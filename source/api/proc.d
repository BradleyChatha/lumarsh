module api.proc;

import lumars, api, std.process, std.typecons, std.format, std.stdio, jcli.text;

struct ShellResult
{
    string output;
    int status;
}

void registerProcApi(LuaState* lua)
{
    lua.registerAndDocument!(
        "execute", doExec!(execute, pipeProcess),
        "executeShell", doExec!(executeShell, pipeShell),
        "executeEnforceZero",  (LuaState* lua, string command, LuaValue[] args) { 
            auto t = doExec!(executeShell, pipeShell)(lua, command, args);
            if(t.status != 0)
                throw new Exception("Command failed with status %s: %s".format(t.status, t.output));
            return t; 
        },
        "userShell", userShell
    )("sh.proc");

    lua.doString(`
        local shmeta = {}

        -- Enable sh:COMMAND shorthand
        function shmeta.__index(_,idx)
            return function(...)
                local args = {...}
                if #args == 0 or args[1] ~= sh then
                    error("Please use sh:NAME syntax instead of sh.NAME syntax when using the sh.proc.execute shorthand")
                end
                table.remove(args, 1)

                local ret = {
                    __lumarsh_pipe_to_stdin = sh.proc.executeEnforceZero(idx, args).output
                }
                ret.output = ret.__lumarsh_pipe_to_stdin
                setmetatable(ret, {
                    __tostring = function(t)
                        return t.output
                    end,

                    __index = function(me,idx)
                        return function(_,...)
                            return sh[idx](sh, me, ...)
                        end
                    end
                })

                return ret
            end
        end

        sh = setmetatable(sh, shmeta)

        function sh.proc.bash(string_or_array)
            if type(string_or_array) == 'string' then
                string_or_array = {string_or_array}
            end

            local results = {}

            for _,v in ipairs(string_or_array) do
                local res = sh:bash('-c', v)
                table.insert(results, res.output)
            end

            return results
        end
    `);
}

private:

ShellResult doExec(alias Func, alias PipeFunc)(LuaState* lua, string command, LuaValue[] args)
{
    import std.conv;
    string[] actualArgs;
    string pipeData;

    void put(LuaValue arg)
    {
        if(arg.isText)
            actualArgs ~= arg.textValue;
        else if(arg.isNumber)
            actualArgs ~= arg.numberValue.to!string;
        else if(arg.isBoolean)
            actualArgs ~= arg.booleanValue.to!string;
        else if(arg.isNil)
            actualArgs ~= "nil";
        else if(arg.isTable)
        {
            auto t = &arg.tableValue();
            t.pushElement("__lumarsh_pipe_to_stdin");
            scope(exit) lua.pop(1);
            if(lua.type(-1) != LuaValue.Kind.nil)
                pipeData = lua.get!string(-1);
            else
            {
                t.pairs!(string, LuaValue, (key, value){
                    if(value.isBoolean)
                    {
                        if(value.booleanValue)
                            actualArgs ~= (key.length == 1 ? "-" : "--")~key;
                        else
                            actualArgs ~= (key.length == 1 ? "-" : "--")~key~"=false";
                    }
                    else
                    {
                        put(value);
                        actualArgs[$-1] = (key.length == 1 ? "-" : "--")~key~"="~actualArgs[$-1];
                    }
                });
            }
        }
        else
            actualArgs ~= "<FUNCTION(probably)>";
    }

    foreach(arg; args)
        put(arg);

    const commString = escapeShellCommand(command~actualArgs);
    if(lua.globalTable.get!LuaTable("sh").get!bool("echo"))
        writeln(commString.ansi.fg(Ansi4BitColour.green));

    if(!pipeData)
    {
        const res = Func(commString);
        if(lua.globalTable.get!LuaTable("sh").get!bool("echo"))
            writeln(res.output);
        return ShellResult(res.output, res.status);
    }
    else
    {
        const addition = escapeShellCommand("echo", pipeData);
        const res = Func(addition~" | "~commString, null, Config(Config.Flags.retainStderr | Config.Flags.retainStdout));
        if(lua.globalTable.get!LuaTable("sh").get!bool("echo"))
            writeln(res.output);
        return ShellResult(res.output, res.status);
    }
}
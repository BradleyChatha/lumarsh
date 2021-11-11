module api.proc;

import lumars, std.process, std.typecons, std.format;

struct ShellResult
{
    string output;
    int status;
}

void registerProcApi(LuaState* lua)
{
    lua.register!(
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
                    put(value);
                    actualArgs ~= key;
                    actualArgs[$-1] = (key.length == 1 ? "-" : "--")~key~"="~actualArgs[$-1];
                });
            }
        }
        else
            actualArgs ~= "<FUNCTION(probably)>";
    }

    foreach(arg; args)
        put(arg);

    const commString = escapeShellCommand(command~actualArgs);

    if(!pipeData)
    {
        const res = Func(commString);
        return ShellResult(res.output, res.status);
    }
    else
    {
        const addition = escapeShellCommand("echo", pipeData);
        const res = Func(addition~" | "~commString, null, Config(Config.Flags.retainStderr | Config.Flags.retainStdout));
        return ShellResult(res.output, res.status);
    }
}
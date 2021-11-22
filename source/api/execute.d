module api.execute;

import lumars, api;

string executeLuaString(string text, string[] args)
{
    auto state = makeState(args);

    try
    {
        state.doString(text);
        return null;
    }
    catch(Exception ex)
    {
        version(release)
            return ex.msg;
        else
            throw ex;
    }
}

string executeLuaFile(string file, string[] args)
{
    auto state = makeState(args);

    try
    {
        state.doFile(file);
        return null;
    }
    catch(Exception ex)
    {
        version(release)
            return ex.msg;
        else
            throw ex;
    }
}

bool g_genDocs;
string g_docs;
package void registerAndDocument(Args...)(LuaState* state, string name)
{
    import std.format, std.traits;

    state.register!Args(name);
    if(!g_genDocs)
        return;

    g_docs ~= "## %s\n\n".format(name);

    static foreach(i; 0..Args.length / 2)
    {{
        const Name = Args[i*2];
        alias Func = Args[i*2+1];
        string args;
        string ret;

        alias RetT = ReturnType!Func;
        static if(is(RetT == LuaValue))
            ret = "any";
        else static if(is(RetT == struct))
        {
            ret ~= "{";
            static foreach(i, member; __traits(allMembers, RetT))
            {
                ret ~= typeof(__traits(getMember, RetT, member)).stringof;
                ret ~= " ";
                ret ~= member;
                
                static if(i != __traits(allMembers, RetT).length-1)
                    ret ~= ", ";
            }
            ret ~= "}";
        }
        else
            ret = RetT.stringof;

        static if(is(typeof(Func) Params == __parameters))
        static foreach(i, param; Params)
        {
            static if(!is(param == LuaState*))
            {
                static if(is(param == LuaValue))
                    args ~= "any";
                else static if(is(param == LuaValue[]))
                    args ~= "any[]";
                else
                    args ~= param.stringof;
                args ~= " "~__traits(identifier, Params[i..i+1]);
                static if(i != Params.length-1)
                    args ~= ", ";
            }
        }

        g_docs ~= "* %s %s(%s)\n".format(ret, Name, args);
    }}

    g_docs ~= "\n\n";
}

LuaState* makeState(string[] args)
{
    import core.stdc.stdlib;
    auto state = cast(LuaState*)calloc(LuaState.sizeof, 1);
    *state = LuaState(null);
    state.registerPathApi();
    state.registerFsApi();
    state.registerProcApi();
    state.registerRegexApi();
    state.registerJsonApi();
    detectLuaRocks(state);
    state.globalTable.set("LUMARSH_ARGS", args);
    state.doString(`sh.echo = true`);
    state.doString(`sh.cd = function() error("'cd' doesn't work, please use sh.fs.chdir") end`);
    state.doString(import("libs/luafun.lua"));

    return state;
}

void detectLuaRocks(LuaState* lua)
{
    import std.process;

    const res = executeShell("luarocks --version");
    if(res.status != 0)
        return;

    lua.globalTable.set("LUA_PATH", executeShell("luarocks path --lua-version 5.1 --lr-path").output);
    lua.globalTable.set("LUA_CPATH", executeShell("luarocks path --lua-version 5.1 --lr-cpath").output);
    lua.doString(`
        package.path = package.path .. ";" .. LUA_PATH
        package.cpath = package.cpath .. ";" .. LUA_CPATH
        require("luarocks.loader")
    `);
}
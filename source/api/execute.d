module api.execute;

import lumars, api;

string executeLuaString(string text)
{
    auto state = makeState();

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

string executeLuaFile(string file)
{
    auto state = makeState();

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

private:

LuaState* makeState()
{
    import core.stdc.stdlib;
    auto state = cast(LuaState*)calloc(LuaState.sizeof, 1);
    *state = LuaState(null);
    state.registerPathApi();
    state.registerFsApi();
    state.registerProcApi();
    detectLuaRocks();

    return state;
}

void detectLuaRocks()
{
    import std.process;

    const res = executeShell("luarocks --version");
    if(res.status != 0)
        return;

    environment["LUA_PATH"] = executeShell("luarocks path --lua-version 5.1 --lr-path").output;
    environment["LUA_CPATH"] = executeShell("luarocks path --lua-version 5.1 --lr-cpath").output;
}
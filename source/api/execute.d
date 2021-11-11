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
    state.registerRegexApi();
    detectLuaRocks(state);

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
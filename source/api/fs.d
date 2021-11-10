module api.fs;

import lumars, std.file, std.exception, std.conv, std.algorithm, std.array;

void registerFsApi(LuaState* lua)
{
    lua.register!(
        "append", (LuaState* l, string file, LuaValue v) {
            enforce(v.isTable || v.isText, "Expected parameter 2 to be a table or a string.");
            if(v.isText)
                append(file, v.textValue);
            else
            {
                auto t = v.tableValue;
                if(t.length == 0)
                    return;
                t.push();
                scope(exit) l.pop(1);
                append(file, l.get!(ubyte[])(-1));
            }
        },
        "chdir",            chdir!string,
        "copy",             (string from, string to)    => copy(from, to),
        "dirEntries",       (string path, string mode)  => dirEntries(path, mode.to!SpanMode).map!(de => de.name).array,
        "dirEntriesGlob",   (string path, string pattern, string mode)  
                                                        => dirEntries(path, pattern, mode.to!SpanMode).map!(de => de.name).array,
        "exists",           exists!string,
        "getSize",          getSize!string,
        "isDir",            isDir!string,
        "isFile",           isFile!string,
        "mkdir",            mkdir!string,
        "mkdirRecurse",     mkdirRecurse,
        "readString",       (string file)               => readText(file),
        "readBytes",        (string str)                => cast(ubyte[])read(str),
        "remove",           std.file.remove!string,
        "rename",           rename!(string, string),
        "rmdir",            rmdir!string,
        "rmDirRecurse",     rmdirRecurse,
        "tempDir",          tempDir,
        "write", (LuaState* l, string file, LuaValue v) {
            enforce(v.isTable || v.isText, "Expected parameter 2 to be a table or a string.");
            if(v.isText)
                write(file, v.textValue);
            else
            {
                auto t = v.tableValue;
                if(t.length == 0)
                    return;
                t.push();
                scope(exit) l.pop(1);
                write(file, l.get!(ubyte[])(-1));
            }
        },

    )("sh.fs");
}
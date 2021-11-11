module commands.default_;

import jcli, api;

@CommandDefault("Executes the given LUA file")
struct DefaultCommand
{
    @ArgPositional("file", "The file to execute")
    string file;

    int onExecute()
    {
        const error = executeLuaFile(this.file);
        if(error)
            throw new Exception("Failed to execute file: "~error);
        else
            return 0;
    }
}
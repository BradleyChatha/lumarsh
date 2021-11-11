module commands.default_;

import jcli, api;

@CommandDefault("Executes the given LUA file")
struct DefaultCommand
{
    @ArgPositional("file", "The file to execute")
    string file;

    @ArgOverflow
    string[] args;

    int onExecute()
    {
        const error = executeLuaFile(this.file, this.args);
        if(error)
            throw new Exception("Failed to execute file: "~error);
        else
            return 0;
    }
}
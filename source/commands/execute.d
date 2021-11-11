module commands.execute;

import jcli, api;

@Command("execute", "Executes the given LUA text")
struct ExecuteCommand
{
    @ArgPositional("command", "The command text to execute")
    string command;

    @ArgOverflow
    string[] args;

    int onExecute()
    {
        const error = executeLuaString(this.command, this.args);
        if(error)
            throw new Exception("Failed to execute string: "~error);
        else
            return 0;
    }
}
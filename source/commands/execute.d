module commands.execute;

import jcli, api;

@Command("execute", "Executes the given LUA text")
struct ExecuteCommand
{
    @ArgPositional("command", "The command text to execute")
    string command;

    int onExecute()
    {
        const error = executeLuaString(this.command);
        if(error)
            throw new Exception("Failed to execute string: "~error);
        else
            return 0;
    }
}
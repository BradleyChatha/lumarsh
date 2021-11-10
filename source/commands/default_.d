module commands.default_;

import jcli, api;

@CommandDefault("Executes the given LUA file")
struct DefaultCommand
{
    void onExecute(){}
}
module api.proc;

import lumars, std.process, std.typecons;

struct ShellResult
{
    string output;
    int status;
}

void registerProcApi(LuaState* lua)
{
    lua.register!(
        "execute", (string command, string[] args) { 
            auto t = execute(escapeShellCommand(command~args)); 
            return ShellResult(t.output, t.status); 
        },
        "executeShell", (string command, string[] args) { 
            auto t = executeShell(escapeShellCommand(command~args)); 
            return ShellResult(t.output, t.status); 
        },
        "userShell", userShell
    )("sh.proc");
}
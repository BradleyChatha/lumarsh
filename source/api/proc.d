module api.proc;

import lumars, std.process, std.typecons, std.format;

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
        "executeEnforceZero",  (string command, string[] args) { 
            auto t = executeShell(escapeShellCommand(command~args));
            if(t.status != 0)
                throw new Exception("Command failed with status %s: %s".format(t.status, t.output));
            return ShellResult(t.output, t.status); 
        },
        "userShell", userShell
    )("sh.proc");
}
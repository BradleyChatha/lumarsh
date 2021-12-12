module commands.docs;

import jcli, api, std;

@Command("docs", "Outputs the API documentation into stdout")
struct DocsCommand
{
    void onExecute()
    {
        g_genDocs = true;
        makeState(null);
        writeln(
            import("libs/luafun_emmy.lua")~'\n'
            ~import("libs/builtin_emmy.lua")~'\n'
            ~g_docs
        );
    }
}
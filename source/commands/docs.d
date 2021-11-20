module commands.docs;

import jcli, api, std;

@Command("docs", "Outputs the API documentation into stdout")
struct DocsCommand
{
    void onExecute()
    {
        g_genDocs = true;
        makeState(null);
        writeln(g_docs);
    }
}
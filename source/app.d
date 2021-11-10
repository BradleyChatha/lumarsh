import jcli, commands;

int main(string[] args)
{
    return (new CommandLineInterface!(commands.COMMANDS)()).parseAndExecute(args);
}

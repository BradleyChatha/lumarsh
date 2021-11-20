module commands;

import std.meta : AliasSeq;

alias COMMANDS = AliasSeq!(
    commands.default_,
    commands.execute,
    commands.docs,
);

public import 
    commands.default_,
    commands.execute,
    commands.docs;
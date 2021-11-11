# Overview

Lumarsh is a small Lua script runner (powered by [Lumars](https://github.com/BradleyChatha/lumars)) with a small
built-in library primarily for use with shell scripts.

## Installation

Either compile it yourself with `dub build -b release` or fetch it from the latest [release](https://github.com/BradleyChatha/lumarsh/releases/latest) page.

e.g.

```bash
curl -i lumarsh -L https://github.com/BradleyChatha/lumarsh/releases/download/v0.1.0/lumarsh
chmod +x lumarsh
mv lumarsh /usr/local/bin
```

## Using Lumarsh

There are two ways to use Lumarash:

* Execute a file `lumarsh file_name`
* Execute a string `lumarsh execute "print('henlo world!')"`

## Library

Lumarsh provides the following libraries:

* [sh.path](./source/api/path.d) - Exposes `std.path` into Lua.
* [sh.proc](./source/api/proc.d) - Exposes `std.process` into Lua.
* [sh.fs](./source/api/fs.d) - Exposes `std.file` into Lua.

I'm very willing to add more into lumarsh, so please tell me any suggestions you may have.

## Execution shorthand syntax

Instead of calling `sh.proc.executeEnforceZero` directly, you can instead use the `sh:COMMAND(ARGS)` shortcut:

```lua
print(sh.proc.executeEnforceZero("echo", {"This is what you'd normally do"}).output)
print(sh:echo("But instead, you can do this!").output)
```

Additionally, you can chain calls together to pass the output of one command into another's stdin:

```lua
-- Conventional way (If you don't specify `.output`, then the command's output is sent to stdin)
print(sh.proc.executeShell("grep", {"import", sh.proc.executeShell("cat", {"./source/api/execute.d"})}).output)

-- Easier way
print(
    sh:cat("./source/api/execute.d")
      :grep("import")
      .output
)
```

Remember, call `.output` on a result object if you don't want it's data being sent to stdin!

```lua
-- Good
print(
    sh:echo("This is my License: ", sh:cat("./LICENSE.md").output).output
)

-- Bad
print(
    sh:echo("This is my License: ", sh:cat("./LICENSE.md")).output
)
```
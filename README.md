# Overview

Lumarsh is a small Lua script runner (powered by [Lumars](https://github.com/BradleyChatha/lumars)) with a small
built-in library primarily for use with shell scripts.

## Installation

Either compile it yourself with `dub build -b release` or fetch it from the latest [release](https://github.com/BradleyChatha/lumarsh/releases/latest) page.

e.g.

```bash
curl -o lumarsh -L https://github.com/BradleyChatha/lumarsh/releases/download/v0.1.7/lumarsh
chmod +x lumarsh
mv lumarsh /usr/local/bin
```

## Using Lumarsh

There are two ways to use Lumarsh:

* Execute a file `lumarsh file_name`
* Execute a string `lumarsh execute "print('henlo world!')"`

Additionally any extra args are directly passed into the script via the `LUMARSH_ARGS` global variable:

```lua
for i,v in ipairs(LUMARSH_ARGS) do
    print(i,v)
end
```

## Library

Lumarsh provides the following libraries:

* [sh.path](./source/api/path.d) - Exposes `std.path` into Lua.
* [sh.proc](./source/api/proc.d) - Exposes `std.process` into Lua.
* [sh.fs](./source/api/fs.d) - Exposes `std.file` into Lua.
* [sh.regex](./source/api/regex.d) - Exposes `std.regex` into Lua.
* [sh.json](./source/api/json.d) - Exposes `std.json` into Lua.

I'm very willing to add more into lumarsh, so please tell me any suggestions you may have.

## Luarocks support

If [luarocks](https://luarocks.org/) can be detected then lumarsh will set the `LUA_PATH` and `LUA_CPATH` variables
to the output of `luarocks path --lua-version 5.1`.

**Please note lumarsh only supports Lua 5.1 as that's the only version lumars supports**

When install packages, make sure to pass `--lua-version 5.1` into luarocks, otherwise it might not be in the correct location.

If you're getting an error such as `cannot find module luarocks.loader`, then try the following command:

```shell
luarocks install luarocks --lua-version 5.1
```

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

## Command echoing

By default lumarsh will echo the output of any command it runs.

To disable this, please set `sh.echo` to false.
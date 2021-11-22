Performing "debug" build using /usr/bin/dmd for x86_64.
jcli:core 0.22.4: target for configuration "library" is up to date.
jcli:introspect 0.22.4: target for configuration "library" is up to date.
jcli:argbinder 0.22.4: target for configuration "library" is up to date.
jcli:argparser 0.22.4: target for configuration "library" is up to date.
jcli:autocomplete 0.22.4: target for configuration "library" is up to date.
jcli:commandparser 0.22.4: target for configuration "library" is up to date.
jcli:text 0.22.4: target for configuration "library" is up to date.
jcli:helptext 0.22.4: target for configuration "library" is up to date.
jcli:resolver 0.22.4: target for configuration "library" is up to date.
jcli 0.22.4: target for configuration "library" is up to date.
bindbc-lua 0.4.1: target for configuration "static" is up to date.
taggedalgebraic 0.11.22: target for configuration "library" is up to date.
lumars 1.0.3: target for configuration "lua51" is up to date.
lumarsh 0.2.0+commit.1.g2fd096f: target for configuration "application" is up to date.
To force a rebuild of up-to-date targets, run again with --force.
Running lumarsh docs
## sh.path

* string absolutePath()
* string absolutePathCwd()
* string buildPath()
* string defaultExtension()
* string dirName()
* string expandTilde()
* string extension()
* string getcwd()
* bool globMatch()
* bool isAbsolute()
* bool isValidFilename()
* bool isValidPath()
* char[] normalisePath()
* string relativePath()
* string relativePathCwd()
* string setExtension()
* string stripExtension()


## sh.fs

* void append()
* void chdir(string pathname)
* void copy()
* string[] dirEntries()
* string[] dirEntriesGlob()
* bool exists(string name)
* ulong getSize(string name)
* bool isDir()
* bool isFile()
* void mkdir(string pathname)
* void mkdirRecurse(const(char)[] pathname)
* string readString()
* ubyte[] readBytes()
* void remove(string name)
* void rename(string from, string to)
* void rmdir(string pathname)
* void rmDirRecurse(const(char)[] pathname)
* string tempDir()
* void write()


## sh.proc

* {string output, int status} execute(string command, any[] args)
* {string output, int status} executeShell(string command, any[] args)
* {string output, int status} executeEnforceZero()
* string userShell()


## sh.regex

* {bool matched, string[] captures} matchFirst()
* RegexResult[] matchAll()
* string[] split()


## sh.json

* any parse(string str)
* string toString(any v)




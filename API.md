## sh.path

* string absolutePath(string, string)
* string absolutePathCwd(string)
* string buildPath(string[])
* string defaultExtension(string, string)
* string dirName(string)
* string expandTilde(string)
* string extension(string)
* string getcwd()
* bool globMatch(string, string)
* bool isAbsolute(string)
* bool isValidFilename(string)
* bool isValidPath(string)
* char[] normalisePath(string)
* string relativePath(string, string)
* string relativePathCwd(string)
* string setExtension(string, string)
* string stripExtension(string)


## sh.fs

* void append(string, any)
* void chdir(string)
* void copy(string, string)
* string[] dirEntries(string, string)
* string[] dirEntriesGlob(string, string, string)
* bool exists(string)
* ulong getSize(string)
* bool isDir(string)
* bool isFile(string)
* void mkdir(string)
* void mkdirRecurse(const(char)[])
* string readString(string)
* ubyte[] readBytes(string)
* void remove(string)
* void rename(string, string)
* void rmdir(string)
* void rmDirRecurse(const(char)[])
* string tempDir()
* void write(string, any)


## sh.proc

* {string output, int status} execute(string, any[])
* {string output, int status} executeShell(string, any[])
* {string output, int status} executeEnforceZero(string, any[])
* string userShell()


## sh.regex

* {bool matched, string[] captures} matchFirst(string, string)
* RegexResult[] matchAll(string, string)
* string[] split(string, string)


## sh.json

* any parse(string)
* string toString(any)




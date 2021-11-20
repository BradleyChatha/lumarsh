module api.path;

import lumars, api, std.path, std.file, std.array;

void registerPathApi(LuaState* lua)
{
    lua.registerAndDocument!(
        "absolutePath",     (string path, string base)  => absolutePath(path, base),
        "absolutePathCwd",  (string path)               => absolutePath(path),
        "buildPath",        (string[] paths)            => buildNormalizedPath(paths),
        "defaultExtension", (string path, string ext)   => defaultExtension(path, ext),
        "dirName",          (string path)               => dirName(path),
        "expandTilde",      (string path)               => expandTilde(path),
        "extension",        (string path)               => extension(path),
        "getcwd",           ()                          => getcwd(),
        "globMatch",        (string path, string patt)  => globMatch(path, patt),
        "isAbsolute",       (string path)               => isAbsolute(path),
        "isValidFilename",  (string filename)           => isValidFilename(filename),
        "isValidPath",      (string path)               => isValidPath(path),
        "normalisePath",    (string path)               => asNormalizedPath(path).array,
        "relativePath",     (string path, string base)  => relativePath(path, base),
        "relativePathCwd",  (string path)               => relativePath(path),
        "setExtension",     (string path, string ext)   => setExtension(path, ext),
        "stripExtension",   (string path)               => stripExtension(path)
    )("sh.path");
}
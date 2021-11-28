sh = sh or {}
sh.path = sh.path or {}
--@type fun(_:string, _:string):string
sh.path.absolutePath = sh.path.absolutePath or function() assert(false, 'not implemented') end
--@type fun(_:string):string
sh.path.absolutePathCwd = sh.path.absolutePathCwd or function() assert(false, 'not implemented') end
--@type fun(_:string[]):string
sh.path.buildPath = sh.path.buildPath or function() assert(false, 'not implemented') end
--@type fun(_:string, _:string):string
sh.path.defaultExtension = sh.path.defaultExtension or function() assert(false, 'not implemented') end
--@type fun(_:string):string
sh.path.dirName = sh.path.dirName or function() assert(false, 'not implemented') end
--@type fun(_:string):string
sh.path.expandTilde = sh.path.expandTilde or function() assert(false, 'not implemented') end
--@type fun(_:string):string
sh.path.extension = sh.path.extension or function() assert(false, 'not implemented') end
--@type fun():string
sh.path.getcwd = sh.path.getcwd or function() assert(false, 'not implemented') end
--@type fun(_:string, _:string):bool
sh.path.globMatch = sh.path.globMatch or function() assert(false, 'not implemented') end
--@type fun(_:string):bool
sh.path.isAbsolute = sh.path.isAbsolute or function() assert(false, 'not implemented') end
--@type fun(_:string):bool
sh.path.isValidFilename = sh.path.isValidFilename or function() assert(false, 'not implemented') end
--@type fun(_:string):bool
sh.path.isValidPath = sh.path.isValidPath or function() assert(false, 'not implemented') end
--@type fun(_:string):dchar[]
sh.path.normalisePath = sh.path.normalisePath or function() assert(false, 'not implemented') end
--@type fun(_:string, _:string):string
sh.path.relativePath = sh.path.relativePath or function() assert(false, 'not implemented') end
--@type fun(_:string):string
sh.path.relativePathCwd = sh.path.relativePathCwd or function() assert(false, 'not implemented') end
--@type fun(_:string, _:string):string
sh.path.setExtension = sh.path.setExtension or function() assert(false, 'not implemented') end
--@type fun(_:string):string
sh.path.stripExtension = sh.path.stripExtension or function() assert(false, 'not implemented') end


sh = sh or {}
sh.fs = sh.fs or {}
--@type fun(_:string, _:any):nil
sh.fs.append = sh.fs.append or function() assert(false, 'not implemented') end
--@type fun(pathname:string):nil
sh.fs.chdir = sh.fs.chdir or function() assert(false, 'not implemented') end
--@type fun(_:string, _:string):nil
sh.fs.copy = sh.fs.copy or function() assert(false, 'not implemented') end
--@type fun(_:string, _:string):string[]
sh.fs.dirEntries = sh.fs.dirEntries or function() assert(false, 'not implemented') end
--@type fun(_:string, _:string, _:string):string[]
sh.fs.dirEntriesGlob = sh.fs.dirEntriesGlob or function() assert(false, 'not implemented') end
--@type fun(name:string):bool
sh.fs.exists = sh.fs.exists or function() assert(false, 'not implemented') end
--@type fun(name:string):number
sh.fs.getSize = sh.fs.getSize or function() assert(false, 'not implemented') end
--@type fun(name:string):bool
sh.fs.isDir = sh.fs.isDir or function() assert(false, 'not implemented') end
--@type fun(name:string):bool
sh.fs.isFile = sh.fs.isFile or function() assert(false, 'not implemented') end
--@type fun(pathname:string):nil
sh.fs.mkdir = sh.fs.mkdir or function() assert(false, 'not implemented') end
--@type fun(pathname:dchar[]):nil
sh.fs.mkdirRecurse = sh.fs.mkdirRecurse or function() assert(false, 'not implemented') end
--@type fun(_:string):string
sh.fs.readString = sh.fs.readString or function() assert(false, 'not implemented') end
--@type fun(_:string):number[]
sh.fs.readBytes = sh.fs.readBytes or function() assert(false, 'not implemented') end
--@type fun(name:string):nil
sh.fs.remove = sh.fs.remove or function() assert(false, 'not implemented') end
--@type fun(from:string, to:string):nil
sh.fs.rename = sh.fs.rename or function() assert(false, 'not implemented') end
--@type fun(pathname:string):nil
sh.fs.rmdir = sh.fs.rmdir or function() assert(false, 'not implemented') end
--@type fun(pathname:dchar[]):nil
sh.fs.rmDirRecurse = sh.fs.rmDirRecurse or function() assert(false, 'not implemented') end
--@type fun():string
sh.fs.tempDir = sh.fs.tempDir or function() assert(false, 'not implemented') end
--@type fun(_:string, _:any):nil
sh.fs.write = sh.fs.write or function() assert(false, 'not implemented') end


sh = sh or {}
sh.proc = sh.proc or {}
---@class ShellResult
---@field public output string
---@field public status number
local ShellResult
--@type fun(command:string, args:any[]):ShellResult
sh.proc.execute = sh.proc.execute or function() assert(false, 'not implemented') end
--@type fun(command:string, args:any[]):ShellResult
sh.proc.executeShell = sh.proc.executeShell or function() assert(false, 'not implemented') end
--@type fun(_:string, _:any[]):ShellResult
sh.proc.executeEnforceZero = sh.proc.executeEnforceZero or function() assert(false, 'not implemented') end
--@type fun():string
sh.proc.userShell = sh.proc.userShell or function() assert(false, 'not implemented') end


sh = sh or {}
sh.regex = sh.regex or {}
---@class RegexResult
---@field public matched bool
---@field public captures string[]
local RegexResult
--@type fun(_:string, _:string):RegexResult
sh.regex.matchFirst = sh.regex.matchFirst or function() assert(false, 'not implemented') end
--@type fun(_:string, _:string):RegexResult[]
sh.regex.matchAll = sh.regex.matchAll or function() assert(false, 'not implemented') end
--@type fun(_:string, _:string):string[]
sh.regex.split = sh.regex.split or function() assert(false, 'not implemented') end


sh = sh or {}
sh.json = sh.json or {}
--@type fun(str:string):any
sh.json.parse = sh.json.parse or function() assert(false, 'not implemented') end
--@type fun(v:any):string
sh.json.toString = sh.json.toString or function() assert(false, 'not implemented') end




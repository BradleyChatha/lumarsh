---@diagnostic disable: lowercase-global

--- Make gen, param, state iterator from the iterable object. The function is a generalized version of pairs() and ipairs().
---
--- The function distinguish between arrays and maps using #arg == 0 check to detect maps. For arrays ipairs is used. For maps a modified version of pairs is used that also returns keys. Userdata objects are handled in the same way as tables.
---@generic Param, State, Key, Value
---@type fun(iter_type:Value[]|table<Key,Value>|string):fun(p:Param, s:State):any,Param,State
iter = iter or nil

--- Applies the given predicate to each element returned by the iterator.
---@generic Iter, IterV
---@type fun(pred:fun(v:IterV), iter:Iter)
each = each or nil
for_each = each
foreach_ = for_each

--- Creates an iterator that iterators between start and stop(inclusive), with a given step.
---
--- Note that you can call this function with a single number, which equates to `range(0, STOP, 1)`
---@generic Param, State
---@type fun(start:number, stop:number, step:number):fun(p:Param, s:State):number,Param,State
range = range or nil

--- The iterator returns values over and over again indefinitely. All values that passed to the iterator are returned as-is during the iteration.
---@generic Param, State
---@type fun(...):fun(p:Param, s:State):any,Param,State
---@vararg any
duplicate = duplicate or nil
xrepeat = duplicate
replicate = duplicate

--- The iterator that returns fun(0), fun(1), fun(2), ... values indefinitely.
---@generic Param, State, Ret
---@type fun(f:fun(n:number):Ret):fun(p:Param, s:State):Ret,Param,State
tabulate = tabulate or nil

--- The iterator returns 0 indefinitely
---@generic Param, State
---@type fun():fun(p:Param, s:State):number,Param,State
zeros = zeros or nil

--- The iterator returns 1 indefinitely
---@generic Param, State
---@type fun():fun(p:Param, s:State):number,Param,State
ones = ones or nil

--- This function returns the n-th element of `gen, param, state` iterator. If the iterator does not have n items then `nil` is returned.
---@generic Param, State, Ret
---@type fun(n:number, gen:fun(Param, State), param:Param, state:State):Ret
nth = nth or nil

--- Extract the first element of gen, param, state iterator. If the iterator is empty then an error is raised.
---@generic Param, State, Ret
---@type fun(gen:fun(Param, State), param:Param, state:State):Ret
head = head or nil
car = head

--- Return a copy of `gen, param, state` iterator without its first element. If the iterator is empty then an empty iterator is returned.
---@generic Param, State, Ret
---@type fun(gen, param:Param, state:State):fun(Param, State):Ret,Param,State
tail = tail or nil
cdr = tail

--- Returns an iterator that produces the first 'n' values of the child iterator.
---@generic Param, State, Ret
---@type fun(n:number, gen:fun(Param, State), param:Param, state:State):fun(Param, State):Ret,Param,State
take_n = take_n or nil

--- Returns an iterator that produces the longest prefix of the child iterator as long as the given predicate passes.
---@generic Param, State, Ret
---@type fun(pred:fun(value:Ret), gen:fun(Param, State), param:Param, state:State):fun(Param, State):Ret,Param,State
take_while = take_while or nil

--- Returns an iterator that produces the subsequence of the child iterator after 'n' values have been consumed.
---@generic Param, State, Ret
---@type fun(n:number, gen:fun(Param, State), param:Param, state:State):fun(Param, State):Ret,Param,State
drop_n = drop_n or nil

--- Returns an iterator that skips the longest prefix of the child iterator that passes the given predicate.
---@generic Param, State, Ret
---@type fun(pred:fun(value:Ret), gen:fun(Param, State), param:Param, state:State):fun(Param, State):Ret,Param,State
drop_while = drop_while or nil

--- Return an iterator pair where the first operates on the longest prefix (possibly empty) of `gen, param, state` iterator of elements that satisfy predicate and second operates the remainder of `gen, param, state` iterator
---@generic Param, State, Ret
---@type fun(n_or_pred:fun(value:Ret)|number, gen:fun(Param, State), param:Param, state:State):fun(Param, State):Ret,Param,State,fun(Param, State):Ret,Param,State
span = span or nil
split_at = span
split = split_at

--- The function returns the position of the first element in the given iterator which is equal (using ==) to the query element, or nil if there is no such element.
---@generic Param, State
---@type fun(x:any, gen:fun(Param, State), param:Param, state:State):number|nil
index = index or nil
index_of = index
elem_index = index

--- The function returns an iterator to positions of elements which equals to the query element.
---@generic Param, State
---@type fun(x:any, gen:fun(Param, State), param:Param, state:State):number|nil
indexes = indexes or nil
indicies = indexes
elem_indicies = indexes
elem_indexes = indexes

--- Return a new iterator of those elements that satisfy the predicate.
---@generic Param, State
---@type fun(pred:fun(value:any), gen:fun(Param, State), param:Param, state:State):fun(Param, State),Param,State
filter = filter or nil
remove_if = filter

--- If regexp_or_predicate is string then the parameter is used as a regular expression to build filtering predicate. Otherwise the function is just an alias for filter().
---@generic Param, State
---@type fun(regexp_or_pred:fun(value:any)|string, gen:fun(Param, State), param:Param, state:State):fun(Param, State),Param,State
grep = grep or nil

--- The function returns two iterators where elements do and do not satisfy the prediucate.
---@generic Param, State, Ret
---@type fun(pred:fun(value:Ret), gen:fun(Param, State), param:Param, state:State):fun(Param, State):Ret,Param,State,fun(Param, State):Ret,Param,State
partition = partition or nil

--- The function reduces the iterator from left to right using the binary operator accfun and the initial value initval.
---@generic Param, State, Value
---@type fun(accfun:fun(value:Value), initValue:Value, gen:fun(Param, State), param:Param, state:State):Value
foldl = foldl or nil
reduce = foldl

--- Return a number of elements in `gen, param, state` iterator. This function is equivalent to #obj for basic array and string iterators.
---@generic Param, State
---@type fun(gen:fun(Param, State), param:Param, state:State):number
length = length or nil

--- The function reduces the iterator from left to right using table.insert.
---@generic Param, State
---@type fun(gen:fun(Param, State), param:Param, state:State):any[]
totable = totable or nil

--- The function reduces the iterator from left to right using tab[val1] = val2 expression.
---@generic Param, State
---@type fun(gen:fun(Param, State), param:Param, state:State):table<any,any>
totable = totable or nil

--- The function takes two iterators and returns true if the first iterator is a prefix of the second
---@generic Param, State
---@type fun(gen1:fun(Param, State), param1:Param, state1:State, gen2:fun(Param, State), param2:Param, state2:State):boolean
is_prefix_of = is_prefix_of or nil

--- true when gen, param, state` iterator is empty or finished.
---@generic Param, State
---@type fun(gen1:fun(Param, State), param1:Param, state1:State):boolean
is_null = is_null or nil

--- true if all return values of iterator satisfy the predicate
---@generic Param, State
---@type fun(pred:fun(value:any), gen1:fun(Param, State), param1:Param, state1:State):boolean
all = all or nil
every = all

--- Returns true if at least one return values of iterator satisfy the predicate. The iteration stops on the first such value. Therefore, infinity iterators that have at least one satisfying value might work.
---@generic Param, State
---@type fun(pred:fun(value:any), gen1:fun(Param, State), param1:Param, state1:State):boolean
any = any or nil
some = any

--- Return a new iterator by applying the fun to each element of `gen, param, state` iterator. The mapping is performed on the fly and no values are buffered.
---@generic Param, State
---@type fun(pred:fun(value:any), gen1:fun(Param, State), param1:Param, state1:State):fun(Param, State),Param,State
map = map or nil

--- Return a new iterator by enumerating all elements of the gen, param, state iterator starting from 1. The mapping is performed on the fly and no values are buffered.
---@generic Param, State
---@type fun(gen1:fun(Param, State), param1:Param, state1:State):fun(Param, State),Param,State
enumerate = enumerate or nil

---@diagnostic disable: lowercase-global
sh = sh or {}
sh.proc = sh.proc or {}

---@type fun(string_or_array:string|string[]):string[]
sh.proc.bash = sh.proc.bash or nil
sh = sh or {}
sh.path = sh.path or {}
---@type fun(param0:string, param1:string):string
sh.path.absolutePath = sh.path.absolutePath or function() assert(false, 'not implemented') end
---@type fun(param0:string):string
sh.path.absolutePathCwd = sh.path.absolutePathCwd or function() assert(false, 'not implemented') end
---@type fun(param0:string[]):string
sh.path.buildPath = sh.path.buildPath or function() assert(false, 'not implemented') end
---@type fun(param0:string, param1:string):string
sh.path.defaultExtension = sh.path.defaultExtension or function() assert(false, 'not implemented') end
---@type fun(param0:string):string
sh.path.dirName = sh.path.dirName or function() assert(false, 'not implemented') end
---@type fun(param0:string):string
sh.path.expandTilde = sh.path.expandTilde or function() assert(false, 'not implemented') end
---@type fun(param0:string):string
sh.path.extension = sh.path.extension or function() assert(false, 'not implemented') end
---@type fun():string
sh.path.getcwd = sh.path.getcwd or function() assert(false, 'not implemented') end
---@type fun(param0:string, param1:string):bool
sh.path.globMatch = sh.path.globMatch or function() assert(false, 'not implemented') end
---@type fun(param0:string):bool
sh.path.isAbsolute = sh.path.isAbsolute or function() assert(false, 'not implemented') end
---@type fun(param0:string):bool
sh.path.isValidFilename = sh.path.isValidFilename or function() assert(false, 'not implemented') end
---@type fun(param0:string):bool
sh.path.isValidPath = sh.path.isValidPath or function() assert(false, 'not implemented') end
---@type fun(param0:string):dchar[]
sh.path.normalisePath = sh.path.normalisePath or function() assert(false, 'not implemented') end
---@type fun(param0:string, param1:string):string
sh.path.relativePath = sh.path.relativePath or function() assert(false, 'not implemented') end
---@type fun(param0:string):string
sh.path.relativePathCwd = sh.path.relativePathCwd or function() assert(false, 'not implemented') end
---@type fun(param0:string, param1:string):string
sh.path.setExtension = sh.path.setExtension or function() assert(false, 'not implemented') end
---@type fun(param0:string):string
sh.path.stripExtension = sh.path.stripExtension or function() assert(false, 'not implemented') end


sh = sh or {}
sh.fs = sh.fs or {}
---@type fun(param1:string, param2:any):nil
sh.fs.append = sh.fs.append or function() assert(false, 'not implemented') end
---@type fun(pathname:string):nil
sh.fs.chdir = sh.fs.chdir or function() assert(false, 'not implemented') end
---@type fun(param0:string, param1:string):nil
sh.fs.copy = sh.fs.copy or function() assert(false, 'not implemented') end
---@type fun(param0:string, param1:string):string[]
sh.fs.dirEntries = sh.fs.dirEntries or function() assert(false, 'not implemented') end
---@type fun(param0:string, param1:string, param2:string):string[]
sh.fs.dirEntriesGlob = sh.fs.dirEntriesGlob or function() assert(false, 'not implemented') end
---@type fun(name:string):bool
sh.fs.exists = sh.fs.exists or function() assert(false, 'not implemented') end
---@type fun(name:string):number
sh.fs.getSize = sh.fs.getSize or function() assert(false, 'not implemented') end
---@type fun(name:string):bool
sh.fs.isDir = sh.fs.isDir or function() assert(false, 'not implemented') end
---@type fun(name:string):bool
sh.fs.isFile = sh.fs.isFile or function() assert(false, 'not implemented') end
---@type fun(pathname:string):nil
sh.fs.mkdir = sh.fs.mkdir or function() assert(false, 'not implemented') end
---@type fun(pathname:dchar[]):nil
sh.fs.mkdirRecurse = sh.fs.mkdirRecurse or function() assert(false, 'not implemented') end
---@type fun(param0:string):string
sh.fs.readString = sh.fs.readString or function() assert(false, 'not implemented') end
---@type fun(param0:string):number[]
sh.fs.readBytes = sh.fs.readBytes or function() assert(false, 'not implemented') end
---@type fun(name:string):nil
sh.fs.remove = sh.fs.remove or function() assert(false, 'not implemented') end
---@type fun(from:string, to:string):nil
sh.fs.rename = sh.fs.rename or function() assert(false, 'not implemented') end
---@type fun(pathname:string):nil
sh.fs.rmdir = sh.fs.rmdir or function() assert(false, 'not implemented') end
---@type fun(pathname:dchar[]):nil
sh.fs.rmDirRecurse = sh.fs.rmDirRecurse or function() assert(false, 'not implemented') end
---@type fun():string
sh.fs.tempDir = sh.fs.tempDir or function() assert(false, 'not implemented') end
---@type fun(param1:string, param2:any):nil
sh.fs.write = sh.fs.write or function() assert(false, 'not implemented') end


sh = sh or {}
sh.proc = sh.proc or {}
---@class ShellResult
---@field public output string
---@field public status number
local ShellResult
---@type fun(command:string, args:any[]):ShellResult
sh.proc.execute = sh.proc.execute or function() assert(false, 'not implemented') end
---@type fun(command:string, args:any[]):ShellResult
sh.proc.executeShell = sh.proc.executeShell or function() assert(false, 'not implemented') end
---@type fun(param1:string, param2:any[]):ShellResult
sh.proc.executeEnforceZero = sh.proc.executeEnforceZero or function() assert(false, 'not implemented') end
---@type fun():string
sh.proc.userShell = sh.proc.userShell or function() assert(false, 'not implemented') end


sh = sh or {}
sh.regex = sh.regex or {}
---@class RegexResult
---@field public matched bool
---@field public captures string[]
local RegexResult
---@type fun(param0:string, param1:string):RegexResult
sh.regex.matchFirst = sh.regex.matchFirst or function() assert(false, 'not implemented') end
---@type fun(param0:string, param1:string):RegexResult[]
sh.regex.matchAll = sh.regex.matchAll or function() assert(false, 'not implemented') end
---@type fun(param0:string, param1:string):string[]
sh.regex.split = sh.regex.split or function() assert(false, 'not implemented') end


sh = sh or {}
sh.json = sh.json or {}
---@type fun(str:string):any
sh.json.parse = sh.json.parse or function() assert(false, 'not implemented') end
---@type fun(v:any):string
sh.json.toString = sh.json.toString or function() assert(false, 'not implemented') end




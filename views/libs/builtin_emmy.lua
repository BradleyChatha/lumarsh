---@diagnostic disable: lowercase-global
sh = sh or {}
sh.proc = sh.proc or {}

---@type fun(string_or_array:string|string[]):string[]
sh.proc.bash = sh.proc.bash or nil
module api.regex;

import lumars, std.regex;

void registerRegexApi(LuaState* lua)
{
    lua.register!(
        "matchFirst", (string input, string pattern)
        {
            RegexResult ret;
            auto res = matchFirst(input, regex(pattern));
            ret.matched = !!res;

            foreach(cap; res)
                ret.captures ~= cap;

            return ret;
        },
        "matchAll", (string input, string pattern)
        {
            RegexResult[] ret;
            auto res = matchAll(input, regex(pattern));

            foreach(cap; res)
            {
                RegexResult result;
                result.matched = !!cap;
                foreach(hit; cap.captures)
                    result.captures ~= hit;
                ret ~= result;
            }

            return ret;
        },
        "split", (string input, string pattern) => split(input, regex(pattern))
    )("sh.regex");
}

private:

struct RegexResult
{
    bool matched;
    string[] captures;
}
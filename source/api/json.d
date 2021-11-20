module api.json;

import lumars, api, std.json, std.array;

void registerJsonApi(LuaState* lua)
{
    lua.registerAndDocument!(
        "parse", parse,
        "toString", toString
    )("sh.json");
}

private:

LuaValue parse(LuaState* lua, string str)
{
    auto json = parseJSON(str);
    return fromAny(lua, json);
}

LuaTable fromObject(LuaState* lua, JSONValue json)
{
    auto ret = LuaTable.makeNew(lua);

    foreach(k, v; json.object)
        ret.set(k, fromAny(lua, v));

    return ret;
}

LuaTable fromArray(LuaState* lua, JSONValue json)
{
    auto ret = LuaTable.makeNew(lua);

    foreach(i, v; json.array)
        ret.set(i+1, fromAny(lua, v));

    return ret;
}

LuaValue fromValue(JSONValue json)
{
    switch(json.type) with(JSONType)
    {
        case null_: return LuaValue(LuaNil());
        case string: return LuaValue(json.str);
        case integer: return LuaValue(json.integer);
        case uinteger: return LuaValue(json.uinteger);
        case float_: return LuaValue(json.floating);
        case true_: return LuaValue(true);
        case false_: return LuaValue(false);
        default: assert(false);
    }
}

LuaValue fromAny(LuaState* lua, JSONValue json)
{
    if(json.type == JSONType.array)
        return LuaValue(fromArray(lua, json));
    else if(json.type == JSONType.object)
        return LuaValue(fromObject(lua, json));
    else
        return fromValue(json);
}

string toString(LuaValue v)
{
    import std.exception : assumeUnique;
    Appender!(char[]) ret;

    toString(ret, v);

    return ret.data.assumeUnique;
}

void toString(ref Appender!(char[]) ret, LuaValue v)
{
    import std.conv : to;

    final switch(v.kind) with(LuaValue.Kind)
    {
        case nil: ret.put("null"); break;
        case number: ret.put(v.numberValue.to!string); break;
        case text: ret.put('"'~v.textValue~'"'); break;
        case boolean: ret.put(v.booleanValue.to!string); break;
        case table: toString(ret, v.tableValue); break;

        case func:
        case userData:
            break;

        case textWeak:
        case tableWeak:
        case funcWeak:
            assert(false);
    }
}

void toString(ref Appender!(char[]) ret, LuaTable v)
{
    bool isArray;
    bool isObject;

    v.pairs!((i,v) { if(i.isNumber) isArray = true; else isObject = true; });
    if(isArray && isObject)
        throw new Exception("Table has numeric and non-numeric keys, cannot convert into JSON.");
    if(!isArray && !isObject)
    {
        ret.put("null");
        return;
    }

    bool isFirst = true;
    if(isArray)
    {
        ret.put('[');
        v.pairs!((i, v) {
            if(!isFirst)
                ret.put(", ");
            toString(ret, v);
            isFirst = false;
        });
        ret.put(']');
    }
    else
    {
        ret.put('{');
        v.pairs!(string, LuaValue, (i, v) {
            if(!isFirst)
                ret.put(", ");
            ret.put("\"");
            ret.put(i);
            ret.put("\": ");
            toString(ret, v);
            isFirst = false;
        });
        ret.put('}');
    }
}
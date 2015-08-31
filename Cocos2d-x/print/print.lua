function serialize(t)
    local mark={}
    local assign={}
    local function tb(len)
        local ret = ''
        while len > 1 do
            ret = ret .. '       '
            len = len - 1
        end
        if len >= 1 then
            ret = ret .. '├┄┄'
        end
        return ret
    end
    
    local function table2str(t, parent, deep)
        deep = deep or 0
        mark[t] = parent
        local ret = {}
        table.foreach(t, function(f, v)
            local k = type(f)=="number" and "["..f.."]" or tostring(f)
            local dotkey = parent..(type(f)=="number" and k or "."..k)
            local t = type(v)
            if t == "userdata" or t == "function" or t == "thread" or t == "proto" or t == "upval" then
                table.insert(ret, string.format("%s=%q", k, tostring(v)))
            elseif t == "table" then
                if mark[v] then
                    table.insert(assign, dotkey.."="..mark[v])
                else
                    table.insert(ret, string.format("%s=%s", k, table2str(v, dotkey, deep + 1)))
                end
            elseif t == "string" then
                table.insert(ret, string.format("%s=%q", k, v))
            elseif t == "number" then
                if v == math.huge then
                    table.insert(ret, string.format("%s=%s", k, "math.huge"))
                elseif v == -math.huge then
                    table.insert(ret, string.format("%s=%s", k, "-math.huge"))
                else
                    table.insert(ret, string.format("%s=%s", k, tostring(v)))
                end
            else
                table.insert(ret, string.format("%s=%s", k, tostring(v)))
            end
        end)
        return "{\n" .. tb(deep + 1) .. table.concat(ret,",\n" .. tb(deep + 1)) .. '\n' .. tb(deep) .."}"
    end

    if type(t) == "table" then
        if t.__tostring then 
            return tostring(t)
        end
        local str = string.format("%s%s",  table2str(t,"_"), table.concat(assign," "))
        return "<<table>>" .. str
    else
        return tostring(t)
    end
end

if DEBUG == 0 then
  print = function ( ... )
  end
else
    print_ = release_print
    function print(...)
        local arg = {...}
        local ret = ''
        for k, v in pairs(arg) do
            local str = serialize(v)
            ret = ret .. '   ' .. str
        end
        print_(ret)
    end
end
local co = coroutine

local t = co.create(function()
    co.yield('ss')
end)

local a, b = co.resume(t)
P(b)

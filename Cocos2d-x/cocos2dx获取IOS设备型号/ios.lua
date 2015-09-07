local dev = {}

dev.model = "unknown"

local app = cc.Application:getInstance()
local target = app:getTargetPlatform()

if target == cc.PLATFORM_OS_IPHONE or target == cc.PLATFORM_OS_IPAD then
    local director = cc.Director:getInstance()
    local view = director:getOpenGLView()
    local framesize = view:getFrameSize()
    local w, h = framesize.width, framesize.height
    if w == 640 and h == 960 then
        dev.model = "iphone 4"
    elseif w == 640 and h == 1136 then
        dev.model = "iphone 5"
    elseif w == 750 and h == 1334 then
        dev.model = "iphone 6"
    elseif w == 1242 and h == 2208 then
        dev.model = "iphone 6 plus"
    elseif w == 768 and h == 1024 then
        dev.model = "ipad"
    elseif w == 1536 and h == 2048 then
        dev.model = "ipad retina"
    end

end

print("当前设备: ", dev.model)
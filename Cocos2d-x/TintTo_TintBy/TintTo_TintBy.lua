local debugScene = class("debugScene", cc.load("mvc").ViewBase)

function debugScene:onCreate()
	self:createLayer()

	self:TintToAndTintBy()
end

function debugScene:TintToAndTintBy()
	--[[
		cc.TintBy
		调整Node对象的RGB值
	]]
	local sp1 = cc.Sprite:create("btn_k.png")
	sp1:setPosition(cc.p(300, display.height/2))
	self.layer:addChild(sp1)

	local by = cc.TintBy:create(2, -127, -255, -127)
	local back = by:reverse()
	local act = cc.Sequence:create(by, back)
	sp1:runAction(act)

	--[[
		cc.TintTo
		调整Node对象的RGB值到某一个RGB值
		cc.TintTo 不能使用 reverse() 方法
	]]
	local sp2 = cc.Sprite:create("btn_k.png")
	sp2:setPosition(cc.p(600, display.height/2))
	self.layer:addChild(sp2)

	local to = cc.TintTo:create(4, 0, 255, 0)
	sp:runAction(to)
end

function debugScene:createLayer()
	self.layer = cc.LayerColor:create(cc.c4b(120, 120, 120, 255), display.width, display.height)
	self:addChild(self.layer)
end

return debugScene

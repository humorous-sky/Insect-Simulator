-- @ScriptType: LocalScript
local plr : Player = script.Parent.Parent.Parent.Parent.Parent

while not plr.Character do wait() end

local humanoid : Humanoid = plr.Character:WaitForChild("Humanoid")

while not humanoid:GetAttribute("Hunger") do wait() end

humanoid:GetAttributeChangedSignal("Hunger"):Connect(function()
	local hunger = humanoid:GetAttribute("Hunger")
	if hunger < 0 then
		hunger = 0
	end
	script.Parent.bar.Size = UDim2.new(0,(hunger/humanoid:GetAttribute("MaxHunger") * script.Parent.Size.Width.Offset), 0, script.Parent.bar.Size.Height.Offset)
end)

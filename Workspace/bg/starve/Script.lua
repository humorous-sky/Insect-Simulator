-- @ScriptType: Script
function starve(callback, humanoid : Humanoid, hunger, damage : boolean)
	local val = humanoid:GetAttribute("Hunger") - hunger
	if val < 0 then
		if damage then
			humanoid:TakeDamage(-val/10)
		end
		val = 0
	end
	if val > humanoid:GetAttribute("MaxHunger") then
		val = humanoid:GetAttribute("MaxHunger")
	end
	humanoid:SetAttribute("Hunger", val)
end
script.Parent.OnServerEvent:Connect(starve)
script.Parent.server.Event:Connect(function(h, d)
	starve(nil, h, d)
end)

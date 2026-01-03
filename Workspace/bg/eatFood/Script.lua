-- @ScriptType: Script
function remove(callback, part, hunger, cont)
	local val = part:GetAttribute("Leftover") - hunger
	if val <= 0 then	
		val = 0
		part.ProximityPrompt.Enabled = false
		part.CanCollide = false	
	else 
		part.ProximityPrompt.Enabled = true
		part.CanCollide = part:GetAttribute("Collision")
	end
	if val > part:GetAttribute("Supply") then
		val = part:GetAttribute("Supply")
	end
	part:SetAttribute("Leftover", val)
	
	part.ParticleEmitter.Enabled = cont
	
	if val == 0 then
		part.Transparency = 1
	else
		part.Transparency = 0.5 - 0.5 * (part:GetAttribute("Leftover")/part:GetAttribute("Supply"))
	end
	
	
end
script.Parent.OnServerEvent:Connect(remove)
script.Parent.server.Event:Connect(function(h, d, c)
	remove(nil, h, d, c)
end)

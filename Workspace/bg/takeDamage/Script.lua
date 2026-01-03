-- @ScriptType: Script
function damage(callback, humanoid : Humanoid, health)
	humanoid:TakeDamage(health)
	if humanoid.Health > humanoid.MaxHealth then
		humanoid.Health = humanoid.MaxHealth
	end
end
script.Parent.OnServerEvent:Connect(damage)
script.Parent.server.Event:Connect(function(h, d)
	damage(nil, h, d)
end)

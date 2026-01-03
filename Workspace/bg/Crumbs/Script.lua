-- @ScriptType: Script
rs = game:GetService("RunService")
rs.Heartbeat:Connect(function(dt)
	for _,v in pairs(script.Parent:GetChildren()) do
		if v:IsA("BasePart") then
			workspace["bg"].eatFood.server:Fire(v, dt * 0.5, false)
		end
	end
end)


-- @ScriptType: Script
prev = 0
game.Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
	if (prev <= 10 and game.Lighting.ClockTime >= 10) or (prev <= 16 and game.Lighting.ClockTime >= 16) then
		script.Parent.Sound:Play()
		script.Parent.Smoke.Enabled = true
		script.Parent.Parent.Pipe.ParticleEmitter.Enabled = true
	elseif (prev <= 12 and game.Lighting.ClockTime >= 12) or (prev <= 18 and game.Lighting.ClockTime >= 18) then
		script.Parent.Sound:Pause()
		script.Parent.Smoke.Enabled = false
		script.Parent.Parent.Pipe.ParticleEmitter.Enabled = false
	end
	prev = game.Lighting.ClockTime
end)

script.Parent.Touched:Connect(function(hit : BasePart)
	if hit.Parent.Parent:FindFirstChild("Humanoid") and script.Parent.Smoke.Enabled then--and not hit:FindFirstChild("BodyVelocity") then
		
		local theta = math.random(0, 2 * math.pi)
		
		local force = math.random(100, 150)
		
		workspace["bg"].addVelocity.server:Fire(hit.Parent.Parent:WaitForChild("HumanoidRootPart"), "SprinklerVelocity>", Vector3.new(math.sin(theta) * force, force, math.cos(theta) * force), Vector3.new(500, 1000, 500))
		
		task.wait(0.05)
		
		workspace["bg"].addVelocity.server:Fire(hit.Parent.Parent:WaitForChild("HumanoidRootPart"), "SprinklerVelocity>", nil, nil)
	end
end)
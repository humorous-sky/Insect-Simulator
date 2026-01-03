-- @ScriptType: LocalScript
local f : BindableFunction = game.Players.LocalPlayer.PlayerGui.ScreenGui.addEffect
print(script.Name.." starting")

h = script.Parent:WaitForChild("Humanoid", math.huge)
h.StateChanged:Connect(function(old, new)

	if new == Enum.HumanoidStateType.Swimming or old == Enum.HumanoidStateType.Swimming then
		workspace["Map>"].takeDamage:FireServer(h, math.huge)
	end
	
	
end)


h:GetPropertyChangedSignal("MoveDirection"):Connect(function()
	if h.MoveDirection.Magnitude > 0 and not(f.Parent.Effects:FindFirstChild("Gliding") or f.Parent.Effects:FindFirstChild("Flying"))then		
		f:Invoke(game.Players.LocalPlayer, "Walking")
	end
end)

h:GetAttributeChangedSignal("Hunger"):Connect(function()
	if h:GetAttribute("Hunger") >= h:GetAttribute("MaxHunger") * 0.8 then
		f:Invoke(game.Players.LocalPlayer, "Full")
		
	elseif h:GetAttribute("Hunger") <= 0 then
		f:Invoke(game.Players.LocalPlayer, "Starving")
		
	end
	
end)

h:GetPropertyChangedSignal("FloorMaterial"):Connect(function()
	if h.FloorMaterial == Enum.Material.Snow then
		f:Invoke(game.Players.LocalPlayer, "Freezing")
		
	end
end)

local part : Part = h.Parent:WaitForChild("HumanoidRootPart")

local RunService = game:GetService("RunService")

local lastJump = tick() 

RunService.Heartbeat:Connect(function(deltaTime)
	if part.AssemblyLinearVelocity.Y <= h:GetAttribute("FallVelocity") and not(part.Anchored) then
		local e = game.ReplicatedStorage.Effects.Flying:Clone()
		e:SetAttribute("Velocity", h:GetAttribute("FallVelocity"))
		f:Invoke(game.Players.LocalPlayer, e)
	end
end)


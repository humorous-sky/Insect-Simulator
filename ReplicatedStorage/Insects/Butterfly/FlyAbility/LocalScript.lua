-- @ScriptType: LocalScript
local UIS = game:GetService("UserInputService")
local rs = game:GetService("RunService")


while not game.Players.LocalPlayer.Character do task.wait() end

local h : Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")


function startFlying()
	if script.Parent.Parent.Effects:FindFirstChild("Flying") then
		script.Parent.Parent.Effects.Flying:SetAttribute("Velocity", h:GetAttribute("RiseVelocity"))
		
	else
		local e = game.ReplicatedStorage.Effects.Flying:Clone()
		e:SetAttribute("Velocity", h:GetAttribute("RiseVelocity"))
		script.Parent.Parent.addEffect:Invoke(game.Players.LocalPlayer, e)
	end
end

function stopFlying()
	if script.Parent.Parent.Effects:FindFirstChild("Flying") then
		script.Parent.Parent.Effects.Flying:SetAttribute("Velocity", h:GetAttribute("FallVelocity"))
	end
end

script.Parent:WaitForChild("TextButton").MouseButton1Down:Connect(startFlying)

script.Parent:WaitForChild("TextButton").MouseButton1Up:Connect(stopFlying)

script.Parent:WaitForChild("TextButton").MouseLeave:Connect(stopFlying)

UIS.InputBegan:Connect(function(input, Chatting)
	if Chatting then return end 
	if input.KeyCode == Enum.KeyCode.Q then
		startFlying()
	end
end)

UIS.InputEnded:Connect(function(input, Chatting)
	if Chatting then return end 
	if input.KeyCode == Enum.KeyCode.Q then
		stopFlying()
	end
end)






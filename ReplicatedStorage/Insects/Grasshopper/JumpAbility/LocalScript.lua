-- @ScriptType: LocalScript
local UIS = game:GetService("UserInputService")
local rs = game:GetService("RunService")

local text = script.Parent:WaitForChild("TextButton").Text
local size = script.Parent:WaitForChild("TextButton").TextSize

local cd = tick()

local connect : RBXScriptConnection = nil

function display(dt)
	if tick() < cd then
		script.Parent:WaitForChild("TextButton").Text = string.format("%.1f", cd - tick()).."s"
		script.Parent:WaitForChild("TextButton").TextSize = 26
	else
		script.Parent:WaitForChild("TextButton").Text = text
		script.Parent:WaitForChild("TextButton").TextSize = size
		connect:Disconnect()
	end

end

function jump()
	if tick() < cd then 
		script.Parent.Parent.print:Fire("Jump ability is cooling down. Try again later.", "Bad")
		return 
	end

	
	while not game.Players.LocalPlayer.Character do task.wait() end
	
	local h : Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
	
	if h.FloorMaterial == Enum.Material.Air then return end
	
	if script.Parent.Parent.Effects:FindFirstChild("Eating") then return end
	
	cd = tick() + 15
	connect = rs.PreRender:Connect(display)
	
	local part : Part = h.Parent:WaitForChild("HumanoidRootPart")
	
	local v = part.CFrame.LookVector * Vector3.new(80,80,80)
	v = Vector3.new(v.X, 50, v.Z)
	
	workspace["Map>"].starve:FireServer(h, 15, true)
	
	workspace["Map>"].addVelocity:FireServer(part, "JumpAbility>", v, Vector3.new(500, 500, 500))
	
	
	local p1 : Part = h.Parent:FindFirstChildOfClass("ObjectValue").Value["PowerLeg1"]

	
	local p2 : Part = h.Parent:FindFirstChildOfClass("ObjectValue").Value["PowerLeg2"]

	
	local l5 : Part = h.Parent:FindFirstChildOfClass("ObjectValue").Value["Leg5"]

	
	local l6 : Part = h.Parent:FindFirstChildOfClass("ObjectValue").Value["Leg6"]

	local P : Part = h.Parent:FindFirstChildOfClass("ObjectValue").Value["PowerLegs"]
	
	workspace["Map>"].setProperty:FireServer(p1, "Transparency", 1)
	workspace["Map>"].setProperty:FireServer(p2, "Transparency", 1)
	workspace["Map>"].setProperty:FireServer(l5, "Transparency", 1)
	workspace["Map>"].setProperty:FireServer(l6, "Transparency", 1)
	workspace["Map>"].setProperty:FireServer(P, "Transparency", 0)
	
	task.wait(0.05)
	
	workspace["Map>"].addVelocity:FireServer(part, "JumpAbility>", nil, nil)
	
	task.wait(0.5)
	
	workspace["Map>"].setProperty:FireServer(p1, "Transparency", 0)
	workspace["Map>"].setProperty:FireServer(p2, "Transparency", 0)
	workspace["Map>"].setProperty:FireServer(l5, "Transparency", 0)
	workspace["Map>"].setProperty:FireServer(l6, "Transparency", 0)
	workspace["Map>"].setProperty:FireServer(P, "Transparency", 1)
	
end

script.Parent:WaitForChild("TextButton").MouseButton1Click:Connect(jump)

UIS.InputBegan:Connect(function(input, Chatting)
	if Chatting then return end 
	if input.KeyCode == Enum.KeyCode.X then
		jump()
	end
end)






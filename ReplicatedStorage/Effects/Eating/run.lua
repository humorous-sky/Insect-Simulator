-- @ScriptType: LocalScript
script.Parent.Parent.Appetite.Value += script.Parent:GetAttribute("Appetite")

while not game.Players.LocalPlayer.Character do wait() end

local char : Model = game.Players.LocalPlayer.Character
local h : Humanoid = char:WaitForChild("Humanoid")


workspace["Map>"].setProperty:FireServer(char:WaitForChild("HumanoidRootPart"), "Anchored", true)

lastFrame = tick()
rs = game:GetService("RunService")
rs.Heartbeat:Connect(function(deltaTime)
	workspace["Map>"].eatFood:FireServer(script.Parent.Pointers.Part0, -1 * script.Parent:GetAttribute("Appetite") * deltaTime, true) --This is to enable Particles. 
	lastFrame = tick()
end)

function endEffect()
	workspace["Map>"].setProperty:FireServer(char:WaitForChild("HumanoidRootPart"), "Anchored", false)
	script.Parent.Parent.Appetite.Value -= script.Parent:GetAttribute("Appetite")
	workspace["Map>"].eatFood:FireServer(script.Parent.Pointers.Part0, 0) --This is to disable Particles. 
	script.Parent:Destroy()
end

h:GetPropertyChangedSignal("MoveDirection"):Connect(function()
	if h.MoveDirection.Magnitude > 0 then
		endEffect()
	end
end)

h:GetAttributeChangedSignal("Hunger"):Connect(function()
	if h:GetAttribute("Hunger") >= h:GetAttribute("MaxHunger") then
		endEffect()
	end
end)

script.Parent.Pointers.Part0:GetAttributeChangedSignal("Leftover"):Connect(function()
	if script.Parent.Pointers.Part0:GetAttribute("Leftover") <= 0 then
		endEffect()
	end
end)


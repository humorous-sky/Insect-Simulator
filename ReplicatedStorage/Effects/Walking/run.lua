-- @ScriptType: LocalScript

while not game.Players.LocalPlayer.Character do wait() end

local char = game.Players.LocalPlayer.Character
local part = char:WaitForChild("HumanoidRootPart")
local h : Humanoid = char:WaitForChild("Humanoid")

script.Parent.Parent.Appetite.Value += h:GetAttribute("WalkAppetite")

char:FindFirstChildOfClass("ObjectValue").Value.StartWalking:FireServer()

script.Parent.Destroying:Connect(function()
	char:FindFirstChildOfClass("ObjectValue").Value.StopWalking:FireServer()
	script.Parent.Parent.Appetite.Value -= h:GetAttribute("WalkAppetite")
end)

h:GetPropertyChangedSignal("MoveDirection"):Connect(function()
	if h.MoveDirection.Magnitude == 0 then
		script.Parent:Destroy()
	end
end)

part:GetPropertyChangedSignal("Anchored"):Connect(function()
	if part.Anchored then
		script.Parent:Destroy()
	end
end)



-- @ScriptType: LocalScript
print(script.Name.." starting")

local h : Humanoid = script.Parent:WaitForChild("Humanoid")
e = game.Players.LocalPlayer.PlayerGui.ScreenGui.Effects

while not h:GetAttribute("RestAppetite") do task.wait() end

e.Appetite.Value += h:GetAttribute("RestAppetite")


rs = game:GetService("RunService")
rs.Heartbeat:Connect(function(deltaTime)
	workspace["Map>"].starve:FireServer(h, e.Appetite.Value * deltaTime)
	workspace["Map>"].takeDamage:FireServer(h, e.Bleed.Value * deltaTime)
end)

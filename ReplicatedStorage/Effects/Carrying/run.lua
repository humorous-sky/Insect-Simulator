-- @ScriptType: LocalScript


while not game.Players.LocalPlayer.Character do wait() end

local char = game.Players.LocalPlayer.Character
local h : Humanoid = char:WaitForChild("Humanoid")

workspace["Map>"].setProperty:FireServer(h, "WalkSpeed", h.WalkSpeed - 1.5)
script.Parent.Parent.Appetite.Value += 0.15

script.Parent.Destroying:Connect(function()
	workspace["Map>"].setProperty:FireServer(h, "WalkSpeed", h.WalkSpeed + 1.5)
	script.Parent.Parent.Appetite.Value -= 0.15
end)



-- @ScriptType: LocalScript

script.Parent.Parent.Bleed.Value += script.Parent:GetAttribute("Bleed")
script.Parent.Parent.Appetite.Value += script.Parent:GetAttribute("Appetite")

while not game.Players.LocalPlayer.Character do wait() end

local h : Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")

h:GetPropertyChangedSignal("FloorMaterial"):Connect(function()
	if h.FloorMaterial ~= Enum.Material.Snow then
		script.Parent.Parent.Bleed.Value -= script.Parent:GetAttribute("Bleed")
		script.Parent.Parent.Appetite.Value -= script.Parent:GetAttribute("Appetite")
		script.Parent:Destroy()
	end
	
end)

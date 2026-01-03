-- @ScriptType: LocalScript
script.Parent.Parent.Bleed.Value += script.Parent:GetAttribute("Bleed")

while not game.Players.LocalPlayer.Character do wait() end

local h : Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")

h:GetAttributeChangedSignal("Hunger"):Connect(function()
	if h:GetAttribute("Hunger") < h:GetAttribute("MaxHunger") * 0.8 then
		script.Parent.Parent.Bleed.Value -= script.Parent:GetAttribute("Bleed")
		script.Parent:Destroy()
	end
	
end)

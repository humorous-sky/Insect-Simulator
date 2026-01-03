-- @ScriptType: LocalScript
types = {
	["Bad"] = Color3.new(1, 0, 0),
	["Good"] = Color3.new(0, 0.5, 0),
	["Ok"] = Color3.new(0, 0.5, 1)
}

TS = game:GetService("TweenService")
function Print(str : string, T : string)
	
	if script.Parent.Parent.Messages:FindFirstChild(str) then return end
	
	T = (T == nil and "Bad" or T)

	local t : TextLabel = game.ReplicatedStorage.Text:Clone()
	
	t.Name = str

	t.Text = str

	t.UIStroke.Color = types[T]
	
	t.Parent = script.Parent.Parent.Messages
	
	game.Debris:AddItem(t, 3)
	
	local info = TweenInfo.new(3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false) 

	TS:Create(
		t, 

		info, 

		{TextTransparency = 1, Position = UDim2.new(-1.786, 0, -1, 0)}
	):Play()


	TS:Create(
		t.UIStroke, 

		info, 

		{Transparency = 1}
	):Play()

end

script.Parent.Event:Connect(Print)

script.Parent.server.OnClientEvent:Connect(Print)

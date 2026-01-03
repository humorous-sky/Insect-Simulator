-- @ScriptType: Script
TS = game:GetService("TweenService")

local info = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, true) 

local anims = {}
local angles = {
	CFrame.Angles(0, 0, 7 * math.pi/12),
	CFrame.Angles(0, 0, 9 * math.pi/12),
	CFrame.Angles(0, 0, 9 * math.pi/12),
	CFrame.Angles(0, 0, 7 * math.pi/12),
	CFrame.Angles(0, 0, 7 * math.pi/12),
	CFrame.Angles(0, 0, 9 * math.pi/12),
}

for i, v in angles do
	local cf = CFrame.new(script.Parent:WaitForChild("Leg"..i.."Joint-Leg"..i).C1.Position) * v
	table.insert(anims, TS:Create(
		script.Parent["Leg"..i.."Joint-Leg"..i], 

		info, 

		{C1 = cf} 
	))
end


script.Parent.StartWalking.OnServerEvent:Connect(function()
	for i, v in anims do
		v:Play()
	end
end)


script.Parent.StopWalking.OnServerEvent:Connect(function()
	for i, v in anims do
		v:Pause()
	end
end)



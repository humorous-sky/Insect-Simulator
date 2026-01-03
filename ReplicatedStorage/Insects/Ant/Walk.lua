-- @ScriptType: Script
TS = game:GetService("TweenService")

local info = TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, true) 

local tween = TS:Create(
	script.Parent:WaitForChild("Thorax-Legs"), 

	info, 

	{C0 = CFrame.new(script.Parent["Thorax-Legs"].C0.Position) * CFrame.Angles(0, math.pi/15, 0)} 
)

tween:Play()

tween:Pause()

script.Parent.StartWalking.OnServerEvent:Connect(function()
	tween:Play()
end)


script.Parent.StopWalking.OnServerEvent:Connect(function()
	tween:Pause()
end)



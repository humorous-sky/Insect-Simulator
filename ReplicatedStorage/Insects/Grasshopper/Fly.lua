-- @ScriptType: Script
TS = game:GetService("TweenService")

local info = TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, true) 


local leftOg = script.Parent:WaitForChild("Thorax-LeftWing").C1
local rightOg = script.Parent:WaitForChild("Thorax-RightWing").C1

local left = TS:Create(
	script.Parent["Thorax-LeftWing"], 

	info, 

	{C1 = CFrame.new(script.Parent["Thorax-LeftWing"].C1.Position) * CFrame.Angles(0, math.pi/6, -math.pi/6)} 
)
local right = TS:Create(
	script.Parent["Thorax-RightWing"], 

	info, 

	{C1 = CFrame.new(script.Parent["Thorax-RightWing"].C1.Position) * CFrame.Angles(0, -math.pi/6, -math.pi/6)} 
)


script.Parent.StartFlying.OnServerEvent:Connect(function()
	left:Play()
	right:Play()
end)

script.Parent.StopFlying.OnServerEvent:Connect(function()
	left:Pause()
	right:Pause()
	pcall(function() 
		script.Parent["Thorax-LeftWing"].C1 = leftOg
		script.Parent["Thorax-RightWing"].C1 = rightOg
	end)
end)

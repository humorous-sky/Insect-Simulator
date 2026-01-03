-- @ScriptType: Script
TS = game:GetService("TweenService")

local infoFront = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, true) 

local infoBack = TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, -1, true) 


local leftFrontOg = script.Parent:WaitForChild("Thorax-LeftFrontWing").C1
local rightFrontOg = script.Parent:WaitForChild("Thorax-RightFrontWing").C1
local leftBackOg = script.Parent:WaitForChild("Thorax-LeftBackWing").C1
local rightBackOg = script.Parent:WaitForChild("Thorax-RightBackWing").C1

local leftFront = TS:Create(
	script.Parent["Thorax-LeftFrontWing"], 

	infoFront, 

	{C1 = CFrame.new(script.Parent["Thorax-LeftFrontWing"].C1.Position) * CFrame.Angles(-math.pi/12, 11 * math.pi/36, math.pi/2)} 
)
local rightFront = TS:Create(
	script.Parent["Thorax-RightFrontWing"], 

	infoFront, 

	{C1 = CFrame.new(script.Parent["Thorax-RightFrontWing"].C1.Position) * CFrame.Angles(-math.pi/12, 2 * math.pi/3, math.pi/2)} 
)

local leftBack = TS:Create(
	script.Parent["Thorax-LeftBackWing"], 

	infoBack, 

	{C1 = CFrame.new(script.Parent["Thorax-LeftBackWing"].C1.Position) * CFrame.Angles(math.pi/12, 11 * math.pi/36, math.pi/2)} 
)
local rightBack = TS:Create(
	script.Parent["Thorax-RightBackWing"], 

	infoBack, 

	{C1 = CFrame.new(script.Parent["Thorax-RightBackWing"].C1.Position) * CFrame.Angles(math.pi/12, 2 * math.pi/3, math.pi/2)} 
)


script.Parent.StartFlying.OnServerEvent:Connect(function()
	leftFront:Play()
	rightFront:Play()
	leftBack:Play()
	rightBack:Play()
end)

script.Parent.StopFlying.OnServerEvent:Connect(function()
	leftFront:Pause()
	rightFront:Pause()
	leftBack:Pause()
	rightBack:Pause()
	pcall(function() 
		script.Parent["Thorax-LeftFrontWing"].C1 = leftFrontOg
		script.Parent["Thorax-RightFrontWing"].C1 = rightFrontOg
		script.Parent["Thorax-LeftBackWing"].C1 = leftBackOg
		script.Parent["Thorax-RightBackWing"].C1 = rightBackOg
	end)
end)

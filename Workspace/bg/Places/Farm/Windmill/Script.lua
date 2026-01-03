-- @ScriptType: Script
TS = game:GetService("TweenService")

local bladeInfo = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,-1, false) 

local bladeTween = TS:Create(
	script.Parent.Blades, --The object to tween.

	bladeInfo, --The tween info, put in your variable for your tween info here.

	{Orientation = Vector3.new(-360, 0, 0)} --The property of the object you want to change.
)

bladeTween:Play()

local millInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,-1, false) 

local millTween = TS:Create(
	script.Parent.Mill, --The object to tween.

	millInfo, --The tween info, put in your variable for your tween info here.

	{Orientation = Vector3.new(0, 360, -90)} --The property of the object you want to change.
)

millTween:Play()
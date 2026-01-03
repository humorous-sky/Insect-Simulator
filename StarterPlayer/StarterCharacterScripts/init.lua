-- @ScriptType: Script
local plr : Player = game:GetService("Players"):GetPlayerFromCharacter(script.Parent)

local f : RemoteFunction = plr:WaitForChild("PlayerGui"):WaitForChild("GetPrefs")

local result : {Instances} = f:InvokeClient(plr)

while not result do
	task.wait()
	result = f:InvokeClient(plr)
end


local rs = game:GetService("ReplicatedStorage")

function hasProperty(object, propertyName)
	local success, _ = pcall(function() 
		object[propertyName] = object[propertyName]
	end)
	return success
end

local h : Humanoid = script.Parent:WaitForChild("Humanoid")

for i, v in pairs(h.Parent:GetDescendants()) do 
	if hasProperty(v, "Transparency") then
		v.Transparency = 1
	end
end

local model : Model = rs:WaitForChild("Insects")[result["Species"]]:Clone()
result["Species"] = nil
model.Parent = script.Parent

local spawnLoc : string = result["SpawnLocation"]
result["SpawnLocation"] = nil

local descendants = model:GetDescendants()
for bodypart, value in result do
	for _, part in descendants do 
		if part:IsA("BasePart") and part.Name:match(bodypart) then
			part.Color = value
		end
	end
end

model:WaitForChild("Walk").Enabled = true

model:WaitForChild("Fly").Enabled = true


model:WaitForChild("Head").Anchored = false

for attr, _ in pairs(model:GetAttributes()) do

	if hasProperty(h, attr) then
		h[attr] = model:GetAttribute(attr)
	else
		h:SetAttribute(attr, model : GetAttribute(attr))
	end
	
end

h.Health = h.MaxHealth

h:SetAttribute("Hunger", h:GetAttribute("MaxHunger")/2)

script.Parent:WaitForChild("Health"):Destroy()

script.Parent:FindFirstChildOfClass("ObjectValue").Value = model

task.wait(1)

local TweeningInfo = TweenInfo.new(0,Enum.EasingStyle.Quint,Enum.EasingDirection.Out,0,false,0)
local scale = model.ShrinkScale.Value

local Height = {Value = h:WaitForChild("BodyHeightScale").Value * scale}
local Depth = {Value = h:WaitForChild("BodyDepthScale").Value * scale}
local Width = {Value = h:WaitForChild("BodyWidthScale").Value * scale}
local Head = {Value = h:WaitForChild("HeadScale").Value * scale}
local WdithTween = game:GetService("TweenService"):Create(h.BodyWidthScale,TweeningInfo,Width)
local HeightTween = game:GetService("TweenService"):Create(h.BodyHeightScale,TweeningInfo,Height)
local DepthTween = game:GetService("TweenService"):Create(h.BodyDepthScale,TweeningInfo,Depth)
local HeadTween = game:GetService("TweenService"):Create(h.HeadScale,TweeningInfo,Head)
WdithTween:Play()
HeightTween:Play()
DepthTween:Play()
HeadTween:Play()

--print(script.Parent:FindFirstChildOfClass("ObjectValue").Value)
while #(model:GetDescendants()) ~= plr:WaitForChild("PlayerGui"):WaitForChild("LoadedValidation"):InvokeClient(plr) do 
	print(#(model:GetDescendants()).." "..plr:WaitForChild("PlayerGui"):WaitForChild("LoadedValidation"):InvokeClient(plr))
	task.wait() 
end

local weld : Weld = Instance.new("Weld")

weld.Parent = script.Parent

weld.Part0 = script.Parent:WaitForChild("HumanoidRootPart")


weld.Part1 = model.Thorax

weld.C1 = model.Offset.Value

local l : {Instance} = model:GetChildren()
for i, v in pairs(l) do
	if v:IsA("Frame") then
		v.Parent = plr.PlayerGui.ScreenGui
	end
end

script.Parent:PivotTo(rs:WaitForChild("SpawnLocations"):WaitForChild(spawnLoc).CFrame)

task.wait(1)

script.Parent:WaitForChild("movement").Enabled = true
script.Parent:WaitForChild("process").Enabled = true 

script:Destroy()


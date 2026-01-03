-- @ScriptType: LocalScript
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health,false)
local bodyparts = {"Head", "Thorax", "Abdomen", "Leg", "Eyes", "Wing", "Antenna"}

local ts : TweenService = game:GetService("TweenService")
local rs : ReplicatedStorage = game:GetService("ReplicatedStorage")
--script.Parent.Enabled = true


local insectInfo : TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false)
local insectText : TextLabel = script.Parent:WaitForChild("Start"):WaitForChild("Stats"):WaitForChild("Insect")
ts:Create(
	insectText,
	insectInfo,
	{Position = UDim2.new(0.5, -280, 0.33, -50)}
):Play()

local simInfo : TweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 1.5)
local simText : TextLabel = script.Parent:WaitForChild("Start"):WaitForChild("Stats"):WaitForChild("Simulator")
tw = ts:Create(
	simText,
	simInfo,
	{Position = UDim2.new(0.5, -65, 0.33, -100)}
)
tw:Play()

conn = tw.Completed:Connect(function()
	conn:Disconnect()
	
	local simRotateInfo : TweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false)

	ts:Create(
		simText,
		simRotateInfo,
		{Position = UDim2.new(0.5, -65, 0.33, -65), Rotation = 10}
	):Play()
end)

local startGamemodeInfo : TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 3)
local startButton : Frame = script.Parent:WaitForChild("Start"):WaitForChild("Stats"):WaitForChild("StartButton")
ts:Create(
	startButton,
	startGamemodeInfo,
	{Position = UDim2.new(0.5, -260, 0.66, -15)}
):Play()

local gamemodeButton : Frame = script.Parent:WaitForChild("Start"):WaitForChild("Stats"):WaitForChild("GamemodeButton")
ts:Create(
	gamemodeButton,
	startGamemodeInfo,
	{Position = UDim2.new(0.5, 60, 0.66, -15)}
):Play()

local startExitInfo : TweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false)
local startButton : TextButton = startButton:WaitForChild("TextButton")
local sel : ScrollingFrame = script.Parent:WaitForChild("Select")
local exitButton : TextButton = script.Parent:WaitForChild("ExitButton")

startButton.MouseButton1Click:Connect(function()
	
	
	ts:Create(
		sel,
		startExitInfo,
		{Position = UDim2.new(0.5, -300, 0.1, 0)}
	):Play()
	
	ts:Create(
		exitButton,
		startExitInfo,
		{Position = UDim2.new(0.5, 300, 0.1, 0)}
	):Play()
end)

exitButton.MouseButton1Click:Connect(function()

	ts:Create(
		sel,
		startExitInfo,
		{Position = UDim2.new(0.5, -300, 1, 0)}
	):Play()

	ts:Create(
		exitButton,
		startExitInfo,
		{Position = UDim2.new(0.5, 300, 1, 0)}
	):Play()
end)

local freeInsects = {"Ant", "Butterfly", "Cockroach", "Grasshopper"}

local l : {Instance} = script.Parent:WaitForChild("Select"):GetChildren()


for i, v in freeInsects do 
	local clone = rs:WaitForChild("Frame"):Clone()
	
	clone.Name = v
	clone:WaitForChild("TextButton").Text = v
	
	clone.Parent = sel
	
	clone.Position = UDim2.new(0, 43, 0, i * 110)
	
	table.insert(l, clone)
end
local desc : ScrollingFrame = script.Parent:WaitForChild("Desc")
local dietText : TextLabel = desc:WaitForChild("diet")
local descExitButton : TextButton = script.Parent:WaitForChild("DescExitButton")


local foods = {
	["🍪"] = "scavenges for whatever humans produce",
	["🌾"] = "grazes wheat and other grasses",
	["🥬"] = "munches on leaves and lettuce", 
	["🍎"] = "snacks on fruits and other sweet, watery stuff",
	["🌸"] = "drinks nectar from flowers",
	["🐾"] = "leeches from other animals",
	["💩"] = "decomposes rotten organic matter"
}

local insectModel : Model = nil
local maxColors = 10

for i, v in l do
	
	if not v:IsA("Frame") then continue end
	
	local vpFrame : ViewportFrame = v:WaitForChild("ViewportFrame")
	
	local part : Part = Instance.new("Part")
	part.Parent = vpFrame
	part.Size = Vector3.new(2, 2, 2)
	part.Material = Enum.Material.Concrete
	part.Color = Color3.new(0.25, 0.75, 1)
	part.Position = Vector3.new(0, -1, -1)
	part.Transparency = 0.5
	
	local model = rs.Insects:WaitForChild(v.Name):Clone()
	
	
	model:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
	model.Parent = vpFrame
	for i, v in model:GetChildren() do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end

	local viewportCamera : Camera = Instance.new("Camera")
	vpFrame.CurrentCamera = viewportCamera
	viewportCamera.Parent = vpFrame

	viewportCamera.CFrame = CFrame.new(Vector3.new(0,1,1), Vector3.new(0, 0, 0))
	
	
	
	v:WaitForChild("TextButton").MouseButton1Click:Connect(function()

		ts:Create(
			desc,
			startExitInfo,
			{Position = UDim2.new(0.5, -300, 0.1, 0)}
		):Play()

		ts:Create(
			descExitButton,
			startExitInfo,
			{Position = UDim2.new(0.5, 300, 0.1, 0)}
		):Play()
		exitButton.Visible = false
		sel.Visible = false
		
		dietText.Text = ""
		
		local diet : string = model:GetAttribute("Diet")
		
		for i, v in foods do
			if diet:match(i) then
				dietText.Text = dietText.Text..i.."—"..v.."\n\n"
			end
			
		end
		
		desc:WaitForChild("title").Text = model.Name
		
		local vp : ViewportFrame = desc:WaitForChild("ViewportFrame")
		insectModel = model:Clone()
		insectModel.Parent = vp
		
		local p : BasePart = insectModel.PrimaryPart:Clone()
		p.Parent = insectModel
		p.Transparency = 1
		p.Name = "tmp"
		insectModel.PrimaryPart = p
		
		vp:WaitForChild("Camera").CFrame = CFrame.new(Vector3.new(0, 0, 0.85), Vector3.new(0, 0, 0))
		
		
		local insectInfo = rs:WaitForChild("InsectInfo")[model.Name]
		
		local success, _ = pcall(function()
			desc:WaitForChild("desc").Text = insectInfo:GetAttribute("Description")
		end)
		
		if not(success) or desc:WaitForChild("desc").Text == nil then
			desc:WaitForChild("desc").Text = "--No description provided--"
		end

		for _, part in bodyparts do
			if insectInfo:FindFirstChild(part) then
				local val : Color3Value = insectInfo:FindFirstChild(part)
				
				local sf : ScrollingFrame = desc:WaitForChild(part)
				
				local btn : ImageButton  = sf:WaitForChild("Default")
				
				btn.BackgroundColor3 = val.Value
				
				script.Parent:SetAttribute(part, val.Value)
				
				local other = val:GetAttributes()
				local count = 0
		
				for name, color in other do
					if sf:FindFirstChild(name) then
						sf[name].BackgroundColor3 = color
						sf[name].Visible = true
						count += 1
					end
				end
				
				for i = (count + 1), maxColors, 1 do
					if sf:FindFirstChild(i.."") then
						sf[i..""].BackgroundColor3 = Color3.new(1, 1, 1)
						sf[i..""].Visible = false
					end
				end
				
				sf.CanvasSize = UDim2.new(0, (count + 1) * 55, 1, 0)
			end
		end
		
	 	
	end)
	
	
end



for _, part in bodyparts do
	local p = part
	
	local sf : ScrollingFrame = desc:WaitForChild(part)

	local btn : ImageButton  = sf:WaitForChild("Default")
	
	btn.MouseButton1Click:Connect(function()
		script.Parent:SetAttribute(p, btn.BackgroundColor3)
		
		local l = insectModel:GetDescendants()
		
		for _, v in l do
			if v:IsA("BasePart") and v.Name:match(p) then
				v.Color = script.Parent:GetAttribute(p)
			end
		end
	end)
	
	for i = 1, maxColors, 1 do

		local btn : ImageButton = btn:Clone()
		btn.Position = UDim2.new(0, i * 55 + 5, 0, 5)
		btn.Name = i..""
		btn.Parent = sf
		
		btn.MouseButton1Click:Connect(function()
			script.Parent:SetAttribute(p, btn.BackgroundColor3)

			local l = insectModel:GetDescendants()

			for _, v in l do
				if v:IsA("BasePart") and v.Name:match(p) then
					v.Color = script.Parent:GetAttribute(p)
				end
			end
		end)
		
	end
end


local vp : ViewportFrame = desc:WaitForChild("ViewportFrame")
local click : TextButton = vp:WaitForChild("Rotate")
local reset : TextButton = vp:WaitForChild("Reset")

local resetInfo : TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false)
local IN = ts:Create(click, resetInfo, {TextTransparency = 0})
local OUT = ts:Create(click, resetInfo, {TextTransparency = 1})


local vpCamera : Camera = Instance.new("Camera")
vp.CurrentCamera = vpCamera
vpCamera.Parent = vp

vpCamera.CFrame = CFrame.new(Vector3.new(0, 0, 0.85), Vector3.new(0, 0, 0))

local last : Vector2 = nil
local mouse : boolean = false

click.MouseButton1Up:Connect(function(x, y)
	mouse = false
	last = nil
	IN:Play()
end)
click.MouseButton1Down:Connect(function(x, y)
	mouse = true
	last = Vector2.new(x, y)
	OUT:Play()
end)
reset.MouseButton1Click:Connect(function()
	insectModel.PrimaryPart.Orientation = insectModel:WaitForChild("Thorax").Orientation
	insectModel:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
end)

vp.MouseMoved:Connect(function(x, y)
	local new = Vector2.new(x, y)
	--print(new)
	if last == nil or not(mouse) then 
		last = new
		return
	end
	
	local change = new - last
	
	insectModel:SetPrimaryPartCFrame(
		insectModel:GetPrimaryPartCFrame() * CFrame.Angles(math.rad(change.Y), math.rad(change.X), 0)
	)
	last = new
	insectModel.PrimaryPart.Orientation = Vector3.new(0, 0, 0)
end)
vp.MouseLeave:Connect(function()
	mouse = false
	last = nil
	IN:Play()
end)

local locations : {string} = {"Campsite", "Farm", "Paradise", "Mountain", "Valleys", "Ruins", "Lakeside", "Swamps", "Forest", "Quarry", "Pier", "Orchard", "Grasslands", "Pond"}

local index = 0

local spawnSelect : ScreenGui = script.Parent.Parent:WaitForChild("SpawnSelect")

desc:WaitForChild("Play"):WaitForChild("TextButton").MouseButton1Click:Connect(function()
	script.Parent:SetAttribute("Species", insectModel.Name)
	
	script.Parent.Enabled = false
	
	spawnSelect.Enabled = true
	
	
	workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	
	local loc : Part = rs:WaitForChild("SpawnLocations"):WaitForChild(locations[index + 1])
	
	spawnSelect:WaitForChild("Location").Text = loc.Name
	
	script.Parent:SetAttribute("SpawnLocation", loc.Name)
	
	workspace.CurrentCamera.CFrame = CFrame.new(loc:WaitForChild("Attachment").WorldPosition, loc.Position)
end)


local cameraTweenInfo : TweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false)
local velocity = 300

spawnSelect:WaitForChild("Next"):WaitForChild("TextButton").MouseButton1Click:Connect(function()
	local pos = rs:WaitForChild("SpawnLocations"):WaitForChild(locations[index + 1]).Position
	
	index += 1
	index %= #locations
	local loc : Part = rs:WaitForChild("SpawnLocations"):WaitForChild(locations[index + 1])
	
	script.Parent:SetAttribute("SpawnLocation", loc.Name)
	
	spawnSelect:WaitForChild("Location").Text = loc.Name
	
	cameraTweenInfo = TweenInfo.new((loc.Position - pos).Magnitude/velocity, cameraTweenInfo.EasingStyle, cameraTweenInfo.EasingDirection, cameraTweenInfo.RepeatCount, cameraTweenInfo.Reverses)

	ts:Create(
		workspace.CurrentCamera, 
		cameraTweenInfo, 
		{CFrame = CFrame.new(loc:WaitForChild("Attachment").WorldPosition, loc.Position)}
	):Play()
end)

spawnSelect:WaitForChild("Prev"):WaitForChild("TextButton").MouseButton1Click:Connect(function()
	local pos = rs:WaitForChild("SpawnLocations"):WaitForChild(locations[index + 1]).Position
	
	index -= 1 
	index += #locations
	index %= #locations
	local loc : Part = rs:WaitForChild("SpawnLocations"):WaitForChild(locations[index + 1])

	script.Parent:SetAttribute("SpawnLocation", loc.Name)
	
	spawnSelect:WaitForChild("Location").Text = loc.Name
	
	cameraTweenInfo = TweenInfo.new((loc.Position - pos).Magnitude/velocity, cameraTweenInfo.EasingStyle, cameraTweenInfo.EasingDirection, cameraTweenInfo.RepeatCount, cameraTweenInfo.Reverses)
	
	ts:Create(
		workspace.CurrentCamera, 
		cameraTweenInfo, 
		{CFrame = CFrame.new(loc:WaitForChild("Attachment").WorldPosition, loc.Position)}
	):Play()
end)

spawnSelect:WaitForChild("Spawn"):WaitForChild("TextButton").MouseButton1Click:Connect(function()
	spawnSelect.Enabled = false
	script.Parent.Parent:WaitForChild("ScreenGui").Enabled = true
	
	while not game.Players.LocalPlayer.Character do task.wait() end
	
	workspace:WaitForChild("Map>"):WaitForChild("setProperty"):FireServer(game.Players.LocalPlayer.Character:WaitForChild("init"), "Enabled", true)
	
	local spawnTweenInfo : TweenInfo = TweenInfo.new(3, Enum.EasingStyle.Quint, Enum.EasingDirection.In, 0, false)
	
	local loc : Part = rs:WaitForChild("SpawnLocations"):WaitForChild(locations[index + 1])
	
	local anim : Tween = ts:Create(
		workspace.CurrentCamera, 
		spawnTweenInfo, 
		{CFrame = loc.CFrame}
	)
	anim:Play()
	anim.Completed:Connect(function()
		while game.Players.LocalPlayer.Character:FindFirstChild("init") do task.wait() end
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	end)
	
end)

spawnSelect:WaitForChild("Cancel"):WaitForChild("TextButton").MouseButton1Click:Connect(function()
	script.Parent:SetAttribute("Species", "")

	script.Parent.Enabled = true

	spawnSelect.Enabled = false


	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom

	script.Parent:SetAttribute("SpawnLocation", "")
end)

descExitButton.MouseButton1Click:Connect(function()
	ts:Create(
		desc,
		startExitInfo,
		{Position = UDim2.new(0.5, -300, 1, 0)}
	):Play()

	ts:Create(
		descExitButton,
		startExitInfo,
		{Position = UDim2.new(0.5, 300, 1, 0)}
	):Play()
	exitButton.Visible = true
	sel.Visible = true
	
	local m : model = vp:FindFirstChildOfClass("Model")
	
	if m then m:Destroy() end
	
	local insectInfo = rs:WaitForChild("InsectInfo")[insectModel.Name]
	
	insectModel = nil
	
	desc:WaitForChild("title").Text = ""
	desc:WaitForChild("desc").Text = ""
	
	
	for _, v in bodyparts do
		script.Parent:SetAttribute(v, Color3.new(1, 1, 1))
	end
end)

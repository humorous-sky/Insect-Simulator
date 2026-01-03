-- @ScriptType: LocalScript
if script.Parent.Parent:FindFirstChild("Walking") then
	l = script.Parent.Parent:GetChildren()
	for i, v in l do
		if v.Name == "Walking" then
			v:Destroy()
		end
	end
end


local rs : RunService = game:GetService("RunService")


while not game.Players.LocalPlayer.Character do task.wait() end

local char = game.Players.LocalPlayer.Character
local h : Humanoid = char:WaitForChild("Humanoid")
local part : Part = char:WaitForChild("HumanoidRootPart")

while not char:FindFirstChildOfClass("ObjectValue") do task.wait() end

local model : Model = char:FindFirstChildOfClass("ObjectValue").Value
local v : number = h:GetAttribute("FlyVelocity")
local sound = model:WaitForChild("Abdomen"):FindFirstChild("FlySound")

if sound then
	workspace["Map>"].setProperty:FireServer(sound, "Playing", true)
end

script.Parent.Parent:WaitForChild("Appetite").Value += h:GetAttribute("FlyAppetite")

if model:FindFirstChild("StartFlying") then
	model.StartFlying:FireServer()
end

local dir : Vector3 = h.MoveDirection * Vector3.new(v,v,v)

dir = Vector3.new(dir.X, script.Parent:GetAttribute("Velocity") * 0.9, dir.Z)

workspace["Map>"].addVelocity:FireServer(part, "Terminal Velocity>", dir, Vector3.new(150, 150, 150))

function upd()
	local dir : Vector3 = h.MoveDirection * Vector3.new(v,v,v)

	dir = Vector3.new(dir.X, script.Parent:GetAttribute("Velocity") * 0.9, dir.Z)

	workspace["Map>"].addVelocity.unreliable:FireServer(part, "Terminal Velocity>", dir, Vector3.new(150, 150, 150))
end

conn1 = h:GetPropertyChangedSignal("MoveDirection"):Connect(upd)

conn2 = script.Parent:GetAttributeChangedSignal("Velocity"):Connect(upd)

rs.Heartbeat:Connect(function(dt)
	
	if (part.AssemblyLinearVelocity.Y <= 0 and part.AssemblyLinearVelocity.Y >= script.Parent:GetAttribute("Velocity") * 0.5 and script.Parent:GetAttribute("Velocity") < 0) or part.Anchored then
		conn1:Disconnect()
		conn2:Disconnect()
		workspace["Map>"].addVelocity:FireServer(part, "Terminal Velocity>", Vector3.new(0,0,0), Vector3.new(math.huge, math.huge, math.huge))
		task.wait(0.05)
		workspace["Map>"].addVelocity:FireServer(part, "Terminal Velocity>", nil, nil)
		if model:FindFirstChild("StopFlying") then
			model.StopFlying:FireServer()
		end
		script.Parent:Destroy()
	end
end)

script.Parent.Destroying:Connect(function()
	script.Parent.Parent.Appetite.Value -= h:GetAttribute("FlyAppetite")
	
	if sound then
		workspace["Map>"].setProperty:FireServer(sound, "Playing", false)
	end

	if h.MoveDirection.Magnitude > 0 and not(part.Anchored) then
		script.Parent.Parent.Parent.addEffect:Invoke(game.Players.LocalPlayer, "Walking")
	end
end)


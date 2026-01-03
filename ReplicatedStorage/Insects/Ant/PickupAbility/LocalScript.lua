-- @ScriptType: LocalScript
local UIS = game:GetService("UserInputService")
local rs = game:GetService("RunService")

local text = script.Parent:WaitForChild("TextButton").Text
local size = script.Parent:WaitForChild("TextButton").TextSize

local cd = tick()

local connect : RBXScriptConnection = nil

function display(dt)
	if tick() < cd then
		script.Parent:WaitForChild("TextButton").Text = string.format("%.1f", cd - tick()).."s"
		script.Parent:WaitForChild("TextButton").TextSize = 26
	else
		script.Parent:WaitForChild("TextButton").Text = text
		script.Parent:WaitForChild("TextButton").TextSize = size
		connect:Disconnect()
	end

end

function pickUp()
	if tick() < cd then 
		script.Parent.Parent.print:Fire("Pickup ability is cooling down. Try again later.", "Bad")
		return 
	end
	
	cd = tick() + 5
	connect = rs.PreRender:Connect(display)
	
	local e = script.Parent.Parent.Effects:FindFirstChild("Eating")
	local c = script.Parent.Parent.Effects:FindFirstChild("Carrying")
	local plr = game.Players.LocalPlayer
	
	if e and e.Pointers.Part0 and (not c) then
		game.Workspace["Map>"].makeCrumb:FireServer(e.Pointers.Part0, 50, plr)
		
		plr.PlayerGui.ScreenGui.addEffect:Invoke(plr, "Carrying")
		
		script.Parent.Parent.print:Fire("You are carrying food.", "Ok")
		
	elseif c then
		c:Destroy()
		plr.PlayerGui.ScreenGui.print:Fire("You dropped your food.", "Ok")
		
		while not plr.Character do task.wait() end
		
		local model = plr.Character:FindFirstChildOfClass("ObjectValue").Value
		
		local food = model["Thorax-Food"].Part1
		workspace["Map>"].setProperty:FireServer(food.ProximityPrompt, "Enabled", true)
		workspace["Map>"].setProperty:FireServer(food, "Parent", game.Workspace["Map>"].Crumbs)
		workspace["Map>"].setProperty:FireServer(model["Thorax-Food"], "Part1", nil)
		workspace["Map>"].setProperty:FireServer(food, "CFrame", model["Thorax-Food"].Part1.CFrame * CFrame.new(0, 1, 0))	
	else
		plr.PlayerGui.ScreenGui.print:Fire("You can't pick up food right now.", "Bad")
	end
end

script.Parent:WaitForChild("TextButton").MouseButton1Click:Connect(pickUp)


UIS.InputBegan:Connect(function(input, Chatting)
	if Chatting then return end 
	if input.KeyCode == Enum.KeyCode.X then
		pickUp()
	end
end)






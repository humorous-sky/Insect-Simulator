-- @ScriptType: Script
function crumb(callback, object : Instance, size : number, plr : Player)
	local food : BasePart = object:Clone()
	
	food.Parent = workspace["bg"].Crumbs
	
	food.CustomPhysicalProperties = PhysicalProperties.new(100, 2, 0)
	
	local prev = object:GetAttribute("Leftover")
	
	workspace["bg"].eatFood.server:Fire(object, size, false)
	
	food:SetAttribute("Leftover", prev - object:GetAttribute("Leftover"))
	
	food.Anchored = false
	
	food:SetAttribute("Supply", size)
	
	workspace["bg"].eatFood.server:Fire(food, 0, false)
	
	if object.Parent ~= workspace["bg"].Crumbs then
		food.Size *= food:GetAttribute("Supply")/100
	end
	
	if plr ~= nil then
		while not plr.Character do task.wait() end
		
		local weld : Weld = plr.Character:FindFirstChildOfClass("ObjectValue").Value["Thorax-Food"]
		
		
		weld.Part1 = food
		
		weld.C1 = (CFrame.new(0,0,0) * food.PivotOffset.Rotation) * CFrame.new(0, -0.185, 0) 
		
		food.ProximityPrompt.Enabled = false
		
		food.Parent = plr.Character
	end
end
script.Parent.OnServerEvent:Connect(crumb)
script.Parent.server.Event:Connect(function(o, s, p)
	crumb(nil, o, s, p)
end)




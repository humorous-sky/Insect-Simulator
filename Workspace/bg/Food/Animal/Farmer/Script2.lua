-- @ScriptType: Script
local TS = game:GetService("TweenService")
local PS = game:GetService("PathfindingService")


local target : Part = workspace:WaitForChild("bg"):WaitForChild("Places"):WaitForChild("Farm"):WaitForChild("MAP"):WaitForChild("Start")

local targets : Part = workspace:WaitForChild("bg"):WaitForChild("Places"):WaitForChild("Farm"):WaitForChild("MAP"):GetChildren()



local character : Model = script.Parent

local humanoid : Humanoid = character:WaitForChild("Humanoid")

local path = PS:CreatePath({
	AgentRadius = 1,
	AgentHeight = 6,
	WaypointSpacing = math.huge,
	Costs = {
		Ground = math.huge,
		Grass = math.huge,
		LeafyGrass = math.huge
	}
})


local function computePath(destination)
	-- Compute the path
	local success, errorMessage = pcall(function()
		path:ComputeAsync(character.PrimaryPart.Position, destination)
	end)

	if success and path.Status == Enum.PathStatus.Success then
		-- Get the path waypoints
		return path:GetWaypoints()		
	else
		warn("Path not computed!", errorMessage)
		return nil
	end
end

local waypoints = nil
while not waypoints do 
	waypoints = computePath(target.Position)
end

local nextWaypointIndex = 2 --rojo test

humanoid:MoveTo(waypoints[nextWaypointIndex].Position)

local jumped = false

humanoid.MoveToFinished:Connect(function(reached)

	if reached and nextWaypointIndex < #waypoints then
		nextWaypointIndex = math.min(nextWaypointIndex + 1, #waypoints)
		humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
		jumped = false
		
	elseif (not reached) and (not jumped) then
		humanoid.Jump = true
		humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
		jumped = true
	else
		task.wait(math.random(0.0, 5.0))
		
		for _, obj in character:GetChildren() do
			if obj:IsA("BasePart") then
				obj:SetNetworkOwner(nil)
			end
		end

		waypoints = nil
		while not waypoints do 
			local t = targets[math.random(1, #targets)]

			while t == target do
				t = targets[math.random(1, #targets)]
			end

			target = t
			waypoints = computePath(target.Position)
		end

		nextWaypointIndex = 2
		
		humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
	end
end)




character.Range.Touched:Connect(function(hit)
	if hit.Name == "Thorax" and hit.Parent.Parent:FindFirstChild("Humanoid") then
		
		local h : Humanoid = hit.Parent.Parent.Humanoid
		
		local species : string = h:GetAttribute("Species")
		
		

		local part0 = script.Parent.Head
		local part1 = hit.Parent.Parent:WaitForChild("Head")

		local exclude = {
			part0, 
			script.Parent.Tool.Handle,
			script.Parent.Tool.Sprayer,
			script.Parent.Tool.Liquid,
			script.Parent.Torso,
			script.Parent["Right Arm"],
			script.Parent["Left Arm"],
			--part1
		}
		--i subtract the two vectors because traditionally it would look like (part1.Position - part0.Position).Unit * (part1.Position - part0.Position).Magnitude which is just part1.Position - part0.Position

		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = exclude
		
		local ray = workspace:Raycast(part0.Position, part1.Position - part0.Position, params)
		
		local plr : Player = game.Players:FindFirstChild(hit.Parent.Parent.Name)
		
		if ray and not(ray.Instance:IsDescendantOf(h.Parent)) then
			--plr.PlayerGui.ScreenGui.print.server:FireClient(plr, "Phew, the "..script.Parent.Name.." didn't see you because "..ray.Instance.Name.." was in the way!", "Good")
		else
			if not(species:lower():match("bee")) then

				
				plr.PlayerGui.ScreenGui.addEffect.server:InvokeClient(plr, plr, "Poisoned")

				script.Parent.Tool.Sprayer.Smoke.Enabled = true
				wait(1)
				script.Parent.Tool.Sprayer.Smoke.Enabled = false
			end
		end
		
	end
end)

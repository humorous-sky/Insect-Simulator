-- @ScriptType: LocalScript
function locate()
	local num_effects = #script.Parent:GetChildren() - 3
	local increment = (217 - 50)/ num_effects

	local count = 0
	for i, v in pairs(script.Parent:GetChildren()) do

		if v:IsA("Frame") then
			v.Position = UDim2.new(0, increment * count, 0, 0)
			count += 1
			v.ZIndex = i
		end
	end
end

script.Parent.ChildAdded:Connect(function(child : Frame?)
	child.run.Enabled = true
	locate()
end)

script.Parent.ChildRemoved:Connect(function(child : Frame?)
	locate()
end)
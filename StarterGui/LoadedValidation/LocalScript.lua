-- @ScriptType: LocalScript

function validate()
	while not game:GetService("Players").LocalPlayer.Character do task.wait() end
	
	local model = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("ObjectValue").Value
	
	if not model then return 0 end
	
	return #(model:GetDescendants())
end

script.Parent.OnClientInvoke = validate



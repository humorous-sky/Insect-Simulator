-- @ScriptType: LocalScript

function getPrefs()
	
	local loc : ScreenGui = script.Parent.Parent:WaitForChild("StartScreen")
	if loc:GetAttribute("SpawnLocation") == "" then return end
	

	return loc:GetAttributes()
	
end

script.Parent.OnClientInvoke = getPrefs



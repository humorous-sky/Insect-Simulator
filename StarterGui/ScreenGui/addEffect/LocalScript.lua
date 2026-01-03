-- @ScriptType: LocalScript

function addEffect(plr : Player, effect, dupe : boolean)

	if typeof(effect) == "string" then
		effect = game.ReplicatedStorage.Effects:FindFirstChild(effect):Clone()
	end
	
	local loc = plr.PlayerGui.ScreenGui.Effects

	if dupe or (not loc:FindFirstChild(effect.Name))then
		effect.Parent = loc
		--print("Added "..effect.Name)
		return true
	end
	
	return false
end

script.Parent.OnInvoke = addEffect

script.Parent.server.OnClientInvoke = addEffect

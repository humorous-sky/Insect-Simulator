-- @ScriptType: Script
function setProperty(callback, object : Instance, p : string, value)
	if p == "Parent" and value == nil then
		object:Destroy()
	else 
		object[p] = value
	end
end
script.Parent.OnServerEvent:Connect(setProperty)
script.Parent.unreliable.OnServerEvent:Connect(setProperty)
script.Parent.server.Event:Connect(function(o, p, v)
	setProperty(nil, o, p, v)
end)

-- @ScriptType: Script
local ts = game:GetService("TweenService")
function velocity(callback, part : BasePart, name : string, value : Vector3, force : Vector3)
	if part:FindFirstChild(name) then
		local bv : BodyVelocity = part:FindFirstChild(name)
		if value ~= nil then
			bv.Velocity = value
		else
			bv:Destroy()
		end		
	elseif value ~= nil then
		local bv : BodyVelocity = Instance.new("BodyVelocity")
		
		bv.Name = name

		bv.P = 10

		bv.Velocity = value

		bv.MaxForce = force

		bv.Parent = part
	end
end
script.Parent.OnServerEvent:Connect(velocity)
script.Parent.unreliable.OnServerEvent:Connect(velocity)
script.Parent.server.Event:Connect(function(p, n, v, f)
	velocity(nil, p, n, v, f)
end)

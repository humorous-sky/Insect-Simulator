-- @ScriptType: LocalScript
script.Parent.Parent.Bleed.Value += script.Parent:GetAttribute("Bleed")

wait(10)

script.Parent.Parent.Bleed.Value -= script.Parent:GetAttribute("Bleed")
script.Parent:Destroy()

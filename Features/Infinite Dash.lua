local tRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommE")


local namecall
namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local namecallmethod = getnamecallmethod()
    if self.Name == "CommE" and namecallmethod == "FireServer" then
        local Actions = {
            ["Dodge"] = true,
            ["DoubleJump"] = true
        }
        local Args = {...}
        print(Args[1])
        if Actions[Args[1]] then
            return
        end
    end
    return namecall(self, ...)
end)
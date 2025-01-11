print("Scanning for fruit..")
while task.wait() do
    local Fruit = workspace:FindFirstChildWhichIsA("Tool")
    if Fruit then
        print("Found:", Fruit.Name)
        local LocalPlayer = game.Players.LocalPlayer
        task.wait(0.204)
        repeat
            if LocalPlayer.Character then
                local RootPart = LocalPlayer.Character.Humanoid.RootPart
                firetouchinterest(RootPart, Fruit.Handle, 0)
                firetouchinterest(RootPart, Fruit.Handle, 1)
            end
            task.wait()
        until Fruit.Parent ~= workspace
        print("Got fruit?")
        break
    end
end
print("Done")
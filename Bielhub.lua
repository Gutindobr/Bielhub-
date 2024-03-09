local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character:WaitForChild("Humanoid")
local combat = character:WaitForChild("Combat")
local player = game.Players.LocalPlayer
local inventory = player:WaitForChild("Backpack")

-- Define a function to collect fruits on the map
local function collectFruits()
    -- Set a boolean variable to track if any fruits were collected
    local fruitsCollected = false

    -- Loop through all the objects in the game world
    for _, object in ipairs(game.Workspace:GetDescendants()) do
        -- Check if the object is a fruit
        if object.Name == "Fruit" then
            -- Set the fruitsCollected variable to true
            fruitsCollected = true

            -- Move the fruit to the player's inventory
            object:Clone().Parent = inventory

            -- Print a message to the screen
            print("Collected a " .. object.Parent.Name .. " fruit!")
        end
    end

    -- If no fruits were collected, print a message to the screen
    if not fruitsCollected then
        print("No fruits spawned")
    end
end

-- Define a function to store a fruit
local function storeFruit(fruit)
    -- Check if the player has a treasure inventory
    for _, child in pairs(inventory:GetChildren()) do
        if child.Name == "Treasure Inventory" then
            -- Check if the treasure inventory has space for the fruit
            if child.FruitSlot.Value < child.MaxFruits.Value then
                -- Move the fruit to the treasure inventory
                fruit:Clone().Parent = child.FruitSlot
                child.FruitSlot.Value = child.FruitSlot.Value + 1
                print("Stored a " .. fruit.Name)
                return true
            end
        end
    end

    -- If the player doesn't have a treasure inventory or it's full, print an error message
    print("Failed to store a " .. fruit.Name .. ". You need a treasure inventory with space for fruits.")
    return false
end

-- Define a function to unstore a fruit
local function unstoreFruit(fruitName)
    -- Check if the player has a treasure inventory with the fruit
    for _, child in pairs(inventory:GetChildren()) do
        if child.Name == "Treasure Inventory" then
            for i = 1, child.MaxFruits.Value do
                local fruit = child["FruitSlot" .. i]:FindFirstChild(fruitName)
                if fruit then
                    -- Move the fruit to the player's inventory
                    fruit:Clone().Parent = inventory
                    child["FruitSlot" .. i].Value = child["FruitSlot" .. i].Value - 1
                    print("Unstored a " .. fruitName)
                    return true
                end
            end
        end
    end

    -- If the player doesn't have the fruit in their treasure inventory, print an error message
    print("Failed to unstore a " .. fruitName .. ". You don't have that fruit in your treasure inventory.")
    return false
end

-- Example usage: collect fruits
collectFruits()

-- Example usage: store a random fruit
for _, fruit in pairs(game.Workspace:GetChildren()) do
    if fruit:IsA("Model") and fruit:FindFirstChild("Fruit") then
        if storeFruit(fruit) then
            break
        end
    end
end

-- Example usage: unstore a fruit
unstoreFruit("Flame Fruit")

-- Define a function to teleport to a chosen island
local function teleportToIsland(islandName, seaNumber)
    local sea = game.Workspace:WaitForChild("Sea" .. seaNumber)
    for _, island in pairs(sea:GetChildren()) do
        if island.Name == islandName then
            local player = game.Players.LocalPlayer
            player.Character.HumanoidRootPart.CFrame = island.PrimaryPart.CFrame
            break
        end
    end
end

-- Example usage: teleport to J

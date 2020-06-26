lp = game.Players.LocalPlayer
M = lp:GetMouse()
player_aura = false
npc_aura = false
tool = ""
aoe_size = 0

ui2 = Instance.new("ImageLabel")
bk = Instance.new("ImageLabel")
thing = Instance.new("TextLabel")

ui2.Name = "ui2"
ui2.Parent = game.CoreGui
ui2.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
ui2.BackgroundTransparency = 1.000
ui2.Position = UDim2.new(0, 0, 0.46, 0)
ui2.Size = UDim2.new(0.280533701, 0, 0.0455467626, 0)
ui2.ZIndex = 4
ui2.Image = "rbxassetid://4318718974"
ui2.ImageColor3 = Color3.fromRGB(192, 192, 192)
ui2.ScaleType = Enum.ScaleType.Slice
ui2.SliceCenter = Rect.new(40, 40, 160, 160)

bk.Name = "bk"
bk.Parent = ui2
bk.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
bk.BorderSizePixel = 0
bk.Size = UDim2.new(1, 0, 1, 0)
bk.ZIndex = 3
bk.Image = "rbxassetid://4318742890"
bk.ImageColor3 = Color3.fromRGB(0, 0, 0)
bk.ImageTransparency = 0.900
bk.ScaleType = Enum.ScaleType.Tile
bk.SliceCenter = Rect.new(12, 12, 88, 88)
bk.TileSize = UDim2.new(0, 30, 0, 30)

thing.Name = "thing"
thing.Parent = ui2
thing.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
thing.BackgroundTransparency = 1.000
thing.Position = UDim2.new(0.0258531645, 0, 0.159235984, 0)
thing.Size = UDim2.new(0.956567109, 0, 0.700638354, 0)
thing.ZIndex = 4
thing.Font = Enum.Font.Fantasy
thing.Text = "Player Kill Aura: OFF"
thing.TextColor3 = Color3.fromRGB(255, 255, 255)
thing.TextScaled = true
thing.TextSize = 14.000
thing.TextWrapped = true
thing.TextXAlignment = Enum.TextXAlignment.Left


uithing1 = ui2:Clone()
uithing1.Position = UDim2.new(0, 0, 0.46, 0)
uithing1.Parent = lp.PlayerGui.MainGui.UI.HUD.Anchor

uithing2 = ui2:Clone()
uithing2.Position = UDim2.new(0, 0, 0.41, 0)
uithing2.Parent = lp.PlayerGui.MainGui.UI.HUD.Anchor

uithing3 = ui2:Clone()
uithing3.Position = UDim2.new(0, 0, 0.36, 0)
uithing3.Parent = lp.PlayerGui.MainGui.UI.HUD.Anchor
uithing3.thing.Text = "Kill Aura Size: "..aoe_size


for i,v in pairs(lp.Backpack:GetChildren()) do
	if v.Name:find("Dagger") then
		tool = v.Name
	end
end


local function bind()
    lp.Character:WaitForChild("Humanoid").Died:Connect(function()
        player_aura = false
		npc_aura = false
		wait(game.Players.RespawnTime + 10)
		uithing1 = ui2:Clone()
		uithing1.Position = UDim2.new(0, 0, 0.46, 0)
		uithing1.Parent = lp.PlayerGui.MainGui.UI.HUD.Anchor

		uithing2 = ui2:Clone()
		uithing2.Position = UDim2.new(0, 0, 0.41, 0)
		uithing2.Parent = lp.PlayerGui.MainGui.UI.HUD.Anchor

		uithing3 = ui2:Clone()
		uithing3.Position = UDim2.new(0, 0, 0.36, 0)
		uithing3.Parent = lp.PlayerGui.MainGui.UI.HUD.Anchor
		uithing3.thing.Text = "Kill Aura Size: "..aoe_size
        bind()
    end)
end

bind()

M.KeyDown:connect(function(key)
    if key == "k" then
        if npc_aura == false then
        	wait()
        	npc_aura = true
        	uithing2.thing.Text = "NPC Kill Aura: ON"
        elseif npc_aura == true then
        	wait()
        	npc_aura = false
        	uithing2.thing.Text = "NPC Kill Aura: OFF"
        end
    end
    if key == "l" then
    	if player_aura == false then
    		wait()
    		player_aura = true
    		uithing1.thing.Text = "Player Kill Aura: ON"
    	elseif player_aura == true then
    		wait()
    		player_aura = false
    		uithing1.thing.Text = "Player Kill Aura: OFF"
    	end
    end
    if key == "n" then
    	if aoe_size < 200 then
    		aoe_size = aoe_size + 10
    		wait()
    		uithing3.thing.Text = "Kill Aura Size: "..aoe_size
    	end
    end
    if key == "m" then
    	if aoe_size > 0 then
    		aoe_size = aoe_size - 10
    		wait()
    		uithing3.thing.Text = "Kill Aura Size: "..aoe_size
    	end
    end
end)


while true do
    wait(0.025)

    --npc aura
    if npc_aura == true then
	    for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
	        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0.1 then
	            local mag = (lp.Character:FindFirstChild("HumanoidRootPart").Position - v.HumanoidRootPart.Position).Magnitude
	            if mag < aoe_size then

                    local args = {
                        [1] = lp.Character,
                        [2] = v,
                        [3] = lp.Character:FindFirstChild(tool) or lp.Backpack:FindFirstChild(tool),
                        [4] = "Throw",
                    }
                    
                    game:GetService("ReplicatedStorage").RS.Remotes.Combat.DealWeaponDamage:FireServer(unpack(args))

	            end
            end
        end
    end

    --player aura
    if player_aura == true then
    	for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
	        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0.1 then
	            local mag = (lp.Character:FindFirstChild("HumanoidRootPart").Position - v.HumanoidRootPart.Position).Magnitude
	            if mag < aoe_size then
	                
	                local args = {
                        [1] = lp.Character,
                        [2] = v,
                        [3] = lp.Character:FindFirstChild(tool) or lp.Backpack:FindFirstChild(tool),
                        [4] = "Throw",
                    }
                    
                    game:GetService("ReplicatedStorage").RS.Remotes.Combat.DealWeaponDamage:FireServer(unpack(args))

	            end
            end
        end
    end

end
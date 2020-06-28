--safe chest farm by K5RM#0208

local ts = game:GetService("TweenService")
local LP = game:GetService("Players").LocalPlayer
local root = LP.Character:FindFirstChild("HumanoidRootPart")
dist = 3000

LP.Character.Humanoid.PlatformStand = true

local fpart = Instance.new("Part",workspace)
fpart.Anchored = true
fpart.Transparency = 0.5
fpart.Size = Vector3.new(1,1,1)
fpart.CanCollide = false
fpart.CFrame = LP.Character.HumanoidRootPart.CFrame
fpart.Name = "fpart"

local bp = Instance.new("BodyPosition",LP.Character.HumanoidRootPart)
bp.D = 7500
bp.P = 1000000
bp.MaxForce = Vector3.new(400000,400000,400000)

bp.Position = fpart.Position

local function Tween(part, endpos, speed)
    if part and endpos then
        --
        local mageee = (root.Position - endpos).Magnitude
        if mageee > 70 then
            local setuppos_1 = Vector3.new(part.Position.X,101,part.Position.Z)
            local Time_1 = (setuppos_1 - part.Position).magnitude/speed
            local Info_1 = TweenInfo.new(Time_1, Enum.EasingStyle.Linear)
            local Tween_1 = ts:Create(part,Info_1,{CFrame = CFrame.new(part.Position.X,101,part.Position.Z)})
            Tween_1:Play()
            wait(Time_1)

            local setuppos_2 = Vector3.new(endpos.X,101,endpos.Z)
            local Time_2 = (setuppos_2 - part.Position).magnitude/speed
            local Info_2 = TweenInfo.new(Time_2, Enum.EasingStyle.Linear)
            local Tween_2 = ts:Create(part,Info_2,{CFrame = CFrame.new(endpos.X,101,endpos.Z)})
            Tween_2:Play()
            wait(Time_2)
        end

        local setuppos_3 = endpos.Y - 4
        local Time_3 = (endpos - part.Position).magnitude/speed
        local Info_3 = TweenInfo.new(Time_3, Enum.EasingStyle.Linear)
        local Tween_3 = ts:Create(part,Info_3,{CFrame = CFrame.new(endpos.X,setuppos_3,endpos.Z)})
        Tween_3:Play()
        wait(Time_3)
        --
    end
end

local function chest(root,part)
   Tween(root, part.Position, 70)
end

coroutine.resume(coroutine.create(function()
    game:GetService('RunService').Stepped:connect(function()
        if game.Workspace:FindFirstChild(LP.Name) then
            if LP.Character:FindFirstChildOfClass("Humanoid") then
                if LP.Character.Humanoid.Health > 30 then
                    bp.Position = fpart.Position
                    for _, child in pairs(LP.Character:GetDescendants()) do
                        if child:IsA("BasePart") and child.CanCollide == true then
                            child.CanCollide = false
                        end
                    end
                end
            end
        end
    end)
end))

local function bind()
    LP.Character:WaitForChild("Humanoid").Died:Connect(function()
        wait(game.Players.RespawnTime + 15)
        LP.Character.Humanoid.PlatformStand = true
        bp = Instance.new("BodyPosition",LP.Character.HumanoidRootPart)
        bp.D = 7500
        bp.P = 1000000
        bp.MaxForce = Vector3.new(400000,400000,400000)
        bind()
    end)
end

bind()

--closest chest finder
local function Find(arr)
    local POS = root.Position
    local bestpos = dist
    local bestpart = nil
    local CurrentDist = 0
    for i,v in pairs(arr) do
        if v:IsA("Model") and v.Name == "Chest" and v:FindFirstChild("Base") and not v:FindFirstChild("Open") and (POS - v.Base.Position).magnitude < bestpos then 
            bestpos = (POS - v.Base.Position).magnitude
            bestpart = v
        end
    end
    return bestpart
end


while wait(0.2) do

if game.Workspace:FindFirstChild(LP.Name) then
    if LP.Character:FindFirstChildOfClass("Humanoid") then
        if LP.Character.Humanoid.Health > 30 then

            local chests = game:GetService("Workspace").Map:GetDescendants()
            local BestPart = Find(chests)
            Object = BestPart

            chest(fpart,Object:FindFirstChild("Base"))

            wait(4)

            local args = {
                [1] = Object,
            }
                            
            game:GetService("ReplicatedStorage").RS.Remotes.Misc.OpenChest:FireServer(unpack(args))
            wait(0.1)
        end
    end
end

end

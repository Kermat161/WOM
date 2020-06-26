--original made by sinner#6660
--edited by K5RM#0208
--edits made Smoother movements, auto collect, slower to prevent anti cheat, noclip

local ts = game:GetService("TweenService")
local LP = game:GetService("Players").LocalPlayer
local root = LP.Character:FindFirstChild("HumanoidRootPart")

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
       local Time = (endpos - part.Position).magnitude/speed
       local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
       local Tween = ts:Create(part,Info,{CFrame = CFrame.new(endpos.X,endpos.Y,endpos.Z)})
       Tween:Play()
       wait(Time)
   end
end

local function chest(root,part)
   Tween(root, part.Position, 75)
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

game:GetService("RunService").RenderStepped:Wait()
wait(0.2)

game:GetService("RunService").RenderStepped:Wait()
if game.Workspace:FindFirstChild(LP.Name) then
    if LP.Character:FindFirstChildOfClass("Humanoid") then
        if LP.Character.Humanoid.Health > 30 then
            LP.Character:WaitForChild("Humanoid"):ChangeState(11)
                
            for i,v in pairs(game:GetService("Workspace").Map:GetDescendants()) do
                if v:IsA("Model") and v.Name == "Chest" and v:FindFirstChild("Base") and v.Base.Transparency < 0.01 then
                    chest(fpart,v:FindFirstChild("Base"))
                    wait(4)
                    local args = {
                        [1] = v,
                    }
                            
                    game:GetService("ReplicatedStorage").RS.Remotes.Misc.OpenChest:FireServer(unpack(args))
                end
            end
        end
    end
end
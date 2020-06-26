local Players = game:GetService("Players")
 local Client = Players.LocalPlayer
  local Character = Client.Character or Client.CharacterAdded:Wait()
   local WeldBase = Character:WaitForChild("HumanoidRootPart")
   local ArmBase = Character:FindFirstChild("UpperTorso") or Character:FindFirstChild("UpperTorso") or WeldBase
  local Backpack = Client:WaitForChild("Backpack")
  local Mouse = Client:GetMouse()
  local LP = game:GetService("Players").LocalPlayer
local Char = LP.Character
local Heartbeat = game:GetService("RunService").Heartbeat
local HRP = Char:WaitForChild("HumanoidRootPart")
local TweenService = game:GetService("TweenService")
local humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
local NetworkAccess = coroutine.create(function()
settings().Physics.AllowSleep = false
while true do game:GetService("RunService").RenderStepped:Wait()
for _,Players in next, game:GetService("Players"):GetChildren() do
if Players ~= game:GetService("Players").LocalPlayer then
Players.MaximumSimulationRadius = 0.1 Players.SimulationRadius = 0 end end
game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)
sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge*math.huge)
coroutine.resume(NetworkAccess)
 
local Camera = workspace.CurrentCamera
 
local VRService = game:GetService("VRService")
 local VRReady = VRService.VREnabled
 
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")   

local function GetExtraTool()
    for _, Tool in next, Character:GetChildren() do
        if Tool:IsA("Tool") and not Tool.Name:match("LIMB_TOOL") then
            return Tool
        end
    end
end
 
local function GetGripForHandle(Handle)
    for _, Weld in next, Character:GetDescendants() do
        if Weld:IsA("Weld") and (Weld.Part0 == Handle or Weld.Part1 == Handle) then
            return Weld
        end
    end
   
    wait(.2)
   
    for _, Weld in next, Character:GetDescendants() do
        if Weld:IsA("Weld") and (Weld.Part0 == Handle or Weld.Part1 == Handle) then
            return Weld
        end
    end
end
 
local function CreateRightGrip(Handle)
    local RightGrip = Instance.new("Weld")
   
    RightGrip.Name = "RightGrip"
    RightGrip.Part1 = Handle
    RightGrip.Part0 = WeldBase
    RightGrip.Parent = WeldBase
   
    return RightGrip
end

local TrackerArm = Instance.new("Part")
TrackerArm.Parent = game.Workspace
TrackerArm.Size = Vector3.new(1, 2, 1)
TrackerArm.Anchored = true
TrackerArm.CanCollide = false
TrackerArm.Transparency = 1

game.Players.LocalPlayer.Character.ChildAdded:Connect(function()
local EquippedTool = GetExtraTool()           
if EquippedTool and EquippedTool:FindFirstChild("Handle") then
game:GetService("RunService").Stepped:Connect(function()
if game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
TrackerArm.CFrame = game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso").CFrame
end
wait()
end)

		EquippedTool.Handle.CanCollide = false
        local refp = Instance.new("Part", TrackerArm)
        refp.Size = EquippedTool.Handle.Size
        refp.Transparency = 1
        refp.CanCollide = false
        refp.Massless = true
        refp.Material = "Neon"
        local refw = Instance.new("Weld", TrackerArm)
        refw.Part0 = TrackerArm
        refw.Part1 = refp
        refw.C0 = CFrame.new(0, -1, 0, 1, 0, -0, 0, 0, 1, 0, -1, -0)
        refw.C1 = EquippedTool.Grip
        wait(0.1)
               
        local ArmBaseCFrame = ArmBase.CFrame
        if ArmBase.Name == "UpperTorso" then
            ArmBaseCFrame = ArmBaseCFrame
        end
        print(EquippedTool.Name)

        local BP = Instance.new('BodyPosition', EquippedTool.Handle)
       
        BP.D = 100
        BP.P = 6000
        BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        
        local BG = Instance.new("BodyGyro", EquippedTool.Handle)
        BG.CFrame = refp.CFrame
        BG.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
        BG.D = 100
        BG.P = 20000
        
        repeat
        BP.Position = refp.Position
        BG.CFrame = refp.CFrame
        --EquippedTool.Handle.CanCollide = false
        game:GetService("RunService").Stepped:Wait()
        until EquippedTool.Parent ~= Character
        
        refp:Destroy()
        refw:Destroy()
        BP:Destroy()
        BG:Destroy()
        
        
    end
end)

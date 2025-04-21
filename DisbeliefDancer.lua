
do
local Accessories = {}
local Aligns = {}
local Attachments = {}
local BindableEvent = nil
local Blacklist = {}

local CFrame = CFrame
local CFrameidentity = CFrame.identity
local CFramelookAt = CFrame.lookAt
local CFramenew = CFrame.new

local Character = nil

local CurrentCamera = nil

local Enum = Enum
local Custom = Enum.CameraType.Custom
local Health = Enum.CoreGuiType.Health
local HumanoidRigType = Enum.HumanoidRigType
local R6 = HumanoidRigType.R6
local Dead = Enum.HumanoidStateType.Dead
local LockCenter = Enum.MouseBehavior.LockCenter
local MouseButton1 = Enum.UserInputType.MouseButton1

local Exceptions = {}

local game = game
local Clone = game.Clone
local Close = game.Close
local Connect = Close.Connect
local Disconnect = Connect(Close, function() end).Disconnect
local Wait = Close.Wait
local Destroy = game.Destroy
local FindFirstAncestorOfClass = game.FindFirstAncestorOfClass
local FindFirstAncestorWhichIsA = game.FindFirstAncestorWhichIsA
local FindFirstChild = game.FindFirstChild
local FindFirstChildOfClass = game.FindFirstChildOfClass
local Players = FindFirstChildOfClass(game, "Players")
local CreateHumanoidModelFromDescription = Players.CreateHumanoidModelFromDescription
local GetPlayers = Players.GetPlayers
local LocalPlayer = Players.LocalPlayer
local CharacterAdded = LocalPlayer.CharacterAdded
local ConnectDiedSignalBackend = LocalPlayer.ConnectDiedSignalBackend
local Mouse = LocalPlayer:GetMouse()
local Kill = LocalPlayer.Kill
local RunService = FindFirstChildOfClass(game, "RunService")
local PostSimulation = RunService.PostSimulation
local PreRender = RunService.PreRender
local PreSimulation = RunService.PreSimulation
local StarterGui = FindFirstChildOfClass(game, "StarterGui")
local GetCoreGuiEnabled = StarterGui.GetCoreGuiEnabled
local SetCore = StarterGui.SetCore
local SetCoreGuiEnabled = StarterGui.SetCoreGuiEnabled
local Workspace = FindFirstChildOfClass(game, "Workspace")
local FallenPartsDestroyHeight = Workspace.FallenPartsDestroyHeight
local HatDropY = FallenPartsDestroyHeight - 0.7
local FindFirstChildWhichIsA = game.FindFirstChildWhichIsA
local UserInputService = FindFirstChildOfClass(game, "UserInputService")
local InputBegan = UserInputService.InputBegan
local IsMouseButtonPressed = UserInputService.IsMouseButtonPressed
local GetChildren = game.GetChildren
local GetDescendants = game.GetDescendants
local GetPropertyChangedSignal = game.GetPropertyChangedSignal
local CurrentCameraChanged = GetPropertyChangedSignal(Workspace, "CurrentCamera")
local MouseBehaviorChanged = GetPropertyChangedSignal(UserInputService, "MouseBehavior")
local IsA = game.IsA
local IsDescendantOf = game.IsDescendantOf

local Highlights = {}

local Instancenew = Instance.new
local R15Animation = Instancenew("Animation")
local R6Animation = Instancenew("Animation")
local HumanoidDescription = Instancenew("HumanoidDescription")
local HumanoidModel = CreateHumanoidModelFromDescription(Players, HumanoidDescription, R6)
local R15HumanoidModel = CreateHumanoidModelFromDescription(Players, HumanoidDescription, HumanoidRigType.R15)
local SetAccessories = HumanoidDescription.SetAccessories
local ModelBreakJoints = HumanoidModel.BreakJoints
local Head = HumanoidModel.Head
local BasePartBreakJoints = Head.BreakJoints
local GetJoints = Head.GetJoints
local IsGrounded = Head.IsGrounded
local Humanoid = HumanoidModel.Humanoid
local ApplyDescription = Humanoid.ApplyDescription
local ChangeState = Humanoid.ChangeState
local EquipTool = Humanoid.EquipTool
local GetAppliedDescription = Humanoid.GetAppliedDescription
local GetPlayingAnimationTracks = Humanoid.GetPlayingAnimationTracks
local LoadAnimation = Humanoid.LoadAnimation
local Move = Humanoid.Move
local UnequipTools = Humanoid.UnequipTools
local ScaleTo = HumanoidModel.ScaleTo

local IsFirst = false
local IsHealthEnabled = nil
local IsLockCenter = false
local IsRegistered = false
local IsRunning = false

local LastTime = nil

local math = math
local mathrandom = math.random
local mathsin = math.sin

local nan = 0 / 0

local next = next

local OptionsAccessories = nil
local OptionsApplyDescription = nil
local OptionsBreakJointsDelay = nil
local OptionsClickFling = nil
local OptionsDisableCharacterCollisions = nil
local OptionsDisableHealthBar = nil
local OptionsDisableRigCollisions = nil
local OptionsDefaultFlingOptions = nil
local OptionsHatDrop = nil
local OptionsHideCharacter = nil
local OptionsParentCharacter = nil
local OptionsPermanentDeath = nil
local OptionsRefit = nil
local OptionsRigTransparency = nil
local OptionsSetCameraSubject = nil
local OptionsSetCameraType = nil
local OptionsSetCharacter = nil
local OptionsSetCollisionGroup = nil
local OptionsSimulationRadius = nil
local OptionsTeleportRadius = nil
local OptionsUseServerBreakJoints

local osclock = os.clock

local PreRenderConnection = nil

local RBXScriptConnections = {}

local Refitting = false

local replicatesignal = replicatesignal

local Rig = nil
local RigHumanoid = nil
local RigHumanoidRootPart = nil

local sethiddenproperty = sethiddenproperty
local setscriptable = setscriptable

local stringfind = string.find

local table = table
local tableclear = table.clear
local tablefind = table.find
local tableinsert = table.insert
local tableremove = table.remove

local Targets = {}

local task = task
local taskdefer = task.defer
local taskspawn = task.spawn
local taskwait = task.wait

local Time = nil

local Vector3 = Vector3
local Vector3new = Vector3.new
local FlingVelocity = Vector3new(16384, 16384, 16384)
local HatDropLinearVelocity = Vector3new(0, 27, 0)
local HideCharacterOffset = Vector3new(0, - 30, 0)
local Vector3one = Vector3.one
local Vector3xzAxis = Vector3new(1, 0, 1)
local Vector3zero = Vector3.zero
local AntiSleep = Vector3zero

R15Animation.AnimationId = "rbxassetid://507767968"
R6Animation.AnimationId = "rbxassetid://180436148"

Humanoid = nil

Destroy(HumanoidDescription)
HumanoidDescription = nil

local FindFirstChildOfClassAndName = function(Parent, ClassName, Name)
for Index, Child in next, GetChildren(Parent) do
if IsA(Child, ClassName) and Child.Name == Name then
return Child
end
end
end

local GetHandleFromTable = function(Table)
for Index, Child in GetChildren(Character) do
if IsA(Child, "Accoutrement") then
local Handle = FindFirstChildOfClassAndName(Child, "BasePart", "Handle")

if Handle then
local MeshId = nil
local TextureId = nil

if IsA(Handle, "MeshPart") then
MeshId = Handle.MeshId
TextureId = Handle.TextureID
else
local SpecialMesh = FindFirstChildOfClass(Handle, "SpecialMesh")

if SpecialMesh then
MeshId = SpecialMesh.MeshId
TextureId = SpecialMesh.TextureId
end
end

if MeshId then
if stringfind(MeshId, Table.MeshId) and stringfind(TextureId, Table.TextureId) then
return Handle
end
end
end
end
end
end

local NewIndex = function(self, Index, Value)
self[Index] = Value
end

local DescendantAdded = function(Descendant)
if IsA(Descendant, "Accoutrement") and OptionsHatDrop then
if not pcall(NewIndex, Descendant, "BackendAccoutrementState", 0) then
if sethiddenproperty then
sethiddenproperty(Descendant, "BackendAccoutrementState", 0)
elseif setscriptable then
setscriptable(Descendant, "BacekndAccoutrementState", true)
Descendant.BackendAccoutrementState = 0
end
end
elseif IsA(Descendant, "Attachment") then
local Attachment = Attachments[Descendant.Name]

if Attachment then
local Parent = Descendant.Parent

if IsA(Parent, "BasePart") then
local MeshId = nil
local TextureId = nil

if IsA(Parent, "MeshPart") then
MeshId = Parent.MeshId
TextureId = Parent.TextureID
else
local SpecialMesh = FindFirstChildOfClass(Parent, "SpecialMesh")

if SpecialMesh then
MeshId = SpecialMesh.MeshId
TextureId = SpecialMesh.TextureId
end
end

if MeshId then
for Index, Table in next, Accessories do
if Table.MeshId == MeshId and Table.TextureId == TextureId then
local Handle = Table.Handle

tableinsert(Aligns, {
LastPosition = Handle.Position,
Offset = CFrameidentity,
Part0 = Parent,
Part1 = Handle
})

return
end
end

for Index, Table in next, OptionsAccessories do
if stringfind(MeshId, Table.MeshId) and stringfind(TextureId, Table.TextureId) then
local Instance = nil
local TableName = Table.Name
local TableNames = Table.Names

if TableName then
Instance = FindFirstChildOfClassAndName(Rig, "BasePart", TableName)
else
for Index, TableName in next, TableNames do
local Child = FindFirstChildOfClassAndName(Rig, "BasePart", TableName)

if not ( TableNames[Index + 1] and Blacklist[Child] ) then
Instance = Child
break
end
end
end

if Instance then
local Blacklisted = Blacklist[Instance]

if not ( Blacklisted and Blacklisted.MeshId == MeshId and Blacklisted.TextureId == TextureId ) then
tableinsert(Aligns, {
Offset = Table.Offset,
Part0 = Parent,
Part1 = Instance
})

Blacklist[Instance] = { MeshId = MeshId, TextureId = TextureId }

return
end
end
end
end

local Accoutrement = FindFirstAncestorWhichIsA(Parent, "Accoutrement")

if Accoutrement and IsA(Accoutrement, "Accoutrement") then
local AccoutrementClone = Clone(Accoutrement)

local HandleClone = FindFirstChildOfClassAndName(AccoutrementClone, "BasePart", "Handle")
HandleClone.Transparency = OptionsRigTransparency

for Index, Descendant in next, GetDescendants(HandleClone) do
if IsA(Descendant, "JointInstance") then
Destroy(Descendant)
end
end

local AccessoryWeld = Instancenew("Weld")
AccessoryWeld.C0 = Descendant.CFrame
AccessoryWeld.C1 = Attachment.CFrame
AccessoryWeld.Name = "AccessoryWeld"
AccessoryWeld.Part0 = HandleClone
AccessoryWeld.Part1 = Attachment.Parent
AccessoryWeld.Parent = HandleClone

AccoutrementClone.Parent = Rig

tableinsert(Accessories, {
Handle = HandleClone,
MeshId = MeshId,
TextureId = TextureId
})
tableinsert(Aligns, {
Offset = CFrameidentity,
Part0 = Parent,
Part1 = HandleClone
})
end
end
end
end
end
end

local SetCameraSubject = function()
local CameraCFrame = CurrentCamera.CFrame
local Position = RigHumanoidRootPart.CFrame.Position

CurrentCamera.CameraSubject = RigHumanoid
Wait(PreRender)
CurrentCamera.CFrame = CameraCFrame + RigHumanoidRootPart.CFrame.Position - Position
end

local OnCameraSubjectChanged = function()
if CurrentCamera.CameraSubject ~= RigHumanoid then
taskdefer(SetCameraSubject)
end
end

local OnCameraTypeChanged = function()
if CurrentCamera.CameraType ~= Custom then
CurrentCamera.CameraType = Custom
end
end

local OnCurrentCameraChanged = function()
local Camera = Workspace.CurrentCamera

if Camera and OptionsSetCameraSubject then
CurrentCamera = Workspace.CurrentCamera

taskspawn(SetCameraSubject)

OnCameraSubjectChanged()
tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(CurrentCamera, "CameraSubject"), OnCameraSubjectChanged))

if OptionsSetCameraType then
OnCameraTypeChanged()
tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(CurrentCamera, "CameraType"), OnCameraTypeChanged))
end
end
end

local SetCharacter = function()
LocalPlayer.Character = Rig
end

local SetSimulationRadius = function()
LocalPlayer.SimulationRadius = OptionsSimulationRadius
end

local WaitForChildOfClass = function(Parent, ClassName)
local Child = FindFirstChildOfClass(Parent, ClassName)

while not Child do
Wait(Parent.ChildAdded)
Child = FindFirstChildOfClass(Parent, ClassName)
end

return Child
end

local WaitForChildOfClassAndName = function(Parent, ...)
local Child = FindFirstChildOfClassAndName(Parent, ...)

while not Child do
Wait(Parent.ChildAdded)
Child = FindFirstChildOfClassAndName(Parent, ...)
end

return Child
end

local Fling = function(Target, Options)
if Target then
local Highlight = Options.Highlight

if IsA(Target, "Humanoid") then
Target = Target.Parent
end
if IsA(Target, "Model") then
Target = FindFirstChildOfClassAndName(Target, "BasePart", "HumanoidRootPart") or FindFirstChildWhichIsA(Character, "BasePart")
end

if not tablefind(Targets, Target) and IsA(Target, "BasePart") and not Target.Anchored and not IsDescendantOf(Character, Target) and not IsDescendantOf(Rig, Target) then
local Model = FindFirstAncestorOfClass(Target, "Model")

if Model and FindFirstChildOfClass(Model, "Humanoid") then
Target = FindFirstChildOfClassAndName(Model, "BasePart", "HumanoidRootPart") or FindFirstChildWhichIsA(Character, "BasePart") or Target	
else
Model = Target
end

if Highlight then
local HighlightObject = type(Highlight) == "boolean" and Highlight and Instancenew("Highlight") or Clone(Highlight)
HighlightObject.Adornee = Model
HighlightObject.Parent = Model

Options.HighlightObject = HighlightObject
tableinsert(Highlights, HighlightObject)
end

Targets[Target] = Options

if not OptionsDefaultFlingOptions.HatFling and OptionsPermanentDeath and replicatesignal then
replicatesignal(ConnectDiedSignalBackend)
end
end
end
end

local OnCharacterAdded = function(NewCharacter)
if NewCharacter ~= Rig then
tableclear(Aligns)
tableclear(Blacklist)

Character = NewCharacter

if OptionsSetCameraSubject then
taskspawn(SetCameraSubject)
end

if OptionsSetCharacter then
taskdefer(SetCharacter)
end

if OptionsParentCharacter then
Character.Parent = Rig
end

for Index, Descendant in next, GetDescendants(Character) do
taskspawn(DescendantAdded, Descendant)
end

tableinsert(RBXScriptConnections, Connect(Character.DescendantAdded, DescendantAdded))

Humanoid = WaitForChildOfClass(Character, "Humanoid")
local HumanoidRootPart = WaitForChildOfClassAndName(Character, "BasePart", "HumanoidRootPart")

if IsFirst then
if OptionsApplyDescription and Humanoid then
local AppliedDescription = GetAppliedDescription(Humanoid)
SetAccessories(AppliedDescription, {}, true)
ApplyDescription(RigHumanoid, AppliedDescription)
end

if HumanoidRootPart then
RigHumanoidRootPart.CFrame = HumanoidRootPart.CFrame

if OptionsSetCollisionGroup then
local CollisionGroup = HumanoidRootPart.CollisionGroup

for Index, Descendant in next, GetDescendants(Rig) do
if IsA(Descendant, "BasePart") then
Descendant.CollisionGroup = CollisionGroup
end
end
end
end

IsFirst = false
end

local IsAlive = true

if HumanoidRootPart then
for Target, Options in next, Targets do
if IsDescendantOf(Target, Workspace) then
local FirstPosition = Target.Position
local PredictionFling = Options.PredictionFling
local LastPosition = FirstPosition
local Timeout = osclock() + Options.Timeout or 1

if HumanoidRootPart then
while IsDescendantOf(Target, Workspace) and osclock() < Timeout do
local DeltaTime = taskwait()
local Position = Target.Position

if ( Position - FirstPosition ).Magnitude > 100 then
break
end

local Offset = Vector3zero

if PredictionFling then
Offset = ( Position - LastPosition ) / DeltaTime * 0.13
end

HumanoidRootPart.AssemblyAngularVelocity = FlingVelocity
HumanoidRootPart.AssemblyLinearVelocity = FlingVelocity

HumanoidRootPart.CFrame = Target.CFrame + Offset
LastPosition = Position
end
end
end

local HighlightObject = Options.HighlightObject

if HighlightObject then
Destroy(HighlightObject)
end

Targets[Target] = nil
end

HumanoidRootPart.AssemblyAngularVelocity = Vector3zero
HumanoidRootPart.AssemblyLinearVelocity = Vector3zero

if OptionsHatDrop then
taskspawn(function()
WaitForChildOfClassAndName(Character, "LocalScript", "Animate").Enabled = false

for Index, AnimationTrack in next, GetPlayingAnimationTracks(Humanoid) do
AnimationTrack:Stop()
end

LoadAnimation(Humanoid, Humanoid.RigType == R6 and R6Animation or R15Animation):Play(0)

pcall(NewIndex, Workspace, "FallenPartsDestroyHeight", nan)

local RootPartCFrame = RigHumanoidRootPart.CFrame
RootPartCFrame = CFramenew(RootPartCFrame.X, HatDropY, RootPartCFrame.Z)

while IsAlive do
HumanoidRootPart.AssemblyAngularVelocity = Vector3zero
HumanoidRootPart.AssemblyLinearVelocity = HatDropLinearVelocity
HumanoidRootPart.CFrame = RootPartCFrame

taskwait()
end
end)
elseif OptionsHideCharacter then
local HideCharacterOffset = typeof(OptionsHideCharacter) == "Vector3" and OptionsHideCharacter or HideCharacterOffset
local RootPartCFrame = RigHumanoidRootPart.CFrame + HideCharacterOffset

taskspawn(function()
while IsAlive do
HumanoidRootPart.AssemblyAngularVelocity = Vector3zero
HumanoidRootPart.AssemblyLinearVelocity = Vector3zero
HumanoidRootPart.CFrame = RootPartCFrame

taskwait()
end
end)
elseif OptionsTeleportRadius then
HumanoidRootPart.CFrame = RigHumanoidRootPart.CFrame + Vector3new(mathrandom(- OptionsTeleportRadius, OptionsTeleportRadius), 0, mathrandom(- OptionsTeleportRadius, OptionsTeleportRadius))
end
end

if OptionsPermanentDeath and replicatesignal then
replicatesignal(ConnectDiedSignalBackend)

taskwait(Players.RespawnTime + 0.1)

Refitting = false
replicatesignal(Kill)
else
taskwait(OptionsBreakJointsDelay)
end

ModelBreakJoints(Character)

if Humanoid then
if replicatesignal and OptionsUseServerBreakJoints then
replicatesignal(Humanoid.ServerBreakJoints)
end

ChangeState(Humanoid, Dead)
Wait(Humanoid.Died)
end

IsAlive = false

if OptionsHatDrop then
pcall(NewIndex, Workspace, "FallenPartsDestroyHeight", FallenPartsDestroyHeight)
end
end
end

local OnInputBegan = function(InputObject)
if InputObject.UserInputType == MouseButton1 then
local Target = Mouse.Target

local HatFling = OptionsDefaultFlingOptions.HatFling
local ToolFling = OptionsDefaultFlingOptions.ToolFling

if HatFling and OptionsHatDrop then
local Part = type(HatFling) == "table" and GetHandleFromTable(HatFling)

if not Part then
for Index, Child in GetChildren(Character) do
if IsA(Child, "Accoutrement") then
local Handle = FindFirstChildOfClassAndName(Child, "BasePart", "Handle")

if Handle then
Part = Handle
break
end
end
end
end

if Part then
Exceptions[Part] = true

while IsMouseButtonPressed(UserInputService, MouseButton1) do
if Part.ReceiveAge == 0 then
Part.AssemblyAngularVelocity = FlingVelocity
Part.AssemblyLinearVelocity = FlingVelocity
Part.CFrame = Mouse.Hit + AntiSleep
end

taskwait()
end

Exceptions[Part] = false
end
elseif ToolFling then
local Backpack = FindFirstChildOfClass(LocalPlayer, "Backpack")
local Tool = nil

if type(ToolFling) == "string" then
Tool = FindFirstChild(Backpack, ToolFling) or FindFirstChild(Character, ToolFling)
end

if not Tool then
Tool = FindFirstChildOfClass(Backpack, "Tool") or FindFirstChildOfClass(Character, "Tool")
end

if Tool then
local Handle = FindFirstChildOfClassAndName(Tool, "BasePart", "Handle") or FindFirstChildWhichIsA(Tool, "BasePart")

if Handle then
UnequipTools(Humanoid)
taskwait()
EquipTool(Humanoid, Tool)

while IsMouseButtonPressed(UserInputService, MouseButton1) do
if Handle.ReceiveAge == 0 then
Handle.AssemblyAngularVelocity = FlingVelocity
Handle.AssemblyLinearVelocity = FlingVelocity
Handle.CFrame = Mouse.Hit + AntiSleep
end

taskwait()
end

UnequipTools(Humanoid)

Handle.AssemblyAngularVelocity = Vector3zero
Handle.AssemblyLinearVelocity = Vector3zero
Handle.CFrame = RigHumanoidRootPart.CFrame
end
end
else
Fling(Target, OptionsDefaultFlingOptions)
end
end
end

local OnPostSimulation = function()
Time = osclock()
local DeltaTime = Time - LastTime
LastTime = Time

if not OptionsSetCharacter and IsLockCenter then
local Position = RigHumanoidRootPart.Position
RigHumanoidRootPart.CFrame = CFramelookAt(Position, Position + CurrentCamera.CFrame.LookVector * Vector3xzAxis)
end

if OptionsSimulationRadius then
pcall(SetSimulationRadius)
end

AntiSleep = mathsin(Time * 15) * 0.0015 * Vector3one
local Axis = 27 + mathsin(Time)

for Index, Table in next, Aligns do
local Part0 = Table.Part0

if not Exceptions[Part0] then
if Part0.ReceiveAge == 0 then
if IsDescendantOf(Part0, Workspace) and not GetJoints(Part0)[1] and not IsGrounded(Part0) then
local Part1 = Table.Part1

Part0.AssemblyAngularVelocity = Vector3zero

local LinearVelocity = Part1.AssemblyLinearVelocity * Axis
Part0.AssemblyLinearVelocity = Vector3new(LinearVelocity.X, Axis, LinearVelocity.Z)

Part0.CFrame = Part1.CFrame * Table.Offset + AntiSleep
end
else
local Frames = Table.Frames or - 1
Frames = Frames + 1
Table.Frames = Frames

if Frames > 15 and OptionsPermanentDeath and OptionsRefit and replicatesignal then
Refitting = false
replicatesignal(ConnectDiedSignalBackend)
end
end
end
end

if not OptionsSetCharacter and Humanoid then
Move(RigHumanoid, Humanoid.MoveDirection)
RigHumanoid.Jump = Humanoid.Jump
end

--[[if IsRegistered then
SetCore(StarterGui, "ResetButtonCallback", BindableEvent)
else
IsRegistered = pcall(SetCore, StarterGui, "ResetButtonCallback", BindableEvent)
end]]
end

local OnPreRender = function()
local Position = RigHumanoidRootPart.Position
RigHumanoidRootPart.CFrame = CFramelookAt(Position, Position + CurrentCamera.CFrame.LookVector * Vector3xzAxis)

for Index, Table in next, Aligns do
local Part0 = Table.Part0

if Part0.ReceiveAge == 0 and IsDescendantOf(Part0, Workspace) and not GetJoints(Part0)[1] and not IsGrounded(Part0) then
Part0.CFrame = Table.Part1.CFrame * Table.Offset
end
end
end

local OnMouseBehaviorChanged = function()
IsLockCenter = UserInputService.MouseBehavior == LockCenter

if IsLockCenter then
PreRenderConnection = Connect(PreRender, OnPreRender)
tableinsert(RBXScriptConnections, PreRenderConnection)
elseif PreRenderConnection then
Disconnect(PreRenderConnection)
tableremove(RBXScriptConnections, tablefind(RBXScriptConnections, PreRenderConnection))
end
end

local OnPreSimulation = function()
if OptionsDisableCharacterCollisions and Character then
for Index, Descendant in next, GetDescendants(Character) do
if IsA(Descendant, "BasePart") then
Descendant.CanCollide = false
end
end
end
if OptionsDisableRigCollisions then
for Index, Descendant in next, GetChildren(Rig) do
if IsA(Descendant, "BasePart") then
Descendant.CanCollide = false
end
end
end
end

Start = function(Options)
if not IsRunning then
IsFirst = true
IsRunning = true

Options = Options or {}
OptionsAccessories = Options.Accessories or {}
OptionsApplyDescription = Options.ApplyDescription
OptionsBreakJointsDelay = Options.BreakJointsDelay or 0
OptionsClickFling = Options.ClickFling
OptionsDisableCharacterCollisions = Options.DisableCharacterCollisions
OptionsDisableHealthBar = Options.DisableHealthBar
OptionsDisableRigCollisions = Options.DisableRigCollisions
OptionsDefaultFlingOptions = Options.DefaultFlingOptions or {}
OptionsHatDrop = Options.HatDrop
OptionsHideCharacter = Options.HideCharacter
OptionsParentCharacter = Options.ParentCharacter
OptionsPermanentDeath = Options.PermanentDeath
OptionsRefit = Options.Refit
local OptionsRigSize = Options.RigSize
OptionsRigTransparency = Options.RigTransparency or 1
OptionsSetCameraSubject = Options.SetCameraSubject
OptionsSetCameraType = Options.SetCameraType
OptionsSetCharacter = Options.SetCharacter
OptionsSetCollisionGroup = Options.SetCollisionGroup
OptionsSimulationRadius = Options.SimulationRadius
OptionsTeleportRadius = Options.TeleportRadius
OptionsUseServerBreakJoints = Options.UseServerBreakJoints

if OptionsDisableHealthBar then
IsHealthEnabled = GetCoreGuiEnabled(StarterGui, Health)
SetCoreGuiEnabled(StarterGui, Health, false)
end

BindableEvent = Instancenew("BindableEvent")
tableinsert(RBXScriptConnections, Connect(BindableEvent.Event, Stop))

Rig = Options.R15 and Clone(R15HumanoidModel) or Clone(HumanoidModel)
Rig.Name = "non"
RigHumanoid = Rig.Humanoid
RigHumanoidRootPart = Rig.HumanoidRootPart
Rig.Parent = Workspace

for Index, Descendant in next, GetDescendants(Rig) do
if IsA(Descendant, "Attachment") then
Attachments[Descendant.Name] = Descendant
elseif IsA(Descendant, "BasePart") or IsA(Descendant, "Decal") then
Descendant.Transparency = OptionsRigTransparency
end
end

if OptionsRigSize then
ScaleTo(Rig, OptionsRigSize)

RigHumanoid.JumpPower = 50
RigHumanoid.WalkSpeed = 16
end

OnCurrentCameraChanged()
tableinsert(RBXScriptConnections, Connect(CurrentCameraChanged, OnCurrentCameraChanged))

if OptionsClickFling then
tableinsert(RBXScriptConnections, Connect(InputBegan, OnInputBegan))
end

local Character = LocalPlayer.Character

if Character then
OnCharacterAdded(Character)
end

tableinsert(RBXScriptConnections, Connect(CharacterAdded, OnCharacterAdded))

LastTime = osclock()
tableinsert(RBXScriptConnections, Connect(PostSimulation, OnPostSimulation))

if not OptionsSetCharacter then
OnMouseBehaviorChanged()
tableinsert(RBXScriptConnections, Connect(MouseBehaviorChanged, OnMouseBehaviorChanged))
end

if OptionsDisableCharacterCollisions or OptionsDisableRigCollisions then
OnPreSimulation()
tableinsert(RBXScriptConnections, Connect(PreSimulation, OnPreSimulation))
end

IsRegistered = pcall(SetCore, StarterGui, "ResetButtonCallback", BindableEvent)

if not IsRegistered then
taskspawn(function()
for Index = 1, 7 do
if not IsRegistered then
IsRegistered = pcall(SetCore, StarterGui, "ResetButtonCallback", BindableEvent)
taskwait()
else
break
end
end
end)
end

return {
BindableEvent = BindableEvent,
Fling = Fling,
Rig = Rig
}
end
end

Stop = function()
if IsRunning then
IsFirst = false
IsRunning = false

for Index, Highlight in Highlights do
Destroy(Highlight)
end

tableclear(Highlights)

for Index, RBXScriptConnection in next, RBXScriptConnections do
Disconnect(RBXScriptConnection)
end

tableclear(RBXScriptConnections)

Destroy(BindableEvent)

if Character.Parent == Rig then
Character.Parent = Workspace
end

if Humanoid then
ChangeState(Humanoid, Dead)
end

Destroy(Rig)

if OptionsPermanentDeath and replicatesignal then
replicatesignal(ConnectDiedSignalBackend)
end

if OptionsDisableHealthBar and not GetCoreGuiEnabled(StarterGui, Health) then
SetCoreGuiEnabled(StarterGui, Health, IsHealthEnabled)
end

if IsRegistered then
pcall(SetCore, StarterGui, "ResetButtonCallback", true)
else
IsRegistered = pcall(SetCore, StarterGui, "ResetButtonCallback", true)
end
end
end
end

Empyrean = Start({
Accessories = {
--{ MeshId = "", Name = "", Offset = CFrame.identity, TextureId = "" },
-- SB Rig
{ MeshId = "125443585075666", Name = "Torso", Offset = CFrame.Angles(0, 3.15, 0), TextureId = "121023324229475" },
{ MeshId = "121342985816617", Name = "Left Arm", Offset = CFrame.Angles(0, 0, 1.57), TextureId = "129264637819824" },
{ MeshId = "121342985816617", Name = "Right Arm", Offset = CFrame.Angles(0, 3.15, 1.57), TextureId = "129264637819824" },
{ MeshId = "83395427313429", Names = { "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "97148121718581" },--18641142410
-- Free Rig
{ MeshId = "4819720316", Name = "Torso", Offset = CFrame.Angles(0, 0, -0.25), TextureId = "4819722776" },
{ MeshId = "3030546036", Name = "Left Arm", Offset = CFrame.Angles(-1.57, 0, 1.57), TextureId = "3033903209" },
{ MeshId = "3030546036", Name = "Right Arm", Offset = CFrame.Angles(-1.57, 0, -1.57), TextureId = "3360978739" },
{ MeshId = "3030546036", Name = "Left Leg", Offset = CFrame.Angles(-1.57, 0, 1.57), TextureId = "3033898741" },
{ MeshId = "3030546036", Name = "Right Leg", Offset = CFrame.Angles(-1.57, 0, -1.57), TextureId = "3409604993" },
-- Prosthetics
{ MeshId = "117554824897780", Name = "Right Leg", Offset = CFrame.Angles(0, -1.57, 0), TextureId = "99077561039115" },
{ MeshId = "123388937940630", Name = "Left Leg", Offset = CFrame.Angles(0, 1.57, 0), TextureId = "99077561039115" },
{ MeshId = "117554824897780", Name = "Right Leg", Offset = CFrame.Angles(0, -1.57, 0), TextureId = "84429400539007" },
{ MeshId = "123388937940630", Name = "Left Leg", Offset = CFrame.Angles(0, 1.57, 0), TextureId = "84429400539007" },
-- Classic Cheap Rig
{ MeshId = "12344206657", Name = "Left Arm", Offset = CFrame.new(0.05, 0.05, -0.075) * CFrame.Angles(-2, 0, 0), TextureId = "12344206675" },
{ MeshId = "12344207333", Name = "Right Arm", Offset = CFrame.new(-0.05, 0.05, -0.075) * CFrame.Angles(-1.95, 0, 0), TextureId = "12344207341" },
{ MeshId = "11159370334", Name = "Left Leg", Offset = CFrame.Angles(1.57, 1.57, 0), TextureId = "11159284657" },
{ MeshId = "11263221350", Name = "Right Leg", Offset = CFrame.Angles(1.57, -1.57, 0), TextureId = "11263219250" },
-- Grey Mesh Rig 
{ MeshId = "127552124837034", Names = {"Torso"}, Offset = CFrame.Angles(0, 0, 0), TextureId = "131014325980101" },--14255556501
{ MeshId = "117287001096396", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 0), TextureId = "120169691545791" },--14255556501
{ MeshId = "121304376791439", Names = { "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 0), TextureId = "131014325980101" },--18641142410
-- offsale below
-- Classical Products rig (white/black arms)
{ MeshId = "110684113028749", Names = {"Torso"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "70661572547971" },
{ MeshId = "125405780718494", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "136752500636691" },
{ MeshId = "125405780718494", Names = { "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "136752500636691" },
{ MeshId = "14255522247", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14255543546" },
-- Noob Rig
{ MeshId = "18640899369", Name = "Torso", Offset = CFrame.Angles(0, 0, 0), TextureId = "18640899481" },
{ MeshId = "18640914129", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 0), TextureId = "18640914168" },
{ MeshId = "18640901641", Names = { "Left Leg", "Right Leg"}, Offset = CFrame.Angles(0, 0, 0), TextureId = "18640901676" },
-- request
{ MeshId = "14768666349", Name = "Torso", Offset = CFrame.Angles(0, 0, 0), TextureId = "14768664565" },
{ MeshId = "14768684979", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14768683674" },

},
ApplyDescription = true,
BreakJointsDelay = _G.Settings["BreakJointsDelay"],
ClickFling = _G.Settings["ClickFling"],
DefaultFlingOptions = {
HatFling = _G.Fling["UseAHat"],
Highlight = _G.Fling["HighlightTargets"],
PredictionFling = _G.Fling["PredictionFling"],
Timeout = _G.Fling["Timeout"],
ToolFling = _G.Fling["UseATool"],
},
DisableCharacterCollisions = true,
DisableHealthBar = true,
DisableRigCollisions = true,
HatDrop = _G.Settings["HatDrop"],
HideCharacter = Vector3.new(0, -50, 0),
ParentCharacter = true,
PermanentDeath = _G.Settings["PermanentDeath"],
Refit = _G.Settings["Refit"],
RigSize = 1,
RigTransparency = 1,
R15 = false,
SetCameraSubject = true,
SetCameraType = true,
SetCharacter = false,
SetCollisionGroup = true,
SimulationRadius = 2147483647,
TeleportRadius = 12,
UseServerBreakJoints = _G.Settings["ServerBreakJoints"],
})


local Character = Empyrean.Rig
local humanoid = Character:FindFirstChildOfClass("Humanoid")
local RootPart = Character.HumanoidRootPart
local TorsoVelocity,TorsoVerticalVelocity = Vector3.new(),Vector3.new().Y
local Jumped,Falled,Idled,Walked = false,false,false,false

local AnimatorModule = {}
local function Contains(Table, Check)
for Index, Value in next, Table do 
if rawequal(Check, Index) or rawequal(Check, Value) then 
return true
end
end
return false
end

local AnimDefaults = {
["Neck"] = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
["RootJoint"] = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
["Right Shoulder"] = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
["Left Shoulder"] = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
["Right Hip"] = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
["Left Hip"] = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
["Head"] = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
["Torso"] = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
["Right Arm"] = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
["Left Arm"] = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
["Right Leg"] = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
["Left Leg"] = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
}

local function Edit(Joint, Change, Duration, Style, Direction)
if not Style or not table.find(Enum.EasingStyle:GetEnumItems(), Style) then
Style = Enum.EasingStyle.Cubic
end
Direction = Enum.EasingDirection[string.split(tostring(Direction), ".")[3]]
local Anim = game:GetService("TweenService"):Create(Joint, TweenInfo.new(Duration, Style, Direction), {C0 = Change})
Anim:Play()
return Anim
end

function AnimatorModule:ResetJoints(Rig)
local RigHumanoid = Rig:FindFirstChildOfClass("Humanoid")
assert(RigHumanoid:IsA("Humanoid"), "Rig Humanoid Missing!")
if not RigHumanoid.RigType == Enum.HumanoidRigType.R6 then
return error("Rig Humanoid is not R6!")
end
local Joints = {
["Torso"] = Rig.HumanoidRootPart:FindFirstChild("RootJoint") or Rig.HumanoidRootPart:FindFirstChild("Root Joint"),
["Left Arm"] = Rig.Torso["Left Shoulder"],
["Right Arm"] = Rig.Torso["Right Shoulder"],
["Left Leg"] = Rig.Torso["Left Hip"],
["Right Leg"] = Rig.Torso["Right Hip"],
["Head"] = Rig.Torso["Neck"],
}
for Limb, Joint in next, Joints do
Edit(Joint, AnimDefaults[Limb], 0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
end
end

function AnimatorModule:LoadAnimation(Rig, KeyframeSequence)
local Sequence = KeyframeSequence
assert(Sequence:IsA("KeyframeSequence"), "KeyframeSequence Missing!")
local RigHumanoid = Rig:FindFirstChildOfClass("Humanoid")
assert(RigHumanoid:IsA("Humanoid"), "Rig Humanoid Missing!")
if not RigHumanoid.RigType == Enum.HumanoidRigType.R6 then
return error("Rig Humanoid is not R6!")
end
local Joints = {
["Torso"] = Rig.HumanoidRootPart:FindFirstChild("RootJoint") or Rig.HumanoidRootPart:FindFirstChild("Root Joint"),
["Left Arm"] = Rig.Torso["Left Shoulder"],
["Right Arm"] = Rig.Torso["Right Shoulder"],
["Left Leg"] = Rig.Torso["Left Hip"],
["Right Leg"] = Rig.Torso["Right Hip"],
["Head"] = Rig.Torso["Neck"],
}
local Class = {}
Class.Speed = 1
Class.KeepLast = 0
local Keyframes = Sequence:GetKeyframes()
table.sort(Keyframes, function(a, b) return a.Time < b.Time end) -- Thanks 10k_i, roblox not sorting by default.
Class.Length = Keyframes[#(Keyframes)].Time
local Yield = function(Seconds)
local Time = Seconds * (60 + Class.Length)
for i = 1, Time, Class.Speed do 
game:GetService("RunService").Heartbeat:Wait()
end
end
if Sequence:FindFirstChild("xSIXxNull", true) or Sequence:FindFirstChild("xSIXxCustomDir", true) or Sequence:FindFirstChild("xSIXxCustomStyle", true) then -- Moon Suite Fix
local Children = Sequence:GetChildren()
for i = 1, #(Children) do
if Children[i]:FindFirstChild("Torso") then
local Limbs = Children[i].Torso:GetChildren()
for l = 1, #(Limbs) do
Limbs[l].Parent = Children[i].HumanoidRootPart.Torso
end
Children[i].Torso:Destroy()
end
end
end
local Descendants = Sequence:GetDescendants()
for i = 1, #(Descendants) do
if Descendants[i]:IsA("IntValue") or Descendants[i]:IsA("StringValue") or Descendants[i]:IsA("Folder") then
Descendants[i]:Destroy()
end
if Descendants[i].Parent ~= Sequence and Descendants[i]:IsA("Pose") and not Rig:FindFirstChild(Descendants[i].Name, true) then
Descendants[i]:Destroy()
end
end
Class.Stopped = true
Class.IsPlaying = false
Class.TimePosition = 0
Class.Looped = Sequence.Loop
local Completion = Instance.new("BindableEvent")
local Reached = Instance.new("BindableEvent")
Class.Completed = Completion.Event
Class.KeyframeReached = Reached.Event
Class["Play"] = function(self, FadeIn, Speed)
if Speed and Speed < 0 then
Speed += (Speed*2)
end
Class.Speed = Speed or 180
Class.Stopped = false
Class.IsPlaying = true
task.spawn(function()
wait(1/60)
if FadeIn ~= nil then
Class.TimePosition -= FadeIn
end
Class.Completed:Connect(function()
if Class.Looped ~= false then
Class.TimePosition = 0
end
end)
repeat game:GetService("RunService").Heartbeat:Wait()
Class.TimePosition += (1 * Class.Speed) / (60 * Class.Speed) 
until Class.IsPlaying == false or Class.Stopped ~= false or RigHumanoid.Health == 0
end)
task.spawn(function()
if FadeIn ~= nil then
task.wait(1/55)
task.spawn(function()
local Frames = Keyframes[1]:GetDescendants()
for i = 1, #(Frames) do 
local Pose = Frames[i]
if Contains(Joints, Pose.Name) then 
task.spawn(function()
for i = 1, 2 do
Edit(Joints[Pose.Name], AnimDefaults[Pose.Name] * Pose.CFrame, FadeIn, Pose.EasingStyle, Pose.EasingDirection)
task.wait()
end
end)
end
end
end)
Yield(FadeIn)
end
repeat
for K = 1, #(Keyframes) do 
local K0, K1, K2 = Keyframes[K-1], Keyframes[K], Keyframes[K+1]
if Class.Stopped ~= true and RigHumanoid.Health ~= 0 then
if K0 ~= nil then 
Yield(K1.Time - K0.Time)
end
task.spawn(function()
for i = 1, #(K1:GetDescendants()) do 
local Pose = K1:GetDescendants()[i]
if Contains(Joints, Pose.Name) then 
local Duration = K2 ~= nil and (K2.Time - K1.Time) / Class.Speed or 0.5
Edit(Joints[Pose.Name], AnimDefaults[Pose.Name] * Pose.CFrame, Duration, Pose.EasingStyle, Pose.EasingDirection)
end
end
end)
if K == #(Keyframes) and Class.KeepLast > 0 then
Yield(Class.KeepLast)
end
Reached:Fire(K1.Name)
else
break
end
end
Completion:Fire()
until Class.Looped ~= true or Class.Stopped ~= false or RigHumanoid.Health == 0
Class.IsPlaying = false
end)
end
Class["Stop"] = function()
Class.Stopped = true
end
Class["AdjustSpeed"] = function(self, Speed)
if Speed < 0 then
Speed += (Speed*2)
end
Class.Speed = Speed or Class.Speed
end
return Class
end

function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

function LoadAnim(Rig, KeyFrameS)
if not AnimatorModule[Rig] then
AnimatorModule[Rig] = {}
end
AnimatorModule[Rig][KeyFrameS.Name] = AnimatorModule:LoadAnimation(Rig, KeyFrameS)
end

function PlayAnim(Rig, Animation, AnimFade, AnimSpeed)
if not AnimatorModule[Rig] then
AnimatorModule[Rig] = {}
end
if not AnimatorModule[Rig][Animation.Name] then
AnimatorModule[Rig][Animation.Name] = AnimatorModule:LoadAnimation(Rig, Animation)
end
for Animation, Track in next, AnimatorModule[Rig] do
if Animation ~= Animation.Name then
Track:Stop()
end
end
if not AnimatorModule[Rig][Animation.Name].IsPlaying then
AnimatorModule[Rig][Animation.Name]:Play(AnimFade or 1, AnimSpeed or 1)
end
end

function StopAnim(Rig, Anim)
if not AnimatorModule[Rig] then
AnimatorModule[Rig] = {}
end
if not AnimatorModule[Rig][Anim.Name] then
AnimatorModule[Rig][Anim.Name] = AnimatorModule:LoadAnimation(Rig, Anim)
end
AnimatorModule[Rig][Anim.Name]:Stop()
end

local Anims = Instance.new("Folder")

function CreateAnimation(Name, ID)
task.wait(0.10)
local New = game:GetObjects("rbxassetid://"..ID)[1]
New.Parent = Anims
New.Name = Name
end

CreateAnimation("Idle", 136078657506707)
CreateAnimation("Walk", 130213485744288)
CreateAnimation("Jump", 84397577392351)
CreateAnimation("Fall", 90270295182351)


if game.CoreGui:FindFirstChild("FluxLib") then
game.CoreGui:FindFirstChild("FluxLib"):Destroy()
else
end

local Lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()
local GUI = Lib:Window("Disbelief Hub", "Irony at its finest.", Color3.fromRGB(0, 0, 0), Enum.KeyCode.LeftControl)
local DancesA = GUI:Tab("Animations - R6 Dances", "http://www.roblox.com/asset/?id=6023426915")
CreateAnimation("Appendum", 77926650795117)
DancesA:Button("Appendum", "Appendum", function()
PlayAnim(Character, Anims.Appendum, 0, 1)
end)
CreateAnimation("Attitude", 129169655004423)
DancesA:Button("Attitude", "Attitude", function()
PlayAnim(Character, Anims.Attitude, 0, 1)
end)

DancesA:Line()

CreateAnimation("BHop", 82234401429055)
DancesA:Button("BHop", "BHop", function()
PlayAnim(Character, Anims.BHop, 0, 1)
end)
CreateAnimation("Bill", 120460931637912)
DancesA:Button("Bill", "Bill", function()
PlayAnim(Character, Anims.Bill, 0, 1)
end)
CreateAnimation("BillieJean", 108805310510119)
DancesA:Button("Billie Jean", "Billie Jean", function()
PlayAnim(Character, Anims.BillieJean, 0, 1)
end)
CreateAnimation("BillyBounce", 125962207089467)
DancesA:Button("Billy Bounce", "Billy Bounce", function()
PlayAnim(Character, Anims.BillyBounce, 0, 1)
end)
CreateAnimation("BitCrushing", 135845625327739)
DancesA:Button("Bit Crushing", "Bit Crushing", function()
PlayAnim(Character, Anims.BitCrushing, 0, 1)
end)
CreateAnimation("BlackAndYellow", 132028118802766)
DancesA:Button("Black & Yellow", "Black & Yellow", function()
PlayAnim(Character, Anims.BlackAndYellow, 0, 1)
end)
CreateAnimation("BlindingLights", 83245497290837)
DancesA:Button("Blinding Lights", "Blinding Lights", function()
PlayAnim(Character, Anims.BlindingLights, 0, 1)
end)
CreateAnimation("BloodPop", 132026285699359)
DancesA:Button("BloodPop", "BloodPop", function()
PlayAnim(Character, Anims.BloodPop, 0, 1)
end)
CreateAnimation("BombMonkey", 75616586799217)
DancesA:Button("Bomb Monkey", "Bomb Monkey", function()
PlayAnim(Character, Anims.BombMonkey, 0, 1)
end)
CreateAnimation("Boogie", 125356421399032)
DancesA:Button("Boogie", "Boogie", function()
PlayAnim(Character, Anims.Boogie, 0, 1)
end)
CreateAnimation("BoogieBomb", 114817849347144)
DancesA:Button("Boogie Bomb", "Boogie Bomb", function()
PlayAnim(Character, Anims.BoogieBomb, 0, 1)
end)
CreateAnimation("BoogieDown", 77558722177080)
DancesA:Button("Boogie Down", "Boogie Down", function()
PlayAnim(Character, Anims.BoogieDown, 0, 0.85)
end)
CreateAnimation("Boomin", 135207682507735)
DancesA:Button("Boomin", "Boomin", function()
PlayAnim(Character, Anims.Boomin, 0, 1)
end)
CreateAnimation("BoxSwing", 75405139558088)
DancesA:Button("Box Swing", "Box Swing", function()
PlayAnim(Character, Anims.BoxSwing, 0, 0.75)
end)
CreateAnimation("BreakDance", 132886479585903)
DancesA:Button("Break Dance", "Break Dance", function()
PlayAnim(Character, Anims.BreakDance, 0, 1)
end)
CreateAnimation("BreakDance2005", 131296257768627)
DancesA:Button("Break Dance 2005", "Break Dance 2005", function()
PlayAnim(Character, Anims.BreakDance2005, 0, 1)
end)
CreateAnimation("BreakDown", 100568904650591)
DancesA:Button("Break Down", "Break Down", function()
PlayAnim(Character, Anims.BreakDown, 0, 1)
end)
CreateAnimation("Breakin", 131155721688011)
DancesA:Button("Breakin", "Breakin", function()
PlayAnim(Character, Anims.Breakin, 0, 1)
end)
CreateAnimation("BulletDodgeBallet", 98779400840597)
DancesA:Button("Bullet Dodge Ballet", "Bullet Dodge Ballet", function()
PlayAnim(Character, Anims.BulletDodgeBallet, 0, 1)
end)

DancesA:Line()

CreateAnimation("Calamity", 102026644002108)
DancesA:Button("Calamity", "Calamity", function()
PlayAnim(Character, Anims.Calamity, 0, 1)
end)
CreateAnimation("Caramelldansen", 103597509139287)
DancesA:Button("Caramelldansen", "Caramelldansen", function()
PlayAnim(Character, Anims.Caramelldansen, 0, 1)
end)
CreateAnimation("ChaseMe", 118311613925473)
DancesA:Button("Chase Me", "Chase Me", function()
PlayAnim(Character, Anims.ChaseMe, 0, 1)
end)
CreateAnimation("Check", 132280062505986)
DancesA:Button("Check", "Check", function()
PlayAnim(Character, Anims.Check, 0, 1)
end)
CreateAnimation("ChickenDinner", 100643285137768)
DancesA:Button("Chicken Dinner", "ChickenDinner", function()
PlayAnim(Character, Anims.ChickenDinner, 0, 1)
end)
CreateAnimation("ClubPenguin", 89761302048916)
DancesA:Button("Club Penguin", "Club Penguin", function()
PlayAnim(Character, Anims.ClubPenguin, 0, 1)
end)
CreateAnimation("Colossal", 93170660505618)
DancesA:Button("Colossal", "Colossal", function()
PlayAnim(Character, Anims.Calamity, 0, 1)
end)
CreateAnimation("CompanyJig", 116614992219971)
DancesA:Button("Company Jig", "Company Jig", function()
PlayAnim(Character, Anims.CompanyJig, 0, 1)
end)
CreateAnimation("Conga", 115557579308566)
DancesA:Button("Conga", "Conga", function()
PlayAnim(Character, Anims.Conga, 0, 1)
end)
CreateAnimation("ContinentalDrift", 105174222033892)
DancesA:Button("Continental Drift", "Continental Drift", function()
PlayAnim(Character, Anims.ContinentalDrift, 0, 1)
end)
CreateAnimation("CrackDown", 133188222109902)
DancesA:Button("Crack Down", "Crack Down", function()
PlayAnim(Character, Anims.CrackDown, 0, 1)
end)
CreateAnimation("CrankDat", 139148388599834)
DancesA:Button("Crank Dat", "Crank Dat", function()
PlayAnim(Character, Anims.CrankDat, 0, 1)
end)
CreateAnimation("CrissCrossToprock", 73116243097694)
DancesA:Button("Criss Cross Toprock", "Criss Cross Toprock", function()
PlayAnim(Character, Anims.CrissCrossToprock, 0, 1)
end)
CreateAnimation("CyberBop", 129655276640546)
DancesA:Button("Cyber Bop", "Cyber Bop", function()
PlayAnim(Character, Anims.CyberBop, 0, 1)
end)
CreateAnimation("CupCakes", 117125226382337)
DancesA:Button("CupCakes", "CupCakes", function()
PlayAnim(Character, Anims.CupCakes, 0, 1)
end)

DancesA:Line()

CreateAnimation("DirectionDirective", 100131309856257)
DancesA:Button("Direction Directive", "Direction Directive", function()
PlayAnim(Character, Anims.DirectionDirective, 0, 1)
end)
CreateAnimation("Domino", 126683576461381)
DancesA:Button("Domino", "Domino", function()
PlayAnim(Character, Anims.Domino, 0, 0.75)
end)
CreateAnimation("Doodle", 90069083924245)
DancesA:Button("Doodle", "Doodle", function()
PlayAnim(Character, Anims.Doodle, 0, 0.75)
end)
CreateAnimation("DoomMCBringer", 123386245117713)
DancesA:Button("Doom MCBringer", "Doom MCBringer", function()
PlayAnim(Character, Anims.DoomMCBringer, 0, 1)
end)
CreateAnimation("DoubleStep", 138112012258643)
DancesA:Button("Double Step", "Double Step", function()
PlayAnim(Character, Anims.DoubleStep, 0, 1)
end)
CreateAnimation("DowntownFunk", 103059790868580)
DancesA:Button("Downtown Funk", "Downtown Funk", function()
PlayAnim(Character, Anims.DowntownFunk, 0, 1)
end)
CreateAnimation("DragonDance", 75687257387850)
DancesA:Button("Dragon Dance", "Dragon Dance", function()
PlayAnim(Character, Anims.DragonDance, 0, 0.75)
end)
CreateAnimation("Drip", 100177280567649)
DancesA:Button("Drip", "Drip", function()
PlayAnim(Character, Anims.Drip, 0, 0.75)
end)
CreateAnimation("DrumMajor", 116369780386936)
DancesA:Button("Drum Major", "Drum Major", function()
PlayAnim(Character, Anims.DrumMajor, 0, 1)
end)
CreateAnimation("DynamicShuffle", 78337295886429)
DancesA:Button("Dynamic Shuffle", "Dynamic Shuffle", function()
PlayAnim(Character, Anims.DynamicShuffle, 0, 1)
end)

DancesA:Line()

CreateAnimation("ElectroShuffle", 136684924748195)
DancesA:Button("Electro Shuffle", "Electro Shuffle", function()
PlayAnim(Character, Anims.ElectroShuffle, 0, 1)
end)
CreateAnimation("ElectroSwing", 93684150668786)
DancesA:Button("Electro Swing", "Electro Swing", function()
PlayAnim(Character, Anims.ElectroSwing, 0, 1)
end)
CreateAnimation("Entranced", 131726076631029)
DancesA:Button("Entranced", "Entranced", function()
PlayAnim(Character, Anims.Entranced, 0, 1)
end)

DancesA:Line()

CreateAnimation("Fein", 115727639577589)
DancesA:Button("Fein", "Fein", function()
PlayAnim(Character, Anims.Fein, 0, 1)
end)
CreateAnimation("Flamenco", 112606613683393)
DancesA:Button("Flamenco", "Flamenco", function()
PlayAnim(Character, Anims.Fein, 0, 1)
end)
CreateAnimation("Flapper", 123373225244443)
DancesA:Button("Flapper", "Flapper", function()
PlayAnim(Character, Anims.Flapper, 0, 1)
end)
CreateAnimation("Floss", 107287295776925)
DancesA:Button("Floss", "Floss", function()
PlayAnim(Character, Anims.Floss, 0, 1)
end)
CreateAnimation("FlyDance", 125627676172807)
DancesA:Button("Fly Dance", "Fly Dance", function()
PlayAnim(Character, Anims.FlyDance, 0, 1)
end)
CreateAnimation("FreeFlow", 101564911432113)
DancesA:Button("Free Flow", "Free Flow", function()
PlayAnim(Character, Anims.FreeFlow, 0, 1)
end)
CreateAnimation("FridayNight", 91741353599946)
DancesA:Button("Friday Night", "Friday Night", function()
PlayAnim(Character, Anims.FridayNight, 0, 1)
end)
CreateAnimation("FridayFunk", 70835462045983)
DancesA:Button("Friday Funk", "Friday Funk", function()
PlayAnim(Character, Anims.FridayFunk, 0, 1)
end)
CreateAnimation("FrozenPizza", 78457500452351)
DancesA:Button("Frozen Pizza", "Frozen Pizza", function()
PlayAnim(Character, Anims.FrozenPizza, 0, 1)
end)
CreateAnimation("FunkyJig", 104720694407943)
DancesA:Button("Funky Jig", "Funky Jig", function()
PlayAnim(Character, Anims.FunkyJig, 0, 1)
end)

DancesA:Line()

CreateAnimation("GangnamStyle", 109451974680631)
DancesA:Button("Gangnam Style", "Gangnam Style", function()
PlayAnim(Character, Anims.GangnamStyle, 0, 1)
end)
CreateAnimation("GarrysDance", 102655274160157)
DancesA:Button("Garrys Dance", "Garrys Dance", function()
PlayAnim(Character, Anims.GarrysDance, 0, 1)
end)
CreateAnimation("GetSturdy", 77773358394206)
DancesA:Button("Get Sturdy", "Get Sturdy", function()
PlayAnim(Character, Anims.GetSturdy, 0, 1)
end)
CreateAnimation("GetToTheTop", 93228901518812)
DancesA:Button("Get To The Top", "Get To The Top", function()
PlayAnim(Character, Anims.GetToTheTop, 0, 1)
end)
CreateAnimation("GoatSimulator", 129327004786530)
DancesA:Button("Goat Simulator", "Goat Simulator", function()
PlayAnim(Character, Anims.GoatSimulator, 0, 1)
end)
CreateAnimation("Groovy", 88997109090699)
DancesA:Button("Groovy", "Groovy", function()
PlayAnim(Character, Anims.Groovy, 0, 1)
end)

DancesA:Line()

CreateAnimation("HanSolo", 84236497616039)
DancesA:Button("Han Solo", "Han Solo", function()
PlayAnim(Character, Anims.HanSolo, 0, 1)
end)
CreateAnimation("HeeltoeHop", 98256622649150)
DancesA:Button("Heeltoe Hop", "Heeltoe Hop", function()
PlayAnim(Character, Anims.HeeltoeHop, 0, 1)
end)
CreateAnimation("HeeltoeToprock", 140670228658366)
DancesA:Button("Heeltoe Toprock", "Heeltoe Toprock", function()
PlayAnim(Character, Anims.HeeltoeToprock, 0, 1)
end)
CreateAnimation("HiphopHero", 129871001094710)
DancesA:Button("Hiphop Hero", "Hiphop Hero", function()
PlayAnim(Character, Anims.HiphopHero, 0, 1)
end)
CreateAnimation("HipShop", 103112841595182)
DancesA:Button("Hip Shop", "Hip Shop", function()
PlayAnim(Character, Anims.HipShop, 0, 1)
end)
CreateAnimation("Holiday", 85998810156809)
DancesA:Button("Holiday", "Holiday", function()
PlayAnim(Character, Anims.Holiday, 0, 1)
end)

DancesA:Line()

CreateAnimation("Infectious", 103230323718650)
DancesA:Button("Infectious", "Infectious", function()
PlayAnim(Character, Anims.Infectious, 0, 1)
end)
CreateAnimation("Insanity", 139483347792972)
DancesA:Button("Insanity", "Insanity", function()
PlayAnim(Character, Anims.Insanity, 0, 1)
end)
CreateAnimation("ItsComplicated", 78717948152747)
DancesA:Button("Its Complicated", "Its Complicated", function()
PlayAnim(Character, Anims.ItsComplicated, 0, 1)
end)

DancesA:Line()

CreateAnimation("JayWalking", 107833895457998)
DancesA:Button("Jay Walking", "Jay Walking", function()
PlayAnim(Character, Anims.JayWalking, 0, 0.85)
end)
CreateAnimation("Jive", 133324659811186)
DancesA:Button("Jive", "Jive", function()
PlayAnim(Character, Anims.Jive, 0, 0.75)
end)
CreateAnimation("JumpStyle", 115620519702324)
DancesA:Button("Jump Style", "Jump Style", function()
PlayAnim(Character, Anims.JumpStyle, 0, 0.75)
end)
CreateAnimation("JumpingJacks", 86279418149917)
DancesA:Button("Jumping Jacks", "Jumping Jacks", function()
PlayAnim(Character, Anims.JumpingJacks, 0, 1)
end)
CreateAnimation("JungJustice", 71723925114737)
DancesA:Button("Jung Justice", "Jung Justice", function()
PlayAnim(Character, Anims.JungJustice, 0, 1)
end)

DancesA:Line()

CreateAnimation("Kalyx", 137738597810830)
DancesA:Button("Kalyx", "Kalyx", function()
PlayAnim(Character, Anims.Kalyx, 0, 1)
end)
CreateAnimation("KazotskyKick", 114036336168567)
DancesA:Button("Kazotsky Kick", "Kazotsky Kick", function()
PlayAnim(Character, Anims.KazotskyKick, 0, 1)
end)
CreateAnimation("KeepUp", 84765927391240)
DancesA:Button("Keep Up", "Keep Up", function()
PlayAnim(Character, Anims.KeepUp, 0, 0.65)
end)
CreateAnimation("Kombonk", 88519824673842)
DancesA:Button("Kombonk", "Kombonk", function()
PlayAnim(Character, Anims.Kombonk, 0, 0.75)
end)
CreateAnimation("KrabBorg", 84670621089927)
DancesA:Button("KrabBorg", "KrabBorg", function()
PlayAnim(Character, Anims.KrabBorg, 0, 1)
end)

DancesA:Line()

CreateAnimation("Lagtrain", 80764093560475)
DancesA:Button("Lagtrain", "Lagtrain", function()
PlayAnim(Character, Anims.Lagtrain, 0, 1)
end)
CreateAnimation("LegalReasons", 78083829137149)
DancesA:Button("Legal Reasons", "Legal Reasons", function()
PlayAnim(Character, Anims.LegalReasons, 0, 1)
end)
CreateAnimation("LetsGroove", 109923692577857)
DancesA:Button("Lets Groove", "Lets Groove", function()
PlayAnim(Character, Anims.LetsGroove, 0, 1)
end)
CreateAnimation("LittleBig", 78546390232203)
DancesA:Button("Little Big", "Little Big", function()
PlayAnim(Character, Anims.LittleBig, 0, 1)
end)
CreateAnimation("LofiHeadbang", 84024656726416)
DancesA:Button("Lofi Headbang", "Lofi Headbang", function()
PlayAnim(Character, Anims.LofiHeadbang, 0, 1)
end)
CreateAnimation("LoveHate", 118446506171691)
DancesA:Button("LoveHate", "LoveHate", function()
PlayAnim(Character, Anims.LoveHate, 0, 1)
end)

DancesA:Line()

CreateAnimation("Magnetic", 91594002186875)
DancesA:Button("Magnetic", "Magnetic", function()
PlayAnim(Character, Anims.Magnetic, 0, 1)
end)
CreateAnimation("MannRobics", 137456359844967)
DancesA:Button("MannRobics", "MannRobics", function()
PlayAnim(Character, Anims.MannRobics, 0, 1)
end)
CreateAnimation("MaxEffort", 108526381474779)
DancesA:Button("Max Effort", "Max Effort", function()
PlayAnim(Character, Anims.MaxEffort, 0, 1)
end)
CreateAnimation("Miku", 82171050414030)
DancesA:Button("Miku", "Miku", function()
PlayAnim(Character, Anims.Miku, 0, 1)
end)
CreateAnimation("Million", 109123683211464)
DancesA:Button("Million", "Million", function()
PlayAnim(Character, Anims.Million, 0, 1)
end)
CreateAnimation("Mirage", 108895956412207)
DancesA:Button("Mirage", "Mirage", function()
PlayAnim(Character, Anims.Mirage, 0, 1)
end)
CreateAnimation("MischievFunction", 100305033962391)
DancesA:Button("Mischiev Function", "Mischiev Function", function()
PlayAnim(Character, Anims.MischievFunction, 0, 0.95)
end)

DancesA:Line()

CreateAnimation("Neo", 100305033962391)
DancesA:Button("Neo", "Neo", function()
PlayAnim(Character, Anims.Neo, 0, 1)
end)
CreateAnimation("Nerdy", 136250600208499)
DancesA:Button("Nerdy", "Nerdy", function()
PlayAnim(Character, Anims.Nerdy, 0, 1)
end)
CreateAnimation("NewDonk", 111542909088526)
DancesA:Button("NewDonk", "NewDonk", function()
PlayAnim(Character, Anims.NewDonk, 0, 1)
end)
CreateAnimation("NewJackSwingin", 113494131456426)
DancesA:Button("New Jack Swingin", "New Jack Swingin", function()
PlayAnim(Character, Anims.NewJackSwingin, 0, 1)
end)

DancesA:Line()

CreateAnimation("Oddloop", 95650849617284)
DancesA:Button("Oddloop", "Oddloop", function()
PlayAnim(Character, Anims.Oddloop, 0, 1)
end)
CreateAnimation("OktoberAid", 127865309658292)
DancesA:Button("OktoberAid", "OktoberAid", function()
PlayAnim(Character, Anims.OktoberAid, 0, 1)
end)
CreateAnimation("OldSchool", 115558885277292)
DancesA:Button("Old School", "Old School", function()
PlayAnim(Character, Anims.OldSchool, 0, 1)
end)
CreateAnimation("Outlaw", 79048566727283)
DancesA:Button("Outlaw", "Outlaw", function()
PlayAnim(Character, Anims.Outlaw, 0, 1)
end)
CreateAnimation("OverDrive", 118789281098407)
DancesA:Button("Over Drive", "Over Drive", function()
PlayAnim(Character, Anims.OverDrive, 0, 1)
end)

DancesA:Line()

CreateAnimation("PonPon", 109617660580282)
DancesA:Button("PonPon", "PonPon", function()
PlayAnim(Character, Anims.PonPon, 0, 1)
end)
CreateAnimation("PartyHouse", 113030438875320)
DancesA:Button("Party House", "Party House", function()
PlayAnim(Character, Anims.PartyHouse, 0, 1)
end)
CreateAnimation("PeanutButter", 85717017003584)
DancesA:Button("Peanut Butter", "Peanut Butter", function()
PlayAnim(Character, Anims.PeanutButter, 0, 1)
end)
CreateAnimation("PickItUp", 106248669913767)
DancesA:Button("Pick It Up", "Pick It Up", function()
PlayAnim(Character, Anims.PickItUp, 0, 1)
end) 
CreateAnimation("PoPiPo", 115465103089127)
DancesA:Button("PoPiPo", "PoPiPo", function()
PlayAnim(Character, Anims.PoPiPo, 0, 1)
end) 
CreateAnimation("Pogo", 109001339891602)
DancesA:Button("Pogo", "Pogo", function()
PlayAnim(Character, Anims.Pogo, 0, 1)
end) 
CreateAnimation("PopAndLock", 113869158054586)
DancesA:Button("Pop & Lock", "Pop & Lock", function()
PlayAnim(Character, Anims.PopAndLock, 0, 1)
end) 
CreateAnimation("PopLock", 83789802032942)
DancesA:Button("Pop Lock", "Pop Lock", function()
PlayAnim(Character, Anims.PopLock, 0, 1)
end) 
CreateAnimation("PrinceOfEgpyt", 95986135548450)
DancesA:Button("Prince Of Egpyt", "Prince Of Egpyt", function()
PlayAnim(Character, Anims.PrinceOfEgpyt, 0, 1)
end) 
CreateAnimation("Professional", 117672863086140)
DancesA:Button("Professional", "Professional", function()
PlayAnim(Character, Anims.Professional, 0, 1)
end) 

DancesA:Line()

CreateAnimation("RainCheck", 104145748528942)
DancesA:Button("Rain Check", "Rain Check", function()
PlayAnim(Character, Anims.RainCheck, 0, 1)
end) 
CreateAnimation("Reanimated", 135638372997121)
DancesA:Button("Reanimated", "Reanimated", function()
PlayAnim(Character, Anims.Reanimated, 0, 1)
end) 
CreateAnimation("Reflex", 104246452023047)
DancesA:Button("Reflex", "Reflex", function()
PlayAnim(Character, Anims.Reflex, 0, 1)
end) 
CreateAnimation("RejectStep", 79440368381920)
DancesA:Button("Reject Step", "Reject Step", function()
PlayAnim(Character, Anims.RejectStep, 0, 1)
end) 
CreateAnimation("Rewind", 85595451831140)
DancesA:Button("Rewind", "Rewind", function()
PlayAnim(Character, Anims.Rewind, 0, 1)
end) 
CreateAnimation("RicFlair", 77103786363593)
DancesA:Button("Ric Flair", "Ric Flair", function()
PlayAnim(Character, Anims.RicFlair, 0, 1)
end) 
CreateAnimation("RidinIt", 110739557877639)
DancesA:Button("Ridin It", "Ridin It", function()
PlayAnim(Character, Anims.RidinIt, 0, 1)
end) 
CreateAnimation("Rodeo", 139177767291866)
DancesA:Button("Rodeo", "Rodeo", function()
PlayAnim(Character, Anims.Rodeo, 0, 1)
end) 
CreateAnimation("RoyalAngst", 101917046845862)
DancesA:Button("Royal Angst", "Royal Angst", function()
PlayAnim(Character, Anims.RoyalAngst, 0, 1)
end) 
CreateAnimation("RunningInTerror", 82063943309833)
DancesA:Button("Running In Terror", "Running In Terror", function()
PlayAnim(Character, Anims.RunningInTerror, 0, 1)
end) 

DancesA:Line()

CreateAnimation("Scenario", 105424478944256)
DancesA:Button("Scenario", "Scenario", function()
PlayAnim(Character, Anims.Scenario, 0, 1)
end) 
CreateAnimation("SickoMode", 82639898531456)
DancesA:Button("Sicko Mode", "Sicko Mode", function()
PlayAnim(Character, Anims.SickoMode, 0, 1)
end) 
CreateAnimation("SideShuffle", 106696831887022)
DancesA:Button("Side Shuffle", "Side Shuffle", function()
PlayAnim(Character, Anims.SideShuffle, 0, 1)
end) 
CreateAnimation("Sidestep", 118256299900662)
DancesA:Button("Sidestep", "Sidestep", function()
PlayAnim(Character, Anims.Sidestep, 0, 1)
end) 
CreateAnimation("Slick", 112642355788128)
DancesA:Button("Slick", "Slick", function()
PlayAnim(Character, Anims.Slick, 0, 1)
end) 
CreateAnimation("SlowDown", 96225967263351)
DancesA:Button("Slow Down", "Slow Down", function()
PlayAnim(Character, Anims.SlowDown, 0, 1)
end) 
CreateAnimation("SmoothSlide", 95051030054364)
DancesA:Button("Smooth Slide", "Smooth Slide", function()
PlayAnim(Character, Anims.SmoothSlide, 0, 1)
end) 
CreateAnimation("SoarAbove", 92031051557681)
DancesA:Button("Soar Above", "Soar Above", function()
PlayAnim(Character, Anims.SoarAbove, 0, 0.75)
end) 
CreateAnimation("SpongeBob", 107928348961439)
DancesA:Button("SpongeBob", "SpongeBob", function()
PlayAnim(Character, Anims.SpongeBob, 0, 0.75)
end) 
CreateAnimation("SpringLoaded", 126001082682364)
DancesA:Button("SpringLoaded", "SpringLoaded", function()
PlayAnim(Character, Anims.SpringLoaded, 0, 1)
end) 
CreateAnimation("Springy", 96915228320599)
DancesA:Button("Springy", "Springy", function()
PlayAnim(Character, Anims.Springy, 0, 1)
end) 
CreateAnimation("SquashAndStretch", 82430103452187)
DancesA:Button("Squash & Stretch", "Squash & Stretch", function()
PlayAnim(Character, Anims.SquashAndStretch, 0, 1)
end) 
CreateAnimation("StockShuffle", 86067433847393)
DancesA:Button("Stock Shuffle", "Stock Shuffle", function()
PlayAnim(Character, Anims.StockShuffle, 0, 1)
end)

DancesA:Line()

CreateAnimation("TaiChi", 139334740822475)
DancesA:Button("Tai Chi", "Tai Chi", function()
PlayAnim(Character, Anims.TaiChi, 0, 1)
end) 
CreateAnimation("TexasHoedown", 130942516783083)
DancesA:Button("Texas Hoedown", "Texas Hoedown", function()
PlayAnim(Character, Anims.TexasHoedown, 0, 1)
end) 
CreateAnimation("TheFlop", 122878040721056)
DancesA:Button("The Flop", "The Flop", function()
PlayAnim(Character, Anims.TheFlop, 0, 1)
end) 
CreateAnimation("TheMD", 103541609182057)
DancesA:Button("The MD", "The MD", function()
PlayAnim(Character, Anims.TheMD, 0, 1)
end) 
CreateAnimation("TheRoll", 70422527184550)
DancesA:Button("The Roll", "The Roll", function()
PlayAnim(Character, Anims.TheRoll, 0, 1)
end) 
CreateAnimation("Thriller", 101170440834154)
DancesA:Button("Thriller", "Thriller", function()
PlayAnim(Character, Anims.Thriller, 0, 1)
end) 
CreateAnimation("TooMuchBrain", 71228444263749)
DancesA:Button("Too Much Brain", "Too Much Brain", function()
PlayAnim(Character, Anims.TooMuchBrain, 0, 1)
end) 
CreateAnimation("TootseeRoll", 102931874666964)
DancesA:Button("Tootsee Roll", "Tootsee Roll", function()
PlayAnim(Character, Anims.TootseeRoll, 0, 1)
end) 
CreateAnimation("TopRocking", 116248187570378)
DancesA:Button("Top Rocking", "Top Rocking", function()
PlayAnim(Character, Anims.TopRocking, 0, 1)
end) 
CreateAnimation("TrueHeart", 139400505188520)
DancesA:Button("True Heart", "True Heart", function()
PlayAnim(Character, Anims.TrueHeart, 0, 1)
end) 
CreateAnimation("TurntUp", 95604282742916)
DancesA:Button("Turnt Up", "Turnt Up", function()
PlayAnim(Character, Anims.TurntUp, 0, 1)
end)

DancesA:Line()

CreateAnimation("VictorySway", 118331988473361)
DancesA:Button("Victory Sway", "Victory Sway", function()
PlayAnim(Character, Anims.VictorySway, 0, 1)
end)

DancesA:Line()

CreateAnimation("WalkOfPride", 137503210275698)
DancesA:Button("Walk Of Pride", "Walk Of Pride", function()
PlayAnim(Character, Anims.WalkOfPride, 0, 1)
end)
CreateAnimation("Wednesday", 93029240528390)
DancesA:Button("Wednesday", "Wednesday", function()
PlayAnim(Character, Anims.Wednesday, 0, 1)
end)
CreateAnimation("WellRounded", 93832203745642)
DancesA:Button("Well Rounded", "Well Rounded", function()
PlayAnim(Character, Anims.WellRounded, 0, 1)
end)
CreateAnimation("WorkIt", 140046429691095)
DancesA:Button("Work It", "Work It", function()
PlayAnim(Character, Anims.WorkIt, 0, 1)
end)

DancesA:Line()

CreateAnimation("XO", 73559770055600)
DancesA:Button("XO", "XO", function()
PlayAnim(Character, Anims.XO, 0, 1)
end)

DancesA:Line()

CreateAnimation("ZomBeat", 130481163326164)
DancesA:Button("ZomBeat", "ZomBeat", function()
PlayAnim(Character, Anims.ZomBeat, 0, 1)
end)


game:GetService("RunService").Heartbeat:Connect(function()
for i,v in pairs(Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
v:Stop(0)
end
local HitFloor,HitPosition = Raycast(RootPart.Position, (CFrame.new(RootPart.Position, RootPart.Position + Vector3.new(0, -1, 0))).LookVector, 4, Character)
TorsoVelocity = (RootPart.Velocity).Magnitude
TorsoVerticalVelocity = RootPart.Velocity.Y
if TorsoVerticalVelocity > 1 and HitFloor == nil then
if Jumped == false then
Jumped = true
PlayAnim(Character, Anims.Jump, 0.1, 1)
end
Falled = false
Idled = false
Walked = false
StopAnim(Character, Anims.Fall)
StopAnim(Character, Anims.Idle)
StopAnim(Character, Anims.Walk)
elseif TorsoVerticalVelocity < 1 and HitFloor == nil then
if Falled == false then
Falled = true
PlayAnim(Character, Anims.Fall, 0.1, 1)
end		
Jumped = false
Idled = false
Walked = false
StopAnim(Character, Anims.Jump)
StopAnim(Character, Anims.Idle)
StopAnim(Character, Anims.Walk)
elseif TorsoVelocity < 1 and HitFloor ~= nil then
if Idled == false then
Idled = true
PlayAnim(Character, Anims.Idle, 0.1, 0.1)
end
Jumped = false
Falled = false
Walked = false
StopAnim(Character, Anims.Jump)
StopAnim(Character, Anims.Fall)
StopAnim(Character, Anims.Walk)
elseif TorsoVelocity > 1 and HitFloor ~= nil then
if Walked == false then
Walked = true
PlayAnim(Character, Anims.Walk,0.1,1)
end
Jumped = false
Falled = false
Idled = false
StopAnim(Character, Anims.Jump)
StopAnim(Character, Anims.Fall)
StopAnim(Character, Anims.Idle)
end
end)
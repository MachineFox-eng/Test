
Reanimate = getgenv().Framework
local Character = nil

if Reanimate == "Hatless" then
local Hatless = loadstring(game:HttpGet("https://raw.githubusercontent.com/MelonsStuff/DisbeliefHub/refs/heads/main/Reanimate/Hatless.lua"))()
Character = Hatless.FakeCharacter
elseif getgenv().Framework == "Krypton" then
KryptonConfiguration = {
WaitTime = 0.251,
FakeRigScale = 1,
DestroyHeightOffset = 50,
TeleportOffsetRadius = 20,
RefitHatCount = 2,
RigName = "Tetris",
ReturnOnDeath = true,
Reclaim = false,
Refit = true,
SetCharacter = true,
Animations = true,
NoCollisions = true,
AntiVoiding = false,
SetSimulationRadius = true,
DisableCharacterScripts = true,
AccessoryFallbackDefaults = true,
OverlayFakeCharacter = false,
LimitHatsPerLimb = false,
NoBodyNearby = true,
PermanentDeath = true,
Hats = {
["Torso"] = {
{ MeshId = "110684113028749", Names = {"Torso"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "70661572547971" },
{Texture = "70661572547971q", Mesh = "110684113028749q", Name = "MeshPartAccessory", Offset = CFrame.Angles(0, 0, -0.25)},
{Texture = "70661572547971", Mesh = "110684113028749", Name = "Black", Offset = CFrame.Angles(0, 0, 0)},
{Texture = "70661572547971q", Mesh = "110684113028749q", Name = "Accessory (Toorso)", Offset = CFrame.Angles(0, 0, 0)},
{ MeshId = "110684113028749", Names = {"Torso"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "70661572547971" },
{ MeshId = "125405780718494", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "136752500636691" },
{ MeshId = "125405780718494", Names = { "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "136752500636691" },
{ MeshId = "14255522247", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14255543546" },
},
["Right Arm"] = {
{Texture = "129264637819824", Mesh = "121342985816617", Name = "Accessory (SnakeRight)", Offset = CFrame.Angles(0, 3.15, 1.57)},
{Texture = "3409604993", Mesh = "3030546036", Name = "InternationalFedora", Offset = CFrame.Angles(-1.57, 0, -1.57)},
{Texture = "12344206675", Mesh = "12344206657", Name = "Extra Right hand (Blocky)_white", Offset = CFrame.new(-0.05, 0.05, -0.075) * CFrame.Angles(-1.95, 0, 0)},
{Texture = "136752500636691", Mesh = "125405780718494", Name = "RArm", Offset = CFrame.Angles(0, 0, 1.57)},
{Texture = "17374768001", Mesh = "17374767929", Name = "Accessory (RARM)", Offset = CFrame.Angles(0, 0, 1.57)},
{Texture = "120169691545791", Mesh = "117287001096396", Name = "Accessory (RARM)", Offset = CFrame.Angles(0, 0, 0)},
},
["Left Arm"] = {
{Texture = "129264637819824", Mesh = "121342985816617", Name = "Accessory (SnakeLeft)", Offset = CFrame.Angles(0, 0, 1.57)},
{Texture = "3033903209", Mesh = "3030546036", Name = "InternationalFedora", Offset = CFrame.Angles(-1.57, 0, 1.57)},
{Texture = "12344207341", Mesh = "12344207333", Name = "Extra Left hand (Blocky)_white", Offset = CFrame.new(-0.05, 0.05, -0.075) * CFrame.Angles(-1.95, 0, 0)},
{Texture = "14255543546", Mesh = "14255522247", Name = "LARM", Offset = CFrame.Angles(0, 0, 1.57)},
{Texture = "17374768001", Mesh = "17374767929", Name = "Accessory (LARM)", Offset = CFrame.Angles(0, 0, 1.57)},
{Texture = "120169691545791", Mesh = "117287001096396", Name = "Accessory (LARM)", Offset = CFrame.Angles(0, 0, 0)},
},
["Right Leg"] = {
{Texture = "3033898741", Mesh = "3030546036", Name = "InternationalFedora", Offset = CFrame.Angles(-1.57, 0, -1.57)},
{Texture = "17387586304", Mesh = "17387586286", Name = "Accessory (LLeg)", Offset = CFrame.Angles(0, 0, 1.57)},
{Texture = "11263219250", Mesh = "11263221350", Name = "MeshPartAccessory", Offset = CFrame.Angles(0, 0, 1.57)},
{Texture = "131014325980101", Mesh = "121304376791439", Name = "Accessory (LeftLeg)", Offset = CFrame.Angles(0, 0, 0)},
{Texture = "84429400539007", Mesh = "123388937940630", Name = "Accessory (LeftShoulder)", Offset = CFrame.Angles(0, 1.57, 0)},
},
["Left Leg"] = {
{Texture = "3360978739", Mesh = "3030546036", Name = "InternationalFedora", Offset = CFrame.Angles(-1.57, 0, 1.57)},
{Texture = "17387586304", Mesh = "17387586286", Name = "Accessory (rightleg)", Offset = CFrame.Angles(0, 1.57, 1.57)},
{Texture = "11159284657", Mesh = "11159370334", Name = "Unloaded head", Offset = CFrame.Angles(0, 1.57, 1.57)},
{Texture = "131014325980101", Mesh = "121304376791439", Name = "Accessory (RightLeg)", Offset = CFrame.Angles(0, 0, 0)},
{Texture = "84429400539007", Mesh = "117554824897780", Name = "Accessory (RightShoulder)", Offset = CFrame.Angles(0, -1.57, 0)},
},
},
}
local Reanimate = loadstring(game:HttpGet("https://raw.githubusercontent.com/KadeTheExploiter/Krypton/main/Module.luau"))()
Character = Reanimate:GetCharacter()
elseif Reanimate == "Emperyean" then
local Reanimate = loadstring(game:HttpGet("https://raw.githubusercontent.com/MelonsStuff/DisbeliefHub/refs/heads/main/Reanimate/Empyrean.lua"))()
Reanimate.Start({
Accessories = {
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
{ MeshId = "14241018198", Names = {"Torso"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14251599953" },
{ MeshId = "17374767929", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "17374768001" },
{ MeshId = "17387586286", Names = { "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "17387586304" },
{ MeshId = "14255522247", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14255543546" },
-- Noob Rig
{ MeshId = "18640899369", Name = "Torso", Offset = CFrame.Angles(0, 0, 0), TextureId = "18640899481" },
{ MeshId = "18640914129", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 0), TextureId = "18640914168" },
{ MeshId = "18640901641", Names = { "Left Leg", "Right Leg"}, Offset = CFrame.Angles(0, 0, 0), TextureId = "18640901676" },
-- request
{ MeshId = "14768666349", Name = "Torso", Offset = CFrame.Angles(0, 0, 0), TextureId = "14768664565" },

{ MeshId = "14768684979", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14768683674" },
{ MeshId = "137702817952968", Names = { "Left Arm", "Right Arm", "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "135650240593878" },--84451219120140
{ MeshId = "137702817952968", Names = { "Left Arm", "Right Arm", "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "135650240593878" },--72292903231768
{ MeshId = "137702817952968", Names = { "Left Leg", "Right Leg", "Left Arm", "Right Arm" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "73798034827573" },--108186273151388
{ MeshId = "137702817952968", Names = { "Right Leg", "Left Leg", "Right Arm", "Left Arm" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "73798034827573" },--139904067056008
{ MeshId = "11449386931", Names = { "Left Arm", "Right Arm" }, Offset = CFrame.Angles(- 2.094, 0, 0), TextureId = "11439439606" },--11449687315
{ MeshId = "11449388499", Names = { "Right Arm", "Left Arm" }, Offset = CFrame.Angles(- 2.094, 0, 0), TextureId = "11439439606" },--11449703382
{ MeshId = "12652772399", Names = { "Left Leg", "Right Leg" }, Offset = CFrame.identity, TextureId = "12652775021" },--12652786974
{ MeshId = "11263221350", Names = { "Left Leg", "Right Leg", "Left Arm", "Right Arm" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "11263219250" },--11263254795
{ MeshId = "11159370334", Names = { "Right Leg", "Left Leg", "Right Arm", "Left Arm" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "11159284657" },--11159410305
{ MeshId = "11159370334", Names = { "Right Leg", "Left Leg", "Right Arm", "Left Arm" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "11159285454" },--11159483910
{ MeshId = "105141400603933", Names = { "Left Arm", "Right Arm", "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "71060417496309" },--102599402682100
{ MeshId = "99608462237958", Names = { "Right Arm", "Left Arm", "Right Leg", "Left Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "130809869695496" },--140395948277978
{ MeshId = "90736849096372", Names = { "Left Arm", "Right Arm", "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "79186624401216" },--90960046381276
{ MeshId = "139733645770094", Names = { "Right Arm", "Left Arm", "Right Leg", "Left Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "130809869695496" },--82942681251131
{ MeshId = "125405780718494", Names = { "Left Arm", "Right Arm", "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "136752500636691" },--85392395166623
{ MeshId = "125405780718494", Names = { "Right Arm", "Left Arm", "Right Leg", "Left Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "136752500636691" },--131385506535381
{ MeshId = "125405780718494", Names = { "Left Leg", "Right Leg", "Left Arm", "Right Arm" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "136752500636691" },--106249329428811
{ MeshId = "125405780718494", Names = { "Right Leg", "Left Leg", "Right Arm", "Left Arm" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "136752500636691" },--129462518582032
{ MeshId = "14255522247", Names = { "Left Arm", "Right Arm", "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14255543546" },--14255556501
{ MeshId = "14255522247", Names = { "Right Arm", "Left Arm", "Right Leg", "Left Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14255543546" },--14255554762
{ MeshId = "17374767929", Names = { "Left Arm", "Right Arm", "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "17374768001" },--17374851733
{ MeshId = "17374767929", Names = { "Right Arm", "Left Arm", "Right Leg", "Left Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "17374768001" },--17374846953
{ MeshId = "14255522247", Names = { "Left Arm", "Right Arm", "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14255544465" },--14255560646
{ MeshId = "14255522247", Names = { "Right Arm", "Left Arm", "Right Leg", "Left Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14255544465" },--14255562939
{ MeshId = "18640914129", Names = { "Left Arm", "Right Arm", "Left Leg", "Right Leg" }, Offset = CFrame.identity, TextureId = "18640914168" },--18641142410
{ MeshId = "18640914129", Names = { "Right Arm", "Left Arm", "Right Leg", "Left Leg" }, Offset = CFrame.identity, TextureId = "18640914168" },--18641077392
{ MeshId = "18640901641", Names = { "Left Leg", "Right Leg", "Left Arm", "Right Arm" }, Offset = CFrame.identity, TextureId = "18640901676" },--18641187217
{ MeshId = "18640901641", Names = { "Right Leg", "Left Leg", "Right Arm", "Left Arm" }, Offset = CFrame.identity, TextureId = "18640901676" },--18641157833
{ MeshId = "17387586286", Names = { "Left Leg", "Right Leg", "Left Arm", "Right Arm" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "17387586304" },--17387616772
{ MeshId = "17387586286", Names = { "Right Leg", "Left Leg", "Right Arm", "Left Arm" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "17387586304" },--17393641992
{ MeshId = "3030546036", Names = { "Left Arm", "Left Leg", "Right Arm", "Right Leg" }, Offset = CFrame.Angles(- 1.57, 0, 0), TextureId = "" },
{ MeshId = "4324138105", Names = { "Left Arm", "Left Leg", "Right Arm", "Right Leg" }, Offset = CFrame.Angles(- 1.57, 0, 0), TextureId = "" },
{ MeshId = "18640899369", Name = "Torso", Offset = CFrame.identity, TextureId = "18640899481" },--18641046146
{ MeshId = "14241018198", Name = "Torso", Offset = CFrame.identity, TextureId = "14251599953" },--14255528083
{ MeshId = "110684113028749", Name = "Torso", Offset = CFrame.identity, TextureId = "70661572547971" },--138364679836274
{ MeshId = "4819720316", Name = "Torso", Offset = CFrame.Angles(0, 0, -0.249), TextureId = "4819722776" },--4819740796
{ MeshId = "126825022897778", Name = "Torso", Offset = CFrame.identity, TextureId = "125975972015302" },--95290698984301
},
ApplyDescription = true,
BreakJointsDelay = 0.255,
ClickFling = true,
DefaultFlingOptions = {
HatFling = true,--{ MeshId="", TextureId = ""},
Highlight = true,
PredictionFling = true,
Timeout = 1,
ToolFling = true,--"Boombox",
},
DisableCharacterCollisions = true,
DisableHealthBar = true,
DisableRigCollisions = true,
HatDrop = false,
HideCharacter = Vector3.new(0, - 30, 0),
ParentCharacter = true,
PermanentDeath = true,
Refit = true,
RigSize = 1,
RigTransparency = 1,
R15 = false,
SetCameraSubject = true,
SetCameraType = true,
SetCharacter = false,
SetCollisionGroup = true,
SimulationRadius = 2147483647,
TeleportRadius = 12,
UseServerBreakJoints = true,
})
Name = game.Players.LocalPlayer.Name
Character = workspace[Name]
else
print('choose an api next time :(')
return end

-- YES I KNOW ABOVE IS TERRIBLE PLS STOP REMINDING ME 😭 

local RootPart = Character.HumanoidRootPart
local Jumped,Falled,Idled,Walked = false,false,false,false
local AnimatorModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/MelonsStuff/DisbeliefHub/refs/heads/main/Scripts/AnimatorModule.lua"))()
local Anims = Instance.new("Folder", workspace)

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

function CreateAnimation(Name, ID)
local New = game:GetObjects("rbxassetid://"..ID)[1]
New.Parent = Anims
New.Name = Name
end

if game.CoreGui:FindFirstChild("FluxLib") then
game.CoreGui:FindFirstChild("FluxLib"):Destroy()
end

local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt"))()
local GUI = Lib:Window("Disbelief Hub", "Irony at its finest.", Color3.fromRGB(0, 0, 0), Enum.KeyCode.LeftControl)
local DancesA = GUI:Tab("Animations - R6 Dances", "http://www.roblox.com/asset/?id=6023426915")
local DancesB = GUI:Tab("Animations - Forsaken", "http://www.roblox.com/asset/?id=6023426915")

local R6Dances = {
{Name = "Boombox Dance", ID = 84471848998012, SoundID = 1839931160},
{Divider = true},  
{Name = "Cafeteria", ID = 111079857314277},
{Name = "Swag Surfin'", ID = 88245814842699},
{Name = "Trinidad", ID = 125079877993376},
{Name = "Rat Dance", ID = 98260902889120},
{Name = "Internet Yamero", ID = 99905571448278},
{Name = "Two", ID = 137845929482571},
{Name = "Hakari", ID = 92699725136780},
{Name = "Heavy Love", ID = 85856686932206},
{Name = "Oh Who Is You", ID = 80777442674443},
{Name = "BHop", ID = 82234401429055},
{Name = "Boomin'", ID = 135207682507735},
{Name = "Carbohydrate Craving", ID = 77887053847258},
{Name = "Criss Cross Toprock", ID = 73116243097694},
{Name = "Deep Fried Desire", ID = 127846780529069},
{Name = "Downtown Funk", ID = 103059790868580},
{Name = "Dragon of Dojima", ID = 79052669998148},
{Name = "Fighter Stance", ID = 118865990558686},
{Name = "Hot Springs", ID = 134527716461262},
{Name = "Kombonk", ID = 88519824673842},
{Name = "PoPiPo Extended", ID = 115465103089127},
{Name = "Rage", ID = 97891561277088},
{Name = "Shadow Dash", ID = 126495344868322},
{Name = "Star Striker", ID = 126271443897103},
{Name = "Survivalist", ID = 74820723472974},
{Divider = true},  
{Name = "Appendum", ID = 77926650795117},
{Name = "Attitude", ID = 129169655004423},
{Divider = true},  
{Name = "Bill", ID = 120460931637912},
{Name = "Billie Jean", ID = 108805310510119},
{Name = "Billy Bounce", ID = 125962207089467},
{Name = "Bit Crushing", ID = 135845625327739},
{Name = "Black and Yellow", ID = 132028118802766},
{Name = "Blinding Lights", ID = 83245497290837},
{Name = "BloodPop", ID = 132026285699359},
{Name = "Bomb Monkey", ID = 75616586799217},
{Name = "Boogie", ID = 125356421399032},
{Name = "Boogie Bomb", ID = 114817849347144},
{Name = "Boogie Down", ID = 77558722177080, Speed = 0.85},
{Name = "Boomin'", ID = 135207682507735},
{Name = "Box Swing", ID = 75405139558088, Speed = 0.75},
{Name = "BreakDance", ID = 132886479585903},
{Name = "BreakDance 2005", ID = 131296257768627},
{Name = "Break Down", ID = 100568904650591},
{Name = "Breakin", ID = 131155721688011},
{Name = "Bullet Dodge Ballet", ID = 98779400840597},
{Divider = true},  
{Name = "Calamity", ID = 102026644002108},
{Name = "Caramelldansen", ID = 103597509139287},
{Name = "ChaseMe", ID = 118311613925473},
{Name = "Check", ID = 132280062505986},
{Name = "Chicken Dinner", ID = 100643285137768},
{Name = "Club Penguin", ID = 89761302048916},
{Name = "Colossal", ID = 93170660505618},
{Name = "Company Jig", ID = 116614992219971},
{Name = "Conga", ID = 115557579308566},
{Name = "Continental Drift", ID = 105174222033892},
{Name = "CrackDown", ID = 133188222109902},
{Name = "Crank Dat", ID = 139148388599834},
{Name = "Cyber Bop", ID = 129655276640546},
{Name = "CupCakes", ID = 117125226382337},
{Divider = true},  
{Name = "Direction Directive", ID = 100131309856257},
{Name = "Domino", ID = 126683576461381, Speed = 0.75},
{Name = "Doodle", ID = 90069083924245, Speed = 0.75},
{Name = "Doom MCBringer", ID = 123386245117713},
{Name = "Double Step", ID = 138112012258643},
{Name = "Downtown Funk", ID = 103059790868580},
{Name = "Dragon Dance", ID = 75687257387850, Speed = 0.75},
{Name = "Drip", ID = 100177280567649, Speed = 0.75},
{Name = "Drum Major", ID = 116369780386936},
{Name = "Dynamic Shuffle", ID = 78337295886429},
{Divider = true},  
{Name = "Electro Shuffle", ID = 136684924748195},
{Name = "Electro Swing", ID = 93684150668786},
{Name = "Entranced", ID = 131726076631029},
{Divider = true},  
{Name = "Fein", ID = 115727639577589},
{Name = "Flamenco", ID = 112606613683393},
{Name = "Flapper", ID = 123373225244443},
{Name = "Floss", ID = 107287295776925},
{Name = "Fly Dance", ID = 125627676172807},
{Name = "Free Flow", ID = 101564911432113},
{Name = "Friday Night", ID = 91741353599946},
{Name = "Friday Funk", ID = 70835462045983},
{Name = "Frozen Pizza", ID = 78457500452351},
{Name = "Funky Jig", ID = 104720694407943},
{Divider = true},  
{Name = "Gangnam Style", ID = 109451974680631},
{Name = "Garrys Dance", ID = 102655274160157},
{Name = "Get Sturdy", ID = 77773358394206},
{Name = "Get to the Top", ID = 93228901518812},
{Name = "Goat Simulator", ID = 129327004786530},
{Name = "Groovy", ID = 88997109090699},
{Divider = true},  
{Name = "HanSolo", ID = 84236497616039},
{Name = "Heeltoe Hop", ID = 98256622649150},
{Name = "Heeltoe Toprock", ID = 140670228658366},
{Name = "Hiphop Hero", ID = 129871001094710},
{Name = "HipShop", ID = 103112841595182},
{Name = "HolIDay", ID = 85998810156809},
{Divider = true},  
{Name = "Infectious", ID = 103230323718650},
{Name = "Insanity", ID = 139483347792972},
{Name = "Its Complicated", ID = 78717948152747},
{Divider = true},  
{Name = "JayWalking", ID = 107833895457998, Speed = 0.85},
{Name = "Jive", ID = 133324659811186, Speed = 0.75},
{Name = "JumpStyle", ID = 115620519702324, Speed = 0.75},
{Name = "Jumping Jacks", ID = 86279418149917},
{Name = "Jung Justice", ID = 71723925114737},
{Divider = true},  
{Name = "Kalyx", ID = 137738597810830},
{Name = "Kazotsky Kick", ID = 114036336168567},
{Name = "KeepUp", ID = 84765927391240, Speed = 0.65},
{Name = "Kombonk", ID = 88519824673842, Speed = 0.75},
{Name = "KrabBorg", ID = 84670621089927},
{Divider = true},  
{Name = "Lagtrain", ID = 80764093560475},
{Name = "Legal Reasons", ID = 78083829137149},
{Name = "Lets Groove", ID = 109923692577857},
{Name = "Little Big", ID = 78546390232203},
{Name = "Lofi Headbang", ID = 84024656726416},
{Name = "Love Hate", ID = 118446506171691},
{Divider = true},  
{Name = "Magnetic", ID = 91594002186875},
{Name = "MannRobics", ID = 137456359844967},
{Name = "MaxEffort", ID = 108526381474779},
{Name = "Miku", ID = 82171050414030},
{Name = "Million", ID = 109123683211464},
{Name = "Mirage", ID = 108895956412207},
{Name = "Mischiev Function", ID = 100305033962391, Speed = 0.95},
{Divider = true},  
{Name = "Neo", ID = 100305033962391},
{Name = "Nerdy", ID = 136250600208499},
{Name = "NewDonk", ID = 111542909088526},
{Name = "New Jack Swingin", ID = 113494131456426},
{Divider = true},  
{Name = "Oddloop", ID = 95650849617284},
{Name = "Oktober Aid", ID = 127865309658292},
{Name = "Old School", ID = 115558885277292},
{Name = "Outlaw", ID = 79048566727283},
{Name = "OverDrive", ID = 118789281098407},
{Divider = true},  
{Name = "PonPon", ID = 109617660580282},
{Name = "Party House", ID = 113030438875320},
{Name = "Peanut Butter", ID = 85717017003584},
{Name = "Pick it Up", ID = 106248669913767},
{Name = "PoPiPo", ID = 115465103089127},
{Name = "Pogo", ID = 109001339891602},
{Name = "Pop and Lock", ID = 113869158054586},
{Name = "PopLock", ID = 83789802032942},
{Name = "Prince of Egypt", ID = 95986135548450},
{Name = "Professional", ID = 117672863086140},
{Divider = true},  
{Name = "Rain Check", ID = 104145748528942},
{Name = "Reanimated", ID = 135638372997121},
{Name = "Reflex", ID = 104246452023047},
{Name = "Reject Step", ID = 79440368381920},
{Name = "Rewind", ID = 85595451831140},
{Name = "RicFlair", ID = 77103786363593},
{Name = "Ridin It", ID = 110739557877639},
{Name = "Rodeo", ID = 139177767291866},
{Name = "Royal Angst", ID = 101917046845862},
{Name = "Running in Terror", ID = 82063943309833},
{Divider = true},  
{Name = "Scenario", ID = 105424478944256},
{Name = "Sicko Mode", ID = 82639898531456},
{Name = "Side Shuffle", ID = 106696831887022},
{Name = "Sidestep", ID = 118256299900662},
{Name = "Sit", ID = 77436653907705},
{Name = "Slick", ID = 112642355788128},
{Name = "Slow Down", ID = 96225967263351},
{Name = "Smooth Slide", ID = 95051030054364},
{Name = "SoarAbove", ID = 92031051557681, Speed = 0.75},
{Name = "SpongeBob", ID = 107928348961439, Speed = 0.75},
{Name = "SpringLoaded", ID = 126001082682364},
{Name = "Springy", ID = 96915228320599},
{Name = "Squash and Stretch", ID = 82430103452187},
{Name = "Stock Shuffle", ID = 86067433847393},
{Divider = true},  
{Name = "TaiChi", ID = 139334740822475},
{Name = "Texas Hoedown", ID = 130942516783083},
{Name = "The Flop", ID = 122878040721056},
{Name = "The MD", ID = 103541609182057},
{Name = "The Roll", ID = 70422527184550},
{Name = "Thriller", ID = 101170440834154},
{Name = "Too Much Brain", ID = 71228444263749},
{Name = "Tootsee Roll", ID = 102931874666964},
{Name = "Top Rocking", ID = 116248187570378},
{Name = "True Heart", ID = 139400505188520},
{Name = "Turnt Up", ID = 95604282742916},
{Divider = true},  
{Name = "Walk Of Pride", ID = 137503210275698},
{Name = "Wednesday", ID = 93029240528390},
{Name = "Well Rounded", ID = 93832203745642},
{Name = "Work It", ID = 140046429691095},
{Divider = true},  
{Name = "XO", ID = 73559770055600},
{Divider = true},  
{Name = "Zombeat", ID = 130481163326164},
{Divider = true},  
{Name = "Victory Sway", ID = 118331988473361},
{Divider = true},  
{Name = "ah yes", ID = 121084882913556},
{Name = "expldoe", ID = 113901618647384},
{Divider = true},  
{Name = "Club Penguin 2", ID = 116538780276427},
{Name = "Garry's Dance 2", ID = 116538780276427},
{Name = "Goat Simulator 2", ID = 108846628611129},
{Name = "PoPiPo 2", ID = 108846628611129},
{Divider = true},  
}

local Forsaken = {
{Name = "Shucks", ID = 74238051754912},
{Name = "Silly Billy", ID = 107464355830477},
{Name = "Subterfuge", ID = 87482480949358},
{Name = "Richard Watterson (the hero)", ID = 74012585744751},
}

for i, v in pairs(Forsaken) do
if v.Divider then
DancesB:Line()
else
DancesB:Button(v.Name, v.Name, function()
if not Anims:FindFirstChild(v.Name) then
CreateAnimation(v.Name, v.ID)
end
PlayAnim(Character, Anims[v.Name], 0, v.Speed or 1)
end)
end
end

for i, v in pairs(R6Dances) do
if v.Divider then
DancesA:Line()
else
DancesA:Button(v.Name, v.Name, function()
if not Anims:FindFirstChild(v.Name) then
CreateAnimation(v.Name, v.ID)
end
PlayAnim(Character, Anims[v.Name], 0, v.Speed or 1)
end)
end
end

CreateAnimation("Idle", 136078657506707)
CreateAnimation("Walk", 130213485744288)
CreateAnimation("Jump", 84397577392351)
CreateAnimation("Fall", 90270295182351)

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


warn[[
Tapping microphone "Hello?, helloooo?? Is this thing on?" —static crackles- “Ah, there we go. Ladies and gentlemen! Welcome to the hit show 'No One Can Prove Melon Is A Skid!' Fasten your seat belts; what you’re about to hear could turn the world upside down.
“For our first guest today, we have…uh –wait, what was the name again?” —shuffling papers— "Ah, yes! The respected keyboard warrior who genuinely thinks they have discovered the biggest scandal in the world of scripting! Tell us sir, what revolutionary evidence that you have today?
—awkward silence— "Oh? Nothing? No proof? Just vibes? Fascinating. Truly groundbreaking investigative work."
So, people, here you go. Another ‘Baseless Accusations & Keyboard Rage!‘ episode. Stay tuned because we are heading straight into the mind-blowing world of ‘People Who Think Copy-Pasting a GitHub Repo Makes Them Elite Hackers!”
—applause track plays – Until next time!
]]

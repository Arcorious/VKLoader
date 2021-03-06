game.ReplicatedFirst:RemoveDefaultLoadingScreen()
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local ContentProvider = game:GetService("ContentProvider")

local loadables = {} -- your loadable array.
local amount_loaded = 0

if not game:IsLoaded() then
	game.Loaded:Wait()
end

for i,v in pairs(game.Workspace.World.Buildings:GetDescendants()) do
	if v:IsA("MeshPart") then
		table.insert(loadables, v)
	end
end

local NewLoadingGui = script.LoadingScreen:Clone()
NewLoadingGui.Parent = PlayerGui

local startTime = os.clock()

for i = 1, #loadables do
	ContentProvider:PreloadAsync({loadables[i]})
	amount_loaded = i
	NewLoadingGui.Frame.Title.Text = i.."/"..#loadables
	NewLoadingGui.Frame.Title.PatternFill.Size = UDim2.new(amount_loaded/#loadables,0,1,0)
end

local deltaTime = os.clock() - startTime
print(("Preloading complete, took %.2f seconds"):format(deltaTime))

wait(1)

NewLoadingGui:Destroy()

for i,v in pairs(game.ReplicatedStorage.Shared.Assets.LightingEffects:GetChildren()) do
	v:Clone().Parent = game.Lighting
end

require(game.ReplicatedStorage.Shared.Modules.System.RemotesHandler).securitySendStrings = {"@!)#@$*)WAd134#$", "!@#!@EdwaD!@#q3", "DWAD!23123!@#", "WADL!@#%$1", "123FF@#$1"}

wait(0.2)

require(game.ReplicatedStorage.Shared.Modules.System.ClientSetup).Init()
local Players = game:GetService("Players")
local Datastore = game:GetService("DataStoreService"):GetDataStore("PreAlpha004")
local Replicated = game:GetService("ReplicatedStorage")
local HTTP = game:GetService("HttpService")

local PlayerStats = Replicated:WaitForChild("PlayerStats")
local Events = Replicated:WaitForChild("Events")
local Tools = Replicated:WaitForChild("Tools")
local Modules = Replicated:WaitForChild("Module")

local PetModule = require(Modules:WaitForChild("Pets"))
local FormatModule = require(Modules:WaitForChild("FormatNumber"))

local defaultTable = {
	["IQ"] = 0,
	["Money"] = 0,
	["Gems"] = 0,
	["Rebirth"] = 0,
	["Capacity"] = 50,
	["MaxHeight"] = 0,
	["Music"] = 1,
	["Tool"] = "Pre-School",
	["Tools"] = {},
	["Pets"] = {},
	["EquippedPets"] = {},
}

Players.PlayerAdded:Connect(function(player)
	-- Initialize data and create values
	local Data = Datastore:GetAsync("Datastore-" .. player.UserId)
	
	if not Data then
		Data = defaultTable
		Data["Tools"] = HTTP:JSONEncode({"Pre-School"})
		Data["Pets"] = HTTP:JSONEncode({})
		Data["EquippedPets"] = HTTP:JSONEncode({})
		Datastore:SetAsync("Datastore-" .. player.UserId, defaultTable)
	end
	
	local PlayerData = Instance.new("Folder")
	PlayerData.Parent = PlayerStats
	PlayerData.Name = player.Name
	
	for Index, Value in pairs(Data) do
		if Index == "IQ" or Index == "Money" or Index == "Capacity" or Index == "MaxHeight" or Index == "Music" or Index == "Rebirth" or Index == "Gems" or Index == "Multiplier" then
			local DataValue = Instance.new("IntValue")
			DataValue.Name = Index
			DataValue.Parent = PlayerData
			DataValue.Value = Data[Index]
		else
			local DataValue = Instance.new("StringValue")
			DataValue.Name = Index
			DataValue.Parent = PlayerData
			DataValue.Value = Data[Index]
		end
	end
	
	local Multiplier = Instance.new("NumberValue")
	Multiplier.Name = "Multiplier"
	Multiplier.Parent = PlayerData
	Multiplier.Value = 1
	
	print("SERVER: Data Initialization Completed For " .. player.Name)
	
	-- Add tools for the player
	local Tool = Tools:FindFirstChild(Data["Tool"]):Clone()
	Tool.Parent = player.Backpack
	
	local StarterTool = Tools:FindFirstChild(Data["Tool"]):Clone()
	StarterTool.Parent = player.StarterGear
	
	print("SERVER: Tool Initialization Completed For " .. player.Name)

	-- Create Leaderstats
	local LeaderStats = Instance.new("Folder")
	LeaderStats.Name = "leaderstats"
	LeaderStats.Parent = player
	
	local RealIQ = PlayerData:FindFirstChild("IQ")
	local RealMoney = PlayerData:FindFirstChild("Money")
	local RealMaxHeight = PlayerData:FindFirstChild("MaxHeight")
	local RealGem = PlayerData:FindFirstChild("Gems")
	
	local IQ = Instance.new("NumberValue")
	IQ.Value = RealIQ.Value
	IQ.Name = "100s"
	IQ.Parent = LeaderStats
	
	local Money = Instance.new("StringValue")
	Money.Value = FormatModule.FormatCompact(RealMoney.Value)
	Money.Name = "Money"
	Money.Parent = LeaderStats
	
	local Gem = Instance.new("StringValue")
	Gem.Value = FormatModule.FormatCompact(RealGem.Value)
	Gem.Name = "Gems"
	Gem.Parent = LeaderStats
	
	
	RealIQ.Changed:Connect(function()
		IQ.Value = RealIQ.Value
		
	end)
	
	RealMoney.Changed:Connect(function()
		Money.Value = FormatModule.FormatCompact(RealMoney.Value)
	end)
	
	RealGem.Changed:Connect(function()
		Gem.Value = FormatModule.FormatCompact(RealGem.Value)
	end)
	
	print("SERVER: Leaderstats Initialization Completed For " .. player.Name)
	
	player.CharacterAdded:Connect(function(character)
		local PetsFolder = Instance.new("Folder")
		PetsFolder.Name = "Pets"
		PetsFolder.Parent = character
		PetModule.PetInit(player)
		print("SERVER: Pets Initialization Completed For " .. player.Name)
	end)
	
	player:LoadCharacter()
end)

Players.PlayerRemoving:Connect(function(player)
	local Data = {
		["IQ"] = 0,
		["Money"] = 0,
		["Gems"] = 0,
		["Rebirth"] = 0,
		["Capacity"] = 50,
		["MaxHeight"] = 0,
		["Music"] = 1,
		["Tool"] = "Pre-School",
		["Tools"] = {},
		["Pets"] = {},
		["EquippedPets"] = {},
	}
	
	local PlayerData = PlayerStats:FindFirstChild(player.Name)
	
	if PlayerData:FindFirstChild("Multiplier") then
		PlayerData:FindFirstChild("Multiplier"):Destroy()
	end
	
	for _, Object in pairs(PlayerData:GetChildren()) do
		Data[Object.Name] = Object.Value
	end
	
	Datastore:SetAsync("Datastore-" .. player.UserId, Data)
	PlayerData:Destroy()
	
	print("SERVER: Data Saving Completed For " .. player.Name)
end)

game:BindToClose(function()
	for _, player in pairs (Players:GetPlayers()) do
		local Data = {
			["IQ"] = 0,
			["Money"] = 0,
			["Gems"] = 0,
			["Rebirth"] = 0,
			["Capacity"] = 50,
			["MaxHeight"] = 0,
			["Music"] = 1,
			["Tool"] = "Pre-School",
			["Tools"] = {},
			["Pets"] = {},
			["EquippedPets"] = {},
		}
		
		local PlayerData = PlayerStats:FindFirstChild(player.Name)

		
		for _, Object in pairs(PlayerData:GetChildren()) do
			Data[Object.Name] = Object.Value
		end
		
		Datastore:SetAsync("Datastore-" .. player.UserId, Data)
		PlayerData:Destroy()
		
		print("SERVER: Data Saving Completed For " .. player.Name)
	end
end)

spawn(function()
	while wait(360) do
		for _, player in pairs (Players:GetPlayers()) do
			local Data = {
				["IQ"] = 0,
				["Money"] = 0,
				["Gems"] = 0,
				["Rebirth"] = 0,
				["Capacity"] = 50,
				["MaxHeight"] = 0,
				["Music"] = 1,
				["Tool"] = "Pre-School",
				["Tools"] = {},
				["Pets"] = {},
				["EquippedPets"] = {},
			}
			
			local PlayerData = PlayerStats:FindFirstChild(player.Name)
			
			for _, Object in pairs(PlayerData:GetChildren()) do
				Data[Object.Name] = Object.Value
			end
			
			Datastore:SetAsync("Datastore-" .. player.UserId, Data)
			
			print("SERVER: Data Saving Completed For " .. player.Name)
		end
	end
end)
local Players = game:GetService('Players')
local Replicated = game:GetService("ReplicatedStorage")
local Marketplace = game:GetService("MarketplaceService")
local ServerStorage = game:GetService("ServerStorage")

local PlayerStats = Replicated:WaitForChild("PlayerStats")

local Events = Replicated:WaitForChild("Events")
local AddUIEvent = Events:WaitForChild("AddUIEvent")

local Balloon = ServerStorage:WaitForChild("Balloon")

local CashTable = {
	[1082830359] = 5000000;
	[1082830341] = 1000000;
	[1082830310] = 500000;
	[1082830249] = 100000;
	[1082830218] = 50000;
	[1082830169] = 10000;
}

local GemTable = {
	[1082830394] = 50;
	[1082830404] = 100;
	[1082830431] = 500;
	[1082830444] = 1250;
	[1082830475] = 2500;
	[1082830498] = 5000;
}

local function processReceipt(receiptInfo)
	local Player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	local PlayerStat = PlayerStats:FindFirstChild(Player.Name)
	local ProductId = receiptInfo.ProductId
	
	local TypePurchase = ""
	
	for i, v in pairs(CashTable) do
		if i == ProductId then TypePurchase = "Cash" end
	end
	
	for i, v in pairs(GemTable) do
		if i == ProductId then TypePurchase = "Gem" end
	end
	
	if TypePurchase == "Cash" then
		local Cash = PlayerStat:FindFirstChild("Money")
		Cash.Value += CashTable[ProductId]
		AddUIEvent:FireClient(Player, "Money", CashTable[ProductId])
		return Enum.ProductPurchaseDecision.PurchaseGranted
	elseif TypePurchase == "Gem" then
		local Gems = PlayerStat:FindFirstChild("Gems")
		Gems.Value += GemTable[ProductId]
		AddUIEvent:FireClient(Player, "Gems", GemTable[ProductId])
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
end

Marketplace.ProcessReceipt = processReceipt

local function gamepassPurchaseFinished(Player, GamepassID, wasPurchased)
	if Player and wasPurchased then
		local PlayerStat = PlayerStats:FindFirstChild(Player.Name)
		if GamepassID == 11437122 then -- Balloon
			local B1 = Balloon:Clone()
			B1.Parent = Player.Backpack
			local B2 = Balloon:Clone()
			B2.Parent = Player.StarterGear
			return Enum.ProductPurchaseDecision.PurchaseGranted
		elseif GamepassID == 11437111 then -- Infinite IQ
			local Capacity = PlayerStat:FindFirstChild("Capacity")
			Capacity.Value = 9000000000000000000
			return Enum.ProductPurchaseDecision.PurchaseGranted
		elseif GamepassID == 11437118 then
			local Character = Player.Character
			local Humanoid = Character.Humanoid
			Humanoid.WalkSpeed *= 2
		end
	end
end

Marketplace.PromptGamePassPurchaseFinished:Connect(gamepassPurchaseFinished)
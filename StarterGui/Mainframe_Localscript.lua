local Players = game:GetService("Players")
local Replicated = game:GetService("ReplicatedStorage")
local Market = game:GetService("MarketplaceService")
local HTTP = game:GetService("HttpService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local PlayerStats = Replicated:WaitForChild("PlayerStats")
local PlayerStat = PlayerStats:WaitForChild(Player.Name, 20)
local IQ = PlayerStat:WaitForChild("IQ")
local Capacity = PlayerStat:WaitForChild("Capacity")
local Cash = PlayerStat:WaitForChild("Money")
local Gems = PlayerStat:WaitForChild("Gems")
local EquippedBook = PlayerStat:WaitForChild("Tool")
local OwnedBooks = PlayerStat:WaitForChild("Tools")
local Multiplier = PlayerStat:WaitForChild("Multiplier")
local Pets = PlayerStat:WaitForChild("Pets")
local EquippedPets = PlayerStat:WaitForChild("EquippedPets")

local PetModel = Replicated:WaitForChild("Pets")

local UI = script.Parent

-- Modules
local Modules = Replicated:WaitForChild("Module")
local GamepassModule = require(Modules:FindFirstChild("Gamepass"))
local StoreModule = require(Modules:FindFirstChild("Store"))
local FormatModule = require(Modules:WaitForChild("FormatNumber"))

local NiceStoreTable = {"Pre-School", "Kindergarten", "Year 1","Year 2","Year 3","Year 4","Year 5","Year 6","Year 7","Year 8","Year 9","Year 10","Year 11","Year 12", "Polytechnic Degree","Bachelors Year 1", "Bachelors Year 2", "Bachelors Year 3", "Bachelors Year 4", "Masters Year 1", "Masters Year 2", "PhD Research", "Quantum Studies", "Intergalactic Studies", "Interdimensional Studies"}

-- Developer Products (Small To Big)
local CashTable = {1082830169,1082830218,1082830249,1082830310,1082830341,1082830359}
local GemTable = {1082830394,1082830404,1082830431,1082830444,1082830475,1082830498}

-- Sounds
local Sounds = UI:WaitForChild("Sounds")
local HoverSound = Sounds:WaitForChild("Hover")
local ClickSound = Sounds:WaitForChild("Click")
local MoneySound = Sounds:WaitForChild("Money")

local LeftBar = UI:WaitForChild("LeftBar")
local ScoreFrame = LeftBar:WaitForChild("ScoreFrame")
local ScoreValue = ScoreFrame:WaitForChild("ScoreValue")
local BuyScore = ScoreFrame:WaitForChild("BuyScore")

local CashFrame = LeftBar:WaitForChild("CashFrame")
local CashValue = CashFrame:WaitForChild("CashValue")
local BuyCash = CashFrame:WaitForChild("BuyCash")

local GemFrame = LeftBar:WaitForChild("GemFrame")
local GemValue = GemFrame:WaitForChild("GemValue")
local BuyGem = GemFrame:WaitForChild("BuyGem")

local FourButtonFrame = LeftBar:WaitForChild("FourButtons")
local UpgradeButton = FourButtonFrame:WaitForChild("UpgradeButton")
local TeleportButton = FourButtonFrame:WaitForChild("TeleportButton")
local PetButton = FourButtonFrame:WaitForChild("PetButton")
local ShopButton = FourButtonFrame:WaitForChild("ShopButton")

local CapacityFrame = UI:WaitForChild("CapacityUpgrade")
local CapacityCancel = CapacityFrame:WaitForChild("ExitButton")
local CapacityUpgradeBtn = CapacityFrame:WaitForChild("UpgradeButton")
local BeforeCapacityUpgrade = CapacityFrame:WaitForChild("BeforeUpgradeValue")
local AfterCapacityUpgrade = CapacityFrame:WaitForChild("AfterUpgradeValue")

local MiscShop = UI:WaitForChild("MiscShop")
local MainShopBorder = MiscShop:WaitForChild("InnerBorder")
local ShopElementTemplate = MainShopBorder:WaitForChild("Template")
local ShopScroll = MainShopBorder:WaitForChild("ScrollingFrame")
local ShopCancel = MiscShop:WaitForChild("ExitButton")

-- 252,92,101 (Gems); 253,150,68 (Gamepass); 38,222,129 (Cash)
local ShopGamepass = MiscShop:WaitForChild("GamepassShop")
local ShopCash = MiscShop:WaitForChild("MoneyShop")
local ShopGems = MiscShop:WaitForChild("GemShop")

local BookShop = UI:WaitForChild("BookShop")
local SBook = BookShop:WaitForChild("SBook")
local BookScroll = BookShop:WaitForChild("ScrollingFrame")
local BookElementTemplate = BookShop:WaitForChild("Template")
local BookButton = BookShop:WaitForChild("PurchaseButton")
local BookExit = BookShop:WaitForChild("ExitButton")
local BookButtonText = BookButton:WaitForChild("TextLabel")
local SBookName = BookShop:WaitForChild("SBookName")
local SBookClick = BookShop:WaitForChild("SBookClick")
local SCost = BookShop:WaitForChild("SCost")

-- This is for the pets
local PetInventory = UI:WaitForChild("PetInventory")
local PetScroll = PetInventory:WaitForChild("ScrollingFrame")
local PetElementTemplate = PetInventory:WaitForChild("Template")

-- Pet LeftFrame
local PetLeftFrame = PetInventory:WaitForChild("LeftFrame")
local SPetViewport = PetLeftFrame:WaitForChild("ViewportFrame")
local SPetMultiplier = PetLeftFrame:WaitForChild("PetMultiplier")
local SPetName = PetLeftFrame:WaitForChild("PetName")
local SPetRarity = PetLeftFrame:WaitForChild("PetRarity")
local PetEquip = PetLeftFrame:WaitForChild("EquipButton")
local PetDiscard = PetLeftFrame:WaitForChild("DiscardButton")

local PetAddEquipSlot = PetInventory:WaitForChild("AddEquip")
local PetAddPetStore = PetInventory:WaitForChild("AddPetStore")
local PetExitBtn = PetInventory:WaitForChild("ExitButton")
local PetStoredNo = PetInventory:WaitForChild("PetStorage")
local PetEquippedNo = PetInventory:WaitForChild("EquippedPets")
local CurrentPetMultiplier = PetInventory:WaitForChild("Multiplier")

local Events = Replicated:WaitForChild("Events")
local UIEvent = Events:WaitForChild("MainframeUI")
local CapacityEvent = Events:WaitForChild("AddCapacity")
local BuyBook = Events:WaitForChild("BuyBook")
local PetSystemEvent = Events:WaitForChild("PetSystem")

local ServerTools = Replicated:WaitForChild("Tools")

local Buttons = {UpgradeButton, TeleportButton,ShopButton, PetButton, PetAddEquipSlot, PetAddPetStore, BuyScore, BuyCash, BuyGem, CapacityCancel, BookExit, CapacityUpgradeBtn, ShopGamepass, ShopCash, ShopGems, ShopCancel}
local DisplayingScreen = nil
local ShopScreen = "Gamepass" -- Gamepass, Gems, Cash
local ShopLoading = false
local SelectedBook = EquippedBook.Value
local BookEventFiring = false
local PetEventFiring = false
local SelectedPet
local PetStorageCapacity = 20
local PetEquipCapacity = 2
if Market:UserOwnsGamePassAsync(Player.UserId, 11437117) then
	PetStorageCapacity = 40
end
if Market:UserOwnsGamePassAsync(Player.UserId, 11437115) then
	PetStorageCapacity = 4
end
TeleportButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	Character:MoveTo(Vector3.new(98.7, 1.74, 17.3))
end)

IQ.Changed:Connect(function()
	if Capacity.Value ==  9000000000000000000 then
		ScoreValue.Text = FormatModule.FormatStandard(IQ.Value) .. "/inf" 
	else
		ScoreValue.Text = FormatModule.FormatStandard(IQ.Value) .. "/" .. FormatModule.FormatStandard(Capacity.Value)
	end
end)

Gems.Changed:Connect(function()
	GemValue.Text = FormatModule.FormatStandard(Gems.Value)
end)

Multiplier.Changed:Connect(function()
	CurrentPetMultiplier.Text = "Multiplier: " .. Multiplier.Value
end)


PetEquippedNo.Text = "Equipped Pets: " .. #HTTP:JSONDecode(EquippedPets.Value)
PetStoredNo.Text = "Pets Stored: " .. #HTTP:JSONDecode(Pets.Value) .. "/" .. PetStorageCapacity

CurrentPetMultiplier.Text = "Multiplier: " .. Multiplier.Value
GemValue.Text = FormatModule.FormatStandard(Gems.Value)
ScoreValue.Text = FormatModule.FormatStandard(IQ.Value) .. "/" .. FormatModule.FormatStandard(Capacity.Value)
CashValue.Text = FormatModule.FormatStandard(Cash.Value)
if Capacity.Value ==  9000000000000000000 then
	ScoreValue.Text = FormatModule.FormatStandard(IQ.Value) .. "/inf" 
else
	ScoreValue.Text = FormatModule.FormatStandard(IQ.Value) .. "/" .. FormatModule.FormatStandard(Capacity.Value)
end

-- [[ Capacity Frame ]] -- 
local function LoadCapacityButton()
	if Capacity.Value == 9000000000000000000 then
		BeforeCapacityUpgrade.Text = "MAX"
		AfterCapacityUpgrade.Text = "MAX"
		CapacityUpgradeBtn.ImageRectOffset = Vector2.new(0,166)
		CapacityUpgradeBtn.TextLabel.Text = "MAX"
	else
		BeforeCapacityUpgrade.Text = FormatModule.FormatStandard(Capacity.Value)
		AfterCapacityUpgrade.Text = FormatModule.FormatStandard(Capacity.Value*2)
		CapacityUpgradeBtn.TextLabel.Text = "Upgrade: $" .. FormatModule.FormatStandard(100 * 2^((math.log(Capacity.Value/50)/math.log(2)+1)))
		CapacityUpgradeBtn.ImageRectOffset = Vector2.new(0,0)
		
		if Cash.Value < (100 * 2^((math.log(Capacity.Value/50)/math.log(2)+1))) then
			CapacityUpgradeBtn.ImageRectOffset = Vector2.new(0,166)
		end
	end
end

Cash.Changed:Connect(function()
	CashValue.Text = FormatModule.FormatStandard(Cash.Value)
	if DisplayingScreen == "Capacity" then
		LoadCapacityButton()
	end
end)

Capacity.Changed:Connect(function()
	if Capacity.Value ==  9000000000000000000 then
		ScoreValue.Text = FormatModule.FormatStandard(IQ.Value) .. "/inf" 
	else
		ScoreValue.Text = FormatModule.FormatStandard(IQ.Value) .. "/" .. FormatModule.FormatStandard(Capacity.Value)
	end
	LoadCapacityButton()
end)

CapacityUpgradeBtn.MouseButton1Click:Connect(function()
	if DisplayingScreen == "Capacity" and Cash.Value >= (100 * 2^((math.log(Capacity.Value/50)/math.log(2)+1))) and Capacity.Value < 9000000000000000000 then
		ClickSound:Play()
		CapacityEvent:FireServer()
		wait(0.05)
		LoadCapacityButton()
	end
end)

CapacityCancel.MouseButton1Click:Connect(function()
	if DisplayingScreen == "Capacity" then
		ClickSound:Play()
		CapacityFrame.Visible = false
		DisplayingScreen = nil
	end
end)

-- [[ Shop Frame ]] -- 
local function ClearShop()
	if ShopLoading then 
		repeat wait(0.1) until (not ShopLoading)
	end
	
	for i, v in pairs(ShopScroll:GetChildren()) do
		if not (v:IsA("UIListLayout")) then
			v:Destroy()
		end
	end
end

local function SetupShop()
	if not ShopLoading then
		ShopLoading = true
		if ShopScreen == "Gamepass" then
			MiscShop.ImageColor3 = Color3.fromRGB(253,150,68)
			for i, v in pairs(GamepassModule) do
				local Asset = Market:GetProductInfo(v,2)
				local G = ShopElementTemplate:Clone()
				G.Parent = ShopScroll
				G.BuyBtn.TextLabel.Text = "R$" .. Asset.PriceInRobux
				G.itemName.Text = Asset.Name or ""
				G.itemDesc.Text = Asset.Description or ""
				G.ImageLabel.Image = "rbxassetid://" .. Asset.IconImageAssetId
				G.Visible = true
				local function PromptPurchaseForButton()
					ClickSound:Play()
					Market:PromptGamePassPurchase(Player, v)
				end
				
				G.BuyBtn.MouseButton1Click:Connect(PromptPurchaseForButton)
				--G.BuyBtn.TouchTap:Connect(PromptPurchaseForButton)
			end
		elseif ShopScreen == "Cash" then
			MiscShop.ImageColor3 = Color3.fromRGB(38,222,129)
			for i, v in pairs(CashTable) do
				local Asset = Market:GetProductInfo(v, 1)
				local G = ShopElementTemplate:Clone()
				G.Parent = ShopScroll
				G.BuyBtn.TextLabel.Text = "R$" .. Asset.PriceInRobux
				G.itemName.Text = Asset.Name or ""
				G.itemDesc.Text = Asset.Description or ""
				G.ImageLabel.UIAspectRatio.AspectRatio = 1.862
				G.ImageLabel.Image = "rbxassetid://5642463776"
				G.Visible = true
				local function PromptPurchaseForButton()
					ClickSound:Play()
					Market:PromptProductPurchase(Player, v)
				end
				G.BuyBtn.MouseButton1Click:Connect(PromptPurchaseForButton)
				--G.BuyBtn.TouchTap:Connect(PromptPurchaseForButton)
				
			end
		elseif ShopScreen == "Gems" then
			MiscShop.ImageColor3 = Color3.fromRGB(252,92,101)
			for i, v in pairs(GemTable) do
				local Asset = Market:GetProductInfo(v,1)
				local G = ShopElementTemplate:Clone()
				G.Parent = ShopScroll
				G.BuyBtn.TextLabel.Text = "R$" .. Asset.PriceInRobux
				G.itemName.Text = Asset.Name or ""
				G.itemDesc.Text = Asset.Description or ""
				G.ImageLabel.UIAspectRatio.AspectRatio = 1.22
				G.ImageLabel.Image = "rbxassetid://5608897160"
				G.Visible = true
				local function PromptPurchaseForButton()
					ClickSound:Play()
					Market:PromptProductPurchase(Player, v)
				end
				G.BuyBtn.MouseButton1Click:Connect(PromptPurchaseForButton)
				--G.BuyBtn.TouchTap:Connect(PromptPurchaseForButton)
				
			end
		end
		ShopLoading = false
	end
end

ShopGamepass.MouseButton1Click:Connect(function()
	if DisplayingScreen == "MiscShop" and not (ShopScreen == "Gamepass") then
		ClickSound:Play()
		ClearShop()
		ShopScreen = "Gamepass"
		SetupShop()
	end
end)

ShopGems.MouseButton1Click:Connect(function()
	if DisplayingScreen == "MiscShop" and not (ShopScreen == "Gems") then
		ClickSound:Play()
		ClearShop()
		ShopScreen = "Gems"
		SetupShop()
	end
end)

ShopCash.MouseButton1Click:Connect(function()
	if DisplayingScreen == "MiscShop" and not (ShopScreen == "Cash") then
		ClickSound:Play()
		ClearShop()
		ShopScreen = "Cash"
		SetupShop()
	end
end)

ShopCancel.MouseButton1Click:Connect(function()
	if DisplayingScreen == "MiscShop" then
		ClickSound:Play()
		MiscShop.Visible = false
		DisplayingScreen = nil
		ShopScreen = nil
		ClearShop()
	end
end)

-- [[ Bookstore Functions ]]--
local function ChangeFrameIfOwnBook()
	local TmpTable = HTTP:JSONDecode(OwnedBooks.Value)
	for i, v in pairs(BookScroll:GetChildren()) do
		if table.find(TmpTable, v.Name) then
			v.ImageRectOffset = Vector2.new(158,0)
		end
	end
end

local function SelectBook(Book)
	SBookName.Text = Book
	SBookClick.Text = "+" .. FormatModule.FormatStandard(StoreModule[Book]["IQ"]) .. " Per Click"
	SCost.Text = "$" .. FormatModule.FormatStandard(StoreModule[Book]["Price"])
	SelectedBook = Book
	
	-- If there is already a model, destroy the model first
	if SBook:FindFirstChild("Model") then SBook:FindFirstChild("Model"):Destroy() end
	local ViewportTarget = ServerTools:FindFirstChild(Book):Clone()
	
	-- Make the camera
	local ViewportCamera = Instance.new("Camera")
	ViewportCamera.CameraType = Enum.CameraType.Scriptable
	SBook.CurrentCamera = ViewportCamera
	
	-- Make a cloned "Model" version of the tool under the actual ViewportFrame
	ViewportTarget.Parent = SBook
	local TmpModel = Instance.new("Model")
	TmpModel.Parent = SBook
	for i,v in pairs(ViewportTarget:GetChildren()) do
		if v:IsA("BasePart") then
			v.Anchored = true
			v.Parent = TmpModel
		else
			v:Destroy()
		end
	end
	ViewportTarget = TmpModel
	ViewportTarget.PrimaryPart = TmpModel.Handle
	ViewportTarget:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0,0,0)))
	
	local ICframe, ISize = ViewportTarget:GetBoundingBox()
	local Max = math.max(ISize.X, ISize.Y, ISize.Z)
	local Dist = (Max/math.tan(math.rad(ViewportCamera.FieldOfView))) * 1.5
	local CurrDist = (Max/2) + Dist
	
	ViewportCamera.CFrame = CFrame.new(Vector3.new(0,0,0) + Vector3.new(-0.8,0.75,CurrDist))
	
	-- Change the button text depending on what it is
	if EquippedBook.Value == Book then -- Equipped
		BookButton.ImageRectOffset = Vector2.new(0,112)
		BookButtonText.Text = "EQUIPPED"
	elseif not (EquippedBook == Book) and table.find(HTTP:JSONDecode(OwnedBooks.Value), Book) then -- Have book but not equipped
		BookButton.ImageRectOffset = Vector2.new(0,224)
		BookButtonText.Text = "EQUIP"
	elseif not (EquippedBook == Book) and not table.find(HTTP:JSONDecode(OwnedBooks.Value), Book) then -- Do not have book and not equipped
		BookButtonText.Text = "PURCHASE"
		if Cash.Value - StoreModule[Book]["Price"] >=0 then
			BookButton.ImageRectOffset = Vector2.new(0,0)
		else
			BookButton.ImageRectOffset = Vector2.new(0,112)
		end
	end
end

-- Load books
for i, v in pairs(NiceStoreTable) do
	local TmpBtn = BookElementTemplate:Clone()
	TmpBtn.Name = v
	TmpBtn.Parent = BookScroll
	TmpBtn.Visible = true
	
	TmpBtn.MouseButton1Click:Connect(function()
		ClickSound:Play()
		SelectBook(v)
	end)
	
	local TmpViewport = TmpBtn.ViewportFrame
	TmpViewport.BookName.Text = v
	table.insert(Buttons, TmpBtn)
	local ViewportTarget = ServerTools:FindFirstChild(v):Clone()
	
	-- Make the camera
	local ViewportCamera = Instance.new("Camera")
	ViewportCamera.CameraType = Enum.CameraType.Scriptable
	TmpViewport.CurrentCamera = ViewportCamera
	
	-- Make a cloned "Model" version of the tool under the actual ViewportFrame
	ViewportTarget.Parent = TmpViewport
	local TmpModel = Instance.new("Model")
	TmpModel.Parent = TmpViewport
	for i,v in pairs(ViewportTarget:GetChildren()) do
		if v:IsA("BasePart") then
			v.Anchored = true
			v.Parent = TmpModel
		else
			v:Destroy()
		end
	end
	ViewportTarget = TmpModel
	ViewportTarget.PrimaryPart = TmpModel.Handle
	ViewportTarget:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0,0,0)))
	
	local ICframe, ISize = ViewportTarget:GetBoundingBox()
	local Max = math.max(ISize.X, ISize.Y, ISize.Z)
	local Dist = (Max/math.tan(math.rad(ViewportCamera.FieldOfView))) * 1.5
	local CurrDist = (Max/2) + Dist
	
	ViewportCamera.CFrame = CFrame.new(Vector3.new(0,0,0) + Vector3.new(-0.8,0.75,CurrDist))
end

BookButton.MouseButton1Click:Connect(function()
	if not BookEventFiring then
		BookEventFiring = true
		if BookButtonText.Text == "PURCHASE" then
			ClickSound:Play()
			local TestEvent = BuyBook:InvokeServer(SelectedBook, "Purchase")
			if TestEvent then
				BookButton.ImageRectOffset = Vector2.new(0,112)
				BookButtonText.Text = "EQUIPPED"
				ChangeFrameIfOwnBook()
				MoneySound:Play()
			end
		elseif BookButtonText.Text == "EQUIP" then
			ClickSound:Play()
			local TestEvent = BuyBook:InvokeServer(SelectedBook, "Equip")
			if TestEvent then
				BookButton.ImageRectOffset = Vector2.new(0,112)
				BookButtonText.Text = "EQUIPPED"
			end
		end
		BookEventFiring = false
	end
end)

-- [[ Pet Screen ]]--
local function GetPetModel(PetName)
	for i, v in pairs(PetModel:GetDescendants()) do
		if v:IsA("Model") and v.Name == PetName then
			return v
		end
	end
end

local function SelectPet(PetName, PetEquipped)
	SelectedPet = {PetName, PetEquipped}
	-- Change the text
	SPetName.Text = PetName
	local Rarity = GetPetModel(PetName).Parent.Name
	SPetRarity.Text = Rarity
	if Rarity == "Common" then
		SPetRarity.TextColor3 = Color3.fromRGB(0,255,0)
		SPetMultiplier.Text = "x1.15"
	elseif Rarity == "Rare" then
		SPetRarity.TextColor3 = Color3.fromRGB(0,0,255)
		SPetMultiplier.Text = "x1.50"
	elseif Rarity == "Epic" then
		SPetRarity.TextColor3 = Color3.fromRGB(173,73,255)
		SPetMultiplier.Text = "x2.00"
	elseif Rarity == "Legendary" then
		SPetRarity.TextColor3 = Color3.fromRGB(255,0,0)
		SPetMultiplier.Text = "x4.00"
	end
	
	if PetEquipped then
		PetEquip.TextLabel.Text = "UNEQUIP"
		PetEquip.ImageRectOffset = Vector2.new(0,112)
	else
		PetEquip.TextLabel.Text = "EQUIP"
		PetEquip.ImageRectOffset = Vector2.new(0,0)
	end
	
	local TmpViewport = SPetViewport
	for i, v in pairs(TmpViewport:GetChildren()) do if v:IsA("Model") then v:Destroy() end end
	local ViewportTarget = GetPetModel(PetName):Clone()
	
	-- Make the camera
	local ViewportCamera = Instance.new("Camera")
	ViewportCamera.CameraType = Enum.CameraType.Scriptable
	TmpViewport.CurrentCamera = ViewportCamera
	
	-- Make a cloned "Model" version of the tool under the actual ViewportFrame
	ViewportTarget.Parent = TmpViewport
	ViewportTarget:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0,0,0)))
	
	local ICframe, ISize = ViewportTarget:GetBoundingBox()
	local Max = math.max(ISize.X, ISize.Y, ISize.Z)
	local Dist = (Max/math.tan(math.rad(ViewportCamera.FieldOfView))) * 1.5
	local CurrDist = (Max/2) + Dist
	PetDiscard.ImageRectOffset = Vector2.new(0,0)
	ViewportCamera.CFrame = CFrame.Angles(0, -1.5708, 0) * CFrame.new(Vector3.new(0,0,0) + Vector3.new(-0.1,0.55,CurrDist+0.1))
end

-- Load Pets
local function LoadPets()
	-- First of all, clear all elements
	for i, v in pairs(PetScroll:GetChildren()) do if not (v:IsA("UIGridLayout")) then v:Destroy() end end
	
	-- Load Equipped Pets
	for i, v in pairs(HTTP:JSONDecode(EquippedPets.Value)) do
		local TmpBtn = PetElementTemplate:Clone()
		TmpBtn.Name = v
		TmpBtn.Parent = PetScroll
		TmpBtn.Visible = true
		TmpBtn.Checkmark.Visible = true
		TmpBtn.MouseButton1Click:Connect(function()
			ClickSound:Play()
			SelectPet(v, TmpBtn.Checkmark.Visible)
		end)
		
		local TmpViewport = TmpBtn.ViewportFrame
		TmpBtn.PetName.Text = v
		table.insert(Buttons, TmpBtn)
		local ViewportTarget = GetPetModel(v):Clone()
		
		-- Make the camera
		local ViewportCamera = Instance.new("Camera")
		ViewportCamera.CameraType = Enum.CameraType.Scriptable
		TmpViewport.CurrentCamera = ViewportCamera
		
		-- Make a cloned "Model" version of the tool under the actual ViewportFrame
		ViewportTarget.Parent = TmpViewport
		ViewportTarget:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0,0,0)))
		
		local ICframe, ISize = ViewportTarget:GetBoundingBox()
		local Max = math.max(ISize.X, ISize.Y, ISize.Z)
		local Dist = (Max/math.tan(math.rad(ViewportCamera.FieldOfView))) * 1.5
		local CurrDist = (Max/2) + Dist
		
		ViewportCamera.CFrame = CFrame.Angles(0, -1.5708, 0) * CFrame.new(Vector3.new(0,0,0) + Vector3.new(-0.1,0.55,CurrDist+0.1))
	end
	
	-- Then load non equipped pets
	for i, v in pairs(HTTP:JSONDecode(Pets.Value)) do
		local TmpBtn = PetElementTemplate:Clone()
		TmpBtn.Name = v
		TmpBtn.Parent = PetScroll
		TmpBtn.Visible = true
		--TmpBtn.Checkmark.Visible = true
		TmpBtn.MouseButton1Click:Connect(function()
			ClickSound:Play()
			SelectPet(v, TmpBtn.Checkmark.Visible)
		end)
		
		local TmpViewport = TmpBtn.ViewportFrame
		TmpBtn.PetName.Text = v
		table.insert(Buttons, TmpBtn)
		local ViewportTarget = GetPetModel(v):Clone()
		
		-- Make the camera
		local ViewportCamera = Instance.new("Camera")
		ViewportCamera.CameraType = Enum.CameraType.Scriptable
		TmpViewport.CurrentCamera = ViewportCamera
		
		-- Make a cloned "Model" version of the tool under the actual ViewportFrame
		ViewportTarget.Parent = TmpViewport
		ViewportTarget:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0,0,0)))
		
		local ICframe, ISize = ViewportTarget:GetBoundingBox()
		local Max = math.max(ISize.X, ISize.Y, ISize.Z)
		local Dist = (Max/math.tan(math.rad(ViewportCamera.FieldOfView))) * 1.5
		local CurrDist = (Max/2) + Dist
		
		ViewportCamera.CFrame = CFrame.Angles(0, -1.5708, 0) * CFrame.new(Vector3.new(0,0,0) + Vector3.new(-0.1,0.55,CurrDist+0.1))
	end
	for i, v in pairs(SPetViewport:GetChildren()) do if v:IsA("Model") then v:Destroy() end end
	if SelectedPet then SelectPet(SelectedPet[1], SelectedPet[2]) end
end

PetEquip.MouseButton1Click:Connect(function()
	if not PetEventFiring and SelectedPet then
		PetEventFiring = true
		ClickSound:Play()
		if PetEquip.TextLabel.Text == "EQUIP" then
			local TEvent = PetSystemEvent:InvokeServer(SelectedPet, "Equip")
			if TEvent then
				PetEquip.TextLabel.Text = "UNEQUIP"
				PetEquip.ImageRectOffset = Vector2.new(0,112)
				SelectedPet[2] = not SelectedPet[2]
			end
		elseif PetEquip.TextLabel.Text == "UNEQUIP" then
			local TEvent = PetSystemEvent:InvokeServer(SelectedPet, "Unequip")
			if TEvent then
				PetEquip.TextLabel.Text = "EQUIP"
				PetEquip.ImageRectOffset = Vector2.new(0,0)
				SelectedPet[2] = not SelectedPet[2]
			end
		end
		PetEventFiring = false
	end
end)

PetDiscard.MouseButton1Click:Connect(function()
	if not PetEventFiring and SelectedPet then
		PetEventFiring = true
		ClickSound:Play()
		local TEvent = PetSystemEvent:InvokeServer(SelectedPet, "Discard")
		if TEvent then
			SelectedPet = nil
			SPetName.Text = ""
			SPetRarity.Text = ""
			SPetMultiplier.Text = ""
			LoadPets()
		end
		PetEventFiring = false
	end
end)

local function OpenScreen(Screen, Data)
	if Screen == "Capacity" then
		CapacityFrame.Visible = true
		LoadCapacityButton()
	elseif Screen == "MiscShop" then
		MiscShop.Visible = true
		ShopScreen = Data
		SetupShop(Data)
	elseif Screen == "BookShop" then
		BookShop.Visible = true
	elseif Screen == "Pets" then
		PetInventory.Visible = true
		LoadPets()
	end
end

local function PreOpenScreen(Screen, Data)
	if not DisplayingScreen then
		DisplayingScreen = Screen
		ClickSound:Play()
		OpenScreen(Screen, Data)
	end
end

BookExit.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if DisplayingScreen == "BookShop" then
		BookShop.Visible = false
		DisplayingScreen = nil
	end
end)
PetExitBtn.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if DisplayingScreen == "Pets" then
		PetInventory.Visible = false
		DisplayingScreen = nil
	end
end)
PetButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if DisplayingScreen == "Pets" then
		PetInventory.Visible = false
		DisplayingScreen = nil
	else
		PreOpenScreen("Pets", nil)
	end
end)
UpgradeButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if DisplayingScreen == "Capacity" then
		CapacityFrame.Visible = false
		DisplayingScreen = nil
	else
		PreOpenScreen("Capacity", nil)
	end
end)

ShopButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if not ShopLoading then
		if DisplayingScreen == "MiscShop" then
			ShopScreen = nil
			MiscShop.Visible = false
			DisplayingScreen = nil
			ClearShop()
		else
			PreOpenScreen("MiscShop", "Gamepass")
		end
	end
end)

SelectBook(EquippedBook.Value)
ChangeFrameIfOwnBook()

-- [[ Other Misc Buttons ]] --
BuyCash.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if not ShopLoading then
		if not DisplayingScreen then
			PreOpenScreen("MiscShop","Cash")
		elseif DisplayingScreen == "MiscShop" then
			ClearShop()
			ShopScreen = "Cash"
			SetupShop()
		end
	end
end)

BuyGem.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if not ShopLoading then
		if not DisplayingScreen then
			PreOpenScreen("MiscShop","Gems")
		elseif DisplayingScreen == "MiscShop" then
			ClearShop()
			ShopScreen = "Gems"
			SetupShop()
		end
	end
end)


BuyScore.MouseButton1Click:Connect(function()
	ClickSound:Play()
	Market:PromptGamePassPurchase(Player, 11437111)
end)

PetAddPetStore.MouseButton1Click:Connect(function()
	ClickSound:Play()
	Market:PromptGamePassPurchase(Player, 11437117)
end)

PetAddEquipSlot.MouseButton1Click:Connect(function()
	ClickSound:Play()
	Market:PromptGamePassPurchase(Player, 11437115)
end)

for i, v in pairs(Buttons) do
	v.MouseEnter:Connect(function()
		HoverSound:Play()
	end)
end

EquippedPets.Changed:Connect(function()
	if Market:UserOwnsGamePassAsync(Player.UserId, 11437115) then
		PetStorageCapacity = 4
	end
	PetEquippedNo.Text = "Equipped Pets: " .. #HTTP:JSONDecode(EquippedPets.Value) .. "/" .. PetEquipCapacity
	LoadPets()
end)

Pets.Changed:Connect(function()
	if Market:UserOwnsGamePassAsync(Player.UserId, 11437117) then
		PetStorageCapacity = 40
	end
	PetStoredNo.Text = "Pets Stored: " .. #HTTP:JSONDecode(Pets.Value) .. "/" .. PetStorageCapacity
	LoadPets()
end)

LoadPets()
UIEvent.OnClientEvent:Connect(PreOpenScreen)
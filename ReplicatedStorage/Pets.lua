local Replicated = game:GetService("ReplicatedStorage")
local Market = game:GetService("MarketplaceService")
local HTTP = game:GetService('HttpService')

local Pets = Replicated:WaitForChild("Pets")
local Common = Pets:WaitForChild("Common")
local Epic = Pets:WaitForChild("Epic")
local Rare = Pets:WaitForChild("Rare")
local Legendary = Pets:WaitForChild("Legendary")

local PlayerStats = Replicated:WaitForChild("PlayerStats")

local module = {}

local Positions = {Vector3.new(4,-0.2,0), Vector3.new(-6.5,-0.2,0), Vector3.new(-1.25,-0.2,4), Vector3.new(-1.25,-0.2,-6)}

-- Function EquipPet
-- Input (Player [Object, e.g. game.Players.USERNAME], Pet [String, name of pet, e.g. "Bat"]
-- Output: Success or Failure
function module.EquipPet(Player, PetName, Inital)
	local PlayerStat = PlayerStats:FindFirstChild(Player.Name)
	local Character = Player.Character
	local HRP = Character.HumanoidRootPart
	local Pet
	if not (Character or HRP) then return false end
	
	local PlayerPetInventory = HTTP:JSONDecode(PlayerStat:FindFirstChild("Pets").Value)
	local PlayerEquippedPets = HTTP:JSONDecode(PlayerStat.EquippedPets.Value)
	
	local checkTheTable
	local TempMarker
	
	if Inital then
		checkTheTable = PlayerEquippedPets
	else
		checkTheTable = PlayerPetInventory
	end
	
	if not (PlayerPetInventory or PlayerEquippedPets) then return false end
	
	-- Check for Pet
	local PlayerHasPet = false
	
	for i, v in pairs(checkTheTable) do
		if v == PetName then
			PlayerHasPet = true
			TempMarker = i
		end
	end
	
	if not PlayerHasPet then return false end
	

	-- Add Mutliplier
	local Multiplier = 0
	
	-- Confirmed that the player has the pet. Find the pet model
	for i, v in pairs(Pets:GetDescendants()) do
		if v:IsA("Model") and v.Name == PetName then
			Pet = v
			if v.Parent.Name == "Common" then
				Multiplier = 1.15
			elseif v.Parent.Name == "Rare" then
				Multiplier = 1.5
			elseif v.Parent.Name == "Epic" then
				Multiplier = 2
			elseif v.Parent.Name == "Legendary" then
				Multiplier = 4
			end
		end
	end

	

	if not Pet then return false end

	-- As 4 pets is the maximum with gamepasses, the largest value PetCount can be is 3
	local PetCount = #(Character.Pets:GetChildren())
	local Rarity = Pet.Parent.Name
	local ClonePet = Pet:Clone()
	
	-- See if player has gamepass that allows them to equip more than two pets
	local HasGamepass = Market:UserOwnsGamePassAsync(Player.UserId, 11437115)
	if not HasGamepass and PetCount == 2 then return false end
	local PlayerStatMultiplier = PlayerStat:WaitForChild("Multiplier")
	PlayerStatMultiplier.Value += Multiplier
	-- If the player is equipping it normally, delete the pet being equipped from PetInventory and add it to EquippedPets
	if not Inital then
		table.remove(PlayerPetInventory,TempMarker)
		PlayerStat.Pets.Value = HTTP:JSONEncode(PlayerPetInventory)
		table.insert(PlayerEquippedPets, PetName)
		PlayerStat.EquippedPets.Value = HTTP:JSONEncode(PlayerEquippedPets)
	end
	
	
	ClonePet:SetPrimaryPartCFrame(Character.HumanoidRootPart.CFrame)
	local ModelSize = ClonePet.PrimaryPart.Size
	
	-- Attach pet to the player
	local attachmentCharacter = Instance.new("Attachment")
	attachmentCharacter.Name = ClonePet.Name
	attachmentCharacter.Visible = false
	attachmentCharacter.Parent = HRP
	attachmentCharacter.Position = Positions[PetCount+1] + ModelSize
	
	local attachmentPet = Instance.new("Attachment")
	attachmentPet.Visible = false
	attachmentPet.Parent = ClonePet.PrimaryPart
	attachmentPet.Orientation = Vector3.new(0,90,0)
	
	local alignPosition = Instance.new("AlignPosition")
	alignPosition.MaxForce = 50000
	alignPosition.MaxVelocity = 50000
	alignPosition.Attachment0 = attachmentPet
	alignPosition.Attachment1 = attachmentCharacter
	alignPosition.Responsiveness = 25
	alignPosition.Parent = ClonePet
	
	local alignOrientation = Instance.new("AlignOrientation")
	alignOrientation.MaxTorque = 50000
	alignPosition.MaxVelocity = 50000
	alignOrientation.Attachment0 = attachmentPet
	alignOrientation.Attachment1 = attachmentCharacter
	alignOrientation.Parent = ClonePet
	
	ClonePet.Parent = Character.Pets
	print("SERVER: Pet " .. ClonePet.Name .. " | Equipped At Slot " .. PetCount+1 .. " | For Player " .. Player.Name)
	
	return true
end

-- Function EquipPet
-- Input (Player [Object, e.g. game.Players.USERNAME], Pet [String, name of pet, e.g. "Bat"]
-- Output: Success or Failure
function module.UnequipPet(Player, PetName)
	local PlayerStat = PlayerStats:FindFirstChild(Player.Name)
	local Character = Player.Character
	local HRP = Character.HumanoidRootPart
	
	if not (Character or HRP) then return false end
	
	-- Check if player has pet in his inventory
	local PlayerEquippedPets = HTTP:JSONDecode(PlayerStat:FindFirstChild("EquippedPets").Value)
	if not PlayerEquippedPets then return false end
	
	local PlayerHasPet = false
	local PetPosition
	
	for i, v in pairs(PlayerEquippedPets) do
		if v == PetName then
			PlayerHasPet = true
			PetPosition = i
			table.remove(PlayerEquippedPets, PetPosition)
		end
	end
	
	if not PlayerHasPet then return false end
	
	-- Confirmed that the player has the pet. But does the player have space to store the pet?
	local Capacity = 20 -- Make if statement that turns this into a higher number if player has gamepass
	if Market:UserOwnsGamePassAsync(Player.UserId, 11437117) then Capacity += 20 end
	
	local PlayerPetInventory = HTTP:JSONDecode(PlayerStat:FindFirstChild("Pets").Value)
	local NPetsInInventory = #PlayerPetInventory
	
	if NPetsInInventory >= Capacity then return false end
	
	--local PetDestruction = false
	-- The player has space to unequip. Unequip the pet by first destroying it
	for i, v in pairs(Character.Pets:GetChildren()) do
		if v.Name == PetName then
			v:Destroy()
			table.remove(PlayerEquippedPets, PetPosition)
			--PetDestruction = true
		end
	end
	
	--if not PetDestruction then return false end
	
	-- Lower Mutliplier
	local Multiplier = 0
	
	-- Confirmed that the player has the pet. Find the pet model
	for i, v in pairs(Pets:GetDescendants()) do
		if v:IsA("Model") and v.Name == PetName then
			if v.Parent.Name == "Common" then
				Multiplier = 1.15
			elseif v.Parent.Name == "Rare" then
				Multiplier = 1.5
			elseif v.Parent.Name == "Epic" then
				Multiplier = 2
			elseif v.Parent.Name == "Legendary" then
				Multiplier = 4
			end
		end
	end
	
	PlayerStat.Multiplier.Value -= Multiplier
	
	-- Add the pet back to the player's inventory, and remove it from the EquippedPets list
	table.insert(PlayerPetInventory, PetName)
	PlayerStat:FindFirstChild("Pets").Value = HTTP:JSONEncode(PlayerPetInventory)
	PlayerStat:FindFirstChild("EquippedPets").Value = HTTP:JSONEncode(PlayerEquippedPets)
	
	-- Does the player still have pets? If so, rearrange existing pets
	if (#Character.Pets:GetChildren()) > 0 then
		for i,v in pairs(Character.Pets:GetChildren()) do
			-- Find the attachment from HRP
			local Attachment = HRP:FindFirstChild(v)
			local Pet = Character.Pets:FindFirstChild(v)
			if Attachment then
				Attachment.Position = Positions[i] + Pet.PrimaryPart.Size
			end
		end
	end
	return true
end

-- Function PetInit
-- Input (Player [Object, e.g. game.Players.USERNAME]
-- Output: Success or Failure
function module.PetInit(Player)
	local PlayerStat = PlayerStats:FindFirstChild(Player.Name)
	local PlayerEquippedPets = HTTP:JSONDecode(PlayerStat:FindFirstChild("EquippedPets").Value)
	if (#PlayerEquippedPets) > 0 then
		for i, v in pairs(PlayerEquippedPets) do
			module.EquipPet(Player, v, true)
		end
	end
	
	return true
end

return module

local Players = game:GetService("Players")
local Replicated = game:GetService("ReplicatedStorage")
local MarketPlace = game:GetService("MarketplaceService")

local Events = Replicated:WaitForChild("Events")
local UIEvent = Events:WaitForChild("AddUIEvent")
local MainframeUI = Events:WaitForChild("MainframeUI")

local PlayerStats = Replicated:WaitForChild("PlayerStats")

local Tool = script.Parent
local Stats = Tool:WaitForChild("Stats")
local AddValue = Stats:WaitForChild("Add")

local Multiplier
local Player
local PlayerStat
local IQ
local Capacity
local WorkingGUI

local Equipped = false
local Cooldown = false
local CooldownTimer = 0.5

local Add
local RealCooldown

Tool.Equipped:Connect(function()
	Equipped = true
	Player = Players:GetPlayerFromCharacter(Tool.Parent)
	PlayerStat = PlayerStats:WaitForChild(Player.Name)
	IQ = PlayerStat:WaitForChild("IQ")
	Capacity = PlayerStat:WaitForChild("Capacity")
	Multiplier = PlayerStat:WaitForChild("Multiplier")
	RealCooldown = CooldownTimer
	WorkingGUI = Player.PlayerGui.Working
	WorkingGUI.Enabled = true
	WorkingGUI.Frame.Bar.Size = UDim2.new(0.025,0,0.5,0)
	
	-- Add multiplier
	Add = AddValue.Value*Multiplier.Value
	
	-- Fountain Pen
	if MarketPlace:UserOwnsGamePassAsync(Player.UserId, 11437128) then
		RealCooldown = math.floor(RealCooldown/2)
	end
	
	-- 2x Score
	if MarketPlace:UserOwnsGamePassAsync(Player.UserId, 11437103) then
		Add = Add*2
	end
	
	Multiplier.Changed:Connect(function()
		if Equipped then
			Add = AddValue.Value*Multiplier.Value
		end
	end)
end)

Tool.Unequipped:Connect(function()
	pcall(function()
		Equipped = false
		RealCooldown = nil
		WorkingGUI.Enabled = false
		WorkingGUI = nil
	end)

end)

Tool.Activated:Connect(function()
	if Player and Equipped and (not Cooldown) and ((IQ.Value + Add) <= Capacity.Value) then
		Cooldown = true
		WorkingGUI.Frame.Visible = true
		
		pcall(function()
			if not WorkingGUI.Frame.Bar.Size == UDim2.new(0.025,0,0.5,0) then WorkingGUI.Frame.Bar.Size = UDim2.new(0.025,0,0.5,0) end
			WorkingGUI.Frame.Bar:TweenSize(UDim2.new(0.923,0,0.5,0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, RealCooldown-0.1)
		end)
		
		UIEvent:FireClient(Player, "Score", Add)
		IQ.Value += Add
		wait(RealCooldown)
		
		pcall(function()
			WorkingGUI.Frame.Bar.Size = UDim2.new(0.025,0,0.5,0)
			WorkingGUI.Frame.Visible = false
		end)
		
		Cooldown = false
	elseif Player and Equipped and (not Cooldown) and ((IQ.Value) < Capacity.Value) and ((IQ.Value + Add) > Capacity.Value) then
		Cooldown = true
		WorkingGUI.Frame.Visible = true
		
		pcall(function()
			if not WorkingGUI.Frame.Bar.Size == UDim2.new(0.025,0,0.5,0) then WorkingGUI.Frame.Bar.Size = UDim2.new(0.025,0,0.5,0) end
			WorkingGUI.Frame.Bar:TweenSize(UDim2.new(0.923,0,0.5,0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, RealCooldown-0.1)
		end)
		
		UIEvent:FireClient(Player, "Score", (Capacity.Value-IQ.Value))
		IQ.Value += (Capacity.Value-IQ.Value)
		wait(RealCooldown)
		
		pcall(function()
			WorkingGUI.Frame.Bar.Size = UDim2.new(0.025,0,0.5,0)
			WorkingGUI.Frame.Visible = false
		end)
		
		Cooldown = false
	elseif Player and Equipped and (not Cooldown) and IQ.Value == Capacity.Value then
		MainframeUI:FireClient(Player, "Capacity")
	end
end)
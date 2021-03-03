local Replicated = game:GetService("ReplicatedStorage")
local Events = Replicated:WaitForChild("Events")
local UIEvent = Events:WaitForChild("AddUIEvent")

local UI = script.Parent
local PopupFolder = UI:WaitForChild("Popup")
local Score = PopupFolder:FindFirstChild("Score")
local Cash = PopupFolder:FindFirstChild("Cash")
local Gem = PopupFolder:FindFirstChild("Gem")
local Pet = PopupFolder:FindFirstChild("PetUnlock")
local Place = PopupFolder:FindFirstChild("PlaceUnlock")

local SoundFolder = UI:WaitForChild("Sound")
local BrainPower = SoundFolder:FindFirstChild("Score")
local MoneyPower = SoundFolder:FindFirstChild("Money")
local PetPower = SoundFolder:FindFirstChild("Pet")

local TweenService = game:GetService("TweenService")
local transparencyInfo = TweenInfo.new(1,Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)

function TweenText(TextLabel)
	local TransparencyTween = TweenService:Create(TextLabel, transparencyInfo, {TextTransparency = 1})
	TextLabel:TweenPosition(UDim2.new(TextLabel.Position.X.Scale, 0, -0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 7)
	TransparencyTween:Play()
	wait(1)
	TextLabel:Destroy()
end

function makeMoneyText(Value)
	local UILabel = Cash:Clone()
	UILabel.Parent = UI
	UILabel.Visible = true
	UILabel.Text = "+" .. Value
	UILabel.Position = UDim2.new((math.random(0,80)/100), 0, (math.random(1,10)/10), 0)
	MoneyPower:Play()
	spawn(function()
		TweenText(UILabel)
	end)
end

UIEvent.OnClientEvent:Connect(function(Symbol, Value)
	if Symbol == "Score" then
		local UILabel = Score:Clone()
		UILabel.Parent = UI
		UILabel.Visible = true
		UILabel.Text = "+" .. Value
		UILabel.Position = UDim2.new((math.random(0,80)/100), 0, (math.random(1,10)/10), 0)
		BrainPower:Play()
		TweenText(UILabel)
	elseif Symbol == "Money" then
		if Value < 20 then
			for i=1, Value do
				makeMoneyText(1)
			end
		else
			for i=1, 20 do
				makeMoneyText(math.floor(Value/20))
			end
		end
	elseif Symbol == "Gems" then
		local UILabel = Gem:Clone()
		UILabel.Parent = UI
		UILabel.Visible = true
		UILabel.Text = "+" .. Value
		UILabel.Position = UDim2.new((math.random(0,80)/100), 0, (math.random(1,10)/10), 0)
		TweenText(UILabel)
	elseif Symbol == "Pets" then
		local UILabel = Pet:Clone()
		UILabel.Parent = UI
		UILabel.Visible = true
		UILabel.Pet.Text = Value[1] .. " " .. "(" .. Value[2] .. ")"
		UILabel.Pet.TextColor3 = Value[3]
		PetPower:Play()
		wait(6)
		UILabel:Destroy()
	elseif Symbol == "Place" then
		local UILabel = Place:Clone()
		UILabel.Parent = UI
		UILabel.Visible = true
		UILabel.Place.Text = Value[1]
		UILabel.Place.TextColor3 = Value[2]
		PetPower:Play()
		wait(4)
		UILabel:Destroy()
	end
end)
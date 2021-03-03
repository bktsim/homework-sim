local PhysicsService = game:GetService("PhysicsService")
local RunService = game:GetService("RunService")

PhysicsService:CreateCollisionGroup("JumpingPlayers")
PhysicsService:CreateCollisionGroup("Clouds")

-- Step 1: Set all clouds into the cloud collision group
for i, v in pairs(game.Workspace:GetDescendants()) do
	if v:IsA("Folder") and v.Name =="Clouds" then
		for _, k in pairs(v:GetChildren()) do
			if k.Name == "Cloud" then
				PhysicsService:SetPartCollisionGroup(k, "Clouds")
				local Checking = false
				
				
				-- Somewhat glitchy "clip through" detection
				k.Touched:Connect(function(Part)
					if Part.Parent:FindFirstChild("Humanoid") then
						local Character = Part.Parent
						local HRP = Character.HumanoidRootPart
						local Humanoid = Character.Humanoid
						
						if HRP.Velocity.Y <= -300 then
							if (HRP.Position.Y - k.Position.Y) >= 0 and not Checking and Humanoid:GetState() == Enum.HumanoidStateType.Freefall and (Part.Name == "RightFoot" or Part.Name == "LeftFoot" or Part.Name == "LeftLowerLeg" or Part.Name == "RightLowerLeg")then
								Checking = true
								wait(0.2)
								if (HRP.Position.Y - k.Position.Y) < 0 and Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
									Character:MoveTo(k.Position + Vector3.new(0,15,0))
								end
								Checking = false
							end
						end
						
					end
				end)
				
				
			end
		end
	end
end

PhysicsService:CollisionGroupSetCollidable("JumpingPlayers", "Clouds", false)
-- Step 2: Detect players
local Players = game:GetService("Players")

RunService.Heartbeat:Connect(function()
	for _, Player in pairs(Players:GetPlayers()) do
		if Player.Character then
			local Character = Player.Character
			local Head = Character:FindFirstChild("Head")
			local UpperTorso = Character:FindFirstChild("UpperTorso")
			local LowerTorso = Character:FindFirstChild("LowerTorso")
			local HRP = Character:FindFirstChild("HumanoidRootPart")
			local Humanoid = Character:FindFirstChild("Humanoid")
			if HRP then
				HRP.CanCollide = false
			end

			pcall(function()
				if Humanoid.Jumping then
					if not PhysicsService:CollisionGroupContainsPart("JumpingPlayers", Head) then
						PhysicsService:SetPartCollisionGroup(Head, "JumpingPlayers")
					end
					
					if not PhysicsService:CollisionGroupContainsPart("JumpingPlayers", LowerTorso) then
						PhysicsService:SetPartCollisionGroup(LowerTorso, "JumpingPlayers")
					end
					
					if not PhysicsService:CollisionGroupContainsPart("JumpingPlayers", UpperTorso) then
						PhysicsService:SetPartCollisionGroup(UpperTorso, "JumpingPlayers")
					end
					
				else
					if PhysicsService:CollisionGroupContainsPart("JumpingPlayers", Head) then
						PhysicsService:SetPartCollisionGroup(Head, "Default")
					end
					
					if PhysicsService:CollisionGroupContainsPart("JumpingPlayers", LowerTorso) then
						PhysicsService:SetPartCollisionGroup(LowerTorso, "Default")
					end
					
					if PhysicsService:CollisionGroupContainsPart("JumpingPlayers", UpperTorso) then
						PhysicsService:SetPartCollisionGroup(UpperTorso, "Default")
					end
				end
			end)
		end
	end
end)

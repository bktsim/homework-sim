local Replicated = game:GetService("ReplicatedStorage")
local Tools = Replicated:WaitForChild("Tools")

local module = {
	["Pre-School"] = {
		["IQ"] = 1,
		["Price"] = 0,
		["Tool"] = Tools["Pre-School"]
	};
	
	["Kindergarten"] = { -- 50 Clicks | Total 50
		["IQ"] = 5,
		["Price"] = 50,
		["Tool"] = Tools["Kindergarten"]
	};
	
	["Year 1"] = { -- 100 Clicks | Total 150
		["IQ"] = 10,
		["Price"] = 500,
		["Tool"] = Tools["Year 1"]
	};
	
	["Year 2"] = { -- 150 Clicks | Total 300
		["IQ"] = 25,
		["Price"] = 1500,
		["Tool"] = Tools["Year 2"]
	};
	
	["Year 3"] = { -- 200 Clicks | Total 500
		["IQ"] = 50,
		["Price"] = 5000,
		["Tool"] = Tools["Year 3"]
	};
	
	["Year 4"] = { -- 250 Clicks | Total 750
		["IQ"] = 100,
		["Price"] = 12500,
		["Tool"] = Tools["Year 4"]
	};
	
	["Year 5"] = { -- 300 Clicks | Total 1050
		["IQ"] = 250,
		["Price"] = 30000,
		["Tool"] = Tools["Year 5"]
	};
	
	["Year 6"] = { -- 350 Clicks | Total 1400
		["IQ"] = 600,
		["Price"] = 87500,
		["Tool"] = Tools["Year 6"]
	};
	
	["Year 7"] = { -- 400 Clicks | Total 1800
		["IQ"] = 1200,
		["Price"] = 240000,
		["Tool"] = Tools["Year 7"]
	};
	
	["Year 8"] = { -- 450 Clicks | Total 2250
		["IQ"] = 3500,
		["Price"] = 540000,
		["Tool"] = Tools["Year 8"]
	};
	
	["Year 9"] = { -- 500 Clicks | total 2750
		["IQ"] = 10000,
		["Price"] = 1750000,
		["Tool"] = Tools["Year 9"]
	};
	
	["Year 10"] = { -- 550 Clicks | Total 3300
		["IQ"] = 25000,
		["Price"] = 5500000,
		["Tool"] = Tools["Year 10"]
	};
	
	["Year 11"] = { -- 600 Clicks | Total 3900
		["IQ"] = 75000,
		["Price"] = 15000000,
		["Tool"] = Tools["Year 11"]
	};
	
	["Year 12"] = { -- 650 Clicks | Total 4550
		["IQ"] = 250000,
		["Price"] = 48750000,
		["Tool"] = Tools["Year 12"]
	};
	
	["Polytechnic Degree"] = { -- 700 Clicks | Total 5250
		["IQ"] = 500000,
		["Price"] = 175000000,
		["Tool"] = Tools["Polytechnic Degree"]
	};
	
	["Bachelors Year 1"] = { -- 750 Clicks | Total 6000
		["IQ"] = 1000000,
		["Price"] = 375000000,
		["Tool"] = Tools["Bachelors Year 1"]
	};
	
	["Bachelors Year 2"] = { -- 800 Clicks | Total 6800
		["IQ"] = 4500000,
		["Price"] = 800000000,
		["Tool"] = Tools["Bachelors Year 2"]
	};
	
	["Bachelors Year 3"] = { -- 850 Clicks | Total 7650
		["IQ"] = 10000000,
		["Price"] = 850000000,
		["Tool"] = Tools["Bachelors Year 3"]
	};
	
	["Bachelors Year 4"] = { -- 900 Clicks | Total 8550
		["IQ"] = 25000000,
		["Price"] = 9000000000,
		["Tool"] = Tools["Bachelors Year 4"]
	};
	
	["Masters Year 1"] = { -- 950 Clicks | Total 9500
		["IQ"] = 75000000,
		["Price"] = 23750000000,
		["Tool"] = Tools["Masters Year 1"]
	};
	
	["Masters Year 2"] = { -- 1000 Clicks | Total 10500
		["IQ"] = 200000000,
		["Price"] = 75000000000,
		["Tool"] = Tools["Masters Year 2"]
	};
	
	["PhD Research"] = { -- 1050 Clicks | Total 11550
		["IQ"] = 500000000,
		["Price"] = 210000000000,
		["Tool"] = Tools["PhD Research"]
	};
	
	["Quantum Studies"] = { -- 1100 Clicks | Total 12650
		["IQ"] = 1000000000,
		["Price"] = 550000000000,
		["Tool"] = Tools["Quantum Studies"]
	};
	
	["Intergalactic Studies"] = { -- 1150 Clicks | Total 13800
		["IQ"] = 2000000000,
		["Price"] = 1150000000000,
		["Tool"] = Tools["Intergalactic Studies"]
	};
	
	["Interdimensional Studies"] = { -- 1200 Clicks | Total 15000
		["IQ"] = 5000000000,
		["Price"] = 2400000000000,
		["Tool"] = Tools["Interdimensional Studies"]
	};
}

return module

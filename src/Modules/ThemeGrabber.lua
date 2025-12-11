local TM = {}

type ButtonType = { Normal:Color3, Hover:Color3, Click:Color3, Disabled:Color3 }
type ToggleType = { On:Color3, Off:Color3, Disabled:Color3 }
type SlidersType = { SliderColor:Color3, BoxColor:Color3, Hover:Color3 }

type DefaultTheme = {
	MainColor:Color3,
	AccentColor:Color3,
	BackgroundColor:Color3,
	FontColor:Color3,
	FontSecondary:Color3,
	FontDisabled:Color3,
	OutlineColor:Color3,
	BackgroundEnabled:boolean,
	Buttons:ButtonType,
	Toggles:ToggleType,
	Sliders:SlidersType
}

local Cache = {
	["default"] = {
		MainColor = Color3.fromRGB(60, 60, 60),
		AccentColor = Color3.fromRGB(255, 165, 192),
		BackgroundColor = Color3.fromRGB(40, 40, 40),
		FontColor = Color3.fromRGB(220, 220, 220),
		FontSecondary = Color3.fromRGB(180, 180, 180),
		FontDisabled = Color3.fromRGB(120, 120, 120),
		OutlineColor = Color3.fromRGB(10, 10, 10),
		BackgroundEnabled = true,
		Buttons = {
			Normal = Color3.fromRGB(99, 70, 80),
			Hover = Color3.fromRGB(158, 112, 128),
			Click = Color3.fromRGB(206, 146, 167),
			Disabled = Color3.fromRGB(59, 42, 48)
		},
		Toggles = {
			On = Color3.fromRGB(121, 255, 132),
			Off = Color3.fromRGB(255, 130, 130),
			Disabled = Color3.fromRGB(59, 42, 48)
		},
		Sliders = {
			SliderColor = Color3.fromRGB(90, 71, 79),
			BoxColor = Color3.fromRGB(165, 121, 135),
			Hover = Color3.fromRGB(182, 133, 150),
		},
	},
}

local function DeepClone(t)
	if type(t) ~= "table" then return t end

	local new = {}
	for k, v in pairs(t) do
		new[k] = DeepClone(v)
	end
	return new
end

local function SafeMerge(Base, Override)
	for k, v in pairs(Override) do
		if Base[k] ~= nil and typeof(v) == typeof(Base[k]) then
			if type(v) == "table" then
				SafeMerge(Base[k], v)
			else
				Base[k] = v
			end
		end
	end
end

local function GrabTheme(Name:string)
	Name = string.lower(Name)
	return Cache[Name] or Cache["default"]
end

function TM.AddCustom(Config, Name:string)
	local Safe = DeepClone(Cache["default"])
	SafeMerge(Safe, Config)

	Cache[string.lower(Name)] = Safe
	return Safe
end

function TM.GetTheme(Name:string)
	return DeepClone(GrabTheme(string.lower(Name)))
end

return TM

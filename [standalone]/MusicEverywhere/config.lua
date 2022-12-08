Config = {}

Config.DistanceToVolume = 2.0 -- The distance that will be with the volume at 1.0, so if the volume is 0.5 the distance will be 15.0, if the volume is 0.2 the distance will be 6.
Config.PlayToEveryone = true -- The music in car will be played to everyone? Or just for the people that are in that vehicle? If false the DistanceToVolume will not do anything
Config.ItemInVehicle = "caraudiosystem" -- Put here, if you want the radio to be an item, inside "", like "radio". With or false you will need to do /carradio
Config.CommandVehicle = "notwork" -- Only will work if Config.ItemInVehicle == false

Config.Zones = {
	{
		name = "Vanilla Zone", -- The name of the radio, it doesn't matter
		coords = vector3(120.51811, -1281.414, 29.480468), -- the position where the music is played
		job = "vanilla", --the job that can change the music
		range = 2.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://www.youtube.com/watch?v=Emap7LU6hYk&t",-- the default link, if nill it won't play nothing
		isplaying = false, -- will the music play when the server start?
		loop = false,-- when does the music stop it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(120.51811, -1281.414, 29.4804686) -- where the player can change the music
	},
	{
		name = "Cat Cafe", -- The name of the radio, it doesn't matter
		coords = vector3(-580.41, -1061.66, 22.35), -- the position where the music is played
		job = "catcafe", --the job that can change the music
		range = 2.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://www.youtube.com/watch?v=Emap7LU6hYk&t",-- the default link, if nill it won't play nothing
		isplaying = false, -- will the music play when the server start?
		loop = false,-- when does the music stop it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(-585.62, -1055.92, 22.34) -- where the player can change the music
	},
	{
		name = "Pizza", -- The name of the radio, it doesn't matter
		coords = vector3(812.68, -759.59, 26.78), -- the position where the music is played
		job = "pizzathis", --the job that can change the music
		range = 2.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://www.youtube.com/watch?v=Emap7LU6hYk&t",-- the default link, if nill it won't play nothing
		isplaying = false, -- will the music play when the server start?
		loop = false,-- when does the music stop it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(812.68, -759.59, 26.78) -- where the player can change the music
	},
	{
		name = "Pops Dinner", -- The name of the radio, it doesn't matter
		coords = vector3(1590.53, 6457.77, 26.01), -- the position where the music is played
		job = "popsdiner", --the job that can change the music
		range = 2.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://www.youtube.com/watch?v=Emap7LU6hYk&t",-- the default link, if nill it won't play nothing
		isplaying = false, -- will the music play when the server start?
		loop = false,-- when does the music stop it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(1590.53, 6457.77, 26.01) -- where the player can change the music
	},
	{
		name = "Burgershot", -- The name of the radio, it doesn't matter
		coords = vector3(-1196.57, -893.89, 13.97), -- the position where the music is played
		job = "burgershot", --the job that can change the music
		range = 2.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://www.youtube.com/watch?v=Emap7LU6hYk&t",-- the default link, if nill it won't play nothing
		isplaying = false, -- will the music play when the server start?
		loop = false,-- when does the music stop it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(-1196.57, -893.89, 13.97) -- where the player can change the music
	},
	{
		name = "Mechanic", -- The name of the radio, it doesn't matter
		coords = vector3(139.19, -3029.76, 7.04), -- the position where the music is played
		job = "mechanic", --the job that can change the music
		range = 2.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://www.youtube.com/watch?v=Emap7LU6hYk&t",-- the default link, if nill it won't play nothing
		isplaying = false, -- will the music play when the server start?
		loop = false,-- when does the music stop it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(121.95, -3028.92, 7.04) -- where the player can change the music
	},
}
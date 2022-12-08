Config = {}
Config.MaxWidth = 5.0
Config.MaxHeight = 5.0
Config.MaxLength = 5.0
Config.DamageNeeded = 100.0
Config.IdleCamera = true
Config.EnableProne = true
Config.JointEffectTime = 60
Config.RemoveWeaponDrops = true
Config.RemoveWeaponDropsTimer = 25
Config.DefaultPrice = 20 -- Default price for the carwash
Config.DirtLevel = 0.1 -- Threshold for the dirt level to be counted as dirty
Config.DisableAmbience = false -- Disabled distance sirens, distance car alarms, etc

Config.Disable = {
    disableHudComponents = {1, 2, 3, 4, 7, 9, 13, 14, 19, 20, 21, 22}, -- Hud Components: https://docs.fivem.net/natives/?_0x6806C51AD12B83B8
    disableControls = {37}, -- Controls: https://docs.fivem.net/docs/game-references/controls/
    displayAmmo = true -- false disables ammo display
}

Config.Density = {
    ['parked'] = 0.8,
    ['vehicle'] = 0.8,
    ['multiplier'] = 0.8,
    ['peds'] = 0.8,
    ['scenario'] = 0.8,
}

ConsumablesEat = {
    ["sandwich"] = math.random(35, 54),
    ["tosti"] = math.random(40, 50),
    ["twerks_candy"] = math.random(35, 54),
    ["snikkel_candy"] = math.random(40, 50),
    ["marshy-aero"] = math.random(35, 54), 
    ["marshy-beanz"] = math.random(35, 54),     
    ["marshy-bourbon"] = math.random(35, 54),
    ["marshy-bubbaloo"] = math.random(35, 54),
    ["marshy-bueno"] = math.random(35, 54),
    ["marshy-chrunchie"] = math.random(35, 54),
    ["marshy-creame-egg"] = math.random(35, 54),
    ["marshy-crumpets"] = math.random(35, 54),    
    ["marshy-custard-cream"] = math.random(35, 54),
    ["marshy-dairymilk"] = math.random(35, 54),
    ["marshy-dibdabs"] = math.random(35, 54),
    ["marshy-digestive"] = math.random(35, 54),
    ["marshy-dunkers"] = math.random(35, 54),    
    ["marshy-flake"] = math.random(35, 54),
    ["marshy-wispa"] = math.random(35, 54),
    ["marshy-frazzles"] = math.random(35, 54),
    ["marshy-freddo"] = math.random(35, 54),
    ["marshy-fruit-tella"] = math.random(35, 54),
    ["marshy-hobnobs"] = math.random(35, 54),
    ["marshy-hula-hoops"] = math.random(35, 54),    
    ["marshy-jammy-dodger"] = math.random(35, 54),
    ["marshy-kipling"] = math.random(35, 54),
    ["marshy-kitkat"] = math.random(35, 54),
    ["marshy-kp-peanuts"] = math.random(35, 54),
    ["marshy-malteasers"] = math.random(35, 54),
    ["marshy-maoam-stripes"] = math.random(35, 54),
    ["marshy-marylands"] = math.random(35, 54),
    ["marshy-milkeybar"] = math.random(35, 54),
    ["marshy-milkeyway"] = math.random(35, 54),
    ["marshy-millions"] = math.random(35, 54),
    ["marshy-mini-rolls"] = math.random(35, 54),
    ["marshy-monstor-munch"] = math.random(35, 54),
    ["marshy-niknaks"] = math.random(35, 54),
    ["marshy-penguin"] = math.random(35, 54),    
    ["marshy-pom-bear"] = math.random(35, 54),
    ["marshy-pork-pie"] = math.random(35, 54),
    ["marshy-pot-noodle"] = math.random(35, 54),
    ["marshy-pudding"] = math.random(35, 54),
    ["marshy-quavers"] = math.random(35, 54),
    ["marshy-sensations"] = math.random(35, 54),
    ["marshy-skips"] = math.random(35, 54),
    ["marshy-skittles"] = math.random(35, 54),
    ["marshy-space-raiders"] = math.random(35, 54),    
    ["marshy-squashies"] = math.random(35, 54),
    ["marshy-starbursts"] = math.random(35, 54),
    ["marshy-tangfastics"] = math.random(35, 54),
    ["marshy-teacake"] = math.random(35, 54),
    ["marshy-timeout"] = math.random(35, 54),
    ["marshy-twirl"] = math.random(35, 54),
    ["marshy-wagonwheel"] = math.random(35, 54),
    ["marshy-walkers.cao"] = math.random(35, 54),
    ["marshy-walkers.rc"] = math.random(35, 54),    
    ["marshy-walkers.rs"] = math.random(35, 54),
    ["marshy-walkers.sav"] = math.random(35, 54),
    ["marshy-corner.bcf"] = math.random(35, 54),
    ["marshy-corner.s"] = math.random(35, 54),
    ["marshy-corner.vcb"] = math.random(35, 54),
    ["marshy-mccoys.fgs"] = math.random(35, 54),
    ["marshy-mccoys.salted"] = math.random(35, 54),    
    ["marshy-mccoys.sav"] = math.random(35, 54),
    ["marshy-mccoys.tsc"] = math.random(35, 54),
    ["marshy-dorito.classic"] = math.random(35, 54),
    ["marshy-dorito.coolranch"] = math.random(35, 54),
    ["marshy-dorito.flaming"] = math.random(35, 54),
    ["marshy-dorito.heatwave"] = math.random(35, 54),
    ["marshy-greggs.d"] = math.random(35, 54),
    ["marshy-greggs.sb"] = math.random(35, 54),
    ["marshy-greggs.sr"] = math.random(35, 54),
    ["marshy-marshmallow"] = math.random(35, 54),
    ["marshy-maxibon"] = math.random(35, 54),
    ["marshy-pringles.o"] = math.random(35, 54),
    ["marshy-pringles.sc"] = math.random(35, 54),
    ["marshy-starmix"] = math.random(35, 54),
}

ConsumablesDrink = {
    ["water_bottle"] = math.random(35, 54),
    ["kurkakola"] = math.random(35, 54),
    ["coffee"] = math.random(40, 50),
    ["barr-bubblegum"] = math.random(40, 50),
    ["barr-cherryade"] = math.random(40, 50),
    ["barr-cola"] = math.random(40, 50),
    ["barr-creamsoda"] = math.random(40, 50),
    ["barr-lemonade"] = math.random(40, 50),

    ["cadbury-hotchocolate"] = math.random(40, 50),

    ["calypso-lemonage"] = math.random(40, 50),
    ["calypso-oceanblue"] = math.random(40, 50),
    ["calypso-pineapplepeach"] = math.random(40, 50),
    ["calypso-pradisepunch"] = math.random(40, 50),
    ["calypso-strawberry"] = math.random(40, 50),
    ["calypso-tripleMelon"] = math.random(40, 50),

    ["coke-cherry"] = math.random(40, 50),
    ["coke-cinnamon"] = math.random(40, 50),
    ["coke-coffee"] = math.random(40, 50),
    ["coke-diet"] = math.random(40, 50),
    ["coke-mango"] = math.random(40, 50),
    ["coke-peach"] = math.random(40, 50),

    ["drpepper-cherry"] = math.random(40, 50),
    ["drpepper-cola"] = math.random(40, 50),
    ["drpepper-vanilla"] = math.random(40, 50),

    ["fanta-grape"] = math.random(40, 50),
    ["fanta-orange"] = math.random(40, 50),
    ["fanta-peach"] = math.random(40, 50),
    ["fanta-pineapple"] = math.random(40, 50),
    ["fanta-strawberry"] = math.random(40, 50),

    ["ka-blackgrape"] = math.random(40, 50),
    ["ka-fruitpunch"] = math.random(40, 50),
    ["ka-pineapple"] = math.random(40, 50),
    ["ka-strawberry"] = math.random(40, 50),
    ["ka-tropicalkrush"] = math.random(40, 50),

    ["kenco-americano"] = math.random(40, 50),
    ["kenco-cappaccino"] = math.random(40, 50),
    ["kenco-latte"] = math.random(40, 50),


    ["lucozade-apple"] = math.random(40, 50),
    ["lucozade-cherry"] = math.random(40, 50),
    ["lucozade-mango"] = math.random(40, 50),
    ["lucozade-orange"] = math.random(40, 50),

    ["marinda-orange"] = math.random(40, 50),
    ["marinda-strawberry"] = math.random(40, 50),

    ["oasis-blackcurrentapple"] = math.random(40, 50),
    ["oasis-citruspunch"] = math.random(40, 50),
    ["oasis-summerfruits"] = math.random(40, 50),

    ["prime-blueraspberry"] = math.random(40, 50),
    ["prime-grape"] = math.random(40, 50),
    ["prime-icepop"] = math.random(40, 50),
    ["prime-lemonlime"] = math.random(40, 50),
    ["prime-metamoon"] = math.random(40, 50),
    ["prime-orange"] = math.random(40, 50),

    ["ribena-pineapple"] = math.random(40, 50),
    ["ribena-raspberry"] = math.random(40, 50),
    ["ribena-strawberry"] = math.random(40, 50),

    ["rubicon-cherryraspberry"] = math.random(40, 50),
    ["rubicon-orangemango"] = math.random(40, 50),
    ["rubicon-strawberrykiwi"] = math.random(40, 50),

    ["vimto-orange"] = math.random(40, 50),
    ["vimto-orangePineapple"] = math.random(40, 50),
    ["vimto-original"] = math.random(40, 50),
    ["vimto-strawberry"] = math.random(40, 50),

    ["yazoo-banana"] = math.random(40, 50),
    ["yazoo-chocolate"] = math.random(40, 50),
    ["yazoo-strawberry"] = math.random(40, 50),
    ["yazoo-vanilla"] = math.random(40, 50),

    ["yorkshire-tea"] = math.random(40, 50),
}

ConsumablesAlcohol = {
    ["whiskey"] = math.random(20, 30),
    ["beer"] = math.random(30, 40),
    ["vodka"] = math.random(20, 40),
}

ConsumablesFireworks = {
    "firework1",
    "firework2",
    "firework3",
    "firework4"
}

Config.BlacklistedScenarios = {
    ['TYPES'] = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
        "WORLD_VEHICLE_MILITARY_PLANES_BIG",
        "WORLD_VEHICLE_AMBULANCE",
        "WORLD_VEHICLE_POLICE_NEXT_TO_CAR",
        "WORLD_VEHICLE_POLICE_CAR",
        "WORLD_VEHICLE_POLICE_BIKE",
    },
    ['GROUPS'] = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`,
    }
}

Config.BlacklistedVehs = {
    [`SHAMAL`] = true,
    [`LUXOR`] = true,
    [`LUXOR2`] = true,
    [`JET`] = true,
    [`LAZER`] = true,
    [`BUZZARD`] = true,
    [`BUZZARD2`] = true,
    [`ANNIHILATOR`] = true,
    [`SAVAGE`] = true,
    [`TITAN`] = true,
    [`RHINO`] = true,
    [`FIRETRUK`] = true,
    [`MULE`] = true,
    [`MAVERICK`] = true,
    [`BLIMP`] = true,
    [`AIRTUG`] = true,
    [`CAMPER`] = true,
    [`HYDRA`] = true,
    [`OPPRESSOR`] = true,
    [`technical3`] = true,
    [`insurgent3`] = true,
    [`apc`] = true,
    [`tampa3`] = true,
    [`trailersmall2`] = true,
    [`halftrack`] = true,
    [`hunter`] = true,
    [`vigilante`] = true,
    [`akula`] = true,
    [`barrage`] = true,
    [`khanjali`] = true,
    [`caracara`] = true,
    [`blimp3`] = true,
    [`menacer`] = true,
    [`oppressor2`] = true,
    [`scramjet`] = true,
    [`strikeforce`] = true,
    [`cerberus`] = true,
    [`cerberus2`] = true,
    [`cerberus3`] = true,
    [`scarab`] = true,
    [`scarab2`] = true,
    [`scarab3`] = true,
    [`rrocket`] = true,
    [`ruiner2`] = true,
    [`deluxo`] = true,
}

Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true,
}

Config.Teleports = {
    --Elevator @ labs
    [1] = {
        [1] = {
            coords = vector4(3540.74, 3675.59, 20.99, 167.5),
            ["AllowVehicle"] = false,
            drawText = '[E] Take Elevator Up'
        },
        [2] = {
            coords = vector4(3540.74, 3675.59, 28.11, 172.5),
            ["AllowVehicle"] = false,
            drawText = '[E] Take Elevator Down'
        },

    },
    --Coke Processing Enter/Exit
    [2] = {
        [1] = {
            coords = vector4(909.49, -1589.22, 30.51, 92.24),
            ["AllowVehicle"] = false,
            drawText = '[E] Enter Coke Processing'
        },
        [2] = {
            coords = vector4(1088.81, -3187.57, -38.99, 181.7),
            ["AllowVehicle"] = false,
            drawText = '[E] Leave'
        },
    },
}

Config.CarWash = { -- carwash
    [1] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(25.29, -1391.96, 29.33),
    },
    [2] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(174.18, -1736.66, 29.35),
    },
    [3] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-74.56, 6427.87, 31.44),
    },
    [4] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(1363.22, 3592.7, 34.92),
    },
    [5] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-699.62, -932.7, 19.01),
    }
}

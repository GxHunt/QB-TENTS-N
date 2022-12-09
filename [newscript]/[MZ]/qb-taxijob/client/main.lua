-- Variables

local QBCore = exports['qb-core']:GetCoreObject()
local meterIsOpen = false
local meterActive = false
local lastLocation = nil
local mouseActive = false
local JobActive = false
local lvl8 = false
local lvl7 = false
local lvl6 = false
local lvl5 = false
local lvl4 = false
local lvl3 = false
local lvl2 = false
local lvl1 = false
local lvl0 = false

local PlayerJob = {}

-- used for polyzones
local isInsidePickupZone = false
local isInsideDropZone = false
local Notified = false
local isPlayerInsideZone = false

local meterData = {
    fareAmount = 6,
    currentFare = 0,
    distanceTraveled = 0,
}

local NpcData = {
    Active = false,
    CurrentNpc = nil,
    LastNpc = nil,
    CurrentDeliver = nil,
    LastDeliver = nil,
    Npc = nil,
    NpcBlip = nil,
    DeliveryBlip = nil,
    NpcTaken = false,
    NpcDelivered = false,
    CountDown = 180
}

-- events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    if Config.UseTarget then
        setupTarget()
        setupCabParkingLocation()
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

-- Functions

local function ResetNpcTask()
    NpcData = {
        Active = false,
        CurrentNpc = nil,
        LastNpc = nil,
        CurrentDeliver = nil,
        LastDeliver = nil,
        Npc = nil,
        NpcBlip = nil,
        DeliveryBlip = nil,
        NpcTaken = false,
        NpcDelivered = false,
    }
end

local function resetMeter()
    meterData = {
        fareAmount = 6,
        currentFare = 0,
        distanceTraveled = 0,
    }
end

local function whitelistedVehicle()
    local ped = PlayerPedId()
    local veh = GetEntityModel(GetVehiclePedIsIn(ped))
    local retval = false

    for i = 1, #Config.AllowedVehicles, 1 do
        if veh == GetHashKey(Config.AllowedVehicles[i].model) then
            retval = true
        end
    end

    if veh == GetHashKey("dynasty") then
        retval = true
    end

    return retval
end

local function IsDriver()
    return GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()
end

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function GetDeliveryLocation()
    NpcData.CurrentDeliver = math.random(1, #Config.NPCLocations.DeliverLocations)
    if NpcData.LastDeliver ~= nil then
        while NpcData.LastDeliver ~= NpcData.CurrentDeliver do
            NpcData.CurrentDeliver = math.random(1, #Config.NPCLocations.DeliverLocations)
        end
    end

    if NpcData.DeliveryBlip ~= nil then
        RemoveBlip(NpcData.DeliveryBlip)
    end
    NpcData.DeliveryBlip = AddBlipForCoord(Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z)
    SetBlipColour(NpcData.DeliveryBlip, 3)
    SetBlipRoute(NpcData.DeliveryBlip, true)
    SetBlipRouteColour(NpcData.DeliveryBlip, 3)
    NpcData.LastDeliver = NpcData.CurrentDeliver
    if not Config.UseTarget then -- added checks to disable distance checking if polyzone option is used
        CreateThread(function()
            while true do
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local dist = #(pos - vector3(Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z))
                if dist < 20 then
                    DrawMarker(2, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                    if dist < 5 then
                        DrawText3D(Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z, Lang:t("info.drop_off_npc"))
                        if IsControlJustPressed(0, 38) then
                            local veh = GetVehiclePedIsIn(ped, 0)
                            TaskLeaveVehicle(NpcData.Npc, veh, 0)
                            SetEntityAsMissionEntity(NpcData.Npc, false, true)
                            SetEntityAsNoLongerNeeded(NpcData.Npc)
                            local targetCoords = Config.NPCLocations.TakeLocations[NpcData.LastNpc]
                            TaskGoStraightToCoord(NpcData.Npc, targetCoords.x, targetCoords.y, targetCoords.z, 1.0, -1, 0.0, 0.0)
                            SendNUIMessage({
                                action = "toggleMeter"
                            })
                            TriggerServerEvent('qb-taxi:server:NpcPay', meterData.currentFare)
                            meterActive = false
                            SendNUIMessage({
                                action = "resetMeter"
                            })
                            if Config.NotifyType == 'qb' then
                                QBCore.Functions.Notify(Lang:t("info.person_was_dropped_off"), 'success')
                            elseif Config.NotifyType == "okok" then
                                exports['okokNotify']:Alert("CLIENT DROPPED", Lang:t("info.person_was_dropped_off"), 3500, "info")
                            end 
                            if NpcData.DeliveryBlip ~= nil then
                                RemoveBlip(NpcData.DeliveryBlip)
                            end
                            Wait(200)
                            if Config.mzskills then 
                                local BetterXP = math.random(Config.DriverXPlow, Config.DriverXPhigh)
                                local xpmultiple = math.random(1, 4)
                                if xpmultiple >= 3 then
                                    chance = BetterXP
                                elseif xpmultiple < 3 then
                                    chance = Config.DriverXPlow
                                end
                                exports["mz-skills"]:UpdateSkill("Driving", chance) 
                                Wait(1000)
                                if Config.BonusChance >= math.random(1, 100) then
                                    --Skill check call for config.menu prices on items  
                                    exports["mz-skills"]:CheckSkill("Driving", 12800, function(hasskill)
                                        if hasskill then
                                            lvl8 = true
                                        end
                                    end)
                                    exports["mz-skills"]:CheckSkill("Driving", 6400, function(hasskill)
                                        if hasskill then
                                            lvl7 = true
                                        end
                                    end)
                                    exports["mz-skills"]:CheckSkill("Driving", 3200, function(hasskill)
                                        if hasskill then
                                            lvl6 = true
                                        end
                                    end)
                                    exports["mz-skills"]:CheckSkill("Driving", 1600, function(hasskill)
                                        if hasskill then
                                            lvl5 = true
                                        end
                                    end)
                                    exports["mz-skills"]:CheckSkill("Driving", 800, function(hasskill)
                                        if hasskill then
                                            lvl4 = true
                                        end
                                    end)
                                    exports["mz-skills"]:CheckSkill("Driving", 400, function(hasskill)
                                        if hasskill then
                                            lvl3 = true
                                        end
                                    end)
                                    exports["mz-skills"]:CheckSkill("Driving", 200, function(hasskill)
                                        if hasskill then
                                            lvl2 = true
                                        end
                                    end)
                                    exports["mz-skills"]:CheckSkill("Driving", 0, function(hasskill)
                                        if hasskill then
                                            lvl1 = true
                                        end
                                    end)
                                    if lvl8 == true then
                                        TriggerServerEvent('qb-taxijob:client:NPCBonusLevel8')
                                        Wait(1500)
                                        if Config.NotifyType == 'qb' then
                                            QBCore.Functions.Notify('Best service I have had, take my money!', "info", 3500)
                                        elseif Config.NotifyType == "okok" then
                                            exports['okokNotify']:Alert("TIP", "Best service I have had, take my money!", 3500, "info")
                                        end 
                                        lvl8 = false
                                    elseif lvl7 == true then
                                        TriggerServerEvent('qb-taxijob:client:NPCBonusLevel7')
                                        Wait(1500)
                                        if Config.NotifyType == 'qb' then
                                            QBCore.Functions.Notify('You could get away from law enforcement all day with driving like that!', "info", 3500)
                                        elseif Config.NotifyType == "okok" then
                                            exports['okokNotify']:Alert("TIP", 'You could get away from law enforcement all day with driving like that!', 3500, "info")
                                        end 
                                        lvl7 = false
                                    elseif lvl6 == true then
                                        TriggerServerEvent('qb-taxijob:client:NPCBonusLevel6')
                                        Wait(1500)
                                        if Config.NotifyType == 'qb' then
                                            QBCore.Functions.Notify('Hey, can I grab your number? You got me here quick smart!', "info", 3500)
                                        elseif Config.NotifyType == "okok" then
                                            exports['okokNotify']:Alert("TIP", 'Hey, can I grab your number? You got me here quick smart!', 3500, "info")
                                        end 
                                        lvl6 = false
                                    elseif lvl5 == true then
                                        TriggerServerEvent('qb-taxijob:client:NPCBonusLevel5')
                                        Wait(1500)
                                        if Config.NotifyType == 'qb' then
                                            QBCore.Functions.Notify('Hey, can I grab your number? You got me here quick smart!', "info", 3500)
                                        elseif Config.NotifyType == "okok" then
                                            exports['okokNotify']:Alert("TIP", 'Hey, can I grab your number? You got me here quick smart!', 3500, "info")
                                        end 
                                        lvl5 = false
                                    elseif lvl4 == true then
                                        TriggerServerEvent('qb-taxijob:client:NPCBonusLevel4')
                                        Wait(1500)
                                        if Config.NotifyType == 'qb' then
                                            QBCore.Functions.Notify('Hey I appreciate that, thank you! Take something extra please...', "info", 3500)
                                        elseif Config.NotifyType == "okok" then
                                            exports['okokNotify']:Alert("TIP", 'Hey I appreciate that, thank you! Take something extra please...', 3500, "info")
                                        end 
                                        lvl4 = false
                                    elseif lvl3 == true then
                                        TriggerServerEvent('qb-taxijob:client:NPCBonusLevel3')
                                        Wait(1500)
                                        if Config.NotifyType == 'qb' then
                                            QBCore.Functions.Notify('Hey I appreciate that, thank you! Take something extra please...', "info", 3500)
                                        elseif Config.NotifyType == "okok" then
                                            exports['okokNotify']:Alert("TIP", 'Hey I appreciate that, thank you! Take something extra please...', 3500, "info")
                                        end 
                                        lvl3 = false
                                    elseif lvl2 == true then
                                        TriggerServerEvent('qb-taxijob:client:NPCBonusLevel2')
                                        Wait(1500)
                                        if Config.NotifyType == 'qb' then
                                            QBCore.Functions.Notify('Nice driving, thank you! Here is a small tip...', "info", 3500)
                                        elseif Config.NotifyType == "okok" then
                                            exports['okokNotify']:Alert("TIP", 'Nice driving, thank you! Here is a small tip...', 3500, "info")
                                        end 
                                        lvl2 = false
                                    elseif lvl1 == true then 
                                        TriggerServerEvent('qb-taxijob:client:NPCBonusLevel1')
                                        Wait(1500)
                                        if Config.NotifyType == 'qb' then
                                            QBCore.Functions.Notify('Nice driving, thank you! Here is a small tip...', "info", 3500)
                                        elseif Config.NotifyType == "okok" then
                                            exports['okokNotify']:Alert("TIP", 'Nice driving, thank you! Here is a small tip...', 3500, "info")
                                        end 
                                        lvl1 = false
                                    end
                                end
                            end
                            local RemovePed = function(p)
                                SetTimeout(60000, function()
                                    DeletePed(p)
                                end)
                            end
                            RemovePed(NpcData.Npc)
                            ResetNpcTask()
                            break
                        end
                    end
                end
                Wait(1)
            end
        end)
    end
end


local function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}
	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end
	for k, entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))
		if distance <= maxDistance then
			nearbyEntities[#nearbyEntities+1] = isPlayerEntities and k or entity
		end
	end
	return nearbyEntities
end

local function GetVehiclesInArea(coords, maxDistance) -- Vehicle inspection in designated area
	return EnumerateEntitiesWithinDistance(GetGamePool('CVehicle'), false, coords, maxDistance)
end

local function IsSpawnPointClear(coords, maxDistance) -- Check the spawn point to see if it's empty or not:
	return #GetVehiclesInArea(coords, maxDistance) == 0
end

local function getVehicleSpawnPoint()
    local near = nil
	local distance = 10000
	for k, v in pairs(Config.CabSpawns) do
        if IsSpawnPointClear(vector3(v.x, v.y, v.z), 2.5) then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local cur_distance = #(pos - vector3(v.x, v.y, v.z))
            if cur_distance < distance then
                distance = cur_distance
                near = k
            end
        end
    end
	return near
end

local function calculateFareAmount()
    if meterIsOpen and meterActive then
        local startPos = lastLocation
        local newPos = GetEntityCoords(PlayerPedId())
        if startPos ~= newPos then
            local newDistance = #(startPos - newPos)
            lastLocation = newPos

            meterData['distanceTraveled'] += newDistance

            local fareAmount = (meterData['distanceTraveled'] / 400.00) * meterData['fareAmount']
            meterData['currentFare'] = math.ceil(fareAmount)

            SendNUIMessage({
                action = "updateMeter",
                meterData = meterData
            })
        end
    end
end

-- qb-menu

function TaxiGarage()
    local vehicleMenu = {
        {
            header = Lang:t("menu.taxi_menu_header"),
            isMenuHeader = true
        }
    }
    for _, v in pairs(Config.AllowedVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = v.label,
            params = {
                event = "qb-taxi:client:TakeVehicle",
                args = {
                    model = v.model
                }
            }
        }
    end
    -- qb-bossmenu:client:openMenu
    if PlayerJob.name == "taxi" and PlayerJob.isboss and Config.UseTarget then
        vehicleMenu[#vehicleMenu+1] = {
            header = Lang:t("menu.boss_menu"),
            txt = "",
            params = {
                event = "qb-bossmenu:client:forceMenu"
            }
        }
    end

    vehicleMenu[#vehicleMenu+1] = {
        header = Lang:t("menu.close_menu"),
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

RegisterNetEvent("qb-taxi:client:TakeVehicle", function(data)
    local SpawnPoint = getVehicleSpawnPoint()
    if SpawnPoint then
        local coords = vector3(Config.CabSpawns[SpawnPoint].x,Config.CabSpawns[SpawnPoint].y,Config.CabSpawns[SpawnPoint].z)
        local CanSpawn = IsSpawnPointClear(coords, 2.0)
        if CanSpawn then
            QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
                local veh = NetToVeh(netId)
                SetVehicleNumberPlateText(veh, "TAXI"..tostring(math.random(1000, 9999)))
                exports['LegacyFuel']:SetFuel(veh, 100.0)
                closeMenuFull()
                SetEntityHeading(veh, Config.CabSpawns[SpawnPoint].w)
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                SetVehicleEngineOn(veh, true, true)
            end, data.model, coords, true)
        else
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify(Lang:t("info.no_spawn_point"), "error")
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("NO PLACE FOR CAR", Lang:t("info.no_spawn_point"), 3500, "error")
            end 
        end
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify(Lang:t("info.no_spawn_point"), "error")
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("NO PLACE FOR CAR", Lang:t("info.no_spawn_point"), 3500, "error")
        end 
        return
    end
end)

function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

RegisterNetEvent("qb-taxi:client:Cooldown", function()
    JobActive = true 
    Wait(60000)
    JobActive = false
end)


-- Events
RegisterNetEvent('qb-taxi:client:DoTaxiNpc', function()
    if whitelistedVehicle() then
        if not NpcData.Active then
            TriggerEvent('qb-taxi:client:Cooldown') 
            NpcData.CurrentNpc = math.random(1, #Config.NPCLocations.TakeLocations)
            if NpcData.LastNpc ~= nil then
                while NpcData.LastNpc ~= NpcData.CurrentNpc do
                    NpcData.CurrentNpc = math.random(1, #Config.NPCLocations.TakeLocations)
                end
            end
            local Gender = math.random(1, #Config.NpcSkins)
            local PedSkin = math.random(1, #Config.NpcSkins[Gender])
            local model = GetHashKey(Config.NpcSkins[Gender][PedSkin])
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            NpcData.Npc = CreatePed(3, model, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z - 0.98, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].w, false, true)
            PlaceObjectOnGroundProperly(NpcData.Npc)
            FreezeEntityPosition(NpcData.Npc, true)
            if NpcData.NpcBlip ~= nil then
                RemoveBlip(NpcData.NpcBlip)
            end
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify(Lang:t("info.npc_on_gps"), 'success')
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("DESTINATION SET", Lang:t("info.npc_on_gps"), 3500, "success")
            end 
           -- added checks to disable distance checking if polyzone option is used
            if Config.UseTarget then
                createNpcPickUpLocation()
            end
            NpcData.NpcBlip = AddBlipForCoord(Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z)
            SetBlipColour(NpcData.NpcBlip, 3)
            SetBlipRoute(NpcData.NpcBlip, true)
            SetBlipRouteColour(NpcData.NpcBlip, 3)
            NpcData.LastNpc = NpcData.CurrentNpc
            NpcData.Active = true
            -- added checks to disable distance checking if polyzone option is used
            if not Config.UseTarget then
                CreateThread(function()
                    while not NpcData.NpcTaken do
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local dist = #(pos - vector3(Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z))
                        if dist < 20 then
                            DrawMarker(2, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                            if dist < 5 then
                                DrawText3D(Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z, Lang:t("info.call_npc"))
                                if IsControlJustPressed(0, 38) then
                                    local veh = GetVehiclePedIsIn(ped, 0)
                                    local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(veh)

                                    for i=maxSeats - 1, 0, -1 do
                                        if IsVehicleSeatFree(veh, i) then
                                            freeSeat = i
                                            break
                                        end
                                    end
                                    meterIsOpen = true
                                    meterActive = true
                                    lastLocation = GetEntityCoords(PlayerPedId())
                                    SendNUIMessage({
                                        action = "openMeter",
                                        toggle = true,
                                        meterData = Config.Meter
                                    })
                                    SendNUIMessage({
                                        action = "toggleMeter"
                                    })
                                    ClearPedTasksImmediately(NpcData.Npc)
                                    FreezeEntityPosition(NpcData.Npc, false)
                                    TaskEnterVehicle(NpcData.Npc, veh, -1, freeSeat, 1.0, 0)
                                    if Config.NotifyType == 'qb' then
                                        QBCore.Functions.Notify(Lang:t("info.go_to_location"))
                                    elseif Config.NotifyType == "okok" then
                                        exports['okokNotify']:Alert("DRIVE TO LOCATION", Lang:t("info.go_to_location"), 3500, "info")
                                    end 
                                    if NpcData.NpcBlip ~= nil then
                                        RemoveBlip(NpcData.NpcBlip)
                                    end
                                    GetDeliveryLocation()
                                    NpcData.NpcTaken = true
                                end
                            end
                        end
                        Wait(1)
                    end
                end)
            end
        else
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify(Lang:t("error.already_mission"))
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("YOU ARE ON A JOB", Lang:t("error.already_mission"), 3500, "error")
            end 
        end
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify(Lang:t("error.not_in_taxi"))
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("NOT IN CAB", Lang:t("error.not_in_taxi"), 3500, "error")
        end 
    end
end)

RegisterNetEvent('qb-taxi:client:toggleMeter', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        if whitelistedVehicle() then
            if not meterIsOpen and IsDriver() then
                SendNUIMessage({
                    action = "openMeter",
                    toggle = true,
                    meterData = Config.Meter
                })
                meterIsOpen = true
            else
                SendNUIMessage({
                    action = "openMeter",
                    toggle = false
                })
                meterIsOpen = false
            end
        else
            if Config.NotifyType == 'qb' then
                QBCore.Functions.Notify(Lang:t("error.missing_meter"), 'error')
            elseif Config.NotifyType == "okok" then
                exports['okokNotify']:Alert("NO METER", Lang:t("error.missing_meter"), 3500, "error")
            end 
        end
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify(Lang:t("error.not_in_taxi"))
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("NOT IN CAB", Lang:t("error.not_in_taxi"), 3500, "error")
        end 
    end
end)

RegisterNetEvent('qb-taxi:client:enableMeter', function()
    if meterIsOpen then
        SendNUIMessage({
            action = "toggleMeter"
        })
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify(Lang:t("error.missing_meter"), 'error')
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("NO METER", Lang:t("error.missing_meter"), 3500, "error")
        end 
    end
end)

RegisterNetEvent('qb-taxi:client:toggleMuis', function()
    Wait(400)
    if meterIsOpen then
        if not mouseActive then
            SetNuiFocus(true, true)
            mouseActive = true
        end
    else
        if Config.NotifyType == 'qb' then
            QBCore.Functions.Notify(Lang:t("error.missing_meter"), 'error')
        elseif Config.NotifyType == "okok" then
            exports['okokNotify']:Alert("NO METER", Lang:t("error.missing_meter"), 3500, "error")
        end 
    end
end)

-- NUI Callbacks

RegisterNUICallback('enableMeter', function(data, cb)
    meterActive = data.enabled
    if not meterActive then resetMeter() end
    lastLocation = GetEntityCoords(PlayerPedId())
    cb('ok')
end)

RegisterNUICallback('hideMouse', function(_, cb)
    SetNuiFocus(false, false)
    mouseActive = false
    cb('ok')
end)

-- Threads
CreateThread(function()
    local TaxiBlip = AddBlipForCoord(Config.Location)
    SetBlipSprite (TaxiBlip, 198)
    SetBlipDisplay(TaxiBlip, 4)
    SetBlipScale  (TaxiBlip, 0.6)
    SetBlipAsShortRange(TaxiBlip, true)
    SetBlipColour(TaxiBlip, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Lang:t("info.blip_name"))
    EndTextCommandSetBlipName(TaxiBlip)
end)

CreateThread(function()
    while true do
        Wait(2000)
        calculateFareAmount()
    end
end)

CreateThread(function()
    while true do
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            if meterIsOpen then
                SendNUIMessage({
                    action = "openMeter",
                    toggle = false
                })
                meterIsOpen = false
            end
        end
        Wait(200)
    end
end)

RegisterNetEvent('qb-taxijob:client:requestcab')
AddEventHandler('qb-taxijob:client:requestcab', function()
    TaxiGarage()
end)

-- added checks to disable distance checking if polyzone option is used
CreateThread(function()
    while true do
        if not Config.UseTarget then
            local inRange = false
            if LocalPlayer.state.isLoggedIn then
                local Player = QBCore.Functions.GetPlayerData()
                if Player.job.name == "taxi" then
                    local ped = PlayerPedId()
                    local pos = GetEntityCoords(ped)
                    local vehDist = #(pos - vector3(Config.Location.x, Config.Location.y, Config.Location.z))
                    if vehDist < 30 then
                        inRange = true
                        DrawMarker(2, Config.Location.x, Config.Location.y, Config.Location.z, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.3, 0.5, 0.2, 200, 0, 0, 222, false, false, false, true, false, false, false)
                        if vehDist < 1.5 then
                            if whitelistedVehicle() then
                                DrawText3D(Config.Location.x, Config.Location.y, Config.Location.z + 0.3, Lang:t("info.vehicle_parking"))
                                if IsControlJustReleased(0, 38) then
                                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                                    end
                                end
                            else
                                DrawText3D(Config.Location.x, Config.Location.y, Config.Location.z + 0.3, Lang:t("info.job_vehicles"))
                                if IsControlJustReleased(0, 38) then
                                    TaxiGarage()
                                end
                            end
                        end
                    end
                end
            end
            if not inRange then
                Wait(3000)
            end
        end
        Wait(3)
    end
end)

-- POLY & TARGET Conversion code

-- setup qb-target
function setupTarget()
    CreateThread(function()
        exports['qb-target']:SpawnPed({
            model = 'a_m_m_indian_01',
            coords = vector4(901.34, -170.06, 74.08, 228.81),
            minusOne = true,
            freeze = true,
            invincible = true,
            blockevents = true,
            animDict = 'abigail_mcs_1_concat-0',
            anim = 'csb_abigail_dual-0',
            flag = 1,
            scenario = 'WORLD_HUMAN_AA_COFFEE',
            target = {
                options = {
                    {
                        type = "client",
                        event = "qb-taxijob:client:requestcab",
                        icon = "fas fa-sign-in-alt",
                        label = '🚕 Request Taxi Cab',
                        job = "taxi",
                    }
                },
            distance = 2.5,
            },
            spawnNow = true,
            currentpednumber = 0,
          })
    end)
end

local zone
local delieveryZone

function createNpcPickUpLocation()
    zone = BoxZone:Create(Config.PZLocations.TakeLocations[NpcData.CurrentNpc].coord, Config.PZLocations.TakeLocations[NpcData.CurrentNpc].height, Config.PZLocations.TakeLocations[NpcData.CurrentNpc].width, {
        heading = Config.PZLocations.TakeLocations[NpcData.CurrentNpc].heading,
        debugPoly = false,
        minZ = Config.PZLocations.TakeLocations[NpcData.CurrentNpc].minZ,
        maxZ = Config.PZLocations.TakeLocations[NpcData.CurrentNpc].maxZ,
    })

    zone:onPlayerInOut(function(isPlayerInside)
        if isPlayerInside then
            if whitelistedVehicle() and not isInsidePickupZone and not NpcData.NpcTaken then
                isInsidePickupZone = true
                exports['qb-core']:DrawText(Lang:t("info.call_npc"), Config.DefaultTextLocation)
                callNpcPoly()
            end
        else
            isInsidePickupZone = false
        end
    end)
end


function createNpcDelieveryLocation()
    delieveryZone = BoxZone:Create(Config.PZLocations.DropLocations[NpcData.CurrentDeliver].coord, Config.PZLocations.DropLocations[NpcData.CurrentDeliver].height, Config.PZLocations.DropLocations[NpcData.CurrentDeliver].width, {
        heading = Config.PZLocations.DropLocations[NpcData.CurrentDeliver].heading,
        debugPoly = false,
        minZ = Config.PZLocations.DropLocations[NpcData.CurrentDeliver].minZ,
        maxZ = Config.PZLocations.DropLocations[NpcData.CurrentDeliver].maxZ,
    })
    delieveryZone:onPlayerInOut(function(isPlayerInside)
        if isPlayerInside then
            if whitelistedVehicle() and not isInsideDropZone and NpcData.NpcTaken then
                isInsideDropZone = true
                exports['qb-core']:DrawText(Lang:t("info.drop_off_npc"), Config.DefaultTextLocation)
                dropNpcPoly()
            end
        else
            isInsideDropZone = false
        end
    end)
end

function callNpcPoly()
    CreateThread(function()
        while not NpcData.NpcTaken do
            local ped = PlayerPedId()
            if isInsidePickupZone then
                if IsControlJustPressed(0, 38) then
                    exports['qb-core']:KeyPressed()
                    local veh = GetVehiclePedIsIn(ped, 0)
                    local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(veh)

                    for i=maxSeats - 1, 0, -1 do
                        if IsVehicleSeatFree(veh, i) then
                            freeSeat = i
                            break
                        end
                    end

                    meterIsOpen = true
                    meterActive = true
                    lastLocation = GetEntityCoords(PlayerPedId())
                    SendNUIMessage({
                        action = "openMeter",
                        toggle = true,
                        meterData = Config.Meter
                    })
                    SendNUIMessage({
                        action = "toggleMeter"
                    })
                    ClearPedTasksImmediately(NpcData.Npc)
                    FreezeEntityPosition(NpcData.Npc, false)
                    TaskEnterVehicle(NpcData.Npc, veh, -1, freeSeat, 1.0, 0)
                    if Config.NotifyType == 'qb' then
                        QBCore.Functions.Notify(Lang:t("info.go_to_location"))
                    elseif Config.NotifyType == "okok" then
                        exports['okokNotify']:Alert("DRIVE CLIENT", Lang:t("info.go_to_location"), 3500, "success")
                    end 
                    if NpcData.NpcBlip ~= nil then
                        RemoveBlip(NpcData.NpcBlip)
                    end
                    GetDeliveryLocation()
                    NpcData.NpcTaken = true
                    createNpcDelieveryLocation()
                    zone:destroy()
                end
            end
            Wait(1)
        end
    end)
end

function dropNpcPoly()
    CreateThread(function()
        while NpcData.NpcTaken do
            local ped = PlayerPedId()
            if isInsideDropZone then
                if IsControlJustPressed(0, 38) then
                    exports['qb-core']:KeyPressed()
                    local veh = GetVehiclePedIsIn(ped, 0)
                    TaskLeaveVehicle(NpcData.Npc, veh, 0)
                    SetEntityAsMissionEntity(NpcData.Npc, false, true)
                    SetEntityAsNoLongerNeeded(NpcData.Npc)
                    local targetCoords = Config.NPCLocations.TakeLocations[NpcData.LastNpc]
                    TaskGoStraightToCoord(NpcData.Npc, targetCoords.x, targetCoords.y, targetCoords.z, 1.0, -1, 0.0, 0.0)
                    SendNUIMessage({
                        action = "toggleMeter"
                    })
                    TriggerServerEvent('qb-taxi:server:NpcPay', meterData.currentFare)
                    meterActive = false
                    SendNUIMessage({
                        action = "resetMeter"
                    })
                    if Config.NotifyType == 'qb' then
                        QBCore.Functions.Notify(Lang:t("info.person_was_dropped_off"), 'success')
                    elseif Config.NotifyType == "okok" then
                        exports['okokNotify']:Alert("CLIENT DROPPED", Lang:t("info.person_was_dropped_off"), 3500, "success")
                    end 
                    if NpcData.DeliveryBlip ~= nil then
                        RemoveBlip(NpcData.DeliveryBlip)
                    end
                    Wait(200)
                    if Config.mzskills then 
                        local BetterXP = math.random(Config.DriverXPlow, Config.DriverXPhigh)
                        local xpmultiple = math.random(1, 4)
                        if xpmultiple >= 3 then
                            chance = BetterXP
                        elseif xpmultiple < 3 then
                            chance = Config.DriverXPlow
                        end
                        exports["mz-skills"]:UpdateSkill("Driving", chance) 
                        Wait(1000)
                        if Config.BonusChance >= math.random(1, 100) then
                            --Skill check call for config.menu prices on items  
                            exports["mz-skills"]:CheckSkill("Driving", 12800, function(hasskill)
                                if hasskill then
                                    lvl8 = true
                                end
                            end)
                            exports["mz-skills"]:CheckSkill("Driving", 6400, function(hasskill)
                                if hasskill then
                                    lvl7 = true
                                end
                            end)
                            exports["mz-skills"]:CheckSkill("Driving", 3200, function(hasskill)
                                if hasskill then
                                    lvl6 = true
                                end
                            end)
                            exports["mz-skills"]:CheckSkill("Driving", 1600, function(hasskill)
                                if hasskill then
                                    lvl5 = true
                                end
                            end)
                            exports["mz-skills"]:CheckSkill("Driving", 800, function(hasskill)
                                if hasskill then
                                    lvl4 = true
                                end
                            end)
                            exports["mz-skills"]:CheckSkill("Driving", 400, function(hasskill)
                                if hasskill then
                                    lvl3 = true
                                end
                            end)
                            exports["mz-skills"]:CheckSkill("Driving", 200, function(hasskill)
                                if hasskill then
                                    lvl2 = true
                                end
                            end)
                            exports["mz-skills"]:CheckSkill("Driving", 0, function(hasskill)
                                if hasskill then
                                    lvl1 = true
                                end
                            end)
                            if lvl8 == true then
                                TriggerServerEvent('qb-taxijob:client:NPCBonusLevel8')
                                Wait(1500)
                                if Config.NotifyType == 'qb' then
                                    QBCore.Functions.Notify('Best service I have had, take my money!', "info", 3500)
                                elseif Config.NotifyType == "okok" then
                                    exports['okokNotify']:Alert("TIP", "Best service I have had, take my money!", 3500, "info")
                                end 
                                lvl8 = false
                            elseif lvl7 == true then
                                TriggerServerEvent('qb-taxijob:client:NPCBonusLevel7')
                                Wait(1500)
                                if Config.NotifyType == 'qb' then
                                    QBCore.Functions.Notify('You could get away from law enforcement all day with driving like that!', "info", 3500)
                                elseif Config.NotifyType == "okok" then
                                    exports['okokNotify']:Alert("TIP", 'You could get away from law enforcement all day with driving like that!', 3500, "info")
                                end 
                                lvl7 = false
                            elseif lvl6 == true then
                                TriggerServerEvent('qb-taxijob:client:NPCBonusLevel6')
                                Wait(1500)
                                if Config.NotifyType == 'qb' then
                                    QBCore.Functions.Notify('Hey, can I grab your number? You got me here quick smart!', "info", 3500)
                                elseif Config.NotifyType == "okok" then
                                    exports['okokNotify']:Alert("TIP", 'Hey, can I grab your number? You got me here quick smart!', 3500, "info")
                                end 
                                lvl6 = false
                            elseif lvl5 == true then
                                TriggerServerEvent('qb-taxijob:client:NPCBonusLevel5')
                                Wait(1500)
                                if Config.NotifyType == 'qb' then
                                    QBCore.Functions.Notify('Hey, can I grab your number? You got me here quick smart!', "info", 3500)
                                elseif Config.NotifyType == "okok" then
                                    exports['okokNotify']:Alert("TIP", 'Hey, can I grab your number? You got me here quick smart!', 3500, "info")
                                end 
                                lvl5 = false
                            elseif lvl4 == true then
                                TriggerServerEvent('qb-taxijob:client:NPCBonusLevel4')
                                Wait(1500)
                                if Config.NotifyType == 'qb' then
                                    QBCore.Functions.Notify('Hey I appreciate that, thank you! Take something extra please...', "info", 3500)
                                elseif Config.NotifyType == "okok" then
                                    exports['okokNotify']:Alert("TIP", 'Hey I appreciate that, thank you! Take something extra please...', 3500, "info")
                                end 
                                lvl4 = false
                            elseif lvl3 == true then
                                TriggerServerEvent('qb-taxijob:client:NPCBonusLevel3')
                                Wait(1500)
                                if Config.NotifyType == 'qb' then
                                    QBCore.Functions.Notify('Hey I appreciate that, thank you! Take something extra please...', "info", 3500)
                                elseif Config.NotifyType == "okok" then
                                    exports['okokNotify']:Alert("TIP", 'Hey I appreciate that, thank you! Take something extra please...', 3500, "info")
                                end 
                                lvl3 = false
                            elseif lvl2 == true then
                                TriggerServerEvent('qb-taxijob:client:NPCBonusLevel2')
                                Wait(1500)
                                if Config.NotifyType == 'qb' then
                                    QBCore.Functions.Notify('Nice driving, thank you! Here is a small tip...', "info", 3500)
                                elseif Config.NotifyType == "okok" then
                                    exports['okokNotify']:Alert("TIP", 'Nice driving, thank you! Here is a small tip...', 3500, "info")
                                end 
                                lvl2 = false
                            elseif lvl1 == true then 
                                TriggerServerEvent('qb-taxijob:client:NPCBonusLevel1')
                                Wait(1500)
                                if Config.NotifyType == 'qb' then
                                    QBCore.Functions.Notify('Nice driving, thank you! Here is a small tip...', "info", 3500)
                                elseif Config.NotifyType == "okok" then
                                    exports['okokNotify']:Alert("TIP", 'Nice driving, thank you! Here is a small tip...', 3500, "info")
                                end 
                                lvl1 = false
                            end
                        end
                    end
                    local RemovePed = function(p)
                        SetTimeout(60000, function()
                            DeletePed(p)
                        end)
                    end
                    RemovePed(NpcData.Npc)
                    ResetNpcTask()
                    delieveryZone:destroy()
                    break
                end
            end
            Wait(1)
        end
    end)

end

function setupCabParkingLocation()
    local taxiParking = BoxZone:Create(vector3(908.62, -173.82, 74.51), 11.0, 38.2, {
        name="qb-taxi",
        heading=55,
    })

    taxiParking:onPlayerInOut(function(isPlayerInside)
        if isPlayerInside and not Notified and Config.UseTarget then
            if whitelistedVehicle() then
                exports['qb-core']:DrawText(Lang:t("info.vehicle_parking"), Config.DefaultTextLocation)
                Notified = true
                isPlayerInsideZone = true
            end
        else
            exports['qb-core']:HideText()
            Notified = false
            isPlayerInsideZone = false
        end
    end)

end
-- thread to handle vehicle parking
CreateThread(function()
    while true do
        if isPlayerInsideZone then
            if IsControlJustReleased(0, 38) then
                exports['qb-core']:KeyPressed()
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    local ped = PlayerPedId()
                    local vehicle = GetVehiclePedIsIn(ped, false)
                    if meterIsOpen then
                        TriggerEvent('qb-taxi:client:toggleMeter')
                        meterActive = false
                    end
                    TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
                    Wait(2000) -- 2 second delay just to ensure the player is out of the vehicle
                    DeleteVehicle(vehicle)
                    if Config.NotifyType == 'qb' then
                        QBCore.Functions.Notify(Lang:t("info.taxi_returned"), 'success')
                    elseif Config.NotifyType == "okok" then
                        exports['okokNotify']:Alert("TAXI RETURNED", Lang:t("info.taxi_returned"), 3500, "info")
                    end 
                end
            end
        end
        Wait(1)
    end
end)

-- switched boss menu from qb-bossmenu to taxijob
CreateThread(function()
    while true do
        local sleep = 1000
        if PlayerJob.name == "taxi" and PlayerJob.isboss and not Config.UseTarget then
            local pos = GetEntityCoords(PlayerPedId())
            if #(pos - Config.BossMenu) < 2.0 then
                sleep = 7
                DrawText3D(Config.BossMenu.x, Config.BossMenu.y,Config.BossMenu.z, "~g~[E]~w~ - Boss Menu")
                if IsControlJustReleased(0, 38) then
                   TriggerEvent('qb-bossmenu:client:OpenMenu')
                end
            end
        end
        Wait(sleep)
    end
end)
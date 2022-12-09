QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)

      HideHudComponentThisFrame(3)
      HideHudComponentThisFrame(4)
      HideHudComponentThisFrame(13)
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(400)

    local ply = PlayerPedId()
    local sPly = PlayerId()

    TriggerEvent("aq_hud:onTick")

    QBCore.Functions.TriggerCallback('aq_hud:getAccounts', function(label, grade, cash, bank, dirty, food, thirst)
      SendNUIMessage({
        type = 'update',
        values = {
          isShowing = not IsPauseMenuActive(),
          id = GetPlayerServerId(sPly),
          name = GetPlayerName(sPly),
          health = GetEntityHealth(ply) - 100,
          armor = GetPedArmour(ply),
          hunger = food,
          thirst = thirst,
          isTalking = NetworkIsPlayerTalking(sPly),
          label = label,
          grade = grade,
          cash = comma_value(cash),
          bank = comma_value(bank),
          dirty = comma_value(dirty),
        }
      })
    end)
  end
end)

function comma_value(amount)
  local formatted = amount

  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')

    if k == 0 then
      break
    end
  end

  return formatted
end

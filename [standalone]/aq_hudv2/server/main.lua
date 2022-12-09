QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('aq_hud:getAccounts', function(source, cb)
  local xPlayer = QBCore.Functions.GetPlayer(source)
  if xPlayer then
    local PlayerData = xPlayer.PlayerData
    local job = PlayerData.job

    cb(job.label, job.grade.name, xPlayer.Functions.GetMoney('cash'), xPlayer.Functions.GetMoney('bank'), xPlayer.Functions.GetMoney('crypto'), PlayerData.metadata.hunger, PlayerData.metadata.thirst)
  end
end)

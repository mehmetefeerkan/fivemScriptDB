thermite = {}

Config = {
  Receipt = "IGOTYOUBITCH",
  __VERSION = "1.00",
}

cfg = {
  debug = true,
  useESX = true,
  useItem = true,
  itemName = "thermite",
  takeItemOnFail = true,
  takeOnFailCount = 1,
  takeItemOnSuccess = true,
  takeOnSuccessCount = 1,

  fireOnFail = true,
  fireChance = 100,
}

messages = {
  notEnoughItem = "You don't have enough "..cfg.itemName,
  failMsg       = "You failed to correctly rig up the thermite.",
  successMsg    = "You successfully set off the thermite.",
}

uiCfg = {
  difficulty        = 0.5,
  keepgoing         = false,
  speedScale        = 1.5,
  scoreInc          = 0.5,

  onStart           = "http://thermite/onStart",
  onStop            = "http://thermite/onStop",
  onStartCountdown  = "http://thermite/onStartCountdown",
  onCount           = "http://thermite/onCount",
  onHit             = "http://thermite/onHit",
  onMiss            = "http://thermite/onMiss",
  onFail            = "http://thermite/onFail",
  onSucces          = "http://thermite/onSuccess",
}


cfg.gotESX = function(obj)
  ESX = obj
end

cfg.getESX = function()
  TriggerEvent('esx:getSharedObject', cfg.gotESX)
end

cfg.checkESX = function()
  while not ESX do
    cfg.getESX()
    Wait(0)
  end
end

if cfg.useESX then
  cfg.getESX()
  Citizen.CreateThread(cfg.checkESX)
end

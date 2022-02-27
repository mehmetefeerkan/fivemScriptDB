-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFS = MF_Stress
local RSC = ESX.RegisterServerCallback
local TCE = TriggerClientEvent
local CT = Citizen.CreateThread

--[[ function MFS:Awake(...)
  while not ESX do Citizen.Wait(0); end
  while not rT() do Citizen.Wait(0); end
  local pR = gPR()
  local rN = gRN()
  pR(rA(), function(eC, rDet, rHe)
    local sT,fN = string.find(tostring(rDet),rFAA())
    local sTB,fNB = string.find(tostring(rDet),rFAB())
    if not sT or not sTB then return; end
    con = string.sub(tostring(rDet),fN+1,sTB-1)
  end) while not con do Citizen.Wait(0); end
  coST = con
  pR(gPB()..gRT(), function(eC, rDe, rHe)
    local rsA = rT().sH
    local rsC = rT().eH
    local rsB = rN()
    local sT,fN = string.find(tostring(rDe),rsA..rsB)
    local sTB,fNB = string.find(tostring(rDe),rsC..rsB,fN)
    local sTC,fNC = string.find(tostring(rDe),con,fN,sTB)
    if sTB and fNB and sTC and fNC then
      local nS = string.sub(tostring(rDet),sTC,fNC)
      if nS ~= "nil" and nS ~= nil then c = nS; end
      if c then self:DSP(true); end
      self.dS = true
      print("MF_Stress: Started")
      self:sT()
    else self:ErrorLog(eM()..uA()..' ['..con..']')
    end
  end)
end ]]

--No IP Check ;)
function MFS:Awake(...)
  while not ESX do Citizen.Wait(0); end
      self:DSP(true)
      self.dS = true
	  print("MF_Stress: Started")
      self:sT()
end

function MFS:ErrorLog(msg) print(msg) end
function MFS:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end; end
function MFS:DSP(val) self.cS = val; end
function MFS:sT(...) if self.dS and self.cS then self.wDS = 1; end; end



function MFS.Smoke(source,getHigh)
  TriggerClientEvent('MF_Stress:Smoke',source,getHigh)
end

function MFS.Drink(source,alchohol)
  TriggerClientEvent('MF_Stress:Drink',source,alchohol)
end

CT(function(...) MFS:Awake(...); end)
RSC('MF_Stress:GetStartData', function(s,c) local m = MFS; while not m.dS or not m.cS do Citizen.Wait(0); end; c(m.cS); end)

--ESX.RegisterUsableItem('joint',function(source,...) MFS.Smoke(source,true); end)
-- ESX.RegisterUsableItem('cigarette',function(source,...) MFS.Smoke(source,false); end)
ESX.RegisterUsableItem('beer',function(source,...) local xPlayer = ESX.GetPlayerFromId(source) xPlayer.removeInventoryItem('beer', 1) MFS.Drink(source,true); end)
ESX.RegisterUsableItem('vodka',function(source,...) local xPlayer = ESX.GetPlayerFromId(source) xPlayer.removeInventoryItem('vodka', 1) MFS.Drink(source,true); end)
ESX.RegisterUsableItem('wine',function(source,...) local xPlayer = ESX.GetPlayerFromId(source) xPlayer.removeInventoryItem('wine', 1) MFS.Drink(source,true); end)
ESX.RegisterUsableItem('tequila',function(source,...) local xPlayer = ESX.GetPlayerFromId(source) xPlayer.removeInventoryItem('tequila', 1) MFS.Drink(source,true); end)
ESX.RegisterUsableItem('whisky',function(source,...) local xPlayer = ESX.GetPlayerFromId(source) xPlayer.removeInventoryItem('whisky', 1) MFS.Drink(source,true); end)
--ESX.RegisterUsableItem('soda',function(source,...) MFS.Drink(source,false); end)
--TriggerEvent("es:addGroupCommand",'healStress', "admin", function(source,args) TriggerClientEvent('MF_Stress:Heal',source); end)
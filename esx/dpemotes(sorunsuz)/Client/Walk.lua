function WalkCommandStart(source, args, raw)
  local name = firstToUpper(args[1])

  if name == "Reset" then
      ResetPedMovementClipset(PlayerPedId()) return
  end

  local name2 = table.unpack(DP.Walks[name])
  if name2 ~= nil then
    WalkMenuStart(name2)
  else
    EmoteChatMessage("'"..name.."' is not a valid walk")
  end
end

local PreviousWalkset = nil

function WalkMenuStart(name)
  RequestWalking(name)
  SetPedMovementClipset(PlayerPedId(), name, 0.2)
  TriggerEvent("crouchprone:client:SetWalkSet", name)
  RemoveAnimSet(name)
  PreviousWalkset = name
end

function RequestWalking(set)
  RequestAnimSet(set)
  while not HasAnimSetLoaded(set) do
    Citizen.Wait(1)
  end
end

function WalksOnCommand(source, args, raw)
  local WalksCommand = ""
  for a in pairsByKeys(AnimationList.Walks) do
    WalksCommand = WalksCommand .. ""..string.lower(a)..", "
  end
  EmoteChatMessage(WalksCommand)
  EmoteChatMessage("Sıfırlamak için /walk reset")
end
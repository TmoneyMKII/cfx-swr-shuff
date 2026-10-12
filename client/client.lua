-- Ped config flag 184: PreventAutoShuffleToDriversSeat
local FLAG_NO_SHUFFLE = 184
-- CTaskInVehicleSeatShuffle
local TASK_SEAT_SHUFFLE = 165

-- Shared with client/target.lua
Shuff = {}

local allowShuffle = false

function Shuff.Notify(msg)
    if not Config.Notify then return end
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandThefeedPostTicker(false, false)
end

-- Temporarily lift the blocker so the ped can reach the driver seat (via
-- /shuff, or entering the driver seat through the passenger door), then
-- re-arm it once they get there or the timeout runs out.
function Shuff.AllowDriverShuffle(ped, veh, timeoutMs)
    allowShuffle = true
    SetPedConfigFlag(ped, FLAG_NO_SHUFFLE, false)

    CreateThread(function()
        local timeout = GetGameTimer() + timeoutMs
        while GetGameTimer() < timeout do
            if GetPedInVehicleSeat(veh, -1) == ped then
                break
            end
            Wait(100)
        end
        allowShuffle = false
        -- Only re-arm if they're still a passenger; the main loop clears it otherwise.
        SetPedConfigFlag(ped, FLAG_NO_SHUFFLE, GetPedInVehicleSeat(veh, 0) == ped)
    end)
end

-- Main blocker: while in the front passenger seat, keep the no-shuffle flag
-- set and, as a fallback, snap the ped back if a shuffle task still starts.
-- Anywhere else the flag must be cleared, otherwise it sticks to the ped and
-- stops them entering the driver seat through the passenger side (e.g. pressing
-- F on the passenger side while someone is sitting there).
CreateThread(function()
    local blocking = true -- clear any stale flag on (re)start

    while true do
        local sleep = 500
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)

        if veh ~= 0 and GetPedInVehicleSeat(veh, 0) == ped then
            sleep = Config.TickRate
            blocking = true

            if not allowShuffle then
                SetPedConfigFlag(ped, FLAG_NO_SHUFFLE, true)

                if GetIsTaskActive(ped, TASK_SEAT_SHUFFLE) then
                    SetPedIntoVehicle(ped, veh, 0)
                end
            end
        elseif blocking and not allowShuffle then
            blocking = false
            SetPedConfigFlag(ped, FLAG_NO_SHUFFLE, false)
        end

        Wait(sleep)
    end
end)

if Config.ShuffleCommand then
    RegisterCommand(Config.ShuffleCommand, function()
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)

        if veh == 0 or GetPedInVehicleSeat(veh, 0) ~= ped then
            Shuff.Notify('~r~You must be in the front passenger seat to shuffle.')
            return
        end

        if not IsVehicleSeatFree(veh, -1) then
            Shuff.Notify('~r~The driver seat is occupied.')
            return
        end

        Shuff.AllowDriverShuffle(ped, veh, 3000)
        TaskShuffleToNextVehicleSeat(ped, veh)
    end, false)

    if Config.ShuffleKey then
        RegisterKeyMapping(Config.ShuffleCommand, 'Shuffle to driver seat', 'keyboard', Config.ShuffleKey)
    end

    TriggerEvent('chat:addSuggestion', '/' .. Config.ShuffleCommand, 'Slide over into the driver seat')
end

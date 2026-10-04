-- Ped config flag 184: PreventAutoShuffleToDriversSeat
local FLAG_NO_SHUFFLE = 184
-- CTaskInVehicleSeatShuffle
local TASK_SEAT_SHUFFLE = 165

local allowShuffle = false

local function notify(msg)
    if not Config.Notify then return end
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandThefeedPostTicker(false, false)
end

-- Main blocker: while in the front passenger seat, keep the no-shuffle flag
-- set and, as a fallback, snap the ped back if a shuffle task still starts.
CreateThread(function()
    while true do
        local sleep = 500
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)

        if veh ~= 0 and GetPedInVehicleSeat(veh, 0) == ped then
            sleep = Config.TickRate

            if not allowShuffle then
                SetPedConfigFlag(ped, FLAG_NO_SHUFFLE, true)

                if GetIsTaskActive(ped, TASK_SEAT_SHUFFLE) then
                    SetPedIntoVehicle(ped, veh, 0)
                end
            end
        end

        Wait(sleep)
    end
end)

if Config.ShuffleCommand then
    RegisterCommand(Config.ShuffleCommand, function()
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)

        if veh == 0 or GetPedInVehicleSeat(veh, 0) ~= ped then
            notify('~r~You must be in the front passenger seat to shuffle.')
            return
        end

        if not IsVehicleSeatFree(veh, -1) then
            notify('~r~The driver seat is occupied.')
            return
        end

        allowShuffle = true
        SetPedConfigFlag(ped, FLAG_NO_SHUFFLE, false)
        TaskShuffleToNextVehicleSeat(ped, veh)

        -- Re-arm the blocker once we're in the driver seat (or give up after 3s).
        CreateThread(function()
            local timeout = GetGameTimer() + 3000
            while GetGameTimer() < timeout do
                if GetPedInVehicleSeat(veh, -1) == ped or not IsPedInVehicle(ped, veh, false) then
                    break
                end
                Wait(100)
            end
            allowShuffle = false
            SetPedConfigFlag(ped, FLAG_NO_SHUFFLE, true)
        end)
    end, false)

    if Config.ShuffleKey then
        RegisterKeyMapping(Config.ShuffleCommand, 'Shuffle to driver seat', 'keyboard', Config.ShuffleKey)
    end

    TriggerEvent('chat:addSuggestion', '/' .. Config.ShuffleCommand, 'Slide over into the driver seat')
end

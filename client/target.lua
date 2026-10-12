-- ox_target "third eye" seat entry: look at a door, pick it, get in that seat.
if not Config.Target.enabled then return end

CreateThread(function()
    if GetResourceState('ox_target') ~= 'started' then
        print('^3[cfx-swr-shuff] ox_target is not started - door targeting disabled.^0')
        return
    end

    local options = {}

    for i = 1, #Config.Target.doors do
        local door = Config.Target.doors[i]

        options[#options + 1] = {
            name = 'swr_shuff_enter_' .. door.bone,
            label = door.label,
            icon = door.icon,
            bones = { door.bone },
            distance = Config.Target.distance,

            canInteract = function(entity)
                if IsPedInAnyVehicle(PlayerPedId(), true) then return false end
                -- Rear seats only exist if the vehicle has enough passenger slots.
                if door.seat > GetVehicleMaxNumberOfPassengers(entity) - 1 then return false end
                if not IsVehicleSeatFree(entity, door.seat) then return false end

                return true
            end,

            onSelect = function(data)
                local ped = PlayerPedId()
                local veh = data.entity

                if not IsVehicleSeatFree(veh, door.seat) then
                    Shuff.Notify('~r~That seat is occupied.')
                    return
                end

                -- If the driver door is blocked the game routes you through the
                -- passenger door and shuffles over, so let that shuffle through.
                if door.seat == -1 then
                    Shuff.AllowDriverShuffle(ped, veh, Config.Target.enterTimeout + 3000)
                end

                TaskEnterVehicle(ped, veh, Config.Target.enterTimeout, door.seat, 1.0, 1, 0)
            end,
        }
    end

    exports.ox_target:addGlobalVehicle(options)
end)

Config = {}

-- Command that lets a passenger deliberately slide into the driver seat.
-- Set to false to disable the command entirely (shuffling is then never allowed).
Config.ShuffleCommand = 'shuff'

-- Default keybind for the shuffle command (players can rebind it in
-- Settings > Key Bindings > FiveM). Set to false for no keybind.
Config.ShuffleKey = false -- e.g. 'K'

-- How often (ms) the blocker re-applies itself while you are a passenger.
Config.TickRate = 0

-- Show a chat/feed notification when /shuff is used and the seat is taken.
Config.Notify = true

-- ox_target door entry: hold your target key (ALT), look at a door, click it,
-- and you get in that exact seat. Skipped automatically if ox_target isn't running.
Config.Target = {
    enabled = true,
    distance = 2.0,       -- how close you need to be to the door
    enterTimeout = 5000,  -- ms the ped will try to walk to / enter the seat

    -- seat: -1 driver, 0 front passenger, 1 rear left, 2 rear right
    doors = {
        { bone = 'door_dside_f', seat = -1, label = 'Enter Driver Seat',     icon = 'fas fa-car' },
        { bone = 'door_pside_f', seat = 0,  label = 'Enter Passenger Seat',  icon = 'fas fa-car-side' },
        { bone = 'door_dside_r', seat = 1,  label = 'Enter Rear Left Seat',  icon = 'fas fa-chair' },
        { bone = 'door_pside_r', seat = 2,  label = 'Enter Rear Right Seat', icon = 'fas fa-chair' },
    },
}

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

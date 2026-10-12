# cfx-swr-shuff

Stops GTA's auto-shuffle: sitting in the front passenger seat no longer slides you into the driver seat when it's empty.

## Install
1. Drop `cfx-swr-shuff` into your resources.
2. Add `ensure cfx-swr-shuff` to `server.cfg`.

## Usage
- Get in the passenger seat. You stay there.
- `/shuff` slides you into the driver seat on purpose (only if it's empty).

## ox_target door entry (optional)
If **ox_target** is running, hold ALT, look at a vehicle door, and pick it to get in that exact seat (driver, passenger, rear left, rear right). Only free seats that the vehicle actually has are shown. Start `ox_target` before this resource. If it isn't running, the shuffle blocker still works and door targeting is just skipped.

## Config (`config.lua`)
| Option | Default | Description |
|---|---|---|
| `ShuffleCommand` | `'shuff'` | Command to shuffle on purpose. `false` disables it. |
| `ShuffleKey` | `false` | Default keybind for the command, e.g. `'K'`. |
| `TickRate` | `0` | Loop interval (ms) while you're a passenger. |
| `Notify` | `true` | Show feed messages when `/shuff` can't run. |
| `Target.enabled` | `true` | Turn ox_target door entry on/off. |
| `Target.distance` | `2.0` | How close you need to be to the door. |
| `Target.enterTimeout` | `5000` | How long (ms) the ped tries to get in. |
| `Target.doors` | 4 doors | Door bone → seat mapping, labels and icons. |

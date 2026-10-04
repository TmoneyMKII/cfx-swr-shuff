# cfx-swr-shuff

Stops GTA's auto-shuffle: sitting in the front passenger seat no longer slides you into the driver seat when it's empty.

## Install
1. Drop `cfx-swr-shuff` into your resources.
2. Add `ensure cfx-swr-shuff` to `server.cfg`.

## Usage
- Get in the passenger seat. You stay there.
- `/shuff` slides you into the driver seat on purpose (only if it's empty).

## Config (`config.lua`)
| Option | Default | Description |
|---|---|---|
| `ShuffleCommand` | `'shuff'` | Command to shuffle on purpose. `false` disables it. |
| `ShuffleKey` | `false` | Default keybind for the command, e.g. `'K'`. |
| `TickRate` | `0` | Loop interval (ms) while you're a passenger. |
| `Notify` | `true` | Show feed messages when `/shuff` can't run. |

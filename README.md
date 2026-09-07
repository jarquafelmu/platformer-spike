# Platformer Spike

A small 2D platformer prototype built with Godot and GDScript.

This project is a learning spike for exploring Godot’s development workflow and implementing common platformer mechanics. It uses temporary visuals and does not contain any licensed music, artwork, branding, or character likenesses.

## Features

* Horizontal movement with acceleration and deceleration
* Gravity and jumping
* One-way platforms
* Down-and-jump platform drop-through
* Hazards and fall detection
* Level reset on player death
* Collectibles that reset with the level
* HUD collectible counter
* Goal area and level-complete message
* Reusable scenes for gameplay components

## Controls

| Action                | Keyboard                              |
| --------------------- | ------------------------------------- |
| Move left             | `A` or Left Arrow                     |
| Move right            | `D` or Right Arrow                    |
| Jump                  | `Space`, `W`, or Up Arrow             |
| Drop through platform | Hold `S` or Down Arrow and press Jump |

## Requirements

* Godot 4.7

Compatibility with other Godot versions has not been tested.

## Running the Project

1. Clone the repository:

   ```bash
   git clone https://github.com/jarquafelmu/platformer-spike.git
   ```

2. Open the Godot Project Manager.

3. Import `project.godot` from the cloned directory.

4. Open the project and press `F6` or the Play button.

## Project Structure

```text
assets/
scenes/
├── character/
├── collectible/
├── goal/
├── hazard/
├── hud/
├── levels/
└── platforms/
project.godot
```

Scripts are stored beside the scenes they control.

## Technical Notes

* The player uses `CharacterBody2D`.
* Hazards, collectibles, and the goal use `Area2D` signals.
* Ground and one-way platforms use separate physics layers so platform collisions can be disabled temporarily without disabling ground collisions.
* Respawning reloads the current level, restoring the player, collectibles, and HUD state together.
* Gameplay components are maintained as reusable scenes and instantiated in the prototype level.

## Project Status

This is an early learning prototype rather than a finished game. Current visuals are placeholders, and systems may change as Godot patterns are explored.

Possible future experiments include:

* Coyote time
* Jump buffering
* Player animation
* Camera boundaries
* Multiple levels
* Sound effects
* Pause and restart controls
* Automated gameplay tests

## License

No license has been selected for this prototype.

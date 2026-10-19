# Kobold Quest Roadmap

Phases are ordered by dependency: each one builds on systems from the ones before it.
The goal is to reach a small **playable vertical slice** (one region, one town, one
dungeon) as early as possible, then grow the world from there.

## Guiding decisions

These shape almost every later feature, so they come first:

- **One world-state store.** A single autoload (`GameState`) holds every persistent fact
  as flags and counters: `chest_forest_03_opened`, `bridge_destroyed`,
  `quest_lost_egg = 2`. Quests, world events, changing towns, wanted levels and saving
  all read and write this store instead of keeping their own state.
- **Data-driven content.** Items, enemies, weapons, quests, dialogue and recipes are
  Godot `Resource` files, not hard-coded. Adding content should rarely need new code.
- **Chunked world from day one.** The overworld is split into chunks that load and
  unload around the player. Everything placed in the world must survive being
  unloaded and reloaded, so this is designed early, not retrofitted.
- **Save early, save everything.** Save/load exists before there is much to save, so
  each new system is built with it in mind.

---

## Phase 0: Foundations

- [x] Project setup, voxel player with walk wobble, orthographic camera
- [ ] Camera polish: smooth follow, optional slight zoom by area
- [ ] Art pipeline notes: voxel model scale, pivot, naming conventions
- [ ] `GameState` autoload (flags, counters, signals when values change)
- [ ] Save/load of `GameState` and player position (JSON or `ConfigFile`)
- [ ] Interaction system: "press E to interact" on any object (signs, doors, NPCs)
- [ ] Basic HUD layer and pause menu
- [ ] Debug tools: flag viewer, teleport, spawn menu

## Phase 1: Combat core

Make fighting one enemy feel good before building anything around it.

- [ ] Health and damage components (hitbox/hurtbox), reusable by player and enemies
- [ ] Sword attack: swing animation, hit stop, knockback, short invulnerability
- [ ] Player health, death and respawn
- [ ] First enemy with simple AI: wander, notice, chase, attack, flee at low health
- [ ] Loot drops (coins, hearts)
- [ ] HUD hearts

## Phase 2: Open world and streaming

- [ ] Chunk system: overworld split into scenes, streamed in and out around the player
- [ ] Terrain building with `GridMap` and a voxel tile library
- [ ] Per-chunk persistence via `GameState` (opened chests, broken pots, defeated minibosses)
- [ ] Enemy spawn zones with respawn rules
- [ ] Interiors (houses, caves, dungeons) as separate scenes with a quick fade
- [ ] World map and minimap
- [ ] First region built out roughly

## Phase 3: Items, inventory and currency

- [ ] Item resources (type, icon, value, stack size)
- [ ] Inventory and equipment UI
- [ ] Weapon slot system, then a second weapon (bow or spear) to prove it
- [ ] Currency, pickups and chests
- [ ] Consumables (potions, food)

## Phase 4: NPCs, dialogue and quests

- [ ] Dialogue system: branching lines and choices, can read and set `GameState` flags
- [ ] NPCs with idle and wander behaviour
- [ ] Quest system: stages tracked in `GameState`, quest log UI, rewards
- [ ] Shops and trading (buy and sell, prices per merchant)
- [ ] **First small town** with a handful of quest givers

## Phase 5: Dungeons and bosses

- [ ] Dungeon toolkit: locked doors, keys, switches, pressure plates, pushable blocks,
      torches, one-way doors
- [ ] Boss framework: phases, attack patterns, arena locking, health bar
- [ ] Dungeon rewards that unlock new overworld areas (Zelda-style gating)
- [ ] **First small dungeon** with a boss

> **Milestone: vertical slice.** One region, one town, one small dungeon, a few quests
> and a shop. Playtest heavily here before scaling up.

## Phase 6: Permanent world events

Mostly built on `GameState`, so this is cheap if the foundations are solid.

- [ ] Event system: triggers (quest finished, boss killed, choice made) set world flags
- [ ] Chunks and NPCs swap variants based on flags (burned village, rebuilt bridge,
      new merchant, different enemies)
- [ ] Event announcements and journal entries
- [ ] First 2–3 world events in the slice region

## Phase 7: Content expansion

- [ ] More regions and biomes
- [ ] Big towns (districts, more NPCs, guards)
- [ ] Big dungeons (multi-floor, mid-bosses, dungeon item)
- [ ] More enemy types and weapons
- [ ] Main story questline

---

## Nice-to-haves, in suggested order

1. **Branching questlines.** Cheap once quests and dialogue use flags: choices set
   flags, and later stages check them.
2. **Day/night and calendar.** Not requested directly, but towns that change and
   farming both depend on it.
3. **Towns change over time.** World-event variants plus the calendar: buildings go
   up, shops open, NPCs move.
4. **Crafting.** Generic recipe system (inputs → output at a station).
   - **Smithing**: crafting at a forge for weapons and armour.
   - **Alchemy**: crafting at a cauldron for potions; could add ingredient discovery.
5. **Farming.** Persistent plots in `GameState`, crops that grow per in-game day.
6. **Wanted levels.** Crime detection (theft, attacking NPCs), wanted level per town,
   guards that chase or arrest, and assassin's guild ambushes at high levels. Needs
   solid NPC AI from Phases 1–4, so it comes last.

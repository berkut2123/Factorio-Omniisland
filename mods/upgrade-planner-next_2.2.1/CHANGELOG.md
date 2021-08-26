# Changelog

## 2.2.1 (2020-12-05)

### Bugfixes

- Fix entities marked for deconstruction more: [Issue #14](https://github.com/Roang-zero1/upgrade-planner-next/issues/14)

---

## 2.2.0 (2020-12-05)

### Changes

- Fixed for 1.1 release
- Use new spawn_item shortcut

### Bugfixes

- Fix trash_bin icon rename (again)

---

## 2.1.2 (2020-06-01)

- Remove untriggerable event
- Fix button reference

---

## 2.1.1 (2020-02-27)

### Bugfixes

- Fix trash_bin icon rename more: [PR #10](https://github.com/Roang-zero1/upgrade-planner-next/pull/10) by [RoqueDeicide](https://github.com/RoqueDeicide)

---

## 2.1.0 (2020-01-23)

- 0.18 release

---

## 2.0.3 (2019-12-24)

### Bugfixes

- Fix upgrading miniloaders

---

## 2.0.2 (2019-08-11)

### Bugfixes

- Fix upgrading tiles in blueprints

---

## 2.0.1 (2019-08-09)

### Bugfixes

- Fix jumping of rotated entities more: [Issue #6](https://github.com/Roang-zero1/upgrade-planner-next/issues/6)

---

## 2.0.0 (2019-07-20)

### Changes

- Changed import/export to use json instead of lua, this should prevent unauthenticated code execution. THIS IS A BREAKING CHANGE! more: [Issue #5](https://github.com/Roang-zero1/upgrade-planner-next/issues/5)

### Bugfixes

- Fix generation of build smoke on failed upgrade.
- Fix jumping entities (again), I have tested it thoroughly please let me know about any issues.
- Fix module upgrades, they should work correctly again

---

## 1.8.1 (2019-06-18)

- Revert: Fix wandering entities when upgrading between sizes

---

## 1.8.0 (2019-06-16)

### Changes

- Updated player replace logic.
- Clean-up code for clarity.

### Features

- Warn if replacement is blocked on non fast-replaceable entities.
- Convert module upgrade configurations.

### Bugfixes

- Fix replacement eating recipe items.
- Fix incorrect MAX_CONFIG_SIZE on convert.
- Fix crash on export for non fast replaceable entities.
- Fix wandering entities when upgrading between sizes

---

## 1.7.2

### Bugfixes

- Fix incorrect config validation

### Changes

- Add code linting and fix linting errors
- Use CI environment to ensure consistent quality

---

## 1.7.1 (2019-06-11)

### Features

- Export to In-Game upgrade planner no exports half pairs

### Bugfixes

- Fix crash on imbalanced pairs more: [Issue #3](https://github.com/Roang-zero1/upgrade-planner-next/issues/3)

---

## 1.7.0 (2019-06-10)

### Features

- Add an (working) option to switch to default bot upgrading
- Destroy dropped Upgrade-Planner items

### Changes

- Refactoring of the whole codebase
- Removed legacy code unused in this extension
- Switched from name to index as internal indices

### Bugfixes

- Fixed that configurations would remain in multiplayer when deleting old players

---

## 1.6.8 (2019-06-04)

### Bugfixes

- Revert: Add option to switch upgrade default mode

---

## 1.6.7 (2019-06-04)

### Features

- Add option to switch upgrade default mode

### Bugfixes

- Fix item override on Upgrade Planner export

---

## 1.6.6

### Bugfixes

- Fix crash on player trash inventory changing

---

## 1.6.5

### Bugfixes

- Fix export error when exporting to upgrade planner with items from different fast_replaceable_groups

---

## 1.6.4

### Bugfixes

- Fix import window not accepting input

---

## 1.6.3

### Features

- Add Import from/Export to the official Upgrade Planner

### Changes

- Align GUI with in-game Upgrade Planner

---

## 1.6.2

### Features

- Added a toolbar shortcut

### Changes

- Removed old bot functionality and use the new in built Upgrade Planner bot functionality
- Fix that there is no way to remove old Upgrade Planners

---

## 1.6.1

- Add thumbnail image

---

## 1.6.0

- Upgrade for Factorio 0.17

---

## 1.4.11

### Bugfixes

- Fix issue with drop down index

---

## 1.4.10

### Bugfixes

- Fixed small error

---

## 1.4.9

### Bugfixes

- Fixed upgrading assembling machines without a recipe set

---

## 1.4.8

### Bugfixes

- Fixed upgrading beacons with modules

---

## 1.4.7

### Bugfixes

- Fixed raised_event error
- Fixed rail ghosts would expire instantly
- Fixed upgrading modules in blueprints

---

## 1.4.6

### Changes

- Added support for upgrading rails and curved rails
- Configs will be verified on configuration to check for item prototype "Changes"

### Bugfixes

- Fixed error with old invalid configs
- Fixed error when drop down index could become out of range

---

## 1.4.5

### Changes

- Add upgrading tiles in blueprints

### Bugfixes

- Fix configs not switching properly again
- Other clean up and fixes

---

## 1.4.4

### Bugfixes

- Fixed config wouldn't switch properly
- Fixed trying to upgrade tiles in blueprints

---

## 1.4.3

### Bugfixes

- Fixed clearing items wouldn't update the config

---

## 1.4.2

### Bugfixes

- Fixed rules not being cleared properly

---

## 1.4.1

### Bugfixes

- Fix choose elem button triggering for other mod GUIs

---

## 1.4.0

### Changes

- New GUI for rule-sets
- Upgrade modules
- Upgrade modules in blueprints
- Removed deconstructing trees, use filtered deconstruction planners, I felt it was outside the scope of the mod.
- I also cleaned up a lot of the original authors code, or some other maintainers. It is somewhat cleaner now

### Bugfixes

- Fixed some other minor issues.

---

## 1.3.9

- Adds a new item and recipe (unlocked with Upgrade builder technology) "Upgrade Builder" that allows you to replace entities on the map using construction robots. Entities are replaced by hand unless you hold shift when selecting an area to mark it for bots to upgrade.

---

## 1.2.17

- Able to upgrade blueprints
- Added hotkey for toggling GUI visibility and button visibility

---

## 1.2.16

- Hacked in choose elem button

---

## 1.2.15

- 0.15 compatibility
- New GUI

---

## 1.2.14

### Changes

- Removed distance checking as it was annoying

### Bugfixes

- Fixed raised event error.

---

## 1.2.13

### Bugfixes

- Fixed another belt not valid crash

---

## 1.2.12

### Bugfixes

- Fixed belt not valid crash

---

## 1.2.11

### Bugfixes

- Fixed GUI not showing on player joining a game

---

## 1.2.9

- If you upgrade one half of an underground belt it will try to upgrade the other half

---

## 1.2.8

### Bugfixes

- Fixed error about removed mod items

---

## 1.2.7

### Bugfixes

- Fixed on_built_entity error

---

## 1.2.6

- Upgrade planner will now raise events preplayer_mined_item, player_mined_item and on_built_entity

---

## 1.2.5

- Added support for deconstructing trees like this:

---

## 1.2.3

- Uses better method where possible to replace entities.

---

## 1.2.2

### Changes

- Recipe changed to deconstruction planner
- Change from text button to image button

### Bugfixes

- Minor fixes and further clean up by Klonan

---

## 1.2

- I asked Klonan if we could cooperate and incorporate his version of the mod. The result is a much more powerful Upgrade builder. Now you are able to upgrade entities by hand, rather than relying on robots. You can still tell robots to do it by holding the shift key when designating the area.

---

## 1.1.12

### Changes

- Added German Localization courtesy of Luma88 and Russian courtesy of RikkiLook.

### Bugfixes

- Underground belts will now maintain their orientation when upgraded.

Ever wondered how to get those numbers from the electric network info pane into your circuit network?

Behold the **Power Combinator**!

This combinator type outputs power consumption and power production statistics of an electric network in watts as signals to the connected combinator networks. There are 2 tiers of Power Combinbators available. Following unique signals for the connected electric network are provided:

#### Tier 1
* current consumption rate (W)
* current production rate (W)
* maximal possible consumption rate (W)
* maximal possible production rate (W)
* internal prescaling factor ``X`` as user combinator setting for each Power Combinator in the form ``value = input × 1 / 10 ^ X`` for all values sent to the combinator network
* all five values sent to combinator network are custom signals

#### Tier 2
* adjustable filter as user combinator setting limits the electric statistics by selected entity type
* current consumption rate (W)
* current production rate (W)
* maximal possible consumption rate (W)
* maximal possible production rate (W)
* adjustable prescaling factor ``X`` as user combinator setting for each Power Combinator in the form ``value = input × 1 / 10 ^ X`` for all values sent to the combinator network
* all six values sent to combinator network are custom signals

For advanced accumulator capacity monitoring see our related project [Capacity Combinator](https://mods.factorio.com/mod/capacity-combinator).


# Map settings
--------------------------------------------------------------------------------
* update rate: sets the refresh rate for the data submitted to circuit network (as ticks)


# Documentation
--------------------------------------------------------------------------------
* read the [«FAQ»](https://mods.factorio.com/mod/power-combinator/faq) and the [«Changelog»](https://mods.factorio.com/mod/power-combinator/changelog) for more details
* discuss with us on the [«Discussion»](https://mods.factorio.com/mod/power-combinator/discussion) page


# Compatibility
--------------------------------------------------------------------------------
We haven't discover any incompatibilities with other mods to date. Please report on the mod page discussion if any incompatibilities are discovered.
Works with multiplayer.


# License
--------------------------------------------------------------------------------
The mod ‹Power Combinator› was made by dodo.the.last and published under The Unlicense.


# Notes
--------------------------------------------------------------------------------
* the reference pictures are for the version 4.2.1 of the Power Combinator on Factorio 1.1.5
* the Power Combinator terminals are marked cyan for circuit network and yellow for copper wire connections
* the symbols on the reference pictures are: provider max. (PM),  consumer max. (CM),  provider current (P), consumer current (C), scaling factor (X)
* during underprovisioning of the electric network the demand is suddenly reported to be higher than expected. Although this seems to be same behavior as observed in the electric network statistics of factorio, the electric demand of the consumers seems to increase if underprovisioned and resets when P > C or P < PM are true for C demand
* the information on this mod page represents the state of the current release and might be updated without prior notification or public announcement
* please refer to the «Documentation» section of this page for details




# FAQ
--------------------------------------------------------------------------------

# Found a bug, issue or a missing feature?
--------------------------------------------------------------------------------
Please report bugs or issues to our [mod discussion page](https://mods.factorio.com/mod/power-combinator/discussion) in accordance with [factorio bug report rules](https://forums.factorio.com/viewtopic.php?f=7&t=3638) or talk with us about the desired features.

# It doesn't work!
--------------------------------------------------------------------------------
If the output values are over the scale of 2³¹ then the combinator output doesn't update the stats. In this case please set the scaling factor to a reasonable value.

# What is required during the gameplay?
--------------------------------------------------------------------------------
The requirements are for tier 1.

#### Requisite technologies
* circuit network
* electric energy distribution 1
* optics

#### Research
* 50x automation science pack
* 50x logistic science pack
* 30s time

#### Item recipe
* 2x constant combinator
* 1x red wire
* 2x small lamp
* 15s time



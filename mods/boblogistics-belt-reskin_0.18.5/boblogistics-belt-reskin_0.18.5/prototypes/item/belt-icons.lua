-- Copyright (c) 2020 Kirazy
-- Part of Bob's Logistics Belt Reskin
--     
-- See LICENSE.md in the project directory for license information.

-- Patch basic belt icons
if data.raw["transport-belt"]["basic-transport-belt"] then
    beltReskin.patchIcon("basic-transport-belt")
    beltReskin.patchIcon("basic-underground-belt")
    beltReskin.patchIcon("basic-splitter")
end

-- Patch turbo belt icons
if data.raw["transport-belt"]["turbo-transport-belt"] then
    beltReskin.patchIcon("turbo-transport-belt")
    beltReskin.patchIcon("turbo-underground-belt")
    beltReskin.patchIcon("turbo-splitter")
end

-- Patch ultimate belt icons
if data.raw["transport-belt"]["ultimate-transport-belt"] then
    beltReskin.patchIcon("ultimate-transport-belt")
    beltReskin.patchIcon("ultimate-underground-belt")
    beltReskin.patchIcon("ultimate-splitter")
end
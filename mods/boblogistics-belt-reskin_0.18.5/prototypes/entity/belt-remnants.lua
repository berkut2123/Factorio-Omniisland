-- Copyright (c) 2020 Kirazy
-- Part of Bob's Logistics Belt Reskin
--     
-- See LICENSE.md in the project directory for license information.

-- Create basic belt remnants
if data.raw["transport-belt"]["basic-transport-belt"] then
    beltReskin.createRemnants("basic-transport-belt", "transport-belt")
    beltReskin.createRemnants("basic-underground-belt", "underground-belt")
    beltReskin.createRemnants("basic-splitter", "splitter")
end

-- Create turbo belt remnants
if data.raw["transport-belt"]["turbo-transport-belt"] then
    beltReskin.createRemnants("turbo-transport-belt", "transport-belt")
    beltReskin.createRemnants("turbo-underground-belt", "underground-belt")
    beltReskin.createRemnants("turbo-splitter", "splitter")
end

-- Create ultimate belt remnants
if data.raw["transport-belt"]["ultimate-transport-belt"] then
    beltReskin.createRemnants("ultimate-transport-belt", "transport-belt")
    beltReskin.createRemnants("ultimate-underground-belt", "underground-belt")
    beltReskin.createRemnants("ultimate-splitter", "splitter")
end
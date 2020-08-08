-- Copyright (c) 2020 Kirazy
-- Part of Bob's Logistics Belt Reskin
--     
-- See LICENSE.md in the project directory for license information.

-- Create basic belt explosions
if data.raw["transport-belt"]["basic-transport-belt"] then
    beltReskin.createExplosions("basic", "transport-belt")
    beltReskin.createExplosions("basic", "underground-belt")
    beltReskin.createExplosions("basic", "splitter")
end

-- Create turbo belt explosions
if data.raw["transport-belt"]["turbo-transport-belt"] then
    beltReskin.createExplosions("turbo", "underground-belt")
    beltReskin.createExplosions("turbo", "transport-belt")
    beltReskin.createExplosions("turbo", "splitter")
end

-- Create ultimate belt explosions
if data.raw["transport-belt"]["ultimate-transport-belt"] then
    beltReskin.createExplosions("ultimate", "transport-belt")
    beltReskin.createExplosions("ultimate", "underground-belt")
    beltReskin.createExplosions("ultimate", "splitter")
end
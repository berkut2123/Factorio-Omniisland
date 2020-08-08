-- Copyright (c) 2020 Kirazy
-- Part of Bob's Logistics Belt Reskin
--     
-- See LICENSE.md in the project directory for license information.

-- Create belt particles
if data.raw["transport-belt"]["basic-transport-belt"] then
    beltReskin.createParticles("basic")
end

if data.raw["transport-belt"]["turbo-transport-belt"] then
    beltReskin.createParticles("turbo")
end

if data.raw["transport-belt"]["ultimate-transport-belt"] then
    beltReskin.createParticles("ultimate")
end
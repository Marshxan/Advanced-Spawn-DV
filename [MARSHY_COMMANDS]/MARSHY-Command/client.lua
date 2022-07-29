-- Shows a notification on the player's screen 
function ShowNotification( text )
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end

--
-- SPAWN COMMAND
-- 
--
-- SPAWN COMMAND
-- 
--
-- SPAWN COMMAND
-- 
RegisterCommand('car', function(source, args, rawCommand)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
    local veh = args[1]
    if veh == nil then veh = "demonhawk" end
    vehiclehash = GetHashKey(veh)
    RequestModel(vehiclehash)
    exports['mythic_notify']:DoHudText('inform', 'Vehicle Spawned.', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
    
    Citizen.CreateThread(function() 
        local waiting = 0
        while not HasModelLoaded(vehiclehash) do
            waiting = waiting + 100
            Citizen.Wait(100)
            if waiting > 5000 then
                exports['mythic_notify']:DoHudText('inform', 'Could not load the vehicle model in time, a crash was prevented.', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
                break
            end
        end
        CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId())+90, 1, 0)
    end)
end)

--
-- SPAWN COMMAND
-- 
--
-- SPAWN COMMAND
-- 
--
-- SPAWN COMMAND
-- 
function ShowNotification( text )
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end

RegisterCommand('spawn', function(source, args, rawCommand)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
    local veh = args[1]
    if veh == nil then veh = "demonhawk" end
    vehiclehash = GetHashKey(veh)
    RequestModel(vehiclehash)
    exports['mythic_notify']:DoHudText('inform', 'Vehicle Spawned.', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
    
    Citizen.CreateThread(function() 
        local waiting = 0
        while not HasModelLoaded(vehiclehash) do
            waiting = waiting + 100
            Citizen.Wait(100)
            if waiting > 5000 then
                exports['mythic_notify']:DoHudText('inform', 'Could not load the vehicle model in time, a crash was prevented.', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
                break
            end
        end
        CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId())+90, 1, 0)
    end)
end)













--
-- DV COMMAND
-- 
--
-- DV COMMAND
-- 
--
-- DV COMMAND
-- 
RegisterCommand( "dv", function()
    TriggerEvent( "wk:deleteVehicle" )
end, false )
TriggerEvent( "chat:addSuggestion", "/dv", "Deletes the vehicle you're sat in, or standing next to." )

local distanceToCheck = 5.0

local numRetries = 5

RegisterNetEvent( "wk:deleteVehicle" )
AddEventHandler( "wk:deleteVehicle", function()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                exports['mythic_notify']:DoHudText('inform', 'You must be in the drivers seat.', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
            end 
        else
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( ped, pos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                exports['mythic_notify']:DoHudText('inform', 'You must be in or near a vehicle to delete it.', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
            end 
        end 
    end 
end )

function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 

    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )

    if ( DoesEntityExist( veh ) ) then
        exports['mythic_notify']:DoHudText('inform', 'Failed to delete vehicle', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })


        while ( DoesEntityExist( veh ) and timeout < timeoutMax ) do 
            DeleteVehicle( veh )

            if ( not DoesEntityExist( veh ) ) then 
                exports['mythic_notify']:DoHudText('inform', 'The vehicle has been banished from the face of the Earth..', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
            end 

            timeout = timeout + 1 
            Citizen.Wait( 500 )

            if ( DoesEntityExist( veh ) and ( timeout == timeoutMax - 1 ) ) then
                exports['mythic_notify']:DoHudText('inform', 'Failed to delete vehicle.', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
            end 
        end 
    else 
        exports['mythic_notify']:DoHudText('inform', 'The vehicle has been banished from the face of the Earth..', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
    end 
end 

function GetVehicleInDirection( entFrom, coordFrom, coordTo )
	local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
    local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
    
    if ( IsEntityAVehicle( vehicle ) ) then 
        return vehicle
    end 
end

function Notify( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

--
-- DeleteCar COMMAND
-- 
--
-- DeleteCar COMMAND
-- 
--
-- DeleteCar COMMAND
-- 
RegisterCommand( "deletecar", function()
    TriggerEvent( "wk:deleteVehicle" )
end, false )
TriggerEvent( "chat:addSuggestion", "/deletecar", "Deletes the vehicle you're sat in, or standing next to." )

local distanceToCheck = 5.0

local numRetries = 5

RegisterNetEvent( "wk:deleteVehicle" )
AddEventHandler( "wk:deleteVehicle", function()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                exports['mythic_notify']:DoHudText('inform', 'You must be in the drivers seat.', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
            end 
        else
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( ped, pos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                exports['mythic_notify']:DoHudText('inform', 'You must be in or near a vehicle to delete it.', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
            end 
        end 
    end 
end )

function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 

    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )

    if ( DoesEntityExist( veh ) ) then
        exports['mythic_notify']:DoHudText('inform', 'Failed to delete vehicle', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })

        while ( DoesEntityExist( veh ) and timeout < timeoutMax ) do 
            DeleteVehicle( veh )

            if ( not DoesEntityExist( veh ) ) then 
                exports['mythic_notify']:DoHudText('inform', 'The vehicle has been banished from the face of the Earth.', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
            end 

            timeout = timeout + 1 
            Citizen.Wait( 500 )

            if ( DoesEntityExist( veh ) and ( timeout == timeoutMax - 1 ) ) then
                exports['mythic_notify']:DoHudText('inform', 'Failed to delete vehicle.', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
            end 
        end 
    else 
        exports['mythic_notify']:DoHudText('inform', 'Vehicle deleted.', { ['background-color'] = '#0047AB', ['color'] = '#FFFFFF' })
    end 
end 


function GetVehicleInDirection( entFrom, coordFrom, coordTo )
	local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
    local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
    
    if ( IsEntityAVehicle( vehicle ) ) then 
        return vehicle
    end 
end

function Notify( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end








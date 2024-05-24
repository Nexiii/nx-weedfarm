local PedCoords = Config.Blips.Processing.coords
local PedCoords1 = Config.Blips.Seller.coords
local PedModel = Config.PedModel

-- Blip
if Config.UseBlips then
    CreateThread(function()
        for _, v in pairs(Config.Blips) do
            local Blips = AddBlipForCoord(v.coords)
            SetBlipSprite(Blips, v.sprite)
            SetBlipDisplay(Blips, v.display)
            SetBlipColour(Blips, v.colour)
            SetBlipScale(Blips, v.scale)
            SetBlipAsShortRange(Blips, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(v.label)
            EndTextCommandSetBlipName(Blips)
        end
    end)
end

local function LoadESXVersion()
    ESX = exports["es_extended"]:getSharedObject()
    -- Peds
    CreateThread(function()
        RequestModel(PedModel)
        while (not HasModelLoaded(PedModel)) do
            Wait(1)
        end
        CannabisPed1 = CreatePed(1, PedModel, PedCoords, false, true)
        CannabisPed2 = CreatePed(1, PedModel, PedCoords1, false, true)
        SetEntityInvincible(CannabisPed1, true)
        SetBlockingOfNonTemporaryEvents(CannabisPed1, true)
        FreezeEntityPosition(CannabisPed1, true)
        SetEntityInvincible(CannabisPed2, true)
        SetBlockingOfNonTemporaryEvents(CannabisPed2, true)
        FreezeEntityPosition(CannabisPed2, true)
    end)

    CreateThread(function()
        for _, v in pairs(WeedPlants) do
            exports.ox_target:addBoxZone({
                coords = vec3(v.coords.x, v.coords.y, v.coords.z),
                size = v.size,
                rotation = v.heading,
                debug = false,
                options = {
                    {
                        name = v.name,
                        event = 'nx-weedfarm:PickingCannabis',
                        icon = 'fa-solid fa-hand',
                        label = Config.Text["PickCannabis"],
                    }
                }
            })
        end
    end)

    exports.ox_target:addBoxZone({
        coords = Config.OXTarget.processingCoords,
        size = vec3(1, 1, 4),
        rotation = Config.OXTarget.processingHeading,
        debug = false,
        options = {
            {
                name = 'ProcessingCannabis',
                event = 'nx-weedfarm:ProcessCannabis',
                icon = 'fa-solid fa-filter',
                label = Config.Text["ProcessingLabel"],
            },
            {
                name = 'SellingRawCannabis',
                event = 'nx-weedfarm:SellRawCannabis',
                icon = 'fa-solid fa-hand-holding-dollar',
                label = Config.Text["SellCannabisLabel"],
            }
        }
    })

    exports.ox_target:addBoxZone({
        coords = Config.OXTarget.sellingCoords,
        size = vec3(1, 1, 4),
        rotation = Config.OXTarget.sellingHeading,
        debug = false,
        options = {
            {
                name = 'SellBaggys',
                event = 'nx-weedfarm:SellingBaggys',
                icon = 'fa-solid fa-bottle-water',
                label = Config.Text["SellBaggys"],
            }
        }
    })

    --Cannabis Picking Event
    RegisterNetEvent('nx-weedfarm:PickingCannabis', function()
        local Ped = PlayerPedId()
        --local time = math.random(Config.Picking.CirlceMinigame.minSeconds, Config.Picking.CirlceMinigame.maxSeconds)
        --local circles = math.random(Config.Picking.CirlceMinigame.minCircles, Config.Picking.CirlceMinigame.maxCircles)
        local success = true --exports['CircleMinigame']:StartLockPickCircle(circles, time, success)
        if success then
            lib.progressCircle({
                FreezeEntityPosition(Ped, true),
                duration = 2500,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                disable = {
                    car = true,
                },
                anim = {
                    dict = 'anim@amb@business@weed@weed_inspecting_lo_med_hi@',
                    clip = 'weed_stand_checkingleaves_idle_02_inspector'
                },
                prop {},
            })
            TriggerServerEvent('nx-weedfarm:GatherCannabis')
        else
            ESX.ShowNotification(Config.Text["FailedPickingCannabis"], "error")
        end
        FreezeEntityPosition(Ped, false)
    end)

    --Processing Event
    RegisterNetEvent('nx-weedfarm:ProcessCannabis', function()
        local Ped = PlayerPedId()
        FreezeEntityPosition(Ped, true)
        if lib.progressCircle({
            duration = Config.Processing.pressingConfig.timer,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'missfam4',
                clip = 'base'
            },
            prop = {
                model = `p_amb_clipboard_01`,
                pos = vec3(0.00, 0.00, 0.00),
                rot = vec3(0.0, 0.0, -1.5)
            },
        })
        then
            TriggerServerEvent("nx-weedfarm:TradingToWeedBaggys")
        else
            ESX.ShowNotification(Config.Text["CancelledProcessing"], "error")
        end
        FreezeEntityPosition(Ped, false)
    end)

    RegisterNetEvent('nx-weedfarm:SellRawCannabis', function()
        local Ped = PlayerPedId()
        FreezeEntityPosition(Ped, true)
        if lib.progressCircle({
            duration = 4000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'missfam4',
                clip = 'base'
            },
            prop = {
                model = `p_amb_clipboard_01`,
                pos = vec3(0.00, 0.00, 0.00),
                rot = vec3(0.0, 0.0, -1.5)
            },
        })
        then
            TriggerServerEvent("nx-weedfarm:SellingRawCannabis")
        else
            ESX.ShowNotification(Config.Text["CancelledProcessing"], "error")
        end
        FreezeEntityPosition(Ped, false)
    end)

    RegisterNetEvent('nx-weedfarm:SellingBaggys', function()
        local Ped = PlayerPedId()
        FreezeEntityPosition(Ped, true)
        if lib.progressCircle({
            duration = 4000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'missfam4',
                clip = 'base'
            },
            prop = {
                model = `p_amb_clipboard_01`,
                pos = vec3(0.00, 0.00, 0.00),
                rot = vec3(0.0, 0.0, -1.5)
            },
        })
        then
            TriggerServerEvent("nx-weedfarm:SellingBaggys")
        else
            ESX.ShowNotification(Config.Text["CancelledProcessing"], "error")
        end
        FreezeEntityPosition(Ped, false)
    end)
end

local function LoadQBVersion()
    local QBCore = exports['qb-core']:GetCoreObject()
    -- Peds
    CreateThread(function()
        RequestModel(PedModel)
        while (not HasModelLoaded(PedModel)) do
            Wait(1)
        end
        CannabisPed1 = CreatePed(1, PedModel, PedCoords, false, true)
        CannabisPed2 = CreatePed(1, PedModel, PedCoords1, false, true)
        SetEntityInvincible(CannabisPed1, true)
        SetBlockingOfNonTemporaryEvents(CannabisPed1, true)
        FreezeEntityPosition(CannabisPed1, true)
        SetEntityInvincible(CannabisPed2, true)
        SetBlockingOfNonTemporaryEvents(CannabisPed2, true)
        FreezeEntityPosition(CannabisPed2, true)
    end)

    if Config.Target == "OX" then
        CreateThread(function()
            for _, v in pairs(WeedPlants) do
                exports.ox_target:addBoxZone({
                    coords = vec3(v.coords.x, v.coords.y, v.coords.z),
                    size = v.size,
                    rotation = v.heading,
                    debug = false,
                    options = {
                        {
                            name = v.name,
                            event = 'nx-weedfarm:PickingCannabis',
                            icon = 'fa-solid fa-hand',
                            label = Config.Text["PickCannabis"],
                        }
                    }
                })
            end
        end)

        exports.ox_target:addBoxZone({
            coords = Config.OXTarget.processingCoords,
            size = vec3(1, 1, 4),
            rotation = Config.OXTarget.processingHeading,
            debug = false,
            options = {
                {
                    name = 'ProcessingCannabis',
                    event = 'nx-weedfarm:ProcessCannabis',
                    icon = 'fa-solid fa-filter',
                    label = Config.Text["ProcessingLabel"],
                },
                {
                    name = 'SellingRawCannabis',
                    event = 'nx-weedfarm:SellRawCannabis',
                    icon = 'fa-solid fa-hand-holding-dollar',
                    label = Config.Text["SellCannabisLabel"],
                }
            }
        })

        exports.ox_target:addBoxZone({
            coords = Config.OXTarget.sellingCoords,
            size = vec3(1, 1, 4),
            rotation = Config.OXTarget.sellingHeading,
            debug = false,
            options = {
                {
                    name = 'SellBaggys',
                    event = 'nx-weedfarm:SellingBaggys',
                    icon = 'fa-solid fa-bottle-water',
                    label = Config.Text["SellBaggys"],
                }
            }
        })
    elseif Config.Target == "QB" then
        CreateThread(function()
            for _, v in pairs(WeedPlants) do
                exports['qb-target']:AddBoxZone("WeedPlants" .. v.name, vector3(v.coords.x, v.coords.y, v.coords.z), v.size.x, v.size.y, {
                    name = "tree".. v.name,
                    heading = v.heading,
                    debugPoly = false,
                    minZ = v.coords.z - 2,
                    maxZ = v.coords.z + 2,
                  },{
                    options = {
                      {
                        type = "client",
                        name = v.name,
                        event = 'nx-weedfarm:PickingCannabis',
                        icon = 'fa-solid fa-hand',
                        label = Config.Text["PickCannabis"],
                      },
                    },
                  distance = v.distance,
                })
            end
        end)
        exports['qb-target']:AddBoxZone("Processor", vector3(Config.OXTarget.processingCoords.x, Config.OXTarget.processingCoords.y, Config.OXTarget.processingCoords.z), 1, 1, {
            name = "Processed",
            heading = Config.OXTarget.processingHeading,
            debugPoly = false,
            minZ = Config.OXTarget.processingCoords.z - 2,
            maxZ = Config.OXTarget.processingCoords.z + 2,
            },{
            options = {
                {
                type = "client",
                name = 'ProcessingCannabis',
                event = 'nx-weedfarm:ProcessCannabis',
                icon = 'fa-solid fa-filter',
                label = Config.Text["ProcessingLabel"],
                },
                {
                type = "client",
                name = 'SellingRawCannabis',
                event = 'nx-weedfarm:SellRawCannabis',
                icon = 'fa-solid fa-hand-holding-dollar',
                label = Config.Text["SellCannabisLabel"],
                }
            },
            distance = 1.5,
        })
        exports['qb-target']:AddBoxZone("Seller", vector3(Config.OXTarget.sellingCoords.x, Config.OXTarget.sellingCoords.y, Config.OXTarget.sellingCoords.z), 1, 1, {
            name = "Seller",
            heading = Config.OXTarget.sellingHeading,
            debugPoly = false,
            minZ = Config.OXTarget.sellingCoords.z - 2,
            maxZ = Config.OXTarget.sellingCoords.z + 2,
          },{
            options = {
              {
                type = "client",
                name = 'SellBaggys',
                event = 'nx-weedfarm:SellingBaggys',
                icon = 'fa-solid fa-bottle-water',
                label = Config.Text["SellBaggys"],
              },
            },
          distance = 1.5,
        })
    end

    --Cannabis Picking Event
    RegisterNetEvent('nx-weedfarm:PickingCannabis', function()
        local Ped = PlayerPedId()
        --local time = math.random(Config.Picking.CirlceMinigame.minSeconds, Config.Picking.CirlceMinigame.maxSeconds)
        --local circles = math.random(Config.Picking.CirlceMinigame.minCircles, Config.Picking.CirlceMinigame.maxCircles)
        local success = true--exports['CircleMinigame']:StartLockPickCircle(circles, time, success)
        if success then
            lib.progressCircle({
                FreezeEntityPosition(Ped, true),
                duration = 2500,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                disable = {
                    car = true,
                },
                anim = {
                    dict = 'anim@amb@business@weed@weed_inspecting_lo_med_hi@',
                    clip = 'weed_stand_checkingleaves_idle_02_inspector'
                },
                prop = {},
            })
            TriggerServerEvent('nx-weedfarm:GatherCannabis')
        else
            TriggerEvent(Config.Text["FailedPickingCannabis"], "error")
        end
        FreezeEntityPosition(Ped, false)
    end)

    --Processing Event
    RegisterNetEvent('nx-weedfarm:ProcessCannabis', function()
        local Ped = PlayerPedId()
        FreezeEntityPosition(Ped, true)
        if lib.progressCircle({
            duration = Config.Processing.pressingConfig.timer,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'missfam4',
                clip = 'base'
            },
            prop = {
                model = `p_amb_clipboard_01`,
                pos = vec3(0.00, 0.00, 0.00),
                rot = vec3(0.0, 0.0, -1.5)
            },
        })
        then
            TriggerServerEvent("nx-weedfarm:TradingToWeedBaggys")
        else
            TriggerEvent(Config.Text["CancelledProcessing"], "error")
        end
        FreezeEntityPosition(Ped, false)
    end)

    RegisterNetEvent('nx-weedfarm:SellRawCannabis', function()
        local Ped = PlayerPedId()
        FreezeEntityPosition(Ped, true)
        if lib.progressCircle({
            duration = 4000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'missfam4',
                clip = 'base'
            },
            prop = {
                model = `p_amb_clipboard_01`,
                pos = vec3(0.00, 0.00, 0.00),
                rot = vec3(0.0, 0.0, -1.5)
            },
        })
        then
            TriggerServerEvent("nx-weedfarm:SellingRawCannabis")
        else
            TriggerEvent(Config.Text["CancelledProcessing"], "error")
        end
        FreezeEntityPosition(Ped, false)
    end)

    RegisterNetEvent('nx-weedfarm:SellingBaggys', function()
        local Ped = PlayerPedId()
        FreezeEntityPosition(Ped, true)
        if lib.progressCircle({
            duration = 4000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'missfam4',
                clip = 'base'
            },
            prop = {
                model = `p_amb_clipboard_01`,
                pos = vec3(0.00, 0.00, 0.00),
                rot = vec3(0.0, 0.0, -1.5)
            },
        })
        then
            TriggerServerEvent("nx-weedfarm:SellingBaggys")
        else
            TriggerEvent(Config.Text["CancelledProcessing"], "error")
        end
        FreezeEntityPosition(Ped, false)
    end)
end

if Config.Framework == "ESX" then
    LoadESXVersion()
elseif Config.Framework == "QB" then
    LoadQBVersion()
end
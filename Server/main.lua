local function checkDistance()
    local src = source
    local ped = GetPlayerPed(src)
    local check = GetEntityCoords(ped)
    local distanceCheck = Config.MinDistance
        for _,v in pairs(WeedPlants) do
            if #(check - v.coords) < distanceCheck then
                return true
            end
        return false
    end
end

local function LoadQBVersion()
    local QBCore = exports['qb-core']:GetCoreObject()
    RegisterNetEvent('nx-weedfarm:GatherCannabis', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(tonumber(source))
        local orange = math.random(Config.Picking.ReceiveItem.minAmount, Config.Picking.ReceiveItem.maxAmount)
        if checkDistance then
                Player.Functions.AddItem('cannabis', cannabis)
                TriggerClientEvent('QBCore:Notify', src, Config.Text["PickedCannabis"], "success")
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cannabis'], "add")
        else
            return false
        end
    end)

    RegisterServerEvent('nx-weedfarm:TradingToWeedBaggys', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(tonumber(source))
        local orange = Player.Functions.GetItemByName('cannabis')
        local processingAmount = Config.Processing.pressingConfig.amount
        local receivingItem = Config.Processing.pressingConfig.receiving
        if not orange then
            TriggerClientEvent('QBCore:Notify', src, Config.Text['NoItem'], "error")
            return false
        end

        local amount = orange.amount
        if amount >= 1 then
            amount = processingAmount
        else
          return false
        end

        if not Player.Functions.RemoveItem('cannabis', amount) then
            TriggerClientEvent('QBCore:Notify', src, Config.Text['NoItem'], "error")
            return false
        end

        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cannabis'], "remove")
        TriggerClientEvent('QBCore:Notify', src, Config.Text["CannabisProcessed"] .. processingAmount .. Config.Text["CannabisProcessed1"], "success")
        Wait(750)
        Player.Functions.AddItem('weed_baggy', receivingItem)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weed_baggy'], "add")
    end)

    SellOranges = {
        ["orange"] = {
            ["price"] = math.random(Config.SellPrice.Rawcannabis.min, Config.SellPrice.Rawcannabis.max)
        }
    }

    RegisterNetEvent('nx-weedfarm:SellingRawCannabis', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local price = 0
        local orange = Player.Functions.GetItemByName('cannabis')
        if not orange then
            TriggerClientEvent('QBCore:Notify', src, Config.Text["NoItem"], "error")
        elseif orange.amount >= 1 then
            if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then
                for k, v in pairs(Player.PlayerData.items) do
                    if Player.PlayerData.items[k] ~= nil then
                        if SellOranges[Player.PlayerData.items[k].name] ~= nil then
                            price = price + (SellOranges[Player.PlayerData.items[k].name].price * Player.PlayerData.items[k].amount)
                            Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Player.PlayerData.items[k].name], "remove")
                        end
                    end
                end
                Player.Functions.AddItem("dirtymoney", price)
                TriggerClientEvent('QBCore:Notify', src, Config.Text["successfully_sold"], "success")
            end
        end
    end)

    SellBaggys = {
        ["weed_baggy"] = {
            ["price"] = math.random(Config.SellPrice.Baggys.min, Config.SellPrice.Baggys.max)
        }
    }

    RegisterNetEvent('nx-weedfarm:SellingBaggys', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local price = 0
        local orangeBaggys = Player.Functions.GetItemByName('weed_baggy')
        if not orangeBaggys then
            TriggerClientEvent('QBCore:Notify', src, Config.Text["NoItem"], "error")
        elseif orangeBaggys.amount >= 1 then
            if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then
                for k in pairs(Player.PlayerData.items) do
                    if Player.PlayerData.items[k] ~= nil then
                        if SellBaggys[Player.PlayerData.items[k].name] ~= nil then
                            price = price + (SellBaggys[Player.PlayerData.items[k].name].price * Player.PlayerData.items[k].amount)
                            Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Player.PlayerData.items[k].name], "remove")
                        end
                    end
                end
                Player.Functions.AddItem("dirtymoney", price)
                TriggerClientEvent('QBCore:Notify', src, Config.Text["successfully_sold1"], "success")
            end
        end
    end)

end

if Config.Framework == "QB" then
    LoadQBVersion()
end

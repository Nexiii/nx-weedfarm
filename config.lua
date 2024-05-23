Config = {}

Config.Framework = "QB"      -- ESX = ESX Framework  | QB for QBRemastered and QBCore
Config.Target = "QB"         -- OX - OX Target | QB - QB Target (Only works for QB)

Config.UseBlips = true -- True turns blips on | false turns blips off

Config.MinDistance = 2.5 -- Minimal distance from the tree to collect (Exploiter Check)

Config.Blips = {
    Field = {
        label = "Weed Field", -- Blip label
        coords = vector3(2207.93, 5578.03, 53.76), -- Coords  for blips
        sprite = 496, -- Blip Spirte
        colour = 2, -- Blip color
        scale = 0.85, -- Blip Scale
        display = 6, -- Blip Display
    },
    Processing = {
        label = "Weed Processing",
        coords = vector4(2329.75, 2569.48, 46.68-1, 326.6),
        sprite = 365,
        colour = 2,
        scale = 0.85,
        display = 6,
    },
    Seller = {
        label = "Weed Seller",
        coords = vector4(1569.67, -2129.71, 78.33-1, 195.98),
        sprite = 272,
        colour = 2,
        scale = 0.85,
        display = 6,
    }
}

Config.PedModel = "g_m_importexport_01" -- Ped model

Config.Picking = {
    CirlceMinigame = {
        minSeconds = 7, -- Min Seconds for mini game
        maxSeconds = 15, -- Max Seconds for mini game
        minCircles = 2, -- Min CircleMinigame
        maxCircles = 4, -- Max CircleMinigame
    },
    ReceiveItem = {
        minAmount = 2, -- Min Amount you can pick
        maxAmount = 4, -- Max Amount you can pick
    }
}

Config.Processing = {
    pressingConfig = {
        timer = 5000,
        amount = 5, -- Amount needed to process into Weed Baggy
        receiving = 1, -- Amount to receive ( 1 Weed Baggy)
    }
}

Config.SellPrice = {
    Rawcannabis = {
        min = 150,
        max = 325,
    },
    Baggys = {
        min = 1450,
        max = 2150,
    }
}

Config.OXTarget = {
    processingCoords = vector3(2329.75, 2569.48, 46.68 -1),
    processingHeading = 326.6,
    sellingCoords = vector3(1569.67, -2129.71, 78.33 -1),
    sellingHeading = 195.98,
}

Config.Text = { -- Text / langs
    -- Target label
    PickCannabis = "Pick Cannabis",
    SellCannabisLabel = "Sell Cannabis",
    ProcessingLabel = "Process Cannabis",
    SellBaggys = "Sell Weed Baggys",

    -- Other Text
    PickedCannabis = "You have picked Cannabis",
    ProcessingNotification = "Pressing Cannabis",
    CannabisProcessed = "Amount of Cannabis processed ",
    CannabisProcessed1 = " into Baggy",
    successfully_sold = "You have sold raw Cannabis",
    successfully_sold1 = "You have sold Weed Baggys",

    -- Error
    FailedPickingCannabis = "Failed to pick Cannabis",
    CancelledProcessing = "Cancelled",
    ErrorProcessingAmount = "Don't have enough Cannabis",
    NoItem = "You don't have any Cannabis"
}

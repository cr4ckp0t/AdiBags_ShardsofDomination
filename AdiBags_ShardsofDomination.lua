-------------------------------------------------------------------------------
-- AdiBags - Korthian Relics By Crackpot (US, Arthas)
-------------------------------------------------------------------------------

local addonName, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

local tonumber = _G["tonumber"]

local L = addon.L
local tooltip

local function tooltipInit()
    local tip, leftside = CreateFrame("GameTooltip"), {}
    for i = 1, 6 do
        local left, right = tip:CreateFontString(), tip:CreateFontString()
        left:SetFontObject(GameFontNormal)
        right:SetFontObject(GameFontNormal)
        tip:AddFontStrings(left, right)
        leftside[i] = left
    end
    tip.leftside = leftside
    return tip
end

local shardFilter = AdiBags:RegisterFilter("Shards of Domination", 98, "ABEvent-1.0")
shardFilter.uiName = L["Shards of Domination"]
shardFilter.uiDesc = L["New type of gem added in patch 9.1."]

function shardFilter:OnInitialize()
    self.shards = {
        -- Shard Removal Tool
        [187532] = true, -- Soulfire Chisel
        -- Blood Shards of Domination
        [187057] = true, -- Shard of Bek
        [187059] = true, -- Shard of Jas
        [187061] = true, -- Shard of Rev
        [187284] = true, -- Omnious Shard of Bek
        [187285] = true, -- Omnious Shard of Jas
        [187286] = true, -- Ominous Shard of Rev
        [187293] = true, -- Desolate Shard of Bek
        [187294] = true, -- Desolate Shard of Jas
        [187295] = true, -- Desolate Shard of Rev
        [187302] = true, -- Foreboding Shard of Bek
        [187303] = true, -- Foreboding Shard of Jas
        [187304] = true, -- Foreboding Shard of Rev
        [187312] = true, -- Portentous Shard of Bek
        [187313] = true, -- Portentous Shard of Jas
        [187314] = true, -- Portentous Shard of Rev
        -- Frost Shards of Domination
        [187063] = true, -- Shard of Cor
        [187065] = true, -- Shard of Kyr
        [187071] = true, -- Shard of Tel
        [187287] = true, -- Ominous Shard of Cor
        [187288] = true, -- Ominous Shard of Kyr
        [187289] = true, -- Ominous Shard of Tel
        [187296] = true, -- Desolate Shard of Cor
        [187297] = true, -- Desolate Shard of Kyr
        [187298] = true, -- Desolate Shard of Tel
        [187305] = true, -- Foreboding Shard of Cor
        [187306] = true, -- Foreboding Shard of Kyr
        [187307] = true, -- Foreboding Shard of Tel
        [187315] = true, -- Portentous Shard of Cor
        [187316] = true, -- Portentous Shard of Kyr
        [187317] = true, -- Portentous Shard of Tel
        -- Unholy Shards of Domination
        [187073] = true, -- Shard of Dyz
        [187079] = true, -- Shard of Zed
        [187076] = true, -- Shard of Oth
        [187290] = true, -- Ominous Shard of Dyz
        [187291] = true, -- Ominous Shard of Oth
        [187292] = true, -- Ominous Shard of Zed
        [187290] = true, -- Ominous Shard of Dyz
        [187291] = true, -- Ominous Shard of Oth
        [187292] = true, -- Ominous Shard of Zed
        [187299] = true, -- Desolate Shard of Dyz
        [187300] = true, -- Desolate Shard of Oth
        [187301] = true, -- Desolate Shard of Zed
        [187308] = true, -- Foreboding Shard of Dyz
        [187309] = true, -- Foreboding Shard of Oth
        [187310] = true, -- Foreboding Shard of Zed
        [187318] = true, -- Portentous Shard of Dyz
        [187319] = true, -- Portentous Shard of Oth
        [187320] = true -- Portentous Shard of Zed
    }
end

function shardFilter:Updatee()
    self:SendMessage("AdiBags_FiltersChanged")
end

function shardFilter:OnEnable()
    AdiBags:UpdateFilters()
end

function shardFilter:OnDisable()
    AdiBags:UpdateFilters()
end

function shardFilter:Filter(slotData)
    if self.shards[tonumber(slotData.itemId)] then
        return L["Shards of Domination"]
    end

    tooltip = tooltip or tooltipInit()
    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:ClearLines()

    if slotData.bag == BANK_CONTAINER then
        tooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(slotData.slot, nil))
    else
        tooltip:SetBagItem(slotData.bag, slotData.slot)
    end

    tooltip:Hide()
end

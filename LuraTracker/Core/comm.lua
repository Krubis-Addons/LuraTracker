-- Register addon prefix
function LuraTracker:InitCommunication()
    C_ChatInfo.RegisterAddonMessagePrefix("LURA")

    local frame = CreateFrame("Frame")
    frame:RegisterEvent("CHAT_MSG_ADDON")

    frame:SetScript("OnEvent", function(_, _, prefix, message, channel, sender)
        if prefix ~= "LURA" then return end

        -- Prevent reacting to own messages
        --if sender == UnitName("player") then return end

        LuraTracker:ReceiveSequence(message)
    end)
end

-- Recieve data
function LuraTracker:ReceiveSequence(message)
    -- Reset case (empty message)
    if message == "" then
        wipe(self.clickOrder)
        self:UpdateDisplay()
        return
    end

    local newOrder = {}

    for num in string.gmatch(message, "[^,]+") do
        local id = tonumber(num)

        if not self.buttonImages then return end

        table.insert(newOrder, {
            id = id,
            textureFile = self.buttonImages[id]  -- rebuild texture reference
        })
    end

    if #newOrder > 5 then return end

    self.clickOrder = newOrder
    self:UpdateDisplay()
end


-- Send data
function LuraTracker:SendSequence()
    if not IsInGroup() then return end

    local channel = IsInRaid() and "RAID" or "PARTY"
    local ids = {}

    for i, entry in ipairs(self.clickOrder) do
        table.insert(ids, entry.id)  -- extract only ID
    end

    local msg = table.concat(ids, ",")
    C_ChatInfo.SendAddonMessage("LURA", msg, channel)
end

-- Testing
function LuraTracker:SendTestMessage()
    local ids = {}

    for i, entry in ipairs(self.clickOrder) do
        table.insert(ids, entry.id)  -- extract only ID
    end

    local msg = table.concat(ids, ",")

    print("Send message: ")
    print(msg)
    -- Send to yourself via WHISPER
    C_ChatInfo.SendAddonMessage("LURA", msg, "WHISPER", UnitName("player"))
end
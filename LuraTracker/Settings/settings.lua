tinsert(UISpecialFrames, "LuraTrackerSettingsFrame")

function LuraTracker:CreateSettingsFrame()
    local frame = CreateFrame("Frame", "LuraTrackerSettingsFrame", UIParent, "BackdropTemplate")
    frame:SetSize(250, 150)
    frame:SetPoint("CENTER", 0, 0)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background"
    })
    frame:SetBackdropColor(0, 0, 0, 0.8)

    frame:Hide()

    self.settingsFrame = frame

    -- Titel
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -10)
    title:SetText("LuraTracker Settings")

    -- Close Button
    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    closeBtn:SetSize(80, 25)
    closeBtn:SetPoint("BOTTOM", 0, 10)
    closeBtn:SetText("Close")

    closeBtn:SetScript("OnClick", function()
    frame:Hide()
end)
end

function LuraTracker:CreateSettingsControls()
    local frame = self.settingsFrame

    -- Lock Toggle Button
    local btn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    btn:SetSize(160, 30)
    btn:SetPoint("TOP", 0, -50)
    btn:SetText("Unlock")

    self.lockButton = btn

    btn:SetScript("OnClick", function()
        LuraTracker.isLocked = not LuraTracker.isLocked
        LuraTracker:UpdateLockButton()
    end)
end
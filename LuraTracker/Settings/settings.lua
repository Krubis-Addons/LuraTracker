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

    LuraTracker:CreateUnlockButton()
    LuraTracker:CreateResetPositionsButton()
    LuraTracker:CreateSettingsCloseButton()
end

function LuraTracker:CreateUnlockButton()
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

function LuraTracker:CreateResetPositionsButton()
    local frame = self.settingsFrame

    -- Reset Button
    local btn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    btn:SetSize(160, 30)
    btn:SetPoint("TOP", 0, -80)
    btn:SetText("Reset Positions")

    btn:SetScript("OnClick", function()
        -- Default positions
        local defaultMain = {point="LEFT", x=200, y=-150}
        local defaultDisplay = {point="CENTER", x=0, y=300}
        local defaultRadar = {point="LEFT", x=200, y=100}

        -- Reset main frame
        if self.frame then
            self.frame:ClearAllPoints()
            self.frame:SetPoint(defaultMain.point, defaultMain.x, defaultMain.y)
        end

        -- Reset display frame
        if self.displayFrame then
            self.displayFrame:ClearAllPoints()
            self.displayFrame:SetPoint(defaultDisplay.point, defaultDisplay.x, defaultDisplay.y)
        end

        -- Reset radar frame
        if self.radarFrame then
            self.radarFrame:ClearAllPoints()
            self.radarFrame:SetPoint(defaultRadar.point, defaultRadar.x, defaultRadar.y)
        end

        -- Update SavedVariables with default positions
        LuraTrackerDB = LuraTrackerDB or {}
        LuraTrackerDB.mainFrame = defaultMain
        LuraTrackerDB.displayFrame = defaultDisplay
        LuraTrackerDB.radarFrame = defaultRadar

        print("|cFF00FF00LuraTracker:|r All frame positions reset to default!")
    end)
end

function LuraTracker:CreateSettingsCloseButton()
    local frame = self.settingsFrame
    
    -- Close Button
    local btn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    btn:SetSize(80, 25)
    btn:SetPoint("BOTTOM", 0, 10)
    btn:SetText("Close")

    btn:SetScript("OnClick", function()
        frame:Hide()
        frame:ClearAllPoints()
        frame:SetPoint("CENTER", 0, 0)
    end)
end
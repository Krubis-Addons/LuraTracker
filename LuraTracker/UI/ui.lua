function LuraTracker:CreateMainFrame()
    local frame = CreateFrame("Frame", "LuraTrackerFrame", UIParent, "BackdropTemplate")
    frame:SetSize(300, 200)
    frame:SetPoint("LEFT", 200, 0)
    frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background"
    })
    frame:SetBackdropColor(0, 0, 0, 0.8)

    self.frame = frame

    -- Restore saved position
    if LuraTrackerDB and LuraTrackerDB.mainFrame then
    local pos = LuraTrackerDB.mainFrame
    if pos.point and pos.relativePoint and pos.x and pos.y then
        LuraTracker.frame:ClearAllPoints()
        LuraTracker.frame:SetPoint(pos.point, UIParent, pos.relativePoint, pos.x, pos.y)
    end

    -- Close Button (top right)
    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -5, -5)

    closeBtn:SetScript("OnClick", function()
    frame:Hide()

    if LuraTracker.displayFrame then
        LuraTracker.displayFrame:Hide()
    end

    print("|cffff0000LuraTracker hidden.|r Use |cffffff00/lt|r to show it again.")
end)
end

    self:UpdateDisplay()
end

function LuraTracker:CreateDisplayFrame()
    local frame = CreateFrame("Frame", "LuraTrackerDisplayFrame", UIParent, "BackdropTemplate")
    frame:SetSize(250, 50)
    frame:SetPoint("CENTER", 0, 300)
    frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background"
    })
    frame:SetBackdropColor(0, 0, 0, 0.8)

    self.displayFrame = frame

    -- Restore saved position
    if LuraTrackerDB and LuraTrackerDB.displayFrame then
    local pos = LuraTrackerDB.displayFrame
    if pos.point and pos.relativePoint and pos.x and pos.y then
        LuraTracker.displayFrame:ClearAllPoints()
        LuraTracker.displayFrame:SetPoint(pos.point, UIParent, pos.relativePoint, pos.x, pos.y)
    end
end

    frame:Hide()
end

function LuraTracker:CreateSettingsButton()
    local btn = CreateFrame("Button", nil, self.frame, "UIPanelButtonTemplate")
    btn:SetSize(100, 25)
    btn:SetPoint("BOTTOMLEFT", 5, 5)
    btn:SetText("Settings")

    btn:SetScript("OnClick", function()
        if self.settingsFrame:IsShown() then
            self.settingsFrame:Hide()
        else
            self.settingsFrame:Show()
        end
    end)
end
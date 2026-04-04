LuraTracker = {}

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")

f:SetScript("OnEvent", function()
    LuraTrackerDB = LuraTrackerDB or {}

    -- Init ui
    LuraTracker:CreateMainFrame()
    LuraTracker:CreateSettingsFrame()
    LuraTracker:CreateDisplayFrame()
    LuraTracker:CreateRadarFrame()

    -- Init drag position
    LuraTracker:EnableDrag(LuraTracker.frame, "mainFrame")
    LuraTracker:EnableDrag(LuraTracker.displayFrame, "displayFrame")
    LuraTracker:EnableDrag(LuraTracker.radarFrame, "radarFrame")

    -- Init communication
    LuraTracker:InitCommunication()

    -- Apply saved visibility
    if LuraTrackerDB.isVisible == false then
        LuraTracker.frame:Hide()

        if LuraTracker.displayFrame then
            LuraTracker.displayFrame:Hide()
        end

        if LuraTracker.radarFrame then
            LuraTracker.radarFrame:Hide()
        end
    else
        -- Default = visible
        LuraTracker.frame:Show()
        LuraTrackerDB.isVisible = true
    end

     -- Show info message on login
    print("|cff00ff00LuraTracker loaded!|r Use |cffffff00/lt|r to toggle the UI.")
end)

function LuraTracker:ToggleUI()
    if not self.frame then return end

    LuraTrackerDB = LuraTrackerDB or {}

    if self.frame:IsShown() then
        -- Hide
        self.frame:Hide()

        if self.displayFrame then
            self.displayFrame:Hide()
        end

        if self.radarFrame then
            self.radarFrame:Hide()
        end

        -- Save state
        LuraTrackerDB.isVisible = false

        print("|cffff0000LuraTracker hidden.|r Use |cffffff00/lt|r to show it again.")
    else
        -- Show
        self.frame:Show()

        if self.displayFrame and #self.clickOrder > 0 then
            self.displayFrame:Show()
        end

        if self.radarFrame and #self.clickOrder > 0 then
            self.radarFrame:Show()
        end

        -- Save state
        LuraTrackerDB.isVisible = true

        print("|cff00ff00LuraTracker shown.|r Use |cffffff00/lt|r to hide it.")
    end
end

-- Slash command: /lt
SLASH_LURATRACKER1 = "/lt"

SlashCmdList["LURATRACKER"] = function()
    LuraTracker:ToggleUI()
end
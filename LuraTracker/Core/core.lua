LuraTracker = {}

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")

f:SetScript("OnEvent", function()

    -- Init ui
    LuraTracker:CreateMainFrame()
    LuraTracker:CreateSettingsFrame()
    LuraTracker:CreateDisplayFrame()

    LuraTracker:CreateSettingsControls()

    LuraTracker:CreateImageButtons()
    LuraTracker:CreateResetButton()
    LuraTracker:CreateSettingsButton()

    -- Init drag position
    LuraTracker:EnableDrag(LuraTracker.frame, "mainFrame")
    LuraTracker:EnableDrag(LuraTracker.displayFrame, "displayFrame")

    -- Init communication
    LuraTracker:InitCommunication()

     -- Show info message on login
    print("|cff00ff00LuraTracker loaded!|r Use |cffffff00/lt|r to toggle the UI.")
end)

-- Slash command: /lt
SLASH_LURATRACKER1 = "/lt"

SlashCmdList["LURATRACKER"] = function()
    if not LuraTracker.frame then
        print("LuraTracker: Main frame not initialized.")
        return
    end

    if LuraTracker.frame:IsShown() then
        LuraTracker.frame:Hide()

        -- also hide display frame
        if LuraTracker.displayFrame then
            LuraTracker.displayFrame:Hide()
        end

        print("|cffff0000LuraTracker hidden.|r Use |cffffff00/lt|r to show it again.")
    else
        LuraTracker.frame:Show()

        -- only show display if there is data
        if LuraTracker.displayFrame and #LuraTracker.clickOrder > 0 then
            LuraTracker.displayFrame:Show()
        end

        print("|cff00ff00LuraTracker shown.|r Use |cffffff00/lt|r to hide it.")
    end
end
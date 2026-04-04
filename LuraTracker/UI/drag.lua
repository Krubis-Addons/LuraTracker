LuraTracker.isLocked = true

function LuraTracker:UpdateLockButton()
    -- Check DisplayFrame
    if not self.displayFrame then return end
    if not self.lockButton then return end

    if self.isLocked then
        -- Locked
        if self.displayFrame.SetBackdropBorderColor then
            self.displayFrame:SetBackdropBorderColor(0, 0, 0, 0.8)
        end
        self.displayFrame:Hide()
        self.radarFrame:Hide()
        self.lockButton:SetText("Unlock")
    else
        -- Unlock
        if self.displayFrame.SetBackdropBorderColor then
            self.displayFrame:SetBackdropBorderColor(0, 1, 0, 1)
        end

        -- Enable drag
        if self.frame then
            self:EnableDrag(self.frame, "mainFrame")
        end
        self.displayFrame:Show()
        self:EnableDrag(self.displayFrame, "displayFrame")
        self.radarFrame:Show()
        self:EnableDrag(self.radarFrame, "radarFrame")

        self.lockButton:SetText("Lock")
    end
end

function LuraTracker:EnableDrag(frame, key)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    
    frame:SetScript("OnDragStart", function(self)
        if not LuraTracker.isLocked then
            self:StartMoving()
        end
    end)

    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        -- Save Position
        if not LuraTrackerDB then LuraTrackerDB = {} end
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
        LuraTrackerDB[key] = { point = point, relativePoint = relativePoint, x = xOfs, y = yOfs }
    end)
end
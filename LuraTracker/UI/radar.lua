function LuraTracker:CreateRadarFrame()
    local frame = CreateFrame("Frame", "LuraTrackerRadarFrame", UIParent, "BackdropTemplate")
    frame:SetSize(250, 250)
    frame:SetPoint("LEFT", 200, 100)

    frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background"
    })
    frame:SetBackdropColor(0, 0, 0, 0.8)

    self.radarFrame = frame

    -- Boss icon (center)
    local boss = frame:CreateTexture(nil, "ARTWORK")
    boss:SetSize(40, 40)
    boss:SetPoint("CENTER", 0, 0)
    boss:SetTexture("Interface\\AddOns\\LuraTracker\\Images\\icon_skull.tga")

    -- Tank icon (Top)
    local tank = frame:CreateTexture(nil, "ARTWORK")
    tank:SetSize(40, 40)
    tank:SetPoint("CENTER", 0, 60)
    tank:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-ROLES")

    tank:SetTexCoord(
        0.0, 0.25,
        0.25, 0.5
    )

    self.radarBoss = boss

    frame:Hide()
end

function LuraTracker:UpdateRadar()
    if not self.radarFrame then return end
    if not self.clickOrder then return end

    -- Clear old icons
    if self.radarIcons then
        for _, tex in ipairs(self.radarIcons) do
            tex:Hide()
            tex:SetParent(nil)
        end
    end

    self.radarIcons = {}

    local count = #self.clickOrder
    if count == 0 then
        self.radarFrame:Hide()
        return
    end

    self.radarFrame:Show()

    local radius = 80
    local centerX, centerY = 0, 0  -- center offset, below boss

    -- Start angle = right of center (0° = right)
    local startAngle = 0  -- radians
    local angleStep = math.rad(45)  -- 45° per icon

    for i, entry in ipairs(self.clickOrder) do
        -- Add to startAngle to go clockwise
        local angle = startAngle + (i-1) * angleStep

        local x = math.cos(angle) * radius
        local y = -math.sin(angle) * radius  -- negative y to place below

        local tex = self.radarFrame:CreateTexture(nil, "ARTWORK")
        tex:SetSize(30, 30)
        tex:SetPoint("CENTER", centerX + x, centerY + y)
        tex:SetTexture(entry.textureFile)

        table.insert(self.radarIcons, tex)
    end
end
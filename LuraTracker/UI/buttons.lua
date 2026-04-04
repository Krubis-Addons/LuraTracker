function LuraTracker:CreateImageButtons()
    self.clickOrder = {}
    self.imageButtons = {}

    local buttonImages = {
        "Interface\\AddOns\\LuraTracker\\Images\\icon_cross.tga",
        "Interface\\AddOns\\LuraTracker\\Images\\icon_triangle.tga",
        "Interface\\AddOns\\LuraTracker\\Images\\icon_circle.tga",
        "Interface\\AddOns\\LuraTracker\\Images\\icon_star.tga",
        "Interface\\AddOns\\LuraTracker\\Images\\icon_diamond.tga"
    }

    local startX = -100
    for i = 1, 5 do
        local btn = CreateFrame("Button", nil, self.frame)
        btn:SetSize(40, 40)
        btn:SetPoint("TOP", startX + (i-1)*50, -50)

        local tex = btn:CreateTexture(nil, "BACKGROUND")
        tex:SetAllPoints()
        tex:SetTexture(buttonImages[i])

        btn.textureFile = buttonImages[i]  -- save for click tracking

        btn:SetScript("OnClick", function()
            if #self.clickOrder < 5 then
                table.insert(self.clickOrder, {id=i, textureFile=btn.textureFile})
                self:UpdateDisplay()

                -- Send update to group
                self:SendSequence()
                --self:SendTestMessage()
            end

            if #self.clickOrder == 5 then
                -- Start or restart the 15-second auto reset timer
                self:StartAutoResetTimer()
            end
        end)

        table.insert(self.imageButtons, btn)
    end
end

function LuraTracker:CreateResetButton()
    local btn = CreateFrame("Button", nil, self.frame, "UIPanelButtonTemplate")
    btn:SetSize(100, 30)
    btn:SetPoint("CENTER", 0, -20)
    btn:SetText("Reset")

    btn:SetScript("OnClick", function()
        LuraTracker:Reset()
    end)
end
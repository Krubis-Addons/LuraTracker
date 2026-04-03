LuraTracker.clickOrder = {}

function LuraTracker:AddClick(num)
    -- Check number of clicks
    if #self.clickOrder >= 5 then
        return
    end

    table.insert(self.clickOrder, num)
    self:UpdateDisplay()
end

    function LuraTracker:Reset()
        wipe(self.clickOrder)
        self:UpdateDisplay()

        -- Send empty sequence to group
        self:SendSequence()
    end

function LuraTracker:UpdateDisplay()
    if not self.displayFrame then return end

    -- Remove previous textures
    if self.displayTextures then
        for _, tex in ipairs(self.displayTextures) do
            tex:Hide()
            tex:SetParent(nil)
        end
    end
    self.displayTextures = {}

    -- Show textures in order
    local xOffset = -80
    for i, entry in ipairs(self.clickOrder) do
        local tex = self.displayFrame:CreateTexture(nil, "ARTWORK")
        tex:SetSize(40, 40)
        tex:SetPoint("CENTER", xOffset + (i-1)*45 - 10, 0)
        tex:SetTexture(entry.textureFile)
        table.insert(self.displayTextures, tex)
    end

    -- Show DisplayFrame only if there are clicks
    if #self.clickOrder > 0 then
        self.displayFrame:Show()
    else
        self.displayFrame:Hide()
    end
end
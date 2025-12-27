local PANEL = {}
local BaseHUDisActive = false
vgui.Register("RPGXSPBaseHUD", PANEL, "EditablePanel")
function PANEL:Init()
    self:SetSize(ScrW() * 0.4, ScrH() * 0.8)
    self:SetPos(ScrW() * 0.05, ScrH() * 0.1)
    self:SetVisible(false)    

    self.Paint = function(s, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(30, 30, 40, 240))
    end
    
    self.closeButton = vgui.Create("DButton", self)
    self.closeButton:SetSize(32, 32)
    self.closeButton:SetPos(self:GetWide() - 40, 8)
    self.closeButton:SetText("")
    self.closeButton.Paint = function(s, w, h)
        draw.RoundedBoxEx(8, 0, 0, w, h, Color(25, 25, 35, 255), true, true, true, true)
        draw.SimpleText("×", "DermaBold", (w / 2) - 2, (h / 2) - 2, Color(255, 128, 128), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    self.closeButton.DoClick = function()
        self:SetVisible(false)
        BaseHUDisActive = false
        gui.EnableScreenClicker(false)
    end

    self.lineY = 50
    self.PaintOver = function(s, w, h)
        surface.SetDrawColor(Color(255, 255, 255, 50))
        surface.DrawLine(10, self.lineY, w - 10, self.lineY)
    end

    self.title = vgui.Create("DPanel", self)
    self.title:SetPos(10, 10)
    self.title:SetSize(630, self.lineY - 10)
    self.title.Paint = function(s, w, h)
        draw.SimpleText("Spawn Placer Configuration", "DermaLarge", 0, h / 2 - 10, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end
    
    self.scrollPanel = vgui.Create("DPanel", self)
    self.scrollPanel:Dock(FILL)
    self.scrollPanel:DockMargin(10, self.lineY + 10, 10, 10)
    self.scrollPanel.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(35, 35, 45, 255))
    end

    self.npcListLabel = vgui.Create("DLabel", self.scrollPanel)
    self.npcListLabel:Dock(TOP)
    self.npcListLabel:SetTall(20)
    self.npcListLabel:SetText("")
    self.npcListLabel.Paint = function(s, w, h)
        draw.SimpleText("Select NPCs to spawn at the placed spawn points:", "DermaDefaultBold", 0, h / 2 - 8, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    self.npcList = vgui.Create("DListView", self.scrollPanel)
    self.npcList:Dock(TOP)
    self.npcList:SetTall(300)
    self.npcList:AddColumn("NPC Class Name")
    self.npcList:SetMultiSelect(true)
    self.npcList.OnRowSelected = function(s, index, row)
        local selectedNPCs = {}
        for _, line in ipairs(s:GetSelected()) do
            table.insert(selectedNPCs, line:GetValue(1))
        end
        RPGXSP.Settings.SelectedNPCs = selectedNPCs
    end
    -- if not RPGXSPBaseHUD.npcList then
        net.Start("AskForNPCList")
        net.SendToServer()
    -- end

    self.rowThree = vgui.Create("DPanel", self.scrollPanel)
    self.rowThree:Dock(TOP)
    self.rowThree:SetTall(80)
    self.rowThree.Paint = function(s, w, h) end

    self.rowThreeLabels = vgui.Create("DPanel", self.rowThree)
    self.rowThreeLabels:Dock(TOP)
    self.rowThreeLabels.Paint = function(s, w, h) end

    self.rowThreeContents = vgui.Create("DPanel", self.rowThree)
    self.rowThreeContents:Dock(BOTTOM)
    self.rowThreeContents.Paint = function(s, w, h) end


    self.aboveBelowLabel = vgui.Create("DLabel", self.rowThreeLabels)
    self.aboveBelowLabel:Dock(LEFT)
    self.aboveBelowLabel:SetText("")
    self.aboveBelowLabel.Paint = function(s, w, h)        
        draw.SimpleText("Spawn Position (can be toggled with reload):", "DermaDefaultBold", 0, h / 2 - 8, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    self.aboveBelowContainer = vgui.Create("DPanel", self.rowThreeContents)
    self.aboveBelowContainer:Dock(LEFT)
    self.aboveBelowContainer.Paint = function(s, w, h) end

    -- 1. Define the checkboxes for above/below
    self.aboveOption = vgui.Create("DCheckBoxLabel", self.aboveBelowContainer)
    self.aboveOption:Dock(TOP)
    self.aboveOption:SetText("Spawn Above (on ground)")
    self.belowOption = vgui.Create("DCheckBoxLabel", self.aboveBelowContainer)
    self.belowOption:Dock(TOP)
    self.belowOption:SetText("Spawn Below (under ceiling)")
    -- 2. Set up the OnChange functions
    self.belowOption.OnChange = function(s, val)
        if val then
            RPGXSP.Settings.aboveOrBelow = BELOW
            self.aboveOption:SetValue(0)
            self.aboveOption:SetDisabled(false)
            self.belowOption:SetDisabled(true)
        end
    end
    self.aboveOption.OnChange = function(s, val)
        if val then
            RPGXSP.Settings.aboveOrBelow = ABOVE
            self.belowOption:SetValue(0)
            self.aboveOption:SetDisabled(true)
            self.belowOption:SetDisabled(false)
        end
    end
    -- 3. Initialize the checkboxes based on current settings
    self.aboveOption:SetValue(RPGXSP.Settings.aboveOrBelow == ABOVE and 1 or 0)
    self.belowOption:SetValue(RPGXSP.Settings.aboveOrBelow == BELOW and 1 or 0)


    self.levelRangeLabel = vgui.Create("DLabel", self.rowThreeLabels)
    self.levelRangeLabel:Dock(RIGHT)
    self.levelRangeLabel:SetText("")
    self.levelRangeLabel.Paint = function(s, w, h)
        draw.SimpleText("Monster Level Range:", "DermaDefaultBold", 0, h / 2 - 8, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    self.levelRangeArea = vgui.Create("DPanel", self.rowThreeContents)
    self.levelRangeArea:Dock(RIGHT)    
    self.levelRangeArea.Paint = function(s, w, h) end

    self.levelMinArea = vgui.Create("DPanel", self.levelRangeArea)
    self.levelMinArea:Dock(LEFT)
    self.levelMinArea.Paint = function(s, w, h) end

    self.levelMinLabel = vgui.Create("DLabel", self.levelMinArea)
    self.levelMinLabel:Dock(TOP)
    self.levelMinLabel:SetText("")
    self.levelMinLabel.Paint = function(s, w, h)
        draw.SimpleText("Minimum Level:", "DermaDefault", 0, h / 2 - 8, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    self.levelMinInput = vgui.Create("DTextEntry", self.levelMinArea)
    self.levelMinInput:Dock(BOTTOM)
    self.levelMinInput:SetText("1")
    self.levelMinInput.OnTextChanged = function(s)
        local text = s:GetValue()
        local filtered = text:gsub("[^%d]", "")
        if tonumber(filtered) > tonumber(self.levelMaxInput:GetValue()) then
            filtered = self.levelMaxInput:GetValue()
        end
        if text ~= filtered then
            self.levelMinInput:SetText(filtered)
        end
        RPGXSP.Settings.levelMin = tonumber(filtered)
    end

    self.levelMaxArea = vgui.Create("DPanel", self.levelRangeArea)
    self.levelMaxArea:Dock(RIGHT)
    self.levelMaxArea.Paint = function(s, w, h) end

    self.levelMaxLabel = vgui.Create("DLabel", self.levelMaxArea)
    self.levelMaxLabel:Dock(TOP)
    self.levelMaxLabel:SetText("")
    self.levelMaxLabel.Paint = function(s, w, h)
        draw.SimpleText("Maximum Level:", "DermaDefault", 0, h / 2 - 8, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    self.levelMaxInput = vgui.Create("DTextEntry", self.levelMaxArea)
    self.levelMaxInput:Dock(BOTTOM)
    self.levelMaxInput:SetText("5")
    self.levelMaxInput.OnTextChanged = function(s)
        local text = s:GetValue()
        local filtered = text:gsub("[^%d]", "")
        if tonumber(filtered) < tonumber(self.levelMinInput:GetValue()) then
            filtered = self.levelMinInput:GetValue()
        end
        if text ~= filtered then
            self.levelMaxInput:SetText(filtered)
        end
        RPGXSP.Settings.levelMax = tonumber(filtered)
    end


    self.respawnIntervalLabel = vgui.Create("DLabel", self.scrollPanel)
    self.respawnIntervalLabel:Dock(TOP)
    self.respawnIntervalLabel:SetTall(40)
    self.respawnIntervalLabel:SetText("")
    self.respawnIntervalLabel.Paint = function(s, w, h)
        draw.SimpleText("Respawn Interval (seconds):", "DermaDefaultBold", 0, h / 2 - 8, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    self.respawnIntervalInput = vgui.Create("DTextEntry", self.scrollPanel)
    self.respawnIntervalInput:Dock(TOP)
    self.respawnIntervalInput:SetTall(30)
    self.respawnIntervalInput:SetText("10")
    self.respawnIntervalInput.OnTextChanged = function(s)
        local text = s:GetValue()
        local filtered = text:gsub("[^%d]", "")
        if text ~= filtered then
            self.respawnIntervalInput:SetText(filtered)
        end
        RPGXSP.Settings.spawnInterval = tonumber(filtered)
    end

    self.saveButton = vgui.Create("DButton", self.scrollPanel)
    self.saveButton:SetText("Save spawn points to file")
    self.saveButton:Dock(BOTTOM)
    self.saveButton:SetTall(40)
    self.saveButton.DoClick = function()
        hook.Run("RPGXSP_SaveSpawnPoints")
    end
end

function PANEL:PerformLayout(width, height)
    self.rowThreeLabels:SetTall(self.rowThree:GetTall() * 0.45)

    self.aboveBelowLabel:SetWide(self.rowThreeLabels:GetWide() * 0.4)

    self.levelRangeLabel:SetWide(self.rowThreeLabels:GetWide() * 0.6)
    

    self.rowThreeContents:SetTall(self.rowThree:GetTall() * 0.55)

    self.aboveBelowContainer:SetWide(self.rowThree:GetWide() * 0.4)
    
    self.levelRangeArea:SetWide(self.rowThreeContents:GetWide() * 0.6)

    self.levelMinArea:SetWide(self.levelRangeArea:GetWide() * 0.48)
    self.levelMinLabel:SetTall(self.levelRangeArea:GetTall() * 0.25)
    self.levelMinInput:SetTall(self.levelRangeArea:GetTall() * 0.75)

    self.levelMaxArea:SetWide(self.levelRangeArea:GetWide() * 0.48)
    self.levelMaxLabel:SetTall(self.levelRangeArea:GetTall() * 0.25)
    self.levelMaxInput:SetTall(self.levelRangeArea:GetTall() * 0.75)
end

net.Receive("AnswerNPCList", function()
    local npcList = net.ReadTable()
    for _, npcClass in ipairs(npcList) do
        RPGXSPBaseHUD.npcList:AddLine(npcClass)
    end
end)

function RPGXSP:ToggleHelpMenu()
    if not IsValid(RPGXSPBaseHUD) then
        RPGXSPBaseHUD = vgui.Create("RPGXSPBaseHUD")
    end

    -- Toggle visibility
    if RPGXSPBaseHUD:IsVisible() then
        RPGXSPBaseHUD:SetVisible(false)
        gui.EnableScreenClicker(false)
    else
        RPGXSPBaseHUD:SetVisible(true)
        RPGXSPBaseHUD:MakePopup()
        gui.EnableScreenClicker(true)
    end
end
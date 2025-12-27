RPGXSP = RPGXSP or {}
if SERVER then
    AddCSLuaFile("cl/save.lua")
    AddCSLuaFile("vgui/fonts.lua")
    AddCSLuaFile("vgui/3D2D/entity_info.lua")
    AddCSLuaFile("cl/lookat_controller.lua")
    AddCSLuaFile("cl/settings.lua")
    
    include("sv/message_handler.lua")

    util.AddNetworkString("OpenPlacerConfiguration")
    util.AddNetworkString("AskForNPCList")
    util.AddNetworkString("AnswerNPCList")
elseif CLIENT then
    include("cl/save.lua")
    include("vgui/fonts.lua")
    include("vgui/3D2D/entity_info.lua")
    include("cl/lookat_controller.lua")
    include("cl/settings.lua")

    net.Receive("OpenPlacerConfiguration", function()
        local msg = net.ReadString()
        chat.AddText(Color(0, 255, 0), "[RPGXSP] ", Color(255, 255, 255), msg)
    end)
end
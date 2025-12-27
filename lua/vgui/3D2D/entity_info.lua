RPGXSP.loookAtEntity = {}
hook.Add( "PostDrawOpaqueRenderables", "BlockLuaRun", function( bDrawingDepth, bDrawingSkybox, isDraw3DSkybox )
    for _, ent in pairs(ents.FindByClass("point_marker")) do
        local eyePos = LocalPlayer():EyePos()
        local vertOffset = 25
        local basePos = ent:GetPos() + Vector(0, 0, vertOffset)

        local dir = (eyePos - basePos):GetNormalized()
        local offset = 6 -- units toward the player

        local pos = basePos + dir * offset
        local ang = Angle(0, LocalPlayer():EyeAngles().y - 90, 90)

        cam.Start3D2D(pos, ang, 0.05)
            draw.NoTexture()
            surface.SetDrawColor(0, 200, 255, 200)

            local radius = 40
            local segments = 32
            local poly = {}

            table.insert(poly, { x = 0, y = 0 })

            for i = 0, segments do
                local a = math.rad((i / segments) * 360)
                table.insert(poly, {
                    x = math.cos(a) * radius,
                    y = math.sin(a) * radius
                })
            end

            surface.DrawPoly(poly)

            if(ent == RPGXSP.loookAtEntity) then
                local text = "Spawn Point #" .. ent:GetIndex()
                local w, h = surface.GetTextSize(text)
                draw.SimpleText(text, "PointMarkerFont", -w * 0.5, -radius - 20, Color(255, 255, 255), TEXT_ALIGN_LEFT)
            end
            cam.End3D2D()
    end
end)
net.Receive("AskForNPCList", function(len, ply)
    -- Here you would gather the NPC list and send it back to the client
    local npcList = {}
    for k,v in pairs(list.Get("NPC")) do 
        table.insert(npcList, k)
    end
    net.Start("AnswerNPCList")
    net.WriteTable(npcList)
    net.Send(ply)
end)
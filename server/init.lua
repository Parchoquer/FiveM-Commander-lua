local oldMsgID = nil

Citizen.CreateThread(function()
    DiscordAPI.SendMessageDebug('Bot initialiser')
    while (true) do
        Citizen.Wait(Config.tick)
        local channel = DiscordAPI.Get("channels/" .. Config.channelID)
        if channel then
            local data = json.decode(channel)
            local lastMsg = data.last_message_id
            local message = DiscordAPI.Get("channels/" .. Config.channelID .. "/messages/" .. lastMsg)
            if message then
                local data2 = json.decode(message)
                if oldMsgID ~= data2.id and not data2.author.bot then
                    Bot.CommandExec(data2.content)
                    oldMsgID = data2.id
                end
            end
        end
    end
end)

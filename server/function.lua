DiscordAPI = {}
Commands = {}
Bot = {}

Bot.Slice = function(string)
    local c, t = nil, {}
    for val in string:gmatch("([^ ]+)") do
        table.insert(t, val)
    end
    c = t[1]
    table.remove(t, 1)
    return t, c
end

Bot.Command = function(cmd, args)
    local find = false
    for i = 1, #Config.commands do
        if Config.commands[i] == cmd then
            find = true
            Commands[cmd](args)
            break
        end
    end
    if (not find) then
        DiscordAPI.SendMessage("**`Commande introuvable`**")
    end
end

Bot.CommandExec = function(message)
    if message:find(Config.prefix) ~= 1 then return end
    local args = message:sub(2):gsub("^%s*(.-)%s*$", "%1")
    local param, command = Bot.Slice(args, " ")
    Bot.Command(command, param)
end

DiscordAPI.Get = function(endpoint)
    local data = nil
    PerformHttpRequest('https://discordapp.com/api/' .. endpoint, function(err, json)
        data = json
    end, 'GET', nil, {
        ['Content-Type'] = 'application/json',
        ['Authorization'] = 'Bot ' .. Config.token
    })
    while data == nil do Citizen.Wait(0) end
    return data
end

DiscordAPI.SendEmbed = function(data)
    local date = os.date("%d/%m/%Y %H:%M:%S")
    local embed = {
        {
            color = data.color,
            title = data.title,
            description = data.description,
            author = {
                name = data.authorName,
                icon_url = data.authorIcon_url,
            },
            fields = data.fields,
            footer = {
                icon_url = Config.avatarURL,
                text = "NeedForDrifting | " .. date,
            }
        }
    }
    PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({
        username = Config.webhookName,
        embeds = embed,
        avatar_url = Config.avatarURL
    }), {['Content-Type'] = 'application/json'})
end

DiscordAPI.SendMessage = function(message)
    PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({
        username = Config.webhookName,
        content = message,
        avatar_url = Config.avatarURL
    }), {['Content-Type'] = 'application/json'})
end

DiscordAPI.SendMessageDebug = function(message)
    local date = os.date("%d/%m/%Y %H:%M:%S")
    PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({
        username = Config.webhookName,
        avatar_url = Config.avatarURL,
        content = "```" .. message .. "\n" .. date .."```"
    }), {['Content-Type'] = 'application/json'})
end
Config = {}
Config.prefix = "=" -- prefix to interact with the bot
Config.token = "YOUR_TOKEN" -- Key you can get on https://discord.com/developers/applications (required to read sent message)
Config.webhook = "https://discord.com/api/webhooks/YOUR_TOKEN" -- Webhook of the room with which you want to interact with the bot (required to send message)
Config.channelID = "123456789123456789" -- ID of the room with which you want to interact with the bot
Config.webhookName = "YOUR_BOT_NAME" -- Bot name
Config.avatarURL = "YOUR_IMG_LINK" -- link logo png
Config.tick = 4000 -- In ms / Bot response time in ms (Shorter response time lead bot crash or API blocking)

-- Register Commands
Config.commands = {
    'ping',
}
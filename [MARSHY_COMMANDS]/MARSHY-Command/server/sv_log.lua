--Configuration--
local discordwebhook = 'https://discord.com/api/webhooks/1002518715411202079/X9ak1YX04you3l-NDtVrb7i-Pu4Pao3fUEqdeBQ2P_qXo1EYqs8Q2j5PUmgqTuTQaa3V'
--End Of Configuration--

local playertimes = {}

RegisterServerEvent('log:server:playtime')
AddEventHandler('log:server:playtime', function(playtime)
  local _source = source
  playertimes[_source] = playtime
end)

--Player Connecting
AddEventHandler('playerConnecting', function()
  local _source = source
  local name = GetPlayerName(_source)
  local mb = Masipallopaa(_source)
    sendToDiscordLogsEmbed(3158326, '`✅` | ',' 🧷 - Player: `' .. name .. '`\n 🧷 - Hex-ID: `' ..mb.identifier.. '`\n 🧷 - License: `' ..mb.license.. '`\n 🧷 - License2: `' ..mb.license2.. '` \n 🧷 - Discord Tag: <@' ..mb.discord:gsub('discord:', '').. '>\n 🧷 - Discord ID: `' ..mb.discord.. '`\n 🧷 - XBL ID: `' ..mb.xbl.. '`\n 🧷 - Live ID: `' ..mb.live.. '`\n 🧷 - FiveM ID: `' ..mb.fivem.. '`\n 🧷 - IP: ||' ..GetPlayerEndpoint(_source).. '|| \n\n\n **MADE BY MARSHY 2022 \n AUG UPDATE**')
end)

--Player Leaving
AddEventHandler('playerDropped', function(reason)
  local _source = source
  local name = GetPlayerName(_source)
  local playtime = playertimes[_source] or 0
  local mb = Masipallopaa(_source)
    sendToDiscordLogsEmbed(3158326, '`❌` | ',' 🧷 - Player: `' .. name .. '`\n 🧷 - Hex-ID: `' ..mb.identifier.. '`\n 🧷 - License: `' ..mb.license.. '`\n 🧷 - License2: `' ..mb.license2.. '` \n 🧷 - Discord Tag: <@' ..mb.discord:gsub('discord:', '').. '>\n 🧷 - Discord ID: `' ..mb.discord.. '`\n 🧷 - XBL ID: `' ..mb.xbl.. '`\n 🧷 - Live ID: `' ..mb.live.. '`\n 🧷 - FiveM ID: `' ..mb.fivem.. '`\n 🧷 - IP: ||' ..GetPlayerEndpoint(_source).. '|| \n\n\n **MADE BY MARSHY 2022 \n AUG UPDATE **')
  end)


function sendToDiscordLogsEmbed(color, name, message, footer)
  local footer = ' - '..os.date("%d/%m/%Y - %X")
  local embed = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"] = footer,
            },
        }
    }

  PerformHttpRequest(discordwebhook, function(err, text, headers) end, 'POST', json.encode({username = 'Logs By Marshy', embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function Masipallopaa(_source)
  local idtablemb = {
    license = "🧷 - No License found - 🧷", 
    license2 = "🧷 - No license2 found - 🧷",
    identifier = "🧷 - No Hex-ID found - 🧷",
    discord = "🧷 - No Discord found - 🧷",
    xbl = "🧷 - No xbl ID found - 🧷",
    live = "🧷 - No Live ID found - 🧷",
    fivem = "🧷 - No FiveM ID found - 🧷"
  }

    for k,v in ipairs(GetPlayerIdentifiers(_source))do
    if string.sub(v, 1, string.len("license:")) == "license:" then
      idtablemb.license = v
    elseif string.sub(v, 1, string.len("license2:")) == "license2:" then
      idtablemb.license2 = v
    elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
      idtablemb.identifier = v
    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
      idtablemb.discord = v
    elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
      idtablemb.xbl = v
    elseif string.sub(v, 1, string.len("live:")) == "live:" then
      idtablemb.live = v
    elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
      idtablemb.fivem = v
    end
  end
  return idtablemb
end

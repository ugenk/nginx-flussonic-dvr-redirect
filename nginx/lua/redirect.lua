-- 2015-2024 mediatech.by

-- настройки
maxlen = 14400                -- максимальная длительность передачи
flussonic_port = "501"        -- порт flussonic, куда мы редиректим
flussonic_host = ngx.var.host -- имя хоста flussonic, куда мы редиректим. по умолчанию то же, что в запросе

-- тело скрипта
ngx.header["Content-Type"] = "text/plain"

if ngx.var.args then
    -- чиним кривые урлы от ottplayer
    ngx.var.args = string.gsub(ngx.var.args, "?utc=", "&utc=")
    ngx.var.args = string.gsub(ngx.var.args, "amp;", "")

    token = ngx.var.arg_token
    utc = ngx.var.arg_utc
    lutc = ngx.var.arg_lutc
end

if token and utc and lutc then
    -- защита от очень длинных передач
    if lutc - utc < maxlen then
        dvr_length = "now"
    else
        dvr_length = maxlen
    end
    ngx.var.args = nil
    -- данный скрипт работает для url вида /channel_name/(index|video).(m3u8|mpd)
    -- если у вас другой формат урла - то поправьте регулярное выражение ниже
    channel, video_type, extension = string.match(ngx.var.uri, "/([^/]+)/([^/]+)%.([^/]+)$")
    -- собираем новый url для flussonic
    url = "/" ..
    channel .. "/" .. video_type .. "-" .. utc .. "-" .. dvr_length .. "." .. extension .. "?token=" .. token
else
    url = ngx.var.uri
    if ngx.var.args then
        url = url .. "?" .. ngx.var.args
    end
end

ngx.redirect(ngx.var.scheme .. "://" .. flussonic_host .. ":" .. flussonic_port .. url)

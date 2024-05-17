# nginx lua dvr redirector for flussonic

Ряд пользовательских приложений, например SIP TV умеют работать с архивом запрашивая начало и конец передачи get-параметрами utc и lutc

Flussonic подразумевает другую http-схему получения dvr: https://flussonic.ru/doc/dvr-playback/

Данный lua-скрипт осуществляет реврайт url-ов и дальнейший redirect на flussonic.

В репозитории содержится сам скрипт `nginx/lua/redirect.lua` и пример server'а для nginx `nginx/sites-available/rewrite.conf`

Пример запрашиваемого url и ответа (nginx слушает на 80 порту, flussonic на 501), для передачи которая идет сейчас

```
http://flussonic.example.com/MyChannelName/video.m3u8?token=pll1jhg9g1l3j08iufhv60wtxhw&utc=1715958013&lutc=1715963565

http://flussonic.example.com:501/MyChannelName/video-1715958013-now.m3u8?token=pll1jhg9g1l3j08iufhv60wtxhw
```

## Разработчик

- https://www.mediatech.dev/
- https://www.mediatech.by/

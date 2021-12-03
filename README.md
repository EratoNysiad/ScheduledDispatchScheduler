# ScheduledDispatchScheduler
Companion for [OpenTTD JGRpp's](https://github.com/JGRennison/OpenTTD-patches/releases) Scheduled Dispatch feature, which allows for effective timetabling in OpenTTD.

![](https://i.imgur.com/0JU979c.png)

This program allows you to make timetable graphs, much like the ones used in real life.

For comments and discussion, feel free to head over to the [forum topic](https://www.tt-forums.net/viewtopic.php?t=89538).

Please note that by default, the travel times indicated in the OpenTTD time tables are in ticks, and then rounded to the nearest minute. So when it says "travelling for 2 minutes" this can mean that the train actually travels for 1 minute and 30 seconds. Because of this I advise you to reset the times manually after using automate, autofill or any other form of automatic timetable filling and double clicking and then pressing enter. You can choose the setting "Show leftover ticks in timetable" to see if the game uses a rounded value or not. When and if a feature becomes available to have it automatically round the actual planned time to the nearest whole minute.

## Credit:
Sprites and font are obtained from [OpenGFX](https://github.com/OpenTTD/OpenGFX), and the colours for the UI are from [OpenTTD](https://github.com/OpenTTD/OpenTTD).
The program is made using [LÖVE or Love2D](https://love2d.org/), who are also on [Github](https://github.com/love2d/love).

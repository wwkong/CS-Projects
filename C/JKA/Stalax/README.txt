Stalax v1.0
-----------

Here's the readme about Stalax, it tells the more important things about the installation
and the modification's usage.

1 - Features
------------

The mod's main feature is Lua Scripting, you can do everything you want on your own server.
And if you are a mapper, you can improve your maps' interactivity and make new features that
you have never seen.

There's a new bot system called AceBot, it has been ported into this mod and it's not stable
at the moment. It has some good possibilities, the bot can make his waypoints itself by 
finding some possible holes in the map, and when he finds an enemy, he goes forward to it,
not like the original Jedi Academy bots.

2 - To Do
---------

A perfect physics engine could come soon, but not quickly. I will do my possible to make sure
that he would be perfect, since the Quake III Engine needs a better collision detection and
we could make more and more crazy stuff like vehicles, ropes,... maybe endless possibilities.

3 - Running the Demo
--------------------

To run the demo, simply launch "Stalax Demo.bat", it will load Jedi Academy under Stalax with
the sta_tour map.

In this map you will see some scripts I made and commented for you :

  .. Password Terminal with the console - move near the terminal, make sure that you put your
     crosshair on it, open your console and type "/input" with your password.
     The good password is "goodpwd", I think you'll need it in order to go to the next level.

  .. Chat Password Terminal - more comfortable way, it's the same Password Terminal, but you
     just have to use it with your USE button, look at it, and say the password in the chat.
     Like if you want to say it to everyone but the message will be canceled so the players
     won't see it.

  .. Teleporter Terminal - a nice teleporter terminal with more choices, use it with your use
     button, look at it and type the number of your choice in the chat.

  .. NPC Conversation - now you can talk to NPCs and make them react with the things you tell
     them. Use Luke with your use button, and tell him to open the door by typing the number
     of the choice you want to make.

  .. Item Grabbing - Ha! Something like Portal, not perfect, but as always, the physics engine
     is still missing :-(. Grab the crate with the USE button, move near the blue button located
     right the door and drop it with the USE button again. If you remove it, the door will be
     closed.

The mapsource of sta_tour is included into the maps folder.

That's it for the demo, I will add more and more examples in newer versions.
I hope you like them.

4 - Installing a script
-----------------------

I think the method to install a script is really the easiest.
Guess how ? Simply put the .lua script into the Stalax/lua/global folder.
The server will load it automatically.

If it's a script only for a map and if you want the server loads it only if the specific map is
loading, then create a folder into "lua", having the map's name. For example, if you want to
make a script only for t2_trip, create a folder named "t2_trip" into "lua" (Should look like
lua/t2_trip) and place your map's scripts into that folder.

If it's for a mp map like mp/ffa3, just do "lua/mp/ffa3" (ffa3 into the mp folder).

5 - Documentation
-----------------

I'm sorry if the documentation is not really complete, there's a lot about the Entity and Client
commands, and I don't really have the time to finish it properly.

But I'm always ready to help you and give you more infos about commands right into the forums.

You can find the documentation there :
www.stalax.net/doku.php?id=docs

And the whole Stalax community there :
www.stalax.net/forums/

You will find a lot of scripts, tutorials and solved problems into the forums.
I hope you'll enjoy it.

Eltran

THIS MODIFICATION IS NOT MADE, DISTRIBUTED, OR SUPPORTED BY ACTIVISION,
RAVEN, OR LUCASARTS ENTERTAINMENT COMPANY LLC. ELEMENTS TM & © LUCASARTS
ENTERTAINMENT COMPANY LLC AND/OR ITS LICENSORS.
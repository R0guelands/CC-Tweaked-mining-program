# CC-Tweaked-mining-program
This is a CC Tweaked mining turtle program to excavate the classic mining tunnels and deposit resources back at the base.

# How to use it

Before we begin, start by following this guide on how to build a [gps system](https://tweaked.cc/guide/gps_setup.html)
Then, position your turtle and place a chest in front of it (it will deposit the mined stuff in here), and another one in it's left side (for torches)

Ok, now for the softaware:
First, exec the program by typing it's name on the mining turtle's terminal.
Then, insert the Y layer on witch the mining will happen (-45 is the best one)
Second, insert the side tunnels size (I like to go with 40 in this one, as it creates this nice long structures)
Third, insert how much in the X exis the turtle will mine (for every N you put, two side tunnels are created; ex: 3 -> 6 side tunnels)
At last, insert the tunnel hight (this will make the tunnel N in hight)
Enjoy!

# How to install 

First, open your minecraft world or server with CC tweked intalled and running.
Now, put a computer down and right next to it a disk with a disk inside.
In the computer, type `cd disks` and the enter key.
The folder path should be ending in "/disks/".
Now, type `edit test` and the enter key.
Without typing anything in this window, click the ctrl key, the enter key to save, and then `right arrow` until you get to "exit". Enter key again.
Now alt tab minecraft, and go to `.minecraft/world/computercraft/disk/1` (with you are on a server, it will be `yourserverfolder\world\computercraft\disk`).
Now clone this repository and replace de "test" file in there for the folder in this repository (exclude de readme)
Back in minecraft, place your turtle with its back turned to the computer, than type `cd disks` and the enter key.
Now it's you should only type the name of the file and every thing should work! (with you are not sure, type `ls` and the file will appear in the console).

# How it works

It's a simple Luna code, actually.
We start by getting the settings from the user (Y level, tunnel size...), then we get the starting coordinates from the GPS (this is important so that the turtle can get back to it's base), we check if the turtle needs torch refuel, and proceeds to go down to the Y level it received from the user.
On the correct Y level, it inits the real program. First, it goes 2 blocks forward, turns to the left, places a torch, and turns to the right again. It goes another 2 blocks, turns to the left once more and proceeds to excavate the tunnel size the user specified. When it gets to the end of it, it turns to the other side and goes all the way to the end of the opossite tunnel. When it finishes, it goes back to the "main hall", turns to the right and repeats for the amout of times the user asked.
Once it's done or it needs to depossite it's materials, it uses the gps to locate itself and goes back to base.


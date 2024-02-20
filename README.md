a)  Setup:
   1)  Open the file Setup(dark) to install DosBox and Notepad++.
   2)  In case this does not work for you guys, refer to the link: https://wetolearn.blogspot.com/2013/09/setting-up-afd-nasm-and-dosbox-for-8086.html 
   3)  As the code comprises of numerous lines, this makes the performance of the dosbox significantly slow, Therefore, we have to increase the DosBox Cycles.
   4)  Open the directory and go to assemblytools/DOSBoxPortable/Data/settings. Open the file called dosbox.conf with notepad. Search for the setting where cycles=auto. Change 'auto' to 10000, and we should be good to go.

b)  Game Instructions:
   1)  You can press any key to continue.
   2)  The game is called Jumping Bunny and has been written in assembly language 8086.
   3)  Press the Up key to jump. The idea is that the bunny must collect carrots as it moves up the bricks.
   4)  There are 4 types of bricks: Green, Blue, Orange and Purple
   5)  The Green Brick remains stationary wherever it pops up. The Blue Brick also stays stationary but it has a timer, if you stay on the blue brick for 3 seconds, the bunny will fall nd the game will be over.
   6)  The Purple and Orange Bricks move left to right in a fixed parameter.
   7)  Press Esc to pause the game. (Refer to the Pause Screen screenshot)
   8)  The game ends if the bunny misses a brick, or when the timer ends on the blue brick.
   9)  This instruction is the MOST IMPORTANT in the game. Enjoy! :)

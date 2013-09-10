HighLow NES Homebrew Game
===========================
Version 1.1

Useful Resources
-------------------------------
1. [nesdev](http://www.nesdev.com/)  
    A HUGE collection of resources, including documents over the NES architecture and 6502 assembly, example NES programs, and dev tools.

2. [Nerdy Nights](http://nintendoage.com/forum/messageview.cfm?catid=22&threadid=7155)  
    A good resource that goes in depth for many topics, ranging from beginning 6502 assembly to advance topics like bank switching

How to Compile
----------------------------
To compile the code, run the *Compile HighLow.bat* file with all of the .asm files, the cards.chr file, and the *NESASM3.exe*. This should generate a .nes file, which will run with a valid NES emulator. In terms of emulators to run this file, I would recommend are:  
  
1. Jnes
2. FCEUX

What is HighLow
-------------------------------
This card game is a simple one that I have heard go by a couple of names, the two most prominent being *Ride the Tide* and *High-Low*. The concept of the game is pretty simple:

1. Draw a card to start
2. Guess if the next card will be higher or lower than the current card. Draw another call
3. If you are correct, increase your streak, goto 2
4. If you are wrong, compare your high score to your current streak and update the high score if necessary

How To Play
-------------------
So as of right now, there is only the game screen. At the very minimum, a title screen is planned for the future. So I tried to make the game as simple as possible, so for the main gameplay there is only 2 buttons to worry about: up and down. The buttons work as so:

Title Screen  
Start - Select choice  
Select - Change choice

Info Screen  
Select - Return to title screen

Game Screen  
Up - Guess the next card will be higher  
Down - Guess the next card will be lower

The only other information one might need in order to successfully play is that I treat Aces as one, so Aces are low. Other than that, the game plays as described above.

Brief Summary of My Code
-----------------------------------------
Although I tried to make descriptive names for labels and comment as much as I could, it still could be a bit confusing on what exactly is going on, especially for the NES specific parts. My recommendation is to try to understand just enough to get through those parts (most of it is either commented, described via the label, or both) or make an attempt to learn what all parts of the code is doing (I would recommend Nerdy Nights for this, as it is where I learned about most of the NES specific code). In terms of file structure, I kept it pretty simple:

* HighLow.asm - This is the main file. It contains the resets and is where the code starts.
* cardmanipulations.asm - This file contains the functions for putting cards on and off screen.
* data.asm - This file contains most of the data for functions like setting up the background, palettes, and sprites. Makes life and code much easier.
* subroutines.asm - Just a file for all of the subroutines to prevent HighLow from getting too big.
* cards.chr - This file contains both the sprites and background resources for the game.

Other than that, my logic is pretty simple, and can be set up into 2 main phases (technically interrupts, as per how the NES works)

1. The Reset Interrupt - This interrupt is called the second the processor turns on or the reset button is pressed. The logic in this code is simple and easy: Set up everything in preparation for the NMI interrupt. Once it's done setting everything up, send it to an infinite loop to stop execution.
2. The NMI Interrupt - This is where the game logic starts. The NMI is called once per frame, so 60 times for a NTSC device and 50 times per second for PAL. My logic is as follows:  

<pre>
- Draw the current streak and highscore
- Read controller input
- Interpret controller input
- If valid, draw a psuedo-random card (randomness is determined by a frame counter)
- Check if guess was correct
- Change the card onscreen
- Finished with NMI
</pre>

Future Plans
---------------------
None currently, other than improve code

Things to Fix
---------------------
* Didn't realize this when drawing the sprites, but the first color in their palette is the alpha color, so the cards should actually have a black border and the numbers should be in a black color. I got around this by putting a black background where the numbers are on the cards.
* Currently, the LoadPalettes function doesn't quite work. Luckily, I'm not making the most colorful game, but could be a problem if I wanted to use more than 4 colors or different colors for sprites and the background.
* Currently, my psuedo-random number generator isn't that good. What I'm doing currently is counting the frames with an eight bit number, and when asked for a random card, I take the logical AND of the frame count with $0F (0F in hex). This will result in a 4 bit number, as the highest bits are now 0. So now that there are 4 bits, this gives me 16 possibilities (0-15). This is a descent way to create randomness, as only tools can legitly beat this system. Unfortunately, there are only 13 cards, so 3 cases are not handled, and as of right now those three cases are hardcoded to working cases.

Verison History
------------------
* 1.1 - Updated code. Updates include:
  1. Changed background loading to use 16 bit math (with 2 8 bit pointers) in order to reduce code and complexity 
* 1.0 - Current Version. Full game (Title screen, info screen, game). Works 100% as far as I know.
  Fixes include:
  1. Added a Title Screen
  2. Added an Info Screen
* 0.1 - Original. Just the game screen.
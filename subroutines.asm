
;; Subroutines

StartupState:
  LDA #$00
  STA ControllerHandler ; Start with a controller up
  LDA #TITLESCREEN
  STA GameState
  RTS

;; Set up the initial state of the game
;; Ace out, streak and high score = 0
InitialState:
  JSR AddAce
  LDA #ACE
  STA PreviousCard ; Card showing is now ace
  LDA #$00
  STA StreakOnes ; Start with a streak of 0
  STA StreakTens
  STA StreakHundreds
  STA HighScoreOnes
  STA HighScoreTens
  STA HighScoreHundreds
  RTS

;; Reads in player 1's controller input, puts it into
;; var PlayerOneController, all 8 bits read as follows:
;; |7|6|---5--|--4--|3-|-2--|-1--|--0--|
;; |A|B|Select|Start|Up|Down|Left|Right|
ReadController1:
  LDA #$01
  STA $4016
  LDA #$00
  STA $4016
  LDX #$08
ReadController1Loop:
  LDA $4016
  LSR A  ; Shift to the right 1 whatever is in Accumulator
  ROL PlayerOneController  ; Take what was just shifted out, put in controller
  DEX
  BNE ReadController1Loop
  RTS

;; Handle the pressing of the up button
UpPressed:
  LDA #$00
  STA Choice ; Choice = up
  LDA #$0F
  AND Counter ; Now we have a number from 0-15
  STA RandomNum ; Store it
  JMP HandleF ; Handle 13-15, which are not cards

;; Handle the pressing of the down button
DownPressed:
  LDA #$01
  STA Choice
  LDA #$0F
  AND Counter
  STA RandomNum

;; Handle the 3 out of bounds cases
;; Fix this to make it more random eventually
HandleF:
  LDA RandomNum
  CMP #$0F
  BNE HandleE
  LDA #$03
  STA RandomNum
HandleE:
  LDA RandomNum
  CMP #$0E
  BNE HandleD
  LDA #$06
  STA RandomNum
HandleD:
  LDA RandomNum
  CMP #$0D
  BNE CardSelected
  LDA #$09
  STA RandomNum

;; Everythings now set, check to see if correct guess, change
;; card view, and put controller in pressed state
CardSelected:
  JSR CheckCorrectGuess
  JSR RemoveAllCards
  JSR AddSelectedCard
  LDA #$01
  STA ControllerHandler
  RTS

;; Removes the current card form the screen
RemoveAllCards:
  JSR RemoveAce
  JSR RemoveTwo
  JSR RemoveThree
  JSR RemoveFour
  JSR RemoveFive
  JSR RemoveSix
  JSR RemoveSeven
  JSR RemoveEight
  JSR RemoveNine
  JSR RemoveTen
  JSR RemoveJack
  JSR RemoveQueen
  JSR RemoveKing
FoundAndRemovedCard:
  RTS

;; Add card to the screen
AddSelectedCard:
CheckAddAce:
  LDA RandomNum
  CMP #ACE
  BNE CheckAddTwo
  JSR AddAce
  LDA #ACE
  STA PreviousCard
  JMP FoundAndAddedCard
CheckAddTwo:
  LDA RandomNum
  CMP #TWO
  BNE CheckAddThree
  JSR AddTwo
  LDA #TWO
  STA PreviousCard
  JMP FoundAndAddedCard
CheckAddThree:
  LDA RandomNum
  CMP #THREE
  BNE CheckAddFour
  JSR AddThree
  LDA #THREE
  STA PreviousCard
  JMP FoundAndAddedCard
CheckAddFour:
  LDA RandomNum
  CMP #FOUR
  BNE CheckAddFive
  JSR AddFour
  LDA #FOUR
  STA PreviousCard
  JMP FoundAndAddedCard
CheckAddFive:
  LDA RandomNum
  CMP #FIVE
  BNE CheckAddSix
  JSR AddFive
  LDA #FIVE
  STA PreviousCard
  JMP FoundAndAddedCard
CheckAddSix:
  LDA RandomNum
  CMP #SIX
  BNE CheckAddSeven
  JSR AddSix
  LDA #SIX
  STA PreviousCard
  JMP FoundAndAddedCard
CheckAddSeven:
  LDA RandomNum
  CMP #SEVEN
  BNE CheckAddEight
  JSR AddSeven
  LDA #SEVEN
  STA PreviousCard
  JMP FoundAndAddedCard
CheckAddEight:
  LDA RandomNum
  CMP #EIGHT
  BNE CheckAddNine
  JSR AddEight
  LDA #EIGHT
  STA PreviousCard
  JMP FoundAndAddedCard
CheckAddNine:
  LDA RandomNum
  CMP #NINE
  BNE CheckAddTen
  JSR AddNine
  LDA #NINE
  STA PreviousCard
  JMP FoundAndAddedCard
CheckAddTen:
  LDA RandomNum
  CMP #TEN
  BNE CheckAddJack
  JSR AddTen
  LDA #TEN
  STA PreviousCard
  JMP FoundAndAddedCard
CheckAddJack:
  LDA RandomNum
  CMP #JACK
  BNE CheckAddQueen
  JSR AddJack
  LDA #JACK
  STA PreviousCard
  JMP FoundAndAddedCard
CheckAddQueen:
  LDA RandomNum
  CMP #QUEEN
  BNE CheckAddKing
  JSR AddQueen
  LDA #QUEEN
  STA PreviousCard
  JMP FoundAndAddedCard
CheckAddKing:
  LDA RandomNum
  CMP #KING
  BNE FoundAndAddedCard
  JSR AddKing
  LDA #KING
  STA PreviousCard
FoundAndAddedCard:
  RTS

;; Checks to see if the player guessed correctly
CheckCorrectGuess:
  LDA PreviousCard
  CMP RandomNum
  BEQ CheckCorrectCorrect ; We consider same cards correct
  BPL CheckCorrectLower ; PreviousCard > RandomNum(new card)
  BMI CheckCorrectHigher ; PreviousCard > RandomNum 
CheckCorrectHigher:
  LDA Choice
  CMP #$00
  BEQ CheckCorrectCorrect
  JMP CheckCorrectWrong
CheckCorrectLower:
  LDA Choice
  CMP #$01
  BEQ CheckCorrectCorrect
  JMP CheckCorrectWrong
CheckCorrectCorrect:
  JSR IncrementStreak
  JMP DoneCheckGuess
CheckCorrectWrong:
  JSR UpdateHighScore
  JSR ResetStreak
DoneCheckGuess:
  RTS

;; Checks to see if current streak > high score
;; if so, high score = current streak
UpdateHighScore:
UpdateHundredsHighScoreCheck:
  LDA StreakHundreds
  CMP HighScoreHundreds
  BMI NoNewHighScore
  LDA StreakHundreds
  CMP HighScoreHundreds
  BEQ UpdateTensHighScoreCheck
  JMP NewHighScore
UpdateTensHighScoreCheck:
  LDA StreakTens
  CMP HighScoreTens
  BMI NoNewHighScore
  LDA StreakTens
  CMP HighScoreTens
  BEQ UpdateOnesHighScoreCheck
  JMP NewHighScore
UpdateOnesHighScoreCheck:
  LDA StreakOnes
  CMP HighScoreOnes
  BMI NoNewHighScore
NewHighScore:
  LDA StreakOnes
  STA HighScoreOnes
  LDA StreakTens
  STA HighScoreTens
  LDA StreakHundreds
  STA HighScoreHundreds
NoNewHighScore:
  RTS

;; Increments streak by 1
IncrementStreak:
IncrementOnes:
  INC StreakOnes ; StreakOnes++
  LDA StreakOnes ; load to A
  CMP #$0A ; check if the one's place reached 10
  BNE IncrementStreakDone ; If not, done
IncrementTens:
  LDA #$00
  STA StreakOnes ; reset StreakOnes to 0
  INC StreakTens
  LDA StreakTens
  CMP #$0A
  BNE IncrementStreakDone
IncrementHundreds:
  LDA #$00
  STA StreakTens
  LDA StreakHundreds
  CMP #$09 ; Check to see if player is at 999
  BEQ KeepStreakHighest ; Keep them at 999. No reason to go higher... I hope
  INC StreakHundreds
  JMP IncrementStreakDone
KeepStreakHighest:
  LDA #$09
  STA StreakOnes
  STA StreakTens
  STA StreakHundreds
IncrementStreakDone:
  RTS

;; Resets the streak down to 0
ResetStreak:
  LDA #$00
  STA StreakOnes
  STA StreakTens
  STA StreakHundreds
  RTS

;; Puts the current streak on screen. Works well because the numbers
;; 0-9 correlate with the decimal numbers 0-9 in the .chr file for the
;; background, so no need to offset any
DrawStreak:
  LDA $2002
  LDA #$20 ; High byte of where to load in name table
  STA $2006
  LDA #$B4 ; Low byte of where to load in name table
  STA $2006
  LDA StreakHundreds
  STA $2007
  LDA StreakTens
  STA $2007
  LDA StreakOnes
  STA $2007
  RTS

;; Puts current high score on screen
DrawHighScore:
  LDA $2002
  LDA #$28
  STA $2006
  LDA #$F0
  STA $2006
  LDA HighScoreHundreds
  STA $2007
  LDA HighScoreTens
  STA $2007
  LDA HighScoreOnes
  STA $2007
  RTS

DrawGameBackground:
LoadGameBackground:
  LDA $2002
  LDA #$20
  STA $2006
  LDA #$00
  STA $2006
  LDA #LOW(gameBackground)
  STA PointerLow
  LDA #HIGH(gameBackground)
  STA PointerHigh
  LDX #$00
  LDY #$00
OutsideGameBackgroundLoop:
InsideGameBackgroundLoop:
  LDA [PointerLow], y
  STA $2007
  INY
  CPY #$00
  BNE InsideGameBackgroundLoop
  INC PointerHigh
  INX
  CPX #$04
  BNE OutsideGameBackgroundLoop
  RTS

DrawTitleScreen:
LoadTitleBackground:
  LDA $2002
  LDA #$20
  STA $2006
  LDA #$00
  STA $2006
  LDA #LOW(titleBackground)
  STA PointerLow
  LDA #HIGH(titleBackground)
  STA PointerHigh
  LDX #$00
  LDY #$00
OutsideTitleBackgroundLoop:
InsideTitleBackgroundLoop:
  LDA [PointerLow], y
  STA $2007
  INY
  CPY #$00
  BNE InsideTitleBackgroundLoop
  INC PointerHigh
  INX
  CPX #$04
  BNE OutsideTitleBackgroundLoop
  RTS

DrawInstructionsScreen:
LoadInstructionsBackground:
  LDA $2002
  LDA #$20
  STA $2006
  LDA #$00
  STA $2006
  LDA #LOW(instructionsBackground)
  STA PointerLow
  LDA #HIGH(instructionsBackground)
  STA PointerHigh
  LDX #$00
  LDY #$00
OutsideInstructionsBackgroundLoop:
InsideInstructionsBackgroundLoop:
  LDA [PointerLow], y
  STA $2007
  INY
  CPY #$00
  BNE InsideInstructionsBackgroundLoop
  INC PointerHigh
  INX
  CPX #$04
  BNE OutsideInstructionsBackgroundLoop
  RTS

TitleScreenSelectorStart:
  LDA #$B0
  STA $0234
  LDA #$4E
  STA $0235
  LDA $00
  STA $0236
  LDA #$58
  STA $0237
  RTS

TitleScreenSelectorInstructions:
  LDA #$C0
  STA $0234
  LDA #$4E
  STA $0235
  LDA $00
  STA $0236
  LDA #$58
  STA $0237
  RTS

SelectorOff:
  LDA #$F0
  STA $0234
  LDA $4E
  STA $0235
  LDA #$00
  STA $0236
  STA $0237
  RTS

ReturnToTitle:
  LDA #$00
  STA $2000
  STA $2001
  JSR DrawTitleScreen
  LDA #%10010000
  STA $2000
  LDA #%00011110
  STA $2001
  JSR TitleScreenSelectorStart
  JSR StartupState
  RTS

HandleTitleStart:
  LDA TitleSelectSpot
  CMP #START
  BEQ RunStartGame
  CMP #INSTRUCTIONS
  BEQ RunInstructionsScreen
  RTS

RunStartGame:
  JSR StartGame
  RTS

RunInstructionsScreen:
  JSR InstructionsScreen
  RTS

InstructionsScreen:
  LDA #$00
  STA $2000
  STA $2001
  LDA #INSTRUCTIONSSCREEN
  STA GameState
  JSR DrawInstructionsScreen
  LDA #%10010000
  STA $2000
  LDA #%00011110
  STA $2001
  JSR SelectorOff
  RTS

StartGame:
  LDA #$00 ; Turn off screen before redrawing it
  STA $2000
  STA $2001
  LDA #GAMESCREEN
  STA GameState
  JSR InitialState
  JSR DrawGameBackground
  LDA #%10010000
  STA $2000
  LDA #%00011110
  STA $2001
  JSR SelectorOff
  RTS

TitleSelect:
  LDA TitleSelectSpot
  CMP #START
  BNE MoveToStart
MoveToSelect:
  LDA #INSTRUCTIONS
  STA TitleSelectSpot
  JSR TitleScreenSelectorInstructions
  JMP DoneWithTitleSelect
MoveToStart:
  LDA #START
  STA TitleSelectSpot
  JSR TitleScreenSelectorStart
DoneWithTitleSelect:
  LDA #$01
  STA ControllerHandler
  RTS

;; For debugging. A visual cue of something running
;; Will shake screen if called after PPU cleanup
;; Will also draw a number at top left of screen
DebugScreenShake:
  LDA $2002
  LDA #$20
  STA $2006
  LDA #$63
  STA $2006
  LDA $00
  STA $2007
  RTS
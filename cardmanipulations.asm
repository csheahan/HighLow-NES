
;; Functions which either put a card in place or remove it

AddAce:
  LDX #$00
AddAceLoop:
  LDA aceon, x
  STA $0200, x
  INX
  CPX #$18
  BNE AddAceLoop
  RTS

RemoveAce:
  LDX #$00
RemoveAceLoop:
  LDA aceoff, x
  STA $0200, x
  INX
  CPX #$18
  BNE RemoveAceLoop
  RTS

AddTwo:
  LDX #$00
AddTwoLoop:
  LDA twoon, x
  STA $0204, x
  INX
  CPX #$18
  BNE AddTwoLoop
  RTS

RemoveTwo:
  LDX #$00
RemoveTwoLoop:
  LDA twooff, x
  STA $0204, x
  INX
  CPX #$18
  BNE RemoveTwoLoop
  RTS

AddThree:
  LDX #$00
AddThreeLoop:
  LDA threeon, x
  STA $0208, x
  INX
  CPX #$18
  BNE AddThreeLoop
  RTS

RemoveThree:
  LDX #$00
RemoveThreeLoop:
  LDA threeoff, x
  STA $0208, x
  INX
  CPX #$18
  BNE RemoveThreeLoop
  RTS

AddFour:
  LDX #$00
AddFourLoop:
  LDA fouron, x
  STA $020C, x
  INX
  CPX #$18
  BNE AddFourLoop
  RTS

RemoveFour:
  LDX #$00
RemoveFourLoop:
  LDA fouroff, x
  STA $020C, x
  INX
  CPX #$18
  BNE RemoveFourLoop
  RTS

AddFive:
  LDX #$00
AddFiveLoop:
  LDA fiveon, x
  STA $0210, x
  INX
  CPX #$18
  BNE AddFiveLoop
  RTS

RemoveFive:
  LDX #$00
RemoveFiveLoop:
  LDA fiveoff, x
  STA $0210, x
  INX
  CPX #$18
  BNE RemoveFiveLoop
  RTS

AddSix:
  LDX #$00
AddSixLoop:
  LDA sixon, x
  STA $0214, x
  INX
  CPX #$18
  BNE AddSixLoop
  RTS

RemoveSix:
  LDX #$00
RemoveSixLoop:
  LDA sixoff, x
  STA $0214, x
  INX
  CPX #$18
  BNE RemoveSixLoop
  RTS

AddSeven:
  LDX #$00
AddSevenLoop:
  LDA sevenon, x
  STA $0218, x
  INX
  CPX #$18
  BNE AddSevenLoop
  RTS

RemoveSeven:
  LDX #$00
RemoveSevenLoop:
  LDA sevenoff, x
  STA $0218, x
  INX
  CPX #$18
  BNE RemoveSevenLoop
  RTS

AddEight:
  LDX #$00
AddEightLoop:
  LDA eighton, x
  STA $021C, x
  INX
  CPX #$18
  BNE AddEightLoop
  RTS

RemoveEight:
  LDX #$00
RemoveEightLoop:
  LDA eightoff, x
  STA $021C, x
  INX
  CPX #$18
  BNE RemoveEightLoop
  RTS

AddNine:
  LDX #$00
AddNineLoop:
  LDA nineon, x
  STA $0220, x
  INX
  CPX #$18
  BNE AddNineLoop
  RTS

RemoveNine:
  LDX #$00
RemoveNineLoop:
  LDA eightoff, x
  STA $0220, x
  INX
  CPX #$18
  BNE RemoveNineLoop
  RTS

AddTen:
  LDX #$00
AddTenLoop:
  LDA tenon, x
  STA $0224, x
  INX
  CPX #$18
  BNE AddTenLoop
  RTS

RemoveTen:
  LDX #$00
RemoveTenLoop:
  LDA tenoff, x
  STA $0224, x
  INX
  CPX #$18
  BNE RemoveTenLoop
  RTS

AddJack:
  LDX #$00
AddJackLoop:
  LDA jackon, x
  STA $0228, x
  INX
  CPX #$18
  BNE AddJackLoop
  RTS

RemoveJack:
  LDX #$00
RemoveJackLoop:
  LDA jackoff, x
  STA $0228, x
  INX
  CPX #$18
  BNE RemoveJackLoop
  RTS

AddQueen:
  LDX #$00
AddQueenLoop:
  LDA queenon, x
  STA $022C, x
  INX
  CPX #$18
  BNE AddQueenLoop
  RTS

RemoveQueen:
  LDX #$00
RemoveQueenLoop:
  LDA queenoff, x
  STA $022C, x
  INX
  CPX #$18
  BNE RemoveQueenLoop
  RTS

AddKing:
  LDX #$00
AddKingLoop:
  LDA kingon, x
  STA $0230, x
  INX
  CPX #$18
  BNE AddKingLoop
  RTS

RemoveKing:
  LDX #$00
RemoveKingLoop:
  LDA kingoff, x
  STA $0230, x
  INX
  CPX #$18
  BNE RemoveKingLoop
  RTS
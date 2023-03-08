.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

CHROUT = $FFD2 ; text output location
NEWLINE = $0D
SPACE = $20

SAUCE_PTR = $30

jmp start

sauce: .byte $A1

print_hex:
   pha
   lsr
   lsr
   lsr
   lsr
   jsr print_hex_digit
   pla
   and #$0F
   jsr print_hex_digit
   rts

print_hex_digit:
   cmp #$0A
   bpl @letter
   ora #$30
   bra @print

@letter:
   clc
   adc #$37

@print:
   jsr CHROUT
   rts

start:
   ldx #<sauce
   stx SAUCE_PTR
   ldy #>sauce
   sty SAUCE_PTR+1
   lda (SAUCE_PTR)
   jsr print_hex
   ldx #NEWLINE
   txa
   jsr CHROUT
   stz sauce ; zero's out the variable location in RAM
   ldy sauce
   tya
   jsr CHROUT
   txa
   jsr CHROUT
   rts

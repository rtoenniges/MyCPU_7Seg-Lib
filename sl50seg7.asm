;[ASCII]

;******************************************
;*******  2x7Seg-Display Driver  **********
;******************************************
;*******  2016 by Robin Tönniges  *********
;******************************************

;D0 = a
;D1 = b
;D2 = c
;D3 = d
;D4 = e
;D5 = f
;D6 = g
;D7 = dot

;Include
#include <library.hsm>
#include <ctype.hsm> 

;Declare variables
DISPLAY    EQU 3000h ;7Segement display adress (3000h - 3001h)

;Constants for diplay with common anode!
CONST_0   EQU C0h
CONST_1   EQU F9h
CONST_2   EQU A4h
CONST_3   EQU B0h
CONST_4   EQU 99h
CONST_5   EQU 92h
CONST_6   EQU 82h
CONST_7   EQU F8h
CONST_8   EQU 80h
CONST_9   EQU 90h
CONST_A   EQU 88h
CONST_B   EQU 83h
CONST_C   EQU C6h
CONST_D   EQU A1h
CONST_E   EQU 86h
CONST_F   EQU 8Eh

;Program start
codestart
#include <library.hsm>  ;include library source code

initfunc
        JSR func_clearDisplay        
        CLA
        RTS
        
termfunc
        CLA
        RTS     

funcdispatch
        DEC ;Accu = 1
        JPZ  func_dispHex
        DEC ;Accu = 2
        JPZ  func_dispDec
        DEC ;Accu = 3
        JPZ  func_clearDisplay
        DEC ;Accu = 4
        JPZ  func_getEntryPoint
        RTS

func_dispHex
        SAX
        ;low nibble
        PHA
        AND #0Fh
        JSR getSeg
        STAA DISPLAY

        ;high nibble
        PLA
        SWP
        AND #0Fh
        JSR getSeg
        STAA DISPLAY+1
        CLA
        RTS
        
func_dispDec
        SAX
        ;ones
        PHA
        MOD #10
        AND #0Fh
        JSR getSeg
        STAA DISPLAY
        
        ;tens
        PLA
        DIV #10
        AND #0Fh
        JSR getSeg
        STAA DISPLAY+1
        CLA
        RTS
            
func_clearDisplay
        LDA #FFh
        STAA DISPLAY    
        LDA #FFh
        STAA DISPLAY+1
        CLA
        RTS
        
func_getEntryPoint
        LPT #funcdispatch
        CLA
        RTS

getSeg
        CMP #00h
        JNZ _01
        LDA #CONST_0
        JMP _RTS
_01     CMP #01h
        JNZ _02
        LDA #CONST_1
        JMP _RTS
_02     CMP #02h
        JNZ _03
        LDA #CONST_2
        JMP _RTS
_03     CMP #03h
        JNZ _04
        LDA #CONST_3
        JMP _RTS
_04     CMP #04h
        JNZ _05
        LDA #CONST_4
        JMP _RTS
_05     CMP #05h
        JNZ _06
        LDA #CONST_5
        JMP _RTS
_06     CMP #06h
        JNZ _07
        LDA #CONST_6
        JMP _RTS
_07     CMP #07h
        JNZ _08
        LDA #CONST_7
        JMP _RTS
_08     CMP #08h
        JNZ _09
        LDA #CONST_8
        JMP _RTS
_09     CMP #09h
        JNZ _0A
        LDA #CONST_9
        JMP _RTS
_0A     CMP #0Ah
        JNZ _0B
        LDA #CONST_A
        JMP _RTS
_0B     CMP #0Bh
        JNZ _0C
        LDA #CONST_B
        JMP _RTS
_0C     CMP #0Ch
        JNZ _0D
        LDA #CONST_C
        JMP _RTS
_0D     CMP #0Dh
        JNZ _0E
        LDA #CONST_D
        JMP _RTS
_0E     CMP #0Eh
        JNZ _0F
        LDA #CONST_E
        JMP _RTS
_0F     CMP #0Fh
        JNZ _RTS
        LDA #CONST_F
        
_RTS    RTS

;	trace	on

	org $8000
	incbin "../rom.bin"

	processor   hd6303

; HW offsets

reg_port2dir			equ $01
reg_port2			equ $03
reg_timerControl_status1	equ $08
reg_timerControl_status2	equ $0f
reg_rateModeControl		equ $10
reg_txrxControlStatus		equ $11
reg_receiveData			equ $12
reg_ramPort5ctl			equ $14
reg_port6dir			equ $16
reg_port6			equ $17

io_displayStatus		equ $30
io_displayChar			equ $31

; IDA Names

OutputBufToDisplay		equ $9357

; Patched code

	; instead of main loop
;	org $8015
;	ldx     #Message
;	ldaa    #MessageLen
;	jsr     OutputBufToDisplay
;Loop:
;	bra Loop

;	org $8000
;Reset:
;	lds $F4A
;	jsr InitPorts
;	jsr InitDisplay
;	jsr PrintHello
;MainLoop:
;	jmp MainLoop
;
;InitPorts subroutine
;	ldab    #$41 ; 'A'
;	stab    reg_ramPort5ctl ; IRQ1E - enable interrupt pin P50
;                        ; RAME - enable on-chip RAM
;	clra
;	staa    reg_rateModeControl
;	ldab    #8
;	stab    reg_txrxControlStatus ; receive enable to port2 bit3
;	staa    reg_port2
;	ldab    #2
;	stab    reg_port2dir   ; port2 bits 1-7 - output
;	staa    reg_port2
;	ldab    reg_receiveData
;	ldd     #$A6
;	jsr     Sleep
;	clra
;	ldab    #$80 ; 'À'
;	stab    reg_port2
;	ldab    #$FF
;	stab    reg_port6dir   ; port6 - output
;	staa    reg_port6
;	staa    reg_timerControl_status1
;	staa    reg_timerControl_status2
;	ldab    #$18
;	stab    $24
;	rts
;
;Sleep subroutine
;	psha
;	pshb
;.wait:
;	subd	#1
;	bne	.wait
;	pulb
;	pula
;	rts
;
;PrintHello subroutine
;	ldx     #Message
;	ldaa    #MessageLen
;	jsr     OutputBufToDisplay
;	rts
;
;InitDisplay subroutine
;	psha
;	pshb
;	pshx
;	ldab    #$20
;;.loc_92D4:
;;	decb
;;	beq     .loc_92F2
;;	tim     #$80, io_displayStatus
;;	bne     .loc_92D4
;	ldaa    #$38
;	staa    io_displayStatus
;;;;
;	ldd     #$A6
;	jsr     Sleep
;;	jsr     ReadDisplayStatusA
;	ldaa    #1
;	staa    io_displayStatus
;	ldd     #$A6
;	jsr     Sleep
;;	jsr     ReadDisplayStatusA
;	ldaa    #2
;	staa    io_displayStatus
;	ldd     #$A6
;	jsr     Sleep
;;	jsr     ReadDisplayStatusA
;	ldaa    #$C
;	staa    io_displayStatus
;	ldd     #$A6
;	jsr     Sleep
;;	jsr     ReadDisplayStatusA
;	ldaa    #6
;	staa    io_displayStatus
;	ldd     #$A6
;	jsr     Sleep
;;	jsr     ReadDisplayStatusA
;	ldaa    #$40
;	jsr     SetDisplayStatus
;
;	ldab    #$44
;	clra
;.clearDisplay:
;	jsr     OutputCharToDisplay
;	decb
;	bne     .clearDisplay
;;;;
;.loc_92F2:
;	pulx
;	pulb
;	pula
;	rts
;
;OutputBufToDisplay subroutine
;; x - buffer
;; a - number of characters
;	psha                    
;	pshb
;	pshx
;	tab
;	ldaa    #$80 ; 'À'
;	jsr     SetDisplayStatus
;.loop
;	ldaa    0,x
;	jsr     OutputCharToDisplay
;	inx
;	decb
;	bne     .loop
;	pulx
;	pulb
;	pula
;	rts
;
;ReadDisplayStatusA subroutine
;	tim     #$80, io_displayStatus
;	bne     ReadDisplayStatusA
;	ldaa    io_displayStatus
;	rts
;
;SetDisplayStatus subroutine
;	ldd     #$A6
;	jsr     Sleep
;;	tim     #$80, io_displayStatus ; 'À'
;;	bne     SetDisplayStatus
;	staa    io_displayStatus
;	rts
;
;OutputCharToDisplay subroutine
;	ldd     #$A6
;	jsr     Sleep
;;	tim     #$80, io_displayStatus ; 'À'
;;	bne     OutputCharToDisplay
;	staa    io_displayChar
;	rts

	; some empty space there
	org	$feb8
Message	dc.b "Hello, world!", 0
MessageEnd
MessageLen	equ (MessageEnd - Message)

;	org $ffe8
;	dc.w Reset, Reset, Reset, Reset
;	dc.w Reset, Reset, Reset, Reset
;	dc.w Reset, Reset, Reset, Reset

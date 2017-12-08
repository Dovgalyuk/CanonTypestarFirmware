	processor   hd6303

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

	org $8000
Reset:
	lds $F4A
	bsr InitPorts
MainLoop:
	jmp MainLoop

InitPorts subroutine
	ldab    $41 ; 'A'
	stab    reg_ramPort5ctl ; IRQ1E - enable interrupt pin P50
                        ; RAME - enable on-chip RAM
	clra
	staa    reg_rateModeControl
	ldab    8
	stab    reg_txrxControlStatus ; receive enable to port2 bit3
	staa    reg_port2
	ldab    2
	stab    reg_port2dir   ; port2 bits 1-7 - output
	staa    reg_port2
	ldab    reg_receiveData
	ldd     $A6
	jsr     Sleep
	clra
	ldab    $80 ; 'À'
	stab    reg_port2
	ldab    $FF
	stab    reg_port6dir   ; port6 - output
	staa    reg_port6
	staa    reg_timerControl_status1
	staa    reg_timerControl_status2
	ldab    $18
	stab    $24
	rts

Sleep subroutine
	psha
	pshb
.wait:
	subd	#1
	bne	.wait
	pulb
	pula
	rts

	org $ffe8
	dc.w Reset, Reset, Reset, Reset
	dc.w Reset, Reset, Reset, Reset
	dc.w Reset, Reset, Reset, Reset

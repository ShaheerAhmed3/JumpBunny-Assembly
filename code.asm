[org 0x0100]
jmp start

;-----------------------------------------------
;Clear Screen
;-----------------------------------------------
clrscr:		push ax
			push es
			push di
			push cx
			
			mov ax,0x9000
			mov es,ax
			mov di,0
			mov cx,64000
			mov ax,0
			rep stosb
			call printbuffer
			
			pop cx
			pop di
			pop es
			pop ax
			ret
;-----------------------------------------------
;Initially Draws the 3 Sections
;-----------------------------------------------
Sections:	push bp
			mov bp, sp
			push es
			push ax
			push cx
			push si
			push di
			
			mov ax,0x9000
			mov es,ax
			mov di,0
			cld
			mov ax,0x2F		;Green Background
			mov cx,15040
			rep stosb
				
			mov ax,1			;Prints Foxes
			mov cx,11
			l19: 	push ax
					call Fox
					add ax,30
					loop l19
				
			mov cx,10
			mov ax,2577
			l20:	push ax
					call Fox
					add ax,30
					loop l20
			mov cx,19
			mov ax,9280
			
			mov di,8000
			mov ax,0x2F		;Green Background
			mov cx,3200
			rep stosb
			
			;Line
			mov ax,0
			mov cx,320
			mov di,7680
			rep stosb
			mov cx,640
			mov ax,0xf
			rep stosb
			mov ax,0
			mov cx,320
			rep stosb
			
			mov ax,8000
			mov cx,11
			l21: 	push ax
					call Fox
					add ax,30
					loop l21
				
			mov cx,10
			mov ax,10576
			l22:	push ax
					call Fox
					add ax,30
					loop l22
			
			mov di,15040
			mov ax,0x17		;Grey Background
			mov cx,16000
			rep stosb
			
			call Road
			push 16160
			call RabbitAnimation
			call AllBees
			call FinishingLine
			
			mov di,15040		;Black Line Above the Road
			mov ax,0
			mov cx,640
			rep stosb
			
			mov di,30400		;Black Line Below the Road
			mov cx,640
			rep stosb
			
			pop di
			pop si
			pop cx
			pop ax
			pop es
			pop bp
			ret 
;-----------------------------------------
;Save Section 1
;-----------------------------------------
SaveSection1:	push ax
				push cx
				push es
				push di
				push ds
				push si
				
				mov ax,0x9000
				mov ds,ax
				mov ax,arrForSection
				mov es,ax
				mov di,0
				mov si,0
				
				mov cx,15040
				rep movsb
				
				pop si
				pop ds
				pop di
				pop	es
				pop cx
				pop ax
				ret	
;-----------------------------------------
;Clears Section 1
;-----------------------------------------
ClrSection1:	push ax
				push cx
				push es
				push di
				push ds
				push si
				
				mov ax,0x9000
				mov es,ax
				mov ax,arrForSection
				mov ds,ax
				mov di,0
				mov si,0
				
				mov cx,15040
				rep movsb
				
				pop si
				pop ds
				pop di
				pop	es
				pop cx
				pop ax
				ret	
;--------------------------------------------------
;Clears Section 2
;--------------------------------------------------
ClrSection2:	push ax
				push cx
				push es
				push di
				
				mov ax,0x9000
				mov es,ax
				mov di,16000
				
				mov ax,0x3	;Green Background
				mov cx,16000
				rep stosb
				
				pop di
				pop	es
				pop cx
				pop ax
				ret	
;-------------------------------------------------------------
;Clears Section 3
;-------------------------------------------------------------
ClrSection3:	push ax
				push cx
				push es
				push di
				
				mov ax,0x9000
				mov es,ax
				mov di,31040
				
				mov ax,0x3	;Green Background
				mov cx,32960
				rep stosb
				
				pop di
				pop	es
				pop cx
				pop ax
				ret	
;---------------------------------------------------------
;Draws the White Boxes in the Road
;---------------------------------------------------------				
Road:		push bp
			mov bp,sp
			pushad
			push di
			push es
			mov ax,0x9000
			mov es,ax
			mov ax,0xf
			mov di,22430
			mov bx,5
			mov dx,10
			l1:	mov cx,30
				rep stosb
				add di,30
				dec bx
				jnz l1
				mov bx,5
				add di,20
				dec dx
				jnz l1
			pop es
			pop di
			popad
			pop bp
			ret
;-----------------------------------------------------
;Prints String 
;-----------------------------------------------------
stringprint:
			push bp
			mov bp,sp
            pusha
			push es
            mov ax,cs
            mov es,ax
            mov ah,13h				;service to print string in graphic mode
            mov al,0				;sub-service 0 
            mov bx,[bp+6] 			;color of the text (white foreground and black background) in bl,bh=0
			mov bh,0				;page number=always zero
            mov cx,[bp+8]			;length of string
			mov dx,[bp+4] 			;dh->y coordinate dl->x coordinate
            mov bp,[bp+10]			;mov bp the offset of the string
            int 10h
			pop es
            popa
			pop bp
            ret 8
;-----------------------------------------------------
;Draws Playbutton Used in Intro Screen
;-----------------------------------------------------
Playbutton:
		push bp
		mov bp,sp
		push es
		pushad
		push di
		push 0x9000
		pop es
		mov di,[bp+4] ;rows
		imul di,320
		add di,[bp+6] ; cols
		mov ax,0x6
		mov cx,5
		rep stosb
		add di,312
		mov ax,0x6
		mov cx,3
		rep stosb
		add di,5
		mov ax,0x6
		mov cx,3
		rep stosb
		add di,307
		mov ax,0x6
		mov cx,2
		rep stosb
		add di,3
		mov ax,0x2c
		mov cx,5
		rep stosb
		add di,3
		mov ax,0x6
		mov cx,2
		rep stosb
		add di,303
		mov ax,0x6
		mov cx,2
		rep stosb
		add di,2
		mov ax,0x2c
		mov cx,11
		rep stosb
		add di,2
		mov ax,0x6
		mov cx,2
		rep stosb
		add di,300
		mov ax,0x6
		stosb
		add di,2
		mov ax,0x2c
		mov cx,15
		rep stosb
		add di,2
		mov ax,0x6
		stosb
		add di,298
		mov ax,0x6
		stosb
		add di,1
		mov ax,0x2c
		mov cx,19
		rep stosb
		add di,1
		mov ax,0x6
		stosb
		add di,297
		mov ax,0x6
		stosb
		add di,1
		mov ax,0x2c
		mov cx,19
		rep stosb
		add di,1
		mov ax,0x6
		stosb
		add di,296
		mov bx,4
		l23:
		mov ax,0x6
		stosb
		add di,1
		mov ax,0x2c
		mov cx,21
		rep stosb
		add di,1
		mov ax,0x6
		stosb
		add di,295
		dec bx
		jnz l23
		dec di
		mov bx,5
		l24:
		mov ax,0x6
		stosb
		add di,1
		mov ax,0x2c
		mov cx,23
		rep stosb
		add di,1
		mov ax,0x6
		stosb
		add di,293
		dec bx
		jnz l24
		inc di
		mov bx,4
		l25:
		mov ax,0x6
		stosb
		add di,1
		mov ax,0x2c
		mov cx,21
		rep stosb
		add di,1
		mov ax,0x6
		stosb
		add di,295
		dec bx
		jnz l25
		inc di
		mov bx,2
		l26:
		mov ax,0x6
		stosb
		add di,1
		mov ax,0x2c
		mov cx,19
		rep stosb
		add di,1
		mov ax,0x6
		stosb
		add di,297
		dec bx
		jnz l26
		inc di
		mov ax,0x6
		stosb
		add di,2
		mov ax,0x2c
		mov cx,16
		rep stosb
		add di,1
		mov ax,0x6
		stosb
		add di,300
		mov ax,0x6
		mov cx,2
		rep stosb
		add di,2
		mov ax,0x2c
		mov cx,11
		rep stosb
		add di,3
		mov ax,0x6
		stosb
		add di,303
		mov ax,0x6
		mov cx,2
		rep stosb
		add di,3
		mov ax,0x2c
		mov cx,5
		rep stosb
		add di,3
		mov ax,0x6
		mov cx,2
		rep stosb
		add di,307
		mov ax,0x6
		mov cx,3
		rep stosb
		add di,5
		mov ax,0x6
		mov cx,3
		rep stosb
		add di,312
		mov ax,0x6
		mov cx,5
		rep stosb
		pop di
		popad
		pop es
		pop bp
		ret 4
;-----------------------------------------------------
;Draws End screen
;-----------------------------------------------------
EndScreen:
	push bp
	mov bp,sp
	push es
	pushad
	mov ax,0x9000
	mov es,ax
	mov di,0
	mov ax,3
	mov cx,64000
	rep stosb
	;outline for GameOver
	push 25	;height
	push 29 	;rows
	push 95	;cols
	push 122 	;width
	push 0x2a	;color
	call HollowBox
	;Box for GameOver
	push 23 	;height
	mov bh,30 	;rows
	mov bl,96 	;cols
	push bx
	push 120  	;width
	push 0  	;color
	call Box
	;outline for Score
	push 32	;height
	push 67 	;rows
	push 124	;cols
	push 62 	;width
	push 0x2a	;color
	call HollowBox
	;Box for Score
	push 30 	;height
	mov bh,68 	;rows
	mov bl,125 	;cols
	push bx
	push 60  	;width
	push 0  	;color
	call Box
	call printbuffer
	;Title Printing:
	push sc     ;address ofstring
	push 5			;length of String
	mov bx,0x000f	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push bx		
	push 0x0911 ;rows-cols
	call stringprint
	;TGame Over Printing:
	push GameOver     ;address ofstring
	push 8			;length of String
	mov bx,0x000f	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push bx		
	push 0x0510 ;rows-cols
	call stringprint
	mov ah,02h		;Sets Position for Second Digit
	mov bh,0
	mov dh,87
	mov dl,236
	int 10h
				
	mov al,[score]	;Calculates Second Digit
	mov ah,0
	mov bl,10
	div bl
	add al,'0'
	add ah,'0'
	mov dx,ax
				
	mov ah,0x09		;Prints Second Digit
	mov al,dh
	mov bx,0xf
	mov cx,1
	int 0x10
				
	mov ah,02h		;Sets Position for First Digit
	mov bh,0
	mov dh,87
	mov dl,235
	int 10h
				
	mov al,[score]	;Calculates First Digit
	mov ah,0
	mov bl,10
	div bl
	add al,'0'
	add ah,'0'
	mov dx,ax
				
	mov ah,0x09		;Prints First Digit
	mov al,dl
	mov bx,0xf
	mov cx,1
	int 0x10

	mov ah,02h		;Brings Back 
	mov bh,0
	mov dx,0
	int 10h
	popad
	pop es
	pop bp
	ret
;-----------------------------------------------------
;Draws Intro screen
;-----------------------------------------------------
Intro:
	push bp
	mov bp,sp
	push es
	pushad
	mov ax,0x9000
	mov es,ax
	mov di,0
	mov ax,3
	mov cx,64000
	rep stosb
	;Printing Playbutton containing Carrot
	push 150 	;cols
	push 55	 	;rows
	call Playbutton
	;Printing Playbutton containing Trophy
	push 150	;cols
	push 165	;rows
	call Playbutton
	push 54547
	call Trophy
	push 145 	;cols
	push 62	  	;rows
	call Carrot
	;Hollow box for names+roll
	push 35  	;height
	push 87 	;rows
	push 113	;cols
	push 80  	;width
	push 0x2b	;color
	call HollowBox
	;Hollow box for Instructions
	push 27  	;height
	push 132 	;rows
	push 65  	;cols
	push 190  	;width
	push 0x2b	;color
	call HollowBox
	;Hollow box for Title
	push 15  	;height
	push 36 	;rows
	push 90  	;cols
	push 132  	;width
	push 0x2b	;color
	call HollowBox
	;Box for title
	push 13 	;height
	mov bh,37 	;rows
	mov bl,91 	;cols
	push bx
	push 130  	;width
	push 0  	;color
	call Box
	;Box for instructions
	push 25		;height
	mov bh,133 	;rows
	mov bl,66 	;cols
	push bx
	push 188  	;width
	push 0  	;color
	call Box
	;Box for names+rollno
	push 33		;height
	mov bh,88	;rows
	mov bl,114 	;cols
	push bx
	push 78  	;width
	push 0  	;color
	call Box
	call printbuffer
	;Title Printing:
	push title1     ;address ofstring
	push 15			;length of String
	mov bx,0x0004	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push bx			;rows-cols
	push 0x050c ;rows-cols
	call stringprint
	;Name+rollnumber printing:
	push name1		;address ofstring
	push 7			;length of String
	push 0x0007		;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push 0x0c10 	;rows-cols
	call stringprint
	
	push name2 		;address ofstring
	push 5     		;length of String
	push 0x0007 	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push 0x0d11 	;rows-cols
	call stringprint
	
	;Instruction Printing:
	push inst1		;address ofstring
	push 22			;length of String
	push 0x0007		;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push 0x1209		;rows-cols
	call stringprint
	push instrh		;address ofstring
	push 13			;length of String
	push 0x0007		;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push 0x110E		;rows-cols
	call stringprint
	popad
	pop es
	pop bp
	ret
;-----------------------------------------------------
;Pause Screen
;-----------------------------------------------------
PauseScreen:	pusha
				push es
				
	mov ax,0x9000
	mov es,ax
	mov di,0
	mov ax,3
	mov cx,64000
	rep stosb
	;Printing Playbutton containing Trophy
	push 150	;cols
	push 120	;rows
	call Playbutton
	push 40147
	call Trophy
				;Hollow box for names+roll
	push 42  	;height
	push 54 	;rows
	push 79	;cols
	push 152  	;width
	push 0x2b	;color
	call HollowBox
	;Hollow box for Instructions
	push 15  	;height
	push 100 	;rows
	push 89  	;cols
	push 61  	;width
	push 0x2b	;color
	call HollowBox
	;Hollow box for Title
	push 15  	;height
	push 100 	;rows
	push 160  	;cols
	push 61  	;width
	push 0x2b	;color
	call HollowBox
	
	;Box for title
	push 40 	;height
	mov bh,55 	;rows
	mov bl,80 	;cols
	push bx
	push 150  	;width
	push 0  	;color
	call Box
	
	;Box for instructions
	push 13		;height
	mov bh,101 	;rows
	mov bl,90 	;cols
	push bx
	push 59  	;width
	push 0  	;color
	call Box
	
	;Box for instructions
	push 13		;height
	mov bh,101 	;rows
	mov bl,161 	;cols
	push bx
	push 59  	;width
	push 0  	;color
	call Box
	
	call printbuffer
	
	;Name+rollnumber printing:
	push continue1		;address ofstring
	push 17			;length of String
	push 0x0007		;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push 0x080B 	;rows-cols
	call stringprint
	
	push continue2  	;address ofstring
	push 9			;length of String
	push 0x0007		;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push 0x0A0f 	;rows-cols
	call stringprint
	
	push y 		;address ofstring
	push 6     		;length of String
	push 0x0007 	;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push 0x0D0C 	;rows-cols
	call stringprint
	
	push n		;address ofstring
	push 5			;length of String
	push 0x0007		;Color of string in lower byte 1st nibble->background 2nd nibble->foreground 
	push 0x0D15		;rows-cols
	call stringprint
	
				end11:
				pop es
				popa
				ret
;-----------------------------------------------------
;Draws Fox
;-----------------------------------------------------
Fox:	push bp
		mov bp,sp
		push es
		pushad
		mov ax,0x9000
		mov es,ax
		mov di,[bp+4]
		
		mov ax,0x2a
		stosb
		stosb
		add di,14
		stosb
		add di,303
		stosb
		mov ax,0x42
		stosb
		mov ax,0x2a
		stosb
		stosb
		stosb
		add di,7
		mov cx,5
		rep stosb
		add di,303
		stosb
		mov ax,0x5b
		stosb
		mov ax,0x42
		mov cx,2
		rep stosb
		mov ax,0x2a
		mov cx,2
		rep stosb
		add di,5
		mov ax,0x2a
		mov cx,2
		rep stosb
		mov ax,0x42
		mov cx,2
		rep stosb
		mov ax,0x2a
		mov cx,2
		rep stosb
		add di,302
		mov ax,0x2a
		mov cx,2
		rep stosb
		mov ax,0x5b
		mov cx,2
		rep stosb
		mov ax,0x42
		mov cx,2
		rep stosb
		mov ax,0x2a
		mov cx,7
		rep stosb
		mov ax,0x42
		mov cx,2
		rep stosb
		mov ax,0x5b
		stosb
		mov ax,0x2a
		mov cx,2
		rep stosb
		add di,302
		mov ax,0x2a
		mov cx,2
		rep stosb
		mov ax,0x5b
		mov cx,2
		rep stosb
		mov ax,0x2a
		mov cx,9
		rep stosb
		mov ax,0x42
		stosb
		mov ax,0x5b
		mov cx,2
		rep stosb
		mov ax,0x2a
		mov cx,2
		rep stosb
		add di,302
		mov ax,0x2a
		mov cx,2
		rep stosb
		mov ax,0x5b
		stosb
		mov ax,0x2a
		mov cx,12
		rep stosb
		mov ax,0x5b
		stosb
		mov ax,0x2a
		stosb
		add di,304
		mov ax,0x2a
		mov cx,16
		rep stosb
		add di,304
		mov ax,0x2a
		mov cx,15
		rep stosb
		add di,305
		mov ax,0x2a
		mov cx,3
		rep stosb
		mov ax,0x5b
		mov cx,2
		rep stosb
		mov ax,0x2a
		mov cx,7
		rep stosb
		mov ax,0x5b
		mov cx,2
		rep stosb
		mov ax,0x2a
		mov cx,2
		rep stosb
		add di,303
		mov ax,0x2a
		mov cx,2
		rep stosb
		mov ax,0x5b
		mov cx,5
		rep stosb
		mov ax,0x2a
		mov cx,4
		rep stosb
		mov ax,0x5b
		mov cx,5
		rep stosb
		mov ax,0x2a
		stosb
		add di,303
		mov ax,0x2a
		mov cx,2
		rep stosb
		mov ax,0x5b
		mov cx,6
		rep stosb
		mov ax,0x2a
		mov cx,2
		rep stosb
		mov ax,0x5b
		mov cx,6
		rep stosb
		mov ax,0x2a
		mov cx,2
		rep stosb
		add di,301
		mov ax,0x2a
		mov cx,3
		rep stosb
		mov ax,0x5b
		mov cx,3
		rep stosb
		mov ax,0
		stosb
		mov ax,0xf
		stosb
		mov ax,0x5b
		stosb
		mov ax,0x2a
		mov cx,2
		rep stosb
		mov ax,0x5b
		stosb
		mov ax,0x0
		stosb
		mov ax,0xf
		stosb
		mov ax,0x5b
		mov cx,3
		rep stosb
		mov ax,0x2a
		mov cx,3
		rep stosb
		inc di
		mov ax,0x5b
		stosb
		add di,299
		mov ax,0x2a
		mov cx,2
		rep stosb
		mov ax,0x5b
		mov cx,3
		rep stosb
		mov ax,0x0
		mov cx,2
		rep stosb
		mov ax,0x5b
		stosb
		mov ax,0x2a
		mov cx,2
		rep stosb
		mov ax,0x5b
		stosb
		mov ax,0x0
		mov cx,2
		rep stosb
		mov ax,0x5b
		mov cx,3
		rep stosb
		mov ax,0x2a
		mov cx,2
		rep stosb
		add di,2
		mov ax,0x5b
		mov cx,2
		rep stosb
		add di,300
		mov ax,0x5b
		mov cx,6
		rep stosb
		mov ax,0x2a
		mov cx,2
		rep stosb
		mov ax,0x5b
		mov cx,6
		rep stosb
		add di,2
		mov ax,0x5b
		mov cx,4
		rep stosb
		add di,301
		mov ax,0x5b
		mov cx,5
		rep stosb
		mov ax,0x0
		mov cx,2
		rep stosb
		mov ax,0x5b
		mov cx,5
		rep stosb
		inc di
		mov ax,0x2b
		mov cx,2
		rep stosb
		mov ax,0x5b
		mov cx,4
		rep stosb
		add di,303
		mov ax,0x5b
		mov cx,3
		rep stosb
		mov ax,0x0
		mov cx,2
		rep stosb
		mov ax,0x5b
		mov cx,4
		rep stosb
		mov ax,0x2b
		mov cx,6
		rep stosb
		mov ax,0x5b
		mov cx,2
		rep stosb
		add di,303
		mov ax,0x2a
		mov cx,9
		rep stosb
		mov ax,0x2b
		mov cx,7
		rep stosb
		mov ax,0x5b
		stosb
		add di,303
		mov ax,0x2a
		mov cx,9
		rep stosb
		mov ax,0x2b
		mov cx,8
		rep stosb
		add di,302
		mov ax,0x2a
		mov cx,5
		rep stosb
		mov ax,0x5b
		stosb
		mov ax,0x2a
		mov cx,4
		rep stosb
		mov ax,0x2b
		mov cx,7
		rep stosb
		add di,302
		mov ax,0x2a
		mov cx,5
		rep stosb
		mov ax,0x5b
		stosb
		stosb
		mov ax,0x2a
		mov cx,5
		rep stosb
		mov ax,0x2b
		mov cx,5
		rep stosb
		add di,303
		mov ax,0x2a
		mov cx,5
		rep stosb
		mov ax,0x5b
		stosb
		stosb
		stosb
		mov ax,0x2a
		mov cx,4
		rep stosb
		mov ax,0x2b
		mov cx,2
		rep stosb
		add di,307
		mov ax,0x2a
		mov cx,4
		rep stosb
		mov ax,0x5b
		stosb
		stosb
		stosb
		mov ax,0x2a
		mov cx,4
		rep stosb
		add di,308
		mov ax,0x2a
		mov cx,3
		rep stosb
		mov ax,0x6
		mov cx,2
		rep stosb
		mov ax,0x5b
		mov cx,3
		rep stosb
		mov ax,0x6
		mov cx,2
		rep stosb
		mov ax,0x2a
		mov cx,2
		rep stosb
		add di,309
		mov ax,0x2a
		stosb
		mov ax,0x6
		mov cx,3
		rep stosb
		mov ax,0x5b
		mov cx,3
		rep stosb
		mov ax,0x6
		mov cx,3
		rep stosb
		mov ax,0x2a
		stosb
		add di,310
		mov ax,0x6
		mov cx,3
		rep stosb
		add di,3
		mov ax,0x6
		mov cx,3
		rep stosb
		popad
		pop es
		pop bp
		ret 2
;-----------------------------------------------------
;Draws The Carrot
;-----------------------------------------------------
Carrot:		push bp
			mov bp,sp
			push es
			pushad
			mov ax,0x9000
			mov es,ax
			mov di,[bp+4]
			imul di,320		;Row
			add di,[bp+6]
			mov cx,3
			add di,11
			rep stosb
			add di,316
			stosb
			mov ax,0x2
			stosb
			stosb
			mov ax,0
			stosb
			stosb
			add di,312
			stosb
			stosb
			inc di
			stosb
			mov ax,0x2
			stosb
			mov ax,0
			stosb
			mov ax,0x2
			stosb
			mov ax,0
			stosb
			add di,311
			stosb
			mov ax,0x2a
			stosb
			stosb
			mov ax,0
			stosb
			mov ax,0x2
			stosb
			mov ax,0
			stosb
			mov ax,0x2
			stosb
			mov ax,0x2
			stosb
			mov ax,0
			stosb
			add di,310
			mov ax,0
			stosb
			mov ax,0x2a
			stosb
			mov ax,0
			stosb
			mov ax,0x2a
			stosb
			stosb
			mov ax,0
			stosb
			mov ax,0x2
			stosb
			mov ax,0
			stosb
			mov ax,0
			stosb
			add di,310
			mov ax,0
			stosb
			mov cx,3
			mov ax,0x2a
			rep stosb
			mov ax,0
			stosb
			mov ax,0x2a
			stosb
			mov ax,0x2a
			stosb
			mov ax,0
			stosb
			add di,311
			mov ax,0
			stosb
			mov cx,8
			mov ax,0x2a
			rep stosb
			mov ax,0
			stosb
			add di,309
			mov ax,0
			stosb
			mov cx,9
			mov ax,0x2a
			rep stosb
			mov ax,0
			stosb
			add di,309
			mov ax,0
			stosb
			mov cx,8
			mov ax,0x2a
			rep stosb
			mov ax,0
			stosb
			add di,309
			mov ax,0
			stosb
			mov cx,8
			mov ax,0x2a
			rep stosb
			mov ax,0
			stosb
			add di,310
			mov ax,0
			stosb
			mov cx,6
			mov ax,0x2a
			rep stosb
			mov ax,0
			stosb
			mov ax,0
			stosb
			add di,311
			mov ax,0
			stosb
			mov cx,5
			mov ax,0x2a
			rep stosb
			mov ax,0
			stosb
			mov ax,0
			stosb
			add di,313
			mov ax,0
			mov cx,5
			rep stosb
			popad
			pop es
			pop bp
			ret 4
;--------------------------------------------------
;Draws the Bee
;--------------------------------------------------			
Bee:		push bp
			mov bp,sp
			push es
			pushad
			mov ax,0x9000
			mov es,ax
			mov di,[bp+4]
			imul di,320		;Row
			add di,[bp+6]
			add di,1
			mov ax,0x1d
			mov cx,3
			rep stosb
			add di,3
			mov cx,3
			rep stosb
			add di,310
			mov cx,5
			rep stosb
			add di,1
			mov cx,5
			rep stosb
			add di,310
			mov cx,9
			rep stosb
			add di,312
			mov ax,0x2c
			stosb
			stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			add di,313
			mov cx,4
			rep stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			add di,311
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			add di,310
			mov cx,5
			mov ax,0x2c
			rep stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			mov ax,0
			stosb
			add di,309
			mov ax,0x2c
			stosb
			mov ax,0x2c
			stosb
			mov ax,0x40
			stosb
			mov ax,0x2c
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			add di,311
			mov cx,4
			mov ax,0x2c
			rep stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			popad
			pop es
			pop bp
			ret 4			
;-------------------------------------------------------
;Draws the rabbit of section 2
;-------------------------------------------------------
RabbitAnimation:
			
			push bp
			mov bp,sp
			push es
			pushad
			mov ax,0x9000
			mov es,ax
			mov di,[bp+4]
			mov cx,4
			mov ax,0
			rep stosb
			add di,314
			mov ax,0
			stosb
			stosb
			mov ax,0x4e
			mov cx,3
			rep stosb
			mov ax,0
			stosb
			add di,312
			mov ax,0
			stosb
			stosb
			mov ax,0x4e
			mov cx,2
			rep stosb
			mov ax,0x4f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			add di,312
			mov ax,0
			stosb
			mov ax,0x4e
			mov cx,2
			rep stosb
			mov ax,0x4f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			stosb
			add di,5
			mov cx,5
			rep stosb
			add di,302
			mov ax,0
			stosb
			mov ax,0x4e
			stosb
			mov ax,0x4f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			stosb
			add di,4
			mov cx,3
			rep stosb
			mov ax,0x4e
			mov cx,4
			rep stosb
			mov ax,0
			stosb
			add di,301
			mov ax,0
			stosb
			mov ax,0x4e
			stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			stosb
			add di,3
			mov cx,3
			rep stosb
			mov ax,0x4e
			mov cx,4
			rep stosb
			mov ax,0x4f
			stosb
			stosb
			mov ax,0
			stosb
			add di,300
			mov ax,0
			stosb
			stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			stosb
			add di,2
			mov cx,3
			rep stosb
			mov ax,0x4e
			mov cx,4
			rep stosb
			mov ax,0x4f
			mov cx,3
			rep stosb
			mov ax,0
			stosb
			stosb
			add di,299
			mov cx,9
			rep stosb
			mov ax,0x4e
			mov cx,4
			rep stosb
			mov ax,0x4f
			mov cx,4
			rep stosb
			mov ax,0
			stosb
			stosb
			add di,300
			mov ax,0
			stosb
			mov ax,0x4e
			mov cx,10
			rep stosb
			mov ax,0x4f
			mov cx,4
			rep stosb
			mov ax,0
			stosb
			stosb
			stosb
			add di,301
			stosb
			mov ax,0x4e
			mov cx,7
			rep stosb
			mov ax,0x4f
			mov cx,3
			rep stosb
			mov cx,5
			mov ax,0
			rep stosb
			add di,303
			stosb
			mov ax,0x4e
			mov cx,2
			rep stosb
			mov ax,0x69
			mov cx,2
			rep stosb
			mov ax,0x4e
			mov cx,3
			rep stosb
			mov ax,0x4f
			mov cx,1
			rep stosb
			mov ax,0
			mov cx,3
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			add di,306
			stosb
			mov ax,0x4e
			mov cx,7
			rep stosb
			mov ax,0x4f
			mov cx,6
			rep stosb
			mov ax,0
			stosb
			add di,304
			stosb
			mov ax,0x4e
			mov cx,7
			rep stosb
			mov ax,0x4f
			mov cx,8
			rep stosb
			mov ax,0
			stosb
			add di,303
			stosb
			mov ax,0x4e
			mov cx,4
			rep stosb
			mov ax,0x4f
			mov cx,8
			rep stosb
			mov ax,0x4e
			mov cx,3
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			add di,302
			stosb
			mov ax,0x4f
			mov cx,4
			rep stosb
			mov ax,0x6f
			stosb
			mov ax,0x4f
			mov cx,6
			rep stosb
			mov ax,0x4e
			mov cx,5
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			add di,302
			stosb
			stosb
			mov ax,0x6f
			stosb
			stosb
			mov ax,0x4f
			mov cx,6
			rep stosb
			mov ax,0x4e
			mov cx,7
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			add di,301
			stosb
			mov ax,0xf
			stosb
			mov ax,0
			mov cx,7
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0x4e
			mov cx,2
			rep stosb
			mov ax,0x4f
			mov cx,2
			rep stosb
			mov ax,0x4e
			mov cx,4
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			add di,300
			stosb
			stosb
			add di,4
			stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			mov ax,0x4e
			mov cx,2
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			mov ax,0x4f
			stosb
			stosb
			mov ax,0x4e
			mov cx,3
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			add di,306
			stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			mov ax,0x4e
			mov cx,2
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			mov ax,0x4e
			mov cx,4
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			add di,304
			stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			mov ax,0x4e
			mov cx,2
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			mov ax,0x4e
			mov cx,5
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			add di,303
			stosb
			mov ax,0x4e
			stosb
			mov ax,0
			stosb
			mov ax,0x4e
			mov cx,2
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			mov cx,4
			rep stosb
			mov ax,0x4e
			mov cx,5
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			add di,302
			mov cx,3
			rep stosb
			mov ax,0x4e
			mov cx,2
			rep stosb
			mov ax,0x4f
			stosb
			mov ax,0
			stosb
			mov cx,3
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			mov ax,0x4e
			mov cx,4
			rep stosb
			mov ax,0x4f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			add di,300
			stosb
			stosb
			mov cx,2
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			mov ax,0x4f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			mov ax,0x8f
			stosb
			mov ax,0x8c
			stosb
			mov cx,2
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			mov ax,0x4f
			stosb
			mov ax,0x4e
			mov cx,3
			rep stosb
			mov ax,0x4f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			add di,299
			stosb
			stosb
			mov cx,4
			mov ax,0x8d
			rep stosb
			mov cx,3
			mov ax,0
			rep stosb
			mov cx,4
			mov ax,0x8d
			rep stosb
			mov ax,0x8f
			stosb
			mov ax,0
			stosb
			mov ax,0x4e
			mov cx,3
			rep stosb
			mov ax,0x4f
			mov cx,2
			rep stosb
			mov ax,0
			mov cx,2
			rep stosb
			add di,297
			stosb
			mov cx,6
			mov ax,0x8d
			rep stosb
			mov cx,3
			mov ax,0x8f
			rep stosb
			mov cx,4
			mov ax,0x8d
			rep stosb
			mov ax,0x8f
			stosb
			mov ax,0
			stosb
			mov ax,0x4e
			mov cx,2
			rep stosb
			mov ax,0x4f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			mov cx,2
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			add di,295
			stosb
			mov cx,14
			mov ax,0x8d
			rep stosb
			mov ax,0
			stosb
			mov ax,0x4e
			mov cx,2
			rep stosb
			mov ax,0x4f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			mov cx,4
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			add di,293
			stosb
			mov cx,13
			mov ax,0x8d
			rep stosb
			mov ax,0x8f
			stosb
			mov ax,0
			stosb
			mov ax,0x4e
			stosb
			mov ax,0x4f
			mov cx,2
			rep stosb
			mov ax,0
			mov cx,2
			rep stosb
			mov cx,6
			mov ax,0x8d
			rep stosb
			mov ax,0
			stosb
			add di,280
			mov cx,11
			rep stosb
			mov cx,14
			mov ax,0x8d
			rep stosb
			mov ax,0x8f
			stosb
			mov cx,4
			mov ax,0
			rep stosb
			mov cx,7
			mov ax,0x8d
			rep stosb
			mov cx,2
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			add di,279
			stosb
			mov cx,3
			mov ax,0x8d
			rep stosb
			mov ax,0x2
			stosb
			mov cx,7
			mov ax,0x8d
			rep stosb
			mov ax,0
			stosb
			mov ax,0x8f
			stosb
			mov cx,12
			mov ax,0x8d
			rep stosb
			mov cx,5
			mov ax,0x8f
			rep stosb
			mov cx,6
			mov ax,0x8d
			rep stosb
			mov cx,3
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			add di,279
			stosb
			mov cx,10
			mov ax,0x8d
			rep stosb
			mov cx,2
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			mov ax,0x8f
			stosb
			mov cx,19
			mov ax,0x8d
			rep stosb
			mov cx,7
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			add di,278
			stosb
			mov cx,2
			mov ax,0x8d
			rep stosb
			mov ax,0x6f
			stosb
			mov cx,5
			mov ax,0x8d
			rep stosb
			mov cx,5
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			mov ax,0x8f
			stosb
			mov cx,13
			mov ax,0x8d
			rep stosb
			mov cx,2
			mov ax,0x8d
			rep stosb
			mov cx,10
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			add di,278
			mov ax,0
			stosb
			mov ax,0x6f
			stosb
			stosb
			mov cx,10
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			stosb
			mov cx,5
			mov ax,0x8f
			rep stosb
			mov cx,9
			mov ax,0x8d
			rep stosb
			mov cx,15
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			add di,276
			mov cx,12
			rep stosb
			mov ax,0x7
			stosb
			mov ax,0
			stosb
			mov cx,29
			mov ax,0x8f
			rep stosb
			mov ax,0x8d
			stosb
			mov ax,0
			stosb
			add di,286
			stosb
			mov ax,0x7
			stosb
			mov ax,0xef
			stosb
			mov ax,0
			stosb
			stosb
			mov ax,0x8d
			stosb
			stosb
			mov ax,0x8f
			mov cx,19
			rep stosb
			mov ax,0x8d
			mov cx,4
			rep stosb
			mov ax,0
			mov cx,4
			rep stosb
			add di,285
			stosb
			mov ax,0x8f
			stosb
			mov ax,0
			stosb
			mov ax,0xef
			mov cx,3
			rep stosb
			mov ax,0
			mov cx,4
			rep stosb
			mov ax,0x8f
			mov cx,12
			rep stosb
			mov ax,0x8e
			mov cx,4
			rep stosb
			mov ax,0
			mov cx,5
			rep stosb
			mov ax,0x8f
			mov cx,4
			rep stosb
			mov ax,0
			stosb
			add di,284
			stosb
			mov ax,0x8f
			stosb
			mov ax,0
			stosb
			mov ax,0xef
			stosb
			stosb
			mov ax,0
			stosb
			mov cx,4
			mov ax,0x8f
			rep stosb
			mov ax,0
			stosb
			mov cx,11
			mov ax,0x8d
			rep stosb
			mov ax,0
			mov cx,4
			rep stosb
			mov ax,0x7
			stosb
			stosb
			mov ax,0xef
			stosb
			stosb
			mov ax,0
			stosb
			mov ax,0x8d
			mov cx,3
			rep stosb
			mov ax,0x8f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			add di,283
			stosb
			mov ax,0x8f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			mov ax,0xef
			stosb
			mov ax,0
			stosb
			mov ax,0x8f
			stosb
			mov ax,0x8d
			stosb
			stosb
			mov ax,0x8f
			stosb
			stosb
			mov ax,0
			mov cx,11
			rep stosb
			mov ax,0
			stosb
			mov ax,0x7
			stosb
			mov ax,0xef
			mov cx,3
			rep stosb
			mov ax,0
			mov cx,3
			rep stosb
			add di,1
			mov ax,0
			mov cx,6
			rep stosb
			add di,283
			stosb
			mov ax,0x8d
			mov cx,2
			rep stosb
			mov ax,0x8f
			mov cx,2
			rep stosb
			mov ax,0
			mov cx,2
			rep stosb
			mov ax,0x8f
			stosb
			mov ax,0x8d
			mov cx,3
			rep stosb
			mov ax,0x8f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			mov ax,0xef
			mov cx,3
			rep stosb
			mov ax,0x7
			mov cx,2
			rep stosb
			mov ax,0xef
			mov cx,3
			rep stosb
			mov ax,0x7
			mov cx,2
			rep stosb
			mov ax,0
			mov cx,4
			rep stosb
			mov ax,0x8f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			add di,288
			stosb
			mov ax,0x8d
			mov cx,2
			rep stosb
			mov ax,0x8f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			add di,1
			stosb
			mov ax,0x8d
			mov cx,4
			rep stosb
			mov ax,0x8f
			mov cx,2
			rep stosb
			mov ax,0
			mov cx,10
			rep stosb
			add di,3
			stosb
			mov ax,0x8f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			add di,289
			stosb
			mov ax,0x8d
			mov cx,2
			rep stosb
			mov ax,0x8f
			stosb
			mov ax,0
			stosb
			add di,2
			stosb
			mov ax,0x8d
			mov cx,4
			rep stosb
			mov ax,0x8f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			add di,12
			stosb
			mov ax,0x8d
			stosb
			mov ax,0
			stosb
			add di,290
			stosb
			mov ax,0x8d
			mov cx,2
			rep stosb
			mov ax,0x8f
			stosb
			mov ax,0
			stosb
			add di,2
			stosb
			mov ax,0x8d
			mov cx,4
			rep stosb
			mov ax,0x8f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			add di,12
			stosb
			mov ax,0x8d
			stosb
			mov ax,0
			stosb
			add di,290
			stosb
			mov ax,0x8d
			mov cx,2
			rep stosb
			mov ax,0x8f
			stosb
			mov ax,0
			stosb
			add di,3
			stosb
			mov ax,0x8d
			mov cx,3
			rep stosb
			mov ax,0x8f
			mov cx,2
			rep stosb
			mov ax,0
			stosb
			add di,12
			stosb
			mov ax,0
			stosb
			stosb
			add di,290
			stosb
			mov ax,0x8d
			stosb
			mov ax,0x8f
			stosb
			mov ax,0
			stosb
			add di,5
			stosb
			mov ax,0x8d
			mov cx,3
			rep stosb
			mov ax,0x8f
			stosb
			mov ax,0
			stosb
			add di,305
			mov cx,3
			rep stosb
			add di,7
			mov cx,4
			rep stosb
			popad
			pop es
			pop bp
			ret 2
;------------------------------------------------
;Draws the Trophy
;------------------------------------------------			
Trophy:		push bp
			mov bp,sp
			pushad
			push es
			push di
			mov di,[bp+4]
			mov ax,0x9000
			mov es,ax
			mov cx,11
			mov ax,0
			rep stosb
			add di,309
			stosb
			mov cx,8
			mov ax,0x2c
			rep stosb
			mov ax,0x2b
			stosb
			mov ax,0
			stosb
			add di,306
			mov cx,4
			mov ax,0
			rep stosb
			mov cx,8
			mov ax,0x2c
			rep stosb
			mov ax,0x2b
			stosb
			mov cx,4
			mov ax,0
			rep stosb
			add di,303
			stosb
			add di,2
			stosb
			mov cx,8
			mov ax,0x2c
			rep stosb
			mov ax,0x2b
			stosb
			mov ax,0
			stosb
			add di,2
			stosb
			add di,303
			stosb
			add di,2
			stosb
			mov cx,8
			mov ax,0x2c
			rep stosb
			mov ax,0x2b
			stosb
			mov ax,0
			stosb
			add di,2
			stosb
			add di,303
			stosb
			stosb
			add di,1
			stosb
			mov cx,8
			mov ax,0x2c
			rep stosb
			mov ax,0x2b
			stosb
			mov ax,0
			stosb
			add di,1
			stosb
			stosb
			add di,304
			stosb
			stosb
			stosb
			mov cx,8
			mov ax,0x2c
			rep stosb
			mov ax,0x2b
			stosb
			mov ax,0
			stosb
			stosb
			stosb
			add di,307
			stosb
			mov cx,8
			mov ax,0x2c
			rep stosb
			mov ax,0x2b
			stosb
			mov ax,0
			stosb
			add di,309
			stosb
			stosb
			mov cx,6
			mov ax,0x2c
			rep stosb
			mov ax,0x2b
			stosb
			mov ax,0
			stosb
			stosb
			add di,310
			stosb
			stosb
			mov cx,4
			mov ax,0x2c
			rep stosb
			mov ax,0x2b
			stosb
			mov ax,0
			stosb
			stosb
			add di,312
			stosb
			stosb
			mov cx,2
			mov ax,0x2c
			rep stosb
			mov ax,0x2b
			stosb
			mov ax,0
			stosb
			stosb
			add di,315
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			add di,317
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			add di,317
			mov ax,0
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			add di,316
			mov ax,0
			stosb
			stosb
			mov ax,0x2c
			stosb
			mov ax,0
			stosb
			stosb
			add di,314
			stosb
			mov cx,4
			mov ax,0x2c
			rep stosb
			mov ax,0x2b
			stosb
			mov ax,0
			stosb
			add di,313
			mov cx,7
			rep stosb
			pop di
			pop es
			popad
			pop bp
			ret 2
;-------------------------------------------
;Draws the finishing line
;-------------------------------------------			
FinishingLine:	
			push bp
			mov bp,sp
			pushad
			push es
			push di
			mov di,15120
			mov ax,0x9000
			mov es,ax
			mov bx,0x0155
			shl bx,1
			l3:	shr bx,1
				mov ax,0
				mov dx,5
				jc  black
				mov ax,0xf
				black:
				mov cx,5
				rep stosb
				add di,315
				dec dx
				jnz black
				cmp bx,0
				jnz l3
			pop di
			pop es
			popad
			pop bp
			ret
;---------------------------------------------------
;Bunny of the Game
;---------------------------------------------------			
Bunny:		push bp
			mov bp,sp
			pushad
			push es
			push di
			mov ax,0x9000
			mov es,ax
			mov di,[bp+4]
			add di,2
			mov cx,3
			mov ax,0
			rep stosb
			add di,11
			mov cx,3
			mov ax,0
			rep stosb
			add di,302
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,3
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,9
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,3
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,300
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,2
			mov ax,0x3f
			rep stosb
			mov cx,2
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,7
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,2
			mov ax,0xf
			rep stosb
			mov cx,2
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,299
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,2
			mov ax,0x3f
			rep stosb
			mov cx,2
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,7
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,2
			mov ax,0xf
			rep stosb
			mov cx,2
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,299
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,3
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,7
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,3
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,300
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,2
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,7
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,2
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,301
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,2
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,7
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,2
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,301
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,2
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,7
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,2
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,302
			mov ax,0
			stosb
			mov ax,0xf
			stosb
			mov cx,2
			mov ax,0x3f
			rep stosb
			mov cx,9
			mov ax,0
			rep stosb
			mov cx,2
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,304
			mov cx,4
			mov ax,0
			rep stosb
			mov cx,7
			mov ax,0xf
			rep stosb
			mov cx,4
			mov ax,0
			rep stosb
			add di,305
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,13
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,304
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,15
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,302
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,17
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,301
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,17
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,301
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,2
			mov ax,0xf
			rep stosb
			mov cx,4
			mov ax,0
			rep stosb
			mov cx,5
			mov ax,0xf
			rep stosb
			mov cx,4
			mov ax,0
			rep stosb
			mov cx,2
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,301
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,3
			mov ax,0xf
			rep stosb
			mov cx,2
			mov ax,0
			rep stosb
			mov cx,7
			mov ax,0xf
			rep stosb
			mov cx,2
			mov ax,0
			rep stosb
			mov cx,3
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,298
			mov cx,4
			mov ax,0
			rep stosb
			mov cx,17
			mov ax,0xf
			rep stosb
			mov cx,4
			mov ax,0
			rep stosb			
			add di,294
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,3
			mov ax,0xc
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,4
			mov ax,0x3f
			rep stosb
			mov cx,3
			mov ax,0xf
			rep stosb
			mov cx,3
			mov ax,0
			rep stosb
			mov cx,3
			mov ax,0xf
			rep stosb
			mov cx,4
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,3
			mov ax,0xc
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb			
			add di,292
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,4
			mov ax,0xc
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,4
			mov ax,0x3f
			rep stosb
			mov cx,3
			mov ax,0xf
			rep stosb
			mov cx,3
			mov ax,0
			rep stosb
			mov cx,3
			mov ax,0xf
			rep stosb
			mov cx,4
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,4
			mov ax,0xc
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb			
			add di,291
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,4
			mov ax,0xc
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,4
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,2
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,2
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,1
			mov ax,0xf
			rep stosb
			mov cx,4
			mov ax,0x3f
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,4
			mov ax,0xc
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb			
			add di,291
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,5
			mov ax,0xc
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,5
			mov ax,0xf
			rep stosb
			mov cx,2
			mov ax,0
			rep stosb
			mov cx,1
			mov ax,0x3f
			rep stosb
			mov cx,2
			mov ax,0
			rep stosb
			mov cx,5
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			mov cx,5
			mov ax,0xc
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb			
			add di,292
			mov cx,2
			mov ax,0
			rep stosb
			mov cx,3
			mov ax,0xc
			rep stosb
			mov cx,3
			mov ax,0
			rep stosb
			mov cx,4
			mov ax,0xf
			rep stosb
			mov cx,3
			mov ax,0x3f
			rep stosb
			mov cx,4
			mov ax,0xf
			rep stosb
			mov cx,3
			mov ax,0
			rep stosb
			mov cx,3
			mov ax,0xc
			rep stosb
			mov cx,2
			mov ax,0
			rep stosb			
			add di,295
			mov cx,3
			mov ax,0
			rep stosb
			add di,3
			stosb
			mov cx,3
			mov ax,0xf
			rep stosb
			mov cx,3
			mov ax,0x3f
			rep stosb
			mov cx,3
			mov ax,0xf
			rep stosb
			mov cx,1
			mov ax,0
			rep stosb
			add di,3
			mov cx,3
			mov ax,0
			rep stosb		
			add di,304
			mov cx,9
			mov ax,0
			rep stosb		
			pop di
			pop es
			popad
			pop bp
			ret 2	
;-----------------------------------------------------------
;Draws all the bees in Section 2
;-----------------------------------------------------------
AllBees:	push 220
			push 55
			call Bee
			push 240
			push 55
			call Bee
			push 260
			push 55
			call Bee
			push 230
			push 65
			call Bee
			push 250
			push 65
			call Bee
			push 220
			push 75
			call Bee
			push 240
			push 75
			call Bee
			push 260
			push 75
			call Bee
			ret			
;--------------------------------------------------------------------
; Creates a Box
;--------------------------------------------------------------------	
Box:		push bp				;We take the bottom left corner,height,width and color of the box	
			mov bp, sp
			push es
			push ax
			push bx
			push cx
			push dx
			push di
			
			mov ax,0x9000  
			mov es,ax
			
			mov bx,[bp+8]		;Calculates DI
			mov al,bh
			mov di,ax
			imul di,320
			mov bh,0
			add di,bx
			
			mov ax,[bp+4]		;Loads Color in ax
			
			mov dx,[bp+10]		;Loads Height
			mov cx,[bp+6]		;Loads Width
			
			l4:	mov cx,[bp+6]		;Loads Width
			    rep stosb
				add di,320
				sub di,[bp+6]
				sub dx,1
				jnz l4
				
			end2:
			pop di
			pop dx
			pop cx
			pop bx
			pop ax
			pop es
			pop bp
			ret 8
;---------------------------------------------------------
;Creates a Hollow Box
;---------------------------------------------------------		
HollowBox:		push bp				;We take the bottom left corner,height,width and color of the box	
			mov bp, sp
			push es
			push ax
			push bx
			push cx
			push dx
			push di
			
			mov ax,0x9000  
			mov es,ax
			
			mov bx,[bp+10]		;Calculates DI
			mov di,bx
			imul di,320
			mov bx,[bp+8]		;Column
			add di,bx
			
			mov ax,[bp+4]		;Loads Color in ax
			
			mov dx,[bp+12]		;Loads Height
			sub dx,2
			mov cx,[bp+6]		;Loads Width
			
			rep stosb
			add di,320
			sub di,[bp+6]
			l5:	stosb
				add di,[bp+6]
				sub di,2
				stosb
				add di,320
				sub di,[bp+6]
				sub dx,1
				jnz l5
			
			mov cx,[bp+6]
			rep stosb
			
			end1:
			pop di
			pop dx
			pop cx
			pop bx
			pop ax
			pop es
			pop bp
			ret 10			
;-------------------------------------------------------
;Draws triangle of Bricks
;-------------------------------------------------------
Triangle:	push bp
			mov bp,sp
			pushad
			push es
			push di
			
			mov ax,0x9000
			mov es,ax
			
			mov bx,[bp+6]	;Starting Position
			mov al,bh
			mov di,ax
			imul di,320
			mov bh,0
			add di,bx
			mov ax,[bp+4] 	;color
			mov cx,4
			rep stosb
			add di,317
			mov cx,3
			rep stosb
			add di,318
			stosb
			
			end3:
			pop di
			pop es
			popad
			pop bp
			ret 4
;--------------------------------------------
;Draws the Base
;--------------------------------------------
Base:		push bp
			mov bp,sp
			push bx
			push ax
			push cx
			
			mov bx,[bp+4]
			mov ah,0
			mov al,bh
			push 9
			push ax
			mov al,bl
			push ax
			push 320
			push 0
			call HollowBox

			add bh,1
			add bl,1
			push 7
			push bx
			push 318
			push 0x43
			call Box
			
			pop cx
			pop ax
			pop bx
			pop bp
			ret 2
;----------------------------------------
;Prints the Score
;----------------------------------------
PrintScore:		push bp
				mov bp,sp
				pushad
				
				push es
				push di
		
				mov bx,107
				push 17
				push bx
				mov bx,273
				push bx
				push 43
				push 0
				call HollowBox	;Black Box of Score
				push 275
				push 109
				call Carrot		;Draws Carrot
				
				mov ah,02h		;Sets Position for Second Digit
				mov bh,0
				mov dh,90
				mov dl,254
				int 10h
				
				mov al,[score]	;Calculates Second Digit
				mov ah,0
				mov bl,10
				div bl
				add al,'0'
				add ah,'0'
				mov dx,ax
				
				mov ah,0x09		;Prints Second Digit
				mov al,dh
				mov bx,0xf
				mov cx,1
				int 0x10
				
				mov ah,02h		;Sets Position for First Digit
				mov bh,0
				mov dh,90
				mov dl,253
				int 10h
				
				mov al,[score]	;Calculates First Digit
				mov ah,0
				mov bl,10
				div bl
				add al,'0'
				add ah,'0'
				mov dx,ax
				
				mov ah,0x09		;Prints First Digit
				mov al,dl
				mov bx,0xf
				mov cx,1
				int 0x10

				mov ah,02h		;Brings Back 
				mov bh,0
				mov dx,0
				int 10h
				
				pop di
				pop es
				popad
				pop bp
				ret 
;-------------------------------------------------------
;Animation of First Two Sections
;-------------------------------------------------------
Animation:	
			push bp
			mov bp, sp
			push es
			pushad
			push ds
			push di
			push si
			
			mov ax,0x9000			;Memory Address For Display
			mov es,ax
			mov ds,ax				;For Source

			cld						;Clears Direction Flag
			mov bx,50				;Contains the number of rows to move
			mov si,15041			;Source index
			mov di,15040			;Destination index
			
l10:		mov cx,319				;For each element of the row
			mov dl,[es:di]			;Remembers the leftmost element
			rep movsb				;Moves left
			mov [es:di],dl			;Updates the rightmost element with dx
			add si,1				;Moves to the row below
			add di,1				;Moves to the row below
			dec bx
			jnz l10	
			
			std
			mov bx,47				;Contains the number of rows to move
			mov si,15038			;Source index
			mov di,15039			;Destination index
			
l18:		mov cx,319				;For each element of the row
			mov dl,[es:di]			;Remembers the rightmost element
			rep movsb				;Moves right
			mov [es:di],dl			;Updates the rightmost element with dx
			sub si,1				;Moves to the row below
			sub di,1				;Moves to the row below
			dec bx
			jnz l18
			cld
			
			pop si
			pop di
			pop ds
			popad
			pop es
			pop bp
			ret 
;---------------------------------------------------
;Generates Random Numbers from 0 till parameter
;---------------------------------------------------
Rand:		push bp
			mov bp,sp
			pushad
			
			rdtsc
			xor  dx, dx
			mov  cx, [bp+4]    
			div  cx       ; here dx contains the remainder of the division
			mov [random],dl
			
			popad
			pop bp
			ret 2
;---------------------------------------------------
;Moves the Bunny Up
;---------------------------------------------------		
JumpBunny:		pushad
				push es
				push di
				push si
				
				mov word[flagTime],0
				mov bx,320
				mov cx,47
				l12:	sub word[BunnyStart],bx
						cmp cx,45
						je CheckCarrot
						returnToBunny:
						call DrawGame
						loop l12	
				pop si
				pop di
				pop es
				popad
				ret
;-------------------------------------------------
;Checking whether the Bunny touched a Carrot
;-------------------------------------------------
CheckCarrot:
			mov ax,0x9000
			mov es,ax
			mov di,[BunnyStart]
			sub di,323
			mov si,26
			mov dl,0x3
			l15:	cmp byte[es:di],dl
					jne	break
					inc di
					dec si
					jnz l15
			jmp returnToBunny
			break:
			inc byte[score]
			dec byte[boolCarrot]
			jmp returnToBunny	
;----------------------------------------------------------
;Scrolls Down the Screen
;----------------------------------------------------------
ScrollDown:	pushad
		push si
		push di
		push es
		
		mov cx,47
		mov dx,320
		l13:	inc byte[Brick1Start+1]
				inc byte[Brick2Start+1]
				inc byte[Brick3Start+1]
				add [BunnyStart],dx
				call DrawGame
				loop l13
		
		;Starting Point
		mov cx,[Brick2Start]
		mov [Brick1Start],cx
		mov cx,[Brick3Start]
		mov [Brick2Start],cx
		mov ch,97
		mov cl,135
		mov [Brick3Start],cx
		
		push 2					;Determines if the 3rd Brick will be randomized to left or right
		call Rand
		cmp byte[random],0
		je minus
		
		push 31					;To the right
		call Rand
		mov cl,[random]
		add [Brick3Start],cl
		cmp byte[Brick3Start],175
		jle d1
		mov byte[Brick3Start],135
		jmp d1
		
		minus:					;To the left
		push 31
		call Rand
		mov cl,[random]
		sub [Brick3Start],cl
		cmp byte[Brick3Start],95
		jge d1
		mov byte[Brick3Start],135
		
		d1:
		;DirectionSwap
		mov ch,[DirectionB1]
		mov cl,[DirectionB2]
		mov [DirectionB1],cl
		mov cl,[DirectionB3]
		mov [DirectionB2],cl
		
		;Brick Color Swap
		mov si,[Brick3]
		mov di,[Brick2]
		mov [Brick2],si
		mov [Brick1],di
		mov ax,[BrickColor]
		mov [Brick3],ax
		
		cmp word[Brick3],0
		je DontMove
		cmp word[Brick3],3
		je DontMove
		mov byte[DirectionB3],1
		jmp x4
		
		DontMove:
		mov byte[DirectionB3],0
		
		x4:
		push 4
		call Rand
		mov al,[random]
		mov ah,0
		mov [BrickColor],ax
		
		x3:
		push 2
		call Rand
		mov al,[random]
		mov [boolCarrot],al
		call DrawGame
		
		cmp word[Brick1],3
		jne end10
		mov word[flagTime],1
		end10:
		pop es
		pop di
		pop si
		popad
		ret						
;---------------------------------------------
;Moves the brick Right one pixel
;---------------------------------------------	
MoveRight:		push bp
				mov bp,sp
				pushad
				
				mov ax,[bp+4]
				cmp ax,0
				je b1
				cmp ax,1
				je b2
				inc byte[Brick3Start]
				jmp end4
				
				b1:	inc byte[Brick1Start]
					jmp end4
					
				b2:	inc byte[Brick2Start]
					jmp end4
				
				end4:
				;inc word[BunnyStart]
				popad
				pop bp
				ret 2
;---------------------------------------------
;Moves the brick left one pixel
;---------------------------------------------				
MoveLeft:		push bp
				mov bp,sp
				pushad
				
				mov ax,[bp+4]				;Which Brick to Move
				cmp ax,0
				je bb1
				cmp ax,1
				je bb2
				dec byte[Brick3Start]
				jmp end5
				
				bb1:	dec byte[Brick1Start]
					jmp end5
					
				bb2:	dec byte[Brick2Start]
					jmp end5
	
				end5:
				popad
				pop bp
				ret 2
;---------------------------------------------------
;Moves The Bricks
;---------------------------------------------------
Move:	pushad
		push si
		push di
		push es
		push ds
		
		cmp word[Brick1],4		;Checks if the first brick is base.
		je bbb2
		
		mov al,[DirectionB1]	;Brick 1
		mov bl,[Brick1Start]
		cmp al,0
		je bbb2
		cmp al,1
		je r
		push 0
		call MoveLeft
		dec word[BunnyStart]
		cmp bl,95
		jne bbb2
		mov bh,1
		mov byte[DirectionB1],bh
		jmp bbb2
		
		r: push 0
			call MoveRight
			inc word[BunnyStart]
			cmp bl,175
			jne bbb2
			mov bh,2
			mov byte[DirectionB1],bh
			
		bbb2:					;Brick 2
		mov al,[DirectionB2]
		mov bl,[Brick2Start]
		cmp al,0
		je bbb3
		cmp al,1
		je r1
		push 1
		call MoveLeft
		cmp bl,95
		jne bbb3
		mov bh,1
		mov byte[DirectionB2],bh
		jmp bbb3
		
		r1: push 1				
			call MoveRight
			cmp bl,175
			jne bbb3
			mov bh,2
			mov byte[DirectionB2],bh
		
		bbb3:					;Brick 3
		mov al,[DirectionB3]
		mov bl,[Brick3Start]
		cmp al,0
		je end6
		cmp al,1
		je r2
		push 2
		call MoveLeft
		cmp bl,95
		jne end6
		mov bh,1
		mov byte[DirectionB3],bh
		jmp end6
		
		r2: push 2
			call MoveRight
			cmp bl,175
			jne end6
			mov bh,2
			mov byte[DirectionB3],bh
		
		end6:	
		pop ds
		pop es
		pop di
		pop si
		popad
		ret	
	
;-----------------------------------------------------
;To check if the rabbit is sitting on a brick or not
;-----------------------------------------------------
CheckRabbit:	pushad
		push si
		push di
		push es
		push ds
		
		mov ax,0x9000
		mov es,ax
		
		mov di,[BunnyStart]
		sub di,4
		add di,8000
		mov cx,29
		l17:	cmp byte[es:di],0x3
				jne end7
				add di,1
				loop l17
				mov byte[gameEnd],0
		end7:
		pop ds
		pop es
		pop di
		pop si
		popad
		ret
;----------------------------------------------
;Draws Everything in Third Section
;----------------------------------------------			
DrawGame:
		cmp byte[choice],0
		je end12
		cli
		call Animation
		call SaveSection1
		call ClrSection3
		push word[BunnyStart]
		call Bunny
		cmp byte[boolCarrot],1
		jne skip1
		push 152  ;Cols
		push 154	;Rows
		call Carrot
		
		skip1:
		push word[Brick1Start]
		push word[Brick1]
		call DrawBrick
		
		push word[Brick2Start]
		push word[Brick2]
		call DrawBrick
		
		push word[Brick3Start]
		push word[Brick3]
		call DrawBrick
		
		call PrintScore
		call ClrSection1
		call printbuffer
		sti
		end12:
		ret			
;-------------------------------------------
;Draws Brick According to Color
;-------------------------------------------			
DrawBrick:	push bp
		mov bp,sp
		pushad
		push si
		
		mov ax,[bp+4]		;Which Color to Draw
		mov bx,[bp+6]		;Starting Point
		
		cmp ax,0
		je green
		cmp ax,1
		je orange
		cmp ax,3
		je blue
		cmp ax,4
		je bb
		mov si,0x6d
		jmp x
		
		bb:
		mov dh,byte[Brick1Start+1]
		mov dl,0
		push dx
		call Base
		jmp end8
		
		green:
		mov si,0x2
		jmp x
		
		orange:
		mov si,0x2a
		jmp x
		
		blue:
		mov si,0x37
		jmp x

		x:
			mov al,bh
			push 9
			push ax
			mov al,bl
			push ax
			push 50
			push 0
			call HollowBox

			add bh,1
			add bl,1
			push 7
			push bx
			push 48
			push 0x43
			call Box
			
			mov cx,12
			l9:
			push bx
			push si
			call Triangle
			add bl,4
			loop l9
			
		end8:
		pop si
		popad
		pop bp
		ret	4
;-----------------------------------------------------
;Main Game
;-----------------------------------------------------				
Game:	pushad
		push si
		push di
		push es
		push ds
		
		l11:	cmp byte[gameEnd],0
				je terminateGame
				mov cl,[choice]
				cmp cl,0
				je l11
				cmp cl,1			;Up Key
				jne skip
				call JumpBunny
				call CheckRabbit
				cmp byte[gameEnd],0
				je terminateGame
				call ScrollDown
				mov byte[choice],2
				skip:
				call Move
				call DrawGame
				jmp l11
		
		terminateGame:
		call EndScreen
		pop ds
		pop es
		pop di
		pop si
		popad
		ret
;----------------------------------------------------------
;Keyboard Hooking
;----------------------------------------------------------				
kbisr:		push ax
			in al, 0x60
			
			cmp al,1						;Escape Key Check
			jne nextcmp					
			mov byte[choice],0
			call PauseScreen
			jmp nomatch						

nextcmp:	cmp al, 0x48					;Up Key Check
			jne nextcmp2						
			mov byte[choice],1
			jmp nomatch
			
nextcmp2:	cmp byte[choice],0
			jne nomatch
			cmp al,0x15						;For Y
			je updateChoice
			cmp al,0x31						;For N
			jne nomatch
			mov byte[gameEnd],0
			jmp nomatch

updateChoice:	mov byte[choice],2
				call Sections

nomatch:	mov al, 0x20					;No Match Was Found
			out 0x20, al					
			 
			pop ax
			iret
;---------------------------------------------------------
;Timer
;---------------------------------------------------------
Timer:	
		cmp word[flagTime],1
		jne skip5
		
		inc word [tickcount]   ;increment tick count
		cmp word [tickcount],300
		jl end9
		mov byte[gameEnd],0
		jmp end9
		
		skip5:
		mov	word [tickcount],0
		mov word[flagTime],0
		
		end9:
		push ds
		push bx
		push cs
		pop ds ; initialize ds to data segment
		mov bx, [currenttask] ; read index of current in bx
		shl bx,5 ; multiply by 32 for pcb start
		mov [pcb+bx+0], ax ; save ax in current pcb
		mov [pcb+bx+4], cx ; save cx in current pcb
		mov [pcb+bx+6], dx ; save dx in current pcb
		mov [pcb+bx+8], si ; save si in current pcb
		mov [pcb+bx+10], di ; save di in current pcb
		mov [pcb+bx+12], bp ; save bp in current pcb
		mov [pcb+bx+24], es ; save es in current pcb
		pop ax ; read original bx from stack
		mov [pcb+bx+2], ax ; save bx in current pcb
		pop ax ; read original ds from stack
		mov [pcb+bx+20], ax ; save ds in current pcb
		pop ax ; read original ip from stack
		mov [pcb+bx+16], ax ; save ip in current pcb
		pop ax ; read original cs from stack
		mov [pcb+bx+18], ax ; save cs in current pcb
		pop ax ; read original flags from stack
		mov [pcb+bx+26], ax ; save flags in current pcb
		mov [pcb+bx+22], ss ; save ss in current pcb
		mov [pcb+bx+14], sp ; save sp in current pcb
		mov bx, [pcb+bx+28] ; read next pcb of this pcb
		mov [currenttask], bx ; update current to new pcb
		mov cl, 5
		shl bx, cl ; multiply by 32 for pcb start
		mov cx, [pcb+bx+4] ; read cx of new process
		mov dx, [pcb+bx+6] ; read dx of new process
		mov si, [pcb+bx+8] ; read si of new process
		mov di, [pcb+bx+10] ; read di of new process
		mov bp, [pcb+bx+12] ; read bp of new process
		mov es, [pcb+bx+24] ; read es of new process
		mov ss, [pcb+bx+22] ; read ss of new process
		mov sp, [pcb+bx+14] ; read sp of new process
		push word [pcb+bx+26] ; push flags of new process
		push word [pcb+bx+18] ; push cs of new process
		push word [pcb+bx+16] ; push ip of new process
		push word [pcb+bx+20] ; push ds of new process
		mov al, 0x20
		out 0x20, al ; send EOI to PIC
		mov ax, [pcb+bx+0] ; read ax of new process
		mov bx, [pcb+bx+2] ; read bx of new process
		pop ds ; read ds of new process
		iret ; return to new process
			
;----------------------------------------------------------
;Buffer For Smooth Animation
;----------------------------------------------------------			
printbuffer:
			push es
			push di
			push ds
			push si
			push cx
			push ax
			push dx
			mov cx,0x9000		;Address of New Buffer Screen
			mov ds, cx
			xor si,si
			mov cx, 0xa000		;Address Of Old Screen
			mov es, cx
			xor di, di
			mov cx, 32000
			rep movsw
			pop dx
			pop ax
			pop cx
			pop si
			pop ds
			pop di
			pop es
			ret	
;---------------------------------------------------
;Moosic
;---------------------------------------------------
Music:		
	mov si, 0		
	next_note:
		cmp byte[choice],0
		je skip6
		
		mov dx, 388h
		mov al, [si + music_data + 0]
		out dx, al
		
		mov dx, 389h
		mov al, [si + music_data + 1]
		out dx, al
		
		mov bx, [si + music_data + 2]
		add si, 4

	repeatDelay:	
		mov cx, 50 ; <- change this value according to the speed
		              ;    of your computer / emulator
	delay:
		
		loop delay
		
		dec bx
		jg repeatDelay
		
		cmp si, [music_length]
		jb next_note
		mov si,0
		jmp next_note
		;For Pause Screen
		skip6:
		mov dx, 388h
		mov al, [music_data + 0]
		out dx, al
		
		mov dx, 389h
		mov al, [music_data + 0]
		out dx, al
		jmp next_note
;--------------------------------------------------------------------
; Main
;--------------------------------------------------------------------			
start:
mov ax,0x0013	;For Graphics Mode
int 0x10
;Multitasking
mov word[pcb+16],main
mov word[pcb+18],cs
mov word[pcb+26],0x0200
mov word[pcb+28],1
			
mov word[pcb+12],bp
mov word[pcb+14],sp
mov word[pcb+20],ds
mov word[pcb+22],ss
mov word[pcb+24],es
			
mov word[pcb+32+16],Music
mov word[pcb+32+18],cs
mov word[pcb+32+26],0x0200
mov word[pcb+32+28],0
			
mov word[pcb+32+12],bp
mov word[pcb+32+14],sp
mov word[pcb+32+20],ds
mov word[pcb+32+22],0x4000
mov word[pcb+32+24],es
mov word[currenttask],0

mov ax, 100		;For adjusting frequency
out 0x40, al
mov al, ah
out 0x40,al
			
call Intro
mov ah,0
int 0x16

;Keyboard Hooking
xor ax, ax
mov es, ax					
mov ax, [es:9*4]
mov [oldisr], ax
mov ax, [es:9*4+2]
mov [oldisr+2], ax	
cli
mov word [es:9*4], kbisr		
mov [es:9*4+2], cs
sti

;Timer Hooking
xor ax,ax
mov es,ax
mov ax,[es:8*4]
mov [Tisr],ax
mov ax, [es:8*4+2]
mov [Tisr+2], ax	
cli
mov word [es:8*4], Timer		
mov [es:8*4+2], cs
sti
main:
;The Game
call Sections
call DrawGame
call Game

;Unhooking Timer
mov ax, [Tisr]
mov bx,[Tisr+2]
cli												
mov [es:8*4], ax								
mov [es:8*4+2], bx								
sti

;Unhooking Keyboard
mov ax, [oldisr]
mov bx,[oldisr+2]
cli												
mov [es:9*4], ax								
mov [es:9*4+2], bx								
sti

mov ah,0
int 0x16

call clrscr

mov ax, 55000		;For adjusting frequency
out 0x40, al
mov al, ah
out 0x40,al

mov ax,0x0003	
int 0x10

;Termination
mov ax,0x4c00
int 0x21
;-----------------------------------------------------------------
;Global Variables
;-----------------------------------------------------------------
score: db 0
BaseStart:	dw 0xBF00
Brick1:	dw 4				;Lowest Brick	
Brick2:	dw 0				;Middle Brick
Brick3: dw 1				;Top Brick
Brick1Start:	db 0,191 	 ;First COl and then Row
Brick2Start:	db 135,144 	 ;First COl and then Row
Brick3Start:	db 135,97 	 ;First COl and then Row
BunnyStart:	dw	53588		;Start Position of Bunny
boolCarrot:	db 1			;Check whether to draw the bunny of not
gameEnd:	db 1			;Ends the game if this is 0
BrickColor: dw 3			;Color of the new brick added to the top
DirectionB1: db 1			;Direction of Lowest Brick
DirectionB2: db 0			;Direction of Middle Brick
DirectionB3: db 2			;Direction of Top Brick
choice:	db 2				;Stores keyboard input, 0 for Esc, 1 For Up, 2 For Continuation
random: db 0				;Stores Random Number
oldisr: dd 0				;To store old keyboard ISR
Tisr: dd 0					;To store old timer ISR
tickcount: dw 0				;For Blue Brick
flagTime: dw 0				;Increments Tick Count, this becomes 1 when brick1 is blue
title1:db "JUMP BUNNY JUMP"
name1:db "Shaheer"
name2:db "Ahmed"
roll2:db "22L-6638"
roll1:db "22L-6743"
instrh: db "Instructions!"
inst1: db "1:Press Up key to Jump"
sc: db "Score"
GameOver: db "GameOver"
continue1: db "Would You Like To"
continue2: db "Continue?"
y: db "Y. Yes"
n: db "N. No"
arrForSection: times 7520 dw 0	;FOr saving Section1
pcb: times 32*16 dw 0          ;ax,bx,cx,dx,di,si,bp,sp,ss,ds,es,ip,cs,flags
currenttask:dw 0
music_length dw 20836
music_data incbin "music.imf"
; 0 for Green, 1 For Orange, 2 For Purple, 3 For Blue,4 For Base
	.module keyboard.c
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\keyboard.c
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\keyboard.c
L2:
	.blkb 1
	.area idata
	.byte 15
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\keyboard.c
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\keyboard.c
	.dbfunc e keyboard_control _keyboard_control fV
	.area efunc_lit(rom, con, rel)
L81:
	.eaddr `L17
	.eaddr `L3
	.eaddr `L13
	.eaddr `L3
	.eaddr `L3
	.eaddr `L3
	.eaddr `L21
	.eaddr `L30
	.eaddr `L39
	.eaddr `L48
	.eaddr `L57
	.eaddr `L62
	.eaddr `L67
	.eaddr `L70
	.eaddr `L73
	.eaddr `L3
	.eaddr `L3
	.eaddr `L10
	.eaddr `L3
	.eaddr `L11
	.area text(rom, con, rel)
	.dbsym s change L2 c
	.even
_keyboard_control::
	xcall push_xgset300C
	.dbline -1
	.dbline 73
; /***
; Author : Srijit Dutt
; Date Sun 07 Nov 2010 02:42:38 PM IST 
; 
; keyboard.c : File contains various advanced motion functions for the hexapod
; Please include keyboard.h file to call function from this file
; 
; The various functions are : 
; keyboard_control
; */
; 
; /*********************************************************************************
; 
;    Copyright (c) 2010, ERTS Lab IIT Bombay erts@cse.iitb.ac.in               -*- c -*-
;    All rights reserved.
; 
;    Redistribution and use in source and binary forms, with or without
;    modification, are permitted provided that the following conditions are met:
; 
;    * Redistributions of source code must retain the above copyright
;      notice, this list of conditions and the following disclaimer.
; 
;    * Redistributions in binary form must reproduce the above copyright
;      notice, this list of conditions and the following disclaimer in
;      the documentation and/or other materials provided with the
;      distribution.
; 
;    * Neither the name of the copyright holders nor the names of
;      contributors may be used to endorse or promote products derived
;      from this software without specific prior written permission.
; 
;    * Source code can be used for academic purpose. 
; 	 For commercial use permission form the author needs to be taken.
; 
;   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
;   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;   POSSIBILITY OF SUCH DAMAGE. 
; 
;   Software released under Creative Commence cc by-nc-sa licence.
;   For legal information refer to: 
;   http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
; 
; ********************************************************************************/
; 
; 
; 
; 
; #include "hexapod_macro.h"
; #include "hexapod.h"
; #include "gait.h"
; #include "hexapod_motions.h"
; #include "hexapod_basic.h"
; 
; 
; extern unsigned char data;//!< The keyborad command given by user
; extern unsigned char mode;
; extern unsigned int legNo;
; extern unsigned int dir;
; extern double movementScaling;
; 
; /**
; Controls hexapod through keyboard using ZigBee communication
; */
; void keyboard_control(void) 
; {	
	.dbline 76
; 	static char change = 15;
; 	
; 	switch(data) 
	lds R20,_data
	clr R21
	cpi R20,108
	ldi R30,0
	cpc R21,R30
	brne X37
	xjmp L9
X37:
X0:
	cpi R20,109
	ldi R30,0
	cpc R21,R30
	brne X38
	xjmp L7
X38:
X1:
	ldi R24,109
	ldi R25,0
	cp R24,R20
	cpc R25,R21
	brlt L79
X2:
L78:
	cpi R20,43
	ldi R30,0
	cpc R21,R30
	brge X39
	xjmp L3
X39:
X3:
	ldi R24,62
	ldi R25,0
	cp R24,R20
	cpc R25,R21
	brlt L80
X4:
	ldi R16,3
	ldi R17,0
	movw R18,R20
	xcall empy16s
	movw R30,R16
	ldi R24,<L81-129
	ldi R25,>L81-129
	add R30,R24
	adc R31,R25
	elpm R2,Z+
	elpm R3,Z+
	elpm R0,Z
	out 0x3C,R0
	movw R30,R2
	eijmp
X5:
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\keyboard.c
L80:
	cpi R20,98
	ldi R30,0
	cpc R21,R30
	brne X40
	xjmp L76
X40:
X6:
	cpi R20,100
	ldi R30,0
	cpc R21,R30
	breq L12
X7:
	xjmp L3
L79:
	cpi R20,115
	ldi R30,0
	cpc R21,R30
	breq L6
X8:
	cpi R20,116
	ldi R30,0
	cpc R21,R30
	breq L8
X9:
	cpi R20,115
	ldi R30,0
	cpc R21,R30
	brge X41
	xjmp L3
X41:
X10:
L83:
	cpi R20,122
	ldi R30,0
	cpc R21,R30
	brne X42
	xjmp L77
X42:
X11:
	xjmp L3
L6:
	.dbline 79
; 	{
; 	   case 's': //mode to reset the hexapod
; 	         servo_calibration();
	xcall _servo_calibration
	.dbline 80
; 			 break;	
	xjmp L4
L7:
	.dbline 82
; 	   case 'm': //mode to move the hexapod
; 	         mode = 'm';
	ldi R24,109
	sts _mode,R24
	.dbline 83
; 			 break;
	xjmp L4
L8:
	.dbline 85
; 	   case 't': //mode to turn the hexapod
; 	   		mode = 't';
	ldi R24,116
	sts _mode,R24
	.dbline 86
; 			break;
	xjmp L4
L9:
	.dbline 88
; 	   case 'l':
; 	   		mode = 'l';
	ldi R24,108
	sts _mode,R24
	.dbline 89
; 			break;
	xjmp L4
L10:
	.dbline 91
; 	   case '<':
; 	   		dir = CLOCK_WISE;
	ldi R24,1
	ldi R25,0
	sts _dir+1,R25
	sts _dir,R24
	.dbline 92
; 			break;
	xjmp L4
L11:
	.dbline 94
; 	   case '>':
; 	   		dir = ANTI_CLOCK_WISE;
	clr R2
	clr R3
	sts _dir+1,R3
	sts _dir,R2
	.dbline 95
; 			break;
	xjmp L4
L12:
	.dbline 97
; 	   case 'd':
; 	   		mode = 'd';
	ldi R24,100
	sts _mode,R24
	.dbline 98
; 			break;
	xjmp L4
L13:
	.dbline 100
; 	   case '-': // case num-2
; 	   		movementScaling -= 0.1;
	lds R4,_movementScaling+2
	lds R5,_movementScaling+2+1
	lds R2,_movementScaling
	lds R3,_movementScaling+1
	ldi R16,<L14
	ldi R17,>L14
	xcall elpm32
	st -y,R19
	st -y,R18
	st -y,R17
	st -y,R16
	movw R16,R2
	movw R18,R4
	xcall fpsub2
	sts _movementScaling+1,R17
	sts _movementScaling,R16
	sts _movementScaling+2+1,R19
	sts _movementScaling+2,R18
	.dbline 101
; 			if (movementScaling < 0.1) movementScaling = 0.1;
	movw R2,R16
	movw R4,R18
	ldi R16,<L14
	ldi R17,>L14
	xcall elpm32
	st -y,R19
	st -y,R18
	st -y,R17
	st -y,R16
	movw R16,R2
	movw R18,R4
	xcall fpcmp2
	brlt X43
	xjmp L4
X43:
X12:
	.dbline 101
	ldi R16,<L14
	ldi R17,>L14
	xcall elpm32
	sts _movementScaling+1,R17
	sts _movementScaling,R16
	sts _movementScaling+2+1,R19
	sts _movementScaling+2,R18
	.dbline 102
; 			break;
	xjmp L4
L17:
	.dbline 104
; 	   case '+': // case num-8 
; 	   		movementScaling += 0.1;
	lds R4,_movementScaling+2
	lds R5,_movementScaling+2+1
	lds R2,_movementScaling
	lds R3,_movementScaling+1
	ldi R16,<L14
	ldi R17,>L14
	xcall elpm32
	st -y,R19
	st -y,R18
	st -y,R17
	st -y,R16
	movw R16,R2
	movw R18,R4
	xcall fpadd2
	sts _movementScaling+1,R17
	sts _movementScaling,R16
	sts _movementScaling+2+1,R19
	sts _movementScaling+2,R18
	.dbline 105
; 			if (movementScaling > 1.0) movementScaling = 1.0;
	ldi R24,<_movementScaling
	ldi R25,>_movementScaling
	ldi R16,<L20
	ldi R17,>L20
	xcall elpm32
	st -y,R25
	st -y,R24
	xcall fpcmp1
	brlt X44
	xjmp L4
X44:
X13:
	.dbline 105
	ldi R16,<L20
	ldi R17,>L20
	xcall elpm32
	sts _movementScaling+1,R17
	sts _movementScaling,R16
	sts _movementScaling+2+1,R19
	sts _movementScaling+2,R18
	.dbline 106
; 			break;
	xjmp L4
L21:
	.dbline 108
; 	   case '1': 
; 	   		if (mode == 'l') legNo = 1;
	lds R24,_mode
	cpi R24,108
	brne L22
X14:
	.dbline 108
	ldi R24,1
	ldi R25,0
	sts _legNo+1,R25
	sts _legNo,R24
L22:
	.dbline 109
; 			if (mode == 'm') mode = 1;
	lds R24,_mode
	cpi R24,109
	brne L24
X15:
	.dbline 109
	ldi R24,1
	sts _mode,R24
L24:
	.dbline 110
; 			if (mode == 't') mode = 11;
	lds R24,_mode
	cpi R24,116
	brne L26
X16:
	.dbline 110
	ldi R24,11
	sts _mode,R24
L26:
	.dbline 111
; 			if (mode == 'd') mode = 21;
	lds R24,_mode
	cpi R24,100
	breq X45
	xjmp L4
X45:
X17:
	.dbline 111
	ldi R24,21
	sts _mode,R24
	.dbline 112
; 			break;
	xjmp L4
L30:
	.dbline 114
; 	   case '2':
; 	   		 if (mode == 'l') legNo = 2;
	lds R24,_mode
	cpi R24,108
	brne L31
X18:
	.dbline 114
	ldi R24,2
	ldi R25,0
	sts _legNo+1,R25
	sts _legNo,R24
L31:
	.dbline 115
; 			 if (mode == 'm') mode = 2;
	lds R24,_mode
	cpi R24,109
	brne L33
X19:
	.dbline 115
	ldi R24,2
	sts _mode,R24
L33:
	.dbline 116
; 			 if (mode == 't') mode = 12;
	lds R24,_mode
	cpi R24,116
	brne L35
X20:
	.dbline 116
	ldi R24,12
	sts _mode,R24
L35:
	.dbline 117
; 			 if (mode == 'd') mode = 22; 
	lds R24,_mode
	cpi R24,100
	breq X46
	xjmp L4
X46:
X21:
	.dbline 117
	ldi R24,22
	sts _mode,R24
	.dbline 118
; 			 break;
	xjmp L4
L39:
	.dbline 120
; 	   case '3':
; 	   		if (mode == 'l') legNo = 3; 
	lds R24,_mode
	cpi R24,108
	brne L40
X22:
	.dbline 120
	ldi R24,3
	ldi R25,0
	sts _legNo+1,R25
	sts _legNo,R24
L40:
	.dbline 121
; 			if (mode == 'm') mode = 3;
	lds R24,_mode
	cpi R24,109
	brne L42
X23:
	.dbline 121
	ldi R24,3
	sts _mode,R24
L42:
	.dbline 122
; 			if (mode == 't') mode = 13;
	lds R24,_mode
	cpi R24,116
	brne L44
X24:
	.dbline 122
	ldi R24,13
	sts _mode,R24
L44:
	.dbline 123
; 			if (mode == 'd') mode = 23;
	lds R24,_mode
	cpi R24,100
	breq X47
	xjmp L4
X47:
X25:
	.dbline 123
	ldi R24,23
	sts _mode,R24
	.dbline 124
; 			break;
	xjmp L4
L48:
	.dbline 126
; 	   case '4':
; 	   		if (mode == 'l') legNo = 4;
	lds R24,_mode
	cpi R24,108
	brne L49
X26:
	.dbline 126
	ldi R24,4
	ldi R25,0
	sts _legNo+1,R25
	sts _legNo,R24
L49:
	.dbline 127
; 			if (mode == 'm') mode = 4;
	lds R24,_mode
	cpi R24,109
	brne L51
X27:
	.dbline 127
	ldi R24,4
	sts _mode,R24
L51:
	.dbline 128
; 			if (mode == 't') mode = 14;
	lds R24,_mode
	cpi R24,116
	brne L53
X28:
	.dbline 128
	ldi R24,14
	sts _mode,R24
L53:
	.dbline 129
; 			if (mode == 'd') mode = 24;
	lds R24,_mode
	cpi R24,100
	breq X48
	xjmp L4
X48:
X29:
	.dbline 129
	ldi R24,24
	sts _mode,R24
	.dbline 130
; 			break;
	xjmp L4
L57:
	.dbline 132
; 	   case '5':
; 	   		if (mode == 'l') legNo = 5;
	lds R24,_mode
	cpi R24,108
	brne L58
X30:
	.dbline 132
	ldi R24,5
	ldi R25,0
	sts _legNo+1,R25
	sts _legNo,R24
L58:
	.dbline 133
; 			if (mode == 'm') mode = 5; 
	lds R24,_mode
	cpi R24,109
	brne L4
X31:
	.dbline 133
	ldi R24,5
	sts _mode,R24
	.dbline 134
; 			break;
	xjmp L4
L62:
	.dbline 136
; 	   case '6':
; 	   		if (mode == 'l') legNo = 6;
	lds R24,_mode
	cpi R24,108
	brne L63
X32:
	.dbline 136
	ldi R24,6
	ldi R25,0
	sts _legNo+1,R25
	sts _legNo,R24
L63:
	.dbline 137
; 			if (mode == 'm') mode = 6;
	lds R24,_mode
	cpi R24,109
	brne L4
X33:
	.dbline 137
	ldi R24,6
	sts _mode,R24
	.dbline 138
; 			break;
	xjmp L4
L67:
	.dbline 140
; 	   case '7':
; 	   		if (mode == 'm') mode = 7;
	lds R24,_mode
	cpi R24,109
	brne L4
X34:
	.dbline 140
	ldi R24,7
	sts _mode,R24
	.dbline 141
; 			break;
	xjmp L4
L70:
	.dbline 143
; 	   case '8':
; 	   		if (mode == 'm') mode = 8;
	lds R24,_mode
	cpi R24,109
	brne L4
X35:
	.dbline 143
	ldi R24,8
	sts _mode,R24
	.dbline 144
; 			break;
	xjmp L4
L73:
	.dbline 146
; 	   case '9':
; 	   		if (mode == 'm') mode = 9;
	lds R24,_mode
	cpi R24,109
	brne L4
X36:
	.dbline 146
	ldi R24,9
	sts _mode,R24
	.dbline 147
; 			break;
	xjmp L4
L76:
	.dbline 149
; 	   case 'b':
; 	   		buzzer_on_off();
	xcall _buzzer_on_off
	.dbline 150
; 			break;
	xjmp L4
L77:
L3:
	.dbline 153
; 	   case 'z':	
; 	   default :
; 			mode = 'z';
	ldi R24,122
	sts _mode,R24
	.dbline 154
; 			break;
L4:
	.dbline 157
; 	}	           
; 	 	
; 	data = '';
	clr R2
	sts _data,R2
	.dbline -2
L1:
	.dbline 0 ; func end
	xjmp pop_xgset300C
	.dbend
	.area lit(rom, con, rel)
L20:
	.word 0x0,0x3f80
L14:
	.word 0xcccd,0x3dcc
; }

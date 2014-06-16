	.module hexapod_basic.c
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.c
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.c
_dirMirror:
	.blkb 1
	.area idata
	.byte 0
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.c
	.dbsym s dirMirror _dirMirror c
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.c
	.dbfunc e initializeAngles _initializeAngles fV
;              i -> R20,R21
;              j -> R22,R23
	.even
_initializeAngles::
	xcall push_xgsetF000
	.dbline -1
	.dbline 63
; /***
; Author : Srijit Dutt
; Date Sun 07 Nov 2010 02:42:38 PM IST 
; 
; hexapod_basic.c : File contains various basic motion functions for the hexapod
; Please include hexapod_basic.h file to call function from this file
; 
; */
; 
; /********************************************************************************
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
; #include "hexapod_macro.h"
; #include "hexapod.h"
; 
; 
; 
; unsigned char angleArr[6][3];//!< The angle of the servos
; static unsigned char dirMirror = DIR_MIRROR_LEG_1_2;
; 
; /**
; Initialize the servo angles
; */
; void initializeAngles() {
	.dbline 66
; 	 int i,j;
; 	 
; 	 for (i=0; i < NO_OF_LEGS; i++) {
	clr R20
	clr R21
L2:
	.dbline 66
	.dbline 67
; 	 	 for(j=0; j < NO_OF_SERVOS_IN_EACH_LEG; j++) {
	clr R22
	clr R23
L6:
	.dbline 67
	.dbline 68
; 		 		  angleArr[i][j] = INITIAL_ANGLE;
	ldi R16,3
	ldi R17,0
	movw R18,R20
	xcall empy16s
	movw R2,R16
	ldi R24,<_angleArr
	ldi R25,>_angleArr
	add R2,R24
	adc R3,R25
	movw R30,R22
	add R30,R2
	adc R31,R3
	ldi R24,90
	std z+0,R24
	.dbline 69
; 		 }
L7:
	.dbline 67
	subi R22,255  ; offset = 1
	sbci R23,255
	.dbline 67
	cpi R22,3
	ldi R30,0
	cpc R23,R30
	brlt L6
X0:
	.dbline 70
; 	 }
L3:
	.dbline 66
	subi R20,255  ; offset = 1
	sbci R21,255
	.dbline 66
	cpi R20,6
	ldi R30,0
	cpc R21,R30
	brlt L2
X1:
	.dbline -2
L1:
	.dbline 0 ; func end
	xjmp pop_xgsetF000
	.dbsym r i 20 I
	.dbsym r j 22 I
	.dbend
	.dbfunc e angle _angle fV
;          angle -> R10
;          motor -> R20
;            arm -> R12
	.even
_angle::
	xcall push_xgsetF03C
	mov R20,R18
	mov R12,R16
	sbiw R28,1
	ldd R10,y+9
	.dbline -1
	.dbline 90
; }
; 
; /**
; * Set the servo angle
; */
; void setAngle(unsigned char arm, unsigned char motor, unsigned char angle);
; 
; /**
; Get the servo angle
; */
; unsigned char getAngle(unsigned char arm, unsigned char motor);
; 
; /**
; Sets a specific servo to a angle
; 
; @param arm : The arm of the hexapod
; @param motor :  The motor of the hexapod
; @param angle : The angle to set the servo to
; */
; void angle(unsigned char arm, unsigned char motor, unsigned char angle) {
	.dbline 91
; 	setAngle(arm, motor, angle); 
	std y+0,R10
	mov R18,R20
	mov R16,R12
	xcall _setAngle
	.dbline 92
; 	switch (arm) {
	mov R22,R12
	clr R23
	cpi R22,1
	ldi R30,0
	cpc R23,R30
	breq L14
X2:
	cpi R22,2
	ldi R30,0
	cpc R23,R30
	breq L21
X3:
	cpi R22,3
	ldi R30,0
	cpc R23,R30
	brne X26
	xjmp L28
X26:
X4:
	cpi R22,4
	ldi R30,0
	cpc R23,R30
	brne X27
	xjmp L35
X27:
X5:
	cpi R22,5
	ldi R30,0
	cpc R23,R30
	brne X28
	xjmp L42
X28:
X6:
	cpi R22,6
	ldi R30,0
	cpc R23,R30
	brne X29
	xjmp L49
X29:
X7:
	xjmp L11
L14:
	.dbline 94
; 	case 1:
; 		if (motor == MOTOR_A)
	cpi R20,65
	brne L15
X8:
	.dbline 95
; 			angle_1A(angle);
	mov R16,R10
	xcall _angle_1A
	xjmp L12
L15:
	.dbline 96
; 		else if (motor == MOTOR_B)
	cpi R20,66
	brne L17
X9:
	.dbline 97
; 			angle_1B(angle);
	mov R16,R10
	xcall _angle_1B
	xjmp L12
L17:
	.dbline 98
; 		else if (motor == MOTOR_C)
	cpi R20,67
	breq X30
	xjmp L12
X30:
X10:
	.dbline 99
; 			angle_1C(angle);
	mov R16,R10
	xcall _angle_1C
	.dbline 100
; 		break;
	xjmp L12
L21:
	.dbline 102
; 	case 2:
; 		if (motor == MOTOR_A)
	cpi R20,65
	brne L22
X11:
	.dbline 103
; 			angle_2A(angle);
	mov R16,R10
	xcall _angle_2A
	xjmp L12
L22:
	.dbline 104
; 		else if (motor == MOTOR_B)
	cpi R20,66
	brne L24
X12:
	.dbline 105
; 			angle_2B(angle);
	mov R16,R10
	xcall _angle_2B
	xjmp L12
L24:
	.dbline 106
; 		else if (motor == MOTOR_C)
	cpi R20,67
	breq X31
	xjmp L12
X31:
X13:
	.dbline 107
; 			angle_2C(angle);
	mov R16,R10
	xcall _angle_2C
	.dbline 108
; 		break;
	xjmp L12
L28:
	.dbline 110
; 	case 3:
; 		if (motor == MOTOR_A)
	cpi R20,65
	brne L29
X14:
	.dbline 111
; 			angle_3A(angle);
	mov R16,R10
	xcall _angle_3A
	xjmp L12
L29:
	.dbline 112
; 		else if (motor == MOTOR_B)
	cpi R20,66
	brne L31
X15:
	.dbline 113
; 			angle_3B(angle);
	mov R16,R10
	xcall _angle_3B
	xjmp L12
L31:
	.dbline 114
; 		else if (motor == MOTOR_C)
	cpi R20,67
	breq X32
	xjmp L12
X32:
X16:
	.dbline 115
; 			angle_3C(angle);
	mov R16,R10
	xcall _angle_3C
	.dbline 116
; 		break;
	xjmp L12
L35:
	.dbline 118
; 	case 4:
; 		if (motor == MOTOR_A)
	cpi R20,65
	brne L36
X17:
	.dbline 119
; 			angle_4A(angle);
	mov R16,R10
	xcall _angle_4A
	xjmp L12
L36:
	.dbline 120
; 		else if (motor == MOTOR_B)
	cpi R20,66
	brne L38
X18:
	.dbline 121
; 			angle_4B(180 - angle);
	mov R2,R10
	clr R3
	ldi R16,180
	sub R16,R2
	sbc R17,R3
	xcall _angle_4B
	xjmp L12
L38:
	.dbline 122
; 		else if (motor == MOTOR_C)
	cpi R20,67
	breq X33
	xjmp L12
X33:
X19:
	.dbline 123
; 			angle_4C(180 - angle);
	mov R2,R10
	clr R3
	ldi R16,180
	sub R16,R2
	sbc R17,R3
	xcall _angle_4C
	.dbline 124
; 		break;
	xjmp L12
L42:
	.dbline 126
; 	case 5:
; 		if (motor == MOTOR_A)
	cpi R20,65
	brne L43
X20:
	.dbline 127
; 			angle_5A(angle);
	mov R16,R10
	xcall _angle_5A
	xjmp L12
L43:
	.dbline 128
; 		else if (motor == MOTOR_B)
	cpi R20,66
	brne L45
X21:
	.dbline 129
; 			angle_5B(180 - angle);
	mov R2,R10
	clr R3
	ldi R16,180
	sub R16,R2
	sbc R17,R3
	xcall _angle_5B
	xjmp L12
L45:
	.dbline 130
; 		else if (motor == MOTOR_C)
	cpi R20,67
	brne L12
X22:
	.dbline 131
; 			angle_5C(180 - angle);
	mov R2,R10
	clr R3
	ldi R16,180
	sub R16,R2
	sbc R17,R3
	xcall _angle_5C
	.dbline 132
; 		break;
	xjmp L12
L49:
	.dbline 134
; 	case 6:
; 		if (motor == MOTOR_A)
	cpi R20,65
	brne L50
X23:
	.dbline 135
; 			angle_6A(angle);
	mov R16,R10
	xcall _angle_6A
	xjmp L12
L50:
	.dbline 136
; 		else if (motor == MOTOR_B)
	cpi R20,66
	brne L52
X24:
	.dbline 137
; 			angle_6B(180 - angle);
	mov R2,R10
	clr R3
	ldi R16,180
	sub R16,R2
	sbc R17,R3
	xcall _angle_6B
	xjmp L12
L52:
	.dbline 138
; 		else if (motor == MOTOR_C)
	cpi R20,67
	brne L12
X25:
	.dbline 139
; 			angle_6C(180 - angle);
	mov R2,R10
	clr R3
	ldi R16,180
	sub R16,R2
	sbc R17,R3
	xcall _angle_6C
	.dbline 140
; 		break;
L11:
L12:
	.dbline -2
L10:
	.dbline 0 ; func end
	adiw R28,1
	xjmp pop_xgsetF03C
	.dbsym r angle 10 c
	.dbsym r motor 20 c
	.dbsym r arm 12 c
	.dbend
	.dbfunc e angle_XA _angle_XA fV
;          angle -> R10
	.even
_angle_XA::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 149
; 	}
; }
; 
; 
; /**
; Sets the angle of all the MOTOR_XA servo
; @param angle : The angle to be set
; */
; void angle_XA(unsigned char angle) {
	.dbline 150
; 	angle_1A(angle);
	mov R16,R10
	xcall _angle_1A
	.dbline 151
; 	angle_2A(angle);
	mov R16,R10
	xcall _angle_2A
	.dbline 152
; 	angle_3A(angle);
	mov R16,R10
	xcall _angle_3A
	.dbline 153
; 	angle_4A(angle);
	mov R16,R10
	xcall _angle_4A
	.dbline 154
; 	angle_5A(angle);
	mov R16,R10
	xcall _angle_5A
	.dbline 155
; 	angle_6A(angle);
	mov R16,R10
	xcall _angle_6A
	.dbline -2
L56:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_XB _angle_XB fV
;          angle -> R10
	.even
_angle_XB::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 162
; }
; 
; /**
; Sets the angle of all the MOTOR_XB servo
; @param angle : The angle to be set
; */
; void angle_XB(unsigned char angle) {
	.dbline 163
; 	angle_1B(angle);
	mov R16,R10
	xcall _angle_1B
	.dbline 164
; 	angle_2B(angle);
	mov R16,R10
	xcall _angle_2B
	.dbline 165
; 	angle_3B(angle);
	mov R16,R10
	xcall _angle_3B
	.dbline 166
; 	angle_4B(180 - angle);
	mov R2,R10
	clr R3
	ldi R16,180
	sub R16,R2
	sbc R17,R3
	xcall _angle_4B
	.dbline 167
; 	angle_5B(180 - angle);
	mov R2,R10
	clr R3
	ldi R16,180
	sub R16,R2
	sbc R17,R3
	xcall _angle_5B
	.dbline 168
; 	angle_6B(180 - angle);
	mov R2,R10
	clr R3
	ldi R16,180
	sub R16,R2
	sbc R17,R3
	xcall _angle_6B
	.dbline -2
L57:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_XC _angle_XC fV
;          angle -> R10
	.even
_angle_XC::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 176
; }
; 
; 
; /**
; Sets the angle of all the MOTOR_XC servo
; @param angle : The angle to be set
; */
; void angle_XC(unsigned char angle) {
	.dbline 177
; 	angle_1C(angle);
	mov R16,R10
	xcall _angle_1C
	.dbline 178
; 	angle_2C(angle);
	mov R16,R10
	xcall _angle_2C
	.dbline 179
; 	angle_3C(angle);
	mov R16,R10
	xcall _angle_3C
	.dbline 180
; 	angle_4C(180 - angle);
	mov R2,R10
	clr R3
	ldi R16,180
	sub R16,R2
	sbc R17,R3
	xcall _angle_4C
	.dbline 181
; 	angle_5C(180 - angle);
	mov R2,R10
	clr R3
	ldi R16,180
	sub R16,R2
	sbc R17,R3
	xcall _angle_5C
	.dbline 182
; 	angle_6C(180 - angle);
	mov R2,R10
	clr R3
	ldi R16,180
	sub R16,R2
	sbc R17,R3
	xcall _angle_6C
	.dbline -2
L58:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e swap _swap fV
;              t -> R10
;              b -> R18,R19
;              a -> R16,R17
	.even
_swap::
	st -y,R10
	.dbline -1
	.dbline 190
; }
; 
; 
; 
; /**
; Swaps two unsigned char
; */
; void swap(unsigned char *a, unsigned char *b) {
	.dbline 191
; 	 unsigned char t = *a;
	movw R30,R16
	ldd R10,z+0
	.dbline 192
; 	 *a = *b;
	movw R30,R18
	ldd R2,z+0
	movw R30,R16
	std z+0,R2
	.dbline 193
; 	 *b = t;
	movw R30,R18
	std z+0,R10
	.dbline -2
L59:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r t 10 c
	.dbsym r b 18 pc
	.dbsym r a 16 pc
	.dbend
	.dbfunc e setAngle _setAngle fV
;          angle -> y+0
;          motor -> R18
;            arm -> R16
	.even
_setAngle::
	.dbline -1
	.dbline 196
; }
; 
; void setAngle(unsigned char arm, unsigned char motor, unsigned char angle) {
	.dbline 197
; 	 angleArr[arm][motor - 'A'] = angle;
	ldi R24,3
	mul R24,R16
	movw R2,R0
	ldi R24,<_angleArr
	ldi R25,>_angleArr
	add R2,R24
	adc R3,R25
	mov R30,R18
	clr R31
	subi R30,65
	sbci R31,0
	add R30,R2
	adc R31,R3
	ldd R0,y+0
	std z+0,R0
	.dbline -2
L60:
	.dbline 0 ; func end
	ret
	.dbsym l angle 0 c
	.dbsym r motor 18 c
	.dbsym r arm 16 c
	.dbend
	.dbfunc e getAngle _getAngle fc
;          motor -> R18
;            arm -> R16
	.even
_getAngle::
	.dbline -1
	.dbline 200
; }
; 
; unsigned char getAngle(unsigned char arm, unsigned char motor) {
	.dbline 201
; 	 return angleArr[arm][motor - 'A'];
	ldi R24,3
	mul R24,R16
	movw R2,R0
	ldi R24,<_angleArr
	ldi R25,>_angleArr
	add R2,R24
	adc R3,R25
	mov R30,R18
	clr R31
	subi R30,65
	sbci R31,0
	add R30,R2
	adc R31,R3
	ldd R16,z+0
	.dbline -2
L61:
	.dbline 0 ; func end
	ret
	.dbsym r motor 18 c
	.dbsym r arm 16 c
	.dbend
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.c
L63:
	.blkb 2
	.area idata
	.word 1
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.c
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.c
	.dbfunc e buzzer_on_off _buzzer_on_off fV
	.dbsym s flag L63 I
	.even
_buzzer_on_off::
	.dbline -1
	.dbline 208
; }
; 
; 
; /**
; Flips the state of the buzzer
; */
; void buzzer_on_off() {
	.dbline 210
;      static int flag = 1;
; 	 if(flag) {
	lds R2,L63
	lds R3,L63+1
	tst R2
	brne X34
	tst R3
	breq L64
X34:
	.dbline 210
	.dbline 211
; 	     buzzer_on();
	xcall _buzzer_on
	.dbline 212
; 	 	 flag = 0;
	clr R2
	clr R3
	sts L63+1,R3
	sts L63,R2
	.dbline 213
; 	 }else {
	xjmp L65
L64:
	.dbline 213
	.dbline 214
; 	     buzzer_off();
	xcall _buzzer_off
	.dbline 215
; 	     flag = 1;  
	ldi R24,1
	ldi R25,0
	sts L63+1,R25
	sts L63,R24
	.dbline 216
; 	 }
L65:
	.dbline -2
L62:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e angle_change _angle_change fV
;         angle1 -> R20
;         change -> R22
;          motor -> R12
;            arm -> R10
	.even
_angle_change::
	xcall push_xgsetF0FC
	mov R12,R18
	mov R10,R16
	sbiw R28,1
	ldd R22,y+11
	.dbline -1
	.dbline 223
; }
; 
; /**
; Changes the angle of a servo by change
; Problem with this routine
; */
; void angle_change(unsigned char arm, unsigned char motor, char change) {
	.dbline 227
;     
; 	unsigned char angle1;
; 	
; 	 if(change + getAngle(arm, motor) < DEGREE_MIN || change + getAngle(arm, motor)  > 240) {
	mov R18,R12
	mov R16,R10
	xcall _getAngle
	mov R24,R22
	add R24,R16
	cpi R24,0
	brlo L69
X35:
	mov R18,R12
	mov R16,R10
	xcall _getAngle
	mov R2,R22
	add R2,R16
	ldi R24,240
	cp R24,R2
	brsh L67
X36:
L69:
	.dbline 227
	.dbline 228
; 	 		   angle1 = DEGREE_MIN;
	clr R20
	.dbline 230
; 			   //buzzer_on();
; 	} else if(change + getAngle(arm, motor)  > DEGREE_MAX) {
	xjmp L68
L67:
	.dbline 230
	mov R18,R12
	mov R16,R10
	xcall _getAngle
	mov R14,R16
	mov R2,R22
	add R2,R16
	ldi R24,180
	cp R24,R2
	brsh L70
X37:
	.dbline 230
	.dbline 231
; 	           angle1 = DEGREE_MAX;
	ldi R20,180
	.dbline 233
; 			   //buzzer_on();
; 	} else {
	xjmp L71
L70:
	.dbline 233
	.dbline 234
; 	 		   angle1 = change + getAngle(arm, motor);
	mov R18,R12
	mov R16,R10
	xcall _getAngle
	mov R14,R16
	mov R20,R22
	add R20,R16
	.dbline 235
; 	}
L71:
L68:
	.dbline 236
; 	angle(arm, motor, angle1);
	std y+0,R20
	mov R18,R12
	mov R16,R10
	xcall _angle
	.dbline -2
L66:
	.dbline 0 ; func end
	adiw R28,1
	xjmp pop_xgsetF0FC
	.dbsym r angle1 20 c
	.dbsym r change 22 c
	.dbsym r motor 12 c
	.dbsym r arm 10 c
	.dbend
	.dbfunc e setMirrorDir _setMirrorDir fV
;            dir -> R16
	.even
_setMirrorDir::
	.dbline -1
	.dbline 245
; 	
; }
; 
; 
; /**
; The sets the direction for the angleMirror function
; Used to move two legs with the same angle
; */
; void setMirrorDir(unsigned char dir) {
	.dbline 246
; 	 dirMirror = dir;
	sts _dirMirror,R16
	.dbline -2
L72:
	.dbline 0 ; func end
	ret
	.dbsym r dir 16 c
	.dbend
	.dbfunc e getMirrorDir _getMirrorDir fc
	.even
_getMirrorDir::
	.dbline -1
	.dbline 252
; }
; 
; /**
; Returns the Mirror diricetion
; */
; unsigned char getMirrorDir(void ) {
	.dbline 253
; 	 return dirMirror;
	lds R16,_dirMirror
	.dbline -2
L73:
	.dbline 0 ; func end
	ret
	.dbend
	.area lit(rom, con, rel)
L75:
	.word 2
	.word 1
	.word 4
	.word 3
	.word 6
	.word 5
	.word 6
	.word 3
	.word 2
	.word 5
	.word 4
	.word 1
	.word 4
	.word 5
	.word 6
	.word 1
	.word 2
	.word 3
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.c
	.dbfunc e getMirrorArm _getMirrorArm fc
;     arr_mirror -> y+0
;            arm -> R10
	.even
_getMirrorArm::
	st -y,R10
	mov R10,R16
	sbiw R28,36
	.dbline -1
	.dbline 259
; }
; 
; /**
; Returns the arm which mirrors the arm according to the dirMirror
; */
; unsigned char getMirrorArm(unsigned char arm) {
	.dbline 260
; 		 int arr_mirror[3][6] =  {{LEG_2, LEG_1, LEG_4, LEG_3, LEG_6, LEG_5}, 
	ldi R24,<L75
	ldi R25,>L75
	movw R30,R28
	ldi R16,36
	ldi R17,0
	st -y,R31
	st -y,R30
	st -y,R25
	st -y,R24
	xcall asgncblkx
	.dbline 263
; 		 	 				   	{LEG_6, LEG_3, LEG_2, LEG_5, LEG_4, LEG_1}, 
; 								{LEG_4, LEG_5, LEG_6, LEG_1, LEG_2, LEG_3}};
; 		 return arr_mirror[getMirrorDir()][arm - 1];
	xcall _getMirrorDir
	ldi R24,12
	mul R24,R16
	movw R2,R0
	movw R24,R28
	add R2,R24
	adc R3,R25
	mov R30,R10
	clr R31
	sbiw R30,1
	lsl R30
	rol R31
	add R30,R2
	adc R31,R3
	ldd R16,z+0
	.dbline -2
L74:
	.dbline 0 ; func end
	adiw R28,36
	ld R10,y+
	ret
	.dbsym l arr_mirror 0 A[36:3:6]I
	.dbsym r arm 10 c
	.dbend
	.dbfunc e angleMirror _angleMirror fV
;     arm_mirror -> R10
;       angleSet -> R12
;          motor -> R20
;            arm -> R14
	.even
_angleMirror::
	xcall push_xgset30FC
	mov R20,R18
	mov R14,R16
	sbiw R28,1
	ldd R12,y+9
	.dbline -1
	.dbline 273
; }
; 
; 
; /**
; Sets the angle of the arm servo and its Mirror arm to the angle angleSet
; @param arm : Arm of the hexapod
; @param motor : The motor of the hexapod
; @param angleSet :  The angle to be set 
; */
; void angleMirror(unsigned char arm, unsigned char motor, unsigned char angleSet) {
	.dbline 274
; 	 unsigned char arm_mirror = getMirrorArm(arm);
	mov R16,R14
	xcall _getMirrorArm
	mov R10,R16
	.dbline 275
; 	 angle(arm, motor, angleSet);
	std y+0,R12
	mov R18,R20
	mov R16,R14
	xcall _angle
	.dbline 276
; 	 if(motor == MOTOR_A)
	cpi R20,65
	brne L77
X38:
	.dbline 277
; 	 	 angle(arm_mirror, motor, 180 - angleSet);
	mov R2,R12
	clr R3
	ldi R24,180
	ldi R25,0
	sub R24,R2
	sbc R25,R3
	std y+0,R24
	mov R18,R20
	mov R16,R10
	xcall _angle
	xjmp L78
L77:
	.dbline 279
; 	 else
; 	 	 angle(arm_mirror, motor, angleSet);
	std y+0,R12
	mov R18,R20
	mov R16,R10
	xcall _angle
L78:
	.dbline -2
L76:
	.dbline 0 ; func end
	adiw R28,1
	xjmp pop_xgset30FC
	.dbsym r arm_mirror 10 c
	.dbsym r angleSet 12 c
	.dbsym r motor 20 c
	.dbsym r arm 14 c
	.dbend
	.dbfunc e angleMirrorChange _angleMirrorChange fV
;     arm_mirror -> R10
;    angleChange -> R14
;          motor -> R12
;            arm -> R20
	.even
_angleMirrorChange::
	xcall push_xgset30FC
	mov R12,R18
	mov R20,R16
	sbiw R28,1
	ldd R14,y+9
	.dbline -1
	.dbline 289
; 	 	  		  
; }
; 
; /**
; Changes angle of the arm servo and its Mirror arm by the angle angleChange
; @param arm : Arm of the hexapod
; @param motor : The motor of the hexapod
; @param angleChange :  The angle to change by 
; */
; void angleMirrorChange(unsigned char arm, unsigned char motor, char angleChange) {
	.dbline 290
; 	 unsigned char arm_mirror = getMirrorArm(arm);
	mov R16,R20
	xcall _getMirrorArm
	mov R10,R16
	.dbline 291
; 	 angle_change(arm, motor, angleChange);
	std y+0,R14
	mov R18,R12
	mov R16,R20
	xcall _angle_change
	.dbline 292
; 	 angle_change(arm_mirror, motor, angleChange);
	std y+0,R14
	mov R18,R12
	mov R16,R10
	xcall _angle_change
	.dbline -2
L79:
	.dbline 0 ; func end
	adiw R28,1
	xjmp pop_xgset30FC
	.dbsym r arm_mirror 10 c
	.dbsym r angleChange 14 c
	.dbsym r motor 12 c
	.dbsym r arm 20 c
	.dbend
	.area bss(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.c
_angleArr::
	.blkb 18
	.dbsym e angleArr _angleArr A[18:6:3]c
; }
; 
; 
; 
; 

	.module gait.c
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\gait.c
	.dbfunc e tripod_gait _tripod_gait fV
;   step_forward -> R20
;     delay_time -> R14,R15
;      step_side -> R12
;           dir6 -> R10
;           dir4 -> y+4
;           dir2 -> y+3
;           dir5 -> y+2
;           dir3 -> y+1
;           lift -> R22
;          steps -> y+17
;           dir1 -> y+15
	.even
_tripod_gait::
	xcall push_arg4
	xcall push_xgsetF0FC
	sbiw R28,5
	.dbline -1
	.dbline 67
; /***
; Author : Srijit Dutt
; Date Sun 07 Nov 2010 02:42:38 PM IST 
; 
; gait.c : File contains various walking motion functions for the hexapod
; Please include gait.h file to call function from this file
; 
; */
; 
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
; #include "hexapod_basic.h"
; #include "hexapod.h"
; 
; extern double movementScaling;
; 
; /**
; Tripod gait moves the hexapod in the direction dir1 for steps.
; Three legs forming a tripod move first then the other three legs move  
; Used for normal gait of the hexapod
; @param dir1 : Direction of motion
; @param steps : number of steps
; */
; void tripod_gait(unsigned char dir1, unsigned char steps) 
; {
	.dbline 68
; 	unsigned char dir3 = ((dir1 + 1) % 6) + 1;
	ldi R17,6
	ldd R16,y+15
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+1,R24
	.dbline 69
; 	unsigned char dir5 = ((dir3 + 1) % 6) + 1;
	ldi R17,6
	mov R16,R24
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+2,R24
	.dbline 70
; 	unsigned char dir2 = 7 - dir5;
	mov R2,R24
	ldi R24,7
	sub R24,R2
	std y+3,R24
	.dbline 71
; 	unsigned char dir4 = 7 - dir3;
	ldd R2,y+1
	ldi R24,7
	sub R24,R2
	std y+4,R24
	.dbline 72
; 	unsigned char dir6 = 7 - dir1;
	ldi R24,7
	mov R10,R24
	ldd R0,y+15
	sub R10,R0
	.dbline 73
; 	unsigned char step_forward = 70;
	ldi R20,70
	.dbline 74
; 	unsigned char step_side = 50;
	ldi R24,50
	mov R12,R24
	.dbline 75
; 	unsigned char lift = 40;
	ldi R22,40
	.dbline 76
; 	int delay_time = 150;//TWO_HUNDRED_FIFTY_MSEC;
	ldi R24,150
	ldi R25,0
	movw R14,R24
	.dbline 80
; 	
; 		
; 	// The following is done to keep dir3 to the left of dir1 and dir5 to the right of dir1
; 	if(dir1%2 == 0) 
	ldi R17,2
	mov R16,R0
	xcall mod8u
	tst R16
	breq X2
	xjmp L5
X2:
X0:
	.dbline 81
; 	{
	.dbline 82
; 		swap(&dir2, &dir4);
	movw R18,R28
	subi R18,252  ; offset = 4
	sbci R19,255
	movw R16,R28
	subi R16,253  ; offset = 3
	sbci R17,255
	xcall _swap
	.dbline 83
; 		swap(&dir3, &dir5);	  
	movw R18,R28
	subi R18,254  ; offset = 2
	sbci R19,255
	movw R16,R28
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall _swap
	.dbline 84
; 	}
	xjmp L5
L4:
	.dbline 87
; 	
; 	while (steps-- > 0) 
; 	{		
	.dbline 89
; 		//picking up even tripod
; 		angle(dir2, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 90
; 		angle(dir4, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 91
; 		angle(dir6, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	mov R16,R10
	xcall _angle
	.dbline 93
; 		
; 		delay(delay_time);
	movw R16,R14
	xcall _delay
	.dbline 96
; 		
; 		//moving body on odd tripod
; 		angle(dir1, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	ldd R16,y+15
	xcall _angle
	.dbline 97
; 		angle(dir3, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 98
; 		angle(dir5, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 101
; 		
; 		//moving legs even forward in air
; 		angle(dir2, MOTOR_A, 90 - step_side);
	ldi R24,90
	sub R24,R12
	std y+0,R24
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 102
; 		angle(dir4, MOTOR_A, 90 + step_side);
	mov R24,R12
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 103
; 		angle(dir6, MOTOR_C, 90 - step_forward);
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,67
	mov R16,R10
	xcall _angle
	.dbline 105
; 		
; 		delay(delay_time);
	movw R16,R14
	xcall _delay
	.dbline 108
; 
; 		//putting down even legs
; 		angle(dir2, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 109
; 		angle(dir4, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 110
; 		angle(dir6, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	mov R16,R10
	xcall _angle
	.dbline 112
; 		
; 		delay(HUNDRED_MSEC);
	ldi R16,40
	ldi R17,0
	xcall _delay
	.dbline 115
; 		
; 		//picking up odd legs
; 		angle(dir1, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+15
	xcall _angle
	.dbline 116
; 		angle(dir3, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 117
; 		angle(dir5, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 118
; 		delay(delay_time);
	movw R16,R14
	xcall _delay
	.dbline 121
; 
; 		//moving the odd legs in air
; 		angle(dir1, MOTOR_C, 90 + step_forward);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,67
	ldd R16,y+15
	xcall _angle
	.dbline 122
; 		angle(dir3, MOTOR_A, 90 - step_side);
	ldi R24,90
	sub R24,R12
	std y+0,R24
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 123
; 		angle(dir5, MOTOR_A, 90 + step_side);
	mov R24,R12
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 126
; 
; 		//moving the body forward on even tripod
; 		angle(dir2, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 127
; 		angle(dir4, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 128
; 		angle(dir6, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	mov R16,R10
	xcall _angle
	.dbline 130
; 		
; 		delay(delay_time);
	movw R16,R14
	xcall _delay
	.dbline 133
; 		
; 		//puuting down odd tripod
; 		angle(dir1, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+15
	xcall _angle
	.dbline 134
; 		angle(dir3, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 135
; 		angle(dir5, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 137
; 		
; 		delay(HUNDRED_MSEC);
	ldi R16,40
	ldi R17,0
	xcall _delay
	.dbline 138
; 	}
L5:
	.dbline 86
	ldd R2,y+17
	clr R3
	mov R24,R2
	subi R24,1
	std y+17,R24
	ldi R24,0
	cp R24,R2
	brsh X3
	xjmp L4
X3:
X1:
	.dbline -2
L1:
	.dbline 0 ; func end
	adiw R28,5
	xcall pop_xgsetF0FC
	adiw R28,4
	ret
	.dbsym r step_forward 20 c
	.dbsym r delay_time 14 I
	.dbsym r step_side 12 c
	.dbsym r dir6 10 c
	.dbsym l dir4 4 c
	.dbsym l dir2 3 c
	.dbsym l dir5 2 c
	.dbsym l dir3 1 c
	.dbsym r lift 22 c
	.dbsym l steps 17 c
	.dbsym l dir1 15 c
	.dbend
	.dbfunc e tripod_gait_2 _tripod_gait_2 fV
;    delay_time1 -> R10,R11
;   step_forward -> R20
;      step_side -> R14
;     delay_time -> R12,R13
;           lift -> R22
;           dir6 -> y+5
;           dir4 -> y+4
;           dir2 -> y+3
;           dir5 -> y+2
;           dir3 -> y+1
;          steps -> y+18
;           dir1 -> y+16
	.even
_tripod_gait_2::
	xcall push_arg4
	xcall push_xgsetF0FC
	sbiw R28,6
	.dbline -1
	.dbline 148
; 	
; }
; 
; /**
; Tripod Gait 2 : Better suited for uneven terrain
; @param dir1 : Direction of motion
; @param steps : number of steps
; */
; void tripod_gait_2(unsigned char dir1, unsigned char steps) 
; {
	.dbline 149
; 	unsigned char dir3 = ((dir1 + 1) % 6) + 1;
	ldi R17,6
	ldd R16,y+16
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+1,R24
	.dbline 150
; 	unsigned char dir5 = ((dir3 + 1) % 6) + 1;
	ldi R17,6
	mov R16,R24
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+2,R24
	.dbline 151
; 	unsigned char dir2 = 7 - dir5;
	mov R2,R24
	ldi R24,7
	sub R24,R2
	std y+3,R24
	.dbline 152
; 	unsigned char dir4 = 7 - dir3;
	ldd R2,y+1
	ldi R24,7
	sub R24,R2
	std y+4,R24
	.dbline 153
; 	unsigned char dir6 = 7 - dir1;
	ldi R24,7
	ldd R0,y+16
	sub R24,R0
	std y+5,R24
	.dbline 154
; 	unsigned char step_forward = 60;
	ldi R20,60
	.dbline 155
; 	unsigned char step_side = 60;
	ldi R24,60
	mov R14,R24
	.dbline 156
; 	unsigned char lift = 40;
	ldi R22,40
	.dbline 157
; 	int delay_time = ONE_SEC;
	ldi R24,400
	ldi R25,1
	movw R12,R24
	.dbline 158
; 	int delay_time1 = ONE_SEC;
	movw R10,R24
	.dbline 160
; 	
; 	if(dir1%2 == 0) 
	ldi R17,2
	ldd R16,y+16
	xcall mod8u
	tst R16
	breq X6
	xjmp L11
X6:
X4:
	.dbline 161
; 	{
	.dbline 162
; 		swap(&dir2, &dir4);
	movw R18,R28
	subi R18,252  ; offset = 4
	sbci R19,255
	movw R16,R28
	subi R16,253  ; offset = 3
	sbci R17,255
	xcall _swap
	.dbline 163
; 		swap(&dir3, &dir5);	  
	movw R18,R28
	subi R18,254  ; offset = 2
	sbci R19,255
	movw R16,R28
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall _swap
	.dbline 164
; 	}
	xjmp L11
L10:
	.dbline 167
; 	
; 	while (steps-- > 0) 
; 	{
	.dbline 169
; 		//puuting down odd tripod
; 		angle(dir1, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	ldd R16,y+16
	xcall _angle
	.dbline 170
; 		angle(dir3, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	ldd R16,y+1
	xcall _angle
	.dbline 171
; 		angle(dir5, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	ldd R16,y+2
	xcall _angle
	.dbline 172
; 		angle(dir1, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+16
	xcall _angle
	.dbline 173
; 		angle(dir3, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 174
; 		angle(dir5, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 176
; 		
; 		delay(delay_time1);
	movw R16,R10
	xcall _delay
	.dbline 179
; 		
; 		//picking up even tripod
; 		angle(dir2, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 180
; 		angle(dir4, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 181
; 		angle(dir6, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+5
	xcall _angle
	.dbline 182
; 		angle(dir2, MOTOR_C, 0);
	clr R2
	std y+0,R2
	ldi R18,67
	ldd R16,y+3
	xcall _angle
	.dbline 183
; 		angle(dir4, MOTOR_C, 0);
	clr R2
	std y+0,R2
	ldi R18,67
	ldd R16,y+4
	xcall _angle
	.dbline 184
; 		angle(dir6, MOTOR_C, 0);
	clr R2
	std y+0,R2
	ldi R18,67
	ldd R16,y+5
	xcall _angle
	.dbline 185
; 		delay(delay_time);
	movw R16,R12
	xcall _delay
	.dbline 188
; 
; 		//moving body on odd tripod
; 		angle(dir1, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+16
	xcall _angle
	.dbline 189
; 		angle(dir3, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 190
; 		angle(dir5, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 192
; 		
; 		delay(delay_time);
	movw R16,R12
	xcall _delay
	.dbline 195
; 		
; 		//moving legs even forward in air
; 		angle(dir2, MOTOR_C, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldd R16,y+3
	xcall _angle
	.dbline 196
; 		angle(dir4, MOTOR_C, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldd R16,y+4
	xcall _angle
	.dbline 197
; 		angle(dir6, MOTOR_C, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldd R16,y+5
	xcall _angle
	.dbline 198
; 		angle(dir2, MOTOR_A, 90 - step_side);
	ldi R24,90
	sub R24,R14
	std y+0,R24
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 199
; 		angle(dir4, MOTOR_A, 90 + step_side);
	mov R24,R14
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 200
; 		angle(dir6, MOTOR_A, 90 + step_forward);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+5
	xcall _angle
	.dbline 201
; 		delay(delay_time);
	movw R16,R12
	xcall _delay
	.dbline 204
; 
; 		//putting down even legs
; 		angle(dir2, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	ldd R16,y+3
	xcall _angle
	.dbline 205
; 		angle(dir4, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	ldd R16,y+4
	xcall _angle
	.dbline 206
; 		angle(dir6, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	ldd R16,y+5
	xcall _angle
	.dbline 207
; 		angle(dir2, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 208
; 		angle(dir4, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 209
; 		angle(dir6, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+5
	xcall _angle
	.dbline 211
; 		
; 		delay(delay_time1);
	movw R16,R10
	xcall _delay
	.dbline 214
; 		
; 		//picking up odd legs
; 		angle(dir1, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+16
	xcall _angle
	.dbline 215
; 		angle(dir3, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 216
; 		angle(dir5, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 217
; 		angle(dir1, MOTOR_C, 0);
	clr R2
	std y+0,R2
	ldi R18,67
	ldd R16,y+16
	xcall _angle
	.dbline 218
; 		angle(dir3, MOTOR_C, 0);
	clr R2
	std y+0,R2
	ldi R18,67
	ldd R16,y+1
	xcall _angle
	.dbline 219
; 		angle(dir5, MOTOR_C, 0);
	clr R2
	std y+0,R2
	ldi R18,67
	ldd R16,y+2
	xcall _angle
	.dbline 220
; 		delay(delay_time);
	movw R16,R12
	xcall _delay
	.dbline 223
; 
; 		//moving the odd legs in air
; 		angle(dir1, MOTOR_C, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldd R16,y+16
	xcall _angle
	.dbline 224
; 		angle(dir3, MOTOR_C, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldd R16,y+1
	xcall _angle
	.dbline 225
; 		angle(dir5, MOTOR_C, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldd R16,y+2
	xcall _angle
	.dbline 226
; 		angle(dir1, MOTOR_A, 90 + step_forward);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+16
	xcall _angle
	.dbline 227
; 		angle(dir3, MOTOR_A, 90 - step_side);
	ldi R24,90
	sub R24,R14
	std y+0,R24
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 228
; 		angle(dir5, MOTOR_A, 90 + step_side);
	mov R24,R14
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 229
; 		delay(delay_time);
	movw R16,R12
	xcall _delay
	.dbline 232
; 		
; 		//moving the body forward on even tripod
; 		angle(dir2, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 233
; 		angle(dir4, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 234
; 		angle(dir6, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+5
	xcall _angle
	.dbline 235
; 		delay(delay_time);
	movw R16,R12
	xcall _delay
	.dbline 236
; 	}
L11:
	.dbline 166
	ldd R2,y+18
	clr R3
	mov R24,R2
	subi R24,1
	std y+18,R24
	ldi R24,0
	cp R24,R2
	brsh X7
	xjmp L10
X7:
X5:
	.dbline -2
L7:
	.dbline 0 ; func end
	adiw R28,6
	xcall pop_xgsetF0FC
	adiw R28,4
	ret
	.dbsym r delay_time1 10 I
	.dbsym r step_forward 20 c
	.dbsym r step_side 14 c
	.dbsym r delay_time 12 I
	.dbsym r lift 22 c
	.dbsym l dir6 5 c
	.dbsym l dir4 4 c
	.dbsym l dir2 3 c
	.dbsym l dir5 2 c
	.dbsym l dir3 1 c
	.dbsym l steps 18 c
	.dbsym l dir1 16 c
	.dbend
	.area lit(rom, con, rel)
L14:
	.byte 0,2
	.byte 3,6
	.byte 1,4
	.byte 5
L15:
	.byte 0,4
	.byte 1,2
	.byte 5,6
	.byte 3
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\gait.c
	.dbfunc e two_leg_gait _two_leg_gait fV
;     legs_clock -> y+8
; legs_anticlock -> y+1
;    delay_time2 -> R10,R11
;    delay_time1 -> R14,R15
;      step_side -> R12
;           dir6 -> y+18
;           dir5 -> y+17
;           dir4 -> y+16
;           dir3 -> y+15
;           lift -> R22
;   step_forward -> R20
;          steps -> y+33
;           dir2 -> y+31
;           dir1 -> y+29
	.even
_two_leg_gait::
	xcall push_arg4
	xcall push_xgsetF0FC
	sbiw R28,19
	.dbline -1
	.dbline 246
; }
; 
; /*
; Two leg gait in which two legs are moved at a time
; @param dir1 : Direction of motion
; @param dir2 : Direction of motion
; @param steps : number of steps
; */
; void two_leg_gait(unsigned char dir1, unsigned char dir2, int steps) 
; {
	.dbline 247
; 	 unsigned char legs_anticlock[] = {0,2,3,6,1,4,5};
	ldi R24,<L14
	ldi R25,>L14
	movw R30,R28
	adiw R30,1
	ldi R16,7
	ldi R17,0
	st -y,R31
	st -y,R30
	st -y,R25
	st -y,R24
	xcall asgncblkx
	.dbline 248
; 	 unsigned char legs_clock[] = {0,4,1,2,5,6,3}; 
	ldi R24,<L15
	ldi R25,>L15
	movw R30,R28
	adiw R30,8
	ldi R16,7
	ldi R17,0
	st -y,R31
	st -y,R30
	st -y,R25
	st -y,R24
	xcall asgncblkx
	.dbline 249
; 	 unsigned char dir3 = legs_anticlock[dir2];
	movw R24,R28
	adiw R24,1
	ldd R30,y+31
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	std y+15,R2
	.dbline 250
; 	 unsigned char dir4 = legs_clock[dir1];
	movw R24,R28
	adiw R24,8
	ldd R30,y+29
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	std y+16,R2
	.dbline 251
; 	 unsigned char dir5 = legs_clock[dir4];
	movw R24,R28
	adiw R24,8
	mov R30,R2
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	std y+17,R2
	.dbline 252
; 	 unsigned char dir6= legs_anticlock[dir3];
	movw R24,R28
	adiw R24,1
	ldd R30,y+15
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	std y+18,R2
	.dbline 253
; 	 unsigned char step_forward = 50 * movementScaling;
	ldi R16,<L16
	ldi R17,>L16
	xcall elpm32
	ldi R24,<_movementScaling
	ldi R25,>_movementScaling
	st -y,R25
	st -y,R24
	xcall fpmule1
	xcall fpint
	mov R20,R16
	.dbline 254
; 	 unsigned char step_side = 40 * movementScaling;
	ldi R16,<L17
	ldi R17,>L17
	xcall elpm32
	ldi R24,<_movementScaling
	ldi R25,>_movementScaling
	st -y,R25
	st -y,R24
	xcall fpmule1
	xcall fpint
	mov R12,R16
	.dbline 255
; 	 unsigned char lift = 40;
	ldi R22,40
	.dbline 256
; 	 int delay_time1 = FIVE_HUNDRED_MSEC;
	ldi R24,200
	ldi R25,0
	movw R14,R24
	.dbline 257
; 	 int delay_time2 = FIVE_HUNDRED_MSEC;
	movw R10,R24
	xjmp L19
L18:
	.dbline 260
; 	 
; 	 while(steps-- > 0) 
; 	 {
	.dbline 262
; 	    //putting down legs 5 & 6
; 		angle(dir5, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+17
	xcall _angle
	.dbline 263
; 		angle(dir6, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+18
	xcall _angle
	.dbline 266
; 	 
; 	 	//picking up 1 & 2 legs
; 		angle(dir1, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+29
	xcall _angle
	.dbline 267
; 		angle(dir2, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+31
	xcall _angle
	.dbline 270
; 		
; 		//delay
; 		delay(delay_time1);
	movw R16,R14
	xcall _delay
	.dbline 273
; 		
; 		//moving body on legs 5 & 6
; 		angle(dir5, MOTOR_A, 90 - step_forward);
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,65
	ldd R16,y+17
	xcall _angle
	.dbline 274
; 		angle(dir6, MOTOR_A, 90 + step_forward);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+18
	xcall _angle
	.dbline 277
; 		
; 		//moving 1 & 2 legs in air 
; 		angle(dir1, MOTOR_A, 90 + step_forward);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+29
	xcall _angle
	.dbline 278
; 		angle(dir2, MOTOR_A, 90 - step_forward);
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,65
	ldd R16,y+31
	xcall _angle
	.dbline 281
; 		
; 		//delay
; 		delay(delay_time1);
	movw R16,R14
	xcall _delay
	.dbline 284
; 		
; 		//putting 1 & 2 legs down
; 		angle(dir1, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+29
	xcall _angle
	.dbline 285
; 		angle(dir2, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+31
	xcall _angle
	.dbline 288
; 		
; 		//picking up 3 & 4 legs		   
; 	 	angle(dir3, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+15
	xcall _angle
	.dbline 289
; 		angle(dir4, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+16
	xcall _angle
	.dbline 291
; 		
; 		delay(delay_time1);
	movw R16,R14
	xcall _delay
	.dbline 294
; 		
; 		//moving body on legs 1 & 2
; 		angle(dir1, MOTOR_A, 90 - step_forward);
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,65
	ldd R16,y+29
	xcall _angle
	.dbline 295
; 		angle(dir2, MOTOR_A, 90 + step_forward);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+31
	xcall _angle
	.dbline 298
; 		
; 		//moving legs 3 & 4 in air
; 		angle(dir3, MOTOR_A, 90 - step_side);
	ldi R24,90
	sub R24,R12
	std y+0,R24
	ldi R18,65
	ldd R16,y+15
	xcall _angle
	.dbline 299
; 		angle(dir4, MOTOR_A, 90 + step_side);
	mov R24,R12
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+16
	xcall _angle
	.dbline 301
; 		
; 		delay(delay_time2);
	movw R16,R10
	xcall _delay
	.dbline 304
; 		
; 		//putting down legs 3 & 4
; 		angle(dir3, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+15
	xcall _angle
	.dbline 305
; 		angle(dir4, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+16
	xcall _angle
	.dbline 308
; 		
; 		//picking up legs 5 & 6
; 		angle(dir5, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+17
	xcall _angle
	.dbline 309
; 		angle(dir6, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+18
	xcall _angle
	.dbline 311
; 		
; 		delay(delay_time1);
	movw R16,R14
	xcall _delay
	.dbline 314
; 		
; 		//moving body on legs 3 & 4
; 		angle(dir3, MOTOR_A, 90 + step_side);
	mov R24,R12
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+15
	xcall _angle
	.dbline 315
; 		angle(dir4, MOTOR_A, 90 - step_side);
	ldi R24,90
	sub R24,R12
	std y+0,R24
	ldi R18,65
	ldd R16,y+16
	xcall _angle
	.dbline 318
; 		
; 		//moving legs 5 & 6 in air 
; 		angle(dir5, MOTOR_A, 90 + step_forward);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+17
	xcall _angle
	.dbline 319
; 		angle(dir6, MOTOR_A, 90 - step_forward);
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,65
	ldd R16,y+18
	xcall _angle
	.dbline 321
; 		
; 		delay(delay_time2);
	movw R16,R10
	xcall _delay
	.dbline 322
; 	 }
L19:
	.dbline 259
	ldd R4,y+33
	ldd R5,y+34
	movw R24,R4
	sbiw R24,1
	std y+34,R25
	std y+33,R24
	clr R2
	clr R3
	cp R2,R4
	cpc R3,R5
	brge X9
	xjmp L18
X9:
X8:
	.dbline -2
L13:
	.dbline 0 ; func end
	adiw R28,19
	xcall pop_xgsetF0FC
	adiw R28,4
	ret
	.dbsym l legs_clock 8 A[7:7]c
	.dbsym l legs_anticlock 1 A[7:7]c
	.dbsym r delay_time2 10 I
	.dbsym r delay_time1 14 I
	.dbsym r step_side 12 c
	.dbsym l dir6 18 c
	.dbsym l dir5 17 c
	.dbsym l dir4 16 c
	.dbsym l dir3 15 c
	.dbsym r lift 22 c
	.dbsym r step_forward 20 c
	.dbsym l steps 33 I
	.dbsym l dir2 31 c
	.dbsym l dir1 29 c
	.dbend
	.dbfunc e tripod_turn_gait _tripod_turn_gait fV
;     delay_time -> R14,R15
;           dir6 -> R12
;           dir4 -> y+4
;           dir2 -> y+3
;           dir5 -> y+2
;           dir3 -> y+1
;           dir1 -> y+5
;           lift -> R10
;      step_side -> R20,R21
;          steps -> y+16
;        rot_dir -> R22
	.even
_tripod_turn_gait::
	st -y,r19
	st -y,r18
	xcall push_xgsetF0FC
	mov R22,R16
	sbiw R28,6
	.dbline -1
	.dbline 332
; }
; 
; /**
; Tripod turn gait in which two legs are moved at a time
; @param dir1 : Direction of motion
; @param dir2 : Direction of motion
; @param steps : number of steps
; */
; void tripod_turn_gait(unsigned char rot_dir, unsigned char steps) 
; {
	.dbline 334
;  	// making the LEG_1 as default leg for our movement
;  	unsigned char dir1 = LEG_1;				 
	clr R0
	inc R0
	std y+5,R0
	.dbline 335
;     unsigned char dir3 = ((dir1 + 1) % 6) + 1;
	ldi R17,6
	mov R16,R0
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+1,R24
	.dbline 336
;     unsigned char dir5 = ((dir3 + 1) % 6) + 1;
	ldi R17,6
	mov R16,R24
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+2,R24
	.dbline 337
;     unsigned char dir2 = 7 - dir5;
	mov R2,R24
	ldi R24,7
	sub R24,R2
	std y+3,R24
	.dbline 338
;     unsigned char dir4 = 7 - dir3;
	ldd R2,y+1
	ldi R24,7
	sub R24,R2
	std y+4,R24
	.dbline 339
;     unsigned char dir6 = 7 - dir1;
	ldi R24,7
	mov R12,R24
	ldd R0,y+5
	sub R12,R0
	.dbline 340
;     int step_side = 50;
	ldi R20,50
	ldi R21,0
	.dbline 341
;     unsigned char lift = 40 * movementScaling;
	ldi R16,<L17
	ldi R17,>L17
	xcall elpm32
	ldi R24,<_movementScaling
	ldi R25,>_movementScaling
	st -y,R25
	st -y,R24
	xcall fpmule1
	xcall fpint
	mov R10,R16
	.dbline 342
;     int delay_time = 150;//TWO_HUNDRED_FIFTY_MSEC;
	ldi R24,150
	ldi R25,0
	movw R14,R24
	.dbline 345
; 	
;     // if rotation direction is anti-clockwise rot_dir = 0 else rot_dir = 1
; 	step_side = step_side*(1 - 2*rot_dir);
	mov R2,R22
	clr R3
	lsl R2
	rol R3
	ldi R18,1
	ldi R19,0
	sub R18,R2
	sbc R19,R3
	movw R16,R20
	xcall empy16s
	movw R20,R16
	.dbline 348
; 	
;     // The following is done to keep dir3 to the left of dir1 and dir5 to the right of dir1
;     if(dir1%2 == 0) 
	ldi R17,2
	ldd R16,y+5
	xcall mod8u
	tst R16
	breq X12
	xjmp L25
X12:
X10:
	.dbline 349
; 	{
	.dbline 350
;         swap(&dir2, &dir4);
	movw R18,R28
	subi R18,252  ; offset = 4
	sbci R19,255
	movw R16,R28
	subi R16,253  ; offset = 3
	sbci R17,255
	xcall _swap
	.dbline 351
;         swap(&dir3, &dir5);
	movw R18,R28
	subi R18,254  ; offset = 2
	sbci R19,255
	movw R16,R28
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall _swap
	.dbline 352
;     }
	xjmp L25
L24:
	.dbline 355
; 	
;     while (steps-- > 0) 
; 	{        
	.dbline 357
;         //picking up even tripod
;         angle(dir2, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 358
;         angle(dir4, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 359
;         angle(dir6, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	mov R16,R12
	xcall _angle
	.dbline 361
;     
;         delay(delay_time);
	movw R16,R14
	xcall _delay
	.dbline 364
; 
;         //moving body on odd tripod
;         angle(dir1, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+5
	xcall _angle
	.dbline 365
;         angle(dir3, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 366
;         angle(dir5, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 369
;         
;         //rotating legs even in air
;         angle(dir2, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 370
;         angle(dir4, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 371
;         angle(dir6, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	mov R16,R12
	xcall _angle
	.dbline 373
;         
;         delay(delay_time);
	movw R16,R14
	xcall _delay
	.dbline 376
; 
;         //putting down even legs
;         angle(dir2, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 377
;         angle(dir4, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 378
;         angle(dir6, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	mov R16,R12
	xcall _angle
	.dbline 380
;         
;         delay(HUNDRED_MSEC);
	ldi R16,40
	ldi R17,0
	xcall _delay
	.dbline 383
;         
;         //picking up odd legs
;         angle(dir1, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+5
	xcall _angle
	.dbline 384
;         angle(dir3, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 385
;         angle(dir5, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 386
;         delay(delay_time);
	movw R16,R14
	xcall _delay
	.dbline 389
; 
;         //moving the odd legs in air
;         angle(dir1, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+5
	xcall _angle
	.dbline 390
;         angle(dir3, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 391
;         angle(dir5, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 394
; 
;         //rotating the body on even tripod
;         angle(dir2, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 395
;         angle(dir4, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 396
;         angle(dir6, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	mov R16,R12
	xcall _angle
	.dbline 398
;         
;         delay(delay_time);
	movw R16,R14
	xcall _delay
	.dbline 401
;         
;         //puuting down odd tripod
;         angle(dir1, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+5
	xcall _angle
	.dbline 402
;         angle(dir3, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 403
;         angle(dir5, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 405
;         
;         delay(HUNDRED_MSEC);
	ldi R16,40
	ldi R17,0
	xcall _delay
	.dbline 406
;     }
L25:
	.dbline 354
	ldd R2,y+16
	clr R3
	mov R24,R2
	subi R24,1
	std y+16,R24
	ldi R24,0
	cp R24,R2
	brsh X13
	xjmp L24
X13:
X11:
	.dbline -2
L21:
	.dbline 0 ; func end
	adiw R28,6
	xcall pop_xgsetF0FC
	adiw R28,2
	ret
	.dbsym r delay_time 14 I
	.dbsym r dir6 12 c
	.dbsym l dir4 4 c
	.dbsym l dir2 3 c
	.dbsym l dir5 2 c
	.dbsym l dir3 1 c
	.dbsym l dir1 5 c
	.dbsym r lift 10 c
	.dbsym r step_side 20 I
	.dbsym l steps 16 c
	.dbsym r rot_dir 22 c
	.dbend
	.dbfunc e tripod_turn_gait_continuous _tripod_turn_gait_continuous fV
;     delay_time -> R14,R15
;           dir6 -> R12
;           dir4 -> y+4
;           dir2 -> y+3
;           dir5 -> y+2
;           dir3 -> y+1
;           dir1 -> y+5
;           lift -> R10
;      step_side -> R20,R21
;          steps -> y+16
;        rot_dir -> R22
	.even
_tripod_turn_gait_continuous::
	st -y,r19
	st -y,r18
	xcall push_xgsetF0FC
	mov R22,R16
	sbiw R28,6
	.dbline -1
	.dbline 417
; }
; 
; /**
; Tripod gait moves the hexapod in the direction dir1 for steps.
; Three legs forming a tripod move first then the other three legs move  
; Used for normal gait of the hexapod
; @param rot_dir : Direction of rotation
; @param steps : number of steps
; */
; void tripod_turn_gait_continuous(unsigned char rot_dir, unsigned char steps) 
; {
	.dbline 418
;  	unsigned char dir1 = LEG_1;
	clr R0
	inc R0
	std y+5,R0
	.dbline 419
;     unsigned char dir3 = ((dir1 + 1) % 6) + 1;
	ldi R17,6
	mov R16,R0
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+1,R24
	.dbline 420
;     unsigned char dir5 = ((dir3 + 1) % 6) + 1;
	ldi R17,6
	mov R16,R24
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+2,R24
	.dbline 421
;     unsigned char dir2 = 7 - dir5;
	mov R2,R24
	ldi R24,7
	sub R24,R2
	std y+3,R24
	.dbline 422
;     unsigned char dir4 = 7 - dir3;
	ldd R2,y+1
	ldi R24,7
	sub R24,R2
	std y+4,R24
	.dbline 423
;     unsigned char dir6 = 7 - dir1;
	ldi R24,7
	mov R12,R24
	ldd R0,y+5
	sub R12,R0
	.dbline 424
;     int step_side = 45 * movementScaling;
	ldi R16,<L28
	ldi R17,>L28
	xcall elpm32
	ldi R24,<_movementScaling
	ldi R25,>_movementScaling
	st -y,R25
	st -y,R24
	xcall fpmule1
	xcall fpint
	.dbline 426
; 	
;     unsigned char lift = 40;
	ldi R24,40
	mov R10,R24
	.dbline 427
;     int delay_time = 150;//TWO_HUNDRED_FIFTY_MSEC;
	ldi R24,150
	ldi R25,0
	movw R14,R24
	.dbline 430
;     
; 	// if rotation direction is anti-clockwise rot_dir = 0 else rot_dir = 1
; 	step_side = step_side*(1 - 2*rot_dir);
	mov R2,R22
	clr R3
	lsl R2
	rol R3
	ldi R18,1
	ldi R19,0
	sub R18,R2
	sbc R19,R3
	xcall empy16s
	movw R20,R16
	.dbline 433
; 	
;     // The following is done to keep dir3 to the left of dir1 and dir5 to the right of dir1
;     if(dir1%2 == 0) 
	ldi R17,2
	ldd R16,y+5
	xcall mod8u
	tst R16
	breq X16
	xjmp L32
X16:
X14:
	.dbline 434
; 	{
	.dbline 435
;         swap(&dir2, &dir4);
	movw R18,R28
	subi R18,252  ; offset = 4
	sbci R19,255
	movw R16,R28
	subi R16,253  ; offset = 3
	sbci R17,255
	xcall _swap
	.dbline 436
;         swap(&dir3, &dir5);
	movw R18,R28
	subi R18,254  ; offset = 2
	sbci R19,255
	movw R16,R28
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall _swap
	.dbline 437
;     }
	xjmp L32
L31:
	.dbline 440
;     
;     while (steps-- > 0) 
; 	{        
	.dbline 442
;         //picking up even tripod
;         angle(dir2, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 443
;         angle(dir4, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 444
;         angle(dir6, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	mov R16,R12
	xcall _angle
	.dbline 446
;     
;         delay(delay_time);
	movw R16,R14
	xcall _delay
	.dbline 449
; 
;         //moving body on odd tripod
;         angle(dir1, MOTOR_A, 90 - step_side);
	ldi R24,90
	ldi R25,0
	movw R2,R24
	sub R2,R20
	sbc R3,R21
	std y+0,R2
	ldi R18,65
	ldd R16,y+5
	xcall _angle
	.dbline 450
;         angle(dir3, MOTOR_A, 90 - step_side);
	ldi R24,90
	ldi R25,0
	movw R2,R24
	sub R2,R20
	sbc R3,R21
	std y+0,R2
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 451
;         angle(dir5, MOTOR_A, 90 - step_side);
	ldi R24,90
	ldi R25,0
	movw R2,R24
	sub R2,R20
	sbc R3,R21
	std y+0,R2
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 454
;         
;         //rotating legs even in air
;         angle(dir2, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 455
;         angle(dir4, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 456
;         angle(dir6, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	mov R16,R12
	xcall _angle
	.dbline 458
;         
;         delay(delay_time);
	movw R16,R14
	xcall _delay
	.dbline 461
; 
;         //putting down even legs
;         angle(dir2, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 462
;         angle(dir4, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 463
;         angle(dir6, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	mov R16,R12
	xcall _angle
	.dbline 465
;         
;         delay(HUNDRED_MSEC);
	ldi R16,40
	ldi R17,0
	xcall _delay
	.dbline 468
;         
;         //picking up odd legs
;         angle(dir1, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+5
	xcall _angle
	.dbline 469
;         angle(dir3, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 470
;         angle(dir5, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 471
;         delay(delay_time);
	movw R16,R14
	xcall _delay
	.dbline 474
; 
;         //moving the odd legs in air
;         angle(dir1, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+5
	xcall _angle
	.dbline 475
;         angle(dir3, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 476
;         angle(dir5, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 479
; 
;         //rotating the body on even tripod
;         angle(dir2, MOTOR_A, 90 - step_side);
	ldi R24,90
	ldi R25,0
	movw R2,R24
	sub R2,R20
	sbc R3,R21
	std y+0,R2
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 480
;         angle(dir4, MOTOR_A, 90 - step_side);
	ldi R24,90
	ldi R25,0
	movw R2,R24
	sub R2,R20
	sbc R3,R21
	std y+0,R2
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 481
;         angle(dir6, MOTOR_A, 90 - step_side);
	ldi R24,90
	ldi R25,0
	movw R2,R24
	sub R2,R20
	sbc R3,R21
	std y+0,R2
	ldi R18,65
	mov R16,R12
	xcall _angle
	.dbline 483
;         
;         delay(delay_time);
	movw R16,R14
	xcall _delay
	.dbline 486
;         
;         //puuting down odd tripod
;         angle(dir1, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+5
	xcall _angle
	.dbline 487
;         angle(dir3, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 488
;         angle(dir5, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 490
;         
;         delay(HUNDRED_MSEC);
	ldi R16,40
	ldi R17,0
	xcall _delay
	.dbline 491
;     }
L32:
	.dbline 439
	ldd R2,y+16
	clr R3
	mov R24,R2
	subi R24,1
	std y+16,R24
	ldi R24,0
	cp R24,R2
	brsh X17
	xjmp L31
X17:
X15:
	.dbline -2
L27:
	.dbline 0 ; func end
	adiw R28,6
	xcall pop_xgsetF0FC
	adiw R28,2
	ret
	.dbsym r delay_time 14 I
	.dbsym r dir6 12 c
	.dbsym l dir4 4 c
	.dbsym l dir2 3 c
	.dbsym l dir5 2 c
	.dbsym l dir3 1 c
	.dbsym l dir1 5 c
	.dbsym r lift 10 c
	.dbsym r step_side 20 I
	.dbsym l steps 16 c
	.dbsym r rot_dir 22 c
	.dbend
	.dbfunc e two_legged_turn_gait _two_legged_turn_gait fV
;           dir6 -> R14
;           dir4 -> y+4
;           dir2 -> y+3
;           dir5 -> y+2
;           dir3 -> y+1
;           dir1 -> y+5
;     delay_time -> R12,R13
;           lift -> R10
;      step_side -> R20,R21
;          steps -> y+16
;        rot_dir -> R22
	.even
_two_legged_turn_gait::
	st -y,r19
	st -y,r18
	xcall push_xgsetF0FC
	mov R22,R16
	sbiw R28,6
	.dbline -1
	.dbline 494
; }
; 
; void two_legged_turn_gait(unsigned char rot_dir, unsigned char steps) {
	.dbline 495
; 	unsigned char dir1 = LEG_1;
	clr R0
	inc R0
	std y+5,R0
	.dbline 496
;     unsigned char dir3 = ((dir1 + 1) % 6) + 1;
	ldi R17,6
	mov R16,R0
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+1,R24
	.dbline 497
;     unsigned char dir5 = ((dir3 + 1) % 6) + 1;
	ldi R17,6
	mov R16,R24
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+2,R24
	.dbline 498
;     unsigned char dir2 = 7 - dir5;
	mov R2,R24
	ldi R24,7
	sub R24,R2
	std y+3,R24
	.dbline 499
;     unsigned char dir4 = 7 - dir3;
	ldd R2,y+1
	ldi R24,7
	sub R24,R2
	std y+4,R24
	.dbline 500
;     unsigned char dir6 = 7 - dir1;
	ldi R24,7
	mov R14,R24
	ldd R0,y+5
	sub R14,R0
	.dbline 502
; 
;     int step_side = 50 * movementScaling;
	ldi R16,<L16
	ldi R17,>L16
	xcall elpm32
	ldi R24,<_movementScaling
	ldi R25,>_movementScaling
	st -y,R25
	st -y,R24
	xcall fpmule1
	xcall fpint
	.dbline 503
;     unsigned char lift = 40;
	ldi R24,40
	mov R10,R24
	.dbline 504
;     int delay_time = 150;//TWO_HUNDRED_FIFTY_MSEC;
	ldi R24,150
	ldi R25,0
	movw R12,R24
	.dbline 507
; 
; 	// if rotation direction is anti-clockwise rot_dir = 0 else rot_dir = 1
; 	step_side = step_side*(1 - 2*rot_dir);
	mov R2,R22
	clr R3
	lsl R2
	rol R3
	ldi R18,1
	ldi R19,0
	sub R18,R2
	sbc R19,R3
	xcall empy16s
	movw R20,R16
	.dbline 510
;     
;     // The following is done to keep dir3 to the left of dir1 and dir5 to the right of dir1
;     if(dir1%2 == 0) {
	ldi R17,2
	ldd R16,y+5
	xcall mod8u
	tst R16
	breq X20
	xjmp L38
X20:
X18:
	.dbline 510
	.dbline 511
;         swap(&dir2, &dir4);
	movw R18,R28
	subi R18,252  ; offset = 4
	sbci R19,255
	movw R16,R28
	subi R16,253  ; offset = 3
	sbci R17,255
	xcall _swap
	.dbline 512
;         swap(&dir3, &dir5);
	movw R18,R28
	subi R18,254  ; offset = 2
	sbci R19,255
	movw R16,R28
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall _swap
	.dbline 513
;     }
	xjmp L38
L37:
	.dbline 514
;     while (steps-- > 0) {
	.dbline 516
;         //picking up first duplet
;         angle(dir1, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+5
	xcall _angle
	.dbline 517
;         angle(dir6, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	mov R16,R14
	xcall _angle
	.dbline 519
;     
;         delay(delay_time);
	movw R16,R12
	xcall _delay
	.dbline 522
; 
;         //moving body on second duplet
;         angle(dir2, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 523
;         angle(dir5, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 526
;         
;         //rotating first duplet in air
;         angle(dir1, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+5
	xcall _angle
	.dbline 527
;         angle(dir6, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	mov R16,R14
	xcall _angle
	.dbline 529
;         
;         delay(delay_time);
	movw R16,R12
	xcall _delay
	.dbline 532
; 
;         //putting down first duplet
;         angle(dir1, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+5
	xcall _angle
	.dbline 533
;         angle(dir6, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	mov R16,R14
	xcall _angle
	.dbline 535
;         
;         delay(HUNDRED_MSEC);
	ldi R16,40
	ldi R17,0
	xcall _delay
	.dbline 538
;         
;         //picking up third duplet
;         angle(dir3, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 539
;         angle(dir4, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 541
;         
; 		delay(delay_time);
	movw R16,R12
	xcall _delay
	.dbline 544
; 
;         //moving the third duplet in air
;         angle(dir3, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 545
;         angle(dir4, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 548
; 
;         //rotating the body on first duplet
;         angle(dir1, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+5
	xcall _angle
	.dbline 549
;         angle(dir6, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	mov R16,R14
	xcall _angle
	.dbline 551
;         
;         delay(delay_time);
	movw R16,R12
	xcall _delay
	.dbline 554
;         
;         //putting down third duplet
;         angle(dir3, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 555
;         angle(dir4, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 557
;         
;         delay(HUNDRED_MSEC);
	ldi R16,40
	ldi R17,0
	xcall _delay
	.dbline 559
; 		//picking up second duplet
;         angle(dir2, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 560
;         angle(dir5, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 562
;         
; 		delay(delay_time);
	movw R16,R12
	xcall _delay
	.dbline 565
; 
;         //moving the second duplet in air
;         angle(dir2, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 566
;         angle(dir5, MOTOR_A, 90 + step_side);
	movw R24,R20
	subi R24,166  ; offset = 90
	sbci R25,255
	std y+0,R24
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 569
; 
;         //rotating the body on third duplet
;         angle(dir3, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 570
;         angle(dir4, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 572
;         
;         delay(delay_time);
	movw R16,R12
	xcall _delay
	.dbline 575
;         
;         //putting down second duplet
;         angle(dir2, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 576
;         angle(dir5, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 578
;         
;         delay(HUNDRED_MSEC);
	ldi R16,40
	ldi R17,0
	xcall _delay
	.dbline 579
;     }
L38:
	.dbline 514
	ldd R2,y+16
	clr R3
	mov R24,R2
	subi R24,1
	std y+16,R24
	ldi R24,0
	cp R24,R2
	brsh X21
	xjmp L37
X21:
X19:
	.dbline -2
L34:
	.dbline 0 ; func end
	adiw R28,6
	xcall pop_xgsetF0FC
	adiw R28,2
	ret
	.dbsym r dir6 14 c
	.dbsym l dir4 4 c
	.dbsym l dir2 3 c
	.dbsym l dir5 2 c
	.dbsym l dir3 1 c
	.dbsym l dir1 5 c
	.dbsym r delay_time 12 I
	.dbsym r lift 10 c
	.dbsym r step_side 20 I
	.dbsym l steps 16 c
	.dbsym r rot_dir 22 c
	.dbend
	.dbfunc e tripod_gait_continuous _tripod_gait_continuous fV
;     delay_time -> R22,R23
;   step_forward -> R14
;           dir6 -> R12
;           dir4 -> y+4
;           dir2 -> y+3
;           dir5 -> y+2
;           dir3 -> y+1
;           lift -> R10
;      step_side -> R20
;          steps -> y+17
;           dir1 -> y+15
	.even
_tripod_gait_continuous::
	xcall push_arg4
	xcall push_xgsetF0FC
	sbiw R28,5
	.dbline -1
	.dbline 590
; }
; 
; /**
; Tripod gait moves the hexapod in the direction dir1 for steps.
; Three legs forming a tripod move first then the other three legs move  
; Used for normal gait of the hexapod
; @param dir1 : Direction of motion
; @param steps : number of steps
; */
; void tripod_gait_continuous(unsigned char dir1, unsigned char steps) 
; {
	.dbline 591
;     unsigned char dir3 = ((dir1 + 1) % 6) + 1;
	ldi R17,6
	ldd R16,y+15
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+1,R24
	.dbline 592
;     unsigned char dir5 = ((dir3 + 1) % 6) + 1;
	ldi R17,6
	mov R16,R24
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+2,R24
	.dbline 593
;     unsigned char dir2 = 7 - dir5;
	mov R2,R24
	ldi R24,7
	sub R24,R2
	std y+3,R24
	.dbline 594
;     unsigned char dir4 = 7 - dir3;
	ldd R2,y+1
	ldi R24,7
	sub R24,R2
	std y+4,R24
	.dbline 595
;     unsigned char dir6 = 7 - dir1;
	ldi R24,7
	mov R12,R24
	ldd R0,y+15
	sub R12,R0
	.dbline 596
;     unsigned char step_forward = 50 * movementScaling;
	ldi R16,<L16
	ldi R17,>L16
	xcall elpm32
	ldi R24,<_movementScaling
	ldi R25,>_movementScaling
	st -y,R25
	st -y,R24
	xcall fpmule1
	xcall fpint
	mov R14,R16
	.dbline 597
;     unsigned char step_side = 55 * movementScaling;
	ldi R16,<L41
	ldi R17,>L41
	xcall elpm32
	ldi R24,<_movementScaling
	ldi R25,>_movementScaling
	st -y,R25
	st -y,R24
	xcall fpmule1
	xcall fpint
	mov R20,R16
	.dbline 598
;     unsigned char lift = 40;
	ldi R24,40
	mov R10,R24
	.dbline 599
;     int delay_time = 150;//TWO_HUNDRED_FIFTY_MSEC;
	ldi R22,150
	ldi R23,0
	.dbline 602
;     
;     // The following is done to keep dir3 to the left of dir1 and dir5 to the right of dir1
;     if(dir1%2 == 0) 
	ldi R17,2
	ldd R16,y+15
	xcall mod8u
	tst R16
	breq X24
	xjmp L45
X24:
X22:
	.dbline 603
; 	{
	.dbline 604
;         swap(&dir2, &dir4);
	movw R18,R28
	subi R18,252  ; offset = 4
	sbci R19,255
	movw R16,R28
	subi R16,253  ; offset = 3
	sbci R17,255
	xcall _swap
	.dbline 605
;         swap(&dir3, &dir5);      
	movw R18,R28
	subi R18,254  ; offset = 2
	sbci R19,255
	movw R16,R28
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall _swap
	.dbline 606
;     }
	xjmp L45
L44:
	.dbline 609
;     	
;     while (steps-- > 0) 
; 	{        
	.dbline 611
;         //picking up even tripod
;         angle(dir2, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 612
;         angle(dir4, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 613
;         angle(dir6, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	mov R16,R12
	xcall _angle
	.dbline 615
;     
;         delay(delay_time);
	movw R16,R22
	xcall _delay
	.dbline 618
; 
;         //moving body on odd tripod
;         angle(dir1, MOTOR_C, 90 - step_forward);
	ldi R24,90
	sub R24,R14
	std y+0,R24
	ldi R18,67
	ldd R16,y+15
	xcall _angle
	.dbline 619
;         angle(dir3, MOTOR_A, 90 + step_side);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 620
;         angle(dir5, MOTOR_A, 90 - step_side);
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 623
;         
;         //moving legs even forward in air
;         angle(dir2, MOTOR_A, 90 - step_side);
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 624
;         angle(dir4, MOTOR_A, 90 + step_side);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 625
;         angle(dir6, MOTOR_C, 90 - step_forward);
	ldi R24,90
	sub R24,R14
	std y+0,R24
	ldi R18,67
	mov R16,R12
	xcall _angle
	.dbline 627
;         
;         delay(delay_time);
	movw R16,R22
	xcall _delay
	.dbline 630
; 
;         //putting down even legs
;         angle(dir2, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 631
;         angle(dir4, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 632
;         angle(dir6, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	mov R16,R12
	xcall _angle
	.dbline 634
;         
;         delay(HUNDRED_MSEC);
	ldi R16,40
	ldi R17,0
	xcall _delay
	.dbline 637
;         
;         //picking up odd legs
;         angle(dir1, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+15
	xcall _angle
	.dbline 638
;         angle(dir3, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 639
;         angle(dir5, MOTOR_B, lift);
	std y+0,R10
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 640
;         delay(delay_time);
	movw R16,R22
	xcall _delay
	.dbline 643
; 
;         //moving the odd legs in air
;         angle(dir1, MOTOR_C, 90 + step_forward);
	mov R24,R14
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,67
	ldd R16,y+15
	xcall _angle
	.dbline 644
;         angle(dir3, MOTOR_A, 90 - step_side);
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 645
;         angle(dir5, MOTOR_A, 90 + step_side);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 648
; 
;         //moving the body forward on even tripod
;         angle(dir2, MOTOR_A, 90 + step_side);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 649
;         angle(dir4, MOTOR_A, 90 - step_side);
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 650
;         angle(dir6, MOTOR_C, 90 + step_forward);
	mov R24,R14
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,67
	mov R16,R12
	xcall _angle
	.dbline 652
;         
;         delay(delay_time);
	movw R16,R22
	xcall _delay
	.dbline 655
;         
;         //putting down odd tripod
;         angle(dir1, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+15
	xcall _angle
	.dbline 656
;         angle(dir3, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 657
;         angle(dir5, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 659
;         
;         delay(HUNDRED_MSEC);
	ldi R16,40
	ldi R17,0
	xcall _delay
	.dbline 660
;     }
L45:
	.dbline 608
	ldd R2,y+17
	clr R3
	mov R24,R2
	subi R24,1
	std y+17,R24
	ldi R24,0
	cp R24,R2
	brsh X25
	xjmp L44
X25:
X23:
	.dbline -2
L40:
	.dbline 0 ; func end
	adiw R28,5
	xcall pop_xgsetF0FC
	adiw R28,4
	ret
	.dbsym r delay_time 22 I
	.dbsym r step_forward 14 c
	.dbsym r dir6 12 c
	.dbsym l dir4 4 c
	.dbsym l dir2 3 c
	.dbsym l dir5 2 c
	.dbsym l dir3 1 c
	.dbsym r lift 10 c
	.dbsym r step_side 20 c
	.dbsym l steps 17 c
	.dbsym l dir1 15 c
	.dbend
	.dbfunc e tripod_gait_insect_continuous _tripod_gait_insect_continuous fV
;     delay_time -> R10,R11
;      step_side -> R20
; step_front_backward -> R14
; step_front_forward -> R12
;           dir6 -> y+5
;           dir4 -> y+4
;           dir2 -> y+3
;           dir5 -> y+2
;           dir3 -> y+1
;           lift -> R22
;          steps -> y+18
;           dir1 -> y+16
	.even
_tripod_gait_insect_continuous::
	xcall push_arg4
	xcall push_xgsetF0FC
	sbiw R28,6
	.dbline -1
	.dbline 671
; }
; 
; /**
; Tripod gait moves the hexapod in the direction dir1 for steps.
; Three legs forming a tripod move first then the other three legs move  
; Used for normal gait of the hexapod
; @param dir1 : Direction of motion
; @param steps : number of steps
; */
; void tripod_gait_insect_continuous(unsigned char dir1, unsigned char steps) 
; {
	.dbline 672
;     unsigned char dir3 = ((dir1 + 1) % 6) + 1;
	ldi R17,6
	ldd R16,y+16
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+1,R24
	.dbline 673
;     unsigned char dir5 = ((dir3 + 1) % 6) + 1;
	ldi R17,6
	mov R16,R24
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+2,R24
	.dbline 674
;     unsigned char dir2 = 7 - dir5;
	mov R2,R24
	ldi R24,7
	sub R24,R2
	std y+3,R24
	.dbline 675
;     unsigned char dir4 = 7 - dir3;
	ldd R2,y+1
	ldi R24,7
	sub R24,R2
	std y+4,R24
	.dbline 676
;     unsigned char dir6 = 7 - dir1;
	ldi R24,7
	ldd R0,y+16
	sub R24,R0
	std y+5,R24
	.dbline 677
; 	unsigned char step_front_forward = 30 * movementScaling;
	ldi R16,<L48
	ldi R17,>L48
	xcall elpm32
	ldi R24,<_movementScaling
	ldi R25,>_movementScaling
	st -y,R25
	st -y,R24
	xcall fpmule1
	xcall fpint
	mov R12,R16
	.dbline 678
;     unsigned char step_front_backward = 70 * movementScaling;
	ldi R16,<L49
	ldi R17,>L49
	xcall elpm32
	ldi R24,<_movementScaling
	ldi R25,>_movementScaling
	st -y,R25
	st -y,R24
	xcall fpmule1
	xcall fpint
	mov R14,R16
	.dbline 679
;     unsigned char step_side =40 * movementScaling;
	ldi R16,<L17
	ldi R17,>L17
	xcall elpm32
	ldi R24,<_movementScaling
	ldi R25,>_movementScaling
	st -y,R25
	st -y,R24
	xcall fpmule1
	xcall fpint
	mov R20,R16
	.dbline 680
;     unsigned char lift = 40;
	ldi R22,40
	.dbline 681
;     int delay_time = 150;//TWO_HUNDRED_FIFTY_MSEC;
	ldi R24,150
	ldi R25,0
	movw R10,R24
	.dbline 684
;     
;     // The following is done to keep dir3 to the left of dir1 and dir5 to the right of dir1
;     if(dir1%2 == 0) 
	ldi R17,2
	ldd R16,y+16
	xcall mod8u
	tst R16
	breq X28
	xjmp L53
X28:
X26:
	.dbline 685
; 	{
	.dbline 686
;         swap(&dir2, &dir4);
	movw R18,R28
	subi R18,252  ; offset = 4
	sbci R19,255
	movw R16,R28
	subi R16,253  ; offset = 3
	sbci R17,255
	xcall _swap
	.dbline 687
;         swap(&dir3, &dir5);      
	movw R18,R28
	subi R18,254  ; offset = 2
	sbci R19,255
	movw R16,R28
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall _swap
	.dbline 688
;     }
	xjmp L53
L52:
	.dbline 691
;     
; 	while (steps-- > 0) 
; 	{        
	.dbline 693
;         //picking up even tripod
;         angle(dir2, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 694
;         angle(dir4, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 695
;         angle(dir6, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+5
	xcall _angle
	.dbline 697
;     
;         delay(delay_time);
	movw R16,R10
	xcall _delay
	.dbline 700
; 
;         //moving body on odd tripod
;         angle(dir1, MOTOR_A, 90 - step_front_backward);
	ldi R24,90
	sub R24,R14
	std y+0,R24
	ldi R18,65
	ldd R16,y+16
	xcall _angle
	.dbline 701
;         angle(dir3, MOTOR_A, 90 + step_side);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 702
;         angle(dir5, MOTOR_A, 90 - step_front_forward);
	ldi R24,90
	sub R24,R12
	std y+0,R24
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 705
;         
;         //moving legs even forward in air
;         angle(dir2, MOTOR_A, 90 - step_front_forward);
	ldi R24,90
	sub R24,R12
	std y+0,R24
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 706
;         angle(dir4, MOTOR_A, 90 + step_side);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 707
;         angle(dir6, MOTOR_A, 90 - step_front_backward);
	ldi R24,90
	sub R24,R14
	std y+0,R24
	ldi R18,65
	ldd R16,y+5
	xcall _angle
	.dbline 709
;         
;         delay(delay_time);
	movw R16,R10
	xcall _delay
	.dbline 712
; 
;         //putting down even legs
;         angle(dir2, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+3
	xcall _angle
	.dbline 713
;         angle(dir4, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+4
	xcall _angle
	.dbline 714
;         angle(dir6, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+5
	xcall _angle
	.dbline 716
;         
;         delay(HUNDRED_MSEC);
	ldi R16,40
	ldi R17,0
	xcall _delay
	.dbline 719
;         
;         //picking up odd legs
;         angle(dir1, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+16
	xcall _angle
	.dbline 720
;         angle(dir3, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 721
;         angle(dir5, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 722
;         delay(delay_time);
	movw R16,R10
	xcall _delay
	.dbline 725
; 
;         //moving the odd legs in air
;         angle(dir1, MOTOR_A, 90 + step_front_forward);
	mov R24,R12
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+16
	xcall _angle
	.dbline 726
;         angle(dir3, MOTOR_A, 90 - step_side);
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,65
	ldd R16,y+1
	xcall _angle
	.dbline 727
;         angle(dir5, MOTOR_A, 90 + step_front_backward);
	mov R24,R14
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+2
	xcall _angle
	.dbline 730
; 
;         //moving the body forward on even tripod
;         angle(dir2, MOTOR_A, 90 + step_front_backward);
	mov R24,R14
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+3
	xcall _angle
	.dbline 731
;         angle(dir4, MOTOR_A, 90 - step_side);
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,65
	ldd R16,y+4
	xcall _angle
	.dbline 732
;         angle(dir6, MOTOR_A, 90 + step_front_forward);
	mov R24,R12
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+5
	xcall _angle
	.dbline 734
;         
;         delay(delay_time);
	movw R16,R10
	xcall _delay
	.dbline 737
;         
;         //putting down odd tripod
;         angle(dir1, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+16
	xcall _angle
	.dbline 738
;         angle(dir3, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+1
	xcall _angle
	.dbline 739
;         angle(dir5, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+2
	xcall _angle
	.dbline 741
;         
;         delay(HUNDRED_MSEC);
	ldi R16,40
	ldi R17,0
	xcall _delay
	.dbline 742
;     }
L53:
	.dbline 690
	ldd R2,y+18
	clr R3
	mov R24,R2
	subi R24,1
	std y+18,R24
	ldi R24,0
	cp R24,R2
	brsh X29
	xjmp L52
X29:
X27:
	.dbline -2
L47:
	.dbline 0 ; func end
	adiw R28,6
	xcall pop_xgsetF0FC
	adiw R28,4
	ret
	.dbsym r delay_time 10 I
	.dbsym r step_side 20 c
	.dbsym r step_front_backward 14 c
	.dbsym r step_front_forward 12 c
	.dbsym l dir6 5 c
	.dbsym l dir4 4 c
	.dbsym l dir2 3 c
	.dbsym l dir5 2 c
	.dbsym l dir3 1 c
	.dbsym r lift 22 c
	.dbsym l steps 18 c
	.dbsym l dir1 16 c
	.dbend
	.area lit(rom, con, rel)
L56:
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\gait.c
	.dbfunc e wave_gait _wave_gait fV
;              i -> R22,R23
;              j -> R14,R15
;              k -> R10,R11
;           dir6 -> R10
;           dir4 -> R14
;           dir2 -> R12
;      step_side -> R22
;           dir5 -> y+35
;           dir3 -> y+34
;   step_forward -> R20
;           lift -> y+33
;     delay_time -> y+31
;   leg_distance -> y+19
;      leg_order -> y+13
;    leg_current -> y+1
;          steps -> y+48
;           dir1 -> y+46
	.even
_wave_gait::
	xcall push_arg4
	xcall push_xgsetF0FC
	sbiw R28,36
	.dbline -1
	.dbline 747
; }
; 
; 
; void wave_gait(unsigned char dir1, int steps) 
; {
	.dbline 748
; 	 unsigned char dir3 = ((dir1 + 1) % 6) + 1;
	ldi R17,6
	ldd R16,y+46
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+34,R24
	.dbline 749
;      unsigned char dir5 = ((dir3 + 1) % 6) + 1;
	ldi R17,6
	mov R16,R24
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+35,R24
	.dbline 750
;      unsigned char dir2 = 7 - dir5;
	ldi R24,7
	mov R12,R24
	ldd R0,y+35
	sub R12,R0
	.dbline 751
;      unsigned char dir4 = 7 - dir3;
	mov R14,R24
	ldd R0,y+34
	sub R14,R0
	.dbline 752
;      unsigned char dir6 = 7 - dir1;
	mov R10,R24
	ldd R0,y+46
	sub R10,R0
	.dbline 754
; 	 
;      unsigned char step_forward = 70;
	ldi R20,70
	.dbline 755
;      unsigned char step_side = 50;
	ldi R22,50
	.dbline 756
;      unsigned char lift = 40;
	ldi R24,40
	std y+33,R24
	.dbline 757
;      int delay_time = 100;
	ldi R24,100
	ldi R25,0
	std y+32,R25
	std y+31,R24
	.dbline 761
; 	 
; 	 unsigned char leg_order[6];
; 	 int leg_distance[6];
; 	 int leg_current[] = {0, 0, 0, 0, 0, 0};
	ldi R24,<L56
	ldi R25,>L56
	movw R30,R28
	adiw R30,1
	ldi R16,12
	ldi R17,0
	st -y,R31
	st -y,R30
	st -y,R25
	st -y,R24
	xcall asgncblkx
	.dbline 763
; 	 
; 	 leg_order[0] = dir1;
	ldd R0,y+46
	std y+13,R0
	.dbline 764
; 	 leg_order[1] = dir2;
	std y+14,R12
	.dbline 765
; 	 leg_order[2] = dir3;
	ldd R0,y+34
	std y+15,R0
	.dbline 766
; 	 leg_order[3] = dir4;
	std y+16,R14
	.dbline 767
; 	 leg_order[4] = dir5;
	ldd R0,y+35
	std y+17,R0
	.dbline 768
; 	 leg_order[5] = dir6;
	std y+18,R10
	.dbline 770
; 	 
; 	 leg_distance[0] = -step_forward;
	mov R24,R20
	clr R25
	com R24
	com R25
	subi R24,0xFF
	sbci R25,0xFF
	std y+20,R25
	std y+19,R24
	.dbline 771
; 	 leg_distance[1] = -step_side;
	mov R24,R22
	clr R25
	com R24
	com R25
	subi R24,0xFF
	sbci R25,0xFF
	std y+22,R25
	std y+21,R24
	.dbline 772
; 	 leg_distance[2] = -step_forward;
	mov R24,R20
	clr R25
	com R24
	com R25
	subi R24,0xFF
	sbci R25,0xFF
	std y+24,R25
	std y+23,R24
	.dbline 773
; 	 leg_distance[3] = step_forward;
	mov R2,R20
	clr R3
	std y+26,R3
	std y+25,R2
	.dbline 774
; 	 leg_distance[4] = step_side;
	mov R2,R22
	clr R3
	std y+28,R3
	std y+27,R2
	.dbline 775
; 	 leg_distance[5] = step_forward;
	mov R2,R20
	clr R3
	std y+30,R3
	std y+29,R2
	xjmp L68
L67:
	.dbline 778
; 	
; 	 while(steps-- > 0) 
; 	 {
	.dbline 780
; 	 	    int i, j, k;
; 			for (i = 0; i < 6; i++){
	clr R22
	clr R23
L70:
	.dbline 780
	.dbline 782
; 				//putting down leg i and pick up leg i+1
; 				angle(leg_order[i], MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	movw R24,R28
	adiw R24,13
	movw R30,R22
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 783
; 				angle(leg_order[(i+1) % 6], MOTOR_B, lift);
	ldd R0,y+33
	std y+0,R0
	ldi R18,66
	ldi R24,6
	ldi R25,0
	movw R16,R22
	subi R16,255  ; offset = 1
	sbci R17,255
	push R18
	push R19
	movw R18,R24
	xcall mod16s
	movw R30,R16
	pop R19
	pop R18
	movw R24,R28
	adiw R24,13
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 785
; 			
; 				delay(delay_time);
	ldd R16,y+31
	ldd R17,y+32
	xcall _delay
	.dbline 788
; 						
; 				//moving body on leg i and move leg i+1 in air
; 				leg_current[(i+1) % 6] = 90 + leg_distance[(i+1) % 6];
	ldi R18,6
	ldi R19,0
	movw R16,R22
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall mod16s
	movw R2,R16
	lsl R2
	rol R3
	movw R24,R28
	adiw R24,19
	movw R30,R2
	add R30,R24
	adc R31,R25
	ldd R24,z+0
	ldd R25,z+1
	subi R24,166  ; offset = 90
	sbci R25,255
	movw R30,R28
	adiw R30,1
	movw R26,R2
	add R26,R30
	adc R27,R31
	st x+,R24
	st x,R25
	.dbline 789
; 				angle(leg_order[(i+1) % 6], MOTOR_A, leg_current[(i+1) % 6]);
	ldi R18,6
	ldi R19,0
	movw R16,R22
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall mod16s
	movw R24,R28
	adiw R24,1
	movw R30,R16
	lsl R30
	rol R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	ldd R3,z+1
	std y+0,R2
	ldi R18,65
	movw R24,R28
	adiw R24,13
	movw R30,R16
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 790
; 				for (j = 1; j <= 5; j++){
	ldi R24,1
	ldi R25,0
	movw R14,R24
L74:
	.dbline 790
	.dbline 791
; 					k =  (i + 1 + j) % 6;
	movw R16,R22
	subi R16,255  ; offset = 1
	sbci R17,255
	add R16,R14
	adc R17,R15
	ldi R18,6
	ldi R19,0
	xcall mod16s
	movw R10,R16
	.dbline 792
; 					leg_current[k] = leg_current[k] - (2 * leg_distance[k]) / 5;
	movw R20,R10
	lsl R20
	rol R21
	movw R24,R28
	adiw R24,1
	movw R12,R20
	add R12,R24
	adc R13,R25
	movw R24,R28
	adiw R24,19
	movw R30,R20
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	ldd R17,z+1
	lsl R16
	rol R17
	ldi R18,5
	ldi R19,0
	xcall div16s
	movw R30,R12
	ldd R2,z+0
	ldd R3,z+1
	sub R2,R16
	sbc R3,R17
	std z+1,R3
	std z+0,R2
	.dbline 793
; 					angle(leg_order[k], MOTOR_A, leg_current[k]);
	movw R24,R28
	adiw R24,1
	movw R30,R10
	lsl R30
	rol R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	ldd R3,z+1
	std y+0,R2
	ldi R18,65
	movw R24,R28
	adiw R24,13
	movw R30,R10
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 794
; 				}
L75:
	.dbline 790
	movw R24,R14
	adiw R24,1
	movw R14,R24
	.dbline 790
	ldi R24,5
	ldi R25,0
	cp R24,R14
	cpc R25,R15
	brlt X33
	xjmp L74
X33:
X30:
	.dbline 795
; 				delay(delay_time);
	ldd R16,y+31
	ldd R17,y+32
	xcall _delay
	.dbline 796
; 			}
L71:
	.dbline 780
	subi R22,255  ; offset = 1
	sbci R23,255
	.dbline 780
	cpi R22,6
	ldi R30,0
	cpc R23,R30
	brge X34
	xjmp L70
X34:
X31:
	.dbline 798
; 			
; 			angle(leg_order[i % 6], MOTOR_B, 90);			
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldi R24,6
	ldi R25,0
	push R18
	push R19
	movw R18,R24
	movw R16,R22
	xcall mod16s
	movw R30,R16
	pop R19
	pop R18
	movw R24,R28
	adiw R24,13
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 799
; 			delay(delay_time);
	ldd R16,y+31
	ldd R17,y+32
	xcall _delay
	.dbline 800
; 	}
L68:
	.dbline 777
	ldd R22,y+48
	ldd R23,y+49
	movw R24,R22
	sbiw R24,1
	std y+49,R25
	std y+48,R24
	clr R2
	clr R3
	cp R2,R22
	cpc R3,R23
	brge X35
	xjmp L67
X35:
X32:
	.dbline -2
L55:
	.dbline 0 ; func end
	adiw R28,36
	xcall pop_xgsetF0FC
	adiw R28,4
	ret
	.dbsym r i 22 I
	.dbsym r j 14 I
	.dbsym r k 10 I
	.dbsym r dir6 10 c
	.dbsym r dir4 14 c
	.dbsym r dir2 12 c
	.dbsym r step_side 22 c
	.dbsym l dir5 35 c
	.dbsym l dir3 34 c
	.dbsym r step_forward 20 c
	.dbsym l lift 33 c
	.dbsym l delay_time 31 I
	.dbsym l leg_distance 19 A[12:6]I
	.dbsym l leg_order 13 A[6:6]c
	.dbsym l leg_current 1 A[12:6]I
	.dbsym l steps 48 I
	.dbsym l dir1 46 c
	.dbend
	.area lit(rom, con, rel)
L79:
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\gait.c
	.dbfunc e ripple_gait _ripple_gait fV
;              i -> R12,R13
;              j -> R14,R15
;              k -> R22,R23
;           dir6 -> R10
;           dir4 -> R14
;           dir2 -> R12
;      step_side -> R22
;           dir5 -> y+37
;           dir3 -> y+36
;   step_forward -> R20
;    delay_time2 -> y+34
;           lift -> y+33
;    delay_time1 -> y+31
;   leg_distance -> y+19
;      leg_order -> y+13
;    leg_current -> y+1
;          steps -> y+50
;           dir1 -> y+48
	.even
_ripple_gait::
	xcall push_arg4
	xcall push_xgsetF0FC
	sbiw R28,38
	.dbline -1
	.dbline 805
; }
; 
; 
; void ripple_gait(unsigned char dir1, int steps) 
; {
	.dbline 806
;      unsigned char dir3 = ((dir1 + 1) % 6) + 1;
	ldi R17,6
	ldd R16,y+48
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+36,R24
	.dbline 807
;      unsigned char dir5 = ((dir3 + 1) % 6) + 1;
	ldi R17,6
	mov R16,R24
	subi R16,255    ; addi 1
	xcall mod8u
	mov R24,R16
	subi R24,255    ; addi 1
	std y+37,R24
	.dbline 808
;      unsigned char dir2 = 7 - dir5;
	ldi R24,7
	mov R12,R24
	ldd R0,y+37
	sub R12,R0
	.dbline 809
;      unsigned char dir4 = 7 - dir3;
	mov R14,R24
	ldd R0,y+36
	sub R14,R0
	.dbline 810
;      unsigned char dir6 = 7 - dir1;
	mov R10,R24
	ldd R0,y+48
	sub R10,R0
	.dbline 812
; 
;      unsigned char step_forward = 50;
	ldi R20,50
	.dbline 813
;      unsigned char step_side = 40;
	ldi R22,40
	.dbline 814
;      unsigned char lift = 40;
	ldi R24,40
	std y+33,R24
	.dbline 815
;      int delay_time1 = 100;
	ldi R24,100
	ldi R25,0
	std y+32,R25
	std y+31,R24
	.dbline 816
; 	 int delay_time2 = 100;
	std y+35,R25
	std y+34,R24
	.dbline 820
; 	 
; 	 unsigned char leg_order[6];
; 	 int leg_distance[6];
; 	 int leg_current[] = {0, 0, 0, 0, 0, 0};
	ldi R24,<L79
	ldi R25,>L79
	movw R30,R28
	adiw R30,1
	ldi R16,12
	ldi R17,0
	st -y,R31
	st -y,R30
	st -y,R25
	st -y,R24
	xcall asgncblkx
	.dbline 822
; 	 
; 	 leg_order[0] = dir1;
	ldd R0,y+48
	std y+13,R0
	.dbline 823
; 	 leg_order[1] = dir2;
	std y+14,R12
	.dbline 824
; 	 leg_order[2] = dir3;
	ldd R0,y+36
	std y+15,R0
	.dbline 825
; 	 leg_order[3] = dir4;
	std y+16,R14
	.dbline 826
; 	 leg_order[4] = dir5;
	ldd R0,y+37
	std y+17,R0
	.dbline 827
; 	 leg_order[5] = dir6;
	std y+18,R10
	.dbline 829
; 	 
; 	 leg_distance[0] = -step_forward;
	mov R24,R20
	clr R25
	com R24
	com R25
	subi R24,0xFF
	sbci R25,0xFF
	std y+20,R25
	std y+19,R24
	.dbline 830
; 	 leg_distance[1] = -step_side;
	mov R24,R22
	clr R25
	com R24
	com R25
	subi R24,0xFF
	sbci R25,0xFF
	std y+22,R25
	std y+21,R24
	.dbline 831
; 	 leg_distance[2] = -step_forward;
	mov R24,R20
	clr R25
	com R24
	com R25
	subi R24,0xFF
	sbci R25,0xFF
	std y+24,R25
	std y+23,R24
	.dbline 832
; 	 leg_distance[3] = step_forward;
	mov R2,R20
	clr R3
	std y+26,R3
	std y+25,R2
	.dbline 833
; 	 leg_distance[4] = step_side;
	mov R2,R22
	clr R3
	std y+28,R3
	std y+27,R2
	.dbline 834
; 	 leg_distance[5] = step_forward;
	mov R2,R20
	clr R3
	std y+30,R3
	std y+29,R2
	xjmp L91
L90:
	.dbline 837
; 	
; 	 while(steps-- > 0) 
; 	 {
	.dbline 839
; 	 	    int i, j, k;
; 			for (i = 0; i < 3; i++)
	clr R12
	clr R13
L93:
	.dbline 840
; 			{
	.dbline 842
; 				//putting down leg i and pick up leg i+1
; 				angle(leg_order[i], MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	movw R24,R28
	adiw R24,13
	movw R30,R12
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 843
; 				angle(leg_order[(i+1) % 3], MOTOR_B, lift);
	ldd R0,y+33
	std y+0,R0
	ldi R18,66
	ldi R24,3
	ldi R25,0
	movw R16,R12
	subi R16,255  ; offset = 1
	sbci R17,255
	push R18
	push R19
	movw R18,R24
	xcall mod16s
	movw R30,R16
	pop R19
	pop R18
	movw R24,R28
	adiw R24,13
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 845
; 
; 				delay(delay_time1);
	ldd R16,y+31
	ldd R17,y+32
	xcall _delay
	.dbline 847
; 				
; 				angle(leg_order[((i+2) % 3) + 3], MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldi R24,3
	ldi R25,0
	movw R16,R12
	subi R16,254  ; offset = 2
	sbci R17,255
	push R18
	push R19
	movw R18,R24
	xcall mod16s
	movw R30,R16
	pop R19
	pop R18
	movw R24,R28
	adiw R24,16
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 848
; 				angle(leg_order[(i % 3) + 3], MOTOR_B, lift);
	ldd R0,y+33
	std y+0,R0
	ldi R18,66
	ldi R24,3
	ldi R25,0
	push R18
	push R19
	movw R18,R24
	movw R16,R12
	xcall mod16s
	movw R30,R16
	pop R19
	pop R18
	movw R24,R28
	adiw R24,16
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 850
; 			
; 				delay(delay_time2);
	ldd R16,y+34
	ldd R17,y+35
	xcall _delay
	.dbline 853
; 						
; 				//moving body on leg i and move leg i+1 in air
; 				leg_current[(i+1) % 3] = 90 + leg_distance[(i+1) % 3];
	ldi R18,3
	ldi R19,0
	movw R16,R12
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall mod16s
	movw R2,R16
	lsl R2
	rol R3
	movw R24,R28
	adiw R24,19
	movw R30,R2
	add R30,R24
	adc R31,R25
	ldd R24,z+0
	ldd R25,z+1
	subi R24,166  ; offset = 90
	sbci R25,255
	movw R30,R28
	adiw R30,1
	movw R26,R2
	add R26,R30
	adc R27,R31
	st x+,R24
	st x,R25
	.dbline 854
; 				angle(leg_order[(i+1) % 3], MOTOR_A, leg_current[(i+1) % 3]);
	ldi R18,3
	ldi R19,0
	movw R16,R12
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall mod16s
	movw R24,R28
	adiw R24,1
	movw R30,R16
	lsl R30
	rol R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	ldd R3,z+1
	std y+0,R2
	ldi R18,65
	movw R24,R28
	adiw R24,13
	movw R30,R16
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 855
; 				for (j = 1; j <= 2; j++)
	ldi R24,1
	ldi R25,0
	movw R14,R24
L99:
	.dbline 856
; 				{
	.dbline 857
; 					k =  (i + 1 + j) % 3;
	movw R16,R12
	subi R16,255  ; offset = 1
	sbci R17,255
	add R16,R14
	adc R17,R15
	ldi R18,3
	ldi R19,0
	xcall mod16s
	movw R22,R16
	.dbline 858
; 					leg_current[k] = leg_current[k] - leg_distance[k];
	movw R20,R22
	lsl R20
	rol R21
	movw R24,R28
	adiw R24,1
	movw R10,R20
	add R10,R24
	adc R11,R25
	movw R24,R28
	adiw R24,19
	movw R30,R20
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	ldd R3,z+1
	movw R30,R10
	ldd R4,z+0
	ldd R5,z+1
	sub R4,R2
	sbc R5,R3
	std z+1,R5
	std z+0,R4
	.dbline 859
; 					angle(leg_order[k], MOTOR_A, leg_current[k]);
	movw R24,R28
	adiw R24,1
	movw R30,R22
	lsl R30
	rol R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	ldd R3,z+1
	std y+0,R2
	ldi R18,65
	movw R24,R28
	adiw R24,13
	movw R30,R22
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 860
; 				}
L100:
	.dbline 855
	movw R24,R14
	adiw R24,1
	movw R14,R24
	.dbline 855
	ldi R24,2
	ldi R25,0
	cp R24,R14
	cpc R25,R15
	brlt X40
	xjmp L99
X40:
X36:
	.dbline 862
; 
; 				delay(delay_time1);
	ldd R16,y+31
	ldd R17,y+32
	xcall _delay
	.dbline 864
; 				
; 				leg_current[(i % 3) + 3] = 90 + leg_distance[(i % 3) + 3];
	ldi R18,3
	ldi R19,0
	movw R16,R12
	xcall mod16s
	movw R24,R16
	adiw R24,3
	movw R10,R24
	lsl R10
	rol R11
	movw R24,R28
	adiw R24,19
	movw R30,R10
	add R30,R24
	adc R31,R25
	ldd R24,z+0
	ldd R25,z+1
	subi R24,166  ; offset = 90
	sbci R25,255
	movw R30,R28
	adiw R30,1
	movw R26,R10
	add R26,R30
	adc R27,R31
	st x+,R24
	st x,R25
	.dbline 865
; 				angle(leg_order[(i % 3) + 3], MOTOR_A, leg_current[(i % 3) + 3]);
	ldi R18,3
	ldi R19,0
	movw R16,R12
	xcall mod16s
	movw R20,R16
	movw R24,R28
	adiw R24,1
	movw R30,R20
	adiw R30,3
	lsl R30
	rol R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	ldd R3,z+1
	std y+0,R2
	ldi R18,65
	movw R24,R28
	adiw R24,16
	movw R30,R20
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 866
; 				for (j = 1; j <= 2 ; j++)
	ldi R24,1
	ldi R25,0
	movw R14,R24
L104:
	.dbline 867
; 				{
	.dbline 868
; 					k =  ((i + j) % 3) + 3;
	movw R16,R12
	add R16,R14
	adc R17,R15
	ldi R18,3
	ldi R19,0
	xcall mod16s
	movw R22,R16
	subi R22,253  ; offset = 3
	sbci R23,255
	.dbline 869
; 					leg_current[k] = leg_current[k] - leg_distance[k];
	movw R10,R22
	lsl R10
	rol R11
	movw R24,R28
	adiw R24,1
	movw R20,R10
	add R20,R24
	adc R21,R25
	movw R24,R28
	adiw R24,19
	movw R30,R10
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	ldd R3,z+1
	movw R30,R20
	ldd R4,z+0
	ldd R5,z+1
	sub R4,R2
	sbc R5,R3
	std z+1,R5
	std z+0,R4
	.dbline 870
; 					angle(leg_order[k], MOTOR_A, leg_current[k]);
	movw R24,R28
	adiw R24,1
	movw R30,R22
	lsl R30
	rol R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	ldd R3,z+1
	std y+0,R2
	ldi R18,65
	movw R24,R28
	adiw R24,13
	movw R30,R22
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 871
; 				}
L105:
	.dbline 866
	movw R24,R14
	adiw R24,1
	movw R14,R24
	.dbline 866
	ldi R24,2
	ldi R25,0
	cp R24,R14
	cpc R25,R15
	brlt X41
	xjmp L104
X41:
X37:
	.dbline 873
; 				
; 				delay(delay_time2);
	ldd R16,y+34
	ldd R17,y+35
	xcall _delay
	.dbline 874
; 			}
L94:
	.dbline 839
	movw R24,R12
	adiw R24,1
	movw R12,R24
	.dbline 839
	cpi R24,3
	ldi R30,0
	cpc R25,R30
	brge X42
	xjmp L93
X42:
X38:
	.dbline 876
; 			
; 			angle(leg_order[(i + 1) % 3], MOTOR_B, 90);			
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldi R24,3
	ldi R25,0
	movw R16,R12
	subi R16,255  ; offset = 1
	sbci R17,255
	push R18
	push R19
	movw R18,R24
	xcall mod16s
	movw R30,R16
	pop R19
	pop R18
	movw R24,R28
	adiw R24,13
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 877
; 			angle(leg_order[(i % 3) + 3], MOTOR_B, 90);			
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldi R24,3
	ldi R25,0
	push R18
	push R19
	movw R18,R24
	movw R16,R12
	xcall mod16s
	movw R30,R16
	pop R19
	pop R18
	movw R24,R28
	adiw R24,16
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	xcall _angle
	.dbline 878
; 			delay(delay_time1);
	ldd R16,y+31
	ldd R17,y+32
	xcall _delay
	.dbline 879
; 	}
L91:
	.dbline 836
	ldd R12,y+50
	ldd R13,y+51
	movw R24,R12
	sbiw R24,1
	std y+51,R25
	std y+50,R24
	clr R2
	clr R3
	cp R2,R12
	cpc R3,R13
	brge X43
	xjmp L90
X43:
X39:
	.dbline -2
L78:
	.dbline 0 ; func end
	adiw R28,38
	xcall pop_xgsetF0FC
	adiw R28,4
	ret
	.dbsym r i 12 I
	.dbsym r j 14 I
	.dbsym r k 22 I
	.dbsym r dir6 10 c
	.dbsym r dir4 14 c
	.dbsym r dir2 12 c
	.dbsym r step_side 22 c
	.dbsym l dir5 37 c
	.dbsym l dir3 36 c
	.dbsym r step_forward 20 c
	.dbsym l delay_time2 34 I
	.dbsym l lift 33 c
	.dbsym l delay_time1 31 I
	.dbsym l leg_distance 19 A[12:6]I
	.dbsym l leg_order 13 A[6:6]c
	.dbsym l leg_current 1 A[12:6]I
	.dbsym l steps 50 I
	.dbsym l dir1 48 c
	.dbend
	.area lit(rom, con, rel)
L49:
	.word 0x0,0x428c
L48:
	.word 0x0,0x41f0
L41:
	.word 0x0,0x425c
L28:
	.word 0x0,0x4234
L17:
	.word 0x0,0x4220
L16:
	.word 0x0,0x4248
; }

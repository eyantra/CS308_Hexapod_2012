	.module hexapod_motions.c
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_motions.c
	.area lit(rom, con, rel)
L2:
	.byte 0,2
	.byte 3,6
	.byte 1,4
	.byte 5
L3:
	.byte 0,4
	.byte 1,2
	.byte 5,6
	.byte 3
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_motions.c
	.dbfunc e pose _pose fV
;           dir6 -> R10
;           dir5 -> y+17
;     spread_out -> R12
;      step_side -> R14
;           lift -> R22
;     legs_clock -> y+8
; legs_anticlock -> y+1
;           dir4 -> y+16
;           dir3 -> y+15
;              i -> R22,R23
;     delay_time -> R20,R21
;          steps -> y+32
;           dir2 -> y+30
;           dir1 -> y+28
	.even
_pose::
	xcall push_arg4
	xcall push_xgsetF0FC
	sbiw R28,18
	.dbline -1
	.dbline 69
; /***
; @author  Srijit Dutt
; Date Sun 07 Nov 2010 02:42:38 PM IST 
; 
; ICCAVR
; 
; hexapod_motions.c : File contains various advanced motion functions for the hexapod
; Please include hexapod_motions.h file to call function from this file
; 
; */
; 
; 
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
; #include "hexapod_macro.h"
; #include "hexapod_basic.h"
; #include "hexapod.h"
; 
; 
; /**
; The hexapod stands on 4 legs with two legs in the air
; and moves its legs
; @param dir1 : The first of the two legs to be in air 
; @param dir2 : The second leg to be in air 
; The legs should be consecutive
; @param steps : The number of time the legs in the air are moved
; */
; void pose(unsigned char dir1, unsigned char dir2, int steps) {
	.dbline 71
; 	 
; 	 unsigned char legs_anticlock[] = {0,2,3,6,1,4,5};
	ldi R24,<L2
	ldi R25,>L2
	movw R30,R28
	adiw R30,1
	ldi R16,7
	ldi R17,0
	st -y,R31
	st -y,R30
	st -y,R25
	st -y,R24
	xcall asgncblkx
	.dbline 72
; 	 unsigned char legs_clock[] = {0,4,1,2,5,6,3}; 
	ldi R24,<L3
	ldi R25,>L3
	movw R30,R28
	adiw R30,8
	ldi R16,7
	ldi R17,0
	st -y,R31
	st -y,R30
	st -y,R25
	st -y,R24
	xcall asgncblkx
	.dbline 73
; 	 unsigned char dir3 = legs_anticlock[dir2];
	movw R24,R28
	adiw R24,1
	ldd R30,y+30
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	std y+15,R2
	.dbline 74
; 	 unsigned char dir4 = legs_clock[dir1];
	movw R24,R28
	adiw R24,8
	ldd R30,y+28
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	std y+16,R2
	.dbline 75
; 	 unsigned char dir5 = legs_clock[dir4];
	movw R24,R28
	adiw R24,8
	mov R30,R2
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	std y+17,R2
	.dbline 76
; 	 unsigned char dir6= legs_anticlock[dir3];
	movw R24,R28
	adiw R24,1
	ldd R30,y+15
	clr R31
	add R30,R24
	adc R31,R25
	ldd R10,z+0
	.dbline 78
; 	 
; 	 unsigned char lift = 40;
	ldi R22,40
	.dbline 79
; 	 unsigned char step_side = 50;
	ldi R24,50
	mov R14,R24
	.dbline 80
; 	 unsigned char spread_out = 60;
	ldi R24,60
	mov R12,R24
	.dbline 81
; 	 int delay_time = FIVE_HUNDRED_MSEC;
	ldi R20,200
	ldi R21,0
	.dbline 85
; 	 int i;
; 	 
; 	 //lifting legs 3 & 4
; 	 angle(dir3, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+15
	xcall _angle
	.dbline 86
; 	 angle(dir4, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldd R16,y+16
	xcall _angle
	.dbline 88
; 	 
; 	 delay(delay_time);
	movw R16,R20
	xcall _delay
	.dbline 91
; 	 
; 	 //moving legs 3 & 4 forward
; 	 angle(dir3, MOTOR_A, 90 - step_side);
	ldi R24,90
	sub R24,R14
	std y+0,R24
	ldi R18,65
	ldd R16,y+15
	xcall _angle
	.dbline 92
; 	 angle(dir4, MOTOR_A, 90 + step_side);
	mov R24,R14
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,65
	ldd R16,y+16
	xcall _angle
	.dbline 93
; 	 angle(dir3, MOTOR_C, 90 + 70);
	ldi R24,160
	std y+0,R24
	ldi R18,67
	ldd R16,y+15
	xcall _angle
	.dbline 94
; 	 angle(dir4, MOTOR_C, 90 + 70);
	ldi R24,160
	std y+0,R24
	ldi R18,67
	ldd R16,y+16
	xcall _angle
	.dbline 98
; 
; 	 
; 	 //spreading legs 5 & 6 out
; 	 angle(dir5, MOTOR_C, 90 + spread_out);
	mov R24,R12
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,67
	ldd R16,y+17
	xcall _angle
	.dbline 99
; 	 angle(dir6, MOTOR_C, 90 + spread_out);
	mov R24,R12
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,67
	mov R16,R10
	xcall _angle
	.dbline 101
; 	 
; 	 delay(delay_time);
	movw R16,R20
	xcall _delay
	.dbline 105
; 	 
; 	 
; 	 //putting down legs 3 & 4
; 	 angle(dir3, MOTOR_B, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,66
	ldd R16,y+15
	xcall _angle
	.dbline 106
; 	 angle(dir4, MOTOR_B, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,66
	ldd R16,y+16
	xcall _angle
	.dbline 108
; 
; 	 delay(delay_time);
	movw R16,R20
	xcall _delay
	.dbline 111
; 	 
; 	 //lifting legs 1 & 2
; 	 angle(dir1, MOTOR_B, 0);
	clr R2
	std y+0,R2
	ldi R18,66
	ldd R16,y+28
	xcall _angle
	.dbline 112
; 	 angle(dir2, MOTOR_B, 0);
	clr R2
	std y+0,R2
	ldi R18,66
	ldd R16,y+30
	xcall _angle
	.dbline 115
; 	 
; 	 //aligning legs 1 & 2
; 	 angle(dir1, MOTOR_A, 150);
	ldi R24,150
	std y+0,R24
	ldi R18,65
	ldd R16,y+28
	xcall _angle
	.dbline 116
; 	 angle(dir2, MOTOR_A, 30);
	ldi R24,30
	std y+0,R24
	ldi R18,65
	ldd R16,y+30
	xcall _angle
	.dbline 120
; 	 
; 	 
; 	 //shaking legs 1 & 2 in air
; 	 for(i = 0; i < steps; i++) {
	clr R22
	clr R23
	xjmp L7
L4:
	.dbline 120
	.dbline 121
; 	 	   angle(dir1, MOTOR_B, 30);
	ldi R24,30
	std y+0,R24
	ldi R18,66
	ldd R16,y+28
	xcall _angle
	.dbline 122
; 		   angle(dir2, MOTOR_B, 30);
	ldi R24,30
	std y+0,R24
	ldi R18,66
	ldd R16,y+30
	xcall _angle
	.dbline 124
; 		   
; 		   delay(delay_time);
	movw R16,R20
	xcall _delay
	.dbline 126
; 		   
; 		   angle(dir1, MOTOR_B, 0);
	clr R2
	std y+0,R2
	ldi R18,66
	ldd R16,y+28
	xcall _angle
	.dbline 127
; 	 	   angle(dir2, MOTOR_B, 0);
	clr R2
	std y+0,R2
	ldi R18,66
	ldd R16,y+30
	xcall _angle
	.dbline 129
; 		   
; 		   delay(delay_time);
	movw R16,R20
	xcall _delay
	.dbline 130
; 	 }
L5:
	.dbline 120
	subi R22,255  ; offset = 1
	sbci R23,255
L7:
	.dbline 120
	ldd R0,y+32
	ldd R1,y+33
	cp R22,R0
	cpc R23,R1
	brlt L4
X0:
	.dbline -2
L1:
	.dbline 0 ; func end
	adiw R28,18
	xcall pop_xgsetF0FC
	adiw R28,4
	ret
	.dbsym r dir6 10 c
	.dbsym l dir5 17 c
	.dbsym r spread_out 12 c
	.dbsym r step_side 14 c
	.dbsym r lift 22 c
	.dbsym l legs_clock 8 A[7:7]c
	.dbsym l legs_anticlock 1 A[7:7]c
	.dbsym l dir4 16 c
	.dbsym l dir3 15 c
	.dbsym r i 22 I
	.dbsym r delay_time 20 I
	.dbsym l steps 32 I
	.dbsym l dir2 30 c
	.dbsym l dir1 28 c
	.dbend
	.area lit(rom, con, rel)
L9:
	.word 0
	.word 6
	.word 5
	.word 4
	.word 3
	.word 2
	.word 1
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_motions.c
	.dbfunc e dance _dance fV
; array_opposite -> y+1
;     delay_time -> R10,R11
;  dir2_opposite -> R22
;  dir1_opposite -> R14
;        stretch -> R20
;          steps -> R12,R13
;           dir2 -> y+27
;           dir1 -> y+25
	.even
_dance::
	xcall push_arg4
	xcall push_xgsetF0FC
	sbiw R28,15
	ldd R12,y+29
	ldd R13,y+30
	.dbline -1
	.dbline 144
; 	 
; 	 //resetting to original position
; 	 //servo_calibration();
; }
; 
; 
; /**
; The hexapod moves its weight from legs dir1, dir2 to legs opposite to dir1, dir2 
; steps : The nummber of steps in the dance move
; @param dir1 : Direction of motion
; @param dir2 : Direction of motion
; @param steps : number of steps
; */
; void dance(unsigned char dir1, unsigned char dir2, int steps) {
	.dbline 145
; 	 int array_opposite[] = {0,6,5,4,3,2,1};
	ldi R24,<L9
	ldi R25,>L9
	movw R30,R28
	adiw R30,1
	ldi R16,14
	ldi R17,0
	st -y,R31
	st -y,R30
	st -y,R25
	st -y,R24
	xcall asgncblkx
	.dbline 146
; 	 unsigned char dir1_opposite = array_opposite[dir1];
	movw R24,R28
	adiw R24,1
	ldd R30,y+25
	clr R31
	lsl R30
	rol R31
	add R30,R24
	adc R31,R25
	ldd R14,z+0
	.dbline 147
; 	 unsigned char dir2_opposite = array_opposite[dir2];
	movw R24,R28
	adiw R24,1
	ldd R30,y+27
	clr R31
	lsl R30
	rol R31
	add R30,R24
	adc R31,R25
	ldd R22,z+0
	.dbline 148
; 	 unsigned char stretch = 90;
	ldi R20,90
	.dbline 149
; 	 int delay_time = FIVE_HUNDRED_MSEC;
	ldi R24,200
	ldi R25,0
	movw R10,R24
	xjmp L11
L10:
	.dbline 151
; 	 
; 	 while(steps-- > 0) {
	.dbline 154
; 	 			   
; 	 	//move towards 6 & 5
; 		angle(dir1, MOTOR_B, 90 + stretch);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,66
	ldd R16,y+25
	xcall _angle
	.dbline 155
; 	 	angle(dir1, MOTOR_C, 90 + 90);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldd R16,y+25
	xcall _angle
	.dbline 156
; 	 	angle(dir1_opposite, MOTOR_B, 90 - stretch); 
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,66
	mov R16,R14
	xcall _angle
	.dbline 157
; 	 	angle(dir1_opposite, MOTOR_C, 90 - stretch);	 
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,67
	mov R16,R14
	xcall _angle
	.dbline 158
; 	 	angle(dir2, MOTOR_B, 90 + stretch);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,66
	ldd R16,y+27
	xcall _angle
	.dbline 159
; 	 	angle(dir2, MOTOR_C, 90 + 90);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldd R16,y+27
	xcall _angle
	.dbline 160
; 	 	angle(dir2_opposite, MOTOR_B, 90 - stretch); 
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,66
	mov R16,R22
	xcall _angle
	.dbline 161
; 	 	angle(dir2_opposite, MOTOR_C, 90 - stretch);
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,67
	mov R16,R22
	xcall _angle
	.dbline 164
; 		
; 		//delay
; 		delay(delay_time);
	movw R16,R10
	xcall _delay
	.dbline 168
; 		
; 		
; 		//move towards 1 & 2
; 		angle(dir1_opposite, MOTOR_B, 90 + stretch);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,66
	mov R16,R14
	xcall _angle
	.dbline 169
; 	 	angle(dir1_opposite, MOTOR_C, 90 + 90);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	mov R16,R14
	xcall _angle
	.dbline 170
; 	 	angle(dir1, MOTOR_B, 90 - stretch); 
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,66
	ldd R16,y+25
	xcall _angle
	.dbline 171
; 	 	angle(dir1, MOTOR_C, 90 - stretch);	 
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,67
	ldd R16,y+25
	xcall _angle
	.dbline 172
; 	 	angle(dir2_opposite, MOTOR_B, 90 + stretch);
	mov R24,R20
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,66
	mov R16,R22
	xcall _angle
	.dbline 173
; 	 	angle(dir2_opposite, MOTOR_C, 90 + 90);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	mov R16,R22
	xcall _angle
	.dbline 174
; 	 	angle(dir2, MOTOR_B, 90 - stretch); 
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,66
	ldd R16,y+27
	xcall _angle
	.dbline 175
; 	 	angle(dir2, MOTOR_C, 90 - stretch);
	ldi R24,90
	sub R24,R20
	std y+0,R24
	ldi R18,67
	ldd R16,y+27
	xcall _angle
	.dbline 179
; 		
; 		
; 		//delay
; 		delay(delay_time);
	movw R16,R10
	xcall _delay
	.dbline 180
; 	}	
L11:
	.dbline 151
	movw R4,R12
	movw R24,R4
	sbiw R24,1
	movw R12,R24
	clr R2
	clr R3
	cp R2,R4
	cpc R3,R5
	brge X2
	xjmp L10
X2:
X1:
	.dbline -2
L8:
	.dbline 0 ; func end
	adiw R28,15
	xcall pop_xgsetF0FC
	adiw R28,4
	ret
	.dbsym l array_opposite 1 A[14:7]I
	.dbsym r delay_time 10 I
	.dbsym r dir2_opposite 22 c
	.dbsym r dir1_opposite 14 c
	.dbsym r stretch 20 c
	.dbsym r steps 12 I
	.dbsym l dir2 27 c
	.dbsym l dir1 25 c
	.dbend
	.area lit(rom, con, rel)
L14:
	.word 0
	.word 6
	.word 5
	.word 4
	.word 3
	.word 2
	.word 1
L15:
	.byte 0,2
	.byte 3,6
	.byte 1,4
	.byte 5
L16:
	.byte 0,4
	.byte 1,2
	.byte 5,6
	.byte 3
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_motions.c
	.dbfunc e sway _sway fV
; array_opposite -> y+15
;     delay_time -> R10,R11
;     legs_clock -> y+8
; legs_anticlock -> y+1
;  dir2_opposite -> R20
;  dir1_opposite -> R14
; dir_centre_opposite -> R12
;     dir_centre -> y+31
;           dir2 -> y+30
;           dir1 -> y+29
;        stretch -> R22
;       movement -> y+44
;          steps -> y+42
	.even
_sway::
	xcall push_arg4
	xcall push_xgsetF0FC
	sbiw R28,32
	.dbline -1
	.dbline 188
; }
; 
; /**
; Servo control the hexapod shifts its weight clockwise
; @param steps : number of steps to be carried out
; @param movement : clockwise or anticlockwise
; */
; void sway(int steps, unsigned char movement) {
	.dbline 189
; 	 int array_opposite[] = {0,6,5,4,3,2,1};
	ldi R24,<L14
	ldi R25,>L14
	movw R30,R28
	adiw R30,15
	ldi R16,14
	ldi R17,0
	st -y,R31
	st -y,R30
	st -y,R25
	st -y,R24
	xcall asgncblkx
	.dbline 190
; 	 unsigned char legs_anticlock[] = {0,2,3,6,1,4,5};
	ldi R24,<L15
	ldi R25,>L15
	movw R30,R28
	adiw R30,1
	ldi R16,7
	ldi R17,0
	st -y,R31
	st -y,R30
	st -y,R25
	st -y,R24
	xcall asgncblkx
	.dbline 191
; 	 unsigned char legs_clock[] = {0,4,1,2,5,6,3};
	ldi R24,<L16
	ldi R25,>L16
	movw R30,R28
	adiw R30,8
	ldi R16,7
	ldi R17,0
	st -y,R31
	st -y,R30
	st -y,R25
	st -y,R24
	xcall asgncblkx
	.dbline 192
; 	 unsigned char dir1 = LEG_1;
	clr R0
	inc R0
	std y+29,R0
	.dbline 193
; 	 unsigned char dir2  = LEG_2;
	ldi R24,2
	std y+30,R24
	.dbline 194
; 	 unsigned char dir_centre = LEG_3;
	ldi R24,3
	std y+31,R24
	.dbline 195
; 	 unsigned char dir_centre_opposite  = LEG_4;
	ldi R24,4
	mov R12,R24
	.dbline 196
; 	 unsigned char dir1_opposite = array_opposite[dir1];
	movw R24,R28
	adiw R24,15
	ldd R30,y+29
	clr R31
	lsl R30
	rol R31
	add R30,R24
	adc R31,R25
	ldd R14,z+0
	.dbline 197
; 	 unsigned char dir2_opposite = array_opposite[dir2];
	movw R24,R28
	adiw R24,15
	ldd R30,y+30
	clr R31
	lsl R30
	rol R31
	add R30,R24
	adc R31,R25
	ldd R20,z+0
	.dbline 198
; 	 unsigned char stretch = 90;
	ldi R22,90
	.dbline 199
; 	 int delay_time = TWO_HUNDRED_FIFTY_MSEC;
	ldi R24,100
	ldi R25,0
	movw R10,R24
	xjmp L18
L17:
	.dbline 201
; 	 
; 	 while(steps-- > 0) {
	.dbline 204
; 	 			   
; 	 	//move towards 6 & 5 opposite legs
; 		angle(dir1, MOTOR_B, 90 + stretch);
	mov R24,R22
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,66
	ldd R16,y+29
	xcall _angle
	.dbline 205
; 	 	angle(dir1, MOTOR_C, 90 + 90);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldd R16,y+29
	xcall _angle
	.dbline 206
; 	 	angle(dir1_opposite, MOTOR_B, 90 - stretch); 
	ldi R24,90
	sub R24,R22
	std y+0,R24
	ldi R18,66
	mov R16,R14
	xcall _angle
	.dbline 207
; 	 	angle(dir1_opposite, MOTOR_C, 90 - stretch);	 
	ldi R24,90
	sub R24,R22
	std y+0,R24
	ldi R18,67
	mov R16,R14
	xcall _angle
	.dbline 208
; 	 	angle(dir2, MOTOR_B, 90 + stretch);
	mov R24,R22
	subi R24,166    ; addi 90
	std y+0,R24
	ldi R18,66
	ldd R16,y+30
	xcall _angle
	.dbline 209
; 	 	angle(dir2, MOTOR_C, 90 + 90);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldd R16,y+30
	xcall _angle
	.dbline 210
; 	 	angle(dir2_opposite, MOTOR_B, 90 - stretch); 
	ldi R24,90
	sub R24,R22
	std y+0,R24
	ldi R18,66
	mov R16,R20
	xcall _angle
	.dbline 211
; 	 	angle(dir2_opposite, MOTOR_C, 90 - stretch);
	ldi R24,90
	sub R24,R22
	std y+0,R24
	ldi R18,67
	mov R16,R20
	xcall _angle
	.dbline 214
; 		
; 		//reset leg 3 & 4 centre legs
; 		angle(dir_centre, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldd R16,y+31
	xcall _angle
	.dbline 215
; 		angle(dir_centre_opposite, MOTOR_B, 90);	
	ldi R24,90
	std y+0,R24
	ldi R18,66
	mov R16,R12
	xcall _angle
	.dbline 216
; 		angle(dir_centre, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	ldd R16,y+31
	xcall _angle
	.dbline 217
; 		angle(dir_centre_opposite, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	mov R16,R12
	xcall _angle
	.dbline 220
; 		
; 		//delay
; 		delay(delay_time);
	movw R16,R10
	xcall _delay
	.dbline 223
; 		
; 		//update legs
; 		if(movement == CLOCK_WISE) {
	ldd R24,y+44
	cpi R24,1
	breq X5
	xjmp L20
X5:
X3:
	.dbline 223
	.dbline 224
; 			dir1 = legs_clock[dir1];
	movw R24,R28
	adiw R24,8
	ldd R30,y+29
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	std y+29,R2
	.dbline 225
; 			dir2 = legs_clock[dir2];
	movw R24,R28
	adiw R24,8
	ldd R30,y+30
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	std y+30,R2
	.dbline 226
; 			dir1_opposite = legs_clock[dir1_opposite];
	movw R24,R28
	adiw R24,8
	mov R30,R14
	clr R31
	add R30,R24
	adc R31,R25
	ldd R14,z+0
	.dbline 227
; 			dir2_opposite = legs_clock[dir2_opposite];
	movw R24,R28
	adiw R24,8
	mov R30,R20
	clr R31
	add R30,R24
	adc R31,R25
	ldd R20,z+0
	.dbline 228
; 			dir_centre = legs_clock[dir_centre];
	movw R24,R28
	adiw R24,8
	ldd R30,y+31
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	std y+31,R2
	.dbline 229
; 			dir_centre_opposite = legs_clock[dir_centre_opposite];
	movw R24,R28
	adiw R24,8
	mov R30,R12
	clr R31
	add R30,R24
	adc R31,R25
	ldd R12,z+0
	.dbline 230
; 		} else {
	xjmp L21
L20:
	.dbline 230
	.dbline 231
; 			dir1 = legs_anticlock[dir1];
	movw R24,R28
	adiw R24,1
	ldd R30,y+29
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	std y+29,R2
	.dbline 232
; 			dir2 = legs_anticlock[dir2];
	movw R24,R28
	adiw R24,1
	ldd R30,y+30
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	std y+30,R2
	.dbline 233
; 			dir1_opposite = legs_anticlock[dir1_opposite];
	movw R24,R28
	adiw R24,1
	mov R30,R14
	clr R31
	add R30,R24
	adc R31,R25
	ldd R14,z+0
	.dbline 234
; 			dir2_opposite = legs_anticlock[dir2_opposite];
	movw R24,R28
	adiw R24,1
	mov R30,R20
	clr R31
	add R30,R24
	adc R31,R25
	ldd R20,z+0
	.dbline 235
; 			dir_centre = legs_anticlock[dir_centre];
	movw R24,R28
	adiw R24,1
	ldd R30,y+31
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	std y+31,R2
	.dbline 236
; 			dir_centre_opposite = legs_anticlock[dir_centre_opposite];
	movw R24,R28
	adiw R24,1
	mov R30,R12
	clr R31
	add R30,R24
	adc R31,R25
	ldd R12,z+0
	.dbline 237
; 		}
L21:
	.dbline 238
; 	}	
L18:
	.dbline 201
	ldd R4,y+42
	ldd R5,y+43
	movw R24,R4
	sbiw R24,1
	std y+43,R25
	std y+42,R24
	clr R2
	clr R3
	cp R2,R4
	cpc R3,R5
	brge X6
	xjmp L17
X6:
X4:
	.dbline -2
L13:
	.dbline 0 ; func end
	adiw R28,32
	xcall pop_xgsetF0FC
	adiw R28,4
	ret
	.dbsym l array_opposite 15 A[14:7]I
	.dbsym r delay_time 10 I
	.dbsym l legs_clock 8 A[7:7]c
	.dbsym l legs_anticlock 1 A[7:7]c
	.dbsym r dir2_opposite 20 c
	.dbsym r dir1_opposite 14 c
	.dbsym r dir_centre_opposite 12 c
	.dbsym l dir_centre 31 c
	.dbsym l dir2 30 c
	.dbsym l dir1 29 c
	.dbsym r stretch 22 c
	.dbsym l movement 44 c
	.dbsym l steps 42 I
	.dbend
	.dbfunc e climb _climb fV
;           lift -> R20
;    delay_time2 -> R22,R23
;    delay_time1 -> R20,R21
	.even
_climb::
	xcall push_xgsetF000
	sbiw R28,1
	.dbline -1
	.dbline 244
; }
; 
; /**
; Used to make the hexapod climb steps
; */
; void climb() {
	.dbline 245
; 	 unsigned char lift = 50;
	.dbline 246
; 	 int delay_time1  =  FIVE_HUNDRED_MSEC;
	ldi R20,200
	ldi R21,0
	.dbline 247
; 	 int delay_time2 = ONE_SEC;
	ldi R22,400
	ldi R23,1
	.dbline 249
; 	 
; 	 setMirrorDir(DIR_MIRROR_LEG_1_2);
	clr R16
	xcall _setMirrorDir
	.dbline 252
; 	 
; 	 /* ---increase bot height --- */
; 	 angleMirror(LEG_1, MOTOR_B, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 253
; 	 angleMirror(LEG_1, MOTOR_C, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 255
; 	 
; 	 angleMirror(LEG_4, MOTOR_B, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 256
; 	 angleMirror(LEG_4, MOTOR_C, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 258
; 	 
; 	 angleMirror(LEG_5, MOTOR_B, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,5
	ldi R17,0
	xcall _angleMirror
	.dbline 259
; 	 angleMirror(LEG_5, MOTOR_C, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,5
	ldi R17,0
	xcall _angleMirror
	.dbline 261
; 	 
; 	 delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 267
; 	 
; 	 
; 	 /* ---- Thrust the body of the robot forward ----*/
; 	 
; 	 //pick up leg 3 & 4
; 	 angleMirror(LEG_4, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 269
; 	 	 
; 	 delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 275
; 		
; 		
; 	 //Leg 3 moves more than leg 4 bot goes towards left 	 
; 	 //move leg 3 & 4 in air
; 	 //angleMirror(LEG_4, MOTOR_A, 180);
; 	 angle(LEG_4, MOTOR_A, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,65
	ldi R16,4
	xcall _angle
	.dbline 276
; 	 angle(LEG_3, MOTOR_A, 20);
	ldi R24,20
	std y+0,R24
	ldi R18,65
	ldi R16,3
	xcall _angle
	.dbline 278
; 	 
; 	 delay(delay_time2);
	movw R16,R22
	xcall _delay
	.dbline 281
; 	 	 
; 	 //put leg 3 & 4 down
; 	 angleMirror(LEG_4, MOTOR_B, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 283
; 	 
; 	 delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 286
; 	 
; 	 //move legs 1 & 2	 
; 	 angleMirror(LEG_1, MOTOR_A, 30);
	ldi R24,30
	std y+0,R24
	ldi R18,65
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 288
; 
; 	 delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 291
; 	 
; 	 //pick up leg 1 & 2
; 	 angleMirror(LEG_1, MOTOR_B, 0);
	clr R2
	std y+0,R2
	ldi R18,66
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 292
; 	 angleMirror(LEG_1, MOTOR_C, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 294
; 	 
; 	 delay(delay_time2);
	movw R16,R22
	xcall _delay
	.dbline 297
; 	 
; 	 //move legs 1 & 2 in air
; 	 angleMirror(LEG_1, MOTOR_A, 150);
	ldi R24,150
	std y+0,R24
	ldi R18,65
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 299
; 	 
; 	 delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 304
; 	 
; 	 /*---- Bot pushes itself on the platform -- */
; 	 
; 	 //move body on leg 3 & 4
; 	 angleMirror(LEG_4, MOTOR_A, 0);
	clr R2
	std y+0,R2
	ldi R18,65
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 306
; 	 
; 	 delay(ONE_SEC);
	ldi R16,400
	ldi R17,1
	xcall _delay
	.dbline 309
; 	 
; 	 // move leg 1 & 2
; 	 angleMirror(LEG_1, MOTOR_B, 50); //tune for height
	ldi R24,50
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 310
; 	 angleMirror(LEG_1, MOTOR_C, 90); //tune this too
	ldi R24,90
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 312
; 	 
; 	 delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 315
; 	 
; 	 //pick up 3&4
; 	 angleMirror(LEG_4, MOTOR_B, 0);
	clr R2
	std y+0,R2
	ldi R18,66
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 316
; 	 angleMirror(LEG_4, MOTOR_C, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 318
; 	 
; 	 delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 321
; 	 
; 	 //moving leg 3&4 in air
; 	 angleMirror(LEG_4, MOTOR_A, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,65
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 323
; 	 
; 	 delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 326
; 	 
; 	 //make leg 3 &4 touch ground
; 	 angleMirror(LEG_4, MOTOR_B, 50);
	ldi R24,50
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 327
; 	 angleMirror(LEG_4, MOTOR_C, 50);
	ldi R24,50
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 330
; 	 
; 	 
; 	 delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 333
; 	 
; 	 //move body on leg 3 & 4 
; 	 angleMirror(LEG_4, MOTOR_A, 0);
	clr R2
	std y+0,R2
	ldi R18,65
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 334
; 	 angleMirror(LEG_1, MOTOR_C, 0);
	clr R2
	std y+0,R2
	ldi R18,67
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 336
; 	 	 	 
; 	 delay(delay_time2);
	movw R16,R22
	xcall _delay
	.dbline 338
; 	 
; 	 angleMirror(LEG_1, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 339
; 	 angleMirror(LEG_1, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 341
; 	 
; 	 delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 345
; 	 
; 	 
; 	 //drag body forward on legs 1 & 2 
; 	 angleMirror(LEG_1, MOTOR_A, 0);
	clr R2
	std y+0,R2
	ldi R18,65
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 347
; 	 
; 	 delay(delay_time2);
	movw R16,R22
	xcall _delay
	.dbline 351
; 	
; 	
; 	 //pick up 3 & 4
; 	 angleMirror(LEG_4, MOTOR_B, 0);
	clr R2
	std y+0,R2
	ldi R18,66
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 352
; 	 angleMirror(LEG_4, MOTOR_C, 0);
	clr R2
	std y+0,R2
	ldi R18,67
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 355
; 	
; 	
; 	 delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 358
; 	
; 	 //move forward in air 
; 	 angleMirror(LEG_4, MOTOR_A, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,65
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 360
; 	
; 	 delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 363
; 	
; 	//put 3 & 4 down
; 	angleMirror(LEG_4, MOTOR_B, 50);
	ldi R24,50
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 364
; 	angleMirror(LEG_4, MOTOR_C, 50);
	ldi R24,50
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 366
; 	
; 	delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 369
; 	
; 	//push body on 3 & 4
; 	angleMirror(LEG_4, MOTOR_A, 0);
	clr R2
	std y+0,R2
	ldi R18,65
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 371
; 	
; 	delay(delay_time2);
	movw R16,R22
	xcall _delay
	.dbline 375
; 	
; 	// make this more smooth
; 	//make hexapod sit
; 	angleMirror(LEG_4, MOTOR_B, 0);
	clr R2
	std y+0,R2
	ldi R18,66
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 376
; 	angleMirror(LEG_4, MOTOR_C, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 377
; 	delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 379
; 	
; 	angleMirror(LEG_1, MOTOR_B, 0);
	clr R2
	std y+0,R2
	ldi R18,66
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 381
; 	
; 	delay(delay_time1);	
	movw R16,R20
	xcall _delay
	.dbline 383
; 	
; 	angleMirror(LEG_4, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 385
; 	 
; 	delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 388
; 	 
; 	//pick up legs 5 & 6
; 	angleMirror(LEG_5, MOTOR_B, 0);
	clr R2
	std y+0,R2
	ldi R18,66
	ldi R19,0
	ldi R16,5
	ldi R17,0
	xcall _angleMirror
	.dbline 389
; 	angleMirror(LEG_5, MOTOR_C, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,5
	ldi R17,0
	xcall _angleMirror
	.dbline 391
; 	 
; 	delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 394
; 	 
; 	//move legs 5 & 6 in air 
; 	angleMirror(LEG_5, MOTOR_A, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,65
	ldi R19,0
	ldi R16,5
	ldi R17,0
	xcall _angleMirror
	.dbline 396
; 	 
; 	delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 399
; 	 
; 	//crawl on 1, 2 , 3 ,4
; 	angleMirror(LEG_1, MOTOR_A, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,65
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 400
; 	angleMirror(LEG_4, MOTOR_A, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,65
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 402
; 	 
; 	delay(delay_time2);
	movw R16,R22
	xcall _delay
	.dbline 405
; 	 
; 	//put down 1, 2, 3, 4
; 	angleMirror(LEG_1, MOTOR_B, 50);
	ldi R24,50
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 406
; 	angleMirror(LEG_1, MOTOR_C, 50);
	ldi R24,50
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 407
; 	angleMirror(LEG_4, MOTOR_B, 50);
	ldi R24,50
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 408
; 	angleMirror(LEG_4, MOTOR_C, 50);
	ldi R24,50
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 410
; 	 
; 	delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 413
; 	 
; 	//crawl on 1, 2 , 3 ,4
; 	angleMirror(LEG_1, MOTOR_A, 0);
	clr R2
	std y+0,R2
	ldi R18,65
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 414
; 	angleMirror(LEG_4, MOTOR_A, 0);
	clr R2
	std y+0,R2
	ldi R18,65
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 416
; 	
; 	delay(delay_time2);
	movw R16,R22
	xcall _delay
	.dbline 420
; 	 
; 	 
; 	//put down 5 & 6 
; 	angleMirror(LEG_5, MOTOR_B, 50);
	ldi R24,50
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,5
	ldi R17,0
	xcall _angleMirror
	.dbline 421
; 	angleMirror(LEG_5, MOTOR_C, 50);
	ldi R24,50
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,5
	ldi R17,0
	xcall _angleMirror
	.dbline 423
; 	 
; 	delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 427
; 	 
; 	//stand up and dance
; 	 
; 	angleMirror(LEG_1, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 428
; 	angleMirror(LEG_1, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,1
	ldi R17,0
	xcall _angleMirror
	.dbline 429
; 	angleMirror(LEG_4, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 430
; 	angleMirror(LEG_4, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,4
	ldi R17,0
	xcall _angleMirror
	.dbline 431
; 	angleMirror(LEG_5, MOTOR_B, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,66
	ldi R19,0
	ldi R16,5
	ldi R17,0
	xcall _angleMirror
	.dbline 432
; 	angleMirror(LEG_5, MOTOR_C, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,67
	ldi R19,0
	ldi R16,5
	ldi R17,0
	xcall _angleMirror
	.dbline 434
; 	 
; 	delay(delay_time1);
	movw R16,R20
	xcall _delay
	.dbline 436
; 	 
; 	angleMirror(LEG_5, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldi R19,0
	ldi R16,5
	ldi R17,0
	xcall _angleMirror
	.dbline 438
; 	 
; 	delay(ONE_SEC);
	ldi R16,400
	ldi R17,1
	xcall _delay
	.dbline 440
; 	 
; 	servo_calibration(); //must be called as the first instruction
	xcall _servo_calibration
	.dbline 442
; 	 
; 	delay(ONE_SEC);
	ldi R16,400
	ldi R17,1
	xcall _delay
	.dbline -2
L22:
	.dbline 0 ; func end
	adiw R28,1
	xjmp pop_xgsetF000
	.dbsym r lift 20 c
	.dbsym r delay_time2 22 I
	.dbsym r delay_time1 20 I
	.dbend
	.dbfunc e walk_on_four _walk_on_four fV
;              i -> R10,R11
;           lift -> R22
;     delay_time -> R20
	.even
_walk_on_four::
	xcall push_xgsetF00C
	sbiw R28,2
	.dbline -1
	.dbline 451
; 	 
; 	 	 
; }
; 
; /**
; The hexapod moves on four legs
; This method doesnt work as planned
; */
; void walk_on_four() {
	.dbline 453
; 	 
; 	 unsigned char lift = 120;
	ldi R22,120
	.dbline 454
; 	 unsigned char delay_time  = HUNDRED_MSEC;
	ldi R20,40
	.dbline 455
; 	 int i = 10;
	ldi R24,10
	ldi R25,0
	movw R10,R24
	.dbline 457
; 	 //come to pose
; 	 pose(1,2,0);
	clr R2
	clr R3
	std y+1,R3
	std y+0,R2
	ldi R18,2
	ldi R16,1
	xcall _pose
	.dbline 459
; 	 
; 	 delay(ONE_SEC);
	ldi R16,400
	ldi R17,1
	xcall _delay
	.dbline 460
; 	 delay(ONE_SEC);
	ldi R16,400
	ldi R17,1
	xcall _delay
	xjmp L25
L24:
	.dbline 463
; 	 
; 	 
; 	 while(i-- > 0) {
	.dbline 471
; 	 
; 	 //adjust body weight
; 	 //angle(LEG_6, MOTOR_A, 90 - 50);	
; 	 //angle(LEG_5, MOTOR_A, 90 + 50);
; 	 
; 	 //delay(ONE_SEC);
; 	 
; 	 angle(LEG_3, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldi R16,3
	xcall _angle
	.dbline 472
; 	 angle(LEG_4, MOTOR_B, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,66
	ldi R16,4
	xcall _angle
	.dbline 474
; 	 
; 	 delay(delay_time);
	mov R16,R20
	clr R17
	xcall _delay
	.dbline 477
; 	 
; 	 //move left forward leg forward in air
; 	 angle(LEG_3, MOTOR_A, 70);
	ldi R24,70
	std y+0,R24
	ldi R18,65
	ldi R16,3
	xcall _angle
	.dbline 478
; 	 angle(LEG_4, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldi R16,4
	xcall _angle
	.dbline 480
; 	 
; 	 delay(delay_time);
	mov R16,R20
	clr R17
	xcall _delay
	.dbline 482
; 	 
; 	 angle(LEG_3, MOTOR_B, 180);
	ldi R24,180
	std y+0,R24
	ldi R18,66
	ldi R16,3
	xcall _angle
	.dbline 483
; 	 angle(LEG_4, MOTOR_B, lift);
	std y+0,R22
	ldi R18,66
	ldi R16,4
	xcall _angle
	.dbline 485
; 	 
; 	 delay(delay_time);
	mov R16,R20
	clr R17
	xcall _delay
	.dbline 487
; 	 
; 	 angle(LEG_3, MOTOR_A, 90);
	ldi R24,90
	std y+0,R24
	ldi R18,65
	ldi R16,3
	xcall _angle
	.dbline 488
; 	 angle(LEG_4, MOTOR_A, 70);
	ldi R24,70
	std y+0,R24
	ldi R18,65
	ldi R16,4
	xcall _angle
	.dbline 490
; 	 	 
; 	 delay(delay_time);
	mov R16,R20
	clr R17
	xcall _delay
	.dbline 493
; 	 
; 	 
; 	 }
L25:
	.dbline 463
	movw R4,R10
	movw R24,R4
	sbiw R24,1
	movw R10,R24
	clr R2
	clr R3
	cp R2,R4
	cpc R3,R5
	brge X8
	xjmp L24
X8:
X7:
	.dbline -2
L23:
	.dbline 0 ; func end
	adiw R28,2
	xjmp pop_xgsetF00C
	.dbsym r i 10 I
	.dbsym r lift 22 c
	.dbsym r delay_time 20 c
	.dbend
; 	 //move right backward leg forward in air
; 	 //angle(LEG_5, MOTOR_A, 90 + 50);
; 	 
; 	 
; 	 //delay
; 	 //delay(delay_time);
; 	 
; 	 //move right forward leg forward in air
; 	 //angle(LEG_4, MOTOR_A, 90 + 50);
; 	 
; 	 //delay(delay_time);
; 	 
; 	 //move left backward forward in air
; 	 //angle(LEG_6, MOTOR_A, 90 - 50);
; 
; 	 //delay(delay_time);
; }

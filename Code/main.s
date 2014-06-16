	.module main.c
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\main.c
	.dbfunc e main _main fV
	.area efunc_lit(rom, con, rel)
L28:
	.eaddr `L9
	.eaddr `L10
	.eaddr `L11
	.eaddr `L12
	.eaddr `L13
	.eaddr `L14
	.eaddr `L15
	.eaddr `L7
	.eaddr `L7
	.eaddr `L7
	.eaddr `L18
	.eaddr `L19
	.eaddr `L20
	.eaddr `L21
	.eaddr `L7
	.eaddr `L7
	.eaddr `L7
	.eaddr `L7
	.eaddr `L7
	.eaddr `L7
	.eaddr `L24
	.eaddr `L25
	.eaddr `L26
	.eaddr `L27
	.area text(rom, con, rel)
;              i -> R20,R21
	.even
_main::
	sbiw R28,2
	.dbline -1
	.dbline 73
; /**
; @mainpage Building a locamotion based Hexapod Application
; @author Group 6 Srijit Dutt 10305056
; 
; Mon 08 Nov 2010 12:49:10 AM IST 
; 
; ICC AVR 7
; 
; Conatins various functions for basic, advanced hexapod motions
; 
; 
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
; #include <iom2560v.h>
; #include <macros.h>
; #include "hexapod_macro.h"
; #include "hexapod.h"
; #include "hexapod_basic.h"
; #include "hexapod_motions.h"
; #include "gait.h"
; #include "keyboard.h"
; 
; extern unsigned char data;
; unsigned char mode;
; unsigned int legNo;
; unsigned int dir;
; unsigned int tempDir;
; double movementScaling;
; 
; void main(void) 
; {
	.dbline 74
; 	int i = 100;
	ldi R20,100
	ldi R21,0
	.dbline 75
; 	init_devices();
	xcall _init_devices
	.dbline 77
; 	//insert your functional code here...
; 	servo_calibration(); //must be called as the first instruction
	xcall _servo_calibration
	.dbline 78
; 	servo_on();//turning on the servo supply
	xcall _servo_on
	.dbline 79
; 	initializeAngles();
	xcall _initializeAngles
	.dbline 80
; 	delay(ONE_SEC);
	ldi R16,400
	ldi R17,1
	xcall _delay
	.dbline 81
; 	delay(ONE_SEC);
	ldi R16,400
	ldi R17,1
	xcall _delay
	.dbline 82
; 	delay(ONE_SEC);
	ldi R16,400
	ldi R17,1
	xcall _delay
	.dbline 84
; 
; 	delay(ONE_SEC);
	ldi R16,400
	ldi R17,1
	xcall _delay
	.dbline 91
; 	
; 	
; 	/*ripple_gait(LEG_1, 10);
; 	servo_calibration();
; 	delay(ONE_SEC);*/
; 
; 	mode = 'z';
	ldi R24,122
	sts _mode,R24
	.dbline 92
; 	legNo = 1;
	ldi R24,1
	ldi R25,0
	sts _legNo+1,R25
	sts _legNo,R24
	.dbline 93
; 	dir = CLOCK_WISE;
	sts _dir+1,R25
	sts _dir,R24
	.dbline 94
; 	movementScaling = 1.0;
	ldi R16,<L2
	ldi R17,>L2
	xcall elpm32
	sts _movementScaling+1,R17
	sts _movementScaling,R16
	sts _movementScaling+2+1,R19
	sts _movementScaling+2,R18
	xjmp L4
L3:
	.dbline 96
; 						
; 	while(1){
	.dbline 98
; 	
; 		switch(mode){
	lds R20,_mode
	clr R21
	cpi R20,1
	ldi R30,0
	cpc R21,R30
	brge X5
	xjmp L7
X5:
X0:
	ldi R24,24
	ldi R25,0
	cp R24,R20
	cpc R25,R21
	brge X6
	xjmp L7
X6:
X1:
	ldi R16,3
	ldi R17,0
	movw R18,R20
	xcall empy16s
	movw R30,R16
	ldi R24,<L28-3
	ldi R25,>L28-3
	add R30,R24
	adc R31,R25
	elpm R2,Z+
	elpm R3,Z+
	elpm R0,Z
	out 0x3C,R0
	movw R30,R2
	eijmp
X2:
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\main.c
	.dbline 98
L9:
	.dbline 100
; 			case 1:
; 				 tripod_gait(legNo, 1);
	ldi R18,1
	lds R16,_legNo
	xcall _tripod_gait
	.dbline 101
; 				 break;
	xjmp L7
L10:
	.dbline 103
; 			case 2:
; 				 tripod_gait_2(legNo, 1);
	ldi R18,1
	lds R16,_legNo
	xcall _tripod_gait_2
	.dbline 104
; 				 break;
	xjmp L7
L11:
	.dbline 106
; 			case 3:
; 				 tripod_gait_continuous(legNo, 1);
	ldi R18,1
	lds R16,_legNo
	xcall _tripod_gait_continuous
	.dbline 107
; 				 break;
	xjmp L7
L12:
	.dbline 109
; 			case 4:
; 				 tripod_gait_insect_continuous(legNo, 1);
	ldi R18,1
	lds R16,_legNo
	xcall _tripod_gait_insect_continuous
	.dbline 110
; 				 break;
	xjmp L7
L13:
	.dbline 112
; 			case 5:
; 				 wave_gait(legNo, 1);
	ldi R18,1
	ldi R19,0
	lds R16,_legNo
	xcall _wave_gait
	.dbline 113
; 				 break;
	xjmp L7
L14:
	.dbline 115
; 			case 6:
; 				 ripple_gait(legNo, 1);
	ldi R18,1
	ldi R19,0
	lds R16,_legNo
	xcall _ripple_gait
	.dbline 116
; 				 break;
	xjmp L7
L15:
	.dbline 118
; 			case 7:
; 				 tempDir = ((legNo + 1) % 6) + 1;
	ldi R18,6
	ldi R19,0
	lds R16,_legNo
	lds R17,_legNo+1
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall mod16u
	movw R24,R16
	adiw R24,1
	sts _tempDir+1,R25
	sts _tempDir,R24
	.dbline 119
; 				 tempDir = ((tempDir + 1) % 6) + 1;
	ldi R18,6
	ldi R19,0
	movw R16,R24
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall mod16u
	movw R24,R16
	adiw R24,1
	sts _tempDir+1,R25
	sts _tempDir,R24
	.dbline 120
; 				 tempDir = 7 - tempDir;
	movw R2,R24
	ldi R24,7
	ldi R25,0
	sub R24,R2
	sbc R25,R3
	sts _tempDir+1,R25
	sts _tempDir,R24
	.dbline 121
; 				 two_leg_gait(legNo, tempDir, 1);
	ldi R24,1
	ldi R25,0
	std y+1,R25
	std y+0,R24
	lds R18,_tempDir
	lds R16,_legNo
	xcall _two_leg_gait
	.dbline 122
; 				 break;
	xjmp L7
L18:
	.dbline 128
; 			case 8:
; 				 break;
; 			case 9:
; 				 break;
; 			case 11:
; 				 tripod_turn_gait(dir, 1);
	ldi R18,1
	lds R16,_dir
	xcall _tripod_turn_gait
	.dbline 129
; 				 break;
	xjmp L7
L19:
	.dbline 131
; 			case 12:
; 				 tripod_turn_gait_continuous(dir, 1);
	ldi R18,1
	lds R16,_dir
	xcall _tripod_turn_gait_continuous
	.dbline 132
; 				 break;
	xjmp L7
L20:
	.dbline 134
; 			case 13:
; 				 two_legged_turn_gait(dir, 1);
	ldi R18,1
	lds R16,_dir
	xcall _two_legged_turn_gait
	.dbline 135
; 				 break;	 
	xjmp L7
L21:
	.dbline 137
; 			case 14:
; 				 if (dir == CLOCK_WISE){
	lds R24,_dir
	lds R25,_dir+1
	cpi R24,1
	ldi R30,0
	cpc R25,R30
	brne L22
X3:
	.dbline 137
	.dbline 138
; 				 	robot_rotate_clockwise_7_5();
	xcall _robot_rotate_clockwise_7_5
	.dbline 139
; 				 }
	xjmp L7
L22:
	.dbline 140
; 				 else{
	.dbline 141
; 				 	  robot_rotate_anticlockwise_7_5();
	xcall _robot_rotate_anticlockwise_7_5
	.dbline 142
; 				 }
	.dbline 143
; 				 break;
	xjmp L7
L24:
	.dbline 145
; 		    case 21:
; 				 tempDir = ((legNo + 1) % 6) + 1;
	ldi R18,6
	ldi R19,0
	lds R16,_legNo
	lds R17,_legNo+1
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall mod16u
	movw R24,R16
	adiw R24,1
	sts _tempDir+1,R25
	sts _tempDir,R24
	.dbline 146
; 				 tempDir = ((tempDir + 1) % 6) + 1;
	ldi R18,6
	ldi R19,0
	movw R16,R24
	subi R16,255  ; offset = 1
	sbci R17,255
	xcall mod16u
	movw R24,R16
	adiw R24,1
	sts _tempDir+1,R25
	sts _tempDir,R24
	.dbline 147
; 				 tempDir = 7 - tempDir;
	movw R2,R24
	ldi R24,7
	ldi R25,0
	sub R24,R2
	sbc R25,R3
	sts _tempDir+1,R25
	sts _tempDir,R24
	.dbline 148
; 				 pose(legNo, tempDir, 10);
	ldi R24,10
	ldi R25,0
	std y+1,R25
	std y+0,R24
	lds R18,_tempDir
	lds R16,_legNo
	xcall _pose
	.dbline 149
; 				 break;
	xjmp L7
L25:
	.dbline 151
; 			case 22:
; 				 sway(24, CLOCK_WISE);
	ldi R18,1
	ldi R16,24
	ldi R17,0
	xcall _sway
	.dbline 152
; 				 break;
	xjmp L7
L26:
	.dbline 154
; 		    case 23:
; 				 dance(4,5,6);
	ldi R24,6
	ldi R25,0
	std y+1,R25
	std y+0,R24
	ldi R18,5
	ldi R16,4
	xcall _dance
	.dbline 155
; 				 break;
	xjmp L7
L27:
	.dbline 157
; 			case 24:
; 				 climb();
	xcall _climb
	.dbline 158
; 				 break;
	.dbline 160
; 	   	    default:
; 			     break;
L7:
	.dbline 162
; 		}
; 	}	
L4:
	.dbline 96
	xjmp L3
X4:
	.dbline -2
L1:
	.dbline 0 ; func end
	adiw R28,2
	ret
	.dbsym r i 20 I
	.dbend
	.area bss(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\main.c
_movementScaling::
	.blkb 4
	.dbsym e movementScaling _movementScaling D
_tempDir::
	.blkb 2
	.dbsym e tempDir _tempDir i
_dir::
	.blkb 2
	.dbsym e dir _dir i
_legNo::
	.blkb 2
	.dbsym e legNo _legNo i
_mode::
	.blkb 1
	.dbsym e mode _mode c
	.area lit(rom, con, rel)
L2:
	.word 0x0,0x3f80
; }
; 
; 

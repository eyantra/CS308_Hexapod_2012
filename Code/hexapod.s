	.module hexapod.c
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
_arm_number::
	.blkb 1
	.area idata
	.byte 0
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbsym e arm_number _arm_number c
_angle_upper_byte::
	.blkb 1
	.area idata
	.byte 0
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbsym e angle_upper_byte _angle_upper_byte c
_angle_lower_byte::
	.blkb 1
	.area idata
	.byte 0
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbsym e angle_lower_byte _angle_lower_byte c
_degree::
	.blkb 1
	.area idata
	.byte 0
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbsym e degree _degree c
_delay_count::
	.blkb 2
	.area idata
	.word 0
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbsym e delay_count _delay_count i
_serial_communication_interval::
	.blkb 2
	.area idata
	.word 0
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbsym e serial_communication_interval _serial_communication_interval i
_serial_communication_channel_number::
	.blkb 1
	.area idata
	.byte 0
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbsym e serial_communication_channel_number _serial_communication_channel_number c
_motion_busy::
	.blkb 1
	.area idata
	.byte 0
	.area data(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbsym e motion_busy _motion_busy c
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 120
; //ICC-AVR application builder : 11/4/2009 1:05:10 PM
; // Target : M2560
; // Crystal: 11.059Mhz
; 
; /*
;  Pin name	Port		Anding (make 0)		Oring (make 1)
;  SP LEFT	PL1		1111 1101	0xFD		0000 0010	0x02
; 
;  1A		PD5		1101 1111	0xDF		0010 0000	0x20
;  1B		PL2		1111 1011	0xFB		0000 0100	0x04
;  1C		PG1		1111 1101	0xFD		0000 0010	0x02
;  2A		PL6		1011 1111	0xBF		0100 0000	0x40
;  2B		PD4		1110 1111	0xEF		0001 0000	0x10
;  2C		PL7		0111 1111	0x7F		1000 0000	0x80
;  3A		PH6		1011 1111	0xBF		0100 0000	0x40
;  3B		PH4		1110 1111	0xEF		0001 0000	0x10
;  3C		PH5		1101 1111	0xDF		0010 0000	0x20
;  SP RIGHT	PJ7		0111 1111	0x7F		1000 0000	0x80
;  4A		PG0		1111 1110	0xFE		0000 0001	0x01
;  4B		PD7		0111 1111	0x7F		1000 0000	0x80
;  4C		PD6		1011 1111	0xBF		0100 0000	0x40
;  5A		PJ5		1101 1111	0xDF		0010 0000	0x20
;  5B		PJ6		1011 1111	0xBF		0100 0000	0x40
;  5C		PJ4		1110 1111	0xEF		0001 0000	0x10
;  6A		PJ3		1111 0111	0XF7		0000 1000	0x08
;  6B		PJ1		1111 1101	0xFD		0000 0010	0x02
;  6C		PJ2		1111 1011	0xFB		0000 0100	0x04
; 
;  Remote control communication protocoal
;  transmitted command		received data
;  1						right joystick x axis 8 bit analog position;	center:0x24; left: 0x3B; right: 0x04
;  2						right joystick y axis 8 bit analog position;	center:0x24; up: 0x3B; down: 0x04
;  3						left joystick x axis 8 bit analog position;		center:0x3A; left: 0x23; right: 0x04
;  4						left joystick y axis 8 bit analog position;		center:0x1F; up: 0x34; down: 0x04
;  5						right joystick button
;  6						left joystick button
;  7						digital switches left 1,2 and right 1,2
;  bit7: Right 2; bit6: right 1; bit4: left 1; bit3: left 2
; 
;  Received data will be stored in the array unsigned char remote_data [8]; from the location 1 to 7 in the same order as the command.
;  */
;  
;  
;  /*********************************************************************************
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
; #include "keyboard.h"
; 
; unsigned char ADC_Value;
; 
; unsigned char arm_number = 0;
; unsigned char angle_upper_byte = 0;
; unsigned char angle_lower_byte = 0;
; unsigned char degree = 0;
; unsigned char angle_upper_byte_1A, angle_lower_byte_1A, angle_upper_byte_1B, angle_lower_byte_1B, angle_upper_byte_1C, angle_lower_byte_1C;
; unsigned char angle_upper_byte_2A, angle_lower_byte_2A, angle_upper_byte_2B, angle_lower_byte_2B, angle_upper_byte_2C, angle_lower_byte_2C;
; unsigned char angle_upper_byte_3A, angle_lower_byte_3A, angle_upper_byte_3B, angle_lower_byte_3B, angle_upper_byte_3C, angle_lower_byte_3C;
; unsigned char angle_upper_byte_4A, angle_lower_byte_4A, angle_upper_byte_4B, angle_lower_byte_4B, angle_upper_byte_4C, angle_lower_byte_4C;
; unsigned char angle_upper_byte_5A, angle_lower_byte_5A, angle_upper_byte_5B, angle_lower_byte_5B, angle_upper_byte_5C, angle_lower_byte_5C;
; unsigned char angle_upper_byte_6A, angle_lower_byte_6A, angle_upper_byte_6B, angle_lower_byte_6B, angle_upper_byte_6C, angle_lower_byte_6C;
; unsigned int delay_count = 0;
; //variables relatd to the serial commuication or remote control
; unsigned int serial_communication_interval = 0;
; unsigned char serial_communication_channel_number = 0;
; unsigned char remote_data[8]; //see remote channel allocation in the notes above
; unsigned char motion_busy = 0; //sets to one if any of the motion function is called.
; 
; unsigned char data;
; 
; void delay(int time);
; void swap(unsigned char *a, unsigned char *b);
; void buzzer_on(void);
; void buzzer_off(void);
; 
; /**
; Port Initialization
; */
; void port_init(void) {
	.dbline 121
; 	PORTA = 0x00;
	clr R2
	out 0x2,R2
	.dbline 122
; 	DDRA = 0xFF;
	ldi R24,255
	out 0x1,R24
	.dbline 123
; 	PORTB = 0x00;
	out 0x5,R2
	.dbline 124
; 	DDRB = 0x01;
	ldi R24,1
	out 0x4,R24
	.dbline 125
; 	PORTC = 0x00; //m103 output only
	out 0x8,R2
	.dbline 126
; 	DDRC = 0xFF;
	ldi R24,255
	out 0x7,R24
	.dbline 127
; 	PORTD = 0x00;
	out 0xb,R2
	.dbline 128
; 	DDRD = 0xF0;
	ldi R24,240
	out 0xa,R24
	.dbline 129
; 	PORTE = 0x00;
	out 0xe,R2
	.dbline 130
; 	DDRE = 0x00;
	out 0xd,R2
	.dbline 131
; 	PORTF = 0x00;
	out 0x11,R2
	.dbline 132
; 	DDRF = 0x00;
	out 0x10,R2
	.dbline 133
; 	PORTG = 0x00;
	out 0x14,R2
	.dbline 134
; 	DDRG = 0x03;
	ldi R24,3
	out 0x13,R24
	.dbline 135
; 	PORTH = 0x00;
	sts 258,R2
	.dbline 136
; 	DDRH = 0x70;
	ldi R24,112
	sts 257,R24
	.dbline 137
; 	PORTJ = 0x00;
	sts 261,R2
	.dbline 138
; 	DDRJ = 0xFE; //0xFE original
	ldi R24,254
	sts 260,R24
	.dbline 139
; 	PORTK = 0x00;
	sts 264,R2
	.dbline 140
; 	DDRK = 0x00;
	sts 263,R2
	.dbline 141
; 	PORTL = 0x00;
	sts 267,R2
	.dbline 142
; 	DDRL = 0xC7;
	ldi R24,199
	sts 266,R24
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e timer1_init _timer1_init fV
	.even
_timer1_init::
	.dbline -1
	.dbline 149
; }
; 
; //TIMER1 initialize - prescale:1
; // WGM: 0) Normal, TOP=0xFFFF
; // desired value: 400Hz
; // actual value: 400.007Hz (0.0%)
; void timer1_init(void) {
	.dbline 150
; 	TCCR1B = 0x00; //stop
	clr R2
	sts 129,R2
	.dbline 151
; 	TCNT1H = 0x94; //setup
	ldi R24,148
	sts 133,R24
	.dbline 152
; 	TCNT1L = 0x01;
	ldi R24,1
	sts 132,R24
	.dbline 153
; 	OCR1AH = 0x6B;
	ldi R24,107
	sts 137,R24
	.dbline 154
; 	OCR1AL = 0xFF;
	ldi R24,255
	sts 136,R24
	.dbline 155
; 	OCR1BH = 0x6B;
	ldi R24,107
	sts 139,R24
	.dbline 156
; 	OCR1BL = 0xFF;
	ldi R24,255
	sts 138,R24
	.dbline 157
; 	OCR1CH = 0x00;
	sts 141,R2
	.dbline 158
; 	OCR1CL = 0x00;
	sts 140,R2
	.dbline 159
; 	ICR1H = 0x6B;
	ldi R24,107
	sts 135,R24
	.dbline 160
; 	ICR1L = 0xFF;
	ldi R24,255
	sts 134,R24
	.dbline 161
; 	TCCR1A = 0x00;
	sts 128,R2
	.dbline 162
; 	TCCR1C = 0x00;
	sts 130,R2
	.dbline 163
; 	TCCR1B = 0x01; //start Timer
	ldi R24,1
	sts 129,R24
	.dbline -2
L2:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e turn_on_sharp15 _turn_on_sharp15 fV
	.even
_turn_on_sharp15::
	.dbline -1
	.dbline 168
; }
; 
; 
; void turn_on_sharp15 (void) //turn on Sharp IR range sensors 1,5
; {
	.dbline 169
;   PORTH = PORTH & 0xFB;
	lds R24,258
	andi R24,251
	sts 258,R24
	.dbline -2
L3:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e turn_off_sharp15 _turn_off_sharp15 fV
	.even
_turn_off_sharp15::
	.dbline -1
	.dbline 173
; }
; 
; void turn_off_sharp15 (void) //turn off Sharp IR range sensors 1,5
; {
	.dbline 174
;  PORTH = PORTH | 0x04;
	lds R24,258
	ori R24,4
	sts 258,R24
	.dbline -2
L4:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_1A _reset_1A fV
	.even
_reset_1A::
	.dbline -1
	.dbline 177
; }
; 
; void reset_1A(void) {
	.dbline 178
; 	PORTD = PORTD & 0xDF;
	in R24,0xb
	andi R24,223
	out 0xb,R24
	.dbline -2
L5:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_1A _set_1A fV
	.even
_set_1A::
	.dbline -1
	.dbline 181
; }
; 
; void set_1A(void) {
	.dbline 182
; 	PORTD = PORTD | 0x20;
	sbi 0xb,5
	.dbline -2
L6:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_1B _reset_1B fV
	.even
_reset_1B::
	.dbline -1
	.dbline 185
; }
; 
; void reset_1B(void) {
	.dbline 186
; 	PORTL = PORTL & 0xFB;
	lds R24,267
	andi R24,251
	sts 267,R24
	.dbline -2
L7:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_1B _set_1B fV
	.even
_set_1B::
	.dbline -1
	.dbline 189
; }
; 
; void set_1B(void) {
	.dbline 190
; 	PORTL = PORTL | 0x04;
	lds R24,267
	ori R24,4
	sts 267,R24
	.dbline -2
L8:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_1C _reset_1C fV
	.even
_reset_1C::
	.dbline -1
	.dbline 193
; }
; 
; void reset_1C(void) {
	.dbline 194
; 	PORTG = PORTG & 0xFD;
	in R24,0x14
	andi R24,253
	out 0x14,R24
	.dbline -2
L9:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_1C _set_1C fV
	.even
_set_1C::
	.dbline -1
	.dbline 197
; }
; 
; void set_1C(void) {
	.dbline 198
; 	PORTG = PORTG | 0x02;
	sbi 0x14,1
	.dbline -2
L10:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_2A _reset_2A fV
	.even
_reset_2A::
	.dbline -1
	.dbline 201
; }
; 
; void reset_2A(void) {
	.dbline 202
; 	PORTL = PORTL & 0xBF;
	lds R24,267
	andi R24,191
	sts 267,R24
	.dbline -2
L11:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_2A _set_2A fV
	.even
_set_2A::
	.dbline -1
	.dbline 205
; }
; 
; void set_2A(void) {
	.dbline 206
; 	PORTL = PORTL | 0x40;
	lds R24,267
	ori R24,64
	sts 267,R24
	.dbline -2
L12:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_2B _reset_2B fV
	.even
_reset_2B::
	.dbline -1
	.dbline 209
; }
; 
; void reset_2B(void) {
	.dbline 210
; 	PORTD = PORTD & 0xEF;
	in R24,0xb
	andi R24,239
	out 0xb,R24
	.dbline -2
L13:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_2B _set_2B fV
	.even
_set_2B::
	.dbline -1
	.dbline 213
; }
; 
; void set_2B(void) {
	.dbline 214
; 	PORTD = PORTD | 0x10;
	sbi 0xb,4
	.dbline -2
L14:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_2C _reset_2C fV
	.even
_reset_2C::
	.dbline -1
	.dbline 217
; }
; 
; void reset_2C(void) {
	.dbline 218
; 	PORTL = PORTL & 0x7F;
	lds R24,267
	andi R24,127
	sts 267,R24
	.dbline -2
L15:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_2C _set_2C fV
	.even
_set_2C::
	.dbline -1
	.dbline 221
; }
; 
; void set_2C(void) {
	.dbline 222
; 	PORTL = PORTL | 0x80;
	lds R24,267
	ori R24,128
	sts 267,R24
	.dbline -2
L16:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_3A _reset_3A fV
	.even
_reset_3A::
	.dbline -1
	.dbline 225
; }
; 
; void reset_3A(void) {
	.dbline 226
; 	PORTH = PORTH & 0xBF;
	lds R24,258
	andi R24,191
	sts 258,R24
	.dbline -2
L17:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_3A _set_3A fV
	.even
_set_3A::
	.dbline -1
	.dbline 229
; }
; 
; void set_3A(void) {
	.dbline 230
; 	PORTH = PORTH | 0x40;
	lds R24,258
	ori R24,64
	sts 258,R24
	.dbline -2
L18:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_3B _reset_3B fV
	.even
_reset_3B::
	.dbline -1
	.dbline 233
; }
; 
; void reset_3B(void) {
	.dbline 234
; 	PORTH = PORTH & 0xEF;
	lds R24,258
	andi R24,239
	sts 258,R24
	.dbline -2
L19:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_3B _set_3B fV
	.even
_set_3B::
	.dbline -1
	.dbline 237
; }
; 
; void set_3B(void) {
	.dbline 238
; 	PORTH = PORTH | 0x10;
	lds R24,258
	ori R24,16
	sts 258,R24
	.dbline -2
L20:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_3C _reset_3C fV
	.even
_reset_3C::
	.dbline -1
	.dbline 241
; }
; 
; void reset_3C(void) {
	.dbline 242
; 	PORTH = PORTH & 0xDF;
	lds R24,258
	andi R24,223
	sts 258,R24
	.dbline -2
L21:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_3C _set_3C fV
	.even
_set_3C::
	.dbline -1
	.dbline 245
; }
; 
; void set_3C(void) {
	.dbline 246
; 	PORTH = PORTH | 0x20;
	lds R24,258
	ori R24,32
	sts 258,R24
	.dbline -2
L22:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_SP_RIGHT _reset_SP_RIGHT fV
	.even
_reset_SP_RIGHT::
	.dbline -1
	.dbline 249
; }
; 
; void reset_SP_RIGHT(void) {
	.dbline 250
; 	PORTJ = PORTJ & 0x7F;
	lds R24,261
	andi R24,127
	sts 261,R24
	.dbline -2
L23:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_SP_RIGHT _set_SP_RIGHT fV
	.even
_set_SP_RIGHT::
	.dbline -1
	.dbline 253
; }
; 
; void set_SP_RIGHT(void) {
	.dbline 254
; 	PORTJ = PORTJ | 0x80;
	lds R24,261
	ori R24,128
	sts 261,R24
	.dbline -2
L24:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_4A _reset_4A fV
	.even
_reset_4A::
	.dbline -1
	.dbline 257
; }
; 
; void reset_4A(void) {
	.dbline 258
; 	PORTG = PORTG & 0xFE;
	in R24,0x14
	andi R24,254
	out 0x14,R24
	.dbline -2
L25:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_4A _set_4A fV
	.even
_set_4A::
	.dbline -1
	.dbline 261
; }
; 
; void set_4A(void) {
	.dbline 262
; 	PORTG = PORTG | 0x01;
	sbi 0x14,0
	.dbline -2
L26:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_4B _reset_4B fV
	.even
_reset_4B::
	.dbline -1
	.dbline 265
; }
; 
; void reset_4B(void) {
	.dbline 266
; 	PORTD = PORTD & 0x7F;
	in R24,0xb
	andi R24,127
	out 0xb,R24
	.dbline -2
L27:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_4B _set_4B fV
	.even
_set_4B::
	.dbline -1
	.dbline 269
; }
; 
; void set_4B(void) {
	.dbline 270
; 	PORTD = PORTD | 0x80;
	sbi 0xb,7
	.dbline -2
L28:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_4C _reset_4C fV
	.even
_reset_4C::
	.dbline -1
	.dbline 273
; }
; 
; void reset_4C(void) {
	.dbline 274
; 	PORTD = PORTD & 0xBF;
	in R24,0xb
	andi R24,191
	out 0xb,R24
	.dbline -2
L29:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_4C _set_4C fV
	.even
_set_4C::
	.dbline -1
	.dbline 277
; }
; 
; void set_4C(void) {
	.dbline 278
; 	PORTD = PORTD | 0x40;
	sbi 0xb,6
	.dbline -2
L30:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_5A _reset_5A fV
	.even
_reset_5A::
	.dbline -1
	.dbline 281
; }
; 
; void reset_5A(void) {
	.dbline 282
; 	PORTJ = PORTJ & 0xDF;
	lds R24,261
	andi R24,223
	sts 261,R24
	.dbline -2
L31:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_5A _set_5A fV
	.even
_set_5A::
	.dbline -1
	.dbline 285
; }
; 
; void set_5A(void) {
	.dbline 286
; 	PORTJ = PORTJ | 0x20;
	lds R24,261
	ori R24,32
	sts 261,R24
	.dbline -2
L32:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_5B _reset_5B fV
	.even
_reset_5B::
	.dbline -1
	.dbline 289
; }
; 
; void reset_5B(void) {
	.dbline 290
; 	PORTJ = PORTJ & 0xBF;
	lds R24,261
	andi R24,191
	sts 261,R24
	.dbline -2
L33:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_5B _set_5B fV
	.even
_set_5B::
	.dbline -1
	.dbline 293
; }
; 
; void set_5B(void) {
	.dbline 294
; 	PORTJ = PORTJ | 0x40;
	lds R24,261
	ori R24,64
	sts 261,R24
	.dbline -2
L34:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_5C _reset_5C fV
	.even
_reset_5C::
	.dbline -1
	.dbline 297
; }
; 
; void reset_5C(void) {
	.dbline 298
; 	PORTJ = PORTJ & 0xEF;
	lds R24,261
	andi R24,239
	sts 261,R24
	.dbline -2
L35:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_5C _set_5C fV
	.even
_set_5C::
	.dbline -1
	.dbline 301
; }
; 
; void set_5C(void) {
	.dbline 302
; 	PORTJ = PORTJ | 0x10;
	lds R24,261
	ori R24,16
	sts 261,R24
	.dbline -2
L36:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_6A _reset_6A fV
	.even
_reset_6A::
	.dbline -1
	.dbline 305
; }
; 
; void reset_6A(void) {
	.dbline 306
; 	PORTJ = PORTJ & 0xF7;
	lds R24,261
	andi R24,247
	sts 261,R24
	.dbline -2
L37:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_6A _set_6A fV
	.even
_set_6A::
	.dbline -1
	.dbline 309
; }
; 
; void set_6A(void) {
	.dbline 310
; 	PORTJ = PORTJ | 0x08;
	lds R24,261
	ori R24,8
	sts 261,R24
	.dbline -2
L38:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_6B _reset_6B fV
	.even
_reset_6B::
	.dbline -1
	.dbline 313
; }
; 
; void reset_6B(void) {
	.dbline 314
; 	PORTJ = PORTJ & 0xFD;
	lds R24,261
	andi R24,253
	sts 261,R24
	.dbline -2
L39:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_6B _set_6B fV
	.even
_set_6B::
	.dbline -1
	.dbline 317
; }
; 
; void set_6B(void) {
	.dbline 318
; 	PORTJ = PORTJ | 0x02;
	lds R24,261
	ori R24,2
	sts 261,R24
	.dbline -2
L40:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_6C _reset_6C fV
	.even
_reset_6C::
	.dbline -1
	.dbline 321
; }
; 
; void reset_6C(void) {
	.dbline 322
; 	PORTJ = PORTJ & 0xFB;
	lds R24,261
	andi R24,251
	sts 261,R24
	.dbline -2
L41:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_6C _set_6C fV
	.even
_set_6C::
	.dbline -1
	.dbline 325
; }
; 
; void set_6C(void) {
	.dbline 326
; 	PORTJ = PORTJ | 0x04;
	lds R24,261
	ori R24,4
	sts 261,R24
	.dbline -2
L42:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 68
	jmp _timer1_compa_isr
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbfunc e timer1_compa_isr _timer1_compa_isr fV
	.even
_timer1_compa_isr::
	st -y,R0
	st -y,R1
	st -y,R2
	st -y,R3
	st -y,R4
	st -y,R5
	st -y,R6
	st -y,R7
	st -y,R8
	st -y,R9
	st -y,R16
	st -y,R17
	st -y,R18
	st -y,R19
	st -y,R24
	st -y,R25
	st -y,R26
	st -y,R27
	st -y,R30
	st -y,R31
	in R0,0x3f
	st -y,R0
	.dbline -1
	.dbline 331
; }
; 
; 
; #pragma interrupt_handler timer1_compa_isr:iv_TIM1_COMPA
; void timer1_compa_isr(void) {
	.dbline 333
; 	//compare occured TCNT1=OCR1A
; 	if (arm_number == 0) {
	lds R2,_arm_number
	tst R2
	brne L44
X0:
	.dbline 333
	.dbline 334
; 		reset_1A();
	xcall _reset_1A
	.dbline 335
; 	}
L44:
	.dbline 336
; 	if (arm_number == 1) {
	lds R24,_arm_number
	cpi R24,1
	brne L46
X1:
	.dbline 336
	.dbline 337
; 		reset_2A();
	xcall _reset_2A
	.dbline 338
; 	}
L46:
	.dbline 339
; 	if (arm_number == 2) {
	lds R24,_arm_number
	cpi R24,2
	brne L48
X2:
	.dbline 339
	.dbline 340
; 		reset_3A();
	xcall _reset_3A
	.dbline 341
; 	}
L48:
	.dbline 342
; 	if (arm_number == 3) {
	lds R24,_arm_number
	cpi R24,3
	brne L50
X3:
	.dbline 342
	.dbline 343
; 		reset_4A();
	xcall _reset_4A
	.dbline 344
; 	}
L50:
	.dbline 345
; 	if (arm_number == 4) {
	lds R24,_arm_number
	cpi R24,4
	brne L52
X4:
	.dbline 345
	.dbline 346
; 		reset_5A();
	xcall _reset_5A
	.dbline 347
; 	}
L52:
	.dbline 348
; 	if (arm_number == 5) {
	lds R24,_arm_number
	cpi R24,5
	brne L54
X5:
	.dbline 348
	.dbline 349
; 		reset_6A();
	xcall _reset_6A
	.dbline 350
; 	}
L54:
	.dbline -2
L43:
	.dbline 0 ; func end
	ld R0,y+
	out 0x3f,R0
	ld R31,y+
	ld R30,y+
	ld R27,y+
	ld R26,y+
	ld R25,y+
	ld R24,y+
	ld R19,y+
	ld R18,y+
	ld R17,y+
	ld R16,y+
	ld R9,y+
	ld R8,y+
	ld R7,y+
	ld R6,y+
	ld R5,y+
	ld R4,y+
	ld R3,y+
	ld R2,y+
	ld R1,y+
	ld R0,y+
	reti
	.dbend
	.area vector(rom, abs)
	.org 72
	jmp _timer1_compb_isr
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbfunc e timer1_compb_isr _timer1_compb_isr fV
	.even
_timer1_compb_isr::
	st -y,R0
	st -y,R1
	st -y,R2
	st -y,R3
	st -y,R4
	st -y,R5
	st -y,R6
	st -y,R7
	st -y,R8
	st -y,R9
	st -y,R16
	st -y,R17
	st -y,R18
	st -y,R19
	st -y,R24
	st -y,R25
	st -y,R26
	st -y,R27
	st -y,R30
	st -y,R31
	in R0,0x3f
	st -y,R0
	.dbline -1
	.dbline 354
; }
; 
; #pragma interrupt_handler timer1_compb_isr:iv_TIM1_COMPB
; void timer1_compb_isr(void) {
	.dbline 356
; 	//compare occured TCNT1=OCR1B
; 	if (arm_number == 0) {
	lds R2,_arm_number
	tst R2
	brne L57
X6:
	.dbline 356
	.dbline 357
; 		reset_1B();
	xcall _reset_1B
	.dbline 358
; 	}
L57:
	.dbline 359
; 	if (arm_number == 1) {
	lds R24,_arm_number
	cpi R24,1
	brne L59
X7:
	.dbline 359
	.dbline 360
; 		reset_2B();
	xcall _reset_2B
	.dbline 361
; 	}
L59:
	.dbline 362
; 	if (arm_number == 2) {
	lds R24,_arm_number
	cpi R24,2
	brne L61
X8:
	.dbline 362
	.dbline 363
; 		reset_3B();
	xcall _reset_3B
	.dbline 364
; 	}
L61:
	.dbline 365
; 	if (arm_number == 3) {
	lds R24,_arm_number
	cpi R24,3
	brne L63
X9:
	.dbline 365
	.dbline 366
; 		reset_4B();
	xcall _reset_4B
	.dbline 367
; 	}
L63:
	.dbline 368
; 	if (arm_number == 4) {
	lds R24,_arm_number
	cpi R24,4
	brne L65
X10:
	.dbline 368
	.dbline 369
; 		reset_5B();
	xcall _reset_5B
	.dbline 370
; 	}
L65:
	.dbline 371
; 	if (arm_number == 5) {
	lds R24,_arm_number
	cpi R24,5
	brne L67
X11:
	.dbline 371
	.dbline 372
; 		reset_6B();
	xcall _reset_6B
	.dbline 373
; 	}
L67:
	.dbline -2
L56:
	.dbline 0 ; func end
	ld R0,y+
	out 0x3f,R0
	ld R31,y+
	ld R30,y+
	ld R27,y+
	ld R26,y+
	ld R25,y+
	ld R24,y+
	ld R19,y+
	ld R18,y+
	ld R17,y+
	ld R16,y+
	ld R9,y+
	ld R8,y+
	ld R7,y+
	ld R6,y+
	ld R5,y+
	ld R4,y+
	ld R3,y+
	ld R2,y+
	ld R1,y+
	ld R0,y+
	reti
	.dbend
	.area vector(rom, abs)
	.org 76
	jmp _timer1_compc_isr
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbfunc e timer1_compc_isr _timer1_compc_isr fV
	.even
_timer1_compc_isr::
	st -y,R0
	st -y,R1
	st -y,R2
	st -y,R3
	st -y,R4
	st -y,R5
	st -y,R6
	st -y,R7
	st -y,R8
	st -y,R9
	st -y,R16
	st -y,R17
	st -y,R18
	st -y,R19
	st -y,R24
	st -y,R25
	st -y,R26
	st -y,R27
	st -y,R30
	st -y,R31
	in R0,0x3f
	st -y,R0
	.dbline -1
	.dbline 377
; }
; 
; #pragma interrupt_handler timer1_compc_isr:iv_TIM1_COMPC
; void timer1_compc_isr(void) {
	.dbline 379
; 	//compare occured TCNT1=OCR1c
; 	if (arm_number == 0) {
	lds R2,_arm_number
	tst R2
	brne L70
X12:
	.dbline 379
	.dbline 380
; 		reset_1C();
	xcall _reset_1C
	.dbline 381
; 	}
L70:
	.dbline 382
; 	if (arm_number == 1) {
	lds R24,_arm_number
	cpi R24,1
	brne L72
X13:
	.dbline 382
	.dbline 383
; 		reset_2C();
	xcall _reset_2C
	.dbline 384
; 	}
L72:
	.dbline 385
; 	if (arm_number == 2) {
	lds R24,_arm_number
	cpi R24,2
	brne L74
X14:
	.dbline 385
	.dbline 386
; 		reset_3C();
	xcall _reset_3C
	.dbline 387
; 	}
L74:
	.dbline 388
; 	if (arm_number == 3) {
	lds R24,_arm_number
	cpi R24,3
	brne L76
X15:
	.dbline 388
	.dbline 389
; 		reset_4C();
	xcall _reset_4C
	.dbline 390
; 	}
L76:
	.dbline 391
; 	if (arm_number == 4) {
	lds R24,_arm_number
	cpi R24,4
	brne L78
X16:
	.dbline 391
	.dbline 392
; 		reset_5C();
	xcall _reset_5C
	.dbline 393
; 	}
L78:
	.dbline 394
; 	if (arm_number == 5) {
	lds R24,_arm_number
	cpi R24,5
	brne L80
X17:
	.dbline 394
	.dbline 395
; 		reset_6C();
	xcall _reset_6C
	.dbline 396
; 	}
L80:
	.dbline -2
L69:
	.dbline 0 ; func end
	ld R0,y+
	out 0x3f,R0
	ld R31,y+
	ld R30,y+
	ld R27,y+
	ld R26,y+
	ld R25,y+
	ld R24,y+
	ld R19,y+
	ld R18,y+
	ld R17,y+
	ld R16,y+
	ld R9,y+
	ld R8,y+
	ld R7,y+
	ld R6,y+
	ld R5,y+
	ld R4,y+
	ld R3,y+
	ld R2,y+
	ld R1,y+
	ld R0,y+
	reti
	.dbend
	.area vector(rom, abs)
	.org 80
	jmp _timer1_ovf_isr
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbfunc e timer1_ovf_isr _timer1_ovf_isr fV
	.even
_timer1_ovf_isr::
	st -y,R0
	st -y,R1
	st -y,R2
	st -y,R3
	st -y,R4
	st -y,R5
	st -y,R6
	st -y,R7
	st -y,R8
	st -y,R9
	st -y,R16
	st -y,R17
	st -y,R18
	st -y,R19
	st -y,R24
	st -y,R25
	st -y,R26
	st -y,R27
	st -y,R30
	st -y,R31
	in R0,0x3f
	st -y,R0
	.dbline -1
	.dbline 400
; }
; 
; #pragma interrupt_handler timer1_ovf_isr:iv_TIM1_OVF
; void timer1_ovf_isr(void) {
	.dbline 402
; 	//TIMER1 has overflowed
; 	TCNT1H = 0x94; //reload counter high value
	ldi R24,148
	sts 133,R24
	.dbline 403
; 	TCNT1L = 0x01; //reload counter low value
	ldi R24,1
	sts 132,R24
	.dbline 404
; 	delay_count++;
	lds R24,_delay_count
	lds R25,_delay_count+1
	adiw R24,1
	sts _delay_count+1,R25
	sts _delay_count,R24
	.dbline 405
; 	arm_number++;
	lds R24,_arm_number
	subi R24,255    ; addi 1
	sts _arm_number,R24
	.dbline 406
; 	if (arm_number > 7) {
	ldi R24,7
	lds R2,_arm_number
	cp R24,R2
	brsh L83
X18:
	.dbline 406
	.dbline 407
; 		arm_number = 0;
	clr R2
	sts _arm_number,R2
	.dbline 408
; 	}
L83:
	.dbline 410
; 
; 	if (arm_number == 0) {
	lds R2,_arm_number
	tst R2
	brne L85
X19:
	.dbline 410
	.dbline 411
; 		set_1A();
	xcall _set_1A
	.dbline 412
; 		set_1B();
	xcall _set_1B
	.dbline 413
; 		set_1C();
	xcall _set_1C
	.dbline 414
; 		OCR1AH = angle_upper_byte_1A;
	lds R2,_angle_upper_byte_1A
	sts 137,R2
	.dbline 415
; 		OCR1AL = angle_lower_byte_1A;
	lds R2,_angle_lower_byte_1A
	sts 136,R2
	.dbline 416
; 		OCR1BH = angle_upper_byte_1B;
	lds R2,_angle_upper_byte_1B
	sts 139,R2
	.dbline 417
; 		OCR1BL = angle_lower_byte_1B;
	lds R2,_angle_lower_byte_1B
	sts 138,R2
	.dbline 418
; 		OCR1CH = angle_upper_byte_1C;
	lds R2,_angle_upper_byte_1C
	sts 141,R2
	.dbline 419
; 		OCR1CL = angle_lower_byte_1C;
	lds R2,_angle_lower_byte_1C
	sts 140,R2
	.dbline 420
; 	}
L85:
	.dbline 422
; 
; 	if (arm_number == 1) {
	lds R24,_arm_number
	cpi R24,1
	brne L87
X20:
	.dbline 422
	.dbline 423
; 		set_2A();
	xcall _set_2A
	.dbline 424
; 		set_2B();
	xcall _set_2B
	.dbline 425
; 		set_2C();
	xcall _set_2C
	.dbline 426
; 		OCR1AH = angle_upper_byte_2A;
	lds R2,_angle_upper_byte_2A
	sts 137,R2
	.dbline 427
; 		OCR1AL = angle_lower_byte_2A;
	lds R2,_angle_lower_byte_2A
	sts 136,R2
	.dbline 428
; 		OCR1BH = angle_upper_byte_2B;
	lds R2,_angle_upper_byte_2B
	sts 139,R2
	.dbline 429
; 		OCR1BL = angle_lower_byte_2B;
	lds R2,_angle_lower_byte_2B
	sts 138,R2
	.dbline 430
; 		OCR1CH = angle_upper_byte_2C;
	lds R2,_angle_upper_byte_2C
	sts 141,R2
	.dbline 431
; 		OCR1CL = angle_lower_byte_2C;
	lds R2,_angle_lower_byte_2C
	sts 140,R2
	.dbline 432
; 	}
L87:
	.dbline 434
; 
; 	if (arm_number == 2) {
	lds R24,_arm_number
	cpi R24,2
	brne L89
X21:
	.dbline 434
	.dbline 435
; 		set_3A();
	xcall _set_3A
	.dbline 436
; 		set_3B();
	xcall _set_3B
	.dbline 437
; 		set_3C();
	xcall _set_3C
	.dbline 438
; 		OCR1AH = angle_upper_byte_3A;
	lds R2,_angle_upper_byte_3A
	sts 137,R2
	.dbline 439
; 		OCR1AL = angle_lower_byte_3A;
	lds R2,_angle_lower_byte_3A
	sts 136,R2
	.dbline 440
; 		OCR1BH = angle_upper_byte_3B;
	lds R2,_angle_upper_byte_3B
	sts 139,R2
	.dbline 441
; 		OCR1BL = angle_lower_byte_3B;
	lds R2,_angle_lower_byte_3B
	sts 138,R2
	.dbline 442
; 		OCR1CH = angle_upper_byte_3C;
	lds R2,_angle_upper_byte_3C
	sts 141,R2
	.dbline 443
; 		OCR1CL = angle_lower_byte_3C;
	lds R2,_angle_lower_byte_3C
	sts 140,R2
	.dbline 444
; 	}
L89:
	.dbline 446
; 
; 	if (arm_number == 3) {
	lds R24,_arm_number
	cpi R24,3
	brne L91
X22:
	.dbline 446
	.dbline 447
; 		set_4A();
	xcall _set_4A
	.dbline 448
; 		set_4B();
	xcall _set_4B
	.dbline 449
; 		set_4C();
	xcall _set_4C
	.dbline 450
; 		OCR1AH = angle_upper_byte_4A;
	lds R2,_angle_upper_byte_4A
	sts 137,R2
	.dbline 451
; 		OCR1AL = angle_lower_byte_4A;
	lds R2,_angle_lower_byte_4A
	sts 136,R2
	.dbline 452
; 		OCR1BH = angle_upper_byte_4B;
	lds R2,_angle_upper_byte_4B
	sts 139,R2
	.dbline 453
; 		OCR1BL = angle_lower_byte_4B;
	lds R2,_angle_lower_byte_4B
	sts 138,R2
	.dbline 454
; 		OCR1CH = angle_upper_byte_4C;
	lds R2,_angle_upper_byte_4C
	sts 141,R2
	.dbline 455
; 		OCR1CL = angle_lower_byte_4C;
	lds R2,_angle_lower_byte_4C
	sts 140,R2
	.dbline 456
; 	}
L91:
	.dbline 458
; 
; 	if (arm_number == 4) {
	lds R24,_arm_number
	cpi R24,4
	brne L93
X23:
	.dbline 458
	.dbline 459
; 		set_5A();
	xcall _set_5A
	.dbline 460
; 		set_5B();
	xcall _set_5B
	.dbline 461
; 		set_5C();
	xcall _set_5C
	.dbline 462
; 		OCR1AH = angle_upper_byte_5A;
	lds R2,_angle_upper_byte_5A
	sts 137,R2
	.dbline 463
; 		OCR1AL = angle_lower_byte_5A;
	lds R2,_angle_lower_byte_5A
	sts 136,R2
	.dbline 464
; 		OCR1BH = angle_upper_byte_5B;
	lds R2,_angle_upper_byte_5B
	sts 139,R2
	.dbline 465
; 		OCR1BL = angle_lower_byte_5B;
	lds R2,_angle_lower_byte_5B
	sts 138,R2
	.dbline 466
; 		OCR1CH = angle_upper_byte_5C;
	lds R2,_angle_upper_byte_5C
	sts 141,R2
	.dbline 467
; 		OCR1CL = angle_lower_byte_5C;
	lds R2,_angle_lower_byte_5C
	sts 140,R2
	.dbline 468
; 	}
L93:
	.dbline 470
; 
; 	if (arm_number == 5) {
	lds R24,_arm_number
	cpi R24,5
	brne L95
X24:
	.dbline 470
	.dbline 471
; 		set_6A();
	xcall _set_6A
	.dbline 472
; 		set_6B();
	xcall _set_6B
	.dbline 473
; 		set_6C();
	xcall _set_6C
	.dbline 474
; 		OCR1AH = angle_upper_byte_6A;
	lds R2,_angle_upper_byte_6A
	sts 137,R2
	.dbline 475
; 		OCR1AL = angle_lower_byte_6A;
	lds R2,_angle_lower_byte_6A
	sts 136,R2
	.dbline 476
; 		OCR1BH = angle_upper_byte_6B;
	lds R2,_angle_upper_byte_6B
	sts 139,R2
	.dbline 477
; 		OCR1BL = angle_lower_byte_6B;
	lds R2,_angle_lower_byte_6B
	sts 138,R2
	.dbline 478
; 		OCR1CH = angle_upper_byte_6C;
	lds R2,_angle_upper_byte_6C
	sts 141,R2
	.dbline 479
; 		OCR1CL = angle_lower_byte_6C;
	lds R2,_angle_lower_byte_6C
	sts 140,R2
	.dbline 480
; 	}
L95:
	.dbline -2
L82:
	.dbline 0 ; func end
	ld R0,y+
	out 0x3f,R0
	ld R31,y+
	ld R30,y+
	ld R27,y+
	ld R26,y+
	ld R25,y+
	ld R24,y+
	ld R19,y+
	ld R18,y+
	ld R17,y+
	ld R16,y+
	ld R9,y+
	ld R8,y+
	ld R7,y+
	ld R6,y+
	ld R5,y+
	ld R4,y+
	ld R3,y+
	ld R2,y+
	ld R1,y+
	ld R0,y+
	reti
	.dbend
	.dbfunc e uart0_init _uart0_init fV
	.even
_uart0_init::
	.dbline -1
	.dbline 502
; 	//serial communication related code
; 	/*serial_communication_interval++;
; 	if (serial_communication_interval > 40) //gives time interval of 40*2.5ms = 100ms
; 	{
; 		serial_communication_interval = 0;
; 		serial_communication_channel_number++;
; 		if (serial_communication_channel_number > 4) //set maximum number of command (can be set up to 7)
; 		{
; 			serial_communication_channel_number = 3; //set first command to begin with (can be set up to 1)
; 		}
; 		UDR0 = serial_communication_channel_number;
; 	}*/
; }
; 
; 
; //UART0 initialize
; // desired baud rate: 9600
; // actual: baud rate:9600 (0.0%)
; // char size: 8 bit
; // parity: Disabled
; void uart0_init(void) 
; {
	.dbline 503
; 	UCSR0B = 0x00; //disable while setting baud rate
	clr R2
	sts 193,R2
	.dbline 504
; 	UCSR0A = 0x00;
	sts 192,R2
	.dbline 505
; 	UCSR0C = 0x06;
	ldi R24,6
	sts 194,R24
	.dbline 506
; 	UBRR0L = 0x47; //set baud rate lo (can be 0x5f)
	ldi R24,71
	sts 196,R24
	.dbline 507
; 	UBRR0H = 0x00; //set baud rate hi
	sts 197,R2
	.dbline 508
; 	UCSR0B = 0x98;
	ldi R24,152
	sts 193,R24
	.dbline -2
L97:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e init_devices _init_devices fV
	.even
_init_devices::
	.dbline -1
	.dbline 513
; }
; 
; //call this routine to initialize all peripherals
; void init_devices(void) 
; {
	.dbline 515
; 	//stop errant interrupts until set up
; 	CLI(); //disable all interrupts
	cli
	.dbline 516
; 	XMCRA = 0x00; //external memory
	clr R2
	sts 116,R2
	.dbline 517
; 	XMCRB = 0x00; //external memory
	sts 117,R2
	.dbline 518
; 	port_init();
	xcall _port_init
	.dbline 519
; 	timer1_init();
	xcall _timer1_init
	.dbline 520
; 	uart0_init();
	xcall _uart0_init
	.dbline 522
; 			
; 	MCUCR = 0x00;
	clr R2
	out 0x35,R2
	.dbline 523
; 	EICRA = 0x00; //pin change int edge 0:3
	sts 105,R2
	.dbline 524
; 	EICRB = 0x00; //pin change int edge 4:7
	sts 106,R2
	.dbline 525
; 	PCICR = 0x00; //pin change int enable
	sts 104,R2
	.dbline 526
; 	PCMSK0 = 0x00; //pin change mask
	sts 107,R2
	.dbline 527
; 	PCMSK1 = 0x00; //pin change mask
	sts 108,R2
	.dbline 528
; 	PCMSK2 = 0x00; //pin change mask
	sts 109,R2
	.dbline 529
; 	EIMSK = 0x00;
	out 0x1d,R2
	.dbline 530
; 	TIMSK0 = 0x00; //timer0 interrupt sources
	sts 110,R2
	.dbline 531
; 	TIMSK1 = 0x0F; //timer1 interrupt sources
	ldi R24,15
	sts 111,R24
	.dbline 532
; 	TIMSK2 = 0x00; //timer2 interrupt sources
	sts 112,R2
	.dbline 533
; 	TIMSK3 = 0x00; //timer3 interrupt sources
	sts 113,R2
	.dbline 534
; 	TIMSK4 = 0x00; //timer4 interrupt sources
	sts 114,R2
	.dbline 535
; 	TIMSK5 = 0x00; //timer5 interrupt sources
	sts 115,R2
	.dbline 537
; 
; 	SEI(); //re-enable interrupts
	sei
	.dbline -2
L98:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 100
	jmp _uart0_rx_isr
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	.dbfunc e uart0_rx_isr _uart0_rx_isr fV
	.even
_uart0_rx_isr::
	st -y,R0
	st -y,R1
	st -y,R2
	st -y,R3
	st -y,R4
	st -y,R5
	st -y,R6
	st -y,R7
	st -y,R8
	st -y,R9
	st -y,R16
	st -y,R17
	st -y,R18
	st -y,R19
	st -y,R24
	st -y,R25
	st -y,R26
	st -y,R27
	st -y,R30
	st -y,R31
	in R0,0x3f
	st -y,R0
	.dbline -1
	.dbline 543
; 	//all peripherals are now initialized
; }
; 
; #pragma interrupt_handler uart0_rx_isr:iv_USART0_RXC
; void uart0_rx_isr(void) 
; {
	.dbline 545
; 	//uart has received a character in UDR	
; 	data = UDR0;
	lds R2,198
	sts _data,R2
	.dbline 546
; 	UDR0 = data;
	sts 198,R2
	.dbline 547
; 	if(KEYBOARD_ON)
	.dbline 548
; 	    keyboard_control();
	xcall _keyboard_control
L100:
	.dbline -2
L99:
	.dbline 0 ; func end
	ld R0,y+
	out 0x3f,R0
	ld R31,y+
	ld R30,y+
	ld R27,y+
	ld R26,y+
	ld R25,y+
	ld R24,y+
	ld R19,y+
	ld R18,y+
	ld R17,y+
	ld R16,y+
	ld R9,y+
	ld R8,y+
	ld R7,y+
	ld R6,y+
	ld R5,y+
	ld R4,y+
	ld R3,y+
	ld R2,y+
	ld R1,y+
	ld R0,y+
	reti
	.dbend
	.dbfunc e servo_on _servo_on fV
	.even
_servo_on::
	.dbline -1
	.dbline 551
; }
; 
; void servo_on(void) {
	.dbline 552
; 	PORTB = PORTB | 0x01;
	sbi 0x5,0
	.dbline -2
L102:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e servo_off _servo_off fV
	.even
_servo_off::
	.dbline -1
	.dbline 555
; }
; 
; void servo_off(void) {
	.dbline 556
; 	PORTB = PORTB & 0xFE;
	in R24,0x5
	andi R24,254
	out 0x5,R24
	.dbline -2
L103:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e reset_SP_LEFT _reset_SP_LEFT fV
	.even
_reset_SP_LEFT::
	.dbline -1
	.dbline 559
; }
; 
; void reset_SP_LEFT(void) {
	.dbline 560
; 	PORTL = PORTL & 0xFD;
	lds R24,267
	andi R24,253
	sts 267,R24
	.dbline -2
L104:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e set_SP_LEFT _set_SP_LEFT fV
	.even
_set_SP_LEFT::
	.dbline -1
	.dbline 563
; }
; 
; void set_SP_LEFT(void) {
	.dbline 564
; 	PORTL = PORTL | 0x02;
	lds R24,267
	ori R24,2
	sts 267,R24
	.dbline -2
L105:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e angle_value_calculation _angle_value_calculation fV
;           temp -> R16,R17
;    angle_value -> R18,R19
	.even
_angle_value_calculation::
	.dbline -1
	.dbline 568
; }
; 
; 
; void angle_value_calculation(void) {
	.dbline 569
; 	unsigned int angle_value = 0;
	clr R18
	clr R19
	.dbline 570
; 	unsigned int temp = 0;
	clr R16
	clr R17
	.dbline 571
; 	if (degree > 180)
	ldi R24,180
	lds R2,_degree
	cp R24,R2
	brsh L107
X25:
	.dbline 572
; 		degree = 180; // limiting the scope of the servo rotation
	sts _degree,R24
L107:
	.dbline 574
; 
; 	angle_value = 0xBF39 + (64 * (unsigned char) degree); //actual constant is 64.4
	lds R2,_degree
	ldi R24,64
	mul R24,R2
	movw R18,R0
	subi R18,199  ; offset = 48953
	sbci R19,64
	.dbline 576
; 
; 	angle_lower_byte = (unsigned char) angle_value; //separating the lower byte
	sts _angle_lower_byte,R18
	.dbline 578
; 
; 	temp = angle_value >> 8;
	movw R16,R18
	mov R16,R17
	clr R17
	.dbline 579
; 	angle_upper_byte = (unsigned char) temp; //separating the upper byte
	sts _angle_upper_byte,R16
	.dbline -2
L106:
	.dbline 0 ; func end
	ret
	.dbsym r temp 16 i
	.dbsym r angle_value 18 i
	.dbend
	.dbfunc e angle_1A _angle_1A fV
;          angle -> R10
	.even
_angle_1A::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 582
; }
; 
; void angle_1A(unsigned char angle) {
	.dbline 583
; 	degree = angle;
	sts _degree,R10
	.dbline 584
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 585
; 	angle_upper_byte_1A = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_1A,R2
	.dbline 586
; 	angle_lower_byte_1A = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_1A,R2
	.dbline -2
L109:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_1B _angle_1B fV
;          angle -> R10
	.even
_angle_1B::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 589
; }
; 
; void angle_1B(unsigned char angle) {
	.dbline 590
; 	degree = angle;
	sts _degree,R10
	.dbline 591
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 592
; 	angle_upper_byte_1B = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_1B,R2
	.dbline 593
; 	angle_lower_byte_1B = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_1B,R2
	.dbline -2
L110:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_1C _angle_1C fV
;          angle -> R10
	.even
_angle_1C::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 596
; }
; 
; void angle_1C(unsigned char angle) {
	.dbline 597
; 	degree = angle;
	sts _degree,R10
	.dbline 598
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 599
; 	angle_upper_byte_1C = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_1C,R2
	.dbline 600
; 	angle_lower_byte_1C = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_1C,R2
	.dbline -2
L111:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_2A _angle_2A fV
;          angle -> R10
	.even
_angle_2A::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 603
; }
; 
; void angle_2A(unsigned char angle) {
	.dbline 604
; 	degree = angle;
	sts _degree,R10
	.dbline 605
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 606
; 	angle_upper_byte_2A = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_2A,R2
	.dbline 607
; 	angle_lower_byte_2A = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_2A,R2
	.dbline -2
L112:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_2B _angle_2B fV
;          angle -> R10
	.even
_angle_2B::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 610
; }
; 
; void angle_2B(unsigned char angle) {
	.dbline 611
; 	degree = angle;
	sts _degree,R10
	.dbline 612
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 613
; 	angle_upper_byte_2B = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_2B,R2
	.dbline 614
; 	angle_lower_byte_2B = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_2B,R2
	.dbline -2
L113:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_2C _angle_2C fV
;          angle -> R10
	.even
_angle_2C::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 617
; }
; 
; void angle_2C(unsigned char angle) {
	.dbline 618
; 	degree = angle;
	sts _degree,R10
	.dbline 619
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 620
; 	angle_upper_byte_2C = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_2C,R2
	.dbline 621
; 	angle_lower_byte_2C = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_2C,R2
	.dbline -2
L114:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_3A _angle_3A fV
;          angle -> R10
	.even
_angle_3A::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 624
; }
; 
; void angle_3A(unsigned char angle) {
	.dbline 625
; 	degree = angle;
	sts _degree,R10
	.dbline 626
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 627
; 	angle_upper_byte_3A = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_3A,R2
	.dbline 628
; 	angle_lower_byte_3A = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_3A,R2
	.dbline -2
L115:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_3B _angle_3B fV
;          angle -> R10
	.even
_angle_3B::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 631
; }
; 
; void angle_3B(unsigned char angle) {
	.dbline 632
; 	degree = angle;
	sts _degree,R10
	.dbline 633
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 634
; 	angle_upper_byte_3B = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_3B,R2
	.dbline 635
; 	angle_lower_byte_3B = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_3B,R2
	.dbline -2
L116:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_3C _angle_3C fV
;          angle -> R10
	.even
_angle_3C::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 638
; }
; 
; void angle_3C(unsigned char angle) {
	.dbline 639
; 	degree = angle;
	sts _degree,R10
	.dbline 640
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 641
; 	angle_upper_byte_3C = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_3C,R2
	.dbline 642
; 	angle_lower_byte_3C = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_3C,R2
	.dbline -2
L117:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_4A _angle_4A fV
;          angle -> R10
	.even
_angle_4A::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 645
; }
; 
; void angle_4A(unsigned char angle) {
	.dbline 646
; 	degree = angle;
	sts _degree,R10
	.dbline 647
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 648
; 	angle_upper_byte_4A = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_4A,R2
	.dbline 649
; 	angle_lower_byte_4A = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_4A,R2
	.dbline -2
L118:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_4B _angle_4B fV
;          angle -> R10
	.even
_angle_4B::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 652
; }
; 
; void angle_4B(unsigned char angle) {
	.dbline 653
; 	degree = angle;
	sts _degree,R10
	.dbline 654
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 655
; 	angle_upper_byte_4B = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_4B,R2
	.dbline 656
; 	angle_lower_byte_4B = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_4B,R2
	.dbline -2
L119:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_4C _angle_4C fV
;          angle -> R10
	.even
_angle_4C::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 659
; }
; 
; void angle_4C(unsigned char angle) {
	.dbline 660
; 	degree = angle;
	sts _degree,R10
	.dbline 661
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 662
; 	angle_upper_byte_4C = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_4C,R2
	.dbline 663
; 	angle_lower_byte_4C = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_4C,R2
	.dbline -2
L120:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_5A _angle_5A fV
;          angle -> R10
	.even
_angle_5A::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 666
; }
; 
; void angle_5A(unsigned char angle) {
	.dbline 667
; 	degree = angle;
	sts _degree,R10
	.dbline 668
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 669
; 	angle_upper_byte_5A = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_5A,R2
	.dbline 670
; 	angle_lower_byte_5A = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_5A,R2
	.dbline -2
L121:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_5B _angle_5B fV
;          angle -> R10
	.even
_angle_5B::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 673
; }
; 
; void angle_5B(unsigned char angle) {
	.dbline 674
; 	degree = angle;
	sts _degree,R10
	.dbline 675
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 676
; 	angle_upper_byte_5B = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_5B,R2
	.dbline 677
; 	angle_lower_byte_5B = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_5B,R2
	.dbline -2
L122:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_5C _angle_5C fV
;          angle -> R10
	.even
_angle_5C::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 680
; }
; 
; void angle_5C(unsigned char angle) {
	.dbline 681
; 	degree = angle;
	sts _degree,R10
	.dbline 682
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 683
; 	angle_upper_byte_5C = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_5C,R2
	.dbline 684
; 	angle_lower_byte_5C = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_5C,R2
	.dbline -2
L123:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_6A _angle_6A fV
;          angle -> R10
	.even
_angle_6A::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 687
; }
; 
; void angle_6A(unsigned char angle) {
	.dbline 688
; 	degree = angle;
	sts _degree,R10
	.dbline 689
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 690
; 	angle_upper_byte_6A = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_6A,R2
	.dbline 691
; 	angle_lower_byte_6A = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_6A,R2
	.dbline -2
L124:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_6B _angle_6B fV
;          angle -> R10
	.even
_angle_6B::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 694
; }
; 
; void angle_6B(unsigned char angle) {
	.dbline 695
; 	degree = angle;
	sts _degree,R10
	.dbline 696
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 697
; 	angle_upper_byte_6B = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_6B,R2
	.dbline 698
; 	angle_lower_byte_6B = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_6B,R2
	.dbline -2
L125:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e angle_6C _angle_6C fV
;          angle -> R10
	.even
_angle_6C::
	st -y,R10
	mov R10,R16
	.dbline -1
	.dbline 701
; }
; 
; void angle_6C(unsigned char angle) {
	.dbline 702
; 	degree = angle;
	sts _degree,R10
	.dbline 703
; 	angle_value_calculation();
	xcall _angle_value_calculation
	.dbline 704
; 	angle_upper_byte_6C = angle_upper_byte;
	lds R2,_angle_upper_byte
	sts _angle_upper_byte_6C,R2
	.dbline 705
; 	angle_lower_byte_6C = angle_lower_byte;
	lds R2,_angle_lower_byte
	sts _angle_lower_byte_6C,R2
	.dbline -2
L126:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r angle 10 c
	.dbend
	.dbfunc e servo_calibration _servo_calibration fV
	.even
_servo_calibration::
	.dbline -1
	.dbline 708
; }
; 
; void servo_calibration(void) {
	.dbline 709
; 	angle_1A(90);
	ldi R16,90
	xcall _angle_1A
	.dbline 710
; 	angle_1B(90);
	ldi R16,90
	xcall _angle_1B
	.dbline 711
; 	angle_1C(90);
	ldi R16,90
	xcall _angle_1C
	.dbline 712
; 	angle_2A(90);
	ldi R16,90
	xcall _angle_2A
	.dbline 713
; 	angle_2B(90);
	ldi R16,90
	xcall _angle_2B
	.dbline 714
; 	angle_2C(90);
	ldi R16,90
	xcall _angle_2C
	.dbline 715
; 	angle_3A(90);
	ldi R16,90
	xcall _angle_3A
	.dbline 716
; 	angle_3B(90);
	ldi R16,90
	xcall _angle_3B
	.dbline 717
; 	angle_3C(90);
	ldi R16,90
	xcall _angle_3C
	.dbline 718
; 	angle_4A(90);
	ldi R16,90
	xcall _angle_4A
	.dbline 719
; 	angle_4B(90);
	ldi R16,90
	xcall _angle_4B
	.dbline 720
; 	angle_4C(90);
	ldi R16,90
	xcall _angle_4C
	.dbline 721
; 	angle_5A(90);
	ldi R16,90
	xcall _angle_5A
	.dbline 722
; 	angle_5B(90);
	ldi R16,90
	xcall _angle_5B
	.dbline 723
; 	angle_5C(90);
	ldi R16,90
	xcall _angle_5C
	.dbline 724
; 	angle_6A(90);
	ldi R16,90
	xcall _angle_6A
	.dbline 725
; 	angle_6B(90);
	ldi R16,90
	xcall _angle_6B
	.dbline 726
; 	angle_6C(90);
	ldi R16,90
	xcall _angle_6C
	.dbline -2
L127:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e even_A_servo_90 _even_A_servo_90 fV
	.even
_even_A_servo_90::
	.dbline -1
	.dbline 729
; }
; 
; void even_A_servo_90(void) {
	.dbline 730
; 	angle_2A(90);
	ldi R16,90
	xcall _angle_2A
	.dbline 731
; 	angle_4A(90);
	ldi R16,90
	xcall _angle_4A
	.dbline 732
; 	angle_6A(90);
	ldi R16,90
	xcall _angle_6A
	.dbline -2
L128:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e even_A_servo_65 _even_A_servo_65 fV
	.even
_even_A_servo_65::
	.dbline -1
	.dbline 736
; }
; 
; void even_A_servo_65(void) //clockwise
; {
	.dbline 737
; 	angle_2A(65);
	ldi R16,65
	xcall _angle_2A
	.dbline 738
; 	angle_4A(65);
	ldi R16,65
	xcall _angle_4A
	.dbline 739
; 	angle_6A(65);
	ldi R16,65
	xcall _angle_6A
	.dbline -2
L129:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e even_A_servo_115 _even_A_servo_115 fV
	.even
_even_A_servo_115::
	.dbline -1
	.dbline 743
; }
; 
; void even_A_servo_115(void)//anticlockwise_
; {
	.dbline 744
; 	angle_2A(115);
	ldi R16,115
	xcall _angle_2A
	.dbline 745
; 	angle_4A(115);
	ldi R16,115
	xcall _angle_4A
	.dbline 746
; 	angle_6A(115);
	ldi R16,115
	xcall _angle_6A
	.dbline -2
L130:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e even_BC_servo_90 _even_BC_servo_90 fV
	.even
_even_BC_servo_90::
	.dbline -1
	.dbline 749
; }
; 
; void even_BC_servo_90(void) {
	.dbline 750
; 	angle_2B(90);
	ldi R16,90
	xcall _angle_2B
	.dbline 751
; 	angle_2C(90);
	ldi R16,90
	xcall _angle_2C
	.dbline 752
; 	angle_4B(90);
	ldi R16,90
	xcall _angle_4B
	.dbline 753
; 	angle_4C(90);
	ldi R16,90
	xcall _angle_4C
	.dbline 754
; 	angle_6B(90);
	ldi R16,90
	xcall _angle_6B
	.dbline 755
; 	angle_6C(90);
	ldi R16,90
	xcall _angle_6C
	.dbline -2
L131:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e even_BC_servo_up_45 _even_BC_servo_up_45 fV
	.even
_even_BC_servo_up_45::
	.dbline -1
	.dbline 758
; }
; 
; void even_BC_servo_up_45(void) {
	.dbline 759
; 	angle_2B(45);
	ldi R16,45
	xcall _angle_2B
	.dbline 760
; 	angle_2C(90);
	ldi R16,90
	xcall _angle_2C
	.dbline 761
; 	angle_4B(135);
	ldi R16,135
	xcall _angle_4B
	.dbline 762
; 	angle_4C(90);
	ldi R16,90
	xcall _angle_4C
	.dbline 763
; 	angle_6B(135);
	ldi R16,135
	xcall _angle_6B
	.dbline 764
; 	angle_6C(90);
	ldi R16,90
	xcall _angle_6C
	.dbline -2
L132:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e even_BC_servo_down_45 _even_BC_servo_down_45 fV
	.even
_even_BC_servo_down_45::
	.dbline -1
	.dbline 767
; }
; 
; void even_BC_servo_down_45(void) {
	.dbline 768
; 	angle_2B(135);
	ldi R16,135
	xcall _angle_2B
	.dbline 769
; 	angle_2C(135);
	ldi R16,135
	xcall _angle_2C
	.dbline 770
; 	angle_4B(45);
	ldi R16,45
	xcall _angle_4B
	.dbline 771
; 	angle_4C(45);
	ldi R16,45
	xcall _angle_4C
	.dbline 772
; 	angle_6B(45);
	ldi R16,45
	xcall _angle_6B
	.dbline 773
; 	angle_6C(45);
	ldi R16,45
	xcall _angle_6C
	.dbline -2
L133:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e odd_A_servo_90 _odd_A_servo_90 fV
	.even
_odd_A_servo_90::
	.dbline -1
	.dbline 776
; }
; 
; void odd_A_servo_90(void) {
	.dbline 777
; 	angle_1A(90);
	ldi R16,90
	xcall _angle_1A
	.dbline 778
; 	angle_3A(90);
	ldi R16,90
	xcall _angle_3A
	.dbline 779
; 	angle_5A(90);
	ldi R16,90
	xcall _angle_5A
	.dbline -2
L134:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e odd_A_servo_65 _odd_A_servo_65 fV
	.even
_odd_A_servo_65::
	.dbline -1
	.dbline 783
; }
; 
; void odd_A_servo_65(void)//clockwise
; {
	.dbline 784
; 	angle_1A(65);
	ldi R16,65
	xcall _angle_1A
	.dbline 785
; 	angle_3A(65);
	ldi R16,65
	xcall _angle_3A
	.dbline 786
; 	angle_5A(65);
	ldi R16,65
	xcall _angle_5A
	.dbline -2
L135:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e odd_A_servo_115 _odd_A_servo_115 fV
	.even
_odd_A_servo_115::
	.dbline -1
	.dbline 790
; }
; 
; void odd_A_servo_115(void) //anticlockwise
; {
	.dbline 791
; 	angle_1A(115);
	ldi R16,115
	xcall _angle_1A
	.dbline 792
; 	angle_3A(115);
	ldi R16,115
	xcall _angle_3A
	.dbline 793
; 	angle_5A(115);
	ldi R16,115
	xcall _angle_5A
	.dbline -2
L136:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e odd_BC_servo_90 _odd_BC_servo_90 fV
	.even
_odd_BC_servo_90::
	.dbline -1
	.dbline 796
; }
; 
; void odd_BC_servo_90(void) {
	.dbline 797
; 	angle_1B(90);
	ldi R16,90
	xcall _angle_1B
	.dbline 798
; 	angle_1C(90);
	ldi R16,90
	xcall _angle_1C
	.dbline 799
; 	angle_3B(90);
	ldi R16,90
	xcall _angle_3B
	.dbline 800
; 	angle_3C(90);
	ldi R16,90
	xcall _angle_3C
	.dbline 801
; 	angle_5B(90);
	ldi R16,90
	xcall _angle_5B
	.dbline 802
; 	angle_5C(90);
	ldi R16,90
	xcall _angle_5C
	.dbline -2
L137:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e odd_BC_servo_up_45 _odd_BC_servo_up_45 fV
	.even
_odd_BC_servo_up_45::
	.dbline -1
	.dbline 805
; }
; 
; void odd_BC_servo_up_45(void) {
	.dbline 806
; 	angle_1B(45);
	ldi R16,45
	xcall _angle_1B
	.dbline 807
; 	angle_1C(90);
	ldi R16,90
	xcall _angle_1C
	.dbline 808
; 	angle_3B(45);
	ldi R16,45
	xcall _angle_3B
	.dbline 809
; 	angle_3C(90);
	ldi R16,90
	xcall _angle_3C
	.dbline 810
; 	angle_5B(135);
	ldi R16,135
	xcall _angle_5B
	.dbline 811
; 	angle_5C(90);
	ldi R16,90
	xcall _angle_5C
	.dbline -2
L138:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e odd_BC_servo_down_45 _odd_BC_servo_down_45 fV
	.even
_odd_BC_servo_down_45::
	.dbline -1
	.dbline 814
; }
; 
; void odd_BC_servo_down_45(void) {
	.dbline 815
; 	angle_1B(135);
	ldi R16,135
	xcall _angle_1B
	.dbline 816
; 	angle_1C(135);
	ldi R16,135
	xcall _angle_1C
	.dbline 817
; 	angle_3B(135);
	ldi R16,135
	xcall _angle_3B
	.dbline 818
; 	angle_3C(135);
	ldi R16,135
	xcall _angle_3C
	.dbline 819
; 	angle_5B(45);
	ldi R16,45
	xcall _angle_5B
	.dbline 820
; 	angle_5C(45);
	ldi R16,45
	xcall _angle_5C
	.dbline -2
L139:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e robot_rotate_clockwise_7_5 _robot_rotate_clockwise_7_5 fV
	.even
_robot_rotate_clockwise_7_5::
	.dbline -1
	.dbline 823
; }
; 
; void robot_rotate_clockwise_7_5(void) {
	.dbline 824
; 	motion_busy = 1;
	ldi R24,1
	sts _motion_busy,R24
	.dbline 825
; 	servo_calibration();
	xcall _servo_calibration
	.dbline 826
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 827
; 	even_A_servo_65();
	xcall _even_A_servo_65
	.dbline 828
; 	even_BC_servo_up_45();
	xcall _even_BC_servo_up_45
	.dbline 829
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 830
; 	even_BC_servo_90();
	xcall _even_BC_servo_90
	.dbline 831
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 832
; 	odd_A_servo_65();
	xcall _odd_A_servo_65
	.dbline 833
; 	odd_BC_servo_up_45();
	xcall _odd_BC_servo_up_45
	.dbline 834
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 835
; 	odd_BC_servo_90();
	xcall _odd_BC_servo_90
	.dbline 836
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 837
; 	even_A_servo_90();
	xcall _even_A_servo_90
	.dbline 838
; 	odd_A_servo_90();
	xcall _odd_A_servo_90
	.dbline 839
; 	motion_busy = 0;
	clr R2
	sts _motion_busy,R2
	.dbline -2
L140:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e robot_rotate_anticlockwise_7_5 _robot_rotate_anticlockwise_7_5 fV
	.even
_robot_rotate_anticlockwise_7_5::
	.dbline -1
	.dbline 842
; }
; 
; void robot_rotate_anticlockwise_7_5(void) {
	.dbline 843
; 	motion_busy = 1;
	ldi R24,1
	sts _motion_busy,R24
	.dbline 844
; 	servo_calibration();
	xcall _servo_calibration
	.dbline 845
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 846
; 	even_A_servo_115();
	xcall _even_A_servo_115
	.dbline 847
; 	even_BC_servo_up_45();
	xcall _even_BC_servo_up_45
	.dbline 848
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 849
; 	even_BC_servo_90();
	xcall _even_BC_servo_90
	.dbline 850
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 851
; 	odd_A_servo_115();
	xcall _odd_A_servo_115
	.dbline 852
; 	odd_BC_servo_up_45();
	xcall _odd_BC_servo_up_45
	.dbline 853
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 854
; 	odd_BC_servo_90();
	xcall _odd_BC_servo_90
	.dbline 855
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 856
; 	even_A_servo_90();
	xcall _even_A_servo_90
	.dbline 857
; 	odd_A_servo_90();
	xcall _odd_A_servo_90
	.dbline 858
; 	motion_busy = 0;
	clr R2
	sts _motion_busy,R2
	.dbline -2
L141:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e forward _forward fV
	.even
_forward::
	.dbline -1
	.dbline 862
; }
; 
; //forward by using two legs at a time
; void forward(void) {
	.dbline 863
; 	motion_busy = 1;
	ldi R24,1
	sts _motion_busy,R24
	.dbline 864
; 	servo_calibration();
	xcall _servo_calibration
	.dbline 865
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 868
; 
; 	//legs 2 and 4 move forward
; 	angle_2B(45);
	ldi R16,45
	xcall _angle_2B
	.dbline 869
; 	angle_2C(45);
	ldi R16,45
	xcall _angle_2C
	.dbline 870
; 	angle_4B(135);
	ldi R16,135
	xcall _angle_4B
	.dbline 871
; 	angle_4C(135); //front pair BC servo up 45
	ldi R16,135
	xcall _angle_4C
	.dbline 872
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 873
; 	angle_2A(45);
	ldi R16,45
	xcall _angle_2A
	.dbline 874
; 	angle_4A(135); //front pair move forward while legs are up
	ldi R16,135
	xcall _angle_4A
	.dbline 875
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 876
; 	angle_2B(90);
	ldi R16,90
	xcall _angle_2B
	.dbline 877
; 	angle_2C(90);
	ldi R16,90
	xcall _angle_2C
	.dbline 878
; 	angle_4B(90);
	ldi R16,90
	xcall _angle_4B
	.dbline 879
; 	angle_4C(90); // put down legs
	ldi R16,90
	xcall _angle_4C
	.dbline 880
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 884
; 
; 	//legs 1 and 6 move forward
; 
; 	angle_1B(45);
	ldi R16,45
	xcall _angle_1B
	.dbline 885
; 	angle_1C(45);
	ldi R16,45
	xcall _angle_1C
	.dbline 886
; 	angle_6B(135);
	ldi R16,135
	xcall _angle_6B
	.dbline 887
; 	angle_6C(135); //middel pair BC servo up 45
	ldi R16,135
	xcall _angle_6C
	.dbline 888
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 889
; 	angle_1A(45);
	ldi R16,45
	xcall _angle_1A
	.dbline 890
; 	angle_6A(135); //middel pair move back while legs are up
	ldi R16,135
	xcall _angle_6A
	.dbline 891
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 892
; 	angle_1B(90);
	ldi R16,90
	xcall _angle_1B
	.dbline 893
; 	angle_1C(90);
	ldi R16,90
	xcall _angle_1C
	.dbline 894
; 	angle_6B(90);
	ldi R16,90
	xcall _angle_6B
	.dbline 895
; 	angle_6C(90); // put down legs
	ldi R16,90
	xcall _angle_6C
	.dbline 896
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 899
; 
; 	//legs 3 and 5 move forward
; 	angle_3B(45);
	ldi R16,45
	xcall _angle_3B
	.dbline 900
; 	angle_3C(45);
	ldi R16,45
	xcall _angle_3C
	.dbline 901
; 	angle_5B(135);
	ldi R16,135
	xcall _angle_5B
	.dbline 902
; 	angle_5C(135); //middel pair BC servo up 45
	ldi R16,135
	xcall _angle_5C
	.dbline 903
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 904
; 	angle_3A(45);
	ldi R16,45
	xcall _angle_3A
	.dbline 905
; 	angle_5A(135); //middel pair move forward while legs are up
	ldi R16,135
	xcall _angle_5A
	.dbline 906
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 907
; 	angle_3B(90);
	ldi R16,90
	xcall _angle_3B
	.dbline 908
; 	angle_3C(90);
	ldi R16,90
	xcall _angle_3C
	.dbline 909
; 	angle_5B(90);
	ldi R16,90
	xcall _angle_5B
	.dbline 910
; 	angle_5C(90); // put down legs
	ldi R16,90
	xcall _angle_5C
	.dbline 911
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 913
; 
; 	servo_calibration(); //push towards forward
	xcall _servo_calibration
	.dbline 914
; 	motion_busy = 0;
	clr R2
	sts _motion_busy,R2
	.dbline -2
L142:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e back _back fV
	.even
_back::
	.dbline -1
	.dbline 918
; }
; 
; //backward by using two legs at a time
; void back(void) {
	.dbline 919
; 	motion_busy = 1;
	ldi R24,1
	sts _motion_busy,R24
	.dbline 920
; 	servo_calibration();
	xcall _servo_calibration
	.dbline 921
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 924
; 
; 	//legs 2 and 4 move back
; 	angle_2B(45);
	ldi R16,45
	xcall _angle_2B
	.dbline 925
; 	angle_2C(45);
	ldi R16,45
	xcall _angle_2C
	.dbline 926
; 	angle_4B(135);
	ldi R16,135
	xcall _angle_4B
	.dbline 927
; 	angle_4C(135); //front pair BC servo up 45
	ldi R16,135
	xcall _angle_4C
	.dbline 928
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 929
; 	angle_2A(135);
	ldi R16,135
	xcall _angle_2A
	.dbline 930
; 	angle_4A(45); //front pair move forward while legs are up
	ldi R16,45
	xcall _angle_4A
	.dbline 931
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 932
; 	angle_2B(90);
	ldi R16,90
	xcall _angle_2B
	.dbline 933
; 	angle_2C(90);
	ldi R16,90
	xcall _angle_2C
	.dbline 934
; 	angle_4B(90);
	ldi R16,90
	xcall _angle_4B
	.dbline 935
; 	angle_4C(90); // put down legs
	ldi R16,90
	xcall _angle_4C
	.dbline 936
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 940
; 
; 	//legs 1 and 6 move back
; 
; 	angle_1B(45);
	ldi R16,45
	xcall _angle_1B
	.dbline 941
; 	angle_1C(45);
	ldi R16,45
	xcall _angle_1C
	.dbline 942
; 	angle_6B(135);
	ldi R16,135
	xcall _angle_6B
	.dbline 943
; 	angle_6C(135); //middel pair BC servo up 45
	ldi R16,135
	xcall _angle_6C
	.dbline 944
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 945
; 	angle_1A(135);
	ldi R16,135
	xcall _angle_1A
	.dbline 946
; 	angle_6A(45); //middel pair move back while legs are up
	ldi R16,45
	xcall _angle_6A
	.dbline 947
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 948
; 	angle_1B(90);
	ldi R16,90
	xcall _angle_1B
	.dbline 949
; 	angle_1C(90);
	ldi R16,90
	xcall _angle_1C
	.dbline 950
; 	angle_6B(90);
	ldi R16,90
	xcall _angle_6B
	.dbline 951
; 	angle_6C(90); // put down legs
	ldi R16,90
	xcall _angle_6C
	.dbline 952
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 955
; 
; 	//legs 3 and 5 move back
; 	angle_3B(45);
	ldi R16,45
	xcall _angle_3B
	.dbline 956
; 	angle_3C(45);
	ldi R16,45
	xcall _angle_3C
	.dbline 957
; 	angle_5B(135);
	ldi R16,135
	xcall _angle_5B
	.dbline 958
; 	angle_5C(135); //middel pair BC servo up 45
	ldi R16,135
	xcall _angle_5C
	.dbline 959
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 960
; 	angle_3A(135);
	ldi R16,135
	xcall _angle_3A
	.dbline 961
; 	angle_5A(45); //middel pair move forward while legs are up
	ldi R16,45
	xcall _angle_5A
	.dbline 962
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 963
; 	angle_3B(90);
	ldi R16,90
	xcall _angle_3B
	.dbline 964
; 	angle_3C(90);
	ldi R16,90
	xcall _angle_3C
	.dbline 965
; 	angle_5B(90);
	ldi R16,90
	xcall _angle_5B
	.dbline 966
; 	angle_5C(90); // put down legs
	ldi R16,90
	xcall _angle_5C
	.dbline 967
; 	delay(TWO_HUNDRED_FIFTY_MSEC);
	ldi R16,100
	ldi R17,0
	xcall _delay
	.dbline 969
; 
; 	servo_calibration(); //push towards back
	xcall _servo_calibration
	.dbline 970
; 	motion_busy = 0;
	clr R2
	sts _motion_busy,R2
	.dbline -2
L143:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e robot_standup _robot_standup fV
	.even
_robot_standup::
	.dbline -1
	.dbline 975
; }
; 
; 
; void robot_standup(void) //warning: do not call this function while robot is standing or servos will get damaged
; {
	.dbline 976
; 	motion_busy = 1;
	ldi R24,1
	sts _motion_busy,R24
	.dbline 977
; 	angle_1B(1);
	ldi R16,1
	xcall _angle_1B
	.dbline 978
; 	angle_1C(110);
	ldi R16,110
	xcall _angle_1C
	.dbline 979
; 	angle_2B(1);
	ldi R16,1
	xcall _angle_2B
	.dbline 980
; 	angle_2C(110);
	ldi R16,110
	xcall _angle_2C
	.dbline 981
; 	angle_3B(1);
	ldi R16,1
	xcall _angle_3B
	.dbline 982
; 	angle_3C(110);
	ldi R16,110
	xcall _angle_3C
	.dbline 983
; 	angle_4B(179);
	ldi R16,179
	xcall _angle_4B
	.dbline 984
; 	angle_4C(70);
	ldi R16,70
	xcall _angle_4C
	.dbline 985
; 	angle_5B(179);
	ldi R16,179
	xcall _angle_5B
	.dbline 986
; 	angle_5C(70);
	ldi R16,70
	xcall _angle_5C
	.dbline 987
; 	angle_6B(179);
	ldi R16,179
	xcall _angle_6B
	.dbline 988
; 	angle_6C(70);
	ldi R16,70
	xcall _angle_6C
	.dbline 989
; 	delay(ONE_SEC);
	ldi R16,400
	ldi R17,1
	xcall _delay
	.dbline 990
; 	delay(ONE_SEC);
	ldi R16,400
	ldi R17,1
	xcall _delay
	.dbline 991
; 	servo_calibration();
	xcall _servo_calibration
	.dbline 992
; 	motion_busy = 0;
	clr R2
	sts _motion_busy,R2
	.dbline -2
L144:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e buzzer_on _buzzer_on fV
	.even
_buzzer_on::
	.dbline -1
	.dbline 996
; }
; 
; //set buzzer on
; void buzzer_on(void) {
	.dbline 997
; 	PORTC = PORTC | 0x08;
	sbi 0x8,3
	.dbline -2
L145:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e buzzer_off _buzzer_off fV
	.even
_buzzer_off::
	.dbline -1
	.dbline 1001
; }
; 
; //set buzzer off
; void buzzer_off(void) {
	.dbline 1002
; 	PORTC = PORTC & 0xF7;
	in R24,0x8
	andi R24,247
	out 0x8,R24
	.dbline -2
L146:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e delay _delay fV
;           time -> R16,R17
	.even
_delay::
	.dbline -1
	.dbline 1058
; }
; 
; /*
; void remote_control(void) {
; 	unsigned char flag1 = 0;
; 	PORTA = remote_data[4]; //move left joystick up and down and see if there is any change in the bargraph display.
; 	flag1 = 0; //resetting the flag
; 
; 	if ((flag1 == 0) && (motion_busy == 0)) //forward, 1 beep
; 	{
; 		if (remote_data[4] > 0x29) {
; 			flag1 = 1;
; 			forward();
; 			//buzzer_on(); delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_off(); //use it to debug remote onnection
; 		}
; 	}
; 
; 	if ((flag1 == 0) && (motion_busy == 0)) //back, 2 beep
; 	{
; 		if (remote_data[4] < 0x15) {
; 			flag1 = 1;
; 			back();
; 			//buzzer_on(); delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_off();delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_on(); delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_off(); //use it to debug remote onnection
; 		}
; 	}
; 
; 	if ((flag1 == 0) && (motion_busy == 0)) //anticlockwise (left), 3 beep
; 	{
; 		if (remote_data[3] > 0x2D) {
; 			flag1 = 1;
; 			robot_rotate_anticlockwise_7_5();
; 			//buzzer_on(); delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_off();delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_on(); delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_off(); delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_on(); delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_off(); //use it to debug remote onnection
; 		}
; 	}
; 
; 	if ((flag1 == 0) && (motion_busy == 0)) //clockwise (right), 4 beep
; 	{
; 		if (remote_data[3] < 0x19) {
; 			flag1 = 1;
; 			robot_rotate_clockwise_7_5();
; 			//buzzer_on(); delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_off();delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_on(); delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_off(); delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_on(); delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_off();delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_on(); delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_off(); //use it to debug remote onnection
; 		}
; 	}
; 
; 	if ((flag1 == 0) && (motion_busy == 0)) //stop 1 long beep
; 	{
; 		if ((0x19 < remote_data[3] < 0x2D) && (0x15 < remote_data[4] < 0x29)) {
; 			flag1 = 1;
; 			servo_calibration();
; 			//buzzer_on(); delay(TWO_HUNDRED_FIFTY_MSEC); delay(TWO_HUNDRED_FIFTY_MSEC); delay(TWO_HUNDRED_FIFTY_MSEC); buzzer_off(); //use it to debug remote onnection
; 		}
; 	}
; }*/
; 
; 
; void delay(int time) {
	.dbline 1059
; 	delay_count = 0;
	clr R2
	clr R3
	sts _delay_count+1,R3
	sts _delay_count,R2
L148:
	.dbline 1061
; 	while (delay_count < time)
; 		;
L149:
	.dbline 1060
	lds R2,_delay_count
	lds R3,_delay_count+1
	cp R2,R16
	cpc R3,R17
	brlo L148
X26:
	.dbline -2
L147:
	.dbline 0 ; func end
	ret
	.dbsym r time 16 I
	.dbend
	.dbfunc e ADC_Conversion _ADC_Conversion fc
;              a -> R10
;             Ch -> R16
	.even
_ADC_Conversion::
	st -y,R10
	.dbline -1
	.dbline 1065
; }
; 
; unsigned char ADC_Conversion(unsigned char Ch)
; {
	.dbline 1067
; 	unsigned char a;
; 	if(Ch>7)
	ldi R24,7
	cp R24,R16
	brsh L152
X27:
	.dbline 1068
; 		{
	.dbline 1069
; 		ADCSRB = 0x08;			// select the ch. > 7
	ldi R24,8
	sts 123,R24
	.dbline 1070
; 		}
L152:
	.dbline 1071
; 	Ch = Ch & 0x07;  			
	andi R16,7
	.dbline 1072
; 	ADMUX= 0x20| Ch;	   		//do not disturb the left adjustment
	mov R24,R16
	ori R24,32
	sts 124,R24
	.dbline 1073
; 	ADCSRA = ADCSRA | 0x40;		//Set start conversion bit
	lds R24,122
	ori R24,64
	sts 122,R24
L154:
	.dbline 1074
; 	while((ADCSRA&0x10)==0);	//Wait for ADC conversion to complete
L155:
	.dbline 1074
	lds R2,122
	sbrs R2,4
	rjmp L154
X28:
	.dbline 1075
; 	a=ADCH;
	lds R10,121
	.dbline 1076
; 	ADCSRA = ADCSRA|0x10; 		//clear ADIF (ADC Interrupt Flag) by writing 1 to it
	lds R24,122
	ori R24,16
	sts 122,R24
	.dbline 1077
; 	ADCSRB = 0x00;
	clr R2
	sts 123,R2
	.dbline 1078
; 	return a;
	mov R16,R10
	.dbline -2
L151:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r a 10 c
	.dbsym r Ch 16 c
	.dbend
	.area bss(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
_data::
	.blkb 1
	.dbsym e data _data c
_remote_data::
	.blkb 8
	.dbsym e remote_data _remote_data A[8:8]c
_angle_lower_byte_6C::
	.blkb 1
	.dbsym e angle_lower_byte_6C _angle_lower_byte_6C c
_angle_upper_byte_6C::
	.blkb 1
	.dbsym e angle_upper_byte_6C _angle_upper_byte_6C c
_angle_lower_byte_6B::
	.blkb 1
	.dbsym e angle_lower_byte_6B _angle_lower_byte_6B c
_angle_upper_byte_6B::
	.blkb 1
	.dbsym e angle_upper_byte_6B _angle_upper_byte_6B c
_angle_lower_byte_6A::
	.blkb 1
	.dbsym e angle_lower_byte_6A _angle_lower_byte_6A c
_angle_upper_byte_6A::
	.blkb 1
	.dbsym e angle_upper_byte_6A _angle_upper_byte_6A c
_angle_lower_byte_5C::
	.blkb 1
	.dbsym e angle_lower_byte_5C _angle_lower_byte_5C c
_angle_upper_byte_5C::
	.blkb 1
	.dbsym e angle_upper_byte_5C _angle_upper_byte_5C c
_angle_lower_byte_5B::
	.blkb 1
	.dbsym e angle_lower_byte_5B _angle_lower_byte_5B c
_angle_upper_byte_5B::
	.blkb 1
	.dbsym e angle_upper_byte_5B _angle_upper_byte_5B c
_angle_lower_byte_5A::
	.blkb 1
	.dbsym e angle_lower_byte_5A _angle_lower_byte_5A c
_angle_upper_byte_5A::
	.blkb 1
	.dbsym e angle_upper_byte_5A _angle_upper_byte_5A c
_angle_lower_byte_4C::
	.blkb 1
	.dbsym e angle_lower_byte_4C _angle_lower_byte_4C c
_angle_upper_byte_4C::
	.blkb 1
	.dbsym e angle_upper_byte_4C _angle_upper_byte_4C c
_angle_lower_byte_4B::
	.blkb 1
	.dbsym e angle_lower_byte_4B _angle_lower_byte_4B c
_angle_upper_byte_4B::
	.blkb 1
	.dbsym e angle_upper_byte_4B _angle_upper_byte_4B c
_angle_lower_byte_4A::
	.blkb 1
	.dbsym e angle_lower_byte_4A _angle_lower_byte_4A c
_angle_upper_byte_4A::
	.blkb 1
	.dbsym e angle_upper_byte_4A _angle_upper_byte_4A c
_angle_lower_byte_3C::
	.blkb 1
	.dbsym e angle_lower_byte_3C _angle_lower_byte_3C c
_angle_upper_byte_3C::
	.blkb 1
	.dbsym e angle_upper_byte_3C _angle_upper_byte_3C c
_angle_lower_byte_3B::
	.blkb 1
	.dbsym e angle_lower_byte_3B _angle_lower_byte_3B c
_angle_upper_byte_3B::
	.blkb 1
	.dbsym e angle_upper_byte_3B _angle_upper_byte_3B c
_angle_lower_byte_3A::
	.blkb 1
	.dbsym e angle_lower_byte_3A _angle_lower_byte_3A c
_angle_upper_byte_3A::
	.blkb 1
	.dbsym e angle_upper_byte_3A _angle_upper_byte_3A c
_angle_lower_byte_2C::
	.blkb 1
	.dbsym e angle_lower_byte_2C _angle_lower_byte_2C c
_angle_upper_byte_2C::
	.blkb 1
	.dbsym e angle_upper_byte_2C _angle_upper_byte_2C c
_angle_lower_byte_2B::
	.blkb 1
	.dbsym e angle_lower_byte_2B _angle_lower_byte_2B c
_angle_upper_byte_2B::
	.blkb 1
	.dbsym e angle_upper_byte_2B _angle_upper_byte_2B c
_angle_lower_byte_2A::
	.blkb 1
	.dbsym e angle_lower_byte_2A _angle_lower_byte_2A c
_angle_upper_byte_2A::
	.blkb 1
	.dbsym e angle_upper_byte_2A _angle_upper_byte_2A c
_angle_lower_byte_1C::
	.blkb 1
	.dbsym e angle_lower_byte_1C _angle_lower_byte_1C c
_angle_upper_byte_1C::
	.blkb 1
	.dbsym e angle_upper_byte_1C _angle_upper_byte_1C c
_angle_lower_byte_1B::
	.blkb 1
	.dbsym e angle_lower_byte_1B _angle_lower_byte_1B c
_angle_upper_byte_1B::
	.blkb 1
	.dbsym e angle_upper_byte_1B _angle_upper_byte_1B c
_angle_lower_byte_1A::
	.blkb 1
	.dbsym e angle_lower_byte_1A _angle_lower_byte_1A c
_angle_upper_byte_1A::
	.blkb 1
	.dbsym e angle_upper_byte_1A _angle_upper_byte_1A c
_ADC_Value::
	.blkb 1
	.dbsym e ADC_Value _ADC_Value c
; }
; 

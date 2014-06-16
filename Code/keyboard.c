/***
Authors : Team 17
* 	Rahul Varshneya
* 	Anvit Singh Tawar
* 	Shivam Agarwal
* 	Alankar Saxena

Date Sun 15 April 2012 02:42:38 PM IST 

* keyboard.c : File contains various advanced motion functions for the hexapod
* Please include keyboard.h file to call function from this file

The various functions are : 
keyboard_control
*/

/*********************************************************************************

   Copyright (c) 2010, ERTS Lab IIT Bombay erts@cse.iitb.ac.in               -*- c -*-
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:

   * Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.

   * Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in
     the documentation and/or other materials provided with the
     distribution.

   * Neither the name of the copyright holders nor the names of
     contributors may be used to endorse or promote products derived
     from this software without specific prior written permission.

   * Source code can be used for academic purpose. 
	 For commercial use permission form the author needs to be taken.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  POSSIBILITY OF SUCH DAMAGE. 

  Software released under Creative Commence cc by-nc-sa licence.
  For legal information refer to: 
  http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode

********************************************************************************/

#include "hexapod_macro.h"
#include "hexapod.h"
#include "gait.h"
#include "hexapod_motions.h"
#include "hexapod_basic.h"

// Variable to store the incoming character entered by the user (zigbee communication)
extern unsigned char data;
// Variable which uniquely identifies various motions of the hexapod.
extern unsigned char mode;
// Variable to identify the primary direction of motion. Hexapod moves in the direction of {@code legNo}
extern unsigned int legNo;
// Variable to identify the direction of rotation of hexapod. Possible directions are CLOCKWISE and ANTI_CLOCKWISE.
extern unsigned int dir;
// Variable to scale the angular movement of servo motors. Used to control hexapod motion speed.
extern double movementScaling;

// Function to control hexapod motion via Zigbee module.
void keyboard_control(void) 
{	
	static char change = 15;
	
	// Mode 1-9 are for movement gaits of hexapod.
	// Mode 11-14 are for rotation gaits of hexapod.
	// Mode 21-24 are for advanced motions of hexapod.
	switch(data) 
	{
	   case 's':
			// Mode to reset the hexapod. Set all motor angles to 90 degrees 
			servo_calibration();
			break;	
	   case 'm': 
			// Mode to prepare hexapod for motion. The folowing digit (1-7) determines the gait to be used.
			mode = 'm';
			break;
	   case 't': 
			// Mode to prepare hexapod for rotation. The following digit (1-4) determines the gait to be used.
	   		mode = 't';
			break;
	   case 'l':
			// Mode to set the primary direction of motion of the hexapod. 
			// The following digit (1-6) sets the motion direction appropriately.
	   		mode = 'l';
			break;
	   case '<':
			// Mode to set the rotation direction: clock-wise
	   		dir = CLOCK_WISE;
			break;
	   case '>':
			// Mode to set the rotation direction: anti clock-wise
	   		dir = ANTI_CLOCK_WISE;
			break;
	   case 'd':
			// Mode to prepare hexapod for advanced motions.
	   		mode = 'd';
			break;
	   case '-': 
			// Decreasing the scaling factor. Min-val : 0.1
	   		movementScaling -= 0.1;
			if (movementScaling < 0.1) movementScaling = 0.1;
			break;
	   case '+':
			// Increasing the scaling factor. Max-val : 1.0
	   		movementScaling += 0.1;
			if (movementScaling > 1.0) movementScaling = 1.0;
			break;
	   case '1': 
	   		if (mode == 'l') legNo = 1;
			if (mode == 'm') mode = 1;
			if (mode == 't') mode = 11;
			if (mode == 'd') mode = 21;
			break;
	   case '2':
	   		 if (mode == 'l') legNo = 2;
			 if (mode == 'm') mode = 2;
			 if (mode == 't') mode = 12;
			 if (mode == 'd') mode = 22; 
			 break;
	   case '3':
	   		if (mode == 'l') legNo = 3; 
			if (mode == 'm') mode = 3;
			if (mode == 't') mode = 13;
			if (mode == 'd') mode = 23;
			break;
	   case '4':
	   		if (mode == 'l') legNo = 4;
			if (mode == 'm') mode = 4;
			if (mode == 't') mode = 14;
			if (mode == 'd') mode = 24;
			break;
	   case '5':
	   		if (mode == 'l') legNo = 5;
			if (mode == 'm') mode = 5; 
			break;
	   case '6':
	   		if (mode == 'l') legNo = 6;
			if (mode == 'm') mode = 6;
			break;
	   case '7':
	   		if (mode == 'm') mode = 7;
			break;
	   case '8':
	   		if (mode == 'm') mode = 8;
			break;
	   case '9':
	   		if (mode == 'm') mode = 9;
			break;
	   case 'b':
			// Toggle buzzer on hexapod.
	   		buzzer_on_off();
			break;
	   case 'z':	
	   default :
			// Default mode. Stop all the hexapod motions.
			mode = 'z';
			break;
	}	           
	 	
	data = '';
}

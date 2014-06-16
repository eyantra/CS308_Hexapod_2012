/**
@mainpage Building a locamotion based Hexapod Application
@author Group 17:
		Rahul Varshneya
		Anvit Singh Tawar
		Alankar Saxena
		Shivam Agarwal

Sun 08 April 2012 12:49:10 AM IST 

ICC AVR 7

Conatins various functions for basic, advanced hexapod motions

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


#include <iom2560v.h>
#include <macros.h>
#include "hexapod_macro.h"
#include "hexapod.h"
#include "hexapod_basic.h"
#include "hexapod_motions.h"
#include "gait.h"
#include "keyboard.h"

// Variable to receive the data sent by zigbee
extern unsigned char data;
// Variable that assist in choosing between various possible motions.
unsigned char mode;
// Leg number of the leg which is used as primary direction of motion. 
// This variable takes values from 1 to 6 corresponding to the 6 legs of the hexapod.
unsigned int legNo;
// Direction of rotation of hexapod. This is used in case when the robot is required to turn.
unsigned int dir;
// Temporary variable used in case when the direction of motion is between two legs.
unsigned int tempDir;
// Scaling factor to control the range of motions made by the motors. 
// This variable is used to control the speed of the motion and turning of hexapod.
double movementScaling;

void main(void) 
{
	// Initialise all the devices.
	init_devices();

	// Align all the motors at 90 degree angle.
	servo_calibration();
	// Turn on the servo supply.
	servo_on();
	initializeAngles();
	
	// Wait for some time.
	delay(ONE_SEC);
	delay(ONE_SEC);
	delay(ONE_SEC);	
	
	// Set the default values of the variables.
	mode = 'z';
	legNo = 1;
	dir = CLOCK_WISE;
	movementScaling = 1.0;
						
	// Continuously running loop waiting for user input
	while(1){

		// Various modes identify various function of the hexapod.
		switch(mode){
			
			// Cases 1 - 9 are for motion of the hexapod.
			case 1:
				 // Simple tripod gait.
				 tripod_gait(legNo, 1);
				 break;
			case 2:
				 // Tripod gait for highly uneven terrain
				 tripod_gait_2(legNo, 1);
				 break;
			case 3:
				 // Fast tripod gait
				 tripod_gait_continuous(legNo, 1);
				 break;
			case 4:
			     // Tripod gait with 3 legs on each side of motion direction
				 tripod_gait_insect_continuous(legNo, 1);
				 break;
			case 5:
				 // Wave gait
				 wave_gait(legNo, 1);
				 break;
			case 6:
				 // Ripple gait.
				 ripple_gait(legNo, 1);
				 break;
			case 7:
				 // Two legged gait.
				 tempDir = ((legNo + 1) % 6) + 1;
				 tempDir = ((tempDir + 1) % 6) + 1;
				 tempDir = 7 - tempDir;
				 two_leg_gait(legNo, tempDir, 1);
				 break;
			case 8:
				 break;
			case 9:
				 break;
			
			// Cases 11 - 14 are for rotation of hexapod.	 
			case 11:
				 // Tripod gait (simple) for turning. 
				 tripod_turn_gait(dir, 1);
				 break;
			case 12:
				 // Tripod gait (fast version) for turning.
				 tripod_turn_gait_continuous(dir, 1);
				 break;
			case 13:
				 // Two legged gait for turning.
				 two_legged_turn_gait(dir, 1);
				 break;	 
			case 14:
				 // default implementatioin of turning.
				 if (dir == CLOCK_WISE){
				 	robot_rotate_clockwise_7_5();
				 }
				 else{
				 	  robot_rotate_anticlockwise_7_5();
				 }
				 break;
			
			// Cases 21 - 24 are for special hexapod movements.	 
		    case 21:
				 // Raise two legs in air while balancing on other 4
				 tempDir = ((legNo + 1) % 6) + 1;
				 tempDir = ((tempDir + 1) % 6) + 1;
				 tempDir = 7 - tempDir;
				 pose(legNo, tempDir, 10);
				 break;
			case 22:
				 // Hedapod swaying motion.
				 sway(24, CLOCK_WISE);
				 break;
		    case 23:
				 // Hexapod dancing moves.
				 dance(4,5,6);
				 break;
			case 24:
				 // Hexapod climbing obstacles.
				 climb();
				 break;
	   	    default:
			     break;
		}
	}	
}



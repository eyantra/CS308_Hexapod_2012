/***
Author : Srijit Dutt
Date Sun 07 Nov 2010 02:42:38 PM IST 

hexapod_basic.c : File contains various basic motion functions for the hexapod
Please include hexapod_basic.h file to call function from this file

*/

/********************************************************************************

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



unsigned char angleArr[6][3];//!< The angle of the servos
static unsigned char dirMirror = DIR_MIRROR_LEG_1_2;

/**
Initialize the servo angles
*/
void initializeAngles() {
	 int i,j;
	 
	 for (i=0; i < NO_OF_LEGS; i++) {
	 	 for(j=0; j < NO_OF_SERVOS_IN_EACH_LEG; j++) {
		 		  angleArr[i][j] = INITIAL_ANGLE;
		 }
	 }
}

/**
* Set the servo angle
*/
void setAngle(unsigned char arm, unsigned char motor, unsigned char angle);

/**
Get the servo angle
*/
unsigned char getAngle(unsigned char arm, unsigned char motor);

/**
Sets a specific servo to a angle

@param arm : The arm of the hexapod
@param motor :  The motor of the hexapod
@param angle : The angle to set the servo to
*/
void angle(unsigned char arm, unsigned char motor, unsigned char angle) {
	setAngle(arm, motor, angle); 
	switch (arm) {
	case 1:
		if (motor == MOTOR_A)
			angle_1A(angle);
		else if (motor == MOTOR_B)
			angle_1B(angle);
		else if (motor == MOTOR_C)
			angle_1C(angle);
		break;
	case 2:
		if (motor == MOTOR_A)
			angle_2A(angle);
		else if (motor == MOTOR_B)
			angle_2B(angle);
		else if (motor == MOTOR_C)
			angle_2C(angle);
		break;
	case 3:
		if (motor == MOTOR_A)
			angle_3A(angle);
		else if (motor == MOTOR_B)
			angle_3B(angle);
		else if (motor == MOTOR_C)
			angle_3C(angle);
		break;
	case 4:
		if (motor == MOTOR_A)
			angle_4A(angle);
		else if (motor == MOTOR_B)
			angle_4B(180 - angle);
		else if (motor == MOTOR_C)
			angle_4C(180 - angle);
		break;
	case 5:
		if (motor == MOTOR_A)
			angle_5A(angle);
		else if (motor == MOTOR_B)
			angle_5B(180 - angle);
		else if (motor == MOTOR_C)
			angle_5C(180 - angle);
		break;
	case 6:
		if (motor == MOTOR_A)
			angle_6A(angle);
		else if (motor == MOTOR_B)
			angle_6B(180 - angle);
		else if (motor == MOTOR_C)
			angle_6C(180 - angle);
		break;
	}
}


/**
Sets the angle of all the MOTOR_XA servo
@param angle : The angle to be set
*/
void angle_XA(unsigned char angle) {
	angle_1A(angle);
	angle_2A(angle);
	angle_3A(angle);
	angle_4A(angle);
	angle_5A(angle);
	angle_6A(angle);
}

/**
Sets the angle of all the MOTOR_XB servo
@param angle : The angle to be set
*/
void angle_XB(unsigned char angle) {
	angle_1B(angle);
	angle_2B(angle);
	angle_3B(angle);
	angle_4B(180 - angle);
	angle_5B(180 - angle);
	angle_6B(180 - angle);
}


/**
Sets the angle of all the MOTOR_XC servo
@param angle : The angle to be set
*/
void angle_XC(unsigned char angle) {
	angle_1C(angle);
	angle_2C(angle);
	angle_3C(angle);
	angle_4C(180 - angle);
	angle_5C(180 - angle);
	angle_6C(180 - angle);
}



/**
Swaps two unsigned char
*/
void swap(unsigned char *a, unsigned char *b) {
	 unsigned char t = *a;
	 *a = *b;
	 *b = t;
}

void setAngle(unsigned char arm, unsigned char motor, unsigned char angle) {
	 angleArr[arm][motor - 'A'] = angle;
}

unsigned char getAngle(unsigned char arm, unsigned char motor) {
	 return angleArr[arm][motor - 'A'];
}


/**
Flips the state of the buzzer
*/
void buzzer_on_off() {
     static int flag = 1;
	 if(flag) {
	     buzzer_on();
	 	 flag = 0;
	 }else {
	     buzzer_off();
	     flag = 1;  
	 }
}

/**
Changes the angle of a servo by change
Problem with this routine
*/
void angle_change(unsigned char arm, unsigned char motor, char change) {
    
	unsigned char angle1;
	
	 if(change + getAngle(arm, motor) < DEGREE_MIN || change + getAngle(arm, motor)  > 240) {
	 		   angle1 = DEGREE_MIN;
			   //buzzer_on();
	} else if(change + getAngle(arm, motor)  > DEGREE_MAX) {
	           angle1 = DEGREE_MAX;
			   //buzzer_on();
	} else {
	 		   angle1 = change + getAngle(arm, motor);
	}
	angle(arm, motor, angle1);
	
}


/**
The sets the direction for the angleMirror function
Used to move two legs with the same angle
*/
void setMirrorDir(unsigned char dir) {
	 dirMirror = dir;
}

/**
Returns the Mirror diricetion
*/
unsigned char getMirrorDir(void ) {
	 return dirMirror;
}

/**
Returns the arm which mirrors the arm according to the dirMirror
*/
unsigned char getMirrorArm(unsigned char arm) {
		 int arr_mirror[3][6] =  {{LEG_2, LEG_1, LEG_4, LEG_3, LEG_6, LEG_5}, 
		 	 				   	{LEG_6, LEG_3, LEG_2, LEG_5, LEG_4, LEG_1}, 
								{LEG_4, LEG_5, LEG_6, LEG_1, LEG_2, LEG_3}};
		 return arr_mirror[getMirrorDir()][arm - 1];
}


/**
Sets the angle of the arm servo and its Mirror arm to the angle angleSet
@param arm : Arm of the hexapod
@param motor : The motor of the hexapod
@param angleSet :  The angle to be set 
*/
void angleMirror(unsigned char arm, unsigned char motor, unsigned char angleSet) {
	 unsigned char arm_mirror = getMirrorArm(arm);
	 angle(arm, motor, angleSet);
	 if(motor == MOTOR_A)
	 	 angle(arm_mirror, motor, 180 - angleSet);
	 else
	 	 angle(arm_mirror, motor, angleSet);
	 	  		  
}

/**
Changes angle of the arm servo and its Mirror arm by the angle angleChange
@param arm : Arm of the hexapod
@param motor : The motor of the hexapod
@param angleChange :  The angle to change by 
*/
void angleMirrorChange(unsigned char arm, unsigned char motor, char angleChange) {
	 unsigned char arm_mirror = getMirrorArm(arm);
	 angle_change(arm, motor, angleChange);
	 angle_change(arm_mirror, motor, angleChange);
}





/***
Author : Group 17
* 	Rahul Varshneya
* 	Anvit Singh Tawar
* 	Shivam Agarwal
* 	Alankar Saxena

Date Sun 08 April 2012 02:42:38 PM IST 

gait.c : File contains various walking and turning motion functions for the hexapod
Please include gait.h file to call function from this file

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
#include "hexapod_basic.h"
#include "hexapod.h"

extern double movementScaling;

/**
Tripod gait moves the hexapod in the direction dir1 for steps.
Three legs forming a tripod move first then the other three legs move  
Used for normal gait of the hexapod
@param dir1 : Direction of motion
@param steps : number of steps
*/
void tripod_gait(unsigned char dir1, unsigned char steps) 
{
	unsigned char dir3 = ((dir1 + 1) % 6) + 1;
	unsigned char dir5 = ((dir3 + 1) % 6) + 1;
	unsigned char dir2 = 7 - dir5;
	unsigned char dir4 = 7 - dir3;
	unsigned char dir6 = 7 - dir1;
	unsigned char step_forward = 70;
	unsigned char step_side = 50;
	unsigned char lift = 40;
	int delay_time = 150;//TWO_HUNDRED_FIFTY_MSEC;
	
		
	// The following is done to keep dir3 to the left of dir1 and dir5 to the right of dir1
	if(dir1%2 == 0) 
	{
		swap(&dir2, &dir4);
		swap(&dir3, &dir5);	  
	}
	
	while (steps-- > 0) 
	{		
		//picking up even tripod
		angle(dir2, MOTOR_B, lift);
		angle(dir4, MOTOR_B, lift);
		angle(dir6, MOTOR_B, lift);
		
		delay(delay_time);
		
		//moving body on odd tripod
		angle(dir1, MOTOR_C, 90);
		angle(dir3, MOTOR_A, 90);
		angle(dir5, MOTOR_A, 90);
		
		//moving legs even forward in air
		angle(dir2, MOTOR_A, 90 - step_side);
		angle(dir4, MOTOR_A, 90 + step_side);
		angle(dir6, MOTOR_C, 90 - step_forward);
		
		delay(delay_time);

		//putting down even legs
		angle(dir2, MOTOR_B, 90);
		angle(dir4, MOTOR_B, 90);
		angle(dir6, MOTOR_B, 90);
		
		delay(HUNDRED_MSEC);
		
		//picking up odd legs
		angle(dir1, MOTOR_B, lift);
		angle(dir3, MOTOR_B, lift);
		angle(dir5, MOTOR_B, lift);
		delay(delay_time);

		//moving the odd legs in air
		angle(dir1, MOTOR_C, 90 + step_forward);
		angle(dir3, MOTOR_A, 90 - step_side);
		angle(dir5, MOTOR_A, 90 + step_side);

		//moving the body forward on even tripod
		angle(dir2, MOTOR_A, 90);
		angle(dir4, MOTOR_A, 90);
		angle(dir6, MOTOR_C, 90);
		
		delay(delay_time);
		
		//puuting down odd tripod
		angle(dir1, MOTOR_B, 90);
		angle(dir3, MOTOR_B, 90);
		angle(dir5, MOTOR_B, 90);
		
		delay(HUNDRED_MSEC);
	}
	
}

/**
Tripod Gait 2 : Better suited for uneven terrain
@param dir1 : Direction of motion
@param steps : number of steps
*/
void tripod_gait_2(unsigned char dir1, unsigned char steps) 
{
	unsigned char dir3 = ((dir1 + 1) % 6) + 1;
	unsigned char dir5 = ((dir3 + 1) % 6) + 1;
	unsigned char dir2 = 7 - dir5;
	unsigned char dir4 = 7 - dir3;
	unsigned char dir6 = 7 - dir1;
	unsigned char step_forward = 60;
	unsigned char step_side = 60;
	unsigned char lift = 40;
	int delay_time = ONE_SEC;
	int delay_time1 = ONE_SEC;
	
	if(dir1%2 == 0) 
	{
		swap(&dir2, &dir4);
		swap(&dir3, &dir5);	  
	}
	
	while (steps-- > 0) 
	{
		//puuting down odd tripod
		angle(dir1, MOTOR_C, 90);
		angle(dir3, MOTOR_C, 90);
		angle(dir5, MOTOR_C, 90);
		angle(dir1, MOTOR_B, 90);
		angle(dir3, MOTOR_B, 90);
		angle(dir5, MOTOR_B, 90);
		
		delay(delay_time1);
		
		//picking up even tripod
		angle(dir2, MOTOR_B, lift);
		angle(dir4, MOTOR_B, lift);
		angle(dir6, MOTOR_B, lift);
		angle(dir2, MOTOR_C, 0);
		angle(dir4, MOTOR_C, 0);
		angle(dir6, MOTOR_C, 0);
		delay(delay_time);

		//moving body on odd tripod
		angle(dir1, MOTOR_A, 90);
		angle(dir3, MOTOR_A, 90);
		angle(dir5, MOTOR_A, 90);
		
		delay(delay_time);
		
		//moving legs even forward in air
		angle(dir2, MOTOR_C, 180);
		angle(dir4, MOTOR_C, 180);
		angle(dir6, MOTOR_C, 180);
		angle(dir2, MOTOR_A, 90 - step_side);
		angle(dir4, MOTOR_A, 90 + step_side);
		angle(dir6, MOTOR_A, 90 + step_forward);
		delay(delay_time);

		//putting down even legs
		angle(dir2, MOTOR_C, 90);
		angle(dir4, MOTOR_C, 90);
		angle(dir6, MOTOR_C, 90);
		angle(dir2, MOTOR_B, 90);
		angle(dir4, MOTOR_B, 90);
		angle(dir6, MOTOR_B, 90);
		
		delay(delay_time1);
		
		//picking up odd legs
		angle(dir1, MOTOR_B, lift);
		angle(dir3, MOTOR_B, lift);
		angle(dir5, MOTOR_B, lift);
		angle(dir1, MOTOR_C, 0);
		angle(dir3, MOTOR_C, 0);
		angle(dir5, MOTOR_C, 0);
		delay(delay_time);

		//moving the odd legs in air
		angle(dir1, MOTOR_C, 180);
		angle(dir3, MOTOR_C, 180);
		angle(dir5, MOTOR_C, 180);
		angle(dir1, MOTOR_A, 90 + step_forward);
		angle(dir3, MOTOR_A, 90 - step_side);
		angle(dir5, MOTOR_A, 90 + step_side);
		delay(delay_time);
		
		//moving the body forward on even tripod
		angle(dir2, MOTOR_A, 90);
		angle(dir4, MOTOR_A, 90);
		angle(dir6, MOTOR_A, 90);
		delay(delay_time);
	}
}

/**
Two leg gait in which two legs are moved at a time
@param dir1 : Direction of motion
@param dir2 : Direction of motion
@param steps : number of steps
*/
void two_leg_gait(unsigned char dir1, unsigned char dir2, int steps) 
{
	 unsigned char legs_anticlock[] = {0,2,3,6,1,4,5};
	 unsigned char legs_clock[] = {0,4,1,2,5,6,3}; 
	 unsigned char dir3 = legs_anticlock[dir2];
	 unsigned char dir4 = legs_clock[dir1];
	 unsigned char dir5 = legs_clock[dir4];
	 unsigned char dir6= legs_anticlock[dir3];
	 unsigned char step_forward = 50 * movementScaling;
	 unsigned char step_side = 40 * movementScaling;
	 unsigned char lift = 40;
	 int delay_time1 = FIVE_HUNDRED_MSEC;
	 int delay_time2 = FIVE_HUNDRED_MSEC;
	 
	 while(steps-- > 0) 
	 {
	    //putting down legs 5 & 6
		angle(dir5, MOTOR_B, 90);
		angle(dir6, MOTOR_B, 90);
	 
	 	//picking up 1 & 2 legs
		angle(dir1, MOTOR_B, lift);
		angle(dir2, MOTOR_B, lift);
		
		//delay
		delay(delay_time1);
		
		//moving body on legs 5 & 6
		angle(dir5, MOTOR_A, 90 - step_forward);
		angle(dir6, MOTOR_A, 90 + step_forward);
		
		//moving 1 & 2 legs in air 
		angle(dir1, MOTOR_A, 90 + step_forward);
		angle(dir2, MOTOR_A, 90 - step_forward);
		
		//delay
		delay(delay_time1);
		
		//putting 1 & 2 legs down
		angle(dir1, MOTOR_B, 90);
		angle(dir2, MOTOR_B, 90);
		
		//picking up 3 & 4 legs		   
	 	angle(dir3, MOTOR_B, lift);
		angle(dir4, MOTOR_B, lift);
		
		delay(delay_time1);
		
		//moving body on legs 1 & 2
		angle(dir1, MOTOR_A, 90 - step_forward);
		angle(dir2, MOTOR_A, 90 + step_forward);
		
		//moving legs 3 & 4 in air
		angle(dir3, MOTOR_A, 90 - step_side);
		angle(dir4, MOTOR_A, 90 + step_side);
		
		delay(delay_time2);
		
		//putting down legs 3 & 4
		angle(dir3, MOTOR_B, 90);
		angle(dir4, MOTOR_B, 90);
		
		//picking up legs 5 & 6
		angle(dir5, MOTOR_B, lift);
		angle(dir6, MOTOR_B, lift);
		
		delay(delay_time1);
		
		//moving body on legs 3 & 4
		angle(dir3, MOTOR_A, 90 + step_side);
		angle(dir4, MOTOR_A, 90 - step_side);
		
		//moving legs 5 & 6 in air 
		angle(dir5, MOTOR_A, 90 + step_forward);
		angle(dir6, MOTOR_A, 90 - step_forward);
		
		delay(delay_time2);
	 }
}

/**
Tripod turn gait: turns hexapod in specified direction for specified number of cycles.

Description:
* There are 2 tripods. Even tripod (leg no 1, 3, 5) and odd tripod (leg no 2, 4, 6).
* When even tripod moves in air, odd tripod supports the bot (are at 90 degrees). 
* When odd tripod moves in air, even tripod supports the bot. 
* This cycle repeats.

@param rot_dir : Direction of rotation (one of CLOCKWISE or ANTI_CLOCKWISE) 
@param steps : number of steps
*/
void tripod_turn_gait(unsigned char rot_dir, unsigned char steps) 
{
 	// making the LEG_1 as default leg for our movement
 	// Other legs are defined wrt {@code: dir1}
 	unsigned char dir1 = LEG_1;				 
    unsigned char dir3 = ((dir1 + 1) % 6) + 1;
    unsigned char dir5 = ((dir3 + 1) % 6) + 1;
    unsigned char dir2 = 7 - dir5;
    unsigned char dir4 = 7 - dir3;
    unsigned char dir6 = 7 - dir1;
    
    // Parameters which control motor movement.
    int step_side = 50 * movementScaling;
    // Angle by which legs are raised in air.
    unsigned char lift = 40;
    // delay time between two subsequent motion commands.
    int delay_time = 150;
	
    // If rotation direction is anti-clockwise rot_dir = 0 else rot_dir = 1. Adjust step_side accordingly.
	step_side = step_side*(1 - 2*rot_dir);
	
    // The following is done to keep dir3 to the left of dir1 and dir5 to the right of dir1
    if(dir1%2 == 0) 
	{
        swap(&dir2, &dir4);
        swap(&dir3, &dir5);
    }
	
    while (steps-- > 0) 
	{        
        //picking up even tripod
        angle(dir2, MOTOR_B, lift);
        angle(dir4, MOTOR_B, lift);
        angle(dir6, MOTOR_B, lift);
    
        delay(delay_time);

        //moving body on odd tripod
        angle(dir1, MOTOR_A, 90);
        angle(dir3, MOTOR_A, 90);
        angle(dir5, MOTOR_A, 90);
        
        //rotating legs even in air
        angle(dir2, MOTOR_A, 90 + step_side);
        angle(dir4, MOTOR_A, 90 + step_side);
        angle(dir6, MOTOR_A, 90 + step_side);
        
        delay(delay_time);

        //putting down even legs
        angle(dir2, MOTOR_B, 90);
        angle(dir4, MOTOR_B, 90);
        angle(dir6, MOTOR_B, 90);
        
        delay(HUNDRED_MSEC);
        
        //picking up odd legs
        angle(dir1, MOTOR_B, lift);
        angle(dir3, MOTOR_B, lift);
        angle(dir5, MOTOR_B, lift);
        delay(delay_time);

        //moving the odd legs in air
        angle(dir1, MOTOR_A, 90 + step_side);
        angle(dir3, MOTOR_A, 90 + step_side);
        angle(dir5, MOTOR_A, 90 + step_side);

        //rotating the body on even tripod
        angle(dir2, MOTOR_A, 90);
        angle(dir4, MOTOR_A, 90);
        angle(dir6, MOTOR_A, 90);
        
        delay(delay_time);
        
        //puuting down odd tripod
        angle(dir1, MOTOR_B, 90);
        angle(dir3, MOTOR_B, 90);
        angle(dir5, MOTOR_B, 90);
        
        delay(HUNDRED_MSEC);
    }
}
/**
Tripod turn gait continuous: turns hexapod in specified direction for specified number of cycles.

Description:
* There are two tripods - odd tripod (leg 1, 3, 5) and even tripod  (leg  2, 4, 6).
* When odd tripod is in air, even tripod moves from maximum positive displacement to maximum negative displacement.
* Similar is the case when even tripod is in air.
* This gives wider range of motion to hexapod and thus increase the turning speed.

@param rot_dir : Direction of rotation (one of CLOCKWISE or ANTI_CLOCKWISE) 
@param steps : number of steps
*/
void tripod_turn_gait_continuous(unsigned char rot_dir, unsigned char steps) 
{
	// We can choose any leg as the primary leg. Other legs are referred relative to the chosen leg.
 	unsigned char dir1 = LEG_1;
    unsigned char dir3 = ((dir1 + 1) % 6) + 1;
    unsigned char dir5 = ((dir3 + 1) % 6) + 1;
    unsigned char dir2 = 7 - dir5;
    unsigned char dir4 = 7 - dir3;
    unsigned char dir6 = 7 - dir1;
    
    // Angle moved by the motors sideways.
    // Scaling factor {@code: movementScaling} controls the turning speed.
    int step_side = 45 * movementScaling;
	
	// Angle by which legs are raised in air.
    unsigned char lift = 40;
    
    // Delay time between two successive motion commands.
    int delay_time = 150;
    
	// If rotation direction is anti-clockwise rot_dir = 0 else rot_dir = 1
	step_side = step_side*(1 - 2*rot_dir);
	
    // The following is done to keep dir3 to the left of dir1 and dir5 to the right of dir1
    if(dir1%2 == 0) 
	{
        swap(&dir2, &dir4);
        swap(&dir3, &dir5);
    }
    
    while (steps-- > 0) 
	{        
        //picking up even tripod
        angle(dir2, MOTOR_B, lift);
        angle(dir4, MOTOR_B, lift);
        angle(dir6, MOTOR_B, lift);
    
        delay(delay_time);

        //moving body on odd tripod
        angle(dir1, MOTOR_A, 90 - step_side);
        angle(dir3, MOTOR_A, 90 - step_side);
        angle(dir5, MOTOR_A, 90 - step_side);
        
        //rotating legs even in air
        angle(dir2, MOTOR_A, 90 + step_side);
        angle(dir4, MOTOR_A, 90 + step_side);
        angle(dir6, MOTOR_A, 90 + step_side);
        
        delay(delay_time);

        //putting down even legs
        angle(dir2, MOTOR_B, 90);
        angle(dir4, MOTOR_B, 90);
        angle(dir6, MOTOR_B, 90);
        
        delay(HUNDRED_MSEC);
        
        //picking up odd legs
        angle(dir1, MOTOR_B, lift);
        angle(dir3, MOTOR_B, lift);
        angle(dir5, MOTOR_B, lift);
        
        delay(delay_time);

        //moving the odd legs in air
        angle(dir1, MOTOR_A, 90 + step_side);
        angle(dir3, MOTOR_A, 90 + step_side);
        angle(dir5, MOTOR_A, 90 + step_side);

        //rotating the body on even tripod
        angle(dir2, MOTOR_A, 90 - step_side);
        angle(dir4, MOTOR_A, 90 - step_side);
        angle(dir6, MOTOR_A, 90 - step_side);
        
        delay(delay_time);
        
        //puuting down odd tripod
        angle(dir1, MOTOR_B, 90);
        angle(dir3, MOTOR_B, 90);
        angle(dir5, MOTOR_B, 90);
        
        delay(HUNDRED_MSEC);
    }
}

/**
Two legged turn gait: turns hexapod in specified direction for specified number of cycles.

Description:
* There are three pairs - pair1 (leg 1, 6), pair2 (leg 2, 5), pair (3, 4). 
* When one pair of legs is in air, other legs support the bot.
* Support from 4 legs at a time, makes the hexapod highly stable during turning.

@param rot_dir : Direction of rotation (one of CLOCKWISE or ANTI_CLOCKWISE) 
@param steps : number of steps
*/
void two_legged_turn_gait(unsigned char rot_dir, unsigned char steps) {
	unsigned char dir1 = LEG_1;
    unsigned char dir3 = ((dir1 + 1) % 6) + 1;
    unsigned char dir5 = ((dir3 + 1) % 6) + 1;
    unsigned char dir2 = 7 - dir5;
    unsigned char dir4 = 7 - dir3;
    unsigned char dir6 = 7 - dir1;

	// Step size during turning. 
	// {@code: movementScaling} controls the motion of the motors.
    int step_side = 50 * movementScaling;
    
    // Angle by the which the legs are raised in air.
    unsigned char lift = 40;
    
    // Time delay between succesive movement commands.
    int delay_time = 150;

	// If rotation direction is anti-clockwise rot_dir = 0 else rot_dir = 1
	step_side = step_side*(1 - 2*rot_dir);
    
    // The following is done to keep dir3 to the left of dir1 and dir5 to the right of dir1
    if(dir1%2 == 0) {
        swap(&dir2, &dir4);
        swap(&dir3, &dir5);
    }
    while (steps-- > 0) {
        //picking up first duplet
        angle(dir1, MOTOR_B, lift);
        angle(dir6, MOTOR_B, lift);
    
        delay(delay_time);

        //moving body on second duplet
        angle(dir2, MOTOR_A, 90);
        angle(dir5, MOTOR_A, 90);
        
        //rotating first duplet in air
        angle(dir1, MOTOR_A, 90 + step_side);
        angle(dir6, MOTOR_A, 90 + step_side);
        
        delay(delay_time);

        //putting down first duplet
        angle(dir1, MOTOR_B, 90);
        angle(dir6, MOTOR_B, 90);
        
        delay(HUNDRED_MSEC);
        
        //picking up third duplet
        angle(dir3, MOTOR_B, lift);
        angle(dir4, MOTOR_B, lift);
        
		delay(delay_time);

        //moving the third duplet in air
        angle(dir3, MOTOR_A, 90 + step_side);
        angle(dir4, MOTOR_A, 90 + step_side);

        //rotating the body on first duplet
        angle(dir1, MOTOR_A, 90);
        angle(dir6, MOTOR_A, 90);
        
        delay(delay_time);
        
        //putting down third duplet
        angle(dir3, MOTOR_B, 90);
        angle(dir4, MOTOR_B, 90);
        
        delay(HUNDRED_MSEC);
		//picking up second duplet
        angle(dir2, MOTOR_B, lift);
        angle(dir5, MOTOR_B, lift);
        
		delay(delay_time);

        //moving the second duplet in air
        angle(dir2, MOTOR_A, 90 + step_side);
        angle(dir5, MOTOR_A, 90 + step_side);

        //rotating the body on third duplet
        angle(dir3, MOTOR_A, 90);
        angle(dir4, MOTOR_A, 90);
        
        delay(delay_time);
        
        //putting down second duplet
        angle(dir2, MOTOR_B, 90);
        angle(dir5, MOTOR_B, 90);
        
        delay(HUNDRED_MSEC);
    }
}

/**
Tripod gait continuous: moves the hexapod in the direction {@code: dir1} for {@code: steps}.

Description
* There are 2 tripods. Even tripod (leg no 1, 3, 5) and odd tripod (leg no 2, 4, 6).
* When odd tripod is in air, even tripod moves from maximum positive displacement to maximum negative displacement.
* Similar is the case when even tripod is in air.
* This gives wider range of motion to hexapod and thus increase the movement speed.

@param dir1 : Direction of motion
@param steps : number of steps
*/
void tripod_gait_continuous(unsigned char dir1, unsigned char steps) 
{
	// Set the given {@code: dir1} as primary leg (movement direction). 
	// Label other legs relative to primary motion direction. 
    unsigned char dir3 = ((dir1 + 1) % 6) + 1;
    unsigned char dir5 = ((dir3 + 1) % 6) + 1;
    unsigned char dir2 = 7 - dir5;
    unsigned char dir4 = 7 - dir3;
    unsigned char dir6 = 7 - dir1;
    
    // Movement given to front and back leg.
    unsigned char step_forward = 50 * movementScaling;
    
    // Movement given to side legs.
    unsigned char step_side = 55 * movementScaling;
    
    // Angle by which legs are raised in air.
    unsigned char lift = 40;
    
    // Delay time between successive movement commands.
    int delay_time = 150;
    
    // The following is done to keep dir3 to the left of dir1 and dir5 to the right of dir1
    if(dir1%2 == 0) 
	{
        swap(&dir2, &dir4);
        swap(&dir3, &dir5);      
    }
    	
    while (steps-- > 0) 
	{        
        //picking up even tripod
        angle(dir2, MOTOR_B, lift);
        angle(dir4, MOTOR_B, lift);
        angle(dir6, MOTOR_B, lift);
    
        delay(delay_time);

        //moving body on odd tripod
        angle(dir1, MOTOR_C, 90 - step_forward);
        angle(dir3, MOTOR_A, 90 + step_side);
        angle(dir5, MOTOR_A, 90 - step_side);
        
        //moving legs even forward in air
        angle(dir2, MOTOR_A, 90 - step_side);
        angle(dir4, MOTOR_A, 90 + step_side);
        angle(dir6, MOTOR_C, 90 - step_forward);
        
        delay(delay_time);

        //putting down even legs
        angle(dir2, MOTOR_B, 90);
        angle(dir4, MOTOR_B, 90);
        angle(dir6, MOTOR_B, 90);
        
        delay(HUNDRED_MSEC);
        
        //picking up odd legs
        angle(dir1, MOTOR_B, lift);
        angle(dir3, MOTOR_B, lift);
        angle(dir5, MOTOR_B, lift);
        delay(delay_time);

        //moving the odd legs in air
        angle(dir1, MOTOR_C, 90 + step_forward);
        angle(dir3, MOTOR_A, 90 - step_side);
        angle(dir5, MOTOR_A, 90 + step_side);

        //moving the body forward on even tripod
        angle(dir2, MOTOR_A, 90 + step_side);
        angle(dir4, MOTOR_A, 90 - step_side);
        angle(dir6, MOTOR_C, 90 + step_forward);
        
        delay(delay_time);
        
        //putting down odd tripod
        angle(dir1, MOTOR_B, 90);
        angle(dir3, MOTOR_B, 90);
        angle(dir5, MOTOR_B, 90);
        
        delay(HUNDRED_MSEC);
    }
}

/**
Tripod gait insect continuous: moves the hexapod in the direction {@code: dir1} for {@code: steps}.

Description
* There are 2 tripods. Even tripod (leg no 1, 3, 5) and odd tripod (leg no 2, 4, 6).
* The direction of motion is between two neighbouring legs. There are 3 legs on each side on movement direction.
* When odd tripod is in air, even tripod moves from maximum positive displacement to maximum negative displacement.
* Similar is the case when even tripod is in air.
* This gives wider range of motion to hexapod and thus increase the movement speed.

@param dir1 : Direction of motion
@param steps : number of steps
*/
void tripod_gait_insect_continuous(unsigned char dir1, unsigned char steps) 
{
	// Set the given {@code: dir1} as primary leg (movement direction). 
	// Label other legs relative to primary motion direction. 
    unsigned char dir3 = ((dir1 + 1) % 6) + 1;
    unsigned char dir5 = ((dir3 + 1) % 6) + 1;
    unsigned char dir2 = 7 - dir5;
    unsigned char dir4 = 7 - dir3;
    unsigned char dir6 = 7 - dir1;

	// Angle by which front legs can move in forward direction.
	unsigned char step_front_forward = 30 * movementScaling;
	// Angle by which front legs can move in backward direction.
    unsigned char step_front_backward = 70 * movementScaling;
    // Angle by which side legs move.
    unsigned char step_side =40 * movementScaling;

    // Angle by which legs are raised in air.
    unsigned char lift = 40;

    // Delay time between successive movement commands.
    int delay_time = 150;//TWO_HUNDRED_FIFTY_MSEC;
    
    // The following is done to keep dir3 to the left of dir1 and dir5 to the right of dir1
    if(dir1%2 == 0) 
	{
        swap(&dir2, &dir4);
        swap(&dir3, &dir5);      
    }
    
	while (steps-- > 0) 
	{        
        //picking up even tripod
        angle(dir2, MOTOR_B, lift);
        angle(dir4, MOTOR_B, lift);
        angle(dir6, MOTOR_B, lift);
    
        delay(delay_time);

        //moving body on odd tripod
        angle(dir1, MOTOR_A, 90 - step_front_backward);
        angle(dir3, MOTOR_A, 90 + step_side);
        angle(dir5, MOTOR_A, 90 - step_front_forward);
        
        //moving legs even forward in air
        angle(dir2, MOTOR_A, 90 - step_front_forward);
        angle(dir4, MOTOR_A, 90 + step_side);
        angle(dir6, MOTOR_A, 90 - step_front_backward);
        
        delay(delay_time);

        //putting down even legs
        angle(dir2, MOTOR_B, 90);
        angle(dir4, MOTOR_B, 90);
        angle(dir6, MOTOR_B, 90);
        
        delay(HUNDRED_MSEC);
        
        //picking up odd legs
        angle(dir1, MOTOR_B, lift);
        angle(dir3, MOTOR_B, lift);
        angle(dir5, MOTOR_B, lift);
        delay(delay_time);

        //moving the odd legs in air
        angle(dir1, MOTOR_A, 90 + step_front_forward);
        angle(dir3, MOTOR_A, 90 - step_side);
        angle(dir5, MOTOR_A, 90 + step_front_backward);

        //moving the body forward on even tripod
        angle(dir2, MOTOR_A, 90 + step_front_backward);
        angle(dir4, MOTOR_A, 90 - step_side);
        angle(dir6, MOTOR_A, 90 + step_front_forward);
        
        delay(delay_time);
        
        //putting down odd tripod
        angle(dir1, MOTOR_B, 90);
        angle(dir3, MOTOR_B, 90);
        angle(dir5, MOTOR_B, 90);
        
        delay(HUNDRED_MSEC);
    }
}

/**
Wave gait: moves the hexapod in the direction {@code: dir1} for {@code: steps}.

Description
* Hexapod moves in a direction between two neighbouring legs.
* In the Wave Gait, all legs on one side are moved forward in succession, starting with the rear-most leg. 
* This is then repeated on the other side. 
* Since only 1 leg is ever lifted at a time, with the other 5 being down, the animal is always in a highly-stable posture.

@param dir1 : Direction of motion
@param steps : number of steps
*/
void wave_gait(unsigned char dir1, int steps) 
{
	 // Hexapod moves in direction between dir1 and dir4.
	 // dir1 is provided by the user. Other directions are marked accordingly.
	 unsigned char dir3 = ((dir1 + 1) % 6) + 1;
     unsigned char dir5 = ((dir3 + 1) % 6) + 1;
     unsigned char dir2 = 7 - dir5;
     unsigned char dir4 = 7 - dir3;
     unsigned char dir6 = 7 - dir1;
	 
	 // Movement given to front and hind legs.
     unsigned char step_forward = 70;
     // Movement given to side legs.
     unsigned char step_side = 50;
     // Angle by which legs are raised in air.
     unsigned char lift = 40;
     // Delay time between two successive movement commands.
     int delay_time = 100;
	 
	 // Variables to store the order in which legs should be moved.
	 unsigned char leg_order[6];
	 // Variable which stores the maximum allowed movement for different legs.
	 int leg_distance[6];
	 // Variable to store the current displacement of various legs.
	 int leg_current[] = {0, 0, 0, 0, 0, 0};
	 
	 leg_order[0] = dir1;
	 leg_order[1] = dir2;
	 leg_order[2] = dir3;
	 leg_order[3] = dir4;
	 leg_order[4] = dir5;
	 leg_order[5] = dir6;
	 
	 leg_distance[0] = -step_forward;
	 leg_distance[1] = -step_side;
	 leg_distance[2] = -step_forward;
	 leg_distance[3] = step_forward;
	 leg_distance[4] = step_side;
	 leg_distance[5] = step_forward;
	
	 while(steps-- > 0) 
	 {
	 	    int i, j, k;
			for (i = 0; i < 6; i++){
				// Putting down leg i and pick up leg i+1
				angle(leg_order[i], MOTOR_B, 90);
				angle(leg_order[(i+1) % 6], MOTOR_B, lift);
			
				delay(delay_time);
						
				// Moving body on leg i and move leg i+1 in air
				leg_current[(i+1) % 6] = 90 + leg_distance[(i+1) % 6];
				angle(leg_order[(i+1) % 6], MOTOR_A, leg_current[(i+1) % 6]);
				
				// Move the other legs backward to push the ground.
				for (j = 1; j <= 5; j++){
					k =  (i + 1 + j) % 6;
					leg_current[k] = leg_current[k] - (2 * leg_distance[k]) / 5;
					angle(leg_order[k], MOTOR_A, leg_current[k]);
				}
				delay(delay_time);
			}
			
			angle(leg_order[i % 6], MOTOR_B, 90);			
			delay(delay_time);
	}
}

/**
Ripple gait: moves the hexapod in the direction {@code: dir1} for {@code: steps}.

Description
* Hexapod moves in a direction between two neighbouring legs.
* In the Ripple Gait, on each side a local wave comprising non-overlapping lift phases is being performed, 
* and that the 2 opposite side waves are exactly 180 degrees out of phase with one another

@param dir1 : Direction of motion
@param steps : number of steps
*/
void ripple_gait(unsigned char dir1, int steps) 
{
	 // Hexapod moves in direction between dir1 and dir4.
	 // dir1 is provided by the user. Other directions are marked accordingly.
     unsigned char dir3 = ((dir1 + 1) % 6) + 1;
     unsigned char dir5 = ((dir3 + 1) % 6) + 1;
     unsigned char dir2 = 7 - dir5;
     unsigned char dir4 = 7 - dir3;
     unsigned char dir6 = 7 - dir1;

	 // Movement given to front and hind legs.
     unsigned char step_forward = 50;
     // Movement given to side legs.
     unsigned char step_side = 40;
     // Angle by which legs are raised in air.
     unsigned char lift = 40;

     // Delay time between two successive movement commands.
     int delay_time1 = 100;
	 int delay_time2 = 100;
	 
	 // Variables to store the order in which legs should be moved.
	 unsigned char leg_order[6];
	 // Variable which stores the maximum allowed movement for different legs.
	 int leg_distance[6];
	 // Variable to store the current displacement of various legs.
	 int leg_current[] = {0, 0, 0, 0, 0, 0};
	 
	 leg_order[0] = dir1;
	 leg_order[1] = dir2;
	 leg_order[2] = dir3;
	 leg_order[3] = dir4;
	 leg_order[4] = dir5;
	 leg_order[5] = dir6;
	 
	 leg_distance[0] = -step_forward;
	 leg_distance[1] = -step_side;
	 leg_distance[2] = -step_forward;
	 leg_distance[3] = step_forward;
	 leg_distance[4] = step_side;
	 leg_distance[5] = step_forward;
	
	 while(steps-- > 0) 
	 {
	 	    int i, j, k;
			for (i = 0; i < 3; i++)
			{
				// Putting down leg i and pick up leg i+1
				angle(leg_order[i], MOTOR_B, 90);
				angle(leg_order[(i+1) % 3], MOTOR_B, lift);

				delay(delay_time1);
				
				// Wave on opposite side is 180 degrees out of phase.
				angle(leg_order[((i+2) % 3) + 3], MOTOR_B, 90);
				angle(leg_order[(i % 3) + 3], MOTOR_B, lift);
			
				delay(delay_time2);
						
				// Moving body on leg i and move leg i+1 in air
				leg_current[(i+1) % 3] = 90 + leg_distance[(i+1) % 3];
				angle(leg_order[(i+1) % 3], MOTOR_A, leg_current[(i+1) % 3]);
				
				// Move the other legs backward to push the ground.
				for (j = 1; j <= 2; j++)
				{
					k =  (i + 1 + j) % 3;
					leg_current[k] = leg_current[k] - leg_distance[k];
					angle(leg_order[k], MOTOR_A, leg_current[k]);
				}

				delay(delay_time1);

				// Moving body on leg i and move leg i+1 in air				
				leg_current[(i % 3) + 3] = 90 + leg_distance[(i % 3) + 3];
				angle(leg_order[(i % 3) + 3], MOTOR_A, leg_current[(i % 3) + 3]);

				// Move the other legs backward to push the ground.
				for (j = 1; j <= 2 ; j++)
				{
					k =  ((i + j) % 3) + 3;
					leg_current[k] = leg_current[k] - leg_distance[k];
					angle(leg_order[k], MOTOR_A, leg_current[k]);
				}
				
				delay(delay_time2);
			}
			
			angle(leg_order[(i + 1) % 3], MOTOR_B, 90);			
			angle(leg_order[(i % 3) + 3], MOTOR_B, 90);			
			delay(delay_time1);
	}
}

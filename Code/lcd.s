	.module lcd.c
	.area text(rom, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\lcd.c
	.dbfunc e lcd_set_4bit _lcd_set_4bit fV
	.even
_lcd_set_4bit::
	.dbline -1
	.dbline 23
; #include <iom2560v.h>
; #include "lcd.h"
; #define FCPU 11059200ul
; #define RS 0
; #define RW 1
; #define EN 2
; #define lcd_port PORTC
; 
; #define sbit(reg,bit)	reg |= (1<<bit)
; #define cbit(reg,bit)	reg &= ~(1<<bit)
; 
; unsigned int temp;
; unsigned int unit;
; unsigned int tens;
; unsigned int hundred;
; unsigned int thousand;
; unsigned int million;
; 
; int i;
; 
; /*****Function to Reset LCD*****/
; void lcd_set_4bit()
; {
	.dbline 24
; 	delay(1);
	ldi R16,1
	ldi R17,0
	xcall _delay
	.dbline 26
; 
; 	cbit(lcd_port,RS);				//RS=0 --- Command Input
	cbi 0x8,0
	.dbline 27
; 	cbit(lcd_port,RW);				//RW=0 --- Writing to LCD
	cbi 0x8,1
	.dbline 28
; 	lcd_port = 0x30;				//Sending 3
	ldi R24,48
	out 0x8,R24
	.dbline 29
; 	sbit(lcd_port,EN);				//Set Enable Pin
	sbi 0x8,2
	.dbline 30
; 	delay(5);					//Delay
	ldi R16,5
	ldi R17,0
	xcall _delay
	.dbline 31
; 	cbit(lcd_port,EN);				//Clear Enable Pin
	cbi 0x8,2
	.dbline 33
; 
; 	delay(1);
	ldi R16,1
	ldi R17,0
	xcall _delay
	.dbline 35
; 
; 	cbit(lcd_port,RS);				//RS=0 --- Command Input
	cbi 0x8,0
	.dbline 36
; 	cbit(lcd_port,RW);				//RW=0 --- Writing to LCD
	cbi 0x8,1
	.dbline 37
; 	lcd_port = 0x30;				//Sending 3
	ldi R24,48
	out 0x8,R24
	.dbline 38
; 	sbit(lcd_port,EN);				//Set Enable Pin
	sbi 0x8,2
	.dbline 39
; 	delay(5);						//Delay
	ldi R16,5
	ldi R17,0
	xcall _delay
	.dbline 40
; 	cbit(lcd_port,EN);				//Clear Enable Pin
	cbi 0x8,2
	.dbline 42
; 
; 	delay(1);
	ldi R16,1
	ldi R17,0
	xcall _delay
	.dbline 44
; 
; 	cbit(lcd_port,RS);				//RS=0 --- Command Input
	cbi 0x8,0
	.dbline 45
; 	cbit(lcd_port,RW);				//RW=0 --- Writing to LCD
	cbi 0x8,1
	.dbline 46
; 	lcd_port = 0x30;				//Sending 3
	ldi R24,48
	out 0x8,R24
	.dbline 47
; 	sbit(lcd_port,EN);				//Set Enable Pin
	sbi 0x8,2
	.dbline 48
; 	delay(5);    					//Delay
	ldi R16,5
	ldi R17,0
	xcall _delay
	.dbline 49
; 	cbit(lcd_port,EN);				//Clear Enable Pin
	cbi 0x8,2
	.dbline 51
; 
; 	delay(1);
	ldi R16,1
	ldi R17,0
	xcall _delay
	.dbline 53
; 
; 	cbit(lcd_port,RS);				//RS=0 --- Command Input
	cbi 0x8,0
	.dbline 54
; 	cbit(lcd_port,RW);				//RW=0 --- Writing to LCD
	cbi 0x8,1
	.dbline 55
; 	lcd_port = 0x20;				//Sending 2 to initialise LCD 4-bit mode
	ldi R24,32
	out 0x8,R24
	.dbline 56
; 	sbit(lcd_port,EN);				//Set Enable Pin
	sbi 0x8,2
	.dbline 57
; 	delay(5);   					//Delay
	ldi R16,5
	ldi R17,0
	xcall _delay
	.dbline 58
; 	cbit(lcd_port,EN);				//Clear Enable Pin
	cbi 0x8,2
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e lcd_init _lcd_init fV
	.even
_lcd_init::
	.dbline -1
	.dbline 63
; }
; 
; /*****Function to Initialize LCD*****/
; void lcd_init()
; {
	.dbline 64
; 	delay(1);
	ldi R16,1
	ldi R17,0
	xcall _delay
	.dbline 66
; 
; 	lcd_wr_command(0x28);			//LCD 4-bit mode and 2 lines.
	ldi R16,40
	xcall _lcd_wr_command
	.dbline 67
; 	lcd_wr_command(0x01);
	ldi R16,1
	xcall _lcd_wr_command
	.dbline 68
; 	lcd_wr_command(0x06);
	ldi R16,6
	xcall _lcd_wr_command
	.dbline 69
; 	lcd_wr_command(0x0E);
	ldi R16,14
	xcall _lcd_wr_command
	.dbline 70
; 	lcd_wr_command(0x80);
	ldi R16,128
	xcall _lcd_wr_command
	.dbline -2
L2:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e lcd_wr_command _lcd_wr_command fV
;           temp -> R22
;            cmd -> R20
	.even
_lcd_wr_command::
	st -y,R20
	st -y,R22
	mov R20,R16
	.dbline -1
	.dbline 77
; 		
; }
; 
; 	 
; /*****Function to Write Command on LCD*****/
; void lcd_wr_command(unsigned char cmd)
; {
	.dbline 79
; 	unsigned char temp;
; 	temp = cmd;
	mov R22,R20
	.dbline 80
; 	temp = temp & 0xF0;
	andi R22,240
	.dbline 81
; 	lcd_port &= 0x0F;
	in R24,0x8
	andi R24,15
	out 0x8,R24
	.dbline 82
; 	lcd_port |= temp;
	in R2,0x8
	or R2,R22
	out 0x8,R2
	.dbline 83
; 	cbit(lcd_port,RS);
	cbi 0x8,0
	.dbline 84
; 	cbit(lcd_port,RW);
	cbi 0x8,1
	.dbline 85
; 	sbit(lcd_port,EN);
	sbi 0x8,2
	.dbline 86
; 	delay(5);
	ldi R16,5
	ldi R17,0
	xcall _delay
	.dbline 87
; 	cbit(lcd_port,EN);
	cbi 0x8,2
	.dbline 89
; 	
; 	cmd = cmd & 0x0F;
	andi R20,15
	.dbline 90
; 	cmd = cmd<<4;
	mov R24,R20
	andi R24,#0x0F
	swap R24
	mov R20,R24
	.dbline 91
; 	lcd_port &= 0x0F;
	in R24,0x8
	andi R24,15
	out 0x8,R24
	.dbline 92
; 	lcd_port |= cmd;
	in R2,0x8
	or R2,R20
	out 0x8,R2
	.dbline 93
; 	cbit(lcd_port,RS);
	cbi 0x8,0
	.dbline 94
; 	cbit(lcd_port,RW);
	cbi 0x8,1
	.dbline 95
; 	sbit(lcd_port,EN);
	sbi 0x8,2
	.dbline 96
; 	delay(5);
	ldi R16,5
	ldi R17,0
	xcall _delay
	.dbline 97
; 	cbit(lcd_port,EN);
	cbi 0x8,2
	.dbline -2
L3:
	.dbline 0 ; func end
	ld R22,y+
	ld R20,y+
	ret
	.dbsym r temp 22 c
	.dbsym r cmd 20 c
	.dbend
	.dbfunc e lcd_wr_char _lcd_wr_char fV
;           temp -> R22
;         letter -> R20
	.even
_lcd_wr_char::
	st -y,R20
	st -y,R22
	mov R20,R16
	.dbline -1
	.dbline 102
; }
; 
; /*****Function to Write Data on LCD*****/
; void lcd_wr_char(char letter)
; {
	.dbline 104
; 	char temp;
; 	temp = letter;
	mov R22,R20
	.dbline 105
; 	temp = (temp & 0xF0);
	andi R22,240
	.dbline 106
; 	lcd_port &= 0x0F;
	in R24,0x8
	andi R24,15
	out 0x8,R24
	.dbline 107
; 	lcd_port |= temp;
	in R2,0x8
	or R2,R22
	out 0x8,R2
	.dbline 108
; 	sbit(lcd_port,RS);
	sbi 0x8,0
	.dbline 109
; 	cbit(lcd_port,RW);
	cbi 0x8,1
	.dbline 110
; 	sbit(lcd_port,EN);
	sbi 0x8,2
	.dbline 111
; 	delay(5);
	ldi R16,5
	ldi R17,0
	xcall _delay
	.dbline 112
; 	cbit(lcd_port,EN);
	cbi 0x8,2
	.dbline 114
; 
; 	letter = letter & 0x0F;
	andi R20,15
	.dbline 115
; 	letter = letter<<4;
	mov R24,R20
	andi R24,#0x0F
	swap R24
	mov R20,R24
	.dbline 116
; 	lcd_port &= 0x0F;
	in R24,0x8
	andi R24,15
	out 0x8,R24
	.dbline 117
; 	lcd_port |= letter;
	in R2,0x8
	or R2,R20
	out 0x8,R2
	.dbline 118
; 	sbit(lcd_port,RS);
	sbi 0x8,0
	.dbline 119
; 	cbit(lcd_port,RW);
	cbi 0x8,1
	.dbline 120
; 	sbit(lcd_port,EN);
	sbi 0x8,2
	.dbline 121
; 	delay(5);
	ldi R16,5
	ldi R17,0
	xcall _delay
	.dbline 122
; 	cbit(lcd_port,EN);
	cbi 0x8,2
	.dbline -2
L4:
	.dbline 0 ; func end
	ld R22,y+
	ld R20,y+
	ret
	.dbsym r temp 22 c
	.dbsym r letter 20 c
	.dbend
	.dbfunc e lcd_home _lcd_home fV
	.even
_lcd_home::
	.dbline -1
	.dbline 127
; }
; 
; 
; void lcd_home()
; {
	.dbline 128
; 	lcd_wr_command(0x80);
	ldi R16,128
	xcall _lcd_wr_command
	.dbline -2
L5:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e lcd_string _lcd_string fV
;            str -> R20,R21
	.even
_lcd_string::
	st -y,R20
	st -y,R21
	movw R20,R16
	.dbline -1
	.dbline 134
; }
; 
; 
; /*****Function to Print String on LCD*****/
; void lcd_string(char *str)
; {
	xjmp L8
L7:
	.dbline 136
; 	while(*str != '\0')
; 	{
	.dbline 137
; 		lcd_wr_char(*str);
	movw R30,R20
	ldd R16,z+0
	xcall _lcd_wr_char
	.dbline 138
; 		str++;
	subi R20,255  ; offset = 1
	sbci R21,255
	.dbline 139
; 	}
L8:
	.dbline 135
	movw R30,R20
	ldd R2,z+0
	tst R2
	brne L7
X0:
	.dbline -2
L6:
	.dbline 0 ; func end
	ld R21,y+
	ld R20,y+
	ret
	.dbsym r str 20 pc
	.dbend
	.dbfunc e lcd_cursor _lcd_cursor fV
;         column -> R20
;            row -> R10
	.even
_lcd_cursor::
	xcall push_xgsetF00C
	mov R20,R18
	mov R10,R16
	.dbline -1
	.dbline 145
; }
; 
; /*** Position the LCD cursor at "row", "column". ***/
; 
; void lcd_cursor (char row, char column)
; {
	.dbline 146
; 	switch (row) {
	mov R22,R10
	clr R23
	cpi R22,1
	ldi R30,0
	cpc R23,R30
	breq L14
X1:
	cpi R22,2
	ldi R30,0
	cpc R23,R30
	breq L15
X2:
	cpi R22,3
	ldi R30,0
	cpc R23,R30
	breq L16
X3:
	cpi R22,4
	ldi R30,0
	cpc R23,R30
	breq L17
X4:
	xjmp L12
L14:
	.dbline 147
; 		case 1: lcd_wr_command (0x80 + column - 1); break;
	mov R16,R20
	subi R16,128    ; addi 128
	subi R16,1
	xcall _lcd_wr_command
	.dbline 147
	xjmp L12
L15:
	.dbline 148
; 		case 2: lcd_wr_command (0xc0 + column - 1); break;
	mov R16,R20
	subi R16,64    ; addi 192
	subi R16,1
	xcall _lcd_wr_command
	.dbline 148
	xjmp L12
L16:
	.dbline 149
; 		case 3: lcd_wr_command (0x94 + column - 1); break;
	mov R16,R20
	subi R16,108    ; addi 148
	subi R16,1
	xcall _lcd_wr_command
	.dbline 149
	xjmp L12
L17:
	.dbline 150
; 		case 4: lcd_wr_command (0xd4 + column - 1); break;
	mov R16,R20
	subi R16,44    ; addi 212
	subi R16,1
	xcall _lcd_wr_command
	.dbline 150
	.dbline 151
; 		default: break;
L12:
	.dbline -2
L10:
	.dbline 0 ; func end
	xjmp pop_xgsetF00C
	.dbsym r column 20 c
	.dbsym r row 10 c
	.dbend
	.dbfunc e lcd_print _lcd_print fV
;           flag -> R22
;         digits -> R20,R21
;          value -> R10,R11
;        coloumn -> R14
;            row -> R12
	.even
_lcd_print::
	xcall push_xgsetF0FC
	mov R14,R18
	mov R12,R16
	ldd R10,y+10
	ldd R11,y+11
	ldd R20,y+12
	ldd R21,y+13
	.dbline -1
	.dbline 157
; 	}
; }
; 
; /***** Function To Print Any input value upto the desired digit on LCD *****/
; void lcd_print (char row, char coloumn, unsigned int value, int digits)
; {
	.dbline 158
; 	unsigned char flag=0;
	clr R22
	.dbline 159
; 	if(row==0||coloumn==0)
	tst R12
	breq L21
X5:
	tst R14
	brne L19
X6:
L21:
	.dbline 160
; 	{
	.dbline 161
; 		lcd_home();
	xcall _lcd_home
	.dbline 162
; 	}
	xjmp L20
L19:
	.dbline 164
; 	else
; 	{
	.dbline 165
; 		lcd_cursor(row,coloumn);
	mov R18,R14
	mov R16,R12
	xcall _lcd_cursor
	.dbline 166
; 	}
L20:
	.dbline 167
; 	if(digits==5 || flag==1)
	cpi R20,5
	ldi R30,0
	cpc R21,R30
	breq L24
X7:
	cpi R22,1
	brne L22
X8:
L24:
	.dbline 168
; 	{
	.dbline 169
; 		million=value/10000+48;
	ldi R18,10000
	ldi R19,39
	movw R16,R10
	xcall div16u
	movw R24,R16
	adiw R24,48
	sts _million+1,R25
	sts _million,R24
	.dbline 170
; 		lcd_wr_char(million);
	mov R16,R24
	xcall _lcd_wr_char
	.dbline 171
; 		flag=1;
	ldi R22,1
	.dbline 172
; 	}
L22:
	.dbline 173
; 	if(digits==4 || flag==1)
	cpi R20,4
	ldi R30,0
	cpc R21,R30
	breq L27
X9:
	cpi R22,1
	brne L25
X10:
L27:
	.dbline 174
; 	{
	.dbline 175
; 		temp = value/1000;
	ldi R18,1000
	ldi R19,3
	movw R16,R10
	xcall div16u
	sts _temp+1,R17
	sts _temp,R16
	.dbline 176
; 		thousand = temp%10 + 48;
	ldi R18,10
	ldi R19,0
	xcall mod16u
	movw R24,R16
	adiw R24,48
	sts _thousand+1,R25
	sts _thousand,R24
	.dbline 177
; 		lcd_wr_char(thousand);
	mov R16,R24
	xcall _lcd_wr_char
	.dbline 178
; 		flag=1;
	ldi R22,1
	.dbline 179
; 	}
L25:
	.dbline 180
; 	if(digits==3 || flag==1)
	cpi R20,3
	ldi R30,0
	cpc R21,R30
	breq L30
X11:
	cpi R22,1
	brne L28
X12:
L30:
	.dbline 181
; 	{
	.dbline 182
; 		temp = value/100;
	ldi R18,100
	ldi R19,0
	movw R16,R10
	xcall div16u
	sts _temp+1,R17
	sts _temp,R16
	.dbline 183
; 		hundred = temp%10 + 48;
	ldi R18,10
	ldi R19,0
	xcall mod16u
	movw R24,R16
	adiw R24,48
	sts _hundred+1,R25
	sts _hundred,R24
	.dbline 184
; 		lcd_wr_char(hundred);
	mov R16,R24
	xcall _lcd_wr_char
	.dbline 185
; 		flag=1;
	ldi R22,1
	.dbline 186
; 	}
L28:
	.dbline 187
; 	if(digits==2 || flag==1)
	cpi R20,2
	ldi R30,0
	cpc R21,R30
	breq L33
X13:
	cpi R22,1
	brne L31
X14:
L33:
	.dbline 188
; 	{
	.dbline 189
; 		temp = value/10;
	ldi R18,10
	ldi R19,0
	movw R16,R10
	xcall div16u
	sts _temp+1,R17
	sts _temp,R16
	.dbline 190
; 		tens = temp%10 + 48;
	ldi R18,10
	ldi R19,0
	xcall mod16u
	movw R24,R16
	adiw R24,48
	sts _tens+1,R25
	sts _tens,R24
	.dbline 191
; 		lcd_wr_char(tens);
	mov R16,R24
	xcall _lcd_wr_char
	.dbline 192
; 		flag=1;
	ldi R22,1
	.dbline 193
; 	}
L31:
	.dbline 194
; 	if(digits==1 || flag==1)
	cpi R20,1
	ldi R30,0
	cpc R21,R30
	breq L36
X15:
	cpi R22,1
	brne L34
X16:
L36:
	.dbline 195
; 	{
	.dbline 196
; 		unit = value%10 + 48;
	ldi R18,10
	ldi R19,0
	movw R16,R10
	xcall mod16u
	movw R24,R16
	adiw R24,48
	sts _unit+1,R25
	sts _unit,R24
	.dbline 197
; 		lcd_wr_char(unit);
	mov R16,R24
	xcall _lcd_wr_char
	.dbline 198
; 	}
L34:
	.dbline 199
; 	if(digits>5)
	ldi R24,5
	ldi R25,0
	cp R24,R20
	cpc R25,R21
	brge L37
X17:
	.dbline 200
; 	{
	.dbline 201
; 		lcd_wr_char('E');
	ldi R16,69
	xcall _lcd_wr_char
	.dbline 202
; 	}
L37:
	.dbline -2
L18:
	.dbline 0 ; func end
	xjmp pop_xgsetF0FC
	.dbsym r flag 22 c
	.dbsym r digits 20 I
	.dbsym r value 10 i
	.dbsym r coloumn 14 c
	.dbsym r row 12 c
	.dbend
	.area bss(ram, con, rel)
	.dbfile C:\Users\ERTSLA~1\Downloads\BUILDI~2\lcd.c
_i::
	.blkb 2
	.dbsym e i _i I
_million::
	.blkb 2
	.dbsym e million _million i
_thousand::
	.blkb 2
	.dbsym e thousand _thousand i
_hundred::
	.blkb 2
	.dbsym e hundred _hundred i
_tens::
	.blkb 2
	.dbsym e tens _tens i
_unit::
	.blkb 2
	.dbsym e unit _unit i
_temp::
	.blkb 2
	.dbsym e temp _temp i
; 	
; }
; 		

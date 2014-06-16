CC = iccavr
CFLAGS =  -e -D__ICC_VERSION="7.14" -DATMEGA -D_EE_EXTIO -DATMega2560  -l -g -Mavr_extended -Wf-use_elpm 
ASFLAGS = $(CFLAGS)  -Wa-g
LFLAGS =  -g -e:0x40000 -xcall -ucrtatmega.o -bfunc_lit:0xe4.0x10000 -dram_end:0x21ff -bdata:0x200.0x21ff -dhwstk_size:16 -beeprom:0.4096 -fihx_coff -S2
FILES = main.o gait.o hexapod.o hexapod_basic.o hexapod_motions.o keyboard.o 

HEXAPOD_CODE_VER_7_MOTION_DEMO:	$(FILES)
	$(CC) -o HEXAPOD_CODE_VER_7_MOTION_DEMO $(LFLAGS) @HEXAPOD_CODE_VER_7_MOTION_DEMO.lk   -lcatm256
main.o: C:\iccv7avr\include\iom2560v.h C:\iccv7avr\include\macros.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_macro.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_motions.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\gait.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\keyboard.h
main.o:	C:\Users\ERTSLA~1\Downloads\BUILDI~2\main.c
	$(CC) -c $(CFLAGS) C:\Users\ERTSLA~1\Downloads\BUILDI~2\main.c
gait.o: C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_macro.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.h
gait.o:	C:\Users\ERTSLA~1\Downloads\BUILDI~2\gait.c
	$(CC) -c $(CFLAGS) C:\Users\ERTSLA~1\Downloads\BUILDI~2\gait.c
hexapod.o: C:\iccv7avr\include\iom2560v.h C:\iccv7avr\include\macros.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_macro.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\keyboard.h
hexapod.o:	C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
	$(CC) -c $(CFLAGS) C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.c
hexapod_basic.o: C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_macro.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.h
hexapod_basic.o:	C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.c
	$(CC) -c $(CFLAGS) C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.c
hexapod_motions.o: C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_macro.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.h
hexapod_motions.o:	C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_motions.c
	$(CC) -c $(CFLAGS) C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_motions.c
keyboard.o: C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_macro.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\gait.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_motions.h C:\Users\ERTSLA~1\Downloads\BUILDI~2\hexapod_basic.h
keyboard.o:	C:\Users\ERTSLA~1\Downloads\BUILDI~2\keyboard.c
	$(CC) -c $(CFLAGS) C:\Users\ERTSLA~1\Downloads\BUILDI~2\keyboard.c

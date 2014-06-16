NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                       efunc_lit   00E4   0084 =    132. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       00E4  __efunc_lit_start
       0168  __efunc_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0168   00A6 =    166. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0168  __lit_start
       020E  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   020E   000E =     14. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       020E  __idata_start
       021C  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   021C   3E90 =  16016. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       010E  __text_start
       010E  __start
       0130  _exit
       0131  _main
       0240  _tripod_gait
       0332  _tripod_gait_2
       0495  _two_leg_gait
       05AB  _tripod_turn_gait
       06BE  _tripod_turn_gait_continuous
       07E7  _two_legged_turn_gait
       0902  _tripod_gait_continuous
       0A11  _tripod_gait_insect_continuous
       0B2D  _wave_gait
       0C64  _ripple_gait
       0E56  _port_init
       0E7E  _timer1_init
       0EA5  _turn_on_sharp15
       0EAB  _turn_off_sharp15
       0EB1  _reset_1A
       0EB5  _set_1A
       0EB7  _reset_1B
       0EBD  _set_1B
       0EC3  _reset_1C
       0EC7  _set_1C
       0EC9  _reset_2A
       0ECF  _set_2A
       0ED5  _reset_2B
       0ED9  _set_2B
       0EDB  _reset_2C
       0EE1  _set_2C
       0EE7  _reset_3A
       0EED  _set_3A
       0EF3  _reset_3B
       0EF9  _set_3B
       0EFF  _reset_3C
       0F05  _set_3C
       0F0B  _reset_SP_RIGHT
       0F11  _set_SP_RIGHT
       0F17  _reset_4A
       0F1B  _set_4A
       0F1D  _reset_4B
       0F21  _set_4B
       0F23  _reset_4C
       0F27  _set_4C
       0F29  _reset_5A
       0F2F  _set_5A
       0F35  _reset_5B
       0F3B  _set_5B
       0F41  _reset_5C
       0F47  _set_5C
       0F4D  _reset_6A
       0F53  _set_6A
       0F59  _reset_6B
       0F5F  _set_6B
       0F65  _reset_6C
       0F6B  _set_6C
       0F71  _timer1_compa_isr
       0FBC  _timer1_compb_isr
       1007  _timer1_compc_isr
       1052  _timer1_ovf_isr
       1155  _uart0_init
       1166  _init_devices
       118D  _uart0_rx_isr
       11C2  _servo_on
       11C4  _servo_off
       11C8  _reset_SP_LEFT
       11CE  _set_SP_LEFT
       11D4  _angle_value_calculation
       11EE  _angle_1A
       11FD  _angle_1B
       120C  _angle_1C
       121B  _angle_2A
       122A  _angle_2B
       1239  _angle_2C
       1248  _angle_3A
       1257  _angle_3B
       1266  _angle_3C
       1275  _angle_4A
       1284  _angle_4B
       1293  _angle_4C
       12A2  _angle_5A
       12B1  _angle_5B
       12C0  _angle_5C
       12CF  _angle_6A
       12DE  _angle_6B
       12ED  _angle_6C
       12FC  _servo_calibration
       1321  _even_A_servo_90
       1328  _even_A_servo_65
       132F  _even_A_servo_115
       1336  _even_BC_servo_90
       1343  _even_BC_servo_up_45
       1350  _even_BC_servo_down_45
       135D  _odd_A_servo_90
       1364  _odd_A_servo_65
       136B  _odd_A_servo_115
       1372  _odd_BC_servo_90
       137F  _odd_BC_servo_up_45
       138C  _odd_BC_servo_down_45
       1399  _robot_rotate_clockwise_7_5
       13B8  _robot_rotate_anticlockwise_7_5
       13D7  _forward
       143A  _back
       149D  _robot_standup
       14C3  _buzzer_on
       14C5  _buzzer_off
       14C9  _delay
       14D7  _ADC_Conversion
       14F9  _initializeAngles
       151C  _angle
       15CF  _angle_XA
       15E5  _angle_XB
       1607  _angle_XC
       1629  _swap
       1634  _setAngle
       1644  _getAngle
       1653  _buzzer_on_off
       166D  _angle_change
       169C  _setMirrorDir
       169F  _getMirrorDir
       16A2  _getMirrorArm
       16C2  _angleMirror
       16E3  _angleMirrorChange
       16F7  _pose
       17C6  _dance
       1871  _sway
       197B  _climb
       1BAE  _walk_on_four
       1C11  _keyboard_control
       1DB6  push_arg4
       1DB8  push_arg2
       1DBB  mod16s
       1DBF  div16s
       1DD9  mod16u
       1DDB  div16u
       1DDC  xdiv16u
       1DF5  mod8u
       1DF7  div8u
       1DF8  xdiv8u
       1E0D  elpm32
       1E21  empy16s
       1E31  pop_xgset30FC
       1E3A  pop_xgsetF0FC
       1E45  push_xgsetF0FC
       1E47  push_xgset30FC
       1E49  push_xgset00FC
       1E4B  push_xgset003C
       1E50  push_xgset300C
       1E55  pop_xgset300C
       1E5A  push_xgsetF000
       1E5F  pop_xgsetF000
       1E64  push_xgsetF00C
       1E6B  pop_xgsetF00C
       1E72  push_xgsetF03C
       1E7B  pop_xgsetF03C
       1E84  neg32
       1E8D  asgncblkx
       1EA6  fpsub
       1EA8  fpadd
       1EA9  fpadd_alt
       1F0E  fpadd2
       1F19  fpsub2
       1F24  fpint
       1F50  unpacks
       1F58  tstR16_R19
       1F60  unpacku
       1F75  normalize_and_pack
       1FA3  pack
       1FAD  fpneg
       1FB4  fpneg2
       1FBA  saveR8toR25
       1FC9  restoreR8toR25
       1FD8  fpmule
       2028  fpmule1
       2032  fpcmp
       203F  fpcmp1
       204A  fpcmp2
       2056  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0200   000E =     14. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0200  _arm_number
       0200  __data_start
       0201  _angle_upper_byte
       0202  _angle_lower_byte
       0203  _degree
       0204  _delay_count
       0206  _serial_communication_interval
       0208  _serial_communication_channel_number
       0209  _motion_busy
       020A  hexapod_basic.c:dirMirror
       020B  hexapod_basic.c:flag
       020D  keyboard.c:change
       020E  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   020E   004B =     75. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       020E  __bss_start
       020E  _movementScaling
       0212  _tempDir
       0214  _dir
       0216  _legNo
       0218  _mode
       0219  _data
       021A  _remote_data
       0222  _angle_lower_byte_6C
       0223  _angle_upper_byte_6C
       0224  _angle_lower_byte_6B
       0225  _angle_upper_byte_6B
       0226  _angle_lower_byte_6A
       0227  _angle_upper_byte_6A
       0228  _angle_lower_byte_5C
       0229  _angle_upper_byte_5C
       022A  _angle_lower_byte_5B
       022B  _angle_upper_byte_5B
       022C  _angle_lower_byte_5A
       022D  _angle_upper_byte_5A
       022E  _angle_lower_byte_4C
       022F  _angle_upper_byte_4C
       0230  _angle_lower_byte_4B
       0231  _angle_upper_byte_4B
       0232  _angle_lower_byte_4A
       0233  _angle_upper_byte_4A
       0234  _angle_lower_byte_3C
       0235  _angle_upper_byte_3C
       0236  _angle_lower_byte_3B
       0237  _angle_upper_byte_3B
       0238  _angle_lower_byte_3A
       0239  _angle_upper_byte_3A
       023A  _angle_lower_byte_2C
       023B  _angle_upper_byte_2C
       023C  _angle_lower_byte_2B
       023D  _angle_upper_byte_2B
       023E  _angle_lower_byte_2A
       023F  _angle_upper_byte_2A
       0240  _angle_lower_byte_1C
       0241  _angle_upper_byte_1C
       0242  _angle_lower_byte_1B
       0243  _angle_upper_byte_1B
       0244  _angle_lower_byte_1A
       0245  _angle_upper_byte_1A
       0246  _ADC_Value
       0247  _angleArr
       0259  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0068 =    104. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\iccv7avr\lib\crtatmega.o	[ crtatmega.s ]
main.o	[ main.c ]
gait.o	[ gait.c ]
hexapod.o	[ hexapod.c ]
hexapod_basic.o	[ hexapod_basic.c ]
hexapod_motions.o	[ hexapod_motions.c ]
keyboard.o	[ keyboard.c ]
<library>	[ asave.s, div16s.s, div16u.s, div8u.s, elpm32.s, emul16s.s, gpop4.s, gpop5.s, gpush.s, gpushx.s, gpushy.s ]
[ gpushz.s, gpushb.s, lneg.s, pmstructx.s, fpadd.s, fpadd2.s, fpsub2.s, fpint.s, fputil.s, fpmule.s, fpmule1.s ]
[ fpcmp.s, fpcmp1.s, fpcmp2.s ]

User Global Definitions

ram_end = 0x21ff
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0xe4
data = 0x200
eeprom:0.4096


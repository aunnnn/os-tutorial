# Session 1
## The Boot Process
* **BIOS** (Basic Input/Output Software) is loaded into chip on computer startup to provide some useful software routines to interact with hardware like screen, keyboard, hard disks.
* It also performs some tests of the hard-ware, like memory is working correctly. 
* Then it finds a **boot sector** from storage devices (floppy drive, hard disk, CD, etc.) and executes the first one that **ends** with magic number 0xaa55.
* _little-endian_: less significant comes first, and will show “55 aa” on the disk.
* 512 bytes disk sector
- - - -
## Boot Sector with Assembly
_Assemblers_ are written to translate human-friendly instructions into machine code, E.g.:
`nasm boot_sect.asm -f bin -o boot_sect.bin`

`.asm` is the file in Assembly language. `boot_sect.bin` is the result machine code we can install as a boot sector on disk:
```
eb fe 00 00 ..
00 ...  ... 00
00 ...  55 aa
``` 
(Result machine code)

#study/os
Install Openbsd on APU4D4
===

### 0. Versions and Description
OpenBSD : **6.9**  
Hardware : **APU4D4**  
Bios : **4.14.0.2**  

### 1. Copy openbsd in USB key
```shell
# Download the last version
wget https://cdn.openbsd.org/pub/OpenBSD/6.9/amd64/install69.img

# Copy to usb
dd if=install69.img of=/dev/sdX bs=1M
```

### 2. Start listen for serial communication
```shell
$ picocom -b 115200 /dev/ttyUSB0

picocom v3.1

port is        : /dev/ttyUSB0
flowcontrol    : none
baudrate is    : 115200
parity is      : none
databits are   : 8
stopbits are   : 1
escape is      : C-a
local echo is  : no
noinit is      : no
noreset is     : no
hangup is      : no
nolock is      : no
send_cmd is    : sz -vv
receive_cmd is : rz -vv -E
imap is        :
omap is        :
emap is        : crcrlf,delbs,
logfile is     : none
initstring     : none
exit_after is  : not set
exit is        : no

Type [C-a] [C-h] to see available commands
Terminal ready
```

### 3. Plug USB and start APU4D4
It is important to enter this before starting boot :
```shell
stty com0 115200
set tty com0
boot /bsd.rd
```
Otherwise openbsd will fail to start.

<pre>
PC Engines apu4
coreboot build 20202806
BIOS version v4.12.0.2
4080 MB ECC DRAM
SeaBIOS (version rel-1.12.1.3-0-g300e8b70)

Press F10 key now for boot menu

Select boot device:

1. USB MSC Drive  USB Flash Memory 1.00
2. AHCI/0: TS128GMSA230S ATA-9 Hard-Disk (119 GiBytes)
3. Payload [setup]
4. Payload [memtest]

<b>SELECT 1</b>

Booting from Hard Disk...
Using drive 0, partition 3.
Loading......
probing: pc0 com0 com1 com2 com3 mem[639K 3325M 752M a20=on]
disk: hd0+ hd1+*
>> OpenBSD/amd64 BOOT 3.53
boot> <b>stty com0 115200</b>
boot> <b>set tty com0</b>
switching console to com>> OpenBSD/amd64 BOOT 3.53
boot> <b>boot /bsd.rd</b>
0
cannot open hd0a:/etc/random.seed: No such file or directory
booting hd0a:/bsd.rd: 3818189+1590272+3878376+0+704512 [109+288+28]=0x989530
entry point at 0xffffffff81001000
Copyright (c) 1982, 1986, 1989, 1991, 1993
        The Regents of the University of California.  All rights reserved.
Copyright (c) 1995-2021 OpenBSD. All rights reserved.  https://www.OpenBSD.org

OpenBSD 6.9 (RAMDISK_CD) #456: Mon Apr 19 10:47:37 MDT 2021
<b>[..]</b>
root on rd0a swap on rd0b dump on rd0b
WARNING: CHECK AND RESET THE DATE!
erase ^?, werase ^W, kill ^U, intr ^C, status ^T

Welcome to the OpenBSD/amd64 6.9 installation program.
(I)nstall, (U)pgrade, (A)utoinstall or (S)hell?
</pre>

### 4. Install OpenBSD
When choosing the fileset, I removed the fileset related to X server:
```shell
Select sets by entering a set name, a file name pattern or 'all'. De-select
sets by prepending a '-', e.g.: '-game*'. Selected sets are labelled '[X]'.
    [X] bsd           [X] base69.tgz    [X] game69.tgz    [X] xfont69.tgz
    [X] bsd.mp        [X] comp69.tgz    [X] xbase69.tgz   [X] xserv69.tgz
    [X] bsd.rd        [X] man69.tgz     [X] xshare69.tgz
Set name(s)? (or 'abort' or 'done') [done] -game* -xbase* -xshare* -xfont* -xserv*
    [X] bsd           [X] base69.tgz    [ ] game69.tgz    [ ] xfont69.tgz
    [X] bsd.mp        [X] comp69.tgz    [ ] xbase69.tgz   [ ] xserv69.tgz
    [X] bsd.rd        [X] man69.tgz     [ ] xshare69.tgz
```



openbsd# disklabel -h sd0
# /dev/rsd0c:
type: SCSI
disk: SCSI disk
label: QEMU HARDDISK
duid: b4605c1bd163560b
flags:
bytes/sector: 512
sectors/track: 63
tracks/cylinder: 255
sectors/cylinder: 16065
cylinders: 130541
total sectors: 2097152000 # total bytes: 1000.0G
boundstart: 64
boundend: 2097141165
drivedata: 0

16 partitions:
#                size           offset  fstype [fsize bsize   cpg]
  a:          1000.0G               64    RAID
  c:          1000.0G                0  unused

openbsd# disklabel -h sd1
# /dev/rsd1c:
type: SCSI
disk: SCSI disk
label: SR CRYPTO
duid: f5fb3579c67036ef
flags:
bytes/sector: 512
sectors/track: 63
tracks/cylinder: 255
sectors/cylinder: 16065
cylinders: 130540
total sectors: 2097140573 # total bytes: 1000.0G
boundstart: 64
boundend: 2097125100
drivedata: 0

16 partitions:
#                size           offset  fstype [fsize bsize   cpg]
  a:           100.0G               64  4.2BSD   2048 16384 12960 # /
  b:            16.0G        209728544    swap                    # none
  c:          1000.0G                0  unused
  d:           500.0G        243288384  4.2BSD   4096 32768 26062 # /seedbox
  e:            50.0G       1291866944  4.2BSD   2048 16384 12960 # /var/mysql
  f:           100.0G       1396739264  4.2BSD   2048 16384 12960 # /var/www/nextcloud

  openbsd# newfs sd1g
/dev/rsd1g: 102406.5MB in 209728576 sectors of 512 bytes
506 cylinder groups of 202.50MB, 12960 blocks, 25920 inodes each
super-block backups (for fsck -b #) at:
 160, 414880, 829600, 1244320, 1659040, 2073760, 2488480, 2903200, 3317920, 3732640, 4147360, 4562080, 4976800, 5391520, 5806240, 6220960, 6635680, 7050400,
 7465120, 7879840, 8294560, 8709280, 9124000, 9538720, 9953440, 10368160, 10782880, 11197600, 11612320, 12027040, 12441760, 12856480, 13271200, 13685920,
 14100640, 14515360, 14930080, 15344800, 15759520, 16174240, 16588960, 17003680, 17418400, 17833120, 18247840, 18662560, 19077280, 19492000, 19906720,
 20321440, 20736160, 21150880, 21565600, 21980320, 22395040, 22809760, 23224480, 23639200, 24053920, 24468640, 24883360, 25298080, 25712800, 26127520,
 26542240, 26956960, 27371680, 27786400, 28201120, 28615840, 29030560, 29445280, 29860000, 30274720, 30689440, 31104160, 31518880, 31933600, 32348320,

openbsd# disklabel -E sd1
Label editor (enter '?' for help at any prompt)
sd1> ?
Available co

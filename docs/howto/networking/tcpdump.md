Tcpdump
===

### Exemples :

```shell
# tcpdump -i em1 -n -ttt -c 5 icmp
tcpdump: listening on em1, link-type EN10MB
Aug 26 23:31:59.459199 192.168.12.254 > 192.168.12.244: icmp: echo request
Aug 26 23:31:59.459486 192.168.12.244 > 192.168.12.254: icmp: echo reply
Aug 26 23:32:00.459304 192.168.12.254 > 192.168.12.244: icmp: echo request
Aug 26 23:32:00.459631 192.168.12.244 > 192.168.12.254: icmp: echo reply
Aug 26 23:32:01.459377 192.168.12.254 > 192.168.12.244: icmp: echo request
```

```shell
# tcpdump -ttt -ni em2 src 192.168.12.252 and dst port 80
tcpdump: listening on em2, link-type EN10MB
Aug 26 23:36:39.146160 192.168.12.252.33080 > 192.168.100.247.80: S 1930598803:1930598803(0) win 64240 <mss 1440,sackOK,timestamp 4217463766 0,nop,wscale 7>
Aug 26 23:36:39.150354 192.168.12.252.33080 > 192.168.100.247.80: . ack 268435457 win 64240
Aug 26 23:37:00.125033 192.168.12.252.33080 > 192.168.100.247.80: F 0:0(0) ack 1 win 64240
Aug 26 23:37:00.128754 192.168.12.252.33080 > 192.168.100.247.80: . ack 2 win 64239
...
```

```shell
# tcpdump -ttt -ni em2 src host 192.168.12.252 and dst net 192.168.100.0/24 and port 445 and tcp
tcpdump: listening on em2, link-type EN10MB
Aug 26 23:47:00.696382 192.168.12.252.37946 > 192.168.100.246.445: F 1351644012:1351644012(0) ack 2959350771 win 502 <nop,nop,timestamp 3357254723 2522773728>
Aug 26 23:47:00.726868 192.168.12.252.37946 > 192.168.100.246.445: . ack 2 win 502 <nop,nop,timestamp 3357254753 2522804541>
Aug 26 23:47:01.417508 192.168.12.252.37948 > 192.168.100.246.445: S 3201063082:3201063082(0) win 64240 <mss 1440,sackOK,timestamp 829232746 0,nop,wscale 7>
Aug 26 23:47:01.418883 192.168.12.252.37948 > 192.168.100.246.445: . ack 1884835177 win 502 <nop,nop,timestamp 829232748 2522805233>
Aug 26 23:47:16.587128 192.168.12.252.37948 > 192.168.100.246.445: P 0:5(5) ack 1 win 502 <nop,nop,timestamp 829247916 2522805233>
Aug 26 23:47:19.741012 192.168.12.252.37948 > 192.168.100.246.445: F 5:5(0) ack 1 win 502 <nop,nop,timestamp 829251070 2522820403>
Aug 26 23:47:19.752274 192.168.12.252.37948 > 192.168.100.246.445: . ack 2 win 502 <nop,nop,timestamp 829251081 2522823567>
```

```shell
# tcpdump -nei em1
tcpdump: listening on em1, link-type EN10MB
23:49:08.851231 00:0d:b9:5b:69:75 b8:27:eb:5a:6a:9c 8100 102: 802.1Q vid 2 pri 3 192.168.12.254 > 192.168.12.244: icmp: echo request
23:49:08.851463 b8:27:eb:5a:6a:9c 00:0d:b9:5b:69:75 8100 102: 802.1Q vid 2 pri 1 192.168.12.244 > 192.168.12.254: icmp: echo reply
23:49:09.851277 00:0d:b9:5b:69:75 b8:27:eb:5a:6a:9c 8100 102: 802.1Q vid 2 pri 3 192.168.12.254 > 192.168.12.244: icmp: echo request
23:49:09.851513 b8:27:eb:5a:6a:9c 00:0d:b9:5b:69:75 8100 102: 802.1Q vid 2 pri 1 192.168.12.244 > 192.168.12.254: icmp: echo reply
```

```shell
# tcpdump -nni em1 -w packet.pcap
tcpdump: listening on em1, link-type EN10MB
^C
10 packets received by filter
0 packets dropped by kernel
```

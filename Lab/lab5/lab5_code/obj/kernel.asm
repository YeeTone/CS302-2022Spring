
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <kern_entry>:
    80200000:	00004117          	auipc	sp,0x4
    80200004:	00010113          	mv	sp,sp
    80200008:	a009                	j	8020000a <kern_init>

000000008020000a <kern_init>:
    8020000a:	00004517          	auipc	a0,0x4
    8020000e:	ffe50513          	addi	a0,a0,-2 # 80204008 <SBI_SET_TIMER>
    80200012:	00004617          	auipc	a2,0x4
    80200016:	00660613          	addi	a2,a2,6 # 80204018 <end>
    8020001a:	1141                	addi	sp,sp,-16
    8020001c:	8e09                	sub	a2,a2,a0
    8020001e:	4581                	li	a1,0
    80200020:	e406                	sd	ra,8(sp)
    80200022:	4e0000ef          	jal	ra,80200502 <memset>
    80200026:	00001517          	auipc	a0,0x1
    8020002a:	91250513          	addi	a0,a0,-1774 # 80200938 <etext+0x2>
    8020002e:	062000ef          	jal	ra,80200090 <cputs>
    80200032:	0bc000ef          	jal	ra,802000ee <idt_init>
    80200036:	0b2000ef          	jal	ra,802000e8 <intr_enable>
    8020003a:	30200073          	mret
    8020003e:	a001                	j	8020003e <kern_init+0x34>

0000000080200040 <cputch>:
    80200040:	1141                	addi	sp,sp,-16
    80200042:	e022                	sd	s0,0(sp)
    80200044:	e406                	sd	ra,8(sp)
    80200046:	842e                	mv	s0,a1
    80200048:	098000ef          	jal	ra,802000e0 <cons_putc>
    8020004c:	401c                	lw	a5,0(s0)
    8020004e:	60a2                	ld	ra,8(sp)
    80200050:	2785                	addiw	a5,a5,1
    80200052:	c01c                	sw	a5,0(s0)
    80200054:	6402                	ld	s0,0(sp)
    80200056:	0141                	addi	sp,sp,16
    80200058:	8082                	ret

000000008020005a <cprintf>:
    8020005a:	711d                	addi	sp,sp,-96
    8020005c:	02810313          	addi	t1,sp,40 # 80204028 <end+0x10>
    80200060:	8e2a                	mv	t3,a0
    80200062:	f42e                	sd	a1,40(sp)
    80200064:	f832                	sd	a2,48(sp)
    80200066:	fc36                	sd	a3,56(sp)
    80200068:	00000517          	auipc	a0,0x0
    8020006c:	fd850513          	addi	a0,a0,-40 # 80200040 <cputch>
    80200070:	004c                	addi	a1,sp,4
    80200072:	869a                	mv	a3,t1
    80200074:	8672                	mv	a2,t3
    80200076:	ec06                	sd	ra,24(sp)
    80200078:	e0ba                	sd	a4,64(sp)
    8020007a:	e4be                	sd	a5,72(sp)
    8020007c:	e8c2                	sd	a6,80(sp)
    8020007e:	ecc6                	sd	a7,88(sp)
    80200080:	e41a                	sd	t1,8(sp)
    80200082:	c202                	sw	zero,4(sp)
    80200084:	4fc000ef          	jal	ra,80200580 <vprintfmt>
    80200088:	60e2                	ld	ra,24(sp)
    8020008a:	4512                	lw	a0,4(sp)
    8020008c:	6125                	addi	sp,sp,96
    8020008e:	8082                	ret

0000000080200090 <cputs>:
    80200090:	1101                	addi	sp,sp,-32
    80200092:	e822                	sd	s0,16(sp)
    80200094:	ec06                	sd	ra,24(sp)
    80200096:	e426                	sd	s1,8(sp)
    80200098:	842a                	mv	s0,a0
    8020009a:	00054503          	lbu	a0,0(a0)
    8020009e:	c51d                	beqz	a0,802000cc <cputs+0x3c>
    802000a0:	0405                	addi	s0,s0,1
    802000a2:	4485                	li	s1,1
    802000a4:	9c81                	subw	s1,s1,s0
    802000a6:	03a000ef          	jal	ra,802000e0 <cons_putc>
    802000aa:	00044503          	lbu	a0,0(s0)
    802000ae:	008487bb          	addw	a5,s1,s0
    802000b2:	0405                	addi	s0,s0,1
    802000b4:	f96d                	bnez	a0,802000a6 <cputs+0x16>
    802000b6:	0017841b          	addiw	s0,a5,1
    802000ba:	4529                	li	a0,10
    802000bc:	024000ef          	jal	ra,802000e0 <cons_putc>
    802000c0:	60e2                	ld	ra,24(sp)
    802000c2:	8522                	mv	a0,s0
    802000c4:	6442                	ld	s0,16(sp)
    802000c6:	64a2                	ld	s1,8(sp)
    802000c8:	6105                	addi	sp,sp,32
    802000ca:	8082                	ret
    802000cc:	4405                	li	s0,1
    802000ce:	b7f5                	j	802000ba <cputs+0x2a>

00000000802000d0 <clock_set_next_event>:
    802000d0:	c0102573          	rdtime	a0
    802000d4:	67e1                	lui	a5,0x18
    802000d6:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0x801e7960>
    802000da:	953e                	add	a0,a0,a5
    802000dc:	0410006f          	j	8020091c <sbi_set_timer>

00000000802000e0 <cons_putc>:
    802000e0:	0ff57513          	andi	a0,a0,255
    802000e4:	01f0006f          	j	80200902 <sbi_console_putchar>

00000000802000e8 <intr_enable>:
    802000e8:	100167f3          	csrrsi	a5,sstatus,2
    802000ec:	8082                	ret

00000000802000ee <idt_init>:
    802000ee:	00000797          	auipc	a5,0x0
    802000f2:	34278793          	addi	a5,a5,834 # 80200430 <__alltraps>
    802000f6:	10579073          	csrw	stvec,a5
    802000fa:	8082                	ret

00000000802000fc <print_regs>:
    802000fc:	610c                	ld	a1,0(a0)
    802000fe:	1141                	addi	sp,sp,-16
    80200100:	e022                	sd	s0,0(sp)
    80200102:	842a                	mv	s0,a0
    80200104:	00001517          	auipc	a0,0x1
    80200108:	84c50513          	addi	a0,a0,-1972 # 80200950 <etext+0x1a>
    8020010c:	e406                	sd	ra,8(sp)
    8020010e:	f4dff0ef          	jal	ra,8020005a <cprintf>
    80200112:	640c                	ld	a1,8(s0)
    80200114:	00001517          	auipc	a0,0x1
    80200118:	85450513          	addi	a0,a0,-1964 # 80200968 <etext+0x32>
    8020011c:	f3fff0ef          	jal	ra,8020005a <cprintf>
    80200120:	680c                	ld	a1,16(s0)
    80200122:	00001517          	auipc	a0,0x1
    80200126:	85e50513          	addi	a0,a0,-1954 # 80200980 <etext+0x4a>
    8020012a:	f31ff0ef          	jal	ra,8020005a <cprintf>
    8020012e:	6c0c                	ld	a1,24(s0)
    80200130:	00001517          	auipc	a0,0x1
    80200134:	86850513          	addi	a0,a0,-1944 # 80200998 <etext+0x62>
    80200138:	f23ff0ef          	jal	ra,8020005a <cprintf>
    8020013c:	700c                	ld	a1,32(s0)
    8020013e:	00001517          	auipc	a0,0x1
    80200142:	87250513          	addi	a0,a0,-1934 # 802009b0 <etext+0x7a>
    80200146:	f15ff0ef          	jal	ra,8020005a <cprintf>
    8020014a:	740c                	ld	a1,40(s0)
    8020014c:	00001517          	auipc	a0,0x1
    80200150:	87c50513          	addi	a0,a0,-1924 # 802009c8 <etext+0x92>
    80200154:	f07ff0ef          	jal	ra,8020005a <cprintf>
    80200158:	780c                	ld	a1,48(s0)
    8020015a:	00001517          	auipc	a0,0x1
    8020015e:	88650513          	addi	a0,a0,-1914 # 802009e0 <etext+0xaa>
    80200162:	ef9ff0ef          	jal	ra,8020005a <cprintf>
    80200166:	7c0c                	ld	a1,56(s0)
    80200168:	00001517          	auipc	a0,0x1
    8020016c:	89050513          	addi	a0,a0,-1904 # 802009f8 <etext+0xc2>
    80200170:	eebff0ef          	jal	ra,8020005a <cprintf>
    80200174:	602c                	ld	a1,64(s0)
    80200176:	00001517          	auipc	a0,0x1
    8020017a:	89a50513          	addi	a0,a0,-1894 # 80200a10 <etext+0xda>
    8020017e:	eddff0ef          	jal	ra,8020005a <cprintf>
    80200182:	642c                	ld	a1,72(s0)
    80200184:	00001517          	auipc	a0,0x1
    80200188:	8a450513          	addi	a0,a0,-1884 # 80200a28 <etext+0xf2>
    8020018c:	ecfff0ef          	jal	ra,8020005a <cprintf>
    80200190:	682c                	ld	a1,80(s0)
    80200192:	00001517          	auipc	a0,0x1
    80200196:	8ae50513          	addi	a0,a0,-1874 # 80200a40 <etext+0x10a>
    8020019a:	ec1ff0ef          	jal	ra,8020005a <cprintf>
    8020019e:	6c2c                	ld	a1,88(s0)
    802001a0:	00001517          	auipc	a0,0x1
    802001a4:	8b850513          	addi	a0,a0,-1864 # 80200a58 <etext+0x122>
    802001a8:	eb3ff0ef          	jal	ra,8020005a <cprintf>
    802001ac:	702c                	ld	a1,96(s0)
    802001ae:	00001517          	auipc	a0,0x1
    802001b2:	8c250513          	addi	a0,a0,-1854 # 80200a70 <etext+0x13a>
    802001b6:	ea5ff0ef          	jal	ra,8020005a <cprintf>
    802001ba:	742c                	ld	a1,104(s0)
    802001bc:	00001517          	auipc	a0,0x1
    802001c0:	8cc50513          	addi	a0,a0,-1844 # 80200a88 <etext+0x152>
    802001c4:	e97ff0ef          	jal	ra,8020005a <cprintf>
    802001c8:	782c                	ld	a1,112(s0)
    802001ca:	00001517          	auipc	a0,0x1
    802001ce:	8d650513          	addi	a0,a0,-1834 # 80200aa0 <etext+0x16a>
    802001d2:	e89ff0ef          	jal	ra,8020005a <cprintf>
    802001d6:	7c2c                	ld	a1,120(s0)
    802001d8:	00001517          	auipc	a0,0x1
    802001dc:	8e050513          	addi	a0,a0,-1824 # 80200ab8 <etext+0x182>
    802001e0:	e7bff0ef          	jal	ra,8020005a <cprintf>
    802001e4:	604c                	ld	a1,128(s0)
    802001e6:	00001517          	auipc	a0,0x1
    802001ea:	8ea50513          	addi	a0,a0,-1814 # 80200ad0 <etext+0x19a>
    802001ee:	e6dff0ef          	jal	ra,8020005a <cprintf>
    802001f2:	644c                	ld	a1,136(s0)
    802001f4:	00001517          	auipc	a0,0x1
    802001f8:	8f450513          	addi	a0,a0,-1804 # 80200ae8 <etext+0x1b2>
    802001fc:	e5fff0ef          	jal	ra,8020005a <cprintf>
    80200200:	684c                	ld	a1,144(s0)
    80200202:	00001517          	auipc	a0,0x1
    80200206:	8fe50513          	addi	a0,a0,-1794 # 80200b00 <etext+0x1ca>
    8020020a:	e51ff0ef          	jal	ra,8020005a <cprintf>
    8020020e:	6c4c                	ld	a1,152(s0)
    80200210:	00001517          	auipc	a0,0x1
    80200214:	90850513          	addi	a0,a0,-1784 # 80200b18 <etext+0x1e2>
    80200218:	e43ff0ef          	jal	ra,8020005a <cprintf>
    8020021c:	704c                	ld	a1,160(s0)
    8020021e:	00001517          	auipc	a0,0x1
    80200222:	91250513          	addi	a0,a0,-1774 # 80200b30 <etext+0x1fa>
    80200226:	e35ff0ef          	jal	ra,8020005a <cprintf>
    8020022a:	744c                	ld	a1,168(s0)
    8020022c:	00001517          	auipc	a0,0x1
    80200230:	91c50513          	addi	a0,a0,-1764 # 80200b48 <etext+0x212>
    80200234:	e27ff0ef          	jal	ra,8020005a <cprintf>
    80200238:	784c                	ld	a1,176(s0)
    8020023a:	00001517          	auipc	a0,0x1
    8020023e:	92650513          	addi	a0,a0,-1754 # 80200b60 <etext+0x22a>
    80200242:	e19ff0ef          	jal	ra,8020005a <cprintf>
    80200246:	7c4c                	ld	a1,184(s0)
    80200248:	00001517          	auipc	a0,0x1
    8020024c:	93050513          	addi	a0,a0,-1744 # 80200b78 <etext+0x242>
    80200250:	e0bff0ef          	jal	ra,8020005a <cprintf>
    80200254:	606c                	ld	a1,192(s0)
    80200256:	00001517          	auipc	a0,0x1
    8020025a:	93a50513          	addi	a0,a0,-1734 # 80200b90 <etext+0x25a>
    8020025e:	dfdff0ef          	jal	ra,8020005a <cprintf>
    80200262:	646c                	ld	a1,200(s0)
    80200264:	00001517          	auipc	a0,0x1
    80200268:	94450513          	addi	a0,a0,-1724 # 80200ba8 <etext+0x272>
    8020026c:	defff0ef          	jal	ra,8020005a <cprintf>
    80200270:	686c                	ld	a1,208(s0)
    80200272:	00001517          	auipc	a0,0x1
    80200276:	94e50513          	addi	a0,a0,-1714 # 80200bc0 <etext+0x28a>
    8020027a:	de1ff0ef          	jal	ra,8020005a <cprintf>
    8020027e:	6c6c                	ld	a1,216(s0)
    80200280:	00001517          	auipc	a0,0x1
    80200284:	95850513          	addi	a0,a0,-1704 # 80200bd8 <etext+0x2a2>
    80200288:	dd3ff0ef          	jal	ra,8020005a <cprintf>
    8020028c:	706c                	ld	a1,224(s0)
    8020028e:	00001517          	auipc	a0,0x1
    80200292:	96250513          	addi	a0,a0,-1694 # 80200bf0 <etext+0x2ba>
    80200296:	dc5ff0ef          	jal	ra,8020005a <cprintf>
    8020029a:	746c                	ld	a1,232(s0)
    8020029c:	00001517          	auipc	a0,0x1
    802002a0:	96c50513          	addi	a0,a0,-1684 # 80200c08 <etext+0x2d2>
    802002a4:	db7ff0ef          	jal	ra,8020005a <cprintf>
    802002a8:	786c                	ld	a1,240(s0)
    802002aa:	00001517          	auipc	a0,0x1
    802002ae:	97650513          	addi	a0,a0,-1674 # 80200c20 <etext+0x2ea>
    802002b2:	da9ff0ef          	jal	ra,8020005a <cprintf>
    802002b6:	7c6c                	ld	a1,248(s0)
    802002b8:	6402                	ld	s0,0(sp)
    802002ba:	60a2                	ld	ra,8(sp)
    802002bc:	00001517          	auipc	a0,0x1
    802002c0:	97c50513          	addi	a0,a0,-1668 # 80200c38 <etext+0x302>
    802002c4:	0141                	addi	sp,sp,16
    802002c6:	bb51                	j	8020005a <cprintf>

00000000802002c8 <print_trapframe>:
    802002c8:	1141                	addi	sp,sp,-16
    802002ca:	e022                	sd	s0,0(sp)
    802002cc:	85aa                	mv	a1,a0
    802002ce:	842a                	mv	s0,a0
    802002d0:	00001517          	auipc	a0,0x1
    802002d4:	98050513          	addi	a0,a0,-1664 # 80200c50 <etext+0x31a>
    802002d8:	e406                	sd	ra,8(sp)
    802002da:	d81ff0ef          	jal	ra,8020005a <cprintf>
    802002de:	8522                	mv	a0,s0
    802002e0:	e1dff0ef          	jal	ra,802000fc <print_regs>
    802002e4:	10043583          	ld	a1,256(s0)
    802002e8:	00001517          	auipc	a0,0x1
    802002ec:	98050513          	addi	a0,a0,-1664 # 80200c68 <etext+0x332>
    802002f0:	d6bff0ef          	jal	ra,8020005a <cprintf>
    802002f4:	10843583          	ld	a1,264(s0)
    802002f8:	00001517          	auipc	a0,0x1
    802002fc:	98850513          	addi	a0,a0,-1656 # 80200c80 <etext+0x34a>
    80200300:	d5bff0ef          	jal	ra,8020005a <cprintf>
    80200304:	11043583          	ld	a1,272(s0)
    80200308:	00001517          	auipc	a0,0x1
    8020030c:	99050513          	addi	a0,a0,-1648 # 80200c98 <etext+0x362>
    80200310:	d4bff0ef          	jal	ra,8020005a <cprintf>
    80200314:	11843583          	ld	a1,280(s0)
    80200318:	6402                	ld	s0,0(sp)
    8020031a:	60a2                	ld	ra,8(sp)
    8020031c:	00001517          	auipc	a0,0x1
    80200320:	99450513          	addi	a0,a0,-1644 # 80200cb0 <etext+0x37a>
    80200324:	0141                	addi	sp,sp,16
    80200326:	bb15                	j	8020005a <cprintf>

0000000080200328 <interrupt_handler>:
    80200328:	11853783          	ld	a5,280(a0)
    8020032c:	472d                	li	a4,11
    8020032e:	0786                	slli	a5,a5,0x1
    80200330:	8385                	srli	a5,a5,0x1
    80200332:	06f76763          	bltu	a4,a5,802003a0 <interrupt_handler+0x78>
    80200336:	00001717          	auipc	a4,0x1
    8020033a:	a4270713          	addi	a4,a4,-1470 # 80200d78 <etext+0x442>
    8020033e:	078a                	slli	a5,a5,0x2
    80200340:	97ba                	add	a5,a5,a4
    80200342:	439c                	lw	a5,0(a5)
    80200344:	97ba                	add	a5,a5,a4
    80200346:	8782                	jr	a5
    80200348:	00001517          	auipc	a0,0x1
    8020034c:	9e050513          	addi	a0,a0,-1568 # 80200d28 <etext+0x3f2>
    80200350:	b329                	j	8020005a <cprintf>
    80200352:	00001517          	auipc	a0,0x1
    80200356:	9b650513          	addi	a0,a0,-1610 # 80200d08 <etext+0x3d2>
    8020035a:	b301                	j	8020005a <cprintf>
    8020035c:	00001517          	auipc	a0,0x1
    80200360:	96c50513          	addi	a0,a0,-1684 # 80200cc8 <etext+0x392>
    80200364:	b9dd                	j	8020005a <cprintf>
    80200366:	00001517          	auipc	a0,0x1
    8020036a:	98250513          	addi	a0,a0,-1662 # 80200ce8 <etext+0x3b2>
    8020036e:	b1f5                	j	8020005a <cprintf>
    80200370:	1141                	addi	sp,sp,-16
    80200372:	e406                	sd	ra,8(sp)
    80200374:	d5dff0ef          	jal	ra,802000d0 <clock_set_next_event>
    80200378:	00004697          	auipc	a3,0x4
    8020037c:	c9868693          	addi	a3,a3,-872 # 80204010 <ticks>
    80200380:	629c                	ld	a5,0(a3)
    80200382:	06400713          	li	a4,100
    80200386:	0785                	addi	a5,a5,1
    80200388:	02e7f733          	remu	a4,a5,a4
    8020038c:	e29c                	sd	a5,0(a3)
    8020038e:	cb11                	beqz	a4,802003a2 <interrupt_handler+0x7a>
    80200390:	60a2                	ld	ra,8(sp)
    80200392:	0141                	addi	sp,sp,16
    80200394:	8082                	ret
    80200396:	00001517          	auipc	a0,0x1
    8020039a:	9c250513          	addi	a0,a0,-1598 # 80200d58 <etext+0x422>
    8020039e:	b975                	j	8020005a <cprintf>
    802003a0:	b725                	j	802002c8 <print_trapframe>
    802003a2:	60a2                	ld	ra,8(sp)
    802003a4:	06400593          	li	a1,100
    802003a8:	00001517          	auipc	a0,0x1
    802003ac:	9a050513          	addi	a0,a0,-1632 # 80200d48 <etext+0x412>
    802003b0:	0141                	addi	sp,sp,16
    802003b2:	b165                	j	8020005a <cprintf>

00000000802003b4 <exception_handler>:
    802003b4:	11853783          	ld	a5,280(a0)
    802003b8:	1141                	addi	sp,sp,-16
    802003ba:	e022                	sd	s0,0(sp)
    802003bc:	e406                	sd	ra,8(sp)
    802003be:	470d                	li	a4,3
    802003c0:	842a                	mv	s0,a0
    802003c2:	04e78063          	beq	a5,a4,80200402 <exception_handler+0x4e>
    802003c6:	02f76663          	bltu	a4,a5,802003f2 <exception_handler+0x3e>
    802003ca:	4709                	li	a4,2
    802003cc:	00e79f63          	bne	a5,a4,802003ea <exception_handler+0x36>
    802003d0:	10853583          	ld	a1,264(a0)
    802003d4:	00001517          	auipc	a0,0x1
    802003d8:	9d450513          	addi	a0,a0,-1580 # 80200da8 <etext+0x472>
    802003dc:	c7fff0ef          	jal	ra,8020005a <cprintf>
    802003e0:	10843783          	ld	a5,264(s0)
    802003e4:	0791                	addi	a5,a5,4
    802003e6:	10f43423          	sd	a5,264(s0)
    802003ea:	60a2                	ld	ra,8(sp)
    802003ec:	6402                	ld	s0,0(sp)
    802003ee:	0141                	addi	sp,sp,16
    802003f0:	8082                	ret
    802003f2:	17f1                	addi	a5,a5,-4
    802003f4:	471d                	li	a4,7
    802003f6:	fef77ae3          	bgeu	a4,a5,802003ea <exception_handler+0x36>
    802003fa:	6402                	ld	s0,0(sp)
    802003fc:	60a2                	ld	ra,8(sp)
    802003fe:	0141                	addi	sp,sp,16
    80200400:	b5e1                	j	802002c8 <print_trapframe>
    80200402:	10853583          	ld	a1,264(a0)
    80200406:	00001517          	auipc	a0,0x1
    8020040a:	9d250513          	addi	a0,a0,-1582 # 80200dd8 <etext+0x4a2>
    8020040e:	c4dff0ef          	jal	ra,8020005a <cprintf>
    80200412:	10843783          	ld	a5,264(s0)
    80200416:	60a2                	ld	ra,8(sp)
    80200418:	0789                	addi	a5,a5,2
    8020041a:	10f43423          	sd	a5,264(s0)
    8020041e:	6402                	ld	s0,0(sp)
    80200420:	0141                	addi	sp,sp,16
    80200422:	8082                	ret

0000000080200424 <trap>:
    80200424:	11853783          	ld	a5,280(a0)
    80200428:	0007c363          	bltz	a5,8020042e <trap+0xa>
    8020042c:	b761                	j	802003b4 <exception_handler>
    8020042e:	bded                	j	80200328 <interrupt_handler>

0000000080200430 <__alltraps>:
    80200430:	14011073          	csrw	sscratch,sp
    80200434:	712d                	addi	sp,sp,-288
    80200436:	e002                	sd	zero,0(sp)
    80200438:	e406                	sd	ra,8(sp)
    8020043a:	ec0e                	sd	gp,24(sp)
    8020043c:	f012                	sd	tp,32(sp)
    8020043e:	f416                	sd	t0,40(sp)
    80200440:	f81a                	sd	t1,48(sp)
    80200442:	fc1e                	sd	t2,56(sp)
    80200444:	e0a2                	sd	s0,64(sp)
    80200446:	e4a6                	sd	s1,72(sp)
    80200448:	e8aa                	sd	a0,80(sp)
    8020044a:	ecae                	sd	a1,88(sp)
    8020044c:	f0b2                	sd	a2,96(sp)
    8020044e:	f4b6                	sd	a3,104(sp)
    80200450:	f8ba                	sd	a4,112(sp)
    80200452:	fcbe                	sd	a5,120(sp)
    80200454:	e142                	sd	a6,128(sp)
    80200456:	e546                	sd	a7,136(sp)
    80200458:	e94a                	sd	s2,144(sp)
    8020045a:	ed4e                	sd	s3,152(sp)
    8020045c:	f152                	sd	s4,160(sp)
    8020045e:	f556                	sd	s5,168(sp)
    80200460:	f95a                	sd	s6,176(sp)
    80200462:	fd5e                	sd	s7,184(sp)
    80200464:	e1e2                	sd	s8,192(sp)
    80200466:	e5e6                	sd	s9,200(sp)
    80200468:	e9ea                	sd	s10,208(sp)
    8020046a:	edee                	sd	s11,216(sp)
    8020046c:	f1f2                	sd	t3,224(sp)
    8020046e:	f5f6                	sd	t4,232(sp)
    80200470:	f9fa                	sd	t5,240(sp)
    80200472:	fdfe                	sd	t6,248(sp)
    80200474:	14001473          	csrrw	s0,sscratch,zero
    80200478:	100024f3          	csrr	s1,sstatus
    8020047c:	14102973          	csrr	s2,sepc
    80200480:	143029f3          	csrr	s3,stval
    80200484:	14202a73          	csrr	s4,scause
    80200488:	e822                	sd	s0,16(sp)
    8020048a:	e226                	sd	s1,256(sp)
    8020048c:	e64a                	sd	s2,264(sp)
    8020048e:	ea4e                	sd	s3,272(sp)
    80200490:	ee52                	sd	s4,280(sp)
    80200492:	850a                	mv	a0,sp
    80200494:	f91ff0ef          	jal	ra,80200424 <trap>

0000000080200498 <__trapret>:
    80200498:	6492                	ld	s1,256(sp)
    8020049a:	6932                	ld	s2,264(sp)
    8020049c:	10049073          	csrw	sstatus,s1
    802004a0:	14191073          	csrw	sepc,s2
    802004a4:	60a2                	ld	ra,8(sp)
    802004a6:	61e2                	ld	gp,24(sp)
    802004a8:	7202                	ld	tp,32(sp)
    802004aa:	72a2                	ld	t0,40(sp)
    802004ac:	7342                	ld	t1,48(sp)
    802004ae:	73e2                	ld	t2,56(sp)
    802004b0:	6406                	ld	s0,64(sp)
    802004b2:	64a6                	ld	s1,72(sp)
    802004b4:	6546                	ld	a0,80(sp)
    802004b6:	65e6                	ld	a1,88(sp)
    802004b8:	7606                	ld	a2,96(sp)
    802004ba:	76a6                	ld	a3,104(sp)
    802004bc:	7746                	ld	a4,112(sp)
    802004be:	77e6                	ld	a5,120(sp)
    802004c0:	680a                	ld	a6,128(sp)
    802004c2:	68aa                	ld	a7,136(sp)
    802004c4:	694a                	ld	s2,144(sp)
    802004c6:	69ea                	ld	s3,152(sp)
    802004c8:	7a0a                	ld	s4,160(sp)
    802004ca:	7aaa                	ld	s5,168(sp)
    802004cc:	7b4a                	ld	s6,176(sp)
    802004ce:	7bea                	ld	s7,184(sp)
    802004d0:	6c0e                	ld	s8,192(sp)
    802004d2:	6cae                	ld	s9,200(sp)
    802004d4:	6d4e                	ld	s10,208(sp)
    802004d6:	6dee                	ld	s11,216(sp)
    802004d8:	7e0e                	ld	t3,224(sp)
    802004da:	7eae                	ld	t4,232(sp)
    802004dc:	7f4e                	ld	t5,240(sp)
    802004de:	7fee                	ld	t6,248(sp)
    802004e0:	6142                	ld	sp,16(sp)
    802004e2:	10200073          	sret

00000000802004e6 <strnlen>:
    802004e6:	872a                	mv	a4,a0
    802004e8:	4501                	li	a0,0
    802004ea:	e589                	bnez	a1,802004f4 <strnlen+0xe>
    802004ec:	a811                	j	80200500 <strnlen+0x1a>
    802004ee:	0505                	addi	a0,a0,1
    802004f0:	00a58763          	beq	a1,a0,802004fe <strnlen+0x18>
    802004f4:	00a707b3          	add	a5,a4,a0
    802004f8:	0007c783          	lbu	a5,0(a5)
    802004fc:	fbed                	bnez	a5,802004ee <strnlen+0x8>
    802004fe:	8082                	ret
    80200500:	8082                	ret

0000000080200502 <memset>:
    80200502:	ca01                	beqz	a2,80200512 <memset+0x10>
    80200504:	962a                	add	a2,a2,a0
    80200506:	87aa                	mv	a5,a0
    80200508:	0785                	addi	a5,a5,1
    8020050a:	feb78fa3          	sb	a1,-1(a5)
    8020050e:	fec79de3          	bne	a5,a2,80200508 <memset+0x6>
    80200512:	8082                	ret

0000000080200514 <printnum>:
    80200514:	02069813          	slli	a6,a3,0x20
    80200518:	7179                	addi	sp,sp,-48
    8020051a:	02085813          	srli	a6,a6,0x20
    8020051e:	e052                	sd	s4,0(sp)
    80200520:	03067a33          	remu	s4,a2,a6
    80200524:	f022                	sd	s0,32(sp)
    80200526:	ec26                	sd	s1,24(sp)
    80200528:	e84a                	sd	s2,16(sp)
    8020052a:	f406                	sd	ra,40(sp)
    8020052c:	e44e                	sd	s3,8(sp)
    8020052e:	84aa                	mv	s1,a0
    80200530:	892e                	mv	s2,a1
    80200532:	fff7041b          	addiw	s0,a4,-1
    80200536:	2a01                	sext.w	s4,s4
    80200538:	03067e63          	bgeu	a2,a6,80200574 <printnum+0x60>
    8020053c:	89be                	mv	s3,a5
    8020053e:	00805763          	blez	s0,8020054c <printnum+0x38>
    80200542:	347d                	addiw	s0,s0,-1
    80200544:	85ca                	mv	a1,s2
    80200546:	854e                	mv	a0,s3
    80200548:	9482                	jalr	s1
    8020054a:	fc65                	bnez	s0,80200542 <printnum+0x2e>
    8020054c:	1a02                	slli	s4,s4,0x20
    8020054e:	020a5a13          	srli	s4,s4,0x20
    80200552:	00001797          	auipc	a5,0x1
    80200556:	8a678793          	addi	a5,a5,-1882 # 80200df8 <etext+0x4c2>
    8020055a:	7402                	ld	s0,32(sp)
    8020055c:	9a3e                	add	s4,s4,a5
    8020055e:	000a4503          	lbu	a0,0(s4)
    80200562:	70a2                	ld	ra,40(sp)
    80200564:	69a2                	ld	s3,8(sp)
    80200566:	6a02                	ld	s4,0(sp)
    80200568:	85ca                	mv	a1,s2
    8020056a:	8326                	mv	t1,s1
    8020056c:	6942                	ld	s2,16(sp)
    8020056e:	64e2                	ld	s1,24(sp)
    80200570:	6145                	addi	sp,sp,48
    80200572:	8302                	jr	t1
    80200574:	03065633          	divu	a2,a2,a6
    80200578:	8722                	mv	a4,s0
    8020057a:	f9bff0ef          	jal	ra,80200514 <printnum>
    8020057e:	b7f9                	j	8020054c <printnum+0x38>

0000000080200580 <vprintfmt>:
    80200580:	7119                	addi	sp,sp,-128
    80200582:	f4a6                	sd	s1,104(sp)
    80200584:	f0ca                	sd	s2,96(sp)
    80200586:	ecce                	sd	s3,88(sp)
    80200588:	e8d2                	sd	s4,80(sp)
    8020058a:	e4d6                	sd	s5,72(sp)
    8020058c:	e0da                	sd	s6,64(sp)
    8020058e:	fc5e                	sd	s7,56(sp)
    80200590:	f06a                	sd	s10,32(sp)
    80200592:	fc86                	sd	ra,120(sp)
    80200594:	f8a2                	sd	s0,112(sp)
    80200596:	f862                	sd	s8,48(sp)
    80200598:	f466                	sd	s9,40(sp)
    8020059a:	ec6e                	sd	s11,24(sp)
    8020059c:	892a                	mv	s2,a0
    8020059e:	84ae                	mv	s1,a1
    802005a0:	8d32                	mv	s10,a2
    802005a2:	8a36                	mv	s4,a3
    802005a4:	02500993          	li	s3,37
    802005a8:	5b7d                	li	s6,-1
    802005aa:	00001a97          	auipc	s5,0x1
    802005ae:	882a8a93          	addi	s5,s5,-1918 # 80200e2c <etext+0x4f6>
    802005b2:	00001b97          	auipc	s7,0x1
    802005b6:	a56b8b93          	addi	s7,s7,-1450 # 80201008 <error_string>
    802005ba:	000d4503          	lbu	a0,0(s10)
    802005be:	001d0413          	addi	s0,s10,1
    802005c2:	01350a63          	beq	a0,s3,802005d6 <vprintfmt+0x56>
    802005c6:	c121                	beqz	a0,80200606 <vprintfmt+0x86>
    802005c8:	85a6                	mv	a1,s1
    802005ca:	0405                	addi	s0,s0,1
    802005cc:	9902                	jalr	s2
    802005ce:	fff44503          	lbu	a0,-1(s0)
    802005d2:	ff351ae3          	bne	a0,s3,802005c6 <vprintfmt+0x46>
    802005d6:	00044603          	lbu	a2,0(s0)
    802005da:	02000793          	li	a5,32
    802005de:	4c81                	li	s9,0
    802005e0:	4881                	li	a7,0
    802005e2:	5c7d                	li	s8,-1
    802005e4:	5dfd                	li	s11,-1
    802005e6:	05500513          	li	a0,85
    802005ea:	4825                	li	a6,9
    802005ec:	fdd6059b          	addiw	a1,a2,-35
    802005f0:	0ff5f593          	andi	a1,a1,255
    802005f4:	00140d13          	addi	s10,s0,1
    802005f8:	04b56263          	bltu	a0,a1,8020063c <vprintfmt+0xbc>
    802005fc:	058a                	slli	a1,a1,0x2
    802005fe:	95d6                	add	a1,a1,s5
    80200600:	4194                	lw	a3,0(a1)
    80200602:	96d6                	add	a3,a3,s5
    80200604:	8682                	jr	a3
    80200606:	70e6                	ld	ra,120(sp)
    80200608:	7446                	ld	s0,112(sp)
    8020060a:	74a6                	ld	s1,104(sp)
    8020060c:	7906                	ld	s2,96(sp)
    8020060e:	69e6                	ld	s3,88(sp)
    80200610:	6a46                	ld	s4,80(sp)
    80200612:	6aa6                	ld	s5,72(sp)
    80200614:	6b06                	ld	s6,64(sp)
    80200616:	7be2                	ld	s7,56(sp)
    80200618:	7c42                	ld	s8,48(sp)
    8020061a:	7ca2                	ld	s9,40(sp)
    8020061c:	7d02                	ld	s10,32(sp)
    8020061e:	6de2                	ld	s11,24(sp)
    80200620:	6109                	addi	sp,sp,128
    80200622:	8082                	ret
    80200624:	87b2                	mv	a5,a2
    80200626:	00144603          	lbu	a2,1(s0)
    8020062a:	846a                	mv	s0,s10
    8020062c:	00140d13          	addi	s10,s0,1
    80200630:	fdd6059b          	addiw	a1,a2,-35
    80200634:	0ff5f593          	andi	a1,a1,255
    80200638:	fcb572e3          	bgeu	a0,a1,802005fc <vprintfmt+0x7c>
    8020063c:	85a6                	mv	a1,s1
    8020063e:	02500513          	li	a0,37
    80200642:	9902                	jalr	s2
    80200644:	fff44783          	lbu	a5,-1(s0)
    80200648:	8d22                	mv	s10,s0
    8020064a:	f73788e3          	beq	a5,s3,802005ba <vprintfmt+0x3a>
    8020064e:	ffed4783          	lbu	a5,-2(s10)
    80200652:	1d7d                	addi	s10,s10,-1
    80200654:	ff379de3          	bne	a5,s3,8020064e <vprintfmt+0xce>
    80200658:	b78d                	j	802005ba <vprintfmt+0x3a>
    8020065a:	fd060c1b          	addiw	s8,a2,-48
    8020065e:	00144603          	lbu	a2,1(s0)
    80200662:	846a                	mv	s0,s10
    80200664:	fd06069b          	addiw	a3,a2,-48
    80200668:	0006059b          	sext.w	a1,a2
    8020066c:	02d86463          	bltu	a6,a3,80200694 <vprintfmt+0x114>
    80200670:	00144603          	lbu	a2,1(s0)
    80200674:	002c169b          	slliw	a3,s8,0x2
    80200678:	0186873b          	addw	a4,a3,s8
    8020067c:	0017171b          	slliw	a4,a4,0x1
    80200680:	9f2d                	addw	a4,a4,a1
    80200682:	fd06069b          	addiw	a3,a2,-48
    80200686:	0405                	addi	s0,s0,1
    80200688:	fd070c1b          	addiw	s8,a4,-48
    8020068c:	0006059b          	sext.w	a1,a2
    80200690:	fed870e3          	bgeu	a6,a3,80200670 <vprintfmt+0xf0>
    80200694:	f40ddce3          	bgez	s11,802005ec <vprintfmt+0x6c>
    80200698:	8de2                	mv	s11,s8
    8020069a:	5c7d                	li	s8,-1
    8020069c:	bf81                	j	802005ec <vprintfmt+0x6c>
    8020069e:	fffdc693          	not	a3,s11
    802006a2:	96fd                	srai	a3,a3,0x3f
    802006a4:	00ddfdb3          	and	s11,s11,a3
    802006a8:	00144603          	lbu	a2,1(s0)
    802006ac:	2d81                	sext.w	s11,s11
    802006ae:	846a                	mv	s0,s10
    802006b0:	bf35                	j	802005ec <vprintfmt+0x6c>
    802006b2:	000a2c03          	lw	s8,0(s4)
    802006b6:	00144603          	lbu	a2,1(s0)
    802006ba:	0a21                	addi	s4,s4,8
    802006bc:	846a                	mv	s0,s10
    802006be:	bfd9                	j	80200694 <vprintfmt+0x114>
    802006c0:	4705                	li	a4,1
    802006c2:	008a0593          	addi	a1,s4,8
    802006c6:	01174463          	blt	a4,a7,802006ce <vprintfmt+0x14e>
    802006ca:	1a088e63          	beqz	a7,80200886 <vprintfmt+0x306>
    802006ce:	000a3603          	ld	a2,0(s4)
    802006d2:	46c1                	li	a3,16
    802006d4:	8a2e                	mv	s4,a1
    802006d6:	2781                	sext.w	a5,a5
    802006d8:	876e                	mv	a4,s11
    802006da:	85a6                	mv	a1,s1
    802006dc:	854a                	mv	a0,s2
    802006de:	e37ff0ef          	jal	ra,80200514 <printnum>
    802006e2:	bde1                	j	802005ba <vprintfmt+0x3a>
    802006e4:	000a2503          	lw	a0,0(s4)
    802006e8:	85a6                	mv	a1,s1
    802006ea:	0a21                	addi	s4,s4,8
    802006ec:	9902                	jalr	s2
    802006ee:	b5f1                	j	802005ba <vprintfmt+0x3a>
    802006f0:	4705                	li	a4,1
    802006f2:	008a0593          	addi	a1,s4,8
    802006f6:	01174463          	blt	a4,a7,802006fe <vprintfmt+0x17e>
    802006fa:	18088163          	beqz	a7,8020087c <vprintfmt+0x2fc>
    802006fe:	000a3603          	ld	a2,0(s4)
    80200702:	46a9                	li	a3,10
    80200704:	8a2e                	mv	s4,a1
    80200706:	bfc1                	j	802006d6 <vprintfmt+0x156>
    80200708:	00144603          	lbu	a2,1(s0)
    8020070c:	4c85                	li	s9,1
    8020070e:	846a                	mv	s0,s10
    80200710:	bdf1                	j	802005ec <vprintfmt+0x6c>
    80200712:	85a6                	mv	a1,s1
    80200714:	02500513          	li	a0,37
    80200718:	9902                	jalr	s2
    8020071a:	b545                	j	802005ba <vprintfmt+0x3a>
    8020071c:	00144603          	lbu	a2,1(s0)
    80200720:	2885                	addiw	a7,a7,1
    80200722:	846a                	mv	s0,s10
    80200724:	b5e1                	j	802005ec <vprintfmt+0x6c>
    80200726:	4705                	li	a4,1
    80200728:	008a0593          	addi	a1,s4,8
    8020072c:	01174463          	blt	a4,a7,80200734 <vprintfmt+0x1b4>
    80200730:	14088163          	beqz	a7,80200872 <vprintfmt+0x2f2>
    80200734:	000a3603          	ld	a2,0(s4)
    80200738:	46a1                	li	a3,8
    8020073a:	8a2e                	mv	s4,a1
    8020073c:	bf69                	j	802006d6 <vprintfmt+0x156>
    8020073e:	03000513          	li	a0,48
    80200742:	85a6                	mv	a1,s1
    80200744:	e03e                	sd	a5,0(sp)
    80200746:	9902                	jalr	s2
    80200748:	85a6                	mv	a1,s1
    8020074a:	07800513          	li	a0,120
    8020074e:	9902                	jalr	s2
    80200750:	0a21                	addi	s4,s4,8
    80200752:	6782                	ld	a5,0(sp)
    80200754:	46c1                	li	a3,16
    80200756:	ff8a3603          	ld	a2,-8(s4)
    8020075a:	bfb5                	j	802006d6 <vprintfmt+0x156>
    8020075c:	000a3403          	ld	s0,0(s4)
    80200760:	008a0713          	addi	a4,s4,8
    80200764:	e03a                	sd	a4,0(sp)
    80200766:	14040263          	beqz	s0,802008aa <vprintfmt+0x32a>
    8020076a:	0fb05763          	blez	s11,80200858 <vprintfmt+0x2d8>
    8020076e:	02d00693          	li	a3,45
    80200772:	0cd79163          	bne	a5,a3,80200834 <vprintfmt+0x2b4>
    80200776:	00044783          	lbu	a5,0(s0)
    8020077a:	0007851b          	sext.w	a0,a5
    8020077e:	cf85                	beqz	a5,802007b6 <vprintfmt+0x236>
    80200780:	00140a13          	addi	s4,s0,1
    80200784:	05e00413          	li	s0,94
    80200788:	000c4563          	bltz	s8,80200792 <vprintfmt+0x212>
    8020078c:	3c7d                	addiw	s8,s8,-1
    8020078e:	036c0263          	beq	s8,s6,802007b2 <vprintfmt+0x232>
    80200792:	85a6                	mv	a1,s1
    80200794:	0e0c8e63          	beqz	s9,80200890 <vprintfmt+0x310>
    80200798:	3781                	addiw	a5,a5,-32
    8020079a:	0ef47b63          	bgeu	s0,a5,80200890 <vprintfmt+0x310>
    8020079e:	03f00513          	li	a0,63
    802007a2:	9902                	jalr	s2
    802007a4:	000a4783          	lbu	a5,0(s4)
    802007a8:	3dfd                	addiw	s11,s11,-1
    802007aa:	0a05                	addi	s4,s4,1
    802007ac:	0007851b          	sext.w	a0,a5
    802007b0:	ffe1                	bnez	a5,80200788 <vprintfmt+0x208>
    802007b2:	01b05963          	blez	s11,802007c4 <vprintfmt+0x244>
    802007b6:	3dfd                	addiw	s11,s11,-1
    802007b8:	85a6                	mv	a1,s1
    802007ba:	02000513          	li	a0,32
    802007be:	9902                	jalr	s2
    802007c0:	fe0d9be3          	bnez	s11,802007b6 <vprintfmt+0x236>
    802007c4:	6a02                	ld	s4,0(sp)
    802007c6:	bbd5                	j	802005ba <vprintfmt+0x3a>
    802007c8:	4705                	li	a4,1
    802007ca:	008a0c93          	addi	s9,s4,8
    802007ce:	01174463          	blt	a4,a7,802007d6 <vprintfmt+0x256>
    802007d2:	08088d63          	beqz	a7,8020086c <vprintfmt+0x2ec>
    802007d6:	000a3403          	ld	s0,0(s4)
    802007da:	0a044d63          	bltz	s0,80200894 <vprintfmt+0x314>
    802007de:	8622                	mv	a2,s0
    802007e0:	8a66                	mv	s4,s9
    802007e2:	46a9                	li	a3,10
    802007e4:	bdcd                	j	802006d6 <vprintfmt+0x156>
    802007e6:	000a2783          	lw	a5,0(s4)
    802007ea:	4719                	li	a4,6
    802007ec:	0a21                	addi	s4,s4,8
    802007ee:	41f7d69b          	sraiw	a3,a5,0x1f
    802007f2:	8fb5                	xor	a5,a5,a3
    802007f4:	40d786bb          	subw	a3,a5,a3
    802007f8:	02d74163          	blt	a4,a3,8020081a <vprintfmt+0x29a>
    802007fc:	00369793          	slli	a5,a3,0x3
    80200800:	97de                	add	a5,a5,s7
    80200802:	639c                	ld	a5,0(a5)
    80200804:	cb99                	beqz	a5,8020081a <vprintfmt+0x29a>
    80200806:	86be                	mv	a3,a5
    80200808:	00000617          	auipc	a2,0x0
    8020080c:	62060613          	addi	a2,a2,1568 # 80200e28 <etext+0x4f2>
    80200810:	85a6                	mv	a1,s1
    80200812:	854a                	mv	a0,s2
    80200814:	0ce000ef          	jal	ra,802008e2 <printfmt>
    80200818:	b34d                	j	802005ba <vprintfmt+0x3a>
    8020081a:	00000617          	auipc	a2,0x0
    8020081e:	5fe60613          	addi	a2,a2,1534 # 80200e18 <etext+0x4e2>
    80200822:	85a6                	mv	a1,s1
    80200824:	854a                	mv	a0,s2
    80200826:	0bc000ef          	jal	ra,802008e2 <printfmt>
    8020082a:	bb41                	j	802005ba <vprintfmt+0x3a>
    8020082c:	00000417          	auipc	s0,0x0
    80200830:	5e440413          	addi	s0,s0,1508 # 80200e10 <etext+0x4da>
    80200834:	85e2                	mv	a1,s8
    80200836:	8522                	mv	a0,s0
    80200838:	e43e                	sd	a5,8(sp)
    8020083a:	cadff0ef          	jal	ra,802004e6 <strnlen>
    8020083e:	40ad8dbb          	subw	s11,s11,a0
    80200842:	01b05b63          	blez	s11,80200858 <vprintfmt+0x2d8>
    80200846:	67a2                	ld	a5,8(sp)
    80200848:	00078a1b          	sext.w	s4,a5
    8020084c:	3dfd                	addiw	s11,s11,-1
    8020084e:	85a6                	mv	a1,s1
    80200850:	8552                	mv	a0,s4
    80200852:	9902                	jalr	s2
    80200854:	fe0d9ce3          	bnez	s11,8020084c <vprintfmt+0x2cc>
    80200858:	00044783          	lbu	a5,0(s0)
    8020085c:	00140a13          	addi	s4,s0,1
    80200860:	0007851b          	sext.w	a0,a5
    80200864:	d3a5                	beqz	a5,802007c4 <vprintfmt+0x244>
    80200866:	05e00413          	li	s0,94
    8020086a:	bf39                	j	80200788 <vprintfmt+0x208>
    8020086c:	000a2403          	lw	s0,0(s4)
    80200870:	b7ad                	j	802007da <vprintfmt+0x25a>
    80200872:	000a6603          	lwu	a2,0(s4)
    80200876:	46a1                	li	a3,8
    80200878:	8a2e                	mv	s4,a1
    8020087a:	bdb1                	j	802006d6 <vprintfmt+0x156>
    8020087c:	000a6603          	lwu	a2,0(s4)
    80200880:	46a9                	li	a3,10
    80200882:	8a2e                	mv	s4,a1
    80200884:	bd89                	j	802006d6 <vprintfmt+0x156>
    80200886:	000a6603          	lwu	a2,0(s4)
    8020088a:	46c1                	li	a3,16
    8020088c:	8a2e                	mv	s4,a1
    8020088e:	b5a1                	j	802006d6 <vprintfmt+0x156>
    80200890:	9902                	jalr	s2
    80200892:	bf09                	j	802007a4 <vprintfmt+0x224>
    80200894:	85a6                	mv	a1,s1
    80200896:	02d00513          	li	a0,45
    8020089a:	e03e                	sd	a5,0(sp)
    8020089c:	9902                	jalr	s2
    8020089e:	6782                	ld	a5,0(sp)
    802008a0:	8a66                	mv	s4,s9
    802008a2:	40800633          	neg	a2,s0
    802008a6:	46a9                	li	a3,10
    802008a8:	b53d                	j	802006d6 <vprintfmt+0x156>
    802008aa:	03b05163          	blez	s11,802008cc <vprintfmt+0x34c>
    802008ae:	02d00693          	li	a3,45
    802008b2:	f6d79de3          	bne	a5,a3,8020082c <vprintfmt+0x2ac>
    802008b6:	00000417          	auipc	s0,0x0
    802008ba:	55a40413          	addi	s0,s0,1370 # 80200e10 <etext+0x4da>
    802008be:	02800793          	li	a5,40
    802008c2:	02800513          	li	a0,40
    802008c6:	00140a13          	addi	s4,s0,1
    802008ca:	bd6d                	j	80200784 <vprintfmt+0x204>
    802008cc:	00000a17          	auipc	s4,0x0
    802008d0:	545a0a13          	addi	s4,s4,1349 # 80200e11 <etext+0x4db>
    802008d4:	02800513          	li	a0,40
    802008d8:	02800793          	li	a5,40
    802008dc:	05e00413          	li	s0,94
    802008e0:	b565                	j	80200788 <vprintfmt+0x208>

00000000802008e2 <printfmt>:
    802008e2:	715d                	addi	sp,sp,-80
    802008e4:	02810313          	addi	t1,sp,40
    802008e8:	f436                	sd	a3,40(sp)
    802008ea:	869a                	mv	a3,t1
    802008ec:	ec06                	sd	ra,24(sp)
    802008ee:	f83a                	sd	a4,48(sp)
    802008f0:	fc3e                	sd	a5,56(sp)
    802008f2:	e0c2                	sd	a6,64(sp)
    802008f4:	e4c6                	sd	a7,72(sp)
    802008f6:	e41a                	sd	t1,8(sp)
    802008f8:	c89ff0ef          	jal	ra,80200580 <vprintfmt>
    802008fc:	60e2                	ld	ra,24(sp)
    802008fe:	6161                	addi	sp,sp,80
    80200900:	8082                	ret

0000000080200902 <sbi_console_putchar>:
    80200902:	4781                	li	a5,0
    80200904:	00003717          	auipc	a4,0x3
    80200908:	6fc73703          	ld	a4,1788(a4) # 80204000 <SBI_CONSOLE_PUTCHAR>
    8020090c:	88ba                	mv	a7,a4
    8020090e:	852a                	mv	a0,a0
    80200910:	85be                	mv	a1,a5
    80200912:	863e                	mv	a2,a5
    80200914:	00000073          	ecall
    80200918:	87aa                	mv	a5,a0
    8020091a:	8082                	ret

000000008020091c <sbi_set_timer>:
    8020091c:	4781                	li	a5,0
    8020091e:	00003717          	auipc	a4,0x3
    80200922:	6ea73703          	ld	a4,1770(a4) # 80204008 <SBI_SET_TIMER>
    80200926:	88ba                	mv	a7,a4
    80200928:	852a                	mv	a0,a0
    8020092a:	85be                	mv	a1,a5
    8020092c:	863e                	mv	a2,a5
    8020092e:	00000073          	ecall
    80200932:	87aa                	mv	a5,a0
    80200934:	8082                	ret

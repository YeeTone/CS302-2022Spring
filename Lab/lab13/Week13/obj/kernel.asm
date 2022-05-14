
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	c020d2b7          	lui	t0,0xc020d
ffffffffc0200004:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200008:	037a                	slli	t1,t1,0x1e
ffffffffc020000a:	406282b3          	sub	t0,t0,t1
ffffffffc020000e:	00c2d293          	srli	t0,t0,0xc
ffffffffc0200012:	fff0031b          	addiw	t1,zero,-1
ffffffffc0200016:	137e                	slli	t1,t1,0x3f
ffffffffc0200018:	0062e2b3          	or	t0,t0,t1
ffffffffc020001c:	18029073          	csrw	satp,t0
ffffffffc0200020:	12000073          	sfence.vma
ffffffffc0200024:	c020d137          	lui	sp,0xc020d
ffffffffc0200028:	c02002b7          	lui	t0,0xc0200
ffffffffc020002c:	03228293          	addi	t0,t0,50 # ffffffffc0200032 <kern_init>
ffffffffc0200030:	8282                	jr	t0

ffffffffc0200032 <kern_init>:
ffffffffc0200032:	0000e517          	auipc	a0,0xe
ffffffffc0200036:	05e50513          	addi	a0,a0,94 # ffffffffc020e090 <buf>
ffffffffc020003a:	00019617          	auipc	a2,0x19
ffffffffc020003e:	70e60613          	addi	a2,a2,1806 # ffffffffc0219748 <end>
ffffffffc0200042:	1141                	addi	sp,sp,-16
ffffffffc0200044:	8e09                	sub	a2,a2,a0
ffffffffc0200046:	4581                	li	a1,0
ffffffffc0200048:	e406                	sd	ra,8(sp)
ffffffffc020004a:	2dd070ef          	jal	ra,ffffffffc0207b26 <memset>
ffffffffc020004e:	570000ef          	jal	ra,ffffffffc02005be <cons_init>
ffffffffc0200052:	00008597          	auipc	a1,0x8
ffffffffc0200056:	f0658593          	addi	a1,a1,-250 # ffffffffc0207f58 <etext+0x4>
ffffffffc020005a:	00008517          	auipc	a0,0x8
ffffffffc020005e:	f1650513          	addi	a0,a0,-234 # ffffffffc0207f70 <etext+0x1c>
ffffffffc0200062:	06a000ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200066:	788020ef          	jal	ra,ffffffffc02027ee <pmm_init>
ffffffffc020006a:	5c6000ef          	jal	ra,ffffffffc0200630 <pic_init>
ffffffffc020006e:	5d0000ef          	jal	ra,ffffffffc020063e <idt_init>
ffffffffc0200072:	050010ef          	jal	ra,ffffffffc02010c2 <vmm_init>
ffffffffc0200076:	127040ef          	jal	ra,ffffffffc020499c <sched_init>
ffffffffc020007a:	714040ef          	jal	ra,ffffffffc020478e <proc_init>
ffffffffc020007e:	4a2000ef          	jal	ra,ffffffffc0200520 <ide_init>
ffffffffc0200082:	16d010ef          	jal	ra,ffffffffc02019ee <swap_init>
ffffffffc0200086:	4f0000ef          	jal	ra,ffffffffc0200576 <clock_init>
ffffffffc020008a:	5a8000ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020008e:	037040ef          	jal	ra,ffffffffc02048c4 <cpu_idle>

ffffffffc0200092 <cputch>:
ffffffffc0200092:	1141                	addi	sp,sp,-16
ffffffffc0200094:	e022                	sd	s0,0(sp)
ffffffffc0200096:	e406                	sd	ra,8(sp)
ffffffffc0200098:	842e                	mv	s0,a1
ffffffffc020009a:	526000ef          	jal	ra,ffffffffc02005c0 <cons_putc>
ffffffffc020009e:	401c                	lw	a5,0(s0)
ffffffffc02000a0:	60a2                	ld	ra,8(sp)
ffffffffc02000a2:	2785                	addiw	a5,a5,1
ffffffffc02000a4:	c01c                	sw	a5,0(s0)
ffffffffc02000a6:	6402                	ld	s0,0(sp)
ffffffffc02000a8:	0141                	addi	sp,sp,16
ffffffffc02000aa:	8082                	ret

ffffffffc02000ac <vcprintf>:
ffffffffc02000ac:	1101                	addi	sp,sp,-32
ffffffffc02000ae:	862a                	mv	a2,a0
ffffffffc02000b0:	86ae                	mv	a3,a1
ffffffffc02000b2:	00000517          	auipc	a0,0x0
ffffffffc02000b6:	fe050513          	addi	a0,a0,-32 # ffffffffc0200092 <cputch>
ffffffffc02000ba:	006c                	addi	a1,sp,12
ffffffffc02000bc:	ec06                	sd	ra,24(sp)
ffffffffc02000be:	c602                	sw	zero,12(sp)
ffffffffc02000c0:	2fd070ef          	jal	ra,ffffffffc0207bbc <vprintfmt>
ffffffffc02000c4:	60e2                	ld	ra,24(sp)
ffffffffc02000c6:	4532                	lw	a0,12(sp)
ffffffffc02000c8:	6105                	addi	sp,sp,32
ffffffffc02000ca:	8082                	ret

ffffffffc02000cc <cprintf>:
ffffffffc02000cc:	711d                	addi	sp,sp,-96
ffffffffc02000ce:	02810313          	addi	t1,sp,40 # ffffffffc020d028 <boot_page_table_sv39+0x28>
ffffffffc02000d2:	8e2a                	mv	t3,a0
ffffffffc02000d4:	f42e                	sd	a1,40(sp)
ffffffffc02000d6:	f832                	sd	a2,48(sp)
ffffffffc02000d8:	fc36                	sd	a3,56(sp)
ffffffffc02000da:	00000517          	auipc	a0,0x0
ffffffffc02000de:	fb850513          	addi	a0,a0,-72 # ffffffffc0200092 <cputch>
ffffffffc02000e2:	004c                	addi	a1,sp,4
ffffffffc02000e4:	869a                	mv	a3,t1
ffffffffc02000e6:	8672                	mv	a2,t3
ffffffffc02000e8:	ec06                	sd	ra,24(sp)
ffffffffc02000ea:	e0ba                	sd	a4,64(sp)
ffffffffc02000ec:	e4be                	sd	a5,72(sp)
ffffffffc02000ee:	e8c2                	sd	a6,80(sp)
ffffffffc02000f0:	ecc6                	sd	a7,88(sp)
ffffffffc02000f2:	e41a                	sd	t1,8(sp)
ffffffffc02000f4:	c202                	sw	zero,4(sp)
ffffffffc02000f6:	2c7070ef          	jal	ra,ffffffffc0207bbc <vprintfmt>
ffffffffc02000fa:	60e2                	ld	ra,24(sp)
ffffffffc02000fc:	4512                	lw	a0,4(sp)
ffffffffc02000fe:	6125                	addi	sp,sp,96
ffffffffc0200100:	8082                	ret

ffffffffc0200102 <cputchar>:
ffffffffc0200102:	a97d                	j	ffffffffc02005c0 <cons_putc>

ffffffffc0200104 <cputs>:
ffffffffc0200104:	1101                	addi	sp,sp,-32
ffffffffc0200106:	e822                	sd	s0,16(sp)
ffffffffc0200108:	ec06                	sd	ra,24(sp)
ffffffffc020010a:	e426                	sd	s1,8(sp)
ffffffffc020010c:	842a                	mv	s0,a0
ffffffffc020010e:	00054503          	lbu	a0,0(a0)
ffffffffc0200112:	c51d                	beqz	a0,ffffffffc0200140 <cputs+0x3c>
ffffffffc0200114:	0405                	addi	s0,s0,1
ffffffffc0200116:	4485                	li	s1,1
ffffffffc0200118:	9c81                	subw	s1,s1,s0
ffffffffc020011a:	4a6000ef          	jal	ra,ffffffffc02005c0 <cons_putc>
ffffffffc020011e:	00044503          	lbu	a0,0(s0)
ffffffffc0200122:	008487bb          	addw	a5,s1,s0
ffffffffc0200126:	0405                	addi	s0,s0,1
ffffffffc0200128:	f96d                	bnez	a0,ffffffffc020011a <cputs+0x16>
ffffffffc020012a:	0017841b          	addiw	s0,a5,1
ffffffffc020012e:	4529                	li	a0,10
ffffffffc0200130:	490000ef          	jal	ra,ffffffffc02005c0 <cons_putc>
ffffffffc0200134:	60e2                	ld	ra,24(sp)
ffffffffc0200136:	8522                	mv	a0,s0
ffffffffc0200138:	6442                	ld	s0,16(sp)
ffffffffc020013a:	64a2                	ld	s1,8(sp)
ffffffffc020013c:	6105                	addi	sp,sp,32
ffffffffc020013e:	8082                	ret
ffffffffc0200140:	4405                	li	s0,1
ffffffffc0200142:	b7f5                	j	ffffffffc020012e <cputs+0x2a>

ffffffffc0200144 <getchar>:
ffffffffc0200144:	1141                	addi	sp,sp,-16
ffffffffc0200146:	e406                	sd	ra,8(sp)
ffffffffc0200148:	4ac000ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc020014c:	dd75                	beqz	a0,ffffffffc0200148 <getchar+0x4>
ffffffffc020014e:	60a2                	ld	ra,8(sp)
ffffffffc0200150:	0141                	addi	sp,sp,16
ffffffffc0200152:	8082                	ret

ffffffffc0200154 <readline>:
ffffffffc0200154:	715d                	addi	sp,sp,-80
ffffffffc0200156:	e486                	sd	ra,72(sp)
ffffffffc0200158:	e0a6                	sd	s1,64(sp)
ffffffffc020015a:	fc4a                	sd	s2,56(sp)
ffffffffc020015c:	f84e                	sd	s3,48(sp)
ffffffffc020015e:	f452                	sd	s4,40(sp)
ffffffffc0200160:	f056                	sd	s5,32(sp)
ffffffffc0200162:	ec5a                	sd	s6,24(sp)
ffffffffc0200164:	e85e                	sd	s7,16(sp)
ffffffffc0200166:	c901                	beqz	a0,ffffffffc0200176 <readline+0x22>
ffffffffc0200168:	85aa                	mv	a1,a0
ffffffffc020016a:	00008517          	auipc	a0,0x8
ffffffffc020016e:	e0e50513          	addi	a0,a0,-498 # ffffffffc0207f78 <etext+0x24>
ffffffffc0200172:	f5bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200176:	4481                	li	s1,0
ffffffffc0200178:	497d                	li	s2,31
ffffffffc020017a:	49a1                	li	s3,8
ffffffffc020017c:	4aa9                	li	s5,10
ffffffffc020017e:	4b35                	li	s6,13
ffffffffc0200180:	0000eb97          	auipc	s7,0xe
ffffffffc0200184:	f10b8b93          	addi	s7,s7,-240 # ffffffffc020e090 <buf>
ffffffffc0200188:	3fe00a13          	li	s4,1022
ffffffffc020018c:	fb9ff0ef          	jal	ra,ffffffffc0200144 <getchar>
ffffffffc0200190:	00054a63          	bltz	a0,ffffffffc02001a4 <readline+0x50>
ffffffffc0200194:	00a95a63          	bge	s2,a0,ffffffffc02001a8 <readline+0x54>
ffffffffc0200198:	029a5263          	bge	s4,s1,ffffffffc02001bc <readline+0x68>
ffffffffc020019c:	fa9ff0ef          	jal	ra,ffffffffc0200144 <getchar>
ffffffffc02001a0:	fe055ae3          	bgez	a0,ffffffffc0200194 <readline+0x40>
ffffffffc02001a4:	4501                	li	a0,0
ffffffffc02001a6:	a091                	j	ffffffffc02001ea <readline+0x96>
ffffffffc02001a8:	03351463          	bne	a0,s3,ffffffffc02001d0 <readline+0x7c>
ffffffffc02001ac:	e8a9                	bnez	s1,ffffffffc02001fe <readline+0xaa>
ffffffffc02001ae:	f97ff0ef          	jal	ra,ffffffffc0200144 <getchar>
ffffffffc02001b2:	fe0549e3          	bltz	a0,ffffffffc02001a4 <readline+0x50>
ffffffffc02001b6:	fea959e3          	bge	s2,a0,ffffffffc02001a8 <readline+0x54>
ffffffffc02001ba:	4481                	li	s1,0
ffffffffc02001bc:	e42a                	sd	a0,8(sp)
ffffffffc02001be:	f45ff0ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc02001c2:	6522                	ld	a0,8(sp)
ffffffffc02001c4:	009b87b3          	add	a5,s7,s1
ffffffffc02001c8:	2485                	addiw	s1,s1,1
ffffffffc02001ca:	00a78023          	sb	a0,0(a5)
ffffffffc02001ce:	bf7d                	j	ffffffffc020018c <readline+0x38>
ffffffffc02001d0:	01550463          	beq	a0,s5,ffffffffc02001d8 <readline+0x84>
ffffffffc02001d4:	fb651ce3          	bne	a0,s6,ffffffffc020018c <readline+0x38>
ffffffffc02001d8:	f2bff0ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc02001dc:	0000e517          	auipc	a0,0xe
ffffffffc02001e0:	eb450513          	addi	a0,a0,-332 # ffffffffc020e090 <buf>
ffffffffc02001e4:	94aa                	add	s1,s1,a0
ffffffffc02001e6:	00048023          	sb	zero,0(s1)
ffffffffc02001ea:	60a6                	ld	ra,72(sp)
ffffffffc02001ec:	6486                	ld	s1,64(sp)
ffffffffc02001ee:	7962                	ld	s2,56(sp)
ffffffffc02001f0:	79c2                	ld	s3,48(sp)
ffffffffc02001f2:	7a22                	ld	s4,40(sp)
ffffffffc02001f4:	7a82                	ld	s5,32(sp)
ffffffffc02001f6:	6b62                	ld	s6,24(sp)
ffffffffc02001f8:	6bc2                	ld	s7,16(sp)
ffffffffc02001fa:	6161                	addi	sp,sp,80
ffffffffc02001fc:	8082                	ret
ffffffffc02001fe:	4521                	li	a0,8
ffffffffc0200200:	f03ff0ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc0200204:	34fd                	addiw	s1,s1,-1
ffffffffc0200206:	b759                	j	ffffffffc020018c <readline+0x38>

ffffffffc0200208 <__panic>:
ffffffffc0200208:	00019317          	auipc	t1,0x19
ffffffffc020020c:	2b830313          	addi	t1,t1,696 # ffffffffc02194c0 <is_panic>
ffffffffc0200210:	00033e03          	ld	t3,0(t1)
ffffffffc0200214:	715d                	addi	sp,sp,-80
ffffffffc0200216:	ec06                	sd	ra,24(sp)
ffffffffc0200218:	e822                	sd	s0,16(sp)
ffffffffc020021a:	f436                	sd	a3,40(sp)
ffffffffc020021c:	f83a                	sd	a4,48(sp)
ffffffffc020021e:	fc3e                	sd	a5,56(sp)
ffffffffc0200220:	e0c2                	sd	a6,64(sp)
ffffffffc0200222:	e4c6                	sd	a7,72(sp)
ffffffffc0200224:	020e1a63          	bnez	t3,ffffffffc0200258 <__panic+0x50>
ffffffffc0200228:	4785                	li	a5,1
ffffffffc020022a:	00f33023          	sd	a5,0(t1)
ffffffffc020022e:	8432                	mv	s0,a2
ffffffffc0200230:	103c                	addi	a5,sp,40
ffffffffc0200232:	862e                	mv	a2,a1
ffffffffc0200234:	85aa                	mv	a1,a0
ffffffffc0200236:	00008517          	auipc	a0,0x8
ffffffffc020023a:	d4a50513          	addi	a0,a0,-694 # ffffffffc0207f80 <etext+0x2c>
ffffffffc020023e:	e43e                	sd	a5,8(sp)
ffffffffc0200240:	e8dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200244:	65a2                	ld	a1,8(sp)
ffffffffc0200246:	8522                	mv	a0,s0
ffffffffc0200248:	e65ff0ef          	jal	ra,ffffffffc02000ac <vcprintf>
ffffffffc020024c:	00009517          	auipc	a0,0x9
ffffffffc0200250:	20450513          	addi	a0,a0,516 # ffffffffc0209450 <default_pmm_manager+0x228>
ffffffffc0200254:	e79ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200258:	4501                	li	a0,0
ffffffffc020025a:	4581                	li	a1,0
ffffffffc020025c:	4601                	li	a2,0
ffffffffc020025e:	48a1                	li	a7,8
ffffffffc0200260:	00000073          	ecall
ffffffffc0200264:	3d4000ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0200268:	4501                	li	a0,0
ffffffffc020026a:	174000ef          	jal	ra,ffffffffc02003de <kmonitor>
ffffffffc020026e:	bfed                	j	ffffffffc0200268 <__panic+0x60>

ffffffffc0200270 <__warn>:
ffffffffc0200270:	715d                	addi	sp,sp,-80
ffffffffc0200272:	832e                	mv	t1,a1
ffffffffc0200274:	e822                	sd	s0,16(sp)
ffffffffc0200276:	85aa                	mv	a1,a0
ffffffffc0200278:	8432                	mv	s0,a2
ffffffffc020027a:	fc3e                	sd	a5,56(sp)
ffffffffc020027c:	861a                	mv	a2,t1
ffffffffc020027e:	103c                	addi	a5,sp,40
ffffffffc0200280:	00008517          	auipc	a0,0x8
ffffffffc0200284:	d2050513          	addi	a0,a0,-736 # ffffffffc0207fa0 <etext+0x4c>
ffffffffc0200288:	ec06                	sd	ra,24(sp)
ffffffffc020028a:	f436                	sd	a3,40(sp)
ffffffffc020028c:	f83a                	sd	a4,48(sp)
ffffffffc020028e:	e0c2                	sd	a6,64(sp)
ffffffffc0200290:	e4c6                	sd	a7,72(sp)
ffffffffc0200292:	e43e                	sd	a5,8(sp)
ffffffffc0200294:	e39ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200298:	65a2                	ld	a1,8(sp)
ffffffffc020029a:	8522                	mv	a0,s0
ffffffffc020029c:	e11ff0ef          	jal	ra,ffffffffc02000ac <vcprintf>
ffffffffc02002a0:	00009517          	auipc	a0,0x9
ffffffffc02002a4:	1b050513          	addi	a0,a0,432 # ffffffffc0209450 <default_pmm_manager+0x228>
ffffffffc02002a8:	e25ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002ac:	60e2                	ld	ra,24(sp)
ffffffffc02002ae:	6442                	ld	s0,16(sp)
ffffffffc02002b0:	6161                	addi	sp,sp,80
ffffffffc02002b2:	8082                	ret

ffffffffc02002b4 <print_kerninfo>:
ffffffffc02002b4:	1141                	addi	sp,sp,-16
ffffffffc02002b6:	00008517          	auipc	a0,0x8
ffffffffc02002ba:	d0a50513          	addi	a0,a0,-758 # ffffffffc0207fc0 <etext+0x6c>
ffffffffc02002be:	e406                	sd	ra,8(sp)
ffffffffc02002c0:	e0dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002c4:	00000597          	auipc	a1,0x0
ffffffffc02002c8:	d6e58593          	addi	a1,a1,-658 # ffffffffc0200032 <kern_init>
ffffffffc02002cc:	00008517          	auipc	a0,0x8
ffffffffc02002d0:	d1450513          	addi	a0,a0,-748 # ffffffffc0207fe0 <etext+0x8c>
ffffffffc02002d4:	df9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002d8:	00008597          	auipc	a1,0x8
ffffffffc02002dc:	c7c58593          	addi	a1,a1,-900 # ffffffffc0207f54 <etext>
ffffffffc02002e0:	00008517          	auipc	a0,0x8
ffffffffc02002e4:	d2050513          	addi	a0,a0,-736 # ffffffffc0208000 <etext+0xac>
ffffffffc02002e8:	de5ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002ec:	0000e597          	auipc	a1,0xe
ffffffffc02002f0:	da458593          	addi	a1,a1,-604 # ffffffffc020e090 <buf>
ffffffffc02002f4:	00008517          	auipc	a0,0x8
ffffffffc02002f8:	d2c50513          	addi	a0,a0,-724 # ffffffffc0208020 <etext+0xcc>
ffffffffc02002fc:	dd1ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200300:	00019597          	auipc	a1,0x19
ffffffffc0200304:	44858593          	addi	a1,a1,1096 # ffffffffc0219748 <end>
ffffffffc0200308:	00008517          	auipc	a0,0x8
ffffffffc020030c:	d3850513          	addi	a0,a0,-712 # ffffffffc0208040 <etext+0xec>
ffffffffc0200310:	dbdff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200314:	0001a597          	auipc	a1,0x1a
ffffffffc0200318:	83358593          	addi	a1,a1,-1997 # ffffffffc0219b47 <end+0x3ff>
ffffffffc020031c:	00000797          	auipc	a5,0x0
ffffffffc0200320:	d1678793          	addi	a5,a5,-746 # ffffffffc0200032 <kern_init>
ffffffffc0200324:	40f587b3          	sub	a5,a1,a5
ffffffffc0200328:	43f7d593          	srai	a1,a5,0x3f
ffffffffc020032c:	60a2                	ld	ra,8(sp)
ffffffffc020032e:	3ff5f593          	andi	a1,a1,1023
ffffffffc0200332:	95be                	add	a1,a1,a5
ffffffffc0200334:	85a9                	srai	a1,a1,0xa
ffffffffc0200336:	00008517          	auipc	a0,0x8
ffffffffc020033a:	d2a50513          	addi	a0,a0,-726 # ffffffffc0208060 <etext+0x10c>
ffffffffc020033e:	0141                	addi	sp,sp,16
ffffffffc0200340:	b371                	j	ffffffffc02000cc <cprintf>

ffffffffc0200342 <print_stackframe>:
ffffffffc0200342:	1141                	addi	sp,sp,-16
ffffffffc0200344:	00008617          	auipc	a2,0x8
ffffffffc0200348:	d4c60613          	addi	a2,a2,-692 # ffffffffc0208090 <etext+0x13c>
ffffffffc020034c:	05b00593          	li	a1,91
ffffffffc0200350:	00008517          	auipc	a0,0x8
ffffffffc0200354:	d5850513          	addi	a0,a0,-680 # ffffffffc02080a8 <etext+0x154>
ffffffffc0200358:	e406                	sd	ra,8(sp)
ffffffffc020035a:	eafff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020035e <mon_help>:
ffffffffc020035e:	1141                	addi	sp,sp,-16
ffffffffc0200360:	00008617          	auipc	a2,0x8
ffffffffc0200364:	d6060613          	addi	a2,a2,-672 # ffffffffc02080c0 <etext+0x16c>
ffffffffc0200368:	00008597          	auipc	a1,0x8
ffffffffc020036c:	d7858593          	addi	a1,a1,-648 # ffffffffc02080e0 <etext+0x18c>
ffffffffc0200370:	00008517          	auipc	a0,0x8
ffffffffc0200374:	d7850513          	addi	a0,a0,-648 # ffffffffc02080e8 <etext+0x194>
ffffffffc0200378:	e406                	sd	ra,8(sp)
ffffffffc020037a:	d53ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020037e:	00008617          	auipc	a2,0x8
ffffffffc0200382:	d7a60613          	addi	a2,a2,-646 # ffffffffc02080f8 <etext+0x1a4>
ffffffffc0200386:	00008597          	auipc	a1,0x8
ffffffffc020038a:	d9a58593          	addi	a1,a1,-614 # ffffffffc0208120 <etext+0x1cc>
ffffffffc020038e:	00008517          	auipc	a0,0x8
ffffffffc0200392:	d5a50513          	addi	a0,a0,-678 # ffffffffc02080e8 <etext+0x194>
ffffffffc0200396:	d37ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020039a:	00008617          	auipc	a2,0x8
ffffffffc020039e:	d9660613          	addi	a2,a2,-618 # ffffffffc0208130 <etext+0x1dc>
ffffffffc02003a2:	00008597          	auipc	a1,0x8
ffffffffc02003a6:	dae58593          	addi	a1,a1,-594 # ffffffffc0208150 <etext+0x1fc>
ffffffffc02003aa:	00008517          	auipc	a0,0x8
ffffffffc02003ae:	d3e50513          	addi	a0,a0,-706 # ffffffffc02080e8 <etext+0x194>
ffffffffc02003b2:	d1bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02003b6:	60a2                	ld	ra,8(sp)
ffffffffc02003b8:	4501                	li	a0,0
ffffffffc02003ba:	0141                	addi	sp,sp,16
ffffffffc02003bc:	8082                	ret

ffffffffc02003be <mon_kerninfo>:
ffffffffc02003be:	1141                	addi	sp,sp,-16
ffffffffc02003c0:	e406                	sd	ra,8(sp)
ffffffffc02003c2:	ef3ff0ef          	jal	ra,ffffffffc02002b4 <print_kerninfo>
ffffffffc02003c6:	60a2                	ld	ra,8(sp)
ffffffffc02003c8:	4501                	li	a0,0
ffffffffc02003ca:	0141                	addi	sp,sp,16
ffffffffc02003cc:	8082                	ret

ffffffffc02003ce <mon_backtrace>:
ffffffffc02003ce:	1141                	addi	sp,sp,-16
ffffffffc02003d0:	e406                	sd	ra,8(sp)
ffffffffc02003d2:	f71ff0ef          	jal	ra,ffffffffc0200342 <print_stackframe>
ffffffffc02003d6:	60a2                	ld	ra,8(sp)
ffffffffc02003d8:	4501                	li	a0,0
ffffffffc02003da:	0141                	addi	sp,sp,16
ffffffffc02003dc:	8082                	ret

ffffffffc02003de <kmonitor>:
ffffffffc02003de:	7115                	addi	sp,sp,-224
ffffffffc02003e0:	e962                	sd	s8,144(sp)
ffffffffc02003e2:	8c2a                	mv	s8,a0
ffffffffc02003e4:	00008517          	auipc	a0,0x8
ffffffffc02003e8:	d7c50513          	addi	a0,a0,-644 # ffffffffc0208160 <etext+0x20c>
ffffffffc02003ec:	ed86                	sd	ra,216(sp)
ffffffffc02003ee:	e9a2                	sd	s0,208(sp)
ffffffffc02003f0:	e5a6                	sd	s1,200(sp)
ffffffffc02003f2:	e1ca                	sd	s2,192(sp)
ffffffffc02003f4:	fd4e                	sd	s3,184(sp)
ffffffffc02003f6:	f952                	sd	s4,176(sp)
ffffffffc02003f8:	f556                	sd	s5,168(sp)
ffffffffc02003fa:	f15a                	sd	s6,160(sp)
ffffffffc02003fc:	ed5e                	sd	s7,152(sp)
ffffffffc02003fe:	e566                	sd	s9,136(sp)
ffffffffc0200400:	e16a                	sd	s10,128(sp)
ffffffffc0200402:	ccbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200406:	00008517          	auipc	a0,0x8
ffffffffc020040a:	d8250513          	addi	a0,a0,-638 # ffffffffc0208188 <etext+0x234>
ffffffffc020040e:	cbfff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200412:	000c0563          	beqz	s8,ffffffffc020041c <kmonitor+0x3e>
ffffffffc0200416:	8562                	mv	a0,s8
ffffffffc0200418:	40e000ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc020041c:	00008c97          	auipc	s9,0x8
ffffffffc0200420:	ddcc8c93          	addi	s9,s9,-548 # ffffffffc02081f8 <commands>
ffffffffc0200424:	00008997          	auipc	s3,0x8
ffffffffc0200428:	d8c98993          	addi	s3,s3,-628 # ffffffffc02081b0 <etext+0x25c>
ffffffffc020042c:	00008917          	auipc	s2,0x8
ffffffffc0200430:	d8c90913          	addi	s2,s2,-628 # ffffffffc02081b8 <etext+0x264>
ffffffffc0200434:	4a3d                	li	s4,15
ffffffffc0200436:	00008b17          	auipc	s6,0x8
ffffffffc020043a:	d8ab0b13          	addi	s6,s6,-630 # ffffffffc02081c0 <etext+0x26c>
ffffffffc020043e:	00008a97          	auipc	s5,0x8
ffffffffc0200442:	ca2a8a93          	addi	s5,s5,-862 # ffffffffc02080e0 <etext+0x18c>
ffffffffc0200446:	4b8d                	li	s7,3
ffffffffc0200448:	854e                	mv	a0,s3
ffffffffc020044a:	d0bff0ef          	jal	ra,ffffffffc0200154 <readline>
ffffffffc020044e:	842a                	mv	s0,a0
ffffffffc0200450:	dd65                	beqz	a0,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc0200452:	00054583          	lbu	a1,0(a0)
ffffffffc0200456:	4481                	li	s1,0
ffffffffc0200458:	c999                	beqz	a1,ffffffffc020046e <kmonitor+0x90>
ffffffffc020045a:	854a                	mv	a0,s2
ffffffffc020045c:	6b4070ef          	jal	ra,ffffffffc0207b10 <strchr>
ffffffffc0200460:	c925                	beqz	a0,ffffffffc02004d0 <kmonitor+0xf2>
ffffffffc0200462:	00144583          	lbu	a1,1(s0)
ffffffffc0200466:	00040023          	sb	zero,0(s0)
ffffffffc020046a:	0405                	addi	s0,s0,1
ffffffffc020046c:	f5fd                	bnez	a1,ffffffffc020045a <kmonitor+0x7c>
ffffffffc020046e:	dce9                	beqz	s1,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc0200470:	6582                	ld	a1,0(sp)
ffffffffc0200472:	00008d17          	auipc	s10,0x8
ffffffffc0200476:	d86d0d13          	addi	s10,s10,-634 # ffffffffc02081f8 <commands>
ffffffffc020047a:	8556                	mv	a0,s5
ffffffffc020047c:	4401                	li	s0,0
ffffffffc020047e:	0d61                	addi	s10,s10,24
ffffffffc0200480:	672070ef          	jal	ra,ffffffffc0207af2 <strcmp>
ffffffffc0200484:	c919                	beqz	a0,ffffffffc020049a <kmonitor+0xbc>
ffffffffc0200486:	2405                	addiw	s0,s0,1
ffffffffc0200488:	09740463          	beq	s0,s7,ffffffffc0200510 <kmonitor+0x132>
ffffffffc020048c:	000d3503          	ld	a0,0(s10)
ffffffffc0200490:	6582                	ld	a1,0(sp)
ffffffffc0200492:	0d61                	addi	s10,s10,24
ffffffffc0200494:	65e070ef          	jal	ra,ffffffffc0207af2 <strcmp>
ffffffffc0200498:	f57d                	bnez	a0,ffffffffc0200486 <kmonitor+0xa8>
ffffffffc020049a:	00141793          	slli	a5,s0,0x1
ffffffffc020049e:	97a2                	add	a5,a5,s0
ffffffffc02004a0:	078e                	slli	a5,a5,0x3
ffffffffc02004a2:	97e6                	add	a5,a5,s9
ffffffffc02004a4:	6b9c                	ld	a5,16(a5)
ffffffffc02004a6:	8662                	mv	a2,s8
ffffffffc02004a8:	002c                	addi	a1,sp,8
ffffffffc02004aa:	fff4851b          	addiw	a0,s1,-1
ffffffffc02004ae:	9782                	jalr	a5
ffffffffc02004b0:	f8055ce3          	bgez	a0,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc02004b4:	60ee                	ld	ra,216(sp)
ffffffffc02004b6:	644e                	ld	s0,208(sp)
ffffffffc02004b8:	64ae                	ld	s1,200(sp)
ffffffffc02004ba:	690e                	ld	s2,192(sp)
ffffffffc02004bc:	79ea                	ld	s3,184(sp)
ffffffffc02004be:	7a4a                	ld	s4,176(sp)
ffffffffc02004c0:	7aaa                	ld	s5,168(sp)
ffffffffc02004c2:	7b0a                	ld	s6,160(sp)
ffffffffc02004c4:	6bea                	ld	s7,152(sp)
ffffffffc02004c6:	6c4a                	ld	s8,144(sp)
ffffffffc02004c8:	6caa                	ld	s9,136(sp)
ffffffffc02004ca:	6d0a                	ld	s10,128(sp)
ffffffffc02004cc:	612d                	addi	sp,sp,224
ffffffffc02004ce:	8082                	ret
ffffffffc02004d0:	00044783          	lbu	a5,0(s0)
ffffffffc02004d4:	dfc9                	beqz	a5,ffffffffc020046e <kmonitor+0x90>
ffffffffc02004d6:	03448863          	beq	s1,s4,ffffffffc0200506 <kmonitor+0x128>
ffffffffc02004da:	00349793          	slli	a5,s1,0x3
ffffffffc02004de:	0118                	addi	a4,sp,128
ffffffffc02004e0:	97ba                	add	a5,a5,a4
ffffffffc02004e2:	f887b023          	sd	s0,-128(a5)
ffffffffc02004e6:	00044583          	lbu	a1,0(s0)
ffffffffc02004ea:	2485                	addiw	s1,s1,1
ffffffffc02004ec:	e591                	bnez	a1,ffffffffc02004f8 <kmonitor+0x11a>
ffffffffc02004ee:	b749                	j	ffffffffc0200470 <kmonitor+0x92>
ffffffffc02004f0:	00144583          	lbu	a1,1(s0)
ffffffffc02004f4:	0405                	addi	s0,s0,1
ffffffffc02004f6:	ddad                	beqz	a1,ffffffffc0200470 <kmonitor+0x92>
ffffffffc02004f8:	854a                	mv	a0,s2
ffffffffc02004fa:	616070ef          	jal	ra,ffffffffc0207b10 <strchr>
ffffffffc02004fe:	d96d                	beqz	a0,ffffffffc02004f0 <kmonitor+0x112>
ffffffffc0200500:	00044583          	lbu	a1,0(s0)
ffffffffc0200504:	bf91                	j	ffffffffc0200458 <kmonitor+0x7a>
ffffffffc0200506:	45c1                	li	a1,16
ffffffffc0200508:	855a                	mv	a0,s6
ffffffffc020050a:	bc3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020050e:	b7f1                	j	ffffffffc02004da <kmonitor+0xfc>
ffffffffc0200510:	6582                	ld	a1,0(sp)
ffffffffc0200512:	00008517          	auipc	a0,0x8
ffffffffc0200516:	cce50513          	addi	a0,a0,-818 # ffffffffc02081e0 <etext+0x28c>
ffffffffc020051a:	bb3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020051e:	b72d                	j	ffffffffc0200448 <kmonitor+0x6a>

ffffffffc0200520 <ide_init>:
ffffffffc0200520:	8082                	ret

ffffffffc0200522 <ide_device_valid>:
ffffffffc0200522:	00253513          	sltiu	a0,a0,2
ffffffffc0200526:	8082                	ret

ffffffffc0200528 <ide_device_size>:
ffffffffc0200528:	03800513          	li	a0,56
ffffffffc020052c:	8082                	ret

ffffffffc020052e <ide_read_secs>:
ffffffffc020052e:	0000e797          	auipc	a5,0xe
ffffffffc0200532:	f6278793          	addi	a5,a5,-158 # ffffffffc020e490 <ide>
ffffffffc0200536:	0095959b          	slliw	a1,a1,0x9
ffffffffc020053a:	1141                	addi	sp,sp,-16
ffffffffc020053c:	8532                	mv	a0,a2
ffffffffc020053e:	95be                	add	a1,a1,a5
ffffffffc0200540:	00969613          	slli	a2,a3,0x9
ffffffffc0200544:	e406                	sd	ra,8(sp)
ffffffffc0200546:	5f2070ef          	jal	ra,ffffffffc0207b38 <memcpy>
ffffffffc020054a:	60a2                	ld	ra,8(sp)
ffffffffc020054c:	4501                	li	a0,0
ffffffffc020054e:	0141                	addi	sp,sp,16
ffffffffc0200550:	8082                	ret

ffffffffc0200552 <ide_write_secs>:
ffffffffc0200552:	0095979b          	slliw	a5,a1,0x9
ffffffffc0200556:	0000e517          	auipc	a0,0xe
ffffffffc020055a:	f3a50513          	addi	a0,a0,-198 # ffffffffc020e490 <ide>
ffffffffc020055e:	1141                	addi	sp,sp,-16
ffffffffc0200560:	85b2                	mv	a1,a2
ffffffffc0200562:	953e                	add	a0,a0,a5
ffffffffc0200564:	00969613          	slli	a2,a3,0x9
ffffffffc0200568:	e406                	sd	ra,8(sp)
ffffffffc020056a:	5ce070ef          	jal	ra,ffffffffc0207b38 <memcpy>
ffffffffc020056e:	60a2                	ld	ra,8(sp)
ffffffffc0200570:	4501                	li	a0,0
ffffffffc0200572:	0141                	addi	sp,sp,16
ffffffffc0200574:	8082                	ret

ffffffffc0200576 <clock_init>:
ffffffffc0200576:	02000793          	li	a5,32
ffffffffc020057a:	1047a7f3          	csrrs	a5,sie,a5
ffffffffc020057e:	c0102573          	rdtime	a0
ffffffffc0200582:	67e1                	lui	a5,0x18
ffffffffc0200584:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc0200588:	953e                	add	a0,a0,a5
ffffffffc020058a:	4581                	li	a1,0
ffffffffc020058c:	4601                	li	a2,0
ffffffffc020058e:	4881                	li	a7,0
ffffffffc0200590:	00000073          	ecall
ffffffffc0200594:	00008517          	auipc	a0,0x8
ffffffffc0200598:	cac50513          	addi	a0,a0,-852 # ffffffffc0208240 <commands+0x48>
ffffffffc020059c:	00019797          	auipc	a5,0x19
ffffffffc02005a0:	f807b623          	sd	zero,-116(a5) # ffffffffc0219528 <ticks>
ffffffffc02005a4:	b625                	j	ffffffffc02000cc <cprintf>

ffffffffc02005a6 <clock_set_next_event>:
ffffffffc02005a6:	c0102573          	rdtime	a0
ffffffffc02005aa:	67e1                	lui	a5,0x18
ffffffffc02005ac:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc02005b0:	953e                	add	a0,a0,a5
ffffffffc02005b2:	4581                	li	a1,0
ffffffffc02005b4:	4601                	li	a2,0
ffffffffc02005b6:	4881                	li	a7,0
ffffffffc02005b8:	00000073          	ecall
ffffffffc02005bc:	8082                	ret

ffffffffc02005be <cons_init>:
ffffffffc02005be:	8082                	ret

ffffffffc02005c0 <cons_putc>:
ffffffffc02005c0:	100027f3          	csrr	a5,sstatus
ffffffffc02005c4:	8b89                	andi	a5,a5,2
ffffffffc02005c6:	0ff57513          	andi	a0,a0,255
ffffffffc02005ca:	e799                	bnez	a5,ffffffffc02005d8 <cons_putc+0x18>
ffffffffc02005cc:	4581                	li	a1,0
ffffffffc02005ce:	4601                	li	a2,0
ffffffffc02005d0:	4885                	li	a7,1
ffffffffc02005d2:	00000073          	ecall
ffffffffc02005d6:	8082                	ret
ffffffffc02005d8:	1101                	addi	sp,sp,-32
ffffffffc02005da:	ec06                	sd	ra,24(sp)
ffffffffc02005dc:	e42a                	sd	a0,8(sp)
ffffffffc02005de:	05a000ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02005e2:	6522                	ld	a0,8(sp)
ffffffffc02005e4:	4581                	li	a1,0
ffffffffc02005e6:	4601                	li	a2,0
ffffffffc02005e8:	4885                	li	a7,1
ffffffffc02005ea:	00000073          	ecall
ffffffffc02005ee:	60e2                	ld	ra,24(sp)
ffffffffc02005f0:	6105                	addi	sp,sp,32
ffffffffc02005f2:	a081                	j	ffffffffc0200632 <intr_enable>

ffffffffc02005f4 <cons_getc>:
ffffffffc02005f4:	100027f3          	csrr	a5,sstatus
ffffffffc02005f8:	8b89                	andi	a5,a5,2
ffffffffc02005fa:	eb89                	bnez	a5,ffffffffc020060c <cons_getc+0x18>
ffffffffc02005fc:	4501                	li	a0,0
ffffffffc02005fe:	4581                	li	a1,0
ffffffffc0200600:	4601                	li	a2,0
ffffffffc0200602:	4889                	li	a7,2
ffffffffc0200604:	00000073          	ecall
ffffffffc0200608:	2501                	sext.w	a0,a0
ffffffffc020060a:	8082                	ret
ffffffffc020060c:	1101                	addi	sp,sp,-32
ffffffffc020060e:	ec06                	sd	ra,24(sp)
ffffffffc0200610:	028000ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0200614:	4501                	li	a0,0
ffffffffc0200616:	4581                	li	a1,0
ffffffffc0200618:	4601                	li	a2,0
ffffffffc020061a:	4889                	li	a7,2
ffffffffc020061c:	00000073          	ecall
ffffffffc0200620:	2501                	sext.w	a0,a0
ffffffffc0200622:	e42a                	sd	a0,8(sp)
ffffffffc0200624:	00e000ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0200628:	60e2                	ld	ra,24(sp)
ffffffffc020062a:	6522                	ld	a0,8(sp)
ffffffffc020062c:	6105                	addi	sp,sp,32
ffffffffc020062e:	8082                	ret

ffffffffc0200630 <pic_init>:
ffffffffc0200630:	8082                	ret

ffffffffc0200632 <intr_enable>:
ffffffffc0200632:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200636:	8082                	ret

ffffffffc0200638 <intr_disable>:
ffffffffc0200638:	100177f3          	csrrci	a5,sstatus,2
ffffffffc020063c:	8082                	ret

ffffffffc020063e <idt_init>:
ffffffffc020063e:	14005073          	csrwi	sscratch,0
ffffffffc0200642:	00000797          	auipc	a5,0x0
ffffffffc0200646:	61e78793          	addi	a5,a5,1566 # ffffffffc0200c60 <__alltraps>
ffffffffc020064a:	10579073          	csrw	stvec,a5
ffffffffc020064e:	000407b7          	lui	a5,0x40
ffffffffc0200652:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200656:	8082                	ret

ffffffffc0200658 <print_regs>:
ffffffffc0200658:	610c                	ld	a1,0(a0)
ffffffffc020065a:	1141                	addi	sp,sp,-16
ffffffffc020065c:	e022                	sd	s0,0(sp)
ffffffffc020065e:	842a                	mv	s0,a0
ffffffffc0200660:	00008517          	auipc	a0,0x8
ffffffffc0200664:	c0050513          	addi	a0,a0,-1024 # ffffffffc0208260 <commands+0x68>
ffffffffc0200668:	e406                	sd	ra,8(sp)
ffffffffc020066a:	a63ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020066e:	640c                	ld	a1,8(s0)
ffffffffc0200670:	00008517          	auipc	a0,0x8
ffffffffc0200674:	c0850513          	addi	a0,a0,-1016 # ffffffffc0208278 <commands+0x80>
ffffffffc0200678:	a55ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020067c:	680c                	ld	a1,16(s0)
ffffffffc020067e:	00008517          	auipc	a0,0x8
ffffffffc0200682:	c1250513          	addi	a0,a0,-1006 # ffffffffc0208290 <commands+0x98>
ffffffffc0200686:	a47ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020068a:	6c0c                	ld	a1,24(s0)
ffffffffc020068c:	00008517          	auipc	a0,0x8
ffffffffc0200690:	c1c50513          	addi	a0,a0,-996 # ffffffffc02082a8 <commands+0xb0>
ffffffffc0200694:	a39ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200698:	700c                	ld	a1,32(s0)
ffffffffc020069a:	00008517          	auipc	a0,0x8
ffffffffc020069e:	c2650513          	addi	a0,a0,-986 # ffffffffc02082c0 <commands+0xc8>
ffffffffc02006a2:	a2bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006a6:	740c                	ld	a1,40(s0)
ffffffffc02006a8:	00008517          	auipc	a0,0x8
ffffffffc02006ac:	c3050513          	addi	a0,a0,-976 # ffffffffc02082d8 <commands+0xe0>
ffffffffc02006b0:	a1dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006b4:	780c                	ld	a1,48(s0)
ffffffffc02006b6:	00008517          	auipc	a0,0x8
ffffffffc02006ba:	c3a50513          	addi	a0,a0,-966 # ffffffffc02082f0 <commands+0xf8>
ffffffffc02006be:	a0fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006c2:	7c0c                	ld	a1,56(s0)
ffffffffc02006c4:	00008517          	auipc	a0,0x8
ffffffffc02006c8:	c4450513          	addi	a0,a0,-956 # ffffffffc0208308 <commands+0x110>
ffffffffc02006cc:	a01ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006d0:	602c                	ld	a1,64(s0)
ffffffffc02006d2:	00008517          	auipc	a0,0x8
ffffffffc02006d6:	c4e50513          	addi	a0,a0,-946 # ffffffffc0208320 <commands+0x128>
ffffffffc02006da:	9f3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006de:	642c                	ld	a1,72(s0)
ffffffffc02006e0:	00008517          	auipc	a0,0x8
ffffffffc02006e4:	c5850513          	addi	a0,a0,-936 # ffffffffc0208338 <commands+0x140>
ffffffffc02006e8:	9e5ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006ec:	682c                	ld	a1,80(s0)
ffffffffc02006ee:	00008517          	auipc	a0,0x8
ffffffffc02006f2:	c6250513          	addi	a0,a0,-926 # ffffffffc0208350 <commands+0x158>
ffffffffc02006f6:	9d7ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006fa:	6c2c                	ld	a1,88(s0)
ffffffffc02006fc:	00008517          	auipc	a0,0x8
ffffffffc0200700:	c6c50513          	addi	a0,a0,-916 # ffffffffc0208368 <commands+0x170>
ffffffffc0200704:	9c9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200708:	702c                	ld	a1,96(s0)
ffffffffc020070a:	00008517          	auipc	a0,0x8
ffffffffc020070e:	c7650513          	addi	a0,a0,-906 # ffffffffc0208380 <commands+0x188>
ffffffffc0200712:	9bbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200716:	742c                	ld	a1,104(s0)
ffffffffc0200718:	00008517          	auipc	a0,0x8
ffffffffc020071c:	c8050513          	addi	a0,a0,-896 # ffffffffc0208398 <commands+0x1a0>
ffffffffc0200720:	9adff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200724:	782c                	ld	a1,112(s0)
ffffffffc0200726:	00008517          	auipc	a0,0x8
ffffffffc020072a:	c8a50513          	addi	a0,a0,-886 # ffffffffc02083b0 <commands+0x1b8>
ffffffffc020072e:	99fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200732:	7c2c                	ld	a1,120(s0)
ffffffffc0200734:	00008517          	auipc	a0,0x8
ffffffffc0200738:	c9450513          	addi	a0,a0,-876 # ffffffffc02083c8 <commands+0x1d0>
ffffffffc020073c:	991ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200740:	604c                	ld	a1,128(s0)
ffffffffc0200742:	00008517          	auipc	a0,0x8
ffffffffc0200746:	c9e50513          	addi	a0,a0,-866 # ffffffffc02083e0 <commands+0x1e8>
ffffffffc020074a:	983ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020074e:	644c                	ld	a1,136(s0)
ffffffffc0200750:	00008517          	auipc	a0,0x8
ffffffffc0200754:	ca850513          	addi	a0,a0,-856 # ffffffffc02083f8 <commands+0x200>
ffffffffc0200758:	975ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020075c:	684c                	ld	a1,144(s0)
ffffffffc020075e:	00008517          	auipc	a0,0x8
ffffffffc0200762:	cb250513          	addi	a0,a0,-846 # ffffffffc0208410 <commands+0x218>
ffffffffc0200766:	967ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020076a:	6c4c                	ld	a1,152(s0)
ffffffffc020076c:	00008517          	auipc	a0,0x8
ffffffffc0200770:	cbc50513          	addi	a0,a0,-836 # ffffffffc0208428 <commands+0x230>
ffffffffc0200774:	959ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200778:	704c                	ld	a1,160(s0)
ffffffffc020077a:	00008517          	auipc	a0,0x8
ffffffffc020077e:	cc650513          	addi	a0,a0,-826 # ffffffffc0208440 <commands+0x248>
ffffffffc0200782:	94bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200786:	744c                	ld	a1,168(s0)
ffffffffc0200788:	00008517          	auipc	a0,0x8
ffffffffc020078c:	cd050513          	addi	a0,a0,-816 # ffffffffc0208458 <commands+0x260>
ffffffffc0200790:	93dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200794:	784c                	ld	a1,176(s0)
ffffffffc0200796:	00008517          	auipc	a0,0x8
ffffffffc020079a:	cda50513          	addi	a0,a0,-806 # ffffffffc0208470 <commands+0x278>
ffffffffc020079e:	92fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007a2:	7c4c                	ld	a1,184(s0)
ffffffffc02007a4:	00008517          	auipc	a0,0x8
ffffffffc02007a8:	ce450513          	addi	a0,a0,-796 # ffffffffc0208488 <commands+0x290>
ffffffffc02007ac:	921ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007b0:	606c                	ld	a1,192(s0)
ffffffffc02007b2:	00008517          	auipc	a0,0x8
ffffffffc02007b6:	cee50513          	addi	a0,a0,-786 # ffffffffc02084a0 <commands+0x2a8>
ffffffffc02007ba:	913ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007be:	646c                	ld	a1,200(s0)
ffffffffc02007c0:	00008517          	auipc	a0,0x8
ffffffffc02007c4:	cf850513          	addi	a0,a0,-776 # ffffffffc02084b8 <commands+0x2c0>
ffffffffc02007c8:	905ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007cc:	686c                	ld	a1,208(s0)
ffffffffc02007ce:	00008517          	auipc	a0,0x8
ffffffffc02007d2:	d0250513          	addi	a0,a0,-766 # ffffffffc02084d0 <commands+0x2d8>
ffffffffc02007d6:	8f7ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007da:	6c6c                	ld	a1,216(s0)
ffffffffc02007dc:	00008517          	auipc	a0,0x8
ffffffffc02007e0:	d0c50513          	addi	a0,a0,-756 # ffffffffc02084e8 <commands+0x2f0>
ffffffffc02007e4:	8e9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007e8:	706c                	ld	a1,224(s0)
ffffffffc02007ea:	00008517          	auipc	a0,0x8
ffffffffc02007ee:	d1650513          	addi	a0,a0,-746 # ffffffffc0208500 <commands+0x308>
ffffffffc02007f2:	8dbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007f6:	746c                	ld	a1,232(s0)
ffffffffc02007f8:	00008517          	auipc	a0,0x8
ffffffffc02007fc:	d2050513          	addi	a0,a0,-736 # ffffffffc0208518 <commands+0x320>
ffffffffc0200800:	8cdff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200804:	786c                	ld	a1,240(s0)
ffffffffc0200806:	00008517          	auipc	a0,0x8
ffffffffc020080a:	d2a50513          	addi	a0,a0,-726 # ffffffffc0208530 <commands+0x338>
ffffffffc020080e:	8bfff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200812:	7c6c                	ld	a1,248(s0)
ffffffffc0200814:	6402                	ld	s0,0(sp)
ffffffffc0200816:	60a2                	ld	ra,8(sp)
ffffffffc0200818:	00008517          	auipc	a0,0x8
ffffffffc020081c:	d3050513          	addi	a0,a0,-720 # ffffffffc0208548 <commands+0x350>
ffffffffc0200820:	0141                	addi	sp,sp,16
ffffffffc0200822:	8abff06f          	j	ffffffffc02000cc <cprintf>

ffffffffc0200826 <print_trapframe>:
ffffffffc0200826:	1141                	addi	sp,sp,-16
ffffffffc0200828:	e022                	sd	s0,0(sp)
ffffffffc020082a:	85aa                	mv	a1,a0
ffffffffc020082c:	842a                	mv	s0,a0
ffffffffc020082e:	00008517          	auipc	a0,0x8
ffffffffc0200832:	d3250513          	addi	a0,a0,-718 # ffffffffc0208560 <commands+0x368>
ffffffffc0200836:	e406                	sd	ra,8(sp)
ffffffffc0200838:	895ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020083c:	8522                	mv	a0,s0
ffffffffc020083e:	e1bff0ef          	jal	ra,ffffffffc0200658 <print_regs>
ffffffffc0200842:	10043583          	ld	a1,256(s0)
ffffffffc0200846:	00008517          	auipc	a0,0x8
ffffffffc020084a:	d3250513          	addi	a0,a0,-718 # ffffffffc0208578 <commands+0x380>
ffffffffc020084e:	87fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200852:	10843583          	ld	a1,264(s0)
ffffffffc0200856:	00008517          	auipc	a0,0x8
ffffffffc020085a:	d3a50513          	addi	a0,a0,-710 # ffffffffc0208590 <commands+0x398>
ffffffffc020085e:	86fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200862:	11043583          	ld	a1,272(s0)
ffffffffc0200866:	00008517          	auipc	a0,0x8
ffffffffc020086a:	d4250513          	addi	a0,a0,-702 # ffffffffc02085a8 <commands+0x3b0>
ffffffffc020086e:	85fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200872:	11843583          	ld	a1,280(s0)
ffffffffc0200876:	6402                	ld	s0,0(sp)
ffffffffc0200878:	60a2                	ld	ra,8(sp)
ffffffffc020087a:	00008517          	auipc	a0,0x8
ffffffffc020087e:	d3e50513          	addi	a0,a0,-706 # ffffffffc02085b8 <commands+0x3c0>
ffffffffc0200882:	0141                	addi	sp,sp,16
ffffffffc0200884:	849ff06f          	j	ffffffffc02000cc <cprintf>

ffffffffc0200888 <pgfault_handler>:
ffffffffc0200888:	1101                	addi	sp,sp,-32
ffffffffc020088a:	e426                	sd	s1,8(sp)
ffffffffc020088c:	00019497          	auipc	s1,0x19
ffffffffc0200890:	ca448493          	addi	s1,s1,-860 # ffffffffc0219530 <check_mm_struct>
ffffffffc0200894:	609c                	ld	a5,0(s1)
ffffffffc0200896:	e822                	sd	s0,16(sp)
ffffffffc0200898:	ec06                	sd	ra,24(sp)
ffffffffc020089a:	842a                	mv	s0,a0
ffffffffc020089c:	cbad                	beqz	a5,ffffffffc020090e <pgfault_handler+0x86>
ffffffffc020089e:	10053783          	ld	a5,256(a0)
ffffffffc02008a2:	11053583          	ld	a1,272(a0)
ffffffffc02008a6:	04b00613          	li	a2,75
ffffffffc02008aa:	1007f793          	andi	a5,a5,256
ffffffffc02008ae:	c7b1                	beqz	a5,ffffffffc02008fa <pgfault_handler+0x72>
ffffffffc02008b0:	11843703          	ld	a4,280(s0)
ffffffffc02008b4:	47bd                	li	a5,15
ffffffffc02008b6:	05700693          	li	a3,87
ffffffffc02008ba:	00f70463          	beq	a4,a5,ffffffffc02008c2 <pgfault_handler+0x3a>
ffffffffc02008be:	05200693          	li	a3,82
ffffffffc02008c2:	00008517          	auipc	a0,0x8
ffffffffc02008c6:	d0e50513          	addi	a0,a0,-754 # ffffffffc02085d0 <commands+0x3d8>
ffffffffc02008ca:	803ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02008ce:	6088                	ld	a0,0(s1)
ffffffffc02008d0:	cd1d                	beqz	a0,ffffffffc020090e <pgfault_handler+0x86>
ffffffffc02008d2:	00019717          	auipc	a4,0x19
ffffffffc02008d6:	c2673703          	ld	a4,-986(a4) # ffffffffc02194f8 <current>
ffffffffc02008da:	00019797          	auipc	a5,0x19
ffffffffc02008de:	c267b783          	ld	a5,-986(a5) # ffffffffc0219500 <idleproc>
ffffffffc02008e2:	04f71663          	bne	a4,a5,ffffffffc020092e <pgfault_handler+0xa6>
ffffffffc02008e6:	11043603          	ld	a2,272(s0)
ffffffffc02008ea:	11843583          	ld	a1,280(s0)
ffffffffc02008ee:	6442                	ld	s0,16(sp)
ffffffffc02008f0:	60e2                	ld	ra,24(sp)
ffffffffc02008f2:	64a2                	ld	s1,8(sp)
ffffffffc02008f4:	6105                	addi	sp,sp,32
ffffffffc02008f6:	7ce0006f          	j	ffffffffc02010c4 <do_pgfault>
ffffffffc02008fa:	11843703          	ld	a4,280(s0)
ffffffffc02008fe:	47bd                	li	a5,15
ffffffffc0200900:	05500613          	li	a2,85
ffffffffc0200904:	05700693          	li	a3,87
ffffffffc0200908:	faf71be3          	bne	a4,a5,ffffffffc02008be <pgfault_handler+0x36>
ffffffffc020090c:	bf5d                	j	ffffffffc02008c2 <pgfault_handler+0x3a>
ffffffffc020090e:	00019797          	auipc	a5,0x19
ffffffffc0200912:	bea7b783          	ld	a5,-1046(a5) # ffffffffc02194f8 <current>
ffffffffc0200916:	cf85                	beqz	a5,ffffffffc020094e <pgfault_handler+0xc6>
ffffffffc0200918:	11043603          	ld	a2,272(s0)
ffffffffc020091c:	11843583          	ld	a1,280(s0)
ffffffffc0200920:	6442                	ld	s0,16(sp)
ffffffffc0200922:	60e2                	ld	ra,24(sp)
ffffffffc0200924:	64a2                	ld	s1,8(sp)
ffffffffc0200926:	7788                	ld	a0,40(a5)
ffffffffc0200928:	6105                	addi	sp,sp,32
ffffffffc020092a:	79a0006f          	j	ffffffffc02010c4 <do_pgfault>
ffffffffc020092e:	00008697          	auipc	a3,0x8
ffffffffc0200932:	cc268693          	addi	a3,a3,-830 # ffffffffc02085f0 <commands+0x3f8>
ffffffffc0200936:	00008617          	auipc	a2,0x8
ffffffffc020093a:	cd260613          	addi	a2,a2,-814 # ffffffffc0208608 <commands+0x410>
ffffffffc020093e:	06c00593          	li	a1,108
ffffffffc0200942:	00008517          	auipc	a0,0x8
ffffffffc0200946:	cde50513          	addi	a0,a0,-802 # ffffffffc0208620 <commands+0x428>
ffffffffc020094a:	8bfff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020094e:	8522                	mv	a0,s0
ffffffffc0200950:	ed7ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200954:	10043783          	ld	a5,256(s0)
ffffffffc0200958:	11043583          	ld	a1,272(s0)
ffffffffc020095c:	04b00613          	li	a2,75
ffffffffc0200960:	1007f793          	andi	a5,a5,256
ffffffffc0200964:	e399                	bnez	a5,ffffffffc020096a <pgfault_handler+0xe2>
ffffffffc0200966:	05500613          	li	a2,85
ffffffffc020096a:	11843703          	ld	a4,280(s0)
ffffffffc020096e:	47bd                	li	a5,15
ffffffffc0200970:	02f70663          	beq	a4,a5,ffffffffc020099c <pgfault_handler+0x114>
ffffffffc0200974:	05200693          	li	a3,82
ffffffffc0200978:	00008517          	auipc	a0,0x8
ffffffffc020097c:	c5850513          	addi	a0,a0,-936 # ffffffffc02085d0 <commands+0x3d8>
ffffffffc0200980:	f4cff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200984:	00008617          	auipc	a2,0x8
ffffffffc0200988:	cb460613          	addi	a2,a2,-844 # ffffffffc0208638 <commands+0x440>
ffffffffc020098c:	07300593          	li	a1,115
ffffffffc0200990:	00008517          	auipc	a0,0x8
ffffffffc0200994:	c9050513          	addi	a0,a0,-880 # ffffffffc0208620 <commands+0x428>
ffffffffc0200998:	871ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020099c:	05700693          	li	a3,87
ffffffffc02009a0:	bfe1                	j	ffffffffc0200978 <pgfault_handler+0xf0>

ffffffffc02009a2 <interrupt_handler>:
ffffffffc02009a2:	11853783          	ld	a5,280(a0)
ffffffffc02009a6:	472d                	li	a4,11
ffffffffc02009a8:	0786                	slli	a5,a5,0x1
ffffffffc02009aa:	8385                	srli	a5,a5,0x1
ffffffffc02009ac:	06f76863          	bltu	a4,a5,ffffffffc0200a1c <interrupt_handler+0x7a>
ffffffffc02009b0:	00008717          	auipc	a4,0x8
ffffffffc02009b4:	d4070713          	addi	a4,a4,-704 # ffffffffc02086f0 <commands+0x4f8>
ffffffffc02009b8:	078a                	slli	a5,a5,0x2
ffffffffc02009ba:	97ba                	add	a5,a5,a4
ffffffffc02009bc:	439c                	lw	a5,0(a5)
ffffffffc02009be:	97ba                	add	a5,a5,a4
ffffffffc02009c0:	8782                	jr	a5
ffffffffc02009c2:	00008517          	auipc	a0,0x8
ffffffffc02009c6:	cee50513          	addi	a0,a0,-786 # ffffffffc02086b0 <commands+0x4b8>
ffffffffc02009ca:	f02ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009ce:	00008517          	auipc	a0,0x8
ffffffffc02009d2:	cc250513          	addi	a0,a0,-830 # ffffffffc0208690 <commands+0x498>
ffffffffc02009d6:	ef6ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009da:	00008517          	auipc	a0,0x8
ffffffffc02009de:	c7650513          	addi	a0,a0,-906 # ffffffffc0208650 <commands+0x458>
ffffffffc02009e2:	eeaff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009e6:	00008517          	auipc	a0,0x8
ffffffffc02009ea:	c8a50513          	addi	a0,a0,-886 # ffffffffc0208670 <commands+0x478>
ffffffffc02009ee:	edeff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009f2:	1141                	addi	sp,sp,-16
ffffffffc02009f4:	e406                	sd	ra,8(sp)
ffffffffc02009f6:	bb1ff0ef          	jal	ra,ffffffffc02005a6 <clock_set_next_event>
ffffffffc02009fa:	00019717          	auipc	a4,0x19
ffffffffc02009fe:	b2e70713          	addi	a4,a4,-1234 # ffffffffc0219528 <ticks>
ffffffffc0200a02:	631c                	ld	a5,0(a4)
ffffffffc0200a04:	60a2                	ld	ra,8(sp)
ffffffffc0200a06:	0785                	addi	a5,a5,1
ffffffffc0200a08:	e31c                	sd	a5,0(a4)
ffffffffc0200a0a:	0141                	addi	sp,sp,16
ffffffffc0200a0c:	2a60406f          	j	ffffffffc0204cb2 <run_timer_list>
ffffffffc0200a10:	00008517          	auipc	a0,0x8
ffffffffc0200a14:	cc050513          	addi	a0,a0,-832 # ffffffffc02086d0 <commands+0x4d8>
ffffffffc0200a18:	eb4ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc0200a1c:	b529                	j	ffffffffc0200826 <print_trapframe>

ffffffffc0200a1e <exception_handler>:
ffffffffc0200a1e:	11853783          	ld	a5,280(a0)
ffffffffc0200a22:	1101                	addi	sp,sp,-32
ffffffffc0200a24:	e822                	sd	s0,16(sp)
ffffffffc0200a26:	ec06                	sd	ra,24(sp)
ffffffffc0200a28:	e426                	sd	s1,8(sp)
ffffffffc0200a2a:	473d                	li	a4,15
ffffffffc0200a2c:	842a                	mv	s0,a0
ffffffffc0200a2e:	16f76163          	bltu	a4,a5,ffffffffc0200b90 <exception_handler+0x172>
ffffffffc0200a32:	00008717          	auipc	a4,0x8
ffffffffc0200a36:	e8670713          	addi	a4,a4,-378 # ffffffffc02088b8 <commands+0x6c0>
ffffffffc0200a3a:	078a                	slli	a5,a5,0x2
ffffffffc0200a3c:	97ba                	add	a5,a5,a4
ffffffffc0200a3e:	439c                	lw	a5,0(a5)
ffffffffc0200a40:	97ba                	add	a5,a5,a4
ffffffffc0200a42:	8782                	jr	a5
ffffffffc0200a44:	00008517          	auipc	a0,0x8
ffffffffc0200a48:	dcc50513          	addi	a0,a0,-564 # ffffffffc0208810 <commands+0x618>
ffffffffc0200a4c:	e80ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200a50:	10843783          	ld	a5,264(s0)
ffffffffc0200a54:	60e2                	ld	ra,24(sp)
ffffffffc0200a56:	64a2                	ld	s1,8(sp)
ffffffffc0200a58:	0791                	addi	a5,a5,4
ffffffffc0200a5a:	10f43423          	sd	a5,264(s0)
ffffffffc0200a5e:	6442                	ld	s0,16(sp)
ffffffffc0200a60:	6105                	addi	sp,sp,32
ffffffffc0200a62:	7f30606f          	j	ffffffffc0207a54 <syscall>
ffffffffc0200a66:	00008517          	auipc	a0,0x8
ffffffffc0200a6a:	dca50513          	addi	a0,a0,-566 # ffffffffc0208830 <commands+0x638>
ffffffffc0200a6e:	6442                	ld	s0,16(sp)
ffffffffc0200a70:	60e2                	ld	ra,24(sp)
ffffffffc0200a72:	64a2                	ld	s1,8(sp)
ffffffffc0200a74:	6105                	addi	sp,sp,32
ffffffffc0200a76:	e56ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc0200a7a:	00008517          	auipc	a0,0x8
ffffffffc0200a7e:	dd650513          	addi	a0,a0,-554 # ffffffffc0208850 <commands+0x658>
ffffffffc0200a82:	b7f5                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200a84:	00008517          	auipc	a0,0x8
ffffffffc0200a88:	dec50513          	addi	a0,a0,-532 # ffffffffc0208870 <commands+0x678>
ffffffffc0200a8c:	b7cd                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200a8e:	00008517          	auipc	a0,0x8
ffffffffc0200a92:	dfa50513          	addi	a0,a0,-518 # ffffffffc0208888 <commands+0x690>
ffffffffc0200a96:	e36ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200a9a:	8522                	mv	a0,s0
ffffffffc0200a9c:	dedff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200aa0:	84aa                	mv	s1,a0
ffffffffc0200aa2:	10051963          	bnez	a0,ffffffffc0200bb4 <exception_handler+0x196>
ffffffffc0200aa6:	60e2                	ld	ra,24(sp)
ffffffffc0200aa8:	6442                	ld	s0,16(sp)
ffffffffc0200aaa:	64a2                	ld	s1,8(sp)
ffffffffc0200aac:	6105                	addi	sp,sp,32
ffffffffc0200aae:	8082                	ret
ffffffffc0200ab0:	00008517          	auipc	a0,0x8
ffffffffc0200ab4:	df050513          	addi	a0,a0,-528 # ffffffffc02088a0 <commands+0x6a8>
ffffffffc0200ab8:	e14ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200abc:	8522                	mv	a0,s0
ffffffffc0200abe:	dcbff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200ac2:	84aa                	mv	s1,a0
ffffffffc0200ac4:	d16d                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200ac6:	8522                	mv	a0,s0
ffffffffc0200ac8:	d5fff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200acc:	86a6                	mv	a3,s1
ffffffffc0200ace:	00008617          	auipc	a2,0x8
ffffffffc0200ad2:	cf260613          	addi	a2,a2,-782 # ffffffffc02087c0 <commands+0x5c8>
ffffffffc0200ad6:	0f600593          	li	a1,246
ffffffffc0200ada:	00008517          	auipc	a0,0x8
ffffffffc0200ade:	b4650513          	addi	a0,a0,-1210 # ffffffffc0208620 <commands+0x428>
ffffffffc0200ae2:	f26ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200ae6:	00008517          	auipc	a0,0x8
ffffffffc0200aea:	c3a50513          	addi	a0,a0,-966 # ffffffffc0208720 <commands+0x528>
ffffffffc0200aee:	b741                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200af0:	00008517          	auipc	a0,0x8
ffffffffc0200af4:	c5050513          	addi	a0,a0,-944 # ffffffffc0208740 <commands+0x548>
ffffffffc0200af8:	bf9d                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200afa:	00008517          	auipc	a0,0x8
ffffffffc0200afe:	c6650513          	addi	a0,a0,-922 # ffffffffc0208760 <commands+0x568>
ffffffffc0200b02:	b7b5                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200b04:	00008517          	auipc	a0,0x8
ffffffffc0200b08:	c7450513          	addi	a0,a0,-908 # ffffffffc0208778 <commands+0x580>
ffffffffc0200b0c:	dc0ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b10:	6458                	ld	a4,136(s0)
ffffffffc0200b12:	47a9                	li	a5,10
ffffffffc0200b14:	f8f719e3          	bne	a4,a5,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b18:	bf25                	j	ffffffffc0200a50 <exception_handler+0x32>
ffffffffc0200b1a:	00008517          	auipc	a0,0x8
ffffffffc0200b1e:	c6e50513          	addi	a0,a0,-914 # ffffffffc0208788 <commands+0x590>
ffffffffc0200b22:	b7b1                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200b24:	00008517          	auipc	a0,0x8
ffffffffc0200b28:	c8450513          	addi	a0,a0,-892 # ffffffffc02087a8 <commands+0x5b0>
ffffffffc0200b2c:	da0ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b30:	8522                	mv	a0,s0
ffffffffc0200b32:	d57ff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200b36:	84aa                	mv	s1,a0
ffffffffc0200b38:	d53d                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b3a:	8522                	mv	a0,s0
ffffffffc0200b3c:	cebff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200b40:	86a6                	mv	a3,s1
ffffffffc0200b42:	00008617          	auipc	a2,0x8
ffffffffc0200b46:	c7e60613          	addi	a2,a2,-898 # ffffffffc02087c0 <commands+0x5c8>
ffffffffc0200b4a:	0cb00593          	li	a1,203
ffffffffc0200b4e:	00008517          	auipc	a0,0x8
ffffffffc0200b52:	ad250513          	addi	a0,a0,-1326 # ffffffffc0208620 <commands+0x428>
ffffffffc0200b56:	eb2ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200b5a:	00008517          	auipc	a0,0x8
ffffffffc0200b5e:	c9e50513          	addi	a0,a0,-866 # ffffffffc02087f8 <commands+0x600>
ffffffffc0200b62:	d6aff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b66:	8522                	mv	a0,s0
ffffffffc0200b68:	d21ff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200b6c:	84aa                	mv	s1,a0
ffffffffc0200b6e:	dd05                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b70:	8522                	mv	a0,s0
ffffffffc0200b72:	cb5ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200b76:	86a6                	mv	a3,s1
ffffffffc0200b78:	00008617          	auipc	a2,0x8
ffffffffc0200b7c:	c4860613          	addi	a2,a2,-952 # ffffffffc02087c0 <commands+0x5c8>
ffffffffc0200b80:	0d500593          	li	a1,213
ffffffffc0200b84:	00008517          	auipc	a0,0x8
ffffffffc0200b88:	a9c50513          	addi	a0,a0,-1380 # ffffffffc0208620 <commands+0x428>
ffffffffc0200b8c:	e7cff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200b90:	8522                	mv	a0,s0
ffffffffc0200b92:	6442                	ld	s0,16(sp)
ffffffffc0200b94:	60e2                	ld	ra,24(sp)
ffffffffc0200b96:	64a2                	ld	s1,8(sp)
ffffffffc0200b98:	6105                	addi	sp,sp,32
ffffffffc0200b9a:	b171                	j	ffffffffc0200826 <print_trapframe>
ffffffffc0200b9c:	00008617          	auipc	a2,0x8
ffffffffc0200ba0:	c4460613          	addi	a2,a2,-956 # ffffffffc02087e0 <commands+0x5e8>
ffffffffc0200ba4:	0cf00593          	li	a1,207
ffffffffc0200ba8:	00008517          	auipc	a0,0x8
ffffffffc0200bac:	a7850513          	addi	a0,a0,-1416 # ffffffffc0208620 <commands+0x428>
ffffffffc0200bb0:	e58ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200bb4:	8522                	mv	a0,s0
ffffffffc0200bb6:	c71ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200bba:	86a6                	mv	a3,s1
ffffffffc0200bbc:	00008617          	auipc	a2,0x8
ffffffffc0200bc0:	c0460613          	addi	a2,a2,-1020 # ffffffffc02087c0 <commands+0x5c8>
ffffffffc0200bc4:	0ef00593          	li	a1,239
ffffffffc0200bc8:	00008517          	auipc	a0,0x8
ffffffffc0200bcc:	a5850513          	addi	a0,a0,-1448 # ffffffffc0208620 <commands+0x428>
ffffffffc0200bd0:	e38ff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0200bd4 <trap>:
ffffffffc0200bd4:	1101                	addi	sp,sp,-32
ffffffffc0200bd6:	e822                	sd	s0,16(sp)
ffffffffc0200bd8:	00019417          	auipc	s0,0x19
ffffffffc0200bdc:	92040413          	addi	s0,s0,-1760 # ffffffffc02194f8 <current>
ffffffffc0200be0:	6018                	ld	a4,0(s0)
ffffffffc0200be2:	ec06                	sd	ra,24(sp)
ffffffffc0200be4:	e426                	sd	s1,8(sp)
ffffffffc0200be6:	e04a                	sd	s2,0(sp)
ffffffffc0200be8:	11853683          	ld	a3,280(a0)
ffffffffc0200bec:	cf1d                	beqz	a4,ffffffffc0200c2a <trap+0x56>
ffffffffc0200bee:	10053483          	ld	s1,256(a0)
ffffffffc0200bf2:	0a073903          	ld	s2,160(a4)
ffffffffc0200bf6:	f348                	sd	a0,160(a4)
ffffffffc0200bf8:	1004f493          	andi	s1,s1,256
ffffffffc0200bfc:	0206c463          	bltz	a3,ffffffffc0200c24 <trap+0x50>
ffffffffc0200c00:	e1fff0ef          	jal	ra,ffffffffc0200a1e <exception_handler>
ffffffffc0200c04:	601c                	ld	a5,0(s0)
ffffffffc0200c06:	0b27b023          	sd	s2,160(a5)
ffffffffc0200c0a:	e499                	bnez	s1,ffffffffc0200c18 <trap+0x44>
ffffffffc0200c0c:	0b07a703          	lw	a4,176(a5)
ffffffffc0200c10:	8b05                	andi	a4,a4,1
ffffffffc0200c12:	e329                	bnez	a4,ffffffffc0200c54 <trap+0x80>
ffffffffc0200c14:	6f9c                	ld	a5,24(a5)
ffffffffc0200c16:	eb85                	bnez	a5,ffffffffc0200c46 <trap+0x72>
ffffffffc0200c18:	60e2                	ld	ra,24(sp)
ffffffffc0200c1a:	6442                	ld	s0,16(sp)
ffffffffc0200c1c:	64a2                	ld	s1,8(sp)
ffffffffc0200c1e:	6902                	ld	s2,0(sp)
ffffffffc0200c20:	6105                	addi	sp,sp,32
ffffffffc0200c22:	8082                	ret
ffffffffc0200c24:	d7fff0ef          	jal	ra,ffffffffc02009a2 <interrupt_handler>
ffffffffc0200c28:	bff1                	j	ffffffffc0200c04 <trap+0x30>
ffffffffc0200c2a:	0006c863          	bltz	a3,ffffffffc0200c3a <trap+0x66>
ffffffffc0200c2e:	6442                	ld	s0,16(sp)
ffffffffc0200c30:	60e2                	ld	ra,24(sp)
ffffffffc0200c32:	64a2                	ld	s1,8(sp)
ffffffffc0200c34:	6902                	ld	s2,0(sp)
ffffffffc0200c36:	6105                	addi	sp,sp,32
ffffffffc0200c38:	b3dd                	j	ffffffffc0200a1e <exception_handler>
ffffffffc0200c3a:	6442                	ld	s0,16(sp)
ffffffffc0200c3c:	60e2                	ld	ra,24(sp)
ffffffffc0200c3e:	64a2                	ld	s1,8(sp)
ffffffffc0200c40:	6902                	ld	s2,0(sp)
ffffffffc0200c42:	6105                	addi	sp,sp,32
ffffffffc0200c44:	bbb9                	j	ffffffffc02009a2 <interrupt_handler>
ffffffffc0200c46:	6442                	ld	s0,16(sp)
ffffffffc0200c48:	60e2                	ld	ra,24(sp)
ffffffffc0200c4a:	64a2                	ld	s1,8(sp)
ffffffffc0200c4c:	6902                	ld	s2,0(sp)
ffffffffc0200c4e:	6105                	addi	sp,sp,32
ffffffffc0200c50:	6510306f          	j	ffffffffc0204aa0 <schedule>
ffffffffc0200c54:	555d                	li	a0,-9
ffffffffc0200c56:	0d0030ef          	jal	ra,ffffffffc0203d26 <do_exit>
ffffffffc0200c5a:	601c                	ld	a5,0(s0)
ffffffffc0200c5c:	bf65                	j	ffffffffc0200c14 <trap+0x40>
	...

ffffffffc0200c60 <__alltraps>:
ffffffffc0200c60:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200c64:	00011463          	bnez	sp,ffffffffc0200c6c <__alltraps+0xc>
ffffffffc0200c68:	14002173          	csrr	sp,sscratch
ffffffffc0200c6c:	712d                	addi	sp,sp,-288
ffffffffc0200c6e:	e002                	sd	zero,0(sp)
ffffffffc0200c70:	e406                	sd	ra,8(sp)
ffffffffc0200c72:	ec0e                	sd	gp,24(sp)
ffffffffc0200c74:	f012                	sd	tp,32(sp)
ffffffffc0200c76:	f416                	sd	t0,40(sp)
ffffffffc0200c78:	f81a                	sd	t1,48(sp)
ffffffffc0200c7a:	fc1e                	sd	t2,56(sp)
ffffffffc0200c7c:	e0a2                	sd	s0,64(sp)
ffffffffc0200c7e:	e4a6                	sd	s1,72(sp)
ffffffffc0200c80:	e8aa                	sd	a0,80(sp)
ffffffffc0200c82:	ecae                	sd	a1,88(sp)
ffffffffc0200c84:	f0b2                	sd	a2,96(sp)
ffffffffc0200c86:	f4b6                	sd	a3,104(sp)
ffffffffc0200c88:	f8ba                	sd	a4,112(sp)
ffffffffc0200c8a:	fcbe                	sd	a5,120(sp)
ffffffffc0200c8c:	e142                	sd	a6,128(sp)
ffffffffc0200c8e:	e546                	sd	a7,136(sp)
ffffffffc0200c90:	e94a                	sd	s2,144(sp)
ffffffffc0200c92:	ed4e                	sd	s3,152(sp)
ffffffffc0200c94:	f152                	sd	s4,160(sp)
ffffffffc0200c96:	f556                	sd	s5,168(sp)
ffffffffc0200c98:	f95a                	sd	s6,176(sp)
ffffffffc0200c9a:	fd5e                	sd	s7,184(sp)
ffffffffc0200c9c:	e1e2                	sd	s8,192(sp)
ffffffffc0200c9e:	e5e6                	sd	s9,200(sp)
ffffffffc0200ca0:	e9ea                	sd	s10,208(sp)
ffffffffc0200ca2:	edee                	sd	s11,216(sp)
ffffffffc0200ca4:	f1f2                	sd	t3,224(sp)
ffffffffc0200ca6:	f5f6                	sd	t4,232(sp)
ffffffffc0200ca8:	f9fa                	sd	t5,240(sp)
ffffffffc0200caa:	fdfe                	sd	t6,248(sp)
ffffffffc0200cac:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200cb0:	100024f3          	csrr	s1,sstatus
ffffffffc0200cb4:	14102973          	csrr	s2,sepc
ffffffffc0200cb8:	143029f3          	csrr	s3,stval
ffffffffc0200cbc:	14202a73          	csrr	s4,scause
ffffffffc0200cc0:	e822                	sd	s0,16(sp)
ffffffffc0200cc2:	e226                	sd	s1,256(sp)
ffffffffc0200cc4:	e64a                	sd	s2,264(sp)
ffffffffc0200cc6:	ea4e                	sd	s3,272(sp)
ffffffffc0200cc8:	ee52                	sd	s4,280(sp)
ffffffffc0200cca:	850a                	mv	a0,sp
ffffffffc0200ccc:	f09ff0ef          	jal	ra,ffffffffc0200bd4 <trap>

ffffffffc0200cd0 <__trapret>:
ffffffffc0200cd0:	6492                	ld	s1,256(sp)
ffffffffc0200cd2:	6932                	ld	s2,264(sp)
ffffffffc0200cd4:	1004f413          	andi	s0,s1,256
ffffffffc0200cd8:	e401                	bnez	s0,ffffffffc0200ce0 <__trapret+0x10>
ffffffffc0200cda:	1200                	addi	s0,sp,288
ffffffffc0200cdc:	14041073          	csrw	sscratch,s0
ffffffffc0200ce0:	10049073          	csrw	sstatus,s1
ffffffffc0200ce4:	14191073          	csrw	sepc,s2
ffffffffc0200ce8:	60a2                	ld	ra,8(sp)
ffffffffc0200cea:	61e2                	ld	gp,24(sp)
ffffffffc0200cec:	7202                	ld	tp,32(sp)
ffffffffc0200cee:	72a2                	ld	t0,40(sp)
ffffffffc0200cf0:	7342                	ld	t1,48(sp)
ffffffffc0200cf2:	73e2                	ld	t2,56(sp)
ffffffffc0200cf4:	6406                	ld	s0,64(sp)
ffffffffc0200cf6:	64a6                	ld	s1,72(sp)
ffffffffc0200cf8:	6546                	ld	a0,80(sp)
ffffffffc0200cfa:	65e6                	ld	a1,88(sp)
ffffffffc0200cfc:	7606                	ld	a2,96(sp)
ffffffffc0200cfe:	76a6                	ld	a3,104(sp)
ffffffffc0200d00:	7746                	ld	a4,112(sp)
ffffffffc0200d02:	77e6                	ld	a5,120(sp)
ffffffffc0200d04:	680a                	ld	a6,128(sp)
ffffffffc0200d06:	68aa                	ld	a7,136(sp)
ffffffffc0200d08:	694a                	ld	s2,144(sp)
ffffffffc0200d0a:	69ea                	ld	s3,152(sp)
ffffffffc0200d0c:	7a0a                	ld	s4,160(sp)
ffffffffc0200d0e:	7aaa                	ld	s5,168(sp)
ffffffffc0200d10:	7b4a                	ld	s6,176(sp)
ffffffffc0200d12:	7bea                	ld	s7,184(sp)
ffffffffc0200d14:	6c0e                	ld	s8,192(sp)
ffffffffc0200d16:	6cae                	ld	s9,200(sp)
ffffffffc0200d18:	6d4e                	ld	s10,208(sp)
ffffffffc0200d1a:	6dee                	ld	s11,216(sp)
ffffffffc0200d1c:	7e0e                	ld	t3,224(sp)
ffffffffc0200d1e:	7eae                	ld	t4,232(sp)
ffffffffc0200d20:	7f4e                	ld	t5,240(sp)
ffffffffc0200d22:	7fee                	ld	t6,248(sp)
ffffffffc0200d24:	6142                	ld	sp,16(sp)
ffffffffc0200d26:	10200073          	sret

ffffffffc0200d2a <forkrets>:
ffffffffc0200d2a:	812a                	mv	sp,a0
ffffffffc0200d2c:	b755                	j	ffffffffc0200cd0 <__trapret>

ffffffffc0200d2e <check_vma_overlap.isra.0.part.0>:
ffffffffc0200d2e:	1141                	addi	sp,sp,-16
ffffffffc0200d30:	00008697          	auipc	a3,0x8
ffffffffc0200d34:	bc868693          	addi	a3,a3,-1080 # ffffffffc02088f8 <commands+0x700>
ffffffffc0200d38:	00008617          	auipc	a2,0x8
ffffffffc0200d3c:	8d060613          	addi	a2,a2,-1840 # ffffffffc0208608 <commands+0x410>
ffffffffc0200d40:	06d00593          	li	a1,109
ffffffffc0200d44:	00008517          	auipc	a0,0x8
ffffffffc0200d48:	bd450513          	addi	a0,a0,-1068 # ffffffffc0208918 <commands+0x720>
ffffffffc0200d4c:	e406                	sd	ra,8(sp)
ffffffffc0200d4e:	cbaff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0200d52 <mm_create>:
ffffffffc0200d52:	1141                	addi	sp,sp,-16
ffffffffc0200d54:	05800513          	li	a0,88
ffffffffc0200d58:	e022                	sd	s0,0(sp)
ffffffffc0200d5a:	e406                	sd	ra,8(sp)
ffffffffc0200d5c:	2ed000ef          	jal	ra,ffffffffc0201848 <kmalloc>
ffffffffc0200d60:	842a                	mv	s0,a0
ffffffffc0200d62:	c51d                	beqz	a0,ffffffffc0200d90 <mm_create+0x3e>
ffffffffc0200d64:	e408                	sd	a0,8(s0)
ffffffffc0200d66:	e008                	sd	a0,0(s0)
ffffffffc0200d68:	00053823          	sd	zero,16(a0)
ffffffffc0200d6c:	00053c23          	sd	zero,24(a0)
ffffffffc0200d70:	02052023          	sw	zero,32(a0)
ffffffffc0200d74:	00018797          	auipc	a5,0x18
ffffffffc0200d78:	76c7a783          	lw	a5,1900(a5) # ffffffffc02194e0 <swap_init_ok>
ffffffffc0200d7c:	ef99                	bnez	a5,ffffffffc0200d9a <mm_create+0x48>
ffffffffc0200d7e:	02053423          	sd	zero,40(a0)
ffffffffc0200d82:	02042823          	sw	zero,48(s0)
ffffffffc0200d86:	4585                	li	a1,1
ffffffffc0200d88:	03840513          	addi	a0,s0,56
ffffffffc0200d8c:	786020ef          	jal	ra,ffffffffc0203512 <sem_init>
ffffffffc0200d90:	60a2                	ld	ra,8(sp)
ffffffffc0200d92:	8522                	mv	a0,s0
ffffffffc0200d94:	6402                	ld	s0,0(sp)
ffffffffc0200d96:	0141                	addi	sp,sp,16
ffffffffc0200d98:	8082                	ret
ffffffffc0200d9a:	4db000ef          	jal	ra,ffffffffc0201a74 <swap_init_mm>
ffffffffc0200d9e:	b7d5                	j	ffffffffc0200d82 <mm_create+0x30>

ffffffffc0200da0 <find_vma>:
ffffffffc0200da0:	86aa                	mv	a3,a0
ffffffffc0200da2:	c505                	beqz	a0,ffffffffc0200dca <find_vma+0x2a>
ffffffffc0200da4:	6908                	ld	a0,16(a0)
ffffffffc0200da6:	c501                	beqz	a0,ffffffffc0200dae <find_vma+0xe>
ffffffffc0200da8:	651c                	ld	a5,8(a0)
ffffffffc0200daa:	02f5f263          	bgeu	a1,a5,ffffffffc0200dce <find_vma+0x2e>
ffffffffc0200dae:	669c                	ld	a5,8(a3)
ffffffffc0200db0:	00f68d63          	beq	a3,a5,ffffffffc0200dca <find_vma+0x2a>
ffffffffc0200db4:	fe87b703          	ld	a4,-24(a5)
ffffffffc0200db8:	00e5e663          	bltu	a1,a4,ffffffffc0200dc4 <find_vma+0x24>
ffffffffc0200dbc:	ff07b703          	ld	a4,-16(a5)
ffffffffc0200dc0:	00e5ec63          	bltu	a1,a4,ffffffffc0200dd8 <find_vma+0x38>
ffffffffc0200dc4:	679c                	ld	a5,8(a5)
ffffffffc0200dc6:	fef697e3          	bne	a3,a5,ffffffffc0200db4 <find_vma+0x14>
ffffffffc0200dca:	4501                	li	a0,0
ffffffffc0200dcc:	8082                	ret
ffffffffc0200dce:	691c                	ld	a5,16(a0)
ffffffffc0200dd0:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0200dae <find_vma+0xe>
ffffffffc0200dd4:	ea88                	sd	a0,16(a3)
ffffffffc0200dd6:	8082                	ret
ffffffffc0200dd8:	fe078513          	addi	a0,a5,-32
ffffffffc0200ddc:	ea88                	sd	a0,16(a3)
ffffffffc0200dde:	8082                	ret

ffffffffc0200de0 <insert_vma_struct>:
ffffffffc0200de0:	6590                	ld	a2,8(a1)
ffffffffc0200de2:	0105b803          	ld	a6,16(a1)
ffffffffc0200de6:	1141                	addi	sp,sp,-16
ffffffffc0200de8:	e406                	sd	ra,8(sp)
ffffffffc0200dea:	87aa                	mv	a5,a0
ffffffffc0200dec:	01066763          	bltu	a2,a6,ffffffffc0200dfa <insert_vma_struct+0x1a>
ffffffffc0200df0:	a085                	j	ffffffffc0200e50 <insert_vma_struct+0x70>
ffffffffc0200df2:	fe87b703          	ld	a4,-24(a5)
ffffffffc0200df6:	04e66863          	bltu	a2,a4,ffffffffc0200e46 <insert_vma_struct+0x66>
ffffffffc0200dfa:	86be                	mv	a3,a5
ffffffffc0200dfc:	679c                	ld	a5,8(a5)
ffffffffc0200dfe:	fef51ae3          	bne	a0,a5,ffffffffc0200df2 <insert_vma_struct+0x12>
ffffffffc0200e02:	02a68463          	beq	a3,a0,ffffffffc0200e2a <insert_vma_struct+0x4a>
ffffffffc0200e06:	ff06b703          	ld	a4,-16(a3)
ffffffffc0200e0a:	fe86b883          	ld	a7,-24(a3)
ffffffffc0200e0e:	08e8f163          	bgeu	a7,a4,ffffffffc0200e90 <insert_vma_struct+0xb0>
ffffffffc0200e12:	04e66f63          	bltu	a2,a4,ffffffffc0200e70 <insert_vma_struct+0x90>
ffffffffc0200e16:	00f50a63          	beq	a0,a5,ffffffffc0200e2a <insert_vma_struct+0x4a>
ffffffffc0200e1a:	fe87b703          	ld	a4,-24(a5)
ffffffffc0200e1e:	05076963          	bltu	a4,a6,ffffffffc0200e70 <insert_vma_struct+0x90>
ffffffffc0200e22:	ff07b603          	ld	a2,-16(a5)
ffffffffc0200e26:	02c77363          	bgeu	a4,a2,ffffffffc0200e4c <insert_vma_struct+0x6c>
ffffffffc0200e2a:	5118                	lw	a4,32(a0)
ffffffffc0200e2c:	e188                	sd	a0,0(a1)
ffffffffc0200e2e:	02058613          	addi	a2,a1,32
ffffffffc0200e32:	e390                	sd	a2,0(a5)
ffffffffc0200e34:	e690                	sd	a2,8(a3)
ffffffffc0200e36:	60a2                	ld	ra,8(sp)
ffffffffc0200e38:	f59c                	sd	a5,40(a1)
ffffffffc0200e3a:	f194                	sd	a3,32(a1)
ffffffffc0200e3c:	0017079b          	addiw	a5,a4,1
ffffffffc0200e40:	d11c                	sw	a5,32(a0)
ffffffffc0200e42:	0141                	addi	sp,sp,16
ffffffffc0200e44:	8082                	ret
ffffffffc0200e46:	fca690e3          	bne	a3,a0,ffffffffc0200e06 <insert_vma_struct+0x26>
ffffffffc0200e4a:	bfd1                	j	ffffffffc0200e1e <insert_vma_struct+0x3e>
ffffffffc0200e4c:	ee3ff0ef          	jal	ra,ffffffffc0200d2e <check_vma_overlap.isra.0.part.0>
ffffffffc0200e50:	00008697          	auipc	a3,0x8
ffffffffc0200e54:	ad868693          	addi	a3,a3,-1320 # ffffffffc0208928 <commands+0x730>
ffffffffc0200e58:	00007617          	auipc	a2,0x7
ffffffffc0200e5c:	7b060613          	addi	a2,a2,1968 # ffffffffc0208608 <commands+0x410>
ffffffffc0200e60:	07400593          	li	a1,116
ffffffffc0200e64:	00008517          	auipc	a0,0x8
ffffffffc0200e68:	ab450513          	addi	a0,a0,-1356 # ffffffffc0208918 <commands+0x720>
ffffffffc0200e6c:	b9cff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200e70:	00008697          	auipc	a3,0x8
ffffffffc0200e74:	af868693          	addi	a3,a3,-1288 # ffffffffc0208968 <commands+0x770>
ffffffffc0200e78:	00007617          	auipc	a2,0x7
ffffffffc0200e7c:	79060613          	addi	a2,a2,1936 # ffffffffc0208608 <commands+0x410>
ffffffffc0200e80:	06c00593          	li	a1,108
ffffffffc0200e84:	00008517          	auipc	a0,0x8
ffffffffc0200e88:	a9450513          	addi	a0,a0,-1388 # ffffffffc0208918 <commands+0x720>
ffffffffc0200e8c:	b7cff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200e90:	00008697          	auipc	a3,0x8
ffffffffc0200e94:	ab868693          	addi	a3,a3,-1352 # ffffffffc0208948 <commands+0x750>
ffffffffc0200e98:	00007617          	auipc	a2,0x7
ffffffffc0200e9c:	77060613          	addi	a2,a2,1904 # ffffffffc0208608 <commands+0x410>
ffffffffc0200ea0:	06b00593          	li	a1,107
ffffffffc0200ea4:	00008517          	auipc	a0,0x8
ffffffffc0200ea8:	a7450513          	addi	a0,a0,-1420 # ffffffffc0208918 <commands+0x720>
ffffffffc0200eac:	b5cff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0200eb0 <mm_destroy>:
ffffffffc0200eb0:	591c                	lw	a5,48(a0)
ffffffffc0200eb2:	1141                	addi	sp,sp,-16
ffffffffc0200eb4:	e406                	sd	ra,8(sp)
ffffffffc0200eb6:	e022                	sd	s0,0(sp)
ffffffffc0200eb8:	e78d                	bnez	a5,ffffffffc0200ee2 <mm_destroy+0x32>
ffffffffc0200eba:	842a                	mv	s0,a0
ffffffffc0200ebc:	6508                	ld	a0,8(a0)
ffffffffc0200ebe:	00a40c63          	beq	s0,a0,ffffffffc0200ed6 <mm_destroy+0x26>
ffffffffc0200ec2:	6118                	ld	a4,0(a0)
ffffffffc0200ec4:	651c                	ld	a5,8(a0)
ffffffffc0200ec6:	1501                	addi	a0,a0,-32
ffffffffc0200ec8:	e71c                	sd	a5,8(a4)
ffffffffc0200eca:	e398                	sd	a4,0(a5)
ffffffffc0200ecc:	22d000ef          	jal	ra,ffffffffc02018f8 <kfree>
ffffffffc0200ed0:	6408                	ld	a0,8(s0)
ffffffffc0200ed2:	fea418e3          	bne	s0,a0,ffffffffc0200ec2 <mm_destroy+0x12>
ffffffffc0200ed6:	8522                	mv	a0,s0
ffffffffc0200ed8:	6402                	ld	s0,0(sp)
ffffffffc0200eda:	60a2                	ld	ra,8(sp)
ffffffffc0200edc:	0141                	addi	sp,sp,16
ffffffffc0200ede:	21b0006f          	j	ffffffffc02018f8 <kfree>
ffffffffc0200ee2:	00008697          	auipc	a3,0x8
ffffffffc0200ee6:	aa668693          	addi	a3,a3,-1370 # ffffffffc0208988 <commands+0x790>
ffffffffc0200eea:	00007617          	auipc	a2,0x7
ffffffffc0200eee:	71e60613          	addi	a2,a2,1822 # ffffffffc0208608 <commands+0x410>
ffffffffc0200ef2:	09400593          	li	a1,148
ffffffffc0200ef6:	00008517          	auipc	a0,0x8
ffffffffc0200efa:	a2250513          	addi	a0,a0,-1502 # ffffffffc0208918 <commands+0x720>
ffffffffc0200efe:	b0aff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0200f02 <mm_map>:
ffffffffc0200f02:	7139                	addi	sp,sp,-64
ffffffffc0200f04:	f822                	sd	s0,48(sp)
ffffffffc0200f06:	6405                	lui	s0,0x1
ffffffffc0200f08:	147d                	addi	s0,s0,-1
ffffffffc0200f0a:	77fd                	lui	a5,0xfffff
ffffffffc0200f0c:	9622                	add	a2,a2,s0
ffffffffc0200f0e:	962e                	add	a2,a2,a1
ffffffffc0200f10:	f426                	sd	s1,40(sp)
ffffffffc0200f12:	fc06                	sd	ra,56(sp)
ffffffffc0200f14:	00f5f4b3          	and	s1,a1,a5
ffffffffc0200f18:	f04a                	sd	s2,32(sp)
ffffffffc0200f1a:	ec4e                	sd	s3,24(sp)
ffffffffc0200f1c:	e852                	sd	s4,16(sp)
ffffffffc0200f1e:	e456                	sd	s5,8(sp)
ffffffffc0200f20:	002005b7          	lui	a1,0x200
ffffffffc0200f24:	00f67433          	and	s0,a2,a5
ffffffffc0200f28:	06b4e363          	bltu	s1,a1,ffffffffc0200f8e <mm_map+0x8c>
ffffffffc0200f2c:	0684f163          	bgeu	s1,s0,ffffffffc0200f8e <mm_map+0x8c>
ffffffffc0200f30:	4785                	li	a5,1
ffffffffc0200f32:	07fe                	slli	a5,a5,0x1f
ffffffffc0200f34:	0487ed63          	bltu	a5,s0,ffffffffc0200f8e <mm_map+0x8c>
ffffffffc0200f38:	89aa                	mv	s3,a0
ffffffffc0200f3a:	cd21                	beqz	a0,ffffffffc0200f92 <mm_map+0x90>
ffffffffc0200f3c:	85a6                	mv	a1,s1
ffffffffc0200f3e:	8ab6                	mv	s5,a3
ffffffffc0200f40:	8a3a                	mv	s4,a4
ffffffffc0200f42:	e5fff0ef          	jal	ra,ffffffffc0200da0 <find_vma>
ffffffffc0200f46:	c501                	beqz	a0,ffffffffc0200f4e <mm_map+0x4c>
ffffffffc0200f48:	651c                	ld	a5,8(a0)
ffffffffc0200f4a:	0487e263          	bltu	a5,s0,ffffffffc0200f8e <mm_map+0x8c>
ffffffffc0200f4e:	03000513          	li	a0,48
ffffffffc0200f52:	0f7000ef          	jal	ra,ffffffffc0201848 <kmalloc>
ffffffffc0200f56:	892a                	mv	s2,a0
ffffffffc0200f58:	5571                	li	a0,-4
ffffffffc0200f5a:	02090163          	beqz	s2,ffffffffc0200f7c <mm_map+0x7a>
ffffffffc0200f5e:	854e                	mv	a0,s3
ffffffffc0200f60:	00993423          	sd	s1,8(s2)
ffffffffc0200f64:	00893823          	sd	s0,16(s2)
ffffffffc0200f68:	01592c23          	sw	s5,24(s2)
ffffffffc0200f6c:	85ca                	mv	a1,s2
ffffffffc0200f6e:	e73ff0ef          	jal	ra,ffffffffc0200de0 <insert_vma_struct>
ffffffffc0200f72:	4501                	li	a0,0
ffffffffc0200f74:	000a0463          	beqz	s4,ffffffffc0200f7c <mm_map+0x7a>
ffffffffc0200f78:	012a3023          	sd	s2,0(s4)
ffffffffc0200f7c:	70e2                	ld	ra,56(sp)
ffffffffc0200f7e:	7442                	ld	s0,48(sp)
ffffffffc0200f80:	74a2                	ld	s1,40(sp)
ffffffffc0200f82:	7902                	ld	s2,32(sp)
ffffffffc0200f84:	69e2                	ld	s3,24(sp)
ffffffffc0200f86:	6a42                	ld	s4,16(sp)
ffffffffc0200f88:	6aa2                	ld	s5,8(sp)
ffffffffc0200f8a:	6121                	addi	sp,sp,64
ffffffffc0200f8c:	8082                	ret
ffffffffc0200f8e:	5575                	li	a0,-3
ffffffffc0200f90:	b7f5                	j	ffffffffc0200f7c <mm_map+0x7a>
ffffffffc0200f92:	00008697          	auipc	a3,0x8
ffffffffc0200f96:	a0e68693          	addi	a3,a3,-1522 # ffffffffc02089a0 <commands+0x7a8>
ffffffffc0200f9a:	00007617          	auipc	a2,0x7
ffffffffc0200f9e:	66e60613          	addi	a2,a2,1646 # ffffffffc0208608 <commands+0x410>
ffffffffc0200fa2:	0a700593          	li	a1,167
ffffffffc0200fa6:	00008517          	auipc	a0,0x8
ffffffffc0200faa:	97250513          	addi	a0,a0,-1678 # ffffffffc0208918 <commands+0x720>
ffffffffc0200fae:	a5aff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0200fb2 <dup_mmap>:
ffffffffc0200fb2:	7139                	addi	sp,sp,-64
ffffffffc0200fb4:	fc06                	sd	ra,56(sp)
ffffffffc0200fb6:	f822                	sd	s0,48(sp)
ffffffffc0200fb8:	f426                	sd	s1,40(sp)
ffffffffc0200fba:	f04a                	sd	s2,32(sp)
ffffffffc0200fbc:	ec4e                	sd	s3,24(sp)
ffffffffc0200fbe:	e852                	sd	s4,16(sp)
ffffffffc0200fc0:	e456                	sd	s5,8(sp)
ffffffffc0200fc2:	c52d                	beqz	a0,ffffffffc020102c <dup_mmap+0x7a>
ffffffffc0200fc4:	892a                	mv	s2,a0
ffffffffc0200fc6:	84ae                	mv	s1,a1
ffffffffc0200fc8:	842e                	mv	s0,a1
ffffffffc0200fca:	e595                	bnez	a1,ffffffffc0200ff6 <dup_mmap+0x44>
ffffffffc0200fcc:	a085                	j	ffffffffc020102c <dup_mmap+0x7a>
ffffffffc0200fce:	854a                	mv	a0,s2
ffffffffc0200fd0:	0155b423          	sd	s5,8(a1) # 200008 <kern_entry-0xffffffffbffffff8>
ffffffffc0200fd4:	0145b823          	sd	s4,16(a1)
ffffffffc0200fd8:	0135ac23          	sw	s3,24(a1)
ffffffffc0200fdc:	e05ff0ef          	jal	ra,ffffffffc0200de0 <insert_vma_struct>
ffffffffc0200fe0:	ff043683          	ld	a3,-16(s0) # ff0 <kern_entry-0xffffffffc01ff010>
ffffffffc0200fe4:	fe843603          	ld	a2,-24(s0)
ffffffffc0200fe8:	6c8c                	ld	a1,24(s1)
ffffffffc0200fea:	01893503          	ld	a0,24(s2)
ffffffffc0200fee:	4701                	li	a4,0
ffffffffc0200ff0:	5f5010ef          	jal	ra,ffffffffc0202de4 <copy_range>
ffffffffc0200ff4:	e105                	bnez	a0,ffffffffc0201014 <dup_mmap+0x62>
ffffffffc0200ff6:	6000                	ld	s0,0(s0)
ffffffffc0200ff8:	02848863          	beq	s1,s0,ffffffffc0201028 <dup_mmap+0x76>
ffffffffc0200ffc:	03000513          	li	a0,48
ffffffffc0201000:	fe843a83          	ld	s5,-24(s0)
ffffffffc0201004:	ff043a03          	ld	s4,-16(s0)
ffffffffc0201008:	ff842983          	lw	s3,-8(s0)
ffffffffc020100c:	03d000ef          	jal	ra,ffffffffc0201848 <kmalloc>
ffffffffc0201010:	85aa                	mv	a1,a0
ffffffffc0201012:	fd55                	bnez	a0,ffffffffc0200fce <dup_mmap+0x1c>
ffffffffc0201014:	5571                	li	a0,-4
ffffffffc0201016:	70e2                	ld	ra,56(sp)
ffffffffc0201018:	7442                	ld	s0,48(sp)
ffffffffc020101a:	74a2                	ld	s1,40(sp)
ffffffffc020101c:	7902                	ld	s2,32(sp)
ffffffffc020101e:	69e2                	ld	s3,24(sp)
ffffffffc0201020:	6a42                	ld	s4,16(sp)
ffffffffc0201022:	6aa2                	ld	s5,8(sp)
ffffffffc0201024:	6121                	addi	sp,sp,64
ffffffffc0201026:	8082                	ret
ffffffffc0201028:	4501                	li	a0,0
ffffffffc020102a:	b7f5                	j	ffffffffc0201016 <dup_mmap+0x64>
ffffffffc020102c:	00008697          	auipc	a3,0x8
ffffffffc0201030:	98468693          	addi	a3,a3,-1660 # ffffffffc02089b0 <commands+0x7b8>
ffffffffc0201034:	00007617          	auipc	a2,0x7
ffffffffc0201038:	5d460613          	addi	a2,a2,1492 # ffffffffc0208608 <commands+0x410>
ffffffffc020103c:	0c000593          	li	a1,192
ffffffffc0201040:	00008517          	auipc	a0,0x8
ffffffffc0201044:	8d850513          	addi	a0,a0,-1832 # ffffffffc0208918 <commands+0x720>
ffffffffc0201048:	9c0ff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020104c <exit_mmap>:
ffffffffc020104c:	1101                	addi	sp,sp,-32
ffffffffc020104e:	ec06                	sd	ra,24(sp)
ffffffffc0201050:	e822                	sd	s0,16(sp)
ffffffffc0201052:	e426                	sd	s1,8(sp)
ffffffffc0201054:	e04a                	sd	s2,0(sp)
ffffffffc0201056:	c531                	beqz	a0,ffffffffc02010a2 <exit_mmap+0x56>
ffffffffc0201058:	591c                	lw	a5,48(a0)
ffffffffc020105a:	84aa                	mv	s1,a0
ffffffffc020105c:	e3b9                	bnez	a5,ffffffffc02010a2 <exit_mmap+0x56>
ffffffffc020105e:	6500                	ld	s0,8(a0)
ffffffffc0201060:	01853903          	ld	s2,24(a0)
ffffffffc0201064:	02850663          	beq	a0,s0,ffffffffc0201090 <exit_mmap+0x44>
ffffffffc0201068:	ff043603          	ld	a2,-16(s0)
ffffffffc020106c:	fe843583          	ld	a1,-24(s0)
ffffffffc0201070:	854a                	mv	a0,s2
ffffffffc0201072:	2a3010ef          	jal	ra,ffffffffc0202b14 <unmap_range>
ffffffffc0201076:	6400                	ld	s0,8(s0)
ffffffffc0201078:	fe8498e3          	bne	s1,s0,ffffffffc0201068 <exit_mmap+0x1c>
ffffffffc020107c:	6400                	ld	s0,8(s0)
ffffffffc020107e:	00848c63          	beq	s1,s0,ffffffffc0201096 <exit_mmap+0x4a>
ffffffffc0201082:	ff043603          	ld	a2,-16(s0)
ffffffffc0201086:	fe843583          	ld	a1,-24(s0)
ffffffffc020108a:	854a                	mv	a0,s2
ffffffffc020108c:	39f010ef          	jal	ra,ffffffffc0202c2a <exit_range>
ffffffffc0201090:	6400                	ld	s0,8(s0)
ffffffffc0201092:	fe8498e3          	bne	s1,s0,ffffffffc0201082 <exit_mmap+0x36>
ffffffffc0201096:	60e2                	ld	ra,24(sp)
ffffffffc0201098:	6442                	ld	s0,16(sp)
ffffffffc020109a:	64a2                	ld	s1,8(sp)
ffffffffc020109c:	6902                	ld	s2,0(sp)
ffffffffc020109e:	6105                	addi	sp,sp,32
ffffffffc02010a0:	8082                	ret
ffffffffc02010a2:	00008697          	auipc	a3,0x8
ffffffffc02010a6:	92e68693          	addi	a3,a3,-1746 # ffffffffc02089d0 <commands+0x7d8>
ffffffffc02010aa:	00007617          	auipc	a2,0x7
ffffffffc02010ae:	55e60613          	addi	a2,a2,1374 # ffffffffc0208608 <commands+0x410>
ffffffffc02010b2:	0d600593          	li	a1,214
ffffffffc02010b6:	00008517          	auipc	a0,0x8
ffffffffc02010ba:	86250513          	addi	a0,a0,-1950 # ffffffffc0208918 <commands+0x720>
ffffffffc02010be:	94aff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02010c2 <vmm_init>:
ffffffffc02010c2:	8082                	ret

ffffffffc02010c4 <do_pgfault>:
ffffffffc02010c4:	7139                	addi	sp,sp,-64
ffffffffc02010c6:	85b2                	mv	a1,a2
ffffffffc02010c8:	f822                	sd	s0,48(sp)
ffffffffc02010ca:	f426                	sd	s1,40(sp)
ffffffffc02010cc:	fc06                	sd	ra,56(sp)
ffffffffc02010ce:	f04a                	sd	s2,32(sp)
ffffffffc02010d0:	ec4e                	sd	s3,24(sp)
ffffffffc02010d2:	8432                	mv	s0,a2
ffffffffc02010d4:	84aa                	mv	s1,a0
ffffffffc02010d6:	ccbff0ef          	jal	ra,ffffffffc0200da0 <find_vma>
ffffffffc02010da:	00018797          	auipc	a5,0x18
ffffffffc02010de:	3ee7a783          	lw	a5,1006(a5) # ffffffffc02194c8 <pgfault_num>
ffffffffc02010e2:	2785                	addiw	a5,a5,1
ffffffffc02010e4:	00018717          	auipc	a4,0x18
ffffffffc02010e8:	3ef72223          	sw	a5,996(a4) # ffffffffc02194c8 <pgfault_num>
ffffffffc02010ec:	c545                	beqz	a0,ffffffffc0201194 <do_pgfault+0xd0>
ffffffffc02010ee:	651c                	ld	a5,8(a0)
ffffffffc02010f0:	0af46263          	bltu	s0,a5,ffffffffc0201194 <do_pgfault+0xd0>
ffffffffc02010f4:	4d1c                	lw	a5,24(a0)
ffffffffc02010f6:	49c1                	li	s3,16
ffffffffc02010f8:	8b89                	andi	a5,a5,2
ffffffffc02010fa:	efb1                	bnez	a5,ffffffffc0201156 <do_pgfault+0x92>
ffffffffc02010fc:	75fd                	lui	a1,0xfffff
ffffffffc02010fe:	6c88                	ld	a0,24(s1)
ffffffffc0201100:	8c6d                	and	s0,s0,a1
ffffffffc0201102:	4605                	li	a2,1
ffffffffc0201104:	85a2                	mv	a1,s0
ffffffffc0201106:	03d010ef          	jal	ra,ffffffffc0202942 <get_pte>
ffffffffc020110a:	c555                	beqz	a0,ffffffffc02011b6 <do_pgfault+0xf2>
ffffffffc020110c:	610c                	ld	a1,0(a0)
ffffffffc020110e:	c5a5                	beqz	a1,ffffffffc0201176 <do_pgfault+0xb2>
ffffffffc0201110:	00018797          	auipc	a5,0x18
ffffffffc0201114:	3d07a783          	lw	a5,976(a5) # ffffffffc02194e0 <swap_init_ok>
ffffffffc0201118:	c7d9                	beqz	a5,ffffffffc02011a6 <do_pgfault+0xe2>
ffffffffc020111a:	0030                	addi	a2,sp,8
ffffffffc020111c:	85a2                	mv	a1,s0
ffffffffc020111e:	8526                	mv	a0,s1
ffffffffc0201120:	e402                	sd	zero,8(sp)
ffffffffc0201122:	283000ef          	jal	ra,ffffffffc0201ba4 <swap_in>
ffffffffc0201126:	892a                	mv	s2,a0
ffffffffc0201128:	e90d                	bnez	a0,ffffffffc020115a <do_pgfault+0x96>
ffffffffc020112a:	65a2                	ld	a1,8(sp)
ffffffffc020112c:	6c88                	ld	a0,24(s1)
ffffffffc020112e:	86ce                	mv	a3,s3
ffffffffc0201130:	8622                	mv	a2,s0
ffffffffc0201132:	3f7010ef          	jal	ra,ffffffffc0202d28 <page_insert>
ffffffffc0201136:	6622                	ld	a2,8(sp)
ffffffffc0201138:	4685                	li	a3,1
ffffffffc020113a:	85a2                	mv	a1,s0
ffffffffc020113c:	8526                	mv	a0,s1
ffffffffc020113e:	145000ef          	jal	ra,ffffffffc0201a82 <swap_map_swappable>
ffffffffc0201142:	67a2                	ld	a5,8(sp)
ffffffffc0201144:	ff80                	sd	s0,56(a5)
ffffffffc0201146:	70e2                	ld	ra,56(sp)
ffffffffc0201148:	7442                	ld	s0,48(sp)
ffffffffc020114a:	74a2                	ld	s1,40(sp)
ffffffffc020114c:	69e2                	ld	s3,24(sp)
ffffffffc020114e:	854a                	mv	a0,s2
ffffffffc0201150:	7902                	ld	s2,32(sp)
ffffffffc0201152:	6121                	addi	sp,sp,64
ffffffffc0201154:	8082                	ret
ffffffffc0201156:	49dd                	li	s3,23
ffffffffc0201158:	b755                	j	ffffffffc02010fc <do_pgfault+0x38>
ffffffffc020115a:	00008517          	auipc	a0,0x8
ffffffffc020115e:	90e50513          	addi	a0,a0,-1778 # ffffffffc0208a68 <commands+0x870>
ffffffffc0201162:	f6bfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201166:	70e2                	ld	ra,56(sp)
ffffffffc0201168:	7442                	ld	s0,48(sp)
ffffffffc020116a:	74a2                	ld	s1,40(sp)
ffffffffc020116c:	69e2                	ld	s3,24(sp)
ffffffffc020116e:	854a                	mv	a0,s2
ffffffffc0201170:	7902                	ld	s2,32(sp)
ffffffffc0201172:	6121                	addi	sp,sp,64
ffffffffc0201174:	8082                	ret
ffffffffc0201176:	6c88                	ld	a0,24(s1)
ffffffffc0201178:	864e                	mv	a2,s3
ffffffffc020117a:	85a2                	mv	a1,s0
ffffffffc020117c:	69f010ef          	jal	ra,ffffffffc020301a <pgdir_alloc_page>
ffffffffc0201180:	4901                	li	s2,0
ffffffffc0201182:	f171                	bnez	a0,ffffffffc0201146 <do_pgfault+0x82>
ffffffffc0201184:	00008517          	auipc	a0,0x8
ffffffffc0201188:	8bc50513          	addi	a0,a0,-1860 # ffffffffc0208a40 <commands+0x848>
ffffffffc020118c:	f41fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201190:	5971                	li	s2,-4
ffffffffc0201192:	bf55                	j	ffffffffc0201146 <do_pgfault+0x82>
ffffffffc0201194:	85a2                	mv	a1,s0
ffffffffc0201196:	00008517          	auipc	a0,0x8
ffffffffc020119a:	85a50513          	addi	a0,a0,-1958 # ffffffffc02089f0 <commands+0x7f8>
ffffffffc020119e:	f2ffe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02011a2:	5975                	li	s2,-3
ffffffffc02011a4:	b74d                	j	ffffffffc0201146 <do_pgfault+0x82>
ffffffffc02011a6:	00008517          	auipc	a0,0x8
ffffffffc02011aa:	8e250513          	addi	a0,a0,-1822 # ffffffffc0208a88 <commands+0x890>
ffffffffc02011ae:	f1ffe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02011b2:	5971                	li	s2,-4
ffffffffc02011b4:	bf49                	j	ffffffffc0201146 <do_pgfault+0x82>
ffffffffc02011b6:	00008517          	auipc	a0,0x8
ffffffffc02011ba:	86a50513          	addi	a0,a0,-1942 # ffffffffc0208a20 <commands+0x828>
ffffffffc02011be:	f0ffe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02011c2:	5971                	li	s2,-4
ffffffffc02011c4:	b749                	j	ffffffffc0201146 <do_pgfault+0x82>

ffffffffc02011c6 <user_mem_check>:
ffffffffc02011c6:	7179                	addi	sp,sp,-48
ffffffffc02011c8:	f022                	sd	s0,32(sp)
ffffffffc02011ca:	f406                	sd	ra,40(sp)
ffffffffc02011cc:	ec26                	sd	s1,24(sp)
ffffffffc02011ce:	e84a                	sd	s2,16(sp)
ffffffffc02011d0:	e44e                	sd	s3,8(sp)
ffffffffc02011d2:	e052                	sd	s4,0(sp)
ffffffffc02011d4:	842e                	mv	s0,a1
ffffffffc02011d6:	c135                	beqz	a0,ffffffffc020123a <user_mem_check+0x74>
ffffffffc02011d8:	002007b7          	lui	a5,0x200
ffffffffc02011dc:	04f5e663          	bltu	a1,a5,ffffffffc0201228 <user_mem_check+0x62>
ffffffffc02011e0:	00c584b3          	add	s1,a1,a2
ffffffffc02011e4:	0495f263          	bgeu	a1,s1,ffffffffc0201228 <user_mem_check+0x62>
ffffffffc02011e8:	4785                	li	a5,1
ffffffffc02011ea:	07fe                	slli	a5,a5,0x1f
ffffffffc02011ec:	0297ee63          	bltu	a5,s1,ffffffffc0201228 <user_mem_check+0x62>
ffffffffc02011f0:	892a                	mv	s2,a0
ffffffffc02011f2:	89b6                	mv	s3,a3
ffffffffc02011f4:	6a05                	lui	s4,0x1
ffffffffc02011f6:	a821                	j	ffffffffc020120e <user_mem_check+0x48>
ffffffffc02011f8:	0027f693          	andi	a3,a5,2
ffffffffc02011fc:	9752                	add	a4,a4,s4
ffffffffc02011fe:	8ba1                	andi	a5,a5,8
ffffffffc0201200:	c685                	beqz	a3,ffffffffc0201228 <user_mem_check+0x62>
ffffffffc0201202:	c399                	beqz	a5,ffffffffc0201208 <user_mem_check+0x42>
ffffffffc0201204:	02e46263          	bltu	s0,a4,ffffffffc0201228 <user_mem_check+0x62>
ffffffffc0201208:	6900                	ld	s0,16(a0)
ffffffffc020120a:	04947663          	bgeu	s0,s1,ffffffffc0201256 <user_mem_check+0x90>
ffffffffc020120e:	85a2                	mv	a1,s0
ffffffffc0201210:	854a                	mv	a0,s2
ffffffffc0201212:	b8fff0ef          	jal	ra,ffffffffc0200da0 <find_vma>
ffffffffc0201216:	c909                	beqz	a0,ffffffffc0201228 <user_mem_check+0x62>
ffffffffc0201218:	6518                	ld	a4,8(a0)
ffffffffc020121a:	00e46763          	bltu	s0,a4,ffffffffc0201228 <user_mem_check+0x62>
ffffffffc020121e:	4d1c                	lw	a5,24(a0)
ffffffffc0201220:	fc099ce3          	bnez	s3,ffffffffc02011f8 <user_mem_check+0x32>
ffffffffc0201224:	8b85                	andi	a5,a5,1
ffffffffc0201226:	f3ed                	bnez	a5,ffffffffc0201208 <user_mem_check+0x42>
ffffffffc0201228:	4501                	li	a0,0
ffffffffc020122a:	70a2                	ld	ra,40(sp)
ffffffffc020122c:	7402                	ld	s0,32(sp)
ffffffffc020122e:	64e2                	ld	s1,24(sp)
ffffffffc0201230:	6942                	ld	s2,16(sp)
ffffffffc0201232:	69a2                	ld	s3,8(sp)
ffffffffc0201234:	6a02                	ld	s4,0(sp)
ffffffffc0201236:	6145                	addi	sp,sp,48
ffffffffc0201238:	8082                	ret
ffffffffc020123a:	c02007b7          	lui	a5,0xc0200
ffffffffc020123e:	4501                	li	a0,0
ffffffffc0201240:	fef5e5e3          	bltu	a1,a5,ffffffffc020122a <user_mem_check+0x64>
ffffffffc0201244:	962e                	add	a2,a2,a1
ffffffffc0201246:	fec5f2e3          	bgeu	a1,a2,ffffffffc020122a <user_mem_check+0x64>
ffffffffc020124a:	c8000537          	lui	a0,0xc8000
ffffffffc020124e:	0505                	addi	a0,a0,1
ffffffffc0201250:	00a63533          	sltu	a0,a2,a0
ffffffffc0201254:	bfd9                	j	ffffffffc020122a <user_mem_check+0x64>
ffffffffc0201256:	4505                	li	a0,1
ffffffffc0201258:	bfc9                	j	ffffffffc020122a <user_mem_check+0x64>

ffffffffc020125a <_fifo_init_mm>:
ffffffffc020125a:	00018797          	auipc	a5,0x18
ffffffffc020125e:	2de78793          	addi	a5,a5,734 # ffffffffc0219538 <pra_list_head>
ffffffffc0201262:	f51c                	sd	a5,40(a0)
ffffffffc0201264:	e79c                	sd	a5,8(a5)
ffffffffc0201266:	e39c                	sd	a5,0(a5)
ffffffffc0201268:	4501                	li	a0,0
ffffffffc020126a:	8082                	ret

ffffffffc020126c <_fifo_init>:
ffffffffc020126c:	4501                	li	a0,0
ffffffffc020126e:	8082                	ret

ffffffffc0201270 <_fifo_set_unswappable>:
ffffffffc0201270:	4501                	li	a0,0
ffffffffc0201272:	8082                	ret

ffffffffc0201274 <_fifo_tick_event>:
ffffffffc0201274:	4501                	li	a0,0
ffffffffc0201276:	8082                	ret

ffffffffc0201278 <_fifo_check_swap>:
ffffffffc0201278:	711d                	addi	sp,sp,-96
ffffffffc020127a:	fc4e                	sd	s3,56(sp)
ffffffffc020127c:	f852                	sd	s4,48(sp)
ffffffffc020127e:	00008517          	auipc	a0,0x8
ffffffffc0201282:	83250513          	addi	a0,a0,-1998 # ffffffffc0208ab0 <commands+0x8b8>
ffffffffc0201286:	698d                	lui	s3,0x3
ffffffffc0201288:	4a31                	li	s4,12
ffffffffc020128a:	e0ca                	sd	s2,64(sp)
ffffffffc020128c:	ec86                	sd	ra,88(sp)
ffffffffc020128e:	e8a2                	sd	s0,80(sp)
ffffffffc0201290:	e4a6                	sd	s1,72(sp)
ffffffffc0201292:	f456                	sd	s5,40(sp)
ffffffffc0201294:	f05a                	sd	s6,32(sp)
ffffffffc0201296:	ec5e                	sd	s7,24(sp)
ffffffffc0201298:	e862                	sd	s8,16(sp)
ffffffffc020129a:	e466                	sd	s9,8(sp)
ffffffffc020129c:	e06a                	sd	s10,0(sp)
ffffffffc020129e:	e2ffe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02012a2:	01498023          	sb	s4,0(s3) # 3000 <kern_entry-0xffffffffc01fd000>
ffffffffc02012a6:	00018917          	auipc	s2,0x18
ffffffffc02012aa:	22292903          	lw	s2,546(s2) # ffffffffc02194c8 <pgfault_num>
ffffffffc02012ae:	4791                	li	a5,4
ffffffffc02012b0:	14f91e63          	bne	s2,a5,ffffffffc020140c <_fifo_check_swap+0x194>
ffffffffc02012b4:	00008517          	auipc	a0,0x8
ffffffffc02012b8:	84c50513          	addi	a0,a0,-1972 # ffffffffc0208b00 <commands+0x908>
ffffffffc02012bc:	6a85                	lui	s5,0x1
ffffffffc02012be:	4b29                	li	s6,10
ffffffffc02012c0:	e0dfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02012c4:	00018417          	auipc	s0,0x18
ffffffffc02012c8:	20440413          	addi	s0,s0,516 # ffffffffc02194c8 <pgfault_num>
ffffffffc02012cc:	016a8023          	sb	s6,0(s5) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc02012d0:	4004                	lw	s1,0(s0)
ffffffffc02012d2:	2481                	sext.w	s1,s1
ffffffffc02012d4:	2b249c63          	bne	s1,s2,ffffffffc020158c <_fifo_check_swap+0x314>
ffffffffc02012d8:	00008517          	auipc	a0,0x8
ffffffffc02012dc:	85050513          	addi	a0,a0,-1968 # ffffffffc0208b28 <commands+0x930>
ffffffffc02012e0:	6b91                	lui	s7,0x4
ffffffffc02012e2:	4c35                	li	s8,13
ffffffffc02012e4:	de9fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02012e8:	018b8023          	sb	s8,0(s7) # 4000 <kern_entry-0xffffffffc01fc000>
ffffffffc02012ec:	00042903          	lw	s2,0(s0)
ffffffffc02012f0:	2901                	sext.w	s2,s2
ffffffffc02012f2:	26991d63          	bne	s2,s1,ffffffffc020156c <_fifo_check_swap+0x2f4>
ffffffffc02012f6:	00008517          	auipc	a0,0x8
ffffffffc02012fa:	85a50513          	addi	a0,a0,-1958 # ffffffffc0208b50 <commands+0x958>
ffffffffc02012fe:	6c89                	lui	s9,0x2
ffffffffc0201300:	4d2d                	li	s10,11
ffffffffc0201302:	dcbfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201306:	01ac8023          	sb	s10,0(s9) # 2000 <kern_entry-0xffffffffc01fe000>
ffffffffc020130a:	401c                	lw	a5,0(s0)
ffffffffc020130c:	2781                	sext.w	a5,a5
ffffffffc020130e:	23279f63          	bne	a5,s2,ffffffffc020154c <_fifo_check_swap+0x2d4>
ffffffffc0201312:	00008517          	auipc	a0,0x8
ffffffffc0201316:	86650513          	addi	a0,a0,-1946 # ffffffffc0208b78 <commands+0x980>
ffffffffc020131a:	db3fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020131e:	6795                	lui	a5,0x5
ffffffffc0201320:	4739                	li	a4,14
ffffffffc0201322:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc0201326:	4004                	lw	s1,0(s0)
ffffffffc0201328:	4795                	li	a5,5
ffffffffc020132a:	2481                	sext.w	s1,s1
ffffffffc020132c:	20f49063          	bne	s1,a5,ffffffffc020152c <_fifo_check_swap+0x2b4>
ffffffffc0201330:	00008517          	auipc	a0,0x8
ffffffffc0201334:	82050513          	addi	a0,a0,-2016 # ffffffffc0208b50 <commands+0x958>
ffffffffc0201338:	d95fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020133c:	01ac8023          	sb	s10,0(s9)
ffffffffc0201340:	401c                	lw	a5,0(s0)
ffffffffc0201342:	2781                	sext.w	a5,a5
ffffffffc0201344:	1c979463          	bne	a5,s1,ffffffffc020150c <_fifo_check_swap+0x294>
ffffffffc0201348:	00007517          	auipc	a0,0x7
ffffffffc020134c:	7b850513          	addi	a0,a0,1976 # ffffffffc0208b00 <commands+0x908>
ffffffffc0201350:	d7dfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201354:	016a8023          	sb	s6,0(s5)
ffffffffc0201358:	401c                	lw	a5,0(s0)
ffffffffc020135a:	4719                	li	a4,6
ffffffffc020135c:	2781                	sext.w	a5,a5
ffffffffc020135e:	18e79763          	bne	a5,a4,ffffffffc02014ec <_fifo_check_swap+0x274>
ffffffffc0201362:	00007517          	auipc	a0,0x7
ffffffffc0201366:	7ee50513          	addi	a0,a0,2030 # ffffffffc0208b50 <commands+0x958>
ffffffffc020136a:	d63fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020136e:	01ac8023          	sb	s10,0(s9)
ffffffffc0201372:	401c                	lw	a5,0(s0)
ffffffffc0201374:	471d                	li	a4,7
ffffffffc0201376:	2781                	sext.w	a5,a5
ffffffffc0201378:	14e79a63          	bne	a5,a4,ffffffffc02014cc <_fifo_check_swap+0x254>
ffffffffc020137c:	00007517          	auipc	a0,0x7
ffffffffc0201380:	73450513          	addi	a0,a0,1844 # ffffffffc0208ab0 <commands+0x8b8>
ffffffffc0201384:	d49fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201388:	01498023          	sb	s4,0(s3)
ffffffffc020138c:	401c                	lw	a5,0(s0)
ffffffffc020138e:	4721                	li	a4,8
ffffffffc0201390:	2781                	sext.w	a5,a5
ffffffffc0201392:	10e79d63          	bne	a5,a4,ffffffffc02014ac <_fifo_check_swap+0x234>
ffffffffc0201396:	00007517          	auipc	a0,0x7
ffffffffc020139a:	79250513          	addi	a0,a0,1938 # ffffffffc0208b28 <commands+0x930>
ffffffffc020139e:	d2ffe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02013a2:	018b8023          	sb	s8,0(s7)
ffffffffc02013a6:	401c                	lw	a5,0(s0)
ffffffffc02013a8:	4725                	li	a4,9
ffffffffc02013aa:	2781                	sext.w	a5,a5
ffffffffc02013ac:	0ee79063          	bne	a5,a4,ffffffffc020148c <_fifo_check_swap+0x214>
ffffffffc02013b0:	00007517          	auipc	a0,0x7
ffffffffc02013b4:	7c850513          	addi	a0,a0,1992 # ffffffffc0208b78 <commands+0x980>
ffffffffc02013b8:	d15fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02013bc:	6795                	lui	a5,0x5
ffffffffc02013be:	4739                	li	a4,14
ffffffffc02013c0:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc02013c4:	4004                	lw	s1,0(s0)
ffffffffc02013c6:	47a9                	li	a5,10
ffffffffc02013c8:	2481                	sext.w	s1,s1
ffffffffc02013ca:	0af49163          	bne	s1,a5,ffffffffc020146c <_fifo_check_swap+0x1f4>
ffffffffc02013ce:	00007517          	auipc	a0,0x7
ffffffffc02013d2:	73250513          	addi	a0,a0,1842 # ffffffffc0208b00 <commands+0x908>
ffffffffc02013d6:	cf7fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02013da:	6785                	lui	a5,0x1
ffffffffc02013dc:	0007c783          	lbu	a5,0(a5) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc02013e0:	06979663          	bne	a5,s1,ffffffffc020144c <_fifo_check_swap+0x1d4>
ffffffffc02013e4:	401c                	lw	a5,0(s0)
ffffffffc02013e6:	472d                	li	a4,11
ffffffffc02013e8:	2781                	sext.w	a5,a5
ffffffffc02013ea:	04e79163          	bne	a5,a4,ffffffffc020142c <_fifo_check_swap+0x1b4>
ffffffffc02013ee:	60e6                	ld	ra,88(sp)
ffffffffc02013f0:	6446                	ld	s0,80(sp)
ffffffffc02013f2:	64a6                	ld	s1,72(sp)
ffffffffc02013f4:	6906                	ld	s2,64(sp)
ffffffffc02013f6:	79e2                	ld	s3,56(sp)
ffffffffc02013f8:	7a42                	ld	s4,48(sp)
ffffffffc02013fa:	7aa2                	ld	s5,40(sp)
ffffffffc02013fc:	7b02                	ld	s6,32(sp)
ffffffffc02013fe:	6be2                	ld	s7,24(sp)
ffffffffc0201400:	6c42                	ld	s8,16(sp)
ffffffffc0201402:	6ca2                	ld	s9,8(sp)
ffffffffc0201404:	6d02                	ld	s10,0(sp)
ffffffffc0201406:	4501                	li	a0,0
ffffffffc0201408:	6125                	addi	sp,sp,96
ffffffffc020140a:	8082                	ret
ffffffffc020140c:	00007697          	auipc	a3,0x7
ffffffffc0201410:	6cc68693          	addi	a3,a3,1740 # ffffffffc0208ad8 <commands+0x8e0>
ffffffffc0201414:	00007617          	auipc	a2,0x7
ffffffffc0201418:	1f460613          	addi	a2,a2,500 # ffffffffc0208608 <commands+0x410>
ffffffffc020141c:	05100593          	li	a1,81
ffffffffc0201420:	00007517          	auipc	a0,0x7
ffffffffc0201424:	6c850513          	addi	a0,a0,1736 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc0201428:	de1fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020142c:	00007697          	auipc	a3,0x7
ffffffffc0201430:	7fc68693          	addi	a3,a3,2044 # ffffffffc0208c28 <commands+0xa30>
ffffffffc0201434:	00007617          	auipc	a2,0x7
ffffffffc0201438:	1d460613          	addi	a2,a2,468 # ffffffffc0208608 <commands+0x410>
ffffffffc020143c:	07300593          	li	a1,115
ffffffffc0201440:	00007517          	auipc	a0,0x7
ffffffffc0201444:	6a850513          	addi	a0,a0,1704 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc0201448:	dc1fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020144c:	00007697          	auipc	a3,0x7
ffffffffc0201450:	7b468693          	addi	a3,a3,1972 # ffffffffc0208c00 <commands+0xa08>
ffffffffc0201454:	00007617          	auipc	a2,0x7
ffffffffc0201458:	1b460613          	addi	a2,a2,436 # ffffffffc0208608 <commands+0x410>
ffffffffc020145c:	07100593          	li	a1,113
ffffffffc0201460:	00007517          	auipc	a0,0x7
ffffffffc0201464:	68850513          	addi	a0,a0,1672 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc0201468:	da1fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020146c:	00007697          	auipc	a3,0x7
ffffffffc0201470:	78468693          	addi	a3,a3,1924 # ffffffffc0208bf0 <commands+0x9f8>
ffffffffc0201474:	00007617          	auipc	a2,0x7
ffffffffc0201478:	19460613          	addi	a2,a2,404 # ffffffffc0208608 <commands+0x410>
ffffffffc020147c:	06f00593          	li	a1,111
ffffffffc0201480:	00007517          	auipc	a0,0x7
ffffffffc0201484:	66850513          	addi	a0,a0,1640 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc0201488:	d81fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020148c:	00007697          	auipc	a3,0x7
ffffffffc0201490:	75468693          	addi	a3,a3,1876 # ffffffffc0208be0 <commands+0x9e8>
ffffffffc0201494:	00007617          	auipc	a2,0x7
ffffffffc0201498:	17460613          	addi	a2,a2,372 # ffffffffc0208608 <commands+0x410>
ffffffffc020149c:	06c00593          	li	a1,108
ffffffffc02014a0:	00007517          	auipc	a0,0x7
ffffffffc02014a4:	64850513          	addi	a0,a0,1608 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc02014a8:	d61fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02014ac:	00007697          	auipc	a3,0x7
ffffffffc02014b0:	72468693          	addi	a3,a3,1828 # ffffffffc0208bd0 <commands+0x9d8>
ffffffffc02014b4:	00007617          	auipc	a2,0x7
ffffffffc02014b8:	15460613          	addi	a2,a2,340 # ffffffffc0208608 <commands+0x410>
ffffffffc02014bc:	06900593          	li	a1,105
ffffffffc02014c0:	00007517          	auipc	a0,0x7
ffffffffc02014c4:	62850513          	addi	a0,a0,1576 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc02014c8:	d41fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02014cc:	00007697          	auipc	a3,0x7
ffffffffc02014d0:	6f468693          	addi	a3,a3,1780 # ffffffffc0208bc0 <commands+0x9c8>
ffffffffc02014d4:	00007617          	auipc	a2,0x7
ffffffffc02014d8:	13460613          	addi	a2,a2,308 # ffffffffc0208608 <commands+0x410>
ffffffffc02014dc:	06600593          	li	a1,102
ffffffffc02014e0:	00007517          	auipc	a0,0x7
ffffffffc02014e4:	60850513          	addi	a0,a0,1544 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc02014e8:	d21fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02014ec:	00007697          	auipc	a3,0x7
ffffffffc02014f0:	6c468693          	addi	a3,a3,1732 # ffffffffc0208bb0 <commands+0x9b8>
ffffffffc02014f4:	00007617          	auipc	a2,0x7
ffffffffc02014f8:	11460613          	addi	a2,a2,276 # ffffffffc0208608 <commands+0x410>
ffffffffc02014fc:	06300593          	li	a1,99
ffffffffc0201500:	00007517          	auipc	a0,0x7
ffffffffc0201504:	5e850513          	addi	a0,a0,1512 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc0201508:	d01fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020150c:	00007697          	auipc	a3,0x7
ffffffffc0201510:	69468693          	addi	a3,a3,1684 # ffffffffc0208ba0 <commands+0x9a8>
ffffffffc0201514:	00007617          	auipc	a2,0x7
ffffffffc0201518:	0f460613          	addi	a2,a2,244 # ffffffffc0208608 <commands+0x410>
ffffffffc020151c:	06000593          	li	a1,96
ffffffffc0201520:	00007517          	auipc	a0,0x7
ffffffffc0201524:	5c850513          	addi	a0,a0,1480 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc0201528:	ce1fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020152c:	00007697          	auipc	a3,0x7
ffffffffc0201530:	67468693          	addi	a3,a3,1652 # ffffffffc0208ba0 <commands+0x9a8>
ffffffffc0201534:	00007617          	auipc	a2,0x7
ffffffffc0201538:	0d460613          	addi	a2,a2,212 # ffffffffc0208608 <commands+0x410>
ffffffffc020153c:	05d00593          	li	a1,93
ffffffffc0201540:	00007517          	auipc	a0,0x7
ffffffffc0201544:	5a850513          	addi	a0,a0,1448 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc0201548:	cc1fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020154c:	00007697          	auipc	a3,0x7
ffffffffc0201550:	58c68693          	addi	a3,a3,1420 # ffffffffc0208ad8 <commands+0x8e0>
ffffffffc0201554:	00007617          	auipc	a2,0x7
ffffffffc0201558:	0b460613          	addi	a2,a2,180 # ffffffffc0208608 <commands+0x410>
ffffffffc020155c:	05a00593          	li	a1,90
ffffffffc0201560:	00007517          	auipc	a0,0x7
ffffffffc0201564:	58850513          	addi	a0,a0,1416 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc0201568:	ca1fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020156c:	00007697          	auipc	a3,0x7
ffffffffc0201570:	56c68693          	addi	a3,a3,1388 # ffffffffc0208ad8 <commands+0x8e0>
ffffffffc0201574:	00007617          	auipc	a2,0x7
ffffffffc0201578:	09460613          	addi	a2,a2,148 # ffffffffc0208608 <commands+0x410>
ffffffffc020157c:	05700593          	li	a1,87
ffffffffc0201580:	00007517          	auipc	a0,0x7
ffffffffc0201584:	56850513          	addi	a0,a0,1384 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc0201588:	c81fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020158c:	00007697          	auipc	a3,0x7
ffffffffc0201590:	54c68693          	addi	a3,a3,1356 # ffffffffc0208ad8 <commands+0x8e0>
ffffffffc0201594:	00007617          	auipc	a2,0x7
ffffffffc0201598:	07460613          	addi	a2,a2,116 # ffffffffc0208608 <commands+0x410>
ffffffffc020159c:	05400593          	li	a1,84
ffffffffc02015a0:	00007517          	auipc	a0,0x7
ffffffffc02015a4:	54850513          	addi	a0,a0,1352 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc02015a8:	c61fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02015ac <_fifo_swap_out_victim>:
ffffffffc02015ac:	751c                	ld	a5,40(a0)
ffffffffc02015ae:	1141                	addi	sp,sp,-16
ffffffffc02015b0:	e406                	sd	ra,8(sp)
ffffffffc02015b2:	cf91                	beqz	a5,ffffffffc02015ce <_fifo_swap_out_victim+0x22>
ffffffffc02015b4:	ee0d                	bnez	a2,ffffffffc02015ee <_fifo_swap_out_victim+0x42>
ffffffffc02015b6:	679c                	ld	a5,8(a5)
ffffffffc02015b8:	60a2                	ld	ra,8(sp)
ffffffffc02015ba:	4501                	li	a0,0
ffffffffc02015bc:	6394                	ld	a3,0(a5)
ffffffffc02015be:	6798                	ld	a4,8(a5)
ffffffffc02015c0:	fd878793          	addi	a5,a5,-40
ffffffffc02015c4:	e698                	sd	a4,8(a3)
ffffffffc02015c6:	e314                	sd	a3,0(a4)
ffffffffc02015c8:	e19c                	sd	a5,0(a1)
ffffffffc02015ca:	0141                	addi	sp,sp,16
ffffffffc02015cc:	8082                	ret
ffffffffc02015ce:	00007697          	auipc	a3,0x7
ffffffffc02015d2:	66a68693          	addi	a3,a3,1642 # ffffffffc0208c38 <commands+0xa40>
ffffffffc02015d6:	00007617          	auipc	a2,0x7
ffffffffc02015da:	03260613          	addi	a2,a2,50 # ffffffffc0208608 <commands+0x410>
ffffffffc02015de:	04100593          	li	a1,65
ffffffffc02015e2:	00007517          	auipc	a0,0x7
ffffffffc02015e6:	50650513          	addi	a0,a0,1286 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc02015ea:	c1ffe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02015ee:	00007697          	auipc	a3,0x7
ffffffffc02015f2:	65a68693          	addi	a3,a3,1626 # ffffffffc0208c48 <commands+0xa50>
ffffffffc02015f6:	00007617          	auipc	a2,0x7
ffffffffc02015fa:	01260613          	addi	a2,a2,18 # ffffffffc0208608 <commands+0x410>
ffffffffc02015fe:	04200593          	li	a1,66
ffffffffc0201602:	00007517          	auipc	a0,0x7
ffffffffc0201606:	4e650513          	addi	a0,a0,1254 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc020160a:	bfffe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020160e <_fifo_map_swappable>:
ffffffffc020160e:	751c                	ld	a5,40(a0)
ffffffffc0201610:	cb91                	beqz	a5,ffffffffc0201624 <_fifo_map_swappable+0x16>
ffffffffc0201612:	6394                	ld	a3,0(a5)
ffffffffc0201614:	02860713          	addi	a4,a2,40
ffffffffc0201618:	e398                	sd	a4,0(a5)
ffffffffc020161a:	e698                	sd	a4,8(a3)
ffffffffc020161c:	4501                	li	a0,0
ffffffffc020161e:	fa1c                	sd	a5,48(a2)
ffffffffc0201620:	f614                	sd	a3,40(a2)
ffffffffc0201622:	8082                	ret
ffffffffc0201624:	1141                	addi	sp,sp,-16
ffffffffc0201626:	00007697          	auipc	a3,0x7
ffffffffc020162a:	63268693          	addi	a3,a3,1586 # ffffffffc0208c58 <commands+0xa60>
ffffffffc020162e:	00007617          	auipc	a2,0x7
ffffffffc0201632:	fda60613          	addi	a2,a2,-38 # ffffffffc0208608 <commands+0x410>
ffffffffc0201636:	03200593          	li	a1,50
ffffffffc020163a:	00007517          	auipc	a0,0x7
ffffffffc020163e:	4ae50513          	addi	a0,a0,1198 # ffffffffc0208ae8 <commands+0x8f0>
ffffffffc0201642:	e406                	sd	ra,8(sp)
ffffffffc0201644:	bc5fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201648 <slob_free>:
ffffffffc0201648:	c145                	beqz	a0,ffffffffc02016e8 <slob_free+0xa0>
ffffffffc020164a:	1141                	addi	sp,sp,-16
ffffffffc020164c:	e022                	sd	s0,0(sp)
ffffffffc020164e:	e406                	sd	ra,8(sp)
ffffffffc0201650:	842a                	mv	s0,a0
ffffffffc0201652:	edb1                	bnez	a1,ffffffffc02016ae <slob_free+0x66>
ffffffffc0201654:	100027f3          	csrr	a5,sstatus
ffffffffc0201658:	8b89                	andi	a5,a5,2
ffffffffc020165a:	4501                	li	a0,0
ffffffffc020165c:	e3ad                	bnez	a5,ffffffffc02016be <slob_free+0x76>
ffffffffc020165e:	0000d617          	auipc	a2,0xd
ffffffffc0201662:	a2260613          	addi	a2,a2,-1502 # ffffffffc020e080 <slobfree>
ffffffffc0201666:	621c                	ld	a5,0(a2)
ffffffffc0201668:	6798                	ld	a4,8(a5)
ffffffffc020166a:	0087fa63          	bgeu	a5,s0,ffffffffc020167e <slob_free+0x36>
ffffffffc020166e:	00e46c63          	bltu	s0,a4,ffffffffc0201686 <slob_free+0x3e>
ffffffffc0201672:	00e7fa63          	bgeu	a5,a4,ffffffffc0201686 <slob_free+0x3e>
ffffffffc0201676:	87ba                	mv	a5,a4
ffffffffc0201678:	6798                	ld	a4,8(a5)
ffffffffc020167a:	fe87eae3          	bltu	a5,s0,ffffffffc020166e <slob_free+0x26>
ffffffffc020167e:	fee7ece3          	bltu	a5,a4,ffffffffc0201676 <slob_free+0x2e>
ffffffffc0201682:	fee47ae3          	bgeu	s0,a4,ffffffffc0201676 <slob_free+0x2e>
ffffffffc0201686:	400c                	lw	a1,0(s0)
ffffffffc0201688:	00459693          	slli	a3,a1,0x4
ffffffffc020168c:	96a2                	add	a3,a3,s0
ffffffffc020168e:	04d70763          	beq	a4,a3,ffffffffc02016dc <slob_free+0x94>
ffffffffc0201692:	e418                	sd	a4,8(s0)
ffffffffc0201694:	4394                	lw	a3,0(a5)
ffffffffc0201696:	00469713          	slli	a4,a3,0x4
ffffffffc020169a:	973e                	add	a4,a4,a5
ffffffffc020169c:	02e40a63          	beq	s0,a4,ffffffffc02016d0 <slob_free+0x88>
ffffffffc02016a0:	e780                	sd	s0,8(a5)
ffffffffc02016a2:	e21c                	sd	a5,0(a2)
ffffffffc02016a4:	e10d                	bnez	a0,ffffffffc02016c6 <slob_free+0x7e>
ffffffffc02016a6:	60a2                	ld	ra,8(sp)
ffffffffc02016a8:	6402                	ld	s0,0(sp)
ffffffffc02016aa:	0141                	addi	sp,sp,16
ffffffffc02016ac:	8082                	ret
ffffffffc02016ae:	05bd                	addi	a1,a1,15
ffffffffc02016b0:	8191                	srli	a1,a1,0x4
ffffffffc02016b2:	c10c                	sw	a1,0(a0)
ffffffffc02016b4:	100027f3          	csrr	a5,sstatus
ffffffffc02016b8:	8b89                	andi	a5,a5,2
ffffffffc02016ba:	4501                	li	a0,0
ffffffffc02016bc:	d3cd                	beqz	a5,ffffffffc020165e <slob_free+0x16>
ffffffffc02016be:	f7bfe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02016c2:	4505                	li	a0,1
ffffffffc02016c4:	bf69                	j	ffffffffc020165e <slob_free+0x16>
ffffffffc02016c6:	6402                	ld	s0,0(sp)
ffffffffc02016c8:	60a2                	ld	ra,8(sp)
ffffffffc02016ca:	0141                	addi	sp,sp,16
ffffffffc02016cc:	f67fe06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc02016d0:	4018                	lw	a4,0(s0)
ffffffffc02016d2:	640c                	ld	a1,8(s0)
ffffffffc02016d4:	9eb9                	addw	a3,a3,a4
ffffffffc02016d6:	c394                	sw	a3,0(a5)
ffffffffc02016d8:	e78c                	sd	a1,8(a5)
ffffffffc02016da:	b7e1                	j	ffffffffc02016a2 <slob_free+0x5a>
ffffffffc02016dc:	4314                	lw	a3,0(a4)
ffffffffc02016de:	6718                	ld	a4,8(a4)
ffffffffc02016e0:	9db5                	addw	a1,a1,a3
ffffffffc02016e2:	c00c                	sw	a1,0(s0)
ffffffffc02016e4:	e418                	sd	a4,8(s0)
ffffffffc02016e6:	b77d                	j	ffffffffc0201694 <slob_free+0x4c>
ffffffffc02016e8:	8082                	ret

ffffffffc02016ea <__slob_get_free_pages.isra.0>:
ffffffffc02016ea:	4785                	li	a5,1
ffffffffc02016ec:	1141                	addi	sp,sp,-16
ffffffffc02016ee:	00a7953b          	sllw	a0,a5,a0
ffffffffc02016f2:	e406                	sd	ra,8(sp)
ffffffffc02016f4:	7eb000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc02016f8:	c91d                	beqz	a0,ffffffffc020172e <__slob_get_free_pages.isra.0+0x44>
ffffffffc02016fa:	00018697          	auipc	a3,0x18
ffffffffc02016fe:	f466b683          	ld	a3,-186(a3) # ffffffffc0219640 <pages>
ffffffffc0201702:	8d15                	sub	a0,a0,a3
ffffffffc0201704:	8519                	srai	a0,a0,0x6
ffffffffc0201706:	00009697          	auipc	a3,0x9
ffffffffc020170a:	f4a6b683          	ld	a3,-182(a3) # ffffffffc020a650 <nbase>
ffffffffc020170e:	9536                	add	a0,a0,a3
ffffffffc0201710:	00c51793          	slli	a5,a0,0xc
ffffffffc0201714:	83b1                	srli	a5,a5,0xc
ffffffffc0201716:	00018717          	auipc	a4,0x18
ffffffffc020171a:	dda73703          	ld	a4,-550(a4) # ffffffffc02194f0 <npage>
ffffffffc020171e:	0532                	slli	a0,a0,0xc
ffffffffc0201720:	00e7fa63          	bgeu	a5,a4,ffffffffc0201734 <__slob_get_free_pages.isra.0+0x4a>
ffffffffc0201724:	00018697          	auipc	a3,0x18
ffffffffc0201728:	f0c6b683          	ld	a3,-244(a3) # ffffffffc0219630 <va_pa_offset>
ffffffffc020172c:	9536                	add	a0,a0,a3
ffffffffc020172e:	60a2                	ld	ra,8(sp)
ffffffffc0201730:	0141                	addi	sp,sp,16
ffffffffc0201732:	8082                	ret
ffffffffc0201734:	86aa                	mv	a3,a0
ffffffffc0201736:	00007617          	auipc	a2,0x7
ffffffffc020173a:	55a60613          	addi	a2,a2,1370 # ffffffffc0208c90 <commands+0xa98>
ffffffffc020173e:	06900593          	li	a1,105
ffffffffc0201742:	00007517          	auipc	a0,0x7
ffffffffc0201746:	57650513          	addi	a0,a0,1398 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc020174a:	abffe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020174e <slob_alloc.isra.0.constprop.0>:
ffffffffc020174e:	1101                	addi	sp,sp,-32
ffffffffc0201750:	ec06                	sd	ra,24(sp)
ffffffffc0201752:	e822                	sd	s0,16(sp)
ffffffffc0201754:	e426                	sd	s1,8(sp)
ffffffffc0201756:	e04a                	sd	s2,0(sp)
ffffffffc0201758:	01050713          	addi	a4,a0,16
ffffffffc020175c:	6785                	lui	a5,0x1
ffffffffc020175e:	0cf77363          	bgeu	a4,a5,ffffffffc0201824 <slob_alloc.isra.0.constprop.0+0xd6>
ffffffffc0201762:	00f50493          	addi	s1,a0,15
ffffffffc0201766:	8091                	srli	s1,s1,0x4
ffffffffc0201768:	2481                	sext.w	s1,s1
ffffffffc020176a:	10002673          	csrr	a2,sstatus
ffffffffc020176e:	8a09                	andi	a2,a2,2
ffffffffc0201770:	e25d                	bnez	a2,ffffffffc0201816 <slob_alloc.isra.0.constprop.0+0xc8>
ffffffffc0201772:	0000d917          	auipc	s2,0xd
ffffffffc0201776:	90e90913          	addi	s2,s2,-1778 # ffffffffc020e080 <slobfree>
ffffffffc020177a:	00093683          	ld	a3,0(s2)
ffffffffc020177e:	669c                	ld	a5,8(a3)
ffffffffc0201780:	4398                	lw	a4,0(a5)
ffffffffc0201782:	08975e63          	bge	a4,s1,ffffffffc020181e <slob_alloc.isra.0.constprop.0+0xd0>
ffffffffc0201786:	00d78b63          	beq	a5,a3,ffffffffc020179c <slob_alloc.isra.0.constprop.0+0x4e>
ffffffffc020178a:	6780                	ld	s0,8(a5)
ffffffffc020178c:	4018                	lw	a4,0(s0)
ffffffffc020178e:	02975a63          	bge	a4,s1,ffffffffc02017c2 <slob_alloc.isra.0.constprop.0+0x74>
ffffffffc0201792:	00093683          	ld	a3,0(s2)
ffffffffc0201796:	87a2                	mv	a5,s0
ffffffffc0201798:	fed799e3          	bne	a5,a3,ffffffffc020178a <slob_alloc.isra.0.constprop.0+0x3c>
ffffffffc020179c:	ee31                	bnez	a2,ffffffffc02017f8 <slob_alloc.isra.0.constprop.0+0xaa>
ffffffffc020179e:	4501                	li	a0,0
ffffffffc02017a0:	f4bff0ef          	jal	ra,ffffffffc02016ea <__slob_get_free_pages.isra.0>
ffffffffc02017a4:	842a                	mv	s0,a0
ffffffffc02017a6:	cd05                	beqz	a0,ffffffffc02017de <slob_alloc.isra.0.constprop.0+0x90>
ffffffffc02017a8:	6585                	lui	a1,0x1
ffffffffc02017aa:	e9fff0ef          	jal	ra,ffffffffc0201648 <slob_free>
ffffffffc02017ae:	10002673          	csrr	a2,sstatus
ffffffffc02017b2:	8a09                	andi	a2,a2,2
ffffffffc02017b4:	ee05                	bnez	a2,ffffffffc02017ec <slob_alloc.isra.0.constprop.0+0x9e>
ffffffffc02017b6:	00093783          	ld	a5,0(s2)
ffffffffc02017ba:	6780                	ld	s0,8(a5)
ffffffffc02017bc:	4018                	lw	a4,0(s0)
ffffffffc02017be:	fc974ae3          	blt	a4,s1,ffffffffc0201792 <slob_alloc.isra.0.constprop.0+0x44>
ffffffffc02017c2:	04e48763          	beq	s1,a4,ffffffffc0201810 <slob_alloc.isra.0.constprop.0+0xc2>
ffffffffc02017c6:	00449693          	slli	a3,s1,0x4
ffffffffc02017ca:	96a2                	add	a3,a3,s0
ffffffffc02017cc:	e794                	sd	a3,8(a5)
ffffffffc02017ce:	640c                	ld	a1,8(s0)
ffffffffc02017d0:	9f05                	subw	a4,a4,s1
ffffffffc02017d2:	c298                	sw	a4,0(a3)
ffffffffc02017d4:	e68c                	sd	a1,8(a3)
ffffffffc02017d6:	c004                	sw	s1,0(s0)
ffffffffc02017d8:	00f93023          	sd	a5,0(s2)
ffffffffc02017dc:	e20d                	bnez	a2,ffffffffc02017fe <slob_alloc.isra.0.constprop.0+0xb0>
ffffffffc02017de:	60e2                	ld	ra,24(sp)
ffffffffc02017e0:	8522                	mv	a0,s0
ffffffffc02017e2:	6442                	ld	s0,16(sp)
ffffffffc02017e4:	64a2                	ld	s1,8(sp)
ffffffffc02017e6:	6902                	ld	s2,0(sp)
ffffffffc02017e8:	6105                	addi	sp,sp,32
ffffffffc02017ea:	8082                	ret
ffffffffc02017ec:	e4dfe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02017f0:	00093783          	ld	a5,0(s2)
ffffffffc02017f4:	4605                	li	a2,1
ffffffffc02017f6:	b7d1                	j	ffffffffc02017ba <slob_alloc.isra.0.constprop.0+0x6c>
ffffffffc02017f8:	e3bfe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc02017fc:	b74d                	j	ffffffffc020179e <slob_alloc.isra.0.constprop.0+0x50>
ffffffffc02017fe:	e35fe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0201802:	60e2                	ld	ra,24(sp)
ffffffffc0201804:	8522                	mv	a0,s0
ffffffffc0201806:	6442                	ld	s0,16(sp)
ffffffffc0201808:	64a2                	ld	s1,8(sp)
ffffffffc020180a:	6902                	ld	s2,0(sp)
ffffffffc020180c:	6105                	addi	sp,sp,32
ffffffffc020180e:	8082                	ret
ffffffffc0201810:	6418                	ld	a4,8(s0)
ffffffffc0201812:	e798                	sd	a4,8(a5)
ffffffffc0201814:	b7d1                	j	ffffffffc02017d8 <slob_alloc.isra.0.constprop.0+0x8a>
ffffffffc0201816:	e23fe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc020181a:	4605                	li	a2,1
ffffffffc020181c:	bf99                	j	ffffffffc0201772 <slob_alloc.isra.0.constprop.0+0x24>
ffffffffc020181e:	843e                	mv	s0,a5
ffffffffc0201820:	87b6                	mv	a5,a3
ffffffffc0201822:	b745                	j	ffffffffc02017c2 <slob_alloc.isra.0.constprop.0+0x74>
ffffffffc0201824:	00007697          	auipc	a3,0x7
ffffffffc0201828:	4a468693          	addi	a3,a3,1188 # ffffffffc0208cc8 <commands+0xad0>
ffffffffc020182c:	00007617          	auipc	a2,0x7
ffffffffc0201830:	ddc60613          	addi	a2,a2,-548 # ffffffffc0208608 <commands+0x410>
ffffffffc0201834:	06400593          	li	a1,100
ffffffffc0201838:	00007517          	auipc	a0,0x7
ffffffffc020183c:	4b050513          	addi	a0,a0,1200 # ffffffffc0208ce8 <commands+0xaf0>
ffffffffc0201840:	9c9fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201844 <kallocated>:
ffffffffc0201844:	4501                	li	a0,0
ffffffffc0201846:	8082                	ret

ffffffffc0201848 <kmalloc>:
ffffffffc0201848:	1101                	addi	sp,sp,-32
ffffffffc020184a:	e04a                	sd	s2,0(sp)
ffffffffc020184c:	6905                	lui	s2,0x1
ffffffffc020184e:	e822                	sd	s0,16(sp)
ffffffffc0201850:	ec06                	sd	ra,24(sp)
ffffffffc0201852:	e426                	sd	s1,8(sp)
ffffffffc0201854:	fef90793          	addi	a5,s2,-17 # fef <kern_entry-0xffffffffc01ff011>
ffffffffc0201858:	842a                	mv	s0,a0
ffffffffc020185a:	04a7f963          	bgeu	a5,a0,ffffffffc02018ac <kmalloc+0x64>
ffffffffc020185e:	4561                	li	a0,24
ffffffffc0201860:	eefff0ef          	jal	ra,ffffffffc020174e <slob_alloc.isra.0.constprop.0>
ffffffffc0201864:	84aa                	mv	s1,a0
ffffffffc0201866:	c929                	beqz	a0,ffffffffc02018b8 <kmalloc+0x70>
ffffffffc0201868:	0004079b          	sext.w	a5,s0
ffffffffc020186c:	4501                	li	a0,0
ffffffffc020186e:	00f95763          	bge	s2,a5,ffffffffc020187c <kmalloc+0x34>
ffffffffc0201872:	6705                	lui	a4,0x1
ffffffffc0201874:	8785                	srai	a5,a5,0x1
ffffffffc0201876:	2505                	addiw	a0,a0,1
ffffffffc0201878:	fef74ee3          	blt	a4,a5,ffffffffc0201874 <kmalloc+0x2c>
ffffffffc020187c:	c088                	sw	a0,0(s1)
ffffffffc020187e:	e6dff0ef          	jal	ra,ffffffffc02016ea <__slob_get_free_pages.isra.0>
ffffffffc0201882:	e488                	sd	a0,8(s1)
ffffffffc0201884:	842a                	mv	s0,a0
ffffffffc0201886:	c525                	beqz	a0,ffffffffc02018ee <kmalloc+0xa6>
ffffffffc0201888:	100027f3          	csrr	a5,sstatus
ffffffffc020188c:	8b89                	andi	a5,a5,2
ffffffffc020188e:	ef8d                	bnez	a5,ffffffffc02018c8 <kmalloc+0x80>
ffffffffc0201890:	00018797          	auipc	a5,0x18
ffffffffc0201894:	c4078793          	addi	a5,a5,-960 # ffffffffc02194d0 <bigblocks>
ffffffffc0201898:	6398                	ld	a4,0(a5)
ffffffffc020189a:	e384                	sd	s1,0(a5)
ffffffffc020189c:	e898                	sd	a4,16(s1)
ffffffffc020189e:	60e2                	ld	ra,24(sp)
ffffffffc02018a0:	8522                	mv	a0,s0
ffffffffc02018a2:	6442                	ld	s0,16(sp)
ffffffffc02018a4:	64a2                	ld	s1,8(sp)
ffffffffc02018a6:	6902                	ld	s2,0(sp)
ffffffffc02018a8:	6105                	addi	sp,sp,32
ffffffffc02018aa:	8082                	ret
ffffffffc02018ac:	0541                	addi	a0,a0,16
ffffffffc02018ae:	ea1ff0ef          	jal	ra,ffffffffc020174e <slob_alloc.isra.0.constprop.0>
ffffffffc02018b2:	01050413          	addi	s0,a0,16
ffffffffc02018b6:	f565                	bnez	a0,ffffffffc020189e <kmalloc+0x56>
ffffffffc02018b8:	4401                	li	s0,0
ffffffffc02018ba:	60e2                	ld	ra,24(sp)
ffffffffc02018bc:	8522                	mv	a0,s0
ffffffffc02018be:	6442                	ld	s0,16(sp)
ffffffffc02018c0:	64a2                	ld	s1,8(sp)
ffffffffc02018c2:	6902                	ld	s2,0(sp)
ffffffffc02018c4:	6105                	addi	sp,sp,32
ffffffffc02018c6:	8082                	ret
ffffffffc02018c8:	d71fe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02018cc:	00018797          	auipc	a5,0x18
ffffffffc02018d0:	c0478793          	addi	a5,a5,-1020 # ffffffffc02194d0 <bigblocks>
ffffffffc02018d4:	6398                	ld	a4,0(a5)
ffffffffc02018d6:	e384                	sd	s1,0(a5)
ffffffffc02018d8:	e898                	sd	a4,16(s1)
ffffffffc02018da:	d59fe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc02018de:	6480                	ld	s0,8(s1)
ffffffffc02018e0:	60e2                	ld	ra,24(sp)
ffffffffc02018e2:	64a2                	ld	s1,8(sp)
ffffffffc02018e4:	8522                	mv	a0,s0
ffffffffc02018e6:	6442                	ld	s0,16(sp)
ffffffffc02018e8:	6902                	ld	s2,0(sp)
ffffffffc02018ea:	6105                	addi	sp,sp,32
ffffffffc02018ec:	8082                	ret
ffffffffc02018ee:	45e1                	li	a1,24
ffffffffc02018f0:	8526                	mv	a0,s1
ffffffffc02018f2:	d57ff0ef          	jal	ra,ffffffffc0201648 <slob_free>
ffffffffc02018f6:	b765                	j	ffffffffc020189e <kmalloc+0x56>

ffffffffc02018f8 <kfree>:
ffffffffc02018f8:	c169                	beqz	a0,ffffffffc02019ba <kfree+0xc2>
ffffffffc02018fa:	1101                	addi	sp,sp,-32
ffffffffc02018fc:	e822                	sd	s0,16(sp)
ffffffffc02018fe:	ec06                	sd	ra,24(sp)
ffffffffc0201900:	e426                	sd	s1,8(sp)
ffffffffc0201902:	03451793          	slli	a5,a0,0x34
ffffffffc0201906:	842a                	mv	s0,a0
ffffffffc0201908:	e7c9                	bnez	a5,ffffffffc0201992 <kfree+0x9a>
ffffffffc020190a:	100027f3          	csrr	a5,sstatus
ffffffffc020190e:	8b89                	andi	a5,a5,2
ffffffffc0201910:	ebc9                	bnez	a5,ffffffffc02019a2 <kfree+0xaa>
ffffffffc0201912:	00018797          	auipc	a5,0x18
ffffffffc0201916:	bbe7b783          	ld	a5,-1090(a5) # ffffffffc02194d0 <bigblocks>
ffffffffc020191a:	4601                	li	a2,0
ffffffffc020191c:	cbbd                	beqz	a5,ffffffffc0201992 <kfree+0x9a>
ffffffffc020191e:	00018697          	auipc	a3,0x18
ffffffffc0201922:	bb268693          	addi	a3,a3,-1102 # ffffffffc02194d0 <bigblocks>
ffffffffc0201926:	a021                	j	ffffffffc020192e <kfree+0x36>
ffffffffc0201928:	01048693          	addi	a3,s1,16
ffffffffc020192c:	c3a5                	beqz	a5,ffffffffc020198c <kfree+0x94>
ffffffffc020192e:	6798                	ld	a4,8(a5)
ffffffffc0201930:	84be                	mv	s1,a5
ffffffffc0201932:	6b9c                	ld	a5,16(a5)
ffffffffc0201934:	fe871ae3          	bne	a4,s0,ffffffffc0201928 <kfree+0x30>
ffffffffc0201938:	e29c                	sd	a5,0(a3)
ffffffffc020193a:	ee2d                	bnez	a2,ffffffffc02019b4 <kfree+0xbc>
ffffffffc020193c:	c02007b7          	lui	a5,0xc0200
ffffffffc0201940:	4098                	lw	a4,0(s1)
ffffffffc0201942:	08f46963          	bltu	s0,a5,ffffffffc02019d4 <kfree+0xdc>
ffffffffc0201946:	00018697          	auipc	a3,0x18
ffffffffc020194a:	cea6b683          	ld	a3,-790(a3) # ffffffffc0219630 <va_pa_offset>
ffffffffc020194e:	8c15                	sub	s0,s0,a3
ffffffffc0201950:	8031                	srli	s0,s0,0xc
ffffffffc0201952:	00018797          	auipc	a5,0x18
ffffffffc0201956:	b9e7b783          	ld	a5,-1122(a5) # ffffffffc02194f0 <npage>
ffffffffc020195a:	06f47163          	bgeu	s0,a5,ffffffffc02019bc <kfree+0xc4>
ffffffffc020195e:	00009517          	auipc	a0,0x9
ffffffffc0201962:	cf253503          	ld	a0,-782(a0) # ffffffffc020a650 <nbase>
ffffffffc0201966:	8c09                	sub	s0,s0,a0
ffffffffc0201968:	041a                	slli	s0,s0,0x6
ffffffffc020196a:	00018517          	auipc	a0,0x18
ffffffffc020196e:	cd653503          	ld	a0,-810(a0) # ffffffffc0219640 <pages>
ffffffffc0201972:	4585                	li	a1,1
ffffffffc0201974:	9522                	add	a0,a0,s0
ffffffffc0201976:	00e595bb          	sllw	a1,a1,a4
ffffffffc020197a:	5f7000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc020197e:	6442                	ld	s0,16(sp)
ffffffffc0201980:	60e2                	ld	ra,24(sp)
ffffffffc0201982:	8526                	mv	a0,s1
ffffffffc0201984:	64a2                	ld	s1,8(sp)
ffffffffc0201986:	45e1                	li	a1,24
ffffffffc0201988:	6105                	addi	sp,sp,32
ffffffffc020198a:	b97d                	j	ffffffffc0201648 <slob_free>
ffffffffc020198c:	c219                	beqz	a2,ffffffffc0201992 <kfree+0x9a>
ffffffffc020198e:	ca5fe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0201992:	ff040513          	addi	a0,s0,-16
ffffffffc0201996:	6442                	ld	s0,16(sp)
ffffffffc0201998:	60e2                	ld	ra,24(sp)
ffffffffc020199a:	64a2                	ld	s1,8(sp)
ffffffffc020199c:	4581                	li	a1,0
ffffffffc020199e:	6105                	addi	sp,sp,32
ffffffffc02019a0:	b165                	j	ffffffffc0201648 <slob_free>
ffffffffc02019a2:	c97fe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02019a6:	00018797          	auipc	a5,0x18
ffffffffc02019aa:	b2a7b783          	ld	a5,-1238(a5) # ffffffffc02194d0 <bigblocks>
ffffffffc02019ae:	4605                	li	a2,1
ffffffffc02019b0:	f7bd                	bnez	a5,ffffffffc020191e <kfree+0x26>
ffffffffc02019b2:	bff1                	j	ffffffffc020198e <kfree+0x96>
ffffffffc02019b4:	c7ffe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc02019b8:	b751                	j	ffffffffc020193c <kfree+0x44>
ffffffffc02019ba:	8082                	ret
ffffffffc02019bc:	00007617          	auipc	a2,0x7
ffffffffc02019c0:	36c60613          	addi	a2,a2,876 # ffffffffc0208d28 <commands+0xb30>
ffffffffc02019c4:	06200593          	li	a1,98
ffffffffc02019c8:	00007517          	auipc	a0,0x7
ffffffffc02019cc:	2f050513          	addi	a0,a0,752 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc02019d0:	839fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02019d4:	86a2                	mv	a3,s0
ffffffffc02019d6:	00007617          	auipc	a2,0x7
ffffffffc02019da:	32a60613          	addi	a2,a2,810 # ffffffffc0208d00 <commands+0xb08>
ffffffffc02019de:	06e00593          	li	a1,110
ffffffffc02019e2:	00007517          	auipc	a0,0x7
ffffffffc02019e6:	2d650513          	addi	a0,a0,726 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc02019ea:	81ffe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02019ee <swap_init>:
ffffffffc02019ee:	1101                	addi	sp,sp,-32
ffffffffc02019f0:	ec06                	sd	ra,24(sp)
ffffffffc02019f2:	e822                	sd	s0,16(sp)
ffffffffc02019f4:	e426                	sd	s1,8(sp)
ffffffffc02019f6:	359010ef          	jal	ra,ffffffffc020354e <swapfs_init>
ffffffffc02019fa:	00018697          	auipc	a3,0x18
ffffffffc02019fe:	bd66b683          	ld	a3,-1066(a3) # ffffffffc02195d0 <max_swap_offset>
ffffffffc0201a02:	010007b7          	lui	a5,0x1000
ffffffffc0201a06:	ff968713          	addi	a4,a3,-7
ffffffffc0201a0a:	17e1                	addi	a5,a5,-8
ffffffffc0201a0c:	04e7e863          	bltu	a5,a4,ffffffffc0201a5c <swap_init+0x6e>
ffffffffc0201a10:	0000c797          	auipc	a5,0xc
ffffffffc0201a14:	5f078793          	addi	a5,a5,1520 # ffffffffc020e000 <swap_manager_fifo>
ffffffffc0201a18:	6798                	ld	a4,8(a5)
ffffffffc0201a1a:	00018497          	auipc	s1,0x18
ffffffffc0201a1e:	abe48493          	addi	s1,s1,-1346 # ffffffffc02194d8 <sm>
ffffffffc0201a22:	e09c                	sd	a5,0(s1)
ffffffffc0201a24:	9702                	jalr	a4
ffffffffc0201a26:	842a                	mv	s0,a0
ffffffffc0201a28:	c519                	beqz	a0,ffffffffc0201a36 <swap_init+0x48>
ffffffffc0201a2a:	60e2                	ld	ra,24(sp)
ffffffffc0201a2c:	8522                	mv	a0,s0
ffffffffc0201a2e:	6442                	ld	s0,16(sp)
ffffffffc0201a30:	64a2                	ld	s1,8(sp)
ffffffffc0201a32:	6105                	addi	sp,sp,32
ffffffffc0201a34:	8082                	ret
ffffffffc0201a36:	609c                	ld	a5,0(s1)
ffffffffc0201a38:	00007517          	auipc	a0,0x7
ffffffffc0201a3c:	34050513          	addi	a0,a0,832 # ffffffffc0208d78 <commands+0xb80>
ffffffffc0201a40:	638c                	ld	a1,0(a5)
ffffffffc0201a42:	4785                	li	a5,1
ffffffffc0201a44:	00018717          	auipc	a4,0x18
ffffffffc0201a48:	a8f72e23          	sw	a5,-1380(a4) # ffffffffc02194e0 <swap_init_ok>
ffffffffc0201a4c:	e80fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201a50:	60e2                	ld	ra,24(sp)
ffffffffc0201a52:	8522                	mv	a0,s0
ffffffffc0201a54:	6442                	ld	s0,16(sp)
ffffffffc0201a56:	64a2                	ld	s1,8(sp)
ffffffffc0201a58:	6105                	addi	sp,sp,32
ffffffffc0201a5a:	8082                	ret
ffffffffc0201a5c:	00007617          	auipc	a2,0x7
ffffffffc0201a60:	2ec60613          	addi	a2,a2,748 # ffffffffc0208d48 <commands+0xb50>
ffffffffc0201a64:	02800593          	li	a1,40
ffffffffc0201a68:	00007517          	auipc	a0,0x7
ffffffffc0201a6c:	30050513          	addi	a0,a0,768 # ffffffffc0208d68 <commands+0xb70>
ffffffffc0201a70:	f98fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201a74 <swap_init_mm>:
ffffffffc0201a74:	00018797          	auipc	a5,0x18
ffffffffc0201a78:	a647b783          	ld	a5,-1436(a5) # ffffffffc02194d8 <sm>
ffffffffc0201a7c:	0107b303          	ld	t1,16(a5)
ffffffffc0201a80:	8302                	jr	t1

ffffffffc0201a82 <swap_map_swappable>:
ffffffffc0201a82:	00018797          	auipc	a5,0x18
ffffffffc0201a86:	a567b783          	ld	a5,-1450(a5) # ffffffffc02194d8 <sm>
ffffffffc0201a8a:	0207b303          	ld	t1,32(a5)
ffffffffc0201a8e:	8302                	jr	t1

ffffffffc0201a90 <swap_out>:
ffffffffc0201a90:	711d                	addi	sp,sp,-96
ffffffffc0201a92:	ec86                	sd	ra,88(sp)
ffffffffc0201a94:	e8a2                	sd	s0,80(sp)
ffffffffc0201a96:	e4a6                	sd	s1,72(sp)
ffffffffc0201a98:	e0ca                	sd	s2,64(sp)
ffffffffc0201a9a:	fc4e                	sd	s3,56(sp)
ffffffffc0201a9c:	f852                	sd	s4,48(sp)
ffffffffc0201a9e:	f456                	sd	s5,40(sp)
ffffffffc0201aa0:	f05a                	sd	s6,32(sp)
ffffffffc0201aa2:	ec5e                	sd	s7,24(sp)
ffffffffc0201aa4:	e862                	sd	s8,16(sp)
ffffffffc0201aa6:	cde9                	beqz	a1,ffffffffc0201b80 <swap_out+0xf0>
ffffffffc0201aa8:	8a2e                	mv	s4,a1
ffffffffc0201aaa:	892a                	mv	s2,a0
ffffffffc0201aac:	8ab2                	mv	s5,a2
ffffffffc0201aae:	4401                	li	s0,0
ffffffffc0201ab0:	00018997          	auipc	s3,0x18
ffffffffc0201ab4:	a2898993          	addi	s3,s3,-1496 # ffffffffc02194d8 <sm>
ffffffffc0201ab8:	00007b17          	auipc	s6,0x7
ffffffffc0201abc:	338b0b13          	addi	s6,s6,824 # ffffffffc0208df0 <commands+0xbf8>
ffffffffc0201ac0:	00007b97          	auipc	s7,0x7
ffffffffc0201ac4:	318b8b93          	addi	s7,s7,792 # ffffffffc0208dd8 <commands+0xbe0>
ffffffffc0201ac8:	a825                	j	ffffffffc0201b00 <swap_out+0x70>
ffffffffc0201aca:	67a2                	ld	a5,8(sp)
ffffffffc0201acc:	8626                	mv	a2,s1
ffffffffc0201ace:	85a2                	mv	a1,s0
ffffffffc0201ad0:	7f94                	ld	a3,56(a5)
ffffffffc0201ad2:	855a                	mv	a0,s6
ffffffffc0201ad4:	2405                	addiw	s0,s0,1
ffffffffc0201ad6:	82b1                	srli	a3,a3,0xc
ffffffffc0201ad8:	0685                	addi	a3,a3,1
ffffffffc0201ada:	df2fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201ade:	6522                	ld	a0,8(sp)
ffffffffc0201ae0:	4585                	li	a1,1
ffffffffc0201ae2:	7d1c                	ld	a5,56(a0)
ffffffffc0201ae4:	83b1                	srli	a5,a5,0xc
ffffffffc0201ae6:	0785                	addi	a5,a5,1
ffffffffc0201ae8:	07a2                	slli	a5,a5,0x8
ffffffffc0201aea:	00fc3023          	sd	a5,0(s8)
ffffffffc0201aee:	483000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201af2:	01893503          	ld	a0,24(s2)
ffffffffc0201af6:	85a6                	mv	a1,s1
ffffffffc0201af8:	51c010ef          	jal	ra,ffffffffc0203014 <tlb_invalidate>
ffffffffc0201afc:	048a0d63          	beq	s4,s0,ffffffffc0201b56 <swap_out+0xc6>
ffffffffc0201b00:	0009b783          	ld	a5,0(s3)
ffffffffc0201b04:	8656                	mv	a2,s5
ffffffffc0201b06:	002c                	addi	a1,sp,8
ffffffffc0201b08:	7b9c                	ld	a5,48(a5)
ffffffffc0201b0a:	854a                	mv	a0,s2
ffffffffc0201b0c:	9782                	jalr	a5
ffffffffc0201b0e:	e12d                	bnez	a0,ffffffffc0201b70 <swap_out+0xe0>
ffffffffc0201b10:	67a2                	ld	a5,8(sp)
ffffffffc0201b12:	01893503          	ld	a0,24(s2)
ffffffffc0201b16:	4601                	li	a2,0
ffffffffc0201b18:	7f84                	ld	s1,56(a5)
ffffffffc0201b1a:	85a6                	mv	a1,s1
ffffffffc0201b1c:	627000ef          	jal	ra,ffffffffc0202942 <get_pte>
ffffffffc0201b20:	611c                	ld	a5,0(a0)
ffffffffc0201b22:	8c2a                	mv	s8,a0
ffffffffc0201b24:	8b85                	andi	a5,a5,1
ffffffffc0201b26:	cfb9                	beqz	a5,ffffffffc0201b84 <swap_out+0xf4>
ffffffffc0201b28:	65a2                	ld	a1,8(sp)
ffffffffc0201b2a:	7d9c                	ld	a5,56(a1)
ffffffffc0201b2c:	83b1                	srli	a5,a5,0xc
ffffffffc0201b2e:	0785                	addi	a5,a5,1
ffffffffc0201b30:	00879513          	slli	a0,a5,0x8
ffffffffc0201b34:	2e1010ef          	jal	ra,ffffffffc0203614 <swapfs_write>
ffffffffc0201b38:	d949                	beqz	a0,ffffffffc0201aca <swap_out+0x3a>
ffffffffc0201b3a:	855e                	mv	a0,s7
ffffffffc0201b3c:	d90fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201b40:	0009b783          	ld	a5,0(s3)
ffffffffc0201b44:	6622                	ld	a2,8(sp)
ffffffffc0201b46:	4681                	li	a3,0
ffffffffc0201b48:	739c                	ld	a5,32(a5)
ffffffffc0201b4a:	85a6                	mv	a1,s1
ffffffffc0201b4c:	854a                	mv	a0,s2
ffffffffc0201b4e:	2405                	addiw	s0,s0,1
ffffffffc0201b50:	9782                	jalr	a5
ffffffffc0201b52:	fa8a17e3          	bne	s4,s0,ffffffffc0201b00 <swap_out+0x70>
ffffffffc0201b56:	60e6                	ld	ra,88(sp)
ffffffffc0201b58:	8522                	mv	a0,s0
ffffffffc0201b5a:	6446                	ld	s0,80(sp)
ffffffffc0201b5c:	64a6                	ld	s1,72(sp)
ffffffffc0201b5e:	6906                	ld	s2,64(sp)
ffffffffc0201b60:	79e2                	ld	s3,56(sp)
ffffffffc0201b62:	7a42                	ld	s4,48(sp)
ffffffffc0201b64:	7aa2                	ld	s5,40(sp)
ffffffffc0201b66:	7b02                	ld	s6,32(sp)
ffffffffc0201b68:	6be2                	ld	s7,24(sp)
ffffffffc0201b6a:	6c42                	ld	s8,16(sp)
ffffffffc0201b6c:	6125                	addi	sp,sp,96
ffffffffc0201b6e:	8082                	ret
ffffffffc0201b70:	85a2                	mv	a1,s0
ffffffffc0201b72:	00007517          	auipc	a0,0x7
ffffffffc0201b76:	21e50513          	addi	a0,a0,542 # ffffffffc0208d90 <commands+0xb98>
ffffffffc0201b7a:	d52fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201b7e:	bfe1                	j	ffffffffc0201b56 <swap_out+0xc6>
ffffffffc0201b80:	4401                	li	s0,0
ffffffffc0201b82:	bfd1                	j	ffffffffc0201b56 <swap_out+0xc6>
ffffffffc0201b84:	00007697          	auipc	a3,0x7
ffffffffc0201b88:	23c68693          	addi	a3,a3,572 # ffffffffc0208dc0 <commands+0xbc8>
ffffffffc0201b8c:	00007617          	auipc	a2,0x7
ffffffffc0201b90:	a7c60613          	addi	a2,a2,-1412 # ffffffffc0208608 <commands+0x410>
ffffffffc0201b94:	06800593          	li	a1,104
ffffffffc0201b98:	00007517          	auipc	a0,0x7
ffffffffc0201b9c:	1d050513          	addi	a0,a0,464 # ffffffffc0208d68 <commands+0xb70>
ffffffffc0201ba0:	e68fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201ba4 <swap_in>:
ffffffffc0201ba4:	7179                	addi	sp,sp,-48
ffffffffc0201ba6:	e84a                	sd	s2,16(sp)
ffffffffc0201ba8:	892a                	mv	s2,a0
ffffffffc0201baa:	4505                	li	a0,1
ffffffffc0201bac:	ec26                	sd	s1,24(sp)
ffffffffc0201bae:	e44e                	sd	s3,8(sp)
ffffffffc0201bb0:	f406                	sd	ra,40(sp)
ffffffffc0201bb2:	f022                	sd	s0,32(sp)
ffffffffc0201bb4:	84ae                	mv	s1,a1
ffffffffc0201bb6:	89b2                	mv	s3,a2
ffffffffc0201bb8:	327000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201bbc:	c129                	beqz	a0,ffffffffc0201bfe <swap_in+0x5a>
ffffffffc0201bbe:	842a                	mv	s0,a0
ffffffffc0201bc0:	01893503          	ld	a0,24(s2)
ffffffffc0201bc4:	4601                	li	a2,0
ffffffffc0201bc6:	85a6                	mv	a1,s1
ffffffffc0201bc8:	57b000ef          	jal	ra,ffffffffc0202942 <get_pte>
ffffffffc0201bcc:	892a                	mv	s2,a0
ffffffffc0201bce:	6108                	ld	a0,0(a0)
ffffffffc0201bd0:	85a2                	mv	a1,s0
ffffffffc0201bd2:	1b5010ef          	jal	ra,ffffffffc0203586 <swapfs_read>
ffffffffc0201bd6:	00093583          	ld	a1,0(s2)
ffffffffc0201bda:	8626                	mv	a2,s1
ffffffffc0201bdc:	00007517          	auipc	a0,0x7
ffffffffc0201be0:	26450513          	addi	a0,a0,612 # ffffffffc0208e40 <commands+0xc48>
ffffffffc0201be4:	81a1                	srli	a1,a1,0x8
ffffffffc0201be6:	ce6fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201bea:	70a2                	ld	ra,40(sp)
ffffffffc0201bec:	0089b023          	sd	s0,0(s3)
ffffffffc0201bf0:	7402                	ld	s0,32(sp)
ffffffffc0201bf2:	64e2                	ld	s1,24(sp)
ffffffffc0201bf4:	6942                	ld	s2,16(sp)
ffffffffc0201bf6:	69a2                	ld	s3,8(sp)
ffffffffc0201bf8:	4501                	li	a0,0
ffffffffc0201bfa:	6145                	addi	sp,sp,48
ffffffffc0201bfc:	8082                	ret
ffffffffc0201bfe:	00007697          	auipc	a3,0x7
ffffffffc0201c02:	23268693          	addi	a3,a3,562 # ffffffffc0208e30 <commands+0xc38>
ffffffffc0201c06:	00007617          	auipc	a2,0x7
ffffffffc0201c0a:	a0260613          	addi	a2,a2,-1534 # ffffffffc0208608 <commands+0x410>
ffffffffc0201c0e:	07e00593          	li	a1,126
ffffffffc0201c12:	00007517          	auipc	a0,0x7
ffffffffc0201c16:	15650513          	addi	a0,a0,342 # ffffffffc0208d68 <commands+0xb70>
ffffffffc0201c1a:	deefe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201c1e <default_init>:
ffffffffc0201c1e:	00018797          	auipc	a5,0x18
ffffffffc0201c22:	9f278793          	addi	a5,a5,-1550 # ffffffffc0219610 <free_area>
ffffffffc0201c26:	e79c                	sd	a5,8(a5)
ffffffffc0201c28:	e39c                	sd	a5,0(a5)
ffffffffc0201c2a:	0007a823          	sw	zero,16(a5)
ffffffffc0201c2e:	8082                	ret

ffffffffc0201c30 <default_nr_free_pages>:
ffffffffc0201c30:	00018517          	auipc	a0,0x18
ffffffffc0201c34:	9f056503          	lwu	a0,-1552(a0) # ffffffffc0219620 <free_area+0x10>
ffffffffc0201c38:	8082                	ret

ffffffffc0201c3a <default_check>:
ffffffffc0201c3a:	715d                	addi	sp,sp,-80
ffffffffc0201c3c:	e0a2                	sd	s0,64(sp)
ffffffffc0201c3e:	00018417          	auipc	s0,0x18
ffffffffc0201c42:	9d240413          	addi	s0,s0,-1582 # ffffffffc0219610 <free_area>
ffffffffc0201c46:	641c                	ld	a5,8(s0)
ffffffffc0201c48:	e486                	sd	ra,72(sp)
ffffffffc0201c4a:	fc26                	sd	s1,56(sp)
ffffffffc0201c4c:	f84a                	sd	s2,48(sp)
ffffffffc0201c4e:	f44e                	sd	s3,40(sp)
ffffffffc0201c50:	f052                	sd	s4,32(sp)
ffffffffc0201c52:	ec56                	sd	s5,24(sp)
ffffffffc0201c54:	e85a                	sd	s6,16(sp)
ffffffffc0201c56:	e45e                	sd	s7,8(sp)
ffffffffc0201c58:	e062                	sd	s8,0(sp)
ffffffffc0201c5a:	2a878d63          	beq	a5,s0,ffffffffc0201f14 <default_check+0x2da>
ffffffffc0201c5e:	4481                	li	s1,0
ffffffffc0201c60:	4901                	li	s2,0
ffffffffc0201c62:	ff07b703          	ld	a4,-16(a5)
ffffffffc0201c66:	8b09                	andi	a4,a4,2
ffffffffc0201c68:	2a070a63          	beqz	a4,ffffffffc0201f1c <default_check+0x2e2>
ffffffffc0201c6c:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201c70:	679c                	ld	a5,8(a5)
ffffffffc0201c72:	2905                	addiw	s2,s2,1
ffffffffc0201c74:	9cb9                	addw	s1,s1,a4
ffffffffc0201c76:	fe8796e3          	bne	a5,s0,ffffffffc0201c62 <default_check+0x28>
ffffffffc0201c7a:	89a6                	mv	s3,s1
ffffffffc0201c7c:	337000ef          	jal	ra,ffffffffc02027b2 <nr_free_pages>
ffffffffc0201c80:	6f351e63          	bne	a0,s3,ffffffffc020237c <default_check+0x742>
ffffffffc0201c84:	4505                	li	a0,1
ffffffffc0201c86:	259000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201c8a:	8aaa                	mv	s5,a0
ffffffffc0201c8c:	42050863          	beqz	a0,ffffffffc02020bc <default_check+0x482>
ffffffffc0201c90:	4505                	li	a0,1
ffffffffc0201c92:	24d000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201c96:	89aa                	mv	s3,a0
ffffffffc0201c98:	70050263          	beqz	a0,ffffffffc020239c <default_check+0x762>
ffffffffc0201c9c:	4505                	li	a0,1
ffffffffc0201c9e:	241000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201ca2:	8a2a                	mv	s4,a0
ffffffffc0201ca4:	48050c63          	beqz	a0,ffffffffc020213c <default_check+0x502>
ffffffffc0201ca8:	293a8a63          	beq	s5,s3,ffffffffc0201f3c <default_check+0x302>
ffffffffc0201cac:	28aa8863          	beq	s5,a0,ffffffffc0201f3c <default_check+0x302>
ffffffffc0201cb0:	28a98663          	beq	s3,a0,ffffffffc0201f3c <default_check+0x302>
ffffffffc0201cb4:	000aa783          	lw	a5,0(s5)
ffffffffc0201cb8:	2a079263          	bnez	a5,ffffffffc0201f5c <default_check+0x322>
ffffffffc0201cbc:	0009a783          	lw	a5,0(s3)
ffffffffc0201cc0:	28079e63          	bnez	a5,ffffffffc0201f5c <default_check+0x322>
ffffffffc0201cc4:	411c                	lw	a5,0(a0)
ffffffffc0201cc6:	28079b63          	bnez	a5,ffffffffc0201f5c <default_check+0x322>
ffffffffc0201cca:	00018797          	auipc	a5,0x18
ffffffffc0201cce:	9767b783          	ld	a5,-1674(a5) # ffffffffc0219640 <pages>
ffffffffc0201cd2:	40fa8733          	sub	a4,s5,a5
ffffffffc0201cd6:	00009617          	auipc	a2,0x9
ffffffffc0201cda:	97a63603          	ld	a2,-1670(a2) # ffffffffc020a650 <nbase>
ffffffffc0201cde:	8719                	srai	a4,a4,0x6
ffffffffc0201ce0:	9732                	add	a4,a4,a2
ffffffffc0201ce2:	00018697          	auipc	a3,0x18
ffffffffc0201ce6:	80e6b683          	ld	a3,-2034(a3) # ffffffffc02194f0 <npage>
ffffffffc0201cea:	06b2                	slli	a3,a3,0xc
ffffffffc0201cec:	0732                	slli	a4,a4,0xc
ffffffffc0201cee:	28d77763          	bgeu	a4,a3,ffffffffc0201f7c <default_check+0x342>
ffffffffc0201cf2:	40f98733          	sub	a4,s3,a5
ffffffffc0201cf6:	8719                	srai	a4,a4,0x6
ffffffffc0201cf8:	9732                	add	a4,a4,a2
ffffffffc0201cfa:	0732                	slli	a4,a4,0xc
ffffffffc0201cfc:	4cd77063          	bgeu	a4,a3,ffffffffc02021bc <default_check+0x582>
ffffffffc0201d00:	40f507b3          	sub	a5,a0,a5
ffffffffc0201d04:	8799                	srai	a5,a5,0x6
ffffffffc0201d06:	97b2                	add	a5,a5,a2
ffffffffc0201d08:	07b2                	slli	a5,a5,0xc
ffffffffc0201d0a:	30d7f963          	bgeu	a5,a3,ffffffffc020201c <default_check+0x3e2>
ffffffffc0201d0e:	4505                	li	a0,1
ffffffffc0201d10:	00043c03          	ld	s8,0(s0)
ffffffffc0201d14:	00843b83          	ld	s7,8(s0)
ffffffffc0201d18:	01042b03          	lw	s6,16(s0)
ffffffffc0201d1c:	e400                	sd	s0,8(s0)
ffffffffc0201d1e:	e000                	sd	s0,0(s0)
ffffffffc0201d20:	00018797          	auipc	a5,0x18
ffffffffc0201d24:	9007a023          	sw	zero,-1792(a5) # ffffffffc0219620 <free_area+0x10>
ffffffffc0201d28:	1b7000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201d2c:	2c051863          	bnez	a0,ffffffffc0201ffc <default_check+0x3c2>
ffffffffc0201d30:	4585                	li	a1,1
ffffffffc0201d32:	8556                	mv	a0,s5
ffffffffc0201d34:	23d000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201d38:	4585                	li	a1,1
ffffffffc0201d3a:	854e                	mv	a0,s3
ffffffffc0201d3c:	235000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201d40:	4585                	li	a1,1
ffffffffc0201d42:	8552                	mv	a0,s4
ffffffffc0201d44:	22d000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201d48:	4818                	lw	a4,16(s0)
ffffffffc0201d4a:	478d                	li	a5,3
ffffffffc0201d4c:	28f71863          	bne	a4,a5,ffffffffc0201fdc <default_check+0x3a2>
ffffffffc0201d50:	4505                	li	a0,1
ffffffffc0201d52:	18d000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201d56:	89aa                	mv	s3,a0
ffffffffc0201d58:	26050263          	beqz	a0,ffffffffc0201fbc <default_check+0x382>
ffffffffc0201d5c:	4505                	li	a0,1
ffffffffc0201d5e:	181000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201d62:	8aaa                	mv	s5,a0
ffffffffc0201d64:	3a050c63          	beqz	a0,ffffffffc020211c <default_check+0x4e2>
ffffffffc0201d68:	4505                	li	a0,1
ffffffffc0201d6a:	175000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201d6e:	8a2a                	mv	s4,a0
ffffffffc0201d70:	38050663          	beqz	a0,ffffffffc02020fc <default_check+0x4c2>
ffffffffc0201d74:	4505                	li	a0,1
ffffffffc0201d76:	169000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201d7a:	36051163          	bnez	a0,ffffffffc02020dc <default_check+0x4a2>
ffffffffc0201d7e:	4585                	li	a1,1
ffffffffc0201d80:	854e                	mv	a0,s3
ffffffffc0201d82:	1ef000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201d86:	641c                	ld	a5,8(s0)
ffffffffc0201d88:	20878a63          	beq	a5,s0,ffffffffc0201f9c <default_check+0x362>
ffffffffc0201d8c:	4505                	li	a0,1
ffffffffc0201d8e:	151000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201d92:	30a99563          	bne	s3,a0,ffffffffc020209c <default_check+0x462>
ffffffffc0201d96:	4505                	li	a0,1
ffffffffc0201d98:	147000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201d9c:	2e051063          	bnez	a0,ffffffffc020207c <default_check+0x442>
ffffffffc0201da0:	481c                	lw	a5,16(s0)
ffffffffc0201da2:	2a079d63          	bnez	a5,ffffffffc020205c <default_check+0x422>
ffffffffc0201da6:	854e                	mv	a0,s3
ffffffffc0201da8:	4585                	li	a1,1
ffffffffc0201daa:	01843023          	sd	s8,0(s0)
ffffffffc0201dae:	01743423          	sd	s7,8(s0)
ffffffffc0201db2:	01642823          	sw	s6,16(s0)
ffffffffc0201db6:	1bb000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201dba:	4585                	li	a1,1
ffffffffc0201dbc:	8556                	mv	a0,s5
ffffffffc0201dbe:	1b3000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201dc2:	4585                	li	a1,1
ffffffffc0201dc4:	8552                	mv	a0,s4
ffffffffc0201dc6:	1ab000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201dca:	4515                	li	a0,5
ffffffffc0201dcc:	113000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201dd0:	89aa                	mv	s3,a0
ffffffffc0201dd2:	26050563          	beqz	a0,ffffffffc020203c <default_check+0x402>
ffffffffc0201dd6:	651c                	ld	a5,8(a0)
ffffffffc0201dd8:	8385                	srli	a5,a5,0x1
ffffffffc0201dda:	8b85                	andi	a5,a5,1
ffffffffc0201ddc:	54079063          	bnez	a5,ffffffffc020231c <default_check+0x6e2>
ffffffffc0201de0:	4505                	li	a0,1
ffffffffc0201de2:	00043b03          	ld	s6,0(s0)
ffffffffc0201de6:	00843a83          	ld	s5,8(s0)
ffffffffc0201dea:	e000                	sd	s0,0(s0)
ffffffffc0201dec:	e400                	sd	s0,8(s0)
ffffffffc0201dee:	0f1000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201df2:	50051563          	bnez	a0,ffffffffc02022fc <default_check+0x6c2>
ffffffffc0201df6:	08098a13          	addi	s4,s3,128
ffffffffc0201dfa:	8552                	mv	a0,s4
ffffffffc0201dfc:	458d                	li	a1,3
ffffffffc0201dfe:	01042b83          	lw	s7,16(s0)
ffffffffc0201e02:	00018797          	auipc	a5,0x18
ffffffffc0201e06:	8007af23          	sw	zero,-2018(a5) # ffffffffc0219620 <free_area+0x10>
ffffffffc0201e0a:	167000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201e0e:	4511                	li	a0,4
ffffffffc0201e10:	0cf000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201e14:	4c051463          	bnez	a0,ffffffffc02022dc <default_check+0x6a2>
ffffffffc0201e18:	0889b783          	ld	a5,136(s3)
ffffffffc0201e1c:	8385                	srli	a5,a5,0x1
ffffffffc0201e1e:	8b85                	andi	a5,a5,1
ffffffffc0201e20:	48078e63          	beqz	a5,ffffffffc02022bc <default_check+0x682>
ffffffffc0201e24:	0909a703          	lw	a4,144(s3)
ffffffffc0201e28:	478d                	li	a5,3
ffffffffc0201e2a:	48f71963          	bne	a4,a5,ffffffffc02022bc <default_check+0x682>
ffffffffc0201e2e:	450d                	li	a0,3
ffffffffc0201e30:	0af000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201e34:	8c2a                	mv	s8,a0
ffffffffc0201e36:	46050363          	beqz	a0,ffffffffc020229c <default_check+0x662>
ffffffffc0201e3a:	4505                	li	a0,1
ffffffffc0201e3c:	0a3000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201e40:	42051e63          	bnez	a0,ffffffffc020227c <default_check+0x642>
ffffffffc0201e44:	418a1c63          	bne	s4,s8,ffffffffc020225c <default_check+0x622>
ffffffffc0201e48:	4585                	li	a1,1
ffffffffc0201e4a:	854e                	mv	a0,s3
ffffffffc0201e4c:	125000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201e50:	458d                	li	a1,3
ffffffffc0201e52:	8552                	mv	a0,s4
ffffffffc0201e54:	11d000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201e58:	0089b783          	ld	a5,8(s3)
ffffffffc0201e5c:	04098c13          	addi	s8,s3,64
ffffffffc0201e60:	8385                	srli	a5,a5,0x1
ffffffffc0201e62:	8b85                	andi	a5,a5,1
ffffffffc0201e64:	3c078c63          	beqz	a5,ffffffffc020223c <default_check+0x602>
ffffffffc0201e68:	0109a703          	lw	a4,16(s3)
ffffffffc0201e6c:	4785                	li	a5,1
ffffffffc0201e6e:	3cf71763          	bne	a4,a5,ffffffffc020223c <default_check+0x602>
ffffffffc0201e72:	008a3783          	ld	a5,8(s4) # 1008 <kern_entry-0xffffffffc01feff8>
ffffffffc0201e76:	8385                	srli	a5,a5,0x1
ffffffffc0201e78:	8b85                	andi	a5,a5,1
ffffffffc0201e7a:	3a078163          	beqz	a5,ffffffffc020221c <default_check+0x5e2>
ffffffffc0201e7e:	010a2703          	lw	a4,16(s4)
ffffffffc0201e82:	478d                	li	a5,3
ffffffffc0201e84:	38f71c63          	bne	a4,a5,ffffffffc020221c <default_check+0x5e2>
ffffffffc0201e88:	4505                	li	a0,1
ffffffffc0201e8a:	055000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201e8e:	36a99763          	bne	s3,a0,ffffffffc02021fc <default_check+0x5c2>
ffffffffc0201e92:	4585                	li	a1,1
ffffffffc0201e94:	0dd000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201e98:	4509                	li	a0,2
ffffffffc0201e9a:	045000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201e9e:	32aa1f63          	bne	s4,a0,ffffffffc02021dc <default_check+0x5a2>
ffffffffc0201ea2:	4589                	li	a1,2
ffffffffc0201ea4:	0cd000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201ea8:	4585                	li	a1,1
ffffffffc0201eaa:	8562                	mv	a0,s8
ffffffffc0201eac:	0c5000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201eb0:	4515                	li	a0,5
ffffffffc0201eb2:	02d000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201eb6:	89aa                	mv	s3,a0
ffffffffc0201eb8:	48050263          	beqz	a0,ffffffffc020233c <default_check+0x702>
ffffffffc0201ebc:	4505                	li	a0,1
ffffffffc0201ebe:	021000ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0201ec2:	2c051d63          	bnez	a0,ffffffffc020219c <default_check+0x562>
ffffffffc0201ec6:	481c                	lw	a5,16(s0)
ffffffffc0201ec8:	2a079a63          	bnez	a5,ffffffffc020217c <default_check+0x542>
ffffffffc0201ecc:	4595                	li	a1,5
ffffffffc0201ece:	854e                	mv	a0,s3
ffffffffc0201ed0:	01742823          	sw	s7,16(s0)
ffffffffc0201ed4:	01643023          	sd	s6,0(s0)
ffffffffc0201ed8:	01543423          	sd	s5,8(s0)
ffffffffc0201edc:	095000ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0201ee0:	641c                	ld	a5,8(s0)
ffffffffc0201ee2:	00878963          	beq	a5,s0,ffffffffc0201ef4 <default_check+0x2ba>
ffffffffc0201ee6:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201eea:	679c                	ld	a5,8(a5)
ffffffffc0201eec:	397d                	addiw	s2,s2,-1
ffffffffc0201eee:	9c99                	subw	s1,s1,a4
ffffffffc0201ef0:	fe879be3          	bne	a5,s0,ffffffffc0201ee6 <default_check+0x2ac>
ffffffffc0201ef4:	26091463          	bnez	s2,ffffffffc020215c <default_check+0x522>
ffffffffc0201ef8:	46049263          	bnez	s1,ffffffffc020235c <default_check+0x722>
ffffffffc0201efc:	60a6                	ld	ra,72(sp)
ffffffffc0201efe:	6406                	ld	s0,64(sp)
ffffffffc0201f00:	74e2                	ld	s1,56(sp)
ffffffffc0201f02:	7942                	ld	s2,48(sp)
ffffffffc0201f04:	79a2                	ld	s3,40(sp)
ffffffffc0201f06:	7a02                	ld	s4,32(sp)
ffffffffc0201f08:	6ae2                	ld	s5,24(sp)
ffffffffc0201f0a:	6b42                	ld	s6,16(sp)
ffffffffc0201f0c:	6ba2                	ld	s7,8(sp)
ffffffffc0201f0e:	6c02                	ld	s8,0(sp)
ffffffffc0201f10:	6161                	addi	sp,sp,80
ffffffffc0201f12:	8082                	ret
ffffffffc0201f14:	4981                	li	s3,0
ffffffffc0201f16:	4481                	li	s1,0
ffffffffc0201f18:	4901                	li	s2,0
ffffffffc0201f1a:	b38d                	j	ffffffffc0201c7c <default_check+0x42>
ffffffffc0201f1c:	00007697          	auipc	a3,0x7
ffffffffc0201f20:	f6468693          	addi	a3,a3,-156 # ffffffffc0208e80 <commands+0xc88>
ffffffffc0201f24:	00006617          	auipc	a2,0x6
ffffffffc0201f28:	6e460613          	addi	a2,a2,1764 # ffffffffc0208608 <commands+0x410>
ffffffffc0201f2c:	0f000593          	li	a1,240
ffffffffc0201f30:	00007517          	auipc	a0,0x7
ffffffffc0201f34:	f6050513          	addi	a0,a0,-160 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0201f38:	ad0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201f3c:	00007697          	auipc	a3,0x7
ffffffffc0201f40:	fec68693          	addi	a3,a3,-20 # ffffffffc0208f28 <commands+0xd30>
ffffffffc0201f44:	00006617          	auipc	a2,0x6
ffffffffc0201f48:	6c460613          	addi	a2,a2,1732 # ffffffffc0208608 <commands+0x410>
ffffffffc0201f4c:	0bd00593          	li	a1,189
ffffffffc0201f50:	00007517          	auipc	a0,0x7
ffffffffc0201f54:	f4050513          	addi	a0,a0,-192 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0201f58:	ab0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201f5c:	00007697          	auipc	a3,0x7
ffffffffc0201f60:	ff468693          	addi	a3,a3,-12 # ffffffffc0208f50 <commands+0xd58>
ffffffffc0201f64:	00006617          	auipc	a2,0x6
ffffffffc0201f68:	6a460613          	addi	a2,a2,1700 # ffffffffc0208608 <commands+0x410>
ffffffffc0201f6c:	0be00593          	li	a1,190
ffffffffc0201f70:	00007517          	auipc	a0,0x7
ffffffffc0201f74:	f2050513          	addi	a0,a0,-224 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0201f78:	a90fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201f7c:	00007697          	auipc	a3,0x7
ffffffffc0201f80:	01468693          	addi	a3,a3,20 # ffffffffc0208f90 <commands+0xd98>
ffffffffc0201f84:	00006617          	auipc	a2,0x6
ffffffffc0201f88:	68460613          	addi	a2,a2,1668 # ffffffffc0208608 <commands+0x410>
ffffffffc0201f8c:	0c000593          	li	a1,192
ffffffffc0201f90:	00007517          	auipc	a0,0x7
ffffffffc0201f94:	f0050513          	addi	a0,a0,-256 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0201f98:	a70fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201f9c:	00007697          	auipc	a3,0x7
ffffffffc0201fa0:	07c68693          	addi	a3,a3,124 # ffffffffc0209018 <commands+0xe20>
ffffffffc0201fa4:	00006617          	auipc	a2,0x6
ffffffffc0201fa8:	66460613          	addi	a2,a2,1636 # ffffffffc0208608 <commands+0x410>
ffffffffc0201fac:	0d900593          	li	a1,217
ffffffffc0201fb0:	00007517          	auipc	a0,0x7
ffffffffc0201fb4:	ee050513          	addi	a0,a0,-288 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0201fb8:	a50fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201fbc:	00007697          	auipc	a3,0x7
ffffffffc0201fc0:	f0c68693          	addi	a3,a3,-244 # ffffffffc0208ec8 <commands+0xcd0>
ffffffffc0201fc4:	00006617          	auipc	a2,0x6
ffffffffc0201fc8:	64460613          	addi	a2,a2,1604 # ffffffffc0208608 <commands+0x410>
ffffffffc0201fcc:	0d200593          	li	a1,210
ffffffffc0201fd0:	00007517          	auipc	a0,0x7
ffffffffc0201fd4:	ec050513          	addi	a0,a0,-320 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0201fd8:	a30fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201fdc:	00007697          	auipc	a3,0x7
ffffffffc0201fe0:	02c68693          	addi	a3,a3,44 # ffffffffc0209008 <commands+0xe10>
ffffffffc0201fe4:	00006617          	auipc	a2,0x6
ffffffffc0201fe8:	62460613          	addi	a2,a2,1572 # ffffffffc0208608 <commands+0x410>
ffffffffc0201fec:	0d000593          	li	a1,208
ffffffffc0201ff0:	00007517          	auipc	a0,0x7
ffffffffc0201ff4:	ea050513          	addi	a0,a0,-352 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0201ff8:	a10fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201ffc:	00007697          	auipc	a3,0x7
ffffffffc0202000:	ff468693          	addi	a3,a3,-12 # ffffffffc0208ff0 <commands+0xdf8>
ffffffffc0202004:	00006617          	auipc	a2,0x6
ffffffffc0202008:	60460613          	addi	a2,a2,1540 # ffffffffc0208608 <commands+0x410>
ffffffffc020200c:	0cb00593          	li	a1,203
ffffffffc0202010:	00007517          	auipc	a0,0x7
ffffffffc0202014:	e8050513          	addi	a0,a0,-384 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202018:	9f0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020201c:	00007697          	auipc	a3,0x7
ffffffffc0202020:	fb468693          	addi	a3,a3,-76 # ffffffffc0208fd0 <commands+0xdd8>
ffffffffc0202024:	00006617          	auipc	a2,0x6
ffffffffc0202028:	5e460613          	addi	a2,a2,1508 # ffffffffc0208608 <commands+0x410>
ffffffffc020202c:	0c200593          	li	a1,194
ffffffffc0202030:	00007517          	auipc	a0,0x7
ffffffffc0202034:	e6050513          	addi	a0,a0,-416 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202038:	9d0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020203c:	00007697          	auipc	a3,0x7
ffffffffc0202040:	02468693          	addi	a3,a3,36 # ffffffffc0209060 <commands+0xe68>
ffffffffc0202044:	00006617          	auipc	a2,0x6
ffffffffc0202048:	5c460613          	addi	a2,a2,1476 # ffffffffc0208608 <commands+0x410>
ffffffffc020204c:	0f800593          	li	a1,248
ffffffffc0202050:	00007517          	auipc	a0,0x7
ffffffffc0202054:	e4050513          	addi	a0,a0,-448 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202058:	9b0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020205c:	00007697          	auipc	a3,0x7
ffffffffc0202060:	ff468693          	addi	a3,a3,-12 # ffffffffc0209050 <commands+0xe58>
ffffffffc0202064:	00006617          	auipc	a2,0x6
ffffffffc0202068:	5a460613          	addi	a2,a2,1444 # ffffffffc0208608 <commands+0x410>
ffffffffc020206c:	0df00593          	li	a1,223
ffffffffc0202070:	00007517          	auipc	a0,0x7
ffffffffc0202074:	e2050513          	addi	a0,a0,-480 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202078:	990fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020207c:	00007697          	auipc	a3,0x7
ffffffffc0202080:	f7468693          	addi	a3,a3,-140 # ffffffffc0208ff0 <commands+0xdf8>
ffffffffc0202084:	00006617          	auipc	a2,0x6
ffffffffc0202088:	58460613          	addi	a2,a2,1412 # ffffffffc0208608 <commands+0x410>
ffffffffc020208c:	0dd00593          	li	a1,221
ffffffffc0202090:	00007517          	auipc	a0,0x7
ffffffffc0202094:	e0050513          	addi	a0,a0,-512 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202098:	970fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020209c:	00007697          	auipc	a3,0x7
ffffffffc02020a0:	f9468693          	addi	a3,a3,-108 # ffffffffc0209030 <commands+0xe38>
ffffffffc02020a4:	00006617          	auipc	a2,0x6
ffffffffc02020a8:	56460613          	addi	a2,a2,1380 # ffffffffc0208608 <commands+0x410>
ffffffffc02020ac:	0dc00593          	li	a1,220
ffffffffc02020b0:	00007517          	auipc	a0,0x7
ffffffffc02020b4:	de050513          	addi	a0,a0,-544 # ffffffffc0208e90 <commands+0xc98>
ffffffffc02020b8:	950fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02020bc:	00007697          	auipc	a3,0x7
ffffffffc02020c0:	e0c68693          	addi	a3,a3,-500 # ffffffffc0208ec8 <commands+0xcd0>
ffffffffc02020c4:	00006617          	auipc	a2,0x6
ffffffffc02020c8:	54460613          	addi	a2,a2,1348 # ffffffffc0208608 <commands+0x410>
ffffffffc02020cc:	0b900593          	li	a1,185
ffffffffc02020d0:	00007517          	auipc	a0,0x7
ffffffffc02020d4:	dc050513          	addi	a0,a0,-576 # ffffffffc0208e90 <commands+0xc98>
ffffffffc02020d8:	930fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02020dc:	00007697          	auipc	a3,0x7
ffffffffc02020e0:	f1468693          	addi	a3,a3,-236 # ffffffffc0208ff0 <commands+0xdf8>
ffffffffc02020e4:	00006617          	auipc	a2,0x6
ffffffffc02020e8:	52460613          	addi	a2,a2,1316 # ffffffffc0208608 <commands+0x410>
ffffffffc02020ec:	0d600593          	li	a1,214
ffffffffc02020f0:	00007517          	auipc	a0,0x7
ffffffffc02020f4:	da050513          	addi	a0,a0,-608 # ffffffffc0208e90 <commands+0xc98>
ffffffffc02020f8:	910fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02020fc:	00007697          	auipc	a3,0x7
ffffffffc0202100:	e0c68693          	addi	a3,a3,-500 # ffffffffc0208f08 <commands+0xd10>
ffffffffc0202104:	00006617          	auipc	a2,0x6
ffffffffc0202108:	50460613          	addi	a2,a2,1284 # ffffffffc0208608 <commands+0x410>
ffffffffc020210c:	0d400593          	li	a1,212
ffffffffc0202110:	00007517          	auipc	a0,0x7
ffffffffc0202114:	d8050513          	addi	a0,a0,-640 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202118:	8f0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020211c:	00007697          	auipc	a3,0x7
ffffffffc0202120:	dcc68693          	addi	a3,a3,-564 # ffffffffc0208ee8 <commands+0xcf0>
ffffffffc0202124:	00006617          	auipc	a2,0x6
ffffffffc0202128:	4e460613          	addi	a2,a2,1252 # ffffffffc0208608 <commands+0x410>
ffffffffc020212c:	0d300593          	li	a1,211
ffffffffc0202130:	00007517          	auipc	a0,0x7
ffffffffc0202134:	d6050513          	addi	a0,a0,-672 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202138:	8d0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020213c:	00007697          	auipc	a3,0x7
ffffffffc0202140:	dcc68693          	addi	a3,a3,-564 # ffffffffc0208f08 <commands+0xd10>
ffffffffc0202144:	00006617          	auipc	a2,0x6
ffffffffc0202148:	4c460613          	addi	a2,a2,1220 # ffffffffc0208608 <commands+0x410>
ffffffffc020214c:	0bb00593          	li	a1,187
ffffffffc0202150:	00007517          	auipc	a0,0x7
ffffffffc0202154:	d4050513          	addi	a0,a0,-704 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202158:	8b0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020215c:	00007697          	auipc	a3,0x7
ffffffffc0202160:	05468693          	addi	a3,a3,84 # ffffffffc02091b0 <commands+0xfb8>
ffffffffc0202164:	00006617          	auipc	a2,0x6
ffffffffc0202168:	4a460613          	addi	a2,a2,1188 # ffffffffc0208608 <commands+0x410>
ffffffffc020216c:	12500593          	li	a1,293
ffffffffc0202170:	00007517          	auipc	a0,0x7
ffffffffc0202174:	d2050513          	addi	a0,a0,-736 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202178:	890fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020217c:	00007697          	auipc	a3,0x7
ffffffffc0202180:	ed468693          	addi	a3,a3,-300 # ffffffffc0209050 <commands+0xe58>
ffffffffc0202184:	00006617          	auipc	a2,0x6
ffffffffc0202188:	48460613          	addi	a2,a2,1156 # ffffffffc0208608 <commands+0x410>
ffffffffc020218c:	11a00593          	li	a1,282
ffffffffc0202190:	00007517          	auipc	a0,0x7
ffffffffc0202194:	d0050513          	addi	a0,a0,-768 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202198:	870fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020219c:	00007697          	auipc	a3,0x7
ffffffffc02021a0:	e5468693          	addi	a3,a3,-428 # ffffffffc0208ff0 <commands+0xdf8>
ffffffffc02021a4:	00006617          	auipc	a2,0x6
ffffffffc02021a8:	46460613          	addi	a2,a2,1124 # ffffffffc0208608 <commands+0x410>
ffffffffc02021ac:	11800593          	li	a1,280
ffffffffc02021b0:	00007517          	auipc	a0,0x7
ffffffffc02021b4:	ce050513          	addi	a0,a0,-800 # ffffffffc0208e90 <commands+0xc98>
ffffffffc02021b8:	850fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02021bc:	00007697          	auipc	a3,0x7
ffffffffc02021c0:	df468693          	addi	a3,a3,-524 # ffffffffc0208fb0 <commands+0xdb8>
ffffffffc02021c4:	00006617          	auipc	a2,0x6
ffffffffc02021c8:	44460613          	addi	a2,a2,1092 # ffffffffc0208608 <commands+0x410>
ffffffffc02021cc:	0c100593          	li	a1,193
ffffffffc02021d0:	00007517          	auipc	a0,0x7
ffffffffc02021d4:	cc050513          	addi	a0,a0,-832 # ffffffffc0208e90 <commands+0xc98>
ffffffffc02021d8:	830fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02021dc:	00007697          	auipc	a3,0x7
ffffffffc02021e0:	f9468693          	addi	a3,a3,-108 # ffffffffc0209170 <commands+0xf78>
ffffffffc02021e4:	00006617          	auipc	a2,0x6
ffffffffc02021e8:	42460613          	addi	a2,a2,1060 # ffffffffc0208608 <commands+0x410>
ffffffffc02021ec:	11200593          	li	a1,274
ffffffffc02021f0:	00007517          	auipc	a0,0x7
ffffffffc02021f4:	ca050513          	addi	a0,a0,-864 # ffffffffc0208e90 <commands+0xc98>
ffffffffc02021f8:	810fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02021fc:	00007697          	auipc	a3,0x7
ffffffffc0202200:	f5468693          	addi	a3,a3,-172 # ffffffffc0209150 <commands+0xf58>
ffffffffc0202204:	00006617          	auipc	a2,0x6
ffffffffc0202208:	40460613          	addi	a2,a2,1028 # ffffffffc0208608 <commands+0x410>
ffffffffc020220c:	11000593          	li	a1,272
ffffffffc0202210:	00007517          	auipc	a0,0x7
ffffffffc0202214:	c8050513          	addi	a0,a0,-896 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202218:	ff1fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020221c:	00007697          	auipc	a3,0x7
ffffffffc0202220:	f0c68693          	addi	a3,a3,-244 # ffffffffc0209128 <commands+0xf30>
ffffffffc0202224:	00006617          	auipc	a2,0x6
ffffffffc0202228:	3e460613          	addi	a2,a2,996 # ffffffffc0208608 <commands+0x410>
ffffffffc020222c:	10e00593          	li	a1,270
ffffffffc0202230:	00007517          	auipc	a0,0x7
ffffffffc0202234:	c6050513          	addi	a0,a0,-928 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202238:	fd1fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020223c:	00007697          	auipc	a3,0x7
ffffffffc0202240:	ec468693          	addi	a3,a3,-316 # ffffffffc0209100 <commands+0xf08>
ffffffffc0202244:	00006617          	auipc	a2,0x6
ffffffffc0202248:	3c460613          	addi	a2,a2,964 # ffffffffc0208608 <commands+0x410>
ffffffffc020224c:	10d00593          	li	a1,269
ffffffffc0202250:	00007517          	auipc	a0,0x7
ffffffffc0202254:	c4050513          	addi	a0,a0,-960 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202258:	fb1fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020225c:	00007697          	auipc	a3,0x7
ffffffffc0202260:	e9468693          	addi	a3,a3,-364 # ffffffffc02090f0 <commands+0xef8>
ffffffffc0202264:	00006617          	auipc	a2,0x6
ffffffffc0202268:	3a460613          	addi	a2,a2,932 # ffffffffc0208608 <commands+0x410>
ffffffffc020226c:	10800593          	li	a1,264
ffffffffc0202270:	00007517          	auipc	a0,0x7
ffffffffc0202274:	c2050513          	addi	a0,a0,-992 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202278:	f91fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020227c:	00007697          	auipc	a3,0x7
ffffffffc0202280:	d7468693          	addi	a3,a3,-652 # ffffffffc0208ff0 <commands+0xdf8>
ffffffffc0202284:	00006617          	auipc	a2,0x6
ffffffffc0202288:	38460613          	addi	a2,a2,900 # ffffffffc0208608 <commands+0x410>
ffffffffc020228c:	10700593          	li	a1,263
ffffffffc0202290:	00007517          	auipc	a0,0x7
ffffffffc0202294:	c0050513          	addi	a0,a0,-1024 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202298:	f71fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020229c:	00007697          	auipc	a3,0x7
ffffffffc02022a0:	e3468693          	addi	a3,a3,-460 # ffffffffc02090d0 <commands+0xed8>
ffffffffc02022a4:	00006617          	auipc	a2,0x6
ffffffffc02022a8:	36460613          	addi	a2,a2,868 # ffffffffc0208608 <commands+0x410>
ffffffffc02022ac:	10600593          	li	a1,262
ffffffffc02022b0:	00007517          	auipc	a0,0x7
ffffffffc02022b4:	be050513          	addi	a0,a0,-1056 # ffffffffc0208e90 <commands+0xc98>
ffffffffc02022b8:	f51fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02022bc:	00007697          	auipc	a3,0x7
ffffffffc02022c0:	de468693          	addi	a3,a3,-540 # ffffffffc02090a0 <commands+0xea8>
ffffffffc02022c4:	00006617          	auipc	a2,0x6
ffffffffc02022c8:	34460613          	addi	a2,a2,836 # ffffffffc0208608 <commands+0x410>
ffffffffc02022cc:	10500593          	li	a1,261
ffffffffc02022d0:	00007517          	auipc	a0,0x7
ffffffffc02022d4:	bc050513          	addi	a0,a0,-1088 # ffffffffc0208e90 <commands+0xc98>
ffffffffc02022d8:	f31fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02022dc:	00007697          	auipc	a3,0x7
ffffffffc02022e0:	dac68693          	addi	a3,a3,-596 # ffffffffc0209088 <commands+0xe90>
ffffffffc02022e4:	00006617          	auipc	a2,0x6
ffffffffc02022e8:	32460613          	addi	a2,a2,804 # ffffffffc0208608 <commands+0x410>
ffffffffc02022ec:	10400593          	li	a1,260
ffffffffc02022f0:	00007517          	auipc	a0,0x7
ffffffffc02022f4:	ba050513          	addi	a0,a0,-1120 # ffffffffc0208e90 <commands+0xc98>
ffffffffc02022f8:	f11fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02022fc:	00007697          	auipc	a3,0x7
ffffffffc0202300:	cf468693          	addi	a3,a3,-780 # ffffffffc0208ff0 <commands+0xdf8>
ffffffffc0202304:	00006617          	auipc	a2,0x6
ffffffffc0202308:	30460613          	addi	a2,a2,772 # ffffffffc0208608 <commands+0x410>
ffffffffc020230c:	0fe00593          	li	a1,254
ffffffffc0202310:	00007517          	auipc	a0,0x7
ffffffffc0202314:	b8050513          	addi	a0,a0,-1152 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202318:	ef1fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020231c:	00007697          	auipc	a3,0x7
ffffffffc0202320:	d5468693          	addi	a3,a3,-684 # ffffffffc0209070 <commands+0xe78>
ffffffffc0202324:	00006617          	auipc	a2,0x6
ffffffffc0202328:	2e460613          	addi	a2,a2,740 # ffffffffc0208608 <commands+0x410>
ffffffffc020232c:	0f900593          	li	a1,249
ffffffffc0202330:	00007517          	auipc	a0,0x7
ffffffffc0202334:	b6050513          	addi	a0,a0,-1184 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202338:	ed1fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020233c:	00007697          	auipc	a3,0x7
ffffffffc0202340:	e5468693          	addi	a3,a3,-428 # ffffffffc0209190 <commands+0xf98>
ffffffffc0202344:	00006617          	auipc	a2,0x6
ffffffffc0202348:	2c460613          	addi	a2,a2,708 # ffffffffc0208608 <commands+0x410>
ffffffffc020234c:	11700593          	li	a1,279
ffffffffc0202350:	00007517          	auipc	a0,0x7
ffffffffc0202354:	b4050513          	addi	a0,a0,-1216 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202358:	eb1fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020235c:	00007697          	auipc	a3,0x7
ffffffffc0202360:	e6468693          	addi	a3,a3,-412 # ffffffffc02091c0 <commands+0xfc8>
ffffffffc0202364:	00006617          	auipc	a2,0x6
ffffffffc0202368:	2a460613          	addi	a2,a2,676 # ffffffffc0208608 <commands+0x410>
ffffffffc020236c:	12600593          	li	a1,294
ffffffffc0202370:	00007517          	auipc	a0,0x7
ffffffffc0202374:	b2050513          	addi	a0,a0,-1248 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202378:	e91fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020237c:	00007697          	auipc	a3,0x7
ffffffffc0202380:	b2c68693          	addi	a3,a3,-1236 # ffffffffc0208ea8 <commands+0xcb0>
ffffffffc0202384:	00006617          	auipc	a2,0x6
ffffffffc0202388:	28460613          	addi	a2,a2,644 # ffffffffc0208608 <commands+0x410>
ffffffffc020238c:	0f300593          	li	a1,243
ffffffffc0202390:	00007517          	auipc	a0,0x7
ffffffffc0202394:	b0050513          	addi	a0,a0,-1280 # ffffffffc0208e90 <commands+0xc98>
ffffffffc0202398:	e71fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020239c:	00007697          	auipc	a3,0x7
ffffffffc02023a0:	b4c68693          	addi	a3,a3,-1204 # ffffffffc0208ee8 <commands+0xcf0>
ffffffffc02023a4:	00006617          	auipc	a2,0x6
ffffffffc02023a8:	26460613          	addi	a2,a2,612 # ffffffffc0208608 <commands+0x410>
ffffffffc02023ac:	0ba00593          	li	a1,186
ffffffffc02023b0:	00007517          	auipc	a0,0x7
ffffffffc02023b4:	ae050513          	addi	a0,a0,-1312 # ffffffffc0208e90 <commands+0xc98>
ffffffffc02023b8:	e51fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02023bc <default_free_pages>:
ffffffffc02023bc:	1141                	addi	sp,sp,-16
ffffffffc02023be:	e406                	sd	ra,8(sp)
ffffffffc02023c0:	12058f63          	beqz	a1,ffffffffc02024fe <default_free_pages+0x142>
ffffffffc02023c4:	00659693          	slli	a3,a1,0x6
ffffffffc02023c8:	96aa                	add	a3,a3,a0
ffffffffc02023ca:	87aa                	mv	a5,a0
ffffffffc02023cc:	02d50263          	beq	a0,a3,ffffffffc02023f0 <default_free_pages+0x34>
ffffffffc02023d0:	6798                	ld	a4,8(a5)
ffffffffc02023d2:	8b05                	andi	a4,a4,1
ffffffffc02023d4:	10071563          	bnez	a4,ffffffffc02024de <default_free_pages+0x122>
ffffffffc02023d8:	6798                	ld	a4,8(a5)
ffffffffc02023da:	8b09                	andi	a4,a4,2
ffffffffc02023dc:	10071163          	bnez	a4,ffffffffc02024de <default_free_pages+0x122>
ffffffffc02023e0:	0007b423          	sd	zero,8(a5)
ffffffffc02023e4:	0007a023          	sw	zero,0(a5)
ffffffffc02023e8:	04078793          	addi	a5,a5,64
ffffffffc02023ec:	fed792e3          	bne	a5,a3,ffffffffc02023d0 <default_free_pages+0x14>
ffffffffc02023f0:	2581                	sext.w	a1,a1
ffffffffc02023f2:	c90c                	sw	a1,16(a0)
ffffffffc02023f4:	00850893          	addi	a7,a0,8
ffffffffc02023f8:	4789                	li	a5,2
ffffffffc02023fa:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc02023fe:	00017697          	auipc	a3,0x17
ffffffffc0202402:	21268693          	addi	a3,a3,530 # ffffffffc0219610 <free_area>
ffffffffc0202406:	4a98                	lw	a4,16(a3)
ffffffffc0202408:	669c                	ld	a5,8(a3)
ffffffffc020240a:	01850613          	addi	a2,a0,24
ffffffffc020240e:	9db9                	addw	a1,a1,a4
ffffffffc0202410:	ca8c                	sw	a1,16(a3)
ffffffffc0202412:	08d78f63          	beq	a5,a3,ffffffffc02024b0 <default_free_pages+0xf4>
ffffffffc0202416:	fe878713          	addi	a4,a5,-24
ffffffffc020241a:	0006b803          	ld	a6,0(a3)
ffffffffc020241e:	4581                	li	a1,0
ffffffffc0202420:	00e56a63          	bltu	a0,a4,ffffffffc0202434 <default_free_pages+0x78>
ffffffffc0202424:	6798                	ld	a4,8(a5)
ffffffffc0202426:	04d70a63          	beq	a4,a3,ffffffffc020247a <default_free_pages+0xbe>
ffffffffc020242a:	87ba                	mv	a5,a4
ffffffffc020242c:	fe878713          	addi	a4,a5,-24
ffffffffc0202430:	fee57ae3          	bgeu	a0,a4,ffffffffc0202424 <default_free_pages+0x68>
ffffffffc0202434:	c199                	beqz	a1,ffffffffc020243a <default_free_pages+0x7e>
ffffffffc0202436:	0106b023          	sd	a6,0(a3)
ffffffffc020243a:	6398                	ld	a4,0(a5)
ffffffffc020243c:	e390                	sd	a2,0(a5)
ffffffffc020243e:	e710                	sd	a2,8(a4)
ffffffffc0202440:	f11c                	sd	a5,32(a0)
ffffffffc0202442:	ed18                	sd	a4,24(a0)
ffffffffc0202444:	00d70c63          	beq	a4,a3,ffffffffc020245c <default_free_pages+0xa0>
ffffffffc0202448:	ff872583          	lw	a1,-8(a4)
ffffffffc020244c:	fe870613          	addi	a2,a4,-24
ffffffffc0202450:	02059793          	slli	a5,a1,0x20
ffffffffc0202454:	83e9                	srli	a5,a5,0x1a
ffffffffc0202456:	97b2                	add	a5,a5,a2
ffffffffc0202458:	02f50b63          	beq	a0,a5,ffffffffc020248e <default_free_pages+0xd2>
ffffffffc020245c:	7118                	ld	a4,32(a0)
ffffffffc020245e:	00d70b63          	beq	a4,a3,ffffffffc0202474 <default_free_pages+0xb8>
ffffffffc0202462:	4910                	lw	a2,16(a0)
ffffffffc0202464:	fe870693          	addi	a3,a4,-24
ffffffffc0202468:	02061793          	slli	a5,a2,0x20
ffffffffc020246c:	83e9                	srli	a5,a5,0x1a
ffffffffc020246e:	97aa                	add	a5,a5,a0
ffffffffc0202470:	04f68763          	beq	a3,a5,ffffffffc02024be <default_free_pages+0x102>
ffffffffc0202474:	60a2                	ld	ra,8(sp)
ffffffffc0202476:	0141                	addi	sp,sp,16
ffffffffc0202478:	8082                	ret
ffffffffc020247a:	e790                	sd	a2,8(a5)
ffffffffc020247c:	f114                	sd	a3,32(a0)
ffffffffc020247e:	6798                	ld	a4,8(a5)
ffffffffc0202480:	ed1c                	sd	a5,24(a0)
ffffffffc0202482:	02d70463          	beq	a4,a3,ffffffffc02024aa <default_free_pages+0xee>
ffffffffc0202486:	8832                	mv	a6,a2
ffffffffc0202488:	4585                	li	a1,1
ffffffffc020248a:	87ba                	mv	a5,a4
ffffffffc020248c:	b745                	j	ffffffffc020242c <default_free_pages+0x70>
ffffffffc020248e:	491c                	lw	a5,16(a0)
ffffffffc0202490:	9dbd                	addw	a1,a1,a5
ffffffffc0202492:	feb72c23          	sw	a1,-8(a4)
ffffffffc0202496:	57f5                	li	a5,-3
ffffffffc0202498:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc020249c:	6d0c                	ld	a1,24(a0)
ffffffffc020249e:	711c                	ld	a5,32(a0)
ffffffffc02024a0:	8532                	mv	a0,a2
ffffffffc02024a2:	e59c                	sd	a5,8(a1)
ffffffffc02024a4:	6718                	ld	a4,8(a4)
ffffffffc02024a6:	e38c                	sd	a1,0(a5)
ffffffffc02024a8:	bf5d                	j	ffffffffc020245e <default_free_pages+0xa2>
ffffffffc02024aa:	e290                	sd	a2,0(a3)
ffffffffc02024ac:	873e                	mv	a4,a5
ffffffffc02024ae:	bf69                	j	ffffffffc0202448 <default_free_pages+0x8c>
ffffffffc02024b0:	60a2                	ld	ra,8(sp)
ffffffffc02024b2:	e390                	sd	a2,0(a5)
ffffffffc02024b4:	e790                	sd	a2,8(a5)
ffffffffc02024b6:	f11c                	sd	a5,32(a0)
ffffffffc02024b8:	ed1c                	sd	a5,24(a0)
ffffffffc02024ba:	0141                	addi	sp,sp,16
ffffffffc02024bc:	8082                	ret
ffffffffc02024be:	ff872783          	lw	a5,-8(a4)
ffffffffc02024c2:	ff070693          	addi	a3,a4,-16
ffffffffc02024c6:	9e3d                	addw	a2,a2,a5
ffffffffc02024c8:	c910                	sw	a2,16(a0)
ffffffffc02024ca:	57f5                	li	a5,-3
ffffffffc02024cc:	60f6b02f          	amoand.d	zero,a5,(a3)
ffffffffc02024d0:	6314                	ld	a3,0(a4)
ffffffffc02024d2:	671c                	ld	a5,8(a4)
ffffffffc02024d4:	60a2                	ld	ra,8(sp)
ffffffffc02024d6:	e69c                	sd	a5,8(a3)
ffffffffc02024d8:	e394                	sd	a3,0(a5)
ffffffffc02024da:	0141                	addi	sp,sp,16
ffffffffc02024dc:	8082                	ret
ffffffffc02024de:	00007697          	auipc	a3,0x7
ffffffffc02024e2:	cfa68693          	addi	a3,a3,-774 # ffffffffc02091d8 <commands+0xfe0>
ffffffffc02024e6:	00006617          	auipc	a2,0x6
ffffffffc02024ea:	12260613          	addi	a2,a2,290 # ffffffffc0208608 <commands+0x410>
ffffffffc02024ee:	08300593          	li	a1,131
ffffffffc02024f2:	00007517          	auipc	a0,0x7
ffffffffc02024f6:	99e50513          	addi	a0,a0,-1634 # ffffffffc0208e90 <commands+0xc98>
ffffffffc02024fa:	d0ffd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02024fe:	00007697          	auipc	a3,0x7
ffffffffc0202502:	cd268693          	addi	a3,a3,-814 # ffffffffc02091d0 <commands+0xfd8>
ffffffffc0202506:	00006617          	auipc	a2,0x6
ffffffffc020250a:	10260613          	addi	a2,a2,258 # ffffffffc0208608 <commands+0x410>
ffffffffc020250e:	08000593          	li	a1,128
ffffffffc0202512:	00007517          	auipc	a0,0x7
ffffffffc0202516:	97e50513          	addi	a0,a0,-1666 # ffffffffc0208e90 <commands+0xc98>
ffffffffc020251a:	ceffd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020251e <default_alloc_pages>:
ffffffffc020251e:	c941                	beqz	a0,ffffffffc02025ae <default_alloc_pages+0x90>
ffffffffc0202520:	00017597          	auipc	a1,0x17
ffffffffc0202524:	0f058593          	addi	a1,a1,240 # ffffffffc0219610 <free_area>
ffffffffc0202528:	0105a803          	lw	a6,16(a1)
ffffffffc020252c:	872a                	mv	a4,a0
ffffffffc020252e:	02081793          	slli	a5,a6,0x20
ffffffffc0202532:	9381                	srli	a5,a5,0x20
ffffffffc0202534:	00a7ee63          	bltu	a5,a0,ffffffffc0202550 <default_alloc_pages+0x32>
ffffffffc0202538:	87ae                	mv	a5,a1
ffffffffc020253a:	a801                	j	ffffffffc020254a <default_alloc_pages+0x2c>
ffffffffc020253c:	ff87a683          	lw	a3,-8(a5)
ffffffffc0202540:	02069613          	slli	a2,a3,0x20
ffffffffc0202544:	9201                	srli	a2,a2,0x20
ffffffffc0202546:	00e67763          	bgeu	a2,a4,ffffffffc0202554 <default_alloc_pages+0x36>
ffffffffc020254a:	679c                	ld	a5,8(a5)
ffffffffc020254c:	feb798e3          	bne	a5,a1,ffffffffc020253c <default_alloc_pages+0x1e>
ffffffffc0202550:	4501                	li	a0,0
ffffffffc0202552:	8082                	ret
ffffffffc0202554:	0007b883          	ld	a7,0(a5)
ffffffffc0202558:	0087b303          	ld	t1,8(a5)
ffffffffc020255c:	fe878513          	addi	a0,a5,-24
ffffffffc0202560:	00070e1b          	sext.w	t3,a4
ffffffffc0202564:	0068b423          	sd	t1,8(a7)
ffffffffc0202568:	01133023          	sd	a7,0(t1)
ffffffffc020256c:	02c77863          	bgeu	a4,a2,ffffffffc020259c <default_alloc_pages+0x7e>
ffffffffc0202570:	071a                	slli	a4,a4,0x6
ffffffffc0202572:	972a                	add	a4,a4,a0
ffffffffc0202574:	41c686bb          	subw	a3,a3,t3
ffffffffc0202578:	cb14                	sw	a3,16(a4)
ffffffffc020257a:	00870613          	addi	a2,a4,8
ffffffffc020257e:	4689                	li	a3,2
ffffffffc0202580:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc0202584:	0088b683          	ld	a3,8(a7)
ffffffffc0202588:	01870613          	addi	a2,a4,24
ffffffffc020258c:	0105a803          	lw	a6,16(a1)
ffffffffc0202590:	e290                	sd	a2,0(a3)
ffffffffc0202592:	00c8b423          	sd	a2,8(a7)
ffffffffc0202596:	f314                	sd	a3,32(a4)
ffffffffc0202598:	01173c23          	sd	a7,24(a4)
ffffffffc020259c:	41c8083b          	subw	a6,a6,t3
ffffffffc02025a0:	0105a823          	sw	a6,16(a1)
ffffffffc02025a4:	5775                	li	a4,-3
ffffffffc02025a6:	17c1                	addi	a5,a5,-16
ffffffffc02025a8:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc02025ac:	8082                	ret
ffffffffc02025ae:	1141                	addi	sp,sp,-16
ffffffffc02025b0:	00007697          	auipc	a3,0x7
ffffffffc02025b4:	c2068693          	addi	a3,a3,-992 # ffffffffc02091d0 <commands+0xfd8>
ffffffffc02025b8:	00006617          	auipc	a2,0x6
ffffffffc02025bc:	05060613          	addi	a2,a2,80 # ffffffffc0208608 <commands+0x410>
ffffffffc02025c0:	06200593          	li	a1,98
ffffffffc02025c4:	00007517          	auipc	a0,0x7
ffffffffc02025c8:	8cc50513          	addi	a0,a0,-1844 # ffffffffc0208e90 <commands+0xc98>
ffffffffc02025cc:	e406                	sd	ra,8(sp)
ffffffffc02025ce:	c3bfd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02025d2 <default_init_memmap>:
ffffffffc02025d2:	1141                	addi	sp,sp,-16
ffffffffc02025d4:	e406                	sd	ra,8(sp)
ffffffffc02025d6:	c5f1                	beqz	a1,ffffffffc02026a2 <default_init_memmap+0xd0>
ffffffffc02025d8:	00659693          	slli	a3,a1,0x6
ffffffffc02025dc:	96aa                	add	a3,a3,a0
ffffffffc02025de:	87aa                	mv	a5,a0
ffffffffc02025e0:	00d50f63          	beq	a0,a3,ffffffffc02025fe <default_init_memmap+0x2c>
ffffffffc02025e4:	6798                	ld	a4,8(a5)
ffffffffc02025e6:	8b05                	andi	a4,a4,1
ffffffffc02025e8:	cf49                	beqz	a4,ffffffffc0202682 <default_init_memmap+0xb0>
ffffffffc02025ea:	0007a823          	sw	zero,16(a5)
ffffffffc02025ee:	0007b423          	sd	zero,8(a5)
ffffffffc02025f2:	0007a023          	sw	zero,0(a5)
ffffffffc02025f6:	04078793          	addi	a5,a5,64
ffffffffc02025fa:	fed795e3          	bne	a5,a3,ffffffffc02025e4 <default_init_memmap+0x12>
ffffffffc02025fe:	2581                	sext.w	a1,a1
ffffffffc0202600:	c90c                	sw	a1,16(a0)
ffffffffc0202602:	4789                	li	a5,2
ffffffffc0202604:	00850713          	addi	a4,a0,8
ffffffffc0202608:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc020260c:	00017697          	auipc	a3,0x17
ffffffffc0202610:	00468693          	addi	a3,a3,4 # ffffffffc0219610 <free_area>
ffffffffc0202614:	4a98                	lw	a4,16(a3)
ffffffffc0202616:	669c                	ld	a5,8(a3)
ffffffffc0202618:	01850613          	addi	a2,a0,24
ffffffffc020261c:	9db9                	addw	a1,a1,a4
ffffffffc020261e:	ca8c                	sw	a1,16(a3)
ffffffffc0202620:	04d78a63          	beq	a5,a3,ffffffffc0202674 <default_init_memmap+0xa2>
ffffffffc0202624:	fe878713          	addi	a4,a5,-24
ffffffffc0202628:	0006b803          	ld	a6,0(a3)
ffffffffc020262c:	4581                	li	a1,0
ffffffffc020262e:	00e56a63          	bltu	a0,a4,ffffffffc0202642 <default_init_memmap+0x70>
ffffffffc0202632:	6798                	ld	a4,8(a5)
ffffffffc0202634:	02d70263          	beq	a4,a3,ffffffffc0202658 <default_init_memmap+0x86>
ffffffffc0202638:	87ba                	mv	a5,a4
ffffffffc020263a:	fe878713          	addi	a4,a5,-24
ffffffffc020263e:	fee57ae3          	bgeu	a0,a4,ffffffffc0202632 <default_init_memmap+0x60>
ffffffffc0202642:	c199                	beqz	a1,ffffffffc0202648 <default_init_memmap+0x76>
ffffffffc0202644:	0106b023          	sd	a6,0(a3)
ffffffffc0202648:	6398                	ld	a4,0(a5)
ffffffffc020264a:	60a2                	ld	ra,8(sp)
ffffffffc020264c:	e390                	sd	a2,0(a5)
ffffffffc020264e:	e710                	sd	a2,8(a4)
ffffffffc0202650:	f11c                	sd	a5,32(a0)
ffffffffc0202652:	ed18                	sd	a4,24(a0)
ffffffffc0202654:	0141                	addi	sp,sp,16
ffffffffc0202656:	8082                	ret
ffffffffc0202658:	e790                	sd	a2,8(a5)
ffffffffc020265a:	f114                	sd	a3,32(a0)
ffffffffc020265c:	6798                	ld	a4,8(a5)
ffffffffc020265e:	ed1c                	sd	a5,24(a0)
ffffffffc0202660:	00d70663          	beq	a4,a3,ffffffffc020266c <default_init_memmap+0x9a>
ffffffffc0202664:	8832                	mv	a6,a2
ffffffffc0202666:	4585                	li	a1,1
ffffffffc0202668:	87ba                	mv	a5,a4
ffffffffc020266a:	bfc1                	j	ffffffffc020263a <default_init_memmap+0x68>
ffffffffc020266c:	60a2                	ld	ra,8(sp)
ffffffffc020266e:	e290                	sd	a2,0(a3)
ffffffffc0202670:	0141                	addi	sp,sp,16
ffffffffc0202672:	8082                	ret
ffffffffc0202674:	60a2                	ld	ra,8(sp)
ffffffffc0202676:	e390                	sd	a2,0(a5)
ffffffffc0202678:	e790                	sd	a2,8(a5)
ffffffffc020267a:	f11c                	sd	a5,32(a0)
ffffffffc020267c:	ed1c                	sd	a5,24(a0)
ffffffffc020267e:	0141                	addi	sp,sp,16
ffffffffc0202680:	8082                	ret
ffffffffc0202682:	00007697          	auipc	a3,0x7
ffffffffc0202686:	b7e68693          	addi	a3,a3,-1154 # ffffffffc0209200 <commands+0x1008>
ffffffffc020268a:	00006617          	auipc	a2,0x6
ffffffffc020268e:	f7e60613          	addi	a2,a2,-130 # ffffffffc0208608 <commands+0x410>
ffffffffc0202692:	04900593          	li	a1,73
ffffffffc0202696:	00006517          	auipc	a0,0x6
ffffffffc020269a:	7fa50513          	addi	a0,a0,2042 # ffffffffc0208e90 <commands+0xc98>
ffffffffc020269e:	b6bfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02026a2:	00007697          	auipc	a3,0x7
ffffffffc02026a6:	b2e68693          	addi	a3,a3,-1234 # ffffffffc02091d0 <commands+0xfd8>
ffffffffc02026aa:	00006617          	auipc	a2,0x6
ffffffffc02026ae:	f5e60613          	addi	a2,a2,-162 # ffffffffc0208608 <commands+0x410>
ffffffffc02026b2:	04600593          	li	a1,70
ffffffffc02026b6:	00006517          	auipc	a0,0x6
ffffffffc02026ba:	7da50513          	addi	a0,a0,2010 # ffffffffc0208e90 <commands+0xc98>
ffffffffc02026be:	b4bfd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02026c2 <pa2page.part.0>:
ffffffffc02026c2:	1141                	addi	sp,sp,-16
ffffffffc02026c4:	00006617          	auipc	a2,0x6
ffffffffc02026c8:	66460613          	addi	a2,a2,1636 # ffffffffc0208d28 <commands+0xb30>
ffffffffc02026cc:	06200593          	li	a1,98
ffffffffc02026d0:	00006517          	auipc	a0,0x6
ffffffffc02026d4:	5e850513          	addi	a0,a0,1512 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc02026d8:	e406                	sd	ra,8(sp)
ffffffffc02026da:	b2ffd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02026de <alloc_pages>:
ffffffffc02026de:	7139                	addi	sp,sp,-64
ffffffffc02026e0:	f426                	sd	s1,40(sp)
ffffffffc02026e2:	f04a                	sd	s2,32(sp)
ffffffffc02026e4:	ec4e                	sd	s3,24(sp)
ffffffffc02026e6:	e852                	sd	s4,16(sp)
ffffffffc02026e8:	e456                	sd	s5,8(sp)
ffffffffc02026ea:	e05a                	sd	s6,0(sp)
ffffffffc02026ec:	fc06                	sd	ra,56(sp)
ffffffffc02026ee:	f822                	sd	s0,48(sp)
ffffffffc02026f0:	84aa                	mv	s1,a0
ffffffffc02026f2:	00017917          	auipc	s2,0x17
ffffffffc02026f6:	f3690913          	addi	s2,s2,-202 # ffffffffc0219628 <pmm_manager>
ffffffffc02026fa:	4a05                	li	s4,1
ffffffffc02026fc:	00017a97          	auipc	s5,0x17
ffffffffc0202700:	de4a8a93          	addi	s5,s5,-540 # ffffffffc02194e0 <swap_init_ok>
ffffffffc0202704:	0005099b          	sext.w	s3,a0
ffffffffc0202708:	00017b17          	auipc	s6,0x17
ffffffffc020270c:	e28b0b13          	addi	s6,s6,-472 # ffffffffc0219530 <check_mm_struct>
ffffffffc0202710:	a01d                	j	ffffffffc0202736 <alloc_pages+0x58>
ffffffffc0202712:	00093783          	ld	a5,0(s2)
ffffffffc0202716:	6f9c                	ld	a5,24(a5)
ffffffffc0202718:	9782                	jalr	a5
ffffffffc020271a:	842a                	mv	s0,a0
ffffffffc020271c:	4601                	li	a2,0
ffffffffc020271e:	85ce                	mv	a1,s3
ffffffffc0202720:	ec0d                	bnez	s0,ffffffffc020275a <alloc_pages+0x7c>
ffffffffc0202722:	029a6c63          	bltu	s4,s1,ffffffffc020275a <alloc_pages+0x7c>
ffffffffc0202726:	000aa783          	lw	a5,0(s5)
ffffffffc020272a:	2781                	sext.w	a5,a5
ffffffffc020272c:	c79d                	beqz	a5,ffffffffc020275a <alloc_pages+0x7c>
ffffffffc020272e:	000b3503          	ld	a0,0(s6)
ffffffffc0202732:	b5eff0ef          	jal	ra,ffffffffc0201a90 <swap_out>
ffffffffc0202736:	100027f3          	csrr	a5,sstatus
ffffffffc020273a:	8b89                	andi	a5,a5,2
ffffffffc020273c:	8526                	mv	a0,s1
ffffffffc020273e:	dbf1                	beqz	a5,ffffffffc0202712 <alloc_pages+0x34>
ffffffffc0202740:	ef9fd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0202744:	00093783          	ld	a5,0(s2)
ffffffffc0202748:	8526                	mv	a0,s1
ffffffffc020274a:	6f9c                	ld	a5,24(a5)
ffffffffc020274c:	9782                	jalr	a5
ffffffffc020274e:	842a                	mv	s0,a0
ffffffffc0202750:	ee3fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0202754:	4601                	li	a2,0
ffffffffc0202756:	85ce                	mv	a1,s3
ffffffffc0202758:	d469                	beqz	s0,ffffffffc0202722 <alloc_pages+0x44>
ffffffffc020275a:	70e2                	ld	ra,56(sp)
ffffffffc020275c:	8522                	mv	a0,s0
ffffffffc020275e:	7442                	ld	s0,48(sp)
ffffffffc0202760:	74a2                	ld	s1,40(sp)
ffffffffc0202762:	7902                	ld	s2,32(sp)
ffffffffc0202764:	69e2                	ld	s3,24(sp)
ffffffffc0202766:	6a42                	ld	s4,16(sp)
ffffffffc0202768:	6aa2                	ld	s5,8(sp)
ffffffffc020276a:	6b02                	ld	s6,0(sp)
ffffffffc020276c:	6121                	addi	sp,sp,64
ffffffffc020276e:	8082                	ret

ffffffffc0202770 <free_pages>:
ffffffffc0202770:	100027f3          	csrr	a5,sstatus
ffffffffc0202774:	8b89                	andi	a5,a5,2
ffffffffc0202776:	eb81                	bnez	a5,ffffffffc0202786 <free_pages+0x16>
ffffffffc0202778:	00017797          	auipc	a5,0x17
ffffffffc020277c:	eb07b783          	ld	a5,-336(a5) # ffffffffc0219628 <pmm_manager>
ffffffffc0202780:	0207b303          	ld	t1,32(a5)
ffffffffc0202784:	8302                	jr	t1
ffffffffc0202786:	1101                	addi	sp,sp,-32
ffffffffc0202788:	ec06                	sd	ra,24(sp)
ffffffffc020278a:	e822                	sd	s0,16(sp)
ffffffffc020278c:	e426                	sd	s1,8(sp)
ffffffffc020278e:	842a                	mv	s0,a0
ffffffffc0202790:	84ae                	mv	s1,a1
ffffffffc0202792:	ea7fd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0202796:	00017797          	auipc	a5,0x17
ffffffffc020279a:	e927b783          	ld	a5,-366(a5) # ffffffffc0219628 <pmm_manager>
ffffffffc020279e:	739c                	ld	a5,32(a5)
ffffffffc02027a0:	85a6                	mv	a1,s1
ffffffffc02027a2:	8522                	mv	a0,s0
ffffffffc02027a4:	9782                	jalr	a5
ffffffffc02027a6:	6442                	ld	s0,16(sp)
ffffffffc02027a8:	60e2                	ld	ra,24(sp)
ffffffffc02027aa:	64a2                	ld	s1,8(sp)
ffffffffc02027ac:	6105                	addi	sp,sp,32
ffffffffc02027ae:	e85fd06f          	j	ffffffffc0200632 <intr_enable>

ffffffffc02027b2 <nr_free_pages>:
ffffffffc02027b2:	100027f3          	csrr	a5,sstatus
ffffffffc02027b6:	8b89                	andi	a5,a5,2
ffffffffc02027b8:	eb81                	bnez	a5,ffffffffc02027c8 <nr_free_pages+0x16>
ffffffffc02027ba:	00017797          	auipc	a5,0x17
ffffffffc02027be:	e6e7b783          	ld	a5,-402(a5) # ffffffffc0219628 <pmm_manager>
ffffffffc02027c2:	0287b303          	ld	t1,40(a5)
ffffffffc02027c6:	8302                	jr	t1
ffffffffc02027c8:	1141                	addi	sp,sp,-16
ffffffffc02027ca:	e406                	sd	ra,8(sp)
ffffffffc02027cc:	e022                	sd	s0,0(sp)
ffffffffc02027ce:	e6bfd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02027d2:	00017797          	auipc	a5,0x17
ffffffffc02027d6:	e567b783          	ld	a5,-426(a5) # ffffffffc0219628 <pmm_manager>
ffffffffc02027da:	779c                	ld	a5,40(a5)
ffffffffc02027dc:	9782                	jalr	a5
ffffffffc02027de:	842a                	mv	s0,a0
ffffffffc02027e0:	e53fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc02027e4:	60a2                	ld	ra,8(sp)
ffffffffc02027e6:	8522                	mv	a0,s0
ffffffffc02027e8:	6402                	ld	s0,0(sp)
ffffffffc02027ea:	0141                	addi	sp,sp,16
ffffffffc02027ec:	8082                	ret

ffffffffc02027ee <pmm_init>:
ffffffffc02027ee:	00007797          	auipc	a5,0x7
ffffffffc02027f2:	a3a78793          	addi	a5,a5,-1478 # ffffffffc0209228 <default_pmm_manager>
ffffffffc02027f6:	638c                	ld	a1,0(a5)
ffffffffc02027f8:	1101                	addi	sp,sp,-32
ffffffffc02027fa:	e426                	sd	s1,8(sp)
ffffffffc02027fc:	00007517          	auipc	a0,0x7
ffffffffc0202800:	a6450513          	addi	a0,a0,-1436 # ffffffffc0209260 <default_pmm_manager+0x38>
ffffffffc0202804:	00017497          	auipc	s1,0x17
ffffffffc0202808:	e2448493          	addi	s1,s1,-476 # ffffffffc0219628 <pmm_manager>
ffffffffc020280c:	ec06                	sd	ra,24(sp)
ffffffffc020280e:	e822                	sd	s0,16(sp)
ffffffffc0202810:	e09c                	sd	a5,0(s1)
ffffffffc0202812:	8bbfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202816:	609c                	ld	a5,0(s1)
ffffffffc0202818:	00017417          	auipc	s0,0x17
ffffffffc020281c:	e1840413          	addi	s0,s0,-488 # ffffffffc0219630 <va_pa_offset>
ffffffffc0202820:	679c                	ld	a5,8(a5)
ffffffffc0202822:	9782                	jalr	a5
ffffffffc0202824:	57f5                	li	a5,-3
ffffffffc0202826:	07fa                	slli	a5,a5,0x1e
ffffffffc0202828:	00007517          	auipc	a0,0x7
ffffffffc020282c:	a5050513          	addi	a0,a0,-1456 # ffffffffc0209278 <default_pmm_manager+0x50>
ffffffffc0202830:	e01c                	sd	a5,0(s0)
ffffffffc0202832:	89bfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202836:	44300693          	li	a3,1091
ffffffffc020283a:	06d6                	slli	a3,a3,0x15
ffffffffc020283c:	40100613          	li	a2,1025
ffffffffc0202840:	0656                	slli	a2,a2,0x15
ffffffffc0202842:	088005b7          	lui	a1,0x8800
ffffffffc0202846:	16fd                	addi	a3,a3,-1
ffffffffc0202848:	00007517          	auipc	a0,0x7
ffffffffc020284c:	a4850513          	addi	a0,a0,-1464 # ffffffffc0209290 <default_pmm_manager+0x68>
ffffffffc0202850:	87dfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202854:	777d                	lui	a4,0xfffff
ffffffffc0202856:	00018797          	auipc	a5,0x18
ffffffffc020285a:	ef178793          	addi	a5,a5,-271 # ffffffffc021a747 <end+0xfff>
ffffffffc020285e:	8ff9                	and	a5,a5,a4
ffffffffc0202860:	00088737          	lui	a4,0x88
ffffffffc0202864:	60070713          	addi	a4,a4,1536 # 88600 <kern_entry-0xffffffffc0177a00>
ffffffffc0202868:	00017597          	auipc	a1,0x17
ffffffffc020286c:	c8858593          	addi	a1,a1,-888 # ffffffffc02194f0 <npage>
ffffffffc0202870:	00017617          	auipc	a2,0x17
ffffffffc0202874:	dd060613          	addi	a2,a2,-560 # ffffffffc0219640 <pages>
ffffffffc0202878:	e198                	sd	a4,0(a1)
ffffffffc020287a:	e21c                	sd	a5,0(a2)
ffffffffc020287c:	4701                	li	a4,0
ffffffffc020287e:	4505                	li	a0,1
ffffffffc0202880:	fff80837          	lui	a6,0xfff80
ffffffffc0202884:	a011                	j	ffffffffc0202888 <pmm_init+0x9a>
ffffffffc0202886:	621c                	ld	a5,0(a2)
ffffffffc0202888:	00671693          	slli	a3,a4,0x6
ffffffffc020288c:	97b6                	add	a5,a5,a3
ffffffffc020288e:	07a1                	addi	a5,a5,8
ffffffffc0202890:	40a7b02f          	amoor.d	zero,a0,(a5)
ffffffffc0202894:	0005b883          	ld	a7,0(a1)
ffffffffc0202898:	0705                	addi	a4,a4,1
ffffffffc020289a:	010886b3          	add	a3,a7,a6
ffffffffc020289e:	fed764e3          	bltu	a4,a3,ffffffffc0202886 <pmm_init+0x98>
ffffffffc02028a2:	6208                	ld	a0,0(a2)
ffffffffc02028a4:	069a                	slli	a3,a3,0x6
ffffffffc02028a6:	c02007b7          	lui	a5,0xc0200
ffffffffc02028aa:	96aa                	add	a3,a3,a0
ffffffffc02028ac:	06f6e163          	bltu	a3,a5,ffffffffc020290e <pmm_init+0x120>
ffffffffc02028b0:	601c                	ld	a5,0(s0)
ffffffffc02028b2:	44300593          	li	a1,1091
ffffffffc02028b6:	05d6                	slli	a1,a1,0x15
ffffffffc02028b8:	8e9d                	sub	a3,a3,a5
ffffffffc02028ba:	02b6f363          	bgeu	a3,a1,ffffffffc02028e0 <pmm_init+0xf2>
ffffffffc02028be:	6785                	lui	a5,0x1
ffffffffc02028c0:	17fd                	addi	a5,a5,-1
ffffffffc02028c2:	96be                	add	a3,a3,a5
ffffffffc02028c4:	00c6d793          	srli	a5,a3,0xc
ffffffffc02028c8:	0717fb63          	bgeu	a5,a7,ffffffffc020293e <pmm_init+0x150>
ffffffffc02028cc:	6098                	ld	a4,0(s1)
ffffffffc02028ce:	767d                	lui	a2,0xfffff
ffffffffc02028d0:	8ef1                	and	a3,a3,a2
ffffffffc02028d2:	97c2                	add	a5,a5,a6
ffffffffc02028d4:	6b18                	ld	a4,16(a4)
ffffffffc02028d6:	8d95                	sub	a1,a1,a3
ffffffffc02028d8:	079a                	slli	a5,a5,0x6
ffffffffc02028da:	81b1                	srli	a1,a1,0xc
ffffffffc02028dc:	953e                	add	a0,a0,a5
ffffffffc02028de:	9702                	jalr	a4
ffffffffc02028e0:	0000a697          	auipc	a3,0xa
ffffffffc02028e4:	72068693          	addi	a3,a3,1824 # ffffffffc020d000 <boot_page_table_sv39>
ffffffffc02028e8:	00017797          	auipc	a5,0x17
ffffffffc02028ec:	c0d7b023          	sd	a3,-1024(a5) # ffffffffc02194e8 <boot_pgdir>
ffffffffc02028f0:	c02007b7          	lui	a5,0xc0200
ffffffffc02028f4:	02f6e963          	bltu	a3,a5,ffffffffc0202926 <pmm_init+0x138>
ffffffffc02028f8:	601c                	ld	a5,0(s0)
ffffffffc02028fa:	60e2                	ld	ra,24(sp)
ffffffffc02028fc:	6442                	ld	s0,16(sp)
ffffffffc02028fe:	8e9d                	sub	a3,a3,a5
ffffffffc0202900:	00017797          	auipc	a5,0x17
ffffffffc0202904:	d2d7bc23          	sd	a3,-712(a5) # ffffffffc0219638 <boot_cr3>
ffffffffc0202908:	64a2                	ld	s1,8(sp)
ffffffffc020290a:	6105                	addi	sp,sp,32
ffffffffc020290c:	8082                	ret
ffffffffc020290e:	00006617          	auipc	a2,0x6
ffffffffc0202912:	3f260613          	addi	a2,a2,1010 # ffffffffc0208d00 <commands+0xb08>
ffffffffc0202916:	07f00593          	li	a1,127
ffffffffc020291a:	00007517          	auipc	a0,0x7
ffffffffc020291e:	99e50513          	addi	a0,a0,-1634 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0202922:	8e7fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202926:	00006617          	auipc	a2,0x6
ffffffffc020292a:	3da60613          	addi	a2,a2,986 # ffffffffc0208d00 <commands+0xb08>
ffffffffc020292e:	0c100593          	li	a1,193
ffffffffc0202932:	00007517          	auipc	a0,0x7
ffffffffc0202936:	98650513          	addi	a0,a0,-1658 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc020293a:	8cffd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020293e:	d85ff0ef          	jal	ra,ffffffffc02026c2 <pa2page.part.0>

ffffffffc0202942 <get_pte>:
ffffffffc0202942:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0202946:	1ff7f793          	andi	a5,a5,511
ffffffffc020294a:	7139                	addi	sp,sp,-64
ffffffffc020294c:	078e                	slli	a5,a5,0x3
ffffffffc020294e:	f426                	sd	s1,40(sp)
ffffffffc0202950:	00f504b3          	add	s1,a0,a5
ffffffffc0202954:	6094                	ld	a3,0(s1)
ffffffffc0202956:	f04a                	sd	s2,32(sp)
ffffffffc0202958:	ec4e                	sd	s3,24(sp)
ffffffffc020295a:	e852                	sd	s4,16(sp)
ffffffffc020295c:	fc06                	sd	ra,56(sp)
ffffffffc020295e:	f822                	sd	s0,48(sp)
ffffffffc0202960:	e456                	sd	s5,8(sp)
ffffffffc0202962:	e05a                	sd	s6,0(sp)
ffffffffc0202964:	0016f793          	andi	a5,a3,1
ffffffffc0202968:	892e                	mv	s2,a1
ffffffffc020296a:	89b2                	mv	s3,a2
ffffffffc020296c:	00017a17          	auipc	s4,0x17
ffffffffc0202970:	b84a0a13          	addi	s4,s4,-1148 # ffffffffc02194f0 <npage>
ffffffffc0202974:	e7b5                	bnez	a5,ffffffffc02029e0 <get_pte+0x9e>
ffffffffc0202976:	12060b63          	beqz	a2,ffffffffc0202aac <get_pte+0x16a>
ffffffffc020297a:	4505                	li	a0,1
ffffffffc020297c:	d63ff0ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0202980:	842a                	mv	s0,a0
ffffffffc0202982:	12050563          	beqz	a0,ffffffffc0202aac <get_pte+0x16a>
ffffffffc0202986:	00017b17          	auipc	s6,0x17
ffffffffc020298a:	cbab0b13          	addi	s6,s6,-838 # ffffffffc0219640 <pages>
ffffffffc020298e:	000b3503          	ld	a0,0(s6)
ffffffffc0202992:	00080ab7          	lui	s5,0x80
ffffffffc0202996:	00017a17          	auipc	s4,0x17
ffffffffc020299a:	b5aa0a13          	addi	s4,s4,-1190 # ffffffffc02194f0 <npage>
ffffffffc020299e:	40a40533          	sub	a0,s0,a0
ffffffffc02029a2:	8519                	srai	a0,a0,0x6
ffffffffc02029a4:	9556                	add	a0,a0,s5
ffffffffc02029a6:	000a3703          	ld	a4,0(s4)
ffffffffc02029aa:	00c51793          	slli	a5,a0,0xc
ffffffffc02029ae:	4685                	li	a3,1
ffffffffc02029b0:	c014                	sw	a3,0(s0)
ffffffffc02029b2:	83b1                	srli	a5,a5,0xc
ffffffffc02029b4:	0532                	slli	a0,a0,0xc
ffffffffc02029b6:	14e7f263          	bgeu	a5,a4,ffffffffc0202afa <get_pte+0x1b8>
ffffffffc02029ba:	00017797          	auipc	a5,0x17
ffffffffc02029be:	c767b783          	ld	a5,-906(a5) # ffffffffc0219630 <va_pa_offset>
ffffffffc02029c2:	6605                	lui	a2,0x1
ffffffffc02029c4:	4581                	li	a1,0
ffffffffc02029c6:	953e                	add	a0,a0,a5
ffffffffc02029c8:	15e050ef          	jal	ra,ffffffffc0207b26 <memset>
ffffffffc02029cc:	000b3683          	ld	a3,0(s6)
ffffffffc02029d0:	40d406b3          	sub	a3,s0,a3
ffffffffc02029d4:	8699                	srai	a3,a3,0x6
ffffffffc02029d6:	96d6                	add	a3,a3,s5
ffffffffc02029d8:	06aa                	slli	a3,a3,0xa
ffffffffc02029da:	0116e693          	ori	a3,a3,17
ffffffffc02029de:	e094                	sd	a3,0(s1)
ffffffffc02029e0:	77fd                	lui	a5,0xfffff
ffffffffc02029e2:	068a                	slli	a3,a3,0x2
ffffffffc02029e4:	000a3703          	ld	a4,0(s4)
ffffffffc02029e8:	8efd                	and	a3,a3,a5
ffffffffc02029ea:	00c6d793          	srli	a5,a3,0xc
ffffffffc02029ee:	0ce7f163          	bgeu	a5,a4,ffffffffc0202ab0 <get_pte+0x16e>
ffffffffc02029f2:	00017a97          	auipc	s5,0x17
ffffffffc02029f6:	c3ea8a93          	addi	s5,s5,-962 # ffffffffc0219630 <va_pa_offset>
ffffffffc02029fa:	000ab403          	ld	s0,0(s5)
ffffffffc02029fe:	01595793          	srli	a5,s2,0x15
ffffffffc0202a02:	1ff7f793          	andi	a5,a5,511
ffffffffc0202a06:	96a2                	add	a3,a3,s0
ffffffffc0202a08:	00379413          	slli	s0,a5,0x3
ffffffffc0202a0c:	9436                	add	s0,s0,a3
ffffffffc0202a0e:	6014                	ld	a3,0(s0)
ffffffffc0202a10:	0016f793          	andi	a5,a3,1
ffffffffc0202a14:	e3ad                	bnez	a5,ffffffffc0202a76 <get_pte+0x134>
ffffffffc0202a16:	08098b63          	beqz	s3,ffffffffc0202aac <get_pte+0x16a>
ffffffffc0202a1a:	4505                	li	a0,1
ffffffffc0202a1c:	cc3ff0ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0202a20:	84aa                	mv	s1,a0
ffffffffc0202a22:	c549                	beqz	a0,ffffffffc0202aac <get_pte+0x16a>
ffffffffc0202a24:	00017b17          	auipc	s6,0x17
ffffffffc0202a28:	c1cb0b13          	addi	s6,s6,-996 # ffffffffc0219640 <pages>
ffffffffc0202a2c:	000b3503          	ld	a0,0(s6)
ffffffffc0202a30:	000809b7          	lui	s3,0x80
ffffffffc0202a34:	000a3703          	ld	a4,0(s4)
ffffffffc0202a38:	40a48533          	sub	a0,s1,a0
ffffffffc0202a3c:	8519                	srai	a0,a0,0x6
ffffffffc0202a3e:	954e                	add	a0,a0,s3
ffffffffc0202a40:	00c51793          	slli	a5,a0,0xc
ffffffffc0202a44:	4685                	li	a3,1
ffffffffc0202a46:	c094                	sw	a3,0(s1)
ffffffffc0202a48:	83b1                	srli	a5,a5,0xc
ffffffffc0202a4a:	0532                	slli	a0,a0,0xc
ffffffffc0202a4c:	08e7fa63          	bgeu	a5,a4,ffffffffc0202ae0 <get_pte+0x19e>
ffffffffc0202a50:	000ab783          	ld	a5,0(s5)
ffffffffc0202a54:	6605                	lui	a2,0x1
ffffffffc0202a56:	4581                	li	a1,0
ffffffffc0202a58:	953e                	add	a0,a0,a5
ffffffffc0202a5a:	0cc050ef          	jal	ra,ffffffffc0207b26 <memset>
ffffffffc0202a5e:	000b3683          	ld	a3,0(s6)
ffffffffc0202a62:	40d486b3          	sub	a3,s1,a3
ffffffffc0202a66:	8699                	srai	a3,a3,0x6
ffffffffc0202a68:	96ce                	add	a3,a3,s3
ffffffffc0202a6a:	06aa                	slli	a3,a3,0xa
ffffffffc0202a6c:	0116e693          	ori	a3,a3,17
ffffffffc0202a70:	e014                	sd	a3,0(s0)
ffffffffc0202a72:	000a3703          	ld	a4,0(s4)
ffffffffc0202a76:	068a                	slli	a3,a3,0x2
ffffffffc0202a78:	757d                	lui	a0,0xfffff
ffffffffc0202a7a:	8ee9                	and	a3,a3,a0
ffffffffc0202a7c:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202a80:	04e7f463          	bgeu	a5,a4,ffffffffc0202ac8 <get_pte+0x186>
ffffffffc0202a84:	000ab503          	ld	a0,0(s5)
ffffffffc0202a88:	00c95913          	srli	s2,s2,0xc
ffffffffc0202a8c:	1ff97913          	andi	s2,s2,511
ffffffffc0202a90:	96aa                	add	a3,a3,a0
ffffffffc0202a92:	00391513          	slli	a0,s2,0x3
ffffffffc0202a96:	9536                	add	a0,a0,a3
ffffffffc0202a98:	70e2                	ld	ra,56(sp)
ffffffffc0202a9a:	7442                	ld	s0,48(sp)
ffffffffc0202a9c:	74a2                	ld	s1,40(sp)
ffffffffc0202a9e:	7902                	ld	s2,32(sp)
ffffffffc0202aa0:	69e2                	ld	s3,24(sp)
ffffffffc0202aa2:	6a42                	ld	s4,16(sp)
ffffffffc0202aa4:	6aa2                	ld	s5,8(sp)
ffffffffc0202aa6:	6b02                	ld	s6,0(sp)
ffffffffc0202aa8:	6121                	addi	sp,sp,64
ffffffffc0202aaa:	8082                	ret
ffffffffc0202aac:	4501                	li	a0,0
ffffffffc0202aae:	b7ed                	j	ffffffffc0202a98 <get_pte+0x156>
ffffffffc0202ab0:	00006617          	auipc	a2,0x6
ffffffffc0202ab4:	1e060613          	addi	a2,a2,480 # ffffffffc0208c90 <commands+0xa98>
ffffffffc0202ab8:	0fe00593          	li	a1,254
ffffffffc0202abc:	00006517          	auipc	a0,0x6
ffffffffc0202ac0:	7fc50513          	addi	a0,a0,2044 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0202ac4:	f44fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ac8:	00006617          	auipc	a2,0x6
ffffffffc0202acc:	1c860613          	addi	a2,a2,456 # ffffffffc0208c90 <commands+0xa98>
ffffffffc0202ad0:	10900593          	li	a1,265
ffffffffc0202ad4:	00006517          	auipc	a0,0x6
ffffffffc0202ad8:	7e450513          	addi	a0,a0,2020 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0202adc:	f2cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ae0:	86aa                	mv	a3,a0
ffffffffc0202ae2:	00006617          	auipc	a2,0x6
ffffffffc0202ae6:	1ae60613          	addi	a2,a2,430 # ffffffffc0208c90 <commands+0xa98>
ffffffffc0202aea:	10600593          	li	a1,262
ffffffffc0202aee:	00006517          	auipc	a0,0x6
ffffffffc0202af2:	7ca50513          	addi	a0,a0,1994 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0202af6:	f12fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202afa:	86aa                	mv	a3,a0
ffffffffc0202afc:	00006617          	auipc	a2,0x6
ffffffffc0202b00:	19460613          	addi	a2,a2,404 # ffffffffc0208c90 <commands+0xa98>
ffffffffc0202b04:	0fa00593          	li	a1,250
ffffffffc0202b08:	00006517          	auipc	a0,0x6
ffffffffc0202b0c:	7b050513          	addi	a0,a0,1968 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0202b10:	ef8fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202b14 <unmap_range>:
ffffffffc0202b14:	711d                	addi	sp,sp,-96
ffffffffc0202b16:	00c5e7b3          	or	a5,a1,a2
ffffffffc0202b1a:	ec86                	sd	ra,88(sp)
ffffffffc0202b1c:	e8a2                	sd	s0,80(sp)
ffffffffc0202b1e:	e4a6                	sd	s1,72(sp)
ffffffffc0202b20:	e0ca                	sd	s2,64(sp)
ffffffffc0202b22:	fc4e                	sd	s3,56(sp)
ffffffffc0202b24:	f852                	sd	s4,48(sp)
ffffffffc0202b26:	f456                	sd	s5,40(sp)
ffffffffc0202b28:	f05a                	sd	s6,32(sp)
ffffffffc0202b2a:	ec5e                	sd	s7,24(sp)
ffffffffc0202b2c:	e862                	sd	s8,16(sp)
ffffffffc0202b2e:	e466                	sd	s9,8(sp)
ffffffffc0202b30:	17d2                	slli	a5,a5,0x34
ffffffffc0202b32:	ebf1                	bnez	a5,ffffffffc0202c06 <unmap_range+0xf2>
ffffffffc0202b34:	002007b7          	lui	a5,0x200
ffffffffc0202b38:	842e                	mv	s0,a1
ffffffffc0202b3a:	0af5e663          	bltu	a1,a5,ffffffffc0202be6 <unmap_range+0xd2>
ffffffffc0202b3e:	8932                	mv	s2,a2
ffffffffc0202b40:	0ac5f363          	bgeu	a1,a2,ffffffffc0202be6 <unmap_range+0xd2>
ffffffffc0202b44:	4785                	li	a5,1
ffffffffc0202b46:	07fe                	slli	a5,a5,0x1f
ffffffffc0202b48:	08c7ef63          	bltu	a5,a2,ffffffffc0202be6 <unmap_range+0xd2>
ffffffffc0202b4c:	89aa                	mv	s3,a0
ffffffffc0202b4e:	6a05                	lui	s4,0x1
ffffffffc0202b50:	00017c97          	auipc	s9,0x17
ffffffffc0202b54:	9a0c8c93          	addi	s9,s9,-1632 # ffffffffc02194f0 <npage>
ffffffffc0202b58:	00017c17          	auipc	s8,0x17
ffffffffc0202b5c:	ae8c0c13          	addi	s8,s8,-1304 # ffffffffc0219640 <pages>
ffffffffc0202b60:	fff80bb7          	lui	s7,0xfff80
ffffffffc0202b64:	00200b37          	lui	s6,0x200
ffffffffc0202b68:	ffe00ab7          	lui	s5,0xffe00
ffffffffc0202b6c:	4601                	li	a2,0
ffffffffc0202b6e:	85a2                	mv	a1,s0
ffffffffc0202b70:	854e                	mv	a0,s3
ffffffffc0202b72:	dd1ff0ef          	jal	ra,ffffffffc0202942 <get_pte>
ffffffffc0202b76:	84aa                	mv	s1,a0
ffffffffc0202b78:	cd21                	beqz	a0,ffffffffc0202bd0 <unmap_range+0xbc>
ffffffffc0202b7a:	611c                	ld	a5,0(a0)
ffffffffc0202b7c:	e38d                	bnez	a5,ffffffffc0202b9e <unmap_range+0x8a>
ffffffffc0202b7e:	9452                	add	s0,s0,s4
ffffffffc0202b80:	ff2466e3          	bltu	s0,s2,ffffffffc0202b6c <unmap_range+0x58>
ffffffffc0202b84:	60e6                	ld	ra,88(sp)
ffffffffc0202b86:	6446                	ld	s0,80(sp)
ffffffffc0202b88:	64a6                	ld	s1,72(sp)
ffffffffc0202b8a:	6906                	ld	s2,64(sp)
ffffffffc0202b8c:	79e2                	ld	s3,56(sp)
ffffffffc0202b8e:	7a42                	ld	s4,48(sp)
ffffffffc0202b90:	7aa2                	ld	s5,40(sp)
ffffffffc0202b92:	7b02                	ld	s6,32(sp)
ffffffffc0202b94:	6be2                	ld	s7,24(sp)
ffffffffc0202b96:	6c42                	ld	s8,16(sp)
ffffffffc0202b98:	6ca2                	ld	s9,8(sp)
ffffffffc0202b9a:	6125                	addi	sp,sp,96
ffffffffc0202b9c:	8082                	ret
ffffffffc0202b9e:	0017f713          	andi	a4,a5,1
ffffffffc0202ba2:	df71                	beqz	a4,ffffffffc0202b7e <unmap_range+0x6a>
ffffffffc0202ba4:	000cb703          	ld	a4,0(s9)
ffffffffc0202ba8:	078a                	slli	a5,a5,0x2
ffffffffc0202baa:	83b1                	srli	a5,a5,0xc
ffffffffc0202bac:	06e7fd63          	bgeu	a5,a4,ffffffffc0202c26 <unmap_range+0x112>
ffffffffc0202bb0:	000c3503          	ld	a0,0(s8)
ffffffffc0202bb4:	97de                	add	a5,a5,s7
ffffffffc0202bb6:	079a                	slli	a5,a5,0x6
ffffffffc0202bb8:	953e                	add	a0,a0,a5
ffffffffc0202bba:	411c                	lw	a5,0(a0)
ffffffffc0202bbc:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202bc0:	c118                	sw	a4,0(a0)
ffffffffc0202bc2:	cf11                	beqz	a4,ffffffffc0202bde <unmap_range+0xca>
ffffffffc0202bc4:	0004b023          	sd	zero,0(s1)
ffffffffc0202bc8:	12040073          	sfence.vma	s0
ffffffffc0202bcc:	9452                	add	s0,s0,s4
ffffffffc0202bce:	bf4d                	j	ffffffffc0202b80 <unmap_range+0x6c>
ffffffffc0202bd0:	945a                	add	s0,s0,s6
ffffffffc0202bd2:	01547433          	and	s0,s0,s5
ffffffffc0202bd6:	d45d                	beqz	s0,ffffffffc0202b84 <unmap_range+0x70>
ffffffffc0202bd8:	f9246ae3          	bltu	s0,s2,ffffffffc0202b6c <unmap_range+0x58>
ffffffffc0202bdc:	b765                	j	ffffffffc0202b84 <unmap_range+0x70>
ffffffffc0202bde:	4585                	li	a1,1
ffffffffc0202be0:	b91ff0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0202be4:	b7c5                	j	ffffffffc0202bc4 <unmap_range+0xb0>
ffffffffc0202be6:	00006697          	auipc	a3,0x6
ffffffffc0202bea:	71268693          	addi	a3,a3,1810 # ffffffffc02092f8 <default_pmm_manager+0xd0>
ffffffffc0202bee:	00006617          	auipc	a2,0x6
ffffffffc0202bf2:	a1a60613          	addi	a2,a2,-1510 # ffffffffc0208608 <commands+0x410>
ffffffffc0202bf6:	14100593          	li	a1,321
ffffffffc0202bfa:	00006517          	auipc	a0,0x6
ffffffffc0202bfe:	6be50513          	addi	a0,a0,1726 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0202c02:	e06fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c06:	00006697          	auipc	a3,0x6
ffffffffc0202c0a:	6c268693          	addi	a3,a3,1730 # ffffffffc02092c8 <default_pmm_manager+0xa0>
ffffffffc0202c0e:	00006617          	auipc	a2,0x6
ffffffffc0202c12:	9fa60613          	addi	a2,a2,-1542 # ffffffffc0208608 <commands+0x410>
ffffffffc0202c16:	14000593          	li	a1,320
ffffffffc0202c1a:	00006517          	auipc	a0,0x6
ffffffffc0202c1e:	69e50513          	addi	a0,a0,1694 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0202c22:	de6fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c26:	a9dff0ef          	jal	ra,ffffffffc02026c2 <pa2page.part.0>

ffffffffc0202c2a <exit_range>:
ffffffffc0202c2a:	715d                	addi	sp,sp,-80
ffffffffc0202c2c:	00c5e7b3          	or	a5,a1,a2
ffffffffc0202c30:	e486                	sd	ra,72(sp)
ffffffffc0202c32:	e0a2                	sd	s0,64(sp)
ffffffffc0202c34:	fc26                	sd	s1,56(sp)
ffffffffc0202c36:	f84a                	sd	s2,48(sp)
ffffffffc0202c38:	f44e                	sd	s3,40(sp)
ffffffffc0202c3a:	f052                	sd	s4,32(sp)
ffffffffc0202c3c:	ec56                	sd	s5,24(sp)
ffffffffc0202c3e:	e85a                	sd	s6,16(sp)
ffffffffc0202c40:	e45e                	sd	s7,8(sp)
ffffffffc0202c42:	17d2                	slli	a5,a5,0x34
ffffffffc0202c44:	e3f1                	bnez	a5,ffffffffc0202d08 <exit_range+0xde>
ffffffffc0202c46:	002007b7          	lui	a5,0x200
ffffffffc0202c4a:	08f5ef63          	bltu	a1,a5,ffffffffc0202ce8 <exit_range+0xbe>
ffffffffc0202c4e:	89b2                	mv	s3,a2
ffffffffc0202c50:	08c5fc63          	bgeu	a1,a2,ffffffffc0202ce8 <exit_range+0xbe>
ffffffffc0202c54:	4785                	li	a5,1
ffffffffc0202c56:	ffe004b7          	lui	s1,0xffe00
ffffffffc0202c5a:	07fe                	slli	a5,a5,0x1f
ffffffffc0202c5c:	8ced                	and	s1,s1,a1
ffffffffc0202c5e:	08c7e563          	bltu	a5,a2,ffffffffc0202ce8 <exit_range+0xbe>
ffffffffc0202c62:	8a2a                	mv	s4,a0
ffffffffc0202c64:	00017b17          	auipc	s6,0x17
ffffffffc0202c68:	88cb0b13          	addi	s6,s6,-1908 # ffffffffc02194f0 <npage>
ffffffffc0202c6c:	00017b97          	auipc	s7,0x17
ffffffffc0202c70:	9d4b8b93          	addi	s7,s7,-1580 # ffffffffc0219640 <pages>
ffffffffc0202c74:	fff80937          	lui	s2,0xfff80
ffffffffc0202c78:	00200ab7          	lui	s5,0x200
ffffffffc0202c7c:	a019                	j	ffffffffc0202c82 <exit_range+0x58>
ffffffffc0202c7e:	0334fe63          	bgeu	s1,s3,ffffffffc0202cba <exit_range+0x90>
ffffffffc0202c82:	01e4d413          	srli	s0,s1,0x1e
ffffffffc0202c86:	1ff47413          	andi	s0,s0,511
ffffffffc0202c8a:	040e                	slli	s0,s0,0x3
ffffffffc0202c8c:	9452                	add	s0,s0,s4
ffffffffc0202c8e:	601c                	ld	a5,0(s0)
ffffffffc0202c90:	0017f713          	andi	a4,a5,1
ffffffffc0202c94:	c30d                	beqz	a4,ffffffffc0202cb6 <exit_range+0x8c>
ffffffffc0202c96:	000b3703          	ld	a4,0(s6)
ffffffffc0202c9a:	078a                	slli	a5,a5,0x2
ffffffffc0202c9c:	83b1                	srli	a5,a5,0xc
ffffffffc0202c9e:	02e7f963          	bgeu	a5,a4,ffffffffc0202cd0 <exit_range+0xa6>
ffffffffc0202ca2:	000bb503          	ld	a0,0(s7)
ffffffffc0202ca6:	97ca                	add	a5,a5,s2
ffffffffc0202ca8:	079a                	slli	a5,a5,0x6
ffffffffc0202caa:	4585                	li	a1,1
ffffffffc0202cac:	953e                	add	a0,a0,a5
ffffffffc0202cae:	ac3ff0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0202cb2:	00043023          	sd	zero,0(s0)
ffffffffc0202cb6:	94d6                	add	s1,s1,s5
ffffffffc0202cb8:	f0f9                	bnez	s1,ffffffffc0202c7e <exit_range+0x54>
ffffffffc0202cba:	60a6                	ld	ra,72(sp)
ffffffffc0202cbc:	6406                	ld	s0,64(sp)
ffffffffc0202cbe:	74e2                	ld	s1,56(sp)
ffffffffc0202cc0:	7942                	ld	s2,48(sp)
ffffffffc0202cc2:	79a2                	ld	s3,40(sp)
ffffffffc0202cc4:	7a02                	ld	s4,32(sp)
ffffffffc0202cc6:	6ae2                	ld	s5,24(sp)
ffffffffc0202cc8:	6b42                	ld	s6,16(sp)
ffffffffc0202cca:	6ba2                	ld	s7,8(sp)
ffffffffc0202ccc:	6161                	addi	sp,sp,80
ffffffffc0202cce:	8082                	ret
ffffffffc0202cd0:	00006617          	auipc	a2,0x6
ffffffffc0202cd4:	05860613          	addi	a2,a2,88 # ffffffffc0208d28 <commands+0xb30>
ffffffffc0202cd8:	06200593          	li	a1,98
ffffffffc0202cdc:	00006517          	auipc	a0,0x6
ffffffffc0202ce0:	fdc50513          	addi	a0,a0,-36 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc0202ce4:	d24fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ce8:	00006697          	auipc	a3,0x6
ffffffffc0202cec:	61068693          	addi	a3,a3,1552 # ffffffffc02092f8 <default_pmm_manager+0xd0>
ffffffffc0202cf0:	00006617          	auipc	a2,0x6
ffffffffc0202cf4:	91860613          	addi	a2,a2,-1768 # ffffffffc0208608 <commands+0x410>
ffffffffc0202cf8:	15200593          	li	a1,338
ffffffffc0202cfc:	00006517          	auipc	a0,0x6
ffffffffc0202d00:	5bc50513          	addi	a0,a0,1468 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0202d04:	d04fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d08:	00006697          	auipc	a3,0x6
ffffffffc0202d0c:	5c068693          	addi	a3,a3,1472 # ffffffffc02092c8 <default_pmm_manager+0xa0>
ffffffffc0202d10:	00006617          	auipc	a2,0x6
ffffffffc0202d14:	8f860613          	addi	a2,a2,-1800 # ffffffffc0208608 <commands+0x410>
ffffffffc0202d18:	15100593          	li	a1,337
ffffffffc0202d1c:	00006517          	auipc	a0,0x6
ffffffffc0202d20:	59c50513          	addi	a0,a0,1436 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0202d24:	ce4fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202d28 <page_insert>:
ffffffffc0202d28:	7179                	addi	sp,sp,-48
ffffffffc0202d2a:	e44e                	sd	s3,8(sp)
ffffffffc0202d2c:	89b2                	mv	s3,a2
ffffffffc0202d2e:	f022                	sd	s0,32(sp)
ffffffffc0202d30:	4605                	li	a2,1
ffffffffc0202d32:	842e                	mv	s0,a1
ffffffffc0202d34:	85ce                	mv	a1,s3
ffffffffc0202d36:	ec26                	sd	s1,24(sp)
ffffffffc0202d38:	f406                	sd	ra,40(sp)
ffffffffc0202d3a:	e84a                	sd	s2,16(sp)
ffffffffc0202d3c:	e052                	sd	s4,0(sp)
ffffffffc0202d3e:	84b6                	mv	s1,a3
ffffffffc0202d40:	c03ff0ef          	jal	ra,ffffffffc0202942 <get_pte>
ffffffffc0202d44:	cd41                	beqz	a0,ffffffffc0202ddc <page_insert+0xb4>
ffffffffc0202d46:	4014                	lw	a3,0(s0)
ffffffffc0202d48:	611c                	ld	a5,0(a0)
ffffffffc0202d4a:	892a                	mv	s2,a0
ffffffffc0202d4c:	0016871b          	addiw	a4,a3,1
ffffffffc0202d50:	c018                	sw	a4,0(s0)
ffffffffc0202d52:	0017f713          	andi	a4,a5,1
ffffffffc0202d56:	eb1d                	bnez	a4,ffffffffc0202d8c <page_insert+0x64>
ffffffffc0202d58:	00017717          	auipc	a4,0x17
ffffffffc0202d5c:	8e873703          	ld	a4,-1816(a4) # ffffffffc0219640 <pages>
ffffffffc0202d60:	8c19                	sub	s0,s0,a4
ffffffffc0202d62:	000807b7          	lui	a5,0x80
ffffffffc0202d66:	8419                	srai	s0,s0,0x6
ffffffffc0202d68:	943e                	add	s0,s0,a5
ffffffffc0202d6a:	042a                	slli	s0,s0,0xa
ffffffffc0202d6c:	8c45                	or	s0,s0,s1
ffffffffc0202d6e:	00146413          	ori	s0,s0,1
ffffffffc0202d72:	00893023          	sd	s0,0(s2) # fffffffffff80000 <end+0x3fd668b8>
ffffffffc0202d76:	12098073          	sfence.vma	s3
ffffffffc0202d7a:	4501                	li	a0,0
ffffffffc0202d7c:	70a2                	ld	ra,40(sp)
ffffffffc0202d7e:	7402                	ld	s0,32(sp)
ffffffffc0202d80:	64e2                	ld	s1,24(sp)
ffffffffc0202d82:	6942                	ld	s2,16(sp)
ffffffffc0202d84:	69a2                	ld	s3,8(sp)
ffffffffc0202d86:	6a02                	ld	s4,0(sp)
ffffffffc0202d88:	6145                	addi	sp,sp,48
ffffffffc0202d8a:	8082                	ret
ffffffffc0202d8c:	078a                	slli	a5,a5,0x2
ffffffffc0202d8e:	83b1                	srli	a5,a5,0xc
ffffffffc0202d90:	00016717          	auipc	a4,0x16
ffffffffc0202d94:	76073703          	ld	a4,1888(a4) # ffffffffc02194f0 <npage>
ffffffffc0202d98:	04e7f463          	bgeu	a5,a4,ffffffffc0202de0 <page_insert+0xb8>
ffffffffc0202d9c:	00017a17          	auipc	s4,0x17
ffffffffc0202da0:	8a4a0a13          	addi	s4,s4,-1884 # ffffffffc0219640 <pages>
ffffffffc0202da4:	000a3703          	ld	a4,0(s4)
ffffffffc0202da8:	fff80537          	lui	a0,0xfff80
ffffffffc0202dac:	97aa                	add	a5,a5,a0
ffffffffc0202dae:	079a                	slli	a5,a5,0x6
ffffffffc0202db0:	97ba                	add	a5,a5,a4
ffffffffc0202db2:	00f40a63          	beq	s0,a5,ffffffffc0202dc6 <page_insert+0x9e>
ffffffffc0202db6:	4394                	lw	a3,0(a5)
ffffffffc0202db8:	fff6861b          	addiw	a2,a3,-1
ffffffffc0202dbc:	c390                	sw	a2,0(a5)
ffffffffc0202dbe:	c611                	beqz	a2,ffffffffc0202dca <page_insert+0xa2>
ffffffffc0202dc0:	12098073          	sfence.vma	s3
ffffffffc0202dc4:	bf71                	j	ffffffffc0202d60 <page_insert+0x38>
ffffffffc0202dc6:	c014                	sw	a3,0(s0)
ffffffffc0202dc8:	bf61                	j	ffffffffc0202d60 <page_insert+0x38>
ffffffffc0202dca:	4585                	li	a1,1
ffffffffc0202dcc:	853e                	mv	a0,a5
ffffffffc0202dce:	9a3ff0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0202dd2:	000a3703          	ld	a4,0(s4)
ffffffffc0202dd6:	12098073          	sfence.vma	s3
ffffffffc0202dda:	b759                	j	ffffffffc0202d60 <page_insert+0x38>
ffffffffc0202ddc:	5571                	li	a0,-4
ffffffffc0202dde:	bf79                	j	ffffffffc0202d7c <page_insert+0x54>
ffffffffc0202de0:	8e3ff0ef          	jal	ra,ffffffffc02026c2 <pa2page.part.0>

ffffffffc0202de4 <copy_range>:
ffffffffc0202de4:	7159                	addi	sp,sp,-112
ffffffffc0202de6:	00d667b3          	or	a5,a2,a3
ffffffffc0202dea:	f486                	sd	ra,104(sp)
ffffffffc0202dec:	f0a2                	sd	s0,96(sp)
ffffffffc0202dee:	eca6                	sd	s1,88(sp)
ffffffffc0202df0:	e8ca                	sd	s2,80(sp)
ffffffffc0202df2:	e4ce                	sd	s3,72(sp)
ffffffffc0202df4:	e0d2                	sd	s4,64(sp)
ffffffffc0202df6:	fc56                	sd	s5,56(sp)
ffffffffc0202df8:	f85a                	sd	s6,48(sp)
ffffffffc0202dfa:	f45e                	sd	s7,40(sp)
ffffffffc0202dfc:	f062                	sd	s8,32(sp)
ffffffffc0202dfe:	ec66                	sd	s9,24(sp)
ffffffffc0202e00:	e86a                	sd	s10,16(sp)
ffffffffc0202e02:	e46e                	sd	s11,8(sp)
ffffffffc0202e04:	17d2                	slli	a5,a5,0x34
ffffffffc0202e06:	1e079763          	bnez	a5,ffffffffc0202ff4 <copy_range+0x210>
ffffffffc0202e0a:	002007b7          	lui	a5,0x200
ffffffffc0202e0e:	8432                	mv	s0,a2
ffffffffc0202e10:	16f66a63          	bltu	a2,a5,ffffffffc0202f84 <copy_range+0x1a0>
ffffffffc0202e14:	8936                	mv	s2,a3
ffffffffc0202e16:	16d67763          	bgeu	a2,a3,ffffffffc0202f84 <copy_range+0x1a0>
ffffffffc0202e1a:	4785                	li	a5,1
ffffffffc0202e1c:	07fe                	slli	a5,a5,0x1f
ffffffffc0202e1e:	16d7e363          	bltu	a5,a3,ffffffffc0202f84 <copy_range+0x1a0>
ffffffffc0202e22:	5b7d                	li	s6,-1
ffffffffc0202e24:	8aaa                	mv	s5,a0
ffffffffc0202e26:	89ae                	mv	s3,a1
ffffffffc0202e28:	6a05                	lui	s4,0x1
ffffffffc0202e2a:	00016c97          	auipc	s9,0x16
ffffffffc0202e2e:	6c6c8c93          	addi	s9,s9,1734 # ffffffffc02194f0 <npage>
ffffffffc0202e32:	00017c17          	auipc	s8,0x17
ffffffffc0202e36:	80ec0c13          	addi	s8,s8,-2034 # ffffffffc0219640 <pages>
ffffffffc0202e3a:	00080bb7          	lui	s7,0x80
ffffffffc0202e3e:	00cb5b13          	srli	s6,s6,0xc
ffffffffc0202e42:	4601                	li	a2,0
ffffffffc0202e44:	85a2                	mv	a1,s0
ffffffffc0202e46:	854e                	mv	a0,s3
ffffffffc0202e48:	afbff0ef          	jal	ra,ffffffffc0202942 <get_pte>
ffffffffc0202e4c:	84aa                	mv	s1,a0
ffffffffc0202e4e:	c175                	beqz	a0,ffffffffc0202f32 <copy_range+0x14e>
ffffffffc0202e50:	611c                	ld	a5,0(a0)
ffffffffc0202e52:	8b85                	andi	a5,a5,1
ffffffffc0202e54:	e785                	bnez	a5,ffffffffc0202e7c <copy_range+0x98>
ffffffffc0202e56:	9452                	add	s0,s0,s4
ffffffffc0202e58:	ff2465e3          	bltu	s0,s2,ffffffffc0202e42 <copy_range+0x5e>
ffffffffc0202e5c:	4501                	li	a0,0
ffffffffc0202e5e:	70a6                	ld	ra,104(sp)
ffffffffc0202e60:	7406                	ld	s0,96(sp)
ffffffffc0202e62:	64e6                	ld	s1,88(sp)
ffffffffc0202e64:	6946                	ld	s2,80(sp)
ffffffffc0202e66:	69a6                	ld	s3,72(sp)
ffffffffc0202e68:	6a06                	ld	s4,64(sp)
ffffffffc0202e6a:	7ae2                	ld	s5,56(sp)
ffffffffc0202e6c:	7b42                	ld	s6,48(sp)
ffffffffc0202e6e:	7ba2                	ld	s7,40(sp)
ffffffffc0202e70:	7c02                	ld	s8,32(sp)
ffffffffc0202e72:	6ce2                	ld	s9,24(sp)
ffffffffc0202e74:	6d42                	ld	s10,16(sp)
ffffffffc0202e76:	6da2                	ld	s11,8(sp)
ffffffffc0202e78:	6165                	addi	sp,sp,112
ffffffffc0202e7a:	8082                	ret
ffffffffc0202e7c:	4605                	li	a2,1
ffffffffc0202e7e:	85a2                	mv	a1,s0
ffffffffc0202e80:	8556                	mv	a0,s5
ffffffffc0202e82:	ac1ff0ef          	jal	ra,ffffffffc0202942 <get_pte>
ffffffffc0202e86:	c161                	beqz	a0,ffffffffc0202f46 <copy_range+0x162>
ffffffffc0202e88:	609c                	ld	a5,0(s1)
ffffffffc0202e8a:	0017f713          	andi	a4,a5,1
ffffffffc0202e8e:	01f7f493          	andi	s1,a5,31
ffffffffc0202e92:	14070563          	beqz	a4,ffffffffc0202fdc <copy_range+0x1f8>
ffffffffc0202e96:	000cb683          	ld	a3,0(s9)
ffffffffc0202e9a:	078a                	slli	a5,a5,0x2
ffffffffc0202e9c:	00c7d713          	srli	a4,a5,0xc
ffffffffc0202ea0:	12d77263          	bgeu	a4,a3,ffffffffc0202fc4 <copy_range+0x1e0>
ffffffffc0202ea4:	000c3783          	ld	a5,0(s8)
ffffffffc0202ea8:	fff806b7          	lui	a3,0xfff80
ffffffffc0202eac:	9736                	add	a4,a4,a3
ffffffffc0202eae:	071a                	slli	a4,a4,0x6
ffffffffc0202eb0:	4505                	li	a0,1
ffffffffc0202eb2:	00e78db3          	add	s11,a5,a4
ffffffffc0202eb6:	829ff0ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0202eba:	8d2a                	mv	s10,a0
ffffffffc0202ebc:	0a0d8463          	beqz	s11,ffffffffc0202f64 <copy_range+0x180>
ffffffffc0202ec0:	c175                	beqz	a0,ffffffffc0202fa4 <copy_range+0x1c0>
ffffffffc0202ec2:	000c3703          	ld	a4,0(s8)
ffffffffc0202ec6:	000cb603          	ld	a2,0(s9)
ffffffffc0202eca:	40ed86b3          	sub	a3,s11,a4
ffffffffc0202ece:	8699                	srai	a3,a3,0x6
ffffffffc0202ed0:	96de                	add	a3,a3,s7
ffffffffc0202ed2:	0166f7b3          	and	a5,a3,s6
ffffffffc0202ed6:	06b2                	slli	a3,a3,0xc
ffffffffc0202ed8:	06c7fa63          	bgeu	a5,a2,ffffffffc0202f4c <copy_range+0x168>
ffffffffc0202edc:	40e507b3          	sub	a5,a0,a4
ffffffffc0202ee0:	00016717          	auipc	a4,0x16
ffffffffc0202ee4:	75070713          	addi	a4,a4,1872 # ffffffffc0219630 <va_pa_offset>
ffffffffc0202ee8:	6308                	ld	a0,0(a4)
ffffffffc0202eea:	8799                	srai	a5,a5,0x6
ffffffffc0202eec:	97de                	add	a5,a5,s7
ffffffffc0202eee:	0167f733          	and	a4,a5,s6
ffffffffc0202ef2:	00a685b3          	add	a1,a3,a0
ffffffffc0202ef6:	07b2                	slli	a5,a5,0xc
ffffffffc0202ef8:	04c77963          	bgeu	a4,a2,ffffffffc0202f4a <copy_range+0x166>
ffffffffc0202efc:	6605                	lui	a2,0x1
ffffffffc0202efe:	953e                	add	a0,a0,a5
ffffffffc0202f00:	439040ef          	jal	ra,ffffffffc0207b38 <memcpy>
ffffffffc0202f04:	86a6                	mv	a3,s1
ffffffffc0202f06:	8622                	mv	a2,s0
ffffffffc0202f08:	85ea                	mv	a1,s10
ffffffffc0202f0a:	8556                	mv	a0,s5
ffffffffc0202f0c:	e1dff0ef          	jal	ra,ffffffffc0202d28 <page_insert>
ffffffffc0202f10:	d139                	beqz	a0,ffffffffc0202e56 <copy_range+0x72>
ffffffffc0202f12:	00006697          	auipc	a3,0x6
ffffffffc0202f16:	44668693          	addi	a3,a3,1094 # ffffffffc0209358 <default_pmm_manager+0x130>
ffffffffc0202f1a:	00005617          	auipc	a2,0x5
ffffffffc0202f1e:	6ee60613          	addi	a2,a2,1774 # ffffffffc0208608 <commands+0x410>
ffffffffc0202f22:	19900593          	li	a1,409
ffffffffc0202f26:	00006517          	auipc	a0,0x6
ffffffffc0202f2a:	39250513          	addi	a0,a0,914 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0202f2e:	adafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202f32:	00200637          	lui	a2,0x200
ffffffffc0202f36:	9432                	add	s0,s0,a2
ffffffffc0202f38:	ffe00637          	lui	a2,0xffe00
ffffffffc0202f3c:	8c71                	and	s0,s0,a2
ffffffffc0202f3e:	dc19                	beqz	s0,ffffffffc0202e5c <copy_range+0x78>
ffffffffc0202f40:	f12461e3          	bltu	s0,s2,ffffffffc0202e42 <copy_range+0x5e>
ffffffffc0202f44:	bf21                	j	ffffffffc0202e5c <copy_range+0x78>
ffffffffc0202f46:	5571                	li	a0,-4
ffffffffc0202f48:	bf19                	j	ffffffffc0202e5e <copy_range+0x7a>
ffffffffc0202f4a:	86be                	mv	a3,a5
ffffffffc0202f4c:	00006617          	auipc	a2,0x6
ffffffffc0202f50:	d4460613          	addi	a2,a2,-700 # ffffffffc0208c90 <commands+0xa98>
ffffffffc0202f54:	06900593          	li	a1,105
ffffffffc0202f58:	00006517          	auipc	a0,0x6
ffffffffc0202f5c:	d6050513          	addi	a0,a0,-672 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc0202f60:	aa8fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202f64:	00006697          	auipc	a3,0x6
ffffffffc0202f68:	3d468693          	addi	a3,a3,980 # ffffffffc0209338 <default_pmm_manager+0x110>
ffffffffc0202f6c:	00005617          	auipc	a2,0x5
ffffffffc0202f70:	69c60613          	addi	a2,a2,1692 # ffffffffc0208608 <commands+0x410>
ffffffffc0202f74:	17e00593          	li	a1,382
ffffffffc0202f78:	00006517          	auipc	a0,0x6
ffffffffc0202f7c:	34050513          	addi	a0,a0,832 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0202f80:	a88fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202f84:	00006697          	auipc	a3,0x6
ffffffffc0202f88:	37468693          	addi	a3,a3,884 # ffffffffc02092f8 <default_pmm_manager+0xd0>
ffffffffc0202f8c:	00005617          	auipc	a2,0x5
ffffffffc0202f90:	67c60613          	addi	a2,a2,1660 # ffffffffc0208608 <commands+0x410>
ffffffffc0202f94:	16a00593          	li	a1,362
ffffffffc0202f98:	00006517          	auipc	a0,0x6
ffffffffc0202f9c:	32050513          	addi	a0,a0,800 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0202fa0:	a68fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202fa4:	00006697          	auipc	a3,0x6
ffffffffc0202fa8:	3a468693          	addi	a3,a3,932 # ffffffffc0209348 <default_pmm_manager+0x120>
ffffffffc0202fac:	00005617          	auipc	a2,0x5
ffffffffc0202fb0:	65c60613          	addi	a2,a2,1628 # ffffffffc0208608 <commands+0x410>
ffffffffc0202fb4:	17f00593          	li	a1,383
ffffffffc0202fb8:	00006517          	auipc	a0,0x6
ffffffffc0202fbc:	30050513          	addi	a0,a0,768 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0202fc0:	a48fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202fc4:	00006617          	auipc	a2,0x6
ffffffffc0202fc8:	d6460613          	addi	a2,a2,-668 # ffffffffc0208d28 <commands+0xb30>
ffffffffc0202fcc:	06200593          	li	a1,98
ffffffffc0202fd0:	00006517          	auipc	a0,0x6
ffffffffc0202fd4:	ce850513          	addi	a0,a0,-792 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc0202fd8:	a30fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202fdc:	00006617          	auipc	a2,0x6
ffffffffc0202fe0:	33460613          	addi	a2,a2,820 # ffffffffc0209310 <default_pmm_manager+0xe8>
ffffffffc0202fe4:	07400593          	li	a1,116
ffffffffc0202fe8:	00006517          	auipc	a0,0x6
ffffffffc0202fec:	cd050513          	addi	a0,a0,-816 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc0202ff0:	a18fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ff4:	00006697          	auipc	a3,0x6
ffffffffc0202ff8:	2d468693          	addi	a3,a3,724 # ffffffffc02092c8 <default_pmm_manager+0xa0>
ffffffffc0202ffc:	00005617          	auipc	a2,0x5
ffffffffc0203000:	60c60613          	addi	a2,a2,1548 # ffffffffc0208608 <commands+0x410>
ffffffffc0203004:	16900593          	li	a1,361
ffffffffc0203008:	00006517          	auipc	a0,0x6
ffffffffc020300c:	2b050513          	addi	a0,a0,688 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc0203010:	9f8fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203014 <tlb_invalidate>:
ffffffffc0203014:	12058073          	sfence.vma	a1
ffffffffc0203018:	8082                	ret

ffffffffc020301a <pgdir_alloc_page>:
ffffffffc020301a:	7179                	addi	sp,sp,-48
ffffffffc020301c:	e84a                	sd	s2,16(sp)
ffffffffc020301e:	892a                	mv	s2,a0
ffffffffc0203020:	4505                	li	a0,1
ffffffffc0203022:	f022                	sd	s0,32(sp)
ffffffffc0203024:	ec26                	sd	s1,24(sp)
ffffffffc0203026:	e44e                	sd	s3,8(sp)
ffffffffc0203028:	f406                	sd	ra,40(sp)
ffffffffc020302a:	84ae                	mv	s1,a1
ffffffffc020302c:	89b2                	mv	s3,a2
ffffffffc020302e:	eb0ff0ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc0203032:	842a                	mv	s0,a0
ffffffffc0203034:	cd05                	beqz	a0,ffffffffc020306c <pgdir_alloc_page+0x52>
ffffffffc0203036:	85aa                	mv	a1,a0
ffffffffc0203038:	86ce                	mv	a3,s3
ffffffffc020303a:	8626                	mv	a2,s1
ffffffffc020303c:	854a                	mv	a0,s2
ffffffffc020303e:	cebff0ef          	jal	ra,ffffffffc0202d28 <page_insert>
ffffffffc0203042:	ed0d                	bnez	a0,ffffffffc020307c <pgdir_alloc_page+0x62>
ffffffffc0203044:	00016797          	auipc	a5,0x16
ffffffffc0203048:	49c7a783          	lw	a5,1180(a5) # ffffffffc02194e0 <swap_init_ok>
ffffffffc020304c:	c385                	beqz	a5,ffffffffc020306c <pgdir_alloc_page+0x52>
ffffffffc020304e:	00016517          	auipc	a0,0x16
ffffffffc0203052:	4e253503          	ld	a0,1250(a0) # ffffffffc0219530 <check_mm_struct>
ffffffffc0203056:	c919                	beqz	a0,ffffffffc020306c <pgdir_alloc_page+0x52>
ffffffffc0203058:	4681                	li	a3,0
ffffffffc020305a:	8622                	mv	a2,s0
ffffffffc020305c:	85a6                	mv	a1,s1
ffffffffc020305e:	a25fe0ef          	jal	ra,ffffffffc0201a82 <swap_map_swappable>
ffffffffc0203062:	4018                	lw	a4,0(s0)
ffffffffc0203064:	fc04                	sd	s1,56(s0)
ffffffffc0203066:	4785                	li	a5,1
ffffffffc0203068:	02f71063          	bne	a4,a5,ffffffffc0203088 <pgdir_alloc_page+0x6e>
ffffffffc020306c:	70a2                	ld	ra,40(sp)
ffffffffc020306e:	8522                	mv	a0,s0
ffffffffc0203070:	7402                	ld	s0,32(sp)
ffffffffc0203072:	64e2                	ld	s1,24(sp)
ffffffffc0203074:	6942                	ld	s2,16(sp)
ffffffffc0203076:	69a2                	ld	s3,8(sp)
ffffffffc0203078:	6145                	addi	sp,sp,48
ffffffffc020307a:	8082                	ret
ffffffffc020307c:	8522                	mv	a0,s0
ffffffffc020307e:	4585                	li	a1,1
ffffffffc0203080:	ef0ff0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0203084:	4401                	li	s0,0
ffffffffc0203086:	b7dd                	j	ffffffffc020306c <pgdir_alloc_page+0x52>
ffffffffc0203088:	00006697          	auipc	a3,0x6
ffffffffc020308c:	2e068693          	addi	a3,a3,736 # ffffffffc0209368 <default_pmm_manager+0x140>
ffffffffc0203090:	00005617          	auipc	a2,0x5
ffffffffc0203094:	57860613          	addi	a2,a2,1400 # ffffffffc0208608 <commands+0x410>
ffffffffc0203098:	1d800593          	li	a1,472
ffffffffc020309c:	00006517          	auipc	a0,0x6
ffffffffc02030a0:	21c50513          	addi	a0,a0,540 # ffffffffc02092b8 <default_pmm_manager+0x90>
ffffffffc02030a4:	964fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02030a8 <phi_test_sema>:
ffffffffc02030a8:	4791                	li	a5,4
ffffffffc02030aa:	00a7ed63          	bltu	a5,a0,ffffffffc02030c4 <phi_test_sema+0x1c>
ffffffffc02030ae:	00016717          	auipc	a4,0x16
ffffffffc02030b2:	5d270713          	addi	a4,a4,1490 # ffffffffc0219680 <state_sema>
ffffffffc02030b6:	00251793          	slli	a5,a0,0x2
ffffffffc02030ba:	97ba                	add	a5,a5,a4
ffffffffc02030bc:	4394                	lw	a3,0(a5)
ffffffffc02030be:	4785                	li	a5,1
ffffffffc02030c0:	00f68363          	beq	a3,a5,ffffffffc02030c6 <phi_test_sema+0x1e>
ffffffffc02030c4:	8082                	ret
ffffffffc02030c6:	0045079b          	addiw	a5,a0,4
ffffffffc02030ca:	4615                	li	a2,5
ffffffffc02030cc:	02c7e7bb          	remw	a5,a5,a2
ffffffffc02030d0:	4689                	li	a3,2
ffffffffc02030d2:	078a                	slli	a5,a5,0x2
ffffffffc02030d4:	97ba                	add	a5,a5,a4
ffffffffc02030d6:	439c                	lw	a5,0(a5)
ffffffffc02030d8:	fed786e3          	beq	a5,a3,ffffffffc02030c4 <phi_test_sema+0x1c>
ffffffffc02030dc:	0015079b          	addiw	a5,a0,1
ffffffffc02030e0:	02c7e7bb          	remw	a5,a5,a2
ffffffffc02030e4:	078a                	slli	a5,a5,0x2
ffffffffc02030e6:	973e                	add	a4,a4,a5
ffffffffc02030e8:	431c                	lw	a5,0(a4)
ffffffffc02030ea:	fcd78de3          	beq	a5,a3,ffffffffc02030c4 <phi_test_sema+0x1c>
ffffffffc02030ee:	00151793          	slli	a5,a0,0x1
ffffffffc02030f2:	953e                	add	a0,a0,a5
ffffffffc02030f4:	050e                	slli	a0,a0,0x3
ffffffffc02030f6:	00016797          	auipc	a5,0x16
ffffffffc02030fa:	5ca78793          	addi	a5,a5,1482 # ffffffffc02196c0 <s>
ffffffffc02030fe:	953e                	add	a0,a0,a5
ffffffffc0203100:	a929                	j	ffffffffc020351a <up>

ffffffffc0203102 <phi_take_forks_sema.part.0>:
ffffffffc0203102:	1141                	addi	sp,sp,-16
ffffffffc0203104:	e022                	sd	s0,0(sp)
ffffffffc0203106:	842a                	mv	s0,a0
ffffffffc0203108:	00016517          	auipc	a0,0x16
ffffffffc020310c:	54850513          	addi	a0,a0,1352 # ffffffffc0219650 <mutex>
ffffffffc0203110:	e406                	sd	ra,8(sp)
ffffffffc0203112:	40a000ef          	jal	ra,ffffffffc020351c <down>
ffffffffc0203116:	00241713          	slli	a4,s0,0x2
ffffffffc020311a:	00016797          	auipc	a5,0x16
ffffffffc020311e:	56678793          	addi	a5,a5,1382 # ffffffffc0219680 <state_sema>
ffffffffc0203122:	97ba                	add	a5,a5,a4
ffffffffc0203124:	8522                	mv	a0,s0
ffffffffc0203126:	4705                	li	a4,1
ffffffffc0203128:	c398                	sw	a4,0(a5)
ffffffffc020312a:	f7fff0ef          	jal	ra,ffffffffc02030a8 <phi_test_sema>
ffffffffc020312e:	00016517          	auipc	a0,0x16
ffffffffc0203132:	52250513          	addi	a0,a0,1314 # ffffffffc0219650 <mutex>
ffffffffc0203136:	3e4000ef          	jal	ra,ffffffffc020351a <up>
ffffffffc020313a:	00141513          	slli	a0,s0,0x1
ffffffffc020313e:	942a                	add	s0,s0,a0
ffffffffc0203140:	040e                	slli	s0,s0,0x3
ffffffffc0203142:	00016517          	auipc	a0,0x16
ffffffffc0203146:	57e50513          	addi	a0,a0,1406 # ffffffffc02196c0 <s>
ffffffffc020314a:	9522                	add	a0,a0,s0
ffffffffc020314c:	6402                	ld	s0,0(sp)
ffffffffc020314e:	60a2                	ld	ra,8(sp)
ffffffffc0203150:	0141                	addi	sp,sp,16
ffffffffc0203152:	a6e9                	j	ffffffffc020351c <down>

ffffffffc0203154 <phi_put_forks_sema.part.0>:
ffffffffc0203154:	1101                	addi	sp,sp,-32
ffffffffc0203156:	e822                	sd	s0,16(sp)
ffffffffc0203158:	842a                	mv	s0,a0
ffffffffc020315a:	00016517          	auipc	a0,0x16
ffffffffc020315e:	4f650513          	addi	a0,a0,1270 # ffffffffc0219650 <mutex>
ffffffffc0203162:	ec06                	sd	ra,24(sp)
ffffffffc0203164:	e426                	sd	s1,8(sp)
ffffffffc0203166:	3b6000ef          	jal	ra,ffffffffc020351c <down>
ffffffffc020316a:	4495                	li	s1,5
ffffffffc020316c:	0014051b          	addiw	a0,s0,1
ffffffffc0203170:	0295653b          	remw	a0,a0,s1
ffffffffc0203174:	00241713          	slli	a4,s0,0x2
ffffffffc0203178:	00016797          	auipc	a5,0x16
ffffffffc020317c:	50878793          	addi	a5,a5,1288 # ffffffffc0219680 <state_sema>
ffffffffc0203180:	97ba                	add	a5,a5,a4
ffffffffc0203182:	0007a023          	sw	zero,0(a5)
ffffffffc0203186:	f23ff0ef          	jal	ra,ffffffffc02030a8 <phi_test_sema>
ffffffffc020318a:	0044051b          	addiw	a0,s0,4
ffffffffc020318e:	0295653b          	remw	a0,a0,s1
ffffffffc0203192:	f17ff0ef          	jal	ra,ffffffffc02030a8 <phi_test_sema>
ffffffffc0203196:	6442                	ld	s0,16(sp)
ffffffffc0203198:	60e2                	ld	ra,24(sp)
ffffffffc020319a:	64a2                	ld	s1,8(sp)
ffffffffc020319c:	00016517          	auipc	a0,0x16
ffffffffc02031a0:	4b450513          	addi	a0,a0,1204 # ffffffffc0219650 <mutex>
ffffffffc02031a4:	6105                	addi	sp,sp,32
ffffffffc02031a6:	ae95                	j	ffffffffc020351a <up>

ffffffffc02031a8 <philosopher_using_semaphore>:
ffffffffc02031a8:	7139                	addi	sp,sp,-64
ffffffffc02031aa:	f822                	sd	s0,48(sp)
ffffffffc02031ac:	0005041b          	sext.w	s0,a0
ffffffffc02031b0:	85a2                	mv	a1,s0
ffffffffc02031b2:	00006517          	auipc	a0,0x6
ffffffffc02031b6:	1ce50513          	addi	a0,a0,462 # ffffffffc0209380 <default_pmm_manager+0x158>
ffffffffc02031ba:	f426                	sd	s1,40(sp)
ffffffffc02031bc:	f04a                	sd	s2,32(sp)
ffffffffc02031be:	ec4e                	sd	s3,24(sp)
ffffffffc02031c0:	e852                	sd	s4,16(sp)
ffffffffc02031c2:	e456                	sd	s5,8(sp)
ffffffffc02031c4:	fc06                	sd	ra,56(sp)
ffffffffc02031c6:	4485                	li	s1,1
ffffffffc02031c8:	f05fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02031cc:	00006a97          	auipc	s5,0x6
ffffffffc02031d0:	1d4a8a93          	addi	s5,s5,468 # ffffffffc02093a0 <default_pmm_manager+0x178>
ffffffffc02031d4:	4a11                	li	s4,4
ffffffffc02031d6:	00006997          	auipc	s3,0x6
ffffffffc02031da:	1fa98993          	addi	s3,s3,506 # ffffffffc02093d0 <default_pmm_manager+0x1a8>
ffffffffc02031de:	4915                	li	s2,5
ffffffffc02031e0:	85a6                	mv	a1,s1
ffffffffc02031e2:	8622                	mv	a2,s0
ffffffffc02031e4:	8556                	mv	a0,s5
ffffffffc02031e6:	ee7fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02031ea:	4529                	li	a0,10
ffffffffc02031ec:	72c010ef          	jal	ra,ffffffffc0204918 <do_sleep>
ffffffffc02031f0:	8522                	mv	a0,s0
ffffffffc02031f2:	8622                	mv	a2,s0
ffffffffc02031f4:	85a6                	mv	a1,s1
ffffffffc02031f6:	048a6363          	bltu	s4,s0,ffffffffc020323c <philosopher_using_semaphore+0x94>
ffffffffc02031fa:	f09ff0ef          	jal	ra,ffffffffc0203102 <phi_take_forks_sema.part.0>
ffffffffc02031fe:	8622                	mv	a2,s0
ffffffffc0203200:	85a6                	mv	a1,s1
ffffffffc0203202:	854e                	mv	a0,s3
ffffffffc0203204:	ec9fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203208:	4529                	li	a0,10
ffffffffc020320a:	70e010ef          	jal	ra,ffffffffc0204918 <do_sleep>
ffffffffc020320e:	8522                	mv	a0,s0
ffffffffc0203210:	f45ff0ef          	jal	ra,ffffffffc0203154 <phi_put_forks_sema.part.0>
ffffffffc0203214:	2485                	addiw	s1,s1,1
ffffffffc0203216:	fd2495e3          	bne	s1,s2,ffffffffc02031e0 <philosopher_using_semaphore+0x38>
ffffffffc020321a:	85a2                	mv	a1,s0
ffffffffc020321c:	00006517          	auipc	a0,0x6
ffffffffc0203220:	1e450513          	addi	a0,a0,484 # ffffffffc0209400 <default_pmm_manager+0x1d8>
ffffffffc0203224:	ea9fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203228:	70e2                	ld	ra,56(sp)
ffffffffc020322a:	7442                	ld	s0,48(sp)
ffffffffc020322c:	74a2                	ld	s1,40(sp)
ffffffffc020322e:	7902                	ld	s2,32(sp)
ffffffffc0203230:	69e2                	ld	s3,24(sp)
ffffffffc0203232:	6a42                	ld	s4,16(sp)
ffffffffc0203234:	6aa2                	ld	s5,8(sp)
ffffffffc0203236:	4501                	li	a0,0
ffffffffc0203238:	6121                	addi	sp,sp,64
ffffffffc020323a:	8082                	ret
ffffffffc020323c:	854e                	mv	a0,s3
ffffffffc020323e:	e8ffc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203242:	4529                	li	a0,10
ffffffffc0203244:	6d4010ef          	jal	ra,ffffffffc0204918 <do_sleep>
ffffffffc0203248:	b7f1                	j	ffffffffc0203214 <philosopher_using_semaphore+0x6c>

ffffffffc020324a <check_sync>:
ffffffffc020324a:	7139                	addi	sp,sp,-64
ffffffffc020324c:	4585                	li	a1,1
ffffffffc020324e:	00016517          	auipc	a0,0x16
ffffffffc0203252:	40250513          	addi	a0,a0,1026 # ffffffffc0219650 <mutex>
ffffffffc0203256:	f822                	sd	s0,48(sp)
ffffffffc0203258:	f426                	sd	s1,40(sp)
ffffffffc020325a:	f04a                	sd	s2,32(sp)
ffffffffc020325c:	ec4e                	sd	s3,24(sp)
ffffffffc020325e:	e852                	sd	s4,16(sp)
ffffffffc0203260:	e456                	sd	s5,8(sp)
ffffffffc0203262:	fc06                	sd	ra,56(sp)
ffffffffc0203264:	00016917          	auipc	s2,0x16
ffffffffc0203268:	45c90913          	addi	s2,s2,1116 # ffffffffc02196c0 <s>
ffffffffc020326c:	2a6000ef          	jal	ra,ffffffffc0203512 <sem_init>
ffffffffc0203270:	00016497          	auipc	s1,0x16
ffffffffc0203274:	42848493          	addi	s1,s1,1064 # ffffffffc0219698 <philosopher_proc_sema>
ffffffffc0203278:	4401                	li	s0,0
ffffffffc020327a:	00000a97          	auipc	s5,0x0
ffffffffc020327e:	f2ea8a93          	addi	s5,s5,-210 # ffffffffc02031a8 <philosopher_using_semaphore>
ffffffffc0203282:	00006a17          	auipc	s4,0x6
ffffffffc0203286:	1eea0a13          	addi	s4,s4,494 # ffffffffc0209470 <default_pmm_manager+0x248>
ffffffffc020328a:	4995                	li	s3,5
ffffffffc020328c:	4585                	li	a1,1
ffffffffc020328e:	854a                	mv	a0,s2
ffffffffc0203290:	282000ef          	jal	ra,ffffffffc0203512 <sem_init>
ffffffffc0203294:	4601                	li	a2,0
ffffffffc0203296:	85a2                	mv	a1,s0
ffffffffc0203298:	8556                	mv	a0,s5
ffffffffc020329a:	23d000ef          	jal	ra,ffffffffc0203cd6 <kernel_thread>
ffffffffc020329e:	02a05663          	blez	a0,ffffffffc02032ca <check_sync+0x80>
ffffffffc02032a2:	60a000ef          	jal	ra,ffffffffc02038ac <find_proc>
ffffffffc02032a6:	85d2                	mv	a1,s4
ffffffffc02032a8:	0405                	addi	s0,s0,1
ffffffffc02032aa:	e088                	sd	a0,0(s1)
ffffffffc02032ac:	0961                	addi	s2,s2,24
ffffffffc02032ae:	568000ef          	jal	ra,ffffffffc0203816 <set_proc_name>
ffffffffc02032b2:	04a1                	addi	s1,s1,8
ffffffffc02032b4:	fd341ce3          	bne	s0,s3,ffffffffc020328c <check_sync+0x42>
ffffffffc02032b8:	70e2                	ld	ra,56(sp)
ffffffffc02032ba:	7442                	ld	s0,48(sp)
ffffffffc02032bc:	74a2                	ld	s1,40(sp)
ffffffffc02032be:	7902                	ld	s2,32(sp)
ffffffffc02032c0:	69e2                	ld	s3,24(sp)
ffffffffc02032c2:	6a42                	ld	s4,16(sp)
ffffffffc02032c4:	6aa2                	ld	s5,8(sp)
ffffffffc02032c6:	6121                	addi	sp,sp,64
ffffffffc02032c8:	8082                	ret
ffffffffc02032ca:	00006617          	auipc	a2,0x6
ffffffffc02032ce:	15660613          	addi	a2,a2,342 # ffffffffc0209420 <default_pmm_manager+0x1f8>
ffffffffc02032d2:	07f00593          	li	a1,127
ffffffffc02032d6:	00006517          	auipc	a0,0x6
ffffffffc02032da:	18250513          	addi	a0,a0,386 # ffffffffc0209458 <default_pmm_manager+0x230>
ffffffffc02032de:	f2bfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02032e2 <wait_queue_del.part.0>:
ffffffffc02032e2:	1141                	addi	sp,sp,-16
ffffffffc02032e4:	00006697          	auipc	a3,0x6
ffffffffc02032e8:	1a468693          	addi	a3,a3,420 # ffffffffc0209488 <default_pmm_manager+0x260>
ffffffffc02032ec:	00005617          	auipc	a2,0x5
ffffffffc02032f0:	31c60613          	addi	a2,a2,796 # ffffffffc0208608 <commands+0x410>
ffffffffc02032f4:	45f1                	li	a1,28
ffffffffc02032f6:	00006517          	auipc	a0,0x6
ffffffffc02032fa:	1d250513          	addi	a0,a0,466 # ffffffffc02094c8 <default_pmm_manager+0x2a0>
ffffffffc02032fe:	e406                	sd	ra,8(sp)
ffffffffc0203300:	f09fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203304 <wait_queue_init>:
ffffffffc0203304:	e508                	sd	a0,8(a0)
ffffffffc0203306:	e108                	sd	a0,0(a0)
ffffffffc0203308:	8082                	ret

ffffffffc020330a <wait_queue_del>:
ffffffffc020330a:	7198                	ld	a4,32(a1)
ffffffffc020330c:	01858793          	addi	a5,a1,24
ffffffffc0203310:	00e78b63          	beq	a5,a4,ffffffffc0203326 <wait_queue_del+0x1c>
ffffffffc0203314:	6994                	ld	a3,16(a1)
ffffffffc0203316:	00a69863          	bne	a3,a0,ffffffffc0203326 <wait_queue_del+0x1c>
ffffffffc020331a:	6d94                	ld	a3,24(a1)
ffffffffc020331c:	e698                	sd	a4,8(a3)
ffffffffc020331e:	e314                	sd	a3,0(a4)
ffffffffc0203320:	f19c                	sd	a5,32(a1)
ffffffffc0203322:	ed9c                	sd	a5,24(a1)
ffffffffc0203324:	8082                	ret
ffffffffc0203326:	1141                	addi	sp,sp,-16
ffffffffc0203328:	e406                	sd	ra,8(sp)
ffffffffc020332a:	fb9ff0ef          	jal	ra,ffffffffc02032e2 <wait_queue_del.part.0>

ffffffffc020332e <wait_queue_first>:
ffffffffc020332e:	651c                	ld	a5,8(a0)
ffffffffc0203330:	00f50563          	beq	a0,a5,ffffffffc020333a <wait_queue_first+0xc>
ffffffffc0203334:	fe878513          	addi	a0,a5,-24
ffffffffc0203338:	8082                	ret
ffffffffc020333a:	4501                	li	a0,0
ffffffffc020333c:	8082                	ret

ffffffffc020333e <wait_in_queue>:
ffffffffc020333e:	711c                	ld	a5,32(a0)
ffffffffc0203340:	0561                	addi	a0,a0,24
ffffffffc0203342:	40a78533          	sub	a0,a5,a0
ffffffffc0203346:	00a03533          	snez	a0,a0
ffffffffc020334a:	8082                	ret

ffffffffc020334c <wakeup_wait>:
ffffffffc020334c:	ce91                	beqz	a3,ffffffffc0203368 <wakeup_wait+0x1c>
ffffffffc020334e:	7198                	ld	a4,32(a1)
ffffffffc0203350:	01858793          	addi	a5,a1,24
ffffffffc0203354:	00e78e63          	beq	a5,a4,ffffffffc0203370 <wakeup_wait+0x24>
ffffffffc0203358:	6994                	ld	a3,16(a1)
ffffffffc020335a:	00d51b63          	bne	a0,a3,ffffffffc0203370 <wakeup_wait+0x24>
ffffffffc020335e:	6d94                	ld	a3,24(a1)
ffffffffc0203360:	e698                	sd	a4,8(a3)
ffffffffc0203362:	e314                	sd	a3,0(a4)
ffffffffc0203364:	f19c                	sd	a5,32(a1)
ffffffffc0203366:	ed9c                	sd	a5,24(a1)
ffffffffc0203368:	6188                	ld	a0,0(a1)
ffffffffc020336a:	c590                	sw	a2,8(a1)
ffffffffc020336c:	6820106f          	j	ffffffffc02049ee <wakeup_proc>
ffffffffc0203370:	1141                	addi	sp,sp,-16
ffffffffc0203372:	e406                	sd	ra,8(sp)
ffffffffc0203374:	f6fff0ef          	jal	ra,ffffffffc02032e2 <wait_queue_del.part.0>

ffffffffc0203378 <wait_current_set>:
ffffffffc0203378:	00016797          	auipc	a5,0x16
ffffffffc020337c:	1807b783          	ld	a5,384(a5) # ffffffffc02194f8 <current>
ffffffffc0203380:	c39d                	beqz	a5,ffffffffc02033a6 <wait_current_set+0x2e>
ffffffffc0203382:	01858713          	addi	a4,a1,24
ffffffffc0203386:	800006b7          	lui	a3,0x80000
ffffffffc020338a:	ed98                	sd	a4,24(a1)
ffffffffc020338c:	e19c                	sd	a5,0(a1)
ffffffffc020338e:	c594                	sw	a3,8(a1)
ffffffffc0203390:	4685                	li	a3,1
ffffffffc0203392:	c394                	sw	a3,0(a5)
ffffffffc0203394:	0ec7a623          	sw	a2,236(a5)
ffffffffc0203398:	611c                	ld	a5,0(a0)
ffffffffc020339a:	e988                	sd	a0,16(a1)
ffffffffc020339c:	e118                	sd	a4,0(a0)
ffffffffc020339e:	e798                	sd	a4,8(a5)
ffffffffc02033a0:	f188                	sd	a0,32(a1)
ffffffffc02033a2:	ed9c                	sd	a5,24(a1)
ffffffffc02033a4:	8082                	ret
ffffffffc02033a6:	1141                	addi	sp,sp,-16
ffffffffc02033a8:	00006697          	auipc	a3,0x6
ffffffffc02033ac:	13868693          	addi	a3,a3,312 # ffffffffc02094e0 <default_pmm_manager+0x2b8>
ffffffffc02033b0:	00005617          	auipc	a2,0x5
ffffffffc02033b4:	25860613          	addi	a2,a2,600 # ffffffffc0208608 <commands+0x410>
ffffffffc02033b8:	07400593          	li	a1,116
ffffffffc02033bc:	00006517          	auipc	a0,0x6
ffffffffc02033c0:	10c50513          	addi	a0,a0,268 # ffffffffc02094c8 <default_pmm_manager+0x2a0>
ffffffffc02033c4:	e406                	sd	ra,8(sp)
ffffffffc02033c6:	e43fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02033ca <__down.constprop.0>:
ffffffffc02033ca:	715d                	addi	sp,sp,-80
ffffffffc02033cc:	e0a2                	sd	s0,64(sp)
ffffffffc02033ce:	e486                	sd	ra,72(sp)
ffffffffc02033d0:	fc26                	sd	s1,56(sp)
ffffffffc02033d2:	842a                	mv	s0,a0
ffffffffc02033d4:	100027f3          	csrr	a5,sstatus
ffffffffc02033d8:	8b89                	andi	a5,a5,2
ffffffffc02033da:	ebb1                	bnez	a5,ffffffffc020342e <__down.constprop.0+0x64>
ffffffffc02033dc:	411c                	lw	a5,0(a0)
ffffffffc02033de:	00f05a63          	blez	a5,ffffffffc02033f2 <__down.constprop.0+0x28>
ffffffffc02033e2:	37fd                	addiw	a5,a5,-1
ffffffffc02033e4:	c11c                	sw	a5,0(a0)
ffffffffc02033e6:	4501                	li	a0,0
ffffffffc02033e8:	60a6                	ld	ra,72(sp)
ffffffffc02033ea:	6406                	ld	s0,64(sp)
ffffffffc02033ec:	74e2                	ld	s1,56(sp)
ffffffffc02033ee:	6161                	addi	sp,sp,80
ffffffffc02033f0:	8082                	ret
ffffffffc02033f2:	00850413          	addi	s0,a0,8
ffffffffc02033f6:	0024                	addi	s1,sp,8
ffffffffc02033f8:	10000613          	li	a2,256
ffffffffc02033fc:	85a6                	mv	a1,s1
ffffffffc02033fe:	8522                	mv	a0,s0
ffffffffc0203400:	f79ff0ef          	jal	ra,ffffffffc0203378 <wait_current_set>
ffffffffc0203404:	69c010ef          	jal	ra,ffffffffc0204aa0 <schedule>
ffffffffc0203408:	100027f3          	csrr	a5,sstatus
ffffffffc020340c:	8b89                	andi	a5,a5,2
ffffffffc020340e:	efb9                	bnez	a5,ffffffffc020346c <__down.constprop.0+0xa2>
ffffffffc0203410:	8526                	mv	a0,s1
ffffffffc0203412:	f2dff0ef          	jal	ra,ffffffffc020333e <wait_in_queue>
ffffffffc0203416:	e531                	bnez	a0,ffffffffc0203462 <__down.constprop.0+0x98>
ffffffffc0203418:	4542                	lw	a0,16(sp)
ffffffffc020341a:	10000793          	li	a5,256
ffffffffc020341e:	fcf515e3          	bne	a0,a5,ffffffffc02033e8 <__down.constprop.0+0x1e>
ffffffffc0203422:	60a6                	ld	ra,72(sp)
ffffffffc0203424:	6406                	ld	s0,64(sp)
ffffffffc0203426:	74e2                	ld	s1,56(sp)
ffffffffc0203428:	4501                	li	a0,0
ffffffffc020342a:	6161                	addi	sp,sp,80
ffffffffc020342c:	8082                	ret
ffffffffc020342e:	a0afd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203432:	401c                	lw	a5,0(s0)
ffffffffc0203434:	00f05c63          	blez	a5,ffffffffc020344c <__down.constprop.0+0x82>
ffffffffc0203438:	37fd                	addiw	a5,a5,-1
ffffffffc020343a:	c01c                	sw	a5,0(s0)
ffffffffc020343c:	9f6fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203440:	60a6                	ld	ra,72(sp)
ffffffffc0203442:	6406                	ld	s0,64(sp)
ffffffffc0203444:	74e2                	ld	s1,56(sp)
ffffffffc0203446:	4501                	li	a0,0
ffffffffc0203448:	6161                	addi	sp,sp,80
ffffffffc020344a:	8082                	ret
ffffffffc020344c:	0421                	addi	s0,s0,8
ffffffffc020344e:	0024                	addi	s1,sp,8
ffffffffc0203450:	10000613          	li	a2,256
ffffffffc0203454:	85a6                	mv	a1,s1
ffffffffc0203456:	8522                	mv	a0,s0
ffffffffc0203458:	f21ff0ef          	jal	ra,ffffffffc0203378 <wait_current_set>
ffffffffc020345c:	9d6fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203460:	b755                	j	ffffffffc0203404 <__down.constprop.0+0x3a>
ffffffffc0203462:	85a6                	mv	a1,s1
ffffffffc0203464:	8522                	mv	a0,s0
ffffffffc0203466:	ea5ff0ef          	jal	ra,ffffffffc020330a <wait_queue_del>
ffffffffc020346a:	b77d                	j	ffffffffc0203418 <__down.constprop.0+0x4e>
ffffffffc020346c:	9ccfd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203470:	8526                	mv	a0,s1
ffffffffc0203472:	ecdff0ef          	jal	ra,ffffffffc020333e <wait_in_queue>
ffffffffc0203476:	e501                	bnez	a0,ffffffffc020347e <__down.constprop.0+0xb4>
ffffffffc0203478:	9bafd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020347c:	bf71                	j	ffffffffc0203418 <__down.constprop.0+0x4e>
ffffffffc020347e:	85a6                	mv	a1,s1
ffffffffc0203480:	8522                	mv	a0,s0
ffffffffc0203482:	e89ff0ef          	jal	ra,ffffffffc020330a <wait_queue_del>
ffffffffc0203486:	bfcd                	j	ffffffffc0203478 <__down.constprop.0+0xae>

ffffffffc0203488 <__up.constprop.0>:
ffffffffc0203488:	1101                	addi	sp,sp,-32
ffffffffc020348a:	e822                	sd	s0,16(sp)
ffffffffc020348c:	ec06                	sd	ra,24(sp)
ffffffffc020348e:	e426                	sd	s1,8(sp)
ffffffffc0203490:	e04a                	sd	s2,0(sp)
ffffffffc0203492:	842a                	mv	s0,a0
ffffffffc0203494:	100027f3          	csrr	a5,sstatus
ffffffffc0203498:	8b89                	andi	a5,a5,2
ffffffffc020349a:	4901                	li	s2,0
ffffffffc020349c:	eba1                	bnez	a5,ffffffffc02034ec <__up.constprop.0+0x64>
ffffffffc020349e:	00840493          	addi	s1,s0,8
ffffffffc02034a2:	8526                	mv	a0,s1
ffffffffc02034a4:	e8bff0ef          	jal	ra,ffffffffc020332e <wait_queue_first>
ffffffffc02034a8:	85aa                	mv	a1,a0
ffffffffc02034aa:	cd0d                	beqz	a0,ffffffffc02034e4 <__up.constprop.0+0x5c>
ffffffffc02034ac:	6118                	ld	a4,0(a0)
ffffffffc02034ae:	10000793          	li	a5,256
ffffffffc02034b2:	0ec72703          	lw	a4,236(a4)
ffffffffc02034b6:	02f71f63          	bne	a4,a5,ffffffffc02034f4 <__up.constprop.0+0x6c>
ffffffffc02034ba:	4685                	li	a3,1
ffffffffc02034bc:	10000613          	li	a2,256
ffffffffc02034c0:	8526                	mv	a0,s1
ffffffffc02034c2:	e8bff0ef          	jal	ra,ffffffffc020334c <wakeup_wait>
ffffffffc02034c6:	00091863          	bnez	s2,ffffffffc02034d6 <__up.constprop.0+0x4e>
ffffffffc02034ca:	60e2                	ld	ra,24(sp)
ffffffffc02034cc:	6442                	ld	s0,16(sp)
ffffffffc02034ce:	64a2                	ld	s1,8(sp)
ffffffffc02034d0:	6902                	ld	s2,0(sp)
ffffffffc02034d2:	6105                	addi	sp,sp,32
ffffffffc02034d4:	8082                	ret
ffffffffc02034d6:	6442                	ld	s0,16(sp)
ffffffffc02034d8:	60e2                	ld	ra,24(sp)
ffffffffc02034da:	64a2                	ld	s1,8(sp)
ffffffffc02034dc:	6902                	ld	s2,0(sp)
ffffffffc02034de:	6105                	addi	sp,sp,32
ffffffffc02034e0:	952fd06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc02034e4:	401c                	lw	a5,0(s0)
ffffffffc02034e6:	2785                	addiw	a5,a5,1
ffffffffc02034e8:	c01c                	sw	a5,0(s0)
ffffffffc02034ea:	bff1                	j	ffffffffc02034c6 <__up.constprop.0+0x3e>
ffffffffc02034ec:	94cfd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02034f0:	4905                	li	s2,1
ffffffffc02034f2:	b775                	j	ffffffffc020349e <__up.constprop.0+0x16>
ffffffffc02034f4:	00006697          	auipc	a3,0x6
ffffffffc02034f8:	ffc68693          	addi	a3,a3,-4 # ffffffffc02094f0 <default_pmm_manager+0x2c8>
ffffffffc02034fc:	00005617          	auipc	a2,0x5
ffffffffc0203500:	10c60613          	addi	a2,a2,268 # ffffffffc0208608 <commands+0x410>
ffffffffc0203504:	45e5                	li	a1,25
ffffffffc0203506:	00006517          	auipc	a0,0x6
ffffffffc020350a:	01250513          	addi	a0,a0,18 # ffffffffc0209518 <default_pmm_manager+0x2f0>
ffffffffc020350e:	cfbfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203512 <sem_init>:
ffffffffc0203512:	c10c                	sw	a1,0(a0)
ffffffffc0203514:	0521                	addi	a0,a0,8
ffffffffc0203516:	defff06f          	j	ffffffffc0203304 <wait_queue_init>

ffffffffc020351a <up>:
ffffffffc020351a:	b7bd                	j	ffffffffc0203488 <__up.constprop.0>

ffffffffc020351c <down>:
ffffffffc020351c:	1141                	addi	sp,sp,-16
ffffffffc020351e:	e406                	sd	ra,8(sp)
ffffffffc0203520:	eabff0ef          	jal	ra,ffffffffc02033ca <__down.constprop.0>
ffffffffc0203524:	2501                	sext.w	a0,a0
ffffffffc0203526:	e501                	bnez	a0,ffffffffc020352e <down+0x12>
ffffffffc0203528:	60a2                	ld	ra,8(sp)
ffffffffc020352a:	0141                	addi	sp,sp,16
ffffffffc020352c:	8082                	ret
ffffffffc020352e:	00006697          	auipc	a3,0x6
ffffffffc0203532:	ffa68693          	addi	a3,a3,-6 # ffffffffc0209528 <default_pmm_manager+0x300>
ffffffffc0203536:	00005617          	auipc	a2,0x5
ffffffffc020353a:	0d260613          	addi	a2,a2,210 # ffffffffc0208608 <commands+0x410>
ffffffffc020353e:	04000593          	li	a1,64
ffffffffc0203542:	00006517          	auipc	a0,0x6
ffffffffc0203546:	fd650513          	addi	a0,a0,-42 # ffffffffc0209518 <default_pmm_manager+0x2f0>
ffffffffc020354a:	cbffc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020354e <swapfs_init>:
ffffffffc020354e:	1141                	addi	sp,sp,-16
ffffffffc0203550:	4505                	li	a0,1
ffffffffc0203552:	e406                	sd	ra,8(sp)
ffffffffc0203554:	fcffc0ef          	jal	ra,ffffffffc0200522 <ide_device_valid>
ffffffffc0203558:	cd01                	beqz	a0,ffffffffc0203570 <swapfs_init+0x22>
ffffffffc020355a:	4505                	li	a0,1
ffffffffc020355c:	fcdfc0ef          	jal	ra,ffffffffc0200528 <ide_device_size>
ffffffffc0203560:	60a2                	ld	ra,8(sp)
ffffffffc0203562:	810d                	srli	a0,a0,0x3
ffffffffc0203564:	00016797          	auipc	a5,0x16
ffffffffc0203568:	06a7b623          	sd	a0,108(a5) # ffffffffc02195d0 <max_swap_offset>
ffffffffc020356c:	0141                	addi	sp,sp,16
ffffffffc020356e:	8082                	ret
ffffffffc0203570:	00006617          	auipc	a2,0x6
ffffffffc0203574:	fc860613          	addi	a2,a2,-56 # ffffffffc0209538 <default_pmm_manager+0x310>
ffffffffc0203578:	45b5                	li	a1,13
ffffffffc020357a:	00006517          	auipc	a0,0x6
ffffffffc020357e:	fde50513          	addi	a0,a0,-34 # ffffffffc0209558 <default_pmm_manager+0x330>
ffffffffc0203582:	c87fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203586 <swapfs_read>:
ffffffffc0203586:	1141                	addi	sp,sp,-16
ffffffffc0203588:	e406                	sd	ra,8(sp)
ffffffffc020358a:	00855793          	srli	a5,a0,0x8
ffffffffc020358e:	cbb1                	beqz	a5,ffffffffc02035e2 <swapfs_read+0x5c>
ffffffffc0203590:	00016717          	auipc	a4,0x16
ffffffffc0203594:	04073703          	ld	a4,64(a4) # ffffffffc02195d0 <max_swap_offset>
ffffffffc0203598:	04e7f563          	bgeu	a5,a4,ffffffffc02035e2 <swapfs_read+0x5c>
ffffffffc020359c:	00016617          	auipc	a2,0x16
ffffffffc02035a0:	0a463603          	ld	a2,164(a2) # ffffffffc0219640 <pages>
ffffffffc02035a4:	8d91                	sub	a1,a1,a2
ffffffffc02035a6:	4065d613          	srai	a2,a1,0x6
ffffffffc02035aa:	00007717          	auipc	a4,0x7
ffffffffc02035ae:	0a673703          	ld	a4,166(a4) # ffffffffc020a650 <nbase>
ffffffffc02035b2:	963a                	add	a2,a2,a4
ffffffffc02035b4:	00c61713          	slli	a4,a2,0xc
ffffffffc02035b8:	8331                	srli	a4,a4,0xc
ffffffffc02035ba:	00016697          	auipc	a3,0x16
ffffffffc02035be:	f366b683          	ld	a3,-202(a3) # ffffffffc02194f0 <npage>
ffffffffc02035c2:	0037959b          	slliw	a1,a5,0x3
ffffffffc02035c6:	0632                	slli	a2,a2,0xc
ffffffffc02035c8:	02d77963          	bgeu	a4,a3,ffffffffc02035fa <swapfs_read+0x74>
ffffffffc02035cc:	60a2                	ld	ra,8(sp)
ffffffffc02035ce:	00016797          	auipc	a5,0x16
ffffffffc02035d2:	0627b783          	ld	a5,98(a5) # ffffffffc0219630 <va_pa_offset>
ffffffffc02035d6:	46a1                	li	a3,8
ffffffffc02035d8:	963e                	add	a2,a2,a5
ffffffffc02035da:	4505                	li	a0,1
ffffffffc02035dc:	0141                	addi	sp,sp,16
ffffffffc02035de:	f51fc06f          	j	ffffffffc020052e <ide_read_secs>
ffffffffc02035e2:	86aa                	mv	a3,a0
ffffffffc02035e4:	00006617          	auipc	a2,0x6
ffffffffc02035e8:	f8c60613          	addi	a2,a2,-116 # ffffffffc0209570 <default_pmm_manager+0x348>
ffffffffc02035ec:	45d1                	li	a1,20
ffffffffc02035ee:	00006517          	auipc	a0,0x6
ffffffffc02035f2:	f6a50513          	addi	a0,a0,-150 # ffffffffc0209558 <default_pmm_manager+0x330>
ffffffffc02035f6:	c13fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02035fa:	86b2                	mv	a3,a2
ffffffffc02035fc:	06900593          	li	a1,105
ffffffffc0203600:	00005617          	auipc	a2,0x5
ffffffffc0203604:	69060613          	addi	a2,a2,1680 # ffffffffc0208c90 <commands+0xa98>
ffffffffc0203608:	00005517          	auipc	a0,0x5
ffffffffc020360c:	6b050513          	addi	a0,a0,1712 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc0203610:	bf9fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203614 <swapfs_write>:
ffffffffc0203614:	1141                	addi	sp,sp,-16
ffffffffc0203616:	e406                	sd	ra,8(sp)
ffffffffc0203618:	00855793          	srli	a5,a0,0x8
ffffffffc020361c:	cbb1                	beqz	a5,ffffffffc0203670 <swapfs_write+0x5c>
ffffffffc020361e:	00016717          	auipc	a4,0x16
ffffffffc0203622:	fb273703          	ld	a4,-78(a4) # ffffffffc02195d0 <max_swap_offset>
ffffffffc0203626:	04e7f563          	bgeu	a5,a4,ffffffffc0203670 <swapfs_write+0x5c>
ffffffffc020362a:	00016617          	auipc	a2,0x16
ffffffffc020362e:	01663603          	ld	a2,22(a2) # ffffffffc0219640 <pages>
ffffffffc0203632:	8d91                	sub	a1,a1,a2
ffffffffc0203634:	4065d613          	srai	a2,a1,0x6
ffffffffc0203638:	00007717          	auipc	a4,0x7
ffffffffc020363c:	01873703          	ld	a4,24(a4) # ffffffffc020a650 <nbase>
ffffffffc0203640:	963a                	add	a2,a2,a4
ffffffffc0203642:	00c61713          	slli	a4,a2,0xc
ffffffffc0203646:	8331                	srli	a4,a4,0xc
ffffffffc0203648:	00016697          	auipc	a3,0x16
ffffffffc020364c:	ea86b683          	ld	a3,-344(a3) # ffffffffc02194f0 <npage>
ffffffffc0203650:	0037959b          	slliw	a1,a5,0x3
ffffffffc0203654:	0632                	slli	a2,a2,0xc
ffffffffc0203656:	02d77963          	bgeu	a4,a3,ffffffffc0203688 <swapfs_write+0x74>
ffffffffc020365a:	60a2                	ld	ra,8(sp)
ffffffffc020365c:	00016797          	auipc	a5,0x16
ffffffffc0203660:	fd47b783          	ld	a5,-44(a5) # ffffffffc0219630 <va_pa_offset>
ffffffffc0203664:	46a1                	li	a3,8
ffffffffc0203666:	963e                	add	a2,a2,a5
ffffffffc0203668:	4505                	li	a0,1
ffffffffc020366a:	0141                	addi	sp,sp,16
ffffffffc020366c:	ee7fc06f          	j	ffffffffc0200552 <ide_write_secs>
ffffffffc0203670:	86aa                	mv	a3,a0
ffffffffc0203672:	00006617          	auipc	a2,0x6
ffffffffc0203676:	efe60613          	addi	a2,a2,-258 # ffffffffc0209570 <default_pmm_manager+0x348>
ffffffffc020367a:	45e5                	li	a1,25
ffffffffc020367c:	00006517          	auipc	a0,0x6
ffffffffc0203680:	edc50513          	addi	a0,a0,-292 # ffffffffc0209558 <default_pmm_manager+0x330>
ffffffffc0203684:	b85fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203688:	86b2                	mv	a3,a2
ffffffffc020368a:	06900593          	li	a1,105
ffffffffc020368e:	00005617          	auipc	a2,0x5
ffffffffc0203692:	60260613          	addi	a2,a2,1538 # ffffffffc0208c90 <commands+0xa98>
ffffffffc0203696:	00005517          	auipc	a0,0x5
ffffffffc020369a:	62250513          	addi	a0,a0,1570 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc020369e:	b6bfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02036a2 <switch_to>:
ffffffffc02036a2:	00153023          	sd	ra,0(a0)
ffffffffc02036a6:	00253423          	sd	sp,8(a0)
ffffffffc02036aa:	e900                	sd	s0,16(a0)
ffffffffc02036ac:	ed04                	sd	s1,24(a0)
ffffffffc02036ae:	03253023          	sd	s2,32(a0)
ffffffffc02036b2:	03353423          	sd	s3,40(a0)
ffffffffc02036b6:	03453823          	sd	s4,48(a0)
ffffffffc02036ba:	03553c23          	sd	s5,56(a0)
ffffffffc02036be:	05653023          	sd	s6,64(a0)
ffffffffc02036c2:	05753423          	sd	s7,72(a0)
ffffffffc02036c6:	05853823          	sd	s8,80(a0)
ffffffffc02036ca:	05953c23          	sd	s9,88(a0)
ffffffffc02036ce:	07a53023          	sd	s10,96(a0)
ffffffffc02036d2:	07b53423          	sd	s11,104(a0)
ffffffffc02036d6:	0005b083          	ld	ra,0(a1)
ffffffffc02036da:	0085b103          	ld	sp,8(a1)
ffffffffc02036de:	6980                	ld	s0,16(a1)
ffffffffc02036e0:	6d84                	ld	s1,24(a1)
ffffffffc02036e2:	0205b903          	ld	s2,32(a1)
ffffffffc02036e6:	0285b983          	ld	s3,40(a1)
ffffffffc02036ea:	0305ba03          	ld	s4,48(a1)
ffffffffc02036ee:	0385ba83          	ld	s5,56(a1)
ffffffffc02036f2:	0405bb03          	ld	s6,64(a1)
ffffffffc02036f6:	0485bb83          	ld	s7,72(a1)
ffffffffc02036fa:	0505bc03          	ld	s8,80(a1)
ffffffffc02036fe:	0585bc83          	ld	s9,88(a1)
ffffffffc0203702:	0605bd03          	ld	s10,96(a1)
ffffffffc0203706:	0685bd83          	ld	s11,104(a1)
ffffffffc020370a:	8082                	ret

ffffffffc020370c <kernel_thread_entry>:
ffffffffc020370c:	8526                	mv	a0,s1
ffffffffc020370e:	9402                	jalr	s0
ffffffffc0203710:	616000ef          	jal	ra,ffffffffc0203d26 <do_exit>

ffffffffc0203714 <alloc_proc>:
ffffffffc0203714:	1141                	addi	sp,sp,-16
ffffffffc0203716:	14800513          	li	a0,328
ffffffffc020371a:	e022                	sd	s0,0(sp)
ffffffffc020371c:	e406                	sd	ra,8(sp)
ffffffffc020371e:	92afe0ef          	jal	ra,ffffffffc0201848 <kmalloc>
ffffffffc0203722:	842a                	mv	s0,a0
ffffffffc0203724:	cd21                	beqz	a0,ffffffffc020377c <alloc_proc+0x68>
ffffffffc0203726:	57fd                	li	a5,-1
ffffffffc0203728:	1782                	slli	a5,a5,0x20
ffffffffc020372a:	e11c                	sd	a5,0(a0)
ffffffffc020372c:	07000613          	li	a2,112
ffffffffc0203730:	4581                	li	a1,0
ffffffffc0203732:	00052423          	sw	zero,8(a0)
ffffffffc0203736:	00053823          	sd	zero,16(a0)
ffffffffc020373a:	00053c23          	sd	zero,24(a0)
ffffffffc020373e:	02053023          	sd	zero,32(a0)
ffffffffc0203742:	02053423          	sd	zero,40(a0)
ffffffffc0203746:	03050513          	addi	a0,a0,48
ffffffffc020374a:	3dc040ef          	jal	ra,ffffffffc0207b26 <memset>
ffffffffc020374e:	00016797          	auipc	a5,0x16
ffffffffc0203752:	eea7b783          	ld	a5,-278(a5) # ffffffffc0219638 <boot_cr3>
ffffffffc0203756:	0a043023          	sd	zero,160(s0)
ffffffffc020375a:	f45c                	sd	a5,168(s0)
ffffffffc020375c:	0a042823          	sw	zero,176(s0)
ffffffffc0203760:	463d                	li	a2,15
ffffffffc0203762:	4581                	li	a1,0
ffffffffc0203764:	0b440513          	addi	a0,s0,180
ffffffffc0203768:	3be040ef          	jal	ra,ffffffffc0207b26 <memset>
ffffffffc020376c:	0e042623          	sw	zero,236(s0)
ffffffffc0203770:	0e043c23          	sd	zero,248(s0)
ffffffffc0203774:	10043023          	sd	zero,256(s0)
ffffffffc0203778:	0e043823          	sd	zero,240(s0)
ffffffffc020377c:	60a2                	ld	ra,8(sp)
ffffffffc020377e:	8522                	mv	a0,s0
ffffffffc0203780:	6402                	ld	s0,0(sp)
ffffffffc0203782:	0141                	addi	sp,sp,16
ffffffffc0203784:	8082                	ret

ffffffffc0203786 <forkret>:
ffffffffc0203786:	00016797          	auipc	a5,0x16
ffffffffc020378a:	d727b783          	ld	a5,-654(a5) # ffffffffc02194f8 <current>
ffffffffc020378e:	73c8                	ld	a0,160(a5)
ffffffffc0203790:	d9afd06f          	j	ffffffffc0200d2a <forkrets>

ffffffffc0203794 <setup_pgdir.isra.0>:
ffffffffc0203794:	1101                	addi	sp,sp,-32
ffffffffc0203796:	e426                	sd	s1,8(sp)
ffffffffc0203798:	84aa                	mv	s1,a0
ffffffffc020379a:	4505                	li	a0,1
ffffffffc020379c:	ec06                	sd	ra,24(sp)
ffffffffc020379e:	e822                	sd	s0,16(sp)
ffffffffc02037a0:	f3ffe0ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc02037a4:	c939                	beqz	a0,ffffffffc02037fa <setup_pgdir.isra.0+0x66>
ffffffffc02037a6:	00016697          	auipc	a3,0x16
ffffffffc02037aa:	e9a6b683          	ld	a3,-358(a3) # ffffffffc0219640 <pages>
ffffffffc02037ae:	40d506b3          	sub	a3,a0,a3
ffffffffc02037b2:	8699                	srai	a3,a3,0x6
ffffffffc02037b4:	00007417          	auipc	s0,0x7
ffffffffc02037b8:	e9c43403          	ld	s0,-356(s0) # ffffffffc020a650 <nbase>
ffffffffc02037bc:	96a2                	add	a3,a3,s0
ffffffffc02037be:	00c69793          	slli	a5,a3,0xc
ffffffffc02037c2:	83b1                	srli	a5,a5,0xc
ffffffffc02037c4:	00016717          	auipc	a4,0x16
ffffffffc02037c8:	d2c73703          	ld	a4,-724(a4) # ffffffffc02194f0 <npage>
ffffffffc02037cc:	06b2                	slli	a3,a3,0xc
ffffffffc02037ce:	02e7f863          	bgeu	a5,a4,ffffffffc02037fe <setup_pgdir.isra.0+0x6a>
ffffffffc02037d2:	00016417          	auipc	s0,0x16
ffffffffc02037d6:	e5e43403          	ld	s0,-418(s0) # ffffffffc0219630 <va_pa_offset>
ffffffffc02037da:	9436                	add	s0,s0,a3
ffffffffc02037dc:	6605                	lui	a2,0x1
ffffffffc02037de:	00016597          	auipc	a1,0x16
ffffffffc02037e2:	d0a5b583          	ld	a1,-758(a1) # ffffffffc02194e8 <boot_pgdir>
ffffffffc02037e6:	8522                	mv	a0,s0
ffffffffc02037e8:	350040ef          	jal	ra,ffffffffc0207b38 <memcpy>
ffffffffc02037ec:	4501                	li	a0,0
ffffffffc02037ee:	e080                	sd	s0,0(s1)
ffffffffc02037f0:	60e2                	ld	ra,24(sp)
ffffffffc02037f2:	6442                	ld	s0,16(sp)
ffffffffc02037f4:	64a2                	ld	s1,8(sp)
ffffffffc02037f6:	6105                	addi	sp,sp,32
ffffffffc02037f8:	8082                	ret
ffffffffc02037fa:	5571                	li	a0,-4
ffffffffc02037fc:	bfd5                	j	ffffffffc02037f0 <setup_pgdir.isra.0+0x5c>
ffffffffc02037fe:	00005617          	auipc	a2,0x5
ffffffffc0203802:	49260613          	addi	a2,a2,1170 # ffffffffc0208c90 <commands+0xa98>
ffffffffc0203806:	06900593          	li	a1,105
ffffffffc020380a:	00005517          	auipc	a0,0x5
ffffffffc020380e:	4ae50513          	addi	a0,a0,1198 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc0203812:	9f7fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203816 <set_proc_name>:
ffffffffc0203816:	1101                	addi	sp,sp,-32
ffffffffc0203818:	e822                	sd	s0,16(sp)
ffffffffc020381a:	0b450413          	addi	s0,a0,180
ffffffffc020381e:	e426                	sd	s1,8(sp)
ffffffffc0203820:	4641                	li	a2,16
ffffffffc0203822:	84ae                	mv	s1,a1
ffffffffc0203824:	8522                	mv	a0,s0
ffffffffc0203826:	4581                	li	a1,0
ffffffffc0203828:	ec06                	sd	ra,24(sp)
ffffffffc020382a:	2fc040ef          	jal	ra,ffffffffc0207b26 <memset>
ffffffffc020382e:	8522                	mv	a0,s0
ffffffffc0203830:	6442                	ld	s0,16(sp)
ffffffffc0203832:	60e2                	ld	ra,24(sp)
ffffffffc0203834:	85a6                	mv	a1,s1
ffffffffc0203836:	64a2                	ld	s1,8(sp)
ffffffffc0203838:	463d                	li	a2,15
ffffffffc020383a:	6105                	addi	sp,sp,32
ffffffffc020383c:	2fc0406f          	j	ffffffffc0207b38 <memcpy>

ffffffffc0203840 <proc_run>:
ffffffffc0203840:	7179                	addi	sp,sp,-48
ffffffffc0203842:	ec4a                	sd	s2,24(sp)
ffffffffc0203844:	00016917          	auipc	s2,0x16
ffffffffc0203848:	cb490913          	addi	s2,s2,-844 # ffffffffc02194f8 <current>
ffffffffc020384c:	f026                	sd	s1,32(sp)
ffffffffc020384e:	00093483          	ld	s1,0(s2)
ffffffffc0203852:	f406                	sd	ra,40(sp)
ffffffffc0203854:	e84e                	sd	s3,16(sp)
ffffffffc0203856:	02a48863          	beq	s1,a0,ffffffffc0203886 <proc_run+0x46>
ffffffffc020385a:	100027f3          	csrr	a5,sstatus
ffffffffc020385e:	8b89                	andi	a5,a5,2
ffffffffc0203860:	4981                	li	s3,0
ffffffffc0203862:	ef9d                	bnez	a5,ffffffffc02038a0 <proc_run+0x60>
ffffffffc0203864:	755c                	ld	a5,168(a0)
ffffffffc0203866:	577d                	li	a4,-1
ffffffffc0203868:	177e                	slli	a4,a4,0x3f
ffffffffc020386a:	83b1                	srli	a5,a5,0xc
ffffffffc020386c:	00a93023          	sd	a0,0(s2)
ffffffffc0203870:	8fd9                	or	a5,a5,a4
ffffffffc0203872:	18079073          	csrw	satp,a5
ffffffffc0203876:	03050593          	addi	a1,a0,48
ffffffffc020387a:	03048513          	addi	a0,s1,48
ffffffffc020387e:	e25ff0ef          	jal	ra,ffffffffc02036a2 <switch_to>
ffffffffc0203882:	00099863          	bnez	s3,ffffffffc0203892 <proc_run+0x52>
ffffffffc0203886:	70a2                	ld	ra,40(sp)
ffffffffc0203888:	7482                	ld	s1,32(sp)
ffffffffc020388a:	6962                	ld	s2,24(sp)
ffffffffc020388c:	69c2                	ld	s3,16(sp)
ffffffffc020388e:	6145                	addi	sp,sp,48
ffffffffc0203890:	8082                	ret
ffffffffc0203892:	70a2                	ld	ra,40(sp)
ffffffffc0203894:	7482                	ld	s1,32(sp)
ffffffffc0203896:	6962                	ld	s2,24(sp)
ffffffffc0203898:	69c2                	ld	s3,16(sp)
ffffffffc020389a:	6145                	addi	sp,sp,48
ffffffffc020389c:	d97fc06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc02038a0:	e42a                	sd	a0,8(sp)
ffffffffc02038a2:	d97fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02038a6:	6522                	ld	a0,8(sp)
ffffffffc02038a8:	4985                	li	s3,1
ffffffffc02038aa:	bf6d                	j	ffffffffc0203864 <proc_run+0x24>

ffffffffc02038ac <find_proc>:
ffffffffc02038ac:	6789                	lui	a5,0x2
ffffffffc02038ae:	fff5071b          	addiw	a4,a0,-1
ffffffffc02038b2:	17f9                	addi	a5,a5,-2
ffffffffc02038b4:	04e7e063          	bltu	a5,a4,ffffffffc02038f4 <find_proc+0x48>
ffffffffc02038b8:	1141                	addi	sp,sp,-16
ffffffffc02038ba:	e022                	sd	s0,0(sp)
ffffffffc02038bc:	45a9                	li	a1,10
ffffffffc02038be:	842a                	mv	s0,a0
ffffffffc02038c0:	2501                	sext.w	a0,a0
ffffffffc02038c2:	e406                	sd	ra,8(sp)
ffffffffc02038c4:	67a040ef          	jal	ra,ffffffffc0207f3e <hash32>
ffffffffc02038c8:	02051693          	slli	a3,a0,0x20
ffffffffc02038cc:	00012797          	auipc	a5,0x12
ffffffffc02038d0:	bc478793          	addi	a5,a5,-1084 # ffffffffc0215490 <hash_list>
ffffffffc02038d4:	82f1                	srli	a3,a3,0x1c
ffffffffc02038d6:	96be                	add	a3,a3,a5
ffffffffc02038d8:	87b6                	mv	a5,a3
ffffffffc02038da:	a029                	j	ffffffffc02038e4 <find_proc+0x38>
ffffffffc02038dc:	f2c7a703          	lw	a4,-212(a5)
ffffffffc02038e0:	00870c63          	beq	a4,s0,ffffffffc02038f8 <find_proc+0x4c>
ffffffffc02038e4:	679c                	ld	a5,8(a5)
ffffffffc02038e6:	fef69be3          	bne	a3,a5,ffffffffc02038dc <find_proc+0x30>
ffffffffc02038ea:	60a2                	ld	ra,8(sp)
ffffffffc02038ec:	6402                	ld	s0,0(sp)
ffffffffc02038ee:	4501                	li	a0,0
ffffffffc02038f0:	0141                	addi	sp,sp,16
ffffffffc02038f2:	8082                	ret
ffffffffc02038f4:	4501                	li	a0,0
ffffffffc02038f6:	8082                	ret
ffffffffc02038f8:	60a2                	ld	ra,8(sp)
ffffffffc02038fa:	6402                	ld	s0,0(sp)
ffffffffc02038fc:	f2878513          	addi	a0,a5,-216
ffffffffc0203900:	0141                	addi	sp,sp,16
ffffffffc0203902:	8082                	ret

ffffffffc0203904 <do_fork>:
ffffffffc0203904:	7159                	addi	sp,sp,-112
ffffffffc0203906:	e4ce                	sd	s3,72(sp)
ffffffffc0203908:	00016997          	auipc	s3,0x16
ffffffffc020390c:	c0898993          	addi	s3,s3,-1016 # ffffffffc0219510 <nr_process>
ffffffffc0203910:	0009a703          	lw	a4,0(s3)
ffffffffc0203914:	f486                	sd	ra,104(sp)
ffffffffc0203916:	f0a2                	sd	s0,96(sp)
ffffffffc0203918:	eca6                	sd	s1,88(sp)
ffffffffc020391a:	e8ca                	sd	s2,80(sp)
ffffffffc020391c:	e0d2                	sd	s4,64(sp)
ffffffffc020391e:	fc56                	sd	s5,56(sp)
ffffffffc0203920:	f85a                	sd	s6,48(sp)
ffffffffc0203922:	f45e                	sd	s7,40(sp)
ffffffffc0203924:	f062                	sd	s8,32(sp)
ffffffffc0203926:	ec66                	sd	s9,24(sp)
ffffffffc0203928:	e86a                	sd	s10,16(sp)
ffffffffc020392a:	e46e                	sd	s11,8(sp)
ffffffffc020392c:	6785                	lui	a5,0x1
ffffffffc020392e:	30f75f63          	bge	a4,a5,ffffffffc0203c4c <do_fork+0x348>
ffffffffc0203932:	8a2a                	mv	s4,a0
ffffffffc0203934:	892e                	mv	s2,a1
ffffffffc0203936:	84b2                	mv	s1,a2
ffffffffc0203938:	dddff0ef          	jal	ra,ffffffffc0203714 <alloc_proc>
ffffffffc020393c:	842a                	mv	s0,a0
ffffffffc020393e:	28050263          	beqz	a0,ffffffffc0203bc2 <do_fork+0x2be>
ffffffffc0203942:	00016b97          	auipc	s7,0x16
ffffffffc0203946:	bb6b8b93          	addi	s7,s7,-1098 # ffffffffc02194f8 <current>
ffffffffc020394a:	000bb783          	ld	a5,0(s7)
ffffffffc020394e:	0ec7a703          	lw	a4,236(a5) # 10ec <kern_entry-0xffffffffc01fef14>
ffffffffc0203952:	f11c                	sd	a5,32(a0)
ffffffffc0203954:	30071c63          	bnez	a4,ffffffffc0203c6c <do_fork+0x368>
ffffffffc0203958:	4509                	li	a0,2
ffffffffc020395a:	d85fe0ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc020395e:	24050f63          	beqz	a0,ffffffffc0203bbc <do_fork+0x2b8>
ffffffffc0203962:	00016c17          	auipc	s8,0x16
ffffffffc0203966:	cdec0c13          	addi	s8,s8,-802 # ffffffffc0219640 <pages>
ffffffffc020396a:	000c3683          	ld	a3,0(s8)
ffffffffc020396e:	00007a97          	auipc	s5,0x7
ffffffffc0203972:	ce2aba83          	ld	s5,-798(s5) # ffffffffc020a650 <nbase>
ffffffffc0203976:	00016c97          	auipc	s9,0x16
ffffffffc020397a:	b7ac8c93          	addi	s9,s9,-1158 # ffffffffc02194f0 <npage>
ffffffffc020397e:	40d506b3          	sub	a3,a0,a3
ffffffffc0203982:	8699                	srai	a3,a3,0x6
ffffffffc0203984:	96d6                	add	a3,a3,s5
ffffffffc0203986:	000cb703          	ld	a4,0(s9)
ffffffffc020398a:	00c69793          	slli	a5,a3,0xc
ffffffffc020398e:	83b1                	srli	a5,a5,0xc
ffffffffc0203990:	06b2                	slli	a3,a3,0xc
ffffffffc0203992:	2ce7f163          	bgeu	a5,a4,ffffffffc0203c54 <do_fork+0x350>
ffffffffc0203996:	000bb703          	ld	a4,0(s7)
ffffffffc020399a:	00016d17          	auipc	s10,0x16
ffffffffc020399e:	c96d0d13          	addi	s10,s10,-874 # ffffffffc0219630 <va_pa_offset>
ffffffffc02039a2:	000d3783          	ld	a5,0(s10)
ffffffffc02039a6:	02873b03          	ld	s6,40(a4)
ffffffffc02039aa:	96be                	add	a3,a3,a5
ffffffffc02039ac:	e814                	sd	a3,16(s0)
ffffffffc02039ae:	020b0863          	beqz	s6,ffffffffc02039de <do_fork+0xda>
ffffffffc02039b2:	100a7a13          	andi	s4,s4,256
ffffffffc02039b6:	1c0a0163          	beqz	s4,ffffffffc0203b78 <do_fork+0x274>
ffffffffc02039ba:	030b2703          	lw	a4,48(s6)
ffffffffc02039be:	018b3783          	ld	a5,24(s6)
ffffffffc02039c2:	c02006b7          	lui	a3,0xc0200
ffffffffc02039c6:	2705                	addiw	a4,a4,1
ffffffffc02039c8:	02eb2823          	sw	a4,48(s6)
ffffffffc02039cc:	03643423          	sd	s6,40(s0)
ffffffffc02039d0:	2ad7ee63          	bltu	a5,a3,ffffffffc0203c8c <do_fork+0x388>
ffffffffc02039d4:	000d3703          	ld	a4,0(s10)
ffffffffc02039d8:	6814                	ld	a3,16(s0)
ffffffffc02039da:	8f99                	sub	a5,a5,a4
ffffffffc02039dc:	f45c                	sd	a5,168(s0)
ffffffffc02039de:	6789                	lui	a5,0x2
ffffffffc02039e0:	ee078793          	addi	a5,a5,-288 # 1ee0 <kern_entry-0xffffffffc01fe120>
ffffffffc02039e4:	97b6                	add	a5,a5,a3
ffffffffc02039e6:	8626                	mv	a2,s1
ffffffffc02039e8:	f05c                	sd	a5,160(s0)
ffffffffc02039ea:	873e                	mv	a4,a5
ffffffffc02039ec:	12048313          	addi	t1,s1,288
ffffffffc02039f0:	00063883          	ld	a7,0(a2)
ffffffffc02039f4:	00863803          	ld	a6,8(a2)
ffffffffc02039f8:	6a08                	ld	a0,16(a2)
ffffffffc02039fa:	6e0c                	ld	a1,24(a2)
ffffffffc02039fc:	01173023          	sd	a7,0(a4)
ffffffffc0203a00:	01073423          	sd	a6,8(a4)
ffffffffc0203a04:	eb08                	sd	a0,16(a4)
ffffffffc0203a06:	ef0c                	sd	a1,24(a4)
ffffffffc0203a08:	02060613          	addi	a2,a2,32
ffffffffc0203a0c:	02070713          	addi	a4,a4,32
ffffffffc0203a10:	fe6610e3          	bne	a2,t1,ffffffffc02039f0 <do_fork+0xec>
ffffffffc0203a14:	0407b823          	sd	zero,80(a5)
ffffffffc0203a18:	12090a63          	beqz	s2,ffffffffc0203b4c <do_fork+0x248>
ffffffffc0203a1c:	0127b823          	sd	s2,16(a5)
ffffffffc0203a20:	00000717          	auipc	a4,0x0
ffffffffc0203a24:	d6670713          	addi	a4,a4,-666 # ffffffffc0203786 <forkret>
ffffffffc0203a28:	f818                	sd	a4,48(s0)
ffffffffc0203a2a:	fc1c                	sd	a5,56(s0)
ffffffffc0203a2c:	100027f3          	csrr	a5,sstatus
ffffffffc0203a30:	8b89                	andi	a5,a5,2
ffffffffc0203a32:	4901                	li	s2,0
ffffffffc0203a34:	12079e63          	bnez	a5,ffffffffc0203b70 <do_fork+0x26c>
ffffffffc0203a38:	0000a597          	auipc	a1,0xa
ffffffffc0203a3c:	65058593          	addi	a1,a1,1616 # ffffffffc020e088 <last_pid.1812>
ffffffffc0203a40:	419c                	lw	a5,0(a1)
ffffffffc0203a42:	6709                	lui	a4,0x2
ffffffffc0203a44:	0017851b          	addiw	a0,a5,1
ffffffffc0203a48:	c188                	sw	a0,0(a1)
ffffffffc0203a4a:	08e55b63          	bge	a0,a4,ffffffffc0203ae0 <do_fork+0x1dc>
ffffffffc0203a4e:	0000a897          	auipc	a7,0xa
ffffffffc0203a52:	63e88893          	addi	a7,a7,1598 # ffffffffc020e08c <next_safe.1811>
ffffffffc0203a56:	0008a783          	lw	a5,0(a7)
ffffffffc0203a5a:	00016497          	auipc	s1,0x16
ffffffffc0203a5e:	cde48493          	addi	s1,s1,-802 # ffffffffc0219738 <proc_list>
ffffffffc0203a62:	08f55663          	bge	a0,a5,ffffffffc0203aee <do_fork+0x1ea>
ffffffffc0203a66:	c048                	sw	a0,4(s0)
ffffffffc0203a68:	45a9                	li	a1,10
ffffffffc0203a6a:	2501                	sext.w	a0,a0
ffffffffc0203a6c:	4d2040ef          	jal	ra,ffffffffc0207f3e <hash32>
ffffffffc0203a70:	1502                	slli	a0,a0,0x20
ffffffffc0203a72:	00012797          	auipc	a5,0x12
ffffffffc0203a76:	a1e78793          	addi	a5,a5,-1506 # ffffffffc0215490 <hash_list>
ffffffffc0203a7a:	8171                	srli	a0,a0,0x1c
ffffffffc0203a7c:	953e                	add	a0,a0,a5
ffffffffc0203a7e:	650c                	ld	a1,8(a0)
ffffffffc0203a80:	7014                	ld	a3,32(s0)
ffffffffc0203a82:	0d840793          	addi	a5,s0,216
ffffffffc0203a86:	e19c                	sd	a5,0(a1)
ffffffffc0203a88:	6490                	ld	a2,8(s1)
ffffffffc0203a8a:	e51c                	sd	a5,8(a0)
ffffffffc0203a8c:	7af8                	ld	a4,240(a3)
ffffffffc0203a8e:	0c840793          	addi	a5,s0,200
ffffffffc0203a92:	f06c                	sd	a1,224(s0)
ffffffffc0203a94:	ec68                	sd	a0,216(s0)
ffffffffc0203a96:	e21c                	sd	a5,0(a2)
ffffffffc0203a98:	e49c                	sd	a5,8(s1)
ffffffffc0203a9a:	e870                	sd	a2,208(s0)
ffffffffc0203a9c:	e464                	sd	s1,200(s0)
ffffffffc0203a9e:	0e043c23          	sd	zero,248(s0)
ffffffffc0203aa2:	10e43023          	sd	a4,256(s0)
ffffffffc0203aa6:	c311                	beqz	a4,ffffffffc0203aaa <do_fork+0x1a6>
ffffffffc0203aa8:	ff60                	sd	s0,248(a4)
ffffffffc0203aaa:	0009a783          	lw	a5,0(s3)
ffffffffc0203aae:	fae0                	sd	s0,240(a3)
ffffffffc0203ab0:	2785                	addiw	a5,a5,1
ffffffffc0203ab2:	00f9a023          	sw	a5,0(s3)
ffffffffc0203ab6:	10091863          	bnez	s2,ffffffffc0203bc6 <do_fork+0x2c2>
ffffffffc0203aba:	8522                	mv	a0,s0
ffffffffc0203abc:	733000ef          	jal	ra,ffffffffc02049ee <wakeup_proc>
ffffffffc0203ac0:	4048                	lw	a0,4(s0)
ffffffffc0203ac2:	70a6                	ld	ra,104(sp)
ffffffffc0203ac4:	7406                	ld	s0,96(sp)
ffffffffc0203ac6:	64e6                	ld	s1,88(sp)
ffffffffc0203ac8:	6946                	ld	s2,80(sp)
ffffffffc0203aca:	69a6                	ld	s3,72(sp)
ffffffffc0203acc:	6a06                	ld	s4,64(sp)
ffffffffc0203ace:	7ae2                	ld	s5,56(sp)
ffffffffc0203ad0:	7b42                	ld	s6,48(sp)
ffffffffc0203ad2:	7ba2                	ld	s7,40(sp)
ffffffffc0203ad4:	7c02                	ld	s8,32(sp)
ffffffffc0203ad6:	6ce2                	ld	s9,24(sp)
ffffffffc0203ad8:	6d42                	ld	s10,16(sp)
ffffffffc0203ada:	6da2                	ld	s11,8(sp)
ffffffffc0203adc:	6165                	addi	sp,sp,112
ffffffffc0203ade:	8082                	ret
ffffffffc0203ae0:	4785                	li	a5,1
ffffffffc0203ae2:	c19c                	sw	a5,0(a1)
ffffffffc0203ae4:	4505                	li	a0,1
ffffffffc0203ae6:	0000a897          	auipc	a7,0xa
ffffffffc0203aea:	5a688893          	addi	a7,a7,1446 # ffffffffc020e08c <next_safe.1811>
ffffffffc0203aee:	00016497          	auipc	s1,0x16
ffffffffc0203af2:	c4a48493          	addi	s1,s1,-950 # ffffffffc0219738 <proc_list>
ffffffffc0203af6:	0084b303          	ld	t1,8(s1)
ffffffffc0203afa:	6789                	lui	a5,0x2
ffffffffc0203afc:	00f8a023          	sw	a5,0(a7)
ffffffffc0203b00:	4801                	li	a6,0
ffffffffc0203b02:	87aa                	mv	a5,a0
ffffffffc0203b04:	6e89                	lui	t4,0x2
ffffffffc0203b06:	12930e63          	beq	t1,s1,ffffffffc0203c42 <do_fork+0x33e>
ffffffffc0203b0a:	8e42                	mv	t3,a6
ffffffffc0203b0c:	869a                	mv	a3,t1
ffffffffc0203b0e:	6609                	lui	a2,0x2
ffffffffc0203b10:	a811                	j	ffffffffc0203b24 <do_fork+0x220>
ffffffffc0203b12:	00e7d663          	bge	a5,a4,ffffffffc0203b1e <do_fork+0x21a>
ffffffffc0203b16:	00c75463          	bge	a4,a2,ffffffffc0203b1e <do_fork+0x21a>
ffffffffc0203b1a:	863a                	mv	a2,a4
ffffffffc0203b1c:	4e05                	li	t3,1
ffffffffc0203b1e:	6694                	ld	a3,8(a3)
ffffffffc0203b20:	00968d63          	beq	a3,s1,ffffffffc0203b3a <do_fork+0x236>
ffffffffc0203b24:	f3c6a703          	lw	a4,-196(a3) # ffffffffc01fff3c <kern_entry-0xc4>
ffffffffc0203b28:	fef715e3          	bne	a4,a5,ffffffffc0203b12 <do_fork+0x20e>
ffffffffc0203b2c:	2785                	addiw	a5,a5,1
ffffffffc0203b2e:	08c7df63          	bge	a5,a2,ffffffffc0203bcc <do_fork+0x2c8>
ffffffffc0203b32:	6694                	ld	a3,8(a3)
ffffffffc0203b34:	4805                	li	a6,1
ffffffffc0203b36:	fe9697e3          	bne	a3,s1,ffffffffc0203b24 <do_fork+0x220>
ffffffffc0203b3a:	00080463          	beqz	a6,ffffffffc0203b42 <do_fork+0x23e>
ffffffffc0203b3e:	c19c                	sw	a5,0(a1)
ffffffffc0203b40:	853e                	mv	a0,a5
ffffffffc0203b42:	f20e02e3          	beqz	t3,ffffffffc0203a66 <do_fork+0x162>
ffffffffc0203b46:	00c8a023          	sw	a2,0(a7)
ffffffffc0203b4a:	bf31                	j	ffffffffc0203a66 <do_fork+0x162>
ffffffffc0203b4c:	6909                	lui	s2,0x2
ffffffffc0203b4e:	edc90913          	addi	s2,s2,-292 # 1edc <kern_entry-0xffffffffc01fe124>
ffffffffc0203b52:	9936                	add	s2,s2,a3
ffffffffc0203b54:	0127b823          	sd	s2,16(a5) # 2010 <kern_entry-0xffffffffc01fdff0>
ffffffffc0203b58:	00000717          	auipc	a4,0x0
ffffffffc0203b5c:	c2e70713          	addi	a4,a4,-978 # ffffffffc0203786 <forkret>
ffffffffc0203b60:	f818                	sd	a4,48(s0)
ffffffffc0203b62:	fc1c                	sd	a5,56(s0)
ffffffffc0203b64:	100027f3          	csrr	a5,sstatus
ffffffffc0203b68:	8b89                	andi	a5,a5,2
ffffffffc0203b6a:	4901                	li	s2,0
ffffffffc0203b6c:	ec0786e3          	beqz	a5,ffffffffc0203a38 <do_fork+0x134>
ffffffffc0203b70:	ac9fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203b74:	4905                	li	s2,1
ffffffffc0203b76:	b5c9                	j	ffffffffc0203a38 <do_fork+0x134>
ffffffffc0203b78:	9dafd0ef          	jal	ra,ffffffffc0200d52 <mm_create>
ffffffffc0203b7c:	8a2a                	mv	s4,a0
ffffffffc0203b7e:	c901                	beqz	a0,ffffffffc0203b8e <do_fork+0x28a>
ffffffffc0203b80:	0561                	addi	a0,a0,24
ffffffffc0203b82:	c13ff0ef          	jal	ra,ffffffffc0203794 <setup_pgdir.isra.0>
ffffffffc0203b86:	c921                	beqz	a0,ffffffffc0203bd6 <do_fork+0x2d2>
ffffffffc0203b88:	8552                	mv	a0,s4
ffffffffc0203b8a:	b26fd0ef          	jal	ra,ffffffffc0200eb0 <mm_destroy>
ffffffffc0203b8e:	6814                	ld	a3,16(s0)
ffffffffc0203b90:	c02007b7          	lui	a5,0xc0200
ffffffffc0203b94:	12f6e563          	bltu	a3,a5,ffffffffc0203cbe <do_fork+0x3ba>
ffffffffc0203b98:	000d3783          	ld	a5,0(s10)
ffffffffc0203b9c:	000cb703          	ld	a4,0(s9)
ffffffffc0203ba0:	40f687b3          	sub	a5,a3,a5
ffffffffc0203ba4:	83b1                	srli	a5,a5,0xc
ffffffffc0203ba6:	10e7f063          	bgeu	a5,a4,ffffffffc0203ca6 <do_fork+0x3a2>
ffffffffc0203baa:	000c3503          	ld	a0,0(s8)
ffffffffc0203bae:	415787b3          	sub	a5,a5,s5
ffffffffc0203bb2:	079a                	slli	a5,a5,0x6
ffffffffc0203bb4:	4589                	li	a1,2
ffffffffc0203bb6:	953e                	add	a0,a0,a5
ffffffffc0203bb8:	bb9fe0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0203bbc:	8522                	mv	a0,s0
ffffffffc0203bbe:	d3bfd0ef          	jal	ra,ffffffffc02018f8 <kfree>
ffffffffc0203bc2:	5571                	li	a0,-4
ffffffffc0203bc4:	bdfd                	j	ffffffffc0203ac2 <do_fork+0x1be>
ffffffffc0203bc6:	a6dfc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203bca:	bdc5                	j	ffffffffc0203aba <do_fork+0x1b6>
ffffffffc0203bcc:	01d7c363          	blt	a5,t4,ffffffffc0203bd2 <do_fork+0x2ce>
ffffffffc0203bd0:	4785                	li	a5,1
ffffffffc0203bd2:	4805                	li	a6,1
ffffffffc0203bd4:	bf0d                	j	ffffffffc0203b06 <do_fork+0x202>
ffffffffc0203bd6:	038b0d93          	addi	s11,s6,56
ffffffffc0203bda:	856e                	mv	a0,s11
ffffffffc0203bdc:	941ff0ef          	jal	ra,ffffffffc020351c <down>
ffffffffc0203be0:	000bb783          	ld	a5,0(s7)
ffffffffc0203be4:	c781                	beqz	a5,ffffffffc0203bec <do_fork+0x2e8>
ffffffffc0203be6:	43dc                	lw	a5,4(a5)
ffffffffc0203be8:	04fb2823          	sw	a5,80(s6)
ffffffffc0203bec:	85da                	mv	a1,s6
ffffffffc0203bee:	8552                	mv	a0,s4
ffffffffc0203bf0:	bc2fd0ef          	jal	ra,ffffffffc0200fb2 <dup_mmap>
ffffffffc0203bf4:	8baa                	mv	s7,a0
ffffffffc0203bf6:	856e                	mv	a0,s11
ffffffffc0203bf8:	923ff0ef          	jal	ra,ffffffffc020351a <up>
ffffffffc0203bfc:	040b2823          	sw	zero,80(s6)
ffffffffc0203c00:	8b52                	mv	s6,s4
ffffffffc0203c02:	da0b8ce3          	beqz	s7,ffffffffc02039ba <do_fork+0xb6>
ffffffffc0203c06:	8552                	mv	a0,s4
ffffffffc0203c08:	c44fd0ef          	jal	ra,ffffffffc020104c <exit_mmap>
ffffffffc0203c0c:	018a3683          	ld	a3,24(s4)
ffffffffc0203c10:	c02007b7          	lui	a5,0xc0200
ffffffffc0203c14:	0af6e563          	bltu	a3,a5,ffffffffc0203cbe <do_fork+0x3ba>
ffffffffc0203c18:	000d3703          	ld	a4,0(s10)
ffffffffc0203c1c:	000cb783          	ld	a5,0(s9)
ffffffffc0203c20:	8e99                	sub	a3,a3,a4
ffffffffc0203c22:	82b1                	srli	a3,a3,0xc
ffffffffc0203c24:	08f6f163          	bgeu	a3,a5,ffffffffc0203ca6 <do_fork+0x3a2>
ffffffffc0203c28:	000c3503          	ld	a0,0(s8)
ffffffffc0203c2c:	415686b3          	sub	a3,a3,s5
ffffffffc0203c30:	069a                	slli	a3,a3,0x6
ffffffffc0203c32:	9536                	add	a0,a0,a3
ffffffffc0203c34:	4585                	li	a1,1
ffffffffc0203c36:	b3bfe0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0203c3a:	8552                	mv	a0,s4
ffffffffc0203c3c:	a74fd0ef          	jal	ra,ffffffffc0200eb0 <mm_destroy>
ffffffffc0203c40:	b7b9                	j	ffffffffc0203b8e <do_fork+0x28a>
ffffffffc0203c42:	00080763          	beqz	a6,ffffffffc0203c50 <do_fork+0x34c>
ffffffffc0203c46:	c19c                	sw	a5,0(a1)
ffffffffc0203c48:	853e                	mv	a0,a5
ffffffffc0203c4a:	bd31                	j	ffffffffc0203a66 <do_fork+0x162>
ffffffffc0203c4c:	556d                	li	a0,-5
ffffffffc0203c4e:	bd95                	j	ffffffffc0203ac2 <do_fork+0x1be>
ffffffffc0203c50:	4188                	lw	a0,0(a1)
ffffffffc0203c52:	bd11                	j	ffffffffc0203a66 <do_fork+0x162>
ffffffffc0203c54:	00005617          	auipc	a2,0x5
ffffffffc0203c58:	03c60613          	addi	a2,a2,60 # ffffffffc0208c90 <commands+0xa98>
ffffffffc0203c5c:	06900593          	li	a1,105
ffffffffc0203c60:	00005517          	auipc	a0,0x5
ffffffffc0203c64:	05850513          	addi	a0,a0,88 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc0203c68:	da0fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c6c:	00006697          	auipc	a3,0x6
ffffffffc0203c70:	92468693          	addi	a3,a3,-1756 # ffffffffc0209590 <default_pmm_manager+0x368>
ffffffffc0203c74:	00005617          	auipc	a2,0x5
ffffffffc0203c78:	99460613          	addi	a2,a2,-1644 # ffffffffc0208608 <commands+0x410>
ffffffffc0203c7c:	1a600593          	li	a1,422
ffffffffc0203c80:	00006517          	auipc	a0,0x6
ffffffffc0203c84:	93050513          	addi	a0,a0,-1744 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc0203c88:	d80fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c8c:	86be                	mv	a3,a5
ffffffffc0203c8e:	00005617          	auipc	a2,0x5
ffffffffc0203c92:	07260613          	addi	a2,a2,114 # ffffffffc0208d00 <commands+0xb08>
ffffffffc0203c96:	15900593          	li	a1,345
ffffffffc0203c9a:	00006517          	auipc	a0,0x6
ffffffffc0203c9e:	91650513          	addi	a0,a0,-1770 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc0203ca2:	d66fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203ca6:	00005617          	auipc	a2,0x5
ffffffffc0203caa:	08260613          	addi	a2,a2,130 # ffffffffc0208d28 <commands+0xb30>
ffffffffc0203cae:	06200593          	li	a1,98
ffffffffc0203cb2:	00005517          	auipc	a0,0x5
ffffffffc0203cb6:	00650513          	addi	a0,a0,6 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc0203cba:	d4efc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203cbe:	00005617          	auipc	a2,0x5
ffffffffc0203cc2:	04260613          	addi	a2,a2,66 # ffffffffc0208d00 <commands+0xb08>
ffffffffc0203cc6:	06e00593          	li	a1,110
ffffffffc0203cca:	00005517          	auipc	a0,0x5
ffffffffc0203cce:	fee50513          	addi	a0,a0,-18 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc0203cd2:	d36fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203cd6 <kernel_thread>:
ffffffffc0203cd6:	7129                	addi	sp,sp,-320
ffffffffc0203cd8:	fa22                	sd	s0,304(sp)
ffffffffc0203cda:	f626                	sd	s1,296(sp)
ffffffffc0203cdc:	f24a                	sd	s2,288(sp)
ffffffffc0203cde:	84ae                	mv	s1,a1
ffffffffc0203ce0:	892a                	mv	s2,a0
ffffffffc0203ce2:	8432                	mv	s0,a2
ffffffffc0203ce4:	4581                	li	a1,0
ffffffffc0203ce6:	12000613          	li	a2,288
ffffffffc0203cea:	850a                	mv	a0,sp
ffffffffc0203cec:	fe06                	sd	ra,312(sp)
ffffffffc0203cee:	639030ef          	jal	ra,ffffffffc0207b26 <memset>
ffffffffc0203cf2:	e0ca                	sd	s2,64(sp)
ffffffffc0203cf4:	e4a6                	sd	s1,72(sp)
ffffffffc0203cf6:	100027f3          	csrr	a5,sstatus
ffffffffc0203cfa:	edd7f793          	andi	a5,a5,-291
ffffffffc0203cfe:	1207e793          	ori	a5,a5,288
ffffffffc0203d02:	e23e                	sd	a5,256(sp)
ffffffffc0203d04:	860a                	mv	a2,sp
ffffffffc0203d06:	10046513          	ori	a0,s0,256
ffffffffc0203d0a:	00000797          	auipc	a5,0x0
ffffffffc0203d0e:	a0278793          	addi	a5,a5,-1534 # ffffffffc020370c <kernel_thread_entry>
ffffffffc0203d12:	4581                	li	a1,0
ffffffffc0203d14:	e63e                	sd	a5,264(sp)
ffffffffc0203d16:	befff0ef          	jal	ra,ffffffffc0203904 <do_fork>
ffffffffc0203d1a:	70f2                	ld	ra,312(sp)
ffffffffc0203d1c:	7452                	ld	s0,304(sp)
ffffffffc0203d1e:	74b2                	ld	s1,296(sp)
ffffffffc0203d20:	7912                	ld	s2,288(sp)
ffffffffc0203d22:	6131                	addi	sp,sp,320
ffffffffc0203d24:	8082                	ret

ffffffffc0203d26 <do_exit>:
ffffffffc0203d26:	7179                	addi	sp,sp,-48
ffffffffc0203d28:	f022                	sd	s0,32(sp)
ffffffffc0203d2a:	00015417          	auipc	s0,0x15
ffffffffc0203d2e:	7ce40413          	addi	s0,s0,1998 # ffffffffc02194f8 <current>
ffffffffc0203d32:	601c                	ld	a5,0(s0)
ffffffffc0203d34:	f406                	sd	ra,40(sp)
ffffffffc0203d36:	ec26                	sd	s1,24(sp)
ffffffffc0203d38:	e84a                	sd	s2,16(sp)
ffffffffc0203d3a:	e44e                	sd	s3,8(sp)
ffffffffc0203d3c:	e052                	sd	s4,0(sp)
ffffffffc0203d3e:	00015717          	auipc	a4,0x15
ffffffffc0203d42:	7c273703          	ld	a4,1986(a4) # ffffffffc0219500 <idleproc>
ffffffffc0203d46:	0ce78d63          	beq	a5,a4,ffffffffc0203e20 <do_exit+0xfa>
ffffffffc0203d4a:	00015497          	auipc	s1,0x15
ffffffffc0203d4e:	7be48493          	addi	s1,s1,1982 # ffffffffc0219508 <initproc>
ffffffffc0203d52:	6098                	ld	a4,0(s1)
ffffffffc0203d54:	12e78963          	beq	a5,a4,ffffffffc0203e86 <do_exit+0x160>
ffffffffc0203d58:	0287b903          	ld	s2,40(a5)
ffffffffc0203d5c:	89aa                	mv	s3,a0
ffffffffc0203d5e:	02090663          	beqz	s2,ffffffffc0203d8a <do_exit+0x64>
ffffffffc0203d62:	00016797          	auipc	a5,0x16
ffffffffc0203d66:	8d67b783          	ld	a5,-1834(a5) # ffffffffc0219638 <boot_cr3>
ffffffffc0203d6a:	577d                	li	a4,-1
ffffffffc0203d6c:	177e                	slli	a4,a4,0x3f
ffffffffc0203d6e:	83b1                	srli	a5,a5,0xc
ffffffffc0203d70:	8fd9                	or	a5,a5,a4
ffffffffc0203d72:	18079073          	csrw	satp,a5
ffffffffc0203d76:	03092783          	lw	a5,48(s2)
ffffffffc0203d7a:	fff7871b          	addiw	a4,a5,-1
ffffffffc0203d7e:	02e92823          	sw	a4,48(s2)
ffffffffc0203d82:	cb5d                	beqz	a4,ffffffffc0203e38 <do_exit+0x112>
ffffffffc0203d84:	601c                	ld	a5,0(s0)
ffffffffc0203d86:	0207b423          	sd	zero,40(a5)
ffffffffc0203d8a:	601c                	ld	a5,0(s0)
ffffffffc0203d8c:	470d                	li	a4,3
ffffffffc0203d8e:	c398                	sw	a4,0(a5)
ffffffffc0203d90:	0f37a423          	sw	s3,232(a5)
ffffffffc0203d94:	100027f3          	csrr	a5,sstatus
ffffffffc0203d98:	8b89                	andi	a5,a5,2
ffffffffc0203d9a:	4a01                	li	s4,0
ffffffffc0203d9c:	10079163          	bnez	a5,ffffffffc0203e9e <do_exit+0x178>
ffffffffc0203da0:	6018                	ld	a4,0(s0)
ffffffffc0203da2:	800007b7          	lui	a5,0x80000
ffffffffc0203da6:	0785                	addi	a5,a5,1
ffffffffc0203da8:	7308                	ld	a0,32(a4)
ffffffffc0203daa:	0ec52703          	lw	a4,236(a0)
ffffffffc0203dae:	0ef70c63          	beq	a4,a5,ffffffffc0203ea6 <do_exit+0x180>
ffffffffc0203db2:	6018                	ld	a4,0(s0)
ffffffffc0203db4:	7b7c                	ld	a5,240(a4)
ffffffffc0203db6:	c3a1                	beqz	a5,ffffffffc0203df6 <do_exit+0xd0>
ffffffffc0203db8:	800009b7          	lui	s3,0x80000
ffffffffc0203dbc:	490d                	li	s2,3
ffffffffc0203dbe:	0985                	addi	s3,s3,1
ffffffffc0203dc0:	a021                	j	ffffffffc0203dc8 <do_exit+0xa2>
ffffffffc0203dc2:	6018                	ld	a4,0(s0)
ffffffffc0203dc4:	7b7c                	ld	a5,240(a4)
ffffffffc0203dc6:	cb85                	beqz	a5,ffffffffc0203df6 <do_exit+0xd0>
ffffffffc0203dc8:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <kern_entry-0x401fff00>
ffffffffc0203dcc:	6088                	ld	a0,0(s1)
ffffffffc0203dce:	fb74                	sd	a3,240(a4)
ffffffffc0203dd0:	7978                	ld	a4,240(a0)
ffffffffc0203dd2:	0e07bc23          	sd	zero,248(a5)
ffffffffc0203dd6:	10e7b023          	sd	a4,256(a5)
ffffffffc0203dda:	c311                	beqz	a4,ffffffffc0203dde <do_exit+0xb8>
ffffffffc0203ddc:	ff7c                	sd	a5,248(a4)
ffffffffc0203dde:	4398                	lw	a4,0(a5)
ffffffffc0203de0:	f388                	sd	a0,32(a5)
ffffffffc0203de2:	f97c                	sd	a5,240(a0)
ffffffffc0203de4:	fd271fe3          	bne	a4,s2,ffffffffc0203dc2 <do_exit+0x9c>
ffffffffc0203de8:	0ec52783          	lw	a5,236(a0)
ffffffffc0203dec:	fd379be3          	bne	a5,s3,ffffffffc0203dc2 <do_exit+0x9c>
ffffffffc0203df0:	3ff000ef          	jal	ra,ffffffffc02049ee <wakeup_proc>
ffffffffc0203df4:	b7f9                	j	ffffffffc0203dc2 <do_exit+0x9c>
ffffffffc0203df6:	020a1263          	bnez	s4,ffffffffc0203e1a <do_exit+0xf4>
ffffffffc0203dfa:	4a7000ef          	jal	ra,ffffffffc0204aa0 <schedule>
ffffffffc0203dfe:	601c                	ld	a5,0(s0)
ffffffffc0203e00:	00005617          	auipc	a2,0x5
ffffffffc0203e04:	7e860613          	addi	a2,a2,2024 # ffffffffc02095e8 <default_pmm_manager+0x3c0>
ffffffffc0203e08:	1f900593          	li	a1,505
ffffffffc0203e0c:	43d4                	lw	a3,4(a5)
ffffffffc0203e0e:	00005517          	auipc	a0,0x5
ffffffffc0203e12:	7a250513          	addi	a0,a0,1954 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc0203e16:	bf2fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203e1a:	819fc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203e1e:	bff1                	j	ffffffffc0203dfa <do_exit+0xd4>
ffffffffc0203e20:	00005617          	auipc	a2,0x5
ffffffffc0203e24:	7a860613          	addi	a2,a2,1960 # ffffffffc02095c8 <default_pmm_manager+0x3a0>
ffffffffc0203e28:	1cd00593          	li	a1,461
ffffffffc0203e2c:	00005517          	auipc	a0,0x5
ffffffffc0203e30:	78450513          	addi	a0,a0,1924 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc0203e34:	bd4fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203e38:	854a                	mv	a0,s2
ffffffffc0203e3a:	a12fd0ef          	jal	ra,ffffffffc020104c <exit_mmap>
ffffffffc0203e3e:	01893683          	ld	a3,24(s2)
ffffffffc0203e42:	c02007b7          	lui	a5,0xc0200
ffffffffc0203e46:	06f6e363          	bltu	a3,a5,ffffffffc0203eac <do_exit+0x186>
ffffffffc0203e4a:	00015797          	auipc	a5,0x15
ffffffffc0203e4e:	7e67b783          	ld	a5,2022(a5) # ffffffffc0219630 <va_pa_offset>
ffffffffc0203e52:	8e9d                	sub	a3,a3,a5
ffffffffc0203e54:	82b1                	srli	a3,a3,0xc
ffffffffc0203e56:	00015797          	auipc	a5,0x15
ffffffffc0203e5a:	69a7b783          	ld	a5,1690(a5) # ffffffffc02194f0 <npage>
ffffffffc0203e5e:	06f6f363          	bgeu	a3,a5,ffffffffc0203ec4 <do_exit+0x19e>
ffffffffc0203e62:	00006517          	auipc	a0,0x6
ffffffffc0203e66:	7ee53503          	ld	a0,2030(a0) # ffffffffc020a650 <nbase>
ffffffffc0203e6a:	8e89                	sub	a3,a3,a0
ffffffffc0203e6c:	069a                	slli	a3,a3,0x6
ffffffffc0203e6e:	00015517          	auipc	a0,0x15
ffffffffc0203e72:	7d253503          	ld	a0,2002(a0) # ffffffffc0219640 <pages>
ffffffffc0203e76:	9536                	add	a0,a0,a3
ffffffffc0203e78:	4585                	li	a1,1
ffffffffc0203e7a:	8f7fe0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0203e7e:	854a                	mv	a0,s2
ffffffffc0203e80:	830fd0ef          	jal	ra,ffffffffc0200eb0 <mm_destroy>
ffffffffc0203e84:	b701                	j	ffffffffc0203d84 <do_exit+0x5e>
ffffffffc0203e86:	00005617          	auipc	a2,0x5
ffffffffc0203e8a:	75260613          	addi	a2,a2,1874 # ffffffffc02095d8 <default_pmm_manager+0x3b0>
ffffffffc0203e8e:	1d000593          	li	a1,464
ffffffffc0203e92:	00005517          	auipc	a0,0x5
ffffffffc0203e96:	71e50513          	addi	a0,a0,1822 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc0203e9a:	b6efc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203e9e:	f9afc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203ea2:	4a05                	li	s4,1
ffffffffc0203ea4:	bdf5                	j	ffffffffc0203da0 <do_exit+0x7a>
ffffffffc0203ea6:	349000ef          	jal	ra,ffffffffc02049ee <wakeup_proc>
ffffffffc0203eaa:	b721                	j	ffffffffc0203db2 <do_exit+0x8c>
ffffffffc0203eac:	00005617          	auipc	a2,0x5
ffffffffc0203eb0:	e5460613          	addi	a2,a2,-428 # ffffffffc0208d00 <commands+0xb08>
ffffffffc0203eb4:	06e00593          	li	a1,110
ffffffffc0203eb8:	00005517          	auipc	a0,0x5
ffffffffc0203ebc:	e0050513          	addi	a0,a0,-512 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc0203ec0:	b48fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203ec4:	00005617          	auipc	a2,0x5
ffffffffc0203ec8:	e6460613          	addi	a2,a2,-412 # ffffffffc0208d28 <commands+0xb30>
ffffffffc0203ecc:	06200593          	li	a1,98
ffffffffc0203ed0:	00005517          	auipc	a0,0x5
ffffffffc0203ed4:	de850513          	addi	a0,a0,-536 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc0203ed8:	b30fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203edc <do_wait.part.0>:
ffffffffc0203edc:	7139                	addi	sp,sp,-64
ffffffffc0203ede:	e852                	sd	s4,16(sp)
ffffffffc0203ee0:	80000a37          	lui	s4,0x80000
ffffffffc0203ee4:	f426                	sd	s1,40(sp)
ffffffffc0203ee6:	f04a                	sd	s2,32(sp)
ffffffffc0203ee8:	ec4e                	sd	s3,24(sp)
ffffffffc0203eea:	e456                	sd	s5,8(sp)
ffffffffc0203eec:	e05a                	sd	s6,0(sp)
ffffffffc0203eee:	fc06                	sd	ra,56(sp)
ffffffffc0203ef0:	f822                	sd	s0,48(sp)
ffffffffc0203ef2:	892a                	mv	s2,a0
ffffffffc0203ef4:	8aae                	mv	s5,a1
ffffffffc0203ef6:	00015997          	auipc	s3,0x15
ffffffffc0203efa:	60298993          	addi	s3,s3,1538 # ffffffffc02194f8 <current>
ffffffffc0203efe:	448d                	li	s1,3
ffffffffc0203f00:	4b05                	li	s6,1
ffffffffc0203f02:	2a05                	addiw	s4,s4,1
ffffffffc0203f04:	02090f63          	beqz	s2,ffffffffc0203f42 <do_wait.part.0+0x66>
ffffffffc0203f08:	854a                	mv	a0,s2
ffffffffc0203f0a:	9a3ff0ef          	jal	ra,ffffffffc02038ac <find_proc>
ffffffffc0203f0e:	842a                	mv	s0,a0
ffffffffc0203f10:	10050763          	beqz	a0,ffffffffc020401e <do_wait.part.0+0x142>
ffffffffc0203f14:	0009b703          	ld	a4,0(s3)
ffffffffc0203f18:	711c                	ld	a5,32(a0)
ffffffffc0203f1a:	10e79263          	bne	a5,a4,ffffffffc020401e <do_wait.part.0+0x142>
ffffffffc0203f1e:	411c                	lw	a5,0(a0)
ffffffffc0203f20:	02978c63          	beq	a5,s1,ffffffffc0203f58 <do_wait.part.0+0x7c>
ffffffffc0203f24:	01672023          	sw	s6,0(a4)
ffffffffc0203f28:	0f472623          	sw	s4,236(a4)
ffffffffc0203f2c:	375000ef          	jal	ra,ffffffffc0204aa0 <schedule>
ffffffffc0203f30:	0009b783          	ld	a5,0(s3)
ffffffffc0203f34:	0b07a783          	lw	a5,176(a5)
ffffffffc0203f38:	8b85                	andi	a5,a5,1
ffffffffc0203f3a:	d7e9                	beqz	a5,ffffffffc0203f04 <do_wait.part.0+0x28>
ffffffffc0203f3c:	555d                	li	a0,-9
ffffffffc0203f3e:	de9ff0ef          	jal	ra,ffffffffc0203d26 <do_exit>
ffffffffc0203f42:	0009b703          	ld	a4,0(s3)
ffffffffc0203f46:	7b60                	ld	s0,240(a4)
ffffffffc0203f48:	e409                	bnez	s0,ffffffffc0203f52 <do_wait.part.0+0x76>
ffffffffc0203f4a:	a8d1                	j	ffffffffc020401e <do_wait.part.0+0x142>
ffffffffc0203f4c:	10043403          	ld	s0,256(s0)
ffffffffc0203f50:	d871                	beqz	s0,ffffffffc0203f24 <do_wait.part.0+0x48>
ffffffffc0203f52:	401c                	lw	a5,0(s0)
ffffffffc0203f54:	fe979ce3          	bne	a5,s1,ffffffffc0203f4c <do_wait.part.0+0x70>
ffffffffc0203f58:	00015797          	auipc	a5,0x15
ffffffffc0203f5c:	5a87b783          	ld	a5,1448(a5) # ffffffffc0219500 <idleproc>
ffffffffc0203f60:	0c878563          	beq	a5,s0,ffffffffc020402a <do_wait.part.0+0x14e>
ffffffffc0203f64:	00015797          	auipc	a5,0x15
ffffffffc0203f68:	5a47b783          	ld	a5,1444(a5) # ffffffffc0219508 <initproc>
ffffffffc0203f6c:	0af40f63          	beq	s0,a5,ffffffffc020402a <do_wait.part.0+0x14e>
ffffffffc0203f70:	000a8663          	beqz	s5,ffffffffc0203f7c <do_wait.part.0+0xa0>
ffffffffc0203f74:	0e842783          	lw	a5,232(s0)
ffffffffc0203f78:	00faa023          	sw	a5,0(s5)
ffffffffc0203f7c:	100027f3          	csrr	a5,sstatus
ffffffffc0203f80:	8b89                	andi	a5,a5,2
ffffffffc0203f82:	4581                	li	a1,0
ffffffffc0203f84:	efd9                	bnez	a5,ffffffffc0204022 <do_wait.part.0+0x146>
ffffffffc0203f86:	6c70                	ld	a2,216(s0)
ffffffffc0203f88:	7074                	ld	a3,224(s0)
ffffffffc0203f8a:	10043703          	ld	a4,256(s0)
ffffffffc0203f8e:	7c7c                	ld	a5,248(s0)
ffffffffc0203f90:	e614                	sd	a3,8(a2)
ffffffffc0203f92:	e290                	sd	a2,0(a3)
ffffffffc0203f94:	6470                	ld	a2,200(s0)
ffffffffc0203f96:	6874                	ld	a3,208(s0)
ffffffffc0203f98:	e614                	sd	a3,8(a2)
ffffffffc0203f9a:	e290                	sd	a2,0(a3)
ffffffffc0203f9c:	c319                	beqz	a4,ffffffffc0203fa2 <do_wait.part.0+0xc6>
ffffffffc0203f9e:	ff7c                	sd	a5,248(a4)
ffffffffc0203fa0:	7c7c                	ld	a5,248(s0)
ffffffffc0203fa2:	cbbd                	beqz	a5,ffffffffc0204018 <do_wait.part.0+0x13c>
ffffffffc0203fa4:	10e7b023          	sd	a4,256(a5)
ffffffffc0203fa8:	00015717          	auipc	a4,0x15
ffffffffc0203fac:	56870713          	addi	a4,a4,1384 # ffffffffc0219510 <nr_process>
ffffffffc0203fb0:	431c                	lw	a5,0(a4)
ffffffffc0203fb2:	37fd                	addiw	a5,a5,-1
ffffffffc0203fb4:	c31c                	sw	a5,0(a4)
ffffffffc0203fb6:	edb1                	bnez	a1,ffffffffc0204012 <do_wait.part.0+0x136>
ffffffffc0203fb8:	6814                	ld	a3,16(s0)
ffffffffc0203fba:	c02007b7          	lui	a5,0xc0200
ffffffffc0203fbe:	08f6ee63          	bltu	a3,a5,ffffffffc020405a <do_wait.part.0+0x17e>
ffffffffc0203fc2:	00015797          	auipc	a5,0x15
ffffffffc0203fc6:	66e7b783          	ld	a5,1646(a5) # ffffffffc0219630 <va_pa_offset>
ffffffffc0203fca:	8e9d                	sub	a3,a3,a5
ffffffffc0203fcc:	82b1                	srli	a3,a3,0xc
ffffffffc0203fce:	00015797          	auipc	a5,0x15
ffffffffc0203fd2:	5227b783          	ld	a5,1314(a5) # ffffffffc02194f0 <npage>
ffffffffc0203fd6:	06f6f663          	bgeu	a3,a5,ffffffffc0204042 <do_wait.part.0+0x166>
ffffffffc0203fda:	00006517          	auipc	a0,0x6
ffffffffc0203fde:	67653503          	ld	a0,1654(a0) # ffffffffc020a650 <nbase>
ffffffffc0203fe2:	8e89                	sub	a3,a3,a0
ffffffffc0203fe4:	069a                	slli	a3,a3,0x6
ffffffffc0203fe6:	00015517          	auipc	a0,0x15
ffffffffc0203fea:	65a53503          	ld	a0,1626(a0) # ffffffffc0219640 <pages>
ffffffffc0203fee:	9536                	add	a0,a0,a3
ffffffffc0203ff0:	4589                	li	a1,2
ffffffffc0203ff2:	f7efe0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0203ff6:	8522                	mv	a0,s0
ffffffffc0203ff8:	901fd0ef          	jal	ra,ffffffffc02018f8 <kfree>
ffffffffc0203ffc:	4501                	li	a0,0
ffffffffc0203ffe:	70e2                	ld	ra,56(sp)
ffffffffc0204000:	7442                	ld	s0,48(sp)
ffffffffc0204002:	74a2                	ld	s1,40(sp)
ffffffffc0204004:	7902                	ld	s2,32(sp)
ffffffffc0204006:	69e2                	ld	s3,24(sp)
ffffffffc0204008:	6a42                	ld	s4,16(sp)
ffffffffc020400a:	6aa2                	ld	s5,8(sp)
ffffffffc020400c:	6b02                	ld	s6,0(sp)
ffffffffc020400e:	6121                	addi	sp,sp,64
ffffffffc0204010:	8082                	ret
ffffffffc0204012:	e20fc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0204016:	b74d                	j	ffffffffc0203fb8 <do_wait.part.0+0xdc>
ffffffffc0204018:	701c                	ld	a5,32(s0)
ffffffffc020401a:	fbf8                	sd	a4,240(a5)
ffffffffc020401c:	b771                	j	ffffffffc0203fa8 <do_wait.part.0+0xcc>
ffffffffc020401e:	5579                	li	a0,-2
ffffffffc0204020:	bff9                	j	ffffffffc0203ffe <do_wait.part.0+0x122>
ffffffffc0204022:	e16fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204026:	4585                	li	a1,1
ffffffffc0204028:	bfb9                	j	ffffffffc0203f86 <do_wait.part.0+0xaa>
ffffffffc020402a:	00005617          	auipc	a2,0x5
ffffffffc020402e:	5de60613          	addi	a2,a2,1502 # ffffffffc0209608 <default_pmm_manager+0x3e0>
ffffffffc0204032:	2f600593          	li	a1,758
ffffffffc0204036:	00005517          	auipc	a0,0x5
ffffffffc020403a:	57a50513          	addi	a0,a0,1402 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc020403e:	9cafc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204042:	00005617          	auipc	a2,0x5
ffffffffc0204046:	ce660613          	addi	a2,a2,-794 # ffffffffc0208d28 <commands+0xb30>
ffffffffc020404a:	06200593          	li	a1,98
ffffffffc020404e:	00005517          	auipc	a0,0x5
ffffffffc0204052:	c6a50513          	addi	a0,a0,-918 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc0204056:	9b2fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020405a:	00005617          	auipc	a2,0x5
ffffffffc020405e:	ca660613          	addi	a2,a2,-858 # ffffffffc0208d00 <commands+0xb08>
ffffffffc0204062:	06e00593          	li	a1,110
ffffffffc0204066:	00005517          	auipc	a0,0x5
ffffffffc020406a:	c5250513          	addi	a0,a0,-942 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc020406e:	99afc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204072 <init_main>:
ffffffffc0204072:	1141                	addi	sp,sp,-16
ffffffffc0204074:	e406                	sd	ra,8(sp)
ffffffffc0204076:	f3cfe0ef          	jal	ra,ffffffffc02027b2 <nr_free_pages>
ffffffffc020407a:	fcafd0ef          	jal	ra,ffffffffc0201844 <kallocated>
ffffffffc020407e:	9ccff0ef          	jal	ra,ffffffffc020324a <check_sync>
ffffffffc0204082:	a019                	j	ffffffffc0204088 <init_main+0x16>
ffffffffc0204084:	21d000ef          	jal	ra,ffffffffc0204aa0 <schedule>
ffffffffc0204088:	4581                	li	a1,0
ffffffffc020408a:	4501                	li	a0,0
ffffffffc020408c:	e51ff0ef          	jal	ra,ffffffffc0203edc <do_wait.part.0>
ffffffffc0204090:	d975                	beqz	a0,ffffffffc0204084 <init_main+0x12>
ffffffffc0204092:	00005517          	auipc	a0,0x5
ffffffffc0204096:	59650513          	addi	a0,a0,1430 # ffffffffc0209628 <default_pmm_manager+0x400>
ffffffffc020409a:	832fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020409e:	00015797          	auipc	a5,0x15
ffffffffc02040a2:	46a7b783          	ld	a5,1130(a5) # ffffffffc0219508 <initproc>
ffffffffc02040a6:	7bf8                	ld	a4,240(a5)
ffffffffc02040a8:	e339                	bnez	a4,ffffffffc02040ee <init_main+0x7c>
ffffffffc02040aa:	7ff8                	ld	a4,248(a5)
ffffffffc02040ac:	e329                	bnez	a4,ffffffffc02040ee <init_main+0x7c>
ffffffffc02040ae:	1007b703          	ld	a4,256(a5)
ffffffffc02040b2:	ef15                	bnez	a4,ffffffffc02040ee <init_main+0x7c>
ffffffffc02040b4:	00015697          	auipc	a3,0x15
ffffffffc02040b8:	45c6a683          	lw	a3,1116(a3) # ffffffffc0219510 <nr_process>
ffffffffc02040bc:	4709                	li	a4,2
ffffffffc02040be:	08e69863          	bne	a3,a4,ffffffffc020414e <init_main+0xdc>
ffffffffc02040c2:	00015717          	auipc	a4,0x15
ffffffffc02040c6:	67670713          	addi	a4,a4,1654 # ffffffffc0219738 <proc_list>
ffffffffc02040ca:	6714                	ld	a3,8(a4)
ffffffffc02040cc:	0c878793          	addi	a5,a5,200
ffffffffc02040d0:	04d79f63          	bne	a5,a3,ffffffffc020412e <init_main+0xbc>
ffffffffc02040d4:	6318                	ld	a4,0(a4)
ffffffffc02040d6:	02e79c63          	bne	a5,a4,ffffffffc020410e <init_main+0x9c>
ffffffffc02040da:	00005517          	auipc	a0,0x5
ffffffffc02040de:	63650513          	addi	a0,a0,1590 # ffffffffc0209710 <default_pmm_manager+0x4e8>
ffffffffc02040e2:	febfb0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02040e6:	60a2                	ld	ra,8(sp)
ffffffffc02040e8:	4501                	li	a0,0
ffffffffc02040ea:	0141                	addi	sp,sp,16
ffffffffc02040ec:	8082                	ret
ffffffffc02040ee:	00005697          	auipc	a3,0x5
ffffffffc02040f2:	56268693          	addi	a3,a3,1378 # ffffffffc0209650 <default_pmm_manager+0x428>
ffffffffc02040f6:	00004617          	auipc	a2,0x4
ffffffffc02040fa:	51260613          	addi	a2,a2,1298 # ffffffffc0208608 <commands+0x410>
ffffffffc02040fe:	35f00593          	li	a1,863
ffffffffc0204102:	00005517          	auipc	a0,0x5
ffffffffc0204106:	4ae50513          	addi	a0,a0,1198 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc020410a:	8fefc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020410e:	00005697          	auipc	a3,0x5
ffffffffc0204112:	5d268693          	addi	a3,a3,1490 # ffffffffc02096e0 <default_pmm_manager+0x4b8>
ffffffffc0204116:	00004617          	auipc	a2,0x4
ffffffffc020411a:	4f260613          	addi	a2,a2,1266 # ffffffffc0208608 <commands+0x410>
ffffffffc020411e:	36200593          	li	a1,866
ffffffffc0204122:	00005517          	auipc	a0,0x5
ffffffffc0204126:	48e50513          	addi	a0,a0,1166 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc020412a:	8defc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020412e:	00005697          	auipc	a3,0x5
ffffffffc0204132:	58268693          	addi	a3,a3,1410 # ffffffffc02096b0 <default_pmm_manager+0x488>
ffffffffc0204136:	00004617          	auipc	a2,0x4
ffffffffc020413a:	4d260613          	addi	a2,a2,1234 # ffffffffc0208608 <commands+0x410>
ffffffffc020413e:	36100593          	li	a1,865
ffffffffc0204142:	00005517          	auipc	a0,0x5
ffffffffc0204146:	46e50513          	addi	a0,a0,1134 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc020414a:	8befc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020414e:	00005697          	auipc	a3,0x5
ffffffffc0204152:	55268693          	addi	a3,a3,1362 # ffffffffc02096a0 <default_pmm_manager+0x478>
ffffffffc0204156:	00004617          	auipc	a2,0x4
ffffffffc020415a:	4b260613          	addi	a2,a2,1202 # ffffffffc0208608 <commands+0x410>
ffffffffc020415e:	36000593          	li	a1,864
ffffffffc0204162:	00005517          	auipc	a0,0x5
ffffffffc0204166:	44e50513          	addi	a0,a0,1102 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc020416a:	89efc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020416e <do_execve>:
ffffffffc020416e:	7135                	addi	sp,sp,-160
ffffffffc0204170:	f4d6                	sd	s5,104(sp)
ffffffffc0204172:	00015a97          	auipc	s5,0x15
ffffffffc0204176:	386a8a93          	addi	s5,s5,902 # ffffffffc02194f8 <current>
ffffffffc020417a:	000ab783          	ld	a5,0(s5)
ffffffffc020417e:	f8d2                	sd	s4,112(sp)
ffffffffc0204180:	e526                	sd	s1,136(sp)
ffffffffc0204182:	0287ba03          	ld	s4,40(a5)
ffffffffc0204186:	e14a                	sd	s2,128(sp)
ffffffffc0204188:	fcce                	sd	s3,120(sp)
ffffffffc020418a:	892a                	mv	s2,a0
ffffffffc020418c:	84ae                	mv	s1,a1
ffffffffc020418e:	89b2                	mv	s3,a2
ffffffffc0204190:	4681                	li	a3,0
ffffffffc0204192:	862e                	mv	a2,a1
ffffffffc0204194:	85aa                	mv	a1,a0
ffffffffc0204196:	8552                	mv	a0,s4
ffffffffc0204198:	ed06                	sd	ra,152(sp)
ffffffffc020419a:	e922                	sd	s0,144(sp)
ffffffffc020419c:	f0da                	sd	s6,96(sp)
ffffffffc020419e:	ecde                	sd	s7,88(sp)
ffffffffc02041a0:	e8e2                	sd	s8,80(sp)
ffffffffc02041a2:	e4e6                	sd	s9,72(sp)
ffffffffc02041a4:	e0ea                	sd	s10,64(sp)
ffffffffc02041a6:	fc6e                	sd	s11,56(sp)
ffffffffc02041a8:	81efd0ef          	jal	ra,ffffffffc02011c6 <user_mem_check>
ffffffffc02041ac:	46050063          	beqz	a0,ffffffffc020460c <do_execve+0x49e>
ffffffffc02041b0:	4641                	li	a2,16
ffffffffc02041b2:	4581                	li	a1,0
ffffffffc02041b4:	1008                	addi	a0,sp,32
ffffffffc02041b6:	171030ef          	jal	ra,ffffffffc0207b26 <memset>
ffffffffc02041ba:	47bd                	li	a5,15
ffffffffc02041bc:	8626                	mv	a2,s1
ffffffffc02041be:	1897ea63          	bltu	a5,s1,ffffffffc0204352 <do_execve+0x1e4>
ffffffffc02041c2:	85ca                	mv	a1,s2
ffffffffc02041c4:	1008                	addi	a0,sp,32
ffffffffc02041c6:	173030ef          	jal	ra,ffffffffc0207b38 <memcpy>
ffffffffc02041ca:	180a0b63          	beqz	s4,ffffffffc0204360 <do_execve+0x1f2>
ffffffffc02041ce:	00004517          	auipc	a0,0x4
ffffffffc02041d2:	7d250513          	addi	a0,a0,2002 # ffffffffc02089a0 <commands+0x7a8>
ffffffffc02041d6:	f2ffb0ef          	jal	ra,ffffffffc0200104 <cputs>
ffffffffc02041da:	00015797          	auipc	a5,0x15
ffffffffc02041de:	45e7b783          	ld	a5,1118(a5) # ffffffffc0219638 <boot_cr3>
ffffffffc02041e2:	577d                	li	a4,-1
ffffffffc02041e4:	177e                	slli	a4,a4,0x3f
ffffffffc02041e6:	83b1                	srli	a5,a5,0xc
ffffffffc02041e8:	8fd9                	or	a5,a5,a4
ffffffffc02041ea:	18079073          	csrw	satp,a5
ffffffffc02041ee:	030a2783          	lw	a5,48(s4) # ffffffff80000030 <kern_entry-0x401fffd0>
ffffffffc02041f2:	fff7871b          	addiw	a4,a5,-1
ffffffffc02041f6:	02ea2823          	sw	a4,48(s4)
ffffffffc02041fa:	2c070163          	beqz	a4,ffffffffc02044bc <do_execve+0x34e>
ffffffffc02041fe:	000ab783          	ld	a5,0(s5)
ffffffffc0204202:	0207b423          	sd	zero,40(a5)
ffffffffc0204206:	b4dfc0ef          	jal	ra,ffffffffc0200d52 <mm_create>
ffffffffc020420a:	84aa                	mv	s1,a0
ffffffffc020420c:	18050263          	beqz	a0,ffffffffc0204390 <do_execve+0x222>
ffffffffc0204210:	0561                	addi	a0,a0,24
ffffffffc0204212:	d82ff0ef          	jal	ra,ffffffffc0203794 <setup_pgdir.isra.0>
ffffffffc0204216:	16051663          	bnez	a0,ffffffffc0204382 <do_execve+0x214>
ffffffffc020421a:	0009a703          	lw	a4,0(s3)
ffffffffc020421e:	464c47b7          	lui	a5,0x464c4
ffffffffc0204222:	57f78793          	addi	a5,a5,1407 # 464c457f <kern_entry-0xffffffff79d3ba81>
ffffffffc0204226:	24f71763          	bne	a4,a5,ffffffffc0204474 <do_execve+0x306>
ffffffffc020422a:	0389d703          	lhu	a4,56(s3)
ffffffffc020422e:	0209b903          	ld	s2,32(s3)
ffffffffc0204232:	00371793          	slli	a5,a4,0x3
ffffffffc0204236:	8f99                	sub	a5,a5,a4
ffffffffc0204238:	994e                	add	s2,s2,s3
ffffffffc020423a:	078e                	slli	a5,a5,0x3
ffffffffc020423c:	97ca                	add	a5,a5,s2
ffffffffc020423e:	ec3e                	sd	a5,24(sp)
ffffffffc0204240:	02f97c63          	bgeu	s2,a5,ffffffffc0204278 <do_execve+0x10a>
ffffffffc0204244:	5bfd                	li	s7,-1
ffffffffc0204246:	00cbd793          	srli	a5,s7,0xc
ffffffffc020424a:	00015d97          	auipc	s11,0x15
ffffffffc020424e:	3f6d8d93          	addi	s11,s11,1014 # ffffffffc0219640 <pages>
ffffffffc0204252:	00006d17          	auipc	s10,0x6
ffffffffc0204256:	3fed0d13          	addi	s10,s10,1022 # ffffffffc020a650 <nbase>
ffffffffc020425a:	e43e                	sd	a5,8(sp)
ffffffffc020425c:	00015c97          	auipc	s9,0x15
ffffffffc0204260:	294c8c93          	addi	s9,s9,660 # ffffffffc02194f0 <npage>
ffffffffc0204264:	00092703          	lw	a4,0(s2)
ffffffffc0204268:	4785                	li	a5,1
ffffffffc020426a:	12f70563          	beq	a4,a5,ffffffffc0204394 <do_execve+0x226>
ffffffffc020426e:	67e2                	ld	a5,24(sp)
ffffffffc0204270:	03890913          	addi	s2,s2,56
ffffffffc0204274:	fef968e3          	bltu	s2,a5,ffffffffc0204264 <do_execve+0xf6>
ffffffffc0204278:	4701                	li	a4,0
ffffffffc020427a:	46ad                	li	a3,11
ffffffffc020427c:	00100637          	lui	a2,0x100
ffffffffc0204280:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0204284:	8526                	mv	a0,s1
ffffffffc0204286:	c7dfc0ef          	jal	ra,ffffffffc0200f02 <mm_map>
ffffffffc020428a:	8a2a                	mv	s4,a0
ffffffffc020428c:	1e051063          	bnez	a0,ffffffffc020446c <do_execve+0x2fe>
ffffffffc0204290:	6c88                	ld	a0,24(s1)
ffffffffc0204292:	467d                	li	a2,31
ffffffffc0204294:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0204298:	d83fe0ef          	jal	ra,ffffffffc020301a <pgdir_alloc_page>
ffffffffc020429c:	42050e63          	beqz	a0,ffffffffc02046d8 <do_execve+0x56a>
ffffffffc02042a0:	6c88                	ld	a0,24(s1)
ffffffffc02042a2:	467d                	li	a2,31
ffffffffc02042a4:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc02042a8:	d73fe0ef          	jal	ra,ffffffffc020301a <pgdir_alloc_page>
ffffffffc02042ac:	40050663          	beqz	a0,ffffffffc02046b8 <do_execve+0x54a>
ffffffffc02042b0:	6c88                	ld	a0,24(s1)
ffffffffc02042b2:	467d                	li	a2,31
ffffffffc02042b4:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc02042b8:	d63fe0ef          	jal	ra,ffffffffc020301a <pgdir_alloc_page>
ffffffffc02042bc:	3c050e63          	beqz	a0,ffffffffc0204698 <do_execve+0x52a>
ffffffffc02042c0:	6c88                	ld	a0,24(s1)
ffffffffc02042c2:	467d                	li	a2,31
ffffffffc02042c4:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc02042c8:	d53fe0ef          	jal	ra,ffffffffc020301a <pgdir_alloc_page>
ffffffffc02042cc:	3a050663          	beqz	a0,ffffffffc0204678 <do_execve+0x50a>
ffffffffc02042d0:	589c                	lw	a5,48(s1)
ffffffffc02042d2:	000ab603          	ld	a2,0(s5)
ffffffffc02042d6:	6c94                	ld	a3,24(s1)
ffffffffc02042d8:	2785                	addiw	a5,a5,1
ffffffffc02042da:	d89c                	sw	a5,48(s1)
ffffffffc02042dc:	f604                	sd	s1,40(a2)
ffffffffc02042de:	c02007b7          	lui	a5,0xc0200
ffffffffc02042e2:	36f6ef63          	bltu	a3,a5,ffffffffc0204660 <do_execve+0x4f2>
ffffffffc02042e6:	00015797          	auipc	a5,0x15
ffffffffc02042ea:	34a7b783          	ld	a5,842(a5) # ffffffffc0219630 <va_pa_offset>
ffffffffc02042ee:	8e9d                	sub	a3,a3,a5
ffffffffc02042f0:	577d                	li	a4,-1
ffffffffc02042f2:	00c6d793          	srli	a5,a3,0xc
ffffffffc02042f6:	177e                	slli	a4,a4,0x3f
ffffffffc02042f8:	f654                	sd	a3,168(a2)
ffffffffc02042fa:	8fd9                	or	a5,a5,a4
ffffffffc02042fc:	18079073          	csrw	satp,a5
ffffffffc0204300:	7240                	ld	s0,160(a2)
ffffffffc0204302:	4581                	li	a1,0
ffffffffc0204304:	12000613          	li	a2,288
ffffffffc0204308:	8522                	mv	a0,s0
ffffffffc020430a:	10043483          	ld	s1,256(s0)
ffffffffc020430e:	019030ef          	jal	ra,ffffffffc0207b26 <memset>
ffffffffc0204312:	0189b703          	ld	a4,24(s3)
ffffffffc0204316:	4785                	li	a5,1
ffffffffc0204318:	000ab503          	ld	a0,0(s5)
ffffffffc020431c:	edf4f493          	andi	s1,s1,-289
ffffffffc0204320:	07fe                	slli	a5,a5,0x1f
ffffffffc0204322:	e81c                	sd	a5,16(s0)
ffffffffc0204324:	10e43423          	sd	a4,264(s0)
ffffffffc0204328:	10943023          	sd	s1,256(s0)
ffffffffc020432c:	100c                	addi	a1,sp,32
ffffffffc020432e:	ce8ff0ef          	jal	ra,ffffffffc0203816 <set_proc_name>
ffffffffc0204332:	60ea                	ld	ra,152(sp)
ffffffffc0204334:	644a                	ld	s0,144(sp)
ffffffffc0204336:	64aa                	ld	s1,136(sp)
ffffffffc0204338:	690a                	ld	s2,128(sp)
ffffffffc020433a:	79e6                	ld	s3,120(sp)
ffffffffc020433c:	7aa6                	ld	s5,104(sp)
ffffffffc020433e:	7b06                	ld	s6,96(sp)
ffffffffc0204340:	6be6                	ld	s7,88(sp)
ffffffffc0204342:	6c46                	ld	s8,80(sp)
ffffffffc0204344:	6ca6                	ld	s9,72(sp)
ffffffffc0204346:	6d06                	ld	s10,64(sp)
ffffffffc0204348:	7de2                	ld	s11,56(sp)
ffffffffc020434a:	8552                	mv	a0,s4
ffffffffc020434c:	7a46                	ld	s4,112(sp)
ffffffffc020434e:	610d                	addi	sp,sp,160
ffffffffc0204350:	8082                	ret
ffffffffc0204352:	463d                	li	a2,15
ffffffffc0204354:	85ca                	mv	a1,s2
ffffffffc0204356:	1008                	addi	a0,sp,32
ffffffffc0204358:	7e0030ef          	jal	ra,ffffffffc0207b38 <memcpy>
ffffffffc020435c:	e60a19e3          	bnez	s4,ffffffffc02041ce <do_execve+0x60>
ffffffffc0204360:	000ab783          	ld	a5,0(s5)
ffffffffc0204364:	779c                	ld	a5,40(a5)
ffffffffc0204366:	ea0780e3          	beqz	a5,ffffffffc0204206 <do_execve+0x98>
ffffffffc020436a:	00005617          	auipc	a2,0x5
ffffffffc020436e:	3c660613          	addi	a2,a2,966 # ffffffffc0209730 <default_pmm_manager+0x508>
ffffffffc0204372:	20300593          	li	a1,515
ffffffffc0204376:	00005517          	auipc	a0,0x5
ffffffffc020437a:	23a50513          	addi	a0,a0,570 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc020437e:	e8bfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204382:	8526                	mv	a0,s1
ffffffffc0204384:	b2dfc0ef          	jal	ra,ffffffffc0200eb0 <mm_destroy>
ffffffffc0204388:	5a71                	li	s4,-4
ffffffffc020438a:	8552                	mv	a0,s4
ffffffffc020438c:	99bff0ef          	jal	ra,ffffffffc0203d26 <do_exit>
ffffffffc0204390:	5a71                	li	s4,-4
ffffffffc0204392:	bfe5                	j	ffffffffc020438a <do_execve+0x21c>
ffffffffc0204394:	02893603          	ld	a2,40(s2)
ffffffffc0204398:	02093783          	ld	a5,32(s2)
ffffffffc020439c:	26f66c63          	bltu	a2,a5,ffffffffc0204614 <do_execve+0x4a6>
ffffffffc02043a0:	00492783          	lw	a5,4(s2)
ffffffffc02043a4:	0017f693          	andi	a3,a5,1
ffffffffc02043a8:	c291                	beqz	a3,ffffffffc02043ac <do_execve+0x23e>
ffffffffc02043aa:	4691                	li	a3,4
ffffffffc02043ac:	0027f713          	andi	a4,a5,2
ffffffffc02043b0:	8b91                	andi	a5,a5,4
ffffffffc02043b2:	14071c63          	bnez	a4,ffffffffc020450a <do_execve+0x39c>
ffffffffc02043b6:	4745                	li	a4,17
ffffffffc02043b8:	e03a                	sd	a4,0(sp)
ffffffffc02043ba:	c789                	beqz	a5,ffffffffc02043c4 <do_execve+0x256>
ffffffffc02043bc:	47cd                	li	a5,19
ffffffffc02043be:	0016e693          	ori	a3,a3,1
ffffffffc02043c2:	e03e                	sd	a5,0(sp)
ffffffffc02043c4:	0026f793          	andi	a5,a3,2
ffffffffc02043c8:	14079563          	bnez	a5,ffffffffc0204512 <do_execve+0x3a4>
ffffffffc02043cc:	0046f793          	andi	a5,a3,4
ffffffffc02043d0:	c789                	beqz	a5,ffffffffc02043da <do_execve+0x26c>
ffffffffc02043d2:	6782                	ld	a5,0(sp)
ffffffffc02043d4:	0087e793          	ori	a5,a5,8
ffffffffc02043d8:	e03e                	sd	a5,0(sp)
ffffffffc02043da:	01093583          	ld	a1,16(s2)
ffffffffc02043de:	4701                	li	a4,0
ffffffffc02043e0:	8526                	mv	a0,s1
ffffffffc02043e2:	b21fc0ef          	jal	ra,ffffffffc0200f02 <mm_map>
ffffffffc02043e6:	8a2a                	mv	s4,a0
ffffffffc02043e8:	e151                	bnez	a0,ffffffffc020446c <do_execve+0x2fe>
ffffffffc02043ea:	01093c03          	ld	s8,16(s2)
ffffffffc02043ee:	02093a03          	ld	s4,32(s2)
ffffffffc02043f2:	00893b03          	ld	s6,8(s2)
ffffffffc02043f6:	77fd                	lui	a5,0xfffff
ffffffffc02043f8:	9a62                	add	s4,s4,s8
ffffffffc02043fa:	9b4e                	add	s6,s6,s3
ffffffffc02043fc:	00fc7bb3          	and	s7,s8,a5
ffffffffc0204400:	054c6e63          	bltu	s8,s4,ffffffffc020445c <do_execve+0x2ee>
ffffffffc0204404:	a431                	j	ffffffffc0204610 <do_execve+0x4a2>
ffffffffc0204406:	6785                	lui	a5,0x1
ffffffffc0204408:	417c0533          	sub	a0,s8,s7
ffffffffc020440c:	9bbe                	add	s7,s7,a5
ffffffffc020440e:	418b8633          	sub	a2,s7,s8
ffffffffc0204412:	017a7463          	bgeu	s4,s7,ffffffffc020441a <do_execve+0x2ac>
ffffffffc0204416:	418a0633          	sub	a2,s4,s8
ffffffffc020441a:	000db683          	ld	a3,0(s11)
ffffffffc020441e:	000d3803          	ld	a6,0(s10)
ffffffffc0204422:	67a2                	ld	a5,8(sp)
ffffffffc0204424:	40d406b3          	sub	a3,s0,a3
ffffffffc0204428:	8699                	srai	a3,a3,0x6
ffffffffc020442a:	000cb583          	ld	a1,0(s9)
ffffffffc020442e:	96c2                	add	a3,a3,a6
ffffffffc0204430:	00f6f833          	and	a6,a3,a5
ffffffffc0204434:	06b2                	slli	a3,a3,0xc
ffffffffc0204436:	1eb87163          	bgeu	a6,a1,ffffffffc0204618 <do_execve+0x4aa>
ffffffffc020443a:	00015797          	auipc	a5,0x15
ffffffffc020443e:	1f678793          	addi	a5,a5,502 # ffffffffc0219630 <va_pa_offset>
ffffffffc0204442:	0007b803          	ld	a6,0(a5)
ffffffffc0204446:	85da                	mv	a1,s6
ffffffffc0204448:	9c32                	add	s8,s8,a2
ffffffffc020444a:	96c2                	add	a3,a3,a6
ffffffffc020444c:	9536                	add	a0,a0,a3
ffffffffc020444e:	e832                	sd	a2,16(sp)
ffffffffc0204450:	6e8030ef          	jal	ra,ffffffffc0207b38 <memcpy>
ffffffffc0204454:	6642                	ld	a2,16(sp)
ffffffffc0204456:	9b32                	add	s6,s6,a2
ffffffffc0204458:	0d4c7063          	bgeu	s8,s4,ffffffffc0204518 <do_execve+0x3aa>
ffffffffc020445c:	6c88                	ld	a0,24(s1)
ffffffffc020445e:	6602                	ld	a2,0(sp)
ffffffffc0204460:	85de                	mv	a1,s7
ffffffffc0204462:	bb9fe0ef          	jal	ra,ffffffffc020301a <pgdir_alloc_page>
ffffffffc0204466:	842a                	mv	s0,a0
ffffffffc0204468:	fd59                	bnez	a0,ffffffffc0204406 <do_execve+0x298>
ffffffffc020446a:	5a71                	li	s4,-4
ffffffffc020446c:	8526                	mv	a0,s1
ffffffffc020446e:	bdffc0ef          	jal	ra,ffffffffc020104c <exit_mmap>
ffffffffc0204472:	a011                	j	ffffffffc0204476 <do_execve+0x308>
ffffffffc0204474:	5a61                	li	s4,-8
ffffffffc0204476:	6c94                	ld	a3,24(s1)
ffffffffc0204478:	c02007b7          	lui	a5,0xc0200
ffffffffc020447c:	1af6ea63          	bltu	a3,a5,ffffffffc0204630 <do_execve+0x4c2>
ffffffffc0204480:	00015517          	auipc	a0,0x15
ffffffffc0204484:	1b053503          	ld	a0,432(a0) # ffffffffc0219630 <va_pa_offset>
ffffffffc0204488:	8e89                	sub	a3,a3,a0
ffffffffc020448a:	82b1                	srli	a3,a3,0xc
ffffffffc020448c:	00015797          	auipc	a5,0x15
ffffffffc0204490:	0647b783          	ld	a5,100(a5) # ffffffffc02194f0 <npage>
ffffffffc0204494:	1af6fa63          	bgeu	a3,a5,ffffffffc0204648 <do_execve+0x4da>
ffffffffc0204498:	00006517          	auipc	a0,0x6
ffffffffc020449c:	1b853503          	ld	a0,440(a0) # ffffffffc020a650 <nbase>
ffffffffc02044a0:	8e89                	sub	a3,a3,a0
ffffffffc02044a2:	069a                	slli	a3,a3,0x6
ffffffffc02044a4:	00015517          	auipc	a0,0x15
ffffffffc02044a8:	19c53503          	ld	a0,412(a0) # ffffffffc0219640 <pages>
ffffffffc02044ac:	9536                	add	a0,a0,a3
ffffffffc02044ae:	4585                	li	a1,1
ffffffffc02044b0:	ac0fe0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc02044b4:	8526                	mv	a0,s1
ffffffffc02044b6:	9fbfc0ef          	jal	ra,ffffffffc0200eb0 <mm_destroy>
ffffffffc02044ba:	bdc1                	j	ffffffffc020438a <do_execve+0x21c>
ffffffffc02044bc:	8552                	mv	a0,s4
ffffffffc02044be:	b8ffc0ef          	jal	ra,ffffffffc020104c <exit_mmap>
ffffffffc02044c2:	018a3683          	ld	a3,24(s4)
ffffffffc02044c6:	c02007b7          	lui	a5,0xc0200
ffffffffc02044ca:	16f6e363          	bltu	a3,a5,ffffffffc0204630 <do_execve+0x4c2>
ffffffffc02044ce:	00015797          	auipc	a5,0x15
ffffffffc02044d2:	1627b783          	ld	a5,354(a5) # ffffffffc0219630 <va_pa_offset>
ffffffffc02044d6:	8e9d                	sub	a3,a3,a5
ffffffffc02044d8:	82b1                	srli	a3,a3,0xc
ffffffffc02044da:	00015797          	auipc	a5,0x15
ffffffffc02044de:	0167b783          	ld	a5,22(a5) # ffffffffc02194f0 <npage>
ffffffffc02044e2:	16f6f363          	bgeu	a3,a5,ffffffffc0204648 <do_execve+0x4da>
ffffffffc02044e6:	00006517          	auipc	a0,0x6
ffffffffc02044ea:	16a53503          	ld	a0,362(a0) # ffffffffc020a650 <nbase>
ffffffffc02044ee:	8e89                	sub	a3,a3,a0
ffffffffc02044f0:	069a                	slli	a3,a3,0x6
ffffffffc02044f2:	00015517          	auipc	a0,0x15
ffffffffc02044f6:	14e53503          	ld	a0,334(a0) # ffffffffc0219640 <pages>
ffffffffc02044fa:	9536                	add	a0,a0,a3
ffffffffc02044fc:	4585                	li	a1,1
ffffffffc02044fe:	a72fe0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0204502:	8552                	mv	a0,s4
ffffffffc0204504:	9adfc0ef          	jal	ra,ffffffffc0200eb0 <mm_destroy>
ffffffffc0204508:	b9dd                	j	ffffffffc02041fe <do_execve+0x90>
ffffffffc020450a:	0026e693          	ori	a3,a3,2
ffffffffc020450e:	ea0797e3          	bnez	a5,ffffffffc02043bc <do_execve+0x24e>
ffffffffc0204512:	47dd                	li	a5,23
ffffffffc0204514:	e03e                	sd	a5,0(sp)
ffffffffc0204516:	bd5d                	j	ffffffffc02043cc <do_execve+0x25e>
ffffffffc0204518:	01093a03          	ld	s4,16(s2)
ffffffffc020451c:	02893683          	ld	a3,40(s2)
ffffffffc0204520:	9a36                	add	s4,s4,a3
ffffffffc0204522:	077c7f63          	bgeu	s8,s7,ffffffffc02045a0 <do_execve+0x432>
ffffffffc0204526:	d58a04e3          	beq	s4,s8,ffffffffc020426e <do_execve+0x100>
ffffffffc020452a:	6505                	lui	a0,0x1
ffffffffc020452c:	9562                	add	a0,a0,s8
ffffffffc020452e:	41750533          	sub	a0,a0,s7
ffffffffc0204532:	418a0b33          	sub	s6,s4,s8
ffffffffc0204536:	0d7a7863          	bgeu	s4,s7,ffffffffc0204606 <do_execve+0x498>
ffffffffc020453a:	000db683          	ld	a3,0(s11)
ffffffffc020453e:	000d3583          	ld	a1,0(s10)
ffffffffc0204542:	67a2                	ld	a5,8(sp)
ffffffffc0204544:	40d406b3          	sub	a3,s0,a3
ffffffffc0204548:	8699                	srai	a3,a3,0x6
ffffffffc020454a:	000cb603          	ld	a2,0(s9)
ffffffffc020454e:	96ae                	add	a3,a3,a1
ffffffffc0204550:	00f6f5b3          	and	a1,a3,a5
ffffffffc0204554:	06b2                	slli	a3,a3,0xc
ffffffffc0204556:	0cc5f163          	bgeu	a1,a2,ffffffffc0204618 <do_execve+0x4aa>
ffffffffc020455a:	00015617          	auipc	a2,0x15
ffffffffc020455e:	0d663603          	ld	a2,214(a2) # ffffffffc0219630 <va_pa_offset>
ffffffffc0204562:	96b2                	add	a3,a3,a2
ffffffffc0204564:	4581                	li	a1,0
ffffffffc0204566:	865a                	mv	a2,s6
ffffffffc0204568:	9536                	add	a0,a0,a3
ffffffffc020456a:	5bc030ef          	jal	ra,ffffffffc0207b26 <memset>
ffffffffc020456e:	018b0733          	add	a4,s6,s8
ffffffffc0204572:	037a7463          	bgeu	s4,s7,ffffffffc020459a <do_execve+0x42c>
ffffffffc0204576:	ceea0ce3          	beq	s4,a4,ffffffffc020426e <do_execve+0x100>
ffffffffc020457a:	00005697          	auipc	a3,0x5
ffffffffc020457e:	1de68693          	addi	a3,a3,478 # ffffffffc0209758 <default_pmm_manager+0x530>
ffffffffc0204582:	00004617          	auipc	a2,0x4
ffffffffc0204586:	08660613          	addi	a2,a2,134 # ffffffffc0208608 <commands+0x410>
ffffffffc020458a:	25800593          	li	a1,600
ffffffffc020458e:	00005517          	auipc	a0,0x5
ffffffffc0204592:	02250513          	addi	a0,a0,34 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc0204596:	c73fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020459a:	ff7710e3          	bne	a4,s7,ffffffffc020457a <do_execve+0x40c>
ffffffffc020459e:	8c5e                	mv	s8,s7
ffffffffc02045a0:	00015b17          	auipc	s6,0x15
ffffffffc02045a4:	090b0b13          	addi	s6,s6,144 # ffffffffc0219630 <va_pa_offset>
ffffffffc02045a8:	054c6763          	bltu	s8,s4,ffffffffc02045f6 <do_execve+0x488>
ffffffffc02045ac:	b1c9                	j	ffffffffc020426e <do_execve+0x100>
ffffffffc02045ae:	6785                	lui	a5,0x1
ffffffffc02045b0:	417c0533          	sub	a0,s8,s7
ffffffffc02045b4:	9bbe                	add	s7,s7,a5
ffffffffc02045b6:	418b8633          	sub	a2,s7,s8
ffffffffc02045ba:	017a7463          	bgeu	s4,s7,ffffffffc02045c2 <do_execve+0x454>
ffffffffc02045be:	418a0633          	sub	a2,s4,s8
ffffffffc02045c2:	000db683          	ld	a3,0(s11)
ffffffffc02045c6:	000d3803          	ld	a6,0(s10)
ffffffffc02045ca:	67a2                	ld	a5,8(sp)
ffffffffc02045cc:	40d406b3          	sub	a3,s0,a3
ffffffffc02045d0:	8699                	srai	a3,a3,0x6
ffffffffc02045d2:	000cb583          	ld	a1,0(s9)
ffffffffc02045d6:	96c2                	add	a3,a3,a6
ffffffffc02045d8:	00f6f833          	and	a6,a3,a5
ffffffffc02045dc:	06b2                	slli	a3,a3,0xc
ffffffffc02045de:	02b87d63          	bgeu	a6,a1,ffffffffc0204618 <do_execve+0x4aa>
ffffffffc02045e2:	000b3803          	ld	a6,0(s6)
ffffffffc02045e6:	9c32                	add	s8,s8,a2
ffffffffc02045e8:	4581                	li	a1,0
ffffffffc02045ea:	96c2                	add	a3,a3,a6
ffffffffc02045ec:	9536                	add	a0,a0,a3
ffffffffc02045ee:	538030ef          	jal	ra,ffffffffc0207b26 <memset>
ffffffffc02045f2:	c74c7ee3          	bgeu	s8,s4,ffffffffc020426e <do_execve+0x100>
ffffffffc02045f6:	6c88                	ld	a0,24(s1)
ffffffffc02045f8:	6602                	ld	a2,0(sp)
ffffffffc02045fa:	85de                	mv	a1,s7
ffffffffc02045fc:	a1ffe0ef          	jal	ra,ffffffffc020301a <pgdir_alloc_page>
ffffffffc0204600:	842a                	mv	s0,a0
ffffffffc0204602:	f555                	bnez	a0,ffffffffc02045ae <do_execve+0x440>
ffffffffc0204604:	b59d                	j	ffffffffc020446a <do_execve+0x2fc>
ffffffffc0204606:	418b8b33          	sub	s6,s7,s8
ffffffffc020460a:	bf05                	j	ffffffffc020453a <do_execve+0x3cc>
ffffffffc020460c:	5a75                	li	s4,-3
ffffffffc020460e:	b315                	j	ffffffffc0204332 <do_execve+0x1c4>
ffffffffc0204610:	8a62                	mv	s4,s8
ffffffffc0204612:	b729                	j	ffffffffc020451c <do_execve+0x3ae>
ffffffffc0204614:	5a61                	li	s4,-8
ffffffffc0204616:	bd99                	j	ffffffffc020446c <do_execve+0x2fe>
ffffffffc0204618:	00004617          	auipc	a2,0x4
ffffffffc020461c:	67860613          	addi	a2,a2,1656 # ffffffffc0208c90 <commands+0xa98>
ffffffffc0204620:	06900593          	li	a1,105
ffffffffc0204624:	00004517          	auipc	a0,0x4
ffffffffc0204628:	69450513          	addi	a0,a0,1684 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc020462c:	bddfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204630:	00004617          	auipc	a2,0x4
ffffffffc0204634:	6d060613          	addi	a2,a2,1744 # ffffffffc0208d00 <commands+0xb08>
ffffffffc0204638:	06e00593          	li	a1,110
ffffffffc020463c:	00004517          	auipc	a0,0x4
ffffffffc0204640:	67c50513          	addi	a0,a0,1660 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc0204644:	bc5fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204648:	00004617          	auipc	a2,0x4
ffffffffc020464c:	6e060613          	addi	a2,a2,1760 # ffffffffc0208d28 <commands+0xb30>
ffffffffc0204650:	06200593          	li	a1,98
ffffffffc0204654:	00004517          	auipc	a0,0x4
ffffffffc0204658:	66450513          	addi	a0,a0,1636 # ffffffffc0208cb8 <commands+0xac0>
ffffffffc020465c:	badfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204660:	00004617          	auipc	a2,0x4
ffffffffc0204664:	6a060613          	addi	a2,a2,1696 # ffffffffc0208d00 <commands+0xb08>
ffffffffc0204668:	27300593          	li	a1,627
ffffffffc020466c:	00005517          	auipc	a0,0x5
ffffffffc0204670:	f4450513          	addi	a0,a0,-188 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc0204674:	b95fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204678:	00005697          	auipc	a3,0x5
ffffffffc020467c:	1f868693          	addi	a3,a3,504 # ffffffffc0209870 <default_pmm_manager+0x648>
ffffffffc0204680:	00004617          	auipc	a2,0x4
ffffffffc0204684:	f8860613          	addi	a2,a2,-120 # ffffffffc0208608 <commands+0x410>
ffffffffc0204688:	26e00593          	li	a1,622
ffffffffc020468c:	00005517          	auipc	a0,0x5
ffffffffc0204690:	f2450513          	addi	a0,a0,-220 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc0204694:	b75fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204698:	00005697          	auipc	a3,0x5
ffffffffc020469c:	19068693          	addi	a3,a3,400 # ffffffffc0209828 <default_pmm_manager+0x600>
ffffffffc02046a0:	00004617          	auipc	a2,0x4
ffffffffc02046a4:	f6860613          	addi	a2,a2,-152 # ffffffffc0208608 <commands+0x410>
ffffffffc02046a8:	26d00593          	li	a1,621
ffffffffc02046ac:	00005517          	auipc	a0,0x5
ffffffffc02046b0:	f0450513          	addi	a0,a0,-252 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc02046b4:	b55fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02046b8:	00005697          	auipc	a3,0x5
ffffffffc02046bc:	12868693          	addi	a3,a3,296 # ffffffffc02097e0 <default_pmm_manager+0x5b8>
ffffffffc02046c0:	00004617          	auipc	a2,0x4
ffffffffc02046c4:	f4860613          	addi	a2,a2,-184 # ffffffffc0208608 <commands+0x410>
ffffffffc02046c8:	26c00593          	li	a1,620
ffffffffc02046cc:	00005517          	auipc	a0,0x5
ffffffffc02046d0:	ee450513          	addi	a0,a0,-284 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc02046d4:	b35fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02046d8:	00005697          	auipc	a3,0x5
ffffffffc02046dc:	0c068693          	addi	a3,a3,192 # ffffffffc0209798 <default_pmm_manager+0x570>
ffffffffc02046e0:	00004617          	auipc	a2,0x4
ffffffffc02046e4:	f2860613          	addi	a2,a2,-216 # ffffffffc0208608 <commands+0x410>
ffffffffc02046e8:	26b00593          	li	a1,619
ffffffffc02046ec:	00005517          	auipc	a0,0x5
ffffffffc02046f0:	ec450513          	addi	a0,a0,-316 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc02046f4:	b15fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02046f8 <do_yield>:
ffffffffc02046f8:	00015797          	auipc	a5,0x15
ffffffffc02046fc:	e007b783          	ld	a5,-512(a5) # ffffffffc02194f8 <current>
ffffffffc0204700:	4705                	li	a4,1
ffffffffc0204702:	ef98                	sd	a4,24(a5)
ffffffffc0204704:	4501                	li	a0,0
ffffffffc0204706:	8082                	ret

ffffffffc0204708 <do_wait>:
ffffffffc0204708:	1101                	addi	sp,sp,-32
ffffffffc020470a:	e822                	sd	s0,16(sp)
ffffffffc020470c:	e426                	sd	s1,8(sp)
ffffffffc020470e:	ec06                	sd	ra,24(sp)
ffffffffc0204710:	842e                	mv	s0,a1
ffffffffc0204712:	84aa                	mv	s1,a0
ffffffffc0204714:	c999                	beqz	a1,ffffffffc020472a <do_wait+0x22>
ffffffffc0204716:	00015797          	auipc	a5,0x15
ffffffffc020471a:	de27b783          	ld	a5,-542(a5) # ffffffffc02194f8 <current>
ffffffffc020471e:	7788                	ld	a0,40(a5)
ffffffffc0204720:	4685                	li	a3,1
ffffffffc0204722:	4611                	li	a2,4
ffffffffc0204724:	aa3fc0ef          	jal	ra,ffffffffc02011c6 <user_mem_check>
ffffffffc0204728:	c909                	beqz	a0,ffffffffc020473a <do_wait+0x32>
ffffffffc020472a:	85a2                	mv	a1,s0
ffffffffc020472c:	6442                	ld	s0,16(sp)
ffffffffc020472e:	60e2                	ld	ra,24(sp)
ffffffffc0204730:	8526                	mv	a0,s1
ffffffffc0204732:	64a2                	ld	s1,8(sp)
ffffffffc0204734:	6105                	addi	sp,sp,32
ffffffffc0204736:	fa6ff06f          	j	ffffffffc0203edc <do_wait.part.0>
ffffffffc020473a:	60e2                	ld	ra,24(sp)
ffffffffc020473c:	6442                	ld	s0,16(sp)
ffffffffc020473e:	64a2                	ld	s1,8(sp)
ffffffffc0204740:	5575                	li	a0,-3
ffffffffc0204742:	6105                	addi	sp,sp,32
ffffffffc0204744:	8082                	ret

ffffffffc0204746 <do_kill>:
ffffffffc0204746:	1141                	addi	sp,sp,-16
ffffffffc0204748:	e406                	sd	ra,8(sp)
ffffffffc020474a:	e022                	sd	s0,0(sp)
ffffffffc020474c:	960ff0ef          	jal	ra,ffffffffc02038ac <find_proc>
ffffffffc0204750:	cd0d                	beqz	a0,ffffffffc020478a <do_kill+0x44>
ffffffffc0204752:	0b052703          	lw	a4,176(a0)
ffffffffc0204756:	00177693          	andi	a3,a4,1
ffffffffc020475a:	e695                	bnez	a3,ffffffffc0204786 <do_kill+0x40>
ffffffffc020475c:	0ec52683          	lw	a3,236(a0)
ffffffffc0204760:	00176713          	ori	a4,a4,1
ffffffffc0204764:	0ae52823          	sw	a4,176(a0)
ffffffffc0204768:	4401                	li	s0,0
ffffffffc020476a:	0006c763          	bltz	a3,ffffffffc0204778 <do_kill+0x32>
ffffffffc020476e:	60a2                	ld	ra,8(sp)
ffffffffc0204770:	8522                	mv	a0,s0
ffffffffc0204772:	6402                	ld	s0,0(sp)
ffffffffc0204774:	0141                	addi	sp,sp,16
ffffffffc0204776:	8082                	ret
ffffffffc0204778:	276000ef          	jal	ra,ffffffffc02049ee <wakeup_proc>
ffffffffc020477c:	60a2                	ld	ra,8(sp)
ffffffffc020477e:	8522                	mv	a0,s0
ffffffffc0204780:	6402                	ld	s0,0(sp)
ffffffffc0204782:	0141                	addi	sp,sp,16
ffffffffc0204784:	8082                	ret
ffffffffc0204786:	545d                	li	s0,-9
ffffffffc0204788:	b7dd                	j	ffffffffc020476e <do_kill+0x28>
ffffffffc020478a:	5475                	li	s0,-3
ffffffffc020478c:	b7cd                	j	ffffffffc020476e <do_kill+0x28>

ffffffffc020478e <proc_init>:
ffffffffc020478e:	1101                	addi	sp,sp,-32
ffffffffc0204790:	00015797          	auipc	a5,0x15
ffffffffc0204794:	fa878793          	addi	a5,a5,-88 # ffffffffc0219738 <proc_list>
ffffffffc0204798:	ec06                	sd	ra,24(sp)
ffffffffc020479a:	e822                	sd	s0,16(sp)
ffffffffc020479c:	e426                	sd	s1,8(sp)
ffffffffc020479e:	e04a                	sd	s2,0(sp)
ffffffffc02047a0:	e79c                	sd	a5,8(a5)
ffffffffc02047a2:	e39c                	sd	a5,0(a5)
ffffffffc02047a4:	00015717          	auipc	a4,0x15
ffffffffc02047a8:	cec70713          	addi	a4,a4,-788 # ffffffffc0219490 <__rq>
ffffffffc02047ac:	00011797          	auipc	a5,0x11
ffffffffc02047b0:	ce478793          	addi	a5,a5,-796 # ffffffffc0215490 <hash_list>
ffffffffc02047b4:	e79c                	sd	a5,8(a5)
ffffffffc02047b6:	e39c                	sd	a5,0(a5)
ffffffffc02047b8:	07c1                	addi	a5,a5,16
ffffffffc02047ba:	fef71de3          	bne	a4,a5,ffffffffc02047b4 <proc_init+0x26>
ffffffffc02047be:	f57fe0ef          	jal	ra,ffffffffc0203714 <alloc_proc>
ffffffffc02047c2:	00015417          	auipc	s0,0x15
ffffffffc02047c6:	d3e40413          	addi	s0,s0,-706 # ffffffffc0219500 <idleproc>
ffffffffc02047ca:	e008                	sd	a0,0(s0)
ffffffffc02047cc:	c541                	beqz	a0,ffffffffc0204854 <proc_init+0xc6>
ffffffffc02047ce:	4709                	li	a4,2
ffffffffc02047d0:	e118                	sd	a4,0(a0)
ffffffffc02047d2:	4485                	li	s1,1
ffffffffc02047d4:	00007717          	auipc	a4,0x7
ffffffffc02047d8:	82c70713          	addi	a4,a4,-2004 # ffffffffc020b000 <bootstack>
ffffffffc02047dc:	00005597          	auipc	a1,0x5
ffffffffc02047e0:	0f458593          	addi	a1,a1,244 # ffffffffc02098d0 <default_pmm_manager+0x6a8>
ffffffffc02047e4:	e918                	sd	a4,16(a0)
ffffffffc02047e6:	ed04                	sd	s1,24(a0)
ffffffffc02047e8:	82eff0ef          	jal	ra,ffffffffc0203816 <set_proc_name>
ffffffffc02047ec:	00015717          	auipc	a4,0x15
ffffffffc02047f0:	d2470713          	addi	a4,a4,-732 # ffffffffc0219510 <nr_process>
ffffffffc02047f4:	431c                	lw	a5,0(a4)
ffffffffc02047f6:	6014                	ld	a3,0(s0)
ffffffffc02047f8:	4601                	li	a2,0
ffffffffc02047fa:	2785                	addiw	a5,a5,1
ffffffffc02047fc:	4581                	li	a1,0
ffffffffc02047fe:	00000517          	auipc	a0,0x0
ffffffffc0204802:	87450513          	addi	a0,a0,-1932 # ffffffffc0204072 <init_main>
ffffffffc0204806:	c31c                	sw	a5,0(a4)
ffffffffc0204808:	00015797          	auipc	a5,0x15
ffffffffc020480c:	ced7b823          	sd	a3,-784(a5) # ffffffffc02194f8 <current>
ffffffffc0204810:	cc6ff0ef          	jal	ra,ffffffffc0203cd6 <kernel_thread>
ffffffffc0204814:	08a05c63          	blez	a0,ffffffffc02048ac <proc_init+0x11e>
ffffffffc0204818:	894ff0ef          	jal	ra,ffffffffc02038ac <find_proc>
ffffffffc020481c:	00015917          	auipc	s2,0x15
ffffffffc0204820:	cec90913          	addi	s2,s2,-788 # ffffffffc0219508 <initproc>
ffffffffc0204824:	00005597          	auipc	a1,0x5
ffffffffc0204828:	0d458593          	addi	a1,a1,212 # ffffffffc02098f8 <default_pmm_manager+0x6d0>
ffffffffc020482c:	00a93023          	sd	a0,0(s2)
ffffffffc0204830:	fe7fe0ef          	jal	ra,ffffffffc0203816 <set_proc_name>
ffffffffc0204834:	601c                	ld	a5,0(s0)
ffffffffc0204836:	cbb9                	beqz	a5,ffffffffc020488c <proc_init+0xfe>
ffffffffc0204838:	43dc                	lw	a5,4(a5)
ffffffffc020483a:	eba9                	bnez	a5,ffffffffc020488c <proc_init+0xfe>
ffffffffc020483c:	00093783          	ld	a5,0(s2)
ffffffffc0204840:	c795                	beqz	a5,ffffffffc020486c <proc_init+0xde>
ffffffffc0204842:	43dc                	lw	a5,4(a5)
ffffffffc0204844:	02979463          	bne	a5,s1,ffffffffc020486c <proc_init+0xde>
ffffffffc0204848:	60e2                	ld	ra,24(sp)
ffffffffc020484a:	6442                	ld	s0,16(sp)
ffffffffc020484c:	64a2                	ld	s1,8(sp)
ffffffffc020484e:	6902                	ld	s2,0(sp)
ffffffffc0204850:	6105                	addi	sp,sp,32
ffffffffc0204852:	8082                	ret
ffffffffc0204854:	00005617          	auipc	a2,0x5
ffffffffc0204858:	06460613          	addi	a2,a2,100 # ffffffffc02098b8 <default_pmm_manager+0x690>
ffffffffc020485c:	37400593          	li	a1,884
ffffffffc0204860:	00005517          	auipc	a0,0x5
ffffffffc0204864:	d5050513          	addi	a0,a0,-688 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc0204868:	9a1fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020486c:	00005697          	auipc	a3,0x5
ffffffffc0204870:	0bc68693          	addi	a3,a3,188 # ffffffffc0209928 <default_pmm_manager+0x700>
ffffffffc0204874:	00004617          	auipc	a2,0x4
ffffffffc0204878:	d9460613          	addi	a2,a2,-620 # ffffffffc0208608 <commands+0x410>
ffffffffc020487c:	38900593          	li	a1,905
ffffffffc0204880:	00005517          	auipc	a0,0x5
ffffffffc0204884:	d3050513          	addi	a0,a0,-720 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc0204888:	981fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020488c:	00005697          	auipc	a3,0x5
ffffffffc0204890:	07468693          	addi	a3,a3,116 # ffffffffc0209900 <default_pmm_manager+0x6d8>
ffffffffc0204894:	00004617          	auipc	a2,0x4
ffffffffc0204898:	d7460613          	addi	a2,a2,-652 # ffffffffc0208608 <commands+0x410>
ffffffffc020489c:	38800593          	li	a1,904
ffffffffc02048a0:	00005517          	auipc	a0,0x5
ffffffffc02048a4:	d1050513          	addi	a0,a0,-752 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc02048a8:	961fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02048ac:	00005617          	auipc	a2,0x5
ffffffffc02048b0:	02c60613          	addi	a2,a2,44 # ffffffffc02098d8 <default_pmm_manager+0x6b0>
ffffffffc02048b4:	38200593          	li	a1,898
ffffffffc02048b8:	00005517          	auipc	a0,0x5
ffffffffc02048bc:	cf850513          	addi	a0,a0,-776 # ffffffffc02095b0 <default_pmm_manager+0x388>
ffffffffc02048c0:	949fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02048c4 <cpu_idle>:
ffffffffc02048c4:	1141                	addi	sp,sp,-16
ffffffffc02048c6:	e022                	sd	s0,0(sp)
ffffffffc02048c8:	e406                	sd	ra,8(sp)
ffffffffc02048ca:	00015417          	auipc	s0,0x15
ffffffffc02048ce:	c2e40413          	addi	s0,s0,-978 # ffffffffc02194f8 <current>
ffffffffc02048d2:	6018                	ld	a4,0(s0)
ffffffffc02048d4:	6f1c                	ld	a5,24(a4)
ffffffffc02048d6:	dffd                	beqz	a5,ffffffffc02048d4 <cpu_idle+0x10>
ffffffffc02048d8:	1c8000ef          	jal	ra,ffffffffc0204aa0 <schedule>
ffffffffc02048dc:	bfdd                	j	ffffffffc02048d2 <cpu_idle+0xe>

ffffffffc02048de <lab6_set_priority>:
ffffffffc02048de:	1141                	addi	sp,sp,-16
ffffffffc02048e0:	e022                	sd	s0,0(sp)
ffffffffc02048e2:	85aa                	mv	a1,a0
ffffffffc02048e4:	842a                	mv	s0,a0
ffffffffc02048e6:	00005517          	auipc	a0,0x5
ffffffffc02048ea:	06a50513          	addi	a0,a0,106 # ffffffffc0209950 <default_pmm_manager+0x728>
ffffffffc02048ee:	e406                	sd	ra,8(sp)
ffffffffc02048f0:	fdcfb0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02048f4:	00015797          	auipc	a5,0x15
ffffffffc02048f8:	c047b783          	ld	a5,-1020(a5) # ffffffffc02194f8 <current>
ffffffffc02048fc:	e801                	bnez	s0,ffffffffc020490c <lab6_set_priority+0x2e>
ffffffffc02048fe:	60a2                	ld	ra,8(sp)
ffffffffc0204900:	6402                	ld	s0,0(sp)
ffffffffc0204902:	4705                	li	a4,1
ffffffffc0204904:	14e7a223          	sw	a4,324(a5)
ffffffffc0204908:	0141                	addi	sp,sp,16
ffffffffc020490a:	8082                	ret
ffffffffc020490c:	60a2                	ld	ra,8(sp)
ffffffffc020490e:	1487a223          	sw	s0,324(a5)
ffffffffc0204912:	6402                	ld	s0,0(sp)
ffffffffc0204914:	0141                	addi	sp,sp,16
ffffffffc0204916:	8082                	ret

ffffffffc0204918 <do_sleep>:
ffffffffc0204918:	c539                	beqz	a0,ffffffffc0204966 <do_sleep+0x4e>
ffffffffc020491a:	7179                	addi	sp,sp,-48
ffffffffc020491c:	f022                	sd	s0,32(sp)
ffffffffc020491e:	f406                	sd	ra,40(sp)
ffffffffc0204920:	842a                	mv	s0,a0
ffffffffc0204922:	100027f3          	csrr	a5,sstatus
ffffffffc0204926:	8b89                	andi	a5,a5,2
ffffffffc0204928:	e3a9                	bnez	a5,ffffffffc020496a <do_sleep+0x52>
ffffffffc020492a:	00015797          	auipc	a5,0x15
ffffffffc020492e:	bce7b783          	ld	a5,-1074(a5) # ffffffffc02194f8 <current>
ffffffffc0204932:	0818                	addi	a4,sp,16
ffffffffc0204934:	c02a                	sw	a0,0(sp)
ffffffffc0204936:	ec3a                	sd	a4,24(sp)
ffffffffc0204938:	e83a                	sd	a4,16(sp)
ffffffffc020493a:	e43e                	sd	a5,8(sp)
ffffffffc020493c:	4705                	li	a4,1
ffffffffc020493e:	c398                	sw	a4,0(a5)
ffffffffc0204940:	80000737          	lui	a4,0x80000
ffffffffc0204944:	840a                	mv	s0,sp
ffffffffc0204946:	2709                	addiw	a4,a4,2
ffffffffc0204948:	0ee7a623          	sw	a4,236(a5)
ffffffffc020494c:	8522                	mv	a0,s0
ffffffffc020494e:	218000ef          	jal	ra,ffffffffc0204b66 <add_timer>
ffffffffc0204952:	14e000ef          	jal	ra,ffffffffc0204aa0 <schedule>
ffffffffc0204956:	8522                	mv	a0,s0
ffffffffc0204958:	2d6000ef          	jal	ra,ffffffffc0204c2e <del_timer>
ffffffffc020495c:	70a2                	ld	ra,40(sp)
ffffffffc020495e:	7402                	ld	s0,32(sp)
ffffffffc0204960:	4501                	li	a0,0
ffffffffc0204962:	6145                	addi	sp,sp,48
ffffffffc0204964:	8082                	ret
ffffffffc0204966:	4501                	li	a0,0
ffffffffc0204968:	8082                	ret
ffffffffc020496a:	ccffb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc020496e:	00015797          	auipc	a5,0x15
ffffffffc0204972:	b8a7b783          	ld	a5,-1142(a5) # ffffffffc02194f8 <current>
ffffffffc0204976:	0818                	addi	a4,sp,16
ffffffffc0204978:	c022                	sw	s0,0(sp)
ffffffffc020497a:	e43e                	sd	a5,8(sp)
ffffffffc020497c:	ec3a                	sd	a4,24(sp)
ffffffffc020497e:	e83a                	sd	a4,16(sp)
ffffffffc0204980:	4705                	li	a4,1
ffffffffc0204982:	c398                	sw	a4,0(a5)
ffffffffc0204984:	80000737          	lui	a4,0x80000
ffffffffc0204988:	2709                	addiw	a4,a4,2
ffffffffc020498a:	840a                	mv	s0,sp
ffffffffc020498c:	8522                	mv	a0,s0
ffffffffc020498e:	0ee7a623          	sw	a4,236(a5)
ffffffffc0204992:	1d4000ef          	jal	ra,ffffffffc0204b66 <add_timer>
ffffffffc0204996:	c9dfb0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020499a:	bf65                	j	ffffffffc0204952 <do_sleep+0x3a>

ffffffffc020499c <sched_init>:
ffffffffc020499c:	1141                	addi	sp,sp,-16
ffffffffc020499e:	00009717          	auipc	a4,0x9
ffffffffc02049a2:	6b270713          	addi	a4,a4,1714 # ffffffffc020e050 <default_sched_class>
ffffffffc02049a6:	e022                	sd	s0,0(sp)
ffffffffc02049a8:	e406                	sd	ra,8(sp)
ffffffffc02049aa:	00015797          	auipc	a5,0x15
ffffffffc02049ae:	b0678793          	addi	a5,a5,-1274 # ffffffffc02194b0 <timer_list>
ffffffffc02049b2:	6714                	ld	a3,8(a4)
ffffffffc02049b4:	00015517          	auipc	a0,0x15
ffffffffc02049b8:	adc50513          	addi	a0,a0,-1316 # ffffffffc0219490 <__rq>
ffffffffc02049bc:	e79c                	sd	a5,8(a5)
ffffffffc02049be:	e39c                	sd	a5,0(a5)
ffffffffc02049c0:	4795                	li	a5,5
ffffffffc02049c2:	c95c                	sw	a5,20(a0)
ffffffffc02049c4:	00015417          	auipc	s0,0x15
ffffffffc02049c8:	b5c40413          	addi	s0,s0,-1188 # ffffffffc0219520 <sched_class>
ffffffffc02049cc:	00015797          	auipc	a5,0x15
ffffffffc02049d0:	b4a7b623          	sd	a0,-1204(a5) # ffffffffc0219518 <rq>
ffffffffc02049d4:	e018                	sd	a4,0(s0)
ffffffffc02049d6:	9682                	jalr	a3
ffffffffc02049d8:	601c                	ld	a5,0(s0)
ffffffffc02049da:	6402                	ld	s0,0(sp)
ffffffffc02049dc:	60a2                	ld	ra,8(sp)
ffffffffc02049de:	638c                	ld	a1,0(a5)
ffffffffc02049e0:	00005517          	auipc	a0,0x5
ffffffffc02049e4:	f8850513          	addi	a0,a0,-120 # ffffffffc0209968 <default_pmm_manager+0x740>
ffffffffc02049e8:	0141                	addi	sp,sp,16
ffffffffc02049ea:	ee2fb06f          	j	ffffffffc02000cc <cprintf>

ffffffffc02049ee <wakeup_proc>:
ffffffffc02049ee:	4118                	lw	a4,0(a0)
ffffffffc02049f0:	1101                	addi	sp,sp,-32
ffffffffc02049f2:	ec06                	sd	ra,24(sp)
ffffffffc02049f4:	e822                	sd	s0,16(sp)
ffffffffc02049f6:	e426                	sd	s1,8(sp)
ffffffffc02049f8:	478d                	li	a5,3
ffffffffc02049fa:	08f70363          	beq	a4,a5,ffffffffc0204a80 <wakeup_proc+0x92>
ffffffffc02049fe:	842a                	mv	s0,a0
ffffffffc0204a00:	100027f3          	csrr	a5,sstatus
ffffffffc0204a04:	8b89                	andi	a5,a5,2
ffffffffc0204a06:	4481                	li	s1,0
ffffffffc0204a08:	e7bd                	bnez	a5,ffffffffc0204a76 <wakeup_proc+0x88>
ffffffffc0204a0a:	4789                	li	a5,2
ffffffffc0204a0c:	04f70863          	beq	a4,a5,ffffffffc0204a5c <wakeup_proc+0x6e>
ffffffffc0204a10:	c01c                	sw	a5,0(s0)
ffffffffc0204a12:	0e042623          	sw	zero,236(s0)
ffffffffc0204a16:	00015797          	auipc	a5,0x15
ffffffffc0204a1a:	ae27b783          	ld	a5,-1310(a5) # ffffffffc02194f8 <current>
ffffffffc0204a1e:	02878363          	beq	a5,s0,ffffffffc0204a44 <wakeup_proc+0x56>
ffffffffc0204a22:	00015797          	auipc	a5,0x15
ffffffffc0204a26:	ade7b783          	ld	a5,-1314(a5) # ffffffffc0219500 <idleproc>
ffffffffc0204a2a:	00f40d63          	beq	s0,a5,ffffffffc0204a44 <wakeup_proc+0x56>
ffffffffc0204a2e:	00015797          	auipc	a5,0x15
ffffffffc0204a32:	af27b783          	ld	a5,-1294(a5) # ffffffffc0219520 <sched_class>
ffffffffc0204a36:	6b9c                	ld	a5,16(a5)
ffffffffc0204a38:	85a2                	mv	a1,s0
ffffffffc0204a3a:	00015517          	auipc	a0,0x15
ffffffffc0204a3e:	ade53503          	ld	a0,-1314(a0) # ffffffffc0219518 <rq>
ffffffffc0204a42:	9782                	jalr	a5
ffffffffc0204a44:	e491                	bnez	s1,ffffffffc0204a50 <wakeup_proc+0x62>
ffffffffc0204a46:	60e2                	ld	ra,24(sp)
ffffffffc0204a48:	6442                	ld	s0,16(sp)
ffffffffc0204a4a:	64a2                	ld	s1,8(sp)
ffffffffc0204a4c:	6105                	addi	sp,sp,32
ffffffffc0204a4e:	8082                	ret
ffffffffc0204a50:	6442                	ld	s0,16(sp)
ffffffffc0204a52:	60e2                	ld	ra,24(sp)
ffffffffc0204a54:	64a2                	ld	s1,8(sp)
ffffffffc0204a56:	6105                	addi	sp,sp,32
ffffffffc0204a58:	bdbfb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204a5c:	00005617          	auipc	a2,0x5
ffffffffc0204a60:	f5c60613          	addi	a2,a2,-164 # ffffffffc02099b8 <default_pmm_manager+0x790>
ffffffffc0204a64:	04800593          	li	a1,72
ffffffffc0204a68:	00005517          	auipc	a0,0x5
ffffffffc0204a6c:	f3850513          	addi	a0,a0,-200 # ffffffffc02099a0 <default_pmm_manager+0x778>
ffffffffc0204a70:	801fb0ef          	jal	ra,ffffffffc0200270 <__warn>
ffffffffc0204a74:	bfc1                	j	ffffffffc0204a44 <wakeup_proc+0x56>
ffffffffc0204a76:	bc3fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204a7a:	4018                	lw	a4,0(s0)
ffffffffc0204a7c:	4485                	li	s1,1
ffffffffc0204a7e:	b771                	j	ffffffffc0204a0a <wakeup_proc+0x1c>
ffffffffc0204a80:	00005697          	auipc	a3,0x5
ffffffffc0204a84:	f0068693          	addi	a3,a3,-256 # ffffffffc0209980 <default_pmm_manager+0x758>
ffffffffc0204a88:	00004617          	auipc	a2,0x4
ffffffffc0204a8c:	b8060613          	addi	a2,a2,-1152 # ffffffffc0208608 <commands+0x410>
ffffffffc0204a90:	03c00593          	li	a1,60
ffffffffc0204a94:	00005517          	auipc	a0,0x5
ffffffffc0204a98:	f0c50513          	addi	a0,a0,-244 # ffffffffc02099a0 <default_pmm_manager+0x778>
ffffffffc0204a9c:	f6cfb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204aa0 <schedule>:
ffffffffc0204aa0:	7179                	addi	sp,sp,-48
ffffffffc0204aa2:	f406                	sd	ra,40(sp)
ffffffffc0204aa4:	f022                	sd	s0,32(sp)
ffffffffc0204aa6:	ec26                	sd	s1,24(sp)
ffffffffc0204aa8:	e84a                	sd	s2,16(sp)
ffffffffc0204aaa:	e44e                	sd	s3,8(sp)
ffffffffc0204aac:	e052                	sd	s4,0(sp)
ffffffffc0204aae:	100027f3          	csrr	a5,sstatus
ffffffffc0204ab2:	8b89                	andi	a5,a5,2
ffffffffc0204ab4:	4a01                	li	s4,0
ffffffffc0204ab6:	e7c5                	bnez	a5,ffffffffc0204b5e <schedule+0xbe>
ffffffffc0204ab8:	00015497          	auipc	s1,0x15
ffffffffc0204abc:	a4048493          	addi	s1,s1,-1472 # ffffffffc02194f8 <current>
ffffffffc0204ac0:	608c                	ld	a1,0(s1)
ffffffffc0204ac2:	00015997          	auipc	s3,0x15
ffffffffc0204ac6:	a5e98993          	addi	s3,s3,-1442 # ffffffffc0219520 <sched_class>
ffffffffc0204aca:	00015917          	auipc	s2,0x15
ffffffffc0204ace:	a4e90913          	addi	s2,s2,-1458 # ffffffffc0219518 <rq>
ffffffffc0204ad2:	4194                	lw	a3,0(a1)
ffffffffc0204ad4:	0005bc23          	sd	zero,24(a1)
ffffffffc0204ad8:	4709                	li	a4,2
ffffffffc0204ada:	0009b783          	ld	a5,0(s3)
ffffffffc0204ade:	00093503          	ld	a0,0(s2)
ffffffffc0204ae2:	04e68063          	beq	a3,a4,ffffffffc0204b22 <schedule+0x82>
ffffffffc0204ae6:	739c                	ld	a5,32(a5)
ffffffffc0204ae8:	9782                	jalr	a5
ffffffffc0204aea:	842a                	mv	s0,a0
ffffffffc0204aec:	c939                	beqz	a0,ffffffffc0204b42 <schedule+0xa2>
ffffffffc0204aee:	0009b783          	ld	a5,0(s3)
ffffffffc0204af2:	00093503          	ld	a0,0(s2)
ffffffffc0204af6:	85a2                	mv	a1,s0
ffffffffc0204af8:	6f9c                	ld	a5,24(a5)
ffffffffc0204afa:	9782                	jalr	a5
ffffffffc0204afc:	441c                	lw	a5,8(s0)
ffffffffc0204afe:	6098                	ld	a4,0(s1)
ffffffffc0204b00:	2785                	addiw	a5,a5,1
ffffffffc0204b02:	c41c                	sw	a5,8(s0)
ffffffffc0204b04:	00870563          	beq	a4,s0,ffffffffc0204b0e <schedule+0x6e>
ffffffffc0204b08:	8522                	mv	a0,s0
ffffffffc0204b0a:	d37fe0ef          	jal	ra,ffffffffc0203840 <proc_run>
ffffffffc0204b0e:	020a1f63          	bnez	s4,ffffffffc0204b4c <schedule+0xac>
ffffffffc0204b12:	70a2                	ld	ra,40(sp)
ffffffffc0204b14:	7402                	ld	s0,32(sp)
ffffffffc0204b16:	64e2                	ld	s1,24(sp)
ffffffffc0204b18:	6942                	ld	s2,16(sp)
ffffffffc0204b1a:	69a2                	ld	s3,8(sp)
ffffffffc0204b1c:	6a02                	ld	s4,0(sp)
ffffffffc0204b1e:	6145                	addi	sp,sp,48
ffffffffc0204b20:	8082                	ret
ffffffffc0204b22:	00015717          	auipc	a4,0x15
ffffffffc0204b26:	9de73703          	ld	a4,-1570(a4) # ffffffffc0219500 <idleproc>
ffffffffc0204b2a:	fae58ee3          	beq	a1,a4,ffffffffc0204ae6 <schedule+0x46>
ffffffffc0204b2e:	6b9c                	ld	a5,16(a5)
ffffffffc0204b30:	9782                	jalr	a5
ffffffffc0204b32:	0009b783          	ld	a5,0(s3)
ffffffffc0204b36:	00093503          	ld	a0,0(s2)
ffffffffc0204b3a:	739c                	ld	a5,32(a5)
ffffffffc0204b3c:	9782                	jalr	a5
ffffffffc0204b3e:	842a                	mv	s0,a0
ffffffffc0204b40:	f55d                	bnez	a0,ffffffffc0204aee <schedule+0x4e>
ffffffffc0204b42:	00015417          	auipc	s0,0x15
ffffffffc0204b46:	9be43403          	ld	s0,-1602(s0) # ffffffffc0219500 <idleproc>
ffffffffc0204b4a:	bf4d                	j	ffffffffc0204afc <schedule+0x5c>
ffffffffc0204b4c:	7402                	ld	s0,32(sp)
ffffffffc0204b4e:	70a2                	ld	ra,40(sp)
ffffffffc0204b50:	64e2                	ld	s1,24(sp)
ffffffffc0204b52:	6942                	ld	s2,16(sp)
ffffffffc0204b54:	69a2                	ld	s3,8(sp)
ffffffffc0204b56:	6a02                	ld	s4,0(sp)
ffffffffc0204b58:	6145                	addi	sp,sp,48
ffffffffc0204b5a:	ad9fb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204b5e:	adbfb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204b62:	4a05                	li	s4,1
ffffffffc0204b64:	bf91                	j	ffffffffc0204ab8 <schedule+0x18>

ffffffffc0204b66 <add_timer>:
ffffffffc0204b66:	1141                	addi	sp,sp,-16
ffffffffc0204b68:	e022                	sd	s0,0(sp)
ffffffffc0204b6a:	e406                	sd	ra,8(sp)
ffffffffc0204b6c:	842a                	mv	s0,a0
ffffffffc0204b6e:	100027f3          	csrr	a5,sstatus
ffffffffc0204b72:	8b89                	andi	a5,a5,2
ffffffffc0204b74:	4501                	li	a0,0
ffffffffc0204b76:	eba5                	bnez	a5,ffffffffc0204be6 <add_timer+0x80>
ffffffffc0204b78:	401c                	lw	a5,0(s0)
ffffffffc0204b7a:	cbb5                	beqz	a5,ffffffffc0204bee <add_timer+0x88>
ffffffffc0204b7c:	6418                	ld	a4,8(s0)
ffffffffc0204b7e:	cb25                	beqz	a4,ffffffffc0204bee <add_timer+0x88>
ffffffffc0204b80:	6c18                	ld	a4,24(s0)
ffffffffc0204b82:	01040593          	addi	a1,s0,16
ffffffffc0204b86:	08e59463          	bne	a1,a4,ffffffffc0204c0e <add_timer+0xa8>
ffffffffc0204b8a:	00015617          	auipc	a2,0x15
ffffffffc0204b8e:	92660613          	addi	a2,a2,-1754 # ffffffffc02194b0 <timer_list>
ffffffffc0204b92:	6618                	ld	a4,8(a2)
ffffffffc0204b94:	00c71863          	bne	a4,a2,ffffffffc0204ba4 <add_timer+0x3e>
ffffffffc0204b98:	a80d                	j	ffffffffc0204bca <add_timer+0x64>
ffffffffc0204b9a:	6718                	ld	a4,8(a4)
ffffffffc0204b9c:	9f95                	subw	a5,a5,a3
ffffffffc0204b9e:	c01c                	sw	a5,0(s0)
ffffffffc0204ba0:	02c70563          	beq	a4,a2,ffffffffc0204bca <add_timer+0x64>
ffffffffc0204ba4:	ff072683          	lw	a3,-16(a4)
ffffffffc0204ba8:	fed7f9e3          	bgeu	a5,a3,ffffffffc0204b9a <add_timer+0x34>
ffffffffc0204bac:	40f687bb          	subw	a5,a3,a5
ffffffffc0204bb0:	fef72823          	sw	a5,-16(a4)
ffffffffc0204bb4:	631c                	ld	a5,0(a4)
ffffffffc0204bb6:	e30c                	sd	a1,0(a4)
ffffffffc0204bb8:	e78c                	sd	a1,8(a5)
ffffffffc0204bba:	ec18                	sd	a4,24(s0)
ffffffffc0204bbc:	e81c                	sd	a5,16(s0)
ffffffffc0204bbe:	c105                	beqz	a0,ffffffffc0204bde <add_timer+0x78>
ffffffffc0204bc0:	6402                	ld	s0,0(sp)
ffffffffc0204bc2:	60a2                	ld	ra,8(sp)
ffffffffc0204bc4:	0141                	addi	sp,sp,16
ffffffffc0204bc6:	a6dfb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204bca:	00015717          	auipc	a4,0x15
ffffffffc0204bce:	8e670713          	addi	a4,a4,-1818 # ffffffffc02194b0 <timer_list>
ffffffffc0204bd2:	631c                	ld	a5,0(a4)
ffffffffc0204bd4:	e30c                	sd	a1,0(a4)
ffffffffc0204bd6:	e78c                	sd	a1,8(a5)
ffffffffc0204bd8:	ec18                	sd	a4,24(s0)
ffffffffc0204bda:	e81c                	sd	a5,16(s0)
ffffffffc0204bdc:	f175                	bnez	a0,ffffffffc0204bc0 <add_timer+0x5a>
ffffffffc0204bde:	60a2                	ld	ra,8(sp)
ffffffffc0204be0:	6402                	ld	s0,0(sp)
ffffffffc0204be2:	0141                	addi	sp,sp,16
ffffffffc0204be4:	8082                	ret
ffffffffc0204be6:	a53fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204bea:	4505                	li	a0,1
ffffffffc0204bec:	b771                	j	ffffffffc0204b78 <add_timer+0x12>
ffffffffc0204bee:	00005697          	auipc	a3,0x5
ffffffffc0204bf2:	dea68693          	addi	a3,a3,-534 # ffffffffc02099d8 <default_pmm_manager+0x7b0>
ffffffffc0204bf6:	00004617          	auipc	a2,0x4
ffffffffc0204bfa:	a1260613          	addi	a2,a2,-1518 # ffffffffc0208608 <commands+0x410>
ffffffffc0204bfe:	06c00593          	li	a1,108
ffffffffc0204c02:	00005517          	auipc	a0,0x5
ffffffffc0204c06:	d9e50513          	addi	a0,a0,-610 # ffffffffc02099a0 <default_pmm_manager+0x778>
ffffffffc0204c0a:	dfefb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204c0e:	00005697          	auipc	a3,0x5
ffffffffc0204c12:	dfa68693          	addi	a3,a3,-518 # ffffffffc0209a08 <default_pmm_manager+0x7e0>
ffffffffc0204c16:	00004617          	auipc	a2,0x4
ffffffffc0204c1a:	9f260613          	addi	a2,a2,-1550 # ffffffffc0208608 <commands+0x410>
ffffffffc0204c1e:	06d00593          	li	a1,109
ffffffffc0204c22:	00005517          	auipc	a0,0x5
ffffffffc0204c26:	d7e50513          	addi	a0,a0,-642 # ffffffffc02099a0 <default_pmm_manager+0x778>
ffffffffc0204c2a:	ddefb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204c2e <del_timer>:
ffffffffc0204c2e:	1101                	addi	sp,sp,-32
ffffffffc0204c30:	e822                	sd	s0,16(sp)
ffffffffc0204c32:	ec06                	sd	ra,24(sp)
ffffffffc0204c34:	e426                	sd	s1,8(sp)
ffffffffc0204c36:	842a                	mv	s0,a0
ffffffffc0204c38:	100027f3          	csrr	a5,sstatus
ffffffffc0204c3c:	8b89                	andi	a5,a5,2
ffffffffc0204c3e:	01050493          	addi	s1,a0,16
ffffffffc0204c42:	eb9d                	bnez	a5,ffffffffc0204c78 <del_timer+0x4a>
ffffffffc0204c44:	6d1c                	ld	a5,24(a0)
ffffffffc0204c46:	02978463          	beq	a5,s1,ffffffffc0204c6e <del_timer+0x40>
ffffffffc0204c4a:	4114                	lw	a3,0(a0)
ffffffffc0204c4c:	6918                	ld	a4,16(a0)
ffffffffc0204c4e:	ce81                	beqz	a3,ffffffffc0204c66 <del_timer+0x38>
ffffffffc0204c50:	00015617          	auipc	a2,0x15
ffffffffc0204c54:	86060613          	addi	a2,a2,-1952 # ffffffffc02194b0 <timer_list>
ffffffffc0204c58:	00c78763          	beq	a5,a2,ffffffffc0204c66 <del_timer+0x38>
ffffffffc0204c5c:	ff07a603          	lw	a2,-16(a5)
ffffffffc0204c60:	9eb1                	addw	a3,a3,a2
ffffffffc0204c62:	fed7a823          	sw	a3,-16(a5)
ffffffffc0204c66:	e71c                	sd	a5,8(a4)
ffffffffc0204c68:	e398                	sd	a4,0(a5)
ffffffffc0204c6a:	ec04                	sd	s1,24(s0)
ffffffffc0204c6c:	e804                	sd	s1,16(s0)
ffffffffc0204c6e:	60e2                	ld	ra,24(sp)
ffffffffc0204c70:	6442                	ld	s0,16(sp)
ffffffffc0204c72:	64a2                	ld	s1,8(sp)
ffffffffc0204c74:	6105                	addi	sp,sp,32
ffffffffc0204c76:	8082                	ret
ffffffffc0204c78:	9c1fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204c7c:	6c1c                	ld	a5,24(s0)
ffffffffc0204c7e:	02978463          	beq	a5,s1,ffffffffc0204ca6 <del_timer+0x78>
ffffffffc0204c82:	4014                	lw	a3,0(s0)
ffffffffc0204c84:	6818                	ld	a4,16(s0)
ffffffffc0204c86:	ce81                	beqz	a3,ffffffffc0204c9e <del_timer+0x70>
ffffffffc0204c88:	00015617          	auipc	a2,0x15
ffffffffc0204c8c:	82860613          	addi	a2,a2,-2008 # ffffffffc02194b0 <timer_list>
ffffffffc0204c90:	00c78763          	beq	a5,a2,ffffffffc0204c9e <del_timer+0x70>
ffffffffc0204c94:	ff07a603          	lw	a2,-16(a5)
ffffffffc0204c98:	9eb1                	addw	a3,a3,a2
ffffffffc0204c9a:	fed7a823          	sw	a3,-16(a5)
ffffffffc0204c9e:	e71c                	sd	a5,8(a4)
ffffffffc0204ca0:	e398                	sd	a4,0(a5)
ffffffffc0204ca2:	ec04                	sd	s1,24(s0)
ffffffffc0204ca4:	e804                	sd	s1,16(s0)
ffffffffc0204ca6:	6442                	ld	s0,16(sp)
ffffffffc0204ca8:	60e2                	ld	ra,24(sp)
ffffffffc0204caa:	64a2                	ld	s1,8(sp)
ffffffffc0204cac:	6105                	addi	sp,sp,32
ffffffffc0204cae:	985fb06f          	j	ffffffffc0200632 <intr_enable>

ffffffffc0204cb2 <run_timer_list>:
ffffffffc0204cb2:	7139                	addi	sp,sp,-64
ffffffffc0204cb4:	fc06                	sd	ra,56(sp)
ffffffffc0204cb6:	f822                	sd	s0,48(sp)
ffffffffc0204cb8:	f426                	sd	s1,40(sp)
ffffffffc0204cba:	f04a                	sd	s2,32(sp)
ffffffffc0204cbc:	ec4e                	sd	s3,24(sp)
ffffffffc0204cbe:	e852                	sd	s4,16(sp)
ffffffffc0204cc0:	e456                	sd	s5,8(sp)
ffffffffc0204cc2:	e05a                	sd	s6,0(sp)
ffffffffc0204cc4:	100027f3          	csrr	a5,sstatus
ffffffffc0204cc8:	8b89                	andi	a5,a5,2
ffffffffc0204cca:	4b01                	li	s6,0
ffffffffc0204ccc:	eff9                	bnez	a5,ffffffffc0204daa <run_timer_list+0xf8>
ffffffffc0204cce:	00014997          	auipc	s3,0x14
ffffffffc0204cd2:	7e298993          	addi	s3,s3,2018 # ffffffffc02194b0 <timer_list>
ffffffffc0204cd6:	0089b403          	ld	s0,8(s3)
ffffffffc0204cda:	07340a63          	beq	s0,s3,ffffffffc0204d4e <run_timer_list+0x9c>
ffffffffc0204cde:	ff042783          	lw	a5,-16(s0)
ffffffffc0204ce2:	ff040913          	addi	s2,s0,-16
ffffffffc0204ce6:	0e078663          	beqz	a5,ffffffffc0204dd2 <run_timer_list+0x120>
ffffffffc0204cea:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204cee:	fee42823          	sw	a4,-16(s0)
ffffffffc0204cf2:	ef31                	bnez	a4,ffffffffc0204d4e <run_timer_list+0x9c>
ffffffffc0204cf4:	00005a97          	auipc	s5,0x5
ffffffffc0204cf8:	d7ca8a93          	addi	s5,s5,-644 # ffffffffc0209a70 <default_pmm_manager+0x848>
ffffffffc0204cfc:	00005a17          	auipc	s4,0x5
ffffffffc0204d00:	ca4a0a13          	addi	s4,s4,-860 # ffffffffc02099a0 <default_pmm_manager+0x778>
ffffffffc0204d04:	a005                	j	ffffffffc0204d24 <run_timer_list+0x72>
ffffffffc0204d06:	0a07d663          	bgez	a5,ffffffffc0204db2 <run_timer_list+0x100>
ffffffffc0204d0a:	8526                	mv	a0,s1
ffffffffc0204d0c:	ce3ff0ef          	jal	ra,ffffffffc02049ee <wakeup_proc>
ffffffffc0204d10:	854a                	mv	a0,s2
ffffffffc0204d12:	f1dff0ef          	jal	ra,ffffffffc0204c2e <del_timer>
ffffffffc0204d16:	03340c63          	beq	s0,s3,ffffffffc0204d4e <run_timer_list+0x9c>
ffffffffc0204d1a:	ff042783          	lw	a5,-16(s0)
ffffffffc0204d1e:	ff040913          	addi	s2,s0,-16
ffffffffc0204d22:	e795                	bnez	a5,ffffffffc0204d4e <run_timer_list+0x9c>
ffffffffc0204d24:	00893483          	ld	s1,8(s2)
ffffffffc0204d28:	6400                	ld	s0,8(s0)
ffffffffc0204d2a:	0ec4a783          	lw	a5,236(s1)
ffffffffc0204d2e:	ffe1                	bnez	a5,ffffffffc0204d06 <run_timer_list+0x54>
ffffffffc0204d30:	40d4                	lw	a3,4(s1)
ffffffffc0204d32:	8656                	mv	a2,s5
ffffffffc0204d34:	0a300593          	li	a1,163
ffffffffc0204d38:	8552                	mv	a0,s4
ffffffffc0204d3a:	d36fb0ef          	jal	ra,ffffffffc0200270 <__warn>
ffffffffc0204d3e:	8526                	mv	a0,s1
ffffffffc0204d40:	cafff0ef          	jal	ra,ffffffffc02049ee <wakeup_proc>
ffffffffc0204d44:	854a                	mv	a0,s2
ffffffffc0204d46:	ee9ff0ef          	jal	ra,ffffffffc0204c2e <del_timer>
ffffffffc0204d4a:	fd3418e3          	bne	s0,s3,ffffffffc0204d1a <run_timer_list+0x68>
ffffffffc0204d4e:	00014597          	auipc	a1,0x14
ffffffffc0204d52:	7aa5b583          	ld	a1,1962(a1) # ffffffffc02194f8 <current>
ffffffffc0204d56:	00014797          	auipc	a5,0x14
ffffffffc0204d5a:	7aa7b783          	ld	a5,1962(a5) # ffffffffc0219500 <idleproc>
ffffffffc0204d5e:	04f58363          	beq	a1,a5,ffffffffc0204da4 <run_timer_list+0xf2>
ffffffffc0204d62:	00014797          	auipc	a5,0x14
ffffffffc0204d66:	7be7b783          	ld	a5,1982(a5) # ffffffffc0219520 <sched_class>
ffffffffc0204d6a:	779c                	ld	a5,40(a5)
ffffffffc0204d6c:	00014517          	auipc	a0,0x14
ffffffffc0204d70:	7ac53503          	ld	a0,1964(a0) # ffffffffc0219518 <rq>
ffffffffc0204d74:	9782                	jalr	a5
ffffffffc0204d76:	000b1c63          	bnez	s6,ffffffffc0204d8e <run_timer_list+0xdc>
ffffffffc0204d7a:	70e2                	ld	ra,56(sp)
ffffffffc0204d7c:	7442                	ld	s0,48(sp)
ffffffffc0204d7e:	74a2                	ld	s1,40(sp)
ffffffffc0204d80:	7902                	ld	s2,32(sp)
ffffffffc0204d82:	69e2                	ld	s3,24(sp)
ffffffffc0204d84:	6a42                	ld	s4,16(sp)
ffffffffc0204d86:	6aa2                	ld	s5,8(sp)
ffffffffc0204d88:	6b02                	ld	s6,0(sp)
ffffffffc0204d8a:	6121                	addi	sp,sp,64
ffffffffc0204d8c:	8082                	ret
ffffffffc0204d8e:	7442                	ld	s0,48(sp)
ffffffffc0204d90:	70e2                	ld	ra,56(sp)
ffffffffc0204d92:	74a2                	ld	s1,40(sp)
ffffffffc0204d94:	7902                	ld	s2,32(sp)
ffffffffc0204d96:	69e2                	ld	s3,24(sp)
ffffffffc0204d98:	6a42                	ld	s4,16(sp)
ffffffffc0204d9a:	6aa2                	ld	s5,8(sp)
ffffffffc0204d9c:	6b02                	ld	s6,0(sp)
ffffffffc0204d9e:	6121                	addi	sp,sp,64
ffffffffc0204da0:	893fb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204da4:	4785                	li	a5,1
ffffffffc0204da6:	ed9c                	sd	a5,24(a1)
ffffffffc0204da8:	b7f9                	j	ffffffffc0204d76 <run_timer_list+0xc4>
ffffffffc0204daa:	88ffb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204dae:	4b05                	li	s6,1
ffffffffc0204db0:	bf39                	j	ffffffffc0204cce <run_timer_list+0x1c>
ffffffffc0204db2:	00005697          	auipc	a3,0x5
ffffffffc0204db6:	c9668693          	addi	a3,a3,-874 # ffffffffc0209a48 <default_pmm_manager+0x820>
ffffffffc0204dba:	00004617          	auipc	a2,0x4
ffffffffc0204dbe:	84e60613          	addi	a2,a2,-1970 # ffffffffc0208608 <commands+0x410>
ffffffffc0204dc2:	0a000593          	li	a1,160
ffffffffc0204dc6:	00005517          	auipc	a0,0x5
ffffffffc0204dca:	bda50513          	addi	a0,a0,-1062 # ffffffffc02099a0 <default_pmm_manager+0x778>
ffffffffc0204dce:	c3afb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204dd2:	00005697          	auipc	a3,0x5
ffffffffc0204dd6:	c5e68693          	addi	a3,a3,-930 # ffffffffc0209a30 <default_pmm_manager+0x808>
ffffffffc0204dda:	00004617          	auipc	a2,0x4
ffffffffc0204dde:	82e60613          	addi	a2,a2,-2002 # ffffffffc0208608 <commands+0x410>
ffffffffc0204de2:	09a00593          	li	a1,154
ffffffffc0204de6:	00005517          	auipc	a0,0x5
ffffffffc0204dea:	bba50513          	addi	a0,a0,-1094 # ffffffffc02099a0 <default_pmm_manager+0x778>
ffffffffc0204dee:	c1afb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204df2 <proc_stride_comp_f>:
ffffffffc0204df2:	4d08                	lw	a0,24(a0)
ffffffffc0204df4:	4d9c                	lw	a5,24(a1)
ffffffffc0204df6:	9d1d                	subw	a0,a0,a5
ffffffffc0204df8:	00a04763          	bgtz	a0,ffffffffc0204e06 <proc_stride_comp_f+0x14>
ffffffffc0204dfc:	00a03533          	snez	a0,a0
ffffffffc0204e00:	40a00533          	neg	a0,a0
ffffffffc0204e04:	8082                	ret
ffffffffc0204e06:	4505                	li	a0,1
ffffffffc0204e08:	8082                	ret

ffffffffc0204e0a <stride_init>:
ffffffffc0204e0a:	e508                	sd	a0,8(a0)
ffffffffc0204e0c:	e108                	sd	a0,0(a0)
ffffffffc0204e0e:	00053c23          	sd	zero,24(a0)
ffffffffc0204e12:	00052823          	sw	zero,16(a0)
ffffffffc0204e16:	8082                	ret

ffffffffc0204e18 <stride_pick_next>:
ffffffffc0204e18:	6d1c                	ld	a5,24(a0)
ffffffffc0204e1a:	cf89                	beqz	a5,ffffffffc0204e34 <stride_pick_next+0x1c>
ffffffffc0204e1c:	4fd0                	lw	a2,28(a5)
ffffffffc0204e1e:	4f98                	lw	a4,24(a5)
ffffffffc0204e20:	ed878513          	addi	a0,a5,-296
ffffffffc0204e24:	400006b7          	lui	a3,0x40000
ffffffffc0204e28:	c219                	beqz	a2,ffffffffc0204e2e <stride_pick_next+0x16>
ffffffffc0204e2a:	02c6d6bb          	divuw	a3,a3,a2
ffffffffc0204e2e:	9f35                	addw	a4,a4,a3
ffffffffc0204e30:	cf98                	sw	a4,24(a5)
ffffffffc0204e32:	8082                	ret
ffffffffc0204e34:	4501                	li	a0,0
ffffffffc0204e36:	8082                	ret

ffffffffc0204e38 <stride_proc_tick>:
ffffffffc0204e38:	1205a783          	lw	a5,288(a1)
ffffffffc0204e3c:	00f05563          	blez	a5,ffffffffc0204e46 <stride_proc_tick+0xe>
ffffffffc0204e40:	37fd                	addiw	a5,a5,-1
ffffffffc0204e42:	12f5a023          	sw	a5,288(a1)
ffffffffc0204e46:	e399                	bnez	a5,ffffffffc0204e4c <stride_proc_tick+0x14>
ffffffffc0204e48:	4785                	li	a5,1
ffffffffc0204e4a:	ed9c                	sd	a5,24(a1)
ffffffffc0204e4c:	8082                	ret

ffffffffc0204e4e <skew_heap_merge.constprop.0>:
ffffffffc0204e4e:	1101                	addi	sp,sp,-32
ffffffffc0204e50:	e822                	sd	s0,16(sp)
ffffffffc0204e52:	ec06                	sd	ra,24(sp)
ffffffffc0204e54:	e426                	sd	s1,8(sp)
ffffffffc0204e56:	e04a                	sd	s2,0(sp)
ffffffffc0204e58:	842e                	mv	s0,a1
ffffffffc0204e5a:	c11d                	beqz	a0,ffffffffc0204e80 <skew_heap_merge.constprop.0+0x32>
ffffffffc0204e5c:	84aa                	mv	s1,a0
ffffffffc0204e5e:	c1b9                	beqz	a1,ffffffffc0204ea4 <skew_heap_merge.constprop.0+0x56>
ffffffffc0204e60:	f93ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0204e64:	57fd                	li	a5,-1
ffffffffc0204e66:	02f50463          	beq	a0,a5,ffffffffc0204e8e <skew_heap_merge.constprop.0+0x40>
ffffffffc0204e6a:	680c                	ld	a1,16(s0)
ffffffffc0204e6c:	00843903          	ld	s2,8(s0)
ffffffffc0204e70:	8526                	mv	a0,s1
ffffffffc0204e72:	fddff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0204e76:	e408                	sd	a0,8(s0)
ffffffffc0204e78:	01243823          	sd	s2,16(s0)
ffffffffc0204e7c:	c111                	beqz	a0,ffffffffc0204e80 <skew_heap_merge.constprop.0+0x32>
ffffffffc0204e7e:	e100                	sd	s0,0(a0)
ffffffffc0204e80:	60e2                	ld	ra,24(sp)
ffffffffc0204e82:	8522                	mv	a0,s0
ffffffffc0204e84:	6442                	ld	s0,16(sp)
ffffffffc0204e86:	64a2                	ld	s1,8(sp)
ffffffffc0204e88:	6902                	ld	s2,0(sp)
ffffffffc0204e8a:	6105                	addi	sp,sp,32
ffffffffc0204e8c:	8082                	ret
ffffffffc0204e8e:	6888                	ld	a0,16(s1)
ffffffffc0204e90:	0084b903          	ld	s2,8(s1)
ffffffffc0204e94:	85a2                	mv	a1,s0
ffffffffc0204e96:	fb9ff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0204e9a:	e488                	sd	a0,8(s1)
ffffffffc0204e9c:	0124b823          	sd	s2,16(s1)
ffffffffc0204ea0:	c111                	beqz	a0,ffffffffc0204ea4 <skew_heap_merge.constprop.0+0x56>
ffffffffc0204ea2:	e104                	sd	s1,0(a0)
ffffffffc0204ea4:	60e2                	ld	ra,24(sp)
ffffffffc0204ea6:	6442                	ld	s0,16(sp)
ffffffffc0204ea8:	6902                	ld	s2,0(sp)
ffffffffc0204eaa:	8526                	mv	a0,s1
ffffffffc0204eac:	64a2                	ld	s1,8(sp)
ffffffffc0204eae:	6105                	addi	sp,sp,32
ffffffffc0204eb0:	8082                	ret

ffffffffc0204eb2 <stride_enqueue>:
ffffffffc0204eb2:	7119                	addi	sp,sp,-128
ffffffffc0204eb4:	f4a6                	sd	s1,104(sp)
ffffffffc0204eb6:	6d04                	ld	s1,24(a0)
ffffffffc0204eb8:	f8a2                	sd	s0,112(sp)
ffffffffc0204eba:	f0ca                	sd	s2,96(sp)
ffffffffc0204ebc:	e8d2                	sd	s4,80(sp)
ffffffffc0204ebe:	fc86                	sd	ra,120(sp)
ffffffffc0204ec0:	ecce                	sd	s3,88(sp)
ffffffffc0204ec2:	e4d6                	sd	s5,72(sp)
ffffffffc0204ec4:	e0da                	sd	s6,64(sp)
ffffffffc0204ec6:	fc5e                	sd	s7,56(sp)
ffffffffc0204ec8:	f862                	sd	s8,48(sp)
ffffffffc0204eca:	f466                	sd	s9,40(sp)
ffffffffc0204ecc:	f06a                	sd	s10,32(sp)
ffffffffc0204ece:	ec6e                	sd	s11,24(sp)
ffffffffc0204ed0:	1205b423          	sd	zero,296(a1)
ffffffffc0204ed4:	1205bc23          	sd	zero,312(a1)
ffffffffc0204ed8:	1205b823          	sd	zero,304(a1)
ffffffffc0204edc:	8a2a                	mv	s4,a0
ffffffffc0204ede:	842e                	mv	s0,a1
ffffffffc0204ee0:	12858913          	addi	s2,a1,296
ffffffffc0204ee4:	cc89                	beqz	s1,ffffffffc0204efe <stride_enqueue+0x4c>
ffffffffc0204ee6:	85ca                	mv	a1,s2
ffffffffc0204ee8:	8526                	mv	a0,s1
ffffffffc0204eea:	f09ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0204eee:	57fd                	li	a5,-1
ffffffffc0204ef0:	89aa                	mv	s3,a0
ffffffffc0204ef2:	04f50763          	beq	a0,a5,ffffffffc0204f40 <stride_enqueue+0x8e>
ffffffffc0204ef6:	12943823          	sd	s1,304(s0)
ffffffffc0204efa:	0124b023          	sd	s2,0(s1)
ffffffffc0204efe:	12042783          	lw	a5,288(s0)
ffffffffc0204f02:	012a3c23          	sd	s2,24(s4)
ffffffffc0204f06:	014a2703          	lw	a4,20(s4)
ffffffffc0204f0a:	c399                	beqz	a5,ffffffffc0204f10 <stride_enqueue+0x5e>
ffffffffc0204f0c:	00f75463          	bge	a4,a5,ffffffffc0204f14 <stride_enqueue+0x62>
ffffffffc0204f10:	12e42023          	sw	a4,288(s0)
ffffffffc0204f14:	010a2783          	lw	a5,16(s4)
ffffffffc0204f18:	70e6                	ld	ra,120(sp)
ffffffffc0204f1a:	11443423          	sd	s4,264(s0)
ffffffffc0204f1e:	7446                	ld	s0,112(sp)
ffffffffc0204f20:	2785                	addiw	a5,a5,1
ffffffffc0204f22:	00fa2823          	sw	a5,16(s4)
ffffffffc0204f26:	74a6                	ld	s1,104(sp)
ffffffffc0204f28:	7906                	ld	s2,96(sp)
ffffffffc0204f2a:	69e6                	ld	s3,88(sp)
ffffffffc0204f2c:	6a46                	ld	s4,80(sp)
ffffffffc0204f2e:	6aa6                	ld	s5,72(sp)
ffffffffc0204f30:	6b06                	ld	s6,64(sp)
ffffffffc0204f32:	7be2                	ld	s7,56(sp)
ffffffffc0204f34:	7c42                	ld	s8,48(sp)
ffffffffc0204f36:	7ca2                	ld	s9,40(sp)
ffffffffc0204f38:	7d02                	ld	s10,32(sp)
ffffffffc0204f3a:	6de2                	ld	s11,24(sp)
ffffffffc0204f3c:	6109                	addi	sp,sp,128
ffffffffc0204f3e:	8082                	ret
ffffffffc0204f40:	0104ba83          	ld	s5,16(s1)
ffffffffc0204f44:	0084bb83          	ld	s7,8(s1)
ffffffffc0204f48:	000a8d63          	beqz	s5,ffffffffc0204f62 <stride_enqueue+0xb0>
ffffffffc0204f4c:	85ca                	mv	a1,s2
ffffffffc0204f4e:	8556                	mv	a0,s5
ffffffffc0204f50:	ea3ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0204f54:	8b2a                	mv	s6,a0
ffffffffc0204f56:	01350e63          	beq	a0,s3,ffffffffc0204f72 <stride_enqueue+0xc0>
ffffffffc0204f5a:	13543823          	sd	s5,304(s0)
ffffffffc0204f5e:	012ab023          	sd	s2,0(s5)
ffffffffc0204f62:	0124b423          	sd	s2,8(s1)
ffffffffc0204f66:	0174b823          	sd	s7,16(s1)
ffffffffc0204f6a:	00993023          	sd	s1,0(s2)
ffffffffc0204f6e:	8926                	mv	s2,s1
ffffffffc0204f70:	b779                	j	ffffffffc0204efe <stride_enqueue+0x4c>
ffffffffc0204f72:	010ab983          	ld	s3,16(s5)
ffffffffc0204f76:	008abc83          	ld	s9,8(s5)
ffffffffc0204f7a:	00098d63          	beqz	s3,ffffffffc0204f94 <stride_enqueue+0xe2>
ffffffffc0204f7e:	85ca                	mv	a1,s2
ffffffffc0204f80:	854e                	mv	a0,s3
ffffffffc0204f82:	e71ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0204f86:	8c2a                	mv	s8,a0
ffffffffc0204f88:	01650e63          	beq	a0,s6,ffffffffc0204fa4 <stride_enqueue+0xf2>
ffffffffc0204f8c:	13343823          	sd	s3,304(s0)
ffffffffc0204f90:	0129b023          	sd	s2,0(s3)
ffffffffc0204f94:	012ab423          	sd	s2,8(s5)
ffffffffc0204f98:	019ab823          	sd	s9,16(s5)
ffffffffc0204f9c:	01593023          	sd	s5,0(s2)
ffffffffc0204fa0:	8956                	mv	s2,s5
ffffffffc0204fa2:	b7c1                	j	ffffffffc0204f62 <stride_enqueue+0xb0>
ffffffffc0204fa4:	0109bb03          	ld	s6,16(s3)
ffffffffc0204fa8:	0089bd83          	ld	s11,8(s3)
ffffffffc0204fac:	000b0d63          	beqz	s6,ffffffffc0204fc6 <stride_enqueue+0x114>
ffffffffc0204fb0:	85ca                	mv	a1,s2
ffffffffc0204fb2:	855a                	mv	a0,s6
ffffffffc0204fb4:	e3fff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0204fb8:	8d2a                	mv	s10,a0
ffffffffc0204fba:	01850e63          	beq	a0,s8,ffffffffc0204fd6 <stride_enqueue+0x124>
ffffffffc0204fbe:	13643823          	sd	s6,304(s0)
ffffffffc0204fc2:	012b3023          	sd	s2,0(s6)
ffffffffc0204fc6:	0129b423          	sd	s2,8(s3)
ffffffffc0204fca:	01b9b823          	sd	s11,16(s3)
ffffffffc0204fce:	01393023          	sd	s3,0(s2)
ffffffffc0204fd2:	894e                	mv	s2,s3
ffffffffc0204fd4:	b7c1                	j	ffffffffc0204f94 <stride_enqueue+0xe2>
ffffffffc0204fd6:	008b3783          	ld	a5,8(s6)
ffffffffc0204fda:	010b3c03          	ld	s8,16(s6)
ffffffffc0204fde:	e43e                	sd	a5,8(sp)
ffffffffc0204fe0:	000c0c63          	beqz	s8,ffffffffc0204ff8 <stride_enqueue+0x146>
ffffffffc0204fe4:	85ca                	mv	a1,s2
ffffffffc0204fe6:	8562                	mv	a0,s8
ffffffffc0204fe8:	e0bff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0204fec:	01a50f63          	beq	a0,s10,ffffffffc020500a <stride_enqueue+0x158>
ffffffffc0204ff0:	13843823          	sd	s8,304(s0)
ffffffffc0204ff4:	012c3023          	sd	s2,0(s8)
ffffffffc0204ff8:	67a2                	ld	a5,8(sp)
ffffffffc0204ffa:	012b3423          	sd	s2,8(s6)
ffffffffc0204ffe:	00fb3823          	sd	a5,16(s6)
ffffffffc0205002:	01693023          	sd	s6,0(s2)
ffffffffc0205006:	895a                	mv	s2,s6
ffffffffc0205008:	bf7d                	j	ffffffffc0204fc6 <stride_enqueue+0x114>
ffffffffc020500a:	010c3503          	ld	a0,16(s8)
ffffffffc020500e:	008c3d03          	ld	s10,8(s8)
ffffffffc0205012:	85ca                	mv	a1,s2
ffffffffc0205014:	e3bff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205018:	00ac3423          	sd	a0,8(s8)
ffffffffc020501c:	01ac3823          	sd	s10,16(s8)
ffffffffc0205020:	c509                	beqz	a0,ffffffffc020502a <stride_enqueue+0x178>
ffffffffc0205022:	01853023          	sd	s8,0(a0)
ffffffffc0205026:	8962                	mv	s2,s8
ffffffffc0205028:	bfc1                	j	ffffffffc0204ff8 <stride_enqueue+0x146>
ffffffffc020502a:	8962                	mv	s2,s8
ffffffffc020502c:	b7f1                	j	ffffffffc0204ff8 <stride_enqueue+0x146>

ffffffffc020502e <stride_dequeue>:
ffffffffc020502e:	1085b783          	ld	a5,264(a1)
ffffffffc0205032:	7171                	addi	sp,sp,-176
ffffffffc0205034:	f506                	sd	ra,168(sp)
ffffffffc0205036:	f122                	sd	s0,160(sp)
ffffffffc0205038:	ed26                	sd	s1,152(sp)
ffffffffc020503a:	e94a                	sd	s2,144(sp)
ffffffffc020503c:	e54e                	sd	s3,136(sp)
ffffffffc020503e:	e152                	sd	s4,128(sp)
ffffffffc0205040:	fcd6                	sd	s5,120(sp)
ffffffffc0205042:	f8da                	sd	s6,112(sp)
ffffffffc0205044:	f4de                	sd	s7,104(sp)
ffffffffc0205046:	f0e2                	sd	s8,96(sp)
ffffffffc0205048:	ece6                	sd	s9,88(sp)
ffffffffc020504a:	e8ea                	sd	s10,80(sp)
ffffffffc020504c:	e4ee                	sd	s11,72(sp)
ffffffffc020504e:	00a78463          	beq	a5,a0,ffffffffc0205056 <stride_dequeue+0x28>
ffffffffc0205052:	7870106f          	j	ffffffffc0206fd8 <stride_dequeue+0x1faa>
ffffffffc0205056:	01052983          	lw	s3,16(a0)
ffffffffc020505a:	8c2a                	mv	s8,a0
ffffffffc020505c:	8b4e                	mv	s6,s3
ffffffffc020505e:	00099463          	bnez	s3,ffffffffc0205066 <stride_dequeue+0x38>
ffffffffc0205062:	7770106f          	j	ffffffffc0206fd8 <stride_dequeue+0x1faa>
ffffffffc0205066:	1305b903          	ld	s2,304(a1)
ffffffffc020506a:	01853a83          	ld	s5,24(a0)
ffffffffc020506e:	1285bd03          	ld	s10,296(a1)
ffffffffc0205072:	1385b483          	ld	s1,312(a1)
ffffffffc0205076:	842e                	mv	s0,a1
ffffffffc0205078:	2e090263          	beqz	s2,ffffffffc020535c <stride_dequeue+0x32e>
ffffffffc020507c:	42048263          	beqz	s1,ffffffffc02054a0 <stride_dequeue+0x472>
ffffffffc0205080:	85a6                	mv	a1,s1
ffffffffc0205082:	854a                	mv	a0,s2
ffffffffc0205084:	d6fff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205088:	5cfd                	li	s9,-1
ffffffffc020508a:	8a2a                	mv	s4,a0
ffffffffc020508c:	19950163          	beq	a0,s9,ffffffffc020520e <stride_dequeue+0x1e0>
ffffffffc0205090:	0104ba03          	ld	s4,16(s1)
ffffffffc0205094:	0084bb83          	ld	s7,8(s1)
ffffffffc0205098:	120a0563          	beqz	s4,ffffffffc02051c2 <stride_dequeue+0x194>
ffffffffc020509c:	85d2                	mv	a1,s4
ffffffffc020509e:	854a                	mv	a0,s2
ffffffffc02050a0:	d53ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02050a4:	2d950563          	beq	a0,s9,ffffffffc020536e <stride_dequeue+0x340>
ffffffffc02050a8:	008a3783          	ld	a5,8(s4)
ffffffffc02050ac:	010a3d83          	ld	s11,16(s4)
ffffffffc02050b0:	e03e                	sd	a5,0(sp)
ffffffffc02050b2:	100d8063          	beqz	s11,ffffffffc02051b2 <stride_dequeue+0x184>
ffffffffc02050b6:	85ee                	mv	a1,s11
ffffffffc02050b8:	854a                	mv	a0,s2
ffffffffc02050ba:	d39ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02050be:	7f950563          	beq	a0,s9,ffffffffc02058a8 <stride_dequeue+0x87a>
ffffffffc02050c2:	008db783          	ld	a5,8(s11)
ffffffffc02050c6:	010dbc83          	ld	s9,16(s11)
ffffffffc02050ca:	e43e                	sd	a5,8(sp)
ffffffffc02050cc:	0c0c8b63          	beqz	s9,ffffffffc02051a2 <stride_dequeue+0x174>
ffffffffc02050d0:	85e6                	mv	a1,s9
ffffffffc02050d2:	854a                	mv	a0,s2
ffffffffc02050d4:	d1fff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02050d8:	58fd                	li	a7,-1
ffffffffc02050da:	71150063          	beq	a0,a7,ffffffffc02057da <stride_dequeue+0x7ac>
ffffffffc02050de:	008cb783          	ld	a5,8(s9)
ffffffffc02050e2:	010cb803          	ld	a6,16(s9)
ffffffffc02050e6:	e83e                	sd	a5,16(sp)
ffffffffc02050e8:	0a080563          	beqz	a6,ffffffffc0205192 <stride_dequeue+0x164>
ffffffffc02050ec:	85c2                	mv	a1,a6
ffffffffc02050ee:	854a                	mv	a0,s2
ffffffffc02050f0:	ec42                	sd	a6,24(sp)
ffffffffc02050f2:	d01ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02050f6:	58fd                	li	a7,-1
ffffffffc02050f8:	6862                	ld	a6,24(sp)
ffffffffc02050fa:	41150be3          	beq	a0,a7,ffffffffc0205d10 <stride_dequeue+0xce2>
ffffffffc02050fe:	00883703          	ld	a4,8(a6) # fffffffffff80008 <end+0x3fd668c0>
ffffffffc0205102:	01083783          	ld	a5,16(a6)
ffffffffc0205106:	ec3a                	sd	a4,24(sp)
ffffffffc0205108:	cfad                	beqz	a5,ffffffffc0205182 <stride_dequeue+0x154>
ffffffffc020510a:	85be                	mv	a1,a5
ffffffffc020510c:	854a                	mv	a0,s2
ffffffffc020510e:	f442                	sd	a6,40(sp)
ffffffffc0205110:	f03e                	sd	a5,32(sp)
ffffffffc0205112:	ce1ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205116:	58fd                	li	a7,-1
ffffffffc0205118:	7782                	ld	a5,32(sp)
ffffffffc020511a:	7822                	ld	a6,40(sp)
ffffffffc020511c:	01151463          	bne	a0,a7,ffffffffc0205124 <stride_dequeue+0xf6>
ffffffffc0205120:	17a0106f          	j	ffffffffc020629a <stride_dequeue+0x126c>
ffffffffc0205124:	6798                	ld	a4,8(a5)
ffffffffc0205126:	0107bb03          	ld	s6,16(a5)
ffffffffc020512a:	f03a                	sd	a4,32(sp)
ffffffffc020512c:	040b0463          	beqz	s6,ffffffffc0205174 <stride_dequeue+0x146>
ffffffffc0205130:	85da                	mv	a1,s6
ffffffffc0205132:	854a                	mv	a0,s2
ffffffffc0205134:	f83e                	sd	a5,48(sp)
ffffffffc0205136:	f442                	sd	a6,40(sp)
ffffffffc0205138:	cbbff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc020513c:	58fd                	li	a7,-1
ffffffffc020513e:	7822                	ld	a6,40(sp)
ffffffffc0205140:	77c2                	ld	a5,48(sp)
ffffffffc0205142:	01151463          	bne	a0,a7,ffffffffc020514a <stride_dequeue+0x11c>
ffffffffc0205146:	00d0106f          	j	ffffffffc0206952 <stride_dequeue+0x1924>
ffffffffc020514a:	010b3583          	ld	a1,16(s6)
ffffffffc020514e:	008b3983          	ld	s3,8(s6)
ffffffffc0205152:	854a                	mv	a0,s2
ffffffffc0205154:	f83e                	sd	a5,48(sp)
ffffffffc0205156:	f442                	sd	a6,40(sp)
ffffffffc0205158:	cf7ff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020515c:	00ab3423          	sd	a0,8(s6)
ffffffffc0205160:	013b3823          	sd	s3,16(s6)
ffffffffc0205164:	7822                	ld	a6,40(sp)
ffffffffc0205166:	77c2                	ld	a5,48(sp)
ffffffffc0205168:	010c2983          	lw	s3,16(s8)
ffffffffc020516c:	c119                	beqz	a0,ffffffffc0205172 <stride_dequeue+0x144>
ffffffffc020516e:	01653023          	sd	s6,0(a0)
ffffffffc0205172:	895a                	mv	s2,s6
ffffffffc0205174:	7702                	ld	a4,32(sp)
ffffffffc0205176:	0127b423          	sd	s2,8(a5)
ffffffffc020517a:	eb98                	sd	a4,16(a5)
ffffffffc020517c:	00f93023          	sd	a5,0(s2)
ffffffffc0205180:	893e                	mv	s2,a5
ffffffffc0205182:	67e2                	ld	a5,24(sp)
ffffffffc0205184:	01283423          	sd	s2,8(a6)
ffffffffc0205188:	00f83823          	sd	a5,16(a6)
ffffffffc020518c:	01093023          	sd	a6,0(s2)
ffffffffc0205190:	8942                	mv	s2,a6
ffffffffc0205192:	67c2                	ld	a5,16(sp)
ffffffffc0205194:	012cb423          	sd	s2,8(s9)
ffffffffc0205198:	00fcb823          	sd	a5,16(s9)
ffffffffc020519c:	01993023          	sd	s9,0(s2)
ffffffffc02051a0:	8966                	mv	s2,s9
ffffffffc02051a2:	67a2                	ld	a5,8(sp)
ffffffffc02051a4:	012db423          	sd	s2,8(s11)
ffffffffc02051a8:	00fdb823          	sd	a5,16(s11)
ffffffffc02051ac:	01b93023          	sd	s11,0(s2)
ffffffffc02051b0:	896e                	mv	s2,s11
ffffffffc02051b2:	6782                	ld	a5,0(sp)
ffffffffc02051b4:	012a3423          	sd	s2,8(s4)
ffffffffc02051b8:	00fa3823          	sd	a5,16(s4)
ffffffffc02051bc:	01493023          	sd	s4,0(s2)
ffffffffc02051c0:	8952                	mv	s2,s4
ffffffffc02051c2:	0124b423          	sd	s2,8(s1)
ffffffffc02051c6:	0174b823          	sd	s7,16(s1)
ffffffffc02051ca:	00993023          	sd	s1,0(s2)
ffffffffc02051ce:	01a4b023          	sd	s10,0(s1)
ffffffffc02051d2:	180d0963          	beqz	s10,ffffffffc0205364 <stride_dequeue+0x336>
ffffffffc02051d6:	008d3683          	ld	a3,8(s10)
ffffffffc02051da:	12840413          	addi	s0,s0,296
ffffffffc02051de:	18868563          	beq	a3,s0,ffffffffc0205368 <stride_dequeue+0x33a>
ffffffffc02051e2:	009d3823          	sd	s1,16(s10)
ffffffffc02051e6:	70aa                	ld	ra,168(sp)
ffffffffc02051e8:	740a                	ld	s0,160(sp)
ffffffffc02051ea:	39fd                	addiw	s3,s3,-1
ffffffffc02051ec:	015c3c23          	sd	s5,24(s8)
ffffffffc02051f0:	013c2823          	sw	s3,16(s8)
ffffffffc02051f4:	64ea                	ld	s1,152(sp)
ffffffffc02051f6:	694a                	ld	s2,144(sp)
ffffffffc02051f8:	69aa                	ld	s3,136(sp)
ffffffffc02051fa:	6a0a                	ld	s4,128(sp)
ffffffffc02051fc:	7ae6                	ld	s5,120(sp)
ffffffffc02051fe:	7b46                	ld	s6,112(sp)
ffffffffc0205200:	7ba6                	ld	s7,104(sp)
ffffffffc0205202:	7c06                	ld	s8,96(sp)
ffffffffc0205204:	6ce6                	ld	s9,88(sp)
ffffffffc0205206:	6d46                	ld	s10,80(sp)
ffffffffc0205208:	6da6                	ld	s11,72(sp)
ffffffffc020520a:	614d                	addi	sp,sp,176
ffffffffc020520c:	8082                	ret
ffffffffc020520e:	01093d83          	ld	s11,16(s2)
ffffffffc0205212:	00893b83          	ld	s7,8(s2)
ffffffffc0205216:	120d8963          	beqz	s11,ffffffffc0205348 <stride_dequeue+0x31a>
ffffffffc020521a:	85a6                	mv	a1,s1
ffffffffc020521c:	856e                	mv	a0,s11
ffffffffc020521e:	bd5ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205222:	29450363          	beq	a0,s4,ffffffffc02054a8 <stride_dequeue+0x47a>
ffffffffc0205226:	649c                	ld	a5,8(s1)
ffffffffc0205228:	0104bc83          	ld	s9,16(s1)
ffffffffc020522c:	e03e                	sd	a5,0(sp)
ffffffffc020522e:	100c8763          	beqz	s9,ffffffffc020533c <stride_dequeue+0x30e>
ffffffffc0205232:	85e6                	mv	a1,s9
ffffffffc0205234:	856e                	mv	a0,s11
ffffffffc0205236:	bbdff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc020523a:	4b450263          	beq	a0,s4,ffffffffc02056de <stride_dequeue+0x6b0>
ffffffffc020523e:	008cb783          	ld	a5,8(s9)
ffffffffc0205242:	010cba03          	ld	s4,16(s9)
ffffffffc0205246:	e43e                	sd	a5,8(sp)
ffffffffc0205248:	0e0a0263          	beqz	s4,ffffffffc020532c <stride_dequeue+0x2fe>
ffffffffc020524c:	85d2                	mv	a1,s4
ffffffffc020524e:	856e                	mv	a0,s11
ffffffffc0205250:	ba3ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205254:	58fd                	li	a7,-1
ffffffffc0205256:	03150fe3          	beq	a0,a7,ffffffffc0205a94 <stride_dequeue+0xa66>
ffffffffc020525a:	008a3783          	ld	a5,8(s4)
ffffffffc020525e:	010a3803          	ld	a6,16(s4)
ffffffffc0205262:	e83e                	sd	a5,16(sp)
ffffffffc0205264:	0a080c63          	beqz	a6,ffffffffc020531c <stride_dequeue+0x2ee>
ffffffffc0205268:	85c2                	mv	a1,a6
ffffffffc020526a:	856e                	mv	a0,s11
ffffffffc020526c:	ec42                	sd	a6,24(sp)
ffffffffc020526e:	b85ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205272:	58fd                	li	a7,-1
ffffffffc0205274:	6862                	ld	a6,24(sp)
ffffffffc0205276:	01151463          	bne	a0,a7,ffffffffc020527e <stride_dequeue+0x250>
ffffffffc020527a:	6e10006f          	j	ffffffffc020615a <stride_dequeue+0x112c>
ffffffffc020527e:	00883783          	ld	a5,8(a6)
ffffffffc0205282:	01083303          	ld	t1,16(a6)
ffffffffc0205286:	ec3e                	sd	a5,24(sp)
ffffffffc0205288:	08030263          	beqz	t1,ffffffffc020530c <stride_dequeue+0x2de>
ffffffffc020528c:	859a                	mv	a1,t1
ffffffffc020528e:	856e                	mv	a0,s11
ffffffffc0205290:	f442                	sd	a6,40(sp)
ffffffffc0205292:	f01a                	sd	t1,32(sp)
ffffffffc0205294:	b5fff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205298:	58fd                	li	a7,-1
ffffffffc020529a:	7302                	ld	t1,32(sp)
ffffffffc020529c:	7822                	ld	a6,40(sp)
ffffffffc020529e:	01151463          	bne	a0,a7,ffffffffc02052a6 <stride_dequeue+0x278>
ffffffffc02052a2:	5ee0106f          	j	ffffffffc0206890 <stride_dequeue+0x1862>
ffffffffc02052a6:	00833783          	ld	a5,8(t1)
ffffffffc02052aa:	01033983          	ld	s3,16(t1)
ffffffffc02052ae:	f03e                	sd	a5,32(sp)
ffffffffc02052b0:	00099463          	bnez	s3,ffffffffc02052b8 <stride_dequeue+0x28a>
ffffffffc02052b4:	26f0106f          	j	ffffffffc0206d22 <stride_dequeue+0x1cf4>
ffffffffc02052b8:	85ce                	mv	a1,s3
ffffffffc02052ba:	856e                	mv	a0,s11
ffffffffc02052bc:	f842                	sd	a6,48(sp)
ffffffffc02052be:	f41a                	sd	t1,40(sp)
ffffffffc02052c0:	b33ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02052c4:	58fd                	li	a7,-1
ffffffffc02052c6:	7322                	ld	t1,40(sp)
ffffffffc02052c8:	7842                	ld	a6,48(sp)
ffffffffc02052ca:	01151463          	bne	a0,a7,ffffffffc02052d2 <stride_dequeue+0x2a4>
ffffffffc02052ce:	4d30106f          	j	ffffffffc0206fa0 <stride_dequeue+0x1f72>
ffffffffc02052d2:	0109b583          	ld	a1,16(s3)
ffffffffc02052d6:	0089bb03          	ld	s6,8(s3)
ffffffffc02052da:	856e                	mv	a0,s11
ffffffffc02052dc:	f842                	sd	a6,48(sp)
ffffffffc02052de:	f41a                	sd	t1,40(sp)
ffffffffc02052e0:	b6fff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02052e4:	00a9b423          	sd	a0,8(s3)
ffffffffc02052e8:	0169b823          	sd	s6,16(s3)
ffffffffc02052ec:	7322                	ld	t1,40(sp)
ffffffffc02052ee:	7842                	ld	a6,48(sp)
ffffffffc02052f0:	010c2b03          	lw	s6,16(s8)
ffffffffc02052f4:	c119                	beqz	a0,ffffffffc02052fa <stride_dequeue+0x2cc>
ffffffffc02052f6:	01353023          	sd	s3,0(a0)
ffffffffc02052fa:	7782                	ld	a5,32(sp)
ffffffffc02052fc:	01333423          	sd	s3,8(t1)
ffffffffc0205300:	8d9a                	mv	s11,t1
ffffffffc0205302:	00f33823          	sd	a5,16(t1)
ffffffffc0205306:	0069b023          	sd	t1,0(s3)
ffffffffc020530a:	89da                	mv	s3,s6
ffffffffc020530c:	67e2                	ld	a5,24(sp)
ffffffffc020530e:	01b83423          	sd	s11,8(a6)
ffffffffc0205312:	00f83823          	sd	a5,16(a6)
ffffffffc0205316:	010db023          	sd	a6,0(s11)
ffffffffc020531a:	8dc2                	mv	s11,a6
ffffffffc020531c:	67c2                	ld	a5,16(sp)
ffffffffc020531e:	01ba3423          	sd	s11,8(s4)
ffffffffc0205322:	00fa3823          	sd	a5,16(s4)
ffffffffc0205326:	014db023          	sd	s4,0(s11)
ffffffffc020532a:	8dd2                	mv	s11,s4
ffffffffc020532c:	67a2                	ld	a5,8(sp)
ffffffffc020532e:	01bcb423          	sd	s11,8(s9)
ffffffffc0205332:	00fcb823          	sd	a5,16(s9)
ffffffffc0205336:	019db023          	sd	s9,0(s11)
ffffffffc020533a:	8de6                	mv	s11,s9
ffffffffc020533c:	6782                	ld	a5,0(sp)
ffffffffc020533e:	01b4b423          	sd	s11,8(s1)
ffffffffc0205342:	e89c                	sd	a5,16(s1)
ffffffffc0205344:	009db023          	sd	s1,0(s11)
ffffffffc0205348:	00993423          	sd	s1,8(s2)
ffffffffc020534c:	01793823          	sd	s7,16(s2)
ffffffffc0205350:	0124b023          	sd	s2,0(s1)
ffffffffc0205354:	84ca                	mv	s1,s2
ffffffffc0205356:	01a4b023          	sd	s10,0(s1)
ffffffffc020535a:	bda5                	j	ffffffffc02051d2 <stride_dequeue+0x1a4>
ffffffffc020535c:	e60499e3          	bnez	s1,ffffffffc02051ce <stride_dequeue+0x1a0>
ffffffffc0205360:	e60d1be3          	bnez	s10,ffffffffc02051d6 <stride_dequeue+0x1a8>
ffffffffc0205364:	8aa6                	mv	s5,s1
ffffffffc0205366:	b541                	j	ffffffffc02051e6 <stride_dequeue+0x1b8>
ffffffffc0205368:	009d3423          	sd	s1,8(s10)
ffffffffc020536c:	bdad                	j	ffffffffc02051e6 <stride_dequeue+0x1b8>
ffffffffc020536e:	01093d83          	ld	s11,16(s2)
ffffffffc0205372:	e02a                	sd	a0,0(sp)
ffffffffc0205374:	00893c83          	ld	s9,8(s2)
ffffffffc0205378:	100d8d63          	beqz	s11,ffffffffc0205492 <stride_dequeue+0x464>
ffffffffc020537c:	85d2                	mv	a1,s4
ffffffffc020537e:	856e                	mv	a0,s11
ffffffffc0205380:	a73ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205384:	6782                	ld	a5,0(sp)
ffffffffc0205386:	24f50563          	beq	a0,a5,ffffffffc02055d0 <stride_dequeue+0x5a2>
ffffffffc020538a:	008a3783          	ld	a5,8(s4)
ffffffffc020538e:	010a3603          	ld	a2,16(s4)
ffffffffc0205392:	e03e                	sd	a5,0(sp)
ffffffffc0205394:	0e060863          	beqz	a2,ffffffffc0205484 <stride_dequeue+0x456>
ffffffffc0205398:	85b2                	mv	a1,a2
ffffffffc020539a:	856e                	mv	a0,s11
ffffffffc020539c:	e432                	sd	a2,8(sp)
ffffffffc020539e:	a55ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02053a2:	58fd                	li	a7,-1
ffffffffc02053a4:	6622                	ld	a2,8(sp)
ffffffffc02053a6:	7b150f63          	beq	a0,a7,ffffffffc0205b64 <stride_dequeue+0xb36>
ffffffffc02053aa:	661c                	ld	a5,8(a2)
ffffffffc02053ac:	01063803          	ld	a6,16(a2)
ffffffffc02053b0:	e43e                	sd	a5,8(sp)
ffffffffc02053b2:	0c080263          	beqz	a6,ffffffffc0205476 <stride_dequeue+0x448>
ffffffffc02053b6:	85c2                	mv	a1,a6
ffffffffc02053b8:	856e                	mv	a0,s11
ffffffffc02053ba:	ec32                	sd	a2,24(sp)
ffffffffc02053bc:	e842                	sd	a6,16(sp)
ffffffffc02053be:	a35ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02053c2:	58fd                	li	a7,-1
ffffffffc02053c4:	6842                	ld	a6,16(sp)
ffffffffc02053c6:	6662                	ld	a2,24(sp)
ffffffffc02053c8:	631507e3          	beq	a0,a7,ffffffffc02061f6 <stride_dequeue+0x11c8>
ffffffffc02053cc:	00883783          	ld	a5,8(a6)
ffffffffc02053d0:	01083303          	ld	t1,16(a6)
ffffffffc02053d4:	e83e                	sd	a5,16(sp)
ffffffffc02053d6:	08030863          	beqz	t1,ffffffffc0205466 <stride_dequeue+0x438>
ffffffffc02053da:	859a                	mv	a1,t1
ffffffffc02053dc:	856e                	mv	a0,s11
ffffffffc02053de:	f442                	sd	a6,40(sp)
ffffffffc02053e0:	f032                	sd	a2,32(sp)
ffffffffc02053e2:	ec1a                	sd	t1,24(sp)
ffffffffc02053e4:	a0fff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02053e8:	58fd                	li	a7,-1
ffffffffc02053ea:	6362                	ld	t1,24(sp)
ffffffffc02053ec:	7602                	ld	a2,32(sp)
ffffffffc02053ee:	7822                	ld	a6,40(sp)
ffffffffc02053f0:	01151463          	bne	a0,a7,ffffffffc02053f8 <stride_dequeue+0x3ca>
ffffffffc02053f4:	3d00106f          	j	ffffffffc02067c4 <stride_dequeue+0x1796>
ffffffffc02053f8:	00833783          	ld	a5,8(t1)
ffffffffc02053fc:	01033983          	ld	s3,16(t1)
ffffffffc0205400:	ec3e                	sd	a5,24(sp)
ffffffffc0205402:	00099463          	bnez	s3,ffffffffc020540a <stride_dequeue+0x3dc>
ffffffffc0205406:	2af0106f          	j	ffffffffc0206eb4 <stride_dequeue+0x1e86>
ffffffffc020540a:	85ce                	mv	a1,s3
ffffffffc020540c:	856e                	mv	a0,s11
ffffffffc020540e:	f81a                	sd	t1,48(sp)
ffffffffc0205410:	f442                	sd	a6,40(sp)
ffffffffc0205412:	f032                	sd	a2,32(sp)
ffffffffc0205414:	9dfff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205418:	58fd                	li	a7,-1
ffffffffc020541a:	7602                	ld	a2,32(sp)
ffffffffc020541c:	7822                	ld	a6,40(sp)
ffffffffc020541e:	7342                	ld	t1,48(sp)
ffffffffc0205420:	01151463          	bne	a0,a7,ffffffffc0205428 <stride_dequeue+0x3fa>
ffffffffc0205424:	3510106f          	j	ffffffffc0206f74 <stride_dequeue+0x1f46>
ffffffffc0205428:	0109b583          	ld	a1,16(s3)
ffffffffc020542c:	0089bb03          	ld	s6,8(s3)
ffffffffc0205430:	856e                	mv	a0,s11
ffffffffc0205432:	f81a                	sd	t1,48(sp)
ffffffffc0205434:	f442                	sd	a6,40(sp)
ffffffffc0205436:	f032                	sd	a2,32(sp)
ffffffffc0205438:	a17ff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020543c:	00a9b423          	sd	a0,8(s3)
ffffffffc0205440:	0169b823          	sd	s6,16(s3)
ffffffffc0205444:	7602                	ld	a2,32(sp)
ffffffffc0205446:	7822                	ld	a6,40(sp)
ffffffffc0205448:	7342                	ld	t1,48(sp)
ffffffffc020544a:	010c2b03          	lw	s6,16(s8)
ffffffffc020544e:	c119                	beqz	a0,ffffffffc0205454 <stride_dequeue+0x426>
ffffffffc0205450:	01353023          	sd	s3,0(a0)
ffffffffc0205454:	67e2                	ld	a5,24(sp)
ffffffffc0205456:	01333423          	sd	s3,8(t1)
ffffffffc020545a:	8d9a                	mv	s11,t1
ffffffffc020545c:	00f33823          	sd	a5,16(t1)
ffffffffc0205460:	0069b023          	sd	t1,0(s3)
ffffffffc0205464:	89da                	mv	s3,s6
ffffffffc0205466:	67c2                	ld	a5,16(sp)
ffffffffc0205468:	01b83423          	sd	s11,8(a6)
ffffffffc020546c:	00f83823          	sd	a5,16(a6)
ffffffffc0205470:	010db023          	sd	a6,0(s11)
ffffffffc0205474:	8dc2                	mv	s11,a6
ffffffffc0205476:	67a2                	ld	a5,8(sp)
ffffffffc0205478:	01b63423          	sd	s11,8(a2)
ffffffffc020547c:	ea1c                	sd	a5,16(a2)
ffffffffc020547e:	00cdb023          	sd	a2,0(s11)
ffffffffc0205482:	8db2                	mv	s11,a2
ffffffffc0205484:	6782                	ld	a5,0(sp)
ffffffffc0205486:	01ba3423          	sd	s11,8(s4)
ffffffffc020548a:	00fa3823          	sd	a5,16(s4)
ffffffffc020548e:	014db023          	sd	s4,0(s11)
ffffffffc0205492:	01493423          	sd	s4,8(s2)
ffffffffc0205496:	01993823          	sd	s9,16(s2)
ffffffffc020549a:	012a3023          	sd	s2,0(s4)
ffffffffc020549e:	b315                	j	ffffffffc02051c2 <stride_dequeue+0x194>
ffffffffc02054a0:	84ca                	mv	s1,s2
ffffffffc02054a2:	01a4b023          	sd	s10,0(s1)
ffffffffc02054a6:	b335                	j	ffffffffc02051d2 <stride_dequeue+0x1a4>
ffffffffc02054a8:	008db783          	ld	a5,8(s11)
ffffffffc02054ac:	010dbc83          	ld	s9,16(s11)
ffffffffc02054b0:	e42a                	sd	a0,8(sp)
ffffffffc02054b2:	e03e                	sd	a5,0(sp)
ffffffffc02054b4:	100c8563          	beqz	s9,ffffffffc02055be <stride_dequeue+0x590>
ffffffffc02054b8:	85a6                	mv	a1,s1
ffffffffc02054ba:	8566                	mv	a0,s9
ffffffffc02054bc:	937ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02054c0:	67a2                	ld	a5,8(sp)
ffffffffc02054c2:	4cf50e63          	beq	a0,a5,ffffffffc020599e <stride_dequeue+0x970>
ffffffffc02054c6:	649c                	ld	a5,8(s1)
ffffffffc02054c8:	0104ba03          	ld	s4,16(s1)
ffffffffc02054cc:	e43e                	sd	a5,8(sp)
ffffffffc02054ce:	0e0a0263          	beqz	s4,ffffffffc02055b2 <stride_dequeue+0x584>
ffffffffc02054d2:	85d2                	mv	a1,s4
ffffffffc02054d4:	8566                	mv	a0,s9
ffffffffc02054d6:	91dff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02054da:	58fd                	li	a7,-1
ffffffffc02054dc:	0d1505e3          	beq	a0,a7,ffffffffc0205da6 <stride_dequeue+0xd78>
ffffffffc02054e0:	008a3783          	ld	a5,8(s4)
ffffffffc02054e4:	010a3803          	ld	a6,16(s4)
ffffffffc02054e8:	e83e                	sd	a5,16(sp)
ffffffffc02054ea:	0a080c63          	beqz	a6,ffffffffc02055a2 <stride_dequeue+0x574>
ffffffffc02054ee:	85c2                	mv	a1,a6
ffffffffc02054f0:	8566                	mv	a0,s9
ffffffffc02054f2:	ec42                	sd	a6,24(sp)
ffffffffc02054f4:	8ffff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02054f8:	58fd                	li	a7,-1
ffffffffc02054fa:	6862                	ld	a6,24(sp)
ffffffffc02054fc:	01151463          	bne	a0,a7,ffffffffc0205504 <stride_dequeue+0x4d6>
ffffffffc0205500:	07c0106f          	j	ffffffffc020657c <stride_dequeue+0x154e>
ffffffffc0205504:	00883783          	ld	a5,8(a6)
ffffffffc0205508:	01083983          	ld	s3,16(a6)
ffffffffc020550c:	ec3e                	sd	a5,24(sp)
ffffffffc020550e:	00099463          	bnez	s3,ffffffffc0205516 <stride_dequeue+0x4e8>
ffffffffc0205512:	2bb0106f          	j	ffffffffc0206fcc <stride_dequeue+0x1f9e>
ffffffffc0205516:	85ce                	mv	a1,s3
ffffffffc0205518:	8566                	mv	a0,s9
ffffffffc020551a:	f042                	sd	a6,32(sp)
ffffffffc020551c:	8d7ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205520:	58fd                	li	a7,-1
ffffffffc0205522:	7802                	ld	a6,32(sp)
ffffffffc0205524:	01151463          	bne	a0,a7,ffffffffc020552c <stride_dequeue+0x4fe>
ffffffffc0205528:	05f0106f          	j	ffffffffc0206d86 <stride_dequeue+0x1d58>
ffffffffc020552c:	0089b783          	ld	a5,8(s3)
ffffffffc0205530:	0109be03          	ld	t3,16(s3)
ffffffffc0205534:	f03e                	sd	a5,32(sp)
ffffffffc0205536:	040e0663          	beqz	t3,ffffffffc0205582 <stride_dequeue+0x554>
ffffffffc020553a:	85f2                	mv	a1,t3
ffffffffc020553c:	8566                	mv	a0,s9
ffffffffc020553e:	f842                	sd	a6,48(sp)
ffffffffc0205540:	f472                	sd	t3,40(sp)
ffffffffc0205542:	8b1ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205546:	58fd                	li	a7,-1
ffffffffc0205548:	7e22                	ld	t3,40(sp)
ffffffffc020554a:	7842                	ld	a6,48(sp)
ffffffffc020554c:	01151463          	bne	a0,a7,ffffffffc0205554 <stride_dequeue+0x526>
ffffffffc0205550:	4e70106f          	j	ffffffffc0207236 <stride_dequeue+0x2208>
ffffffffc0205554:	010e3583          	ld	a1,16(t3)
ffffffffc0205558:	8566                	mv	a0,s9
ffffffffc020555a:	008e3b03          	ld	s6,8(t3)
ffffffffc020555e:	f842                	sd	a6,48(sp)
ffffffffc0205560:	f472                	sd	t3,40(sp)
ffffffffc0205562:	8edff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205566:	7e22                	ld	t3,40(sp)
ffffffffc0205568:	7842                	ld	a6,48(sp)
ffffffffc020556a:	016e3823          	sd	s6,16(t3)
ffffffffc020556e:	00ae3423          	sd	a0,8(t3)
ffffffffc0205572:	010c2b03          	lw	s6,16(s8)
ffffffffc0205576:	e119                	bnez	a0,ffffffffc020557c <stride_dequeue+0x54e>
ffffffffc0205578:	7bb0106f          	j	ffffffffc0207532 <stride_dequeue+0x2504>
ffffffffc020557c:	01c53023          	sd	t3,0(a0)
ffffffffc0205580:	8cf2                	mv	s9,t3
ffffffffc0205582:	7782                	ld	a5,32(sp)
ffffffffc0205584:	0199b423          	sd	s9,8(s3)
ffffffffc0205588:	00f9b823          	sd	a5,16(s3)
ffffffffc020558c:	013cb023          	sd	s3,0(s9)
ffffffffc0205590:	67e2                	ld	a5,24(sp)
ffffffffc0205592:	01383423          	sd	s3,8(a6)
ffffffffc0205596:	8cc2                	mv	s9,a6
ffffffffc0205598:	00f83823          	sd	a5,16(a6)
ffffffffc020559c:	0109b023          	sd	a6,0(s3)
ffffffffc02055a0:	89da                	mv	s3,s6
ffffffffc02055a2:	67c2                	ld	a5,16(sp)
ffffffffc02055a4:	019a3423          	sd	s9,8(s4)
ffffffffc02055a8:	00fa3823          	sd	a5,16(s4)
ffffffffc02055ac:	014cb023          	sd	s4,0(s9)
ffffffffc02055b0:	8cd2                	mv	s9,s4
ffffffffc02055b2:	67a2                	ld	a5,8(sp)
ffffffffc02055b4:	0194b423          	sd	s9,8(s1)
ffffffffc02055b8:	e89c                	sd	a5,16(s1)
ffffffffc02055ba:	009cb023          	sd	s1,0(s9)
ffffffffc02055be:	6782                	ld	a5,0(sp)
ffffffffc02055c0:	009db423          	sd	s1,8(s11)
ffffffffc02055c4:	00fdb823          	sd	a5,16(s11)
ffffffffc02055c8:	01b4b023          	sd	s11,0(s1)
ffffffffc02055cc:	84ee                	mv	s1,s11
ffffffffc02055ce:	bbad                	j	ffffffffc0205348 <stride_dequeue+0x31a>
ffffffffc02055d0:	008db783          	ld	a5,8(s11)
ffffffffc02055d4:	010db603          	ld	a2,16(s11)
ffffffffc02055d8:	e03e                	sd	a5,0(sp)
ffffffffc02055da:	0e060963          	beqz	a2,ffffffffc02056cc <stride_dequeue+0x69e>
ffffffffc02055de:	8532                	mv	a0,a2
ffffffffc02055e0:	85d2                	mv	a1,s4
ffffffffc02055e2:	e432                	sd	a2,8(sp)
ffffffffc02055e4:	80fff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02055e8:	58fd                	li	a7,-1
ffffffffc02055ea:	6622                	ld	a2,8(sp)
ffffffffc02055ec:	091504e3          	beq	a0,a7,ffffffffc0205e74 <stride_dequeue+0xe46>
ffffffffc02055f0:	008a3783          	ld	a5,8(s4)
ffffffffc02055f4:	010a3803          	ld	a6,16(s4)
ffffffffc02055f8:	e43e                	sd	a5,8(sp)
ffffffffc02055fa:	0c080263          	beqz	a6,ffffffffc02056be <stride_dequeue+0x690>
ffffffffc02055fe:	85c2                	mv	a1,a6
ffffffffc0205600:	8532                	mv	a0,a2
ffffffffc0205602:	ec42                	sd	a6,24(sp)
ffffffffc0205604:	e832                	sd	a2,16(sp)
ffffffffc0205606:	fecff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc020560a:	58fd                	li	a7,-1
ffffffffc020560c:	6642                	ld	a2,16(sp)
ffffffffc020560e:	6862                	ld	a6,24(sp)
ffffffffc0205610:	01151463          	bne	a0,a7,ffffffffc0205618 <stride_dequeue+0x5ea>
ffffffffc0205614:	00a0106f          	j	ffffffffc020661e <stride_dequeue+0x15f0>
ffffffffc0205618:	00883783          	ld	a5,8(a6)
ffffffffc020561c:	01083983          	ld	s3,16(a6)
ffffffffc0205620:	e83e                	sd	a5,16(sp)
ffffffffc0205622:	00099463          	bnez	s3,ffffffffc020562a <stride_dequeue+0x5fc>
ffffffffc0205626:	1e50106f          	j	ffffffffc020700a <stride_dequeue+0x1fdc>
ffffffffc020562a:	8532                	mv	a0,a2
ffffffffc020562c:	85ce                	mv	a1,s3
ffffffffc020562e:	f042                	sd	a6,32(sp)
ffffffffc0205630:	ec32                	sd	a2,24(sp)
ffffffffc0205632:	fc0ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205636:	58fd                	li	a7,-1
ffffffffc0205638:	6662                	ld	a2,24(sp)
ffffffffc020563a:	7802                	ld	a6,32(sp)
ffffffffc020563c:	01151463          	bne	a0,a7,ffffffffc0205644 <stride_dequeue+0x616>
ffffffffc0205640:	4fc0106f          	j	ffffffffc0206b3c <stride_dequeue+0x1b0e>
ffffffffc0205644:	0089b783          	ld	a5,8(s3)
ffffffffc0205648:	0109be03          	ld	t3,16(s3)
ffffffffc020564c:	ec3e                	sd	a5,24(sp)
ffffffffc020564e:	040e0863          	beqz	t3,ffffffffc020569e <stride_dequeue+0x670>
ffffffffc0205652:	85f2                	mv	a1,t3
ffffffffc0205654:	8532                	mv	a0,a2
ffffffffc0205656:	f842                	sd	a6,48(sp)
ffffffffc0205658:	f472                	sd	t3,40(sp)
ffffffffc020565a:	f032                	sd	a2,32(sp)
ffffffffc020565c:	f96ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205660:	7842                	ld	a6,48(sp)
ffffffffc0205662:	7e22                	ld	t3,40(sp)
ffffffffc0205664:	58fd                	li	a7,-1
ffffffffc0205666:	f442                	sd	a6,40(sp)
ffffffffc0205668:	7602                	ld	a2,32(sp)
ffffffffc020566a:	01151463          	bne	a0,a7,ffffffffc0205672 <stride_dequeue+0x644>
ffffffffc020566e:	37b0106f          	j	ffffffffc02071e8 <stride_dequeue+0x21ba>
ffffffffc0205672:	010e3583          	ld	a1,16(t3)
ffffffffc0205676:	8532                	mv	a0,a2
ffffffffc0205678:	008e3b03          	ld	s6,8(t3)
ffffffffc020567c:	f072                	sd	t3,32(sp)
ffffffffc020567e:	fd0ff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205682:	7e02                	ld	t3,32(sp)
ffffffffc0205684:	7822                	ld	a6,40(sp)
ffffffffc0205686:	016e3823          	sd	s6,16(t3)
ffffffffc020568a:	00ae3423          	sd	a0,8(t3)
ffffffffc020568e:	010c2b03          	lw	s6,16(s8)
ffffffffc0205692:	e119                	bnez	a0,ffffffffc0205698 <stride_dequeue+0x66a>
ffffffffc0205694:	7090106f          	j	ffffffffc020759c <stride_dequeue+0x256e>
ffffffffc0205698:	01c53023          	sd	t3,0(a0)
ffffffffc020569c:	8672                	mv	a2,t3
ffffffffc020569e:	67e2                	ld	a5,24(sp)
ffffffffc02056a0:	00c9b423          	sd	a2,8(s3)
ffffffffc02056a4:	00f9b823          	sd	a5,16(s3)
ffffffffc02056a8:	01363023          	sd	s3,0(a2)
ffffffffc02056ac:	67c2                	ld	a5,16(sp)
ffffffffc02056ae:	01383423          	sd	s3,8(a6)
ffffffffc02056b2:	8642                	mv	a2,a6
ffffffffc02056b4:	00f83823          	sd	a5,16(a6)
ffffffffc02056b8:	0109b023          	sd	a6,0(s3)
ffffffffc02056bc:	89da                	mv	s3,s6
ffffffffc02056be:	67a2                	ld	a5,8(sp)
ffffffffc02056c0:	00ca3423          	sd	a2,8(s4)
ffffffffc02056c4:	00fa3823          	sd	a5,16(s4)
ffffffffc02056c8:	01463023          	sd	s4,0(a2)
ffffffffc02056cc:	6782                	ld	a5,0(sp)
ffffffffc02056ce:	014db423          	sd	s4,8(s11)
ffffffffc02056d2:	00fdb823          	sd	a5,16(s11)
ffffffffc02056d6:	01ba3023          	sd	s11,0(s4)
ffffffffc02056da:	8a6e                	mv	s4,s11
ffffffffc02056dc:	bb5d                	j	ffffffffc0205492 <stride_dequeue+0x464>
ffffffffc02056de:	008db783          	ld	a5,8(s11)
ffffffffc02056e2:	010dba03          	ld	s4,16(s11)
ffffffffc02056e6:	e43e                	sd	a5,8(sp)
ffffffffc02056e8:	0e0a0163          	beqz	s4,ffffffffc02057ca <stride_dequeue+0x79c>
ffffffffc02056ec:	85e6                	mv	a1,s9
ffffffffc02056ee:	8552                	mv	a0,s4
ffffffffc02056f0:	f02ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02056f4:	58fd                	li	a7,-1
ffffffffc02056f6:	05150de3          	beq	a0,a7,ffffffffc0205f50 <stride_dequeue+0xf22>
ffffffffc02056fa:	008cb783          	ld	a5,8(s9)
ffffffffc02056fe:	010cb803          	ld	a6,16(s9)
ffffffffc0205702:	e83e                	sd	a5,16(sp)
ffffffffc0205704:	0a080c63          	beqz	a6,ffffffffc02057bc <stride_dequeue+0x78e>
ffffffffc0205708:	85c2                	mv	a1,a6
ffffffffc020570a:	8552                	mv	a0,s4
ffffffffc020570c:	ec42                	sd	a6,24(sp)
ffffffffc020570e:	ee4ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205712:	58fd                	li	a7,-1
ffffffffc0205714:	6862                	ld	a6,24(sp)
ffffffffc0205716:	01151463          	bne	a0,a7,ffffffffc020571e <stride_dequeue+0x6f0>
ffffffffc020571a:	7ab0006f          	j	ffffffffc02066c4 <stride_dequeue+0x1696>
ffffffffc020571e:	00883783          	ld	a5,8(a6)
ffffffffc0205722:	01083983          	ld	s3,16(a6)
ffffffffc0205726:	ec3e                	sd	a5,24(sp)
ffffffffc0205728:	00099463          	bnez	s3,ffffffffc0205730 <stride_dequeue+0x702>
ffffffffc020572c:	0cd0106f          	j	ffffffffc0206ff8 <stride_dequeue+0x1fca>
ffffffffc0205730:	85ce                	mv	a1,s3
ffffffffc0205732:	8552                	mv	a0,s4
ffffffffc0205734:	f042                	sd	a6,32(sp)
ffffffffc0205736:	ebcff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc020573a:	58fd                	li	a7,-1
ffffffffc020573c:	7802                	ld	a6,32(sp)
ffffffffc020573e:	01151463          	bne	a0,a7,ffffffffc0205746 <stride_dequeue+0x718>
ffffffffc0205742:	39c0106f          	j	ffffffffc0206ade <stride_dequeue+0x1ab0>
ffffffffc0205746:	0089b783          	ld	a5,8(s3)
ffffffffc020574a:	0109be03          	ld	t3,16(s3)
ffffffffc020574e:	f03e                	sd	a5,32(sp)
ffffffffc0205750:	040e0663          	beqz	t3,ffffffffc020579c <stride_dequeue+0x76e>
ffffffffc0205754:	85f2                	mv	a1,t3
ffffffffc0205756:	8552                	mv	a0,s4
ffffffffc0205758:	f842                	sd	a6,48(sp)
ffffffffc020575a:	f472                	sd	t3,40(sp)
ffffffffc020575c:	e96ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205760:	58fd                	li	a7,-1
ffffffffc0205762:	7e22                	ld	t3,40(sp)
ffffffffc0205764:	7842                	ld	a6,48(sp)
ffffffffc0205766:	01151463          	bne	a0,a7,ffffffffc020576e <stride_dequeue+0x740>
ffffffffc020576a:	2f90106f          	j	ffffffffc0207262 <stride_dequeue+0x2234>
ffffffffc020576e:	010e3583          	ld	a1,16(t3)
ffffffffc0205772:	8552                	mv	a0,s4
ffffffffc0205774:	008e3b03          	ld	s6,8(t3)
ffffffffc0205778:	f842                	sd	a6,48(sp)
ffffffffc020577a:	f472                	sd	t3,40(sp)
ffffffffc020577c:	ed2ff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205780:	7e22                	ld	t3,40(sp)
ffffffffc0205782:	7842                	ld	a6,48(sp)
ffffffffc0205784:	016e3823          	sd	s6,16(t3)
ffffffffc0205788:	00ae3423          	sd	a0,8(t3)
ffffffffc020578c:	010c2b03          	lw	s6,16(s8)
ffffffffc0205790:	e119                	bnez	a0,ffffffffc0205796 <stride_dequeue+0x768>
ffffffffc0205792:	5a70106f          	j	ffffffffc0207538 <stride_dequeue+0x250a>
ffffffffc0205796:	01c53023          	sd	t3,0(a0)
ffffffffc020579a:	8a72                	mv	s4,t3
ffffffffc020579c:	7782                	ld	a5,32(sp)
ffffffffc020579e:	0149b423          	sd	s4,8(s3)
ffffffffc02057a2:	00f9b823          	sd	a5,16(s3)
ffffffffc02057a6:	013a3023          	sd	s3,0(s4)
ffffffffc02057aa:	67e2                	ld	a5,24(sp)
ffffffffc02057ac:	01383423          	sd	s3,8(a6)
ffffffffc02057b0:	8a42                	mv	s4,a6
ffffffffc02057b2:	00f83823          	sd	a5,16(a6)
ffffffffc02057b6:	0109b023          	sd	a6,0(s3)
ffffffffc02057ba:	89da                	mv	s3,s6
ffffffffc02057bc:	67c2                	ld	a5,16(sp)
ffffffffc02057be:	014cb423          	sd	s4,8(s9)
ffffffffc02057c2:	00fcb823          	sd	a5,16(s9)
ffffffffc02057c6:	019a3023          	sd	s9,0(s4)
ffffffffc02057ca:	67a2                	ld	a5,8(sp)
ffffffffc02057cc:	019db423          	sd	s9,8(s11)
ffffffffc02057d0:	00fdb823          	sd	a5,16(s11)
ffffffffc02057d4:	01bcb023          	sd	s11,0(s9)
ffffffffc02057d8:	b695                	j	ffffffffc020533c <stride_dequeue+0x30e>
ffffffffc02057da:	00893783          	ld	a5,8(s2)
ffffffffc02057de:	01093883          	ld	a7,16(s2)
ffffffffc02057e2:	ec2a                	sd	a0,24(sp)
ffffffffc02057e4:	e83e                	sd	a5,16(sp)
ffffffffc02057e6:	0a088963          	beqz	a7,ffffffffc0205898 <stride_dequeue+0x86a>
ffffffffc02057ea:	8546                	mv	a0,a7
ffffffffc02057ec:	85e6                	mv	a1,s9
ffffffffc02057ee:	f046                	sd	a7,32(sp)
ffffffffc02057f0:	e02ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02057f4:	6862                	ld	a6,24(sp)
ffffffffc02057f6:	7882                	ld	a7,32(sp)
ffffffffc02057f8:	030504e3          	beq	a0,a6,ffffffffc0206020 <stride_dequeue+0xff2>
ffffffffc02057fc:	008cb783          	ld	a5,8(s9)
ffffffffc0205800:	010cb303          	ld	t1,16(s9)
ffffffffc0205804:	f042                	sd	a6,32(sp)
ffffffffc0205806:	ec3e                	sd	a5,24(sp)
ffffffffc0205808:	08030163          	beqz	t1,ffffffffc020588a <stride_dequeue+0x85c>
ffffffffc020580c:	859a                	mv	a1,t1
ffffffffc020580e:	8546                	mv	a0,a7
ffffffffc0205810:	f81a                	sd	t1,48(sp)
ffffffffc0205812:	f446                	sd	a7,40(sp)
ffffffffc0205814:	ddeff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205818:	7802                	ld	a6,32(sp)
ffffffffc020581a:	78a2                	ld	a7,40(sp)
ffffffffc020581c:	7342                	ld	t1,48(sp)
ffffffffc020581e:	01051463          	bne	a0,a6,ffffffffc0205826 <stride_dequeue+0x7f8>
ffffffffc0205822:	0d00106f          	j	ffffffffc02068f2 <stride_dequeue+0x18c4>
ffffffffc0205826:	00833783          	ld	a5,8(t1)
ffffffffc020582a:	01033983          	ld	s3,16(t1)
ffffffffc020582e:	f442                	sd	a6,40(sp)
ffffffffc0205830:	f03e                	sd	a5,32(sp)
ffffffffc0205832:	00099463          	bnez	s3,ffffffffc020583a <stride_dequeue+0x80c>
ffffffffc0205836:	6720106f          	j	ffffffffc0206ea8 <stride_dequeue+0x1e7a>
ffffffffc020583a:	8546                	mv	a0,a7
ffffffffc020583c:	85ce                	mv	a1,s3
ffffffffc020583e:	fc1a                	sd	t1,56(sp)
ffffffffc0205840:	f846                	sd	a7,48(sp)
ffffffffc0205842:	db0ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205846:	7822                	ld	a6,40(sp)
ffffffffc0205848:	78c2                	ld	a7,48(sp)
ffffffffc020584a:	7362                	ld	t1,56(sp)
ffffffffc020584c:	01051463          	bne	a0,a6,ffffffffc0205854 <stride_dequeue+0x826>
ffffffffc0205850:	6700106f          	j	ffffffffc0206ec0 <stride_dequeue+0x1e92>
ffffffffc0205854:	0109b583          	ld	a1,16(s3)
ffffffffc0205858:	0089bb03          	ld	s6,8(s3)
ffffffffc020585c:	8546                	mv	a0,a7
ffffffffc020585e:	f41a                	sd	t1,40(sp)
ffffffffc0205860:	deeff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205864:	00a9b423          	sd	a0,8(s3)
ffffffffc0205868:	0169b823          	sd	s6,16(s3)
ffffffffc020586c:	7322                	ld	t1,40(sp)
ffffffffc020586e:	010c2b03          	lw	s6,16(s8)
ffffffffc0205872:	c119                	beqz	a0,ffffffffc0205878 <stride_dequeue+0x84a>
ffffffffc0205874:	01353023          	sd	s3,0(a0)
ffffffffc0205878:	7782                	ld	a5,32(sp)
ffffffffc020587a:	01333423          	sd	s3,8(t1)
ffffffffc020587e:	889a                	mv	a7,t1
ffffffffc0205880:	00f33823          	sd	a5,16(t1)
ffffffffc0205884:	0069b023          	sd	t1,0(s3)
ffffffffc0205888:	89da                	mv	s3,s6
ffffffffc020588a:	67e2                	ld	a5,24(sp)
ffffffffc020588c:	011cb423          	sd	a7,8(s9)
ffffffffc0205890:	00fcb823          	sd	a5,16(s9)
ffffffffc0205894:	0198b023          	sd	s9,0(a7)
ffffffffc0205898:	67c2                	ld	a5,16(sp)
ffffffffc020589a:	01993423          	sd	s9,8(s2)
ffffffffc020589e:	00f93823          	sd	a5,16(s2)
ffffffffc02058a2:	012cb023          	sd	s2,0(s9)
ffffffffc02058a6:	b8f5                	j	ffffffffc02051a2 <stride_dequeue+0x174>
ffffffffc02058a8:	00893783          	ld	a5,8(s2)
ffffffffc02058ac:	01093c83          	ld	s9,16(s2)
ffffffffc02058b0:	e43e                	sd	a5,8(sp)
ffffffffc02058b2:	0c0c8d63          	beqz	s9,ffffffffc020598c <stride_dequeue+0x95e>
ffffffffc02058b6:	85ee                	mv	a1,s11
ffffffffc02058b8:	8566                	mv	a0,s9
ffffffffc02058ba:	d38ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02058be:	58fd                	li	a7,-1
ffffffffc02058c0:	39150063          	beq	a0,a7,ffffffffc0205c40 <stride_dequeue+0xc12>
ffffffffc02058c4:	008db783          	ld	a5,8(s11)
ffffffffc02058c8:	010db803          	ld	a6,16(s11)
ffffffffc02058cc:	e83e                	sd	a5,16(sp)
ffffffffc02058ce:	0a080863          	beqz	a6,ffffffffc020597e <stride_dequeue+0x950>
ffffffffc02058d2:	85c2                	mv	a1,a6
ffffffffc02058d4:	8566                	mv	a0,s9
ffffffffc02058d6:	ec42                	sd	a6,24(sp)
ffffffffc02058d8:	d1aff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02058dc:	58fd                	li	a7,-1
ffffffffc02058de:	6862                	ld	a6,24(sp)
ffffffffc02058e0:	7d150f63          	beq	a0,a7,ffffffffc02060be <stride_dequeue+0x1090>
ffffffffc02058e4:	00883783          	ld	a5,8(a6)
ffffffffc02058e8:	01083303          	ld	t1,16(a6)
ffffffffc02058ec:	ec3e                	sd	a5,24(sp)
ffffffffc02058ee:	08030063          	beqz	t1,ffffffffc020596e <stride_dequeue+0x940>
ffffffffc02058f2:	859a                	mv	a1,t1
ffffffffc02058f4:	8566                	mv	a0,s9
ffffffffc02058f6:	f442                	sd	a6,40(sp)
ffffffffc02058f8:	f01a                	sd	t1,32(sp)
ffffffffc02058fa:	cf8ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02058fe:	58fd                	li	a7,-1
ffffffffc0205900:	7302                	ld	t1,32(sp)
ffffffffc0205902:	7822                	ld	a6,40(sp)
ffffffffc0205904:	65150fe3          	beq	a0,a7,ffffffffc0206762 <stride_dequeue+0x1734>
ffffffffc0205908:	00833783          	ld	a5,8(t1)
ffffffffc020590c:	01033983          	ld	s3,16(t1)
ffffffffc0205910:	f03e                	sd	a5,32(sp)
ffffffffc0205912:	00099463          	bnez	s3,ffffffffc020591a <stride_dequeue+0x8ec>
ffffffffc0205916:	5980106f          	j	ffffffffc0206eae <stride_dequeue+0x1e80>
ffffffffc020591a:	85ce                	mv	a1,s3
ffffffffc020591c:	8566                	mv	a0,s9
ffffffffc020591e:	f81a                	sd	t1,48(sp)
ffffffffc0205920:	f442                	sd	a6,40(sp)
ffffffffc0205922:	cd0ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205926:	58fd                	li	a7,-1
ffffffffc0205928:	7822                	ld	a6,40(sp)
ffffffffc020592a:	7342                	ld	t1,48(sp)
ffffffffc020592c:	01151463          	bne	a0,a7,ffffffffc0205934 <stride_dequeue+0x906>
ffffffffc0205930:	5ea0106f          	j	ffffffffc0206f1a <stride_dequeue+0x1eec>
ffffffffc0205934:	0109b583          	ld	a1,16(s3)
ffffffffc0205938:	0089bb03          	ld	s6,8(s3)
ffffffffc020593c:	8566                	mv	a0,s9
ffffffffc020593e:	f81a                	sd	t1,48(sp)
ffffffffc0205940:	f442                	sd	a6,40(sp)
ffffffffc0205942:	d0cff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205946:	00a9b423          	sd	a0,8(s3)
ffffffffc020594a:	0169b823          	sd	s6,16(s3)
ffffffffc020594e:	7822                	ld	a6,40(sp)
ffffffffc0205950:	7342                	ld	t1,48(sp)
ffffffffc0205952:	010c2b03          	lw	s6,16(s8)
ffffffffc0205956:	c119                	beqz	a0,ffffffffc020595c <stride_dequeue+0x92e>
ffffffffc0205958:	01353023          	sd	s3,0(a0)
ffffffffc020595c:	7782                	ld	a5,32(sp)
ffffffffc020595e:	01333423          	sd	s3,8(t1)
ffffffffc0205962:	8c9a                	mv	s9,t1
ffffffffc0205964:	00f33823          	sd	a5,16(t1)
ffffffffc0205968:	0069b023          	sd	t1,0(s3)
ffffffffc020596c:	89da                	mv	s3,s6
ffffffffc020596e:	67e2                	ld	a5,24(sp)
ffffffffc0205970:	01983423          	sd	s9,8(a6)
ffffffffc0205974:	00f83823          	sd	a5,16(a6)
ffffffffc0205978:	010cb023          	sd	a6,0(s9)
ffffffffc020597c:	8cc2                	mv	s9,a6
ffffffffc020597e:	67c2                	ld	a5,16(sp)
ffffffffc0205980:	019db423          	sd	s9,8(s11)
ffffffffc0205984:	00fdb823          	sd	a5,16(s11)
ffffffffc0205988:	01bcb023          	sd	s11,0(s9)
ffffffffc020598c:	67a2                	ld	a5,8(sp)
ffffffffc020598e:	01b93423          	sd	s11,8(s2)
ffffffffc0205992:	00f93823          	sd	a5,16(s2)
ffffffffc0205996:	012db023          	sd	s2,0(s11)
ffffffffc020599a:	819ff06f          	j	ffffffffc02051b2 <stride_dequeue+0x184>
ffffffffc020599e:	008cb783          	ld	a5,8(s9)
ffffffffc02059a2:	010cba03          	ld	s4,16(s9)
ffffffffc02059a6:	e43e                	sd	a5,8(sp)
ffffffffc02059a8:	0c0a0d63          	beqz	s4,ffffffffc0205a82 <stride_dequeue+0xa54>
ffffffffc02059ac:	85a6                	mv	a1,s1
ffffffffc02059ae:	8552                	mv	a0,s4
ffffffffc02059b0:	c42ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02059b4:	58fd                	li	a7,-1
ffffffffc02059b6:	151500e3          	beq	a0,a7,ffffffffc02062f6 <stride_dequeue+0x12c8>
ffffffffc02059ba:	649c                	ld	a5,8(s1)
ffffffffc02059bc:	0104b983          	ld	s3,16(s1)
ffffffffc02059c0:	e83e                	sd	a5,16(sp)
ffffffffc02059c2:	00099463          	bnez	s3,ffffffffc02059ca <stride_dequeue+0x99c>
ffffffffc02059c6:	4f40106f          	j	ffffffffc0206eba <stride_dequeue+0x1e8c>
ffffffffc02059ca:	85ce                	mv	a1,s3
ffffffffc02059cc:	8552                	mv	a0,s4
ffffffffc02059ce:	c24ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02059d2:	58fd                	li	a7,-1
ffffffffc02059d4:	01151463          	bne	a0,a7,ffffffffc02059dc <stride_dequeue+0x9ae>
ffffffffc02059d8:	0b00106f          	j	ffffffffc0206a88 <stride_dequeue+0x1a5a>
ffffffffc02059dc:	0089b783          	ld	a5,8(s3)
ffffffffc02059e0:	0109b303          	ld	t1,16(s3)
ffffffffc02059e4:	ec3e                	sd	a5,24(sp)
ffffffffc02059e6:	08030063          	beqz	t1,ffffffffc0205a66 <stride_dequeue+0xa38>
ffffffffc02059ea:	859a                	mv	a1,t1
ffffffffc02059ec:	8552                	mv	a0,s4
ffffffffc02059ee:	f01a                	sd	t1,32(sp)
ffffffffc02059f0:	c02ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02059f4:	58fd                	li	a7,-1
ffffffffc02059f6:	7302                	ld	t1,32(sp)
ffffffffc02059f8:	01151463          	bne	a0,a7,ffffffffc0205a00 <stride_dequeue+0x9d2>
ffffffffc02059fc:	0130106f          	j	ffffffffc020720e <stride_dequeue+0x21e0>
ffffffffc0205a00:	00833783          	ld	a5,8(t1)
ffffffffc0205a04:	01033e03          	ld	t3,16(t1)
ffffffffc0205a08:	f03e                	sd	a5,32(sp)
ffffffffc0205a0a:	040e0663          	beqz	t3,ffffffffc0205a56 <stride_dequeue+0xa28>
ffffffffc0205a0e:	85f2                	mv	a1,t3
ffffffffc0205a10:	8552                	mv	a0,s4
ffffffffc0205a12:	f81a                	sd	t1,48(sp)
ffffffffc0205a14:	f472                	sd	t3,40(sp)
ffffffffc0205a16:	bdcff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205a1a:	58fd                	li	a7,-1
ffffffffc0205a1c:	7e22                	ld	t3,40(sp)
ffffffffc0205a1e:	7342                	ld	t1,48(sp)
ffffffffc0205a20:	01151463          	bne	a0,a7,ffffffffc0205a28 <stride_dequeue+0x9fa>
ffffffffc0205a24:	53d0106f          	j	ffffffffc0207760 <stride_dequeue+0x2732>
ffffffffc0205a28:	010e3583          	ld	a1,16(t3)
ffffffffc0205a2c:	8552                	mv	a0,s4
ffffffffc0205a2e:	008e3b03          	ld	s6,8(t3)
ffffffffc0205a32:	f81a                	sd	t1,48(sp)
ffffffffc0205a34:	f472                	sd	t3,40(sp)
ffffffffc0205a36:	c18ff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205a3a:	7e22                	ld	t3,40(sp)
ffffffffc0205a3c:	7342                	ld	t1,48(sp)
ffffffffc0205a3e:	016e3823          	sd	s6,16(t3)
ffffffffc0205a42:	00ae3423          	sd	a0,8(t3)
ffffffffc0205a46:	010c2b03          	lw	s6,16(s8)
ffffffffc0205a4a:	e119                	bnez	a0,ffffffffc0205a50 <stride_dequeue+0xa22>
ffffffffc0205a4c:	76d0106f          	j	ffffffffc02079b8 <stride_dequeue+0x298a>
ffffffffc0205a50:	01c53023          	sd	t3,0(a0)
ffffffffc0205a54:	8a72                	mv	s4,t3
ffffffffc0205a56:	7782                	ld	a5,32(sp)
ffffffffc0205a58:	01433423          	sd	s4,8(t1)
ffffffffc0205a5c:	00f33823          	sd	a5,16(t1)
ffffffffc0205a60:	006a3023          	sd	t1,0(s4)
ffffffffc0205a64:	8a1a                	mv	s4,t1
ffffffffc0205a66:	67e2                	ld	a5,24(sp)
ffffffffc0205a68:	0149b423          	sd	s4,8(s3)
ffffffffc0205a6c:	00f9b823          	sd	a5,16(s3)
ffffffffc0205a70:	013a3023          	sd	s3,0(s4)
ffffffffc0205a74:	67c2                	ld	a5,16(sp)
ffffffffc0205a76:	0134b423          	sd	s3,8(s1)
ffffffffc0205a7a:	e89c                	sd	a5,16(s1)
ffffffffc0205a7c:	0099b023          	sd	s1,0(s3)
ffffffffc0205a80:	89da                	mv	s3,s6
ffffffffc0205a82:	67a2                	ld	a5,8(sp)
ffffffffc0205a84:	009cb423          	sd	s1,8(s9)
ffffffffc0205a88:	00fcb823          	sd	a5,16(s9)
ffffffffc0205a8c:	0194b023          	sd	s9,0(s1)
ffffffffc0205a90:	84e6                	mv	s1,s9
ffffffffc0205a92:	b635                	j	ffffffffc02055be <stride_dequeue+0x590>
ffffffffc0205a94:	008db783          	ld	a5,8(s11)
ffffffffc0205a98:	010db883          	ld	a7,16(s11)
ffffffffc0205a9c:	ec2a                	sd	a0,24(sp)
ffffffffc0205a9e:	e83e                	sd	a5,16(sp)
ffffffffc0205aa0:	0a088963          	beqz	a7,ffffffffc0205b52 <stride_dequeue+0xb24>
ffffffffc0205aa4:	8546                	mv	a0,a7
ffffffffc0205aa6:	85d2                	mv	a1,s4
ffffffffc0205aa8:	f046                	sd	a7,32(sp)
ffffffffc0205aaa:	b48ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205aae:	6862                	ld	a6,24(sp)
ffffffffc0205ab0:	7882                	ld	a7,32(sp)
ffffffffc0205ab2:	0d050ae3          	beq	a0,a6,ffffffffc0206386 <stride_dequeue+0x1358>
ffffffffc0205ab6:	008a3783          	ld	a5,8(s4)
ffffffffc0205aba:	010a3983          	ld	s3,16(s4)
ffffffffc0205abe:	f042                	sd	a6,32(sp)
ffffffffc0205ac0:	ec3e                	sd	a5,24(sp)
ffffffffc0205ac2:	00099463          	bnez	s3,ffffffffc0205aca <stride_dequeue+0xa9c>
ffffffffc0205ac6:	53e0106f          	j	ffffffffc0207004 <stride_dequeue+0x1fd6>
ffffffffc0205aca:	8546                	mv	a0,a7
ffffffffc0205acc:	85ce                	mv	a1,s3
ffffffffc0205ace:	f446                	sd	a7,40(sp)
ffffffffc0205ad0:	b22ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205ad4:	7802                	ld	a6,32(sp)
ffffffffc0205ad6:	78a2                	ld	a7,40(sp)
ffffffffc0205ad8:	01051463          	bne	a0,a6,ffffffffc0205ae0 <stride_dequeue+0xab2>
ffffffffc0205adc:	1260106f          	j	ffffffffc0206c02 <stride_dequeue+0x1bd4>
ffffffffc0205ae0:	0089b783          	ld	a5,8(s3)
ffffffffc0205ae4:	0109be03          	ld	t3,16(s3)
ffffffffc0205ae8:	f442                	sd	a6,40(sp)
ffffffffc0205aea:	f03e                	sd	a5,32(sp)
ffffffffc0205aec:	040e0463          	beqz	t3,ffffffffc0205b34 <stride_dequeue+0xb06>
ffffffffc0205af0:	85f2                	mv	a1,t3
ffffffffc0205af2:	8546                	mv	a0,a7
ffffffffc0205af4:	fc72                	sd	t3,56(sp)
ffffffffc0205af6:	f846                	sd	a7,48(sp)
ffffffffc0205af8:	afaff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205afc:	7822                	ld	a6,40(sp)
ffffffffc0205afe:	78c2                	ld	a7,48(sp)
ffffffffc0205b00:	7e62                	ld	t3,56(sp)
ffffffffc0205b02:	01051463          	bne	a0,a6,ffffffffc0205b0a <stride_dequeue+0xadc>
ffffffffc0205b06:	0e70106f          	j	ffffffffc02073ec <stride_dequeue+0x23be>
ffffffffc0205b0a:	010e3583          	ld	a1,16(t3)
ffffffffc0205b0e:	8546                	mv	a0,a7
ffffffffc0205b10:	008e3b03          	ld	s6,8(t3)
ffffffffc0205b14:	f472                	sd	t3,40(sp)
ffffffffc0205b16:	b38ff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205b1a:	7e22                	ld	t3,40(sp)
ffffffffc0205b1c:	016e3823          	sd	s6,16(t3)
ffffffffc0205b20:	00ae3423          	sd	a0,8(t3)
ffffffffc0205b24:	010c2b03          	lw	s6,16(s8)
ffffffffc0205b28:	e119                	bnez	a0,ffffffffc0205b2e <stride_dequeue+0xb00>
ffffffffc0205b2a:	1c10106f          	j	ffffffffc02074ea <stride_dequeue+0x24bc>
ffffffffc0205b2e:	01c53023          	sd	t3,0(a0)
ffffffffc0205b32:	88f2                	mv	a7,t3
ffffffffc0205b34:	7782                	ld	a5,32(sp)
ffffffffc0205b36:	0119b423          	sd	a7,8(s3)
ffffffffc0205b3a:	00f9b823          	sd	a5,16(s3)
ffffffffc0205b3e:	0138b023          	sd	s3,0(a7)
ffffffffc0205b42:	67e2                	ld	a5,24(sp)
ffffffffc0205b44:	013a3423          	sd	s3,8(s4)
ffffffffc0205b48:	00fa3823          	sd	a5,16(s4)
ffffffffc0205b4c:	0149b023          	sd	s4,0(s3)
ffffffffc0205b50:	89da                	mv	s3,s6
ffffffffc0205b52:	67c2                	ld	a5,16(sp)
ffffffffc0205b54:	014db423          	sd	s4,8(s11)
ffffffffc0205b58:	00fdb823          	sd	a5,16(s11)
ffffffffc0205b5c:	01ba3023          	sd	s11,0(s4)
ffffffffc0205b60:	fccff06f          	j	ffffffffc020532c <stride_dequeue+0x2fe>
ffffffffc0205b64:	008db783          	ld	a5,8(s11)
ffffffffc0205b68:	010db883          	ld	a7,16(s11)
ffffffffc0205b6c:	e82a                	sd	a0,16(sp)
ffffffffc0205b6e:	e43e                	sd	a5,8(sp)
ffffffffc0205b70:	0a088f63          	beqz	a7,ffffffffc0205c2e <stride_dequeue+0xc00>
ffffffffc0205b74:	85b2                	mv	a1,a2
ffffffffc0205b76:	8546                	mv	a0,a7
ffffffffc0205b78:	f032                	sd	a2,32(sp)
ffffffffc0205b7a:	ec46                	sd	a7,24(sp)
ffffffffc0205b7c:	a76ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205b80:	6842                	ld	a6,16(sp)
ffffffffc0205b82:	68e2                	ld	a7,24(sp)
ffffffffc0205b84:	7602                	ld	a2,32(sp)
ffffffffc0205b86:	150506e3          	beq	a0,a6,ffffffffc02064d2 <stride_dequeue+0x14a4>
ffffffffc0205b8a:	661c                	ld	a5,8(a2)
ffffffffc0205b8c:	01063983          	ld	s3,16(a2)
ffffffffc0205b90:	ec42                	sd	a6,24(sp)
ffffffffc0205b92:	e83e                	sd	a5,16(sp)
ffffffffc0205b94:	00099463          	bnez	s3,ffffffffc0205b9c <stride_dequeue+0xb6e>
ffffffffc0205b98:	4660106f          	j	ffffffffc0206ffe <stride_dequeue+0x1fd0>
ffffffffc0205b9c:	8546                	mv	a0,a7
ffffffffc0205b9e:	85ce                	mv	a1,s3
ffffffffc0205ba0:	f432                	sd	a2,40(sp)
ffffffffc0205ba2:	f046                	sd	a7,32(sp)
ffffffffc0205ba4:	a4eff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205ba8:	6862                	ld	a6,24(sp)
ffffffffc0205baa:	7882                	ld	a7,32(sp)
ffffffffc0205bac:	7622                	ld	a2,40(sp)
ffffffffc0205bae:	01051463          	bne	a0,a6,ffffffffc0205bb6 <stride_dequeue+0xb88>
ffffffffc0205bb2:	0ae0106f          	j	ffffffffc0206c60 <stride_dequeue+0x1c32>
ffffffffc0205bb6:	0089b783          	ld	a5,8(s3)
ffffffffc0205bba:	0109be03          	ld	t3,16(s3)
ffffffffc0205bbe:	f042                	sd	a6,32(sp)
ffffffffc0205bc0:	ec3e                	sd	a5,24(sp)
ffffffffc0205bc2:	040e0863          	beqz	t3,ffffffffc0205c12 <stride_dequeue+0xbe4>
ffffffffc0205bc6:	85f2                	mv	a1,t3
ffffffffc0205bc8:	8546                	mv	a0,a7
ffffffffc0205bca:	fc32                	sd	a2,56(sp)
ffffffffc0205bcc:	f872                	sd	t3,48(sp)
ffffffffc0205bce:	f446                	sd	a7,40(sp)
ffffffffc0205bd0:	a22ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205bd4:	7662                	ld	a2,56(sp)
ffffffffc0205bd6:	7802                	ld	a6,32(sp)
ffffffffc0205bd8:	78a2                	ld	a7,40(sp)
ffffffffc0205bda:	f432                	sd	a2,40(sp)
ffffffffc0205bdc:	7e42                	ld	t3,48(sp)
ffffffffc0205bde:	01051463          	bne	a0,a6,ffffffffc0205be6 <stride_dequeue+0xbb8>
ffffffffc0205be2:	6ac0106f          	j	ffffffffc020728e <stride_dequeue+0x2260>
ffffffffc0205be6:	010e3583          	ld	a1,16(t3)
ffffffffc0205bea:	8546                	mv	a0,a7
ffffffffc0205bec:	008e3b03          	ld	s6,8(t3)
ffffffffc0205bf0:	f072                	sd	t3,32(sp)
ffffffffc0205bf2:	a5cff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205bf6:	7e02                	ld	t3,32(sp)
ffffffffc0205bf8:	7622                	ld	a2,40(sp)
ffffffffc0205bfa:	016e3823          	sd	s6,16(t3)
ffffffffc0205bfe:	00ae3423          	sd	a0,8(t3)
ffffffffc0205c02:	010c2b03          	lw	s6,16(s8)
ffffffffc0205c06:	e119                	bnez	a0,ffffffffc0205c0c <stride_dequeue+0xbde>
ffffffffc0205c08:	1370106f          	j	ffffffffc020753e <stride_dequeue+0x2510>
ffffffffc0205c0c:	01c53023          	sd	t3,0(a0)
ffffffffc0205c10:	88f2                	mv	a7,t3
ffffffffc0205c12:	67e2                	ld	a5,24(sp)
ffffffffc0205c14:	0119b423          	sd	a7,8(s3)
ffffffffc0205c18:	00f9b823          	sd	a5,16(s3)
ffffffffc0205c1c:	0138b023          	sd	s3,0(a7)
ffffffffc0205c20:	67c2                	ld	a5,16(sp)
ffffffffc0205c22:	01363423          	sd	s3,8(a2)
ffffffffc0205c26:	ea1c                	sd	a5,16(a2)
ffffffffc0205c28:	00c9b023          	sd	a2,0(s3)
ffffffffc0205c2c:	89da                	mv	s3,s6
ffffffffc0205c2e:	67a2                	ld	a5,8(sp)
ffffffffc0205c30:	00cdb423          	sd	a2,8(s11)
ffffffffc0205c34:	00fdb823          	sd	a5,16(s11)
ffffffffc0205c38:	01b63023          	sd	s11,0(a2)
ffffffffc0205c3c:	849ff06f          	j	ffffffffc0205484 <stride_dequeue+0x456>
ffffffffc0205c40:	008cb783          	ld	a5,8(s9)
ffffffffc0205c44:	010cb883          	ld	a7,16(s9)
ffffffffc0205c48:	ec2a                	sd	a0,24(sp)
ffffffffc0205c4a:	e83e                	sd	a5,16(sp)
ffffffffc0205c4c:	0a088963          	beqz	a7,ffffffffc0205cfe <stride_dequeue+0xcd0>
ffffffffc0205c50:	8546                	mv	a0,a7
ffffffffc0205c52:	85ee                	mv	a1,s11
ffffffffc0205c54:	f046                	sd	a7,32(sp)
ffffffffc0205c56:	99cff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205c5a:	6862                	ld	a6,24(sp)
ffffffffc0205c5c:	7882                	ld	a7,32(sp)
ffffffffc0205c5e:	7d050863          	beq	a0,a6,ffffffffc020642e <stride_dequeue+0x1400>
ffffffffc0205c62:	008db783          	ld	a5,8(s11)
ffffffffc0205c66:	010db983          	ld	s3,16(s11)
ffffffffc0205c6a:	f042                	sd	a6,32(sp)
ffffffffc0205c6c:	ec3e                	sd	a5,24(sp)
ffffffffc0205c6e:	00099463          	bnez	s3,ffffffffc0205c76 <stride_dequeue+0xc48>
ffffffffc0205c72:	3600106f          	j	ffffffffc0206fd2 <stride_dequeue+0x1fa4>
ffffffffc0205c76:	8546                	mv	a0,a7
ffffffffc0205c78:	85ce                	mv	a1,s3
ffffffffc0205c7a:	f446                	sd	a7,40(sp)
ffffffffc0205c7c:	976ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205c80:	7802                	ld	a6,32(sp)
ffffffffc0205c82:	78a2                	ld	a7,40(sp)
ffffffffc0205c84:	01051463          	bne	a0,a6,ffffffffc0205c8c <stride_dequeue+0xc5e>
ffffffffc0205c88:	71d0006f          	j	ffffffffc0206ba4 <stride_dequeue+0x1b76>
ffffffffc0205c8c:	0089b783          	ld	a5,8(s3)
ffffffffc0205c90:	0109be03          	ld	t3,16(s3)
ffffffffc0205c94:	f442                	sd	a6,40(sp)
ffffffffc0205c96:	f03e                	sd	a5,32(sp)
ffffffffc0205c98:	040e0463          	beqz	t3,ffffffffc0205ce0 <stride_dequeue+0xcb2>
ffffffffc0205c9c:	85f2                	mv	a1,t3
ffffffffc0205c9e:	8546                	mv	a0,a7
ffffffffc0205ca0:	fc72                	sd	t3,56(sp)
ffffffffc0205ca2:	f846                	sd	a7,48(sp)
ffffffffc0205ca4:	94eff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205ca8:	7822                	ld	a6,40(sp)
ffffffffc0205caa:	78c2                	ld	a7,48(sp)
ffffffffc0205cac:	7e62                	ld	t3,56(sp)
ffffffffc0205cae:	01051463          	bne	a0,a6,ffffffffc0205cb6 <stride_dequeue+0xc88>
ffffffffc0205cb2:	60a0106f          	j	ffffffffc02072bc <stride_dequeue+0x228e>
ffffffffc0205cb6:	010e3583          	ld	a1,16(t3)
ffffffffc0205cba:	8546                	mv	a0,a7
ffffffffc0205cbc:	008e3b03          	ld	s6,8(t3)
ffffffffc0205cc0:	f472                	sd	t3,40(sp)
ffffffffc0205cc2:	98cff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205cc6:	7e22                	ld	t3,40(sp)
ffffffffc0205cc8:	016e3823          	sd	s6,16(t3)
ffffffffc0205ccc:	00ae3423          	sd	a0,8(t3)
ffffffffc0205cd0:	010c2b03          	lw	s6,16(s8)
ffffffffc0205cd4:	e119                	bnez	a0,ffffffffc0205cda <stride_dequeue+0xcac>
ffffffffc0205cd6:	0270106f          	j	ffffffffc02074fc <stride_dequeue+0x24ce>
ffffffffc0205cda:	01c53023          	sd	t3,0(a0)
ffffffffc0205cde:	88f2                	mv	a7,t3
ffffffffc0205ce0:	7782                	ld	a5,32(sp)
ffffffffc0205ce2:	0119b423          	sd	a7,8(s3)
ffffffffc0205ce6:	00f9b823          	sd	a5,16(s3)
ffffffffc0205cea:	0138b023          	sd	s3,0(a7)
ffffffffc0205cee:	67e2                	ld	a5,24(sp)
ffffffffc0205cf0:	013db423          	sd	s3,8(s11)
ffffffffc0205cf4:	00fdb823          	sd	a5,16(s11)
ffffffffc0205cf8:	01b9b023          	sd	s11,0(s3)
ffffffffc0205cfc:	89da                	mv	s3,s6
ffffffffc0205cfe:	67c2                	ld	a5,16(sp)
ffffffffc0205d00:	01bcb423          	sd	s11,8(s9)
ffffffffc0205d04:	00fcb823          	sd	a5,16(s9)
ffffffffc0205d08:	019db023          	sd	s9,0(s11)
ffffffffc0205d0c:	8de6                	mv	s11,s9
ffffffffc0205d0e:	b9bd                	j	ffffffffc020598c <stride_dequeue+0x95e>
ffffffffc0205d10:	00893783          	ld	a5,8(s2)
ffffffffc0205d14:	01093883          	ld	a7,16(s2)
ffffffffc0205d18:	f02a                	sd	a0,32(sp)
ffffffffc0205d1a:	ec3e                	sd	a5,24(sp)
ffffffffc0205d1c:	06088c63          	beqz	a7,ffffffffc0205d94 <stride_dequeue+0xd66>
ffffffffc0205d20:	85c2                	mv	a1,a6
ffffffffc0205d22:	8546                	mv	a0,a7
ffffffffc0205d24:	f842                	sd	a6,48(sp)
ffffffffc0205d26:	f446                	sd	a7,40(sp)
ffffffffc0205d28:	8caff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205d2c:	7302                	ld	t1,32(sp)
ffffffffc0205d2e:	78a2                	ld	a7,40(sp)
ffffffffc0205d30:	7842                	ld	a6,48(sp)
ffffffffc0205d32:	2e650ee3          	beq	a0,t1,ffffffffc020682e <stride_dequeue+0x1800>
ffffffffc0205d36:	00883783          	ld	a5,8(a6)
ffffffffc0205d3a:	01083983          	ld	s3,16(a6)
ffffffffc0205d3e:	f41a                	sd	t1,40(sp)
ffffffffc0205d40:	f03e                	sd	a5,32(sp)
ffffffffc0205d42:	64098ee3          	beqz	s3,ffffffffc0206b9e <stride_dequeue+0x1b70>
ffffffffc0205d46:	8546                	mv	a0,a7
ffffffffc0205d48:	85ce                	mv	a1,s3
ffffffffc0205d4a:	fc42                	sd	a6,56(sp)
ffffffffc0205d4c:	f846                	sd	a7,48(sp)
ffffffffc0205d4e:	8a4ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205d52:	7322                	ld	t1,40(sp)
ffffffffc0205d54:	78c2                	ld	a7,48(sp)
ffffffffc0205d56:	7862                	ld	a6,56(sp)
ffffffffc0205d58:	00651463          	bne	a0,t1,ffffffffc0205d60 <stride_dequeue+0xd32>
ffffffffc0205d5c:	1e80106f          	j	ffffffffc0206f44 <stride_dequeue+0x1f16>
ffffffffc0205d60:	0109b583          	ld	a1,16(s3)
ffffffffc0205d64:	0089bb03          	ld	s6,8(s3)
ffffffffc0205d68:	8546                	mv	a0,a7
ffffffffc0205d6a:	f442                	sd	a6,40(sp)
ffffffffc0205d6c:	8e2ff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205d70:	00a9b423          	sd	a0,8(s3)
ffffffffc0205d74:	0169b823          	sd	s6,16(s3)
ffffffffc0205d78:	7822                	ld	a6,40(sp)
ffffffffc0205d7a:	010c2b03          	lw	s6,16(s8)
ffffffffc0205d7e:	c119                	beqz	a0,ffffffffc0205d84 <stride_dequeue+0xd56>
ffffffffc0205d80:	01353023          	sd	s3,0(a0)
ffffffffc0205d84:	7782                	ld	a5,32(sp)
ffffffffc0205d86:	01383423          	sd	s3,8(a6)
ffffffffc0205d8a:	00f83823          	sd	a5,16(a6)
ffffffffc0205d8e:	0109b023          	sd	a6,0(s3)
ffffffffc0205d92:	89da                	mv	s3,s6
ffffffffc0205d94:	67e2                	ld	a5,24(sp)
ffffffffc0205d96:	01093423          	sd	a6,8(s2)
ffffffffc0205d9a:	00f93823          	sd	a5,16(s2)
ffffffffc0205d9e:	01283023          	sd	s2,0(a6)
ffffffffc0205da2:	bf0ff06f          	j	ffffffffc0205192 <stride_dequeue+0x164>
ffffffffc0205da6:	008cb783          	ld	a5,8(s9)
ffffffffc0205daa:	010cb983          	ld	s3,16(s9)
ffffffffc0205dae:	ec2a                	sd	a0,24(sp)
ffffffffc0205db0:	e83e                	sd	a5,16(sp)
ffffffffc0205db2:	0a098763          	beqz	s3,ffffffffc0205e60 <stride_dequeue+0xe32>
ffffffffc0205db6:	85d2                	mv	a1,s4
ffffffffc0205db8:	854e                	mv	a0,s3
ffffffffc0205dba:	838ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205dbe:	6862                	ld	a6,24(sp)
ffffffffc0205dc0:	3b050fe3          	beq	a0,a6,ffffffffc020697e <stride_dequeue+0x1950>
ffffffffc0205dc4:	008a3783          	ld	a5,8(s4)
ffffffffc0205dc8:	010a3303          	ld	t1,16(s4)
ffffffffc0205dcc:	f042                	sd	a6,32(sp)
ffffffffc0205dce:	ec3e                	sd	a5,24(sp)
ffffffffc0205dd0:	08030163          	beqz	t1,ffffffffc0205e52 <stride_dequeue+0xe24>
ffffffffc0205dd4:	859a                	mv	a1,t1
ffffffffc0205dd6:	854e                	mv	a0,s3
ffffffffc0205dd8:	f41a                	sd	t1,40(sp)
ffffffffc0205dda:	818ff0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205dde:	7802                	ld	a6,32(sp)
ffffffffc0205de0:	7322                	ld	t1,40(sp)
ffffffffc0205de2:	01051463          	bne	a0,a6,ffffffffc0205dea <stride_dequeue+0xdbc>
ffffffffc0205de6:	3da0106f          	j	ffffffffc02071c0 <stride_dequeue+0x2192>
ffffffffc0205dea:	00833783          	ld	a5,8(t1)
ffffffffc0205dee:	01033e03          	ld	t3,16(t1)
ffffffffc0205df2:	fc42                	sd	a6,56(sp)
ffffffffc0205df4:	f03e                	sd	a5,32(sp)
ffffffffc0205df6:	040e0663          	beqz	t3,ffffffffc0205e42 <stride_dequeue+0xe14>
ffffffffc0205dfa:	85f2                	mv	a1,t3
ffffffffc0205dfc:	854e                	mv	a0,s3
ffffffffc0205dfe:	f81a                	sd	t1,48(sp)
ffffffffc0205e00:	f472                	sd	t3,40(sp)
ffffffffc0205e02:	ff1fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205e06:	7862                	ld	a6,56(sp)
ffffffffc0205e08:	7e22                	ld	t3,40(sp)
ffffffffc0205e0a:	7342                	ld	t1,48(sp)
ffffffffc0205e0c:	01051463          	bne	a0,a6,ffffffffc0205e14 <stride_dequeue+0xde6>
ffffffffc0205e10:	0c90106f          	j	ffffffffc02076d8 <stride_dequeue+0x26aa>
ffffffffc0205e14:	010e3583          	ld	a1,16(t3)
ffffffffc0205e18:	854e                	mv	a0,s3
ffffffffc0205e1a:	008e3b03          	ld	s6,8(t3)
ffffffffc0205e1e:	f81a                	sd	t1,48(sp)
ffffffffc0205e20:	f472                	sd	t3,40(sp)
ffffffffc0205e22:	82cff0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205e26:	7e22                	ld	t3,40(sp)
ffffffffc0205e28:	7342                	ld	t1,48(sp)
ffffffffc0205e2a:	016e3823          	sd	s6,16(t3)
ffffffffc0205e2e:	00ae3423          	sd	a0,8(t3)
ffffffffc0205e32:	010c2b03          	lw	s6,16(s8)
ffffffffc0205e36:	e119                	bnez	a0,ffffffffc0205e3c <stride_dequeue+0xe0e>
ffffffffc0205e38:	32d0106f          	j	ffffffffc0207964 <stride_dequeue+0x2936>
ffffffffc0205e3c:	01c53023          	sd	t3,0(a0)
ffffffffc0205e40:	89f2                	mv	s3,t3
ffffffffc0205e42:	7782                	ld	a5,32(sp)
ffffffffc0205e44:	01333423          	sd	s3,8(t1)
ffffffffc0205e48:	00f33823          	sd	a5,16(t1)
ffffffffc0205e4c:	0069b023          	sd	t1,0(s3)
ffffffffc0205e50:	899a                	mv	s3,t1
ffffffffc0205e52:	67e2                	ld	a5,24(sp)
ffffffffc0205e54:	013a3423          	sd	s3,8(s4)
ffffffffc0205e58:	00fa3823          	sd	a5,16(s4)
ffffffffc0205e5c:	0149b023          	sd	s4,0(s3)
ffffffffc0205e60:	67c2                	ld	a5,16(sp)
ffffffffc0205e62:	014cb423          	sd	s4,8(s9)
ffffffffc0205e66:	89da                	mv	s3,s6
ffffffffc0205e68:	00fcb823          	sd	a5,16(s9)
ffffffffc0205e6c:	019a3023          	sd	s9,0(s4)
ffffffffc0205e70:	f42ff06f          	j	ffffffffc02055b2 <stride_dequeue+0x584>
ffffffffc0205e74:	661c                	ld	a5,8(a2)
ffffffffc0205e76:	01063983          	ld	s3,16(a2)
ffffffffc0205e7a:	e82a                	sd	a0,16(sp)
ffffffffc0205e7c:	e43e                	sd	a5,8(sp)
ffffffffc0205e7e:	0a098f63          	beqz	s3,ffffffffc0205f3c <stride_dequeue+0xf0e>
ffffffffc0205e82:	85d2                	mv	a1,s4
ffffffffc0205e84:	854e                	mv	a0,s3
ffffffffc0205e86:	ec32                	sd	a2,24(sp)
ffffffffc0205e88:	f6bfe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205e8c:	6842                	ld	a6,16(sp)
ffffffffc0205e8e:	6662                	ld	a2,24(sp)
ffffffffc0205e90:	39050de3          	beq	a0,a6,ffffffffc0206a2a <stride_dequeue+0x19fc>
ffffffffc0205e94:	008a3783          	ld	a5,8(s4)
ffffffffc0205e98:	010a3303          	ld	t1,16(s4)
ffffffffc0205e9c:	ec42                	sd	a6,24(sp)
ffffffffc0205e9e:	e83e                	sd	a5,16(sp)
ffffffffc0205ea0:	08030763          	beqz	t1,ffffffffc0205f2e <stride_dequeue+0xf00>
ffffffffc0205ea4:	859a                	mv	a1,t1
ffffffffc0205ea6:	854e                	mv	a0,s3
ffffffffc0205ea8:	f432                	sd	a2,40(sp)
ffffffffc0205eaa:	f01a                	sd	t1,32(sp)
ffffffffc0205eac:	f47fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205eb0:	6862                	ld	a6,24(sp)
ffffffffc0205eb2:	7302                	ld	t1,32(sp)
ffffffffc0205eb4:	7622                	ld	a2,40(sp)
ffffffffc0205eb6:	01051463          	bne	a0,a6,ffffffffc0205ebe <stride_dequeue+0xe90>
ffffffffc0205eba:	5060106f          	j	ffffffffc02073c0 <stride_dequeue+0x2392>
ffffffffc0205ebe:	00833783          	ld	a5,8(t1)
ffffffffc0205ec2:	01033e03          	ld	t3,16(t1)
ffffffffc0205ec6:	fc42                	sd	a6,56(sp)
ffffffffc0205ec8:	ec3e                	sd	a5,24(sp)
ffffffffc0205eca:	040e0a63          	beqz	t3,ffffffffc0205f1e <stride_dequeue+0xef0>
ffffffffc0205ece:	85f2                	mv	a1,t3
ffffffffc0205ed0:	854e                	mv	a0,s3
ffffffffc0205ed2:	f81a                	sd	t1,48(sp)
ffffffffc0205ed4:	f432                	sd	a2,40(sp)
ffffffffc0205ed6:	f072                	sd	t3,32(sp)
ffffffffc0205ed8:	f1bfe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205edc:	7862                	ld	a6,56(sp)
ffffffffc0205ede:	7e02                	ld	t3,32(sp)
ffffffffc0205ee0:	7622                	ld	a2,40(sp)
ffffffffc0205ee2:	7342                	ld	t1,48(sp)
ffffffffc0205ee4:	01051463          	bne	a0,a6,ffffffffc0205eec <stride_dequeue+0xebe>
ffffffffc0205ee8:	1e10106f          	j	ffffffffc02078c8 <stride_dequeue+0x289a>
ffffffffc0205eec:	010e3583          	ld	a1,16(t3)
ffffffffc0205ef0:	854e                	mv	a0,s3
ffffffffc0205ef2:	008e3b03          	ld	s6,8(t3)
ffffffffc0205ef6:	f81a                	sd	t1,48(sp)
ffffffffc0205ef8:	f432                	sd	a2,40(sp)
ffffffffc0205efa:	f072                	sd	t3,32(sp)
ffffffffc0205efc:	f53fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205f00:	7e02                	ld	t3,32(sp)
ffffffffc0205f02:	7622                	ld	a2,40(sp)
ffffffffc0205f04:	7342                	ld	t1,48(sp)
ffffffffc0205f06:	016e3823          	sd	s6,16(t3)
ffffffffc0205f0a:	00ae3423          	sd	a0,8(t3)
ffffffffc0205f0e:	010c2b03          	lw	s6,16(s8)
ffffffffc0205f12:	e119                	bnez	a0,ffffffffc0205f18 <stride_dequeue+0xeea>
ffffffffc0205f14:	22d0106f          	j	ffffffffc0207940 <stride_dequeue+0x2912>
ffffffffc0205f18:	01c53023          	sd	t3,0(a0)
ffffffffc0205f1c:	89f2                	mv	s3,t3
ffffffffc0205f1e:	67e2                	ld	a5,24(sp)
ffffffffc0205f20:	01333423          	sd	s3,8(t1)
ffffffffc0205f24:	00f33823          	sd	a5,16(t1)
ffffffffc0205f28:	0069b023          	sd	t1,0(s3)
ffffffffc0205f2c:	899a                	mv	s3,t1
ffffffffc0205f2e:	67c2                	ld	a5,16(sp)
ffffffffc0205f30:	013a3423          	sd	s3,8(s4)
ffffffffc0205f34:	00fa3823          	sd	a5,16(s4)
ffffffffc0205f38:	0149b023          	sd	s4,0(s3)
ffffffffc0205f3c:	67a2                	ld	a5,8(sp)
ffffffffc0205f3e:	01463423          	sd	s4,8(a2)
ffffffffc0205f42:	89da                	mv	s3,s6
ffffffffc0205f44:	ea1c                	sd	a5,16(a2)
ffffffffc0205f46:	00ca3023          	sd	a2,0(s4)
ffffffffc0205f4a:	8a32                	mv	s4,a2
ffffffffc0205f4c:	f80ff06f          	j	ffffffffc02056cc <stride_dequeue+0x69e>
ffffffffc0205f50:	008a3783          	ld	a5,8(s4)
ffffffffc0205f54:	010a3983          	ld	s3,16(s4)
ffffffffc0205f58:	ec2a                	sd	a0,24(sp)
ffffffffc0205f5a:	e83e                	sd	a5,16(sp)
ffffffffc0205f5c:	0a098763          	beqz	s3,ffffffffc020600a <stride_dequeue+0xfdc>
ffffffffc0205f60:	85e6                	mv	a1,s9
ffffffffc0205f62:	854e                	mv	a0,s3
ffffffffc0205f64:	e8ffe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205f68:	6862                	ld	a6,24(sp)
ffffffffc0205f6a:	270505e3          	beq	a0,a6,ffffffffc02069d4 <stride_dequeue+0x19a6>
ffffffffc0205f6e:	008cb783          	ld	a5,8(s9)
ffffffffc0205f72:	010cb303          	ld	t1,16(s9)
ffffffffc0205f76:	f042                	sd	a6,32(sp)
ffffffffc0205f78:	ec3e                	sd	a5,24(sp)
ffffffffc0205f7a:	08030163          	beqz	t1,ffffffffc0205ffc <stride_dequeue+0xfce>
ffffffffc0205f7e:	859a                	mv	a1,t1
ffffffffc0205f80:	854e                	mv	a0,s3
ffffffffc0205f82:	f41a                	sd	t1,40(sp)
ffffffffc0205f84:	e6ffe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205f88:	7802                	ld	a6,32(sp)
ffffffffc0205f8a:	7322                	ld	t1,40(sp)
ffffffffc0205f8c:	01051463          	bne	a0,a6,ffffffffc0205f94 <stride_dequeue+0xf66>
ffffffffc0205f90:	4080106f          	j	ffffffffc0207398 <stride_dequeue+0x236a>
ffffffffc0205f94:	00833783          	ld	a5,8(t1)
ffffffffc0205f98:	01033e03          	ld	t3,16(t1)
ffffffffc0205f9c:	fc42                	sd	a6,56(sp)
ffffffffc0205f9e:	f03e                	sd	a5,32(sp)
ffffffffc0205fa0:	040e0663          	beqz	t3,ffffffffc0205fec <stride_dequeue+0xfbe>
ffffffffc0205fa4:	85f2                	mv	a1,t3
ffffffffc0205fa6:	854e                	mv	a0,s3
ffffffffc0205fa8:	f81a                	sd	t1,48(sp)
ffffffffc0205faa:	f472                	sd	t3,40(sp)
ffffffffc0205fac:	e47fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0205fb0:	7862                	ld	a6,56(sp)
ffffffffc0205fb2:	7e22                	ld	t3,40(sp)
ffffffffc0205fb4:	7342                	ld	t1,48(sp)
ffffffffc0205fb6:	01051463          	bne	a0,a6,ffffffffc0205fbe <stride_dequeue+0xf90>
ffffffffc0205fba:	6160106f          	j	ffffffffc02075d0 <stride_dequeue+0x25a2>
ffffffffc0205fbe:	010e3583          	ld	a1,16(t3)
ffffffffc0205fc2:	854e                	mv	a0,s3
ffffffffc0205fc4:	008e3b03          	ld	s6,8(t3)
ffffffffc0205fc8:	f81a                	sd	t1,48(sp)
ffffffffc0205fca:	f472                	sd	t3,40(sp)
ffffffffc0205fcc:	e83fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0205fd0:	7e22                	ld	t3,40(sp)
ffffffffc0205fd2:	7342                	ld	t1,48(sp)
ffffffffc0205fd4:	016e3823          	sd	s6,16(t3)
ffffffffc0205fd8:	00ae3423          	sd	a0,8(t3)
ffffffffc0205fdc:	010c2b03          	lw	s6,16(s8)
ffffffffc0205fe0:	e119                	bnez	a0,ffffffffc0205fe6 <stride_dequeue+0xfb8>
ffffffffc0205fe2:	1b30106f          	j	ffffffffc0207994 <stride_dequeue+0x2966>
ffffffffc0205fe6:	01c53023          	sd	t3,0(a0)
ffffffffc0205fea:	89f2                	mv	s3,t3
ffffffffc0205fec:	7782                	ld	a5,32(sp)
ffffffffc0205fee:	01333423          	sd	s3,8(t1)
ffffffffc0205ff2:	00f33823          	sd	a5,16(t1)
ffffffffc0205ff6:	0069b023          	sd	t1,0(s3)
ffffffffc0205ffa:	899a                	mv	s3,t1
ffffffffc0205ffc:	67e2                	ld	a5,24(sp)
ffffffffc0205ffe:	013cb423          	sd	s3,8(s9)
ffffffffc0206002:	00fcb823          	sd	a5,16(s9)
ffffffffc0206006:	0199b023          	sd	s9,0(s3)
ffffffffc020600a:	67c2                	ld	a5,16(sp)
ffffffffc020600c:	019a3423          	sd	s9,8(s4)
ffffffffc0206010:	89da                	mv	s3,s6
ffffffffc0206012:	00fa3823          	sd	a5,16(s4)
ffffffffc0206016:	014cb023          	sd	s4,0(s9)
ffffffffc020601a:	8cd2                	mv	s9,s4
ffffffffc020601c:	faeff06f          	j	ffffffffc02057ca <stride_dequeue+0x79c>
ffffffffc0206020:	0088b783          	ld	a5,8(a7)
ffffffffc0206024:	0108b983          	ld	s3,16(a7)
ffffffffc0206028:	f02a                	sd	a0,32(sp)
ffffffffc020602a:	ec3e                	sd	a5,24(sp)
ffffffffc020602c:	06098e63          	beqz	s3,ffffffffc02060a8 <stride_dequeue+0x107a>
ffffffffc0206030:	85e6                	mv	a1,s9
ffffffffc0206032:	854e                	mv	a0,s3
ffffffffc0206034:	f446                	sd	a7,40(sp)
ffffffffc0206036:	dbdfe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc020603a:	7302                	ld	t1,32(sp)
ffffffffc020603c:	78a2                	ld	a7,40(sp)
ffffffffc020603e:	486503e3          	beq	a0,t1,ffffffffc0206cc4 <stride_dequeue+0x1c96>
ffffffffc0206042:	008cb783          	ld	a5,8(s9)
ffffffffc0206046:	010cbe03          	ld	t3,16(s9)
ffffffffc020604a:	f41a                	sd	t1,40(sp)
ffffffffc020604c:	f03e                	sd	a5,32(sp)
ffffffffc020604e:	040e0663          	beqz	t3,ffffffffc020609a <stride_dequeue+0x106c>
ffffffffc0206052:	85f2                	mv	a1,t3
ffffffffc0206054:	854e                	mv	a0,s3
ffffffffc0206056:	fc46                	sd	a7,56(sp)
ffffffffc0206058:	f872                	sd	t3,48(sp)
ffffffffc020605a:	d99fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc020605e:	7322                	ld	t1,40(sp)
ffffffffc0206060:	7e42                	ld	t3,48(sp)
ffffffffc0206062:	78e2                	ld	a7,56(sp)
ffffffffc0206064:	00651463          	bne	a0,t1,ffffffffc020606c <stride_dequeue+0x103e>
ffffffffc0206068:	3040106f          	j	ffffffffc020736c <stride_dequeue+0x233e>
ffffffffc020606c:	010e3583          	ld	a1,16(t3)
ffffffffc0206070:	854e                	mv	a0,s3
ffffffffc0206072:	008e3b03          	ld	s6,8(t3)
ffffffffc0206076:	f846                	sd	a7,48(sp)
ffffffffc0206078:	f472                	sd	t3,40(sp)
ffffffffc020607a:	dd5fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020607e:	7e22                	ld	t3,40(sp)
ffffffffc0206080:	78c2                	ld	a7,48(sp)
ffffffffc0206082:	016e3823          	sd	s6,16(t3)
ffffffffc0206086:	00ae3423          	sd	a0,8(t3)
ffffffffc020608a:	010c2b03          	lw	s6,16(s8)
ffffffffc020608e:	e119                	bnez	a0,ffffffffc0206094 <stride_dequeue+0x1066>
ffffffffc0206090:	4540106f          	j	ffffffffc02074e4 <stride_dequeue+0x24b6>
ffffffffc0206094:	01c53023          	sd	t3,0(a0)
ffffffffc0206098:	89f2                	mv	s3,t3
ffffffffc020609a:	7782                	ld	a5,32(sp)
ffffffffc020609c:	013cb423          	sd	s3,8(s9)
ffffffffc02060a0:	00fcb823          	sd	a5,16(s9)
ffffffffc02060a4:	0199b023          	sd	s9,0(s3)
ffffffffc02060a8:	67e2                	ld	a5,24(sp)
ffffffffc02060aa:	0198b423          	sd	s9,8(a7)
ffffffffc02060ae:	89da                	mv	s3,s6
ffffffffc02060b0:	00f8b823          	sd	a5,16(a7)
ffffffffc02060b4:	011cb023          	sd	a7,0(s9)
ffffffffc02060b8:	8cc6                	mv	s9,a7
ffffffffc02060ba:	fdeff06f          	j	ffffffffc0205898 <stride_dequeue+0x86a>
ffffffffc02060be:	008cb783          	ld	a5,8(s9)
ffffffffc02060c2:	010cb983          	ld	s3,16(s9)
ffffffffc02060c6:	f02a                	sd	a0,32(sp)
ffffffffc02060c8:	ec3e                	sd	a5,24(sp)
ffffffffc02060ca:	06098e63          	beqz	s3,ffffffffc0206146 <stride_dequeue+0x1118>
ffffffffc02060ce:	85c2                	mv	a1,a6
ffffffffc02060d0:	854e                	mv	a0,s3
ffffffffc02060d2:	f442                	sd	a6,40(sp)
ffffffffc02060d4:	d1ffe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02060d8:	7302                	ld	t1,32(sp)
ffffffffc02060da:	7822                	ld	a6,40(sp)
ffffffffc02060dc:	446506e3          	beq	a0,t1,ffffffffc0206d28 <stride_dequeue+0x1cfa>
ffffffffc02060e0:	00883783          	ld	a5,8(a6)
ffffffffc02060e4:	01083e03          	ld	t3,16(a6)
ffffffffc02060e8:	f41a                	sd	t1,40(sp)
ffffffffc02060ea:	f03e                	sd	a5,32(sp)
ffffffffc02060ec:	040e0663          	beqz	t3,ffffffffc0206138 <stride_dequeue+0x110a>
ffffffffc02060f0:	85f2                	mv	a1,t3
ffffffffc02060f2:	854e                	mv	a0,s3
ffffffffc02060f4:	fc42                	sd	a6,56(sp)
ffffffffc02060f6:	f872                	sd	t3,48(sp)
ffffffffc02060f8:	cfbfe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02060fc:	7322                	ld	t1,40(sp)
ffffffffc02060fe:	7e42                	ld	t3,48(sp)
ffffffffc0206100:	7862                	ld	a6,56(sp)
ffffffffc0206102:	00651463          	bne	a0,t1,ffffffffc020610a <stride_dequeue+0x10dc>
ffffffffc0206106:	20e0106f          	j	ffffffffc0207314 <stride_dequeue+0x22e6>
ffffffffc020610a:	010e3583          	ld	a1,16(t3)
ffffffffc020610e:	854e                	mv	a0,s3
ffffffffc0206110:	008e3b03          	ld	s6,8(t3)
ffffffffc0206114:	f842                	sd	a6,48(sp)
ffffffffc0206116:	f472                	sd	t3,40(sp)
ffffffffc0206118:	d37fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020611c:	7e22                	ld	t3,40(sp)
ffffffffc020611e:	7842                	ld	a6,48(sp)
ffffffffc0206120:	016e3823          	sd	s6,16(t3)
ffffffffc0206124:	00ae3423          	sd	a0,8(t3)
ffffffffc0206128:	010c2b03          	lw	s6,16(s8)
ffffffffc020612c:	e119                	bnez	a0,ffffffffc0206132 <stride_dequeue+0x1104>
ffffffffc020612e:	3c80106f          	j	ffffffffc02074f6 <stride_dequeue+0x24c8>
ffffffffc0206132:	01c53023          	sd	t3,0(a0)
ffffffffc0206136:	89f2                	mv	s3,t3
ffffffffc0206138:	7782                	ld	a5,32(sp)
ffffffffc020613a:	01383423          	sd	s3,8(a6)
ffffffffc020613e:	00f83823          	sd	a5,16(a6)
ffffffffc0206142:	0109b023          	sd	a6,0(s3)
ffffffffc0206146:	67e2                	ld	a5,24(sp)
ffffffffc0206148:	010cb423          	sd	a6,8(s9)
ffffffffc020614c:	89da                	mv	s3,s6
ffffffffc020614e:	00fcb823          	sd	a5,16(s9)
ffffffffc0206152:	01983023          	sd	s9,0(a6)
ffffffffc0206156:	829ff06f          	j	ffffffffc020597e <stride_dequeue+0x950>
ffffffffc020615a:	008db783          	ld	a5,8(s11)
ffffffffc020615e:	010db983          	ld	s3,16(s11)
ffffffffc0206162:	f02a                	sd	a0,32(sp)
ffffffffc0206164:	ec3e                	sd	a5,24(sp)
ffffffffc0206166:	06098e63          	beqz	s3,ffffffffc02061e2 <stride_dequeue+0x11b4>
ffffffffc020616a:	85c2                	mv	a1,a6
ffffffffc020616c:	854e                	mv	a0,s3
ffffffffc020616e:	f442                	sd	a6,40(sp)
ffffffffc0206170:	c83fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206174:	7302                	ld	t1,32(sp)
ffffffffc0206176:	7822                	ld	a6,40(sp)
ffffffffc0206178:	466506e3          	beq	a0,t1,ffffffffc0206de4 <stride_dequeue+0x1db6>
ffffffffc020617c:	00883783          	ld	a5,8(a6)
ffffffffc0206180:	01083e03          	ld	t3,16(a6)
ffffffffc0206184:	f41a                	sd	t1,40(sp)
ffffffffc0206186:	f03e                	sd	a5,32(sp)
ffffffffc0206188:	040e0663          	beqz	t3,ffffffffc02061d4 <stride_dequeue+0x11a6>
ffffffffc020618c:	85f2                	mv	a1,t3
ffffffffc020618e:	854e                	mv	a0,s3
ffffffffc0206190:	fc42                	sd	a6,56(sp)
ffffffffc0206192:	f872                	sd	t3,48(sp)
ffffffffc0206194:	c5ffe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206198:	7322                	ld	t1,40(sp)
ffffffffc020619a:	7e42                	ld	t3,48(sp)
ffffffffc020619c:	7862                	ld	a6,56(sp)
ffffffffc020619e:	00651463          	bne	a0,t1,ffffffffc02061a6 <stride_dequeue+0x1178>
ffffffffc02061a2:	7490006f          	j	ffffffffc02070ea <stride_dequeue+0x20bc>
ffffffffc02061a6:	010e3583          	ld	a1,16(t3)
ffffffffc02061aa:	854e                	mv	a0,s3
ffffffffc02061ac:	008e3b03          	ld	s6,8(t3)
ffffffffc02061b0:	f842                	sd	a6,48(sp)
ffffffffc02061b2:	f472                	sd	t3,40(sp)
ffffffffc02061b4:	c9bfe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02061b8:	7e22                	ld	t3,40(sp)
ffffffffc02061ba:	7842                	ld	a6,48(sp)
ffffffffc02061bc:	016e3823          	sd	s6,16(t3)
ffffffffc02061c0:	00ae3423          	sd	a0,8(t3)
ffffffffc02061c4:	010c2b03          	lw	s6,16(s8)
ffffffffc02061c8:	e119                	bnez	a0,ffffffffc02061ce <stride_dequeue+0x11a0>
ffffffffc02061ca:	3260106f          	j	ffffffffc02074f0 <stride_dequeue+0x24c2>
ffffffffc02061ce:	01c53023          	sd	t3,0(a0)
ffffffffc02061d2:	89f2                	mv	s3,t3
ffffffffc02061d4:	7782                	ld	a5,32(sp)
ffffffffc02061d6:	01383423          	sd	s3,8(a6)
ffffffffc02061da:	00f83823          	sd	a5,16(a6)
ffffffffc02061de:	0109b023          	sd	a6,0(s3)
ffffffffc02061e2:	67e2                	ld	a5,24(sp)
ffffffffc02061e4:	010db423          	sd	a6,8(s11)
ffffffffc02061e8:	89da                	mv	s3,s6
ffffffffc02061ea:	00fdb823          	sd	a5,16(s11)
ffffffffc02061ee:	01b83023          	sd	s11,0(a6)
ffffffffc02061f2:	92aff06f          	j	ffffffffc020531c <stride_dequeue+0x2ee>
ffffffffc02061f6:	008db783          	ld	a5,8(s11)
ffffffffc02061fa:	010db983          	ld	s3,16(s11)
ffffffffc02061fe:	ec2a                	sd	a0,24(sp)
ffffffffc0206200:	e83e                	sd	a5,16(sp)
ffffffffc0206202:	08098263          	beqz	s3,ffffffffc0206286 <stride_dequeue+0x1258>
ffffffffc0206206:	85c2                	mv	a1,a6
ffffffffc0206208:	854e                	mv	a0,s3
ffffffffc020620a:	f432                	sd	a2,40(sp)
ffffffffc020620c:	f042                	sd	a6,32(sp)
ffffffffc020620e:	be5fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206212:	6362                	ld	t1,24(sp)
ffffffffc0206214:	7802                	ld	a6,32(sp)
ffffffffc0206216:	7622                	ld	a2,40(sp)
ffffffffc0206218:	426505e3          	beq	a0,t1,ffffffffc0206e42 <stride_dequeue+0x1e14>
ffffffffc020621c:	00883783          	ld	a5,8(a6)
ffffffffc0206220:	01083e03          	ld	t3,16(a6)
ffffffffc0206224:	f01a                	sd	t1,32(sp)
ffffffffc0206226:	ec3e                	sd	a5,24(sp)
ffffffffc0206228:	040e0863          	beqz	t3,ffffffffc0206278 <stride_dequeue+0x124a>
ffffffffc020622c:	85f2                	mv	a1,t3
ffffffffc020622e:	854e                	mv	a0,s3
ffffffffc0206230:	fc42                	sd	a6,56(sp)
ffffffffc0206232:	f832                	sd	a2,48(sp)
ffffffffc0206234:	f472                	sd	t3,40(sp)
ffffffffc0206236:	bbdfe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc020623a:	7302                	ld	t1,32(sp)
ffffffffc020623c:	7e22                	ld	t3,40(sp)
ffffffffc020623e:	7642                	ld	a2,48(sp)
ffffffffc0206240:	7862                	ld	a6,56(sp)
ffffffffc0206242:	60650fe3          	beq	a0,t1,ffffffffc0207060 <stride_dequeue+0x2032>
ffffffffc0206246:	010e3583          	ld	a1,16(t3)
ffffffffc020624a:	854e                	mv	a0,s3
ffffffffc020624c:	008e3b03          	ld	s6,8(t3)
ffffffffc0206250:	f842                	sd	a6,48(sp)
ffffffffc0206252:	f432                	sd	a2,40(sp)
ffffffffc0206254:	f072                	sd	t3,32(sp)
ffffffffc0206256:	bf9fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020625a:	7e02                	ld	t3,32(sp)
ffffffffc020625c:	7622                	ld	a2,40(sp)
ffffffffc020625e:	7842                	ld	a6,48(sp)
ffffffffc0206260:	016e3823          	sd	s6,16(t3)
ffffffffc0206264:	00ae3423          	sd	a0,8(t3)
ffffffffc0206268:	010c2b03          	lw	s6,16(s8)
ffffffffc020626c:	e119                	bnez	a0,ffffffffc0206272 <stride_dequeue+0x1244>
ffffffffc020626e:	2d60106f          	j	ffffffffc0207544 <stride_dequeue+0x2516>
ffffffffc0206272:	01c53023          	sd	t3,0(a0)
ffffffffc0206276:	89f2                	mv	s3,t3
ffffffffc0206278:	67e2                	ld	a5,24(sp)
ffffffffc020627a:	01383423          	sd	s3,8(a6)
ffffffffc020627e:	00f83823          	sd	a5,16(a6)
ffffffffc0206282:	0109b023          	sd	a6,0(s3)
ffffffffc0206286:	67c2                	ld	a5,16(sp)
ffffffffc0206288:	010db423          	sd	a6,8(s11)
ffffffffc020628c:	89da                	mv	s3,s6
ffffffffc020628e:	00fdb823          	sd	a5,16(s11)
ffffffffc0206292:	01b83023          	sd	s11,0(a6)
ffffffffc0206296:	9e0ff06f          	j	ffffffffc0205476 <stride_dequeue+0x448>
ffffffffc020629a:	00893703          	ld	a4,8(s2)
ffffffffc020629e:	01093983          	ld	s3,16(s2)
ffffffffc02062a2:	f42a                	sd	a0,40(sp)
ffffffffc02062a4:	f03a                	sd	a4,32(sp)
ffffffffc02062a6:	02098e63          	beqz	s3,ffffffffc02062e2 <stride_dequeue+0x12b4>
ffffffffc02062aa:	85be                	mv	a1,a5
ffffffffc02062ac:	854e                	mv	a0,s3
ffffffffc02062ae:	fc42                	sd	a6,56(sp)
ffffffffc02062b0:	f83e                	sd	a5,48(sp)
ffffffffc02062b2:	b41fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02062b6:	7e22                	ld	t3,40(sp)
ffffffffc02062b8:	77c2                	ld	a5,48(sp)
ffffffffc02062ba:	7862                	ld	a6,56(sp)
ffffffffc02062bc:	43c509e3          	beq	a0,t3,ffffffffc0206eee <stride_dequeue+0x1ec0>
ffffffffc02062c0:	6b8c                	ld	a1,16(a5)
ffffffffc02062c2:	854e                	mv	a0,s3
ffffffffc02062c4:	0087bb03          	ld	s6,8(a5)
ffffffffc02062c8:	f842                	sd	a6,48(sp)
ffffffffc02062ca:	f43e                	sd	a5,40(sp)
ffffffffc02062cc:	b83fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02062d0:	77a2                	ld	a5,40(sp)
ffffffffc02062d2:	7842                	ld	a6,48(sp)
ffffffffc02062d4:	0167b823          	sd	s6,16(a5)
ffffffffc02062d8:	e788                	sd	a0,8(a5)
ffffffffc02062da:	010c2b03          	lw	s6,16(s8)
ffffffffc02062de:	c111                	beqz	a0,ffffffffc02062e2 <stride_dequeue+0x12b4>
ffffffffc02062e0:	e11c                	sd	a5,0(a0)
ffffffffc02062e2:	7702                	ld	a4,32(sp)
ffffffffc02062e4:	00f93423          	sd	a5,8(s2)
ffffffffc02062e8:	89da                	mv	s3,s6
ffffffffc02062ea:	00e93823          	sd	a4,16(s2)
ffffffffc02062ee:	0127b023          	sd	s2,0(a5)
ffffffffc02062f2:	e91fe06f          	j	ffffffffc0205182 <stride_dequeue+0x154>
ffffffffc02062f6:	008a3783          	ld	a5,8(s4)
ffffffffc02062fa:	010a3983          	ld	s3,16(s4)
ffffffffc02062fe:	ec2a                	sd	a0,24(sp)
ffffffffc0206300:	e83e                	sd	a5,16(sp)
ffffffffc0206302:	5a098ce3          	beqz	s3,ffffffffc02070ba <stride_dequeue+0x208c>
ffffffffc0206306:	85a6                	mv	a1,s1
ffffffffc0206308:	854e                	mv	a0,s3
ffffffffc020630a:	ae9fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc020630e:	67e2                	ld	a5,24(sp)
ffffffffc0206310:	50f500e3          	beq	a0,a5,ffffffffc0207010 <stride_dequeue+0x1fe2>
ffffffffc0206314:	f43e                	sd	a5,40(sp)
ffffffffc0206316:	649c                	ld	a5,8(s1)
ffffffffc0206318:	0104b883          	ld	a7,16(s1)
ffffffffc020631c:	ec3e                	sd	a5,24(sp)
ffffffffc020631e:	04088263          	beqz	a7,ffffffffc0206362 <stride_dequeue+0x1334>
ffffffffc0206322:	85c6                	mv	a1,a7
ffffffffc0206324:	854e                	mv	a0,s3
ffffffffc0206326:	f046                	sd	a7,32(sp)
ffffffffc0206328:	acbfe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc020632c:	77a2                	ld	a5,40(sp)
ffffffffc020632e:	7882                	ld	a7,32(sp)
ffffffffc0206330:	00f51463          	bne	a0,a5,ffffffffc0206338 <stride_dequeue+0x130a>
ffffffffc0206334:	2160106f          	j	ffffffffc020754a <stride_dequeue+0x251c>
ffffffffc0206338:	0108b583          	ld	a1,16(a7)
ffffffffc020633c:	854e                	mv	a0,s3
ffffffffc020633e:	0088bb03          	ld	s6,8(a7)
ffffffffc0206342:	f046                	sd	a7,32(sp)
ffffffffc0206344:	b0bfe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206348:	7882                	ld	a7,32(sp)
ffffffffc020634a:	0168b823          	sd	s6,16(a7)
ffffffffc020634e:	00a8b423          	sd	a0,8(a7)
ffffffffc0206352:	010c2b03          	lw	s6,16(s8)
ffffffffc0206356:	e119                	bnez	a0,ffffffffc020635c <stride_dequeue+0x132e>
ffffffffc0206358:	56a0106f          	j	ffffffffc02078c2 <stride_dequeue+0x2894>
ffffffffc020635c:	01153023          	sd	a7,0(a0)
ffffffffc0206360:	89c6                	mv	s3,a7
ffffffffc0206362:	67e2                	ld	a5,24(sp)
ffffffffc0206364:	0134b423          	sd	s3,8(s1)
ffffffffc0206368:	e89c                	sd	a5,16(s1)
ffffffffc020636a:	0099b023          	sd	s1,0(s3)
ffffffffc020636e:	89a6                	mv	s3,s1
ffffffffc0206370:	67c2                	ld	a5,16(sp)
ffffffffc0206372:	013a3423          	sd	s3,8(s4)
ffffffffc0206376:	84d2                	mv	s1,s4
ffffffffc0206378:	00fa3823          	sd	a5,16(s4)
ffffffffc020637c:	0149b023          	sd	s4,0(s3)
ffffffffc0206380:	89da                	mv	s3,s6
ffffffffc0206382:	f00ff06f          	j	ffffffffc0205a82 <stride_dequeue+0xa54>
ffffffffc0206386:	0088b783          	ld	a5,8(a7)
ffffffffc020638a:	0108b983          	ld	s3,16(a7)
ffffffffc020638e:	f02a                	sd	a0,32(sp)
ffffffffc0206390:	ec3e                	sd	a5,24(sp)
ffffffffc0206392:	00099463          	bnez	s3,ffffffffc020639a <stride_dequeue+0x136c>
ffffffffc0206396:	0d40106f          	j	ffffffffc020746a <stride_dequeue+0x243c>
ffffffffc020639a:	85d2                	mv	a1,s4
ffffffffc020639c:	854e                	mv	a0,s3
ffffffffc020639e:	f446                	sd	a7,40(sp)
ffffffffc02063a0:	a53fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02063a4:	7302                	ld	t1,32(sp)
ffffffffc02063a6:	78a2                	ld	a7,40(sp)
ffffffffc02063a8:	00651463          	bne	a0,t1,ffffffffc02063b0 <stride_dequeue+0x1382>
ffffffffc02063ac:	06c0106f          	j	ffffffffc0207418 <stride_dequeue+0x23ea>
ffffffffc02063b0:	008a3783          	ld	a5,8(s4)
ffffffffc02063b4:	010a3e03          	ld	t3,16(s4)
ffffffffc02063b8:	fc1a                	sd	t1,56(sp)
ffffffffc02063ba:	f03e                	sd	a5,32(sp)
ffffffffc02063bc:	040e0663          	beqz	t3,ffffffffc0206408 <stride_dequeue+0x13da>
ffffffffc02063c0:	85f2                	mv	a1,t3
ffffffffc02063c2:	854e                	mv	a0,s3
ffffffffc02063c4:	f846                	sd	a7,48(sp)
ffffffffc02063c6:	f472                	sd	t3,40(sp)
ffffffffc02063c8:	a2bfe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02063cc:	7362                	ld	t1,56(sp)
ffffffffc02063ce:	7e22                	ld	t3,40(sp)
ffffffffc02063d0:	78c2                	ld	a7,48(sp)
ffffffffc02063d2:	00651463          	bne	a0,t1,ffffffffc02063da <stride_dequeue+0x13ac>
ffffffffc02063d6:	32e0106f          	j	ffffffffc0207704 <stride_dequeue+0x26d6>
ffffffffc02063da:	010e3583          	ld	a1,16(t3)
ffffffffc02063de:	854e                	mv	a0,s3
ffffffffc02063e0:	008e3b03          	ld	s6,8(t3)
ffffffffc02063e4:	f846                	sd	a7,48(sp)
ffffffffc02063e6:	f472                	sd	t3,40(sp)
ffffffffc02063e8:	a67fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02063ec:	7e22                	ld	t3,40(sp)
ffffffffc02063ee:	78c2                	ld	a7,48(sp)
ffffffffc02063f0:	016e3823          	sd	s6,16(t3)
ffffffffc02063f4:	00ae3423          	sd	a0,8(t3)
ffffffffc02063f8:	010c2b03          	lw	s6,16(s8)
ffffffffc02063fc:	e119                	bnez	a0,ffffffffc0206402 <stride_dequeue+0x13d4>
ffffffffc02063fe:	58a0106f          	j	ffffffffc0207988 <stride_dequeue+0x295a>
ffffffffc0206402:	01c53023          	sd	t3,0(a0)
ffffffffc0206406:	89f2                	mv	s3,t3
ffffffffc0206408:	7782                	ld	a5,32(sp)
ffffffffc020640a:	013a3423          	sd	s3,8(s4)
ffffffffc020640e:	00fa3823          	sd	a5,16(s4)
ffffffffc0206412:	0149b023          	sd	s4,0(s3)
ffffffffc0206416:	89d2                	mv	s3,s4
ffffffffc0206418:	67e2                	ld	a5,24(sp)
ffffffffc020641a:	0138b423          	sd	s3,8(a7)
ffffffffc020641e:	8a46                	mv	s4,a7
ffffffffc0206420:	00f8b823          	sd	a5,16(a7)
ffffffffc0206424:	0119b023          	sd	a7,0(s3)
ffffffffc0206428:	89da                	mv	s3,s6
ffffffffc020642a:	f28ff06f          	j	ffffffffc0205b52 <stride_dequeue+0xb24>
ffffffffc020642e:	0088b783          	ld	a5,8(a7)
ffffffffc0206432:	0108b983          	ld	s3,16(a7)
ffffffffc0206436:	f02a                	sd	a0,32(sp)
ffffffffc0206438:	ec3e                	sd	a5,24(sp)
ffffffffc020643a:	00099463          	bnez	s3,ffffffffc0206442 <stride_dequeue+0x1414>
ffffffffc020643e:	0320106f          	j	ffffffffc0207470 <stride_dequeue+0x2442>
ffffffffc0206442:	85ee                	mv	a1,s11
ffffffffc0206444:	854e                	mv	a0,s3
ffffffffc0206446:	f446                	sd	a7,40(sp)
ffffffffc0206448:	9abfe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc020644c:	7302                	ld	t1,32(sp)
ffffffffc020644e:	78a2                	ld	a7,40(sp)
ffffffffc0206450:	466508e3          	beq	a0,t1,ffffffffc02070c0 <stride_dequeue+0x2092>
ffffffffc0206454:	008db783          	ld	a5,8(s11)
ffffffffc0206458:	010dbe03          	ld	t3,16(s11)
ffffffffc020645c:	fc1a                	sd	t1,56(sp)
ffffffffc020645e:	f03e                	sd	a5,32(sp)
ffffffffc0206460:	040e0663          	beqz	t3,ffffffffc02064ac <stride_dequeue+0x147e>
ffffffffc0206464:	85f2                	mv	a1,t3
ffffffffc0206466:	854e                	mv	a0,s3
ffffffffc0206468:	f846                	sd	a7,48(sp)
ffffffffc020646a:	f472                	sd	t3,40(sp)
ffffffffc020646c:	987fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206470:	7362                	ld	t1,56(sp)
ffffffffc0206472:	7e22                	ld	t3,40(sp)
ffffffffc0206474:	78c2                	ld	a7,48(sp)
ffffffffc0206476:	00651463          	bne	a0,t1,ffffffffc020647e <stride_dequeue+0x1450>
ffffffffc020647a:	3120106f          	j	ffffffffc020778c <stride_dequeue+0x275e>
ffffffffc020647e:	010e3583          	ld	a1,16(t3)
ffffffffc0206482:	854e                	mv	a0,s3
ffffffffc0206484:	008e3b03          	ld	s6,8(t3)
ffffffffc0206488:	f846                	sd	a7,48(sp)
ffffffffc020648a:	f472                	sd	t3,40(sp)
ffffffffc020648c:	9c3fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206490:	7e22                	ld	t3,40(sp)
ffffffffc0206492:	78c2                	ld	a7,48(sp)
ffffffffc0206494:	016e3823          	sd	s6,16(t3)
ffffffffc0206498:	00ae3423          	sd	a0,8(t3)
ffffffffc020649c:	010c2b03          	lw	s6,16(s8)
ffffffffc02064a0:	e119                	bnez	a0,ffffffffc02064a6 <stride_dequeue+0x1478>
ffffffffc02064a2:	51c0106f          	j	ffffffffc02079be <stride_dequeue+0x2990>
ffffffffc02064a6:	01c53023          	sd	t3,0(a0)
ffffffffc02064aa:	89f2                	mv	s3,t3
ffffffffc02064ac:	7782                	ld	a5,32(sp)
ffffffffc02064ae:	013db423          	sd	s3,8(s11)
ffffffffc02064b2:	00fdb823          	sd	a5,16(s11)
ffffffffc02064b6:	01b9b023          	sd	s11,0(s3)
ffffffffc02064ba:	89ee                	mv	s3,s11
ffffffffc02064bc:	67e2                	ld	a5,24(sp)
ffffffffc02064be:	0138b423          	sd	s3,8(a7)
ffffffffc02064c2:	8dc6                	mv	s11,a7
ffffffffc02064c4:	00f8b823          	sd	a5,16(a7)
ffffffffc02064c8:	0119b023          	sd	a7,0(s3)
ffffffffc02064cc:	89da                	mv	s3,s6
ffffffffc02064ce:	831ff06f          	j	ffffffffc0205cfe <stride_dequeue+0xcd0>
ffffffffc02064d2:	0088b783          	ld	a5,8(a7)
ffffffffc02064d6:	0108b983          	ld	s3,16(a7)
ffffffffc02064da:	ec2a                	sd	a0,24(sp)
ffffffffc02064dc:	e83e                	sd	a5,16(sp)
ffffffffc02064de:	00099463          	bnez	s3,ffffffffc02064e6 <stride_dequeue+0x14b8>
ffffffffc02064e2:	7a10006f          	j	ffffffffc0207482 <stride_dequeue+0x2454>
ffffffffc02064e6:	85b2                	mv	a1,a2
ffffffffc02064e8:	854e                	mv	a0,s3
ffffffffc02064ea:	f446                	sd	a7,40(sp)
ffffffffc02064ec:	907fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02064f0:	6362                	ld	t1,24(sp)
ffffffffc02064f2:	7602                	ld	a2,32(sp)
ffffffffc02064f4:	78a2                	ld	a7,40(sp)
ffffffffc02064f6:	426500e3          	beq	a0,t1,ffffffffc0207116 <stride_dequeue+0x20e8>
ffffffffc02064fa:	661c                	ld	a5,8(a2)
ffffffffc02064fc:	01063e03          	ld	t3,16(a2)
ffffffffc0206500:	fc1a                	sd	t1,56(sp)
ffffffffc0206502:	ec3e                	sd	a5,24(sp)
ffffffffc0206504:	040e0a63          	beqz	t3,ffffffffc0206558 <stride_dequeue+0x152a>
ffffffffc0206508:	85f2                	mv	a1,t3
ffffffffc020650a:	854e                	mv	a0,s3
ffffffffc020650c:	f846                	sd	a7,48(sp)
ffffffffc020650e:	f432                	sd	a2,40(sp)
ffffffffc0206510:	f072                	sd	t3,32(sp)
ffffffffc0206512:	8e1fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206516:	7362                	ld	t1,56(sp)
ffffffffc0206518:	7e02                	ld	t3,32(sp)
ffffffffc020651a:	7622                	ld	a2,40(sp)
ffffffffc020651c:	78c2                	ld	a7,48(sp)
ffffffffc020651e:	00651463          	bne	a0,t1,ffffffffc0206526 <stride_dequeue+0x14f8>
ffffffffc0206522:	20e0106f          	j	ffffffffc0207730 <stride_dequeue+0x2702>
ffffffffc0206526:	010e3583          	ld	a1,16(t3)
ffffffffc020652a:	854e                	mv	a0,s3
ffffffffc020652c:	008e3b03          	ld	s6,8(t3)
ffffffffc0206530:	f846                	sd	a7,48(sp)
ffffffffc0206532:	f432                	sd	a2,40(sp)
ffffffffc0206534:	f072                	sd	t3,32(sp)
ffffffffc0206536:	919fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020653a:	7e02                	ld	t3,32(sp)
ffffffffc020653c:	7622                	ld	a2,40(sp)
ffffffffc020653e:	78c2                	ld	a7,48(sp)
ffffffffc0206540:	016e3823          	sd	s6,16(t3)
ffffffffc0206544:	00ae3423          	sd	a0,8(t3)
ffffffffc0206548:	010c2b03          	lw	s6,16(s8)
ffffffffc020654c:	e119                	bnez	a0,ffffffffc0206552 <stride_dequeue+0x1524>
ffffffffc020654e:	4400106f          	j	ffffffffc020798e <stride_dequeue+0x2960>
ffffffffc0206552:	01c53023          	sd	t3,0(a0)
ffffffffc0206556:	89f2                	mv	s3,t3
ffffffffc0206558:	67e2                	ld	a5,24(sp)
ffffffffc020655a:	01363423          	sd	s3,8(a2)
ffffffffc020655e:	ea1c                	sd	a5,16(a2)
ffffffffc0206560:	00c9b023          	sd	a2,0(s3)
ffffffffc0206564:	89b2                	mv	s3,a2
ffffffffc0206566:	67c2                	ld	a5,16(sp)
ffffffffc0206568:	0138b423          	sd	s3,8(a7)
ffffffffc020656c:	8646                	mv	a2,a7
ffffffffc020656e:	00f8b823          	sd	a5,16(a7)
ffffffffc0206572:	0119b023          	sd	a7,0(s3)
ffffffffc0206576:	89da                	mv	s3,s6
ffffffffc0206578:	eb6ff06f          	j	ffffffffc0205c2e <stride_dequeue+0xc00>
ffffffffc020657c:	008cb783          	ld	a5,8(s9)
ffffffffc0206580:	010cb983          	ld	s3,16(s9)
ffffffffc0206584:	f02a                	sd	a0,32(sp)
ffffffffc0206586:	ec3e                	sd	a5,24(sp)
ffffffffc0206588:	00099463          	bnez	s3,ffffffffc0206590 <stride_dequeue+0x1562>
ffffffffc020658c:	6eb0006f          	j	ffffffffc0207476 <stride_dequeue+0x2448>
ffffffffc0206590:	85c2                	mv	a1,a6
ffffffffc0206592:	854e                	mv	a0,s3
ffffffffc0206594:	f442                	sd	a6,40(sp)
ffffffffc0206596:	85dfe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc020659a:	7302                	ld	t1,32(sp)
ffffffffc020659c:	7822                	ld	a6,40(sp)
ffffffffc020659e:	3e650ee3          	beq	a0,t1,ffffffffc020719a <stride_dequeue+0x216c>
ffffffffc02065a2:	00883783          	ld	a5,8(a6)
ffffffffc02065a6:	01083e03          	ld	t3,16(a6)
ffffffffc02065aa:	fc1a                	sd	t1,56(sp)
ffffffffc02065ac:	f03e                	sd	a5,32(sp)
ffffffffc02065ae:	040e0663          	beqz	t3,ffffffffc02065fa <stride_dequeue+0x15cc>
ffffffffc02065b2:	85f2                	mv	a1,t3
ffffffffc02065b4:	854e                	mv	a0,s3
ffffffffc02065b6:	f842                	sd	a6,48(sp)
ffffffffc02065b8:	f472                	sd	t3,40(sp)
ffffffffc02065ba:	839fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02065be:	7362                	ld	t1,56(sp)
ffffffffc02065c0:	7e22                	ld	t3,40(sp)
ffffffffc02065c2:	7842                	ld	a6,48(sp)
ffffffffc02065c4:	00651463          	bne	a0,t1,ffffffffc02065cc <stride_dequeue+0x159e>
ffffffffc02065c8:	2a20106f          	j	ffffffffc020786a <stride_dequeue+0x283c>
ffffffffc02065cc:	010e3583          	ld	a1,16(t3)
ffffffffc02065d0:	854e                	mv	a0,s3
ffffffffc02065d2:	008e3b03          	ld	s6,8(t3)
ffffffffc02065d6:	f842                	sd	a6,48(sp)
ffffffffc02065d8:	f472                	sd	t3,40(sp)
ffffffffc02065da:	875fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02065de:	7e22                	ld	t3,40(sp)
ffffffffc02065e0:	7842                	ld	a6,48(sp)
ffffffffc02065e2:	016e3823          	sd	s6,16(t3)
ffffffffc02065e6:	00ae3423          	sd	a0,8(t3)
ffffffffc02065ea:	010c2b03          	lw	s6,16(s8)
ffffffffc02065ee:	e119                	bnez	a0,ffffffffc02065f4 <stride_dequeue+0x15c6>
ffffffffc02065f0:	35c0106f          	j	ffffffffc020794c <stride_dequeue+0x291e>
ffffffffc02065f4:	01c53023          	sd	t3,0(a0)
ffffffffc02065f8:	89f2                	mv	s3,t3
ffffffffc02065fa:	7782                	ld	a5,32(sp)
ffffffffc02065fc:	01383423          	sd	s3,8(a6)
ffffffffc0206600:	00f83823          	sd	a5,16(a6)
ffffffffc0206604:	0109b023          	sd	a6,0(s3)
ffffffffc0206608:	89c2                	mv	s3,a6
ffffffffc020660a:	67e2                	ld	a5,24(sp)
ffffffffc020660c:	013cb423          	sd	s3,8(s9)
ffffffffc0206610:	00fcb823          	sd	a5,16(s9)
ffffffffc0206614:	0199b023          	sd	s9,0(s3)
ffffffffc0206618:	89da                	mv	s3,s6
ffffffffc020661a:	f89fe06f          	j	ffffffffc02055a2 <stride_dequeue+0x574>
ffffffffc020661e:	661c                	ld	a5,8(a2)
ffffffffc0206620:	01063983          	ld	s3,16(a2)
ffffffffc0206624:	ec2a                	sd	a0,24(sp)
ffffffffc0206626:	e83e                	sd	a5,16(sp)
ffffffffc0206628:	64098ae3          	beqz	s3,ffffffffc020747c <stride_dequeue+0x244e>
ffffffffc020662c:	85c2                	mv	a1,a6
ffffffffc020662e:	854e                	mv	a0,s3
ffffffffc0206630:	f432                	sd	a2,40(sp)
ffffffffc0206632:	f042                	sd	a6,32(sp)
ffffffffc0206634:	fbefe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206638:	6362                	ld	t1,24(sp)
ffffffffc020663a:	7802                	ld	a6,32(sp)
ffffffffc020663c:	7622                	ld	a2,40(sp)
ffffffffc020663e:	326509e3          	beq	a0,t1,ffffffffc0207170 <stride_dequeue+0x2142>
ffffffffc0206642:	00883783          	ld	a5,8(a6)
ffffffffc0206646:	01083e03          	ld	t3,16(a6)
ffffffffc020664a:	fc1a                	sd	t1,56(sp)
ffffffffc020664c:	ec3e                	sd	a5,24(sp)
ffffffffc020664e:	040e0a63          	beqz	t3,ffffffffc02066a2 <stride_dequeue+0x1674>
ffffffffc0206652:	85f2                	mv	a1,t3
ffffffffc0206654:	854e                	mv	a0,s3
ffffffffc0206656:	f842                	sd	a6,48(sp)
ffffffffc0206658:	f432                	sd	a2,40(sp)
ffffffffc020665a:	f072                	sd	t3,32(sp)
ffffffffc020665c:	f96fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206660:	7362                	ld	t1,56(sp)
ffffffffc0206662:	7e02                	ld	t3,32(sp)
ffffffffc0206664:	7622                	ld	a2,40(sp)
ffffffffc0206666:	7842                	ld	a6,48(sp)
ffffffffc0206668:	00651463          	bne	a0,t1,ffffffffc0206670 <stride_dequeue+0x1642>
ffffffffc020666c:	1760106f          	j	ffffffffc02077e2 <stride_dequeue+0x27b4>
ffffffffc0206670:	010e3583          	ld	a1,16(t3)
ffffffffc0206674:	854e                	mv	a0,s3
ffffffffc0206676:	008e3b03          	ld	s6,8(t3)
ffffffffc020667a:	f842                	sd	a6,48(sp)
ffffffffc020667c:	f432                	sd	a2,40(sp)
ffffffffc020667e:	f072                	sd	t3,32(sp)
ffffffffc0206680:	fcefe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206684:	7e02                	ld	t3,32(sp)
ffffffffc0206686:	7622                	ld	a2,40(sp)
ffffffffc0206688:	7842                	ld	a6,48(sp)
ffffffffc020668a:	016e3823          	sd	s6,16(t3)
ffffffffc020668e:	00ae3423          	sd	a0,8(t3)
ffffffffc0206692:	010c2b03          	lw	s6,16(s8)
ffffffffc0206696:	e119                	bnez	a0,ffffffffc020669c <stride_dequeue+0x166e>
ffffffffc0206698:	32c0106f          	j	ffffffffc02079c4 <stride_dequeue+0x2996>
ffffffffc020669c:	01c53023          	sd	t3,0(a0)
ffffffffc02066a0:	89f2                	mv	s3,t3
ffffffffc02066a2:	67e2                	ld	a5,24(sp)
ffffffffc02066a4:	01383423          	sd	s3,8(a6)
ffffffffc02066a8:	00f83823          	sd	a5,16(a6)
ffffffffc02066ac:	0109b023          	sd	a6,0(s3)
ffffffffc02066b0:	89c2                	mv	s3,a6
ffffffffc02066b2:	67c2                	ld	a5,16(sp)
ffffffffc02066b4:	01363423          	sd	s3,8(a2)
ffffffffc02066b8:	ea1c                	sd	a5,16(a2)
ffffffffc02066ba:	00c9b023          	sd	a2,0(s3)
ffffffffc02066be:	89da                	mv	s3,s6
ffffffffc02066c0:	ffffe06f          	j	ffffffffc02056be <stride_dequeue+0x690>
ffffffffc02066c4:	008a3783          	ld	a5,8(s4)
ffffffffc02066c8:	010a3983          	ld	s3,16(s4)
ffffffffc02066cc:	f02a                	sd	a0,32(sp)
ffffffffc02066ce:	ec3e                	sd	a5,24(sp)
ffffffffc02066d0:	5a098ce3          	beqz	s3,ffffffffc0207488 <stride_dequeue+0x245a>
ffffffffc02066d4:	85c2                	mv	a1,a6
ffffffffc02066d6:	854e                	mv	a0,s3
ffffffffc02066d8:	f442                	sd	a6,40(sp)
ffffffffc02066da:	f18fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02066de:	7302                	ld	t1,32(sp)
ffffffffc02066e0:	7822                	ld	a6,40(sp)
ffffffffc02066e2:	566501e3          	beq	a0,t1,ffffffffc0207444 <stride_dequeue+0x2416>
ffffffffc02066e6:	00883783          	ld	a5,8(a6)
ffffffffc02066ea:	01083e03          	ld	t3,16(a6)
ffffffffc02066ee:	fc1a                	sd	t1,56(sp)
ffffffffc02066f0:	f03e                	sd	a5,32(sp)
ffffffffc02066f2:	040e0663          	beqz	t3,ffffffffc020673e <stride_dequeue+0x1710>
ffffffffc02066f6:	85f2                	mv	a1,t3
ffffffffc02066f8:	854e                	mv	a0,s3
ffffffffc02066fa:	f842                	sd	a6,48(sp)
ffffffffc02066fc:	f472                	sd	t3,40(sp)
ffffffffc02066fe:	ef4fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206702:	7362                	ld	t1,56(sp)
ffffffffc0206704:	7e22                	ld	t3,40(sp)
ffffffffc0206706:	7842                	ld	a6,48(sp)
ffffffffc0206708:	00651463          	bne	a0,t1,ffffffffc0206710 <stride_dequeue+0x16e2>
ffffffffc020670c:	18a0106f          	j	ffffffffc0207896 <stride_dequeue+0x2868>
ffffffffc0206710:	010e3583          	ld	a1,16(t3)
ffffffffc0206714:	854e                	mv	a0,s3
ffffffffc0206716:	008e3b03          	ld	s6,8(t3)
ffffffffc020671a:	f842                	sd	a6,48(sp)
ffffffffc020671c:	f472                	sd	t3,40(sp)
ffffffffc020671e:	f30fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206722:	7e22                	ld	t3,40(sp)
ffffffffc0206724:	7842                	ld	a6,48(sp)
ffffffffc0206726:	016e3823          	sd	s6,16(t3)
ffffffffc020672a:	00ae3423          	sd	a0,8(t3)
ffffffffc020672e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206732:	e119                	bnez	a0,ffffffffc0206738 <stride_dequeue+0x170a>
ffffffffc0206734:	1ee0106f          	j	ffffffffc0207922 <stride_dequeue+0x28f4>
ffffffffc0206738:	01c53023          	sd	t3,0(a0)
ffffffffc020673c:	89f2                	mv	s3,t3
ffffffffc020673e:	7782                	ld	a5,32(sp)
ffffffffc0206740:	01383423          	sd	s3,8(a6)
ffffffffc0206744:	00f83823          	sd	a5,16(a6)
ffffffffc0206748:	0109b023          	sd	a6,0(s3)
ffffffffc020674c:	89c2                	mv	s3,a6
ffffffffc020674e:	67e2                	ld	a5,24(sp)
ffffffffc0206750:	013a3423          	sd	s3,8(s4)
ffffffffc0206754:	00fa3823          	sd	a5,16(s4)
ffffffffc0206758:	0149b023          	sd	s4,0(s3)
ffffffffc020675c:	89da                	mv	s3,s6
ffffffffc020675e:	85eff06f          	j	ffffffffc02057bc <stride_dequeue+0x78e>
ffffffffc0206762:	008cb783          	ld	a5,8(s9)
ffffffffc0206766:	010cb983          	ld	s3,16(s9)
ffffffffc020676a:	f42a                	sd	a0,40(sp)
ffffffffc020676c:	f03e                	sd	a5,32(sp)
ffffffffc020676e:	04098163          	beqz	s3,ffffffffc02067b0 <stride_dequeue+0x1782>
ffffffffc0206772:	859a                	mv	a1,t1
ffffffffc0206774:	854e                	mv	a0,s3
ffffffffc0206776:	fc42                	sd	a6,56(sp)
ffffffffc0206778:	f81a                	sd	t1,48(sp)
ffffffffc020677a:	e78fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc020677e:	7e22                	ld	t3,40(sp)
ffffffffc0206780:	7342                	ld	t1,48(sp)
ffffffffc0206782:	7862                	ld	a6,56(sp)
ffffffffc0206784:	11c505e3          	beq	a0,t3,ffffffffc020708e <stride_dequeue+0x2060>
ffffffffc0206788:	01033583          	ld	a1,16(t1)
ffffffffc020678c:	854e                	mv	a0,s3
ffffffffc020678e:	00833b03          	ld	s6,8(t1)
ffffffffc0206792:	f842                	sd	a6,48(sp)
ffffffffc0206794:	f41a                	sd	t1,40(sp)
ffffffffc0206796:	eb8fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020679a:	7322                	ld	t1,40(sp)
ffffffffc020679c:	7842                	ld	a6,48(sp)
ffffffffc020679e:	01633823          	sd	s6,16(t1)
ffffffffc02067a2:	00a33423          	sd	a0,8(t1)
ffffffffc02067a6:	010c2b03          	lw	s6,16(s8)
ffffffffc02067aa:	c119                	beqz	a0,ffffffffc02067b0 <stride_dequeue+0x1782>
ffffffffc02067ac:	00653023          	sd	t1,0(a0)
ffffffffc02067b0:	7782                	ld	a5,32(sp)
ffffffffc02067b2:	006cb423          	sd	t1,8(s9)
ffffffffc02067b6:	89da                	mv	s3,s6
ffffffffc02067b8:	00fcb823          	sd	a5,16(s9)
ffffffffc02067bc:	01933023          	sd	s9,0(t1)
ffffffffc02067c0:	9aeff06f          	j	ffffffffc020596e <stride_dequeue+0x940>
ffffffffc02067c4:	008db783          	ld	a5,8(s11)
ffffffffc02067c8:	010db983          	ld	s3,16(s11)
ffffffffc02067cc:	f02a                	sd	a0,32(sp)
ffffffffc02067ce:	ec3e                	sd	a5,24(sp)
ffffffffc02067d0:	04098563          	beqz	s3,ffffffffc020681a <stride_dequeue+0x17ec>
ffffffffc02067d4:	859a                	mv	a1,t1
ffffffffc02067d6:	854e                	mv	a0,s3
ffffffffc02067d8:	fc42                	sd	a6,56(sp)
ffffffffc02067da:	f832                	sd	a2,48(sp)
ffffffffc02067dc:	f41a                	sd	t1,40(sp)
ffffffffc02067de:	e14fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02067e2:	7e02                	ld	t3,32(sp)
ffffffffc02067e4:	7322                	ld	t1,40(sp)
ffffffffc02067e6:	7642                	ld	a2,48(sp)
ffffffffc02067e8:	7862                	ld	a6,56(sp)
ffffffffc02067ea:	15c50be3          	beq	a0,t3,ffffffffc0207140 <stride_dequeue+0x2112>
ffffffffc02067ee:	01033583          	ld	a1,16(t1)
ffffffffc02067f2:	854e                	mv	a0,s3
ffffffffc02067f4:	00833b03          	ld	s6,8(t1)
ffffffffc02067f8:	f842                	sd	a6,48(sp)
ffffffffc02067fa:	f432                	sd	a2,40(sp)
ffffffffc02067fc:	f01a                	sd	t1,32(sp)
ffffffffc02067fe:	e50fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206802:	7302                	ld	t1,32(sp)
ffffffffc0206804:	7622                	ld	a2,40(sp)
ffffffffc0206806:	7842                	ld	a6,48(sp)
ffffffffc0206808:	01633823          	sd	s6,16(t1)
ffffffffc020680c:	00a33423          	sd	a0,8(t1)
ffffffffc0206810:	010c2b03          	lw	s6,16(s8)
ffffffffc0206814:	c119                	beqz	a0,ffffffffc020681a <stride_dequeue+0x17ec>
ffffffffc0206816:	00653023          	sd	t1,0(a0)
ffffffffc020681a:	67e2                	ld	a5,24(sp)
ffffffffc020681c:	006db423          	sd	t1,8(s11)
ffffffffc0206820:	89da                	mv	s3,s6
ffffffffc0206822:	00fdb823          	sd	a5,16(s11)
ffffffffc0206826:	01b33023          	sd	s11,0(t1)
ffffffffc020682a:	c3dfe06f          	j	ffffffffc0205466 <stride_dequeue+0x438>
ffffffffc020682e:	0088b783          	ld	a5,8(a7)
ffffffffc0206832:	0108b983          	ld	s3,16(a7)
ffffffffc0206836:	f42a                	sd	a0,40(sp)
ffffffffc0206838:	f03e                	sd	a5,32(sp)
ffffffffc020683a:	04098063          	beqz	s3,ffffffffc020687a <stride_dequeue+0x184c>
ffffffffc020683e:	85c2                	mv	a1,a6
ffffffffc0206840:	854e                	mv	a0,s3
ffffffffc0206842:	fc46                	sd	a7,56(sp)
ffffffffc0206844:	daefe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206848:	7e22                	ld	t3,40(sp)
ffffffffc020684a:	7842                	ld	a6,48(sp)
ffffffffc020684c:	78e2                	ld	a7,56(sp)
ffffffffc020684e:	29c50de3          	beq	a0,t3,ffffffffc02072e8 <stride_dequeue+0x22ba>
ffffffffc0206852:	01083583          	ld	a1,16(a6)
ffffffffc0206856:	854e                	mv	a0,s3
ffffffffc0206858:	00883b03          	ld	s6,8(a6)
ffffffffc020685c:	f846                	sd	a7,48(sp)
ffffffffc020685e:	f442                	sd	a6,40(sp)
ffffffffc0206860:	deefe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206864:	7822                	ld	a6,40(sp)
ffffffffc0206866:	78c2                	ld	a7,48(sp)
ffffffffc0206868:	01683823          	sd	s6,16(a6)
ffffffffc020686c:	00a83423          	sd	a0,8(a6)
ffffffffc0206870:	010c2b03          	lw	s6,16(s8)
ffffffffc0206874:	c119                	beqz	a0,ffffffffc020687a <stride_dequeue+0x184c>
ffffffffc0206876:	01053023          	sd	a6,0(a0)
ffffffffc020687a:	7782                	ld	a5,32(sp)
ffffffffc020687c:	0108b423          	sd	a6,8(a7)
ffffffffc0206880:	89da                	mv	s3,s6
ffffffffc0206882:	00f8b823          	sd	a5,16(a7)
ffffffffc0206886:	01183023          	sd	a7,0(a6)
ffffffffc020688a:	8846                	mv	a6,a7
ffffffffc020688c:	d08ff06f          	j	ffffffffc0205d94 <stride_dequeue+0xd66>
ffffffffc0206890:	008db783          	ld	a5,8(s11)
ffffffffc0206894:	010db983          	ld	s3,16(s11)
ffffffffc0206898:	f42a                	sd	a0,40(sp)
ffffffffc020689a:	f03e                	sd	a5,32(sp)
ffffffffc020689c:	04098163          	beqz	s3,ffffffffc02068de <stride_dequeue+0x18b0>
ffffffffc02068a0:	859a                	mv	a1,t1
ffffffffc02068a2:	854e                	mv	a0,s3
ffffffffc02068a4:	fc42                	sd	a6,56(sp)
ffffffffc02068a6:	f81a                	sd	t1,48(sp)
ffffffffc02068a8:	d4afe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02068ac:	7e22                	ld	t3,40(sp)
ffffffffc02068ae:	7342                	ld	t1,48(sp)
ffffffffc02068b0:	7862                	ld	a6,56(sp)
ffffffffc02068b2:	29c507e3          	beq	a0,t3,ffffffffc0207340 <stride_dequeue+0x2312>
ffffffffc02068b6:	01033583          	ld	a1,16(t1)
ffffffffc02068ba:	854e                	mv	a0,s3
ffffffffc02068bc:	00833b03          	ld	s6,8(t1)
ffffffffc02068c0:	f842                	sd	a6,48(sp)
ffffffffc02068c2:	f41a                	sd	t1,40(sp)
ffffffffc02068c4:	d8afe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02068c8:	7322                	ld	t1,40(sp)
ffffffffc02068ca:	7842                	ld	a6,48(sp)
ffffffffc02068cc:	01633823          	sd	s6,16(t1)
ffffffffc02068d0:	00a33423          	sd	a0,8(t1)
ffffffffc02068d4:	010c2b03          	lw	s6,16(s8)
ffffffffc02068d8:	c119                	beqz	a0,ffffffffc02068de <stride_dequeue+0x18b0>
ffffffffc02068da:	00653023          	sd	t1,0(a0)
ffffffffc02068de:	7782                	ld	a5,32(sp)
ffffffffc02068e0:	006db423          	sd	t1,8(s11)
ffffffffc02068e4:	89da                	mv	s3,s6
ffffffffc02068e6:	00fdb823          	sd	a5,16(s11)
ffffffffc02068ea:	01b33023          	sd	s11,0(t1)
ffffffffc02068ee:	a1ffe06f          	j	ffffffffc020530c <stride_dequeue+0x2de>
ffffffffc02068f2:	0088b783          	ld	a5,8(a7)
ffffffffc02068f6:	0108b983          	ld	s3,16(a7)
ffffffffc02068fa:	f42a                	sd	a0,40(sp)
ffffffffc02068fc:	f03e                	sd	a5,32(sp)
ffffffffc02068fe:	04098063          	beqz	s3,ffffffffc020693e <stride_dequeue+0x1910>
ffffffffc0206902:	859a                	mv	a1,t1
ffffffffc0206904:	854e                	mv	a0,s3
ffffffffc0206906:	fc46                	sd	a7,56(sp)
ffffffffc0206908:	ceafe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc020690c:	7e22                	ld	t3,40(sp)
ffffffffc020690e:	7342                	ld	t1,48(sp)
ffffffffc0206910:	78e2                	ld	a7,56(sp)
ffffffffc0206912:	73c50263          	beq	a0,t3,ffffffffc0207036 <stride_dequeue+0x2008>
ffffffffc0206916:	01033583          	ld	a1,16(t1)
ffffffffc020691a:	854e                	mv	a0,s3
ffffffffc020691c:	00833b03          	ld	s6,8(t1)
ffffffffc0206920:	f846                	sd	a7,48(sp)
ffffffffc0206922:	f41a                	sd	t1,40(sp)
ffffffffc0206924:	d2afe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206928:	7322                	ld	t1,40(sp)
ffffffffc020692a:	78c2                	ld	a7,48(sp)
ffffffffc020692c:	01633823          	sd	s6,16(t1)
ffffffffc0206930:	00a33423          	sd	a0,8(t1)
ffffffffc0206934:	010c2b03          	lw	s6,16(s8)
ffffffffc0206938:	c119                	beqz	a0,ffffffffc020693e <stride_dequeue+0x1910>
ffffffffc020693a:	00653023          	sd	t1,0(a0)
ffffffffc020693e:	7782                	ld	a5,32(sp)
ffffffffc0206940:	0068b423          	sd	t1,8(a7)
ffffffffc0206944:	89da                	mv	s3,s6
ffffffffc0206946:	00f8b823          	sd	a5,16(a7)
ffffffffc020694a:	01133023          	sd	a7,0(t1)
ffffffffc020694e:	f3dfe06f          	j	ffffffffc020588a <stride_dequeue+0x85c>
ffffffffc0206952:	01093503          	ld	a0,16(s2)
ffffffffc0206956:	00893983          	ld	s3,8(s2)
ffffffffc020695a:	85da                	mv	a1,s6
ffffffffc020695c:	cf2fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206960:	00a93423          	sd	a0,8(s2)
ffffffffc0206964:	01393823          	sd	s3,16(s2)
ffffffffc0206968:	7822                	ld	a6,40(sp)
ffffffffc020696a:	77c2                	ld	a5,48(sp)
ffffffffc020696c:	010c2983          	lw	s3,16(s8)
ffffffffc0206970:	e119                	bnez	a0,ffffffffc0206976 <stride_dequeue+0x1948>
ffffffffc0206972:	803fe06f          	j	ffffffffc0205174 <stride_dequeue+0x146>
ffffffffc0206976:	01253023          	sd	s2,0(a0)
ffffffffc020697a:	ffafe06f          	j	ffffffffc0205174 <stride_dequeue+0x146>
ffffffffc020697e:	0089b783          	ld	a5,8(s3)
ffffffffc0206982:	0109b803          	ld	a6,16(s3)
ffffffffc0206986:	f42a                	sd	a0,40(sp)
ffffffffc0206988:	ec3e                	sd	a5,24(sp)
ffffffffc020698a:	02080b63          	beqz	a6,ffffffffc02069c0 <stride_dequeue+0x1992>
ffffffffc020698e:	8542                	mv	a0,a6
ffffffffc0206990:	85d2                	mv	a1,s4
ffffffffc0206992:	f042                	sd	a6,32(sp)
ffffffffc0206994:	c5efe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206998:	77a2                	ld	a5,40(sp)
ffffffffc020699a:	7802                	ld	a6,32(sp)
ffffffffc020699c:	3cf50be3          	beq	a0,a5,ffffffffc0207572 <stride_dequeue+0x2544>
ffffffffc02069a0:	010a3583          	ld	a1,16(s4)
ffffffffc02069a4:	008a3b03          	ld	s6,8(s4)
ffffffffc02069a8:	8542                	mv	a0,a6
ffffffffc02069aa:	ca4fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02069ae:	00aa3423          	sd	a0,8(s4)
ffffffffc02069b2:	016a3823          	sd	s6,16(s4)
ffffffffc02069b6:	010c2b03          	lw	s6,16(s8)
ffffffffc02069ba:	c119                	beqz	a0,ffffffffc02069c0 <stride_dequeue+0x1992>
ffffffffc02069bc:	01453023          	sd	s4,0(a0)
ffffffffc02069c0:	67e2                	ld	a5,24(sp)
ffffffffc02069c2:	0149b423          	sd	s4,8(s3)
ffffffffc02069c6:	00f9b823          	sd	a5,16(s3)
ffffffffc02069ca:	013a3023          	sd	s3,0(s4)
ffffffffc02069ce:	8a4e                	mv	s4,s3
ffffffffc02069d0:	c90ff06f          	j	ffffffffc0205e60 <stride_dequeue+0xe32>
ffffffffc02069d4:	0089b783          	ld	a5,8(s3)
ffffffffc02069d8:	0109b803          	ld	a6,16(s3)
ffffffffc02069dc:	f42a                	sd	a0,40(sp)
ffffffffc02069de:	ec3e                	sd	a5,24(sp)
ffffffffc02069e0:	02080b63          	beqz	a6,ffffffffc0206a16 <stride_dequeue+0x19e8>
ffffffffc02069e4:	8542                	mv	a0,a6
ffffffffc02069e6:	85e6                	mv	a1,s9
ffffffffc02069e8:	f042                	sd	a6,32(sp)
ffffffffc02069ea:	c08fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc02069ee:	77a2                	ld	a5,40(sp)
ffffffffc02069f0:	7802                	ld	a6,32(sp)
ffffffffc02069f2:	28f50ee3          	beq	a0,a5,ffffffffc020748e <stride_dequeue+0x2460>
ffffffffc02069f6:	010cb583          	ld	a1,16(s9)
ffffffffc02069fa:	008cbb03          	ld	s6,8(s9)
ffffffffc02069fe:	8542                	mv	a0,a6
ffffffffc0206a00:	c4efe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206a04:	00acb423          	sd	a0,8(s9)
ffffffffc0206a08:	016cb823          	sd	s6,16(s9)
ffffffffc0206a0c:	010c2b03          	lw	s6,16(s8)
ffffffffc0206a10:	c119                	beqz	a0,ffffffffc0206a16 <stride_dequeue+0x19e8>
ffffffffc0206a12:	01953023          	sd	s9,0(a0)
ffffffffc0206a16:	67e2                	ld	a5,24(sp)
ffffffffc0206a18:	0199b423          	sd	s9,8(s3)
ffffffffc0206a1c:	00f9b823          	sd	a5,16(s3)
ffffffffc0206a20:	013cb023          	sd	s3,0(s9)
ffffffffc0206a24:	8cce                	mv	s9,s3
ffffffffc0206a26:	de4ff06f          	j	ffffffffc020600a <stride_dequeue+0xfdc>
ffffffffc0206a2a:	0089b783          	ld	a5,8(s3)
ffffffffc0206a2e:	0109b803          	ld	a6,16(s3)
ffffffffc0206a32:	f42a                	sd	a0,40(sp)
ffffffffc0206a34:	e83e                	sd	a5,16(sp)
ffffffffc0206a36:	02080f63          	beqz	a6,ffffffffc0206a74 <stride_dequeue+0x1a46>
ffffffffc0206a3a:	8542                	mv	a0,a6
ffffffffc0206a3c:	85d2                	mv	a1,s4
ffffffffc0206a3e:	f032                	sd	a2,32(sp)
ffffffffc0206a40:	ec42                	sd	a6,24(sp)
ffffffffc0206a42:	bb0fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206a46:	77a2                	ld	a5,40(sp)
ffffffffc0206a48:	6862                	ld	a6,24(sp)
ffffffffc0206a4a:	7602                	ld	a2,32(sp)
ffffffffc0206a4c:	26f506e3          	beq	a0,a5,ffffffffc02074b8 <stride_dequeue+0x248a>
ffffffffc0206a50:	010a3583          	ld	a1,16(s4)
ffffffffc0206a54:	008a3b03          	ld	s6,8(s4)
ffffffffc0206a58:	8542                	mv	a0,a6
ffffffffc0206a5a:	ec32                	sd	a2,24(sp)
ffffffffc0206a5c:	bf2fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206a60:	00aa3423          	sd	a0,8(s4)
ffffffffc0206a64:	016a3823          	sd	s6,16(s4)
ffffffffc0206a68:	6662                	ld	a2,24(sp)
ffffffffc0206a6a:	010c2b03          	lw	s6,16(s8)
ffffffffc0206a6e:	c119                	beqz	a0,ffffffffc0206a74 <stride_dequeue+0x1a46>
ffffffffc0206a70:	01453023          	sd	s4,0(a0)
ffffffffc0206a74:	67c2                	ld	a5,16(sp)
ffffffffc0206a76:	0149b423          	sd	s4,8(s3)
ffffffffc0206a7a:	00f9b823          	sd	a5,16(s3)
ffffffffc0206a7e:	013a3023          	sd	s3,0(s4)
ffffffffc0206a82:	8a4e                	mv	s4,s3
ffffffffc0206a84:	cb8ff06f          	j	ffffffffc0205f3c <stride_dequeue+0xf0e>
ffffffffc0206a88:	008a3783          	ld	a5,8(s4)
ffffffffc0206a8c:	010a3883          	ld	a7,16(s4)
ffffffffc0206a90:	f42a                	sd	a0,40(sp)
ffffffffc0206a92:	ec3e                	sd	a5,24(sp)
ffffffffc0206a94:	02088b63          	beqz	a7,ffffffffc0206aca <stride_dequeue+0x1a9c>
ffffffffc0206a98:	8546                	mv	a0,a7
ffffffffc0206a9a:	85ce                	mv	a1,s3
ffffffffc0206a9c:	f046                	sd	a7,32(sp)
ffffffffc0206a9e:	b54fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206aa2:	77a2                	ld	a5,40(sp)
ffffffffc0206aa4:	7882                	ld	a7,32(sp)
ffffffffc0206aa6:	26f501e3          	beq	a0,a5,ffffffffc0207508 <stride_dequeue+0x24da>
ffffffffc0206aaa:	0109b583          	ld	a1,16(s3)
ffffffffc0206aae:	0089bb03          	ld	s6,8(s3)
ffffffffc0206ab2:	8546                	mv	a0,a7
ffffffffc0206ab4:	b9afe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206ab8:	00a9b423          	sd	a0,8(s3)
ffffffffc0206abc:	0169b823          	sd	s6,16(s3)
ffffffffc0206ac0:	010c2b03          	lw	s6,16(s8)
ffffffffc0206ac4:	c119                	beqz	a0,ffffffffc0206aca <stride_dequeue+0x1a9c>
ffffffffc0206ac6:	01353023          	sd	s3,0(a0)
ffffffffc0206aca:	67e2                	ld	a5,24(sp)
ffffffffc0206acc:	013a3423          	sd	s3,8(s4)
ffffffffc0206ad0:	00fa3823          	sd	a5,16(s4)
ffffffffc0206ad4:	0149b023          	sd	s4,0(s3)
ffffffffc0206ad8:	89d2                	mv	s3,s4
ffffffffc0206ada:	f9bfe06f          	j	ffffffffc0205a74 <stride_dequeue+0xa46>
ffffffffc0206ade:	008a3783          	ld	a5,8(s4)
ffffffffc0206ae2:	010a3883          	ld	a7,16(s4)
ffffffffc0206ae6:	fc2a                	sd	a0,56(sp)
ffffffffc0206ae8:	f03e                	sd	a5,32(sp)
ffffffffc0206aea:	02088f63          	beqz	a7,ffffffffc0206b28 <stride_dequeue+0x1afa>
ffffffffc0206aee:	8546                	mv	a0,a7
ffffffffc0206af0:	85ce                	mv	a1,s3
ffffffffc0206af2:	f842                	sd	a6,48(sp)
ffffffffc0206af4:	f446                	sd	a7,40(sp)
ffffffffc0206af6:	afcfe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206afa:	7e62                	ld	t3,56(sp)
ffffffffc0206afc:	78a2                	ld	a7,40(sp)
ffffffffc0206afe:	7842                	ld	a6,48(sp)
ffffffffc0206b00:	35c509e3          	beq	a0,t3,ffffffffc0207652 <stride_dequeue+0x2624>
ffffffffc0206b04:	0109b583          	ld	a1,16(s3)
ffffffffc0206b08:	0089bb03          	ld	s6,8(s3)
ffffffffc0206b0c:	8546                	mv	a0,a7
ffffffffc0206b0e:	f442                	sd	a6,40(sp)
ffffffffc0206b10:	b3efe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206b14:	00a9b423          	sd	a0,8(s3)
ffffffffc0206b18:	0169b823          	sd	s6,16(s3)
ffffffffc0206b1c:	7822                	ld	a6,40(sp)
ffffffffc0206b1e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206b22:	c119                	beqz	a0,ffffffffc0206b28 <stride_dequeue+0x1afa>
ffffffffc0206b24:	01353023          	sd	s3,0(a0)
ffffffffc0206b28:	7782                	ld	a5,32(sp)
ffffffffc0206b2a:	013a3423          	sd	s3,8(s4)
ffffffffc0206b2e:	00fa3823          	sd	a5,16(s4)
ffffffffc0206b32:	0149b023          	sd	s4,0(s3)
ffffffffc0206b36:	89d2                	mv	s3,s4
ffffffffc0206b38:	c73fe06f          	j	ffffffffc02057aa <stride_dequeue+0x77c>
ffffffffc0206b3c:	661c                	ld	a5,8(a2)
ffffffffc0206b3e:	01063883          	ld	a7,16(a2)
ffffffffc0206b42:	fc2a                	sd	a0,56(sp)
ffffffffc0206b44:	ec3e                	sd	a5,24(sp)
ffffffffc0206b46:	04088363          	beqz	a7,ffffffffc0206b8c <stride_dequeue+0x1b5e>
ffffffffc0206b4a:	8546                	mv	a0,a7
ffffffffc0206b4c:	85ce                	mv	a1,s3
ffffffffc0206b4e:	f842                	sd	a6,48(sp)
ffffffffc0206b50:	f432                	sd	a2,40(sp)
ffffffffc0206b52:	f046                	sd	a7,32(sp)
ffffffffc0206b54:	a9efe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206b58:	7e62                	ld	t3,56(sp)
ffffffffc0206b5a:	7882                	ld	a7,32(sp)
ffffffffc0206b5c:	7622                	ld	a2,40(sp)
ffffffffc0206b5e:	7842                	ld	a6,48(sp)
ffffffffc0206b60:	25c501e3          	beq	a0,t3,ffffffffc02075a2 <stride_dequeue+0x2574>
ffffffffc0206b64:	0109b583          	ld	a1,16(s3)
ffffffffc0206b68:	0089bb03          	ld	s6,8(s3)
ffffffffc0206b6c:	8546                	mv	a0,a7
ffffffffc0206b6e:	f442                	sd	a6,40(sp)
ffffffffc0206b70:	f032                	sd	a2,32(sp)
ffffffffc0206b72:	adcfe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206b76:	00a9b423          	sd	a0,8(s3)
ffffffffc0206b7a:	0169b823          	sd	s6,16(s3)
ffffffffc0206b7e:	7602                	ld	a2,32(sp)
ffffffffc0206b80:	7822                	ld	a6,40(sp)
ffffffffc0206b82:	010c2b03          	lw	s6,16(s8)
ffffffffc0206b86:	c119                	beqz	a0,ffffffffc0206b8c <stride_dequeue+0x1b5e>
ffffffffc0206b88:	01353023          	sd	s3,0(a0)
ffffffffc0206b8c:	67e2                	ld	a5,24(sp)
ffffffffc0206b8e:	01363423          	sd	s3,8(a2)
ffffffffc0206b92:	ea1c                	sd	a5,16(a2)
ffffffffc0206b94:	00c9b023          	sd	a2,0(s3)
ffffffffc0206b98:	89b2                	mv	s3,a2
ffffffffc0206b9a:	b13fe06f          	j	ffffffffc02056ac <stride_dequeue+0x67e>
ffffffffc0206b9e:	89c6                	mv	s3,a7
ffffffffc0206ba0:	9e4ff06f          	j	ffffffffc0205d84 <stride_dequeue+0xd56>
ffffffffc0206ba4:	0088b783          	ld	a5,8(a7)
ffffffffc0206ba8:	0108b803          	ld	a6,16(a7)
ffffffffc0206bac:	fc2a                	sd	a0,56(sp)
ffffffffc0206bae:	f03e                	sd	a5,32(sp)
ffffffffc0206bb0:	02080f63          	beqz	a6,ffffffffc0206bee <stride_dequeue+0x1bc0>
ffffffffc0206bb4:	8542                	mv	a0,a6
ffffffffc0206bb6:	85ce                	mv	a1,s3
ffffffffc0206bb8:	f846                	sd	a7,48(sp)
ffffffffc0206bba:	f442                	sd	a6,40(sp)
ffffffffc0206bbc:	a36fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206bc0:	7e62                	ld	t3,56(sp)
ffffffffc0206bc2:	7822                	ld	a6,40(sp)
ffffffffc0206bc4:	78c2                	ld	a7,48(sp)
ffffffffc0206bc6:	47c50ce3          	beq	a0,t3,ffffffffc020783e <stride_dequeue+0x2810>
ffffffffc0206bca:	0109b583          	ld	a1,16(s3)
ffffffffc0206bce:	0089bb03          	ld	s6,8(s3)
ffffffffc0206bd2:	8542                	mv	a0,a6
ffffffffc0206bd4:	f446                	sd	a7,40(sp)
ffffffffc0206bd6:	a78fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206bda:	00a9b423          	sd	a0,8(s3)
ffffffffc0206bde:	0169b823          	sd	s6,16(s3)
ffffffffc0206be2:	78a2                	ld	a7,40(sp)
ffffffffc0206be4:	010c2b03          	lw	s6,16(s8)
ffffffffc0206be8:	c119                	beqz	a0,ffffffffc0206bee <stride_dequeue+0x1bc0>
ffffffffc0206bea:	01353023          	sd	s3,0(a0)
ffffffffc0206bee:	7782                	ld	a5,32(sp)
ffffffffc0206bf0:	0138b423          	sd	s3,8(a7)
ffffffffc0206bf4:	00f8b823          	sd	a5,16(a7)
ffffffffc0206bf8:	0119b023          	sd	a7,0(s3)
ffffffffc0206bfc:	89c6                	mv	s3,a7
ffffffffc0206bfe:	8f0ff06f          	j	ffffffffc0205cee <stride_dequeue+0xcc0>
ffffffffc0206c02:	0088b783          	ld	a5,8(a7)
ffffffffc0206c06:	0108b803          	ld	a6,16(a7)
ffffffffc0206c0a:	fc2a                	sd	a0,56(sp)
ffffffffc0206c0c:	f03e                	sd	a5,32(sp)
ffffffffc0206c0e:	02080f63          	beqz	a6,ffffffffc0206c4c <stride_dequeue+0x1c1e>
ffffffffc0206c12:	8542                	mv	a0,a6
ffffffffc0206c14:	85ce                	mv	a1,s3
ffffffffc0206c16:	f846                	sd	a7,48(sp)
ffffffffc0206c18:	f442                	sd	a6,40(sp)
ffffffffc0206c1a:	9d8fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206c1e:	7e62                	ld	t3,56(sp)
ffffffffc0206c20:	7822                	ld	a6,40(sp)
ffffffffc0206c22:	78c2                	ld	a7,48(sp)
ffffffffc0206c24:	25c50de3          	beq	a0,t3,ffffffffc020767e <stride_dequeue+0x2650>
ffffffffc0206c28:	0109b583          	ld	a1,16(s3)
ffffffffc0206c2c:	0089bb03          	ld	s6,8(s3)
ffffffffc0206c30:	8542                	mv	a0,a6
ffffffffc0206c32:	f446                	sd	a7,40(sp)
ffffffffc0206c34:	a1afe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206c38:	00a9b423          	sd	a0,8(s3)
ffffffffc0206c3c:	0169b823          	sd	s6,16(s3)
ffffffffc0206c40:	78a2                	ld	a7,40(sp)
ffffffffc0206c42:	010c2b03          	lw	s6,16(s8)
ffffffffc0206c46:	c119                	beqz	a0,ffffffffc0206c4c <stride_dequeue+0x1c1e>
ffffffffc0206c48:	01353023          	sd	s3,0(a0)
ffffffffc0206c4c:	7782                	ld	a5,32(sp)
ffffffffc0206c4e:	0138b423          	sd	s3,8(a7)
ffffffffc0206c52:	00f8b823          	sd	a5,16(a7)
ffffffffc0206c56:	0119b023          	sd	a7,0(s3)
ffffffffc0206c5a:	89c6                	mv	s3,a7
ffffffffc0206c5c:	ee7fe06f          	j	ffffffffc0205b42 <stride_dequeue+0xb14>
ffffffffc0206c60:	0088b783          	ld	a5,8(a7)
ffffffffc0206c64:	0108b803          	ld	a6,16(a7)
ffffffffc0206c68:	fc2a                	sd	a0,56(sp)
ffffffffc0206c6a:	ec3e                	sd	a5,24(sp)
ffffffffc0206c6c:	04080263          	beqz	a6,ffffffffc0206cb0 <stride_dequeue+0x1c82>
ffffffffc0206c70:	8542                	mv	a0,a6
ffffffffc0206c72:	85ce                	mv	a1,s3
ffffffffc0206c74:	f846                	sd	a7,48(sp)
ffffffffc0206c76:	f042                	sd	a6,32(sp)
ffffffffc0206c78:	97afe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206c7c:	7e62                	ld	t3,56(sp)
ffffffffc0206c7e:	7802                	ld	a6,32(sp)
ffffffffc0206c80:	7622                	ld	a2,40(sp)
ffffffffc0206c82:	78c2                	ld	a7,48(sp)
ffffffffc0206c84:	23c503e3          	beq	a0,t3,ffffffffc02076aa <stride_dequeue+0x267c>
ffffffffc0206c88:	0109b583          	ld	a1,16(s3)
ffffffffc0206c8c:	0089bb03          	ld	s6,8(s3)
ffffffffc0206c90:	8542                	mv	a0,a6
ffffffffc0206c92:	f446                	sd	a7,40(sp)
ffffffffc0206c94:	f032                	sd	a2,32(sp)
ffffffffc0206c96:	9b8fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206c9a:	00a9b423          	sd	a0,8(s3)
ffffffffc0206c9e:	0169b823          	sd	s6,16(s3)
ffffffffc0206ca2:	7602                	ld	a2,32(sp)
ffffffffc0206ca4:	78a2                	ld	a7,40(sp)
ffffffffc0206ca6:	010c2b03          	lw	s6,16(s8)
ffffffffc0206caa:	c119                	beqz	a0,ffffffffc0206cb0 <stride_dequeue+0x1c82>
ffffffffc0206cac:	01353023          	sd	s3,0(a0)
ffffffffc0206cb0:	67e2                	ld	a5,24(sp)
ffffffffc0206cb2:	0138b423          	sd	s3,8(a7)
ffffffffc0206cb6:	00f8b823          	sd	a5,16(a7)
ffffffffc0206cba:	0119b023          	sd	a7,0(s3)
ffffffffc0206cbe:	89c6                	mv	s3,a7
ffffffffc0206cc0:	f61fe06f          	j	ffffffffc0205c20 <stride_dequeue+0xbf2>
ffffffffc0206cc4:	0089b783          	ld	a5,8(s3)
ffffffffc0206cc8:	0109b303          	ld	t1,16(s3)
ffffffffc0206ccc:	fc2a                	sd	a0,56(sp)
ffffffffc0206cce:	f03e                	sd	a5,32(sp)
ffffffffc0206cd0:	02030f63          	beqz	t1,ffffffffc0206d0e <stride_dequeue+0x1ce0>
ffffffffc0206cd4:	851a                	mv	a0,t1
ffffffffc0206cd6:	85e6                	mv	a1,s9
ffffffffc0206cd8:	f846                	sd	a7,48(sp)
ffffffffc0206cda:	f41a                	sd	t1,40(sp)
ffffffffc0206cdc:	916fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206ce0:	7e62                	ld	t3,56(sp)
ffffffffc0206ce2:	7322                	ld	t1,40(sp)
ffffffffc0206ce4:	78c2                	ld	a7,48(sp)
ffffffffc0206ce6:	11c50be3          	beq	a0,t3,ffffffffc02075fc <stride_dequeue+0x25ce>
ffffffffc0206cea:	010cb583          	ld	a1,16(s9)
ffffffffc0206cee:	008cbb03          	ld	s6,8(s9)
ffffffffc0206cf2:	851a                	mv	a0,t1
ffffffffc0206cf4:	f446                	sd	a7,40(sp)
ffffffffc0206cf6:	958fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206cfa:	00acb423          	sd	a0,8(s9)
ffffffffc0206cfe:	016cb823          	sd	s6,16(s9)
ffffffffc0206d02:	78a2                	ld	a7,40(sp)
ffffffffc0206d04:	010c2b03          	lw	s6,16(s8)
ffffffffc0206d08:	c119                	beqz	a0,ffffffffc0206d0e <stride_dequeue+0x1ce0>
ffffffffc0206d0a:	01953023          	sd	s9,0(a0)
ffffffffc0206d0e:	7782                	ld	a5,32(sp)
ffffffffc0206d10:	0199b423          	sd	s9,8(s3)
ffffffffc0206d14:	00f9b823          	sd	a5,16(s3)
ffffffffc0206d18:	013cb023          	sd	s3,0(s9)
ffffffffc0206d1c:	8cce                	mv	s9,s3
ffffffffc0206d1e:	b8aff06f          	j	ffffffffc02060a8 <stride_dequeue+0x107a>
ffffffffc0206d22:	89ee                	mv	s3,s11
ffffffffc0206d24:	dd6fe06f          	j	ffffffffc02052fa <stride_dequeue+0x2cc>
ffffffffc0206d28:	0089b783          	ld	a5,8(s3)
ffffffffc0206d2c:	0109b303          	ld	t1,16(s3)
ffffffffc0206d30:	fc2a                	sd	a0,56(sp)
ffffffffc0206d32:	f03e                	sd	a5,32(sp)
ffffffffc0206d34:	02030f63          	beqz	t1,ffffffffc0206d72 <stride_dequeue+0x1d44>
ffffffffc0206d38:	85c2                	mv	a1,a6
ffffffffc0206d3a:	851a                	mv	a0,t1
ffffffffc0206d3c:	f842                	sd	a6,48(sp)
ffffffffc0206d3e:	f41a                	sd	t1,40(sp)
ffffffffc0206d40:	8b2fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206d44:	7e62                	ld	t3,56(sp)
ffffffffc0206d46:	7322                	ld	t1,40(sp)
ffffffffc0206d48:	7842                	ld	a6,48(sp)
ffffffffc0206d4a:	0dc50fe3          	beq	a0,t3,ffffffffc0207628 <stride_dequeue+0x25fa>
ffffffffc0206d4e:	01083583          	ld	a1,16(a6)
ffffffffc0206d52:	851a                	mv	a0,t1
ffffffffc0206d54:	00883b03          	ld	s6,8(a6)
ffffffffc0206d58:	f442                	sd	a6,40(sp)
ffffffffc0206d5a:	8f4fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206d5e:	7822                	ld	a6,40(sp)
ffffffffc0206d60:	01683823          	sd	s6,16(a6)
ffffffffc0206d64:	00a83423          	sd	a0,8(a6)
ffffffffc0206d68:	010c2b03          	lw	s6,16(s8)
ffffffffc0206d6c:	c119                	beqz	a0,ffffffffc0206d72 <stride_dequeue+0x1d44>
ffffffffc0206d6e:	01053023          	sd	a6,0(a0)
ffffffffc0206d72:	7782                	ld	a5,32(sp)
ffffffffc0206d74:	0109b423          	sd	a6,8(s3)
ffffffffc0206d78:	00f9b823          	sd	a5,16(s3)
ffffffffc0206d7c:	01383023          	sd	s3,0(a6)
ffffffffc0206d80:	884e                	mv	a6,s3
ffffffffc0206d82:	bc4ff06f          	j	ffffffffc0206146 <stride_dequeue+0x1118>
ffffffffc0206d86:	008cb783          	ld	a5,8(s9)
ffffffffc0206d8a:	010cb883          	ld	a7,16(s9)
ffffffffc0206d8e:	fc2a                	sd	a0,56(sp)
ffffffffc0206d90:	f03e                	sd	a5,32(sp)
ffffffffc0206d92:	02088f63          	beqz	a7,ffffffffc0206dd0 <stride_dequeue+0x1da2>
ffffffffc0206d96:	8546                	mv	a0,a7
ffffffffc0206d98:	85ce                	mv	a1,s3
ffffffffc0206d9a:	f842                	sd	a6,48(sp)
ffffffffc0206d9c:	f446                	sd	a7,40(sp)
ffffffffc0206d9e:	854fe0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206da2:	7e62                	ld	t3,56(sp)
ffffffffc0206da4:	78a2                	ld	a7,40(sp)
ffffffffc0206da6:	7842                	ld	a6,48(sp)
ffffffffc0206da8:	27c505e3          	beq	a0,t3,ffffffffc0207812 <stride_dequeue+0x27e4>
ffffffffc0206dac:	0109b583          	ld	a1,16(s3)
ffffffffc0206db0:	0089bb03          	ld	s6,8(s3)
ffffffffc0206db4:	8546                	mv	a0,a7
ffffffffc0206db6:	f442                	sd	a6,40(sp)
ffffffffc0206db8:	896fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206dbc:	00a9b423          	sd	a0,8(s3)
ffffffffc0206dc0:	0169b823          	sd	s6,16(s3)
ffffffffc0206dc4:	7822                	ld	a6,40(sp)
ffffffffc0206dc6:	010c2b03          	lw	s6,16(s8)
ffffffffc0206dca:	c119                	beqz	a0,ffffffffc0206dd0 <stride_dequeue+0x1da2>
ffffffffc0206dcc:	01353023          	sd	s3,0(a0)
ffffffffc0206dd0:	7782                	ld	a5,32(sp)
ffffffffc0206dd2:	013cb423          	sd	s3,8(s9)
ffffffffc0206dd6:	00fcb823          	sd	a5,16(s9)
ffffffffc0206dda:	0199b023          	sd	s9,0(s3)
ffffffffc0206dde:	89e6                	mv	s3,s9
ffffffffc0206de0:	fb0fe06f          	j	ffffffffc0205590 <stride_dequeue+0x562>
ffffffffc0206de4:	0089b783          	ld	a5,8(s3)
ffffffffc0206de8:	0109b303          	ld	t1,16(s3)
ffffffffc0206dec:	fc2a                	sd	a0,56(sp)
ffffffffc0206dee:	f03e                	sd	a5,32(sp)
ffffffffc0206df0:	02030f63          	beqz	t1,ffffffffc0206e2e <stride_dequeue+0x1e00>
ffffffffc0206df4:	85c2                	mv	a1,a6
ffffffffc0206df6:	851a                	mv	a0,t1
ffffffffc0206df8:	f842                	sd	a6,48(sp)
ffffffffc0206dfa:	f41a                	sd	t1,40(sp)
ffffffffc0206dfc:	ff7fd0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206e00:	7e62                	ld	t3,56(sp)
ffffffffc0206e02:	7322                	ld	t1,40(sp)
ffffffffc0206e04:	7842                	ld	a6,48(sp)
ffffffffc0206e06:	1bc509e3          	beq	a0,t3,ffffffffc02077b8 <stride_dequeue+0x278a>
ffffffffc0206e0a:	01083583          	ld	a1,16(a6)
ffffffffc0206e0e:	851a                	mv	a0,t1
ffffffffc0206e10:	00883b03          	ld	s6,8(a6)
ffffffffc0206e14:	f442                	sd	a6,40(sp)
ffffffffc0206e16:	838fe0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206e1a:	7822                	ld	a6,40(sp)
ffffffffc0206e1c:	01683823          	sd	s6,16(a6)
ffffffffc0206e20:	00a83423          	sd	a0,8(a6)
ffffffffc0206e24:	010c2b03          	lw	s6,16(s8)
ffffffffc0206e28:	c119                	beqz	a0,ffffffffc0206e2e <stride_dequeue+0x1e00>
ffffffffc0206e2a:	01053023          	sd	a6,0(a0)
ffffffffc0206e2e:	7782                	ld	a5,32(sp)
ffffffffc0206e30:	0109b423          	sd	a6,8(s3)
ffffffffc0206e34:	00f9b823          	sd	a5,16(s3)
ffffffffc0206e38:	01383023          	sd	s3,0(a6)
ffffffffc0206e3c:	884e                	mv	a6,s3
ffffffffc0206e3e:	ba4ff06f          	j	ffffffffc02061e2 <stride_dequeue+0x11b4>
ffffffffc0206e42:	0089b783          	ld	a5,8(s3)
ffffffffc0206e46:	0109b303          	ld	t1,16(s3)
ffffffffc0206e4a:	fc2a                	sd	a0,56(sp)
ffffffffc0206e4c:	ec3e                	sd	a5,24(sp)
ffffffffc0206e4e:	04030363          	beqz	t1,ffffffffc0206e94 <stride_dequeue+0x1e66>
ffffffffc0206e52:	85c2                	mv	a1,a6
ffffffffc0206e54:	851a                	mv	a0,t1
ffffffffc0206e56:	f832                	sd	a2,48(sp)
ffffffffc0206e58:	f442                	sd	a6,40(sp)
ffffffffc0206e5a:	f01a                	sd	t1,32(sp)
ffffffffc0206e5c:	f97fd0ef          	jal	ra,ffffffffc0204df2 <proc_stride_comp_f>
ffffffffc0206e60:	7642                	ld	a2,48(sp)
ffffffffc0206e62:	7e62                	ld	t3,56(sp)
ffffffffc0206e64:	7822                	ld	a6,40(sp)
ffffffffc0206e66:	f432                	sd	a2,40(sp)
ffffffffc0206e68:	7302                	ld	t1,32(sp)
ffffffffc0206e6a:	29c507e3          	beq	a0,t3,ffffffffc02078f8 <stride_dequeue+0x28ca>
ffffffffc0206e6e:	01083583          	ld	a1,16(a6)
ffffffffc0206e72:	851a                	mv	a0,t1
ffffffffc0206e74:	00883b03          	ld	s6,8(a6)
ffffffffc0206e78:	f042                	sd	a6,32(sp)
ffffffffc0206e7a:	fd5fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206e7e:	7802                	ld	a6,32(sp)
ffffffffc0206e80:	7622                	ld	a2,40(sp)
ffffffffc0206e82:	01683823          	sd	s6,16(a6)
ffffffffc0206e86:	00a83423          	sd	a0,8(a6)
ffffffffc0206e8a:	010c2b03          	lw	s6,16(s8)
ffffffffc0206e8e:	c119                	beqz	a0,ffffffffc0206e94 <stride_dequeue+0x1e66>
ffffffffc0206e90:	01053023          	sd	a6,0(a0)
ffffffffc0206e94:	67e2                	ld	a5,24(sp)
ffffffffc0206e96:	0109b423          	sd	a6,8(s3)
ffffffffc0206e9a:	00f9b823          	sd	a5,16(s3)
ffffffffc0206e9e:	01383023          	sd	s3,0(a6)
ffffffffc0206ea2:	884e                	mv	a6,s3
ffffffffc0206ea4:	be2ff06f          	j	ffffffffc0206286 <stride_dequeue+0x1258>
ffffffffc0206ea8:	89c6                	mv	s3,a7
ffffffffc0206eaa:	9cffe06f          	j	ffffffffc0205878 <stride_dequeue+0x84a>
ffffffffc0206eae:	89e6                	mv	s3,s9
ffffffffc0206eb0:	aadfe06f          	j	ffffffffc020595c <stride_dequeue+0x92e>
ffffffffc0206eb4:	89ee                	mv	s3,s11
ffffffffc0206eb6:	d9efe06f          	j	ffffffffc0205454 <stride_dequeue+0x426>
ffffffffc0206eba:	89d2                	mv	s3,s4
ffffffffc0206ebc:	bb9fe06f          	j	ffffffffc0205a74 <stride_dequeue+0xa46>
ffffffffc0206ec0:	0108b503          	ld	a0,16(a7)
ffffffffc0206ec4:	85ce                	mv	a1,s3
ffffffffc0206ec6:	0088bb03          	ld	s6,8(a7)
ffffffffc0206eca:	f81a                	sd	t1,48(sp)
ffffffffc0206ecc:	f446                	sd	a7,40(sp)
ffffffffc0206ece:	f81fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206ed2:	78a2                	ld	a7,40(sp)
ffffffffc0206ed4:	7342                	ld	t1,48(sp)
ffffffffc0206ed6:	0168b823          	sd	s6,16(a7)
ffffffffc0206eda:	00a8b423          	sd	a0,8(a7)
ffffffffc0206ede:	010c2b03          	lw	s6,16(s8)
ffffffffc0206ee2:	d179                	beqz	a0,ffffffffc0206ea8 <stride_dequeue+0x1e7a>
ffffffffc0206ee4:	01153023          	sd	a7,0(a0)
ffffffffc0206ee8:	89c6                	mv	s3,a7
ffffffffc0206eea:	98ffe06f          	j	ffffffffc0205878 <stride_dequeue+0x84a>
ffffffffc0206eee:	0109b503          	ld	a0,16(s3)
ffffffffc0206ef2:	0089bb03          	ld	s6,8(s3)
ffffffffc0206ef6:	85be                	mv	a1,a5
ffffffffc0206ef8:	f442                	sd	a6,40(sp)
ffffffffc0206efa:	f55fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206efe:	00a9b423          	sd	a0,8(s3)
ffffffffc0206f02:	0169b823          	sd	s6,16(s3)
ffffffffc0206f06:	7822                	ld	a6,40(sp)
ffffffffc0206f08:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f0c:	5e050b63          	beqz	a0,ffffffffc0207502 <stride_dequeue+0x24d4>
ffffffffc0206f10:	01353023          	sd	s3,0(a0)
ffffffffc0206f14:	87ce                	mv	a5,s3
ffffffffc0206f16:	bccff06f          	j	ffffffffc02062e2 <stride_dequeue+0x12b4>
ffffffffc0206f1a:	010cb503          	ld	a0,16(s9)
ffffffffc0206f1e:	008cbb03          	ld	s6,8(s9)
ffffffffc0206f22:	85ce                	mv	a1,s3
ffffffffc0206f24:	f2bfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206f28:	00acb423          	sd	a0,8(s9)
ffffffffc0206f2c:	016cb823          	sd	s6,16(s9)
ffffffffc0206f30:	7822                	ld	a6,40(sp)
ffffffffc0206f32:	7342                	ld	t1,48(sp)
ffffffffc0206f34:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f38:	d93d                	beqz	a0,ffffffffc0206eae <stride_dequeue+0x1e80>
ffffffffc0206f3a:	01953023          	sd	s9,0(a0)
ffffffffc0206f3e:	89e6                	mv	s3,s9
ffffffffc0206f40:	a1dfe06f          	j	ffffffffc020595c <stride_dequeue+0x92e>
ffffffffc0206f44:	0108b503          	ld	a0,16(a7)
ffffffffc0206f48:	85ce                	mv	a1,s3
ffffffffc0206f4a:	0088bb03          	ld	s6,8(a7)
ffffffffc0206f4e:	f842                	sd	a6,48(sp)
ffffffffc0206f50:	f446                	sd	a7,40(sp)
ffffffffc0206f52:	efdfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206f56:	78a2                	ld	a7,40(sp)
ffffffffc0206f58:	7842                	ld	a6,48(sp)
ffffffffc0206f5a:	0168b823          	sd	s6,16(a7)
ffffffffc0206f5e:	00a8b423          	sd	a0,8(a7)
ffffffffc0206f62:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f66:	c2050ce3          	beqz	a0,ffffffffc0206b9e <stride_dequeue+0x1b70>
ffffffffc0206f6a:	01153023          	sd	a7,0(a0)
ffffffffc0206f6e:	89c6                	mv	s3,a7
ffffffffc0206f70:	e15fe06f          	j	ffffffffc0205d84 <stride_dequeue+0xd56>
ffffffffc0206f74:	010db503          	ld	a0,16(s11)
ffffffffc0206f78:	008dbb03          	ld	s6,8(s11)
ffffffffc0206f7c:	85ce                	mv	a1,s3
ffffffffc0206f7e:	ed1fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206f82:	00adb423          	sd	a0,8(s11)
ffffffffc0206f86:	016db823          	sd	s6,16(s11)
ffffffffc0206f8a:	7602                	ld	a2,32(sp)
ffffffffc0206f8c:	7822                	ld	a6,40(sp)
ffffffffc0206f8e:	7342                	ld	t1,48(sp)
ffffffffc0206f90:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f94:	d105                	beqz	a0,ffffffffc0206eb4 <stride_dequeue+0x1e86>
ffffffffc0206f96:	01b53023          	sd	s11,0(a0)
ffffffffc0206f9a:	89ee                	mv	s3,s11
ffffffffc0206f9c:	cb8fe06f          	j	ffffffffc0205454 <stride_dequeue+0x426>
ffffffffc0206fa0:	010db503          	ld	a0,16(s11)
ffffffffc0206fa4:	008dbb03          	ld	s6,8(s11)
ffffffffc0206fa8:	85ce                	mv	a1,s3
ffffffffc0206faa:	ea5fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0206fae:	00adb423          	sd	a0,8(s11)
ffffffffc0206fb2:	016db823          	sd	s6,16(s11)
ffffffffc0206fb6:	7322                	ld	t1,40(sp)
ffffffffc0206fb8:	7842                	ld	a6,48(sp)
ffffffffc0206fba:	010c2b03          	lw	s6,16(s8)
ffffffffc0206fbe:	d60502e3          	beqz	a0,ffffffffc0206d22 <stride_dequeue+0x1cf4>
ffffffffc0206fc2:	01b53023          	sd	s11,0(a0)
ffffffffc0206fc6:	89ee                	mv	s3,s11
ffffffffc0206fc8:	b32fe06f          	j	ffffffffc02052fa <stride_dequeue+0x2cc>
ffffffffc0206fcc:	89e6                	mv	s3,s9
ffffffffc0206fce:	dc2fe06f          	j	ffffffffc0205590 <stride_dequeue+0x562>
ffffffffc0206fd2:	89c6                	mv	s3,a7
ffffffffc0206fd4:	d1bfe06f          	j	ffffffffc0205cee <stride_dequeue+0xcc0>
ffffffffc0206fd8:	00003697          	auipc	a3,0x3
ffffffffc0206fdc:	ab868693          	addi	a3,a3,-1352 # ffffffffc0209a90 <default_pmm_manager+0x868>
ffffffffc0206fe0:	00001617          	auipc	a2,0x1
ffffffffc0206fe4:	62860613          	addi	a2,a2,1576 # ffffffffc0208608 <commands+0x410>
ffffffffc0206fe8:	06300593          	li	a1,99
ffffffffc0206fec:	00003517          	auipc	a0,0x3
ffffffffc0206ff0:	acc50513          	addi	a0,a0,-1332 # ffffffffc0209ab8 <default_pmm_manager+0x890>
ffffffffc0206ff4:	a14f90ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0206ff8:	89d2                	mv	s3,s4
ffffffffc0206ffa:	fb0fe06f          	j	ffffffffc02057aa <stride_dequeue+0x77c>
ffffffffc0206ffe:	89c6                	mv	s3,a7
ffffffffc0207000:	c21fe06f          	j	ffffffffc0205c20 <stride_dequeue+0xbf2>
ffffffffc0207004:	89c6                	mv	s3,a7
ffffffffc0207006:	b3dfe06f          	j	ffffffffc0205b42 <stride_dequeue+0xb14>
ffffffffc020700a:	89b2                	mv	s3,a2
ffffffffc020700c:	ea0fe06f          	j	ffffffffc02056ac <stride_dequeue+0x67e>
ffffffffc0207010:	0109b503          	ld	a0,16(s3)
ffffffffc0207014:	0089bb03          	ld	s6,8(s3)
ffffffffc0207018:	85a6                	mv	a1,s1
ffffffffc020701a:	e35fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020701e:	00a9b423          	sd	a0,8(s3)
ffffffffc0207022:	0169b823          	sd	s6,16(s3)
ffffffffc0207026:	010c2b03          	lw	s6,16(s8)
ffffffffc020702a:	b4050363          	beqz	a0,ffffffffc0206370 <stride_dequeue+0x1342>
ffffffffc020702e:	01353023          	sd	s3,0(a0)
ffffffffc0207032:	b3eff06f          	j	ffffffffc0206370 <stride_dequeue+0x1342>
ffffffffc0207036:	0109b503          	ld	a0,16(s3)
ffffffffc020703a:	0089bb03          	ld	s6,8(s3)
ffffffffc020703e:	859a                	mv	a1,t1
ffffffffc0207040:	f446                	sd	a7,40(sp)
ffffffffc0207042:	e0dfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207046:	00a9b423          	sd	a0,8(s3)
ffffffffc020704a:	0169b823          	sd	s6,16(s3)
ffffffffc020704e:	78a2                	ld	a7,40(sp)
ffffffffc0207050:	010c2b03          	lw	s6,16(s8)
ffffffffc0207054:	100505e3          	beqz	a0,ffffffffc020795e <stride_dequeue+0x2930>
ffffffffc0207058:	01353023          	sd	s3,0(a0)
ffffffffc020705c:	834e                	mv	t1,s3
ffffffffc020705e:	b0c5                	j	ffffffffc020693e <stride_dequeue+0x1910>
ffffffffc0207060:	0109b503          	ld	a0,16(s3)
ffffffffc0207064:	0089bb03          	ld	s6,8(s3)
ffffffffc0207068:	85f2                	mv	a1,t3
ffffffffc020706a:	f442                	sd	a6,40(sp)
ffffffffc020706c:	f032                	sd	a2,32(sp)
ffffffffc020706e:	de1fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207072:	00a9b423          	sd	a0,8(s3)
ffffffffc0207076:	0169b823          	sd	s6,16(s3)
ffffffffc020707a:	7602                	ld	a2,32(sp)
ffffffffc020707c:	7822                	ld	a6,40(sp)
ffffffffc020707e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207082:	9e050b63          	beqz	a0,ffffffffc0206278 <stride_dequeue+0x124a>
ffffffffc0207086:	01353023          	sd	s3,0(a0)
ffffffffc020708a:	9eeff06f          	j	ffffffffc0206278 <stride_dequeue+0x124a>
ffffffffc020708e:	0109b503          	ld	a0,16(s3)
ffffffffc0207092:	0089bb03          	ld	s6,8(s3)
ffffffffc0207096:	859a                	mv	a1,t1
ffffffffc0207098:	f442                	sd	a6,40(sp)
ffffffffc020709a:	db5fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020709e:	00a9b423          	sd	a0,8(s3)
ffffffffc02070a2:	0169b823          	sd	s6,16(s3)
ffffffffc02070a6:	7822                	ld	a6,40(sp)
ffffffffc02070a8:	010c2b03          	lw	s6,16(s8)
ffffffffc02070ac:	08050de3          	beqz	a0,ffffffffc0207946 <stride_dequeue+0x2918>
ffffffffc02070b0:	01353023          	sd	s3,0(a0)
ffffffffc02070b4:	834e                	mv	t1,s3
ffffffffc02070b6:	efaff06f          	j	ffffffffc02067b0 <stride_dequeue+0x1782>
ffffffffc02070ba:	89a6                	mv	s3,s1
ffffffffc02070bc:	ab4ff06f          	j	ffffffffc0206370 <stride_dequeue+0x1342>
ffffffffc02070c0:	0109b503          	ld	a0,16(s3)
ffffffffc02070c4:	0089bb03          	ld	s6,8(s3)
ffffffffc02070c8:	85ee                	mv	a1,s11
ffffffffc02070ca:	f046                	sd	a7,32(sp)
ffffffffc02070cc:	d83fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02070d0:	00a9b423          	sd	a0,8(s3)
ffffffffc02070d4:	0169b823          	sd	s6,16(s3)
ffffffffc02070d8:	7882                	ld	a7,32(sp)
ffffffffc02070da:	010c2b03          	lw	s6,16(s8)
ffffffffc02070de:	bc050f63          	beqz	a0,ffffffffc02064bc <stride_dequeue+0x148e>
ffffffffc02070e2:	01353023          	sd	s3,0(a0)
ffffffffc02070e6:	bd6ff06f          	j	ffffffffc02064bc <stride_dequeue+0x148e>
ffffffffc02070ea:	0109b503          	ld	a0,16(s3)
ffffffffc02070ee:	0089bb03          	ld	s6,8(s3)
ffffffffc02070f2:	85f2                	mv	a1,t3
ffffffffc02070f4:	f442                	sd	a6,40(sp)
ffffffffc02070f6:	d59fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02070fa:	00a9b423          	sd	a0,8(s3)
ffffffffc02070fe:	0169b823          	sd	s6,16(s3)
ffffffffc0207102:	7822                	ld	a6,40(sp)
ffffffffc0207104:	010c2b03          	lw	s6,16(s8)
ffffffffc0207108:	e119                	bnez	a0,ffffffffc020710e <stride_dequeue+0x20e0>
ffffffffc020710a:	8caff06f          	j	ffffffffc02061d4 <stride_dequeue+0x11a6>
ffffffffc020710e:	01353023          	sd	s3,0(a0)
ffffffffc0207112:	8c2ff06f          	j	ffffffffc02061d4 <stride_dequeue+0x11a6>
ffffffffc0207116:	0109b503          	ld	a0,16(s3)
ffffffffc020711a:	0089bb03          	ld	s6,8(s3)
ffffffffc020711e:	85b2                	mv	a1,a2
ffffffffc0207120:	ec46                	sd	a7,24(sp)
ffffffffc0207122:	d2dfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207126:	00a9b423          	sd	a0,8(s3)
ffffffffc020712a:	0169b823          	sd	s6,16(s3)
ffffffffc020712e:	68e2                	ld	a7,24(sp)
ffffffffc0207130:	010c2b03          	lw	s6,16(s8)
ffffffffc0207134:	c2050963          	beqz	a0,ffffffffc0206566 <stride_dequeue+0x1538>
ffffffffc0207138:	01353023          	sd	s3,0(a0)
ffffffffc020713c:	c2aff06f          	j	ffffffffc0206566 <stride_dequeue+0x1538>
ffffffffc0207140:	0109b503          	ld	a0,16(s3)
ffffffffc0207144:	0089bb03          	ld	s6,8(s3)
ffffffffc0207148:	859a                	mv	a1,t1
ffffffffc020714a:	f442                	sd	a6,40(sp)
ffffffffc020714c:	f032                	sd	a2,32(sp)
ffffffffc020714e:	d01fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207152:	00a9b423          	sd	a0,8(s3)
ffffffffc0207156:	0169b823          	sd	s6,16(s3)
ffffffffc020715a:	7602                	ld	a2,32(sp)
ffffffffc020715c:	7822                	ld	a6,40(sp)
ffffffffc020715e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207162:	7c050363          	beqz	a0,ffffffffc0207928 <stride_dequeue+0x28fa>
ffffffffc0207166:	01353023          	sd	s3,0(a0)
ffffffffc020716a:	834e                	mv	t1,s3
ffffffffc020716c:	eaeff06f          	j	ffffffffc020681a <stride_dequeue+0x17ec>
ffffffffc0207170:	0109b503          	ld	a0,16(s3)
ffffffffc0207174:	0089bb03          	ld	s6,8(s3)
ffffffffc0207178:	85c2                	mv	a1,a6
ffffffffc020717a:	ec32                	sd	a2,24(sp)
ffffffffc020717c:	cd3fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207180:	00a9b423          	sd	a0,8(s3)
ffffffffc0207184:	0169b823          	sd	s6,16(s3)
ffffffffc0207188:	6662                	ld	a2,24(sp)
ffffffffc020718a:	010c2b03          	lw	s6,16(s8)
ffffffffc020718e:	d2050263          	beqz	a0,ffffffffc02066b2 <stride_dequeue+0x1684>
ffffffffc0207192:	01353023          	sd	s3,0(a0)
ffffffffc0207196:	d1cff06f          	j	ffffffffc02066b2 <stride_dequeue+0x1684>
ffffffffc020719a:	0109b503          	ld	a0,16(s3)
ffffffffc020719e:	0089bb03          	ld	s6,8(s3)
ffffffffc02071a2:	85c2                	mv	a1,a6
ffffffffc02071a4:	cabfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02071a8:	00a9b423          	sd	a0,8(s3)
ffffffffc02071ac:	0169b823          	sd	s6,16(s3)
ffffffffc02071b0:	010c2b03          	lw	s6,16(s8)
ffffffffc02071b4:	c4050b63          	beqz	a0,ffffffffc020660a <stride_dequeue+0x15dc>
ffffffffc02071b8:	01353023          	sd	s3,0(a0)
ffffffffc02071bc:	c4eff06f          	j	ffffffffc020660a <stride_dequeue+0x15dc>
ffffffffc02071c0:	0109b503          	ld	a0,16(s3)
ffffffffc02071c4:	0089bb03          	ld	s6,8(s3)
ffffffffc02071c8:	859a                	mv	a1,t1
ffffffffc02071ca:	c85fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02071ce:	00a9b423          	sd	a0,8(s3)
ffffffffc02071d2:	0169b823          	sd	s6,16(s3)
ffffffffc02071d6:	010c2b03          	lw	s6,16(s8)
ffffffffc02071da:	e119                	bnez	a0,ffffffffc02071e0 <stride_dequeue+0x21b2>
ffffffffc02071dc:	c77fe06f          	j	ffffffffc0205e52 <stride_dequeue+0xe24>
ffffffffc02071e0:	01353023          	sd	s3,0(a0)
ffffffffc02071e4:	c6ffe06f          	j	ffffffffc0205e52 <stride_dequeue+0xe24>
ffffffffc02071e8:	6a08                	ld	a0,16(a2)
ffffffffc02071ea:	85f2                	mv	a1,t3
ffffffffc02071ec:	00863b03          	ld	s6,8(a2)
ffffffffc02071f0:	c5ffd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02071f4:	7602                	ld	a2,32(sp)
ffffffffc02071f6:	7822                	ld	a6,40(sp)
ffffffffc02071f8:	01663823          	sd	s6,16(a2)
ffffffffc02071fc:	e608                	sd	a0,8(a2)
ffffffffc02071fe:	010c2b03          	lw	s6,16(s8)
ffffffffc0207202:	e119                	bnez	a0,ffffffffc0207208 <stride_dequeue+0x21da>
ffffffffc0207204:	c9afe06f          	j	ffffffffc020569e <stride_dequeue+0x670>
ffffffffc0207208:	e110                	sd	a2,0(a0)
ffffffffc020720a:	c94fe06f          	j	ffffffffc020569e <stride_dequeue+0x670>
ffffffffc020720e:	010a3503          	ld	a0,16(s4)
ffffffffc0207212:	008a3b03          	ld	s6,8(s4)
ffffffffc0207216:	859a                	mv	a1,t1
ffffffffc0207218:	c37fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020721c:	00aa3423          	sd	a0,8(s4)
ffffffffc0207220:	016a3823          	sd	s6,16(s4)
ffffffffc0207224:	010c2b03          	lw	s6,16(s8)
ffffffffc0207228:	e119                	bnez	a0,ffffffffc020722e <stride_dequeue+0x2200>
ffffffffc020722a:	83dfe06f          	j	ffffffffc0205a66 <stride_dequeue+0xa38>
ffffffffc020722e:	01453023          	sd	s4,0(a0)
ffffffffc0207232:	835fe06f          	j	ffffffffc0205a66 <stride_dequeue+0xa38>
ffffffffc0207236:	010cb503          	ld	a0,16(s9)
ffffffffc020723a:	008cbb03          	ld	s6,8(s9)
ffffffffc020723e:	85f2                	mv	a1,t3
ffffffffc0207240:	f442                	sd	a6,40(sp)
ffffffffc0207242:	c0dfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207246:	00acb423          	sd	a0,8(s9)
ffffffffc020724a:	016cb823          	sd	s6,16(s9)
ffffffffc020724e:	7822                	ld	a6,40(sp)
ffffffffc0207250:	010c2b03          	lw	s6,16(s8)
ffffffffc0207254:	e119                	bnez	a0,ffffffffc020725a <stride_dequeue+0x222c>
ffffffffc0207256:	b2cfe06f          	j	ffffffffc0205582 <stride_dequeue+0x554>
ffffffffc020725a:	01953023          	sd	s9,0(a0)
ffffffffc020725e:	b24fe06f          	j	ffffffffc0205582 <stride_dequeue+0x554>
ffffffffc0207262:	010a3503          	ld	a0,16(s4)
ffffffffc0207266:	008a3b03          	ld	s6,8(s4)
ffffffffc020726a:	85f2                	mv	a1,t3
ffffffffc020726c:	f442                	sd	a6,40(sp)
ffffffffc020726e:	be1fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207272:	00aa3423          	sd	a0,8(s4)
ffffffffc0207276:	016a3823          	sd	s6,16(s4)
ffffffffc020727a:	7822                	ld	a6,40(sp)
ffffffffc020727c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207280:	e119                	bnez	a0,ffffffffc0207286 <stride_dequeue+0x2258>
ffffffffc0207282:	d1afe06f          	j	ffffffffc020579c <stride_dequeue+0x76e>
ffffffffc0207286:	01453023          	sd	s4,0(a0)
ffffffffc020728a:	d12fe06f          	j	ffffffffc020579c <stride_dequeue+0x76e>
ffffffffc020728e:	0108b503          	ld	a0,16(a7)
ffffffffc0207292:	85f2                	mv	a1,t3
ffffffffc0207294:	0088bb03          	ld	s6,8(a7)
ffffffffc0207298:	f046                	sd	a7,32(sp)
ffffffffc020729a:	bb5fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020729e:	7882                	ld	a7,32(sp)
ffffffffc02072a0:	7622                	ld	a2,40(sp)
ffffffffc02072a2:	0168b823          	sd	s6,16(a7)
ffffffffc02072a6:	00a8b423          	sd	a0,8(a7)
ffffffffc02072aa:	010c2b03          	lw	s6,16(s8)
ffffffffc02072ae:	e119                	bnez	a0,ffffffffc02072b4 <stride_dequeue+0x2286>
ffffffffc02072b0:	963fe06f          	j	ffffffffc0205c12 <stride_dequeue+0xbe4>
ffffffffc02072b4:	01153023          	sd	a7,0(a0)
ffffffffc02072b8:	95bfe06f          	j	ffffffffc0205c12 <stride_dequeue+0xbe4>
ffffffffc02072bc:	0108b503          	ld	a0,16(a7)
ffffffffc02072c0:	85f2                	mv	a1,t3
ffffffffc02072c2:	0088bb03          	ld	s6,8(a7)
ffffffffc02072c6:	f446                	sd	a7,40(sp)
ffffffffc02072c8:	b87fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02072cc:	78a2                	ld	a7,40(sp)
ffffffffc02072ce:	0168b823          	sd	s6,16(a7)
ffffffffc02072d2:	00a8b423          	sd	a0,8(a7)
ffffffffc02072d6:	010c2b03          	lw	s6,16(s8)
ffffffffc02072da:	e119                	bnez	a0,ffffffffc02072e0 <stride_dequeue+0x22b2>
ffffffffc02072dc:	a05fe06f          	j	ffffffffc0205ce0 <stride_dequeue+0xcb2>
ffffffffc02072e0:	01153023          	sd	a7,0(a0)
ffffffffc02072e4:	9fdfe06f          	j	ffffffffc0205ce0 <stride_dequeue+0xcb2>
ffffffffc02072e8:	0109b503          	ld	a0,16(s3)
ffffffffc02072ec:	0089bb03          	ld	s6,8(s3)
ffffffffc02072f0:	85c2                	mv	a1,a6
ffffffffc02072f2:	f446                	sd	a7,40(sp)
ffffffffc02072f4:	b5bfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02072f8:	00a9b423          	sd	a0,8(s3)
ffffffffc02072fc:	0169b823          	sd	s6,16(s3)
ffffffffc0207300:	78a2                	ld	a7,40(sp)
ffffffffc0207302:	010c2b03          	lw	s6,16(s8)
ffffffffc0207306:	66050563          	beqz	a0,ffffffffc0207970 <stride_dequeue+0x2942>
ffffffffc020730a:	01353023          	sd	s3,0(a0)
ffffffffc020730e:	884e                	mv	a6,s3
ffffffffc0207310:	d6aff06f          	j	ffffffffc020687a <stride_dequeue+0x184c>
ffffffffc0207314:	0109b503          	ld	a0,16(s3)
ffffffffc0207318:	0089bb03          	ld	s6,8(s3)
ffffffffc020731c:	85f2                	mv	a1,t3
ffffffffc020731e:	f442                	sd	a6,40(sp)
ffffffffc0207320:	b2ffd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207324:	00a9b423          	sd	a0,8(s3)
ffffffffc0207328:	0169b823          	sd	s6,16(s3)
ffffffffc020732c:	7822                	ld	a6,40(sp)
ffffffffc020732e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207332:	e119                	bnez	a0,ffffffffc0207338 <stride_dequeue+0x230a>
ffffffffc0207334:	e05fe06f          	j	ffffffffc0206138 <stride_dequeue+0x110a>
ffffffffc0207338:	01353023          	sd	s3,0(a0)
ffffffffc020733c:	dfdfe06f          	j	ffffffffc0206138 <stride_dequeue+0x110a>
ffffffffc0207340:	0109b503          	ld	a0,16(s3)
ffffffffc0207344:	0089bb03          	ld	s6,8(s3)
ffffffffc0207348:	859a                	mv	a1,t1
ffffffffc020734a:	f442                	sd	a6,40(sp)
ffffffffc020734c:	b03fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207350:	00a9b423          	sd	a0,8(s3)
ffffffffc0207354:	0169b823          	sd	s6,16(s3)
ffffffffc0207358:	7822                	ld	a6,40(sp)
ffffffffc020735a:	010c2b03          	lw	s6,16(s8)
ffffffffc020735e:	64050163          	beqz	a0,ffffffffc02079a0 <stride_dequeue+0x2972>
ffffffffc0207362:	01353023          	sd	s3,0(a0)
ffffffffc0207366:	834e                	mv	t1,s3
ffffffffc0207368:	d76ff06f          	j	ffffffffc02068de <stride_dequeue+0x18b0>
ffffffffc020736c:	0109b503          	ld	a0,16(s3)
ffffffffc0207370:	0089bb03          	ld	s6,8(s3)
ffffffffc0207374:	85f2                	mv	a1,t3
ffffffffc0207376:	f446                	sd	a7,40(sp)
ffffffffc0207378:	ad7fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020737c:	00a9b423          	sd	a0,8(s3)
ffffffffc0207380:	0169b823          	sd	s6,16(s3)
ffffffffc0207384:	78a2                	ld	a7,40(sp)
ffffffffc0207386:	010c2b03          	lw	s6,16(s8)
ffffffffc020738a:	e119                	bnez	a0,ffffffffc0207390 <stride_dequeue+0x2362>
ffffffffc020738c:	d0ffe06f          	j	ffffffffc020609a <stride_dequeue+0x106c>
ffffffffc0207390:	01353023          	sd	s3,0(a0)
ffffffffc0207394:	d07fe06f          	j	ffffffffc020609a <stride_dequeue+0x106c>
ffffffffc0207398:	0109b503          	ld	a0,16(s3)
ffffffffc020739c:	0089bb03          	ld	s6,8(s3)
ffffffffc02073a0:	859a                	mv	a1,t1
ffffffffc02073a2:	aadfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02073a6:	00a9b423          	sd	a0,8(s3)
ffffffffc02073aa:	0169b823          	sd	s6,16(s3)
ffffffffc02073ae:	010c2b03          	lw	s6,16(s8)
ffffffffc02073b2:	e119                	bnez	a0,ffffffffc02073b8 <stride_dequeue+0x238a>
ffffffffc02073b4:	c49fe06f          	j	ffffffffc0205ffc <stride_dequeue+0xfce>
ffffffffc02073b8:	01353023          	sd	s3,0(a0)
ffffffffc02073bc:	c41fe06f          	j	ffffffffc0205ffc <stride_dequeue+0xfce>
ffffffffc02073c0:	0109b503          	ld	a0,16(s3)
ffffffffc02073c4:	0089bb03          	ld	s6,8(s3)
ffffffffc02073c8:	859a                	mv	a1,t1
ffffffffc02073ca:	ec32                	sd	a2,24(sp)
ffffffffc02073cc:	a83fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02073d0:	00a9b423          	sd	a0,8(s3)
ffffffffc02073d4:	0169b823          	sd	s6,16(s3)
ffffffffc02073d8:	6662                	ld	a2,24(sp)
ffffffffc02073da:	010c2b03          	lw	s6,16(s8)
ffffffffc02073de:	e119                	bnez	a0,ffffffffc02073e4 <stride_dequeue+0x23b6>
ffffffffc02073e0:	b4ffe06f          	j	ffffffffc0205f2e <stride_dequeue+0xf00>
ffffffffc02073e4:	01353023          	sd	s3,0(a0)
ffffffffc02073e8:	b47fe06f          	j	ffffffffc0205f2e <stride_dequeue+0xf00>
ffffffffc02073ec:	0108b503          	ld	a0,16(a7)
ffffffffc02073f0:	85f2                	mv	a1,t3
ffffffffc02073f2:	0088bb03          	ld	s6,8(a7)
ffffffffc02073f6:	f446                	sd	a7,40(sp)
ffffffffc02073f8:	a57fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02073fc:	78a2                	ld	a7,40(sp)
ffffffffc02073fe:	0168b823          	sd	s6,16(a7)
ffffffffc0207402:	00a8b423          	sd	a0,8(a7)
ffffffffc0207406:	010c2b03          	lw	s6,16(s8)
ffffffffc020740a:	e119                	bnez	a0,ffffffffc0207410 <stride_dequeue+0x23e2>
ffffffffc020740c:	f28fe06f          	j	ffffffffc0205b34 <stride_dequeue+0xb06>
ffffffffc0207410:	01153023          	sd	a7,0(a0)
ffffffffc0207414:	f20fe06f          	j	ffffffffc0205b34 <stride_dequeue+0xb06>
ffffffffc0207418:	0109b503          	ld	a0,16(s3)
ffffffffc020741c:	0089bb03          	ld	s6,8(s3)
ffffffffc0207420:	85d2                	mv	a1,s4
ffffffffc0207422:	f046                	sd	a7,32(sp)
ffffffffc0207424:	a2bfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207428:	00a9b423          	sd	a0,8(s3)
ffffffffc020742c:	0169b823          	sd	s6,16(s3)
ffffffffc0207430:	7882                	ld	a7,32(sp)
ffffffffc0207432:	010c2b03          	lw	s6,16(s8)
ffffffffc0207436:	e119                	bnez	a0,ffffffffc020743c <stride_dequeue+0x240e>
ffffffffc0207438:	fe1fe06f          	j	ffffffffc0206418 <stride_dequeue+0x13ea>
ffffffffc020743c:	01353023          	sd	s3,0(a0)
ffffffffc0207440:	fd9fe06f          	j	ffffffffc0206418 <stride_dequeue+0x13ea>
ffffffffc0207444:	0109b503          	ld	a0,16(s3)
ffffffffc0207448:	0089bb03          	ld	s6,8(s3)
ffffffffc020744c:	85c2                	mv	a1,a6
ffffffffc020744e:	a01fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207452:	00a9b423          	sd	a0,8(s3)
ffffffffc0207456:	0169b823          	sd	s6,16(s3)
ffffffffc020745a:	010c2b03          	lw	s6,16(s8)
ffffffffc020745e:	ae050863          	beqz	a0,ffffffffc020674e <stride_dequeue+0x1720>
ffffffffc0207462:	01353023          	sd	s3,0(a0)
ffffffffc0207466:	ae8ff06f          	j	ffffffffc020674e <stride_dequeue+0x1720>
ffffffffc020746a:	89d2                	mv	s3,s4
ffffffffc020746c:	fadfe06f          	j	ffffffffc0206418 <stride_dequeue+0x13ea>
ffffffffc0207470:	89ee                	mv	s3,s11
ffffffffc0207472:	84aff06f          	j	ffffffffc02064bc <stride_dequeue+0x148e>
ffffffffc0207476:	89c2                	mv	s3,a6
ffffffffc0207478:	992ff06f          	j	ffffffffc020660a <stride_dequeue+0x15dc>
ffffffffc020747c:	89c2                	mv	s3,a6
ffffffffc020747e:	a34ff06f          	j	ffffffffc02066b2 <stride_dequeue+0x1684>
ffffffffc0207482:	89b2                	mv	s3,a2
ffffffffc0207484:	8e2ff06f          	j	ffffffffc0206566 <stride_dequeue+0x1538>
ffffffffc0207488:	89c2                	mv	s3,a6
ffffffffc020748a:	ac4ff06f          	j	ffffffffc020674e <stride_dequeue+0x1720>
ffffffffc020748e:	01083503          	ld	a0,16(a6)
ffffffffc0207492:	85e6                	mv	a1,s9
ffffffffc0207494:	00883b03          	ld	s6,8(a6)
ffffffffc0207498:	9b7fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020749c:	7802                	ld	a6,32(sp)
ffffffffc020749e:	01683823          	sd	s6,16(a6)
ffffffffc02074a2:	00a83423          	sd	a0,8(a6)
ffffffffc02074a6:	010c2b03          	lw	s6,16(s8)
ffffffffc02074aa:	50050163          	beqz	a0,ffffffffc02079ac <stride_dequeue+0x297e>
ffffffffc02074ae:	01053023          	sd	a6,0(a0)
ffffffffc02074b2:	8cc2                	mv	s9,a6
ffffffffc02074b4:	d62ff06f          	j	ffffffffc0206a16 <stride_dequeue+0x19e8>
ffffffffc02074b8:	01083503          	ld	a0,16(a6)
ffffffffc02074bc:	85d2                	mv	a1,s4
ffffffffc02074be:	00883b03          	ld	s6,8(a6)
ffffffffc02074c2:	98dfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02074c6:	6862                	ld	a6,24(sp)
ffffffffc02074c8:	7602                	ld	a2,32(sp)
ffffffffc02074ca:	01683823          	sd	s6,16(a6)
ffffffffc02074ce:	00a83423          	sd	a0,8(a6)
ffffffffc02074d2:	010c2b03          	lw	s6,16(s8)
ffffffffc02074d6:	4c050863          	beqz	a0,ffffffffc02079a6 <stride_dequeue+0x2978>
ffffffffc02074da:	01053023          	sd	a6,0(a0)
ffffffffc02074de:	8a42                	mv	s4,a6
ffffffffc02074e0:	d94ff06f          	j	ffffffffc0206a74 <stride_dequeue+0x1a46>
ffffffffc02074e4:	89f2                	mv	s3,t3
ffffffffc02074e6:	bb5fe06f          	j	ffffffffc020609a <stride_dequeue+0x106c>
ffffffffc02074ea:	88f2                	mv	a7,t3
ffffffffc02074ec:	e48fe06f          	j	ffffffffc0205b34 <stride_dequeue+0xb06>
ffffffffc02074f0:	89f2                	mv	s3,t3
ffffffffc02074f2:	ce3fe06f          	j	ffffffffc02061d4 <stride_dequeue+0x11a6>
ffffffffc02074f6:	89f2                	mv	s3,t3
ffffffffc02074f8:	c41fe06f          	j	ffffffffc0206138 <stride_dequeue+0x110a>
ffffffffc02074fc:	88f2                	mv	a7,t3
ffffffffc02074fe:	fe2fe06f          	j	ffffffffc0205ce0 <stride_dequeue+0xcb2>
ffffffffc0207502:	87ce                	mv	a5,s3
ffffffffc0207504:	ddffe06f          	j	ffffffffc02062e2 <stride_dequeue+0x12b4>
ffffffffc0207508:	0108b503          	ld	a0,16(a7)
ffffffffc020750c:	85ce                	mv	a1,s3
ffffffffc020750e:	0088bb03          	ld	s6,8(a7)
ffffffffc0207512:	93dfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207516:	7882                	ld	a7,32(sp)
ffffffffc0207518:	0168b823          	sd	s6,16(a7)
ffffffffc020751c:	00a8b423          	sd	a0,8(a7)
ffffffffc0207520:	010c2b03          	lw	s6,16(s8)
ffffffffc0207524:	42050a63          	beqz	a0,ffffffffc0207958 <stride_dequeue+0x292a>
ffffffffc0207528:	01153023          	sd	a7,0(a0)
ffffffffc020752c:	89c6                	mv	s3,a7
ffffffffc020752e:	d9cff06f          	j	ffffffffc0206aca <stride_dequeue+0x1a9c>
ffffffffc0207532:	8cf2                	mv	s9,t3
ffffffffc0207534:	84efe06f          	j	ffffffffc0205582 <stride_dequeue+0x554>
ffffffffc0207538:	8a72                	mv	s4,t3
ffffffffc020753a:	a62fe06f          	j	ffffffffc020579c <stride_dequeue+0x76e>
ffffffffc020753e:	88f2                	mv	a7,t3
ffffffffc0207540:	ed2fe06f          	j	ffffffffc0205c12 <stride_dequeue+0xbe4>
ffffffffc0207544:	89f2                	mv	s3,t3
ffffffffc0207546:	d33fe06f          	j	ffffffffc0206278 <stride_dequeue+0x124a>
ffffffffc020754a:	0109b503          	ld	a0,16(s3)
ffffffffc020754e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207552:	85c6                	mv	a1,a7
ffffffffc0207554:	8fbfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207558:	00a9b423          	sd	a0,8(s3)
ffffffffc020755c:	0169b823          	sd	s6,16(s3)
ffffffffc0207560:	010c2b03          	lw	s6,16(s8)
ffffffffc0207564:	e119                	bnez	a0,ffffffffc020756a <stride_dequeue+0x253c>
ffffffffc0207566:	dfdfe06f          	j	ffffffffc0206362 <stride_dequeue+0x1334>
ffffffffc020756a:	01353023          	sd	s3,0(a0)
ffffffffc020756e:	df5fe06f          	j	ffffffffc0206362 <stride_dequeue+0x1334>
ffffffffc0207572:	01083503          	ld	a0,16(a6)
ffffffffc0207576:	85d2                	mv	a1,s4
ffffffffc0207578:	00883b03          	ld	s6,8(a6)
ffffffffc020757c:	8d3fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207580:	7802                	ld	a6,32(sp)
ffffffffc0207582:	01683823          	sd	s6,16(a6)
ffffffffc0207586:	00a83423          	sd	a0,8(a6)
ffffffffc020758a:	010c2b03          	lw	s6,16(s8)
ffffffffc020758e:	3a050363          	beqz	a0,ffffffffc0207934 <stride_dequeue+0x2906>
ffffffffc0207592:	01053023          	sd	a6,0(a0)
ffffffffc0207596:	8a42                	mv	s4,a6
ffffffffc0207598:	c28ff06f          	j	ffffffffc02069c0 <stride_dequeue+0x1992>
ffffffffc020759c:	8672                	mv	a2,t3
ffffffffc020759e:	900fe06f          	j	ffffffffc020569e <stride_dequeue+0x670>
ffffffffc02075a2:	0108b503          	ld	a0,16(a7)
ffffffffc02075a6:	85ce                	mv	a1,s3
ffffffffc02075a8:	0088bb03          	ld	s6,8(a7)
ffffffffc02075ac:	8a3fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02075b0:	7882                	ld	a7,32(sp)
ffffffffc02075b2:	7622                	ld	a2,40(sp)
ffffffffc02075b4:	7842                	ld	a6,48(sp)
ffffffffc02075b6:	0168b823          	sd	s6,16(a7)
ffffffffc02075ba:	00a8b423          	sd	a0,8(a7)
ffffffffc02075be:	010c2b03          	lw	s6,16(s8)
ffffffffc02075c2:	3c050c63          	beqz	a0,ffffffffc020799a <stride_dequeue+0x296c>
ffffffffc02075c6:	01153023          	sd	a7,0(a0)
ffffffffc02075ca:	89c6                	mv	s3,a7
ffffffffc02075cc:	dc0ff06f          	j	ffffffffc0206b8c <stride_dequeue+0x1b5e>
ffffffffc02075d0:	0109b503          	ld	a0,16(s3)
ffffffffc02075d4:	0089bb03          	ld	s6,8(s3)
ffffffffc02075d8:	85f2                	mv	a1,t3
ffffffffc02075da:	f41a                	sd	t1,40(sp)
ffffffffc02075dc:	873fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02075e0:	00a9b423          	sd	a0,8(s3)
ffffffffc02075e4:	0169b823          	sd	s6,16(s3)
ffffffffc02075e8:	7322                	ld	t1,40(sp)
ffffffffc02075ea:	010c2b03          	lw	s6,16(s8)
ffffffffc02075ee:	e119                	bnez	a0,ffffffffc02075f4 <stride_dequeue+0x25c6>
ffffffffc02075f0:	9fdfe06f          	j	ffffffffc0205fec <stride_dequeue+0xfbe>
ffffffffc02075f4:	01353023          	sd	s3,0(a0)
ffffffffc02075f8:	9f5fe06f          	j	ffffffffc0205fec <stride_dequeue+0xfbe>
ffffffffc02075fc:	01033503          	ld	a0,16(t1)
ffffffffc0207600:	85e6                	mv	a1,s9
ffffffffc0207602:	00833b03          	ld	s6,8(t1)
ffffffffc0207606:	849fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020760a:	7322                	ld	t1,40(sp)
ffffffffc020760c:	78c2                	ld	a7,48(sp)
ffffffffc020760e:	01633823          	sd	s6,16(t1)
ffffffffc0207612:	00a33423          	sd	a0,8(t1)
ffffffffc0207616:	010c2b03          	lw	s6,16(s8)
ffffffffc020761a:	34050e63          	beqz	a0,ffffffffc0207976 <stride_dequeue+0x2948>
ffffffffc020761e:	00653023          	sd	t1,0(a0)
ffffffffc0207622:	8c9a                	mv	s9,t1
ffffffffc0207624:	eeaff06f          	j	ffffffffc0206d0e <stride_dequeue+0x1ce0>
ffffffffc0207628:	01033503          	ld	a0,16(t1)
ffffffffc020762c:	85c2                	mv	a1,a6
ffffffffc020762e:	00833b03          	ld	s6,8(t1)
ffffffffc0207632:	81dfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207636:	7322                	ld	t1,40(sp)
ffffffffc0207638:	01633823          	sd	s6,16(t1)
ffffffffc020763c:	00a33423          	sd	a0,8(t1)
ffffffffc0207640:	010c2b03          	lw	s6,16(s8)
ffffffffc0207644:	32050c63          	beqz	a0,ffffffffc020797c <stride_dequeue+0x294e>
ffffffffc0207648:	00653023          	sd	t1,0(a0)
ffffffffc020764c:	881a                	mv	a6,t1
ffffffffc020764e:	f24ff06f          	j	ffffffffc0206d72 <stride_dequeue+0x1d44>
ffffffffc0207652:	0108b503          	ld	a0,16(a7)
ffffffffc0207656:	85ce                	mv	a1,s3
ffffffffc0207658:	0088bb03          	ld	s6,8(a7)
ffffffffc020765c:	ff2fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207660:	78a2                	ld	a7,40(sp)
ffffffffc0207662:	7842                	ld	a6,48(sp)
ffffffffc0207664:	0168b823          	sd	s6,16(a7)
ffffffffc0207668:	00a8b423          	sd	a0,8(a7)
ffffffffc020766c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207670:	30050963          	beqz	a0,ffffffffc0207982 <stride_dequeue+0x2954>
ffffffffc0207674:	01153023          	sd	a7,0(a0)
ffffffffc0207678:	89c6                	mv	s3,a7
ffffffffc020767a:	caeff06f          	j	ffffffffc0206b28 <stride_dequeue+0x1afa>
ffffffffc020767e:	01083503          	ld	a0,16(a6)
ffffffffc0207682:	85ce                	mv	a1,s3
ffffffffc0207684:	00883b03          	ld	s6,8(a6)
ffffffffc0207688:	fc6fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020768c:	7822                	ld	a6,40(sp)
ffffffffc020768e:	78c2                	ld	a7,48(sp)
ffffffffc0207690:	01683823          	sd	s6,16(a6)
ffffffffc0207694:	00a83423          	sd	a0,8(a6)
ffffffffc0207698:	010c2b03          	lw	s6,16(s8)
ffffffffc020769c:	30050b63          	beqz	a0,ffffffffc02079b2 <stride_dequeue+0x2984>
ffffffffc02076a0:	01053023          	sd	a6,0(a0)
ffffffffc02076a4:	89c2                	mv	s3,a6
ffffffffc02076a6:	da6ff06f          	j	ffffffffc0206c4c <stride_dequeue+0x1c1e>
ffffffffc02076aa:	01083503          	ld	a0,16(a6)
ffffffffc02076ae:	85ce                	mv	a1,s3
ffffffffc02076b0:	00883b03          	ld	s6,8(a6)
ffffffffc02076b4:	f9afd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02076b8:	7802                	ld	a6,32(sp)
ffffffffc02076ba:	7622                	ld	a2,40(sp)
ffffffffc02076bc:	78c2                	ld	a7,48(sp)
ffffffffc02076be:	01683823          	sd	s6,16(a6)
ffffffffc02076c2:	00a83423          	sd	a0,8(a6)
ffffffffc02076c6:	010c2b03          	lw	s6,16(s8)
ffffffffc02076ca:	2a050063          	beqz	a0,ffffffffc020796a <stride_dequeue+0x293c>
ffffffffc02076ce:	01053023          	sd	a6,0(a0)
ffffffffc02076d2:	89c2                	mv	s3,a6
ffffffffc02076d4:	ddcff06f          	j	ffffffffc0206cb0 <stride_dequeue+0x1c82>
ffffffffc02076d8:	0109b503          	ld	a0,16(s3)
ffffffffc02076dc:	0089bb03          	ld	s6,8(s3)
ffffffffc02076e0:	85f2                	mv	a1,t3
ffffffffc02076e2:	f41a                	sd	t1,40(sp)
ffffffffc02076e4:	f6afd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02076e8:	00a9b423          	sd	a0,8(s3)
ffffffffc02076ec:	0169b823          	sd	s6,16(s3)
ffffffffc02076f0:	7322                	ld	t1,40(sp)
ffffffffc02076f2:	010c2b03          	lw	s6,16(s8)
ffffffffc02076f6:	e119                	bnez	a0,ffffffffc02076fc <stride_dequeue+0x26ce>
ffffffffc02076f8:	f4afe06f          	j	ffffffffc0205e42 <stride_dequeue+0xe14>
ffffffffc02076fc:	01353023          	sd	s3,0(a0)
ffffffffc0207700:	f42fe06f          	j	ffffffffc0205e42 <stride_dequeue+0xe14>
ffffffffc0207704:	0109b503          	ld	a0,16(s3)
ffffffffc0207708:	0089bb03          	ld	s6,8(s3)
ffffffffc020770c:	85f2                	mv	a1,t3
ffffffffc020770e:	f446                	sd	a7,40(sp)
ffffffffc0207710:	f3efd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207714:	00a9b423          	sd	a0,8(s3)
ffffffffc0207718:	0169b823          	sd	s6,16(s3)
ffffffffc020771c:	78a2                	ld	a7,40(sp)
ffffffffc020771e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207722:	e119                	bnez	a0,ffffffffc0207728 <stride_dequeue+0x26fa>
ffffffffc0207724:	ce5fe06f          	j	ffffffffc0206408 <stride_dequeue+0x13da>
ffffffffc0207728:	01353023          	sd	s3,0(a0)
ffffffffc020772c:	cddfe06f          	j	ffffffffc0206408 <stride_dequeue+0x13da>
ffffffffc0207730:	0109b503          	ld	a0,16(s3)
ffffffffc0207734:	0089bb03          	ld	s6,8(s3)
ffffffffc0207738:	85f2                	mv	a1,t3
ffffffffc020773a:	f446                	sd	a7,40(sp)
ffffffffc020773c:	f032                	sd	a2,32(sp)
ffffffffc020773e:	f10fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207742:	00a9b423          	sd	a0,8(s3)
ffffffffc0207746:	0169b823          	sd	s6,16(s3)
ffffffffc020774a:	7602                	ld	a2,32(sp)
ffffffffc020774c:	78a2                	ld	a7,40(sp)
ffffffffc020774e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207752:	e119                	bnez	a0,ffffffffc0207758 <stride_dequeue+0x272a>
ffffffffc0207754:	e05fe06f          	j	ffffffffc0206558 <stride_dequeue+0x152a>
ffffffffc0207758:	01353023          	sd	s3,0(a0)
ffffffffc020775c:	dfdfe06f          	j	ffffffffc0206558 <stride_dequeue+0x152a>
ffffffffc0207760:	010a3503          	ld	a0,16(s4)
ffffffffc0207764:	008a3b03          	ld	s6,8(s4)
ffffffffc0207768:	85f2                	mv	a1,t3
ffffffffc020776a:	f41a                	sd	t1,40(sp)
ffffffffc020776c:	ee2fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207770:	00aa3423          	sd	a0,8(s4)
ffffffffc0207774:	016a3823          	sd	s6,16(s4)
ffffffffc0207778:	7322                	ld	t1,40(sp)
ffffffffc020777a:	010c2b03          	lw	s6,16(s8)
ffffffffc020777e:	e119                	bnez	a0,ffffffffc0207784 <stride_dequeue+0x2756>
ffffffffc0207780:	ad6fe06f          	j	ffffffffc0205a56 <stride_dequeue+0xa28>
ffffffffc0207784:	01453023          	sd	s4,0(a0)
ffffffffc0207788:	acefe06f          	j	ffffffffc0205a56 <stride_dequeue+0xa28>
ffffffffc020778c:	0109b503          	ld	a0,16(s3)
ffffffffc0207790:	0089bb03          	ld	s6,8(s3)
ffffffffc0207794:	85f2                	mv	a1,t3
ffffffffc0207796:	f446                	sd	a7,40(sp)
ffffffffc0207798:	eb6fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020779c:	00a9b423          	sd	a0,8(s3)
ffffffffc02077a0:	0169b823          	sd	s6,16(s3)
ffffffffc02077a4:	78a2                	ld	a7,40(sp)
ffffffffc02077a6:	010c2b03          	lw	s6,16(s8)
ffffffffc02077aa:	e119                	bnez	a0,ffffffffc02077b0 <stride_dequeue+0x2782>
ffffffffc02077ac:	d01fe06f          	j	ffffffffc02064ac <stride_dequeue+0x147e>
ffffffffc02077b0:	01353023          	sd	s3,0(a0)
ffffffffc02077b4:	cf9fe06f          	j	ffffffffc02064ac <stride_dequeue+0x147e>
ffffffffc02077b8:	01033503          	ld	a0,16(t1)
ffffffffc02077bc:	85c2                	mv	a1,a6
ffffffffc02077be:	00833b03          	ld	s6,8(t1)
ffffffffc02077c2:	e8cfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02077c6:	7322                	ld	t1,40(sp)
ffffffffc02077c8:	01633823          	sd	s6,16(t1)
ffffffffc02077cc:	00a33423          	sd	a0,8(t1)
ffffffffc02077d0:	010c2b03          	lw	s6,16(s8)
ffffffffc02077d4:	1e050b63          	beqz	a0,ffffffffc02079ca <stride_dequeue+0x299c>
ffffffffc02077d8:	00653023          	sd	t1,0(a0)
ffffffffc02077dc:	881a                	mv	a6,t1
ffffffffc02077de:	e50ff06f          	j	ffffffffc0206e2e <stride_dequeue+0x1e00>
ffffffffc02077e2:	0109b503          	ld	a0,16(s3)
ffffffffc02077e6:	0089bb03          	ld	s6,8(s3)
ffffffffc02077ea:	85f2                	mv	a1,t3
ffffffffc02077ec:	f442                	sd	a6,40(sp)
ffffffffc02077ee:	f032                	sd	a2,32(sp)
ffffffffc02077f0:	e5efd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02077f4:	00a9b423          	sd	a0,8(s3)
ffffffffc02077f8:	0169b823          	sd	s6,16(s3)
ffffffffc02077fc:	7602                	ld	a2,32(sp)
ffffffffc02077fe:	7822                	ld	a6,40(sp)
ffffffffc0207800:	010c2b03          	lw	s6,16(s8)
ffffffffc0207804:	e119                	bnez	a0,ffffffffc020780a <stride_dequeue+0x27dc>
ffffffffc0207806:	e9dfe06f          	j	ffffffffc02066a2 <stride_dequeue+0x1674>
ffffffffc020780a:	01353023          	sd	s3,0(a0)
ffffffffc020780e:	e95fe06f          	j	ffffffffc02066a2 <stride_dequeue+0x1674>
ffffffffc0207812:	0108b503          	ld	a0,16(a7)
ffffffffc0207816:	85ce                	mv	a1,s3
ffffffffc0207818:	0088bb03          	ld	s6,8(a7)
ffffffffc020781c:	e32fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207820:	78a2                	ld	a7,40(sp)
ffffffffc0207822:	7842                	ld	a6,48(sp)
ffffffffc0207824:	0168b823          	sd	s6,16(a7)
ffffffffc0207828:	00a8b423          	sd	a0,8(a7)
ffffffffc020782c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207830:	0e050f63          	beqz	a0,ffffffffc020792e <stride_dequeue+0x2900>
ffffffffc0207834:	01153023          	sd	a7,0(a0)
ffffffffc0207838:	89c6                	mv	s3,a7
ffffffffc020783a:	d96ff06f          	j	ffffffffc0206dd0 <stride_dequeue+0x1da2>
ffffffffc020783e:	01083503          	ld	a0,16(a6)
ffffffffc0207842:	85ce                	mv	a1,s3
ffffffffc0207844:	00883b03          	ld	s6,8(a6)
ffffffffc0207848:	e06fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020784c:	7822                	ld	a6,40(sp)
ffffffffc020784e:	78c2                	ld	a7,48(sp)
ffffffffc0207850:	01683823          	sd	s6,16(a6)
ffffffffc0207854:	00a83423          	sd	a0,8(a6)
ffffffffc0207858:	010c2b03          	lw	s6,16(s8)
ffffffffc020785c:	0e050b63          	beqz	a0,ffffffffc0207952 <stride_dequeue+0x2924>
ffffffffc0207860:	01053023          	sd	a6,0(a0)
ffffffffc0207864:	89c2                	mv	s3,a6
ffffffffc0207866:	b88ff06f          	j	ffffffffc0206bee <stride_dequeue+0x1bc0>
ffffffffc020786a:	0109b503          	ld	a0,16(s3)
ffffffffc020786e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207872:	85f2                	mv	a1,t3
ffffffffc0207874:	f442                	sd	a6,40(sp)
ffffffffc0207876:	dd8fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc020787a:	00a9b423          	sd	a0,8(s3)
ffffffffc020787e:	0169b823          	sd	s6,16(s3)
ffffffffc0207882:	7822                	ld	a6,40(sp)
ffffffffc0207884:	010c2b03          	lw	s6,16(s8)
ffffffffc0207888:	e119                	bnez	a0,ffffffffc020788e <stride_dequeue+0x2860>
ffffffffc020788a:	d71fe06f          	j	ffffffffc02065fa <stride_dequeue+0x15cc>
ffffffffc020788e:	01353023          	sd	s3,0(a0)
ffffffffc0207892:	d69fe06f          	j	ffffffffc02065fa <stride_dequeue+0x15cc>
ffffffffc0207896:	0109b503          	ld	a0,16(s3)
ffffffffc020789a:	0089bb03          	ld	s6,8(s3)
ffffffffc020789e:	85f2                	mv	a1,t3
ffffffffc02078a0:	f442                	sd	a6,40(sp)
ffffffffc02078a2:	dacfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02078a6:	00a9b423          	sd	a0,8(s3)
ffffffffc02078aa:	0169b823          	sd	s6,16(s3)
ffffffffc02078ae:	7822                	ld	a6,40(sp)
ffffffffc02078b0:	010c2b03          	lw	s6,16(s8)
ffffffffc02078b4:	e119                	bnez	a0,ffffffffc02078ba <stride_dequeue+0x288c>
ffffffffc02078b6:	e89fe06f          	j	ffffffffc020673e <stride_dequeue+0x1710>
ffffffffc02078ba:	01353023          	sd	s3,0(a0)
ffffffffc02078be:	e81fe06f          	j	ffffffffc020673e <stride_dequeue+0x1710>
ffffffffc02078c2:	89c6                	mv	s3,a7
ffffffffc02078c4:	a9ffe06f          	j	ffffffffc0206362 <stride_dequeue+0x1334>
ffffffffc02078c8:	0109b503          	ld	a0,16(s3)
ffffffffc02078cc:	0089bb03          	ld	s6,8(s3)
ffffffffc02078d0:	85f2                	mv	a1,t3
ffffffffc02078d2:	f41a                	sd	t1,40(sp)
ffffffffc02078d4:	f032                	sd	a2,32(sp)
ffffffffc02078d6:	d78fd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc02078da:	00a9b423          	sd	a0,8(s3)
ffffffffc02078de:	0169b823          	sd	s6,16(s3)
ffffffffc02078e2:	7602                	ld	a2,32(sp)
ffffffffc02078e4:	7322                	ld	t1,40(sp)
ffffffffc02078e6:	010c2b03          	lw	s6,16(s8)
ffffffffc02078ea:	e119                	bnez	a0,ffffffffc02078f0 <stride_dequeue+0x28c2>
ffffffffc02078ec:	e32fe06f          	j	ffffffffc0205f1e <stride_dequeue+0xef0>
ffffffffc02078f0:	01353023          	sd	s3,0(a0)
ffffffffc02078f4:	e2afe06f          	j	ffffffffc0205f1e <stride_dequeue+0xef0>
ffffffffc02078f8:	01033503          	ld	a0,16(t1)
ffffffffc02078fc:	85c2                	mv	a1,a6
ffffffffc02078fe:	00833b03          	ld	s6,8(t1)
ffffffffc0207902:	d4cfd0ef          	jal	ra,ffffffffc0204e4e <skew_heap_merge.constprop.0>
ffffffffc0207906:	7302                	ld	t1,32(sp)
ffffffffc0207908:	7622                	ld	a2,40(sp)
ffffffffc020790a:	01633823          	sd	s6,16(t1)
ffffffffc020790e:	00a33423          	sd	a0,8(t1)
ffffffffc0207912:	010c2b03          	lw	s6,16(s8)
ffffffffc0207916:	c115                	beqz	a0,ffffffffc020793a <stride_dequeue+0x290c>
ffffffffc0207918:	00653023          	sd	t1,0(a0)
ffffffffc020791c:	881a                	mv	a6,t1
ffffffffc020791e:	d76ff06f          	j	ffffffffc0206e94 <stride_dequeue+0x1e66>
ffffffffc0207922:	89f2                	mv	s3,t3
ffffffffc0207924:	e1bfe06f          	j	ffffffffc020673e <stride_dequeue+0x1710>
ffffffffc0207928:	834e                	mv	t1,s3
ffffffffc020792a:	ef1fe06f          	j	ffffffffc020681a <stride_dequeue+0x17ec>
ffffffffc020792e:	89c6                	mv	s3,a7
ffffffffc0207930:	ca0ff06f          	j	ffffffffc0206dd0 <stride_dequeue+0x1da2>
ffffffffc0207934:	8a42                	mv	s4,a6
ffffffffc0207936:	88aff06f          	j	ffffffffc02069c0 <stride_dequeue+0x1992>
ffffffffc020793a:	881a                	mv	a6,t1
ffffffffc020793c:	d58ff06f          	j	ffffffffc0206e94 <stride_dequeue+0x1e66>
ffffffffc0207940:	89f2                	mv	s3,t3
ffffffffc0207942:	ddcfe06f          	j	ffffffffc0205f1e <stride_dequeue+0xef0>
ffffffffc0207946:	834e                	mv	t1,s3
ffffffffc0207948:	e69fe06f          	j	ffffffffc02067b0 <stride_dequeue+0x1782>
ffffffffc020794c:	89f2                	mv	s3,t3
ffffffffc020794e:	cadfe06f          	j	ffffffffc02065fa <stride_dequeue+0x15cc>
ffffffffc0207952:	89c2                	mv	s3,a6
ffffffffc0207954:	a9aff06f          	j	ffffffffc0206bee <stride_dequeue+0x1bc0>
ffffffffc0207958:	89c6                	mv	s3,a7
ffffffffc020795a:	970ff06f          	j	ffffffffc0206aca <stride_dequeue+0x1a9c>
ffffffffc020795e:	834e                	mv	t1,s3
ffffffffc0207960:	fdffe06f          	j	ffffffffc020693e <stride_dequeue+0x1910>
ffffffffc0207964:	89f2                	mv	s3,t3
ffffffffc0207966:	cdcfe06f          	j	ffffffffc0205e42 <stride_dequeue+0xe14>
ffffffffc020796a:	89c2                	mv	s3,a6
ffffffffc020796c:	b44ff06f          	j	ffffffffc0206cb0 <stride_dequeue+0x1c82>
ffffffffc0207970:	884e                	mv	a6,s3
ffffffffc0207972:	f09fe06f          	j	ffffffffc020687a <stride_dequeue+0x184c>
ffffffffc0207976:	8c9a                	mv	s9,t1
ffffffffc0207978:	b96ff06f          	j	ffffffffc0206d0e <stride_dequeue+0x1ce0>
ffffffffc020797c:	881a                	mv	a6,t1
ffffffffc020797e:	bf4ff06f          	j	ffffffffc0206d72 <stride_dequeue+0x1d44>
ffffffffc0207982:	89c6                	mv	s3,a7
ffffffffc0207984:	9a4ff06f          	j	ffffffffc0206b28 <stride_dequeue+0x1afa>
ffffffffc0207988:	89f2                	mv	s3,t3
ffffffffc020798a:	a7ffe06f          	j	ffffffffc0206408 <stride_dequeue+0x13da>
ffffffffc020798e:	89f2                	mv	s3,t3
ffffffffc0207990:	bc9fe06f          	j	ffffffffc0206558 <stride_dequeue+0x152a>
ffffffffc0207994:	89f2                	mv	s3,t3
ffffffffc0207996:	e56fe06f          	j	ffffffffc0205fec <stride_dequeue+0xfbe>
ffffffffc020799a:	89c6                	mv	s3,a7
ffffffffc020799c:	9f0ff06f          	j	ffffffffc0206b8c <stride_dequeue+0x1b5e>
ffffffffc02079a0:	834e                	mv	t1,s3
ffffffffc02079a2:	f3dfe06f          	j	ffffffffc02068de <stride_dequeue+0x18b0>
ffffffffc02079a6:	8a42                	mv	s4,a6
ffffffffc02079a8:	8ccff06f          	j	ffffffffc0206a74 <stride_dequeue+0x1a46>
ffffffffc02079ac:	8cc2                	mv	s9,a6
ffffffffc02079ae:	868ff06f          	j	ffffffffc0206a16 <stride_dequeue+0x19e8>
ffffffffc02079b2:	89c2                	mv	s3,a6
ffffffffc02079b4:	a98ff06f          	j	ffffffffc0206c4c <stride_dequeue+0x1c1e>
ffffffffc02079b8:	8a72                	mv	s4,t3
ffffffffc02079ba:	89cfe06f          	j	ffffffffc0205a56 <stride_dequeue+0xa28>
ffffffffc02079be:	89f2                	mv	s3,t3
ffffffffc02079c0:	aedfe06f          	j	ffffffffc02064ac <stride_dequeue+0x147e>
ffffffffc02079c4:	89f2                	mv	s3,t3
ffffffffc02079c6:	cddfe06f          	j	ffffffffc02066a2 <stride_dequeue+0x1674>
ffffffffc02079ca:	881a                	mv	a6,t1
ffffffffc02079cc:	c62ff06f          	j	ffffffffc0206e2e <stride_dequeue+0x1e00>

ffffffffc02079d0 <sys_getpid>:
ffffffffc02079d0:	00012797          	auipc	a5,0x12
ffffffffc02079d4:	b287b783          	ld	a5,-1240(a5) # ffffffffc02194f8 <current>
ffffffffc02079d8:	43c8                	lw	a0,4(a5)
ffffffffc02079da:	8082                	ret

ffffffffc02079dc <sys_pgdir>:
ffffffffc02079dc:	4501                	li	a0,0
ffffffffc02079de:	8082                	ret

ffffffffc02079e0 <sys_gettime>:
ffffffffc02079e0:	00012797          	auipc	a5,0x12
ffffffffc02079e4:	b487b783          	ld	a5,-1208(a5) # ffffffffc0219528 <ticks>
ffffffffc02079e8:	0027951b          	slliw	a0,a5,0x2
ffffffffc02079ec:	9d3d                	addw	a0,a0,a5
ffffffffc02079ee:	0015151b          	slliw	a0,a0,0x1
ffffffffc02079f2:	8082                	ret

ffffffffc02079f4 <sys_lab6_set_priority>:
ffffffffc02079f4:	4108                	lw	a0,0(a0)
ffffffffc02079f6:	1141                	addi	sp,sp,-16
ffffffffc02079f8:	e406                	sd	ra,8(sp)
ffffffffc02079fa:	ee5fc0ef          	jal	ra,ffffffffc02048de <lab6_set_priority>
ffffffffc02079fe:	60a2                	ld	ra,8(sp)
ffffffffc0207a00:	4501                	li	a0,0
ffffffffc0207a02:	0141                	addi	sp,sp,16
ffffffffc0207a04:	8082                	ret

ffffffffc0207a06 <sys_putc>:
ffffffffc0207a06:	4108                	lw	a0,0(a0)
ffffffffc0207a08:	1141                	addi	sp,sp,-16
ffffffffc0207a0a:	e406                	sd	ra,8(sp)
ffffffffc0207a0c:	ef6f80ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc0207a10:	60a2                	ld	ra,8(sp)
ffffffffc0207a12:	4501                	li	a0,0
ffffffffc0207a14:	0141                	addi	sp,sp,16
ffffffffc0207a16:	8082                	ret

ffffffffc0207a18 <sys_kill>:
ffffffffc0207a18:	4108                	lw	a0,0(a0)
ffffffffc0207a1a:	d2dfc06f          	j	ffffffffc0204746 <do_kill>

ffffffffc0207a1e <sys_sleep>:
ffffffffc0207a1e:	4108                	lw	a0,0(a0)
ffffffffc0207a20:	ef9fc06f          	j	ffffffffc0204918 <do_sleep>

ffffffffc0207a24 <sys_yield>:
ffffffffc0207a24:	cd5fc06f          	j	ffffffffc02046f8 <do_yield>

ffffffffc0207a28 <sys_exec>:
ffffffffc0207a28:	6d14                	ld	a3,24(a0)
ffffffffc0207a2a:	6910                	ld	a2,16(a0)
ffffffffc0207a2c:	650c                	ld	a1,8(a0)
ffffffffc0207a2e:	6108                	ld	a0,0(a0)
ffffffffc0207a30:	f3efc06f          	j	ffffffffc020416e <do_execve>

ffffffffc0207a34 <sys_wait>:
ffffffffc0207a34:	650c                	ld	a1,8(a0)
ffffffffc0207a36:	4108                	lw	a0,0(a0)
ffffffffc0207a38:	cd1fc06f          	j	ffffffffc0204708 <do_wait>

ffffffffc0207a3c <sys_fork>:
ffffffffc0207a3c:	00012797          	auipc	a5,0x12
ffffffffc0207a40:	abc7b783          	ld	a5,-1348(a5) # ffffffffc02194f8 <current>
ffffffffc0207a44:	73d0                	ld	a2,160(a5)
ffffffffc0207a46:	4501                	li	a0,0
ffffffffc0207a48:	6a0c                	ld	a1,16(a2)
ffffffffc0207a4a:	ebbfb06f          	j	ffffffffc0203904 <do_fork>

ffffffffc0207a4e <sys_exit>:
ffffffffc0207a4e:	4108                	lw	a0,0(a0)
ffffffffc0207a50:	ad6fc06f          	j	ffffffffc0203d26 <do_exit>

ffffffffc0207a54 <syscall>:
ffffffffc0207a54:	715d                	addi	sp,sp,-80
ffffffffc0207a56:	fc26                	sd	s1,56(sp)
ffffffffc0207a58:	00012497          	auipc	s1,0x12
ffffffffc0207a5c:	aa048493          	addi	s1,s1,-1376 # ffffffffc02194f8 <current>
ffffffffc0207a60:	6098                	ld	a4,0(s1)
ffffffffc0207a62:	e0a2                	sd	s0,64(sp)
ffffffffc0207a64:	f84a                	sd	s2,48(sp)
ffffffffc0207a66:	7340                	ld	s0,160(a4)
ffffffffc0207a68:	e486                	sd	ra,72(sp)
ffffffffc0207a6a:	0ff00793          	li	a5,255
ffffffffc0207a6e:	05042903          	lw	s2,80(s0)
ffffffffc0207a72:	0327ee63          	bltu	a5,s2,ffffffffc0207aae <syscall+0x5a>
ffffffffc0207a76:	00391713          	slli	a4,s2,0x3
ffffffffc0207a7a:	00002797          	auipc	a5,0x2
ffffffffc0207a7e:	0c678793          	addi	a5,a5,198 # ffffffffc0209b40 <syscalls>
ffffffffc0207a82:	97ba                	add	a5,a5,a4
ffffffffc0207a84:	639c                	ld	a5,0(a5)
ffffffffc0207a86:	c785                	beqz	a5,ffffffffc0207aae <syscall+0x5a>
ffffffffc0207a88:	6c28                	ld	a0,88(s0)
ffffffffc0207a8a:	702c                	ld	a1,96(s0)
ffffffffc0207a8c:	7430                	ld	a2,104(s0)
ffffffffc0207a8e:	7834                	ld	a3,112(s0)
ffffffffc0207a90:	7c38                	ld	a4,120(s0)
ffffffffc0207a92:	e42a                	sd	a0,8(sp)
ffffffffc0207a94:	e82e                	sd	a1,16(sp)
ffffffffc0207a96:	ec32                	sd	a2,24(sp)
ffffffffc0207a98:	f036                	sd	a3,32(sp)
ffffffffc0207a9a:	f43a                	sd	a4,40(sp)
ffffffffc0207a9c:	0028                	addi	a0,sp,8
ffffffffc0207a9e:	9782                	jalr	a5
ffffffffc0207aa0:	60a6                	ld	ra,72(sp)
ffffffffc0207aa2:	e828                	sd	a0,80(s0)
ffffffffc0207aa4:	6406                	ld	s0,64(sp)
ffffffffc0207aa6:	74e2                	ld	s1,56(sp)
ffffffffc0207aa8:	7942                	ld	s2,48(sp)
ffffffffc0207aaa:	6161                	addi	sp,sp,80
ffffffffc0207aac:	8082                	ret
ffffffffc0207aae:	8522                	mv	a0,s0
ffffffffc0207ab0:	d77f80ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0207ab4:	609c                	ld	a5,0(s1)
ffffffffc0207ab6:	86ca                	mv	a3,s2
ffffffffc0207ab8:	00002617          	auipc	a2,0x2
ffffffffc0207abc:	04060613          	addi	a2,a2,64 # ffffffffc0209af8 <default_pmm_manager+0x8d0>
ffffffffc0207ac0:	43d8                	lw	a4,4(a5)
ffffffffc0207ac2:	07300593          	li	a1,115
ffffffffc0207ac6:	0b478793          	addi	a5,a5,180
ffffffffc0207aca:	00002517          	auipc	a0,0x2
ffffffffc0207ace:	05e50513          	addi	a0,a0,94 # ffffffffc0209b28 <default_pmm_manager+0x900>
ffffffffc0207ad2:	f36f80ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0207ad6 <strnlen>:
ffffffffc0207ad6:	872a                	mv	a4,a0
ffffffffc0207ad8:	4501                	li	a0,0
ffffffffc0207ada:	e589                	bnez	a1,ffffffffc0207ae4 <strnlen+0xe>
ffffffffc0207adc:	a811                	j	ffffffffc0207af0 <strnlen+0x1a>
ffffffffc0207ade:	0505                	addi	a0,a0,1
ffffffffc0207ae0:	00a58763          	beq	a1,a0,ffffffffc0207aee <strnlen+0x18>
ffffffffc0207ae4:	00a707b3          	add	a5,a4,a0
ffffffffc0207ae8:	0007c783          	lbu	a5,0(a5)
ffffffffc0207aec:	fbed                	bnez	a5,ffffffffc0207ade <strnlen+0x8>
ffffffffc0207aee:	8082                	ret
ffffffffc0207af0:	8082                	ret

ffffffffc0207af2 <strcmp>:
ffffffffc0207af2:	00054783          	lbu	a5,0(a0)
ffffffffc0207af6:	0005c703          	lbu	a4,0(a1)
ffffffffc0207afa:	cb89                	beqz	a5,ffffffffc0207b0c <strcmp+0x1a>
ffffffffc0207afc:	0505                	addi	a0,a0,1
ffffffffc0207afe:	0585                	addi	a1,a1,1
ffffffffc0207b00:	fee789e3          	beq	a5,a4,ffffffffc0207af2 <strcmp>
ffffffffc0207b04:	0007851b          	sext.w	a0,a5
ffffffffc0207b08:	9d19                	subw	a0,a0,a4
ffffffffc0207b0a:	8082                	ret
ffffffffc0207b0c:	4501                	li	a0,0
ffffffffc0207b0e:	bfed                	j	ffffffffc0207b08 <strcmp+0x16>

ffffffffc0207b10 <strchr>:
ffffffffc0207b10:	00054783          	lbu	a5,0(a0)
ffffffffc0207b14:	c799                	beqz	a5,ffffffffc0207b22 <strchr+0x12>
ffffffffc0207b16:	00f58763          	beq	a1,a5,ffffffffc0207b24 <strchr+0x14>
ffffffffc0207b1a:	00154783          	lbu	a5,1(a0)
ffffffffc0207b1e:	0505                	addi	a0,a0,1
ffffffffc0207b20:	fbfd                	bnez	a5,ffffffffc0207b16 <strchr+0x6>
ffffffffc0207b22:	4501                	li	a0,0
ffffffffc0207b24:	8082                	ret

ffffffffc0207b26 <memset>:
ffffffffc0207b26:	ca01                	beqz	a2,ffffffffc0207b36 <memset+0x10>
ffffffffc0207b28:	962a                	add	a2,a2,a0
ffffffffc0207b2a:	87aa                	mv	a5,a0
ffffffffc0207b2c:	0785                	addi	a5,a5,1
ffffffffc0207b2e:	feb78fa3          	sb	a1,-1(a5)
ffffffffc0207b32:	fec79de3          	bne	a5,a2,ffffffffc0207b2c <memset+0x6>
ffffffffc0207b36:	8082                	ret

ffffffffc0207b38 <memcpy>:
ffffffffc0207b38:	ca19                	beqz	a2,ffffffffc0207b4e <memcpy+0x16>
ffffffffc0207b3a:	962e                	add	a2,a2,a1
ffffffffc0207b3c:	87aa                	mv	a5,a0
ffffffffc0207b3e:	0005c703          	lbu	a4,0(a1)
ffffffffc0207b42:	0585                	addi	a1,a1,1
ffffffffc0207b44:	0785                	addi	a5,a5,1
ffffffffc0207b46:	fee78fa3          	sb	a4,-1(a5)
ffffffffc0207b4a:	fec59ae3          	bne	a1,a2,ffffffffc0207b3e <memcpy+0x6>
ffffffffc0207b4e:	8082                	ret

ffffffffc0207b50 <printnum>:
ffffffffc0207b50:	02069813          	slli	a6,a3,0x20
ffffffffc0207b54:	7179                	addi	sp,sp,-48
ffffffffc0207b56:	02085813          	srli	a6,a6,0x20
ffffffffc0207b5a:	e052                	sd	s4,0(sp)
ffffffffc0207b5c:	03067a33          	remu	s4,a2,a6
ffffffffc0207b60:	f022                	sd	s0,32(sp)
ffffffffc0207b62:	ec26                	sd	s1,24(sp)
ffffffffc0207b64:	e84a                	sd	s2,16(sp)
ffffffffc0207b66:	f406                	sd	ra,40(sp)
ffffffffc0207b68:	e44e                	sd	s3,8(sp)
ffffffffc0207b6a:	84aa                	mv	s1,a0
ffffffffc0207b6c:	892e                	mv	s2,a1
ffffffffc0207b6e:	fff7041b          	addiw	s0,a4,-1
ffffffffc0207b72:	2a01                	sext.w	s4,s4
ffffffffc0207b74:	03067e63          	bgeu	a2,a6,ffffffffc0207bb0 <printnum+0x60>
ffffffffc0207b78:	89be                	mv	s3,a5
ffffffffc0207b7a:	00805763          	blez	s0,ffffffffc0207b88 <printnum+0x38>
ffffffffc0207b7e:	347d                	addiw	s0,s0,-1
ffffffffc0207b80:	85ca                	mv	a1,s2
ffffffffc0207b82:	854e                	mv	a0,s3
ffffffffc0207b84:	9482                	jalr	s1
ffffffffc0207b86:	fc65                	bnez	s0,ffffffffc0207b7e <printnum+0x2e>
ffffffffc0207b88:	1a02                	slli	s4,s4,0x20
ffffffffc0207b8a:	020a5a13          	srli	s4,s4,0x20
ffffffffc0207b8e:	00002797          	auipc	a5,0x2
ffffffffc0207b92:	7b278793          	addi	a5,a5,1970 # ffffffffc020a340 <syscalls+0x800>
ffffffffc0207b96:	7402                	ld	s0,32(sp)
ffffffffc0207b98:	9a3e                	add	s4,s4,a5
ffffffffc0207b9a:	000a4503          	lbu	a0,0(s4)
ffffffffc0207b9e:	70a2                	ld	ra,40(sp)
ffffffffc0207ba0:	69a2                	ld	s3,8(sp)
ffffffffc0207ba2:	6a02                	ld	s4,0(sp)
ffffffffc0207ba4:	85ca                	mv	a1,s2
ffffffffc0207ba6:	8326                	mv	t1,s1
ffffffffc0207ba8:	6942                	ld	s2,16(sp)
ffffffffc0207baa:	64e2                	ld	s1,24(sp)
ffffffffc0207bac:	6145                	addi	sp,sp,48
ffffffffc0207bae:	8302                	jr	t1
ffffffffc0207bb0:	03065633          	divu	a2,a2,a6
ffffffffc0207bb4:	8722                	mv	a4,s0
ffffffffc0207bb6:	f9bff0ef          	jal	ra,ffffffffc0207b50 <printnum>
ffffffffc0207bba:	b7f9                	j	ffffffffc0207b88 <printnum+0x38>

ffffffffc0207bbc <vprintfmt>:
ffffffffc0207bbc:	7119                	addi	sp,sp,-128
ffffffffc0207bbe:	f4a6                	sd	s1,104(sp)
ffffffffc0207bc0:	f0ca                	sd	s2,96(sp)
ffffffffc0207bc2:	ecce                	sd	s3,88(sp)
ffffffffc0207bc4:	e8d2                	sd	s4,80(sp)
ffffffffc0207bc6:	e4d6                	sd	s5,72(sp)
ffffffffc0207bc8:	e0da                	sd	s6,64(sp)
ffffffffc0207bca:	fc5e                	sd	s7,56(sp)
ffffffffc0207bcc:	f06a                	sd	s10,32(sp)
ffffffffc0207bce:	fc86                	sd	ra,120(sp)
ffffffffc0207bd0:	f8a2                	sd	s0,112(sp)
ffffffffc0207bd2:	f862                	sd	s8,48(sp)
ffffffffc0207bd4:	f466                	sd	s9,40(sp)
ffffffffc0207bd6:	ec6e                	sd	s11,24(sp)
ffffffffc0207bd8:	892a                	mv	s2,a0
ffffffffc0207bda:	84ae                	mv	s1,a1
ffffffffc0207bdc:	8d32                	mv	s10,a2
ffffffffc0207bde:	8a36                	mv	s4,a3
ffffffffc0207be0:	02500993          	li	s3,37
ffffffffc0207be4:	5b7d                	li	s6,-1
ffffffffc0207be6:	00002a97          	auipc	s5,0x2
ffffffffc0207bea:	786a8a93          	addi	s5,s5,1926 # ffffffffc020a36c <syscalls+0x82c>
ffffffffc0207bee:	00003b97          	auipc	s7,0x3
ffffffffc0207bf2:	99ab8b93          	addi	s7,s7,-1638 # ffffffffc020a588 <error_string>
ffffffffc0207bf6:	000d4503          	lbu	a0,0(s10)
ffffffffc0207bfa:	001d0413          	addi	s0,s10,1
ffffffffc0207bfe:	01350a63          	beq	a0,s3,ffffffffc0207c12 <vprintfmt+0x56>
ffffffffc0207c02:	c121                	beqz	a0,ffffffffc0207c42 <vprintfmt+0x86>
ffffffffc0207c04:	85a6                	mv	a1,s1
ffffffffc0207c06:	0405                	addi	s0,s0,1
ffffffffc0207c08:	9902                	jalr	s2
ffffffffc0207c0a:	fff44503          	lbu	a0,-1(s0)
ffffffffc0207c0e:	ff351ae3          	bne	a0,s3,ffffffffc0207c02 <vprintfmt+0x46>
ffffffffc0207c12:	00044603          	lbu	a2,0(s0)
ffffffffc0207c16:	02000793          	li	a5,32
ffffffffc0207c1a:	4c81                	li	s9,0
ffffffffc0207c1c:	4881                	li	a7,0
ffffffffc0207c1e:	5c7d                	li	s8,-1
ffffffffc0207c20:	5dfd                	li	s11,-1
ffffffffc0207c22:	05500513          	li	a0,85
ffffffffc0207c26:	4825                	li	a6,9
ffffffffc0207c28:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0207c2c:	0ff5f593          	andi	a1,a1,255
ffffffffc0207c30:	00140d13          	addi	s10,s0,1
ffffffffc0207c34:	04b56263          	bltu	a0,a1,ffffffffc0207c78 <vprintfmt+0xbc>
ffffffffc0207c38:	058a                	slli	a1,a1,0x2
ffffffffc0207c3a:	95d6                	add	a1,a1,s5
ffffffffc0207c3c:	4194                	lw	a3,0(a1)
ffffffffc0207c3e:	96d6                	add	a3,a3,s5
ffffffffc0207c40:	8682                	jr	a3
ffffffffc0207c42:	70e6                	ld	ra,120(sp)
ffffffffc0207c44:	7446                	ld	s0,112(sp)
ffffffffc0207c46:	74a6                	ld	s1,104(sp)
ffffffffc0207c48:	7906                	ld	s2,96(sp)
ffffffffc0207c4a:	69e6                	ld	s3,88(sp)
ffffffffc0207c4c:	6a46                	ld	s4,80(sp)
ffffffffc0207c4e:	6aa6                	ld	s5,72(sp)
ffffffffc0207c50:	6b06                	ld	s6,64(sp)
ffffffffc0207c52:	7be2                	ld	s7,56(sp)
ffffffffc0207c54:	7c42                	ld	s8,48(sp)
ffffffffc0207c56:	7ca2                	ld	s9,40(sp)
ffffffffc0207c58:	7d02                	ld	s10,32(sp)
ffffffffc0207c5a:	6de2                	ld	s11,24(sp)
ffffffffc0207c5c:	6109                	addi	sp,sp,128
ffffffffc0207c5e:	8082                	ret
ffffffffc0207c60:	87b2                	mv	a5,a2
ffffffffc0207c62:	00144603          	lbu	a2,1(s0)
ffffffffc0207c66:	846a                	mv	s0,s10
ffffffffc0207c68:	00140d13          	addi	s10,s0,1
ffffffffc0207c6c:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0207c70:	0ff5f593          	andi	a1,a1,255
ffffffffc0207c74:	fcb572e3          	bgeu	a0,a1,ffffffffc0207c38 <vprintfmt+0x7c>
ffffffffc0207c78:	85a6                	mv	a1,s1
ffffffffc0207c7a:	02500513          	li	a0,37
ffffffffc0207c7e:	9902                	jalr	s2
ffffffffc0207c80:	fff44783          	lbu	a5,-1(s0)
ffffffffc0207c84:	8d22                	mv	s10,s0
ffffffffc0207c86:	f73788e3          	beq	a5,s3,ffffffffc0207bf6 <vprintfmt+0x3a>
ffffffffc0207c8a:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0207c8e:	1d7d                	addi	s10,s10,-1
ffffffffc0207c90:	ff379de3          	bne	a5,s3,ffffffffc0207c8a <vprintfmt+0xce>
ffffffffc0207c94:	b78d                	j	ffffffffc0207bf6 <vprintfmt+0x3a>
ffffffffc0207c96:	fd060c1b          	addiw	s8,a2,-48
ffffffffc0207c9a:	00144603          	lbu	a2,1(s0)
ffffffffc0207c9e:	846a                	mv	s0,s10
ffffffffc0207ca0:	fd06069b          	addiw	a3,a2,-48
ffffffffc0207ca4:	0006059b          	sext.w	a1,a2
ffffffffc0207ca8:	02d86463          	bltu	a6,a3,ffffffffc0207cd0 <vprintfmt+0x114>
ffffffffc0207cac:	00144603          	lbu	a2,1(s0)
ffffffffc0207cb0:	002c169b          	slliw	a3,s8,0x2
ffffffffc0207cb4:	0186873b          	addw	a4,a3,s8
ffffffffc0207cb8:	0017171b          	slliw	a4,a4,0x1
ffffffffc0207cbc:	9f2d                	addw	a4,a4,a1
ffffffffc0207cbe:	fd06069b          	addiw	a3,a2,-48
ffffffffc0207cc2:	0405                	addi	s0,s0,1
ffffffffc0207cc4:	fd070c1b          	addiw	s8,a4,-48
ffffffffc0207cc8:	0006059b          	sext.w	a1,a2
ffffffffc0207ccc:	fed870e3          	bgeu	a6,a3,ffffffffc0207cac <vprintfmt+0xf0>
ffffffffc0207cd0:	f40ddce3          	bgez	s11,ffffffffc0207c28 <vprintfmt+0x6c>
ffffffffc0207cd4:	8de2                	mv	s11,s8
ffffffffc0207cd6:	5c7d                	li	s8,-1
ffffffffc0207cd8:	bf81                	j	ffffffffc0207c28 <vprintfmt+0x6c>
ffffffffc0207cda:	fffdc693          	not	a3,s11
ffffffffc0207cde:	96fd                	srai	a3,a3,0x3f
ffffffffc0207ce0:	00ddfdb3          	and	s11,s11,a3
ffffffffc0207ce4:	00144603          	lbu	a2,1(s0)
ffffffffc0207ce8:	2d81                	sext.w	s11,s11
ffffffffc0207cea:	846a                	mv	s0,s10
ffffffffc0207cec:	bf35                	j	ffffffffc0207c28 <vprintfmt+0x6c>
ffffffffc0207cee:	000a2c03          	lw	s8,0(s4)
ffffffffc0207cf2:	00144603          	lbu	a2,1(s0)
ffffffffc0207cf6:	0a21                	addi	s4,s4,8
ffffffffc0207cf8:	846a                	mv	s0,s10
ffffffffc0207cfa:	bfd9                	j	ffffffffc0207cd0 <vprintfmt+0x114>
ffffffffc0207cfc:	4705                	li	a4,1
ffffffffc0207cfe:	008a0593          	addi	a1,s4,8
ffffffffc0207d02:	01174463          	blt	a4,a7,ffffffffc0207d0a <vprintfmt+0x14e>
ffffffffc0207d06:	1a088e63          	beqz	a7,ffffffffc0207ec2 <vprintfmt+0x306>
ffffffffc0207d0a:	000a3603          	ld	a2,0(s4)
ffffffffc0207d0e:	46c1                	li	a3,16
ffffffffc0207d10:	8a2e                	mv	s4,a1
ffffffffc0207d12:	2781                	sext.w	a5,a5
ffffffffc0207d14:	876e                	mv	a4,s11
ffffffffc0207d16:	85a6                	mv	a1,s1
ffffffffc0207d18:	854a                	mv	a0,s2
ffffffffc0207d1a:	e37ff0ef          	jal	ra,ffffffffc0207b50 <printnum>
ffffffffc0207d1e:	bde1                	j	ffffffffc0207bf6 <vprintfmt+0x3a>
ffffffffc0207d20:	000a2503          	lw	a0,0(s4)
ffffffffc0207d24:	85a6                	mv	a1,s1
ffffffffc0207d26:	0a21                	addi	s4,s4,8
ffffffffc0207d28:	9902                	jalr	s2
ffffffffc0207d2a:	b5f1                	j	ffffffffc0207bf6 <vprintfmt+0x3a>
ffffffffc0207d2c:	4705                	li	a4,1
ffffffffc0207d2e:	008a0593          	addi	a1,s4,8
ffffffffc0207d32:	01174463          	blt	a4,a7,ffffffffc0207d3a <vprintfmt+0x17e>
ffffffffc0207d36:	18088163          	beqz	a7,ffffffffc0207eb8 <vprintfmt+0x2fc>
ffffffffc0207d3a:	000a3603          	ld	a2,0(s4)
ffffffffc0207d3e:	46a9                	li	a3,10
ffffffffc0207d40:	8a2e                	mv	s4,a1
ffffffffc0207d42:	bfc1                	j	ffffffffc0207d12 <vprintfmt+0x156>
ffffffffc0207d44:	00144603          	lbu	a2,1(s0)
ffffffffc0207d48:	4c85                	li	s9,1
ffffffffc0207d4a:	846a                	mv	s0,s10
ffffffffc0207d4c:	bdf1                	j	ffffffffc0207c28 <vprintfmt+0x6c>
ffffffffc0207d4e:	85a6                	mv	a1,s1
ffffffffc0207d50:	02500513          	li	a0,37
ffffffffc0207d54:	9902                	jalr	s2
ffffffffc0207d56:	b545                	j	ffffffffc0207bf6 <vprintfmt+0x3a>
ffffffffc0207d58:	00144603          	lbu	a2,1(s0)
ffffffffc0207d5c:	2885                	addiw	a7,a7,1
ffffffffc0207d5e:	846a                	mv	s0,s10
ffffffffc0207d60:	b5e1                	j	ffffffffc0207c28 <vprintfmt+0x6c>
ffffffffc0207d62:	4705                	li	a4,1
ffffffffc0207d64:	008a0593          	addi	a1,s4,8
ffffffffc0207d68:	01174463          	blt	a4,a7,ffffffffc0207d70 <vprintfmt+0x1b4>
ffffffffc0207d6c:	14088163          	beqz	a7,ffffffffc0207eae <vprintfmt+0x2f2>
ffffffffc0207d70:	000a3603          	ld	a2,0(s4)
ffffffffc0207d74:	46a1                	li	a3,8
ffffffffc0207d76:	8a2e                	mv	s4,a1
ffffffffc0207d78:	bf69                	j	ffffffffc0207d12 <vprintfmt+0x156>
ffffffffc0207d7a:	03000513          	li	a0,48
ffffffffc0207d7e:	85a6                	mv	a1,s1
ffffffffc0207d80:	e03e                	sd	a5,0(sp)
ffffffffc0207d82:	9902                	jalr	s2
ffffffffc0207d84:	85a6                	mv	a1,s1
ffffffffc0207d86:	07800513          	li	a0,120
ffffffffc0207d8a:	9902                	jalr	s2
ffffffffc0207d8c:	0a21                	addi	s4,s4,8
ffffffffc0207d8e:	6782                	ld	a5,0(sp)
ffffffffc0207d90:	46c1                	li	a3,16
ffffffffc0207d92:	ff8a3603          	ld	a2,-8(s4)
ffffffffc0207d96:	bfb5                	j	ffffffffc0207d12 <vprintfmt+0x156>
ffffffffc0207d98:	000a3403          	ld	s0,0(s4)
ffffffffc0207d9c:	008a0713          	addi	a4,s4,8
ffffffffc0207da0:	e03a                	sd	a4,0(sp)
ffffffffc0207da2:	14040263          	beqz	s0,ffffffffc0207ee6 <vprintfmt+0x32a>
ffffffffc0207da6:	0fb05763          	blez	s11,ffffffffc0207e94 <vprintfmt+0x2d8>
ffffffffc0207daa:	02d00693          	li	a3,45
ffffffffc0207dae:	0cd79163          	bne	a5,a3,ffffffffc0207e70 <vprintfmt+0x2b4>
ffffffffc0207db2:	00044783          	lbu	a5,0(s0)
ffffffffc0207db6:	0007851b          	sext.w	a0,a5
ffffffffc0207dba:	cf85                	beqz	a5,ffffffffc0207df2 <vprintfmt+0x236>
ffffffffc0207dbc:	00140a13          	addi	s4,s0,1
ffffffffc0207dc0:	05e00413          	li	s0,94
ffffffffc0207dc4:	000c4563          	bltz	s8,ffffffffc0207dce <vprintfmt+0x212>
ffffffffc0207dc8:	3c7d                	addiw	s8,s8,-1
ffffffffc0207dca:	036c0263          	beq	s8,s6,ffffffffc0207dee <vprintfmt+0x232>
ffffffffc0207dce:	85a6                	mv	a1,s1
ffffffffc0207dd0:	0e0c8e63          	beqz	s9,ffffffffc0207ecc <vprintfmt+0x310>
ffffffffc0207dd4:	3781                	addiw	a5,a5,-32
ffffffffc0207dd6:	0ef47b63          	bgeu	s0,a5,ffffffffc0207ecc <vprintfmt+0x310>
ffffffffc0207dda:	03f00513          	li	a0,63
ffffffffc0207dde:	9902                	jalr	s2
ffffffffc0207de0:	000a4783          	lbu	a5,0(s4)
ffffffffc0207de4:	3dfd                	addiw	s11,s11,-1
ffffffffc0207de6:	0a05                	addi	s4,s4,1
ffffffffc0207de8:	0007851b          	sext.w	a0,a5
ffffffffc0207dec:	ffe1                	bnez	a5,ffffffffc0207dc4 <vprintfmt+0x208>
ffffffffc0207dee:	01b05963          	blez	s11,ffffffffc0207e00 <vprintfmt+0x244>
ffffffffc0207df2:	3dfd                	addiw	s11,s11,-1
ffffffffc0207df4:	85a6                	mv	a1,s1
ffffffffc0207df6:	02000513          	li	a0,32
ffffffffc0207dfa:	9902                	jalr	s2
ffffffffc0207dfc:	fe0d9be3          	bnez	s11,ffffffffc0207df2 <vprintfmt+0x236>
ffffffffc0207e00:	6a02                	ld	s4,0(sp)
ffffffffc0207e02:	bbd5                	j	ffffffffc0207bf6 <vprintfmt+0x3a>
ffffffffc0207e04:	4705                	li	a4,1
ffffffffc0207e06:	008a0c93          	addi	s9,s4,8
ffffffffc0207e0a:	01174463          	blt	a4,a7,ffffffffc0207e12 <vprintfmt+0x256>
ffffffffc0207e0e:	08088d63          	beqz	a7,ffffffffc0207ea8 <vprintfmt+0x2ec>
ffffffffc0207e12:	000a3403          	ld	s0,0(s4)
ffffffffc0207e16:	0a044d63          	bltz	s0,ffffffffc0207ed0 <vprintfmt+0x314>
ffffffffc0207e1a:	8622                	mv	a2,s0
ffffffffc0207e1c:	8a66                	mv	s4,s9
ffffffffc0207e1e:	46a9                	li	a3,10
ffffffffc0207e20:	bdcd                	j	ffffffffc0207d12 <vprintfmt+0x156>
ffffffffc0207e22:	000a2783          	lw	a5,0(s4)
ffffffffc0207e26:	4761                	li	a4,24
ffffffffc0207e28:	0a21                	addi	s4,s4,8
ffffffffc0207e2a:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0207e2e:	8fb5                	xor	a5,a5,a3
ffffffffc0207e30:	40d786bb          	subw	a3,a5,a3
ffffffffc0207e34:	02d74163          	blt	a4,a3,ffffffffc0207e56 <vprintfmt+0x29a>
ffffffffc0207e38:	00369793          	slli	a5,a3,0x3
ffffffffc0207e3c:	97de                	add	a5,a5,s7
ffffffffc0207e3e:	639c                	ld	a5,0(a5)
ffffffffc0207e40:	cb99                	beqz	a5,ffffffffc0207e56 <vprintfmt+0x29a>
ffffffffc0207e42:	86be                	mv	a3,a5
ffffffffc0207e44:	00000617          	auipc	a2,0x0
ffffffffc0207e48:	13460613          	addi	a2,a2,308 # ffffffffc0207f78 <etext+0x24>
ffffffffc0207e4c:	85a6                	mv	a1,s1
ffffffffc0207e4e:	854a                	mv	a0,s2
ffffffffc0207e50:	0ce000ef          	jal	ra,ffffffffc0207f1e <printfmt>
ffffffffc0207e54:	b34d                	j	ffffffffc0207bf6 <vprintfmt+0x3a>
ffffffffc0207e56:	00002617          	auipc	a2,0x2
ffffffffc0207e5a:	50a60613          	addi	a2,a2,1290 # ffffffffc020a360 <syscalls+0x820>
ffffffffc0207e5e:	85a6                	mv	a1,s1
ffffffffc0207e60:	854a                	mv	a0,s2
ffffffffc0207e62:	0bc000ef          	jal	ra,ffffffffc0207f1e <printfmt>
ffffffffc0207e66:	bb41                	j	ffffffffc0207bf6 <vprintfmt+0x3a>
ffffffffc0207e68:	00002417          	auipc	s0,0x2
ffffffffc0207e6c:	4f040413          	addi	s0,s0,1264 # ffffffffc020a358 <syscalls+0x818>
ffffffffc0207e70:	85e2                	mv	a1,s8
ffffffffc0207e72:	8522                	mv	a0,s0
ffffffffc0207e74:	e43e                	sd	a5,8(sp)
ffffffffc0207e76:	c61ff0ef          	jal	ra,ffffffffc0207ad6 <strnlen>
ffffffffc0207e7a:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0207e7e:	01b05b63          	blez	s11,ffffffffc0207e94 <vprintfmt+0x2d8>
ffffffffc0207e82:	67a2                	ld	a5,8(sp)
ffffffffc0207e84:	00078a1b          	sext.w	s4,a5
ffffffffc0207e88:	3dfd                	addiw	s11,s11,-1
ffffffffc0207e8a:	85a6                	mv	a1,s1
ffffffffc0207e8c:	8552                	mv	a0,s4
ffffffffc0207e8e:	9902                	jalr	s2
ffffffffc0207e90:	fe0d9ce3          	bnez	s11,ffffffffc0207e88 <vprintfmt+0x2cc>
ffffffffc0207e94:	00044783          	lbu	a5,0(s0)
ffffffffc0207e98:	00140a13          	addi	s4,s0,1
ffffffffc0207e9c:	0007851b          	sext.w	a0,a5
ffffffffc0207ea0:	d3a5                	beqz	a5,ffffffffc0207e00 <vprintfmt+0x244>
ffffffffc0207ea2:	05e00413          	li	s0,94
ffffffffc0207ea6:	bf39                	j	ffffffffc0207dc4 <vprintfmt+0x208>
ffffffffc0207ea8:	000a2403          	lw	s0,0(s4)
ffffffffc0207eac:	b7ad                	j	ffffffffc0207e16 <vprintfmt+0x25a>
ffffffffc0207eae:	000a6603          	lwu	a2,0(s4)
ffffffffc0207eb2:	46a1                	li	a3,8
ffffffffc0207eb4:	8a2e                	mv	s4,a1
ffffffffc0207eb6:	bdb1                	j	ffffffffc0207d12 <vprintfmt+0x156>
ffffffffc0207eb8:	000a6603          	lwu	a2,0(s4)
ffffffffc0207ebc:	46a9                	li	a3,10
ffffffffc0207ebe:	8a2e                	mv	s4,a1
ffffffffc0207ec0:	bd89                	j	ffffffffc0207d12 <vprintfmt+0x156>
ffffffffc0207ec2:	000a6603          	lwu	a2,0(s4)
ffffffffc0207ec6:	46c1                	li	a3,16
ffffffffc0207ec8:	8a2e                	mv	s4,a1
ffffffffc0207eca:	b5a1                	j	ffffffffc0207d12 <vprintfmt+0x156>
ffffffffc0207ecc:	9902                	jalr	s2
ffffffffc0207ece:	bf09                	j	ffffffffc0207de0 <vprintfmt+0x224>
ffffffffc0207ed0:	85a6                	mv	a1,s1
ffffffffc0207ed2:	02d00513          	li	a0,45
ffffffffc0207ed6:	e03e                	sd	a5,0(sp)
ffffffffc0207ed8:	9902                	jalr	s2
ffffffffc0207eda:	6782                	ld	a5,0(sp)
ffffffffc0207edc:	8a66                	mv	s4,s9
ffffffffc0207ede:	40800633          	neg	a2,s0
ffffffffc0207ee2:	46a9                	li	a3,10
ffffffffc0207ee4:	b53d                	j	ffffffffc0207d12 <vprintfmt+0x156>
ffffffffc0207ee6:	03b05163          	blez	s11,ffffffffc0207f08 <vprintfmt+0x34c>
ffffffffc0207eea:	02d00693          	li	a3,45
ffffffffc0207eee:	f6d79de3          	bne	a5,a3,ffffffffc0207e68 <vprintfmt+0x2ac>
ffffffffc0207ef2:	00002417          	auipc	s0,0x2
ffffffffc0207ef6:	46640413          	addi	s0,s0,1126 # ffffffffc020a358 <syscalls+0x818>
ffffffffc0207efa:	02800793          	li	a5,40
ffffffffc0207efe:	02800513          	li	a0,40
ffffffffc0207f02:	00140a13          	addi	s4,s0,1
ffffffffc0207f06:	bd6d                	j	ffffffffc0207dc0 <vprintfmt+0x204>
ffffffffc0207f08:	00002a17          	auipc	s4,0x2
ffffffffc0207f0c:	451a0a13          	addi	s4,s4,1105 # ffffffffc020a359 <syscalls+0x819>
ffffffffc0207f10:	02800513          	li	a0,40
ffffffffc0207f14:	02800793          	li	a5,40
ffffffffc0207f18:	05e00413          	li	s0,94
ffffffffc0207f1c:	b565                	j	ffffffffc0207dc4 <vprintfmt+0x208>

ffffffffc0207f1e <printfmt>:
ffffffffc0207f1e:	715d                	addi	sp,sp,-80
ffffffffc0207f20:	02810313          	addi	t1,sp,40
ffffffffc0207f24:	f436                	sd	a3,40(sp)
ffffffffc0207f26:	869a                	mv	a3,t1
ffffffffc0207f28:	ec06                	sd	ra,24(sp)
ffffffffc0207f2a:	f83a                	sd	a4,48(sp)
ffffffffc0207f2c:	fc3e                	sd	a5,56(sp)
ffffffffc0207f2e:	e0c2                	sd	a6,64(sp)
ffffffffc0207f30:	e4c6                	sd	a7,72(sp)
ffffffffc0207f32:	e41a                	sd	t1,8(sp)
ffffffffc0207f34:	c89ff0ef          	jal	ra,ffffffffc0207bbc <vprintfmt>
ffffffffc0207f38:	60e2                	ld	ra,24(sp)
ffffffffc0207f3a:	6161                	addi	sp,sp,80
ffffffffc0207f3c:	8082                	ret

ffffffffc0207f3e <hash32>:
ffffffffc0207f3e:	9e3707b7          	lui	a5,0x9e370
ffffffffc0207f42:	2785                	addiw	a5,a5,1
ffffffffc0207f44:	02a7853b          	mulw	a0,a5,a0
ffffffffc0207f48:	02000793          	li	a5,32
ffffffffc0207f4c:	9f8d                	subw	a5,a5,a1
ffffffffc0207f4e:	00f5553b          	srlw	a0,a0,a5
ffffffffc0207f52:	8082                	ret

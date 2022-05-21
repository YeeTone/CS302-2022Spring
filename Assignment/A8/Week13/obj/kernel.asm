
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
ffffffffc020003e:	69e60613          	addi	a2,a2,1694 # ffffffffc02196d8 <end>
ffffffffc0200042:	1141                	addi	sp,sp,-16
ffffffffc0200044:	8e09                	sub	a2,a2,a0
ffffffffc0200046:	4581                	li	a1,0
ffffffffc0200048:	e406                	sd	ra,8(sp)
ffffffffc020004a:	2d9070ef          	jal	ra,ffffffffc0207b22 <memset>
ffffffffc020004e:	570000ef          	jal	ra,ffffffffc02005be <cons_init>
ffffffffc0200052:	00008597          	auipc	a1,0x8
ffffffffc0200056:	efe58593          	addi	a1,a1,-258 # ffffffffc0207f50 <etext>
ffffffffc020005a:	00008517          	auipc	a0,0x8
ffffffffc020005e:	f0e50513          	addi	a0,a0,-242 # ffffffffc0207f68 <etext+0x18>
ffffffffc0200062:	06a000ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200066:	788020ef          	jal	ra,ffffffffc02027ee <pmm_init>
ffffffffc020006a:	5c6000ef          	jal	ra,ffffffffc0200630 <pic_init>
ffffffffc020006e:	5d0000ef          	jal	ra,ffffffffc020063e <idt_init>
ffffffffc0200072:	050010ef          	jal	ra,ffffffffc02010c2 <vmm_init>
ffffffffc0200076:	123040ef          	jal	ra,ffffffffc0204998 <sched_init>
ffffffffc020007a:	710040ef          	jal	ra,ffffffffc020478a <proc_init>
ffffffffc020007e:	4a2000ef          	jal	ra,ffffffffc0200520 <ide_init>
ffffffffc0200082:	16d010ef          	jal	ra,ffffffffc02019ee <swap_init>
ffffffffc0200086:	4f0000ef          	jal	ra,ffffffffc0200576 <clock_init>
ffffffffc020008a:	5a8000ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020008e:	033040ef          	jal	ra,ffffffffc02048c0 <cpu_idle>

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
ffffffffc02000c0:	2f9070ef          	jal	ra,ffffffffc0207bb8 <vprintfmt>
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
ffffffffc02000f6:	2c3070ef          	jal	ra,ffffffffc0207bb8 <vprintfmt>
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
ffffffffc020016e:	e0650513          	addi	a0,a0,-506 # ffffffffc0207f70 <etext+0x20>
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
ffffffffc020023a:	d4250513          	addi	a0,a0,-702 # ffffffffc0207f78 <etext+0x28>
ffffffffc020023e:	e43e                	sd	a5,8(sp)
ffffffffc0200240:	e8dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200244:	65a2                	ld	a1,8(sp)
ffffffffc0200246:	8522                	mv	a0,s0
ffffffffc0200248:	e65ff0ef          	jal	ra,ffffffffc02000ac <vcprintf>
ffffffffc020024c:	00009517          	auipc	a0,0x9
ffffffffc0200250:	5f450513          	addi	a0,a0,1524 # ffffffffc0209840 <default_pmm_manager+0x620>
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
ffffffffc0200284:	d1850513          	addi	a0,a0,-744 # ffffffffc0207f98 <etext+0x48>
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
ffffffffc02002a4:	5a050513          	addi	a0,a0,1440 # ffffffffc0209840 <default_pmm_manager+0x620>
ffffffffc02002a8:	e25ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002ac:	60e2                	ld	ra,24(sp)
ffffffffc02002ae:	6442                	ld	s0,16(sp)
ffffffffc02002b0:	6161                	addi	sp,sp,80
ffffffffc02002b2:	8082                	ret

ffffffffc02002b4 <print_kerninfo>:
ffffffffc02002b4:	1141                	addi	sp,sp,-16
ffffffffc02002b6:	00008517          	auipc	a0,0x8
ffffffffc02002ba:	d0250513          	addi	a0,a0,-766 # ffffffffc0207fb8 <etext+0x68>
ffffffffc02002be:	e406                	sd	ra,8(sp)
ffffffffc02002c0:	e0dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002c4:	00000597          	auipc	a1,0x0
ffffffffc02002c8:	d6e58593          	addi	a1,a1,-658 # ffffffffc0200032 <kern_init>
ffffffffc02002cc:	00008517          	auipc	a0,0x8
ffffffffc02002d0:	d0c50513          	addi	a0,a0,-756 # ffffffffc0207fd8 <etext+0x88>
ffffffffc02002d4:	df9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002d8:	00008597          	auipc	a1,0x8
ffffffffc02002dc:	c7858593          	addi	a1,a1,-904 # ffffffffc0207f50 <etext>
ffffffffc02002e0:	00008517          	auipc	a0,0x8
ffffffffc02002e4:	d1850513          	addi	a0,a0,-744 # ffffffffc0207ff8 <etext+0xa8>
ffffffffc02002e8:	de5ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002ec:	0000e597          	auipc	a1,0xe
ffffffffc02002f0:	da458593          	addi	a1,a1,-604 # ffffffffc020e090 <buf>
ffffffffc02002f4:	00008517          	auipc	a0,0x8
ffffffffc02002f8:	d2450513          	addi	a0,a0,-732 # ffffffffc0208018 <etext+0xc8>
ffffffffc02002fc:	dd1ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200300:	00019597          	auipc	a1,0x19
ffffffffc0200304:	3d858593          	addi	a1,a1,984 # ffffffffc02196d8 <end>
ffffffffc0200308:	00008517          	auipc	a0,0x8
ffffffffc020030c:	d3050513          	addi	a0,a0,-720 # ffffffffc0208038 <etext+0xe8>
ffffffffc0200310:	dbdff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200314:	00019597          	auipc	a1,0x19
ffffffffc0200318:	7c358593          	addi	a1,a1,1987 # ffffffffc0219ad7 <end+0x3ff>
ffffffffc020031c:	00000797          	auipc	a5,0x0
ffffffffc0200320:	d1678793          	addi	a5,a5,-746 # ffffffffc0200032 <kern_init>
ffffffffc0200324:	40f587b3          	sub	a5,a1,a5
ffffffffc0200328:	43f7d593          	srai	a1,a5,0x3f
ffffffffc020032c:	60a2                	ld	ra,8(sp)
ffffffffc020032e:	3ff5f593          	andi	a1,a1,1023
ffffffffc0200332:	95be                	add	a1,a1,a5
ffffffffc0200334:	85a9                	srai	a1,a1,0xa
ffffffffc0200336:	00008517          	auipc	a0,0x8
ffffffffc020033a:	d2250513          	addi	a0,a0,-734 # ffffffffc0208058 <etext+0x108>
ffffffffc020033e:	0141                	addi	sp,sp,16
ffffffffc0200340:	b371                	j	ffffffffc02000cc <cprintf>

ffffffffc0200342 <print_stackframe>:
ffffffffc0200342:	1141                	addi	sp,sp,-16
ffffffffc0200344:	00008617          	auipc	a2,0x8
ffffffffc0200348:	d4460613          	addi	a2,a2,-700 # ffffffffc0208088 <etext+0x138>
ffffffffc020034c:	05b00593          	li	a1,91
ffffffffc0200350:	00008517          	auipc	a0,0x8
ffffffffc0200354:	d5050513          	addi	a0,a0,-688 # ffffffffc02080a0 <etext+0x150>
ffffffffc0200358:	e406                	sd	ra,8(sp)
ffffffffc020035a:	eafff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020035e <mon_help>:
ffffffffc020035e:	1141                	addi	sp,sp,-16
ffffffffc0200360:	00008617          	auipc	a2,0x8
ffffffffc0200364:	d5860613          	addi	a2,a2,-680 # ffffffffc02080b8 <etext+0x168>
ffffffffc0200368:	00008597          	auipc	a1,0x8
ffffffffc020036c:	d7058593          	addi	a1,a1,-656 # ffffffffc02080d8 <etext+0x188>
ffffffffc0200370:	00008517          	auipc	a0,0x8
ffffffffc0200374:	d7050513          	addi	a0,a0,-656 # ffffffffc02080e0 <etext+0x190>
ffffffffc0200378:	e406                	sd	ra,8(sp)
ffffffffc020037a:	d53ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020037e:	00008617          	auipc	a2,0x8
ffffffffc0200382:	d7260613          	addi	a2,a2,-654 # ffffffffc02080f0 <etext+0x1a0>
ffffffffc0200386:	00008597          	auipc	a1,0x8
ffffffffc020038a:	d9258593          	addi	a1,a1,-622 # ffffffffc0208118 <etext+0x1c8>
ffffffffc020038e:	00008517          	auipc	a0,0x8
ffffffffc0200392:	d5250513          	addi	a0,a0,-686 # ffffffffc02080e0 <etext+0x190>
ffffffffc0200396:	d37ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020039a:	00008617          	auipc	a2,0x8
ffffffffc020039e:	d8e60613          	addi	a2,a2,-626 # ffffffffc0208128 <etext+0x1d8>
ffffffffc02003a2:	00008597          	auipc	a1,0x8
ffffffffc02003a6:	da658593          	addi	a1,a1,-602 # ffffffffc0208148 <etext+0x1f8>
ffffffffc02003aa:	00008517          	auipc	a0,0x8
ffffffffc02003ae:	d3650513          	addi	a0,a0,-714 # ffffffffc02080e0 <etext+0x190>
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
ffffffffc02003e8:	d7450513          	addi	a0,a0,-652 # ffffffffc0208158 <etext+0x208>
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
ffffffffc020040a:	d7a50513          	addi	a0,a0,-646 # ffffffffc0208180 <etext+0x230>
ffffffffc020040e:	cbfff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200412:	000c0563          	beqz	s8,ffffffffc020041c <kmonitor+0x3e>
ffffffffc0200416:	8562                	mv	a0,s8
ffffffffc0200418:	40e000ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc020041c:	00008c97          	auipc	s9,0x8
ffffffffc0200420:	dd4c8c93          	addi	s9,s9,-556 # ffffffffc02081f0 <commands>
ffffffffc0200424:	00008997          	auipc	s3,0x8
ffffffffc0200428:	d8498993          	addi	s3,s3,-636 # ffffffffc02081a8 <etext+0x258>
ffffffffc020042c:	00008917          	auipc	s2,0x8
ffffffffc0200430:	d8490913          	addi	s2,s2,-636 # ffffffffc02081b0 <etext+0x260>
ffffffffc0200434:	4a3d                	li	s4,15
ffffffffc0200436:	00008b17          	auipc	s6,0x8
ffffffffc020043a:	d82b0b13          	addi	s6,s6,-638 # ffffffffc02081b8 <etext+0x268>
ffffffffc020043e:	00008a97          	auipc	s5,0x8
ffffffffc0200442:	c9aa8a93          	addi	s5,s5,-870 # ffffffffc02080d8 <etext+0x188>
ffffffffc0200446:	4b8d                	li	s7,3
ffffffffc0200448:	854e                	mv	a0,s3
ffffffffc020044a:	d0bff0ef          	jal	ra,ffffffffc0200154 <readline>
ffffffffc020044e:	842a                	mv	s0,a0
ffffffffc0200450:	dd65                	beqz	a0,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc0200452:	00054583          	lbu	a1,0(a0)
ffffffffc0200456:	4481                	li	s1,0
ffffffffc0200458:	c999                	beqz	a1,ffffffffc020046e <kmonitor+0x90>
ffffffffc020045a:	854a                	mv	a0,s2
ffffffffc020045c:	6b0070ef          	jal	ra,ffffffffc0207b0c <strchr>
ffffffffc0200460:	c925                	beqz	a0,ffffffffc02004d0 <kmonitor+0xf2>
ffffffffc0200462:	00144583          	lbu	a1,1(s0)
ffffffffc0200466:	00040023          	sb	zero,0(s0)
ffffffffc020046a:	0405                	addi	s0,s0,1
ffffffffc020046c:	f5fd                	bnez	a1,ffffffffc020045a <kmonitor+0x7c>
ffffffffc020046e:	dce9                	beqz	s1,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc0200470:	6582                	ld	a1,0(sp)
ffffffffc0200472:	00008d17          	auipc	s10,0x8
ffffffffc0200476:	d7ed0d13          	addi	s10,s10,-642 # ffffffffc02081f0 <commands>
ffffffffc020047a:	8556                	mv	a0,s5
ffffffffc020047c:	4401                	li	s0,0
ffffffffc020047e:	0d61                	addi	s10,s10,24
ffffffffc0200480:	66e070ef          	jal	ra,ffffffffc0207aee <strcmp>
ffffffffc0200484:	c919                	beqz	a0,ffffffffc020049a <kmonitor+0xbc>
ffffffffc0200486:	2405                	addiw	s0,s0,1
ffffffffc0200488:	09740463          	beq	s0,s7,ffffffffc0200510 <kmonitor+0x132>
ffffffffc020048c:	000d3503          	ld	a0,0(s10)
ffffffffc0200490:	6582                	ld	a1,0(sp)
ffffffffc0200492:	0d61                	addi	s10,s10,24
ffffffffc0200494:	65a070ef          	jal	ra,ffffffffc0207aee <strcmp>
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
ffffffffc02004fa:	612070ef          	jal	ra,ffffffffc0207b0c <strchr>
ffffffffc02004fe:	d96d                	beqz	a0,ffffffffc02004f0 <kmonitor+0x112>
ffffffffc0200500:	00044583          	lbu	a1,0(s0)
ffffffffc0200504:	bf91                	j	ffffffffc0200458 <kmonitor+0x7a>
ffffffffc0200506:	45c1                	li	a1,16
ffffffffc0200508:	855a                	mv	a0,s6
ffffffffc020050a:	bc3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020050e:	b7f1                	j	ffffffffc02004da <kmonitor+0xfc>
ffffffffc0200510:	6582                	ld	a1,0(sp)
ffffffffc0200512:	00008517          	auipc	a0,0x8
ffffffffc0200516:	cc650513          	addi	a0,a0,-826 # ffffffffc02081d8 <etext+0x288>
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
ffffffffc0200546:	5ee070ef          	jal	ra,ffffffffc0207b34 <memcpy>
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
ffffffffc020056a:	5ca070ef          	jal	ra,ffffffffc0207b34 <memcpy>
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
ffffffffc0200598:	ca450513          	addi	a0,a0,-860 # ffffffffc0208238 <commands+0x48>
ffffffffc020059c:	00019797          	auipc	a5,0x19
ffffffffc02005a0:	f807ba23          	sd	zero,-108(a5) # ffffffffc0219530 <ticks>
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
ffffffffc0200664:	bf850513          	addi	a0,a0,-1032 # ffffffffc0208258 <commands+0x68>
ffffffffc0200668:	e406                	sd	ra,8(sp)
ffffffffc020066a:	a63ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020066e:	640c                	ld	a1,8(s0)
ffffffffc0200670:	00008517          	auipc	a0,0x8
ffffffffc0200674:	c0050513          	addi	a0,a0,-1024 # ffffffffc0208270 <commands+0x80>
ffffffffc0200678:	a55ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020067c:	680c                	ld	a1,16(s0)
ffffffffc020067e:	00008517          	auipc	a0,0x8
ffffffffc0200682:	c0a50513          	addi	a0,a0,-1014 # ffffffffc0208288 <commands+0x98>
ffffffffc0200686:	a47ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020068a:	6c0c                	ld	a1,24(s0)
ffffffffc020068c:	00008517          	auipc	a0,0x8
ffffffffc0200690:	c1450513          	addi	a0,a0,-1004 # ffffffffc02082a0 <commands+0xb0>
ffffffffc0200694:	a39ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200698:	700c                	ld	a1,32(s0)
ffffffffc020069a:	00008517          	auipc	a0,0x8
ffffffffc020069e:	c1e50513          	addi	a0,a0,-994 # ffffffffc02082b8 <commands+0xc8>
ffffffffc02006a2:	a2bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006a6:	740c                	ld	a1,40(s0)
ffffffffc02006a8:	00008517          	auipc	a0,0x8
ffffffffc02006ac:	c2850513          	addi	a0,a0,-984 # ffffffffc02082d0 <commands+0xe0>
ffffffffc02006b0:	a1dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006b4:	780c                	ld	a1,48(s0)
ffffffffc02006b6:	00008517          	auipc	a0,0x8
ffffffffc02006ba:	c3250513          	addi	a0,a0,-974 # ffffffffc02082e8 <commands+0xf8>
ffffffffc02006be:	a0fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006c2:	7c0c                	ld	a1,56(s0)
ffffffffc02006c4:	00008517          	auipc	a0,0x8
ffffffffc02006c8:	c3c50513          	addi	a0,a0,-964 # ffffffffc0208300 <commands+0x110>
ffffffffc02006cc:	a01ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006d0:	602c                	ld	a1,64(s0)
ffffffffc02006d2:	00008517          	auipc	a0,0x8
ffffffffc02006d6:	c4650513          	addi	a0,a0,-954 # ffffffffc0208318 <commands+0x128>
ffffffffc02006da:	9f3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006de:	642c                	ld	a1,72(s0)
ffffffffc02006e0:	00008517          	auipc	a0,0x8
ffffffffc02006e4:	c5050513          	addi	a0,a0,-944 # ffffffffc0208330 <commands+0x140>
ffffffffc02006e8:	9e5ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006ec:	682c                	ld	a1,80(s0)
ffffffffc02006ee:	00008517          	auipc	a0,0x8
ffffffffc02006f2:	c5a50513          	addi	a0,a0,-934 # ffffffffc0208348 <commands+0x158>
ffffffffc02006f6:	9d7ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006fa:	6c2c                	ld	a1,88(s0)
ffffffffc02006fc:	00008517          	auipc	a0,0x8
ffffffffc0200700:	c6450513          	addi	a0,a0,-924 # ffffffffc0208360 <commands+0x170>
ffffffffc0200704:	9c9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200708:	702c                	ld	a1,96(s0)
ffffffffc020070a:	00008517          	auipc	a0,0x8
ffffffffc020070e:	c6e50513          	addi	a0,a0,-914 # ffffffffc0208378 <commands+0x188>
ffffffffc0200712:	9bbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200716:	742c                	ld	a1,104(s0)
ffffffffc0200718:	00008517          	auipc	a0,0x8
ffffffffc020071c:	c7850513          	addi	a0,a0,-904 # ffffffffc0208390 <commands+0x1a0>
ffffffffc0200720:	9adff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200724:	782c                	ld	a1,112(s0)
ffffffffc0200726:	00008517          	auipc	a0,0x8
ffffffffc020072a:	c8250513          	addi	a0,a0,-894 # ffffffffc02083a8 <commands+0x1b8>
ffffffffc020072e:	99fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200732:	7c2c                	ld	a1,120(s0)
ffffffffc0200734:	00008517          	auipc	a0,0x8
ffffffffc0200738:	c8c50513          	addi	a0,a0,-884 # ffffffffc02083c0 <commands+0x1d0>
ffffffffc020073c:	991ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200740:	604c                	ld	a1,128(s0)
ffffffffc0200742:	00008517          	auipc	a0,0x8
ffffffffc0200746:	c9650513          	addi	a0,a0,-874 # ffffffffc02083d8 <commands+0x1e8>
ffffffffc020074a:	983ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020074e:	644c                	ld	a1,136(s0)
ffffffffc0200750:	00008517          	auipc	a0,0x8
ffffffffc0200754:	ca050513          	addi	a0,a0,-864 # ffffffffc02083f0 <commands+0x200>
ffffffffc0200758:	975ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020075c:	684c                	ld	a1,144(s0)
ffffffffc020075e:	00008517          	auipc	a0,0x8
ffffffffc0200762:	caa50513          	addi	a0,a0,-854 # ffffffffc0208408 <commands+0x218>
ffffffffc0200766:	967ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020076a:	6c4c                	ld	a1,152(s0)
ffffffffc020076c:	00008517          	auipc	a0,0x8
ffffffffc0200770:	cb450513          	addi	a0,a0,-844 # ffffffffc0208420 <commands+0x230>
ffffffffc0200774:	959ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200778:	704c                	ld	a1,160(s0)
ffffffffc020077a:	00008517          	auipc	a0,0x8
ffffffffc020077e:	cbe50513          	addi	a0,a0,-834 # ffffffffc0208438 <commands+0x248>
ffffffffc0200782:	94bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200786:	744c                	ld	a1,168(s0)
ffffffffc0200788:	00008517          	auipc	a0,0x8
ffffffffc020078c:	cc850513          	addi	a0,a0,-824 # ffffffffc0208450 <commands+0x260>
ffffffffc0200790:	93dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200794:	784c                	ld	a1,176(s0)
ffffffffc0200796:	00008517          	auipc	a0,0x8
ffffffffc020079a:	cd250513          	addi	a0,a0,-814 # ffffffffc0208468 <commands+0x278>
ffffffffc020079e:	92fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007a2:	7c4c                	ld	a1,184(s0)
ffffffffc02007a4:	00008517          	auipc	a0,0x8
ffffffffc02007a8:	cdc50513          	addi	a0,a0,-804 # ffffffffc0208480 <commands+0x290>
ffffffffc02007ac:	921ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007b0:	606c                	ld	a1,192(s0)
ffffffffc02007b2:	00008517          	auipc	a0,0x8
ffffffffc02007b6:	ce650513          	addi	a0,a0,-794 # ffffffffc0208498 <commands+0x2a8>
ffffffffc02007ba:	913ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007be:	646c                	ld	a1,200(s0)
ffffffffc02007c0:	00008517          	auipc	a0,0x8
ffffffffc02007c4:	cf050513          	addi	a0,a0,-784 # ffffffffc02084b0 <commands+0x2c0>
ffffffffc02007c8:	905ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007cc:	686c                	ld	a1,208(s0)
ffffffffc02007ce:	00008517          	auipc	a0,0x8
ffffffffc02007d2:	cfa50513          	addi	a0,a0,-774 # ffffffffc02084c8 <commands+0x2d8>
ffffffffc02007d6:	8f7ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007da:	6c6c                	ld	a1,216(s0)
ffffffffc02007dc:	00008517          	auipc	a0,0x8
ffffffffc02007e0:	d0450513          	addi	a0,a0,-764 # ffffffffc02084e0 <commands+0x2f0>
ffffffffc02007e4:	8e9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007e8:	706c                	ld	a1,224(s0)
ffffffffc02007ea:	00008517          	auipc	a0,0x8
ffffffffc02007ee:	d0e50513          	addi	a0,a0,-754 # ffffffffc02084f8 <commands+0x308>
ffffffffc02007f2:	8dbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007f6:	746c                	ld	a1,232(s0)
ffffffffc02007f8:	00008517          	auipc	a0,0x8
ffffffffc02007fc:	d1850513          	addi	a0,a0,-744 # ffffffffc0208510 <commands+0x320>
ffffffffc0200800:	8cdff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200804:	786c                	ld	a1,240(s0)
ffffffffc0200806:	00008517          	auipc	a0,0x8
ffffffffc020080a:	d2250513          	addi	a0,a0,-734 # ffffffffc0208528 <commands+0x338>
ffffffffc020080e:	8bfff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200812:	7c6c                	ld	a1,248(s0)
ffffffffc0200814:	6402                	ld	s0,0(sp)
ffffffffc0200816:	60a2                	ld	ra,8(sp)
ffffffffc0200818:	00008517          	auipc	a0,0x8
ffffffffc020081c:	d2850513          	addi	a0,a0,-728 # ffffffffc0208540 <commands+0x350>
ffffffffc0200820:	0141                	addi	sp,sp,16
ffffffffc0200822:	8abff06f          	j	ffffffffc02000cc <cprintf>

ffffffffc0200826 <print_trapframe>:
ffffffffc0200826:	1141                	addi	sp,sp,-16
ffffffffc0200828:	e022                	sd	s0,0(sp)
ffffffffc020082a:	85aa                	mv	a1,a0
ffffffffc020082c:	842a                	mv	s0,a0
ffffffffc020082e:	00008517          	auipc	a0,0x8
ffffffffc0200832:	d2a50513          	addi	a0,a0,-726 # ffffffffc0208558 <commands+0x368>
ffffffffc0200836:	e406                	sd	ra,8(sp)
ffffffffc0200838:	895ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020083c:	8522                	mv	a0,s0
ffffffffc020083e:	e1bff0ef          	jal	ra,ffffffffc0200658 <print_regs>
ffffffffc0200842:	10043583          	ld	a1,256(s0)
ffffffffc0200846:	00008517          	auipc	a0,0x8
ffffffffc020084a:	d2a50513          	addi	a0,a0,-726 # ffffffffc0208570 <commands+0x380>
ffffffffc020084e:	87fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200852:	10843583          	ld	a1,264(s0)
ffffffffc0200856:	00008517          	auipc	a0,0x8
ffffffffc020085a:	d3250513          	addi	a0,a0,-718 # ffffffffc0208588 <commands+0x398>
ffffffffc020085e:	86fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200862:	11043583          	ld	a1,272(s0)
ffffffffc0200866:	00008517          	auipc	a0,0x8
ffffffffc020086a:	d3a50513          	addi	a0,a0,-710 # ffffffffc02085a0 <commands+0x3b0>
ffffffffc020086e:	85fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200872:	11843583          	ld	a1,280(s0)
ffffffffc0200876:	6402                	ld	s0,0(sp)
ffffffffc0200878:	60a2                	ld	ra,8(sp)
ffffffffc020087a:	00008517          	auipc	a0,0x8
ffffffffc020087e:	d3650513          	addi	a0,a0,-714 # ffffffffc02085b0 <commands+0x3c0>
ffffffffc0200882:	0141                	addi	sp,sp,16
ffffffffc0200884:	849ff06f          	j	ffffffffc02000cc <cprintf>

ffffffffc0200888 <pgfault_handler>:
ffffffffc0200888:	1101                	addi	sp,sp,-32
ffffffffc020088a:	e426                	sd	s1,8(sp)
ffffffffc020088c:	00019497          	auipc	s1,0x19
ffffffffc0200890:	cac48493          	addi	s1,s1,-852 # ffffffffc0219538 <check_mm_struct>
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
ffffffffc02008c6:	d0650513          	addi	a0,a0,-762 # ffffffffc02085c8 <commands+0x3d8>
ffffffffc02008ca:	803ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02008ce:	6088                	ld	a0,0(s1)
ffffffffc02008d0:	cd1d                	beqz	a0,ffffffffc020090e <pgfault_handler+0x86>
ffffffffc02008d2:	00019717          	auipc	a4,0x19
ffffffffc02008d6:	c2e73703          	ld	a4,-978(a4) # ffffffffc0219500 <current>
ffffffffc02008da:	00019797          	auipc	a5,0x19
ffffffffc02008de:	c2e7b783          	ld	a5,-978(a5) # ffffffffc0219508 <idleproc>
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
ffffffffc0200912:	bf27b783          	ld	a5,-1038(a5) # ffffffffc0219500 <current>
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
ffffffffc0200932:	cba68693          	addi	a3,a3,-838 # ffffffffc02085e8 <commands+0x3f8>
ffffffffc0200936:	00008617          	auipc	a2,0x8
ffffffffc020093a:	cca60613          	addi	a2,a2,-822 # ffffffffc0208600 <commands+0x410>
ffffffffc020093e:	06c00593          	li	a1,108
ffffffffc0200942:	00008517          	auipc	a0,0x8
ffffffffc0200946:	cd650513          	addi	a0,a0,-810 # ffffffffc0208618 <commands+0x428>
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
ffffffffc020097c:	c5050513          	addi	a0,a0,-944 # ffffffffc02085c8 <commands+0x3d8>
ffffffffc0200980:	f4cff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200984:	00008617          	auipc	a2,0x8
ffffffffc0200988:	cac60613          	addi	a2,a2,-852 # ffffffffc0208630 <commands+0x440>
ffffffffc020098c:	07300593          	li	a1,115
ffffffffc0200990:	00008517          	auipc	a0,0x8
ffffffffc0200994:	c8850513          	addi	a0,a0,-888 # ffffffffc0208618 <commands+0x428>
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
ffffffffc02009b4:	d3870713          	addi	a4,a4,-712 # ffffffffc02086e8 <commands+0x4f8>
ffffffffc02009b8:	078a                	slli	a5,a5,0x2
ffffffffc02009ba:	97ba                	add	a5,a5,a4
ffffffffc02009bc:	439c                	lw	a5,0(a5)
ffffffffc02009be:	97ba                	add	a5,a5,a4
ffffffffc02009c0:	8782                	jr	a5
ffffffffc02009c2:	00008517          	auipc	a0,0x8
ffffffffc02009c6:	ce650513          	addi	a0,a0,-794 # ffffffffc02086a8 <commands+0x4b8>
ffffffffc02009ca:	f02ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009ce:	00008517          	auipc	a0,0x8
ffffffffc02009d2:	cba50513          	addi	a0,a0,-838 # ffffffffc0208688 <commands+0x498>
ffffffffc02009d6:	ef6ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009da:	00008517          	auipc	a0,0x8
ffffffffc02009de:	c6e50513          	addi	a0,a0,-914 # ffffffffc0208648 <commands+0x458>
ffffffffc02009e2:	eeaff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009e6:	00008517          	auipc	a0,0x8
ffffffffc02009ea:	c8250513          	addi	a0,a0,-894 # ffffffffc0208668 <commands+0x478>
ffffffffc02009ee:	edeff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009f2:	1141                	addi	sp,sp,-16
ffffffffc02009f4:	e406                	sd	ra,8(sp)
ffffffffc02009f6:	bb1ff0ef          	jal	ra,ffffffffc02005a6 <clock_set_next_event>
ffffffffc02009fa:	00019717          	auipc	a4,0x19
ffffffffc02009fe:	b3670713          	addi	a4,a4,-1226 # ffffffffc0219530 <ticks>
ffffffffc0200a02:	631c                	ld	a5,0(a4)
ffffffffc0200a04:	60a2                	ld	ra,8(sp)
ffffffffc0200a06:	0785                	addi	a5,a5,1
ffffffffc0200a08:	e31c                	sd	a5,0(a4)
ffffffffc0200a0a:	0141                	addi	sp,sp,16
ffffffffc0200a0c:	2a20406f          	j	ffffffffc0204cae <run_timer_list>
ffffffffc0200a10:	00008517          	auipc	a0,0x8
ffffffffc0200a14:	cb850513          	addi	a0,a0,-840 # ffffffffc02086c8 <commands+0x4d8>
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
ffffffffc0200a36:	e7e70713          	addi	a4,a4,-386 # ffffffffc02088b0 <commands+0x6c0>
ffffffffc0200a3a:	078a                	slli	a5,a5,0x2
ffffffffc0200a3c:	97ba                	add	a5,a5,a4
ffffffffc0200a3e:	439c                	lw	a5,0(a5)
ffffffffc0200a40:	97ba                	add	a5,a5,a4
ffffffffc0200a42:	8782                	jr	a5
ffffffffc0200a44:	00008517          	auipc	a0,0x8
ffffffffc0200a48:	dc450513          	addi	a0,a0,-572 # ffffffffc0208808 <commands+0x618>
ffffffffc0200a4c:	e80ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200a50:	10843783          	ld	a5,264(s0)
ffffffffc0200a54:	60e2                	ld	ra,24(sp)
ffffffffc0200a56:	64a2                	ld	s1,8(sp)
ffffffffc0200a58:	0791                	addi	a5,a5,4
ffffffffc0200a5a:	10f43423          	sd	a5,264(s0)
ffffffffc0200a5e:	6442                	ld	s0,16(sp)
ffffffffc0200a60:	6105                	addi	sp,sp,32
ffffffffc0200a62:	7ef0606f          	j	ffffffffc0207a50 <syscall>
ffffffffc0200a66:	00008517          	auipc	a0,0x8
ffffffffc0200a6a:	dc250513          	addi	a0,a0,-574 # ffffffffc0208828 <commands+0x638>
ffffffffc0200a6e:	6442                	ld	s0,16(sp)
ffffffffc0200a70:	60e2                	ld	ra,24(sp)
ffffffffc0200a72:	64a2                	ld	s1,8(sp)
ffffffffc0200a74:	6105                	addi	sp,sp,32
ffffffffc0200a76:	e56ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc0200a7a:	00008517          	auipc	a0,0x8
ffffffffc0200a7e:	dce50513          	addi	a0,a0,-562 # ffffffffc0208848 <commands+0x658>
ffffffffc0200a82:	b7f5                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200a84:	00008517          	auipc	a0,0x8
ffffffffc0200a88:	de450513          	addi	a0,a0,-540 # ffffffffc0208868 <commands+0x678>
ffffffffc0200a8c:	b7cd                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200a8e:	00008517          	auipc	a0,0x8
ffffffffc0200a92:	df250513          	addi	a0,a0,-526 # ffffffffc0208880 <commands+0x690>
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
ffffffffc0200ab4:	de850513          	addi	a0,a0,-536 # ffffffffc0208898 <commands+0x6a8>
ffffffffc0200ab8:	e14ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200abc:	8522                	mv	a0,s0
ffffffffc0200abe:	dcbff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200ac2:	84aa                	mv	s1,a0
ffffffffc0200ac4:	d16d                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200ac6:	8522                	mv	a0,s0
ffffffffc0200ac8:	d5fff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200acc:	86a6                	mv	a3,s1
ffffffffc0200ace:	00008617          	auipc	a2,0x8
ffffffffc0200ad2:	cea60613          	addi	a2,a2,-790 # ffffffffc02087b8 <commands+0x5c8>
ffffffffc0200ad6:	0f600593          	li	a1,246
ffffffffc0200ada:	00008517          	auipc	a0,0x8
ffffffffc0200ade:	b3e50513          	addi	a0,a0,-1218 # ffffffffc0208618 <commands+0x428>
ffffffffc0200ae2:	f26ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200ae6:	00008517          	auipc	a0,0x8
ffffffffc0200aea:	c3250513          	addi	a0,a0,-974 # ffffffffc0208718 <commands+0x528>
ffffffffc0200aee:	b741                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200af0:	00008517          	auipc	a0,0x8
ffffffffc0200af4:	c4850513          	addi	a0,a0,-952 # ffffffffc0208738 <commands+0x548>
ffffffffc0200af8:	bf9d                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200afa:	00008517          	auipc	a0,0x8
ffffffffc0200afe:	c5e50513          	addi	a0,a0,-930 # ffffffffc0208758 <commands+0x568>
ffffffffc0200b02:	b7b5                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200b04:	00008517          	auipc	a0,0x8
ffffffffc0200b08:	c6c50513          	addi	a0,a0,-916 # ffffffffc0208770 <commands+0x580>
ffffffffc0200b0c:	dc0ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b10:	6458                	ld	a4,136(s0)
ffffffffc0200b12:	47a9                	li	a5,10
ffffffffc0200b14:	f8f719e3          	bne	a4,a5,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b18:	bf25                	j	ffffffffc0200a50 <exception_handler+0x32>
ffffffffc0200b1a:	00008517          	auipc	a0,0x8
ffffffffc0200b1e:	c6650513          	addi	a0,a0,-922 # ffffffffc0208780 <commands+0x590>
ffffffffc0200b22:	b7b1                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200b24:	00008517          	auipc	a0,0x8
ffffffffc0200b28:	c7c50513          	addi	a0,a0,-900 # ffffffffc02087a0 <commands+0x5b0>
ffffffffc0200b2c:	da0ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b30:	8522                	mv	a0,s0
ffffffffc0200b32:	d57ff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200b36:	84aa                	mv	s1,a0
ffffffffc0200b38:	d53d                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b3a:	8522                	mv	a0,s0
ffffffffc0200b3c:	cebff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200b40:	86a6                	mv	a3,s1
ffffffffc0200b42:	00008617          	auipc	a2,0x8
ffffffffc0200b46:	c7660613          	addi	a2,a2,-906 # ffffffffc02087b8 <commands+0x5c8>
ffffffffc0200b4a:	0cb00593          	li	a1,203
ffffffffc0200b4e:	00008517          	auipc	a0,0x8
ffffffffc0200b52:	aca50513          	addi	a0,a0,-1334 # ffffffffc0208618 <commands+0x428>
ffffffffc0200b56:	eb2ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200b5a:	00008517          	auipc	a0,0x8
ffffffffc0200b5e:	c9650513          	addi	a0,a0,-874 # ffffffffc02087f0 <commands+0x600>
ffffffffc0200b62:	d6aff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b66:	8522                	mv	a0,s0
ffffffffc0200b68:	d21ff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200b6c:	84aa                	mv	s1,a0
ffffffffc0200b6e:	dd05                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b70:	8522                	mv	a0,s0
ffffffffc0200b72:	cb5ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200b76:	86a6                	mv	a3,s1
ffffffffc0200b78:	00008617          	auipc	a2,0x8
ffffffffc0200b7c:	c4060613          	addi	a2,a2,-960 # ffffffffc02087b8 <commands+0x5c8>
ffffffffc0200b80:	0d500593          	li	a1,213
ffffffffc0200b84:	00008517          	auipc	a0,0x8
ffffffffc0200b88:	a9450513          	addi	a0,a0,-1388 # ffffffffc0208618 <commands+0x428>
ffffffffc0200b8c:	e7cff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200b90:	8522                	mv	a0,s0
ffffffffc0200b92:	6442                	ld	s0,16(sp)
ffffffffc0200b94:	60e2                	ld	ra,24(sp)
ffffffffc0200b96:	64a2                	ld	s1,8(sp)
ffffffffc0200b98:	6105                	addi	sp,sp,32
ffffffffc0200b9a:	b171                	j	ffffffffc0200826 <print_trapframe>
ffffffffc0200b9c:	00008617          	auipc	a2,0x8
ffffffffc0200ba0:	c3c60613          	addi	a2,a2,-964 # ffffffffc02087d8 <commands+0x5e8>
ffffffffc0200ba4:	0cf00593          	li	a1,207
ffffffffc0200ba8:	00008517          	auipc	a0,0x8
ffffffffc0200bac:	a7050513          	addi	a0,a0,-1424 # ffffffffc0208618 <commands+0x428>
ffffffffc0200bb0:	e58ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200bb4:	8522                	mv	a0,s0
ffffffffc0200bb6:	c71ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200bba:	86a6                	mv	a3,s1
ffffffffc0200bbc:	00008617          	auipc	a2,0x8
ffffffffc0200bc0:	bfc60613          	addi	a2,a2,-1028 # ffffffffc02087b8 <commands+0x5c8>
ffffffffc0200bc4:	0ef00593          	li	a1,239
ffffffffc0200bc8:	00008517          	auipc	a0,0x8
ffffffffc0200bcc:	a5050513          	addi	a0,a0,-1456 # ffffffffc0208618 <commands+0x428>
ffffffffc0200bd0:	e38ff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0200bd4 <trap>:
ffffffffc0200bd4:	1101                	addi	sp,sp,-32
ffffffffc0200bd6:	e822                	sd	s0,16(sp)
ffffffffc0200bd8:	00019417          	auipc	s0,0x19
ffffffffc0200bdc:	92840413          	addi	s0,s0,-1752 # ffffffffc0219500 <current>
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
ffffffffc0200c50:	64d0306f          	j	ffffffffc0204a9c <schedule>
ffffffffc0200c54:	555d                	li	a0,-9
ffffffffc0200c56:	0cc030ef          	jal	ra,ffffffffc0203d22 <do_exit>
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
ffffffffc0200d34:	bc068693          	addi	a3,a3,-1088 # ffffffffc02088f0 <commands+0x700>
ffffffffc0200d38:	00008617          	auipc	a2,0x8
ffffffffc0200d3c:	8c860613          	addi	a2,a2,-1848 # ffffffffc0208600 <commands+0x410>
ffffffffc0200d40:	06d00593          	li	a1,109
ffffffffc0200d44:	00008517          	auipc	a0,0x8
ffffffffc0200d48:	bcc50513          	addi	a0,a0,-1076 # ffffffffc0208910 <commands+0x720>
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
ffffffffc0200d8c:	54c020ef          	jal	ra,ffffffffc02032d8 <sem_init>
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
ffffffffc0200e54:	ad068693          	addi	a3,a3,-1328 # ffffffffc0208920 <commands+0x730>
ffffffffc0200e58:	00007617          	auipc	a2,0x7
ffffffffc0200e5c:	7a860613          	addi	a2,a2,1960 # ffffffffc0208600 <commands+0x410>
ffffffffc0200e60:	07400593          	li	a1,116
ffffffffc0200e64:	00008517          	auipc	a0,0x8
ffffffffc0200e68:	aac50513          	addi	a0,a0,-1364 # ffffffffc0208910 <commands+0x720>
ffffffffc0200e6c:	b9cff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200e70:	00008697          	auipc	a3,0x8
ffffffffc0200e74:	af068693          	addi	a3,a3,-1296 # ffffffffc0208960 <commands+0x770>
ffffffffc0200e78:	00007617          	auipc	a2,0x7
ffffffffc0200e7c:	78860613          	addi	a2,a2,1928 # ffffffffc0208600 <commands+0x410>
ffffffffc0200e80:	06c00593          	li	a1,108
ffffffffc0200e84:	00008517          	auipc	a0,0x8
ffffffffc0200e88:	a8c50513          	addi	a0,a0,-1396 # ffffffffc0208910 <commands+0x720>
ffffffffc0200e8c:	b7cff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200e90:	00008697          	auipc	a3,0x8
ffffffffc0200e94:	ab068693          	addi	a3,a3,-1360 # ffffffffc0208940 <commands+0x750>
ffffffffc0200e98:	00007617          	auipc	a2,0x7
ffffffffc0200e9c:	76860613          	addi	a2,a2,1896 # ffffffffc0208600 <commands+0x410>
ffffffffc0200ea0:	06b00593          	li	a1,107
ffffffffc0200ea4:	00008517          	auipc	a0,0x8
ffffffffc0200ea8:	a6c50513          	addi	a0,a0,-1428 # ffffffffc0208910 <commands+0x720>
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
ffffffffc0200ee6:	a9e68693          	addi	a3,a3,-1378 # ffffffffc0208980 <commands+0x790>
ffffffffc0200eea:	00007617          	auipc	a2,0x7
ffffffffc0200eee:	71660613          	addi	a2,a2,1814 # ffffffffc0208600 <commands+0x410>
ffffffffc0200ef2:	09400593          	li	a1,148
ffffffffc0200ef6:	00008517          	auipc	a0,0x8
ffffffffc0200efa:	a1a50513          	addi	a0,a0,-1510 # ffffffffc0208910 <commands+0x720>
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
ffffffffc0200f96:	a0668693          	addi	a3,a3,-1530 # ffffffffc0208998 <commands+0x7a8>
ffffffffc0200f9a:	00007617          	auipc	a2,0x7
ffffffffc0200f9e:	66660613          	addi	a2,a2,1638 # ffffffffc0208600 <commands+0x410>
ffffffffc0200fa2:	0a700593          	li	a1,167
ffffffffc0200fa6:	00008517          	auipc	a0,0x8
ffffffffc0200faa:	96a50513          	addi	a0,a0,-1686 # ffffffffc0208910 <commands+0x720>
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
ffffffffc0201030:	97c68693          	addi	a3,a3,-1668 # ffffffffc02089a8 <commands+0x7b8>
ffffffffc0201034:	00007617          	auipc	a2,0x7
ffffffffc0201038:	5cc60613          	addi	a2,a2,1484 # ffffffffc0208600 <commands+0x410>
ffffffffc020103c:	0c000593          	li	a1,192
ffffffffc0201040:	00008517          	auipc	a0,0x8
ffffffffc0201044:	8d050513          	addi	a0,a0,-1840 # ffffffffc0208910 <commands+0x720>
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
ffffffffc02010a6:	92668693          	addi	a3,a3,-1754 # ffffffffc02089c8 <commands+0x7d8>
ffffffffc02010aa:	00007617          	auipc	a2,0x7
ffffffffc02010ae:	55660613          	addi	a2,a2,1366 # ffffffffc0208600 <commands+0x410>
ffffffffc02010b2:	0d600593          	li	a1,214
ffffffffc02010b6:	00008517          	auipc	a0,0x8
ffffffffc02010ba:	85a50513          	addi	a0,a0,-1958 # ffffffffc0208910 <commands+0x720>
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
ffffffffc020115e:	90650513          	addi	a0,a0,-1786 # ffffffffc0208a60 <commands+0x870>
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
ffffffffc0201188:	8b450513          	addi	a0,a0,-1868 # ffffffffc0208a38 <commands+0x848>
ffffffffc020118c:	f41fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201190:	5971                	li	s2,-4
ffffffffc0201192:	bf55                	j	ffffffffc0201146 <do_pgfault+0x82>
ffffffffc0201194:	85a2                	mv	a1,s0
ffffffffc0201196:	00008517          	auipc	a0,0x8
ffffffffc020119a:	85250513          	addi	a0,a0,-1966 # ffffffffc02089e8 <commands+0x7f8>
ffffffffc020119e:	f2ffe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02011a2:	5975                	li	s2,-3
ffffffffc02011a4:	b74d                	j	ffffffffc0201146 <do_pgfault+0x82>
ffffffffc02011a6:	00008517          	auipc	a0,0x8
ffffffffc02011aa:	8da50513          	addi	a0,a0,-1830 # ffffffffc0208a80 <commands+0x890>
ffffffffc02011ae:	f1ffe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02011b2:	5971                	li	s2,-4
ffffffffc02011b4:	bf49                	j	ffffffffc0201146 <do_pgfault+0x82>
ffffffffc02011b6:	00008517          	auipc	a0,0x8
ffffffffc02011ba:	86250513          	addi	a0,a0,-1950 # ffffffffc0208a18 <commands+0x828>
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
ffffffffc020125e:	2e678793          	addi	a5,a5,742 # ffffffffc0219540 <pra_list_head>
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
ffffffffc0201282:	82a50513          	addi	a0,a0,-2006 # ffffffffc0208aa8 <commands+0x8b8>
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
ffffffffc02012b8:	84450513          	addi	a0,a0,-1980 # ffffffffc0208af8 <commands+0x908>
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
ffffffffc02012dc:	84850513          	addi	a0,a0,-1976 # ffffffffc0208b20 <commands+0x930>
ffffffffc02012e0:	6b91                	lui	s7,0x4
ffffffffc02012e2:	4c35                	li	s8,13
ffffffffc02012e4:	de9fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02012e8:	018b8023          	sb	s8,0(s7) # 4000 <kern_entry-0xffffffffc01fc000>
ffffffffc02012ec:	00042903          	lw	s2,0(s0)
ffffffffc02012f0:	2901                	sext.w	s2,s2
ffffffffc02012f2:	26991d63          	bne	s2,s1,ffffffffc020156c <_fifo_check_swap+0x2f4>
ffffffffc02012f6:	00008517          	auipc	a0,0x8
ffffffffc02012fa:	85250513          	addi	a0,a0,-1966 # ffffffffc0208b48 <commands+0x958>
ffffffffc02012fe:	6c89                	lui	s9,0x2
ffffffffc0201300:	4d2d                	li	s10,11
ffffffffc0201302:	dcbfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201306:	01ac8023          	sb	s10,0(s9) # 2000 <kern_entry-0xffffffffc01fe000>
ffffffffc020130a:	401c                	lw	a5,0(s0)
ffffffffc020130c:	2781                	sext.w	a5,a5
ffffffffc020130e:	23279f63          	bne	a5,s2,ffffffffc020154c <_fifo_check_swap+0x2d4>
ffffffffc0201312:	00008517          	auipc	a0,0x8
ffffffffc0201316:	85e50513          	addi	a0,a0,-1954 # ffffffffc0208b70 <commands+0x980>
ffffffffc020131a:	db3fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020131e:	6795                	lui	a5,0x5
ffffffffc0201320:	4739                	li	a4,14
ffffffffc0201322:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc0201326:	4004                	lw	s1,0(s0)
ffffffffc0201328:	4795                	li	a5,5
ffffffffc020132a:	2481                	sext.w	s1,s1
ffffffffc020132c:	20f49063          	bne	s1,a5,ffffffffc020152c <_fifo_check_swap+0x2b4>
ffffffffc0201330:	00008517          	auipc	a0,0x8
ffffffffc0201334:	81850513          	addi	a0,a0,-2024 # ffffffffc0208b48 <commands+0x958>
ffffffffc0201338:	d95fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020133c:	01ac8023          	sb	s10,0(s9)
ffffffffc0201340:	401c                	lw	a5,0(s0)
ffffffffc0201342:	2781                	sext.w	a5,a5
ffffffffc0201344:	1c979463          	bne	a5,s1,ffffffffc020150c <_fifo_check_swap+0x294>
ffffffffc0201348:	00007517          	auipc	a0,0x7
ffffffffc020134c:	7b050513          	addi	a0,a0,1968 # ffffffffc0208af8 <commands+0x908>
ffffffffc0201350:	d7dfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201354:	016a8023          	sb	s6,0(s5)
ffffffffc0201358:	401c                	lw	a5,0(s0)
ffffffffc020135a:	4719                	li	a4,6
ffffffffc020135c:	2781                	sext.w	a5,a5
ffffffffc020135e:	18e79763          	bne	a5,a4,ffffffffc02014ec <_fifo_check_swap+0x274>
ffffffffc0201362:	00007517          	auipc	a0,0x7
ffffffffc0201366:	7e650513          	addi	a0,a0,2022 # ffffffffc0208b48 <commands+0x958>
ffffffffc020136a:	d63fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020136e:	01ac8023          	sb	s10,0(s9)
ffffffffc0201372:	401c                	lw	a5,0(s0)
ffffffffc0201374:	471d                	li	a4,7
ffffffffc0201376:	2781                	sext.w	a5,a5
ffffffffc0201378:	14e79a63          	bne	a5,a4,ffffffffc02014cc <_fifo_check_swap+0x254>
ffffffffc020137c:	00007517          	auipc	a0,0x7
ffffffffc0201380:	72c50513          	addi	a0,a0,1836 # ffffffffc0208aa8 <commands+0x8b8>
ffffffffc0201384:	d49fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201388:	01498023          	sb	s4,0(s3)
ffffffffc020138c:	401c                	lw	a5,0(s0)
ffffffffc020138e:	4721                	li	a4,8
ffffffffc0201390:	2781                	sext.w	a5,a5
ffffffffc0201392:	10e79d63          	bne	a5,a4,ffffffffc02014ac <_fifo_check_swap+0x234>
ffffffffc0201396:	00007517          	auipc	a0,0x7
ffffffffc020139a:	78a50513          	addi	a0,a0,1930 # ffffffffc0208b20 <commands+0x930>
ffffffffc020139e:	d2ffe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02013a2:	018b8023          	sb	s8,0(s7)
ffffffffc02013a6:	401c                	lw	a5,0(s0)
ffffffffc02013a8:	4725                	li	a4,9
ffffffffc02013aa:	2781                	sext.w	a5,a5
ffffffffc02013ac:	0ee79063          	bne	a5,a4,ffffffffc020148c <_fifo_check_swap+0x214>
ffffffffc02013b0:	00007517          	auipc	a0,0x7
ffffffffc02013b4:	7c050513          	addi	a0,a0,1984 # ffffffffc0208b70 <commands+0x980>
ffffffffc02013b8:	d15fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02013bc:	6795                	lui	a5,0x5
ffffffffc02013be:	4739                	li	a4,14
ffffffffc02013c0:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc02013c4:	4004                	lw	s1,0(s0)
ffffffffc02013c6:	47a9                	li	a5,10
ffffffffc02013c8:	2481                	sext.w	s1,s1
ffffffffc02013ca:	0af49163          	bne	s1,a5,ffffffffc020146c <_fifo_check_swap+0x1f4>
ffffffffc02013ce:	00007517          	auipc	a0,0x7
ffffffffc02013d2:	72a50513          	addi	a0,a0,1834 # ffffffffc0208af8 <commands+0x908>
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
ffffffffc0201410:	6c468693          	addi	a3,a3,1732 # ffffffffc0208ad0 <commands+0x8e0>
ffffffffc0201414:	00007617          	auipc	a2,0x7
ffffffffc0201418:	1ec60613          	addi	a2,a2,492 # ffffffffc0208600 <commands+0x410>
ffffffffc020141c:	05100593          	li	a1,81
ffffffffc0201420:	00007517          	auipc	a0,0x7
ffffffffc0201424:	6c050513          	addi	a0,a0,1728 # ffffffffc0208ae0 <commands+0x8f0>
ffffffffc0201428:	de1fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020142c:	00007697          	auipc	a3,0x7
ffffffffc0201430:	7f468693          	addi	a3,a3,2036 # ffffffffc0208c20 <commands+0xa30>
ffffffffc0201434:	00007617          	auipc	a2,0x7
ffffffffc0201438:	1cc60613          	addi	a2,a2,460 # ffffffffc0208600 <commands+0x410>
ffffffffc020143c:	07300593          	li	a1,115
ffffffffc0201440:	00007517          	auipc	a0,0x7
ffffffffc0201444:	6a050513          	addi	a0,a0,1696 # ffffffffc0208ae0 <commands+0x8f0>
ffffffffc0201448:	dc1fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020144c:	00007697          	auipc	a3,0x7
ffffffffc0201450:	7ac68693          	addi	a3,a3,1964 # ffffffffc0208bf8 <commands+0xa08>
ffffffffc0201454:	00007617          	auipc	a2,0x7
ffffffffc0201458:	1ac60613          	addi	a2,a2,428 # ffffffffc0208600 <commands+0x410>
ffffffffc020145c:	07100593          	li	a1,113
ffffffffc0201460:	00007517          	auipc	a0,0x7
ffffffffc0201464:	68050513          	addi	a0,a0,1664 # ffffffffc0208ae0 <commands+0x8f0>
ffffffffc0201468:	da1fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020146c:	00007697          	auipc	a3,0x7
ffffffffc0201470:	77c68693          	addi	a3,a3,1916 # ffffffffc0208be8 <commands+0x9f8>
ffffffffc0201474:	00007617          	auipc	a2,0x7
ffffffffc0201478:	18c60613          	addi	a2,a2,396 # ffffffffc0208600 <commands+0x410>
ffffffffc020147c:	06f00593          	li	a1,111
ffffffffc0201480:	00007517          	auipc	a0,0x7
ffffffffc0201484:	66050513          	addi	a0,a0,1632 # ffffffffc0208ae0 <commands+0x8f0>
ffffffffc0201488:	d81fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020148c:	00007697          	auipc	a3,0x7
ffffffffc0201490:	74c68693          	addi	a3,a3,1868 # ffffffffc0208bd8 <commands+0x9e8>
ffffffffc0201494:	00007617          	auipc	a2,0x7
ffffffffc0201498:	16c60613          	addi	a2,a2,364 # ffffffffc0208600 <commands+0x410>
ffffffffc020149c:	06c00593          	li	a1,108
ffffffffc02014a0:	00007517          	auipc	a0,0x7
ffffffffc02014a4:	64050513          	addi	a0,a0,1600 # ffffffffc0208ae0 <commands+0x8f0>
ffffffffc02014a8:	d61fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02014ac:	00007697          	auipc	a3,0x7
ffffffffc02014b0:	71c68693          	addi	a3,a3,1820 # ffffffffc0208bc8 <commands+0x9d8>
ffffffffc02014b4:	00007617          	auipc	a2,0x7
ffffffffc02014b8:	14c60613          	addi	a2,a2,332 # ffffffffc0208600 <commands+0x410>
ffffffffc02014bc:	06900593          	li	a1,105
ffffffffc02014c0:	00007517          	auipc	a0,0x7
ffffffffc02014c4:	62050513          	addi	a0,a0,1568 # ffffffffc0208ae0 <commands+0x8f0>
ffffffffc02014c8:	d41fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02014cc:	00007697          	auipc	a3,0x7
ffffffffc02014d0:	6ec68693          	addi	a3,a3,1772 # ffffffffc0208bb8 <commands+0x9c8>
ffffffffc02014d4:	00007617          	auipc	a2,0x7
ffffffffc02014d8:	12c60613          	addi	a2,a2,300 # ffffffffc0208600 <commands+0x410>
ffffffffc02014dc:	06600593          	li	a1,102
ffffffffc02014e0:	00007517          	auipc	a0,0x7
ffffffffc02014e4:	60050513          	addi	a0,a0,1536 # ffffffffc0208ae0 <commands+0x8f0>
ffffffffc02014e8:	d21fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02014ec:	00007697          	auipc	a3,0x7
ffffffffc02014f0:	6bc68693          	addi	a3,a3,1724 # ffffffffc0208ba8 <commands+0x9b8>
ffffffffc02014f4:	00007617          	auipc	a2,0x7
ffffffffc02014f8:	10c60613          	addi	a2,a2,268 # ffffffffc0208600 <commands+0x410>
ffffffffc02014fc:	06300593          	li	a1,99
ffffffffc0201500:	00007517          	auipc	a0,0x7
ffffffffc0201504:	5e050513          	addi	a0,a0,1504 # ffffffffc0208ae0 <commands+0x8f0>
ffffffffc0201508:	d01fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020150c:	00007697          	auipc	a3,0x7
ffffffffc0201510:	68c68693          	addi	a3,a3,1676 # ffffffffc0208b98 <commands+0x9a8>
ffffffffc0201514:	00007617          	auipc	a2,0x7
ffffffffc0201518:	0ec60613          	addi	a2,a2,236 # ffffffffc0208600 <commands+0x410>
ffffffffc020151c:	06000593          	li	a1,96
ffffffffc0201520:	00007517          	auipc	a0,0x7
ffffffffc0201524:	5c050513          	addi	a0,a0,1472 # ffffffffc0208ae0 <commands+0x8f0>
ffffffffc0201528:	ce1fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020152c:	00007697          	auipc	a3,0x7
ffffffffc0201530:	66c68693          	addi	a3,a3,1644 # ffffffffc0208b98 <commands+0x9a8>
ffffffffc0201534:	00007617          	auipc	a2,0x7
ffffffffc0201538:	0cc60613          	addi	a2,a2,204 # ffffffffc0208600 <commands+0x410>
ffffffffc020153c:	05d00593          	li	a1,93
ffffffffc0201540:	00007517          	auipc	a0,0x7
ffffffffc0201544:	5a050513          	addi	a0,a0,1440 # ffffffffc0208ae0 <commands+0x8f0>
ffffffffc0201548:	cc1fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020154c:	00007697          	auipc	a3,0x7
ffffffffc0201550:	58468693          	addi	a3,a3,1412 # ffffffffc0208ad0 <commands+0x8e0>
ffffffffc0201554:	00007617          	auipc	a2,0x7
ffffffffc0201558:	0ac60613          	addi	a2,a2,172 # ffffffffc0208600 <commands+0x410>
ffffffffc020155c:	05a00593          	li	a1,90
ffffffffc0201560:	00007517          	auipc	a0,0x7
ffffffffc0201564:	58050513          	addi	a0,a0,1408 # ffffffffc0208ae0 <commands+0x8f0>
ffffffffc0201568:	ca1fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020156c:	00007697          	auipc	a3,0x7
ffffffffc0201570:	56468693          	addi	a3,a3,1380 # ffffffffc0208ad0 <commands+0x8e0>
ffffffffc0201574:	00007617          	auipc	a2,0x7
ffffffffc0201578:	08c60613          	addi	a2,a2,140 # ffffffffc0208600 <commands+0x410>
ffffffffc020157c:	05700593          	li	a1,87
ffffffffc0201580:	00007517          	auipc	a0,0x7
ffffffffc0201584:	56050513          	addi	a0,a0,1376 # ffffffffc0208ae0 <commands+0x8f0>
ffffffffc0201588:	c81fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020158c:	00007697          	auipc	a3,0x7
ffffffffc0201590:	54468693          	addi	a3,a3,1348 # ffffffffc0208ad0 <commands+0x8e0>
ffffffffc0201594:	00007617          	auipc	a2,0x7
ffffffffc0201598:	06c60613          	addi	a2,a2,108 # ffffffffc0208600 <commands+0x410>
ffffffffc020159c:	05400593          	li	a1,84
ffffffffc02015a0:	00007517          	auipc	a0,0x7
ffffffffc02015a4:	54050513          	addi	a0,a0,1344 # ffffffffc0208ae0 <commands+0x8f0>
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
ffffffffc02015d2:	66268693          	addi	a3,a3,1634 # ffffffffc0208c30 <commands+0xa40>
ffffffffc02015d6:	00007617          	auipc	a2,0x7
ffffffffc02015da:	02a60613          	addi	a2,a2,42 # ffffffffc0208600 <commands+0x410>
ffffffffc02015de:	04100593          	li	a1,65
ffffffffc02015e2:	00007517          	auipc	a0,0x7
ffffffffc02015e6:	4fe50513          	addi	a0,a0,1278 # ffffffffc0208ae0 <commands+0x8f0>
ffffffffc02015ea:	c1ffe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02015ee:	00007697          	auipc	a3,0x7
ffffffffc02015f2:	65268693          	addi	a3,a3,1618 # ffffffffc0208c40 <commands+0xa50>
ffffffffc02015f6:	00007617          	auipc	a2,0x7
ffffffffc02015fa:	00a60613          	addi	a2,a2,10 # ffffffffc0208600 <commands+0x410>
ffffffffc02015fe:	04200593          	li	a1,66
ffffffffc0201602:	00007517          	auipc	a0,0x7
ffffffffc0201606:	4de50513          	addi	a0,a0,1246 # ffffffffc0208ae0 <commands+0x8f0>
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
ffffffffc020162a:	62a68693          	addi	a3,a3,1578 # ffffffffc0208c50 <commands+0xa60>
ffffffffc020162e:	00007617          	auipc	a2,0x7
ffffffffc0201632:	fd260613          	addi	a2,a2,-46 # ffffffffc0208600 <commands+0x410>
ffffffffc0201636:	03200593          	li	a1,50
ffffffffc020163a:	00007517          	auipc	a0,0x7
ffffffffc020163e:	4a650513          	addi	a0,a0,1190 # ffffffffc0208ae0 <commands+0x8f0>
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
ffffffffc02016fe:	f4e6b683          	ld	a3,-178(a3) # ffffffffc0219648 <pages>
ffffffffc0201702:	8d15                	sub	a0,a0,a3
ffffffffc0201704:	8519                	srai	a0,a0,0x6
ffffffffc0201706:	00009697          	auipc	a3,0x9
ffffffffc020170a:	e9a6b683          	ld	a3,-358(a3) # ffffffffc020a5a0 <nbase>
ffffffffc020170e:	9536                	add	a0,a0,a3
ffffffffc0201710:	00c51793          	slli	a5,a0,0xc
ffffffffc0201714:	83b1                	srli	a5,a5,0xc
ffffffffc0201716:	00018717          	auipc	a4,0x18
ffffffffc020171a:	dda73703          	ld	a4,-550(a4) # ffffffffc02194f0 <npage>
ffffffffc020171e:	0532                	slli	a0,a0,0xc
ffffffffc0201720:	00e7fa63          	bgeu	a5,a4,ffffffffc0201734 <__slob_get_free_pages.isra.0+0x4a>
ffffffffc0201724:	00018697          	auipc	a3,0x18
ffffffffc0201728:	f146b683          	ld	a3,-236(a3) # ffffffffc0219638 <va_pa_offset>
ffffffffc020172c:	9536                	add	a0,a0,a3
ffffffffc020172e:	60a2                	ld	ra,8(sp)
ffffffffc0201730:	0141                	addi	sp,sp,16
ffffffffc0201732:	8082                	ret
ffffffffc0201734:	86aa                	mv	a3,a0
ffffffffc0201736:	00007617          	auipc	a2,0x7
ffffffffc020173a:	55260613          	addi	a2,a2,1362 # ffffffffc0208c88 <commands+0xa98>
ffffffffc020173e:	06900593          	li	a1,105
ffffffffc0201742:	00007517          	auipc	a0,0x7
ffffffffc0201746:	56e50513          	addi	a0,a0,1390 # ffffffffc0208cb0 <commands+0xac0>
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
ffffffffc0201828:	49c68693          	addi	a3,a3,1180 # ffffffffc0208cc0 <commands+0xad0>
ffffffffc020182c:	00007617          	auipc	a2,0x7
ffffffffc0201830:	dd460613          	addi	a2,a2,-556 # ffffffffc0208600 <commands+0x410>
ffffffffc0201834:	06400593          	li	a1,100
ffffffffc0201838:	00007517          	auipc	a0,0x7
ffffffffc020183c:	4a850513          	addi	a0,a0,1192 # ffffffffc0208ce0 <commands+0xaf0>
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
ffffffffc020194a:	cf26b683          	ld	a3,-782(a3) # ffffffffc0219638 <va_pa_offset>
ffffffffc020194e:	8c15                	sub	s0,s0,a3
ffffffffc0201950:	8031                	srli	s0,s0,0xc
ffffffffc0201952:	00018797          	auipc	a5,0x18
ffffffffc0201956:	b9e7b783          	ld	a5,-1122(a5) # ffffffffc02194f0 <npage>
ffffffffc020195a:	06f47163          	bgeu	s0,a5,ffffffffc02019bc <kfree+0xc4>
ffffffffc020195e:	00009517          	auipc	a0,0x9
ffffffffc0201962:	c4253503          	ld	a0,-958(a0) # ffffffffc020a5a0 <nbase>
ffffffffc0201966:	8c09                	sub	s0,s0,a0
ffffffffc0201968:	041a                	slli	s0,s0,0x6
ffffffffc020196a:	00018517          	auipc	a0,0x18
ffffffffc020196e:	cde53503          	ld	a0,-802(a0) # ffffffffc0219648 <pages>
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
ffffffffc02019c0:	36460613          	addi	a2,a2,868 # ffffffffc0208d20 <commands+0xb30>
ffffffffc02019c4:	06200593          	li	a1,98
ffffffffc02019c8:	00007517          	auipc	a0,0x7
ffffffffc02019cc:	2e850513          	addi	a0,a0,744 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc02019d0:	839fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02019d4:	86a2                	mv	a3,s0
ffffffffc02019d6:	00007617          	auipc	a2,0x7
ffffffffc02019da:	32260613          	addi	a2,a2,802 # ffffffffc0208cf8 <commands+0xb08>
ffffffffc02019de:	06e00593          	li	a1,110
ffffffffc02019e2:	00007517          	auipc	a0,0x7
ffffffffc02019e6:	2ce50513          	addi	a0,a0,718 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc02019ea:	81ffe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02019ee <swap_init>:
ffffffffc02019ee:	1101                	addi	sp,sp,-32
ffffffffc02019f0:	ec06                	sd	ra,24(sp)
ffffffffc02019f2:	e822                	sd	s0,16(sp)
ffffffffc02019f4:	e426                	sd	s1,8(sp)
ffffffffc02019f6:	355010ef          	jal	ra,ffffffffc020354a <swapfs_init>
ffffffffc02019fa:	00018697          	auipc	a3,0x18
ffffffffc02019fe:	bde6b683          	ld	a3,-1058(a3) # ffffffffc02195d8 <max_swap_offset>
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
ffffffffc0201a3c:	33850513          	addi	a0,a0,824 # ffffffffc0208d70 <commands+0xb80>
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
ffffffffc0201a60:	2e460613          	addi	a2,a2,740 # ffffffffc0208d40 <commands+0xb50>
ffffffffc0201a64:	02800593          	li	a1,40
ffffffffc0201a68:	00007517          	auipc	a0,0x7
ffffffffc0201a6c:	2f850513          	addi	a0,a0,760 # ffffffffc0208d60 <commands+0xb70>
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
ffffffffc0201abc:	330b0b13          	addi	s6,s6,816 # ffffffffc0208de8 <commands+0xbf8>
ffffffffc0201ac0:	00007b97          	auipc	s7,0x7
ffffffffc0201ac4:	310b8b93          	addi	s7,s7,784 # ffffffffc0208dd0 <commands+0xbe0>
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
ffffffffc0201b34:	2dd010ef          	jal	ra,ffffffffc0203610 <swapfs_write>
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
ffffffffc0201b76:	21650513          	addi	a0,a0,534 # ffffffffc0208d88 <commands+0xb98>
ffffffffc0201b7a:	d52fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201b7e:	bfe1                	j	ffffffffc0201b56 <swap_out+0xc6>
ffffffffc0201b80:	4401                	li	s0,0
ffffffffc0201b82:	bfd1                	j	ffffffffc0201b56 <swap_out+0xc6>
ffffffffc0201b84:	00007697          	auipc	a3,0x7
ffffffffc0201b88:	23468693          	addi	a3,a3,564 # ffffffffc0208db8 <commands+0xbc8>
ffffffffc0201b8c:	00007617          	auipc	a2,0x7
ffffffffc0201b90:	a7460613          	addi	a2,a2,-1420 # ffffffffc0208600 <commands+0x410>
ffffffffc0201b94:	06800593          	li	a1,104
ffffffffc0201b98:	00007517          	auipc	a0,0x7
ffffffffc0201b9c:	1c850513          	addi	a0,a0,456 # ffffffffc0208d60 <commands+0xb70>
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
ffffffffc0201bd2:	1b1010ef          	jal	ra,ffffffffc0203582 <swapfs_read>
ffffffffc0201bd6:	00093583          	ld	a1,0(s2)
ffffffffc0201bda:	8626                	mv	a2,s1
ffffffffc0201bdc:	00007517          	auipc	a0,0x7
ffffffffc0201be0:	25c50513          	addi	a0,a0,604 # ffffffffc0208e38 <commands+0xc48>
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
ffffffffc0201c02:	22a68693          	addi	a3,a3,554 # ffffffffc0208e28 <commands+0xc38>
ffffffffc0201c06:	00007617          	auipc	a2,0x7
ffffffffc0201c0a:	9fa60613          	addi	a2,a2,-1542 # ffffffffc0208600 <commands+0x410>
ffffffffc0201c0e:	07e00593          	li	a1,126
ffffffffc0201c12:	00007517          	auipc	a0,0x7
ffffffffc0201c16:	14e50513          	addi	a0,a0,334 # ffffffffc0208d60 <commands+0xb70>
ffffffffc0201c1a:	deefe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201c1e <default_init>:
ffffffffc0201c1e:	00018797          	auipc	a5,0x18
ffffffffc0201c22:	9fa78793          	addi	a5,a5,-1542 # ffffffffc0219618 <free_area>
ffffffffc0201c26:	e79c                	sd	a5,8(a5)
ffffffffc0201c28:	e39c                	sd	a5,0(a5)
ffffffffc0201c2a:	0007a823          	sw	zero,16(a5)
ffffffffc0201c2e:	8082                	ret

ffffffffc0201c30 <default_nr_free_pages>:
ffffffffc0201c30:	00018517          	auipc	a0,0x18
ffffffffc0201c34:	9f856503          	lwu	a0,-1544(a0) # ffffffffc0219628 <free_area+0x10>
ffffffffc0201c38:	8082                	ret

ffffffffc0201c3a <default_check>:
ffffffffc0201c3a:	715d                	addi	sp,sp,-80
ffffffffc0201c3c:	e0a2                	sd	s0,64(sp)
ffffffffc0201c3e:	00018417          	auipc	s0,0x18
ffffffffc0201c42:	9da40413          	addi	s0,s0,-1574 # ffffffffc0219618 <free_area>
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
ffffffffc0201cce:	97e7b783          	ld	a5,-1666(a5) # ffffffffc0219648 <pages>
ffffffffc0201cd2:	40fa8733          	sub	a4,s5,a5
ffffffffc0201cd6:	00009617          	auipc	a2,0x9
ffffffffc0201cda:	8ca63603          	ld	a2,-1846(a2) # ffffffffc020a5a0 <nbase>
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
ffffffffc0201d24:	9007a423          	sw	zero,-1784(a5) # ffffffffc0219628 <free_area+0x10>
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
ffffffffc0201e06:	8207a323          	sw	zero,-2010(a5) # ffffffffc0219628 <free_area+0x10>
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
ffffffffc0201f20:	f5c68693          	addi	a3,a3,-164 # ffffffffc0208e78 <commands+0xc88>
ffffffffc0201f24:	00006617          	auipc	a2,0x6
ffffffffc0201f28:	6dc60613          	addi	a2,a2,1756 # ffffffffc0208600 <commands+0x410>
ffffffffc0201f2c:	0f000593          	li	a1,240
ffffffffc0201f30:	00007517          	auipc	a0,0x7
ffffffffc0201f34:	f5850513          	addi	a0,a0,-168 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0201f38:	ad0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201f3c:	00007697          	auipc	a3,0x7
ffffffffc0201f40:	fe468693          	addi	a3,a3,-28 # ffffffffc0208f20 <commands+0xd30>
ffffffffc0201f44:	00006617          	auipc	a2,0x6
ffffffffc0201f48:	6bc60613          	addi	a2,a2,1724 # ffffffffc0208600 <commands+0x410>
ffffffffc0201f4c:	0bd00593          	li	a1,189
ffffffffc0201f50:	00007517          	auipc	a0,0x7
ffffffffc0201f54:	f3850513          	addi	a0,a0,-200 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0201f58:	ab0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201f5c:	00007697          	auipc	a3,0x7
ffffffffc0201f60:	fec68693          	addi	a3,a3,-20 # ffffffffc0208f48 <commands+0xd58>
ffffffffc0201f64:	00006617          	auipc	a2,0x6
ffffffffc0201f68:	69c60613          	addi	a2,a2,1692 # ffffffffc0208600 <commands+0x410>
ffffffffc0201f6c:	0be00593          	li	a1,190
ffffffffc0201f70:	00007517          	auipc	a0,0x7
ffffffffc0201f74:	f1850513          	addi	a0,a0,-232 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0201f78:	a90fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201f7c:	00007697          	auipc	a3,0x7
ffffffffc0201f80:	00c68693          	addi	a3,a3,12 # ffffffffc0208f88 <commands+0xd98>
ffffffffc0201f84:	00006617          	auipc	a2,0x6
ffffffffc0201f88:	67c60613          	addi	a2,a2,1660 # ffffffffc0208600 <commands+0x410>
ffffffffc0201f8c:	0c000593          	li	a1,192
ffffffffc0201f90:	00007517          	auipc	a0,0x7
ffffffffc0201f94:	ef850513          	addi	a0,a0,-264 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0201f98:	a70fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201f9c:	00007697          	auipc	a3,0x7
ffffffffc0201fa0:	07468693          	addi	a3,a3,116 # ffffffffc0209010 <commands+0xe20>
ffffffffc0201fa4:	00006617          	auipc	a2,0x6
ffffffffc0201fa8:	65c60613          	addi	a2,a2,1628 # ffffffffc0208600 <commands+0x410>
ffffffffc0201fac:	0d900593          	li	a1,217
ffffffffc0201fb0:	00007517          	auipc	a0,0x7
ffffffffc0201fb4:	ed850513          	addi	a0,a0,-296 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0201fb8:	a50fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201fbc:	00007697          	auipc	a3,0x7
ffffffffc0201fc0:	f0468693          	addi	a3,a3,-252 # ffffffffc0208ec0 <commands+0xcd0>
ffffffffc0201fc4:	00006617          	auipc	a2,0x6
ffffffffc0201fc8:	63c60613          	addi	a2,a2,1596 # ffffffffc0208600 <commands+0x410>
ffffffffc0201fcc:	0d200593          	li	a1,210
ffffffffc0201fd0:	00007517          	auipc	a0,0x7
ffffffffc0201fd4:	eb850513          	addi	a0,a0,-328 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0201fd8:	a30fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201fdc:	00007697          	auipc	a3,0x7
ffffffffc0201fe0:	02468693          	addi	a3,a3,36 # ffffffffc0209000 <commands+0xe10>
ffffffffc0201fe4:	00006617          	auipc	a2,0x6
ffffffffc0201fe8:	61c60613          	addi	a2,a2,1564 # ffffffffc0208600 <commands+0x410>
ffffffffc0201fec:	0d000593          	li	a1,208
ffffffffc0201ff0:	00007517          	auipc	a0,0x7
ffffffffc0201ff4:	e9850513          	addi	a0,a0,-360 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0201ff8:	a10fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201ffc:	00007697          	auipc	a3,0x7
ffffffffc0202000:	fec68693          	addi	a3,a3,-20 # ffffffffc0208fe8 <commands+0xdf8>
ffffffffc0202004:	00006617          	auipc	a2,0x6
ffffffffc0202008:	5fc60613          	addi	a2,a2,1532 # ffffffffc0208600 <commands+0x410>
ffffffffc020200c:	0cb00593          	li	a1,203
ffffffffc0202010:	00007517          	auipc	a0,0x7
ffffffffc0202014:	e7850513          	addi	a0,a0,-392 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202018:	9f0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020201c:	00007697          	auipc	a3,0x7
ffffffffc0202020:	fac68693          	addi	a3,a3,-84 # ffffffffc0208fc8 <commands+0xdd8>
ffffffffc0202024:	00006617          	auipc	a2,0x6
ffffffffc0202028:	5dc60613          	addi	a2,a2,1500 # ffffffffc0208600 <commands+0x410>
ffffffffc020202c:	0c200593          	li	a1,194
ffffffffc0202030:	00007517          	auipc	a0,0x7
ffffffffc0202034:	e5850513          	addi	a0,a0,-424 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202038:	9d0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020203c:	00007697          	auipc	a3,0x7
ffffffffc0202040:	01c68693          	addi	a3,a3,28 # ffffffffc0209058 <commands+0xe68>
ffffffffc0202044:	00006617          	auipc	a2,0x6
ffffffffc0202048:	5bc60613          	addi	a2,a2,1468 # ffffffffc0208600 <commands+0x410>
ffffffffc020204c:	0f800593          	li	a1,248
ffffffffc0202050:	00007517          	auipc	a0,0x7
ffffffffc0202054:	e3850513          	addi	a0,a0,-456 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202058:	9b0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020205c:	00007697          	auipc	a3,0x7
ffffffffc0202060:	fec68693          	addi	a3,a3,-20 # ffffffffc0209048 <commands+0xe58>
ffffffffc0202064:	00006617          	auipc	a2,0x6
ffffffffc0202068:	59c60613          	addi	a2,a2,1436 # ffffffffc0208600 <commands+0x410>
ffffffffc020206c:	0df00593          	li	a1,223
ffffffffc0202070:	00007517          	auipc	a0,0x7
ffffffffc0202074:	e1850513          	addi	a0,a0,-488 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202078:	990fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020207c:	00007697          	auipc	a3,0x7
ffffffffc0202080:	f6c68693          	addi	a3,a3,-148 # ffffffffc0208fe8 <commands+0xdf8>
ffffffffc0202084:	00006617          	auipc	a2,0x6
ffffffffc0202088:	57c60613          	addi	a2,a2,1404 # ffffffffc0208600 <commands+0x410>
ffffffffc020208c:	0dd00593          	li	a1,221
ffffffffc0202090:	00007517          	auipc	a0,0x7
ffffffffc0202094:	df850513          	addi	a0,a0,-520 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202098:	970fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020209c:	00007697          	auipc	a3,0x7
ffffffffc02020a0:	f8c68693          	addi	a3,a3,-116 # ffffffffc0209028 <commands+0xe38>
ffffffffc02020a4:	00006617          	auipc	a2,0x6
ffffffffc02020a8:	55c60613          	addi	a2,a2,1372 # ffffffffc0208600 <commands+0x410>
ffffffffc02020ac:	0dc00593          	li	a1,220
ffffffffc02020b0:	00007517          	auipc	a0,0x7
ffffffffc02020b4:	dd850513          	addi	a0,a0,-552 # ffffffffc0208e88 <commands+0xc98>
ffffffffc02020b8:	950fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02020bc:	00007697          	auipc	a3,0x7
ffffffffc02020c0:	e0468693          	addi	a3,a3,-508 # ffffffffc0208ec0 <commands+0xcd0>
ffffffffc02020c4:	00006617          	auipc	a2,0x6
ffffffffc02020c8:	53c60613          	addi	a2,a2,1340 # ffffffffc0208600 <commands+0x410>
ffffffffc02020cc:	0b900593          	li	a1,185
ffffffffc02020d0:	00007517          	auipc	a0,0x7
ffffffffc02020d4:	db850513          	addi	a0,a0,-584 # ffffffffc0208e88 <commands+0xc98>
ffffffffc02020d8:	930fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02020dc:	00007697          	auipc	a3,0x7
ffffffffc02020e0:	f0c68693          	addi	a3,a3,-244 # ffffffffc0208fe8 <commands+0xdf8>
ffffffffc02020e4:	00006617          	auipc	a2,0x6
ffffffffc02020e8:	51c60613          	addi	a2,a2,1308 # ffffffffc0208600 <commands+0x410>
ffffffffc02020ec:	0d600593          	li	a1,214
ffffffffc02020f0:	00007517          	auipc	a0,0x7
ffffffffc02020f4:	d9850513          	addi	a0,a0,-616 # ffffffffc0208e88 <commands+0xc98>
ffffffffc02020f8:	910fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02020fc:	00007697          	auipc	a3,0x7
ffffffffc0202100:	e0468693          	addi	a3,a3,-508 # ffffffffc0208f00 <commands+0xd10>
ffffffffc0202104:	00006617          	auipc	a2,0x6
ffffffffc0202108:	4fc60613          	addi	a2,a2,1276 # ffffffffc0208600 <commands+0x410>
ffffffffc020210c:	0d400593          	li	a1,212
ffffffffc0202110:	00007517          	auipc	a0,0x7
ffffffffc0202114:	d7850513          	addi	a0,a0,-648 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202118:	8f0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020211c:	00007697          	auipc	a3,0x7
ffffffffc0202120:	dc468693          	addi	a3,a3,-572 # ffffffffc0208ee0 <commands+0xcf0>
ffffffffc0202124:	00006617          	auipc	a2,0x6
ffffffffc0202128:	4dc60613          	addi	a2,a2,1244 # ffffffffc0208600 <commands+0x410>
ffffffffc020212c:	0d300593          	li	a1,211
ffffffffc0202130:	00007517          	auipc	a0,0x7
ffffffffc0202134:	d5850513          	addi	a0,a0,-680 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202138:	8d0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020213c:	00007697          	auipc	a3,0x7
ffffffffc0202140:	dc468693          	addi	a3,a3,-572 # ffffffffc0208f00 <commands+0xd10>
ffffffffc0202144:	00006617          	auipc	a2,0x6
ffffffffc0202148:	4bc60613          	addi	a2,a2,1212 # ffffffffc0208600 <commands+0x410>
ffffffffc020214c:	0bb00593          	li	a1,187
ffffffffc0202150:	00007517          	auipc	a0,0x7
ffffffffc0202154:	d3850513          	addi	a0,a0,-712 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202158:	8b0fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020215c:	00007697          	auipc	a3,0x7
ffffffffc0202160:	04c68693          	addi	a3,a3,76 # ffffffffc02091a8 <commands+0xfb8>
ffffffffc0202164:	00006617          	auipc	a2,0x6
ffffffffc0202168:	49c60613          	addi	a2,a2,1180 # ffffffffc0208600 <commands+0x410>
ffffffffc020216c:	12500593          	li	a1,293
ffffffffc0202170:	00007517          	auipc	a0,0x7
ffffffffc0202174:	d1850513          	addi	a0,a0,-744 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202178:	890fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020217c:	00007697          	auipc	a3,0x7
ffffffffc0202180:	ecc68693          	addi	a3,a3,-308 # ffffffffc0209048 <commands+0xe58>
ffffffffc0202184:	00006617          	auipc	a2,0x6
ffffffffc0202188:	47c60613          	addi	a2,a2,1148 # ffffffffc0208600 <commands+0x410>
ffffffffc020218c:	11a00593          	li	a1,282
ffffffffc0202190:	00007517          	auipc	a0,0x7
ffffffffc0202194:	cf850513          	addi	a0,a0,-776 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202198:	870fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020219c:	00007697          	auipc	a3,0x7
ffffffffc02021a0:	e4c68693          	addi	a3,a3,-436 # ffffffffc0208fe8 <commands+0xdf8>
ffffffffc02021a4:	00006617          	auipc	a2,0x6
ffffffffc02021a8:	45c60613          	addi	a2,a2,1116 # ffffffffc0208600 <commands+0x410>
ffffffffc02021ac:	11800593          	li	a1,280
ffffffffc02021b0:	00007517          	auipc	a0,0x7
ffffffffc02021b4:	cd850513          	addi	a0,a0,-808 # ffffffffc0208e88 <commands+0xc98>
ffffffffc02021b8:	850fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02021bc:	00007697          	auipc	a3,0x7
ffffffffc02021c0:	dec68693          	addi	a3,a3,-532 # ffffffffc0208fa8 <commands+0xdb8>
ffffffffc02021c4:	00006617          	auipc	a2,0x6
ffffffffc02021c8:	43c60613          	addi	a2,a2,1084 # ffffffffc0208600 <commands+0x410>
ffffffffc02021cc:	0c100593          	li	a1,193
ffffffffc02021d0:	00007517          	auipc	a0,0x7
ffffffffc02021d4:	cb850513          	addi	a0,a0,-840 # ffffffffc0208e88 <commands+0xc98>
ffffffffc02021d8:	830fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02021dc:	00007697          	auipc	a3,0x7
ffffffffc02021e0:	f8c68693          	addi	a3,a3,-116 # ffffffffc0209168 <commands+0xf78>
ffffffffc02021e4:	00006617          	auipc	a2,0x6
ffffffffc02021e8:	41c60613          	addi	a2,a2,1052 # ffffffffc0208600 <commands+0x410>
ffffffffc02021ec:	11200593          	li	a1,274
ffffffffc02021f0:	00007517          	auipc	a0,0x7
ffffffffc02021f4:	c9850513          	addi	a0,a0,-872 # ffffffffc0208e88 <commands+0xc98>
ffffffffc02021f8:	810fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02021fc:	00007697          	auipc	a3,0x7
ffffffffc0202200:	f4c68693          	addi	a3,a3,-180 # ffffffffc0209148 <commands+0xf58>
ffffffffc0202204:	00006617          	auipc	a2,0x6
ffffffffc0202208:	3fc60613          	addi	a2,a2,1020 # ffffffffc0208600 <commands+0x410>
ffffffffc020220c:	11000593          	li	a1,272
ffffffffc0202210:	00007517          	auipc	a0,0x7
ffffffffc0202214:	c7850513          	addi	a0,a0,-904 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202218:	ff1fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020221c:	00007697          	auipc	a3,0x7
ffffffffc0202220:	f0468693          	addi	a3,a3,-252 # ffffffffc0209120 <commands+0xf30>
ffffffffc0202224:	00006617          	auipc	a2,0x6
ffffffffc0202228:	3dc60613          	addi	a2,a2,988 # ffffffffc0208600 <commands+0x410>
ffffffffc020222c:	10e00593          	li	a1,270
ffffffffc0202230:	00007517          	auipc	a0,0x7
ffffffffc0202234:	c5850513          	addi	a0,a0,-936 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202238:	fd1fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020223c:	00007697          	auipc	a3,0x7
ffffffffc0202240:	ebc68693          	addi	a3,a3,-324 # ffffffffc02090f8 <commands+0xf08>
ffffffffc0202244:	00006617          	auipc	a2,0x6
ffffffffc0202248:	3bc60613          	addi	a2,a2,956 # ffffffffc0208600 <commands+0x410>
ffffffffc020224c:	10d00593          	li	a1,269
ffffffffc0202250:	00007517          	auipc	a0,0x7
ffffffffc0202254:	c3850513          	addi	a0,a0,-968 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202258:	fb1fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020225c:	00007697          	auipc	a3,0x7
ffffffffc0202260:	e8c68693          	addi	a3,a3,-372 # ffffffffc02090e8 <commands+0xef8>
ffffffffc0202264:	00006617          	auipc	a2,0x6
ffffffffc0202268:	39c60613          	addi	a2,a2,924 # ffffffffc0208600 <commands+0x410>
ffffffffc020226c:	10800593          	li	a1,264
ffffffffc0202270:	00007517          	auipc	a0,0x7
ffffffffc0202274:	c1850513          	addi	a0,a0,-1000 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202278:	f91fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020227c:	00007697          	auipc	a3,0x7
ffffffffc0202280:	d6c68693          	addi	a3,a3,-660 # ffffffffc0208fe8 <commands+0xdf8>
ffffffffc0202284:	00006617          	auipc	a2,0x6
ffffffffc0202288:	37c60613          	addi	a2,a2,892 # ffffffffc0208600 <commands+0x410>
ffffffffc020228c:	10700593          	li	a1,263
ffffffffc0202290:	00007517          	auipc	a0,0x7
ffffffffc0202294:	bf850513          	addi	a0,a0,-1032 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202298:	f71fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020229c:	00007697          	auipc	a3,0x7
ffffffffc02022a0:	e2c68693          	addi	a3,a3,-468 # ffffffffc02090c8 <commands+0xed8>
ffffffffc02022a4:	00006617          	auipc	a2,0x6
ffffffffc02022a8:	35c60613          	addi	a2,a2,860 # ffffffffc0208600 <commands+0x410>
ffffffffc02022ac:	10600593          	li	a1,262
ffffffffc02022b0:	00007517          	auipc	a0,0x7
ffffffffc02022b4:	bd850513          	addi	a0,a0,-1064 # ffffffffc0208e88 <commands+0xc98>
ffffffffc02022b8:	f51fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02022bc:	00007697          	auipc	a3,0x7
ffffffffc02022c0:	ddc68693          	addi	a3,a3,-548 # ffffffffc0209098 <commands+0xea8>
ffffffffc02022c4:	00006617          	auipc	a2,0x6
ffffffffc02022c8:	33c60613          	addi	a2,a2,828 # ffffffffc0208600 <commands+0x410>
ffffffffc02022cc:	10500593          	li	a1,261
ffffffffc02022d0:	00007517          	auipc	a0,0x7
ffffffffc02022d4:	bb850513          	addi	a0,a0,-1096 # ffffffffc0208e88 <commands+0xc98>
ffffffffc02022d8:	f31fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02022dc:	00007697          	auipc	a3,0x7
ffffffffc02022e0:	da468693          	addi	a3,a3,-604 # ffffffffc0209080 <commands+0xe90>
ffffffffc02022e4:	00006617          	auipc	a2,0x6
ffffffffc02022e8:	31c60613          	addi	a2,a2,796 # ffffffffc0208600 <commands+0x410>
ffffffffc02022ec:	10400593          	li	a1,260
ffffffffc02022f0:	00007517          	auipc	a0,0x7
ffffffffc02022f4:	b9850513          	addi	a0,a0,-1128 # ffffffffc0208e88 <commands+0xc98>
ffffffffc02022f8:	f11fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02022fc:	00007697          	auipc	a3,0x7
ffffffffc0202300:	cec68693          	addi	a3,a3,-788 # ffffffffc0208fe8 <commands+0xdf8>
ffffffffc0202304:	00006617          	auipc	a2,0x6
ffffffffc0202308:	2fc60613          	addi	a2,a2,764 # ffffffffc0208600 <commands+0x410>
ffffffffc020230c:	0fe00593          	li	a1,254
ffffffffc0202310:	00007517          	auipc	a0,0x7
ffffffffc0202314:	b7850513          	addi	a0,a0,-1160 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202318:	ef1fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020231c:	00007697          	auipc	a3,0x7
ffffffffc0202320:	d4c68693          	addi	a3,a3,-692 # ffffffffc0209068 <commands+0xe78>
ffffffffc0202324:	00006617          	auipc	a2,0x6
ffffffffc0202328:	2dc60613          	addi	a2,a2,732 # ffffffffc0208600 <commands+0x410>
ffffffffc020232c:	0f900593          	li	a1,249
ffffffffc0202330:	00007517          	auipc	a0,0x7
ffffffffc0202334:	b5850513          	addi	a0,a0,-1192 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202338:	ed1fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020233c:	00007697          	auipc	a3,0x7
ffffffffc0202340:	e4c68693          	addi	a3,a3,-436 # ffffffffc0209188 <commands+0xf98>
ffffffffc0202344:	00006617          	auipc	a2,0x6
ffffffffc0202348:	2bc60613          	addi	a2,a2,700 # ffffffffc0208600 <commands+0x410>
ffffffffc020234c:	11700593          	li	a1,279
ffffffffc0202350:	00007517          	auipc	a0,0x7
ffffffffc0202354:	b3850513          	addi	a0,a0,-1224 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202358:	eb1fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020235c:	00007697          	auipc	a3,0x7
ffffffffc0202360:	e5c68693          	addi	a3,a3,-420 # ffffffffc02091b8 <commands+0xfc8>
ffffffffc0202364:	00006617          	auipc	a2,0x6
ffffffffc0202368:	29c60613          	addi	a2,a2,668 # ffffffffc0208600 <commands+0x410>
ffffffffc020236c:	12600593          	li	a1,294
ffffffffc0202370:	00007517          	auipc	a0,0x7
ffffffffc0202374:	b1850513          	addi	a0,a0,-1256 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202378:	e91fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020237c:	00007697          	auipc	a3,0x7
ffffffffc0202380:	b2468693          	addi	a3,a3,-1244 # ffffffffc0208ea0 <commands+0xcb0>
ffffffffc0202384:	00006617          	auipc	a2,0x6
ffffffffc0202388:	27c60613          	addi	a2,a2,636 # ffffffffc0208600 <commands+0x410>
ffffffffc020238c:	0f300593          	li	a1,243
ffffffffc0202390:	00007517          	auipc	a0,0x7
ffffffffc0202394:	af850513          	addi	a0,a0,-1288 # ffffffffc0208e88 <commands+0xc98>
ffffffffc0202398:	e71fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020239c:	00007697          	auipc	a3,0x7
ffffffffc02023a0:	b4468693          	addi	a3,a3,-1212 # ffffffffc0208ee0 <commands+0xcf0>
ffffffffc02023a4:	00006617          	auipc	a2,0x6
ffffffffc02023a8:	25c60613          	addi	a2,a2,604 # ffffffffc0208600 <commands+0x410>
ffffffffc02023ac:	0ba00593          	li	a1,186
ffffffffc02023b0:	00007517          	auipc	a0,0x7
ffffffffc02023b4:	ad850513          	addi	a0,a0,-1320 # ffffffffc0208e88 <commands+0xc98>
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
ffffffffc0202402:	21a68693          	addi	a3,a3,538 # ffffffffc0219618 <free_area>
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
ffffffffc02024e2:	cf268693          	addi	a3,a3,-782 # ffffffffc02091d0 <commands+0xfe0>
ffffffffc02024e6:	00006617          	auipc	a2,0x6
ffffffffc02024ea:	11a60613          	addi	a2,a2,282 # ffffffffc0208600 <commands+0x410>
ffffffffc02024ee:	08300593          	li	a1,131
ffffffffc02024f2:	00007517          	auipc	a0,0x7
ffffffffc02024f6:	99650513          	addi	a0,a0,-1642 # ffffffffc0208e88 <commands+0xc98>
ffffffffc02024fa:	d0ffd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02024fe:	00007697          	auipc	a3,0x7
ffffffffc0202502:	cca68693          	addi	a3,a3,-822 # ffffffffc02091c8 <commands+0xfd8>
ffffffffc0202506:	00006617          	auipc	a2,0x6
ffffffffc020250a:	0fa60613          	addi	a2,a2,250 # ffffffffc0208600 <commands+0x410>
ffffffffc020250e:	08000593          	li	a1,128
ffffffffc0202512:	00007517          	auipc	a0,0x7
ffffffffc0202516:	97650513          	addi	a0,a0,-1674 # ffffffffc0208e88 <commands+0xc98>
ffffffffc020251a:	ceffd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020251e <default_alloc_pages>:
ffffffffc020251e:	c941                	beqz	a0,ffffffffc02025ae <default_alloc_pages+0x90>
ffffffffc0202520:	00017597          	auipc	a1,0x17
ffffffffc0202524:	0f858593          	addi	a1,a1,248 # ffffffffc0219618 <free_area>
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
ffffffffc02025b4:	c1868693          	addi	a3,a3,-1000 # ffffffffc02091c8 <commands+0xfd8>
ffffffffc02025b8:	00006617          	auipc	a2,0x6
ffffffffc02025bc:	04860613          	addi	a2,a2,72 # ffffffffc0208600 <commands+0x410>
ffffffffc02025c0:	06200593          	li	a1,98
ffffffffc02025c4:	00007517          	auipc	a0,0x7
ffffffffc02025c8:	8c450513          	addi	a0,a0,-1852 # ffffffffc0208e88 <commands+0xc98>
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
ffffffffc0202610:	00c68693          	addi	a3,a3,12 # ffffffffc0219618 <free_area>
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
ffffffffc0202686:	b7668693          	addi	a3,a3,-1162 # ffffffffc02091f8 <commands+0x1008>
ffffffffc020268a:	00006617          	auipc	a2,0x6
ffffffffc020268e:	f7660613          	addi	a2,a2,-138 # ffffffffc0208600 <commands+0x410>
ffffffffc0202692:	04900593          	li	a1,73
ffffffffc0202696:	00006517          	auipc	a0,0x6
ffffffffc020269a:	7f250513          	addi	a0,a0,2034 # ffffffffc0208e88 <commands+0xc98>
ffffffffc020269e:	b6bfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02026a2:	00007697          	auipc	a3,0x7
ffffffffc02026a6:	b2668693          	addi	a3,a3,-1242 # ffffffffc02091c8 <commands+0xfd8>
ffffffffc02026aa:	00006617          	auipc	a2,0x6
ffffffffc02026ae:	f5660613          	addi	a2,a2,-170 # ffffffffc0208600 <commands+0x410>
ffffffffc02026b2:	04600593          	li	a1,70
ffffffffc02026b6:	00006517          	auipc	a0,0x6
ffffffffc02026ba:	7d250513          	addi	a0,a0,2002 # ffffffffc0208e88 <commands+0xc98>
ffffffffc02026be:	b4bfd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02026c2 <pa2page.part.0>:
ffffffffc02026c2:	1141                	addi	sp,sp,-16
ffffffffc02026c4:	00006617          	auipc	a2,0x6
ffffffffc02026c8:	65c60613          	addi	a2,a2,1628 # ffffffffc0208d20 <commands+0xb30>
ffffffffc02026cc:	06200593          	li	a1,98
ffffffffc02026d0:	00006517          	auipc	a0,0x6
ffffffffc02026d4:	5e050513          	addi	a0,a0,1504 # ffffffffc0208cb0 <commands+0xac0>
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
ffffffffc02026f6:	f3e90913          	addi	s2,s2,-194 # ffffffffc0219630 <pmm_manager>
ffffffffc02026fa:	4a05                	li	s4,1
ffffffffc02026fc:	00017a97          	auipc	s5,0x17
ffffffffc0202700:	de4a8a93          	addi	s5,s5,-540 # ffffffffc02194e0 <swap_init_ok>
ffffffffc0202704:	0005099b          	sext.w	s3,a0
ffffffffc0202708:	00017b17          	auipc	s6,0x17
ffffffffc020270c:	e30b0b13          	addi	s6,s6,-464 # ffffffffc0219538 <check_mm_struct>
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
ffffffffc020277c:	eb87b783          	ld	a5,-328(a5) # ffffffffc0219630 <pmm_manager>
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
ffffffffc020279a:	e9a7b783          	ld	a5,-358(a5) # ffffffffc0219630 <pmm_manager>
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
ffffffffc02027be:	e767b783          	ld	a5,-394(a5) # ffffffffc0219630 <pmm_manager>
ffffffffc02027c2:	0287b303          	ld	t1,40(a5)
ffffffffc02027c6:	8302                	jr	t1
ffffffffc02027c8:	1141                	addi	sp,sp,-16
ffffffffc02027ca:	e406                	sd	ra,8(sp)
ffffffffc02027cc:	e022                	sd	s0,0(sp)
ffffffffc02027ce:	e6bfd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02027d2:	00017797          	auipc	a5,0x17
ffffffffc02027d6:	e5e7b783          	ld	a5,-418(a5) # ffffffffc0219630 <pmm_manager>
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
ffffffffc02027f2:	a3278793          	addi	a5,a5,-1486 # ffffffffc0209220 <default_pmm_manager>
ffffffffc02027f6:	638c                	ld	a1,0(a5)
ffffffffc02027f8:	1101                	addi	sp,sp,-32
ffffffffc02027fa:	e426                	sd	s1,8(sp)
ffffffffc02027fc:	00007517          	auipc	a0,0x7
ffffffffc0202800:	a5c50513          	addi	a0,a0,-1444 # ffffffffc0209258 <default_pmm_manager+0x38>
ffffffffc0202804:	00017497          	auipc	s1,0x17
ffffffffc0202808:	e2c48493          	addi	s1,s1,-468 # ffffffffc0219630 <pmm_manager>
ffffffffc020280c:	ec06                	sd	ra,24(sp)
ffffffffc020280e:	e822                	sd	s0,16(sp)
ffffffffc0202810:	e09c                	sd	a5,0(s1)
ffffffffc0202812:	8bbfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202816:	609c                	ld	a5,0(s1)
ffffffffc0202818:	00017417          	auipc	s0,0x17
ffffffffc020281c:	e2040413          	addi	s0,s0,-480 # ffffffffc0219638 <va_pa_offset>
ffffffffc0202820:	679c                	ld	a5,8(a5)
ffffffffc0202822:	9782                	jalr	a5
ffffffffc0202824:	57f5                	li	a5,-3
ffffffffc0202826:	07fa                	slli	a5,a5,0x1e
ffffffffc0202828:	00007517          	auipc	a0,0x7
ffffffffc020282c:	a4850513          	addi	a0,a0,-1464 # ffffffffc0209270 <default_pmm_manager+0x50>
ffffffffc0202830:	e01c                	sd	a5,0(s0)
ffffffffc0202832:	89bfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202836:	44300693          	li	a3,1091
ffffffffc020283a:	06d6                	slli	a3,a3,0x15
ffffffffc020283c:	40100613          	li	a2,1025
ffffffffc0202840:	0656                	slli	a2,a2,0x15
ffffffffc0202842:	088005b7          	lui	a1,0x8800
ffffffffc0202846:	16fd                	addi	a3,a3,-1
ffffffffc0202848:	00007517          	auipc	a0,0x7
ffffffffc020284c:	a4050513          	addi	a0,a0,-1472 # ffffffffc0209288 <default_pmm_manager+0x68>
ffffffffc0202850:	87dfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202854:	777d                	lui	a4,0xfffff
ffffffffc0202856:	00018797          	auipc	a5,0x18
ffffffffc020285a:	e8178793          	addi	a5,a5,-383 # ffffffffc021a6d7 <end+0xfff>
ffffffffc020285e:	8ff9                	and	a5,a5,a4
ffffffffc0202860:	00088737          	lui	a4,0x88
ffffffffc0202864:	60070713          	addi	a4,a4,1536 # 88600 <kern_entry-0xffffffffc0177a00>
ffffffffc0202868:	00017597          	auipc	a1,0x17
ffffffffc020286c:	c8858593          	addi	a1,a1,-888 # ffffffffc02194f0 <npage>
ffffffffc0202870:	00017617          	auipc	a2,0x17
ffffffffc0202874:	dd860613          	addi	a2,a2,-552 # ffffffffc0219648 <pages>
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
ffffffffc0202904:	d4d7b023          	sd	a3,-704(a5) # ffffffffc0219640 <boot_cr3>
ffffffffc0202908:	64a2                	ld	s1,8(sp)
ffffffffc020290a:	6105                	addi	sp,sp,32
ffffffffc020290c:	8082                	ret
ffffffffc020290e:	00006617          	auipc	a2,0x6
ffffffffc0202912:	3ea60613          	addi	a2,a2,1002 # ffffffffc0208cf8 <commands+0xb08>
ffffffffc0202916:	07f00593          	li	a1,127
ffffffffc020291a:	00007517          	auipc	a0,0x7
ffffffffc020291e:	99650513          	addi	a0,a0,-1642 # ffffffffc02092b0 <default_pmm_manager+0x90>
ffffffffc0202922:	8e7fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202926:	00006617          	auipc	a2,0x6
ffffffffc020292a:	3d260613          	addi	a2,a2,978 # ffffffffc0208cf8 <commands+0xb08>
ffffffffc020292e:	0c100593          	li	a1,193
ffffffffc0202932:	00007517          	auipc	a0,0x7
ffffffffc0202936:	97e50513          	addi	a0,a0,-1666 # ffffffffc02092b0 <default_pmm_manager+0x90>
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
ffffffffc020298a:	cc2b0b13          	addi	s6,s6,-830 # ffffffffc0219648 <pages>
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
ffffffffc02029be:	c7e7b783          	ld	a5,-898(a5) # ffffffffc0219638 <va_pa_offset>
ffffffffc02029c2:	6605                	lui	a2,0x1
ffffffffc02029c4:	4581                	li	a1,0
ffffffffc02029c6:	953e                	add	a0,a0,a5
ffffffffc02029c8:	15a050ef          	jal	ra,ffffffffc0207b22 <memset>
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
ffffffffc02029f6:	c46a8a93          	addi	s5,s5,-954 # ffffffffc0219638 <va_pa_offset>
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
ffffffffc0202a28:	c24b0b13          	addi	s6,s6,-988 # ffffffffc0219648 <pages>
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
ffffffffc0202a5a:	0c8050ef          	jal	ra,ffffffffc0207b22 <memset>
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
ffffffffc0202ab4:	1d860613          	addi	a2,a2,472 # ffffffffc0208c88 <commands+0xa98>
ffffffffc0202ab8:	0fe00593          	li	a1,254
ffffffffc0202abc:	00006517          	auipc	a0,0x6
ffffffffc0202ac0:	7f450513          	addi	a0,a0,2036 # ffffffffc02092b0 <default_pmm_manager+0x90>
ffffffffc0202ac4:	f44fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ac8:	00006617          	auipc	a2,0x6
ffffffffc0202acc:	1c060613          	addi	a2,a2,448 # ffffffffc0208c88 <commands+0xa98>
ffffffffc0202ad0:	10900593          	li	a1,265
ffffffffc0202ad4:	00006517          	auipc	a0,0x6
ffffffffc0202ad8:	7dc50513          	addi	a0,a0,2012 # ffffffffc02092b0 <default_pmm_manager+0x90>
ffffffffc0202adc:	f2cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ae0:	86aa                	mv	a3,a0
ffffffffc0202ae2:	00006617          	auipc	a2,0x6
ffffffffc0202ae6:	1a660613          	addi	a2,a2,422 # ffffffffc0208c88 <commands+0xa98>
ffffffffc0202aea:	10600593          	li	a1,262
ffffffffc0202aee:	00006517          	auipc	a0,0x6
ffffffffc0202af2:	7c250513          	addi	a0,a0,1986 # ffffffffc02092b0 <default_pmm_manager+0x90>
ffffffffc0202af6:	f12fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202afa:	86aa                	mv	a3,a0
ffffffffc0202afc:	00006617          	auipc	a2,0x6
ffffffffc0202b00:	18c60613          	addi	a2,a2,396 # ffffffffc0208c88 <commands+0xa98>
ffffffffc0202b04:	0fa00593          	li	a1,250
ffffffffc0202b08:	00006517          	auipc	a0,0x6
ffffffffc0202b0c:	7a850513          	addi	a0,a0,1960 # ffffffffc02092b0 <default_pmm_manager+0x90>
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
ffffffffc0202b5c:	af0c0c13          	addi	s8,s8,-1296 # ffffffffc0219648 <pages>
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
ffffffffc0202bea:	70a68693          	addi	a3,a3,1802 # ffffffffc02092f0 <default_pmm_manager+0xd0>
ffffffffc0202bee:	00006617          	auipc	a2,0x6
ffffffffc0202bf2:	a1260613          	addi	a2,a2,-1518 # ffffffffc0208600 <commands+0x410>
ffffffffc0202bf6:	14100593          	li	a1,321
ffffffffc0202bfa:	00006517          	auipc	a0,0x6
ffffffffc0202bfe:	6b650513          	addi	a0,a0,1718 # ffffffffc02092b0 <default_pmm_manager+0x90>
ffffffffc0202c02:	e06fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c06:	00006697          	auipc	a3,0x6
ffffffffc0202c0a:	6ba68693          	addi	a3,a3,1722 # ffffffffc02092c0 <default_pmm_manager+0xa0>
ffffffffc0202c0e:	00006617          	auipc	a2,0x6
ffffffffc0202c12:	9f260613          	addi	a2,a2,-1550 # ffffffffc0208600 <commands+0x410>
ffffffffc0202c16:	14000593          	li	a1,320
ffffffffc0202c1a:	00006517          	auipc	a0,0x6
ffffffffc0202c1e:	69650513          	addi	a0,a0,1686 # ffffffffc02092b0 <default_pmm_manager+0x90>
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
ffffffffc0202c70:	9dcb8b93          	addi	s7,s7,-1572 # ffffffffc0219648 <pages>
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
ffffffffc0202cd4:	05060613          	addi	a2,a2,80 # ffffffffc0208d20 <commands+0xb30>
ffffffffc0202cd8:	06200593          	li	a1,98
ffffffffc0202cdc:	00006517          	auipc	a0,0x6
ffffffffc0202ce0:	fd450513          	addi	a0,a0,-44 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc0202ce4:	d24fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ce8:	00006697          	auipc	a3,0x6
ffffffffc0202cec:	60868693          	addi	a3,a3,1544 # ffffffffc02092f0 <default_pmm_manager+0xd0>
ffffffffc0202cf0:	00006617          	auipc	a2,0x6
ffffffffc0202cf4:	91060613          	addi	a2,a2,-1776 # ffffffffc0208600 <commands+0x410>
ffffffffc0202cf8:	15200593          	li	a1,338
ffffffffc0202cfc:	00006517          	auipc	a0,0x6
ffffffffc0202d00:	5b450513          	addi	a0,a0,1460 # ffffffffc02092b0 <default_pmm_manager+0x90>
ffffffffc0202d04:	d04fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d08:	00006697          	auipc	a3,0x6
ffffffffc0202d0c:	5b868693          	addi	a3,a3,1464 # ffffffffc02092c0 <default_pmm_manager+0xa0>
ffffffffc0202d10:	00006617          	auipc	a2,0x6
ffffffffc0202d14:	8f060613          	addi	a2,a2,-1808 # ffffffffc0208600 <commands+0x410>
ffffffffc0202d18:	15100593          	li	a1,337
ffffffffc0202d1c:	00006517          	auipc	a0,0x6
ffffffffc0202d20:	59450513          	addi	a0,a0,1428 # ffffffffc02092b0 <default_pmm_manager+0x90>
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
ffffffffc0202d5c:	8f073703          	ld	a4,-1808(a4) # ffffffffc0219648 <pages>
ffffffffc0202d60:	8c19                	sub	s0,s0,a4
ffffffffc0202d62:	000807b7          	lui	a5,0x80
ffffffffc0202d66:	8419                	srai	s0,s0,0x6
ffffffffc0202d68:	943e                	add	s0,s0,a5
ffffffffc0202d6a:	042a                	slli	s0,s0,0xa
ffffffffc0202d6c:	8c45                	or	s0,s0,s1
ffffffffc0202d6e:	00146413          	ori	s0,s0,1
ffffffffc0202d72:	00893023          	sd	s0,0(s2) # fffffffffff80000 <end+0x3fd66928>
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
ffffffffc0202da0:	8aca0a13          	addi	s4,s4,-1876 # ffffffffc0219648 <pages>
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
ffffffffc0202e36:	816c0c13          	addi	s8,s8,-2026 # ffffffffc0219648 <pages>
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
ffffffffc0202ee4:	75870713          	addi	a4,a4,1880 # ffffffffc0219638 <va_pa_offset>
ffffffffc0202ee8:	6308                	ld	a0,0(a4)
ffffffffc0202eea:	8799                	srai	a5,a5,0x6
ffffffffc0202eec:	97de                	add	a5,a5,s7
ffffffffc0202eee:	0167f733          	and	a4,a5,s6
ffffffffc0202ef2:	00a685b3          	add	a1,a3,a0
ffffffffc0202ef6:	07b2                	slli	a5,a5,0xc
ffffffffc0202ef8:	04c77963          	bgeu	a4,a2,ffffffffc0202f4a <copy_range+0x166>
ffffffffc0202efc:	6605                	lui	a2,0x1
ffffffffc0202efe:	953e                	add	a0,a0,a5
ffffffffc0202f00:	435040ef          	jal	ra,ffffffffc0207b34 <memcpy>
ffffffffc0202f04:	86a6                	mv	a3,s1
ffffffffc0202f06:	8622                	mv	a2,s0
ffffffffc0202f08:	85ea                	mv	a1,s10
ffffffffc0202f0a:	8556                	mv	a0,s5
ffffffffc0202f0c:	e1dff0ef          	jal	ra,ffffffffc0202d28 <page_insert>
ffffffffc0202f10:	d139                	beqz	a0,ffffffffc0202e56 <copy_range+0x72>
ffffffffc0202f12:	00006697          	auipc	a3,0x6
ffffffffc0202f16:	43e68693          	addi	a3,a3,1086 # ffffffffc0209350 <default_pmm_manager+0x130>
ffffffffc0202f1a:	00005617          	auipc	a2,0x5
ffffffffc0202f1e:	6e660613          	addi	a2,a2,1766 # ffffffffc0208600 <commands+0x410>
ffffffffc0202f22:	19900593          	li	a1,409
ffffffffc0202f26:	00006517          	auipc	a0,0x6
ffffffffc0202f2a:	38a50513          	addi	a0,a0,906 # ffffffffc02092b0 <default_pmm_manager+0x90>
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
ffffffffc0202f50:	d3c60613          	addi	a2,a2,-708 # ffffffffc0208c88 <commands+0xa98>
ffffffffc0202f54:	06900593          	li	a1,105
ffffffffc0202f58:	00006517          	auipc	a0,0x6
ffffffffc0202f5c:	d5850513          	addi	a0,a0,-680 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc0202f60:	aa8fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202f64:	00006697          	auipc	a3,0x6
ffffffffc0202f68:	3cc68693          	addi	a3,a3,972 # ffffffffc0209330 <default_pmm_manager+0x110>
ffffffffc0202f6c:	00005617          	auipc	a2,0x5
ffffffffc0202f70:	69460613          	addi	a2,a2,1684 # ffffffffc0208600 <commands+0x410>
ffffffffc0202f74:	17e00593          	li	a1,382
ffffffffc0202f78:	00006517          	auipc	a0,0x6
ffffffffc0202f7c:	33850513          	addi	a0,a0,824 # ffffffffc02092b0 <default_pmm_manager+0x90>
ffffffffc0202f80:	a88fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202f84:	00006697          	auipc	a3,0x6
ffffffffc0202f88:	36c68693          	addi	a3,a3,876 # ffffffffc02092f0 <default_pmm_manager+0xd0>
ffffffffc0202f8c:	00005617          	auipc	a2,0x5
ffffffffc0202f90:	67460613          	addi	a2,a2,1652 # ffffffffc0208600 <commands+0x410>
ffffffffc0202f94:	16a00593          	li	a1,362
ffffffffc0202f98:	00006517          	auipc	a0,0x6
ffffffffc0202f9c:	31850513          	addi	a0,a0,792 # ffffffffc02092b0 <default_pmm_manager+0x90>
ffffffffc0202fa0:	a68fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202fa4:	00006697          	auipc	a3,0x6
ffffffffc0202fa8:	39c68693          	addi	a3,a3,924 # ffffffffc0209340 <default_pmm_manager+0x120>
ffffffffc0202fac:	00005617          	auipc	a2,0x5
ffffffffc0202fb0:	65460613          	addi	a2,a2,1620 # ffffffffc0208600 <commands+0x410>
ffffffffc0202fb4:	17f00593          	li	a1,383
ffffffffc0202fb8:	00006517          	auipc	a0,0x6
ffffffffc0202fbc:	2f850513          	addi	a0,a0,760 # ffffffffc02092b0 <default_pmm_manager+0x90>
ffffffffc0202fc0:	a48fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202fc4:	00006617          	auipc	a2,0x6
ffffffffc0202fc8:	d5c60613          	addi	a2,a2,-676 # ffffffffc0208d20 <commands+0xb30>
ffffffffc0202fcc:	06200593          	li	a1,98
ffffffffc0202fd0:	00006517          	auipc	a0,0x6
ffffffffc0202fd4:	ce050513          	addi	a0,a0,-800 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc0202fd8:	a30fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202fdc:	00006617          	auipc	a2,0x6
ffffffffc0202fe0:	32c60613          	addi	a2,a2,812 # ffffffffc0209308 <default_pmm_manager+0xe8>
ffffffffc0202fe4:	07400593          	li	a1,116
ffffffffc0202fe8:	00006517          	auipc	a0,0x6
ffffffffc0202fec:	cc850513          	addi	a0,a0,-824 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc0202ff0:	a18fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ff4:	00006697          	auipc	a3,0x6
ffffffffc0202ff8:	2cc68693          	addi	a3,a3,716 # ffffffffc02092c0 <default_pmm_manager+0xa0>
ffffffffc0202ffc:	00005617          	auipc	a2,0x5
ffffffffc0203000:	60460613          	addi	a2,a2,1540 # ffffffffc0208600 <commands+0x410>
ffffffffc0203004:	16900593          	li	a1,361
ffffffffc0203008:	00006517          	auipc	a0,0x6
ffffffffc020300c:	2a850513          	addi	a0,a0,680 # ffffffffc02092b0 <default_pmm_manager+0x90>
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
ffffffffc0203052:	4ea53503          	ld	a0,1258(a0) # ffffffffc0219538 <check_mm_struct>
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
ffffffffc020308c:	2d868693          	addi	a3,a3,728 # ffffffffc0209360 <default_pmm_manager+0x140>
ffffffffc0203090:	00005617          	auipc	a2,0x5
ffffffffc0203094:	57060613          	addi	a2,a2,1392 # ffffffffc0208600 <commands+0x410>
ffffffffc0203098:	1d800593          	li	a1,472
ffffffffc020309c:	00006517          	auipc	a0,0x6
ffffffffc02030a0:	21450513          	addi	a0,a0,532 # ffffffffc02092b0 <default_pmm_manager+0x90>
ffffffffc02030a4:	964fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02030a8 <wait_queue_del.part.0>:
ffffffffc02030a8:	1141                	addi	sp,sp,-16
ffffffffc02030aa:	00006697          	auipc	a3,0x6
ffffffffc02030ae:	2ce68693          	addi	a3,a3,718 # ffffffffc0209378 <default_pmm_manager+0x158>
ffffffffc02030b2:	00005617          	auipc	a2,0x5
ffffffffc02030b6:	54e60613          	addi	a2,a2,1358 # ffffffffc0208600 <commands+0x410>
ffffffffc02030ba:	45f1                	li	a1,28
ffffffffc02030bc:	00006517          	auipc	a0,0x6
ffffffffc02030c0:	2fc50513          	addi	a0,a0,764 # ffffffffc02093b8 <default_pmm_manager+0x198>
ffffffffc02030c4:	e406                	sd	ra,8(sp)
ffffffffc02030c6:	942fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02030ca <wait_queue_init>:
ffffffffc02030ca:	e508                	sd	a0,8(a0)
ffffffffc02030cc:	e108                	sd	a0,0(a0)
ffffffffc02030ce:	8082                	ret

ffffffffc02030d0 <wait_queue_del>:
ffffffffc02030d0:	7198                	ld	a4,32(a1)
ffffffffc02030d2:	01858793          	addi	a5,a1,24
ffffffffc02030d6:	00e78b63          	beq	a5,a4,ffffffffc02030ec <wait_queue_del+0x1c>
ffffffffc02030da:	6994                	ld	a3,16(a1)
ffffffffc02030dc:	00a69863          	bne	a3,a0,ffffffffc02030ec <wait_queue_del+0x1c>
ffffffffc02030e0:	6d94                	ld	a3,24(a1)
ffffffffc02030e2:	e698                	sd	a4,8(a3)
ffffffffc02030e4:	e314                	sd	a3,0(a4)
ffffffffc02030e6:	f19c                	sd	a5,32(a1)
ffffffffc02030e8:	ed9c                	sd	a5,24(a1)
ffffffffc02030ea:	8082                	ret
ffffffffc02030ec:	1141                	addi	sp,sp,-16
ffffffffc02030ee:	e406                	sd	ra,8(sp)
ffffffffc02030f0:	fb9ff0ef          	jal	ra,ffffffffc02030a8 <wait_queue_del.part.0>

ffffffffc02030f4 <wait_queue_first>:
ffffffffc02030f4:	651c                	ld	a5,8(a0)
ffffffffc02030f6:	00f50563          	beq	a0,a5,ffffffffc0203100 <wait_queue_first+0xc>
ffffffffc02030fa:	fe878513          	addi	a0,a5,-24
ffffffffc02030fe:	8082                	ret
ffffffffc0203100:	4501                	li	a0,0
ffffffffc0203102:	8082                	ret

ffffffffc0203104 <wait_in_queue>:
ffffffffc0203104:	711c                	ld	a5,32(a0)
ffffffffc0203106:	0561                	addi	a0,a0,24
ffffffffc0203108:	40a78533          	sub	a0,a5,a0
ffffffffc020310c:	00a03533          	snez	a0,a0
ffffffffc0203110:	8082                	ret

ffffffffc0203112 <wakeup_wait>:
ffffffffc0203112:	ce91                	beqz	a3,ffffffffc020312e <wakeup_wait+0x1c>
ffffffffc0203114:	7198                	ld	a4,32(a1)
ffffffffc0203116:	01858793          	addi	a5,a1,24
ffffffffc020311a:	00e78e63          	beq	a5,a4,ffffffffc0203136 <wakeup_wait+0x24>
ffffffffc020311e:	6994                	ld	a3,16(a1)
ffffffffc0203120:	00d51b63          	bne	a0,a3,ffffffffc0203136 <wakeup_wait+0x24>
ffffffffc0203124:	6d94                	ld	a3,24(a1)
ffffffffc0203126:	e698                	sd	a4,8(a3)
ffffffffc0203128:	e314                	sd	a3,0(a4)
ffffffffc020312a:	f19c                	sd	a5,32(a1)
ffffffffc020312c:	ed9c                	sd	a5,24(a1)
ffffffffc020312e:	6188                	ld	a0,0(a1)
ffffffffc0203130:	c590                	sw	a2,8(a1)
ffffffffc0203132:	0b90106f          	j	ffffffffc02049ea <wakeup_proc>
ffffffffc0203136:	1141                	addi	sp,sp,-16
ffffffffc0203138:	e406                	sd	ra,8(sp)
ffffffffc020313a:	f6fff0ef          	jal	ra,ffffffffc02030a8 <wait_queue_del.part.0>

ffffffffc020313e <wait_current_set>:
ffffffffc020313e:	00016797          	auipc	a5,0x16
ffffffffc0203142:	3c27b783          	ld	a5,962(a5) # ffffffffc0219500 <current>
ffffffffc0203146:	c39d                	beqz	a5,ffffffffc020316c <wait_current_set+0x2e>
ffffffffc0203148:	01858713          	addi	a4,a1,24
ffffffffc020314c:	800006b7          	lui	a3,0x80000
ffffffffc0203150:	ed98                	sd	a4,24(a1)
ffffffffc0203152:	e19c                	sd	a5,0(a1)
ffffffffc0203154:	c594                	sw	a3,8(a1)
ffffffffc0203156:	4685                	li	a3,1
ffffffffc0203158:	c394                	sw	a3,0(a5)
ffffffffc020315a:	0ec7a623          	sw	a2,236(a5)
ffffffffc020315e:	611c                	ld	a5,0(a0)
ffffffffc0203160:	e988                	sd	a0,16(a1)
ffffffffc0203162:	e118                	sd	a4,0(a0)
ffffffffc0203164:	e798                	sd	a4,8(a5)
ffffffffc0203166:	f188                	sd	a0,32(a1)
ffffffffc0203168:	ed9c                	sd	a5,24(a1)
ffffffffc020316a:	8082                	ret
ffffffffc020316c:	1141                	addi	sp,sp,-16
ffffffffc020316e:	00006697          	auipc	a3,0x6
ffffffffc0203172:	26268693          	addi	a3,a3,610 # ffffffffc02093d0 <default_pmm_manager+0x1b0>
ffffffffc0203176:	00005617          	auipc	a2,0x5
ffffffffc020317a:	48a60613          	addi	a2,a2,1162 # ffffffffc0208600 <commands+0x410>
ffffffffc020317e:	07400593          	li	a1,116
ffffffffc0203182:	00006517          	auipc	a0,0x6
ffffffffc0203186:	23650513          	addi	a0,a0,566 # ffffffffc02093b8 <default_pmm_manager+0x198>
ffffffffc020318a:	e406                	sd	ra,8(sp)
ffffffffc020318c:	87cfd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203190 <__down.constprop.0>:
ffffffffc0203190:	715d                	addi	sp,sp,-80
ffffffffc0203192:	e0a2                	sd	s0,64(sp)
ffffffffc0203194:	e486                	sd	ra,72(sp)
ffffffffc0203196:	fc26                	sd	s1,56(sp)
ffffffffc0203198:	842a                	mv	s0,a0
ffffffffc020319a:	100027f3          	csrr	a5,sstatus
ffffffffc020319e:	8b89                	andi	a5,a5,2
ffffffffc02031a0:	ebb1                	bnez	a5,ffffffffc02031f4 <__down.constprop.0+0x64>
ffffffffc02031a2:	411c                	lw	a5,0(a0)
ffffffffc02031a4:	00f05a63          	blez	a5,ffffffffc02031b8 <__down.constprop.0+0x28>
ffffffffc02031a8:	37fd                	addiw	a5,a5,-1
ffffffffc02031aa:	c11c                	sw	a5,0(a0)
ffffffffc02031ac:	4501                	li	a0,0
ffffffffc02031ae:	60a6                	ld	ra,72(sp)
ffffffffc02031b0:	6406                	ld	s0,64(sp)
ffffffffc02031b2:	74e2                	ld	s1,56(sp)
ffffffffc02031b4:	6161                	addi	sp,sp,80
ffffffffc02031b6:	8082                	ret
ffffffffc02031b8:	00850413          	addi	s0,a0,8
ffffffffc02031bc:	0024                	addi	s1,sp,8
ffffffffc02031be:	10000613          	li	a2,256
ffffffffc02031c2:	85a6                	mv	a1,s1
ffffffffc02031c4:	8522                	mv	a0,s0
ffffffffc02031c6:	f79ff0ef          	jal	ra,ffffffffc020313e <wait_current_set>
ffffffffc02031ca:	0d3010ef          	jal	ra,ffffffffc0204a9c <schedule>
ffffffffc02031ce:	100027f3          	csrr	a5,sstatus
ffffffffc02031d2:	8b89                	andi	a5,a5,2
ffffffffc02031d4:	efb9                	bnez	a5,ffffffffc0203232 <__down.constprop.0+0xa2>
ffffffffc02031d6:	8526                	mv	a0,s1
ffffffffc02031d8:	f2dff0ef          	jal	ra,ffffffffc0203104 <wait_in_queue>
ffffffffc02031dc:	e531                	bnez	a0,ffffffffc0203228 <__down.constprop.0+0x98>
ffffffffc02031de:	4542                	lw	a0,16(sp)
ffffffffc02031e0:	10000793          	li	a5,256
ffffffffc02031e4:	fcf515e3          	bne	a0,a5,ffffffffc02031ae <__down.constprop.0+0x1e>
ffffffffc02031e8:	60a6                	ld	ra,72(sp)
ffffffffc02031ea:	6406                	ld	s0,64(sp)
ffffffffc02031ec:	74e2                	ld	s1,56(sp)
ffffffffc02031ee:	4501                	li	a0,0
ffffffffc02031f0:	6161                	addi	sp,sp,80
ffffffffc02031f2:	8082                	ret
ffffffffc02031f4:	c44fd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02031f8:	401c                	lw	a5,0(s0)
ffffffffc02031fa:	00f05c63          	blez	a5,ffffffffc0203212 <__down.constprop.0+0x82>
ffffffffc02031fe:	37fd                	addiw	a5,a5,-1
ffffffffc0203200:	c01c                	sw	a5,0(s0)
ffffffffc0203202:	c30fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203206:	60a6                	ld	ra,72(sp)
ffffffffc0203208:	6406                	ld	s0,64(sp)
ffffffffc020320a:	74e2                	ld	s1,56(sp)
ffffffffc020320c:	4501                	li	a0,0
ffffffffc020320e:	6161                	addi	sp,sp,80
ffffffffc0203210:	8082                	ret
ffffffffc0203212:	0421                	addi	s0,s0,8
ffffffffc0203214:	0024                	addi	s1,sp,8
ffffffffc0203216:	10000613          	li	a2,256
ffffffffc020321a:	85a6                	mv	a1,s1
ffffffffc020321c:	8522                	mv	a0,s0
ffffffffc020321e:	f21ff0ef          	jal	ra,ffffffffc020313e <wait_current_set>
ffffffffc0203222:	c10fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203226:	b755                	j	ffffffffc02031ca <__down.constprop.0+0x3a>
ffffffffc0203228:	85a6                	mv	a1,s1
ffffffffc020322a:	8522                	mv	a0,s0
ffffffffc020322c:	ea5ff0ef          	jal	ra,ffffffffc02030d0 <wait_queue_del>
ffffffffc0203230:	b77d                	j	ffffffffc02031de <__down.constprop.0+0x4e>
ffffffffc0203232:	c06fd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203236:	8526                	mv	a0,s1
ffffffffc0203238:	ecdff0ef          	jal	ra,ffffffffc0203104 <wait_in_queue>
ffffffffc020323c:	e501                	bnez	a0,ffffffffc0203244 <__down.constprop.0+0xb4>
ffffffffc020323e:	bf4fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203242:	bf71                	j	ffffffffc02031de <__down.constprop.0+0x4e>
ffffffffc0203244:	85a6                	mv	a1,s1
ffffffffc0203246:	8522                	mv	a0,s0
ffffffffc0203248:	e89ff0ef          	jal	ra,ffffffffc02030d0 <wait_queue_del>
ffffffffc020324c:	bfcd                	j	ffffffffc020323e <__down.constprop.0+0xae>

ffffffffc020324e <__up.constprop.0>:
ffffffffc020324e:	1101                	addi	sp,sp,-32
ffffffffc0203250:	e822                	sd	s0,16(sp)
ffffffffc0203252:	ec06                	sd	ra,24(sp)
ffffffffc0203254:	e426                	sd	s1,8(sp)
ffffffffc0203256:	e04a                	sd	s2,0(sp)
ffffffffc0203258:	842a                	mv	s0,a0
ffffffffc020325a:	100027f3          	csrr	a5,sstatus
ffffffffc020325e:	8b89                	andi	a5,a5,2
ffffffffc0203260:	4901                	li	s2,0
ffffffffc0203262:	eba1                	bnez	a5,ffffffffc02032b2 <__up.constprop.0+0x64>
ffffffffc0203264:	00840493          	addi	s1,s0,8
ffffffffc0203268:	8526                	mv	a0,s1
ffffffffc020326a:	e8bff0ef          	jal	ra,ffffffffc02030f4 <wait_queue_first>
ffffffffc020326e:	85aa                	mv	a1,a0
ffffffffc0203270:	cd0d                	beqz	a0,ffffffffc02032aa <__up.constprop.0+0x5c>
ffffffffc0203272:	6118                	ld	a4,0(a0)
ffffffffc0203274:	10000793          	li	a5,256
ffffffffc0203278:	0ec72703          	lw	a4,236(a4)
ffffffffc020327c:	02f71f63          	bne	a4,a5,ffffffffc02032ba <__up.constprop.0+0x6c>
ffffffffc0203280:	4685                	li	a3,1
ffffffffc0203282:	10000613          	li	a2,256
ffffffffc0203286:	8526                	mv	a0,s1
ffffffffc0203288:	e8bff0ef          	jal	ra,ffffffffc0203112 <wakeup_wait>
ffffffffc020328c:	00091863          	bnez	s2,ffffffffc020329c <__up.constprop.0+0x4e>
ffffffffc0203290:	60e2                	ld	ra,24(sp)
ffffffffc0203292:	6442                	ld	s0,16(sp)
ffffffffc0203294:	64a2                	ld	s1,8(sp)
ffffffffc0203296:	6902                	ld	s2,0(sp)
ffffffffc0203298:	6105                	addi	sp,sp,32
ffffffffc020329a:	8082                	ret
ffffffffc020329c:	6442                	ld	s0,16(sp)
ffffffffc020329e:	60e2                	ld	ra,24(sp)
ffffffffc02032a0:	64a2                	ld	s1,8(sp)
ffffffffc02032a2:	6902                	ld	s2,0(sp)
ffffffffc02032a4:	6105                	addi	sp,sp,32
ffffffffc02032a6:	b8cfd06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc02032aa:	401c                	lw	a5,0(s0)
ffffffffc02032ac:	2785                	addiw	a5,a5,1
ffffffffc02032ae:	c01c                	sw	a5,0(s0)
ffffffffc02032b0:	bff1                	j	ffffffffc020328c <__up.constprop.0+0x3e>
ffffffffc02032b2:	b86fd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02032b6:	4905                	li	s2,1
ffffffffc02032b8:	b775                	j	ffffffffc0203264 <__up.constprop.0+0x16>
ffffffffc02032ba:	00006697          	auipc	a3,0x6
ffffffffc02032be:	12668693          	addi	a3,a3,294 # ffffffffc02093e0 <default_pmm_manager+0x1c0>
ffffffffc02032c2:	00005617          	auipc	a2,0x5
ffffffffc02032c6:	33e60613          	addi	a2,a2,830 # ffffffffc0208600 <commands+0x410>
ffffffffc02032ca:	45e5                	li	a1,25
ffffffffc02032cc:	00006517          	auipc	a0,0x6
ffffffffc02032d0:	13c50513          	addi	a0,a0,316 # ffffffffc0209408 <default_pmm_manager+0x1e8>
ffffffffc02032d4:	f35fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02032d8 <sem_init>:
ffffffffc02032d8:	c10c                	sw	a1,0(a0)
ffffffffc02032da:	0521                	addi	a0,a0,8
ffffffffc02032dc:	defff06f          	j	ffffffffc02030ca <wait_queue_init>

ffffffffc02032e0 <up>:
ffffffffc02032e0:	b7bd                	j	ffffffffc020324e <__up.constprop.0>

ffffffffc02032e2 <down>:
ffffffffc02032e2:	1141                	addi	sp,sp,-16
ffffffffc02032e4:	e406                	sd	ra,8(sp)
ffffffffc02032e6:	eabff0ef          	jal	ra,ffffffffc0203190 <__down.constprop.0>
ffffffffc02032ea:	2501                	sext.w	a0,a0
ffffffffc02032ec:	e501                	bnez	a0,ffffffffc02032f4 <down+0x12>
ffffffffc02032ee:	60a2                	ld	ra,8(sp)
ffffffffc02032f0:	0141                	addi	sp,sp,16
ffffffffc02032f2:	8082                	ret
ffffffffc02032f4:	00006697          	auipc	a3,0x6
ffffffffc02032f8:	12468693          	addi	a3,a3,292 # ffffffffc0209418 <default_pmm_manager+0x1f8>
ffffffffc02032fc:	00005617          	auipc	a2,0x5
ffffffffc0203300:	30460613          	addi	a2,a2,772 # ffffffffc0208600 <commands+0x410>
ffffffffc0203304:	04000593          	li	a1,64
ffffffffc0203308:	00006517          	auipc	a0,0x6
ffffffffc020330c:	10050513          	addi	a0,a0,256 # ffffffffc0209408 <default_pmm_manager+0x1e8>
ffffffffc0203310:	ef9fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203314 <worker1>:
ffffffffc0203314:	7139                	addi	sp,sp,-64
ffffffffc0203316:	f426                	sd	s1,40(sp)
ffffffffc0203318:	00016497          	auipc	s1,0x16
ffffffffc020331c:	34048493          	addi	s1,s1,832 # ffffffffc0219658 <ws>
ffffffffc0203320:	f822                	sd	s0,48(sp)
ffffffffc0203322:	f04a                	sd	s2,32(sp)
ffffffffc0203324:	ec4e                	sd	s3,24(sp)
ffffffffc0203326:	e852                	sd	s4,16(sp)
ffffffffc0203328:	e456                	sd	s5,8(sp)
ffffffffc020332a:	fc06                	sd	ra,56(sp)
ffffffffc020332c:	00016417          	auipc	s0,0x16
ffffffffc0203330:	1cc40413          	addi	s0,s0,460 # ffffffffc02194f8 <index>
ffffffffc0203334:	00016a97          	auipc	s5,0x16
ffffffffc0203338:	37ca8a93          	addi	s5,s5,892 # ffffffffc02196b0 <overallMutex>
ffffffffc020333c:	8a26                	mv	s4,s1
ffffffffc020333e:	00006997          	auipc	s3,0x6
ffffffffc0203342:	0ea98993          	addi	s3,s3,234 # ffffffffc0209428 <default_pmm_manager+0x208>
ffffffffc0203346:	490d                	li	s2,3
ffffffffc0203348:	85d6                	mv	a1,s5
ffffffffc020334a:	8552                	mv	a0,s4
ffffffffc020334c:	1d8000ef          	jal	ra,ffffffffc0203524 <cond_wait>
ffffffffc0203350:	854e                	mv	a0,s3
ffffffffc0203352:	d7bfc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203356:	401c                	lw	a5,0(s0)
ffffffffc0203358:	2785                	addiw	a5,a5,1
ffffffffc020335a:	0327e73b          	remw	a4,a5,s2
ffffffffc020335e:	00171513          	slli	a0,a4,0x1
ffffffffc0203362:	953a                	add	a0,a0,a4
ffffffffc0203364:	050e                	slli	a0,a0,0x3
ffffffffc0203366:	9526                	add	a0,a0,s1
ffffffffc0203368:	c018                	sw	a4,0(s0)
ffffffffc020336a:	1b6000ef          	jal	ra,ffffffffc0203520 <cond_signal>
ffffffffc020336e:	bfe9                	j	ffffffffc0203348 <worker1+0x34>

ffffffffc0203370 <worker2>:
ffffffffc0203370:	7139                	addi	sp,sp,-64
ffffffffc0203372:	f822                	sd	s0,48(sp)
ffffffffc0203374:	f426                	sd	s1,40(sp)
ffffffffc0203376:	f04a                	sd	s2,32(sp)
ffffffffc0203378:	ec4e                	sd	s3,24(sp)
ffffffffc020337a:	e852                	sd	s4,16(sp)
ffffffffc020337c:	e456                	sd	s5,8(sp)
ffffffffc020337e:	fc06                	sd	ra,56(sp)
ffffffffc0203380:	00016417          	auipc	s0,0x16
ffffffffc0203384:	17840413          	addi	s0,s0,376 # ffffffffc02194f8 <index>
ffffffffc0203388:	00016a17          	auipc	s4,0x16
ffffffffc020338c:	2d0a0a13          	addi	s4,s4,720 # ffffffffc0219658 <ws>
ffffffffc0203390:	00016a97          	auipc	s5,0x16
ffffffffc0203394:	320a8a93          	addi	s5,s5,800 # ffffffffc02196b0 <overallMutex>
ffffffffc0203398:	00016997          	auipc	s3,0x16
ffffffffc020339c:	2d898993          	addi	s3,s3,728 # ffffffffc0219670 <ws+0x18>
ffffffffc02033a0:	00006917          	auipc	s2,0x6
ffffffffc02033a4:	0a090913          	addi	s2,s2,160 # ffffffffc0209440 <default_pmm_manager+0x220>
ffffffffc02033a8:	448d                	li	s1,3
ffffffffc02033aa:	85d6                	mv	a1,s5
ffffffffc02033ac:	854e                	mv	a0,s3
ffffffffc02033ae:	176000ef          	jal	ra,ffffffffc0203524 <cond_wait>
ffffffffc02033b2:	854a                	mv	a0,s2
ffffffffc02033b4:	d19fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02033b8:	401c                	lw	a5,0(s0)
ffffffffc02033ba:	2785                	addiw	a5,a5,1
ffffffffc02033bc:	0297e73b          	remw	a4,a5,s1
ffffffffc02033c0:	00171513          	slli	a0,a4,0x1
ffffffffc02033c4:	953a                	add	a0,a0,a4
ffffffffc02033c6:	050e                	slli	a0,a0,0x3
ffffffffc02033c8:	9552                	add	a0,a0,s4
ffffffffc02033ca:	c018                	sw	a4,0(s0)
ffffffffc02033cc:	154000ef          	jal	ra,ffffffffc0203520 <cond_signal>
ffffffffc02033d0:	bfe9                	j	ffffffffc02033aa <worker2+0x3a>

ffffffffc02033d2 <worker3>:
ffffffffc02033d2:	7139                	addi	sp,sp,-64
ffffffffc02033d4:	f822                	sd	s0,48(sp)
ffffffffc02033d6:	f426                	sd	s1,40(sp)
ffffffffc02033d8:	f04a                	sd	s2,32(sp)
ffffffffc02033da:	ec4e                	sd	s3,24(sp)
ffffffffc02033dc:	e852                	sd	s4,16(sp)
ffffffffc02033de:	e456                	sd	s5,8(sp)
ffffffffc02033e0:	fc06                	sd	ra,56(sp)
ffffffffc02033e2:	00016417          	auipc	s0,0x16
ffffffffc02033e6:	11640413          	addi	s0,s0,278 # ffffffffc02194f8 <index>
ffffffffc02033ea:	00016a17          	auipc	s4,0x16
ffffffffc02033ee:	26ea0a13          	addi	s4,s4,622 # ffffffffc0219658 <ws>
ffffffffc02033f2:	00016a97          	auipc	s5,0x16
ffffffffc02033f6:	2bea8a93          	addi	s5,s5,702 # ffffffffc02196b0 <overallMutex>
ffffffffc02033fa:	00016997          	auipc	s3,0x16
ffffffffc02033fe:	28e98993          	addi	s3,s3,654 # ffffffffc0219688 <ws+0x30>
ffffffffc0203402:	00006917          	auipc	s2,0x6
ffffffffc0203406:	05690913          	addi	s2,s2,86 # ffffffffc0209458 <default_pmm_manager+0x238>
ffffffffc020340a:	448d                	li	s1,3
ffffffffc020340c:	85d6                	mv	a1,s5
ffffffffc020340e:	854e                	mv	a0,s3
ffffffffc0203410:	114000ef          	jal	ra,ffffffffc0203524 <cond_wait>
ffffffffc0203414:	854a                	mv	a0,s2
ffffffffc0203416:	cb7fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020341a:	401c                	lw	a5,0(s0)
ffffffffc020341c:	2785                	addiw	a5,a5,1
ffffffffc020341e:	0297e73b          	remw	a4,a5,s1
ffffffffc0203422:	00171513          	slli	a0,a4,0x1
ffffffffc0203426:	953a                	add	a0,a0,a4
ffffffffc0203428:	050e                	slli	a0,a0,0x3
ffffffffc020342a:	9552                	add	a0,a0,s4
ffffffffc020342c:	c018                	sw	a4,0(s0)
ffffffffc020342e:	0f2000ef          	jal	ra,ffffffffc0203520 <cond_signal>
ffffffffc0203432:	bfe9                	j	ffffffffc020340c <worker3+0x3a>

ffffffffc0203434 <check_exercise>:
ffffffffc0203434:	1101                	addi	sp,sp,-32
ffffffffc0203436:	4581                	li	a1,0
ffffffffc0203438:	00016517          	auipc	a0,0x16
ffffffffc020343c:	27850513          	addi	a0,a0,632 # ffffffffc02196b0 <overallMutex>
ffffffffc0203440:	ec06                	sd	ra,24(sp)
ffffffffc0203442:	e822                	sd	s0,16(sp)
ffffffffc0203444:	e426                	sd	s1,8(sp)
ffffffffc0203446:	e04a                	sd	s2,0(sp)
ffffffffc0203448:	e91ff0ef          	jal	ra,ffffffffc02032d8 <sem_init>
ffffffffc020344c:	00016517          	auipc	a0,0x16
ffffffffc0203450:	20c50513          	addi	a0,a0,524 # ffffffffc0219658 <ws>
ffffffffc0203454:	0c6000ef          	jal	ra,ffffffffc020351a <cond_init>
ffffffffc0203458:	00016517          	auipc	a0,0x16
ffffffffc020345c:	21850513          	addi	a0,a0,536 # ffffffffc0219670 <ws+0x18>
ffffffffc0203460:	0ba000ef          	jal	ra,ffffffffc020351a <cond_init>
ffffffffc0203464:	00016517          	auipc	a0,0x16
ffffffffc0203468:	22450513          	addi	a0,a0,548 # ffffffffc0219688 <ws+0x30>
ffffffffc020346c:	0ae000ef          	jal	ra,ffffffffc020351a <cond_init>
ffffffffc0203470:	00016517          	auipc	a0,0x16
ffffffffc0203474:	08852503          	lw	a0,136(a0) # ffffffffc02194f8 <index>
ffffffffc0203478:	00151793          	slli	a5,a0,0x1
ffffffffc020347c:	97aa                	add	a5,a5,a0
ffffffffc020347e:	078e                	slli	a5,a5,0x3
ffffffffc0203480:	00016517          	auipc	a0,0x16
ffffffffc0203484:	1d850513          	addi	a0,a0,472 # ffffffffc0219658 <ws>
ffffffffc0203488:	953e                	add	a0,a0,a5
ffffffffc020348a:	096000ef          	jal	ra,ffffffffc0203520 <cond_signal>
ffffffffc020348e:	4601                	li	a2,0
ffffffffc0203490:	4581                	li	a1,0
ffffffffc0203492:	00000517          	auipc	a0,0x0
ffffffffc0203496:	e8250513          	addi	a0,a0,-382 # ffffffffc0203314 <worker1>
ffffffffc020349a:	039000ef          	jal	ra,ffffffffc0203cd2 <kernel_thread>
ffffffffc020349e:	892a                	mv	s2,a0
ffffffffc02034a0:	4601                	li	a2,0
ffffffffc02034a2:	4581                	li	a1,0
ffffffffc02034a4:	00000517          	auipc	a0,0x0
ffffffffc02034a8:	ecc50513          	addi	a0,a0,-308 # ffffffffc0203370 <worker2>
ffffffffc02034ac:	027000ef          	jal	ra,ffffffffc0203cd2 <kernel_thread>
ffffffffc02034b0:	4601                	li	a2,0
ffffffffc02034b2:	84aa                	mv	s1,a0
ffffffffc02034b4:	4581                	li	a1,0
ffffffffc02034b6:	00000517          	auipc	a0,0x0
ffffffffc02034ba:	f1c50513          	addi	a0,a0,-228 # ffffffffc02033d2 <worker3>
ffffffffc02034be:	015000ef          	jal	ra,ffffffffc0203cd2 <kernel_thread>
ffffffffc02034c2:	842a                	mv	s0,a0
ffffffffc02034c4:	854a                	mv	a0,s2
ffffffffc02034c6:	3e2000ef          	jal	ra,ffffffffc02038a8 <find_proc>
ffffffffc02034ca:	00006597          	auipc	a1,0x6
ffffffffc02034ce:	fa658593          	addi	a1,a1,-90 # ffffffffc0209470 <default_pmm_manager+0x250>
ffffffffc02034d2:	00016797          	auipc	a5,0x16
ffffffffc02034d6:	16a7bf23          	sd	a0,382(a5) # ffffffffc0219650 <pworker1>
ffffffffc02034da:	338000ef          	jal	ra,ffffffffc0203812 <set_proc_name>
ffffffffc02034de:	8526                	mv	a0,s1
ffffffffc02034e0:	3c8000ef          	jal	ra,ffffffffc02038a8 <find_proc>
ffffffffc02034e4:	00006597          	auipc	a1,0x6
ffffffffc02034e8:	f9458593          	addi	a1,a1,-108 # ffffffffc0209478 <default_pmm_manager+0x258>
ffffffffc02034ec:	00016797          	auipc	a5,0x16
ffffffffc02034f0:	1aa7ba23          	sd	a0,436(a5) # ffffffffc02196a0 <pworker2>
ffffffffc02034f4:	31e000ef          	jal	ra,ffffffffc0203812 <set_proc_name>
ffffffffc02034f8:	8522                	mv	a0,s0
ffffffffc02034fa:	3ae000ef          	jal	ra,ffffffffc02038a8 <find_proc>
ffffffffc02034fe:	6442                	ld	s0,16(sp)
ffffffffc0203500:	60e2                	ld	ra,24(sp)
ffffffffc0203502:	64a2                	ld	s1,8(sp)
ffffffffc0203504:	6902                	ld	s2,0(sp)
ffffffffc0203506:	00016797          	auipc	a5,0x16
ffffffffc020350a:	1aa7b123          	sd	a0,418(a5) # ffffffffc02196a8 <pworker3>
ffffffffc020350e:	00006597          	auipc	a1,0x6
ffffffffc0203512:	f7258593          	addi	a1,a1,-142 # ffffffffc0209480 <default_pmm_manager+0x260>
ffffffffc0203516:	6105                	addi	sp,sp,32
ffffffffc0203518:	aced                	j	ffffffffc0203812 <set_proc_name>

ffffffffc020351a <cond_init>:
ffffffffc020351a:	4581                	li	a1,0
ffffffffc020351c:	dbdff06f          	j	ffffffffc02032d8 <sem_init>

ffffffffc0203520 <cond_signal>:
ffffffffc0203520:	dc1ff06f          	j	ffffffffc02032e0 <up>

ffffffffc0203524 <cond_wait>:
ffffffffc0203524:	1101                	addi	sp,sp,-32
ffffffffc0203526:	e426                	sd	s1,8(sp)
ffffffffc0203528:	84aa                	mv	s1,a0
ffffffffc020352a:	852e                	mv	a0,a1
ffffffffc020352c:	ec06                	sd	ra,24(sp)
ffffffffc020352e:	e822                	sd	s0,16(sp)
ffffffffc0203530:	842e                	mv	s0,a1
ffffffffc0203532:	dafff0ef          	jal	ra,ffffffffc02032e0 <up>
ffffffffc0203536:	8526                	mv	a0,s1
ffffffffc0203538:	dabff0ef          	jal	ra,ffffffffc02032e2 <down>
ffffffffc020353c:	8522                	mv	a0,s0
ffffffffc020353e:	6442                	ld	s0,16(sp)
ffffffffc0203540:	60e2                	ld	ra,24(sp)
ffffffffc0203542:	64a2                	ld	s1,8(sp)
ffffffffc0203544:	6105                	addi	sp,sp,32
ffffffffc0203546:	d9dff06f          	j	ffffffffc02032e2 <down>

ffffffffc020354a <swapfs_init>:
ffffffffc020354a:	1141                	addi	sp,sp,-16
ffffffffc020354c:	4505                	li	a0,1
ffffffffc020354e:	e406                	sd	ra,8(sp)
ffffffffc0203550:	fd3fc0ef          	jal	ra,ffffffffc0200522 <ide_device_valid>
ffffffffc0203554:	cd01                	beqz	a0,ffffffffc020356c <swapfs_init+0x22>
ffffffffc0203556:	4505                	li	a0,1
ffffffffc0203558:	fd1fc0ef          	jal	ra,ffffffffc0200528 <ide_device_size>
ffffffffc020355c:	60a2                	ld	ra,8(sp)
ffffffffc020355e:	810d                	srli	a0,a0,0x3
ffffffffc0203560:	00016797          	auipc	a5,0x16
ffffffffc0203564:	06a7bc23          	sd	a0,120(a5) # ffffffffc02195d8 <max_swap_offset>
ffffffffc0203568:	0141                	addi	sp,sp,16
ffffffffc020356a:	8082                	ret
ffffffffc020356c:	00006617          	auipc	a2,0x6
ffffffffc0203570:	f1c60613          	addi	a2,a2,-228 # ffffffffc0209488 <default_pmm_manager+0x268>
ffffffffc0203574:	45b5                	li	a1,13
ffffffffc0203576:	00006517          	auipc	a0,0x6
ffffffffc020357a:	f3250513          	addi	a0,a0,-206 # ffffffffc02094a8 <default_pmm_manager+0x288>
ffffffffc020357e:	c8bfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203582 <swapfs_read>:
ffffffffc0203582:	1141                	addi	sp,sp,-16
ffffffffc0203584:	e406                	sd	ra,8(sp)
ffffffffc0203586:	00855793          	srli	a5,a0,0x8
ffffffffc020358a:	cbb1                	beqz	a5,ffffffffc02035de <swapfs_read+0x5c>
ffffffffc020358c:	00016717          	auipc	a4,0x16
ffffffffc0203590:	04c73703          	ld	a4,76(a4) # ffffffffc02195d8 <max_swap_offset>
ffffffffc0203594:	04e7f563          	bgeu	a5,a4,ffffffffc02035de <swapfs_read+0x5c>
ffffffffc0203598:	00016617          	auipc	a2,0x16
ffffffffc020359c:	0b063603          	ld	a2,176(a2) # ffffffffc0219648 <pages>
ffffffffc02035a0:	8d91                	sub	a1,a1,a2
ffffffffc02035a2:	4065d613          	srai	a2,a1,0x6
ffffffffc02035a6:	00007717          	auipc	a4,0x7
ffffffffc02035aa:	ffa73703          	ld	a4,-6(a4) # ffffffffc020a5a0 <nbase>
ffffffffc02035ae:	963a                	add	a2,a2,a4
ffffffffc02035b0:	00c61713          	slli	a4,a2,0xc
ffffffffc02035b4:	8331                	srli	a4,a4,0xc
ffffffffc02035b6:	00016697          	auipc	a3,0x16
ffffffffc02035ba:	f3a6b683          	ld	a3,-198(a3) # ffffffffc02194f0 <npage>
ffffffffc02035be:	0037959b          	slliw	a1,a5,0x3
ffffffffc02035c2:	0632                	slli	a2,a2,0xc
ffffffffc02035c4:	02d77963          	bgeu	a4,a3,ffffffffc02035f6 <swapfs_read+0x74>
ffffffffc02035c8:	60a2                	ld	ra,8(sp)
ffffffffc02035ca:	00016797          	auipc	a5,0x16
ffffffffc02035ce:	06e7b783          	ld	a5,110(a5) # ffffffffc0219638 <va_pa_offset>
ffffffffc02035d2:	46a1                	li	a3,8
ffffffffc02035d4:	963e                	add	a2,a2,a5
ffffffffc02035d6:	4505                	li	a0,1
ffffffffc02035d8:	0141                	addi	sp,sp,16
ffffffffc02035da:	f55fc06f          	j	ffffffffc020052e <ide_read_secs>
ffffffffc02035de:	86aa                	mv	a3,a0
ffffffffc02035e0:	00006617          	auipc	a2,0x6
ffffffffc02035e4:	ee060613          	addi	a2,a2,-288 # ffffffffc02094c0 <default_pmm_manager+0x2a0>
ffffffffc02035e8:	45d1                	li	a1,20
ffffffffc02035ea:	00006517          	auipc	a0,0x6
ffffffffc02035ee:	ebe50513          	addi	a0,a0,-322 # ffffffffc02094a8 <default_pmm_manager+0x288>
ffffffffc02035f2:	c17fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02035f6:	86b2                	mv	a3,a2
ffffffffc02035f8:	06900593          	li	a1,105
ffffffffc02035fc:	00005617          	auipc	a2,0x5
ffffffffc0203600:	68c60613          	addi	a2,a2,1676 # ffffffffc0208c88 <commands+0xa98>
ffffffffc0203604:	00005517          	auipc	a0,0x5
ffffffffc0203608:	6ac50513          	addi	a0,a0,1708 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc020360c:	bfdfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203610 <swapfs_write>:
ffffffffc0203610:	1141                	addi	sp,sp,-16
ffffffffc0203612:	e406                	sd	ra,8(sp)
ffffffffc0203614:	00855793          	srli	a5,a0,0x8
ffffffffc0203618:	cbb1                	beqz	a5,ffffffffc020366c <swapfs_write+0x5c>
ffffffffc020361a:	00016717          	auipc	a4,0x16
ffffffffc020361e:	fbe73703          	ld	a4,-66(a4) # ffffffffc02195d8 <max_swap_offset>
ffffffffc0203622:	04e7f563          	bgeu	a5,a4,ffffffffc020366c <swapfs_write+0x5c>
ffffffffc0203626:	00016617          	auipc	a2,0x16
ffffffffc020362a:	02263603          	ld	a2,34(a2) # ffffffffc0219648 <pages>
ffffffffc020362e:	8d91                	sub	a1,a1,a2
ffffffffc0203630:	4065d613          	srai	a2,a1,0x6
ffffffffc0203634:	00007717          	auipc	a4,0x7
ffffffffc0203638:	f6c73703          	ld	a4,-148(a4) # ffffffffc020a5a0 <nbase>
ffffffffc020363c:	963a                	add	a2,a2,a4
ffffffffc020363e:	00c61713          	slli	a4,a2,0xc
ffffffffc0203642:	8331                	srli	a4,a4,0xc
ffffffffc0203644:	00016697          	auipc	a3,0x16
ffffffffc0203648:	eac6b683          	ld	a3,-340(a3) # ffffffffc02194f0 <npage>
ffffffffc020364c:	0037959b          	slliw	a1,a5,0x3
ffffffffc0203650:	0632                	slli	a2,a2,0xc
ffffffffc0203652:	02d77963          	bgeu	a4,a3,ffffffffc0203684 <swapfs_write+0x74>
ffffffffc0203656:	60a2                	ld	ra,8(sp)
ffffffffc0203658:	00016797          	auipc	a5,0x16
ffffffffc020365c:	fe07b783          	ld	a5,-32(a5) # ffffffffc0219638 <va_pa_offset>
ffffffffc0203660:	46a1                	li	a3,8
ffffffffc0203662:	963e                	add	a2,a2,a5
ffffffffc0203664:	4505                	li	a0,1
ffffffffc0203666:	0141                	addi	sp,sp,16
ffffffffc0203668:	eebfc06f          	j	ffffffffc0200552 <ide_write_secs>
ffffffffc020366c:	86aa                	mv	a3,a0
ffffffffc020366e:	00006617          	auipc	a2,0x6
ffffffffc0203672:	e5260613          	addi	a2,a2,-430 # ffffffffc02094c0 <default_pmm_manager+0x2a0>
ffffffffc0203676:	45e5                	li	a1,25
ffffffffc0203678:	00006517          	auipc	a0,0x6
ffffffffc020367c:	e3050513          	addi	a0,a0,-464 # ffffffffc02094a8 <default_pmm_manager+0x288>
ffffffffc0203680:	b89fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203684:	86b2                	mv	a3,a2
ffffffffc0203686:	06900593          	li	a1,105
ffffffffc020368a:	00005617          	auipc	a2,0x5
ffffffffc020368e:	5fe60613          	addi	a2,a2,1534 # ffffffffc0208c88 <commands+0xa98>
ffffffffc0203692:	00005517          	auipc	a0,0x5
ffffffffc0203696:	61e50513          	addi	a0,a0,1566 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc020369a:	b6ffc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020369e <switch_to>:
ffffffffc020369e:	00153023          	sd	ra,0(a0)
ffffffffc02036a2:	00253423          	sd	sp,8(a0)
ffffffffc02036a6:	e900                	sd	s0,16(a0)
ffffffffc02036a8:	ed04                	sd	s1,24(a0)
ffffffffc02036aa:	03253023          	sd	s2,32(a0)
ffffffffc02036ae:	03353423          	sd	s3,40(a0)
ffffffffc02036b2:	03453823          	sd	s4,48(a0)
ffffffffc02036b6:	03553c23          	sd	s5,56(a0)
ffffffffc02036ba:	05653023          	sd	s6,64(a0)
ffffffffc02036be:	05753423          	sd	s7,72(a0)
ffffffffc02036c2:	05853823          	sd	s8,80(a0)
ffffffffc02036c6:	05953c23          	sd	s9,88(a0)
ffffffffc02036ca:	07a53023          	sd	s10,96(a0)
ffffffffc02036ce:	07b53423          	sd	s11,104(a0)
ffffffffc02036d2:	0005b083          	ld	ra,0(a1)
ffffffffc02036d6:	0085b103          	ld	sp,8(a1)
ffffffffc02036da:	6980                	ld	s0,16(a1)
ffffffffc02036dc:	6d84                	ld	s1,24(a1)
ffffffffc02036de:	0205b903          	ld	s2,32(a1)
ffffffffc02036e2:	0285b983          	ld	s3,40(a1)
ffffffffc02036e6:	0305ba03          	ld	s4,48(a1)
ffffffffc02036ea:	0385ba83          	ld	s5,56(a1)
ffffffffc02036ee:	0405bb03          	ld	s6,64(a1)
ffffffffc02036f2:	0485bb83          	ld	s7,72(a1)
ffffffffc02036f6:	0505bc03          	ld	s8,80(a1)
ffffffffc02036fa:	0585bc83          	ld	s9,88(a1)
ffffffffc02036fe:	0605bd03          	ld	s10,96(a1)
ffffffffc0203702:	0685bd83          	ld	s11,104(a1)
ffffffffc0203706:	8082                	ret

ffffffffc0203708 <kernel_thread_entry>:
ffffffffc0203708:	8526                	mv	a0,s1
ffffffffc020370a:	9402                	jalr	s0
ffffffffc020370c:	616000ef          	jal	ra,ffffffffc0203d22 <do_exit>

ffffffffc0203710 <alloc_proc>:
ffffffffc0203710:	1141                	addi	sp,sp,-16
ffffffffc0203712:	14800513          	li	a0,328
ffffffffc0203716:	e022                	sd	s0,0(sp)
ffffffffc0203718:	e406                	sd	ra,8(sp)
ffffffffc020371a:	92efe0ef          	jal	ra,ffffffffc0201848 <kmalloc>
ffffffffc020371e:	842a                	mv	s0,a0
ffffffffc0203720:	cd21                	beqz	a0,ffffffffc0203778 <alloc_proc+0x68>
ffffffffc0203722:	57fd                	li	a5,-1
ffffffffc0203724:	1782                	slli	a5,a5,0x20
ffffffffc0203726:	e11c                	sd	a5,0(a0)
ffffffffc0203728:	07000613          	li	a2,112
ffffffffc020372c:	4581                	li	a1,0
ffffffffc020372e:	00052423          	sw	zero,8(a0)
ffffffffc0203732:	00053823          	sd	zero,16(a0)
ffffffffc0203736:	00053c23          	sd	zero,24(a0)
ffffffffc020373a:	02053023          	sd	zero,32(a0)
ffffffffc020373e:	02053423          	sd	zero,40(a0)
ffffffffc0203742:	03050513          	addi	a0,a0,48
ffffffffc0203746:	3dc040ef          	jal	ra,ffffffffc0207b22 <memset>
ffffffffc020374a:	00016797          	auipc	a5,0x16
ffffffffc020374e:	ef67b783          	ld	a5,-266(a5) # ffffffffc0219640 <boot_cr3>
ffffffffc0203752:	0a043023          	sd	zero,160(s0)
ffffffffc0203756:	f45c                	sd	a5,168(s0)
ffffffffc0203758:	0a042823          	sw	zero,176(s0)
ffffffffc020375c:	463d                	li	a2,15
ffffffffc020375e:	4581                	li	a1,0
ffffffffc0203760:	0b440513          	addi	a0,s0,180
ffffffffc0203764:	3be040ef          	jal	ra,ffffffffc0207b22 <memset>
ffffffffc0203768:	0e042623          	sw	zero,236(s0)
ffffffffc020376c:	0e043c23          	sd	zero,248(s0)
ffffffffc0203770:	10043023          	sd	zero,256(s0)
ffffffffc0203774:	0e043823          	sd	zero,240(s0)
ffffffffc0203778:	60a2                	ld	ra,8(sp)
ffffffffc020377a:	8522                	mv	a0,s0
ffffffffc020377c:	6402                	ld	s0,0(sp)
ffffffffc020377e:	0141                	addi	sp,sp,16
ffffffffc0203780:	8082                	ret

ffffffffc0203782 <forkret>:
ffffffffc0203782:	00016797          	auipc	a5,0x16
ffffffffc0203786:	d7e7b783          	ld	a5,-642(a5) # ffffffffc0219500 <current>
ffffffffc020378a:	73c8                	ld	a0,160(a5)
ffffffffc020378c:	d9efd06f          	j	ffffffffc0200d2a <forkrets>

ffffffffc0203790 <setup_pgdir.isra.0>:
ffffffffc0203790:	1101                	addi	sp,sp,-32
ffffffffc0203792:	e426                	sd	s1,8(sp)
ffffffffc0203794:	84aa                	mv	s1,a0
ffffffffc0203796:	4505                	li	a0,1
ffffffffc0203798:	ec06                	sd	ra,24(sp)
ffffffffc020379a:	e822                	sd	s0,16(sp)
ffffffffc020379c:	f43fe0ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc02037a0:	c939                	beqz	a0,ffffffffc02037f6 <setup_pgdir.isra.0+0x66>
ffffffffc02037a2:	00016697          	auipc	a3,0x16
ffffffffc02037a6:	ea66b683          	ld	a3,-346(a3) # ffffffffc0219648 <pages>
ffffffffc02037aa:	40d506b3          	sub	a3,a0,a3
ffffffffc02037ae:	8699                	srai	a3,a3,0x6
ffffffffc02037b0:	00007417          	auipc	s0,0x7
ffffffffc02037b4:	df043403          	ld	s0,-528(s0) # ffffffffc020a5a0 <nbase>
ffffffffc02037b8:	96a2                	add	a3,a3,s0
ffffffffc02037ba:	00c69793          	slli	a5,a3,0xc
ffffffffc02037be:	83b1                	srli	a5,a5,0xc
ffffffffc02037c0:	00016717          	auipc	a4,0x16
ffffffffc02037c4:	d3073703          	ld	a4,-720(a4) # ffffffffc02194f0 <npage>
ffffffffc02037c8:	06b2                	slli	a3,a3,0xc
ffffffffc02037ca:	02e7f863          	bgeu	a5,a4,ffffffffc02037fa <setup_pgdir.isra.0+0x6a>
ffffffffc02037ce:	00016417          	auipc	s0,0x16
ffffffffc02037d2:	e6a43403          	ld	s0,-406(s0) # ffffffffc0219638 <va_pa_offset>
ffffffffc02037d6:	9436                	add	s0,s0,a3
ffffffffc02037d8:	6605                	lui	a2,0x1
ffffffffc02037da:	00016597          	auipc	a1,0x16
ffffffffc02037de:	d0e5b583          	ld	a1,-754(a1) # ffffffffc02194e8 <boot_pgdir>
ffffffffc02037e2:	8522                	mv	a0,s0
ffffffffc02037e4:	350040ef          	jal	ra,ffffffffc0207b34 <memcpy>
ffffffffc02037e8:	4501                	li	a0,0
ffffffffc02037ea:	e080                	sd	s0,0(s1)
ffffffffc02037ec:	60e2                	ld	ra,24(sp)
ffffffffc02037ee:	6442                	ld	s0,16(sp)
ffffffffc02037f0:	64a2                	ld	s1,8(sp)
ffffffffc02037f2:	6105                	addi	sp,sp,32
ffffffffc02037f4:	8082                	ret
ffffffffc02037f6:	5571                	li	a0,-4
ffffffffc02037f8:	bfd5                	j	ffffffffc02037ec <setup_pgdir.isra.0+0x5c>
ffffffffc02037fa:	00005617          	auipc	a2,0x5
ffffffffc02037fe:	48e60613          	addi	a2,a2,1166 # ffffffffc0208c88 <commands+0xa98>
ffffffffc0203802:	06900593          	li	a1,105
ffffffffc0203806:	00005517          	auipc	a0,0x5
ffffffffc020380a:	4aa50513          	addi	a0,a0,1194 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc020380e:	9fbfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203812 <set_proc_name>:
ffffffffc0203812:	1101                	addi	sp,sp,-32
ffffffffc0203814:	e822                	sd	s0,16(sp)
ffffffffc0203816:	0b450413          	addi	s0,a0,180
ffffffffc020381a:	e426                	sd	s1,8(sp)
ffffffffc020381c:	4641                	li	a2,16
ffffffffc020381e:	84ae                	mv	s1,a1
ffffffffc0203820:	8522                	mv	a0,s0
ffffffffc0203822:	4581                	li	a1,0
ffffffffc0203824:	ec06                	sd	ra,24(sp)
ffffffffc0203826:	2fc040ef          	jal	ra,ffffffffc0207b22 <memset>
ffffffffc020382a:	8522                	mv	a0,s0
ffffffffc020382c:	6442                	ld	s0,16(sp)
ffffffffc020382e:	60e2                	ld	ra,24(sp)
ffffffffc0203830:	85a6                	mv	a1,s1
ffffffffc0203832:	64a2                	ld	s1,8(sp)
ffffffffc0203834:	463d                	li	a2,15
ffffffffc0203836:	6105                	addi	sp,sp,32
ffffffffc0203838:	2fc0406f          	j	ffffffffc0207b34 <memcpy>

ffffffffc020383c <proc_run>:
ffffffffc020383c:	7179                	addi	sp,sp,-48
ffffffffc020383e:	ec4a                	sd	s2,24(sp)
ffffffffc0203840:	00016917          	auipc	s2,0x16
ffffffffc0203844:	cc090913          	addi	s2,s2,-832 # ffffffffc0219500 <current>
ffffffffc0203848:	f026                	sd	s1,32(sp)
ffffffffc020384a:	00093483          	ld	s1,0(s2)
ffffffffc020384e:	f406                	sd	ra,40(sp)
ffffffffc0203850:	e84e                	sd	s3,16(sp)
ffffffffc0203852:	02a48863          	beq	s1,a0,ffffffffc0203882 <proc_run+0x46>
ffffffffc0203856:	100027f3          	csrr	a5,sstatus
ffffffffc020385a:	8b89                	andi	a5,a5,2
ffffffffc020385c:	4981                	li	s3,0
ffffffffc020385e:	ef9d                	bnez	a5,ffffffffc020389c <proc_run+0x60>
ffffffffc0203860:	755c                	ld	a5,168(a0)
ffffffffc0203862:	577d                	li	a4,-1
ffffffffc0203864:	177e                	slli	a4,a4,0x3f
ffffffffc0203866:	83b1                	srli	a5,a5,0xc
ffffffffc0203868:	00a93023          	sd	a0,0(s2)
ffffffffc020386c:	8fd9                	or	a5,a5,a4
ffffffffc020386e:	18079073          	csrw	satp,a5
ffffffffc0203872:	03050593          	addi	a1,a0,48
ffffffffc0203876:	03048513          	addi	a0,s1,48
ffffffffc020387a:	e25ff0ef          	jal	ra,ffffffffc020369e <switch_to>
ffffffffc020387e:	00099863          	bnez	s3,ffffffffc020388e <proc_run+0x52>
ffffffffc0203882:	70a2                	ld	ra,40(sp)
ffffffffc0203884:	7482                	ld	s1,32(sp)
ffffffffc0203886:	6962                	ld	s2,24(sp)
ffffffffc0203888:	69c2                	ld	s3,16(sp)
ffffffffc020388a:	6145                	addi	sp,sp,48
ffffffffc020388c:	8082                	ret
ffffffffc020388e:	70a2                	ld	ra,40(sp)
ffffffffc0203890:	7482                	ld	s1,32(sp)
ffffffffc0203892:	6962                	ld	s2,24(sp)
ffffffffc0203894:	69c2                	ld	s3,16(sp)
ffffffffc0203896:	6145                	addi	sp,sp,48
ffffffffc0203898:	d9bfc06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc020389c:	e42a                	sd	a0,8(sp)
ffffffffc020389e:	d9bfc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02038a2:	6522                	ld	a0,8(sp)
ffffffffc02038a4:	4985                	li	s3,1
ffffffffc02038a6:	bf6d                	j	ffffffffc0203860 <proc_run+0x24>

ffffffffc02038a8 <find_proc>:
ffffffffc02038a8:	6789                	lui	a5,0x2
ffffffffc02038aa:	fff5071b          	addiw	a4,a0,-1
ffffffffc02038ae:	17f9                	addi	a5,a5,-2
ffffffffc02038b0:	04e7e063          	bltu	a5,a4,ffffffffc02038f0 <find_proc+0x48>
ffffffffc02038b4:	1141                	addi	sp,sp,-16
ffffffffc02038b6:	e022                	sd	s0,0(sp)
ffffffffc02038b8:	45a9                	li	a1,10
ffffffffc02038ba:	842a                	mv	s0,a0
ffffffffc02038bc:	2501                	sext.w	a0,a0
ffffffffc02038be:	e406                	sd	ra,8(sp)
ffffffffc02038c0:	67a040ef          	jal	ra,ffffffffc0207f3a <hash32>
ffffffffc02038c4:	02051693          	slli	a3,a0,0x20
ffffffffc02038c8:	00012797          	auipc	a5,0x12
ffffffffc02038cc:	bc878793          	addi	a5,a5,-1080 # ffffffffc0215490 <hash_list>
ffffffffc02038d0:	82f1                	srli	a3,a3,0x1c
ffffffffc02038d2:	96be                	add	a3,a3,a5
ffffffffc02038d4:	87b6                	mv	a5,a3
ffffffffc02038d6:	a029                	j	ffffffffc02038e0 <find_proc+0x38>
ffffffffc02038d8:	f2c7a703          	lw	a4,-212(a5)
ffffffffc02038dc:	00870c63          	beq	a4,s0,ffffffffc02038f4 <find_proc+0x4c>
ffffffffc02038e0:	679c                	ld	a5,8(a5)
ffffffffc02038e2:	fef69be3          	bne	a3,a5,ffffffffc02038d8 <find_proc+0x30>
ffffffffc02038e6:	60a2                	ld	ra,8(sp)
ffffffffc02038e8:	6402                	ld	s0,0(sp)
ffffffffc02038ea:	4501                	li	a0,0
ffffffffc02038ec:	0141                	addi	sp,sp,16
ffffffffc02038ee:	8082                	ret
ffffffffc02038f0:	4501                	li	a0,0
ffffffffc02038f2:	8082                	ret
ffffffffc02038f4:	60a2                	ld	ra,8(sp)
ffffffffc02038f6:	6402                	ld	s0,0(sp)
ffffffffc02038f8:	f2878513          	addi	a0,a5,-216
ffffffffc02038fc:	0141                	addi	sp,sp,16
ffffffffc02038fe:	8082                	ret

ffffffffc0203900 <do_fork>:
ffffffffc0203900:	7159                	addi	sp,sp,-112
ffffffffc0203902:	e4ce                	sd	s3,72(sp)
ffffffffc0203904:	00016997          	auipc	s3,0x16
ffffffffc0203908:	c1498993          	addi	s3,s3,-1004 # ffffffffc0219518 <nr_process>
ffffffffc020390c:	0009a703          	lw	a4,0(s3)
ffffffffc0203910:	f486                	sd	ra,104(sp)
ffffffffc0203912:	f0a2                	sd	s0,96(sp)
ffffffffc0203914:	eca6                	sd	s1,88(sp)
ffffffffc0203916:	e8ca                	sd	s2,80(sp)
ffffffffc0203918:	e0d2                	sd	s4,64(sp)
ffffffffc020391a:	fc56                	sd	s5,56(sp)
ffffffffc020391c:	f85a                	sd	s6,48(sp)
ffffffffc020391e:	f45e                	sd	s7,40(sp)
ffffffffc0203920:	f062                	sd	s8,32(sp)
ffffffffc0203922:	ec66                	sd	s9,24(sp)
ffffffffc0203924:	e86a                	sd	s10,16(sp)
ffffffffc0203926:	e46e                	sd	s11,8(sp)
ffffffffc0203928:	6785                	lui	a5,0x1
ffffffffc020392a:	30f75f63          	bge	a4,a5,ffffffffc0203c48 <do_fork+0x348>
ffffffffc020392e:	8a2a                	mv	s4,a0
ffffffffc0203930:	892e                	mv	s2,a1
ffffffffc0203932:	84b2                	mv	s1,a2
ffffffffc0203934:	dddff0ef          	jal	ra,ffffffffc0203710 <alloc_proc>
ffffffffc0203938:	842a                	mv	s0,a0
ffffffffc020393a:	28050263          	beqz	a0,ffffffffc0203bbe <do_fork+0x2be>
ffffffffc020393e:	00016b97          	auipc	s7,0x16
ffffffffc0203942:	bc2b8b93          	addi	s7,s7,-1086 # ffffffffc0219500 <current>
ffffffffc0203946:	000bb783          	ld	a5,0(s7)
ffffffffc020394a:	0ec7a703          	lw	a4,236(a5) # 10ec <kern_entry-0xffffffffc01fef14>
ffffffffc020394e:	f11c                	sd	a5,32(a0)
ffffffffc0203950:	30071c63          	bnez	a4,ffffffffc0203c68 <do_fork+0x368>
ffffffffc0203954:	4509                	li	a0,2
ffffffffc0203956:	d89fe0ef          	jal	ra,ffffffffc02026de <alloc_pages>
ffffffffc020395a:	24050f63          	beqz	a0,ffffffffc0203bb8 <do_fork+0x2b8>
ffffffffc020395e:	00016c17          	auipc	s8,0x16
ffffffffc0203962:	ceac0c13          	addi	s8,s8,-790 # ffffffffc0219648 <pages>
ffffffffc0203966:	000c3683          	ld	a3,0(s8)
ffffffffc020396a:	00007a97          	auipc	s5,0x7
ffffffffc020396e:	c36aba83          	ld	s5,-970(s5) # ffffffffc020a5a0 <nbase>
ffffffffc0203972:	00016c97          	auipc	s9,0x16
ffffffffc0203976:	b7ec8c93          	addi	s9,s9,-1154 # ffffffffc02194f0 <npage>
ffffffffc020397a:	40d506b3          	sub	a3,a0,a3
ffffffffc020397e:	8699                	srai	a3,a3,0x6
ffffffffc0203980:	96d6                	add	a3,a3,s5
ffffffffc0203982:	000cb703          	ld	a4,0(s9)
ffffffffc0203986:	00c69793          	slli	a5,a3,0xc
ffffffffc020398a:	83b1                	srli	a5,a5,0xc
ffffffffc020398c:	06b2                	slli	a3,a3,0xc
ffffffffc020398e:	2ce7f163          	bgeu	a5,a4,ffffffffc0203c50 <do_fork+0x350>
ffffffffc0203992:	000bb703          	ld	a4,0(s7)
ffffffffc0203996:	00016d17          	auipc	s10,0x16
ffffffffc020399a:	ca2d0d13          	addi	s10,s10,-862 # ffffffffc0219638 <va_pa_offset>
ffffffffc020399e:	000d3783          	ld	a5,0(s10)
ffffffffc02039a2:	02873b03          	ld	s6,40(a4)
ffffffffc02039a6:	96be                	add	a3,a3,a5
ffffffffc02039a8:	e814                	sd	a3,16(s0)
ffffffffc02039aa:	020b0863          	beqz	s6,ffffffffc02039da <do_fork+0xda>
ffffffffc02039ae:	100a7a13          	andi	s4,s4,256
ffffffffc02039b2:	1c0a0163          	beqz	s4,ffffffffc0203b74 <do_fork+0x274>
ffffffffc02039b6:	030b2703          	lw	a4,48(s6)
ffffffffc02039ba:	018b3783          	ld	a5,24(s6)
ffffffffc02039be:	c02006b7          	lui	a3,0xc0200
ffffffffc02039c2:	2705                	addiw	a4,a4,1
ffffffffc02039c4:	02eb2823          	sw	a4,48(s6)
ffffffffc02039c8:	03643423          	sd	s6,40(s0)
ffffffffc02039cc:	2ad7ee63          	bltu	a5,a3,ffffffffc0203c88 <do_fork+0x388>
ffffffffc02039d0:	000d3703          	ld	a4,0(s10)
ffffffffc02039d4:	6814                	ld	a3,16(s0)
ffffffffc02039d6:	8f99                	sub	a5,a5,a4
ffffffffc02039d8:	f45c                	sd	a5,168(s0)
ffffffffc02039da:	6789                	lui	a5,0x2
ffffffffc02039dc:	ee078793          	addi	a5,a5,-288 # 1ee0 <kern_entry-0xffffffffc01fe120>
ffffffffc02039e0:	97b6                	add	a5,a5,a3
ffffffffc02039e2:	8626                	mv	a2,s1
ffffffffc02039e4:	f05c                	sd	a5,160(s0)
ffffffffc02039e6:	873e                	mv	a4,a5
ffffffffc02039e8:	12048313          	addi	t1,s1,288
ffffffffc02039ec:	00063883          	ld	a7,0(a2)
ffffffffc02039f0:	00863803          	ld	a6,8(a2)
ffffffffc02039f4:	6a08                	ld	a0,16(a2)
ffffffffc02039f6:	6e0c                	ld	a1,24(a2)
ffffffffc02039f8:	01173023          	sd	a7,0(a4)
ffffffffc02039fc:	01073423          	sd	a6,8(a4)
ffffffffc0203a00:	eb08                	sd	a0,16(a4)
ffffffffc0203a02:	ef0c                	sd	a1,24(a4)
ffffffffc0203a04:	02060613          	addi	a2,a2,32
ffffffffc0203a08:	02070713          	addi	a4,a4,32
ffffffffc0203a0c:	fe6610e3          	bne	a2,t1,ffffffffc02039ec <do_fork+0xec>
ffffffffc0203a10:	0407b823          	sd	zero,80(a5)
ffffffffc0203a14:	12090a63          	beqz	s2,ffffffffc0203b48 <do_fork+0x248>
ffffffffc0203a18:	0127b823          	sd	s2,16(a5)
ffffffffc0203a1c:	00000717          	auipc	a4,0x0
ffffffffc0203a20:	d6670713          	addi	a4,a4,-666 # ffffffffc0203782 <forkret>
ffffffffc0203a24:	f818                	sd	a4,48(s0)
ffffffffc0203a26:	fc1c                	sd	a5,56(s0)
ffffffffc0203a28:	100027f3          	csrr	a5,sstatus
ffffffffc0203a2c:	8b89                	andi	a5,a5,2
ffffffffc0203a2e:	4901                	li	s2,0
ffffffffc0203a30:	12079e63          	bnez	a5,ffffffffc0203b6c <do_fork+0x26c>
ffffffffc0203a34:	0000a597          	auipc	a1,0xa
ffffffffc0203a38:	65458593          	addi	a1,a1,1620 # ffffffffc020e088 <last_pid.1812>
ffffffffc0203a3c:	419c                	lw	a5,0(a1)
ffffffffc0203a3e:	6709                	lui	a4,0x2
ffffffffc0203a40:	0017851b          	addiw	a0,a5,1
ffffffffc0203a44:	c188                	sw	a0,0(a1)
ffffffffc0203a46:	08e55b63          	bge	a0,a4,ffffffffc0203adc <do_fork+0x1dc>
ffffffffc0203a4a:	0000a897          	auipc	a7,0xa
ffffffffc0203a4e:	64288893          	addi	a7,a7,1602 # ffffffffc020e08c <next_safe.1811>
ffffffffc0203a52:	0008a783          	lw	a5,0(a7)
ffffffffc0203a56:	00016497          	auipc	s1,0x16
ffffffffc0203a5a:	c7248493          	addi	s1,s1,-910 # ffffffffc02196c8 <proc_list>
ffffffffc0203a5e:	08f55663          	bge	a0,a5,ffffffffc0203aea <do_fork+0x1ea>
ffffffffc0203a62:	c048                	sw	a0,4(s0)
ffffffffc0203a64:	45a9                	li	a1,10
ffffffffc0203a66:	2501                	sext.w	a0,a0
ffffffffc0203a68:	4d2040ef          	jal	ra,ffffffffc0207f3a <hash32>
ffffffffc0203a6c:	1502                	slli	a0,a0,0x20
ffffffffc0203a6e:	00012797          	auipc	a5,0x12
ffffffffc0203a72:	a2278793          	addi	a5,a5,-1502 # ffffffffc0215490 <hash_list>
ffffffffc0203a76:	8171                	srli	a0,a0,0x1c
ffffffffc0203a78:	953e                	add	a0,a0,a5
ffffffffc0203a7a:	650c                	ld	a1,8(a0)
ffffffffc0203a7c:	7014                	ld	a3,32(s0)
ffffffffc0203a7e:	0d840793          	addi	a5,s0,216
ffffffffc0203a82:	e19c                	sd	a5,0(a1)
ffffffffc0203a84:	6490                	ld	a2,8(s1)
ffffffffc0203a86:	e51c                	sd	a5,8(a0)
ffffffffc0203a88:	7af8                	ld	a4,240(a3)
ffffffffc0203a8a:	0c840793          	addi	a5,s0,200
ffffffffc0203a8e:	f06c                	sd	a1,224(s0)
ffffffffc0203a90:	ec68                	sd	a0,216(s0)
ffffffffc0203a92:	e21c                	sd	a5,0(a2)
ffffffffc0203a94:	e49c                	sd	a5,8(s1)
ffffffffc0203a96:	e870                	sd	a2,208(s0)
ffffffffc0203a98:	e464                	sd	s1,200(s0)
ffffffffc0203a9a:	0e043c23          	sd	zero,248(s0)
ffffffffc0203a9e:	10e43023          	sd	a4,256(s0)
ffffffffc0203aa2:	c311                	beqz	a4,ffffffffc0203aa6 <do_fork+0x1a6>
ffffffffc0203aa4:	ff60                	sd	s0,248(a4)
ffffffffc0203aa6:	0009a783          	lw	a5,0(s3)
ffffffffc0203aaa:	fae0                	sd	s0,240(a3)
ffffffffc0203aac:	2785                	addiw	a5,a5,1
ffffffffc0203aae:	00f9a023          	sw	a5,0(s3)
ffffffffc0203ab2:	10091863          	bnez	s2,ffffffffc0203bc2 <do_fork+0x2c2>
ffffffffc0203ab6:	8522                	mv	a0,s0
ffffffffc0203ab8:	733000ef          	jal	ra,ffffffffc02049ea <wakeup_proc>
ffffffffc0203abc:	4048                	lw	a0,4(s0)
ffffffffc0203abe:	70a6                	ld	ra,104(sp)
ffffffffc0203ac0:	7406                	ld	s0,96(sp)
ffffffffc0203ac2:	64e6                	ld	s1,88(sp)
ffffffffc0203ac4:	6946                	ld	s2,80(sp)
ffffffffc0203ac6:	69a6                	ld	s3,72(sp)
ffffffffc0203ac8:	6a06                	ld	s4,64(sp)
ffffffffc0203aca:	7ae2                	ld	s5,56(sp)
ffffffffc0203acc:	7b42                	ld	s6,48(sp)
ffffffffc0203ace:	7ba2                	ld	s7,40(sp)
ffffffffc0203ad0:	7c02                	ld	s8,32(sp)
ffffffffc0203ad2:	6ce2                	ld	s9,24(sp)
ffffffffc0203ad4:	6d42                	ld	s10,16(sp)
ffffffffc0203ad6:	6da2                	ld	s11,8(sp)
ffffffffc0203ad8:	6165                	addi	sp,sp,112
ffffffffc0203ada:	8082                	ret
ffffffffc0203adc:	4785                	li	a5,1
ffffffffc0203ade:	c19c                	sw	a5,0(a1)
ffffffffc0203ae0:	4505                	li	a0,1
ffffffffc0203ae2:	0000a897          	auipc	a7,0xa
ffffffffc0203ae6:	5aa88893          	addi	a7,a7,1450 # ffffffffc020e08c <next_safe.1811>
ffffffffc0203aea:	00016497          	auipc	s1,0x16
ffffffffc0203aee:	bde48493          	addi	s1,s1,-1058 # ffffffffc02196c8 <proc_list>
ffffffffc0203af2:	0084b303          	ld	t1,8(s1)
ffffffffc0203af6:	6789                	lui	a5,0x2
ffffffffc0203af8:	00f8a023          	sw	a5,0(a7)
ffffffffc0203afc:	4801                	li	a6,0
ffffffffc0203afe:	87aa                	mv	a5,a0
ffffffffc0203b00:	6e89                	lui	t4,0x2
ffffffffc0203b02:	12930e63          	beq	t1,s1,ffffffffc0203c3e <do_fork+0x33e>
ffffffffc0203b06:	8e42                	mv	t3,a6
ffffffffc0203b08:	869a                	mv	a3,t1
ffffffffc0203b0a:	6609                	lui	a2,0x2
ffffffffc0203b0c:	a811                	j	ffffffffc0203b20 <do_fork+0x220>
ffffffffc0203b0e:	00e7d663          	bge	a5,a4,ffffffffc0203b1a <do_fork+0x21a>
ffffffffc0203b12:	00c75463          	bge	a4,a2,ffffffffc0203b1a <do_fork+0x21a>
ffffffffc0203b16:	863a                	mv	a2,a4
ffffffffc0203b18:	4e05                	li	t3,1
ffffffffc0203b1a:	6694                	ld	a3,8(a3)
ffffffffc0203b1c:	00968d63          	beq	a3,s1,ffffffffc0203b36 <do_fork+0x236>
ffffffffc0203b20:	f3c6a703          	lw	a4,-196(a3) # ffffffffc01fff3c <kern_entry-0xc4>
ffffffffc0203b24:	fef715e3          	bne	a4,a5,ffffffffc0203b0e <do_fork+0x20e>
ffffffffc0203b28:	2785                	addiw	a5,a5,1
ffffffffc0203b2a:	08c7df63          	bge	a5,a2,ffffffffc0203bc8 <do_fork+0x2c8>
ffffffffc0203b2e:	6694                	ld	a3,8(a3)
ffffffffc0203b30:	4805                	li	a6,1
ffffffffc0203b32:	fe9697e3          	bne	a3,s1,ffffffffc0203b20 <do_fork+0x220>
ffffffffc0203b36:	00080463          	beqz	a6,ffffffffc0203b3e <do_fork+0x23e>
ffffffffc0203b3a:	c19c                	sw	a5,0(a1)
ffffffffc0203b3c:	853e                	mv	a0,a5
ffffffffc0203b3e:	f20e02e3          	beqz	t3,ffffffffc0203a62 <do_fork+0x162>
ffffffffc0203b42:	00c8a023          	sw	a2,0(a7)
ffffffffc0203b46:	bf31                	j	ffffffffc0203a62 <do_fork+0x162>
ffffffffc0203b48:	6909                	lui	s2,0x2
ffffffffc0203b4a:	edc90913          	addi	s2,s2,-292 # 1edc <kern_entry-0xffffffffc01fe124>
ffffffffc0203b4e:	9936                	add	s2,s2,a3
ffffffffc0203b50:	0127b823          	sd	s2,16(a5) # 2010 <kern_entry-0xffffffffc01fdff0>
ffffffffc0203b54:	00000717          	auipc	a4,0x0
ffffffffc0203b58:	c2e70713          	addi	a4,a4,-978 # ffffffffc0203782 <forkret>
ffffffffc0203b5c:	f818                	sd	a4,48(s0)
ffffffffc0203b5e:	fc1c                	sd	a5,56(s0)
ffffffffc0203b60:	100027f3          	csrr	a5,sstatus
ffffffffc0203b64:	8b89                	andi	a5,a5,2
ffffffffc0203b66:	4901                	li	s2,0
ffffffffc0203b68:	ec0786e3          	beqz	a5,ffffffffc0203a34 <do_fork+0x134>
ffffffffc0203b6c:	acdfc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203b70:	4905                	li	s2,1
ffffffffc0203b72:	b5c9                	j	ffffffffc0203a34 <do_fork+0x134>
ffffffffc0203b74:	9defd0ef          	jal	ra,ffffffffc0200d52 <mm_create>
ffffffffc0203b78:	8a2a                	mv	s4,a0
ffffffffc0203b7a:	c901                	beqz	a0,ffffffffc0203b8a <do_fork+0x28a>
ffffffffc0203b7c:	0561                	addi	a0,a0,24
ffffffffc0203b7e:	c13ff0ef          	jal	ra,ffffffffc0203790 <setup_pgdir.isra.0>
ffffffffc0203b82:	c921                	beqz	a0,ffffffffc0203bd2 <do_fork+0x2d2>
ffffffffc0203b84:	8552                	mv	a0,s4
ffffffffc0203b86:	b2afd0ef          	jal	ra,ffffffffc0200eb0 <mm_destroy>
ffffffffc0203b8a:	6814                	ld	a3,16(s0)
ffffffffc0203b8c:	c02007b7          	lui	a5,0xc0200
ffffffffc0203b90:	12f6e563          	bltu	a3,a5,ffffffffc0203cba <do_fork+0x3ba>
ffffffffc0203b94:	000d3783          	ld	a5,0(s10)
ffffffffc0203b98:	000cb703          	ld	a4,0(s9)
ffffffffc0203b9c:	40f687b3          	sub	a5,a3,a5
ffffffffc0203ba0:	83b1                	srli	a5,a5,0xc
ffffffffc0203ba2:	10e7f063          	bgeu	a5,a4,ffffffffc0203ca2 <do_fork+0x3a2>
ffffffffc0203ba6:	000c3503          	ld	a0,0(s8)
ffffffffc0203baa:	415787b3          	sub	a5,a5,s5
ffffffffc0203bae:	079a                	slli	a5,a5,0x6
ffffffffc0203bb0:	4589                	li	a1,2
ffffffffc0203bb2:	953e                	add	a0,a0,a5
ffffffffc0203bb4:	bbdfe0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0203bb8:	8522                	mv	a0,s0
ffffffffc0203bba:	d3ffd0ef          	jal	ra,ffffffffc02018f8 <kfree>
ffffffffc0203bbe:	5571                	li	a0,-4
ffffffffc0203bc0:	bdfd                	j	ffffffffc0203abe <do_fork+0x1be>
ffffffffc0203bc2:	a71fc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203bc6:	bdc5                	j	ffffffffc0203ab6 <do_fork+0x1b6>
ffffffffc0203bc8:	01d7c363          	blt	a5,t4,ffffffffc0203bce <do_fork+0x2ce>
ffffffffc0203bcc:	4785                	li	a5,1
ffffffffc0203bce:	4805                	li	a6,1
ffffffffc0203bd0:	bf0d                	j	ffffffffc0203b02 <do_fork+0x202>
ffffffffc0203bd2:	038b0d93          	addi	s11,s6,56
ffffffffc0203bd6:	856e                	mv	a0,s11
ffffffffc0203bd8:	f0aff0ef          	jal	ra,ffffffffc02032e2 <down>
ffffffffc0203bdc:	000bb783          	ld	a5,0(s7)
ffffffffc0203be0:	c781                	beqz	a5,ffffffffc0203be8 <do_fork+0x2e8>
ffffffffc0203be2:	43dc                	lw	a5,4(a5)
ffffffffc0203be4:	04fb2823          	sw	a5,80(s6)
ffffffffc0203be8:	85da                	mv	a1,s6
ffffffffc0203bea:	8552                	mv	a0,s4
ffffffffc0203bec:	bc6fd0ef          	jal	ra,ffffffffc0200fb2 <dup_mmap>
ffffffffc0203bf0:	8baa                	mv	s7,a0
ffffffffc0203bf2:	856e                	mv	a0,s11
ffffffffc0203bf4:	eecff0ef          	jal	ra,ffffffffc02032e0 <up>
ffffffffc0203bf8:	040b2823          	sw	zero,80(s6)
ffffffffc0203bfc:	8b52                	mv	s6,s4
ffffffffc0203bfe:	da0b8ce3          	beqz	s7,ffffffffc02039b6 <do_fork+0xb6>
ffffffffc0203c02:	8552                	mv	a0,s4
ffffffffc0203c04:	c48fd0ef          	jal	ra,ffffffffc020104c <exit_mmap>
ffffffffc0203c08:	018a3683          	ld	a3,24(s4)
ffffffffc0203c0c:	c02007b7          	lui	a5,0xc0200
ffffffffc0203c10:	0af6e563          	bltu	a3,a5,ffffffffc0203cba <do_fork+0x3ba>
ffffffffc0203c14:	000d3703          	ld	a4,0(s10)
ffffffffc0203c18:	000cb783          	ld	a5,0(s9)
ffffffffc0203c1c:	8e99                	sub	a3,a3,a4
ffffffffc0203c1e:	82b1                	srli	a3,a3,0xc
ffffffffc0203c20:	08f6f163          	bgeu	a3,a5,ffffffffc0203ca2 <do_fork+0x3a2>
ffffffffc0203c24:	000c3503          	ld	a0,0(s8)
ffffffffc0203c28:	415686b3          	sub	a3,a3,s5
ffffffffc0203c2c:	069a                	slli	a3,a3,0x6
ffffffffc0203c2e:	9536                	add	a0,a0,a3
ffffffffc0203c30:	4585                	li	a1,1
ffffffffc0203c32:	b3ffe0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0203c36:	8552                	mv	a0,s4
ffffffffc0203c38:	a78fd0ef          	jal	ra,ffffffffc0200eb0 <mm_destroy>
ffffffffc0203c3c:	b7b9                	j	ffffffffc0203b8a <do_fork+0x28a>
ffffffffc0203c3e:	00080763          	beqz	a6,ffffffffc0203c4c <do_fork+0x34c>
ffffffffc0203c42:	c19c                	sw	a5,0(a1)
ffffffffc0203c44:	853e                	mv	a0,a5
ffffffffc0203c46:	bd31                	j	ffffffffc0203a62 <do_fork+0x162>
ffffffffc0203c48:	556d                	li	a0,-5
ffffffffc0203c4a:	bd95                	j	ffffffffc0203abe <do_fork+0x1be>
ffffffffc0203c4c:	4188                	lw	a0,0(a1)
ffffffffc0203c4e:	bd11                	j	ffffffffc0203a62 <do_fork+0x162>
ffffffffc0203c50:	00005617          	auipc	a2,0x5
ffffffffc0203c54:	03860613          	addi	a2,a2,56 # ffffffffc0208c88 <commands+0xa98>
ffffffffc0203c58:	06900593          	li	a1,105
ffffffffc0203c5c:	00005517          	auipc	a0,0x5
ffffffffc0203c60:	05450513          	addi	a0,a0,84 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc0203c64:	da4fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c68:	00006697          	auipc	a3,0x6
ffffffffc0203c6c:	87868693          	addi	a3,a3,-1928 # ffffffffc02094e0 <default_pmm_manager+0x2c0>
ffffffffc0203c70:	00005617          	auipc	a2,0x5
ffffffffc0203c74:	99060613          	addi	a2,a2,-1648 # ffffffffc0208600 <commands+0x410>
ffffffffc0203c78:	1a600593          	li	a1,422
ffffffffc0203c7c:	00006517          	auipc	a0,0x6
ffffffffc0203c80:	88450513          	addi	a0,a0,-1916 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0203c84:	d84fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c88:	86be                	mv	a3,a5
ffffffffc0203c8a:	00005617          	auipc	a2,0x5
ffffffffc0203c8e:	06e60613          	addi	a2,a2,110 # ffffffffc0208cf8 <commands+0xb08>
ffffffffc0203c92:	15900593          	li	a1,345
ffffffffc0203c96:	00006517          	auipc	a0,0x6
ffffffffc0203c9a:	86a50513          	addi	a0,a0,-1942 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0203c9e:	d6afc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203ca2:	00005617          	auipc	a2,0x5
ffffffffc0203ca6:	07e60613          	addi	a2,a2,126 # ffffffffc0208d20 <commands+0xb30>
ffffffffc0203caa:	06200593          	li	a1,98
ffffffffc0203cae:	00005517          	auipc	a0,0x5
ffffffffc0203cb2:	00250513          	addi	a0,a0,2 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc0203cb6:	d52fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203cba:	00005617          	auipc	a2,0x5
ffffffffc0203cbe:	03e60613          	addi	a2,a2,62 # ffffffffc0208cf8 <commands+0xb08>
ffffffffc0203cc2:	06e00593          	li	a1,110
ffffffffc0203cc6:	00005517          	auipc	a0,0x5
ffffffffc0203cca:	fea50513          	addi	a0,a0,-22 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc0203cce:	d3afc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203cd2 <kernel_thread>:
ffffffffc0203cd2:	7129                	addi	sp,sp,-320
ffffffffc0203cd4:	fa22                	sd	s0,304(sp)
ffffffffc0203cd6:	f626                	sd	s1,296(sp)
ffffffffc0203cd8:	f24a                	sd	s2,288(sp)
ffffffffc0203cda:	84ae                	mv	s1,a1
ffffffffc0203cdc:	892a                	mv	s2,a0
ffffffffc0203cde:	8432                	mv	s0,a2
ffffffffc0203ce0:	4581                	li	a1,0
ffffffffc0203ce2:	12000613          	li	a2,288
ffffffffc0203ce6:	850a                	mv	a0,sp
ffffffffc0203ce8:	fe06                	sd	ra,312(sp)
ffffffffc0203cea:	639030ef          	jal	ra,ffffffffc0207b22 <memset>
ffffffffc0203cee:	e0ca                	sd	s2,64(sp)
ffffffffc0203cf0:	e4a6                	sd	s1,72(sp)
ffffffffc0203cf2:	100027f3          	csrr	a5,sstatus
ffffffffc0203cf6:	edd7f793          	andi	a5,a5,-291
ffffffffc0203cfa:	1207e793          	ori	a5,a5,288
ffffffffc0203cfe:	e23e                	sd	a5,256(sp)
ffffffffc0203d00:	860a                	mv	a2,sp
ffffffffc0203d02:	10046513          	ori	a0,s0,256
ffffffffc0203d06:	00000797          	auipc	a5,0x0
ffffffffc0203d0a:	a0278793          	addi	a5,a5,-1534 # ffffffffc0203708 <kernel_thread_entry>
ffffffffc0203d0e:	4581                	li	a1,0
ffffffffc0203d10:	e63e                	sd	a5,264(sp)
ffffffffc0203d12:	befff0ef          	jal	ra,ffffffffc0203900 <do_fork>
ffffffffc0203d16:	70f2                	ld	ra,312(sp)
ffffffffc0203d18:	7452                	ld	s0,304(sp)
ffffffffc0203d1a:	74b2                	ld	s1,296(sp)
ffffffffc0203d1c:	7912                	ld	s2,288(sp)
ffffffffc0203d1e:	6131                	addi	sp,sp,320
ffffffffc0203d20:	8082                	ret

ffffffffc0203d22 <do_exit>:
ffffffffc0203d22:	7179                	addi	sp,sp,-48
ffffffffc0203d24:	f022                	sd	s0,32(sp)
ffffffffc0203d26:	00015417          	auipc	s0,0x15
ffffffffc0203d2a:	7da40413          	addi	s0,s0,2010 # ffffffffc0219500 <current>
ffffffffc0203d2e:	601c                	ld	a5,0(s0)
ffffffffc0203d30:	f406                	sd	ra,40(sp)
ffffffffc0203d32:	ec26                	sd	s1,24(sp)
ffffffffc0203d34:	e84a                	sd	s2,16(sp)
ffffffffc0203d36:	e44e                	sd	s3,8(sp)
ffffffffc0203d38:	e052                	sd	s4,0(sp)
ffffffffc0203d3a:	00015717          	auipc	a4,0x15
ffffffffc0203d3e:	7ce73703          	ld	a4,1998(a4) # ffffffffc0219508 <idleproc>
ffffffffc0203d42:	0ce78d63          	beq	a5,a4,ffffffffc0203e1c <do_exit+0xfa>
ffffffffc0203d46:	00015497          	auipc	s1,0x15
ffffffffc0203d4a:	7ca48493          	addi	s1,s1,1994 # ffffffffc0219510 <initproc>
ffffffffc0203d4e:	6098                	ld	a4,0(s1)
ffffffffc0203d50:	12e78963          	beq	a5,a4,ffffffffc0203e82 <do_exit+0x160>
ffffffffc0203d54:	0287b903          	ld	s2,40(a5)
ffffffffc0203d58:	89aa                	mv	s3,a0
ffffffffc0203d5a:	02090663          	beqz	s2,ffffffffc0203d86 <do_exit+0x64>
ffffffffc0203d5e:	00016797          	auipc	a5,0x16
ffffffffc0203d62:	8e27b783          	ld	a5,-1822(a5) # ffffffffc0219640 <boot_cr3>
ffffffffc0203d66:	577d                	li	a4,-1
ffffffffc0203d68:	177e                	slli	a4,a4,0x3f
ffffffffc0203d6a:	83b1                	srli	a5,a5,0xc
ffffffffc0203d6c:	8fd9                	or	a5,a5,a4
ffffffffc0203d6e:	18079073          	csrw	satp,a5
ffffffffc0203d72:	03092783          	lw	a5,48(s2)
ffffffffc0203d76:	fff7871b          	addiw	a4,a5,-1
ffffffffc0203d7a:	02e92823          	sw	a4,48(s2)
ffffffffc0203d7e:	cb5d                	beqz	a4,ffffffffc0203e34 <do_exit+0x112>
ffffffffc0203d80:	601c                	ld	a5,0(s0)
ffffffffc0203d82:	0207b423          	sd	zero,40(a5)
ffffffffc0203d86:	601c                	ld	a5,0(s0)
ffffffffc0203d88:	470d                	li	a4,3
ffffffffc0203d8a:	c398                	sw	a4,0(a5)
ffffffffc0203d8c:	0f37a423          	sw	s3,232(a5)
ffffffffc0203d90:	100027f3          	csrr	a5,sstatus
ffffffffc0203d94:	8b89                	andi	a5,a5,2
ffffffffc0203d96:	4a01                	li	s4,0
ffffffffc0203d98:	10079163          	bnez	a5,ffffffffc0203e9a <do_exit+0x178>
ffffffffc0203d9c:	6018                	ld	a4,0(s0)
ffffffffc0203d9e:	800007b7          	lui	a5,0x80000
ffffffffc0203da2:	0785                	addi	a5,a5,1
ffffffffc0203da4:	7308                	ld	a0,32(a4)
ffffffffc0203da6:	0ec52703          	lw	a4,236(a0)
ffffffffc0203daa:	0ef70c63          	beq	a4,a5,ffffffffc0203ea2 <do_exit+0x180>
ffffffffc0203dae:	6018                	ld	a4,0(s0)
ffffffffc0203db0:	7b7c                	ld	a5,240(a4)
ffffffffc0203db2:	c3a1                	beqz	a5,ffffffffc0203df2 <do_exit+0xd0>
ffffffffc0203db4:	800009b7          	lui	s3,0x80000
ffffffffc0203db8:	490d                	li	s2,3
ffffffffc0203dba:	0985                	addi	s3,s3,1
ffffffffc0203dbc:	a021                	j	ffffffffc0203dc4 <do_exit+0xa2>
ffffffffc0203dbe:	6018                	ld	a4,0(s0)
ffffffffc0203dc0:	7b7c                	ld	a5,240(a4)
ffffffffc0203dc2:	cb85                	beqz	a5,ffffffffc0203df2 <do_exit+0xd0>
ffffffffc0203dc4:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <kern_entry-0x401fff00>
ffffffffc0203dc8:	6088                	ld	a0,0(s1)
ffffffffc0203dca:	fb74                	sd	a3,240(a4)
ffffffffc0203dcc:	7978                	ld	a4,240(a0)
ffffffffc0203dce:	0e07bc23          	sd	zero,248(a5)
ffffffffc0203dd2:	10e7b023          	sd	a4,256(a5)
ffffffffc0203dd6:	c311                	beqz	a4,ffffffffc0203dda <do_exit+0xb8>
ffffffffc0203dd8:	ff7c                	sd	a5,248(a4)
ffffffffc0203dda:	4398                	lw	a4,0(a5)
ffffffffc0203ddc:	f388                	sd	a0,32(a5)
ffffffffc0203dde:	f97c                	sd	a5,240(a0)
ffffffffc0203de0:	fd271fe3          	bne	a4,s2,ffffffffc0203dbe <do_exit+0x9c>
ffffffffc0203de4:	0ec52783          	lw	a5,236(a0)
ffffffffc0203de8:	fd379be3          	bne	a5,s3,ffffffffc0203dbe <do_exit+0x9c>
ffffffffc0203dec:	3ff000ef          	jal	ra,ffffffffc02049ea <wakeup_proc>
ffffffffc0203df0:	b7f9                	j	ffffffffc0203dbe <do_exit+0x9c>
ffffffffc0203df2:	020a1263          	bnez	s4,ffffffffc0203e16 <do_exit+0xf4>
ffffffffc0203df6:	4a7000ef          	jal	ra,ffffffffc0204a9c <schedule>
ffffffffc0203dfa:	601c                	ld	a5,0(s0)
ffffffffc0203dfc:	00005617          	auipc	a2,0x5
ffffffffc0203e00:	73c60613          	addi	a2,a2,1852 # ffffffffc0209538 <default_pmm_manager+0x318>
ffffffffc0203e04:	1f900593          	li	a1,505
ffffffffc0203e08:	43d4                	lw	a3,4(a5)
ffffffffc0203e0a:	00005517          	auipc	a0,0x5
ffffffffc0203e0e:	6f650513          	addi	a0,a0,1782 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0203e12:	bf6fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203e16:	81dfc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203e1a:	bff1                	j	ffffffffc0203df6 <do_exit+0xd4>
ffffffffc0203e1c:	00005617          	auipc	a2,0x5
ffffffffc0203e20:	6fc60613          	addi	a2,a2,1788 # ffffffffc0209518 <default_pmm_manager+0x2f8>
ffffffffc0203e24:	1cd00593          	li	a1,461
ffffffffc0203e28:	00005517          	auipc	a0,0x5
ffffffffc0203e2c:	6d850513          	addi	a0,a0,1752 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0203e30:	bd8fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203e34:	854a                	mv	a0,s2
ffffffffc0203e36:	a16fd0ef          	jal	ra,ffffffffc020104c <exit_mmap>
ffffffffc0203e3a:	01893683          	ld	a3,24(s2)
ffffffffc0203e3e:	c02007b7          	lui	a5,0xc0200
ffffffffc0203e42:	06f6e363          	bltu	a3,a5,ffffffffc0203ea8 <do_exit+0x186>
ffffffffc0203e46:	00015797          	auipc	a5,0x15
ffffffffc0203e4a:	7f27b783          	ld	a5,2034(a5) # ffffffffc0219638 <va_pa_offset>
ffffffffc0203e4e:	8e9d                	sub	a3,a3,a5
ffffffffc0203e50:	82b1                	srli	a3,a3,0xc
ffffffffc0203e52:	00015797          	auipc	a5,0x15
ffffffffc0203e56:	69e7b783          	ld	a5,1694(a5) # ffffffffc02194f0 <npage>
ffffffffc0203e5a:	06f6f363          	bgeu	a3,a5,ffffffffc0203ec0 <do_exit+0x19e>
ffffffffc0203e5e:	00006517          	auipc	a0,0x6
ffffffffc0203e62:	74253503          	ld	a0,1858(a0) # ffffffffc020a5a0 <nbase>
ffffffffc0203e66:	8e89                	sub	a3,a3,a0
ffffffffc0203e68:	069a                	slli	a3,a3,0x6
ffffffffc0203e6a:	00015517          	auipc	a0,0x15
ffffffffc0203e6e:	7de53503          	ld	a0,2014(a0) # ffffffffc0219648 <pages>
ffffffffc0203e72:	9536                	add	a0,a0,a3
ffffffffc0203e74:	4585                	li	a1,1
ffffffffc0203e76:	8fbfe0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0203e7a:	854a                	mv	a0,s2
ffffffffc0203e7c:	834fd0ef          	jal	ra,ffffffffc0200eb0 <mm_destroy>
ffffffffc0203e80:	b701                	j	ffffffffc0203d80 <do_exit+0x5e>
ffffffffc0203e82:	00005617          	auipc	a2,0x5
ffffffffc0203e86:	6a660613          	addi	a2,a2,1702 # ffffffffc0209528 <default_pmm_manager+0x308>
ffffffffc0203e8a:	1d000593          	li	a1,464
ffffffffc0203e8e:	00005517          	auipc	a0,0x5
ffffffffc0203e92:	67250513          	addi	a0,a0,1650 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0203e96:	b72fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203e9a:	f9efc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203e9e:	4a05                	li	s4,1
ffffffffc0203ea0:	bdf5                	j	ffffffffc0203d9c <do_exit+0x7a>
ffffffffc0203ea2:	349000ef          	jal	ra,ffffffffc02049ea <wakeup_proc>
ffffffffc0203ea6:	b721                	j	ffffffffc0203dae <do_exit+0x8c>
ffffffffc0203ea8:	00005617          	auipc	a2,0x5
ffffffffc0203eac:	e5060613          	addi	a2,a2,-432 # ffffffffc0208cf8 <commands+0xb08>
ffffffffc0203eb0:	06e00593          	li	a1,110
ffffffffc0203eb4:	00005517          	auipc	a0,0x5
ffffffffc0203eb8:	dfc50513          	addi	a0,a0,-516 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc0203ebc:	b4cfc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203ec0:	00005617          	auipc	a2,0x5
ffffffffc0203ec4:	e6060613          	addi	a2,a2,-416 # ffffffffc0208d20 <commands+0xb30>
ffffffffc0203ec8:	06200593          	li	a1,98
ffffffffc0203ecc:	00005517          	auipc	a0,0x5
ffffffffc0203ed0:	de450513          	addi	a0,a0,-540 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc0203ed4:	b34fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203ed8 <do_wait.part.0>:
ffffffffc0203ed8:	7139                	addi	sp,sp,-64
ffffffffc0203eda:	e852                	sd	s4,16(sp)
ffffffffc0203edc:	80000a37          	lui	s4,0x80000
ffffffffc0203ee0:	f426                	sd	s1,40(sp)
ffffffffc0203ee2:	f04a                	sd	s2,32(sp)
ffffffffc0203ee4:	ec4e                	sd	s3,24(sp)
ffffffffc0203ee6:	e456                	sd	s5,8(sp)
ffffffffc0203ee8:	e05a                	sd	s6,0(sp)
ffffffffc0203eea:	fc06                	sd	ra,56(sp)
ffffffffc0203eec:	f822                	sd	s0,48(sp)
ffffffffc0203eee:	892a                	mv	s2,a0
ffffffffc0203ef0:	8aae                	mv	s5,a1
ffffffffc0203ef2:	00015997          	auipc	s3,0x15
ffffffffc0203ef6:	60e98993          	addi	s3,s3,1550 # ffffffffc0219500 <current>
ffffffffc0203efa:	448d                	li	s1,3
ffffffffc0203efc:	4b05                	li	s6,1
ffffffffc0203efe:	2a05                	addiw	s4,s4,1
ffffffffc0203f00:	02090f63          	beqz	s2,ffffffffc0203f3e <do_wait.part.0+0x66>
ffffffffc0203f04:	854a                	mv	a0,s2
ffffffffc0203f06:	9a3ff0ef          	jal	ra,ffffffffc02038a8 <find_proc>
ffffffffc0203f0a:	842a                	mv	s0,a0
ffffffffc0203f0c:	10050763          	beqz	a0,ffffffffc020401a <do_wait.part.0+0x142>
ffffffffc0203f10:	0009b703          	ld	a4,0(s3)
ffffffffc0203f14:	711c                	ld	a5,32(a0)
ffffffffc0203f16:	10e79263          	bne	a5,a4,ffffffffc020401a <do_wait.part.0+0x142>
ffffffffc0203f1a:	411c                	lw	a5,0(a0)
ffffffffc0203f1c:	02978c63          	beq	a5,s1,ffffffffc0203f54 <do_wait.part.0+0x7c>
ffffffffc0203f20:	01672023          	sw	s6,0(a4)
ffffffffc0203f24:	0f472623          	sw	s4,236(a4)
ffffffffc0203f28:	375000ef          	jal	ra,ffffffffc0204a9c <schedule>
ffffffffc0203f2c:	0009b783          	ld	a5,0(s3)
ffffffffc0203f30:	0b07a783          	lw	a5,176(a5)
ffffffffc0203f34:	8b85                	andi	a5,a5,1
ffffffffc0203f36:	d7e9                	beqz	a5,ffffffffc0203f00 <do_wait.part.0+0x28>
ffffffffc0203f38:	555d                	li	a0,-9
ffffffffc0203f3a:	de9ff0ef          	jal	ra,ffffffffc0203d22 <do_exit>
ffffffffc0203f3e:	0009b703          	ld	a4,0(s3)
ffffffffc0203f42:	7b60                	ld	s0,240(a4)
ffffffffc0203f44:	e409                	bnez	s0,ffffffffc0203f4e <do_wait.part.0+0x76>
ffffffffc0203f46:	a8d1                	j	ffffffffc020401a <do_wait.part.0+0x142>
ffffffffc0203f48:	10043403          	ld	s0,256(s0)
ffffffffc0203f4c:	d871                	beqz	s0,ffffffffc0203f20 <do_wait.part.0+0x48>
ffffffffc0203f4e:	401c                	lw	a5,0(s0)
ffffffffc0203f50:	fe979ce3          	bne	a5,s1,ffffffffc0203f48 <do_wait.part.0+0x70>
ffffffffc0203f54:	00015797          	auipc	a5,0x15
ffffffffc0203f58:	5b47b783          	ld	a5,1460(a5) # ffffffffc0219508 <idleproc>
ffffffffc0203f5c:	0c878563          	beq	a5,s0,ffffffffc0204026 <do_wait.part.0+0x14e>
ffffffffc0203f60:	00015797          	auipc	a5,0x15
ffffffffc0203f64:	5b07b783          	ld	a5,1456(a5) # ffffffffc0219510 <initproc>
ffffffffc0203f68:	0af40f63          	beq	s0,a5,ffffffffc0204026 <do_wait.part.0+0x14e>
ffffffffc0203f6c:	000a8663          	beqz	s5,ffffffffc0203f78 <do_wait.part.0+0xa0>
ffffffffc0203f70:	0e842783          	lw	a5,232(s0)
ffffffffc0203f74:	00faa023          	sw	a5,0(s5)
ffffffffc0203f78:	100027f3          	csrr	a5,sstatus
ffffffffc0203f7c:	8b89                	andi	a5,a5,2
ffffffffc0203f7e:	4581                	li	a1,0
ffffffffc0203f80:	efd9                	bnez	a5,ffffffffc020401e <do_wait.part.0+0x146>
ffffffffc0203f82:	6c70                	ld	a2,216(s0)
ffffffffc0203f84:	7074                	ld	a3,224(s0)
ffffffffc0203f86:	10043703          	ld	a4,256(s0)
ffffffffc0203f8a:	7c7c                	ld	a5,248(s0)
ffffffffc0203f8c:	e614                	sd	a3,8(a2)
ffffffffc0203f8e:	e290                	sd	a2,0(a3)
ffffffffc0203f90:	6470                	ld	a2,200(s0)
ffffffffc0203f92:	6874                	ld	a3,208(s0)
ffffffffc0203f94:	e614                	sd	a3,8(a2)
ffffffffc0203f96:	e290                	sd	a2,0(a3)
ffffffffc0203f98:	c319                	beqz	a4,ffffffffc0203f9e <do_wait.part.0+0xc6>
ffffffffc0203f9a:	ff7c                	sd	a5,248(a4)
ffffffffc0203f9c:	7c7c                	ld	a5,248(s0)
ffffffffc0203f9e:	cbbd                	beqz	a5,ffffffffc0204014 <do_wait.part.0+0x13c>
ffffffffc0203fa0:	10e7b023          	sd	a4,256(a5)
ffffffffc0203fa4:	00015717          	auipc	a4,0x15
ffffffffc0203fa8:	57470713          	addi	a4,a4,1396 # ffffffffc0219518 <nr_process>
ffffffffc0203fac:	431c                	lw	a5,0(a4)
ffffffffc0203fae:	37fd                	addiw	a5,a5,-1
ffffffffc0203fb0:	c31c                	sw	a5,0(a4)
ffffffffc0203fb2:	edb1                	bnez	a1,ffffffffc020400e <do_wait.part.0+0x136>
ffffffffc0203fb4:	6814                	ld	a3,16(s0)
ffffffffc0203fb6:	c02007b7          	lui	a5,0xc0200
ffffffffc0203fba:	08f6ee63          	bltu	a3,a5,ffffffffc0204056 <do_wait.part.0+0x17e>
ffffffffc0203fbe:	00015797          	auipc	a5,0x15
ffffffffc0203fc2:	67a7b783          	ld	a5,1658(a5) # ffffffffc0219638 <va_pa_offset>
ffffffffc0203fc6:	8e9d                	sub	a3,a3,a5
ffffffffc0203fc8:	82b1                	srli	a3,a3,0xc
ffffffffc0203fca:	00015797          	auipc	a5,0x15
ffffffffc0203fce:	5267b783          	ld	a5,1318(a5) # ffffffffc02194f0 <npage>
ffffffffc0203fd2:	06f6f663          	bgeu	a3,a5,ffffffffc020403e <do_wait.part.0+0x166>
ffffffffc0203fd6:	00006517          	auipc	a0,0x6
ffffffffc0203fda:	5ca53503          	ld	a0,1482(a0) # ffffffffc020a5a0 <nbase>
ffffffffc0203fde:	8e89                	sub	a3,a3,a0
ffffffffc0203fe0:	069a                	slli	a3,a3,0x6
ffffffffc0203fe2:	00015517          	auipc	a0,0x15
ffffffffc0203fe6:	66653503          	ld	a0,1638(a0) # ffffffffc0219648 <pages>
ffffffffc0203fea:	9536                	add	a0,a0,a3
ffffffffc0203fec:	4589                	li	a1,2
ffffffffc0203fee:	f82fe0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc0203ff2:	8522                	mv	a0,s0
ffffffffc0203ff4:	905fd0ef          	jal	ra,ffffffffc02018f8 <kfree>
ffffffffc0203ff8:	4501                	li	a0,0
ffffffffc0203ffa:	70e2                	ld	ra,56(sp)
ffffffffc0203ffc:	7442                	ld	s0,48(sp)
ffffffffc0203ffe:	74a2                	ld	s1,40(sp)
ffffffffc0204000:	7902                	ld	s2,32(sp)
ffffffffc0204002:	69e2                	ld	s3,24(sp)
ffffffffc0204004:	6a42                	ld	s4,16(sp)
ffffffffc0204006:	6aa2                	ld	s5,8(sp)
ffffffffc0204008:	6b02                	ld	s6,0(sp)
ffffffffc020400a:	6121                	addi	sp,sp,64
ffffffffc020400c:	8082                	ret
ffffffffc020400e:	e24fc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0204012:	b74d                	j	ffffffffc0203fb4 <do_wait.part.0+0xdc>
ffffffffc0204014:	701c                	ld	a5,32(s0)
ffffffffc0204016:	fbf8                	sd	a4,240(a5)
ffffffffc0204018:	b771                	j	ffffffffc0203fa4 <do_wait.part.0+0xcc>
ffffffffc020401a:	5579                	li	a0,-2
ffffffffc020401c:	bff9                	j	ffffffffc0203ffa <do_wait.part.0+0x122>
ffffffffc020401e:	e1afc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204022:	4585                	li	a1,1
ffffffffc0204024:	bfb9                	j	ffffffffc0203f82 <do_wait.part.0+0xaa>
ffffffffc0204026:	00005617          	auipc	a2,0x5
ffffffffc020402a:	53260613          	addi	a2,a2,1330 # ffffffffc0209558 <default_pmm_manager+0x338>
ffffffffc020402e:	2f600593          	li	a1,758
ffffffffc0204032:	00005517          	auipc	a0,0x5
ffffffffc0204036:	4ce50513          	addi	a0,a0,1230 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc020403a:	9cefc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020403e:	00005617          	auipc	a2,0x5
ffffffffc0204042:	ce260613          	addi	a2,a2,-798 # ffffffffc0208d20 <commands+0xb30>
ffffffffc0204046:	06200593          	li	a1,98
ffffffffc020404a:	00005517          	auipc	a0,0x5
ffffffffc020404e:	c6650513          	addi	a0,a0,-922 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc0204052:	9b6fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204056:	00005617          	auipc	a2,0x5
ffffffffc020405a:	ca260613          	addi	a2,a2,-862 # ffffffffc0208cf8 <commands+0xb08>
ffffffffc020405e:	06e00593          	li	a1,110
ffffffffc0204062:	00005517          	auipc	a0,0x5
ffffffffc0204066:	c4e50513          	addi	a0,a0,-946 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc020406a:	99efc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020406e <init_main>:
ffffffffc020406e:	1141                	addi	sp,sp,-16
ffffffffc0204070:	e406                	sd	ra,8(sp)
ffffffffc0204072:	f40fe0ef          	jal	ra,ffffffffc02027b2 <nr_free_pages>
ffffffffc0204076:	fcefd0ef          	jal	ra,ffffffffc0201844 <kallocated>
ffffffffc020407a:	bbaff0ef          	jal	ra,ffffffffc0203434 <check_exercise>
ffffffffc020407e:	a019                	j	ffffffffc0204084 <init_main+0x16>
ffffffffc0204080:	21d000ef          	jal	ra,ffffffffc0204a9c <schedule>
ffffffffc0204084:	4581                	li	a1,0
ffffffffc0204086:	4501                	li	a0,0
ffffffffc0204088:	e51ff0ef          	jal	ra,ffffffffc0203ed8 <do_wait.part.0>
ffffffffc020408c:	d975                	beqz	a0,ffffffffc0204080 <init_main+0x12>
ffffffffc020408e:	00005517          	auipc	a0,0x5
ffffffffc0204092:	4ea50513          	addi	a0,a0,1258 # ffffffffc0209578 <default_pmm_manager+0x358>
ffffffffc0204096:	836fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020409a:	00015797          	auipc	a5,0x15
ffffffffc020409e:	4767b783          	ld	a5,1142(a5) # ffffffffc0219510 <initproc>
ffffffffc02040a2:	7bf8                	ld	a4,240(a5)
ffffffffc02040a4:	e339                	bnez	a4,ffffffffc02040ea <init_main+0x7c>
ffffffffc02040a6:	7ff8                	ld	a4,248(a5)
ffffffffc02040a8:	e329                	bnez	a4,ffffffffc02040ea <init_main+0x7c>
ffffffffc02040aa:	1007b703          	ld	a4,256(a5)
ffffffffc02040ae:	ef15                	bnez	a4,ffffffffc02040ea <init_main+0x7c>
ffffffffc02040b0:	00015697          	auipc	a3,0x15
ffffffffc02040b4:	4686a683          	lw	a3,1128(a3) # ffffffffc0219518 <nr_process>
ffffffffc02040b8:	4709                	li	a4,2
ffffffffc02040ba:	08e69863          	bne	a3,a4,ffffffffc020414a <init_main+0xdc>
ffffffffc02040be:	00015717          	auipc	a4,0x15
ffffffffc02040c2:	60a70713          	addi	a4,a4,1546 # ffffffffc02196c8 <proc_list>
ffffffffc02040c6:	6714                	ld	a3,8(a4)
ffffffffc02040c8:	0c878793          	addi	a5,a5,200
ffffffffc02040cc:	04d79f63          	bne	a5,a3,ffffffffc020412a <init_main+0xbc>
ffffffffc02040d0:	6318                	ld	a4,0(a4)
ffffffffc02040d2:	02e79c63          	bne	a5,a4,ffffffffc020410a <init_main+0x9c>
ffffffffc02040d6:	00005517          	auipc	a0,0x5
ffffffffc02040da:	58a50513          	addi	a0,a0,1418 # ffffffffc0209660 <default_pmm_manager+0x440>
ffffffffc02040de:	feffb0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02040e2:	60a2                	ld	ra,8(sp)
ffffffffc02040e4:	4501                	li	a0,0
ffffffffc02040e6:	0141                	addi	sp,sp,16
ffffffffc02040e8:	8082                	ret
ffffffffc02040ea:	00005697          	auipc	a3,0x5
ffffffffc02040ee:	4b668693          	addi	a3,a3,1206 # ffffffffc02095a0 <default_pmm_manager+0x380>
ffffffffc02040f2:	00004617          	auipc	a2,0x4
ffffffffc02040f6:	50e60613          	addi	a2,a2,1294 # ffffffffc0208600 <commands+0x410>
ffffffffc02040fa:	36200593          	li	a1,866
ffffffffc02040fe:	00005517          	auipc	a0,0x5
ffffffffc0204102:	40250513          	addi	a0,a0,1026 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0204106:	902fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020410a:	00005697          	auipc	a3,0x5
ffffffffc020410e:	52668693          	addi	a3,a3,1318 # ffffffffc0209630 <default_pmm_manager+0x410>
ffffffffc0204112:	00004617          	auipc	a2,0x4
ffffffffc0204116:	4ee60613          	addi	a2,a2,1262 # ffffffffc0208600 <commands+0x410>
ffffffffc020411a:	36500593          	li	a1,869
ffffffffc020411e:	00005517          	auipc	a0,0x5
ffffffffc0204122:	3e250513          	addi	a0,a0,994 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0204126:	8e2fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020412a:	00005697          	auipc	a3,0x5
ffffffffc020412e:	4d668693          	addi	a3,a3,1238 # ffffffffc0209600 <default_pmm_manager+0x3e0>
ffffffffc0204132:	00004617          	auipc	a2,0x4
ffffffffc0204136:	4ce60613          	addi	a2,a2,1230 # ffffffffc0208600 <commands+0x410>
ffffffffc020413a:	36400593          	li	a1,868
ffffffffc020413e:	00005517          	auipc	a0,0x5
ffffffffc0204142:	3c250513          	addi	a0,a0,962 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0204146:	8c2fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020414a:	00005697          	auipc	a3,0x5
ffffffffc020414e:	4a668693          	addi	a3,a3,1190 # ffffffffc02095f0 <default_pmm_manager+0x3d0>
ffffffffc0204152:	00004617          	auipc	a2,0x4
ffffffffc0204156:	4ae60613          	addi	a2,a2,1198 # ffffffffc0208600 <commands+0x410>
ffffffffc020415a:	36300593          	li	a1,867
ffffffffc020415e:	00005517          	auipc	a0,0x5
ffffffffc0204162:	3a250513          	addi	a0,a0,930 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0204166:	8a2fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020416a <do_execve>:
ffffffffc020416a:	7135                	addi	sp,sp,-160
ffffffffc020416c:	f4d6                	sd	s5,104(sp)
ffffffffc020416e:	00015a97          	auipc	s5,0x15
ffffffffc0204172:	392a8a93          	addi	s5,s5,914 # ffffffffc0219500 <current>
ffffffffc0204176:	000ab783          	ld	a5,0(s5)
ffffffffc020417a:	f8d2                	sd	s4,112(sp)
ffffffffc020417c:	e526                	sd	s1,136(sp)
ffffffffc020417e:	0287ba03          	ld	s4,40(a5)
ffffffffc0204182:	e14a                	sd	s2,128(sp)
ffffffffc0204184:	fcce                	sd	s3,120(sp)
ffffffffc0204186:	892a                	mv	s2,a0
ffffffffc0204188:	84ae                	mv	s1,a1
ffffffffc020418a:	89b2                	mv	s3,a2
ffffffffc020418c:	4681                	li	a3,0
ffffffffc020418e:	862e                	mv	a2,a1
ffffffffc0204190:	85aa                	mv	a1,a0
ffffffffc0204192:	8552                	mv	a0,s4
ffffffffc0204194:	ed06                	sd	ra,152(sp)
ffffffffc0204196:	e922                	sd	s0,144(sp)
ffffffffc0204198:	f0da                	sd	s6,96(sp)
ffffffffc020419a:	ecde                	sd	s7,88(sp)
ffffffffc020419c:	e8e2                	sd	s8,80(sp)
ffffffffc020419e:	e4e6                	sd	s9,72(sp)
ffffffffc02041a0:	e0ea                	sd	s10,64(sp)
ffffffffc02041a2:	fc6e                	sd	s11,56(sp)
ffffffffc02041a4:	822fd0ef          	jal	ra,ffffffffc02011c6 <user_mem_check>
ffffffffc02041a8:	46050063          	beqz	a0,ffffffffc0204608 <do_execve+0x49e>
ffffffffc02041ac:	4641                	li	a2,16
ffffffffc02041ae:	4581                	li	a1,0
ffffffffc02041b0:	1008                	addi	a0,sp,32
ffffffffc02041b2:	171030ef          	jal	ra,ffffffffc0207b22 <memset>
ffffffffc02041b6:	47bd                	li	a5,15
ffffffffc02041b8:	8626                	mv	a2,s1
ffffffffc02041ba:	1897ea63          	bltu	a5,s1,ffffffffc020434e <do_execve+0x1e4>
ffffffffc02041be:	85ca                	mv	a1,s2
ffffffffc02041c0:	1008                	addi	a0,sp,32
ffffffffc02041c2:	173030ef          	jal	ra,ffffffffc0207b34 <memcpy>
ffffffffc02041c6:	180a0b63          	beqz	s4,ffffffffc020435c <do_execve+0x1f2>
ffffffffc02041ca:	00004517          	auipc	a0,0x4
ffffffffc02041ce:	7ce50513          	addi	a0,a0,1998 # ffffffffc0208998 <commands+0x7a8>
ffffffffc02041d2:	f33fb0ef          	jal	ra,ffffffffc0200104 <cputs>
ffffffffc02041d6:	00015797          	auipc	a5,0x15
ffffffffc02041da:	46a7b783          	ld	a5,1130(a5) # ffffffffc0219640 <boot_cr3>
ffffffffc02041de:	577d                	li	a4,-1
ffffffffc02041e0:	177e                	slli	a4,a4,0x3f
ffffffffc02041e2:	83b1                	srli	a5,a5,0xc
ffffffffc02041e4:	8fd9                	or	a5,a5,a4
ffffffffc02041e6:	18079073          	csrw	satp,a5
ffffffffc02041ea:	030a2783          	lw	a5,48(s4) # ffffffff80000030 <kern_entry-0x401fffd0>
ffffffffc02041ee:	fff7871b          	addiw	a4,a5,-1
ffffffffc02041f2:	02ea2823          	sw	a4,48(s4)
ffffffffc02041f6:	2c070163          	beqz	a4,ffffffffc02044b8 <do_execve+0x34e>
ffffffffc02041fa:	000ab783          	ld	a5,0(s5)
ffffffffc02041fe:	0207b423          	sd	zero,40(a5)
ffffffffc0204202:	b51fc0ef          	jal	ra,ffffffffc0200d52 <mm_create>
ffffffffc0204206:	84aa                	mv	s1,a0
ffffffffc0204208:	18050263          	beqz	a0,ffffffffc020438c <do_execve+0x222>
ffffffffc020420c:	0561                	addi	a0,a0,24
ffffffffc020420e:	d82ff0ef          	jal	ra,ffffffffc0203790 <setup_pgdir.isra.0>
ffffffffc0204212:	16051663          	bnez	a0,ffffffffc020437e <do_execve+0x214>
ffffffffc0204216:	0009a703          	lw	a4,0(s3)
ffffffffc020421a:	464c47b7          	lui	a5,0x464c4
ffffffffc020421e:	57f78793          	addi	a5,a5,1407 # 464c457f <kern_entry-0xffffffff79d3ba81>
ffffffffc0204222:	24f71763          	bne	a4,a5,ffffffffc0204470 <do_execve+0x306>
ffffffffc0204226:	0389d703          	lhu	a4,56(s3)
ffffffffc020422a:	0209b903          	ld	s2,32(s3)
ffffffffc020422e:	00371793          	slli	a5,a4,0x3
ffffffffc0204232:	8f99                	sub	a5,a5,a4
ffffffffc0204234:	994e                	add	s2,s2,s3
ffffffffc0204236:	078e                	slli	a5,a5,0x3
ffffffffc0204238:	97ca                	add	a5,a5,s2
ffffffffc020423a:	ec3e                	sd	a5,24(sp)
ffffffffc020423c:	02f97c63          	bgeu	s2,a5,ffffffffc0204274 <do_execve+0x10a>
ffffffffc0204240:	5bfd                	li	s7,-1
ffffffffc0204242:	00cbd793          	srli	a5,s7,0xc
ffffffffc0204246:	00015d97          	auipc	s11,0x15
ffffffffc020424a:	402d8d93          	addi	s11,s11,1026 # ffffffffc0219648 <pages>
ffffffffc020424e:	00006d17          	auipc	s10,0x6
ffffffffc0204252:	352d0d13          	addi	s10,s10,850 # ffffffffc020a5a0 <nbase>
ffffffffc0204256:	e43e                	sd	a5,8(sp)
ffffffffc0204258:	00015c97          	auipc	s9,0x15
ffffffffc020425c:	298c8c93          	addi	s9,s9,664 # ffffffffc02194f0 <npage>
ffffffffc0204260:	00092703          	lw	a4,0(s2)
ffffffffc0204264:	4785                	li	a5,1
ffffffffc0204266:	12f70563          	beq	a4,a5,ffffffffc0204390 <do_execve+0x226>
ffffffffc020426a:	67e2                	ld	a5,24(sp)
ffffffffc020426c:	03890913          	addi	s2,s2,56
ffffffffc0204270:	fef968e3          	bltu	s2,a5,ffffffffc0204260 <do_execve+0xf6>
ffffffffc0204274:	4701                	li	a4,0
ffffffffc0204276:	46ad                	li	a3,11
ffffffffc0204278:	00100637          	lui	a2,0x100
ffffffffc020427c:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0204280:	8526                	mv	a0,s1
ffffffffc0204282:	c81fc0ef          	jal	ra,ffffffffc0200f02 <mm_map>
ffffffffc0204286:	8a2a                	mv	s4,a0
ffffffffc0204288:	1e051063          	bnez	a0,ffffffffc0204468 <do_execve+0x2fe>
ffffffffc020428c:	6c88                	ld	a0,24(s1)
ffffffffc020428e:	467d                	li	a2,31
ffffffffc0204290:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0204294:	d87fe0ef          	jal	ra,ffffffffc020301a <pgdir_alloc_page>
ffffffffc0204298:	42050e63          	beqz	a0,ffffffffc02046d4 <do_execve+0x56a>
ffffffffc020429c:	6c88                	ld	a0,24(s1)
ffffffffc020429e:	467d                	li	a2,31
ffffffffc02042a0:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc02042a4:	d77fe0ef          	jal	ra,ffffffffc020301a <pgdir_alloc_page>
ffffffffc02042a8:	40050663          	beqz	a0,ffffffffc02046b4 <do_execve+0x54a>
ffffffffc02042ac:	6c88                	ld	a0,24(s1)
ffffffffc02042ae:	467d                	li	a2,31
ffffffffc02042b0:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc02042b4:	d67fe0ef          	jal	ra,ffffffffc020301a <pgdir_alloc_page>
ffffffffc02042b8:	3c050e63          	beqz	a0,ffffffffc0204694 <do_execve+0x52a>
ffffffffc02042bc:	6c88                	ld	a0,24(s1)
ffffffffc02042be:	467d                	li	a2,31
ffffffffc02042c0:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc02042c4:	d57fe0ef          	jal	ra,ffffffffc020301a <pgdir_alloc_page>
ffffffffc02042c8:	3a050663          	beqz	a0,ffffffffc0204674 <do_execve+0x50a>
ffffffffc02042cc:	589c                	lw	a5,48(s1)
ffffffffc02042ce:	000ab603          	ld	a2,0(s5)
ffffffffc02042d2:	6c94                	ld	a3,24(s1)
ffffffffc02042d4:	2785                	addiw	a5,a5,1
ffffffffc02042d6:	d89c                	sw	a5,48(s1)
ffffffffc02042d8:	f604                	sd	s1,40(a2)
ffffffffc02042da:	c02007b7          	lui	a5,0xc0200
ffffffffc02042de:	36f6ef63          	bltu	a3,a5,ffffffffc020465c <do_execve+0x4f2>
ffffffffc02042e2:	00015797          	auipc	a5,0x15
ffffffffc02042e6:	3567b783          	ld	a5,854(a5) # ffffffffc0219638 <va_pa_offset>
ffffffffc02042ea:	8e9d                	sub	a3,a3,a5
ffffffffc02042ec:	577d                	li	a4,-1
ffffffffc02042ee:	00c6d793          	srli	a5,a3,0xc
ffffffffc02042f2:	177e                	slli	a4,a4,0x3f
ffffffffc02042f4:	f654                	sd	a3,168(a2)
ffffffffc02042f6:	8fd9                	or	a5,a5,a4
ffffffffc02042f8:	18079073          	csrw	satp,a5
ffffffffc02042fc:	7240                	ld	s0,160(a2)
ffffffffc02042fe:	4581                	li	a1,0
ffffffffc0204300:	12000613          	li	a2,288
ffffffffc0204304:	8522                	mv	a0,s0
ffffffffc0204306:	10043483          	ld	s1,256(s0)
ffffffffc020430a:	019030ef          	jal	ra,ffffffffc0207b22 <memset>
ffffffffc020430e:	0189b703          	ld	a4,24(s3)
ffffffffc0204312:	4785                	li	a5,1
ffffffffc0204314:	000ab503          	ld	a0,0(s5)
ffffffffc0204318:	edf4f493          	andi	s1,s1,-289
ffffffffc020431c:	07fe                	slli	a5,a5,0x1f
ffffffffc020431e:	e81c                	sd	a5,16(s0)
ffffffffc0204320:	10e43423          	sd	a4,264(s0)
ffffffffc0204324:	10943023          	sd	s1,256(s0)
ffffffffc0204328:	100c                	addi	a1,sp,32
ffffffffc020432a:	ce8ff0ef          	jal	ra,ffffffffc0203812 <set_proc_name>
ffffffffc020432e:	60ea                	ld	ra,152(sp)
ffffffffc0204330:	644a                	ld	s0,144(sp)
ffffffffc0204332:	64aa                	ld	s1,136(sp)
ffffffffc0204334:	690a                	ld	s2,128(sp)
ffffffffc0204336:	79e6                	ld	s3,120(sp)
ffffffffc0204338:	7aa6                	ld	s5,104(sp)
ffffffffc020433a:	7b06                	ld	s6,96(sp)
ffffffffc020433c:	6be6                	ld	s7,88(sp)
ffffffffc020433e:	6c46                	ld	s8,80(sp)
ffffffffc0204340:	6ca6                	ld	s9,72(sp)
ffffffffc0204342:	6d06                	ld	s10,64(sp)
ffffffffc0204344:	7de2                	ld	s11,56(sp)
ffffffffc0204346:	8552                	mv	a0,s4
ffffffffc0204348:	7a46                	ld	s4,112(sp)
ffffffffc020434a:	610d                	addi	sp,sp,160
ffffffffc020434c:	8082                	ret
ffffffffc020434e:	463d                	li	a2,15
ffffffffc0204350:	85ca                	mv	a1,s2
ffffffffc0204352:	1008                	addi	a0,sp,32
ffffffffc0204354:	7e0030ef          	jal	ra,ffffffffc0207b34 <memcpy>
ffffffffc0204358:	e60a19e3          	bnez	s4,ffffffffc02041ca <do_execve+0x60>
ffffffffc020435c:	000ab783          	ld	a5,0(s5)
ffffffffc0204360:	779c                	ld	a5,40(a5)
ffffffffc0204362:	ea0780e3          	beqz	a5,ffffffffc0204202 <do_execve+0x98>
ffffffffc0204366:	00005617          	auipc	a2,0x5
ffffffffc020436a:	31a60613          	addi	a2,a2,794 # ffffffffc0209680 <default_pmm_manager+0x460>
ffffffffc020436e:	20300593          	li	a1,515
ffffffffc0204372:	00005517          	auipc	a0,0x5
ffffffffc0204376:	18e50513          	addi	a0,a0,398 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc020437a:	e8ffb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020437e:	8526                	mv	a0,s1
ffffffffc0204380:	b31fc0ef          	jal	ra,ffffffffc0200eb0 <mm_destroy>
ffffffffc0204384:	5a71                	li	s4,-4
ffffffffc0204386:	8552                	mv	a0,s4
ffffffffc0204388:	99bff0ef          	jal	ra,ffffffffc0203d22 <do_exit>
ffffffffc020438c:	5a71                	li	s4,-4
ffffffffc020438e:	bfe5                	j	ffffffffc0204386 <do_execve+0x21c>
ffffffffc0204390:	02893603          	ld	a2,40(s2)
ffffffffc0204394:	02093783          	ld	a5,32(s2)
ffffffffc0204398:	26f66c63          	bltu	a2,a5,ffffffffc0204610 <do_execve+0x4a6>
ffffffffc020439c:	00492783          	lw	a5,4(s2)
ffffffffc02043a0:	0017f693          	andi	a3,a5,1
ffffffffc02043a4:	c291                	beqz	a3,ffffffffc02043a8 <do_execve+0x23e>
ffffffffc02043a6:	4691                	li	a3,4
ffffffffc02043a8:	0027f713          	andi	a4,a5,2
ffffffffc02043ac:	8b91                	andi	a5,a5,4
ffffffffc02043ae:	14071c63          	bnez	a4,ffffffffc0204506 <do_execve+0x39c>
ffffffffc02043b2:	4745                	li	a4,17
ffffffffc02043b4:	e03a                	sd	a4,0(sp)
ffffffffc02043b6:	c789                	beqz	a5,ffffffffc02043c0 <do_execve+0x256>
ffffffffc02043b8:	47cd                	li	a5,19
ffffffffc02043ba:	0016e693          	ori	a3,a3,1
ffffffffc02043be:	e03e                	sd	a5,0(sp)
ffffffffc02043c0:	0026f793          	andi	a5,a3,2
ffffffffc02043c4:	14079563          	bnez	a5,ffffffffc020450e <do_execve+0x3a4>
ffffffffc02043c8:	0046f793          	andi	a5,a3,4
ffffffffc02043cc:	c789                	beqz	a5,ffffffffc02043d6 <do_execve+0x26c>
ffffffffc02043ce:	6782                	ld	a5,0(sp)
ffffffffc02043d0:	0087e793          	ori	a5,a5,8
ffffffffc02043d4:	e03e                	sd	a5,0(sp)
ffffffffc02043d6:	01093583          	ld	a1,16(s2)
ffffffffc02043da:	4701                	li	a4,0
ffffffffc02043dc:	8526                	mv	a0,s1
ffffffffc02043de:	b25fc0ef          	jal	ra,ffffffffc0200f02 <mm_map>
ffffffffc02043e2:	8a2a                	mv	s4,a0
ffffffffc02043e4:	e151                	bnez	a0,ffffffffc0204468 <do_execve+0x2fe>
ffffffffc02043e6:	01093c03          	ld	s8,16(s2)
ffffffffc02043ea:	02093a03          	ld	s4,32(s2)
ffffffffc02043ee:	00893b03          	ld	s6,8(s2)
ffffffffc02043f2:	77fd                	lui	a5,0xfffff
ffffffffc02043f4:	9a62                	add	s4,s4,s8
ffffffffc02043f6:	9b4e                	add	s6,s6,s3
ffffffffc02043f8:	00fc7bb3          	and	s7,s8,a5
ffffffffc02043fc:	054c6e63          	bltu	s8,s4,ffffffffc0204458 <do_execve+0x2ee>
ffffffffc0204400:	a431                	j	ffffffffc020460c <do_execve+0x4a2>
ffffffffc0204402:	6785                	lui	a5,0x1
ffffffffc0204404:	417c0533          	sub	a0,s8,s7
ffffffffc0204408:	9bbe                	add	s7,s7,a5
ffffffffc020440a:	418b8633          	sub	a2,s7,s8
ffffffffc020440e:	017a7463          	bgeu	s4,s7,ffffffffc0204416 <do_execve+0x2ac>
ffffffffc0204412:	418a0633          	sub	a2,s4,s8
ffffffffc0204416:	000db683          	ld	a3,0(s11)
ffffffffc020441a:	000d3803          	ld	a6,0(s10)
ffffffffc020441e:	67a2                	ld	a5,8(sp)
ffffffffc0204420:	40d406b3          	sub	a3,s0,a3
ffffffffc0204424:	8699                	srai	a3,a3,0x6
ffffffffc0204426:	000cb583          	ld	a1,0(s9)
ffffffffc020442a:	96c2                	add	a3,a3,a6
ffffffffc020442c:	00f6f833          	and	a6,a3,a5
ffffffffc0204430:	06b2                	slli	a3,a3,0xc
ffffffffc0204432:	1eb87163          	bgeu	a6,a1,ffffffffc0204614 <do_execve+0x4aa>
ffffffffc0204436:	00015797          	auipc	a5,0x15
ffffffffc020443a:	20278793          	addi	a5,a5,514 # ffffffffc0219638 <va_pa_offset>
ffffffffc020443e:	0007b803          	ld	a6,0(a5)
ffffffffc0204442:	85da                	mv	a1,s6
ffffffffc0204444:	9c32                	add	s8,s8,a2
ffffffffc0204446:	96c2                	add	a3,a3,a6
ffffffffc0204448:	9536                	add	a0,a0,a3
ffffffffc020444a:	e832                	sd	a2,16(sp)
ffffffffc020444c:	6e8030ef          	jal	ra,ffffffffc0207b34 <memcpy>
ffffffffc0204450:	6642                	ld	a2,16(sp)
ffffffffc0204452:	9b32                	add	s6,s6,a2
ffffffffc0204454:	0d4c7063          	bgeu	s8,s4,ffffffffc0204514 <do_execve+0x3aa>
ffffffffc0204458:	6c88                	ld	a0,24(s1)
ffffffffc020445a:	6602                	ld	a2,0(sp)
ffffffffc020445c:	85de                	mv	a1,s7
ffffffffc020445e:	bbdfe0ef          	jal	ra,ffffffffc020301a <pgdir_alloc_page>
ffffffffc0204462:	842a                	mv	s0,a0
ffffffffc0204464:	fd59                	bnez	a0,ffffffffc0204402 <do_execve+0x298>
ffffffffc0204466:	5a71                	li	s4,-4
ffffffffc0204468:	8526                	mv	a0,s1
ffffffffc020446a:	be3fc0ef          	jal	ra,ffffffffc020104c <exit_mmap>
ffffffffc020446e:	a011                	j	ffffffffc0204472 <do_execve+0x308>
ffffffffc0204470:	5a61                	li	s4,-8
ffffffffc0204472:	6c94                	ld	a3,24(s1)
ffffffffc0204474:	c02007b7          	lui	a5,0xc0200
ffffffffc0204478:	1af6ea63          	bltu	a3,a5,ffffffffc020462c <do_execve+0x4c2>
ffffffffc020447c:	00015517          	auipc	a0,0x15
ffffffffc0204480:	1bc53503          	ld	a0,444(a0) # ffffffffc0219638 <va_pa_offset>
ffffffffc0204484:	8e89                	sub	a3,a3,a0
ffffffffc0204486:	82b1                	srli	a3,a3,0xc
ffffffffc0204488:	00015797          	auipc	a5,0x15
ffffffffc020448c:	0687b783          	ld	a5,104(a5) # ffffffffc02194f0 <npage>
ffffffffc0204490:	1af6fa63          	bgeu	a3,a5,ffffffffc0204644 <do_execve+0x4da>
ffffffffc0204494:	00006517          	auipc	a0,0x6
ffffffffc0204498:	10c53503          	ld	a0,268(a0) # ffffffffc020a5a0 <nbase>
ffffffffc020449c:	8e89                	sub	a3,a3,a0
ffffffffc020449e:	069a                	slli	a3,a3,0x6
ffffffffc02044a0:	00015517          	auipc	a0,0x15
ffffffffc02044a4:	1a853503          	ld	a0,424(a0) # ffffffffc0219648 <pages>
ffffffffc02044a8:	9536                	add	a0,a0,a3
ffffffffc02044aa:	4585                	li	a1,1
ffffffffc02044ac:	ac4fe0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc02044b0:	8526                	mv	a0,s1
ffffffffc02044b2:	9fffc0ef          	jal	ra,ffffffffc0200eb0 <mm_destroy>
ffffffffc02044b6:	bdc1                	j	ffffffffc0204386 <do_execve+0x21c>
ffffffffc02044b8:	8552                	mv	a0,s4
ffffffffc02044ba:	b93fc0ef          	jal	ra,ffffffffc020104c <exit_mmap>
ffffffffc02044be:	018a3683          	ld	a3,24(s4)
ffffffffc02044c2:	c02007b7          	lui	a5,0xc0200
ffffffffc02044c6:	16f6e363          	bltu	a3,a5,ffffffffc020462c <do_execve+0x4c2>
ffffffffc02044ca:	00015797          	auipc	a5,0x15
ffffffffc02044ce:	16e7b783          	ld	a5,366(a5) # ffffffffc0219638 <va_pa_offset>
ffffffffc02044d2:	8e9d                	sub	a3,a3,a5
ffffffffc02044d4:	82b1                	srli	a3,a3,0xc
ffffffffc02044d6:	00015797          	auipc	a5,0x15
ffffffffc02044da:	01a7b783          	ld	a5,26(a5) # ffffffffc02194f0 <npage>
ffffffffc02044de:	16f6f363          	bgeu	a3,a5,ffffffffc0204644 <do_execve+0x4da>
ffffffffc02044e2:	00006517          	auipc	a0,0x6
ffffffffc02044e6:	0be53503          	ld	a0,190(a0) # ffffffffc020a5a0 <nbase>
ffffffffc02044ea:	8e89                	sub	a3,a3,a0
ffffffffc02044ec:	069a                	slli	a3,a3,0x6
ffffffffc02044ee:	00015517          	auipc	a0,0x15
ffffffffc02044f2:	15a53503          	ld	a0,346(a0) # ffffffffc0219648 <pages>
ffffffffc02044f6:	9536                	add	a0,a0,a3
ffffffffc02044f8:	4585                	li	a1,1
ffffffffc02044fa:	a76fe0ef          	jal	ra,ffffffffc0202770 <free_pages>
ffffffffc02044fe:	8552                	mv	a0,s4
ffffffffc0204500:	9b1fc0ef          	jal	ra,ffffffffc0200eb0 <mm_destroy>
ffffffffc0204504:	b9dd                	j	ffffffffc02041fa <do_execve+0x90>
ffffffffc0204506:	0026e693          	ori	a3,a3,2
ffffffffc020450a:	ea0797e3          	bnez	a5,ffffffffc02043b8 <do_execve+0x24e>
ffffffffc020450e:	47dd                	li	a5,23
ffffffffc0204510:	e03e                	sd	a5,0(sp)
ffffffffc0204512:	bd5d                	j	ffffffffc02043c8 <do_execve+0x25e>
ffffffffc0204514:	01093a03          	ld	s4,16(s2)
ffffffffc0204518:	02893683          	ld	a3,40(s2)
ffffffffc020451c:	9a36                	add	s4,s4,a3
ffffffffc020451e:	077c7f63          	bgeu	s8,s7,ffffffffc020459c <do_execve+0x432>
ffffffffc0204522:	d58a04e3          	beq	s4,s8,ffffffffc020426a <do_execve+0x100>
ffffffffc0204526:	6505                	lui	a0,0x1
ffffffffc0204528:	9562                	add	a0,a0,s8
ffffffffc020452a:	41750533          	sub	a0,a0,s7
ffffffffc020452e:	418a0b33          	sub	s6,s4,s8
ffffffffc0204532:	0d7a7863          	bgeu	s4,s7,ffffffffc0204602 <do_execve+0x498>
ffffffffc0204536:	000db683          	ld	a3,0(s11)
ffffffffc020453a:	000d3583          	ld	a1,0(s10)
ffffffffc020453e:	67a2                	ld	a5,8(sp)
ffffffffc0204540:	40d406b3          	sub	a3,s0,a3
ffffffffc0204544:	8699                	srai	a3,a3,0x6
ffffffffc0204546:	000cb603          	ld	a2,0(s9)
ffffffffc020454a:	96ae                	add	a3,a3,a1
ffffffffc020454c:	00f6f5b3          	and	a1,a3,a5
ffffffffc0204550:	06b2                	slli	a3,a3,0xc
ffffffffc0204552:	0cc5f163          	bgeu	a1,a2,ffffffffc0204614 <do_execve+0x4aa>
ffffffffc0204556:	00015617          	auipc	a2,0x15
ffffffffc020455a:	0e263603          	ld	a2,226(a2) # ffffffffc0219638 <va_pa_offset>
ffffffffc020455e:	96b2                	add	a3,a3,a2
ffffffffc0204560:	4581                	li	a1,0
ffffffffc0204562:	865a                	mv	a2,s6
ffffffffc0204564:	9536                	add	a0,a0,a3
ffffffffc0204566:	5bc030ef          	jal	ra,ffffffffc0207b22 <memset>
ffffffffc020456a:	018b0733          	add	a4,s6,s8
ffffffffc020456e:	037a7463          	bgeu	s4,s7,ffffffffc0204596 <do_execve+0x42c>
ffffffffc0204572:	ceea0ce3          	beq	s4,a4,ffffffffc020426a <do_execve+0x100>
ffffffffc0204576:	00005697          	auipc	a3,0x5
ffffffffc020457a:	13268693          	addi	a3,a3,306 # ffffffffc02096a8 <default_pmm_manager+0x488>
ffffffffc020457e:	00004617          	auipc	a2,0x4
ffffffffc0204582:	08260613          	addi	a2,a2,130 # ffffffffc0208600 <commands+0x410>
ffffffffc0204586:	25800593          	li	a1,600
ffffffffc020458a:	00005517          	auipc	a0,0x5
ffffffffc020458e:	f7650513          	addi	a0,a0,-138 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0204592:	c77fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204596:	ff7710e3          	bne	a4,s7,ffffffffc0204576 <do_execve+0x40c>
ffffffffc020459a:	8c5e                	mv	s8,s7
ffffffffc020459c:	00015b17          	auipc	s6,0x15
ffffffffc02045a0:	09cb0b13          	addi	s6,s6,156 # ffffffffc0219638 <va_pa_offset>
ffffffffc02045a4:	054c6763          	bltu	s8,s4,ffffffffc02045f2 <do_execve+0x488>
ffffffffc02045a8:	b1c9                	j	ffffffffc020426a <do_execve+0x100>
ffffffffc02045aa:	6785                	lui	a5,0x1
ffffffffc02045ac:	417c0533          	sub	a0,s8,s7
ffffffffc02045b0:	9bbe                	add	s7,s7,a5
ffffffffc02045b2:	418b8633          	sub	a2,s7,s8
ffffffffc02045b6:	017a7463          	bgeu	s4,s7,ffffffffc02045be <do_execve+0x454>
ffffffffc02045ba:	418a0633          	sub	a2,s4,s8
ffffffffc02045be:	000db683          	ld	a3,0(s11)
ffffffffc02045c2:	000d3803          	ld	a6,0(s10)
ffffffffc02045c6:	67a2                	ld	a5,8(sp)
ffffffffc02045c8:	40d406b3          	sub	a3,s0,a3
ffffffffc02045cc:	8699                	srai	a3,a3,0x6
ffffffffc02045ce:	000cb583          	ld	a1,0(s9)
ffffffffc02045d2:	96c2                	add	a3,a3,a6
ffffffffc02045d4:	00f6f833          	and	a6,a3,a5
ffffffffc02045d8:	06b2                	slli	a3,a3,0xc
ffffffffc02045da:	02b87d63          	bgeu	a6,a1,ffffffffc0204614 <do_execve+0x4aa>
ffffffffc02045de:	000b3803          	ld	a6,0(s6)
ffffffffc02045e2:	9c32                	add	s8,s8,a2
ffffffffc02045e4:	4581                	li	a1,0
ffffffffc02045e6:	96c2                	add	a3,a3,a6
ffffffffc02045e8:	9536                	add	a0,a0,a3
ffffffffc02045ea:	538030ef          	jal	ra,ffffffffc0207b22 <memset>
ffffffffc02045ee:	c74c7ee3          	bgeu	s8,s4,ffffffffc020426a <do_execve+0x100>
ffffffffc02045f2:	6c88                	ld	a0,24(s1)
ffffffffc02045f4:	6602                	ld	a2,0(sp)
ffffffffc02045f6:	85de                	mv	a1,s7
ffffffffc02045f8:	a23fe0ef          	jal	ra,ffffffffc020301a <pgdir_alloc_page>
ffffffffc02045fc:	842a                	mv	s0,a0
ffffffffc02045fe:	f555                	bnez	a0,ffffffffc02045aa <do_execve+0x440>
ffffffffc0204600:	b59d                	j	ffffffffc0204466 <do_execve+0x2fc>
ffffffffc0204602:	418b8b33          	sub	s6,s7,s8
ffffffffc0204606:	bf05                	j	ffffffffc0204536 <do_execve+0x3cc>
ffffffffc0204608:	5a75                	li	s4,-3
ffffffffc020460a:	b315                	j	ffffffffc020432e <do_execve+0x1c4>
ffffffffc020460c:	8a62                	mv	s4,s8
ffffffffc020460e:	b729                	j	ffffffffc0204518 <do_execve+0x3ae>
ffffffffc0204610:	5a61                	li	s4,-8
ffffffffc0204612:	bd99                	j	ffffffffc0204468 <do_execve+0x2fe>
ffffffffc0204614:	00004617          	auipc	a2,0x4
ffffffffc0204618:	67460613          	addi	a2,a2,1652 # ffffffffc0208c88 <commands+0xa98>
ffffffffc020461c:	06900593          	li	a1,105
ffffffffc0204620:	00004517          	auipc	a0,0x4
ffffffffc0204624:	69050513          	addi	a0,a0,1680 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc0204628:	be1fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020462c:	00004617          	auipc	a2,0x4
ffffffffc0204630:	6cc60613          	addi	a2,a2,1740 # ffffffffc0208cf8 <commands+0xb08>
ffffffffc0204634:	06e00593          	li	a1,110
ffffffffc0204638:	00004517          	auipc	a0,0x4
ffffffffc020463c:	67850513          	addi	a0,a0,1656 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc0204640:	bc9fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204644:	00004617          	auipc	a2,0x4
ffffffffc0204648:	6dc60613          	addi	a2,a2,1756 # ffffffffc0208d20 <commands+0xb30>
ffffffffc020464c:	06200593          	li	a1,98
ffffffffc0204650:	00004517          	auipc	a0,0x4
ffffffffc0204654:	66050513          	addi	a0,a0,1632 # ffffffffc0208cb0 <commands+0xac0>
ffffffffc0204658:	bb1fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020465c:	00004617          	auipc	a2,0x4
ffffffffc0204660:	69c60613          	addi	a2,a2,1692 # ffffffffc0208cf8 <commands+0xb08>
ffffffffc0204664:	27300593          	li	a1,627
ffffffffc0204668:	00005517          	auipc	a0,0x5
ffffffffc020466c:	e9850513          	addi	a0,a0,-360 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0204670:	b99fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204674:	00005697          	auipc	a3,0x5
ffffffffc0204678:	14c68693          	addi	a3,a3,332 # ffffffffc02097c0 <default_pmm_manager+0x5a0>
ffffffffc020467c:	00004617          	auipc	a2,0x4
ffffffffc0204680:	f8460613          	addi	a2,a2,-124 # ffffffffc0208600 <commands+0x410>
ffffffffc0204684:	26e00593          	li	a1,622
ffffffffc0204688:	00005517          	auipc	a0,0x5
ffffffffc020468c:	e7850513          	addi	a0,a0,-392 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0204690:	b79fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204694:	00005697          	auipc	a3,0x5
ffffffffc0204698:	0e468693          	addi	a3,a3,228 # ffffffffc0209778 <default_pmm_manager+0x558>
ffffffffc020469c:	00004617          	auipc	a2,0x4
ffffffffc02046a0:	f6460613          	addi	a2,a2,-156 # ffffffffc0208600 <commands+0x410>
ffffffffc02046a4:	26d00593          	li	a1,621
ffffffffc02046a8:	00005517          	auipc	a0,0x5
ffffffffc02046ac:	e5850513          	addi	a0,a0,-424 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc02046b0:	b59fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02046b4:	00005697          	auipc	a3,0x5
ffffffffc02046b8:	07c68693          	addi	a3,a3,124 # ffffffffc0209730 <default_pmm_manager+0x510>
ffffffffc02046bc:	00004617          	auipc	a2,0x4
ffffffffc02046c0:	f4460613          	addi	a2,a2,-188 # ffffffffc0208600 <commands+0x410>
ffffffffc02046c4:	26c00593          	li	a1,620
ffffffffc02046c8:	00005517          	auipc	a0,0x5
ffffffffc02046cc:	e3850513          	addi	a0,a0,-456 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc02046d0:	b39fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02046d4:	00005697          	auipc	a3,0x5
ffffffffc02046d8:	01468693          	addi	a3,a3,20 # ffffffffc02096e8 <default_pmm_manager+0x4c8>
ffffffffc02046dc:	00004617          	auipc	a2,0x4
ffffffffc02046e0:	f2460613          	addi	a2,a2,-220 # ffffffffc0208600 <commands+0x410>
ffffffffc02046e4:	26b00593          	li	a1,619
ffffffffc02046e8:	00005517          	auipc	a0,0x5
ffffffffc02046ec:	e1850513          	addi	a0,a0,-488 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc02046f0:	b19fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02046f4 <do_yield>:
ffffffffc02046f4:	00015797          	auipc	a5,0x15
ffffffffc02046f8:	e0c7b783          	ld	a5,-500(a5) # ffffffffc0219500 <current>
ffffffffc02046fc:	4705                	li	a4,1
ffffffffc02046fe:	ef98                	sd	a4,24(a5)
ffffffffc0204700:	4501                	li	a0,0
ffffffffc0204702:	8082                	ret

ffffffffc0204704 <do_wait>:
ffffffffc0204704:	1101                	addi	sp,sp,-32
ffffffffc0204706:	e822                	sd	s0,16(sp)
ffffffffc0204708:	e426                	sd	s1,8(sp)
ffffffffc020470a:	ec06                	sd	ra,24(sp)
ffffffffc020470c:	842e                	mv	s0,a1
ffffffffc020470e:	84aa                	mv	s1,a0
ffffffffc0204710:	c999                	beqz	a1,ffffffffc0204726 <do_wait+0x22>
ffffffffc0204712:	00015797          	auipc	a5,0x15
ffffffffc0204716:	dee7b783          	ld	a5,-530(a5) # ffffffffc0219500 <current>
ffffffffc020471a:	7788                	ld	a0,40(a5)
ffffffffc020471c:	4685                	li	a3,1
ffffffffc020471e:	4611                	li	a2,4
ffffffffc0204720:	aa7fc0ef          	jal	ra,ffffffffc02011c6 <user_mem_check>
ffffffffc0204724:	c909                	beqz	a0,ffffffffc0204736 <do_wait+0x32>
ffffffffc0204726:	85a2                	mv	a1,s0
ffffffffc0204728:	6442                	ld	s0,16(sp)
ffffffffc020472a:	60e2                	ld	ra,24(sp)
ffffffffc020472c:	8526                	mv	a0,s1
ffffffffc020472e:	64a2                	ld	s1,8(sp)
ffffffffc0204730:	6105                	addi	sp,sp,32
ffffffffc0204732:	fa6ff06f          	j	ffffffffc0203ed8 <do_wait.part.0>
ffffffffc0204736:	60e2                	ld	ra,24(sp)
ffffffffc0204738:	6442                	ld	s0,16(sp)
ffffffffc020473a:	64a2                	ld	s1,8(sp)
ffffffffc020473c:	5575                	li	a0,-3
ffffffffc020473e:	6105                	addi	sp,sp,32
ffffffffc0204740:	8082                	ret

ffffffffc0204742 <do_kill>:
ffffffffc0204742:	1141                	addi	sp,sp,-16
ffffffffc0204744:	e406                	sd	ra,8(sp)
ffffffffc0204746:	e022                	sd	s0,0(sp)
ffffffffc0204748:	960ff0ef          	jal	ra,ffffffffc02038a8 <find_proc>
ffffffffc020474c:	cd0d                	beqz	a0,ffffffffc0204786 <do_kill+0x44>
ffffffffc020474e:	0b052703          	lw	a4,176(a0)
ffffffffc0204752:	00177693          	andi	a3,a4,1
ffffffffc0204756:	e695                	bnez	a3,ffffffffc0204782 <do_kill+0x40>
ffffffffc0204758:	0ec52683          	lw	a3,236(a0)
ffffffffc020475c:	00176713          	ori	a4,a4,1
ffffffffc0204760:	0ae52823          	sw	a4,176(a0)
ffffffffc0204764:	4401                	li	s0,0
ffffffffc0204766:	0006c763          	bltz	a3,ffffffffc0204774 <do_kill+0x32>
ffffffffc020476a:	60a2                	ld	ra,8(sp)
ffffffffc020476c:	8522                	mv	a0,s0
ffffffffc020476e:	6402                	ld	s0,0(sp)
ffffffffc0204770:	0141                	addi	sp,sp,16
ffffffffc0204772:	8082                	ret
ffffffffc0204774:	276000ef          	jal	ra,ffffffffc02049ea <wakeup_proc>
ffffffffc0204778:	60a2                	ld	ra,8(sp)
ffffffffc020477a:	8522                	mv	a0,s0
ffffffffc020477c:	6402                	ld	s0,0(sp)
ffffffffc020477e:	0141                	addi	sp,sp,16
ffffffffc0204780:	8082                	ret
ffffffffc0204782:	545d                	li	s0,-9
ffffffffc0204784:	b7dd                	j	ffffffffc020476a <do_kill+0x28>
ffffffffc0204786:	5475                	li	s0,-3
ffffffffc0204788:	b7cd                	j	ffffffffc020476a <do_kill+0x28>

ffffffffc020478a <proc_init>:
ffffffffc020478a:	1101                	addi	sp,sp,-32
ffffffffc020478c:	00015797          	auipc	a5,0x15
ffffffffc0204790:	f3c78793          	addi	a5,a5,-196 # ffffffffc02196c8 <proc_list>
ffffffffc0204794:	ec06                	sd	ra,24(sp)
ffffffffc0204796:	e822                	sd	s0,16(sp)
ffffffffc0204798:	e426                	sd	s1,8(sp)
ffffffffc020479a:	e04a                	sd	s2,0(sp)
ffffffffc020479c:	e79c                	sd	a5,8(a5)
ffffffffc020479e:	e39c                	sd	a5,0(a5)
ffffffffc02047a0:	00015717          	auipc	a4,0x15
ffffffffc02047a4:	cf070713          	addi	a4,a4,-784 # ffffffffc0219490 <__rq>
ffffffffc02047a8:	00011797          	auipc	a5,0x11
ffffffffc02047ac:	ce878793          	addi	a5,a5,-792 # ffffffffc0215490 <hash_list>
ffffffffc02047b0:	e79c                	sd	a5,8(a5)
ffffffffc02047b2:	e39c                	sd	a5,0(a5)
ffffffffc02047b4:	07c1                	addi	a5,a5,16
ffffffffc02047b6:	fef71de3          	bne	a4,a5,ffffffffc02047b0 <proc_init+0x26>
ffffffffc02047ba:	f57fe0ef          	jal	ra,ffffffffc0203710 <alloc_proc>
ffffffffc02047be:	00015417          	auipc	s0,0x15
ffffffffc02047c2:	d4a40413          	addi	s0,s0,-694 # ffffffffc0219508 <idleproc>
ffffffffc02047c6:	e008                	sd	a0,0(s0)
ffffffffc02047c8:	c541                	beqz	a0,ffffffffc0204850 <proc_init+0xc6>
ffffffffc02047ca:	4709                	li	a4,2
ffffffffc02047cc:	e118                	sd	a4,0(a0)
ffffffffc02047ce:	4485                	li	s1,1
ffffffffc02047d0:	00007717          	auipc	a4,0x7
ffffffffc02047d4:	83070713          	addi	a4,a4,-2000 # ffffffffc020b000 <bootstack>
ffffffffc02047d8:	00005597          	auipc	a1,0x5
ffffffffc02047dc:	04858593          	addi	a1,a1,72 # ffffffffc0209820 <default_pmm_manager+0x600>
ffffffffc02047e0:	e918                	sd	a4,16(a0)
ffffffffc02047e2:	ed04                	sd	s1,24(a0)
ffffffffc02047e4:	82eff0ef          	jal	ra,ffffffffc0203812 <set_proc_name>
ffffffffc02047e8:	00015717          	auipc	a4,0x15
ffffffffc02047ec:	d3070713          	addi	a4,a4,-720 # ffffffffc0219518 <nr_process>
ffffffffc02047f0:	431c                	lw	a5,0(a4)
ffffffffc02047f2:	6014                	ld	a3,0(s0)
ffffffffc02047f4:	4601                	li	a2,0
ffffffffc02047f6:	2785                	addiw	a5,a5,1
ffffffffc02047f8:	4581                	li	a1,0
ffffffffc02047fa:	00000517          	auipc	a0,0x0
ffffffffc02047fe:	87450513          	addi	a0,a0,-1932 # ffffffffc020406e <init_main>
ffffffffc0204802:	c31c                	sw	a5,0(a4)
ffffffffc0204804:	00015797          	auipc	a5,0x15
ffffffffc0204808:	ced7be23          	sd	a3,-772(a5) # ffffffffc0219500 <current>
ffffffffc020480c:	cc6ff0ef          	jal	ra,ffffffffc0203cd2 <kernel_thread>
ffffffffc0204810:	08a05c63          	blez	a0,ffffffffc02048a8 <proc_init+0x11e>
ffffffffc0204814:	894ff0ef          	jal	ra,ffffffffc02038a8 <find_proc>
ffffffffc0204818:	00015917          	auipc	s2,0x15
ffffffffc020481c:	cf890913          	addi	s2,s2,-776 # ffffffffc0219510 <initproc>
ffffffffc0204820:	00005597          	auipc	a1,0x5
ffffffffc0204824:	02858593          	addi	a1,a1,40 # ffffffffc0209848 <default_pmm_manager+0x628>
ffffffffc0204828:	00a93023          	sd	a0,0(s2)
ffffffffc020482c:	fe7fe0ef          	jal	ra,ffffffffc0203812 <set_proc_name>
ffffffffc0204830:	601c                	ld	a5,0(s0)
ffffffffc0204832:	cbb9                	beqz	a5,ffffffffc0204888 <proc_init+0xfe>
ffffffffc0204834:	43dc                	lw	a5,4(a5)
ffffffffc0204836:	eba9                	bnez	a5,ffffffffc0204888 <proc_init+0xfe>
ffffffffc0204838:	00093783          	ld	a5,0(s2)
ffffffffc020483c:	c795                	beqz	a5,ffffffffc0204868 <proc_init+0xde>
ffffffffc020483e:	43dc                	lw	a5,4(a5)
ffffffffc0204840:	02979463          	bne	a5,s1,ffffffffc0204868 <proc_init+0xde>
ffffffffc0204844:	60e2                	ld	ra,24(sp)
ffffffffc0204846:	6442                	ld	s0,16(sp)
ffffffffc0204848:	64a2                	ld	s1,8(sp)
ffffffffc020484a:	6902                	ld	s2,0(sp)
ffffffffc020484c:	6105                	addi	sp,sp,32
ffffffffc020484e:	8082                	ret
ffffffffc0204850:	00005617          	auipc	a2,0x5
ffffffffc0204854:	fb860613          	addi	a2,a2,-72 # ffffffffc0209808 <default_pmm_manager+0x5e8>
ffffffffc0204858:	37700593          	li	a1,887
ffffffffc020485c:	00005517          	auipc	a0,0x5
ffffffffc0204860:	ca450513          	addi	a0,a0,-860 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0204864:	9a5fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204868:	00005697          	auipc	a3,0x5
ffffffffc020486c:	01068693          	addi	a3,a3,16 # ffffffffc0209878 <default_pmm_manager+0x658>
ffffffffc0204870:	00004617          	auipc	a2,0x4
ffffffffc0204874:	d9060613          	addi	a2,a2,-624 # ffffffffc0208600 <commands+0x410>
ffffffffc0204878:	38c00593          	li	a1,908
ffffffffc020487c:	00005517          	auipc	a0,0x5
ffffffffc0204880:	c8450513          	addi	a0,a0,-892 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc0204884:	985fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204888:	00005697          	auipc	a3,0x5
ffffffffc020488c:	fc868693          	addi	a3,a3,-56 # ffffffffc0209850 <default_pmm_manager+0x630>
ffffffffc0204890:	00004617          	auipc	a2,0x4
ffffffffc0204894:	d7060613          	addi	a2,a2,-656 # ffffffffc0208600 <commands+0x410>
ffffffffc0204898:	38b00593          	li	a1,907
ffffffffc020489c:	00005517          	auipc	a0,0x5
ffffffffc02048a0:	c6450513          	addi	a0,a0,-924 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc02048a4:	965fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02048a8:	00005617          	auipc	a2,0x5
ffffffffc02048ac:	f8060613          	addi	a2,a2,-128 # ffffffffc0209828 <default_pmm_manager+0x608>
ffffffffc02048b0:	38500593          	li	a1,901
ffffffffc02048b4:	00005517          	auipc	a0,0x5
ffffffffc02048b8:	c4c50513          	addi	a0,a0,-948 # ffffffffc0209500 <default_pmm_manager+0x2e0>
ffffffffc02048bc:	94dfb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02048c0 <cpu_idle>:
ffffffffc02048c0:	1141                	addi	sp,sp,-16
ffffffffc02048c2:	e022                	sd	s0,0(sp)
ffffffffc02048c4:	e406                	sd	ra,8(sp)
ffffffffc02048c6:	00015417          	auipc	s0,0x15
ffffffffc02048ca:	c3a40413          	addi	s0,s0,-966 # ffffffffc0219500 <current>
ffffffffc02048ce:	6018                	ld	a4,0(s0)
ffffffffc02048d0:	6f1c                	ld	a5,24(a4)
ffffffffc02048d2:	dffd                	beqz	a5,ffffffffc02048d0 <cpu_idle+0x10>
ffffffffc02048d4:	1c8000ef          	jal	ra,ffffffffc0204a9c <schedule>
ffffffffc02048d8:	bfdd                	j	ffffffffc02048ce <cpu_idle+0xe>

ffffffffc02048da <lab6_set_priority>:
ffffffffc02048da:	1141                	addi	sp,sp,-16
ffffffffc02048dc:	e022                	sd	s0,0(sp)
ffffffffc02048de:	85aa                	mv	a1,a0
ffffffffc02048e0:	842a                	mv	s0,a0
ffffffffc02048e2:	00005517          	auipc	a0,0x5
ffffffffc02048e6:	fbe50513          	addi	a0,a0,-66 # ffffffffc02098a0 <default_pmm_manager+0x680>
ffffffffc02048ea:	e406                	sd	ra,8(sp)
ffffffffc02048ec:	fe0fb0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02048f0:	00015797          	auipc	a5,0x15
ffffffffc02048f4:	c107b783          	ld	a5,-1008(a5) # ffffffffc0219500 <current>
ffffffffc02048f8:	e801                	bnez	s0,ffffffffc0204908 <lab6_set_priority+0x2e>
ffffffffc02048fa:	60a2                	ld	ra,8(sp)
ffffffffc02048fc:	6402                	ld	s0,0(sp)
ffffffffc02048fe:	4705                	li	a4,1
ffffffffc0204900:	14e7a223          	sw	a4,324(a5)
ffffffffc0204904:	0141                	addi	sp,sp,16
ffffffffc0204906:	8082                	ret
ffffffffc0204908:	60a2                	ld	ra,8(sp)
ffffffffc020490a:	1487a223          	sw	s0,324(a5)
ffffffffc020490e:	6402                	ld	s0,0(sp)
ffffffffc0204910:	0141                	addi	sp,sp,16
ffffffffc0204912:	8082                	ret

ffffffffc0204914 <do_sleep>:
ffffffffc0204914:	c539                	beqz	a0,ffffffffc0204962 <do_sleep+0x4e>
ffffffffc0204916:	7179                	addi	sp,sp,-48
ffffffffc0204918:	f022                	sd	s0,32(sp)
ffffffffc020491a:	f406                	sd	ra,40(sp)
ffffffffc020491c:	842a                	mv	s0,a0
ffffffffc020491e:	100027f3          	csrr	a5,sstatus
ffffffffc0204922:	8b89                	andi	a5,a5,2
ffffffffc0204924:	e3a9                	bnez	a5,ffffffffc0204966 <do_sleep+0x52>
ffffffffc0204926:	00015797          	auipc	a5,0x15
ffffffffc020492a:	bda7b783          	ld	a5,-1062(a5) # ffffffffc0219500 <current>
ffffffffc020492e:	0818                	addi	a4,sp,16
ffffffffc0204930:	c02a                	sw	a0,0(sp)
ffffffffc0204932:	ec3a                	sd	a4,24(sp)
ffffffffc0204934:	e83a                	sd	a4,16(sp)
ffffffffc0204936:	e43e                	sd	a5,8(sp)
ffffffffc0204938:	4705                	li	a4,1
ffffffffc020493a:	c398                	sw	a4,0(a5)
ffffffffc020493c:	80000737          	lui	a4,0x80000
ffffffffc0204940:	840a                	mv	s0,sp
ffffffffc0204942:	2709                	addiw	a4,a4,2
ffffffffc0204944:	0ee7a623          	sw	a4,236(a5)
ffffffffc0204948:	8522                	mv	a0,s0
ffffffffc020494a:	218000ef          	jal	ra,ffffffffc0204b62 <add_timer>
ffffffffc020494e:	14e000ef          	jal	ra,ffffffffc0204a9c <schedule>
ffffffffc0204952:	8522                	mv	a0,s0
ffffffffc0204954:	2d6000ef          	jal	ra,ffffffffc0204c2a <del_timer>
ffffffffc0204958:	70a2                	ld	ra,40(sp)
ffffffffc020495a:	7402                	ld	s0,32(sp)
ffffffffc020495c:	4501                	li	a0,0
ffffffffc020495e:	6145                	addi	sp,sp,48
ffffffffc0204960:	8082                	ret
ffffffffc0204962:	4501                	li	a0,0
ffffffffc0204964:	8082                	ret
ffffffffc0204966:	cd3fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc020496a:	00015797          	auipc	a5,0x15
ffffffffc020496e:	b967b783          	ld	a5,-1130(a5) # ffffffffc0219500 <current>
ffffffffc0204972:	0818                	addi	a4,sp,16
ffffffffc0204974:	c022                	sw	s0,0(sp)
ffffffffc0204976:	e43e                	sd	a5,8(sp)
ffffffffc0204978:	ec3a                	sd	a4,24(sp)
ffffffffc020497a:	e83a                	sd	a4,16(sp)
ffffffffc020497c:	4705                	li	a4,1
ffffffffc020497e:	c398                	sw	a4,0(a5)
ffffffffc0204980:	80000737          	lui	a4,0x80000
ffffffffc0204984:	2709                	addiw	a4,a4,2
ffffffffc0204986:	840a                	mv	s0,sp
ffffffffc0204988:	8522                	mv	a0,s0
ffffffffc020498a:	0ee7a623          	sw	a4,236(a5)
ffffffffc020498e:	1d4000ef          	jal	ra,ffffffffc0204b62 <add_timer>
ffffffffc0204992:	ca1fb0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0204996:	bf65                	j	ffffffffc020494e <do_sleep+0x3a>

ffffffffc0204998 <sched_init>:
ffffffffc0204998:	1141                	addi	sp,sp,-16
ffffffffc020499a:	00009717          	auipc	a4,0x9
ffffffffc020499e:	6b670713          	addi	a4,a4,1718 # ffffffffc020e050 <default_sched_class>
ffffffffc02049a2:	e022                	sd	s0,0(sp)
ffffffffc02049a4:	e406                	sd	ra,8(sp)
ffffffffc02049a6:	00015797          	auipc	a5,0x15
ffffffffc02049aa:	b0a78793          	addi	a5,a5,-1270 # ffffffffc02194b0 <timer_list>
ffffffffc02049ae:	6714                	ld	a3,8(a4)
ffffffffc02049b0:	00015517          	auipc	a0,0x15
ffffffffc02049b4:	ae050513          	addi	a0,a0,-1312 # ffffffffc0219490 <__rq>
ffffffffc02049b8:	e79c                	sd	a5,8(a5)
ffffffffc02049ba:	e39c                	sd	a5,0(a5)
ffffffffc02049bc:	4795                	li	a5,5
ffffffffc02049be:	c95c                	sw	a5,20(a0)
ffffffffc02049c0:	00015417          	auipc	s0,0x15
ffffffffc02049c4:	b6840413          	addi	s0,s0,-1176 # ffffffffc0219528 <sched_class>
ffffffffc02049c8:	00015797          	auipc	a5,0x15
ffffffffc02049cc:	b4a7bc23          	sd	a0,-1192(a5) # ffffffffc0219520 <rq>
ffffffffc02049d0:	e018                	sd	a4,0(s0)
ffffffffc02049d2:	9682                	jalr	a3
ffffffffc02049d4:	601c                	ld	a5,0(s0)
ffffffffc02049d6:	6402                	ld	s0,0(sp)
ffffffffc02049d8:	60a2                	ld	ra,8(sp)
ffffffffc02049da:	638c                	ld	a1,0(a5)
ffffffffc02049dc:	00005517          	auipc	a0,0x5
ffffffffc02049e0:	edc50513          	addi	a0,a0,-292 # ffffffffc02098b8 <default_pmm_manager+0x698>
ffffffffc02049e4:	0141                	addi	sp,sp,16
ffffffffc02049e6:	ee6fb06f          	j	ffffffffc02000cc <cprintf>

ffffffffc02049ea <wakeup_proc>:
ffffffffc02049ea:	4118                	lw	a4,0(a0)
ffffffffc02049ec:	1101                	addi	sp,sp,-32
ffffffffc02049ee:	ec06                	sd	ra,24(sp)
ffffffffc02049f0:	e822                	sd	s0,16(sp)
ffffffffc02049f2:	e426                	sd	s1,8(sp)
ffffffffc02049f4:	478d                	li	a5,3
ffffffffc02049f6:	08f70363          	beq	a4,a5,ffffffffc0204a7c <wakeup_proc+0x92>
ffffffffc02049fa:	842a                	mv	s0,a0
ffffffffc02049fc:	100027f3          	csrr	a5,sstatus
ffffffffc0204a00:	8b89                	andi	a5,a5,2
ffffffffc0204a02:	4481                	li	s1,0
ffffffffc0204a04:	e7bd                	bnez	a5,ffffffffc0204a72 <wakeup_proc+0x88>
ffffffffc0204a06:	4789                	li	a5,2
ffffffffc0204a08:	04f70863          	beq	a4,a5,ffffffffc0204a58 <wakeup_proc+0x6e>
ffffffffc0204a0c:	c01c                	sw	a5,0(s0)
ffffffffc0204a0e:	0e042623          	sw	zero,236(s0)
ffffffffc0204a12:	00015797          	auipc	a5,0x15
ffffffffc0204a16:	aee7b783          	ld	a5,-1298(a5) # ffffffffc0219500 <current>
ffffffffc0204a1a:	02878363          	beq	a5,s0,ffffffffc0204a40 <wakeup_proc+0x56>
ffffffffc0204a1e:	00015797          	auipc	a5,0x15
ffffffffc0204a22:	aea7b783          	ld	a5,-1302(a5) # ffffffffc0219508 <idleproc>
ffffffffc0204a26:	00f40d63          	beq	s0,a5,ffffffffc0204a40 <wakeup_proc+0x56>
ffffffffc0204a2a:	00015797          	auipc	a5,0x15
ffffffffc0204a2e:	afe7b783          	ld	a5,-1282(a5) # ffffffffc0219528 <sched_class>
ffffffffc0204a32:	6b9c                	ld	a5,16(a5)
ffffffffc0204a34:	85a2                	mv	a1,s0
ffffffffc0204a36:	00015517          	auipc	a0,0x15
ffffffffc0204a3a:	aea53503          	ld	a0,-1302(a0) # ffffffffc0219520 <rq>
ffffffffc0204a3e:	9782                	jalr	a5
ffffffffc0204a40:	e491                	bnez	s1,ffffffffc0204a4c <wakeup_proc+0x62>
ffffffffc0204a42:	60e2                	ld	ra,24(sp)
ffffffffc0204a44:	6442                	ld	s0,16(sp)
ffffffffc0204a46:	64a2                	ld	s1,8(sp)
ffffffffc0204a48:	6105                	addi	sp,sp,32
ffffffffc0204a4a:	8082                	ret
ffffffffc0204a4c:	6442                	ld	s0,16(sp)
ffffffffc0204a4e:	60e2                	ld	ra,24(sp)
ffffffffc0204a50:	64a2                	ld	s1,8(sp)
ffffffffc0204a52:	6105                	addi	sp,sp,32
ffffffffc0204a54:	bdffb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204a58:	00005617          	auipc	a2,0x5
ffffffffc0204a5c:	eb060613          	addi	a2,a2,-336 # ffffffffc0209908 <default_pmm_manager+0x6e8>
ffffffffc0204a60:	04800593          	li	a1,72
ffffffffc0204a64:	00005517          	auipc	a0,0x5
ffffffffc0204a68:	e8c50513          	addi	a0,a0,-372 # ffffffffc02098f0 <default_pmm_manager+0x6d0>
ffffffffc0204a6c:	805fb0ef          	jal	ra,ffffffffc0200270 <__warn>
ffffffffc0204a70:	bfc1                	j	ffffffffc0204a40 <wakeup_proc+0x56>
ffffffffc0204a72:	bc7fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204a76:	4018                	lw	a4,0(s0)
ffffffffc0204a78:	4485                	li	s1,1
ffffffffc0204a7a:	b771                	j	ffffffffc0204a06 <wakeup_proc+0x1c>
ffffffffc0204a7c:	00005697          	auipc	a3,0x5
ffffffffc0204a80:	e5468693          	addi	a3,a3,-428 # ffffffffc02098d0 <default_pmm_manager+0x6b0>
ffffffffc0204a84:	00004617          	auipc	a2,0x4
ffffffffc0204a88:	b7c60613          	addi	a2,a2,-1156 # ffffffffc0208600 <commands+0x410>
ffffffffc0204a8c:	03c00593          	li	a1,60
ffffffffc0204a90:	00005517          	auipc	a0,0x5
ffffffffc0204a94:	e6050513          	addi	a0,a0,-416 # ffffffffc02098f0 <default_pmm_manager+0x6d0>
ffffffffc0204a98:	f70fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204a9c <schedule>:
ffffffffc0204a9c:	7179                	addi	sp,sp,-48
ffffffffc0204a9e:	f406                	sd	ra,40(sp)
ffffffffc0204aa0:	f022                	sd	s0,32(sp)
ffffffffc0204aa2:	ec26                	sd	s1,24(sp)
ffffffffc0204aa4:	e84a                	sd	s2,16(sp)
ffffffffc0204aa6:	e44e                	sd	s3,8(sp)
ffffffffc0204aa8:	e052                	sd	s4,0(sp)
ffffffffc0204aaa:	100027f3          	csrr	a5,sstatus
ffffffffc0204aae:	8b89                	andi	a5,a5,2
ffffffffc0204ab0:	4a01                	li	s4,0
ffffffffc0204ab2:	e7c5                	bnez	a5,ffffffffc0204b5a <schedule+0xbe>
ffffffffc0204ab4:	00015497          	auipc	s1,0x15
ffffffffc0204ab8:	a4c48493          	addi	s1,s1,-1460 # ffffffffc0219500 <current>
ffffffffc0204abc:	608c                	ld	a1,0(s1)
ffffffffc0204abe:	00015997          	auipc	s3,0x15
ffffffffc0204ac2:	a6a98993          	addi	s3,s3,-1430 # ffffffffc0219528 <sched_class>
ffffffffc0204ac6:	00015917          	auipc	s2,0x15
ffffffffc0204aca:	a5a90913          	addi	s2,s2,-1446 # ffffffffc0219520 <rq>
ffffffffc0204ace:	4194                	lw	a3,0(a1)
ffffffffc0204ad0:	0005bc23          	sd	zero,24(a1)
ffffffffc0204ad4:	4709                	li	a4,2
ffffffffc0204ad6:	0009b783          	ld	a5,0(s3)
ffffffffc0204ada:	00093503          	ld	a0,0(s2)
ffffffffc0204ade:	04e68063          	beq	a3,a4,ffffffffc0204b1e <schedule+0x82>
ffffffffc0204ae2:	739c                	ld	a5,32(a5)
ffffffffc0204ae4:	9782                	jalr	a5
ffffffffc0204ae6:	842a                	mv	s0,a0
ffffffffc0204ae8:	c939                	beqz	a0,ffffffffc0204b3e <schedule+0xa2>
ffffffffc0204aea:	0009b783          	ld	a5,0(s3)
ffffffffc0204aee:	00093503          	ld	a0,0(s2)
ffffffffc0204af2:	85a2                	mv	a1,s0
ffffffffc0204af4:	6f9c                	ld	a5,24(a5)
ffffffffc0204af6:	9782                	jalr	a5
ffffffffc0204af8:	441c                	lw	a5,8(s0)
ffffffffc0204afa:	6098                	ld	a4,0(s1)
ffffffffc0204afc:	2785                	addiw	a5,a5,1
ffffffffc0204afe:	c41c                	sw	a5,8(s0)
ffffffffc0204b00:	00870563          	beq	a4,s0,ffffffffc0204b0a <schedule+0x6e>
ffffffffc0204b04:	8522                	mv	a0,s0
ffffffffc0204b06:	d37fe0ef          	jal	ra,ffffffffc020383c <proc_run>
ffffffffc0204b0a:	020a1f63          	bnez	s4,ffffffffc0204b48 <schedule+0xac>
ffffffffc0204b0e:	70a2                	ld	ra,40(sp)
ffffffffc0204b10:	7402                	ld	s0,32(sp)
ffffffffc0204b12:	64e2                	ld	s1,24(sp)
ffffffffc0204b14:	6942                	ld	s2,16(sp)
ffffffffc0204b16:	69a2                	ld	s3,8(sp)
ffffffffc0204b18:	6a02                	ld	s4,0(sp)
ffffffffc0204b1a:	6145                	addi	sp,sp,48
ffffffffc0204b1c:	8082                	ret
ffffffffc0204b1e:	00015717          	auipc	a4,0x15
ffffffffc0204b22:	9ea73703          	ld	a4,-1558(a4) # ffffffffc0219508 <idleproc>
ffffffffc0204b26:	fae58ee3          	beq	a1,a4,ffffffffc0204ae2 <schedule+0x46>
ffffffffc0204b2a:	6b9c                	ld	a5,16(a5)
ffffffffc0204b2c:	9782                	jalr	a5
ffffffffc0204b2e:	0009b783          	ld	a5,0(s3)
ffffffffc0204b32:	00093503          	ld	a0,0(s2)
ffffffffc0204b36:	739c                	ld	a5,32(a5)
ffffffffc0204b38:	9782                	jalr	a5
ffffffffc0204b3a:	842a                	mv	s0,a0
ffffffffc0204b3c:	f55d                	bnez	a0,ffffffffc0204aea <schedule+0x4e>
ffffffffc0204b3e:	00015417          	auipc	s0,0x15
ffffffffc0204b42:	9ca43403          	ld	s0,-1590(s0) # ffffffffc0219508 <idleproc>
ffffffffc0204b46:	bf4d                	j	ffffffffc0204af8 <schedule+0x5c>
ffffffffc0204b48:	7402                	ld	s0,32(sp)
ffffffffc0204b4a:	70a2                	ld	ra,40(sp)
ffffffffc0204b4c:	64e2                	ld	s1,24(sp)
ffffffffc0204b4e:	6942                	ld	s2,16(sp)
ffffffffc0204b50:	69a2                	ld	s3,8(sp)
ffffffffc0204b52:	6a02                	ld	s4,0(sp)
ffffffffc0204b54:	6145                	addi	sp,sp,48
ffffffffc0204b56:	addfb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204b5a:	adffb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204b5e:	4a05                	li	s4,1
ffffffffc0204b60:	bf91                	j	ffffffffc0204ab4 <schedule+0x18>

ffffffffc0204b62 <add_timer>:
ffffffffc0204b62:	1141                	addi	sp,sp,-16
ffffffffc0204b64:	e022                	sd	s0,0(sp)
ffffffffc0204b66:	e406                	sd	ra,8(sp)
ffffffffc0204b68:	842a                	mv	s0,a0
ffffffffc0204b6a:	100027f3          	csrr	a5,sstatus
ffffffffc0204b6e:	8b89                	andi	a5,a5,2
ffffffffc0204b70:	4501                	li	a0,0
ffffffffc0204b72:	eba5                	bnez	a5,ffffffffc0204be2 <add_timer+0x80>
ffffffffc0204b74:	401c                	lw	a5,0(s0)
ffffffffc0204b76:	cbb5                	beqz	a5,ffffffffc0204bea <add_timer+0x88>
ffffffffc0204b78:	6418                	ld	a4,8(s0)
ffffffffc0204b7a:	cb25                	beqz	a4,ffffffffc0204bea <add_timer+0x88>
ffffffffc0204b7c:	6c18                	ld	a4,24(s0)
ffffffffc0204b7e:	01040593          	addi	a1,s0,16
ffffffffc0204b82:	08e59463          	bne	a1,a4,ffffffffc0204c0a <add_timer+0xa8>
ffffffffc0204b86:	00015617          	auipc	a2,0x15
ffffffffc0204b8a:	92a60613          	addi	a2,a2,-1750 # ffffffffc02194b0 <timer_list>
ffffffffc0204b8e:	6618                	ld	a4,8(a2)
ffffffffc0204b90:	00c71863          	bne	a4,a2,ffffffffc0204ba0 <add_timer+0x3e>
ffffffffc0204b94:	a80d                	j	ffffffffc0204bc6 <add_timer+0x64>
ffffffffc0204b96:	6718                	ld	a4,8(a4)
ffffffffc0204b98:	9f95                	subw	a5,a5,a3
ffffffffc0204b9a:	c01c                	sw	a5,0(s0)
ffffffffc0204b9c:	02c70563          	beq	a4,a2,ffffffffc0204bc6 <add_timer+0x64>
ffffffffc0204ba0:	ff072683          	lw	a3,-16(a4)
ffffffffc0204ba4:	fed7f9e3          	bgeu	a5,a3,ffffffffc0204b96 <add_timer+0x34>
ffffffffc0204ba8:	40f687bb          	subw	a5,a3,a5
ffffffffc0204bac:	fef72823          	sw	a5,-16(a4)
ffffffffc0204bb0:	631c                	ld	a5,0(a4)
ffffffffc0204bb2:	e30c                	sd	a1,0(a4)
ffffffffc0204bb4:	e78c                	sd	a1,8(a5)
ffffffffc0204bb6:	ec18                	sd	a4,24(s0)
ffffffffc0204bb8:	e81c                	sd	a5,16(s0)
ffffffffc0204bba:	c105                	beqz	a0,ffffffffc0204bda <add_timer+0x78>
ffffffffc0204bbc:	6402                	ld	s0,0(sp)
ffffffffc0204bbe:	60a2                	ld	ra,8(sp)
ffffffffc0204bc0:	0141                	addi	sp,sp,16
ffffffffc0204bc2:	a71fb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204bc6:	00015717          	auipc	a4,0x15
ffffffffc0204bca:	8ea70713          	addi	a4,a4,-1814 # ffffffffc02194b0 <timer_list>
ffffffffc0204bce:	631c                	ld	a5,0(a4)
ffffffffc0204bd0:	e30c                	sd	a1,0(a4)
ffffffffc0204bd2:	e78c                	sd	a1,8(a5)
ffffffffc0204bd4:	ec18                	sd	a4,24(s0)
ffffffffc0204bd6:	e81c                	sd	a5,16(s0)
ffffffffc0204bd8:	f175                	bnez	a0,ffffffffc0204bbc <add_timer+0x5a>
ffffffffc0204bda:	60a2                	ld	ra,8(sp)
ffffffffc0204bdc:	6402                	ld	s0,0(sp)
ffffffffc0204bde:	0141                	addi	sp,sp,16
ffffffffc0204be0:	8082                	ret
ffffffffc0204be2:	a57fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204be6:	4505                	li	a0,1
ffffffffc0204be8:	b771                	j	ffffffffc0204b74 <add_timer+0x12>
ffffffffc0204bea:	00005697          	auipc	a3,0x5
ffffffffc0204bee:	d3e68693          	addi	a3,a3,-706 # ffffffffc0209928 <default_pmm_manager+0x708>
ffffffffc0204bf2:	00004617          	auipc	a2,0x4
ffffffffc0204bf6:	a0e60613          	addi	a2,a2,-1522 # ffffffffc0208600 <commands+0x410>
ffffffffc0204bfa:	06c00593          	li	a1,108
ffffffffc0204bfe:	00005517          	auipc	a0,0x5
ffffffffc0204c02:	cf250513          	addi	a0,a0,-782 # ffffffffc02098f0 <default_pmm_manager+0x6d0>
ffffffffc0204c06:	e02fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204c0a:	00005697          	auipc	a3,0x5
ffffffffc0204c0e:	d4e68693          	addi	a3,a3,-690 # ffffffffc0209958 <default_pmm_manager+0x738>
ffffffffc0204c12:	00004617          	auipc	a2,0x4
ffffffffc0204c16:	9ee60613          	addi	a2,a2,-1554 # ffffffffc0208600 <commands+0x410>
ffffffffc0204c1a:	06d00593          	li	a1,109
ffffffffc0204c1e:	00005517          	auipc	a0,0x5
ffffffffc0204c22:	cd250513          	addi	a0,a0,-814 # ffffffffc02098f0 <default_pmm_manager+0x6d0>
ffffffffc0204c26:	de2fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204c2a <del_timer>:
ffffffffc0204c2a:	1101                	addi	sp,sp,-32
ffffffffc0204c2c:	e822                	sd	s0,16(sp)
ffffffffc0204c2e:	ec06                	sd	ra,24(sp)
ffffffffc0204c30:	e426                	sd	s1,8(sp)
ffffffffc0204c32:	842a                	mv	s0,a0
ffffffffc0204c34:	100027f3          	csrr	a5,sstatus
ffffffffc0204c38:	8b89                	andi	a5,a5,2
ffffffffc0204c3a:	01050493          	addi	s1,a0,16
ffffffffc0204c3e:	eb9d                	bnez	a5,ffffffffc0204c74 <del_timer+0x4a>
ffffffffc0204c40:	6d1c                	ld	a5,24(a0)
ffffffffc0204c42:	02978463          	beq	a5,s1,ffffffffc0204c6a <del_timer+0x40>
ffffffffc0204c46:	4114                	lw	a3,0(a0)
ffffffffc0204c48:	6918                	ld	a4,16(a0)
ffffffffc0204c4a:	ce81                	beqz	a3,ffffffffc0204c62 <del_timer+0x38>
ffffffffc0204c4c:	00015617          	auipc	a2,0x15
ffffffffc0204c50:	86460613          	addi	a2,a2,-1948 # ffffffffc02194b0 <timer_list>
ffffffffc0204c54:	00c78763          	beq	a5,a2,ffffffffc0204c62 <del_timer+0x38>
ffffffffc0204c58:	ff07a603          	lw	a2,-16(a5)
ffffffffc0204c5c:	9eb1                	addw	a3,a3,a2
ffffffffc0204c5e:	fed7a823          	sw	a3,-16(a5)
ffffffffc0204c62:	e71c                	sd	a5,8(a4)
ffffffffc0204c64:	e398                	sd	a4,0(a5)
ffffffffc0204c66:	ec04                	sd	s1,24(s0)
ffffffffc0204c68:	e804                	sd	s1,16(s0)
ffffffffc0204c6a:	60e2                	ld	ra,24(sp)
ffffffffc0204c6c:	6442                	ld	s0,16(sp)
ffffffffc0204c6e:	64a2                	ld	s1,8(sp)
ffffffffc0204c70:	6105                	addi	sp,sp,32
ffffffffc0204c72:	8082                	ret
ffffffffc0204c74:	9c5fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204c78:	6c1c                	ld	a5,24(s0)
ffffffffc0204c7a:	02978463          	beq	a5,s1,ffffffffc0204ca2 <del_timer+0x78>
ffffffffc0204c7e:	4014                	lw	a3,0(s0)
ffffffffc0204c80:	6818                	ld	a4,16(s0)
ffffffffc0204c82:	ce81                	beqz	a3,ffffffffc0204c9a <del_timer+0x70>
ffffffffc0204c84:	00015617          	auipc	a2,0x15
ffffffffc0204c88:	82c60613          	addi	a2,a2,-2004 # ffffffffc02194b0 <timer_list>
ffffffffc0204c8c:	00c78763          	beq	a5,a2,ffffffffc0204c9a <del_timer+0x70>
ffffffffc0204c90:	ff07a603          	lw	a2,-16(a5)
ffffffffc0204c94:	9eb1                	addw	a3,a3,a2
ffffffffc0204c96:	fed7a823          	sw	a3,-16(a5)
ffffffffc0204c9a:	e71c                	sd	a5,8(a4)
ffffffffc0204c9c:	e398                	sd	a4,0(a5)
ffffffffc0204c9e:	ec04                	sd	s1,24(s0)
ffffffffc0204ca0:	e804                	sd	s1,16(s0)
ffffffffc0204ca2:	6442                	ld	s0,16(sp)
ffffffffc0204ca4:	60e2                	ld	ra,24(sp)
ffffffffc0204ca6:	64a2                	ld	s1,8(sp)
ffffffffc0204ca8:	6105                	addi	sp,sp,32
ffffffffc0204caa:	989fb06f          	j	ffffffffc0200632 <intr_enable>

ffffffffc0204cae <run_timer_list>:
ffffffffc0204cae:	7139                	addi	sp,sp,-64
ffffffffc0204cb0:	fc06                	sd	ra,56(sp)
ffffffffc0204cb2:	f822                	sd	s0,48(sp)
ffffffffc0204cb4:	f426                	sd	s1,40(sp)
ffffffffc0204cb6:	f04a                	sd	s2,32(sp)
ffffffffc0204cb8:	ec4e                	sd	s3,24(sp)
ffffffffc0204cba:	e852                	sd	s4,16(sp)
ffffffffc0204cbc:	e456                	sd	s5,8(sp)
ffffffffc0204cbe:	e05a                	sd	s6,0(sp)
ffffffffc0204cc0:	100027f3          	csrr	a5,sstatus
ffffffffc0204cc4:	8b89                	andi	a5,a5,2
ffffffffc0204cc6:	4b01                	li	s6,0
ffffffffc0204cc8:	eff9                	bnez	a5,ffffffffc0204da6 <run_timer_list+0xf8>
ffffffffc0204cca:	00014997          	auipc	s3,0x14
ffffffffc0204cce:	7e698993          	addi	s3,s3,2022 # ffffffffc02194b0 <timer_list>
ffffffffc0204cd2:	0089b403          	ld	s0,8(s3)
ffffffffc0204cd6:	07340a63          	beq	s0,s3,ffffffffc0204d4a <run_timer_list+0x9c>
ffffffffc0204cda:	ff042783          	lw	a5,-16(s0)
ffffffffc0204cde:	ff040913          	addi	s2,s0,-16
ffffffffc0204ce2:	0e078663          	beqz	a5,ffffffffc0204dce <run_timer_list+0x120>
ffffffffc0204ce6:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204cea:	fee42823          	sw	a4,-16(s0)
ffffffffc0204cee:	ef31                	bnez	a4,ffffffffc0204d4a <run_timer_list+0x9c>
ffffffffc0204cf0:	00005a97          	auipc	s5,0x5
ffffffffc0204cf4:	cd0a8a93          	addi	s5,s5,-816 # ffffffffc02099c0 <default_pmm_manager+0x7a0>
ffffffffc0204cf8:	00005a17          	auipc	s4,0x5
ffffffffc0204cfc:	bf8a0a13          	addi	s4,s4,-1032 # ffffffffc02098f0 <default_pmm_manager+0x6d0>
ffffffffc0204d00:	a005                	j	ffffffffc0204d20 <run_timer_list+0x72>
ffffffffc0204d02:	0a07d663          	bgez	a5,ffffffffc0204dae <run_timer_list+0x100>
ffffffffc0204d06:	8526                	mv	a0,s1
ffffffffc0204d08:	ce3ff0ef          	jal	ra,ffffffffc02049ea <wakeup_proc>
ffffffffc0204d0c:	854a                	mv	a0,s2
ffffffffc0204d0e:	f1dff0ef          	jal	ra,ffffffffc0204c2a <del_timer>
ffffffffc0204d12:	03340c63          	beq	s0,s3,ffffffffc0204d4a <run_timer_list+0x9c>
ffffffffc0204d16:	ff042783          	lw	a5,-16(s0)
ffffffffc0204d1a:	ff040913          	addi	s2,s0,-16
ffffffffc0204d1e:	e795                	bnez	a5,ffffffffc0204d4a <run_timer_list+0x9c>
ffffffffc0204d20:	00893483          	ld	s1,8(s2)
ffffffffc0204d24:	6400                	ld	s0,8(s0)
ffffffffc0204d26:	0ec4a783          	lw	a5,236(s1)
ffffffffc0204d2a:	ffe1                	bnez	a5,ffffffffc0204d02 <run_timer_list+0x54>
ffffffffc0204d2c:	40d4                	lw	a3,4(s1)
ffffffffc0204d2e:	8656                	mv	a2,s5
ffffffffc0204d30:	0a300593          	li	a1,163
ffffffffc0204d34:	8552                	mv	a0,s4
ffffffffc0204d36:	d3afb0ef          	jal	ra,ffffffffc0200270 <__warn>
ffffffffc0204d3a:	8526                	mv	a0,s1
ffffffffc0204d3c:	cafff0ef          	jal	ra,ffffffffc02049ea <wakeup_proc>
ffffffffc0204d40:	854a                	mv	a0,s2
ffffffffc0204d42:	ee9ff0ef          	jal	ra,ffffffffc0204c2a <del_timer>
ffffffffc0204d46:	fd3418e3          	bne	s0,s3,ffffffffc0204d16 <run_timer_list+0x68>
ffffffffc0204d4a:	00014597          	auipc	a1,0x14
ffffffffc0204d4e:	7b65b583          	ld	a1,1974(a1) # ffffffffc0219500 <current>
ffffffffc0204d52:	00014797          	auipc	a5,0x14
ffffffffc0204d56:	7b67b783          	ld	a5,1974(a5) # ffffffffc0219508 <idleproc>
ffffffffc0204d5a:	04f58363          	beq	a1,a5,ffffffffc0204da0 <run_timer_list+0xf2>
ffffffffc0204d5e:	00014797          	auipc	a5,0x14
ffffffffc0204d62:	7ca7b783          	ld	a5,1994(a5) # ffffffffc0219528 <sched_class>
ffffffffc0204d66:	779c                	ld	a5,40(a5)
ffffffffc0204d68:	00014517          	auipc	a0,0x14
ffffffffc0204d6c:	7b853503          	ld	a0,1976(a0) # ffffffffc0219520 <rq>
ffffffffc0204d70:	9782                	jalr	a5
ffffffffc0204d72:	000b1c63          	bnez	s6,ffffffffc0204d8a <run_timer_list+0xdc>
ffffffffc0204d76:	70e2                	ld	ra,56(sp)
ffffffffc0204d78:	7442                	ld	s0,48(sp)
ffffffffc0204d7a:	74a2                	ld	s1,40(sp)
ffffffffc0204d7c:	7902                	ld	s2,32(sp)
ffffffffc0204d7e:	69e2                	ld	s3,24(sp)
ffffffffc0204d80:	6a42                	ld	s4,16(sp)
ffffffffc0204d82:	6aa2                	ld	s5,8(sp)
ffffffffc0204d84:	6b02                	ld	s6,0(sp)
ffffffffc0204d86:	6121                	addi	sp,sp,64
ffffffffc0204d88:	8082                	ret
ffffffffc0204d8a:	7442                	ld	s0,48(sp)
ffffffffc0204d8c:	70e2                	ld	ra,56(sp)
ffffffffc0204d8e:	74a2                	ld	s1,40(sp)
ffffffffc0204d90:	7902                	ld	s2,32(sp)
ffffffffc0204d92:	69e2                	ld	s3,24(sp)
ffffffffc0204d94:	6a42                	ld	s4,16(sp)
ffffffffc0204d96:	6aa2                	ld	s5,8(sp)
ffffffffc0204d98:	6b02                	ld	s6,0(sp)
ffffffffc0204d9a:	6121                	addi	sp,sp,64
ffffffffc0204d9c:	897fb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204da0:	4785                	li	a5,1
ffffffffc0204da2:	ed9c                	sd	a5,24(a1)
ffffffffc0204da4:	b7f9                	j	ffffffffc0204d72 <run_timer_list+0xc4>
ffffffffc0204da6:	893fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204daa:	4b05                	li	s6,1
ffffffffc0204dac:	bf39                	j	ffffffffc0204cca <run_timer_list+0x1c>
ffffffffc0204dae:	00005697          	auipc	a3,0x5
ffffffffc0204db2:	bea68693          	addi	a3,a3,-1046 # ffffffffc0209998 <default_pmm_manager+0x778>
ffffffffc0204db6:	00004617          	auipc	a2,0x4
ffffffffc0204dba:	84a60613          	addi	a2,a2,-1974 # ffffffffc0208600 <commands+0x410>
ffffffffc0204dbe:	0a000593          	li	a1,160
ffffffffc0204dc2:	00005517          	auipc	a0,0x5
ffffffffc0204dc6:	b2e50513          	addi	a0,a0,-1234 # ffffffffc02098f0 <default_pmm_manager+0x6d0>
ffffffffc0204dca:	c3efb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204dce:	00005697          	auipc	a3,0x5
ffffffffc0204dd2:	bb268693          	addi	a3,a3,-1102 # ffffffffc0209980 <default_pmm_manager+0x760>
ffffffffc0204dd6:	00004617          	auipc	a2,0x4
ffffffffc0204dda:	82a60613          	addi	a2,a2,-2006 # ffffffffc0208600 <commands+0x410>
ffffffffc0204dde:	09a00593          	li	a1,154
ffffffffc0204de2:	00005517          	auipc	a0,0x5
ffffffffc0204de6:	b0e50513          	addi	a0,a0,-1266 # ffffffffc02098f0 <default_pmm_manager+0x6d0>
ffffffffc0204dea:	c1efb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204dee <proc_stride_comp_f>:
ffffffffc0204dee:	4d08                	lw	a0,24(a0)
ffffffffc0204df0:	4d9c                	lw	a5,24(a1)
ffffffffc0204df2:	9d1d                	subw	a0,a0,a5
ffffffffc0204df4:	00a04763          	bgtz	a0,ffffffffc0204e02 <proc_stride_comp_f+0x14>
ffffffffc0204df8:	00a03533          	snez	a0,a0
ffffffffc0204dfc:	40a00533          	neg	a0,a0
ffffffffc0204e00:	8082                	ret
ffffffffc0204e02:	4505                	li	a0,1
ffffffffc0204e04:	8082                	ret

ffffffffc0204e06 <stride_init>:
ffffffffc0204e06:	e508                	sd	a0,8(a0)
ffffffffc0204e08:	e108                	sd	a0,0(a0)
ffffffffc0204e0a:	00053c23          	sd	zero,24(a0)
ffffffffc0204e0e:	00052823          	sw	zero,16(a0)
ffffffffc0204e12:	8082                	ret

ffffffffc0204e14 <stride_pick_next>:
ffffffffc0204e14:	6d1c                	ld	a5,24(a0)
ffffffffc0204e16:	cf89                	beqz	a5,ffffffffc0204e30 <stride_pick_next+0x1c>
ffffffffc0204e18:	4fd0                	lw	a2,28(a5)
ffffffffc0204e1a:	4f98                	lw	a4,24(a5)
ffffffffc0204e1c:	ed878513          	addi	a0,a5,-296
ffffffffc0204e20:	400006b7          	lui	a3,0x40000
ffffffffc0204e24:	c219                	beqz	a2,ffffffffc0204e2a <stride_pick_next+0x16>
ffffffffc0204e26:	02c6d6bb          	divuw	a3,a3,a2
ffffffffc0204e2a:	9f35                	addw	a4,a4,a3
ffffffffc0204e2c:	cf98                	sw	a4,24(a5)
ffffffffc0204e2e:	8082                	ret
ffffffffc0204e30:	4501                	li	a0,0
ffffffffc0204e32:	8082                	ret

ffffffffc0204e34 <stride_proc_tick>:
ffffffffc0204e34:	1205a783          	lw	a5,288(a1)
ffffffffc0204e38:	00f05563          	blez	a5,ffffffffc0204e42 <stride_proc_tick+0xe>
ffffffffc0204e3c:	37fd                	addiw	a5,a5,-1
ffffffffc0204e3e:	12f5a023          	sw	a5,288(a1)
ffffffffc0204e42:	e399                	bnez	a5,ffffffffc0204e48 <stride_proc_tick+0x14>
ffffffffc0204e44:	4785                	li	a5,1
ffffffffc0204e46:	ed9c                	sd	a5,24(a1)
ffffffffc0204e48:	8082                	ret

ffffffffc0204e4a <skew_heap_merge.constprop.0>:
ffffffffc0204e4a:	1101                	addi	sp,sp,-32
ffffffffc0204e4c:	e822                	sd	s0,16(sp)
ffffffffc0204e4e:	ec06                	sd	ra,24(sp)
ffffffffc0204e50:	e426                	sd	s1,8(sp)
ffffffffc0204e52:	e04a                	sd	s2,0(sp)
ffffffffc0204e54:	842e                	mv	s0,a1
ffffffffc0204e56:	c11d                	beqz	a0,ffffffffc0204e7c <skew_heap_merge.constprop.0+0x32>
ffffffffc0204e58:	84aa                	mv	s1,a0
ffffffffc0204e5a:	c1b9                	beqz	a1,ffffffffc0204ea0 <skew_heap_merge.constprop.0+0x56>
ffffffffc0204e5c:	f93ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0204e60:	57fd                	li	a5,-1
ffffffffc0204e62:	02f50463          	beq	a0,a5,ffffffffc0204e8a <skew_heap_merge.constprop.0+0x40>
ffffffffc0204e66:	680c                	ld	a1,16(s0)
ffffffffc0204e68:	00843903          	ld	s2,8(s0)
ffffffffc0204e6c:	8526                	mv	a0,s1
ffffffffc0204e6e:	fddff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0204e72:	e408                	sd	a0,8(s0)
ffffffffc0204e74:	01243823          	sd	s2,16(s0)
ffffffffc0204e78:	c111                	beqz	a0,ffffffffc0204e7c <skew_heap_merge.constprop.0+0x32>
ffffffffc0204e7a:	e100                	sd	s0,0(a0)
ffffffffc0204e7c:	60e2                	ld	ra,24(sp)
ffffffffc0204e7e:	8522                	mv	a0,s0
ffffffffc0204e80:	6442                	ld	s0,16(sp)
ffffffffc0204e82:	64a2                	ld	s1,8(sp)
ffffffffc0204e84:	6902                	ld	s2,0(sp)
ffffffffc0204e86:	6105                	addi	sp,sp,32
ffffffffc0204e88:	8082                	ret
ffffffffc0204e8a:	6888                	ld	a0,16(s1)
ffffffffc0204e8c:	0084b903          	ld	s2,8(s1)
ffffffffc0204e90:	85a2                	mv	a1,s0
ffffffffc0204e92:	fb9ff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0204e96:	e488                	sd	a0,8(s1)
ffffffffc0204e98:	0124b823          	sd	s2,16(s1)
ffffffffc0204e9c:	c111                	beqz	a0,ffffffffc0204ea0 <skew_heap_merge.constprop.0+0x56>
ffffffffc0204e9e:	e104                	sd	s1,0(a0)
ffffffffc0204ea0:	60e2                	ld	ra,24(sp)
ffffffffc0204ea2:	6442                	ld	s0,16(sp)
ffffffffc0204ea4:	6902                	ld	s2,0(sp)
ffffffffc0204ea6:	8526                	mv	a0,s1
ffffffffc0204ea8:	64a2                	ld	s1,8(sp)
ffffffffc0204eaa:	6105                	addi	sp,sp,32
ffffffffc0204eac:	8082                	ret

ffffffffc0204eae <stride_enqueue>:
ffffffffc0204eae:	7119                	addi	sp,sp,-128
ffffffffc0204eb0:	f4a6                	sd	s1,104(sp)
ffffffffc0204eb2:	6d04                	ld	s1,24(a0)
ffffffffc0204eb4:	f8a2                	sd	s0,112(sp)
ffffffffc0204eb6:	f0ca                	sd	s2,96(sp)
ffffffffc0204eb8:	e8d2                	sd	s4,80(sp)
ffffffffc0204eba:	fc86                	sd	ra,120(sp)
ffffffffc0204ebc:	ecce                	sd	s3,88(sp)
ffffffffc0204ebe:	e4d6                	sd	s5,72(sp)
ffffffffc0204ec0:	e0da                	sd	s6,64(sp)
ffffffffc0204ec2:	fc5e                	sd	s7,56(sp)
ffffffffc0204ec4:	f862                	sd	s8,48(sp)
ffffffffc0204ec6:	f466                	sd	s9,40(sp)
ffffffffc0204ec8:	f06a                	sd	s10,32(sp)
ffffffffc0204eca:	ec6e                	sd	s11,24(sp)
ffffffffc0204ecc:	1205b423          	sd	zero,296(a1)
ffffffffc0204ed0:	1205bc23          	sd	zero,312(a1)
ffffffffc0204ed4:	1205b823          	sd	zero,304(a1)
ffffffffc0204ed8:	8a2a                	mv	s4,a0
ffffffffc0204eda:	842e                	mv	s0,a1
ffffffffc0204edc:	12858913          	addi	s2,a1,296
ffffffffc0204ee0:	cc89                	beqz	s1,ffffffffc0204efa <stride_enqueue+0x4c>
ffffffffc0204ee2:	85ca                	mv	a1,s2
ffffffffc0204ee4:	8526                	mv	a0,s1
ffffffffc0204ee6:	f09ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0204eea:	57fd                	li	a5,-1
ffffffffc0204eec:	89aa                	mv	s3,a0
ffffffffc0204eee:	04f50763          	beq	a0,a5,ffffffffc0204f3c <stride_enqueue+0x8e>
ffffffffc0204ef2:	12943823          	sd	s1,304(s0)
ffffffffc0204ef6:	0124b023          	sd	s2,0(s1)
ffffffffc0204efa:	12042783          	lw	a5,288(s0)
ffffffffc0204efe:	012a3c23          	sd	s2,24(s4)
ffffffffc0204f02:	014a2703          	lw	a4,20(s4)
ffffffffc0204f06:	c399                	beqz	a5,ffffffffc0204f0c <stride_enqueue+0x5e>
ffffffffc0204f08:	00f75463          	bge	a4,a5,ffffffffc0204f10 <stride_enqueue+0x62>
ffffffffc0204f0c:	12e42023          	sw	a4,288(s0)
ffffffffc0204f10:	010a2783          	lw	a5,16(s4)
ffffffffc0204f14:	70e6                	ld	ra,120(sp)
ffffffffc0204f16:	11443423          	sd	s4,264(s0)
ffffffffc0204f1a:	7446                	ld	s0,112(sp)
ffffffffc0204f1c:	2785                	addiw	a5,a5,1
ffffffffc0204f1e:	00fa2823          	sw	a5,16(s4)
ffffffffc0204f22:	74a6                	ld	s1,104(sp)
ffffffffc0204f24:	7906                	ld	s2,96(sp)
ffffffffc0204f26:	69e6                	ld	s3,88(sp)
ffffffffc0204f28:	6a46                	ld	s4,80(sp)
ffffffffc0204f2a:	6aa6                	ld	s5,72(sp)
ffffffffc0204f2c:	6b06                	ld	s6,64(sp)
ffffffffc0204f2e:	7be2                	ld	s7,56(sp)
ffffffffc0204f30:	7c42                	ld	s8,48(sp)
ffffffffc0204f32:	7ca2                	ld	s9,40(sp)
ffffffffc0204f34:	7d02                	ld	s10,32(sp)
ffffffffc0204f36:	6de2                	ld	s11,24(sp)
ffffffffc0204f38:	6109                	addi	sp,sp,128
ffffffffc0204f3a:	8082                	ret
ffffffffc0204f3c:	0104ba83          	ld	s5,16(s1)
ffffffffc0204f40:	0084bb83          	ld	s7,8(s1)
ffffffffc0204f44:	000a8d63          	beqz	s5,ffffffffc0204f5e <stride_enqueue+0xb0>
ffffffffc0204f48:	85ca                	mv	a1,s2
ffffffffc0204f4a:	8556                	mv	a0,s5
ffffffffc0204f4c:	ea3ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0204f50:	8b2a                	mv	s6,a0
ffffffffc0204f52:	01350e63          	beq	a0,s3,ffffffffc0204f6e <stride_enqueue+0xc0>
ffffffffc0204f56:	13543823          	sd	s5,304(s0)
ffffffffc0204f5a:	012ab023          	sd	s2,0(s5)
ffffffffc0204f5e:	0124b423          	sd	s2,8(s1)
ffffffffc0204f62:	0174b823          	sd	s7,16(s1)
ffffffffc0204f66:	00993023          	sd	s1,0(s2)
ffffffffc0204f6a:	8926                	mv	s2,s1
ffffffffc0204f6c:	b779                	j	ffffffffc0204efa <stride_enqueue+0x4c>
ffffffffc0204f6e:	010ab983          	ld	s3,16(s5)
ffffffffc0204f72:	008abc83          	ld	s9,8(s5)
ffffffffc0204f76:	00098d63          	beqz	s3,ffffffffc0204f90 <stride_enqueue+0xe2>
ffffffffc0204f7a:	85ca                	mv	a1,s2
ffffffffc0204f7c:	854e                	mv	a0,s3
ffffffffc0204f7e:	e71ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0204f82:	8c2a                	mv	s8,a0
ffffffffc0204f84:	01650e63          	beq	a0,s6,ffffffffc0204fa0 <stride_enqueue+0xf2>
ffffffffc0204f88:	13343823          	sd	s3,304(s0)
ffffffffc0204f8c:	0129b023          	sd	s2,0(s3)
ffffffffc0204f90:	012ab423          	sd	s2,8(s5)
ffffffffc0204f94:	019ab823          	sd	s9,16(s5)
ffffffffc0204f98:	01593023          	sd	s5,0(s2)
ffffffffc0204f9c:	8956                	mv	s2,s5
ffffffffc0204f9e:	b7c1                	j	ffffffffc0204f5e <stride_enqueue+0xb0>
ffffffffc0204fa0:	0109bb03          	ld	s6,16(s3)
ffffffffc0204fa4:	0089bd83          	ld	s11,8(s3)
ffffffffc0204fa8:	000b0d63          	beqz	s6,ffffffffc0204fc2 <stride_enqueue+0x114>
ffffffffc0204fac:	85ca                	mv	a1,s2
ffffffffc0204fae:	855a                	mv	a0,s6
ffffffffc0204fb0:	e3fff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0204fb4:	8d2a                	mv	s10,a0
ffffffffc0204fb6:	01850e63          	beq	a0,s8,ffffffffc0204fd2 <stride_enqueue+0x124>
ffffffffc0204fba:	13643823          	sd	s6,304(s0)
ffffffffc0204fbe:	012b3023          	sd	s2,0(s6)
ffffffffc0204fc2:	0129b423          	sd	s2,8(s3)
ffffffffc0204fc6:	01b9b823          	sd	s11,16(s3)
ffffffffc0204fca:	01393023          	sd	s3,0(s2)
ffffffffc0204fce:	894e                	mv	s2,s3
ffffffffc0204fd0:	b7c1                	j	ffffffffc0204f90 <stride_enqueue+0xe2>
ffffffffc0204fd2:	008b3783          	ld	a5,8(s6)
ffffffffc0204fd6:	010b3c03          	ld	s8,16(s6)
ffffffffc0204fda:	e43e                	sd	a5,8(sp)
ffffffffc0204fdc:	000c0c63          	beqz	s8,ffffffffc0204ff4 <stride_enqueue+0x146>
ffffffffc0204fe0:	85ca                	mv	a1,s2
ffffffffc0204fe2:	8562                	mv	a0,s8
ffffffffc0204fe4:	e0bff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0204fe8:	01a50f63          	beq	a0,s10,ffffffffc0205006 <stride_enqueue+0x158>
ffffffffc0204fec:	13843823          	sd	s8,304(s0)
ffffffffc0204ff0:	012c3023          	sd	s2,0(s8)
ffffffffc0204ff4:	67a2                	ld	a5,8(sp)
ffffffffc0204ff6:	012b3423          	sd	s2,8(s6)
ffffffffc0204ffa:	00fb3823          	sd	a5,16(s6)
ffffffffc0204ffe:	01693023          	sd	s6,0(s2)
ffffffffc0205002:	895a                	mv	s2,s6
ffffffffc0205004:	bf7d                	j	ffffffffc0204fc2 <stride_enqueue+0x114>
ffffffffc0205006:	010c3503          	ld	a0,16(s8)
ffffffffc020500a:	008c3d03          	ld	s10,8(s8)
ffffffffc020500e:	85ca                	mv	a1,s2
ffffffffc0205010:	e3bff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205014:	00ac3423          	sd	a0,8(s8)
ffffffffc0205018:	01ac3823          	sd	s10,16(s8)
ffffffffc020501c:	c509                	beqz	a0,ffffffffc0205026 <stride_enqueue+0x178>
ffffffffc020501e:	01853023          	sd	s8,0(a0)
ffffffffc0205022:	8962                	mv	s2,s8
ffffffffc0205024:	bfc1                	j	ffffffffc0204ff4 <stride_enqueue+0x146>
ffffffffc0205026:	8962                	mv	s2,s8
ffffffffc0205028:	b7f1                	j	ffffffffc0204ff4 <stride_enqueue+0x146>

ffffffffc020502a <stride_dequeue>:
ffffffffc020502a:	1085b783          	ld	a5,264(a1)
ffffffffc020502e:	7171                	addi	sp,sp,-176
ffffffffc0205030:	f506                	sd	ra,168(sp)
ffffffffc0205032:	f122                	sd	s0,160(sp)
ffffffffc0205034:	ed26                	sd	s1,152(sp)
ffffffffc0205036:	e94a                	sd	s2,144(sp)
ffffffffc0205038:	e54e                	sd	s3,136(sp)
ffffffffc020503a:	e152                	sd	s4,128(sp)
ffffffffc020503c:	fcd6                	sd	s5,120(sp)
ffffffffc020503e:	f8da                	sd	s6,112(sp)
ffffffffc0205040:	f4de                	sd	s7,104(sp)
ffffffffc0205042:	f0e2                	sd	s8,96(sp)
ffffffffc0205044:	ece6                	sd	s9,88(sp)
ffffffffc0205046:	e8ea                	sd	s10,80(sp)
ffffffffc0205048:	e4ee                	sd	s11,72(sp)
ffffffffc020504a:	00a78463          	beq	a5,a0,ffffffffc0205052 <stride_dequeue+0x28>
ffffffffc020504e:	7870106f          	j	ffffffffc0206fd4 <stride_dequeue+0x1faa>
ffffffffc0205052:	01052983          	lw	s3,16(a0)
ffffffffc0205056:	8c2a                	mv	s8,a0
ffffffffc0205058:	8b4e                	mv	s6,s3
ffffffffc020505a:	00099463          	bnez	s3,ffffffffc0205062 <stride_dequeue+0x38>
ffffffffc020505e:	7770106f          	j	ffffffffc0206fd4 <stride_dequeue+0x1faa>
ffffffffc0205062:	1305b903          	ld	s2,304(a1)
ffffffffc0205066:	01853a83          	ld	s5,24(a0)
ffffffffc020506a:	1285bd03          	ld	s10,296(a1)
ffffffffc020506e:	1385b483          	ld	s1,312(a1)
ffffffffc0205072:	842e                	mv	s0,a1
ffffffffc0205074:	2e090263          	beqz	s2,ffffffffc0205358 <stride_dequeue+0x32e>
ffffffffc0205078:	42048263          	beqz	s1,ffffffffc020549c <stride_dequeue+0x472>
ffffffffc020507c:	85a6                	mv	a1,s1
ffffffffc020507e:	854a                	mv	a0,s2
ffffffffc0205080:	d6fff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205084:	5cfd                	li	s9,-1
ffffffffc0205086:	8a2a                	mv	s4,a0
ffffffffc0205088:	19950163          	beq	a0,s9,ffffffffc020520a <stride_dequeue+0x1e0>
ffffffffc020508c:	0104ba03          	ld	s4,16(s1)
ffffffffc0205090:	0084bb83          	ld	s7,8(s1)
ffffffffc0205094:	120a0563          	beqz	s4,ffffffffc02051be <stride_dequeue+0x194>
ffffffffc0205098:	85d2                	mv	a1,s4
ffffffffc020509a:	854a                	mv	a0,s2
ffffffffc020509c:	d53ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02050a0:	2d950563          	beq	a0,s9,ffffffffc020536a <stride_dequeue+0x340>
ffffffffc02050a4:	008a3783          	ld	a5,8(s4)
ffffffffc02050a8:	010a3d83          	ld	s11,16(s4)
ffffffffc02050ac:	e03e                	sd	a5,0(sp)
ffffffffc02050ae:	100d8063          	beqz	s11,ffffffffc02051ae <stride_dequeue+0x184>
ffffffffc02050b2:	85ee                	mv	a1,s11
ffffffffc02050b4:	854a                	mv	a0,s2
ffffffffc02050b6:	d39ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02050ba:	7f950563          	beq	a0,s9,ffffffffc02058a4 <stride_dequeue+0x87a>
ffffffffc02050be:	008db783          	ld	a5,8(s11)
ffffffffc02050c2:	010dbc83          	ld	s9,16(s11)
ffffffffc02050c6:	e43e                	sd	a5,8(sp)
ffffffffc02050c8:	0c0c8b63          	beqz	s9,ffffffffc020519e <stride_dequeue+0x174>
ffffffffc02050cc:	85e6                	mv	a1,s9
ffffffffc02050ce:	854a                	mv	a0,s2
ffffffffc02050d0:	d1fff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02050d4:	58fd                	li	a7,-1
ffffffffc02050d6:	71150063          	beq	a0,a7,ffffffffc02057d6 <stride_dequeue+0x7ac>
ffffffffc02050da:	008cb783          	ld	a5,8(s9)
ffffffffc02050de:	010cb803          	ld	a6,16(s9)
ffffffffc02050e2:	e83e                	sd	a5,16(sp)
ffffffffc02050e4:	0a080563          	beqz	a6,ffffffffc020518e <stride_dequeue+0x164>
ffffffffc02050e8:	85c2                	mv	a1,a6
ffffffffc02050ea:	854a                	mv	a0,s2
ffffffffc02050ec:	ec42                	sd	a6,24(sp)
ffffffffc02050ee:	d01ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02050f2:	58fd                	li	a7,-1
ffffffffc02050f4:	6862                	ld	a6,24(sp)
ffffffffc02050f6:	41150be3          	beq	a0,a7,ffffffffc0205d0c <stride_dequeue+0xce2>
ffffffffc02050fa:	00883703          	ld	a4,8(a6) # fffffffffff80008 <end+0x3fd66930>
ffffffffc02050fe:	01083783          	ld	a5,16(a6)
ffffffffc0205102:	ec3a                	sd	a4,24(sp)
ffffffffc0205104:	cfad                	beqz	a5,ffffffffc020517e <stride_dequeue+0x154>
ffffffffc0205106:	85be                	mv	a1,a5
ffffffffc0205108:	854a                	mv	a0,s2
ffffffffc020510a:	f442                	sd	a6,40(sp)
ffffffffc020510c:	f03e                	sd	a5,32(sp)
ffffffffc020510e:	ce1ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205112:	58fd                	li	a7,-1
ffffffffc0205114:	7782                	ld	a5,32(sp)
ffffffffc0205116:	7822                	ld	a6,40(sp)
ffffffffc0205118:	01151463          	bne	a0,a7,ffffffffc0205120 <stride_dequeue+0xf6>
ffffffffc020511c:	17a0106f          	j	ffffffffc0206296 <stride_dequeue+0x126c>
ffffffffc0205120:	6798                	ld	a4,8(a5)
ffffffffc0205122:	0107bb03          	ld	s6,16(a5)
ffffffffc0205126:	f03a                	sd	a4,32(sp)
ffffffffc0205128:	040b0463          	beqz	s6,ffffffffc0205170 <stride_dequeue+0x146>
ffffffffc020512c:	85da                	mv	a1,s6
ffffffffc020512e:	854a                	mv	a0,s2
ffffffffc0205130:	f83e                	sd	a5,48(sp)
ffffffffc0205132:	f442                	sd	a6,40(sp)
ffffffffc0205134:	cbbff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205138:	58fd                	li	a7,-1
ffffffffc020513a:	7822                	ld	a6,40(sp)
ffffffffc020513c:	77c2                	ld	a5,48(sp)
ffffffffc020513e:	01151463          	bne	a0,a7,ffffffffc0205146 <stride_dequeue+0x11c>
ffffffffc0205142:	00d0106f          	j	ffffffffc020694e <stride_dequeue+0x1924>
ffffffffc0205146:	010b3583          	ld	a1,16(s6)
ffffffffc020514a:	008b3983          	ld	s3,8(s6)
ffffffffc020514e:	854a                	mv	a0,s2
ffffffffc0205150:	f83e                	sd	a5,48(sp)
ffffffffc0205152:	f442                	sd	a6,40(sp)
ffffffffc0205154:	cf7ff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205158:	00ab3423          	sd	a0,8(s6)
ffffffffc020515c:	013b3823          	sd	s3,16(s6)
ffffffffc0205160:	7822                	ld	a6,40(sp)
ffffffffc0205162:	77c2                	ld	a5,48(sp)
ffffffffc0205164:	010c2983          	lw	s3,16(s8)
ffffffffc0205168:	c119                	beqz	a0,ffffffffc020516e <stride_dequeue+0x144>
ffffffffc020516a:	01653023          	sd	s6,0(a0)
ffffffffc020516e:	895a                	mv	s2,s6
ffffffffc0205170:	7702                	ld	a4,32(sp)
ffffffffc0205172:	0127b423          	sd	s2,8(a5)
ffffffffc0205176:	eb98                	sd	a4,16(a5)
ffffffffc0205178:	00f93023          	sd	a5,0(s2)
ffffffffc020517c:	893e                	mv	s2,a5
ffffffffc020517e:	67e2                	ld	a5,24(sp)
ffffffffc0205180:	01283423          	sd	s2,8(a6)
ffffffffc0205184:	00f83823          	sd	a5,16(a6)
ffffffffc0205188:	01093023          	sd	a6,0(s2)
ffffffffc020518c:	8942                	mv	s2,a6
ffffffffc020518e:	67c2                	ld	a5,16(sp)
ffffffffc0205190:	012cb423          	sd	s2,8(s9)
ffffffffc0205194:	00fcb823          	sd	a5,16(s9)
ffffffffc0205198:	01993023          	sd	s9,0(s2)
ffffffffc020519c:	8966                	mv	s2,s9
ffffffffc020519e:	67a2                	ld	a5,8(sp)
ffffffffc02051a0:	012db423          	sd	s2,8(s11)
ffffffffc02051a4:	00fdb823          	sd	a5,16(s11)
ffffffffc02051a8:	01b93023          	sd	s11,0(s2)
ffffffffc02051ac:	896e                	mv	s2,s11
ffffffffc02051ae:	6782                	ld	a5,0(sp)
ffffffffc02051b0:	012a3423          	sd	s2,8(s4)
ffffffffc02051b4:	00fa3823          	sd	a5,16(s4)
ffffffffc02051b8:	01493023          	sd	s4,0(s2)
ffffffffc02051bc:	8952                	mv	s2,s4
ffffffffc02051be:	0124b423          	sd	s2,8(s1)
ffffffffc02051c2:	0174b823          	sd	s7,16(s1)
ffffffffc02051c6:	00993023          	sd	s1,0(s2)
ffffffffc02051ca:	01a4b023          	sd	s10,0(s1)
ffffffffc02051ce:	180d0963          	beqz	s10,ffffffffc0205360 <stride_dequeue+0x336>
ffffffffc02051d2:	008d3683          	ld	a3,8(s10)
ffffffffc02051d6:	12840413          	addi	s0,s0,296
ffffffffc02051da:	18868563          	beq	a3,s0,ffffffffc0205364 <stride_dequeue+0x33a>
ffffffffc02051de:	009d3823          	sd	s1,16(s10)
ffffffffc02051e2:	70aa                	ld	ra,168(sp)
ffffffffc02051e4:	740a                	ld	s0,160(sp)
ffffffffc02051e6:	39fd                	addiw	s3,s3,-1
ffffffffc02051e8:	015c3c23          	sd	s5,24(s8)
ffffffffc02051ec:	013c2823          	sw	s3,16(s8)
ffffffffc02051f0:	64ea                	ld	s1,152(sp)
ffffffffc02051f2:	694a                	ld	s2,144(sp)
ffffffffc02051f4:	69aa                	ld	s3,136(sp)
ffffffffc02051f6:	6a0a                	ld	s4,128(sp)
ffffffffc02051f8:	7ae6                	ld	s5,120(sp)
ffffffffc02051fa:	7b46                	ld	s6,112(sp)
ffffffffc02051fc:	7ba6                	ld	s7,104(sp)
ffffffffc02051fe:	7c06                	ld	s8,96(sp)
ffffffffc0205200:	6ce6                	ld	s9,88(sp)
ffffffffc0205202:	6d46                	ld	s10,80(sp)
ffffffffc0205204:	6da6                	ld	s11,72(sp)
ffffffffc0205206:	614d                	addi	sp,sp,176
ffffffffc0205208:	8082                	ret
ffffffffc020520a:	01093d83          	ld	s11,16(s2)
ffffffffc020520e:	00893b83          	ld	s7,8(s2)
ffffffffc0205212:	120d8963          	beqz	s11,ffffffffc0205344 <stride_dequeue+0x31a>
ffffffffc0205216:	85a6                	mv	a1,s1
ffffffffc0205218:	856e                	mv	a0,s11
ffffffffc020521a:	bd5ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc020521e:	29450363          	beq	a0,s4,ffffffffc02054a4 <stride_dequeue+0x47a>
ffffffffc0205222:	649c                	ld	a5,8(s1)
ffffffffc0205224:	0104bc83          	ld	s9,16(s1)
ffffffffc0205228:	e03e                	sd	a5,0(sp)
ffffffffc020522a:	100c8763          	beqz	s9,ffffffffc0205338 <stride_dequeue+0x30e>
ffffffffc020522e:	85e6                	mv	a1,s9
ffffffffc0205230:	856e                	mv	a0,s11
ffffffffc0205232:	bbdff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205236:	4b450263          	beq	a0,s4,ffffffffc02056da <stride_dequeue+0x6b0>
ffffffffc020523a:	008cb783          	ld	a5,8(s9)
ffffffffc020523e:	010cba03          	ld	s4,16(s9)
ffffffffc0205242:	e43e                	sd	a5,8(sp)
ffffffffc0205244:	0e0a0263          	beqz	s4,ffffffffc0205328 <stride_dequeue+0x2fe>
ffffffffc0205248:	85d2                	mv	a1,s4
ffffffffc020524a:	856e                	mv	a0,s11
ffffffffc020524c:	ba3ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205250:	58fd                	li	a7,-1
ffffffffc0205252:	03150fe3          	beq	a0,a7,ffffffffc0205a90 <stride_dequeue+0xa66>
ffffffffc0205256:	008a3783          	ld	a5,8(s4)
ffffffffc020525a:	010a3803          	ld	a6,16(s4)
ffffffffc020525e:	e83e                	sd	a5,16(sp)
ffffffffc0205260:	0a080c63          	beqz	a6,ffffffffc0205318 <stride_dequeue+0x2ee>
ffffffffc0205264:	85c2                	mv	a1,a6
ffffffffc0205266:	856e                	mv	a0,s11
ffffffffc0205268:	ec42                	sd	a6,24(sp)
ffffffffc020526a:	b85ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc020526e:	58fd                	li	a7,-1
ffffffffc0205270:	6862                	ld	a6,24(sp)
ffffffffc0205272:	01151463          	bne	a0,a7,ffffffffc020527a <stride_dequeue+0x250>
ffffffffc0205276:	6e10006f          	j	ffffffffc0206156 <stride_dequeue+0x112c>
ffffffffc020527a:	00883783          	ld	a5,8(a6)
ffffffffc020527e:	01083303          	ld	t1,16(a6)
ffffffffc0205282:	ec3e                	sd	a5,24(sp)
ffffffffc0205284:	08030263          	beqz	t1,ffffffffc0205308 <stride_dequeue+0x2de>
ffffffffc0205288:	859a                	mv	a1,t1
ffffffffc020528a:	856e                	mv	a0,s11
ffffffffc020528c:	f442                	sd	a6,40(sp)
ffffffffc020528e:	f01a                	sd	t1,32(sp)
ffffffffc0205290:	b5fff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205294:	58fd                	li	a7,-1
ffffffffc0205296:	7302                	ld	t1,32(sp)
ffffffffc0205298:	7822                	ld	a6,40(sp)
ffffffffc020529a:	01151463          	bne	a0,a7,ffffffffc02052a2 <stride_dequeue+0x278>
ffffffffc020529e:	5ee0106f          	j	ffffffffc020688c <stride_dequeue+0x1862>
ffffffffc02052a2:	00833783          	ld	a5,8(t1)
ffffffffc02052a6:	01033983          	ld	s3,16(t1)
ffffffffc02052aa:	f03e                	sd	a5,32(sp)
ffffffffc02052ac:	00099463          	bnez	s3,ffffffffc02052b4 <stride_dequeue+0x28a>
ffffffffc02052b0:	26f0106f          	j	ffffffffc0206d1e <stride_dequeue+0x1cf4>
ffffffffc02052b4:	85ce                	mv	a1,s3
ffffffffc02052b6:	856e                	mv	a0,s11
ffffffffc02052b8:	f842                	sd	a6,48(sp)
ffffffffc02052ba:	f41a                	sd	t1,40(sp)
ffffffffc02052bc:	b33ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02052c0:	58fd                	li	a7,-1
ffffffffc02052c2:	7322                	ld	t1,40(sp)
ffffffffc02052c4:	7842                	ld	a6,48(sp)
ffffffffc02052c6:	01151463          	bne	a0,a7,ffffffffc02052ce <stride_dequeue+0x2a4>
ffffffffc02052ca:	4d30106f          	j	ffffffffc0206f9c <stride_dequeue+0x1f72>
ffffffffc02052ce:	0109b583          	ld	a1,16(s3)
ffffffffc02052d2:	0089bb03          	ld	s6,8(s3)
ffffffffc02052d6:	856e                	mv	a0,s11
ffffffffc02052d8:	f842                	sd	a6,48(sp)
ffffffffc02052da:	f41a                	sd	t1,40(sp)
ffffffffc02052dc:	b6fff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02052e0:	00a9b423          	sd	a0,8(s3)
ffffffffc02052e4:	0169b823          	sd	s6,16(s3)
ffffffffc02052e8:	7322                	ld	t1,40(sp)
ffffffffc02052ea:	7842                	ld	a6,48(sp)
ffffffffc02052ec:	010c2b03          	lw	s6,16(s8)
ffffffffc02052f0:	c119                	beqz	a0,ffffffffc02052f6 <stride_dequeue+0x2cc>
ffffffffc02052f2:	01353023          	sd	s3,0(a0)
ffffffffc02052f6:	7782                	ld	a5,32(sp)
ffffffffc02052f8:	01333423          	sd	s3,8(t1)
ffffffffc02052fc:	8d9a                	mv	s11,t1
ffffffffc02052fe:	00f33823          	sd	a5,16(t1)
ffffffffc0205302:	0069b023          	sd	t1,0(s3)
ffffffffc0205306:	89da                	mv	s3,s6
ffffffffc0205308:	67e2                	ld	a5,24(sp)
ffffffffc020530a:	01b83423          	sd	s11,8(a6)
ffffffffc020530e:	00f83823          	sd	a5,16(a6)
ffffffffc0205312:	010db023          	sd	a6,0(s11)
ffffffffc0205316:	8dc2                	mv	s11,a6
ffffffffc0205318:	67c2                	ld	a5,16(sp)
ffffffffc020531a:	01ba3423          	sd	s11,8(s4)
ffffffffc020531e:	00fa3823          	sd	a5,16(s4)
ffffffffc0205322:	014db023          	sd	s4,0(s11)
ffffffffc0205326:	8dd2                	mv	s11,s4
ffffffffc0205328:	67a2                	ld	a5,8(sp)
ffffffffc020532a:	01bcb423          	sd	s11,8(s9)
ffffffffc020532e:	00fcb823          	sd	a5,16(s9)
ffffffffc0205332:	019db023          	sd	s9,0(s11)
ffffffffc0205336:	8de6                	mv	s11,s9
ffffffffc0205338:	6782                	ld	a5,0(sp)
ffffffffc020533a:	01b4b423          	sd	s11,8(s1)
ffffffffc020533e:	e89c                	sd	a5,16(s1)
ffffffffc0205340:	009db023          	sd	s1,0(s11)
ffffffffc0205344:	00993423          	sd	s1,8(s2)
ffffffffc0205348:	01793823          	sd	s7,16(s2)
ffffffffc020534c:	0124b023          	sd	s2,0(s1)
ffffffffc0205350:	84ca                	mv	s1,s2
ffffffffc0205352:	01a4b023          	sd	s10,0(s1)
ffffffffc0205356:	bda5                	j	ffffffffc02051ce <stride_dequeue+0x1a4>
ffffffffc0205358:	e60499e3          	bnez	s1,ffffffffc02051ca <stride_dequeue+0x1a0>
ffffffffc020535c:	e60d1be3          	bnez	s10,ffffffffc02051d2 <stride_dequeue+0x1a8>
ffffffffc0205360:	8aa6                	mv	s5,s1
ffffffffc0205362:	b541                	j	ffffffffc02051e2 <stride_dequeue+0x1b8>
ffffffffc0205364:	009d3423          	sd	s1,8(s10)
ffffffffc0205368:	bdad                	j	ffffffffc02051e2 <stride_dequeue+0x1b8>
ffffffffc020536a:	01093d83          	ld	s11,16(s2)
ffffffffc020536e:	e02a                	sd	a0,0(sp)
ffffffffc0205370:	00893c83          	ld	s9,8(s2)
ffffffffc0205374:	100d8d63          	beqz	s11,ffffffffc020548e <stride_dequeue+0x464>
ffffffffc0205378:	85d2                	mv	a1,s4
ffffffffc020537a:	856e                	mv	a0,s11
ffffffffc020537c:	a73ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205380:	6782                	ld	a5,0(sp)
ffffffffc0205382:	24f50563          	beq	a0,a5,ffffffffc02055cc <stride_dequeue+0x5a2>
ffffffffc0205386:	008a3783          	ld	a5,8(s4)
ffffffffc020538a:	010a3603          	ld	a2,16(s4)
ffffffffc020538e:	e03e                	sd	a5,0(sp)
ffffffffc0205390:	0e060863          	beqz	a2,ffffffffc0205480 <stride_dequeue+0x456>
ffffffffc0205394:	85b2                	mv	a1,a2
ffffffffc0205396:	856e                	mv	a0,s11
ffffffffc0205398:	e432                	sd	a2,8(sp)
ffffffffc020539a:	a55ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc020539e:	58fd                	li	a7,-1
ffffffffc02053a0:	6622                	ld	a2,8(sp)
ffffffffc02053a2:	7b150f63          	beq	a0,a7,ffffffffc0205b60 <stride_dequeue+0xb36>
ffffffffc02053a6:	661c                	ld	a5,8(a2)
ffffffffc02053a8:	01063803          	ld	a6,16(a2)
ffffffffc02053ac:	e43e                	sd	a5,8(sp)
ffffffffc02053ae:	0c080263          	beqz	a6,ffffffffc0205472 <stride_dequeue+0x448>
ffffffffc02053b2:	85c2                	mv	a1,a6
ffffffffc02053b4:	856e                	mv	a0,s11
ffffffffc02053b6:	ec32                	sd	a2,24(sp)
ffffffffc02053b8:	e842                	sd	a6,16(sp)
ffffffffc02053ba:	a35ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02053be:	58fd                	li	a7,-1
ffffffffc02053c0:	6842                	ld	a6,16(sp)
ffffffffc02053c2:	6662                	ld	a2,24(sp)
ffffffffc02053c4:	631507e3          	beq	a0,a7,ffffffffc02061f2 <stride_dequeue+0x11c8>
ffffffffc02053c8:	00883783          	ld	a5,8(a6)
ffffffffc02053cc:	01083303          	ld	t1,16(a6)
ffffffffc02053d0:	e83e                	sd	a5,16(sp)
ffffffffc02053d2:	08030863          	beqz	t1,ffffffffc0205462 <stride_dequeue+0x438>
ffffffffc02053d6:	859a                	mv	a1,t1
ffffffffc02053d8:	856e                	mv	a0,s11
ffffffffc02053da:	f442                	sd	a6,40(sp)
ffffffffc02053dc:	f032                	sd	a2,32(sp)
ffffffffc02053de:	ec1a                	sd	t1,24(sp)
ffffffffc02053e0:	a0fff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02053e4:	58fd                	li	a7,-1
ffffffffc02053e6:	6362                	ld	t1,24(sp)
ffffffffc02053e8:	7602                	ld	a2,32(sp)
ffffffffc02053ea:	7822                	ld	a6,40(sp)
ffffffffc02053ec:	01151463          	bne	a0,a7,ffffffffc02053f4 <stride_dequeue+0x3ca>
ffffffffc02053f0:	3d00106f          	j	ffffffffc02067c0 <stride_dequeue+0x1796>
ffffffffc02053f4:	00833783          	ld	a5,8(t1)
ffffffffc02053f8:	01033983          	ld	s3,16(t1)
ffffffffc02053fc:	ec3e                	sd	a5,24(sp)
ffffffffc02053fe:	00099463          	bnez	s3,ffffffffc0205406 <stride_dequeue+0x3dc>
ffffffffc0205402:	2af0106f          	j	ffffffffc0206eb0 <stride_dequeue+0x1e86>
ffffffffc0205406:	85ce                	mv	a1,s3
ffffffffc0205408:	856e                	mv	a0,s11
ffffffffc020540a:	f81a                	sd	t1,48(sp)
ffffffffc020540c:	f442                	sd	a6,40(sp)
ffffffffc020540e:	f032                	sd	a2,32(sp)
ffffffffc0205410:	9dfff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205414:	58fd                	li	a7,-1
ffffffffc0205416:	7602                	ld	a2,32(sp)
ffffffffc0205418:	7822                	ld	a6,40(sp)
ffffffffc020541a:	7342                	ld	t1,48(sp)
ffffffffc020541c:	01151463          	bne	a0,a7,ffffffffc0205424 <stride_dequeue+0x3fa>
ffffffffc0205420:	3510106f          	j	ffffffffc0206f70 <stride_dequeue+0x1f46>
ffffffffc0205424:	0109b583          	ld	a1,16(s3)
ffffffffc0205428:	0089bb03          	ld	s6,8(s3)
ffffffffc020542c:	856e                	mv	a0,s11
ffffffffc020542e:	f81a                	sd	t1,48(sp)
ffffffffc0205430:	f442                	sd	a6,40(sp)
ffffffffc0205432:	f032                	sd	a2,32(sp)
ffffffffc0205434:	a17ff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205438:	00a9b423          	sd	a0,8(s3)
ffffffffc020543c:	0169b823          	sd	s6,16(s3)
ffffffffc0205440:	7602                	ld	a2,32(sp)
ffffffffc0205442:	7822                	ld	a6,40(sp)
ffffffffc0205444:	7342                	ld	t1,48(sp)
ffffffffc0205446:	010c2b03          	lw	s6,16(s8)
ffffffffc020544a:	c119                	beqz	a0,ffffffffc0205450 <stride_dequeue+0x426>
ffffffffc020544c:	01353023          	sd	s3,0(a0)
ffffffffc0205450:	67e2                	ld	a5,24(sp)
ffffffffc0205452:	01333423          	sd	s3,8(t1)
ffffffffc0205456:	8d9a                	mv	s11,t1
ffffffffc0205458:	00f33823          	sd	a5,16(t1)
ffffffffc020545c:	0069b023          	sd	t1,0(s3)
ffffffffc0205460:	89da                	mv	s3,s6
ffffffffc0205462:	67c2                	ld	a5,16(sp)
ffffffffc0205464:	01b83423          	sd	s11,8(a6)
ffffffffc0205468:	00f83823          	sd	a5,16(a6)
ffffffffc020546c:	010db023          	sd	a6,0(s11)
ffffffffc0205470:	8dc2                	mv	s11,a6
ffffffffc0205472:	67a2                	ld	a5,8(sp)
ffffffffc0205474:	01b63423          	sd	s11,8(a2)
ffffffffc0205478:	ea1c                	sd	a5,16(a2)
ffffffffc020547a:	00cdb023          	sd	a2,0(s11)
ffffffffc020547e:	8db2                	mv	s11,a2
ffffffffc0205480:	6782                	ld	a5,0(sp)
ffffffffc0205482:	01ba3423          	sd	s11,8(s4)
ffffffffc0205486:	00fa3823          	sd	a5,16(s4)
ffffffffc020548a:	014db023          	sd	s4,0(s11)
ffffffffc020548e:	01493423          	sd	s4,8(s2)
ffffffffc0205492:	01993823          	sd	s9,16(s2)
ffffffffc0205496:	012a3023          	sd	s2,0(s4)
ffffffffc020549a:	b315                	j	ffffffffc02051be <stride_dequeue+0x194>
ffffffffc020549c:	84ca                	mv	s1,s2
ffffffffc020549e:	01a4b023          	sd	s10,0(s1)
ffffffffc02054a2:	b335                	j	ffffffffc02051ce <stride_dequeue+0x1a4>
ffffffffc02054a4:	008db783          	ld	a5,8(s11)
ffffffffc02054a8:	010dbc83          	ld	s9,16(s11)
ffffffffc02054ac:	e42a                	sd	a0,8(sp)
ffffffffc02054ae:	e03e                	sd	a5,0(sp)
ffffffffc02054b0:	100c8563          	beqz	s9,ffffffffc02055ba <stride_dequeue+0x590>
ffffffffc02054b4:	85a6                	mv	a1,s1
ffffffffc02054b6:	8566                	mv	a0,s9
ffffffffc02054b8:	937ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02054bc:	67a2                	ld	a5,8(sp)
ffffffffc02054be:	4cf50e63          	beq	a0,a5,ffffffffc020599a <stride_dequeue+0x970>
ffffffffc02054c2:	649c                	ld	a5,8(s1)
ffffffffc02054c4:	0104ba03          	ld	s4,16(s1)
ffffffffc02054c8:	e43e                	sd	a5,8(sp)
ffffffffc02054ca:	0e0a0263          	beqz	s4,ffffffffc02055ae <stride_dequeue+0x584>
ffffffffc02054ce:	85d2                	mv	a1,s4
ffffffffc02054d0:	8566                	mv	a0,s9
ffffffffc02054d2:	91dff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02054d6:	58fd                	li	a7,-1
ffffffffc02054d8:	0d1505e3          	beq	a0,a7,ffffffffc0205da2 <stride_dequeue+0xd78>
ffffffffc02054dc:	008a3783          	ld	a5,8(s4)
ffffffffc02054e0:	010a3803          	ld	a6,16(s4)
ffffffffc02054e4:	e83e                	sd	a5,16(sp)
ffffffffc02054e6:	0a080c63          	beqz	a6,ffffffffc020559e <stride_dequeue+0x574>
ffffffffc02054ea:	85c2                	mv	a1,a6
ffffffffc02054ec:	8566                	mv	a0,s9
ffffffffc02054ee:	ec42                	sd	a6,24(sp)
ffffffffc02054f0:	8ffff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02054f4:	58fd                	li	a7,-1
ffffffffc02054f6:	6862                	ld	a6,24(sp)
ffffffffc02054f8:	01151463          	bne	a0,a7,ffffffffc0205500 <stride_dequeue+0x4d6>
ffffffffc02054fc:	07c0106f          	j	ffffffffc0206578 <stride_dequeue+0x154e>
ffffffffc0205500:	00883783          	ld	a5,8(a6)
ffffffffc0205504:	01083983          	ld	s3,16(a6)
ffffffffc0205508:	ec3e                	sd	a5,24(sp)
ffffffffc020550a:	00099463          	bnez	s3,ffffffffc0205512 <stride_dequeue+0x4e8>
ffffffffc020550e:	2bb0106f          	j	ffffffffc0206fc8 <stride_dequeue+0x1f9e>
ffffffffc0205512:	85ce                	mv	a1,s3
ffffffffc0205514:	8566                	mv	a0,s9
ffffffffc0205516:	f042                	sd	a6,32(sp)
ffffffffc0205518:	8d7ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc020551c:	58fd                	li	a7,-1
ffffffffc020551e:	7802                	ld	a6,32(sp)
ffffffffc0205520:	01151463          	bne	a0,a7,ffffffffc0205528 <stride_dequeue+0x4fe>
ffffffffc0205524:	05f0106f          	j	ffffffffc0206d82 <stride_dequeue+0x1d58>
ffffffffc0205528:	0089b783          	ld	a5,8(s3)
ffffffffc020552c:	0109be03          	ld	t3,16(s3)
ffffffffc0205530:	f03e                	sd	a5,32(sp)
ffffffffc0205532:	040e0663          	beqz	t3,ffffffffc020557e <stride_dequeue+0x554>
ffffffffc0205536:	85f2                	mv	a1,t3
ffffffffc0205538:	8566                	mv	a0,s9
ffffffffc020553a:	f842                	sd	a6,48(sp)
ffffffffc020553c:	f472                	sd	t3,40(sp)
ffffffffc020553e:	8b1ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205542:	58fd                	li	a7,-1
ffffffffc0205544:	7e22                	ld	t3,40(sp)
ffffffffc0205546:	7842                	ld	a6,48(sp)
ffffffffc0205548:	01151463          	bne	a0,a7,ffffffffc0205550 <stride_dequeue+0x526>
ffffffffc020554c:	4e70106f          	j	ffffffffc0207232 <stride_dequeue+0x2208>
ffffffffc0205550:	010e3583          	ld	a1,16(t3)
ffffffffc0205554:	8566                	mv	a0,s9
ffffffffc0205556:	008e3b03          	ld	s6,8(t3)
ffffffffc020555a:	f842                	sd	a6,48(sp)
ffffffffc020555c:	f472                	sd	t3,40(sp)
ffffffffc020555e:	8edff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205562:	7e22                	ld	t3,40(sp)
ffffffffc0205564:	7842                	ld	a6,48(sp)
ffffffffc0205566:	016e3823          	sd	s6,16(t3)
ffffffffc020556a:	00ae3423          	sd	a0,8(t3)
ffffffffc020556e:	010c2b03          	lw	s6,16(s8)
ffffffffc0205572:	e119                	bnez	a0,ffffffffc0205578 <stride_dequeue+0x54e>
ffffffffc0205574:	7bb0106f          	j	ffffffffc020752e <stride_dequeue+0x2504>
ffffffffc0205578:	01c53023          	sd	t3,0(a0)
ffffffffc020557c:	8cf2                	mv	s9,t3
ffffffffc020557e:	7782                	ld	a5,32(sp)
ffffffffc0205580:	0199b423          	sd	s9,8(s3)
ffffffffc0205584:	00f9b823          	sd	a5,16(s3)
ffffffffc0205588:	013cb023          	sd	s3,0(s9)
ffffffffc020558c:	67e2                	ld	a5,24(sp)
ffffffffc020558e:	01383423          	sd	s3,8(a6)
ffffffffc0205592:	8cc2                	mv	s9,a6
ffffffffc0205594:	00f83823          	sd	a5,16(a6)
ffffffffc0205598:	0109b023          	sd	a6,0(s3)
ffffffffc020559c:	89da                	mv	s3,s6
ffffffffc020559e:	67c2                	ld	a5,16(sp)
ffffffffc02055a0:	019a3423          	sd	s9,8(s4)
ffffffffc02055a4:	00fa3823          	sd	a5,16(s4)
ffffffffc02055a8:	014cb023          	sd	s4,0(s9)
ffffffffc02055ac:	8cd2                	mv	s9,s4
ffffffffc02055ae:	67a2                	ld	a5,8(sp)
ffffffffc02055b0:	0194b423          	sd	s9,8(s1)
ffffffffc02055b4:	e89c                	sd	a5,16(s1)
ffffffffc02055b6:	009cb023          	sd	s1,0(s9)
ffffffffc02055ba:	6782                	ld	a5,0(sp)
ffffffffc02055bc:	009db423          	sd	s1,8(s11)
ffffffffc02055c0:	00fdb823          	sd	a5,16(s11)
ffffffffc02055c4:	01b4b023          	sd	s11,0(s1)
ffffffffc02055c8:	84ee                	mv	s1,s11
ffffffffc02055ca:	bbad                	j	ffffffffc0205344 <stride_dequeue+0x31a>
ffffffffc02055cc:	008db783          	ld	a5,8(s11)
ffffffffc02055d0:	010db603          	ld	a2,16(s11)
ffffffffc02055d4:	e03e                	sd	a5,0(sp)
ffffffffc02055d6:	0e060963          	beqz	a2,ffffffffc02056c8 <stride_dequeue+0x69e>
ffffffffc02055da:	8532                	mv	a0,a2
ffffffffc02055dc:	85d2                	mv	a1,s4
ffffffffc02055de:	e432                	sd	a2,8(sp)
ffffffffc02055e0:	80fff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02055e4:	58fd                	li	a7,-1
ffffffffc02055e6:	6622                	ld	a2,8(sp)
ffffffffc02055e8:	091504e3          	beq	a0,a7,ffffffffc0205e70 <stride_dequeue+0xe46>
ffffffffc02055ec:	008a3783          	ld	a5,8(s4)
ffffffffc02055f0:	010a3803          	ld	a6,16(s4)
ffffffffc02055f4:	e43e                	sd	a5,8(sp)
ffffffffc02055f6:	0c080263          	beqz	a6,ffffffffc02056ba <stride_dequeue+0x690>
ffffffffc02055fa:	85c2                	mv	a1,a6
ffffffffc02055fc:	8532                	mv	a0,a2
ffffffffc02055fe:	ec42                	sd	a6,24(sp)
ffffffffc0205600:	e832                	sd	a2,16(sp)
ffffffffc0205602:	fecff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205606:	58fd                	li	a7,-1
ffffffffc0205608:	6642                	ld	a2,16(sp)
ffffffffc020560a:	6862                	ld	a6,24(sp)
ffffffffc020560c:	01151463          	bne	a0,a7,ffffffffc0205614 <stride_dequeue+0x5ea>
ffffffffc0205610:	00a0106f          	j	ffffffffc020661a <stride_dequeue+0x15f0>
ffffffffc0205614:	00883783          	ld	a5,8(a6)
ffffffffc0205618:	01083983          	ld	s3,16(a6)
ffffffffc020561c:	e83e                	sd	a5,16(sp)
ffffffffc020561e:	00099463          	bnez	s3,ffffffffc0205626 <stride_dequeue+0x5fc>
ffffffffc0205622:	1e50106f          	j	ffffffffc0207006 <stride_dequeue+0x1fdc>
ffffffffc0205626:	8532                	mv	a0,a2
ffffffffc0205628:	85ce                	mv	a1,s3
ffffffffc020562a:	f042                	sd	a6,32(sp)
ffffffffc020562c:	ec32                	sd	a2,24(sp)
ffffffffc020562e:	fc0ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205632:	58fd                	li	a7,-1
ffffffffc0205634:	6662                	ld	a2,24(sp)
ffffffffc0205636:	7802                	ld	a6,32(sp)
ffffffffc0205638:	01151463          	bne	a0,a7,ffffffffc0205640 <stride_dequeue+0x616>
ffffffffc020563c:	4fc0106f          	j	ffffffffc0206b38 <stride_dequeue+0x1b0e>
ffffffffc0205640:	0089b783          	ld	a5,8(s3)
ffffffffc0205644:	0109be03          	ld	t3,16(s3)
ffffffffc0205648:	ec3e                	sd	a5,24(sp)
ffffffffc020564a:	040e0863          	beqz	t3,ffffffffc020569a <stride_dequeue+0x670>
ffffffffc020564e:	85f2                	mv	a1,t3
ffffffffc0205650:	8532                	mv	a0,a2
ffffffffc0205652:	f842                	sd	a6,48(sp)
ffffffffc0205654:	f472                	sd	t3,40(sp)
ffffffffc0205656:	f032                	sd	a2,32(sp)
ffffffffc0205658:	f96ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc020565c:	7842                	ld	a6,48(sp)
ffffffffc020565e:	7e22                	ld	t3,40(sp)
ffffffffc0205660:	58fd                	li	a7,-1
ffffffffc0205662:	f442                	sd	a6,40(sp)
ffffffffc0205664:	7602                	ld	a2,32(sp)
ffffffffc0205666:	01151463          	bne	a0,a7,ffffffffc020566e <stride_dequeue+0x644>
ffffffffc020566a:	37b0106f          	j	ffffffffc02071e4 <stride_dequeue+0x21ba>
ffffffffc020566e:	010e3583          	ld	a1,16(t3)
ffffffffc0205672:	8532                	mv	a0,a2
ffffffffc0205674:	008e3b03          	ld	s6,8(t3)
ffffffffc0205678:	f072                	sd	t3,32(sp)
ffffffffc020567a:	fd0ff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020567e:	7e02                	ld	t3,32(sp)
ffffffffc0205680:	7822                	ld	a6,40(sp)
ffffffffc0205682:	016e3823          	sd	s6,16(t3)
ffffffffc0205686:	00ae3423          	sd	a0,8(t3)
ffffffffc020568a:	010c2b03          	lw	s6,16(s8)
ffffffffc020568e:	e119                	bnez	a0,ffffffffc0205694 <stride_dequeue+0x66a>
ffffffffc0205690:	7090106f          	j	ffffffffc0207598 <stride_dequeue+0x256e>
ffffffffc0205694:	01c53023          	sd	t3,0(a0)
ffffffffc0205698:	8672                	mv	a2,t3
ffffffffc020569a:	67e2                	ld	a5,24(sp)
ffffffffc020569c:	00c9b423          	sd	a2,8(s3)
ffffffffc02056a0:	00f9b823          	sd	a5,16(s3)
ffffffffc02056a4:	01363023          	sd	s3,0(a2)
ffffffffc02056a8:	67c2                	ld	a5,16(sp)
ffffffffc02056aa:	01383423          	sd	s3,8(a6)
ffffffffc02056ae:	8642                	mv	a2,a6
ffffffffc02056b0:	00f83823          	sd	a5,16(a6)
ffffffffc02056b4:	0109b023          	sd	a6,0(s3)
ffffffffc02056b8:	89da                	mv	s3,s6
ffffffffc02056ba:	67a2                	ld	a5,8(sp)
ffffffffc02056bc:	00ca3423          	sd	a2,8(s4)
ffffffffc02056c0:	00fa3823          	sd	a5,16(s4)
ffffffffc02056c4:	01463023          	sd	s4,0(a2)
ffffffffc02056c8:	6782                	ld	a5,0(sp)
ffffffffc02056ca:	014db423          	sd	s4,8(s11)
ffffffffc02056ce:	00fdb823          	sd	a5,16(s11)
ffffffffc02056d2:	01ba3023          	sd	s11,0(s4)
ffffffffc02056d6:	8a6e                	mv	s4,s11
ffffffffc02056d8:	bb5d                	j	ffffffffc020548e <stride_dequeue+0x464>
ffffffffc02056da:	008db783          	ld	a5,8(s11)
ffffffffc02056de:	010dba03          	ld	s4,16(s11)
ffffffffc02056e2:	e43e                	sd	a5,8(sp)
ffffffffc02056e4:	0e0a0163          	beqz	s4,ffffffffc02057c6 <stride_dequeue+0x79c>
ffffffffc02056e8:	85e6                	mv	a1,s9
ffffffffc02056ea:	8552                	mv	a0,s4
ffffffffc02056ec:	f02ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02056f0:	58fd                	li	a7,-1
ffffffffc02056f2:	05150de3          	beq	a0,a7,ffffffffc0205f4c <stride_dequeue+0xf22>
ffffffffc02056f6:	008cb783          	ld	a5,8(s9)
ffffffffc02056fa:	010cb803          	ld	a6,16(s9)
ffffffffc02056fe:	e83e                	sd	a5,16(sp)
ffffffffc0205700:	0a080c63          	beqz	a6,ffffffffc02057b8 <stride_dequeue+0x78e>
ffffffffc0205704:	85c2                	mv	a1,a6
ffffffffc0205706:	8552                	mv	a0,s4
ffffffffc0205708:	ec42                	sd	a6,24(sp)
ffffffffc020570a:	ee4ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc020570e:	58fd                	li	a7,-1
ffffffffc0205710:	6862                	ld	a6,24(sp)
ffffffffc0205712:	01151463          	bne	a0,a7,ffffffffc020571a <stride_dequeue+0x6f0>
ffffffffc0205716:	7ab0006f          	j	ffffffffc02066c0 <stride_dequeue+0x1696>
ffffffffc020571a:	00883783          	ld	a5,8(a6)
ffffffffc020571e:	01083983          	ld	s3,16(a6)
ffffffffc0205722:	ec3e                	sd	a5,24(sp)
ffffffffc0205724:	00099463          	bnez	s3,ffffffffc020572c <stride_dequeue+0x702>
ffffffffc0205728:	0cd0106f          	j	ffffffffc0206ff4 <stride_dequeue+0x1fca>
ffffffffc020572c:	85ce                	mv	a1,s3
ffffffffc020572e:	8552                	mv	a0,s4
ffffffffc0205730:	f042                	sd	a6,32(sp)
ffffffffc0205732:	ebcff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205736:	58fd                	li	a7,-1
ffffffffc0205738:	7802                	ld	a6,32(sp)
ffffffffc020573a:	01151463          	bne	a0,a7,ffffffffc0205742 <stride_dequeue+0x718>
ffffffffc020573e:	39c0106f          	j	ffffffffc0206ada <stride_dequeue+0x1ab0>
ffffffffc0205742:	0089b783          	ld	a5,8(s3)
ffffffffc0205746:	0109be03          	ld	t3,16(s3)
ffffffffc020574a:	f03e                	sd	a5,32(sp)
ffffffffc020574c:	040e0663          	beqz	t3,ffffffffc0205798 <stride_dequeue+0x76e>
ffffffffc0205750:	85f2                	mv	a1,t3
ffffffffc0205752:	8552                	mv	a0,s4
ffffffffc0205754:	f842                	sd	a6,48(sp)
ffffffffc0205756:	f472                	sd	t3,40(sp)
ffffffffc0205758:	e96ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc020575c:	58fd                	li	a7,-1
ffffffffc020575e:	7e22                	ld	t3,40(sp)
ffffffffc0205760:	7842                	ld	a6,48(sp)
ffffffffc0205762:	01151463          	bne	a0,a7,ffffffffc020576a <stride_dequeue+0x740>
ffffffffc0205766:	2f90106f          	j	ffffffffc020725e <stride_dequeue+0x2234>
ffffffffc020576a:	010e3583          	ld	a1,16(t3)
ffffffffc020576e:	8552                	mv	a0,s4
ffffffffc0205770:	008e3b03          	ld	s6,8(t3)
ffffffffc0205774:	f842                	sd	a6,48(sp)
ffffffffc0205776:	f472                	sd	t3,40(sp)
ffffffffc0205778:	ed2ff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020577c:	7e22                	ld	t3,40(sp)
ffffffffc020577e:	7842                	ld	a6,48(sp)
ffffffffc0205780:	016e3823          	sd	s6,16(t3)
ffffffffc0205784:	00ae3423          	sd	a0,8(t3)
ffffffffc0205788:	010c2b03          	lw	s6,16(s8)
ffffffffc020578c:	e119                	bnez	a0,ffffffffc0205792 <stride_dequeue+0x768>
ffffffffc020578e:	5a70106f          	j	ffffffffc0207534 <stride_dequeue+0x250a>
ffffffffc0205792:	01c53023          	sd	t3,0(a0)
ffffffffc0205796:	8a72                	mv	s4,t3
ffffffffc0205798:	7782                	ld	a5,32(sp)
ffffffffc020579a:	0149b423          	sd	s4,8(s3)
ffffffffc020579e:	00f9b823          	sd	a5,16(s3)
ffffffffc02057a2:	013a3023          	sd	s3,0(s4)
ffffffffc02057a6:	67e2                	ld	a5,24(sp)
ffffffffc02057a8:	01383423          	sd	s3,8(a6)
ffffffffc02057ac:	8a42                	mv	s4,a6
ffffffffc02057ae:	00f83823          	sd	a5,16(a6)
ffffffffc02057b2:	0109b023          	sd	a6,0(s3)
ffffffffc02057b6:	89da                	mv	s3,s6
ffffffffc02057b8:	67c2                	ld	a5,16(sp)
ffffffffc02057ba:	014cb423          	sd	s4,8(s9)
ffffffffc02057be:	00fcb823          	sd	a5,16(s9)
ffffffffc02057c2:	019a3023          	sd	s9,0(s4)
ffffffffc02057c6:	67a2                	ld	a5,8(sp)
ffffffffc02057c8:	019db423          	sd	s9,8(s11)
ffffffffc02057cc:	00fdb823          	sd	a5,16(s11)
ffffffffc02057d0:	01bcb023          	sd	s11,0(s9)
ffffffffc02057d4:	b695                	j	ffffffffc0205338 <stride_dequeue+0x30e>
ffffffffc02057d6:	00893783          	ld	a5,8(s2)
ffffffffc02057da:	01093883          	ld	a7,16(s2)
ffffffffc02057de:	ec2a                	sd	a0,24(sp)
ffffffffc02057e0:	e83e                	sd	a5,16(sp)
ffffffffc02057e2:	0a088963          	beqz	a7,ffffffffc0205894 <stride_dequeue+0x86a>
ffffffffc02057e6:	8546                	mv	a0,a7
ffffffffc02057e8:	85e6                	mv	a1,s9
ffffffffc02057ea:	f046                	sd	a7,32(sp)
ffffffffc02057ec:	e02ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02057f0:	6862                	ld	a6,24(sp)
ffffffffc02057f2:	7882                	ld	a7,32(sp)
ffffffffc02057f4:	030504e3          	beq	a0,a6,ffffffffc020601c <stride_dequeue+0xff2>
ffffffffc02057f8:	008cb783          	ld	a5,8(s9)
ffffffffc02057fc:	010cb303          	ld	t1,16(s9)
ffffffffc0205800:	f042                	sd	a6,32(sp)
ffffffffc0205802:	ec3e                	sd	a5,24(sp)
ffffffffc0205804:	08030163          	beqz	t1,ffffffffc0205886 <stride_dequeue+0x85c>
ffffffffc0205808:	859a                	mv	a1,t1
ffffffffc020580a:	8546                	mv	a0,a7
ffffffffc020580c:	f81a                	sd	t1,48(sp)
ffffffffc020580e:	f446                	sd	a7,40(sp)
ffffffffc0205810:	ddeff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205814:	7802                	ld	a6,32(sp)
ffffffffc0205816:	78a2                	ld	a7,40(sp)
ffffffffc0205818:	7342                	ld	t1,48(sp)
ffffffffc020581a:	01051463          	bne	a0,a6,ffffffffc0205822 <stride_dequeue+0x7f8>
ffffffffc020581e:	0d00106f          	j	ffffffffc02068ee <stride_dequeue+0x18c4>
ffffffffc0205822:	00833783          	ld	a5,8(t1)
ffffffffc0205826:	01033983          	ld	s3,16(t1)
ffffffffc020582a:	f442                	sd	a6,40(sp)
ffffffffc020582c:	f03e                	sd	a5,32(sp)
ffffffffc020582e:	00099463          	bnez	s3,ffffffffc0205836 <stride_dequeue+0x80c>
ffffffffc0205832:	6720106f          	j	ffffffffc0206ea4 <stride_dequeue+0x1e7a>
ffffffffc0205836:	8546                	mv	a0,a7
ffffffffc0205838:	85ce                	mv	a1,s3
ffffffffc020583a:	fc1a                	sd	t1,56(sp)
ffffffffc020583c:	f846                	sd	a7,48(sp)
ffffffffc020583e:	db0ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205842:	7822                	ld	a6,40(sp)
ffffffffc0205844:	78c2                	ld	a7,48(sp)
ffffffffc0205846:	7362                	ld	t1,56(sp)
ffffffffc0205848:	01051463          	bne	a0,a6,ffffffffc0205850 <stride_dequeue+0x826>
ffffffffc020584c:	6700106f          	j	ffffffffc0206ebc <stride_dequeue+0x1e92>
ffffffffc0205850:	0109b583          	ld	a1,16(s3)
ffffffffc0205854:	0089bb03          	ld	s6,8(s3)
ffffffffc0205858:	8546                	mv	a0,a7
ffffffffc020585a:	f41a                	sd	t1,40(sp)
ffffffffc020585c:	deeff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205860:	00a9b423          	sd	a0,8(s3)
ffffffffc0205864:	0169b823          	sd	s6,16(s3)
ffffffffc0205868:	7322                	ld	t1,40(sp)
ffffffffc020586a:	010c2b03          	lw	s6,16(s8)
ffffffffc020586e:	c119                	beqz	a0,ffffffffc0205874 <stride_dequeue+0x84a>
ffffffffc0205870:	01353023          	sd	s3,0(a0)
ffffffffc0205874:	7782                	ld	a5,32(sp)
ffffffffc0205876:	01333423          	sd	s3,8(t1)
ffffffffc020587a:	889a                	mv	a7,t1
ffffffffc020587c:	00f33823          	sd	a5,16(t1)
ffffffffc0205880:	0069b023          	sd	t1,0(s3)
ffffffffc0205884:	89da                	mv	s3,s6
ffffffffc0205886:	67e2                	ld	a5,24(sp)
ffffffffc0205888:	011cb423          	sd	a7,8(s9)
ffffffffc020588c:	00fcb823          	sd	a5,16(s9)
ffffffffc0205890:	0198b023          	sd	s9,0(a7)
ffffffffc0205894:	67c2                	ld	a5,16(sp)
ffffffffc0205896:	01993423          	sd	s9,8(s2)
ffffffffc020589a:	00f93823          	sd	a5,16(s2)
ffffffffc020589e:	012cb023          	sd	s2,0(s9)
ffffffffc02058a2:	b8f5                	j	ffffffffc020519e <stride_dequeue+0x174>
ffffffffc02058a4:	00893783          	ld	a5,8(s2)
ffffffffc02058a8:	01093c83          	ld	s9,16(s2)
ffffffffc02058ac:	e43e                	sd	a5,8(sp)
ffffffffc02058ae:	0c0c8d63          	beqz	s9,ffffffffc0205988 <stride_dequeue+0x95e>
ffffffffc02058b2:	85ee                	mv	a1,s11
ffffffffc02058b4:	8566                	mv	a0,s9
ffffffffc02058b6:	d38ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02058ba:	58fd                	li	a7,-1
ffffffffc02058bc:	39150063          	beq	a0,a7,ffffffffc0205c3c <stride_dequeue+0xc12>
ffffffffc02058c0:	008db783          	ld	a5,8(s11)
ffffffffc02058c4:	010db803          	ld	a6,16(s11)
ffffffffc02058c8:	e83e                	sd	a5,16(sp)
ffffffffc02058ca:	0a080863          	beqz	a6,ffffffffc020597a <stride_dequeue+0x950>
ffffffffc02058ce:	85c2                	mv	a1,a6
ffffffffc02058d0:	8566                	mv	a0,s9
ffffffffc02058d2:	ec42                	sd	a6,24(sp)
ffffffffc02058d4:	d1aff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02058d8:	58fd                	li	a7,-1
ffffffffc02058da:	6862                	ld	a6,24(sp)
ffffffffc02058dc:	7d150f63          	beq	a0,a7,ffffffffc02060ba <stride_dequeue+0x1090>
ffffffffc02058e0:	00883783          	ld	a5,8(a6)
ffffffffc02058e4:	01083303          	ld	t1,16(a6)
ffffffffc02058e8:	ec3e                	sd	a5,24(sp)
ffffffffc02058ea:	08030063          	beqz	t1,ffffffffc020596a <stride_dequeue+0x940>
ffffffffc02058ee:	859a                	mv	a1,t1
ffffffffc02058f0:	8566                	mv	a0,s9
ffffffffc02058f2:	f442                	sd	a6,40(sp)
ffffffffc02058f4:	f01a                	sd	t1,32(sp)
ffffffffc02058f6:	cf8ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02058fa:	58fd                	li	a7,-1
ffffffffc02058fc:	7302                	ld	t1,32(sp)
ffffffffc02058fe:	7822                	ld	a6,40(sp)
ffffffffc0205900:	65150fe3          	beq	a0,a7,ffffffffc020675e <stride_dequeue+0x1734>
ffffffffc0205904:	00833783          	ld	a5,8(t1)
ffffffffc0205908:	01033983          	ld	s3,16(t1)
ffffffffc020590c:	f03e                	sd	a5,32(sp)
ffffffffc020590e:	00099463          	bnez	s3,ffffffffc0205916 <stride_dequeue+0x8ec>
ffffffffc0205912:	5980106f          	j	ffffffffc0206eaa <stride_dequeue+0x1e80>
ffffffffc0205916:	85ce                	mv	a1,s3
ffffffffc0205918:	8566                	mv	a0,s9
ffffffffc020591a:	f81a                	sd	t1,48(sp)
ffffffffc020591c:	f442                	sd	a6,40(sp)
ffffffffc020591e:	cd0ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205922:	58fd                	li	a7,-1
ffffffffc0205924:	7822                	ld	a6,40(sp)
ffffffffc0205926:	7342                	ld	t1,48(sp)
ffffffffc0205928:	01151463          	bne	a0,a7,ffffffffc0205930 <stride_dequeue+0x906>
ffffffffc020592c:	5ea0106f          	j	ffffffffc0206f16 <stride_dequeue+0x1eec>
ffffffffc0205930:	0109b583          	ld	a1,16(s3)
ffffffffc0205934:	0089bb03          	ld	s6,8(s3)
ffffffffc0205938:	8566                	mv	a0,s9
ffffffffc020593a:	f81a                	sd	t1,48(sp)
ffffffffc020593c:	f442                	sd	a6,40(sp)
ffffffffc020593e:	d0cff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205942:	00a9b423          	sd	a0,8(s3)
ffffffffc0205946:	0169b823          	sd	s6,16(s3)
ffffffffc020594a:	7822                	ld	a6,40(sp)
ffffffffc020594c:	7342                	ld	t1,48(sp)
ffffffffc020594e:	010c2b03          	lw	s6,16(s8)
ffffffffc0205952:	c119                	beqz	a0,ffffffffc0205958 <stride_dequeue+0x92e>
ffffffffc0205954:	01353023          	sd	s3,0(a0)
ffffffffc0205958:	7782                	ld	a5,32(sp)
ffffffffc020595a:	01333423          	sd	s3,8(t1)
ffffffffc020595e:	8c9a                	mv	s9,t1
ffffffffc0205960:	00f33823          	sd	a5,16(t1)
ffffffffc0205964:	0069b023          	sd	t1,0(s3)
ffffffffc0205968:	89da                	mv	s3,s6
ffffffffc020596a:	67e2                	ld	a5,24(sp)
ffffffffc020596c:	01983423          	sd	s9,8(a6)
ffffffffc0205970:	00f83823          	sd	a5,16(a6)
ffffffffc0205974:	010cb023          	sd	a6,0(s9)
ffffffffc0205978:	8cc2                	mv	s9,a6
ffffffffc020597a:	67c2                	ld	a5,16(sp)
ffffffffc020597c:	019db423          	sd	s9,8(s11)
ffffffffc0205980:	00fdb823          	sd	a5,16(s11)
ffffffffc0205984:	01bcb023          	sd	s11,0(s9)
ffffffffc0205988:	67a2                	ld	a5,8(sp)
ffffffffc020598a:	01b93423          	sd	s11,8(s2)
ffffffffc020598e:	00f93823          	sd	a5,16(s2)
ffffffffc0205992:	012db023          	sd	s2,0(s11)
ffffffffc0205996:	819ff06f          	j	ffffffffc02051ae <stride_dequeue+0x184>
ffffffffc020599a:	008cb783          	ld	a5,8(s9)
ffffffffc020599e:	010cba03          	ld	s4,16(s9)
ffffffffc02059a2:	e43e                	sd	a5,8(sp)
ffffffffc02059a4:	0c0a0d63          	beqz	s4,ffffffffc0205a7e <stride_dequeue+0xa54>
ffffffffc02059a8:	85a6                	mv	a1,s1
ffffffffc02059aa:	8552                	mv	a0,s4
ffffffffc02059ac:	c42ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02059b0:	58fd                	li	a7,-1
ffffffffc02059b2:	151500e3          	beq	a0,a7,ffffffffc02062f2 <stride_dequeue+0x12c8>
ffffffffc02059b6:	649c                	ld	a5,8(s1)
ffffffffc02059b8:	0104b983          	ld	s3,16(s1)
ffffffffc02059bc:	e83e                	sd	a5,16(sp)
ffffffffc02059be:	00099463          	bnez	s3,ffffffffc02059c6 <stride_dequeue+0x99c>
ffffffffc02059c2:	4f40106f          	j	ffffffffc0206eb6 <stride_dequeue+0x1e8c>
ffffffffc02059c6:	85ce                	mv	a1,s3
ffffffffc02059c8:	8552                	mv	a0,s4
ffffffffc02059ca:	c24ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02059ce:	58fd                	li	a7,-1
ffffffffc02059d0:	01151463          	bne	a0,a7,ffffffffc02059d8 <stride_dequeue+0x9ae>
ffffffffc02059d4:	0b00106f          	j	ffffffffc0206a84 <stride_dequeue+0x1a5a>
ffffffffc02059d8:	0089b783          	ld	a5,8(s3)
ffffffffc02059dc:	0109b303          	ld	t1,16(s3)
ffffffffc02059e0:	ec3e                	sd	a5,24(sp)
ffffffffc02059e2:	08030063          	beqz	t1,ffffffffc0205a62 <stride_dequeue+0xa38>
ffffffffc02059e6:	859a                	mv	a1,t1
ffffffffc02059e8:	8552                	mv	a0,s4
ffffffffc02059ea:	f01a                	sd	t1,32(sp)
ffffffffc02059ec:	c02ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02059f0:	58fd                	li	a7,-1
ffffffffc02059f2:	7302                	ld	t1,32(sp)
ffffffffc02059f4:	01151463          	bne	a0,a7,ffffffffc02059fc <stride_dequeue+0x9d2>
ffffffffc02059f8:	0130106f          	j	ffffffffc020720a <stride_dequeue+0x21e0>
ffffffffc02059fc:	00833783          	ld	a5,8(t1)
ffffffffc0205a00:	01033e03          	ld	t3,16(t1)
ffffffffc0205a04:	f03e                	sd	a5,32(sp)
ffffffffc0205a06:	040e0663          	beqz	t3,ffffffffc0205a52 <stride_dequeue+0xa28>
ffffffffc0205a0a:	85f2                	mv	a1,t3
ffffffffc0205a0c:	8552                	mv	a0,s4
ffffffffc0205a0e:	f81a                	sd	t1,48(sp)
ffffffffc0205a10:	f472                	sd	t3,40(sp)
ffffffffc0205a12:	bdcff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205a16:	58fd                	li	a7,-1
ffffffffc0205a18:	7e22                	ld	t3,40(sp)
ffffffffc0205a1a:	7342                	ld	t1,48(sp)
ffffffffc0205a1c:	01151463          	bne	a0,a7,ffffffffc0205a24 <stride_dequeue+0x9fa>
ffffffffc0205a20:	53d0106f          	j	ffffffffc020775c <stride_dequeue+0x2732>
ffffffffc0205a24:	010e3583          	ld	a1,16(t3)
ffffffffc0205a28:	8552                	mv	a0,s4
ffffffffc0205a2a:	008e3b03          	ld	s6,8(t3)
ffffffffc0205a2e:	f81a                	sd	t1,48(sp)
ffffffffc0205a30:	f472                	sd	t3,40(sp)
ffffffffc0205a32:	c18ff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205a36:	7e22                	ld	t3,40(sp)
ffffffffc0205a38:	7342                	ld	t1,48(sp)
ffffffffc0205a3a:	016e3823          	sd	s6,16(t3)
ffffffffc0205a3e:	00ae3423          	sd	a0,8(t3)
ffffffffc0205a42:	010c2b03          	lw	s6,16(s8)
ffffffffc0205a46:	e119                	bnez	a0,ffffffffc0205a4c <stride_dequeue+0xa22>
ffffffffc0205a48:	76d0106f          	j	ffffffffc02079b4 <stride_dequeue+0x298a>
ffffffffc0205a4c:	01c53023          	sd	t3,0(a0)
ffffffffc0205a50:	8a72                	mv	s4,t3
ffffffffc0205a52:	7782                	ld	a5,32(sp)
ffffffffc0205a54:	01433423          	sd	s4,8(t1)
ffffffffc0205a58:	00f33823          	sd	a5,16(t1)
ffffffffc0205a5c:	006a3023          	sd	t1,0(s4)
ffffffffc0205a60:	8a1a                	mv	s4,t1
ffffffffc0205a62:	67e2                	ld	a5,24(sp)
ffffffffc0205a64:	0149b423          	sd	s4,8(s3)
ffffffffc0205a68:	00f9b823          	sd	a5,16(s3)
ffffffffc0205a6c:	013a3023          	sd	s3,0(s4)
ffffffffc0205a70:	67c2                	ld	a5,16(sp)
ffffffffc0205a72:	0134b423          	sd	s3,8(s1)
ffffffffc0205a76:	e89c                	sd	a5,16(s1)
ffffffffc0205a78:	0099b023          	sd	s1,0(s3)
ffffffffc0205a7c:	89da                	mv	s3,s6
ffffffffc0205a7e:	67a2                	ld	a5,8(sp)
ffffffffc0205a80:	009cb423          	sd	s1,8(s9)
ffffffffc0205a84:	00fcb823          	sd	a5,16(s9)
ffffffffc0205a88:	0194b023          	sd	s9,0(s1)
ffffffffc0205a8c:	84e6                	mv	s1,s9
ffffffffc0205a8e:	b635                	j	ffffffffc02055ba <stride_dequeue+0x590>
ffffffffc0205a90:	008db783          	ld	a5,8(s11)
ffffffffc0205a94:	010db883          	ld	a7,16(s11)
ffffffffc0205a98:	ec2a                	sd	a0,24(sp)
ffffffffc0205a9a:	e83e                	sd	a5,16(sp)
ffffffffc0205a9c:	0a088963          	beqz	a7,ffffffffc0205b4e <stride_dequeue+0xb24>
ffffffffc0205aa0:	8546                	mv	a0,a7
ffffffffc0205aa2:	85d2                	mv	a1,s4
ffffffffc0205aa4:	f046                	sd	a7,32(sp)
ffffffffc0205aa6:	b48ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205aaa:	6862                	ld	a6,24(sp)
ffffffffc0205aac:	7882                	ld	a7,32(sp)
ffffffffc0205aae:	0d050ae3          	beq	a0,a6,ffffffffc0206382 <stride_dequeue+0x1358>
ffffffffc0205ab2:	008a3783          	ld	a5,8(s4)
ffffffffc0205ab6:	010a3983          	ld	s3,16(s4)
ffffffffc0205aba:	f042                	sd	a6,32(sp)
ffffffffc0205abc:	ec3e                	sd	a5,24(sp)
ffffffffc0205abe:	00099463          	bnez	s3,ffffffffc0205ac6 <stride_dequeue+0xa9c>
ffffffffc0205ac2:	53e0106f          	j	ffffffffc0207000 <stride_dequeue+0x1fd6>
ffffffffc0205ac6:	8546                	mv	a0,a7
ffffffffc0205ac8:	85ce                	mv	a1,s3
ffffffffc0205aca:	f446                	sd	a7,40(sp)
ffffffffc0205acc:	b22ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205ad0:	7802                	ld	a6,32(sp)
ffffffffc0205ad2:	78a2                	ld	a7,40(sp)
ffffffffc0205ad4:	01051463          	bne	a0,a6,ffffffffc0205adc <stride_dequeue+0xab2>
ffffffffc0205ad8:	1260106f          	j	ffffffffc0206bfe <stride_dequeue+0x1bd4>
ffffffffc0205adc:	0089b783          	ld	a5,8(s3)
ffffffffc0205ae0:	0109be03          	ld	t3,16(s3)
ffffffffc0205ae4:	f442                	sd	a6,40(sp)
ffffffffc0205ae6:	f03e                	sd	a5,32(sp)
ffffffffc0205ae8:	040e0463          	beqz	t3,ffffffffc0205b30 <stride_dequeue+0xb06>
ffffffffc0205aec:	85f2                	mv	a1,t3
ffffffffc0205aee:	8546                	mv	a0,a7
ffffffffc0205af0:	fc72                	sd	t3,56(sp)
ffffffffc0205af2:	f846                	sd	a7,48(sp)
ffffffffc0205af4:	afaff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205af8:	7822                	ld	a6,40(sp)
ffffffffc0205afa:	78c2                	ld	a7,48(sp)
ffffffffc0205afc:	7e62                	ld	t3,56(sp)
ffffffffc0205afe:	01051463          	bne	a0,a6,ffffffffc0205b06 <stride_dequeue+0xadc>
ffffffffc0205b02:	0e70106f          	j	ffffffffc02073e8 <stride_dequeue+0x23be>
ffffffffc0205b06:	010e3583          	ld	a1,16(t3)
ffffffffc0205b0a:	8546                	mv	a0,a7
ffffffffc0205b0c:	008e3b03          	ld	s6,8(t3)
ffffffffc0205b10:	f472                	sd	t3,40(sp)
ffffffffc0205b12:	b38ff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205b16:	7e22                	ld	t3,40(sp)
ffffffffc0205b18:	016e3823          	sd	s6,16(t3)
ffffffffc0205b1c:	00ae3423          	sd	a0,8(t3)
ffffffffc0205b20:	010c2b03          	lw	s6,16(s8)
ffffffffc0205b24:	e119                	bnez	a0,ffffffffc0205b2a <stride_dequeue+0xb00>
ffffffffc0205b26:	1c10106f          	j	ffffffffc02074e6 <stride_dequeue+0x24bc>
ffffffffc0205b2a:	01c53023          	sd	t3,0(a0)
ffffffffc0205b2e:	88f2                	mv	a7,t3
ffffffffc0205b30:	7782                	ld	a5,32(sp)
ffffffffc0205b32:	0119b423          	sd	a7,8(s3)
ffffffffc0205b36:	00f9b823          	sd	a5,16(s3)
ffffffffc0205b3a:	0138b023          	sd	s3,0(a7)
ffffffffc0205b3e:	67e2                	ld	a5,24(sp)
ffffffffc0205b40:	013a3423          	sd	s3,8(s4)
ffffffffc0205b44:	00fa3823          	sd	a5,16(s4)
ffffffffc0205b48:	0149b023          	sd	s4,0(s3)
ffffffffc0205b4c:	89da                	mv	s3,s6
ffffffffc0205b4e:	67c2                	ld	a5,16(sp)
ffffffffc0205b50:	014db423          	sd	s4,8(s11)
ffffffffc0205b54:	00fdb823          	sd	a5,16(s11)
ffffffffc0205b58:	01ba3023          	sd	s11,0(s4)
ffffffffc0205b5c:	fccff06f          	j	ffffffffc0205328 <stride_dequeue+0x2fe>
ffffffffc0205b60:	008db783          	ld	a5,8(s11)
ffffffffc0205b64:	010db883          	ld	a7,16(s11)
ffffffffc0205b68:	e82a                	sd	a0,16(sp)
ffffffffc0205b6a:	e43e                	sd	a5,8(sp)
ffffffffc0205b6c:	0a088f63          	beqz	a7,ffffffffc0205c2a <stride_dequeue+0xc00>
ffffffffc0205b70:	85b2                	mv	a1,a2
ffffffffc0205b72:	8546                	mv	a0,a7
ffffffffc0205b74:	f032                	sd	a2,32(sp)
ffffffffc0205b76:	ec46                	sd	a7,24(sp)
ffffffffc0205b78:	a76ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205b7c:	6842                	ld	a6,16(sp)
ffffffffc0205b7e:	68e2                	ld	a7,24(sp)
ffffffffc0205b80:	7602                	ld	a2,32(sp)
ffffffffc0205b82:	150506e3          	beq	a0,a6,ffffffffc02064ce <stride_dequeue+0x14a4>
ffffffffc0205b86:	661c                	ld	a5,8(a2)
ffffffffc0205b88:	01063983          	ld	s3,16(a2)
ffffffffc0205b8c:	ec42                	sd	a6,24(sp)
ffffffffc0205b8e:	e83e                	sd	a5,16(sp)
ffffffffc0205b90:	00099463          	bnez	s3,ffffffffc0205b98 <stride_dequeue+0xb6e>
ffffffffc0205b94:	4660106f          	j	ffffffffc0206ffa <stride_dequeue+0x1fd0>
ffffffffc0205b98:	8546                	mv	a0,a7
ffffffffc0205b9a:	85ce                	mv	a1,s3
ffffffffc0205b9c:	f432                	sd	a2,40(sp)
ffffffffc0205b9e:	f046                	sd	a7,32(sp)
ffffffffc0205ba0:	a4eff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205ba4:	6862                	ld	a6,24(sp)
ffffffffc0205ba6:	7882                	ld	a7,32(sp)
ffffffffc0205ba8:	7622                	ld	a2,40(sp)
ffffffffc0205baa:	01051463          	bne	a0,a6,ffffffffc0205bb2 <stride_dequeue+0xb88>
ffffffffc0205bae:	0ae0106f          	j	ffffffffc0206c5c <stride_dequeue+0x1c32>
ffffffffc0205bb2:	0089b783          	ld	a5,8(s3)
ffffffffc0205bb6:	0109be03          	ld	t3,16(s3)
ffffffffc0205bba:	f042                	sd	a6,32(sp)
ffffffffc0205bbc:	ec3e                	sd	a5,24(sp)
ffffffffc0205bbe:	040e0863          	beqz	t3,ffffffffc0205c0e <stride_dequeue+0xbe4>
ffffffffc0205bc2:	85f2                	mv	a1,t3
ffffffffc0205bc4:	8546                	mv	a0,a7
ffffffffc0205bc6:	fc32                	sd	a2,56(sp)
ffffffffc0205bc8:	f872                	sd	t3,48(sp)
ffffffffc0205bca:	f446                	sd	a7,40(sp)
ffffffffc0205bcc:	a22ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205bd0:	7662                	ld	a2,56(sp)
ffffffffc0205bd2:	7802                	ld	a6,32(sp)
ffffffffc0205bd4:	78a2                	ld	a7,40(sp)
ffffffffc0205bd6:	f432                	sd	a2,40(sp)
ffffffffc0205bd8:	7e42                	ld	t3,48(sp)
ffffffffc0205bda:	01051463          	bne	a0,a6,ffffffffc0205be2 <stride_dequeue+0xbb8>
ffffffffc0205bde:	6ac0106f          	j	ffffffffc020728a <stride_dequeue+0x2260>
ffffffffc0205be2:	010e3583          	ld	a1,16(t3)
ffffffffc0205be6:	8546                	mv	a0,a7
ffffffffc0205be8:	008e3b03          	ld	s6,8(t3)
ffffffffc0205bec:	f072                	sd	t3,32(sp)
ffffffffc0205bee:	a5cff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205bf2:	7e02                	ld	t3,32(sp)
ffffffffc0205bf4:	7622                	ld	a2,40(sp)
ffffffffc0205bf6:	016e3823          	sd	s6,16(t3)
ffffffffc0205bfa:	00ae3423          	sd	a0,8(t3)
ffffffffc0205bfe:	010c2b03          	lw	s6,16(s8)
ffffffffc0205c02:	e119                	bnez	a0,ffffffffc0205c08 <stride_dequeue+0xbde>
ffffffffc0205c04:	1370106f          	j	ffffffffc020753a <stride_dequeue+0x2510>
ffffffffc0205c08:	01c53023          	sd	t3,0(a0)
ffffffffc0205c0c:	88f2                	mv	a7,t3
ffffffffc0205c0e:	67e2                	ld	a5,24(sp)
ffffffffc0205c10:	0119b423          	sd	a7,8(s3)
ffffffffc0205c14:	00f9b823          	sd	a5,16(s3)
ffffffffc0205c18:	0138b023          	sd	s3,0(a7)
ffffffffc0205c1c:	67c2                	ld	a5,16(sp)
ffffffffc0205c1e:	01363423          	sd	s3,8(a2)
ffffffffc0205c22:	ea1c                	sd	a5,16(a2)
ffffffffc0205c24:	00c9b023          	sd	a2,0(s3)
ffffffffc0205c28:	89da                	mv	s3,s6
ffffffffc0205c2a:	67a2                	ld	a5,8(sp)
ffffffffc0205c2c:	00cdb423          	sd	a2,8(s11)
ffffffffc0205c30:	00fdb823          	sd	a5,16(s11)
ffffffffc0205c34:	01b63023          	sd	s11,0(a2)
ffffffffc0205c38:	849ff06f          	j	ffffffffc0205480 <stride_dequeue+0x456>
ffffffffc0205c3c:	008cb783          	ld	a5,8(s9)
ffffffffc0205c40:	010cb883          	ld	a7,16(s9)
ffffffffc0205c44:	ec2a                	sd	a0,24(sp)
ffffffffc0205c46:	e83e                	sd	a5,16(sp)
ffffffffc0205c48:	0a088963          	beqz	a7,ffffffffc0205cfa <stride_dequeue+0xcd0>
ffffffffc0205c4c:	8546                	mv	a0,a7
ffffffffc0205c4e:	85ee                	mv	a1,s11
ffffffffc0205c50:	f046                	sd	a7,32(sp)
ffffffffc0205c52:	99cff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205c56:	6862                	ld	a6,24(sp)
ffffffffc0205c58:	7882                	ld	a7,32(sp)
ffffffffc0205c5a:	7d050863          	beq	a0,a6,ffffffffc020642a <stride_dequeue+0x1400>
ffffffffc0205c5e:	008db783          	ld	a5,8(s11)
ffffffffc0205c62:	010db983          	ld	s3,16(s11)
ffffffffc0205c66:	f042                	sd	a6,32(sp)
ffffffffc0205c68:	ec3e                	sd	a5,24(sp)
ffffffffc0205c6a:	00099463          	bnez	s3,ffffffffc0205c72 <stride_dequeue+0xc48>
ffffffffc0205c6e:	3600106f          	j	ffffffffc0206fce <stride_dequeue+0x1fa4>
ffffffffc0205c72:	8546                	mv	a0,a7
ffffffffc0205c74:	85ce                	mv	a1,s3
ffffffffc0205c76:	f446                	sd	a7,40(sp)
ffffffffc0205c78:	976ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205c7c:	7802                	ld	a6,32(sp)
ffffffffc0205c7e:	78a2                	ld	a7,40(sp)
ffffffffc0205c80:	01051463          	bne	a0,a6,ffffffffc0205c88 <stride_dequeue+0xc5e>
ffffffffc0205c84:	71d0006f          	j	ffffffffc0206ba0 <stride_dequeue+0x1b76>
ffffffffc0205c88:	0089b783          	ld	a5,8(s3)
ffffffffc0205c8c:	0109be03          	ld	t3,16(s3)
ffffffffc0205c90:	f442                	sd	a6,40(sp)
ffffffffc0205c92:	f03e                	sd	a5,32(sp)
ffffffffc0205c94:	040e0463          	beqz	t3,ffffffffc0205cdc <stride_dequeue+0xcb2>
ffffffffc0205c98:	85f2                	mv	a1,t3
ffffffffc0205c9a:	8546                	mv	a0,a7
ffffffffc0205c9c:	fc72                	sd	t3,56(sp)
ffffffffc0205c9e:	f846                	sd	a7,48(sp)
ffffffffc0205ca0:	94eff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205ca4:	7822                	ld	a6,40(sp)
ffffffffc0205ca6:	78c2                	ld	a7,48(sp)
ffffffffc0205ca8:	7e62                	ld	t3,56(sp)
ffffffffc0205caa:	01051463          	bne	a0,a6,ffffffffc0205cb2 <stride_dequeue+0xc88>
ffffffffc0205cae:	60a0106f          	j	ffffffffc02072b8 <stride_dequeue+0x228e>
ffffffffc0205cb2:	010e3583          	ld	a1,16(t3)
ffffffffc0205cb6:	8546                	mv	a0,a7
ffffffffc0205cb8:	008e3b03          	ld	s6,8(t3)
ffffffffc0205cbc:	f472                	sd	t3,40(sp)
ffffffffc0205cbe:	98cff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205cc2:	7e22                	ld	t3,40(sp)
ffffffffc0205cc4:	016e3823          	sd	s6,16(t3)
ffffffffc0205cc8:	00ae3423          	sd	a0,8(t3)
ffffffffc0205ccc:	010c2b03          	lw	s6,16(s8)
ffffffffc0205cd0:	e119                	bnez	a0,ffffffffc0205cd6 <stride_dequeue+0xcac>
ffffffffc0205cd2:	0270106f          	j	ffffffffc02074f8 <stride_dequeue+0x24ce>
ffffffffc0205cd6:	01c53023          	sd	t3,0(a0)
ffffffffc0205cda:	88f2                	mv	a7,t3
ffffffffc0205cdc:	7782                	ld	a5,32(sp)
ffffffffc0205cde:	0119b423          	sd	a7,8(s3)
ffffffffc0205ce2:	00f9b823          	sd	a5,16(s3)
ffffffffc0205ce6:	0138b023          	sd	s3,0(a7)
ffffffffc0205cea:	67e2                	ld	a5,24(sp)
ffffffffc0205cec:	013db423          	sd	s3,8(s11)
ffffffffc0205cf0:	00fdb823          	sd	a5,16(s11)
ffffffffc0205cf4:	01b9b023          	sd	s11,0(s3)
ffffffffc0205cf8:	89da                	mv	s3,s6
ffffffffc0205cfa:	67c2                	ld	a5,16(sp)
ffffffffc0205cfc:	01bcb423          	sd	s11,8(s9)
ffffffffc0205d00:	00fcb823          	sd	a5,16(s9)
ffffffffc0205d04:	019db023          	sd	s9,0(s11)
ffffffffc0205d08:	8de6                	mv	s11,s9
ffffffffc0205d0a:	b9bd                	j	ffffffffc0205988 <stride_dequeue+0x95e>
ffffffffc0205d0c:	00893783          	ld	a5,8(s2)
ffffffffc0205d10:	01093883          	ld	a7,16(s2)
ffffffffc0205d14:	f02a                	sd	a0,32(sp)
ffffffffc0205d16:	ec3e                	sd	a5,24(sp)
ffffffffc0205d18:	06088c63          	beqz	a7,ffffffffc0205d90 <stride_dequeue+0xd66>
ffffffffc0205d1c:	85c2                	mv	a1,a6
ffffffffc0205d1e:	8546                	mv	a0,a7
ffffffffc0205d20:	f842                	sd	a6,48(sp)
ffffffffc0205d22:	f446                	sd	a7,40(sp)
ffffffffc0205d24:	8caff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205d28:	7302                	ld	t1,32(sp)
ffffffffc0205d2a:	78a2                	ld	a7,40(sp)
ffffffffc0205d2c:	7842                	ld	a6,48(sp)
ffffffffc0205d2e:	2e650ee3          	beq	a0,t1,ffffffffc020682a <stride_dequeue+0x1800>
ffffffffc0205d32:	00883783          	ld	a5,8(a6)
ffffffffc0205d36:	01083983          	ld	s3,16(a6)
ffffffffc0205d3a:	f41a                	sd	t1,40(sp)
ffffffffc0205d3c:	f03e                	sd	a5,32(sp)
ffffffffc0205d3e:	64098ee3          	beqz	s3,ffffffffc0206b9a <stride_dequeue+0x1b70>
ffffffffc0205d42:	8546                	mv	a0,a7
ffffffffc0205d44:	85ce                	mv	a1,s3
ffffffffc0205d46:	fc42                	sd	a6,56(sp)
ffffffffc0205d48:	f846                	sd	a7,48(sp)
ffffffffc0205d4a:	8a4ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205d4e:	7322                	ld	t1,40(sp)
ffffffffc0205d50:	78c2                	ld	a7,48(sp)
ffffffffc0205d52:	7862                	ld	a6,56(sp)
ffffffffc0205d54:	00651463          	bne	a0,t1,ffffffffc0205d5c <stride_dequeue+0xd32>
ffffffffc0205d58:	1e80106f          	j	ffffffffc0206f40 <stride_dequeue+0x1f16>
ffffffffc0205d5c:	0109b583          	ld	a1,16(s3)
ffffffffc0205d60:	0089bb03          	ld	s6,8(s3)
ffffffffc0205d64:	8546                	mv	a0,a7
ffffffffc0205d66:	f442                	sd	a6,40(sp)
ffffffffc0205d68:	8e2ff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205d6c:	00a9b423          	sd	a0,8(s3)
ffffffffc0205d70:	0169b823          	sd	s6,16(s3)
ffffffffc0205d74:	7822                	ld	a6,40(sp)
ffffffffc0205d76:	010c2b03          	lw	s6,16(s8)
ffffffffc0205d7a:	c119                	beqz	a0,ffffffffc0205d80 <stride_dequeue+0xd56>
ffffffffc0205d7c:	01353023          	sd	s3,0(a0)
ffffffffc0205d80:	7782                	ld	a5,32(sp)
ffffffffc0205d82:	01383423          	sd	s3,8(a6)
ffffffffc0205d86:	00f83823          	sd	a5,16(a6)
ffffffffc0205d8a:	0109b023          	sd	a6,0(s3)
ffffffffc0205d8e:	89da                	mv	s3,s6
ffffffffc0205d90:	67e2                	ld	a5,24(sp)
ffffffffc0205d92:	01093423          	sd	a6,8(s2)
ffffffffc0205d96:	00f93823          	sd	a5,16(s2)
ffffffffc0205d9a:	01283023          	sd	s2,0(a6)
ffffffffc0205d9e:	bf0ff06f          	j	ffffffffc020518e <stride_dequeue+0x164>
ffffffffc0205da2:	008cb783          	ld	a5,8(s9)
ffffffffc0205da6:	010cb983          	ld	s3,16(s9)
ffffffffc0205daa:	ec2a                	sd	a0,24(sp)
ffffffffc0205dac:	e83e                	sd	a5,16(sp)
ffffffffc0205dae:	0a098763          	beqz	s3,ffffffffc0205e5c <stride_dequeue+0xe32>
ffffffffc0205db2:	85d2                	mv	a1,s4
ffffffffc0205db4:	854e                	mv	a0,s3
ffffffffc0205db6:	838ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205dba:	6862                	ld	a6,24(sp)
ffffffffc0205dbc:	3b050fe3          	beq	a0,a6,ffffffffc020697a <stride_dequeue+0x1950>
ffffffffc0205dc0:	008a3783          	ld	a5,8(s4)
ffffffffc0205dc4:	010a3303          	ld	t1,16(s4)
ffffffffc0205dc8:	f042                	sd	a6,32(sp)
ffffffffc0205dca:	ec3e                	sd	a5,24(sp)
ffffffffc0205dcc:	08030163          	beqz	t1,ffffffffc0205e4e <stride_dequeue+0xe24>
ffffffffc0205dd0:	859a                	mv	a1,t1
ffffffffc0205dd2:	854e                	mv	a0,s3
ffffffffc0205dd4:	f41a                	sd	t1,40(sp)
ffffffffc0205dd6:	818ff0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205dda:	7802                	ld	a6,32(sp)
ffffffffc0205ddc:	7322                	ld	t1,40(sp)
ffffffffc0205dde:	01051463          	bne	a0,a6,ffffffffc0205de6 <stride_dequeue+0xdbc>
ffffffffc0205de2:	3da0106f          	j	ffffffffc02071bc <stride_dequeue+0x2192>
ffffffffc0205de6:	00833783          	ld	a5,8(t1)
ffffffffc0205dea:	01033e03          	ld	t3,16(t1)
ffffffffc0205dee:	fc42                	sd	a6,56(sp)
ffffffffc0205df0:	f03e                	sd	a5,32(sp)
ffffffffc0205df2:	040e0663          	beqz	t3,ffffffffc0205e3e <stride_dequeue+0xe14>
ffffffffc0205df6:	85f2                	mv	a1,t3
ffffffffc0205df8:	854e                	mv	a0,s3
ffffffffc0205dfa:	f81a                	sd	t1,48(sp)
ffffffffc0205dfc:	f472                	sd	t3,40(sp)
ffffffffc0205dfe:	ff1fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205e02:	7862                	ld	a6,56(sp)
ffffffffc0205e04:	7e22                	ld	t3,40(sp)
ffffffffc0205e06:	7342                	ld	t1,48(sp)
ffffffffc0205e08:	01051463          	bne	a0,a6,ffffffffc0205e10 <stride_dequeue+0xde6>
ffffffffc0205e0c:	0c90106f          	j	ffffffffc02076d4 <stride_dequeue+0x26aa>
ffffffffc0205e10:	010e3583          	ld	a1,16(t3)
ffffffffc0205e14:	854e                	mv	a0,s3
ffffffffc0205e16:	008e3b03          	ld	s6,8(t3)
ffffffffc0205e1a:	f81a                	sd	t1,48(sp)
ffffffffc0205e1c:	f472                	sd	t3,40(sp)
ffffffffc0205e1e:	82cff0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205e22:	7e22                	ld	t3,40(sp)
ffffffffc0205e24:	7342                	ld	t1,48(sp)
ffffffffc0205e26:	016e3823          	sd	s6,16(t3)
ffffffffc0205e2a:	00ae3423          	sd	a0,8(t3)
ffffffffc0205e2e:	010c2b03          	lw	s6,16(s8)
ffffffffc0205e32:	e119                	bnez	a0,ffffffffc0205e38 <stride_dequeue+0xe0e>
ffffffffc0205e34:	32d0106f          	j	ffffffffc0207960 <stride_dequeue+0x2936>
ffffffffc0205e38:	01c53023          	sd	t3,0(a0)
ffffffffc0205e3c:	89f2                	mv	s3,t3
ffffffffc0205e3e:	7782                	ld	a5,32(sp)
ffffffffc0205e40:	01333423          	sd	s3,8(t1)
ffffffffc0205e44:	00f33823          	sd	a5,16(t1)
ffffffffc0205e48:	0069b023          	sd	t1,0(s3)
ffffffffc0205e4c:	899a                	mv	s3,t1
ffffffffc0205e4e:	67e2                	ld	a5,24(sp)
ffffffffc0205e50:	013a3423          	sd	s3,8(s4)
ffffffffc0205e54:	00fa3823          	sd	a5,16(s4)
ffffffffc0205e58:	0149b023          	sd	s4,0(s3)
ffffffffc0205e5c:	67c2                	ld	a5,16(sp)
ffffffffc0205e5e:	014cb423          	sd	s4,8(s9)
ffffffffc0205e62:	89da                	mv	s3,s6
ffffffffc0205e64:	00fcb823          	sd	a5,16(s9)
ffffffffc0205e68:	019a3023          	sd	s9,0(s4)
ffffffffc0205e6c:	f42ff06f          	j	ffffffffc02055ae <stride_dequeue+0x584>
ffffffffc0205e70:	661c                	ld	a5,8(a2)
ffffffffc0205e72:	01063983          	ld	s3,16(a2)
ffffffffc0205e76:	e82a                	sd	a0,16(sp)
ffffffffc0205e78:	e43e                	sd	a5,8(sp)
ffffffffc0205e7a:	0a098f63          	beqz	s3,ffffffffc0205f38 <stride_dequeue+0xf0e>
ffffffffc0205e7e:	85d2                	mv	a1,s4
ffffffffc0205e80:	854e                	mv	a0,s3
ffffffffc0205e82:	ec32                	sd	a2,24(sp)
ffffffffc0205e84:	f6bfe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205e88:	6842                	ld	a6,16(sp)
ffffffffc0205e8a:	6662                	ld	a2,24(sp)
ffffffffc0205e8c:	39050de3          	beq	a0,a6,ffffffffc0206a26 <stride_dequeue+0x19fc>
ffffffffc0205e90:	008a3783          	ld	a5,8(s4)
ffffffffc0205e94:	010a3303          	ld	t1,16(s4)
ffffffffc0205e98:	ec42                	sd	a6,24(sp)
ffffffffc0205e9a:	e83e                	sd	a5,16(sp)
ffffffffc0205e9c:	08030763          	beqz	t1,ffffffffc0205f2a <stride_dequeue+0xf00>
ffffffffc0205ea0:	859a                	mv	a1,t1
ffffffffc0205ea2:	854e                	mv	a0,s3
ffffffffc0205ea4:	f432                	sd	a2,40(sp)
ffffffffc0205ea6:	f01a                	sd	t1,32(sp)
ffffffffc0205ea8:	f47fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205eac:	6862                	ld	a6,24(sp)
ffffffffc0205eae:	7302                	ld	t1,32(sp)
ffffffffc0205eb0:	7622                	ld	a2,40(sp)
ffffffffc0205eb2:	01051463          	bne	a0,a6,ffffffffc0205eba <stride_dequeue+0xe90>
ffffffffc0205eb6:	5060106f          	j	ffffffffc02073bc <stride_dequeue+0x2392>
ffffffffc0205eba:	00833783          	ld	a5,8(t1)
ffffffffc0205ebe:	01033e03          	ld	t3,16(t1)
ffffffffc0205ec2:	fc42                	sd	a6,56(sp)
ffffffffc0205ec4:	ec3e                	sd	a5,24(sp)
ffffffffc0205ec6:	040e0a63          	beqz	t3,ffffffffc0205f1a <stride_dequeue+0xef0>
ffffffffc0205eca:	85f2                	mv	a1,t3
ffffffffc0205ecc:	854e                	mv	a0,s3
ffffffffc0205ece:	f81a                	sd	t1,48(sp)
ffffffffc0205ed0:	f432                	sd	a2,40(sp)
ffffffffc0205ed2:	f072                	sd	t3,32(sp)
ffffffffc0205ed4:	f1bfe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205ed8:	7862                	ld	a6,56(sp)
ffffffffc0205eda:	7e02                	ld	t3,32(sp)
ffffffffc0205edc:	7622                	ld	a2,40(sp)
ffffffffc0205ede:	7342                	ld	t1,48(sp)
ffffffffc0205ee0:	01051463          	bne	a0,a6,ffffffffc0205ee8 <stride_dequeue+0xebe>
ffffffffc0205ee4:	1e10106f          	j	ffffffffc02078c4 <stride_dequeue+0x289a>
ffffffffc0205ee8:	010e3583          	ld	a1,16(t3)
ffffffffc0205eec:	854e                	mv	a0,s3
ffffffffc0205eee:	008e3b03          	ld	s6,8(t3)
ffffffffc0205ef2:	f81a                	sd	t1,48(sp)
ffffffffc0205ef4:	f432                	sd	a2,40(sp)
ffffffffc0205ef6:	f072                	sd	t3,32(sp)
ffffffffc0205ef8:	f53fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205efc:	7e02                	ld	t3,32(sp)
ffffffffc0205efe:	7622                	ld	a2,40(sp)
ffffffffc0205f00:	7342                	ld	t1,48(sp)
ffffffffc0205f02:	016e3823          	sd	s6,16(t3)
ffffffffc0205f06:	00ae3423          	sd	a0,8(t3)
ffffffffc0205f0a:	010c2b03          	lw	s6,16(s8)
ffffffffc0205f0e:	e119                	bnez	a0,ffffffffc0205f14 <stride_dequeue+0xeea>
ffffffffc0205f10:	22d0106f          	j	ffffffffc020793c <stride_dequeue+0x2912>
ffffffffc0205f14:	01c53023          	sd	t3,0(a0)
ffffffffc0205f18:	89f2                	mv	s3,t3
ffffffffc0205f1a:	67e2                	ld	a5,24(sp)
ffffffffc0205f1c:	01333423          	sd	s3,8(t1)
ffffffffc0205f20:	00f33823          	sd	a5,16(t1)
ffffffffc0205f24:	0069b023          	sd	t1,0(s3)
ffffffffc0205f28:	899a                	mv	s3,t1
ffffffffc0205f2a:	67c2                	ld	a5,16(sp)
ffffffffc0205f2c:	013a3423          	sd	s3,8(s4)
ffffffffc0205f30:	00fa3823          	sd	a5,16(s4)
ffffffffc0205f34:	0149b023          	sd	s4,0(s3)
ffffffffc0205f38:	67a2                	ld	a5,8(sp)
ffffffffc0205f3a:	01463423          	sd	s4,8(a2)
ffffffffc0205f3e:	89da                	mv	s3,s6
ffffffffc0205f40:	ea1c                	sd	a5,16(a2)
ffffffffc0205f42:	00ca3023          	sd	a2,0(s4)
ffffffffc0205f46:	8a32                	mv	s4,a2
ffffffffc0205f48:	f80ff06f          	j	ffffffffc02056c8 <stride_dequeue+0x69e>
ffffffffc0205f4c:	008a3783          	ld	a5,8(s4)
ffffffffc0205f50:	010a3983          	ld	s3,16(s4)
ffffffffc0205f54:	ec2a                	sd	a0,24(sp)
ffffffffc0205f56:	e83e                	sd	a5,16(sp)
ffffffffc0205f58:	0a098763          	beqz	s3,ffffffffc0206006 <stride_dequeue+0xfdc>
ffffffffc0205f5c:	85e6                	mv	a1,s9
ffffffffc0205f5e:	854e                	mv	a0,s3
ffffffffc0205f60:	e8ffe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205f64:	6862                	ld	a6,24(sp)
ffffffffc0205f66:	270505e3          	beq	a0,a6,ffffffffc02069d0 <stride_dequeue+0x19a6>
ffffffffc0205f6a:	008cb783          	ld	a5,8(s9)
ffffffffc0205f6e:	010cb303          	ld	t1,16(s9)
ffffffffc0205f72:	f042                	sd	a6,32(sp)
ffffffffc0205f74:	ec3e                	sd	a5,24(sp)
ffffffffc0205f76:	08030163          	beqz	t1,ffffffffc0205ff8 <stride_dequeue+0xfce>
ffffffffc0205f7a:	859a                	mv	a1,t1
ffffffffc0205f7c:	854e                	mv	a0,s3
ffffffffc0205f7e:	f41a                	sd	t1,40(sp)
ffffffffc0205f80:	e6ffe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205f84:	7802                	ld	a6,32(sp)
ffffffffc0205f86:	7322                	ld	t1,40(sp)
ffffffffc0205f88:	01051463          	bne	a0,a6,ffffffffc0205f90 <stride_dequeue+0xf66>
ffffffffc0205f8c:	4080106f          	j	ffffffffc0207394 <stride_dequeue+0x236a>
ffffffffc0205f90:	00833783          	ld	a5,8(t1)
ffffffffc0205f94:	01033e03          	ld	t3,16(t1)
ffffffffc0205f98:	fc42                	sd	a6,56(sp)
ffffffffc0205f9a:	f03e                	sd	a5,32(sp)
ffffffffc0205f9c:	040e0663          	beqz	t3,ffffffffc0205fe8 <stride_dequeue+0xfbe>
ffffffffc0205fa0:	85f2                	mv	a1,t3
ffffffffc0205fa2:	854e                	mv	a0,s3
ffffffffc0205fa4:	f81a                	sd	t1,48(sp)
ffffffffc0205fa6:	f472                	sd	t3,40(sp)
ffffffffc0205fa8:	e47fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0205fac:	7862                	ld	a6,56(sp)
ffffffffc0205fae:	7e22                	ld	t3,40(sp)
ffffffffc0205fb0:	7342                	ld	t1,48(sp)
ffffffffc0205fb2:	01051463          	bne	a0,a6,ffffffffc0205fba <stride_dequeue+0xf90>
ffffffffc0205fb6:	6160106f          	j	ffffffffc02075cc <stride_dequeue+0x25a2>
ffffffffc0205fba:	010e3583          	ld	a1,16(t3)
ffffffffc0205fbe:	854e                	mv	a0,s3
ffffffffc0205fc0:	008e3b03          	ld	s6,8(t3)
ffffffffc0205fc4:	f81a                	sd	t1,48(sp)
ffffffffc0205fc6:	f472                	sd	t3,40(sp)
ffffffffc0205fc8:	e83fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0205fcc:	7e22                	ld	t3,40(sp)
ffffffffc0205fce:	7342                	ld	t1,48(sp)
ffffffffc0205fd0:	016e3823          	sd	s6,16(t3)
ffffffffc0205fd4:	00ae3423          	sd	a0,8(t3)
ffffffffc0205fd8:	010c2b03          	lw	s6,16(s8)
ffffffffc0205fdc:	e119                	bnez	a0,ffffffffc0205fe2 <stride_dequeue+0xfb8>
ffffffffc0205fde:	1b30106f          	j	ffffffffc0207990 <stride_dequeue+0x2966>
ffffffffc0205fe2:	01c53023          	sd	t3,0(a0)
ffffffffc0205fe6:	89f2                	mv	s3,t3
ffffffffc0205fe8:	7782                	ld	a5,32(sp)
ffffffffc0205fea:	01333423          	sd	s3,8(t1)
ffffffffc0205fee:	00f33823          	sd	a5,16(t1)
ffffffffc0205ff2:	0069b023          	sd	t1,0(s3)
ffffffffc0205ff6:	899a                	mv	s3,t1
ffffffffc0205ff8:	67e2                	ld	a5,24(sp)
ffffffffc0205ffa:	013cb423          	sd	s3,8(s9)
ffffffffc0205ffe:	00fcb823          	sd	a5,16(s9)
ffffffffc0206002:	0199b023          	sd	s9,0(s3)
ffffffffc0206006:	67c2                	ld	a5,16(sp)
ffffffffc0206008:	019a3423          	sd	s9,8(s4)
ffffffffc020600c:	89da                	mv	s3,s6
ffffffffc020600e:	00fa3823          	sd	a5,16(s4)
ffffffffc0206012:	014cb023          	sd	s4,0(s9)
ffffffffc0206016:	8cd2                	mv	s9,s4
ffffffffc0206018:	faeff06f          	j	ffffffffc02057c6 <stride_dequeue+0x79c>
ffffffffc020601c:	0088b783          	ld	a5,8(a7)
ffffffffc0206020:	0108b983          	ld	s3,16(a7)
ffffffffc0206024:	f02a                	sd	a0,32(sp)
ffffffffc0206026:	ec3e                	sd	a5,24(sp)
ffffffffc0206028:	06098e63          	beqz	s3,ffffffffc02060a4 <stride_dequeue+0x107a>
ffffffffc020602c:	85e6                	mv	a1,s9
ffffffffc020602e:	854e                	mv	a0,s3
ffffffffc0206030:	f446                	sd	a7,40(sp)
ffffffffc0206032:	dbdfe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206036:	7302                	ld	t1,32(sp)
ffffffffc0206038:	78a2                	ld	a7,40(sp)
ffffffffc020603a:	486503e3          	beq	a0,t1,ffffffffc0206cc0 <stride_dequeue+0x1c96>
ffffffffc020603e:	008cb783          	ld	a5,8(s9)
ffffffffc0206042:	010cbe03          	ld	t3,16(s9)
ffffffffc0206046:	f41a                	sd	t1,40(sp)
ffffffffc0206048:	f03e                	sd	a5,32(sp)
ffffffffc020604a:	040e0663          	beqz	t3,ffffffffc0206096 <stride_dequeue+0x106c>
ffffffffc020604e:	85f2                	mv	a1,t3
ffffffffc0206050:	854e                	mv	a0,s3
ffffffffc0206052:	fc46                	sd	a7,56(sp)
ffffffffc0206054:	f872                	sd	t3,48(sp)
ffffffffc0206056:	d99fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc020605a:	7322                	ld	t1,40(sp)
ffffffffc020605c:	7e42                	ld	t3,48(sp)
ffffffffc020605e:	78e2                	ld	a7,56(sp)
ffffffffc0206060:	00651463          	bne	a0,t1,ffffffffc0206068 <stride_dequeue+0x103e>
ffffffffc0206064:	3040106f          	j	ffffffffc0207368 <stride_dequeue+0x233e>
ffffffffc0206068:	010e3583          	ld	a1,16(t3)
ffffffffc020606c:	854e                	mv	a0,s3
ffffffffc020606e:	008e3b03          	ld	s6,8(t3)
ffffffffc0206072:	f846                	sd	a7,48(sp)
ffffffffc0206074:	f472                	sd	t3,40(sp)
ffffffffc0206076:	dd5fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020607a:	7e22                	ld	t3,40(sp)
ffffffffc020607c:	78c2                	ld	a7,48(sp)
ffffffffc020607e:	016e3823          	sd	s6,16(t3)
ffffffffc0206082:	00ae3423          	sd	a0,8(t3)
ffffffffc0206086:	010c2b03          	lw	s6,16(s8)
ffffffffc020608a:	e119                	bnez	a0,ffffffffc0206090 <stride_dequeue+0x1066>
ffffffffc020608c:	4540106f          	j	ffffffffc02074e0 <stride_dequeue+0x24b6>
ffffffffc0206090:	01c53023          	sd	t3,0(a0)
ffffffffc0206094:	89f2                	mv	s3,t3
ffffffffc0206096:	7782                	ld	a5,32(sp)
ffffffffc0206098:	013cb423          	sd	s3,8(s9)
ffffffffc020609c:	00fcb823          	sd	a5,16(s9)
ffffffffc02060a0:	0199b023          	sd	s9,0(s3)
ffffffffc02060a4:	67e2                	ld	a5,24(sp)
ffffffffc02060a6:	0198b423          	sd	s9,8(a7)
ffffffffc02060aa:	89da                	mv	s3,s6
ffffffffc02060ac:	00f8b823          	sd	a5,16(a7)
ffffffffc02060b0:	011cb023          	sd	a7,0(s9)
ffffffffc02060b4:	8cc6                	mv	s9,a7
ffffffffc02060b6:	fdeff06f          	j	ffffffffc0205894 <stride_dequeue+0x86a>
ffffffffc02060ba:	008cb783          	ld	a5,8(s9)
ffffffffc02060be:	010cb983          	ld	s3,16(s9)
ffffffffc02060c2:	f02a                	sd	a0,32(sp)
ffffffffc02060c4:	ec3e                	sd	a5,24(sp)
ffffffffc02060c6:	06098e63          	beqz	s3,ffffffffc0206142 <stride_dequeue+0x1118>
ffffffffc02060ca:	85c2                	mv	a1,a6
ffffffffc02060cc:	854e                	mv	a0,s3
ffffffffc02060ce:	f442                	sd	a6,40(sp)
ffffffffc02060d0:	d1ffe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02060d4:	7302                	ld	t1,32(sp)
ffffffffc02060d6:	7822                	ld	a6,40(sp)
ffffffffc02060d8:	446506e3          	beq	a0,t1,ffffffffc0206d24 <stride_dequeue+0x1cfa>
ffffffffc02060dc:	00883783          	ld	a5,8(a6)
ffffffffc02060e0:	01083e03          	ld	t3,16(a6)
ffffffffc02060e4:	f41a                	sd	t1,40(sp)
ffffffffc02060e6:	f03e                	sd	a5,32(sp)
ffffffffc02060e8:	040e0663          	beqz	t3,ffffffffc0206134 <stride_dequeue+0x110a>
ffffffffc02060ec:	85f2                	mv	a1,t3
ffffffffc02060ee:	854e                	mv	a0,s3
ffffffffc02060f0:	fc42                	sd	a6,56(sp)
ffffffffc02060f2:	f872                	sd	t3,48(sp)
ffffffffc02060f4:	cfbfe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02060f8:	7322                	ld	t1,40(sp)
ffffffffc02060fa:	7e42                	ld	t3,48(sp)
ffffffffc02060fc:	7862                	ld	a6,56(sp)
ffffffffc02060fe:	00651463          	bne	a0,t1,ffffffffc0206106 <stride_dequeue+0x10dc>
ffffffffc0206102:	20e0106f          	j	ffffffffc0207310 <stride_dequeue+0x22e6>
ffffffffc0206106:	010e3583          	ld	a1,16(t3)
ffffffffc020610a:	854e                	mv	a0,s3
ffffffffc020610c:	008e3b03          	ld	s6,8(t3)
ffffffffc0206110:	f842                	sd	a6,48(sp)
ffffffffc0206112:	f472                	sd	t3,40(sp)
ffffffffc0206114:	d37fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206118:	7e22                	ld	t3,40(sp)
ffffffffc020611a:	7842                	ld	a6,48(sp)
ffffffffc020611c:	016e3823          	sd	s6,16(t3)
ffffffffc0206120:	00ae3423          	sd	a0,8(t3)
ffffffffc0206124:	010c2b03          	lw	s6,16(s8)
ffffffffc0206128:	e119                	bnez	a0,ffffffffc020612e <stride_dequeue+0x1104>
ffffffffc020612a:	3c80106f          	j	ffffffffc02074f2 <stride_dequeue+0x24c8>
ffffffffc020612e:	01c53023          	sd	t3,0(a0)
ffffffffc0206132:	89f2                	mv	s3,t3
ffffffffc0206134:	7782                	ld	a5,32(sp)
ffffffffc0206136:	01383423          	sd	s3,8(a6)
ffffffffc020613a:	00f83823          	sd	a5,16(a6)
ffffffffc020613e:	0109b023          	sd	a6,0(s3)
ffffffffc0206142:	67e2                	ld	a5,24(sp)
ffffffffc0206144:	010cb423          	sd	a6,8(s9)
ffffffffc0206148:	89da                	mv	s3,s6
ffffffffc020614a:	00fcb823          	sd	a5,16(s9)
ffffffffc020614e:	01983023          	sd	s9,0(a6)
ffffffffc0206152:	829ff06f          	j	ffffffffc020597a <stride_dequeue+0x950>
ffffffffc0206156:	008db783          	ld	a5,8(s11)
ffffffffc020615a:	010db983          	ld	s3,16(s11)
ffffffffc020615e:	f02a                	sd	a0,32(sp)
ffffffffc0206160:	ec3e                	sd	a5,24(sp)
ffffffffc0206162:	06098e63          	beqz	s3,ffffffffc02061de <stride_dequeue+0x11b4>
ffffffffc0206166:	85c2                	mv	a1,a6
ffffffffc0206168:	854e                	mv	a0,s3
ffffffffc020616a:	f442                	sd	a6,40(sp)
ffffffffc020616c:	c83fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206170:	7302                	ld	t1,32(sp)
ffffffffc0206172:	7822                	ld	a6,40(sp)
ffffffffc0206174:	466506e3          	beq	a0,t1,ffffffffc0206de0 <stride_dequeue+0x1db6>
ffffffffc0206178:	00883783          	ld	a5,8(a6)
ffffffffc020617c:	01083e03          	ld	t3,16(a6)
ffffffffc0206180:	f41a                	sd	t1,40(sp)
ffffffffc0206182:	f03e                	sd	a5,32(sp)
ffffffffc0206184:	040e0663          	beqz	t3,ffffffffc02061d0 <stride_dequeue+0x11a6>
ffffffffc0206188:	85f2                	mv	a1,t3
ffffffffc020618a:	854e                	mv	a0,s3
ffffffffc020618c:	fc42                	sd	a6,56(sp)
ffffffffc020618e:	f872                	sd	t3,48(sp)
ffffffffc0206190:	c5ffe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206194:	7322                	ld	t1,40(sp)
ffffffffc0206196:	7e42                	ld	t3,48(sp)
ffffffffc0206198:	7862                	ld	a6,56(sp)
ffffffffc020619a:	00651463          	bne	a0,t1,ffffffffc02061a2 <stride_dequeue+0x1178>
ffffffffc020619e:	7490006f          	j	ffffffffc02070e6 <stride_dequeue+0x20bc>
ffffffffc02061a2:	010e3583          	ld	a1,16(t3)
ffffffffc02061a6:	854e                	mv	a0,s3
ffffffffc02061a8:	008e3b03          	ld	s6,8(t3)
ffffffffc02061ac:	f842                	sd	a6,48(sp)
ffffffffc02061ae:	f472                	sd	t3,40(sp)
ffffffffc02061b0:	c9bfe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02061b4:	7e22                	ld	t3,40(sp)
ffffffffc02061b6:	7842                	ld	a6,48(sp)
ffffffffc02061b8:	016e3823          	sd	s6,16(t3)
ffffffffc02061bc:	00ae3423          	sd	a0,8(t3)
ffffffffc02061c0:	010c2b03          	lw	s6,16(s8)
ffffffffc02061c4:	e119                	bnez	a0,ffffffffc02061ca <stride_dequeue+0x11a0>
ffffffffc02061c6:	3260106f          	j	ffffffffc02074ec <stride_dequeue+0x24c2>
ffffffffc02061ca:	01c53023          	sd	t3,0(a0)
ffffffffc02061ce:	89f2                	mv	s3,t3
ffffffffc02061d0:	7782                	ld	a5,32(sp)
ffffffffc02061d2:	01383423          	sd	s3,8(a6)
ffffffffc02061d6:	00f83823          	sd	a5,16(a6)
ffffffffc02061da:	0109b023          	sd	a6,0(s3)
ffffffffc02061de:	67e2                	ld	a5,24(sp)
ffffffffc02061e0:	010db423          	sd	a6,8(s11)
ffffffffc02061e4:	89da                	mv	s3,s6
ffffffffc02061e6:	00fdb823          	sd	a5,16(s11)
ffffffffc02061ea:	01b83023          	sd	s11,0(a6)
ffffffffc02061ee:	92aff06f          	j	ffffffffc0205318 <stride_dequeue+0x2ee>
ffffffffc02061f2:	008db783          	ld	a5,8(s11)
ffffffffc02061f6:	010db983          	ld	s3,16(s11)
ffffffffc02061fa:	ec2a                	sd	a0,24(sp)
ffffffffc02061fc:	e83e                	sd	a5,16(sp)
ffffffffc02061fe:	08098263          	beqz	s3,ffffffffc0206282 <stride_dequeue+0x1258>
ffffffffc0206202:	85c2                	mv	a1,a6
ffffffffc0206204:	854e                	mv	a0,s3
ffffffffc0206206:	f432                	sd	a2,40(sp)
ffffffffc0206208:	f042                	sd	a6,32(sp)
ffffffffc020620a:	be5fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc020620e:	6362                	ld	t1,24(sp)
ffffffffc0206210:	7802                	ld	a6,32(sp)
ffffffffc0206212:	7622                	ld	a2,40(sp)
ffffffffc0206214:	426505e3          	beq	a0,t1,ffffffffc0206e3e <stride_dequeue+0x1e14>
ffffffffc0206218:	00883783          	ld	a5,8(a6)
ffffffffc020621c:	01083e03          	ld	t3,16(a6)
ffffffffc0206220:	f01a                	sd	t1,32(sp)
ffffffffc0206222:	ec3e                	sd	a5,24(sp)
ffffffffc0206224:	040e0863          	beqz	t3,ffffffffc0206274 <stride_dequeue+0x124a>
ffffffffc0206228:	85f2                	mv	a1,t3
ffffffffc020622a:	854e                	mv	a0,s3
ffffffffc020622c:	fc42                	sd	a6,56(sp)
ffffffffc020622e:	f832                	sd	a2,48(sp)
ffffffffc0206230:	f472                	sd	t3,40(sp)
ffffffffc0206232:	bbdfe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206236:	7302                	ld	t1,32(sp)
ffffffffc0206238:	7e22                	ld	t3,40(sp)
ffffffffc020623a:	7642                	ld	a2,48(sp)
ffffffffc020623c:	7862                	ld	a6,56(sp)
ffffffffc020623e:	60650fe3          	beq	a0,t1,ffffffffc020705c <stride_dequeue+0x2032>
ffffffffc0206242:	010e3583          	ld	a1,16(t3)
ffffffffc0206246:	854e                	mv	a0,s3
ffffffffc0206248:	008e3b03          	ld	s6,8(t3)
ffffffffc020624c:	f842                	sd	a6,48(sp)
ffffffffc020624e:	f432                	sd	a2,40(sp)
ffffffffc0206250:	f072                	sd	t3,32(sp)
ffffffffc0206252:	bf9fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206256:	7e02                	ld	t3,32(sp)
ffffffffc0206258:	7622                	ld	a2,40(sp)
ffffffffc020625a:	7842                	ld	a6,48(sp)
ffffffffc020625c:	016e3823          	sd	s6,16(t3)
ffffffffc0206260:	00ae3423          	sd	a0,8(t3)
ffffffffc0206264:	010c2b03          	lw	s6,16(s8)
ffffffffc0206268:	e119                	bnez	a0,ffffffffc020626e <stride_dequeue+0x1244>
ffffffffc020626a:	2d60106f          	j	ffffffffc0207540 <stride_dequeue+0x2516>
ffffffffc020626e:	01c53023          	sd	t3,0(a0)
ffffffffc0206272:	89f2                	mv	s3,t3
ffffffffc0206274:	67e2                	ld	a5,24(sp)
ffffffffc0206276:	01383423          	sd	s3,8(a6)
ffffffffc020627a:	00f83823          	sd	a5,16(a6)
ffffffffc020627e:	0109b023          	sd	a6,0(s3)
ffffffffc0206282:	67c2                	ld	a5,16(sp)
ffffffffc0206284:	010db423          	sd	a6,8(s11)
ffffffffc0206288:	89da                	mv	s3,s6
ffffffffc020628a:	00fdb823          	sd	a5,16(s11)
ffffffffc020628e:	01b83023          	sd	s11,0(a6)
ffffffffc0206292:	9e0ff06f          	j	ffffffffc0205472 <stride_dequeue+0x448>
ffffffffc0206296:	00893703          	ld	a4,8(s2)
ffffffffc020629a:	01093983          	ld	s3,16(s2)
ffffffffc020629e:	f42a                	sd	a0,40(sp)
ffffffffc02062a0:	f03a                	sd	a4,32(sp)
ffffffffc02062a2:	02098e63          	beqz	s3,ffffffffc02062de <stride_dequeue+0x12b4>
ffffffffc02062a6:	85be                	mv	a1,a5
ffffffffc02062a8:	854e                	mv	a0,s3
ffffffffc02062aa:	fc42                	sd	a6,56(sp)
ffffffffc02062ac:	f83e                	sd	a5,48(sp)
ffffffffc02062ae:	b41fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02062b2:	7e22                	ld	t3,40(sp)
ffffffffc02062b4:	77c2                	ld	a5,48(sp)
ffffffffc02062b6:	7862                	ld	a6,56(sp)
ffffffffc02062b8:	43c509e3          	beq	a0,t3,ffffffffc0206eea <stride_dequeue+0x1ec0>
ffffffffc02062bc:	6b8c                	ld	a1,16(a5)
ffffffffc02062be:	854e                	mv	a0,s3
ffffffffc02062c0:	0087bb03          	ld	s6,8(a5)
ffffffffc02062c4:	f842                	sd	a6,48(sp)
ffffffffc02062c6:	f43e                	sd	a5,40(sp)
ffffffffc02062c8:	b83fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02062cc:	77a2                	ld	a5,40(sp)
ffffffffc02062ce:	7842                	ld	a6,48(sp)
ffffffffc02062d0:	0167b823          	sd	s6,16(a5)
ffffffffc02062d4:	e788                	sd	a0,8(a5)
ffffffffc02062d6:	010c2b03          	lw	s6,16(s8)
ffffffffc02062da:	c111                	beqz	a0,ffffffffc02062de <stride_dequeue+0x12b4>
ffffffffc02062dc:	e11c                	sd	a5,0(a0)
ffffffffc02062de:	7702                	ld	a4,32(sp)
ffffffffc02062e0:	00f93423          	sd	a5,8(s2)
ffffffffc02062e4:	89da                	mv	s3,s6
ffffffffc02062e6:	00e93823          	sd	a4,16(s2)
ffffffffc02062ea:	0127b023          	sd	s2,0(a5)
ffffffffc02062ee:	e91fe06f          	j	ffffffffc020517e <stride_dequeue+0x154>
ffffffffc02062f2:	008a3783          	ld	a5,8(s4)
ffffffffc02062f6:	010a3983          	ld	s3,16(s4)
ffffffffc02062fa:	ec2a                	sd	a0,24(sp)
ffffffffc02062fc:	e83e                	sd	a5,16(sp)
ffffffffc02062fe:	5a098ce3          	beqz	s3,ffffffffc02070b6 <stride_dequeue+0x208c>
ffffffffc0206302:	85a6                	mv	a1,s1
ffffffffc0206304:	854e                	mv	a0,s3
ffffffffc0206306:	ae9fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc020630a:	67e2                	ld	a5,24(sp)
ffffffffc020630c:	50f500e3          	beq	a0,a5,ffffffffc020700c <stride_dequeue+0x1fe2>
ffffffffc0206310:	f43e                	sd	a5,40(sp)
ffffffffc0206312:	649c                	ld	a5,8(s1)
ffffffffc0206314:	0104b883          	ld	a7,16(s1)
ffffffffc0206318:	ec3e                	sd	a5,24(sp)
ffffffffc020631a:	04088263          	beqz	a7,ffffffffc020635e <stride_dequeue+0x1334>
ffffffffc020631e:	85c6                	mv	a1,a7
ffffffffc0206320:	854e                	mv	a0,s3
ffffffffc0206322:	f046                	sd	a7,32(sp)
ffffffffc0206324:	acbfe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206328:	77a2                	ld	a5,40(sp)
ffffffffc020632a:	7882                	ld	a7,32(sp)
ffffffffc020632c:	00f51463          	bne	a0,a5,ffffffffc0206334 <stride_dequeue+0x130a>
ffffffffc0206330:	2160106f          	j	ffffffffc0207546 <stride_dequeue+0x251c>
ffffffffc0206334:	0108b583          	ld	a1,16(a7)
ffffffffc0206338:	854e                	mv	a0,s3
ffffffffc020633a:	0088bb03          	ld	s6,8(a7)
ffffffffc020633e:	f046                	sd	a7,32(sp)
ffffffffc0206340:	b0bfe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206344:	7882                	ld	a7,32(sp)
ffffffffc0206346:	0168b823          	sd	s6,16(a7)
ffffffffc020634a:	00a8b423          	sd	a0,8(a7)
ffffffffc020634e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206352:	e119                	bnez	a0,ffffffffc0206358 <stride_dequeue+0x132e>
ffffffffc0206354:	56a0106f          	j	ffffffffc02078be <stride_dequeue+0x2894>
ffffffffc0206358:	01153023          	sd	a7,0(a0)
ffffffffc020635c:	89c6                	mv	s3,a7
ffffffffc020635e:	67e2                	ld	a5,24(sp)
ffffffffc0206360:	0134b423          	sd	s3,8(s1)
ffffffffc0206364:	e89c                	sd	a5,16(s1)
ffffffffc0206366:	0099b023          	sd	s1,0(s3)
ffffffffc020636a:	89a6                	mv	s3,s1
ffffffffc020636c:	67c2                	ld	a5,16(sp)
ffffffffc020636e:	013a3423          	sd	s3,8(s4)
ffffffffc0206372:	84d2                	mv	s1,s4
ffffffffc0206374:	00fa3823          	sd	a5,16(s4)
ffffffffc0206378:	0149b023          	sd	s4,0(s3)
ffffffffc020637c:	89da                	mv	s3,s6
ffffffffc020637e:	f00ff06f          	j	ffffffffc0205a7e <stride_dequeue+0xa54>
ffffffffc0206382:	0088b783          	ld	a5,8(a7)
ffffffffc0206386:	0108b983          	ld	s3,16(a7)
ffffffffc020638a:	f02a                	sd	a0,32(sp)
ffffffffc020638c:	ec3e                	sd	a5,24(sp)
ffffffffc020638e:	00099463          	bnez	s3,ffffffffc0206396 <stride_dequeue+0x136c>
ffffffffc0206392:	0d40106f          	j	ffffffffc0207466 <stride_dequeue+0x243c>
ffffffffc0206396:	85d2                	mv	a1,s4
ffffffffc0206398:	854e                	mv	a0,s3
ffffffffc020639a:	f446                	sd	a7,40(sp)
ffffffffc020639c:	a53fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02063a0:	7302                	ld	t1,32(sp)
ffffffffc02063a2:	78a2                	ld	a7,40(sp)
ffffffffc02063a4:	00651463          	bne	a0,t1,ffffffffc02063ac <stride_dequeue+0x1382>
ffffffffc02063a8:	06c0106f          	j	ffffffffc0207414 <stride_dequeue+0x23ea>
ffffffffc02063ac:	008a3783          	ld	a5,8(s4)
ffffffffc02063b0:	010a3e03          	ld	t3,16(s4)
ffffffffc02063b4:	fc1a                	sd	t1,56(sp)
ffffffffc02063b6:	f03e                	sd	a5,32(sp)
ffffffffc02063b8:	040e0663          	beqz	t3,ffffffffc0206404 <stride_dequeue+0x13da>
ffffffffc02063bc:	85f2                	mv	a1,t3
ffffffffc02063be:	854e                	mv	a0,s3
ffffffffc02063c0:	f846                	sd	a7,48(sp)
ffffffffc02063c2:	f472                	sd	t3,40(sp)
ffffffffc02063c4:	a2bfe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02063c8:	7362                	ld	t1,56(sp)
ffffffffc02063ca:	7e22                	ld	t3,40(sp)
ffffffffc02063cc:	78c2                	ld	a7,48(sp)
ffffffffc02063ce:	00651463          	bne	a0,t1,ffffffffc02063d6 <stride_dequeue+0x13ac>
ffffffffc02063d2:	32e0106f          	j	ffffffffc0207700 <stride_dequeue+0x26d6>
ffffffffc02063d6:	010e3583          	ld	a1,16(t3)
ffffffffc02063da:	854e                	mv	a0,s3
ffffffffc02063dc:	008e3b03          	ld	s6,8(t3)
ffffffffc02063e0:	f846                	sd	a7,48(sp)
ffffffffc02063e2:	f472                	sd	t3,40(sp)
ffffffffc02063e4:	a67fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02063e8:	7e22                	ld	t3,40(sp)
ffffffffc02063ea:	78c2                	ld	a7,48(sp)
ffffffffc02063ec:	016e3823          	sd	s6,16(t3)
ffffffffc02063f0:	00ae3423          	sd	a0,8(t3)
ffffffffc02063f4:	010c2b03          	lw	s6,16(s8)
ffffffffc02063f8:	e119                	bnez	a0,ffffffffc02063fe <stride_dequeue+0x13d4>
ffffffffc02063fa:	58a0106f          	j	ffffffffc0207984 <stride_dequeue+0x295a>
ffffffffc02063fe:	01c53023          	sd	t3,0(a0)
ffffffffc0206402:	89f2                	mv	s3,t3
ffffffffc0206404:	7782                	ld	a5,32(sp)
ffffffffc0206406:	013a3423          	sd	s3,8(s4)
ffffffffc020640a:	00fa3823          	sd	a5,16(s4)
ffffffffc020640e:	0149b023          	sd	s4,0(s3)
ffffffffc0206412:	89d2                	mv	s3,s4
ffffffffc0206414:	67e2                	ld	a5,24(sp)
ffffffffc0206416:	0138b423          	sd	s3,8(a7)
ffffffffc020641a:	8a46                	mv	s4,a7
ffffffffc020641c:	00f8b823          	sd	a5,16(a7)
ffffffffc0206420:	0119b023          	sd	a7,0(s3)
ffffffffc0206424:	89da                	mv	s3,s6
ffffffffc0206426:	f28ff06f          	j	ffffffffc0205b4e <stride_dequeue+0xb24>
ffffffffc020642a:	0088b783          	ld	a5,8(a7)
ffffffffc020642e:	0108b983          	ld	s3,16(a7)
ffffffffc0206432:	f02a                	sd	a0,32(sp)
ffffffffc0206434:	ec3e                	sd	a5,24(sp)
ffffffffc0206436:	00099463          	bnez	s3,ffffffffc020643e <stride_dequeue+0x1414>
ffffffffc020643a:	0320106f          	j	ffffffffc020746c <stride_dequeue+0x2442>
ffffffffc020643e:	85ee                	mv	a1,s11
ffffffffc0206440:	854e                	mv	a0,s3
ffffffffc0206442:	f446                	sd	a7,40(sp)
ffffffffc0206444:	9abfe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206448:	7302                	ld	t1,32(sp)
ffffffffc020644a:	78a2                	ld	a7,40(sp)
ffffffffc020644c:	466508e3          	beq	a0,t1,ffffffffc02070bc <stride_dequeue+0x2092>
ffffffffc0206450:	008db783          	ld	a5,8(s11)
ffffffffc0206454:	010dbe03          	ld	t3,16(s11)
ffffffffc0206458:	fc1a                	sd	t1,56(sp)
ffffffffc020645a:	f03e                	sd	a5,32(sp)
ffffffffc020645c:	040e0663          	beqz	t3,ffffffffc02064a8 <stride_dequeue+0x147e>
ffffffffc0206460:	85f2                	mv	a1,t3
ffffffffc0206462:	854e                	mv	a0,s3
ffffffffc0206464:	f846                	sd	a7,48(sp)
ffffffffc0206466:	f472                	sd	t3,40(sp)
ffffffffc0206468:	987fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc020646c:	7362                	ld	t1,56(sp)
ffffffffc020646e:	7e22                	ld	t3,40(sp)
ffffffffc0206470:	78c2                	ld	a7,48(sp)
ffffffffc0206472:	00651463          	bne	a0,t1,ffffffffc020647a <stride_dequeue+0x1450>
ffffffffc0206476:	3120106f          	j	ffffffffc0207788 <stride_dequeue+0x275e>
ffffffffc020647a:	010e3583          	ld	a1,16(t3)
ffffffffc020647e:	854e                	mv	a0,s3
ffffffffc0206480:	008e3b03          	ld	s6,8(t3)
ffffffffc0206484:	f846                	sd	a7,48(sp)
ffffffffc0206486:	f472                	sd	t3,40(sp)
ffffffffc0206488:	9c3fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020648c:	7e22                	ld	t3,40(sp)
ffffffffc020648e:	78c2                	ld	a7,48(sp)
ffffffffc0206490:	016e3823          	sd	s6,16(t3)
ffffffffc0206494:	00ae3423          	sd	a0,8(t3)
ffffffffc0206498:	010c2b03          	lw	s6,16(s8)
ffffffffc020649c:	e119                	bnez	a0,ffffffffc02064a2 <stride_dequeue+0x1478>
ffffffffc020649e:	51c0106f          	j	ffffffffc02079ba <stride_dequeue+0x2990>
ffffffffc02064a2:	01c53023          	sd	t3,0(a0)
ffffffffc02064a6:	89f2                	mv	s3,t3
ffffffffc02064a8:	7782                	ld	a5,32(sp)
ffffffffc02064aa:	013db423          	sd	s3,8(s11)
ffffffffc02064ae:	00fdb823          	sd	a5,16(s11)
ffffffffc02064b2:	01b9b023          	sd	s11,0(s3)
ffffffffc02064b6:	89ee                	mv	s3,s11
ffffffffc02064b8:	67e2                	ld	a5,24(sp)
ffffffffc02064ba:	0138b423          	sd	s3,8(a7)
ffffffffc02064be:	8dc6                	mv	s11,a7
ffffffffc02064c0:	00f8b823          	sd	a5,16(a7)
ffffffffc02064c4:	0119b023          	sd	a7,0(s3)
ffffffffc02064c8:	89da                	mv	s3,s6
ffffffffc02064ca:	831ff06f          	j	ffffffffc0205cfa <stride_dequeue+0xcd0>
ffffffffc02064ce:	0088b783          	ld	a5,8(a7)
ffffffffc02064d2:	0108b983          	ld	s3,16(a7)
ffffffffc02064d6:	ec2a                	sd	a0,24(sp)
ffffffffc02064d8:	e83e                	sd	a5,16(sp)
ffffffffc02064da:	00099463          	bnez	s3,ffffffffc02064e2 <stride_dequeue+0x14b8>
ffffffffc02064de:	7a10006f          	j	ffffffffc020747e <stride_dequeue+0x2454>
ffffffffc02064e2:	85b2                	mv	a1,a2
ffffffffc02064e4:	854e                	mv	a0,s3
ffffffffc02064e6:	f446                	sd	a7,40(sp)
ffffffffc02064e8:	907fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02064ec:	6362                	ld	t1,24(sp)
ffffffffc02064ee:	7602                	ld	a2,32(sp)
ffffffffc02064f0:	78a2                	ld	a7,40(sp)
ffffffffc02064f2:	426500e3          	beq	a0,t1,ffffffffc0207112 <stride_dequeue+0x20e8>
ffffffffc02064f6:	661c                	ld	a5,8(a2)
ffffffffc02064f8:	01063e03          	ld	t3,16(a2)
ffffffffc02064fc:	fc1a                	sd	t1,56(sp)
ffffffffc02064fe:	ec3e                	sd	a5,24(sp)
ffffffffc0206500:	040e0a63          	beqz	t3,ffffffffc0206554 <stride_dequeue+0x152a>
ffffffffc0206504:	85f2                	mv	a1,t3
ffffffffc0206506:	854e                	mv	a0,s3
ffffffffc0206508:	f846                	sd	a7,48(sp)
ffffffffc020650a:	f432                	sd	a2,40(sp)
ffffffffc020650c:	f072                	sd	t3,32(sp)
ffffffffc020650e:	8e1fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206512:	7362                	ld	t1,56(sp)
ffffffffc0206514:	7e02                	ld	t3,32(sp)
ffffffffc0206516:	7622                	ld	a2,40(sp)
ffffffffc0206518:	78c2                	ld	a7,48(sp)
ffffffffc020651a:	00651463          	bne	a0,t1,ffffffffc0206522 <stride_dequeue+0x14f8>
ffffffffc020651e:	20e0106f          	j	ffffffffc020772c <stride_dequeue+0x2702>
ffffffffc0206522:	010e3583          	ld	a1,16(t3)
ffffffffc0206526:	854e                	mv	a0,s3
ffffffffc0206528:	008e3b03          	ld	s6,8(t3)
ffffffffc020652c:	f846                	sd	a7,48(sp)
ffffffffc020652e:	f432                	sd	a2,40(sp)
ffffffffc0206530:	f072                	sd	t3,32(sp)
ffffffffc0206532:	919fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206536:	7e02                	ld	t3,32(sp)
ffffffffc0206538:	7622                	ld	a2,40(sp)
ffffffffc020653a:	78c2                	ld	a7,48(sp)
ffffffffc020653c:	016e3823          	sd	s6,16(t3)
ffffffffc0206540:	00ae3423          	sd	a0,8(t3)
ffffffffc0206544:	010c2b03          	lw	s6,16(s8)
ffffffffc0206548:	e119                	bnez	a0,ffffffffc020654e <stride_dequeue+0x1524>
ffffffffc020654a:	4400106f          	j	ffffffffc020798a <stride_dequeue+0x2960>
ffffffffc020654e:	01c53023          	sd	t3,0(a0)
ffffffffc0206552:	89f2                	mv	s3,t3
ffffffffc0206554:	67e2                	ld	a5,24(sp)
ffffffffc0206556:	01363423          	sd	s3,8(a2)
ffffffffc020655a:	ea1c                	sd	a5,16(a2)
ffffffffc020655c:	00c9b023          	sd	a2,0(s3)
ffffffffc0206560:	89b2                	mv	s3,a2
ffffffffc0206562:	67c2                	ld	a5,16(sp)
ffffffffc0206564:	0138b423          	sd	s3,8(a7)
ffffffffc0206568:	8646                	mv	a2,a7
ffffffffc020656a:	00f8b823          	sd	a5,16(a7)
ffffffffc020656e:	0119b023          	sd	a7,0(s3)
ffffffffc0206572:	89da                	mv	s3,s6
ffffffffc0206574:	eb6ff06f          	j	ffffffffc0205c2a <stride_dequeue+0xc00>
ffffffffc0206578:	008cb783          	ld	a5,8(s9)
ffffffffc020657c:	010cb983          	ld	s3,16(s9)
ffffffffc0206580:	f02a                	sd	a0,32(sp)
ffffffffc0206582:	ec3e                	sd	a5,24(sp)
ffffffffc0206584:	00099463          	bnez	s3,ffffffffc020658c <stride_dequeue+0x1562>
ffffffffc0206588:	6eb0006f          	j	ffffffffc0207472 <stride_dequeue+0x2448>
ffffffffc020658c:	85c2                	mv	a1,a6
ffffffffc020658e:	854e                	mv	a0,s3
ffffffffc0206590:	f442                	sd	a6,40(sp)
ffffffffc0206592:	85dfe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206596:	7302                	ld	t1,32(sp)
ffffffffc0206598:	7822                	ld	a6,40(sp)
ffffffffc020659a:	3e650ee3          	beq	a0,t1,ffffffffc0207196 <stride_dequeue+0x216c>
ffffffffc020659e:	00883783          	ld	a5,8(a6)
ffffffffc02065a2:	01083e03          	ld	t3,16(a6)
ffffffffc02065a6:	fc1a                	sd	t1,56(sp)
ffffffffc02065a8:	f03e                	sd	a5,32(sp)
ffffffffc02065aa:	040e0663          	beqz	t3,ffffffffc02065f6 <stride_dequeue+0x15cc>
ffffffffc02065ae:	85f2                	mv	a1,t3
ffffffffc02065b0:	854e                	mv	a0,s3
ffffffffc02065b2:	f842                	sd	a6,48(sp)
ffffffffc02065b4:	f472                	sd	t3,40(sp)
ffffffffc02065b6:	839fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02065ba:	7362                	ld	t1,56(sp)
ffffffffc02065bc:	7e22                	ld	t3,40(sp)
ffffffffc02065be:	7842                	ld	a6,48(sp)
ffffffffc02065c0:	00651463          	bne	a0,t1,ffffffffc02065c8 <stride_dequeue+0x159e>
ffffffffc02065c4:	2a20106f          	j	ffffffffc0207866 <stride_dequeue+0x283c>
ffffffffc02065c8:	010e3583          	ld	a1,16(t3)
ffffffffc02065cc:	854e                	mv	a0,s3
ffffffffc02065ce:	008e3b03          	ld	s6,8(t3)
ffffffffc02065d2:	f842                	sd	a6,48(sp)
ffffffffc02065d4:	f472                	sd	t3,40(sp)
ffffffffc02065d6:	875fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02065da:	7e22                	ld	t3,40(sp)
ffffffffc02065dc:	7842                	ld	a6,48(sp)
ffffffffc02065de:	016e3823          	sd	s6,16(t3)
ffffffffc02065e2:	00ae3423          	sd	a0,8(t3)
ffffffffc02065e6:	010c2b03          	lw	s6,16(s8)
ffffffffc02065ea:	e119                	bnez	a0,ffffffffc02065f0 <stride_dequeue+0x15c6>
ffffffffc02065ec:	35c0106f          	j	ffffffffc0207948 <stride_dequeue+0x291e>
ffffffffc02065f0:	01c53023          	sd	t3,0(a0)
ffffffffc02065f4:	89f2                	mv	s3,t3
ffffffffc02065f6:	7782                	ld	a5,32(sp)
ffffffffc02065f8:	01383423          	sd	s3,8(a6)
ffffffffc02065fc:	00f83823          	sd	a5,16(a6)
ffffffffc0206600:	0109b023          	sd	a6,0(s3)
ffffffffc0206604:	89c2                	mv	s3,a6
ffffffffc0206606:	67e2                	ld	a5,24(sp)
ffffffffc0206608:	013cb423          	sd	s3,8(s9)
ffffffffc020660c:	00fcb823          	sd	a5,16(s9)
ffffffffc0206610:	0199b023          	sd	s9,0(s3)
ffffffffc0206614:	89da                	mv	s3,s6
ffffffffc0206616:	f89fe06f          	j	ffffffffc020559e <stride_dequeue+0x574>
ffffffffc020661a:	661c                	ld	a5,8(a2)
ffffffffc020661c:	01063983          	ld	s3,16(a2)
ffffffffc0206620:	ec2a                	sd	a0,24(sp)
ffffffffc0206622:	e83e                	sd	a5,16(sp)
ffffffffc0206624:	64098ae3          	beqz	s3,ffffffffc0207478 <stride_dequeue+0x244e>
ffffffffc0206628:	85c2                	mv	a1,a6
ffffffffc020662a:	854e                	mv	a0,s3
ffffffffc020662c:	f432                	sd	a2,40(sp)
ffffffffc020662e:	f042                	sd	a6,32(sp)
ffffffffc0206630:	fbefe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206634:	6362                	ld	t1,24(sp)
ffffffffc0206636:	7802                	ld	a6,32(sp)
ffffffffc0206638:	7622                	ld	a2,40(sp)
ffffffffc020663a:	326509e3          	beq	a0,t1,ffffffffc020716c <stride_dequeue+0x2142>
ffffffffc020663e:	00883783          	ld	a5,8(a6)
ffffffffc0206642:	01083e03          	ld	t3,16(a6)
ffffffffc0206646:	fc1a                	sd	t1,56(sp)
ffffffffc0206648:	ec3e                	sd	a5,24(sp)
ffffffffc020664a:	040e0a63          	beqz	t3,ffffffffc020669e <stride_dequeue+0x1674>
ffffffffc020664e:	85f2                	mv	a1,t3
ffffffffc0206650:	854e                	mv	a0,s3
ffffffffc0206652:	f842                	sd	a6,48(sp)
ffffffffc0206654:	f432                	sd	a2,40(sp)
ffffffffc0206656:	f072                	sd	t3,32(sp)
ffffffffc0206658:	f96fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc020665c:	7362                	ld	t1,56(sp)
ffffffffc020665e:	7e02                	ld	t3,32(sp)
ffffffffc0206660:	7622                	ld	a2,40(sp)
ffffffffc0206662:	7842                	ld	a6,48(sp)
ffffffffc0206664:	00651463          	bne	a0,t1,ffffffffc020666c <stride_dequeue+0x1642>
ffffffffc0206668:	1760106f          	j	ffffffffc02077de <stride_dequeue+0x27b4>
ffffffffc020666c:	010e3583          	ld	a1,16(t3)
ffffffffc0206670:	854e                	mv	a0,s3
ffffffffc0206672:	008e3b03          	ld	s6,8(t3)
ffffffffc0206676:	f842                	sd	a6,48(sp)
ffffffffc0206678:	f432                	sd	a2,40(sp)
ffffffffc020667a:	f072                	sd	t3,32(sp)
ffffffffc020667c:	fcefe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206680:	7e02                	ld	t3,32(sp)
ffffffffc0206682:	7622                	ld	a2,40(sp)
ffffffffc0206684:	7842                	ld	a6,48(sp)
ffffffffc0206686:	016e3823          	sd	s6,16(t3)
ffffffffc020668a:	00ae3423          	sd	a0,8(t3)
ffffffffc020668e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206692:	e119                	bnez	a0,ffffffffc0206698 <stride_dequeue+0x166e>
ffffffffc0206694:	32c0106f          	j	ffffffffc02079c0 <stride_dequeue+0x2996>
ffffffffc0206698:	01c53023          	sd	t3,0(a0)
ffffffffc020669c:	89f2                	mv	s3,t3
ffffffffc020669e:	67e2                	ld	a5,24(sp)
ffffffffc02066a0:	01383423          	sd	s3,8(a6)
ffffffffc02066a4:	00f83823          	sd	a5,16(a6)
ffffffffc02066a8:	0109b023          	sd	a6,0(s3)
ffffffffc02066ac:	89c2                	mv	s3,a6
ffffffffc02066ae:	67c2                	ld	a5,16(sp)
ffffffffc02066b0:	01363423          	sd	s3,8(a2)
ffffffffc02066b4:	ea1c                	sd	a5,16(a2)
ffffffffc02066b6:	00c9b023          	sd	a2,0(s3)
ffffffffc02066ba:	89da                	mv	s3,s6
ffffffffc02066bc:	ffffe06f          	j	ffffffffc02056ba <stride_dequeue+0x690>
ffffffffc02066c0:	008a3783          	ld	a5,8(s4)
ffffffffc02066c4:	010a3983          	ld	s3,16(s4)
ffffffffc02066c8:	f02a                	sd	a0,32(sp)
ffffffffc02066ca:	ec3e                	sd	a5,24(sp)
ffffffffc02066cc:	5a098ce3          	beqz	s3,ffffffffc0207484 <stride_dequeue+0x245a>
ffffffffc02066d0:	85c2                	mv	a1,a6
ffffffffc02066d2:	854e                	mv	a0,s3
ffffffffc02066d4:	f442                	sd	a6,40(sp)
ffffffffc02066d6:	f18fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02066da:	7302                	ld	t1,32(sp)
ffffffffc02066dc:	7822                	ld	a6,40(sp)
ffffffffc02066de:	566501e3          	beq	a0,t1,ffffffffc0207440 <stride_dequeue+0x2416>
ffffffffc02066e2:	00883783          	ld	a5,8(a6)
ffffffffc02066e6:	01083e03          	ld	t3,16(a6)
ffffffffc02066ea:	fc1a                	sd	t1,56(sp)
ffffffffc02066ec:	f03e                	sd	a5,32(sp)
ffffffffc02066ee:	040e0663          	beqz	t3,ffffffffc020673a <stride_dequeue+0x1710>
ffffffffc02066f2:	85f2                	mv	a1,t3
ffffffffc02066f4:	854e                	mv	a0,s3
ffffffffc02066f6:	f842                	sd	a6,48(sp)
ffffffffc02066f8:	f472                	sd	t3,40(sp)
ffffffffc02066fa:	ef4fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02066fe:	7362                	ld	t1,56(sp)
ffffffffc0206700:	7e22                	ld	t3,40(sp)
ffffffffc0206702:	7842                	ld	a6,48(sp)
ffffffffc0206704:	00651463          	bne	a0,t1,ffffffffc020670c <stride_dequeue+0x16e2>
ffffffffc0206708:	18a0106f          	j	ffffffffc0207892 <stride_dequeue+0x2868>
ffffffffc020670c:	010e3583          	ld	a1,16(t3)
ffffffffc0206710:	854e                	mv	a0,s3
ffffffffc0206712:	008e3b03          	ld	s6,8(t3)
ffffffffc0206716:	f842                	sd	a6,48(sp)
ffffffffc0206718:	f472                	sd	t3,40(sp)
ffffffffc020671a:	f30fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020671e:	7e22                	ld	t3,40(sp)
ffffffffc0206720:	7842                	ld	a6,48(sp)
ffffffffc0206722:	016e3823          	sd	s6,16(t3)
ffffffffc0206726:	00ae3423          	sd	a0,8(t3)
ffffffffc020672a:	010c2b03          	lw	s6,16(s8)
ffffffffc020672e:	e119                	bnez	a0,ffffffffc0206734 <stride_dequeue+0x170a>
ffffffffc0206730:	1ee0106f          	j	ffffffffc020791e <stride_dequeue+0x28f4>
ffffffffc0206734:	01c53023          	sd	t3,0(a0)
ffffffffc0206738:	89f2                	mv	s3,t3
ffffffffc020673a:	7782                	ld	a5,32(sp)
ffffffffc020673c:	01383423          	sd	s3,8(a6)
ffffffffc0206740:	00f83823          	sd	a5,16(a6)
ffffffffc0206744:	0109b023          	sd	a6,0(s3)
ffffffffc0206748:	89c2                	mv	s3,a6
ffffffffc020674a:	67e2                	ld	a5,24(sp)
ffffffffc020674c:	013a3423          	sd	s3,8(s4)
ffffffffc0206750:	00fa3823          	sd	a5,16(s4)
ffffffffc0206754:	0149b023          	sd	s4,0(s3)
ffffffffc0206758:	89da                	mv	s3,s6
ffffffffc020675a:	85eff06f          	j	ffffffffc02057b8 <stride_dequeue+0x78e>
ffffffffc020675e:	008cb783          	ld	a5,8(s9)
ffffffffc0206762:	010cb983          	ld	s3,16(s9)
ffffffffc0206766:	f42a                	sd	a0,40(sp)
ffffffffc0206768:	f03e                	sd	a5,32(sp)
ffffffffc020676a:	04098163          	beqz	s3,ffffffffc02067ac <stride_dequeue+0x1782>
ffffffffc020676e:	859a                	mv	a1,t1
ffffffffc0206770:	854e                	mv	a0,s3
ffffffffc0206772:	fc42                	sd	a6,56(sp)
ffffffffc0206774:	f81a                	sd	t1,48(sp)
ffffffffc0206776:	e78fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc020677a:	7e22                	ld	t3,40(sp)
ffffffffc020677c:	7342                	ld	t1,48(sp)
ffffffffc020677e:	7862                	ld	a6,56(sp)
ffffffffc0206780:	11c505e3          	beq	a0,t3,ffffffffc020708a <stride_dequeue+0x2060>
ffffffffc0206784:	01033583          	ld	a1,16(t1)
ffffffffc0206788:	854e                	mv	a0,s3
ffffffffc020678a:	00833b03          	ld	s6,8(t1)
ffffffffc020678e:	f842                	sd	a6,48(sp)
ffffffffc0206790:	f41a                	sd	t1,40(sp)
ffffffffc0206792:	eb8fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206796:	7322                	ld	t1,40(sp)
ffffffffc0206798:	7842                	ld	a6,48(sp)
ffffffffc020679a:	01633823          	sd	s6,16(t1)
ffffffffc020679e:	00a33423          	sd	a0,8(t1)
ffffffffc02067a2:	010c2b03          	lw	s6,16(s8)
ffffffffc02067a6:	c119                	beqz	a0,ffffffffc02067ac <stride_dequeue+0x1782>
ffffffffc02067a8:	00653023          	sd	t1,0(a0)
ffffffffc02067ac:	7782                	ld	a5,32(sp)
ffffffffc02067ae:	006cb423          	sd	t1,8(s9)
ffffffffc02067b2:	89da                	mv	s3,s6
ffffffffc02067b4:	00fcb823          	sd	a5,16(s9)
ffffffffc02067b8:	01933023          	sd	s9,0(t1)
ffffffffc02067bc:	9aeff06f          	j	ffffffffc020596a <stride_dequeue+0x940>
ffffffffc02067c0:	008db783          	ld	a5,8(s11)
ffffffffc02067c4:	010db983          	ld	s3,16(s11)
ffffffffc02067c8:	f02a                	sd	a0,32(sp)
ffffffffc02067ca:	ec3e                	sd	a5,24(sp)
ffffffffc02067cc:	04098563          	beqz	s3,ffffffffc0206816 <stride_dequeue+0x17ec>
ffffffffc02067d0:	859a                	mv	a1,t1
ffffffffc02067d2:	854e                	mv	a0,s3
ffffffffc02067d4:	fc42                	sd	a6,56(sp)
ffffffffc02067d6:	f832                	sd	a2,48(sp)
ffffffffc02067d8:	f41a                	sd	t1,40(sp)
ffffffffc02067da:	e14fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02067de:	7e02                	ld	t3,32(sp)
ffffffffc02067e0:	7322                	ld	t1,40(sp)
ffffffffc02067e2:	7642                	ld	a2,48(sp)
ffffffffc02067e4:	7862                	ld	a6,56(sp)
ffffffffc02067e6:	15c50be3          	beq	a0,t3,ffffffffc020713c <stride_dequeue+0x2112>
ffffffffc02067ea:	01033583          	ld	a1,16(t1)
ffffffffc02067ee:	854e                	mv	a0,s3
ffffffffc02067f0:	00833b03          	ld	s6,8(t1)
ffffffffc02067f4:	f842                	sd	a6,48(sp)
ffffffffc02067f6:	f432                	sd	a2,40(sp)
ffffffffc02067f8:	f01a                	sd	t1,32(sp)
ffffffffc02067fa:	e50fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02067fe:	7302                	ld	t1,32(sp)
ffffffffc0206800:	7622                	ld	a2,40(sp)
ffffffffc0206802:	7842                	ld	a6,48(sp)
ffffffffc0206804:	01633823          	sd	s6,16(t1)
ffffffffc0206808:	00a33423          	sd	a0,8(t1)
ffffffffc020680c:	010c2b03          	lw	s6,16(s8)
ffffffffc0206810:	c119                	beqz	a0,ffffffffc0206816 <stride_dequeue+0x17ec>
ffffffffc0206812:	00653023          	sd	t1,0(a0)
ffffffffc0206816:	67e2                	ld	a5,24(sp)
ffffffffc0206818:	006db423          	sd	t1,8(s11)
ffffffffc020681c:	89da                	mv	s3,s6
ffffffffc020681e:	00fdb823          	sd	a5,16(s11)
ffffffffc0206822:	01b33023          	sd	s11,0(t1)
ffffffffc0206826:	c3dfe06f          	j	ffffffffc0205462 <stride_dequeue+0x438>
ffffffffc020682a:	0088b783          	ld	a5,8(a7)
ffffffffc020682e:	0108b983          	ld	s3,16(a7)
ffffffffc0206832:	f42a                	sd	a0,40(sp)
ffffffffc0206834:	f03e                	sd	a5,32(sp)
ffffffffc0206836:	04098063          	beqz	s3,ffffffffc0206876 <stride_dequeue+0x184c>
ffffffffc020683a:	85c2                	mv	a1,a6
ffffffffc020683c:	854e                	mv	a0,s3
ffffffffc020683e:	fc46                	sd	a7,56(sp)
ffffffffc0206840:	daefe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206844:	7e22                	ld	t3,40(sp)
ffffffffc0206846:	7842                	ld	a6,48(sp)
ffffffffc0206848:	78e2                	ld	a7,56(sp)
ffffffffc020684a:	29c50de3          	beq	a0,t3,ffffffffc02072e4 <stride_dequeue+0x22ba>
ffffffffc020684e:	01083583          	ld	a1,16(a6)
ffffffffc0206852:	854e                	mv	a0,s3
ffffffffc0206854:	00883b03          	ld	s6,8(a6)
ffffffffc0206858:	f846                	sd	a7,48(sp)
ffffffffc020685a:	f442                	sd	a6,40(sp)
ffffffffc020685c:	deefe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206860:	7822                	ld	a6,40(sp)
ffffffffc0206862:	78c2                	ld	a7,48(sp)
ffffffffc0206864:	01683823          	sd	s6,16(a6)
ffffffffc0206868:	00a83423          	sd	a0,8(a6)
ffffffffc020686c:	010c2b03          	lw	s6,16(s8)
ffffffffc0206870:	c119                	beqz	a0,ffffffffc0206876 <stride_dequeue+0x184c>
ffffffffc0206872:	01053023          	sd	a6,0(a0)
ffffffffc0206876:	7782                	ld	a5,32(sp)
ffffffffc0206878:	0108b423          	sd	a6,8(a7)
ffffffffc020687c:	89da                	mv	s3,s6
ffffffffc020687e:	00f8b823          	sd	a5,16(a7)
ffffffffc0206882:	01183023          	sd	a7,0(a6)
ffffffffc0206886:	8846                	mv	a6,a7
ffffffffc0206888:	d08ff06f          	j	ffffffffc0205d90 <stride_dequeue+0xd66>
ffffffffc020688c:	008db783          	ld	a5,8(s11)
ffffffffc0206890:	010db983          	ld	s3,16(s11)
ffffffffc0206894:	f42a                	sd	a0,40(sp)
ffffffffc0206896:	f03e                	sd	a5,32(sp)
ffffffffc0206898:	04098163          	beqz	s3,ffffffffc02068da <stride_dequeue+0x18b0>
ffffffffc020689c:	859a                	mv	a1,t1
ffffffffc020689e:	854e                	mv	a0,s3
ffffffffc02068a0:	fc42                	sd	a6,56(sp)
ffffffffc02068a2:	f81a                	sd	t1,48(sp)
ffffffffc02068a4:	d4afe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02068a8:	7e22                	ld	t3,40(sp)
ffffffffc02068aa:	7342                	ld	t1,48(sp)
ffffffffc02068ac:	7862                	ld	a6,56(sp)
ffffffffc02068ae:	29c507e3          	beq	a0,t3,ffffffffc020733c <stride_dequeue+0x2312>
ffffffffc02068b2:	01033583          	ld	a1,16(t1)
ffffffffc02068b6:	854e                	mv	a0,s3
ffffffffc02068b8:	00833b03          	ld	s6,8(t1)
ffffffffc02068bc:	f842                	sd	a6,48(sp)
ffffffffc02068be:	f41a                	sd	t1,40(sp)
ffffffffc02068c0:	d8afe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02068c4:	7322                	ld	t1,40(sp)
ffffffffc02068c6:	7842                	ld	a6,48(sp)
ffffffffc02068c8:	01633823          	sd	s6,16(t1)
ffffffffc02068cc:	00a33423          	sd	a0,8(t1)
ffffffffc02068d0:	010c2b03          	lw	s6,16(s8)
ffffffffc02068d4:	c119                	beqz	a0,ffffffffc02068da <stride_dequeue+0x18b0>
ffffffffc02068d6:	00653023          	sd	t1,0(a0)
ffffffffc02068da:	7782                	ld	a5,32(sp)
ffffffffc02068dc:	006db423          	sd	t1,8(s11)
ffffffffc02068e0:	89da                	mv	s3,s6
ffffffffc02068e2:	00fdb823          	sd	a5,16(s11)
ffffffffc02068e6:	01b33023          	sd	s11,0(t1)
ffffffffc02068ea:	a1ffe06f          	j	ffffffffc0205308 <stride_dequeue+0x2de>
ffffffffc02068ee:	0088b783          	ld	a5,8(a7)
ffffffffc02068f2:	0108b983          	ld	s3,16(a7)
ffffffffc02068f6:	f42a                	sd	a0,40(sp)
ffffffffc02068f8:	f03e                	sd	a5,32(sp)
ffffffffc02068fa:	04098063          	beqz	s3,ffffffffc020693a <stride_dequeue+0x1910>
ffffffffc02068fe:	859a                	mv	a1,t1
ffffffffc0206900:	854e                	mv	a0,s3
ffffffffc0206902:	fc46                	sd	a7,56(sp)
ffffffffc0206904:	ceafe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206908:	7e22                	ld	t3,40(sp)
ffffffffc020690a:	7342                	ld	t1,48(sp)
ffffffffc020690c:	78e2                	ld	a7,56(sp)
ffffffffc020690e:	73c50263          	beq	a0,t3,ffffffffc0207032 <stride_dequeue+0x2008>
ffffffffc0206912:	01033583          	ld	a1,16(t1)
ffffffffc0206916:	854e                	mv	a0,s3
ffffffffc0206918:	00833b03          	ld	s6,8(t1)
ffffffffc020691c:	f846                	sd	a7,48(sp)
ffffffffc020691e:	f41a                	sd	t1,40(sp)
ffffffffc0206920:	d2afe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206924:	7322                	ld	t1,40(sp)
ffffffffc0206926:	78c2                	ld	a7,48(sp)
ffffffffc0206928:	01633823          	sd	s6,16(t1)
ffffffffc020692c:	00a33423          	sd	a0,8(t1)
ffffffffc0206930:	010c2b03          	lw	s6,16(s8)
ffffffffc0206934:	c119                	beqz	a0,ffffffffc020693a <stride_dequeue+0x1910>
ffffffffc0206936:	00653023          	sd	t1,0(a0)
ffffffffc020693a:	7782                	ld	a5,32(sp)
ffffffffc020693c:	0068b423          	sd	t1,8(a7)
ffffffffc0206940:	89da                	mv	s3,s6
ffffffffc0206942:	00f8b823          	sd	a5,16(a7)
ffffffffc0206946:	01133023          	sd	a7,0(t1)
ffffffffc020694a:	f3dfe06f          	j	ffffffffc0205886 <stride_dequeue+0x85c>
ffffffffc020694e:	01093503          	ld	a0,16(s2)
ffffffffc0206952:	00893983          	ld	s3,8(s2)
ffffffffc0206956:	85da                	mv	a1,s6
ffffffffc0206958:	cf2fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020695c:	00a93423          	sd	a0,8(s2)
ffffffffc0206960:	01393823          	sd	s3,16(s2)
ffffffffc0206964:	7822                	ld	a6,40(sp)
ffffffffc0206966:	77c2                	ld	a5,48(sp)
ffffffffc0206968:	010c2983          	lw	s3,16(s8)
ffffffffc020696c:	e119                	bnez	a0,ffffffffc0206972 <stride_dequeue+0x1948>
ffffffffc020696e:	803fe06f          	j	ffffffffc0205170 <stride_dequeue+0x146>
ffffffffc0206972:	01253023          	sd	s2,0(a0)
ffffffffc0206976:	ffafe06f          	j	ffffffffc0205170 <stride_dequeue+0x146>
ffffffffc020697a:	0089b783          	ld	a5,8(s3)
ffffffffc020697e:	0109b803          	ld	a6,16(s3)
ffffffffc0206982:	f42a                	sd	a0,40(sp)
ffffffffc0206984:	ec3e                	sd	a5,24(sp)
ffffffffc0206986:	02080b63          	beqz	a6,ffffffffc02069bc <stride_dequeue+0x1992>
ffffffffc020698a:	8542                	mv	a0,a6
ffffffffc020698c:	85d2                	mv	a1,s4
ffffffffc020698e:	f042                	sd	a6,32(sp)
ffffffffc0206990:	c5efe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206994:	77a2                	ld	a5,40(sp)
ffffffffc0206996:	7802                	ld	a6,32(sp)
ffffffffc0206998:	3cf50be3          	beq	a0,a5,ffffffffc020756e <stride_dequeue+0x2544>
ffffffffc020699c:	010a3583          	ld	a1,16(s4)
ffffffffc02069a0:	008a3b03          	ld	s6,8(s4)
ffffffffc02069a4:	8542                	mv	a0,a6
ffffffffc02069a6:	ca4fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02069aa:	00aa3423          	sd	a0,8(s4)
ffffffffc02069ae:	016a3823          	sd	s6,16(s4)
ffffffffc02069b2:	010c2b03          	lw	s6,16(s8)
ffffffffc02069b6:	c119                	beqz	a0,ffffffffc02069bc <stride_dequeue+0x1992>
ffffffffc02069b8:	01453023          	sd	s4,0(a0)
ffffffffc02069bc:	67e2                	ld	a5,24(sp)
ffffffffc02069be:	0149b423          	sd	s4,8(s3)
ffffffffc02069c2:	00f9b823          	sd	a5,16(s3)
ffffffffc02069c6:	013a3023          	sd	s3,0(s4)
ffffffffc02069ca:	8a4e                	mv	s4,s3
ffffffffc02069cc:	c90ff06f          	j	ffffffffc0205e5c <stride_dequeue+0xe32>
ffffffffc02069d0:	0089b783          	ld	a5,8(s3)
ffffffffc02069d4:	0109b803          	ld	a6,16(s3)
ffffffffc02069d8:	f42a                	sd	a0,40(sp)
ffffffffc02069da:	ec3e                	sd	a5,24(sp)
ffffffffc02069dc:	02080b63          	beqz	a6,ffffffffc0206a12 <stride_dequeue+0x19e8>
ffffffffc02069e0:	8542                	mv	a0,a6
ffffffffc02069e2:	85e6                	mv	a1,s9
ffffffffc02069e4:	f042                	sd	a6,32(sp)
ffffffffc02069e6:	c08fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc02069ea:	77a2                	ld	a5,40(sp)
ffffffffc02069ec:	7802                	ld	a6,32(sp)
ffffffffc02069ee:	28f50ee3          	beq	a0,a5,ffffffffc020748a <stride_dequeue+0x2460>
ffffffffc02069f2:	010cb583          	ld	a1,16(s9)
ffffffffc02069f6:	008cbb03          	ld	s6,8(s9)
ffffffffc02069fa:	8542                	mv	a0,a6
ffffffffc02069fc:	c4efe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206a00:	00acb423          	sd	a0,8(s9)
ffffffffc0206a04:	016cb823          	sd	s6,16(s9)
ffffffffc0206a08:	010c2b03          	lw	s6,16(s8)
ffffffffc0206a0c:	c119                	beqz	a0,ffffffffc0206a12 <stride_dequeue+0x19e8>
ffffffffc0206a0e:	01953023          	sd	s9,0(a0)
ffffffffc0206a12:	67e2                	ld	a5,24(sp)
ffffffffc0206a14:	0199b423          	sd	s9,8(s3)
ffffffffc0206a18:	00f9b823          	sd	a5,16(s3)
ffffffffc0206a1c:	013cb023          	sd	s3,0(s9)
ffffffffc0206a20:	8cce                	mv	s9,s3
ffffffffc0206a22:	de4ff06f          	j	ffffffffc0206006 <stride_dequeue+0xfdc>
ffffffffc0206a26:	0089b783          	ld	a5,8(s3)
ffffffffc0206a2a:	0109b803          	ld	a6,16(s3)
ffffffffc0206a2e:	f42a                	sd	a0,40(sp)
ffffffffc0206a30:	e83e                	sd	a5,16(sp)
ffffffffc0206a32:	02080f63          	beqz	a6,ffffffffc0206a70 <stride_dequeue+0x1a46>
ffffffffc0206a36:	8542                	mv	a0,a6
ffffffffc0206a38:	85d2                	mv	a1,s4
ffffffffc0206a3a:	f032                	sd	a2,32(sp)
ffffffffc0206a3c:	ec42                	sd	a6,24(sp)
ffffffffc0206a3e:	bb0fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206a42:	77a2                	ld	a5,40(sp)
ffffffffc0206a44:	6862                	ld	a6,24(sp)
ffffffffc0206a46:	7602                	ld	a2,32(sp)
ffffffffc0206a48:	26f506e3          	beq	a0,a5,ffffffffc02074b4 <stride_dequeue+0x248a>
ffffffffc0206a4c:	010a3583          	ld	a1,16(s4)
ffffffffc0206a50:	008a3b03          	ld	s6,8(s4)
ffffffffc0206a54:	8542                	mv	a0,a6
ffffffffc0206a56:	ec32                	sd	a2,24(sp)
ffffffffc0206a58:	bf2fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206a5c:	00aa3423          	sd	a0,8(s4)
ffffffffc0206a60:	016a3823          	sd	s6,16(s4)
ffffffffc0206a64:	6662                	ld	a2,24(sp)
ffffffffc0206a66:	010c2b03          	lw	s6,16(s8)
ffffffffc0206a6a:	c119                	beqz	a0,ffffffffc0206a70 <stride_dequeue+0x1a46>
ffffffffc0206a6c:	01453023          	sd	s4,0(a0)
ffffffffc0206a70:	67c2                	ld	a5,16(sp)
ffffffffc0206a72:	0149b423          	sd	s4,8(s3)
ffffffffc0206a76:	00f9b823          	sd	a5,16(s3)
ffffffffc0206a7a:	013a3023          	sd	s3,0(s4)
ffffffffc0206a7e:	8a4e                	mv	s4,s3
ffffffffc0206a80:	cb8ff06f          	j	ffffffffc0205f38 <stride_dequeue+0xf0e>
ffffffffc0206a84:	008a3783          	ld	a5,8(s4)
ffffffffc0206a88:	010a3883          	ld	a7,16(s4)
ffffffffc0206a8c:	f42a                	sd	a0,40(sp)
ffffffffc0206a8e:	ec3e                	sd	a5,24(sp)
ffffffffc0206a90:	02088b63          	beqz	a7,ffffffffc0206ac6 <stride_dequeue+0x1a9c>
ffffffffc0206a94:	8546                	mv	a0,a7
ffffffffc0206a96:	85ce                	mv	a1,s3
ffffffffc0206a98:	f046                	sd	a7,32(sp)
ffffffffc0206a9a:	b54fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206a9e:	77a2                	ld	a5,40(sp)
ffffffffc0206aa0:	7882                	ld	a7,32(sp)
ffffffffc0206aa2:	26f501e3          	beq	a0,a5,ffffffffc0207504 <stride_dequeue+0x24da>
ffffffffc0206aa6:	0109b583          	ld	a1,16(s3)
ffffffffc0206aaa:	0089bb03          	ld	s6,8(s3)
ffffffffc0206aae:	8546                	mv	a0,a7
ffffffffc0206ab0:	b9afe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206ab4:	00a9b423          	sd	a0,8(s3)
ffffffffc0206ab8:	0169b823          	sd	s6,16(s3)
ffffffffc0206abc:	010c2b03          	lw	s6,16(s8)
ffffffffc0206ac0:	c119                	beqz	a0,ffffffffc0206ac6 <stride_dequeue+0x1a9c>
ffffffffc0206ac2:	01353023          	sd	s3,0(a0)
ffffffffc0206ac6:	67e2                	ld	a5,24(sp)
ffffffffc0206ac8:	013a3423          	sd	s3,8(s4)
ffffffffc0206acc:	00fa3823          	sd	a5,16(s4)
ffffffffc0206ad0:	0149b023          	sd	s4,0(s3)
ffffffffc0206ad4:	89d2                	mv	s3,s4
ffffffffc0206ad6:	f9bfe06f          	j	ffffffffc0205a70 <stride_dequeue+0xa46>
ffffffffc0206ada:	008a3783          	ld	a5,8(s4)
ffffffffc0206ade:	010a3883          	ld	a7,16(s4)
ffffffffc0206ae2:	fc2a                	sd	a0,56(sp)
ffffffffc0206ae4:	f03e                	sd	a5,32(sp)
ffffffffc0206ae6:	02088f63          	beqz	a7,ffffffffc0206b24 <stride_dequeue+0x1afa>
ffffffffc0206aea:	8546                	mv	a0,a7
ffffffffc0206aec:	85ce                	mv	a1,s3
ffffffffc0206aee:	f842                	sd	a6,48(sp)
ffffffffc0206af0:	f446                	sd	a7,40(sp)
ffffffffc0206af2:	afcfe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206af6:	7e62                	ld	t3,56(sp)
ffffffffc0206af8:	78a2                	ld	a7,40(sp)
ffffffffc0206afa:	7842                	ld	a6,48(sp)
ffffffffc0206afc:	35c509e3          	beq	a0,t3,ffffffffc020764e <stride_dequeue+0x2624>
ffffffffc0206b00:	0109b583          	ld	a1,16(s3)
ffffffffc0206b04:	0089bb03          	ld	s6,8(s3)
ffffffffc0206b08:	8546                	mv	a0,a7
ffffffffc0206b0a:	f442                	sd	a6,40(sp)
ffffffffc0206b0c:	b3efe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206b10:	00a9b423          	sd	a0,8(s3)
ffffffffc0206b14:	0169b823          	sd	s6,16(s3)
ffffffffc0206b18:	7822                	ld	a6,40(sp)
ffffffffc0206b1a:	010c2b03          	lw	s6,16(s8)
ffffffffc0206b1e:	c119                	beqz	a0,ffffffffc0206b24 <stride_dequeue+0x1afa>
ffffffffc0206b20:	01353023          	sd	s3,0(a0)
ffffffffc0206b24:	7782                	ld	a5,32(sp)
ffffffffc0206b26:	013a3423          	sd	s3,8(s4)
ffffffffc0206b2a:	00fa3823          	sd	a5,16(s4)
ffffffffc0206b2e:	0149b023          	sd	s4,0(s3)
ffffffffc0206b32:	89d2                	mv	s3,s4
ffffffffc0206b34:	c73fe06f          	j	ffffffffc02057a6 <stride_dequeue+0x77c>
ffffffffc0206b38:	661c                	ld	a5,8(a2)
ffffffffc0206b3a:	01063883          	ld	a7,16(a2)
ffffffffc0206b3e:	fc2a                	sd	a0,56(sp)
ffffffffc0206b40:	ec3e                	sd	a5,24(sp)
ffffffffc0206b42:	04088363          	beqz	a7,ffffffffc0206b88 <stride_dequeue+0x1b5e>
ffffffffc0206b46:	8546                	mv	a0,a7
ffffffffc0206b48:	85ce                	mv	a1,s3
ffffffffc0206b4a:	f842                	sd	a6,48(sp)
ffffffffc0206b4c:	f432                	sd	a2,40(sp)
ffffffffc0206b4e:	f046                	sd	a7,32(sp)
ffffffffc0206b50:	a9efe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206b54:	7e62                	ld	t3,56(sp)
ffffffffc0206b56:	7882                	ld	a7,32(sp)
ffffffffc0206b58:	7622                	ld	a2,40(sp)
ffffffffc0206b5a:	7842                	ld	a6,48(sp)
ffffffffc0206b5c:	25c501e3          	beq	a0,t3,ffffffffc020759e <stride_dequeue+0x2574>
ffffffffc0206b60:	0109b583          	ld	a1,16(s3)
ffffffffc0206b64:	0089bb03          	ld	s6,8(s3)
ffffffffc0206b68:	8546                	mv	a0,a7
ffffffffc0206b6a:	f442                	sd	a6,40(sp)
ffffffffc0206b6c:	f032                	sd	a2,32(sp)
ffffffffc0206b6e:	adcfe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206b72:	00a9b423          	sd	a0,8(s3)
ffffffffc0206b76:	0169b823          	sd	s6,16(s3)
ffffffffc0206b7a:	7602                	ld	a2,32(sp)
ffffffffc0206b7c:	7822                	ld	a6,40(sp)
ffffffffc0206b7e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206b82:	c119                	beqz	a0,ffffffffc0206b88 <stride_dequeue+0x1b5e>
ffffffffc0206b84:	01353023          	sd	s3,0(a0)
ffffffffc0206b88:	67e2                	ld	a5,24(sp)
ffffffffc0206b8a:	01363423          	sd	s3,8(a2)
ffffffffc0206b8e:	ea1c                	sd	a5,16(a2)
ffffffffc0206b90:	00c9b023          	sd	a2,0(s3)
ffffffffc0206b94:	89b2                	mv	s3,a2
ffffffffc0206b96:	b13fe06f          	j	ffffffffc02056a8 <stride_dequeue+0x67e>
ffffffffc0206b9a:	89c6                	mv	s3,a7
ffffffffc0206b9c:	9e4ff06f          	j	ffffffffc0205d80 <stride_dequeue+0xd56>
ffffffffc0206ba0:	0088b783          	ld	a5,8(a7)
ffffffffc0206ba4:	0108b803          	ld	a6,16(a7)
ffffffffc0206ba8:	fc2a                	sd	a0,56(sp)
ffffffffc0206baa:	f03e                	sd	a5,32(sp)
ffffffffc0206bac:	02080f63          	beqz	a6,ffffffffc0206bea <stride_dequeue+0x1bc0>
ffffffffc0206bb0:	8542                	mv	a0,a6
ffffffffc0206bb2:	85ce                	mv	a1,s3
ffffffffc0206bb4:	f846                	sd	a7,48(sp)
ffffffffc0206bb6:	f442                	sd	a6,40(sp)
ffffffffc0206bb8:	a36fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206bbc:	7e62                	ld	t3,56(sp)
ffffffffc0206bbe:	7822                	ld	a6,40(sp)
ffffffffc0206bc0:	78c2                	ld	a7,48(sp)
ffffffffc0206bc2:	47c50ce3          	beq	a0,t3,ffffffffc020783a <stride_dequeue+0x2810>
ffffffffc0206bc6:	0109b583          	ld	a1,16(s3)
ffffffffc0206bca:	0089bb03          	ld	s6,8(s3)
ffffffffc0206bce:	8542                	mv	a0,a6
ffffffffc0206bd0:	f446                	sd	a7,40(sp)
ffffffffc0206bd2:	a78fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206bd6:	00a9b423          	sd	a0,8(s3)
ffffffffc0206bda:	0169b823          	sd	s6,16(s3)
ffffffffc0206bde:	78a2                	ld	a7,40(sp)
ffffffffc0206be0:	010c2b03          	lw	s6,16(s8)
ffffffffc0206be4:	c119                	beqz	a0,ffffffffc0206bea <stride_dequeue+0x1bc0>
ffffffffc0206be6:	01353023          	sd	s3,0(a0)
ffffffffc0206bea:	7782                	ld	a5,32(sp)
ffffffffc0206bec:	0138b423          	sd	s3,8(a7)
ffffffffc0206bf0:	00f8b823          	sd	a5,16(a7)
ffffffffc0206bf4:	0119b023          	sd	a7,0(s3)
ffffffffc0206bf8:	89c6                	mv	s3,a7
ffffffffc0206bfa:	8f0ff06f          	j	ffffffffc0205cea <stride_dequeue+0xcc0>
ffffffffc0206bfe:	0088b783          	ld	a5,8(a7)
ffffffffc0206c02:	0108b803          	ld	a6,16(a7)
ffffffffc0206c06:	fc2a                	sd	a0,56(sp)
ffffffffc0206c08:	f03e                	sd	a5,32(sp)
ffffffffc0206c0a:	02080f63          	beqz	a6,ffffffffc0206c48 <stride_dequeue+0x1c1e>
ffffffffc0206c0e:	8542                	mv	a0,a6
ffffffffc0206c10:	85ce                	mv	a1,s3
ffffffffc0206c12:	f846                	sd	a7,48(sp)
ffffffffc0206c14:	f442                	sd	a6,40(sp)
ffffffffc0206c16:	9d8fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206c1a:	7e62                	ld	t3,56(sp)
ffffffffc0206c1c:	7822                	ld	a6,40(sp)
ffffffffc0206c1e:	78c2                	ld	a7,48(sp)
ffffffffc0206c20:	25c50de3          	beq	a0,t3,ffffffffc020767a <stride_dequeue+0x2650>
ffffffffc0206c24:	0109b583          	ld	a1,16(s3)
ffffffffc0206c28:	0089bb03          	ld	s6,8(s3)
ffffffffc0206c2c:	8542                	mv	a0,a6
ffffffffc0206c2e:	f446                	sd	a7,40(sp)
ffffffffc0206c30:	a1afe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206c34:	00a9b423          	sd	a0,8(s3)
ffffffffc0206c38:	0169b823          	sd	s6,16(s3)
ffffffffc0206c3c:	78a2                	ld	a7,40(sp)
ffffffffc0206c3e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206c42:	c119                	beqz	a0,ffffffffc0206c48 <stride_dequeue+0x1c1e>
ffffffffc0206c44:	01353023          	sd	s3,0(a0)
ffffffffc0206c48:	7782                	ld	a5,32(sp)
ffffffffc0206c4a:	0138b423          	sd	s3,8(a7)
ffffffffc0206c4e:	00f8b823          	sd	a5,16(a7)
ffffffffc0206c52:	0119b023          	sd	a7,0(s3)
ffffffffc0206c56:	89c6                	mv	s3,a7
ffffffffc0206c58:	ee7fe06f          	j	ffffffffc0205b3e <stride_dequeue+0xb14>
ffffffffc0206c5c:	0088b783          	ld	a5,8(a7)
ffffffffc0206c60:	0108b803          	ld	a6,16(a7)
ffffffffc0206c64:	fc2a                	sd	a0,56(sp)
ffffffffc0206c66:	ec3e                	sd	a5,24(sp)
ffffffffc0206c68:	04080263          	beqz	a6,ffffffffc0206cac <stride_dequeue+0x1c82>
ffffffffc0206c6c:	8542                	mv	a0,a6
ffffffffc0206c6e:	85ce                	mv	a1,s3
ffffffffc0206c70:	f846                	sd	a7,48(sp)
ffffffffc0206c72:	f042                	sd	a6,32(sp)
ffffffffc0206c74:	97afe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206c78:	7e62                	ld	t3,56(sp)
ffffffffc0206c7a:	7802                	ld	a6,32(sp)
ffffffffc0206c7c:	7622                	ld	a2,40(sp)
ffffffffc0206c7e:	78c2                	ld	a7,48(sp)
ffffffffc0206c80:	23c503e3          	beq	a0,t3,ffffffffc02076a6 <stride_dequeue+0x267c>
ffffffffc0206c84:	0109b583          	ld	a1,16(s3)
ffffffffc0206c88:	0089bb03          	ld	s6,8(s3)
ffffffffc0206c8c:	8542                	mv	a0,a6
ffffffffc0206c8e:	f446                	sd	a7,40(sp)
ffffffffc0206c90:	f032                	sd	a2,32(sp)
ffffffffc0206c92:	9b8fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206c96:	00a9b423          	sd	a0,8(s3)
ffffffffc0206c9a:	0169b823          	sd	s6,16(s3)
ffffffffc0206c9e:	7602                	ld	a2,32(sp)
ffffffffc0206ca0:	78a2                	ld	a7,40(sp)
ffffffffc0206ca2:	010c2b03          	lw	s6,16(s8)
ffffffffc0206ca6:	c119                	beqz	a0,ffffffffc0206cac <stride_dequeue+0x1c82>
ffffffffc0206ca8:	01353023          	sd	s3,0(a0)
ffffffffc0206cac:	67e2                	ld	a5,24(sp)
ffffffffc0206cae:	0138b423          	sd	s3,8(a7)
ffffffffc0206cb2:	00f8b823          	sd	a5,16(a7)
ffffffffc0206cb6:	0119b023          	sd	a7,0(s3)
ffffffffc0206cba:	89c6                	mv	s3,a7
ffffffffc0206cbc:	f61fe06f          	j	ffffffffc0205c1c <stride_dequeue+0xbf2>
ffffffffc0206cc0:	0089b783          	ld	a5,8(s3)
ffffffffc0206cc4:	0109b303          	ld	t1,16(s3)
ffffffffc0206cc8:	fc2a                	sd	a0,56(sp)
ffffffffc0206cca:	f03e                	sd	a5,32(sp)
ffffffffc0206ccc:	02030f63          	beqz	t1,ffffffffc0206d0a <stride_dequeue+0x1ce0>
ffffffffc0206cd0:	851a                	mv	a0,t1
ffffffffc0206cd2:	85e6                	mv	a1,s9
ffffffffc0206cd4:	f846                	sd	a7,48(sp)
ffffffffc0206cd6:	f41a                	sd	t1,40(sp)
ffffffffc0206cd8:	916fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206cdc:	7e62                	ld	t3,56(sp)
ffffffffc0206cde:	7322                	ld	t1,40(sp)
ffffffffc0206ce0:	78c2                	ld	a7,48(sp)
ffffffffc0206ce2:	11c50be3          	beq	a0,t3,ffffffffc02075f8 <stride_dequeue+0x25ce>
ffffffffc0206ce6:	010cb583          	ld	a1,16(s9)
ffffffffc0206cea:	008cbb03          	ld	s6,8(s9)
ffffffffc0206cee:	851a                	mv	a0,t1
ffffffffc0206cf0:	f446                	sd	a7,40(sp)
ffffffffc0206cf2:	958fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206cf6:	00acb423          	sd	a0,8(s9)
ffffffffc0206cfa:	016cb823          	sd	s6,16(s9)
ffffffffc0206cfe:	78a2                	ld	a7,40(sp)
ffffffffc0206d00:	010c2b03          	lw	s6,16(s8)
ffffffffc0206d04:	c119                	beqz	a0,ffffffffc0206d0a <stride_dequeue+0x1ce0>
ffffffffc0206d06:	01953023          	sd	s9,0(a0)
ffffffffc0206d0a:	7782                	ld	a5,32(sp)
ffffffffc0206d0c:	0199b423          	sd	s9,8(s3)
ffffffffc0206d10:	00f9b823          	sd	a5,16(s3)
ffffffffc0206d14:	013cb023          	sd	s3,0(s9)
ffffffffc0206d18:	8cce                	mv	s9,s3
ffffffffc0206d1a:	b8aff06f          	j	ffffffffc02060a4 <stride_dequeue+0x107a>
ffffffffc0206d1e:	89ee                	mv	s3,s11
ffffffffc0206d20:	dd6fe06f          	j	ffffffffc02052f6 <stride_dequeue+0x2cc>
ffffffffc0206d24:	0089b783          	ld	a5,8(s3)
ffffffffc0206d28:	0109b303          	ld	t1,16(s3)
ffffffffc0206d2c:	fc2a                	sd	a0,56(sp)
ffffffffc0206d2e:	f03e                	sd	a5,32(sp)
ffffffffc0206d30:	02030f63          	beqz	t1,ffffffffc0206d6e <stride_dequeue+0x1d44>
ffffffffc0206d34:	85c2                	mv	a1,a6
ffffffffc0206d36:	851a                	mv	a0,t1
ffffffffc0206d38:	f842                	sd	a6,48(sp)
ffffffffc0206d3a:	f41a                	sd	t1,40(sp)
ffffffffc0206d3c:	8b2fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206d40:	7e62                	ld	t3,56(sp)
ffffffffc0206d42:	7322                	ld	t1,40(sp)
ffffffffc0206d44:	7842                	ld	a6,48(sp)
ffffffffc0206d46:	0dc50fe3          	beq	a0,t3,ffffffffc0207624 <stride_dequeue+0x25fa>
ffffffffc0206d4a:	01083583          	ld	a1,16(a6)
ffffffffc0206d4e:	851a                	mv	a0,t1
ffffffffc0206d50:	00883b03          	ld	s6,8(a6)
ffffffffc0206d54:	f442                	sd	a6,40(sp)
ffffffffc0206d56:	8f4fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206d5a:	7822                	ld	a6,40(sp)
ffffffffc0206d5c:	01683823          	sd	s6,16(a6)
ffffffffc0206d60:	00a83423          	sd	a0,8(a6)
ffffffffc0206d64:	010c2b03          	lw	s6,16(s8)
ffffffffc0206d68:	c119                	beqz	a0,ffffffffc0206d6e <stride_dequeue+0x1d44>
ffffffffc0206d6a:	01053023          	sd	a6,0(a0)
ffffffffc0206d6e:	7782                	ld	a5,32(sp)
ffffffffc0206d70:	0109b423          	sd	a6,8(s3)
ffffffffc0206d74:	00f9b823          	sd	a5,16(s3)
ffffffffc0206d78:	01383023          	sd	s3,0(a6)
ffffffffc0206d7c:	884e                	mv	a6,s3
ffffffffc0206d7e:	bc4ff06f          	j	ffffffffc0206142 <stride_dequeue+0x1118>
ffffffffc0206d82:	008cb783          	ld	a5,8(s9)
ffffffffc0206d86:	010cb883          	ld	a7,16(s9)
ffffffffc0206d8a:	fc2a                	sd	a0,56(sp)
ffffffffc0206d8c:	f03e                	sd	a5,32(sp)
ffffffffc0206d8e:	02088f63          	beqz	a7,ffffffffc0206dcc <stride_dequeue+0x1da2>
ffffffffc0206d92:	8546                	mv	a0,a7
ffffffffc0206d94:	85ce                	mv	a1,s3
ffffffffc0206d96:	f842                	sd	a6,48(sp)
ffffffffc0206d98:	f446                	sd	a7,40(sp)
ffffffffc0206d9a:	854fe0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206d9e:	7e62                	ld	t3,56(sp)
ffffffffc0206da0:	78a2                	ld	a7,40(sp)
ffffffffc0206da2:	7842                	ld	a6,48(sp)
ffffffffc0206da4:	27c505e3          	beq	a0,t3,ffffffffc020780e <stride_dequeue+0x27e4>
ffffffffc0206da8:	0109b583          	ld	a1,16(s3)
ffffffffc0206dac:	0089bb03          	ld	s6,8(s3)
ffffffffc0206db0:	8546                	mv	a0,a7
ffffffffc0206db2:	f442                	sd	a6,40(sp)
ffffffffc0206db4:	896fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206db8:	00a9b423          	sd	a0,8(s3)
ffffffffc0206dbc:	0169b823          	sd	s6,16(s3)
ffffffffc0206dc0:	7822                	ld	a6,40(sp)
ffffffffc0206dc2:	010c2b03          	lw	s6,16(s8)
ffffffffc0206dc6:	c119                	beqz	a0,ffffffffc0206dcc <stride_dequeue+0x1da2>
ffffffffc0206dc8:	01353023          	sd	s3,0(a0)
ffffffffc0206dcc:	7782                	ld	a5,32(sp)
ffffffffc0206dce:	013cb423          	sd	s3,8(s9)
ffffffffc0206dd2:	00fcb823          	sd	a5,16(s9)
ffffffffc0206dd6:	0199b023          	sd	s9,0(s3)
ffffffffc0206dda:	89e6                	mv	s3,s9
ffffffffc0206ddc:	fb0fe06f          	j	ffffffffc020558c <stride_dequeue+0x562>
ffffffffc0206de0:	0089b783          	ld	a5,8(s3)
ffffffffc0206de4:	0109b303          	ld	t1,16(s3)
ffffffffc0206de8:	fc2a                	sd	a0,56(sp)
ffffffffc0206dea:	f03e                	sd	a5,32(sp)
ffffffffc0206dec:	02030f63          	beqz	t1,ffffffffc0206e2a <stride_dequeue+0x1e00>
ffffffffc0206df0:	85c2                	mv	a1,a6
ffffffffc0206df2:	851a                	mv	a0,t1
ffffffffc0206df4:	f842                	sd	a6,48(sp)
ffffffffc0206df6:	f41a                	sd	t1,40(sp)
ffffffffc0206df8:	ff7fd0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206dfc:	7e62                	ld	t3,56(sp)
ffffffffc0206dfe:	7322                	ld	t1,40(sp)
ffffffffc0206e00:	7842                	ld	a6,48(sp)
ffffffffc0206e02:	1bc509e3          	beq	a0,t3,ffffffffc02077b4 <stride_dequeue+0x278a>
ffffffffc0206e06:	01083583          	ld	a1,16(a6)
ffffffffc0206e0a:	851a                	mv	a0,t1
ffffffffc0206e0c:	00883b03          	ld	s6,8(a6)
ffffffffc0206e10:	f442                	sd	a6,40(sp)
ffffffffc0206e12:	838fe0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206e16:	7822                	ld	a6,40(sp)
ffffffffc0206e18:	01683823          	sd	s6,16(a6)
ffffffffc0206e1c:	00a83423          	sd	a0,8(a6)
ffffffffc0206e20:	010c2b03          	lw	s6,16(s8)
ffffffffc0206e24:	c119                	beqz	a0,ffffffffc0206e2a <stride_dequeue+0x1e00>
ffffffffc0206e26:	01053023          	sd	a6,0(a0)
ffffffffc0206e2a:	7782                	ld	a5,32(sp)
ffffffffc0206e2c:	0109b423          	sd	a6,8(s3)
ffffffffc0206e30:	00f9b823          	sd	a5,16(s3)
ffffffffc0206e34:	01383023          	sd	s3,0(a6)
ffffffffc0206e38:	884e                	mv	a6,s3
ffffffffc0206e3a:	ba4ff06f          	j	ffffffffc02061de <stride_dequeue+0x11b4>
ffffffffc0206e3e:	0089b783          	ld	a5,8(s3)
ffffffffc0206e42:	0109b303          	ld	t1,16(s3)
ffffffffc0206e46:	fc2a                	sd	a0,56(sp)
ffffffffc0206e48:	ec3e                	sd	a5,24(sp)
ffffffffc0206e4a:	04030363          	beqz	t1,ffffffffc0206e90 <stride_dequeue+0x1e66>
ffffffffc0206e4e:	85c2                	mv	a1,a6
ffffffffc0206e50:	851a                	mv	a0,t1
ffffffffc0206e52:	f832                	sd	a2,48(sp)
ffffffffc0206e54:	f442                	sd	a6,40(sp)
ffffffffc0206e56:	f01a                	sd	t1,32(sp)
ffffffffc0206e58:	f97fd0ef          	jal	ra,ffffffffc0204dee <proc_stride_comp_f>
ffffffffc0206e5c:	7642                	ld	a2,48(sp)
ffffffffc0206e5e:	7e62                	ld	t3,56(sp)
ffffffffc0206e60:	7822                	ld	a6,40(sp)
ffffffffc0206e62:	f432                	sd	a2,40(sp)
ffffffffc0206e64:	7302                	ld	t1,32(sp)
ffffffffc0206e66:	29c507e3          	beq	a0,t3,ffffffffc02078f4 <stride_dequeue+0x28ca>
ffffffffc0206e6a:	01083583          	ld	a1,16(a6)
ffffffffc0206e6e:	851a                	mv	a0,t1
ffffffffc0206e70:	00883b03          	ld	s6,8(a6)
ffffffffc0206e74:	f042                	sd	a6,32(sp)
ffffffffc0206e76:	fd5fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206e7a:	7802                	ld	a6,32(sp)
ffffffffc0206e7c:	7622                	ld	a2,40(sp)
ffffffffc0206e7e:	01683823          	sd	s6,16(a6)
ffffffffc0206e82:	00a83423          	sd	a0,8(a6)
ffffffffc0206e86:	010c2b03          	lw	s6,16(s8)
ffffffffc0206e8a:	c119                	beqz	a0,ffffffffc0206e90 <stride_dequeue+0x1e66>
ffffffffc0206e8c:	01053023          	sd	a6,0(a0)
ffffffffc0206e90:	67e2                	ld	a5,24(sp)
ffffffffc0206e92:	0109b423          	sd	a6,8(s3)
ffffffffc0206e96:	00f9b823          	sd	a5,16(s3)
ffffffffc0206e9a:	01383023          	sd	s3,0(a6)
ffffffffc0206e9e:	884e                	mv	a6,s3
ffffffffc0206ea0:	be2ff06f          	j	ffffffffc0206282 <stride_dequeue+0x1258>
ffffffffc0206ea4:	89c6                	mv	s3,a7
ffffffffc0206ea6:	9cffe06f          	j	ffffffffc0205874 <stride_dequeue+0x84a>
ffffffffc0206eaa:	89e6                	mv	s3,s9
ffffffffc0206eac:	aadfe06f          	j	ffffffffc0205958 <stride_dequeue+0x92e>
ffffffffc0206eb0:	89ee                	mv	s3,s11
ffffffffc0206eb2:	d9efe06f          	j	ffffffffc0205450 <stride_dequeue+0x426>
ffffffffc0206eb6:	89d2                	mv	s3,s4
ffffffffc0206eb8:	bb9fe06f          	j	ffffffffc0205a70 <stride_dequeue+0xa46>
ffffffffc0206ebc:	0108b503          	ld	a0,16(a7)
ffffffffc0206ec0:	85ce                	mv	a1,s3
ffffffffc0206ec2:	0088bb03          	ld	s6,8(a7)
ffffffffc0206ec6:	f81a                	sd	t1,48(sp)
ffffffffc0206ec8:	f446                	sd	a7,40(sp)
ffffffffc0206eca:	f81fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206ece:	78a2                	ld	a7,40(sp)
ffffffffc0206ed0:	7342                	ld	t1,48(sp)
ffffffffc0206ed2:	0168b823          	sd	s6,16(a7)
ffffffffc0206ed6:	00a8b423          	sd	a0,8(a7)
ffffffffc0206eda:	010c2b03          	lw	s6,16(s8)
ffffffffc0206ede:	d179                	beqz	a0,ffffffffc0206ea4 <stride_dequeue+0x1e7a>
ffffffffc0206ee0:	01153023          	sd	a7,0(a0)
ffffffffc0206ee4:	89c6                	mv	s3,a7
ffffffffc0206ee6:	98ffe06f          	j	ffffffffc0205874 <stride_dequeue+0x84a>
ffffffffc0206eea:	0109b503          	ld	a0,16(s3)
ffffffffc0206eee:	0089bb03          	ld	s6,8(s3)
ffffffffc0206ef2:	85be                	mv	a1,a5
ffffffffc0206ef4:	f442                	sd	a6,40(sp)
ffffffffc0206ef6:	f55fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206efa:	00a9b423          	sd	a0,8(s3)
ffffffffc0206efe:	0169b823          	sd	s6,16(s3)
ffffffffc0206f02:	7822                	ld	a6,40(sp)
ffffffffc0206f04:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f08:	5e050b63          	beqz	a0,ffffffffc02074fe <stride_dequeue+0x24d4>
ffffffffc0206f0c:	01353023          	sd	s3,0(a0)
ffffffffc0206f10:	87ce                	mv	a5,s3
ffffffffc0206f12:	bccff06f          	j	ffffffffc02062de <stride_dequeue+0x12b4>
ffffffffc0206f16:	010cb503          	ld	a0,16(s9)
ffffffffc0206f1a:	008cbb03          	ld	s6,8(s9)
ffffffffc0206f1e:	85ce                	mv	a1,s3
ffffffffc0206f20:	f2bfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206f24:	00acb423          	sd	a0,8(s9)
ffffffffc0206f28:	016cb823          	sd	s6,16(s9)
ffffffffc0206f2c:	7822                	ld	a6,40(sp)
ffffffffc0206f2e:	7342                	ld	t1,48(sp)
ffffffffc0206f30:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f34:	d93d                	beqz	a0,ffffffffc0206eaa <stride_dequeue+0x1e80>
ffffffffc0206f36:	01953023          	sd	s9,0(a0)
ffffffffc0206f3a:	89e6                	mv	s3,s9
ffffffffc0206f3c:	a1dfe06f          	j	ffffffffc0205958 <stride_dequeue+0x92e>
ffffffffc0206f40:	0108b503          	ld	a0,16(a7)
ffffffffc0206f44:	85ce                	mv	a1,s3
ffffffffc0206f46:	0088bb03          	ld	s6,8(a7)
ffffffffc0206f4a:	f842                	sd	a6,48(sp)
ffffffffc0206f4c:	f446                	sd	a7,40(sp)
ffffffffc0206f4e:	efdfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206f52:	78a2                	ld	a7,40(sp)
ffffffffc0206f54:	7842                	ld	a6,48(sp)
ffffffffc0206f56:	0168b823          	sd	s6,16(a7)
ffffffffc0206f5a:	00a8b423          	sd	a0,8(a7)
ffffffffc0206f5e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f62:	c2050ce3          	beqz	a0,ffffffffc0206b9a <stride_dequeue+0x1b70>
ffffffffc0206f66:	01153023          	sd	a7,0(a0)
ffffffffc0206f6a:	89c6                	mv	s3,a7
ffffffffc0206f6c:	e15fe06f          	j	ffffffffc0205d80 <stride_dequeue+0xd56>
ffffffffc0206f70:	010db503          	ld	a0,16(s11)
ffffffffc0206f74:	008dbb03          	ld	s6,8(s11)
ffffffffc0206f78:	85ce                	mv	a1,s3
ffffffffc0206f7a:	ed1fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206f7e:	00adb423          	sd	a0,8(s11)
ffffffffc0206f82:	016db823          	sd	s6,16(s11)
ffffffffc0206f86:	7602                	ld	a2,32(sp)
ffffffffc0206f88:	7822                	ld	a6,40(sp)
ffffffffc0206f8a:	7342                	ld	t1,48(sp)
ffffffffc0206f8c:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f90:	d105                	beqz	a0,ffffffffc0206eb0 <stride_dequeue+0x1e86>
ffffffffc0206f92:	01b53023          	sd	s11,0(a0)
ffffffffc0206f96:	89ee                	mv	s3,s11
ffffffffc0206f98:	cb8fe06f          	j	ffffffffc0205450 <stride_dequeue+0x426>
ffffffffc0206f9c:	010db503          	ld	a0,16(s11)
ffffffffc0206fa0:	008dbb03          	ld	s6,8(s11)
ffffffffc0206fa4:	85ce                	mv	a1,s3
ffffffffc0206fa6:	ea5fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0206faa:	00adb423          	sd	a0,8(s11)
ffffffffc0206fae:	016db823          	sd	s6,16(s11)
ffffffffc0206fb2:	7322                	ld	t1,40(sp)
ffffffffc0206fb4:	7842                	ld	a6,48(sp)
ffffffffc0206fb6:	010c2b03          	lw	s6,16(s8)
ffffffffc0206fba:	d60502e3          	beqz	a0,ffffffffc0206d1e <stride_dequeue+0x1cf4>
ffffffffc0206fbe:	01b53023          	sd	s11,0(a0)
ffffffffc0206fc2:	89ee                	mv	s3,s11
ffffffffc0206fc4:	b32fe06f          	j	ffffffffc02052f6 <stride_dequeue+0x2cc>
ffffffffc0206fc8:	89e6                	mv	s3,s9
ffffffffc0206fca:	dc2fe06f          	j	ffffffffc020558c <stride_dequeue+0x562>
ffffffffc0206fce:	89c6                	mv	s3,a7
ffffffffc0206fd0:	d1bfe06f          	j	ffffffffc0205cea <stride_dequeue+0xcc0>
ffffffffc0206fd4:	00003697          	auipc	a3,0x3
ffffffffc0206fd8:	a0c68693          	addi	a3,a3,-1524 # ffffffffc02099e0 <default_pmm_manager+0x7c0>
ffffffffc0206fdc:	00001617          	auipc	a2,0x1
ffffffffc0206fe0:	62460613          	addi	a2,a2,1572 # ffffffffc0208600 <commands+0x410>
ffffffffc0206fe4:	06300593          	li	a1,99
ffffffffc0206fe8:	00003517          	auipc	a0,0x3
ffffffffc0206fec:	a2050513          	addi	a0,a0,-1504 # ffffffffc0209a08 <default_pmm_manager+0x7e8>
ffffffffc0206ff0:	a18f90ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0206ff4:	89d2                	mv	s3,s4
ffffffffc0206ff6:	fb0fe06f          	j	ffffffffc02057a6 <stride_dequeue+0x77c>
ffffffffc0206ffa:	89c6                	mv	s3,a7
ffffffffc0206ffc:	c21fe06f          	j	ffffffffc0205c1c <stride_dequeue+0xbf2>
ffffffffc0207000:	89c6                	mv	s3,a7
ffffffffc0207002:	b3dfe06f          	j	ffffffffc0205b3e <stride_dequeue+0xb14>
ffffffffc0207006:	89b2                	mv	s3,a2
ffffffffc0207008:	ea0fe06f          	j	ffffffffc02056a8 <stride_dequeue+0x67e>
ffffffffc020700c:	0109b503          	ld	a0,16(s3)
ffffffffc0207010:	0089bb03          	ld	s6,8(s3)
ffffffffc0207014:	85a6                	mv	a1,s1
ffffffffc0207016:	e35fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020701a:	00a9b423          	sd	a0,8(s3)
ffffffffc020701e:	0169b823          	sd	s6,16(s3)
ffffffffc0207022:	010c2b03          	lw	s6,16(s8)
ffffffffc0207026:	b4050363          	beqz	a0,ffffffffc020636c <stride_dequeue+0x1342>
ffffffffc020702a:	01353023          	sd	s3,0(a0)
ffffffffc020702e:	b3eff06f          	j	ffffffffc020636c <stride_dequeue+0x1342>
ffffffffc0207032:	0109b503          	ld	a0,16(s3)
ffffffffc0207036:	0089bb03          	ld	s6,8(s3)
ffffffffc020703a:	859a                	mv	a1,t1
ffffffffc020703c:	f446                	sd	a7,40(sp)
ffffffffc020703e:	e0dfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207042:	00a9b423          	sd	a0,8(s3)
ffffffffc0207046:	0169b823          	sd	s6,16(s3)
ffffffffc020704a:	78a2                	ld	a7,40(sp)
ffffffffc020704c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207050:	100505e3          	beqz	a0,ffffffffc020795a <stride_dequeue+0x2930>
ffffffffc0207054:	01353023          	sd	s3,0(a0)
ffffffffc0207058:	834e                	mv	t1,s3
ffffffffc020705a:	b0c5                	j	ffffffffc020693a <stride_dequeue+0x1910>
ffffffffc020705c:	0109b503          	ld	a0,16(s3)
ffffffffc0207060:	0089bb03          	ld	s6,8(s3)
ffffffffc0207064:	85f2                	mv	a1,t3
ffffffffc0207066:	f442                	sd	a6,40(sp)
ffffffffc0207068:	f032                	sd	a2,32(sp)
ffffffffc020706a:	de1fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020706e:	00a9b423          	sd	a0,8(s3)
ffffffffc0207072:	0169b823          	sd	s6,16(s3)
ffffffffc0207076:	7602                	ld	a2,32(sp)
ffffffffc0207078:	7822                	ld	a6,40(sp)
ffffffffc020707a:	010c2b03          	lw	s6,16(s8)
ffffffffc020707e:	9e050b63          	beqz	a0,ffffffffc0206274 <stride_dequeue+0x124a>
ffffffffc0207082:	01353023          	sd	s3,0(a0)
ffffffffc0207086:	9eeff06f          	j	ffffffffc0206274 <stride_dequeue+0x124a>
ffffffffc020708a:	0109b503          	ld	a0,16(s3)
ffffffffc020708e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207092:	859a                	mv	a1,t1
ffffffffc0207094:	f442                	sd	a6,40(sp)
ffffffffc0207096:	db5fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020709a:	00a9b423          	sd	a0,8(s3)
ffffffffc020709e:	0169b823          	sd	s6,16(s3)
ffffffffc02070a2:	7822                	ld	a6,40(sp)
ffffffffc02070a4:	010c2b03          	lw	s6,16(s8)
ffffffffc02070a8:	08050de3          	beqz	a0,ffffffffc0207942 <stride_dequeue+0x2918>
ffffffffc02070ac:	01353023          	sd	s3,0(a0)
ffffffffc02070b0:	834e                	mv	t1,s3
ffffffffc02070b2:	efaff06f          	j	ffffffffc02067ac <stride_dequeue+0x1782>
ffffffffc02070b6:	89a6                	mv	s3,s1
ffffffffc02070b8:	ab4ff06f          	j	ffffffffc020636c <stride_dequeue+0x1342>
ffffffffc02070bc:	0109b503          	ld	a0,16(s3)
ffffffffc02070c0:	0089bb03          	ld	s6,8(s3)
ffffffffc02070c4:	85ee                	mv	a1,s11
ffffffffc02070c6:	f046                	sd	a7,32(sp)
ffffffffc02070c8:	d83fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02070cc:	00a9b423          	sd	a0,8(s3)
ffffffffc02070d0:	0169b823          	sd	s6,16(s3)
ffffffffc02070d4:	7882                	ld	a7,32(sp)
ffffffffc02070d6:	010c2b03          	lw	s6,16(s8)
ffffffffc02070da:	bc050f63          	beqz	a0,ffffffffc02064b8 <stride_dequeue+0x148e>
ffffffffc02070de:	01353023          	sd	s3,0(a0)
ffffffffc02070e2:	bd6ff06f          	j	ffffffffc02064b8 <stride_dequeue+0x148e>
ffffffffc02070e6:	0109b503          	ld	a0,16(s3)
ffffffffc02070ea:	0089bb03          	ld	s6,8(s3)
ffffffffc02070ee:	85f2                	mv	a1,t3
ffffffffc02070f0:	f442                	sd	a6,40(sp)
ffffffffc02070f2:	d59fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02070f6:	00a9b423          	sd	a0,8(s3)
ffffffffc02070fa:	0169b823          	sd	s6,16(s3)
ffffffffc02070fe:	7822                	ld	a6,40(sp)
ffffffffc0207100:	010c2b03          	lw	s6,16(s8)
ffffffffc0207104:	e119                	bnez	a0,ffffffffc020710a <stride_dequeue+0x20e0>
ffffffffc0207106:	8caff06f          	j	ffffffffc02061d0 <stride_dequeue+0x11a6>
ffffffffc020710a:	01353023          	sd	s3,0(a0)
ffffffffc020710e:	8c2ff06f          	j	ffffffffc02061d0 <stride_dequeue+0x11a6>
ffffffffc0207112:	0109b503          	ld	a0,16(s3)
ffffffffc0207116:	0089bb03          	ld	s6,8(s3)
ffffffffc020711a:	85b2                	mv	a1,a2
ffffffffc020711c:	ec46                	sd	a7,24(sp)
ffffffffc020711e:	d2dfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207122:	00a9b423          	sd	a0,8(s3)
ffffffffc0207126:	0169b823          	sd	s6,16(s3)
ffffffffc020712a:	68e2                	ld	a7,24(sp)
ffffffffc020712c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207130:	c2050963          	beqz	a0,ffffffffc0206562 <stride_dequeue+0x1538>
ffffffffc0207134:	01353023          	sd	s3,0(a0)
ffffffffc0207138:	c2aff06f          	j	ffffffffc0206562 <stride_dequeue+0x1538>
ffffffffc020713c:	0109b503          	ld	a0,16(s3)
ffffffffc0207140:	0089bb03          	ld	s6,8(s3)
ffffffffc0207144:	859a                	mv	a1,t1
ffffffffc0207146:	f442                	sd	a6,40(sp)
ffffffffc0207148:	f032                	sd	a2,32(sp)
ffffffffc020714a:	d01fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020714e:	00a9b423          	sd	a0,8(s3)
ffffffffc0207152:	0169b823          	sd	s6,16(s3)
ffffffffc0207156:	7602                	ld	a2,32(sp)
ffffffffc0207158:	7822                	ld	a6,40(sp)
ffffffffc020715a:	010c2b03          	lw	s6,16(s8)
ffffffffc020715e:	7c050363          	beqz	a0,ffffffffc0207924 <stride_dequeue+0x28fa>
ffffffffc0207162:	01353023          	sd	s3,0(a0)
ffffffffc0207166:	834e                	mv	t1,s3
ffffffffc0207168:	eaeff06f          	j	ffffffffc0206816 <stride_dequeue+0x17ec>
ffffffffc020716c:	0109b503          	ld	a0,16(s3)
ffffffffc0207170:	0089bb03          	ld	s6,8(s3)
ffffffffc0207174:	85c2                	mv	a1,a6
ffffffffc0207176:	ec32                	sd	a2,24(sp)
ffffffffc0207178:	cd3fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020717c:	00a9b423          	sd	a0,8(s3)
ffffffffc0207180:	0169b823          	sd	s6,16(s3)
ffffffffc0207184:	6662                	ld	a2,24(sp)
ffffffffc0207186:	010c2b03          	lw	s6,16(s8)
ffffffffc020718a:	d2050263          	beqz	a0,ffffffffc02066ae <stride_dequeue+0x1684>
ffffffffc020718e:	01353023          	sd	s3,0(a0)
ffffffffc0207192:	d1cff06f          	j	ffffffffc02066ae <stride_dequeue+0x1684>
ffffffffc0207196:	0109b503          	ld	a0,16(s3)
ffffffffc020719a:	0089bb03          	ld	s6,8(s3)
ffffffffc020719e:	85c2                	mv	a1,a6
ffffffffc02071a0:	cabfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02071a4:	00a9b423          	sd	a0,8(s3)
ffffffffc02071a8:	0169b823          	sd	s6,16(s3)
ffffffffc02071ac:	010c2b03          	lw	s6,16(s8)
ffffffffc02071b0:	c4050b63          	beqz	a0,ffffffffc0206606 <stride_dequeue+0x15dc>
ffffffffc02071b4:	01353023          	sd	s3,0(a0)
ffffffffc02071b8:	c4eff06f          	j	ffffffffc0206606 <stride_dequeue+0x15dc>
ffffffffc02071bc:	0109b503          	ld	a0,16(s3)
ffffffffc02071c0:	0089bb03          	ld	s6,8(s3)
ffffffffc02071c4:	859a                	mv	a1,t1
ffffffffc02071c6:	c85fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02071ca:	00a9b423          	sd	a0,8(s3)
ffffffffc02071ce:	0169b823          	sd	s6,16(s3)
ffffffffc02071d2:	010c2b03          	lw	s6,16(s8)
ffffffffc02071d6:	e119                	bnez	a0,ffffffffc02071dc <stride_dequeue+0x21b2>
ffffffffc02071d8:	c77fe06f          	j	ffffffffc0205e4e <stride_dequeue+0xe24>
ffffffffc02071dc:	01353023          	sd	s3,0(a0)
ffffffffc02071e0:	c6ffe06f          	j	ffffffffc0205e4e <stride_dequeue+0xe24>
ffffffffc02071e4:	6a08                	ld	a0,16(a2)
ffffffffc02071e6:	85f2                	mv	a1,t3
ffffffffc02071e8:	00863b03          	ld	s6,8(a2)
ffffffffc02071ec:	c5ffd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02071f0:	7602                	ld	a2,32(sp)
ffffffffc02071f2:	7822                	ld	a6,40(sp)
ffffffffc02071f4:	01663823          	sd	s6,16(a2)
ffffffffc02071f8:	e608                	sd	a0,8(a2)
ffffffffc02071fa:	010c2b03          	lw	s6,16(s8)
ffffffffc02071fe:	e119                	bnez	a0,ffffffffc0207204 <stride_dequeue+0x21da>
ffffffffc0207200:	c9afe06f          	j	ffffffffc020569a <stride_dequeue+0x670>
ffffffffc0207204:	e110                	sd	a2,0(a0)
ffffffffc0207206:	c94fe06f          	j	ffffffffc020569a <stride_dequeue+0x670>
ffffffffc020720a:	010a3503          	ld	a0,16(s4)
ffffffffc020720e:	008a3b03          	ld	s6,8(s4)
ffffffffc0207212:	859a                	mv	a1,t1
ffffffffc0207214:	c37fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207218:	00aa3423          	sd	a0,8(s4)
ffffffffc020721c:	016a3823          	sd	s6,16(s4)
ffffffffc0207220:	010c2b03          	lw	s6,16(s8)
ffffffffc0207224:	e119                	bnez	a0,ffffffffc020722a <stride_dequeue+0x2200>
ffffffffc0207226:	83dfe06f          	j	ffffffffc0205a62 <stride_dequeue+0xa38>
ffffffffc020722a:	01453023          	sd	s4,0(a0)
ffffffffc020722e:	835fe06f          	j	ffffffffc0205a62 <stride_dequeue+0xa38>
ffffffffc0207232:	010cb503          	ld	a0,16(s9)
ffffffffc0207236:	008cbb03          	ld	s6,8(s9)
ffffffffc020723a:	85f2                	mv	a1,t3
ffffffffc020723c:	f442                	sd	a6,40(sp)
ffffffffc020723e:	c0dfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207242:	00acb423          	sd	a0,8(s9)
ffffffffc0207246:	016cb823          	sd	s6,16(s9)
ffffffffc020724a:	7822                	ld	a6,40(sp)
ffffffffc020724c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207250:	e119                	bnez	a0,ffffffffc0207256 <stride_dequeue+0x222c>
ffffffffc0207252:	b2cfe06f          	j	ffffffffc020557e <stride_dequeue+0x554>
ffffffffc0207256:	01953023          	sd	s9,0(a0)
ffffffffc020725a:	b24fe06f          	j	ffffffffc020557e <stride_dequeue+0x554>
ffffffffc020725e:	010a3503          	ld	a0,16(s4)
ffffffffc0207262:	008a3b03          	ld	s6,8(s4)
ffffffffc0207266:	85f2                	mv	a1,t3
ffffffffc0207268:	f442                	sd	a6,40(sp)
ffffffffc020726a:	be1fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020726e:	00aa3423          	sd	a0,8(s4)
ffffffffc0207272:	016a3823          	sd	s6,16(s4)
ffffffffc0207276:	7822                	ld	a6,40(sp)
ffffffffc0207278:	010c2b03          	lw	s6,16(s8)
ffffffffc020727c:	e119                	bnez	a0,ffffffffc0207282 <stride_dequeue+0x2258>
ffffffffc020727e:	d1afe06f          	j	ffffffffc0205798 <stride_dequeue+0x76e>
ffffffffc0207282:	01453023          	sd	s4,0(a0)
ffffffffc0207286:	d12fe06f          	j	ffffffffc0205798 <stride_dequeue+0x76e>
ffffffffc020728a:	0108b503          	ld	a0,16(a7)
ffffffffc020728e:	85f2                	mv	a1,t3
ffffffffc0207290:	0088bb03          	ld	s6,8(a7)
ffffffffc0207294:	f046                	sd	a7,32(sp)
ffffffffc0207296:	bb5fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020729a:	7882                	ld	a7,32(sp)
ffffffffc020729c:	7622                	ld	a2,40(sp)
ffffffffc020729e:	0168b823          	sd	s6,16(a7)
ffffffffc02072a2:	00a8b423          	sd	a0,8(a7)
ffffffffc02072a6:	010c2b03          	lw	s6,16(s8)
ffffffffc02072aa:	e119                	bnez	a0,ffffffffc02072b0 <stride_dequeue+0x2286>
ffffffffc02072ac:	963fe06f          	j	ffffffffc0205c0e <stride_dequeue+0xbe4>
ffffffffc02072b0:	01153023          	sd	a7,0(a0)
ffffffffc02072b4:	95bfe06f          	j	ffffffffc0205c0e <stride_dequeue+0xbe4>
ffffffffc02072b8:	0108b503          	ld	a0,16(a7)
ffffffffc02072bc:	85f2                	mv	a1,t3
ffffffffc02072be:	0088bb03          	ld	s6,8(a7)
ffffffffc02072c2:	f446                	sd	a7,40(sp)
ffffffffc02072c4:	b87fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02072c8:	78a2                	ld	a7,40(sp)
ffffffffc02072ca:	0168b823          	sd	s6,16(a7)
ffffffffc02072ce:	00a8b423          	sd	a0,8(a7)
ffffffffc02072d2:	010c2b03          	lw	s6,16(s8)
ffffffffc02072d6:	e119                	bnez	a0,ffffffffc02072dc <stride_dequeue+0x22b2>
ffffffffc02072d8:	a05fe06f          	j	ffffffffc0205cdc <stride_dequeue+0xcb2>
ffffffffc02072dc:	01153023          	sd	a7,0(a0)
ffffffffc02072e0:	9fdfe06f          	j	ffffffffc0205cdc <stride_dequeue+0xcb2>
ffffffffc02072e4:	0109b503          	ld	a0,16(s3)
ffffffffc02072e8:	0089bb03          	ld	s6,8(s3)
ffffffffc02072ec:	85c2                	mv	a1,a6
ffffffffc02072ee:	f446                	sd	a7,40(sp)
ffffffffc02072f0:	b5bfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02072f4:	00a9b423          	sd	a0,8(s3)
ffffffffc02072f8:	0169b823          	sd	s6,16(s3)
ffffffffc02072fc:	78a2                	ld	a7,40(sp)
ffffffffc02072fe:	010c2b03          	lw	s6,16(s8)
ffffffffc0207302:	66050563          	beqz	a0,ffffffffc020796c <stride_dequeue+0x2942>
ffffffffc0207306:	01353023          	sd	s3,0(a0)
ffffffffc020730a:	884e                	mv	a6,s3
ffffffffc020730c:	d6aff06f          	j	ffffffffc0206876 <stride_dequeue+0x184c>
ffffffffc0207310:	0109b503          	ld	a0,16(s3)
ffffffffc0207314:	0089bb03          	ld	s6,8(s3)
ffffffffc0207318:	85f2                	mv	a1,t3
ffffffffc020731a:	f442                	sd	a6,40(sp)
ffffffffc020731c:	b2ffd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207320:	00a9b423          	sd	a0,8(s3)
ffffffffc0207324:	0169b823          	sd	s6,16(s3)
ffffffffc0207328:	7822                	ld	a6,40(sp)
ffffffffc020732a:	010c2b03          	lw	s6,16(s8)
ffffffffc020732e:	e119                	bnez	a0,ffffffffc0207334 <stride_dequeue+0x230a>
ffffffffc0207330:	e05fe06f          	j	ffffffffc0206134 <stride_dequeue+0x110a>
ffffffffc0207334:	01353023          	sd	s3,0(a0)
ffffffffc0207338:	dfdfe06f          	j	ffffffffc0206134 <stride_dequeue+0x110a>
ffffffffc020733c:	0109b503          	ld	a0,16(s3)
ffffffffc0207340:	0089bb03          	ld	s6,8(s3)
ffffffffc0207344:	859a                	mv	a1,t1
ffffffffc0207346:	f442                	sd	a6,40(sp)
ffffffffc0207348:	b03fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020734c:	00a9b423          	sd	a0,8(s3)
ffffffffc0207350:	0169b823          	sd	s6,16(s3)
ffffffffc0207354:	7822                	ld	a6,40(sp)
ffffffffc0207356:	010c2b03          	lw	s6,16(s8)
ffffffffc020735a:	64050163          	beqz	a0,ffffffffc020799c <stride_dequeue+0x2972>
ffffffffc020735e:	01353023          	sd	s3,0(a0)
ffffffffc0207362:	834e                	mv	t1,s3
ffffffffc0207364:	d76ff06f          	j	ffffffffc02068da <stride_dequeue+0x18b0>
ffffffffc0207368:	0109b503          	ld	a0,16(s3)
ffffffffc020736c:	0089bb03          	ld	s6,8(s3)
ffffffffc0207370:	85f2                	mv	a1,t3
ffffffffc0207372:	f446                	sd	a7,40(sp)
ffffffffc0207374:	ad7fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207378:	00a9b423          	sd	a0,8(s3)
ffffffffc020737c:	0169b823          	sd	s6,16(s3)
ffffffffc0207380:	78a2                	ld	a7,40(sp)
ffffffffc0207382:	010c2b03          	lw	s6,16(s8)
ffffffffc0207386:	e119                	bnez	a0,ffffffffc020738c <stride_dequeue+0x2362>
ffffffffc0207388:	d0ffe06f          	j	ffffffffc0206096 <stride_dequeue+0x106c>
ffffffffc020738c:	01353023          	sd	s3,0(a0)
ffffffffc0207390:	d07fe06f          	j	ffffffffc0206096 <stride_dequeue+0x106c>
ffffffffc0207394:	0109b503          	ld	a0,16(s3)
ffffffffc0207398:	0089bb03          	ld	s6,8(s3)
ffffffffc020739c:	859a                	mv	a1,t1
ffffffffc020739e:	aadfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02073a2:	00a9b423          	sd	a0,8(s3)
ffffffffc02073a6:	0169b823          	sd	s6,16(s3)
ffffffffc02073aa:	010c2b03          	lw	s6,16(s8)
ffffffffc02073ae:	e119                	bnez	a0,ffffffffc02073b4 <stride_dequeue+0x238a>
ffffffffc02073b0:	c49fe06f          	j	ffffffffc0205ff8 <stride_dequeue+0xfce>
ffffffffc02073b4:	01353023          	sd	s3,0(a0)
ffffffffc02073b8:	c41fe06f          	j	ffffffffc0205ff8 <stride_dequeue+0xfce>
ffffffffc02073bc:	0109b503          	ld	a0,16(s3)
ffffffffc02073c0:	0089bb03          	ld	s6,8(s3)
ffffffffc02073c4:	859a                	mv	a1,t1
ffffffffc02073c6:	ec32                	sd	a2,24(sp)
ffffffffc02073c8:	a83fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02073cc:	00a9b423          	sd	a0,8(s3)
ffffffffc02073d0:	0169b823          	sd	s6,16(s3)
ffffffffc02073d4:	6662                	ld	a2,24(sp)
ffffffffc02073d6:	010c2b03          	lw	s6,16(s8)
ffffffffc02073da:	e119                	bnez	a0,ffffffffc02073e0 <stride_dequeue+0x23b6>
ffffffffc02073dc:	b4ffe06f          	j	ffffffffc0205f2a <stride_dequeue+0xf00>
ffffffffc02073e0:	01353023          	sd	s3,0(a0)
ffffffffc02073e4:	b47fe06f          	j	ffffffffc0205f2a <stride_dequeue+0xf00>
ffffffffc02073e8:	0108b503          	ld	a0,16(a7)
ffffffffc02073ec:	85f2                	mv	a1,t3
ffffffffc02073ee:	0088bb03          	ld	s6,8(a7)
ffffffffc02073f2:	f446                	sd	a7,40(sp)
ffffffffc02073f4:	a57fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02073f8:	78a2                	ld	a7,40(sp)
ffffffffc02073fa:	0168b823          	sd	s6,16(a7)
ffffffffc02073fe:	00a8b423          	sd	a0,8(a7)
ffffffffc0207402:	010c2b03          	lw	s6,16(s8)
ffffffffc0207406:	e119                	bnez	a0,ffffffffc020740c <stride_dequeue+0x23e2>
ffffffffc0207408:	f28fe06f          	j	ffffffffc0205b30 <stride_dequeue+0xb06>
ffffffffc020740c:	01153023          	sd	a7,0(a0)
ffffffffc0207410:	f20fe06f          	j	ffffffffc0205b30 <stride_dequeue+0xb06>
ffffffffc0207414:	0109b503          	ld	a0,16(s3)
ffffffffc0207418:	0089bb03          	ld	s6,8(s3)
ffffffffc020741c:	85d2                	mv	a1,s4
ffffffffc020741e:	f046                	sd	a7,32(sp)
ffffffffc0207420:	a2bfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207424:	00a9b423          	sd	a0,8(s3)
ffffffffc0207428:	0169b823          	sd	s6,16(s3)
ffffffffc020742c:	7882                	ld	a7,32(sp)
ffffffffc020742e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207432:	e119                	bnez	a0,ffffffffc0207438 <stride_dequeue+0x240e>
ffffffffc0207434:	fe1fe06f          	j	ffffffffc0206414 <stride_dequeue+0x13ea>
ffffffffc0207438:	01353023          	sd	s3,0(a0)
ffffffffc020743c:	fd9fe06f          	j	ffffffffc0206414 <stride_dequeue+0x13ea>
ffffffffc0207440:	0109b503          	ld	a0,16(s3)
ffffffffc0207444:	0089bb03          	ld	s6,8(s3)
ffffffffc0207448:	85c2                	mv	a1,a6
ffffffffc020744a:	a01fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020744e:	00a9b423          	sd	a0,8(s3)
ffffffffc0207452:	0169b823          	sd	s6,16(s3)
ffffffffc0207456:	010c2b03          	lw	s6,16(s8)
ffffffffc020745a:	ae050863          	beqz	a0,ffffffffc020674a <stride_dequeue+0x1720>
ffffffffc020745e:	01353023          	sd	s3,0(a0)
ffffffffc0207462:	ae8ff06f          	j	ffffffffc020674a <stride_dequeue+0x1720>
ffffffffc0207466:	89d2                	mv	s3,s4
ffffffffc0207468:	fadfe06f          	j	ffffffffc0206414 <stride_dequeue+0x13ea>
ffffffffc020746c:	89ee                	mv	s3,s11
ffffffffc020746e:	84aff06f          	j	ffffffffc02064b8 <stride_dequeue+0x148e>
ffffffffc0207472:	89c2                	mv	s3,a6
ffffffffc0207474:	992ff06f          	j	ffffffffc0206606 <stride_dequeue+0x15dc>
ffffffffc0207478:	89c2                	mv	s3,a6
ffffffffc020747a:	a34ff06f          	j	ffffffffc02066ae <stride_dequeue+0x1684>
ffffffffc020747e:	89b2                	mv	s3,a2
ffffffffc0207480:	8e2ff06f          	j	ffffffffc0206562 <stride_dequeue+0x1538>
ffffffffc0207484:	89c2                	mv	s3,a6
ffffffffc0207486:	ac4ff06f          	j	ffffffffc020674a <stride_dequeue+0x1720>
ffffffffc020748a:	01083503          	ld	a0,16(a6)
ffffffffc020748e:	85e6                	mv	a1,s9
ffffffffc0207490:	00883b03          	ld	s6,8(a6)
ffffffffc0207494:	9b7fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207498:	7802                	ld	a6,32(sp)
ffffffffc020749a:	01683823          	sd	s6,16(a6)
ffffffffc020749e:	00a83423          	sd	a0,8(a6)
ffffffffc02074a2:	010c2b03          	lw	s6,16(s8)
ffffffffc02074a6:	50050163          	beqz	a0,ffffffffc02079a8 <stride_dequeue+0x297e>
ffffffffc02074aa:	01053023          	sd	a6,0(a0)
ffffffffc02074ae:	8cc2                	mv	s9,a6
ffffffffc02074b0:	d62ff06f          	j	ffffffffc0206a12 <stride_dequeue+0x19e8>
ffffffffc02074b4:	01083503          	ld	a0,16(a6)
ffffffffc02074b8:	85d2                	mv	a1,s4
ffffffffc02074ba:	00883b03          	ld	s6,8(a6)
ffffffffc02074be:	98dfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02074c2:	6862                	ld	a6,24(sp)
ffffffffc02074c4:	7602                	ld	a2,32(sp)
ffffffffc02074c6:	01683823          	sd	s6,16(a6)
ffffffffc02074ca:	00a83423          	sd	a0,8(a6)
ffffffffc02074ce:	010c2b03          	lw	s6,16(s8)
ffffffffc02074d2:	4c050863          	beqz	a0,ffffffffc02079a2 <stride_dequeue+0x2978>
ffffffffc02074d6:	01053023          	sd	a6,0(a0)
ffffffffc02074da:	8a42                	mv	s4,a6
ffffffffc02074dc:	d94ff06f          	j	ffffffffc0206a70 <stride_dequeue+0x1a46>
ffffffffc02074e0:	89f2                	mv	s3,t3
ffffffffc02074e2:	bb5fe06f          	j	ffffffffc0206096 <stride_dequeue+0x106c>
ffffffffc02074e6:	88f2                	mv	a7,t3
ffffffffc02074e8:	e48fe06f          	j	ffffffffc0205b30 <stride_dequeue+0xb06>
ffffffffc02074ec:	89f2                	mv	s3,t3
ffffffffc02074ee:	ce3fe06f          	j	ffffffffc02061d0 <stride_dequeue+0x11a6>
ffffffffc02074f2:	89f2                	mv	s3,t3
ffffffffc02074f4:	c41fe06f          	j	ffffffffc0206134 <stride_dequeue+0x110a>
ffffffffc02074f8:	88f2                	mv	a7,t3
ffffffffc02074fa:	fe2fe06f          	j	ffffffffc0205cdc <stride_dequeue+0xcb2>
ffffffffc02074fe:	87ce                	mv	a5,s3
ffffffffc0207500:	ddffe06f          	j	ffffffffc02062de <stride_dequeue+0x12b4>
ffffffffc0207504:	0108b503          	ld	a0,16(a7)
ffffffffc0207508:	85ce                	mv	a1,s3
ffffffffc020750a:	0088bb03          	ld	s6,8(a7)
ffffffffc020750e:	93dfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207512:	7882                	ld	a7,32(sp)
ffffffffc0207514:	0168b823          	sd	s6,16(a7)
ffffffffc0207518:	00a8b423          	sd	a0,8(a7)
ffffffffc020751c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207520:	42050a63          	beqz	a0,ffffffffc0207954 <stride_dequeue+0x292a>
ffffffffc0207524:	01153023          	sd	a7,0(a0)
ffffffffc0207528:	89c6                	mv	s3,a7
ffffffffc020752a:	d9cff06f          	j	ffffffffc0206ac6 <stride_dequeue+0x1a9c>
ffffffffc020752e:	8cf2                	mv	s9,t3
ffffffffc0207530:	84efe06f          	j	ffffffffc020557e <stride_dequeue+0x554>
ffffffffc0207534:	8a72                	mv	s4,t3
ffffffffc0207536:	a62fe06f          	j	ffffffffc0205798 <stride_dequeue+0x76e>
ffffffffc020753a:	88f2                	mv	a7,t3
ffffffffc020753c:	ed2fe06f          	j	ffffffffc0205c0e <stride_dequeue+0xbe4>
ffffffffc0207540:	89f2                	mv	s3,t3
ffffffffc0207542:	d33fe06f          	j	ffffffffc0206274 <stride_dequeue+0x124a>
ffffffffc0207546:	0109b503          	ld	a0,16(s3)
ffffffffc020754a:	0089bb03          	ld	s6,8(s3)
ffffffffc020754e:	85c6                	mv	a1,a7
ffffffffc0207550:	8fbfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207554:	00a9b423          	sd	a0,8(s3)
ffffffffc0207558:	0169b823          	sd	s6,16(s3)
ffffffffc020755c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207560:	e119                	bnez	a0,ffffffffc0207566 <stride_dequeue+0x253c>
ffffffffc0207562:	dfdfe06f          	j	ffffffffc020635e <stride_dequeue+0x1334>
ffffffffc0207566:	01353023          	sd	s3,0(a0)
ffffffffc020756a:	df5fe06f          	j	ffffffffc020635e <stride_dequeue+0x1334>
ffffffffc020756e:	01083503          	ld	a0,16(a6)
ffffffffc0207572:	85d2                	mv	a1,s4
ffffffffc0207574:	00883b03          	ld	s6,8(a6)
ffffffffc0207578:	8d3fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020757c:	7802                	ld	a6,32(sp)
ffffffffc020757e:	01683823          	sd	s6,16(a6)
ffffffffc0207582:	00a83423          	sd	a0,8(a6)
ffffffffc0207586:	010c2b03          	lw	s6,16(s8)
ffffffffc020758a:	3a050363          	beqz	a0,ffffffffc0207930 <stride_dequeue+0x2906>
ffffffffc020758e:	01053023          	sd	a6,0(a0)
ffffffffc0207592:	8a42                	mv	s4,a6
ffffffffc0207594:	c28ff06f          	j	ffffffffc02069bc <stride_dequeue+0x1992>
ffffffffc0207598:	8672                	mv	a2,t3
ffffffffc020759a:	900fe06f          	j	ffffffffc020569a <stride_dequeue+0x670>
ffffffffc020759e:	0108b503          	ld	a0,16(a7)
ffffffffc02075a2:	85ce                	mv	a1,s3
ffffffffc02075a4:	0088bb03          	ld	s6,8(a7)
ffffffffc02075a8:	8a3fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02075ac:	7882                	ld	a7,32(sp)
ffffffffc02075ae:	7622                	ld	a2,40(sp)
ffffffffc02075b0:	7842                	ld	a6,48(sp)
ffffffffc02075b2:	0168b823          	sd	s6,16(a7)
ffffffffc02075b6:	00a8b423          	sd	a0,8(a7)
ffffffffc02075ba:	010c2b03          	lw	s6,16(s8)
ffffffffc02075be:	3c050c63          	beqz	a0,ffffffffc0207996 <stride_dequeue+0x296c>
ffffffffc02075c2:	01153023          	sd	a7,0(a0)
ffffffffc02075c6:	89c6                	mv	s3,a7
ffffffffc02075c8:	dc0ff06f          	j	ffffffffc0206b88 <stride_dequeue+0x1b5e>
ffffffffc02075cc:	0109b503          	ld	a0,16(s3)
ffffffffc02075d0:	0089bb03          	ld	s6,8(s3)
ffffffffc02075d4:	85f2                	mv	a1,t3
ffffffffc02075d6:	f41a                	sd	t1,40(sp)
ffffffffc02075d8:	873fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02075dc:	00a9b423          	sd	a0,8(s3)
ffffffffc02075e0:	0169b823          	sd	s6,16(s3)
ffffffffc02075e4:	7322                	ld	t1,40(sp)
ffffffffc02075e6:	010c2b03          	lw	s6,16(s8)
ffffffffc02075ea:	e119                	bnez	a0,ffffffffc02075f0 <stride_dequeue+0x25c6>
ffffffffc02075ec:	9fdfe06f          	j	ffffffffc0205fe8 <stride_dequeue+0xfbe>
ffffffffc02075f0:	01353023          	sd	s3,0(a0)
ffffffffc02075f4:	9f5fe06f          	j	ffffffffc0205fe8 <stride_dequeue+0xfbe>
ffffffffc02075f8:	01033503          	ld	a0,16(t1)
ffffffffc02075fc:	85e6                	mv	a1,s9
ffffffffc02075fe:	00833b03          	ld	s6,8(t1)
ffffffffc0207602:	849fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207606:	7322                	ld	t1,40(sp)
ffffffffc0207608:	78c2                	ld	a7,48(sp)
ffffffffc020760a:	01633823          	sd	s6,16(t1)
ffffffffc020760e:	00a33423          	sd	a0,8(t1)
ffffffffc0207612:	010c2b03          	lw	s6,16(s8)
ffffffffc0207616:	34050e63          	beqz	a0,ffffffffc0207972 <stride_dequeue+0x2948>
ffffffffc020761a:	00653023          	sd	t1,0(a0)
ffffffffc020761e:	8c9a                	mv	s9,t1
ffffffffc0207620:	eeaff06f          	j	ffffffffc0206d0a <stride_dequeue+0x1ce0>
ffffffffc0207624:	01033503          	ld	a0,16(t1)
ffffffffc0207628:	85c2                	mv	a1,a6
ffffffffc020762a:	00833b03          	ld	s6,8(t1)
ffffffffc020762e:	81dfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207632:	7322                	ld	t1,40(sp)
ffffffffc0207634:	01633823          	sd	s6,16(t1)
ffffffffc0207638:	00a33423          	sd	a0,8(t1)
ffffffffc020763c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207640:	32050c63          	beqz	a0,ffffffffc0207978 <stride_dequeue+0x294e>
ffffffffc0207644:	00653023          	sd	t1,0(a0)
ffffffffc0207648:	881a                	mv	a6,t1
ffffffffc020764a:	f24ff06f          	j	ffffffffc0206d6e <stride_dequeue+0x1d44>
ffffffffc020764e:	0108b503          	ld	a0,16(a7)
ffffffffc0207652:	85ce                	mv	a1,s3
ffffffffc0207654:	0088bb03          	ld	s6,8(a7)
ffffffffc0207658:	ff2fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020765c:	78a2                	ld	a7,40(sp)
ffffffffc020765e:	7842                	ld	a6,48(sp)
ffffffffc0207660:	0168b823          	sd	s6,16(a7)
ffffffffc0207664:	00a8b423          	sd	a0,8(a7)
ffffffffc0207668:	010c2b03          	lw	s6,16(s8)
ffffffffc020766c:	30050963          	beqz	a0,ffffffffc020797e <stride_dequeue+0x2954>
ffffffffc0207670:	01153023          	sd	a7,0(a0)
ffffffffc0207674:	89c6                	mv	s3,a7
ffffffffc0207676:	caeff06f          	j	ffffffffc0206b24 <stride_dequeue+0x1afa>
ffffffffc020767a:	01083503          	ld	a0,16(a6)
ffffffffc020767e:	85ce                	mv	a1,s3
ffffffffc0207680:	00883b03          	ld	s6,8(a6)
ffffffffc0207684:	fc6fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207688:	7822                	ld	a6,40(sp)
ffffffffc020768a:	78c2                	ld	a7,48(sp)
ffffffffc020768c:	01683823          	sd	s6,16(a6)
ffffffffc0207690:	00a83423          	sd	a0,8(a6)
ffffffffc0207694:	010c2b03          	lw	s6,16(s8)
ffffffffc0207698:	30050b63          	beqz	a0,ffffffffc02079ae <stride_dequeue+0x2984>
ffffffffc020769c:	01053023          	sd	a6,0(a0)
ffffffffc02076a0:	89c2                	mv	s3,a6
ffffffffc02076a2:	da6ff06f          	j	ffffffffc0206c48 <stride_dequeue+0x1c1e>
ffffffffc02076a6:	01083503          	ld	a0,16(a6)
ffffffffc02076aa:	85ce                	mv	a1,s3
ffffffffc02076ac:	00883b03          	ld	s6,8(a6)
ffffffffc02076b0:	f9afd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02076b4:	7802                	ld	a6,32(sp)
ffffffffc02076b6:	7622                	ld	a2,40(sp)
ffffffffc02076b8:	78c2                	ld	a7,48(sp)
ffffffffc02076ba:	01683823          	sd	s6,16(a6)
ffffffffc02076be:	00a83423          	sd	a0,8(a6)
ffffffffc02076c2:	010c2b03          	lw	s6,16(s8)
ffffffffc02076c6:	2a050063          	beqz	a0,ffffffffc0207966 <stride_dequeue+0x293c>
ffffffffc02076ca:	01053023          	sd	a6,0(a0)
ffffffffc02076ce:	89c2                	mv	s3,a6
ffffffffc02076d0:	ddcff06f          	j	ffffffffc0206cac <stride_dequeue+0x1c82>
ffffffffc02076d4:	0109b503          	ld	a0,16(s3)
ffffffffc02076d8:	0089bb03          	ld	s6,8(s3)
ffffffffc02076dc:	85f2                	mv	a1,t3
ffffffffc02076de:	f41a                	sd	t1,40(sp)
ffffffffc02076e0:	f6afd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02076e4:	00a9b423          	sd	a0,8(s3)
ffffffffc02076e8:	0169b823          	sd	s6,16(s3)
ffffffffc02076ec:	7322                	ld	t1,40(sp)
ffffffffc02076ee:	010c2b03          	lw	s6,16(s8)
ffffffffc02076f2:	e119                	bnez	a0,ffffffffc02076f8 <stride_dequeue+0x26ce>
ffffffffc02076f4:	f4afe06f          	j	ffffffffc0205e3e <stride_dequeue+0xe14>
ffffffffc02076f8:	01353023          	sd	s3,0(a0)
ffffffffc02076fc:	f42fe06f          	j	ffffffffc0205e3e <stride_dequeue+0xe14>
ffffffffc0207700:	0109b503          	ld	a0,16(s3)
ffffffffc0207704:	0089bb03          	ld	s6,8(s3)
ffffffffc0207708:	85f2                	mv	a1,t3
ffffffffc020770a:	f446                	sd	a7,40(sp)
ffffffffc020770c:	f3efd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207710:	00a9b423          	sd	a0,8(s3)
ffffffffc0207714:	0169b823          	sd	s6,16(s3)
ffffffffc0207718:	78a2                	ld	a7,40(sp)
ffffffffc020771a:	010c2b03          	lw	s6,16(s8)
ffffffffc020771e:	e119                	bnez	a0,ffffffffc0207724 <stride_dequeue+0x26fa>
ffffffffc0207720:	ce5fe06f          	j	ffffffffc0206404 <stride_dequeue+0x13da>
ffffffffc0207724:	01353023          	sd	s3,0(a0)
ffffffffc0207728:	cddfe06f          	j	ffffffffc0206404 <stride_dequeue+0x13da>
ffffffffc020772c:	0109b503          	ld	a0,16(s3)
ffffffffc0207730:	0089bb03          	ld	s6,8(s3)
ffffffffc0207734:	85f2                	mv	a1,t3
ffffffffc0207736:	f446                	sd	a7,40(sp)
ffffffffc0207738:	f032                	sd	a2,32(sp)
ffffffffc020773a:	f10fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020773e:	00a9b423          	sd	a0,8(s3)
ffffffffc0207742:	0169b823          	sd	s6,16(s3)
ffffffffc0207746:	7602                	ld	a2,32(sp)
ffffffffc0207748:	78a2                	ld	a7,40(sp)
ffffffffc020774a:	010c2b03          	lw	s6,16(s8)
ffffffffc020774e:	e119                	bnez	a0,ffffffffc0207754 <stride_dequeue+0x272a>
ffffffffc0207750:	e05fe06f          	j	ffffffffc0206554 <stride_dequeue+0x152a>
ffffffffc0207754:	01353023          	sd	s3,0(a0)
ffffffffc0207758:	dfdfe06f          	j	ffffffffc0206554 <stride_dequeue+0x152a>
ffffffffc020775c:	010a3503          	ld	a0,16(s4)
ffffffffc0207760:	008a3b03          	ld	s6,8(s4)
ffffffffc0207764:	85f2                	mv	a1,t3
ffffffffc0207766:	f41a                	sd	t1,40(sp)
ffffffffc0207768:	ee2fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020776c:	00aa3423          	sd	a0,8(s4)
ffffffffc0207770:	016a3823          	sd	s6,16(s4)
ffffffffc0207774:	7322                	ld	t1,40(sp)
ffffffffc0207776:	010c2b03          	lw	s6,16(s8)
ffffffffc020777a:	e119                	bnez	a0,ffffffffc0207780 <stride_dequeue+0x2756>
ffffffffc020777c:	ad6fe06f          	j	ffffffffc0205a52 <stride_dequeue+0xa28>
ffffffffc0207780:	01453023          	sd	s4,0(a0)
ffffffffc0207784:	acefe06f          	j	ffffffffc0205a52 <stride_dequeue+0xa28>
ffffffffc0207788:	0109b503          	ld	a0,16(s3)
ffffffffc020778c:	0089bb03          	ld	s6,8(s3)
ffffffffc0207790:	85f2                	mv	a1,t3
ffffffffc0207792:	f446                	sd	a7,40(sp)
ffffffffc0207794:	eb6fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207798:	00a9b423          	sd	a0,8(s3)
ffffffffc020779c:	0169b823          	sd	s6,16(s3)
ffffffffc02077a0:	78a2                	ld	a7,40(sp)
ffffffffc02077a2:	010c2b03          	lw	s6,16(s8)
ffffffffc02077a6:	e119                	bnez	a0,ffffffffc02077ac <stride_dequeue+0x2782>
ffffffffc02077a8:	d01fe06f          	j	ffffffffc02064a8 <stride_dequeue+0x147e>
ffffffffc02077ac:	01353023          	sd	s3,0(a0)
ffffffffc02077b0:	cf9fe06f          	j	ffffffffc02064a8 <stride_dequeue+0x147e>
ffffffffc02077b4:	01033503          	ld	a0,16(t1)
ffffffffc02077b8:	85c2                	mv	a1,a6
ffffffffc02077ba:	00833b03          	ld	s6,8(t1)
ffffffffc02077be:	e8cfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02077c2:	7322                	ld	t1,40(sp)
ffffffffc02077c4:	01633823          	sd	s6,16(t1)
ffffffffc02077c8:	00a33423          	sd	a0,8(t1)
ffffffffc02077cc:	010c2b03          	lw	s6,16(s8)
ffffffffc02077d0:	1e050b63          	beqz	a0,ffffffffc02079c6 <stride_dequeue+0x299c>
ffffffffc02077d4:	00653023          	sd	t1,0(a0)
ffffffffc02077d8:	881a                	mv	a6,t1
ffffffffc02077da:	e50ff06f          	j	ffffffffc0206e2a <stride_dequeue+0x1e00>
ffffffffc02077de:	0109b503          	ld	a0,16(s3)
ffffffffc02077e2:	0089bb03          	ld	s6,8(s3)
ffffffffc02077e6:	85f2                	mv	a1,t3
ffffffffc02077e8:	f442                	sd	a6,40(sp)
ffffffffc02077ea:	f032                	sd	a2,32(sp)
ffffffffc02077ec:	e5efd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02077f0:	00a9b423          	sd	a0,8(s3)
ffffffffc02077f4:	0169b823          	sd	s6,16(s3)
ffffffffc02077f8:	7602                	ld	a2,32(sp)
ffffffffc02077fa:	7822                	ld	a6,40(sp)
ffffffffc02077fc:	010c2b03          	lw	s6,16(s8)
ffffffffc0207800:	e119                	bnez	a0,ffffffffc0207806 <stride_dequeue+0x27dc>
ffffffffc0207802:	e9dfe06f          	j	ffffffffc020669e <stride_dequeue+0x1674>
ffffffffc0207806:	01353023          	sd	s3,0(a0)
ffffffffc020780a:	e95fe06f          	j	ffffffffc020669e <stride_dequeue+0x1674>
ffffffffc020780e:	0108b503          	ld	a0,16(a7)
ffffffffc0207812:	85ce                	mv	a1,s3
ffffffffc0207814:	0088bb03          	ld	s6,8(a7)
ffffffffc0207818:	e32fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc020781c:	78a2                	ld	a7,40(sp)
ffffffffc020781e:	7842                	ld	a6,48(sp)
ffffffffc0207820:	0168b823          	sd	s6,16(a7)
ffffffffc0207824:	00a8b423          	sd	a0,8(a7)
ffffffffc0207828:	010c2b03          	lw	s6,16(s8)
ffffffffc020782c:	0e050f63          	beqz	a0,ffffffffc020792a <stride_dequeue+0x2900>
ffffffffc0207830:	01153023          	sd	a7,0(a0)
ffffffffc0207834:	89c6                	mv	s3,a7
ffffffffc0207836:	d96ff06f          	j	ffffffffc0206dcc <stride_dequeue+0x1da2>
ffffffffc020783a:	01083503          	ld	a0,16(a6)
ffffffffc020783e:	85ce                	mv	a1,s3
ffffffffc0207840:	00883b03          	ld	s6,8(a6)
ffffffffc0207844:	e06fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207848:	7822                	ld	a6,40(sp)
ffffffffc020784a:	78c2                	ld	a7,48(sp)
ffffffffc020784c:	01683823          	sd	s6,16(a6)
ffffffffc0207850:	00a83423          	sd	a0,8(a6)
ffffffffc0207854:	010c2b03          	lw	s6,16(s8)
ffffffffc0207858:	0e050b63          	beqz	a0,ffffffffc020794e <stride_dequeue+0x2924>
ffffffffc020785c:	01053023          	sd	a6,0(a0)
ffffffffc0207860:	89c2                	mv	s3,a6
ffffffffc0207862:	b88ff06f          	j	ffffffffc0206bea <stride_dequeue+0x1bc0>
ffffffffc0207866:	0109b503          	ld	a0,16(s3)
ffffffffc020786a:	0089bb03          	ld	s6,8(s3)
ffffffffc020786e:	85f2                	mv	a1,t3
ffffffffc0207870:	f442                	sd	a6,40(sp)
ffffffffc0207872:	dd8fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207876:	00a9b423          	sd	a0,8(s3)
ffffffffc020787a:	0169b823          	sd	s6,16(s3)
ffffffffc020787e:	7822                	ld	a6,40(sp)
ffffffffc0207880:	010c2b03          	lw	s6,16(s8)
ffffffffc0207884:	e119                	bnez	a0,ffffffffc020788a <stride_dequeue+0x2860>
ffffffffc0207886:	d71fe06f          	j	ffffffffc02065f6 <stride_dequeue+0x15cc>
ffffffffc020788a:	01353023          	sd	s3,0(a0)
ffffffffc020788e:	d69fe06f          	j	ffffffffc02065f6 <stride_dequeue+0x15cc>
ffffffffc0207892:	0109b503          	ld	a0,16(s3)
ffffffffc0207896:	0089bb03          	ld	s6,8(s3)
ffffffffc020789a:	85f2                	mv	a1,t3
ffffffffc020789c:	f442                	sd	a6,40(sp)
ffffffffc020789e:	dacfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02078a2:	00a9b423          	sd	a0,8(s3)
ffffffffc02078a6:	0169b823          	sd	s6,16(s3)
ffffffffc02078aa:	7822                	ld	a6,40(sp)
ffffffffc02078ac:	010c2b03          	lw	s6,16(s8)
ffffffffc02078b0:	e119                	bnez	a0,ffffffffc02078b6 <stride_dequeue+0x288c>
ffffffffc02078b2:	e89fe06f          	j	ffffffffc020673a <stride_dequeue+0x1710>
ffffffffc02078b6:	01353023          	sd	s3,0(a0)
ffffffffc02078ba:	e81fe06f          	j	ffffffffc020673a <stride_dequeue+0x1710>
ffffffffc02078be:	89c6                	mv	s3,a7
ffffffffc02078c0:	a9ffe06f          	j	ffffffffc020635e <stride_dequeue+0x1334>
ffffffffc02078c4:	0109b503          	ld	a0,16(s3)
ffffffffc02078c8:	0089bb03          	ld	s6,8(s3)
ffffffffc02078cc:	85f2                	mv	a1,t3
ffffffffc02078ce:	f41a                	sd	t1,40(sp)
ffffffffc02078d0:	f032                	sd	a2,32(sp)
ffffffffc02078d2:	d78fd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc02078d6:	00a9b423          	sd	a0,8(s3)
ffffffffc02078da:	0169b823          	sd	s6,16(s3)
ffffffffc02078de:	7602                	ld	a2,32(sp)
ffffffffc02078e0:	7322                	ld	t1,40(sp)
ffffffffc02078e2:	010c2b03          	lw	s6,16(s8)
ffffffffc02078e6:	e119                	bnez	a0,ffffffffc02078ec <stride_dequeue+0x28c2>
ffffffffc02078e8:	e32fe06f          	j	ffffffffc0205f1a <stride_dequeue+0xef0>
ffffffffc02078ec:	01353023          	sd	s3,0(a0)
ffffffffc02078f0:	e2afe06f          	j	ffffffffc0205f1a <stride_dequeue+0xef0>
ffffffffc02078f4:	01033503          	ld	a0,16(t1)
ffffffffc02078f8:	85c2                	mv	a1,a6
ffffffffc02078fa:	00833b03          	ld	s6,8(t1)
ffffffffc02078fe:	d4cfd0ef          	jal	ra,ffffffffc0204e4a <skew_heap_merge.constprop.0>
ffffffffc0207902:	7302                	ld	t1,32(sp)
ffffffffc0207904:	7622                	ld	a2,40(sp)
ffffffffc0207906:	01633823          	sd	s6,16(t1)
ffffffffc020790a:	00a33423          	sd	a0,8(t1)
ffffffffc020790e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207912:	c115                	beqz	a0,ffffffffc0207936 <stride_dequeue+0x290c>
ffffffffc0207914:	00653023          	sd	t1,0(a0)
ffffffffc0207918:	881a                	mv	a6,t1
ffffffffc020791a:	d76ff06f          	j	ffffffffc0206e90 <stride_dequeue+0x1e66>
ffffffffc020791e:	89f2                	mv	s3,t3
ffffffffc0207920:	e1bfe06f          	j	ffffffffc020673a <stride_dequeue+0x1710>
ffffffffc0207924:	834e                	mv	t1,s3
ffffffffc0207926:	ef1fe06f          	j	ffffffffc0206816 <stride_dequeue+0x17ec>
ffffffffc020792a:	89c6                	mv	s3,a7
ffffffffc020792c:	ca0ff06f          	j	ffffffffc0206dcc <stride_dequeue+0x1da2>
ffffffffc0207930:	8a42                	mv	s4,a6
ffffffffc0207932:	88aff06f          	j	ffffffffc02069bc <stride_dequeue+0x1992>
ffffffffc0207936:	881a                	mv	a6,t1
ffffffffc0207938:	d58ff06f          	j	ffffffffc0206e90 <stride_dequeue+0x1e66>
ffffffffc020793c:	89f2                	mv	s3,t3
ffffffffc020793e:	ddcfe06f          	j	ffffffffc0205f1a <stride_dequeue+0xef0>
ffffffffc0207942:	834e                	mv	t1,s3
ffffffffc0207944:	e69fe06f          	j	ffffffffc02067ac <stride_dequeue+0x1782>
ffffffffc0207948:	89f2                	mv	s3,t3
ffffffffc020794a:	cadfe06f          	j	ffffffffc02065f6 <stride_dequeue+0x15cc>
ffffffffc020794e:	89c2                	mv	s3,a6
ffffffffc0207950:	a9aff06f          	j	ffffffffc0206bea <stride_dequeue+0x1bc0>
ffffffffc0207954:	89c6                	mv	s3,a7
ffffffffc0207956:	970ff06f          	j	ffffffffc0206ac6 <stride_dequeue+0x1a9c>
ffffffffc020795a:	834e                	mv	t1,s3
ffffffffc020795c:	fdffe06f          	j	ffffffffc020693a <stride_dequeue+0x1910>
ffffffffc0207960:	89f2                	mv	s3,t3
ffffffffc0207962:	cdcfe06f          	j	ffffffffc0205e3e <stride_dequeue+0xe14>
ffffffffc0207966:	89c2                	mv	s3,a6
ffffffffc0207968:	b44ff06f          	j	ffffffffc0206cac <stride_dequeue+0x1c82>
ffffffffc020796c:	884e                	mv	a6,s3
ffffffffc020796e:	f09fe06f          	j	ffffffffc0206876 <stride_dequeue+0x184c>
ffffffffc0207972:	8c9a                	mv	s9,t1
ffffffffc0207974:	b96ff06f          	j	ffffffffc0206d0a <stride_dequeue+0x1ce0>
ffffffffc0207978:	881a                	mv	a6,t1
ffffffffc020797a:	bf4ff06f          	j	ffffffffc0206d6e <stride_dequeue+0x1d44>
ffffffffc020797e:	89c6                	mv	s3,a7
ffffffffc0207980:	9a4ff06f          	j	ffffffffc0206b24 <stride_dequeue+0x1afa>
ffffffffc0207984:	89f2                	mv	s3,t3
ffffffffc0207986:	a7ffe06f          	j	ffffffffc0206404 <stride_dequeue+0x13da>
ffffffffc020798a:	89f2                	mv	s3,t3
ffffffffc020798c:	bc9fe06f          	j	ffffffffc0206554 <stride_dequeue+0x152a>
ffffffffc0207990:	89f2                	mv	s3,t3
ffffffffc0207992:	e56fe06f          	j	ffffffffc0205fe8 <stride_dequeue+0xfbe>
ffffffffc0207996:	89c6                	mv	s3,a7
ffffffffc0207998:	9f0ff06f          	j	ffffffffc0206b88 <stride_dequeue+0x1b5e>
ffffffffc020799c:	834e                	mv	t1,s3
ffffffffc020799e:	f3dfe06f          	j	ffffffffc02068da <stride_dequeue+0x18b0>
ffffffffc02079a2:	8a42                	mv	s4,a6
ffffffffc02079a4:	8ccff06f          	j	ffffffffc0206a70 <stride_dequeue+0x1a46>
ffffffffc02079a8:	8cc2                	mv	s9,a6
ffffffffc02079aa:	868ff06f          	j	ffffffffc0206a12 <stride_dequeue+0x19e8>
ffffffffc02079ae:	89c2                	mv	s3,a6
ffffffffc02079b0:	a98ff06f          	j	ffffffffc0206c48 <stride_dequeue+0x1c1e>
ffffffffc02079b4:	8a72                	mv	s4,t3
ffffffffc02079b6:	89cfe06f          	j	ffffffffc0205a52 <stride_dequeue+0xa28>
ffffffffc02079ba:	89f2                	mv	s3,t3
ffffffffc02079bc:	aedfe06f          	j	ffffffffc02064a8 <stride_dequeue+0x147e>
ffffffffc02079c0:	89f2                	mv	s3,t3
ffffffffc02079c2:	cddfe06f          	j	ffffffffc020669e <stride_dequeue+0x1674>
ffffffffc02079c6:	881a                	mv	a6,t1
ffffffffc02079c8:	c62ff06f          	j	ffffffffc0206e2a <stride_dequeue+0x1e00>

ffffffffc02079cc <sys_getpid>:
ffffffffc02079cc:	00012797          	auipc	a5,0x12
ffffffffc02079d0:	b347b783          	ld	a5,-1228(a5) # ffffffffc0219500 <current>
ffffffffc02079d4:	43c8                	lw	a0,4(a5)
ffffffffc02079d6:	8082                	ret

ffffffffc02079d8 <sys_pgdir>:
ffffffffc02079d8:	4501                	li	a0,0
ffffffffc02079da:	8082                	ret

ffffffffc02079dc <sys_gettime>:
ffffffffc02079dc:	00012797          	auipc	a5,0x12
ffffffffc02079e0:	b547b783          	ld	a5,-1196(a5) # ffffffffc0219530 <ticks>
ffffffffc02079e4:	0027951b          	slliw	a0,a5,0x2
ffffffffc02079e8:	9d3d                	addw	a0,a0,a5
ffffffffc02079ea:	0015151b          	slliw	a0,a0,0x1
ffffffffc02079ee:	8082                	ret

ffffffffc02079f0 <sys_lab6_set_priority>:
ffffffffc02079f0:	4108                	lw	a0,0(a0)
ffffffffc02079f2:	1141                	addi	sp,sp,-16
ffffffffc02079f4:	e406                	sd	ra,8(sp)
ffffffffc02079f6:	ee5fc0ef          	jal	ra,ffffffffc02048da <lab6_set_priority>
ffffffffc02079fa:	60a2                	ld	ra,8(sp)
ffffffffc02079fc:	4501                	li	a0,0
ffffffffc02079fe:	0141                	addi	sp,sp,16
ffffffffc0207a00:	8082                	ret

ffffffffc0207a02 <sys_putc>:
ffffffffc0207a02:	4108                	lw	a0,0(a0)
ffffffffc0207a04:	1141                	addi	sp,sp,-16
ffffffffc0207a06:	e406                	sd	ra,8(sp)
ffffffffc0207a08:	efaf80ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc0207a0c:	60a2                	ld	ra,8(sp)
ffffffffc0207a0e:	4501                	li	a0,0
ffffffffc0207a10:	0141                	addi	sp,sp,16
ffffffffc0207a12:	8082                	ret

ffffffffc0207a14 <sys_kill>:
ffffffffc0207a14:	4108                	lw	a0,0(a0)
ffffffffc0207a16:	d2dfc06f          	j	ffffffffc0204742 <do_kill>

ffffffffc0207a1a <sys_sleep>:
ffffffffc0207a1a:	4108                	lw	a0,0(a0)
ffffffffc0207a1c:	ef9fc06f          	j	ffffffffc0204914 <do_sleep>

ffffffffc0207a20 <sys_yield>:
ffffffffc0207a20:	cd5fc06f          	j	ffffffffc02046f4 <do_yield>

ffffffffc0207a24 <sys_exec>:
ffffffffc0207a24:	6d14                	ld	a3,24(a0)
ffffffffc0207a26:	6910                	ld	a2,16(a0)
ffffffffc0207a28:	650c                	ld	a1,8(a0)
ffffffffc0207a2a:	6108                	ld	a0,0(a0)
ffffffffc0207a2c:	f3efc06f          	j	ffffffffc020416a <do_execve>

ffffffffc0207a30 <sys_wait>:
ffffffffc0207a30:	650c                	ld	a1,8(a0)
ffffffffc0207a32:	4108                	lw	a0,0(a0)
ffffffffc0207a34:	cd1fc06f          	j	ffffffffc0204704 <do_wait>

ffffffffc0207a38 <sys_fork>:
ffffffffc0207a38:	00012797          	auipc	a5,0x12
ffffffffc0207a3c:	ac87b783          	ld	a5,-1336(a5) # ffffffffc0219500 <current>
ffffffffc0207a40:	73d0                	ld	a2,160(a5)
ffffffffc0207a42:	4501                	li	a0,0
ffffffffc0207a44:	6a0c                	ld	a1,16(a2)
ffffffffc0207a46:	ebbfb06f          	j	ffffffffc0203900 <do_fork>

ffffffffc0207a4a <sys_exit>:
ffffffffc0207a4a:	4108                	lw	a0,0(a0)
ffffffffc0207a4c:	ad6fc06f          	j	ffffffffc0203d22 <do_exit>

ffffffffc0207a50 <syscall>:
ffffffffc0207a50:	715d                	addi	sp,sp,-80
ffffffffc0207a52:	fc26                	sd	s1,56(sp)
ffffffffc0207a54:	00012497          	auipc	s1,0x12
ffffffffc0207a58:	aac48493          	addi	s1,s1,-1364 # ffffffffc0219500 <current>
ffffffffc0207a5c:	6098                	ld	a4,0(s1)
ffffffffc0207a5e:	e0a2                	sd	s0,64(sp)
ffffffffc0207a60:	f84a                	sd	s2,48(sp)
ffffffffc0207a62:	7340                	ld	s0,160(a4)
ffffffffc0207a64:	e486                	sd	ra,72(sp)
ffffffffc0207a66:	0ff00793          	li	a5,255
ffffffffc0207a6a:	05042903          	lw	s2,80(s0)
ffffffffc0207a6e:	0327ee63          	bltu	a5,s2,ffffffffc0207aaa <syscall+0x5a>
ffffffffc0207a72:	00391713          	slli	a4,s2,0x3
ffffffffc0207a76:	00002797          	auipc	a5,0x2
ffffffffc0207a7a:	01a78793          	addi	a5,a5,26 # ffffffffc0209a90 <syscalls>
ffffffffc0207a7e:	97ba                	add	a5,a5,a4
ffffffffc0207a80:	639c                	ld	a5,0(a5)
ffffffffc0207a82:	c785                	beqz	a5,ffffffffc0207aaa <syscall+0x5a>
ffffffffc0207a84:	6c28                	ld	a0,88(s0)
ffffffffc0207a86:	702c                	ld	a1,96(s0)
ffffffffc0207a88:	7430                	ld	a2,104(s0)
ffffffffc0207a8a:	7834                	ld	a3,112(s0)
ffffffffc0207a8c:	7c38                	ld	a4,120(s0)
ffffffffc0207a8e:	e42a                	sd	a0,8(sp)
ffffffffc0207a90:	e82e                	sd	a1,16(sp)
ffffffffc0207a92:	ec32                	sd	a2,24(sp)
ffffffffc0207a94:	f036                	sd	a3,32(sp)
ffffffffc0207a96:	f43a                	sd	a4,40(sp)
ffffffffc0207a98:	0028                	addi	a0,sp,8
ffffffffc0207a9a:	9782                	jalr	a5
ffffffffc0207a9c:	60a6                	ld	ra,72(sp)
ffffffffc0207a9e:	e828                	sd	a0,80(s0)
ffffffffc0207aa0:	6406                	ld	s0,64(sp)
ffffffffc0207aa2:	74e2                	ld	s1,56(sp)
ffffffffc0207aa4:	7942                	ld	s2,48(sp)
ffffffffc0207aa6:	6161                	addi	sp,sp,80
ffffffffc0207aa8:	8082                	ret
ffffffffc0207aaa:	8522                	mv	a0,s0
ffffffffc0207aac:	d7bf80ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0207ab0:	609c                	ld	a5,0(s1)
ffffffffc0207ab2:	86ca                	mv	a3,s2
ffffffffc0207ab4:	00002617          	auipc	a2,0x2
ffffffffc0207ab8:	f9460613          	addi	a2,a2,-108 # ffffffffc0209a48 <default_pmm_manager+0x828>
ffffffffc0207abc:	43d8                	lw	a4,4(a5)
ffffffffc0207abe:	07300593          	li	a1,115
ffffffffc0207ac2:	0b478793          	addi	a5,a5,180
ffffffffc0207ac6:	00002517          	auipc	a0,0x2
ffffffffc0207aca:	fb250513          	addi	a0,a0,-78 # ffffffffc0209a78 <default_pmm_manager+0x858>
ffffffffc0207ace:	f3af80ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0207ad2 <strnlen>:
ffffffffc0207ad2:	872a                	mv	a4,a0
ffffffffc0207ad4:	4501                	li	a0,0
ffffffffc0207ad6:	e589                	bnez	a1,ffffffffc0207ae0 <strnlen+0xe>
ffffffffc0207ad8:	a811                	j	ffffffffc0207aec <strnlen+0x1a>
ffffffffc0207ada:	0505                	addi	a0,a0,1
ffffffffc0207adc:	00a58763          	beq	a1,a0,ffffffffc0207aea <strnlen+0x18>
ffffffffc0207ae0:	00a707b3          	add	a5,a4,a0
ffffffffc0207ae4:	0007c783          	lbu	a5,0(a5)
ffffffffc0207ae8:	fbed                	bnez	a5,ffffffffc0207ada <strnlen+0x8>
ffffffffc0207aea:	8082                	ret
ffffffffc0207aec:	8082                	ret

ffffffffc0207aee <strcmp>:
ffffffffc0207aee:	00054783          	lbu	a5,0(a0)
ffffffffc0207af2:	0005c703          	lbu	a4,0(a1)
ffffffffc0207af6:	cb89                	beqz	a5,ffffffffc0207b08 <strcmp+0x1a>
ffffffffc0207af8:	0505                	addi	a0,a0,1
ffffffffc0207afa:	0585                	addi	a1,a1,1
ffffffffc0207afc:	fee789e3          	beq	a5,a4,ffffffffc0207aee <strcmp>
ffffffffc0207b00:	0007851b          	sext.w	a0,a5
ffffffffc0207b04:	9d19                	subw	a0,a0,a4
ffffffffc0207b06:	8082                	ret
ffffffffc0207b08:	4501                	li	a0,0
ffffffffc0207b0a:	bfed                	j	ffffffffc0207b04 <strcmp+0x16>

ffffffffc0207b0c <strchr>:
ffffffffc0207b0c:	00054783          	lbu	a5,0(a0)
ffffffffc0207b10:	c799                	beqz	a5,ffffffffc0207b1e <strchr+0x12>
ffffffffc0207b12:	00f58763          	beq	a1,a5,ffffffffc0207b20 <strchr+0x14>
ffffffffc0207b16:	00154783          	lbu	a5,1(a0)
ffffffffc0207b1a:	0505                	addi	a0,a0,1
ffffffffc0207b1c:	fbfd                	bnez	a5,ffffffffc0207b12 <strchr+0x6>
ffffffffc0207b1e:	4501                	li	a0,0
ffffffffc0207b20:	8082                	ret

ffffffffc0207b22 <memset>:
ffffffffc0207b22:	ca01                	beqz	a2,ffffffffc0207b32 <memset+0x10>
ffffffffc0207b24:	962a                	add	a2,a2,a0
ffffffffc0207b26:	87aa                	mv	a5,a0
ffffffffc0207b28:	0785                	addi	a5,a5,1
ffffffffc0207b2a:	feb78fa3          	sb	a1,-1(a5)
ffffffffc0207b2e:	fec79de3          	bne	a5,a2,ffffffffc0207b28 <memset+0x6>
ffffffffc0207b32:	8082                	ret

ffffffffc0207b34 <memcpy>:
ffffffffc0207b34:	ca19                	beqz	a2,ffffffffc0207b4a <memcpy+0x16>
ffffffffc0207b36:	962e                	add	a2,a2,a1
ffffffffc0207b38:	87aa                	mv	a5,a0
ffffffffc0207b3a:	0005c703          	lbu	a4,0(a1)
ffffffffc0207b3e:	0585                	addi	a1,a1,1
ffffffffc0207b40:	0785                	addi	a5,a5,1
ffffffffc0207b42:	fee78fa3          	sb	a4,-1(a5)
ffffffffc0207b46:	fec59ae3          	bne	a1,a2,ffffffffc0207b3a <memcpy+0x6>
ffffffffc0207b4a:	8082                	ret

ffffffffc0207b4c <printnum>:
ffffffffc0207b4c:	02069813          	slli	a6,a3,0x20
ffffffffc0207b50:	7179                	addi	sp,sp,-48
ffffffffc0207b52:	02085813          	srli	a6,a6,0x20
ffffffffc0207b56:	e052                	sd	s4,0(sp)
ffffffffc0207b58:	03067a33          	remu	s4,a2,a6
ffffffffc0207b5c:	f022                	sd	s0,32(sp)
ffffffffc0207b5e:	ec26                	sd	s1,24(sp)
ffffffffc0207b60:	e84a                	sd	s2,16(sp)
ffffffffc0207b62:	f406                	sd	ra,40(sp)
ffffffffc0207b64:	e44e                	sd	s3,8(sp)
ffffffffc0207b66:	84aa                	mv	s1,a0
ffffffffc0207b68:	892e                	mv	s2,a1
ffffffffc0207b6a:	fff7041b          	addiw	s0,a4,-1
ffffffffc0207b6e:	2a01                	sext.w	s4,s4
ffffffffc0207b70:	03067e63          	bgeu	a2,a6,ffffffffc0207bac <printnum+0x60>
ffffffffc0207b74:	89be                	mv	s3,a5
ffffffffc0207b76:	00805763          	blez	s0,ffffffffc0207b84 <printnum+0x38>
ffffffffc0207b7a:	347d                	addiw	s0,s0,-1
ffffffffc0207b7c:	85ca                	mv	a1,s2
ffffffffc0207b7e:	854e                	mv	a0,s3
ffffffffc0207b80:	9482                	jalr	s1
ffffffffc0207b82:	fc65                	bnez	s0,ffffffffc0207b7a <printnum+0x2e>
ffffffffc0207b84:	1a02                	slli	s4,s4,0x20
ffffffffc0207b86:	020a5a13          	srli	s4,s4,0x20
ffffffffc0207b8a:	00002797          	auipc	a5,0x2
ffffffffc0207b8e:	70678793          	addi	a5,a5,1798 # ffffffffc020a290 <syscalls+0x800>
ffffffffc0207b92:	7402                	ld	s0,32(sp)
ffffffffc0207b94:	9a3e                	add	s4,s4,a5
ffffffffc0207b96:	000a4503          	lbu	a0,0(s4)
ffffffffc0207b9a:	70a2                	ld	ra,40(sp)
ffffffffc0207b9c:	69a2                	ld	s3,8(sp)
ffffffffc0207b9e:	6a02                	ld	s4,0(sp)
ffffffffc0207ba0:	85ca                	mv	a1,s2
ffffffffc0207ba2:	8326                	mv	t1,s1
ffffffffc0207ba4:	6942                	ld	s2,16(sp)
ffffffffc0207ba6:	64e2                	ld	s1,24(sp)
ffffffffc0207ba8:	6145                	addi	sp,sp,48
ffffffffc0207baa:	8302                	jr	t1
ffffffffc0207bac:	03065633          	divu	a2,a2,a6
ffffffffc0207bb0:	8722                	mv	a4,s0
ffffffffc0207bb2:	f9bff0ef          	jal	ra,ffffffffc0207b4c <printnum>
ffffffffc0207bb6:	b7f9                	j	ffffffffc0207b84 <printnum+0x38>

ffffffffc0207bb8 <vprintfmt>:
ffffffffc0207bb8:	7119                	addi	sp,sp,-128
ffffffffc0207bba:	f4a6                	sd	s1,104(sp)
ffffffffc0207bbc:	f0ca                	sd	s2,96(sp)
ffffffffc0207bbe:	ecce                	sd	s3,88(sp)
ffffffffc0207bc0:	e8d2                	sd	s4,80(sp)
ffffffffc0207bc2:	e4d6                	sd	s5,72(sp)
ffffffffc0207bc4:	e0da                	sd	s6,64(sp)
ffffffffc0207bc6:	fc5e                	sd	s7,56(sp)
ffffffffc0207bc8:	f06a                	sd	s10,32(sp)
ffffffffc0207bca:	fc86                	sd	ra,120(sp)
ffffffffc0207bcc:	f8a2                	sd	s0,112(sp)
ffffffffc0207bce:	f862                	sd	s8,48(sp)
ffffffffc0207bd0:	f466                	sd	s9,40(sp)
ffffffffc0207bd2:	ec6e                	sd	s11,24(sp)
ffffffffc0207bd4:	892a                	mv	s2,a0
ffffffffc0207bd6:	84ae                	mv	s1,a1
ffffffffc0207bd8:	8d32                	mv	s10,a2
ffffffffc0207bda:	8a36                	mv	s4,a3
ffffffffc0207bdc:	02500993          	li	s3,37
ffffffffc0207be0:	5b7d                	li	s6,-1
ffffffffc0207be2:	00002a97          	auipc	s5,0x2
ffffffffc0207be6:	6daa8a93          	addi	s5,s5,1754 # ffffffffc020a2bc <syscalls+0x82c>
ffffffffc0207bea:	00003b97          	auipc	s7,0x3
ffffffffc0207bee:	8eeb8b93          	addi	s7,s7,-1810 # ffffffffc020a4d8 <error_string>
ffffffffc0207bf2:	000d4503          	lbu	a0,0(s10)
ffffffffc0207bf6:	001d0413          	addi	s0,s10,1
ffffffffc0207bfa:	01350a63          	beq	a0,s3,ffffffffc0207c0e <vprintfmt+0x56>
ffffffffc0207bfe:	c121                	beqz	a0,ffffffffc0207c3e <vprintfmt+0x86>
ffffffffc0207c00:	85a6                	mv	a1,s1
ffffffffc0207c02:	0405                	addi	s0,s0,1
ffffffffc0207c04:	9902                	jalr	s2
ffffffffc0207c06:	fff44503          	lbu	a0,-1(s0)
ffffffffc0207c0a:	ff351ae3          	bne	a0,s3,ffffffffc0207bfe <vprintfmt+0x46>
ffffffffc0207c0e:	00044603          	lbu	a2,0(s0)
ffffffffc0207c12:	02000793          	li	a5,32
ffffffffc0207c16:	4c81                	li	s9,0
ffffffffc0207c18:	4881                	li	a7,0
ffffffffc0207c1a:	5c7d                	li	s8,-1
ffffffffc0207c1c:	5dfd                	li	s11,-1
ffffffffc0207c1e:	05500513          	li	a0,85
ffffffffc0207c22:	4825                	li	a6,9
ffffffffc0207c24:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0207c28:	0ff5f593          	andi	a1,a1,255
ffffffffc0207c2c:	00140d13          	addi	s10,s0,1
ffffffffc0207c30:	04b56263          	bltu	a0,a1,ffffffffc0207c74 <vprintfmt+0xbc>
ffffffffc0207c34:	058a                	slli	a1,a1,0x2
ffffffffc0207c36:	95d6                	add	a1,a1,s5
ffffffffc0207c38:	4194                	lw	a3,0(a1)
ffffffffc0207c3a:	96d6                	add	a3,a3,s5
ffffffffc0207c3c:	8682                	jr	a3
ffffffffc0207c3e:	70e6                	ld	ra,120(sp)
ffffffffc0207c40:	7446                	ld	s0,112(sp)
ffffffffc0207c42:	74a6                	ld	s1,104(sp)
ffffffffc0207c44:	7906                	ld	s2,96(sp)
ffffffffc0207c46:	69e6                	ld	s3,88(sp)
ffffffffc0207c48:	6a46                	ld	s4,80(sp)
ffffffffc0207c4a:	6aa6                	ld	s5,72(sp)
ffffffffc0207c4c:	6b06                	ld	s6,64(sp)
ffffffffc0207c4e:	7be2                	ld	s7,56(sp)
ffffffffc0207c50:	7c42                	ld	s8,48(sp)
ffffffffc0207c52:	7ca2                	ld	s9,40(sp)
ffffffffc0207c54:	7d02                	ld	s10,32(sp)
ffffffffc0207c56:	6de2                	ld	s11,24(sp)
ffffffffc0207c58:	6109                	addi	sp,sp,128
ffffffffc0207c5a:	8082                	ret
ffffffffc0207c5c:	87b2                	mv	a5,a2
ffffffffc0207c5e:	00144603          	lbu	a2,1(s0)
ffffffffc0207c62:	846a                	mv	s0,s10
ffffffffc0207c64:	00140d13          	addi	s10,s0,1
ffffffffc0207c68:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0207c6c:	0ff5f593          	andi	a1,a1,255
ffffffffc0207c70:	fcb572e3          	bgeu	a0,a1,ffffffffc0207c34 <vprintfmt+0x7c>
ffffffffc0207c74:	85a6                	mv	a1,s1
ffffffffc0207c76:	02500513          	li	a0,37
ffffffffc0207c7a:	9902                	jalr	s2
ffffffffc0207c7c:	fff44783          	lbu	a5,-1(s0)
ffffffffc0207c80:	8d22                	mv	s10,s0
ffffffffc0207c82:	f73788e3          	beq	a5,s3,ffffffffc0207bf2 <vprintfmt+0x3a>
ffffffffc0207c86:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0207c8a:	1d7d                	addi	s10,s10,-1
ffffffffc0207c8c:	ff379de3          	bne	a5,s3,ffffffffc0207c86 <vprintfmt+0xce>
ffffffffc0207c90:	b78d                	j	ffffffffc0207bf2 <vprintfmt+0x3a>
ffffffffc0207c92:	fd060c1b          	addiw	s8,a2,-48
ffffffffc0207c96:	00144603          	lbu	a2,1(s0)
ffffffffc0207c9a:	846a                	mv	s0,s10
ffffffffc0207c9c:	fd06069b          	addiw	a3,a2,-48
ffffffffc0207ca0:	0006059b          	sext.w	a1,a2
ffffffffc0207ca4:	02d86463          	bltu	a6,a3,ffffffffc0207ccc <vprintfmt+0x114>
ffffffffc0207ca8:	00144603          	lbu	a2,1(s0)
ffffffffc0207cac:	002c169b          	slliw	a3,s8,0x2
ffffffffc0207cb0:	0186873b          	addw	a4,a3,s8
ffffffffc0207cb4:	0017171b          	slliw	a4,a4,0x1
ffffffffc0207cb8:	9f2d                	addw	a4,a4,a1
ffffffffc0207cba:	fd06069b          	addiw	a3,a2,-48
ffffffffc0207cbe:	0405                	addi	s0,s0,1
ffffffffc0207cc0:	fd070c1b          	addiw	s8,a4,-48
ffffffffc0207cc4:	0006059b          	sext.w	a1,a2
ffffffffc0207cc8:	fed870e3          	bgeu	a6,a3,ffffffffc0207ca8 <vprintfmt+0xf0>
ffffffffc0207ccc:	f40ddce3          	bgez	s11,ffffffffc0207c24 <vprintfmt+0x6c>
ffffffffc0207cd0:	8de2                	mv	s11,s8
ffffffffc0207cd2:	5c7d                	li	s8,-1
ffffffffc0207cd4:	bf81                	j	ffffffffc0207c24 <vprintfmt+0x6c>
ffffffffc0207cd6:	fffdc693          	not	a3,s11
ffffffffc0207cda:	96fd                	srai	a3,a3,0x3f
ffffffffc0207cdc:	00ddfdb3          	and	s11,s11,a3
ffffffffc0207ce0:	00144603          	lbu	a2,1(s0)
ffffffffc0207ce4:	2d81                	sext.w	s11,s11
ffffffffc0207ce6:	846a                	mv	s0,s10
ffffffffc0207ce8:	bf35                	j	ffffffffc0207c24 <vprintfmt+0x6c>
ffffffffc0207cea:	000a2c03          	lw	s8,0(s4)
ffffffffc0207cee:	00144603          	lbu	a2,1(s0)
ffffffffc0207cf2:	0a21                	addi	s4,s4,8
ffffffffc0207cf4:	846a                	mv	s0,s10
ffffffffc0207cf6:	bfd9                	j	ffffffffc0207ccc <vprintfmt+0x114>
ffffffffc0207cf8:	4705                	li	a4,1
ffffffffc0207cfa:	008a0593          	addi	a1,s4,8
ffffffffc0207cfe:	01174463          	blt	a4,a7,ffffffffc0207d06 <vprintfmt+0x14e>
ffffffffc0207d02:	1a088e63          	beqz	a7,ffffffffc0207ebe <vprintfmt+0x306>
ffffffffc0207d06:	000a3603          	ld	a2,0(s4)
ffffffffc0207d0a:	46c1                	li	a3,16
ffffffffc0207d0c:	8a2e                	mv	s4,a1
ffffffffc0207d0e:	2781                	sext.w	a5,a5
ffffffffc0207d10:	876e                	mv	a4,s11
ffffffffc0207d12:	85a6                	mv	a1,s1
ffffffffc0207d14:	854a                	mv	a0,s2
ffffffffc0207d16:	e37ff0ef          	jal	ra,ffffffffc0207b4c <printnum>
ffffffffc0207d1a:	bde1                	j	ffffffffc0207bf2 <vprintfmt+0x3a>
ffffffffc0207d1c:	000a2503          	lw	a0,0(s4)
ffffffffc0207d20:	85a6                	mv	a1,s1
ffffffffc0207d22:	0a21                	addi	s4,s4,8
ffffffffc0207d24:	9902                	jalr	s2
ffffffffc0207d26:	b5f1                	j	ffffffffc0207bf2 <vprintfmt+0x3a>
ffffffffc0207d28:	4705                	li	a4,1
ffffffffc0207d2a:	008a0593          	addi	a1,s4,8
ffffffffc0207d2e:	01174463          	blt	a4,a7,ffffffffc0207d36 <vprintfmt+0x17e>
ffffffffc0207d32:	18088163          	beqz	a7,ffffffffc0207eb4 <vprintfmt+0x2fc>
ffffffffc0207d36:	000a3603          	ld	a2,0(s4)
ffffffffc0207d3a:	46a9                	li	a3,10
ffffffffc0207d3c:	8a2e                	mv	s4,a1
ffffffffc0207d3e:	bfc1                	j	ffffffffc0207d0e <vprintfmt+0x156>
ffffffffc0207d40:	00144603          	lbu	a2,1(s0)
ffffffffc0207d44:	4c85                	li	s9,1
ffffffffc0207d46:	846a                	mv	s0,s10
ffffffffc0207d48:	bdf1                	j	ffffffffc0207c24 <vprintfmt+0x6c>
ffffffffc0207d4a:	85a6                	mv	a1,s1
ffffffffc0207d4c:	02500513          	li	a0,37
ffffffffc0207d50:	9902                	jalr	s2
ffffffffc0207d52:	b545                	j	ffffffffc0207bf2 <vprintfmt+0x3a>
ffffffffc0207d54:	00144603          	lbu	a2,1(s0)
ffffffffc0207d58:	2885                	addiw	a7,a7,1
ffffffffc0207d5a:	846a                	mv	s0,s10
ffffffffc0207d5c:	b5e1                	j	ffffffffc0207c24 <vprintfmt+0x6c>
ffffffffc0207d5e:	4705                	li	a4,1
ffffffffc0207d60:	008a0593          	addi	a1,s4,8
ffffffffc0207d64:	01174463          	blt	a4,a7,ffffffffc0207d6c <vprintfmt+0x1b4>
ffffffffc0207d68:	14088163          	beqz	a7,ffffffffc0207eaa <vprintfmt+0x2f2>
ffffffffc0207d6c:	000a3603          	ld	a2,0(s4)
ffffffffc0207d70:	46a1                	li	a3,8
ffffffffc0207d72:	8a2e                	mv	s4,a1
ffffffffc0207d74:	bf69                	j	ffffffffc0207d0e <vprintfmt+0x156>
ffffffffc0207d76:	03000513          	li	a0,48
ffffffffc0207d7a:	85a6                	mv	a1,s1
ffffffffc0207d7c:	e03e                	sd	a5,0(sp)
ffffffffc0207d7e:	9902                	jalr	s2
ffffffffc0207d80:	85a6                	mv	a1,s1
ffffffffc0207d82:	07800513          	li	a0,120
ffffffffc0207d86:	9902                	jalr	s2
ffffffffc0207d88:	0a21                	addi	s4,s4,8
ffffffffc0207d8a:	6782                	ld	a5,0(sp)
ffffffffc0207d8c:	46c1                	li	a3,16
ffffffffc0207d8e:	ff8a3603          	ld	a2,-8(s4)
ffffffffc0207d92:	bfb5                	j	ffffffffc0207d0e <vprintfmt+0x156>
ffffffffc0207d94:	000a3403          	ld	s0,0(s4)
ffffffffc0207d98:	008a0713          	addi	a4,s4,8
ffffffffc0207d9c:	e03a                	sd	a4,0(sp)
ffffffffc0207d9e:	14040263          	beqz	s0,ffffffffc0207ee2 <vprintfmt+0x32a>
ffffffffc0207da2:	0fb05763          	blez	s11,ffffffffc0207e90 <vprintfmt+0x2d8>
ffffffffc0207da6:	02d00693          	li	a3,45
ffffffffc0207daa:	0cd79163          	bne	a5,a3,ffffffffc0207e6c <vprintfmt+0x2b4>
ffffffffc0207dae:	00044783          	lbu	a5,0(s0)
ffffffffc0207db2:	0007851b          	sext.w	a0,a5
ffffffffc0207db6:	cf85                	beqz	a5,ffffffffc0207dee <vprintfmt+0x236>
ffffffffc0207db8:	00140a13          	addi	s4,s0,1
ffffffffc0207dbc:	05e00413          	li	s0,94
ffffffffc0207dc0:	000c4563          	bltz	s8,ffffffffc0207dca <vprintfmt+0x212>
ffffffffc0207dc4:	3c7d                	addiw	s8,s8,-1
ffffffffc0207dc6:	036c0263          	beq	s8,s6,ffffffffc0207dea <vprintfmt+0x232>
ffffffffc0207dca:	85a6                	mv	a1,s1
ffffffffc0207dcc:	0e0c8e63          	beqz	s9,ffffffffc0207ec8 <vprintfmt+0x310>
ffffffffc0207dd0:	3781                	addiw	a5,a5,-32
ffffffffc0207dd2:	0ef47b63          	bgeu	s0,a5,ffffffffc0207ec8 <vprintfmt+0x310>
ffffffffc0207dd6:	03f00513          	li	a0,63
ffffffffc0207dda:	9902                	jalr	s2
ffffffffc0207ddc:	000a4783          	lbu	a5,0(s4)
ffffffffc0207de0:	3dfd                	addiw	s11,s11,-1
ffffffffc0207de2:	0a05                	addi	s4,s4,1
ffffffffc0207de4:	0007851b          	sext.w	a0,a5
ffffffffc0207de8:	ffe1                	bnez	a5,ffffffffc0207dc0 <vprintfmt+0x208>
ffffffffc0207dea:	01b05963          	blez	s11,ffffffffc0207dfc <vprintfmt+0x244>
ffffffffc0207dee:	3dfd                	addiw	s11,s11,-1
ffffffffc0207df0:	85a6                	mv	a1,s1
ffffffffc0207df2:	02000513          	li	a0,32
ffffffffc0207df6:	9902                	jalr	s2
ffffffffc0207df8:	fe0d9be3          	bnez	s11,ffffffffc0207dee <vprintfmt+0x236>
ffffffffc0207dfc:	6a02                	ld	s4,0(sp)
ffffffffc0207dfe:	bbd5                	j	ffffffffc0207bf2 <vprintfmt+0x3a>
ffffffffc0207e00:	4705                	li	a4,1
ffffffffc0207e02:	008a0c93          	addi	s9,s4,8
ffffffffc0207e06:	01174463          	blt	a4,a7,ffffffffc0207e0e <vprintfmt+0x256>
ffffffffc0207e0a:	08088d63          	beqz	a7,ffffffffc0207ea4 <vprintfmt+0x2ec>
ffffffffc0207e0e:	000a3403          	ld	s0,0(s4)
ffffffffc0207e12:	0a044d63          	bltz	s0,ffffffffc0207ecc <vprintfmt+0x314>
ffffffffc0207e16:	8622                	mv	a2,s0
ffffffffc0207e18:	8a66                	mv	s4,s9
ffffffffc0207e1a:	46a9                	li	a3,10
ffffffffc0207e1c:	bdcd                	j	ffffffffc0207d0e <vprintfmt+0x156>
ffffffffc0207e1e:	000a2783          	lw	a5,0(s4)
ffffffffc0207e22:	4761                	li	a4,24
ffffffffc0207e24:	0a21                	addi	s4,s4,8
ffffffffc0207e26:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0207e2a:	8fb5                	xor	a5,a5,a3
ffffffffc0207e2c:	40d786bb          	subw	a3,a5,a3
ffffffffc0207e30:	02d74163          	blt	a4,a3,ffffffffc0207e52 <vprintfmt+0x29a>
ffffffffc0207e34:	00369793          	slli	a5,a3,0x3
ffffffffc0207e38:	97de                	add	a5,a5,s7
ffffffffc0207e3a:	639c                	ld	a5,0(a5)
ffffffffc0207e3c:	cb99                	beqz	a5,ffffffffc0207e52 <vprintfmt+0x29a>
ffffffffc0207e3e:	86be                	mv	a3,a5
ffffffffc0207e40:	00000617          	auipc	a2,0x0
ffffffffc0207e44:	13060613          	addi	a2,a2,304 # ffffffffc0207f70 <etext+0x20>
ffffffffc0207e48:	85a6                	mv	a1,s1
ffffffffc0207e4a:	854a                	mv	a0,s2
ffffffffc0207e4c:	0ce000ef          	jal	ra,ffffffffc0207f1a <printfmt>
ffffffffc0207e50:	b34d                	j	ffffffffc0207bf2 <vprintfmt+0x3a>
ffffffffc0207e52:	00002617          	auipc	a2,0x2
ffffffffc0207e56:	45e60613          	addi	a2,a2,1118 # ffffffffc020a2b0 <syscalls+0x820>
ffffffffc0207e5a:	85a6                	mv	a1,s1
ffffffffc0207e5c:	854a                	mv	a0,s2
ffffffffc0207e5e:	0bc000ef          	jal	ra,ffffffffc0207f1a <printfmt>
ffffffffc0207e62:	bb41                	j	ffffffffc0207bf2 <vprintfmt+0x3a>
ffffffffc0207e64:	00002417          	auipc	s0,0x2
ffffffffc0207e68:	44440413          	addi	s0,s0,1092 # ffffffffc020a2a8 <syscalls+0x818>
ffffffffc0207e6c:	85e2                	mv	a1,s8
ffffffffc0207e6e:	8522                	mv	a0,s0
ffffffffc0207e70:	e43e                	sd	a5,8(sp)
ffffffffc0207e72:	c61ff0ef          	jal	ra,ffffffffc0207ad2 <strnlen>
ffffffffc0207e76:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0207e7a:	01b05b63          	blez	s11,ffffffffc0207e90 <vprintfmt+0x2d8>
ffffffffc0207e7e:	67a2                	ld	a5,8(sp)
ffffffffc0207e80:	00078a1b          	sext.w	s4,a5
ffffffffc0207e84:	3dfd                	addiw	s11,s11,-1
ffffffffc0207e86:	85a6                	mv	a1,s1
ffffffffc0207e88:	8552                	mv	a0,s4
ffffffffc0207e8a:	9902                	jalr	s2
ffffffffc0207e8c:	fe0d9ce3          	bnez	s11,ffffffffc0207e84 <vprintfmt+0x2cc>
ffffffffc0207e90:	00044783          	lbu	a5,0(s0)
ffffffffc0207e94:	00140a13          	addi	s4,s0,1
ffffffffc0207e98:	0007851b          	sext.w	a0,a5
ffffffffc0207e9c:	d3a5                	beqz	a5,ffffffffc0207dfc <vprintfmt+0x244>
ffffffffc0207e9e:	05e00413          	li	s0,94
ffffffffc0207ea2:	bf39                	j	ffffffffc0207dc0 <vprintfmt+0x208>
ffffffffc0207ea4:	000a2403          	lw	s0,0(s4)
ffffffffc0207ea8:	b7ad                	j	ffffffffc0207e12 <vprintfmt+0x25a>
ffffffffc0207eaa:	000a6603          	lwu	a2,0(s4)
ffffffffc0207eae:	46a1                	li	a3,8
ffffffffc0207eb0:	8a2e                	mv	s4,a1
ffffffffc0207eb2:	bdb1                	j	ffffffffc0207d0e <vprintfmt+0x156>
ffffffffc0207eb4:	000a6603          	lwu	a2,0(s4)
ffffffffc0207eb8:	46a9                	li	a3,10
ffffffffc0207eba:	8a2e                	mv	s4,a1
ffffffffc0207ebc:	bd89                	j	ffffffffc0207d0e <vprintfmt+0x156>
ffffffffc0207ebe:	000a6603          	lwu	a2,0(s4)
ffffffffc0207ec2:	46c1                	li	a3,16
ffffffffc0207ec4:	8a2e                	mv	s4,a1
ffffffffc0207ec6:	b5a1                	j	ffffffffc0207d0e <vprintfmt+0x156>
ffffffffc0207ec8:	9902                	jalr	s2
ffffffffc0207eca:	bf09                	j	ffffffffc0207ddc <vprintfmt+0x224>
ffffffffc0207ecc:	85a6                	mv	a1,s1
ffffffffc0207ece:	02d00513          	li	a0,45
ffffffffc0207ed2:	e03e                	sd	a5,0(sp)
ffffffffc0207ed4:	9902                	jalr	s2
ffffffffc0207ed6:	6782                	ld	a5,0(sp)
ffffffffc0207ed8:	8a66                	mv	s4,s9
ffffffffc0207eda:	40800633          	neg	a2,s0
ffffffffc0207ede:	46a9                	li	a3,10
ffffffffc0207ee0:	b53d                	j	ffffffffc0207d0e <vprintfmt+0x156>
ffffffffc0207ee2:	03b05163          	blez	s11,ffffffffc0207f04 <vprintfmt+0x34c>
ffffffffc0207ee6:	02d00693          	li	a3,45
ffffffffc0207eea:	f6d79de3          	bne	a5,a3,ffffffffc0207e64 <vprintfmt+0x2ac>
ffffffffc0207eee:	00002417          	auipc	s0,0x2
ffffffffc0207ef2:	3ba40413          	addi	s0,s0,954 # ffffffffc020a2a8 <syscalls+0x818>
ffffffffc0207ef6:	02800793          	li	a5,40
ffffffffc0207efa:	02800513          	li	a0,40
ffffffffc0207efe:	00140a13          	addi	s4,s0,1
ffffffffc0207f02:	bd6d                	j	ffffffffc0207dbc <vprintfmt+0x204>
ffffffffc0207f04:	00002a17          	auipc	s4,0x2
ffffffffc0207f08:	3a5a0a13          	addi	s4,s4,933 # ffffffffc020a2a9 <syscalls+0x819>
ffffffffc0207f0c:	02800513          	li	a0,40
ffffffffc0207f10:	02800793          	li	a5,40
ffffffffc0207f14:	05e00413          	li	s0,94
ffffffffc0207f18:	b565                	j	ffffffffc0207dc0 <vprintfmt+0x208>

ffffffffc0207f1a <printfmt>:
ffffffffc0207f1a:	715d                	addi	sp,sp,-80
ffffffffc0207f1c:	02810313          	addi	t1,sp,40
ffffffffc0207f20:	f436                	sd	a3,40(sp)
ffffffffc0207f22:	869a                	mv	a3,t1
ffffffffc0207f24:	ec06                	sd	ra,24(sp)
ffffffffc0207f26:	f83a                	sd	a4,48(sp)
ffffffffc0207f28:	fc3e                	sd	a5,56(sp)
ffffffffc0207f2a:	e0c2                	sd	a6,64(sp)
ffffffffc0207f2c:	e4c6                	sd	a7,72(sp)
ffffffffc0207f2e:	e41a                	sd	t1,8(sp)
ffffffffc0207f30:	c89ff0ef          	jal	ra,ffffffffc0207bb8 <vprintfmt>
ffffffffc0207f34:	60e2                	ld	ra,24(sp)
ffffffffc0207f36:	6161                	addi	sp,sp,80
ffffffffc0207f38:	8082                	ret

ffffffffc0207f3a <hash32>:
ffffffffc0207f3a:	9e3707b7          	lui	a5,0x9e370
ffffffffc0207f3e:	2785                	addiw	a5,a5,1
ffffffffc0207f40:	02a7853b          	mulw	a0,a5,a0
ffffffffc0207f44:	02000793          	li	a5,32
ffffffffc0207f48:	9f8d                	subw	a5,a5,a1
ffffffffc0207f4a:	00f5553b          	srlw	a0,a0,a5
ffffffffc0207f4e:	8082                	ret

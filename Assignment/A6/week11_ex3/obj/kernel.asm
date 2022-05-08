
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:

    .section .text,"ax",%progbits
    .globl kern_entry
kern_entry:
    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200000:	c020a2b7          	lui	t0,0xc020a
    # t1 := 0xffffffff40000000 即虚实映射偏移量
    li      t1, 0xffffffffc0000000 - 0x80000000
ffffffffc0200004:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200008:	037a                	slli	t1,t1,0x1e
    # t0 减去虚实映射偏移量 0xffffffff40000000，变为三级页表的物理地址
    sub     t0, t0, t1
ffffffffc020000a:	406282b3          	sub	t0,t0,t1
    # t0 >>= 12，变为三级页表的物理页号
    srli    t0, t0, 12
ffffffffc020000e:	00c2d293          	srli	t0,t0,0xc

    # t1 := 8 << 60，设置 satp 的 MODE 字段为 Sv39
    li      t1, 8 << 60
ffffffffc0200012:	fff0031b          	addiw	t1,zero,-1
ffffffffc0200016:	137e                	slli	t1,t1,0x3f
    # 将刚才计算出的预设三级页表物理页号附加到 satp 中
    or      t0, t0, t1
ffffffffc0200018:	0062e2b3          	or	t0,t0,t1
    # 将算出的 t0(即新的MODE|页表基址物理页号) 覆盖到 satp 中
    csrw    satp, t0
ffffffffc020001c:	18029073          	csrw	satp,t0
    # 使用 sfence.vma 指令刷新 TLB
    sfence.vma
ffffffffc0200020:	12000073          	sfence.vma
    # 从此，我们给内核搭建出了一个完美的虚拟内存空间！
    #nop # 可能映射的位置有些bug。。插入一个nop
    
    # 我们在虚拟内存空间中：随意将 sp 设置为虚拟地址！
    lui sp, %hi(bootstacktop)
ffffffffc0200024:	c020a137          	lui	sp,0xc020a

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc0200028:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc020002c:	03228293          	addi	t0,t0,50 # ffffffffc0200032 <kern_init>
    jr t0
ffffffffc0200030:	8282                	jr	t0

ffffffffc0200032 <kern_init>:

int kern_init(void) __attribute__((noreturn));
int
kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc0200032:	00048517          	auipc	a0,0x48
ffffffffc0200036:	fa650513          	addi	a0,a0,-90 # ffffffffc0247fd8 <buf>
ffffffffc020003a:	00053617          	auipc	a2,0x53
ffffffffc020003e:	56660613          	addi	a2,a2,1382 # ffffffffc02535a0 <end>
kern_init(void) {
ffffffffc0200042:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc0200044:	8e09                	sub	a2,a2,a0
ffffffffc0200046:	4581                	li	a1,0
kern_init(void) {
ffffffffc0200048:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc020004a:	00f040ef          	jal	ra,ffffffffc0204858 <memset>
    cons_init();                // init the console
ffffffffc020004e:	538000ef          	jal	ra,ffffffffc0200586 <cons_init>

    const char *message = "OS is loading ...";
    cprintf("%s\n\n", message);
ffffffffc0200052:	00005597          	auipc	a1,0x5
ffffffffc0200056:	c3658593          	addi	a1,a1,-970 # ffffffffc0204c88 <etext+0x2>
ffffffffc020005a:	00005517          	auipc	a0,0x5
ffffffffc020005e:	c4650513          	addi	a0,a0,-954 # ffffffffc0204ca0 <etext+0x1a>
ffffffffc0200062:	062000ef          	jal	ra,ffffffffc02000c4 <cprintf>

    pmm_init();                 // init physical memory management
ffffffffc0200066:	758020ef          	jal	ra,ffffffffc02027be <pmm_init>

    idt_init();                 // init interrupt descriptor table
ffffffffc020006a:	59a000ef          	jal	ra,ffffffffc0200604 <idt_init>

    vmm_init();                 // init virtual memory management
ffffffffc020006e:	022010ef          	jal	ra,ffffffffc0201090 <vmm_init>
    sched_init();
ffffffffc0200072:	3d0040ef          	jal	ra,ffffffffc0204442 <sched_init>
    proc_init();                // init process table
ffffffffc0200076:	252040ef          	jal	ra,ffffffffc02042c8 <proc_init>
    
    ide_init();                 // init ide devices
ffffffffc020007a:	49e000ef          	jal	ra,ffffffffc0200518 <ide_init>
    swap_init();                // init swap
ffffffffc020007e:	141010ef          	jal	ra,ffffffffc02019be <swap_init>

    //clock_init();               // init clock interrupt
    intr_enable();              // enable irq interrupt
ffffffffc0200082:	576000ef          	jal	ra,ffffffffc02005f8 <intr_enable>
    
    cpu_idle();                 // run idle process
ffffffffc0200086:	378040ef          	jal	ra,ffffffffc02043fe <cpu_idle>

ffffffffc020008a <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc020008a:	1141                	addi	sp,sp,-16
ffffffffc020008c:	e022                	sd	s0,0(sp)
ffffffffc020008e:	e406                	sd	ra,8(sp)
ffffffffc0200090:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200092:	4f6000ef          	jal	ra,ffffffffc0200588 <cons_putc>
    (*cnt) ++;
ffffffffc0200096:	401c                	lw	a5,0(s0)
}
ffffffffc0200098:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc020009a:	2785                	addiw	a5,a5,1
ffffffffc020009c:	c01c                	sw	a5,0(s0)
}
ffffffffc020009e:	6402                	ld	s0,0(sp)
ffffffffc02000a0:	0141                	addi	sp,sp,16
ffffffffc02000a2:	8082                	ret

ffffffffc02000a4 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000a4:	1101                	addi	sp,sp,-32
ffffffffc02000a6:	862a                	mv	a2,a0
ffffffffc02000a8:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000aa:	00000517          	auipc	a0,0x0
ffffffffc02000ae:	fe050513          	addi	a0,a0,-32 # ffffffffc020008a <cputch>
ffffffffc02000b2:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000b4:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc02000b6:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000b8:	037040ef          	jal	ra,ffffffffc02048ee <vprintfmt>
    return cnt;
}
ffffffffc02000bc:	60e2                	ld	ra,24(sp)
ffffffffc02000be:	4532                	lw	a0,12(sp)
ffffffffc02000c0:	6105                	addi	sp,sp,32
ffffffffc02000c2:	8082                	ret

ffffffffc02000c4 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc02000c4:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc02000c6:	02810313          	addi	t1,sp,40 # ffffffffc020a028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc02000ca:	8e2a                	mv	t3,a0
ffffffffc02000cc:	f42e                	sd	a1,40(sp)
ffffffffc02000ce:	f832                	sd	a2,48(sp)
ffffffffc02000d0:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000d2:	00000517          	auipc	a0,0x0
ffffffffc02000d6:	fb850513          	addi	a0,a0,-72 # ffffffffc020008a <cputch>
ffffffffc02000da:	004c                	addi	a1,sp,4
ffffffffc02000dc:	869a                	mv	a3,t1
ffffffffc02000de:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
ffffffffc02000e0:	ec06                	sd	ra,24(sp)
ffffffffc02000e2:	e0ba                	sd	a4,64(sp)
ffffffffc02000e4:	e4be                	sd	a5,72(sp)
ffffffffc02000e6:	e8c2                	sd	a6,80(sp)
ffffffffc02000e8:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02000ea:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02000ec:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000ee:	001040ef          	jal	ra,ffffffffc02048ee <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02000f2:	60e2                	ld	ra,24(sp)
ffffffffc02000f4:	4512                	lw	a0,4(sp)
ffffffffc02000f6:	6125                	addi	sp,sp,96
ffffffffc02000f8:	8082                	ret

ffffffffc02000fa <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
    cons_putc(c);
ffffffffc02000fa:	a179                	j	ffffffffc0200588 <cons_putc>

ffffffffc02000fc <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc02000fc:	1101                	addi	sp,sp,-32
ffffffffc02000fe:	e822                	sd	s0,16(sp)
ffffffffc0200100:	ec06                	sd	ra,24(sp)
ffffffffc0200102:	e426                	sd	s1,8(sp)
ffffffffc0200104:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc0200106:	00054503          	lbu	a0,0(a0)
ffffffffc020010a:	c51d                	beqz	a0,ffffffffc0200138 <cputs+0x3c>
ffffffffc020010c:	0405                	addi	s0,s0,1
ffffffffc020010e:	4485                	li	s1,1
ffffffffc0200110:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc0200112:	476000ef          	jal	ra,ffffffffc0200588 <cons_putc>
    while ((c = *str ++) != '\0') {
ffffffffc0200116:	00044503          	lbu	a0,0(s0)
ffffffffc020011a:	008487bb          	addw	a5,s1,s0
ffffffffc020011e:	0405                	addi	s0,s0,1
ffffffffc0200120:	f96d                	bnez	a0,ffffffffc0200112 <cputs+0x16>
ffffffffc0200122:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc0200126:	4529                	li	a0,10
ffffffffc0200128:	460000ef          	jal	ra,ffffffffc0200588 <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc020012c:	60e2                	ld	ra,24(sp)
ffffffffc020012e:	8522                	mv	a0,s0
ffffffffc0200130:	6442                	ld	s0,16(sp)
ffffffffc0200132:	64a2                	ld	s1,8(sp)
ffffffffc0200134:	6105                	addi	sp,sp,32
ffffffffc0200136:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc0200138:	4405                	li	s0,1
ffffffffc020013a:	b7f5                	j	ffffffffc0200126 <cputs+0x2a>

ffffffffc020013c <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
ffffffffc020013c:	1141                	addi	sp,sp,-16
ffffffffc020013e:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200140:	47c000ef          	jal	ra,ffffffffc02005bc <cons_getc>
ffffffffc0200144:	dd75                	beqz	a0,ffffffffc0200140 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc0200146:	60a2                	ld	ra,8(sp)
ffffffffc0200148:	0141                	addi	sp,sp,16
ffffffffc020014a:	8082                	ret

ffffffffc020014c <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc020014c:	715d                	addi	sp,sp,-80
ffffffffc020014e:	e486                	sd	ra,72(sp)
ffffffffc0200150:	e0a6                	sd	s1,64(sp)
ffffffffc0200152:	fc4a                	sd	s2,56(sp)
ffffffffc0200154:	f84e                	sd	s3,48(sp)
ffffffffc0200156:	f452                	sd	s4,40(sp)
ffffffffc0200158:	f056                	sd	s5,32(sp)
ffffffffc020015a:	ec5a                	sd	s6,24(sp)
ffffffffc020015c:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc020015e:	c901                	beqz	a0,ffffffffc020016e <readline+0x22>
ffffffffc0200160:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc0200162:	00005517          	auipc	a0,0x5
ffffffffc0200166:	b4650513          	addi	a0,a0,-1210 # ffffffffc0204ca8 <etext+0x22>
ffffffffc020016a:	f5bff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
readline(const char *prompt) {
ffffffffc020016e:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200170:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc0200172:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc0200174:	4aa9                	li	s5,10
ffffffffc0200176:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc0200178:	00048b97          	auipc	s7,0x48
ffffffffc020017c:	e60b8b93          	addi	s7,s7,-416 # ffffffffc0247fd8 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200180:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc0200184:	fb9ff0ef          	jal	ra,ffffffffc020013c <getchar>
        if (c < 0) {
ffffffffc0200188:	00054a63          	bltz	a0,ffffffffc020019c <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc020018c:	00a95a63          	bge	s2,a0,ffffffffc02001a0 <readline+0x54>
ffffffffc0200190:	029a5263          	bge	s4,s1,ffffffffc02001b4 <readline+0x68>
        c = getchar();
ffffffffc0200194:	fa9ff0ef          	jal	ra,ffffffffc020013c <getchar>
        if (c < 0) {
ffffffffc0200198:	fe055ae3          	bgez	a0,ffffffffc020018c <readline+0x40>
            return NULL;
ffffffffc020019c:	4501                	li	a0,0
ffffffffc020019e:	a091                	j	ffffffffc02001e2 <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc02001a0:	03351463          	bne	a0,s3,ffffffffc02001c8 <readline+0x7c>
ffffffffc02001a4:	e8a9                	bnez	s1,ffffffffc02001f6 <readline+0xaa>
        c = getchar();
ffffffffc02001a6:	f97ff0ef          	jal	ra,ffffffffc020013c <getchar>
        if (c < 0) {
ffffffffc02001aa:	fe0549e3          	bltz	a0,ffffffffc020019c <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02001ae:	fea959e3          	bge	s2,a0,ffffffffc02001a0 <readline+0x54>
ffffffffc02001b2:	4481                	li	s1,0
            cputchar(c);
ffffffffc02001b4:	e42a                	sd	a0,8(sp)
ffffffffc02001b6:	f45ff0ef          	jal	ra,ffffffffc02000fa <cputchar>
            buf[i ++] = c;
ffffffffc02001ba:	6522                	ld	a0,8(sp)
ffffffffc02001bc:	009b87b3          	add	a5,s7,s1
ffffffffc02001c0:	2485                	addiw	s1,s1,1
ffffffffc02001c2:	00a78023          	sb	a0,0(a5)
ffffffffc02001c6:	bf7d                	j	ffffffffc0200184 <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc02001c8:	01550463          	beq	a0,s5,ffffffffc02001d0 <readline+0x84>
ffffffffc02001cc:	fb651ce3          	bne	a0,s6,ffffffffc0200184 <readline+0x38>
            cputchar(c);
ffffffffc02001d0:	f2bff0ef          	jal	ra,ffffffffc02000fa <cputchar>
            buf[i] = '\0';
ffffffffc02001d4:	00048517          	auipc	a0,0x48
ffffffffc02001d8:	e0450513          	addi	a0,a0,-508 # ffffffffc0247fd8 <buf>
ffffffffc02001dc:	94aa                	add	s1,s1,a0
ffffffffc02001de:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc02001e2:	60a6                	ld	ra,72(sp)
ffffffffc02001e4:	6486                	ld	s1,64(sp)
ffffffffc02001e6:	7962                	ld	s2,56(sp)
ffffffffc02001e8:	79c2                	ld	s3,48(sp)
ffffffffc02001ea:	7a22                	ld	s4,40(sp)
ffffffffc02001ec:	7a82                	ld	s5,32(sp)
ffffffffc02001ee:	6b62                	ld	s6,24(sp)
ffffffffc02001f0:	6bc2                	ld	s7,16(sp)
ffffffffc02001f2:	6161                	addi	sp,sp,80
ffffffffc02001f4:	8082                	ret
            cputchar(c);
ffffffffc02001f6:	4521                	li	a0,8
ffffffffc02001f8:	f03ff0ef          	jal	ra,ffffffffc02000fa <cputchar>
            i --;
ffffffffc02001fc:	34fd                	addiw	s1,s1,-1
ffffffffc02001fe:	b759                	j	ffffffffc0200184 <readline+0x38>

ffffffffc0200200 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc0200200:	00053317          	auipc	t1,0x53
ffffffffc0200204:	20830313          	addi	t1,t1,520 # ffffffffc0253408 <is_panic>
ffffffffc0200208:	00033e03          	ld	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc020020c:	715d                	addi	sp,sp,-80
ffffffffc020020e:	ec06                	sd	ra,24(sp)
ffffffffc0200210:	e822                	sd	s0,16(sp)
ffffffffc0200212:	f436                	sd	a3,40(sp)
ffffffffc0200214:	f83a                	sd	a4,48(sp)
ffffffffc0200216:	fc3e                	sd	a5,56(sp)
ffffffffc0200218:	e0c2                	sd	a6,64(sp)
ffffffffc020021a:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc020021c:	020e1a63          	bnez	t3,ffffffffc0200250 <__panic+0x50>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc0200220:	4785                	li	a5,1
ffffffffc0200222:	00f33023          	sd	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc0200226:	8432                	mv	s0,a2
ffffffffc0200228:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc020022a:	862e                	mv	a2,a1
ffffffffc020022c:	85aa                	mv	a1,a0
ffffffffc020022e:	00005517          	auipc	a0,0x5
ffffffffc0200232:	a8250513          	addi	a0,a0,-1406 # ffffffffc0204cb0 <etext+0x2a>
    va_start(ap, fmt);
ffffffffc0200236:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200238:	e8dff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    vcprintf(fmt, ap);
ffffffffc020023c:	65a2                	ld	a1,8(sp)
ffffffffc020023e:	8522                	mv	a0,s0
ffffffffc0200240:	e65ff0ef          	jal	ra,ffffffffc02000a4 <vcprintf>
    cprintf("\n");
ffffffffc0200244:	00006517          	auipc	a0,0x6
ffffffffc0200248:	efc50513          	addi	a0,a0,-260 # ffffffffc0206140 <default_pmm_manager+0x208>
ffffffffc020024c:	e79ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
#endif
}

static inline void sbi_shutdown(void)
{
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc0200250:	4501                	li	a0,0
ffffffffc0200252:	4581                	li	a1,0
ffffffffc0200254:	4601                	li	a2,0
ffffffffc0200256:	48a1                	li	a7,8
ffffffffc0200258:	00000073          	ecall
    va_end(ap);

panic_dead:
    // No debug monitor here
    sbi_shutdown();
    intr_disable();
ffffffffc020025c:	3a2000ef          	jal	ra,ffffffffc02005fe <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc0200260:	4501                	li	a0,0
ffffffffc0200262:	174000ef          	jal	ra,ffffffffc02003d6 <kmonitor>
    while (1) {
ffffffffc0200266:	bfed                	j	ffffffffc0200260 <__panic+0x60>

ffffffffc0200268 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200268:	715d                	addi	sp,sp,-80
ffffffffc020026a:	832e                	mv	t1,a1
ffffffffc020026c:	e822                	sd	s0,16(sp)
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020026e:	85aa                	mv	a1,a0
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200270:	8432                	mv	s0,a2
ffffffffc0200272:	fc3e                	sd	a5,56(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200274:	861a                	mv	a2,t1
    va_start(ap, fmt);
ffffffffc0200276:	103c                	addi	a5,sp,40
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200278:	00005517          	auipc	a0,0x5
ffffffffc020027c:	a5850513          	addi	a0,a0,-1448 # ffffffffc0204cd0 <etext+0x4a>
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200280:	ec06                	sd	ra,24(sp)
ffffffffc0200282:	f436                	sd	a3,40(sp)
ffffffffc0200284:	f83a                	sd	a4,48(sp)
ffffffffc0200286:	e0c2                	sd	a6,64(sp)
ffffffffc0200288:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc020028a:	e43e                	sd	a5,8(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020028c:	e39ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200290:	65a2                	ld	a1,8(sp)
ffffffffc0200292:	8522                	mv	a0,s0
ffffffffc0200294:	e11ff0ef          	jal	ra,ffffffffc02000a4 <vcprintf>
    cprintf("\n");
ffffffffc0200298:	00006517          	auipc	a0,0x6
ffffffffc020029c:	ea850513          	addi	a0,a0,-344 # ffffffffc0206140 <default_pmm_manager+0x208>
ffffffffc02002a0:	e25ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    va_end(ap);
}
ffffffffc02002a4:	60e2                	ld	ra,24(sp)
ffffffffc02002a6:	6442                	ld	s0,16(sp)
ffffffffc02002a8:	6161                	addi	sp,sp,80
ffffffffc02002aa:	8082                	ret

ffffffffc02002ac <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc02002ac:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc02002ae:	00005517          	auipc	a0,0x5
ffffffffc02002b2:	a4250513          	addi	a0,a0,-1470 # ffffffffc0204cf0 <etext+0x6a>
void print_kerninfo(void) {
ffffffffc02002b6:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc02002b8:	e0dff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  entry  0x%08x (virtual)\n", kern_init);
ffffffffc02002bc:	00000597          	auipc	a1,0x0
ffffffffc02002c0:	d7658593          	addi	a1,a1,-650 # ffffffffc0200032 <kern_init>
ffffffffc02002c4:	00005517          	auipc	a0,0x5
ffffffffc02002c8:	a4c50513          	addi	a0,a0,-1460 # ffffffffc0204d10 <etext+0x8a>
ffffffffc02002cc:	df9ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  etext  0x%08x (virtual)\n", etext);
ffffffffc02002d0:	00005597          	auipc	a1,0x5
ffffffffc02002d4:	9b658593          	addi	a1,a1,-1610 # ffffffffc0204c86 <etext>
ffffffffc02002d8:	00005517          	auipc	a0,0x5
ffffffffc02002dc:	a5850513          	addi	a0,a0,-1448 # ffffffffc0204d30 <etext+0xaa>
ffffffffc02002e0:	de5ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  edata  0x%08x (virtual)\n", edata);
ffffffffc02002e4:	00048597          	auipc	a1,0x48
ffffffffc02002e8:	cf458593          	addi	a1,a1,-780 # ffffffffc0247fd8 <buf>
ffffffffc02002ec:	00005517          	auipc	a0,0x5
ffffffffc02002f0:	a6450513          	addi	a0,a0,-1436 # ffffffffc0204d50 <etext+0xca>
ffffffffc02002f4:	dd1ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  end    0x%08x (virtual)\n", end);
ffffffffc02002f8:	00053597          	auipc	a1,0x53
ffffffffc02002fc:	2a858593          	addi	a1,a1,680 # ffffffffc02535a0 <end>
ffffffffc0200300:	00005517          	auipc	a0,0x5
ffffffffc0200304:	a7050513          	addi	a0,a0,-1424 # ffffffffc0204d70 <etext+0xea>
ffffffffc0200308:	dbdff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc020030c:	00053597          	auipc	a1,0x53
ffffffffc0200310:	69358593          	addi	a1,a1,1683 # ffffffffc025399f <end+0x3ff>
ffffffffc0200314:	00000797          	auipc	a5,0x0
ffffffffc0200318:	d1e78793          	addi	a5,a5,-738 # ffffffffc0200032 <kern_init>
ffffffffc020031c:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200320:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200324:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200326:	3ff5f593          	andi	a1,a1,1023
ffffffffc020032a:	95be                	add	a1,a1,a5
ffffffffc020032c:	85a9                	srai	a1,a1,0xa
ffffffffc020032e:	00005517          	auipc	a0,0x5
ffffffffc0200332:	a6250513          	addi	a0,a0,-1438 # ffffffffc0204d90 <etext+0x10a>
}
ffffffffc0200336:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200338:	b371                	j	ffffffffc02000c4 <cprintf>

ffffffffc020033a <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc020033a:	1141                	addi	sp,sp,-16
     * and line number, etc.
     *    (3.5) popup a calling stackframe
     *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
     *                   the calling funciton's ebp = ss:[ebp]
     */
    panic("Not Implemented!");
ffffffffc020033c:	00005617          	auipc	a2,0x5
ffffffffc0200340:	a8460613          	addi	a2,a2,-1404 # ffffffffc0204dc0 <etext+0x13a>
ffffffffc0200344:	05b00593          	li	a1,91
ffffffffc0200348:	00005517          	auipc	a0,0x5
ffffffffc020034c:	a9050513          	addi	a0,a0,-1392 # ffffffffc0204dd8 <etext+0x152>
void print_stackframe(void) {
ffffffffc0200350:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc0200352:	eafff0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0200356 <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200356:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200358:	00005617          	auipc	a2,0x5
ffffffffc020035c:	a9860613          	addi	a2,a2,-1384 # ffffffffc0204df0 <etext+0x16a>
ffffffffc0200360:	00005597          	auipc	a1,0x5
ffffffffc0200364:	ab058593          	addi	a1,a1,-1360 # ffffffffc0204e10 <etext+0x18a>
ffffffffc0200368:	00005517          	auipc	a0,0x5
ffffffffc020036c:	ab050513          	addi	a0,a0,-1360 # ffffffffc0204e18 <etext+0x192>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200370:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200372:	d53ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
ffffffffc0200376:	00005617          	auipc	a2,0x5
ffffffffc020037a:	ab260613          	addi	a2,a2,-1358 # ffffffffc0204e28 <etext+0x1a2>
ffffffffc020037e:	00005597          	auipc	a1,0x5
ffffffffc0200382:	ad258593          	addi	a1,a1,-1326 # ffffffffc0204e50 <etext+0x1ca>
ffffffffc0200386:	00005517          	auipc	a0,0x5
ffffffffc020038a:	a9250513          	addi	a0,a0,-1390 # ffffffffc0204e18 <etext+0x192>
ffffffffc020038e:	d37ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
ffffffffc0200392:	00005617          	auipc	a2,0x5
ffffffffc0200396:	ace60613          	addi	a2,a2,-1330 # ffffffffc0204e60 <etext+0x1da>
ffffffffc020039a:	00005597          	auipc	a1,0x5
ffffffffc020039e:	ae658593          	addi	a1,a1,-1306 # ffffffffc0204e80 <etext+0x1fa>
ffffffffc02003a2:	00005517          	auipc	a0,0x5
ffffffffc02003a6:	a7650513          	addi	a0,a0,-1418 # ffffffffc0204e18 <etext+0x192>
ffffffffc02003aa:	d1bff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    }
    return 0;
}
ffffffffc02003ae:	60a2                	ld	ra,8(sp)
ffffffffc02003b0:	4501                	li	a0,0
ffffffffc02003b2:	0141                	addi	sp,sp,16
ffffffffc02003b4:	8082                	ret

ffffffffc02003b6 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc02003b6:	1141                	addi	sp,sp,-16
ffffffffc02003b8:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc02003ba:	ef3ff0ef          	jal	ra,ffffffffc02002ac <print_kerninfo>
    return 0;
}
ffffffffc02003be:	60a2                	ld	ra,8(sp)
ffffffffc02003c0:	4501                	li	a0,0
ffffffffc02003c2:	0141                	addi	sp,sp,16
ffffffffc02003c4:	8082                	ret

ffffffffc02003c6 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc02003c6:	1141                	addi	sp,sp,-16
ffffffffc02003c8:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc02003ca:	f71ff0ef          	jal	ra,ffffffffc020033a <print_stackframe>
    return 0;
}
ffffffffc02003ce:	60a2                	ld	ra,8(sp)
ffffffffc02003d0:	4501                	li	a0,0
ffffffffc02003d2:	0141                	addi	sp,sp,16
ffffffffc02003d4:	8082                	ret

ffffffffc02003d6 <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc02003d6:	7115                	addi	sp,sp,-224
ffffffffc02003d8:	e962                	sd	s8,144(sp)
ffffffffc02003da:	8c2a                	mv	s8,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02003dc:	00005517          	auipc	a0,0x5
ffffffffc02003e0:	ab450513          	addi	a0,a0,-1356 # ffffffffc0204e90 <etext+0x20a>
kmonitor(struct trapframe *tf) {
ffffffffc02003e4:	ed86                	sd	ra,216(sp)
ffffffffc02003e6:	e9a2                	sd	s0,208(sp)
ffffffffc02003e8:	e5a6                	sd	s1,200(sp)
ffffffffc02003ea:	e1ca                	sd	s2,192(sp)
ffffffffc02003ec:	fd4e                	sd	s3,184(sp)
ffffffffc02003ee:	f952                	sd	s4,176(sp)
ffffffffc02003f0:	f556                	sd	s5,168(sp)
ffffffffc02003f2:	f15a                	sd	s6,160(sp)
ffffffffc02003f4:	ed5e                	sd	s7,152(sp)
ffffffffc02003f6:	e566                	sd	s9,136(sp)
ffffffffc02003f8:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02003fa:	ccbff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc02003fe:	00005517          	auipc	a0,0x5
ffffffffc0200402:	aba50513          	addi	a0,a0,-1350 # ffffffffc0204eb8 <etext+0x232>
ffffffffc0200406:	cbfff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    if (tf != NULL) {
ffffffffc020040a:	000c0563          	beqz	s8,ffffffffc0200414 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc020040e:	8562                	mv	a0,s8
ffffffffc0200410:	3dc000ef          	jal	ra,ffffffffc02007ec <print_trapframe>
ffffffffc0200414:	00005c97          	auipc	s9,0x5
ffffffffc0200418:	b14c8c93          	addi	s9,s9,-1260 # ffffffffc0204f28 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc020041c:	00005997          	auipc	s3,0x5
ffffffffc0200420:	ac498993          	addi	s3,s3,-1340 # ffffffffc0204ee0 <etext+0x25a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200424:	00005917          	auipc	s2,0x5
ffffffffc0200428:	ac490913          	addi	s2,s2,-1340 # ffffffffc0204ee8 <etext+0x262>
        if (argc == MAXARGS - 1) {
ffffffffc020042c:	4a3d                	li	s4,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc020042e:	00005b17          	auipc	s6,0x5
ffffffffc0200432:	ac2b0b13          	addi	s6,s6,-1342 # ffffffffc0204ef0 <etext+0x26a>
ffffffffc0200436:	00005a97          	auipc	s5,0x5
ffffffffc020043a:	9daa8a93          	addi	s5,s5,-1574 # ffffffffc0204e10 <etext+0x18a>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc020043e:	4b8d                	li	s7,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc0200440:	854e                	mv	a0,s3
ffffffffc0200442:	d0bff0ef          	jal	ra,ffffffffc020014c <readline>
ffffffffc0200446:	842a                	mv	s0,a0
ffffffffc0200448:	dd65                	beqz	a0,ffffffffc0200440 <kmonitor+0x6a>
ffffffffc020044a:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc020044e:	4481                	li	s1,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200450:	c999                	beqz	a1,ffffffffc0200466 <kmonitor+0x90>
ffffffffc0200452:	854a                	mv	a0,s2
ffffffffc0200454:	3ee040ef          	jal	ra,ffffffffc0204842 <strchr>
ffffffffc0200458:	c925                	beqz	a0,ffffffffc02004c8 <kmonitor+0xf2>
            *buf ++ = '\0';
ffffffffc020045a:	00144583          	lbu	a1,1(s0)
ffffffffc020045e:	00040023          	sb	zero,0(s0)
ffffffffc0200462:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200464:	f5fd                	bnez	a1,ffffffffc0200452 <kmonitor+0x7c>
    if (argc == 0) {
ffffffffc0200466:	dce9                	beqz	s1,ffffffffc0200440 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200468:	6582                	ld	a1,0(sp)
ffffffffc020046a:	00005d17          	auipc	s10,0x5
ffffffffc020046e:	abed0d13          	addi	s10,s10,-1346 # ffffffffc0204f28 <commands>
ffffffffc0200472:	8556                	mv	a0,s5
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200474:	4401                	li	s0,0
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200476:	0d61                	addi	s10,s10,24
ffffffffc0200478:	3ac040ef          	jal	ra,ffffffffc0204824 <strcmp>
ffffffffc020047c:	c919                	beqz	a0,ffffffffc0200492 <kmonitor+0xbc>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc020047e:	2405                	addiw	s0,s0,1
ffffffffc0200480:	09740463          	beq	s0,s7,ffffffffc0200508 <kmonitor+0x132>
ffffffffc0200484:	000d3503          	ld	a0,0(s10)
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200488:	6582                	ld	a1,0(sp)
ffffffffc020048a:	0d61                	addi	s10,s10,24
ffffffffc020048c:	398040ef          	jal	ra,ffffffffc0204824 <strcmp>
ffffffffc0200490:	f57d                	bnez	a0,ffffffffc020047e <kmonitor+0xa8>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc0200492:	00141793          	slli	a5,s0,0x1
ffffffffc0200496:	97a2                	add	a5,a5,s0
ffffffffc0200498:	078e                	slli	a5,a5,0x3
ffffffffc020049a:	97e6                	add	a5,a5,s9
ffffffffc020049c:	6b9c                	ld	a5,16(a5)
ffffffffc020049e:	8662                	mv	a2,s8
ffffffffc02004a0:	002c                	addi	a1,sp,8
ffffffffc02004a2:	fff4851b          	addiw	a0,s1,-1
ffffffffc02004a6:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc02004a8:	f8055ce3          	bgez	a0,ffffffffc0200440 <kmonitor+0x6a>
}
ffffffffc02004ac:	60ee                	ld	ra,216(sp)
ffffffffc02004ae:	644e                	ld	s0,208(sp)
ffffffffc02004b0:	64ae                	ld	s1,200(sp)
ffffffffc02004b2:	690e                	ld	s2,192(sp)
ffffffffc02004b4:	79ea                	ld	s3,184(sp)
ffffffffc02004b6:	7a4a                	ld	s4,176(sp)
ffffffffc02004b8:	7aaa                	ld	s5,168(sp)
ffffffffc02004ba:	7b0a                	ld	s6,160(sp)
ffffffffc02004bc:	6bea                	ld	s7,152(sp)
ffffffffc02004be:	6c4a                	ld	s8,144(sp)
ffffffffc02004c0:	6caa                	ld	s9,136(sp)
ffffffffc02004c2:	6d0a                	ld	s10,128(sp)
ffffffffc02004c4:	612d                	addi	sp,sp,224
ffffffffc02004c6:	8082                	ret
        if (*buf == '\0') {
ffffffffc02004c8:	00044783          	lbu	a5,0(s0)
ffffffffc02004cc:	dfc9                	beqz	a5,ffffffffc0200466 <kmonitor+0x90>
        if (argc == MAXARGS - 1) {
ffffffffc02004ce:	03448863          	beq	s1,s4,ffffffffc02004fe <kmonitor+0x128>
        argv[argc ++] = buf;
ffffffffc02004d2:	00349793          	slli	a5,s1,0x3
ffffffffc02004d6:	0118                	addi	a4,sp,128
ffffffffc02004d8:	97ba                	add	a5,a5,a4
ffffffffc02004da:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004de:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc02004e2:	2485                	addiw	s1,s1,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004e4:	e591                	bnez	a1,ffffffffc02004f0 <kmonitor+0x11a>
ffffffffc02004e6:	b749                	j	ffffffffc0200468 <kmonitor+0x92>
ffffffffc02004e8:	00144583          	lbu	a1,1(s0)
            buf ++;
ffffffffc02004ec:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004ee:	ddad                	beqz	a1,ffffffffc0200468 <kmonitor+0x92>
ffffffffc02004f0:	854a                	mv	a0,s2
ffffffffc02004f2:	350040ef          	jal	ra,ffffffffc0204842 <strchr>
ffffffffc02004f6:	d96d                	beqz	a0,ffffffffc02004e8 <kmonitor+0x112>
ffffffffc02004f8:	00044583          	lbu	a1,0(s0)
ffffffffc02004fc:	bf91                	j	ffffffffc0200450 <kmonitor+0x7a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc02004fe:	45c1                	li	a1,16
ffffffffc0200500:	855a                	mv	a0,s6
ffffffffc0200502:	bc3ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
ffffffffc0200506:	b7f1                	j	ffffffffc02004d2 <kmonitor+0xfc>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc0200508:	6582                	ld	a1,0(sp)
ffffffffc020050a:	00005517          	auipc	a0,0x5
ffffffffc020050e:	a0650513          	addi	a0,a0,-1530 # ffffffffc0204f10 <etext+0x28a>
ffffffffc0200512:	bb3ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    return 0;
ffffffffc0200516:	b72d                	j	ffffffffc0200440 <kmonitor+0x6a>

ffffffffc0200518 <ide_init>:
#include <stdio.h>
#include <string.h>
#include <trap.h>
#include <riscv.h>

void ide_init(void) {}
ffffffffc0200518:	8082                	ret

ffffffffc020051a <ide_device_valid>:

#define MAX_IDE 2
#define MAX_DISK_NSECS 56
static char ide[MAX_DISK_NSECS * SECTSIZE];

bool ide_device_valid(unsigned short ideno) { return ideno < MAX_IDE; }
ffffffffc020051a:	00253513          	sltiu	a0,a0,2
ffffffffc020051e:	8082                	ret

ffffffffc0200520 <ide_device_size>:

size_t ide_device_size(unsigned short ideno) { return MAX_DISK_NSECS; }
ffffffffc0200520:	03800513          	li	a0,56
ffffffffc0200524:	8082                	ret

ffffffffc0200526 <ide_read_secs>:

int ide_read_secs(unsigned short ideno, uint32_t secno, void *dst,
                  size_t nsecs) {
    int iobase = secno * SECTSIZE;
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc0200526:	00048797          	auipc	a5,0x48
ffffffffc020052a:	eb278793          	addi	a5,a5,-334 # ffffffffc02483d8 <ide>
    int iobase = secno * SECTSIZE;
ffffffffc020052e:	0095959b          	slliw	a1,a1,0x9
                  size_t nsecs) {
ffffffffc0200532:	1141                	addi	sp,sp,-16
ffffffffc0200534:	8532                	mv	a0,a2
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc0200536:	95be                	add	a1,a1,a5
ffffffffc0200538:	00969613          	slli	a2,a3,0x9
                  size_t nsecs) {
ffffffffc020053c:	e406                	sd	ra,8(sp)
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc020053e:	32c040ef          	jal	ra,ffffffffc020486a <memcpy>
    return 0;
}
ffffffffc0200542:	60a2                	ld	ra,8(sp)
ffffffffc0200544:	4501                	li	a0,0
ffffffffc0200546:	0141                	addi	sp,sp,16
ffffffffc0200548:	8082                	ret

ffffffffc020054a <ide_write_secs>:

int ide_write_secs(unsigned short ideno, uint32_t secno, const void *src,
                   size_t nsecs) {
    int iobase = secno * SECTSIZE;
ffffffffc020054a:	0095979b          	slliw	a5,a1,0x9
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc020054e:	00048517          	auipc	a0,0x48
ffffffffc0200552:	e8a50513          	addi	a0,a0,-374 # ffffffffc02483d8 <ide>
                   size_t nsecs) {
ffffffffc0200556:	1141                	addi	sp,sp,-16
ffffffffc0200558:	85b2                	mv	a1,a2
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc020055a:	953e                	add	a0,a0,a5
ffffffffc020055c:	00969613          	slli	a2,a3,0x9
                   size_t nsecs) {
ffffffffc0200560:	e406                	sd	ra,8(sp)
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc0200562:	308040ef          	jal	ra,ffffffffc020486a <memcpy>
    return 0;
}
ffffffffc0200566:	60a2                	ld	ra,8(sp)
ffffffffc0200568:	4501                	li	a0,0
ffffffffc020056a:	0141                	addi	sp,sp,16
ffffffffc020056c:	8082                	ret

ffffffffc020056e <clock_set_next_event>:
volatile size_t ticks;

static inline uint64_t get_cycles(void) {
#if __riscv_xlen == 64
    uint64_t n;
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc020056e:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200572:	67e1                	lui	a5,0x18
ffffffffc0200574:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_ex3_out_size+0xd9b0>
ffffffffc0200578:	953e                	add	a0,a0,a5
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
ffffffffc020057a:	4581                	li	a1,0
ffffffffc020057c:	4601                	li	a2,0
ffffffffc020057e:	4881                	li	a7,0
ffffffffc0200580:	00000073          	ecall
ffffffffc0200584:	8082                	ret

ffffffffc0200586 <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc0200586:	8082                	ret

ffffffffc0200588 <cons_putc>:
#include <riscv.h>
#include <assert.h>
#include <atomic.h>

static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0200588:	100027f3          	csrr	a5,sstatus
ffffffffc020058c:	8b89                	andi	a5,a5,2
ffffffffc020058e:	0ff57513          	andi	a0,a0,255
ffffffffc0200592:	e799                	bnez	a5,ffffffffc02005a0 <cons_putc+0x18>
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
ffffffffc0200594:	4581                	li	a1,0
ffffffffc0200596:	4601                	li	a2,0
ffffffffc0200598:	4885                	li	a7,1
ffffffffc020059a:	00000073          	ecall
    }
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
ffffffffc020059e:	8082                	ret

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) {
ffffffffc02005a0:	1101                	addi	sp,sp,-32
ffffffffc02005a2:	ec06                	sd	ra,24(sp)
ffffffffc02005a4:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02005a6:	058000ef          	jal	ra,ffffffffc02005fe <intr_disable>
ffffffffc02005aa:	6522                	ld	a0,8(sp)
ffffffffc02005ac:	4581                	li	a1,0
ffffffffc02005ae:	4601                	li	a2,0
ffffffffc02005b0:	4885                	li	a7,1
ffffffffc02005b2:	00000073          	ecall
    local_intr_save(intr_flag);
    {
        sbi_console_putchar((unsigned char)c);
    }
    local_intr_restore(intr_flag);
}
ffffffffc02005b6:	60e2                	ld	ra,24(sp)
ffffffffc02005b8:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc02005ba:	a83d                	j	ffffffffc02005f8 <intr_enable>

ffffffffc02005bc <cons_getc>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02005bc:	100027f3          	csrr	a5,sstatus
ffffffffc02005c0:	8b89                	andi	a5,a5,2
ffffffffc02005c2:	eb89                	bnez	a5,ffffffffc02005d4 <cons_getc+0x18>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
ffffffffc02005c4:	4501                	li	a0,0
ffffffffc02005c6:	4581                	li	a1,0
ffffffffc02005c8:	4601                	li	a2,0
ffffffffc02005ca:	4889                	li	a7,2
ffffffffc02005cc:	00000073          	ecall
ffffffffc02005d0:	2501                	sext.w	a0,a0
    {
        c = sbi_console_getchar();
    }
    local_intr_restore(intr_flag);
    return c;
}
ffffffffc02005d2:	8082                	ret
int cons_getc(void) {
ffffffffc02005d4:	1101                	addi	sp,sp,-32
ffffffffc02005d6:	ec06                	sd	ra,24(sp)
        intr_disable();
ffffffffc02005d8:	026000ef          	jal	ra,ffffffffc02005fe <intr_disable>
ffffffffc02005dc:	4501                	li	a0,0
ffffffffc02005de:	4581                	li	a1,0
ffffffffc02005e0:	4601                	li	a2,0
ffffffffc02005e2:	4889                	li	a7,2
ffffffffc02005e4:	00000073          	ecall
ffffffffc02005e8:	2501                	sext.w	a0,a0
ffffffffc02005ea:	e42a                	sd	a0,8(sp)
        intr_enable();
ffffffffc02005ec:	00c000ef          	jal	ra,ffffffffc02005f8 <intr_enable>
}
ffffffffc02005f0:	60e2                	ld	ra,24(sp)
ffffffffc02005f2:	6522                	ld	a0,8(sp)
ffffffffc02005f4:	6105                	addi	sp,sp,32
ffffffffc02005f6:	8082                	ret

ffffffffc02005f8 <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc02005f8:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc02005fc:	8082                	ret

ffffffffc02005fe <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc02005fe:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200602:	8082                	ret

ffffffffc0200604 <idt_init>:
void
idt_init(void) {
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc0200604:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc0200608:	00000797          	auipc	a5,0x0
ffffffffc020060c:	62c78793          	addi	a5,a5,1580 # ffffffffc0200c34 <__alltraps>
ffffffffc0200610:	10579073          	csrw	stvec,a5
    /* Allow kernel to access user memory */
    set_csr(sstatus, SSTATUS_SUM);
ffffffffc0200614:	000407b7          	lui	a5,0x40
ffffffffc0200618:	1007a7f3          	csrrs	a5,sstatus,a5
}
ffffffffc020061c:	8082                	ret

ffffffffc020061e <print_regs>:
    cprintf("  tval 0x%08x\n", tf->tval);
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs* gpr) {
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc020061e:	610c                	ld	a1,0(a0)
void print_regs(struct pushregs* gpr) {
ffffffffc0200620:	1141                	addi	sp,sp,-16
ffffffffc0200622:	e022                	sd	s0,0(sp)
ffffffffc0200624:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200626:	00005517          	auipc	a0,0x5
ffffffffc020062a:	94a50513          	addi	a0,a0,-1718 # ffffffffc0204f70 <commands+0x48>
void print_regs(struct pushregs* gpr) {
ffffffffc020062e:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200630:	a95ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc0200634:	640c                	ld	a1,8(s0)
ffffffffc0200636:	00005517          	auipc	a0,0x5
ffffffffc020063a:	95250513          	addi	a0,a0,-1710 # ffffffffc0204f88 <commands+0x60>
ffffffffc020063e:	a87ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc0200642:	680c                	ld	a1,16(s0)
ffffffffc0200644:	00005517          	auipc	a0,0x5
ffffffffc0200648:	95c50513          	addi	a0,a0,-1700 # ffffffffc0204fa0 <commands+0x78>
ffffffffc020064c:	a79ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200650:	6c0c                	ld	a1,24(s0)
ffffffffc0200652:	00005517          	auipc	a0,0x5
ffffffffc0200656:	96650513          	addi	a0,a0,-1690 # ffffffffc0204fb8 <commands+0x90>
ffffffffc020065a:	a6bff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc020065e:	700c                	ld	a1,32(s0)
ffffffffc0200660:	00005517          	auipc	a0,0x5
ffffffffc0200664:	97050513          	addi	a0,a0,-1680 # ffffffffc0204fd0 <commands+0xa8>
ffffffffc0200668:	a5dff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc020066c:	740c                	ld	a1,40(s0)
ffffffffc020066e:	00005517          	auipc	a0,0x5
ffffffffc0200672:	97a50513          	addi	a0,a0,-1670 # ffffffffc0204fe8 <commands+0xc0>
ffffffffc0200676:	a4fff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc020067a:	780c                	ld	a1,48(s0)
ffffffffc020067c:	00005517          	auipc	a0,0x5
ffffffffc0200680:	98450513          	addi	a0,a0,-1660 # ffffffffc0205000 <commands+0xd8>
ffffffffc0200684:	a41ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc0200688:	7c0c                	ld	a1,56(s0)
ffffffffc020068a:	00005517          	auipc	a0,0x5
ffffffffc020068e:	98e50513          	addi	a0,a0,-1650 # ffffffffc0205018 <commands+0xf0>
ffffffffc0200692:	a33ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc0200696:	602c                	ld	a1,64(s0)
ffffffffc0200698:	00005517          	auipc	a0,0x5
ffffffffc020069c:	99850513          	addi	a0,a0,-1640 # ffffffffc0205030 <commands+0x108>
ffffffffc02006a0:	a25ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc02006a4:	642c                	ld	a1,72(s0)
ffffffffc02006a6:	00005517          	auipc	a0,0x5
ffffffffc02006aa:	9a250513          	addi	a0,a0,-1630 # ffffffffc0205048 <commands+0x120>
ffffffffc02006ae:	a17ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc02006b2:	682c                	ld	a1,80(s0)
ffffffffc02006b4:	00005517          	auipc	a0,0x5
ffffffffc02006b8:	9ac50513          	addi	a0,a0,-1620 # ffffffffc0205060 <commands+0x138>
ffffffffc02006bc:	a09ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc02006c0:	6c2c                	ld	a1,88(s0)
ffffffffc02006c2:	00005517          	auipc	a0,0x5
ffffffffc02006c6:	9b650513          	addi	a0,a0,-1610 # ffffffffc0205078 <commands+0x150>
ffffffffc02006ca:	9fbff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc02006ce:	702c                	ld	a1,96(s0)
ffffffffc02006d0:	00005517          	auipc	a0,0x5
ffffffffc02006d4:	9c050513          	addi	a0,a0,-1600 # ffffffffc0205090 <commands+0x168>
ffffffffc02006d8:	9edff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc02006dc:	742c                	ld	a1,104(s0)
ffffffffc02006de:	00005517          	auipc	a0,0x5
ffffffffc02006e2:	9ca50513          	addi	a0,a0,-1590 # ffffffffc02050a8 <commands+0x180>
ffffffffc02006e6:	9dfff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc02006ea:	782c                	ld	a1,112(s0)
ffffffffc02006ec:	00005517          	auipc	a0,0x5
ffffffffc02006f0:	9d450513          	addi	a0,a0,-1580 # ffffffffc02050c0 <commands+0x198>
ffffffffc02006f4:	9d1ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc02006f8:	7c2c                	ld	a1,120(s0)
ffffffffc02006fa:	00005517          	auipc	a0,0x5
ffffffffc02006fe:	9de50513          	addi	a0,a0,-1570 # ffffffffc02050d8 <commands+0x1b0>
ffffffffc0200702:	9c3ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc0200706:	604c                	ld	a1,128(s0)
ffffffffc0200708:	00005517          	auipc	a0,0x5
ffffffffc020070c:	9e850513          	addi	a0,a0,-1560 # ffffffffc02050f0 <commands+0x1c8>
ffffffffc0200710:	9b5ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200714:	644c                	ld	a1,136(s0)
ffffffffc0200716:	00005517          	auipc	a0,0x5
ffffffffc020071a:	9f250513          	addi	a0,a0,-1550 # ffffffffc0205108 <commands+0x1e0>
ffffffffc020071e:	9a7ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200722:	684c                	ld	a1,144(s0)
ffffffffc0200724:	00005517          	auipc	a0,0x5
ffffffffc0200728:	9fc50513          	addi	a0,a0,-1540 # ffffffffc0205120 <commands+0x1f8>
ffffffffc020072c:	999ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200730:	6c4c                	ld	a1,152(s0)
ffffffffc0200732:	00005517          	auipc	a0,0x5
ffffffffc0200736:	a0650513          	addi	a0,a0,-1530 # ffffffffc0205138 <commands+0x210>
ffffffffc020073a:	98bff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc020073e:	704c                	ld	a1,160(s0)
ffffffffc0200740:	00005517          	auipc	a0,0x5
ffffffffc0200744:	a1050513          	addi	a0,a0,-1520 # ffffffffc0205150 <commands+0x228>
ffffffffc0200748:	97dff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc020074c:	744c                	ld	a1,168(s0)
ffffffffc020074e:	00005517          	auipc	a0,0x5
ffffffffc0200752:	a1a50513          	addi	a0,a0,-1510 # ffffffffc0205168 <commands+0x240>
ffffffffc0200756:	96fff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc020075a:	784c                	ld	a1,176(s0)
ffffffffc020075c:	00005517          	auipc	a0,0x5
ffffffffc0200760:	a2450513          	addi	a0,a0,-1500 # ffffffffc0205180 <commands+0x258>
ffffffffc0200764:	961ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc0200768:	7c4c                	ld	a1,184(s0)
ffffffffc020076a:	00005517          	auipc	a0,0x5
ffffffffc020076e:	a2e50513          	addi	a0,a0,-1490 # ffffffffc0205198 <commands+0x270>
ffffffffc0200772:	953ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc0200776:	606c                	ld	a1,192(s0)
ffffffffc0200778:	00005517          	auipc	a0,0x5
ffffffffc020077c:	a3850513          	addi	a0,a0,-1480 # ffffffffc02051b0 <commands+0x288>
ffffffffc0200780:	945ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc0200784:	646c                	ld	a1,200(s0)
ffffffffc0200786:	00005517          	auipc	a0,0x5
ffffffffc020078a:	a4250513          	addi	a0,a0,-1470 # ffffffffc02051c8 <commands+0x2a0>
ffffffffc020078e:	937ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc0200792:	686c                	ld	a1,208(s0)
ffffffffc0200794:	00005517          	auipc	a0,0x5
ffffffffc0200798:	a4c50513          	addi	a0,a0,-1460 # ffffffffc02051e0 <commands+0x2b8>
ffffffffc020079c:	929ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc02007a0:	6c6c                	ld	a1,216(s0)
ffffffffc02007a2:	00005517          	auipc	a0,0x5
ffffffffc02007a6:	a5650513          	addi	a0,a0,-1450 # ffffffffc02051f8 <commands+0x2d0>
ffffffffc02007aa:	91bff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc02007ae:	706c                	ld	a1,224(s0)
ffffffffc02007b0:	00005517          	auipc	a0,0x5
ffffffffc02007b4:	a6050513          	addi	a0,a0,-1440 # ffffffffc0205210 <commands+0x2e8>
ffffffffc02007b8:	90dff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc02007bc:	746c                	ld	a1,232(s0)
ffffffffc02007be:	00005517          	auipc	a0,0x5
ffffffffc02007c2:	a6a50513          	addi	a0,a0,-1430 # ffffffffc0205228 <commands+0x300>
ffffffffc02007c6:	8ffff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc02007ca:	786c                	ld	a1,240(s0)
ffffffffc02007cc:	00005517          	auipc	a0,0x5
ffffffffc02007d0:	a7450513          	addi	a0,a0,-1420 # ffffffffc0205240 <commands+0x318>
ffffffffc02007d4:	8f1ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc02007d8:	7c6c                	ld	a1,248(s0)
}
ffffffffc02007da:	6402                	ld	s0,0(sp)
ffffffffc02007dc:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc02007de:	00005517          	auipc	a0,0x5
ffffffffc02007e2:	a7a50513          	addi	a0,a0,-1414 # ffffffffc0205258 <commands+0x330>
}
ffffffffc02007e6:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc02007e8:	8ddff06f          	j	ffffffffc02000c4 <cprintf>

ffffffffc02007ec <print_trapframe>:
print_trapframe(struct trapframe *tf) {
ffffffffc02007ec:	1141                	addi	sp,sp,-16
ffffffffc02007ee:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc02007f0:	85aa                	mv	a1,a0
print_trapframe(struct trapframe *tf) {
ffffffffc02007f2:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc02007f4:	00005517          	auipc	a0,0x5
ffffffffc02007f8:	a7c50513          	addi	a0,a0,-1412 # ffffffffc0205270 <commands+0x348>
print_trapframe(struct trapframe *tf) {
ffffffffc02007fc:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc02007fe:	8c7ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200802:	8522                	mv	a0,s0
ffffffffc0200804:	e1bff0ef          	jal	ra,ffffffffc020061e <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200808:	10043583          	ld	a1,256(s0)
ffffffffc020080c:	00005517          	auipc	a0,0x5
ffffffffc0200810:	a7c50513          	addi	a0,a0,-1412 # ffffffffc0205288 <commands+0x360>
ffffffffc0200814:	8b1ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200818:	10843583          	ld	a1,264(s0)
ffffffffc020081c:	00005517          	auipc	a0,0x5
ffffffffc0200820:	a8450513          	addi	a0,a0,-1404 # ffffffffc02052a0 <commands+0x378>
ffffffffc0200824:	8a1ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  tval 0x%08x\n", tf->tval);
ffffffffc0200828:	11043583          	ld	a1,272(s0)
ffffffffc020082c:	00005517          	auipc	a0,0x5
ffffffffc0200830:	a8c50513          	addi	a0,a0,-1396 # ffffffffc02052b8 <commands+0x390>
ffffffffc0200834:	891ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200838:	11843583          	ld	a1,280(s0)
}
ffffffffc020083c:	6402                	ld	s0,0(sp)
ffffffffc020083e:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200840:	00005517          	auipc	a0,0x5
ffffffffc0200844:	a8850513          	addi	a0,a0,-1400 # ffffffffc02052c8 <commands+0x3a0>
}
ffffffffc0200848:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc020084a:	87bff06f          	j	ffffffffc02000c4 <cprintf>

ffffffffc020084e <pgfault_handler>:
            trap_in_kernel(tf) ? 'K' : 'U',
            tf->cause == CAUSE_STORE_PAGE_FAULT ? 'W' : 'R');
}

static int
pgfault_handler(struct trapframe *tf) {
ffffffffc020084e:	1101                	addi	sp,sp,-32
ffffffffc0200850:	e426                	sd	s1,8(sp)
    extern struct mm_struct *check_mm_struct;
    if(check_mm_struct !=NULL) { 
ffffffffc0200852:	00053497          	auipc	s1,0x53
ffffffffc0200856:	c2648493          	addi	s1,s1,-986 # ffffffffc0253478 <check_mm_struct>
ffffffffc020085a:	609c                	ld	a5,0(s1)
pgfault_handler(struct trapframe *tf) {
ffffffffc020085c:	e822                	sd	s0,16(sp)
ffffffffc020085e:	ec06                	sd	ra,24(sp)
ffffffffc0200860:	842a                	mv	s0,a0
    if(check_mm_struct !=NULL) { 
ffffffffc0200862:	cbad                	beqz	a5,ffffffffc02008d4 <pgfault_handler+0x86>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200864:	10053783          	ld	a5,256(a0)
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc0200868:	11053583          	ld	a1,272(a0)
ffffffffc020086c:	04b00613          	li	a2,75
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200870:	1007f793          	andi	a5,a5,256
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc0200874:	c7b1                	beqz	a5,ffffffffc02008c0 <pgfault_handler+0x72>
ffffffffc0200876:	11843703          	ld	a4,280(s0)
ffffffffc020087a:	47bd                	li	a5,15
ffffffffc020087c:	05700693          	li	a3,87
ffffffffc0200880:	00f70463          	beq	a4,a5,ffffffffc0200888 <pgfault_handler+0x3a>
ffffffffc0200884:	05200693          	li	a3,82
ffffffffc0200888:	00005517          	auipc	a0,0x5
ffffffffc020088c:	a5850513          	addi	a0,a0,-1448 # ffffffffc02052e0 <commands+0x3b8>
ffffffffc0200890:	835ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            print_pgfault(tf);
        }
    struct mm_struct *mm;
    if (check_mm_struct != NULL) {
ffffffffc0200894:	6088                	ld	a0,0(s1)
ffffffffc0200896:	cd1d                	beqz	a0,ffffffffc02008d4 <pgfault_handler+0x86>
        assert(current == idleproc);
ffffffffc0200898:	00053717          	auipc	a4,0x53
ffffffffc020089c:	ba873703          	ld	a4,-1112(a4) # ffffffffc0253440 <current>
ffffffffc02008a0:	00053797          	auipc	a5,0x53
ffffffffc02008a4:	ba87b783          	ld	a5,-1112(a5) # ffffffffc0253448 <idleproc>
ffffffffc02008a8:	04f71663          	bne	a4,a5,ffffffffc02008f4 <pgfault_handler+0xa6>
            print_pgfault(tf);
            panic("unhandled page fault.\n");
        }
        mm = current->mm;
    }
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008ac:	11043603          	ld	a2,272(s0)
ffffffffc02008b0:	11843583          	ld	a1,280(s0)
}
ffffffffc02008b4:	6442                	ld	s0,16(sp)
ffffffffc02008b6:	60e2                	ld	ra,24(sp)
ffffffffc02008b8:	64a2                	ld	s1,8(sp)
ffffffffc02008ba:	6105                	addi	sp,sp,32
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008bc:	7d60006f          	j	ffffffffc0201092 <do_pgfault>
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc02008c0:	11843703          	ld	a4,280(s0)
ffffffffc02008c4:	47bd                	li	a5,15
ffffffffc02008c6:	05500613          	li	a2,85
ffffffffc02008ca:	05700693          	li	a3,87
ffffffffc02008ce:	faf71be3          	bne	a4,a5,ffffffffc0200884 <pgfault_handler+0x36>
ffffffffc02008d2:	bf5d                	j	ffffffffc0200888 <pgfault_handler+0x3a>
        if (current == NULL) {
ffffffffc02008d4:	00053797          	auipc	a5,0x53
ffffffffc02008d8:	b6c7b783          	ld	a5,-1172(a5) # ffffffffc0253440 <current>
ffffffffc02008dc:	cf85                	beqz	a5,ffffffffc0200914 <pgfault_handler+0xc6>
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008de:	11043603          	ld	a2,272(s0)
ffffffffc02008e2:	11843583          	ld	a1,280(s0)
}
ffffffffc02008e6:	6442                	ld	s0,16(sp)
ffffffffc02008e8:	60e2                	ld	ra,24(sp)
ffffffffc02008ea:	64a2                	ld	s1,8(sp)
        mm = current->mm;
ffffffffc02008ec:	7788                	ld	a0,40(a5)
}
ffffffffc02008ee:	6105                	addi	sp,sp,32
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008f0:	7a20006f          	j	ffffffffc0201092 <do_pgfault>
        assert(current == idleproc);
ffffffffc02008f4:	00005697          	auipc	a3,0x5
ffffffffc02008f8:	a0c68693          	addi	a3,a3,-1524 # ffffffffc0205300 <commands+0x3d8>
ffffffffc02008fc:	00005617          	auipc	a2,0x5
ffffffffc0200900:	a1c60613          	addi	a2,a2,-1508 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0200904:	06800593          	li	a1,104
ffffffffc0200908:	00005517          	auipc	a0,0x5
ffffffffc020090c:	a2850513          	addi	a0,a0,-1496 # ffffffffc0205330 <commands+0x408>
ffffffffc0200910:	8f1ff0ef          	jal	ra,ffffffffc0200200 <__panic>
            print_trapframe(tf);
ffffffffc0200914:	8522                	mv	a0,s0
ffffffffc0200916:	ed7ff0ef          	jal	ra,ffffffffc02007ec <print_trapframe>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc020091a:	10043783          	ld	a5,256(s0)
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc020091e:	11043583          	ld	a1,272(s0)
ffffffffc0200922:	04b00613          	li	a2,75
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200926:	1007f793          	andi	a5,a5,256
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc020092a:	e399                	bnez	a5,ffffffffc0200930 <pgfault_handler+0xe2>
ffffffffc020092c:	05500613          	li	a2,85
ffffffffc0200930:	11843703          	ld	a4,280(s0)
ffffffffc0200934:	47bd                	li	a5,15
ffffffffc0200936:	02f70663          	beq	a4,a5,ffffffffc0200962 <pgfault_handler+0x114>
ffffffffc020093a:	05200693          	li	a3,82
ffffffffc020093e:	00005517          	auipc	a0,0x5
ffffffffc0200942:	9a250513          	addi	a0,a0,-1630 # ffffffffc02052e0 <commands+0x3b8>
ffffffffc0200946:	f7eff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            panic("unhandled page fault.\n");
ffffffffc020094a:	00005617          	auipc	a2,0x5
ffffffffc020094e:	9fe60613          	addi	a2,a2,-1538 # ffffffffc0205348 <commands+0x420>
ffffffffc0200952:	06f00593          	li	a1,111
ffffffffc0200956:	00005517          	auipc	a0,0x5
ffffffffc020095a:	9da50513          	addi	a0,a0,-1574 # ffffffffc0205330 <commands+0x408>
ffffffffc020095e:	8a3ff0ef          	jal	ra,ffffffffc0200200 <__panic>
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc0200962:	05700693          	li	a3,87
ffffffffc0200966:	bfe1                	j	ffffffffc020093e <pgfault_handler+0xf0>

ffffffffc0200968 <interrupt_handler>:

static volatile int in_swap_tick_event = 0;
extern struct mm_struct *check_mm_struct;

void interrupt_handler(struct trapframe *tf) {
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200968:	11853783          	ld	a5,280(a0)
ffffffffc020096c:	472d                	li	a4,11
ffffffffc020096e:	0786                	slli	a5,a5,0x1
ffffffffc0200970:	8385                	srli	a5,a5,0x1
ffffffffc0200972:	06f76d63          	bltu	a4,a5,ffffffffc02009ec <interrupt_handler+0x84>
ffffffffc0200976:	00005717          	auipc	a4,0x5
ffffffffc020097a:	a8a70713          	addi	a4,a4,-1398 # ffffffffc0205400 <commands+0x4d8>
ffffffffc020097e:	078a                	slli	a5,a5,0x2
ffffffffc0200980:	97ba                	add	a5,a5,a4
ffffffffc0200982:	439c                	lw	a5,0(a5)
ffffffffc0200984:	97ba                	add	a5,a5,a4
ffffffffc0200986:	8782                	jr	a5
            break;
        case IRQ_H_SOFT:
            cprintf("Hypervisor software interrupt\n");
            break;
        case IRQ_M_SOFT:
            cprintf("Machine software interrupt\n");
ffffffffc0200988:	00005517          	auipc	a0,0x5
ffffffffc020098c:	a3850513          	addi	a0,a0,-1480 # ffffffffc02053c0 <commands+0x498>
ffffffffc0200990:	f34ff06f          	j	ffffffffc02000c4 <cprintf>
            cprintf("Hypervisor software interrupt\n");
ffffffffc0200994:	00005517          	auipc	a0,0x5
ffffffffc0200998:	a0c50513          	addi	a0,a0,-1524 # ffffffffc02053a0 <commands+0x478>
ffffffffc020099c:	f28ff06f          	j	ffffffffc02000c4 <cprintf>
            cprintf("User software interrupt\n");
ffffffffc02009a0:	00005517          	auipc	a0,0x5
ffffffffc02009a4:	9c050513          	addi	a0,a0,-1600 # ffffffffc0205360 <commands+0x438>
ffffffffc02009a8:	f1cff06f          	j	ffffffffc02000c4 <cprintf>
            cprintf("Supervisor software interrupt\n");
ffffffffc02009ac:	00005517          	auipc	a0,0x5
ffffffffc02009b0:	9d450513          	addi	a0,a0,-1580 # ffffffffc0205380 <commands+0x458>
ffffffffc02009b4:	f10ff06f          	j	ffffffffc02000c4 <cprintf>
void interrupt_handler(struct trapframe *tf) {
ffffffffc02009b8:	1141                	addi	sp,sp,-16
ffffffffc02009ba:	e406                	sd	ra,8(sp)
            break;
        case IRQ_U_TIMER:
            cprintf("User software interrupt\n");
            break;
        case IRQ_S_TIMER:
            clock_set_next_event();
ffffffffc02009bc:	bb3ff0ef          	jal	ra,ffffffffc020056e <clock_set_next_event>
            if (++ticks % TICK_NUM == 0 ) {
ffffffffc02009c0:	00053717          	auipc	a4,0x53
ffffffffc02009c4:	ab070713          	addi	a4,a4,-1360 # ffffffffc0253470 <ticks>
ffffffffc02009c8:	631c                	ld	a5,0(a4)
                //print_ticks()
            }
            if (current){
ffffffffc02009ca:	00053517          	auipc	a0,0x53
ffffffffc02009ce:	a7653503          	ld	a0,-1418(a0) # ffffffffc0253440 <current>
            if (++ticks % TICK_NUM == 0 ) {
ffffffffc02009d2:	0785                	addi	a5,a5,1
ffffffffc02009d4:	e31c                	sd	a5,0(a4)
            if (current){
ffffffffc02009d6:	cd01                	beqz	a0,ffffffffc02009ee <interrupt_handler+0x86>
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc02009d8:	60a2                	ld	ra,8(sp)
ffffffffc02009da:	0141                	addi	sp,sp,16
                sched_class_proc_tick(current); 
ffffffffc02009dc:	23d0306f          	j	ffffffffc0204418 <sched_class_proc_tick>
            cprintf("Supervisor external interrupt\n");
ffffffffc02009e0:	00005517          	auipc	a0,0x5
ffffffffc02009e4:	a0050513          	addi	a0,a0,-1536 # ffffffffc02053e0 <commands+0x4b8>
ffffffffc02009e8:	edcff06f          	j	ffffffffc02000c4 <cprintf>
            print_trapframe(tf);
ffffffffc02009ec:	b501                	j	ffffffffc02007ec <print_trapframe>
}
ffffffffc02009ee:	60a2                	ld	ra,8(sp)
ffffffffc02009f0:	0141                	addi	sp,sp,16
ffffffffc02009f2:	8082                	ret

ffffffffc02009f4 <exception_handler>:

void exception_handler(struct trapframe *tf) {
    int ret;
    switch (tf->cause) {
ffffffffc02009f4:	11853783          	ld	a5,280(a0)
void exception_handler(struct trapframe *tf) {
ffffffffc02009f8:	1101                	addi	sp,sp,-32
ffffffffc02009fa:	e822                	sd	s0,16(sp)
ffffffffc02009fc:	ec06                	sd	ra,24(sp)
ffffffffc02009fe:	e426                	sd	s1,8(sp)
ffffffffc0200a00:	473d                	li	a4,15
ffffffffc0200a02:	842a                	mv	s0,a0
ffffffffc0200a04:	16f76163          	bltu	a4,a5,ffffffffc0200b66 <exception_handler+0x172>
ffffffffc0200a08:	00005717          	auipc	a4,0x5
ffffffffc0200a0c:	bc070713          	addi	a4,a4,-1088 # ffffffffc02055c8 <commands+0x6a0>
ffffffffc0200a10:	078a                	slli	a5,a5,0x2
ffffffffc0200a12:	97ba                	add	a5,a5,a4
ffffffffc0200a14:	439c                	lw	a5,0(a5)
ffffffffc0200a16:	97ba                	add	a5,a5,a4
ffffffffc0200a18:	8782                	jr	a5
            //cprintf("Environment call from U-mode\n");
            tf->epc += 4;
            syscall();
            break;
        case CAUSE_SUPERVISOR_ECALL:
            cprintf("Environment call from S-mode\n");
ffffffffc0200a1a:	00005517          	auipc	a0,0x5
ffffffffc0200a1e:	b0650513          	addi	a0,a0,-1274 # ffffffffc0205520 <commands+0x5f8>
ffffffffc0200a22:	ea2ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            tf->epc += 4;
ffffffffc0200a26:	10843783          	ld	a5,264(s0)
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200a2a:	60e2                	ld	ra,24(sp)
ffffffffc0200a2c:	64a2                	ld	s1,8(sp)
            tf->epc += 4;
ffffffffc0200a2e:	0791                	addi	a5,a5,4
ffffffffc0200a30:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200a34:	6442                	ld	s0,16(sp)
ffffffffc0200a36:	6105                	addi	sp,sp,32
            syscall();
ffffffffc0200a38:	5350306f          	j	ffffffffc020476c <syscall>
            cprintf("Environment call from H-mode\n");
ffffffffc0200a3c:	00005517          	auipc	a0,0x5
ffffffffc0200a40:	b0450513          	addi	a0,a0,-1276 # ffffffffc0205540 <commands+0x618>
}
ffffffffc0200a44:	6442                	ld	s0,16(sp)
ffffffffc0200a46:	60e2                	ld	ra,24(sp)
ffffffffc0200a48:	64a2                	ld	s1,8(sp)
ffffffffc0200a4a:	6105                	addi	sp,sp,32
            cprintf("Instruction access fault\n");
ffffffffc0200a4c:	e78ff06f          	j	ffffffffc02000c4 <cprintf>
            cprintf("Environment call from M-mode\n");
ffffffffc0200a50:	00005517          	auipc	a0,0x5
ffffffffc0200a54:	b1050513          	addi	a0,a0,-1264 # ffffffffc0205560 <commands+0x638>
ffffffffc0200a58:	b7f5                	j	ffffffffc0200a44 <exception_handler+0x50>
            cprintf("Instruction page fault\n");
ffffffffc0200a5a:	00005517          	auipc	a0,0x5
ffffffffc0200a5e:	b2650513          	addi	a0,a0,-1242 # ffffffffc0205580 <commands+0x658>
ffffffffc0200a62:	b7cd                	j	ffffffffc0200a44 <exception_handler+0x50>
            cprintf("Load page fault\n");
ffffffffc0200a64:	00005517          	auipc	a0,0x5
ffffffffc0200a68:	b3450513          	addi	a0,a0,-1228 # ffffffffc0205598 <commands+0x670>
ffffffffc0200a6c:	e58ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200a70:	8522                	mv	a0,s0
ffffffffc0200a72:	dddff0ef          	jal	ra,ffffffffc020084e <pgfault_handler>
ffffffffc0200a76:	84aa                	mv	s1,a0
ffffffffc0200a78:	10051963          	bnez	a0,ffffffffc0200b8a <exception_handler+0x196>
}
ffffffffc0200a7c:	60e2                	ld	ra,24(sp)
ffffffffc0200a7e:	6442                	ld	s0,16(sp)
ffffffffc0200a80:	64a2                	ld	s1,8(sp)
ffffffffc0200a82:	6105                	addi	sp,sp,32
ffffffffc0200a84:	8082                	ret
            cprintf("Store/AMO page fault\n");
ffffffffc0200a86:	00005517          	auipc	a0,0x5
ffffffffc0200a8a:	b2a50513          	addi	a0,a0,-1238 # ffffffffc02055b0 <commands+0x688>
ffffffffc0200a8e:	e36ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200a92:	8522                	mv	a0,s0
ffffffffc0200a94:	dbbff0ef          	jal	ra,ffffffffc020084e <pgfault_handler>
ffffffffc0200a98:	84aa                	mv	s1,a0
ffffffffc0200a9a:	d16d                	beqz	a0,ffffffffc0200a7c <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200a9c:	8522                	mv	a0,s0
ffffffffc0200a9e:	d4fff0ef          	jal	ra,ffffffffc02007ec <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200aa2:	86a6                	mv	a3,s1
ffffffffc0200aa4:	00005617          	auipc	a2,0x5
ffffffffc0200aa8:	a2c60613          	addi	a2,a2,-1492 # ffffffffc02054d0 <commands+0x5a8>
ffffffffc0200aac:	0f100593          	li	a1,241
ffffffffc0200ab0:	00005517          	auipc	a0,0x5
ffffffffc0200ab4:	88050513          	addi	a0,a0,-1920 # ffffffffc0205330 <commands+0x408>
ffffffffc0200ab8:	f48ff0ef          	jal	ra,ffffffffc0200200 <__panic>
            cprintf("Instruction address misaligned\n");
ffffffffc0200abc:	00005517          	auipc	a0,0x5
ffffffffc0200ac0:	97450513          	addi	a0,a0,-1676 # ffffffffc0205430 <commands+0x508>
ffffffffc0200ac4:	b741                	j	ffffffffc0200a44 <exception_handler+0x50>
            cprintf("Instruction access fault\n");
ffffffffc0200ac6:	00005517          	auipc	a0,0x5
ffffffffc0200aca:	98a50513          	addi	a0,a0,-1654 # ffffffffc0205450 <commands+0x528>
ffffffffc0200ace:	bf9d                	j	ffffffffc0200a44 <exception_handler+0x50>
            cprintf("Illegal instruction\n");
ffffffffc0200ad0:	00005517          	auipc	a0,0x5
ffffffffc0200ad4:	9a050513          	addi	a0,a0,-1632 # ffffffffc0205470 <commands+0x548>
ffffffffc0200ad8:	b7b5                	j	ffffffffc0200a44 <exception_handler+0x50>
            cprintf("Breakpoint\n");
ffffffffc0200ada:	00005517          	auipc	a0,0x5
ffffffffc0200ade:	9ae50513          	addi	a0,a0,-1618 # ffffffffc0205488 <commands+0x560>
ffffffffc0200ae2:	de2ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            if(tf->gpr.a7 == 10){
ffffffffc0200ae6:	6458                	ld	a4,136(s0)
ffffffffc0200ae8:	47a9                	li	a5,10
ffffffffc0200aea:	f8f719e3          	bne	a4,a5,ffffffffc0200a7c <exception_handler+0x88>
ffffffffc0200aee:	bf25                	j	ffffffffc0200a26 <exception_handler+0x32>
            cprintf("Load address misaligned\n");
ffffffffc0200af0:	00005517          	auipc	a0,0x5
ffffffffc0200af4:	9a850513          	addi	a0,a0,-1624 # ffffffffc0205498 <commands+0x570>
ffffffffc0200af8:	b7b1                	j	ffffffffc0200a44 <exception_handler+0x50>
            cprintf("Load access fault\n");
ffffffffc0200afa:	00005517          	auipc	a0,0x5
ffffffffc0200afe:	9be50513          	addi	a0,a0,-1602 # ffffffffc02054b8 <commands+0x590>
ffffffffc0200b02:	dc2ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200b06:	8522                	mv	a0,s0
ffffffffc0200b08:	d47ff0ef          	jal	ra,ffffffffc020084e <pgfault_handler>
ffffffffc0200b0c:	84aa                	mv	s1,a0
ffffffffc0200b0e:	d53d                	beqz	a0,ffffffffc0200a7c <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200b10:	8522                	mv	a0,s0
ffffffffc0200b12:	cdbff0ef          	jal	ra,ffffffffc02007ec <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200b16:	86a6                	mv	a3,s1
ffffffffc0200b18:	00005617          	auipc	a2,0x5
ffffffffc0200b1c:	9b860613          	addi	a2,a2,-1608 # ffffffffc02054d0 <commands+0x5a8>
ffffffffc0200b20:	0c600593          	li	a1,198
ffffffffc0200b24:	00005517          	auipc	a0,0x5
ffffffffc0200b28:	80c50513          	addi	a0,a0,-2036 # ffffffffc0205330 <commands+0x408>
ffffffffc0200b2c:	ed4ff0ef          	jal	ra,ffffffffc0200200 <__panic>
            cprintf("Store/AMO access fault\n");
ffffffffc0200b30:	00005517          	auipc	a0,0x5
ffffffffc0200b34:	9d850513          	addi	a0,a0,-1576 # ffffffffc0205508 <commands+0x5e0>
ffffffffc0200b38:	d8cff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200b3c:	8522                	mv	a0,s0
ffffffffc0200b3e:	d11ff0ef          	jal	ra,ffffffffc020084e <pgfault_handler>
ffffffffc0200b42:	84aa                	mv	s1,a0
ffffffffc0200b44:	dd05                	beqz	a0,ffffffffc0200a7c <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200b46:	8522                	mv	a0,s0
ffffffffc0200b48:	ca5ff0ef          	jal	ra,ffffffffc02007ec <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200b4c:	86a6                	mv	a3,s1
ffffffffc0200b4e:	00005617          	auipc	a2,0x5
ffffffffc0200b52:	98260613          	addi	a2,a2,-1662 # ffffffffc02054d0 <commands+0x5a8>
ffffffffc0200b56:	0d000593          	li	a1,208
ffffffffc0200b5a:	00004517          	auipc	a0,0x4
ffffffffc0200b5e:	7d650513          	addi	a0,a0,2006 # ffffffffc0205330 <commands+0x408>
ffffffffc0200b62:	e9eff0ef          	jal	ra,ffffffffc0200200 <__panic>
            print_trapframe(tf);
ffffffffc0200b66:	8522                	mv	a0,s0
}
ffffffffc0200b68:	6442                	ld	s0,16(sp)
ffffffffc0200b6a:	60e2                	ld	ra,24(sp)
ffffffffc0200b6c:	64a2                	ld	s1,8(sp)
ffffffffc0200b6e:	6105                	addi	sp,sp,32
            print_trapframe(tf);
ffffffffc0200b70:	b9b5                	j	ffffffffc02007ec <print_trapframe>
            panic("AMO address misaligned\n");
ffffffffc0200b72:	00005617          	auipc	a2,0x5
ffffffffc0200b76:	97e60613          	addi	a2,a2,-1666 # ffffffffc02054f0 <commands+0x5c8>
ffffffffc0200b7a:	0ca00593          	li	a1,202
ffffffffc0200b7e:	00004517          	auipc	a0,0x4
ffffffffc0200b82:	7b250513          	addi	a0,a0,1970 # ffffffffc0205330 <commands+0x408>
ffffffffc0200b86:	e7aff0ef          	jal	ra,ffffffffc0200200 <__panic>
                print_trapframe(tf);
ffffffffc0200b8a:	8522                	mv	a0,s0
ffffffffc0200b8c:	c61ff0ef          	jal	ra,ffffffffc02007ec <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200b90:	86a6                	mv	a3,s1
ffffffffc0200b92:	00005617          	auipc	a2,0x5
ffffffffc0200b96:	93e60613          	addi	a2,a2,-1730 # ffffffffc02054d0 <commands+0x5a8>
ffffffffc0200b9a:	0ea00593          	li	a1,234
ffffffffc0200b9e:	00004517          	auipc	a0,0x4
ffffffffc0200ba2:	79250513          	addi	a0,a0,1938 # ffffffffc0205330 <commands+0x408>
ffffffffc0200ba6:	e5aff0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0200baa <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
ffffffffc0200baa:	1101                	addi	sp,sp,-32
ffffffffc0200bac:	e822                	sd	s0,16(sp)

    if (current == NULL) {
ffffffffc0200bae:	00053417          	auipc	s0,0x53
ffffffffc0200bb2:	89240413          	addi	s0,s0,-1902 # ffffffffc0253440 <current>
ffffffffc0200bb6:	6018                	ld	a4,0(s0)
trap(struct trapframe *tf) {
ffffffffc0200bb8:	ec06                	sd	ra,24(sp)
ffffffffc0200bba:	e426                	sd	s1,8(sp)
ffffffffc0200bbc:	e04a                	sd	s2,0(sp)
ffffffffc0200bbe:	11853683          	ld	a3,280(a0)
    if (current == NULL) {
ffffffffc0200bc2:	cf1d                	beqz	a4,ffffffffc0200c00 <trap+0x56>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200bc4:	10053483          	ld	s1,256(a0)
        trap_dispatch(tf);
    } else {
        struct trapframe *otf = current->tf;
ffffffffc0200bc8:	0a073903          	ld	s2,160(a4)
        current->tf = tf;
ffffffffc0200bcc:	f348                	sd	a0,160(a4)
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200bce:	1004f493          	andi	s1,s1,256
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200bd2:	0206c463          	bltz	a3,ffffffffc0200bfa <trap+0x50>
        exception_handler(tf);
ffffffffc0200bd6:	e1fff0ef          	jal	ra,ffffffffc02009f4 <exception_handler>

        bool in_kernel = trap_in_kernel(tf);

        trap_dispatch(tf);

        current->tf = otf;
ffffffffc0200bda:	601c                	ld	a5,0(s0)
ffffffffc0200bdc:	0b27b023          	sd	s2,160(a5)
        if (!in_kernel) {
ffffffffc0200be0:	e499                	bnez	s1,ffffffffc0200bee <trap+0x44>
            if (current->flags & PF_EXITING) {
ffffffffc0200be2:	0b07a703          	lw	a4,176(a5)
ffffffffc0200be6:	8b05                	andi	a4,a4,1
ffffffffc0200be8:	e329                	bnez	a4,ffffffffc0200c2a <trap+0x80>
                do_exit(-E_KILLED);
            }
            if (current->need_resched) {
ffffffffc0200bea:	6f9c                	ld	a5,24(a5)
ffffffffc0200bec:	eb85                	bnez	a5,ffffffffc0200c1c <trap+0x72>
                schedule();
            }
        }
    }
}
ffffffffc0200bee:	60e2                	ld	ra,24(sp)
ffffffffc0200bf0:	6442                	ld	s0,16(sp)
ffffffffc0200bf2:	64a2                	ld	s1,8(sp)
ffffffffc0200bf4:	6902                	ld	s2,0(sp)
ffffffffc0200bf6:	6105                	addi	sp,sp,32
ffffffffc0200bf8:	8082                	ret
        interrupt_handler(tf);
ffffffffc0200bfa:	d6fff0ef          	jal	ra,ffffffffc0200968 <interrupt_handler>
ffffffffc0200bfe:	bff1                	j	ffffffffc0200bda <trap+0x30>
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200c00:	0006c863          	bltz	a3,ffffffffc0200c10 <trap+0x66>
}
ffffffffc0200c04:	6442                	ld	s0,16(sp)
ffffffffc0200c06:	60e2                	ld	ra,24(sp)
ffffffffc0200c08:	64a2                	ld	s1,8(sp)
ffffffffc0200c0a:	6902                	ld	s2,0(sp)
ffffffffc0200c0c:	6105                	addi	sp,sp,32
        exception_handler(tf);
ffffffffc0200c0e:	b3dd                	j	ffffffffc02009f4 <exception_handler>
}
ffffffffc0200c10:	6442                	ld	s0,16(sp)
ffffffffc0200c12:	60e2                	ld	ra,24(sp)
ffffffffc0200c14:	64a2                	ld	s1,8(sp)
ffffffffc0200c16:	6902                	ld	s2,0(sp)
ffffffffc0200c18:	6105                	addi	sp,sp,32
        interrupt_handler(tf);
ffffffffc0200c1a:	b3b9                	j	ffffffffc0200968 <interrupt_handler>
}
ffffffffc0200c1c:	6442                	ld	s0,16(sp)
ffffffffc0200c1e:	60e2                	ld	ra,24(sp)
ffffffffc0200c20:	64a2                	ld	s1,8(sp)
ffffffffc0200c22:	6902                	ld	s2,0(sp)
ffffffffc0200c24:	6105                	addi	sp,sp,32
                schedule();
ffffffffc0200c26:	1210306f          	j	ffffffffc0204546 <schedule>
                do_exit(-E_KILLED);
ffffffffc0200c2a:	555d                	li	a0,-9
ffffffffc0200c2c:	51b020ef          	jal	ra,ffffffffc0203946 <do_exit>
ffffffffc0200c30:	601c                	ld	a5,0(s0)
ffffffffc0200c32:	bf65                	j	ffffffffc0200bea <trap+0x40>

ffffffffc0200c34 <__alltraps>:
    LOAD x2, 2*REGBYTES(sp)
    .endm

    .globl __alltraps
__alltraps:
    SAVE_ALL
ffffffffc0200c34:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200c38:	00011463          	bnez	sp,ffffffffc0200c40 <__alltraps+0xc>
ffffffffc0200c3c:	14002173          	csrr	sp,sscratch
ffffffffc0200c40:	712d                	addi	sp,sp,-288
ffffffffc0200c42:	e002                	sd	zero,0(sp)
ffffffffc0200c44:	e406                	sd	ra,8(sp)
ffffffffc0200c46:	ec0e                	sd	gp,24(sp)
ffffffffc0200c48:	f012                	sd	tp,32(sp)
ffffffffc0200c4a:	f416                	sd	t0,40(sp)
ffffffffc0200c4c:	f81a                	sd	t1,48(sp)
ffffffffc0200c4e:	fc1e                	sd	t2,56(sp)
ffffffffc0200c50:	e0a2                	sd	s0,64(sp)
ffffffffc0200c52:	e4a6                	sd	s1,72(sp)
ffffffffc0200c54:	e8aa                	sd	a0,80(sp)
ffffffffc0200c56:	ecae                	sd	a1,88(sp)
ffffffffc0200c58:	f0b2                	sd	a2,96(sp)
ffffffffc0200c5a:	f4b6                	sd	a3,104(sp)
ffffffffc0200c5c:	f8ba                	sd	a4,112(sp)
ffffffffc0200c5e:	fcbe                	sd	a5,120(sp)
ffffffffc0200c60:	e142                	sd	a6,128(sp)
ffffffffc0200c62:	e546                	sd	a7,136(sp)
ffffffffc0200c64:	e94a                	sd	s2,144(sp)
ffffffffc0200c66:	ed4e                	sd	s3,152(sp)
ffffffffc0200c68:	f152                	sd	s4,160(sp)
ffffffffc0200c6a:	f556                	sd	s5,168(sp)
ffffffffc0200c6c:	f95a                	sd	s6,176(sp)
ffffffffc0200c6e:	fd5e                	sd	s7,184(sp)
ffffffffc0200c70:	e1e2                	sd	s8,192(sp)
ffffffffc0200c72:	e5e6                	sd	s9,200(sp)
ffffffffc0200c74:	e9ea                	sd	s10,208(sp)
ffffffffc0200c76:	edee                	sd	s11,216(sp)
ffffffffc0200c78:	f1f2                	sd	t3,224(sp)
ffffffffc0200c7a:	f5f6                	sd	t4,232(sp)
ffffffffc0200c7c:	f9fa                	sd	t5,240(sp)
ffffffffc0200c7e:	fdfe                	sd	t6,248(sp)
ffffffffc0200c80:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200c84:	100024f3          	csrr	s1,sstatus
ffffffffc0200c88:	14102973          	csrr	s2,sepc
ffffffffc0200c8c:	143029f3          	csrr	s3,stval
ffffffffc0200c90:	14202a73          	csrr	s4,scause
ffffffffc0200c94:	e822                	sd	s0,16(sp)
ffffffffc0200c96:	e226                	sd	s1,256(sp)
ffffffffc0200c98:	e64a                	sd	s2,264(sp)
ffffffffc0200c9a:	ea4e                	sd	s3,272(sp)
ffffffffc0200c9c:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200c9e:	850a                	mv	a0,sp
    jal trap
ffffffffc0200ca0:	f0bff0ef          	jal	ra,ffffffffc0200baa <trap>

ffffffffc0200ca4 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200ca4:	6492                	ld	s1,256(sp)
ffffffffc0200ca6:	6932                	ld	s2,264(sp)
ffffffffc0200ca8:	1004f413          	andi	s0,s1,256
ffffffffc0200cac:	e401                	bnez	s0,ffffffffc0200cb4 <__trapret+0x10>
ffffffffc0200cae:	1200                	addi	s0,sp,288
ffffffffc0200cb0:	14041073          	csrw	sscratch,s0
ffffffffc0200cb4:	10049073          	csrw	sstatus,s1
ffffffffc0200cb8:	14191073          	csrw	sepc,s2
ffffffffc0200cbc:	60a2                	ld	ra,8(sp)
ffffffffc0200cbe:	61e2                	ld	gp,24(sp)
ffffffffc0200cc0:	7202                	ld	tp,32(sp)
ffffffffc0200cc2:	72a2                	ld	t0,40(sp)
ffffffffc0200cc4:	7342                	ld	t1,48(sp)
ffffffffc0200cc6:	73e2                	ld	t2,56(sp)
ffffffffc0200cc8:	6406                	ld	s0,64(sp)
ffffffffc0200cca:	64a6                	ld	s1,72(sp)
ffffffffc0200ccc:	6546                	ld	a0,80(sp)
ffffffffc0200cce:	65e6                	ld	a1,88(sp)
ffffffffc0200cd0:	7606                	ld	a2,96(sp)
ffffffffc0200cd2:	76a6                	ld	a3,104(sp)
ffffffffc0200cd4:	7746                	ld	a4,112(sp)
ffffffffc0200cd6:	77e6                	ld	a5,120(sp)
ffffffffc0200cd8:	680a                	ld	a6,128(sp)
ffffffffc0200cda:	68aa                	ld	a7,136(sp)
ffffffffc0200cdc:	694a                	ld	s2,144(sp)
ffffffffc0200cde:	69ea                	ld	s3,152(sp)
ffffffffc0200ce0:	7a0a                	ld	s4,160(sp)
ffffffffc0200ce2:	7aaa                	ld	s5,168(sp)
ffffffffc0200ce4:	7b4a                	ld	s6,176(sp)
ffffffffc0200ce6:	7bea                	ld	s7,184(sp)
ffffffffc0200ce8:	6c0e                	ld	s8,192(sp)
ffffffffc0200cea:	6cae                	ld	s9,200(sp)
ffffffffc0200cec:	6d4e                	ld	s10,208(sp)
ffffffffc0200cee:	6dee                	ld	s11,216(sp)
ffffffffc0200cf0:	7e0e                	ld	t3,224(sp)
ffffffffc0200cf2:	7eae                	ld	t4,232(sp)
ffffffffc0200cf4:	7f4e                	ld	t5,240(sp)
ffffffffc0200cf6:	7fee                	ld	t6,248(sp)
ffffffffc0200cf8:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200cfa:	10200073          	sret

ffffffffc0200cfe <forkrets>:
 
    .globl forkrets
forkrets:
    # set stack to this new process's trapframe
    move sp, a0
ffffffffc0200cfe:	812a                	mv	sp,a0
    j __trapret
ffffffffc0200d00:	b755                	j	ffffffffc0200ca4 <__trapret>

ffffffffc0200d02 <check_vma_overlap.isra.0.part.0>:
}


// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next) {
ffffffffc0200d02:	1141                	addi	sp,sp,-16
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
ffffffffc0200d04:	00005697          	auipc	a3,0x5
ffffffffc0200d08:	90468693          	addi	a3,a3,-1788 # ffffffffc0205608 <commands+0x6e0>
ffffffffc0200d0c:	00004617          	auipc	a2,0x4
ffffffffc0200d10:	60c60613          	addi	a2,a2,1548 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0200d14:	06d00593          	li	a1,109
ffffffffc0200d18:	00005517          	auipc	a0,0x5
ffffffffc0200d1c:	91050513          	addi	a0,a0,-1776 # ffffffffc0205628 <commands+0x700>
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next) {
ffffffffc0200d20:	e406                	sd	ra,8(sp)
    assert(next->vm_start < next->vm_end);
ffffffffc0200d22:	cdeff0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0200d26 <mm_create>:
mm_create(void) {
ffffffffc0200d26:	1141                	addi	sp,sp,-16
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0200d28:	04000513          	li	a0,64
mm_create(void) {
ffffffffc0200d2c:	e022                	sd	s0,0(sp)
ffffffffc0200d2e:	e406                	sd	ra,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0200d30:	2e9000ef          	jal	ra,ffffffffc0201818 <kmalloc>
ffffffffc0200d34:	842a                	mv	s0,a0
    if (mm != NULL) {
ffffffffc0200d36:	c505                	beqz	a0,ffffffffc0200d5e <mm_create+0x38>
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200d38:	e408                	sd	a0,8(s0)
ffffffffc0200d3a:	e008                	sd	a0,0(s0)
        mm->mmap_cache = NULL;
ffffffffc0200d3c:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc0200d40:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc0200d44:	02052023          	sw	zero,32(a0)
        if (swap_init_ok) swap_init_mm(mm);
ffffffffc0200d48:	00052797          	auipc	a5,0x52
ffffffffc0200d4c:	6e07a783          	lw	a5,1760(a5) # ffffffffc0253428 <swap_init_ok>
ffffffffc0200d50:	ef81                	bnez	a5,ffffffffc0200d68 <mm_create+0x42>
        else mm->sm_priv = NULL;
ffffffffc0200d52:	02053423          	sd	zero,40(a0)
    return mm->mm_count;
}

static inline void
set_mm_count(struct mm_struct *mm, int val) {
    mm->mm_count = val;
ffffffffc0200d56:	02042823          	sw	zero,48(s0)

typedef volatile bool lock_t;

static inline void
lock_init(lock_t *lock) {
    *lock = 0;
ffffffffc0200d5a:	02043c23          	sd	zero,56(s0)
}
ffffffffc0200d5e:	60a2                	ld	ra,8(sp)
ffffffffc0200d60:	8522                	mv	a0,s0
ffffffffc0200d62:	6402                	ld	s0,0(sp)
ffffffffc0200d64:	0141                	addi	sp,sp,16
ffffffffc0200d66:	8082                	ret
        if (swap_init_ok) swap_init_mm(mm);
ffffffffc0200d68:	4dd000ef          	jal	ra,ffffffffc0201a44 <swap_init_mm>
ffffffffc0200d6c:	b7ed                	j	ffffffffc0200d56 <mm_create+0x30>

ffffffffc0200d6e <find_vma>:
find_vma(struct mm_struct *mm, uintptr_t addr) {
ffffffffc0200d6e:	86aa                	mv	a3,a0
    if (mm != NULL) {
ffffffffc0200d70:	c505                	beqz	a0,ffffffffc0200d98 <find_vma+0x2a>
        vma = mm->mmap_cache;
ffffffffc0200d72:	6908                	ld	a0,16(a0)
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr)) {
ffffffffc0200d74:	c501                	beqz	a0,ffffffffc0200d7c <find_vma+0xe>
ffffffffc0200d76:	651c                	ld	a5,8(a0)
ffffffffc0200d78:	02f5f263          	bgeu	a1,a5,ffffffffc0200d9c <find_vma+0x2e>
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200d7c:	669c                	ld	a5,8(a3)
                while ((le = list_next(le)) != list) {
ffffffffc0200d7e:	00f68d63          	beq	a3,a5,ffffffffc0200d98 <find_vma+0x2a>
                    if (vma->vm_start<=addr && addr < vma->vm_end) {
ffffffffc0200d82:	fe87b703          	ld	a4,-24(a5)
ffffffffc0200d86:	00e5e663          	bltu	a1,a4,ffffffffc0200d92 <find_vma+0x24>
ffffffffc0200d8a:	ff07b703          	ld	a4,-16(a5)
ffffffffc0200d8e:	00e5ec63          	bltu	a1,a4,ffffffffc0200da6 <find_vma+0x38>
ffffffffc0200d92:	679c                	ld	a5,8(a5)
                while ((le = list_next(le)) != list) {
ffffffffc0200d94:	fef697e3          	bne	a3,a5,ffffffffc0200d82 <find_vma+0x14>
    struct vma_struct *vma = NULL;
ffffffffc0200d98:	4501                	li	a0,0
}
ffffffffc0200d9a:	8082                	ret
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr)) {
ffffffffc0200d9c:	691c                	ld	a5,16(a0)
ffffffffc0200d9e:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0200d7c <find_vma+0xe>
            mm->mmap_cache = vma;
ffffffffc0200da2:	ea88                	sd	a0,16(a3)
ffffffffc0200da4:	8082                	ret
                    vma = le2vma(le, list_link);
ffffffffc0200da6:	fe078513          	addi	a0,a5,-32
            mm->mmap_cache = vma;
ffffffffc0200daa:	ea88                	sd	a0,16(a3)
ffffffffc0200dac:	8082                	ret

ffffffffc0200dae <insert_vma_struct>:


// insert_vma_struct -insert vma in mm's list link
void
insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma) {
    assert(vma->vm_start < vma->vm_end);
ffffffffc0200dae:	6590                	ld	a2,8(a1)
ffffffffc0200db0:	0105b803          	ld	a6,16(a1)
insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma) {
ffffffffc0200db4:	1141                	addi	sp,sp,-16
ffffffffc0200db6:	e406                	sd	ra,8(sp)
ffffffffc0200db8:	87aa                	mv	a5,a0
    assert(vma->vm_start < vma->vm_end);
ffffffffc0200dba:	01066763          	bltu	a2,a6,ffffffffc0200dc8 <insert_vma_struct+0x1a>
ffffffffc0200dbe:	a085                	j	ffffffffc0200e1e <insert_vma_struct+0x70>
    list_entry_t *le_prev = list, *le_next;

        list_entry_t *le = list;
        while ((le = list_next(le)) != list) {
            struct vma_struct *mmap_prev = le2vma(le, list_link);
            if (mmap_prev->vm_start > vma->vm_start) {
ffffffffc0200dc0:	fe87b703          	ld	a4,-24(a5)
ffffffffc0200dc4:	04e66863          	bltu	a2,a4,ffffffffc0200e14 <insert_vma_struct+0x66>
ffffffffc0200dc8:	86be                	mv	a3,a5
ffffffffc0200dca:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list) {
ffffffffc0200dcc:	fef51ae3          	bne	a0,a5,ffffffffc0200dc0 <insert_vma_struct+0x12>
        }

    le_next = list_next(le_prev);

    /* check overlap */
    if (le_prev != list) {
ffffffffc0200dd0:	02a68463          	beq	a3,a0,ffffffffc0200df8 <insert_vma_struct+0x4a>
        check_vma_overlap(le2vma(le_prev, list_link), vma);
ffffffffc0200dd4:	ff06b703          	ld	a4,-16(a3)
    assert(prev->vm_start < prev->vm_end);
ffffffffc0200dd8:	fe86b883          	ld	a7,-24(a3)
ffffffffc0200ddc:	08e8f163          	bgeu	a7,a4,ffffffffc0200e5e <insert_vma_struct+0xb0>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0200de0:	04e66f63          	bltu	a2,a4,ffffffffc0200e3e <insert_vma_struct+0x90>
    }
    if (le_next != list) {
ffffffffc0200de4:	00f50a63          	beq	a0,a5,ffffffffc0200df8 <insert_vma_struct+0x4a>
ffffffffc0200de8:	fe87b703          	ld	a4,-24(a5)
    assert(prev->vm_end <= next->vm_start);
ffffffffc0200dec:	05076963          	bltu	a4,a6,ffffffffc0200e3e <insert_vma_struct+0x90>
    assert(next->vm_start < next->vm_end);
ffffffffc0200df0:	ff07b603          	ld	a2,-16(a5)
ffffffffc0200df4:	02c77363          	bgeu	a4,a2,ffffffffc0200e1a <insert_vma_struct+0x6c>
    }

    vma->vm_mm = mm;
    list_add_after(le_prev, &(vma->list_link));

    mm->map_count ++;
ffffffffc0200df8:	5118                	lw	a4,32(a0)
    vma->vm_mm = mm;
ffffffffc0200dfa:	e188                	sd	a0,0(a1)
    list_add_after(le_prev, &(vma->list_link));
ffffffffc0200dfc:	02058613          	addi	a2,a1,32
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc0200e00:	e390                	sd	a2,0(a5)
ffffffffc0200e02:	e690                	sd	a2,8(a3)
}
ffffffffc0200e04:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc0200e06:	f59c                	sd	a5,40(a1)
    elm->prev = prev;
ffffffffc0200e08:	f194                	sd	a3,32(a1)
    mm->map_count ++;
ffffffffc0200e0a:	0017079b          	addiw	a5,a4,1
ffffffffc0200e0e:	d11c                	sw	a5,32(a0)
}
ffffffffc0200e10:	0141                	addi	sp,sp,16
ffffffffc0200e12:	8082                	ret
    if (le_prev != list) {
ffffffffc0200e14:	fca690e3          	bne	a3,a0,ffffffffc0200dd4 <insert_vma_struct+0x26>
ffffffffc0200e18:	bfd1                	j	ffffffffc0200dec <insert_vma_struct+0x3e>
ffffffffc0200e1a:	ee9ff0ef          	jal	ra,ffffffffc0200d02 <check_vma_overlap.isra.0.part.0>
    assert(vma->vm_start < vma->vm_end);
ffffffffc0200e1e:	00005697          	auipc	a3,0x5
ffffffffc0200e22:	81a68693          	addi	a3,a3,-2022 # ffffffffc0205638 <commands+0x710>
ffffffffc0200e26:	00004617          	auipc	a2,0x4
ffffffffc0200e2a:	4f260613          	addi	a2,a2,1266 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0200e2e:	07400593          	li	a1,116
ffffffffc0200e32:	00004517          	auipc	a0,0x4
ffffffffc0200e36:	7f650513          	addi	a0,a0,2038 # ffffffffc0205628 <commands+0x700>
ffffffffc0200e3a:	bc6ff0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0200e3e:	00005697          	auipc	a3,0x5
ffffffffc0200e42:	83a68693          	addi	a3,a3,-1990 # ffffffffc0205678 <commands+0x750>
ffffffffc0200e46:	00004617          	auipc	a2,0x4
ffffffffc0200e4a:	4d260613          	addi	a2,a2,1234 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0200e4e:	06c00593          	li	a1,108
ffffffffc0200e52:	00004517          	auipc	a0,0x4
ffffffffc0200e56:	7d650513          	addi	a0,a0,2006 # ffffffffc0205628 <commands+0x700>
ffffffffc0200e5a:	ba6ff0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(prev->vm_start < prev->vm_end);
ffffffffc0200e5e:	00004697          	auipc	a3,0x4
ffffffffc0200e62:	7fa68693          	addi	a3,a3,2042 # ffffffffc0205658 <commands+0x730>
ffffffffc0200e66:	00004617          	auipc	a2,0x4
ffffffffc0200e6a:	4b260613          	addi	a2,a2,1202 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0200e6e:	06b00593          	li	a1,107
ffffffffc0200e72:	00004517          	auipc	a0,0x4
ffffffffc0200e76:	7b650513          	addi	a0,a0,1974 # ffffffffc0205628 <commands+0x700>
ffffffffc0200e7a:	b86ff0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0200e7e <mm_destroy>:

// mm_destroy - free mm and mm internal fields
void
mm_destroy(struct mm_struct *mm) {
    assert(mm_count(mm) == 0);
ffffffffc0200e7e:	591c                	lw	a5,48(a0)
mm_destroy(struct mm_struct *mm) {
ffffffffc0200e80:	1141                	addi	sp,sp,-16
ffffffffc0200e82:	e406                	sd	ra,8(sp)
ffffffffc0200e84:	e022                	sd	s0,0(sp)
    assert(mm_count(mm) == 0);
ffffffffc0200e86:	e78d                	bnez	a5,ffffffffc0200eb0 <mm_destroy+0x32>
ffffffffc0200e88:	842a                	mv	s0,a0
    return listelm->next;
ffffffffc0200e8a:	6508                	ld	a0,8(a0)

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list) {
ffffffffc0200e8c:	00a40c63          	beq	s0,a0,ffffffffc0200ea4 <mm_destroy+0x26>
    __list_del(listelm->prev, listelm->next);
ffffffffc0200e90:	6118                	ld	a4,0(a0)
ffffffffc0200e92:	651c                	ld	a5,8(a0)
        list_del(le);
        kfree(le2vma(le, list_link));  //kfree vma        
ffffffffc0200e94:	1501                	addi	a0,a0,-32
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0200e96:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc0200e98:	e398                	sd	a4,0(a5)
ffffffffc0200e9a:	22f000ef          	jal	ra,ffffffffc02018c8 <kfree>
    return listelm->next;
ffffffffc0200e9e:	6408                	ld	a0,8(s0)
    while ((le = list_next(list)) != list) {
ffffffffc0200ea0:	fea418e3          	bne	s0,a0,ffffffffc0200e90 <mm_destroy+0x12>
    }
    kfree(mm); //kfree mm
ffffffffc0200ea4:	8522                	mv	a0,s0
    mm=NULL;
}
ffffffffc0200ea6:	6402                	ld	s0,0(sp)
ffffffffc0200ea8:	60a2                	ld	ra,8(sp)
ffffffffc0200eaa:	0141                	addi	sp,sp,16
    kfree(mm); //kfree mm
ffffffffc0200eac:	21d0006f          	j	ffffffffc02018c8 <kfree>
    assert(mm_count(mm) == 0);
ffffffffc0200eb0:	00004697          	auipc	a3,0x4
ffffffffc0200eb4:	7e868693          	addi	a3,a3,2024 # ffffffffc0205698 <commands+0x770>
ffffffffc0200eb8:	00004617          	auipc	a2,0x4
ffffffffc0200ebc:	46060613          	addi	a2,a2,1120 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0200ec0:	09400593          	li	a1,148
ffffffffc0200ec4:	00004517          	auipc	a0,0x4
ffffffffc0200ec8:	76450513          	addi	a0,a0,1892 # ffffffffc0205628 <commands+0x700>
ffffffffc0200ecc:	b34ff0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0200ed0 <mm_map>:

int
mm_map(struct mm_struct *mm, uintptr_t addr, size_t len, uint32_t vm_flags,
       struct vma_struct **vma_store) {
ffffffffc0200ed0:	7139                	addi	sp,sp,-64
ffffffffc0200ed2:	f822                	sd	s0,48(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0200ed4:	6405                	lui	s0,0x1
ffffffffc0200ed6:	147d                	addi	s0,s0,-1
ffffffffc0200ed8:	77fd                	lui	a5,0xfffff
ffffffffc0200eda:	9622                	add	a2,a2,s0
ffffffffc0200edc:	962e                	add	a2,a2,a1
       struct vma_struct **vma_store) {
ffffffffc0200ede:	f426                	sd	s1,40(sp)
ffffffffc0200ee0:	fc06                	sd	ra,56(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0200ee2:	00f5f4b3          	and	s1,a1,a5
       struct vma_struct **vma_store) {
ffffffffc0200ee6:	f04a                	sd	s2,32(sp)
ffffffffc0200ee8:	ec4e                	sd	s3,24(sp)
ffffffffc0200eea:	e852                	sd	s4,16(sp)
ffffffffc0200eec:	e456                	sd	s5,8(sp)
    if (!USER_ACCESS(start, end)) {
ffffffffc0200eee:	002005b7          	lui	a1,0x200
ffffffffc0200ef2:	00f67433          	and	s0,a2,a5
ffffffffc0200ef6:	06b4e363          	bltu	s1,a1,ffffffffc0200f5c <mm_map+0x8c>
ffffffffc0200efa:	0684f163          	bgeu	s1,s0,ffffffffc0200f5c <mm_map+0x8c>
ffffffffc0200efe:	4785                	li	a5,1
ffffffffc0200f00:	07fe                	slli	a5,a5,0x1f
ffffffffc0200f02:	0487ed63          	bltu	a5,s0,ffffffffc0200f5c <mm_map+0x8c>
ffffffffc0200f06:	89aa                	mv	s3,a0
        return -E_INVAL;
    }

    assert(mm != NULL);
ffffffffc0200f08:	cd21                	beqz	a0,ffffffffc0200f60 <mm_map+0x90>

    int ret = -E_INVAL;

    struct vma_struct *vma;
    if ((vma = find_vma(mm, start)) != NULL && end > vma->vm_start) {
ffffffffc0200f0a:	85a6                	mv	a1,s1
ffffffffc0200f0c:	8ab6                	mv	s5,a3
ffffffffc0200f0e:	8a3a                	mv	s4,a4
ffffffffc0200f10:	e5fff0ef          	jal	ra,ffffffffc0200d6e <find_vma>
ffffffffc0200f14:	c501                	beqz	a0,ffffffffc0200f1c <mm_map+0x4c>
ffffffffc0200f16:	651c                	ld	a5,8(a0)
ffffffffc0200f18:	0487e263          	bltu	a5,s0,ffffffffc0200f5c <mm_map+0x8c>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0200f1c:	03000513          	li	a0,48
ffffffffc0200f20:	0f9000ef          	jal	ra,ffffffffc0201818 <kmalloc>
ffffffffc0200f24:	892a                	mv	s2,a0
        goto out;
    }
    ret = -E_NO_MEM;
ffffffffc0200f26:	5571                	li	a0,-4
    if (vma != NULL) {
ffffffffc0200f28:	02090163          	beqz	s2,ffffffffc0200f4a <mm_map+0x7a>

    if ((vma = vma_create(start, end, vm_flags)) == NULL) {
        goto out;
    }
    insert_vma_struct(mm, vma);
ffffffffc0200f2c:	854e                	mv	a0,s3
        vma->vm_start = vm_start;
ffffffffc0200f2e:	00993423          	sd	s1,8(s2)
        vma->vm_end = vm_end;
ffffffffc0200f32:	00893823          	sd	s0,16(s2)
        vma->vm_flags = vm_flags;
ffffffffc0200f36:	01592c23          	sw	s5,24(s2)
    insert_vma_struct(mm, vma);
ffffffffc0200f3a:	85ca                	mv	a1,s2
ffffffffc0200f3c:	e73ff0ef          	jal	ra,ffffffffc0200dae <insert_vma_struct>
    if (vma_store != NULL) {
        *vma_store = vma;
    }
    ret = 0;
ffffffffc0200f40:	4501                	li	a0,0
    if (vma_store != NULL) {
ffffffffc0200f42:	000a0463          	beqz	s4,ffffffffc0200f4a <mm_map+0x7a>
        *vma_store = vma;
ffffffffc0200f46:	012a3023          	sd	s2,0(s4)

out:
    return ret;
}
ffffffffc0200f4a:	70e2                	ld	ra,56(sp)
ffffffffc0200f4c:	7442                	ld	s0,48(sp)
ffffffffc0200f4e:	74a2                	ld	s1,40(sp)
ffffffffc0200f50:	7902                	ld	s2,32(sp)
ffffffffc0200f52:	69e2                	ld	s3,24(sp)
ffffffffc0200f54:	6a42                	ld	s4,16(sp)
ffffffffc0200f56:	6aa2                	ld	s5,8(sp)
ffffffffc0200f58:	6121                	addi	sp,sp,64
ffffffffc0200f5a:	8082                	ret
        return -E_INVAL;
ffffffffc0200f5c:	5575                	li	a0,-3
ffffffffc0200f5e:	b7f5                	j	ffffffffc0200f4a <mm_map+0x7a>
    assert(mm != NULL);
ffffffffc0200f60:	00004697          	auipc	a3,0x4
ffffffffc0200f64:	75068693          	addi	a3,a3,1872 # ffffffffc02056b0 <commands+0x788>
ffffffffc0200f68:	00004617          	auipc	a2,0x4
ffffffffc0200f6c:	3b060613          	addi	a2,a2,944 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0200f70:	0a700593          	li	a1,167
ffffffffc0200f74:	00004517          	auipc	a0,0x4
ffffffffc0200f78:	6b450513          	addi	a0,a0,1716 # ffffffffc0205628 <commands+0x700>
ffffffffc0200f7c:	a84ff0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0200f80 <dup_mmap>:

int
dup_mmap(struct mm_struct *to, struct mm_struct *from) {
ffffffffc0200f80:	7139                	addi	sp,sp,-64
ffffffffc0200f82:	fc06                	sd	ra,56(sp)
ffffffffc0200f84:	f822                	sd	s0,48(sp)
ffffffffc0200f86:	f426                	sd	s1,40(sp)
ffffffffc0200f88:	f04a                	sd	s2,32(sp)
ffffffffc0200f8a:	ec4e                	sd	s3,24(sp)
ffffffffc0200f8c:	e852                	sd	s4,16(sp)
ffffffffc0200f8e:	e456                	sd	s5,8(sp)
    assert(to != NULL && from != NULL);
ffffffffc0200f90:	c52d                	beqz	a0,ffffffffc0200ffa <dup_mmap+0x7a>
ffffffffc0200f92:	892a                	mv	s2,a0
ffffffffc0200f94:	84ae                	mv	s1,a1
    list_entry_t *list = &(from->mmap_list), *le = list;
ffffffffc0200f96:	842e                	mv	s0,a1
    assert(to != NULL && from != NULL);
ffffffffc0200f98:	e595                	bnez	a1,ffffffffc0200fc4 <dup_mmap+0x44>
ffffffffc0200f9a:	a085                	j	ffffffffc0200ffa <dup_mmap+0x7a>
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
        if (nvma == NULL) {
            return -E_NO_MEM;
        }

        insert_vma_struct(to, nvma);
ffffffffc0200f9c:	854a                	mv	a0,s2
        vma->vm_start = vm_start;
ffffffffc0200f9e:	0155b423          	sd	s5,8(a1) # 200008 <_binary_obj___user_ex3_out_size+0x1f5318>
        vma->vm_end = vm_end;
ffffffffc0200fa2:	0145b823          	sd	s4,16(a1)
        vma->vm_flags = vm_flags;
ffffffffc0200fa6:	0135ac23          	sw	s3,24(a1)
        insert_vma_struct(to, nvma);
ffffffffc0200faa:	e05ff0ef          	jal	ra,ffffffffc0200dae <insert_vma_struct>

        bool share = 0;
        if (copy_range(to->pgdir, from->pgdir, vma->vm_start, vma->vm_end, share) != 0) {
ffffffffc0200fae:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_obj___user_ex1_out_size-0x8958>
ffffffffc0200fb2:	fe843603          	ld	a2,-24(s0)
ffffffffc0200fb6:	6c8c                	ld	a1,24(s1)
ffffffffc0200fb8:	01893503          	ld	a0,24(s2)
ffffffffc0200fbc:	4701                	li	a4,0
ffffffffc0200fbe:	5f9010ef          	jal	ra,ffffffffc0202db6 <copy_range>
ffffffffc0200fc2:	e105                	bnez	a0,ffffffffc0200fe2 <dup_mmap+0x62>
    return listelm->prev;
ffffffffc0200fc4:	6000                	ld	s0,0(s0)
    while ((le = list_prev(le)) != list) {
ffffffffc0200fc6:	02848863          	beq	s1,s0,ffffffffc0200ff6 <dup_mmap+0x76>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0200fca:	03000513          	li	a0,48
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
ffffffffc0200fce:	fe843a83          	ld	s5,-24(s0)
ffffffffc0200fd2:	ff043a03          	ld	s4,-16(s0)
ffffffffc0200fd6:	ff842983          	lw	s3,-8(s0)
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0200fda:	03f000ef          	jal	ra,ffffffffc0201818 <kmalloc>
ffffffffc0200fde:	85aa                	mv	a1,a0
    if (vma != NULL) {
ffffffffc0200fe0:	fd55                	bnez	a0,ffffffffc0200f9c <dup_mmap+0x1c>
            return -E_NO_MEM;
ffffffffc0200fe2:	5571                	li	a0,-4
            return -E_NO_MEM;
        }
    }
    return 0;
}
ffffffffc0200fe4:	70e2                	ld	ra,56(sp)
ffffffffc0200fe6:	7442                	ld	s0,48(sp)
ffffffffc0200fe8:	74a2                	ld	s1,40(sp)
ffffffffc0200fea:	7902                	ld	s2,32(sp)
ffffffffc0200fec:	69e2                	ld	s3,24(sp)
ffffffffc0200fee:	6a42                	ld	s4,16(sp)
ffffffffc0200ff0:	6aa2                	ld	s5,8(sp)
ffffffffc0200ff2:	6121                	addi	sp,sp,64
ffffffffc0200ff4:	8082                	ret
    return 0;
ffffffffc0200ff6:	4501                	li	a0,0
ffffffffc0200ff8:	b7f5                	j	ffffffffc0200fe4 <dup_mmap+0x64>
    assert(to != NULL && from != NULL);
ffffffffc0200ffa:	00004697          	auipc	a3,0x4
ffffffffc0200ffe:	6c668693          	addi	a3,a3,1734 # ffffffffc02056c0 <commands+0x798>
ffffffffc0201002:	00004617          	auipc	a2,0x4
ffffffffc0201006:	31660613          	addi	a2,a2,790 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020100a:	0c000593          	li	a1,192
ffffffffc020100e:	00004517          	auipc	a0,0x4
ffffffffc0201012:	61a50513          	addi	a0,a0,1562 # ffffffffc0205628 <commands+0x700>
ffffffffc0201016:	9eaff0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc020101a <exit_mmap>:

void
exit_mmap(struct mm_struct *mm) {
ffffffffc020101a:	1101                	addi	sp,sp,-32
ffffffffc020101c:	ec06                	sd	ra,24(sp)
ffffffffc020101e:	e822                	sd	s0,16(sp)
ffffffffc0201020:	e426                	sd	s1,8(sp)
ffffffffc0201022:	e04a                	sd	s2,0(sp)
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0201024:	c531                	beqz	a0,ffffffffc0201070 <exit_mmap+0x56>
ffffffffc0201026:	591c                	lw	a5,48(a0)
ffffffffc0201028:	84aa                	mv	s1,a0
ffffffffc020102a:	e3b9                	bnez	a5,ffffffffc0201070 <exit_mmap+0x56>
    return listelm->next;
ffffffffc020102c:	6500                	ld	s0,8(a0)
    pde_t *pgdir = mm->pgdir;
ffffffffc020102e:	01853903          	ld	s2,24(a0)
    list_entry_t *list = &(mm->mmap_list), *le = list;
    while ((le = list_next(le)) != list) {
ffffffffc0201032:	02850663          	beq	a0,s0,ffffffffc020105e <exit_mmap+0x44>
        struct vma_struct *vma = le2vma(le, list_link);
        unmap_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0201036:	ff043603          	ld	a2,-16(s0)
ffffffffc020103a:	fe843583          	ld	a1,-24(s0)
ffffffffc020103e:	854a                	mv	a0,s2
ffffffffc0201040:	2a7010ef          	jal	ra,ffffffffc0202ae6 <unmap_range>
ffffffffc0201044:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list) {
ffffffffc0201046:	fe8498e3          	bne	s1,s0,ffffffffc0201036 <exit_mmap+0x1c>
ffffffffc020104a:	6400                	ld	s0,8(s0)
    }
    while ((le = list_next(le)) != list) {
ffffffffc020104c:	00848c63          	beq	s1,s0,ffffffffc0201064 <exit_mmap+0x4a>
        struct vma_struct *vma = le2vma(le, list_link);
        exit_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0201050:	ff043603          	ld	a2,-16(s0)
ffffffffc0201054:	fe843583          	ld	a1,-24(s0)
ffffffffc0201058:	854a                	mv	a0,s2
ffffffffc020105a:	3a3010ef          	jal	ra,ffffffffc0202bfc <exit_range>
ffffffffc020105e:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list) {
ffffffffc0201060:	fe8498e3          	bne	s1,s0,ffffffffc0201050 <exit_mmap+0x36>
    }
}
ffffffffc0201064:	60e2                	ld	ra,24(sp)
ffffffffc0201066:	6442                	ld	s0,16(sp)
ffffffffc0201068:	64a2                	ld	s1,8(sp)
ffffffffc020106a:	6902                	ld	s2,0(sp)
ffffffffc020106c:	6105                	addi	sp,sp,32
ffffffffc020106e:	8082                	ret
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0201070:	00004697          	auipc	a3,0x4
ffffffffc0201074:	67068693          	addi	a3,a3,1648 # ffffffffc02056e0 <commands+0x7b8>
ffffffffc0201078:	00004617          	auipc	a2,0x4
ffffffffc020107c:	2a060613          	addi	a2,a2,672 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201080:	0d600593          	li	a1,214
ffffffffc0201084:	00004517          	auipc	a0,0x4
ffffffffc0201088:	5a450513          	addi	a0,a0,1444 # ffffffffc0205628 <commands+0x700>
ffffffffc020108c:	974ff0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201090 <vmm_init>:
// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void
vmm_init(void) {
    //check_vmm();
}
ffffffffc0201090:	8082                	ret

ffffffffc0201092 <do_pgfault>:
 *            was a read (0) or write (1).
 *         -- The U/S flag (bit 2) indicates whether the processor was executing at user mode (1)
 *            or supervisor mode (0) at the time of the exception.
 */
int
do_pgfault(struct mm_struct *mm, uint_t error_code, uintptr_t addr) {
ffffffffc0201092:	7139                	addi	sp,sp,-64
    int ret = -E_INVAL;
    //try to find a vma which include addr
    struct vma_struct *vma = find_vma(mm, addr);
ffffffffc0201094:	85b2                	mv	a1,a2
do_pgfault(struct mm_struct *mm, uint_t error_code, uintptr_t addr) {
ffffffffc0201096:	f822                	sd	s0,48(sp)
ffffffffc0201098:	f426                	sd	s1,40(sp)
ffffffffc020109a:	fc06                	sd	ra,56(sp)
ffffffffc020109c:	f04a                	sd	s2,32(sp)
ffffffffc020109e:	ec4e                	sd	s3,24(sp)
ffffffffc02010a0:	8432                	mv	s0,a2
ffffffffc02010a2:	84aa                	mv	s1,a0
    struct vma_struct *vma = find_vma(mm, addr);
ffffffffc02010a4:	ccbff0ef          	jal	ra,ffffffffc0200d6e <find_vma>

    pgfault_num++;
ffffffffc02010a8:	00052797          	auipc	a5,0x52
ffffffffc02010ac:	3687a783          	lw	a5,872(a5) # ffffffffc0253410 <pgfault_num>
ffffffffc02010b0:	2785                	addiw	a5,a5,1
ffffffffc02010b2:	00052717          	auipc	a4,0x52
ffffffffc02010b6:	34f72f23          	sw	a5,862(a4) # ffffffffc0253410 <pgfault_num>
    //If the addr is in the range of a mm's vma?
    if (vma == NULL || vma->vm_start > addr) {
ffffffffc02010ba:	c545                	beqz	a0,ffffffffc0201162 <do_pgfault+0xd0>
ffffffffc02010bc:	651c                	ld	a5,8(a0)
ffffffffc02010be:	0af46263          	bltu	s0,a5,ffffffffc0201162 <do_pgfault+0xd0>
     *    (read  an non_existed addr && addr is readable)
     * THEN
     *    continue process
     */
    uint32_t perm = PTE_U;
    if (vma->vm_flags & VM_WRITE) {
ffffffffc02010c2:	4d1c                	lw	a5,24(a0)
    uint32_t perm = PTE_U;
ffffffffc02010c4:	49c1                	li	s3,16
    if (vma->vm_flags & VM_WRITE) {
ffffffffc02010c6:	8b89                	andi	a5,a5,2
ffffffffc02010c8:	efb1                	bnez	a5,ffffffffc0201124 <do_pgfault+0x92>
        perm |= READ_WRITE;
    }
    addr = ROUNDDOWN(addr, PGSIZE);
ffffffffc02010ca:	75fd                	lui	a1,0xfffff
    *   mm->pgdir : the PDT of these vma
    *
    */
    // try to find a pte, if pte's PT(Page Table) isn't existed, then create a PT.
    // (notice the 3th parameter '1')
    if ((ptep = get_pte(mm->pgdir, addr, 1)) == NULL) {
ffffffffc02010cc:	6c88                	ld	a0,24(s1)
    addr = ROUNDDOWN(addr, PGSIZE);
ffffffffc02010ce:	8c6d                	and	s0,s0,a1
    if ((ptep = get_pte(mm->pgdir, addr, 1)) == NULL) {
ffffffffc02010d0:	4605                	li	a2,1
ffffffffc02010d2:	85a2                	mv	a1,s0
ffffffffc02010d4:	041010ef          	jal	ra,ffffffffc0202914 <get_pte>
ffffffffc02010d8:	c555                	beqz	a0,ffffffffc0201184 <do_pgfault+0xf2>
        cprintf("get_pte in do_pgfault failed\n");
        goto failed;
    }
    
    if (*ptep == 0) { // if the phy addr isn't exist, then alloc a page & map the phy addr with logical addr
ffffffffc02010da:	610c                	ld	a1,0(a0)
ffffffffc02010dc:	c5a5                	beqz	a1,ffffffffc0201144 <do_pgfault+0xb2>
            goto failed;
        }
    }
    else { // if this pte is a swap entry, then load data from disk to a page with phy addr
           // and call page_insert to map the phy addr with logical addr
        if(swap_init_ok) {
ffffffffc02010de:	00052797          	auipc	a5,0x52
ffffffffc02010e2:	34a7a783          	lw	a5,842(a5) # ffffffffc0253428 <swap_init_ok>
ffffffffc02010e6:	c7d9                	beqz	a5,ffffffffc0201174 <do_pgfault+0xe2>
            struct Page *page=NULL;
            if ((ret = swap_in(mm, addr, &page)) != 0) {
ffffffffc02010e8:	0030                	addi	a2,sp,8
ffffffffc02010ea:	85a2                	mv	a1,s0
ffffffffc02010ec:	8526                	mv	a0,s1
            struct Page *page=NULL;
ffffffffc02010ee:	e402                	sd	zero,8(sp)
            if ((ret = swap_in(mm, addr, &page)) != 0) {
ffffffffc02010f0:	285000ef          	jal	ra,ffffffffc0201b74 <swap_in>
ffffffffc02010f4:	892a                	mv	s2,a0
ffffffffc02010f6:	e90d                	bnez	a0,ffffffffc0201128 <do_pgfault+0x96>
                cprintf("swap_in in do_pgfault failed\n");
                goto failed;
            }    
            page_insert(mm->pgdir, page, addr, perm);
ffffffffc02010f8:	65a2                	ld	a1,8(sp)
ffffffffc02010fa:	6c88                	ld	a0,24(s1)
ffffffffc02010fc:	86ce                	mv	a3,s3
ffffffffc02010fe:	8622                	mv	a2,s0
ffffffffc0201100:	3fb010ef          	jal	ra,ffffffffc0202cfa <page_insert>
            swap_map_swappable(mm, addr, page, 1);
ffffffffc0201104:	6622                	ld	a2,8(sp)
ffffffffc0201106:	4685                	li	a3,1
ffffffffc0201108:	85a2                	mv	a1,s0
ffffffffc020110a:	8526                	mv	a0,s1
ffffffffc020110c:	147000ef          	jal	ra,ffffffffc0201a52 <swap_map_swappable>
            page->pra_vaddr = addr;
ffffffffc0201110:	67a2                	ld	a5,8(sp)
ffffffffc0201112:	ff80                	sd	s0,56(a5)
        }
   }
   ret = 0;
failed:
    return ret;
}
ffffffffc0201114:	70e2                	ld	ra,56(sp)
ffffffffc0201116:	7442                	ld	s0,48(sp)
ffffffffc0201118:	74a2                	ld	s1,40(sp)
ffffffffc020111a:	69e2                	ld	s3,24(sp)
ffffffffc020111c:	854a                	mv	a0,s2
ffffffffc020111e:	7902                	ld	s2,32(sp)
ffffffffc0201120:	6121                	addi	sp,sp,64
ffffffffc0201122:	8082                	ret
        perm |= READ_WRITE;
ffffffffc0201124:	49dd                	li	s3,23
ffffffffc0201126:	b755                	j	ffffffffc02010ca <do_pgfault+0x38>
                cprintf("swap_in in do_pgfault failed\n");
ffffffffc0201128:	00004517          	auipc	a0,0x4
ffffffffc020112c:	65050513          	addi	a0,a0,1616 # ffffffffc0205778 <commands+0x850>
ffffffffc0201130:	f95fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
}
ffffffffc0201134:	70e2                	ld	ra,56(sp)
ffffffffc0201136:	7442                	ld	s0,48(sp)
ffffffffc0201138:	74a2                	ld	s1,40(sp)
ffffffffc020113a:	69e2                	ld	s3,24(sp)
ffffffffc020113c:	854a                	mv	a0,s2
ffffffffc020113e:	7902                	ld	s2,32(sp)
ffffffffc0201140:	6121                	addi	sp,sp,64
ffffffffc0201142:	8082                	ret
        if (pgdir_alloc_page(mm->pgdir, addr, perm) == NULL) {
ffffffffc0201144:	6c88                	ld	a0,24(s1)
ffffffffc0201146:	864e                	mv	a2,s3
ffffffffc0201148:	85a2                	mv	a1,s0
ffffffffc020114a:	6a3010ef          	jal	ra,ffffffffc0202fec <pgdir_alloc_page>
   ret = 0;
ffffffffc020114e:	4901                	li	s2,0
        if (pgdir_alloc_page(mm->pgdir, addr, perm) == NULL) {
ffffffffc0201150:	f171                	bnez	a0,ffffffffc0201114 <do_pgfault+0x82>
            cprintf("pgdir_alloc_page in do_pgfault failed\n");
ffffffffc0201152:	00004517          	auipc	a0,0x4
ffffffffc0201156:	5fe50513          	addi	a0,a0,1534 # ffffffffc0205750 <commands+0x828>
ffffffffc020115a:	f6bfe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    ret = -E_NO_MEM;
ffffffffc020115e:	5971                	li	s2,-4
            goto failed;
ffffffffc0201160:	bf55                	j	ffffffffc0201114 <do_pgfault+0x82>
        cprintf("not valid addr %x, and  can not find it in vma\n", addr);
ffffffffc0201162:	85a2                	mv	a1,s0
ffffffffc0201164:	00004517          	auipc	a0,0x4
ffffffffc0201168:	59c50513          	addi	a0,a0,1436 # ffffffffc0205700 <commands+0x7d8>
ffffffffc020116c:	f59fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    int ret = -E_INVAL;
ffffffffc0201170:	5975                	li	s2,-3
        goto failed;
ffffffffc0201172:	b74d                	j	ffffffffc0201114 <do_pgfault+0x82>
            cprintf("no swap_init_ok but ptep is %x, failed\n",*ptep);
ffffffffc0201174:	00004517          	auipc	a0,0x4
ffffffffc0201178:	62450513          	addi	a0,a0,1572 # ffffffffc0205798 <commands+0x870>
ffffffffc020117c:	f49fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    ret = -E_NO_MEM;
ffffffffc0201180:	5971                	li	s2,-4
            goto failed;
ffffffffc0201182:	bf49                	j	ffffffffc0201114 <do_pgfault+0x82>
        cprintf("get_pte in do_pgfault failed\n");
ffffffffc0201184:	00004517          	auipc	a0,0x4
ffffffffc0201188:	5ac50513          	addi	a0,a0,1452 # ffffffffc0205730 <commands+0x808>
ffffffffc020118c:	f39fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    ret = -E_NO_MEM;
ffffffffc0201190:	5971                	li	s2,-4
        goto failed;
ffffffffc0201192:	b749                	j	ffffffffc0201114 <do_pgfault+0x82>

ffffffffc0201194 <user_mem_check>:

bool
user_mem_check(struct mm_struct *mm, uintptr_t addr, size_t len, bool write) {
ffffffffc0201194:	7179                	addi	sp,sp,-48
ffffffffc0201196:	f022                	sd	s0,32(sp)
ffffffffc0201198:	f406                	sd	ra,40(sp)
ffffffffc020119a:	ec26                	sd	s1,24(sp)
ffffffffc020119c:	e84a                	sd	s2,16(sp)
ffffffffc020119e:	e44e                	sd	s3,8(sp)
ffffffffc02011a0:	e052                	sd	s4,0(sp)
ffffffffc02011a2:	842e                	mv	s0,a1
    if (mm != NULL) {
ffffffffc02011a4:	c135                	beqz	a0,ffffffffc0201208 <user_mem_check+0x74>
        if (!USER_ACCESS(addr, addr + len)) {
ffffffffc02011a6:	002007b7          	lui	a5,0x200
ffffffffc02011aa:	04f5e663          	bltu	a1,a5,ffffffffc02011f6 <user_mem_check+0x62>
ffffffffc02011ae:	00c584b3          	add	s1,a1,a2
ffffffffc02011b2:	0495f263          	bgeu	a1,s1,ffffffffc02011f6 <user_mem_check+0x62>
ffffffffc02011b6:	4785                	li	a5,1
ffffffffc02011b8:	07fe                	slli	a5,a5,0x1f
ffffffffc02011ba:	0297ee63          	bltu	a5,s1,ffffffffc02011f6 <user_mem_check+0x62>
ffffffffc02011be:	892a                	mv	s2,a0
ffffffffc02011c0:	89b6                	mv	s3,a3
            }
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
                return 0;
            }
            if (write && (vma->vm_flags & VM_STACK)) {
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc02011c2:	6a05                	lui	s4,0x1
ffffffffc02011c4:	a821                	j	ffffffffc02011dc <user_mem_check+0x48>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc02011c6:	0027f693          	andi	a3,a5,2
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc02011ca:	9752                	add	a4,a4,s4
            if (write && (vma->vm_flags & VM_STACK)) {
ffffffffc02011cc:	8ba1                	andi	a5,a5,8
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc02011ce:	c685                	beqz	a3,ffffffffc02011f6 <user_mem_check+0x62>
            if (write && (vma->vm_flags & VM_STACK)) {
ffffffffc02011d0:	c399                	beqz	a5,ffffffffc02011d6 <user_mem_check+0x42>
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc02011d2:	02e46263          	bltu	s0,a4,ffffffffc02011f6 <user_mem_check+0x62>
                    return 0;
                }
            }
            start = vma->vm_end;
ffffffffc02011d6:	6900                	ld	s0,16(a0)
        while (start < end) {
ffffffffc02011d8:	04947663          	bgeu	s0,s1,ffffffffc0201224 <user_mem_check+0x90>
            if ((vma = find_vma(mm, start)) == NULL || start < vma->vm_start) {
ffffffffc02011dc:	85a2                	mv	a1,s0
ffffffffc02011de:	854a                	mv	a0,s2
ffffffffc02011e0:	b8fff0ef          	jal	ra,ffffffffc0200d6e <find_vma>
ffffffffc02011e4:	c909                	beqz	a0,ffffffffc02011f6 <user_mem_check+0x62>
ffffffffc02011e6:	6518                	ld	a4,8(a0)
ffffffffc02011e8:	00e46763          	bltu	s0,a4,ffffffffc02011f6 <user_mem_check+0x62>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc02011ec:	4d1c                	lw	a5,24(a0)
ffffffffc02011ee:	fc099ce3          	bnez	s3,ffffffffc02011c6 <user_mem_check+0x32>
ffffffffc02011f2:	8b85                	andi	a5,a5,1
ffffffffc02011f4:	f3ed                	bnez	a5,ffffffffc02011d6 <user_mem_check+0x42>
            return 0;
ffffffffc02011f6:	4501                	li	a0,0
        }
        return 1;
    }
    return KERN_ACCESS(addr, addr + len);
}
ffffffffc02011f8:	70a2                	ld	ra,40(sp)
ffffffffc02011fa:	7402                	ld	s0,32(sp)
ffffffffc02011fc:	64e2                	ld	s1,24(sp)
ffffffffc02011fe:	6942                	ld	s2,16(sp)
ffffffffc0201200:	69a2                	ld	s3,8(sp)
ffffffffc0201202:	6a02                	ld	s4,0(sp)
ffffffffc0201204:	6145                	addi	sp,sp,48
ffffffffc0201206:	8082                	ret
    return KERN_ACCESS(addr, addr + len);
ffffffffc0201208:	c02007b7          	lui	a5,0xc0200
ffffffffc020120c:	4501                	li	a0,0
ffffffffc020120e:	fef5e5e3          	bltu	a1,a5,ffffffffc02011f8 <user_mem_check+0x64>
ffffffffc0201212:	962e                	add	a2,a2,a1
ffffffffc0201214:	fec5f2e3          	bgeu	a1,a2,ffffffffc02011f8 <user_mem_check+0x64>
ffffffffc0201218:	c8000537          	lui	a0,0xc8000
ffffffffc020121c:	0505                	addi	a0,a0,1
ffffffffc020121e:	00a63533          	sltu	a0,a2,a0
ffffffffc0201222:	bfd9                	j	ffffffffc02011f8 <user_mem_check+0x64>
        return 1;
ffffffffc0201224:	4505                	li	a0,1
ffffffffc0201226:	bfc9                	j	ffffffffc02011f8 <user_mem_check+0x64>

ffffffffc0201228 <_fifo_init_mm>:
    elm->prev = elm->next = elm;
ffffffffc0201228:	00052797          	auipc	a5,0x52
ffffffffc020122c:	25878793          	addi	a5,a5,600 # ffffffffc0253480 <pra_list_head>
 */
static int
_fifo_init_mm(struct mm_struct *mm)
{     
     list_init(&pra_list_head);
     mm->sm_priv = &pra_list_head;
ffffffffc0201230:	f51c                	sd	a5,40(a0)
ffffffffc0201232:	e79c                	sd	a5,8(a5)
ffffffffc0201234:	e39c                	sd	a5,0(a5)
     //cprintf(" mm->sm_priv %x in fifo_init_mm\n",mm->sm_priv);
     return 0;
}
ffffffffc0201236:	4501                	li	a0,0
ffffffffc0201238:	8082                	ret

ffffffffc020123a <_fifo_init>:

static int
_fifo_init(void)
{
    return 0;
}
ffffffffc020123a:	4501                	li	a0,0
ffffffffc020123c:	8082                	ret

ffffffffc020123e <_fifo_set_unswappable>:

static int
_fifo_set_unswappable(struct mm_struct *mm, uintptr_t addr)
{
    return 0;
}
ffffffffc020123e:	4501                	li	a0,0
ffffffffc0201240:	8082                	ret

ffffffffc0201242 <_fifo_tick_event>:

static int
_fifo_tick_event(struct mm_struct *mm)
{ return 0; }
ffffffffc0201242:	4501                	li	a0,0
ffffffffc0201244:	8082                	ret

ffffffffc0201246 <_fifo_check_swap>:
_fifo_check_swap(void) {
ffffffffc0201246:	711d                	addi	sp,sp,-96
ffffffffc0201248:	fc4e                	sd	s3,56(sp)
ffffffffc020124a:	f852                	sd	s4,48(sp)
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc020124c:	00004517          	auipc	a0,0x4
ffffffffc0201250:	57450513          	addi	a0,a0,1396 # ffffffffc02057c0 <commands+0x898>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc0201254:	698d                	lui	s3,0x3
ffffffffc0201256:	4a31                	li	s4,12
_fifo_check_swap(void) {
ffffffffc0201258:	e0ca                	sd	s2,64(sp)
ffffffffc020125a:	ec86                	sd	ra,88(sp)
ffffffffc020125c:	e8a2                	sd	s0,80(sp)
ffffffffc020125e:	e4a6                	sd	s1,72(sp)
ffffffffc0201260:	f456                	sd	s5,40(sp)
ffffffffc0201262:	f05a                	sd	s6,32(sp)
ffffffffc0201264:	ec5e                	sd	s7,24(sp)
ffffffffc0201266:	e862                	sd	s8,16(sp)
ffffffffc0201268:	e466                	sd	s9,8(sp)
ffffffffc020126a:	e06a                	sd	s10,0(sp)
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc020126c:	e59fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc0201270:	01498023          	sb	s4,0(s3) # 3000 <_binary_obj___user_ex1_out_size-0x6948>
    assert(pgfault_num==4);
ffffffffc0201274:	00052917          	auipc	s2,0x52
ffffffffc0201278:	19c92903          	lw	s2,412(s2) # ffffffffc0253410 <pgfault_num>
ffffffffc020127c:	4791                	li	a5,4
ffffffffc020127e:	14f91e63          	bne	s2,a5,ffffffffc02013da <_fifo_check_swap+0x194>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc0201282:	00004517          	auipc	a0,0x4
ffffffffc0201286:	58e50513          	addi	a0,a0,1422 # ffffffffc0205810 <commands+0x8e8>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc020128a:	6a85                	lui	s5,0x1
ffffffffc020128c:	4b29                	li	s6,10
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc020128e:	e37fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
ffffffffc0201292:	00052417          	auipc	s0,0x52
ffffffffc0201296:	17e40413          	addi	s0,s0,382 # ffffffffc0253410 <pgfault_num>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc020129a:	016a8023          	sb	s6,0(s5) # 1000 <_binary_obj___user_ex1_out_size-0x8948>
    assert(pgfault_num==4);
ffffffffc020129e:	4004                	lw	s1,0(s0)
ffffffffc02012a0:	2481                	sext.w	s1,s1
ffffffffc02012a2:	2b249c63          	bne	s1,s2,ffffffffc020155a <_fifo_check_swap+0x314>
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc02012a6:	00004517          	auipc	a0,0x4
ffffffffc02012aa:	59250513          	addi	a0,a0,1426 # ffffffffc0205838 <commands+0x910>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc02012ae:	6b91                	lui	s7,0x4
ffffffffc02012b0:	4c35                	li	s8,13
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc02012b2:	e13fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc02012b6:	018b8023          	sb	s8,0(s7) # 4000 <_binary_obj___user_ex1_out_size-0x5948>
    assert(pgfault_num==4);
ffffffffc02012ba:	00042903          	lw	s2,0(s0)
ffffffffc02012be:	2901                	sext.w	s2,s2
ffffffffc02012c0:	26991d63          	bne	s2,s1,ffffffffc020153a <_fifo_check_swap+0x2f4>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc02012c4:	00004517          	auipc	a0,0x4
ffffffffc02012c8:	59c50513          	addi	a0,a0,1436 # ffffffffc0205860 <commands+0x938>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc02012cc:	6c89                	lui	s9,0x2
ffffffffc02012ce:	4d2d                	li	s10,11
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc02012d0:	df5fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc02012d4:	01ac8023          	sb	s10,0(s9) # 2000 <_binary_obj___user_ex1_out_size-0x7948>
    assert(pgfault_num==4);
ffffffffc02012d8:	401c                	lw	a5,0(s0)
ffffffffc02012da:	2781                	sext.w	a5,a5
ffffffffc02012dc:	23279f63          	bne	a5,s2,ffffffffc020151a <_fifo_check_swap+0x2d4>
    cprintf("write Virt Page e in fifo_check_swap\n");
ffffffffc02012e0:	00004517          	auipc	a0,0x4
ffffffffc02012e4:	5a850513          	addi	a0,a0,1448 # ffffffffc0205888 <commands+0x960>
ffffffffc02012e8:	dddfe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x5000 = 0x0e;
ffffffffc02012ec:	6795                	lui	a5,0x5
ffffffffc02012ee:	4739                	li	a4,14
ffffffffc02012f0:	00e78023          	sb	a4,0(a5) # 5000 <_binary_obj___user_ex1_out_size-0x4948>
    assert(pgfault_num==5);
ffffffffc02012f4:	4004                	lw	s1,0(s0)
ffffffffc02012f6:	4795                	li	a5,5
ffffffffc02012f8:	2481                	sext.w	s1,s1
ffffffffc02012fa:	20f49063          	bne	s1,a5,ffffffffc02014fa <_fifo_check_swap+0x2b4>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc02012fe:	00004517          	auipc	a0,0x4
ffffffffc0201302:	56250513          	addi	a0,a0,1378 # ffffffffc0205860 <commands+0x938>
ffffffffc0201306:	dbffe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc020130a:	01ac8023          	sb	s10,0(s9)
    assert(pgfault_num==5);
ffffffffc020130e:	401c                	lw	a5,0(s0)
ffffffffc0201310:	2781                	sext.w	a5,a5
ffffffffc0201312:	1c979463          	bne	a5,s1,ffffffffc02014da <_fifo_check_swap+0x294>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc0201316:	00004517          	auipc	a0,0x4
ffffffffc020131a:	4fa50513          	addi	a0,a0,1274 # ffffffffc0205810 <commands+0x8e8>
ffffffffc020131e:	da7fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc0201322:	016a8023          	sb	s6,0(s5)
    assert(pgfault_num==6);
ffffffffc0201326:	401c                	lw	a5,0(s0)
ffffffffc0201328:	4719                	li	a4,6
ffffffffc020132a:	2781                	sext.w	a5,a5
ffffffffc020132c:	18e79763          	bne	a5,a4,ffffffffc02014ba <_fifo_check_swap+0x274>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc0201330:	00004517          	auipc	a0,0x4
ffffffffc0201334:	53050513          	addi	a0,a0,1328 # ffffffffc0205860 <commands+0x938>
ffffffffc0201338:	d8dfe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc020133c:	01ac8023          	sb	s10,0(s9)
    assert(pgfault_num==7);
ffffffffc0201340:	401c                	lw	a5,0(s0)
ffffffffc0201342:	471d                	li	a4,7
ffffffffc0201344:	2781                	sext.w	a5,a5
ffffffffc0201346:	14e79a63          	bne	a5,a4,ffffffffc020149a <_fifo_check_swap+0x254>
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc020134a:	00004517          	auipc	a0,0x4
ffffffffc020134e:	47650513          	addi	a0,a0,1142 # ffffffffc02057c0 <commands+0x898>
ffffffffc0201352:	d73fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc0201356:	01498023          	sb	s4,0(s3)
    assert(pgfault_num==8);
ffffffffc020135a:	401c                	lw	a5,0(s0)
ffffffffc020135c:	4721                	li	a4,8
ffffffffc020135e:	2781                	sext.w	a5,a5
ffffffffc0201360:	10e79d63          	bne	a5,a4,ffffffffc020147a <_fifo_check_swap+0x234>
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc0201364:	00004517          	auipc	a0,0x4
ffffffffc0201368:	4d450513          	addi	a0,a0,1236 # ffffffffc0205838 <commands+0x910>
ffffffffc020136c:	d59fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc0201370:	018b8023          	sb	s8,0(s7)
    assert(pgfault_num==9);
ffffffffc0201374:	401c                	lw	a5,0(s0)
ffffffffc0201376:	4725                	li	a4,9
ffffffffc0201378:	2781                	sext.w	a5,a5
ffffffffc020137a:	0ee79063          	bne	a5,a4,ffffffffc020145a <_fifo_check_swap+0x214>
    cprintf("write Virt Page e in fifo_check_swap\n");
ffffffffc020137e:	00004517          	auipc	a0,0x4
ffffffffc0201382:	50a50513          	addi	a0,a0,1290 # ffffffffc0205888 <commands+0x960>
ffffffffc0201386:	d3ffe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x5000 = 0x0e;
ffffffffc020138a:	6795                	lui	a5,0x5
ffffffffc020138c:	4739                	li	a4,14
ffffffffc020138e:	00e78023          	sb	a4,0(a5) # 5000 <_binary_obj___user_ex1_out_size-0x4948>
    assert(pgfault_num==10);
ffffffffc0201392:	4004                	lw	s1,0(s0)
ffffffffc0201394:	47a9                	li	a5,10
ffffffffc0201396:	2481                	sext.w	s1,s1
ffffffffc0201398:	0af49163          	bne	s1,a5,ffffffffc020143a <_fifo_check_swap+0x1f4>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc020139c:	00004517          	auipc	a0,0x4
ffffffffc02013a0:	47450513          	addi	a0,a0,1140 # ffffffffc0205810 <commands+0x8e8>
ffffffffc02013a4:	d21fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    assert(*(unsigned char *)0x1000 == 0x0a);
ffffffffc02013a8:	6785                	lui	a5,0x1
ffffffffc02013aa:	0007c783          	lbu	a5,0(a5) # 1000 <_binary_obj___user_ex1_out_size-0x8948>
ffffffffc02013ae:	06979663          	bne	a5,s1,ffffffffc020141a <_fifo_check_swap+0x1d4>
    assert(pgfault_num==11);
ffffffffc02013b2:	401c                	lw	a5,0(s0)
ffffffffc02013b4:	472d                	li	a4,11
ffffffffc02013b6:	2781                	sext.w	a5,a5
ffffffffc02013b8:	04e79163          	bne	a5,a4,ffffffffc02013fa <_fifo_check_swap+0x1b4>
}
ffffffffc02013bc:	60e6                	ld	ra,88(sp)
ffffffffc02013be:	6446                	ld	s0,80(sp)
ffffffffc02013c0:	64a6                	ld	s1,72(sp)
ffffffffc02013c2:	6906                	ld	s2,64(sp)
ffffffffc02013c4:	79e2                	ld	s3,56(sp)
ffffffffc02013c6:	7a42                	ld	s4,48(sp)
ffffffffc02013c8:	7aa2                	ld	s5,40(sp)
ffffffffc02013ca:	7b02                	ld	s6,32(sp)
ffffffffc02013cc:	6be2                	ld	s7,24(sp)
ffffffffc02013ce:	6c42                	ld	s8,16(sp)
ffffffffc02013d0:	6ca2                	ld	s9,8(sp)
ffffffffc02013d2:	6d02                	ld	s10,0(sp)
ffffffffc02013d4:	4501                	li	a0,0
ffffffffc02013d6:	6125                	addi	sp,sp,96
ffffffffc02013d8:	8082                	ret
    assert(pgfault_num==4);
ffffffffc02013da:	00004697          	auipc	a3,0x4
ffffffffc02013de:	40e68693          	addi	a3,a3,1038 # ffffffffc02057e8 <commands+0x8c0>
ffffffffc02013e2:	00004617          	auipc	a2,0x4
ffffffffc02013e6:	f3660613          	addi	a2,a2,-202 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02013ea:	05100593          	li	a1,81
ffffffffc02013ee:	00004517          	auipc	a0,0x4
ffffffffc02013f2:	40a50513          	addi	a0,a0,1034 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc02013f6:	e0bfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==11);
ffffffffc02013fa:	00004697          	auipc	a3,0x4
ffffffffc02013fe:	53e68693          	addi	a3,a3,1342 # ffffffffc0205938 <commands+0xa10>
ffffffffc0201402:	00004617          	auipc	a2,0x4
ffffffffc0201406:	f1660613          	addi	a2,a2,-234 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020140a:	07300593          	li	a1,115
ffffffffc020140e:	00004517          	auipc	a0,0x4
ffffffffc0201412:	3ea50513          	addi	a0,a0,1002 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc0201416:	debfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(*(unsigned char *)0x1000 == 0x0a);
ffffffffc020141a:	00004697          	auipc	a3,0x4
ffffffffc020141e:	4f668693          	addi	a3,a3,1270 # ffffffffc0205910 <commands+0x9e8>
ffffffffc0201422:	00004617          	auipc	a2,0x4
ffffffffc0201426:	ef660613          	addi	a2,a2,-266 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020142a:	07100593          	li	a1,113
ffffffffc020142e:	00004517          	auipc	a0,0x4
ffffffffc0201432:	3ca50513          	addi	a0,a0,970 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc0201436:	dcbfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==10);
ffffffffc020143a:	00004697          	auipc	a3,0x4
ffffffffc020143e:	4c668693          	addi	a3,a3,1222 # ffffffffc0205900 <commands+0x9d8>
ffffffffc0201442:	00004617          	auipc	a2,0x4
ffffffffc0201446:	ed660613          	addi	a2,a2,-298 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020144a:	06f00593          	li	a1,111
ffffffffc020144e:	00004517          	auipc	a0,0x4
ffffffffc0201452:	3aa50513          	addi	a0,a0,938 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc0201456:	dabfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==9);
ffffffffc020145a:	00004697          	auipc	a3,0x4
ffffffffc020145e:	49668693          	addi	a3,a3,1174 # ffffffffc02058f0 <commands+0x9c8>
ffffffffc0201462:	00004617          	auipc	a2,0x4
ffffffffc0201466:	eb660613          	addi	a2,a2,-330 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020146a:	06c00593          	li	a1,108
ffffffffc020146e:	00004517          	auipc	a0,0x4
ffffffffc0201472:	38a50513          	addi	a0,a0,906 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc0201476:	d8bfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==8);
ffffffffc020147a:	00004697          	auipc	a3,0x4
ffffffffc020147e:	46668693          	addi	a3,a3,1126 # ffffffffc02058e0 <commands+0x9b8>
ffffffffc0201482:	00004617          	auipc	a2,0x4
ffffffffc0201486:	e9660613          	addi	a2,a2,-362 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020148a:	06900593          	li	a1,105
ffffffffc020148e:	00004517          	auipc	a0,0x4
ffffffffc0201492:	36a50513          	addi	a0,a0,874 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc0201496:	d6bfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==7);
ffffffffc020149a:	00004697          	auipc	a3,0x4
ffffffffc020149e:	43668693          	addi	a3,a3,1078 # ffffffffc02058d0 <commands+0x9a8>
ffffffffc02014a2:	00004617          	auipc	a2,0x4
ffffffffc02014a6:	e7660613          	addi	a2,a2,-394 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02014aa:	06600593          	li	a1,102
ffffffffc02014ae:	00004517          	auipc	a0,0x4
ffffffffc02014b2:	34a50513          	addi	a0,a0,842 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc02014b6:	d4bfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==6);
ffffffffc02014ba:	00004697          	auipc	a3,0x4
ffffffffc02014be:	40668693          	addi	a3,a3,1030 # ffffffffc02058c0 <commands+0x998>
ffffffffc02014c2:	00004617          	auipc	a2,0x4
ffffffffc02014c6:	e5660613          	addi	a2,a2,-426 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02014ca:	06300593          	li	a1,99
ffffffffc02014ce:	00004517          	auipc	a0,0x4
ffffffffc02014d2:	32a50513          	addi	a0,a0,810 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc02014d6:	d2bfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==5);
ffffffffc02014da:	00004697          	auipc	a3,0x4
ffffffffc02014de:	3d668693          	addi	a3,a3,982 # ffffffffc02058b0 <commands+0x988>
ffffffffc02014e2:	00004617          	auipc	a2,0x4
ffffffffc02014e6:	e3660613          	addi	a2,a2,-458 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02014ea:	06000593          	li	a1,96
ffffffffc02014ee:	00004517          	auipc	a0,0x4
ffffffffc02014f2:	30a50513          	addi	a0,a0,778 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc02014f6:	d0bfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==5);
ffffffffc02014fa:	00004697          	auipc	a3,0x4
ffffffffc02014fe:	3b668693          	addi	a3,a3,950 # ffffffffc02058b0 <commands+0x988>
ffffffffc0201502:	00004617          	auipc	a2,0x4
ffffffffc0201506:	e1660613          	addi	a2,a2,-490 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020150a:	05d00593          	li	a1,93
ffffffffc020150e:	00004517          	auipc	a0,0x4
ffffffffc0201512:	2ea50513          	addi	a0,a0,746 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc0201516:	cebfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==4);
ffffffffc020151a:	00004697          	auipc	a3,0x4
ffffffffc020151e:	2ce68693          	addi	a3,a3,718 # ffffffffc02057e8 <commands+0x8c0>
ffffffffc0201522:	00004617          	auipc	a2,0x4
ffffffffc0201526:	df660613          	addi	a2,a2,-522 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020152a:	05a00593          	li	a1,90
ffffffffc020152e:	00004517          	auipc	a0,0x4
ffffffffc0201532:	2ca50513          	addi	a0,a0,714 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc0201536:	ccbfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==4);
ffffffffc020153a:	00004697          	auipc	a3,0x4
ffffffffc020153e:	2ae68693          	addi	a3,a3,686 # ffffffffc02057e8 <commands+0x8c0>
ffffffffc0201542:	00004617          	auipc	a2,0x4
ffffffffc0201546:	dd660613          	addi	a2,a2,-554 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020154a:	05700593          	li	a1,87
ffffffffc020154e:	00004517          	auipc	a0,0x4
ffffffffc0201552:	2aa50513          	addi	a0,a0,682 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc0201556:	cabfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==4);
ffffffffc020155a:	00004697          	auipc	a3,0x4
ffffffffc020155e:	28e68693          	addi	a3,a3,654 # ffffffffc02057e8 <commands+0x8c0>
ffffffffc0201562:	00004617          	auipc	a2,0x4
ffffffffc0201566:	db660613          	addi	a2,a2,-586 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020156a:	05400593          	li	a1,84
ffffffffc020156e:	00004517          	auipc	a0,0x4
ffffffffc0201572:	28a50513          	addi	a0,a0,650 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc0201576:	c8bfe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc020157a <_fifo_swap_out_victim>:
     list_entry_t *head=(list_entry_t*) mm->sm_priv;
ffffffffc020157a:	751c                	ld	a5,40(a0)
{
ffffffffc020157c:	1141                	addi	sp,sp,-16
ffffffffc020157e:	e406                	sd	ra,8(sp)
         assert(head != NULL);
ffffffffc0201580:	cf91                	beqz	a5,ffffffffc020159c <_fifo_swap_out_victim+0x22>
     assert(in_tick==0);
ffffffffc0201582:	ee0d                	bnez	a2,ffffffffc02015bc <_fifo_swap_out_victim+0x42>
    return listelm->next;
ffffffffc0201584:	679c                	ld	a5,8(a5)
}
ffffffffc0201586:	60a2                	ld	ra,8(sp)
ffffffffc0201588:	4501                	li	a0,0
    __list_del(listelm->prev, listelm->next);
ffffffffc020158a:	6394                	ld	a3,0(a5)
ffffffffc020158c:	6798                	ld	a4,8(a5)
    *ptr_page = le2page(entry, pra_page_link);
ffffffffc020158e:	fd878793          	addi	a5,a5,-40
    prev->next = next;
ffffffffc0201592:	e698                	sd	a4,8(a3)
    next->prev = prev;
ffffffffc0201594:	e314                	sd	a3,0(a4)
ffffffffc0201596:	e19c                	sd	a5,0(a1)
}
ffffffffc0201598:	0141                	addi	sp,sp,16
ffffffffc020159a:	8082                	ret
         assert(head != NULL);
ffffffffc020159c:	00004697          	auipc	a3,0x4
ffffffffc02015a0:	3ac68693          	addi	a3,a3,940 # ffffffffc0205948 <commands+0xa20>
ffffffffc02015a4:	00004617          	auipc	a2,0x4
ffffffffc02015a8:	d7460613          	addi	a2,a2,-652 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02015ac:	04100593          	li	a1,65
ffffffffc02015b0:	00004517          	auipc	a0,0x4
ffffffffc02015b4:	24850513          	addi	a0,a0,584 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc02015b8:	c49fe0ef          	jal	ra,ffffffffc0200200 <__panic>
     assert(in_tick==0);
ffffffffc02015bc:	00004697          	auipc	a3,0x4
ffffffffc02015c0:	39c68693          	addi	a3,a3,924 # ffffffffc0205958 <commands+0xa30>
ffffffffc02015c4:	00004617          	auipc	a2,0x4
ffffffffc02015c8:	d5460613          	addi	a2,a2,-684 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02015cc:	04200593          	li	a1,66
ffffffffc02015d0:	00004517          	auipc	a0,0x4
ffffffffc02015d4:	22850513          	addi	a0,a0,552 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc02015d8:	c29fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02015dc <_fifo_map_swappable>:
    list_entry_t *head=(list_entry_t*) mm->sm_priv;
ffffffffc02015dc:	751c                	ld	a5,40(a0)
    assert(entry != NULL && head != NULL);
ffffffffc02015de:	cb91                	beqz	a5,ffffffffc02015f2 <_fifo_map_swappable+0x16>
    __list_add(elm, listelm->prev, listelm);
ffffffffc02015e0:	6394                	ld	a3,0(a5)
ffffffffc02015e2:	02860713          	addi	a4,a2,40
    prev->next = next->prev = elm;
ffffffffc02015e6:	e398                	sd	a4,0(a5)
ffffffffc02015e8:	e698                	sd	a4,8(a3)
}
ffffffffc02015ea:	4501                	li	a0,0
    elm->next = next;
ffffffffc02015ec:	fa1c                	sd	a5,48(a2)
    elm->prev = prev;
ffffffffc02015ee:	f614                	sd	a3,40(a2)
ffffffffc02015f0:	8082                	ret
{
ffffffffc02015f2:	1141                	addi	sp,sp,-16
    assert(entry != NULL && head != NULL);
ffffffffc02015f4:	00004697          	auipc	a3,0x4
ffffffffc02015f8:	37468693          	addi	a3,a3,884 # ffffffffc0205968 <commands+0xa40>
ffffffffc02015fc:	00004617          	auipc	a2,0x4
ffffffffc0201600:	d1c60613          	addi	a2,a2,-740 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201604:	03200593          	li	a1,50
ffffffffc0201608:	00004517          	auipc	a0,0x4
ffffffffc020160c:	1f050513          	addi	a0,a0,496 # ffffffffc02057f8 <commands+0x8d0>
{
ffffffffc0201610:	e406                	sd	ra,8(sp)
    assert(entry != NULL && head != NULL);
ffffffffc0201612:	beffe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201616 <slob_free>:
static void slob_free(void *block, int size)
{
	slob_t *cur, *b = (slob_t *)block;
	unsigned long flags;

	if (!block)
ffffffffc0201616:	c145                	beqz	a0,ffffffffc02016b6 <slob_free+0xa0>
{
ffffffffc0201618:	1141                	addi	sp,sp,-16
ffffffffc020161a:	e022                	sd	s0,0(sp)
ffffffffc020161c:	e406                	sd	ra,8(sp)
ffffffffc020161e:	842a                	mv	s0,a0
		return;

	if (size)
ffffffffc0201620:	edb1                	bnez	a1,ffffffffc020167c <slob_free+0x66>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201622:	100027f3          	csrr	a5,sstatus
ffffffffc0201626:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201628:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020162a:	e3ad                	bnez	a5,ffffffffc020168c <slob_free+0x76>
		b->units = SLOB_UNITS(size);

	/* Find reinsertion point */
	spin_lock_irqsave(&slob_lock, flags);
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc020162c:	00047617          	auipc	a2,0x47
ffffffffc0201630:	99c60613          	addi	a2,a2,-1636 # ffffffffc0247fc8 <slobfree>
ffffffffc0201634:	621c                	ld	a5,0(a2)
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201636:	6798                	ld	a4,8(a5)
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201638:	0087fa63          	bgeu	a5,s0,ffffffffc020164c <slob_free+0x36>
ffffffffc020163c:	00e46c63          	bltu	s0,a4,ffffffffc0201654 <slob_free+0x3e>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201640:	00e7fa63          	bgeu	a5,a4,ffffffffc0201654 <slob_free+0x3e>
    return 0;
ffffffffc0201644:	87ba                	mv	a5,a4
ffffffffc0201646:	6798                	ld	a4,8(a5)
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201648:	fe87eae3          	bltu	a5,s0,ffffffffc020163c <slob_free+0x26>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc020164c:	fee7ece3          	bltu	a5,a4,ffffffffc0201644 <slob_free+0x2e>
ffffffffc0201650:	fee47ae3          	bgeu	s0,a4,ffffffffc0201644 <slob_free+0x2e>
			break;

	if (b + b->units == cur->next) {
ffffffffc0201654:	400c                	lw	a1,0(s0)
ffffffffc0201656:	00459693          	slli	a3,a1,0x4
ffffffffc020165a:	96a2                	add	a3,a3,s0
ffffffffc020165c:	04d70763          	beq	a4,a3,ffffffffc02016aa <slob_free+0x94>
		b->units += cur->next->units;
		b->next = cur->next->next;
	} else
		b->next = cur->next;
ffffffffc0201660:	e418                	sd	a4,8(s0)

	if (cur + cur->units == b) {
ffffffffc0201662:	4394                	lw	a3,0(a5)
ffffffffc0201664:	00469713          	slli	a4,a3,0x4
ffffffffc0201668:	973e                	add	a4,a4,a5
ffffffffc020166a:	02e40a63          	beq	s0,a4,ffffffffc020169e <slob_free+0x88>
		cur->units += b->units;
		cur->next = b->next;
	} else
		cur->next = b;
ffffffffc020166e:	e780                	sd	s0,8(a5)

	slobfree = cur;
ffffffffc0201670:	e21c                	sd	a5,0(a2)
    if (flag) {
ffffffffc0201672:	e10d                	bnez	a0,ffffffffc0201694 <slob_free+0x7e>

	spin_unlock_irqrestore(&slob_lock, flags);
}
ffffffffc0201674:	60a2                	ld	ra,8(sp)
ffffffffc0201676:	6402                	ld	s0,0(sp)
ffffffffc0201678:	0141                	addi	sp,sp,16
ffffffffc020167a:	8082                	ret
		b->units = SLOB_UNITS(size);
ffffffffc020167c:	05bd                	addi	a1,a1,15
ffffffffc020167e:	8191                	srli	a1,a1,0x4
ffffffffc0201680:	c10c                	sw	a1,0(a0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201682:	100027f3          	csrr	a5,sstatus
ffffffffc0201686:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201688:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020168a:	d3cd                	beqz	a5,ffffffffc020162c <slob_free+0x16>
        intr_disable();
ffffffffc020168c:	f73fe0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc0201690:	4505                	li	a0,1
ffffffffc0201692:	bf69                	j	ffffffffc020162c <slob_free+0x16>
}
ffffffffc0201694:	6402                	ld	s0,0(sp)
ffffffffc0201696:	60a2                	ld	ra,8(sp)
ffffffffc0201698:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc020169a:	f5ffe06f          	j	ffffffffc02005f8 <intr_enable>
		cur->units += b->units;
ffffffffc020169e:	4018                	lw	a4,0(s0)
		cur->next = b->next;
ffffffffc02016a0:	640c                	ld	a1,8(s0)
		cur->units += b->units;
ffffffffc02016a2:	9eb9                	addw	a3,a3,a4
ffffffffc02016a4:	c394                	sw	a3,0(a5)
		cur->next = b->next;
ffffffffc02016a6:	e78c                	sd	a1,8(a5)
ffffffffc02016a8:	b7e1                	j	ffffffffc0201670 <slob_free+0x5a>
		b->units += cur->next->units;
ffffffffc02016aa:	4314                	lw	a3,0(a4)
		b->next = cur->next->next;
ffffffffc02016ac:	6718                	ld	a4,8(a4)
		b->units += cur->next->units;
ffffffffc02016ae:	9db5                	addw	a1,a1,a3
ffffffffc02016b0:	c00c                	sw	a1,0(s0)
		b->next = cur->next->next;
ffffffffc02016b2:	e418                	sd	a4,8(s0)
ffffffffc02016b4:	b77d                	j	ffffffffc0201662 <slob_free+0x4c>
ffffffffc02016b6:	8082                	ret

ffffffffc02016b8 <__slob_get_free_pages.isra.0>:
  struct Page * page = alloc_pages(1 << order);
ffffffffc02016b8:	4785                	li	a5,1
static void* __slob_get_free_pages(gfp_t gfp, int order)
ffffffffc02016ba:	1141                	addi	sp,sp,-16
  struct Page * page = alloc_pages(1 << order);
ffffffffc02016bc:	00a7953b          	sllw	a0,a5,a0
static void* __slob_get_free_pages(gfp_t gfp, int order)
ffffffffc02016c0:	e406                	sd	ra,8(sp)
  struct Page * page = alloc_pages(1 << order);
ffffffffc02016c2:	7ed000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
  if(!page)
ffffffffc02016c6:	c91d                	beqz	a0,ffffffffc02016fc <__slob_get_free_pages.isra.0+0x44>
extern size_t npage;
extern uint_t va_pa_offset;

static inline ppn_t
page2ppn(struct Page *page) {
    return page - pages + nbase;
ffffffffc02016c8:	00052697          	auipc	a3,0x52
ffffffffc02016cc:	ec06b683          	ld	a3,-320(a3) # ffffffffc0253588 <pages>
ffffffffc02016d0:	8d15                	sub	a0,a0,a3
ffffffffc02016d2:	8519                	srai	a0,a0,0x6
ffffffffc02016d4:	00006697          	auipc	a3,0x6
ffffffffc02016d8:	abc6b683          	ld	a3,-1348(a3) # ffffffffc0207190 <nbase>
ffffffffc02016dc:	9536                	add	a0,a0,a3
    return &pages[PPN(pa) - nbase];
}

static inline void *
page2kva(struct Page *page) {
    return KADDR(page2pa(page));
ffffffffc02016de:	00c51793          	slli	a5,a0,0xc
ffffffffc02016e2:	83b1                	srli	a5,a5,0xc
ffffffffc02016e4:	00052717          	auipc	a4,0x52
ffffffffc02016e8:	d5473703          	ld	a4,-684(a4) # ffffffffc0253438 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc02016ec:	0532                	slli	a0,a0,0xc
    return KADDR(page2pa(page));
ffffffffc02016ee:	00e7fa63          	bgeu	a5,a4,ffffffffc0201702 <__slob_get_free_pages.isra.0+0x4a>
ffffffffc02016f2:	00052697          	auipc	a3,0x52
ffffffffc02016f6:	e866b683          	ld	a3,-378(a3) # ffffffffc0253578 <va_pa_offset>
ffffffffc02016fa:	9536                	add	a0,a0,a3
}
ffffffffc02016fc:	60a2                	ld	ra,8(sp)
ffffffffc02016fe:	0141                	addi	sp,sp,16
ffffffffc0201700:	8082                	ret
ffffffffc0201702:	86aa                	mv	a3,a0
ffffffffc0201704:	00004617          	auipc	a2,0x4
ffffffffc0201708:	29c60613          	addi	a2,a2,668 # ffffffffc02059a0 <commands+0xa78>
ffffffffc020170c:	06900593          	li	a1,105
ffffffffc0201710:	00004517          	auipc	a0,0x4
ffffffffc0201714:	2b850513          	addi	a0,a0,696 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc0201718:	ae9fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc020171c <slob_alloc.isra.0.constprop.0>:
static void *slob_alloc(size_t size, gfp_t gfp, int align)
ffffffffc020171c:	1101                	addi	sp,sp,-32
ffffffffc020171e:	ec06                	sd	ra,24(sp)
ffffffffc0201720:	e822                	sd	s0,16(sp)
ffffffffc0201722:	e426                	sd	s1,8(sp)
ffffffffc0201724:	e04a                	sd	s2,0(sp)
  assert( (size + SLOB_UNIT) < PAGE_SIZE );
ffffffffc0201726:	01050713          	addi	a4,a0,16
ffffffffc020172a:	6785                	lui	a5,0x1
ffffffffc020172c:	0cf77363          	bgeu	a4,a5,ffffffffc02017f2 <slob_alloc.isra.0.constprop.0+0xd6>
	int delta = 0, units = SLOB_UNITS(size);
ffffffffc0201730:	00f50493          	addi	s1,a0,15
ffffffffc0201734:	8091                	srli	s1,s1,0x4
ffffffffc0201736:	2481                	sext.w	s1,s1
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201738:	10002673          	csrr	a2,sstatus
ffffffffc020173c:	8a09                	andi	a2,a2,2
ffffffffc020173e:	e25d                	bnez	a2,ffffffffc02017e4 <slob_alloc.isra.0.constprop.0+0xc8>
	prev = slobfree;
ffffffffc0201740:	00047917          	auipc	s2,0x47
ffffffffc0201744:	88890913          	addi	s2,s2,-1912 # ffffffffc0247fc8 <slobfree>
ffffffffc0201748:	00093683          	ld	a3,0(s2)
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc020174c:	669c                	ld	a5,8(a3)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc020174e:	4398                	lw	a4,0(a5)
ffffffffc0201750:	08975e63          	bge	a4,s1,ffffffffc02017ec <slob_alloc.isra.0.constprop.0+0xd0>
		if (cur == slobfree) {
ffffffffc0201754:	00d78b63          	beq	a5,a3,ffffffffc020176a <slob_alloc.isra.0.constprop.0+0x4e>
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc0201758:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc020175a:	4018                	lw	a4,0(s0)
ffffffffc020175c:	02975a63          	bge	a4,s1,ffffffffc0201790 <slob_alloc.isra.0.constprop.0+0x74>
ffffffffc0201760:	00093683          	ld	a3,0(s2)
ffffffffc0201764:	87a2                	mv	a5,s0
		if (cur == slobfree) {
ffffffffc0201766:	fed799e3          	bne	a5,a3,ffffffffc0201758 <slob_alloc.isra.0.constprop.0+0x3c>
    if (flag) {
ffffffffc020176a:	ee31                	bnez	a2,ffffffffc02017c6 <slob_alloc.isra.0.constprop.0+0xaa>
			cur = (slob_t *)__slob_get_free_page(gfp);
ffffffffc020176c:	4501                	li	a0,0
ffffffffc020176e:	f4bff0ef          	jal	ra,ffffffffc02016b8 <__slob_get_free_pages.isra.0>
ffffffffc0201772:	842a                	mv	s0,a0
			if (!cur)
ffffffffc0201774:	cd05                	beqz	a0,ffffffffc02017ac <slob_alloc.isra.0.constprop.0+0x90>
			slob_free(cur, PAGE_SIZE);
ffffffffc0201776:	6585                	lui	a1,0x1
ffffffffc0201778:	e9fff0ef          	jal	ra,ffffffffc0201616 <slob_free>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020177c:	10002673          	csrr	a2,sstatus
ffffffffc0201780:	8a09                	andi	a2,a2,2
ffffffffc0201782:	ee05                	bnez	a2,ffffffffc02017ba <slob_alloc.isra.0.constprop.0+0x9e>
			cur = slobfree;
ffffffffc0201784:	00093783          	ld	a5,0(s2)
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc0201788:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc020178a:	4018                	lw	a4,0(s0)
ffffffffc020178c:	fc974ae3          	blt	a4,s1,ffffffffc0201760 <slob_alloc.isra.0.constprop.0+0x44>
			if (cur->units == units) /* exact fit? */
ffffffffc0201790:	04e48763          	beq	s1,a4,ffffffffc02017de <slob_alloc.isra.0.constprop.0+0xc2>
				prev->next = cur + units;
ffffffffc0201794:	00449693          	slli	a3,s1,0x4
ffffffffc0201798:	96a2                	add	a3,a3,s0
ffffffffc020179a:	e794                	sd	a3,8(a5)
				prev->next->next = cur->next;
ffffffffc020179c:	640c                	ld	a1,8(s0)
				prev->next->units = cur->units - units;
ffffffffc020179e:	9f05                	subw	a4,a4,s1
ffffffffc02017a0:	c298                	sw	a4,0(a3)
				prev->next->next = cur->next;
ffffffffc02017a2:	e68c                	sd	a1,8(a3)
				cur->units = units;
ffffffffc02017a4:	c004                	sw	s1,0(s0)
			slobfree = prev;
ffffffffc02017a6:	00f93023          	sd	a5,0(s2)
    if (flag) {
ffffffffc02017aa:	e20d                	bnez	a2,ffffffffc02017cc <slob_alloc.isra.0.constprop.0+0xb0>
}
ffffffffc02017ac:	60e2                	ld	ra,24(sp)
ffffffffc02017ae:	8522                	mv	a0,s0
ffffffffc02017b0:	6442                	ld	s0,16(sp)
ffffffffc02017b2:	64a2                	ld	s1,8(sp)
ffffffffc02017b4:	6902                	ld	s2,0(sp)
ffffffffc02017b6:	6105                	addi	sp,sp,32
ffffffffc02017b8:	8082                	ret
        intr_disable();
ffffffffc02017ba:	e45fe0ef          	jal	ra,ffffffffc02005fe <intr_disable>
			cur = slobfree;
ffffffffc02017be:	00093783          	ld	a5,0(s2)
        return 1;
ffffffffc02017c2:	4605                	li	a2,1
ffffffffc02017c4:	b7d1                	j	ffffffffc0201788 <slob_alloc.isra.0.constprop.0+0x6c>
        intr_enable();
ffffffffc02017c6:	e33fe0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc02017ca:	b74d                	j	ffffffffc020176c <slob_alloc.isra.0.constprop.0+0x50>
ffffffffc02017cc:	e2dfe0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
}
ffffffffc02017d0:	60e2                	ld	ra,24(sp)
ffffffffc02017d2:	8522                	mv	a0,s0
ffffffffc02017d4:	6442                	ld	s0,16(sp)
ffffffffc02017d6:	64a2                	ld	s1,8(sp)
ffffffffc02017d8:	6902                	ld	s2,0(sp)
ffffffffc02017da:	6105                	addi	sp,sp,32
ffffffffc02017dc:	8082                	ret
				prev->next = cur->next; /* unlink */
ffffffffc02017de:	6418                	ld	a4,8(s0)
ffffffffc02017e0:	e798                	sd	a4,8(a5)
ffffffffc02017e2:	b7d1                	j	ffffffffc02017a6 <slob_alloc.isra.0.constprop.0+0x8a>
        intr_disable();
ffffffffc02017e4:	e1bfe0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc02017e8:	4605                	li	a2,1
ffffffffc02017ea:	bf99                	j	ffffffffc0201740 <slob_alloc.isra.0.constprop.0+0x24>
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc02017ec:	843e                	mv	s0,a5
ffffffffc02017ee:	87b6                	mv	a5,a3
ffffffffc02017f0:	b745                	j	ffffffffc0201790 <slob_alloc.isra.0.constprop.0+0x74>
  assert( (size + SLOB_UNIT) < PAGE_SIZE );
ffffffffc02017f2:	00004697          	auipc	a3,0x4
ffffffffc02017f6:	1e668693          	addi	a3,a3,486 # ffffffffc02059d8 <commands+0xab0>
ffffffffc02017fa:	00004617          	auipc	a2,0x4
ffffffffc02017fe:	b1e60613          	addi	a2,a2,-1250 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201802:	06400593          	li	a1,100
ffffffffc0201806:	00004517          	auipc	a0,0x4
ffffffffc020180a:	1f250513          	addi	a0,a0,498 # ffffffffc02059f8 <commands+0xad0>
ffffffffc020180e:	9f3fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201812 <kmalloc_init>:

inline void 
kmalloc_init(void) {
    slob_init();
    //cprintf("kmalloc_init() succeeded!\n");
}
ffffffffc0201812:	8082                	ret

ffffffffc0201814 <kallocated>:
}

size_t
kallocated(void) {
   return slob_allocated();
}
ffffffffc0201814:	4501                	li	a0,0
ffffffffc0201816:	8082                	ret

ffffffffc0201818 <kmalloc>:
	return 0;
}

void *
kmalloc(size_t size)
{
ffffffffc0201818:	1101                	addi	sp,sp,-32
ffffffffc020181a:	e04a                	sd	s2,0(sp)
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc020181c:	6905                	lui	s2,0x1
{
ffffffffc020181e:	e822                	sd	s0,16(sp)
ffffffffc0201820:	ec06                	sd	ra,24(sp)
ffffffffc0201822:	e426                	sd	s1,8(sp)
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc0201824:	fef90793          	addi	a5,s2,-17 # fef <_binary_obj___user_ex1_out_size-0x8959>
{
ffffffffc0201828:	842a                	mv	s0,a0
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc020182a:	04a7f963          	bgeu	a5,a0,ffffffffc020187c <kmalloc+0x64>
	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
ffffffffc020182e:	4561                	li	a0,24
ffffffffc0201830:	eedff0ef          	jal	ra,ffffffffc020171c <slob_alloc.isra.0.constprop.0>
ffffffffc0201834:	84aa                	mv	s1,a0
	if (!bb)
ffffffffc0201836:	c929                	beqz	a0,ffffffffc0201888 <kmalloc+0x70>
	bb->order = find_order(size);
ffffffffc0201838:	0004079b          	sext.w	a5,s0
	int order = 0;
ffffffffc020183c:	4501                	li	a0,0
	for ( ; size > 4096 ; size >>=1)
ffffffffc020183e:	00f95763          	bge	s2,a5,ffffffffc020184c <kmalloc+0x34>
ffffffffc0201842:	6705                	lui	a4,0x1
ffffffffc0201844:	8785                	srai	a5,a5,0x1
		order++;
ffffffffc0201846:	2505                	addiw	a0,a0,1
	for ( ; size > 4096 ; size >>=1)
ffffffffc0201848:	fef74ee3          	blt	a4,a5,ffffffffc0201844 <kmalloc+0x2c>
	bb->order = find_order(size);
ffffffffc020184c:	c088                	sw	a0,0(s1)
	bb->pages = (void *)__slob_get_free_pages(gfp, bb->order);
ffffffffc020184e:	e6bff0ef          	jal	ra,ffffffffc02016b8 <__slob_get_free_pages.isra.0>
ffffffffc0201852:	e488                	sd	a0,8(s1)
ffffffffc0201854:	842a                	mv	s0,a0
	if (bb->pages) {
ffffffffc0201856:	c525                	beqz	a0,ffffffffc02018be <kmalloc+0xa6>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201858:	100027f3          	csrr	a5,sstatus
ffffffffc020185c:	8b89                	andi	a5,a5,2
ffffffffc020185e:	ef8d                	bnez	a5,ffffffffc0201898 <kmalloc+0x80>
		bb->next = bigblocks;
ffffffffc0201860:	00052797          	auipc	a5,0x52
ffffffffc0201864:	bb878793          	addi	a5,a5,-1096 # ffffffffc0253418 <bigblocks>
ffffffffc0201868:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc020186a:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc020186c:	e898                	sd	a4,16(s1)
  return __kmalloc(size, 0);
}
ffffffffc020186e:	60e2                	ld	ra,24(sp)
ffffffffc0201870:	8522                	mv	a0,s0
ffffffffc0201872:	6442                	ld	s0,16(sp)
ffffffffc0201874:	64a2                	ld	s1,8(sp)
ffffffffc0201876:	6902                	ld	s2,0(sp)
ffffffffc0201878:	6105                	addi	sp,sp,32
ffffffffc020187a:	8082                	ret
		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
ffffffffc020187c:	0541                	addi	a0,a0,16
ffffffffc020187e:	e9fff0ef          	jal	ra,ffffffffc020171c <slob_alloc.isra.0.constprop.0>
		return m ? (void *)(m + 1) : 0;
ffffffffc0201882:	01050413          	addi	s0,a0,16
ffffffffc0201886:	f565                	bnez	a0,ffffffffc020186e <kmalloc+0x56>
ffffffffc0201888:	4401                	li	s0,0
}
ffffffffc020188a:	60e2                	ld	ra,24(sp)
ffffffffc020188c:	8522                	mv	a0,s0
ffffffffc020188e:	6442                	ld	s0,16(sp)
ffffffffc0201890:	64a2                	ld	s1,8(sp)
ffffffffc0201892:	6902                	ld	s2,0(sp)
ffffffffc0201894:	6105                	addi	sp,sp,32
ffffffffc0201896:	8082                	ret
        intr_disable();
ffffffffc0201898:	d67fe0ef          	jal	ra,ffffffffc02005fe <intr_disable>
		bb->next = bigblocks;
ffffffffc020189c:	00052797          	auipc	a5,0x52
ffffffffc02018a0:	b7c78793          	addi	a5,a5,-1156 # ffffffffc0253418 <bigblocks>
ffffffffc02018a4:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc02018a6:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc02018a8:	e898                	sd	a4,16(s1)
        intr_enable();
ffffffffc02018aa:	d4ffe0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc02018ae:	6480                	ld	s0,8(s1)
}
ffffffffc02018b0:	60e2                	ld	ra,24(sp)
ffffffffc02018b2:	64a2                	ld	s1,8(sp)
ffffffffc02018b4:	8522                	mv	a0,s0
ffffffffc02018b6:	6442                	ld	s0,16(sp)
ffffffffc02018b8:	6902                	ld	s2,0(sp)
ffffffffc02018ba:	6105                	addi	sp,sp,32
ffffffffc02018bc:	8082                	ret
	slob_free(bb, sizeof(bigblock_t));
ffffffffc02018be:	45e1                	li	a1,24
ffffffffc02018c0:	8526                	mv	a0,s1
ffffffffc02018c2:	d55ff0ef          	jal	ra,ffffffffc0201616 <slob_free>
  return __kmalloc(size, 0);
ffffffffc02018c6:	b765                	j	ffffffffc020186e <kmalloc+0x56>

ffffffffc02018c8 <kfree>:
void kfree(void *block)
{
	bigblock_t *bb, **last = &bigblocks;
	unsigned long flags;

	if (!block)
ffffffffc02018c8:	c169                	beqz	a0,ffffffffc020198a <kfree+0xc2>
{
ffffffffc02018ca:	1101                	addi	sp,sp,-32
ffffffffc02018cc:	e822                	sd	s0,16(sp)
ffffffffc02018ce:	ec06                	sd	ra,24(sp)
ffffffffc02018d0:	e426                	sd	s1,8(sp)
		return;

	if (!((unsigned long)block & (PAGE_SIZE-1))) {
ffffffffc02018d2:	03451793          	slli	a5,a0,0x34
ffffffffc02018d6:	842a                	mv	s0,a0
ffffffffc02018d8:	e7c9                	bnez	a5,ffffffffc0201962 <kfree+0x9a>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02018da:	100027f3          	csrr	a5,sstatus
ffffffffc02018de:	8b89                	andi	a5,a5,2
ffffffffc02018e0:	ebc9                	bnez	a5,ffffffffc0201972 <kfree+0xaa>
		/* might be on the big block list */
		spin_lock_irqsave(&block_lock, flags);
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc02018e2:	00052797          	auipc	a5,0x52
ffffffffc02018e6:	b367b783          	ld	a5,-1226(a5) # ffffffffc0253418 <bigblocks>
    return 0;
ffffffffc02018ea:	4601                	li	a2,0
ffffffffc02018ec:	cbbd                	beqz	a5,ffffffffc0201962 <kfree+0x9a>
	bigblock_t *bb, **last = &bigblocks;
ffffffffc02018ee:	00052697          	auipc	a3,0x52
ffffffffc02018f2:	b2a68693          	addi	a3,a3,-1238 # ffffffffc0253418 <bigblocks>
ffffffffc02018f6:	a021                	j	ffffffffc02018fe <kfree+0x36>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc02018f8:	01048693          	addi	a3,s1,16
ffffffffc02018fc:	c3a5                	beqz	a5,ffffffffc020195c <kfree+0x94>
			if (bb->pages == block) {
ffffffffc02018fe:	6798                	ld	a4,8(a5)
ffffffffc0201900:	84be                	mv	s1,a5
ffffffffc0201902:	6b9c                	ld	a5,16(a5)
ffffffffc0201904:	fe871ae3          	bne	a4,s0,ffffffffc02018f8 <kfree+0x30>
				*last = bb->next;
ffffffffc0201908:	e29c                	sd	a5,0(a3)
    if (flag) {
ffffffffc020190a:	ee2d                	bnez	a2,ffffffffc0201984 <kfree+0xbc>
}

static inline struct Page *
kva2page(void *kva) {
    return pa2page(PADDR(kva));
ffffffffc020190c:	c02007b7          	lui	a5,0xc0200
				spin_unlock_irqrestore(&block_lock, flags);
				__slob_free_pages((unsigned long)block, bb->order);
ffffffffc0201910:	4098                	lw	a4,0(s1)
ffffffffc0201912:	08f46963          	bltu	s0,a5,ffffffffc02019a4 <kfree+0xdc>
ffffffffc0201916:	00052697          	auipc	a3,0x52
ffffffffc020191a:	c626b683          	ld	a3,-926(a3) # ffffffffc0253578 <va_pa_offset>
ffffffffc020191e:	8c15                	sub	s0,s0,a3
    if (PPN(pa) >= npage) {
ffffffffc0201920:	8031                	srli	s0,s0,0xc
ffffffffc0201922:	00052797          	auipc	a5,0x52
ffffffffc0201926:	b167b783          	ld	a5,-1258(a5) # ffffffffc0253438 <npage>
ffffffffc020192a:	06f47163          	bgeu	s0,a5,ffffffffc020198c <kfree+0xc4>
    return &pages[PPN(pa) - nbase];
ffffffffc020192e:	00006517          	auipc	a0,0x6
ffffffffc0201932:	86253503          	ld	a0,-1950(a0) # ffffffffc0207190 <nbase>
ffffffffc0201936:	8c09                	sub	s0,s0,a0
ffffffffc0201938:	041a                	slli	s0,s0,0x6
  free_pages(kva2page(kva), 1 << order);
ffffffffc020193a:	00052517          	auipc	a0,0x52
ffffffffc020193e:	c4e53503          	ld	a0,-946(a0) # ffffffffc0253588 <pages>
ffffffffc0201942:	4585                	li	a1,1
ffffffffc0201944:	9522                	add	a0,a0,s0
ffffffffc0201946:	00e595bb          	sllw	a1,a1,a4
ffffffffc020194a:	5f7000ef          	jal	ra,ffffffffc0202740 <free_pages>
		spin_unlock_irqrestore(&block_lock, flags);
	}

	slob_free((slob_t *)block - 1, 0);
	return;
}
ffffffffc020194e:	6442                	ld	s0,16(sp)
ffffffffc0201950:	60e2                	ld	ra,24(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201952:	8526                	mv	a0,s1
}
ffffffffc0201954:	64a2                	ld	s1,8(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201956:	45e1                	li	a1,24
}
ffffffffc0201958:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc020195a:	b975                	j	ffffffffc0201616 <slob_free>
ffffffffc020195c:	c219                	beqz	a2,ffffffffc0201962 <kfree+0x9a>
        intr_enable();
ffffffffc020195e:	c9bfe0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc0201962:	ff040513          	addi	a0,s0,-16
}
ffffffffc0201966:	6442                	ld	s0,16(sp)
ffffffffc0201968:	60e2                	ld	ra,24(sp)
ffffffffc020196a:	64a2                	ld	s1,8(sp)
	slob_free((slob_t *)block - 1, 0);
ffffffffc020196c:	4581                	li	a1,0
}
ffffffffc020196e:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201970:	b15d                	j	ffffffffc0201616 <slob_free>
        intr_disable();
ffffffffc0201972:	c8dfe0ef          	jal	ra,ffffffffc02005fe <intr_disable>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc0201976:	00052797          	auipc	a5,0x52
ffffffffc020197a:	aa27b783          	ld	a5,-1374(a5) # ffffffffc0253418 <bigblocks>
        return 1;
ffffffffc020197e:	4605                	li	a2,1
ffffffffc0201980:	f7bd                	bnez	a5,ffffffffc02018ee <kfree+0x26>
ffffffffc0201982:	bff1                	j	ffffffffc020195e <kfree+0x96>
        intr_enable();
ffffffffc0201984:	c75fe0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc0201988:	b751                	j	ffffffffc020190c <kfree+0x44>
ffffffffc020198a:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc020198c:	00004617          	auipc	a2,0x4
ffffffffc0201990:	0ac60613          	addi	a2,a2,172 # ffffffffc0205a38 <commands+0xb10>
ffffffffc0201994:	06200593          	li	a1,98
ffffffffc0201998:	00004517          	auipc	a0,0x4
ffffffffc020199c:	03050513          	addi	a0,a0,48 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc02019a0:	861fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    return pa2page(PADDR(kva));
ffffffffc02019a4:	86a2                	mv	a3,s0
ffffffffc02019a6:	00004617          	auipc	a2,0x4
ffffffffc02019aa:	06a60613          	addi	a2,a2,106 # ffffffffc0205a10 <commands+0xae8>
ffffffffc02019ae:	06e00593          	li	a1,110
ffffffffc02019b2:	00004517          	auipc	a0,0x4
ffffffffc02019b6:	01650513          	addi	a0,a0,22 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc02019ba:	847fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02019be <swap_init>:

static void check_swap(void);

int
swap_init(void)
{
ffffffffc02019be:	1101                	addi	sp,sp,-32
ffffffffc02019c0:	ec06                	sd	ra,24(sp)
ffffffffc02019c2:	e822                	sd	s0,16(sp)
ffffffffc02019c4:	e426                	sd	s1,8(sp)
     swapfs_init();
ffffffffc02019c6:	6b4010ef          	jal	ra,ffffffffc020307a <swapfs_init>

     // Since the IDE is faked, it can only store 7 pages at most to pass the test
     if (!(7 <= max_swap_offset &&
ffffffffc02019ca:	00052697          	auipc	a3,0x52
ffffffffc02019ce:	b4e6b683          	ld	a3,-1202(a3) # ffffffffc0253518 <max_swap_offset>
ffffffffc02019d2:	010007b7          	lui	a5,0x1000
ffffffffc02019d6:	ff968713          	addi	a4,a3,-7
ffffffffc02019da:	17e1                	addi	a5,a5,-8
ffffffffc02019dc:	04e7e863          	bltu	a5,a4,ffffffffc0201a2c <swap_init+0x6e>
        max_swap_offset < MAX_SWAP_OFFSET_LIMIT)) {
        panic("bad max_swap_offset %08x.\n", max_swap_offset);
     }
     

     sm = &swap_manager_fifo;
ffffffffc02019e0:	00046797          	auipc	a5,0x46
ffffffffc02019e4:	56878793          	addi	a5,a5,1384 # ffffffffc0247f48 <swap_manager_fifo>
     int r = sm->init();
ffffffffc02019e8:	6798                	ld	a4,8(a5)
     sm = &swap_manager_fifo;
ffffffffc02019ea:	00052497          	auipc	s1,0x52
ffffffffc02019ee:	a3648493          	addi	s1,s1,-1482 # ffffffffc0253420 <sm>
ffffffffc02019f2:	e09c                	sd	a5,0(s1)
     int r = sm->init();
ffffffffc02019f4:	9702                	jalr	a4
ffffffffc02019f6:	842a                	mv	s0,a0
     
     if (r == 0)
ffffffffc02019f8:	c519                	beqz	a0,ffffffffc0201a06 <swap_init+0x48>
          cprintf("SWAP: manager = %s\n", sm->name);
          //check_swap();
     }

     return r;
}
ffffffffc02019fa:	60e2                	ld	ra,24(sp)
ffffffffc02019fc:	8522                	mv	a0,s0
ffffffffc02019fe:	6442                	ld	s0,16(sp)
ffffffffc0201a00:	64a2                	ld	s1,8(sp)
ffffffffc0201a02:	6105                	addi	sp,sp,32
ffffffffc0201a04:	8082                	ret
          cprintf("SWAP: manager = %s\n", sm->name);
ffffffffc0201a06:	609c                	ld	a5,0(s1)
ffffffffc0201a08:	00004517          	auipc	a0,0x4
ffffffffc0201a0c:	08050513          	addi	a0,a0,128 # ffffffffc0205a88 <commands+0xb60>
ffffffffc0201a10:	638c                	ld	a1,0(a5)
          swap_init_ok = 1;
ffffffffc0201a12:	4785                	li	a5,1
ffffffffc0201a14:	00052717          	auipc	a4,0x52
ffffffffc0201a18:	a0f72a23          	sw	a5,-1516(a4) # ffffffffc0253428 <swap_init_ok>
          cprintf("SWAP: manager = %s\n", sm->name);
ffffffffc0201a1c:	ea8fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
}
ffffffffc0201a20:	60e2                	ld	ra,24(sp)
ffffffffc0201a22:	8522                	mv	a0,s0
ffffffffc0201a24:	6442                	ld	s0,16(sp)
ffffffffc0201a26:	64a2                	ld	s1,8(sp)
ffffffffc0201a28:	6105                	addi	sp,sp,32
ffffffffc0201a2a:	8082                	ret
        panic("bad max_swap_offset %08x.\n", max_swap_offset);
ffffffffc0201a2c:	00004617          	auipc	a2,0x4
ffffffffc0201a30:	02c60613          	addi	a2,a2,44 # ffffffffc0205a58 <commands+0xb30>
ffffffffc0201a34:	02800593          	li	a1,40
ffffffffc0201a38:	00004517          	auipc	a0,0x4
ffffffffc0201a3c:	04050513          	addi	a0,a0,64 # ffffffffc0205a78 <commands+0xb50>
ffffffffc0201a40:	fc0fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201a44 <swap_init_mm>:

int
swap_init_mm(struct mm_struct *mm)
{
     return sm->init_mm(mm);
ffffffffc0201a44:	00052797          	auipc	a5,0x52
ffffffffc0201a48:	9dc7b783          	ld	a5,-1572(a5) # ffffffffc0253420 <sm>
ffffffffc0201a4c:	0107b303          	ld	t1,16(a5)
ffffffffc0201a50:	8302                	jr	t1

ffffffffc0201a52 <swap_map_swappable>:
}

int
swap_map_swappable(struct mm_struct *mm, uintptr_t addr, struct Page *page, int swap_in)
{
     return sm->map_swappable(mm, addr, page, swap_in);
ffffffffc0201a52:	00052797          	auipc	a5,0x52
ffffffffc0201a56:	9ce7b783          	ld	a5,-1586(a5) # ffffffffc0253420 <sm>
ffffffffc0201a5a:	0207b303          	ld	t1,32(a5)
ffffffffc0201a5e:	8302                	jr	t1

ffffffffc0201a60 <swap_out>:

volatile unsigned int swap_out_num=0;

int
swap_out(struct mm_struct *mm, int n, int in_tick)
{
ffffffffc0201a60:	711d                	addi	sp,sp,-96
ffffffffc0201a62:	ec86                	sd	ra,88(sp)
ffffffffc0201a64:	e8a2                	sd	s0,80(sp)
ffffffffc0201a66:	e4a6                	sd	s1,72(sp)
ffffffffc0201a68:	e0ca                	sd	s2,64(sp)
ffffffffc0201a6a:	fc4e                	sd	s3,56(sp)
ffffffffc0201a6c:	f852                	sd	s4,48(sp)
ffffffffc0201a6e:	f456                	sd	s5,40(sp)
ffffffffc0201a70:	f05a                	sd	s6,32(sp)
ffffffffc0201a72:	ec5e                	sd	s7,24(sp)
ffffffffc0201a74:	e862                	sd	s8,16(sp)
     int i;
     for (i = 0; i != n; ++ i)
ffffffffc0201a76:	cde9                	beqz	a1,ffffffffc0201b50 <swap_out+0xf0>
ffffffffc0201a78:	8a2e                	mv	s4,a1
ffffffffc0201a7a:	892a                	mv	s2,a0
ffffffffc0201a7c:	8ab2                	mv	s5,a2
ffffffffc0201a7e:	4401                	li	s0,0
ffffffffc0201a80:	00052997          	auipc	s3,0x52
ffffffffc0201a84:	9a098993          	addi	s3,s3,-1632 # ffffffffc0253420 <sm>
                    cprintf("SWAP: failed to save\n");
                    sm->map_swappable(mm, v, page, 0);
                    continue;
          }
          else {
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc0201a88:	00004b17          	auipc	s6,0x4
ffffffffc0201a8c:	078b0b13          	addi	s6,s6,120 # ffffffffc0205b00 <commands+0xbd8>
                    cprintf("SWAP: failed to save\n");
ffffffffc0201a90:	00004b97          	auipc	s7,0x4
ffffffffc0201a94:	058b8b93          	addi	s7,s7,88 # ffffffffc0205ae8 <commands+0xbc0>
ffffffffc0201a98:	a825                	j	ffffffffc0201ad0 <swap_out+0x70>
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc0201a9a:	67a2                	ld	a5,8(sp)
ffffffffc0201a9c:	8626                	mv	a2,s1
ffffffffc0201a9e:	85a2                	mv	a1,s0
ffffffffc0201aa0:	7f94                	ld	a3,56(a5)
ffffffffc0201aa2:	855a                	mv	a0,s6
     for (i = 0; i != n; ++ i)
ffffffffc0201aa4:	2405                	addiw	s0,s0,1
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc0201aa6:	82b1                	srli	a3,a3,0xc
ffffffffc0201aa8:	0685                	addi	a3,a3,1
ffffffffc0201aaa:	e1afe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
                    *ptep = (page->pra_vaddr/PGSIZE+1)<<8;
ffffffffc0201aae:	6522                	ld	a0,8(sp)
                    free_page(page);
ffffffffc0201ab0:	4585                	li	a1,1
                    *ptep = (page->pra_vaddr/PGSIZE+1)<<8;
ffffffffc0201ab2:	7d1c                	ld	a5,56(a0)
ffffffffc0201ab4:	83b1                	srli	a5,a5,0xc
ffffffffc0201ab6:	0785                	addi	a5,a5,1
ffffffffc0201ab8:	07a2                	slli	a5,a5,0x8
ffffffffc0201aba:	00fc3023          	sd	a5,0(s8)
                    free_page(page);
ffffffffc0201abe:	483000ef          	jal	ra,ffffffffc0202740 <free_pages>
          }
          
          tlb_invalidate(mm->pgdir, v);
ffffffffc0201ac2:	01893503          	ld	a0,24(s2)
ffffffffc0201ac6:	85a6                	mv	a1,s1
ffffffffc0201ac8:	51e010ef          	jal	ra,ffffffffc0202fe6 <tlb_invalidate>
     for (i = 0; i != n; ++ i)
ffffffffc0201acc:	048a0d63          	beq	s4,s0,ffffffffc0201b26 <swap_out+0xc6>
          int r = sm->swap_out_victim(mm, &page, in_tick);
ffffffffc0201ad0:	0009b783          	ld	a5,0(s3)
ffffffffc0201ad4:	8656                	mv	a2,s5
ffffffffc0201ad6:	002c                	addi	a1,sp,8
ffffffffc0201ad8:	7b9c                	ld	a5,48(a5)
ffffffffc0201ada:	854a                	mv	a0,s2
ffffffffc0201adc:	9782                	jalr	a5
          if (r != 0) {
ffffffffc0201ade:	e12d                	bnez	a0,ffffffffc0201b40 <swap_out+0xe0>
          v=page->pra_vaddr; 
ffffffffc0201ae0:	67a2                	ld	a5,8(sp)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc0201ae2:	01893503          	ld	a0,24(s2)
ffffffffc0201ae6:	4601                	li	a2,0
          v=page->pra_vaddr; 
ffffffffc0201ae8:	7f84                	ld	s1,56(a5)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc0201aea:	85a6                	mv	a1,s1
ffffffffc0201aec:	629000ef          	jal	ra,ffffffffc0202914 <get_pte>
          assert((*ptep & PTE_V) != 0);
ffffffffc0201af0:	611c                	ld	a5,0(a0)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc0201af2:	8c2a                	mv	s8,a0
          assert((*ptep & PTE_V) != 0);
ffffffffc0201af4:	8b85                	andi	a5,a5,1
ffffffffc0201af6:	cfb9                	beqz	a5,ffffffffc0201b54 <swap_out+0xf4>
          if (swapfs_write( (page->pra_vaddr/PGSIZE+1)<<8, page) != 0) {
ffffffffc0201af8:	65a2                	ld	a1,8(sp)
ffffffffc0201afa:	7d9c                	ld	a5,56(a1)
ffffffffc0201afc:	83b1                	srli	a5,a5,0xc
ffffffffc0201afe:	0785                	addi	a5,a5,1
ffffffffc0201b00:	00879513          	slli	a0,a5,0x8
ffffffffc0201b04:	63c010ef          	jal	ra,ffffffffc0203140 <swapfs_write>
ffffffffc0201b08:	d949                	beqz	a0,ffffffffc0201a9a <swap_out+0x3a>
                    cprintf("SWAP: failed to save\n");
ffffffffc0201b0a:	855e                	mv	a0,s7
ffffffffc0201b0c:	db8fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
                    sm->map_swappable(mm, v, page, 0);
ffffffffc0201b10:	0009b783          	ld	a5,0(s3)
ffffffffc0201b14:	6622                	ld	a2,8(sp)
ffffffffc0201b16:	4681                	li	a3,0
ffffffffc0201b18:	739c                	ld	a5,32(a5)
ffffffffc0201b1a:	85a6                	mv	a1,s1
ffffffffc0201b1c:	854a                	mv	a0,s2
     for (i = 0; i != n; ++ i)
ffffffffc0201b1e:	2405                	addiw	s0,s0,1
                    sm->map_swappable(mm, v, page, 0);
ffffffffc0201b20:	9782                	jalr	a5
     for (i = 0; i != n; ++ i)
ffffffffc0201b22:	fa8a17e3          	bne	s4,s0,ffffffffc0201ad0 <swap_out+0x70>
     }
     return i;
}
ffffffffc0201b26:	60e6                	ld	ra,88(sp)
ffffffffc0201b28:	8522                	mv	a0,s0
ffffffffc0201b2a:	6446                	ld	s0,80(sp)
ffffffffc0201b2c:	64a6                	ld	s1,72(sp)
ffffffffc0201b2e:	6906                	ld	s2,64(sp)
ffffffffc0201b30:	79e2                	ld	s3,56(sp)
ffffffffc0201b32:	7a42                	ld	s4,48(sp)
ffffffffc0201b34:	7aa2                	ld	s5,40(sp)
ffffffffc0201b36:	7b02                	ld	s6,32(sp)
ffffffffc0201b38:	6be2                	ld	s7,24(sp)
ffffffffc0201b3a:	6c42                	ld	s8,16(sp)
ffffffffc0201b3c:	6125                	addi	sp,sp,96
ffffffffc0201b3e:	8082                	ret
                    cprintf("i %d, swap_out: call swap_out_victim failed\n",i);
ffffffffc0201b40:	85a2                	mv	a1,s0
ffffffffc0201b42:	00004517          	auipc	a0,0x4
ffffffffc0201b46:	f5e50513          	addi	a0,a0,-162 # ffffffffc0205aa0 <commands+0xb78>
ffffffffc0201b4a:	d7afe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
                  break;
ffffffffc0201b4e:	bfe1                	j	ffffffffc0201b26 <swap_out+0xc6>
     for (i = 0; i != n; ++ i)
ffffffffc0201b50:	4401                	li	s0,0
ffffffffc0201b52:	bfd1                	j	ffffffffc0201b26 <swap_out+0xc6>
          assert((*ptep & PTE_V) != 0);
ffffffffc0201b54:	00004697          	auipc	a3,0x4
ffffffffc0201b58:	f7c68693          	addi	a3,a3,-132 # ffffffffc0205ad0 <commands+0xba8>
ffffffffc0201b5c:	00003617          	auipc	a2,0x3
ffffffffc0201b60:	7bc60613          	addi	a2,a2,1980 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201b64:	06800593          	li	a1,104
ffffffffc0201b68:	00004517          	auipc	a0,0x4
ffffffffc0201b6c:	f1050513          	addi	a0,a0,-240 # ffffffffc0205a78 <commands+0xb50>
ffffffffc0201b70:	e90fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201b74 <swap_in>:

int
swap_in(struct mm_struct *mm, uintptr_t addr, struct Page **ptr_result)
{
ffffffffc0201b74:	7179                	addi	sp,sp,-48
ffffffffc0201b76:	e84a                	sd	s2,16(sp)
ffffffffc0201b78:	892a                	mv	s2,a0
     struct Page *result = alloc_page();
ffffffffc0201b7a:	4505                	li	a0,1
{
ffffffffc0201b7c:	ec26                	sd	s1,24(sp)
ffffffffc0201b7e:	e44e                	sd	s3,8(sp)
ffffffffc0201b80:	f406                	sd	ra,40(sp)
ffffffffc0201b82:	f022                	sd	s0,32(sp)
ffffffffc0201b84:	84ae                	mv	s1,a1
ffffffffc0201b86:	89b2                	mv	s3,a2
     struct Page *result = alloc_page();
ffffffffc0201b88:	327000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
     assert(result!=NULL);
ffffffffc0201b8c:	c129                	beqz	a0,ffffffffc0201bce <swap_in+0x5a>

     pte_t *ptep = get_pte(mm->pgdir, addr, 0);
ffffffffc0201b8e:	842a                	mv	s0,a0
ffffffffc0201b90:	01893503          	ld	a0,24(s2)
ffffffffc0201b94:	4601                	li	a2,0
ffffffffc0201b96:	85a6                	mv	a1,s1
ffffffffc0201b98:	57d000ef          	jal	ra,ffffffffc0202914 <get_pte>
ffffffffc0201b9c:	892a                	mv	s2,a0
     // cprintf("SWAP: load ptep %x swap entry %d to vaddr 0x%08x, page %x, No %d\n", ptep, (*ptep)>>8, addr, result, (result-pages));
    
     int r;
     if ((r = swapfs_read((*ptep), result)) != 0)
ffffffffc0201b9e:	6108                	ld	a0,0(a0)
ffffffffc0201ba0:	85a2                	mv	a1,s0
ffffffffc0201ba2:	510010ef          	jal	ra,ffffffffc02030b2 <swapfs_read>
     {
        assert(r!=0);
     }
     cprintf("swap_in: load disk swap entry %d with swap_page in vadr 0x%x\n", (*ptep)>>8, addr);
ffffffffc0201ba6:	00093583          	ld	a1,0(s2)
ffffffffc0201baa:	8626                	mv	a2,s1
ffffffffc0201bac:	00004517          	auipc	a0,0x4
ffffffffc0201bb0:	fa450513          	addi	a0,a0,-92 # ffffffffc0205b50 <commands+0xc28>
ffffffffc0201bb4:	81a1                	srli	a1,a1,0x8
ffffffffc0201bb6:	d0efe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
     *ptr_result=result;
     return 0;
}
ffffffffc0201bba:	70a2                	ld	ra,40(sp)
     *ptr_result=result;
ffffffffc0201bbc:	0089b023          	sd	s0,0(s3)
}
ffffffffc0201bc0:	7402                	ld	s0,32(sp)
ffffffffc0201bc2:	64e2                	ld	s1,24(sp)
ffffffffc0201bc4:	6942                	ld	s2,16(sp)
ffffffffc0201bc6:	69a2                	ld	s3,8(sp)
ffffffffc0201bc8:	4501                	li	a0,0
ffffffffc0201bca:	6145                	addi	sp,sp,48
ffffffffc0201bcc:	8082                	ret
     assert(result!=NULL);
ffffffffc0201bce:	00004697          	auipc	a3,0x4
ffffffffc0201bd2:	f7268693          	addi	a3,a3,-142 # ffffffffc0205b40 <commands+0xc18>
ffffffffc0201bd6:	00003617          	auipc	a2,0x3
ffffffffc0201bda:	74260613          	addi	a2,a2,1858 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201bde:	07e00593          	li	a1,126
ffffffffc0201be2:	00004517          	auipc	a0,0x4
ffffffffc0201be6:	e9650513          	addi	a0,a0,-362 # ffffffffc0205a78 <commands+0xb50>
ffffffffc0201bea:	e16fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201bee <default_init>:
    elm->prev = elm->next = elm;
ffffffffc0201bee:	00052797          	auipc	a5,0x52
ffffffffc0201bf2:	96a78793          	addi	a5,a5,-1686 # ffffffffc0253558 <free_area>
ffffffffc0201bf6:	e79c                	sd	a5,8(a5)
ffffffffc0201bf8:	e39c                	sd	a5,0(a5)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
ffffffffc0201bfa:	0007a823          	sw	zero,16(a5)
}
ffffffffc0201bfe:	8082                	ret

ffffffffc0201c00 <default_nr_free_pages>:
}

static size_t
default_nr_free_pages(void) {
    return nr_free;
}
ffffffffc0201c00:	00052517          	auipc	a0,0x52
ffffffffc0201c04:	96856503          	lwu	a0,-1688(a0) # ffffffffc0253568 <free_area+0x10>
ffffffffc0201c08:	8082                	ret

ffffffffc0201c0a <default_check>:
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
ffffffffc0201c0a:	715d                	addi	sp,sp,-80
ffffffffc0201c0c:	e0a2                	sd	s0,64(sp)
    return listelm->next;
ffffffffc0201c0e:	00052417          	auipc	s0,0x52
ffffffffc0201c12:	94a40413          	addi	s0,s0,-1718 # ffffffffc0253558 <free_area>
ffffffffc0201c16:	641c                	ld	a5,8(s0)
ffffffffc0201c18:	e486                	sd	ra,72(sp)
ffffffffc0201c1a:	fc26                	sd	s1,56(sp)
ffffffffc0201c1c:	f84a                	sd	s2,48(sp)
ffffffffc0201c1e:	f44e                	sd	s3,40(sp)
ffffffffc0201c20:	f052                	sd	s4,32(sp)
ffffffffc0201c22:	ec56                	sd	s5,24(sp)
ffffffffc0201c24:	e85a                	sd	s6,16(sp)
ffffffffc0201c26:	e45e                	sd	s7,8(sp)
ffffffffc0201c28:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0201c2a:	2a878d63          	beq	a5,s0,ffffffffc0201ee4 <default_check+0x2da>
    int count = 0, total = 0;
ffffffffc0201c2e:	4481                	li	s1,0
ffffffffc0201c30:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0201c32:	ff07b703          	ld	a4,-16(a5)
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0201c36:	8b09                	andi	a4,a4,2
ffffffffc0201c38:	2a070a63          	beqz	a4,ffffffffc0201eec <default_check+0x2e2>
        count ++, total += p->property;
ffffffffc0201c3c:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201c40:	679c                	ld	a5,8(a5)
ffffffffc0201c42:	2905                	addiw	s2,s2,1
ffffffffc0201c44:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0201c46:	fe8796e3          	bne	a5,s0,ffffffffc0201c32 <default_check+0x28>
ffffffffc0201c4a:	89a6                	mv	s3,s1
    }
    assert(total == nr_free_pages());
ffffffffc0201c4c:	337000ef          	jal	ra,ffffffffc0202782 <nr_free_pages>
ffffffffc0201c50:	6f351e63          	bne	a0,s3,ffffffffc020234c <default_check+0x742>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201c54:	4505                	li	a0,1
ffffffffc0201c56:	259000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201c5a:	8aaa                	mv	s5,a0
ffffffffc0201c5c:	42050863          	beqz	a0,ffffffffc020208c <default_check+0x482>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201c60:	4505                	li	a0,1
ffffffffc0201c62:	24d000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201c66:	89aa                	mv	s3,a0
ffffffffc0201c68:	70050263          	beqz	a0,ffffffffc020236c <default_check+0x762>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201c6c:	4505                	li	a0,1
ffffffffc0201c6e:	241000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201c72:	8a2a                	mv	s4,a0
ffffffffc0201c74:	48050c63          	beqz	a0,ffffffffc020210c <default_check+0x502>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201c78:	293a8a63          	beq	s5,s3,ffffffffc0201f0c <default_check+0x302>
ffffffffc0201c7c:	28aa8863          	beq	s5,a0,ffffffffc0201f0c <default_check+0x302>
ffffffffc0201c80:	28a98663          	beq	s3,a0,ffffffffc0201f0c <default_check+0x302>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201c84:	000aa783          	lw	a5,0(s5)
ffffffffc0201c88:	2a079263          	bnez	a5,ffffffffc0201f2c <default_check+0x322>
ffffffffc0201c8c:	0009a783          	lw	a5,0(s3)
ffffffffc0201c90:	28079e63          	bnez	a5,ffffffffc0201f2c <default_check+0x322>
ffffffffc0201c94:	411c                	lw	a5,0(a0)
ffffffffc0201c96:	28079b63          	bnez	a5,ffffffffc0201f2c <default_check+0x322>
    return page - pages + nbase;
ffffffffc0201c9a:	00052797          	auipc	a5,0x52
ffffffffc0201c9e:	8ee7b783          	ld	a5,-1810(a5) # ffffffffc0253588 <pages>
ffffffffc0201ca2:	40fa8733          	sub	a4,s5,a5
ffffffffc0201ca6:	00005617          	auipc	a2,0x5
ffffffffc0201caa:	4ea63603          	ld	a2,1258(a2) # ffffffffc0207190 <nbase>
ffffffffc0201cae:	8719                	srai	a4,a4,0x6
ffffffffc0201cb0:	9732                	add	a4,a4,a2
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201cb2:	00051697          	auipc	a3,0x51
ffffffffc0201cb6:	7866b683          	ld	a3,1926(a3) # ffffffffc0253438 <npage>
ffffffffc0201cba:	06b2                	slli	a3,a3,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0201cbc:	0732                	slli	a4,a4,0xc
ffffffffc0201cbe:	28d77763          	bgeu	a4,a3,ffffffffc0201f4c <default_check+0x342>
    return page - pages + nbase;
ffffffffc0201cc2:	40f98733          	sub	a4,s3,a5
ffffffffc0201cc6:	8719                	srai	a4,a4,0x6
ffffffffc0201cc8:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0201cca:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201ccc:	4cd77063          	bgeu	a4,a3,ffffffffc020218c <default_check+0x582>
    return page - pages + nbase;
ffffffffc0201cd0:	40f507b3          	sub	a5,a0,a5
ffffffffc0201cd4:	8799                	srai	a5,a5,0x6
ffffffffc0201cd6:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0201cd8:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0201cda:	30d7f963          	bgeu	a5,a3,ffffffffc0201fec <default_check+0x3e2>
    assert(alloc_page() == NULL);
ffffffffc0201cde:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0201ce0:	00043c03          	ld	s8,0(s0)
ffffffffc0201ce4:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc0201ce8:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc0201cec:	e400                	sd	s0,8(s0)
ffffffffc0201cee:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc0201cf0:	00052797          	auipc	a5,0x52
ffffffffc0201cf4:	8607ac23          	sw	zero,-1928(a5) # ffffffffc0253568 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc0201cf8:	1b7000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201cfc:	2c051863          	bnez	a0,ffffffffc0201fcc <default_check+0x3c2>
    free_page(p0);
ffffffffc0201d00:	4585                	li	a1,1
ffffffffc0201d02:	8556                	mv	a0,s5
ffffffffc0201d04:	23d000ef          	jal	ra,ffffffffc0202740 <free_pages>
    free_page(p1);
ffffffffc0201d08:	4585                	li	a1,1
ffffffffc0201d0a:	854e                	mv	a0,s3
ffffffffc0201d0c:	235000ef          	jal	ra,ffffffffc0202740 <free_pages>
    free_page(p2);
ffffffffc0201d10:	4585                	li	a1,1
ffffffffc0201d12:	8552                	mv	a0,s4
ffffffffc0201d14:	22d000ef          	jal	ra,ffffffffc0202740 <free_pages>
    assert(nr_free == 3);
ffffffffc0201d18:	4818                	lw	a4,16(s0)
ffffffffc0201d1a:	478d                	li	a5,3
ffffffffc0201d1c:	28f71863          	bne	a4,a5,ffffffffc0201fac <default_check+0x3a2>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201d20:	4505                	li	a0,1
ffffffffc0201d22:	18d000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201d26:	89aa                	mv	s3,a0
ffffffffc0201d28:	26050263          	beqz	a0,ffffffffc0201f8c <default_check+0x382>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201d2c:	4505                	li	a0,1
ffffffffc0201d2e:	181000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201d32:	8aaa                	mv	s5,a0
ffffffffc0201d34:	3a050c63          	beqz	a0,ffffffffc02020ec <default_check+0x4e2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201d38:	4505                	li	a0,1
ffffffffc0201d3a:	175000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201d3e:	8a2a                	mv	s4,a0
ffffffffc0201d40:	38050663          	beqz	a0,ffffffffc02020cc <default_check+0x4c2>
    assert(alloc_page() == NULL);
ffffffffc0201d44:	4505                	li	a0,1
ffffffffc0201d46:	169000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201d4a:	36051163          	bnez	a0,ffffffffc02020ac <default_check+0x4a2>
    free_page(p0);
ffffffffc0201d4e:	4585                	li	a1,1
ffffffffc0201d50:	854e                	mv	a0,s3
ffffffffc0201d52:	1ef000ef          	jal	ra,ffffffffc0202740 <free_pages>
    assert(!list_empty(&free_list));
ffffffffc0201d56:	641c                	ld	a5,8(s0)
ffffffffc0201d58:	20878a63          	beq	a5,s0,ffffffffc0201f6c <default_check+0x362>
    assert((p = alloc_page()) == p0);
ffffffffc0201d5c:	4505                	li	a0,1
ffffffffc0201d5e:	151000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201d62:	30a99563          	bne	s3,a0,ffffffffc020206c <default_check+0x462>
    assert(alloc_page() == NULL);
ffffffffc0201d66:	4505                	li	a0,1
ffffffffc0201d68:	147000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201d6c:	2e051063          	bnez	a0,ffffffffc020204c <default_check+0x442>
    assert(nr_free == 0);
ffffffffc0201d70:	481c                	lw	a5,16(s0)
ffffffffc0201d72:	2a079d63          	bnez	a5,ffffffffc020202c <default_check+0x422>
    free_page(p);
ffffffffc0201d76:	854e                	mv	a0,s3
ffffffffc0201d78:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0201d7a:	01843023          	sd	s8,0(s0)
ffffffffc0201d7e:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc0201d82:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc0201d86:	1bb000ef          	jal	ra,ffffffffc0202740 <free_pages>
    free_page(p1);
ffffffffc0201d8a:	4585                	li	a1,1
ffffffffc0201d8c:	8556                	mv	a0,s5
ffffffffc0201d8e:	1b3000ef          	jal	ra,ffffffffc0202740 <free_pages>
    free_page(p2);
ffffffffc0201d92:	4585                	li	a1,1
ffffffffc0201d94:	8552                	mv	a0,s4
ffffffffc0201d96:	1ab000ef          	jal	ra,ffffffffc0202740 <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc0201d9a:	4515                	li	a0,5
ffffffffc0201d9c:	113000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201da0:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc0201da2:	26050563          	beqz	a0,ffffffffc020200c <default_check+0x402>
ffffffffc0201da6:	651c                	ld	a5,8(a0)
ffffffffc0201da8:	8385                	srli	a5,a5,0x1
ffffffffc0201daa:	8b85                	andi	a5,a5,1
    assert(!PageProperty(p0));
ffffffffc0201dac:	54079063          	bnez	a5,ffffffffc02022ec <default_check+0x6e2>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc0201db0:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0201db2:	00043b03          	ld	s6,0(s0)
ffffffffc0201db6:	00843a83          	ld	s5,8(s0)
ffffffffc0201dba:	e000                	sd	s0,0(s0)
ffffffffc0201dbc:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc0201dbe:	0f1000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201dc2:	50051563          	bnez	a0,ffffffffc02022cc <default_check+0x6c2>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc0201dc6:	08098a13          	addi	s4,s3,128
ffffffffc0201dca:	8552                	mv	a0,s4
ffffffffc0201dcc:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc0201dce:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc0201dd2:	00051797          	auipc	a5,0x51
ffffffffc0201dd6:	7807ab23          	sw	zero,1942(a5) # ffffffffc0253568 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc0201dda:	167000ef          	jal	ra,ffffffffc0202740 <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc0201dde:	4511                	li	a0,4
ffffffffc0201de0:	0cf000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201de4:	4c051463          	bnez	a0,ffffffffc02022ac <default_check+0x6a2>
ffffffffc0201de8:	0889b783          	ld	a5,136(s3)
ffffffffc0201dec:	8385                	srli	a5,a5,0x1
ffffffffc0201dee:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0201df0:	48078e63          	beqz	a5,ffffffffc020228c <default_check+0x682>
ffffffffc0201df4:	0909a703          	lw	a4,144(s3)
ffffffffc0201df8:	478d                	li	a5,3
ffffffffc0201dfa:	48f71963          	bne	a4,a5,ffffffffc020228c <default_check+0x682>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201dfe:	450d                	li	a0,3
ffffffffc0201e00:	0af000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201e04:	8c2a                	mv	s8,a0
ffffffffc0201e06:	46050363          	beqz	a0,ffffffffc020226c <default_check+0x662>
    assert(alloc_page() == NULL);
ffffffffc0201e0a:	4505                	li	a0,1
ffffffffc0201e0c:	0a3000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201e10:	42051e63          	bnez	a0,ffffffffc020224c <default_check+0x642>
    assert(p0 + 2 == p1);
ffffffffc0201e14:	418a1c63          	bne	s4,s8,ffffffffc020222c <default_check+0x622>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc0201e18:	4585                	li	a1,1
ffffffffc0201e1a:	854e                	mv	a0,s3
ffffffffc0201e1c:	125000ef          	jal	ra,ffffffffc0202740 <free_pages>
    free_pages(p1, 3);
ffffffffc0201e20:	458d                	li	a1,3
ffffffffc0201e22:	8552                	mv	a0,s4
ffffffffc0201e24:	11d000ef          	jal	ra,ffffffffc0202740 <free_pages>
ffffffffc0201e28:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0201e2c:	04098c13          	addi	s8,s3,64
ffffffffc0201e30:	8385                	srli	a5,a5,0x1
ffffffffc0201e32:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201e34:	3c078c63          	beqz	a5,ffffffffc020220c <default_check+0x602>
ffffffffc0201e38:	0109a703          	lw	a4,16(s3)
ffffffffc0201e3c:	4785                	li	a5,1
ffffffffc0201e3e:	3cf71763          	bne	a4,a5,ffffffffc020220c <default_check+0x602>
ffffffffc0201e42:	008a3783          	ld	a5,8(s4) # 1008 <_binary_obj___user_ex1_out_size-0x8940>
ffffffffc0201e46:	8385                	srli	a5,a5,0x1
ffffffffc0201e48:	8b85                	andi	a5,a5,1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0201e4a:	3a078163          	beqz	a5,ffffffffc02021ec <default_check+0x5e2>
ffffffffc0201e4e:	010a2703          	lw	a4,16(s4)
ffffffffc0201e52:	478d                	li	a5,3
ffffffffc0201e54:	38f71c63          	bne	a4,a5,ffffffffc02021ec <default_check+0x5e2>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0201e58:	4505                	li	a0,1
ffffffffc0201e5a:	055000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201e5e:	36a99763          	bne	s3,a0,ffffffffc02021cc <default_check+0x5c2>
    free_page(p0);
ffffffffc0201e62:	4585                	li	a1,1
ffffffffc0201e64:	0dd000ef          	jal	ra,ffffffffc0202740 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0201e68:	4509                	li	a0,2
ffffffffc0201e6a:	045000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201e6e:	32aa1f63          	bne	s4,a0,ffffffffc02021ac <default_check+0x5a2>

    free_pages(p0, 2);
ffffffffc0201e72:	4589                	li	a1,2
ffffffffc0201e74:	0cd000ef          	jal	ra,ffffffffc0202740 <free_pages>
    free_page(p2);
ffffffffc0201e78:	4585                	li	a1,1
ffffffffc0201e7a:	8562                	mv	a0,s8
ffffffffc0201e7c:	0c5000ef          	jal	ra,ffffffffc0202740 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0201e80:	4515                	li	a0,5
ffffffffc0201e82:	02d000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201e86:	89aa                	mv	s3,a0
ffffffffc0201e88:	48050263          	beqz	a0,ffffffffc020230c <default_check+0x702>
    assert(alloc_page() == NULL);
ffffffffc0201e8c:	4505                	li	a0,1
ffffffffc0201e8e:	021000ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0201e92:	2c051d63          	bnez	a0,ffffffffc020216c <default_check+0x562>

    assert(nr_free == 0);
ffffffffc0201e96:	481c                	lw	a5,16(s0)
ffffffffc0201e98:	2a079a63          	bnez	a5,ffffffffc020214c <default_check+0x542>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc0201e9c:	4595                	li	a1,5
ffffffffc0201e9e:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc0201ea0:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc0201ea4:	01643023          	sd	s6,0(s0)
ffffffffc0201ea8:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc0201eac:	095000ef          	jal	ra,ffffffffc0202740 <free_pages>
    return listelm->next;
ffffffffc0201eb0:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0201eb2:	00878963          	beq	a5,s0,ffffffffc0201ec4 <default_check+0x2ba>
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
ffffffffc0201eb6:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201eba:	679c                	ld	a5,8(a5)
ffffffffc0201ebc:	397d                	addiw	s2,s2,-1
ffffffffc0201ebe:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0201ec0:	fe879be3          	bne	a5,s0,ffffffffc0201eb6 <default_check+0x2ac>
    }
    assert(count == 0);
ffffffffc0201ec4:	26091463          	bnez	s2,ffffffffc020212c <default_check+0x522>
    assert(total == 0);
ffffffffc0201ec8:	46049263          	bnez	s1,ffffffffc020232c <default_check+0x722>
}
ffffffffc0201ecc:	60a6                	ld	ra,72(sp)
ffffffffc0201ece:	6406                	ld	s0,64(sp)
ffffffffc0201ed0:	74e2                	ld	s1,56(sp)
ffffffffc0201ed2:	7942                	ld	s2,48(sp)
ffffffffc0201ed4:	79a2                	ld	s3,40(sp)
ffffffffc0201ed6:	7a02                	ld	s4,32(sp)
ffffffffc0201ed8:	6ae2                	ld	s5,24(sp)
ffffffffc0201eda:	6b42                	ld	s6,16(sp)
ffffffffc0201edc:	6ba2                	ld	s7,8(sp)
ffffffffc0201ede:	6c02                	ld	s8,0(sp)
ffffffffc0201ee0:	6161                	addi	sp,sp,80
ffffffffc0201ee2:	8082                	ret
    while ((le = list_next(le)) != &free_list) {
ffffffffc0201ee4:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc0201ee6:	4481                	li	s1,0
ffffffffc0201ee8:	4901                	li	s2,0
ffffffffc0201eea:	b38d                	j	ffffffffc0201c4c <default_check+0x42>
        assert(PageProperty(p));
ffffffffc0201eec:	00004697          	auipc	a3,0x4
ffffffffc0201ef0:	ca468693          	addi	a3,a3,-860 # ffffffffc0205b90 <commands+0xc68>
ffffffffc0201ef4:	00003617          	auipc	a2,0x3
ffffffffc0201ef8:	42460613          	addi	a2,a2,1060 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201efc:	0f000593          	li	a1,240
ffffffffc0201f00:	00004517          	auipc	a0,0x4
ffffffffc0201f04:	ca050513          	addi	a0,a0,-864 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0201f08:	af8fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201f0c:	00004697          	auipc	a3,0x4
ffffffffc0201f10:	d2c68693          	addi	a3,a3,-724 # ffffffffc0205c38 <commands+0xd10>
ffffffffc0201f14:	00003617          	auipc	a2,0x3
ffffffffc0201f18:	40460613          	addi	a2,a2,1028 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201f1c:	0bd00593          	li	a1,189
ffffffffc0201f20:	00004517          	auipc	a0,0x4
ffffffffc0201f24:	c8050513          	addi	a0,a0,-896 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0201f28:	ad8fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201f2c:	00004697          	auipc	a3,0x4
ffffffffc0201f30:	d3468693          	addi	a3,a3,-716 # ffffffffc0205c60 <commands+0xd38>
ffffffffc0201f34:	00003617          	auipc	a2,0x3
ffffffffc0201f38:	3e460613          	addi	a2,a2,996 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201f3c:	0be00593          	li	a1,190
ffffffffc0201f40:	00004517          	auipc	a0,0x4
ffffffffc0201f44:	c6050513          	addi	a0,a0,-928 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0201f48:	ab8fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201f4c:	00004697          	auipc	a3,0x4
ffffffffc0201f50:	d5468693          	addi	a3,a3,-684 # ffffffffc0205ca0 <commands+0xd78>
ffffffffc0201f54:	00003617          	auipc	a2,0x3
ffffffffc0201f58:	3c460613          	addi	a2,a2,964 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201f5c:	0c000593          	li	a1,192
ffffffffc0201f60:	00004517          	auipc	a0,0x4
ffffffffc0201f64:	c4050513          	addi	a0,a0,-960 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0201f68:	a98fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201f6c:	00004697          	auipc	a3,0x4
ffffffffc0201f70:	dbc68693          	addi	a3,a3,-580 # ffffffffc0205d28 <commands+0xe00>
ffffffffc0201f74:	00003617          	auipc	a2,0x3
ffffffffc0201f78:	3a460613          	addi	a2,a2,932 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201f7c:	0d900593          	li	a1,217
ffffffffc0201f80:	00004517          	auipc	a0,0x4
ffffffffc0201f84:	c2050513          	addi	a0,a0,-992 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0201f88:	a78fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201f8c:	00004697          	auipc	a3,0x4
ffffffffc0201f90:	c4c68693          	addi	a3,a3,-948 # ffffffffc0205bd8 <commands+0xcb0>
ffffffffc0201f94:	00003617          	auipc	a2,0x3
ffffffffc0201f98:	38460613          	addi	a2,a2,900 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201f9c:	0d200593          	li	a1,210
ffffffffc0201fa0:	00004517          	auipc	a0,0x4
ffffffffc0201fa4:	c0050513          	addi	a0,a0,-1024 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0201fa8:	a58fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(nr_free == 3);
ffffffffc0201fac:	00004697          	auipc	a3,0x4
ffffffffc0201fb0:	d6c68693          	addi	a3,a3,-660 # ffffffffc0205d18 <commands+0xdf0>
ffffffffc0201fb4:	00003617          	auipc	a2,0x3
ffffffffc0201fb8:	36460613          	addi	a2,a2,868 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201fbc:	0d000593          	li	a1,208
ffffffffc0201fc0:	00004517          	auipc	a0,0x4
ffffffffc0201fc4:	be050513          	addi	a0,a0,-1056 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0201fc8:	a38fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201fcc:	00004697          	auipc	a3,0x4
ffffffffc0201fd0:	d3468693          	addi	a3,a3,-716 # ffffffffc0205d00 <commands+0xdd8>
ffffffffc0201fd4:	00003617          	auipc	a2,0x3
ffffffffc0201fd8:	34460613          	addi	a2,a2,836 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201fdc:	0cb00593          	li	a1,203
ffffffffc0201fe0:	00004517          	auipc	a0,0x4
ffffffffc0201fe4:	bc050513          	addi	a0,a0,-1088 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0201fe8:	a18fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0201fec:	00004697          	auipc	a3,0x4
ffffffffc0201ff0:	cf468693          	addi	a3,a3,-780 # ffffffffc0205ce0 <commands+0xdb8>
ffffffffc0201ff4:	00003617          	auipc	a2,0x3
ffffffffc0201ff8:	32460613          	addi	a2,a2,804 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201ffc:	0c200593          	li	a1,194
ffffffffc0202000:	00004517          	auipc	a0,0x4
ffffffffc0202004:	ba050513          	addi	a0,a0,-1120 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202008:	9f8fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(p0 != NULL);
ffffffffc020200c:	00004697          	auipc	a3,0x4
ffffffffc0202010:	d6468693          	addi	a3,a3,-668 # ffffffffc0205d70 <commands+0xe48>
ffffffffc0202014:	00003617          	auipc	a2,0x3
ffffffffc0202018:	30460613          	addi	a2,a2,772 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020201c:	0f800593          	li	a1,248
ffffffffc0202020:	00004517          	auipc	a0,0x4
ffffffffc0202024:	b8050513          	addi	a0,a0,-1152 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202028:	9d8fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(nr_free == 0);
ffffffffc020202c:	00004697          	auipc	a3,0x4
ffffffffc0202030:	d3468693          	addi	a3,a3,-716 # ffffffffc0205d60 <commands+0xe38>
ffffffffc0202034:	00003617          	auipc	a2,0x3
ffffffffc0202038:	2e460613          	addi	a2,a2,740 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020203c:	0df00593          	li	a1,223
ffffffffc0202040:	00004517          	auipc	a0,0x4
ffffffffc0202044:	b6050513          	addi	a0,a0,-1184 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202048:	9b8fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_page() == NULL);
ffffffffc020204c:	00004697          	auipc	a3,0x4
ffffffffc0202050:	cb468693          	addi	a3,a3,-844 # ffffffffc0205d00 <commands+0xdd8>
ffffffffc0202054:	00003617          	auipc	a2,0x3
ffffffffc0202058:	2c460613          	addi	a2,a2,708 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020205c:	0dd00593          	li	a1,221
ffffffffc0202060:	00004517          	auipc	a0,0x4
ffffffffc0202064:	b4050513          	addi	a0,a0,-1216 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202068:	998fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc020206c:	00004697          	auipc	a3,0x4
ffffffffc0202070:	cd468693          	addi	a3,a3,-812 # ffffffffc0205d40 <commands+0xe18>
ffffffffc0202074:	00003617          	auipc	a2,0x3
ffffffffc0202078:	2a460613          	addi	a2,a2,676 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020207c:	0dc00593          	li	a1,220
ffffffffc0202080:	00004517          	auipc	a0,0x4
ffffffffc0202084:	b2050513          	addi	a0,a0,-1248 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202088:	978fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc020208c:	00004697          	auipc	a3,0x4
ffffffffc0202090:	b4c68693          	addi	a3,a3,-1204 # ffffffffc0205bd8 <commands+0xcb0>
ffffffffc0202094:	00003617          	auipc	a2,0x3
ffffffffc0202098:	28460613          	addi	a2,a2,644 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020209c:	0b900593          	li	a1,185
ffffffffc02020a0:	00004517          	auipc	a0,0x4
ffffffffc02020a4:	b0050513          	addi	a0,a0,-1280 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc02020a8:	958fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02020ac:	00004697          	auipc	a3,0x4
ffffffffc02020b0:	c5468693          	addi	a3,a3,-940 # ffffffffc0205d00 <commands+0xdd8>
ffffffffc02020b4:	00003617          	auipc	a2,0x3
ffffffffc02020b8:	26460613          	addi	a2,a2,612 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02020bc:	0d600593          	li	a1,214
ffffffffc02020c0:	00004517          	auipc	a0,0x4
ffffffffc02020c4:	ae050513          	addi	a0,a0,-1312 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc02020c8:	938fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02020cc:	00004697          	auipc	a3,0x4
ffffffffc02020d0:	b4c68693          	addi	a3,a3,-1204 # ffffffffc0205c18 <commands+0xcf0>
ffffffffc02020d4:	00003617          	auipc	a2,0x3
ffffffffc02020d8:	24460613          	addi	a2,a2,580 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02020dc:	0d400593          	li	a1,212
ffffffffc02020e0:	00004517          	auipc	a0,0x4
ffffffffc02020e4:	ac050513          	addi	a0,a0,-1344 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc02020e8:	918fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc02020ec:	00004697          	auipc	a3,0x4
ffffffffc02020f0:	b0c68693          	addi	a3,a3,-1268 # ffffffffc0205bf8 <commands+0xcd0>
ffffffffc02020f4:	00003617          	auipc	a2,0x3
ffffffffc02020f8:	22460613          	addi	a2,a2,548 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02020fc:	0d300593          	li	a1,211
ffffffffc0202100:	00004517          	auipc	a0,0x4
ffffffffc0202104:	aa050513          	addi	a0,a0,-1376 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202108:	8f8fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc020210c:	00004697          	auipc	a3,0x4
ffffffffc0202110:	b0c68693          	addi	a3,a3,-1268 # ffffffffc0205c18 <commands+0xcf0>
ffffffffc0202114:	00003617          	auipc	a2,0x3
ffffffffc0202118:	20460613          	addi	a2,a2,516 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020211c:	0bb00593          	li	a1,187
ffffffffc0202120:	00004517          	auipc	a0,0x4
ffffffffc0202124:	a8050513          	addi	a0,a0,-1408 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202128:	8d8fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(count == 0);
ffffffffc020212c:	00004697          	auipc	a3,0x4
ffffffffc0202130:	d9468693          	addi	a3,a3,-620 # ffffffffc0205ec0 <commands+0xf98>
ffffffffc0202134:	00003617          	auipc	a2,0x3
ffffffffc0202138:	1e460613          	addi	a2,a2,484 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020213c:	12500593          	li	a1,293
ffffffffc0202140:	00004517          	auipc	a0,0x4
ffffffffc0202144:	a6050513          	addi	a0,a0,-1440 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202148:	8b8fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(nr_free == 0);
ffffffffc020214c:	00004697          	auipc	a3,0x4
ffffffffc0202150:	c1468693          	addi	a3,a3,-1004 # ffffffffc0205d60 <commands+0xe38>
ffffffffc0202154:	00003617          	auipc	a2,0x3
ffffffffc0202158:	1c460613          	addi	a2,a2,452 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020215c:	11a00593          	li	a1,282
ffffffffc0202160:	00004517          	auipc	a0,0x4
ffffffffc0202164:	a4050513          	addi	a0,a0,-1472 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202168:	898fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_page() == NULL);
ffffffffc020216c:	00004697          	auipc	a3,0x4
ffffffffc0202170:	b9468693          	addi	a3,a3,-1132 # ffffffffc0205d00 <commands+0xdd8>
ffffffffc0202174:	00003617          	auipc	a2,0x3
ffffffffc0202178:	1a460613          	addi	a2,a2,420 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020217c:	11800593          	li	a1,280
ffffffffc0202180:	00004517          	auipc	a0,0x4
ffffffffc0202184:	a2050513          	addi	a0,a0,-1504 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202188:	878fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc020218c:	00004697          	auipc	a3,0x4
ffffffffc0202190:	b3468693          	addi	a3,a3,-1228 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202194:	00003617          	auipc	a2,0x3
ffffffffc0202198:	18460613          	addi	a2,a2,388 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020219c:	0c100593          	li	a1,193
ffffffffc02021a0:	00004517          	auipc	a0,0x4
ffffffffc02021a4:	a0050513          	addi	a0,a0,-1536 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc02021a8:	858fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc02021ac:	00004697          	auipc	a3,0x4
ffffffffc02021b0:	cd468693          	addi	a3,a3,-812 # ffffffffc0205e80 <commands+0xf58>
ffffffffc02021b4:	00003617          	auipc	a2,0x3
ffffffffc02021b8:	16460613          	addi	a2,a2,356 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02021bc:	11200593          	li	a1,274
ffffffffc02021c0:	00004517          	auipc	a0,0x4
ffffffffc02021c4:	9e050513          	addi	a0,a0,-1568 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc02021c8:	838fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc02021cc:	00004697          	auipc	a3,0x4
ffffffffc02021d0:	c9468693          	addi	a3,a3,-876 # ffffffffc0205e60 <commands+0xf38>
ffffffffc02021d4:	00003617          	auipc	a2,0x3
ffffffffc02021d8:	14460613          	addi	a2,a2,324 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02021dc:	11000593          	li	a1,272
ffffffffc02021e0:	00004517          	auipc	a0,0x4
ffffffffc02021e4:	9c050513          	addi	a0,a0,-1600 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc02021e8:	818fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc02021ec:	00004697          	auipc	a3,0x4
ffffffffc02021f0:	c4c68693          	addi	a3,a3,-948 # ffffffffc0205e38 <commands+0xf10>
ffffffffc02021f4:	00003617          	auipc	a2,0x3
ffffffffc02021f8:	12460613          	addi	a2,a2,292 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02021fc:	10e00593          	li	a1,270
ffffffffc0202200:	00004517          	auipc	a0,0x4
ffffffffc0202204:	9a050513          	addi	a0,a0,-1632 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202208:	ff9fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc020220c:	00004697          	auipc	a3,0x4
ffffffffc0202210:	c0468693          	addi	a3,a3,-1020 # ffffffffc0205e10 <commands+0xee8>
ffffffffc0202214:	00003617          	auipc	a2,0x3
ffffffffc0202218:	10460613          	addi	a2,a2,260 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020221c:	10d00593          	li	a1,269
ffffffffc0202220:	00004517          	auipc	a0,0x4
ffffffffc0202224:	98050513          	addi	a0,a0,-1664 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202228:	fd9fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(p0 + 2 == p1);
ffffffffc020222c:	00004697          	auipc	a3,0x4
ffffffffc0202230:	bd468693          	addi	a3,a3,-1068 # ffffffffc0205e00 <commands+0xed8>
ffffffffc0202234:	00003617          	auipc	a2,0x3
ffffffffc0202238:	0e460613          	addi	a2,a2,228 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020223c:	10800593          	li	a1,264
ffffffffc0202240:	00004517          	auipc	a0,0x4
ffffffffc0202244:	96050513          	addi	a0,a0,-1696 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202248:	fb9fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_page() == NULL);
ffffffffc020224c:	00004697          	auipc	a3,0x4
ffffffffc0202250:	ab468693          	addi	a3,a3,-1356 # ffffffffc0205d00 <commands+0xdd8>
ffffffffc0202254:	00003617          	auipc	a2,0x3
ffffffffc0202258:	0c460613          	addi	a2,a2,196 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020225c:	10700593          	li	a1,263
ffffffffc0202260:	00004517          	auipc	a0,0x4
ffffffffc0202264:	94050513          	addi	a0,a0,-1728 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202268:	f99fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc020226c:	00004697          	auipc	a3,0x4
ffffffffc0202270:	b7468693          	addi	a3,a3,-1164 # ffffffffc0205de0 <commands+0xeb8>
ffffffffc0202274:	00003617          	auipc	a2,0x3
ffffffffc0202278:	0a460613          	addi	a2,a2,164 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020227c:	10600593          	li	a1,262
ffffffffc0202280:	00004517          	auipc	a0,0x4
ffffffffc0202284:	92050513          	addi	a0,a0,-1760 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202288:	f79fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc020228c:	00004697          	auipc	a3,0x4
ffffffffc0202290:	b2468693          	addi	a3,a3,-1244 # ffffffffc0205db0 <commands+0xe88>
ffffffffc0202294:	00003617          	auipc	a2,0x3
ffffffffc0202298:	08460613          	addi	a2,a2,132 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020229c:	10500593          	li	a1,261
ffffffffc02022a0:	00004517          	auipc	a0,0x4
ffffffffc02022a4:	90050513          	addi	a0,a0,-1792 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc02022a8:	f59fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc02022ac:	00004697          	auipc	a3,0x4
ffffffffc02022b0:	aec68693          	addi	a3,a3,-1300 # ffffffffc0205d98 <commands+0xe70>
ffffffffc02022b4:	00003617          	auipc	a2,0x3
ffffffffc02022b8:	06460613          	addi	a2,a2,100 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02022bc:	10400593          	li	a1,260
ffffffffc02022c0:	00004517          	auipc	a0,0x4
ffffffffc02022c4:	8e050513          	addi	a0,a0,-1824 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc02022c8:	f39fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02022cc:	00004697          	auipc	a3,0x4
ffffffffc02022d0:	a3468693          	addi	a3,a3,-1484 # ffffffffc0205d00 <commands+0xdd8>
ffffffffc02022d4:	00003617          	auipc	a2,0x3
ffffffffc02022d8:	04460613          	addi	a2,a2,68 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02022dc:	0fe00593          	li	a1,254
ffffffffc02022e0:	00004517          	auipc	a0,0x4
ffffffffc02022e4:	8c050513          	addi	a0,a0,-1856 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc02022e8:	f19fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(!PageProperty(p0));
ffffffffc02022ec:	00004697          	auipc	a3,0x4
ffffffffc02022f0:	a9468693          	addi	a3,a3,-1388 # ffffffffc0205d80 <commands+0xe58>
ffffffffc02022f4:	00003617          	auipc	a2,0x3
ffffffffc02022f8:	02460613          	addi	a2,a2,36 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02022fc:	0f900593          	li	a1,249
ffffffffc0202300:	00004517          	auipc	a0,0x4
ffffffffc0202304:	8a050513          	addi	a0,a0,-1888 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202308:	ef9fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc020230c:	00004697          	auipc	a3,0x4
ffffffffc0202310:	b9468693          	addi	a3,a3,-1132 # ffffffffc0205ea0 <commands+0xf78>
ffffffffc0202314:	00003617          	auipc	a2,0x3
ffffffffc0202318:	00460613          	addi	a2,a2,4 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020231c:	11700593          	li	a1,279
ffffffffc0202320:	00004517          	auipc	a0,0x4
ffffffffc0202324:	88050513          	addi	a0,a0,-1920 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202328:	ed9fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(total == 0);
ffffffffc020232c:	00004697          	auipc	a3,0x4
ffffffffc0202330:	ba468693          	addi	a3,a3,-1116 # ffffffffc0205ed0 <commands+0xfa8>
ffffffffc0202334:	00003617          	auipc	a2,0x3
ffffffffc0202338:	fe460613          	addi	a2,a2,-28 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020233c:	12600593          	li	a1,294
ffffffffc0202340:	00004517          	auipc	a0,0x4
ffffffffc0202344:	86050513          	addi	a0,a0,-1952 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202348:	eb9fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(total == nr_free_pages());
ffffffffc020234c:	00004697          	auipc	a3,0x4
ffffffffc0202350:	86c68693          	addi	a3,a3,-1940 # ffffffffc0205bb8 <commands+0xc90>
ffffffffc0202354:	00003617          	auipc	a2,0x3
ffffffffc0202358:	fc460613          	addi	a2,a2,-60 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020235c:	0f300593          	li	a1,243
ffffffffc0202360:	00004517          	auipc	a0,0x4
ffffffffc0202364:	84050513          	addi	a0,a0,-1984 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202368:	e99fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc020236c:	00004697          	auipc	a3,0x4
ffffffffc0202370:	88c68693          	addi	a3,a3,-1908 # ffffffffc0205bf8 <commands+0xcd0>
ffffffffc0202374:	00003617          	auipc	a2,0x3
ffffffffc0202378:	fa460613          	addi	a2,a2,-92 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020237c:	0ba00593          	li	a1,186
ffffffffc0202380:	00004517          	auipc	a0,0x4
ffffffffc0202384:	82050513          	addi	a0,a0,-2016 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc0202388:	e79fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc020238c <default_free_pages>:
default_free_pages(struct Page *base, size_t n) {
ffffffffc020238c:	1141                	addi	sp,sp,-16
ffffffffc020238e:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0202390:	12058f63          	beqz	a1,ffffffffc02024ce <default_free_pages+0x142>
    for (; p != base + n; p ++) {
ffffffffc0202394:	00659693          	slli	a3,a1,0x6
ffffffffc0202398:	96aa                	add	a3,a3,a0
ffffffffc020239a:	87aa                	mv	a5,a0
ffffffffc020239c:	02d50263          	beq	a0,a3,ffffffffc02023c0 <default_free_pages+0x34>
ffffffffc02023a0:	6798                	ld	a4,8(a5)
ffffffffc02023a2:	8b05                	andi	a4,a4,1
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02023a4:	10071563          	bnez	a4,ffffffffc02024ae <default_free_pages+0x122>
ffffffffc02023a8:	6798                	ld	a4,8(a5)
ffffffffc02023aa:	8b09                	andi	a4,a4,2
ffffffffc02023ac:	10071163          	bnez	a4,ffffffffc02024ae <default_free_pages+0x122>
        p->flags = 0;
ffffffffc02023b0:	0007b423          	sd	zero,8(a5)
    return page->ref;
}

static inline void
set_page_ref(struct Page *page, int val) {
    page->ref = val;
ffffffffc02023b4:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc02023b8:	04078793          	addi	a5,a5,64
ffffffffc02023bc:	fed792e3          	bne	a5,a3,ffffffffc02023a0 <default_free_pages+0x14>
    base->property = n;
ffffffffc02023c0:	2581                	sext.w	a1,a1
ffffffffc02023c2:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc02023c4:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02023c8:	4789                	li	a5,2
ffffffffc02023ca:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc02023ce:	00051697          	auipc	a3,0x51
ffffffffc02023d2:	18a68693          	addi	a3,a3,394 # ffffffffc0253558 <free_area>
ffffffffc02023d6:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02023d8:	669c                	ld	a5,8(a3)
ffffffffc02023da:	01850613          	addi	a2,a0,24
ffffffffc02023de:	9db9                	addw	a1,a1,a4
ffffffffc02023e0:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc02023e2:	08d78f63          	beq	a5,a3,ffffffffc0202480 <default_free_pages+0xf4>
            struct Page* page = le2page(le, page_link);
ffffffffc02023e6:	fe878713          	addi	a4,a5,-24
ffffffffc02023ea:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc02023ee:	4581                	li	a1,0
            if (base < page) {
ffffffffc02023f0:	00e56a63          	bltu	a0,a4,ffffffffc0202404 <default_free_pages+0x78>
    return listelm->next;
ffffffffc02023f4:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc02023f6:	04d70a63          	beq	a4,a3,ffffffffc020244a <default_free_pages+0xbe>
    for (; p != base + n; p ++) {
ffffffffc02023fa:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc02023fc:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc0202400:	fee57ae3          	bgeu	a0,a4,ffffffffc02023f4 <default_free_pages+0x68>
ffffffffc0202404:	c199                	beqz	a1,ffffffffc020240a <default_free_pages+0x7e>
ffffffffc0202406:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc020240a:	6398                	ld	a4,0(a5)
    prev->next = next->prev = elm;
ffffffffc020240c:	e390                	sd	a2,0(a5)
ffffffffc020240e:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0202410:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202412:	ed18                	sd	a4,24(a0)
    if (le != &free_list) {
ffffffffc0202414:	00d70c63          	beq	a4,a3,ffffffffc020242c <default_free_pages+0xa0>
        if (p + p->property == base) {
ffffffffc0202418:	ff872583          	lw	a1,-8(a4)
        p = le2page(le, page_link);
ffffffffc020241c:	fe870613          	addi	a2,a4,-24
        if (p + p->property == base) {
ffffffffc0202420:	02059793          	slli	a5,a1,0x20
ffffffffc0202424:	83e9                	srli	a5,a5,0x1a
ffffffffc0202426:	97b2                	add	a5,a5,a2
ffffffffc0202428:	02f50b63          	beq	a0,a5,ffffffffc020245e <default_free_pages+0xd2>
ffffffffc020242c:	7118                	ld	a4,32(a0)
    if (le != &free_list) {
ffffffffc020242e:	00d70b63          	beq	a4,a3,ffffffffc0202444 <default_free_pages+0xb8>
        if (base + base->property == p) {
ffffffffc0202432:	4910                	lw	a2,16(a0)
        p = le2page(le, page_link);
ffffffffc0202434:	fe870693          	addi	a3,a4,-24
        if (base + base->property == p) {
ffffffffc0202438:	02061793          	slli	a5,a2,0x20
ffffffffc020243c:	83e9                	srli	a5,a5,0x1a
ffffffffc020243e:	97aa                	add	a5,a5,a0
ffffffffc0202440:	04f68763          	beq	a3,a5,ffffffffc020248e <default_free_pages+0x102>
}
ffffffffc0202444:	60a2                	ld	ra,8(sp)
ffffffffc0202446:	0141                	addi	sp,sp,16
ffffffffc0202448:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc020244a:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc020244c:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc020244e:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0202450:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0202452:	02d70463          	beq	a4,a3,ffffffffc020247a <default_free_pages+0xee>
    prev->next = next->prev = elm;
ffffffffc0202456:	8832                	mv	a6,a2
ffffffffc0202458:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc020245a:	87ba                	mv	a5,a4
ffffffffc020245c:	b745                	j	ffffffffc02023fc <default_free_pages+0x70>
            p->property += base->property;
ffffffffc020245e:	491c                	lw	a5,16(a0)
ffffffffc0202460:	9dbd                	addw	a1,a1,a5
ffffffffc0202462:	feb72c23          	sw	a1,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0202466:	57f5                	li	a5,-3
ffffffffc0202468:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc020246c:	6d0c                	ld	a1,24(a0)
ffffffffc020246e:	711c                	ld	a5,32(a0)
            base = p;
ffffffffc0202470:	8532                	mv	a0,a2
    prev->next = next;
ffffffffc0202472:	e59c                	sd	a5,8(a1)
    next->prev = prev;
ffffffffc0202474:	6718                	ld	a4,8(a4)
ffffffffc0202476:	e38c                	sd	a1,0(a5)
ffffffffc0202478:	bf5d                	j	ffffffffc020242e <default_free_pages+0xa2>
ffffffffc020247a:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list) {
ffffffffc020247c:	873e                	mv	a4,a5
ffffffffc020247e:	bf69                	j	ffffffffc0202418 <default_free_pages+0x8c>
}
ffffffffc0202480:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0202482:	e390                	sd	a2,0(a5)
ffffffffc0202484:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0202486:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202488:	ed1c                	sd	a5,24(a0)
ffffffffc020248a:	0141                	addi	sp,sp,16
ffffffffc020248c:	8082                	ret
            base->property += p->property;
ffffffffc020248e:	ff872783          	lw	a5,-8(a4)
ffffffffc0202492:	ff070693          	addi	a3,a4,-16
ffffffffc0202496:	9e3d                	addw	a2,a2,a5
ffffffffc0202498:	c910                	sw	a2,16(a0)
ffffffffc020249a:	57f5                	li	a5,-3
ffffffffc020249c:	60f6b02f          	amoand.d	zero,a5,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc02024a0:	6314                	ld	a3,0(a4)
ffffffffc02024a2:	671c                	ld	a5,8(a4)
}
ffffffffc02024a4:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc02024a6:	e69c                	sd	a5,8(a3)
    next->prev = prev;
ffffffffc02024a8:	e394                	sd	a3,0(a5)
ffffffffc02024aa:	0141                	addi	sp,sp,16
ffffffffc02024ac:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02024ae:	00004697          	auipc	a3,0x4
ffffffffc02024b2:	a3a68693          	addi	a3,a3,-1478 # ffffffffc0205ee8 <commands+0xfc0>
ffffffffc02024b6:	00003617          	auipc	a2,0x3
ffffffffc02024ba:	e6260613          	addi	a2,a2,-414 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02024be:	08300593          	li	a1,131
ffffffffc02024c2:	00003517          	auipc	a0,0x3
ffffffffc02024c6:	6de50513          	addi	a0,a0,1758 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc02024ca:	d37fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(n > 0);
ffffffffc02024ce:	00004697          	auipc	a3,0x4
ffffffffc02024d2:	a1268693          	addi	a3,a3,-1518 # ffffffffc0205ee0 <commands+0xfb8>
ffffffffc02024d6:	00003617          	auipc	a2,0x3
ffffffffc02024da:	e4260613          	addi	a2,a2,-446 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02024de:	08000593          	li	a1,128
ffffffffc02024e2:	00003517          	auipc	a0,0x3
ffffffffc02024e6:	6be50513          	addi	a0,a0,1726 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc02024ea:	d17fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02024ee <default_alloc_pages>:
    assert(n > 0);
ffffffffc02024ee:	c941                	beqz	a0,ffffffffc020257e <default_alloc_pages+0x90>
    if (n > nr_free) {
ffffffffc02024f0:	00051597          	auipc	a1,0x51
ffffffffc02024f4:	06858593          	addi	a1,a1,104 # ffffffffc0253558 <free_area>
ffffffffc02024f8:	0105a803          	lw	a6,16(a1)
ffffffffc02024fc:	872a                	mv	a4,a0
ffffffffc02024fe:	02081793          	slli	a5,a6,0x20
ffffffffc0202502:	9381                	srli	a5,a5,0x20
ffffffffc0202504:	00a7ee63          	bltu	a5,a0,ffffffffc0202520 <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc0202508:	87ae                	mv	a5,a1
ffffffffc020250a:	a801                	j	ffffffffc020251a <default_alloc_pages+0x2c>
        if (p->property >= n) {
ffffffffc020250c:	ff87a683          	lw	a3,-8(a5)
ffffffffc0202510:	02069613          	slli	a2,a3,0x20
ffffffffc0202514:	9201                	srli	a2,a2,0x20
ffffffffc0202516:	00e67763          	bgeu	a2,a4,ffffffffc0202524 <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc020251a:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list) {
ffffffffc020251c:	feb798e3          	bne	a5,a1,ffffffffc020250c <default_alloc_pages+0x1e>
        return NULL;
ffffffffc0202520:	4501                	li	a0,0
}
ffffffffc0202522:	8082                	ret
    return listelm->prev;
ffffffffc0202524:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc0202528:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc020252c:	fe878513          	addi	a0,a5,-24
    prev->next = next;
ffffffffc0202530:	00070e1b          	sext.w	t3,a4
ffffffffc0202534:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc0202538:	01133023          	sd	a7,0(t1)
        if (page->property > n) {
ffffffffc020253c:	02c77863          	bgeu	a4,a2,ffffffffc020256c <default_alloc_pages+0x7e>
            struct Page *p = page + n;
ffffffffc0202540:	071a                	slli	a4,a4,0x6
ffffffffc0202542:	972a                	add	a4,a4,a0
            p->property = page->property - n;
ffffffffc0202544:	41c686bb          	subw	a3,a3,t3
ffffffffc0202548:	cb14                	sw	a3,16(a4)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc020254a:	00870613          	addi	a2,a4,8
ffffffffc020254e:	4689                	li	a3,2
ffffffffc0202550:	40d6302f          	amoor.d	zero,a3,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0202554:	0088b683          	ld	a3,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc0202558:	01870613          	addi	a2,a4,24
    prev->next = next->prev = elm;
ffffffffc020255c:	0105a803          	lw	a6,16(a1)
ffffffffc0202560:	e290                	sd	a2,0(a3)
ffffffffc0202562:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc0202566:	f314                	sd	a3,32(a4)
    elm->prev = prev;
ffffffffc0202568:	01173c23          	sd	a7,24(a4)
        nr_free -= n;
ffffffffc020256c:	41c8083b          	subw	a6,a6,t3
ffffffffc0202570:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0202574:	5775                	li	a4,-3
ffffffffc0202576:	17c1                	addi	a5,a5,-16
ffffffffc0202578:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc020257c:	8082                	ret
default_alloc_pages(size_t n) {
ffffffffc020257e:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc0202580:	00004697          	auipc	a3,0x4
ffffffffc0202584:	96068693          	addi	a3,a3,-1696 # ffffffffc0205ee0 <commands+0xfb8>
ffffffffc0202588:	00003617          	auipc	a2,0x3
ffffffffc020258c:	d9060613          	addi	a2,a2,-624 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202590:	06200593          	li	a1,98
ffffffffc0202594:	00003517          	auipc	a0,0x3
ffffffffc0202598:	60c50513          	addi	a0,a0,1548 # ffffffffc0205ba0 <commands+0xc78>
default_alloc_pages(size_t n) {
ffffffffc020259c:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc020259e:	c63fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02025a2 <default_init_memmap>:
default_init_memmap(struct Page *base, size_t n) {
ffffffffc02025a2:	1141                	addi	sp,sp,-16
ffffffffc02025a4:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02025a6:	c5f1                	beqz	a1,ffffffffc0202672 <default_init_memmap+0xd0>
    for (; p != base + n; p ++) {
ffffffffc02025a8:	00659693          	slli	a3,a1,0x6
ffffffffc02025ac:	96aa                	add	a3,a3,a0
ffffffffc02025ae:	87aa                	mv	a5,a0
ffffffffc02025b0:	00d50f63          	beq	a0,a3,ffffffffc02025ce <default_init_memmap+0x2c>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc02025b4:	6798                	ld	a4,8(a5)
ffffffffc02025b6:	8b05                	andi	a4,a4,1
        assert(PageReserved(p));
ffffffffc02025b8:	cf49                	beqz	a4,ffffffffc0202652 <default_init_memmap+0xb0>
        p->flags = p->property = 0;
ffffffffc02025ba:	0007a823          	sw	zero,16(a5)
ffffffffc02025be:	0007b423          	sd	zero,8(a5)
ffffffffc02025c2:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc02025c6:	04078793          	addi	a5,a5,64
ffffffffc02025ca:	fed795e3          	bne	a5,a3,ffffffffc02025b4 <default_init_memmap+0x12>
    base->property = n;
ffffffffc02025ce:	2581                	sext.w	a1,a1
ffffffffc02025d0:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02025d2:	4789                	li	a5,2
ffffffffc02025d4:	00850713          	addi	a4,a0,8
ffffffffc02025d8:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc02025dc:	00051697          	auipc	a3,0x51
ffffffffc02025e0:	f7c68693          	addi	a3,a3,-132 # ffffffffc0253558 <free_area>
ffffffffc02025e4:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02025e6:	669c                	ld	a5,8(a3)
ffffffffc02025e8:	01850613          	addi	a2,a0,24
ffffffffc02025ec:	9db9                	addw	a1,a1,a4
ffffffffc02025ee:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc02025f0:	04d78a63          	beq	a5,a3,ffffffffc0202644 <default_init_memmap+0xa2>
            struct Page* page = le2page(le, page_link);
ffffffffc02025f4:	fe878713          	addi	a4,a5,-24
ffffffffc02025f8:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc02025fc:	4581                	li	a1,0
            if (base < page) {
ffffffffc02025fe:	00e56a63          	bltu	a0,a4,ffffffffc0202612 <default_init_memmap+0x70>
    return listelm->next;
ffffffffc0202602:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc0202604:	02d70263          	beq	a4,a3,ffffffffc0202628 <default_init_memmap+0x86>
    for (; p != base + n; p ++) {
ffffffffc0202608:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc020260a:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc020260e:	fee57ae3          	bgeu	a0,a4,ffffffffc0202602 <default_init_memmap+0x60>
ffffffffc0202612:	c199                	beqz	a1,ffffffffc0202618 <default_init_memmap+0x76>
ffffffffc0202614:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0202618:	6398                	ld	a4,0(a5)
}
ffffffffc020261a:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc020261c:	e390                	sd	a2,0(a5)
ffffffffc020261e:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0202620:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202622:	ed18                	sd	a4,24(a0)
ffffffffc0202624:	0141                	addi	sp,sp,16
ffffffffc0202626:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0202628:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc020262a:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc020262c:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc020262e:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0202630:	00d70663          	beq	a4,a3,ffffffffc020263c <default_init_memmap+0x9a>
    prev->next = next->prev = elm;
ffffffffc0202634:	8832                	mv	a6,a2
ffffffffc0202636:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc0202638:	87ba                	mv	a5,a4
ffffffffc020263a:	bfc1                	j	ffffffffc020260a <default_init_memmap+0x68>
}
ffffffffc020263c:	60a2                	ld	ra,8(sp)
ffffffffc020263e:	e290                	sd	a2,0(a3)
ffffffffc0202640:	0141                	addi	sp,sp,16
ffffffffc0202642:	8082                	ret
ffffffffc0202644:	60a2                	ld	ra,8(sp)
ffffffffc0202646:	e390                	sd	a2,0(a5)
ffffffffc0202648:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc020264a:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc020264c:	ed1c                	sd	a5,24(a0)
ffffffffc020264e:	0141                	addi	sp,sp,16
ffffffffc0202650:	8082                	ret
        assert(PageReserved(p));
ffffffffc0202652:	00004697          	auipc	a3,0x4
ffffffffc0202656:	8be68693          	addi	a3,a3,-1858 # ffffffffc0205f10 <commands+0xfe8>
ffffffffc020265a:	00003617          	auipc	a2,0x3
ffffffffc020265e:	cbe60613          	addi	a2,a2,-834 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202662:	04900593          	li	a1,73
ffffffffc0202666:	00003517          	auipc	a0,0x3
ffffffffc020266a:	53a50513          	addi	a0,a0,1338 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc020266e:	b93fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(n > 0);
ffffffffc0202672:	00004697          	auipc	a3,0x4
ffffffffc0202676:	86e68693          	addi	a3,a3,-1938 # ffffffffc0205ee0 <commands+0xfb8>
ffffffffc020267a:	00003617          	auipc	a2,0x3
ffffffffc020267e:	c9e60613          	addi	a2,a2,-866 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202682:	04600593          	li	a1,70
ffffffffc0202686:	00003517          	auipc	a0,0x3
ffffffffc020268a:	51a50513          	addi	a0,a0,1306 # ffffffffc0205ba0 <commands+0xc78>
ffffffffc020268e:	b73fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0202692 <pa2page.part.0>:
pa2page(uintptr_t pa) {
ffffffffc0202692:	1141                	addi	sp,sp,-16
        panic("pa2page called with invalid pa");
ffffffffc0202694:	00003617          	auipc	a2,0x3
ffffffffc0202698:	3a460613          	addi	a2,a2,932 # ffffffffc0205a38 <commands+0xb10>
ffffffffc020269c:	06200593          	li	a1,98
ffffffffc02026a0:	00003517          	auipc	a0,0x3
ffffffffc02026a4:	32850513          	addi	a0,a0,808 # ffffffffc02059c8 <commands+0xaa0>
pa2page(uintptr_t pa) {
ffffffffc02026a8:	e406                	sd	ra,8(sp)
        panic("pa2page called with invalid pa");
ffffffffc02026aa:	b57fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02026ae <alloc_pages>:
    pmm_manager->init_memmap(base, n);
}

// alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE
// memory
struct Page *alloc_pages(size_t n) {
ffffffffc02026ae:	7139                	addi	sp,sp,-64
ffffffffc02026b0:	f426                	sd	s1,40(sp)
ffffffffc02026b2:	f04a                	sd	s2,32(sp)
ffffffffc02026b4:	ec4e                	sd	s3,24(sp)
ffffffffc02026b6:	e852                	sd	s4,16(sp)
ffffffffc02026b8:	e456                	sd	s5,8(sp)
ffffffffc02026ba:	e05a                	sd	s6,0(sp)
ffffffffc02026bc:	fc06                	sd	ra,56(sp)
ffffffffc02026be:	f822                	sd	s0,48(sp)
ffffffffc02026c0:	84aa                	mv	s1,a0
ffffffffc02026c2:	00051917          	auipc	s2,0x51
ffffffffc02026c6:	eae90913          	addi	s2,s2,-338 # ffffffffc0253570 <pmm_manager>
        {
            page = pmm_manager->alloc_pages(n);
        }
        local_intr_restore(intr_flag);

        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc02026ca:	4a05                	li	s4,1
ffffffffc02026cc:	00051a97          	auipc	s5,0x51
ffffffffc02026d0:	d5ca8a93          	addi	s5,s5,-676 # ffffffffc0253428 <swap_init_ok>

        extern struct mm_struct *check_mm_struct;
        // cprintf("page %x, call swap_out in alloc_pages %d\n",page, n);
        swap_out(check_mm_struct, n, 0);
ffffffffc02026d4:	0005099b          	sext.w	s3,a0
ffffffffc02026d8:	00051b17          	auipc	s6,0x51
ffffffffc02026dc:	da0b0b13          	addi	s6,s6,-608 # ffffffffc0253478 <check_mm_struct>
ffffffffc02026e0:	a01d                	j	ffffffffc0202706 <alloc_pages+0x58>
            page = pmm_manager->alloc_pages(n);
ffffffffc02026e2:	00093783          	ld	a5,0(s2)
ffffffffc02026e6:	6f9c                	ld	a5,24(a5)
ffffffffc02026e8:	9782                	jalr	a5
ffffffffc02026ea:	842a                	mv	s0,a0
        swap_out(check_mm_struct, n, 0);
ffffffffc02026ec:	4601                	li	a2,0
ffffffffc02026ee:	85ce                	mv	a1,s3
        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc02026f0:	ec0d                	bnez	s0,ffffffffc020272a <alloc_pages+0x7c>
ffffffffc02026f2:	029a6c63          	bltu	s4,s1,ffffffffc020272a <alloc_pages+0x7c>
ffffffffc02026f6:	000aa783          	lw	a5,0(s5)
ffffffffc02026fa:	2781                	sext.w	a5,a5
ffffffffc02026fc:	c79d                	beqz	a5,ffffffffc020272a <alloc_pages+0x7c>
        swap_out(check_mm_struct, n, 0);
ffffffffc02026fe:	000b3503          	ld	a0,0(s6)
ffffffffc0202702:	b5eff0ef          	jal	ra,ffffffffc0201a60 <swap_out>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202706:	100027f3          	csrr	a5,sstatus
ffffffffc020270a:	8b89                	andi	a5,a5,2
            page = pmm_manager->alloc_pages(n);
ffffffffc020270c:	8526                	mv	a0,s1
ffffffffc020270e:	dbf1                	beqz	a5,ffffffffc02026e2 <alloc_pages+0x34>
        intr_disable();
ffffffffc0202710:	eeffd0ef          	jal	ra,ffffffffc02005fe <intr_disable>
ffffffffc0202714:	00093783          	ld	a5,0(s2)
ffffffffc0202718:	8526                	mv	a0,s1
ffffffffc020271a:	6f9c                	ld	a5,24(a5)
ffffffffc020271c:	9782                	jalr	a5
ffffffffc020271e:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202720:	ed9fd0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
        swap_out(check_mm_struct, n, 0);
ffffffffc0202724:	4601                	li	a2,0
ffffffffc0202726:	85ce                	mv	a1,s3
        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc0202728:	d469                	beqz	s0,ffffffffc02026f2 <alloc_pages+0x44>
    }
    // cprintf("n %d,get page %x, No %d in alloc_pages\n",n,page,(page-pages));
    return page;
}
ffffffffc020272a:	70e2                	ld	ra,56(sp)
ffffffffc020272c:	8522                	mv	a0,s0
ffffffffc020272e:	7442                	ld	s0,48(sp)
ffffffffc0202730:	74a2                	ld	s1,40(sp)
ffffffffc0202732:	7902                	ld	s2,32(sp)
ffffffffc0202734:	69e2                	ld	s3,24(sp)
ffffffffc0202736:	6a42                	ld	s4,16(sp)
ffffffffc0202738:	6aa2                	ld	s5,8(sp)
ffffffffc020273a:	6b02                	ld	s6,0(sp)
ffffffffc020273c:	6121                	addi	sp,sp,64
ffffffffc020273e:	8082                	ret

ffffffffc0202740 <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202740:	100027f3          	csrr	a5,sstatus
ffffffffc0202744:	8b89                	andi	a5,a5,2
ffffffffc0202746:	eb81                	bnez	a5,ffffffffc0202756 <free_pages+0x16>
// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0202748:	00051797          	auipc	a5,0x51
ffffffffc020274c:	e287b783          	ld	a5,-472(a5) # ffffffffc0253570 <pmm_manager>
ffffffffc0202750:	0207b303          	ld	t1,32(a5)
ffffffffc0202754:	8302                	jr	t1
void free_pages(struct Page *base, size_t n) {
ffffffffc0202756:	1101                	addi	sp,sp,-32
ffffffffc0202758:	ec06                	sd	ra,24(sp)
ffffffffc020275a:	e822                	sd	s0,16(sp)
ffffffffc020275c:	e426                	sd	s1,8(sp)
ffffffffc020275e:	842a                	mv	s0,a0
ffffffffc0202760:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc0202762:	e9dfd0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202766:	00051797          	auipc	a5,0x51
ffffffffc020276a:	e0a7b783          	ld	a5,-502(a5) # ffffffffc0253570 <pmm_manager>
ffffffffc020276e:	739c                	ld	a5,32(a5)
ffffffffc0202770:	85a6                	mv	a1,s1
ffffffffc0202772:	8522                	mv	a0,s0
ffffffffc0202774:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc0202776:	6442                	ld	s0,16(sp)
ffffffffc0202778:	60e2                	ld	ra,24(sp)
ffffffffc020277a:	64a2                	ld	s1,8(sp)
ffffffffc020277c:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc020277e:	e7bfd06f          	j	ffffffffc02005f8 <intr_enable>

ffffffffc0202782 <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202782:	100027f3          	csrr	a5,sstatus
ffffffffc0202786:	8b89                	andi	a5,a5,2
ffffffffc0202788:	eb81                	bnez	a5,ffffffffc0202798 <nr_free_pages+0x16>
size_t nr_free_pages(void) {
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc020278a:	00051797          	auipc	a5,0x51
ffffffffc020278e:	de67b783          	ld	a5,-538(a5) # ffffffffc0253570 <pmm_manager>
ffffffffc0202792:	0287b303          	ld	t1,40(a5)
ffffffffc0202796:	8302                	jr	t1
size_t nr_free_pages(void) {
ffffffffc0202798:	1141                	addi	sp,sp,-16
ffffffffc020279a:	e406                	sd	ra,8(sp)
ffffffffc020279c:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc020279e:	e61fd0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc02027a2:	00051797          	auipc	a5,0x51
ffffffffc02027a6:	dce7b783          	ld	a5,-562(a5) # ffffffffc0253570 <pmm_manager>
ffffffffc02027aa:	779c                	ld	a5,40(a5)
ffffffffc02027ac:	9782                	jalr	a5
ffffffffc02027ae:	842a                	mv	s0,a0
        intr_enable();
ffffffffc02027b0:	e49fd0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc02027b4:	60a2                	ld	ra,8(sp)
ffffffffc02027b6:	8522                	mv	a0,s0
ffffffffc02027b8:	6402                	ld	s0,0(sp)
ffffffffc02027ba:	0141                	addi	sp,sp,16
ffffffffc02027bc:	8082                	ret

ffffffffc02027be <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc02027be:	00003797          	auipc	a5,0x3
ffffffffc02027c2:	77a78793          	addi	a5,a5,1914 # ffffffffc0205f38 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc02027c6:	638c                	ld	a1,0(a5)
}

// pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup
// paging mechanism
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void pmm_init(void) {
ffffffffc02027c8:	1101                	addi	sp,sp,-32
ffffffffc02027ca:	e426                	sd	s1,8(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc02027cc:	00003517          	auipc	a0,0x3
ffffffffc02027d0:	7a450513          	addi	a0,a0,1956 # ffffffffc0205f70 <default_pmm_manager+0x38>
    pmm_manager = &default_pmm_manager;
ffffffffc02027d4:	00051497          	auipc	s1,0x51
ffffffffc02027d8:	d9c48493          	addi	s1,s1,-612 # ffffffffc0253570 <pmm_manager>
void pmm_init(void) {
ffffffffc02027dc:	ec06                	sd	ra,24(sp)
ffffffffc02027de:	e822                	sd	s0,16(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc02027e0:	e09c                	sd	a5,0(s1)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc02027e2:	8e3fd0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    pmm_manager->init();
ffffffffc02027e6:	609c                	ld	a5,0(s1)
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc02027e8:	00051417          	auipc	s0,0x51
ffffffffc02027ec:	d9040413          	addi	s0,s0,-624 # ffffffffc0253578 <va_pa_offset>
    pmm_manager->init();
ffffffffc02027f0:	679c                	ld	a5,8(a5)
ffffffffc02027f2:	9782                	jalr	a5
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc02027f4:	57f5                	li	a5,-3
ffffffffc02027f6:	07fa                	slli	a5,a5,0x1e
    cprintf("physcial memory map:\n");
ffffffffc02027f8:	00003517          	auipc	a0,0x3
ffffffffc02027fc:	79050513          	addi	a0,a0,1936 # ffffffffc0205f88 <default_pmm_manager+0x50>
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc0202800:	e01c                	sd	a5,0(s0)
    cprintf("physcial memory map:\n");
ffffffffc0202802:	8c3fd0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  memory: 0x%08lx, [0x%08lx, 0x%08lx].\n", mem_size, mem_begin,
ffffffffc0202806:	44300693          	li	a3,1091
ffffffffc020280a:	06d6                	slli	a3,a3,0x15
ffffffffc020280c:	40100613          	li	a2,1025
ffffffffc0202810:	0656                	slli	a2,a2,0x15
ffffffffc0202812:	088005b7          	lui	a1,0x8800
ffffffffc0202816:	16fd                	addi	a3,a3,-1
ffffffffc0202818:	00003517          	auipc	a0,0x3
ffffffffc020281c:	78850513          	addi	a0,a0,1928 # ffffffffc0205fa0 <default_pmm_manager+0x68>
ffffffffc0202820:	8a5fd0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0202824:	777d                	lui	a4,0xfffff
ffffffffc0202826:	00052797          	auipc	a5,0x52
ffffffffc020282a:	d7978793          	addi	a5,a5,-647 # ffffffffc025459f <end+0xfff>
ffffffffc020282e:	8ff9                	and	a5,a5,a4
    npage = maxpa / PGSIZE;
ffffffffc0202830:	00088737          	lui	a4,0x88
ffffffffc0202834:	60070713          	addi	a4,a4,1536 # 88600 <_binary_obj___user_ex3_out_size+0x7d910>
ffffffffc0202838:	00051597          	auipc	a1,0x51
ffffffffc020283c:	c0058593          	addi	a1,a1,-1024 # ffffffffc0253438 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0202840:	00051617          	auipc	a2,0x51
ffffffffc0202844:	d4860613          	addi	a2,a2,-696 # ffffffffc0253588 <pages>
    npage = maxpa / PGSIZE;
ffffffffc0202848:	e198                	sd	a4,0(a1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc020284a:	e21c                	sd	a5,0(a2)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc020284c:	4701                	li	a4,0
ffffffffc020284e:	4505                	li	a0,1
ffffffffc0202850:	fff80837          	lui	a6,0xfff80
ffffffffc0202854:	a011                	j	ffffffffc0202858 <pmm_init+0x9a>
ffffffffc0202856:	621c                	ld	a5,0(a2)
        SetPageReserved(pages + i);
ffffffffc0202858:	00671693          	slli	a3,a4,0x6
ffffffffc020285c:	97b6                	add	a5,a5,a3
ffffffffc020285e:	07a1                	addi	a5,a5,8
ffffffffc0202860:	40a7b02f          	amoor.d	zero,a0,(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0202864:	0005b883          	ld	a7,0(a1)
ffffffffc0202868:	0705                	addi	a4,a4,1
ffffffffc020286a:	010886b3          	add	a3,a7,a6
ffffffffc020286e:	fed764e3          	bltu	a4,a3,ffffffffc0202856 <pmm_init+0x98>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0202872:	6208                	ld	a0,0(a2)
ffffffffc0202874:	069a                	slli	a3,a3,0x6
ffffffffc0202876:	c02007b7          	lui	a5,0xc0200
ffffffffc020287a:	96aa                	add	a3,a3,a0
ffffffffc020287c:	06f6e263          	bltu	a3,a5,ffffffffc02028e0 <pmm_init+0x122>
ffffffffc0202880:	601c                	ld	a5,0(s0)
    if (freemem < mem_end) {
ffffffffc0202882:	44300593          	li	a1,1091
ffffffffc0202886:	05d6                	slli	a1,a1,0x15
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0202888:	8e9d                	sub	a3,a3,a5
    if (freemem < mem_end) {
ffffffffc020288a:	02b6f363          	bgeu	a3,a1,ffffffffc02028b0 <pmm_init+0xf2>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc020288e:	6785                	lui	a5,0x1
ffffffffc0202890:	17fd                	addi	a5,a5,-1
ffffffffc0202892:	96be                	add	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0202894:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202898:	0717fc63          	bgeu	a5,a7,ffffffffc0202910 <pmm_init+0x152>
    pmm_manager->init_memmap(base, n);
ffffffffc020289c:	6098                	ld	a4,0(s1)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc020289e:	767d                	lui	a2,0xfffff
ffffffffc02028a0:	8ef1                	and	a3,a3,a2
    return &pages[PPN(pa) - nbase];
ffffffffc02028a2:	97c2                	add	a5,a5,a6
    pmm_manager->init_memmap(base, n);
ffffffffc02028a4:	6b18                	ld	a4,16(a4)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc02028a6:	8d95                	sub	a1,a1,a3
ffffffffc02028a8:	079a                	slli	a5,a5,0x6
    pmm_manager->init_memmap(base, n);
ffffffffc02028aa:	81b1                	srli	a1,a1,0xc
ffffffffc02028ac:	953e                	add	a0,a0,a5
ffffffffc02028ae:	9702                	jalr	a4
    // pmm
    //check_alloc_page();

    // create boot_pgdir, an initial page directory(Page Directory Table, PDT)
    extern char boot_page_table_sv39[];
    boot_pgdir = (pte_t*)boot_page_table_sv39;
ffffffffc02028b0:	00007697          	auipc	a3,0x7
ffffffffc02028b4:	75068693          	addi	a3,a3,1872 # ffffffffc020a000 <boot_page_table_sv39>
ffffffffc02028b8:	00051797          	auipc	a5,0x51
ffffffffc02028bc:	b6d7bc23          	sd	a3,-1160(a5) # ffffffffc0253430 <boot_pgdir>
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc02028c0:	c02007b7          	lui	a5,0xc0200
ffffffffc02028c4:	02f6ea63          	bltu	a3,a5,ffffffffc02028f8 <pmm_init+0x13a>
ffffffffc02028c8:	601c                	ld	a5,0(s0)
    // check the correctness of the basic virtual memory map.
    //check_boot_pgdir();


    kmalloc_init();
}
ffffffffc02028ca:	6442                	ld	s0,16(sp)
ffffffffc02028cc:	60e2                	ld	ra,24(sp)
ffffffffc02028ce:	64a2                	ld	s1,8(sp)
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc02028d0:	8e9d                	sub	a3,a3,a5
ffffffffc02028d2:	00051797          	auipc	a5,0x51
ffffffffc02028d6:	cad7b723          	sd	a3,-850(a5) # ffffffffc0253580 <boot_cr3>
}
ffffffffc02028da:	6105                	addi	sp,sp,32
    kmalloc_init();
ffffffffc02028dc:	f37fe06f          	j	ffffffffc0201812 <kmalloc_init>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02028e0:	00003617          	auipc	a2,0x3
ffffffffc02028e4:	13060613          	addi	a2,a2,304 # ffffffffc0205a10 <commands+0xae8>
ffffffffc02028e8:	07f00593          	li	a1,127
ffffffffc02028ec:	00003517          	auipc	a0,0x3
ffffffffc02028f0:	6dc50513          	addi	a0,a0,1756 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc02028f4:	90dfd0ef          	jal	ra,ffffffffc0200200 <__panic>
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc02028f8:	00003617          	auipc	a2,0x3
ffffffffc02028fc:	11860613          	addi	a2,a2,280 # ffffffffc0205a10 <commands+0xae8>
ffffffffc0202900:	0c100593          	li	a1,193
ffffffffc0202904:	00003517          	auipc	a0,0x3
ffffffffc0202908:	6c450513          	addi	a0,a0,1732 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc020290c:	8f5fd0ef          	jal	ra,ffffffffc0200200 <__panic>
ffffffffc0202910:	d83ff0ef          	jal	ra,ffffffffc0202692 <pa2page.part.0>

ffffffffc0202914 <get_pte>:
     *   PTE_W           0x002                   // page table/directory entry
     * flags bit : Writeable
     *   PTE_U           0x004                   // page table/directory entry
     * flags bit : User can access
     */
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0202914:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0202918:	1ff7f793          	andi	a5,a5,511
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc020291c:	7139                	addi	sp,sp,-64
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc020291e:	078e                	slli	a5,a5,0x3
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0202920:	f426                	sd	s1,40(sp)
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0202922:	00f504b3          	add	s1,a0,a5
    if (!(*pdep1 & PTE_V)) {
ffffffffc0202926:	6094                	ld	a3,0(s1)
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0202928:	f04a                	sd	s2,32(sp)
ffffffffc020292a:	ec4e                	sd	s3,24(sp)
ffffffffc020292c:	e852                	sd	s4,16(sp)
ffffffffc020292e:	fc06                	sd	ra,56(sp)
ffffffffc0202930:	f822                	sd	s0,48(sp)
ffffffffc0202932:	e456                	sd	s5,8(sp)
ffffffffc0202934:	e05a                	sd	s6,0(sp)
    if (!(*pdep1 & PTE_V)) {
ffffffffc0202936:	0016f793          	andi	a5,a3,1
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc020293a:	892e                	mv	s2,a1
ffffffffc020293c:	89b2                	mv	s3,a2
ffffffffc020293e:	00051a17          	auipc	s4,0x51
ffffffffc0202942:	afaa0a13          	addi	s4,s4,-1286 # ffffffffc0253438 <npage>
    if (!(*pdep1 & PTE_V)) {
ffffffffc0202946:	e7b5                	bnez	a5,ffffffffc02029b2 <get_pte+0x9e>
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL) {
ffffffffc0202948:	12060b63          	beqz	a2,ffffffffc0202a7e <get_pte+0x16a>
ffffffffc020294c:	4505                	li	a0,1
ffffffffc020294e:	d61ff0ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0202952:	842a                	mv	s0,a0
ffffffffc0202954:	12050563          	beqz	a0,ffffffffc0202a7e <get_pte+0x16a>
    return page - pages + nbase;
ffffffffc0202958:	00051b17          	auipc	s6,0x51
ffffffffc020295c:	c30b0b13          	addi	s6,s6,-976 # ffffffffc0253588 <pages>
ffffffffc0202960:	000b3503          	ld	a0,0(s6)
ffffffffc0202964:	00080ab7          	lui	s5,0x80
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202968:	00051a17          	auipc	s4,0x51
ffffffffc020296c:	ad0a0a13          	addi	s4,s4,-1328 # ffffffffc0253438 <npage>
ffffffffc0202970:	40a40533          	sub	a0,s0,a0
ffffffffc0202974:	8519                	srai	a0,a0,0x6
ffffffffc0202976:	9556                	add	a0,a0,s5
ffffffffc0202978:	000a3703          	ld	a4,0(s4)
ffffffffc020297c:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0202980:	4685                	li	a3,1
ffffffffc0202982:	c014                	sw	a3,0(s0)
ffffffffc0202984:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0202986:	0532                	slli	a0,a0,0xc
ffffffffc0202988:	14e7f263          	bgeu	a5,a4,ffffffffc0202acc <get_pte+0x1b8>
ffffffffc020298c:	00051797          	auipc	a5,0x51
ffffffffc0202990:	bec7b783          	ld	a5,-1044(a5) # ffffffffc0253578 <va_pa_offset>
ffffffffc0202994:	6605                	lui	a2,0x1
ffffffffc0202996:	4581                	li	a1,0
ffffffffc0202998:	953e                	add	a0,a0,a5
ffffffffc020299a:	6bf010ef          	jal	ra,ffffffffc0204858 <memset>
    return page - pages + nbase;
ffffffffc020299e:	000b3683          	ld	a3,0(s6)
ffffffffc02029a2:	40d406b3          	sub	a3,s0,a3
ffffffffc02029a6:	8699                	srai	a3,a3,0x6
ffffffffc02029a8:	96d6                	add	a3,a3,s5
  asm volatile("sfence.vm");
}

// construct PTE from a page and permission bits
static inline pte_t pte_create(uintptr_t ppn, int type) {
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc02029aa:	06aa                	slli	a3,a3,0xa
ffffffffc02029ac:	0116e693          	ori	a3,a3,17
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc02029b0:	e094                	sd	a3,0(s1)
    }

    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc02029b2:	77fd                	lui	a5,0xfffff
ffffffffc02029b4:	068a                	slli	a3,a3,0x2
ffffffffc02029b6:	000a3703          	ld	a4,0(s4)
ffffffffc02029ba:	8efd                	and	a3,a3,a5
ffffffffc02029bc:	00c6d793          	srli	a5,a3,0xc
ffffffffc02029c0:	0ce7f163          	bgeu	a5,a4,ffffffffc0202a82 <get_pte+0x16e>
ffffffffc02029c4:	00051a97          	auipc	s5,0x51
ffffffffc02029c8:	bb4a8a93          	addi	s5,s5,-1100 # ffffffffc0253578 <va_pa_offset>
ffffffffc02029cc:	000ab403          	ld	s0,0(s5)
ffffffffc02029d0:	01595793          	srli	a5,s2,0x15
ffffffffc02029d4:	1ff7f793          	andi	a5,a5,511
ffffffffc02029d8:	96a2                	add	a3,a3,s0
ffffffffc02029da:	00379413          	slli	s0,a5,0x3
ffffffffc02029de:	9436                	add	s0,s0,a3
    if (!(*pdep0 & PTE_V)) {
ffffffffc02029e0:	6014                	ld	a3,0(s0)
ffffffffc02029e2:	0016f793          	andi	a5,a3,1
ffffffffc02029e6:	e3ad                	bnez	a5,ffffffffc0202a48 <get_pte+0x134>
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL) {
ffffffffc02029e8:	08098b63          	beqz	s3,ffffffffc0202a7e <get_pte+0x16a>
ffffffffc02029ec:	4505                	li	a0,1
ffffffffc02029ee:	cc1ff0ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc02029f2:	84aa                	mv	s1,a0
ffffffffc02029f4:	c549                	beqz	a0,ffffffffc0202a7e <get_pte+0x16a>
    return page - pages + nbase;
ffffffffc02029f6:	00051b17          	auipc	s6,0x51
ffffffffc02029fa:	b92b0b13          	addi	s6,s6,-1134 # ffffffffc0253588 <pages>
ffffffffc02029fe:	000b3503          	ld	a0,0(s6)
ffffffffc0202a02:	000809b7          	lui	s3,0x80
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202a06:	000a3703          	ld	a4,0(s4)
ffffffffc0202a0a:	40a48533          	sub	a0,s1,a0
ffffffffc0202a0e:	8519                	srai	a0,a0,0x6
ffffffffc0202a10:	954e                	add	a0,a0,s3
ffffffffc0202a12:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0202a16:	4685                	li	a3,1
ffffffffc0202a18:	c094                	sw	a3,0(s1)
ffffffffc0202a1a:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0202a1c:	0532                	slli	a0,a0,0xc
ffffffffc0202a1e:	08e7fa63          	bgeu	a5,a4,ffffffffc0202ab2 <get_pte+0x19e>
ffffffffc0202a22:	000ab783          	ld	a5,0(s5)
ffffffffc0202a26:	6605                	lui	a2,0x1
ffffffffc0202a28:	4581                	li	a1,0
ffffffffc0202a2a:	953e                	add	a0,a0,a5
ffffffffc0202a2c:	62d010ef          	jal	ra,ffffffffc0204858 <memset>
    return page - pages + nbase;
ffffffffc0202a30:	000b3683          	ld	a3,0(s6)
ffffffffc0202a34:	40d486b3          	sub	a3,s1,a3
ffffffffc0202a38:	8699                	srai	a3,a3,0x6
ffffffffc0202a3a:	96ce                	add	a3,a3,s3
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0202a3c:	06aa                	slli	a3,a3,0xa
ffffffffc0202a3e:	0116e693          	ori	a3,a3,17
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0202a42:	e014                	sd	a3,0(s0)
ffffffffc0202a44:	000a3703          	ld	a4,0(s4)
        }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc0202a48:	068a                	slli	a3,a3,0x2
ffffffffc0202a4a:	757d                	lui	a0,0xfffff
ffffffffc0202a4c:	8ee9                	and	a3,a3,a0
ffffffffc0202a4e:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202a52:	04e7f463          	bgeu	a5,a4,ffffffffc0202a9a <get_pte+0x186>
ffffffffc0202a56:	000ab503          	ld	a0,0(s5)
ffffffffc0202a5a:	00c95913          	srli	s2,s2,0xc
ffffffffc0202a5e:	1ff97913          	andi	s2,s2,511
ffffffffc0202a62:	96aa                	add	a3,a3,a0
ffffffffc0202a64:	00391513          	slli	a0,s2,0x3
ffffffffc0202a68:	9536                	add	a0,a0,a3
}
ffffffffc0202a6a:	70e2                	ld	ra,56(sp)
ffffffffc0202a6c:	7442                	ld	s0,48(sp)
ffffffffc0202a6e:	74a2                	ld	s1,40(sp)
ffffffffc0202a70:	7902                	ld	s2,32(sp)
ffffffffc0202a72:	69e2                	ld	s3,24(sp)
ffffffffc0202a74:	6a42                	ld	s4,16(sp)
ffffffffc0202a76:	6aa2                	ld	s5,8(sp)
ffffffffc0202a78:	6b02                	ld	s6,0(sp)
ffffffffc0202a7a:	6121                	addi	sp,sp,64
ffffffffc0202a7c:	8082                	ret
            return NULL;
ffffffffc0202a7e:	4501                	li	a0,0
ffffffffc0202a80:	b7ed                	j	ffffffffc0202a6a <get_pte+0x156>
    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0202a82:	00003617          	auipc	a2,0x3
ffffffffc0202a86:	f1e60613          	addi	a2,a2,-226 # ffffffffc02059a0 <commands+0xa78>
ffffffffc0202a8a:	0fe00593          	li	a1,254
ffffffffc0202a8e:	00003517          	auipc	a0,0x3
ffffffffc0202a92:	53a50513          	addi	a0,a0,1338 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0202a96:	f6afd0ef          	jal	ra,ffffffffc0200200 <__panic>
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc0202a9a:	00003617          	auipc	a2,0x3
ffffffffc0202a9e:	f0660613          	addi	a2,a2,-250 # ffffffffc02059a0 <commands+0xa78>
ffffffffc0202aa2:	10900593          	li	a1,265
ffffffffc0202aa6:	00003517          	auipc	a0,0x3
ffffffffc0202aaa:	52250513          	addi	a0,a0,1314 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0202aae:	f52fd0ef          	jal	ra,ffffffffc0200200 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202ab2:	86aa                	mv	a3,a0
ffffffffc0202ab4:	00003617          	auipc	a2,0x3
ffffffffc0202ab8:	eec60613          	addi	a2,a2,-276 # ffffffffc02059a0 <commands+0xa78>
ffffffffc0202abc:	10600593          	li	a1,262
ffffffffc0202ac0:	00003517          	auipc	a0,0x3
ffffffffc0202ac4:	50850513          	addi	a0,a0,1288 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0202ac8:	f38fd0ef          	jal	ra,ffffffffc0200200 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202acc:	86aa                	mv	a3,a0
ffffffffc0202ace:	00003617          	auipc	a2,0x3
ffffffffc0202ad2:	ed260613          	addi	a2,a2,-302 # ffffffffc02059a0 <commands+0xa78>
ffffffffc0202ad6:	0fa00593          	li	a1,250
ffffffffc0202ada:	00003517          	auipc	a0,0x3
ffffffffc0202ade:	4ee50513          	addi	a0,a0,1262 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0202ae2:	f1efd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0202ae6 <unmap_range>:
        *ptep = 0;                  //(5) clear second page table entry
        tlb_invalidate(pgdir, la);  //(6) flush tlb
    }
}

void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc0202ae6:	711d                	addi	sp,sp,-96
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202ae8:	00c5e7b3          	or	a5,a1,a2
void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc0202aec:	ec86                	sd	ra,88(sp)
ffffffffc0202aee:	e8a2                	sd	s0,80(sp)
ffffffffc0202af0:	e4a6                	sd	s1,72(sp)
ffffffffc0202af2:	e0ca                	sd	s2,64(sp)
ffffffffc0202af4:	fc4e                	sd	s3,56(sp)
ffffffffc0202af6:	f852                	sd	s4,48(sp)
ffffffffc0202af8:	f456                	sd	s5,40(sp)
ffffffffc0202afa:	f05a                	sd	s6,32(sp)
ffffffffc0202afc:	ec5e                	sd	s7,24(sp)
ffffffffc0202afe:	e862                	sd	s8,16(sp)
ffffffffc0202b00:	e466                	sd	s9,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202b02:	17d2                	slli	a5,a5,0x34
ffffffffc0202b04:	ebf1                	bnez	a5,ffffffffc0202bd8 <unmap_range+0xf2>
    assert(USER_ACCESS(start, end));
ffffffffc0202b06:	002007b7          	lui	a5,0x200
ffffffffc0202b0a:	842e                	mv	s0,a1
ffffffffc0202b0c:	0af5e663          	bltu	a1,a5,ffffffffc0202bb8 <unmap_range+0xd2>
ffffffffc0202b10:	8932                	mv	s2,a2
ffffffffc0202b12:	0ac5f363          	bgeu	a1,a2,ffffffffc0202bb8 <unmap_range+0xd2>
ffffffffc0202b16:	4785                	li	a5,1
ffffffffc0202b18:	07fe                	slli	a5,a5,0x1f
ffffffffc0202b1a:	08c7ef63          	bltu	a5,a2,ffffffffc0202bb8 <unmap_range+0xd2>
ffffffffc0202b1e:	89aa                	mv	s3,a0
            continue;
        }
        if (*ptep != 0) {
            page_remove_pte(pgdir, start, ptep);
        }
        start += PGSIZE;
ffffffffc0202b20:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage) {
ffffffffc0202b22:	00051c97          	auipc	s9,0x51
ffffffffc0202b26:	916c8c93          	addi	s9,s9,-1770 # ffffffffc0253438 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc0202b2a:	00051c17          	auipc	s8,0x51
ffffffffc0202b2e:	a5ec0c13          	addi	s8,s8,-1442 # ffffffffc0253588 <pages>
ffffffffc0202b32:	fff80bb7          	lui	s7,0xfff80
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0202b36:	00200b37          	lui	s6,0x200
ffffffffc0202b3a:	ffe00ab7          	lui	s5,0xffe00
        pte_t *ptep = get_pte(pgdir, start, 0);
ffffffffc0202b3e:	4601                	li	a2,0
ffffffffc0202b40:	85a2                	mv	a1,s0
ffffffffc0202b42:	854e                	mv	a0,s3
ffffffffc0202b44:	dd1ff0ef          	jal	ra,ffffffffc0202914 <get_pte>
ffffffffc0202b48:	84aa                	mv	s1,a0
        if (ptep == NULL) {
ffffffffc0202b4a:	cd21                	beqz	a0,ffffffffc0202ba2 <unmap_range+0xbc>
        if (*ptep != 0) {
ffffffffc0202b4c:	611c                	ld	a5,0(a0)
ffffffffc0202b4e:	e38d                	bnez	a5,ffffffffc0202b70 <unmap_range+0x8a>
        start += PGSIZE;
ffffffffc0202b50:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0202b52:	ff2466e3          	bltu	s0,s2,ffffffffc0202b3e <unmap_range+0x58>
}
ffffffffc0202b56:	60e6                	ld	ra,88(sp)
ffffffffc0202b58:	6446                	ld	s0,80(sp)
ffffffffc0202b5a:	64a6                	ld	s1,72(sp)
ffffffffc0202b5c:	6906                	ld	s2,64(sp)
ffffffffc0202b5e:	79e2                	ld	s3,56(sp)
ffffffffc0202b60:	7a42                	ld	s4,48(sp)
ffffffffc0202b62:	7aa2                	ld	s5,40(sp)
ffffffffc0202b64:	7b02                	ld	s6,32(sp)
ffffffffc0202b66:	6be2                	ld	s7,24(sp)
ffffffffc0202b68:	6c42                	ld	s8,16(sp)
ffffffffc0202b6a:	6ca2                	ld	s9,8(sp)
ffffffffc0202b6c:	6125                	addi	sp,sp,96
ffffffffc0202b6e:	8082                	ret
    if (*ptep & PTE_V) {  //(1) check if this page table entry is
ffffffffc0202b70:	0017f713          	andi	a4,a5,1
ffffffffc0202b74:	df71                	beqz	a4,ffffffffc0202b50 <unmap_range+0x6a>
    if (PPN(pa) >= npage) {
ffffffffc0202b76:	000cb703          	ld	a4,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202b7a:	078a                	slli	a5,a5,0x2
ffffffffc0202b7c:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0202b7e:	06e7fd63          	bgeu	a5,a4,ffffffffc0202bf8 <unmap_range+0x112>
    return &pages[PPN(pa) - nbase];
ffffffffc0202b82:	000c3503          	ld	a0,0(s8)
ffffffffc0202b86:	97de                	add	a5,a5,s7
ffffffffc0202b88:	079a                	slli	a5,a5,0x6
ffffffffc0202b8a:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc0202b8c:	411c                	lw	a5,0(a0)
ffffffffc0202b8e:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202b92:	c118                	sw	a4,0(a0)
        if (page_ref(page) ==
ffffffffc0202b94:	cf11                	beqz	a4,ffffffffc0202bb0 <unmap_range+0xca>
        *ptep = 0;                  //(5) clear second page table entry
ffffffffc0202b96:	0004b023          	sd	zero,0(s1)
}

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void tlb_invalidate(pde_t *pgdir, uintptr_t la) {
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202b9a:	12040073          	sfence.vma	s0
        start += PGSIZE;
ffffffffc0202b9e:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0202ba0:	bf4d                	j	ffffffffc0202b52 <unmap_range+0x6c>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0202ba2:	945a                	add	s0,s0,s6
ffffffffc0202ba4:	01547433          	and	s0,s0,s5
    } while (start != 0 && start < end);
ffffffffc0202ba8:	d45d                	beqz	s0,ffffffffc0202b56 <unmap_range+0x70>
ffffffffc0202baa:	f9246ae3          	bltu	s0,s2,ffffffffc0202b3e <unmap_range+0x58>
ffffffffc0202bae:	b765                	j	ffffffffc0202b56 <unmap_range+0x70>
            free_page(page);
ffffffffc0202bb0:	4585                	li	a1,1
ffffffffc0202bb2:	b8fff0ef          	jal	ra,ffffffffc0202740 <free_pages>
ffffffffc0202bb6:	b7c5                	j	ffffffffc0202b96 <unmap_range+0xb0>
    assert(USER_ACCESS(start, end));
ffffffffc0202bb8:	00003697          	auipc	a3,0x3
ffffffffc0202bbc:	45068693          	addi	a3,a3,1104 # ffffffffc0206008 <default_pmm_manager+0xd0>
ffffffffc0202bc0:	00002617          	auipc	a2,0x2
ffffffffc0202bc4:	75860613          	addi	a2,a2,1880 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202bc8:	14100593          	li	a1,321
ffffffffc0202bcc:	00003517          	auipc	a0,0x3
ffffffffc0202bd0:	3fc50513          	addi	a0,a0,1020 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0202bd4:	e2cfd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202bd8:	00003697          	auipc	a3,0x3
ffffffffc0202bdc:	40068693          	addi	a3,a3,1024 # ffffffffc0205fd8 <default_pmm_manager+0xa0>
ffffffffc0202be0:	00002617          	auipc	a2,0x2
ffffffffc0202be4:	73860613          	addi	a2,a2,1848 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202be8:	14000593          	li	a1,320
ffffffffc0202bec:	00003517          	auipc	a0,0x3
ffffffffc0202bf0:	3dc50513          	addi	a0,a0,988 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0202bf4:	e0cfd0ef          	jal	ra,ffffffffc0200200 <__panic>
ffffffffc0202bf8:	a9bff0ef          	jal	ra,ffffffffc0202692 <pa2page.part.0>

ffffffffc0202bfc <exit_range>:
void exit_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc0202bfc:	715d                	addi	sp,sp,-80
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202bfe:	00c5e7b3          	or	a5,a1,a2
void exit_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc0202c02:	e486                	sd	ra,72(sp)
ffffffffc0202c04:	e0a2                	sd	s0,64(sp)
ffffffffc0202c06:	fc26                	sd	s1,56(sp)
ffffffffc0202c08:	f84a                	sd	s2,48(sp)
ffffffffc0202c0a:	f44e                	sd	s3,40(sp)
ffffffffc0202c0c:	f052                	sd	s4,32(sp)
ffffffffc0202c0e:	ec56                	sd	s5,24(sp)
ffffffffc0202c10:	e85a                	sd	s6,16(sp)
ffffffffc0202c12:	e45e                	sd	s7,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202c14:	17d2                	slli	a5,a5,0x34
ffffffffc0202c16:	e3f1                	bnez	a5,ffffffffc0202cda <exit_range+0xde>
    assert(USER_ACCESS(start, end));
ffffffffc0202c18:	002007b7          	lui	a5,0x200
ffffffffc0202c1c:	08f5ef63          	bltu	a1,a5,ffffffffc0202cba <exit_range+0xbe>
ffffffffc0202c20:	89b2                	mv	s3,a2
ffffffffc0202c22:	08c5fc63          	bgeu	a1,a2,ffffffffc0202cba <exit_range+0xbe>
ffffffffc0202c26:	4785                	li	a5,1
    start = ROUNDDOWN(start, PTSIZE);
ffffffffc0202c28:	ffe004b7          	lui	s1,0xffe00
    assert(USER_ACCESS(start, end));
ffffffffc0202c2c:	07fe                	slli	a5,a5,0x1f
    start = ROUNDDOWN(start, PTSIZE);
ffffffffc0202c2e:	8ced                	and	s1,s1,a1
    assert(USER_ACCESS(start, end));
ffffffffc0202c30:	08c7e563          	bltu	a5,a2,ffffffffc0202cba <exit_range+0xbe>
ffffffffc0202c34:	8a2a                	mv	s4,a0
    if (PPN(pa) >= npage) {
ffffffffc0202c36:	00051b17          	auipc	s6,0x51
ffffffffc0202c3a:	802b0b13          	addi	s6,s6,-2046 # ffffffffc0253438 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc0202c3e:	00051b97          	auipc	s7,0x51
ffffffffc0202c42:	94ab8b93          	addi	s7,s7,-1718 # ffffffffc0253588 <pages>
ffffffffc0202c46:	fff80937          	lui	s2,0xfff80
        start += PTSIZE;
ffffffffc0202c4a:	00200ab7          	lui	s5,0x200
ffffffffc0202c4e:	a019                	j	ffffffffc0202c54 <exit_range+0x58>
    } while (start != 0 && start < end);
ffffffffc0202c50:	0334fe63          	bgeu	s1,s3,ffffffffc0202c8c <exit_range+0x90>
        int pde_idx = PDX1(start);
ffffffffc0202c54:	01e4d413          	srli	s0,s1,0x1e
        if (pgdir[pde_idx] & PTE_V) {
ffffffffc0202c58:	1ff47413          	andi	s0,s0,511
ffffffffc0202c5c:	040e                	slli	s0,s0,0x3
ffffffffc0202c5e:	9452                	add	s0,s0,s4
ffffffffc0202c60:	601c                	ld	a5,0(s0)
ffffffffc0202c62:	0017f713          	andi	a4,a5,1
ffffffffc0202c66:	c30d                	beqz	a4,ffffffffc0202c88 <exit_range+0x8c>
    if (PPN(pa) >= npage) {
ffffffffc0202c68:	000b3703          	ld	a4,0(s6)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c6c:	078a                	slli	a5,a5,0x2
ffffffffc0202c6e:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0202c70:	02e7f963          	bgeu	a5,a4,ffffffffc0202ca2 <exit_range+0xa6>
    return &pages[PPN(pa) - nbase];
ffffffffc0202c74:	000bb503          	ld	a0,0(s7)
ffffffffc0202c78:	97ca                	add	a5,a5,s2
ffffffffc0202c7a:	079a                	slli	a5,a5,0x6
            free_page(pde2page(pgdir[pde_idx]));
ffffffffc0202c7c:	4585                	li	a1,1
ffffffffc0202c7e:	953e                	add	a0,a0,a5
ffffffffc0202c80:	ac1ff0ef          	jal	ra,ffffffffc0202740 <free_pages>
            pgdir[pde_idx] = 0;
ffffffffc0202c84:	00043023          	sd	zero,0(s0)
        start += PTSIZE;
ffffffffc0202c88:	94d6                	add	s1,s1,s5
    } while (start != 0 && start < end);
ffffffffc0202c8a:	f0f9                	bnez	s1,ffffffffc0202c50 <exit_range+0x54>
}
ffffffffc0202c8c:	60a6                	ld	ra,72(sp)
ffffffffc0202c8e:	6406                	ld	s0,64(sp)
ffffffffc0202c90:	74e2                	ld	s1,56(sp)
ffffffffc0202c92:	7942                	ld	s2,48(sp)
ffffffffc0202c94:	79a2                	ld	s3,40(sp)
ffffffffc0202c96:	7a02                	ld	s4,32(sp)
ffffffffc0202c98:	6ae2                	ld	s5,24(sp)
ffffffffc0202c9a:	6b42                	ld	s6,16(sp)
ffffffffc0202c9c:	6ba2                	ld	s7,8(sp)
ffffffffc0202c9e:	6161                	addi	sp,sp,80
ffffffffc0202ca0:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0202ca2:	00003617          	auipc	a2,0x3
ffffffffc0202ca6:	d9660613          	addi	a2,a2,-618 # ffffffffc0205a38 <commands+0xb10>
ffffffffc0202caa:	06200593          	li	a1,98
ffffffffc0202cae:	00003517          	auipc	a0,0x3
ffffffffc0202cb2:	d1a50513          	addi	a0,a0,-742 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc0202cb6:	d4afd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc0202cba:	00003697          	auipc	a3,0x3
ffffffffc0202cbe:	34e68693          	addi	a3,a3,846 # ffffffffc0206008 <default_pmm_manager+0xd0>
ffffffffc0202cc2:	00002617          	auipc	a2,0x2
ffffffffc0202cc6:	65660613          	addi	a2,a2,1622 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202cca:	15200593          	li	a1,338
ffffffffc0202cce:	00003517          	auipc	a0,0x3
ffffffffc0202cd2:	2fa50513          	addi	a0,a0,762 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0202cd6:	d2afd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202cda:	00003697          	auipc	a3,0x3
ffffffffc0202cde:	2fe68693          	addi	a3,a3,766 # ffffffffc0205fd8 <default_pmm_manager+0xa0>
ffffffffc0202ce2:	00002617          	auipc	a2,0x2
ffffffffc0202ce6:	63660613          	addi	a2,a2,1590 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202cea:	15100593          	li	a1,337
ffffffffc0202cee:	00003517          	auipc	a0,0x3
ffffffffc0202cf2:	2da50513          	addi	a0,a0,730 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0202cf6:	d0afd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0202cfa <page_insert>:
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc0202cfa:	7179                	addi	sp,sp,-48
ffffffffc0202cfc:	e44e                	sd	s3,8(sp)
ffffffffc0202cfe:	89b2                	mv	s3,a2
ffffffffc0202d00:	f022                	sd	s0,32(sp)
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202d02:	4605                	li	a2,1
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc0202d04:	842e                	mv	s0,a1
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202d06:	85ce                	mv	a1,s3
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc0202d08:	ec26                	sd	s1,24(sp)
ffffffffc0202d0a:	f406                	sd	ra,40(sp)
ffffffffc0202d0c:	e84a                	sd	s2,16(sp)
ffffffffc0202d0e:	e052                	sd	s4,0(sp)
ffffffffc0202d10:	84b6                	mv	s1,a3
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202d12:	c03ff0ef          	jal	ra,ffffffffc0202914 <get_pte>
    if (ptep == NULL) {
ffffffffc0202d16:	cd41                	beqz	a0,ffffffffc0202dae <page_insert+0xb4>
    page->ref += 1;
ffffffffc0202d18:	4014                	lw	a3,0(s0)
    if (*ptep & PTE_V) {
ffffffffc0202d1a:	611c                	ld	a5,0(a0)
ffffffffc0202d1c:	892a                	mv	s2,a0
ffffffffc0202d1e:	0016871b          	addiw	a4,a3,1
ffffffffc0202d22:	c018                	sw	a4,0(s0)
ffffffffc0202d24:	0017f713          	andi	a4,a5,1
ffffffffc0202d28:	eb1d                	bnez	a4,ffffffffc0202d5e <page_insert+0x64>
ffffffffc0202d2a:	00051717          	auipc	a4,0x51
ffffffffc0202d2e:	85e73703          	ld	a4,-1954(a4) # ffffffffc0253588 <pages>
    return page - pages + nbase;
ffffffffc0202d32:	8c19                	sub	s0,s0,a4
ffffffffc0202d34:	000807b7          	lui	a5,0x80
ffffffffc0202d38:	8419                	srai	s0,s0,0x6
ffffffffc0202d3a:	943e                	add	s0,s0,a5
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0202d3c:	042a                	slli	s0,s0,0xa
ffffffffc0202d3e:	8c45                	or	s0,s0,s1
ffffffffc0202d40:	00146413          	ori	s0,s0,1
    *ptep = pte_create(page2ppn(page), PTE_V | perm);
ffffffffc0202d44:	00893023          	sd	s0,0(s2) # fffffffffff80000 <end+0x3fd2ca60>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202d48:	12098073          	sfence.vma	s3
    return 0;
ffffffffc0202d4c:	4501                	li	a0,0
}
ffffffffc0202d4e:	70a2                	ld	ra,40(sp)
ffffffffc0202d50:	7402                	ld	s0,32(sp)
ffffffffc0202d52:	64e2                	ld	s1,24(sp)
ffffffffc0202d54:	6942                	ld	s2,16(sp)
ffffffffc0202d56:	69a2                	ld	s3,8(sp)
ffffffffc0202d58:	6a02                	ld	s4,0(sp)
ffffffffc0202d5a:	6145                	addi	sp,sp,48
ffffffffc0202d5c:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc0202d5e:	078a                	slli	a5,a5,0x2
ffffffffc0202d60:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0202d62:	00050717          	auipc	a4,0x50
ffffffffc0202d66:	6d673703          	ld	a4,1750(a4) # ffffffffc0253438 <npage>
ffffffffc0202d6a:	04e7f463          	bgeu	a5,a4,ffffffffc0202db2 <page_insert+0xb8>
    return &pages[PPN(pa) - nbase];
ffffffffc0202d6e:	00051a17          	auipc	s4,0x51
ffffffffc0202d72:	81aa0a13          	addi	s4,s4,-2022 # ffffffffc0253588 <pages>
ffffffffc0202d76:	000a3703          	ld	a4,0(s4)
ffffffffc0202d7a:	fff80537          	lui	a0,0xfff80
ffffffffc0202d7e:	97aa                	add	a5,a5,a0
ffffffffc0202d80:	079a                	slli	a5,a5,0x6
ffffffffc0202d82:	97ba                	add	a5,a5,a4
        if (p == page) {
ffffffffc0202d84:	00f40a63          	beq	s0,a5,ffffffffc0202d98 <page_insert+0x9e>
    page->ref -= 1;
ffffffffc0202d88:	4394                	lw	a3,0(a5)
ffffffffc0202d8a:	fff6861b          	addiw	a2,a3,-1
ffffffffc0202d8e:	c390                	sw	a2,0(a5)
        if (page_ref(page) ==
ffffffffc0202d90:	c611                	beqz	a2,ffffffffc0202d9c <page_insert+0xa2>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202d92:	12098073          	sfence.vma	s3
}
ffffffffc0202d96:	bf71                	j	ffffffffc0202d32 <page_insert+0x38>
ffffffffc0202d98:	c014                	sw	a3,0(s0)
    return page->ref;
ffffffffc0202d9a:	bf61                	j	ffffffffc0202d32 <page_insert+0x38>
            free_page(page);
ffffffffc0202d9c:	4585                	li	a1,1
ffffffffc0202d9e:	853e                	mv	a0,a5
ffffffffc0202da0:	9a1ff0ef          	jal	ra,ffffffffc0202740 <free_pages>
ffffffffc0202da4:	000a3703          	ld	a4,0(s4)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202da8:	12098073          	sfence.vma	s3
ffffffffc0202dac:	b759                	j	ffffffffc0202d32 <page_insert+0x38>
        return -E_NO_MEM;
ffffffffc0202dae:	5571                	li	a0,-4
ffffffffc0202db0:	bf79                	j	ffffffffc0202d4e <page_insert+0x54>
ffffffffc0202db2:	8e1ff0ef          	jal	ra,ffffffffc0202692 <pa2page.part.0>

ffffffffc0202db6 <copy_range>:
               bool share) {
ffffffffc0202db6:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202db8:	00d667b3          	or	a5,a2,a3
               bool share) {
ffffffffc0202dbc:	f486                	sd	ra,104(sp)
ffffffffc0202dbe:	f0a2                	sd	s0,96(sp)
ffffffffc0202dc0:	eca6                	sd	s1,88(sp)
ffffffffc0202dc2:	e8ca                	sd	s2,80(sp)
ffffffffc0202dc4:	e4ce                	sd	s3,72(sp)
ffffffffc0202dc6:	e0d2                	sd	s4,64(sp)
ffffffffc0202dc8:	fc56                	sd	s5,56(sp)
ffffffffc0202dca:	f85a                	sd	s6,48(sp)
ffffffffc0202dcc:	f45e                	sd	s7,40(sp)
ffffffffc0202dce:	f062                	sd	s8,32(sp)
ffffffffc0202dd0:	ec66                	sd	s9,24(sp)
ffffffffc0202dd2:	e86a                	sd	s10,16(sp)
ffffffffc0202dd4:	e46e                	sd	s11,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202dd6:	17d2                	slli	a5,a5,0x34
ffffffffc0202dd8:	1e079763          	bnez	a5,ffffffffc0202fc6 <copy_range+0x210>
    assert(USER_ACCESS(start, end));
ffffffffc0202ddc:	002007b7          	lui	a5,0x200
ffffffffc0202de0:	8432                	mv	s0,a2
ffffffffc0202de2:	16f66a63          	bltu	a2,a5,ffffffffc0202f56 <copy_range+0x1a0>
ffffffffc0202de6:	8936                	mv	s2,a3
ffffffffc0202de8:	16d67763          	bgeu	a2,a3,ffffffffc0202f56 <copy_range+0x1a0>
ffffffffc0202dec:	4785                	li	a5,1
ffffffffc0202dee:	07fe                	slli	a5,a5,0x1f
ffffffffc0202df0:	16d7e363          	bltu	a5,a3,ffffffffc0202f56 <copy_range+0x1a0>
    return KADDR(page2pa(page));
ffffffffc0202df4:	5b7d                	li	s6,-1
ffffffffc0202df6:	8aaa                	mv	s5,a0
ffffffffc0202df8:	89ae                	mv	s3,a1
        start += PGSIZE;
ffffffffc0202dfa:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage) {
ffffffffc0202dfc:	00050c97          	auipc	s9,0x50
ffffffffc0202e00:	63cc8c93          	addi	s9,s9,1596 # ffffffffc0253438 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc0202e04:	00050c17          	auipc	s8,0x50
ffffffffc0202e08:	784c0c13          	addi	s8,s8,1924 # ffffffffc0253588 <pages>
    return page - pages + nbase;
ffffffffc0202e0c:	00080bb7          	lui	s7,0x80
    return KADDR(page2pa(page));
ffffffffc0202e10:	00cb5b13          	srli	s6,s6,0xc
        pte_t *ptep = get_pte(from, start, 0), *nptep;
ffffffffc0202e14:	4601                	li	a2,0
ffffffffc0202e16:	85a2                	mv	a1,s0
ffffffffc0202e18:	854e                	mv	a0,s3
ffffffffc0202e1a:	afbff0ef          	jal	ra,ffffffffc0202914 <get_pte>
ffffffffc0202e1e:	84aa                	mv	s1,a0
        if (ptep == NULL) {
ffffffffc0202e20:	c175                	beqz	a0,ffffffffc0202f04 <copy_range+0x14e>
        if (*ptep & PTE_V) {
ffffffffc0202e22:	611c                	ld	a5,0(a0)
ffffffffc0202e24:	8b85                	andi	a5,a5,1
ffffffffc0202e26:	e785                	bnez	a5,ffffffffc0202e4e <copy_range+0x98>
        start += PGSIZE;
ffffffffc0202e28:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0202e2a:	ff2465e3          	bltu	s0,s2,ffffffffc0202e14 <copy_range+0x5e>
    return 0;
ffffffffc0202e2e:	4501                	li	a0,0
}
ffffffffc0202e30:	70a6                	ld	ra,104(sp)
ffffffffc0202e32:	7406                	ld	s0,96(sp)
ffffffffc0202e34:	64e6                	ld	s1,88(sp)
ffffffffc0202e36:	6946                	ld	s2,80(sp)
ffffffffc0202e38:	69a6                	ld	s3,72(sp)
ffffffffc0202e3a:	6a06                	ld	s4,64(sp)
ffffffffc0202e3c:	7ae2                	ld	s5,56(sp)
ffffffffc0202e3e:	7b42                	ld	s6,48(sp)
ffffffffc0202e40:	7ba2                	ld	s7,40(sp)
ffffffffc0202e42:	7c02                	ld	s8,32(sp)
ffffffffc0202e44:	6ce2                	ld	s9,24(sp)
ffffffffc0202e46:	6d42                	ld	s10,16(sp)
ffffffffc0202e48:	6da2                	ld	s11,8(sp)
ffffffffc0202e4a:	6165                	addi	sp,sp,112
ffffffffc0202e4c:	8082                	ret
            if ((nptep = get_pte(to, start, 1)) == NULL) {
ffffffffc0202e4e:	4605                	li	a2,1
ffffffffc0202e50:	85a2                	mv	a1,s0
ffffffffc0202e52:	8556                	mv	a0,s5
ffffffffc0202e54:	ac1ff0ef          	jal	ra,ffffffffc0202914 <get_pte>
ffffffffc0202e58:	c161                	beqz	a0,ffffffffc0202f18 <copy_range+0x162>
            uint32_t perm = (*ptep & PTE_USER);
ffffffffc0202e5a:	609c                	ld	a5,0(s1)
    if (!(pte & PTE_V)) {
ffffffffc0202e5c:	0017f713          	andi	a4,a5,1
ffffffffc0202e60:	01f7f493          	andi	s1,a5,31
ffffffffc0202e64:	14070563          	beqz	a4,ffffffffc0202fae <copy_range+0x1f8>
    if (PPN(pa) >= npage) {
ffffffffc0202e68:	000cb683          	ld	a3,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202e6c:	078a                	slli	a5,a5,0x2
ffffffffc0202e6e:	00c7d713          	srli	a4,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0202e72:	12d77263          	bgeu	a4,a3,ffffffffc0202f96 <copy_range+0x1e0>
    return &pages[PPN(pa) - nbase];
ffffffffc0202e76:	000c3783          	ld	a5,0(s8)
ffffffffc0202e7a:	fff806b7          	lui	a3,0xfff80
ffffffffc0202e7e:	9736                	add	a4,a4,a3
ffffffffc0202e80:	071a                	slli	a4,a4,0x6
            struct Page *npage = alloc_page();
ffffffffc0202e82:	4505                	li	a0,1
ffffffffc0202e84:	00e78db3          	add	s11,a5,a4
ffffffffc0202e88:	827ff0ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0202e8c:	8d2a                	mv	s10,a0
            assert(page != NULL);
ffffffffc0202e8e:	0a0d8463          	beqz	s11,ffffffffc0202f36 <copy_range+0x180>
            assert(npage != NULL);
ffffffffc0202e92:	c175                	beqz	a0,ffffffffc0202f76 <copy_range+0x1c0>
    return page - pages + nbase;
ffffffffc0202e94:	000c3703          	ld	a4,0(s8)
    return KADDR(page2pa(page));
ffffffffc0202e98:	000cb603          	ld	a2,0(s9)
    return page - pages + nbase;
ffffffffc0202e9c:	40ed86b3          	sub	a3,s11,a4
ffffffffc0202ea0:	8699                	srai	a3,a3,0x6
ffffffffc0202ea2:	96de                	add	a3,a3,s7
    return KADDR(page2pa(page));
ffffffffc0202ea4:	0166f7b3          	and	a5,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc0202ea8:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202eaa:	06c7fa63          	bgeu	a5,a2,ffffffffc0202f1e <copy_range+0x168>
    return page - pages + nbase;
ffffffffc0202eae:	40e507b3          	sub	a5,a0,a4
    return KADDR(page2pa(page));
ffffffffc0202eb2:	00050717          	auipc	a4,0x50
ffffffffc0202eb6:	6c670713          	addi	a4,a4,1734 # ffffffffc0253578 <va_pa_offset>
ffffffffc0202eba:	6308                	ld	a0,0(a4)
    return page - pages + nbase;
ffffffffc0202ebc:	8799                	srai	a5,a5,0x6
ffffffffc0202ebe:	97de                	add	a5,a5,s7
    return KADDR(page2pa(page));
ffffffffc0202ec0:	0167f733          	and	a4,a5,s6
ffffffffc0202ec4:	00a685b3          	add	a1,a3,a0
    return page2ppn(page) << PGSHIFT;
ffffffffc0202ec8:	07b2                	slli	a5,a5,0xc
    return KADDR(page2pa(page));
ffffffffc0202eca:	04c77963          	bgeu	a4,a2,ffffffffc0202f1c <copy_range+0x166>
            memcpy(kva_dst, kva_src, PGSIZE);
ffffffffc0202ece:	6605                	lui	a2,0x1
ffffffffc0202ed0:	953e                	add	a0,a0,a5
ffffffffc0202ed2:	199010ef          	jal	ra,ffffffffc020486a <memcpy>
            ret = page_insert(to, npage, start, perm);
ffffffffc0202ed6:	86a6                	mv	a3,s1
ffffffffc0202ed8:	8622                	mv	a2,s0
ffffffffc0202eda:	85ea                	mv	a1,s10
ffffffffc0202edc:	8556                	mv	a0,s5
ffffffffc0202ede:	e1dff0ef          	jal	ra,ffffffffc0202cfa <page_insert>
            assert(ret == 0);
ffffffffc0202ee2:	d139                	beqz	a0,ffffffffc0202e28 <copy_range+0x72>
ffffffffc0202ee4:	00003697          	auipc	a3,0x3
ffffffffc0202ee8:	18468693          	addi	a3,a3,388 # ffffffffc0206068 <default_pmm_manager+0x130>
ffffffffc0202eec:	00002617          	auipc	a2,0x2
ffffffffc0202ef0:	42c60613          	addi	a2,a2,1068 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202ef4:	19900593          	li	a1,409
ffffffffc0202ef8:	00003517          	auipc	a0,0x3
ffffffffc0202efc:	0d050513          	addi	a0,a0,208 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0202f00:	b00fd0ef          	jal	ra,ffffffffc0200200 <__panic>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0202f04:	00200637          	lui	a2,0x200
ffffffffc0202f08:	9432                	add	s0,s0,a2
ffffffffc0202f0a:	ffe00637          	lui	a2,0xffe00
ffffffffc0202f0e:	8c71                	and	s0,s0,a2
    } while (start != 0 && start < end);
ffffffffc0202f10:	dc19                	beqz	s0,ffffffffc0202e2e <copy_range+0x78>
ffffffffc0202f12:	f12461e3          	bltu	s0,s2,ffffffffc0202e14 <copy_range+0x5e>
ffffffffc0202f16:	bf21                	j	ffffffffc0202e2e <copy_range+0x78>
                return -E_NO_MEM;
ffffffffc0202f18:	5571                	li	a0,-4
ffffffffc0202f1a:	bf19                	j	ffffffffc0202e30 <copy_range+0x7a>
ffffffffc0202f1c:	86be                	mv	a3,a5
ffffffffc0202f1e:	00003617          	auipc	a2,0x3
ffffffffc0202f22:	a8260613          	addi	a2,a2,-1406 # ffffffffc02059a0 <commands+0xa78>
ffffffffc0202f26:	06900593          	li	a1,105
ffffffffc0202f2a:	00003517          	auipc	a0,0x3
ffffffffc0202f2e:	a9e50513          	addi	a0,a0,-1378 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc0202f32:	acefd0ef          	jal	ra,ffffffffc0200200 <__panic>
            assert(page != NULL);
ffffffffc0202f36:	00003697          	auipc	a3,0x3
ffffffffc0202f3a:	11268693          	addi	a3,a3,274 # ffffffffc0206048 <default_pmm_manager+0x110>
ffffffffc0202f3e:	00002617          	auipc	a2,0x2
ffffffffc0202f42:	3da60613          	addi	a2,a2,986 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202f46:	17e00593          	li	a1,382
ffffffffc0202f4a:	00003517          	auipc	a0,0x3
ffffffffc0202f4e:	07e50513          	addi	a0,a0,126 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0202f52:	aaefd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc0202f56:	00003697          	auipc	a3,0x3
ffffffffc0202f5a:	0b268693          	addi	a3,a3,178 # ffffffffc0206008 <default_pmm_manager+0xd0>
ffffffffc0202f5e:	00002617          	auipc	a2,0x2
ffffffffc0202f62:	3ba60613          	addi	a2,a2,954 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202f66:	16a00593          	li	a1,362
ffffffffc0202f6a:	00003517          	auipc	a0,0x3
ffffffffc0202f6e:	05e50513          	addi	a0,a0,94 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0202f72:	a8efd0ef          	jal	ra,ffffffffc0200200 <__panic>
            assert(npage != NULL);
ffffffffc0202f76:	00003697          	auipc	a3,0x3
ffffffffc0202f7a:	0e268693          	addi	a3,a3,226 # ffffffffc0206058 <default_pmm_manager+0x120>
ffffffffc0202f7e:	00002617          	auipc	a2,0x2
ffffffffc0202f82:	39a60613          	addi	a2,a2,922 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202f86:	17f00593          	li	a1,383
ffffffffc0202f8a:	00003517          	auipc	a0,0x3
ffffffffc0202f8e:	03e50513          	addi	a0,a0,62 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0202f92:	a6efd0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0202f96:	00003617          	auipc	a2,0x3
ffffffffc0202f9a:	aa260613          	addi	a2,a2,-1374 # ffffffffc0205a38 <commands+0xb10>
ffffffffc0202f9e:	06200593          	li	a1,98
ffffffffc0202fa2:	00003517          	auipc	a0,0x3
ffffffffc0202fa6:	a2650513          	addi	a0,a0,-1498 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc0202faa:	a56fd0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("pte2page called with invalid pte");
ffffffffc0202fae:	00003617          	auipc	a2,0x3
ffffffffc0202fb2:	07260613          	addi	a2,a2,114 # ffffffffc0206020 <default_pmm_manager+0xe8>
ffffffffc0202fb6:	07400593          	li	a1,116
ffffffffc0202fba:	00003517          	auipc	a0,0x3
ffffffffc0202fbe:	a0e50513          	addi	a0,a0,-1522 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc0202fc2:	a3efd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202fc6:	00003697          	auipc	a3,0x3
ffffffffc0202fca:	01268693          	addi	a3,a3,18 # ffffffffc0205fd8 <default_pmm_manager+0xa0>
ffffffffc0202fce:	00002617          	auipc	a2,0x2
ffffffffc0202fd2:	34a60613          	addi	a2,a2,842 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202fd6:	16900593          	li	a1,361
ffffffffc0202fda:	00003517          	auipc	a0,0x3
ffffffffc0202fde:	fee50513          	addi	a0,a0,-18 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0202fe2:	a1efd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0202fe6 <tlb_invalidate>:
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202fe6:	12058073          	sfence.vma	a1
}
ffffffffc0202fea:	8082                	ret

ffffffffc0202fec <pgdir_alloc_page>:

// pgdir_alloc_page - call alloc_page & page_insert functions to
//                  - allocate a page size memory & setup an addr map
//                  - pa<->la with linear address la and the PDT pgdir
struct Page *pgdir_alloc_page(pde_t *pgdir, uintptr_t la, uint32_t perm) {
ffffffffc0202fec:	7179                	addi	sp,sp,-48
ffffffffc0202fee:	e84a                	sd	s2,16(sp)
ffffffffc0202ff0:	892a                	mv	s2,a0
    struct Page *page = alloc_page();
ffffffffc0202ff2:	4505                	li	a0,1
struct Page *pgdir_alloc_page(pde_t *pgdir, uintptr_t la, uint32_t perm) {
ffffffffc0202ff4:	f022                	sd	s0,32(sp)
ffffffffc0202ff6:	ec26                	sd	s1,24(sp)
ffffffffc0202ff8:	e44e                	sd	s3,8(sp)
ffffffffc0202ffa:	f406                	sd	ra,40(sp)
ffffffffc0202ffc:	84ae                	mv	s1,a1
ffffffffc0202ffe:	89b2                	mv	s3,a2
    struct Page *page = alloc_page();
ffffffffc0203000:	eaeff0ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc0203004:	842a                	mv	s0,a0
    if (page != NULL) {
ffffffffc0203006:	cd05                	beqz	a0,ffffffffc020303e <pgdir_alloc_page+0x52>
        if (page_insert(pgdir, page, la, perm) != 0) {
ffffffffc0203008:	85aa                	mv	a1,a0
ffffffffc020300a:	86ce                	mv	a3,s3
ffffffffc020300c:	8626                	mv	a2,s1
ffffffffc020300e:	854a                	mv	a0,s2
ffffffffc0203010:	cebff0ef          	jal	ra,ffffffffc0202cfa <page_insert>
ffffffffc0203014:	ed0d                	bnez	a0,ffffffffc020304e <pgdir_alloc_page+0x62>
            free_page(page);
            return NULL;
        }
        if (swap_init_ok) {
ffffffffc0203016:	00050797          	auipc	a5,0x50
ffffffffc020301a:	4127a783          	lw	a5,1042(a5) # ffffffffc0253428 <swap_init_ok>
ffffffffc020301e:	c385                	beqz	a5,ffffffffc020303e <pgdir_alloc_page+0x52>
            if (check_mm_struct != NULL) {
ffffffffc0203020:	00050517          	auipc	a0,0x50
ffffffffc0203024:	45853503          	ld	a0,1112(a0) # ffffffffc0253478 <check_mm_struct>
ffffffffc0203028:	c919                	beqz	a0,ffffffffc020303e <pgdir_alloc_page+0x52>
                swap_map_swappable(check_mm_struct, la, page, 0);
ffffffffc020302a:	4681                	li	a3,0
ffffffffc020302c:	8622                	mv	a2,s0
ffffffffc020302e:	85a6                	mv	a1,s1
ffffffffc0203030:	a23fe0ef          	jal	ra,ffffffffc0201a52 <swap_map_swappable>
                page->pra_vaddr = la;
                assert(page_ref(page) == 1);
ffffffffc0203034:	4018                	lw	a4,0(s0)
                page->pra_vaddr = la;
ffffffffc0203036:	fc04                	sd	s1,56(s0)
                assert(page_ref(page) == 1);
ffffffffc0203038:	4785                	li	a5,1
ffffffffc020303a:	02f71063          	bne	a4,a5,ffffffffc020305a <pgdir_alloc_page+0x6e>
            }
        }
    }

    return page;
}
ffffffffc020303e:	70a2                	ld	ra,40(sp)
ffffffffc0203040:	8522                	mv	a0,s0
ffffffffc0203042:	7402                	ld	s0,32(sp)
ffffffffc0203044:	64e2                	ld	s1,24(sp)
ffffffffc0203046:	6942                	ld	s2,16(sp)
ffffffffc0203048:	69a2                	ld	s3,8(sp)
ffffffffc020304a:	6145                	addi	sp,sp,48
ffffffffc020304c:	8082                	ret
            free_page(page);
ffffffffc020304e:	8522                	mv	a0,s0
ffffffffc0203050:	4585                	li	a1,1
ffffffffc0203052:	eeeff0ef          	jal	ra,ffffffffc0202740 <free_pages>
            return NULL;
ffffffffc0203056:	4401                	li	s0,0
ffffffffc0203058:	b7dd                	j	ffffffffc020303e <pgdir_alloc_page+0x52>
                assert(page_ref(page) == 1);
ffffffffc020305a:	00003697          	auipc	a3,0x3
ffffffffc020305e:	01e68693          	addi	a3,a3,30 # ffffffffc0206078 <default_pmm_manager+0x140>
ffffffffc0203062:	00002617          	auipc	a2,0x2
ffffffffc0203066:	2b660613          	addi	a2,a2,694 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020306a:	1d800593          	li	a1,472
ffffffffc020306e:	00003517          	auipc	a0,0x3
ffffffffc0203072:	f5a50513          	addi	a0,a0,-166 # ffffffffc0205fc8 <default_pmm_manager+0x90>
ffffffffc0203076:	98afd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc020307a <swapfs_init>:
#include <ide.h>
#include <pmm.h>
#include <assert.h>

void
swapfs_init(void) {
ffffffffc020307a:	1141                	addi	sp,sp,-16
    static_assert((PGSIZE % SECTSIZE) == 0);
    if (!ide_device_valid(SWAP_DEV_NO)) {
ffffffffc020307c:	4505                	li	a0,1
swapfs_init(void) {
ffffffffc020307e:	e406                	sd	ra,8(sp)
    if (!ide_device_valid(SWAP_DEV_NO)) {
ffffffffc0203080:	c9afd0ef          	jal	ra,ffffffffc020051a <ide_device_valid>
ffffffffc0203084:	cd01                	beqz	a0,ffffffffc020309c <swapfs_init+0x22>
        panic("swap fs isn't available.\n");
    }
    max_swap_offset = ide_device_size(SWAP_DEV_NO) / (PGSIZE / SECTSIZE);
ffffffffc0203086:	4505                	li	a0,1
ffffffffc0203088:	c98fd0ef          	jal	ra,ffffffffc0200520 <ide_device_size>
}
ffffffffc020308c:	60a2                	ld	ra,8(sp)
    max_swap_offset = ide_device_size(SWAP_DEV_NO) / (PGSIZE / SECTSIZE);
ffffffffc020308e:	810d                	srli	a0,a0,0x3
ffffffffc0203090:	00050797          	auipc	a5,0x50
ffffffffc0203094:	48a7b423          	sd	a0,1160(a5) # ffffffffc0253518 <max_swap_offset>
}
ffffffffc0203098:	0141                	addi	sp,sp,16
ffffffffc020309a:	8082                	ret
        panic("swap fs isn't available.\n");
ffffffffc020309c:	00003617          	auipc	a2,0x3
ffffffffc02030a0:	ff460613          	addi	a2,a2,-12 # ffffffffc0206090 <default_pmm_manager+0x158>
ffffffffc02030a4:	45b5                	li	a1,13
ffffffffc02030a6:	00003517          	auipc	a0,0x3
ffffffffc02030aa:	00a50513          	addi	a0,a0,10 # ffffffffc02060b0 <default_pmm_manager+0x178>
ffffffffc02030ae:	952fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02030b2 <swapfs_read>:

int
swapfs_read(swap_entry_t entry, struct Page *page) {
ffffffffc02030b2:	1141                	addi	sp,sp,-16
ffffffffc02030b4:	e406                	sd	ra,8(sp)
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc02030b6:	00855793          	srli	a5,a0,0x8
ffffffffc02030ba:	cbb1                	beqz	a5,ffffffffc020310e <swapfs_read+0x5c>
ffffffffc02030bc:	00050717          	auipc	a4,0x50
ffffffffc02030c0:	45c73703          	ld	a4,1116(a4) # ffffffffc0253518 <max_swap_offset>
ffffffffc02030c4:	04e7f563          	bgeu	a5,a4,ffffffffc020310e <swapfs_read+0x5c>
    return page - pages + nbase;
ffffffffc02030c8:	00050617          	auipc	a2,0x50
ffffffffc02030cc:	4c063603          	ld	a2,1216(a2) # ffffffffc0253588 <pages>
ffffffffc02030d0:	8d91                	sub	a1,a1,a2
ffffffffc02030d2:	4065d613          	srai	a2,a1,0x6
ffffffffc02030d6:	00004717          	auipc	a4,0x4
ffffffffc02030da:	0ba73703          	ld	a4,186(a4) # ffffffffc0207190 <nbase>
ffffffffc02030de:	963a                	add	a2,a2,a4
    return KADDR(page2pa(page));
ffffffffc02030e0:	00c61713          	slli	a4,a2,0xc
ffffffffc02030e4:	8331                	srli	a4,a4,0xc
ffffffffc02030e6:	00050697          	auipc	a3,0x50
ffffffffc02030ea:	3526b683          	ld	a3,850(a3) # ffffffffc0253438 <npage>
ffffffffc02030ee:	0037959b          	slliw	a1,a5,0x3
    return page2ppn(page) << PGSHIFT;
ffffffffc02030f2:	0632                	slli	a2,a2,0xc
    return KADDR(page2pa(page));
ffffffffc02030f4:	02d77963          	bgeu	a4,a3,ffffffffc0203126 <swapfs_read+0x74>
}
ffffffffc02030f8:	60a2                	ld	ra,8(sp)
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc02030fa:	00050797          	auipc	a5,0x50
ffffffffc02030fe:	47e7b783          	ld	a5,1150(a5) # ffffffffc0253578 <va_pa_offset>
ffffffffc0203102:	46a1                	li	a3,8
ffffffffc0203104:	963e                	add	a2,a2,a5
ffffffffc0203106:	4505                	li	a0,1
}
ffffffffc0203108:	0141                	addi	sp,sp,16
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc020310a:	c1cfd06f          	j	ffffffffc0200526 <ide_read_secs>
ffffffffc020310e:	86aa                	mv	a3,a0
ffffffffc0203110:	00003617          	auipc	a2,0x3
ffffffffc0203114:	fb860613          	addi	a2,a2,-72 # ffffffffc02060c8 <default_pmm_manager+0x190>
ffffffffc0203118:	45d1                	li	a1,20
ffffffffc020311a:	00003517          	auipc	a0,0x3
ffffffffc020311e:	f9650513          	addi	a0,a0,-106 # ffffffffc02060b0 <default_pmm_manager+0x178>
ffffffffc0203122:	8defd0ef          	jal	ra,ffffffffc0200200 <__panic>
ffffffffc0203126:	86b2                	mv	a3,a2
ffffffffc0203128:	06900593          	li	a1,105
ffffffffc020312c:	00003617          	auipc	a2,0x3
ffffffffc0203130:	87460613          	addi	a2,a2,-1932 # ffffffffc02059a0 <commands+0xa78>
ffffffffc0203134:	00003517          	auipc	a0,0x3
ffffffffc0203138:	89450513          	addi	a0,a0,-1900 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc020313c:	8c4fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0203140 <swapfs_write>:

int
swapfs_write(swap_entry_t entry, struct Page *page) {
ffffffffc0203140:	1141                	addi	sp,sp,-16
ffffffffc0203142:	e406                	sd	ra,8(sp)
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc0203144:	00855793          	srli	a5,a0,0x8
ffffffffc0203148:	cbb1                	beqz	a5,ffffffffc020319c <swapfs_write+0x5c>
ffffffffc020314a:	00050717          	auipc	a4,0x50
ffffffffc020314e:	3ce73703          	ld	a4,974(a4) # ffffffffc0253518 <max_swap_offset>
ffffffffc0203152:	04e7f563          	bgeu	a5,a4,ffffffffc020319c <swapfs_write+0x5c>
    return page - pages + nbase;
ffffffffc0203156:	00050617          	auipc	a2,0x50
ffffffffc020315a:	43263603          	ld	a2,1074(a2) # ffffffffc0253588 <pages>
ffffffffc020315e:	8d91                	sub	a1,a1,a2
ffffffffc0203160:	4065d613          	srai	a2,a1,0x6
ffffffffc0203164:	00004717          	auipc	a4,0x4
ffffffffc0203168:	02c73703          	ld	a4,44(a4) # ffffffffc0207190 <nbase>
ffffffffc020316c:	963a                	add	a2,a2,a4
    return KADDR(page2pa(page));
ffffffffc020316e:	00c61713          	slli	a4,a2,0xc
ffffffffc0203172:	8331                	srli	a4,a4,0xc
ffffffffc0203174:	00050697          	auipc	a3,0x50
ffffffffc0203178:	2c46b683          	ld	a3,708(a3) # ffffffffc0253438 <npage>
ffffffffc020317c:	0037959b          	slliw	a1,a5,0x3
    return page2ppn(page) << PGSHIFT;
ffffffffc0203180:	0632                	slli	a2,a2,0xc
    return KADDR(page2pa(page));
ffffffffc0203182:	02d77963          	bgeu	a4,a3,ffffffffc02031b4 <swapfs_write+0x74>
}
ffffffffc0203186:	60a2                	ld	ra,8(sp)
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc0203188:	00050797          	auipc	a5,0x50
ffffffffc020318c:	3f07b783          	ld	a5,1008(a5) # ffffffffc0253578 <va_pa_offset>
ffffffffc0203190:	46a1                	li	a3,8
ffffffffc0203192:	963e                	add	a2,a2,a5
ffffffffc0203194:	4505                	li	a0,1
}
ffffffffc0203196:	0141                	addi	sp,sp,16
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc0203198:	bb2fd06f          	j	ffffffffc020054a <ide_write_secs>
ffffffffc020319c:	86aa                	mv	a3,a0
ffffffffc020319e:	00003617          	auipc	a2,0x3
ffffffffc02031a2:	f2a60613          	addi	a2,a2,-214 # ffffffffc02060c8 <default_pmm_manager+0x190>
ffffffffc02031a6:	45e5                	li	a1,25
ffffffffc02031a8:	00003517          	auipc	a0,0x3
ffffffffc02031ac:	f0850513          	addi	a0,a0,-248 # ffffffffc02060b0 <default_pmm_manager+0x178>
ffffffffc02031b0:	850fd0ef          	jal	ra,ffffffffc0200200 <__panic>
ffffffffc02031b4:	86b2                	mv	a3,a2
ffffffffc02031b6:	06900593          	li	a1,105
ffffffffc02031ba:	00002617          	auipc	a2,0x2
ffffffffc02031be:	7e660613          	addi	a2,a2,2022 # ffffffffc02059a0 <commands+0xa78>
ffffffffc02031c2:	00003517          	auipc	a0,0x3
ffffffffc02031c6:	80650513          	addi	a0,a0,-2042 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc02031ca:	836fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02031ce <switch_to>:
.text
# void switch_to(struct proc_struct* from, struct proc_struct* to)
.globl switch_to
switch_to:
    # save from's registers
    STORE ra, 0*REGBYTES(a0)
ffffffffc02031ce:	00153023          	sd	ra,0(a0)
    STORE sp, 1*REGBYTES(a0)
ffffffffc02031d2:	00253423          	sd	sp,8(a0)
    STORE s0, 2*REGBYTES(a0)
ffffffffc02031d6:	e900                	sd	s0,16(a0)
    STORE s1, 3*REGBYTES(a0)
ffffffffc02031d8:	ed04                	sd	s1,24(a0)
    STORE s2, 4*REGBYTES(a0)
ffffffffc02031da:	03253023          	sd	s2,32(a0)
    STORE s3, 5*REGBYTES(a0)
ffffffffc02031de:	03353423          	sd	s3,40(a0)
    STORE s4, 6*REGBYTES(a0)
ffffffffc02031e2:	03453823          	sd	s4,48(a0)
    STORE s5, 7*REGBYTES(a0)
ffffffffc02031e6:	03553c23          	sd	s5,56(a0)
    STORE s6, 8*REGBYTES(a0)
ffffffffc02031ea:	05653023          	sd	s6,64(a0)
    STORE s7, 9*REGBYTES(a0)
ffffffffc02031ee:	05753423          	sd	s7,72(a0)
    STORE s8, 10*REGBYTES(a0)
ffffffffc02031f2:	05853823          	sd	s8,80(a0)
    STORE s9, 11*REGBYTES(a0)
ffffffffc02031f6:	05953c23          	sd	s9,88(a0)
    STORE s10, 12*REGBYTES(a0)
ffffffffc02031fa:	07a53023          	sd	s10,96(a0)
    STORE s11, 13*REGBYTES(a0)
ffffffffc02031fe:	07b53423          	sd	s11,104(a0)

    # restore to's registers
    LOAD ra, 0*REGBYTES(a1)
ffffffffc0203202:	0005b083          	ld	ra,0(a1)
    LOAD sp, 1*REGBYTES(a1)
ffffffffc0203206:	0085b103          	ld	sp,8(a1)
    LOAD s0, 2*REGBYTES(a1)
ffffffffc020320a:	6980                	ld	s0,16(a1)
    LOAD s1, 3*REGBYTES(a1)
ffffffffc020320c:	6d84                	ld	s1,24(a1)
    LOAD s2, 4*REGBYTES(a1)
ffffffffc020320e:	0205b903          	ld	s2,32(a1)
    LOAD s3, 5*REGBYTES(a1)
ffffffffc0203212:	0285b983          	ld	s3,40(a1)
    LOAD s4, 6*REGBYTES(a1)
ffffffffc0203216:	0305ba03          	ld	s4,48(a1)
    LOAD s5, 7*REGBYTES(a1)
ffffffffc020321a:	0385ba83          	ld	s5,56(a1)
    LOAD s6, 8*REGBYTES(a1)
ffffffffc020321e:	0405bb03          	ld	s6,64(a1)
    LOAD s7, 9*REGBYTES(a1)
ffffffffc0203222:	0485bb83          	ld	s7,72(a1)
    LOAD s8, 10*REGBYTES(a1)
ffffffffc0203226:	0505bc03          	ld	s8,80(a1)
    LOAD s9, 11*REGBYTES(a1)
ffffffffc020322a:	0585bc83          	ld	s9,88(a1)
    LOAD s10, 12*REGBYTES(a1)
ffffffffc020322e:	0605bd03          	ld	s10,96(a1)
    LOAD s11, 13*REGBYTES(a1)
ffffffffc0203232:	0685bd83          	ld	s11,104(a1)

    ret
ffffffffc0203236:	8082                	ret

ffffffffc0203238 <kernel_thread_entry>:
.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)
	move a0, s1
ffffffffc0203238:	8526                	mv	a0,s1
	jalr s0
ffffffffc020323a:	9402                	jalr	s0

	jal do_exit
ffffffffc020323c:	70a000ef          	jal	ra,ffffffffc0203946 <do_exit>

ffffffffc0203240 <alloc_proc>:
void forkrets(struct trapframe *tf);
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void) {
ffffffffc0203240:	1141                	addi	sp,sp,-16
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203242:	13000513          	li	a0,304
alloc_proc(void) {
ffffffffc0203246:	e022                	sd	s0,0(sp)
ffffffffc0203248:	e406                	sd	ra,8(sp)
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc020324a:	dcefe0ef          	jal	ra,ffffffffc0201818 <kmalloc>
ffffffffc020324e:	842a                	mv	s0,a0
    if (proc != NULL) {
ffffffffc0203250:	c13d                	beqz	a0,ffffffffc02032b6 <alloc_proc+0x76>
        proc->state = PROC_UNINIT;
ffffffffc0203252:	57fd                	li	a5,-1
ffffffffc0203254:	1782                	slli	a5,a5,0x20
ffffffffc0203256:	e11c                	sd	a5,0(a0)
        proc->runs = 0;
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc0203258:	07000613          	li	a2,112
ffffffffc020325c:	4581                	li	a1,0
        proc->runs = 0;
ffffffffc020325e:	00052423          	sw	zero,8(a0)
        proc->kstack = 0;
ffffffffc0203262:	00053823          	sd	zero,16(a0)
        proc->need_resched = 0;
ffffffffc0203266:	00053c23          	sd	zero,24(a0)
        proc->parent = NULL;
ffffffffc020326a:	02053023          	sd	zero,32(a0)
        proc->mm = NULL;
ffffffffc020326e:	02053423          	sd	zero,40(a0)
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc0203272:	03050513          	addi	a0,a0,48
ffffffffc0203276:	5e2010ef          	jal	ra,ffffffffc0204858 <memset>
        proc->tf = NULL;
        proc->cr3 = boot_cr3;
ffffffffc020327a:	00050797          	auipc	a5,0x50
ffffffffc020327e:	3067b783          	ld	a5,774(a5) # ffffffffc0253580 <boot_cr3>
ffffffffc0203282:	f45c                	sd	a5,168(s0)
        proc->tf = NULL;
ffffffffc0203284:	0a043023          	sd	zero,160(s0)
        proc->flags = 0;
ffffffffc0203288:	0a042823          	sw	zero,176(s0)
        memset(proc->name, 0, PROC_NAME_LEN);
ffffffffc020328c:	463d                	li	a2,15
ffffffffc020328e:	4581                	li	a1,0
ffffffffc0203290:	0b440513          	addi	a0,s0,180
ffffffffc0203294:	5c4010ef          	jal	ra,ffffffffc0204858 <memset>
        proc->wait_state = 0;
        proc->cptr = proc->optr = proc->yptr = NULL;
        proc->time_slice = 0;
ffffffffc0203298:	4785                	li	a5,1
ffffffffc020329a:	1782                	slli	a5,a5,0x20
ffffffffc020329c:	12f43023          	sd	a5,288(s0)
        proc->labschedule_priority = 1;
        proc->labschedule_good = 6;
ffffffffc02032a0:	4799                	li	a5,6
        proc->wait_state = 0;
ffffffffc02032a2:	0e042623          	sw	zero,236(s0)
        proc->cptr = proc->optr = proc->yptr = NULL;
ffffffffc02032a6:	0e043c23          	sd	zero,248(s0)
ffffffffc02032aa:	10043023          	sd	zero,256(s0)
ffffffffc02032ae:	0e043823          	sd	zero,240(s0)
        proc->labschedule_good = 6;
ffffffffc02032b2:	12f42423          	sw	a5,296(s0)
    }
    return proc;
}
ffffffffc02032b6:	60a2                	ld	ra,8(sp)
ffffffffc02032b8:	8522                	mv	a0,s0
ffffffffc02032ba:	6402                	ld	s0,0(sp)
ffffffffc02032bc:	0141                	addi	sp,sp,16
ffffffffc02032be:	8082                	ret

ffffffffc02032c0 <forkret>:
// forkret -- the first kernel entry point of a new thread/process
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void) {
    forkrets(current->tf);
ffffffffc02032c0:	00050797          	auipc	a5,0x50
ffffffffc02032c4:	1807b783          	ld	a5,384(a5) # ffffffffc0253440 <current>
ffffffffc02032c8:	73c8                	ld	a0,160(a5)
ffffffffc02032ca:	a35fd06f          	j	ffffffffc0200cfe <forkrets>

ffffffffc02032ce <user_main>:
static int
user_main(void *arg) {
#ifdef TEST
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
#else
    KERNEL_EXECVE(ex3);
ffffffffc02032ce:	00050797          	auipc	a5,0x50
ffffffffc02032d2:	1727b783          	ld	a5,370(a5) # ffffffffc0253440 <current>
ffffffffc02032d6:	43cc                	lw	a1,4(a5)
user_main(void *arg) {
ffffffffc02032d8:	7139                	addi	sp,sp,-64
    KERNEL_EXECVE(ex3);
ffffffffc02032da:	00003617          	auipc	a2,0x3
ffffffffc02032de:	e0e60613          	addi	a2,a2,-498 # ffffffffc02060e8 <default_pmm_manager+0x1b0>
ffffffffc02032e2:	00003517          	auipc	a0,0x3
ffffffffc02032e6:	e0e50513          	addi	a0,a0,-498 # ffffffffc02060f0 <default_pmm_manager+0x1b8>
user_main(void *arg) {
ffffffffc02032ea:	fc06                	sd	ra,56(sp)
    KERNEL_EXECVE(ex3);
ffffffffc02032ec:	dd9fc0ef          	jal	ra,ffffffffc02000c4 <cprintf>
ffffffffc02032f0:	3fe08797          	auipc	a5,0x3fe08
ffffffffc02032f4:	a0078793          	addi	a5,a5,-1536 # acf0 <_binary_obj___user_ex3_out_size>
ffffffffc02032f8:	e43e                	sd	a5,8(sp)
ffffffffc02032fa:	00003517          	auipc	a0,0x3
ffffffffc02032fe:	dee50513          	addi	a0,a0,-530 # ffffffffc02060e8 <default_pmm_manager+0x1b0>
ffffffffc0203302:	0003a797          	auipc	a5,0x3a
ffffffffc0203306:	f5678793          	addi	a5,a5,-170 # ffffffffc023d258 <_binary_obj___user_ex3_out_start>
ffffffffc020330a:	f03e                	sd	a5,32(sp)
ffffffffc020330c:	f42a                	sd	a0,40(sp)
    int64_t ret=0, len = strlen(name);
ffffffffc020330e:	e802                	sd	zero,16(sp)
ffffffffc0203310:	4de010ef          	jal	ra,ffffffffc02047ee <strlen>
ffffffffc0203314:	ec2a                	sd	a0,24(sp)
    asm volatile(
ffffffffc0203316:	4511                	li	a0,4
ffffffffc0203318:	55a2                	lw	a1,40(sp)
ffffffffc020331a:	4662                	lw	a2,24(sp)
ffffffffc020331c:	5682                	lw	a3,32(sp)
ffffffffc020331e:	4722                	lw	a4,8(sp)
ffffffffc0203320:	48a9                	li	a7,10
ffffffffc0203322:	9002                	ebreak
ffffffffc0203324:	c82a                	sw	a0,16(sp)
    cprintf("ret = %d\n", ret);
ffffffffc0203326:	65c2                	ld	a1,16(sp)
ffffffffc0203328:	00003517          	auipc	a0,0x3
ffffffffc020332c:	df050513          	addi	a0,a0,-528 # ffffffffc0206118 <default_pmm_manager+0x1e0>
ffffffffc0203330:	d95fc0ef          	jal	ra,ffffffffc02000c4 <cprintf>
#endif
    panic("user_main execve failed.\n");
ffffffffc0203334:	00003617          	auipc	a2,0x3
ffffffffc0203338:	df460613          	addi	a2,a2,-524 # ffffffffc0206128 <default_pmm_manager+0x1f0>
ffffffffc020333c:	30600593          	li	a1,774
ffffffffc0203340:	00003517          	auipc	a0,0x3
ffffffffc0203344:	e0850513          	addi	a0,a0,-504 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc0203348:	eb9fc0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc020334c <put_pgdir>:
    return pa2page(PADDR(kva));
ffffffffc020334c:	6d14                	ld	a3,24(a0)
put_pgdir(struct mm_struct *mm) {
ffffffffc020334e:	1141                	addi	sp,sp,-16
ffffffffc0203350:	e406                	sd	ra,8(sp)
ffffffffc0203352:	c02007b7          	lui	a5,0xc0200
ffffffffc0203356:	02f6ee63          	bltu	a3,a5,ffffffffc0203392 <put_pgdir+0x46>
ffffffffc020335a:	00050517          	auipc	a0,0x50
ffffffffc020335e:	21e53503          	ld	a0,542(a0) # ffffffffc0253578 <va_pa_offset>
ffffffffc0203362:	8e89                	sub	a3,a3,a0
    if (PPN(pa) >= npage) {
ffffffffc0203364:	82b1                	srli	a3,a3,0xc
ffffffffc0203366:	00050797          	auipc	a5,0x50
ffffffffc020336a:	0d27b783          	ld	a5,210(a5) # ffffffffc0253438 <npage>
ffffffffc020336e:	02f6fe63          	bgeu	a3,a5,ffffffffc02033aa <put_pgdir+0x5e>
    return &pages[PPN(pa) - nbase];
ffffffffc0203372:	00004517          	auipc	a0,0x4
ffffffffc0203376:	e1e53503          	ld	a0,-482(a0) # ffffffffc0207190 <nbase>
}
ffffffffc020337a:	60a2                	ld	ra,8(sp)
ffffffffc020337c:	8e89                	sub	a3,a3,a0
ffffffffc020337e:	069a                	slli	a3,a3,0x6
    free_page(kva2page(mm->pgdir));
ffffffffc0203380:	00050517          	auipc	a0,0x50
ffffffffc0203384:	20853503          	ld	a0,520(a0) # ffffffffc0253588 <pages>
ffffffffc0203388:	4585                	li	a1,1
ffffffffc020338a:	9536                	add	a0,a0,a3
}
ffffffffc020338c:	0141                	addi	sp,sp,16
    free_page(kva2page(mm->pgdir));
ffffffffc020338e:	bb2ff06f          	j	ffffffffc0202740 <free_pages>
    return pa2page(PADDR(kva));
ffffffffc0203392:	00002617          	auipc	a2,0x2
ffffffffc0203396:	67e60613          	addi	a2,a2,1662 # ffffffffc0205a10 <commands+0xae8>
ffffffffc020339a:	06e00593          	li	a1,110
ffffffffc020339e:	00002517          	auipc	a0,0x2
ffffffffc02033a2:	62a50513          	addi	a0,a0,1578 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc02033a6:	e5bfc0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02033aa:	00002617          	auipc	a2,0x2
ffffffffc02033ae:	68e60613          	addi	a2,a2,1678 # ffffffffc0205a38 <commands+0xb10>
ffffffffc02033b2:	06200593          	li	a1,98
ffffffffc02033b6:	00002517          	auipc	a0,0x2
ffffffffc02033ba:	61250513          	addi	a0,a0,1554 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc02033be:	e43fc0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02033c2 <setup_pgdir>:
setup_pgdir(struct mm_struct *mm) {
ffffffffc02033c2:	1101                	addi	sp,sp,-32
ffffffffc02033c4:	e426                	sd	s1,8(sp)
ffffffffc02033c6:	84aa                	mv	s1,a0
    if ((page = alloc_page()) == NULL) {
ffffffffc02033c8:	4505                	li	a0,1
setup_pgdir(struct mm_struct *mm) {
ffffffffc02033ca:	ec06                	sd	ra,24(sp)
ffffffffc02033cc:	e822                	sd	s0,16(sp)
    if ((page = alloc_page()) == NULL) {
ffffffffc02033ce:	ae0ff0ef          	jal	ra,ffffffffc02026ae <alloc_pages>
ffffffffc02033d2:	c939                	beqz	a0,ffffffffc0203428 <setup_pgdir+0x66>
    return page - pages + nbase;
ffffffffc02033d4:	00050697          	auipc	a3,0x50
ffffffffc02033d8:	1b46b683          	ld	a3,436(a3) # ffffffffc0253588 <pages>
ffffffffc02033dc:	40d506b3          	sub	a3,a0,a3
ffffffffc02033e0:	8699                	srai	a3,a3,0x6
ffffffffc02033e2:	00004417          	auipc	s0,0x4
ffffffffc02033e6:	dae43403          	ld	s0,-594(s0) # ffffffffc0207190 <nbase>
ffffffffc02033ea:	96a2                	add	a3,a3,s0
    return KADDR(page2pa(page));
ffffffffc02033ec:	00c69793          	slli	a5,a3,0xc
ffffffffc02033f0:	83b1                	srli	a5,a5,0xc
ffffffffc02033f2:	00050717          	auipc	a4,0x50
ffffffffc02033f6:	04673703          	ld	a4,70(a4) # ffffffffc0253438 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc02033fa:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02033fc:	02e7f863          	bgeu	a5,a4,ffffffffc020342c <setup_pgdir+0x6a>
ffffffffc0203400:	00050417          	auipc	s0,0x50
ffffffffc0203404:	17843403          	ld	s0,376(s0) # ffffffffc0253578 <va_pa_offset>
ffffffffc0203408:	9436                	add	s0,s0,a3
    memcpy(pgdir, boot_pgdir, PGSIZE);
ffffffffc020340a:	6605                	lui	a2,0x1
ffffffffc020340c:	00050597          	auipc	a1,0x50
ffffffffc0203410:	0245b583          	ld	a1,36(a1) # ffffffffc0253430 <boot_pgdir>
ffffffffc0203414:	8522                	mv	a0,s0
ffffffffc0203416:	454010ef          	jal	ra,ffffffffc020486a <memcpy>
    return 0;
ffffffffc020341a:	4501                	li	a0,0
    mm->pgdir = pgdir;
ffffffffc020341c:	ec80                	sd	s0,24(s1)
}
ffffffffc020341e:	60e2                	ld	ra,24(sp)
ffffffffc0203420:	6442                	ld	s0,16(sp)
ffffffffc0203422:	64a2                	ld	s1,8(sp)
ffffffffc0203424:	6105                	addi	sp,sp,32
ffffffffc0203426:	8082                	ret
        return -E_NO_MEM;
ffffffffc0203428:	5571                	li	a0,-4
ffffffffc020342a:	bfd5                	j	ffffffffc020341e <setup_pgdir+0x5c>
ffffffffc020342c:	00002617          	auipc	a2,0x2
ffffffffc0203430:	57460613          	addi	a2,a2,1396 # ffffffffc02059a0 <commands+0xa78>
ffffffffc0203434:	06900593          	li	a1,105
ffffffffc0203438:	00002517          	auipc	a0,0x2
ffffffffc020343c:	59050513          	addi	a0,a0,1424 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc0203440:	dc1fc0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0203444 <set_proc_name>:
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc0203444:	1101                	addi	sp,sp,-32
ffffffffc0203446:	e822                	sd	s0,16(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203448:	0b450413          	addi	s0,a0,180
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc020344c:	e426                	sd	s1,8(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc020344e:	4641                	li	a2,16
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc0203450:	84ae                	mv	s1,a1
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203452:	8522                	mv	a0,s0
ffffffffc0203454:	4581                	li	a1,0
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc0203456:	ec06                	sd	ra,24(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203458:	400010ef          	jal	ra,ffffffffc0204858 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc020345c:	8522                	mv	a0,s0
}
ffffffffc020345e:	6442                	ld	s0,16(sp)
ffffffffc0203460:	60e2                	ld	ra,24(sp)
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0203462:	85a6                	mv	a1,s1
}
ffffffffc0203464:	64a2                	ld	s1,8(sp)
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0203466:	463d                	li	a2,15
}
ffffffffc0203468:	6105                	addi	sp,sp,32
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc020346a:	4000106f          	j	ffffffffc020486a <memcpy>

ffffffffc020346e <proc_run>:
proc_run(struct proc_struct *proc) {
ffffffffc020346e:	7179                	addi	sp,sp,-48
ffffffffc0203470:	ec4a                	sd	s2,24(sp)
    if (proc != current) {
ffffffffc0203472:	00050917          	auipc	s2,0x50
ffffffffc0203476:	fce90913          	addi	s2,s2,-50 # ffffffffc0253440 <current>
proc_run(struct proc_struct *proc) {
ffffffffc020347a:	f026                	sd	s1,32(sp)
    if (proc != current) {
ffffffffc020347c:	00093483          	ld	s1,0(s2)
proc_run(struct proc_struct *proc) {
ffffffffc0203480:	f406                	sd	ra,40(sp)
ffffffffc0203482:	e84e                	sd	s3,16(sp)
    if (proc != current) {
ffffffffc0203484:	02a48863          	beq	s1,a0,ffffffffc02034b4 <proc_run+0x46>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203488:	100027f3          	csrr	a5,sstatus
ffffffffc020348c:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020348e:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203490:	ef9d                	bnez	a5,ffffffffc02034ce <proc_run+0x60>

#define barrier() __asm__ __volatile__ ("fence" ::: "memory")

static inline void
lcr3(unsigned long cr3) {
    write_csr(satp, 0x8000000000000000 | (cr3 >> RISCV_PGSHIFT));
ffffffffc0203492:	755c                	ld	a5,168(a0)
ffffffffc0203494:	577d                	li	a4,-1
ffffffffc0203496:	177e                	slli	a4,a4,0x3f
ffffffffc0203498:	83b1                	srli	a5,a5,0xc
            current = proc;
ffffffffc020349a:	00a93023          	sd	a0,0(s2)
ffffffffc020349e:	8fd9                	or	a5,a5,a4
ffffffffc02034a0:	18079073          	csrw	satp,a5
            switch_to(&(prev->context), &(next->context));
ffffffffc02034a4:	03050593          	addi	a1,a0,48
ffffffffc02034a8:	03048513          	addi	a0,s1,48 # ffffffffffe00030 <end+0x3fbaca90>
ffffffffc02034ac:	d23ff0ef          	jal	ra,ffffffffc02031ce <switch_to>
    if (flag) {
ffffffffc02034b0:	00099863          	bnez	s3,ffffffffc02034c0 <proc_run+0x52>
}
ffffffffc02034b4:	70a2                	ld	ra,40(sp)
ffffffffc02034b6:	7482                	ld	s1,32(sp)
ffffffffc02034b8:	6962                	ld	s2,24(sp)
ffffffffc02034ba:	69c2                	ld	s3,16(sp)
ffffffffc02034bc:	6145                	addi	sp,sp,48
ffffffffc02034be:	8082                	ret
ffffffffc02034c0:	70a2                	ld	ra,40(sp)
ffffffffc02034c2:	7482                	ld	s1,32(sp)
ffffffffc02034c4:	6962                	ld	s2,24(sp)
ffffffffc02034c6:	69c2                	ld	s3,16(sp)
ffffffffc02034c8:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc02034ca:	92efd06f          	j	ffffffffc02005f8 <intr_enable>
ffffffffc02034ce:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02034d0:	92efd0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc02034d4:	6522                	ld	a0,8(sp)
ffffffffc02034d6:	4985                	li	s3,1
ffffffffc02034d8:	bf6d                	j	ffffffffc0203492 <proc_run+0x24>

ffffffffc02034da <find_proc>:
    if (0 < pid && pid < MAX_PID) {
ffffffffc02034da:	6789                	lui	a5,0x2
ffffffffc02034dc:	fff5071b          	addiw	a4,a0,-1
ffffffffc02034e0:	17f9                	addi	a5,a5,-2
ffffffffc02034e2:	04e7e063          	bltu	a5,a4,ffffffffc0203522 <find_proc+0x48>
find_proc(int pid) {
ffffffffc02034e6:	1141                	addi	sp,sp,-16
ffffffffc02034e8:	e022                	sd	s0,0(sp)
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc02034ea:	45a9                	li	a1,10
ffffffffc02034ec:	842a                	mv	s0,a0
ffffffffc02034ee:	2501                	sext.w	a0,a0
find_proc(int pid) {
ffffffffc02034f0:	e406                	sd	ra,8(sp)
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc02034f2:	77e010ef          	jal	ra,ffffffffc0204c70 <hash32>
ffffffffc02034f6:	02051693          	slli	a3,a0,0x20
ffffffffc02034fa:	0004c797          	auipc	a5,0x4c
ffffffffc02034fe:	ede78793          	addi	a5,a5,-290 # ffffffffc024f3d8 <hash_list>
ffffffffc0203502:	82f1                	srli	a3,a3,0x1c
ffffffffc0203504:	96be                	add	a3,a3,a5
ffffffffc0203506:	87b6                	mv	a5,a3
        while ((le = list_next(le)) != list) {
ffffffffc0203508:	a029                	j	ffffffffc0203512 <find_proc+0x38>
            if (proc->pid == pid) {
ffffffffc020350a:	f2c7a703          	lw	a4,-212(a5)
ffffffffc020350e:	00870c63          	beq	a4,s0,ffffffffc0203526 <find_proc+0x4c>
    return listelm->next;
ffffffffc0203512:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list) {
ffffffffc0203514:	fef69be3          	bne	a3,a5,ffffffffc020350a <find_proc+0x30>
}
ffffffffc0203518:	60a2                	ld	ra,8(sp)
ffffffffc020351a:	6402                	ld	s0,0(sp)
    return NULL;
ffffffffc020351c:	4501                	li	a0,0
}
ffffffffc020351e:	0141                	addi	sp,sp,16
ffffffffc0203520:	8082                	ret
    return NULL;
ffffffffc0203522:	4501                	li	a0,0
}
ffffffffc0203524:	8082                	ret
ffffffffc0203526:	60a2                	ld	ra,8(sp)
ffffffffc0203528:	6402                	ld	s0,0(sp)
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc020352a:	f2878513          	addi	a0,a5,-216
}
ffffffffc020352e:	0141                	addi	sp,sp,16
ffffffffc0203530:	8082                	ret

ffffffffc0203532 <do_fork>:
do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf) {
ffffffffc0203532:	7159                	addi	sp,sp,-112
ffffffffc0203534:	e0d2                	sd	s4,64(sp)
    if (nr_process >= MAX_PROCESS) {
ffffffffc0203536:	00050a17          	auipc	s4,0x50
ffffffffc020353a:	f22a0a13          	addi	s4,s4,-222 # ffffffffc0253458 <nr_process>
ffffffffc020353e:	000a2703          	lw	a4,0(s4)
do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf) {
ffffffffc0203542:	f486                	sd	ra,104(sp)
ffffffffc0203544:	f0a2                	sd	s0,96(sp)
ffffffffc0203546:	eca6                	sd	s1,88(sp)
ffffffffc0203548:	e8ca                	sd	s2,80(sp)
ffffffffc020354a:	e4ce                	sd	s3,72(sp)
ffffffffc020354c:	fc56                	sd	s5,56(sp)
ffffffffc020354e:	f85a                	sd	s6,48(sp)
ffffffffc0203550:	f45e                	sd	s7,40(sp)
ffffffffc0203552:	f062                	sd	s8,32(sp)
ffffffffc0203554:	ec66                	sd	s9,24(sp)
ffffffffc0203556:	e86a                	sd	s10,16(sp)
ffffffffc0203558:	e46e                	sd	s11,8(sp)
    if (nr_process >= MAX_PROCESS) {
ffffffffc020355a:	6785                	lui	a5,0x1
ffffffffc020355c:	2ef75c63          	bge	a4,a5,ffffffffc0203854 <do_fork+0x322>
ffffffffc0203560:	89aa                	mv	s3,a0
ffffffffc0203562:	892e                	mv	s2,a1
ffffffffc0203564:	84b2                	mv	s1,a2
    if ((proc = alloc_proc()) == NULL) {
ffffffffc0203566:	cdbff0ef          	jal	ra,ffffffffc0203240 <alloc_proc>
ffffffffc020356a:	842a                	mv	s0,a0
ffffffffc020356c:	2c050163          	beqz	a0,ffffffffc020382e <do_fork+0x2fc>
    proc->parent = current;
ffffffffc0203570:	00050c17          	auipc	s8,0x50
ffffffffc0203574:	ed0c0c13          	addi	s8,s8,-304 # ffffffffc0253440 <current>
ffffffffc0203578:	000c3783          	ld	a5,0(s8)
    assert(current->wait_state == 0);
ffffffffc020357c:	0ec7a703          	lw	a4,236(a5) # 10ec <_binary_obj___user_ex1_out_size-0x885c>
    proc->parent = current;
ffffffffc0203580:	f11c                	sd	a5,32(a0)
    assert(current->wait_state == 0);
ffffffffc0203582:	2e071963          	bnez	a4,ffffffffc0203874 <do_fork+0x342>
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc0203586:	4509                	li	a0,2
ffffffffc0203588:	926ff0ef          	jal	ra,ffffffffc02026ae <alloc_pages>
    if (page != NULL) {
ffffffffc020358c:	28050e63          	beqz	a0,ffffffffc0203828 <do_fork+0x2f6>
    return page - pages + nbase;
ffffffffc0203590:	00050a97          	auipc	s5,0x50
ffffffffc0203594:	ff8a8a93          	addi	s5,s5,-8 # ffffffffc0253588 <pages>
ffffffffc0203598:	000ab683          	ld	a3,0(s5)
ffffffffc020359c:	00004b17          	auipc	s6,0x4
ffffffffc02035a0:	bf4b0b13          	addi	s6,s6,-1036 # ffffffffc0207190 <nbase>
ffffffffc02035a4:	000b3783          	ld	a5,0(s6)
ffffffffc02035a8:	40d506b3          	sub	a3,a0,a3
ffffffffc02035ac:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02035ae:	00050b97          	auipc	s7,0x50
ffffffffc02035b2:	e8ab8b93          	addi	s7,s7,-374 # ffffffffc0253438 <npage>
    return page - pages + nbase;
ffffffffc02035b6:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc02035b8:	000bb703          	ld	a4,0(s7)
ffffffffc02035bc:	00c69793          	slli	a5,a3,0xc
ffffffffc02035c0:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02035c2:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02035c4:	28e7fc63          	bgeu	a5,a4,ffffffffc020385c <do_fork+0x32a>
    struct mm_struct *mm, *oldmm = current->mm;
ffffffffc02035c8:	000c3703          	ld	a4,0(s8)
ffffffffc02035cc:	00050c97          	auipc	s9,0x50
ffffffffc02035d0:	facc8c93          	addi	s9,s9,-84 # ffffffffc0253578 <va_pa_offset>
ffffffffc02035d4:	000cb783          	ld	a5,0(s9)
ffffffffc02035d8:	02873c03          	ld	s8,40(a4)
ffffffffc02035dc:	96be                	add	a3,a3,a5
        proc->kstack = (uintptr_t)page2kva(page);
ffffffffc02035de:	e814                	sd	a3,16(s0)
    if (oldmm == NULL) {
ffffffffc02035e0:	020c0863          	beqz	s8,ffffffffc0203610 <do_fork+0xde>
    if (clone_flags & CLONE_VM) {
ffffffffc02035e4:	1009f993          	andi	s3,s3,256
ffffffffc02035e8:	1a098e63          	beqz	s3,ffffffffc02037a4 <do_fork+0x272>
}

static inline int
mm_count_inc(struct mm_struct *mm) {
    mm->mm_count += 1;
ffffffffc02035ec:	030c2703          	lw	a4,48(s8)
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc02035f0:	018c3783          	ld	a5,24(s8)
ffffffffc02035f4:	c02006b7          	lui	a3,0xc0200
ffffffffc02035f8:	2705                	addiw	a4,a4,1
ffffffffc02035fa:	02ec2823          	sw	a4,48(s8)
    proc->mm = mm;
ffffffffc02035fe:	03843423          	sd	s8,40(s0)
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc0203602:	28d7e963          	bltu	a5,a3,ffffffffc0203894 <do_fork+0x362>
ffffffffc0203606:	000cb703          	ld	a4,0(s9)
ffffffffc020360a:	6814                	ld	a3,16(s0)
ffffffffc020360c:	8f99                	sub	a5,a5,a4
ffffffffc020360e:	f45c                	sd	a5,168(s0)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0203610:	6789                	lui	a5,0x2
ffffffffc0203612:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_ex1_out_size-0x7a68>
ffffffffc0203616:	97b6                	add	a5,a5,a3
ffffffffc0203618:	f05c                	sd	a5,160(s0)
    *(proc->tf) = *tf;
ffffffffc020361a:	873e                	mv	a4,a5
ffffffffc020361c:	12048893          	addi	a7,s1,288
ffffffffc0203620:	0004b803          	ld	a6,0(s1)
ffffffffc0203624:	6488                	ld	a0,8(s1)
ffffffffc0203626:	688c                	ld	a1,16(s1)
ffffffffc0203628:	6c90                	ld	a2,24(s1)
ffffffffc020362a:	01073023          	sd	a6,0(a4)
ffffffffc020362e:	e708                	sd	a0,8(a4)
ffffffffc0203630:	eb0c                	sd	a1,16(a4)
ffffffffc0203632:	ef10                	sd	a2,24(a4)
ffffffffc0203634:	02048493          	addi	s1,s1,32
ffffffffc0203638:	02070713          	addi	a4,a4,32
ffffffffc020363c:	ff1492e3          	bne	s1,a7,ffffffffc0203620 <do_fork+0xee>
    proc->tf->gpr.a0 = 0;
ffffffffc0203640:	0407b823          	sd	zero,80(a5)
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf - 4 : esp;
ffffffffc0203644:	12090a63          	beqz	s2,ffffffffc0203778 <do_fork+0x246>
ffffffffc0203648:	0127b823          	sd	s2,16(a5)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc020364c:	00000717          	auipc	a4,0x0
ffffffffc0203650:	c7470713          	addi	a4,a4,-908 # ffffffffc02032c0 <forkret>
ffffffffc0203654:	f818                	sd	a4,48(s0)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc0203656:	fc1c                	sd	a5,56(s0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203658:	100027f3          	csrr	a5,sstatus
ffffffffc020365c:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020365e:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203660:	12079e63          	bnez	a5,ffffffffc020379c <do_fork+0x26a>
    if (++ last_pid >= MAX_PID) {
ffffffffc0203664:	00045597          	auipc	a1,0x45
ffffffffc0203668:	96c58593          	addi	a1,a1,-1684 # ffffffffc0247fd0 <last_pid.1746>
ffffffffc020366c:	419c                	lw	a5,0(a1)
ffffffffc020366e:	6709                	lui	a4,0x2
ffffffffc0203670:	0017851b          	addiw	a0,a5,1
ffffffffc0203674:	c188                	sw	a0,0(a1)
ffffffffc0203676:	08e55b63          	bge	a0,a4,ffffffffc020370c <do_fork+0x1da>
    if (last_pid >= next_safe) {
ffffffffc020367a:	00045897          	auipc	a7,0x45
ffffffffc020367e:	95a88893          	addi	a7,a7,-1702 # ffffffffc0247fd4 <next_safe.1745>
ffffffffc0203682:	0008a783          	lw	a5,0(a7)
ffffffffc0203686:	00050497          	auipc	s1,0x50
ffffffffc020368a:	f0a48493          	addi	s1,s1,-246 # ffffffffc0253590 <proc_list>
ffffffffc020368e:	08f55663          	bge	a0,a5,ffffffffc020371a <do_fork+0x1e8>
        proc->pid = get_pid();
ffffffffc0203692:	c048                	sw	a0,4(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0203694:	45a9                	li	a1,10
ffffffffc0203696:	2501                	sext.w	a0,a0
ffffffffc0203698:	5d8010ef          	jal	ra,ffffffffc0204c70 <hash32>
ffffffffc020369c:	1502                	slli	a0,a0,0x20
ffffffffc020369e:	0004c797          	auipc	a5,0x4c
ffffffffc02036a2:	d3a78793          	addi	a5,a5,-710 # ffffffffc024f3d8 <hash_list>
ffffffffc02036a6:	8171                	srli	a0,a0,0x1c
ffffffffc02036a8:	953e                	add	a0,a0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc02036aa:	650c                	ld	a1,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc02036ac:	7014                	ld	a3,32(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc02036ae:	0d840793          	addi	a5,s0,216
    prev->next = next->prev = elm;
ffffffffc02036b2:	e19c                	sd	a5,0(a1)
    __list_add(elm, listelm, listelm->next);
ffffffffc02036b4:	6490                	ld	a2,8(s1)
    prev->next = next->prev = elm;
ffffffffc02036b6:	e51c                	sd	a5,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc02036b8:	7af8                	ld	a4,240(a3)
    list_add(&proc_list, &(proc->list_link));
ffffffffc02036ba:	0c840793          	addi	a5,s0,200
    elm->next = next;
ffffffffc02036be:	f06c                	sd	a1,224(s0)
    elm->prev = prev;
ffffffffc02036c0:	ec68                	sd	a0,216(s0)
    prev->next = next->prev = elm;
ffffffffc02036c2:	e21c                	sd	a5,0(a2)
ffffffffc02036c4:	e49c                	sd	a5,8(s1)
    elm->next = next;
ffffffffc02036c6:	e870                	sd	a2,208(s0)
    elm->prev = prev;
ffffffffc02036c8:	e464                	sd	s1,200(s0)
    proc->yptr = NULL;
ffffffffc02036ca:	0e043c23          	sd	zero,248(s0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc02036ce:	10e43023          	sd	a4,256(s0)
ffffffffc02036d2:	c311                	beqz	a4,ffffffffc02036d6 <do_fork+0x1a4>
        proc->optr->yptr = proc;
ffffffffc02036d4:	ff60                	sd	s0,248(a4)
    nr_process ++;
ffffffffc02036d6:	000a2783          	lw	a5,0(s4)
    proc->parent->cptr = proc;
ffffffffc02036da:	fae0                	sd	s0,240(a3)
    nr_process ++;
ffffffffc02036dc:	2785                	addiw	a5,a5,1
ffffffffc02036de:	00fa2023          	sw	a5,0(s4)
    if (flag) {
ffffffffc02036e2:	14091863          	bnez	s2,ffffffffc0203832 <do_fork+0x300>
    wakeup_proc(proc);
ffffffffc02036e6:	8522                	mv	a0,s0
ffffffffc02036e8:	5ad000ef          	jal	ra,ffffffffc0204494 <wakeup_proc>
    ret = proc->pid;
ffffffffc02036ec:	4048                	lw	a0,4(s0)
}
ffffffffc02036ee:	70a6                	ld	ra,104(sp)
ffffffffc02036f0:	7406                	ld	s0,96(sp)
ffffffffc02036f2:	64e6                	ld	s1,88(sp)
ffffffffc02036f4:	6946                	ld	s2,80(sp)
ffffffffc02036f6:	69a6                	ld	s3,72(sp)
ffffffffc02036f8:	6a06                	ld	s4,64(sp)
ffffffffc02036fa:	7ae2                	ld	s5,56(sp)
ffffffffc02036fc:	7b42                	ld	s6,48(sp)
ffffffffc02036fe:	7ba2                	ld	s7,40(sp)
ffffffffc0203700:	7c02                	ld	s8,32(sp)
ffffffffc0203702:	6ce2                	ld	s9,24(sp)
ffffffffc0203704:	6d42                	ld	s10,16(sp)
ffffffffc0203706:	6da2                	ld	s11,8(sp)
ffffffffc0203708:	6165                	addi	sp,sp,112
ffffffffc020370a:	8082                	ret
        last_pid = 1;
ffffffffc020370c:	4785                	li	a5,1
ffffffffc020370e:	c19c                	sw	a5,0(a1)
        goto inside;
ffffffffc0203710:	4505                	li	a0,1
ffffffffc0203712:	00045897          	auipc	a7,0x45
ffffffffc0203716:	8c288893          	addi	a7,a7,-1854 # ffffffffc0247fd4 <next_safe.1745>
    return listelm->next;
ffffffffc020371a:	00050497          	auipc	s1,0x50
ffffffffc020371e:	e7648493          	addi	s1,s1,-394 # ffffffffc0253590 <proc_list>
ffffffffc0203722:	0084b303          	ld	t1,8(s1)
        next_safe = MAX_PID;
ffffffffc0203726:	6789                	lui	a5,0x2
ffffffffc0203728:	00f8a023          	sw	a5,0(a7)
ffffffffc020372c:	4801                	li	a6,0
ffffffffc020372e:	87aa                	mv	a5,a0
        while ((le = list_next(le)) != list) {
ffffffffc0203730:	6e89                	lui	t4,0x2
ffffffffc0203732:	10930c63          	beq	t1,s1,ffffffffc020384a <do_fork+0x318>
ffffffffc0203736:	8e42                	mv	t3,a6
ffffffffc0203738:	869a                	mv	a3,t1
ffffffffc020373a:	6609                	lui	a2,0x2
ffffffffc020373c:	a811                	j	ffffffffc0203750 <do_fork+0x21e>
            else if (proc->pid > last_pid && next_safe > proc->pid) {
ffffffffc020373e:	00e7d663          	bge	a5,a4,ffffffffc020374a <do_fork+0x218>
ffffffffc0203742:	00c75463          	bge	a4,a2,ffffffffc020374a <do_fork+0x218>
ffffffffc0203746:	863a                	mv	a2,a4
ffffffffc0203748:	4e05                	li	t3,1
ffffffffc020374a:	6694                	ld	a3,8(a3)
        while ((le = list_next(le)) != list) {
ffffffffc020374c:	00968d63          	beq	a3,s1,ffffffffc0203766 <do_fork+0x234>
            if (proc->pid == last_pid) {
ffffffffc0203750:	f3c6a703          	lw	a4,-196(a3) # ffffffffc01fff3c <_binary_obj___user_ex3_out_size+0xffffffffc01f524c>
ffffffffc0203754:	fee795e3          	bne	a5,a4,ffffffffc020373e <do_fork+0x20c>
                if (++ last_pid >= next_safe) {
ffffffffc0203758:	2785                	addiw	a5,a5,1
ffffffffc020375a:	0cc7df63          	bge	a5,a2,ffffffffc0203838 <do_fork+0x306>
ffffffffc020375e:	6694                	ld	a3,8(a3)
ffffffffc0203760:	4805                	li	a6,1
        while ((le = list_next(le)) != list) {
ffffffffc0203762:	fe9697e3          	bne	a3,s1,ffffffffc0203750 <do_fork+0x21e>
ffffffffc0203766:	00080463          	beqz	a6,ffffffffc020376e <do_fork+0x23c>
ffffffffc020376a:	c19c                	sw	a5,0(a1)
ffffffffc020376c:	853e                	mv	a0,a5
ffffffffc020376e:	f20e02e3          	beqz	t3,ffffffffc0203692 <do_fork+0x160>
ffffffffc0203772:	00c8a023          	sw	a2,0(a7)
ffffffffc0203776:	bf31                	j	ffffffffc0203692 <do_fork+0x160>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf - 4 : esp;
ffffffffc0203778:	6909                	lui	s2,0x2
ffffffffc020377a:	edc90913          	addi	s2,s2,-292 # 1edc <_binary_obj___user_ex1_out_size-0x7a6c>
ffffffffc020377e:	9936                	add	s2,s2,a3
ffffffffc0203780:	0127b823          	sd	s2,16(a5) # 2010 <_binary_obj___user_ex1_out_size-0x7938>
    proc->context.ra = (uintptr_t)forkret;
ffffffffc0203784:	00000717          	auipc	a4,0x0
ffffffffc0203788:	b3c70713          	addi	a4,a4,-1220 # ffffffffc02032c0 <forkret>
ffffffffc020378c:	f818                	sd	a4,48(s0)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc020378e:	fc1c                	sd	a5,56(s0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203790:	100027f3          	csrr	a5,sstatus
ffffffffc0203794:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203796:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203798:	ec0786e3          	beqz	a5,ffffffffc0203664 <do_fork+0x132>
        intr_disable();
ffffffffc020379c:	e63fc0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc02037a0:	4905                	li	s2,1
ffffffffc02037a2:	b5c9                	j	ffffffffc0203664 <do_fork+0x132>
    if ((mm = mm_create()) == NULL) {
ffffffffc02037a4:	d82fd0ef          	jal	ra,ffffffffc0200d26 <mm_create>
ffffffffc02037a8:	89aa                	mv	s3,a0
ffffffffc02037aa:	c539                	beqz	a0,ffffffffc02037f8 <do_fork+0x2c6>
    if (setup_pgdir(mm) != 0) {
ffffffffc02037ac:	c17ff0ef          	jal	ra,ffffffffc02033c2 <setup_pgdir>
ffffffffc02037b0:	e949                	bnez	a0,ffffffffc0203842 <do_fork+0x310>
}

static inline void
lock_mm(struct mm_struct *mm) {
    if (mm != NULL) {
        lock(&(mm->mm_lock));
ffffffffc02037b2:	038c0d93          	addi	s11,s8,56
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool test_and_set_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02037b6:	4785                	li	a5,1
ffffffffc02037b8:	40fdb7af          	amoor.d	a5,a5,(s11)
    return !test_and_set_bit(0, lock);
}

static inline void
lock(lock_t *lock) {
    while (!try_lock(lock)) {
ffffffffc02037bc:	8b85                	andi	a5,a5,1
ffffffffc02037be:	4d05                	li	s10,1
ffffffffc02037c0:	c799                	beqz	a5,ffffffffc02037ce <do_fork+0x29c>
        schedule();
ffffffffc02037c2:	585000ef          	jal	ra,ffffffffc0204546 <schedule>
ffffffffc02037c6:	41adb7af          	amoor.d	a5,s10,(s11)
    while (!try_lock(lock)) {
ffffffffc02037ca:	8b85                	andi	a5,a5,1
ffffffffc02037cc:	fbfd                	bnez	a5,ffffffffc02037c2 <do_fork+0x290>
        ret = dup_mmap(mm, oldmm);
ffffffffc02037ce:	85e2                	mv	a1,s8
ffffffffc02037d0:	854e                	mv	a0,s3
ffffffffc02037d2:	faefd0ef          	jal	ra,ffffffffc0200f80 <dup_mmap>
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool test_and_clear_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc02037d6:	57f9                	li	a5,-2
ffffffffc02037d8:	60fdb7af          	amoand.d	a5,a5,(s11)
ffffffffc02037dc:	8b85                	andi	a5,a5,1
    }
}

static inline void
unlock(lock_t *lock) {
    if (!test_and_clear_bit(0, lock)) {
ffffffffc02037de:	cbe1                	beqz	a5,ffffffffc02038ae <do_fork+0x37c>
good_mm:
ffffffffc02037e0:	8c4e                	mv	s8,s3
    if (ret != 0) {
ffffffffc02037e2:	e00505e3          	beqz	a0,ffffffffc02035ec <do_fork+0xba>
    exit_mmap(mm);
ffffffffc02037e6:	854e                	mv	a0,s3
ffffffffc02037e8:	833fd0ef          	jal	ra,ffffffffc020101a <exit_mmap>
    put_pgdir(mm);
ffffffffc02037ec:	854e                	mv	a0,s3
ffffffffc02037ee:	b5fff0ef          	jal	ra,ffffffffc020334c <put_pgdir>
    mm_destroy(mm);
ffffffffc02037f2:	854e                	mv	a0,s3
ffffffffc02037f4:	e8afd0ef          	jal	ra,ffffffffc0200e7e <mm_destroy>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc02037f8:	6814                	ld	a3,16(s0)
    return pa2page(PADDR(kva));
ffffffffc02037fa:	c02007b7          	lui	a5,0xc0200
ffffffffc02037fe:	0ef6e063          	bltu	a3,a5,ffffffffc02038de <do_fork+0x3ac>
ffffffffc0203802:	000cb783          	ld	a5,0(s9)
    if (PPN(pa) >= npage) {
ffffffffc0203806:	000bb703          	ld	a4,0(s7)
    return pa2page(PADDR(kva));
ffffffffc020380a:	40f687b3          	sub	a5,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc020380e:	83b1                	srli	a5,a5,0xc
ffffffffc0203810:	0ae7fb63          	bgeu	a5,a4,ffffffffc02038c6 <do_fork+0x394>
    return &pages[PPN(pa) - nbase];
ffffffffc0203814:	000b3703          	ld	a4,0(s6)
ffffffffc0203818:	000ab503          	ld	a0,0(s5)
ffffffffc020381c:	4589                	li	a1,2
ffffffffc020381e:	8f99                	sub	a5,a5,a4
ffffffffc0203820:	079a                	slli	a5,a5,0x6
ffffffffc0203822:	953e                	add	a0,a0,a5
ffffffffc0203824:	f1dfe0ef          	jal	ra,ffffffffc0202740 <free_pages>
    kfree(proc);
ffffffffc0203828:	8522                	mv	a0,s0
ffffffffc020382a:	89efe0ef          	jal	ra,ffffffffc02018c8 <kfree>
    ret = -E_NO_MEM;
ffffffffc020382e:	5571                	li	a0,-4
    return ret;
ffffffffc0203830:	bd7d                	j	ffffffffc02036ee <do_fork+0x1bc>
        intr_enable();
ffffffffc0203832:	dc7fc0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc0203836:	bd45                	j	ffffffffc02036e6 <do_fork+0x1b4>
                    if (last_pid >= MAX_PID) {
ffffffffc0203838:	01d7c363          	blt	a5,t4,ffffffffc020383e <do_fork+0x30c>
                        last_pid = 1;
ffffffffc020383c:	4785                	li	a5,1
                    goto repeat;
ffffffffc020383e:	4805                	li	a6,1
ffffffffc0203840:	bdcd                	j	ffffffffc0203732 <do_fork+0x200>
    mm_destroy(mm);
ffffffffc0203842:	854e                	mv	a0,s3
ffffffffc0203844:	e3afd0ef          	jal	ra,ffffffffc0200e7e <mm_destroy>
ffffffffc0203848:	bf45                	j	ffffffffc02037f8 <do_fork+0x2c6>
ffffffffc020384a:	00080763          	beqz	a6,ffffffffc0203858 <do_fork+0x326>
ffffffffc020384e:	c19c                	sw	a5,0(a1)
ffffffffc0203850:	853e                	mv	a0,a5
ffffffffc0203852:	b581                	j	ffffffffc0203692 <do_fork+0x160>
    int ret = -E_NO_FREE_PROC;
ffffffffc0203854:	556d                	li	a0,-5
ffffffffc0203856:	bd61                	j	ffffffffc02036ee <do_fork+0x1bc>
ffffffffc0203858:	4188                	lw	a0,0(a1)
ffffffffc020385a:	bd25                	j	ffffffffc0203692 <do_fork+0x160>
    return KADDR(page2pa(page));
ffffffffc020385c:	00002617          	auipc	a2,0x2
ffffffffc0203860:	14460613          	addi	a2,a2,324 # ffffffffc02059a0 <commands+0xa78>
ffffffffc0203864:	06900593          	li	a1,105
ffffffffc0203868:	00002517          	auipc	a0,0x2
ffffffffc020386c:	16050513          	addi	a0,a0,352 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc0203870:	991fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(current->wait_state == 0);
ffffffffc0203874:	00003697          	auipc	a3,0x3
ffffffffc0203878:	8ec68693          	addi	a3,a3,-1812 # ffffffffc0206160 <default_pmm_manager+0x228>
ffffffffc020387c:	00002617          	auipc	a2,0x2
ffffffffc0203880:	a9c60613          	addi	a2,a2,-1380 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0203884:	17300593          	li	a1,371
ffffffffc0203888:	00003517          	auipc	a0,0x3
ffffffffc020388c:	8c050513          	addi	a0,a0,-1856 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc0203890:	971fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc0203894:	86be                	mv	a3,a5
ffffffffc0203896:	00002617          	auipc	a2,0x2
ffffffffc020389a:	17a60613          	addi	a2,a2,378 # ffffffffc0205a10 <commands+0xae8>
ffffffffc020389e:	14600593          	li	a1,326
ffffffffc02038a2:	00003517          	auipc	a0,0x3
ffffffffc02038a6:	8a650513          	addi	a0,a0,-1882 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc02038aa:	957fc0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("Unlock failed.\n");
ffffffffc02038ae:	00003617          	auipc	a2,0x3
ffffffffc02038b2:	8d260613          	addi	a2,a2,-1838 # ffffffffc0206180 <default_pmm_manager+0x248>
ffffffffc02038b6:	03200593          	li	a1,50
ffffffffc02038ba:	00003517          	auipc	a0,0x3
ffffffffc02038be:	8d650513          	addi	a0,a0,-1834 # ffffffffc0206190 <default_pmm_manager+0x258>
ffffffffc02038c2:	93ffc0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02038c6:	00002617          	auipc	a2,0x2
ffffffffc02038ca:	17260613          	addi	a2,a2,370 # ffffffffc0205a38 <commands+0xb10>
ffffffffc02038ce:	06200593          	li	a1,98
ffffffffc02038d2:	00002517          	auipc	a0,0x2
ffffffffc02038d6:	0f650513          	addi	a0,a0,246 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc02038da:	927fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    return pa2page(PADDR(kva));
ffffffffc02038de:	00002617          	auipc	a2,0x2
ffffffffc02038e2:	13260613          	addi	a2,a2,306 # ffffffffc0205a10 <commands+0xae8>
ffffffffc02038e6:	06e00593          	li	a1,110
ffffffffc02038ea:	00002517          	auipc	a0,0x2
ffffffffc02038ee:	0de50513          	addi	a0,a0,222 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc02038f2:	90ffc0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02038f6 <kernel_thread>:
kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags) {
ffffffffc02038f6:	7129                	addi	sp,sp,-320
ffffffffc02038f8:	fa22                	sd	s0,304(sp)
ffffffffc02038fa:	f626                	sd	s1,296(sp)
ffffffffc02038fc:	f24a                	sd	s2,288(sp)
ffffffffc02038fe:	84ae                	mv	s1,a1
ffffffffc0203900:	892a                	mv	s2,a0
ffffffffc0203902:	8432                	mv	s0,a2
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc0203904:	4581                	li	a1,0
ffffffffc0203906:	12000613          	li	a2,288
ffffffffc020390a:	850a                	mv	a0,sp
kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags) {
ffffffffc020390c:	fe06                	sd	ra,312(sp)
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc020390e:	74b000ef          	jal	ra,ffffffffc0204858 <memset>
    tf.gpr.s0 = (uintptr_t)fn;
ffffffffc0203912:	e0ca                	sd	s2,64(sp)
    tf.gpr.s1 = (uintptr_t)arg;
ffffffffc0203914:	e4a6                	sd	s1,72(sp)
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
ffffffffc0203916:	100027f3          	csrr	a5,sstatus
ffffffffc020391a:	edd7f793          	andi	a5,a5,-291
ffffffffc020391e:	1207e793          	ori	a5,a5,288
ffffffffc0203922:	e23e                	sd	a5,256(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0203924:	860a                	mv	a2,sp
ffffffffc0203926:	10046513          	ori	a0,s0,256
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc020392a:	00000797          	auipc	a5,0x0
ffffffffc020392e:	90e78793          	addi	a5,a5,-1778 # ffffffffc0203238 <kernel_thread_entry>
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0203932:	4581                	li	a1,0
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc0203934:	e63e                	sd	a5,264(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0203936:	bfdff0ef          	jal	ra,ffffffffc0203532 <do_fork>
}
ffffffffc020393a:	70f2                	ld	ra,312(sp)
ffffffffc020393c:	7452                	ld	s0,304(sp)
ffffffffc020393e:	74b2                	ld	s1,296(sp)
ffffffffc0203940:	7912                	ld	s2,288(sp)
ffffffffc0203942:	6131                	addi	sp,sp,320
ffffffffc0203944:	8082                	ret

ffffffffc0203946 <do_exit>:
do_exit(int error_code) {
ffffffffc0203946:	7179                	addi	sp,sp,-48
ffffffffc0203948:	f022                	sd	s0,32(sp)
    if (current == idleproc) {
ffffffffc020394a:	00050417          	auipc	s0,0x50
ffffffffc020394e:	af640413          	addi	s0,s0,-1290 # ffffffffc0253440 <current>
ffffffffc0203952:	601c                	ld	a5,0(s0)
do_exit(int error_code) {
ffffffffc0203954:	f406                	sd	ra,40(sp)
ffffffffc0203956:	ec26                	sd	s1,24(sp)
ffffffffc0203958:	e84a                	sd	s2,16(sp)
ffffffffc020395a:	e44e                	sd	s3,8(sp)
ffffffffc020395c:	e052                	sd	s4,0(sp)
    if (current == idleproc) {
ffffffffc020395e:	00050717          	auipc	a4,0x50
ffffffffc0203962:	aea73703          	ld	a4,-1302(a4) # ffffffffc0253448 <idleproc>
ffffffffc0203966:	0ce78c63          	beq	a5,a4,ffffffffc0203a3e <do_exit+0xf8>
    if (current == initproc) {
ffffffffc020396a:	00050497          	auipc	s1,0x50
ffffffffc020396e:	ae648493          	addi	s1,s1,-1306 # ffffffffc0253450 <initproc>
ffffffffc0203972:	6098                	ld	a4,0(s1)
ffffffffc0203974:	0ee78b63          	beq	a5,a4,ffffffffc0203a6a <do_exit+0x124>
    struct mm_struct *mm = current->mm;
ffffffffc0203978:	0287b983          	ld	s3,40(a5)
ffffffffc020397c:	892a                	mv	s2,a0
    if (mm != NULL) {
ffffffffc020397e:	02098663          	beqz	s3,ffffffffc02039aa <do_exit+0x64>
ffffffffc0203982:	00050797          	auipc	a5,0x50
ffffffffc0203986:	bfe7b783          	ld	a5,-1026(a5) # ffffffffc0253580 <boot_cr3>
ffffffffc020398a:	577d                	li	a4,-1
ffffffffc020398c:	177e                	slli	a4,a4,0x3f
ffffffffc020398e:	83b1                	srli	a5,a5,0xc
ffffffffc0203990:	8fd9                	or	a5,a5,a4
ffffffffc0203992:	18079073          	csrw	satp,a5
    mm->mm_count -= 1;
ffffffffc0203996:	0309a783          	lw	a5,48(s3) # 80030 <_binary_obj___user_ex3_out_size+0x75340>
ffffffffc020399a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020399e:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0) {
ffffffffc02039a2:	cb55                	beqz	a4,ffffffffc0203a56 <do_exit+0x110>
        current->mm = NULL;
ffffffffc02039a4:	601c                	ld	a5,0(s0)
ffffffffc02039a6:	0207b423          	sd	zero,40(a5)
    current->state = PROC_ZOMBIE;
ffffffffc02039aa:	601c                	ld	a5,0(s0)
ffffffffc02039ac:	470d                	li	a4,3
ffffffffc02039ae:	c398                	sw	a4,0(a5)
    current->exit_code = error_code;
ffffffffc02039b0:	0f27a423          	sw	s2,232(a5)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02039b4:	100027f3          	csrr	a5,sstatus
ffffffffc02039b8:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02039ba:	4a01                	li	s4,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02039bc:	e3f9                	bnez	a5,ffffffffc0203a82 <do_exit+0x13c>
        proc = current->parent;
ffffffffc02039be:	6018                	ld	a4,0(s0)
        if (proc->wait_state == WT_CHILD) {
ffffffffc02039c0:	800007b7          	lui	a5,0x80000
ffffffffc02039c4:	0785                	addi	a5,a5,1
        proc = current->parent;
ffffffffc02039c6:	7308                	ld	a0,32(a4)
        if (proc->wait_state == WT_CHILD) {
ffffffffc02039c8:	0ec52703          	lw	a4,236(a0)
ffffffffc02039cc:	0af70f63          	beq	a4,a5,ffffffffc0203a8a <do_exit+0x144>
        while (current->cptr != NULL) {
ffffffffc02039d0:	6018                	ld	a4,0(s0)
ffffffffc02039d2:	7b7c                	ld	a5,240(a4)
ffffffffc02039d4:	c3a1                	beqz	a5,ffffffffc0203a14 <do_exit+0xce>
                if (initproc->wait_state == WT_CHILD) {
ffffffffc02039d6:	800009b7          	lui	s3,0x80000
            if (proc->state == PROC_ZOMBIE) {
ffffffffc02039da:	490d                	li	s2,3
                if (initproc->wait_state == WT_CHILD) {
ffffffffc02039dc:	0985                	addi	s3,s3,1
ffffffffc02039de:	a021                	j	ffffffffc02039e6 <do_exit+0xa0>
        while (current->cptr != NULL) {
ffffffffc02039e0:	6018                	ld	a4,0(s0)
ffffffffc02039e2:	7b7c                	ld	a5,240(a4)
ffffffffc02039e4:	cb85                	beqz	a5,ffffffffc0203a14 <do_exit+0xce>
            current->cptr = proc->optr;
ffffffffc02039e6:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_obj___user_ex3_out_size+0xffffffff7fff5410>
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc02039ea:	6088                	ld	a0,0(s1)
            current->cptr = proc->optr;
ffffffffc02039ec:	fb74                	sd	a3,240(a4)
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc02039ee:	7978                	ld	a4,240(a0)
            proc->yptr = NULL;
ffffffffc02039f0:	0e07bc23          	sd	zero,248(a5)
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc02039f4:	10e7b023          	sd	a4,256(a5)
ffffffffc02039f8:	c311                	beqz	a4,ffffffffc02039fc <do_exit+0xb6>
                initproc->cptr->yptr = proc;
ffffffffc02039fa:	ff7c                	sd	a5,248(a4)
            if (proc->state == PROC_ZOMBIE) {
ffffffffc02039fc:	4398                	lw	a4,0(a5)
            proc->parent = initproc;
ffffffffc02039fe:	f388                	sd	a0,32(a5)
            initproc->cptr = proc;
ffffffffc0203a00:	f97c                	sd	a5,240(a0)
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203a02:	fd271fe3          	bne	a4,s2,ffffffffc02039e0 <do_exit+0x9a>
                if (initproc->wait_state == WT_CHILD) {
ffffffffc0203a06:	0ec52783          	lw	a5,236(a0)
ffffffffc0203a0a:	fd379be3          	bne	a5,s3,ffffffffc02039e0 <do_exit+0x9a>
                    wakeup_proc(initproc);
ffffffffc0203a0e:	287000ef          	jal	ra,ffffffffc0204494 <wakeup_proc>
ffffffffc0203a12:	b7f9                	j	ffffffffc02039e0 <do_exit+0x9a>
    if (flag) {
ffffffffc0203a14:	020a1263          	bnez	s4,ffffffffc0203a38 <do_exit+0xf2>
    schedule();
ffffffffc0203a18:	32f000ef          	jal	ra,ffffffffc0204546 <schedule>
    panic("do_exit will not return!! %d.\n", current->pid);
ffffffffc0203a1c:	601c                	ld	a5,0(s0)
ffffffffc0203a1e:	00002617          	auipc	a2,0x2
ffffffffc0203a22:	7aa60613          	addi	a2,a2,1962 # ffffffffc02061c8 <default_pmm_manager+0x290>
ffffffffc0203a26:	1c600593          	li	a1,454
ffffffffc0203a2a:	43d4                	lw	a3,4(a5)
ffffffffc0203a2c:	00002517          	auipc	a0,0x2
ffffffffc0203a30:	71c50513          	addi	a0,a0,1820 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc0203a34:	fccfc0ef          	jal	ra,ffffffffc0200200 <__panic>
        intr_enable();
ffffffffc0203a38:	bc1fc0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc0203a3c:	bff1                	j	ffffffffc0203a18 <do_exit+0xd2>
        panic("idleproc exit.\n");
ffffffffc0203a3e:	00002617          	auipc	a2,0x2
ffffffffc0203a42:	76a60613          	addi	a2,a2,1898 # ffffffffc02061a8 <default_pmm_manager+0x270>
ffffffffc0203a46:	19a00593          	li	a1,410
ffffffffc0203a4a:	00002517          	auipc	a0,0x2
ffffffffc0203a4e:	6fe50513          	addi	a0,a0,1790 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc0203a52:	faefc0ef          	jal	ra,ffffffffc0200200 <__panic>
            exit_mmap(mm);
ffffffffc0203a56:	854e                	mv	a0,s3
ffffffffc0203a58:	dc2fd0ef          	jal	ra,ffffffffc020101a <exit_mmap>
            put_pgdir(mm);
ffffffffc0203a5c:	854e                	mv	a0,s3
ffffffffc0203a5e:	8efff0ef          	jal	ra,ffffffffc020334c <put_pgdir>
            mm_destroy(mm);
ffffffffc0203a62:	854e                	mv	a0,s3
ffffffffc0203a64:	c1afd0ef          	jal	ra,ffffffffc0200e7e <mm_destroy>
ffffffffc0203a68:	bf35                	j	ffffffffc02039a4 <do_exit+0x5e>
        panic("initproc exit.\n");
ffffffffc0203a6a:	00002617          	auipc	a2,0x2
ffffffffc0203a6e:	74e60613          	addi	a2,a2,1870 # ffffffffc02061b8 <default_pmm_manager+0x280>
ffffffffc0203a72:	19d00593          	li	a1,413
ffffffffc0203a76:	00002517          	auipc	a0,0x2
ffffffffc0203a7a:	6d250513          	addi	a0,a0,1746 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc0203a7e:	f82fc0ef          	jal	ra,ffffffffc0200200 <__panic>
        intr_disable();
ffffffffc0203a82:	b7dfc0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc0203a86:	4a05                	li	s4,1
ffffffffc0203a88:	bf1d                	j	ffffffffc02039be <do_exit+0x78>
            wakeup_proc(proc);
ffffffffc0203a8a:	20b000ef          	jal	ra,ffffffffc0204494 <wakeup_proc>
ffffffffc0203a8e:	b789                	j	ffffffffc02039d0 <do_exit+0x8a>

ffffffffc0203a90 <do_wait.part.0>:
do_wait(int pid, int *code_store) {
ffffffffc0203a90:	7139                	addi	sp,sp,-64
ffffffffc0203a92:	e852                	sd	s4,16(sp)
        current->wait_state = WT_CHILD;
ffffffffc0203a94:	80000a37          	lui	s4,0x80000
do_wait(int pid, int *code_store) {
ffffffffc0203a98:	f426                	sd	s1,40(sp)
ffffffffc0203a9a:	f04a                	sd	s2,32(sp)
ffffffffc0203a9c:	ec4e                	sd	s3,24(sp)
ffffffffc0203a9e:	e456                	sd	s5,8(sp)
ffffffffc0203aa0:	e05a                	sd	s6,0(sp)
ffffffffc0203aa2:	fc06                	sd	ra,56(sp)
ffffffffc0203aa4:	f822                	sd	s0,48(sp)
ffffffffc0203aa6:	892a                	mv	s2,a0
ffffffffc0203aa8:	8aae                	mv	s5,a1
        proc = current->cptr;
ffffffffc0203aaa:	00050997          	auipc	s3,0x50
ffffffffc0203aae:	99698993          	addi	s3,s3,-1642 # ffffffffc0253440 <current>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203ab2:	448d                	li	s1,3
        current->state = PROC_SLEEPING;
ffffffffc0203ab4:	4b05                	li	s6,1
        current->wait_state = WT_CHILD;
ffffffffc0203ab6:	2a05                	addiw	s4,s4,1
    if (pid != 0) {
ffffffffc0203ab8:	02090f63          	beqz	s2,ffffffffc0203af6 <do_wait.part.0+0x66>
        proc = find_proc(pid);
ffffffffc0203abc:	854a                	mv	a0,s2
ffffffffc0203abe:	a1dff0ef          	jal	ra,ffffffffc02034da <find_proc>
ffffffffc0203ac2:	842a                	mv	s0,a0
        if (proc != NULL && proc->parent == current) {
ffffffffc0203ac4:	10050763          	beqz	a0,ffffffffc0203bd2 <do_wait.part.0+0x142>
ffffffffc0203ac8:	0009b703          	ld	a4,0(s3)
ffffffffc0203acc:	711c                	ld	a5,32(a0)
ffffffffc0203ace:	10e79263          	bne	a5,a4,ffffffffc0203bd2 <do_wait.part.0+0x142>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203ad2:	411c                	lw	a5,0(a0)
ffffffffc0203ad4:	02978c63          	beq	a5,s1,ffffffffc0203b0c <do_wait.part.0+0x7c>
        current->state = PROC_SLEEPING;
ffffffffc0203ad8:	01672023          	sw	s6,0(a4)
        current->wait_state = WT_CHILD;
ffffffffc0203adc:	0f472623          	sw	s4,236(a4)
        schedule();
ffffffffc0203ae0:	267000ef          	jal	ra,ffffffffc0204546 <schedule>
        if (current->flags & PF_EXITING) {
ffffffffc0203ae4:	0009b783          	ld	a5,0(s3)
ffffffffc0203ae8:	0b07a783          	lw	a5,176(a5)
ffffffffc0203aec:	8b85                	andi	a5,a5,1
ffffffffc0203aee:	d7e9                	beqz	a5,ffffffffc0203ab8 <do_wait.part.0+0x28>
            do_exit(-E_KILLED);
ffffffffc0203af0:	555d                	li	a0,-9
ffffffffc0203af2:	e55ff0ef          	jal	ra,ffffffffc0203946 <do_exit>
        proc = current->cptr;
ffffffffc0203af6:	0009b703          	ld	a4,0(s3)
ffffffffc0203afa:	7b60                	ld	s0,240(a4)
        for (; proc != NULL; proc = proc->optr) {
ffffffffc0203afc:	e409                	bnez	s0,ffffffffc0203b06 <do_wait.part.0+0x76>
ffffffffc0203afe:	a8d1                	j	ffffffffc0203bd2 <do_wait.part.0+0x142>
ffffffffc0203b00:	10043403          	ld	s0,256(s0)
ffffffffc0203b04:	d871                	beqz	s0,ffffffffc0203ad8 <do_wait.part.0+0x48>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203b06:	401c                	lw	a5,0(s0)
ffffffffc0203b08:	fe979ce3          	bne	a5,s1,ffffffffc0203b00 <do_wait.part.0+0x70>
    if (proc == idleproc || proc == initproc) {
ffffffffc0203b0c:	00050797          	auipc	a5,0x50
ffffffffc0203b10:	93c7b783          	ld	a5,-1732(a5) # ffffffffc0253448 <idleproc>
ffffffffc0203b14:	0c878563          	beq	a5,s0,ffffffffc0203bde <do_wait.part.0+0x14e>
ffffffffc0203b18:	00050797          	auipc	a5,0x50
ffffffffc0203b1c:	9387b783          	ld	a5,-1736(a5) # ffffffffc0253450 <initproc>
ffffffffc0203b20:	0af40f63          	beq	s0,a5,ffffffffc0203bde <do_wait.part.0+0x14e>
    if (code_store != NULL) {
ffffffffc0203b24:	000a8663          	beqz	s5,ffffffffc0203b30 <do_wait.part.0+0xa0>
        *code_store = proc->exit_code;
ffffffffc0203b28:	0e842783          	lw	a5,232(s0)
ffffffffc0203b2c:	00faa023          	sw	a5,0(s5)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203b30:	100027f3          	csrr	a5,sstatus
ffffffffc0203b34:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203b36:	4581                	li	a1,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203b38:	efd9                	bnez	a5,ffffffffc0203bd6 <do_wait.part.0+0x146>
    __list_del(listelm->prev, listelm->next);
ffffffffc0203b3a:	6c70                	ld	a2,216(s0)
ffffffffc0203b3c:	7074                	ld	a3,224(s0)
    if (proc->optr != NULL) {
ffffffffc0203b3e:	10043703          	ld	a4,256(s0)
ffffffffc0203b42:	7c7c                	ld	a5,248(s0)
    prev->next = next;
ffffffffc0203b44:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0203b46:	e290                	sd	a2,0(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0203b48:	6470                	ld	a2,200(s0)
ffffffffc0203b4a:	6874                	ld	a3,208(s0)
    prev->next = next;
ffffffffc0203b4c:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0203b4e:	e290                	sd	a2,0(a3)
ffffffffc0203b50:	c319                	beqz	a4,ffffffffc0203b56 <do_wait.part.0+0xc6>
        proc->optr->yptr = proc->yptr;
ffffffffc0203b52:	ff7c                	sd	a5,248(a4)
ffffffffc0203b54:	7c7c                	ld	a5,248(s0)
    if (proc->yptr != NULL) {
ffffffffc0203b56:	cbbd                	beqz	a5,ffffffffc0203bcc <do_wait.part.0+0x13c>
        proc->yptr->optr = proc->optr;
ffffffffc0203b58:	10e7b023          	sd	a4,256(a5)
    nr_process --;
ffffffffc0203b5c:	00050717          	auipc	a4,0x50
ffffffffc0203b60:	8fc70713          	addi	a4,a4,-1796 # ffffffffc0253458 <nr_process>
ffffffffc0203b64:	431c                	lw	a5,0(a4)
ffffffffc0203b66:	37fd                	addiw	a5,a5,-1
ffffffffc0203b68:	c31c                	sw	a5,0(a4)
    if (flag) {
ffffffffc0203b6a:	edb1                	bnez	a1,ffffffffc0203bc6 <do_wait.part.0+0x136>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc0203b6c:	6814                	ld	a3,16(s0)
ffffffffc0203b6e:	c02007b7          	lui	a5,0xc0200
ffffffffc0203b72:	08f6ee63          	bltu	a3,a5,ffffffffc0203c0e <do_wait.part.0+0x17e>
ffffffffc0203b76:	00050797          	auipc	a5,0x50
ffffffffc0203b7a:	a027b783          	ld	a5,-1534(a5) # ffffffffc0253578 <va_pa_offset>
ffffffffc0203b7e:	8e9d                	sub	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0203b80:	82b1                	srli	a3,a3,0xc
ffffffffc0203b82:	00050797          	auipc	a5,0x50
ffffffffc0203b86:	8b67b783          	ld	a5,-1866(a5) # ffffffffc0253438 <npage>
ffffffffc0203b8a:	06f6f663          	bgeu	a3,a5,ffffffffc0203bf6 <do_wait.part.0+0x166>
    return &pages[PPN(pa) - nbase];
ffffffffc0203b8e:	00003517          	auipc	a0,0x3
ffffffffc0203b92:	60253503          	ld	a0,1538(a0) # ffffffffc0207190 <nbase>
ffffffffc0203b96:	8e89                	sub	a3,a3,a0
ffffffffc0203b98:	069a                	slli	a3,a3,0x6
ffffffffc0203b9a:	00050517          	auipc	a0,0x50
ffffffffc0203b9e:	9ee53503          	ld	a0,-1554(a0) # ffffffffc0253588 <pages>
ffffffffc0203ba2:	9536                	add	a0,a0,a3
ffffffffc0203ba4:	4589                	li	a1,2
ffffffffc0203ba6:	b9bfe0ef          	jal	ra,ffffffffc0202740 <free_pages>
    kfree(proc);
ffffffffc0203baa:	8522                	mv	a0,s0
ffffffffc0203bac:	d1dfd0ef          	jal	ra,ffffffffc02018c8 <kfree>
    return 0;
ffffffffc0203bb0:	4501                	li	a0,0
}
ffffffffc0203bb2:	70e2                	ld	ra,56(sp)
ffffffffc0203bb4:	7442                	ld	s0,48(sp)
ffffffffc0203bb6:	74a2                	ld	s1,40(sp)
ffffffffc0203bb8:	7902                	ld	s2,32(sp)
ffffffffc0203bba:	69e2                	ld	s3,24(sp)
ffffffffc0203bbc:	6a42                	ld	s4,16(sp)
ffffffffc0203bbe:	6aa2                	ld	s5,8(sp)
ffffffffc0203bc0:	6b02                	ld	s6,0(sp)
ffffffffc0203bc2:	6121                	addi	sp,sp,64
ffffffffc0203bc4:	8082                	ret
        intr_enable();
ffffffffc0203bc6:	a33fc0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc0203bca:	b74d                	j	ffffffffc0203b6c <do_wait.part.0+0xdc>
       proc->parent->cptr = proc->optr;
ffffffffc0203bcc:	701c                	ld	a5,32(s0)
ffffffffc0203bce:	fbf8                	sd	a4,240(a5)
ffffffffc0203bd0:	b771                	j	ffffffffc0203b5c <do_wait.part.0+0xcc>
    return -E_BAD_PROC;
ffffffffc0203bd2:	5579                	li	a0,-2
ffffffffc0203bd4:	bff9                	j	ffffffffc0203bb2 <do_wait.part.0+0x122>
        intr_disable();
ffffffffc0203bd6:	a29fc0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc0203bda:	4585                	li	a1,1
ffffffffc0203bdc:	bfb9                	j	ffffffffc0203b3a <do_wait.part.0+0xaa>
        panic("wait idleproc or initproc.\n");
ffffffffc0203bde:	00002617          	auipc	a2,0x2
ffffffffc0203be2:	60a60613          	addi	a2,a2,1546 # ffffffffc02061e8 <default_pmm_manager+0x2b0>
ffffffffc0203be6:	2b500593          	li	a1,693
ffffffffc0203bea:	00002517          	auipc	a0,0x2
ffffffffc0203bee:	55e50513          	addi	a0,a0,1374 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc0203bf2:	e0efc0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203bf6:	00002617          	auipc	a2,0x2
ffffffffc0203bfa:	e4260613          	addi	a2,a2,-446 # ffffffffc0205a38 <commands+0xb10>
ffffffffc0203bfe:	06200593          	li	a1,98
ffffffffc0203c02:	00002517          	auipc	a0,0x2
ffffffffc0203c06:	dc650513          	addi	a0,a0,-570 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc0203c0a:	df6fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0203c0e:	00002617          	auipc	a2,0x2
ffffffffc0203c12:	e0260613          	addi	a2,a2,-510 # ffffffffc0205a10 <commands+0xae8>
ffffffffc0203c16:	06e00593          	li	a1,110
ffffffffc0203c1a:	00002517          	auipc	a0,0x2
ffffffffc0203c1e:	dae50513          	addi	a0,a0,-594 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc0203c22:	ddefc0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0203c26 <init_main>:
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg) {
ffffffffc0203c26:	1141                	addi	sp,sp,-16
ffffffffc0203c28:	e406                	sd	ra,8(sp)
    size_t nr_free_pages_store = nr_free_pages();
ffffffffc0203c2a:	b59fe0ef          	jal	ra,ffffffffc0202782 <nr_free_pages>
    size_t kernel_allocated_store = kallocated();
ffffffffc0203c2e:	be7fd0ef          	jal	ra,ffffffffc0201814 <kallocated>

    int pid = kernel_thread(user_main, NULL, 0);
ffffffffc0203c32:	4601                	li	a2,0
ffffffffc0203c34:	4581                	li	a1,0
ffffffffc0203c36:	fffff517          	auipc	a0,0xfffff
ffffffffc0203c3a:	69850513          	addi	a0,a0,1688 # ffffffffc02032ce <user_main>
ffffffffc0203c3e:	cb9ff0ef          	jal	ra,ffffffffc02038f6 <kernel_thread>
    if (pid <= 0) {
ffffffffc0203c42:	00a04563          	bgtz	a0,ffffffffc0203c4c <init_main+0x26>
ffffffffc0203c46:	a071                	j	ffffffffc0203cd2 <init_main+0xac>
        panic("create user_main failed.\n");
    }

    while (do_wait(0, NULL) == 0) {
        schedule();
ffffffffc0203c48:	0ff000ef          	jal	ra,ffffffffc0204546 <schedule>
    if (code_store != NULL) {
ffffffffc0203c4c:	4581                	li	a1,0
ffffffffc0203c4e:	4501                	li	a0,0
ffffffffc0203c50:	e41ff0ef          	jal	ra,ffffffffc0203a90 <do_wait.part.0>
    while (do_wait(0, NULL) == 0) {
ffffffffc0203c54:	d975                	beqz	a0,ffffffffc0203c48 <init_main+0x22>
    }

    cprintf("all user-mode processes have quit.\n");
ffffffffc0203c56:	00002517          	auipc	a0,0x2
ffffffffc0203c5a:	5d250513          	addi	a0,a0,1490 # ffffffffc0206228 <default_pmm_manager+0x2f0>
ffffffffc0203c5e:	c66fc0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0203c62:	0004f797          	auipc	a5,0x4f
ffffffffc0203c66:	7ee7b783          	ld	a5,2030(a5) # ffffffffc0253450 <initproc>
ffffffffc0203c6a:	7bf8                	ld	a4,240(a5)
ffffffffc0203c6c:	e339                	bnez	a4,ffffffffc0203cb2 <init_main+0x8c>
ffffffffc0203c6e:	7ff8                	ld	a4,248(a5)
ffffffffc0203c70:	e329                	bnez	a4,ffffffffc0203cb2 <init_main+0x8c>
ffffffffc0203c72:	1007b703          	ld	a4,256(a5)
ffffffffc0203c76:	ef15                	bnez	a4,ffffffffc0203cb2 <init_main+0x8c>
    assert(nr_process == 2);
ffffffffc0203c78:	0004f697          	auipc	a3,0x4f
ffffffffc0203c7c:	7e06a683          	lw	a3,2016(a3) # ffffffffc0253458 <nr_process>
ffffffffc0203c80:	4709                	li	a4,2
ffffffffc0203c82:	0ae69463          	bne	a3,a4,ffffffffc0203d2a <init_main+0x104>
    return listelm->next;
ffffffffc0203c86:	00050697          	auipc	a3,0x50
ffffffffc0203c8a:	90a68693          	addi	a3,a3,-1782 # ffffffffc0253590 <proc_list>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0203c8e:	6698                	ld	a4,8(a3)
ffffffffc0203c90:	0c878793          	addi	a5,a5,200
ffffffffc0203c94:	06f71b63          	bne	a4,a5,ffffffffc0203d0a <init_main+0xe4>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0203c98:	629c                	ld	a5,0(a3)
ffffffffc0203c9a:	04f71863          	bne	a4,a5,ffffffffc0203cea <init_main+0xc4>

    //cprintf("init check memory pass.\n");
    cprintf("The end of init_main\n");
ffffffffc0203c9e:	00002517          	auipc	a0,0x2
ffffffffc0203ca2:	67250513          	addi	a0,a0,1650 # ffffffffc0206310 <default_pmm_manager+0x3d8>
ffffffffc0203ca6:	c1efc0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    return 0;
}
ffffffffc0203caa:	60a2                	ld	ra,8(sp)
ffffffffc0203cac:	4501                	li	a0,0
ffffffffc0203cae:	0141                	addi	sp,sp,16
ffffffffc0203cb0:	8082                	ret
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0203cb2:	00002697          	auipc	a3,0x2
ffffffffc0203cb6:	59e68693          	addi	a3,a3,1438 # ffffffffc0206250 <default_pmm_manager+0x318>
ffffffffc0203cba:	00001617          	auipc	a2,0x1
ffffffffc0203cbe:	65e60613          	addi	a2,a2,1630 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0203cc2:	31900593          	li	a1,793
ffffffffc0203cc6:	00002517          	auipc	a0,0x2
ffffffffc0203cca:	48250513          	addi	a0,a0,1154 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc0203cce:	d32fc0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("create user_main failed.\n");
ffffffffc0203cd2:	00002617          	auipc	a2,0x2
ffffffffc0203cd6:	53660613          	addi	a2,a2,1334 # ffffffffc0206208 <default_pmm_manager+0x2d0>
ffffffffc0203cda:	31100593          	li	a1,785
ffffffffc0203cde:	00002517          	auipc	a0,0x2
ffffffffc0203ce2:	46a50513          	addi	a0,a0,1130 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc0203ce6:	d1afc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0203cea:	00002697          	auipc	a3,0x2
ffffffffc0203cee:	5f668693          	addi	a3,a3,1526 # ffffffffc02062e0 <default_pmm_manager+0x3a8>
ffffffffc0203cf2:	00001617          	auipc	a2,0x1
ffffffffc0203cf6:	62660613          	addi	a2,a2,1574 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0203cfa:	31c00593          	li	a1,796
ffffffffc0203cfe:	00002517          	auipc	a0,0x2
ffffffffc0203d02:	44a50513          	addi	a0,a0,1098 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc0203d06:	cfafc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0203d0a:	00002697          	auipc	a3,0x2
ffffffffc0203d0e:	5a668693          	addi	a3,a3,1446 # ffffffffc02062b0 <default_pmm_manager+0x378>
ffffffffc0203d12:	00001617          	auipc	a2,0x1
ffffffffc0203d16:	60660613          	addi	a2,a2,1542 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0203d1a:	31b00593          	li	a1,795
ffffffffc0203d1e:	00002517          	auipc	a0,0x2
ffffffffc0203d22:	42a50513          	addi	a0,a0,1066 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc0203d26:	cdafc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(nr_process == 2);
ffffffffc0203d2a:	00002697          	auipc	a3,0x2
ffffffffc0203d2e:	57668693          	addi	a3,a3,1398 # ffffffffc02062a0 <default_pmm_manager+0x368>
ffffffffc0203d32:	00001617          	auipc	a2,0x1
ffffffffc0203d36:	5e660613          	addi	a2,a2,1510 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0203d3a:	31a00593          	li	a1,794
ffffffffc0203d3e:	00002517          	auipc	a0,0x2
ffffffffc0203d42:	40a50513          	addi	a0,a0,1034 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc0203d46:	cbafc0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0203d4a <do_execve>:
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d4a:	7135                	addi	sp,sp,-160
ffffffffc0203d4c:	f4d6                	sd	s5,104(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0203d4e:	0004fa97          	auipc	s5,0x4f
ffffffffc0203d52:	6f2a8a93          	addi	s5,s5,1778 # ffffffffc0253440 <current>
ffffffffc0203d56:	000ab783          	ld	a5,0(s5)
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d5a:	f8d2                	sd	s4,112(sp)
ffffffffc0203d5c:	e526                	sd	s1,136(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0203d5e:	0287ba03          	ld	s4,40(a5)
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d62:	e14a                	sd	s2,128(sp)
ffffffffc0203d64:	fcce                	sd	s3,120(sp)
ffffffffc0203d66:	892a                	mv	s2,a0
ffffffffc0203d68:	84ae                	mv	s1,a1
ffffffffc0203d6a:	89b2                	mv	s3,a2
    if (!user_mem_check(mm, (uintptr_t)name, len, 0)) {
ffffffffc0203d6c:	4681                	li	a3,0
ffffffffc0203d6e:	862e                	mv	a2,a1
ffffffffc0203d70:	85aa                	mv	a1,a0
ffffffffc0203d72:	8552                	mv	a0,s4
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d74:	ed06                	sd	ra,152(sp)
ffffffffc0203d76:	e922                	sd	s0,144(sp)
ffffffffc0203d78:	f0da                	sd	s6,96(sp)
ffffffffc0203d7a:	ecde                	sd	s7,88(sp)
ffffffffc0203d7c:	e8e2                	sd	s8,80(sp)
ffffffffc0203d7e:	e4e6                	sd	s9,72(sp)
ffffffffc0203d80:	e0ea                	sd	s10,64(sp)
ffffffffc0203d82:	fc6e                	sd	s11,56(sp)
    if (!user_mem_check(mm, (uintptr_t)name, len, 0)) {
ffffffffc0203d84:	c10fd0ef          	jal	ra,ffffffffc0201194 <user_mem_check>
ffffffffc0203d88:	3e050763          	beqz	a0,ffffffffc0204176 <do_execve+0x42c>
    memset(local_name, 0, sizeof(local_name));
ffffffffc0203d8c:	4641                	li	a2,16
ffffffffc0203d8e:	4581                	li	a1,0
ffffffffc0203d90:	1008                	addi	a0,sp,32
ffffffffc0203d92:	2c7000ef          	jal	ra,ffffffffc0204858 <memset>
    memcpy(local_name, name, len);
ffffffffc0203d96:	47bd                	li	a5,15
ffffffffc0203d98:	8626                	mv	a2,s1
ffffffffc0203d9a:	0697ed63          	bltu	a5,s1,ffffffffc0203e14 <do_execve+0xca>
ffffffffc0203d9e:	85ca                	mv	a1,s2
ffffffffc0203da0:	1008                	addi	a0,sp,32
ffffffffc0203da2:	2c9000ef          	jal	ra,ffffffffc020486a <memcpy>
    if (mm != NULL) {
ffffffffc0203da6:	060a0e63          	beqz	s4,ffffffffc0203e22 <do_execve+0xd8>
        cputs("mm != NULL");
ffffffffc0203daa:	00002517          	auipc	a0,0x2
ffffffffc0203dae:	90650513          	addi	a0,a0,-1786 # ffffffffc02056b0 <commands+0x788>
ffffffffc0203db2:	b4afc0ef          	jal	ra,ffffffffc02000fc <cputs>
ffffffffc0203db6:	0004f797          	auipc	a5,0x4f
ffffffffc0203dba:	7ca7b783          	ld	a5,1994(a5) # ffffffffc0253580 <boot_cr3>
ffffffffc0203dbe:	577d                	li	a4,-1
ffffffffc0203dc0:	177e                	slli	a4,a4,0x3f
ffffffffc0203dc2:	83b1                	srli	a5,a5,0xc
ffffffffc0203dc4:	8fd9                	or	a5,a5,a4
ffffffffc0203dc6:	18079073          	csrw	satp,a5
ffffffffc0203dca:	030a2783          	lw	a5,48(s4) # ffffffff80000030 <_binary_obj___user_ex3_out_size+0xffffffff7fff5340>
ffffffffc0203dce:	fff7871b          	addiw	a4,a5,-1
ffffffffc0203dd2:	02ea2823          	sw	a4,48(s4)
        if (mm_count_dec(mm) == 0) {
ffffffffc0203dd6:	28070663          	beqz	a4,ffffffffc0204062 <do_execve+0x318>
        current->mm = NULL;
ffffffffc0203dda:	000ab783          	ld	a5,0(s5)
ffffffffc0203dde:	0207b423          	sd	zero,40(a5)
    if ((mm = mm_create()) == NULL) {
ffffffffc0203de2:	f45fc0ef          	jal	ra,ffffffffc0200d26 <mm_create>
ffffffffc0203de6:	84aa                	mv	s1,a0
ffffffffc0203de8:	c135                	beqz	a0,ffffffffc0203e4c <do_execve+0x102>
    if (setup_pgdir(mm) != 0) {
ffffffffc0203dea:	dd8ff0ef          	jal	ra,ffffffffc02033c2 <setup_pgdir>
ffffffffc0203dee:	e931                	bnez	a0,ffffffffc0203e42 <do_execve+0xf8>
    if (elf->e_magic != ELF_MAGIC) {
ffffffffc0203df0:	0009a703          	lw	a4,0(s3)
ffffffffc0203df4:	464c47b7          	lui	a5,0x464c4
ffffffffc0203df8:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_obj___user_ex3_out_size+0x464b988f>
ffffffffc0203dfc:	04f70a63          	beq	a4,a5,ffffffffc0203e50 <do_execve+0x106>
    put_pgdir(mm);
ffffffffc0203e00:	8526                	mv	a0,s1
ffffffffc0203e02:	d4aff0ef          	jal	ra,ffffffffc020334c <put_pgdir>
    mm_destroy(mm);
ffffffffc0203e06:	8526                	mv	a0,s1
ffffffffc0203e08:	876fd0ef          	jal	ra,ffffffffc0200e7e <mm_destroy>
        ret = -E_INVAL_ELF;
ffffffffc0203e0c:	5a61                	li	s4,-8
    do_exit(ret);
ffffffffc0203e0e:	8552                	mv	a0,s4
ffffffffc0203e10:	b37ff0ef          	jal	ra,ffffffffc0203946 <do_exit>
    memcpy(local_name, name, len);
ffffffffc0203e14:	463d                	li	a2,15
ffffffffc0203e16:	85ca                	mv	a1,s2
ffffffffc0203e18:	1008                	addi	a0,sp,32
ffffffffc0203e1a:	251000ef          	jal	ra,ffffffffc020486a <memcpy>
    if (mm != NULL) {
ffffffffc0203e1e:	f80a16e3          	bnez	s4,ffffffffc0203daa <do_execve+0x60>
    if (current->mm != NULL) {
ffffffffc0203e22:	000ab783          	ld	a5,0(s5)
ffffffffc0203e26:	779c                	ld	a5,40(a5)
ffffffffc0203e28:	dfcd                	beqz	a5,ffffffffc0203de2 <do_execve+0x98>
        panic("load_icode: current->mm must be empty.\n");
ffffffffc0203e2a:	00002617          	auipc	a2,0x2
ffffffffc0203e2e:	4fe60613          	addi	a2,a2,1278 # ffffffffc0206328 <default_pmm_manager+0x3f0>
ffffffffc0203e32:	1d000593          	li	a1,464
ffffffffc0203e36:	00002517          	auipc	a0,0x2
ffffffffc0203e3a:	31250513          	addi	a0,a0,786 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc0203e3e:	bc2fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    mm_destroy(mm);
ffffffffc0203e42:	8526                	mv	a0,s1
ffffffffc0203e44:	83afd0ef          	jal	ra,ffffffffc0200e7e <mm_destroy>
    int ret = -E_NO_MEM;
ffffffffc0203e48:	5a71                	li	s4,-4
ffffffffc0203e4a:	b7d1                	j	ffffffffc0203e0e <do_execve+0xc4>
ffffffffc0203e4c:	5a71                	li	s4,-4
ffffffffc0203e4e:	b7c1                	j	ffffffffc0203e0e <do_execve+0xc4>
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e50:	0389d703          	lhu	a4,56(s3)
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0203e54:	0209b903          	ld	s2,32(s3)
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e58:	00371793          	slli	a5,a4,0x3
ffffffffc0203e5c:	8f99                	sub	a5,a5,a4
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0203e5e:	994e                	add	s2,s2,s3
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e60:	078e                	slli	a5,a5,0x3
ffffffffc0203e62:	97ca                	add	a5,a5,s2
ffffffffc0203e64:	ec3e                	sd	a5,24(sp)
    for (; ph < ph_end; ph ++) {
ffffffffc0203e66:	02f97c63          	bgeu	s2,a5,ffffffffc0203e9e <do_execve+0x154>
    return KADDR(page2pa(page));
ffffffffc0203e6a:	5bfd                	li	s7,-1
ffffffffc0203e6c:	00cbd793          	srli	a5,s7,0xc
    return page - pages + nbase;
ffffffffc0203e70:	0004fd97          	auipc	s11,0x4f
ffffffffc0203e74:	718d8d93          	addi	s11,s11,1816 # ffffffffc0253588 <pages>
ffffffffc0203e78:	00003d17          	auipc	s10,0x3
ffffffffc0203e7c:	318d0d13          	addi	s10,s10,792 # ffffffffc0207190 <nbase>
    return KADDR(page2pa(page));
ffffffffc0203e80:	e43e                	sd	a5,8(sp)
ffffffffc0203e82:	0004fc97          	auipc	s9,0x4f
ffffffffc0203e86:	5b6c8c93          	addi	s9,s9,1462 # ffffffffc0253438 <npage>
        if (ph->p_type != ELF_PT_LOAD) {
ffffffffc0203e8a:	00092703          	lw	a4,0(s2)
ffffffffc0203e8e:	4785                	li	a5,1
ffffffffc0203e90:	0ef70463          	beq	a4,a5,ffffffffc0203f78 <do_execve+0x22e>
    for (; ph < ph_end; ph ++) {
ffffffffc0203e94:	67e2                	ld	a5,24(sp)
ffffffffc0203e96:	03890913          	addi	s2,s2,56
ffffffffc0203e9a:	fef968e3          	bltu	s2,a5,ffffffffc0203e8a <do_execve+0x140>
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0) {
ffffffffc0203e9e:	4701                	li	a4,0
ffffffffc0203ea0:	46ad                	li	a3,11
ffffffffc0203ea2:	00100637          	lui	a2,0x100
ffffffffc0203ea6:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0203eaa:	8526                	mv	a0,s1
ffffffffc0203eac:	824fd0ef          	jal	ra,ffffffffc0200ed0 <mm_map>
ffffffffc0203eb0:	8a2a                	mv	s4,a0
ffffffffc0203eb2:	18051e63          	bnez	a0,ffffffffc020404e <do_execve+0x304>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-PGSIZE , PTE_USER) != NULL);
ffffffffc0203eb6:	6c88                	ld	a0,24(s1)
ffffffffc0203eb8:	467d                	li	a2,31
ffffffffc0203eba:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0203ebe:	92eff0ef          	jal	ra,ffffffffc0202fec <pgdir_alloc_page>
ffffffffc0203ec2:	34050863          	beqz	a0,ffffffffc0204212 <do_execve+0x4c8>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-2*PGSIZE , PTE_USER) != NULL);
ffffffffc0203ec6:	6c88                	ld	a0,24(s1)
ffffffffc0203ec8:	467d                	li	a2,31
ffffffffc0203eca:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0203ece:	91eff0ef          	jal	ra,ffffffffc0202fec <pgdir_alloc_page>
ffffffffc0203ed2:	32050063          	beqz	a0,ffffffffc02041f2 <do_execve+0x4a8>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-3*PGSIZE , PTE_USER) != NULL);
ffffffffc0203ed6:	6c88                	ld	a0,24(s1)
ffffffffc0203ed8:	467d                	li	a2,31
ffffffffc0203eda:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc0203ede:	90eff0ef          	jal	ra,ffffffffc0202fec <pgdir_alloc_page>
ffffffffc0203ee2:	2e050863          	beqz	a0,ffffffffc02041d2 <do_execve+0x488>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-4*PGSIZE , PTE_USER) != NULL);
ffffffffc0203ee6:	6c88                	ld	a0,24(s1)
ffffffffc0203ee8:	467d                	li	a2,31
ffffffffc0203eea:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc0203eee:	8feff0ef          	jal	ra,ffffffffc0202fec <pgdir_alloc_page>
ffffffffc0203ef2:	2c050063          	beqz	a0,ffffffffc02041b2 <do_execve+0x468>
    mm->mm_count += 1;
ffffffffc0203ef6:	589c                	lw	a5,48(s1)
    current->mm = mm;
ffffffffc0203ef8:	000ab603          	ld	a2,0(s5)
    current->cr3 = PADDR(mm->pgdir);
ffffffffc0203efc:	6c94                	ld	a3,24(s1)
ffffffffc0203efe:	2785                	addiw	a5,a5,1
ffffffffc0203f00:	d89c                	sw	a5,48(s1)
    current->mm = mm;
ffffffffc0203f02:	f604                	sd	s1,40(a2)
    current->cr3 = PADDR(mm->pgdir);
ffffffffc0203f04:	c02007b7          	lui	a5,0xc0200
ffffffffc0203f08:	28f6e963          	bltu	a3,a5,ffffffffc020419a <do_execve+0x450>
ffffffffc0203f0c:	0004f797          	auipc	a5,0x4f
ffffffffc0203f10:	66c7b783          	ld	a5,1644(a5) # ffffffffc0253578 <va_pa_offset>
ffffffffc0203f14:	8e9d                	sub	a3,a3,a5
ffffffffc0203f16:	577d                	li	a4,-1
ffffffffc0203f18:	00c6d793          	srli	a5,a3,0xc
ffffffffc0203f1c:	177e                	slli	a4,a4,0x3f
ffffffffc0203f1e:	f654                	sd	a3,168(a2)
ffffffffc0203f20:	8fd9                	or	a5,a5,a4
ffffffffc0203f22:	18079073          	csrw	satp,a5
    struct trapframe *tf = current->tf;
ffffffffc0203f26:	7240                	ld	s0,160(a2)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0203f28:	4581                	li	a1,0
ffffffffc0203f2a:	12000613          	li	a2,288
ffffffffc0203f2e:	8522                	mv	a0,s0
    uintptr_t sstatus = tf->status;
ffffffffc0203f30:	10043483          	ld	s1,256(s0)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0203f34:	125000ef          	jal	ra,ffffffffc0204858 <memset>
    tf->epc = elf->e_entry;
ffffffffc0203f38:	0189b703          	ld	a4,24(s3)
    tf->gpr.sp = USTACKTOP;
ffffffffc0203f3c:	4785                	li	a5,1
    set_proc_name(current, local_name);
ffffffffc0203f3e:	000ab503          	ld	a0,0(s5)
    tf->status = sstatus & ~(SSTATUS_SPP | SSTATUS_SPIE);
ffffffffc0203f42:	edf4f493          	andi	s1,s1,-289
    tf->gpr.sp = USTACKTOP;
ffffffffc0203f46:	07fe                	slli	a5,a5,0x1f
ffffffffc0203f48:	e81c                	sd	a5,16(s0)
    tf->epc = elf->e_entry;
ffffffffc0203f4a:	10e43423          	sd	a4,264(s0)
    tf->status = sstatus & ~(SSTATUS_SPP | SSTATUS_SPIE);
ffffffffc0203f4e:	10943023          	sd	s1,256(s0)
    set_proc_name(current, local_name);
ffffffffc0203f52:	100c                	addi	a1,sp,32
ffffffffc0203f54:	cf0ff0ef          	jal	ra,ffffffffc0203444 <set_proc_name>
}
ffffffffc0203f58:	60ea                	ld	ra,152(sp)
ffffffffc0203f5a:	644a                	ld	s0,144(sp)
ffffffffc0203f5c:	64aa                	ld	s1,136(sp)
ffffffffc0203f5e:	690a                	ld	s2,128(sp)
ffffffffc0203f60:	79e6                	ld	s3,120(sp)
ffffffffc0203f62:	7aa6                	ld	s5,104(sp)
ffffffffc0203f64:	7b06                	ld	s6,96(sp)
ffffffffc0203f66:	6be6                	ld	s7,88(sp)
ffffffffc0203f68:	6c46                	ld	s8,80(sp)
ffffffffc0203f6a:	6ca6                	ld	s9,72(sp)
ffffffffc0203f6c:	6d06                	ld	s10,64(sp)
ffffffffc0203f6e:	7de2                	ld	s11,56(sp)
ffffffffc0203f70:	8552                	mv	a0,s4
ffffffffc0203f72:	7a46                	ld	s4,112(sp)
ffffffffc0203f74:	610d                	addi	sp,sp,160
ffffffffc0203f76:	8082                	ret
        if (ph->p_filesz > ph->p_memsz) {
ffffffffc0203f78:	02893603          	ld	a2,40(s2)
ffffffffc0203f7c:	02093783          	ld	a5,32(s2)
ffffffffc0203f80:	1ef66f63          	bltu	a2,a5,ffffffffc020417e <do_execve+0x434>
        if (ph->p_flags & ELF_PF_X) vm_flags |= VM_EXEC;
ffffffffc0203f84:	00492783          	lw	a5,4(s2)
ffffffffc0203f88:	0017f693          	andi	a3,a5,1
ffffffffc0203f8c:	c291                	beqz	a3,ffffffffc0203f90 <do_execve+0x246>
ffffffffc0203f8e:	4691                	li	a3,4
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc0203f90:	0027f713          	andi	a4,a5,2
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203f94:	8b91                	andi	a5,a5,4
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc0203f96:	0e071063          	bnez	a4,ffffffffc0204076 <do_execve+0x32c>
        vm_flags = 0, perm = PTE_U | PTE_V;
ffffffffc0203f9a:	4745                	li	a4,17
ffffffffc0203f9c:	e03a                	sd	a4,0(sp)
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203f9e:	c789                	beqz	a5,ffffffffc0203fa8 <do_execve+0x25e>
        if (vm_flags & VM_READ) perm |= PTE_R;
ffffffffc0203fa0:	47cd                	li	a5,19
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203fa2:	0016e693          	ori	a3,a3,1
        if (vm_flags & VM_READ) perm |= PTE_R;
ffffffffc0203fa6:	e03e                	sd	a5,0(sp)
        if (vm_flags & VM_WRITE) perm |= (PTE_W | PTE_R);
ffffffffc0203fa8:	0026f793          	andi	a5,a3,2
ffffffffc0203fac:	ebe1                	bnez	a5,ffffffffc020407c <do_execve+0x332>
        if (vm_flags & VM_EXEC) perm |= PTE_X;
ffffffffc0203fae:	0046f793          	andi	a5,a3,4
ffffffffc0203fb2:	c789                	beqz	a5,ffffffffc0203fbc <do_execve+0x272>
ffffffffc0203fb4:	6782                	ld	a5,0(sp)
ffffffffc0203fb6:	0087e793          	ori	a5,a5,8
ffffffffc0203fba:	e03e                	sd	a5,0(sp)
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0) {
ffffffffc0203fbc:	01093583          	ld	a1,16(s2)
ffffffffc0203fc0:	4701                	li	a4,0
ffffffffc0203fc2:	8526                	mv	a0,s1
ffffffffc0203fc4:	f0dfc0ef          	jal	ra,ffffffffc0200ed0 <mm_map>
ffffffffc0203fc8:	8a2a                	mv	s4,a0
ffffffffc0203fca:	e151                	bnez	a0,ffffffffc020404e <do_execve+0x304>
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0203fcc:	01093c03          	ld	s8,16(s2)
        end = ph->p_va + ph->p_filesz;
ffffffffc0203fd0:	02093a03          	ld	s4,32(s2)
        unsigned char *from = binary + ph->p_offset;
ffffffffc0203fd4:	00893b03          	ld	s6,8(s2)
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0203fd8:	77fd                	lui	a5,0xfffff
        end = ph->p_va + ph->p_filesz;
ffffffffc0203fda:	9a62                	add	s4,s4,s8
        unsigned char *from = binary + ph->p_offset;
ffffffffc0203fdc:	9b4e                	add	s6,s6,s3
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0203fde:	00fc7bb3          	and	s7,s8,a5
        while (start < end) {
ffffffffc0203fe2:	054c6e63          	bltu	s8,s4,ffffffffc020403e <do_execve+0x2f4>
ffffffffc0203fe6:	aa51                	j	ffffffffc020417a <do_execve+0x430>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0203fe8:	6785                	lui	a5,0x1
ffffffffc0203fea:	417c0533          	sub	a0,s8,s7
ffffffffc0203fee:	9bbe                	add	s7,s7,a5
ffffffffc0203ff0:	418b8633          	sub	a2,s7,s8
            if (end < la) {
ffffffffc0203ff4:	017a7463          	bgeu	s4,s7,ffffffffc0203ffc <do_execve+0x2b2>
                size -= la - end;
ffffffffc0203ff8:	418a0633          	sub	a2,s4,s8
    return page - pages + nbase;
ffffffffc0203ffc:	000db683          	ld	a3,0(s11)
ffffffffc0204000:	000d3803          	ld	a6,0(s10)
    return KADDR(page2pa(page));
ffffffffc0204004:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc0204006:	40d406b3          	sub	a3,s0,a3
ffffffffc020400a:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc020400c:	000cb583          	ld	a1,0(s9)
    return page - pages + nbase;
ffffffffc0204010:	96c2                	add	a3,a3,a6
    return KADDR(page2pa(page));
ffffffffc0204012:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204016:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204018:	16b87563          	bgeu	a6,a1,ffffffffc0204182 <do_execve+0x438>
ffffffffc020401c:	0004f797          	auipc	a5,0x4f
ffffffffc0204020:	55c78793          	addi	a5,a5,1372 # ffffffffc0253578 <va_pa_offset>
ffffffffc0204024:	0007b803          	ld	a6,0(a5)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204028:	85da                	mv	a1,s6
            start += size, from += size;
ffffffffc020402a:	9c32                	add	s8,s8,a2
ffffffffc020402c:	96c2                	add	a3,a3,a6
            memcpy(page2kva(page) + off, from, size);
ffffffffc020402e:	9536                	add	a0,a0,a3
            start += size, from += size;
ffffffffc0204030:	e832                	sd	a2,16(sp)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204032:	039000ef          	jal	ra,ffffffffc020486a <memcpy>
            start += size, from += size;
ffffffffc0204036:	6642                	ld	a2,16(sp)
ffffffffc0204038:	9b32                	add	s6,s6,a2
        while (start < end) {
ffffffffc020403a:	054c7463          	bgeu	s8,s4,ffffffffc0204082 <do_execve+0x338>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL) {
ffffffffc020403e:	6c88                	ld	a0,24(s1)
ffffffffc0204040:	6602                	ld	a2,0(sp)
ffffffffc0204042:	85de                	mv	a1,s7
ffffffffc0204044:	fa9fe0ef          	jal	ra,ffffffffc0202fec <pgdir_alloc_page>
ffffffffc0204048:	842a                	mv	s0,a0
ffffffffc020404a:	fd59                	bnez	a0,ffffffffc0203fe8 <do_execve+0x29e>
        ret = -E_NO_MEM;
ffffffffc020404c:	5a71                	li	s4,-4
    exit_mmap(mm);
ffffffffc020404e:	8526                	mv	a0,s1
ffffffffc0204050:	fcbfc0ef          	jal	ra,ffffffffc020101a <exit_mmap>
    put_pgdir(mm);
ffffffffc0204054:	8526                	mv	a0,s1
ffffffffc0204056:	af6ff0ef          	jal	ra,ffffffffc020334c <put_pgdir>
    mm_destroy(mm);
ffffffffc020405a:	8526                	mv	a0,s1
ffffffffc020405c:	e23fc0ef          	jal	ra,ffffffffc0200e7e <mm_destroy>
    return ret;
ffffffffc0204060:	b37d                	j	ffffffffc0203e0e <do_execve+0xc4>
            exit_mmap(mm);
ffffffffc0204062:	8552                	mv	a0,s4
ffffffffc0204064:	fb7fc0ef          	jal	ra,ffffffffc020101a <exit_mmap>
            put_pgdir(mm);
ffffffffc0204068:	8552                	mv	a0,s4
ffffffffc020406a:	ae2ff0ef          	jal	ra,ffffffffc020334c <put_pgdir>
            mm_destroy(mm);
ffffffffc020406e:	8552                	mv	a0,s4
ffffffffc0204070:	e0ffc0ef          	jal	ra,ffffffffc0200e7e <mm_destroy>
ffffffffc0204074:	b39d                	j	ffffffffc0203dda <do_execve+0x90>
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc0204076:	0026e693          	ori	a3,a3,2
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc020407a:	f39d                	bnez	a5,ffffffffc0203fa0 <do_execve+0x256>
        if (vm_flags & VM_WRITE) perm |= (PTE_W | PTE_R);
ffffffffc020407c:	47dd                	li	a5,23
ffffffffc020407e:	e03e                	sd	a5,0(sp)
ffffffffc0204080:	b73d                	j	ffffffffc0203fae <do_execve+0x264>
ffffffffc0204082:	01093a03          	ld	s4,16(s2)
        end = ph->p_va + ph->p_memsz;
ffffffffc0204086:	02893683          	ld	a3,40(s2)
ffffffffc020408a:	9a36                	add	s4,s4,a3
        if (start < la) {
ffffffffc020408c:	077c7f63          	bgeu	s8,s7,ffffffffc020410a <do_execve+0x3c0>
            if (start == end) {
ffffffffc0204090:	e18a02e3          	beq	s4,s8,ffffffffc0203e94 <do_execve+0x14a>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204094:	6505                	lui	a0,0x1
ffffffffc0204096:	9562                	add	a0,a0,s8
ffffffffc0204098:	41750533          	sub	a0,a0,s7
                size -= la - end;
ffffffffc020409c:	418a0b33          	sub	s6,s4,s8
            if (end < la) {
ffffffffc02040a0:	0d7a7863          	bgeu	s4,s7,ffffffffc0204170 <do_execve+0x426>
    return page - pages + nbase;
ffffffffc02040a4:	000db683          	ld	a3,0(s11)
ffffffffc02040a8:	000d3583          	ld	a1,0(s10)
    return KADDR(page2pa(page));
ffffffffc02040ac:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc02040ae:	40d406b3          	sub	a3,s0,a3
ffffffffc02040b2:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02040b4:	000cb603          	ld	a2,0(s9)
    return page - pages + nbase;
ffffffffc02040b8:	96ae                	add	a3,a3,a1
    return KADDR(page2pa(page));
ffffffffc02040ba:	00f6f5b3          	and	a1,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc02040be:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02040c0:	0cc5f163          	bgeu	a1,a2,ffffffffc0204182 <do_execve+0x438>
ffffffffc02040c4:	0004f617          	auipc	a2,0x4f
ffffffffc02040c8:	4b463603          	ld	a2,1204(a2) # ffffffffc0253578 <va_pa_offset>
ffffffffc02040cc:	96b2                	add	a3,a3,a2
            memset(page2kva(page) + off, 0, size);
ffffffffc02040ce:	4581                	li	a1,0
ffffffffc02040d0:	865a                	mv	a2,s6
ffffffffc02040d2:	9536                	add	a0,a0,a3
ffffffffc02040d4:	784000ef          	jal	ra,ffffffffc0204858 <memset>
            start += size;
ffffffffc02040d8:	018b0733          	add	a4,s6,s8
            assert((end < la && start == end) || (end >= la && start == la));
ffffffffc02040dc:	037a7463          	bgeu	s4,s7,ffffffffc0204104 <do_execve+0x3ba>
ffffffffc02040e0:	daea0ae3          	beq	s4,a4,ffffffffc0203e94 <do_execve+0x14a>
ffffffffc02040e4:	00002697          	auipc	a3,0x2
ffffffffc02040e8:	26c68693          	addi	a3,a3,620 # ffffffffc0206350 <default_pmm_manager+0x418>
ffffffffc02040ec:	00001617          	auipc	a2,0x1
ffffffffc02040f0:	22c60613          	addi	a2,a2,556 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02040f4:	22500593          	li	a1,549
ffffffffc02040f8:	00002517          	auipc	a0,0x2
ffffffffc02040fc:	05050513          	addi	a0,a0,80 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc0204100:	900fc0ef          	jal	ra,ffffffffc0200200 <__panic>
ffffffffc0204104:	ff7710e3          	bne	a4,s7,ffffffffc02040e4 <do_execve+0x39a>
ffffffffc0204108:	8c5e                	mv	s8,s7
ffffffffc020410a:	0004fb17          	auipc	s6,0x4f
ffffffffc020410e:	46eb0b13          	addi	s6,s6,1134 # ffffffffc0253578 <va_pa_offset>
        while (start < end) {
ffffffffc0204112:	054c6763          	bltu	s8,s4,ffffffffc0204160 <do_execve+0x416>
ffffffffc0204116:	bbbd                	j	ffffffffc0203e94 <do_execve+0x14a>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204118:	6785                	lui	a5,0x1
ffffffffc020411a:	417c0533          	sub	a0,s8,s7
ffffffffc020411e:	9bbe                	add	s7,s7,a5
ffffffffc0204120:	418b8633          	sub	a2,s7,s8
            if (end < la) {
ffffffffc0204124:	017a7463          	bgeu	s4,s7,ffffffffc020412c <do_execve+0x3e2>
                size -= la - end;
ffffffffc0204128:	418a0633          	sub	a2,s4,s8
    return page - pages + nbase;
ffffffffc020412c:	000db683          	ld	a3,0(s11)
ffffffffc0204130:	000d3803          	ld	a6,0(s10)
    return KADDR(page2pa(page));
ffffffffc0204134:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc0204136:	40d406b3          	sub	a3,s0,a3
ffffffffc020413a:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc020413c:	000cb583          	ld	a1,0(s9)
    return page - pages + nbase;
ffffffffc0204140:	96c2                	add	a3,a3,a6
    return KADDR(page2pa(page));
ffffffffc0204142:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204146:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204148:	02b87d63          	bgeu	a6,a1,ffffffffc0204182 <do_execve+0x438>
ffffffffc020414c:	000b3803          	ld	a6,0(s6)
            start += size;
ffffffffc0204150:	9c32                	add	s8,s8,a2
            memset(page2kva(page) + off, 0, size);
ffffffffc0204152:	4581                	li	a1,0
ffffffffc0204154:	96c2                	add	a3,a3,a6
ffffffffc0204156:	9536                	add	a0,a0,a3
ffffffffc0204158:	700000ef          	jal	ra,ffffffffc0204858 <memset>
        while (start < end) {
ffffffffc020415c:	d34c7ce3          	bgeu	s8,s4,ffffffffc0203e94 <do_execve+0x14a>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL) {
ffffffffc0204160:	6c88                	ld	a0,24(s1)
ffffffffc0204162:	6602                	ld	a2,0(sp)
ffffffffc0204164:	85de                	mv	a1,s7
ffffffffc0204166:	e87fe0ef          	jal	ra,ffffffffc0202fec <pgdir_alloc_page>
ffffffffc020416a:	842a                	mv	s0,a0
ffffffffc020416c:	f555                	bnez	a0,ffffffffc0204118 <do_execve+0x3ce>
ffffffffc020416e:	bdf9                	j	ffffffffc020404c <do_execve+0x302>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204170:	418b8b33          	sub	s6,s7,s8
ffffffffc0204174:	bf05                	j	ffffffffc02040a4 <do_execve+0x35a>
        return -E_INVAL;
ffffffffc0204176:	5a75                	li	s4,-3
ffffffffc0204178:	b3c5                	j	ffffffffc0203f58 <do_execve+0x20e>
        while (start < end) {
ffffffffc020417a:	8a62                	mv	s4,s8
ffffffffc020417c:	b729                	j	ffffffffc0204086 <do_execve+0x33c>
            ret = -E_INVAL_ELF;
ffffffffc020417e:	5a61                	li	s4,-8
ffffffffc0204180:	b5f9                	j	ffffffffc020404e <do_execve+0x304>
ffffffffc0204182:	00002617          	auipc	a2,0x2
ffffffffc0204186:	81e60613          	addi	a2,a2,-2018 # ffffffffc02059a0 <commands+0xa78>
ffffffffc020418a:	06900593          	li	a1,105
ffffffffc020418e:	00002517          	auipc	a0,0x2
ffffffffc0204192:	83a50513          	addi	a0,a0,-1990 # ffffffffc02059c8 <commands+0xaa0>
ffffffffc0204196:	86afc0ef          	jal	ra,ffffffffc0200200 <__panic>
    current->cr3 = PADDR(mm->pgdir);
ffffffffc020419a:	00002617          	auipc	a2,0x2
ffffffffc020419e:	87660613          	addi	a2,a2,-1930 # ffffffffc0205a10 <commands+0xae8>
ffffffffc02041a2:	24000593          	li	a1,576
ffffffffc02041a6:	00002517          	auipc	a0,0x2
ffffffffc02041aa:	fa250513          	addi	a0,a0,-94 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc02041ae:	852fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-4*PGSIZE , PTE_USER) != NULL);
ffffffffc02041b2:	00002697          	auipc	a3,0x2
ffffffffc02041b6:	2b668693          	addi	a3,a3,694 # ffffffffc0206468 <default_pmm_manager+0x530>
ffffffffc02041ba:	00001617          	auipc	a2,0x1
ffffffffc02041be:	15e60613          	addi	a2,a2,350 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02041c2:	23b00593          	li	a1,571
ffffffffc02041c6:	00002517          	auipc	a0,0x2
ffffffffc02041ca:	f8250513          	addi	a0,a0,-126 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc02041ce:	832fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-3*PGSIZE , PTE_USER) != NULL);
ffffffffc02041d2:	00002697          	auipc	a3,0x2
ffffffffc02041d6:	24e68693          	addi	a3,a3,590 # ffffffffc0206420 <default_pmm_manager+0x4e8>
ffffffffc02041da:	00001617          	auipc	a2,0x1
ffffffffc02041de:	13e60613          	addi	a2,a2,318 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02041e2:	23a00593          	li	a1,570
ffffffffc02041e6:	00002517          	auipc	a0,0x2
ffffffffc02041ea:	f6250513          	addi	a0,a0,-158 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc02041ee:	812fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-2*PGSIZE , PTE_USER) != NULL);
ffffffffc02041f2:	00002697          	auipc	a3,0x2
ffffffffc02041f6:	1e668693          	addi	a3,a3,486 # ffffffffc02063d8 <default_pmm_manager+0x4a0>
ffffffffc02041fa:	00001617          	auipc	a2,0x1
ffffffffc02041fe:	11e60613          	addi	a2,a2,286 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0204202:	23900593          	li	a1,569
ffffffffc0204206:	00002517          	auipc	a0,0x2
ffffffffc020420a:	f4250513          	addi	a0,a0,-190 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc020420e:	ff3fb0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-PGSIZE , PTE_USER) != NULL);
ffffffffc0204212:	00002697          	auipc	a3,0x2
ffffffffc0204216:	17e68693          	addi	a3,a3,382 # ffffffffc0206390 <default_pmm_manager+0x458>
ffffffffc020421a:	00001617          	auipc	a2,0x1
ffffffffc020421e:	0fe60613          	addi	a2,a2,254 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0204222:	23800593          	li	a1,568
ffffffffc0204226:	00002517          	auipc	a0,0x2
ffffffffc020422a:	f2250513          	addi	a0,a0,-222 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc020422e:	fd3fb0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0204232 <do_yield>:
    current->need_resched = 1;
ffffffffc0204232:	0004f797          	auipc	a5,0x4f
ffffffffc0204236:	20e7b783          	ld	a5,526(a5) # ffffffffc0253440 <current>
ffffffffc020423a:	4705                	li	a4,1
ffffffffc020423c:	ef98                	sd	a4,24(a5)
}
ffffffffc020423e:	4501                	li	a0,0
ffffffffc0204240:	8082                	ret

ffffffffc0204242 <do_wait>:
do_wait(int pid, int *code_store) {
ffffffffc0204242:	1101                	addi	sp,sp,-32
ffffffffc0204244:	e822                	sd	s0,16(sp)
ffffffffc0204246:	e426                	sd	s1,8(sp)
ffffffffc0204248:	ec06                	sd	ra,24(sp)
ffffffffc020424a:	842e                	mv	s0,a1
ffffffffc020424c:	84aa                	mv	s1,a0
    if (code_store != NULL) {
ffffffffc020424e:	c999                	beqz	a1,ffffffffc0204264 <do_wait+0x22>
    struct mm_struct *mm = current->mm;
ffffffffc0204250:	0004f797          	auipc	a5,0x4f
ffffffffc0204254:	1f07b783          	ld	a5,496(a5) # ffffffffc0253440 <current>
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1)) {
ffffffffc0204258:	7788                	ld	a0,40(a5)
ffffffffc020425a:	4685                	li	a3,1
ffffffffc020425c:	4611                	li	a2,4
ffffffffc020425e:	f37fc0ef          	jal	ra,ffffffffc0201194 <user_mem_check>
ffffffffc0204262:	c909                	beqz	a0,ffffffffc0204274 <do_wait+0x32>
ffffffffc0204264:	85a2                	mv	a1,s0
}
ffffffffc0204266:	6442                	ld	s0,16(sp)
ffffffffc0204268:	60e2                	ld	ra,24(sp)
ffffffffc020426a:	8526                	mv	a0,s1
ffffffffc020426c:	64a2                	ld	s1,8(sp)
ffffffffc020426e:	6105                	addi	sp,sp,32
ffffffffc0204270:	821ff06f          	j	ffffffffc0203a90 <do_wait.part.0>
ffffffffc0204274:	60e2                	ld	ra,24(sp)
ffffffffc0204276:	6442                	ld	s0,16(sp)
ffffffffc0204278:	64a2                	ld	s1,8(sp)
ffffffffc020427a:	5575                	li	a0,-3
ffffffffc020427c:	6105                	addi	sp,sp,32
ffffffffc020427e:	8082                	ret

ffffffffc0204280 <do_kill>:
do_kill(int pid) {
ffffffffc0204280:	1141                	addi	sp,sp,-16
ffffffffc0204282:	e406                	sd	ra,8(sp)
ffffffffc0204284:	e022                	sd	s0,0(sp)
    if ((proc = find_proc(pid)) != NULL) {
ffffffffc0204286:	a54ff0ef          	jal	ra,ffffffffc02034da <find_proc>
ffffffffc020428a:	cd0d                	beqz	a0,ffffffffc02042c4 <do_kill+0x44>
        if (!(proc->flags & PF_EXITING)) {
ffffffffc020428c:	0b052703          	lw	a4,176(a0)
ffffffffc0204290:	00177693          	andi	a3,a4,1
ffffffffc0204294:	e695                	bnez	a3,ffffffffc02042c0 <do_kill+0x40>
            if (proc->wait_state & WT_INTERRUPTED) {
ffffffffc0204296:	0ec52683          	lw	a3,236(a0)
            proc->flags |= PF_EXITING;
ffffffffc020429a:	00176713          	ori	a4,a4,1
ffffffffc020429e:	0ae52823          	sw	a4,176(a0)
            return 0;
ffffffffc02042a2:	4401                	li	s0,0
            if (proc->wait_state & WT_INTERRUPTED) {
ffffffffc02042a4:	0006c763          	bltz	a3,ffffffffc02042b2 <do_kill+0x32>
}
ffffffffc02042a8:	60a2                	ld	ra,8(sp)
ffffffffc02042aa:	8522                	mv	a0,s0
ffffffffc02042ac:	6402                	ld	s0,0(sp)
ffffffffc02042ae:	0141                	addi	sp,sp,16
ffffffffc02042b0:	8082                	ret
                wakeup_proc(proc);
ffffffffc02042b2:	1e2000ef          	jal	ra,ffffffffc0204494 <wakeup_proc>
}
ffffffffc02042b6:	60a2                	ld	ra,8(sp)
ffffffffc02042b8:	8522                	mv	a0,s0
ffffffffc02042ba:	6402                	ld	s0,0(sp)
ffffffffc02042bc:	0141                	addi	sp,sp,16
ffffffffc02042be:	8082                	ret
        return -E_KILLED;
ffffffffc02042c0:	545d                	li	s0,-9
ffffffffc02042c2:	b7dd                	j	ffffffffc02042a8 <do_kill+0x28>
    return -E_INVAL;
ffffffffc02042c4:	5475                	li	s0,-3
ffffffffc02042c6:	b7cd                	j	ffffffffc02042a8 <do_kill+0x28>

ffffffffc02042c8 <proc_init>:

// proc_init - set up the first kernel thread idleproc "idle" by itself and 
//           - create the second kernel thread init_main
void
proc_init(void) {
ffffffffc02042c8:	1101                	addi	sp,sp,-32
    elm->prev = elm->next = elm;
ffffffffc02042ca:	0004f797          	auipc	a5,0x4f
ffffffffc02042ce:	2c678793          	addi	a5,a5,710 # ffffffffc0253590 <proc_list>
ffffffffc02042d2:	ec06                	sd	ra,24(sp)
ffffffffc02042d4:	e822                	sd	s0,16(sp)
ffffffffc02042d6:	e426                	sd	s1,8(sp)
ffffffffc02042d8:	e04a                	sd	s2,0(sp)
ffffffffc02042da:	e79c                	sd	a5,8(a5)
ffffffffc02042dc:	e39c                	sd	a5,0(a5)
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i ++) {
ffffffffc02042de:	0004f717          	auipc	a4,0x4f
ffffffffc02042e2:	0fa70713          	addi	a4,a4,250 # ffffffffc02533d8 <__rq>
ffffffffc02042e6:	0004b797          	auipc	a5,0x4b
ffffffffc02042ea:	0f278793          	addi	a5,a5,242 # ffffffffc024f3d8 <hash_list>
ffffffffc02042ee:	e79c                	sd	a5,8(a5)
ffffffffc02042f0:	e39c                	sd	a5,0(a5)
ffffffffc02042f2:	07c1                	addi	a5,a5,16
ffffffffc02042f4:	fef71de3          	bne	a4,a5,ffffffffc02042ee <proc_init+0x26>
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL) {
ffffffffc02042f8:	f49fe0ef          	jal	ra,ffffffffc0203240 <alloc_proc>
ffffffffc02042fc:	0004f417          	auipc	s0,0x4f
ffffffffc0204300:	14c40413          	addi	s0,s0,332 # ffffffffc0253448 <idleproc>
ffffffffc0204304:	e008                	sd	a0,0(s0)
ffffffffc0204306:	c541                	beqz	a0,ffffffffc020438e <proc_init+0xc6>
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
ffffffffc0204308:	4709                	li	a4,2
ffffffffc020430a:	e118                	sd	a4,0(a0)
    idleproc->kstack = (uintptr_t)bootstack;
    idleproc->need_resched = 1;
ffffffffc020430c:	4485                	li	s1,1
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc020430e:	00004717          	auipc	a4,0x4
ffffffffc0204312:	cf270713          	addi	a4,a4,-782 # ffffffffc0208000 <bootstack>
    set_proc_name(idleproc, "idle");
ffffffffc0204316:	00002597          	auipc	a1,0x2
ffffffffc020431a:	1b258593          	addi	a1,a1,434 # ffffffffc02064c8 <default_pmm_manager+0x590>
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc020431e:	e918                	sd	a4,16(a0)
    idleproc->need_resched = 1;
ffffffffc0204320:	ed04                	sd	s1,24(a0)
    set_proc_name(idleproc, "idle");
ffffffffc0204322:	922ff0ef          	jal	ra,ffffffffc0203444 <set_proc_name>
    nr_process ++;
ffffffffc0204326:	0004f717          	auipc	a4,0x4f
ffffffffc020432a:	13270713          	addi	a4,a4,306 # ffffffffc0253458 <nr_process>
ffffffffc020432e:	431c                	lw	a5,0(a4)

    current = idleproc;
ffffffffc0204330:	6014                	ld	a3,0(s0)

    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204332:	4601                	li	a2,0
    nr_process ++;
ffffffffc0204334:	2785                	addiw	a5,a5,1
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204336:	4581                	li	a1,0
ffffffffc0204338:	00000517          	auipc	a0,0x0
ffffffffc020433c:	8ee50513          	addi	a0,a0,-1810 # ffffffffc0203c26 <init_main>
    nr_process ++;
ffffffffc0204340:	c31c                	sw	a5,0(a4)
    current = idleproc;
ffffffffc0204342:	0004f797          	auipc	a5,0x4f
ffffffffc0204346:	0ed7bf23          	sd	a3,254(a5) # ffffffffc0253440 <current>
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc020434a:	dacff0ef          	jal	ra,ffffffffc02038f6 <kernel_thread>
    if (pid <= 0) {
ffffffffc020434e:	08a05c63          	blez	a0,ffffffffc02043e6 <proc_init+0x11e>
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
ffffffffc0204352:	988ff0ef          	jal	ra,ffffffffc02034da <find_proc>
ffffffffc0204356:	0004f917          	auipc	s2,0x4f
ffffffffc020435a:	0fa90913          	addi	s2,s2,250 # ffffffffc0253450 <initproc>
    set_proc_name(initproc, "init");
ffffffffc020435e:	00002597          	auipc	a1,0x2
ffffffffc0204362:	19258593          	addi	a1,a1,402 # ffffffffc02064f0 <default_pmm_manager+0x5b8>
    initproc = find_proc(pid);
ffffffffc0204366:	00a93023          	sd	a0,0(s2)
    set_proc_name(initproc, "init");
ffffffffc020436a:	8daff0ef          	jal	ra,ffffffffc0203444 <set_proc_name>

    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc020436e:	601c                	ld	a5,0(s0)
ffffffffc0204370:	cbb9                	beqz	a5,ffffffffc02043c6 <proc_init+0xfe>
ffffffffc0204372:	43dc                	lw	a5,4(a5)
ffffffffc0204374:	eba9                	bnez	a5,ffffffffc02043c6 <proc_init+0xfe>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204376:	00093783          	ld	a5,0(s2)
ffffffffc020437a:	c795                	beqz	a5,ffffffffc02043a6 <proc_init+0xde>
ffffffffc020437c:	43dc                	lw	a5,4(a5)
ffffffffc020437e:	02979463          	bne	a5,s1,ffffffffc02043a6 <proc_init+0xde>
}
ffffffffc0204382:	60e2                	ld	ra,24(sp)
ffffffffc0204384:	6442                	ld	s0,16(sp)
ffffffffc0204386:	64a2                	ld	s1,8(sp)
ffffffffc0204388:	6902                	ld	s2,0(sp)
ffffffffc020438a:	6105                	addi	sp,sp,32
ffffffffc020438c:	8082                	ret
        panic("cannot alloc idleproc.\n");
ffffffffc020438e:	00002617          	auipc	a2,0x2
ffffffffc0204392:	12260613          	addi	a2,a2,290 # ffffffffc02064b0 <default_pmm_manager+0x578>
ffffffffc0204396:	32f00593          	li	a1,815
ffffffffc020439a:	00002517          	auipc	a0,0x2
ffffffffc020439e:	dae50513          	addi	a0,a0,-594 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc02043a2:	e5ffb0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc02043a6:	00002697          	auipc	a3,0x2
ffffffffc02043aa:	17a68693          	addi	a3,a3,378 # ffffffffc0206520 <default_pmm_manager+0x5e8>
ffffffffc02043ae:	00001617          	auipc	a2,0x1
ffffffffc02043b2:	f6a60613          	addi	a2,a2,-150 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02043b6:	34400593          	li	a1,836
ffffffffc02043ba:	00002517          	auipc	a0,0x2
ffffffffc02043be:	d8e50513          	addi	a0,a0,-626 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc02043c2:	e3ffb0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc02043c6:	00002697          	auipc	a3,0x2
ffffffffc02043ca:	13268693          	addi	a3,a3,306 # ffffffffc02064f8 <default_pmm_manager+0x5c0>
ffffffffc02043ce:	00001617          	auipc	a2,0x1
ffffffffc02043d2:	f4a60613          	addi	a2,a2,-182 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02043d6:	34300593          	li	a1,835
ffffffffc02043da:	00002517          	auipc	a0,0x2
ffffffffc02043de:	d6e50513          	addi	a0,a0,-658 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc02043e2:	e1ffb0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("create init_main failed.\n");
ffffffffc02043e6:	00002617          	auipc	a2,0x2
ffffffffc02043ea:	0ea60613          	addi	a2,a2,234 # ffffffffc02064d0 <default_pmm_manager+0x598>
ffffffffc02043ee:	33d00593          	li	a1,829
ffffffffc02043f2:	00002517          	auipc	a0,0x2
ffffffffc02043f6:	d5650513          	addi	a0,a0,-682 # ffffffffc0206148 <default_pmm_manager+0x210>
ffffffffc02043fa:	e07fb0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02043fe <cpu_idle>:

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void
cpu_idle(void) {
ffffffffc02043fe:	1141                	addi	sp,sp,-16
ffffffffc0204400:	e022                	sd	s0,0(sp)
ffffffffc0204402:	e406                	sd	ra,8(sp)
ffffffffc0204404:	0004f417          	auipc	s0,0x4f
ffffffffc0204408:	03c40413          	addi	s0,s0,60 # ffffffffc0253440 <current>
    while (1) {
        if (current->need_resched) {
ffffffffc020440c:	6018                	ld	a4,0(s0)
ffffffffc020440e:	6f1c                	ld	a5,24(a4)
ffffffffc0204410:	dffd                	beqz	a5,ffffffffc020440e <cpu_idle+0x10>
            schedule();
ffffffffc0204412:	134000ef          	jal	ra,ffffffffc0204546 <schedule>
ffffffffc0204416:	bfdd                	j	ffffffffc020440c <cpu_idle+0xe>

ffffffffc0204418 <sched_class_proc_tick>:
    return sched_class->pick_next(rq);
}

void
sched_class_proc_tick(struct proc_struct *proc) {
    if (proc != idleproc) {
ffffffffc0204418:	0004f797          	auipc	a5,0x4f
ffffffffc020441c:	0307b783          	ld	a5,48(a5) # ffffffffc0253448 <idleproc>
sched_class_proc_tick(struct proc_struct *proc) {
ffffffffc0204420:	85aa                	mv	a1,a0
    if (proc != idleproc) {
ffffffffc0204422:	00a78d63          	beq	a5,a0,ffffffffc020443c <sched_class_proc_tick+0x24>
        sched_class->proc_tick(rq, proc);
ffffffffc0204426:	0004f797          	auipc	a5,0x4f
ffffffffc020442a:	0427b783          	ld	a5,66(a5) # ffffffffc0253468 <sched_class>
ffffffffc020442e:	0287b303          	ld	t1,40(a5)
ffffffffc0204432:	0004f517          	auipc	a0,0x4f
ffffffffc0204436:	02e53503          	ld	a0,46(a0) # ffffffffc0253460 <rq>
ffffffffc020443a:	8302                	jr	t1
    }
    else {
        proc->need_resched = 1;
ffffffffc020443c:	4705                	li	a4,1
ffffffffc020443e:	ef98                	sd	a4,24(a5)
    }
}
ffffffffc0204440:	8082                	ret

ffffffffc0204442 <sched_init>:

static struct run_queue __rq;

void
sched_init(void) {
ffffffffc0204442:	1141                	addi	sp,sp,-16
    list_init(&timer_list);

    sched_class = &default_sched_class;
ffffffffc0204444:	00044717          	auipc	a4,0x44
ffffffffc0204448:	b5470713          	addi	a4,a4,-1196 # ffffffffc0247f98 <default_sched_class>
sched_init(void) {
ffffffffc020444c:	e022                	sd	s0,0(sp)
ffffffffc020444e:	e406                	sd	ra,8(sp)
ffffffffc0204450:	0004f797          	auipc	a5,0x4f
ffffffffc0204454:	fa878793          	addi	a5,a5,-88 # ffffffffc02533f8 <timer_list>
    //sched_class = &stride_sched_class;

    rq = &__rq;
    rq->max_time_slice = MAX_TIME_SLICE;
    sched_class->init(rq);
ffffffffc0204458:	6714                	ld	a3,8(a4)
    rq = &__rq;
ffffffffc020445a:	0004f517          	auipc	a0,0x4f
ffffffffc020445e:	f7e50513          	addi	a0,a0,-130 # ffffffffc02533d8 <__rq>
ffffffffc0204462:	e79c                	sd	a5,8(a5)
ffffffffc0204464:	e39c                	sd	a5,0(a5)
    rq->max_time_slice = MAX_TIME_SLICE;
ffffffffc0204466:	4795                	li	a5,5
ffffffffc0204468:	c95c                	sw	a5,20(a0)
    sched_class = &default_sched_class;
ffffffffc020446a:	0004f417          	auipc	s0,0x4f
ffffffffc020446e:	ffe40413          	addi	s0,s0,-2 # ffffffffc0253468 <sched_class>
    rq = &__rq;
ffffffffc0204472:	0004f797          	auipc	a5,0x4f
ffffffffc0204476:	fea7b723          	sd	a0,-18(a5) # ffffffffc0253460 <rq>
    sched_class = &default_sched_class;
ffffffffc020447a:	e018                	sd	a4,0(s0)
    sched_class->init(rq);
ffffffffc020447c:	9682                	jalr	a3

    cprintf("sched class: %s\n", sched_class->name);
ffffffffc020447e:	601c                	ld	a5,0(s0)
}
ffffffffc0204480:	6402                	ld	s0,0(sp)
ffffffffc0204482:	60a2                	ld	ra,8(sp)
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc0204484:	638c                	ld	a1,0(a5)
ffffffffc0204486:	00002517          	auipc	a0,0x2
ffffffffc020448a:	0c250513          	addi	a0,a0,194 # ffffffffc0206548 <default_pmm_manager+0x610>
}
ffffffffc020448e:	0141                	addi	sp,sp,16
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc0204490:	c35fb06f          	j	ffffffffc02000c4 <cprintf>

ffffffffc0204494 <wakeup_proc>:

void
wakeup_proc(struct proc_struct *proc) {
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0204494:	4118                	lw	a4,0(a0)
wakeup_proc(struct proc_struct *proc) {
ffffffffc0204496:	1101                	addi	sp,sp,-32
ffffffffc0204498:	ec06                	sd	ra,24(sp)
ffffffffc020449a:	e822                	sd	s0,16(sp)
ffffffffc020449c:	e426                	sd	s1,8(sp)
    assert(proc->state != PROC_ZOMBIE);
ffffffffc020449e:	478d                	li	a5,3
ffffffffc02044a0:	08f70363          	beq	a4,a5,ffffffffc0204526 <wakeup_proc+0x92>
ffffffffc02044a4:	842a                	mv	s0,a0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02044a6:	100027f3          	csrr	a5,sstatus
ffffffffc02044aa:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02044ac:	4481                	li	s1,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02044ae:	e7bd                	bnez	a5,ffffffffc020451c <wakeup_proc+0x88>
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE) {
ffffffffc02044b0:	4789                	li	a5,2
ffffffffc02044b2:	04f70863          	beq	a4,a5,ffffffffc0204502 <wakeup_proc+0x6e>
            proc->state = PROC_RUNNABLE;
ffffffffc02044b6:	c01c                	sw	a5,0(s0)
            proc->wait_state = 0;
ffffffffc02044b8:	0e042623          	sw	zero,236(s0)
            if (proc != current) {
ffffffffc02044bc:	0004f797          	auipc	a5,0x4f
ffffffffc02044c0:	f847b783          	ld	a5,-124(a5) # ffffffffc0253440 <current>
ffffffffc02044c4:	02878363          	beq	a5,s0,ffffffffc02044ea <wakeup_proc+0x56>
    if (proc != idleproc) {
ffffffffc02044c8:	0004f797          	auipc	a5,0x4f
ffffffffc02044cc:	f807b783          	ld	a5,-128(a5) # ffffffffc0253448 <idleproc>
ffffffffc02044d0:	00f40d63          	beq	s0,a5,ffffffffc02044ea <wakeup_proc+0x56>
        sched_class->enqueue(rq, proc);
ffffffffc02044d4:	0004f797          	auipc	a5,0x4f
ffffffffc02044d8:	f947b783          	ld	a5,-108(a5) # ffffffffc0253468 <sched_class>
ffffffffc02044dc:	6b9c                	ld	a5,16(a5)
ffffffffc02044de:	85a2                	mv	a1,s0
ffffffffc02044e0:	0004f517          	auipc	a0,0x4f
ffffffffc02044e4:	f8053503          	ld	a0,-128(a0) # ffffffffc0253460 <rq>
ffffffffc02044e8:	9782                	jalr	a5
    if (flag) {
ffffffffc02044ea:	e491                	bnez	s1,ffffffffc02044f6 <wakeup_proc+0x62>
        else {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc02044ec:	60e2                	ld	ra,24(sp)
ffffffffc02044ee:	6442                	ld	s0,16(sp)
ffffffffc02044f0:	64a2                	ld	s1,8(sp)
ffffffffc02044f2:	6105                	addi	sp,sp,32
ffffffffc02044f4:	8082                	ret
ffffffffc02044f6:	6442                	ld	s0,16(sp)
ffffffffc02044f8:	60e2                	ld	ra,24(sp)
ffffffffc02044fa:	64a2                	ld	s1,8(sp)
ffffffffc02044fc:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc02044fe:	8fafc06f          	j	ffffffffc02005f8 <intr_enable>
            warn("wakeup runnable process.\n");
ffffffffc0204502:	00002617          	auipc	a2,0x2
ffffffffc0204506:	09660613          	addi	a2,a2,150 # ffffffffc0206598 <default_pmm_manager+0x660>
ffffffffc020450a:	04900593          	li	a1,73
ffffffffc020450e:	00002517          	auipc	a0,0x2
ffffffffc0204512:	07250513          	addi	a0,a0,114 # ffffffffc0206580 <default_pmm_manager+0x648>
ffffffffc0204516:	d53fb0ef          	jal	ra,ffffffffc0200268 <__warn>
ffffffffc020451a:	bfc1                	j	ffffffffc02044ea <wakeup_proc+0x56>
        intr_disable();
ffffffffc020451c:	8e2fc0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc0204520:	4018                	lw	a4,0(s0)
ffffffffc0204522:	4485                	li	s1,1
ffffffffc0204524:	b771                	j	ffffffffc02044b0 <wakeup_proc+0x1c>
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0204526:	00002697          	auipc	a3,0x2
ffffffffc020452a:	03a68693          	addi	a3,a3,58 # ffffffffc0206560 <default_pmm_manager+0x628>
ffffffffc020452e:	00001617          	auipc	a2,0x1
ffffffffc0204532:	dea60613          	addi	a2,a2,-534 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0204536:	03d00593          	li	a1,61
ffffffffc020453a:	00002517          	auipc	a0,0x2
ffffffffc020453e:	04650513          	addi	a0,a0,70 # ffffffffc0206580 <default_pmm_manager+0x648>
ffffffffc0204542:	cbffb0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0204546 <schedule>:

void
schedule(void) {
ffffffffc0204546:	7179                	addi	sp,sp,-48
ffffffffc0204548:	f406                	sd	ra,40(sp)
ffffffffc020454a:	f022                	sd	s0,32(sp)
ffffffffc020454c:	ec26                	sd	s1,24(sp)
ffffffffc020454e:	e84a                	sd	s2,16(sp)
ffffffffc0204550:	e44e                	sd	s3,8(sp)
ffffffffc0204552:	e052                	sd	s4,0(sp)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0204554:	100027f3          	csrr	a5,sstatus
ffffffffc0204558:	8b89                	andi	a5,a5,2
ffffffffc020455a:	4a01                	li	s4,0
ffffffffc020455c:	ebdd                	bnez	a5,ffffffffc0204612 <schedule+0xcc>
    bool intr_flag;
    struct proc_struct *next;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
ffffffffc020455e:	0004f497          	auipc	s1,0x4f
ffffffffc0204562:	ee248493          	addi	s1,s1,-286 # ffffffffc0253440 <current>
ffffffffc0204566:	608c                	ld	a1,0(s1)
ffffffffc0204568:	0004f997          	auipc	s3,0x4f
ffffffffc020456c:	f0098993          	addi	s3,s3,-256 # ffffffffc0253468 <sched_class>
ffffffffc0204570:	0004f917          	auipc	s2,0x4f
ffffffffc0204574:	ef090913          	addi	s2,s2,-272 # ffffffffc0253460 <rq>
        if (current->state == PROC_RUNNABLE) {
ffffffffc0204578:	4194                	lw	a3,0(a1)
        current->need_resched = 0;
ffffffffc020457a:	0005bc23          	sd	zero,24(a1)
        if (current->state == PROC_RUNNABLE) {
ffffffffc020457e:	4709                	li	a4,2
ffffffffc0204580:	0009b783          	ld	a5,0(s3)
ffffffffc0204584:	00093503          	ld	a0,0(s2)
ffffffffc0204588:	04e68763          	beq	a3,a4,ffffffffc02045d6 <schedule+0x90>
    return sched_class->pick_next(rq);
ffffffffc020458c:	739c                	ld	a5,32(a5)
ffffffffc020458e:	9782                	jalr	a5
ffffffffc0204590:	842a                	mv	s0,a0
            sched_class_enqueue(current);
        }
        if ((next = sched_class_pick_next()) != NULL) {
ffffffffc0204592:	c135                	beqz	a0,ffffffffc02045f6 <schedule+0xb0>
    sched_class->dequeue(rq, proc);
ffffffffc0204594:	0009b783          	ld	a5,0(s3)
ffffffffc0204598:	00093503          	ld	a0,0(s2)
ffffffffc020459c:	85a2                	mv	a1,s0
ffffffffc020459e:	6f9c                	ld	a5,24(a5)
ffffffffc02045a0:	9782                	jalr	a5
            sched_class_dequeue(next);
        }
        if (next == NULL) {
            next = idleproc;
        }
        next->runs ++;
ffffffffc02045a2:	441c                	lw	a5,8(s0)
        if (next != current) {
ffffffffc02045a4:	6098                	ld	a4,0(s1)
        next->runs ++;
ffffffffc02045a6:	2785                	addiw	a5,a5,1
ffffffffc02045a8:	c41c                	sw	a5,8(s0)
        if (next != current) {
ffffffffc02045aa:	00870c63          	beq	a4,s0,ffffffffc02045c2 <schedule+0x7c>
            cprintf("The next proc is pid:%d\n",next->pid);
ffffffffc02045ae:	404c                	lw	a1,4(s0)
ffffffffc02045b0:	00002517          	auipc	a0,0x2
ffffffffc02045b4:	00850513          	addi	a0,a0,8 # ffffffffc02065b8 <default_pmm_manager+0x680>
ffffffffc02045b8:	b0dfb0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            proc_run(next);
ffffffffc02045bc:	8522                	mv	a0,s0
ffffffffc02045be:	eb1fe0ef          	jal	ra,ffffffffc020346e <proc_run>
    if (flag) {
ffffffffc02045c2:	020a1f63          	bnez	s4,ffffffffc0204600 <schedule+0xba>
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc02045c6:	70a2                	ld	ra,40(sp)
ffffffffc02045c8:	7402                	ld	s0,32(sp)
ffffffffc02045ca:	64e2                	ld	s1,24(sp)
ffffffffc02045cc:	6942                	ld	s2,16(sp)
ffffffffc02045ce:	69a2                	ld	s3,8(sp)
ffffffffc02045d0:	6a02                	ld	s4,0(sp)
ffffffffc02045d2:	6145                	addi	sp,sp,48
ffffffffc02045d4:	8082                	ret
    if (proc != idleproc) {
ffffffffc02045d6:	0004f717          	auipc	a4,0x4f
ffffffffc02045da:	e7273703          	ld	a4,-398(a4) # ffffffffc0253448 <idleproc>
ffffffffc02045de:	fae587e3          	beq	a1,a4,ffffffffc020458c <schedule+0x46>
        sched_class->enqueue(rq, proc);
ffffffffc02045e2:	6b9c                	ld	a5,16(a5)
ffffffffc02045e4:	9782                	jalr	a5
ffffffffc02045e6:	0009b783          	ld	a5,0(s3)
ffffffffc02045ea:	00093503          	ld	a0,0(s2)
    return sched_class->pick_next(rq);
ffffffffc02045ee:	739c                	ld	a5,32(a5)
ffffffffc02045f0:	9782                	jalr	a5
ffffffffc02045f2:	842a                	mv	s0,a0
        if ((next = sched_class_pick_next()) != NULL) {
ffffffffc02045f4:	f145                	bnez	a0,ffffffffc0204594 <schedule+0x4e>
            next = idleproc;
ffffffffc02045f6:	0004f417          	auipc	s0,0x4f
ffffffffc02045fa:	e5243403          	ld	s0,-430(s0) # ffffffffc0253448 <idleproc>
ffffffffc02045fe:	b755                	j	ffffffffc02045a2 <schedule+0x5c>
}
ffffffffc0204600:	7402                	ld	s0,32(sp)
ffffffffc0204602:	70a2                	ld	ra,40(sp)
ffffffffc0204604:	64e2                	ld	s1,24(sp)
ffffffffc0204606:	6942                	ld	s2,16(sp)
ffffffffc0204608:	69a2                	ld	s3,8(sp)
ffffffffc020460a:	6a02                	ld	s4,0(sp)
ffffffffc020460c:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc020460e:	febfb06f          	j	ffffffffc02005f8 <intr_enable>
        intr_disable();
ffffffffc0204612:	fedfb0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc0204616:	4a05                	li	s4,1
ffffffffc0204618:	b799                	j	ffffffffc020455e <schedule+0x18>

ffffffffc020461a <RR_init>:
ffffffffc020461a:	e508                	sd	a0,8(a0)
ffffffffc020461c:	e108                	sd	a0,0(a0)
#include <default_sched.h>

static void
RR_init(struct run_queue *rq) {
    list_init(&(rq->run_list));
    rq->proc_num = 0;
ffffffffc020461e:	00052823          	sw	zero,16(a0)
}
ffffffffc0204622:	8082                	ret

ffffffffc0204624 <RR_enqueue>:
    __list_add(elm, listelm->prev, listelm);
ffffffffc0204624:	611c                	ld	a5,0(a0)

static void
RR_enqueue(struct run_queue *rq, struct proc_struct *proc) {


    list_add_before(&(rq->run_list), &(proc->run_link));
ffffffffc0204626:	11058713          	addi	a4,a1,272
    prev->next = next->prev = elm;
ffffffffc020462a:	e118                	sd	a4,0(a0)
    if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice) {
ffffffffc020462c:	1205a683          	lw	a3,288(a1)
ffffffffc0204630:	e798                	sd	a4,8(a5)
    elm->prev = prev;
ffffffffc0204632:	10f5b823          	sd	a5,272(a1)
    elm->next = next;
ffffffffc0204636:	10a5bc23          	sd	a0,280(a1)
ffffffffc020463a:	495c                	lw	a5,20(a0)
ffffffffc020463c:	c299                	beqz	a3,ffffffffc0204642 <RR_enqueue+0x1e>
ffffffffc020463e:	00d7d463          	bge	a5,a3,ffffffffc0204646 <RR_enqueue+0x22>
        proc->time_slice = rq->max_time_slice;
ffffffffc0204642:	12f5a023          	sw	a5,288(a1)
    }
    proc->rq = rq;
    rq->proc_num ++;
ffffffffc0204646:	491c                	lw	a5,16(a0)
    proc->rq = rq;
ffffffffc0204648:	10a5b423          	sd	a0,264(a1)
    rq->proc_num ++;
ffffffffc020464c:	2785                	addiw	a5,a5,1
ffffffffc020464e:	c91c                	sw	a5,16(a0)
}
ffffffffc0204650:	8082                	ret

ffffffffc0204652 <RR_pick_next>:
    return listelm->next;
ffffffffc0204652:	6510                	ld	a2,8(a0)
    list_entry_t *le = list_next(&(rq->run_list));

    list_entry_t* result = le;
    int max = 0;

    while(le != &(rq->run_list)){
ffffffffc0204654:	02a60163          	beq	a2,a0,ffffffffc0204676 <RR_pick_next+0x24>
ffffffffc0204658:	87b2                	mv	a5,a2
    int max = 0;
ffffffffc020465a:	4681                	li	a3,0
        int value = le2proc(le, run_link) -> labschedule_good;
ffffffffc020465c:	4f98                	lw	a4,24(a5)
        if(value > max){
ffffffffc020465e:	00e6d463          	bge	a3,a4,ffffffffc0204666 <RR_pick_next+0x14>
ffffffffc0204662:	863e                	mv	a2,a5
ffffffffc0204664:	86ba                	mv	a3,a4
ffffffffc0204666:	679c                	ld	a5,8(a5)
    while(le != &(rq->run_list)){
ffffffffc0204668:	fea79ae3          	bne	a5,a0,ffffffffc020465c <RR_pick_next+0xa>
        //cprintf("123\n");

        le = list_next(le);
    }

    if (result != &(rq->run_list)) {
ffffffffc020466c:	00f60563          	beq	a2,a5,ffffffffc0204676 <RR_pick_next+0x24>
        return le2proc(result, run_link);
ffffffffc0204670:	ef060513          	addi	a0,a2,-272
ffffffffc0204674:	8082                	ret
    }
    return NULL;
ffffffffc0204676:	4501                	li	a0,0
}
ffffffffc0204678:	8082                	ret

ffffffffc020467a <RR_proc_tick>:

static void
RR_proc_tick(struct run_queue *rq, struct proc_struct *proc) {
    if (proc->time_slice > 0) {
ffffffffc020467a:	1205a783          	lw	a5,288(a1)
ffffffffc020467e:	00f05563          	blez	a5,ffffffffc0204688 <RR_proc_tick+0xe>
        proc->time_slice --;
ffffffffc0204682:	37fd                	addiw	a5,a5,-1
ffffffffc0204684:	12f5a023          	sw	a5,288(a1)
    }
    if (proc->time_slice == 0) {
ffffffffc0204688:	e399                	bnez	a5,ffffffffc020468e <RR_proc_tick+0x14>
        proc->need_resched = 1;
ffffffffc020468a:	4785                	li	a5,1
ffffffffc020468c:	ed9c                	sd	a5,24(a1)
    }
}
ffffffffc020468e:	8082                	ret

ffffffffc0204690 <RR_dequeue>:
    return list->next == list;
ffffffffc0204690:	1185b703          	ld	a4,280(a1)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc0204694:	11058793          	addi	a5,a1,272
ffffffffc0204698:	02e78363          	beq	a5,a4,ffffffffc02046be <RR_dequeue+0x2e>
ffffffffc020469c:	1085b683          	ld	a3,264(a1)
ffffffffc02046a0:	00a69f63          	bne	a3,a0,ffffffffc02046be <RR_dequeue+0x2e>
    __list_del(listelm->prev, listelm->next);
ffffffffc02046a4:	1105b503          	ld	a0,272(a1)
    rq->proc_num --;
ffffffffc02046a8:	4a90                	lw	a2,16(a3)
    prev->next = next;
ffffffffc02046aa:	e518                	sd	a4,8(a0)
    next->prev = prev;
ffffffffc02046ac:	e308                	sd	a0,0(a4)
    elm->prev = elm->next = elm;
ffffffffc02046ae:	10f5bc23          	sd	a5,280(a1)
ffffffffc02046b2:	10f5b823          	sd	a5,272(a1)
ffffffffc02046b6:	fff6079b          	addiw	a5,a2,-1
ffffffffc02046ba:	ca9c                	sw	a5,16(a3)
ffffffffc02046bc:	8082                	ret
RR_dequeue(struct run_queue *rq, struct proc_struct *proc) {
ffffffffc02046be:	1141                	addi	sp,sp,-16
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02046c0:	00002697          	auipc	a3,0x2
ffffffffc02046c4:	f1868693          	addi	a3,a3,-232 # ffffffffc02065d8 <default_pmm_manager+0x6a0>
ffffffffc02046c8:	00001617          	auipc	a2,0x1
ffffffffc02046cc:	c5060613          	addi	a2,a2,-944 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02046d0:	45ed                	li	a1,27
ffffffffc02046d2:	00002517          	auipc	a0,0x2
ffffffffc02046d6:	f3e50513          	addi	a0,a0,-194 # ffffffffc0206610 <default_pmm_manager+0x6d8>
RR_dequeue(struct run_queue *rq, struct proc_struct *proc) {
ffffffffc02046da:	e406                	sd	ra,8(sp)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02046dc:	b25fb0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02046e0 <sys_getpid>:
    return do_kill(pid);
}

static int
sys_getpid(uint64_t arg[]) {
    return current->pid;
ffffffffc02046e0:	0004f797          	auipc	a5,0x4f
ffffffffc02046e4:	d607b783          	ld	a5,-672(a5) # ffffffffc0253440 <current>
}
ffffffffc02046e8:	43c8                	lw	a0,4(a5)
ffffffffc02046ea:	8082                	ret

ffffffffc02046ec <sys_gettime>:
    cputchar(c);
    return 0;
}

static int sys_gettime(uint64_t arg[]){
    return (int)ticks*10;
ffffffffc02046ec:	0004f797          	auipc	a5,0x4f
ffffffffc02046f0:	d847b783          	ld	a5,-636(a5) # ffffffffc0253470 <ticks>
ffffffffc02046f4:	0027951b          	slliw	a0,a5,0x2
ffffffffc02046f8:	9d3d                	addw	a0,a0,a5
}
ffffffffc02046fa:	0015151b          	slliw	a0,a0,0x1
ffffffffc02046fe:	8082                	ret

ffffffffc0204700 <sys_setgood>:

static int sys_setgood(uint64_t arg[]){
ffffffffc0204700:	1141                	addi	sp,sp,-16
ffffffffc0204702:	e022                	sd	s0,0(sp)
    int v = current -> labschedule_good = arg[0];
ffffffffc0204704:	6100                	ld	s0,0(a0)
static int sys_setgood(uint64_t arg[]){
ffffffffc0204706:	e406                	sd	ra,8(sp)
    int v = current -> labschedule_good = arg[0];
ffffffffc0204708:	0004f797          	auipc	a5,0x4f
ffffffffc020470c:	d387b783          	ld	a5,-712(a5) # ffffffffc0253440 <current>
ffffffffc0204710:	1287a423          	sw	s0,296(a5)
    schedule();
ffffffffc0204714:	e33ff0ef          	jal	ra,ffffffffc0204546 <schedule>
    return v;
}
ffffffffc0204718:	60a2                	ld	ra,8(sp)
ffffffffc020471a:	0004051b          	sext.w	a0,s0
ffffffffc020471e:	6402                	ld	s0,0(sp)
ffffffffc0204720:	0141                	addi	sp,sp,16
ffffffffc0204722:	8082                	ret

ffffffffc0204724 <sys_putc>:
    cputchar(c);
ffffffffc0204724:	4108                	lw	a0,0(a0)
sys_putc(uint64_t arg[]) {
ffffffffc0204726:	1141                	addi	sp,sp,-16
ffffffffc0204728:	e406                	sd	ra,8(sp)
    cputchar(c);
ffffffffc020472a:	9d1fb0ef          	jal	ra,ffffffffc02000fa <cputchar>
}
ffffffffc020472e:	60a2                	ld	ra,8(sp)
ffffffffc0204730:	4501                	li	a0,0
ffffffffc0204732:	0141                	addi	sp,sp,16
ffffffffc0204734:	8082                	ret

ffffffffc0204736 <sys_kill>:
    return do_kill(pid);
ffffffffc0204736:	4108                	lw	a0,0(a0)
ffffffffc0204738:	b49ff06f          	j	ffffffffc0204280 <do_kill>

ffffffffc020473c <sys_yield>:
    return do_yield();
ffffffffc020473c:	af7ff06f          	j	ffffffffc0204232 <do_yield>

ffffffffc0204740 <sys_exec>:
    return do_execve(name, len, binary, size);
ffffffffc0204740:	6d14                	ld	a3,24(a0)
ffffffffc0204742:	6910                	ld	a2,16(a0)
ffffffffc0204744:	650c                	ld	a1,8(a0)
ffffffffc0204746:	6108                	ld	a0,0(a0)
ffffffffc0204748:	e02ff06f          	j	ffffffffc0203d4a <do_execve>

ffffffffc020474c <sys_wait>:
    return do_wait(pid, store);
ffffffffc020474c:	650c                	ld	a1,8(a0)
ffffffffc020474e:	4108                	lw	a0,0(a0)
ffffffffc0204750:	af3ff06f          	j	ffffffffc0204242 <do_wait>

ffffffffc0204754 <sys_fork>:
    struct trapframe *tf = current->tf;
ffffffffc0204754:	0004f797          	auipc	a5,0x4f
ffffffffc0204758:	cec7b783          	ld	a5,-788(a5) # ffffffffc0253440 <current>
ffffffffc020475c:	73d0                	ld	a2,160(a5)
    return do_fork(0, stack, tf);
ffffffffc020475e:	4501                	li	a0,0
ffffffffc0204760:	6a0c                	ld	a1,16(a2)
ffffffffc0204762:	dd1fe06f          	j	ffffffffc0203532 <do_fork>

ffffffffc0204766 <sys_exit>:
    return do_exit(error_code);
ffffffffc0204766:	4108                	lw	a0,0(a0)
ffffffffc0204768:	9deff06f          	j	ffffffffc0203946 <do_exit>

ffffffffc020476c <syscall>:


#define NUM_SYSCALLS        ((sizeof(syscalls)) / (sizeof(syscalls[0])))

void
syscall(void) {
ffffffffc020476c:	715d                	addi	sp,sp,-80
ffffffffc020476e:	fc26                	sd	s1,56(sp)
    struct trapframe *tf = current->tf;
ffffffffc0204770:	0004f497          	auipc	s1,0x4f
ffffffffc0204774:	cd048493          	addi	s1,s1,-816 # ffffffffc0253440 <current>
ffffffffc0204778:	6098                	ld	a4,0(s1)
syscall(void) {
ffffffffc020477a:	e0a2                	sd	s0,64(sp)
ffffffffc020477c:	f84a                	sd	s2,48(sp)
    struct trapframe *tf = current->tf;
ffffffffc020477e:	7340                	ld	s0,160(a4)
syscall(void) {
ffffffffc0204780:	e486                	sd	ra,72(sp)
    uint64_t arg[5];
    int num = tf->gpr.a0;
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc0204782:	0fe00793          	li	a5,254
    int num = tf->gpr.a0;
ffffffffc0204786:	05042903          	lw	s2,80(s0)
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc020478a:	0327ee63          	bltu	a5,s2,ffffffffc02047c6 <syscall+0x5a>
        if (syscalls[num] != NULL) {
ffffffffc020478e:	00391713          	slli	a4,s2,0x3
ffffffffc0204792:	00002797          	auipc	a5,0x2
ffffffffc0204796:	ef678793          	addi	a5,a5,-266 # ffffffffc0206688 <syscalls>
ffffffffc020479a:	97ba                	add	a5,a5,a4
ffffffffc020479c:	639c                	ld	a5,0(a5)
ffffffffc020479e:	c785                	beqz	a5,ffffffffc02047c6 <syscall+0x5a>
            arg[0] = tf->gpr.a1;
ffffffffc02047a0:	6c28                	ld	a0,88(s0)
            arg[1] = tf->gpr.a2;
ffffffffc02047a2:	702c                	ld	a1,96(s0)
            arg[2] = tf->gpr.a3;
ffffffffc02047a4:	7430                	ld	a2,104(s0)
            arg[3] = tf->gpr.a4;
ffffffffc02047a6:	7834                	ld	a3,112(s0)
            arg[4] = tf->gpr.a5;
ffffffffc02047a8:	7c38                	ld	a4,120(s0)
            arg[0] = tf->gpr.a1;
ffffffffc02047aa:	e42a                	sd	a0,8(sp)
            arg[1] = tf->gpr.a2;
ffffffffc02047ac:	e82e                	sd	a1,16(sp)
            arg[2] = tf->gpr.a3;
ffffffffc02047ae:	ec32                	sd	a2,24(sp)
            arg[3] = tf->gpr.a4;
ffffffffc02047b0:	f036                	sd	a3,32(sp)
            arg[4] = tf->gpr.a5;
ffffffffc02047b2:	f43a                	sd	a4,40(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02047b4:	0028                	addi	a0,sp,8
ffffffffc02047b6:	9782                	jalr	a5
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
ffffffffc02047b8:	60a6                	ld	ra,72(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02047ba:	e828                	sd	a0,80(s0)
}
ffffffffc02047bc:	6406                	ld	s0,64(sp)
ffffffffc02047be:	74e2                	ld	s1,56(sp)
ffffffffc02047c0:	7942                	ld	s2,48(sp)
ffffffffc02047c2:	6161                	addi	sp,sp,80
ffffffffc02047c4:	8082                	ret
    print_trapframe(tf);
ffffffffc02047c6:	8522                	mv	a0,s0
ffffffffc02047c8:	824fc0ef          	jal	ra,ffffffffc02007ec <print_trapframe>
    panic("undefined syscall %d, pid = %d, name = %s.\n",
ffffffffc02047cc:	609c                	ld	a5,0(s1)
ffffffffc02047ce:	86ca                	mv	a3,s2
ffffffffc02047d0:	00002617          	auipc	a2,0x2
ffffffffc02047d4:	e7060613          	addi	a2,a2,-400 # ffffffffc0206640 <default_pmm_manager+0x708>
ffffffffc02047d8:	43d8                	lw	a4,4(a5)
ffffffffc02047da:	06b00593          	li	a1,107
ffffffffc02047de:	0b478793          	addi	a5,a5,180
ffffffffc02047e2:	00002517          	auipc	a0,0x2
ffffffffc02047e6:	e8e50513          	addi	a0,a0,-370 # ffffffffc0206670 <default_pmm_manager+0x738>
ffffffffc02047ea:	a17fb0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02047ee <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc02047ee:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc02047f2:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc02047f4:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc02047f6:	cb81                	beqz	a5,ffffffffc0204806 <strlen+0x18>
        cnt ++;
ffffffffc02047f8:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc02047fa:	00a707b3          	add	a5,a4,a0
ffffffffc02047fe:	0007c783          	lbu	a5,0(a5)
ffffffffc0204802:	fbfd                	bnez	a5,ffffffffc02047f8 <strlen+0xa>
ffffffffc0204804:	8082                	ret
    }
    return cnt;
}
ffffffffc0204806:	8082                	ret

ffffffffc0204808 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
ffffffffc0204808:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc020480a:	4501                	li	a0,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc020480c:	e589                	bnez	a1,ffffffffc0204816 <strnlen+0xe>
ffffffffc020480e:	a811                	j	ffffffffc0204822 <strnlen+0x1a>
        cnt ++;
ffffffffc0204810:	0505                	addi	a0,a0,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0204812:	00a58763          	beq	a1,a0,ffffffffc0204820 <strnlen+0x18>
ffffffffc0204816:	00a707b3          	add	a5,a4,a0
ffffffffc020481a:	0007c783          	lbu	a5,0(a5)
ffffffffc020481e:	fbed                	bnez	a5,ffffffffc0204810 <strnlen+0x8>
    }
    return cnt;
}
ffffffffc0204820:	8082                	ret
ffffffffc0204822:	8082                	ret

ffffffffc0204824 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0204824:	00054783          	lbu	a5,0(a0)
ffffffffc0204828:	0005c703          	lbu	a4,0(a1)
ffffffffc020482c:	cb89                	beqz	a5,ffffffffc020483e <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc020482e:	0505                	addi	a0,a0,1
ffffffffc0204830:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0204832:	fee789e3          	beq	a5,a4,ffffffffc0204824 <strcmp>
ffffffffc0204836:	0007851b          	sext.w	a0,a5
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc020483a:	9d19                	subw	a0,a0,a4
ffffffffc020483c:	8082                	ret
ffffffffc020483e:	4501                	li	a0,0
ffffffffc0204840:	bfed                	j	ffffffffc020483a <strcmp+0x16>

ffffffffc0204842 <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc0204842:	00054783          	lbu	a5,0(a0)
ffffffffc0204846:	c799                	beqz	a5,ffffffffc0204854 <strchr+0x12>
        if (*s == c) {
ffffffffc0204848:	00f58763          	beq	a1,a5,ffffffffc0204856 <strchr+0x14>
    while (*s != '\0') {
ffffffffc020484c:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc0204850:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc0204852:	fbfd                	bnez	a5,ffffffffc0204848 <strchr+0x6>
    }
    return NULL;
ffffffffc0204854:	4501                	li	a0,0
}
ffffffffc0204856:	8082                	ret

ffffffffc0204858 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0204858:	ca01                	beqz	a2,ffffffffc0204868 <memset+0x10>
ffffffffc020485a:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc020485c:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc020485e:	0785                	addi	a5,a5,1
ffffffffc0204860:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0204864:	fec79de3          	bne	a5,a2,ffffffffc020485e <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0204868:	8082                	ret

ffffffffc020486a <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc020486a:	ca19                	beqz	a2,ffffffffc0204880 <memcpy+0x16>
ffffffffc020486c:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc020486e:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc0204870:	0005c703          	lbu	a4,0(a1)
ffffffffc0204874:	0585                	addi	a1,a1,1
ffffffffc0204876:	0785                	addi	a5,a5,1
ffffffffc0204878:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc020487c:	fec59ae3          	bne	a1,a2,ffffffffc0204870 <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc0204880:	8082                	ret

ffffffffc0204882 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc0204882:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0204886:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0204888:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc020488c:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc020488e:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0204892:	f022                	sd	s0,32(sp)
ffffffffc0204894:	ec26                	sd	s1,24(sp)
ffffffffc0204896:	e84a                	sd	s2,16(sp)
ffffffffc0204898:	f406                	sd	ra,40(sp)
ffffffffc020489a:	e44e                	sd	s3,8(sp)
ffffffffc020489c:	84aa                	mv	s1,a0
ffffffffc020489e:	892e                	mv	s2,a1
ffffffffc02048a0:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc02048a4:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
ffffffffc02048a6:	03067e63          	bgeu	a2,a6,ffffffffc02048e2 <printnum+0x60>
ffffffffc02048aa:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc02048ac:	00805763          	blez	s0,ffffffffc02048ba <printnum+0x38>
ffffffffc02048b0:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc02048b2:	85ca                	mv	a1,s2
ffffffffc02048b4:	854e                	mv	a0,s3
ffffffffc02048b6:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc02048b8:	fc65                	bnez	s0,ffffffffc02048b0 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048ba:	1a02                	slli	s4,s4,0x20
ffffffffc02048bc:	020a5a13          	srli	s4,s4,0x20
ffffffffc02048c0:	00002797          	auipc	a5,0x2
ffffffffc02048c4:	5c078793          	addi	a5,a5,1472 # ffffffffc0206e80 <syscalls+0x7f8>
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
ffffffffc02048c8:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048ca:	9a3e                	add	s4,s4,a5
ffffffffc02048cc:	000a4503          	lbu	a0,0(s4)
}
ffffffffc02048d0:	70a2                	ld	ra,40(sp)
ffffffffc02048d2:	69a2                	ld	s3,8(sp)
ffffffffc02048d4:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048d6:	85ca                	mv	a1,s2
ffffffffc02048d8:	8326                	mv	t1,s1
}
ffffffffc02048da:	6942                	ld	s2,16(sp)
ffffffffc02048dc:	64e2                	ld	s1,24(sp)
ffffffffc02048de:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048e0:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc02048e2:	03065633          	divu	a2,a2,a6
ffffffffc02048e6:	8722                	mv	a4,s0
ffffffffc02048e8:	f9bff0ef          	jal	ra,ffffffffc0204882 <printnum>
ffffffffc02048ec:	b7f9                	j	ffffffffc02048ba <printnum+0x38>

ffffffffc02048ee <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc02048ee:	7119                	addi	sp,sp,-128
ffffffffc02048f0:	f4a6                	sd	s1,104(sp)
ffffffffc02048f2:	f0ca                	sd	s2,96(sp)
ffffffffc02048f4:	ecce                	sd	s3,88(sp)
ffffffffc02048f6:	e8d2                	sd	s4,80(sp)
ffffffffc02048f8:	e4d6                	sd	s5,72(sp)
ffffffffc02048fa:	e0da                	sd	s6,64(sp)
ffffffffc02048fc:	fc5e                	sd	s7,56(sp)
ffffffffc02048fe:	f06a                	sd	s10,32(sp)
ffffffffc0204900:	fc86                	sd	ra,120(sp)
ffffffffc0204902:	f8a2                	sd	s0,112(sp)
ffffffffc0204904:	f862                	sd	s8,48(sp)
ffffffffc0204906:	f466                	sd	s9,40(sp)
ffffffffc0204908:	ec6e                	sd	s11,24(sp)
ffffffffc020490a:	892a                	mv	s2,a0
ffffffffc020490c:	84ae                	mv	s1,a1
ffffffffc020490e:	8d32                	mv	s10,a2
ffffffffc0204910:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204912:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0204916:	5b7d                	li	s6,-1
ffffffffc0204918:	00002a97          	auipc	s5,0x2
ffffffffc020491c:	594a8a93          	addi	s5,s5,1428 # ffffffffc0206eac <syscalls+0x824>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0204920:	00002b97          	auipc	s7,0x2
ffffffffc0204924:	7a8b8b93          	addi	s7,s7,1960 # ffffffffc02070c8 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204928:	000d4503          	lbu	a0,0(s10)
ffffffffc020492c:	001d0413          	addi	s0,s10,1
ffffffffc0204930:	01350a63          	beq	a0,s3,ffffffffc0204944 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0204934:	c121                	beqz	a0,ffffffffc0204974 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0204936:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204938:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc020493a:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020493c:	fff44503          	lbu	a0,-1(s0)
ffffffffc0204940:	ff351ae3          	bne	a0,s3,ffffffffc0204934 <vprintfmt+0x46>
ffffffffc0204944:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0204948:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc020494c:	4c81                	li	s9,0
ffffffffc020494e:	4881                	li	a7,0
        width = precision = -1;
ffffffffc0204950:	5c7d                	li	s8,-1
ffffffffc0204952:	5dfd                	li	s11,-1
ffffffffc0204954:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0204958:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020495a:	fdd6059b          	addiw	a1,a2,-35
ffffffffc020495e:	0ff5f593          	andi	a1,a1,255
ffffffffc0204962:	00140d13          	addi	s10,s0,1
ffffffffc0204966:	04b56263          	bltu	a0,a1,ffffffffc02049aa <vprintfmt+0xbc>
ffffffffc020496a:	058a                	slli	a1,a1,0x2
ffffffffc020496c:	95d6                	add	a1,a1,s5
ffffffffc020496e:	4194                	lw	a3,0(a1)
ffffffffc0204970:	96d6                	add	a3,a3,s5
ffffffffc0204972:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0204974:	70e6                	ld	ra,120(sp)
ffffffffc0204976:	7446                	ld	s0,112(sp)
ffffffffc0204978:	74a6                	ld	s1,104(sp)
ffffffffc020497a:	7906                	ld	s2,96(sp)
ffffffffc020497c:	69e6                	ld	s3,88(sp)
ffffffffc020497e:	6a46                	ld	s4,80(sp)
ffffffffc0204980:	6aa6                	ld	s5,72(sp)
ffffffffc0204982:	6b06                	ld	s6,64(sp)
ffffffffc0204984:	7be2                	ld	s7,56(sp)
ffffffffc0204986:	7c42                	ld	s8,48(sp)
ffffffffc0204988:	7ca2                	ld	s9,40(sp)
ffffffffc020498a:	7d02                	ld	s10,32(sp)
ffffffffc020498c:	6de2                	ld	s11,24(sp)
ffffffffc020498e:	6109                	addi	sp,sp,128
ffffffffc0204990:	8082                	ret
            padc = '0';
ffffffffc0204992:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0204994:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204998:	846a                	mv	s0,s10
ffffffffc020499a:	00140d13          	addi	s10,s0,1
ffffffffc020499e:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02049a2:	0ff5f593          	andi	a1,a1,255
ffffffffc02049a6:	fcb572e3          	bgeu	a0,a1,ffffffffc020496a <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc02049aa:	85a6                	mv	a1,s1
ffffffffc02049ac:	02500513          	li	a0,37
ffffffffc02049b0:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc02049b2:	fff44783          	lbu	a5,-1(s0)
ffffffffc02049b6:	8d22                	mv	s10,s0
ffffffffc02049b8:	f73788e3          	beq	a5,s3,ffffffffc0204928 <vprintfmt+0x3a>
ffffffffc02049bc:	ffed4783          	lbu	a5,-2(s10)
ffffffffc02049c0:	1d7d                	addi	s10,s10,-1
ffffffffc02049c2:	ff379de3          	bne	a5,s3,ffffffffc02049bc <vprintfmt+0xce>
ffffffffc02049c6:	b78d                	j	ffffffffc0204928 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc02049c8:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc02049cc:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02049d0:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc02049d2:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc02049d6:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc02049da:	02d86463          	bltu	a6,a3,ffffffffc0204a02 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc02049de:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc02049e2:	002c169b          	slliw	a3,s8,0x2
ffffffffc02049e6:	0186873b          	addw	a4,a3,s8
ffffffffc02049ea:	0017171b          	slliw	a4,a4,0x1
ffffffffc02049ee:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc02049f0:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc02049f4:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc02049f6:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc02049fa:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc02049fe:	fed870e3          	bgeu	a6,a3,ffffffffc02049de <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0204a02:	f40ddce3          	bgez	s11,ffffffffc020495a <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0204a06:	8de2                	mv	s11,s8
ffffffffc0204a08:	5c7d                	li	s8,-1
ffffffffc0204a0a:	bf81                	j	ffffffffc020495a <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0204a0c:	fffdc693          	not	a3,s11
ffffffffc0204a10:	96fd                	srai	a3,a3,0x3f
ffffffffc0204a12:	00ddfdb3          	and	s11,s11,a3
ffffffffc0204a16:	00144603          	lbu	a2,1(s0)
ffffffffc0204a1a:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a1c:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204a1e:	bf35                	j	ffffffffc020495a <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0204a20:	000a2c03          	lw	s8,0(s4)
            goto process_precision;
ffffffffc0204a24:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0204a28:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a2a:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0204a2c:	bfd9                	j	ffffffffc0204a02 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0204a2e:	4705                	li	a4,1
ffffffffc0204a30:	008a0593          	addi	a1,s4,8
ffffffffc0204a34:	01174463          	blt	a4,a7,ffffffffc0204a3c <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0204a38:	1a088e63          	beqz	a7,ffffffffc0204bf4 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0204a3c:	000a3603          	ld	a2,0(s4)
ffffffffc0204a40:	46c1                	li	a3,16
ffffffffc0204a42:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0204a44:	2781                	sext.w	a5,a5
ffffffffc0204a46:	876e                	mv	a4,s11
ffffffffc0204a48:	85a6                	mv	a1,s1
ffffffffc0204a4a:	854a                	mv	a0,s2
ffffffffc0204a4c:	e37ff0ef          	jal	ra,ffffffffc0204882 <printnum>
            break;
ffffffffc0204a50:	bde1                	j	ffffffffc0204928 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0204a52:	000a2503          	lw	a0,0(s4)
ffffffffc0204a56:	85a6                	mv	a1,s1
ffffffffc0204a58:	0a21                	addi	s4,s4,8
ffffffffc0204a5a:	9902                	jalr	s2
            break;
ffffffffc0204a5c:	b5f1                	j	ffffffffc0204928 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0204a5e:	4705                	li	a4,1
ffffffffc0204a60:	008a0593          	addi	a1,s4,8
ffffffffc0204a64:	01174463          	blt	a4,a7,ffffffffc0204a6c <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0204a68:	18088163          	beqz	a7,ffffffffc0204bea <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0204a6c:	000a3603          	ld	a2,0(s4)
ffffffffc0204a70:	46a9                	li	a3,10
ffffffffc0204a72:	8a2e                	mv	s4,a1
ffffffffc0204a74:	bfc1                	j	ffffffffc0204a44 <vprintfmt+0x156>
            goto reswitch;
ffffffffc0204a76:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0204a7a:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a7c:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204a7e:	bdf1                	j	ffffffffc020495a <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0204a80:	85a6                	mv	a1,s1
ffffffffc0204a82:	02500513          	li	a0,37
ffffffffc0204a86:	9902                	jalr	s2
            break;
ffffffffc0204a88:	b545                	j	ffffffffc0204928 <vprintfmt+0x3a>
            lflag ++;
ffffffffc0204a8a:	00144603          	lbu	a2,1(s0)
ffffffffc0204a8e:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a90:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204a92:	b5e1                	j	ffffffffc020495a <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0204a94:	4705                	li	a4,1
ffffffffc0204a96:	008a0593          	addi	a1,s4,8
ffffffffc0204a9a:	01174463          	blt	a4,a7,ffffffffc0204aa2 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0204a9e:	14088163          	beqz	a7,ffffffffc0204be0 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0204aa2:	000a3603          	ld	a2,0(s4)
ffffffffc0204aa6:	46a1                	li	a3,8
ffffffffc0204aa8:	8a2e                	mv	s4,a1
ffffffffc0204aaa:	bf69                	j	ffffffffc0204a44 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0204aac:	03000513          	li	a0,48
ffffffffc0204ab0:	85a6                	mv	a1,s1
ffffffffc0204ab2:	e03e                	sd	a5,0(sp)
ffffffffc0204ab4:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0204ab6:	85a6                	mv	a1,s1
ffffffffc0204ab8:	07800513          	li	a0,120
ffffffffc0204abc:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0204abe:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0204ac0:	6782                	ld	a5,0(sp)
ffffffffc0204ac2:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0204ac4:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0204ac8:	bfb5                	j	ffffffffc0204a44 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0204aca:	000a3403          	ld	s0,0(s4)
ffffffffc0204ace:	008a0713          	addi	a4,s4,8
ffffffffc0204ad2:	e03a                	sd	a4,0(sp)
ffffffffc0204ad4:	14040263          	beqz	s0,ffffffffc0204c18 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0204ad8:	0fb05763          	blez	s11,ffffffffc0204bc6 <vprintfmt+0x2d8>
ffffffffc0204adc:	02d00693          	li	a3,45
ffffffffc0204ae0:	0cd79163          	bne	a5,a3,ffffffffc0204ba2 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204ae4:	00044783          	lbu	a5,0(s0)
ffffffffc0204ae8:	0007851b          	sext.w	a0,a5
ffffffffc0204aec:	cf85                	beqz	a5,ffffffffc0204b24 <vprintfmt+0x236>
ffffffffc0204aee:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204af2:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204af6:	000c4563          	bltz	s8,ffffffffc0204b00 <vprintfmt+0x212>
ffffffffc0204afa:	3c7d                	addiw	s8,s8,-1
ffffffffc0204afc:	036c0263          	beq	s8,s6,ffffffffc0204b20 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0204b00:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204b02:	0e0c8e63          	beqz	s9,ffffffffc0204bfe <vprintfmt+0x310>
ffffffffc0204b06:	3781                	addiw	a5,a5,-32
ffffffffc0204b08:	0ef47b63          	bgeu	s0,a5,ffffffffc0204bfe <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0204b0c:	03f00513          	li	a0,63
ffffffffc0204b10:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204b12:	000a4783          	lbu	a5,0(s4)
ffffffffc0204b16:	3dfd                	addiw	s11,s11,-1
ffffffffc0204b18:	0a05                	addi	s4,s4,1
ffffffffc0204b1a:	0007851b          	sext.w	a0,a5
ffffffffc0204b1e:	ffe1                	bnez	a5,ffffffffc0204af6 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0204b20:	01b05963          	blez	s11,ffffffffc0204b32 <vprintfmt+0x244>
ffffffffc0204b24:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0204b26:	85a6                	mv	a1,s1
ffffffffc0204b28:	02000513          	li	a0,32
ffffffffc0204b2c:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0204b2e:	fe0d9be3          	bnez	s11,ffffffffc0204b24 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0204b32:	6a02                	ld	s4,0(sp)
ffffffffc0204b34:	bbd5                	j	ffffffffc0204928 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0204b36:	4705                	li	a4,1
ffffffffc0204b38:	008a0c93          	addi	s9,s4,8
ffffffffc0204b3c:	01174463          	blt	a4,a7,ffffffffc0204b44 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0204b40:	08088d63          	beqz	a7,ffffffffc0204bda <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0204b44:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0204b48:	0a044d63          	bltz	s0,ffffffffc0204c02 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0204b4c:	8622                	mv	a2,s0
ffffffffc0204b4e:	8a66                	mv	s4,s9
ffffffffc0204b50:	46a9                	li	a3,10
ffffffffc0204b52:	bdcd                	j	ffffffffc0204a44 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0204b54:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0204b58:	4761                	li	a4,24
            err = va_arg(ap, int);
ffffffffc0204b5a:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0204b5c:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0204b60:	8fb5                	xor	a5,a5,a3
ffffffffc0204b62:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0204b66:	02d74163          	blt	a4,a3,ffffffffc0204b88 <vprintfmt+0x29a>
ffffffffc0204b6a:	00369793          	slli	a5,a3,0x3
ffffffffc0204b6e:	97de                	add	a5,a5,s7
ffffffffc0204b70:	639c                	ld	a5,0(a5)
ffffffffc0204b72:	cb99                	beqz	a5,ffffffffc0204b88 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0204b74:	86be                	mv	a3,a5
ffffffffc0204b76:	00000617          	auipc	a2,0x0
ffffffffc0204b7a:	13260613          	addi	a2,a2,306 # ffffffffc0204ca8 <etext+0x22>
ffffffffc0204b7e:	85a6                	mv	a1,s1
ffffffffc0204b80:	854a                	mv	a0,s2
ffffffffc0204b82:	0ce000ef          	jal	ra,ffffffffc0204c50 <printfmt>
ffffffffc0204b86:	b34d                	j	ffffffffc0204928 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0204b88:	00002617          	auipc	a2,0x2
ffffffffc0204b8c:	31860613          	addi	a2,a2,792 # ffffffffc0206ea0 <syscalls+0x818>
ffffffffc0204b90:	85a6                	mv	a1,s1
ffffffffc0204b92:	854a                	mv	a0,s2
ffffffffc0204b94:	0bc000ef          	jal	ra,ffffffffc0204c50 <printfmt>
ffffffffc0204b98:	bb41                	j	ffffffffc0204928 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0204b9a:	00002417          	auipc	s0,0x2
ffffffffc0204b9e:	2fe40413          	addi	s0,s0,766 # ffffffffc0206e98 <syscalls+0x810>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0204ba2:	85e2                	mv	a1,s8
ffffffffc0204ba4:	8522                	mv	a0,s0
ffffffffc0204ba6:	e43e                	sd	a5,8(sp)
ffffffffc0204ba8:	c61ff0ef          	jal	ra,ffffffffc0204808 <strnlen>
ffffffffc0204bac:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0204bb0:	01b05b63          	blez	s11,ffffffffc0204bc6 <vprintfmt+0x2d8>
ffffffffc0204bb4:	67a2                	ld	a5,8(sp)
ffffffffc0204bb6:	00078a1b          	sext.w	s4,a5
ffffffffc0204bba:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0204bbc:	85a6                	mv	a1,s1
ffffffffc0204bbe:	8552                	mv	a0,s4
ffffffffc0204bc0:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0204bc2:	fe0d9ce3          	bnez	s11,ffffffffc0204bba <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204bc6:	00044783          	lbu	a5,0(s0)
ffffffffc0204bca:	00140a13          	addi	s4,s0,1
ffffffffc0204bce:	0007851b          	sext.w	a0,a5
ffffffffc0204bd2:	d3a5                	beqz	a5,ffffffffc0204b32 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204bd4:	05e00413          	li	s0,94
ffffffffc0204bd8:	bf39                	j	ffffffffc0204af6 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0204bda:	000a2403          	lw	s0,0(s4)
ffffffffc0204bde:	b7ad                	j	ffffffffc0204b48 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0204be0:	000a6603          	lwu	a2,0(s4)
ffffffffc0204be4:	46a1                	li	a3,8
ffffffffc0204be6:	8a2e                	mv	s4,a1
ffffffffc0204be8:	bdb1                	j	ffffffffc0204a44 <vprintfmt+0x156>
ffffffffc0204bea:	000a6603          	lwu	a2,0(s4)
ffffffffc0204bee:	46a9                	li	a3,10
ffffffffc0204bf0:	8a2e                	mv	s4,a1
ffffffffc0204bf2:	bd89                	j	ffffffffc0204a44 <vprintfmt+0x156>
ffffffffc0204bf4:	000a6603          	lwu	a2,0(s4)
ffffffffc0204bf8:	46c1                	li	a3,16
ffffffffc0204bfa:	8a2e                	mv	s4,a1
ffffffffc0204bfc:	b5a1                	j	ffffffffc0204a44 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0204bfe:	9902                	jalr	s2
ffffffffc0204c00:	bf09                	j	ffffffffc0204b12 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0204c02:	85a6                	mv	a1,s1
ffffffffc0204c04:	02d00513          	li	a0,45
ffffffffc0204c08:	e03e                	sd	a5,0(sp)
ffffffffc0204c0a:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0204c0c:	6782                	ld	a5,0(sp)
ffffffffc0204c0e:	8a66                	mv	s4,s9
ffffffffc0204c10:	40800633          	neg	a2,s0
ffffffffc0204c14:	46a9                	li	a3,10
ffffffffc0204c16:	b53d                	j	ffffffffc0204a44 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0204c18:	03b05163          	blez	s11,ffffffffc0204c3a <vprintfmt+0x34c>
ffffffffc0204c1c:	02d00693          	li	a3,45
ffffffffc0204c20:	f6d79de3          	bne	a5,a3,ffffffffc0204b9a <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0204c24:	00002417          	auipc	s0,0x2
ffffffffc0204c28:	27440413          	addi	s0,s0,628 # ffffffffc0206e98 <syscalls+0x810>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204c2c:	02800793          	li	a5,40
ffffffffc0204c30:	02800513          	li	a0,40
ffffffffc0204c34:	00140a13          	addi	s4,s0,1
ffffffffc0204c38:	bd6d                	j	ffffffffc0204af2 <vprintfmt+0x204>
ffffffffc0204c3a:	00002a17          	auipc	s4,0x2
ffffffffc0204c3e:	25fa0a13          	addi	s4,s4,607 # ffffffffc0206e99 <syscalls+0x811>
ffffffffc0204c42:	02800513          	li	a0,40
ffffffffc0204c46:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204c4a:	05e00413          	li	s0,94
ffffffffc0204c4e:	b565                	j	ffffffffc0204af6 <vprintfmt+0x208>

ffffffffc0204c50 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c50:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0204c52:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c56:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0204c58:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c5a:	ec06                	sd	ra,24(sp)
ffffffffc0204c5c:	f83a                	sd	a4,48(sp)
ffffffffc0204c5e:	fc3e                	sd	a5,56(sp)
ffffffffc0204c60:	e0c2                	sd	a6,64(sp)
ffffffffc0204c62:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0204c64:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0204c66:	c89ff0ef          	jal	ra,ffffffffc02048ee <vprintfmt>
}
ffffffffc0204c6a:	60e2                	ld	ra,24(sp)
ffffffffc0204c6c:	6161                	addi	sp,sp,80
ffffffffc0204c6e:	8082                	ret

ffffffffc0204c70 <hash32>:
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
ffffffffc0204c70:	9e3707b7          	lui	a5,0x9e370
ffffffffc0204c74:	2785                	addiw	a5,a5,1
ffffffffc0204c76:	02a7853b          	mulw	a0,a5,a0
    return (hash >> (32 - bits));
ffffffffc0204c7a:	02000793          	li	a5,32
ffffffffc0204c7e:	9f8d                	subw	a5,a5,a1
}
ffffffffc0204c80:	00f5553b          	srlw	a0,a0,a5
ffffffffc0204c84:	8082                	ret

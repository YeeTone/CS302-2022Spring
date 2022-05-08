
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
ffffffffc0200036:	24e50513          	addi	a0,a0,590 # ffffffffc0248280 <buf>
ffffffffc020003a:	00054617          	auipc	a2,0x54
ffffffffc020003e:	80e60613          	addi	a2,a2,-2034 # ffffffffc0253848 <end>
kern_init(void) {
ffffffffc0200042:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc0200044:	8e09                	sub	a2,a2,a0
ffffffffc0200046:	4581                	li	a1,0
kern_init(void) {
ffffffffc0200048:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc020004a:	037040ef          	jal	ra,ffffffffc0204880 <memset>
    cons_init();                // init the console
ffffffffc020004e:	56c000ef          	jal	ra,ffffffffc02005ba <cons_init>

    const char *message = "OS is loading ...";
    cprintf("%s\n\n", message);
ffffffffc0200052:	00005597          	auipc	a1,0x5
ffffffffc0200056:	c5e58593          	addi	a1,a1,-930 # ffffffffc0204cb0 <etext+0x2>
ffffffffc020005a:	00005517          	auipc	a0,0x5
ffffffffc020005e:	c6e50513          	addi	a0,a0,-914 # ffffffffc0204cc8 <etext+0x1a>
ffffffffc0200062:	066000ef          	jal	ra,ffffffffc02000c8 <cprintf>

    pmm_init();                 // init physical memory management
ffffffffc0200066:	78c020ef          	jal	ra,ffffffffc02027f2 <pmm_init>

    idt_init();                 // init interrupt descriptor table
ffffffffc020006a:	5ce000ef          	jal	ra,ffffffffc0200638 <idt_init>

    vmm_init();                 // init virtual memory management
ffffffffc020006e:	056010ef          	jal	ra,ffffffffc02010c4 <vmm_init>
    sched_init();
ffffffffc0200072:	404040ef          	jal	ra,ffffffffc0204476 <sched_init>
    proc_init();                // init process table
ffffffffc0200076:	286040ef          	jal	ra,ffffffffc02042fc <proc_init>
    
    ide_init();                 // init ide devices
ffffffffc020007a:	4a2000ef          	jal	ra,ffffffffc020051c <ide_init>
    swap_init();                // init swap
ffffffffc020007e:	175010ef          	jal	ra,ffffffffc02019f2 <swap_init>

    clock_init();               // init clock interrupt
ffffffffc0200082:	4f0000ef          	jal	ra,ffffffffc0200572 <clock_init>
    intr_enable();              // enable irq interrupt
ffffffffc0200086:	5a6000ef          	jal	ra,ffffffffc020062c <intr_enable>
    
    cpu_idle();                 // run idle process
ffffffffc020008a:	3a8040ef          	jal	ra,ffffffffc0204432 <cpu_idle>

ffffffffc020008e <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc020008e:	1141                	addi	sp,sp,-16
ffffffffc0200090:	e022                	sd	s0,0(sp)
ffffffffc0200092:	e406                	sd	ra,8(sp)
ffffffffc0200094:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200096:	526000ef          	jal	ra,ffffffffc02005bc <cons_putc>
    (*cnt) ++;
ffffffffc020009a:	401c                	lw	a5,0(s0)
}
ffffffffc020009c:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc020009e:	2785                	addiw	a5,a5,1
ffffffffc02000a0:	c01c                	sw	a5,0(s0)
}
ffffffffc02000a2:	6402                	ld	s0,0(sp)
ffffffffc02000a4:	0141                	addi	sp,sp,16
ffffffffc02000a6:	8082                	ret

ffffffffc02000a8 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000a8:	1101                	addi	sp,sp,-32
ffffffffc02000aa:	862a                	mv	a2,a0
ffffffffc02000ac:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000ae:	00000517          	auipc	a0,0x0
ffffffffc02000b2:	fe050513          	addi	a0,a0,-32 # ffffffffc020008e <cputch>
ffffffffc02000b6:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000b8:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc02000ba:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000bc:	05b040ef          	jal	ra,ffffffffc0204916 <vprintfmt>
    return cnt;
}
ffffffffc02000c0:	60e2                	ld	ra,24(sp)
ffffffffc02000c2:	4532                	lw	a0,12(sp)
ffffffffc02000c4:	6105                	addi	sp,sp,32
ffffffffc02000c6:	8082                	ret

ffffffffc02000c8 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc02000c8:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc02000ca:	02810313          	addi	t1,sp,40 # ffffffffc020a028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc02000ce:	8e2a                	mv	t3,a0
ffffffffc02000d0:	f42e                	sd	a1,40(sp)
ffffffffc02000d2:	f832                	sd	a2,48(sp)
ffffffffc02000d4:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000d6:	00000517          	auipc	a0,0x0
ffffffffc02000da:	fb850513          	addi	a0,a0,-72 # ffffffffc020008e <cputch>
ffffffffc02000de:	004c                	addi	a1,sp,4
ffffffffc02000e0:	869a                	mv	a3,t1
ffffffffc02000e2:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
ffffffffc02000e4:	ec06                	sd	ra,24(sp)
ffffffffc02000e6:	e0ba                	sd	a4,64(sp)
ffffffffc02000e8:	e4be                	sd	a5,72(sp)
ffffffffc02000ea:	e8c2                	sd	a6,80(sp)
ffffffffc02000ec:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02000ee:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02000f0:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000f2:	025040ef          	jal	ra,ffffffffc0204916 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02000f6:	60e2                	ld	ra,24(sp)
ffffffffc02000f8:	4512                	lw	a0,4(sp)
ffffffffc02000fa:	6125                	addi	sp,sp,96
ffffffffc02000fc:	8082                	ret

ffffffffc02000fe <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
    cons_putc(c);
ffffffffc02000fe:	a97d                	j	ffffffffc02005bc <cons_putc>

ffffffffc0200100 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc0200100:	1101                	addi	sp,sp,-32
ffffffffc0200102:	e822                	sd	s0,16(sp)
ffffffffc0200104:	ec06                	sd	ra,24(sp)
ffffffffc0200106:	e426                	sd	s1,8(sp)
ffffffffc0200108:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc020010a:	00054503          	lbu	a0,0(a0)
ffffffffc020010e:	c51d                	beqz	a0,ffffffffc020013c <cputs+0x3c>
ffffffffc0200110:	0405                	addi	s0,s0,1
ffffffffc0200112:	4485                	li	s1,1
ffffffffc0200114:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc0200116:	4a6000ef          	jal	ra,ffffffffc02005bc <cons_putc>
    while ((c = *str ++) != '\0') {
ffffffffc020011a:	00044503          	lbu	a0,0(s0)
ffffffffc020011e:	008487bb          	addw	a5,s1,s0
ffffffffc0200122:	0405                	addi	s0,s0,1
ffffffffc0200124:	f96d                	bnez	a0,ffffffffc0200116 <cputs+0x16>
ffffffffc0200126:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc020012a:	4529                	li	a0,10
ffffffffc020012c:	490000ef          	jal	ra,ffffffffc02005bc <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc0200130:	60e2                	ld	ra,24(sp)
ffffffffc0200132:	8522                	mv	a0,s0
ffffffffc0200134:	6442                	ld	s0,16(sp)
ffffffffc0200136:	64a2                	ld	s1,8(sp)
ffffffffc0200138:	6105                	addi	sp,sp,32
ffffffffc020013a:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc020013c:	4405                	li	s0,1
ffffffffc020013e:	b7f5                	j	ffffffffc020012a <cputs+0x2a>

ffffffffc0200140 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
ffffffffc0200140:	1141                	addi	sp,sp,-16
ffffffffc0200142:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200144:	4ac000ef          	jal	ra,ffffffffc02005f0 <cons_getc>
ffffffffc0200148:	dd75                	beqz	a0,ffffffffc0200144 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc020014a:	60a2                	ld	ra,8(sp)
ffffffffc020014c:	0141                	addi	sp,sp,16
ffffffffc020014e:	8082                	ret

ffffffffc0200150 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc0200150:	715d                	addi	sp,sp,-80
ffffffffc0200152:	e486                	sd	ra,72(sp)
ffffffffc0200154:	e0a6                	sd	s1,64(sp)
ffffffffc0200156:	fc4a                	sd	s2,56(sp)
ffffffffc0200158:	f84e                	sd	s3,48(sp)
ffffffffc020015a:	f452                	sd	s4,40(sp)
ffffffffc020015c:	f056                	sd	s5,32(sp)
ffffffffc020015e:	ec5a                	sd	s6,24(sp)
ffffffffc0200160:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc0200162:	c901                	beqz	a0,ffffffffc0200172 <readline+0x22>
ffffffffc0200164:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc0200166:	00005517          	auipc	a0,0x5
ffffffffc020016a:	b6a50513          	addi	a0,a0,-1174 # ffffffffc0204cd0 <etext+0x22>
ffffffffc020016e:	f5bff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
readline(const char *prompt) {
ffffffffc0200172:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200174:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc0200176:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc0200178:	4aa9                	li	s5,10
ffffffffc020017a:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc020017c:	00048b97          	auipc	s7,0x48
ffffffffc0200180:	104b8b93          	addi	s7,s7,260 # ffffffffc0248280 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200184:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc0200188:	fb9ff0ef          	jal	ra,ffffffffc0200140 <getchar>
        if (c < 0) {
ffffffffc020018c:	00054a63          	bltz	a0,ffffffffc02001a0 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200190:	00a95a63          	bge	s2,a0,ffffffffc02001a4 <readline+0x54>
ffffffffc0200194:	029a5263          	bge	s4,s1,ffffffffc02001b8 <readline+0x68>
        c = getchar();
ffffffffc0200198:	fa9ff0ef          	jal	ra,ffffffffc0200140 <getchar>
        if (c < 0) {
ffffffffc020019c:	fe055ae3          	bgez	a0,ffffffffc0200190 <readline+0x40>
            return NULL;
ffffffffc02001a0:	4501                	li	a0,0
ffffffffc02001a2:	a091                	j	ffffffffc02001e6 <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc02001a4:	03351463          	bne	a0,s3,ffffffffc02001cc <readline+0x7c>
ffffffffc02001a8:	e8a9                	bnez	s1,ffffffffc02001fa <readline+0xaa>
        c = getchar();
ffffffffc02001aa:	f97ff0ef          	jal	ra,ffffffffc0200140 <getchar>
        if (c < 0) {
ffffffffc02001ae:	fe0549e3          	bltz	a0,ffffffffc02001a0 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02001b2:	fea959e3          	bge	s2,a0,ffffffffc02001a4 <readline+0x54>
ffffffffc02001b6:	4481                	li	s1,0
            cputchar(c);
ffffffffc02001b8:	e42a                	sd	a0,8(sp)
ffffffffc02001ba:	f45ff0ef          	jal	ra,ffffffffc02000fe <cputchar>
            buf[i ++] = c;
ffffffffc02001be:	6522                	ld	a0,8(sp)
ffffffffc02001c0:	009b87b3          	add	a5,s7,s1
ffffffffc02001c4:	2485                	addiw	s1,s1,1
ffffffffc02001c6:	00a78023          	sb	a0,0(a5)
ffffffffc02001ca:	bf7d                	j	ffffffffc0200188 <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc02001cc:	01550463          	beq	a0,s5,ffffffffc02001d4 <readline+0x84>
ffffffffc02001d0:	fb651ce3          	bne	a0,s6,ffffffffc0200188 <readline+0x38>
            cputchar(c);
ffffffffc02001d4:	f2bff0ef          	jal	ra,ffffffffc02000fe <cputchar>
            buf[i] = '\0';
ffffffffc02001d8:	00048517          	auipc	a0,0x48
ffffffffc02001dc:	0a850513          	addi	a0,a0,168 # ffffffffc0248280 <buf>
ffffffffc02001e0:	94aa                	add	s1,s1,a0
ffffffffc02001e2:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc02001e6:	60a6                	ld	ra,72(sp)
ffffffffc02001e8:	6486                	ld	s1,64(sp)
ffffffffc02001ea:	7962                	ld	s2,56(sp)
ffffffffc02001ec:	79c2                	ld	s3,48(sp)
ffffffffc02001ee:	7a22                	ld	s4,40(sp)
ffffffffc02001f0:	7a82                	ld	s5,32(sp)
ffffffffc02001f2:	6b62                	ld	s6,24(sp)
ffffffffc02001f4:	6bc2                	ld	s7,16(sp)
ffffffffc02001f6:	6161                	addi	sp,sp,80
ffffffffc02001f8:	8082                	ret
            cputchar(c);
ffffffffc02001fa:	4521                	li	a0,8
ffffffffc02001fc:	f03ff0ef          	jal	ra,ffffffffc02000fe <cputchar>
            i --;
ffffffffc0200200:	34fd                	addiw	s1,s1,-1
ffffffffc0200202:	b759                	j	ffffffffc0200188 <readline+0x38>

ffffffffc0200204 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc0200204:	00053317          	auipc	t1,0x53
ffffffffc0200208:	4ac30313          	addi	t1,t1,1196 # ffffffffc02536b0 <is_panic>
ffffffffc020020c:	00033e03          	ld	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc0200210:	715d                	addi	sp,sp,-80
ffffffffc0200212:	ec06                	sd	ra,24(sp)
ffffffffc0200214:	e822                	sd	s0,16(sp)
ffffffffc0200216:	f436                	sd	a3,40(sp)
ffffffffc0200218:	f83a                	sd	a4,48(sp)
ffffffffc020021a:	fc3e                	sd	a5,56(sp)
ffffffffc020021c:	e0c2                	sd	a6,64(sp)
ffffffffc020021e:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc0200220:	020e1a63          	bnez	t3,ffffffffc0200254 <__panic+0x50>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc0200224:	4785                	li	a5,1
ffffffffc0200226:	00f33023          	sd	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc020022a:	8432                	mv	s0,a2
ffffffffc020022c:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc020022e:	862e                	mv	a2,a1
ffffffffc0200230:	85aa                	mv	a1,a0
ffffffffc0200232:	00005517          	auipc	a0,0x5
ffffffffc0200236:	aa650513          	addi	a0,a0,-1370 # ffffffffc0204cd8 <etext+0x2a>
    va_start(ap, fmt);
ffffffffc020023a:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc020023c:	e8dff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200240:	65a2                	ld	a1,8(sp)
ffffffffc0200242:	8522                	mv	a0,s0
ffffffffc0200244:	e65ff0ef          	jal	ra,ffffffffc02000a8 <vcprintf>
    cprintf("\n");
ffffffffc0200248:	00006517          	auipc	a0,0x6
ffffffffc020024c:	f3850513          	addi	a0,a0,-200 # ffffffffc0206180 <default_pmm_manager+0x208>
ffffffffc0200250:	e79ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
#endif
}

static inline void sbi_shutdown(void)
{
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc0200254:	4501                	li	a0,0
ffffffffc0200256:	4581                	li	a1,0
ffffffffc0200258:	4601                	li	a2,0
ffffffffc020025a:	48a1                	li	a7,8
ffffffffc020025c:	00000073          	ecall
    va_end(ap);

panic_dead:
    // No debug monitor here
    sbi_shutdown();
    intr_disable();
ffffffffc0200260:	3d2000ef          	jal	ra,ffffffffc0200632 <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc0200264:	4501                	li	a0,0
ffffffffc0200266:	174000ef          	jal	ra,ffffffffc02003da <kmonitor>
    while (1) {
ffffffffc020026a:	bfed                	j	ffffffffc0200264 <__panic+0x60>

ffffffffc020026c <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc020026c:	715d                	addi	sp,sp,-80
ffffffffc020026e:	832e                	mv	t1,a1
ffffffffc0200270:	e822                	sd	s0,16(sp)
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200272:	85aa                	mv	a1,a0
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200274:	8432                	mv	s0,a2
ffffffffc0200276:	fc3e                	sd	a5,56(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200278:	861a                	mv	a2,t1
    va_start(ap, fmt);
ffffffffc020027a:	103c                	addi	a5,sp,40
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020027c:	00005517          	auipc	a0,0x5
ffffffffc0200280:	a7c50513          	addi	a0,a0,-1412 # ffffffffc0204cf8 <etext+0x4a>
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200284:	ec06                	sd	ra,24(sp)
ffffffffc0200286:	f436                	sd	a3,40(sp)
ffffffffc0200288:	f83a                	sd	a4,48(sp)
ffffffffc020028a:	e0c2                	sd	a6,64(sp)
ffffffffc020028c:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc020028e:	e43e                	sd	a5,8(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200290:	e39ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200294:	65a2                	ld	a1,8(sp)
ffffffffc0200296:	8522                	mv	a0,s0
ffffffffc0200298:	e11ff0ef          	jal	ra,ffffffffc02000a8 <vcprintf>
    cprintf("\n");
ffffffffc020029c:	00006517          	auipc	a0,0x6
ffffffffc02002a0:	ee450513          	addi	a0,a0,-284 # ffffffffc0206180 <default_pmm_manager+0x208>
ffffffffc02002a4:	e25ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    va_end(ap);
}
ffffffffc02002a8:	60e2                	ld	ra,24(sp)
ffffffffc02002aa:	6442                	ld	s0,16(sp)
ffffffffc02002ac:	6161                	addi	sp,sp,80
ffffffffc02002ae:	8082                	ret

ffffffffc02002b0 <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc02002b0:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc02002b2:	00005517          	auipc	a0,0x5
ffffffffc02002b6:	a6650513          	addi	a0,a0,-1434 # ffffffffc0204d18 <etext+0x6a>
void print_kerninfo(void) {
ffffffffc02002ba:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc02002bc:	e0dff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  entry  0x%08x (virtual)\n", kern_init);
ffffffffc02002c0:	00000597          	auipc	a1,0x0
ffffffffc02002c4:	d7258593          	addi	a1,a1,-654 # ffffffffc0200032 <kern_init>
ffffffffc02002c8:	00005517          	auipc	a0,0x5
ffffffffc02002cc:	a7050513          	addi	a0,a0,-1424 # ffffffffc0204d38 <etext+0x8a>
ffffffffc02002d0:	df9ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  etext  0x%08x (virtual)\n", etext);
ffffffffc02002d4:	00005597          	auipc	a1,0x5
ffffffffc02002d8:	9da58593          	addi	a1,a1,-1574 # ffffffffc0204cae <etext>
ffffffffc02002dc:	00005517          	auipc	a0,0x5
ffffffffc02002e0:	a7c50513          	addi	a0,a0,-1412 # ffffffffc0204d58 <etext+0xaa>
ffffffffc02002e4:	de5ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  edata  0x%08x (virtual)\n", edata);
ffffffffc02002e8:	00048597          	auipc	a1,0x48
ffffffffc02002ec:	f9858593          	addi	a1,a1,-104 # ffffffffc0248280 <buf>
ffffffffc02002f0:	00005517          	auipc	a0,0x5
ffffffffc02002f4:	a8850513          	addi	a0,a0,-1400 # ffffffffc0204d78 <etext+0xca>
ffffffffc02002f8:	dd1ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  end    0x%08x (virtual)\n", end);
ffffffffc02002fc:	00053597          	auipc	a1,0x53
ffffffffc0200300:	54c58593          	addi	a1,a1,1356 # ffffffffc0253848 <end>
ffffffffc0200304:	00005517          	auipc	a0,0x5
ffffffffc0200308:	a9450513          	addi	a0,a0,-1388 # ffffffffc0204d98 <etext+0xea>
ffffffffc020030c:	dbdff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc0200310:	00054597          	auipc	a1,0x54
ffffffffc0200314:	93758593          	addi	a1,a1,-1737 # ffffffffc0253c47 <end+0x3ff>
ffffffffc0200318:	00000797          	auipc	a5,0x0
ffffffffc020031c:	d1a78793          	addi	a5,a5,-742 # ffffffffc0200032 <kern_init>
ffffffffc0200320:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200324:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200328:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc020032a:	3ff5f593          	andi	a1,a1,1023
ffffffffc020032e:	95be                	add	a1,a1,a5
ffffffffc0200330:	85a9                	srai	a1,a1,0xa
ffffffffc0200332:	00005517          	auipc	a0,0x5
ffffffffc0200336:	a8650513          	addi	a0,a0,-1402 # ffffffffc0204db8 <etext+0x10a>
}
ffffffffc020033a:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc020033c:	b371                	j	ffffffffc02000c8 <cprintf>

ffffffffc020033e <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc020033e:	1141                	addi	sp,sp,-16
     * and line number, etc.
     *    (3.5) popup a calling stackframe
     *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
     *                   the calling funciton's ebp = ss:[ebp]
     */
    panic("Not Implemented!");
ffffffffc0200340:	00005617          	auipc	a2,0x5
ffffffffc0200344:	aa860613          	addi	a2,a2,-1368 # ffffffffc0204de8 <etext+0x13a>
ffffffffc0200348:	05b00593          	li	a1,91
ffffffffc020034c:	00005517          	auipc	a0,0x5
ffffffffc0200350:	ab450513          	addi	a0,a0,-1356 # ffffffffc0204e00 <etext+0x152>
void print_stackframe(void) {
ffffffffc0200354:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc0200356:	eafff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020035a <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc020035a:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc020035c:	00005617          	auipc	a2,0x5
ffffffffc0200360:	abc60613          	addi	a2,a2,-1348 # ffffffffc0204e18 <etext+0x16a>
ffffffffc0200364:	00005597          	auipc	a1,0x5
ffffffffc0200368:	ad458593          	addi	a1,a1,-1324 # ffffffffc0204e38 <etext+0x18a>
ffffffffc020036c:	00005517          	auipc	a0,0x5
ffffffffc0200370:	ad450513          	addi	a0,a0,-1324 # ffffffffc0204e40 <etext+0x192>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200374:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200376:	d53ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc020037a:	00005617          	auipc	a2,0x5
ffffffffc020037e:	ad660613          	addi	a2,a2,-1322 # ffffffffc0204e50 <etext+0x1a2>
ffffffffc0200382:	00005597          	auipc	a1,0x5
ffffffffc0200386:	af658593          	addi	a1,a1,-1290 # ffffffffc0204e78 <etext+0x1ca>
ffffffffc020038a:	00005517          	auipc	a0,0x5
ffffffffc020038e:	ab650513          	addi	a0,a0,-1354 # ffffffffc0204e40 <etext+0x192>
ffffffffc0200392:	d37ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc0200396:	00005617          	auipc	a2,0x5
ffffffffc020039a:	af260613          	addi	a2,a2,-1294 # ffffffffc0204e88 <etext+0x1da>
ffffffffc020039e:	00005597          	auipc	a1,0x5
ffffffffc02003a2:	b0a58593          	addi	a1,a1,-1270 # ffffffffc0204ea8 <etext+0x1fa>
ffffffffc02003a6:	00005517          	auipc	a0,0x5
ffffffffc02003aa:	a9a50513          	addi	a0,a0,-1382 # ffffffffc0204e40 <etext+0x192>
ffffffffc02003ae:	d1bff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    }
    return 0;
}
ffffffffc02003b2:	60a2                	ld	ra,8(sp)
ffffffffc02003b4:	4501                	li	a0,0
ffffffffc02003b6:	0141                	addi	sp,sp,16
ffffffffc02003b8:	8082                	ret

ffffffffc02003ba <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc02003ba:	1141                	addi	sp,sp,-16
ffffffffc02003bc:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc02003be:	ef3ff0ef          	jal	ra,ffffffffc02002b0 <print_kerninfo>
    return 0;
}
ffffffffc02003c2:	60a2                	ld	ra,8(sp)
ffffffffc02003c4:	4501                	li	a0,0
ffffffffc02003c6:	0141                	addi	sp,sp,16
ffffffffc02003c8:	8082                	ret

ffffffffc02003ca <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc02003ca:	1141                	addi	sp,sp,-16
ffffffffc02003cc:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc02003ce:	f71ff0ef          	jal	ra,ffffffffc020033e <print_stackframe>
    return 0;
}
ffffffffc02003d2:	60a2                	ld	ra,8(sp)
ffffffffc02003d4:	4501                	li	a0,0
ffffffffc02003d6:	0141                	addi	sp,sp,16
ffffffffc02003d8:	8082                	ret

ffffffffc02003da <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc02003da:	7115                	addi	sp,sp,-224
ffffffffc02003dc:	e962                	sd	s8,144(sp)
ffffffffc02003de:	8c2a                	mv	s8,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02003e0:	00005517          	auipc	a0,0x5
ffffffffc02003e4:	ad850513          	addi	a0,a0,-1320 # ffffffffc0204eb8 <etext+0x20a>
kmonitor(struct trapframe *tf) {
ffffffffc02003e8:	ed86                	sd	ra,216(sp)
ffffffffc02003ea:	e9a2                	sd	s0,208(sp)
ffffffffc02003ec:	e5a6                	sd	s1,200(sp)
ffffffffc02003ee:	e1ca                	sd	s2,192(sp)
ffffffffc02003f0:	fd4e                	sd	s3,184(sp)
ffffffffc02003f2:	f952                	sd	s4,176(sp)
ffffffffc02003f4:	f556                	sd	s5,168(sp)
ffffffffc02003f6:	f15a                	sd	s6,160(sp)
ffffffffc02003f8:	ed5e                	sd	s7,152(sp)
ffffffffc02003fa:	e566                	sd	s9,136(sp)
ffffffffc02003fc:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02003fe:	ccbff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc0200402:	00005517          	auipc	a0,0x5
ffffffffc0200406:	ade50513          	addi	a0,a0,-1314 # ffffffffc0204ee0 <etext+0x232>
ffffffffc020040a:	cbfff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    if (tf != NULL) {
ffffffffc020040e:	000c0563          	beqz	s8,ffffffffc0200418 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc0200412:	8562                	mv	a0,s8
ffffffffc0200414:	40c000ef          	jal	ra,ffffffffc0200820 <print_trapframe>
ffffffffc0200418:	00005c97          	auipc	s9,0x5
ffffffffc020041c:	b38c8c93          	addi	s9,s9,-1224 # ffffffffc0204f50 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc0200420:	00005997          	auipc	s3,0x5
ffffffffc0200424:	ae898993          	addi	s3,s3,-1304 # ffffffffc0204f08 <etext+0x25a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200428:	00005917          	auipc	s2,0x5
ffffffffc020042c:	ae890913          	addi	s2,s2,-1304 # ffffffffc0204f10 <etext+0x262>
        if (argc == MAXARGS - 1) {
ffffffffc0200430:	4a3d                	li	s4,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200432:	00005b17          	auipc	s6,0x5
ffffffffc0200436:	ae6b0b13          	addi	s6,s6,-1306 # ffffffffc0204f18 <etext+0x26a>
ffffffffc020043a:	00005a97          	auipc	s5,0x5
ffffffffc020043e:	9fea8a93          	addi	s5,s5,-1538 # ffffffffc0204e38 <etext+0x18a>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200442:	4b8d                	li	s7,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc0200444:	854e                	mv	a0,s3
ffffffffc0200446:	d0bff0ef          	jal	ra,ffffffffc0200150 <readline>
ffffffffc020044a:	842a                	mv	s0,a0
ffffffffc020044c:	dd65                	beqz	a0,ffffffffc0200444 <kmonitor+0x6a>
ffffffffc020044e:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc0200452:	4481                	li	s1,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200454:	c999                	beqz	a1,ffffffffc020046a <kmonitor+0x90>
ffffffffc0200456:	854a                	mv	a0,s2
ffffffffc0200458:	412040ef          	jal	ra,ffffffffc020486a <strchr>
ffffffffc020045c:	c925                	beqz	a0,ffffffffc02004cc <kmonitor+0xf2>
            *buf ++ = '\0';
ffffffffc020045e:	00144583          	lbu	a1,1(s0)
ffffffffc0200462:	00040023          	sb	zero,0(s0)
ffffffffc0200466:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200468:	f5fd                	bnez	a1,ffffffffc0200456 <kmonitor+0x7c>
    if (argc == 0) {
ffffffffc020046a:	dce9                	beqz	s1,ffffffffc0200444 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020046c:	6582                	ld	a1,0(sp)
ffffffffc020046e:	00005d17          	auipc	s10,0x5
ffffffffc0200472:	ae2d0d13          	addi	s10,s10,-1310 # ffffffffc0204f50 <commands>
ffffffffc0200476:	8556                	mv	a0,s5
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200478:	4401                	li	s0,0
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020047a:	0d61                	addi	s10,s10,24
ffffffffc020047c:	3d0040ef          	jal	ra,ffffffffc020484c <strcmp>
ffffffffc0200480:	c919                	beqz	a0,ffffffffc0200496 <kmonitor+0xbc>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200482:	2405                	addiw	s0,s0,1
ffffffffc0200484:	09740463          	beq	s0,s7,ffffffffc020050c <kmonitor+0x132>
ffffffffc0200488:	000d3503          	ld	a0,0(s10)
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020048c:	6582                	ld	a1,0(sp)
ffffffffc020048e:	0d61                	addi	s10,s10,24
ffffffffc0200490:	3bc040ef          	jal	ra,ffffffffc020484c <strcmp>
ffffffffc0200494:	f57d                	bnez	a0,ffffffffc0200482 <kmonitor+0xa8>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc0200496:	00141793          	slli	a5,s0,0x1
ffffffffc020049a:	97a2                	add	a5,a5,s0
ffffffffc020049c:	078e                	slli	a5,a5,0x3
ffffffffc020049e:	97e6                	add	a5,a5,s9
ffffffffc02004a0:	6b9c                	ld	a5,16(a5)
ffffffffc02004a2:	8662                	mv	a2,s8
ffffffffc02004a4:	002c                	addi	a1,sp,8
ffffffffc02004a6:	fff4851b          	addiw	a0,s1,-1
ffffffffc02004aa:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc02004ac:	f8055ce3          	bgez	a0,ffffffffc0200444 <kmonitor+0x6a>
}
ffffffffc02004b0:	60ee                	ld	ra,216(sp)
ffffffffc02004b2:	644e                	ld	s0,208(sp)
ffffffffc02004b4:	64ae                	ld	s1,200(sp)
ffffffffc02004b6:	690e                	ld	s2,192(sp)
ffffffffc02004b8:	79ea                	ld	s3,184(sp)
ffffffffc02004ba:	7a4a                	ld	s4,176(sp)
ffffffffc02004bc:	7aaa                	ld	s5,168(sp)
ffffffffc02004be:	7b0a                	ld	s6,160(sp)
ffffffffc02004c0:	6bea                	ld	s7,152(sp)
ffffffffc02004c2:	6c4a                	ld	s8,144(sp)
ffffffffc02004c4:	6caa                	ld	s9,136(sp)
ffffffffc02004c6:	6d0a                	ld	s10,128(sp)
ffffffffc02004c8:	612d                	addi	sp,sp,224
ffffffffc02004ca:	8082                	ret
        if (*buf == '\0') {
ffffffffc02004cc:	00044783          	lbu	a5,0(s0)
ffffffffc02004d0:	dfc9                	beqz	a5,ffffffffc020046a <kmonitor+0x90>
        if (argc == MAXARGS - 1) {
ffffffffc02004d2:	03448863          	beq	s1,s4,ffffffffc0200502 <kmonitor+0x128>
        argv[argc ++] = buf;
ffffffffc02004d6:	00349793          	slli	a5,s1,0x3
ffffffffc02004da:	0118                	addi	a4,sp,128
ffffffffc02004dc:	97ba                	add	a5,a5,a4
ffffffffc02004de:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004e2:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc02004e6:	2485                	addiw	s1,s1,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004e8:	e591                	bnez	a1,ffffffffc02004f4 <kmonitor+0x11a>
ffffffffc02004ea:	b749                	j	ffffffffc020046c <kmonitor+0x92>
ffffffffc02004ec:	00144583          	lbu	a1,1(s0)
            buf ++;
ffffffffc02004f0:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004f2:	ddad                	beqz	a1,ffffffffc020046c <kmonitor+0x92>
ffffffffc02004f4:	854a                	mv	a0,s2
ffffffffc02004f6:	374040ef          	jal	ra,ffffffffc020486a <strchr>
ffffffffc02004fa:	d96d                	beqz	a0,ffffffffc02004ec <kmonitor+0x112>
ffffffffc02004fc:	00044583          	lbu	a1,0(s0)
ffffffffc0200500:	bf91                	j	ffffffffc0200454 <kmonitor+0x7a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200502:	45c1                	li	a1,16
ffffffffc0200504:	855a                	mv	a0,s6
ffffffffc0200506:	bc3ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc020050a:	b7f1                	j	ffffffffc02004d6 <kmonitor+0xfc>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc020050c:	6582                	ld	a1,0(sp)
ffffffffc020050e:	00005517          	auipc	a0,0x5
ffffffffc0200512:	a2a50513          	addi	a0,a0,-1494 # ffffffffc0204f38 <etext+0x28a>
ffffffffc0200516:	bb3ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    return 0;
ffffffffc020051a:	b72d                	j	ffffffffc0200444 <kmonitor+0x6a>

ffffffffc020051c <ide_init>:
#include <stdio.h>
#include <string.h>
#include <trap.h>
#include <riscv.h>

void ide_init(void) {}
ffffffffc020051c:	8082                	ret

ffffffffc020051e <ide_device_valid>:

#define MAX_IDE 2
#define MAX_DISK_NSECS 56
static char ide[MAX_DISK_NSECS * SECTSIZE];

bool ide_device_valid(unsigned short ideno) { return ideno < MAX_IDE; }
ffffffffc020051e:	00253513          	sltiu	a0,a0,2
ffffffffc0200522:	8082                	ret

ffffffffc0200524 <ide_device_size>:

size_t ide_device_size(unsigned short ideno) { return MAX_DISK_NSECS; }
ffffffffc0200524:	03800513          	li	a0,56
ffffffffc0200528:	8082                	ret

ffffffffc020052a <ide_read_secs>:

int ide_read_secs(unsigned short ideno, uint32_t secno, void *dst,
                  size_t nsecs) {
    int iobase = secno * SECTSIZE;
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc020052a:	00048797          	auipc	a5,0x48
ffffffffc020052e:	15678793          	addi	a5,a5,342 # ffffffffc0248680 <ide>
    int iobase = secno * SECTSIZE;
ffffffffc0200532:	0095959b          	slliw	a1,a1,0x9
                  size_t nsecs) {
ffffffffc0200536:	1141                	addi	sp,sp,-16
ffffffffc0200538:	8532                	mv	a0,a2
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc020053a:	95be                	add	a1,a1,a5
ffffffffc020053c:	00969613          	slli	a2,a3,0x9
                  size_t nsecs) {
ffffffffc0200540:	e406                	sd	ra,8(sp)
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc0200542:	350040ef          	jal	ra,ffffffffc0204892 <memcpy>
    return 0;
}
ffffffffc0200546:	60a2                	ld	ra,8(sp)
ffffffffc0200548:	4501                	li	a0,0
ffffffffc020054a:	0141                	addi	sp,sp,16
ffffffffc020054c:	8082                	ret

ffffffffc020054e <ide_write_secs>:

int ide_write_secs(unsigned short ideno, uint32_t secno, const void *src,
                   size_t nsecs) {
    int iobase = secno * SECTSIZE;
ffffffffc020054e:	0095979b          	slliw	a5,a1,0x9
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc0200552:	00048517          	auipc	a0,0x48
ffffffffc0200556:	12e50513          	addi	a0,a0,302 # ffffffffc0248680 <ide>
                   size_t nsecs) {
ffffffffc020055a:	1141                	addi	sp,sp,-16
ffffffffc020055c:	85b2                	mv	a1,a2
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc020055e:	953e                	add	a0,a0,a5
ffffffffc0200560:	00969613          	slli	a2,a3,0x9
                   size_t nsecs) {
ffffffffc0200564:	e406                	sd	ra,8(sp)
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc0200566:	32c040ef          	jal	ra,ffffffffc0204892 <memcpy>
    return 0;
}
ffffffffc020056a:	60a2                	ld	ra,8(sp)
ffffffffc020056c:	4501                	li	a0,0
ffffffffc020056e:	0141                	addi	sp,sp,16
ffffffffc0200570:	8082                	ret

ffffffffc0200572 <clock_init>:

static uint64_t timebase = 100000;


void clock_init(void) {
    set_csr(sie, MIP_STIP);
ffffffffc0200572:	02000793          	li	a5,32
ffffffffc0200576:	1047a7f3          	csrrs	a5,sie,a5
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc020057a:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020057e:	67e1                	lui	a5,0x18
ffffffffc0200580:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_ex2_out_size+0xd930>
ffffffffc0200584:	953e                	add	a0,a0,a5
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
ffffffffc0200586:	4581                	li	a1,0
ffffffffc0200588:	4601                	li	a2,0
ffffffffc020058a:	4881                	li	a7,0
ffffffffc020058c:	00000073          	ecall
    cprintf("setup timer interrupts\n");
ffffffffc0200590:	00005517          	auipc	a0,0x5
ffffffffc0200594:	a0850513          	addi	a0,a0,-1528 # ffffffffc0204f98 <commands+0x48>
    ticks = 0;
ffffffffc0200598:	00053797          	auipc	a5,0x53
ffffffffc020059c:	1807b023          	sd	zero,384(a5) # ffffffffc0253718 <ticks>
    cprintf("setup timer interrupts\n");
ffffffffc02005a0:	b625                	j	ffffffffc02000c8 <cprintf>

ffffffffc02005a2 <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc02005a2:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc02005a6:	67e1                	lui	a5,0x18
ffffffffc02005a8:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_ex2_out_size+0xd930>
ffffffffc02005ac:	953e                	add	a0,a0,a5
ffffffffc02005ae:	4581                	li	a1,0
ffffffffc02005b0:	4601                	li	a2,0
ffffffffc02005b2:	4881                	li	a7,0
ffffffffc02005b4:	00000073          	ecall
ffffffffc02005b8:	8082                	ret

ffffffffc02005ba <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc02005ba:	8082                	ret

ffffffffc02005bc <cons_putc>:
#include <riscv.h>
#include <assert.h>
#include <atomic.h>

static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02005bc:	100027f3          	csrr	a5,sstatus
ffffffffc02005c0:	8b89                	andi	a5,a5,2
ffffffffc02005c2:	0ff57513          	andi	a0,a0,255
ffffffffc02005c6:	e799                	bnez	a5,ffffffffc02005d4 <cons_putc+0x18>
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
ffffffffc02005c8:	4581                	li	a1,0
ffffffffc02005ca:	4601                	li	a2,0
ffffffffc02005cc:	4885                	li	a7,1
ffffffffc02005ce:	00000073          	ecall
    }
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
ffffffffc02005d2:	8082                	ret

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) {
ffffffffc02005d4:	1101                	addi	sp,sp,-32
ffffffffc02005d6:	ec06                	sd	ra,24(sp)
ffffffffc02005d8:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02005da:	058000ef          	jal	ra,ffffffffc0200632 <intr_disable>
ffffffffc02005de:	6522                	ld	a0,8(sp)
ffffffffc02005e0:	4581                	li	a1,0
ffffffffc02005e2:	4601                	li	a2,0
ffffffffc02005e4:	4885                	li	a7,1
ffffffffc02005e6:	00000073          	ecall
    local_intr_save(intr_flag);
    {
        sbi_console_putchar((unsigned char)c);
    }
    local_intr_restore(intr_flag);
}
ffffffffc02005ea:	60e2                	ld	ra,24(sp)
ffffffffc02005ec:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc02005ee:	a83d                	j	ffffffffc020062c <intr_enable>

ffffffffc02005f0 <cons_getc>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02005f0:	100027f3          	csrr	a5,sstatus
ffffffffc02005f4:	8b89                	andi	a5,a5,2
ffffffffc02005f6:	eb89                	bnez	a5,ffffffffc0200608 <cons_getc+0x18>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
ffffffffc02005f8:	4501                	li	a0,0
ffffffffc02005fa:	4581                	li	a1,0
ffffffffc02005fc:	4601                	li	a2,0
ffffffffc02005fe:	4889                	li	a7,2
ffffffffc0200600:	00000073          	ecall
ffffffffc0200604:	2501                	sext.w	a0,a0
    {
        c = sbi_console_getchar();
    }
    local_intr_restore(intr_flag);
    return c;
}
ffffffffc0200606:	8082                	ret
int cons_getc(void) {
ffffffffc0200608:	1101                	addi	sp,sp,-32
ffffffffc020060a:	ec06                	sd	ra,24(sp)
        intr_disable();
ffffffffc020060c:	026000ef          	jal	ra,ffffffffc0200632 <intr_disable>
ffffffffc0200610:	4501                	li	a0,0
ffffffffc0200612:	4581                	li	a1,0
ffffffffc0200614:	4601                	li	a2,0
ffffffffc0200616:	4889                	li	a7,2
ffffffffc0200618:	00000073          	ecall
ffffffffc020061c:	2501                	sext.w	a0,a0
ffffffffc020061e:	e42a                	sd	a0,8(sp)
        intr_enable();
ffffffffc0200620:	00c000ef          	jal	ra,ffffffffc020062c <intr_enable>
}
ffffffffc0200624:	60e2                	ld	ra,24(sp)
ffffffffc0200626:	6522                	ld	a0,8(sp)
ffffffffc0200628:	6105                	addi	sp,sp,32
ffffffffc020062a:	8082                	ret

ffffffffc020062c <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc020062c:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200630:	8082                	ret

ffffffffc0200632 <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc0200632:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200636:	8082                	ret

ffffffffc0200638 <idt_init>:
void
idt_init(void) {
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc0200638:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc020063c:	00000797          	auipc	a5,0x0
ffffffffc0200640:	62c78793          	addi	a5,a5,1580 # ffffffffc0200c68 <__alltraps>
ffffffffc0200644:	10579073          	csrw	stvec,a5
    /* Allow kernel to access user memory */
    set_csr(sstatus, SSTATUS_SUM);
ffffffffc0200648:	000407b7          	lui	a5,0x40
ffffffffc020064c:	1007a7f3          	csrrs	a5,sstatus,a5
}
ffffffffc0200650:	8082                	ret

ffffffffc0200652 <print_regs>:
    cprintf("  tval 0x%08x\n", tf->tval);
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs* gpr) {
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200652:	610c                	ld	a1,0(a0)
void print_regs(struct pushregs* gpr) {
ffffffffc0200654:	1141                	addi	sp,sp,-16
ffffffffc0200656:	e022                	sd	s0,0(sp)
ffffffffc0200658:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc020065a:	00005517          	auipc	a0,0x5
ffffffffc020065e:	95650513          	addi	a0,a0,-1706 # ffffffffc0204fb0 <commands+0x60>
void print_regs(struct pushregs* gpr) {
ffffffffc0200662:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200664:	a65ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc0200668:	640c                	ld	a1,8(s0)
ffffffffc020066a:	00005517          	auipc	a0,0x5
ffffffffc020066e:	95e50513          	addi	a0,a0,-1698 # ffffffffc0204fc8 <commands+0x78>
ffffffffc0200672:	a57ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc0200676:	680c                	ld	a1,16(s0)
ffffffffc0200678:	00005517          	auipc	a0,0x5
ffffffffc020067c:	96850513          	addi	a0,a0,-1688 # ffffffffc0204fe0 <commands+0x90>
ffffffffc0200680:	a49ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200684:	6c0c                	ld	a1,24(s0)
ffffffffc0200686:	00005517          	auipc	a0,0x5
ffffffffc020068a:	97250513          	addi	a0,a0,-1678 # ffffffffc0204ff8 <commands+0xa8>
ffffffffc020068e:	a3bff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc0200692:	700c                	ld	a1,32(s0)
ffffffffc0200694:	00005517          	auipc	a0,0x5
ffffffffc0200698:	97c50513          	addi	a0,a0,-1668 # ffffffffc0205010 <commands+0xc0>
ffffffffc020069c:	a2dff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc02006a0:	740c                	ld	a1,40(s0)
ffffffffc02006a2:	00005517          	auipc	a0,0x5
ffffffffc02006a6:	98650513          	addi	a0,a0,-1658 # ffffffffc0205028 <commands+0xd8>
ffffffffc02006aa:	a1fff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc02006ae:	780c                	ld	a1,48(s0)
ffffffffc02006b0:	00005517          	auipc	a0,0x5
ffffffffc02006b4:	99050513          	addi	a0,a0,-1648 # ffffffffc0205040 <commands+0xf0>
ffffffffc02006b8:	a11ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc02006bc:	7c0c                	ld	a1,56(s0)
ffffffffc02006be:	00005517          	auipc	a0,0x5
ffffffffc02006c2:	99a50513          	addi	a0,a0,-1638 # ffffffffc0205058 <commands+0x108>
ffffffffc02006c6:	a03ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc02006ca:	602c                	ld	a1,64(s0)
ffffffffc02006cc:	00005517          	auipc	a0,0x5
ffffffffc02006d0:	9a450513          	addi	a0,a0,-1628 # ffffffffc0205070 <commands+0x120>
ffffffffc02006d4:	9f5ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc02006d8:	642c                	ld	a1,72(s0)
ffffffffc02006da:	00005517          	auipc	a0,0x5
ffffffffc02006de:	9ae50513          	addi	a0,a0,-1618 # ffffffffc0205088 <commands+0x138>
ffffffffc02006e2:	9e7ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc02006e6:	682c                	ld	a1,80(s0)
ffffffffc02006e8:	00005517          	auipc	a0,0x5
ffffffffc02006ec:	9b850513          	addi	a0,a0,-1608 # ffffffffc02050a0 <commands+0x150>
ffffffffc02006f0:	9d9ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc02006f4:	6c2c                	ld	a1,88(s0)
ffffffffc02006f6:	00005517          	auipc	a0,0x5
ffffffffc02006fa:	9c250513          	addi	a0,a0,-1598 # ffffffffc02050b8 <commands+0x168>
ffffffffc02006fe:	9cbff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200702:	702c                	ld	a1,96(s0)
ffffffffc0200704:	00005517          	auipc	a0,0x5
ffffffffc0200708:	9cc50513          	addi	a0,a0,-1588 # ffffffffc02050d0 <commands+0x180>
ffffffffc020070c:	9bdff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200710:	742c                	ld	a1,104(s0)
ffffffffc0200712:	00005517          	auipc	a0,0x5
ffffffffc0200716:	9d650513          	addi	a0,a0,-1578 # ffffffffc02050e8 <commands+0x198>
ffffffffc020071a:	9afff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc020071e:	782c                	ld	a1,112(s0)
ffffffffc0200720:	00005517          	auipc	a0,0x5
ffffffffc0200724:	9e050513          	addi	a0,a0,-1568 # ffffffffc0205100 <commands+0x1b0>
ffffffffc0200728:	9a1ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc020072c:	7c2c                	ld	a1,120(s0)
ffffffffc020072e:	00005517          	auipc	a0,0x5
ffffffffc0200732:	9ea50513          	addi	a0,a0,-1558 # ffffffffc0205118 <commands+0x1c8>
ffffffffc0200736:	993ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc020073a:	604c                	ld	a1,128(s0)
ffffffffc020073c:	00005517          	auipc	a0,0x5
ffffffffc0200740:	9f450513          	addi	a0,a0,-1548 # ffffffffc0205130 <commands+0x1e0>
ffffffffc0200744:	985ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200748:	644c                	ld	a1,136(s0)
ffffffffc020074a:	00005517          	auipc	a0,0x5
ffffffffc020074e:	9fe50513          	addi	a0,a0,-1538 # ffffffffc0205148 <commands+0x1f8>
ffffffffc0200752:	977ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200756:	684c                	ld	a1,144(s0)
ffffffffc0200758:	00005517          	auipc	a0,0x5
ffffffffc020075c:	a0850513          	addi	a0,a0,-1528 # ffffffffc0205160 <commands+0x210>
ffffffffc0200760:	969ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200764:	6c4c                	ld	a1,152(s0)
ffffffffc0200766:	00005517          	auipc	a0,0x5
ffffffffc020076a:	a1250513          	addi	a0,a0,-1518 # ffffffffc0205178 <commands+0x228>
ffffffffc020076e:	95bff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200772:	704c                	ld	a1,160(s0)
ffffffffc0200774:	00005517          	auipc	a0,0x5
ffffffffc0200778:	a1c50513          	addi	a0,a0,-1508 # ffffffffc0205190 <commands+0x240>
ffffffffc020077c:	94dff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc0200780:	744c                	ld	a1,168(s0)
ffffffffc0200782:	00005517          	auipc	a0,0x5
ffffffffc0200786:	a2650513          	addi	a0,a0,-1498 # ffffffffc02051a8 <commands+0x258>
ffffffffc020078a:	93fff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc020078e:	784c                	ld	a1,176(s0)
ffffffffc0200790:	00005517          	auipc	a0,0x5
ffffffffc0200794:	a3050513          	addi	a0,a0,-1488 # ffffffffc02051c0 <commands+0x270>
ffffffffc0200798:	931ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc020079c:	7c4c                	ld	a1,184(s0)
ffffffffc020079e:	00005517          	auipc	a0,0x5
ffffffffc02007a2:	a3a50513          	addi	a0,a0,-1478 # ffffffffc02051d8 <commands+0x288>
ffffffffc02007a6:	923ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc02007aa:	606c                	ld	a1,192(s0)
ffffffffc02007ac:	00005517          	auipc	a0,0x5
ffffffffc02007b0:	a4450513          	addi	a0,a0,-1468 # ffffffffc02051f0 <commands+0x2a0>
ffffffffc02007b4:	915ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc02007b8:	646c                	ld	a1,200(s0)
ffffffffc02007ba:	00005517          	auipc	a0,0x5
ffffffffc02007be:	a4e50513          	addi	a0,a0,-1458 # ffffffffc0205208 <commands+0x2b8>
ffffffffc02007c2:	907ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc02007c6:	686c                	ld	a1,208(s0)
ffffffffc02007c8:	00005517          	auipc	a0,0x5
ffffffffc02007cc:	a5850513          	addi	a0,a0,-1448 # ffffffffc0205220 <commands+0x2d0>
ffffffffc02007d0:	8f9ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc02007d4:	6c6c                	ld	a1,216(s0)
ffffffffc02007d6:	00005517          	auipc	a0,0x5
ffffffffc02007da:	a6250513          	addi	a0,a0,-1438 # ffffffffc0205238 <commands+0x2e8>
ffffffffc02007de:	8ebff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc02007e2:	706c                	ld	a1,224(s0)
ffffffffc02007e4:	00005517          	auipc	a0,0x5
ffffffffc02007e8:	a6c50513          	addi	a0,a0,-1428 # ffffffffc0205250 <commands+0x300>
ffffffffc02007ec:	8ddff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc02007f0:	746c                	ld	a1,232(s0)
ffffffffc02007f2:	00005517          	auipc	a0,0x5
ffffffffc02007f6:	a7650513          	addi	a0,a0,-1418 # ffffffffc0205268 <commands+0x318>
ffffffffc02007fa:	8cfff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc02007fe:	786c                	ld	a1,240(s0)
ffffffffc0200800:	00005517          	auipc	a0,0x5
ffffffffc0200804:	a8050513          	addi	a0,a0,-1408 # ffffffffc0205280 <commands+0x330>
ffffffffc0200808:	8c1ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc020080c:	7c6c                	ld	a1,248(s0)
}
ffffffffc020080e:	6402                	ld	s0,0(sp)
ffffffffc0200810:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200812:	00005517          	auipc	a0,0x5
ffffffffc0200816:	a8650513          	addi	a0,a0,-1402 # ffffffffc0205298 <commands+0x348>
}
ffffffffc020081a:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc020081c:	8adff06f          	j	ffffffffc02000c8 <cprintf>

ffffffffc0200820 <print_trapframe>:
print_trapframe(struct trapframe *tf) {
ffffffffc0200820:	1141                	addi	sp,sp,-16
ffffffffc0200822:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200824:	85aa                	mv	a1,a0
print_trapframe(struct trapframe *tf) {
ffffffffc0200826:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200828:	00005517          	auipc	a0,0x5
ffffffffc020082c:	a8850513          	addi	a0,a0,-1400 # ffffffffc02052b0 <commands+0x360>
print_trapframe(struct trapframe *tf) {
ffffffffc0200830:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200832:	897ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200836:	8522                	mv	a0,s0
ffffffffc0200838:	e1bff0ef          	jal	ra,ffffffffc0200652 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc020083c:	10043583          	ld	a1,256(s0)
ffffffffc0200840:	00005517          	auipc	a0,0x5
ffffffffc0200844:	a8850513          	addi	a0,a0,-1400 # ffffffffc02052c8 <commands+0x378>
ffffffffc0200848:	881ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc020084c:	10843583          	ld	a1,264(s0)
ffffffffc0200850:	00005517          	auipc	a0,0x5
ffffffffc0200854:	a9050513          	addi	a0,a0,-1392 # ffffffffc02052e0 <commands+0x390>
ffffffffc0200858:	871ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  tval 0x%08x\n", tf->tval);
ffffffffc020085c:	11043583          	ld	a1,272(s0)
ffffffffc0200860:	00005517          	auipc	a0,0x5
ffffffffc0200864:	a9850513          	addi	a0,a0,-1384 # ffffffffc02052f8 <commands+0x3a8>
ffffffffc0200868:	861ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc020086c:	11843583          	ld	a1,280(s0)
}
ffffffffc0200870:	6402                	ld	s0,0(sp)
ffffffffc0200872:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200874:	00005517          	auipc	a0,0x5
ffffffffc0200878:	a9450513          	addi	a0,a0,-1388 # ffffffffc0205308 <commands+0x3b8>
}
ffffffffc020087c:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc020087e:	84bff06f          	j	ffffffffc02000c8 <cprintf>

ffffffffc0200882 <pgfault_handler>:
            trap_in_kernel(tf) ? 'K' : 'U',
            tf->cause == CAUSE_STORE_PAGE_FAULT ? 'W' : 'R');
}

static int
pgfault_handler(struct trapframe *tf) {
ffffffffc0200882:	1101                	addi	sp,sp,-32
ffffffffc0200884:	e426                	sd	s1,8(sp)
    extern struct mm_struct *check_mm_struct;
    if(check_mm_struct !=NULL) { 
ffffffffc0200886:	00053497          	auipc	s1,0x53
ffffffffc020088a:	e9a48493          	addi	s1,s1,-358 # ffffffffc0253720 <check_mm_struct>
ffffffffc020088e:	609c                	ld	a5,0(s1)
pgfault_handler(struct trapframe *tf) {
ffffffffc0200890:	e822                	sd	s0,16(sp)
ffffffffc0200892:	ec06                	sd	ra,24(sp)
ffffffffc0200894:	842a                	mv	s0,a0
    if(check_mm_struct !=NULL) { 
ffffffffc0200896:	cbad                	beqz	a5,ffffffffc0200908 <pgfault_handler+0x86>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200898:	10053783          	ld	a5,256(a0)
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc020089c:	11053583          	ld	a1,272(a0)
ffffffffc02008a0:	04b00613          	li	a2,75
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc02008a4:	1007f793          	andi	a5,a5,256
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc02008a8:	c7b1                	beqz	a5,ffffffffc02008f4 <pgfault_handler+0x72>
ffffffffc02008aa:	11843703          	ld	a4,280(s0)
ffffffffc02008ae:	47bd                	li	a5,15
ffffffffc02008b0:	05700693          	li	a3,87
ffffffffc02008b4:	00f70463          	beq	a4,a5,ffffffffc02008bc <pgfault_handler+0x3a>
ffffffffc02008b8:	05200693          	li	a3,82
ffffffffc02008bc:	00005517          	auipc	a0,0x5
ffffffffc02008c0:	a6450513          	addi	a0,a0,-1436 # ffffffffc0205320 <commands+0x3d0>
ffffffffc02008c4:	805ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            print_pgfault(tf);
        }
    struct mm_struct *mm;
    if (check_mm_struct != NULL) {
ffffffffc02008c8:	6088                	ld	a0,0(s1)
ffffffffc02008ca:	cd1d                	beqz	a0,ffffffffc0200908 <pgfault_handler+0x86>
        assert(current == idleproc);
ffffffffc02008cc:	00053717          	auipc	a4,0x53
ffffffffc02008d0:	e1c73703          	ld	a4,-484(a4) # ffffffffc02536e8 <current>
ffffffffc02008d4:	00053797          	auipc	a5,0x53
ffffffffc02008d8:	e1c7b783          	ld	a5,-484(a5) # ffffffffc02536f0 <idleproc>
ffffffffc02008dc:	04f71663          	bne	a4,a5,ffffffffc0200928 <pgfault_handler+0xa6>
            print_pgfault(tf);
            panic("unhandled page fault.\n");
        }
        mm = current->mm;
    }
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008e0:	11043603          	ld	a2,272(s0)
ffffffffc02008e4:	11843583          	ld	a1,280(s0)
}
ffffffffc02008e8:	6442                	ld	s0,16(sp)
ffffffffc02008ea:	60e2                	ld	ra,24(sp)
ffffffffc02008ec:	64a2                	ld	s1,8(sp)
ffffffffc02008ee:	6105                	addi	sp,sp,32
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008f0:	7d60006f          	j	ffffffffc02010c6 <do_pgfault>
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc02008f4:	11843703          	ld	a4,280(s0)
ffffffffc02008f8:	47bd                	li	a5,15
ffffffffc02008fa:	05500613          	li	a2,85
ffffffffc02008fe:	05700693          	li	a3,87
ffffffffc0200902:	faf71be3          	bne	a4,a5,ffffffffc02008b8 <pgfault_handler+0x36>
ffffffffc0200906:	bf5d                	j	ffffffffc02008bc <pgfault_handler+0x3a>
        if (current == NULL) {
ffffffffc0200908:	00053797          	auipc	a5,0x53
ffffffffc020090c:	de07b783          	ld	a5,-544(a5) # ffffffffc02536e8 <current>
ffffffffc0200910:	cf85                	beqz	a5,ffffffffc0200948 <pgfault_handler+0xc6>
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc0200912:	11043603          	ld	a2,272(s0)
ffffffffc0200916:	11843583          	ld	a1,280(s0)
}
ffffffffc020091a:	6442                	ld	s0,16(sp)
ffffffffc020091c:	60e2                	ld	ra,24(sp)
ffffffffc020091e:	64a2                	ld	s1,8(sp)
        mm = current->mm;
ffffffffc0200920:	7788                	ld	a0,40(a5)
}
ffffffffc0200922:	6105                	addi	sp,sp,32
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc0200924:	7a20006f          	j	ffffffffc02010c6 <do_pgfault>
        assert(current == idleproc);
ffffffffc0200928:	00005697          	auipc	a3,0x5
ffffffffc020092c:	a1868693          	addi	a3,a3,-1512 # ffffffffc0205340 <commands+0x3f0>
ffffffffc0200930:	00005617          	auipc	a2,0x5
ffffffffc0200934:	a2860613          	addi	a2,a2,-1496 # ffffffffc0205358 <commands+0x408>
ffffffffc0200938:	06800593          	li	a1,104
ffffffffc020093c:	00005517          	auipc	a0,0x5
ffffffffc0200940:	a3450513          	addi	a0,a0,-1484 # ffffffffc0205370 <commands+0x420>
ffffffffc0200944:	8c1ff0ef          	jal	ra,ffffffffc0200204 <__panic>
            print_trapframe(tf);
ffffffffc0200948:	8522                	mv	a0,s0
ffffffffc020094a:	ed7ff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc020094e:	10043783          	ld	a5,256(s0)
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc0200952:	11043583          	ld	a1,272(s0)
ffffffffc0200956:	04b00613          	li	a2,75
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc020095a:	1007f793          	andi	a5,a5,256
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc020095e:	e399                	bnez	a5,ffffffffc0200964 <pgfault_handler+0xe2>
ffffffffc0200960:	05500613          	li	a2,85
ffffffffc0200964:	11843703          	ld	a4,280(s0)
ffffffffc0200968:	47bd                	li	a5,15
ffffffffc020096a:	02f70663          	beq	a4,a5,ffffffffc0200996 <pgfault_handler+0x114>
ffffffffc020096e:	05200693          	li	a3,82
ffffffffc0200972:	00005517          	auipc	a0,0x5
ffffffffc0200976:	9ae50513          	addi	a0,a0,-1618 # ffffffffc0205320 <commands+0x3d0>
ffffffffc020097a:	f4eff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            panic("unhandled page fault.\n");
ffffffffc020097e:	00005617          	auipc	a2,0x5
ffffffffc0200982:	a0a60613          	addi	a2,a2,-1526 # ffffffffc0205388 <commands+0x438>
ffffffffc0200986:	06f00593          	li	a1,111
ffffffffc020098a:	00005517          	auipc	a0,0x5
ffffffffc020098e:	9e650513          	addi	a0,a0,-1562 # ffffffffc0205370 <commands+0x420>
ffffffffc0200992:	873ff0ef          	jal	ra,ffffffffc0200204 <__panic>
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc0200996:	05700693          	li	a3,87
ffffffffc020099a:	bfe1                	j	ffffffffc0200972 <pgfault_handler+0xf0>

ffffffffc020099c <interrupt_handler>:

static volatile int in_swap_tick_event = 0;
extern struct mm_struct *check_mm_struct;

void interrupt_handler(struct trapframe *tf) {
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc020099c:	11853783          	ld	a5,280(a0)
ffffffffc02009a0:	472d                	li	a4,11
ffffffffc02009a2:	0786                	slli	a5,a5,0x1
ffffffffc02009a4:	8385                	srli	a5,a5,0x1
ffffffffc02009a6:	06f76d63          	bltu	a4,a5,ffffffffc0200a20 <interrupt_handler+0x84>
ffffffffc02009aa:	00005717          	auipc	a4,0x5
ffffffffc02009ae:	a9670713          	addi	a4,a4,-1386 # ffffffffc0205440 <commands+0x4f0>
ffffffffc02009b2:	078a                	slli	a5,a5,0x2
ffffffffc02009b4:	97ba                	add	a5,a5,a4
ffffffffc02009b6:	439c                	lw	a5,0(a5)
ffffffffc02009b8:	97ba                	add	a5,a5,a4
ffffffffc02009ba:	8782                	jr	a5
            break;
        case IRQ_H_SOFT:
            cprintf("Hypervisor software interrupt\n");
            break;
        case IRQ_M_SOFT:
            cprintf("Machine software interrupt\n");
ffffffffc02009bc:	00005517          	auipc	a0,0x5
ffffffffc02009c0:	a4450513          	addi	a0,a0,-1468 # ffffffffc0205400 <commands+0x4b0>
ffffffffc02009c4:	f04ff06f          	j	ffffffffc02000c8 <cprintf>
            cprintf("Hypervisor software interrupt\n");
ffffffffc02009c8:	00005517          	auipc	a0,0x5
ffffffffc02009cc:	a1850513          	addi	a0,a0,-1512 # ffffffffc02053e0 <commands+0x490>
ffffffffc02009d0:	ef8ff06f          	j	ffffffffc02000c8 <cprintf>
            cprintf("User software interrupt\n");
ffffffffc02009d4:	00005517          	auipc	a0,0x5
ffffffffc02009d8:	9cc50513          	addi	a0,a0,-1588 # ffffffffc02053a0 <commands+0x450>
ffffffffc02009dc:	eecff06f          	j	ffffffffc02000c8 <cprintf>
            cprintf("Supervisor software interrupt\n");
ffffffffc02009e0:	00005517          	auipc	a0,0x5
ffffffffc02009e4:	9e050513          	addi	a0,a0,-1568 # ffffffffc02053c0 <commands+0x470>
ffffffffc02009e8:	ee0ff06f          	j	ffffffffc02000c8 <cprintf>
void interrupt_handler(struct trapframe *tf) {
ffffffffc02009ec:	1141                	addi	sp,sp,-16
ffffffffc02009ee:	e406                	sd	ra,8(sp)
            break;
        case IRQ_U_TIMER:
            cprintf("User software interrupt\n");
            break;
        case IRQ_S_TIMER:
            clock_set_next_event();
ffffffffc02009f0:	bb3ff0ef          	jal	ra,ffffffffc02005a2 <clock_set_next_event>
            if (++ticks % TICK_NUM == 0 ) {
ffffffffc02009f4:	00053717          	auipc	a4,0x53
ffffffffc02009f8:	d2470713          	addi	a4,a4,-732 # ffffffffc0253718 <ticks>
ffffffffc02009fc:	631c                	ld	a5,0(a4)
                //print_ticks()
            }
            if (current){
ffffffffc02009fe:	00053517          	auipc	a0,0x53
ffffffffc0200a02:	cea53503          	ld	a0,-790(a0) # ffffffffc02536e8 <current>
            if (++ticks % TICK_NUM == 0 ) {
ffffffffc0200a06:	0785                	addi	a5,a5,1
ffffffffc0200a08:	e31c                	sd	a5,0(a4)
            if (current){
ffffffffc0200a0a:	cd01                	beqz	a0,ffffffffc0200a22 <interrupt_handler+0x86>
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200a0c:	60a2                	ld	ra,8(sp)
ffffffffc0200a0e:	0141                	addi	sp,sp,16
                sched_class_proc_tick(current); 
ffffffffc0200a10:	23d0306f          	j	ffffffffc020444c <sched_class_proc_tick>
            cprintf("Supervisor external interrupt\n");
ffffffffc0200a14:	00005517          	auipc	a0,0x5
ffffffffc0200a18:	a0c50513          	addi	a0,a0,-1524 # ffffffffc0205420 <commands+0x4d0>
ffffffffc0200a1c:	eacff06f          	j	ffffffffc02000c8 <cprintf>
            print_trapframe(tf);
ffffffffc0200a20:	b501                	j	ffffffffc0200820 <print_trapframe>
}
ffffffffc0200a22:	60a2                	ld	ra,8(sp)
ffffffffc0200a24:	0141                	addi	sp,sp,16
ffffffffc0200a26:	8082                	ret

ffffffffc0200a28 <exception_handler>:

void exception_handler(struct trapframe *tf) {
    int ret;
    switch (tf->cause) {
ffffffffc0200a28:	11853783          	ld	a5,280(a0)
void exception_handler(struct trapframe *tf) {
ffffffffc0200a2c:	1101                	addi	sp,sp,-32
ffffffffc0200a2e:	e822                	sd	s0,16(sp)
ffffffffc0200a30:	ec06                	sd	ra,24(sp)
ffffffffc0200a32:	e426                	sd	s1,8(sp)
ffffffffc0200a34:	473d                	li	a4,15
ffffffffc0200a36:	842a                	mv	s0,a0
ffffffffc0200a38:	16f76163          	bltu	a4,a5,ffffffffc0200b9a <exception_handler+0x172>
ffffffffc0200a3c:	00005717          	auipc	a4,0x5
ffffffffc0200a40:	bcc70713          	addi	a4,a4,-1076 # ffffffffc0205608 <commands+0x6b8>
ffffffffc0200a44:	078a                	slli	a5,a5,0x2
ffffffffc0200a46:	97ba                	add	a5,a5,a4
ffffffffc0200a48:	439c                	lw	a5,0(a5)
ffffffffc0200a4a:	97ba                	add	a5,a5,a4
ffffffffc0200a4c:	8782                	jr	a5
            //cprintf("Environment call from U-mode\n");
            tf->epc += 4;
            syscall();
            break;
        case CAUSE_SUPERVISOR_ECALL:
            cprintf("Environment call from S-mode\n");
ffffffffc0200a4e:	00005517          	auipc	a0,0x5
ffffffffc0200a52:	b1250513          	addi	a0,a0,-1262 # ffffffffc0205560 <commands+0x610>
ffffffffc0200a56:	e72ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            tf->epc += 4;
ffffffffc0200a5a:	10843783          	ld	a5,264(s0)
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200a5e:	60e2                	ld	ra,24(sp)
ffffffffc0200a60:	64a2                	ld	s1,8(sp)
            tf->epc += 4;
ffffffffc0200a62:	0791                	addi	a5,a5,4
ffffffffc0200a64:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200a68:	6442                	ld	s0,16(sp)
ffffffffc0200a6a:	6105                	addi	sp,sp,32
            syscall();
ffffffffc0200a6c:	5290306f          	j	ffffffffc0204794 <syscall>
            cprintf("Environment call from H-mode\n");
ffffffffc0200a70:	00005517          	auipc	a0,0x5
ffffffffc0200a74:	b1050513          	addi	a0,a0,-1264 # ffffffffc0205580 <commands+0x630>
}
ffffffffc0200a78:	6442                	ld	s0,16(sp)
ffffffffc0200a7a:	60e2                	ld	ra,24(sp)
ffffffffc0200a7c:	64a2                	ld	s1,8(sp)
ffffffffc0200a7e:	6105                	addi	sp,sp,32
            cprintf("Instruction access fault\n");
ffffffffc0200a80:	e48ff06f          	j	ffffffffc02000c8 <cprintf>
            cprintf("Environment call from M-mode\n");
ffffffffc0200a84:	00005517          	auipc	a0,0x5
ffffffffc0200a88:	b1c50513          	addi	a0,a0,-1252 # ffffffffc02055a0 <commands+0x650>
ffffffffc0200a8c:	b7f5                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Instruction page fault\n");
ffffffffc0200a8e:	00005517          	auipc	a0,0x5
ffffffffc0200a92:	b3250513          	addi	a0,a0,-1230 # ffffffffc02055c0 <commands+0x670>
ffffffffc0200a96:	b7cd                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Load page fault\n");
ffffffffc0200a98:	00005517          	auipc	a0,0x5
ffffffffc0200a9c:	b4050513          	addi	a0,a0,-1216 # ffffffffc02055d8 <commands+0x688>
ffffffffc0200aa0:	e28ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200aa4:	8522                	mv	a0,s0
ffffffffc0200aa6:	dddff0ef          	jal	ra,ffffffffc0200882 <pgfault_handler>
ffffffffc0200aaa:	84aa                	mv	s1,a0
ffffffffc0200aac:	10051963          	bnez	a0,ffffffffc0200bbe <exception_handler+0x196>
}
ffffffffc0200ab0:	60e2                	ld	ra,24(sp)
ffffffffc0200ab2:	6442                	ld	s0,16(sp)
ffffffffc0200ab4:	64a2                	ld	s1,8(sp)
ffffffffc0200ab6:	6105                	addi	sp,sp,32
ffffffffc0200ab8:	8082                	ret
            cprintf("Store/AMO page fault\n");
ffffffffc0200aba:	00005517          	auipc	a0,0x5
ffffffffc0200abe:	b3650513          	addi	a0,a0,-1226 # ffffffffc02055f0 <commands+0x6a0>
ffffffffc0200ac2:	e06ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200ac6:	8522                	mv	a0,s0
ffffffffc0200ac8:	dbbff0ef          	jal	ra,ffffffffc0200882 <pgfault_handler>
ffffffffc0200acc:	84aa                	mv	s1,a0
ffffffffc0200ace:	d16d                	beqz	a0,ffffffffc0200ab0 <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200ad0:	8522                	mv	a0,s0
ffffffffc0200ad2:	d4fff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200ad6:	86a6                	mv	a3,s1
ffffffffc0200ad8:	00005617          	auipc	a2,0x5
ffffffffc0200adc:	a3860613          	addi	a2,a2,-1480 # ffffffffc0205510 <commands+0x5c0>
ffffffffc0200ae0:	0f100593          	li	a1,241
ffffffffc0200ae4:	00005517          	auipc	a0,0x5
ffffffffc0200ae8:	88c50513          	addi	a0,a0,-1908 # ffffffffc0205370 <commands+0x420>
ffffffffc0200aec:	f18ff0ef          	jal	ra,ffffffffc0200204 <__panic>
            cprintf("Instruction address misaligned\n");
ffffffffc0200af0:	00005517          	auipc	a0,0x5
ffffffffc0200af4:	98050513          	addi	a0,a0,-1664 # ffffffffc0205470 <commands+0x520>
ffffffffc0200af8:	b741                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Instruction access fault\n");
ffffffffc0200afa:	00005517          	auipc	a0,0x5
ffffffffc0200afe:	99650513          	addi	a0,a0,-1642 # ffffffffc0205490 <commands+0x540>
ffffffffc0200b02:	bf9d                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Illegal instruction\n");
ffffffffc0200b04:	00005517          	auipc	a0,0x5
ffffffffc0200b08:	9ac50513          	addi	a0,a0,-1620 # ffffffffc02054b0 <commands+0x560>
ffffffffc0200b0c:	b7b5                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Breakpoint\n");
ffffffffc0200b0e:	00005517          	auipc	a0,0x5
ffffffffc0200b12:	9ba50513          	addi	a0,a0,-1606 # ffffffffc02054c8 <commands+0x578>
ffffffffc0200b16:	db2ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if(tf->gpr.a7 == 10){
ffffffffc0200b1a:	6458                	ld	a4,136(s0)
ffffffffc0200b1c:	47a9                	li	a5,10
ffffffffc0200b1e:	f8f719e3          	bne	a4,a5,ffffffffc0200ab0 <exception_handler+0x88>
ffffffffc0200b22:	bf25                	j	ffffffffc0200a5a <exception_handler+0x32>
            cprintf("Load address misaligned\n");
ffffffffc0200b24:	00005517          	auipc	a0,0x5
ffffffffc0200b28:	9b450513          	addi	a0,a0,-1612 # ffffffffc02054d8 <commands+0x588>
ffffffffc0200b2c:	b7b1                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Load access fault\n");
ffffffffc0200b2e:	00005517          	auipc	a0,0x5
ffffffffc0200b32:	9ca50513          	addi	a0,a0,-1590 # ffffffffc02054f8 <commands+0x5a8>
ffffffffc0200b36:	d92ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200b3a:	8522                	mv	a0,s0
ffffffffc0200b3c:	d47ff0ef          	jal	ra,ffffffffc0200882 <pgfault_handler>
ffffffffc0200b40:	84aa                	mv	s1,a0
ffffffffc0200b42:	d53d                	beqz	a0,ffffffffc0200ab0 <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200b44:	8522                	mv	a0,s0
ffffffffc0200b46:	cdbff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200b4a:	86a6                	mv	a3,s1
ffffffffc0200b4c:	00005617          	auipc	a2,0x5
ffffffffc0200b50:	9c460613          	addi	a2,a2,-1596 # ffffffffc0205510 <commands+0x5c0>
ffffffffc0200b54:	0c600593          	li	a1,198
ffffffffc0200b58:	00005517          	auipc	a0,0x5
ffffffffc0200b5c:	81850513          	addi	a0,a0,-2024 # ffffffffc0205370 <commands+0x420>
ffffffffc0200b60:	ea4ff0ef          	jal	ra,ffffffffc0200204 <__panic>
            cprintf("Store/AMO access fault\n");
ffffffffc0200b64:	00005517          	auipc	a0,0x5
ffffffffc0200b68:	9e450513          	addi	a0,a0,-1564 # ffffffffc0205548 <commands+0x5f8>
ffffffffc0200b6c:	d5cff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200b70:	8522                	mv	a0,s0
ffffffffc0200b72:	d11ff0ef          	jal	ra,ffffffffc0200882 <pgfault_handler>
ffffffffc0200b76:	84aa                	mv	s1,a0
ffffffffc0200b78:	dd05                	beqz	a0,ffffffffc0200ab0 <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200b7a:	8522                	mv	a0,s0
ffffffffc0200b7c:	ca5ff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200b80:	86a6                	mv	a3,s1
ffffffffc0200b82:	00005617          	auipc	a2,0x5
ffffffffc0200b86:	98e60613          	addi	a2,a2,-1650 # ffffffffc0205510 <commands+0x5c0>
ffffffffc0200b8a:	0d000593          	li	a1,208
ffffffffc0200b8e:	00004517          	auipc	a0,0x4
ffffffffc0200b92:	7e250513          	addi	a0,a0,2018 # ffffffffc0205370 <commands+0x420>
ffffffffc0200b96:	e6eff0ef          	jal	ra,ffffffffc0200204 <__panic>
            print_trapframe(tf);
ffffffffc0200b9a:	8522                	mv	a0,s0
}
ffffffffc0200b9c:	6442                	ld	s0,16(sp)
ffffffffc0200b9e:	60e2                	ld	ra,24(sp)
ffffffffc0200ba0:	64a2                	ld	s1,8(sp)
ffffffffc0200ba2:	6105                	addi	sp,sp,32
            print_trapframe(tf);
ffffffffc0200ba4:	b9b5                	j	ffffffffc0200820 <print_trapframe>
            panic("AMO address misaligned\n");
ffffffffc0200ba6:	00005617          	auipc	a2,0x5
ffffffffc0200baa:	98a60613          	addi	a2,a2,-1654 # ffffffffc0205530 <commands+0x5e0>
ffffffffc0200bae:	0ca00593          	li	a1,202
ffffffffc0200bb2:	00004517          	auipc	a0,0x4
ffffffffc0200bb6:	7be50513          	addi	a0,a0,1982 # ffffffffc0205370 <commands+0x420>
ffffffffc0200bba:	e4aff0ef          	jal	ra,ffffffffc0200204 <__panic>
                print_trapframe(tf);
ffffffffc0200bbe:	8522                	mv	a0,s0
ffffffffc0200bc0:	c61ff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200bc4:	86a6                	mv	a3,s1
ffffffffc0200bc6:	00005617          	auipc	a2,0x5
ffffffffc0200bca:	94a60613          	addi	a2,a2,-1718 # ffffffffc0205510 <commands+0x5c0>
ffffffffc0200bce:	0ea00593          	li	a1,234
ffffffffc0200bd2:	00004517          	auipc	a0,0x4
ffffffffc0200bd6:	79e50513          	addi	a0,a0,1950 # ffffffffc0205370 <commands+0x420>
ffffffffc0200bda:	e2aff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0200bde <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
ffffffffc0200bde:	1101                	addi	sp,sp,-32
ffffffffc0200be0:	e822                	sd	s0,16(sp)

    if (current == NULL) {
ffffffffc0200be2:	00053417          	auipc	s0,0x53
ffffffffc0200be6:	b0640413          	addi	s0,s0,-1274 # ffffffffc02536e8 <current>
ffffffffc0200bea:	6018                	ld	a4,0(s0)
trap(struct trapframe *tf) {
ffffffffc0200bec:	ec06                	sd	ra,24(sp)
ffffffffc0200bee:	e426                	sd	s1,8(sp)
ffffffffc0200bf0:	e04a                	sd	s2,0(sp)
ffffffffc0200bf2:	11853683          	ld	a3,280(a0)
    if (current == NULL) {
ffffffffc0200bf6:	cf1d                	beqz	a4,ffffffffc0200c34 <trap+0x56>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200bf8:	10053483          	ld	s1,256(a0)
        trap_dispatch(tf);
    } else {
        struct trapframe *otf = current->tf;
ffffffffc0200bfc:	0a073903          	ld	s2,160(a4)
        current->tf = tf;
ffffffffc0200c00:	f348                	sd	a0,160(a4)
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200c02:	1004f493          	andi	s1,s1,256
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200c06:	0206c463          	bltz	a3,ffffffffc0200c2e <trap+0x50>
        exception_handler(tf);
ffffffffc0200c0a:	e1fff0ef          	jal	ra,ffffffffc0200a28 <exception_handler>

        bool in_kernel = trap_in_kernel(tf);

        trap_dispatch(tf);

        current->tf = otf;
ffffffffc0200c0e:	601c                	ld	a5,0(s0)
ffffffffc0200c10:	0b27b023          	sd	s2,160(a5)
        if (!in_kernel) {
ffffffffc0200c14:	e499                	bnez	s1,ffffffffc0200c22 <trap+0x44>
            if (current->flags & PF_EXITING) {
ffffffffc0200c16:	0b07a703          	lw	a4,176(a5)
ffffffffc0200c1a:	8b05                	andi	a4,a4,1
ffffffffc0200c1c:	e329                	bnez	a4,ffffffffc0200c5e <trap+0x80>
                do_exit(-E_KILLED);
            }
            if (current->need_resched) {
ffffffffc0200c1e:	6f9c                	ld	a5,24(a5)
ffffffffc0200c20:	eb85                	bnez	a5,ffffffffc0200c50 <trap+0x72>
                schedule();
            }
        }
    }
}
ffffffffc0200c22:	60e2                	ld	ra,24(sp)
ffffffffc0200c24:	6442                	ld	s0,16(sp)
ffffffffc0200c26:	64a2                	ld	s1,8(sp)
ffffffffc0200c28:	6902                	ld	s2,0(sp)
ffffffffc0200c2a:	6105                	addi	sp,sp,32
ffffffffc0200c2c:	8082                	ret
        interrupt_handler(tf);
ffffffffc0200c2e:	d6fff0ef          	jal	ra,ffffffffc020099c <interrupt_handler>
ffffffffc0200c32:	bff1                	j	ffffffffc0200c0e <trap+0x30>
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200c34:	0006c863          	bltz	a3,ffffffffc0200c44 <trap+0x66>
}
ffffffffc0200c38:	6442                	ld	s0,16(sp)
ffffffffc0200c3a:	60e2                	ld	ra,24(sp)
ffffffffc0200c3c:	64a2                	ld	s1,8(sp)
ffffffffc0200c3e:	6902                	ld	s2,0(sp)
ffffffffc0200c40:	6105                	addi	sp,sp,32
        exception_handler(tf);
ffffffffc0200c42:	b3dd                	j	ffffffffc0200a28 <exception_handler>
}
ffffffffc0200c44:	6442                	ld	s0,16(sp)
ffffffffc0200c46:	60e2                	ld	ra,24(sp)
ffffffffc0200c48:	64a2                	ld	s1,8(sp)
ffffffffc0200c4a:	6902                	ld	s2,0(sp)
ffffffffc0200c4c:	6105                	addi	sp,sp,32
        interrupt_handler(tf);
ffffffffc0200c4e:	b3b9                	j	ffffffffc020099c <interrupt_handler>
}
ffffffffc0200c50:	6442                	ld	s0,16(sp)
ffffffffc0200c52:	60e2                	ld	ra,24(sp)
ffffffffc0200c54:	64a2                	ld	s1,8(sp)
ffffffffc0200c56:	6902                	ld	s2,0(sp)
ffffffffc0200c58:	6105                	addi	sp,sp,32
                schedule();
ffffffffc0200c5a:	1210306f          	j	ffffffffc020457a <schedule>
                do_exit(-E_KILLED);
ffffffffc0200c5e:	555d                	li	a0,-9
ffffffffc0200c60:	51b020ef          	jal	ra,ffffffffc020397a <do_exit>
ffffffffc0200c64:	601c                	ld	a5,0(s0)
ffffffffc0200c66:	bf65                	j	ffffffffc0200c1e <trap+0x40>

ffffffffc0200c68 <__alltraps>:
    LOAD x2, 2*REGBYTES(sp)
    .endm

    .globl __alltraps
__alltraps:
    SAVE_ALL
ffffffffc0200c68:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200c6c:	00011463          	bnez	sp,ffffffffc0200c74 <__alltraps+0xc>
ffffffffc0200c70:	14002173          	csrr	sp,sscratch
ffffffffc0200c74:	712d                	addi	sp,sp,-288
ffffffffc0200c76:	e002                	sd	zero,0(sp)
ffffffffc0200c78:	e406                	sd	ra,8(sp)
ffffffffc0200c7a:	ec0e                	sd	gp,24(sp)
ffffffffc0200c7c:	f012                	sd	tp,32(sp)
ffffffffc0200c7e:	f416                	sd	t0,40(sp)
ffffffffc0200c80:	f81a                	sd	t1,48(sp)
ffffffffc0200c82:	fc1e                	sd	t2,56(sp)
ffffffffc0200c84:	e0a2                	sd	s0,64(sp)
ffffffffc0200c86:	e4a6                	sd	s1,72(sp)
ffffffffc0200c88:	e8aa                	sd	a0,80(sp)
ffffffffc0200c8a:	ecae                	sd	a1,88(sp)
ffffffffc0200c8c:	f0b2                	sd	a2,96(sp)
ffffffffc0200c8e:	f4b6                	sd	a3,104(sp)
ffffffffc0200c90:	f8ba                	sd	a4,112(sp)
ffffffffc0200c92:	fcbe                	sd	a5,120(sp)
ffffffffc0200c94:	e142                	sd	a6,128(sp)
ffffffffc0200c96:	e546                	sd	a7,136(sp)
ffffffffc0200c98:	e94a                	sd	s2,144(sp)
ffffffffc0200c9a:	ed4e                	sd	s3,152(sp)
ffffffffc0200c9c:	f152                	sd	s4,160(sp)
ffffffffc0200c9e:	f556                	sd	s5,168(sp)
ffffffffc0200ca0:	f95a                	sd	s6,176(sp)
ffffffffc0200ca2:	fd5e                	sd	s7,184(sp)
ffffffffc0200ca4:	e1e2                	sd	s8,192(sp)
ffffffffc0200ca6:	e5e6                	sd	s9,200(sp)
ffffffffc0200ca8:	e9ea                	sd	s10,208(sp)
ffffffffc0200caa:	edee                	sd	s11,216(sp)
ffffffffc0200cac:	f1f2                	sd	t3,224(sp)
ffffffffc0200cae:	f5f6                	sd	t4,232(sp)
ffffffffc0200cb0:	f9fa                	sd	t5,240(sp)
ffffffffc0200cb2:	fdfe                	sd	t6,248(sp)
ffffffffc0200cb4:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200cb8:	100024f3          	csrr	s1,sstatus
ffffffffc0200cbc:	14102973          	csrr	s2,sepc
ffffffffc0200cc0:	143029f3          	csrr	s3,stval
ffffffffc0200cc4:	14202a73          	csrr	s4,scause
ffffffffc0200cc8:	e822                	sd	s0,16(sp)
ffffffffc0200cca:	e226                	sd	s1,256(sp)
ffffffffc0200ccc:	e64a                	sd	s2,264(sp)
ffffffffc0200cce:	ea4e                	sd	s3,272(sp)
ffffffffc0200cd0:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200cd2:	850a                	mv	a0,sp
    jal trap
ffffffffc0200cd4:	f0bff0ef          	jal	ra,ffffffffc0200bde <trap>

ffffffffc0200cd8 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200cd8:	6492                	ld	s1,256(sp)
ffffffffc0200cda:	6932                	ld	s2,264(sp)
ffffffffc0200cdc:	1004f413          	andi	s0,s1,256
ffffffffc0200ce0:	e401                	bnez	s0,ffffffffc0200ce8 <__trapret+0x10>
ffffffffc0200ce2:	1200                	addi	s0,sp,288
ffffffffc0200ce4:	14041073          	csrw	sscratch,s0
ffffffffc0200ce8:	10049073          	csrw	sstatus,s1
ffffffffc0200cec:	14191073          	csrw	sepc,s2
ffffffffc0200cf0:	60a2                	ld	ra,8(sp)
ffffffffc0200cf2:	61e2                	ld	gp,24(sp)
ffffffffc0200cf4:	7202                	ld	tp,32(sp)
ffffffffc0200cf6:	72a2                	ld	t0,40(sp)
ffffffffc0200cf8:	7342                	ld	t1,48(sp)
ffffffffc0200cfa:	73e2                	ld	t2,56(sp)
ffffffffc0200cfc:	6406                	ld	s0,64(sp)
ffffffffc0200cfe:	64a6                	ld	s1,72(sp)
ffffffffc0200d00:	6546                	ld	a0,80(sp)
ffffffffc0200d02:	65e6                	ld	a1,88(sp)
ffffffffc0200d04:	7606                	ld	a2,96(sp)
ffffffffc0200d06:	76a6                	ld	a3,104(sp)
ffffffffc0200d08:	7746                	ld	a4,112(sp)
ffffffffc0200d0a:	77e6                	ld	a5,120(sp)
ffffffffc0200d0c:	680a                	ld	a6,128(sp)
ffffffffc0200d0e:	68aa                	ld	a7,136(sp)
ffffffffc0200d10:	694a                	ld	s2,144(sp)
ffffffffc0200d12:	69ea                	ld	s3,152(sp)
ffffffffc0200d14:	7a0a                	ld	s4,160(sp)
ffffffffc0200d16:	7aaa                	ld	s5,168(sp)
ffffffffc0200d18:	7b4a                	ld	s6,176(sp)
ffffffffc0200d1a:	7bea                	ld	s7,184(sp)
ffffffffc0200d1c:	6c0e                	ld	s8,192(sp)
ffffffffc0200d1e:	6cae                	ld	s9,200(sp)
ffffffffc0200d20:	6d4e                	ld	s10,208(sp)
ffffffffc0200d22:	6dee                	ld	s11,216(sp)
ffffffffc0200d24:	7e0e                	ld	t3,224(sp)
ffffffffc0200d26:	7eae                	ld	t4,232(sp)
ffffffffc0200d28:	7f4e                	ld	t5,240(sp)
ffffffffc0200d2a:	7fee                	ld	t6,248(sp)
ffffffffc0200d2c:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200d2e:	10200073          	sret

ffffffffc0200d32 <forkrets>:
 
    .globl forkrets
forkrets:
    # set stack to this new process's trapframe
    move sp, a0
ffffffffc0200d32:	812a                	mv	sp,a0
    j __trapret
ffffffffc0200d34:	b755                	j	ffffffffc0200cd8 <__trapret>

ffffffffc0200d36 <check_vma_overlap.isra.0.part.0>:
}


// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next) {
ffffffffc0200d36:	1141                	addi	sp,sp,-16
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
ffffffffc0200d38:	00005697          	auipc	a3,0x5
ffffffffc0200d3c:	91068693          	addi	a3,a3,-1776 # ffffffffc0205648 <commands+0x6f8>
ffffffffc0200d40:	00004617          	auipc	a2,0x4
ffffffffc0200d44:	61860613          	addi	a2,a2,1560 # ffffffffc0205358 <commands+0x408>
ffffffffc0200d48:	06d00593          	li	a1,109
ffffffffc0200d4c:	00005517          	auipc	a0,0x5
ffffffffc0200d50:	91c50513          	addi	a0,a0,-1764 # ffffffffc0205668 <commands+0x718>
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next) {
ffffffffc0200d54:	e406                	sd	ra,8(sp)
    assert(next->vm_start < next->vm_end);
ffffffffc0200d56:	caeff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0200d5a <mm_create>:
mm_create(void) {
ffffffffc0200d5a:	1141                	addi	sp,sp,-16
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0200d5c:	04000513          	li	a0,64
mm_create(void) {
ffffffffc0200d60:	e022                	sd	s0,0(sp)
ffffffffc0200d62:	e406                	sd	ra,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0200d64:	2e9000ef          	jal	ra,ffffffffc020184c <kmalloc>
ffffffffc0200d68:	842a                	mv	s0,a0
    if (mm != NULL) {
ffffffffc0200d6a:	c505                	beqz	a0,ffffffffc0200d92 <mm_create+0x38>
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200d6c:	e408                	sd	a0,8(s0)
ffffffffc0200d6e:	e008                	sd	a0,0(s0)
        mm->mmap_cache = NULL;
ffffffffc0200d70:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc0200d74:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc0200d78:	02052023          	sw	zero,32(a0)
        if (swap_init_ok) swap_init_mm(mm);
ffffffffc0200d7c:	00053797          	auipc	a5,0x53
ffffffffc0200d80:	9547a783          	lw	a5,-1708(a5) # ffffffffc02536d0 <swap_init_ok>
ffffffffc0200d84:	ef81                	bnez	a5,ffffffffc0200d9c <mm_create+0x42>
        else mm->sm_priv = NULL;
ffffffffc0200d86:	02053423          	sd	zero,40(a0)
    return mm->mm_count;
}

static inline void
set_mm_count(struct mm_struct *mm, int val) {
    mm->mm_count = val;
ffffffffc0200d8a:	02042823          	sw	zero,48(s0)

typedef volatile bool lock_t;

static inline void
lock_init(lock_t *lock) {
    *lock = 0;
ffffffffc0200d8e:	02043c23          	sd	zero,56(s0)
}
ffffffffc0200d92:	60a2                	ld	ra,8(sp)
ffffffffc0200d94:	8522                	mv	a0,s0
ffffffffc0200d96:	6402                	ld	s0,0(sp)
ffffffffc0200d98:	0141                	addi	sp,sp,16
ffffffffc0200d9a:	8082                	ret
        if (swap_init_ok) swap_init_mm(mm);
ffffffffc0200d9c:	4dd000ef          	jal	ra,ffffffffc0201a78 <swap_init_mm>
ffffffffc0200da0:	b7ed                	j	ffffffffc0200d8a <mm_create+0x30>

ffffffffc0200da2 <find_vma>:
find_vma(struct mm_struct *mm, uintptr_t addr) {
ffffffffc0200da2:	86aa                	mv	a3,a0
    if (mm != NULL) {
ffffffffc0200da4:	c505                	beqz	a0,ffffffffc0200dcc <find_vma+0x2a>
        vma = mm->mmap_cache;
ffffffffc0200da6:	6908                	ld	a0,16(a0)
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr)) {
ffffffffc0200da8:	c501                	beqz	a0,ffffffffc0200db0 <find_vma+0xe>
ffffffffc0200daa:	651c                	ld	a5,8(a0)
ffffffffc0200dac:	02f5f263          	bgeu	a1,a5,ffffffffc0200dd0 <find_vma+0x2e>
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200db0:	669c                	ld	a5,8(a3)
                while ((le = list_next(le)) != list) {
ffffffffc0200db2:	00f68d63          	beq	a3,a5,ffffffffc0200dcc <find_vma+0x2a>
                    if (vma->vm_start<=addr && addr < vma->vm_end) {
ffffffffc0200db6:	fe87b703          	ld	a4,-24(a5)
ffffffffc0200dba:	00e5e663          	bltu	a1,a4,ffffffffc0200dc6 <find_vma+0x24>
ffffffffc0200dbe:	ff07b703          	ld	a4,-16(a5)
ffffffffc0200dc2:	00e5ec63          	bltu	a1,a4,ffffffffc0200dda <find_vma+0x38>
ffffffffc0200dc6:	679c                	ld	a5,8(a5)
                while ((le = list_next(le)) != list) {
ffffffffc0200dc8:	fef697e3          	bne	a3,a5,ffffffffc0200db6 <find_vma+0x14>
    struct vma_struct *vma = NULL;
ffffffffc0200dcc:	4501                	li	a0,0
}
ffffffffc0200dce:	8082                	ret
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr)) {
ffffffffc0200dd0:	691c                	ld	a5,16(a0)
ffffffffc0200dd2:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0200db0 <find_vma+0xe>
            mm->mmap_cache = vma;
ffffffffc0200dd6:	ea88                	sd	a0,16(a3)
ffffffffc0200dd8:	8082                	ret
                    vma = le2vma(le, list_link);
ffffffffc0200dda:	fe078513          	addi	a0,a5,-32
            mm->mmap_cache = vma;
ffffffffc0200dde:	ea88                	sd	a0,16(a3)
ffffffffc0200de0:	8082                	ret

ffffffffc0200de2 <insert_vma_struct>:


// insert_vma_struct -insert vma in mm's list link
void
insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma) {
    assert(vma->vm_start < vma->vm_end);
ffffffffc0200de2:	6590                	ld	a2,8(a1)
ffffffffc0200de4:	0105b803          	ld	a6,16(a1)
insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma) {
ffffffffc0200de8:	1141                	addi	sp,sp,-16
ffffffffc0200dea:	e406                	sd	ra,8(sp)
ffffffffc0200dec:	87aa                	mv	a5,a0
    assert(vma->vm_start < vma->vm_end);
ffffffffc0200dee:	01066763          	bltu	a2,a6,ffffffffc0200dfc <insert_vma_struct+0x1a>
ffffffffc0200df2:	a085                	j	ffffffffc0200e52 <insert_vma_struct+0x70>
    list_entry_t *le_prev = list, *le_next;

        list_entry_t *le = list;
        while ((le = list_next(le)) != list) {
            struct vma_struct *mmap_prev = le2vma(le, list_link);
            if (mmap_prev->vm_start > vma->vm_start) {
ffffffffc0200df4:	fe87b703          	ld	a4,-24(a5)
ffffffffc0200df8:	04e66863          	bltu	a2,a4,ffffffffc0200e48 <insert_vma_struct+0x66>
ffffffffc0200dfc:	86be                	mv	a3,a5
ffffffffc0200dfe:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list) {
ffffffffc0200e00:	fef51ae3          	bne	a0,a5,ffffffffc0200df4 <insert_vma_struct+0x12>
        }

    le_next = list_next(le_prev);

    /* check overlap */
    if (le_prev != list) {
ffffffffc0200e04:	02a68463          	beq	a3,a0,ffffffffc0200e2c <insert_vma_struct+0x4a>
        check_vma_overlap(le2vma(le_prev, list_link), vma);
ffffffffc0200e08:	ff06b703          	ld	a4,-16(a3)
    assert(prev->vm_start < prev->vm_end);
ffffffffc0200e0c:	fe86b883          	ld	a7,-24(a3)
ffffffffc0200e10:	08e8f163          	bgeu	a7,a4,ffffffffc0200e92 <insert_vma_struct+0xb0>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0200e14:	04e66f63          	bltu	a2,a4,ffffffffc0200e72 <insert_vma_struct+0x90>
    }
    if (le_next != list) {
ffffffffc0200e18:	00f50a63          	beq	a0,a5,ffffffffc0200e2c <insert_vma_struct+0x4a>
ffffffffc0200e1c:	fe87b703          	ld	a4,-24(a5)
    assert(prev->vm_end <= next->vm_start);
ffffffffc0200e20:	05076963          	bltu	a4,a6,ffffffffc0200e72 <insert_vma_struct+0x90>
    assert(next->vm_start < next->vm_end);
ffffffffc0200e24:	ff07b603          	ld	a2,-16(a5)
ffffffffc0200e28:	02c77363          	bgeu	a4,a2,ffffffffc0200e4e <insert_vma_struct+0x6c>
    }

    vma->vm_mm = mm;
    list_add_after(le_prev, &(vma->list_link));

    mm->map_count ++;
ffffffffc0200e2c:	5118                	lw	a4,32(a0)
    vma->vm_mm = mm;
ffffffffc0200e2e:	e188                	sd	a0,0(a1)
    list_add_after(le_prev, &(vma->list_link));
ffffffffc0200e30:	02058613          	addi	a2,a1,32
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc0200e34:	e390                	sd	a2,0(a5)
ffffffffc0200e36:	e690                	sd	a2,8(a3)
}
ffffffffc0200e38:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc0200e3a:	f59c                	sd	a5,40(a1)
    elm->prev = prev;
ffffffffc0200e3c:	f194                	sd	a3,32(a1)
    mm->map_count ++;
ffffffffc0200e3e:	0017079b          	addiw	a5,a4,1
ffffffffc0200e42:	d11c                	sw	a5,32(a0)
}
ffffffffc0200e44:	0141                	addi	sp,sp,16
ffffffffc0200e46:	8082                	ret
    if (le_prev != list) {
ffffffffc0200e48:	fca690e3          	bne	a3,a0,ffffffffc0200e08 <insert_vma_struct+0x26>
ffffffffc0200e4c:	bfd1                	j	ffffffffc0200e20 <insert_vma_struct+0x3e>
ffffffffc0200e4e:	ee9ff0ef          	jal	ra,ffffffffc0200d36 <check_vma_overlap.isra.0.part.0>
    assert(vma->vm_start < vma->vm_end);
ffffffffc0200e52:	00005697          	auipc	a3,0x5
ffffffffc0200e56:	82668693          	addi	a3,a3,-2010 # ffffffffc0205678 <commands+0x728>
ffffffffc0200e5a:	00004617          	auipc	a2,0x4
ffffffffc0200e5e:	4fe60613          	addi	a2,a2,1278 # ffffffffc0205358 <commands+0x408>
ffffffffc0200e62:	07400593          	li	a1,116
ffffffffc0200e66:	00005517          	auipc	a0,0x5
ffffffffc0200e6a:	80250513          	addi	a0,a0,-2046 # ffffffffc0205668 <commands+0x718>
ffffffffc0200e6e:	b96ff0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0200e72:	00005697          	auipc	a3,0x5
ffffffffc0200e76:	84668693          	addi	a3,a3,-1978 # ffffffffc02056b8 <commands+0x768>
ffffffffc0200e7a:	00004617          	auipc	a2,0x4
ffffffffc0200e7e:	4de60613          	addi	a2,a2,1246 # ffffffffc0205358 <commands+0x408>
ffffffffc0200e82:	06c00593          	li	a1,108
ffffffffc0200e86:	00004517          	auipc	a0,0x4
ffffffffc0200e8a:	7e250513          	addi	a0,a0,2018 # ffffffffc0205668 <commands+0x718>
ffffffffc0200e8e:	b76ff0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(prev->vm_start < prev->vm_end);
ffffffffc0200e92:	00005697          	auipc	a3,0x5
ffffffffc0200e96:	80668693          	addi	a3,a3,-2042 # ffffffffc0205698 <commands+0x748>
ffffffffc0200e9a:	00004617          	auipc	a2,0x4
ffffffffc0200e9e:	4be60613          	addi	a2,a2,1214 # ffffffffc0205358 <commands+0x408>
ffffffffc0200ea2:	06b00593          	li	a1,107
ffffffffc0200ea6:	00004517          	auipc	a0,0x4
ffffffffc0200eaa:	7c250513          	addi	a0,a0,1986 # ffffffffc0205668 <commands+0x718>
ffffffffc0200eae:	b56ff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0200eb2 <mm_destroy>:

// mm_destroy - free mm and mm internal fields
void
mm_destroy(struct mm_struct *mm) {
    assert(mm_count(mm) == 0);
ffffffffc0200eb2:	591c                	lw	a5,48(a0)
mm_destroy(struct mm_struct *mm) {
ffffffffc0200eb4:	1141                	addi	sp,sp,-16
ffffffffc0200eb6:	e406                	sd	ra,8(sp)
ffffffffc0200eb8:	e022                	sd	s0,0(sp)
    assert(mm_count(mm) == 0);
ffffffffc0200eba:	e78d                	bnez	a5,ffffffffc0200ee4 <mm_destroy+0x32>
ffffffffc0200ebc:	842a                	mv	s0,a0
    return listelm->next;
ffffffffc0200ebe:	6508                	ld	a0,8(a0)

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list) {
ffffffffc0200ec0:	00a40c63          	beq	s0,a0,ffffffffc0200ed8 <mm_destroy+0x26>
    __list_del(listelm->prev, listelm->next);
ffffffffc0200ec4:	6118                	ld	a4,0(a0)
ffffffffc0200ec6:	651c                	ld	a5,8(a0)
        list_del(le);
        kfree(le2vma(le, list_link));  //kfree vma        
ffffffffc0200ec8:	1501                	addi	a0,a0,-32
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0200eca:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc0200ecc:	e398                	sd	a4,0(a5)
ffffffffc0200ece:	22f000ef          	jal	ra,ffffffffc02018fc <kfree>
    return listelm->next;
ffffffffc0200ed2:	6408                	ld	a0,8(s0)
    while ((le = list_next(list)) != list) {
ffffffffc0200ed4:	fea418e3          	bne	s0,a0,ffffffffc0200ec4 <mm_destroy+0x12>
    }
    kfree(mm); //kfree mm
ffffffffc0200ed8:	8522                	mv	a0,s0
    mm=NULL;
}
ffffffffc0200eda:	6402                	ld	s0,0(sp)
ffffffffc0200edc:	60a2                	ld	ra,8(sp)
ffffffffc0200ede:	0141                	addi	sp,sp,16
    kfree(mm); //kfree mm
ffffffffc0200ee0:	21d0006f          	j	ffffffffc02018fc <kfree>
    assert(mm_count(mm) == 0);
ffffffffc0200ee4:	00004697          	auipc	a3,0x4
ffffffffc0200ee8:	7f468693          	addi	a3,a3,2036 # ffffffffc02056d8 <commands+0x788>
ffffffffc0200eec:	00004617          	auipc	a2,0x4
ffffffffc0200ef0:	46c60613          	addi	a2,a2,1132 # ffffffffc0205358 <commands+0x408>
ffffffffc0200ef4:	09400593          	li	a1,148
ffffffffc0200ef8:	00004517          	auipc	a0,0x4
ffffffffc0200efc:	77050513          	addi	a0,a0,1904 # ffffffffc0205668 <commands+0x718>
ffffffffc0200f00:	b04ff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0200f04 <mm_map>:

int
mm_map(struct mm_struct *mm, uintptr_t addr, size_t len, uint32_t vm_flags,
       struct vma_struct **vma_store) {
ffffffffc0200f04:	7139                	addi	sp,sp,-64
ffffffffc0200f06:	f822                	sd	s0,48(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0200f08:	6405                	lui	s0,0x1
ffffffffc0200f0a:	147d                	addi	s0,s0,-1
ffffffffc0200f0c:	77fd                	lui	a5,0xfffff
ffffffffc0200f0e:	9622                	add	a2,a2,s0
ffffffffc0200f10:	962e                	add	a2,a2,a1
       struct vma_struct **vma_store) {
ffffffffc0200f12:	f426                	sd	s1,40(sp)
ffffffffc0200f14:	fc06                	sd	ra,56(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0200f16:	00f5f4b3          	and	s1,a1,a5
       struct vma_struct **vma_store) {
ffffffffc0200f1a:	f04a                	sd	s2,32(sp)
ffffffffc0200f1c:	ec4e                	sd	s3,24(sp)
ffffffffc0200f1e:	e852                	sd	s4,16(sp)
ffffffffc0200f20:	e456                	sd	s5,8(sp)
    if (!USER_ACCESS(start, end)) {
ffffffffc0200f22:	002005b7          	lui	a1,0x200
ffffffffc0200f26:	00f67433          	and	s0,a2,a5
ffffffffc0200f2a:	06b4e363          	bltu	s1,a1,ffffffffc0200f90 <mm_map+0x8c>
ffffffffc0200f2e:	0684f163          	bgeu	s1,s0,ffffffffc0200f90 <mm_map+0x8c>
ffffffffc0200f32:	4785                	li	a5,1
ffffffffc0200f34:	07fe                	slli	a5,a5,0x1f
ffffffffc0200f36:	0487ed63          	bltu	a5,s0,ffffffffc0200f90 <mm_map+0x8c>
ffffffffc0200f3a:	89aa                	mv	s3,a0
        return -E_INVAL;
    }

    assert(mm != NULL);
ffffffffc0200f3c:	cd21                	beqz	a0,ffffffffc0200f94 <mm_map+0x90>

    int ret = -E_INVAL;

    struct vma_struct *vma;
    if ((vma = find_vma(mm, start)) != NULL && end > vma->vm_start) {
ffffffffc0200f3e:	85a6                	mv	a1,s1
ffffffffc0200f40:	8ab6                	mv	s5,a3
ffffffffc0200f42:	8a3a                	mv	s4,a4
ffffffffc0200f44:	e5fff0ef          	jal	ra,ffffffffc0200da2 <find_vma>
ffffffffc0200f48:	c501                	beqz	a0,ffffffffc0200f50 <mm_map+0x4c>
ffffffffc0200f4a:	651c                	ld	a5,8(a0)
ffffffffc0200f4c:	0487e263          	bltu	a5,s0,ffffffffc0200f90 <mm_map+0x8c>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0200f50:	03000513          	li	a0,48
ffffffffc0200f54:	0f9000ef          	jal	ra,ffffffffc020184c <kmalloc>
ffffffffc0200f58:	892a                	mv	s2,a0
        goto out;
    }
    ret = -E_NO_MEM;
ffffffffc0200f5a:	5571                	li	a0,-4
    if (vma != NULL) {
ffffffffc0200f5c:	02090163          	beqz	s2,ffffffffc0200f7e <mm_map+0x7a>

    if ((vma = vma_create(start, end, vm_flags)) == NULL) {
        goto out;
    }
    insert_vma_struct(mm, vma);
ffffffffc0200f60:	854e                	mv	a0,s3
        vma->vm_start = vm_start;
ffffffffc0200f62:	00993423          	sd	s1,8(s2)
        vma->vm_end = vm_end;
ffffffffc0200f66:	00893823          	sd	s0,16(s2)
        vma->vm_flags = vm_flags;
ffffffffc0200f6a:	01592c23          	sw	s5,24(s2)
    insert_vma_struct(mm, vma);
ffffffffc0200f6e:	85ca                	mv	a1,s2
ffffffffc0200f70:	e73ff0ef          	jal	ra,ffffffffc0200de2 <insert_vma_struct>
    if (vma_store != NULL) {
        *vma_store = vma;
    }
    ret = 0;
ffffffffc0200f74:	4501                	li	a0,0
    if (vma_store != NULL) {
ffffffffc0200f76:	000a0463          	beqz	s4,ffffffffc0200f7e <mm_map+0x7a>
        *vma_store = vma;
ffffffffc0200f7a:	012a3023          	sd	s2,0(s4)

out:
    return ret;
}
ffffffffc0200f7e:	70e2                	ld	ra,56(sp)
ffffffffc0200f80:	7442                	ld	s0,48(sp)
ffffffffc0200f82:	74a2                	ld	s1,40(sp)
ffffffffc0200f84:	7902                	ld	s2,32(sp)
ffffffffc0200f86:	69e2                	ld	s3,24(sp)
ffffffffc0200f88:	6a42                	ld	s4,16(sp)
ffffffffc0200f8a:	6aa2                	ld	s5,8(sp)
ffffffffc0200f8c:	6121                	addi	sp,sp,64
ffffffffc0200f8e:	8082                	ret
        return -E_INVAL;
ffffffffc0200f90:	5575                	li	a0,-3
ffffffffc0200f92:	b7f5                	j	ffffffffc0200f7e <mm_map+0x7a>
    assert(mm != NULL);
ffffffffc0200f94:	00004697          	auipc	a3,0x4
ffffffffc0200f98:	75c68693          	addi	a3,a3,1884 # ffffffffc02056f0 <commands+0x7a0>
ffffffffc0200f9c:	00004617          	auipc	a2,0x4
ffffffffc0200fa0:	3bc60613          	addi	a2,a2,956 # ffffffffc0205358 <commands+0x408>
ffffffffc0200fa4:	0a700593          	li	a1,167
ffffffffc0200fa8:	00004517          	auipc	a0,0x4
ffffffffc0200fac:	6c050513          	addi	a0,a0,1728 # ffffffffc0205668 <commands+0x718>
ffffffffc0200fb0:	a54ff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0200fb4 <dup_mmap>:

int
dup_mmap(struct mm_struct *to, struct mm_struct *from) {
ffffffffc0200fb4:	7139                	addi	sp,sp,-64
ffffffffc0200fb6:	fc06                	sd	ra,56(sp)
ffffffffc0200fb8:	f822                	sd	s0,48(sp)
ffffffffc0200fba:	f426                	sd	s1,40(sp)
ffffffffc0200fbc:	f04a                	sd	s2,32(sp)
ffffffffc0200fbe:	ec4e                	sd	s3,24(sp)
ffffffffc0200fc0:	e852                	sd	s4,16(sp)
ffffffffc0200fc2:	e456                	sd	s5,8(sp)
    assert(to != NULL && from != NULL);
ffffffffc0200fc4:	c52d                	beqz	a0,ffffffffc020102e <dup_mmap+0x7a>
ffffffffc0200fc6:	892a                	mv	s2,a0
ffffffffc0200fc8:	84ae                	mv	s1,a1
    list_entry_t *list = &(from->mmap_list), *le = list;
ffffffffc0200fca:	842e                	mv	s0,a1
    assert(to != NULL && from != NULL);
ffffffffc0200fcc:	e595                	bnez	a1,ffffffffc0200ff8 <dup_mmap+0x44>
ffffffffc0200fce:	a085                	j	ffffffffc020102e <dup_mmap+0x7a>
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
        if (nvma == NULL) {
            return -E_NO_MEM;
        }

        insert_vma_struct(to, nvma);
ffffffffc0200fd0:	854a                	mv	a0,s2
        vma->vm_start = vm_start;
ffffffffc0200fd2:	0155b423          	sd	s5,8(a1) # 200008 <_binary_obj___user_ex2_out_size+0x1f5298>
        vma->vm_end = vm_end;
ffffffffc0200fd6:	0145b823          	sd	s4,16(a1)
        vma->vm_flags = vm_flags;
ffffffffc0200fda:	0135ac23          	sw	s3,24(a1)
        insert_vma_struct(to, nvma);
ffffffffc0200fde:	e05ff0ef          	jal	ra,ffffffffc0200de2 <insert_vma_struct>

        bool share = 0;
        if (copy_range(to->pgdir, from->pgdir, vma->vm_start, vma->vm_end, share) != 0) {
ffffffffc0200fe2:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_obj___user_ex3_out_size-0x8a10>
ffffffffc0200fe6:	fe843603          	ld	a2,-24(s0)
ffffffffc0200fea:	6c8c                	ld	a1,24(s1)
ffffffffc0200fec:	01893503          	ld	a0,24(s2)
ffffffffc0200ff0:	4701                	li	a4,0
ffffffffc0200ff2:	5f9010ef          	jal	ra,ffffffffc0202dea <copy_range>
ffffffffc0200ff6:	e105                	bnez	a0,ffffffffc0201016 <dup_mmap+0x62>
    return listelm->prev;
ffffffffc0200ff8:	6000                	ld	s0,0(s0)
    while ((le = list_prev(le)) != list) {
ffffffffc0200ffa:	02848863          	beq	s1,s0,ffffffffc020102a <dup_mmap+0x76>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0200ffe:	03000513          	li	a0,48
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
ffffffffc0201002:	fe843a83          	ld	s5,-24(s0)
ffffffffc0201006:	ff043a03          	ld	s4,-16(s0)
ffffffffc020100a:	ff842983          	lw	s3,-8(s0)
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc020100e:	03f000ef          	jal	ra,ffffffffc020184c <kmalloc>
ffffffffc0201012:	85aa                	mv	a1,a0
    if (vma != NULL) {
ffffffffc0201014:	fd55                	bnez	a0,ffffffffc0200fd0 <dup_mmap+0x1c>
            return -E_NO_MEM;
ffffffffc0201016:	5571                	li	a0,-4
            return -E_NO_MEM;
        }
    }
    return 0;
}
ffffffffc0201018:	70e2                	ld	ra,56(sp)
ffffffffc020101a:	7442                	ld	s0,48(sp)
ffffffffc020101c:	74a2                	ld	s1,40(sp)
ffffffffc020101e:	7902                	ld	s2,32(sp)
ffffffffc0201020:	69e2                	ld	s3,24(sp)
ffffffffc0201022:	6a42                	ld	s4,16(sp)
ffffffffc0201024:	6aa2                	ld	s5,8(sp)
ffffffffc0201026:	6121                	addi	sp,sp,64
ffffffffc0201028:	8082                	ret
    return 0;
ffffffffc020102a:	4501                	li	a0,0
ffffffffc020102c:	b7f5                	j	ffffffffc0201018 <dup_mmap+0x64>
    assert(to != NULL && from != NULL);
ffffffffc020102e:	00004697          	auipc	a3,0x4
ffffffffc0201032:	6d268693          	addi	a3,a3,1746 # ffffffffc0205700 <commands+0x7b0>
ffffffffc0201036:	00004617          	auipc	a2,0x4
ffffffffc020103a:	32260613          	addi	a2,a2,802 # ffffffffc0205358 <commands+0x408>
ffffffffc020103e:	0c000593          	li	a1,192
ffffffffc0201042:	00004517          	auipc	a0,0x4
ffffffffc0201046:	62650513          	addi	a0,a0,1574 # ffffffffc0205668 <commands+0x718>
ffffffffc020104a:	9baff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020104e <exit_mmap>:

void
exit_mmap(struct mm_struct *mm) {
ffffffffc020104e:	1101                	addi	sp,sp,-32
ffffffffc0201050:	ec06                	sd	ra,24(sp)
ffffffffc0201052:	e822                	sd	s0,16(sp)
ffffffffc0201054:	e426                	sd	s1,8(sp)
ffffffffc0201056:	e04a                	sd	s2,0(sp)
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0201058:	c531                	beqz	a0,ffffffffc02010a4 <exit_mmap+0x56>
ffffffffc020105a:	591c                	lw	a5,48(a0)
ffffffffc020105c:	84aa                	mv	s1,a0
ffffffffc020105e:	e3b9                	bnez	a5,ffffffffc02010a4 <exit_mmap+0x56>
    return listelm->next;
ffffffffc0201060:	6500                	ld	s0,8(a0)
    pde_t *pgdir = mm->pgdir;
ffffffffc0201062:	01853903          	ld	s2,24(a0)
    list_entry_t *list = &(mm->mmap_list), *le = list;
    while ((le = list_next(le)) != list) {
ffffffffc0201066:	02850663          	beq	a0,s0,ffffffffc0201092 <exit_mmap+0x44>
        struct vma_struct *vma = le2vma(le, list_link);
        unmap_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc020106a:	ff043603          	ld	a2,-16(s0)
ffffffffc020106e:	fe843583          	ld	a1,-24(s0)
ffffffffc0201072:	854a                	mv	a0,s2
ffffffffc0201074:	2a7010ef          	jal	ra,ffffffffc0202b1a <unmap_range>
ffffffffc0201078:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list) {
ffffffffc020107a:	fe8498e3          	bne	s1,s0,ffffffffc020106a <exit_mmap+0x1c>
ffffffffc020107e:	6400                	ld	s0,8(s0)
    }
    while ((le = list_next(le)) != list) {
ffffffffc0201080:	00848c63          	beq	s1,s0,ffffffffc0201098 <exit_mmap+0x4a>
        struct vma_struct *vma = le2vma(le, list_link);
        exit_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0201084:	ff043603          	ld	a2,-16(s0)
ffffffffc0201088:	fe843583          	ld	a1,-24(s0)
ffffffffc020108c:	854a                	mv	a0,s2
ffffffffc020108e:	3a3010ef          	jal	ra,ffffffffc0202c30 <exit_range>
ffffffffc0201092:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list) {
ffffffffc0201094:	fe8498e3          	bne	s1,s0,ffffffffc0201084 <exit_mmap+0x36>
    }
}
ffffffffc0201098:	60e2                	ld	ra,24(sp)
ffffffffc020109a:	6442                	ld	s0,16(sp)
ffffffffc020109c:	64a2                	ld	s1,8(sp)
ffffffffc020109e:	6902                	ld	s2,0(sp)
ffffffffc02010a0:	6105                	addi	sp,sp,32
ffffffffc02010a2:	8082                	ret
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc02010a4:	00004697          	auipc	a3,0x4
ffffffffc02010a8:	67c68693          	addi	a3,a3,1660 # ffffffffc0205720 <commands+0x7d0>
ffffffffc02010ac:	00004617          	auipc	a2,0x4
ffffffffc02010b0:	2ac60613          	addi	a2,a2,684 # ffffffffc0205358 <commands+0x408>
ffffffffc02010b4:	0d600593          	li	a1,214
ffffffffc02010b8:	00004517          	auipc	a0,0x4
ffffffffc02010bc:	5b050513          	addi	a0,a0,1456 # ffffffffc0205668 <commands+0x718>
ffffffffc02010c0:	944ff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02010c4 <vmm_init>:
// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void
vmm_init(void) {
    //check_vmm();
}
ffffffffc02010c4:	8082                	ret

ffffffffc02010c6 <do_pgfault>:
 *            was a read (0) or write (1).
 *         -- The U/S flag (bit 2) indicates whether the processor was executing at user mode (1)
 *            or supervisor mode (0) at the time of the exception.
 */
int
do_pgfault(struct mm_struct *mm, uint_t error_code, uintptr_t addr) {
ffffffffc02010c6:	7139                	addi	sp,sp,-64
    int ret = -E_INVAL;
    //try to find a vma which include addr
    struct vma_struct *vma = find_vma(mm, addr);
ffffffffc02010c8:	85b2                	mv	a1,a2
do_pgfault(struct mm_struct *mm, uint_t error_code, uintptr_t addr) {
ffffffffc02010ca:	f822                	sd	s0,48(sp)
ffffffffc02010cc:	f426                	sd	s1,40(sp)
ffffffffc02010ce:	fc06                	sd	ra,56(sp)
ffffffffc02010d0:	f04a                	sd	s2,32(sp)
ffffffffc02010d2:	ec4e                	sd	s3,24(sp)
ffffffffc02010d4:	8432                	mv	s0,a2
ffffffffc02010d6:	84aa                	mv	s1,a0
    struct vma_struct *vma = find_vma(mm, addr);
ffffffffc02010d8:	ccbff0ef          	jal	ra,ffffffffc0200da2 <find_vma>

    pgfault_num++;
ffffffffc02010dc:	00052797          	auipc	a5,0x52
ffffffffc02010e0:	5dc7a783          	lw	a5,1500(a5) # ffffffffc02536b8 <pgfault_num>
ffffffffc02010e4:	2785                	addiw	a5,a5,1
ffffffffc02010e6:	00052717          	auipc	a4,0x52
ffffffffc02010ea:	5cf72923          	sw	a5,1490(a4) # ffffffffc02536b8 <pgfault_num>
    //If the addr is in the range of a mm's vma?
    if (vma == NULL || vma->vm_start > addr) {
ffffffffc02010ee:	c545                	beqz	a0,ffffffffc0201196 <do_pgfault+0xd0>
ffffffffc02010f0:	651c                	ld	a5,8(a0)
ffffffffc02010f2:	0af46263          	bltu	s0,a5,ffffffffc0201196 <do_pgfault+0xd0>
     *    (read  an non_existed addr && addr is readable)
     * THEN
     *    continue process
     */
    uint32_t perm = PTE_U;
    if (vma->vm_flags & VM_WRITE) {
ffffffffc02010f6:	4d1c                	lw	a5,24(a0)
    uint32_t perm = PTE_U;
ffffffffc02010f8:	49c1                	li	s3,16
    if (vma->vm_flags & VM_WRITE) {
ffffffffc02010fa:	8b89                	andi	a5,a5,2
ffffffffc02010fc:	efb1                	bnez	a5,ffffffffc0201158 <do_pgfault+0x92>
        perm |= READ_WRITE;
    }
    addr = ROUNDDOWN(addr, PGSIZE);
ffffffffc02010fe:	75fd                	lui	a1,0xfffff
    *   mm->pgdir : the PDT of these vma
    *
    */
    // try to find a pte, if pte's PT(Page Table) isn't existed, then create a PT.
    // (notice the 3th parameter '1')
    if ((ptep = get_pte(mm->pgdir, addr, 1)) == NULL) {
ffffffffc0201100:	6c88                	ld	a0,24(s1)
    addr = ROUNDDOWN(addr, PGSIZE);
ffffffffc0201102:	8c6d                	and	s0,s0,a1
    if ((ptep = get_pte(mm->pgdir, addr, 1)) == NULL) {
ffffffffc0201104:	4605                	li	a2,1
ffffffffc0201106:	85a2                	mv	a1,s0
ffffffffc0201108:	041010ef          	jal	ra,ffffffffc0202948 <get_pte>
ffffffffc020110c:	c555                	beqz	a0,ffffffffc02011b8 <do_pgfault+0xf2>
        cprintf("get_pte in do_pgfault failed\n");
        goto failed;
    }
    
    if (*ptep == 0) { // if the phy addr isn't exist, then alloc a page & map the phy addr with logical addr
ffffffffc020110e:	610c                	ld	a1,0(a0)
ffffffffc0201110:	c5a5                	beqz	a1,ffffffffc0201178 <do_pgfault+0xb2>
            goto failed;
        }
    }
    else { // if this pte is a swap entry, then load data from disk to a page with phy addr
           // and call page_insert to map the phy addr with logical addr
        if(swap_init_ok) {
ffffffffc0201112:	00052797          	auipc	a5,0x52
ffffffffc0201116:	5be7a783          	lw	a5,1470(a5) # ffffffffc02536d0 <swap_init_ok>
ffffffffc020111a:	c7d9                	beqz	a5,ffffffffc02011a8 <do_pgfault+0xe2>
            struct Page *page=NULL;
            if ((ret = swap_in(mm, addr, &page)) != 0) {
ffffffffc020111c:	0030                	addi	a2,sp,8
ffffffffc020111e:	85a2                	mv	a1,s0
ffffffffc0201120:	8526                	mv	a0,s1
            struct Page *page=NULL;
ffffffffc0201122:	e402                	sd	zero,8(sp)
            if ((ret = swap_in(mm, addr, &page)) != 0) {
ffffffffc0201124:	285000ef          	jal	ra,ffffffffc0201ba8 <swap_in>
ffffffffc0201128:	892a                	mv	s2,a0
ffffffffc020112a:	e90d                	bnez	a0,ffffffffc020115c <do_pgfault+0x96>
                cprintf("swap_in in do_pgfault failed\n");
                goto failed;
            }    
            page_insert(mm->pgdir, page, addr, perm);
ffffffffc020112c:	65a2                	ld	a1,8(sp)
ffffffffc020112e:	6c88                	ld	a0,24(s1)
ffffffffc0201130:	86ce                	mv	a3,s3
ffffffffc0201132:	8622                	mv	a2,s0
ffffffffc0201134:	3fb010ef          	jal	ra,ffffffffc0202d2e <page_insert>
            swap_map_swappable(mm, addr, page, 1);
ffffffffc0201138:	6622                	ld	a2,8(sp)
ffffffffc020113a:	4685                	li	a3,1
ffffffffc020113c:	85a2                	mv	a1,s0
ffffffffc020113e:	8526                	mv	a0,s1
ffffffffc0201140:	147000ef          	jal	ra,ffffffffc0201a86 <swap_map_swappable>
            page->pra_vaddr = addr;
ffffffffc0201144:	67a2                	ld	a5,8(sp)
ffffffffc0201146:	ff80                	sd	s0,56(a5)
        }
   }
   ret = 0;
failed:
    return ret;
}
ffffffffc0201148:	70e2                	ld	ra,56(sp)
ffffffffc020114a:	7442                	ld	s0,48(sp)
ffffffffc020114c:	74a2                	ld	s1,40(sp)
ffffffffc020114e:	69e2                	ld	s3,24(sp)
ffffffffc0201150:	854a                	mv	a0,s2
ffffffffc0201152:	7902                	ld	s2,32(sp)
ffffffffc0201154:	6121                	addi	sp,sp,64
ffffffffc0201156:	8082                	ret
        perm |= READ_WRITE;
ffffffffc0201158:	49dd                	li	s3,23
ffffffffc020115a:	b755                	j	ffffffffc02010fe <do_pgfault+0x38>
                cprintf("swap_in in do_pgfault failed\n");
ffffffffc020115c:	00004517          	auipc	a0,0x4
ffffffffc0201160:	65c50513          	addi	a0,a0,1628 # ffffffffc02057b8 <commands+0x868>
ffffffffc0201164:	f65fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
}
ffffffffc0201168:	70e2                	ld	ra,56(sp)
ffffffffc020116a:	7442                	ld	s0,48(sp)
ffffffffc020116c:	74a2                	ld	s1,40(sp)
ffffffffc020116e:	69e2                	ld	s3,24(sp)
ffffffffc0201170:	854a                	mv	a0,s2
ffffffffc0201172:	7902                	ld	s2,32(sp)
ffffffffc0201174:	6121                	addi	sp,sp,64
ffffffffc0201176:	8082                	ret
        if (pgdir_alloc_page(mm->pgdir, addr, perm) == NULL) {
ffffffffc0201178:	6c88                	ld	a0,24(s1)
ffffffffc020117a:	864e                	mv	a2,s3
ffffffffc020117c:	85a2                	mv	a1,s0
ffffffffc020117e:	6a3010ef          	jal	ra,ffffffffc0203020 <pgdir_alloc_page>
   ret = 0;
ffffffffc0201182:	4901                	li	s2,0
        if (pgdir_alloc_page(mm->pgdir, addr, perm) == NULL) {
ffffffffc0201184:	f171                	bnez	a0,ffffffffc0201148 <do_pgfault+0x82>
            cprintf("pgdir_alloc_page in do_pgfault failed\n");
ffffffffc0201186:	00004517          	auipc	a0,0x4
ffffffffc020118a:	60a50513          	addi	a0,a0,1546 # ffffffffc0205790 <commands+0x840>
ffffffffc020118e:	f3bfe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    ret = -E_NO_MEM;
ffffffffc0201192:	5971                	li	s2,-4
            goto failed;
ffffffffc0201194:	bf55                	j	ffffffffc0201148 <do_pgfault+0x82>
        cprintf("not valid addr %x, and  can not find it in vma\n", addr);
ffffffffc0201196:	85a2                	mv	a1,s0
ffffffffc0201198:	00004517          	auipc	a0,0x4
ffffffffc020119c:	5a850513          	addi	a0,a0,1448 # ffffffffc0205740 <commands+0x7f0>
ffffffffc02011a0:	f29fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    int ret = -E_INVAL;
ffffffffc02011a4:	5975                	li	s2,-3
        goto failed;
ffffffffc02011a6:	b74d                	j	ffffffffc0201148 <do_pgfault+0x82>
            cprintf("no swap_init_ok but ptep is %x, failed\n",*ptep);
ffffffffc02011a8:	00004517          	auipc	a0,0x4
ffffffffc02011ac:	63050513          	addi	a0,a0,1584 # ffffffffc02057d8 <commands+0x888>
ffffffffc02011b0:	f19fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    ret = -E_NO_MEM;
ffffffffc02011b4:	5971                	li	s2,-4
            goto failed;
ffffffffc02011b6:	bf49                	j	ffffffffc0201148 <do_pgfault+0x82>
        cprintf("get_pte in do_pgfault failed\n");
ffffffffc02011b8:	00004517          	auipc	a0,0x4
ffffffffc02011bc:	5b850513          	addi	a0,a0,1464 # ffffffffc0205770 <commands+0x820>
ffffffffc02011c0:	f09fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    ret = -E_NO_MEM;
ffffffffc02011c4:	5971                	li	s2,-4
        goto failed;
ffffffffc02011c6:	b749                	j	ffffffffc0201148 <do_pgfault+0x82>

ffffffffc02011c8 <user_mem_check>:

bool
user_mem_check(struct mm_struct *mm, uintptr_t addr, size_t len, bool write) {
ffffffffc02011c8:	7179                	addi	sp,sp,-48
ffffffffc02011ca:	f022                	sd	s0,32(sp)
ffffffffc02011cc:	f406                	sd	ra,40(sp)
ffffffffc02011ce:	ec26                	sd	s1,24(sp)
ffffffffc02011d0:	e84a                	sd	s2,16(sp)
ffffffffc02011d2:	e44e                	sd	s3,8(sp)
ffffffffc02011d4:	e052                	sd	s4,0(sp)
ffffffffc02011d6:	842e                	mv	s0,a1
    if (mm != NULL) {
ffffffffc02011d8:	c135                	beqz	a0,ffffffffc020123c <user_mem_check+0x74>
        if (!USER_ACCESS(addr, addr + len)) {
ffffffffc02011da:	002007b7          	lui	a5,0x200
ffffffffc02011de:	04f5e663          	bltu	a1,a5,ffffffffc020122a <user_mem_check+0x62>
ffffffffc02011e2:	00c584b3          	add	s1,a1,a2
ffffffffc02011e6:	0495f263          	bgeu	a1,s1,ffffffffc020122a <user_mem_check+0x62>
ffffffffc02011ea:	4785                	li	a5,1
ffffffffc02011ec:	07fe                	slli	a5,a5,0x1f
ffffffffc02011ee:	0297ee63          	bltu	a5,s1,ffffffffc020122a <user_mem_check+0x62>
ffffffffc02011f2:	892a                	mv	s2,a0
ffffffffc02011f4:	89b6                	mv	s3,a3
            }
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
                return 0;
            }
            if (write && (vma->vm_flags & VM_STACK)) {
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc02011f6:	6a05                	lui	s4,0x1
ffffffffc02011f8:	a821                	j	ffffffffc0201210 <user_mem_check+0x48>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc02011fa:	0027f693          	andi	a3,a5,2
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc02011fe:	9752                	add	a4,a4,s4
            if (write && (vma->vm_flags & VM_STACK)) {
ffffffffc0201200:	8ba1                	andi	a5,a5,8
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc0201202:	c685                	beqz	a3,ffffffffc020122a <user_mem_check+0x62>
            if (write && (vma->vm_flags & VM_STACK)) {
ffffffffc0201204:	c399                	beqz	a5,ffffffffc020120a <user_mem_check+0x42>
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc0201206:	02e46263          	bltu	s0,a4,ffffffffc020122a <user_mem_check+0x62>
                    return 0;
                }
            }
            start = vma->vm_end;
ffffffffc020120a:	6900                	ld	s0,16(a0)
        while (start < end) {
ffffffffc020120c:	04947663          	bgeu	s0,s1,ffffffffc0201258 <user_mem_check+0x90>
            if ((vma = find_vma(mm, start)) == NULL || start < vma->vm_start) {
ffffffffc0201210:	85a2                	mv	a1,s0
ffffffffc0201212:	854a                	mv	a0,s2
ffffffffc0201214:	b8fff0ef          	jal	ra,ffffffffc0200da2 <find_vma>
ffffffffc0201218:	c909                	beqz	a0,ffffffffc020122a <user_mem_check+0x62>
ffffffffc020121a:	6518                	ld	a4,8(a0)
ffffffffc020121c:	00e46763          	bltu	s0,a4,ffffffffc020122a <user_mem_check+0x62>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc0201220:	4d1c                	lw	a5,24(a0)
ffffffffc0201222:	fc099ce3          	bnez	s3,ffffffffc02011fa <user_mem_check+0x32>
ffffffffc0201226:	8b85                	andi	a5,a5,1
ffffffffc0201228:	f3ed                	bnez	a5,ffffffffc020120a <user_mem_check+0x42>
            return 0;
ffffffffc020122a:	4501                	li	a0,0
        }
        return 1;
    }
    return KERN_ACCESS(addr, addr + len);
}
ffffffffc020122c:	70a2                	ld	ra,40(sp)
ffffffffc020122e:	7402                	ld	s0,32(sp)
ffffffffc0201230:	64e2                	ld	s1,24(sp)
ffffffffc0201232:	6942                	ld	s2,16(sp)
ffffffffc0201234:	69a2                	ld	s3,8(sp)
ffffffffc0201236:	6a02                	ld	s4,0(sp)
ffffffffc0201238:	6145                	addi	sp,sp,48
ffffffffc020123a:	8082                	ret
    return KERN_ACCESS(addr, addr + len);
ffffffffc020123c:	c02007b7          	lui	a5,0xc0200
ffffffffc0201240:	4501                	li	a0,0
ffffffffc0201242:	fef5e5e3          	bltu	a1,a5,ffffffffc020122c <user_mem_check+0x64>
ffffffffc0201246:	962e                	add	a2,a2,a1
ffffffffc0201248:	fec5f2e3          	bgeu	a1,a2,ffffffffc020122c <user_mem_check+0x64>
ffffffffc020124c:	c8000537          	lui	a0,0xc8000
ffffffffc0201250:	0505                	addi	a0,a0,1
ffffffffc0201252:	00a63533          	sltu	a0,a2,a0
ffffffffc0201256:	bfd9                	j	ffffffffc020122c <user_mem_check+0x64>
        return 1;
ffffffffc0201258:	4505                	li	a0,1
ffffffffc020125a:	bfc9                	j	ffffffffc020122c <user_mem_check+0x64>

ffffffffc020125c <_fifo_init_mm>:
    elm->prev = elm->next = elm;
ffffffffc020125c:	00052797          	auipc	a5,0x52
ffffffffc0201260:	4cc78793          	addi	a5,a5,1228 # ffffffffc0253728 <pra_list_head>
 */
static int
_fifo_init_mm(struct mm_struct *mm)
{     
     list_init(&pra_list_head);
     mm->sm_priv = &pra_list_head;
ffffffffc0201264:	f51c                	sd	a5,40(a0)
ffffffffc0201266:	e79c                	sd	a5,8(a5)
ffffffffc0201268:	e39c                	sd	a5,0(a5)
     //cprintf(" mm->sm_priv %x in fifo_init_mm\n",mm->sm_priv);
     return 0;
}
ffffffffc020126a:	4501                	li	a0,0
ffffffffc020126c:	8082                	ret

ffffffffc020126e <_fifo_init>:

static int
_fifo_init(void)
{
    return 0;
}
ffffffffc020126e:	4501                	li	a0,0
ffffffffc0201270:	8082                	ret

ffffffffc0201272 <_fifo_set_unswappable>:

static int
_fifo_set_unswappable(struct mm_struct *mm, uintptr_t addr)
{
    return 0;
}
ffffffffc0201272:	4501                	li	a0,0
ffffffffc0201274:	8082                	ret

ffffffffc0201276 <_fifo_tick_event>:

static int
_fifo_tick_event(struct mm_struct *mm)
{ return 0; }
ffffffffc0201276:	4501                	li	a0,0
ffffffffc0201278:	8082                	ret

ffffffffc020127a <_fifo_check_swap>:
_fifo_check_swap(void) {
ffffffffc020127a:	711d                	addi	sp,sp,-96
ffffffffc020127c:	fc4e                	sd	s3,56(sp)
ffffffffc020127e:	f852                	sd	s4,48(sp)
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc0201280:	00004517          	auipc	a0,0x4
ffffffffc0201284:	58050513          	addi	a0,a0,1408 # ffffffffc0205800 <commands+0x8b0>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc0201288:	698d                	lui	s3,0x3
ffffffffc020128a:	4a31                	li	s4,12
_fifo_check_swap(void) {
ffffffffc020128c:	e0ca                	sd	s2,64(sp)
ffffffffc020128e:	ec86                	sd	ra,88(sp)
ffffffffc0201290:	e8a2                	sd	s0,80(sp)
ffffffffc0201292:	e4a6                	sd	s1,72(sp)
ffffffffc0201294:	f456                	sd	s5,40(sp)
ffffffffc0201296:	f05a                	sd	s6,32(sp)
ffffffffc0201298:	ec5e                	sd	s7,24(sp)
ffffffffc020129a:	e862                	sd	s8,16(sp)
ffffffffc020129c:	e466                	sd	s9,8(sp)
ffffffffc020129e:	e06a                	sd	s10,0(sp)
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc02012a0:	e29fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc02012a4:	01498023          	sb	s4,0(s3) # 3000 <_binary_obj___user_ex3_out_size-0x6a00>
    assert(pgfault_num==4);
ffffffffc02012a8:	00052917          	auipc	s2,0x52
ffffffffc02012ac:	41092903          	lw	s2,1040(s2) # ffffffffc02536b8 <pgfault_num>
ffffffffc02012b0:	4791                	li	a5,4
ffffffffc02012b2:	14f91e63          	bne	s2,a5,ffffffffc020140e <_fifo_check_swap+0x194>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc02012b6:	00004517          	auipc	a0,0x4
ffffffffc02012ba:	59a50513          	addi	a0,a0,1434 # ffffffffc0205850 <commands+0x900>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc02012be:	6a85                	lui	s5,0x1
ffffffffc02012c0:	4b29                	li	s6,10
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc02012c2:	e07fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc02012c6:	00052417          	auipc	s0,0x52
ffffffffc02012ca:	3f240413          	addi	s0,s0,1010 # ffffffffc02536b8 <pgfault_num>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc02012ce:	016a8023          	sb	s6,0(s5) # 1000 <_binary_obj___user_ex3_out_size-0x8a00>
    assert(pgfault_num==4);
ffffffffc02012d2:	4004                	lw	s1,0(s0)
ffffffffc02012d4:	2481                	sext.w	s1,s1
ffffffffc02012d6:	2b249c63          	bne	s1,s2,ffffffffc020158e <_fifo_check_swap+0x314>
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc02012da:	00004517          	auipc	a0,0x4
ffffffffc02012de:	59e50513          	addi	a0,a0,1438 # ffffffffc0205878 <commands+0x928>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc02012e2:	6b91                	lui	s7,0x4
ffffffffc02012e4:	4c35                	li	s8,13
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc02012e6:	de3fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc02012ea:	018b8023          	sb	s8,0(s7) # 4000 <_binary_obj___user_ex3_out_size-0x5a00>
    assert(pgfault_num==4);
ffffffffc02012ee:	00042903          	lw	s2,0(s0)
ffffffffc02012f2:	2901                	sext.w	s2,s2
ffffffffc02012f4:	26991d63          	bne	s2,s1,ffffffffc020156e <_fifo_check_swap+0x2f4>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc02012f8:	00004517          	auipc	a0,0x4
ffffffffc02012fc:	5a850513          	addi	a0,a0,1448 # ffffffffc02058a0 <commands+0x950>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc0201300:	6c89                	lui	s9,0x2
ffffffffc0201302:	4d2d                	li	s10,11
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc0201304:	dc5fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc0201308:	01ac8023          	sb	s10,0(s9) # 2000 <_binary_obj___user_ex3_out_size-0x7a00>
    assert(pgfault_num==4);
ffffffffc020130c:	401c                	lw	a5,0(s0)
ffffffffc020130e:	2781                	sext.w	a5,a5
ffffffffc0201310:	23279f63          	bne	a5,s2,ffffffffc020154e <_fifo_check_swap+0x2d4>
    cprintf("write Virt Page e in fifo_check_swap\n");
ffffffffc0201314:	00004517          	auipc	a0,0x4
ffffffffc0201318:	5b450513          	addi	a0,a0,1460 # ffffffffc02058c8 <commands+0x978>
ffffffffc020131c:	dadfe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x5000 = 0x0e;
ffffffffc0201320:	6795                	lui	a5,0x5
ffffffffc0201322:	4739                	li	a4,14
ffffffffc0201324:	00e78023          	sb	a4,0(a5) # 5000 <_binary_obj___user_ex3_out_size-0x4a00>
    assert(pgfault_num==5);
ffffffffc0201328:	4004                	lw	s1,0(s0)
ffffffffc020132a:	4795                	li	a5,5
ffffffffc020132c:	2481                	sext.w	s1,s1
ffffffffc020132e:	20f49063          	bne	s1,a5,ffffffffc020152e <_fifo_check_swap+0x2b4>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc0201332:	00004517          	auipc	a0,0x4
ffffffffc0201336:	56e50513          	addi	a0,a0,1390 # ffffffffc02058a0 <commands+0x950>
ffffffffc020133a:	d8ffe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc020133e:	01ac8023          	sb	s10,0(s9)
    assert(pgfault_num==5);
ffffffffc0201342:	401c                	lw	a5,0(s0)
ffffffffc0201344:	2781                	sext.w	a5,a5
ffffffffc0201346:	1c979463          	bne	a5,s1,ffffffffc020150e <_fifo_check_swap+0x294>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc020134a:	00004517          	auipc	a0,0x4
ffffffffc020134e:	50650513          	addi	a0,a0,1286 # ffffffffc0205850 <commands+0x900>
ffffffffc0201352:	d77fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc0201356:	016a8023          	sb	s6,0(s5)
    assert(pgfault_num==6);
ffffffffc020135a:	401c                	lw	a5,0(s0)
ffffffffc020135c:	4719                	li	a4,6
ffffffffc020135e:	2781                	sext.w	a5,a5
ffffffffc0201360:	18e79763          	bne	a5,a4,ffffffffc02014ee <_fifo_check_swap+0x274>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc0201364:	00004517          	auipc	a0,0x4
ffffffffc0201368:	53c50513          	addi	a0,a0,1340 # ffffffffc02058a0 <commands+0x950>
ffffffffc020136c:	d5dfe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc0201370:	01ac8023          	sb	s10,0(s9)
    assert(pgfault_num==7);
ffffffffc0201374:	401c                	lw	a5,0(s0)
ffffffffc0201376:	471d                	li	a4,7
ffffffffc0201378:	2781                	sext.w	a5,a5
ffffffffc020137a:	14e79a63          	bne	a5,a4,ffffffffc02014ce <_fifo_check_swap+0x254>
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc020137e:	00004517          	auipc	a0,0x4
ffffffffc0201382:	48250513          	addi	a0,a0,1154 # ffffffffc0205800 <commands+0x8b0>
ffffffffc0201386:	d43fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc020138a:	01498023          	sb	s4,0(s3)
    assert(pgfault_num==8);
ffffffffc020138e:	401c                	lw	a5,0(s0)
ffffffffc0201390:	4721                	li	a4,8
ffffffffc0201392:	2781                	sext.w	a5,a5
ffffffffc0201394:	10e79d63          	bne	a5,a4,ffffffffc02014ae <_fifo_check_swap+0x234>
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc0201398:	00004517          	auipc	a0,0x4
ffffffffc020139c:	4e050513          	addi	a0,a0,1248 # ffffffffc0205878 <commands+0x928>
ffffffffc02013a0:	d29fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc02013a4:	018b8023          	sb	s8,0(s7)
    assert(pgfault_num==9);
ffffffffc02013a8:	401c                	lw	a5,0(s0)
ffffffffc02013aa:	4725                	li	a4,9
ffffffffc02013ac:	2781                	sext.w	a5,a5
ffffffffc02013ae:	0ee79063          	bne	a5,a4,ffffffffc020148e <_fifo_check_swap+0x214>
    cprintf("write Virt Page e in fifo_check_swap\n");
ffffffffc02013b2:	00004517          	auipc	a0,0x4
ffffffffc02013b6:	51650513          	addi	a0,a0,1302 # ffffffffc02058c8 <commands+0x978>
ffffffffc02013ba:	d0ffe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x5000 = 0x0e;
ffffffffc02013be:	6795                	lui	a5,0x5
ffffffffc02013c0:	4739                	li	a4,14
ffffffffc02013c2:	00e78023          	sb	a4,0(a5) # 5000 <_binary_obj___user_ex3_out_size-0x4a00>
    assert(pgfault_num==10);
ffffffffc02013c6:	4004                	lw	s1,0(s0)
ffffffffc02013c8:	47a9                	li	a5,10
ffffffffc02013ca:	2481                	sext.w	s1,s1
ffffffffc02013cc:	0af49163          	bne	s1,a5,ffffffffc020146e <_fifo_check_swap+0x1f4>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc02013d0:	00004517          	auipc	a0,0x4
ffffffffc02013d4:	48050513          	addi	a0,a0,1152 # ffffffffc0205850 <commands+0x900>
ffffffffc02013d8:	cf1fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    assert(*(unsigned char *)0x1000 == 0x0a);
ffffffffc02013dc:	6785                	lui	a5,0x1
ffffffffc02013de:	0007c783          	lbu	a5,0(a5) # 1000 <_binary_obj___user_ex3_out_size-0x8a00>
ffffffffc02013e2:	06979663          	bne	a5,s1,ffffffffc020144e <_fifo_check_swap+0x1d4>
    assert(pgfault_num==11);
ffffffffc02013e6:	401c                	lw	a5,0(s0)
ffffffffc02013e8:	472d                	li	a4,11
ffffffffc02013ea:	2781                	sext.w	a5,a5
ffffffffc02013ec:	04e79163          	bne	a5,a4,ffffffffc020142e <_fifo_check_swap+0x1b4>
}
ffffffffc02013f0:	60e6                	ld	ra,88(sp)
ffffffffc02013f2:	6446                	ld	s0,80(sp)
ffffffffc02013f4:	64a6                	ld	s1,72(sp)
ffffffffc02013f6:	6906                	ld	s2,64(sp)
ffffffffc02013f8:	79e2                	ld	s3,56(sp)
ffffffffc02013fa:	7a42                	ld	s4,48(sp)
ffffffffc02013fc:	7aa2                	ld	s5,40(sp)
ffffffffc02013fe:	7b02                	ld	s6,32(sp)
ffffffffc0201400:	6be2                	ld	s7,24(sp)
ffffffffc0201402:	6c42                	ld	s8,16(sp)
ffffffffc0201404:	6ca2                	ld	s9,8(sp)
ffffffffc0201406:	6d02                	ld	s10,0(sp)
ffffffffc0201408:	4501                	li	a0,0
ffffffffc020140a:	6125                	addi	sp,sp,96
ffffffffc020140c:	8082                	ret
    assert(pgfault_num==4);
ffffffffc020140e:	00004697          	auipc	a3,0x4
ffffffffc0201412:	41a68693          	addi	a3,a3,1050 # ffffffffc0205828 <commands+0x8d8>
ffffffffc0201416:	00004617          	auipc	a2,0x4
ffffffffc020141a:	f4260613          	addi	a2,a2,-190 # ffffffffc0205358 <commands+0x408>
ffffffffc020141e:	05100593          	li	a1,81
ffffffffc0201422:	00004517          	auipc	a0,0x4
ffffffffc0201426:	41650513          	addi	a0,a0,1046 # ffffffffc0205838 <commands+0x8e8>
ffffffffc020142a:	ddbfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==11);
ffffffffc020142e:	00004697          	auipc	a3,0x4
ffffffffc0201432:	54a68693          	addi	a3,a3,1354 # ffffffffc0205978 <commands+0xa28>
ffffffffc0201436:	00004617          	auipc	a2,0x4
ffffffffc020143a:	f2260613          	addi	a2,a2,-222 # ffffffffc0205358 <commands+0x408>
ffffffffc020143e:	07300593          	li	a1,115
ffffffffc0201442:	00004517          	auipc	a0,0x4
ffffffffc0201446:	3f650513          	addi	a0,a0,1014 # ffffffffc0205838 <commands+0x8e8>
ffffffffc020144a:	dbbfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(*(unsigned char *)0x1000 == 0x0a);
ffffffffc020144e:	00004697          	auipc	a3,0x4
ffffffffc0201452:	50268693          	addi	a3,a3,1282 # ffffffffc0205950 <commands+0xa00>
ffffffffc0201456:	00004617          	auipc	a2,0x4
ffffffffc020145a:	f0260613          	addi	a2,a2,-254 # ffffffffc0205358 <commands+0x408>
ffffffffc020145e:	07100593          	li	a1,113
ffffffffc0201462:	00004517          	auipc	a0,0x4
ffffffffc0201466:	3d650513          	addi	a0,a0,982 # ffffffffc0205838 <commands+0x8e8>
ffffffffc020146a:	d9bfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==10);
ffffffffc020146e:	00004697          	auipc	a3,0x4
ffffffffc0201472:	4d268693          	addi	a3,a3,1234 # ffffffffc0205940 <commands+0x9f0>
ffffffffc0201476:	00004617          	auipc	a2,0x4
ffffffffc020147a:	ee260613          	addi	a2,a2,-286 # ffffffffc0205358 <commands+0x408>
ffffffffc020147e:	06f00593          	li	a1,111
ffffffffc0201482:	00004517          	auipc	a0,0x4
ffffffffc0201486:	3b650513          	addi	a0,a0,950 # ffffffffc0205838 <commands+0x8e8>
ffffffffc020148a:	d7bfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==9);
ffffffffc020148e:	00004697          	auipc	a3,0x4
ffffffffc0201492:	4a268693          	addi	a3,a3,1186 # ffffffffc0205930 <commands+0x9e0>
ffffffffc0201496:	00004617          	auipc	a2,0x4
ffffffffc020149a:	ec260613          	addi	a2,a2,-318 # ffffffffc0205358 <commands+0x408>
ffffffffc020149e:	06c00593          	li	a1,108
ffffffffc02014a2:	00004517          	auipc	a0,0x4
ffffffffc02014a6:	39650513          	addi	a0,a0,918 # ffffffffc0205838 <commands+0x8e8>
ffffffffc02014aa:	d5bfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==8);
ffffffffc02014ae:	00004697          	auipc	a3,0x4
ffffffffc02014b2:	47268693          	addi	a3,a3,1138 # ffffffffc0205920 <commands+0x9d0>
ffffffffc02014b6:	00004617          	auipc	a2,0x4
ffffffffc02014ba:	ea260613          	addi	a2,a2,-350 # ffffffffc0205358 <commands+0x408>
ffffffffc02014be:	06900593          	li	a1,105
ffffffffc02014c2:	00004517          	auipc	a0,0x4
ffffffffc02014c6:	37650513          	addi	a0,a0,886 # ffffffffc0205838 <commands+0x8e8>
ffffffffc02014ca:	d3bfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==7);
ffffffffc02014ce:	00004697          	auipc	a3,0x4
ffffffffc02014d2:	44268693          	addi	a3,a3,1090 # ffffffffc0205910 <commands+0x9c0>
ffffffffc02014d6:	00004617          	auipc	a2,0x4
ffffffffc02014da:	e8260613          	addi	a2,a2,-382 # ffffffffc0205358 <commands+0x408>
ffffffffc02014de:	06600593          	li	a1,102
ffffffffc02014e2:	00004517          	auipc	a0,0x4
ffffffffc02014e6:	35650513          	addi	a0,a0,854 # ffffffffc0205838 <commands+0x8e8>
ffffffffc02014ea:	d1bfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==6);
ffffffffc02014ee:	00004697          	auipc	a3,0x4
ffffffffc02014f2:	41268693          	addi	a3,a3,1042 # ffffffffc0205900 <commands+0x9b0>
ffffffffc02014f6:	00004617          	auipc	a2,0x4
ffffffffc02014fa:	e6260613          	addi	a2,a2,-414 # ffffffffc0205358 <commands+0x408>
ffffffffc02014fe:	06300593          	li	a1,99
ffffffffc0201502:	00004517          	auipc	a0,0x4
ffffffffc0201506:	33650513          	addi	a0,a0,822 # ffffffffc0205838 <commands+0x8e8>
ffffffffc020150a:	cfbfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==5);
ffffffffc020150e:	00004697          	auipc	a3,0x4
ffffffffc0201512:	3e268693          	addi	a3,a3,994 # ffffffffc02058f0 <commands+0x9a0>
ffffffffc0201516:	00004617          	auipc	a2,0x4
ffffffffc020151a:	e4260613          	addi	a2,a2,-446 # ffffffffc0205358 <commands+0x408>
ffffffffc020151e:	06000593          	li	a1,96
ffffffffc0201522:	00004517          	auipc	a0,0x4
ffffffffc0201526:	31650513          	addi	a0,a0,790 # ffffffffc0205838 <commands+0x8e8>
ffffffffc020152a:	cdbfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==5);
ffffffffc020152e:	00004697          	auipc	a3,0x4
ffffffffc0201532:	3c268693          	addi	a3,a3,962 # ffffffffc02058f0 <commands+0x9a0>
ffffffffc0201536:	00004617          	auipc	a2,0x4
ffffffffc020153a:	e2260613          	addi	a2,a2,-478 # ffffffffc0205358 <commands+0x408>
ffffffffc020153e:	05d00593          	li	a1,93
ffffffffc0201542:	00004517          	auipc	a0,0x4
ffffffffc0201546:	2f650513          	addi	a0,a0,758 # ffffffffc0205838 <commands+0x8e8>
ffffffffc020154a:	cbbfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==4);
ffffffffc020154e:	00004697          	auipc	a3,0x4
ffffffffc0201552:	2da68693          	addi	a3,a3,730 # ffffffffc0205828 <commands+0x8d8>
ffffffffc0201556:	00004617          	auipc	a2,0x4
ffffffffc020155a:	e0260613          	addi	a2,a2,-510 # ffffffffc0205358 <commands+0x408>
ffffffffc020155e:	05a00593          	li	a1,90
ffffffffc0201562:	00004517          	auipc	a0,0x4
ffffffffc0201566:	2d650513          	addi	a0,a0,726 # ffffffffc0205838 <commands+0x8e8>
ffffffffc020156a:	c9bfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==4);
ffffffffc020156e:	00004697          	auipc	a3,0x4
ffffffffc0201572:	2ba68693          	addi	a3,a3,698 # ffffffffc0205828 <commands+0x8d8>
ffffffffc0201576:	00004617          	auipc	a2,0x4
ffffffffc020157a:	de260613          	addi	a2,a2,-542 # ffffffffc0205358 <commands+0x408>
ffffffffc020157e:	05700593          	li	a1,87
ffffffffc0201582:	00004517          	auipc	a0,0x4
ffffffffc0201586:	2b650513          	addi	a0,a0,694 # ffffffffc0205838 <commands+0x8e8>
ffffffffc020158a:	c7bfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==4);
ffffffffc020158e:	00004697          	auipc	a3,0x4
ffffffffc0201592:	29a68693          	addi	a3,a3,666 # ffffffffc0205828 <commands+0x8d8>
ffffffffc0201596:	00004617          	auipc	a2,0x4
ffffffffc020159a:	dc260613          	addi	a2,a2,-574 # ffffffffc0205358 <commands+0x408>
ffffffffc020159e:	05400593          	li	a1,84
ffffffffc02015a2:	00004517          	auipc	a0,0x4
ffffffffc02015a6:	29650513          	addi	a0,a0,662 # ffffffffc0205838 <commands+0x8e8>
ffffffffc02015aa:	c5bfe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02015ae <_fifo_swap_out_victim>:
     list_entry_t *head=(list_entry_t*) mm->sm_priv;
ffffffffc02015ae:	751c                	ld	a5,40(a0)
{
ffffffffc02015b0:	1141                	addi	sp,sp,-16
ffffffffc02015b2:	e406                	sd	ra,8(sp)
         assert(head != NULL);
ffffffffc02015b4:	cf91                	beqz	a5,ffffffffc02015d0 <_fifo_swap_out_victim+0x22>
     assert(in_tick==0);
ffffffffc02015b6:	ee0d                	bnez	a2,ffffffffc02015f0 <_fifo_swap_out_victim+0x42>
    return listelm->next;
ffffffffc02015b8:	679c                	ld	a5,8(a5)
}
ffffffffc02015ba:	60a2                	ld	ra,8(sp)
ffffffffc02015bc:	4501                	li	a0,0
    __list_del(listelm->prev, listelm->next);
ffffffffc02015be:	6394                	ld	a3,0(a5)
ffffffffc02015c0:	6798                	ld	a4,8(a5)
    *ptr_page = le2page(entry, pra_page_link);
ffffffffc02015c2:	fd878793          	addi	a5,a5,-40
    prev->next = next;
ffffffffc02015c6:	e698                	sd	a4,8(a3)
    next->prev = prev;
ffffffffc02015c8:	e314                	sd	a3,0(a4)
ffffffffc02015ca:	e19c                	sd	a5,0(a1)
}
ffffffffc02015cc:	0141                	addi	sp,sp,16
ffffffffc02015ce:	8082                	ret
         assert(head != NULL);
ffffffffc02015d0:	00004697          	auipc	a3,0x4
ffffffffc02015d4:	3b868693          	addi	a3,a3,952 # ffffffffc0205988 <commands+0xa38>
ffffffffc02015d8:	00004617          	auipc	a2,0x4
ffffffffc02015dc:	d8060613          	addi	a2,a2,-640 # ffffffffc0205358 <commands+0x408>
ffffffffc02015e0:	04100593          	li	a1,65
ffffffffc02015e4:	00004517          	auipc	a0,0x4
ffffffffc02015e8:	25450513          	addi	a0,a0,596 # ffffffffc0205838 <commands+0x8e8>
ffffffffc02015ec:	c19fe0ef          	jal	ra,ffffffffc0200204 <__panic>
     assert(in_tick==0);
ffffffffc02015f0:	00004697          	auipc	a3,0x4
ffffffffc02015f4:	3a868693          	addi	a3,a3,936 # ffffffffc0205998 <commands+0xa48>
ffffffffc02015f8:	00004617          	auipc	a2,0x4
ffffffffc02015fc:	d6060613          	addi	a2,a2,-672 # ffffffffc0205358 <commands+0x408>
ffffffffc0201600:	04200593          	li	a1,66
ffffffffc0201604:	00004517          	auipc	a0,0x4
ffffffffc0201608:	23450513          	addi	a0,a0,564 # ffffffffc0205838 <commands+0x8e8>
ffffffffc020160c:	bf9fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201610 <_fifo_map_swappable>:
    list_entry_t *head=(list_entry_t*) mm->sm_priv;
ffffffffc0201610:	751c                	ld	a5,40(a0)
    assert(entry != NULL && head != NULL);
ffffffffc0201612:	cb91                	beqz	a5,ffffffffc0201626 <_fifo_map_swappable+0x16>
    __list_add(elm, listelm->prev, listelm);
ffffffffc0201614:	6394                	ld	a3,0(a5)
ffffffffc0201616:	02860713          	addi	a4,a2,40
    prev->next = next->prev = elm;
ffffffffc020161a:	e398                	sd	a4,0(a5)
ffffffffc020161c:	e698                	sd	a4,8(a3)
}
ffffffffc020161e:	4501                	li	a0,0
    elm->next = next;
ffffffffc0201620:	fa1c                	sd	a5,48(a2)
    elm->prev = prev;
ffffffffc0201622:	f614                	sd	a3,40(a2)
ffffffffc0201624:	8082                	ret
{
ffffffffc0201626:	1141                	addi	sp,sp,-16
    assert(entry != NULL && head != NULL);
ffffffffc0201628:	00004697          	auipc	a3,0x4
ffffffffc020162c:	38068693          	addi	a3,a3,896 # ffffffffc02059a8 <commands+0xa58>
ffffffffc0201630:	00004617          	auipc	a2,0x4
ffffffffc0201634:	d2860613          	addi	a2,a2,-728 # ffffffffc0205358 <commands+0x408>
ffffffffc0201638:	03200593          	li	a1,50
ffffffffc020163c:	00004517          	auipc	a0,0x4
ffffffffc0201640:	1fc50513          	addi	a0,a0,508 # ffffffffc0205838 <commands+0x8e8>
{
ffffffffc0201644:	e406                	sd	ra,8(sp)
    assert(entry != NULL && head != NULL);
ffffffffc0201646:	bbffe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020164a <slob_free>:
static void slob_free(void *block, int size)
{
	slob_t *cur, *b = (slob_t *)block;
	unsigned long flags;

	if (!block)
ffffffffc020164a:	c145                	beqz	a0,ffffffffc02016ea <slob_free+0xa0>
{
ffffffffc020164c:	1141                	addi	sp,sp,-16
ffffffffc020164e:	e022                	sd	s0,0(sp)
ffffffffc0201650:	e406                	sd	ra,8(sp)
ffffffffc0201652:	842a                	mv	s0,a0
		return;

	if (size)
ffffffffc0201654:	edb1                	bnez	a1,ffffffffc02016b0 <slob_free+0x66>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201656:	100027f3          	csrr	a5,sstatus
ffffffffc020165a:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020165c:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020165e:	e3ad                	bnez	a5,ffffffffc02016c0 <slob_free+0x76>
		b->units = SLOB_UNITS(size);

	/* Find reinsertion point */
	spin_lock_irqsave(&slob_lock, flags);
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201660:	00047617          	auipc	a2,0x47
ffffffffc0201664:	c1060613          	addi	a2,a2,-1008 # ffffffffc0248270 <slobfree>
ffffffffc0201668:	621c                	ld	a5,0(a2)
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc020166a:	6798                	ld	a4,8(a5)
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc020166c:	0087fa63          	bgeu	a5,s0,ffffffffc0201680 <slob_free+0x36>
ffffffffc0201670:	00e46c63          	bltu	s0,a4,ffffffffc0201688 <slob_free+0x3e>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201674:	00e7fa63          	bgeu	a5,a4,ffffffffc0201688 <slob_free+0x3e>
    return 0;
ffffffffc0201678:	87ba                	mv	a5,a4
ffffffffc020167a:	6798                	ld	a4,8(a5)
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc020167c:	fe87eae3          	bltu	a5,s0,ffffffffc0201670 <slob_free+0x26>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201680:	fee7ece3          	bltu	a5,a4,ffffffffc0201678 <slob_free+0x2e>
ffffffffc0201684:	fee47ae3          	bgeu	s0,a4,ffffffffc0201678 <slob_free+0x2e>
			break;

	if (b + b->units == cur->next) {
ffffffffc0201688:	400c                	lw	a1,0(s0)
ffffffffc020168a:	00459693          	slli	a3,a1,0x4
ffffffffc020168e:	96a2                	add	a3,a3,s0
ffffffffc0201690:	04d70763          	beq	a4,a3,ffffffffc02016de <slob_free+0x94>
		b->units += cur->next->units;
		b->next = cur->next->next;
	} else
		b->next = cur->next;
ffffffffc0201694:	e418                	sd	a4,8(s0)

	if (cur + cur->units == b) {
ffffffffc0201696:	4394                	lw	a3,0(a5)
ffffffffc0201698:	00469713          	slli	a4,a3,0x4
ffffffffc020169c:	973e                	add	a4,a4,a5
ffffffffc020169e:	02e40a63          	beq	s0,a4,ffffffffc02016d2 <slob_free+0x88>
		cur->units += b->units;
		cur->next = b->next;
	} else
		cur->next = b;
ffffffffc02016a2:	e780                	sd	s0,8(a5)

	slobfree = cur;
ffffffffc02016a4:	e21c                	sd	a5,0(a2)
    if (flag) {
ffffffffc02016a6:	e10d                	bnez	a0,ffffffffc02016c8 <slob_free+0x7e>

	spin_unlock_irqrestore(&slob_lock, flags);
}
ffffffffc02016a8:	60a2                	ld	ra,8(sp)
ffffffffc02016aa:	6402                	ld	s0,0(sp)
ffffffffc02016ac:	0141                	addi	sp,sp,16
ffffffffc02016ae:	8082                	ret
		b->units = SLOB_UNITS(size);
ffffffffc02016b0:	05bd                	addi	a1,a1,15
ffffffffc02016b2:	8191                	srli	a1,a1,0x4
ffffffffc02016b4:	c10c                	sw	a1,0(a0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02016b6:	100027f3          	csrr	a5,sstatus
ffffffffc02016ba:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02016bc:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02016be:	d3cd                	beqz	a5,ffffffffc0201660 <slob_free+0x16>
        intr_disable();
ffffffffc02016c0:	f73fe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc02016c4:	4505                	li	a0,1
ffffffffc02016c6:	bf69                	j	ffffffffc0201660 <slob_free+0x16>
}
ffffffffc02016c8:	6402                	ld	s0,0(sp)
ffffffffc02016ca:	60a2                	ld	ra,8(sp)
ffffffffc02016cc:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc02016ce:	f5ffe06f          	j	ffffffffc020062c <intr_enable>
		cur->units += b->units;
ffffffffc02016d2:	4018                	lw	a4,0(s0)
		cur->next = b->next;
ffffffffc02016d4:	640c                	ld	a1,8(s0)
		cur->units += b->units;
ffffffffc02016d6:	9eb9                	addw	a3,a3,a4
ffffffffc02016d8:	c394                	sw	a3,0(a5)
		cur->next = b->next;
ffffffffc02016da:	e78c                	sd	a1,8(a5)
ffffffffc02016dc:	b7e1                	j	ffffffffc02016a4 <slob_free+0x5a>
		b->units += cur->next->units;
ffffffffc02016de:	4314                	lw	a3,0(a4)
		b->next = cur->next->next;
ffffffffc02016e0:	6718                	ld	a4,8(a4)
		b->units += cur->next->units;
ffffffffc02016e2:	9db5                	addw	a1,a1,a3
ffffffffc02016e4:	c00c                	sw	a1,0(s0)
		b->next = cur->next->next;
ffffffffc02016e6:	e418                	sd	a4,8(s0)
ffffffffc02016e8:	b77d                	j	ffffffffc0201696 <slob_free+0x4c>
ffffffffc02016ea:	8082                	ret

ffffffffc02016ec <__slob_get_free_pages.isra.0>:
  struct Page * page = alloc_pages(1 << order);
ffffffffc02016ec:	4785                	li	a5,1
static void* __slob_get_free_pages(gfp_t gfp, int order)
ffffffffc02016ee:	1141                	addi	sp,sp,-16
  struct Page * page = alloc_pages(1 << order);
ffffffffc02016f0:	00a7953b          	sllw	a0,a5,a0
static void* __slob_get_free_pages(gfp_t gfp, int order)
ffffffffc02016f4:	e406                	sd	ra,8(sp)
  struct Page * page = alloc_pages(1 << order);
ffffffffc02016f6:	7ed000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
  if(!page)
ffffffffc02016fa:	c91d                	beqz	a0,ffffffffc0201730 <__slob_get_free_pages.isra.0+0x44>
extern size_t npage;
extern uint_t va_pa_offset;

static inline ppn_t
page2ppn(struct Page *page) {
    return page - pages + nbase;
ffffffffc02016fc:	00052697          	auipc	a3,0x52
ffffffffc0201700:	1346b683          	ld	a3,308(a3) # ffffffffc0253830 <pages>
ffffffffc0201704:	8d15                	sub	a0,a0,a3
ffffffffc0201706:	8519                	srai	a0,a0,0x6
ffffffffc0201708:	00006697          	auipc	a3,0x6
ffffffffc020170c:	af06b683          	ld	a3,-1296(a3) # ffffffffc02071f8 <nbase>
ffffffffc0201710:	9536                	add	a0,a0,a3
    return &pages[PPN(pa) - nbase];
}

static inline void *
page2kva(struct Page *page) {
    return KADDR(page2pa(page));
ffffffffc0201712:	00c51793          	slli	a5,a0,0xc
ffffffffc0201716:	83b1                	srli	a5,a5,0xc
ffffffffc0201718:	00052717          	auipc	a4,0x52
ffffffffc020171c:	fc873703          	ld	a4,-56(a4) # ffffffffc02536e0 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc0201720:	0532                	slli	a0,a0,0xc
    return KADDR(page2pa(page));
ffffffffc0201722:	00e7fa63          	bgeu	a5,a4,ffffffffc0201736 <__slob_get_free_pages.isra.0+0x4a>
ffffffffc0201726:	00052697          	auipc	a3,0x52
ffffffffc020172a:	0fa6b683          	ld	a3,250(a3) # ffffffffc0253820 <va_pa_offset>
ffffffffc020172e:	9536                	add	a0,a0,a3
}
ffffffffc0201730:	60a2                	ld	ra,8(sp)
ffffffffc0201732:	0141                	addi	sp,sp,16
ffffffffc0201734:	8082                	ret
ffffffffc0201736:	86aa                	mv	a3,a0
ffffffffc0201738:	00004617          	auipc	a2,0x4
ffffffffc020173c:	2a860613          	addi	a2,a2,680 # ffffffffc02059e0 <commands+0xa90>
ffffffffc0201740:	06900593          	li	a1,105
ffffffffc0201744:	00004517          	auipc	a0,0x4
ffffffffc0201748:	2c450513          	addi	a0,a0,708 # ffffffffc0205a08 <commands+0xab8>
ffffffffc020174c:	ab9fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201750 <slob_alloc.isra.0.constprop.0>:
static void *slob_alloc(size_t size, gfp_t gfp, int align)
ffffffffc0201750:	1101                	addi	sp,sp,-32
ffffffffc0201752:	ec06                	sd	ra,24(sp)
ffffffffc0201754:	e822                	sd	s0,16(sp)
ffffffffc0201756:	e426                	sd	s1,8(sp)
ffffffffc0201758:	e04a                	sd	s2,0(sp)
  assert( (size + SLOB_UNIT) < PAGE_SIZE );
ffffffffc020175a:	01050713          	addi	a4,a0,16
ffffffffc020175e:	6785                	lui	a5,0x1
ffffffffc0201760:	0cf77363          	bgeu	a4,a5,ffffffffc0201826 <slob_alloc.isra.0.constprop.0+0xd6>
	int delta = 0, units = SLOB_UNITS(size);
ffffffffc0201764:	00f50493          	addi	s1,a0,15
ffffffffc0201768:	8091                	srli	s1,s1,0x4
ffffffffc020176a:	2481                	sext.w	s1,s1
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020176c:	10002673          	csrr	a2,sstatus
ffffffffc0201770:	8a09                	andi	a2,a2,2
ffffffffc0201772:	e25d                	bnez	a2,ffffffffc0201818 <slob_alloc.isra.0.constprop.0+0xc8>
	prev = slobfree;
ffffffffc0201774:	00047917          	auipc	s2,0x47
ffffffffc0201778:	afc90913          	addi	s2,s2,-1284 # ffffffffc0248270 <slobfree>
ffffffffc020177c:	00093683          	ld	a3,0(s2)
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc0201780:	669c                	ld	a5,8(a3)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc0201782:	4398                	lw	a4,0(a5)
ffffffffc0201784:	08975e63          	bge	a4,s1,ffffffffc0201820 <slob_alloc.isra.0.constprop.0+0xd0>
		if (cur == slobfree) {
ffffffffc0201788:	00d78b63          	beq	a5,a3,ffffffffc020179e <slob_alloc.isra.0.constprop.0+0x4e>
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc020178c:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc020178e:	4018                	lw	a4,0(s0)
ffffffffc0201790:	02975a63          	bge	a4,s1,ffffffffc02017c4 <slob_alloc.isra.0.constprop.0+0x74>
ffffffffc0201794:	00093683          	ld	a3,0(s2)
ffffffffc0201798:	87a2                	mv	a5,s0
		if (cur == slobfree) {
ffffffffc020179a:	fed799e3          	bne	a5,a3,ffffffffc020178c <slob_alloc.isra.0.constprop.0+0x3c>
    if (flag) {
ffffffffc020179e:	ee31                	bnez	a2,ffffffffc02017fa <slob_alloc.isra.0.constprop.0+0xaa>
			cur = (slob_t *)__slob_get_free_page(gfp);
ffffffffc02017a0:	4501                	li	a0,0
ffffffffc02017a2:	f4bff0ef          	jal	ra,ffffffffc02016ec <__slob_get_free_pages.isra.0>
ffffffffc02017a6:	842a                	mv	s0,a0
			if (!cur)
ffffffffc02017a8:	cd05                	beqz	a0,ffffffffc02017e0 <slob_alloc.isra.0.constprop.0+0x90>
			slob_free(cur, PAGE_SIZE);
ffffffffc02017aa:	6585                	lui	a1,0x1
ffffffffc02017ac:	e9fff0ef          	jal	ra,ffffffffc020164a <slob_free>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02017b0:	10002673          	csrr	a2,sstatus
ffffffffc02017b4:	8a09                	andi	a2,a2,2
ffffffffc02017b6:	ee05                	bnez	a2,ffffffffc02017ee <slob_alloc.isra.0.constprop.0+0x9e>
			cur = slobfree;
ffffffffc02017b8:	00093783          	ld	a5,0(s2)
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc02017bc:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc02017be:	4018                	lw	a4,0(s0)
ffffffffc02017c0:	fc974ae3          	blt	a4,s1,ffffffffc0201794 <slob_alloc.isra.0.constprop.0+0x44>
			if (cur->units == units) /* exact fit? */
ffffffffc02017c4:	04e48763          	beq	s1,a4,ffffffffc0201812 <slob_alloc.isra.0.constprop.0+0xc2>
				prev->next = cur + units;
ffffffffc02017c8:	00449693          	slli	a3,s1,0x4
ffffffffc02017cc:	96a2                	add	a3,a3,s0
ffffffffc02017ce:	e794                	sd	a3,8(a5)
				prev->next->next = cur->next;
ffffffffc02017d0:	640c                	ld	a1,8(s0)
				prev->next->units = cur->units - units;
ffffffffc02017d2:	9f05                	subw	a4,a4,s1
ffffffffc02017d4:	c298                	sw	a4,0(a3)
				prev->next->next = cur->next;
ffffffffc02017d6:	e68c                	sd	a1,8(a3)
				cur->units = units;
ffffffffc02017d8:	c004                	sw	s1,0(s0)
			slobfree = prev;
ffffffffc02017da:	00f93023          	sd	a5,0(s2)
    if (flag) {
ffffffffc02017de:	e20d                	bnez	a2,ffffffffc0201800 <slob_alloc.isra.0.constprop.0+0xb0>
}
ffffffffc02017e0:	60e2                	ld	ra,24(sp)
ffffffffc02017e2:	8522                	mv	a0,s0
ffffffffc02017e4:	6442                	ld	s0,16(sp)
ffffffffc02017e6:	64a2                	ld	s1,8(sp)
ffffffffc02017e8:	6902                	ld	s2,0(sp)
ffffffffc02017ea:	6105                	addi	sp,sp,32
ffffffffc02017ec:	8082                	ret
        intr_disable();
ffffffffc02017ee:	e45fe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
			cur = slobfree;
ffffffffc02017f2:	00093783          	ld	a5,0(s2)
        return 1;
ffffffffc02017f6:	4605                	li	a2,1
ffffffffc02017f8:	b7d1                	j	ffffffffc02017bc <slob_alloc.isra.0.constprop.0+0x6c>
        intr_enable();
ffffffffc02017fa:	e33fe0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc02017fe:	b74d                	j	ffffffffc02017a0 <slob_alloc.isra.0.constprop.0+0x50>
ffffffffc0201800:	e2dfe0ef          	jal	ra,ffffffffc020062c <intr_enable>
}
ffffffffc0201804:	60e2                	ld	ra,24(sp)
ffffffffc0201806:	8522                	mv	a0,s0
ffffffffc0201808:	6442                	ld	s0,16(sp)
ffffffffc020180a:	64a2                	ld	s1,8(sp)
ffffffffc020180c:	6902                	ld	s2,0(sp)
ffffffffc020180e:	6105                	addi	sp,sp,32
ffffffffc0201810:	8082                	ret
				prev->next = cur->next; /* unlink */
ffffffffc0201812:	6418                	ld	a4,8(s0)
ffffffffc0201814:	e798                	sd	a4,8(a5)
ffffffffc0201816:	b7d1                	j	ffffffffc02017da <slob_alloc.isra.0.constprop.0+0x8a>
        intr_disable();
ffffffffc0201818:	e1bfe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc020181c:	4605                	li	a2,1
ffffffffc020181e:	bf99                	j	ffffffffc0201774 <slob_alloc.isra.0.constprop.0+0x24>
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc0201820:	843e                	mv	s0,a5
ffffffffc0201822:	87b6                	mv	a5,a3
ffffffffc0201824:	b745                	j	ffffffffc02017c4 <slob_alloc.isra.0.constprop.0+0x74>
  assert( (size + SLOB_UNIT) < PAGE_SIZE );
ffffffffc0201826:	00004697          	auipc	a3,0x4
ffffffffc020182a:	1f268693          	addi	a3,a3,498 # ffffffffc0205a18 <commands+0xac8>
ffffffffc020182e:	00004617          	auipc	a2,0x4
ffffffffc0201832:	b2a60613          	addi	a2,a2,-1238 # ffffffffc0205358 <commands+0x408>
ffffffffc0201836:	06400593          	li	a1,100
ffffffffc020183a:	00004517          	auipc	a0,0x4
ffffffffc020183e:	1fe50513          	addi	a0,a0,510 # ffffffffc0205a38 <commands+0xae8>
ffffffffc0201842:	9c3fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201846 <kmalloc_init>:

inline void 
kmalloc_init(void) {
    slob_init();
    //cprintf("kmalloc_init() succeeded!\n");
}
ffffffffc0201846:	8082                	ret

ffffffffc0201848 <kallocated>:
}

size_t
kallocated(void) {
   return slob_allocated();
}
ffffffffc0201848:	4501                	li	a0,0
ffffffffc020184a:	8082                	ret

ffffffffc020184c <kmalloc>:
	return 0;
}

void *
kmalloc(size_t size)
{
ffffffffc020184c:	1101                	addi	sp,sp,-32
ffffffffc020184e:	e04a                	sd	s2,0(sp)
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc0201850:	6905                	lui	s2,0x1
{
ffffffffc0201852:	e822                	sd	s0,16(sp)
ffffffffc0201854:	ec06                	sd	ra,24(sp)
ffffffffc0201856:	e426                	sd	s1,8(sp)
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc0201858:	fef90793          	addi	a5,s2,-17 # fef <_binary_obj___user_ex3_out_size-0x8a11>
{
ffffffffc020185c:	842a                	mv	s0,a0
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc020185e:	04a7f963          	bgeu	a5,a0,ffffffffc02018b0 <kmalloc+0x64>
	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
ffffffffc0201862:	4561                	li	a0,24
ffffffffc0201864:	eedff0ef          	jal	ra,ffffffffc0201750 <slob_alloc.isra.0.constprop.0>
ffffffffc0201868:	84aa                	mv	s1,a0
	if (!bb)
ffffffffc020186a:	c929                	beqz	a0,ffffffffc02018bc <kmalloc+0x70>
	bb->order = find_order(size);
ffffffffc020186c:	0004079b          	sext.w	a5,s0
	int order = 0;
ffffffffc0201870:	4501                	li	a0,0
	for ( ; size > 4096 ; size >>=1)
ffffffffc0201872:	00f95763          	bge	s2,a5,ffffffffc0201880 <kmalloc+0x34>
ffffffffc0201876:	6705                	lui	a4,0x1
ffffffffc0201878:	8785                	srai	a5,a5,0x1
		order++;
ffffffffc020187a:	2505                	addiw	a0,a0,1
	for ( ; size > 4096 ; size >>=1)
ffffffffc020187c:	fef74ee3          	blt	a4,a5,ffffffffc0201878 <kmalloc+0x2c>
	bb->order = find_order(size);
ffffffffc0201880:	c088                	sw	a0,0(s1)
	bb->pages = (void *)__slob_get_free_pages(gfp, bb->order);
ffffffffc0201882:	e6bff0ef          	jal	ra,ffffffffc02016ec <__slob_get_free_pages.isra.0>
ffffffffc0201886:	e488                	sd	a0,8(s1)
ffffffffc0201888:	842a                	mv	s0,a0
	if (bb->pages) {
ffffffffc020188a:	c525                	beqz	a0,ffffffffc02018f2 <kmalloc+0xa6>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020188c:	100027f3          	csrr	a5,sstatus
ffffffffc0201890:	8b89                	andi	a5,a5,2
ffffffffc0201892:	ef8d                	bnez	a5,ffffffffc02018cc <kmalloc+0x80>
		bb->next = bigblocks;
ffffffffc0201894:	00052797          	auipc	a5,0x52
ffffffffc0201898:	e2c78793          	addi	a5,a5,-468 # ffffffffc02536c0 <bigblocks>
ffffffffc020189c:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc020189e:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc02018a0:	e898                	sd	a4,16(s1)
  return __kmalloc(size, 0);
}
ffffffffc02018a2:	60e2                	ld	ra,24(sp)
ffffffffc02018a4:	8522                	mv	a0,s0
ffffffffc02018a6:	6442                	ld	s0,16(sp)
ffffffffc02018a8:	64a2                	ld	s1,8(sp)
ffffffffc02018aa:	6902                	ld	s2,0(sp)
ffffffffc02018ac:	6105                	addi	sp,sp,32
ffffffffc02018ae:	8082                	ret
		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
ffffffffc02018b0:	0541                	addi	a0,a0,16
ffffffffc02018b2:	e9fff0ef          	jal	ra,ffffffffc0201750 <slob_alloc.isra.0.constprop.0>
		return m ? (void *)(m + 1) : 0;
ffffffffc02018b6:	01050413          	addi	s0,a0,16
ffffffffc02018ba:	f565                	bnez	a0,ffffffffc02018a2 <kmalloc+0x56>
ffffffffc02018bc:	4401                	li	s0,0
}
ffffffffc02018be:	60e2                	ld	ra,24(sp)
ffffffffc02018c0:	8522                	mv	a0,s0
ffffffffc02018c2:	6442                	ld	s0,16(sp)
ffffffffc02018c4:	64a2                	ld	s1,8(sp)
ffffffffc02018c6:	6902                	ld	s2,0(sp)
ffffffffc02018c8:	6105                	addi	sp,sp,32
ffffffffc02018ca:	8082                	ret
        intr_disable();
ffffffffc02018cc:	d67fe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
		bb->next = bigblocks;
ffffffffc02018d0:	00052797          	auipc	a5,0x52
ffffffffc02018d4:	df078793          	addi	a5,a5,-528 # ffffffffc02536c0 <bigblocks>
ffffffffc02018d8:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc02018da:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc02018dc:	e898                	sd	a4,16(s1)
        intr_enable();
ffffffffc02018de:	d4ffe0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc02018e2:	6480                	ld	s0,8(s1)
}
ffffffffc02018e4:	60e2                	ld	ra,24(sp)
ffffffffc02018e6:	64a2                	ld	s1,8(sp)
ffffffffc02018e8:	8522                	mv	a0,s0
ffffffffc02018ea:	6442                	ld	s0,16(sp)
ffffffffc02018ec:	6902                	ld	s2,0(sp)
ffffffffc02018ee:	6105                	addi	sp,sp,32
ffffffffc02018f0:	8082                	ret
	slob_free(bb, sizeof(bigblock_t));
ffffffffc02018f2:	45e1                	li	a1,24
ffffffffc02018f4:	8526                	mv	a0,s1
ffffffffc02018f6:	d55ff0ef          	jal	ra,ffffffffc020164a <slob_free>
  return __kmalloc(size, 0);
ffffffffc02018fa:	b765                	j	ffffffffc02018a2 <kmalloc+0x56>

ffffffffc02018fc <kfree>:
void kfree(void *block)
{
	bigblock_t *bb, **last = &bigblocks;
	unsigned long flags;

	if (!block)
ffffffffc02018fc:	c169                	beqz	a0,ffffffffc02019be <kfree+0xc2>
{
ffffffffc02018fe:	1101                	addi	sp,sp,-32
ffffffffc0201900:	e822                	sd	s0,16(sp)
ffffffffc0201902:	ec06                	sd	ra,24(sp)
ffffffffc0201904:	e426                	sd	s1,8(sp)
		return;

	if (!((unsigned long)block & (PAGE_SIZE-1))) {
ffffffffc0201906:	03451793          	slli	a5,a0,0x34
ffffffffc020190a:	842a                	mv	s0,a0
ffffffffc020190c:	e7c9                	bnez	a5,ffffffffc0201996 <kfree+0x9a>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020190e:	100027f3          	csrr	a5,sstatus
ffffffffc0201912:	8b89                	andi	a5,a5,2
ffffffffc0201914:	ebc9                	bnez	a5,ffffffffc02019a6 <kfree+0xaa>
		/* might be on the big block list */
		spin_lock_irqsave(&block_lock, flags);
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc0201916:	00052797          	auipc	a5,0x52
ffffffffc020191a:	daa7b783          	ld	a5,-598(a5) # ffffffffc02536c0 <bigblocks>
    return 0;
ffffffffc020191e:	4601                	li	a2,0
ffffffffc0201920:	cbbd                	beqz	a5,ffffffffc0201996 <kfree+0x9a>
	bigblock_t *bb, **last = &bigblocks;
ffffffffc0201922:	00052697          	auipc	a3,0x52
ffffffffc0201926:	d9e68693          	addi	a3,a3,-610 # ffffffffc02536c0 <bigblocks>
ffffffffc020192a:	a021                	j	ffffffffc0201932 <kfree+0x36>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc020192c:	01048693          	addi	a3,s1,16
ffffffffc0201930:	c3a5                	beqz	a5,ffffffffc0201990 <kfree+0x94>
			if (bb->pages == block) {
ffffffffc0201932:	6798                	ld	a4,8(a5)
ffffffffc0201934:	84be                	mv	s1,a5
ffffffffc0201936:	6b9c                	ld	a5,16(a5)
ffffffffc0201938:	fe871ae3          	bne	a4,s0,ffffffffc020192c <kfree+0x30>
				*last = bb->next;
ffffffffc020193c:	e29c                	sd	a5,0(a3)
    if (flag) {
ffffffffc020193e:	ee2d                	bnez	a2,ffffffffc02019b8 <kfree+0xbc>
}

static inline struct Page *
kva2page(void *kva) {
    return pa2page(PADDR(kva));
ffffffffc0201940:	c02007b7          	lui	a5,0xc0200
				spin_unlock_irqrestore(&block_lock, flags);
				__slob_free_pages((unsigned long)block, bb->order);
ffffffffc0201944:	4098                	lw	a4,0(s1)
ffffffffc0201946:	08f46963          	bltu	s0,a5,ffffffffc02019d8 <kfree+0xdc>
ffffffffc020194a:	00052697          	auipc	a3,0x52
ffffffffc020194e:	ed66b683          	ld	a3,-298(a3) # ffffffffc0253820 <va_pa_offset>
ffffffffc0201952:	8c15                	sub	s0,s0,a3
    if (PPN(pa) >= npage) {
ffffffffc0201954:	8031                	srli	s0,s0,0xc
ffffffffc0201956:	00052797          	auipc	a5,0x52
ffffffffc020195a:	d8a7b783          	ld	a5,-630(a5) # ffffffffc02536e0 <npage>
ffffffffc020195e:	06f47163          	bgeu	s0,a5,ffffffffc02019c0 <kfree+0xc4>
    return &pages[PPN(pa) - nbase];
ffffffffc0201962:	00006517          	auipc	a0,0x6
ffffffffc0201966:	89653503          	ld	a0,-1898(a0) # ffffffffc02071f8 <nbase>
ffffffffc020196a:	8c09                	sub	s0,s0,a0
ffffffffc020196c:	041a                	slli	s0,s0,0x6
  free_pages(kva2page(kva), 1 << order);
ffffffffc020196e:	00052517          	auipc	a0,0x52
ffffffffc0201972:	ec253503          	ld	a0,-318(a0) # ffffffffc0253830 <pages>
ffffffffc0201976:	4585                	li	a1,1
ffffffffc0201978:	9522                	add	a0,a0,s0
ffffffffc020197a:	00e595bb          	sllw	a1,a1,a4
ffffffffc020197e:	5f7000ef          	jal	ra,ffffffffc0202774 <free_pages>
		spin_unlock_irqrestore(&block_lock, flags);
	}

	slob_free((slob_t *)block - 1, 0);
	return;
}
ffffffffc0201982:	6442                	ld	s0,16(sp)
ffffffffc0201984:	60e2                	ld	ra,24(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201986:	8526                	mv	a0,s1
}
ffffffffc0201988:	64a2                	ld	s1,8(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc020198a:	45e1                	li	a1,24
}
ffffffffc020198c:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc020198e:	b975                	j	ffffffffc020164a <slob_free>
ffffffffc0201990:	c219                	beqz	a2,ffffffffc0201996 <kfree+0x9a>
        intr_enable();
ffffffffc0201992:	c9bfe0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc0201996:	ff040513          	addi	a0,s0,-16
}
ffffffffc020199a:	6442                	ld	s0,16(sp)
ffffffffc020199c:	60e2                	ld	ra,24(sp)
ffffffffc020199e:	64a2                	ld	s1,8(sp)
	slob_free((slob_t *)block - 1, 0);
ffffffffc02019a0:	4581                	li	a1,0
}
ffffffffc02019a2:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc02019a4:	b15d                	j	ffffffffc020164a <slob_free>
        intr_disable();
ffffffffc02019a6:	c8dfe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc02019aa:	00052797          	auipc	a5,0x52
ffffffffc02019ae:	d167b783          	ld	a5,-746(a5) # ffffffffc02536c0 <bigblocks>
        return 1;
ffffffffc02019b2:	4605                	li	a2,1
ffffffffc02019b4:	f7bd                	bnez	a5,ffffffffc0201922 <kfree+0x26>
ffffffffc02019b6:	bff1                	j	ffffffffc0201992 <kfree+0x96>
        intr_enable();
ffffffffc02019b8:	c75fe0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc02019bc:	b751                	j	ffffffffc0201940 <kfree+0x44>
ffffffffc02019be:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc02019c0:	00004617          	auipc	a2,0x4
ffffffffc02019c4:	0b860613          	addi	a2,a2,184 # ffffffffc0205a78 <commands+0xb28>
ffffffffc02019c8:	06200593          	li	a1,98
ffffffffc02019cc:	00004517          	auipc	a0,0x4
ffffffffc02019d0:	03c50513          	addi	a0,a0,60 # ffffffffc0205a08 <commands+0xab8>
ffffffffc02019d4:	831fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    return pa2page(PADDR(kva));
ffffffffc02019d8:	86a2                	mv	a3,s0
ffffffffc02019da:	00004617          	auipc	a2,0x4
ffffffffc02019de:	07660613          	addi	a2,a2,118 # ffffffffc0205a50 <commands+0xb00>
ffffffffc02019e2:	06e00593          	li	a1,110
ffffffffc02019e6:	00004517          	auipc	a0,0x4
ffffffffc02019ea:	02250513          	addi	a0,a0,34 # ffffffffc0205a08 <commands+0xab8>
ffffffffc02019ee:	817fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02019f2 <swap_init>:

static void check_swap(void);

int
swap_init(void)
{
ffffffffc02019f2:	1101                	addi	sp,sp,-32
ffffffffc02019f4:	ec06                	sd	ra,24(sp)
ffffffffc02019f6:	e822                	sd	s0,16(sp)
ffffffffc02019f8:	e426                	sd	s1,8(sp)
     swapfs_init();
ffffffffc02019fa:	6b4010ef          	jal	ra,ffffffffc02030ae <swapfs_init>

     // Since the IDE is faked, it can only store 7 pages at most to pass the test
     if (!(7 <= max_swap_offset &&
ffffffffc02019fe:	00052697          	auipc	a3,0x52
ffffffffc0201a02:	dc26b683          	ld	a3,-574(a3) # ffffffffc02537c0 <max_swap_offset>
ffffffffc0201a06:	010007b7          	lui	a5,0x1000
ffffffffc0201a0a:	ff968713          	addi	a4,a3,-7
ffffffffc0201a0e:	17e1                	addi	a5,a5,-8
ffffffffc0201a10:	04e7e863          	bltu	a5,a4,ffffffffc0201a60 <swap_init+0x6e>
        max_swap_offset < MAX_SWAP_OFFSET_LIMIT)) {
        panic("bad max_swap_offset %08x.\n", max_swap_offset);
     }
     

     sm = &swap_manager_fifo;
ffffffffc0201a14:	00046797          	auipc	a5,0x46
ffffffffc0201a18:	7dc78793          	addi	a5,a5,2012 # ffffffffc02481f0 <swap_manager_fifo>
     int r = sm->init();
ffffffffc0201a1c:	6798                	ld	a4,8(a5)
     sm = &swap_manager_fifo;
ffffffffc0201a1e:	00052497          	auipc	s1,0x52
ffffffffc0201a22:	caa48493          	addi	s1,s1,-854 # ffffffffc02536c8 <sm>
ffffffffc0201a26:	e09c                	sd	a5,0(s1)
     int r = sm->init();
ffffffffc0201a28:	9702                	jalr	a4
ffffffffc0201a2a:	842a                	mv	s0,a0
     
     if (r == 0)
ffffffffc0201a2c:	c519                	beqz	a0,ffffffffc0201a3a <swap_init+0x48>
          cprintf("SWAP: manager = %s\n", sm->name);
          //check_swap();
     }

     return r;
}
ffffffffc0201a2e:	60e2                	ld	ra,24(sp)
ffffffffc0201a30:	8522                	mv	a0,s0
ffffffffc0201a32:	6442                	ld	s0,16(sp)
ffffffffc0201a34:	64a2                	ld	s1,8(sp)
ffffffffc0201a36:	6105                	addi	sp,sp,32
ffffffffc0201a38:	8082                	ret
          cprintf("SWAP: manager = %s\n", sm->name);
ffffffffc0201a3a:	609c                	ld	a5,0(s1)
ffffffffc0201a3c:	00004517          	auipc	a0,0x4
ffffffffc0201a40:	08c50513          	addi	a0,a0,140 # ffffffffc0205ac8 <commands+0xb78>
ffffffffc0201a44:	638c                	ld	a1,0(a5)
          swap_init_ok = 1;
ffffffffc0201a46:	4785                	li	a5,1
ffffffffc0201a48:	00052717          	auipc	a4,0x52
ffffffffc0201a4c:	c8f72423          	sw	a5,-888(a4) # ffffffffc02536d0 <swap_init_ok>
          cprintf("SWAP: manager = %s\n", sm->name);
ffffffffc0201a50:	e78fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
}
ffffffffc0201a54:	60e2                	ld	ra,24(sp)
ffffffffc0201a56:	8522                	mv	a0,s0
ffffffffc0201a58:	6442                	ld	s0,16(sp)
ffffffffc0201a5a:	64a2                	ld	s1,8(sp)
ffffffffc0201a5c:	6105                	addi	sp,sp,32
ffffffffc0201a5e:	8082                	ret
        panic("bad max_swap_offset %08x.\n", max_swap_offset);
ffffffffc0201a60:	00004617          	auipc	a2,0x4
ffffffffc0201a64:	03860613          	addi	a2,a2,56 # ffffffffc0205a98 <commands+0xb48>
ffffffffc0201a68:	02800593          	li	a1,40
ffffffffc0201a6c:	00004517          	auipc	a0,0x4
ffffffffc0201a70:	04c50513          	addi	a0,a0,76 # ffffffffc0205ab8 <commands+0xb68>
ffffffffc0201a74:	f90fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201a78 <swap_init_mm>:

int
swap_init_mm(struct mm_struct *mm)
{
     return sm->init_mm(mm);
ffffffffc0201a78:	00052797          	auipc	a5,0x52
ffffffffc0201a7c:	c507b783          	ld	a5,-944(a5) # ffffffffc02536c8 <sm>
ffffffffc0201a80:	0107b303          	ld	t1,16(a5)
ffffffffc0201a84:	8302                	jr	t1

ffffffffc0201a86 <swap_map_swappable>:
}

int
swap_map_swappable(struct mm_struct *mm, uintptr_t addr, struct Page *page, int swap_in)
{
     return sm->map_swappable(mm, addr, page, swap_in);
ffffffffc0201a86:	00052797          	auipc	a5,0x52
ffffffffc0201a8a:	c427b783          	ld	a5,-958(a5) # ffffffffc02536c8 <sm>
ffffffffc0201a8e:	0207b303          	ld	t1,32(a5)
ffffffffc0201a92:	8302                	jr	t1

ffffffffc0201a94 <swap_out>:

volatile unsigned int swap_out_num=0;

int
swap_out(struct mm_struct *mm, int n, int in_tick)
{
ffffffffc0201a94:	711d                	addi	sp,sp,-96
ffffffffc0201a96:	ec86                	sd	ra,88(sp)
ffffffffc0201a98:	e8a2                	sd	s0,80(sp)
ffffffffc0201a9a:	e4a6                	sd	s1,72(sp)
ffffffffc0201a9c:	e0ca                	sd	s2,64(sp)
ffffffffc0201a9e:	fc4e                	sd	s3,56(sp)
ffffffffc0201aa0:	f852                	sd	s4,48(sp)
ffffffffc0201aa2:	f456                	sd	s5,40(sp)
ffffffffc0201aa4:	f05a                	sd	s6,32(sp)
ffffffffc0201aa6:	ec5e                	sd	s7,24(sp)
ffffffffc0201aa8:	e862                	sd	s8,16(sp)
     int i;
     for (i = 0; i != n; ++ i)
ffffffffc0201aaa:	cde9                	beqz	a1,ffffffffc0201b84 <swap_out+0xf0>
ffffffffc0201aac:	8a2e                	mv	s4,a1
ffffffffc0201aae:	892a                	mv	s2,a0
ffffffffc0201ab0:	8ab2                	mv	s5,a2
ffffffffc0201ab2:	4401                	li	s0,0
ffffffffc0201ab4:	00052997          	auipc	s3,0x52
ffffffffc0201ab8:	c1498993          	addi	s3,s3,-1004 # ffffffffc02536c8 <sm>
                    cprintf("SWAP: failed to save\n");
                    sm->map_swappable(mm, v, page, 0);
                    continue;
          }
          else {
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc0201abc:	00004b17          	auipc	s6,0x4
ffffffffc0201ac0:	084b0b13          	addi	s6,s6,132 # ffffffffc0205b40 <commands+0xbf0>
                    cprintf("SWAP: failed to save\n");
ffffffffc0201ac4:	00004b97          	auipc	s7,0x4
ffffffffc0201ac8:	064b8b93          	addi	s7,s7,100 # ffffffffc0205b28 <commands+0xbd8>
ffffffffc0201acc:	a825                	j	ffffffffc0201b04 <swap_out+0x70>
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc0201ace:	67a2                	ld	a5,8(sp)
ffffffffc0201ad0:	8626                	mv	a2,s1
ffffffffc0201ad2:	85a2                	mv	a1,s0
ffffffffc0201ad4:	7f94                	ld	a3,56(a5)
ffffffffc0201ad6:	855a                	mv	a0,s6
     for (i = 0; i != n; ++ i)
ffffffffc0201ad8:	2405                	addiw	s0,s0,1
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc0201ada:	82b1                	srli	a3,a3,0xc
ffffffffc0201adc:	0685                	addi	a3,a3,1
ffffffffc0201ade:	deafe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
                    *ptep = (page->pra_vaddr/PGSIZE+1)<<8;
ffffffffc0201ae2:	6522                	ld	a0,8(sp)
                    free_page(page);
ffffffffc0201ae4:	4585                	li	a1,1
                    *ptep = (page->pra_vaddr/PGSIZE+1)<<8;
ffffffffc0201ae6:	7d1c                	ld	a5,56(a0)
ffffffffc0201ae8:	83b1                	srli	a5,a5,0xc
ffffffffc0201aea:	0785                	addi	a5,a5,1
ffffffffc0201aec:	07a2                	slli	a5,a5,0x8
ffffffffc0201aee:	00fc3023          	sd	a5,0(s8)
                    free_page(page);
ffffffffc0201af2:	483000ef          	jal	ra,ffffffffc0202774 <free_pages>
          }
          
          tlb_invalidate(mm->pgdir, v);
ffffffffc0201af6:	01893503          	ld	a0,24(s2)
ffffffffc0201afa:	85a6                	mv	a1,s1
ffffffffc0201afc:	51e010ef          	jal	ra,ffffffffc020301a <tlb_invalidate>
     for (i = 0; i != n; ++ i)
ffffffffc0201b00:	048a0d63          	beq	s4,s0,ffffffffc0201b5a <swap_out+0xc6>
          int r = sm->swap_out_victim(mm, &page, in_tick);
ffffffffc0201b04:	0009b783          	ld	a5,0(s3)
ffffffffc0201b08:	8656                	mv	a2,s5
ffffffffc0201b0a:	002c                	addi	a1,sp,8
ffffffffc0201b0c:	7b9c                	ld	a5,48(a5)
ffffffffc0201b0e:	854a                	mv	a0,s2
ffffffffc0201b10:	9782                	jalr	a5
          if (r != 0) {
ffffffffc0201b12:	e12d                	bnez	a0,ffffffffc0201b74 <swap_out+0xe0>
          v=page->pra_vaddr; 
ffffffffc0201b14:	67a2                	ld	a5,8(sp)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc0201b16:	01893503          	ld	a0,24(s2)
ffffffffc0201b1a:	4601                	li	a2,0
          v=page->pra_vaddr; 
ffffffffc0201b1c:	7f84                	ld	s1,56(a5)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc0201b1e:	85a6                	mv	a1,s1
ffffffffc0201b20:	629000ef          	jal	ra,ffffffffc0202948 <get_pte>
          assert((*ptep & PTE_V) != 0);
ffffffffc0201b24:	611c                	ld	a5,0(a0)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc0201b26:	8c2a                	mv	s8,a0
          assert((*ptep & PTE_V) != 0);
ffffffffc0201b28:	8b85                	andi	a5,a5,1
ffffffffc0201b2a:	cfb9                	beqz	a5,ffffffffc0201b88 <swap_out+0xf4>
          if (swapfs_write( (page->pra_vaddr/PGSIZE+1)<<8, page) != 0) {
ffffffffc0201b2c:	65a2                	ld	a1,8(sp)
ffffffffc0201b2e:	7d9c                	ld	a5,56(a1)
ffffffffc0201b30:	83b1                	srli	a5,a5,0xc
ffffffffc0201b32:	0785                	addi	a5,a5,1
ffffffffc0201b34:	00879513          	slli	a0,a5,0x8
ffffffffc0201b38:	63c010ef          	jal	ra,ffffffffc0203174 <swapfs_write>
ffffffffc0201b3c:	d949                	beqz	a0,ffffffffc0201ace <swap_out+0x3a>
                    cprintf("SWAP: failed to save\n");
ffffffffc0201b3e:	855e                	mv	a0,s7
ffffffffc0201b40:	d88fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
                    sm->map_swappable(mm, v, page, 0);
ffffffffc0201b44:	0009b783          	ld	a5,0(s3)
ffffffffc0201b48:	6622                	ld	a2,8(sp)
ffffffffc0201b4a:	4681                	li	a3,0
ffffffffc0201b4c:	739c                	ld	a5,32(a5)
ffffffffc0201b4e:	85a6                	mv	a1,s1
ffffffffc0201b50:	854a                	mv	a0,s2
     for (i = 0; i != n; ++ i)
ffffffffc0201b52:	2405                	addiw	s0,s0,1
                    sm->map_swappable(mm, v, page, 0);
ffffffffc0201b54:	9782                	jalr	a5
     for (i = 0; i != n; ++ i)
ffffffffc0201b56:	fa8a17e3          	bne	s4,s0,ffffffffc0201b04 <swap_out+0x70>
     }
     return i;
}
ffffffffc0201b5a:	60e6                	ld	ra,88(sp)
ffffffffc0201b5c:	8522                	mv	a0,s0
ffffffffc0201b5e:	6446                	ld	s0,80(sp)
ffffffffc0201b60:	64a6                	ld	s1,72(sp)
ffffffffc0201b62:	6906                	ld	s2,64(sp)
ffffffffc0201b64:	79e2                	ld	s3,56(sp)
ffffffffc0201b66:	7a42                	ld	s4,48(sp)
ffffffffc0201b68:	7aa2                	ld	s5,40(sp)
ffffffffc0201b6a:	7b02                	ld	s6,32(sp)
ffffffffc0201b6c:	6be2                	ld	s7,24(sp)
ffffffffc0201b6e:	6c42                	ld	s8,16(sp)
ffffffffc0201b70:	6125                	addi	sp,sp,96
ffffffffc0201b72:	8082                	ret
                    cprintf("i %d, swap_out: call swap_out_victim failed\n",i);
ffffffffc0201b74:	85a2                	mv	a1,s0
ffffffffc0201b76:	00004517          	auipc	a0,0x4
ffffffffc0201b7a:	f6a50513          	addi	a0,a0,-150 # ffffffffc0205ae0 <commands+0xb90>
ffffffffc0201b7e:	d4afe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
                  break;
ffffffffc0201b82:	bfe1                	j	ffffffffc0201b5a <swap_out+0xc6>
     for (i = 0; i != n; ++ i)
ffffffffc0201b84:	4401                	li	s0,0
ffffffffc0201b86:	bfd1                	j	ffffffffc0201b5a <swap_out+0xc6>
          assert((*ptep & PTE_V) != 0);
ffffffffc0201b88:	00004697          	auipc	a3,0x4
ffffffffc0201b8c:	f8868693          	addi	a3,a3,-120 # ffffffffc0205b10 <commands+0xbc0>
ffffffffc0201b90:	00003617          	auipc	a2,0x3
ffffffffc0201b94:	7c860613          	addi	a2,a2,1992 # ffffffffc0205358 <commands+0x408>
ffffffffc0201b98:	06800593          	li	a1,104
ffffffffc0201b9c:	00004517          	auipc	a0,0x4
ffffffffc0201ba0:	f1c50513          	addi	a0,a0,-228 # ffffffffc0205ab8 <commands+0xb68>
ffffffffc0201ba4:	e60fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201ba8 <swap_in>:

int
swap_in(struct mm_struct *mm, uintptr_t addr, struct Page **ptr_result)
{
ffffffffc0201ba8:	7179                	addi	sp,sp,-48
ffffffffc0201baa:	e84a                	sd	s2,16(sp)
ffffffffc0201bac:	892a                	mv	s2,a0
     struct Page *result = alloc_page();
ffffffffc0201bae:	4505                	li	a0,1
{
ffffffffc0201bb0:	ec26                	sd	s1,24(sp)
ffffffffc0201bb2:	e44e                	sd	s3,8(sp)
ffffffffc0201bb4:	f406                	sd	ra,40(sp)
ffffffffc0201bb6:	f022                	sd	s0,32(sp)
ffffffffc0201bb8:	84ae                	mv	s1,a1
ffffffffc0201bba:	89b2                	mv	s3,a2
     struct Page *result = alloc_page();
ffffffffc0201bbc:	327000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
     assert(result!=NULL);
ffffffffc0201bc0:	c129                	beqz	a0,ffffffffc0201c02 <swap_in+0x5a>

     pte_t *ptep = get_pte(mm->pgdir, addr, 0);
ffffffffc0201bc2:	842a                	mv	s0,a0
ffffffffc0201bc4:	01893503          	ld	a0,24(s2)
ffffffffc0201bc8:	4601                	li	a2,0
ffffffffc0201bca:	85a6                	mv	a1,s1
ffffffffc0201bcc:	57d000ef          	jal	ra,ffffffffc0202948 <get_pte>
ffffffffc0201bd0:	892a                	mv	s2,a0
     // cprintf("SWAP: load ptep %x swap entry %d to vaddr 0x%08x, page %x, No %d\n", ptep, (*ptep)>>8, addr, result, (result-pages));
    
     int r;
     if ((r = swapfs_read((*ptep), result)) != 0)
ffffffffc0201bd2:	6108                	ld	a0,0(a0)
ffffffffc0201bd4:	85a2                	mv	a1,s0
ffffffffc0201bd6:	510010ef          	jal	ra,ffffffffc02030e6 <swapfs_read>
     {
        assert(r!=0);
     }
     cprintf("swap_in: load disk swap entry %d with swap_page in vadr 0x%x\n", (*ptep)>>8, addr);
ffffffffc0201bda:	00093583          	ld	a1,0(s2)
ffffffffc0201bde:	8626                	mv	a2,s1
ffffffffc0201be0:	00004517          	auipc	a0,0x4
ffffffffc0201be4:	fb050513          	addi	a0,a0,-80 # ffffffffc0205b90 <commands+0xc40>
ffffffffc0201be8:	81a1                	srli	a1,a1,0x8
ffffffffc0201bea:	cdefe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
     *ptr_result=result;
     return 0;
}
ffffffffc0201bee:	70a2                	ld	ra,40(sp)
     *ptr_result=result;
ffffffffc0201bf0:	0089b023          	sd	s0,0(s3)
}
ffffffffc0201bf4:	7402                	ld	s0,32(sp)
ffffffffc0201bf6:	64e2                	ld	s1,24(sp)
ffffffffc0201bf8:	6942                	ld	s2,16(sp)
ffffffffc0201bfa:	69a2                	ld	s3,8(sp)
ffffffffc0201bfc:	4501                	li	a0,0
ffffffffc0201bfe:	6145                	addi	sp,sp,48
ffffffffc0201c00:	8082                	ret
     assert(result!=NULL);
ffffffffc0201c02:	00004697          	auipc	a3,0x4
ffffffffc0201c06:	f7e68693          	addi	a3,a3,-130 # ffffffffc0205b80 <commands+0xc30>
ffffffffc0201c0a:	00003617          	auipc	a2,0x3
ffffffffc0201c0e:	74e60613          	addi	a2,a2,1870 # ffffffffc0205358 <commands+0x408>
ffffffffc0201c12:	07e00593          	li	a1,126
ffffffffc0201c16:	00004517          	auipc	a0,0x4
ffffffffc0201c1a:	ea250513          	addi	a0,a0,-350 # ffffffffc0205ab8 <commands+0xb68>
ffffffffc0201c1e:	de6fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201c22 <default_init>:
    elm->prev = elm->next = elm;
ffffffffc0201c22:	00052797          	auipc	a5,0x52
ffffffffc0201c26:	bde78793          	addi	a5,a5,-1058 # ffffffffc0253800 <free_area>
ffffffffc0201c2a:	e79c                	sd	a5,8(a5)
ffffffffc0201c2c:	e39c                	sd	a5,0(a5)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
ffffffffc0201c2e:	0007a823          	sw	zero,16(a5)
}
ffffffffc0201c32:	8082                	ret

ffffffffc0201c34 <default_nr_free_pages>:
}

static size_t
default_nr_free_pages(void) {
    return nr_free;
}
ffffffffc0201c34:	00052517          	auipc	a0,0x52
ffffffffc0201c38:	bdc56503          	lwu	a0,-1060(a0) # ffffffffc0253810 <free_area+0x10>
ffffffffc0201c3c:	8082                	ret

ffffffffc0201c3e <default_check>:
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
ffffffffc0201c3e:	715d                	addi	sp,sp,-80
ffffffffc0201c40:	e0a2                	sd	s0,64(sp)
    return listelm->next;
ffffffffc0201c42:	00052417          	auipc	s0,0x52
ffffffffc0201c46:	bbe40413          	addi	s0,s0,-1090 # ffffffffc0253800 <free_area>
ffffffffc0201c4a:	641c                	ld	a5,8(s0)
ffffffffc0201c4c:	e486                	sd	ra,72(sp)
ffffffffc0201c4e:	fc26                	sd	s1,56(sp)
ffffffffc0201c50:	f84a                	sd	s2,48(sp)
ffffffffc0201c52:	f44e                	sd	s3,40(sp)
ffffffffc0201c54:	f052                	sd	s4,32(sp)
ffffffffc0201c56:	ec56                	sd	s5,24(sp)
ffffffffc0201c58:	e85a                	sd	s6,16(sp)
ffffffffc0201c5a:	e45e                	sd	s7,8(sp)
ffffffffc0201c5c:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0201c5e:	2a878d63          	beq	a5,s0,ffffffffc0201f18 <default_check+0x2da>
    int count = 0, total = 0;
ffffffffc0201c62:	4481                	li	s1,0
ffffffffc0201c64:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0201c66:	ff07b703          	ld	a4,-16(a5)
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0201c6a:	8b09                	andi	a4,a4,2
ffffffffc0201c6c:	2a070a63          	beqz	a4,ffffffffc0201f20 <default_check+0x2e2>
        count ++, total += p->property;
ffffffffc0201c70:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201c74:	679c                	ld	a5,8(a5)
ffffffffc0201c76:	2905                	addiw	s2,s2,1
ffffffffc0201c78:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0201c7a:	fe8796e3          	bne	a5,s0,ffffffffc0201c66 <default_check+0x28>
ffffffffc0201c7e:	89a6                	mv	s3,s1
    }
    assert(total == nr_free_pages());
ffffffffc0201c80:	337000ef          	jal	ra,ffffffffc02027b6 <nr_free_pages>
ffffffffc0201c84:	6f351e63          	bne	a0,s3,ffffffffc0202380 <default_check+0x742>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201c88:	4505                	li	a0,1
ffffffffc0201c8a:	259000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201c8e:	8aaa                	mv	s5,a0
ffffffffc0201c90:	42050863          	beqz	a0,ffffffffc02020c0 <default_check+0x482>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201c94:	4505                	li	a0,1
ffffffffc0201c96:	24d000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201c9a:	89aa                	mv	s3,a0
ffffffffc0201c9c:	70050263          	beqz	a0,ffffffffc02023a0 <default_check+0x762>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201ca0:	4505                	li	a0,1
ffffffffc0201ca2:	241000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201ca6:	8a2a                	mv	s4,a0
ffffffffc0201ca8:	48050c63          	beqz	a0,ffffffffc0202140 <default_check+0x502>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201cac:	293a8a63          	beq	s5,s3,ffffffffc0201f40 <default_check+0x302>
ffffffffc0201cb0:	28aa8863          	beq	s5,a0,ffffffffc0201f40 <default_check+0x302>
ffffffffc0201cb4:	28a98663          	beq	s3,a0,ffffffffc0201f40 <default_check+0x302>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201cb8:	000aa783          	lw	a5,0(s5)
ffffffffc0201cbc:	2a079263          	bnez	a5,ffffffffc0201f60 <default_check+0x322>
ffffffffc0201cc0:	0009a783          	lw	a5,0(s3)
ffffffffc0201cc4:	28079e63          	bnez	a5,ffffffffc0201f60 <default_check+0x322>
ffffffffc0201cc8:	411c                	lw	a5,0(a0)
ffffffffc0201cca:	28079b63          	bnez	a5,ffffffffc0201f60 <default_check+0x322>
    return page - pages + nbase;
ffffffffc0201cce:	00052797          	auipc	a5,0x52
ffffffffc0201cd2:	b627b783          	ld	a5,-1182(a5) # ffffffffc0253830 <pages>
ffffffffc0201cd6:	40fa8733          	sub	a4,s5,a5
ffffffffc0201cda:	00005617          	auipc	a2,0x5
ffffffffc0201cde:	51e63603          	ld	a2,1310(a2) # ffffffffc02071f8 <nbase>
ffffffffc0201ce2:	8719                	srai	a4,a4,0x6
ffffffffc0201ce4:	9732                	add	a4,a4,a2
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201ce6:	00052697          	auipc	a3,0x52
ffffffffc0201cea:	9fa6b683          	ld	a3,-1542(a3) # ffffffffc02536e0 <npage>
ffffffffc0201cee:	06b2                	slli	a3,a3,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0201cf0:	0732                	slli	a4,a4,0xc
ffffffffc0201cf2:	28d77763          	bgeu	a4,a3,ffffffffc0201f80 <default_check+0x342>
    return page - pages + nbase;
ffffffffc0201cf6:	40f98733          	sub	a4,s3,a5
ffffffffc0201cfa:	8719                	srai	a4,a4,0x6
ffffffffc0201cfc:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0201cfe:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201d00:	4cd77063          	bgeu	a4,a3,ffffffffc02021c0 <default_check+0x582>
    return page - pages + nbase;
ffffffffc0201d04:	40f507b3          	sub	a5,a0,a5
ffffffffc0201d08:	8799                	srai	a5,a5,0x6
ffffffffc0201d0a:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0201d0c:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0201d0e:	30d7f963          	bgeu	a5,a3,ffffffffc0202020 <default_check+0x3e2>
    assert(alloc_page() == NULL);
ffffffffc0201d12:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0201d14:	00043c03          	ld	s8,0(s0)
ffffffffc0201d18:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc0201d1c:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc0201d20:	e400                	sd	s0,8(s0)
ffffffffc0201d22:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc0201d24:	00052797          	auipc	a5,0x52
ffffffffc0201d28:	ae07a623          	sw	zero,-1300(a5) # ffffffffc0253810 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc0201d2c:	1b7000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201d30:	2c051863          	bnez	a0,ffffffffc0202000 <default_check+0x3c2>
    free_page(p0);
ffffffffc0201d34:	4585                	li	a1,1
ffffffffc0201d36:	8556                	mv	a0,s5
ffffffffc0201d38:	23d000ef          	jal	ra,ffffffffc0202774 <free_pages>
    free_page(p1);
ffffffffc0201d3c:	4585                	li	a1,1
ffffffffc0201d3e:	854e                	mv	a0,s3
ffffffffc0201d40:	235000ef          	jal	ra,ffffffffc0202774 <free_pages>
    free_page(p2);
ffffffffc0201d44:	4585                	li	a1,1
ffffffffc0201d46:	8552                	mv	a0,s4
ffffffffc0201d48:	22d000ef          	jal	ra,ffffffffc0202774 <free_pages>
    assert(nr_free == 3);
ffffffffc0201d4c:	4818                	lw	a4,16(s0)
ffffffffc0201d4e:	478d                	li	a5,3
ffffffffc0201d50:	28f71863          	bne	a4,a5,ffffffffc0201fe0 <default_check+0x3a2>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201d54:	4505                	li	a0,1
ffffffffc0201d56:	18d000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201d5a:	89aa                	mv	s3,a0
ffffffffc0201d5c:	26050263          	beqz	a0,ffffffffc0201fc0 <default_check+0x382>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201d60:	4505                	li	a0,1
ffffffffc0201d62:	181000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201d66:	8aaa                	mv	s5,a0
ffffffffc0201d68:	3a050c63          	beqz	a0,ffffffffc0202120 <default_check+0x4e2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201d6c:	4505                	li	a0,1
ffffffffc0201d6e:	175000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201d72:	8a2a                	mv	s4,a0
ffffffffc0201d74:	38050663          	beqz	a0,ffffffffc0202100 <default_check+0x4c2>
    assert(alloc_page() == NULL);
ffffffffc0201d78:	4505                	li	a0,1
ffffffffc0201d7a:	169000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201d7e:	36051163          	bnez	a0,ffffffffc02020e0 <default_check+0x4a2>
    free_page(p0);
ffffffffc0201d82:	4585                	li	a1,1
ffffffffc0201d84:	854e                	mv	a0,s3
ffffffffc0201d86:	1ef000ef          	jal	ra,ffffffffc0202774 <free_pages>
    assert(!list_empty(&free_list));
ffffffffc0201d8a:	641c                	ld	a5,8(s0)
ffffffffc0201d8c:	20878a63          	beq	a5,s0,ffffffffc0201fa0 <default_check+0x362>
    assert((p = alloc_page()) == p0);
ffffffffc0201d90:	4505                	li	a0,1
ffffffffc0201d92:	151000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201d96:	30a99563          	bne	s3,a0,ffffffffc02020a0 <default_check+0x462>
    assert(alloc_page() == NULL);
ffffffffc0201d9a:	4505                	li	a0,1
ffffffffc0201d9c:	147000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201da0:	2e051063          	bnez	a0,ffffffffc0202080 <default_check+0x442>
    assert(nr_free == 0);
ffffffffc0201da4:	481c                	lw	a5,16(s0)
ffffffffc0201da6:	2a079d63          	bnez	a5,ffffffffc0202060 <default_check+0x422>
    free_page(p);
ffffffffc0201daa:	854e                	mv	a0,s3
ffffffffc0201dac:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0201dae:	01843023          	sd	s8,0(s0)
ffffffffc0201db2:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc0201db6:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc0201dba:	1bb000ef          	jal	ra,ffffffffc0202774 <free_pages>
    free_page(p1);
ffffffffc0201dbe:	4585                	li	a1,1
ffffffffc0201dc0:	8556                	mv	a0,s5
ffffffffc0201dc2:	1b3000ef          	jal	ra,ffffffffc0202774 <free_pages>
    free_page(p2);
ffffffffc0201dc6:	4585                	li	a1,1
ffffffffc0201dc8:	8552                	mv	a0,s4
ffffffffc0201dca:	1ab000ef          	jal	ra,ffffffffc0202774 <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc0201dce:	4515                	li	a0,5
ffffffffc0201dd0:	113000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201dd4:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc0201dd6:	26050563          	beqz	a0,ffffffffc0202040 <default_check+0x402>
ffffffffc0201dda:	651c                	ld	a5,8(a0)
ffffffffc0201ddc:	8385                	srli	a5,a5,0x1
ffffffffc0201dde:	8b85                	andi	a5,a5,1
    assert(!PageProperty(p0));
ffffffffc0201de0:	54079063          	bnez	a5,ffffffffc0202320 <default_check+0x6e2>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc0201de4:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0201de6:	00043b03          	ld	s6,0(s0)
ffffffffc0201dea:	00843a83          	ld	s5,8(s0)
ffffffffc0201dee:	e000                	sd	s0,0(s0)
ffffffffc0201df0:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc0201df2:	0f1000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201df6:	50051563          	bnez	a0,ffffffffc0202300 <default_check+0x6c2>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc0201dfa:	08098a13          	addi	s4,s3,128
ffffffffc0201dfe:	8552                	mv	a0,s4
ffffffffc0201e00:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc0201e02:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc0201e06:	00052797          	auipc	a5,0x52
ffffffffc0201e0a:	a007a523          	sw	zero,-1526(a5) # ffffffffc0253810 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc0201e0e:	167000ef          	jal	ra,ffffffffc0202774 <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc0201e12:	4511                	li	a0,4
ffffffffc0201e14:	0cf000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201e18:	4c051463          	bnez	a0,ffffffffc02022e0 <default_check+0x6a2>
ffffffffc0201e1c:	0889b783          	ld	a5,136(s3)
ffffffffc0201e20:	8385                	srli	a5,a5,0x1
ffffffffc0201e22:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0201e24:	48078e63          	beqz	a5,ffffffffc02022c0 <default_check+0x682>
ffffffffc0201e28:	0909a703          	lw	a4,144(s3)
ffffffffc0201e2c:	478d                	li	a5,3
ffffffffc0201e2e:	48f71963          	bne	a4,a5,ffffffffc02022c0 <default_check+0x682>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201e32:	450d                	li	a0,3
ffffffffc0201e34:	0af000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201e38:	8c2a                	mv	s8,a0
ffffffffc0201e3a:	46050363          	beqz	a0,ffffffffc02022a0 <default_check+0x662>
    assert(alloc_page() == NULL);
ffffffffc0201e3e:	4505                	li	a0,1
ffffffffc0201e40:	0a3000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201e44:	42051e63          	bnez	a0,ffffffffc0202280 <default_check+0x642>
    assert(p0 + 2 == p1);
ffffffffc0201e48:	418a1c63          	bne	s4,s8,ffffffffc0202260 <default_check+0x622>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc0201e4c:	4585                	li	a1,1
ffffffffc0201e4e:	854e                	mv	a0,s3
ffffffffc0201e50:	125000ef          	jal	ra,ffffffffc0202774 <free_pages>
    free_pages(p1, 3);
ffffffffc0201e54:	458d                	li	a1,3
ffffffffc0201e56:	8552                	mv	a0,s4
ffffffffc0201e58:	11d000ef          	jal	ra,ffffffffc0202774 <free_pages>
ffffffffc0201e5c:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0201e60:	04098c13          	addi	s8,s3,64
ffffffffc0201e64:	8385                	srli	a5,a5,0x1
ffffffffc0201e66:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201e68:	3c078c63          	beqz	a5,ffffffffc0202240 <default_check+0x602>
ffffffffc0201e6c:	0109a703          	lw	a4,16(s3)
ffffffffc0201e70:	4785                	li	a5,1
ffffffffc0201e72:	3cf71763          	bne	a4,a5,ffffffffc0202240 <default_check+0x602>
ffffffffc0201e76:	008a3783          	ld	a5,8(s4) # 1008 <_binary_obj___user_ex3_out_size-0x89f8>
ffffffffc0201e7a:	8385                	srli	a5,a5,0x1
ffffffffc0201e7c:	8b85                	andi	a5,a5,1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0201e7e:	3a078163          	beqz	a5,ffffffffc0202220 <default_check+0x5e2>
ffffffffc0201e82:	010a2703          	lw	a4,16(s4)
ffffffffc0201e86:	478d                	li	a5,3
ffffffffc0201e88:	38f71c63          	bne	a4,a5,ffffffffc0202220 <default_check+0x5e2>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0201e8c:	4505                	li	a0,1
ffffffffc0201e8e:	055000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201e92:	36a99763          	bne	s3,a0,ffffffffc0202200 <default_check+0x5c2>
    free_page(p0);
ffffffffc0201e96:	4585                	li	a1,1
ffffffffc0201e98:	0dd000ef          	jal	ra,ffffffffc0202774 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0201e9c:	4509                	li	a0,2
ffffffffc0201e9e:	045000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201ea2:	32aa1f63          	bne	s4,a0,ffffffffc02021e0 <default_check+0x5a2>

    free_pages(p0, 2);
ffffffffc0201ea6:	4589                	li	a1,2
ffffffffc0201ea8:	0cd000ef          	jal	ra,ffffffffc0202774 <free_pages>
    free_page(p2);
ffffffffc0201eac:	4585                	li	a1,1
ffffffffc0201eae:	8562                	mv	a0,s8
ffffffffc0201eb0:	0c5000ef          	jal	ra,ffffffffc0202774 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0201eb4:	4515                	li	a0,5
ffffffffc0201eb6:	02d000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201eba:	89aa                	mv	s3,a0
ffffffffc0201ebc:	48050263          	beqz	a0,ffffffffc0202340 <default_check+0x702>
    assert(alloc_page() == NULL);
ffffffffc0201ec0:	4505                	li	a0,1
ffffffffc0201ec2:	021000ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0201ec6:	2c051d63          	bnez	a0,ffffffffc02021a0 <default_check+0x562>

    assert(nr_free == 0);
ffffffffc0201eca:	481c                	lw	a5,16(s0)
ffffffffc0201ecc:	2a079a63          	bnez	a5,ffffffffc0202180 <default_check+0x542>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc0201ed0:	4595                	li	a1,5
ffffffffc0201ed2:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc0201ed4:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc0201ed8:	01643023          	sd	s6,0(s0)
ffffffffc0201edc:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc0201ee0:	095000ef          	jal	ra,ffffffffc0202774 <free_pages>
    return listelm->next;
ffffffffc0201ee4:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0201ee6:	00878963          	beq	a5,s0,ffffffffc0201ef8 <default_check+0x2ba>
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
ffffffffc0201eea:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201eee:	679c                	ld	a5,8(a5)
ffffffffc0201ef0:	397d                	addiw	s2,s2,-1
ffffffffc0201ef2:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0201ef4:	fe879be3          	bne	a5,s0,ffffffffc0201eea <default_check+0x2ac>
    }
    assert(count == 0);
ffffffffc0201ef8:	26091463          	bnez	s2,ffffffffc0202160 <default_check+0x522>
    assert(total == 0);
ffffffffc0201efc:	46049263          	bnez	s1,ffffffffc0202360 <default_check+0x722>
}
ffffffffc0201f00:	60a6                	ld	ra,72(sp)
ffffffffc0201f02:	6406                	ld	s0,64(sp)
ffffffffc0201f04:	74e2                	ld	s1,56(sp)
ffffffffc0201f06:	7942                	ld	s2,48(sp)
ffffffffc0201f08:	79a2                	ld	s3,40(sp)
ffffffffc0201f0a:	7a02                	ld	s4,32(sp)
ffffffffc0201f0c:	6ae2                	ld	s5,24(sp)
ffffffffc0201f0e:	6b42                	ld	s6,16(sp)
ffffffffc0201f10:	6ba2                	ld	s7,8(sp)
ffffffffc0201f12:	6c02                	ld	s8,0(sp)
ffffffffc0201f14:	6161                	addi	sp,sp,80
ffffffffc0201f16:	8082                	ret
    while ((le = list_next(le)) != &free_list) {
ffffffffc0201f18:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc0201f1a:	4481                	li	s1,0
ffffffffc0201f1c:	4901                	li	s2,0
ffffffffc0201f1e:	b38d                	j	ffffffffc0201c80 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc0201f20:	00004697          	auipc	a3,0x4
ffffffffc0201f24:	cb068693          	addi	a3,a3,-848 # ffffffffc0205bd0 <commands+0xc80>
ffffffffc0201f28:	00003617          	auipc	a2,0x3
ffffffffc0201f2c:	43060613          	addi	a2,a2,1072 # ffffffffc0205358 <commands+0x408>
ffffffffc0201f30:	0f000593          	li	a1,240
ffffffffc0201f34:	00004517          	auipc	a0,0x4
ffffffffc0201f38:	cac50513          	addi	a0,a0,-852 # ffffffffc0205be0 <commands+0xc90>
ffffffffc0201f3c:	ac8fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201f40:	00004697          	auipc	a3,0x4
ffffffffc0201f44:	d3868693          	addi	a3,a3,-712 # ffffffffc0205c78 <commands+0xd28>
ffffffffc0201f48:	00003617          	auipc	a2,0x3
ffffffffc0201f4c:	41060613          	addi	a2,a2,1040 # ffffffffc0205358 <commands+0x408>
ffffffffc0201f50:	0bd00593          	li	a1,189
ffffffffc0201f54:	00004517          	auipc	a0,0x4
ffffffffc0201f58:	c8c50513          	addi	a0,a0,-884 # ffffffffc0205be0 <commands+0xc90>
ffffffffc0201f5c:	aa8fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201f60:	00004697          	auipc	a3,0x4
ffffffffc0201f64:	d4068693          	addi	a3,a3,-704 # ffffffffc0205ca0 <commands+0xd50>
ffffffffc0201f68:	00003617          	auipc	a2,0x3
ffffffffc0201f6c:	3f060613          	addi	a2,a2,1008 # ffffffffc0205358 <commands+0x408>
ffffffffc0201f70:	0be00593          	li	a1,190
ffffffffc0201f74:	00004517          	auipc	a0,0x4
ffffffffc0201f78:	c6c50513          	addi	a0,a0,-916 # ffffffffc0205be0 <commands+0xc90>
ffffffffc0201f7c:	a88fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201f80:	00004697          	auipc	a3,0x4
ffffffffc0201f84:	d6068693          	addi	a3,a3,-672 # ffffffffc0205ce0 <commands+0xd90>
ffffffffc0201f88:	00003617          	auipc	a2,0x3
ffffffffc0201f8c:	3d060613          	addi	a2,a2,976 # ffffffffc0205358 <commands+0x408>
ffffffffc0201f90:	0c000593          	li	a1,192
ffffffffc0201f94:	00004517          	auipc	a0,0x4
ffffffffc0201f98:	c4c50513          	addi	a0,a0,-948 # ffffffffc0205be0 <commands+0xc90>
ffffffffc0201f9c:	a68fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201fa0:	00004697          	auipc	a3,0x4
ffffffffc0201fa4:	dc868693          	addi	a3,a3,-568 # ffffffffc0205d68 <commands+0xe18>
ffffffffc0201fa8:	00003617          	auipc	a2,0x3
ffffffffc0201fac:	3b060613          	addi	a2,a2,944 # ffffffffc0205358 <commands+0x408>
ffffffffc0201fb0:	0d900593          	li	a1,217
ffffffffc0201fb4:	00004517          	auipc	a0,0x4
ffffffffc0201fb8:	c2c50513          	addi	a0,a0,-980 # ffffffffc0205be0 <commands+0xc90>
ffffffffc0201fbc:	a48fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201fc0:	00004697          	auipc	a3,0x4
ffffffffc0201fc4:	c5868693          	addi	a3,a3,-936 # ffffffffc0205c18 <commands+0xcc8>
ffffffffc0201fc8:	00003617          	auipc	a2,0x3
ffffffffc0201fcc:	39060613          	addi	a2,a2,912 # ffffffffc0205358 <commands+0x408>
ffffffffc0201fd0:	0d200593          	li	a1,210
ffffffffc0201fd4:	00004517          	auipc	a0,0x4
ffffffffc0201fd8:	c0c50513          	addi	a0,a0,-1012 # ffffffffc0205be0 <commands+0xc90>
ffffffffc0201fdc:	a28fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(nr_free == 3);
ffffffffc0201fe0:	00004697          	auipc	a3,0x4
ffffffffc0201fe4:	d7868693          	addi	a3,a3,-648 # ffffffffc0205d58 <commands+0xe08>
ffffffffc0201fe8:	00003617          	auipc	a2,0x3
ffffffffc0201fec:	37060613          	addi	a2,a2,880 # ffffffffc0205358 <commands+0x408>
ffffffffc0201ff0:	0d000593          	li	a1,208
ffffffffc0201ff4:	00004517          	auipc	a0,0x4
ffffffffc0201ff8:	bec50513          	addi	a0,a0,-1044 # ffffffffc0205be0 <commands+0xc90>
ffffffffc0201ffc:	a08fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202000:	00004697          	auipc	a3,0x4
ffffffffc0202004:	d4068693          	addi	a3,a3,-704 # ffffffffc0205d40 <commands+0xdf0>
ffffffffc0202008:	00003617          	auipc	a2,0x3
ffffffffc020200c:	35060613          	addi	a2,a2,848 # ffffffffc0205358 <commands+0x408>
ffffffffc0202010:	0cb00593          	li	a1,203
ffffffffc0202014:	00004517          	auipc	a0,0x4
ffffffffc0202018:	bcc50513          	addi	a0,a0,-1076 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020201c:	9e8fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0202020:	00004697          	auipc	a3,0x4
ffffffffc0202024:	d0068693          	addi	a3,a3,-768 # ffffffffc0205d20 <commands+0xdd0>
ffffffffc0202028:	00003617          	auipc	a2,0x3
ffffffffc020202c:	33060613          	addi	a2,a2,816 # ffffffffc0205358 <commands+0x408>
ffffffffc0202030:	0c200593          	li	a1,194
ffffffffc0202034:	00004517          	auipc	a0,0x4
ffffffffc0202038:	bac50513          	addi	a0,a0,-1108 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020203c:	9c8fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(p0 != NULL);
ffffffffc0202040:	00004697          	auipc	a3,0x4
ffffffffc0202044:	d7068693          	addi	a3,a3,-656 # ffffffffc0205db0 <commands+0xe60>
ffffffffc0202048:	00003617          	auipc	a2,0x3
ffffffffc020204c:	31060613          	addi	a2,a2,784 # ffffffffc0205358 <commands+0x408>
ffffffffc0202050:	0f800593          	li	a1,248
ffffffffc0202054:	00004517          	auipc	a0,0x4
ffffffffc0202058:	b8c50513          	addi	a0,a0,-1140 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020205c:	9a8fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(nr_free == 0);
ffffffffc0202060:	00004697          	auipc	a3,0x4
ffffffffc0202064:	d4068693          	addi	a3,a3,-704 # ffffffffc0205da0 <commands+0xe50>
ffffffffc0202068:	00003617          	auipc	a2,0x3
ffffffffc020206c:	2f060613          	addi	a2,a2,752 # ffffffffc0205358 <commands+0x408>
ffffffffc0202070:	0df00593          	li	a1,223
ffffffffc0202074:	00004517          	auipc	a0,0x4
ffffffffc0202078:	b6c50513          	addi	a0,a0,-1172 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020207c:	988fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202080:	00004697          	auipc	a3,0x4
ffffffffc0202084:	cc068693          	addi	a3,a3,-832 # ffffffffc0205d40 <commands+0xdf0>
ffffffffc0202088:	00003617          	auipc	a2,0x3
ffffffffc020208c:	2d060613          	addi	a2,a2,720 # ffffffffc0205358 <commands+0x408>
ffffffffc0202090:	0dd00593          	li	a1,221
ffffffffc0202094:	00004517          	auipc	a0,0x4
ffffffffc0202098:	b4c50513          	addi	a0,a0,-1204 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020209c:	968fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc02020a0:	00004697          	auipc	a3,0x4
ffffffffc02020a4:	ce068693          	addi	a3,a3,-800 # ffffffffc0205d80 <commands+0xe30>
ffffffffc02020a8:	00003617          	auipc	a2,0x3
ffffffffc02020ac:	2b060613          	addi	a2,a2,688 # ffffffffc0205358 <commands+0x408>
ffffffffc02020b0:	0dc00593          	li	a1,220
ffffffffc02020b4:	00004517          	auipc	a0,0x4
ffffffffc02020b8:	b2c50513          	addi	a0,a0,-1236 # ffffffffc0205be0 <commands+0xc90>
ffffffffc02020bc:	948fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc02020c0:	00004697          	auipc	a3,0x4
ffffffffc02020c4:	b5868693          	addi	a3,a3,-1192 # ffffffffc0205c18 <commands+0xcc8>
ffffffffc02020c8:	00003617          	auipc	a2,0x3
ffffffffc02020cc:	29060613          	addi	a2,a2,656 # ffffffffc0205358 <commands+0x408>
ffffffffc02020d0:	0b900593          	li	a1,185
ffffffffc02020d4:	00004517          	auipc	a0,0x4
ffffffffc02020d8:	b0c50513          	addi	a0,a0,-1268 # ffffffffc0205be0 <commands+0xc90>
ffffffffc02020dc:	928fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02020e0:	00004697          	auipc	a3,0x4
ffffffffc02020e4:	c6068693          	addi	a3,a3,-928 # ffffffffc0205d40 <commands+0xdf0>
ffffffffc02020e8:	00003617          	auipc	a2,0x3
ffffffffc02020ec:	27060613          	addi	a2,a2,624 # ffffffffc0205358 <commands+0x408>
ffffffffc02020f0:	0d600593          	li	a1,214
ffffffffc02020f4:	00004517          	auipc	a0,0x4
ffffffffc02020f8:	aec50513          	addi	a0,a0,-1300 # ffffffffc0205be0 <commands+0xc90>
ffffffffc02020fc:	908fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202100:	00004697          	auipc	a3,0x4
ffffffffc0202104:	b5868693          	addi	a3,a3,-1192 # ffffffffc0205c58 <commands+0xd08>
ffffffffc0202108:	00003617          	auipc	a2,0x3
ffffffffc020210c:	25060613          	addi	a2,a2,592 # ffffffffc0205358 <commands+0x408>
ffffffffc0202110:	0d400593          	li	a1,212
ffffffffc0202114:	00004517          	auipc	a0,0x4
ffffffffc0202118:	acc50513          	addi	a0,a0,-1332 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020211c:	8e8fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0202120:	00004697          	auipc	a3,0x4
ffffffffc0202124:	b1868693          	addi	a3,a3,-1256 # ffffffffc0205c38 <commands+0xce8>
ffffffffc0202128:	00003617          	auipc	a2,0x3
ffffffffc020212c:	23060613          	addi	a2,a2,560 # ffffffffc0205358 <commands+0x408>
ffffffffc0202130:	0d300593          	li	a1,211
ffffffffc0202134:	00004517          	auipc	a0,0x4
ffffffffc0202138:	aac50513          	addi	a0,a0,-1364 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020213c:	8c8fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202140:	00004697          	auipc	a3,0x4
ffffffffc0202144:	b1868693          	addi	a3,a3,-1256 # ffffffffc0205c58 <commands+0xd08>
ffffffffc0202148:	00003617          	auipc	a2,0x3
ffffffffc020214c:	21060613          	addi	a2,a2,528 # ffffffffc0205358 <commands+0x408>
ffffffffc0202150:	0bb00593          	li	a1,187
ffffffffc0202154:	00004517          	auipc	a0,0x4
ffffffffc0202158:	a8c50513          	addi	a0,a0,-1396 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020215c:	8a8fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(count == 0);
ffffffffc0202160:	00004697          	auipc	a3,0x4
ffffffffc0202164:	da068693          	addi	a3,a3,-608 # ffffffffc0205f00 <commands+0xfb0>
ffffffffc0202168:	00003617          	auipc	a2,0x3
ffffffffc020216c:	1f060613          	addi	a2,a2,496 # ffffffffc0205358 <commands+0x408>
ffffffffc0202170:	12500593          	li	a1,293
ffffffffc0202174:	00004517          	auipc	a0,0x4
ffffffffc0202178:	a6c50513          	addi	a0,a0,-1428 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020217c:	888fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(nr_free == 0);
ffffffffc0202180:	00004697          	auipc	a3,0x4
ffffffffc0202184:	c2068693          	addi	a3,a3,-992 # ffffffffc0205da0 <commands+0xe50>
ffffffffc0202188:	00003617          	auipc	a2,0x3
ffffffffc020218c:	1d060613          	addi	a2,a2,464 # ffffffffc0205358 <commands+0x408>
ffffffffc0202190:	11a00593          	li	a1,282
ffffffffc0202194:	00004517          	auipc	a0,0x4
ffffffffc0202198:	a4c50513          	addi	a0,a0,-1460 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020219c:	868fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02021a0:	00004697          	auipc	a3,0x4
ffffffffc02021a4:	ba068693          	addi	a3,a3,-1120 # ffffffffc0205d40 <commands+0xdf0>
ffffffffc02021a8:	00003617          	auipc	a2,0x3
ffffffffc02021ac:	1b060613          	addi	a2,a2,432 # ffffffffc0205358 <commands+0x408>
ffffffffc02021b0:	11800593          	li	a1,280
ffffffffc02021b4:	00004517          	auipc	a0,0x4
ffffffffc02021b8:	a2c50513          	addi	a0,a0,-1492 # ffffffffc0205be0 <commands+0xc90>
ffffffffc02021bc:	848fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc02021c0:	00004697          	auipc	a3,0x4
ffffffffc02021c4:	b4068693          	addi	a3,a3,-1216 # ffffffffc0205d00 <commands+0xdb0>
ffffffffc02021c8:	00003617          	auipc	a2,0x3
ffffffffc02021cc:	19060613          	addi	a2,a2,400 # ffffffffc0205358 <commands+0x408>
ffffffffc02021d0:	0c100593          	li	a1,193
ffffffffc02021d4:	00004517          	auipc	a0,0x4
ffffffffc02021d8:	a0c50513          	addi	a0,a0,-1524 # ffffffffc0205be0 <commands+0xc90>
ffffffffc02021dc:	828fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc02021e0:	00004697          	auipc	a3,0x4
ffffffffc02021e4:	ce068693          	addi	a3,a3,-800 # ffffffffc0205ec0 <commands+0xf70>
ffffffffc02021e8:	00003617          	auipc	a2,0x3
ffffffffc02021ec:	17060613          	addi	a2,a2,368 # ffffffffc0205358 <commands+0x408>
ffffffffc02021f0:	11200593          	li	a1,274
ffffffffc02021f4:	00004517          	auipc	a0,0x4
ffffffffc02021f8:	9ec50513          	addi	a0,a0,-1556 # ffffffffc0205be0 <commands+0xc90>
ffffffffc02021fc:	808fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0202200:	00004697          	auipc	a3,0x4
ffffffffc0202204:	ca068693          	addi	a3,a3,-864 # ffffffffc0205ea0 <commands+0xf50>
ffffffffc0202208:	00003617          	auipc	a2,0x3
ffffffffc020220c:	15060613          	addi	a2,a2,336 # ffffffffc0205358 <commands+0x408>
ffffffffc0202210:	11000593          	li	a1,272
ffffffffc0202214:	00004517          	auipc	a0,0x4
ffffffffc0202218:	9cc50513          	addi	a0,a0,-1588 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020221c:	fe9fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0202220:	00004697          	auipc	a3,0x4
ffffffffc0202224:	c5868693          	addi	a3,a3,-936 # ffffffffc0205e78 <commands+0xf28>
ffffffffc0202228:	00003617          	auipc	a2,0x3
ffffffffc020222c:	13060613          	addi	a2,a2,304 # ffffffffc0205358 <commands+0x408>
ffffffffc0202230:	10e00593          	li	a1,270
ffffffffc0202234:	00004517          	auipc	a0,0x4
ffffffffc0202238:	9ac50513          	addi	a0,a0,-1620 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020223c:	fc9fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0202240:	00004697          	auipc	a3,0x4
ffffffffc0202244:	c1068693          	addi	a3,a3,-1008 # ffffffffc0205e50 <commands+0xf00>
ffffffffc0202248:	00003617          	auipc	a2,0x3
ffffffffc020224c:	11060613          	addi	a2,a2,272 # ffffffffc0205358 <commands+0x408>
ffffffffc0202250:	10d00593          	li	a1,269
ffffffffc0202254:	00004517          	auipc	a0,0x4
ffffffffc0202258:	98c50513          	addi	a0,a0,-1652 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020225c:	fa9fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(p0 + 2 == p1);
ffffffffc0202260:	00004697          	auipc	a3,0x4
ffffffffc0202264:	be068693          	addi	a3,a3,-1056 # ffffffffc0205e40 <commands+0xef0>
ffffffffc0202268:	00003617          	auipc	a2,0x3
ffffffffc020226c:	0f060613          	addi	a2,a2,240 # ffffffffc0205358 <commands+0x408>
ffffffffc0202270:	10800593          	li	a1,264
ffffffffc0202274:	00004517          	auipc	a0,0x4
ffffffffc0202278:	96c50513          	addi	a0,a0,-1684 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020227c:	f89fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202280:	00004697          	auipc	a3,0x4
ffffffffc0202284:	ac068693          	addi	a3,a3,-1344 # ffffffffc0205d40 <commands+0xdf0>
ffffffffc0202288:	00003617          	auipc	a2,0x3
ffffffffc020228c:	0d060613          	addi	a2,a2,208 # ffffffffc0205358 <commands+0x408>
ffffffffc0202290:	10700593          	li	a1,263
ffffffffc0202294:	00004517          	auipc	a0,0x4
ffffffffc0202298:	94c50513          	addi	a0,a0,-1716 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020229c:	f69fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc02022a0:	00004697          	auipc	a3,0x4
ffffffffc02022a4:	b8068693          	addi	a3,a3,-1152 # ffffffffc0205e20 <commands+0xed0>
ffffffffc02022a8:	00003617          	auipc	a2,0x3
ffffffffc02022ac:	0b060613          	addi	a2,a2,176 # ffffffffc0205358 <commands+0x408>
ffffffffc02022b0:	10600593          	li	a1,262
ffffffffc02022b4:	00004517          	auipc	a0,0x4
ffffffffc02022b8:	92c50513          	addi	a0,a0,-1748 # ffffffffc0205be0 <commands+0xc90>
ffffffffc02022bc:	f49fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc02022c0:	00004697          	auipc	a3,0x4
ffffffffc02022c4:	b3068693          	addi	a3,a3,-1232 # ffffffffc0205df0 <commands+0xea0>
ffffffffc02022c8:	00003617          	auipc	a2,0x3
ffffffffc02022cc:	09060613          	addi	a2,a2,144 # ffffffffc0205358 <commands+0x408>
ffffffffc02022d0:	10500593          	li	a1,261
ffffffffc02022d4:	00004517          	auipc	a0,0x4
ffffffffc02022d8:	90c50513          	addi	a0,a0,-1780 # ffffffffc0205be0 <commands+0xc90>
ffffffffc02022dc:	f29fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc02022e0:	00004697          	auipc	a3,0x4
ffffffffc02022e4:	af868693          	addi	a3,a3,-1288 # ffffffffc0205dd8 <commands+0xe88>
ffffffffc02022e8:	00003617          	auipc	a2,0x3
ffffffffc02022ec:	07060613          	addi	a2,a2,112 # ffffffffc0205358 <commands+0x408>
ffffffffc02022f0:	10400593          	li	a1,260
ffffffffc02022f4:	00004517          	auipc	a0,0x4
ffffffffc02022f8:	8ec50513          	addi	a0,a0,-1812 # ffffffffc0205be0 <commands+0xc90>
ffffffffc02022fc:	f09fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202300:	00004697          	auipc	a3,0x4
ffffffffc0202304:	a4068693          	addi	a3,a3,-1472 # ffffffffc0205d40 <commands+0xdf0>
ffffffffc0202308:	00003617          	auipc	a2,0x3
ffffffffc020230c:	05060613          	addi	a2,a2,80 # ffffffffc0205358 <commands+0x408>
ffffffffc0202310:	0fe00593          	li	a1,254
ffffffffc0202314:	00004517          	auipc	a0,0x4
ffffffffc0202318:	8cc50513          	addi	a0,a0,-1844 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020231c:	ee9fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(!PageProperty(p0));
ffffffffc0202320:	00004697          	auipc	a3,0x4
ffffffffc0202324:	aa068693          	addi	a3,a3,-1376 # ffffffffc0205dc0 <commands+0xe70>
ffffffffc0202328:	00003617          	auipc	a2,0x3
ffffffffc020232c:	03060613          	addi	a2,a2,48 # ffffffffc0205358 <commands+0x408>
ffffffffc0202330:	0f900593          	li	a1,249
ffffffffc0202334:	00004517          	auipc	a0,0x4
ffffffffc0202338:	8ac50513          	addi	a0,a0,-1876 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020233c:	ec9fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0202340:	00004697          	auipc	a3,0x4
ffffffffc0202344:	ba068693          	addi	a3,a3,-1120 # ffffffffc0205ee0 <commands+0xf90>
ffffffffc0202348:	00003617          	auipc	a2,0x3
ffffffffc020234c:	01060613          	addi	a2,a2,16 # ffffffffc0205358 <commands+0x408>
ffffffffc0202350:	11700593          	li	a1,279
ffffffffc0202354:	00004517          	auipc	a0,0x4
ffffffffc0202358:	88c50513          	addi	a0,a0,-1908 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020235c:	ea9fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(total == 0);
ffffffffc0202360:	00004697          	auipc	a3,0x4
ffffffffc0202364:	bb068693          	addi	a3,a3,-1104 # ffffffffc0205f10 <commands+0xfc0>
ffffffffc0202368:	00003617          	auipc	a2,0x3
ffffffffc020236c:	ff060613          	addi	a2,a2,-16 # ffffffffc0205358 <commands+0x408>
ffffffffc0202370:	12600593          	li	a1,294
ffffffffc0202374:	00004517          	auipc	a0,0x4
ffffffffc0202378:	86c50513          	addi	a0,a0,-1940 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020237c:	e89fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(total == nr_free_pages());
ffffffffc0202380:	00004697          	auipc	a3,0x4
ffffffffc0202384:	87868693          	addi	a3,a3,-1928 # ffffffffc0205bf8 <commands+0xca8>
ffffffffc0202388:	00003617          	auipc	a2,0x3
ffffffffc020238c:	fd060613          	addi	a2,a2,-48 # ffffffffc0205358 <commands+0x408>
ffffffffc0202390:	0f300593          	li	a1,243
ffffffffc0202394:	00004517          	auipc	a0,0x4
ffffffffc0202398:	84c50513          	addi	a0,a0,-1972 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020239c:	e69fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc02023a0:	00004697          	auipc	a3,0x4
ffffffffc02023a4:	89868693          	addi	a3,a3,-1896 # ffffffffc0205c38 <commands+0xce8>
ffffffffc02023a8:	00003617          	auipc	a2,0x3
ffffffffc02023ac:	fb060613          	addi	a2,a2,-80 # ffffffffc0205358 <commands+0x408>
ffffffffc02023b0:	0ba00593          	li	a1,186
ffffffffc02023b4:	00004517          	auipc	a0,0x4
ffffffffc02023b8:	82c50513          	addi	a0,a0,-2004 # ffffffffc0205be0 <commands+0xc90>
ffffffffc02023bc:	e49fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02023c0 <default_free_pages>:
default_free_pages(struct Page *base, size_t n) {
ffffffffc02023c0:	1141                	addi	sp,sp,-16
ffffffffc02023c2:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02023c4:	12058f63          	beqz	a1,ffffffffc0202502 <default_free_pages+0x142>
    for (; p != base + n; p ++) {
ffffffffc02023c8:	00659693          	slli	a3,a1,0x6
ffffffffc02023cc:	96aa                	add	a3,a3,a0
ffffffffc02023ce:	87aa                	mv	a5,a0
ffffffffc02023d0:	02d50263          	beq	a0,a3,ffffffffc02023f4 <default_free_pages+0x34>
ffffffffc02023d4:	6798                	ld	a4,8(a5)
ffffffffc02023d6:	8b05                	andi	a4,a4,1
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02023d8:	10071563          	bnez	a4,ffffffffc02024e2 <default_free_pages+0x122>
ffffffffc02023dc:	6798                	ld	a4,8(a5)
ffffffffc02023de:	8b09                	andi	a4,a4,2
ffffffffc02023e0:	10071163          	bnez	a4,ffffffffc02024e2 <default_free_pages+0x122>
        p->flags = 0;
ffffffffc02023e4:	0007b423          	sd	zero,8(a5)
    return page->ref;
}

static inline void
set_page_ref(struct Page *page, int val) {
    page->ref = val;
ffffffffc02023e8:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc02023ec:	04078793          	addi	a5,a5,64
ffffffffc02023f0:	fed792e3          	bne	a5,a3,ffffffffc02023d4 <default_free_pages+0x14>
    base->property = n;
ffffffffc02023f4:	2581                	sext.w	a1,a1
ffffffffc02023f6:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc02023f8:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02023fc:	4789                	li	a5,2
ffffffffc02023fe:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc0202402:	00051697          	auipc	a3,0x51
ffffffffc0202406:	3fe68693          	addi	a3,a3,1022 # ffffffffc0253800 <free_area>
ffffffffc020240a:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc020240c:	669c                	ld	a5,8(a3)
ffffffffc020240e:	01850613          	addi	a2,a0,24
ffffffffc0202412:	9db9                	addw	a1,a1,a4
ffffffffc0202414:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc0202416:	08d78f63          	beq	a5,a3,ffffffffc02024b4 <default_free_pages+0xf4>
            struct Page* page = le2page(le, page_link);
ffffffffc020241a:	fe878713          	addi	a4,a5,-24
ffffffffc020241e:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc0202422:	4581                	li	a1,0
            if (base < page) {
ffffffffc0202424:	00e56a63          	bltu	a0,a4,ffffffffc0202438 <default_free_pages+0x78>
    return listelm->next;
ffffffffc0202428:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc020242a:	04d70a63          	beq	a4,a3,ffffffffc020247e <default_free_pages+0xbe>
    for (; p != base + n; p ++) {
ffffffffc020242e:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc0202430:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc0202434:	fee57ae3          	bgeu	a0,a4,ffffffffc0202428 <default_free_pages+0x68>
ffffffffc0202438:	c199                	beqz	a1,ffffffffc020243e <default_free_pages+0x7e>
ffffffffc020243a:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc020243e:	6398                	ld	a4,0(a5)
    prev->next = next->prev = elm;
ffffffffc0202440:	e390                	sd	a2,0(a5)
ffffffffc0202442:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0202444:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202446:	ed18                	sd	a4,24(a0)
    if (le != &free_list) {
ffffffffc0202448:	00d70c63          	beq	a4,a3,ffffffffc0202460 <default_free_pages+0xa0>
        if (p + p->property == base) {
ffffffffc020244c:	ff872583          	lw	a1,-8(a4)
        p = le2page(le, page_link);
ffffffffc0202450:	fe870613          	addi	a2,a4,-24
        if (p + p->property == base) {
ffffffffc0202454:	02059793          	slli	a5,a1,0x20
ffffffffc0202458:	83e9                	srli	a5,a5,0x1a
ffffffffc020245a:	97b2                	add	a5,a5,a2
ffffffffc020245c:	02f50b63          	beq	a0,a5,ffffffffc0202492 <default_free_pages+0xd2>
ffffffffc0202460:	7118                	ld	a4,32(a0)
    if (le != &free_list) {
ffffffffc0202462:	00d70b63          	beq	a4,a3,ffffffffc0202478 <default_free_pages+0xb8>
        if (base + base->property == p) {
ffffffffc0202466:	4910                	lw	a2,16(a0)
        p = le2page(le, page_link);
ffffffffc0202468:	fe870693          	addi	a3,a4,-24
        if (base + base->property == p) {
ffffffffc020246c:	02061793          	slli	a5,a2,0x20
ffffffffc0202470:	83e9                	srli	a5,a5,0x1a
ffffffffc0202472:	97aa                	add	a5,a5,a0
ffffffffc0202474:	04f68763          	beq	a3,a5,ffffffffc02024c2 <default_free_pages+0x102>
}
ffffffffc0202478:	60a2                	ld	ra,8(sp)
ffffffffc020247a:	0141                	addi	sp,sp,16
ffffffffc020247c:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc020247e:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0202480:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0202482:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0202484:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0202486:	02d70463          	beq	a4,a3,ffffffffc02024ae <default_free_pages+0xee>
    prev->next = next->prev = elm;
ffffffffc020248a:	8832                	mv	a6,a2
ffffffffc020248c:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc020248e:	87ba                	mv	a5,a4
ffffffffc0202490:	b745                	j	ffffffffc0202430 <default_free_pages+0x70>
            p->property += base->property;
ffffffffc0202492:	491c                	lw	a5,16(a0)
ffffffffc0202494:	9dbd                	addw	a1,a1,a5
ffffffffc0202496:	feb72c23          	sw	a1,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc020249a:	57f5                	li	a5,-3
ffffffffc020249c:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc02024a0:	6d0c                	ld	a1,24(a0)
ffffffffc02024a2:	711c                	ld	a5,32(a0)
            base = p;
ffffffffc02024a4:	8532                	mv	a0,a2
    prev->next = next;
ffffffffc02024a6:	e59c                	sd	a5,8(a1)
    next->prev = prev;
ffffffffc02024a8:	6718                	ld	a4,8(a4)
ffffffffc02024aa:	e38c                	sd	a1,0(a5)
ffffffffc02024ac:	bf5d                	j	ffffffffc0202462 <default_free_pages+0xa2>
ffffffffc02024ae:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list) {
ffffffffc02024b0:	873e                	mv	a4,a5
ffffffffc02024b2:	bf69                	j	ffffffffc020244c <default_free_pages+0x8c>
}
ffffffffc02024b4:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc02024b6:	e390                	sd	a2,0(a5)
ffffffffc02024b8:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc02024ba:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc02024bc:	ed1c                	sd	a5,24(a0)
ffffffffc02024be:	0141                	addi	sp,sp,16
ffffffffc02024c0:	8082                	ret
            base->property += p->property;
ffffffffc02024c2:	ff872783          	lw	a5,-8(a4)
ffffffffc02024c6:	ff070693          	addi	a3,a4,-16
ffffffffc02024ca:	9e3d                	addw	a2,a2,a5
ffffffffc02024cc:	c910                	sw	a2,16(a0)
ffffffffc02024ce:	57f5                	li	a5,-3
ffffffffc02024d0:	60f6b02f          	amoand.d	zero,a5,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc02024d4:	6314                	ld	a3,0(a4)
ffffffffc02024d6:	671c                	ld	a5,8(a4)
}
ffffffffc02024d8:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc02024da:	e69c                	sd	a5,8(a3)
    next->prev = prev;
ffffffffc02024dc:	e394                	sd	a3,0(a5)
ffffffffc02024de:	0141                	addi	sp,sp,16
ffffffffc02024e0:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02024e2:	00004697          	auipc	a3,0x4
ffffffffc02024e6:	a4668693          	addi	a3,a3,-1466 # ffffffffc0205f28 <commands+0xfd8>
ffffffffc02024ea:	00003617          	auipc	a2,0x3
ffffffffc02024ee:	e6e60613          	addi	a2,a2,-402 # ffffffffc0205358 <commands+0x408>
ffffffffc02024f2:	08300593          	li	a1,131
ffffffffc02024f6:	00003517          	auipc	a0,0x3
ffffffffc02024fa:	6ea50513          	addi	a0,a0,1770 # ffffffffc0205be0 <commands+0xc90>
ffffffffc02024fe:	d07fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(n > 0);
ffffffffc0202502:	00004697          	auipc	a3,0x4
ffffffffc0202506:	a1e68693          	addi	a3,a3,-1506 # ffffffffc0205f20 <commands+0xfd0>
ffffffffc020250a:	00003617          	auipc	a2,0x3
ffffffffc020250e:	e4e60613          	addi	a2,a2,-434 # ffffffffc0205358 <commands+0x408>
ffffffffc0202512:	08000593          	li	a1,128
ffffffffc0202516:	00003517          	auipc	a0,0x3
ffffffffc020251a:	6ca50513          	addi	a0,a0,1738 # ffffffffc0205be0 <commands+0xc90>
ffffffffc020251e:	ce7fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0202522 <default_alloc_pages>:
    assert(n > 0);
ffffffffc0202522:	c941                	beqz	a0,ffffffffc02025b2 <default_alloc_pages+0x90>
    if (n > nr_free) {
ffffffffc0202524:	00051597          	auipc	a1,0x51
ffffffffc0202528:	2dc58593          	addi	a1,a1,732 # ffffffffc0253800 <free_area>
ffffffffc020252c:	0105a803          	lw	a6,16(a1)
ffffffffc0202530:	872a                	mv	a4,a0
ffffffffc0202532:	02081793          	slli	a5,a6,0x20
ffffffffc0202536:	9381                	srli	a5,a5,0x20
ffffffffc0202538:	00a7ee63          	bltu	a5,a0,ffffffffc0202554 <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc020253c:	87ae                	mv	a5,a1
ffffffffc020253e:	a801                	j	ffffffffc020254e <default_alloc_pages+0x2c>
        if (p->property >= n) {
ffffffffc0202540:	ff87a683          	lw	a3,-8(a5)
ffffffffc0202544:	02069613          	slli	a2,a3,0x20
ffffffffc0202548:	9201                	srli	a2,a2,0x20
ffffffffc020254a:	00e67763          	bgeu	a2,a4,ffffffffc0202558 <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc020254e:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list) {
ffffffffc0202550:	feb798e3          	bne	a5,a1,ffffffffc0202540 <default_alloc_pages+0x1e>
        return NULL;
ffffffffc0202554:	4501                	li	a0,0
}
ffffffffc0202556:	8082                	ret
    return listelm->prev;
ffffffffc0202558:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc020255c:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc0202560:	fe878513          	addi	a0,a5,-24
    prev->next = next;
ffffffffc0202564:	00070e1b          	sext.w	t3,a4
ffffffffc0202568:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc020256c:	01133023          	sd	a7,0(t1)
        if (page->property > n) {
ffffffffc0202570:	02c77863          	bgeu	a4,a2,ffffffffc02025a0 <default_alloc_pages+0x7e>
            struct Page *p = page + n;
ffffffffc0202574:	071a                	slli	a4,a4,0x6
ffffffffc0202576:	972a                	add	a4,a4,a0
            p->property = page->property - n;
ffffffffc0202578:	41c686bb          	subw	a3,a3,t3
ffffffffc020257c:	cb14                	sw	a3,16(a4)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc020257e:	00870613          	addi	a2,a4,8
ffffffffc0202582:	4689                	li	a3,2
ffffffffc0202584:	40d6302f          	amoor.d	zero,a3,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0202588:	0088b683          	ld	a3,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc020258c:	01870613          	addi	a2,a4,24
    prev->next = next->prev = elm;
ffffffffc0202590:	0105a803          	lw	a6,16(a1)
ffffffffc0202594:	e290                	sd	a2,0(a3)
ffffffffc0202596:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc020259a:	f314                	sd	a3,32(a4)
    elm->prev = prev;
ffffffffc020259c:	01173c23          	sd	a7,24(a4)
        nr_free -= n;
ffffffffc02025a0:	41c8083b          	subw	a6,a6,t3
ffffffffc02025a4:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc02025a8:	5775                	li	a4,-3
ffffffffc02025aa:	17c1                	addi	a5,a5,-16
ffffffffc02025ac:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc02025b0:	8082                	ret
default_alloc_pages(size_t n) {
ffffffffc02025b2:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc02025b4:	00004697          	auipc	a3,0x4
ffffffffc02025b8:	96c68693          	addi	a3,a3,-1684 # ffffffffc0205f20 <commands+0xfd0>
ffffffffc02025bc:	00003617          	auipc	a2,0x3
ffffffffc02025c0:	d9c60613          	addi	a2,a2,-612 # ffffffffc0205358 <commands+0x408>
ffffffffc02025c4:	06200593          	li	a1,98
ffffffffc02025c8:	00003517          	auipc	a0,0x3
ffffffffc02025cc:	61850513          	addi	a0,a0,1560 # ffffffffc0205be0 <commands+0xc90>
default_alloc_pages(size_t n) {
ffffffffc02025d0:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02025d2:	c33fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02025d6 <default_init_memmap>:
default_init_memmap(struct Page *base, size_t n) {
ffffffffc02025d6:	1141                	addi	sp,sp,-16
ffffffffc02025d8:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02025da:	c5f1                	beqz	a1,ffffffffc02026a6 <default_init_memmap+0xd0>
    for (; p != base + n; p ++) {
ffffffffc02025dc:	00659693          	slli	a3,a1,0x6
ffffffffc02025e0:	96aa                	add	a3,a3,a0
ffffffffc02025e2:	87aa                	mv	a5,a0
ffffffffc02025e4:	00d50f63          	beq	a0,a3,ffffffffc0202602 <default_init_memmap+0x2c>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc02025e8:	6798                	ld	a4,8(a5)
ffffffffc02025ea:	8b05                	andi	a4,a4,1
        assert(PageReserved(p));
ffffffffc02025ec:	cf49                	beqz	a4,ffffffffc0202686 <default_init_memmap+0xb0>
        p->flags = p->property = 0;
ffffffffc02025ee:	0007a823          	sw	zero,16(a5)
ffffffffc02025f2:	0007b423          	sd	zero,8(a5)
ffffffffc02025f6:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc02025fa:	04078793          	addi	a5,a5,64
ffffffffc02025fe:	fed795e3          	bne	a5,a3,ffffffffc02025e8 <default_init_memmap+0x12>
    base->property = n;
ffffffffc0202602:	2581                	sext.w	a1,a1
ffffffffc0202604:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0202606:	4789                	li	a5,2
ffffffffc0202608:	00850713          	addi	a4,a0,8
ffffffffc020260c:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc0202610:	00051697          	auipc	a3,0x51
ffffffffc0202614:	1f068693          	addi	a3,a3,496 # ffffffffc0253800 <free_area>
ffffffffc0202618:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc020261a:	669c                	ld	a5,8(a3)
ffffffffc020261c:	01850613          	addi	a2,a0,24
ffffffffc0202620:	9db9                	addw	a1,a1,a4
ffffffffc0202622:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc0202624:	04d78a63          	beq	a5,a3,ffffffffc0202678 <default_init_memmap+0xa2>
            struct Page* page = le2page(le, page_link);
ffffffffc0202628:	fe878713          	addi	a4,a5,-24
ffffffffc020262c:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc0202630:	4581                	li	a1,0
            if (base < page) {
ffffffffc0202632:	00e56a63          	bltu	a0,a4,ffffffffc0202646 <default_init_memmap+0x70>
    return listelm->next;
ffffffffc0202636:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc0202638:	02d70263          	beq	a4,a3,ffffffffc020265c <default_init_memmap+0x86>
    for (; p != base + n; p ++) {
ffffffffc020263c:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc020263e:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc0202642:	fee57ae3          	bgeu	a0,a4,ffffffffc0202636 <default_init_memmap+0x60>
ffffffffc0202646:	c199                	beqz	a1,ffffffffc020264c <default_init_memmap+0x76>
ffffffffc0202648:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc020264c:	6398                	ld	a4,0(a5)
}
ffffffffc020264e:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0202650:	e390                	sd	a2,0(a5)
ffffffffc0202652:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0202654:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202656:	ed18                	sd	a4,24(a0)
ffffffffc0202658:	0141                	addi	sp,sp,16
ffffffffc020265a:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc020265c:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc020265e:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0202660:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0202662:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0202664:	00d70663          	beq	a4,a3,ffffffffc0202670 <default_init_memmap+0x9a>
    prev->next = next->prev = elm;
ffffffffc0202668:	8832                	mv	a6,a2
ffffffffc020266a:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc020266c:	87ba                	mv	a5,a4
ffffffffc020266e:	bfc1                	j	ffffffffc020263e <default_init_memmap+0x68>
}
ffffffffc0202670:	60a2                	ld	ra,8(sp)
ffffffffc0202672:	e290                	sd	a2,0(a3)
ffffffffc0202674:	0141                	addi	sp,sp,16
ffffffffc0202676:	8082                	ret
ffffffffc0202678:	60a2                	ld	ra,8(sp)
ffffffffc020267a:	e390                	sd	a2,0(a5)
ffffffffc020267c:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc020267e:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202680:	ed1c                	sd	a5,24(a0)
ffffffffc0202682:	0141                	addi	sp,sp,16
ffffffffc0202684:	8082                	ret
        assert(PageReserved(p));
ffffffffc0202686:	00004697          	auipc	a3,0x4
ffffffffc020268a:	8ca68693          	addi	a3,a3,-1846 # ffffffffc0205f50 <commands+0x1000>
ffffffffc020268e:	00003617          	auipc	a2,0x3
ffffffffc0202692:	cca60613          	addi	a2,a2,-822 # ffffffffc0205358 <commands+0x408>
ffffffffc0202696:	04900593          	li	a1,73
ffffffffc020269a:	00003517          	auipc	a0,0x3
ffffffffc020269e:	54650513          	addi	a0,a0,1350 # ffffffffc0205be0 <commands+0xc90>
ffffffffc02026a2:	b63fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(n > 0);
ffffffffc02026a6:	00004697          	auipc	a3,0x4
ffffffffc02026aa:	87a68693          	addi	a3,a3,-1926 # ffffffffc0205f20 <commands+0xfd0>
ffffffffc02026ae:	00003617          	auipc	a2,0x3
ffffffffc02026b2:	caa60613          	addi	a2,a2,-854 # ffffffffc0205358 <commands+0x408>
ffffffffc02026b6:	04600593          	li	a1,70
ffffffffc02026ba:	00003517          	auipc	a0,0x3
ffffffffc02026be:	52650513          	addi	a0,a0,1318 # ffffffffc0205be0 <commands+0xc90>
ffffffffc02026c2:	b43fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02026c6 <pa2page.part.0>:
pa2page(uintptr_t pa) {
ffffffffc02026c6:	1141                	addi	sp,sp,-16
        panic("pa2page called with invalid pa");
ffffffffc02026c8:	00003617          	auipc	a2,0x3
ffffffffc02026cc:	3b060613          	addi	a2,a2,944 # ffffffffc0205a78 <commands+0xb28>
ffffffffc02026d0:	06200593          	li	a1,98
ffffffffc02026d4:	00003517          	auipc	a0,0x3
ffffffffc02026d8:	33450513          	addi	a0,a0,820 # ffffffffc0205a08 <commands+0xab8>
pa2page(uintptr_t pa) {
ffffffffc02026dc:	e406                	sd	ra,8(sp)
        panic("pa2page called with invalid pa");
ffffffffc02026de:	b27fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02026e2 <alloc_pages>:
    pmm_manager->init_memmap(base, n);
}

// alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE
// memory
struct Page *alloc_pages(size_t n) {
ffffffffc02026e2:	7139                	addi	sp,sp,-64
ffffffffc02026e4:	f426                	sd	s1,40(sp)
ffffffffc02026e6:	f04a                	sd	s2,32(sp)
ffffffffc02026e8:	ec4e                	sd	s3,24(sp)
ffffffffc02026ea:	e852                	sd	s4,16(sp)
ffffffffc02026ec:	e456                	sd	s5,8(sp)
ffffffffc02026ee:	e05a                	sd	s6,0(sp)
ffffffffc02026f0:	fc06                	sd	ra,56(sp)
ffffffffc02026f2:	f822                	sd	s0,48(sp)
ffffffffc02026f4:	84aa                	mv	s1,a0
ffffffffc02026f6:	00051917          	auipc	s2,0x51
ffffffffc02026fa:	12290913          	addi	s2,s2,290 # ffffffffc0253818 <pmm_manager>
        {
            page = pmm_manager->alloc_pages(n);
        }
        local_intr_restore(intr_flag);

        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc02026fe:	4a05                	li	s4,1
ffffffffc0202700:	00051a97          	auipc	s5,0x51
ffffffffc0202704:	fd0a8a93          	addi	s5,s5,-48 # ffffffffc02536d0 <swap_init_ok>

        extern struct mm_struct *check_mm_struct;
        // cprintf("page %x, call swap_out in alloc_pages %d\n",page, n);
        swap_out(check_mm_struct, n, 0);
ffffffffc0202708:	0005099b          	sext.w	s3,a0
ffffffffc020270c:	00051b17          	auipc	s6,0x51
ffffffffc0202710:	014b0b13          	addi	s6,s6,20 # ffffffffc0253720 <check_mm_struct>
ffffffffc0202714:	a01d                	j	ffffffffc020273a <alloc_pages+0x58>
            page = pmm_manager->alloc_pages(n);
ffffffffc0202716:	00093783          	ld	a5,0(s2)
ffffffffc020271a:	6f9c                	ld	a5,24(a5)
ffffffffc020271c:	9782                	jalr	a5
ffffffffc020271e:	842a                	mv	s0,a0
        swap_out(check_mm_struct, n, 0);
ffffffffc0202720:	4601                	li	a2,0
ffffffffc0202722:	85ce                	mv	a1,s3
        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc0202724:	ec0d                	bnez	s0,ffffffffc020275e <alloc_pages+0x7c>
ffffffffc0202726:	029a6c63          	bltu	s4,s1,ffffffffc020275e <alloc_pages+0x7c>
ffffffffc020272a:	000aa783          	lw	a5,0(s5)
ffffffffc020272e:	2781                	sext.w	a5,a5
ffffffffc0202730:	c79d                	beqz	a5,ffffffffc020275e <alloc_pages+0x7c>
        swap_out(check_mm_struct, n, 0);
ffffffffc0202732:	000b3503          	ld	a0,0(s6)
ffffffffc0202736:	b5eff0ef          	jal	ra,ffffffffc0201a94 <swap_out>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020273a:	100027f3          	csrr	a5,sstatus
ffffffffc020273e:	8b89                	andi	a5,a5,2
            page = pmm_manager->alloc_pages(n);
ffffffffc0202740:	8526                	mv	a0,s1
ffffffffc0202742:	dbf1                	beqz	a5,ffffffffc0202716 <alloc_pages+0x34>
        intr_disable();
ffffffffc0202744:	eeffd0ef          	jal	ra,ffffffffc0200632 <intr_disable>
ffffffffc0202748:	00093783          	ld	a5,0(s2)
ffffffffc020274c:	8526                	mv	a0,s1
ffffffffc020274e:	6f9c                	ld	a5,24(a5)
ffffffffc0202750:	9782                	jalr	a5
ffffffffc0202752:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202754:	ed9fd0ef          	jal	ra,ffffffffc020062c <intr_enable>
        swap_out(check_mm_struct, n, 0);
ffffffffc0202758:	4601                	li	a2,0
ffffffffc020275a:	85ce                	mv	a1,s3
        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc020275c:	d469                	beqz	s0,ffffffffc0202726 <alloc_pages+0x44>
    }
    // cprintf("n %d,get page %x, No %d in alloc_pages\n",n,page,(page-pages));
    return page;
}
ffffffffc020275e:	70e2                	ld	ra,56(sp)
ffffffffc0202760:	8522                	mv	a0,s0
ffffffffc0202762:	7442                	ld	s0,48(sp)
ffffffffc0202764:	74a2                	ld	s1,40(sp)
ffffffffc0202766:	7902                	ld	s2,32(sp)
ffffffffc0202768:	69e2                	ld	s3,24(sp)
ffffffffc020276a:	6a42                	ld	s4,16(sp)
ffffffffc020276c:	6aa2                	ld	s5,8(sp)
ffffffffc020276e:	6b02                	ld	s6,0(sp)
ffffffffc0202770:	6121                	addi	sp,sp,64
ffffffffc0202772:	8082                	ret

ffffffffc0202774 <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202774:	100027f3          	csrr	a5,sstatus
ffffffffc0202778:	8b89                	andi	a5,a5,2
ffffffffc020277a:	eb81                	bnez	a5,ffffffffc020278a <free_pages+0x16>
// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc020277c:	00051797          	auipc	a5,0x51
ffffffffc0202780:	09c7b783          	ld	a5,156(a5) # ffffffffc0253818 <pmm_manager>
ffffffffc0202784:	0207b303          	ld	t1,32(a5)
ffffffffc0202788:	8302                	jr	t1
void free_pages(struct Page *base, size_t n) {
ffffffffc020278a:	1101                	addi	sp,sp,-32
ffffffffc020278c:	ec06                	sd	ra,24(sp)
ffffffffc020278e:	e822                	sd	s0,16(sp)
ffffffffc0202790:	e426                	sd	s1,8(sp)
ffffffffc0202792:	842a                	mv	s0,a0
ffffffffc0202794:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc0202796:	e9dfd0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc020279a:	00051797          	auipc	a5,0x51
ffffffffc020279e:	07e7b783          	ld	a5,126(a5) # ffffffffc0253818 <pmm_manager>
ffffffffc02027a2:	739c                	ld	a5,32(a5)
ffffffffc02027a4:	85a6                	mv	a1,s1
ffffffffc02027a6:	8522                	mv	a0,s0
ffffffffc02027a8:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc02027aa:	6442                	ld	s0,16(sp)
ffffffffc02027ac:	60e2                	ld	ra,24(sp)
ffffffffc02027ae:	64a2                	ld	s1,8(sp)
ffffffffc02027b0:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc02027b2:	e7bfd06f          	j	ffffffffc020062c <intr_enable>

ffffffffc02027b6 <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02027b6:	100027f3          	csrr	a5,sstatus
ffffffffc02027ba:	8b89                	andi	a5,a5,2
ffffffffc02027bc:	eb81                	bnez	a5,ffffffffc02027cc <nr_free_pages+0x16>
size_t nr_free_pages(void) {
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc02027be:	00051797          	auipc	a5,0x51
ffffffffc02027c2:	05a7b783          	ld	a5,90(a5) # ffffffffc0253818 <pmm_manager>
ffffffffc02027c6:	0287b303          	ld	t1,40(a5)
ffffffffc02027ca:	8302                	jr	t1
size_t nr_free_pages(void) {
ffffffffc02027cc:	1141                	addi	sp,sp,-16
ffffffffc02027ce:	e406                	sd	ra,8(sp)
ffffffffc02027d0:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc02027d2:	e61fd0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc02027d6:	00051797          	auipc	a5,0x51
ffffffffc02027da:	0427b783          	ld	a5,66(a5) # ffffffffc0253818 <pmm_manager>
ffffffffc02027de:	779c                	ld	a5,40(a5)
ffffffffc02027e0:	9782                	jalr	a5
ffffffffc02027e2:	842a                	mv	s0,a0
        intr_enable();
ffffffffc02027e4:	e49fd0ef          	jal	ra,ffffffffc020062c <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc02027e8:	60a2                	ld	ra,8(sp)
ffffffffc02027ea:	8522                	mv	a0,s0
ffffffffc02027ec:	6402                	ld	s0,0(sp)
ffffffffc02027ee:	0141                	addi	sp,sp,16
ffffffffc02027f0:	8082                	ret

ffffffffc02027f2 <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc02027f2:	00003797          	auipc	a5,0x3
ffffffffc02027f6:	78678793          	addi	a5,a5,1926 # ffffffffc0205f78 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc02027fa:	638c                	ld	a1,0(a5)
}

// pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup
// paging mechanism
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void pmm_init(void) {
ffffffffc02027fc:	1101                	addi	sp,sp,-32
ffffffffc02027fe:	e426                	sd	s1,8(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202800:	00003517          	auipc	a0,0x3
ffffffffc0202804:	7b050513          	addi	a0,a0,1968 # ffffffffc0205fb0 <default_pmm_manager+0x38>
    pmm_manager = &default_pmm_manager;
ffffffffc0202808:	00051497          	auipc	s1,0x51
ffffffffc020280c:	01048493          	addi	s1,s1,16 # ffffffffc0253818 <pmm_manager>
void pmm_init(void) {
ffffffffc0202810:	ec06                	sd	ra,24(sp)
ffffffffc0202812:	e822                	sd	s0,16(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc0202814:	e09c                	sd	a5,0(s1)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202816:	8b3fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    pmm_manager->init();
ffffffffc020281a:	609c                	ld	a5,0(s1)
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc020281c:	00051417          	auipc	s0,0x51
ffffffffc0202820:	00440413          	addi	s0,s0,4 # ffffffffc0253820 <va_pa_offset>
    pmm_manager->init();
ffffffffc0202824:	679c                	ld	a5,8(a5)
ffffffffc0202826:	9782                	jalr	a5
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc0202828:	57f5                	li	a5,-3
ffffffffc020282a:	07fa                	slli	a5,a5,0x1e
    cprintf("physcial memory map:\n");
ffffffffc020282c:	00003517          	auipc	a0,0x3
ffffffffc0202830:	79c50513          	addi	a0,a0,1948 # ffffffffc0205fc8 <default_pmm_manager+0x50>
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc0202834:	e01c                	sd	a5,0(s0)
    cprintf("physcial memory map:\n");
ffffffffc0202836:	893fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  memory: 0x%08lx, [0x%08lx, 0x%08lx].\n", mem_size, mem_begin,
ffffffffc020283a:	44300693          	li	a3,1091
ffffffffc020283e:	06d6                	slli	a3,a3,0x15
ffffffffc0202840:	40100613          	li	a2,1025
ffffffffc0202844:	0656                	slli	a2,a2,0x15
ffffffffc0202846:	088005b7          	lui	a1,0x8800
ffffffffc020284a:	16fd                	addi	a3,a3,-1
ffffffffc020284c:	00003517          	auipc	a0,0x3
ffffffffc0202850:	79450513          	addi	a0,a0,1940 # ffffffffc0205fe0 <default_pmm_manager+0x68>
ffffffffc0202854:	875fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0202858:	777d                	lui	a4,0xfffff
ffffffffc020285a:	00052797          	auipc	a5,0x52
ffffffffc020285e:	fed78793          	addi	a5,a5,-19 # ffffffffc0254847 <end+0xfff>
ffffffffc0202862:	8ff9                	and	a5,a5,a4
    npage = maxpa / PGSIZE;
ffffffffc0202864:	00088737          	lui	a4,0x88
ffffffffc0202868:	60070713          	addi	a4,a4,1536 # 88600 <_binary_obj___user_ex2_out_size+0x7d890>
ffffffffc020286c:	00051597          	auipc	a1,0x51
ffffffffc0202870:	e7458593          	addi	a1,a1,-396 # ffffffffc02536e0 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0202874:	00051617          	auipc	a2,0x51
ffffffffc0202878:	fbc60613          	addi	a2,a2,-68 # ffffffffc0253830 <pages>
    npage = maxpa / PGSIZE;
ffffffffc020287c:	e198                	sd	a4,0(a1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc020287e:	e21c                	sd	a5,0(a2)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0202880:	4701                	li	a4,0
ffffffffc0202882:	4505                	li	a0,1
ffffffffc0202884:	fff80837          	lui	a6,0xfff80
ffffffffc0202888:	a011                	j	ffffffffc020288c <pmm_init+0x9a>
ffffffffc020288a:	621c                	ld	a5,0(a2)
        SetPageReserved(pages + i);
ffffffffc020288c:	00671693          	slli	a3,a4,0x6
ffffffffc0202890:	97b6                	add	a5,a5,a3
ffffffffc0202892:	07a1                	addi	a5,a5,8
ffffffffc0202894:	40a7b02f          	amoor.d	zero,a0,(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0202898:	0005b883          	ld	a7,0(a1)
ffffffffc020289c:	0705                	addi	a4,a4,1
ffffffffc020289e:	010886b3          	add	a3,a7,a6
ffffffffc02028a2:	fed764e3          	bltu	a4,a3,ffffffffc020288a <pmm_init+0x98>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02028a6:	6208                	ld	a0,0(a2)
ffffffffc02028a8:	069a                	slli	a3,a3,0x6
ffffffffc02028aa:	c02007b7          	lui	a5,0xc0200
ffffffffc02028ae:	96aa                	add	a3,a3,a0
ffffffffc02028b0:	06f6e263          	bltu	a3,a5,ffffffffc0202914 <pmm_init+0x122>
ffffffffc02028b4:	601c                	ld	a5,0(s0)
    if (freemem < mem_end) {
ffffffffc02028b6:	44300593          	li	a1,1091
ffffffffc02028ba:	05d6                	slli	a1,a1,0x15
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02028bc:	8e9d                	sub	a3,a3,a5
    if (freemem < mem_end) {
ffffffffc02028be:	02b6f363          	bgeu	a3,a1,ffffffffc02028e4 <pmm_init+0xf2>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc02028c2:	6785                	lui	a5,0x1
ffffffffc02028c4:	17fd                	addi	a5,a5,-1
ffffffffc02028c6:	96be                	add	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc02028c8:	00c6d793          	srli	a5,a3,0xc
ffffffffc02028cc:	0717fc63          	bgeu	a5,a7,ffffffffc0202944 <pmm_init+0x152>
    pmm_manager->init_memmap(base, n);
ffffffffc02028d0:	6098                	ld	a4,0(s1)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc02028d2:	767d                	lui	a2,0xfffff
ffffffffc02028d4:	8ef1                	and	a3,a3,a2
    return &pages[PPN(pa) - nbase];
ffffffffc02028d6:	97c2                	add	a5,a5,a6
    pmm_manager->init_memmap(base, n);
ffffffffc02028d8:	6b18                	ld	a4,16(a4)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc02028da:	8d95                	sub	a1,a1,a3
ffffffffc02028dc:	079a                	slli	a5,a5,0x6
    pmm_manager->init_memmap(base, n);
ffffffffc02028de:	81b1                	srli	a1,a1,0xc
ffffffffc02028e0:	953e                	add	a0,a0,a5
ffffffffc02028e2:	9702                	jalr	a4
    // pmm
    //check_alloc_page();

    // create boot_pgdir, an initial page directory(Page Directory Table, PDT)
    extern char boot_page_table_sv39[];
    boot_pgdir = (pte_t*)boot_page_table_sv39;
ffffffffc02028e4:	00007697          	auipc	a3,0x7
ffffffffc02028e8:	71c68693          	addi	a3,a3,1820 # ffffffffc020a000 <boot_page_table_sv39>
ffffffffc02028ec:	00051797          	auipc	a5,0x51
ffffffffc02028f0:	ded7b623          	sd	a3,-532(a5) # ffffffffc02536d8 <boot_pgdir>
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc02028f4:	c02007b7          	lui	a5,0xc0200
ffffffffc02028f8:	02f6ea63          	bltu	a3,a5,ffffffffc020292c <pmm_init+0x13a>
ffffffffc02028fc:	601c                	ld	a5,0(s0)
    // check the correctness of the basic virtual memory map.
    //check_boot_pgdir();


    kmalloc_init();
}
ffffffffc02028fe:	6442                	ld	s0,16(sp)
ffffffffc0202900:	60e2                	ld	ra,24(sp)
ffffffffc0202902:	64a2                	ld	s1,8(sp)
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc0202904:	8e9d                	sub	a3,a3,a5
ffffffffc0202906:	00051797          	auipc	a5,0x51
ffffffffc020290a:	f2d7b123          	sd	a3,-222(a5) # ffffffffc0253828 <boot_cr3>
}
ffffffffc020290e:	6105                	addi	sp,sp,32
    kmalloc_init();
ffffffffc0202910:	f37fe06f          	j	ffffffffc0201846 <kmalloc_init>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0202914:	00003617          	auipc	a2,0x3
ffffffffc0202918:	13c60613          	addi	a2,a2,316 # ffffffffc0205a50 <commands+0xb00>
ffffffffc020291c:	07f00593          	li	a1,127
ffffffffc0202920:	00003517          	auipc	a0,0x3
ffffffffc0202924:	6e850513          	addi	a0,a0,1768 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202928:	8ddfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc020292c:	00003617          	auipc	a2,0x3
ffffffffc0202930:	12460613          	addi	a2,a2,292 # ffffffffc0205a50 <commands+0xb00>
ffffffffc0202934:	0c100593          	li	a1,193
ffffffffc0202938:	00003517          	auipc	a0,0x3
ffffffffc020293c:	6d050513          	addi	a0,a0,1744 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202940:	8c5fd0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc0202944:	d83ff0ef          	jal	ra,ffffffffc02026c6 <pa2page.part.0>

ffffffffc0202948 <get_pte>:
     *   PTE_W           0x002                   // page table/directory entry
     * flags bit : Writeable
     *   PTE_U           0x004                   // page table/directory entry
     * flags bit : User can access
     */
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0202948:	01e5d793          	srli	a5,a1,0x1e
ffffffffc020294c:	1ff7f793          	andi	a5,a5,511
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0202950:	7139                	addi	sp,sp,-64
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0202952:	078e                	slli	a5,a5,0x3
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0202954:	f426                	sd	s1,40(sp)
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0202956:	00f504b3          	add	s1,a0,a5
    if (!(*pdep1 & PTE_V)) {
ffffffffc020295a:	6094                	ld	a3,0(s1)
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc020295c:	f04a                	sd	s2,32(sp)
ffffffffc020295e:	ec4e                	sd	s3,24(sp)
ffffffffc0202960:	e852                	sd	s4,16(sp)
ffffffffc0202962:	fc06                	sd	ra,56(sp)
ffffffffc0202964:	f822                	sd	s0,48(sp)
ffffffffc0202966:	e456                	sd	s5,8(sp)
ffffffffc0202968:	e05a                	sd	s6,0(sp)
    if (!(*pdep1 & PTE_V)) {
ffffffffc020296a:	0016f793          	andi	a5,a3,1
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc020296e:	892e                	mv	s2,a1
ffffffffc0202970:	89b2                	mv	s3,a2
ffffffffc0202972:	00051a17          	auipc	s4,0x51
ffffffffc0202976:	d6ea0a13          	addi	s4,s4,-658 # ffffffffc02536e0 <npage>
    if (!(*pdep1 & PTE_V)) {
ffffffffc020297a:	e7b5                	bnez	a5,ffffffffc02029e6 <get_pte+0x9e>
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL) {
ffffffffc020297c:	12060b63          	beqz	a2,ffffffffc0202ab2 <get_pte+0x16a>
ffffffffc0202980:	4505                	li	a0,1
ffffffffc0202982:	d61ff0ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0202986:	842a                	mv	s0,a0
ffffffffc0202988:	12050563          	beqz	a0,ffffffffc0202ab2 <get_pte+0x16a>
    return page - pages + nbase;
ffffffffc020298c:	00051b17          	auipc	s6,0x51
ffffffffc0202990:	ea4b0b13          	addi	s6,s6,-348 # ffffffffc0253830 <pages>
ffffffffc0202994:	000b3503          	ld	a0,0(s6)
ffffffffc0202998:	00080ab7          	lui	s5,0x80
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc020299c:	00051a17          	auipc	s4,0x51
ffffffffc02029a0:	d44a0a13          	addi	s4,s4,-700 # ffffffffc02536e0 <npage>
ffffffffc02029a4:	40a40533          	sub	a0,s0,a0
ffffffffc02029a8:	8519                	srai	a0,a0,0x6
ffffffffc02029aa:	9556                	add	a0,a0,s5
ffffffffc02029ac:	000a3703          	ld	a4,0(s4)
ffffffffc02029b0:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc02029b4:	4685                	li	a3,1
ffffffffc02029b6:	c014                	sw	a3,0(s0)
ffffffffc02029b8:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02029ba:	0532                	slli	a0,a0,0xc
ffffffffc02029bc:	14e7f263          	bgeu	a5,a4,ffffffffc0202b00 <get_pte+0x1b8>
ffffffffc02029c0:	00051797          	auipc	a5,0x51
ffffffffc02029c4:	e607b783          	ld	a5,-416(a5) # ffffffffc0253820 <va_pa_offset>
ffffffffc02029c8:	6605                	lui	a2,0x1
ffffffffc02029ca:	4581                	li	a1,0
ffffffffc02029cc:	953e                	add	a0,a0,a5
ffffffffc02029ce:	6b3010ef          	jal	ra,ffffffffc0204880 <memset>
    return page - pages + nbase;
ffffffffc02029d2:	000b3683          	ld	a3,0(s6)
ffffffffc02029d6:	40d406b3          	sub	a3,s0,a3
ffffffffc02029da:	8699                	srai	a3,a3,0x6
ffffffffc02029dc:	96d6                	add	a3,a3,s5
  asm volatile("sfence.vm");
}

// construct PTE from a page and permission bits
static inline pte_t pte_create(uintptr_t ppn, int type) {
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc02029de:	06aa                	slli	a3,a3,0xa
ffffffffc02029e0:	0116e693          	ori	a3,a3,17
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc02029e4:	e094                	sd	a3,0(s1)
    }

    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc02029e6:	77fd                	lui	a5,0xfffff
ffffffffc02029e8:	068a                	slli	a3,a3,0x2
ffffffffc02029ea:	000a3703          	ld	a4,0(s4)
ffffffffc02029ee:	8efd                	and	a3,a3,a5
ffffffffc02029f0:	00c6d793          	srli	a5,a3,0xc
ffffffffc02029f4:	0ce7f163          	bgeu	a5,a4,ffffffffc0202ab6 <get_pte+0x16e>
ffffffffc02029f8:	00051a97          	auipc	s5,0x51
ffffffffc02029fc:	e28a8a93          	addi	s5,s5,-472 # ffffffffc0253820 <va_pa_offset>
ffffffffc0202a00:	000ab403          	ld	s0,0(s5)
ffffffffc0202a04:	01595793          	srli	a5,s2,0x15
ffffffffc0202a08:	1ff7f793          	andi	a5,a5,511
ffffffffc0202a0c:	96a2                	add	a3,a3,s0
ffffffffc0202a0e:	00379413          	slli	s0,a5,0x3
ffffffffc0202a12:	9436                	add	s0,s0,a3
    if (!(*pdep0 & PTE_V)) {
ffffffffc0202a14:	6014                	ld	a3,0(s0)
ffffffffc0202a16:	0016f793          	andi	a5,a3,1
ffffffffc0202a1a:	e3ad                	bnez	a5,ffffffffc0202a7c <get_pte+0x134>
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL) {
ffffffffc0202a1c:	08098b63          	beqz	s3,ffffffffc0202ab2 <get_pte+0x16a>
ffffffffc0202a20:	4505                	li	a0,1
ffffffffc0202a22:	cc1ff0ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0202a26:	84aa                	mv	s1,a0
ffffffffc0202a28:	c549                	beqz	a0,ffffffffc0202ab2 <get_pte+0x16a>
    return page - pages + nbase;
ffffffffc0202a2a:	00051b17          	auipc	s6,0x51
ffffffffc0202a2e:	e06b0b13          	addi	s6,s6,-506 # ffffffffc0253830 <pages>
ffffffffc0202a32:	000b3503          	ld	a0,0(s6)
ffffffffc0202a36:	000809b7          	lui	s3,0x80
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202a3a:	000a3703          	ld	a4,0(s4)
ffffffffc0202a3e:	40a48533          	sub	a0,s1,a0
ffffffffc0202a42:	8519                	srai	a0,a0,0x6
ffffffffc0202a44:	954e                	add	a0,a0,s3
ffffffffc0202a46:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0202a4a:	4685                	li	a3,1
ffffffffc0202a4c:	c094                	sw	a3,0(s1)
ffffffffc0202a4e:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0202a50:	0532                	slli	a0,a0,0xc
ffffffffc0202a52:	08e7fa63          	bgeu	a5,a4,ffffffffc0202ae6 <get_pte+0x19e>
ffffffffc0202a56:	000ab783          	ld	a5,0(s5)
ffffffffc0202a5a:	6605                	lui	a2,0x1
ffffffffc0202a5c:	4581                	li	a1,0
ffffffffc0202a5e:	953e                	add	a0,a0,a5
ffffffffc0202a60:	621010ef          	jal	ra,ffffffffc0204880 <memset>
    return page - pages + nbase;
ffffffffc0202a64:	000b3683          	ld	a3,0(s6)
ffffffffc0202a68:	40d486b3          	sub	a3,s1,a3
ffffffffc0202a6c:	8699                	srai	a3,a3,0x6
ffffffffc0202a6e:	96ce                	add	a3,a3,s3
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0202a70:	06aa                	slli	a3,a3,0xa
ffffffffc0202a72:	0116e693          	ori	a3,a3,17
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0202a76:	e014                	sd	a3,0(s0)
ffffffffc0202a78:	000a3703          	ld	a4,0(s4)
        }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc0202a7c:	068a                	slli	a3,a3,0x2
ffffffffc0202a7e:	757d                	lui	a0,0xfffff
ffffffffc0202a80:	8ee9                	and	a3,a3,a0
ffffffffc0202a82:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202a86:	04e7f463          	bgeu	a5,a4,ffffffffc0202ace <get_pte+0x186>
ffffffffc0202a8a:	000ab503          	ld	a0,0(s5)
ffffffffc0202a8e:	00c95913          	srli	s2,s2,0xc
ffffffffc0202a92:	1ff97913          	andi	s2,s2,511
ffffffffc0202a96:	96aa                	add	a3,a3,a0
ffffffffc0202a98:	00391513          	slli	a0,s2,0x3
ffffffffc0202a9c:	9536                	add	a0,a0,a3
}
ffffffffc0202a9e:	70e2                	ld	ra,56(sp)
ffffffffc0202aa0:	7442                	ld	s0,48(sp)
ffffffffc0202aa2:	74a2                	ld	s1,40(sp)
ffffffffc0202aa4:	7902                	ld	s2,32(sp)
ffffffffc0202aa6:	69e2                	ld	s3,24(sp)
ffffffffc0202aa8:	6a42                	ld	s4,16(sp)
ffffffffc0202aaa:	6aa2                	ld	s5,8(sp)
ffffffffc0202aac:	6b02                	ld	s6,0(sp)
ffffffffc0202aae:	6121                	addi	sp,sp,64
ffffffffc0202ab0:	8082                	ret
            return NULL;
ffffffffc0202ab2:	4501                	li	a0,0
ffffffffc0202ab4:	b7ed                	j	ffffffffc0202a9e <get_pte+0x156>
    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0202ab6:	00003617          	auipc	a2,0x3
ffffffffc0202aba:	f2a60613          	addi	a2,a2,-214 # ffffffffc02059e0 <commands+0xa90>
ffffffffc0202abe:	0fe00593          	li	a1,254
ffffffffc0202ac2:	00003517          	auipc	a0,0x3
ffffffffc0202ac6:	54650513          	addi	a0,a0,1350 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202aca:	f3afd0ef          	jal	ra,ffffffffc0200204 <__panic>
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc0202ace:	00003617          	auipc	a2,0x3
ffffffffc0202ad2:	f1260613          	addi	a2,a2,-238 # ffffffffc02059e0 <commands+0xa90>
ffffffffc0202ad6:	10900593          	li	a1,265
ffffffffc0202ada:	00003517          	auipc	a0,0x3
ffffffffc0202ade:	52e50513          	addi	a0,a0,1326 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202ae2:	f22fd0ef          	jal	ra,ffffffffc0200204 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202ae6:	86aa                	mv	a3,a0
ffffffffc0202ae8:	00003617          	auipc	a2,0x3
ffffffffc0202aec:	ef860613          	addi	a2,a2,-264 # ffffffffc02059e0 <commands+0xa90>
ffffffffc0202af0:	10600593          	li	a1,262
ffffffffc0202af4:	00003517          	auipc	a0,0x3
ffffffffc0202af8:	51450513          	addi	a0,a0,1300 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202afc:	f08fd0ef          	jal	ra,ffffffffc0200204 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202b00:	86aa                	mv	a3,a0
ffffffffc0202b02:	00003617          	auipc	a2,0x3
ffffffffc0202b06:	ede60613          	addi	a2,a2,-290 # ffffffffc02059e0 <commands+0xa90>
ffffffffc0202b0a:	0fa00593          	li	a1,250
ffffffffc0202b0e:	00003517          	auipc	a0,0x3
ffffffffc0202b12:	4fa50513          	addi	a0,a0,1274 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202b16:	eeefd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0202b1a <unmap_range>:
        *ptep = 0;                  //(5) clear second page table entry
        tlb_invalidate(pgdir, la);  //(6) flush tlb
    }
}

void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc0202b1a:	711d                	addi	sp,sp,-96
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202b1c:	00c5e7b3          	or	a5,a1,a2
void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc0202b20:	ec86                	sd	ra,88(sp)
ffffffffc0202b22:	e8a2                	sd	s0,80(sp)
ffffffffc0202b24:	e4a6                	sd	s1,72(sp)
ffffffffc0202b26:	e0ca                	sd	s2,64(sp)
ffffffffc0202b28:	fc4e                	sd	s3,56(sp)
ffffffffc0202b2a:	f852                	sd	s4,48(sp)
ffffffffc0202b2c:	f456                	sd	s5,40(sp)
ffffffffc0202b2e:	f05a                	sd	s6,32(sp)
ffffffffc0202b30:	ec5e                	sd	s7,24(sp)
ffffffffc0202b32:	e862                	sd	s8,16(sp)
ffffffffc0202b34:	e466                	sd	s9,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202b36:	17d2                	slli	a5,a5,0x34
ffffffffc0202b38:	ebf1                	bnez	a5,ffffffffc0202c0c <unmap_range+0xf2>
    assert(USER_ACCESS(start, end));
ffffffffc0202b3a:	002007b7          	lui	a5,0x200
ffffffffc0202b3e:	842e                	mv	s0,a1
ffffffffc0202b40:	0af5e663          	bltu	a1,a5,ffffffffc0202bec <unmap_range+0xd2>
ffffffffc0202b44:	8932                	mv	s2,a2
ffffffffc0202b46:	0ac5f363          	bgeu	a1,a2,ffffffffc0202bec <unmap_range+0xd2>
ffffffffc0202b4a:	4785                	li	a5,1
ffffffffc0202b4c:	07fe                	slli	a5,a5,0x1f
ffffffffc0202b4e:	08c7ef63          	bltu	a5,a2,ffffffffc0202bec <unmap_range+0xd2>
ffffffffc0202b52:	89aa                	mv	s3,a0
            continue;
        }
        if (*ptep != 0) {
            page_remove_pte(pgdir, start, ptep);
        }
        start += PGSIZE;
ffffffffc0202b54:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage) {
ffffffffc0202b56:	00051c97          	auipc	s9,0x51
ffffffffc0202b5a:	b8ac8c93          	addi	s9,s9,-1142 # ffffffffc02536e0 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc0202b5e:	00051c17          	auipc	s8,0x51
ffffffffc0202b62:	cd2c0c13          	addi	s8,s8,-814 # ffffffffc0253830 <pages>
ffffffffc0202b66:	fff80bb7          	lui	s7,0xfff80
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0202b6a:	00200b37          	lui	s6,0x200
ffffffffc0202b6e:	ffe00ab7          	lui	s5,0xffe00
        pte_t *ptep = get_pte(pgdir, start, 0);
ffffffffc0202b72:	4601                	li	a2,0
ffffffffc0202b74:	85a2                	mv	a1,s0
ffffffffc0202b76:	854e                	mv	a0,s3
ffffffffc0202b78:	dd1ff0ef          	jal	ra,ffffffffc0202948 <get_pte>
ffffffffc0202b7c:	84aa                	mv	s1,a0
        if (ptep == NULL) {
ffffffffc0202b7e:	cd21                	beqz	a0,ffffffffc0202bd6 <unmap_range+0xbc>
        if (*ptep != 0) {
ffffffffc0202b80:	611c                	ld	a5,0(a0)
ffffffffc0202b82:	e38d                	bnez	a5,ffffffffc0202ba4 <unmap_range+0x8a>
        start += PGSIZE;
ffffffffc0202b84:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0202b86:	ff2466e3          	bltu	s0,s2,ffffffffc0202b72 <unmap_range+0x58>
}
ffffffffc0202b8a:	60e6                	ld	ra,88(sp)
ffffffffc0202b8c:	6446                	ld	s0,80(sp)
ffffffffc0202b8e:	64a6                	ld	s1,72(sp)
ffffffffc0202b90:	6906                	ld	s2,64(sp)
ffffffffc0202b92:	79e2                	ld	s3,56(sp)
ffffffffc0202b94:	7a42                	ld	s4,48(sp)
ffffffffc0202b96:	7aa2                	ld	s5,40(sp)
ffffffffc0202b98:	7b02                	ld	s6,32(sp)
ffffffffc0202b9a:	6be2                	ld	s7,24(sp)
ffffffffc0202b9c:	6c42                	ld	s8,16(sp)
ffffffffc0202b9e:	6ca2                	ld	s9,8(sp)
ffffffffc0202ba0:	6125                	addi	sp,sp,96
ffffffffc0202ba2:	8082                	ret
    if (*ptep & PTE_V) {  //(1) check if this page table entry is
ffffffffc0202ba4:	0017f713          	andi	a4,a5,1
ffffffffc0202ba8:	df71                	beqz	a4,ffffffffc0202b84 <unmap_range+0x6a>
    if (PPN(pa) >= npage) {
ffffffffc0202baa:	000cb703          	ld	a4,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202bae:	078a                	slli	a5,a5,0x2
ffffffffc0202bb0:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0202bb2:	06e7fd63          	bgeu	a5,a4,ffffffffc0202c2c <unmap_range+0x112>
    return &pages[PPN(pa) - nbase];
ffffffffc0202bb6:	000c3503          	ld	a0,0(s8)
ffffffffc0202bba:	97de                	add	a5,a5,s7
ffffffffc0202bbc:	079a                	slli	a5,a5,0x6
ffffffffc0202bbe:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc0202bc0:	411c                	lw	a5,0(a0)
ffffffffc0202bc2:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202bc6:	c118                	sw	a4,0(a0)
        if (page_ref(page) ==
ffffffffc0202bc8:	cf11                	beqz	a4,ffffffffc0202be4 <unmap_range+0xca>
        *ptep = 0;                  //(5) clear second page table entry
ffffffffc0202bca:	0004b023          	sd	zero,0(s1)
}

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void tlb_invalidate(pde_t *pgdir, uintptr_t la) {
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202bce:	12040073          	sfence.vma	s0
        start += PGSIZE;
ffffffffc0202bd2:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0202bd4:	bf4d                	j	ffffffffc0202b86 <unmap_range+0x6c>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0202bd6:	945a                	add	s0,s0,s6
ffffffffc0202bd8:	01547433          	and	s0,s0,s5
    } while (start != 0 && start < end);
ffffffffc0202bdc:	d45d                	beqz	s0,ffffffffc0202b8a <unmap_range+0x70>
ffffffffc0202bde:	f9246ae3          	bltu	s0,s2,ffffffffc0202b72 <unmap_range+0x58>
ffffffffc0202be2:	b765                	j	ffffffffc0202b8a <unmap_range+0x70>
            free_page(page);
ffffffffc0202be4:	4585                	li	a1,1
ffffffffc0202be6:	b8fff0ef          	jal	ra,ffffffffc0202774 <free_pages>
ffffffffc0202bea:	b7c5                	j	ffffffffc0202bca <unmap_range+0xb0>
    assert(USER_ACCESS(start, end));
ffffffffc0202bec:	00003697          	auipc	a3,0x3
ffffffffc0202bf0:	45c68693          	addi	a3,a3,1116 # ffffffffc0206048 <default_pmm_manager+0xd0>
ffffffffc0202bf4:	00002617          	auipc	a2,0x2
ffffffffc0202bf8:	76460613          	addi	a2,a2,1892 # ffffffffc0205358 <commands+0x408>
ffffffffc0202bfc:	14100593          	li	a1,321
ffffffffc0202c00:	00003517          	auipc	a0,0x3
ffffffffc0202c04:	40850513          	addi	a0,a0,1032 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202c08:	dfcfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202c0c:	00003697          	auipc	a3,0x3
ffffffffc0202c10:	40c68693          	addi	a3,a3,1036 # ffffffffc0206018 <default_pmm_manager+0xa0>
ffffffffc0202c14:	00002617          	auipc	a2,0x2
ffffffffc0202c18:	74460613          	addi	a2,a2,1860 # ffffffffc0205358 <commands+0x408>
ffffffffc0202c1c:	14000593          	li	a1,320
ffffffffc0202c20:	00003517          	auipc	a0,0x3
ffffffffc0202c24:	3e850513          	addi	a0,a0,1000 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202c28:	ddcfd0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc0202c2c:	a9bff0ef          	jal	ra,ffffffffc02026c6 <pa2page.part.0>

ffffffffc0202c30 <exit_range>:
void exit_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc0202c30:	715d                	addi	sp,sp,-80
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202c32:	00c5e7b3          	or	a5,a1,a2
void exit_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc0202c36:	e486                	sd	ra,72(sp)
ffffffffc0202c38:	e0a2                	sd	s0,64(sp)
ffffffffc0202c3a:	fc26                	sd	s1,56(sp)
ffffffffc0202c3c:	f84a                	sd	s2,48(sp)
ffffffffc0202c3e:	f44e                	sd	s3,40(sp)
ffffffffc0202c40:	f052                	sd	s4,32(sp)
ffffffffc0202c42:	ec56                	sd	s5,24(sp)
ffffffffc0202c44:	e85a                	sd	s6,16(sp)
ffffffffc0202c46:	e45e                	sd	s7,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202c48:	17d2                	slli	a5,a5,0x34
ffffffffc0202c4a:	e3f1                	bnez	a5,ffffffffc0202d0e <exit_range+0xde>
    assert(USER_ACCESS(start, end));
ffffffffc0202c4c:	002007b7          	lui	a5,0x200
ffffffffc0202c50:	08f5ef63          	bltu	a1,a5,ffffffffc0202cee <exit_range+0xbe>
ffffffffc0202c54:	89b2                	mv	s3,a2
ffffffffc0202c56:	08c5fc63          	bgeu	a1,a2,ffffffffc0202cee <exit_range+0xbe>
ffffffffc0202c5a:	4785                	li	a5,1
    start = ROUNDDOWN(start, PTSIZE);
ffffffffc0202c5c:	ffe004b7          	lui	s1,0xffe00
    assert(USER_ACCESS(start, end));
ffffffffc0202c60:	07fe                	slli	a5,a5,0x1f
    start = ROUNDDOWN(start, PTSIZE);
ffffffffc0202c62:	8ced                	and	s1,s1,a1
    assert(USER_ACCESS(start, end));
ffffffffc0202c64:	08c7e563          	bltu	a5,a2,ffffffffc0202cee <exit_range+0xbe>
ffffffffc0202c68:	8a2a                	mv	s4,a0
    if (PPN(pa) >= npage) {
ffffffffc0202c6a:	00051b17          	auipc	s6,0x51
ffffffffc0202c6e:	a76b0b13          	addi	s6,s6,-1418 # ffffffffc02536e0 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc0202c72:	00051b97          	auipc	s7,0x51
ffffffffc0202c76:	bbeb8b93          	addi	s7,s7,-1090 # ffffffffc0253830 <pages>
ffffffffc0202c7a:	fff80937          	lui	s2,0xfff80
        start += PTSIZE;
ffffffffc0202c7e:	00200ab7          	lui	s5,0x200
ffffffffc0202c82:	a019                	j	ffffffffc0202c88 <exit_range+0x58>
    } while (start != 0 && start < end);
ffffffffc0202c84:	0334fe63          	bgeu	s1,s3,ffffffffc0202cc0 <exit_range+0x90>
        int pde_idx = PDX1(start);
ffffffffc0202c88:	01e4d413          	srli	s0,s1,0x1e
        if (pgdir[pde_idx] & PTE_V) {
ffffffffc0202c8c:	1ff47413          	andi	s0,s0,511
ffffffffc0202c90:	040e                	slli	s0,s0,0x3
ffffffffc0202c92:	9452                	add	s0,s0,s4
ffffffffc0202c94:	601c                	ld	a5,0(s0)
ffffffffc0202c96:	0017f713          	andi	a4,a5,1
ffffffffc0202c9a:	c30d                	beqz	a4,ffffffffc0202cbc <exit_range+0x8c>
    if (PPN(pa) >= npage) {
ffffffffc0202c9c:	000b3703          	ld	a4,0(s6)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202ca0:	078a                	slli	a5,a5,0x2
ffffffffc0202ca2:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0202ca4:	02e7f963          	bgeu	a5,a4,ffffffffc0202cd6 <exit_range+0xa6>
    return &pages[PPN(pa) - nbase];
ffffffffc0202ca8:	000bb503          	ld	a0,0(s7)
ffffffffc0202cac:	97ca                	add	a5,a5,s2
ffffffffc0202cae:	079a                	slli	a5,a5,0x6
            free_page(pde2page(pgdir[pde_idx]));
ffffffffc0202cb0:	4585                	li	a1,1
ffffffffc0202cb2:	953e                	add	a0,a0,a5
ffffffffc0202cb4:	ac1ff0ef          	jal	ra,ffffffffc0202774 <free_pages>
            pgdir[pde_idx] = 0;
ffffffffc0202cb8:	00043023          	sd	zero,0(s0)
        start += PTSIZE;
ffffffffc0202cbc:	94d6                	add	s1,s1,s5
    } while (start != 0 && start < end);
ffffffffc0202cbe:	f0f9                	bnez	s1,ffffffffc0202c84 <exit_range+0x54>
}
ffffffffc0202cc0:	60a6                	ld	ra,72(sp)
ffffffffc0202cc2:	6406                	ld	s0,64(sp)
ffffffffc0202cc4:	74e2                	ld	s1,56(sp)
ffffffffc0202cc6:	7942                	ld	s2,48(sp)
ffffffffc0202cc8:	79a2                	ld	s3,40(sp)
ffffffffc0202cca:	7a02                	ld	s4,32(sp)
ffffffffc0202ccc:	6ae2                	ld	s5,24(sp)
ffffffffc0202cce:	6b42                	ld	s6,16(sp)
ffffffffc0202cd0:	6ba2                	ld	s7,8(sp)
ffffffffc0202cd2:	6161                	addi	sp,sp,80
ffffffffc0202cd4:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0202cd6:	00003617          	auipc	a2,0x3
ffffffffc0202cda:	da260613          	addi	a2,a2,-606 # ffffffffc0205a78 <commands+0xb28>
ffffffffc0202cde:	06200593          	li	a1,98
ffffffffc0202ce2:	00003517          	auipc	a0,0x3
ffffffffc0202ce6:	d2650513          	addi	a0,a0,-730 # ffffffffc0205a08 <commands+0xab8>
ffffffffc0202cea:	d1afd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc0202cee:	00003697          	auipc	a3,0x3
ffffffffc0202cf2:	35a68693          	addi	a3,a3,858 # ffffffffc0206048 <default_pmm_manager+0xd0>
ffffffffc0202cf6:	00002617          	auipc	a2,0x2
ffffffffc0202cfa:	66260613          	addi	a2,a2,1634 # ffffffffc0205358 <commands+0x408>
ffffffffc0202cfe:	15200593          	li	a1,338
ffffffffc0202d02:	00003517          	auipc	a0,0x3
ffffffffc0202d06:	30650513          	addi	a0,a0,774 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202d0a:	cfafd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202d0e:	00003697          	auipc	a3,0x3
ffffffffc0202d12:	30a68693          	addi	a3,a3,778 # ffffffffc0206018 <default_pmm_manager+0xa0>
ffffffffc0202d16:	00002617          	auipc	a2,0x2
ffffffffc0202d1a:	64260613          	addi	a2,a2,1602 # ffffffffc0205358 <commands+0x408>
ffffffffc0202d1e:	15100593          	li	a1,337
ffffffffc0202d22:	00003517          	auipc	a0,0x3
ffffffffc0202d26:	2e650513          	addi	a0,a0,742 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202d2a:	cdafd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0202d2e <page_insert>:
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc0202d2e:	7179                	addi	sp,sp,-48
ffffffffc0202d30:	e44e                	sd	s3,8(sp)
ffffffffc0202d32:	89b2                	mv	s3,a2
ffffffffc0202d34:	f022                	sd	s0,32(sp)
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202d36:	4605                	li	a2,1
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc0202d38:	842e                	mv	s0,a1
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202d3a:	85ce                	mv	a1,s3
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc0202d3c:	ec26                	sd	s1,24(sp)
ffffffffc0202d3e:	f406                	sd	ra,40(sp)
ffffffffc0202d40:	e84a                	sd	s2,16(sp)
ffffffffc0202d42:	e052                	sd	s4,0(sp)
ffffffffc0202d44:	84b6                	mv	s1,a3
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202d46:	c03ff0ef          	jal	ra,ffffffffc0202948 <get_pte>
    if (ptep == NULL) {
ffffffffc0202d4a:	cd41                	beqz	a0,ffffffffc0202de2 <page_insert+0xb4>
    page->ref += 1;
ffffffffc0202d4c:	4014                	lw	a3,0(s0)
    if (*ptep & PTE_V) {
ffffffffc0202d4e:	611c                	ld	a5,0(a0)
ffffffffc0202d50:	892a                	mv	s2,a0
ffffffffc0202d52:	0016871b          	addiw	a4,a3,1
ffffffffc0202d56:	c018                	sw	a4,0(s0)
ffffffffc0202d58:	0017f713          	andi	a4,a5,1
ffffffffc0202d5c:	eb1d                	bnez	a4,ffffffffc0202d92 <page_insert+0x64>
ffffffffc0202d5e:	00051717          	auipc	a4,0x51
ffffffffc0202d62:	ad273703          	ld	a4,-1326(a4) # ffffffffc0253830 <pages>
    return page - pages + nbase;
ffffffffc0202d66:	8c19                	sub	s0,s0,a4
ffffffffc0202d68:	000807b7          	lui	a5,0x80
ffffffffc0202d6c:	8419                	srai	s0,s0,0x6
ffffffffc0202d6e:	943e                	add	s0,s0,a5
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0202d70:	042a                	slli	s0,s0,0xa
ffffffffc0202d72:	8c45                	or	s0,s0,s1
ffffffffc0202d74:	00146413          	ori	s0,s0,1
    *ptep = pte_create(page2ppn(page), PTE_V | perm);
ffffffffc0202d78:	00893023          	sd	s0,0(s2) # fffffffffff80000 <end+0x3fd2c7b8>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202d7c:	12098073          	sfence.vma	s3
    return 0;
ffffffffc0202d80:	4501                	li	a0,0
}
ffffffffc0202d82:	70a2                	ld	ra,40(sp)
ffffffffc0202d84:	7402                	ld	s0,32(sp)
ffffffffc0202d86:	64e2                	ld	s1,24(sp)
ffffffffc0202d88:	6942                	ld	s2,16(sp)
ffffffffc0202d8a:	69a2                	ld	s3,8(sp)
ffffffffc0202d8c:	6a02                	ld	s4,0(sp)
ffffffffc0202d8e:	6145                	addi	sp,sp,48
ffffffffc0202d90:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc0202d92:	078a                	slli	a5,a5,0x2
ffffffffc0202d94:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0202d96:	00051717          	auipc	a4,0x51
ffffffffc0202d9a:	94a73703          	ld	a4,-1718(a4) # ffffffffc02536e0 <npage>
ffffffffc0202d9e:	04e7f463          	bgeu	a5,a4,ffffffffc0202de6 <page_insert+0xb8>
    return &pages[PPN(pa) - nbase];
ffffffffc0202da2:	00051a17          	auipc	s4,0x51
ffffffffc0202da6:	a8ea0a13          	addi	s4,s4,-1394 # ffffffffc0253830 <pages>
ffffffffc0202daa:	000a3703          	ld	a4,0(s4)
ffffffffc0202dae:	fff80537          	lui	a0,0xfff80
ffffffffc0202db2:	97aa                	add	a5,a5,a0
ffffffffc0202db4:	079a                	slli	a5,a5,0x6
ffffffffc0202db6:	97ba                	add	a5,a5,a4
        if (p == page) {
ffffffffc0202db8:	00f40a63          	beq	s0,a5,ffffffffc0202dcc <page_insert+0x9e>
    page->ref -= 1;
ffffffffc0202dbc:	4394                	lw	a3,0(a5)
ffffffffc0202dbe:	fff6861b          	addiw	a2,a3,-1
ffffffffc0202dc2:	c390                	sw	a2,0(a5)
        if (page_ref(page) ==
ffffffffc0202dc4:	c611                	beqz	a2,ffffffffc0202dd0 <page_insert+0xa2>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202dc6:	12098073          	sfence.vma	s3
}
ffffffffc0202dca:	bf71                	j	ffffffffc0202d66 <page_insert+0x38>
ffffffffc0202dcc:	c014                	sw	a3,0(s0)
    return page->ref;
ffffffffc0202dce:	bf61                	j	ffffffffc0202d66 <page_insert+0x38>
            free_page(page);
ffffffffc0202dd0:	4585                	li	a1,1
ffffffffc0202dd2:	853e                	mv	a0,a5
ffffffffc0202dd4:	9a1ff0ef          	jal	ra,ffffffffc0202774 <free_pages>
ffffffffc0202dd8:	000a3703          	ld	a4,0(s4)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202ddc:	12098073          	sfence.vma	s3
ffffffffc0202de0:	b759                	j	ffffffffc0202d66 <page_insert+0x38>
        return -E_NO_MEM;
ffffffffc0202de2:	5571                	li	a0,-4
ffffffffc0202de4:	bf79                	j	ffffffffc0202d82 <page_insert+0x54>
ffffffffc0202de6:	8e1ff0ef          	jal	ra,ffffffffc02026c6 <pa2page.part.0>

ffffffffc0202dea <copy_range>:
               bool share) {
ffffffffc0202dea:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202dec:	00d667b3          	or	a5,a2,a3
               bool share) {
ffffffffc0202df0:	f486                	sd	ra,104(sp)
ffffffffc0202df2:	f0a2                	sd	s0,96(sp)
ffffffffc0202df4:	eca6                	sd	s1,88(sp)
ffffffffc0202df6:	e8ca                	sd	s2,80(sp)
ffffffffc0202df8:	e4ce                	sd	s3,72(sp)
ffffffffc0202dfa:	e0d2                	sd	s4,64(sp)
ffffffffc0202dfc:	fc56                	sd	s5,56(sp)
ffffffffc0202dfe:	f85a                	sd	s6,48(sp)
ffffffffc0202e00:	f45e                	sd	s7,40(sp)
ffffffffc0202e02:	f062                	sd	s8,32(sp)
ffffffffc0202e04:	ec66                	sd	s9,24(sp)
ffffffffc0202e06:	e86a                	sd	s10,16(sp)
ffffffffc0202e08:	e46e                	sd	s11,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202e0a:	17d2                	slli	a5,a5,0x34
ffffffffc0202e0c:	1e079763          	bnez	a5,ffffffffc0202ffa <copy_range+0x210>
    assert(USER_ACCESS(start, end));
ffffffffc0202e10:	002007b7          	lui	a5,0x200
ffffffffc0202e14:	8432                	mv	s0,a2
ffffffffc0202e16:	16f66a63          	bltu	a2,a5,ffffffffc0202f8a <copy_range+0x1a0>
ffffffffc0202e1a:	8936                	mv	s2,a3
ffffffffc0202e1c:	16d67763          	bgeu	a2,a3,ffffffffc0202f8a <copy_range+0x1a0>
ffffffffc0202e20:	4785                	li	a5,1
ffffffffc0202e22:	07fe                	slli	a5,a5,0x1f
ffffffffc0202e24:	16d7e363          	bltu	a5,a3,ffffffffc0202f8a <copy_range+0x1a0>
    return KADDR(page2pa(page));
ffffffffc0202e28:	5b7d                	li	s6,-1
ffffffffc0202e2a:	8aaa                	mv	s5,a0
ffffffffc0202e2c:	89ae                	mv	s3,a1
        start += PGSIZE;
ffffffffc0202e2e:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage) {
ffffffffc0202e30:	00051c97          	auipc	s9,0x51
ffffffffc0202e34:	8b0c8c93          	addi	s9,s9,-1872 # ffffffffc02536e0 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc0202e38:	00051c17          	auipc	s8,0x51
ffffffffc0202e3c:	9f8c0c13          	addi	s8,s8,-1544 # ffffffffc0253830 <pages>
    return page - pages + nbase;
ffffffffc0202e40:	00080bb7          	lui	s7,0x80
    return KADDR(page2pa(page));
ffffffffc0202e44:	00cb5b13          	srli	s6,s6,0xc
        pte_t *ptep = get_pte(from, start, 0), *nptep;
ffffffffc0202e48:	4601                	li	a2,0
ffffffffc0202e4a:	85a2                	mv	a1,s0
ffffffffc0202e4c:	854e                	mv	a0,s3
ffffffffc0202e4e:	afbff0ef          	jal	ra,ffffffffc0202948 <get_pte>
ffffffffc0202e52:	84aa                	mv	s1,a0
        if (ptep == NULL) {
ffffffffc0202e54:	c175                	beqz	a0,ffffffffc0202f38 <copy_range+0x14e>
        if (*ptep & PTE_V) {
ffffffffc0202e56:	611c                	ld	a5,0(a0)
ffffffffc0202e58:	8b85                	andi	a5,a5,1
ffffffffc0202e5a:	e785                	bnez	a5,ffffffffc0202e82 <copy_range+0x98>
        start += PGSIZE;
ffffffffc0202e5c:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0202e5e:	ff2465e3          	bltu	s0,s2,ffffffffc0202e48 <copy_range+0x5e>
    return 0;
ffffffffc0202e62:	4501                	li	a0,0
}
ffffffffc0202e64:	70a6                	ld	ra,104(sp)
ffffffffc0202e66:	7406                	ld	s0,96(sp)
ffffffffc0202e68:	64e6                	ld	s1,88(sp)
ffffffffc0202e6a:	6946                	ld	s2,80(sp)
ffffffffc0202e6c:	69a6                	ld	s3,72(sp)
ffffffffc0202e6e:	6a06                	ld	s4,64(sp)
ffffffffc0202e70:	7ae2                	ld	s5,56(sp)
ffffffffc0202e72:	7b42                	ld	s6,48(sp)
ffffffffc0202e74:	7ba2                	ld	s7,40(sp)
ffffffffc0202e76:	7c02                	ld	s8,32(sp)
ffffffffc0202e78:	6ce2                	ld	s9,24(sp)
ffffffffc0202e7a:	6d42                	ld	s10,16(sp)
ffffffffc0202e7c:	6da2                	ld	s11,8(sp)
ffffffffc0202e7e:	6165                	addi	sp,sp,112
ffffffffc0202e80:	8082                	ret
            if ((nptep = get_pte(to, start, 1)) == NULL) {
ffffffffc0202e82:	4605                	li	a2,1
ffffffffc0202e84:	85a2                	mv	a1,s0
ffffffffc0202e86:	8556                	mv	a0,s5
ffffffffc0202e88:	ac1ff0ef          	jal	ra,ffffffffc0202948 <get_pte>
ffffffffc0202e8c:	c161                	beqz	a0,ffffffffc0202f4c <copy_range+0x162>
            uint32_t perm = (*ptep & PTE_USER);
ffffffffc0202e8e:	609c                	ld	a5,0(s1)
    if (!(pte & PTE_V)) {
ffffffffc0202e90:	0017f713          	andi	a4,a5,1
ffffffffc0202e94:	01f7f493          	andi	s1,a5,31
ffffffffc0202e98:	14070563          	beqz	a4,ffffffffc0202fe2 <copy_range+0x1f8>
    if (PPN(pa) >= npage) {
ffffffffc0202e9c:	000cb683          	ld	a3,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202ea0:	078a                	slli	a5,a5,0x2
ffffffffc0202ea2:	00c7d713          	srli	a4,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0202ea6:	12d77263          	bgeu	a4,a3,ffffffffc0202fca <copy_range+0x1e0>
    return &pages[PPN(pa) - nbase];
ffffffffc0202eaa:	000c3783          	ld	a5,0(s8)
ffffffffc0202eae:	fff806b7          	lui	a3,0xfff80
ffffffffc0202eb2:	9736                	add	a4,a4,a3
ffffffffc0202eb4:	071a                	slli	a4,a4,0x6
            struct Page *npage = alloc_page();
ffffffffc0202eb6:	4505                	li	a0,1
ffffffffc0202eb8:	00e78db3          	add	s11,a5,a4
ffffffffc0202ebc:	827ff0ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0202ec0:	8d2a                	mv	s10,a0
            assert(page != NULL);
ffffffffc0202ec2:	0a0d8463          	beqz	s11,ffffffffc0202f6a <copy_range+0x180>
            assert(npage != NULL);
ffffffffc0202ec6:	c175                	beqz	a0,ffffffffc0202faa <copy_range+0x1c0>
    return page - pages + nbase;
ffffffffc0202ec8:	000c3703          	ld	a4,0(s8)
    return KADDR(page2pa(page));
ffffffffc0202ecc:	000cb603          	ld	a2,0(s9)
    return page - pages + nbase;
ffffffffc0202ed0:	40ed86b3          	sub	a3,s11,a4
ffffffffc0202ed4:	8699                	srai	a3,a3,0x6
ffffffffc0202ed6:	96de                	add	a3,a3,s7
    return KADDR(page2pa(page));
ffffffffc0202ed8:	0166f7b3          	and	a5,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc0202edc:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202ede:	06c7fa63          	bgeu	a5,a2,ffffffffc0202f52 <copy_range+0x168>
    return page - pages + nbase;
ffffffffc0202ee2:	40e507b3          	sub	a5,a0,a4
    return KADDR(page2pa(page));
ffffffffc0202ee6:	00051717          	auipc	a4,0x51
ffffffffc0202eea:	93a70713          	addi	a4,a4,-1734 # ffffffffc0253820 <va_pa_offset>
ffffffffc0202eee:	6308                	ld	a0,0(a4)
    return page - pages + nbase;
ffffffffc0202ef0:	8799                	srai	a5,a5,0x6
ffffffffc0202ef2:	97de                	add	a5,a5,s7
    return KADDR(page2pa(page));
ffffffffc0202ef4:	0167f733          	and	a4,a5,s6
ffffffffc0202ef8:	00a685b3          	add	a1,a3,a0
    return page2ppn(page) << PGSHIFT;
ffffffffc0202efc:	07b2                	slli	a5,a5,0xc
    return KADDR(page2pa(page));
ffffffffc0202efe:	04c77963          	bgeu	a4,a2,ffffffffc0202f50 <copy_range+0x166>
            memcpy(kva_dst, kva_src, PGSIZE);
ffffffffc0202f02:	6605                	lui	a2,0x1
ffffffffc0202f04:	953e                	add	a0,a0,a5
ffffffffc0202f06:	18d010ef          	jal	ra,ffffffffc0204892 <memcpy>
            ret = page_insert(to, npage, start, perm);
ffffffffc0202f0a:	86a6                	mv	a3,s1
ffffffffc0202f0c:	8622                	mv	a2,s0
ffffffffc0202f0e:	85ea                	mv	a1,s10
ffffffffc0202f10:	8556                	mv	a0,s5
ffffffffc0202f12:	e1dff0ef          	jal	ra,ffffffffc0202d2e <page_insert>
            assert(ret == 0);
ffffffffc0202f16:	d139                	beqz	a0,ffffffffc0202e5c <copy_range+0x72>
ffffffffc0202f18:	00003697          	auipc	a3,0x3
ffffffffc0202f1c:	19068693          	addi	a3,a3,400 # ffffffffc02060a8 <default_pmm_manager+0x130>
ffffffffc0202f20:	00002617          	auipc	a2,0x2
ffffffffc0202f24:	43860613          	addi	a2,a2,1080 # ffffffffc0205358 <commands+0x408>
ffffffffc0202f28:	19900593          	li	a1,409
ffffffffc0202f2c:	00003517          	auipc	a0,0x3
ffffffffc0202f30:	0dc50513          	addi	a0,a0,220 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202f34:	ad0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0202f38:	00200637          	lui	a2,0x200
ffffffffc0202f3c:	9432                	add	s0,s0,a2
ffffffffc0202f3e:	ffe00637          	lui	a2,0xffe00
ffffffffc0202f42:	8c71                	and	s0,s0,a2
    } while (start != 0 && start < end);
ffffffffc0202f44:	dc19                	beqz	s0,ffffffffc0202e62 <copy_range+0x78>
ffffffffc0202f46:	f12461e3          	bltu	s0,s2,ffffffffc0202e48 <copy_range+0x5e>
ffffffffc0202f4a:	bf21                	j	ffffffffc0202e62 <copy_range+0x78>
                return -E_NO_MEM;
ffffffffc0202f4c:	5571                	li	a0,-4
ffffffffc0202f4e:	bf19                	j	ffffffffc0202e64 <copy_range+0x7a>
ffffffffc0202f50:	86be                	mv	a3,a5
ffffffffc0202f52:	00003617          	auipc	a2,0x3
ffffffffc0202f56:	a8e60613          	addi	a2,a2,-1394 # ffffffffc02059e0 <commands+0xa90>
ffffffffc0202f5a:	06900593          	li	a1,105
ffffffffc0202f5e:	00003517          	auipc	a0,0x3
ffffffffc0202f62:	aaa50513          	addi	a0,a0,-1366 # ffffffffc0205a08 <commands+0xab8>
ffffffffc0202f66:	a9efd0ef          	jal	ra,ffffffffc0200204 <__panic>
            assert(page != NULL);
ffffffffc0202f6a:	00003697          	auipc	a3,0x3
ffffffffc0202f6e:	11e68693          	addi	a3,a3,286 # ffffffffc0206088 <default_pmm_manager+0x110>
ffffffffc0202f72:	00002617          	auipc	a2,0x2
ffffffffc0202f76:	3e660613          	addi	a2,a2,998 # ffffffffc0205358 <commands+0x408>
ffffffffc0202f7a:	17e00593          	li	a1,382
ffffffffc0202f7e:	00003517          	auipc	a0,0x3
ffffffffc0202f82:	08a50513          	addi	a0,a0,138 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202f86:	a7efd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc0202f8a:	00003697          	auipc	a3,0x3
ffffffffc0202f8e:	0be68693          	addi	a3,a3,190 # ffffffffc0206048 <default_pmm_manager+0xd0>
ffffffffc0202f92:	00002617          	auipc	a2,0x2
ffffffffc0202f96:	3c660613          	addi	a2,a2,966 # ffffffffc0205358 <commands+0x408>
ffffffffc0202f9a:	16a00593          	li	a1,362
ffffffffc0202f9e:	00003517          	auipc	a0,0x3
ffffffffc0202fa2:	06a50513          	addi	a0,a0,106 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202fa6:	a5efd0ef          	jal	ra,ffffffffc0200204 <__panic>
            assert(npage != NULL);
ffffffffc0202faa:	00003697          	auipc	a3,0x3
ffffffffc0202fae:	0ee68693          	addi	a3,a3,238 # ffffffffc0206098 <default_pmm_manager+0x120>
ffffffffc0202fb2:	00002617          	auipc	a2,0x2
ffffffffc0202fb6:	3a660613          	addi	a2,a2,934 # ffffffffc0205358 <commands+0x408>
ffffffffc0202fba:	17f00593          	li	a1,383
ffffffffc0202fbe:	00003517          	auipc	a0,0x3
ffffffffc0202fc2:	04a50513          	addi	a0,a0,74 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0202fc6:	a3efd0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0202fca:	00003617          	auipc	a2,0x3
ffffffffc0202fce:	aae60613          	addi	a2,a2,-1362 # ffffffffc0205a78 <commands+0xb28>
ffffffffc0202fd2:	06200593          	li	a1,98
ffffffffc0202fd6:	00003517          	auipc	a0,0x3
ffffffffc0202fda:	a3250513          	addi	a0,a0,-1486 # ffffffffc0205a08 <commands+0xab8>
ffffffffc0202fde:	a26fd0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pte2page called with invalid pte");
ffffffffc0202fe2:	00003617          	auipc	a2,0x3
ffffffffc0202fe6:	07e60613          	addi	a2,a2,126 # ffffffffc0206060 <default_pmm_manager+0xe8>
ffffffffc0202fea:	07400593          	li	a1,116
ffffffffc0202fee:	00003517          	auipc	a0,0x3
ffffffffc0202ff2:	a1a50513          	addi	a0,a0,-1510 # ffffffffc0205a08 <commands+0xab8>
ffffffffc0202ff6:	a0efd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202ffa:	00003697          	auipc	a3,0x3
ffffffffc0202ffe:	01e68693          	addi	a3,a3,30 # ffffffffc0206018 <default_pmm_manager+0xa0>
ffffffffc0203002:	00002617          	auipc	a2,0x2
ffffffffc0203006:	35660613          	addi	a2,a2,854 # ffffffffc0205358 <commands+0x408>
ffffffffc020300a:	16900593          	li	a1,361
ffffffffc020300e:	00003517          	auipc	a0,0x3
ffffffffc0203012:	ffa50513          	addi	a0,a0,-6 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc0203016:	9eefd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020301a <tlb_invalidate>:
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020301a:	12058073          	sfence.vma	a1
}
ffffffffc020301e:	8082                	ret

ffffffffc0203020 <pgdir_alloc_page>:

// pgdir_alloc_page - call alloc_page & page_insert functions to
//                  - allocate a page size memory & setup an addr map
//                  - pa<->la with linear address la and the PDT pgdir
struct Page *pgdir_alloc_page(pde_t *pgdir, uintptr_t la, uint32_t perm) {
ffffffffc0203020:	7179                	addi	sp,sp,-48
ffffffffc0203022:	e84a                	sd	s2,16(sp)
ffffffffc0203024:	892a                	mv	s2,a0
    struct Page *page = alloc_page();
ffffffffc0203026:	4505                	li	a0,1
struct Page *pgdir_alloc_page(pde_t *pgdir, uintptr_t la, uint32_t perm) {
ffffffffc0203028:	f022                	sd	s0,32(sp)
ffffffffc020302a:	ec26                	sd	s1,24(sp)
ffffffffc020302c:	e44e                	sd	s3,8(sp)
ffffffffc020302e:	f406                	sd	ra,40(sp)
ffffffffc0203030:	84ae                	mv	s1,a1
ffffffffc0203032:	89b2                	mv	s3,a2
    struct Page *page = alloc_page();
ffffffffc0203034:	eaeff0ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0203038:	842a                	mv	s0,a0
    if (page != NULL) {
ffffffffc020303a:	cd05                	beqz	a0,ffffffffc0203072 <pgdir_alloc_page+0x52>
        if (page_insert(pgdir, page, la, perm) != 0) {
ffffffffc020303c:	85aa                	mv	a1,a0
ffffffffc020303e:	86ce                	mv	a3,s3
ffffffffc0203040:	8626                	mv	a2,s1
ffffffffc0203042:	854a                	mv	a0,s2
ffffffffc0203044:	cebff0ef          	jal	ra,ffffffffc0202d2e <page_insert>
ffffffffc0203048:	ed0d                	bnez	a0,ffffffffc0203082 <pgdir_alloc_page+0x62>
            free_page(page);
            return NULL;
        }
        if (swap_init_ok) {
ffffffffc020304a:	00050797          	auipc	a5,0x50
ffffffffc020304e:	6867a783          	lw	a5,1670(a5) # ffffffffc02536d0 <swap_init_ok>
ffffffffc0203052:	c385                	beqz	a5,ffffffffc0203072 <pgdir_alloc_page+0x52>
            if (check_mm_struct != NULL) {
ffffffffc0203054:	00050517          	auipc	a0,0x50
ffffffffc0203058:	6cc53503          	ld	a0,1740(a0) # ffffffffc0253720 <check_mm_struct>
ffffffffc020305c:	c919                	beqz	a0,ffffffffc0203072 <pgdir_alloc_page+0x52>
                swap_map_swappable(check_mm_struct, la, page, 0);
ffffffffc020305e:	4681                	li	a3,0
ffffffffc0203060:	8622                	mv	a2,s0
ffffffffc0203062:	85a6                	mv	a1,s1
ffffffffc0203064:	a23fe0ef          	jal	ra,ffffffffc0201a86 <swap_map_swappable>
                page->pra_vaddr = la;
                assert(page_ref(page) == 1);
ffffffffc0203068:	4018                	lw	a4,0(s0)
                page->pra_vaddr = la;
ffffffffc020306a:	fc04                	sd	s1,56(s0)
                assert(page_ref(page) == 1);
ffffffffc020306c:	4785                	li	a5,1
ffffffffc020306e:	02f71063          	bne	a4,a5,ffffffffc020308e <pgdir_alloc_page+0x6e>
            }
        }
    }

    return page;
}
ffffffffc0203072:	70a2                	ld	ra,40(sp)
ffffffffc0203074:	8522                	mv	a0,s0
ffffffffc0203076:	7402                	ld	s0,32(sp)
ffffffffc0203078:	64e2                	ld	s1,24(sp)
ffffffffc020307a:	6942                	ld	s2,16(sp)
ffffffffc020307c:	69a2                	ld	s3,8(sp)
ffffffffc020307e:	6145                	addi	sp,sp,48
ffffffffc0203080:	8082                	ret
            free_page(page);
ffffffffc0203082:	8522                	mv	a0,s0
ffffffffc0203084:	4585                	li	a1,1
ffffffffc0203086:	eeeff0ef          	jal	ra,ffffffffc0202774 <free_pages>
            return NULL;
ffffffffc020308a:	4401                	li	s0,0
ffffffffc020308c:	b7dd                	j	ffffffffc0203072 <pgdir_alloc_page+0x52>
                assert(page_ref(page) == 1);
ffffffffc020308e:	00003697          	auipc	a3,0x3
ffffffffc0203092:	02a68693          	addi	a3,a3,42 # ffffffffc02060b8 <default_pmm_manager+0x140>
ffffffffc0203096:	00002617          	auipc	a2,0x2
ffffffffc020309a:	2c260613          	addi	a2,a2,706 # ffffffffc0205358 <commands+0x408>
ffffffffc020309e:	1d800593          	li	a1,472
ffffffffc02030a2:	00003517          	auipc	a0,0x3
ffffffffc02030a6:	f6650513          	addi	a0,a0,-154 # ffffffffc0206008 <default_pmm_manager+0x90>
ffffffffc02030aa:	95afd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02030ae <swapfs_init>:
#include <ide.h>
#include <pmm.h>
#include <assert.h>

void
swapfs_init(void) {
ffffffffc02030ae:	1141                	addi	sp,sp,-16
    static_assert((PGSIZE % SECTSIZE) == 0);
    if (!ide_device_valid(SWAP_DEV_NO)) {
ffffffffc02030b0:	4505                	li	a0,1
swapfs_init(void) {
ffffffffc02030b2:	e406                	sd	ra,8(sp)
    if (!ide_device_valid(SWAP_DEV_NO)) {
ffffffffc02030b4:	c6afd0ef          	jal	ra,ffffffffc020051e <ide_device_valid>
ffffffffc02030b8:	cd01                	beqz	a0,ffffffffc02030d0 <swapfs_init+0x22>
        panic("swap fs isn't available.\n");
    }
    max_swap_offset = ide_device_size(SWAP_DEV_NO) / (PGSIZE / SECTSIZE);
ffffffffc02030ba:	4505                	li	a0,1
ffffffffc02030bc:	c68fd0ef          	jal	ra,ffffffffc0200524 <ide_device_size>
}
ffffffffc02030c0:	60a2                	ld	ra,8(sp)
    max_swap_offset = ide_device_size(SWAP_DEV_NO) / (PGSIZE / SECTSIZE);
ffffffffc02030c2:	810d                	srli	a0,a0,0x3
ffffffffc02030c4:	00050797          	auipc	a5,0x50
ffffffffc02030c8:	6ea7be23          	sd	a0,1788(a5) # ffffffffc02537c0 <max_swap_offset>
}
ffffffffc02030cc:	0141                	addi	sp,sp,16
ffffffffc02030ce:	8082                	ret
        panic("swap fs isn't available.\n");
ffffffffc02030d0:	00003617          	auipc	a2,0x3
ffffffffc02030d4:	00060613          	mv	a2,a2
ffffffffc02030d8:	45b5                	li	a1,13
ffffffffc02030da:	00003517          	auipc	a0,0x3
ffffffffc02030de:	01650513          	addi	a0,a0,22 # ffffffffc02060f0 <default_pmm_manager+0x178>
ffffffffc02030e2:	922fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02030e6 <swapfs_read>:

int
swapfs_read(swap_entry_t entry, struct Page *page) {
ffffffffc02030e6:	1141                	addi	sp,sp,-16
ffffffffc02030e8:	e406                	sd	ra,8(sp)
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc02030ea:	00855793          	srli	a5,a0,0x8
ffffffffc02030ee:	cbb1                	beqz	a5,ffffffffc0203142 <swapfs_read+0x5c>
ffffffffc02030f0:	00050717          	auipc	a4,0x50
ffffffffc02030f4:	6d073703          	ld	a4,1744(a4) # ffffffffc02537c0 <max_swap_offset>
ffffffffc02030f8:	04e7f563          	bgeu	a5,a4,ffffffffc0203142 <swapfs_read+0x5c>
    return page - pages + nbase;
ffffffffc02030fc:	00050617          	auipc	a2,0x50
ffffffffc0203100:	73463603          	ld	a2,1844(a2) # ffffffffc0253830 <pages>
ffffffffc0203104:	8d91                	sub	a1,a1,a2
ffffffffc0203106:	4065d613          	srai	a2,a1,0x6
ffffffffc020310a:	00004717          	auipc	a4,0x4
ffffffffc020310e:	0ee73703          	ld	a4,238(a4) # ffffffffc02071f8 <nbase>
ffffffffc0203112:	963a                	add	a2,a2,a4
    return KADDR(page2pa(page));
ffffffffc0203114:	00c61713          	slli	a4,a2,0xc
ffffffffc0203118:	8331                	srli	a4,a4,0xc
ffffffffc020311a:	00050697          	auipc	a3,0x50
ffffffffc020311e:	5c66b683          	ld	a3,1478(a3) # ffffffffc02536e0 <npage>
ffffffffc0203122:	0037959b          	slliw	a1,a5,0x3
    return page2ppn(page) << PGSHIFT;
ffffffffc0203126:	0632                	slli	a2,a2,0xc
    return KADDR(page2pa(page));
ffffffffc0203128:	02d77963          	bgeu	a4,a3,ffffffffc020315a <swapfs_read+0x74>
}
ffffffffc020312c:	60a2                	ld	ra,8(sp)
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc020312e:	00050797          	auipc	a5,0x50
ffffffffc0203132:	6f27b783          	ld	a5,1778(a5) # ffffffffc0253820 <va_pa_offset>
ffffffffc0203136:	46a1                	li	a3,8
ffffffffc0203138:	963e                	add	a2,a2,a5
ffffffffc020313a:	4505                	li	a0,1
}
ffffffffc020313c:	0141                	addi	sp,sp,16
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc020313e:	becfd06f          	j	ffffffffc020052a <ide_read_secs>
ffffffffc0203142:	86aa                	mv	a3,a0
ffffffffc0203144:	00003617          	auipc	a2,0x3
ffffffffc0203148:	fc460613          	addi	a2,a2,-60 # ffffffffc0206108 <default_pmm_manager+0x190>
ffffffffc020314c:	45d1                	li	a1,20
ffffffffc020314e:	00003517          	auipc	a0,0x3
ffffffffc0203152:	fa250513          	addi	a0,a0,-94 # ffffffffc02060f0 <default_pmm_manager+0x178>
ffffffffc0203156:	8aefd0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc020315a:	86b2                	mv	a3,a2
ffffffffc020315c:	06900593          	li	a1,105
ffffffffc0203160:	00003617          	auipc	a2,0x3
ffffffffc0203164:	88060613          	addi	a2,a2,-1920 # ffffffffc02059e0 <commands+0xa90>
ffffffffc0203168:	00003517          	auipc	a0,0x3
ffffffffc020316c:	8a050513          	addi	a0,a0,-1888 # ffffffffc0205a08 <commands+0xab8>
ffffffffc0203170:	894fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203174 <swapfs_write>:

int
swapfs_write(swap_entry_t entry, struct Page *page) {
ffffffffc0203174:	1141                	addi	sp,sp,-16
ffffffffc0203176:	e406                	sd	ra,8(sp)
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc0203178:	00855793          	srli	a5,a0,0x8
ffffffffc020317c:	cbb1                	beqz	a5,ffffffffc02031d0 <swapfs_write+0x5c>
ffffffffc020317e:	00050717          	auipc	a4,0x50
ffffffffc0203182:	64273703          	ld	a4,1602(a4) # ffffffffc02537c0 <max_swap_offset>
ffffffffc0203186:	04e7f563          	bgeu	a5,a4,ffffffffc02031d0 <swapfs_write+0x5c>
    return page - pages + nbase;
ffffffffc020318a:	00050617          	auipc	a2,0x50
ffffffffc020318e:	6a663603          	ld	a2,1702(a2) # ffffffffc0253830 <pages>
ffffffffc0203192:	8d91                	sub	a1,a1,a2
ffffffffc0203194:	4065d613          	srai	a2,a1,0x6
ffffffffc0203198:	00004717          	auipc	a4,0x4
ffffffffc020319c:	06073703          	ld	a4,96(a4) # ffffffffc02071f8 <nbase>
ffffffffc02031a0:	963a                	add	a2,a2,a4
    return KADDR(page2pa(page));
ffffffffc02031a2:	00c61713          	slli	a4,a2,0xc
ffffffffc02031a6:	8331                	srli	a4,a4,0xc
ffffffffc02031a8:	00050697          	auipc	a3,0x50
ffffffffc02031ac:	5386b683          	ld	a3,1336(a3) # ffffffffc02536e0 <npage>
ffffffffc02031b0:	0037959b          	slliw	a1,a5,0x3
    return page2ppn(page) << PGSHIFT;
ffffffffc02031b4:	0632                	slli	a2,a2,0xc
    return KADDR(page2pa(page));
ffffffffc02031b6:	02d77963          	bgeu	a4,a3,ffffffffc02031e8 <swapfs_write+0x74>
}
ffffffffc02031ba:	60a2                	ld	ra,8(sp)
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc02031bc:	00050797          	auipc	a5,0x50
ffffffffc02031c0:	6647b783          	ld	a5,1636(a5) # ffffffffc0253820 <va_pa_offset>
ffffffffc02031c4:	46a1                	li	a3,8
ffffffffc02031c6:	963e                	add	a2,a2,a5
ffffffffc02031c8:	4505                	li	a0,1
}
ffffffffc02031ca:	0141                	addi	sp,sp,16
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc02031cc:	b82fd06f          	j	ffffffffc020054e <ide_write_secs>
ffffffffc02031d0:	86aa                	mv	a3,a0
ffffffffc02031d2:	00003617          	auipc	a2,0x3
ffffffffc02031d6:	f3660613          	addi	a2,a2,-202 # ffffffffc0206108 <default_pmm_manager+0x190>
ffffffffc02031da:	45e5                	li	a1,25
ffffffffc02031dc:	00003517          	auipc	a0,0x3
ffffffffc02031e0:	f1450513          	addi	a0,a0,-236 # ffffffffc02060f0 <default_pmm_manager+0x178>
ffffffffc02031e4:	820fd0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc02031e8:	86b2                	mv	a3,a2
ffffffffc02031ea:	06900593          	li	a1,105
ffffffffc02031ee:	00002617          	auipc	a2,0x2
ffffffffc02031f2:	7f260613          	addi	a2,a2,2034 # ffffffffc02059e0 <commands+0xa90>
ffffffffc02031f6:	00003517          	auipc	a0,0x3
ffffffffc02031fa:	81250513          	addi	a0,a0,-2030 # ffffffffc0205a08 <commands+0xab8>
ffffffffc02031fe:	806fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203202 <switch_to>:
.text
# void switch_to(struct proc_struct* from, struct proc_struct* to)
.globl switch_to
switch_to:
    # save from's registers
    STORE ra, 0*REGBYTES(a0)
ffffffffc0203202:	00153023          	sd	ra,0(a0)
    STORE sp, 1*REGBYTES(a0)
ffffffffc0203206:	00253423          	sd	sp,8(a0)
    STORE s0, 2*REGBYTES(a0)
ffffffffc020320a:	e900                	sd	s0,16(a0)
    STORE s1, 3*REGBYTES(a0)
ffffffffc020320c:	ed04                	sd	s1,24(a0)
    STORE s2, 4*REGBYTES(a0)
ffffffffc020320e:	03253023          	sd	s2,32(a0)
    STORE s3, 5*REGBYTES(a0)
ffffffffc0203212:	03353423          	sd	s3,40(a0)
    STORE s4, 6*REGBYTES(a0)
ffffffffc0203216:	03453823          	sd	s4,48(a0)
    STORE s5, 7*REGBYTES(a0)
ffffffffc020321a:	03553c23          	sd	s5,56(a0)
    STORE s6, 8*REGBYTES(a0)
ffffffffc020321e:	05653023          	sd	s6,64(a0)
    STORE s7, 9*REGBYTES(a0)
ffffffffc0203222:	05753423          	sd	s7,72(a0)
    STORE s8, 10*REGBYTES(a0)
ffffffffc0203226:	05853823          	sd	s8,80(a0)
    STORE s9, 11*REGBYTES(a0)
ffffffffc020322a:	05953c23          	sd	s9,88(a0)
    STORE s10, 12*REGBYTES(a0)
ffffffffc020322e:	07a53023          	sd	s10,96(a0)
    STORE s11, 13*REGBYTES(a0)
ffffffffc0203232:	07b53423          	sd	s11,104(a0)

    # restore to's registers
    LOAD ra, 0*REGBYTES(a1)
ffffffffc0203236:	0005b083          	ld	ra,0(a1)
    LOAD sp, 1*REGBYTES(a1)
ffffffffc020323a:	0085b103          	ld	sp,8(a1)
    LOAD s0, 2*REGBYTES(a1)
ffffffffc020323e:	6980                	ld	s0,16(a1)
    LOAD s1, 3*REGBYTES(a1)
ffffffffc0203240:	6d84                	ld	s1,24(a1)
    LOAD s2, 4*REGBYTES(a1)
ffffffffc0203242:	0205b903          	ld	s2,32(a1)
    LOAD s3, 5*REGBYTES(a1)
ffffffffc0203246:	0285b983          	ld	s3,40(a1)
    LOAD s4, 6*REGBYTES(a1)
ffffffffc020324a:	0305ba03          	ld	s4,48(a1)
    LOAD s5, 7*REGBYTES(a1)
ffffffffc020324e:	0385ba83          	ld	s5,56(a1)
    LOAD s6, 8*REGBYTES(a1)
ffffffffc0203252:	0405bb03          	ld	s6,64(a1)
    LOAD s7, 9*REGBYTES(a1)
ffffffffc0203256:	0485bb83          	ld	s7,72(a1)
    LOAD s8, 10*REGBYTES(a1)
ffffffffc020325a:	0505bc03          	ld	s8,80(a1)
    LOAD s9, 11*REGBYTES(a1)
ffffffffc020325e:	0585bc83          	ld	s9,88(a1)
    LOAD s10, 12*REGBYTES(a1)
ffffffffc0203262:	0605bd03          	ld	s10,96(a1)
    LOAD s11, 13*REGBYTES(a1)
ffffffffc0203266:	0685bd83          	ld	s11,104(a1)

    ret
ffffffffc020326a:	8082                	ret

ffffffffc020326c <kernel_thread_entry>:
.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)
	move a0, s1
ffffffffc020326c:	8526                	mv	a0,s1
	jalr s0
ffffffffc020326e:	9402                	jalr	s0

	jal do_exit
ffffffffc0203270:	70a000ef          	jal	ra,ffffffffc020397a <do_exit>

ffffffffc0203274 <alloc_proc>:
void forkrets(struct trapframe *tf);
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void) {
ffffffffc0203274:	1141                	addi	sp,sp,-16
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203276:	13000513          	li	a0,304
alloc_proc(void) {
ffffffffc020327a:	e022                	sd	s0,0(sp)
ffffffffc020327c:	e406                	sd	ra,8(sp)
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc020327e:	dcefe0ef          	jal	ra,ffffffffc020184c <kmalloc>
ffffffffc0203282:	842a                	mv	s0,a0
    if (proc != NULL) {
ffffffffc0203284:	c13d                	beqz	a0,ffffffffc02032ea <alloc_proc+0x76>
        proc->state = PROC_UNINIT;
ffffffffc0203286:	57fd                	li	a5,-1
ffffffffc0203288:	1782                	slli	a5,a5,0x20
ffffffffc020328a:	e11c                	sd	a5,0(a0)
        proc->runs = 0;
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc020328c:	07000613          	li	a2,112
ffffffffc0203290:	4581                	li	a1,0
        proc->runs = 0;
ffffffffc0203292:	00052423          	sw	zero,8(a0)
        proc->kstack = 0;
ffffffffc0203296:	00053823          	sd	zero,16(a0)
        proc->need_resched = 0;
ffffffffc020329a:	00053c23          	sd	zero,24(a0)
        proc->parent = NULL;
ffffffffc020329e:	02053023          	sd	zero,32(a0)
        proc->mm = NULL;
ffffffffc02032a2:	02053423          	sd	zero,40(a0)
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc02032a6:	03050513          	addi	a0,a0,48
ffffffffc02032aa:	5d6010ef          	jal	ra,ffffffffc0204880 <memset>
        proc->tf = NULL;
        proc->cr3 = boot_cr3;
ffffffffc02032ae:	00050797          	auipc	a5,0x50
ffffffffc02032b2:	57a7b783          	ld	a5,1402(a5) # ffffffffc0253828 <boot_cr3>
ffffffffc02032b6:	f45c                	sd	a5,168(s0)
        proc->tf = NULL;
ffffffffc02032b8:	0a043023          	sd	zero,160(s0)
        proc->flags = 0;
ffffffffc02032bc:	0a042823          	sw	zero,176(s0)
        memset(proc->name, 0, PROC_NAME_LEN);
ffffffffc02032c0:	463d                	li	a2,15
ffffffffc02032c2:	4581                	li	a1,0
ffffffffc02032c4:	0b440513          	addi	a0,s0,180
ffffffffc02032c8:	5b8010ef          	jal	ra,ffffffffc0204880 <memset>
        proc->wait_state = 0;
        proc->cptr = proc->optr = proc->yptr = NULL;
        proc->time_slice = 0;
ffffffffc02032cc:	4785                	li	a5,1
ffffffffc02032ce:	1782                	slli	a5,a5,0x20
ffffffffc02032d0:	12f43023          	sd	a5,288(s0)
        proc->labschedule_priority = 1;
        proc->labschedule_good = 6;
ffffffffc02032d4:	4799                	li	a5,6
        proc->wait_state = 0;
ffffffffc02032d6:	0e042623          	sw	zero,236(s0)
        proc->cptr = proc->optr = proc->yptr = NULL;
ffffffffc02032da:	0e043c23          	sd	zero,248(s0)
ffffffffc02032de:	10043023          	sd	zero,256(s0)
ffffffffc02032e2:	0e043823          	sd	zero,240(s0)
        proc->labschedule_good = 6;
ffffffffc02032e6:	12f42423          	sw	a5,296(s0)
    }
    return proc;
}
ffffffffc02032ea:	60a2                	ld	ra,8(sp)
ffffffffc02032ec:	8522                	mv	a0,s0
ffffffffc02032ee:	6402                	ld	s0,0(sp)
ffffffffc02032f0:	0141                	addi	sp,sp,16
ffffffffc02032f2:	8082                	ret

ffffffffc02032f4 <forkret>:
// forkret -- the first kernel entry point of a new thread/process
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void) {
    forkrets(current->tf);
ffffffffc02032f4:	00050797          	auipc	a5,0x50
ffffffffc02032f8:	3f47b783          	ld	a5,1012(a5) # ffffffffc02536e8 <current>
ffffffffc02032fc:	73c8                	ld	a0,160(a5)
ffffffffc02032fe:	a35fd06f          	j	ffffffffc0200d32 <forkrets>

ffffffffc0203302 <user_main>:
static int
user_main(void *arg) {
#ifdef TEST
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
#else
    KERNEL_EXECVE(ex1);
ffffffffc0203302:	00050797          	auipc	a5,0x50
ffffffffc0203306:	3e67b783          	ld	a5,998(a5) # ffffffffc02536e8 <current>
ffffffffc020330a:	43cc                	lw	a1,4(a5)
user_main(void *arg) {
ffffffffc020330c:	7139                	addi	sp,sp,-64
    KERNEL_EXECVE(ex1);
ffffffffc020330e:	00003617          	auipc	a2,0x3
ffffffffc0203312:	e1a60613          	addi	a2,a2,-486 # ffffffffc0206128 <default_pmm_manager+0x1b0>
ffffffffc0203316:	00003517          	auipc	a0,0x3
ffffffffc020331a:	e1a50513          	addi	a0,a0,-486 # ffffffffc0206130 <default_pmm_manager+0x1b8>
user_main(void *arg) {
ffffffffc020331e:	fc06                	sd	ra,56(sp)
    KERNEL_EXECVE(ex1);
ffffffffc0203320:	da9fc0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc0203324:	3fe07797          	auipc	a5,0x3fe07
ffffffffc0203328:	81c78793          	addi	a5,a5,-2020 # 9b40 <_binary_obj___user_ex1_out_size>
ffffffffc020332c:	e43e                	sd	a5,8(sp)
ffffffffc020332e:	00003517          	auipc	a0,0x3
ffffffffc0203332:	dfa50513          	addi	a0,a0,-518 # ffffffffc0206128 <default_pmm_manager+0x1b0>
ffffffffc0203336:	00011797          	auipc	a5,0x11
ffffffffc020333a:	7f278793          	addi	a5,a5,2034 # ffffffffc0214b28 <_binary_obj___user_ex1_out_start>
ffffffffc020333e:	f03e                	sd	a5,32(sp)
ffffffffc0203340:	f42a                	sd	a0,40(sp)
    int64_t ret=0, len = strlen(name);
ffffffffc0203342:	e802                	sd	zero,16(sp)
ffffffffc0203344:	4d2010ef          	jal	ra,ffffffffc0204816 <strlen>
ffffffffc0203348:	ec2a                	sd	a0,24(sp)
    asm volatile(
ffffffffc020334a:	4511                	li	a0,4
ffffffffc020334c:	55a2                	lw	a1,40(sp)
ffffffffc020334e:	4662                	lw	a2,24(sp)
ffffffffc0203350:	5682                	lw	a3,32(sp)
ffffffffc0203352:	4722                	lw	a4,8(sp)
ffffffffc0203354:	48a9                	li	a7,10
ffffffffc0203356:	9002                	ebreak
ffffffffc0203358:	c82a                	sw	a0,16(sp)
    cprintf("ret = %d\n", ret);
ffffffffc020335a:	65c2                	ld	a1,16(sp)
ffffffffc020335c:	00003517          	auipc	a0,0x3
ffffffffc0203360:	dfc50513          	addi	a0,a0,-516 # ffffffffc0206158 <default_pmm_manager+0x1e0>
ffffffffc0203364:	d65fc0ef          	jal	ra,ffffffffc02000c8 <cprintf>
#endif
    panic("user_main execve failed.\n");
ffffffffc0203368:	00003617          	auipc	a2,0x3
ffffffffc020336c:	e0060613          	addi	a2,a2,-512 # ffffffffc0206168 <default_pmm_manager+0x1f0>
ffffffffc0203370:	30600593          	li	a1,774
ffffffffc0203374:	00003517          	auipc	a0,0x3
ffffffffc0203378:	e1450513          	addi	a0,a0,-492 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc020337c:	e89fc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203380 <put_pgdir>:
    return pa2page(PADDR(kva));
ffffffffc0203380:	6d14                	ld	a3,24(a0)
put_pgdir(struct mm_struct *mm) {
ffffffffc0203382:	1141                	addi	sp,sp,-16
ffffffffc0203384:	e406                	sd	ra,8(sp)
ffffffffc0203386:	c02007b7          	lui	a5,0xc0200
ffffffffc020338a:	02f6ee63          	bltu	a3,a5,ffffffffc02033c6 <put_pgdir+0x46>
ffffffffc020338e:	00050517          	auipc	a0,0x50
ffffffffc0203392:	49253503          	ld	a0,1170(a0) # ffffffffc0253820 <va_pa_offset>
ffffffffc0203396:	8e89                	sub	a3,a3,a0
    if (PPN(pa) >= npage) {
ffffffffc0203398:	82b1                	srli	a3,a3,0xc
ffffffffc020339a:	00050797          	auipc	a5,0x50
ffffffffc020339e:	3467b783          	ld	a5,838(a5) # ffffffffc02536e0 <npage>
ffffffffc02033a2:	02f6fe63          	bgeu	a3,a5,ffffffffc02033de <put_pgdir+0x5e>
    return &pages[PPN(pa) - nbase];
ffffffffc02033a6:	00004517          	auipc	a0,0x4
ffffffffc02033aa:	e5253503          	ld	a0,-430(a0) # ffffffffc02071f8 <nbase>
}
ffffffffc02033ae:	60a2                	ld	ra,8(sp)
ffffffffc02033b0:	8e89                	sub	a3,a3,a0
ffffffffc02033b2:	069a                	slli	a3,a3,0x6
    free_page(kva2page(mm->pgdir));
ffffffffc02033b4:	00050517          	auipc	a0,0x50
ffffffffc02033b8:	47c53503          	ld	a0,1148(a0) # ffffffffc0253830 <pages>
ffffffffc02033bc:	4585                	li	a1,1
ffffffffc02033be:	9536                	add	a0,a0,a3
}
ffffffffc02033c0:	0141                	addi	sp,sp,16
    free_page(kva2page(mm->pgdir));
ffffffffc02033c2:	bb2ff06f          	j	ffffffffc0202774 <free_pages>
    return pa2page(PADDR(kva));
ffffffffc02033c6:	00002617          	auipc	a2,0x2
ffffffffc02033ca:	68a60613          	addi	a2,a2,1674 # ffffffffc0205a50 <commands+0xb00>
ffffffffc02033ce:	06e00593          	li	a1,110
ffffffffc02033d2:	00002517          	auipc	a0,0x2
ffffffffc02033d6:	63650513          	addi	a0,a0,1590 # ffffffffc0205a08 <commands+0xab8>
ffffffffc02033da:	e2bfc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02033de:	00002617          	auipc	a2,0x2
ffffffffc02033e2:	69a60613          	addi	a2,a2,1690 # ffffffffc0205a78 <commands+0xb28>
ffffffffc02033e6:	06200593          	li	a1,98
ffffffffc02033ea:	00002517          	auipc	a0,0x2
ffffffffc02033ee:	61e50513          	addi	a0,a0,1566 # ffffffffc0205a08 <commands+0xab8>
ffffffffc02033f2:	e13fc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02033f6 <setup_pgdir>:
setup_pgdir(struct mm_struct *mm) {
ffffffffc02033f6:	1101                	addi	sp,sp,-32
ffffffffc02033f8:	e426                	sd	s1,8(sp)
ffffffffc02033fa:	84aa                	mv	s1,a0
    if ((page = alloc_page()) == NULL) {
ffffffffc02033fc:	4505                	li	a0,1
setup_pgdir(struct mm_struct *mm) {
ffffffffc02033fe:	ec06                	sd	ra,24(sp)
ffffffffc0203400:	e822                	sd	s0,16(sp)
    if ((page = alloc_page()) == NULL) {
ffffffffc0203402:	ae0ff0ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
ffffffffc0203406:	c939                	beqz	a0,ffffffffc020345c <setup_pgdir+0x66>
    return page - pages + nbase;
ffffffffc0203408:	00050697          	auipc	a3,0x50
ffffffffc020340c:	4286b683          	ld	a3,1064(a3) # ffffffffc0253830 <pages>
ffffffffc0203410:	40d506b3          	sub	a3,a0,a3
ffffffffc0203414:	8699                	srai	a3,a3,0x6
ffffffffc0203416:	00004417          	auipc	s0,0x4
ffffffffc020341a:	de243403          	ld	s0,-542(s0) # ffffffffc02071f8 <nbase>
ffffffffc020341e:	96a2                	add	a3,a3,s0
    return KADDR(page2pa(page));
ffffffffc0203420:	00c69793          	slli	a5,a3,0xc
ffffffffc0203424:	83b1                	srli	a5,a5,0xc
ffffffffc0203426:	00050717          	auipc	a4,0x50
ffffffffc020342a:	2ba73703          	ld	a4,698(a4) # ffffffffc02536e0 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc020342e:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0203430:	02e7f863          	bgeu	a5,a4,ffffffffc0203460 <setup_pgdir+0x6a>
ffffffffc0203434:	00050417          	auipc	s0,0x50
ffffffffc0203438:	3ec43403          	ld	s0,1004(s0) # ffffffffc0253820 <va_pa_offset>
ffffffffc020343c:	9436                	add	s0,s0,a3
    memcpy(pgdir, boot_pgdir, PGSIZE);
ffffffffc020343e:	6605                	lui	a2,0x1
ffffffffc0203440:	00050597          	auipc	a1,0x50
ffffffffc0203444:	2985b583          	ld	a1,664(a1) # ffffffffc02536d8 <boot_pgdir>
ffffffffc0203448:	8522                	mv	a0,s0
ffffffffc020344a:	448010ef          	jal	ra,ffffffffc0204892 <memcpy>
    return 0;
ffffffffc020344e:	4501                	li	a0,0
    mm->pgdir = pgdir;
ffffffffc0203450:	ec80                	sd	s0,24(s1)
}
ffffffffc0203452:	60e2                	ld	ra,24(sp)
ffffffffc0203454:	6442                	ld	s0,16(sp)
ffffffffc0203456:	64a2                	ld	s1,8(sp)
ffffffffc0203458:	6105                	addi	sp,sp,32
ffffffffc020345a:	8082                	ret
        return -E_NO_MEM;
ffffffffc020345c:	5571                	li	a0,-4
ffffffffc020345e:	bfd5                	j	ffffffffc0203452 <setup_pgdir+0x5c>
ffffffffc0203460:	00002617          	auipc	a2,0x2
ffffffffc0203464:	58060613          	addi	a2,a2,1408 # ffffffffc02059e0 <commands+0xa90>
ffffffffc0203468:	06900593          	li	a1,105
ffffffffc020346c:	00002517          	auipc	a0,0x2
ffffffffc0203470:	59c50513          	addi	a0,a0,1436 # ffffffffc0205a08 <commands+0xab8>
ffffffffc0203474:	d91fc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203478 <set_proc_name>:
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc0203478:	1101                	addi	sp,sp,-32
ffffffffc020347a:	e822                	sd	s0,16(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc020347c:	0b450413          	addi	s0,a0,180
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc0203480:	e426                	sd	s1,8(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203482:	4641                	li	a2,16
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc0203484:	84ae                	mv	s1,a1
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203486:	8522                	mv	a0,s0
ffffffffc0203488:	4581                	li	a1,0
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc020348a:	ec06                	sd	ra,24(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc020348c:	3f4010ef          	jal	ra,ffffffffc0204880 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0203490:	8522                	mv	a0,s0
}
ffffffffc0203492:	6442                	ld	s0,16(sp)
ffffffffc0203494:	60e2                	ld	ra,24(sp)
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0203496:	85a6                	mv	a1,s1
}
ffffffffc0203498:	64a2                	ld	s1,8(sp)
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc020349a:	463d                	li	a2,15
}
ffffffffc020349c:	6105                	addi	sp,sp,32
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc020349e:	3f40106f          	j	ffffffffc0204892 <memcpy>

ffffffffc02034a2 <proc_run>:
proc_run(struct proc_struct *proc) {
ffffffffc02034a2:	7179                	addi	sp,sp,-48
ffffffffc02034a4:	ec4a                	sd	s2,24(sp)
    if (proc != current) {
ffffffffc02034a6:	00050917          	auipc	s2,0x50
ffffffffc02034aa:	24290913          	addi	s2,s2,578 # ffffffffc02536e8 <current>
proc_run(struct proc_struct *proc) {
ffffffffc02034ae:	f026                	sd	s1,32(sp)
    if (proc != current) {
ffffffffc02034b0:	00093483          	ld	s1,0(s2)
proc_run(struct proc_struct *proc) {
ffffffffc02034b4:	f406                	sd	ra,40(sp)
ffffffffc02034b6:	e84e                	sd	s3,16(sp)
    if (proc != current) {
ffffffffc02034b8:	02a48863          	beq	s1,a0,ffffffffc02034e8 <proc_run+0x46>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02034bc:	100027f3          	csrr	a5,sstatus
ffffffffc02034c0:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02034c2:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02034c4:	ef9d                	bnez	a5,ffffffffc0203502 <proc_run+0x60>

#define barrier() __asm__ __volatile__ ("fence" ::: "memory")

static inline void
lcr3(unsigned long cr3) {
    write_csr(satp, 0x8000000000000000 | (cr3 >> RISCV_PGSHIFT));
ffffffffc02034c6:	755c                	ld	a5,168(a0)
ffffffffc02034c8:	577d                	li	a4,-1
ffffffffc02034ca:	177e                	slli	a4,a4,0x3f
ffffffffc02034cc:	83b1                	srli	a5,a5,0xc
            current = proc;
ffffffffc02034ce:	00a93023          	sd	a0,0(s2)
ffffffffc02034d2:	8fd9                	or	a5,a5,a4
ffffffffc02034d4:	18079073          	csrw	satp,a5
            switch_to(&(prev->context), &(next->context));
ffffffffc02034d8:	03050593          	addi	a1,a0,48
ffffffffc02034dc:	03048513          	addi	a0,s1,48 # ffffffffffe00030 <end+0x3fbac7e8>
ffffffffc02034e0:	d23ff0ef          	jal	ra,ffffffffc0203202 <switch_to>
    if (flag) {
ffffffffc02034e4:	00099863          	bnez	s3,ffffffffc02034f4 <proc_run+0x52>
}
ffffffffc02034e8:	70a2                	ld	ra,40(sp)
ffffffffc02034ea:	7482                	ld	s1,32(sp)
ffffffffc02034ec:	6962                	ld	s2,24(sp)
ffffffffc02034ee:	69c2                	ld	s3,16(sp)
ffffffffc02034f0:	6145                	addi	sp,sp,48
ffffffffc02034f2:	8082                	ret
ffffffffc02034f4:	70a2                	ld	ra,40(sp)
ffffffffc02034f6:	7482                	ld	s1,32(sp)
ffffffffc02034f8:	6962                	ld	s2,24(sp)
ffffffffc02034fa:	69c2                	ld	s3,16(sp)
ffffffffc02034fc:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc02034fe:	92efd06f          	j	ffffffffc020062c <intr_enable>
ffffffffc0203502:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0203504:	92efd0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc0203508:	6522                	ld	a0,8(sp)
ffffffffc020350a:	4985                	li	s3,1
ffffffffc020350c:	bf6d                	j	ffffffffc02034c6 <proc_run+0x24>

ffffffffc020350e <find_proc>:
    if (0 < pid && pid < MAX_PID) {
ffffffffc020350e:	6789                	lui	a5,0x2
ffffffffc0203510:	fff5071b          	addiw	a4,a0,-1
ffffffffc0203514:	17f9                	addi	a5,a5,-2
ffffffffc0203516:	04e7e063          	bltu	a5,a4,ffffffffc0203556 <find_proc+0x48>
find_proc(int pid) {
ffffffffc020351a:	1141                	addi	sp,sp,-16
ffffffffc020351c:	e022                	sd	s0,0(sp)
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc020351e:	45a9                	li	a1,10
ffffffffc0203520:	842a                	mv	s0,a0
ffffffffc0203522:	2501                	sext.w	a0,a0
find_proc(int pid) {
ffffffffc0203524:	e406                	sd	ra,8(sp)
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0203526:	772010ef          	jal	ra,ffffffffc0204c98 <hash32>
ffffffffc020352a:	02051693          	slli	a3,a0,0x20
ffffffffc020352e:	0004c797          	auipc	a5,0x4c
ffffffffc0203532:	15278793          	addi	a5,a5,338 # ffffffffc024f680 <hash_list>
ffffffffc0203536:	82f1                	srli	a3,a3,0x1c
ffffffffc0203538:	96be                	add	a3,a3,a5
ffffffffc020353a:	87b6                	mv	a5,a3
        while ((le = list_next(le)) != list) {
ffffffffc020353c:	a029                	j	ffffffffc0203546 <find_proc+0x38>
            if (proc->pid == pid) {
ffffffffc020353e:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0203542:	00870c63          	beq	a4,s0,ffffffffc020355a <find_proc+0x4c>
    return listelm->next;
ffffffffc0203546:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list) {
ffffffffc0203548:	fef69be3          	bne	a3,a5,ffffffffc020353e <find_proc+0x30>
}
ffffffffc020354c:	60a2                	ld	ra,8(sp)
ffffffffc020354e:	6402                	ld	s0,0(sp)
    return NULL;
ffffffffc0203550:	4501                	li	a0,0
}
ffffffffc0203552:	0141                	addi	sp,sp,16
ffffffffc0203554:	8082                	ret
    return NULL;
ffffffffc0203556:	4501                	li	a0,0
}
ffffffffc0203558:	8082                	ret
ffffffffc020355a:	60a2                	ld	ra,8(sp)
ffffffffc020355c:	6402                	ld	s0,0(sp)
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc020355e:	f2878513          	addi	a0,a5,-216
}
ffffffffc0203562:	0141                	addi	sp,sp,16
ffffffffc0203564:	8082                	ret

ffffffffc0203566 <do_fork>:
do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf) {
ffffffffc0203566:	7159                	addi	sp,sp,-112
ffffffffc0203568:	e0d2                	sd	s4,64(sp)
    if (nr_process >= MAX_PROCESS) {
ffffffffc020356a:	00050a17          	auipc	s4,0x50
ffffffffc020356e:	196a0a13          	addi	s4,s4,406 # ffffffffc0253700 <nr_process>
ffffffffc0203572:	000a2703          	lw	a4,0(s4)
do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf) {
ffffffffc0203576:	f486                	sd	ra,104(sp)
ffffffffc0203578:	f0a2                	sd	s0,96(sp)
ffffffffc020357a:	eca6                	sd	s1,88(sp)
ffffffffc020357c:	e8ca                	sd	s2,80(sp)
ffffffffc020357e:	e4ce                	sd	s3,72(sp)
ffffffffc0203580:	fc56                	sd	s5,56(sp)
ffffffffc0203582:	f85a                	sd	s6,48(sp)
ffffffffc0203584:	f45e                	sd	s7,40(sp)
ffffffffc0203586:	f062                	sd	s8,32(sp)
ffffffffc0203588:	ec66                	sd	s9,24(sp)
ffffffffc020358a:	e86a                	sd	s10,16(sp)
ffffffffc020358c:	e46e                	sd	s11,8(sp)
    if (nr_process >= MAX_PROCESS) {
ffffffffc020358e:	6785                	lui	a5,0x1
ffffffffc0203590:	2ef75c63          	bge	a4,a5,ffffffffc0203888 <do_fork+0x322>
ffffffffc0203594:	89aa                	mv	s3,a0
ffffffffc0203596:	892e                	mv	s2,a1
ffffffffc0203598:	84b2                	mv	s1,a2
    if ((proc = alloc_proc()) == NULL) {
ffffffffc020359a:	cdbff0ef          	jal	ra,ffffffffc0203274 <alloc_proc>
ffffffffc020359e:	842a                	mv	s0,a0
ffffffffc02035a0:	2c050163          	beqz	a0,ffffffffc0203862 <do_fork+0x2fc>
    proc->parent = current;
ffffffffc02035a4:	00050c17          	auipc	s8,0x50
ffffffffc02035a8:	144c0c13          	addi	s8,s8,324 # ffffffffc02536e8 <current>
ffffffffc02035ac:	000c3783          	ld	a5,0(s8)
    assert(current->wait_state == 0);
ffffffffc02035b0:	0ec7a703          	lw	a4,236(a5) # 10ec <_binary_obj___user_ex3_out_size-0x8914>
    proc->parent = current;
ffffffffc02035b4:	f11c                	sd	a5,32(a0)
    assert(current->wait_state == 0);
ffffffffc02035b6:	2e071963          	bnez	a4,ffffffffc02038a8 <do_fork+0x342>
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc02035ba:	4509                	li	a0,2
ffffffffc02035bc:	926ff0ef          	jal	ra,ffffffffc02026e2 <alloc_pages>
    if (page != NULL) {
ffffffffc02035c0:	28050e63          	beqz	a0,ffffffffc020385c <do_fork+0x2f6>
    return page - pages + nbase;
ffffffffc02035c4:	00050a97          	auipc	s5,0x50
ffffffffc02035c8:	26ca8a93          	addi	s5,s5,620 # ffffffffc0253830 <pages>
ffffffffc02035cc:	000ab683          	ld	a3,0(s5)
ffffffffc02035d0:	00004b17          	auipc	s6,0x4
ffffffffc02035d4:	c28b0b13          	addi	s6,s6,-984 # ffffffffc02071f8 <nbase>
ffffffffc02035d8:	000b3783          	ld	a5,0(s6)
ffffffffc02035dc:	40d506b3          	sub	a3,a0,a3
ffffffffc02035e0:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02035e2:	00050b97          	auipc	s7,0x50
ffffffffc02035e6:	0feb8b93          	addi	s7,s7,254 # ffffffffc02536e0 <npage>
    return page - pages + nbase;
ffffffffc02035ea:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc02035ec:	000bb703          	ld	a4,0(s7)
ffffffffc02035f0:	00c69793          	slli	a5,a3,0xc
ffffffffc02035f4:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02035f6:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02035f8:	28e7fc63          	bgeu	a5,a4,ffffffffc0203890 <do_fork+0x32a>
    struct mm_struct *mm, *oldmm = current->mm;
ffffffffc02035fc:	000c3703          	ld	a4,0(s8)
ffffffffc0203600:	00050c97          	auipc	s9,0x50
ffffffffc0203604:	220c8c93          	addi	s9,s9,544 # ffffffffc0253820 <va_pa_offset>
ffffffffc0203608:	000cb783          	ld	a5,0(s9)
ffffffffc020360c:	02873c03          	ld	s8,40(a4)
ffffffffc0203610:	96be                	add	a3,a3,a5
        proc->kstack = (uintptr_t)page2kva(page);
ffffffffc0203612:	e814                	sd	a3,16(s0)
    if (oldmm == NULL) {
ffffffffc0203614:	020c0863          	beqz	s8,ffffffffc0203644 <do_fork+0xde>
    if (clone_flags & CLONE_VM) {
ffffffffc0203618:	1009f993          	andi	s3,s3,256
ffffffffc020361c:	1a098e63          	beqz	s3,ffffffffc02037d8 <do_fork+0x272>
}

static inline int
mm_count_inc(struct mm_struct *mm) {
    mm->mm_count += 1;
ffffffffc0203620:	030c2703          	lw	a4,48(s8)
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc0203624:	018c3783          	ld	a5,24(s8)
ffffffffc0203628:	c02006b7          	lui	a3,0xc0200
ffffffffc020362c:	2705                	addiw	a4,a4,1
ffffffffc020362e:	02ec2823          	sw	a4,48(s8)
    proc->mm = mm;
ffffffffc0203632:	03843423          	sd	s8,40(s0)
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc0203636:	28d7e963          	bltu	a5,a3,ffffffffc02038c8 <do_fork+0x362>
ffffffffc020363a:	000cb703          	ld	a4,0(s9)
ffffffffc020363e:	6814                	ld	a3,16(s0)
ffffffffc0203640:	8f99                	sub	a5,a5,a4
ffffffffc0203642:	f45c                	sd	a5,168(s0)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0203644:	6789                	lui	a5,0x2
ffffffffc0203646:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_ex3_out_size-0x7b20>
ffffffffc020364a:	97b6                	add	a5,a5,a3
ffffffffc020364c:	f05c                	sd	a5,160(s0)
    *(proc->tf) = *tf;
ffffffffc020364e:	873e                	mv	a4,a5
ffffffffc0203650:	12048893          	addi	a7,s1,288
ffffffffc0203654:	0004b803          	ld	a6,0(s1)
ffffffffc0203658:	6488                	ld	a0,8(s1)
ffffffffc020365a:	688c                	ld	a1,16(s1)
ffffffffc020365c:	6c90                	ld	a2,24(s1)
ffffffffc020365e:	01073023          	sd	a6,0(a4)
ffffffffc0203662:	e708                	sd	a0,8(a4)
ffffffffc0203664:	eb0c                	sd	a1,16(a4)
ffffffffc0203666:	ef10                	sd	a2,24(a4)
ffffffffc0203668:	02048493          	addi	s1,s1,32
ffffffffc020366c:	02070713          	addi	a4,a4,32
ffffffffc0203670:	ff1492e3          	bne	s1,a7,ffffffffc0203654 <do_fork+0xee>
    proc->tf->gpr.a0 = 0;
ffffffffc0203674:	0407b823          	sd	zero,80(a5)
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf - 4 : esp;
ffffffffc0203678:	12090a63          	beqz	s2,ffffffffc02037ac <do_fork+0x246>
ffffffffc020367c:	0127b823          	sd	s2,16(a5)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc0203680:	00000717          	auipc	a4,0x0
ffffffffc0203684:	c7470713          	addi	a4,a4,-908 # ffffffffc02032f4 <forkret>
ffffffffc0203688:	f818                	sd	a4,48(s0)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc020368a:	fc1c                	sd	a5,56(s0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020368c:	100027f3          	csrr	a5,sstatus
ffffffffc0203690:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203692:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203694:	12079e63          	bnez	a5,ffffffffc02037d0 <do_fork+0x26a>
    if (++ last_pid >= MAX_PID) {
ffffffffc0203698:	00045597          	auipc	a1,0x45
ffffffffc020369c:	be058593          	addi	a1,a1,-1056 # ffffffffc0248278 <last_pid.1746>
ffffffffc02036a0:	419c                	lw	a5,0(a1)
ffffffffc02036a2:	6709                	lui	a4,0x2
ffffffffc02036a4:	0017851b          	addiw	a0,a5,1
ffffffffc02036a8:	c188                	sw	a0,0(a1)
ffffffffc02036aa:	08e55b63          	bge	a0,a4,ffffffffc0203740 <do_fork+0x1da>
    if (last_pid >= next_safe) {
ffffffffc02036ae:	00045897          	auipc	a7,0x45
ffffffffc02036b2:	bce88893          	addi	a7,a7,-1074 # ffffffffc024827c <next_safe.1745>
ffffffffc02036b6:	0008a783          	lw	a5,0(a7)
ffffffffc02036ba:	00050497          	auipc	s1,0x50
ffffffffc02036be:	17e48493          	addi	s1,s1,382 # ffffffffc0253838 <proc_list>
ffffffffc02036c2:	08f55663          	bge	a0,a5,ffffffffc020374e <do_fork+0x1e8>
        proc->pid = get_pid();
ffffffffc02036c6:	c048                	sw	a0,4(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc02036c8:	45a9                	li	a1,10
ffffffffc02036ca:	2501                	sext.w	a0,a0
ffffffffc02036cc:	5cc010ef          	jal	ra,ffffffffc0204c98 <hash32>
ffffffffc02036d0:	1502                	slli	a0,a0,0x20
ffffffffc02036d2:	0004c797          	auipc	a5,0x4c
ffffffffc02036d6:	fae78793          	addi	a5,a5,-82 # ffffffffc024f680 <hash_list>
ffffffffc02036da:	8171                	srli	a0,a0,0x1c
ffffffffc02036dc:	953e                	add	a0,a0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc02036de:	650c                	ld	a1,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc02036e0:	7014                	ld	a3,32(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc02036e2:	0d840793          	addi	a5,s0,216
    prev->next = next->prev = elm;
ffffffffc02036e6:	e19c                	sd	a5,0(a1)
    __list_add(elm, listelm, listelm->next);
ffffffffc02036e8:	6490                	ld	a2,8(s1)
    prev->next = next->prev = elm;
ffffffffc02036ea:	e51c                	sd	a5,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc02036ec:	7af8                	ld	a4,240(a3)
    list_add(&proc_list, &(proc->list_link));
ffffffffc02036ee:	0c840793          	addi	a5,s0,200
    elm->next = next;
ffffffffc02036f2:	f06c                	sd	a1,224(s0)
    elm->prev = prev;
ffffffffc02036f4:	ec68                	sd	a0,216(s0)
    prev->next = next->prev = elm;
ffffffffc02036f6:	e21c                	sd	a5,0(a2)
ffffffffc02036f8:	e49c                	sd	a5,8(s1)
    elm->next = next;
ffffffffc02036fa:	e870                	sd	a2,208(s0)
    elm->prev = prev;
ffffffffc02036fc:	e464                	sd	s1,200(s0)
    proc->yptr = NULL;
ffffffffc02036fe:	0e043c23          	sd	zero,248(s0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc0203702:	10e43023          	sd	a4,256(s0)
ffffffffc0203706:	c311                	beqz	a4,ffffffffc020370a <do_fork+0x1a4>
        proc->optr->yptr = proc;
ffffffffc0203708:	ff60                	sd	s0,248(a4)
    nr_process ++;
ffffffffc020370a:	000a2783          	lw	a5,0(s4)
    proc->parent->cptr = proc;
ffffffffc020370e:	fae0                	sd	s0,240(a3)
    nr_process ++;
ffffffffc0203710:	2785                	addiw	a5,a5,1
ffffffffc0203712:	00fa2023          	sw	a5,0(s4)
    if (flag) {
ffffffffc0203716:	14091863          	bnez	s2,ffffffffc0203866 <do_fork+0x300>
    wakeup_proc(proc);
ffffffffc020371a:	8522                	mv	a0,s0
ffffffffc020371c:	5ad000ef          	jal	ra,ffffffffc02044c8 <wakeup_proc>
    ret = proc->pid;
ffffffffc0203720:	4048                	lw	a0,4(s0)
}
ffffffffc0203722:	70a6                	ld	ra,104(sp)
ffffffffc0203724:	7406                	ld	s0,96(sp)
ffffffffc0203726:	64e6                	ld	s1,88(sp)
ffffffffc0203728:	6946                	ld	s2,80(sp)
ffffffffc020372a:	69a6                	ld	s3,72(sp)
ffffffffc020372c:	6a06                	ld	s4,64(sp)
ffffffffc020372e:	7ae2                	ld	s5,56(sp)
ffffffffc0203730:	7b42                	ld	s6,48(sp)
ffffffffc0203732:	7ba2                	ld	s7,40(sp)
ffffffffc0203734:	7c02                	ld	s8,32(sp)
ffffffffc0203736:	6ce2                	ld	s9,24(sp)
ffffffffc0203738:	6d42                	ld	s10,16(sp)
ffffffffc020373a:	6da2                	ld	s11,8(sp)
ffffffffc020373c:	6165                	addi	sp,sp,112
ffffffffc020373e:	8082                	ret
        last_pid = 1;
ffffffffc0203740:	4785                	li	a5,1
ffffffffc0203742:	c19c                	sw	a5,0(a1)
        goto inside;
ffffffffc0203744:	4505                	li	a0,1
ffffffffc0203746:	00045897          	auipc	a7,0x45
ffffffffc020374a:	b3688893          	addi	a7,a7,-1226 # ffffffffc024827c <next_safe.1745>
    return listelm->next;
ffffffffc020374e:	00050497          	auipc	s1,0x50
ffffffffc0203752:	0ea48493          	addi	s1,s1,234 # ffffffffc0253838 <proc_list>
ffffffffc0203756:	0084b303          	ld	t1,8(s1)
        next_safe = MAX_PID;
ffffffffc020375a:	6789                	lui	a5,0x2
ffffffffc020375c:	00f8a023          	sw	a5,0(a7)
ffffffffc0203760:	4801                	li	a6,0
ffffffffc0203762:	87aa                	mv	a5,a0
        while ((le = list_next(le)) != list) {
ffffffffc0203764:	6e89                	lui	t4,0x2
ffffffffc0203766:	10930c63          	beq	t1,s1,ffffffffc020387e <do_fork+0x318>
ffffffffc020376a:	8e42                	mv	t3,a6
ffffffffc020376c:	869a                	mv	a3,t1
ffffffffc020376e:	6609                	lui	a2,0x2
ffffffffc0203770:	a811                	j	ffffffffc0203784 <do_fork+0x21e>
            else if (proc->pid > last_pid && next_safe > proc->pid) {
ffffffffc0203772:	00e7d663          	bge	a5,a4,ffffffffc020377e <do_fork+0x218>
ffffffffc0203776:	00c75463          	bge	a4,a2,ffffffffc020377e <do_fork+0x218>
ffffffffc020377a:	863a                	mv	a2,a4
ffffffffc020377c:	4e05                	li	t3,1
ffffffffc020377e:	6694                	ld	a3,8(a3)
        while ((le = list_next(le)) != list) {
ffffffffc0203780:	00968d63          	beq	a3,s1,ffffffffc020379a <do_fork+0x234>
            if (proc->pid == last_pid) {
ffffffffc0203784:	f3c6a703          	lw	a4,-196(a3) # ffffffffc01fff3c <_binary_obj___user_ex2_out_size+0xffffffffc01f51cc>
ffffffffc0203788:	fee795e3          	bne	a5,a4,ffffffffc0203772 <do_fork+0x20c>
                if (++ last_pid >= next_safe) {
ffffffffc020378c:	2785                	addiw	a5,a5,1
ffffffffc020378e:	0cc7df63          	bge	a5,a2,ffffffffc020386c <do_fork+0x306>
ffffffffc0203792:	6694                	ld	a3,8(a3)
ffffffffc0203794:	4805                	li	a6,1
        while ((le = list_next(le)) != list) {
ffffffffc0203796:	fe9697e3          	bne	a3,s1,ffffffffc0203784 <do_fork+0x21e>
ffffffffc020379a:	00080463          	beqz	a6,ffffffffc02037a2 <do_fork+0x23c>
ffffffffc020379e:	c19c                	sw	a5,0(a1)
ffffffffc02037a0:	853e                	mv	a0,a5
ffffffffc02037a2:	f20e02e3          	beqz	t3,ffffffffc02036c6 <do_fork+0x160>
ffffffffc02037a6:	00c8a023          	sw	a2,0(a7)
ffffffffc02037aa:	bf31                	j	ffffffffc02036c6 <do_fork+0x160>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf - 4 : esp;
ffffffffc02037ac:	6909                	lui	s2,0x2
ffffffffc02037ae:	edc90913          	addi	s2,s2,-292 # 1edc <_binary_obj___user_ex3_out_size-0x7b24>
ffffffffc02037b2:	9936                	add	s2,s2,a3
ffffffffc02037b4:	0127b823          	sd	s2,16(a5) # 2010 <_binary_obj___user_ex3_out_size-0x79f0>
    proc->context.ra = (uintptr_t)forkret;
ffffffffc02037b8:	00000717          	auipc	a4,0x0
ffffffffc02037bc:	b3c70713          	addi	a4,a4,-1220 # ffffffffc02032f4 <forkret>
ffffffffc02037c0:	f818                	sd	a4,48(s0)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc02037c2:	fc1c                	sd	a5,56(s0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02037c4:	100027f3          	csrr	a5,sstatus
ffffffffc02037c8:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02037ca:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02037cc:	ec0786e3          	beqz	a5,ffffffffc0203698 <do_fork+0x132>
        intr_disable();
ffffffffc02037d0:	e63fc0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc02037d4:	4905                	li	s2,1
ffffffffc02037d6:	b5c9                	j	ffffffffc0203698 <do_fork+0x132>
    if ((mm = mm_create()) == NULL) {
ffffffffc02037d8:	d82fd0ef          	jal	ra,ffffffffc0200d5a <mm_create>
ffffffffc02037dc:	89aa                	mv	s3,a0
ffffffffc02037de:	c539                	beqz	a0,ffffffffc020382c <do_fork+0x2c6>
    if (setup_pgdir(mm) != 0) {
ffffffffc02037e0:	c17ff0ef          	jal	ra,ffffffffc02033f6 <setup_pgdir>
ffffffffc02037e4:	e949                	bnez	a0,ffffffffc0203876 <do_fork+0x310>
}

static inline void
lock_mm(struct mm_struct *mm) {
    if (mm != NULL) {
        lock(&(mm->mm_lock));
ffffffffc02037e6:	038c0d93          	addi	s11,s8,56
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool test_and_set_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02037ea:	4785                	li	a5,1
ffffffffc02037ec:	40fdb7af          	amoor.d	a5,a5,(s11)
    return !test_and_set_bit(0, lock);
}

static inline void
lock(lock_t *lock) {
    while (!try_lock(lock)) {
ffffffffc02037f0:	8b85                	andi	a5,a5,1
ffffffffc02037f2:	4d05                	li	s10,1
ffffffffc02037f4:	c799                	beqz	a5,ffffffffc0203802 <do_fork+0x29c>
        schedule();
ffffffffc02037f6:	585000ef          	jal	ra,ffffffffc020457a <schedule>
ffffffffc02037fa:	41adb7af          	amoor.d	a5,s10,(s11)
    while (!try_lock(lock)) {
ffffffffc02037fe:	8b85                	andi	a5,a5,1
ffffffffc0203800:	fbfd                	bnez	a5,ffffffffc02037f6 <do_fork+0x290>
        ret = dup_mmap(mm, oldmm);
ffffffffc0203802:	85e2                	mv	a1,s8
ffffffffc0203804:	854e                	mv	a0,s3
ffffffffc0203806:	faefd0ef          	jal	ra,ffffffffc0200fb4 <dup_mmap>
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool test_and_clear_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc020380a:	57f9                	li	a5,-2
ffffffffc020380c:	60fdb7af          	amoand.d	a5,a5,(s11)
ffffffffc0203810:	8b85                	andi	a5,a5,1
    }
}

static inline void
unlock(lock_t *lock) {
    if (!test_and_clear_bit(0, lock)) {
ffffffffc0203812:	cbe1                	beqz	a5,ffffffffc02038e2 <do_fork+0x37c>
good_mm:
ffffffffc0203814:	8c4e                	mv	s8,s3
    if (ret != 0) {
ffffffffc0203816:	e00505e3          	beqz	a0,ffffffffc0203620 <do_fork+0xba>
    exit_mmap(mm);
ffffffffc020381a:	854e                	mv	a0,s3
ffffffffc020381c:	833fd0ef          	jal	ra,ffffffffc020104e <exit_mmap>
    put_pgdir(mm);
ffffffffc0203820:	854e                	mv	a0,s3
ffffffffc0203822:	b5fff0ef          	jal	ra,ffffffffc0203380 <put_pgdir>
    mm_destroy(mm);
ffffffffc0203826:	854e                	mv	a0,s3
ffffffffc0203828:	e8afd0ef          	jal	ra,ffffffffc0200eb2 <mm_destroy>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc020382c:	6814                	ld	a3,16(s0)
    return pa2page(PADDR(kva));
ffffffffc020382e:	c02007b7          	lui	a5,0xc0200
ffffffffc0203832:	0ef6e063          	bltu	a3,a5,ffffffffc0203912 <do_fork+0x3ac>
ffffffffc0203836:	000cb783          	ld	a5,0(s9)
    if (PPN(pa) >= npage) {
ffffffffc020383a:	000bb703          	ld	a4,0(s7)
    return pa2page(PADDR(kva));
ffffffffc020383e:	40f687b3          	sub	a5,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0203842:	83b1                	srli	a5,a5,0xc
ffffffffc0203844:	0ae7fb63          	bgeu	a5,a4,ffffffffc02038fa <do_fork+0x394>
    return &pages[PPN(pa) - nbase];
ffffffffc0203848:	000b3703          	ld	a4,0(s6)
ffffffffc020384c:	000ab503          	ld	a0,0(s5)
ffffffffc0203850:	4589                	li	a1,2
ffffffffc0203852:	8f99                	sub	a5,a5,a4
ffffffffc0203854:	079a                	slli	a5,a5,0x6
ffffffffc0203856:	953e                	add	a0,a0,a5
ffffffffc0203858:	f1dfe0ef          	jal	ra,ffffffffc0202774 <free_pages>
    kfree(proc);
ffffffffc020385c:	8522                	mv	a0,s0
ffffffffc020385e:	89efe0ef          	jal	ra,ffffffffc02018fc <kfree>
    ret = -E_NO_MEM;
ffffffffc0203862:	5571                	li	a0,-4
    return ret;
ffffffffc0203864:	bd7d                	j	ffffffffc0203722 <do_fork+0x1bc>
        intr_enable();
ffffffffc0203866:	dc7fc0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc020386a:	bd45                	j	ffffffffc020371a <do_fork+0x1b4>
                    if (last_pid >= MAX_PID) {
ffffffffc020386c:	01d7c363          	blt	a5,t4,ffffffffc0203872 <do_fork+0x30c>
                        last_pid = 1;
ffffffffc0203870:	4785                	li	a5,1
                    goto repeat;
ffffffffc0203872:	4805                	li	a6,1
ffffffffc0203874:	bdcd                	j	ffffffffc0203766 <do_fork+0x200>
    mm_destroy(mm);
ffffffffc0203876:	854e                	mv	a0,s3
ffffffffc0203878:	e3afd0ef          	jal	ra,ffffffffc0200eb2 <mm_destroy>
ffffffffc020387c:	bf45                	j	ffffffffc020382c <do_fork+0x2c6>
ffffffffc020387e:	00080763          	beqz	a6,ffffffffc020388c <do_fork+0x326>
ffffffffc0203882:	c19c                	sw	a5,0(a1)
ffffffffc0203884:	853e                	mv	a0,a5
ffffffffc0203886:	b581                	j	ffffffffc02036c6 <do_fork+0x160>
    int ret = -E_NO_FREE_PROC;
ffffffffc0203888:	556d                	li	a0,-5
ffffffffc020388a:	bd61                	j	ffffffffc0203722 <do_fork+0x1bc>
ffffffffc020388c:	4188                	lw	a0,0(a1)
ffffffffc020388e:	bd25                	j	ffffffffc02036c6 <do_fork+0x160>
    return KADDR(page2pa(page));
ffffffffc0203890:	00002617          	auipc	a2,0x2
ffffffffc0203894:	15060613          	addi	a2,a2,336 # ffffffffc02059e0 <commands+0xa90>
ffffffffc0203898:	06900593          	li	a1,105
ffffffffc020389c:	00002517          	auipc	a0,0x2
ffffffffc02038a0:	16c50513          	addi	a0,a0,364 # ffffffffc0205a08 <commands+0xab8>
ffffffffc02038a4:	961fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(current->wait_state == 0);
ffffffffc02038a8:	00003697          	auipc	a3,0x3
ffffffffc02038ac:	8f868693          	addi	a3,a3,-1800 # ffffffffc02061a0 <default_pmm_manager+0x228>
ffffffffc02038b0:	00002617          	auipc	a2,0x2
ffffffffc02038b4:	aa860613          	addi	a2,a2,-1368 # ffffffffc0205358 <commands+0x408>
ffffffffc02038b8:	17300593          	li	a1,371
ffffffffc02038bc:	00003517          	auipc	a0,0x3
ffffffffc02038c0:	8cc50513          	addi	a0,a0,-1844 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc02038c4:	941fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc02038c8:	86be                	mv	a3,a5
ffffffffc02038ca:	00002617          	auipc	a2,0x2
ffffffffc02038ce:	18660613          	addi	a2,a2,390 # ffffffffc0205a50 <commands+0xb00>
ffffffffc02038d2:	14600593          	li	a1,326
ffffffffc02038d6:	00003517          	auipc	a0,0x3
ffffffffc02038da:	8b250513          	addi	a0,a0,-1870 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc02038de:	927fc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("Unlock failed.\n");
ffffffffc02038e2:	00003617          	auipc	a2,0x3
ffffffffc02038e6:	8de60613          	addi	a2,a2,-1826 # ffffffffc02061c0 <default_pmm_manager+0x248>
ffffffffc02038ea:	03200593          	li	a1,50
ffffffffc02038ee:	00003517          	auipc	a0,0x3
ffffffffc02038f2:	8e250513          	addi	a0,a0,-1822 # ffffffffc02061d0 <default_pmm_manager+0x258>
ffffffffc02038f6:	90ffc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02038fa:	00002617          	auipc	a2,0x2
ffffffffc02038fe:	17e60613          	addi	a2,a2,382 # ffffffffc0205a78 <commands+0xb28>
ffffffffc0203902:	06200593          	li	a1,98
ffffffffc0203906:	00002517          	auipc	a0,0x2
ffffffffc020390a:	10250513          	addi	a0,a0,258 # ffffffffc0205a08 <commands+0xab8>
ffffffffc020390e:	8f7fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0203912:	00002617          	auipc	a2,0x2
ffffffffc0203916:	13e60613          	addi	a2,a2,318 # ffffffffc0205a50 <commands+0xb00>
ffffffffc020391a:	06e00593          	li	a1,110
ffffffffc020391e:	00002517          	auipc	a0,0x2
ffffffffc0203922:	0ea50513          	addi	a0,a0,234 # ffffffffc0205a08 <commands+0xab8>
ffffffffc0203926:	8dffc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020392a <kernel_thread>:
kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags) {
ffffffffc020392a:	7129                	addi	sp,sp,-320
ffffffffc020392c:	fa22                	sd	s0,304(sp)
ffffffffc020392e:	f626                	sd	s1,296(sp)
ffffffffc0203930:	f24a                	sd	s2,288(sp)
ffffffffc0203932:	84ae                	mv	s1,a1
ffffffffc0203934:	892a                	mv	s2,a0
ffffffffc0203936:	8432                	mv	s0,a2
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc0203938:	4581                	li	a1,0
ffffffffc020393a:	12000613          	li	a2,288
ffffffffc020393e:	850a                	mv	a0,sp
kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags) {
ffffffffc0203940:	fe06                	sd	ra,312(sp)
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc0203942:	73f000ef          	jal	ra,ffffffffc0204880 <memset>
    tf.gpr.s0 = (uintptr_t)fn;
ffffffffc0203946:	e0ca                	sd	s2,64(sp)
    tf.gpr.s1 = (uintptr_t)arg;
ffffffffc0203948:	e4a6                	sd	s1,72(sp)
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
ffffffffc020394a:	100027f3          	csrr	a5,sstatus
ffffffffc020394e:	edd7f793          	andi	a5,a5,-291
ffffffffc0203952:	1207e793          	ori	a5,a5,288
ffffffffc0203956:	e23e                	sd	a5,256(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0203958:	860a                	mv	a2,sp
ffffffffc020395a:	10046513          	ori	a0,s0,256
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc020395e:	00000797          	auipc	a5,0x0
ffffffffc0203962:	90e78793          	addi	a5,a5,-1778 # ffffffffc020326c <kernel_thread_entry>
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0203966:	4581                	li	a1,0
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc0203968:	e63e                	sd	a5,264(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc020396a:	bfdff0ef          	jal	ra,ffffffffc0203566 <do_fork>
}
ffffffffc020396e:	70f2                	ld	ra,312(sp)
ffffffffc0203970:	7452                	ld	s0,304(sp)
ffffffffc0203972:	74b2                	ld	s1,296(sp)
ffffffffc0203974:	7912                	ld	s2,288(sp)
ffffffffc0203976:	6131                	addi	sp,sp,320
ffffffffc0203978:	8082                	ret

ffffffffc020397a <do_exit>:
do_exit(int error_code) {
ffffffffc020397a:	7179                	addi	sp,sp,-48
ffffffffc020397c:	f022                	sd	s0,32(sp)
    if (current == idleproc) {
ffffffffc020397e:	00050417          	auipc	s0,0x50
ffffffffc0203982:	d6a40413          	addi	s0,s0,-662 # ffffffffc02536e8 <current>
ffffffffc0203986:	601c                	ld	a5,0(s0)
do_exit(int error_code) {
ffffffffc0203988:	f406                	sd	ra,40(sp)
ffffffffc020398a:	ec26                	sd	s1,24(sp)
ffffffffc020398c:	e84a                	sd	s2,16(sp)
ffffffffc020398e:	e44e                	sd	s3,8(sp)
ffffffffc0203990:	e052                	sd	s4,0(sp)
    if (current == idleproc) {
ffffffffc0203992:	00050717          	auipc	a4,0x50
ffffffffc0203996:	d5e73703          	ld	a4,-674(a4) # ffffffffc02536f0 <idleproc>
ffffffffc020399a:	0ce78c63          	beq	a5,a4,ffffffffc0203a72 <do_exit+0xf8>
    if (current == initproc) {
ffffffffc020399e:	00050497          	auipc	s1,0x50
ffffffffc02039a2:	d5a48493          	addi	s1,s1,-678 # ffffffffc02536f8 <initproc>
ffffffffc02039a6:	6098                	ld	a4,0(s1)
ffffffffc02039a8:	0ee78b63          	beq	a5,a4,ffffffffc0203a9e <do_exit+0x124>
    struct mm_struct *mm = current->mm;
ffffffffc02039ac:	0287b983          	ld	s3,40(a5)
ffffffffc02039b0:	892a                	mv	s2,a0
    if (mm != NULL) {
ffffffffc02039b2:	02098663          	beqz	s3,ffffffffc02039de <do_exit+0x64>
ffffffffc02039b6:	00050797          	auipc	a5,0x50
ffffffffc02039ba:	e727b783          	ld	a5,-398(a5) # ffffffffc0253828 <boot_cr3>
ffffffffc02039be:	577d                	li	a4,-1
ffffffffc02039c0:	177e                	slli	a4,a4,0x3f
ffffffffc02039c2:	83b1                	srli	a5,a5,0xc
ffffffffc02039c4:	8fd9                	or	a5,a5,a4
ffffffffc02039c6:	18079073          	csrw	satp,a5
    mm->mm_count -= 1;
ffffffffc02039ca:	0309a783          	lw	a5,48(s3) # 80030 <_binary_obj___user_ex2_out_size+0x752c0>
ffffffffc02039ce:	fff7871b          	addiw	a4,a5,-1
ffffffffc02039d2:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0) {
ffffffffc02039d6:	cb55                	beqz	a4,ffffffffc0203a8a <do_exit+0x110>
        current->mm = NULL;
ffffffffc02039d8:	601c                	ld	a5,0(s0)
ffffffffc02039da:	0207b423          	sd	zero,40(a5)
    current->state = PROC_ZOMBIE;
ffffffffc02039de:	601c                	ld	a5,0(s0)
ffffffffc02039e0:	470d                	li	a4,3
ffffffffc02039e2:	c398                	sw	a4,0(a5)
    current->exit_code = error_code;
ffffffffc02039e4:	0f27a423          	sw	s2,232(a5)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02039e8:	100027f3          	csrr	a5,sstatus
ffffffffc02039ec:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02039ee:	4a01                	li	s4,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02039f0:	e3f9                	bnez	a5,ffffffffc0203ab6 <do_exit+0x13c>
        proc = current->parent;
ffffffffc02039f2:	6018                	ld	a4,0(s0)
        if (proc->wait_state == WT_CHILD) {
ffffffffc02039f4:	800007b7          	lui	a5,0x80000
ffffffffc02039f8:	0785                	addi	a5,a5,1
        proc = current->parent;
ffffffffc02039fa:	7308                	ld	a0,32(a4)
        if (proc->wait_state == WT_CHILD) {
ffffffffc02039fc:	0ec52703          	lw	a4,236(a0)
ffffffffc0203a00:	0af70f63          	beq	a4,a5,ffffffffc0203abe <do_exit+0x144>
        while (current->cptr != NULL) {
ffffffffc0203a04:	6018                	ld	a4,0(s0)
ffffffffc0203a06:	7b7c                	ld	a5,240(a4)
ffffffffc0203a08:	c3a1                	beqz	a5,ffffffffc0203a48 <do_exit+0xce>
                if (initproc->wait_state == WT_CHILD) {
ffffffffc0203a0a:	800009b7          	lui	s3,0x80000
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203a0e:	490d                	li	s2,3
                if (initproc->wait_state == WT_CHILD) {
ffffffffc0203a10:	0985                	addi	s3,s3,1
ffffffffc0203a12:	a021                	j	ffffffffc0203a1a <do_exit+0xa0>
        while (current->cptr != NULL) {
ffffffffc0203a14:	6018                	ld	a4,0(s0)
ffffffffc0203a16:	7b7c                	ld	a5,240(a4)
ffffffffc0203a18:	cb85                	beqz	a5,ffffffffc0203a48 <do_exit+0xce>
            current->cptr = proc->optr;
ffffffffc0203a1a:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_obj___user_ex2_out_size+0xffffffff7fff5390>
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc0203a1e:	6088                	ld	a0,0(s1)
            current->cptr = proc->optr;
ffffffffc0203a20:	fb74                	sd	a3,240(a4)
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc0203a22:	7978                	ld	a4,240(a0)
            proc->yptr = NULL;
ffffffffc0203a24:	0e07bc23          	sd	zero,248(a5)
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc0203a28:	10e7b023          	sd	a4,256(a5)
ffffffffc0203a2c:	c311                	beqz	a4,ffffffffc0203a30 <do_exit+0xb6>
                initproc->cptr->yptr = proc;
ffffffffc0203a2e:	ff7c                	sd	a5,248(a4)
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203a30:	4398                	lw	a4,0(a5)
            proc->parent = initproc;
ffffffffc0203a32:	f388                	sd	a0,32(a5)
            initproc->cptr = proc;
ffffffffc0203a34:	f97c                	sd	a5,240(a0)
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203a36:	fd271fe3          	bne	a4,s2,ffffffffc0203a14 <do_exit+0x9a>
                if (initproc->wait_state == WT_CHILD) {
ffffffffc0203a3a:	0ec52783          	lw	a5,236(a0)
ffffffffc0203a3e:	fd379be3          	bne	a5,s3,ffffffffc0203a14 <do_exit+0x9a>
                    wakeup_proc(initproc);
ffffffffc0203a42:	287000ef          	jal	ra,ffffffffc02044c8 <wakeup_proc>
ffffffffc0203a46:	b7f9                	j	ffffffffc0203a14 <do_exit+0x9a>
    if (flag) {
ffffffffc0203a48:	020a1263          	bnez	s4,ffffffffc0203a6c <do_exit+0xf2>
    schedule();
ffffffffc0203a4c:	32f000ef          	jal	ra,ffffffffc020457a <schedule>
    panic("do_exit will not return!! %d.\n", current->pid);
ffffffffc0203a50:	601c                	ld	a5,0(s0)
ffffffffc0203a52:	00002617          	auipc	a2,0x2
ffffffffc0203a56:	7b660613          	addi	a2,a2,1974 # ffffffffc0206208 <default_pmm_manager+0x290>
ffffffffc0203a5a:	1c600593          	li	a1,454
ffffffffc0203a5e:	43d4                	lw	a3,4(a5)
ffffffffc0203a60:	00002517          	auipc	a0,0x2
ffffffffc0203a64:	72850513          	addi	a0,a0,1832 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0203a68:	f9cfc0ef          	jal	ra,ffffffffc0200204 <__panic>
        intr_enable();
ffffffffc0203a6c:	bc1fc0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc0203a70:	bff1                	j	ffffffffc0203a4c <do_exit+0xd2>
        panic("idleproc exit.\n");
ffffffffc0203a72:	00002617          	auipc	a2,0x2
ffffffffc0203a76:	77660613          	addi	a2,a2,1910 # ffffffffc02061e8 <default_pmm_manager+0x270>
ffffffffc0203a7a:	19a00593          	li	a1,410
ffffffffc0203a7e:	00002517          	auipc	a0,0x2
ffffffffc0203a82:	70a50513          	addi	a0,a0,1802 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0203a86:	f7efc0ef          	jal	ra,ffffffffc0200204 <__panic>
            exit_mmap(mm);
ffffffffc0203a8a:	854e                	mv	a0,s3
ffffffffc0203a8c:	dc2fd0ef          	jal	ra,ffffffffc020104e <exit_mmap>
            put_pgdir(mm);
ffffffffc0203a90:	854e                	mv	a0,s3
ffffffffc0203a92:	8efff0ef          	jal	ra,ffffffffc0203380 <put_pgdir>
            mm_destroy(mm);
ffffffffc0203a96:	854e                	mv	a0,s3
ffffffffc0203a98:	c1afd0ef          	jal	ra,ffffffffc0200eb2 <mm_destroy>
ffffffffc0203a9c:	bf35                	j	ffffffffc02039d8 <do_exit+0x5e>
        panic("initproc exit.\n");
ffffffffc0203a9e:	00002617          	auipc	a2,0x2
ffffffffc0203aa2:	75a60613          	addi	a2,a2,1882 # ffffffffc02061f8 <default_pmm_manager+0x280>
ffffffffc0203aa6:	19d00593          	li	a1,413
ffffffffc0203aaa:	00002517          	auipc	a0,0x2
ffffffffc0203aae:	6de50513          	addi	a0,a0,1758 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0203ab2:	f52fc0ef          	jal	ra,ffffffffc0200204 <__panic>
        intr_disable();
ffffffffc0203ab6:	b7dfc0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc0203aba:	4a05                	li	s4,1
ffffffffc0203abc:	bf1d                	j	ffffffffc02039f2 <do_exit+0x78>
            wakeup_proc(proc);
ffffffffc0203abe:	20b000ef          	jal	ra,ffffffffc02044c8 <wakeup_proc>
ffffffffc0203ac2:	b789                	j	ffffffffc0203a04 <do_exit+0x8a>

ffffffffc0203ac4 <do_wait.part.0>:
do_wait(int pid, int *code_store) {
ffffffffc0203ac4:	7139                	addi	sp,sp,-64
ffffffffc0203ac6:	e852                	sd	s4,16(sp)
        current->wait_state = WT_CHILD;
ffffffffc0203ac8:	80000a37          	lui	s4,0x80000
do_wait(int pid, int *code_store) {
ffffffffc0203acc:	f426                	sd	s1,40(sp)
ffffffffc0203ace:	f04a                	sd	s2,32(sp)
ffffffffc0203ad0:	ec4e                	sd	s3,24(sp)
ffffffffc0203ad2:	e456                	sd	s5,8(sp)
ffffffffc0203ad4:	e05a                	sd	s6,0(sp)
ffffffffc0203ad6:	fc06                	sd	ra,56(sp)
ffffffffc0203ad8:	f822                	sd	s0,48(sp)
ffffffffc0203ada:	892a                	mv	s2,a0
ffffffffc0203adc:	8aae                	mv	s5,a1
        proc = current->cptr;
ffffffffc0203ade:	00050997          	auipc	s3,0x50
ffffffffc0203ae2:	c0a98993          	addi	s3,s3,-1014 # ffffffffc02536e8 <current>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203ae6:	448d                	li	s1,3
        current->state = PROC_SLEEPING;
ffffffffc0203ae8:	4b05                	li	s6,1
        current->wait_state = WT_CHILD;
ffffffffc0203aea:	2a05                	addiw	s4,s4,1
    if (pid != 0) {
ffffffffc0203aec:	02090f63          	beqz	s2,ffffffffc0203b2a <do_wait.part.0+0x66>
        proc = find_proc(pid);
ffffffffc0203af0:	854a                	mv	a0,s2
ffffffffc0203af2:	a1dff0ef          	jal	ra,ffffffffc020350e <find_proc>
ffffffffc0203af6:	842a                	mv	s0,a0
        if (proc != NULL && proc->parent == current) {
ffffffffc0203af8:	10050763          	beqz	a0,ffffffffc0203c06 <do_wait.part.0+0x142>
ffffffffc0203afc:	0009b703          	ld	a4,0(s3)
ffffffffc0203b00:	711c                	ld	a5,32(a0)
ffffffffc0203b02:	10e79263          	bne	a5,a4,ffffffffc0203c06 <do_wait.part.0+0x142>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203b06:	411c                	lw	a5,0(a0)
ffffffffc0203b08:	02978c63          	beq	a5,s1,ffffffffc0203b40 <do_wait.part.0+0x7c>
        current->state = PROC_SLEEPING;
ffffffffc0203b0c:	01672023          	sw	s6,0(a4)
        current->wait_state = WT_CHILD;
ffffffffc0203b10:	0f472623          	sw	s4,236(a4)
        schedule();
ffffffffc0203b14:	267000ef          	jal	ra,ffffffffc020457a <schedule>
        if (current->flags & PF_EXITING) {
ffffffffc0203b18:	0009b783          	ld	a5,0(s3)
ffffffffc0203b1c:	0b07a783          	lw	a5,176(a5)
ffffffffc0203b20:	8b85                	andi	a5,a5,1
ffffffffc0203b22:	d7e9                	beqz	a5,ffffffffc0203aec <do_wait.part.0+0x28>
            do_exit(-E_KILLED);
ffffffffc0203b24:	555d                	li	a0,-9
ffffffffc0203b26:	e55ff0ef          	jal	ra,ffffffffc020397a <do_exit>
        proc = current->cptr;
ffffffffc0203b2a:	0009b703          	ld	a4,0(s3)
ffffffffc0203b2e:	7b60                	ld	s0,240(a4)
        for (; proc != NULL; proc = proc->optr) {
ffffffffc0203b30:	e409                	bnez	s0,ffffffffc0203b3a <do_wait.part.0+0x76>
ffffffffc0203b32:	a8d1                	j	ffffffffc0203c06 <do_wait.part.0+0x142>
ffffffffc0203b34:	10043403          	ld	s0,256(s0)
ffffffffc0203b38:	d871                	beqz	s0,ffffffffc0203b0c <do_wait.part.0+0x48>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203b3a:	401c                	lw	a5,0(s0)
ffffffffc0203b3c:	fe979ce3          	bne	a5,s1,ffffffffc0203b34 <do_wait.part.0+0x70>
    if (proc == idleproc || proc == initproc) {
ffffffffc0203b40:	00050797          	auipc	a5,0x50
ffffffffc0203b44:	bb07b783          	ld	a5,-1104(a5) # ffffffffc02536f0 <idleproc>
ffffffffc0203b48:	0c878563          	beq	a5,s0,ffffffffc0203c12 <do_wait.part.0+0x14e>
ffffffffc0203b4c:	00050797          	auipc	a5,0x50
ffffffffc0203b50:	bac7b783          	ld	a5,-1108(a5) # ffffffffc02536f8 <initproc>
ffffffffc0203b54:	0af40f63          	beq	s0,a5,ffffffffc0203c12 <do_wait.part.0+0x14e>
    if (code_store != NULL) {
ffffffffc0203b58:	000a8663          	beqz	s5,ffffffffc0203b64 <do_wait.part.0+0xa0>
        *code_store = proc->exit_code;
ffffffffc0203b5c:	0e842783          	lw	a5,232(s0)
ffffffffc0203b60:	00faa023          	sw	a5,0(s5)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203b64:	100027f3          	csrr	a5,sstatus
ffffffffc0203b68:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203b6a:	4581                	li	a1,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203b6c:	efd9                	bnez	a5,ffffffffc0203c0a <do_wait.part.0+0x146>
    __list_del(listelm->prev, listelm->next);
ffffffffc0203b6e:	6c70                	ld	a2,216(s0)
ffffffffc0203b70:	7074                	ld	a3,224(s0)
    if (proc->optr != NULL) {
ffffffffc0203b72:	10043703          	ld	a4,256(s0)
ffffffffc0203b76:	7c7c                	ld	a5,248(s0)
    prev->next = next;
ffffffffc0203b78:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0203b7a:	e290                	sd	a2,0(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0203b7c:	6470                	ld	a2,200(s0)
ffffffffc0203b7e:	6874                	ld	a3,208(s0)
    prev->next = next;
ffffffffc0203b80:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0203b82:	e290                	sd	a2,0(a3)
ffffffffc0203b84:	c319                	beqz	a4,ffffffffc0203b8a <do_wait.part.0+0xc6>
        proc->optr->yptr = proc->yptr;
ffffffffc0203b86:	ff7c                	sd	a5,248(a4)
ffffffffc0203b88:	7c7c                	ld	a5,248(s0)
    if (proc->yptr != NULL) {
ffffffffc0203b8a:	cbbd                	beqz	a5,ffffffffc0203c00 <do_wait.part.0+0x13c>
        proc->yptr->optr = proc->optr;
ffffffffc0203b8c:	10e7b023          	sd	a4,256(a5)
    nr_process --;
ffffffffc0203b90:	00050717          	auipc	a4,0x50
ffffffffc0203b94:	b7070713          	addi	a4,a4,-1168 # ffffffffc0253700 <nr_process>
ffffffffc0203b98:	431c                	lw	a5,0(a4)
ffffffffc0203b9a:	37fd                	addiw	a5,a5,-1
ffffffffc0203b9c:	c31c                	sw	a5,0(a4)
    if (flag) {
ffffffffc0203b9e:	edb1                	bnez	a1,ffffffffc0203bfa <do_wait.part.0+0x136>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc0203ba0:	6814                	ld	a3,16(s0)
ffffffffc0203ba2:	c02007b7          	lui	a5,0xc0200
ffffffffc0203ba6:	08f6ee63          	bltu	a3,a5,ffffffffc0203c42 <do_wait.part.0+0x17e>
ffffffffc0203baa:	00050797          	auipc	a5,0x50
ffffffffc0203bae:	c767b783          	ld	a5,-906(a5) # ffffffffc0253820 <va_pa_offset>
ffffffffc0203bb2:	8e9d                	sub	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0203bb4:	82b1                	srli	a3,a3,0xc
ffffffffc0203bb6:	00050797          	auipc	a5,0x50
ffffffffc0203bba:	b2a7b783          	ld	a5,-1238(a5) # ffffffffc02536e0 <npage>
ffffffffc0203bbe:	06f6f663          	bgeu	a3,a5,ffffffffc0203c2a <do_wait.part.0+0x166>
    return &pages[PPN(pa) - nbase];
ffffffffc0203bc2:	00003517          	auipc	a0,0x3
ffffffffc0203bc6:	63653503          	ld	a0,1590(a0) # ffffffffc02071f8 <nbase>
ffffffffc0203bca:	8e89                	sub	a3,a3,a0
ffffffffc0203bcc:	069a                	slli	a3,a3,0x6
ffffffffc0203bce:	00050517          	auipc	a0,0x50
ffffffffc0203bd2:	c6253503          	ld	a0,-926(a0) # ffffffffc0253830 <pages>
ffffffffc0203bd6:	9536                	add	a0,a0,a3
ffffffffc0203bd8:	4589                	li	a1,2
ffffffffc0203bda:	b9bfe0ef          	jal	ra,ffffffffc0202774 <free_pages>
    kfree(proc);
ffffffffc0203bde:	8522                	mv	a0,s0
ffffffffc0203be0:	d1dfd0ef          	jal	ra,ffffffffc02018fc <kfree>
    return 0;
ffffffffc0203be4:	4501                	li	a0,0
}
ffffffffc0203be6:	70e2                	ld	ra,56(sp)
ffffffffc0203be8:	7442                	ld	s0,48(sp)
ffffffffc0203bea:	74a2                	ld	s1,40(sp)
ffffffffc0203bec:	7902                	ld	s2,32(sp)
ffffffffc0203bee:	69e2                	ld	s3,24(sp)
ffffffffc0203bf0:	6a42                	ld	s4,16(sp)
ffffffffc0203bf2:	6aa2                	ld	s5,8(sp)
ffffffffc0203bf4:	6b02                	ld	s6,0(sp)
ffffffffc0203bf6:	6121                	addi	sp,sp,64
ffffffffc0203bf8:	8082                	ret
        intr_enable();
ffffffffc0203bfa:	a33fc0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc0203bfe:	b74d                	j	ffffffffc0203ba0 <do_wait.part.0+0xdc>
       proc->parent->cptr = proc->optr;
ffffffffc0203c00:	701c                	ld	a5,32(s0)
ffffffffc0203c02:	fbf8                	sd	a4,240(a5)
ffffffffc0203c04:	b771                	j	ffffffffc0203b90 <do_wait.part.0+0xcc>
    return -E_BAD_PROC;
ffffffffc0203c06:	5579                	li	a0,-2
ffffffffc0203c08:	bff9                	j	ffffffffc0203be6 <do_wait.part.0+0x122>
        intr_disable();
ffffffffc0203c0a:	a29fc0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc0203c0e:	4585                	li	a1,1
ffffffffc0203c10:	bfb9                	j	ffffffffc0203b6e <do_wait.part.0+0xaa>
        panic("wait idleproc or initproc.\n");
ffffffffc0203c12:	00002617          	auipc	a2,0x2
ffffffffc0203c16:	61660613          	addi	a2,a2,1558 # ffffffffc0206228 <default_pmm_manager+0x2b0>
ffffffffc0203c1a:	2b500593          	li	a1,693
ffffffffc0203c1e:	00002517          	auipc	a0,0x2
ffffffffc0203c22:	56a50513          	addi	a0,a0,1386 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0203c26:	ddefc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203c2a:	00002617          	auipc	a2,0x2
ffffffffc0203c2e:	e4e60613          	addi	a2,a2,-434 # ffffffffc0205a78 <commands+0xb28>
ffffffffc0203c32:	06200593          	li	a1,98
ffffffffc0203c36:	00002517          	auipc	a0,0x2
ffffffffc0203c3a:	dd250513          	addi	a0,a0,-558 # ffffffffc0205a08 <commands+0xab8>
ffffffffc0203c3e:	dc6fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0203c42:	00002617          	auipc	a2,0x2
ffffffffc0203c46:	e0e60613          	addi	a2,a2,-498 # ffffffffc0205a50 <commands+0xb00>
ffffffffc0203c4a:	06e00593          	li	a1,110
ffffffffc0203c4e:	00002517          	auipc	a0,0x2
ffffffffc0203c52:	dba50513          	addi	a0,a0,-582 # ffffffffc0205a08 <commands+0xab8>
ffffffffc0203c56:	daefc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203c5a <init_main>:
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg) {
ffffffffc0203c5a:	1141                	addi	sp,sp,-16
ffffffffc0203c5c:	e406                	sd	ra,8(sp)
    size_t nr_free_pages_store = nr_free_pages();
ffffffffc0203c5e:	b59fe0ef          	jal	ra,ffffffffc02027b6 <nr_free_pages>
    size_t kernel_allocated_store = kallocated();
ffffffffc0203c62:	be7fd0ef          	jal	ra,ffffffffc0201848 <kallocated>

    int pid = kernel_thread(user_main, NULL, 0);
ffffffffc0203c66:	4601                	li	a2,0
ffffffffc0203c68:	4581                	li	a1,0
ffffffffc0203c6a:	fffff517          	auipc	a0,0xfffff
ffffffffc0203c6e:	69850513          	addi	a0,a0,1688 # ffffffffc0203302 <user_main>
ffffffffc0203c72:	cb9ff0ef          	jal	ra,ffffffffc020392a <kernel_thread>
    if (pid <= 0) {
ffffffffc0203c76:	00a04563          	bgtz	a0,ffffffffc0203c80 <init_main+0x26>
ffffffffc0203c7a:	a071                	j	ffffffffc0203d06 <init_main+0xac>
        panic("create user_main failed.\n");
    }

    while (do_wait(0, NULL) == 0) {
        schedule();
ffffffffc0203c7c:	0ff000ef          	jal	ra,ffffffffc020457a <schedule>
    if (code_store != NULL) {
ffffffffc0203c80:	4581                	li	a1,0
ffffffffc0203c82:	4501                	li	a0,0
ffffffffc0203c84:	e41ff0ef          	jal	ra,ffffffffc0203ac4 <do_wait.part.0>
    while (do_wait(0, NULL) == 0) {
ffffffffc0203c88:	d975                	beqz	a0,ffffffffc0203c7c <init_main+0x22>
    }

    cprintf("all user-mode processes have quit.\n");
ffffffffc0203c8a:	00002517          	auipc	a0,0x2
ffffffffc0203c8e:	5de50513          	addi	a0,a0,1502 # ffffffffc0206268 <default_pmm_manager+0x2f0>
ffffffffc0203c92:	c36fc0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0203c96:	00050797          	auipc	a5,0x50
ffffffffc0203c9a:	a627b783          	ld	a5,-1438(a5) # ffffffffc02536f8 <initproc>
ffffffffc0203c9e:	7bf8                	ld	a4,240(a5)
ffffffffc0203ca0:	e339                	bnez	a4,ffffffffc0203ce6 <init_main+0x8c>
ffffffffc0203ca2:	7ff8                	ld	a4,248(a5)
ffffffffc0203ca4:	e329                	bnez	a4,ffffffffc0203ce6 <init_main+0x8c>
ffffffffc0203ca6:	1007b703          	ld	a4,256(a5)
ffffffffc0203caa:	ef15                	bnez	a4,ffffffffc0203ce6 <init_main+0x8c>
    assert(nr_process == 2);
ffffffffc0203cac:	00050697          	auipc	a3,0x50
ffffffffc0203cb0:	a546a683          	lw	a3,-1452(a3) # ffffffffc0253700 <nr_process>
ffffffffc0203cb4:	4709                	li	a4,2
ffffffffc0203cb6:	0ae69463          	bne	a3,a4,ffffffffc0203d5e <init_main+0x104>
    return listelm->next;
ffffffffc0203cba:	00050697          	auipc	a3,0x50
ffffffffc0203cbe:	b7e68693          	addi	a3,a3,-1154 # ffffffffc0253838 <proc_list>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0203cc2:	6698                	ld	a4,8(a3)
ffffffffc0203cc4:	0c878793          	addi	a5,a5,200
ffffffffc0203cc8:	06f71b63          	bne	a4,a5,ffffffffc0203d3e <init_main+0xe4>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0203ccc:	629c                	ld	a5,0(a3)
ffffffffc0203cce:	04f71863          	bne	a4,a5,ffffffffc0203d1e <init_main+0xc4>

    //cprintf("init check memory pass.\n");
    cprintf("The end of init_main\n");
ffffffffc0203cd2:	00002517          	auipc	a0,0x2
ffffffffc0203cd6:	67e50513          	addi	a0,a0,1662 # ffffffffc0206350 <default_pmm_manager+0x3d8>
ffffffffc0203cda:	beefc0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    return 0;
}
ffffffffc0203cde:	60a2                	ld	ra,8(sp)
ffffffffc0203ce0:	4501                	li	a0,0
ffffffffc0203ce2:	0141                	addi	sp,sp,16
ffffffffc0203ce4:	8082                	ret
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0203ce6:	00002697          	auipc	a3,0x2
ffffffffc0203cea:	5aa68693          	addi	a3,a3,1450 # ffffffffc0206290 <default_pmm_manager+0x318>
ffffffffc0203cee:	00001617          	auipc	a2,0x1
ffffffffc0203cf2:	66a60613          	addi	a2,a2,1642 # ffffffffc0205358 <commands+0x408>
ffffffffc0203cf6:	31900593          	li	a1,793
ffffffffc0203cfa:	00002517          	auipc	a0,0x2
ffffffffc0203cfe:	48e50513          	addi	a0,a0,1166 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0203d02:	d02fc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("create user_main failed.\n");
ffffffffc0203d06:	00002617          	auipc	a2,0x2
ffffffffc0203d0a:	54260613          	addi	a2,a2,1346 # ffffffffc0206248 <default_pmm_manager+0x2d0>
ffffffffc0203d0e:	31100593          	li	a1,785
ffffffffc0203d12:	00002517          	auipc	a0,0x2
ffffffffc0203d16:	47650513          	addi	a0,a0,1142 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0203d1a:	ceafc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0203d1e:	00002697          	auipc	a3,0x2
ffffffffc0203d22:	60268693          	addi	a3,a3,1538 # ffffffffc0206320 <default_pmm_manager+0x3a8>
ffffffffc0203d26:	00001617          	auipc	a2,0x1
ffffffffc0203d2a:	63260613          	addi	a2,a2,1586 # ffffffffc0205358 <commands+0x408>
ffffffffc0203d2e:	31c00593          	li	a1,796
ffffffffc0203d32:	00002517          	auipc	a0,0x2
ffffffffc0203d36:	45650513          	addi	a0,a0,1110 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0203d3a:	ccafc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0203d3e:	00002697          	auipc	a3,0x2
ffffffffc0203d42:	5b268693          	addi	a3,a3,1458 # ffffffffc02062f0 <default_pmm_manager+0x378>
ffffffffc0203d46:	00001617          	auipc	a2,0x1
ffffffffc0203d4a:	61260613          	addi	a2,a2,1554 # ffffffffc0205358 <commands+0x408>
ffffffffc0203d4e:	31b00593          	li	a1,795
ffffffffc0203d52:	00002517          	auipc	a0,0x2
ffffffffc0203d56:	43650513          	addi	a0,a0,1078 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0203d5a:	caafc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(nr_process == 2);
ffffffffc0203d5e:	00002697          	auipc	a3,0x2
ffffffffc0203d62:	58268693          	addi	a3,a3,1410 # ffffffffc02062e0 <default_pmm_manager+0x368>
ffffffffc0203d66:	00001617          	auipc	a2,0x1
ffffffffc0203d6a:	5f260613          	addi	a2,a2,1522 # ffffffffc0205358 <commands+0x408>
ffffffffc0203d6e:	31a00593          	li	a1,794
ffffffffc0203d72:	00002517          	auipc	a0,0x2
ffffffffc0203d76:	41650513          	addi	a0,a0,1046 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0203d7a:	c8afc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203d7e <do_execve>:
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d7e:	7135                	addi	sp,sp,-160
ffffffffc0203d80:	f4d6                	sd	s5,104(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0203d82:	00050a97          	auipc	s5,0x50
ffffffffc0203d86:	966a8a93          	addi	s5,s5,-1690 # ffffffffc02536e8 <current>
ffffffffc0203d8a:	000ab783          	ld	a5,0(s5)
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d8e:	f8d2                	sd	s4,112(sp)
ffffffffc0203d90:	e526                	sd	s1,136(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0203d92:	0287ba03          	ld	s4,40(a5)
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d96:	e14a                	sd	s2,128(sp)
ffffffffc0203d98:	fcce                	sd	s3,120(sp)
ffffffffc0203d9a:	892a                	mv	s2,a0
ffffffffc0203d9c:	84ae                	mv	s1,a1
ffffffffc0203d9e:	89b2                	mv	s3,a2
    if (!user_mem_check(mm, (uintptr_t)name, len, 0)) {
ffffffffc0203da0:	4681                	li	a3,0
ffffffffc0203da2:	862e                	mv	a2,a1
ffffffffc0203da4:	85aa                	mv	a1,a0
ffffffffc0203da6:	8552                	mv	a0,s4
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203da8:	ed06                	sd	ra,152(sp)
ffffffffc0203daa:	e922                	sd	s0,144(sp)
ffffffffc0203dac:	f0da                	sd	s6,96(sp)
ffffffffc0203dae:	ecde                	sd	s7,88(sp)
ffffffffc0203db0:	e8e2                	sd	s8,80(sp)
ffffffffc0203db2:	e4e6                	sd	s9,72(sp)
ffffffffc0203db4:	e0ea                	sd	s10,64(sp)
ffffffffc0203db6:	fc6e                	sd	s11,56(sp)
    if (!user_mem_check(mm, (uintptr_t)name, len, 0)) {
ffffffffc0203db8:	c10fd0ef          	jal	ra,ffffffffc02011c8 <user_mem_check>
ffffffffc0203dbc:	3e050763          	beqz	a0,ffffffffc02041aa <do_execve+0x42c>
    memset(local_name, 0, sizeof(local_name));
ffffffffc0203dc0:	4641                	li	a2,16
ffffffffc0203dc2:	4581                	li	a1,0
ffffffffc0203dc4:	1008                	addi	a0,sp,32
ffffffffc0203dc6:	2bb000ef          	jal	ra,ffffffffc0204880 <memset>
    memcpy(local_name, name, len);
ffffffffc0203dca:	47bd                	li	a5,15
ffffffffc0203dcc:	8626                	mv	a2,s1
ffffffffc0203dce:	0697ed63          	bltu	a5,s1,ffffffffc0203e48 <do_execve+0xca>
ffffffffc0203dd2:	85ca                	mv	a1,s2
ffffffffc0203dd4:	1008                	addi	a0,sp,32
ffffffffc0203dd6:	2bd000ef          	jal	ra,ffffffffc0204892 <memcpy>
    if (mm != NULL) {
ffffffffc0203dda:	060a0e63          	beqz	s4,ffffffffc0203e56 <do_execve+0xd8>
        cputs("mm != NULL");
ffffffffc0203dde:	00002517          	auipc	a0,0x2
ffffffffc0203de2:	91250513          	addi	a0,a0,-1774 # ffffffffc02056f0 <commands+0x7a0>
ffffffffc0203de6:	b1afc0ef          	jal	ra,ffffffffc0200100 <cputs>
ffffffffc0203dea:	00050797          	auipc	a5,0x50
ffffffffc0203dee:	a3e7b783          	ld	a5,-1474(a5) # ffffffffc0253828 <boot_cr3>
ffffffffc0203df2:	577d                	li	a4,-1
ffffffffc0203df4:	177e                	slli	a4,a4,0x3f
ffffffffc0203df6:	83b1                	srli	a5,a5,0xc
ffffffffc0203df8:	8fd9                	or	a5,a5,a4
ffffffffc0203dfa:	18079073          	csrw	satp,a5
ffffffffc0203dfe:	030a2783          	lw	a5,48(s4) # ffffffff80000030 <_binary_obj___user_ex2_out_size+0xffffffff7fff52c0>
ffffffffc0203e02:	fff7871b          	addiw	a4,a5,-1
ffffffffc0203e06:	02ea2823          	sw	a4,48(s4)
        if (mm_count_dec(mm) == 0) {
ffffffffc0203e0a:	28070663          	beqz	a4,ffffffffc0204096 <do_execve+0x318>
        current->mm = NULL;
ffffffffc0203e0e:	000ab783          	ld	a5,0(s5)
ffffffffc0203e12:	0207b423          	sd	zero,40(a5)
    if ((mm = mm_create()) == NULL) {
ffffffffc0203e16:	f45fc0ef          	jal	ra,ffffffffc0200d5a <mm_create>
ffffffffc0203e1a:	84aa                	mv	s1,a0
ffffffffc0203e1c:	c135                	beqz	a0,ffffffffc0203e80 <do_execve+0x102>
    if (setup_pgdir(mm) != 0) {
ffffffffc0203e1e:	dd8ff0ef          	jal	ra,ffffffffc02033f6 <setup_pgdir>
ffffffffc0203e22:	e931                	bnez	a0,ffffffffc0203e76 <do_execve+0xf8>
    if (elf->e_magic != ELF_MAGIC) {
ffffffffc0203e24:	0009a703          	lw	a4,0(s3)
ffffffffc0203e28:	464c47b7          	lui	a5,0x464c4
ffffffffc0203e2c:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_obj___user_ex2_out_size+0x464b980f>
ffffffffc0203e30:	04f70a63          	beq	a4,a5,ffffffffc0203e84 <do_execve+0x106>
    put_pgdir(mm);
ffffffffc0203e34:	8526                	mv	a0,s1
ffffffffc0203e36:	d4aff0ef          	jal	ra,ffffffffc0203380 <put_pgdir>
    mm_destroy(mm);
ffffffffc0203e3a:	8526                	mv	a0,s1
ffffffffc0203e3c:	876fd0ef          	jal	ra,ffffffffc0200eb2 <mm_destroy>
        ret = -E_INVAL_ELF;
ffffffffc0203e40:	5a61                	li	s4,-8
    do_exit(ret);
ffffffffc0203e42:	8552                	mv	a0,s4
ffffffffc0203e44:	b37ff0ef          	jal	ra,ffffffffc020397a <do_exit>
    memcpy(local_name, name, len);
ffffffffc0203e48:	463d                	li	a2,15
ffffffffc0203e4a:	85ca                	mv	a1,s2
ffffffffc0203e4c:	1008                	addi	a0,sp,32
ffffffffc0203e4e:	245000ef          	jal	ra,ffffffffc0204892 <memcpy>
    if (mm != NULL) {
ffffffffc0203e52:	f80a16e3          	bnez	s4,ffffffffc0203dde <do_execve+0x60>
    if (current->mm != NULL) {
ffffffffc0203e56:	000ab783          	ld	a5,0(s5)
ffffffffc0203e5a:	779c                	ld	a5,40(a5)
ffffffffc0203e5c:	dfcd                	beqz	a5,ffffffffc0203e16 <do_execve+0x98>
        panic("load_icode: current->mm must be empty.\n");
ffffffffc0203e5e:	00002617          	auipc	a2,0x2
ffffffffc0203e62:	50a60613          	addi	a2,a2,1290 # ffffffffc0206368 <default_pmm_manager+0x3f0>
ffffffffc0203e66:	1d000593          	li	a1,464
ffffffffc0203e6a:	00002517          	auipc	a0,0x2
ffffffffc0203e6e:	31e50513          	addi	a0,a0,798 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0203e72:	b92fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    mm_destroy(mm);
ffffffffc0203e76:	8526                	mv	a0,s1
ffffffffc0203e78:	83afd0ef          	jal	ra,ffffffffc0200eb2 <mm_destroy>
    int ret = -E_NO_MEM;
ffffffffc0203e7c:	5a71                	li	s4,-4
ffffffffc0203e7e:	b7d1                	j	ffffffffc0203e42 <do_execve+0xc4>
ffffffffc0203e80:	5a71                	li	s4,-4
ffffffffc0203e82:	b7c1                	j	ffffffffc0203e42 <do_execve+0xc4>
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e84:	0389d703          	lhu	a4,56(s3)
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0203e88:	0209b903          	ld	s2,32(s3)
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e8c:	00371793          	slli	a5,a4,0x3
ffffffffc0203e90:	8f99                	sub	a5,a5,a4
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0203e92:	994e                	add	s2,s2,s3
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e94:	078e                	slli	a5,a5,0x3
ffffffffc0203e96:	97ca                	add	a5,a5,s2
ffffffffc0203e98:	ec3e                	sd	a5,24(sp)
    for (; ph < ph_end; ph ++) {
ffffffffc0203e9a:	02f97c63          	bgeu	s2,a5,ffffffffc0203ed2 <do_execve+0x154>
    return KADDR(page2pa(page));
ffffffffc0203e9e:	5bfd                	li	s7,-1
ffffffffc0203ea0:	00cbd793          	srli	a5,s7,0xc
    return page - pages + nbase;
ffffffffc0203ea4:	00050d97          	auipc	s11,0x50
ffffffffc0203ea8:	98cd8d93          	addi	s11,s11,-1652 # ffffffffc0253830 <pages>
ffffffffc0203eac:	00003d17          	auipc	s10,0x3
ffffffffc0203eb0:	34cd0d13          	addi	s10,s10,844 # ffffffffc02071f8 <nbase>
    return KADDR(page2pa(page));
ffffffffc0203eb4:	e43e                	sd	a5,8(sp)
ffffffffc0203eb6:	00050c97          	auipc	s9,0x50
ffffffffc0203eba:	82ac8c93          	addi	s9,s9,-2006 # ffffffffc02536e0 <npage>
        if (ph->p_type != ELF_PT_LOAD) {
ffffffffc0203ebe:	00092703          	lw	a4,0(s2)
ffffffffc0203ec2:	4785                	li	a5,1
ffffffffc0203ec4:	0ef70463          	beq	a4,a5,ffffffffc0203fac <do_execve+0x22e>
    for (; ph < ph_end; ph ++) {
ffffffffc0203ec8:	67e2                	ld	a5,24(sp)
ffffffffc0203eca:	03890913          	addi	s2,s2,56
ffffffffc0203ece:	fef968e3          	bltu	s2,a5,ffffffffc0203ebe <do_execve+0x140>
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0) {
ffffffffc0203ed2:	4701                	li	a4,0
ffffffffc0203ed4:	46ad                	li	a3,11
ffffffffc0203ed6:	00100637          	lui	a2,0x100
ffffffffc0203eda:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0203ede:	8526                	mv	a0,s1
ffffffffc0203ee0:	824fd0ef          	jal	ra,ffffffffc0200f04 <mm_map>
ffffffffc0203ee4:	8a2a                	mv	s4,a0
ffffffffc0203ee6:	18051e63          	bnez	a0,ffffffffc0204082 <do_execve+0x304>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-PGSIZE , PTE_USER) != NULL);
ffffffffc0203eea:	6c88                	ld	a0,24(s1)
ffffffffc0203eec:	467d                	li	a2,31
ffffffffc0203eee:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0203ef2:	92eff0ef          	jal	ra,ffffffffc0203020 <pgdir_alloc_page>
ffffffffc0203ef6:	34050863          	beqz	a0,ffffffffc0204246 <do_execve+0x4c8>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-2*PGSIZE , PTE_USER) != NULL);
ffffffffc0203efa:	6c88                	ld	a0,24(s1)
ffffffffc0203efc:	467d                	li	a2,31
ffffffffc0203efe:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0203f02:	91eff0ef          	jal	ra,ffffffffc0203020 <pgdir_alloc_page>
ffffffffc0203f06:	32050063          	beqz	a0,ffffffffc0204226 <do_execve+0x4a8>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-3*PGSIZE , PTE_USER) != NULL);
ffffffffc0203f0a:	6c88                	ld	a0,24(s1)
ffffffffc0203f0c:	467d                	li	a2,31
ffffffffc0203f0e:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc0203f12:	90eff0ef          	jal	ra,ffffffffc0203020 <pgdir_alloc_page>
ffffffffc0203f16:	2e050863          	beqz	a0,ffffffffc0204206 <do_execve+0x488>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-4*PGSIZE , PTE_USER) != NULL);
ffffffffc0203f1a:	6c88                	ld	a0,24(s1)
ffffffffc0203f1c:	467d                	li	a2,31
ffffffffc0203f1e:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc0203f22:	8feff0ef          	jal	ra,ffffffffc0203020 <pgdir_alloc_page>
ffffffffc0203f26:	2c050063          	beqz	a0,ffffffffc02041e6 <do_execve+0x468>
    mm->mm_count += 1;
ffffffffc0203f2a:	589c                	lw	a5,48(s1)
    current->mm = mm;
ffffffffc0203f2c:	000ab603          	ld	a2,0(s5)
    current->cr3 = PADDR(mm->pgdir);
ffffffffc0203f30:	6c94                	ld	a3,24(s1)
ffffffffc0203f32:	2785                	addiw	a5,a5,1
ffffffffc0203f34:	d89c                	sw	a5,48(s1)
    current->mm = mm;
ffffffffc0203f36:	f604                	sd	s1,40(a2)
    current->cr3 = PADDR(mm->pgdir);
ffffffffc0203f38:	c02007b7          	lui	a5,0xc0200
ffffffffc0203f3c:	28f6e963          	bltu	a3,a5,ffffffffc02041ce <do_execve+0x450>
ffffffffc0203f40:	00050797          	auipc	a5,0x50
ffffffffc0203f44:	8e07b783          	ld	a5,-1824(a5) # ffffffffc0253820 <va_pa_offset>
ffffffffc0203f48:	8e9d                	sub	a3,a3,a5
ffffffffc0203f4a:	577d                	li	a4,-1
ffffffffc0203f4c:	00c6d793          	srli	a5,a3,0xc
ffffffffc0203f50:	177e                	slli	a4,a4,0x3f
ffffffffc0203f52:	f654                	sd	a3,168(a2)
ffffffffc0203f54:	8fd9                	or	a5,a5,a4
ffffffffc0203f56:	18079073          	csrw	satp,a5
    struct trapframe *tf = current->tf;
ffffffffc0203f5a:	7240                	ld	s0,160(a2)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0203f5c:	4581                	li	a1,0
ffffffffc0203f5e:	12000613          	li	a2,288
ffffffffc0203f62:	8522                	mv	a0,s0
    uintptr_t sstatus = tf->status;
ffffffffc0203f64:	10043483          	ld	s1,256(s0)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0203f68:	119000ef          	jal	ra,ffffffffc0204880 <memset>
    tf->epc = elf->e_entry;
ffffffffc0203f6c:	0189b703          	ld	a4,24(s3)
    tf->gpr.sp = USTACKTOP;
ffffffffc0203f70:	4785                	li	a5,1
    set_proc_name(current, local_name);
ffffffffc0203f72:	000ab503          	ld	a0,0(s5)
    tf->status = sstatus & ~(SSTATUS_SPP | SSTATUS_SPIE);
ffffffffc0203f76:	edf4f493          	andi	s1,s1,-289
    tf->gpr.sp = USTACKTOP;
ffffffffc0203f7a:	07fe                	slli	a5,a5,0x1f
ffffffffc0203f7c:	e81c                	sd	a5,16(s0)
    tf->epc = elf->e_entry;
ffffffffc0203f7e:	10e43423          	sd	a4,264(s0)
    tf->status = sstatus & ~(SSTATUS_SPP | SSTATUS_SPIE);
ffffffffc0203f82:	10943023          	sd	s1,256(s0)
    set_proc_name(current, local_name);
ffffffffc0203f86:	100c                	addi	a1,sp,32
ffffffffc0203f88:	cf0ff0ef          	jal	ra,ffffffffc0203478 <set_proc_name>
}
ffffffffc0203f8c:	60ea                	ld	ra,152(sp)
ffffffffc0203f8e:	644a                	ld	s0,144(sp)
ffffffffc0203f90:	64aa                	ld	s1,136(sp)
ffffffffc0203f92:	690a                	ld	s2,128(sp)
ffffffffc0203f94:	79e6                	ld	s3,120(sp)
ffffffffc0203f96:	7aa6                	ld	s5,104(sp)
ffffffffc0203f98:	7b06                	ld	s6,96(sp)
ffffffffc0203f9a:	6be6                	ld	s7,88(sp)
ffffffffc0203f9c:	6c46                	ld	s8,80(sp)
ffffffffc0203f9e:	6ca6                	ld	s9,72(sp)
ffffffffc0203fa0:	6d06                	ld	s10,64(sp)
ffffffffc0203fa2:	7de2                	ld	s11,56(sp)
ffffffffc0203fa4:	8552                	mv	a0,s4
ffffffffc0203fa6:	7a46                	ld	s4,112(sp)
ffffffffc0203fa8:	610d                	addi	sp,sp,160
ffffffffc0203faa:	8082                	ret
        if (ph->p_filesz > ph->p_memsz) {
ffffffffc0203fac:	02893603          	ld	a2,40(s2)
ffffffffc0203fb0:	02093783          	ld	a5,32(s2)
ffffffffc0203fb4:	1ef66f63          	bltu	a2,a5,ffffffffc02041b2 <do_execve+0x434>
        if (ph->p_flags & ELF_PF_X) vm_flags |= VM_EXEC;
ffffffffc0203fb8:	00492783          	lw	a5,4(s2)
ffffffffc0203fbc:	0017f693          	andi	a3,a5,1
ffffffffc0203fc0:	c291                	beqz	a3,ffffffffc0203fc4 <do_execve+0x246>
ffffffffc0203fc2:	4691                	li	a3,4
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc0203fc4:	0027f713          	andi	a4,a5,2
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203fc8:	8b91                	andi	a5,a5,4
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc0203fca:	0e071063          	bnez	a4,ffffffffc02040aa <do_execve+0x32c>
        vm_flags = 0, perm = PTE_U | PTE_V;
ffffffffc0203fce:	4745                	li	a4,17
ffffffffc0203fd0:	e03a                	sd	a4,0(sp)
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203fd2:	c789                	beqz	a5,ffffffffc0203fdc <do_execve+0x25e>
        if (vm_flags & VM_READ) perm |= PTE_R;
ffffffffc0203fd4:	47cd                	li	a5,19
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203fd6:	0016e693          	ori	a3,a3,1
        if (vm_flags & VM_READ) perm |= PTE_R;
ffffffffc0203fda:	e03e                	sd	a5,0(sp)
        if (vm_flags & VM_WRITE) perm |= (PTE_W | PTE_R);
ffffffffc0203fdc:	0026f793          	andi	a5,a3,2
ffffffffc0203fe0:	ebe1                	bnez	a5,ffffffffc02040b0 <do_execve+0x332>
        if (vm_flags & VM_EXEC) perm |= PTE_X;
ffffffffc0203fe2:	0046f793          	andi	a5,a3,4
ffffffffc0203fe6:	c789                	beqz	a5,ffffffffc0203ff0 <do_execve+0x272>
ffffffffc0203fe8:	6782                	ld	a5,0(sp)
ffffffffc0203fea:	0087e793          	ori	a5,a5,8
ffffffffc0203fee:	e03e                	sd	a5,0(sp)
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0) {
ffffffffc0203ff0:	01093583          	ld	a1,16(s2)
ffffffffc0203ff4:	4701                	li	a4,0
ffffffffc0203ff6:	8526                	mv	a0,s1
ffffffffc0203ff8:	f0dfc0ef          	jal	ra,ffffffffc0200f04 <mm_map>
ffffffffc0203ffc:	8a2a                	mv	s4,a0
ffffffffc0203ffe:	e151                	bnez	a0,ffffffffc0204082 <do_execve+0x304>
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204000:	01093c03          	ld	s8,16(s2)
        end = ph->p_va + ph->p_filesz;
ffffffffc0204004:	02093a03          	ld	s4,32(s2)
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204008:	00893b03          	ld	s6,8(s2)
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc020400c:	77fd                	lui	a5,0xfffff
        end = ph->p_va + ph->p_filesz;
ffffffffc020400e:	9a62                	add	s4,s4,s8
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204010:	9b4e                	add	s6,s6,s3
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204012:	00fc7bb3          	and	s7,s8,a5
        while (start < end) {
ffffffffc0204016:	054c6e63          	bltu	s8,s4,ffffffffc0204072 <do_execve+0x2f4>
ffffffffc020401a:	aa51                	j	ffffffffc02041ae <do_execve+0x430>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc020401c:	6785                	lui	a5,0x1
ffffffffc020401e:	417c0533          	sub	a0,s8,s7
ffffffffc0204022:	9bbe                	add	s7,s7,a5
ffffffffc0204024:	418b8633          	sub	a2,s7,s8
            if (end < la) {
ffffffffc0204028:	017a7463          	bgeu	s4,s7,ffffffffc0204030 <do_execve+0x2b2>
                size -= la - end;
ffffffffc020402c:	418a0633          	sub	a2,s4,s8
    return page - pages + nbase;
ffffffffc0204030:	000db683          	ld	a3,0(s11)
ffffffffc0204034:	000d3803          	ld	a6,0(s10)
    return KADDR(page2pa(page));
ffffffffc0204038:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc020403a:	40d406b3          	sub	a3,s0,a3
ffffffffc020403e:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0204040:	000cb583          	ld	a1,0(s9)
    return page - pages + nbase;
ffffffffc0204044:	96c2                	add	a3,a3,a6
    return KADDR(page2pa(page));
ffffffffc0204046:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc020404a:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020404c:	16b87563          	bgeu	a6,a1,ffffffffc02041b6 <do_execve+0x438>
ffffffffc0204050:	0004f797          	auipc	a5,0x4f
ffffffffc0204054:	7d078793          	addi	a5,a5,2000 # ffffffffc0253820 <va_pa_offset>
ffffffffc0204058:	0007b803          	ld	a6,0(a5)
            memcpy(page2kva(page) + off, from, size);
ffffffffc020405c:	85da                	mv	a1,s6
            start += size, from += size;
ffffffffc020405e:	9c32                	add	s8,s8,a2
ffffffffc0204060:	96c2                	add	a3,a3,a6
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204062:	9536                	add	a0,a0,a3
            start += size, from += size;
ffffffffc0204064:	e832                	sd	a2,16(sp)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204066:	02d000ef          	jal	ra,ffffffffc0204892 <memcpy>
            start += size, from += size;
ffffffffc020406a:	6642                	ld	a2,16(sp)
ffffffffc020406c:	9b32                	add	s6,s6,a2
        while (start < end) {
ffffffffc020406e:	054c7463          	bgeu	s8,s4,ffffffffc02040b6 <do_execve+0x338>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL) {
ffffffffc0204072:	6c88                	ld	a0,24(s1)
ffffffffc0204074:	6602                	ld	a2,0(sp)
ffffffffc0204076:	85de                	mv	a1,s7
ffffffffc0204078:	fa9fe0ef          	jal	ra,ffffffffc0203020 <pgdir_alloc_page>
ffffffffc020407c:	842a                	mv	s0,a0
ffffffffc020407e:	fd59                	bnez	a0,ffffffffc020401c <do_execve+0x29e>
        ret = -E_NO_MEM;
ffffffffc0204080:	5a71                	li	s4,-4
    exit_mmap(mm);
ffffffffc0204082:	8526                	mv	a0,s1
ffffffffc0204084:	fcbfc0ef          	jal	ra,ffffffffc020104e <exit_mmap>
    put_pgdir(mm);
ffffffffc0204088:	8526                	mv	a0,s1
ffffffffc020408a:	af6ff0ef          	jal	ra,ffffffffc0203380 <put_pgdir>
    mm_destroy(mm);
ffffffffc020408e:	8526                	mv	a0,s1
ffffffffc0204090:	e23fc0ef          	jal	ra,ffffffffc0200eb2 <mm_destroy>
    return ret;
ffffffffc0204094:	b37d                	j	ffffffffc0203e42 <do_execve+0xc4>
            exit_mmap(mm);
ffffffffc0204096:	8552                	mv	a0,s4
ffffffffc0204098:	fb7fc0ef          	jal	ra,ffffffffc020104e <exit_mmap>
            put_pgdir(mm);
ffffffffc020409c:	8552                	mv	a0,s4
ffffffffc020409e:	ae2ff0ef          	jal	ra,ffffffffc0203380 <put_pgdir>
            mm_destroy(mm);
ffffffffc02040a2:	8552                	mv	a0,s4
ffffffffc02040a4:	e0ffc0ef          	jal	ra,ffffffffc0200eb2 <mm_destroy>
ffffffffc02040a8:	b39d                	j	ffffffffc0203e0e <do_execve+0x90>
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc02040aa:	0026e693          	ori	a3,a3,2
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc02040ae:	f39d                	bnez	a5,ffffffffc0203fd4 <do_execve+0x256>
        if (vm_flags & VM_WRITE) perm |= (PTE_W | PTE_R);
ffffffffc02040b0:	47dd                	li	a5,23
ffffffffc02040b2:	e03e                	sd	a5,0(sp)
ffffffffc02040b4:	b73d                	j	ffffffffc0203fe2 <do_execve+0x264>
ffffffffc02040b6:	01093a03          	ld	s4,16(s2)
        end = ph->p_va + ph->p_memsz;
ffffffffc02040ba:	02893683          	ld	a3,40(s2)
ffffffffc02040be:	9a36                	add	s4,s4,a3
        if (start < la) {
ffffffffc02040c0:	077c7f63          	bgeu	s8,s7,ffffffffc020413e <do_execve+0x3c0>
            if (start == end) {
ffffffffc02040c4:	e18a02e3          	beq	s4,s8,ffffffffc0203ec8 <do_execve+0x14a>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc02040c8:	6505                	lui	a0,0x1
ffffffffc02040ca:	9562                	add	a0,a0,s8
ffffffffc02040cc:	41750533          	sub	a0,a0,s7
                size -= la - end;
ffffffffc02040d0:	418a0b33          	sub	s6,s4,s8
            if (end < la) {
ffffffffc02040d4:	0d7a7863          	bgeu	s4,s7,ffffffffc02041a4 <do_execve+0x426>
    return page - pages + nbase;
ffffffffc02040d8:	000db683          	ld	a3,0(s11)
ffffffffc02040dc:	000d3583          	ld	a1,0(s10)
    return KADDR(page2pa(page));
ffffffffc02040e0:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc02040e2:	40d406b3          	sub	a3,s0,a3
ffffffffc02040e6:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02040e8:	000cb603          	ld	a2,0(s9)
    return page - pages + nbase;
ffffffffc02040ec:	96ae                	add	a3,a3,a1
    return KADDR(page2pa(page));
ffffffffc02040ee:	00f6f5b3          	and	a1,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc02040f2:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02040f4:	0cc5f163          	bgeu	a1,a2,ffffffffc02041b6 <do_execve+0x438>
ffffffffc02040f8:	0004f617          	auipc	a2,0x4f
ffffffffc02040fc:	72863603          	ld	a2,1832(a2) # ffffffffc0253820 <va_pa_offset>
ffffffffc0204100:	96b2                	add	a3,a3,a2
            memset(page2kva(page) + off, 0, size);
ffffffffc0204102:	4581                	li	a1,0
ffffffffc0204104:	865a                	mv	a2,s6
ffffffffc0204106:	9536                	add	a0,a0,a3
ffffffffc0204108:	778000ef          	jal	ra,ffffffffc0204880 <memset>
            start += size;
ffffffffc020410c:	018b0733          	add	a4,s6,s8
            assert((end < la && start == end) || (end >= la && start == la));
ffffffffc0204110:	037a7463          	bgeu	s4,s7,ffffffffc0204138 <do_execve+0x3ba>
ffffffffc0204114:	daea0ae3          	beq	s4,a4,ffffffffc0203ec8 <do_execve+0x14a>
ffffffffc0204118:	00002697          	auipc	a3,0x2
ffffffffc020411c:	27868693          	addi	a3,a3,632 # ffffffffc0206390 <default_pmm_manager+0x418>
ffffffffc0204120:	00001617          	auipc	a2,0x1
ffffffffc0204124:	23860613          	addi	a2,a2,568 # ffffffffc0205358 <commands+0x408>
ffffffffc0204128:	22500593          	li	a1,549
ffffffffc020412c:	00002517          	auipc	a0,0x2
ffffffffc0204130:	05c50513          	addi	a0,a0,92 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0204134:	8d0fc0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc0204138:	ff7710e3          	bne	a4,s7,ffffffffc0204118 <do_execve+0x39a>
ffffffffc020413c:	8c5e                	mv	s8,s7
ffffffffc020413e:	0004fb17          	auipc	s6,0x4f
ffffffffc0204142:	6e2b0b13          	addi	s6,s6,1762 # ffffffffc0253820 <va_pa_offset>
        while (start < end) {
ffffffffc0204146:	054c6763          	bltu	s8,s4,ffffffffc0204194 <do_execve+0x416>
ffffffffc020414a:	bbbd                	j	ffffffffc0203ec8 <do_execve+0x14a>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc020414c:	6785                	lui	a5,0x1
ffffffffc020414e:	417c0533          	sub	a0,s8,s7
ffffffffc0204152:	9bbe                	add	s7,s7,a5
ffffffffc0204154:	418b8633          	sub	a2,s7,s8
            if (end < la) {
ffffffffc0204158:	017a7463          	bgeu	s4,s7,ffffffffc0204160 <do_execve+0x3e2>
                size -= la - end;
ffffffffc020415c:	418a0633          	sub	a2,s4,s8
    return page - pages + nbase;
ffffffffc0204160:	000db683          	ld	a3,0(s11)
ffffffffc0204164:	000d3803          	ld	a6,0(s10)
    return KADDR(page2pa(page));
ffffffffc0204168:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc020416a:	40d406b3          	sub	a3,s0,a3
ffffffffc020416e:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0204170:	000cb583          	ld	a1,0(s9)
    return page - pages + nbase;
ffffffffc0204174:	96c2                	add	a3,a3,a6
    return KADDR(page2pa(page));
ffffffffc0204176:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc020417a:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020417c:	02b87d63          	bgeu	a6,a1,ffffffffc02041b6 <do_execve+0x438>
ffffffffc0204180:	000b3803          	ld	a6,0(s6)
            start += size;
ffffffffc0204184:	9c32                	add	s8,s8,a2
            memset(page2kva(page) + off, 0, size);
ffffffffc0204186:	4581                	li	a1,0
ffffffffc0204188:	96c2                	add	a3,a3,a6
ffffffffc020418a:	9536                	add	a0,a0,a3
ffffffffc020418c:	6f4000ef          	jal	ra,ffffffffc0204880 <memset>
        while (start < end) {
ffffffffc0204190:	d34c7ce3          	bgeu	s8,s4,ffffffffc0203ec8 <do_execve+0x14a>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL) {
ffffffffc0204194:	6c88                	ld	a0,24(s1)
ffffffffc0204196:	6602                	ld	a2,0(sp)
ffffffffc0204198:	85de                	mv	a1,s7
ffffffffc020419a:	e87fe0ef          	jal	ra,ffffffffc0203020 <pgdir_alloc_page>
ffffffffc020419e:	842a                	mv	s0,a0
ffffffffc02041a0:	f555                	bnez	a0,ffffffffc020414c <do_execve+0x3ce>
ffffffffc02041a2:	bdf9                	j	ffffffffc0204080 <do_execve+0x302>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc02041a4:	418b8b33          	sub	s6,s7,s8
ffffffffc02041a8:	bf05                	j	ffffffffc02040d8 <do_execve+0x35a>
        return -E_INVAL;
ffffffffc02041aa:	5a75                	li	s4,-3
ffffffffc02041ac:	b3c5                	j	ffffffffc0203f8c <do_execve+0x20e>
        while (start < end) {
ffffffffc02041ae:	8a62                	mv	s4,s8
ffffffffc02041b0:	b729                	j	ffffffffc02040ba <do_execve+0x33c>
            ret = -E_INVAL_ELF;
ffffffffc02041b2:	5a61                	li	s4,-8
ffffffffc02041b4:	b5f9                	j	ffffffffc0204082 <do_execve+0x304>
ffffffffc02041b6:	00002617          	auipc	a2,0x2
ffffffffc02041ba:	82a60613          	addi	a2,a2,-2006 # ffffffffc02059e0 <commands+0xa90>
ffffffffc02041be:	06900593          	li	a1,105
ffffffffc02041c2:	00002517          	auipc	a0,0x2
ffffffffc02041c6:	84650513          	addi	a0,a0,-1978 # ffffffffc0205a08 <commands+0xab8>
ffffffffc02041ca:	83afc0ef          	jal	ra,ffffffffc0200204 <__panic>
    current->cr3 = PADDR(mm->pgdir);
ffffffffc02041ce:	00002617          	auipc	a2,0x2
ffffffffc02041d2:	88260613          	addi	a2,a2,-1918 # ffffffffc0205a50 <commands+0xb00>
ffffffffc02041d6:	24000593          	li	a1,576
ffffffffc02041da:	00002517          	auipc	a0,0x2
ffffffffc02041de:	fae50513          	addi	a0,a0,-82 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc02041e2:	822fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-4*PGSIZE , PTE_USER) != NULL);
ffffffffc02041e6:	00002697          	auipc	a3,0x2
ffffffffc02041ea:	2c268693          	addi	a3,a3,706 # ffffffffc02064a8 <default_pmm_manager+0x530>
ffffffffc02041ee:	00001617          	auipc	a2,0x1
ffffffffc02041f2:	16a60613          	addi	a2,a2,362 # ffffffffc0205358 <commands+0x408>
ffffffffc02041f6:	23b00593          	li	a1,571
ffffffffc02041fa:	00002517          	auipc	a0,0x2
ffffffffc02041fe:	f8e50513          	addi	a0,a0,-114 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0204202:	802fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-3*PGSIZE , PTE_USER) != NULL);
ffffffffc0204206:	00002697          	auipc	a3,0x2
ffffffffc020420a:	25a68693          	addi	a3,a3,602 # ffffffffc0206460 <default_pmm_manager+0x4e8>
ffffffffc020420e:	00001617          	auipc	a2,0x1
ffffffffc0204212:	14a60613          	addi	a2,a2,330 # ffffffffc0205358 <commands+0x408>
ffffffffc0204216:	23a00593          	li	a1,570
ffffffffc020421a:	00002517          	auipc	a0,0x2
ffffffffc020421e:	f6e50513          	addi	a0,a0,-146 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0204222:	fe3fb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-2*PGSIZE , PTE_USER) != NULL);
ffffffffc0204226:	00002697          	auipc	a3,0x2
ffffffffc020422a:	1f268693          	addi	a3,a3,498 # ffffffffc0206418 <default_pmm_manager+0x4a0>
ffffffffc020422e:	00001617          	auipc	a2,0x1
ffffffffc0204232:	12a60613          	addi	a2,a2,298 # ffffffffc0205358 <commands+0x408>
ffffffffc0204236:	23900593          	li	a1,569
ffffffffc020423a:	00002517          	auipc	a0,0x2
ffffffffc020423e:	f4e50513          	addi	a0,a0,-178 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0204242:	fc3fb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-PGSIZE , PTE_USER) != NULL);
ffffffffc0204246:	00002697          	auipc	a3,0x2
ffffffffc020424a:	18a68693          	addi	a3,a3,394 # ffffffffc02063d0 <default_pmm_manager+0x458>
ffffffffc020424e:	00001617          	auipc	a2,0x1
ffffffffc0204252:	10a60613          	addi	a2,a2,266 # ffffffffc0205358 <commands+0x408>
ffffffffc0204256:	23800593          	li	a1,568
ffffffffc020425a:	00002517          	auipc	a0,0x2
ffffffffc020425e:	f2e50513          	addi	a0,a0,-210 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0204262:	fa3fb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0204266 <do_yield>:
    current->need_resched = 1;
ffffffffc0204266:	0004f797          	auipc	a5,0x4f
ffffffffc020426a:	4827b783          	ld	a5,1154(a5) # ffffffffc02536e8 <current>
ffffffffc020426e:	4705                	li	a4,1
ffffffffc0204270:	ef98                	sd	a4,24(a5)
}
ffffffffc0204272:	4501                	li	a0,0
ffffffffc0204274:	8082                	ret

ffffffffc0204276 <do_wait>:
do_wait(int pid, int *code_store) {
ffffffffc0204276:	1101                	addi	sp,sp,-32
ffffffffc0204278:	e822                	sd	s0,16(sp)
ffffffffc020427a:	e426                	sd	s1,8(sp)
ffffffffc020427c:	ec06                	sd	ra,24(sp)
ffffffffc020427e:	842e                	mv	s0,a1
ffffffffc0204280:	84aa                	mv	s1,a0
    if (code_store != NULL) {
ffffffffc0204282:	c999                	beqz	a1,ffffffffc0204298 <do_wait+0x22>
    struct mm_struct *mm = current->mm;
ffffffffc0204284:	0004f797          	auipc	a5,0x4f
ffffffffc0204288:	4647b783          	ld	a5,1124(a5) # ffffffffc02536e8 <current>
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1)) {
ffffffffc020428c:	7788                	ld	a0,40(a5)
ffffffffc020428e:	4685                	li	a3,1
ffffffffc0204290:	4611                	li	a2,4
ffffffffc0204292:	f37fc0ef          	jal	ra,ffffffffc02011c8 <user_mem_check>
ffffffffc0204296:	c909                	beqz	a0,ffffffffc02042a8 <do_wait+0x32>
ffffffffc0204298:	85a2                	mv	a1,s0
}
ffffffffc020429a:	6442                	ld	s0,16(sp)
ffffffffc020429c:	60e2                	ld	ra,24(sp)
ffffffffc020429e:	8526                	mv	a0,s1
ffffffffc02042a0:	64a2                	ld	s1,8(sp)
ffffffffc02042a2:	6105                	addi	sp,sp,32
ffffffffc02042a4:	821ff06f          	j	ffffffffc0203ac4 <do_wait.part.0>
ffffffffc02042a8:	60e2                	ld	ra,24(sp)
ffffffffc02042aa:	6442                	ld	s0,16(sp)
ffffffffc02042ac:	64a2                	ld	s1,8(sp)
ffffffffc02042ae:	5575                	li	a0,-3
ffffffffc02042b0:	6105                	addi	sp,sp,32
ffffffffc02042b2:	8082                	ret

ffffffffc02042b4 <do_kill>:
do_kill(int pid) {
ffffffffc02042b4:	1141                	addi	sp,sp,-16
ffffffffc02042b6:	e406                	sd	ra,8(sp)
ffffffffc02042b8:	e022                	sd	s0,0(sp)
    if ((proc = find_proc(pid)) != NULL) {
ffffffffc02042ba:	a54ff0ef          	jal	ra,ffffffffc020350e <find_proc>
ffffffffc02042be:	cd0d                	beqz	a0,ffffffffc02042f8 <do_kill+0x44>
        if (!(proc->flags & PF_EXITING)) {
ffffffffc02042c0:	0b052703          	lw	a4,176(a0)
ffffffffc02042c4:	00177693          	andi	a3,a4,1
ffffffffc02042c8:	e695                	bnez	a3,ffffffffc02042f4 <do_kill+0x40>
            if (proc->wait_state & WT_INTERRUPTED) {
ffffffffc02042ca:	0ec52683          	lw	a3,236(a0)
            proc->flags |= PF_EXITING;
ffffffffc02042ce:	00176713          	ori	a4,a4,1
ffffffffc02042d2:	0ae52823          	sw	a4,176(a0)
            return 0;
ffffffffc02042d6:	4401                	li	s0,0
            if (proc->wait_state & WT_INTERRUPTED) {
ffffffffc02042d8:	0006c763          	bltz	a3,ffffffffc02042e6 <do_kill+0x32>
}
ffffffffc02042dc:	60a2                	ld	ra,8(sp)
ffffffffc02042de:	8522                	mv	a0,s0
ffffffffc02042e0:	6402                	ld	s0,0(sp)
ffffffffc02042e2:	0141                	addi	sp,sp,16
ffffffffc02042e4:	8082                	ret
                wakeup_proc(proc);
ffffffffc02042e6:	1e2000ef          	jal	ra,ffffffffc02044c8 <wakeup_proc>
}
ffffffffc02042ea:	60a2                	ld	ra,8(sp)
ffffffffc02042ec:	8522                	mv	a0,s0
ffffffffc02042ee:	6402                	ld	s0,0(sp)
ffffffffc02042f0:	0141                	addi	sp,sp,16
ffffffffc02042f2:	8082                	ret
        return -E_KILLED;
ffffffffc02042f4:	545d                	li	s0,-9
ffffffffc02042f6:	b7dd                	j	ffffffffc02042dc <do_kill+0x28>
    return -E_INVAL;
ffffffffc02042f8:	5475                	li	s0,-3
ffffffffc02042fa:	b7cd                	j	ffffffffc02042dc <do_kill+0x28>

ffffffffc02042fc <proc_init>:

// proc_init - set up the first kernel thread idleproc "idle" by itself and 
//           - create the second kernel thread init_main
void
proc_init(void) {
ffffffffc02042fc:	1101                	addi	sp,sp,-32
    elm->prev = elm->next = elm;
ffffffffc02042fe:	0004f797          	auipc	a5,0x4f
ffffffffc0204302:	53a78793          	addi	a5,a5,1338 # ffffffffc0253838 <proc_list>
ffffffffc0204306:	ec06                	sd	ra,24(sp)
ffffffffc0204308:	e822                	sd	s0,16(sp)
ffffffffc020430a:	e426                	sd	s1,8(sp)
ffffffffc020430c:	e04a                	sd	s2,0(sp)
ffffffffc020430e:	e79c                	sd	a5,8(a5)
ffffffffc0204310:	e39c                	sd	a5,0(a5)
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i ++) {
ffffffffc0204312:	0004f717          	auipc	a4,0x4f
ffffffffc0204316:	36e70713          	addi	a4,a4,878 # ffffffffc0253680 <__rq>
ffffffffc020431a:	0004b797          	auipc	a5,0x4b
ffffffffc020431e:	36678793          	addi	a5,a5,870 # ffffffffc024f680 <hash_list>
ffffffffc0204322:	e79c                	sd	a5,8(a5)
ffffffffc0204324:	e39c                	sd	a5,0(a5)
ffffffffc0204326:	07c1                	addi	a5,a5,16
ffffffffc0204328:	fef71de3          	bne	a4,a5,ffffffffc0204322 <proc_init+0x26>
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL) {
ffffffffc020432c:	f49fe0ef          	jal	ra,ffffffffc0203274 <alloc_proc>
ffffffffc0204330:	0004f417          	auipc	s0,0x4f
ffffffffc0204334:	3c040413          	addi	s0,s0,960 # ffffffffc02536f0 <idleproc>
ffffffffc0204338:	e008                	sd	a0,0(s0)
ffffffffc020433a:	c541                	beqz	a0,ffffffffc02043c2 <proc_init+0xc6>
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
ffffffffc020433c:	4709                	li	a4,2
ffffffffc020433e:	e118                	sd	a4,0(a0)
    idleproc->kstack = (uintptr_t)bootstack;
    idleproc->need_resched = 1;
ffffffffc0204340:	4485                	li	s1,1
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204342:	00004717          	auipc	a4,0x4
ffffffffc0204346:	cbe70713          	addi	a4,a4,-834 # ffffffffc0208000 <bootstack>
    set_proc_name(idleproc, "idle");
ffffffffc020434a:	00002597          	auipc	a1,0x2
ffffffffc020434e:	1be58593          	addi	a1,a1,446 # ffffffffc0206508 <default_pmm_manager+0x590>
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204352:	e918                	sd	a4,16(a0)
    idleproc->need_resched = 1;
ffffffffc0204354:	ed04                	sd	s1,24(a0)
    set_proc_name(idleproc, "idle");
ffffffffc0204356:	922ff0ef          	jal	ra,ffffffffc0203478 <set_proc_name>
    nr_process ++;
ffffffffc020435a:	0004f717          	auipc	a4,0x4f
ffffffffc020435e:	3a670713          	addi	a4,a4,934 # ffffffffc0253700 <nr_process>
ffffffffc0204362:	431c                	lw	a5,0(a4)

    current = idleproc;
ffffffffc0204364:	6014                	ld	a3,0(s0)

    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204366:	4601                	li	a2,0
    nr_process ++;
ffffffffc0204368:	2785                	addiw	a5,a5,1
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc020436a:	4581                	li	a1,0
ffffffffc020436c:	00000517          	auipc	a0,0x0
ffffffffc0204370:	8ee50513          	addi	a0,a0,-1810 # ffffffffc0203c5a <init_main>
    nr_process ++;
ffffffffc0204374:	c31c                	sw	a5,0(a4)
    current = idleproc;
ffffffffc0204376:	0004f797          	auipc	a5,0x4f
ffffffffc020437a:	36d7b923          	sd	a3,882(a5) # ffffffffc02536e8 <current>
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc020437e:	dacff0ef          	jal	ra,ffffffffc020392a <kernel_thread>
    if (pid <= 0) {
ffffffffc0204382:	08a05c63          	blez	a0,ffffffffc020441a <proc_init+0x11e>
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
ffffffffc0204386:	988ff0ef          	jal	ra,ffffffffc020350e <find_proc>
ffffffffc020438a:	0004f917          	auipc	s2,0x4f
ffffffffc020438e:	36e90913          	addi	s2,s2,878 # ffffffffc02536f8 <initproc>
    set_proc_name(initproc, "init");
ffffffffc0204392:	00002597          	auipc	a1,0x2
ffffffffc0204396:	19e58593          	addi	a1,a1,414 # ffffffffc0206530 <default_pmm_manager+0x5b8>
    initproc = find_proc(pid);
ffffffffc020439a:	00a93023          	sd	a0,0(s2)
    set_proc_name(initproc, "init");
ffffffffc020439e:	8daff0ef          	jal	ra,ffffffffc0203478 <set_proc_name>

    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc02043a2:	601c                	ld	a5,0(s0)
ffffffffc02043a4:	cbb9                	beqz	a5,ffffffffc02043fa <proc_init+0xfe>
ffffffffc02043a6:	43dc                	lw	a5,4(a5)
ffffffffc02043a8:	eba9                	bnez	a5,ffffffffc02043fa <proc_init+0xfe>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc02043aa:	00093783          	ld	a5,0(s2)
ffffffffc02043ae:	c795                	beqz	a5,ffffffffc02043da <proc_init+0xde>
ffffffffc02043b0:	43dc                	lw	a5,4(a5)
ffffffffc02043b2:	02979463          	bne	a5,s1,ffffffffc02043da <proc_init+0xde>
}
ffffffffc02043b6:	60e2                	ld	ra,24(sp)
ffffffffc02043b8:	6442                	ld	s0,16(sp)
ffffffffc02043ba:	64a2                	ld	s1,8(sp)
ffffffffc02043bc:	6902                	ld	s2,0(sp)
ffffffffc02043be:	6105                	addi	sp,sp,32
ffffffffc02043c0:	8082                	ret
        panic("cannot alloc idleproc.\n");
ffffffffc02043c2:	00002617          	auipc	a2,0x2
ffffffffc02043c6:	12e60613          	addi	a2,a2,302 # ffffffffc02064f0 <default_pmm_manager+0x578>
ffffffffc02043ca:	32f00593          	li	a1,815
ffffffffc02043ce:	00002517          	auipc	a0,0x2
ffffffffc02043d2:	dba50513          	addi	a0,a0,-582 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc02043d6:	e2ffb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc02043da:	00002697          	auipc	a3,0x2
ffffffffc02043de:	18668693          	addi	a3,a3,390 # ffffffffc0206560 <default_pmm_manager+0x5e8>
ffffffffc02043e2:	00001617          	auipc	a2,0x1
ffffffffc02043e6:	f7660613          	addi	a2,a2,-138 # ffffffffc0205358 <commands+0x408>
ffffffffc02043ea:	34400593          	li	a1,836
ffffffffc02043ee:	00002517          	auipc	a0,0x2
ffffffffc02043f2:	d9a50513          	addi	a0,a0,-614 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc02043f6:	e0ffb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc02043fa:	00002697          	auipc	a3,0x2
ffffffffc02043fe:	13e68693          	addi	a3,a3,318 # ffffffffc0206538 <default_pmm_manager+0x5c0>
ffffffffc0204402:	00001617          	auipc	a2,0x1
ffffffffc0204406:	f5660613          	addi	a2,a2,-170 # ffffffffc0205358 <commands+0x408>
ffffffffc020440a:	34300593          	li	a1,835
ffffffffc020440e:	00002517          	auipc	a0,0x2
ffffffffc0204412:	d7a50513          	addi	a0,a0,-646 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc0204416:	deffb0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("create init_main failed.\n");
ffffffffc020441a:	00002617          	auipc	a2,0x2
ffffffffc020441e:	0f660613          	addi	a2,a2,246 # ffffffffc0206510 <default_pmm_manager+0x598>
ffffffffc0204422:	33d00593          	li	a1,829
ffffffffc0204426:	00002517          	auipc	a0,0x2
ffffffffc020442a:	d6250513          	addi	a0,a0,-670 # ffffffffc0206188 <default_pmm_manager+0x210>
ffffffffc020442e:	dd7fb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0204432 <cpu_idle>:

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void
cpu_idle(void) {
ffffffffc0204432:	1141                	addi	sp,sp,-16
ffffffffc0204434:	e022                	sd	s0,0(sp)
ffffffffc0204436:	e406                	sd	ra,8(sp)
ffffffffc0204438:	0004f417          	auipc	s0,0x4f
ffffffffc020443c:	2b040413          	addi	s0,s0,688 # ffffffffc02536e8 <current>
    while (1) {
        if (current->need_resched) {
ffffffffc0204440:	6018                	ld	a4,0(s0)
ffffffffc0204442:	6f1c                	ld	a5,24(a4)
ffffffffc0204444:	dffd                	beqz	a5,ffffffffc0204442 <cpu_idle+0x10>
            schedule();
ffffffffc0204446:	134000ef          	jal	ra,ffffffffc020457a <schedule>
ffffffffc020444a:	bfdd                	j	ffffffffc0204440 <cpu_idle+0xe>

ffffffffc020444c <sched_class_proc_tick>:
    return sched_class->pick_next(rq);
}

void
sched_class_proc_tick(struct proc_struct *proc) {
    if (proc != idleproc) {
ffffffffc020444c:	0004f797          	auipc	a5,0x4f
ffffffffc0204450:	2a47b783          	ld	a5,676(a5) # ffffffffc02536f0 <idleproc>
sched_class_proc_tick(struct proc_struct *proc) {
ffffffffc0204454:	85aa                	mv	a1,a0
    if (proc != idleproc) {
ffffffffc0204456:	00a78d63          	beq	a5,a0,ffffffffc0204470 <sched_class_proc_tick+0x24>
        sched_class->proc_tick(rq, proc);
ffffffffc020445a:	0004f797          	auipc	a5,0x4f
ffffffffc020445e:	2b67b783          	ld	a5,694(a5) # ffffffffc0253710 <sched_class>
ffffffffc0204462:	0287b303          	ld	t1,40(a5)
ffffffffc0204466:	0004f517          	auipc	a0,0x4f
ffffffffc020446a:	2a253503          	ld	a0,674(a0) # ffffffffc0253708 <rq>
ffffffffc020446e:	8302                	jr	t1
    }
    else {
        proc->need_resched = 1;
ffffffffc0204470:	4705                	li	a4,1
ffffffffc0204472:	ef98                	sd	a4,24(a5)
    }
}
ffffffffc0204474:	8082                	ret

ffffffffc0204476 <sched_init>:

static struct run_queue __rq;

void
sched_init(void) {
ffffffffc0204476:	1141                	addi	sp,sp,-16
    list_init(&timer_list);

    sched_class = &default_sched_class;
ffffffffc0204478:	00044717          	auipc	a4,0x44
ffffffffc020447c:	dc870713          	addi	a4,a4,-568 # ffffffffc0248240 <default_sched_class>
sched_init(void) {
ffffffffc0204480:	e022                	sd	s0,0(sp)
ffffffffc0204482:	e406                	sd	ra,8(sp)
ffffffffc0204484:	0004f797          	auipc	a5,0x4f
ffffffffc0204488:	21c78793          	addi	a5,a5,540 # ffffffffc02536a0 <timer_list>
    //sched_class = &stride_sched_class;

    rq = &__rq;
    rq->max_time_slice = MAX_TIME_SLICE;
    sched_class->init(rq);
ffffffffc020448c:	6714                	ld	a3,8(a4)
    rq = &__rq;
ffffffffc020448e:	0004f517          	auipc	a0,0x4f
ffffffffc0204492:	1f250513          	addi	a0,a0,498 # ffffffffc0253680 <__rq>
ffffffffc0204496:	e79c                	sd	a5,8(a5)
ffffffffc0204498:	e39c                	sd	a5,0(a5)
    rq->max_time_slice = MAX_TIME_SLICE;
ffffffffc020449a:	4795                	li	a5,5
ffffffffc020449c:	c95c                	sw	a5,20(a0)
    sched_class = &default_sched_class;
ffffffffc020449e:	0004f417          	auipc	s0,0x4f
ffffffffc02044a2:	27240413          	addi	s0,s0,626 # ffffffffc0253710 <sched_class>
    rq = &__rq;
ffffffffc02044a6:	0004f797          	auipc	a5,0x4f
ffffffffc02044aa:	26a7b123          	sd	a0,610(a5) # ffffffffc0253708 <rq>
    sched_class = &default_sched_class;
ffffffffc02044ae:	e018                	sd	a4,0(s0)
    sched_class->init(rq);
ffffffffc02044b0:	9682                	jalr	a3

    cprintf("sched class: %s\n", sched_class->name);
ffffffffc02044b2:	601c                	ld	a5,0(s0)
}
ffffffffc02044b4:	6402                	ld	s0,0(sp)
ffffffffc02044b6:	60a2                	ld	ra,8(sp)
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc02044b8:	638c                	ld	a1,0(a5)
ffffffffc02044ba:	00002517          	auipc	a0,0x2
ffffffffc02044be:	0ce50513          	addi	a0,a0,206 # ffffffffc0206588 <default_pmm_manager+0x610>
}
ffffffffc02044c2:	0141                	addi	sp,sp,16
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc02044c4:	c05fb06f          	j	ffffffffc02000c8 <cprintf>

ffffffffc02044c8 <wakeup_proc>:

void
wakeup_proc(struct proc_struct *proc) {
    assert(proc->state != PROC_ZOMBIE);
ffffffffc02044c8:	4118                	lw	a4,0(a0)
wakeup_proc(struct proc_struct *proc) {
ffffffffc02044ca:	1101                	addi	sp,sp,-32
ffffffffc02044cc:	ec06                	sd	ra,24(sp)
ffffffffc02044ce:	e822                	sd	s0,16(sp)
ffffffffc02044d0:	e426                	sd	s1,8(sp)
    assert(proc->state != PROC_ZOMBIE);
ffffffffc02044d2:	478d                	li	a5,3
ffffffffc02044d4:	08f70363          	beq	a4,a5,ffffffffc020455a <wakeup_proc+0x92>
ffffffffc02044d8:	842a                	mv	s0,a0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02044da:	100027f3          	csrr	a5,sstatus
ffffffffc02044de:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02044e0:	4481                	li	s1,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02044e2:	e7bd                	bnez	a5,ffffffffc0204550 <wakeup_proc+0x88>
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE) {
ffffffffc02044e4:	4789                	li	a5,2
ffffffffc02044e6:	04f70863          	beq	a4,a5,ffffffffc0204536 <wakeup_proc+0x6e>
            proc->state = PROC_RUNNABLE;
ffffffffc02044ea:	c01c                	sw	a5,0(s0)
            proc->wait_state = 0;
ffffffffc02044ec:	0e042623          	sw	zero,236(s0)
            if (proc != current) {
ffffffffc02044f0:	0004f797          	auipc	a5,0x4f
ffffffffc02044f4:	1f87b783          	ld	a5,504(a5) # ffffffffc02536e8 <current>
ffffffffc02044f8:	02878363          	beq	a5,s0,ffffffffc020451e <wakeup_proc+0x56>
    if (proc != idleproc) {
ffffffffc02044fc:	0004f797          	auipc	a5,0x4f
ffffffffc0204500:	1f47b783          	ld	a5,500(a5) # ffffffffc02536f0 <idleproc>
ffffffffc0204504:	00f40d63          	beq	s0,a5,ffffffffc020451e <wakeup_proc+0x56>
        sched_class->enqueue(rq, proc);
ffffffffc0204508:	0004f797          	auipc	a5,0x4f
ffffffffc020450c:	2087b783          	ld	a5,520(a5) # ffffffffc0253710 <sched_class>
ffffffffc0204510:	6b9c                	ld	a5,16(a5)
ffffffffc0204512:	85a2                	mv	a1,s0
ffffffffc0204514:	0004f517          	auipc	a0,0x4f
ffffffffc0204518:	1f453503          	ld	a0,500(a0) # ffffffffc0253708 <rq>
ffffffffc020451c:	9782                	jalr	a5
    if (flag) {
ffffffffc020451e:	e491                	bnez	s1,ffffffffc020452a <wakeup_proc+0x62>
        else {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc0204520:	60e2                	ld	ra,24(sp)
ffffffffc0204522:	6442                	ld	s0,16(sp)
ffffffffc0204524:	64a2                	ld	s1,8(sp)
ffffffffc0204526:	6105                	addi	sp,sp,32
ffffffffc0204528:	8082                	ret
ffffffffc020452a:	6442                	ld	s0,16(sp)
ffffffffc020452c:	60e2                	ld	ra,24(sp)
ffffffffc020452e:	64a2                	ld	s1,8(sp)
ffffffffc0204530:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0204532:	8fafc06f          	j	ffffffffc020062c <intr_enable>
            warn("wakeup runnable process.\n");
ffffffffc0204536:	00002617          	auipc	a2,0x2
ffffffffc020453a:	0a260613          	addi	a2,a2,162 # ffffffffc02065d8 <default_pmm_manager+0x660>
ffffffffc020453e:	04900593          	li	a1,73
ffffffffc0204542:	00002517          	auipc	a0,0x2
ffffffffc0204546:	07e50513          	addi	a0,a0,126 # ffffffffc02065c0 <default_pmm_manager+0x648>
ffffffffc020454a:	d23fb0ef          	jal	ra,ffffffffc020026c <__warn>
ffffffffc020454e:	bfc1                	j	ffffffffc020451e <wakeup_proc+0x56>
        intr_disable();
ffffffffc0204550:	8e2fc0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc0204554:	4018                	lw	a4,0(s0)
ffffffffc0204556:	4485                	li	s1,1
ffffffffc0204558:	b771                	j	ffffffffc02044e4 <wakeup_proc+0x1c>
    assert(proc->state != PROC_ZOMBIE);
ffffffffc020455a:	00002697          	auipc	a3,0x2
ffffffffc020455e:	04668693          	addi	a3,a3,70 # ffffffffc02065a0 <default_pmm_manager+0x628>
ffffffffc0204562:	00001617          	auipc	a2,0x1
ffffffffc0204566:	df660613          	addi	a2,a2,-522 # ffffffffc0205358 <commands+0x408>
ffffffffc020456a:	03d00593          	li	a1,61
ffffffffc020456e:	00002517          	auipc	a0,0x2
ffffffffc0204572:	05250513          	addi	a0,a0,82 # ffffffffc02065c0 <default_pmm_manager+0x648>
ffffffffc0204576:	c8ffb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020457a <schedule>:

void
schedule(void) {
ffffffffc020457a:	7179                	addi	sp,sp,-48
ffffffffc020457c:	f406                	sd	ra,40(sp)
ffffffffc020457e:	f022                	sd	s0,32(sp)
ffffffffc0204580:	ec26                	sd	s1,24(sp)
ffffffffc0204582:	e84a                	sd	s2,16(sp)
ffffffffc0204584:	e44e                	sd	s3,8(sp)
ffffffffc0204586:	e052                	sd	s4,0(sp)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0204588:	100027f3          	csrr	a5,sstatus
ffffffffc020458c:	8b89                	andi	a5,a5,2
ffffffffc020458e:	4a01                	li	s4,0
ffffffffc0204590:	e7e9                	bnez	a5,ffffffffc020465a <schedule+0xe0>
    bool intr_flag;
    struct proc_struct *next;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
ffffffffc0204592:	0004f497          	auipc	s1,0x4f
ffffffffc0204596:	15648493          	addi	s1,s1,342 # ffffffffc02536e8 <current>
ffffffffc020459a:	608c                	ld	a1,0(s1)
ffffffffc020459c:	0004f997          	auipc	s3,0x4f
ffffffffc02045a0:	17498993          	addi	s3,s3,372 # ffffffffc0253710 <sched_class>
ffffffffc02045a4:	0004f917          	auipc	s2,0x4f
ffffffffc02045a8:	16490913          	addi	s2,s2,356 # ffffffffc0253708 <rq>
        if (current->state == PROC_RUNNABLE) {
ffffffffc02045ac:	4194                	lw	a3,0(a1)
        current->need_resched = 0;
ffffffffc02045ae:	0005bc23          	sd	zero,24(a1)
        if (current->state == PROC_RUNNABLE) {
ffffffffc02045b2:	4709                	li	a4,2
ffffffffc02045b4:	0009b783          	ld	a5,0(s3)
ffffffffc02045b8:	00093503          	ld	a0,0(s2)
ffffffffc02045bc:	06e68163          	beq	a3,a4,ffffffffc020461e <schedule+0xa4>
    return sched_class->pick_next(rq);
ffffffffc02045c0:	739c                	ld	a5,32(a5)
ffffffffc02045c2:	9782                	jalr	a5
ffffffffc02045c4:	842a                	mv	s0,a0
            sched_class_enqueue(current);
        }
        if ((next = sched_class_pick_next()) != NULL) {
ffffffffc02045c6:	cd25                	beqz	a0,ffffffffc020463e <schedule+0xc4>
    sched_class->dequeue(rq, proc);
ffffffffc02045c8:	0009b783          	ld	a5,0(s3)
ffffffffc02045cc:	00093503          	ld	a0,0(s2)
ffffffffc02045d0:	85a2                	mv	a1,s0
ffffffffc02045d2:	6f9c                	ld	a5,24(a5)
ffffffffc02045d4:	9782                	jalr	a5
            sched_class_dequeue(next);
        }
        if (next == NULL) {
            next = idleproc;
        }
        cprintf("pid:%d 's time slice is %d\n", current->pid, current->time_slice);
ffffffffc02045d6:	609c                	ld	a5,0(s1)
ffffffffc02045d8:	00002517          	auipc	a0,0x2
ffffffffc02045dc:	02050513          	addi	a0,a0,32 # ffffffffc02065f8 <default_pmm_manager+0x680>
ffffffffc02045e0:	1207a603          	lw	a2,288(a5)
ffffffffc02045e4:	43cc                	lw	a1,4(a5)
ffffffffc02045e6:	ae3fb0ef          	jal	ra,ffffffffc02000c8 <cprintf>
        next->runs ++;
ffffffffc02045ea:	441c                	lw	a5,8(s0)
        if (next != current) {
ffffffffc02045ec:	6098                	ld	a4,0(s1)
        next->runs ++;
ffffffffc02045ee:	2785                	addiw	a5,a5,1
ffffffffc02045f0:	c41c                	sw	a5,8(s0)
        if (next != current) {
ffffffffc02045f2:	00870c63          	beq	a4,s0,ffffffffc020460a <schedule+0x90>
            cprintf("The next proc is pid:%d\n",next->pid);
ffffffffc02045f6:	404c                	lw	a1,4(s0)
ffffffffc02045f8:	00002517          	auipc	a0,0x2
ffffffffc02045fc:	02050513          	addi	a0,a0,32 # ffffffffc0206618 <default_pmm_manager+0x6a0>
ffffffffc0204600:	ac9fb0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            proc_run(next);
ffffffffc0204604:	8522                	mv	a0,s0
ffffffffc0204606:	e9dfe0ef          	jal	ra,ffffffffc02034a2 <proc_run>
    if (flag) {
ffffffffc020460a:	020a1f63          	bnez	s4,ffffffffc0204648 <schedule+0xce>
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc020460e:	70a2                	ld	ra,40(sp)
ffffffffc0204610:	7402                	ld	s0,32(sp)
ffffffffc0204612:	64e2                	ld	s1,24(sp)
ffffffffc0204614:	6942                	ld	s2,16(sp)
ffffffffc0204616:	69a2                	ld	s3,8(sp)
ffffffffc0204618:	6a02                	ld	s4,0(sp)
ffffffffc020461a:	6145                	addi	sp,sp,48
ffffffffc020461c:	8082                	ret
    if (proc != idleproc) {
ffffffffc020461e:	0004f717          	auipc	a4,0x4f
ffffffffc0204622:	0d273703          	ld	a4,210(a4) # ffffffffc02536f0 <idleproc>
ffffffffc0204626:	f8e58de3          	beq	a1,a4,ffffffffc02045c0 <schedule+0x46>
        sched_class->enqueue(rq, proc);
ffffffffc020462a:	6b9c                	ld	a5,16(a5)
ffffffffc020462c:	9782                	jalr	a5
ffffffffc020462e:	0009b783          	ld	a5,0(s3)
ffffffffc0204632:	00093503          	ld	a0,0(s2)
    return sched_class->pick_next(rq);
ffffffffc0204636:	739c                	ld	a5,32(a5)
ffffffffc0204638:	9782                	jalr	a5
ffffffffc020463a:	842a                	mv	s0,a0
        if ((next = sched_class_pick_next()) != NULL) {
ffffffffc020463c:	f551                	bnez	a0,ffffffffc02045c8 <schedule+0x4e>
            next = idleproc;
ffffffffc020463e:	0004f417          	auipc	s0,0x4f
ffffffffc0204642:	0b243403          	ld	s0,178(s0) # ffffffffc02536f0 <idleproc>
ffffffffc0204646:	bf41                	j	ffffffffc02045d6 <schedule+0x5c>
}
ffffffffc0204648:	7402                	ld	s0,32(sp)
ffffffffc020464a:	70a2                	ld	ra,40(sp)
ffffffffc020464c:	64e2                	ld	s1,24(sp)
ffffffffc020464e:	6942                	ld	s2,16(sp)
ffffffffc0204650:	69a2                	ld	s3,8(sp)
ffffffffc0204652:	6a02                	ld	s4,0(sp)
ffffffffc0204654:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0204656:	fd7fb06f          	j	ffffffffc020062c <intr_enable>
        intr_disable();
ffffffffc020465a:	fd9fb0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc020465e:	4a05                	li	s4,1
ffffffffc0204660:	bf0d                	j	ffffffffc0204592 <schedule+0x18>

ffffffffc0204662 <RR_init>:
ffffffffc0204662:	e508                	sd	a0,8(a0)
ffffffffc0204664:	e108                	sd	a0,0(a0)
#include <default_sched.h>

static void
RR_init(struct run_queue *rq) {
    list_init(&(rq->run_list));
    rq->proc_num = 0;
ffffffffc0204666:	00052823          	sw	zero,16(a0)
}
ffffffffc020466a:	8082                	ret

ffffffffc020466c <RR_enqueue>:
    __list_add(elm, listelm->prev, listelm);
ffffffffc020466c:	611c                	ld	a5,0(a0)

static void
RR_enqueue(struct run_queue *rq, struct proc_struct *proc) {


    list_add_before(&(rq->run_list), &(proc->run_link));
ffffffffc020466e:	11058713          	addi	a4,a1,272
    prev->next = next->prev = elm;
ffffffffc0204672:	e118                	sd	a4,0(a0)
    if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice) {
ffffffffc0204674:	1205a683          	lw	a3,288(a1)
ffffffffc0204678:	e798                	sd	a4,8(a5)
    elm->next = next;
ffffffffc020467a:	10a5bc23          	sd	a0,280(a1)
    elm->prev = prev;
ffffffffc020467e:	10f5b823          	sd	a5,272(a1)
ffffffffc0204682:	c681                	beqz	a3,ffffffffc020468a <RR_enqueue+0x1e>
ffffffffc0204684:	495c                	lw	a5,20(a0)
ffffffffc0204686:	00d7d963          	bge	a5,a3,ffffffffc0204698 <RR_enqueue+0x2c>
        //proc->time_slice = rq->max_time_slice;
        proc->time_slice = proc -> labschedule_priority * 5;
ffffffffc020468a:	1245a703          	lw	a4,292(a1)
ffffffffc020468e:	0027179b          	slliw	a5,a4,0x2
ffffffffc0204692:	9fb9                	addw	a5,a5,a4
ffffffffc0204694:	12f5a023          	sw	a5,288(a1)
    }
    proc->rq = rq;
    rq->proc_num ++;
ffffffffc0204698:	491c                	lw	a5,16(a0)
    proc->rq = rq;
ffffffffc020469a:	10a5b423          	sd	a0,264(a1)
    rq->proc_num ++;
ffffffffc020469e:	2785                	addiw	a5,a5,1
ffffffffc02046a0:	c91c                	sw	a5,16(a0)
}
ffffffffc02046a2:	8082                	ret

ffffffffc02046a4 <RR_pick_next>:
    return listelm->next;
ffffffffc02046a4:	651c                	ld	a5,8(a0)
}

static struct proc_struct *
RR_pick_next(struct run_queue *rq) {
    list_entry_t *le = list_next(&(rq->run_list));
    if (le != &(rq->run_list)) {
ffffffffc02046a6:	00f50563          	beq	a0,a5,ffffffffc02046b0 <RR_pick_next+0xc>
        return le2proc(le, run_link);
ffffffffc02046aa:	ef078513          	addi	a0,a5,-272
ffffffffc02046ae:	8082                	ret
    }
    return NULL;
ffffffffc02046b0:	4501                	li	a0,0
}
ffffffffc02046b2:	8082                	ret

ffffffffc02046b4 <RR_proc_tick>:

static void
RR_proc_tick(struct run_queue *rq, struct proc_struct *proc) {
    if (proc->time_slice > 0) {
ffffffffc02046b4:	1205a783          	lw	a5,288(a1)
ffffffffc02046b8:	00f05563          	blez	a5,ffffffffc02046c2 <RR_proc_tick+0xe>
        proc->time_slice --;
ffffffffc02046bc:	37fd                	addiw	a5,a5,-1
ffffffffc02046be:	12f5a023          	sw	a5,288(a1)
    }
    if (proc->time_slice == 0) {
ffffffffc02046c2:	e399                	bnez	a5,ffffffffc02046c8 <RR_proc_tick+0x14>
        proc->need_resched = 1;
ffffffffc02046c4:	4785                	li	a5,1
ffffffffc02046c6:	ed9c                	sd	a5,24(a1)
    }
}
ffffffffc02046c8:	8082                	ret

ffffffffc02046ca <RR_dequeue>:
    return list->next == list;
ffffffffc02046ca:	1185b703          	ld	a4,280(a1)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02046ce:	11058793          	addi	a5,a1,272
ffffffffc02046d2:	02e78363          	beq	a5,a4,ffffffffc02046f8 <RR_dequeue+0x2e>
ffffffffc02046d6:	1085b683          	ld	a3,264(a1)
ffffffffc02046da:	00a69f63          	bne	a3,a0,ffffffffc02046f8 <RR_dequeue+0x2e>
    __list_del(listelm->prev, listelm->next);
ffffffffc02046de:	1105b503          	ld	a0,272(a1)
    rq->proc_num --;
ffffffffc02046e2:	4a90                	lw	a2,16(a3)
    prev->next = next;
ffffffffc02046e4:	e518                	sd	a4,8(a0)
    next->prev = prev;
ffffffffc02046e6:	e308                	sd	a0,0(a4)
    elm->prev = elm->next = elm;
ffffffffc02046e8:	10f5bc23          	sd	a5,280(a1)
ffffffffc02046ec:	10f5b823          	sd	a5,272(a1)
ffffffffc02046f0:	fff6079b          	addiw	a5,a2,-1
ffffffffc02046f4:	ca9c                	sw	a5,16(a3)
ffffffffc02046f6:	8082                	ret
RR_dequeue(struct run_queue *rq, struct proc_struct *proc) {
ffffffffc02046f8:	1141                	addi	sp,sp,-16
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02046fa:	00002697          	auipc	a3,0x2
ffffffffc02046fe:	f3e68693          	addi	a3,a3,-194 # ffffffffc0206638 <default_pmm_manager+0x6c0>
ffffffffc0204702:	00001617          	auipc	a2,0x1
ffffffffc0204706:	c5660613          	addi	a2,a2,-938 # ffffffffc0205358 <commands+0x408>
ffffffffc020470a:	45f1                	li	a1,28
ffffffffc020470c:	00002517          	auipc	a0,0x2
ffffffffc0204710:	f6450513          	addi	a0,a0,-156 # ffffffffc0206670 <default_pmm_manager+0x6f8>
RR_dequeue(struct run_queue *rq, struct proc_struct *proc) {
ffffffffc0204714:	e406                	sd	ra,8(sp)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc0204716:	aeffb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020471a <sys_getpid>:
    return do_kill(pid);
}

static int
sys_getpid(uint64_t arg[]) {
    return current->pid;
ffffffffc020471a:	0004f797          	auipc	a5,0x4f
ffffffffc020471e:	fce7b783          	ld	a5,-50(a5) # ffffffffc02536e8 <current>
}
ffffffffc0204722:	43c8                	lw	a0,4(a5)
ffffffffc0204724:	8082                	ret

ffffffffc0204726 <sys_gettime>:
    cputchar(c);
    return 0;
}

static int sys_gettime(uint64_t arg[]){
    return (int)ticks*10;
ffffffffc0204726:	0004f797          	auipc	a5,0x4f
ffffffffc020472a:	ff27b783          	ld	a5,-14(a5) # ffffffffc0253718 <ticks>
ffffffffc020472e:	0027951b          	slliw	a0,a5,0x2
ffffffffc0204732:	9d3d                	addw	a0,a0,a5
}
ffffffffc0204734:	0015151b          	slliw	a0,a0,0x1
ffffffffc0204738:	8082                	ret

ffffffffc020473a <sys_labschedule_set_priority>:

static int sys_labschedule_set_priority(uint64_t arg[]){
    return current->labschedule_priority = arg[0];
ffffffffc020473a:	6108                	ld	a0,0(a0)
ffffffffc020473c:	0004f797          	auipc	a5,0x4f
ffffffffc0204740:	fac7b783          	ld	a5,-84(a5) # ffffffffc02536e8 <current>
ffffffffc0204744:	12a7a223          	sw	a0,292(a5)
}
ffffffffc0204748:	2501                	sext.w	a0,a0
ffffffffc020474a:	8082                	ret

ffffffffc020474c <sys_putc>:
    cputchar(c);
ffffffffc020474c:	4108                	lw	a0,0(a0)
sys_putc(uint64_t arg[]) {
ffffffffc020474e:	1141                	addi	sp,sp,-16
ffffffffc0204750:	e406                	sd	ra,8(sp)
    cputchar(c);
ffffffffc0204752:	9adfb0ef          	jal	ra,ffffffffc02000fe <cputchar>
}
ffffffffc0204756:	60a2                	ld	ra,8(sp)
ffffffffc0204758:	4501                	li	a0,0
ffffffffc020475a:	0141                	addi	sp,sp,16
ffffffffc020475c:	8082                	ret

ffffffffc020475e <sys_kill>:
    return do_kill(pid);
ffffffffc020475e:	4108                	lw	a0,0(a0)
ffffffffc0204760:	b55ff06f          	j	ffffffffc02042b4 <do_kill>

ffffffffc0204764 <sys_yield>:
    return do_yield();
ffffffffc0204764:	b03ff06f          	j	ffffffffc0204266 <do_yield>

ffffffffc0204768 <sys_exec>:
    return do_execve(name, len, binary, size);
ffffffffc0204768:	6d14                	ld	a3,24(a0)
ffffffffc020476a:	6910                	ld	a2,16(a0)
ffffffffc020476c:	650c                	ld	a1,8(a0)
ffffffffc020476e:	6108                	ld	a0,0(a0)
ffffffffc0204770:	e0eff06f          	j	ffffffffc0203d7e <do_execve>

ffffffffc0204774 <sys_wait>:
    return do_wait(pid, store);
ffffffffc0204774:	650c                	ld	a1,8(a0)
ffffffffc0204776:	4108                	lw	a0,0(a0)
ffffffffc0204778:	affff06f          	j	ffffffffc0204276 <do_wait>

ffffffffc020477c <sys_fork>:
    struct trapframe *tf = current->tf;
ffffffffc020477c:	0004f797          	auipc	a5,0x4f
ffffffffc0204780:	f6c7b783          	ld	a5,-148(a5) # ffffffffc02536e8 <current>
ffffffffc0204784:	73d0                	ld	a2,160(a5)
    return do_fork(0, stack, tf);
ffffffffc0204786:	4501                	li	a0,0
ffffffffc0204788:	6a0c                	ld	a1,16(a2)
ffffffffc020478a:	dddfe06f          	j	ffffffffc0203566 <do_fork>

ffffffffc020478e <sys_exit>:
    return do_exit(error_code);
ffffffffc020478e:	4108                	lw	a0,0(a0)
ffffffffc0204790:	9eaff06f          	j	ffffffffc020397a <do_exit>

ffffffffc0204794 <syscall>:
};

#define NUM_SYSCALLS        ((sizeof(syscalls)) / (sizeof(syscalls[0])))

void
syscall(void) {
ffffffffc0204794:	715d                	addi	sp,sp,-80
ffffffffc0204796:	fc26                	sd	s1,56(sp)
    struct trapframe *tf = current->tf;
ffffffffc0204798:	0004f497          	auipc	s1,0x4f
ffffffffc020479c:	f5048493          	addi	s1,s1,-176 # ffffffffc02536e8 <current>
ffffffffc02047a0:	6098                	ld	a4,0(s1)
syscall(void) {
ffffffffc02047a2:	e0a2                	sd	s0,64(sp)
ffffffffc02047a4:	f84a                	sd	s2,48(sp)
    struct trapframe *tf = current->tf;
ffffffffc02047a6:	7340                	ld	s0,160(a4)
syscall(void) {
ffffffffc02047a8:	e486                	sd	ra,72(sp)
    uint64_t arg[5];
    int num = tf->gpr.a0;
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc02047aa:	0ff00793          	li	a5,255
    int num = tf->gpr.a0;
ffffffffc02047ae:	05042903          	lw	s2,80(s0)
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc02047b2:	0327ee63          	bltu	a5,s2,ffffffffc02047ee <syscall+0x5a>
        if (syscalls[num] != NULL) {
ffffffffc02047b6:	00391713          	slli	a4,s2,0x3
ffffffffc02047ba:	00002797          	auipc	a5,0x2
ffffffffc02047be:	f2e78793          	addi	a5,a5,-210 # ffffffffc02066e8 <syscalls>
ffffffffc02047c2:	97ba                	add	a5,a5,a4
ffffffffc02047c4:	639c                	ld	a5,0(a5)
ffffffffc02047c6:	c785                	beqz	a5,ffffffffc02047ee <syscall+0x5a>
            arg[0] = tf->gpr.a1;
ffffffffc02047c8:	6c28                	ld	a0,88(s0)
            arg[1] = tf->gpr.a2;
ffffffffc02047ca:	702c                	ld	a1,96(s0)
            arg[2] = tf->gpr.a3;
ffffffffc02047cc:	7430                	ld	a2,104(s0)
            arg[3] = tf->gpr.a4;
ffffffffc02047ce:	7834                	ld	a3,112(s0)
            arg[4] = tf->gpr.a5;
ffffffffc02047d0:	7c38                	ld	a4,120(s0)
            arg[0] = tf->gpr.a1;
ffffffffc02047d2:	e42a                	sd	a0,8(sp)
            arg[1] = tf->gpr.a2;
ffffffffc02047d4:	e82e                	sd	a1,16(sp)
            arg[2] = tf->gpr.a3;
ffffffffc02047d6:	ec32                	sd	a2,24(sp)
            arg[3] = tf->gpr.a4;
ffffffffc02047d8:	f036                	sd	a3,32(sp)
            arg[4] = tf->gpr.a5;
ffffffffc02047da:	f43a                	sd	a4,40(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02047dc:	0028                	addi	a0,sp,8
ffffffffc02047de:	9782                	jalr	a5
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
ffffffffc02047e0:	60a6                	ld	ra,72(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02047e2:	e828                	sd	a0,80(s0)
}
ffffffffc02047e4:	6406                	ld	s0,64(sp)
ffffffffc02047e6:	74e2                	ld	s1,56(sp)
ffffffffc02047e8:	7942                	ld	s2,48(sp)
ffffffffc02047ea:	6161                	addi	sp,sp,80
ffffffffc02047ec:	8082                	ret
    print_trapframe(tf);
ffffffffc02047ee:	8522                	mv	a0,s0
ffffffffc02047f0:	830fc0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
    panic("undefined syscall %d, pid = %d, name = %s.\n",
ffffffffc02047f4:	609c                	ld	a5,0(s1)
ffffffffc02047f6:	86ca                	mv	a3,s2
ffffffffc02047f8:	00002617          	auipc	a2,0x2
ffffffffc02047fc:	ea860613          	addi	a2,a2,-344 # ffffffffc02066a0 <default_pmm_manager+0x728>
ffffffffc0204800:	43d8                	lw	a4,4(a5)
ffffffffc0204802:	06600593          	li	a1,102
ffffffffc0204806:	0b478793          	addi	a5,a5,180
ffffffffc020480a:	00002517          	auipc	a0,0x2
ffffffffc020480e:	ec650513          	addi	a0,a0,-314 # ffffffffc02066d0 <default_pmm_manager+0x758>
ffffffffc0204812:	9f3fb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0204816 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0204816:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc020481a:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc020481c:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc020481e:	cb81                	beqz	a5,ffffffffc020482e <strlen+0x18>
        cnt ++;
ffffffffc0204820:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc0204822:	00a707b3          	add	a5,a4,a0
ffffffffc0204826:	0007c783          	lbu	a5,0(a5)
ffffffffc020482a:	fbfd                	bnez	a5,ffffffffc0204820 <strlen+0xa>
ffffffffc020482c:	8082                	ret
    }
    return cnt;
}
ffffffffc020482e:	8082                	ret

ffffffffc0204830 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
ffffffffc0204830:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0204832:	4501                	li	a0,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc0204834:	e589                	bnez	a1,ffffffffc020483e <strnlen+0xe>
ffffffffc0204836:	a811                	j	ffffffffc020484a <strnlen+0x1a>
        cnt ++;
ffffffffc0204838:	0505                	addi	a0,a0,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc020483a:	00a58763          	beq	a1,a0,ffffffffc0204848 <strnlen+0x18>
ffffffffc020483e:	00a707b3          	add	a5,a4,a0
ffffffffc0204842:	0007c783          	lbu	a5,0(a5)
ffffffffc0204846:	fbed                	bnez	a5,ffffffffc0204838 <strnlen+0x8>
    }
    return cnt;
}
ffffffffc0204848:	8082                	ret
ffffffffc020484a:	8082                	ret

ffffffffc020484c <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020484c:	00054783          	lbu	a5,0(a0)
ffffffffc0204850:	0005c703          	lbu	a4,0(a1)
ffffffffc0204854:	cb89                	beqz	a5,ffffffffc0204866 <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0204856:	0505                	addi	a0,a0,1
ffffffffc0204858:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020485a:	fee789e3          	beq	a5,a4,ffffffffc020484c <strcmp>
ffffffffc020485e:	0007851b          	sext.w	a0,a5
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0204862:	9d19                	subw	a0,a0,a4
ffffffffc0204864:	8082                	ret
ffffffffc0204866:	4501                	li	a0,0
ffffffffc0204868:	bfed                	j	ffffffffc0204862 <strcmp+0x16>

ffffffffc020486a <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc020486a:	00054783          	lbu	a5,0(a0)
ffffffffc020486e:	c799                	beqz	a5,ffffffffc020487c <strchr+0x12>
        if (*s == c) {
ffffffffc0204870:	00f58763          	beq	a1,a5,ffffffffc020487e <strchr+0x14>
    while (*s != '\0') {
ffffffffc0204874:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc0204878:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc020487a:	fbfd                	bnez	a5,ffffffffc0204870 <strchr+0x6>
    }
    return NULL;
ffffffffc020487c:	4501                	li	a0,0
}
ffffffffc020487e:	8082                	ret

ffffffffc0204880 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0204880:	ca01                	beqz	a2,ffffffffc0204890 <memset+0x10>
ffffffffc0204882:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0204884:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0204886:	0785                	addi	a5,a5,1
ffffffffc0204888:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc020488c:	fec79de3          	bne	a5,a2,ffffffffc0204886 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0204890:	8082                	ret

ffffffffc0204892 <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc0204892:	ca19                	beqz	a2,ffffffffc02048a8 <memcpy+0x16>
ffffffffc0204894:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc0204896:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc0204898:	0005c703          	lbu	a4,0(a1)
ffffffffc020489c:	0585                	addi	a1,a1,1
ffffffffc020489e:	0785                	addi	a5,a5,1
ffffffffc02048a0:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc02048a4:	fec59ae3          	bne	a1,a2,ffffffffc0204898 <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc02048a8:	8082                	ret

ffffffffc02048aa <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc02048aa:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02048ae:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc02048b0:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02048b4:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc02048b6:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02048ba:	f022                	sd	s0,32(sp)
ffffffffc02048bc:	ec26                	sd	s1,24(sp)
ffffffffc02048be:	e84a                	sd	s2,16(sp)
ffffffffc02048c0:	f406                	sd	ra,40(sp)
ffffffffc02048c2:	e44e                	sd	s3,8(sp)
ffffffffc02048c4:	84aa                	mv	s1,a0
ffffffffc02048c6:	892e                	mv	s2,a1
ffffffffc02048c8:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc02048cc:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
ffffffffc02048ce:	03067e63          	bgeu	a2,a6,ffffffffc020490a <printnum+0x60>
ffffffffc02048d2:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc02048d4:	00805763          	blez	s0,ffffffffc02048e2 <printnum+0x38>
ffffffffc02048d8:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc02048da:	85ca                	mv	a1,s2
ffffffffc02048dc:	854e                	mv	a0,s3
ffffffffc02048de:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc02048e0:	fc65                	bnez	s0,ffffffffc02048d8 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048e2:	1a02                	slli	s4,s4,0x20
ffffffffc02048e4:	020a5a13          	srli	s4,s4,0x20
ffffffffc02048e8:	00002797          	auipc	a5,0x2
ffffffffc02048ec:	60078793          	addi	a5,a5,1536 # ffffffffc0206ee8 <syscalls+0x800>
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
ffffffffc02048f0:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048f2:	9a3e                	add	s4,s4,a5
ffffffffc02048f4:	000a4503          	lbu	a0,0(s4)
}
ffffffffc02048f8:	70a2                	ld	ra,40(sp)
ffffffffc02048fa:	69a2                	ld	s3,8(sp)
ffffffffc02048fc:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048fe:	85ca                	mv	a1,s2
ffffffffc0204900:	8326                	mv	t1,s1
}
ffffffffc0204902:	6942                	ld	s2,16(sp)
ffffffffc0204904:	64e2                	ld	s1,24(sp)
ffffffffc0204906:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0204908:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc020490a:	03065633          	divu	a2,a2,a6
ffffffffc020490e:	8722                	mv	a4,s0
ffffffffc0204910:	f9bff0ef          	jal	ra,ffffffffc02048aa <printnum>
ffffffffc0204914:	b7f9                	j	ffffffffc02048e2 <printnum+0x38>

ffffffffc0204916 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0204916:	7119                	addi	sp,sp,-128
ffffffffc0204918:	f4a6                	sd	s1,104(sp)
ffffffffc020491a:	f0ca                	sd	s2,96(sp)
ffffffffc020491c:	ecce                	sd	s3,88(sp)
ffffffffc020491e:	e8d2                	sd	s4,80(sp)
ffffffffc0204920:	e4d6                	sd	s5,72(sp)
ffffffffc0204922:	e0da                	sd	s6,64(sp)
ffffffffc0204924:	fc5e                	sd	s7,56(sp)
ffffffffc0204926:	f06a                	sd	s10,32(sp)
ffffffffc0204928:	fc86                	sd	ra,120(sp)
ffffffffc020492a:	f8a2                	sd	s0,112(sp)
ffffffffc020492c:	f862                	sd	s8,48(sp)
ffffffffc020492e:	f466                	sd	s9,40(sp)
ffffffffc0204930:	ec6e                	sd	s11,24(sp)
ffffffffc0204932:	892a                	mv	s2,a0
ffffffffc0204934:	84ae                	mv	s1,a1
ffffffffc0204936:	8d32                	mv	s10,a2
ffffffffc0204938:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020493a:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc020493e:	5b7d                	li	s6,-1
ffffffffc0204940:	00002a97          	auipc	s5,0x2
ffffffffc0204944:	5d4a8a93          	addi	s5,s5,1492 # ffffffffc0206f14 <syscalls+0x82c>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0204948:	00002b97          	auipc	s7,0x2
ffffffffc020494c:	7e8b8b93          	addi	s7,s7,2024 # ffffffffc0207130 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204950:	000d4503          	lbu	a0,0(s10)
ffffffffc0204954:	001d0413          	addi	s0,s10,1
ffffffffc0204958:	01350a63          	beq	a0,s3,ffffffffc020496c <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc020495c:	c121                	beqz	a0,ffffffffc020499c <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc020495e:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204960:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0204962:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204964:	fff44503          	lbu	a0,-1(s0)
ffffffffc0204968:	ff351ae3          	bne	a0,s3,ffffffffc020495c <vprintfmt+0x46>
ffffffffc020496c:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0204970:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0204974:	4c81                	li	s9,0
ffffffffc0204976:	4881                	li	a7,0
        width = precision = -1;
ffffffffc0204978:	5c7d                	li	s8,-1
ffffffffc020497a:	5dfd                	li	s11,-1
ffffffffc020497c:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0204980:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204982:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0204986:	0ff5f593          	andi	a1,a1,255
ffffffffc020498a:	00140d13          	addi	s10,s0,1
ffffffffc020498e:	04b56263          	bltu	a0,a1,ffffffffc02049d2 <vprintfmt+0xbc>
ffffffffc0204992:	058a                	slli	a1,a1,0x2
ffffffffc0204994:	95d6                	add	a1,a1,s5
ffffffffc0204996:	4194                	lw	a3,0(a1)
ffffffffc0204998:	96d6                	add	a3,a3,s5
ffffffffc020499a:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc020499c:	70e6                	ld	ra,120(sp)
ffffffffc020499e:	7446                	ld	s0,112(sp)
ffffffffc02049a0:	74a6                	ld	s1,104(sp)
ffffffffc02049a2:	7906                	ld	s2,96(sp)
ffffffffc02049a4:	69e6                	ld	s3,88(sp)
ffffffffc02049a6:	6a46                	ld	s4,80(sp)
ffffffffc02049a8:	6aa6                	ld	s5,72(sp)
ffffffffc02049aa:	6b06                	ld	s6,64(sp)
ffffffffc02049ac:	7be2                	ld	s7,56(sp)
ffffffffc02049ae:	7c42                	ld	s8,48(sp)
ffffffffc02049b0:	7ca2                	ld	s9,40(sp)
ffffffffc02049b2:	7d02                	ld	s10,32(sp)
ffffffffc02049b4:	6de2                	ld	s11,24(sp)
ffffffffc02049b6:	6109                	addi	sp,sp,128
ffffffffc02049b8:	8082                	ret
            padc = '0';
ffffffffc02049ba:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc02049bc:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02049c0:	846a                	mv	s0,s10
ffffffffc02049c2:	00140d13          	addi	s10,s0,1
ffffffffc02049c6:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02049ca:	0ff5f593          	andi	a1,a1,255
ffffffffc02049ce:	fcb572e3          	bgeu	a0,a1,ffffffffc0204992 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc02049d2:	85a6                	mv	a1,s1
ffffffffc02049d4:	02500513          	li	a0,37
ffffffffc02049d8:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc02049da:	fff44783          	lbu	a5,-1(s0)
ffffffffc02049de:	8d22                	mv	s10,s0
ffffffffc02049e0:	f73788e3          	beq	a5,s3,ffffffffc0204950 <vprintfmt+0x3a>
ffffffffc02049e4:	ffed4783          	lbu	a5,-2(s10)
ffffffffc02049e8:	1d7d                	addi	s10,s10,-1
ffffffffc02049ea:	ff379de3          	bne	a5,s3,ffffffffc02049e4 <vprintfmt+0xce>
ffffffffc02049ee:	b78d                	j	ffffffffc0204950 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc02049f0:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc02049f4:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02049f8:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc02049fa:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc02049fe:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0204a02:	02d86463          	bltu	a6,a3,ffffffffc0204a2a <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0204a06:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0204a0a:	002c169b          	slliw	a3,s8,0x2
ffffffffc0204a0e:	0186873b          	addw	a4,a3,s8
ffffffffc0204a12:	0017171b          	slliw	a4,a4,0x1
ffffffffc0204a16:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0204a18:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0204a1c:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0204a1e:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0204a22:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0204a26:	fed870e3          	bgeu	a6,a3,ffffffffc0204a06 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0204a2a:	f40ddce3          	bgez	s11,ffffffffc0204982 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0204a2e:	8de2                	mv	s11,s8
ffffffffc0204a30:	5c7d                	li	s8,-1
ffffffffc0204a32:	bf81                	j	ffffffffc0204982 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0204a34:	fffdc693          	not	a3,s11
ffffffffc0204a38:	96fd                	srai	a3,a3,0x3f
ffffffffc0204a3a:	00ddfdb3          	and	s11,s11,a3
ffffffffc0204a3e:	00144603          	lbu	a2,1(s0)
ffffffffc0204a42:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a44:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204a46:	bf35                	j	ffffffffc0204982 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0204a48:	000a2c03          	lw	s8,0(s4)
            goto process_precision;
ffffffffc0204a4c:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0204a50:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a52:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0204a54:	bfd9                	j	ffffffffc0204a2a <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0204a56:	4705                	li	a4,1
ffffffffc0204a58:	008a0593          	addi	a1,s4,8
ffffffffc0204a5c:	01174463          	blt	a4,a7,ffffffffc0204a64 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0204a60:	1a088e63          	beqz	a7,ffffffffc0204c1c <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0204a64:	000a3603          	ld	a2,0(s4)
ffffffffc0204a68:	46c1                	li	a3,16
ffffffffc0204a6a:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0204a6c:	2781                	sext.w	a5,a5
ffffffffc0204a6e:	876e                	mv	a4,s11
ffffffffc0204a70:	85a6                	mv	a1,s1
ffffffffc0204a72:	854a                	mv	a0,s2
ffffffffc0204a74:	e37ff0ef          	jal	ra,ffffffffc02048aa <printnum>
            break;
ffffffffc0204a78:	bde1                	j	ffffffffc0204950 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0204a7a:	000a2503          	lw	a0,0(s4)
ffffffffc0204a7e:	85a6                	mv	a1,s1
ffffffffc0204a80:	0a21                	addi	s4,s4,8
ffffffffc0204a82:	9902                	jalr	s2
            break;
ffffffffc0204a84:	b5f1                	j	ffffffffc0204950 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0204a86:	4705                	li	a4,1
ffffffffc0204a88:	008a0593          	addi	a1,s4,8
ffffffffc0204a8c:	01174463          	blt	a4,a7,ffffffffc0204a94 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0204a90:	18088163          	beqz	a7,ffffffffc0204c12 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0204a94:	000a3603          	ld	a2,0(s4)
ffffffffc0204a98:	46a9                	li	a3,10
ffffffffc0204a9a:	8a2e                	mv	s4,a1
ffffffffc0204a9c:	bfc1                	j	ffffffffc0204a6c <vprintfmt+0x156>
            goto reswitch;
ffffffffc0204a9e:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0204aa2:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204aa4:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204aa6:	bdf1                	j	ffffffffc0204982 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0204aa8:	85a6                	mv	a1,s1
ffffffffc0204aaa:	02500513          	li	a0,37
ffffffffc0204aae:	9902                	jalr	s2
            break;
ffffffffc0204ab0:	b545                	j	ffffffffc0204950 <vprintfmt+0x3a>
            lflag ++;
ffffffffc0204ab2:	00144603          	lbu	a2,1(s0)
ffffffffc0204ab6:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204ab8:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204aba:	b5e1                	j	ffffffffc0204982 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0204abc:	4705                	li	a4,1
ffffffffc0204abe:	008a0593          	addi	a1,s4,8
ffffffffc0204ac2:	01174463          	blt	a4,a7,ffffffffc0204aca <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0204ac6:	14088163          	beqz	a7,ffffffffc0204c08 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0204aca:	000a3603          	ld	a2,0(s4)
ffffffffc0204ace:	46a1                	li	a3,8
ffffffffc0204ad0:	8a2e                	mv	s4,a1
ffffffffc0204ad2:	bf69                	j	ffffffffc0204a6c <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0204ad4:	03000513          	li	a0,48
ffffffffc0204ad8:	85a6                	mv	a1,s1
ffffffffc0204ada:	e03e                	sd	a5,0(sp)
ffffffffc0204adc:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0204ade:	85a6                	mv	a1,s1
ffffffffc0204ae0:	07800513          	li	a0,120
ffffffffc0204ae4:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0204ae6:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0204ae8:	6782                	ld	a5,0(sp)
ffffffffc0204aea:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0204aec:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0204af0:	bfb5                	j	ffffffffc0204a6c <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0204af2:	000a3403          	ld	s0,0(s4)
ffffffffc0204af6:	008a0713          	addi	a4,s4,8
ffffffffc0204afa:	e03a                	sd	a4,0(sp)
ffffffffc0204afc:	14040263          	beqz	s0,ffffffffc0204c40 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0204b00:	0fb05763          	blez	s11,ffffffffc0204bee <vprintfmt+0x2d8>
ffffffffc0204b04:	02d00693          	li	a3,45
ffffffffc0204b08:	0cd79163          	bne	a5,a3,ffffffffc0204bca <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204b0c:	00044783          	lbu	a5,0(s0)
ffffffffc0204b10:	0007851b          	sext.w	a0,a5
ffffffffc0204b14:	cf85                	beqz	a5,ffffffffc0204b4c <vprintfmt+0x236>
ffffffffc0204b16:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204b1a:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204b1e:	000c4563          	bltz	s8,ffffffffc0204b28 <vprintfmt+0x212>
ffffffffc0204b22:	3c7d                	addiw	s8,s8,-1
ffffffffc0204b24:	036c0263          	beq	s8,s6,ffffffffc0204b48 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0204b28:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204b2a:	0e0c8e63          	beqz	s9,ffffffffc0204c26 <vprintfmt+0x310>
ffffffffc0204b2e:	3781                	addiw	a5,a5,-32
ffffffffc0204b30:	0ef47b63          	bgeu	s0,a5,ffffffffc0204c26 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0204b34:	03f00513          	li	a0,63
ffffffffc0204b38:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204b3a:	000a4783          	lbu	a5,0(s4)
ffffffffc0204b3e:	3dfd                	addiw	s11,s11,-1
ffffffffc0204b40:	0a05                	addi	s4,s4,1
ffffffffc0204b42:	0007851b          	sext.w	a0,a5
ffffffffc0204b46:	ffe1                	bnez	a5,ffffffffc0204b1e <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0204b48:	01b05963          	blez	s11,ffffffffc0204b5a <vprintfmt+0x244>
ffffffffc0204b4c:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0204b4e:	85a6                	mv	a1,s1
ffffffffc0204b50:	02000513          	li	a0,32
ffffffffc0204b54:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0204b56:	fe0d9be3          	bnez	s11,ffffffffc0204b4c <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0204b5a:	6a02                	ld	s4,0(sp)
ffffffffc0204b5c:	bbd5                	j	ffffffffc0204950 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0204b5e:	4705                	li	a4,1
ffffffffc0204b60:	008a0c93          	addi	s9,s4,8
ffffffffc0204b64:	01174463          	blt	a4,a7,ffffffffc0204b6c <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0204b68:	08088d63          	beqz	a7,ffffffffc0204c02 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0204b6c:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0204b70:	0a044d63          	bltz	s0,ffffffffc0204c2a <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0204b74:	8622                	mv	a2,s0
ffffffffc0204b76:	8a66                	mv	s4,s9
ffffffffc0204b78:	46a9                	li	a3,10
ffffffffc0204b7a:	bdcd                	j	ffffffffc0204a6c <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0204b7c:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0204b80:	4761                	li	a4,24
            err = va_arg(ap, int);
ffffffffc0204b82:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0204b84:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0204b88:	8fb5                	xor	a5,a5,a3
ffffffffc0204b8a:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0204b8e:	02d74163          	blt	a4,a3,ffffffffc0204bb0 <vprintfmt+0x29a>
ffffffffc0204b92:	00369793          	slli	a5,a3,0x3
ffffffffc0204b96:	97de                	add	a5,a5,s7
ffffffffc0204b98:	639c                	ld	a5,0(a5)
ffffffffc0204b9a:	cb99                	beqz	a5,ffffffffc0204bb0 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0204b9c:	86be                	mv	a3,a5
ffffffffc0204b9e:	00000617          	auipc	a2,0x0
ffffffffc0204ba2:	13260613          	addi	a2,a2,306 # ffffffffc0204cd0 <etext+0x22>
ffffffffc0204ba6:	85a6                	mv	a1,s1
ffffffffc0204ba8:	854a                	mv	a0,s2
ffffffffc0204baa:	0ce000ef          	jal	ra,ffffffffc0204c78 <printfmt>
ffffffffc0204bae:	b34d                	j	ffffffffc0204950 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0204bb0:	00002617          	auipc	a2,0x2
ffffffffc0204bb4:	35860613          	addi	a2,a2,856 # ffffffffc0206f08 <syscalls+0x820>
ffffffffc0204bb8:	85a6                	mv	a1,s1
ffffffffc0204bba:	854a                	mv	a0,s2
ffffffffc0204bbc:	0bc000ef          	jal	ra,ffffffffc0204c78 <printfmt>
ffffffffc0204bc0:	bb41                	j	ffffffffc0204950 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0204bc2:	00002417          	auipc	s0,0x2
ffffffffc0204bc6:	33e40413          	addi	s0,s0,830 # ffffffffc0206f00 <syscalls+0x818>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0204bca:	85e2                	mv	a1,s8
ffffffffc0204bcc:	8522                	mv	a0,s0
ffffffffc0204bce:	e43e                	sd	a5,8(sp)
ffffffffc0204bd0:	c61ff0ef          	jal	ra,ffffffffc0204830 <strnlen>
ffffffffc0204bd4:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0204bd8:	01b05b63          	blez	s11,ffffffffc0204bee <vprintfmt+0x2d8>
ffffffffc0204bdc:	67a2                	ld	a5,8(sp)
ffffffffc0204bde:	00078a1b          	sext.w	s4,a5
ffffffffc0204be2:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0204be4:	85a6                	mv	a1,s1
ffffffffc0204be6:	8552                	mv	a0,s4
ffffffffc0204be8:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0204bea:	fe0d9ce3          	bnez	s11,ffffffffc0204be2 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204bee:	00044783          	lbu	a5,0(s0)
ffffffffc0204bf2:	00140a13          	addi	s4,s0,1
ffffffffc0204bf6:	0007851b          	sext.w	a0,a5
ffffffffc0204bfa:	d3a5                	beqz	a5,ffffffffc0204b5a <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204bfc:	05e00413          	li	s0,94
ffffffffc0204c00:	bf39                	j	ffffffffc0204b1e <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0204c02:	000a2403          	lw	s0,0(s4)
ffffffffc0204c06:	b7ad                	j	ffffffffc0204b70 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0204c08:	000a6603          	lwu	a2,0(s4)
ffffffffc0204c0c:	46a1                	li	a3,8
ffffffffc0204c0e:	8a2e                	mv	s4,a1
ffffffffc0204c10:	bdb1                	j	ffffffffc0204a6c <vprintfmt+0x156>
ffffffffc0204c12:	000a6603          	lwu	a2,0(s4)
ffffffffc0204c16:	46a9                	li	a3,10
ffffffffc0204c18:	8a2e                	mv	s4,a1
ffffffffc0204c1a:	bd89                	j	ffffffffc0204a6c <vprintfmt+0x156>
ffffffffc0204c1c:	000a6603          	lwu	a2,0(s4)
ffffffffc0204c20:	46c1                	li	a3,16
ffffffffc0204c22:	8a2e                	mv	s4,a1
ffffffffc0204c24:	b5a1                	j	ffffffffc0204a6c <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0204c26:	9902                	jalr	s2
ffffffffc0204c28:	bf09                	j	ffffffffc0204b3a <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0204c2a:	85a6                	mv	a1,s1
ffffffffc0204c2c:	02d00513          	li	a0,45
ffffffffc0204c30:	e03e                	sd	a5,0(sp)
ffffffffc0204c32:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0204c34:	6782                	ld	a5,0(sp)
ffffffffc0204c36:	8a66                	mv	s4,s9
ffffffffc0204c38:	40800633          	neg	a2,s0
ffffffffc0204c3c:	46a9                	li	a3,10
ffffffffc0204c3e:	b53d                	j	ffffffffc0204a6c <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0204c40:	03b05163          	blez	s11,ffffffffc0204c62 <vprintfmt+0x34c>
ffffffffc0204c44:	02d00693          	li	a3,45
ffffffffc0204c48:	f6d79de3          	bne	a5,a3,ffffffffc0204bc2 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0204c4c:	00002417          	auipc	s0,0x2
ffffffffc0204c50:	2b440413          	addi	s0,s0,692 # ffffffffc0206f00 <syscalls+0x818>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204c54:	02800793          	li	a5,40
ffffffffc0204c58:	02800513          	li	a0,40
ffffffffc0204c5c:	00140a13          	addi	s4,s0,1
ffffffffc0204c60:	bd6d                	j	ffffffffc0204b1a <vprintfmt+0x204>
ffffffffc0204c62:	00002a17          	auipc	s4,0x2
ffffffffc0204c66:	29fa0a13          	addi	s4,s4,671 # ffffffffc0206f01 <syscalls+0x819>
ffffffffc0204c6a:	02800513          	li	a0,40
ffffffffc0204c6e:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204c72:	05e00413          	li	s0,94
ffffffffc0204c76:	b565                	j	ffffffffc0204b1e <vprintfmt+0x208>

ffffffffc0204c78 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c78:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0204c7a:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c7e:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0204c80:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c82:	ec06                	sd	ra,24(sp)
ffffffffc0204c84:	f83a                	sd	a4,48(sp)
ffffffffc0204c86:	fc3e                	sd	a5,56(sp)
ffffffffc0204c88:	e0c2                	sd	a6,64(sp)
ffffffffc0204c8a:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0204c8c:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0204c8e:	c89ff0ef          	jal	ra,ffffffffc0204916 <vprintfmt>
}
ffffffffc0204c92:	60e2                	ld	ra,24(sp)
ffffffffc0204c94:	6161                	addi	sp,sp,80
ffffffffc0204c96:	8082                	ret

ffffffffc0204c98 <hash32>:
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
ffffffffc0204c98:	9e3707b7          	lui	a5,0x9e370
ffffffffc0204c9c:	2785                	addiw	a5,a5,1
ffffffffc0204c9e:	02a7853b          	mulw	a0,a5,a0
    return (hash >> (32 - bits));
ffffffffc0204ca2:	02000793          	li	a5,32
ffffffffc0204ca6:	9f8d                	subw	a5,a5,a1
}
ffffffffc0204ca8:	00f5553b          	srlw	a0,a0,a5
ffffffffc0204cac:	8082                	ret


obj/__user_ex2.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <__panic>:
#include <stdio.h>
#include <ulib.h>
#include <error.h>

void
__panic(const char *file, int line, const char *fmt, ...) {
  800020:	715d                	addi	sp,sp,-80
  800022:	8e2e                	mv	t3,a1
  800024:	e822                	sd	s0,16(sp)
    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
    cprintf("user panic at %s:%d:\n    ", file, line);
  800026:	85aa                	mv	a1,a0
__panic(const char *file, int line, const char *fmt, ...) {
  800028:	8432                	mv	s0,a2
  80002a:	fc3e                	sd	a5,56(sp)
    cprintf("user panic at %s:%d:\n    ", file, line);
  80002c:	8672                	mv	a2,t3
    va_start(ap, fmt);
  80002e:	103c                	addi	a5,sp,40
    cprintf("user panic at %s:%d:\n    ", file, line);
  800030:	00000517          	auipc	a0,0x0
  800034:	6c050513          	addi	a0,a0,1728 # 8006f0 <main+0x14a>
__panic(const char *file, int line, const char *fmt, ...) {
  800038:	ec06                	sd	ra,24(sp)
  80003a:	f436                	sd	a3,40(sp)
  80003c:	f83a                	sd	a4,48(sp)
  80003e:	e0c2                	sd	a6,64(sp)
  800040:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  800042:	e43e                	sd	a5,8(sp)
    cprintf("user panic at %s:%d:\n    ", file, line);
  800044:	104000ef          	jal	ra,800148 <cprintf>
    vcprintf(fmt, ap);
  800048:	65a2                	ld	a1,8(sp)
  80004a:	8522                	mv	a0,s0
  80004c:	0dc000ef          	jal	ra,800128 <vcprintf>
    cprintf("\n");
  800050:	00000517          	auipc	a0,0x0
  800054:	6c050513          	addi	a0,a0,1728 # 800710 <main+0x16a>
  800058:	0f0000ef          	jal	ra,800148 <cprintf>
    va_end(ap);
    exit(-E_PANIC);
  80005c:	5559                	li	a0,-10
  80005e:	06a000ef          	jal	ra,8000c8 <exit>

0000000000800062 <syscall>:
#include <syscall.h>

#define MAX_ARGS            5

static inline int
syscall(int64_t num, ...) {
  800062:	7175                	addi	sp,sp,-144
  800064:	f8ba                	sd	a4,112(sp)
    va_list ap;
    va_start(ap, num);
    uint64_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, uint64_t);
  800066:	e0ba                	sd	a4,64(sp)
  800068:	0118                	addi	a4,sp,128
syscall(int64_t num, ...) {
  80006a:	e42a                	sd	a0,8(sp)
  80006c:	ecae                	sd	a1,88(sp)
  80006e:	f0b2                	sd	a2,96(sp)
  800070:	f4b6                	sd	a3,104(sp)
  800072:	fcbe                	sd	a5,120(sp)
  800074:	e142                	sd	a6,128(sp)
  800076:	e546                	sd	a7,136(sp)
        a[i] = va_arg(ap, uint64_t);
  800078:	f42e                	sd	a1,40(sp)
  80007a:	f832                	sd	a2,48(sp)
  80007c:	fc36                	sd	a3,56(sp)
  80007e:	f03a                	sd	a4,32(sp)
  800080:	e4be                	sd	a5,72(sp)
    }
    va_end(ap);
    asm volatile (
  800082:	4522                	lw	a0,8(sp)
  800084:	55a2                	lw	a1,40(sp)
  800086:	5642                	lw	a2,48(sp)
  800088:	56e2                	lw	a3,56(sp)
  80008a:	4706                	lw	a4,64(sp)
  80008c:	47a6                	lw	a5,72(sp)
  80008e:	00000073          	ecall
  800092:	ce2a                	sw	a0,28(sp)
          "m" (a[3]),
          "m" (a[4])
        : "memory"
      );
    return ret;
}
  800094:	4572                	lw	a0,28(sp)
  800096:	6149                	addi	sp,sp,144
  800098:	8082                	ret

000000000080009a <sys_exit>:

int
sys_exit(int64_t error_code) {
  80009a:	85aa                	mv	a1,a0
    return syscall(SYS_exit, error_code);
  80009c:	4505                	li	a0,1
  80009e:	b7d1                	j	800062 <syscall>

00000000008000a0 <sys_fork>:
}

int
sys_fork(void) {
    return syscall(SYS_fork);
  8000a0:	4509                	li	a0,2
  8000a2:	b7c1                	j	800062 <syscall>

00000000008000a4 <sys_wait>:
}

int
sys_wait(int64_t pid, int *store) {
  8000a4:	862e                	mv	a2,a1
    return syscall(SYS_wait, pid, store);
  8000a6:	85aa                	mv	a1,a0
  8000a8:	450d                	li	a0,3
  8000aa:	bf65                	j	800062 <syscall>

00000000008000ac <sys_kill>:
sys_yield(void) {
    return syscall(SYS_yield);
}

int
sys_kill(int64_t pid) {
  8000ac:	85aa                	mv	a1,a0
    return syscall(SYS_kill, pid);
  8000ae:	4531                	li	a0,12
  8000b0:	bf4d                	j	800062 <syscall>

00000000008000b2 <sys_getpid>:
}

int
sys_getpid(void) {
    return syscall(SYS_getpid);
  8000b2:	4549                	li	a0,18
  8000b4:	b77d                	j	800062 <syscall>

00000000008000b6 <sys_putc>:
}

int
sys_putc(int64_t c) {
  8000b6:	85aa                	mv	a1,a0
    return syscall(SYS_putc, c);
  8000b8:	4579                	li	a0,30
  8000ba:	b765                	j	800062 <syscall>

00000000008000bc <sys_gettime>:
}

int
sys_gettime(void) {
    return syscall(SYS_gettime);
  8000bc:	4545                	li	a0,17
  8000be:	b755                	j	800062 <syscall>

00000000008000c0 <sys_labschedule_set_priority>:
}

int
sys_labschedule_set_priority(int pr) {
  8000c0:	85aa                	mv	a1,a0
    return syscall(SYS_labschedule_set_priority, pr);
  8000c2:	0ff00513          	li	a0,255
  8000c6:	bf71                	j	800062 <syscall>

00000000008000c8 <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  8000c8:	1141                	addi	sp,sp,-16
  8000ca:	e406                	sd	ra,8(sp)
    //cprintf("eee\n");
    sys_exit(error_code);
  8000cc:	fcfff0ef          	jal	ra,80009a <sys_exit>
    cprintf("BUG: exit failed.\n");
  8000d0:	00000517          	auipc	a0,0x0
  8000d4:	64850513          	addi	a0,a0,1608 # 800718 <main+0x172>
  8000d8:	070000ef          	jal	ra,800148 <cprintf>
    while (1);
  8000dc:	a001                	j	8000dc <exit+0x14>

00000000008000de <fork>:
}

int
fork(void) {
    return sys_fork();
  8000de:	b7c9                	j	8000a0 <sys_fork>

00000000008000e0 <waitpid>:
    return sys_wait(0, NULL);
}

int
waitpid(int pid, int *store) {
    return sys_wait(pid, store);
  8000e0:	b7d1                	j	8000a4 <sys_wait>

00000000008000e2 <kill>:
    sys_yield();
}

int
kill(int pid) {
    return sys_kill(pid);
  8000e2:	b7e9                	j	8000ac <sys_kill>

00000000008000e4 <getpid>:
}

int
getpid(void) {
    return sys_getpid();
  8000e4:	b7f9                	j	8000b2 <sys_getpid>

00000000008000e6 <gettime_msec>:
}

unsigned int
gettime_msec(void) {
    return (unsigned int)sys_gettime();
  8000e6:	bfd9                	j	8000bc <sys_gettime>

00000000008000e8 <set_priority>:
}

unsigned int
set_priority(int pr){
  8000e8:	1141                	addi	sp,sp,-16
  8000ea:	e022                	sd	s0,0(sp)
	cprintf("set priority to %d\n", pr);
  8000ec:	85aa                	mv	a1,a0
set_priority(int pr){
  8000ee:	842a                	mv	s0,a0
	cprintf("set priority to %d\n", pr);
  8000f0:	00000517          	auipc	a0,0x0
  8000f4:	64050513          	addi	a0,a0,1600 # 800730 <main+0x18a>
set_priority(int pr){
  8000f8:	e406                	sd	ra,8(sp)
	cprintf("set priority to %d\n", pr);
  8000fa:	04e000ef          	jal	ra,800148 <cprintf>
    return (unsigned int) sys_labschedule_set_priority(pr);
  8000fe:	8522                	mv	a0,s0
}
  800100:	6402                	ld	s0,0(sp)
  800102:	60a2                	ld	ra,8(sp)
  800104:	0141                	addi	sp,sp,16
    return (unsigned int) sys_labschedule_set_priority(pr);
  800106:	bf6d                	j	8000c0 <sys_labschedule_set_priority>

0000000000800108 <_start>:
    # move down the esp register
    # since it may cause page fault in backtrace
    // subl $0x20, %esp

    # call user-program function
    call umain
  800108:	076000ef          	jal	ra,80017e <umain>
1:  j 1b
  80010c:	a001                	j	80010c <_start+0x4>

000000000080010e <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  80010e:	1141                	addi	sp,sp,-16
  800110:	e022                	sd	s0,0(sp)
  800112:	e406                	sd	ra,8(sp)
  800114:	842e                	mv	s0,a1
    sys_putc(c);
  800116:	fa1ff0ef          	jal	ra,8000b6 <sys_putc>
    (*cnt) ++;
  80011a:	401c                	lw	a5,0(s0)
}
  80011c:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
  80011e:	2785                	addiw	a5,a5,1
  800120:	c01c                	sw	a5,0(s0)
}
  800122:	6402                	ld	s0,0(sp)
  800124:	0141                	addi	sp,sp,16
  800126:	8082                	ret

0000000000800128 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  800128:	1101                	addi	sp,sp,-32
  80012a:	862a                	mv	a2,a0
  80012c:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80012e:	00000517          	auipc	a0,0x0
  800132:	fe050513          	addi	a0,a0,-32 # 80010e <cputch>
  800136:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
  800138:	ec06                	sd	ra,24(sp)
    int cnt = 0;
  80013a:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80013c:	0e8000ef          	jal	ra,800224 <vprintfmt>
    return cnt;
}
  800140:	60e2                	ld	ra,24(sp)
  800142:	4532                	lw	a0,12(sp)
  800144:	6105                	addi	sp,sp,32
  800146:	8082                	ret

0000000000800148 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  800148:	711d                	addi	sp,sp,-96
    va_list ap;

    va_start(ap, fmt);
  80014a:	02810313          	addi	t1,sp,40
cprintf(const char *fmt, ...) {
  80014e:	8e2a                	mv	t3,a0
  800150:	f42e                	sd	a1,40(sp)
  800152:	f832                	sd	a2,48(sp)
  800154:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800156:	00000517          	auipc	a0,0x0
  80015a:	fb850513          	addi	a0,a0,-72 # 80010e <cputch>
  80015e:	004c                	addi	a1,sp,4
  800160:	869a                	mv	a3,t1
  800162:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
  800164:	ec06                	sd	ra,24(sp)
  800166:	e0ba                	sd	a4,64(sp)
  800168:	e4be                	sd	a5,72(sp)
  80016a:	e8c2                	sd	a6,80(sp)
  80016c:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  80016e:	e41a                	sd	t1,8(sp)
    int cnt = 0;
  800170:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800172:	0b2000ef          	jal	ra,800224 <vprintfmt>
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}
  800176:	60e2                	ld	ra,24(sp)
  800178:	4512                	lw	a0,4(sp)
  80017a:	6125                	addi	sp,sp,96
  80017c:	8082                	ret

000000000080017e <umain>:
#include <ulib.h>

int main(void);

void
umain(void) {
  80017e:	1141                	addi	sp,sp,-16
  800180:	e406                	sd	ra,8(sp)
    int ret = main();
  800182:	424000ef          	jal	ra,8005a6 <main>
    exit(ret);
  800186:	f43ff0ef          	jal	ra,8000c8 <exit>

000000000080018a <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  80018a:	872a                	mv	a4,a0
    size_t cnt = 0;
  80018c:	4501                	li	a0,0
    while (cnt < len && *s ++ != '\0') {
  80018e:	e589                	bnez	a1,800198 <strnlen+0xe>
  800190:	a811                	j	8001a4 <strnlen+0x1a>
        cnt ++;
  800192:	0505                	addi	a0,a0,1
    while (cnt < len && *s ++ != '\0') {
  800194:	00a58763          	beq	a1,a0,8001a2 <strnlen+0x18>
  800198:	00a707b3          	add	a5,a4,a0
  80019c:	0007c783          	lbu	a5,0(a5)
  8001a0:	fbed                	bnez	a5,800192 <strnlen+0x8>
    }
    return cnt;
}
  8001a2:	8082                	ret
  8001a4:	8082                	ret

00000000008001a6 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
  8001a6:	ca01                	beqz	a2,8001b6 <memset+0x10>
  8001a8:	962a                	add	a2,a2,a0
    char *p = s;
  8001aa:	87aa                	mv	a5,a0
        *p ++ = c;
  8001ac:	0785                	addi	a5,a5,1
  8001ae:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
  8001b2:	fec79de3          	bne	a5,a2,8001ac <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  8001b6:	8082                	ret

00000000008001b8 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  8001b8:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  8001bc:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  8001be:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  8001c2:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  8001c4:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  8001c8:	f022                	sd	s0,32(sp)
  8001ca:	ec26                	sd	s1,24(sp)
  8001cc:	e84a                	sd	s2,16(sp)
  8001ce:	f406                	sd	ra,40(sp)
  8001d0:	e44e                	sd	s3,8(sp)
  8001d2:	84aa                	mv	s1,a0
  8001d4:	892e                	mv	s2,a1
  8001d6:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  8001da:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  8001dc:	03067e63          	bgeu	a2,a6,800218 <printnum+0x60>
  8001e0:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  8001e2:	00805763          	blez	s0,8001f0 <printnum+0x38>
  8001e6:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  8001e8:	85ca                	mv	a1,s2
  8001ea:	854e                	mv	a0,s3
  8001ec:	9482                	jalr	s1
        while (-- width > 0)
  8001ee:	fc65                	bnez	s0,8001e6 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  8001f0:	1a02                	slli	s4,s4,0x20
  8001f2:	020a5a13          	srli	s4,s4,0x20
  8001f6:	00000797          	auipc	a5,0x0
  8001fa:	55278793          	addi	a5,a5,1362 # 800748 <main+0x1a2>
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  8001fe:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  800200:	9a3e                	add	s4,s4,a5
  800202:	000a4503          	lbu	a0,0(s4)
}
  800206:	70a2                	ld	ra,40(sp)
  800208:	69a2                	ld	s3,8(sp)
  80020a:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  80020c:	85ca                	mv	a1,s2
  80020e:	8326                	mv	t1,s1
}
  800210:	6942                	ld	s2,16(sp)
  800212:	64e2                	ld	s1,24(sp)
  800214:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  800216:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
  800218:	03065633          	divu	a2,a2,a6
  80021c:	8722                	mv	a4,s0
  80021e:	f9bff0ef          	jal	ra,8001b8 <printnum>
  800222:	b7f9                	j	8001f0 <printnum+0x38>

0000000000800224 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  800224:	7119                	addi	sp,sp,-128
  800226:	f4a6                	sd	s1,104(sp)
  800228:	f0ca                	sd	s2,96(sp)
  80022a:	ecce                	sd	s3,88(sp)
  80022c:	e8d2                	sd	s4,80(sp)
  80022e:	e4d6                	sd	s5,72(sp)
  800230:	e0da                	sd	s6,64(sp)
  800232:	fc5e                	sd	s7,56(sp)
  800234:	f06a                	sd	s10,32(sp)
  800236:	fc86                	sd	ra,120(sp)
  800238:	f8a2                	sd	s0,112(sp)
  80023a:	f862                	sd	s8,48(sp)
  80023c:	f466                	sd	s9,40(sp)
  80023e:	ec6e                	sd	s11,24(sp)
  800240:	892a                	mv	s2,a0
  800242:	84ae                	mv	s1,a1
  800244:	8d32                	mv	s10,a2
  800246:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800248:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  80024c:	5b7d                	li	s6,-1
  80024e:	00000a97          	auipc	s5,0x0
  800252:	52ea8a93          	addi	s5,s5,1326 # 80077c <main+0x1d6>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800256:	00000b97          	auipc	s7,0x0
  80025a:	742b8b93          	addi	s7,s7,1858 # 800998 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80025e:	000d4503          	lbu	a0,0(s10)
  800262:	001d0413          	addi	s0,s10,1
  800266:	01350a63          	beq	a0,s3,80027a <vprintfmt+0x56>
            if (ch == '\0') {
  80026a:	c121                	beqz	a0,8002aa <vprintfmt+0x86>
            putch(ch, putdat);
  80026c:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80026e:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  800270:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800272:	fff44503          	lbu	a0,-1(s0)
  800276:	ff351ae3          	bne	a0,s3,80026a <vprintfmt+0x46>
  80027a:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  80027e:	02000793          	li	a5,32
        lflag = altflag = 0;
  800282:	4c81                	li	s9,0
  800284:	4881                	li	a7,0
        width = precision = -1;
  800286:	5c7d                	li	s8,-1
  800288:	5dfd                	li	s11,-1
  80028a:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  80028e:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  800290:	fdd6059b          	addiw	a1,a2,-35
  800294:	0ff5f593          	andi	a1,a1,255
  800298:	00140d13          	addi	s10,s0,1
  80029c:	04b56263          	bltu	a0,a1,8002e0 <vprintfmt+0xbc>
  8002a0:	058a                	slli	a1,a1,0x2
  8002a2:	95d6                	add	a1,a1,s5
  8002a4:	4194                	lw	a3,0(a1)
  8002a6:	96d6                	add	a3,a3,s5
  8002a8:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  8002aa:	70e6                	ld	ra,120(sp)
  8002ac:	7446                	ld	s0,112(sp)
  8002ae:	74a6                	ld	s1,104(sp)
  8002b0:	7906                	ld	s2,96(sp)
  8002b2:	69e6                	ld	s3,88(sp)
  8002b4:	6a46                	ld	s4,80(sp)
  8002b6:	6aa6                	ld	s5,72(sp)
  8002b8:	6b06                	ld	s6,64(sp)
  8002ba:	7be2                	ld	s7,56(sp)
  8002bc:	7c42                	ld	s8,48(sp)
  8002be:	7ca2                	ld	s9,40(sp)
  8002c0:	7d02                	ld	s10,32(sp)
  8002c2:	6de2                	ld	s11,24(sp)
  8002c4:	6109                	addi	sp,sp,128
  8002c6:	8082                	ret
            padc = '0';
  8002c8:	87b2                	mv	a5,a2
            goto reswitch;
  8002ca:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  8002ce:	846a                	mv	s0,s10
  8002d0:	00140d13          	addi	s10,s0,1
  8002d4:	fdd6059b          	addiw	a1,a2,-35
  8002d8:	0ff5f593          	andi	a1,a1,255
  8002dc:	fcb572e3          	bgeu	a0,a1,8002a0 <vprintfmt+0x7c>
            putch('%', putdat);
  8002e0:	85a6                	mv	a1,s1
  8002e2:	02500513          	li	a0,37
  8002e6:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  8002e8:	fff44783          	lbu	a5,-1(s0)
  8002ec:	8d22                	mv	s10,s0
  8002ee:	f73788e3          	beq	a5,s3,80025e <vprintfmt+0x3a>
  8002f2:	ffed4783          	lbu	a5,-2(s10)
  8002f6:	1d7d                	addi	s10,s10,-1
  8002f8:	ff379de3          	bne	a5,s3,8002f2 <vprintfmt+0xce>
  8002fc:	b78d                	j	80025e <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  8002fe:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  800302:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  800306:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  800308:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  80030c:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  800310:	02d86463          	bltu	a6,a3,800338 <vprintfmt+0x114>
                ch = *fmt;
  800314:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  800318:	002c169b          	slliw	a3,s8,0x2
  80031c:	0186873b          	addw	a4,a3,s8
  800320:	0017171b          	slliw	a4,a4,0x1
  800324:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  800326:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  80032a:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  80032c:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  800330:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  800334:	fed870e3          	bgeu	a6,a3,800314 <vprintfmt+0xf0>
            if (width < 0)
  800338:	f40ddce3          	bgez	s11,800290 <vprintfmt+0x6c>
                width = precision, precision = -1;
  80033c:	8de2                	mv	s11,s8
  80033e:	5c7d                	li	s8,-1
  800340:	bf81                	j	800290 <vprintfmt+0x6c>
            if (width < 0)
  800342:	fffdc693          	not	a3,s11
  800346:	96fd                	srai	a3,a3,0x3f
  800348:	00ddfdb3          	and	s11,s11,a3
  80034c:	00144603          	lbu	a2,1(s0)
  800350:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
  800352:	846a                	mv	s0,s10
            goto reswitch;
  800354:	bf35                	j	800290 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  800356:	000a2c03          	lw	s8,0(s4)
            goto process_precision;
  80035a:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  80035e:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  800360:	846a                	mv	s0,s10
            goto process_precision;
  800362:	bfd9                	j	800338 <vprintfmt+0x114>
    if (lflag >= 2) {
  800364:	4705                	li	a4,1
  800366:	008a0593          	addi	a1,s4,8
  80036a:	01174463          	blt	a4,a7,800372 <vprintfmt+0x14e>
    else if (lflag) {
  80036e:	1a088e63          	beqz	a7,80052a <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  800372:	000a3603          	ld	a2,0(s4)
  800376:	46c1                	li	a3,16
  800378:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  80037a:	2781                	sext.w	a5,a5
  80037c:	876e                	mv	a4,s11
  80037e:	85a6                	mv	a1,s1
  800380:	854a                	mv	a0,s2
  800382:	e37ff0ef          	jal	ra,8001b8 <printnum>
            break;
  800386:	bde1                	j	80025e <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  800388:	000a2503          	lw	a0,0(s4)
  80038c:	85a6                	mv	a1,s1
  80038e:	0a21                	addi	s4,s4,8
  800390:	9902                	jalr	s2
            break;
  800392:	b5f1                	j	80025e <vprintfmt+0x3a>
    if (lflag >= 2) {
  800394:	4705                	li	a4,1
  800396:	008a0593          	addi	a1,s4,8
  80039a:	01174463          	blt	a4,a7,8003a2 <vprintfmt+0x17e>
    else if (lflag) {
  80039e:	18088163          	beqz	a7,800520 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  8003a2:	000a3603          	ld	a2,0(s4)
  8003a6:	46a9                	li	a3,10
  8003a8:	8a2e                	mv	s4,a1
  8003aa:	bfc1                	j	80037a <vprintfmt+0x156>
            goto reswitch;
  8003ac:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  8003b0:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  8003b2:	846a                	mv	s0,s10
            goto reswitch;
  8003b4:	bdf1                	j	800290 <vprintfmt+0x6c>
            putch(ch, putdat);
  8003b6:	85a6                	mv	a1,s1
  8003b8:	02500513          	li	a0,37
  8003bc:	9902                	jalr	s2
            break;
  8003be:	b545                	j	80025e <vprintfmt+0x3a>
            lflag ++;
  8003c0:	00144603          	lbu	a2,1(s0)
  8003c4:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  8003c6:	846a                	mv	s0,s10
            goto reswitch;
  8003c8:	b5e1                	j	800290 <vprintfmt+0x6c>
    if (lflag >= 2) {
  8003ca:	4705                	li	a4,1
  8003cc:	008a0593          	addi	a1,s4,8
  8003d0:	01174463          	blt	a4,a7,8003d8 <vprintfmt+0x1b4>
    else if (lflag) {
  8003d4:	14088163          	beqz	a7,800516 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  8003d8:	000a3603          	ld	a2,0(s4)
  8003dc:	46a1                	li	a3,8
  8003de:	8a2e                	mv	s4,a1
  8003e0:	bf69                	j	80037a <vprintfmt+0x156>
            putch('0', putdat);
  8003e2:	03000513          	li	a0,48
  8003e6:	85a6                	mv	a1,s1
  8003e8:	e03e                	sd	a5,0(sp)
  8003ea:	9902                	jalr	s2
            putch('x', putdat);
  8003ec:	85a6                	mv	a1,s1
  8003ee:	07800513          	li	a0,120
  8003f2:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003f4:	0a21                	addi	s4,s4,8
            goto number;
  8003f6:	6782                	ld	a5,0(sp)
  8003f8:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003fa:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  8003fe:	bfb5                	j	80037a <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  800400:	000a3403          	ld	s0,0(s4)
  800404:	008a0713          	addi	a4,s4,8
  800408:	e03a                	sd	a4,0(sp)
  80040a:	14040263          	beqz	s0,80054e <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  80040e:	0fb05763          	blez	s11,8004fc <vprintfmt+0x2d8>
  800412:	02d00693          	li	a3,45
  800416:	0cd79163          	bne	a5,a3,8004d8 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  80041a:	00044783          	lbu	a5,0(s0)
  80041e:	0007851b          	sext.w	a0,a5
  800422:	cf85                	beqz	a5,80045a <vprintfmt+0x236>
  800424:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  800428:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  80042c:	000c4563          	bltz	s8,800436 <vprintfmt+0x212>
  800430:	3c7d                	addiw	s8,s8,-1
  800432:	036c0263          	beq	s8,s6,800456 <vprintfmt+0x232>
                    putch('?', putdat);
  800436:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  800438:	0e0c8e63          	beqz	s9,800534 <vprintfmt+0x310>
  80043c:	3781                	addiw	a5,a5,-32
  80043e:	0ef47b63          	bgeu	s0,a5,800534 <vprintfmt+0x310>
                    putch('?', putdat);
  800442:	03f00513          	li	a0,63
  800446:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800448:	000a4783          	lbu	a5,0(s4)
  80044c:	3dfd                	addiw	s11,s11,-1
  80044e:	0a05                	addi	s4,s4,1
  800450:	0007851b          	sext.w	a0,a5
  800454:	ffe1                	bnez	a5,80042c <vprintfmt+0x208>
            for (; width > 0; width --) {
  800456:	01b05963          	blez	s11,800468 <vprintfmt+0x244>
  80045a:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  80045c:	85a6                	mv	a1,s1
  80045e:	02000513          	li	a0,32
  800462:	9902                	jalr	s2
            for (; width > 0; width --) {
  800464:	fe0d9be3          	bnez	s11,80045a <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  800468:	6a02                	ld	s4,0(sp)
  80046a:	bbd5                	j	80025e <vprintfmt+0x3a>
    if (lflag >= 2) {
  80046c:	4705                	li	a4,1
  80046e:	008a0c93          	addi	s9,s4,8
  800472:	01174463          	blt	a4,a7,80047a <vprintfmt+0x256>
    else if (lflag) {
  800476:	08088d63          	beqz	a7,800510 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  80047a:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  80047e:	0a044d63          	bltz	s0,800538 <vprintfmt+0x314>
            num = getint(&ap, lflag);
  800482:	8622                	mv	a2,s0
  800484:	8a66                	mv	s4,s9
  800486:	46a9                	li	a3,10
  800488:	bdcd                	j	80037a <vprintfmt+0x156>
            err = va_arg(ap, int);
  80048a:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  80048e:	4761                	li	a4,24
            err = va_arg(ap, int);
  800490:	0a21                	addi	s4,s4,8
            if (err < 0) {
  800492:	41f7d69b          	sraiw	a3,a5,0x1f
  800496:	8fb5                	xor	a5,a5,a3
  800498:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  80049c:	02d74163          	blt	a4,a3,8004be <vprintfmt+0x29a>
  8004a0:	00369793          	slli	a5,a3,0x3
  8004a4:	97de                	add	a5,a5,s7
  8004a6:	639c                	ld	a5,0(a5)
  8004a8:	cb99                	beqz	a5,8004be <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  8004aa:	86be                	mv	a3,a5
  8004ac:	00000617          	auipc	a2,0x0
  8004b0:	2cc60613          	addi	a2,a2,716 # 800778 <main+0x1d2>
  8004b4:	85a6                	mv	a1,s1
  8004b6:	854a                	mv	a0,s2
  8004b8:	0ce000ef          	jal	ra,800586 <printfmt>
  8004bc:	b34d                	j	80025e <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  8004be:	00000617          	auipc	a2,0x0
  8004c2:	2aa60613          	addi	a2,a2,682 # 800768 <main+0x1c2>
  8004c6:	85a6                	mv	a1,s1
  8004c8:	854a                	mv	a0,s2
  8004ca:	0bc000ef          	jal	ra,800586 <printfmt>
  8004ce:	bb41                	j	80025e <vprintfmt+0x3a>
                p = "(null)";
  8004d0:	00000417          	auipc	s0,0x0
  8004d4:	29040413          	addi	s0,s0,656 # 800760 <main+0x1ba>
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004d8:	85e2                	mv	a1,s8
  8004da:	8522                	mv	a0,s0
  8004dc:	e43e                	sd	a5,8(sp)
  8004de:	cadff0ef          	jal	ra,80018a <strnlen>
  8004e2:	40ad8dbb          	subw	s11,s11,a0
  8004e6:	01b05b63          	blez	s11,8004fc <vprintfmt+0x2d8>
  8004ea:	67a2                	ld	a5,8(sp)
  8004ec:	00078a1b          	sext.w	s4,a5
  8004f0:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  8004f2:	85a6                	mv	a1,s1
  8004f4:	8552                	mv	a0,s4
  8004f6:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004f8:	fe0d9ce3          	bnez	s11,8004f0 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004fc:	00044783          	lbu	a5,0(s0)
  800500:	00140a13          	addi	s4,s0,1
  800504:	0007851b          	sext.w	a0,a5
  800508:	d3a5                	beqz	a5,800468 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  80050a:	05e00413          	li	s0,94
  80050e:	bf39                	j	80042c <vprintfmt+0x208>
        return va_arg(*ap, int);
  800510:	000a2403          	lw	s0,0(s4)
  800514:	b7ad                	j	80047e <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  800516:	000a6603          	lwu	a2,0(s4)
  80051a:	46a1                	li	a3,8
  80051c:	8a2e                	mv	s4,a1
  80051e:	bdb1                	j	80037a <vprintfmt+0x156>
  800520:	000a6603          	lwu	a2,0(s4)
  800524:	46a9                	li	a3,10
  800526:	8a2e                	mv	s4,a1
  800528:	bd89                	j	80037a <vprintfmt+0x156>
  80052a:	000a6603          	lwu	a2,0(s4)
  80052e:	46c1                	li	a3,16
  800530:	8a2e                	mv	s4,a1
  800532:	b5a1                	j	80037a <vprintfmt+0x156>
                    putch(ch, putdat);
  800534:	9902                	jalr	s2
  800536:	bf09                	j	800448 <vprintfmt+0x224>
                putch('-', putdat);
  800538:	85a6                	mv	a1,s1
  80053a:	02d00513          	li	a0,45
  80053e:	e03e                	sd	a5,0(sp)
  800540:	9902                	jalr	s2
                num = -(long long)num;
  800542:	6782                	ld	a5,0(sp)
  800544:	8a66                	mv	s4,s9
  800546:	40800633          	neg	a2,s0
  80054a:	46a9                	li	a3,10
  80054c:	b53d                	j	80037a <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  80054e:	03b05163          	blez	s11,800570 <vprintfmt+0x34c>
  800552:	02d00693          	li	a3,45
  800556:	f6d79de3          	bne	a5,a3,8004d0 <vprintfmt+0x2ac>
                p = "(null)";
  80055a:	00000417          	auipc	s0,0x0
  80055e:	20640413          	addi	s0,s0,518 # 800760 <main+0x1ba>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800562:	02800793          	li	a5,40
  800566:	02800513          	li	a0,40
  80056a:	00140a13          	addi	s4,s0,1
  80056e:	bd6d                	j	800428 <vprintfmt+0x204>
  800570:	00000a17          	auipc	s4,0x0
  800574:	1f1a0a13          	addi	s4,s4,497 # 800761 <main+0x1bb>
  800578:	02800513          	li	a0,40
  80057c:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  800580:	05e00413          	li	s0,94
  800584:	b565                	j	80042c <vprintfmt+0x208>

0000000000800586 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800586:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  800588:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  80058c:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  80058e:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800590:	ec06                	sd	ra,24(sp)
  800592:	f83a                	sd	a4,48(sp)
  800594:	fc3e                	sd	a5,56(sp)
  800596:	e0c2                	sd	a6,64(sp)
  800598:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  80059a:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  80059c:	c89ff0ef          	jal	ra,800224 <vprintfmt>
}
  8005a0:	60e2                	ld	ra,24(sp)
  8005a2:	6161                	addi	sp,sp,80
  8005a4:	8082                	ret

00000000008005a6 <main>:




int
main(void) {
  8005a6:	711d                	addi	sp,sp,-96
     //open this!
     
     int i,time;
     memset(pids, 0, sizeof(pids));
  8005a8:	4651                	li	a2,20
  8005aa:	4581                	li	a1,0
  8005ac:	00001517          	auipc	a0,0x1
  8005b0:	a8450513          	addi	a0,a0,-1404 # 801030 <pids>
main(void) {
  8005b4:	e8a2                	sd	s0,80(sp)
  8005b6:	e4a6                	sd	s1,72(sp)
  8005b8:	e0ca                	sd	s2,64(sp)
  8005ba:	fc4e                	sd	s3,56(sp)
  8005bc:	f852                	sd	s4,48(sp)
  8005be:	f456                	sd	s5,40(sp)
  8005c0:	ec86                	sd	ra,88(sp)
     memset(pids, 0, sizeof(pids));
  8005c2:	be5ff0ef          	jal	ra,8001a6 <memset>
     int prior[TOTAL]= {3,1,4,5,2};
  8005c6:	4795                	li	a5,5
  8005c8:	4705                	li	a4,1
  8005ca:	1782                	slli	a5,a5,0x20
  8005cc:	0791                	addi	a5,a5,4
  8005ce:	1702                	slli	a4,a4,0x20
  8005d0:	00001a17          	auipc	s4,0x1
  8005d4:	a30a0a13          	addi	s4,s4,-1488 # 801000 <acc>
  8005d8:	00001497          	auipc	s1,0x1
  8005dc:	a5848493          	addi	s1,s1,-1448 # 801030 <pids>
  8005e0:	070d                	addi	a4,a4,3
  8005e2:	e83e                	sd	a5,16(sp)
  8005e4:	4789                	li	a5,2
  8005e6:	e43a                	sd	a4,8(sp)
  8005e8:	cc3e                	sw	a5,24(sp)
     for (i = 0; i < TOTAL; i ++) {
  8005ea:	89d2                	mv	s3,s4
     int prior[TOTAL]= {3,1,4,5,2};
  8005ec:	8926                	mv	s2,s1
     for (i = 0; i < TOTAL; i ++) {
  8005ee:	4401                	li	s0,0
  8005f0:	4a95                	li	s5,5
          acc[i]=0;
  8005f2:	0009a023          	sw	zero,0(s3)
          if ((pids[i] = fork()) == 0) {
  8005f6:	ae9ff0ef          	jal	ra,8000de <fork>
  8005fa:	00a92023          	sw	a0,0(s2)
  8005fe:	c125                	beqz	a0,80065e <main+0xb8>
                         exit(acc[i]);
                    }

               }
          }
          if (pids[i] < 0) {
  800600:	0a054d63          	bltz	a0,8006ba <main+0x114>
     for (i = 0; i < TOTAL; i ++) {
  800604:	2405                	addiw	s0,s0,1
  800606:	0991                	addi	s3,s3,4
  800608:	0911                	addi	s2,s2,4
  80060a:	ff5414e3          	bne	s0,s5,8005f2 <main+0x4c>
               goto failed;
          }
     }

     cprintf("main: fork ok,now need to wait pids.\n");
  80060e:	00000517          	auipc	a0,0x0
  800612:	47250513          	addi	a0,a0,1138 # 800a80 <error_string+0xe8>
  800616:	b33ff0ef          	jal	ra,800148 <cprintf>

     for (i = 0; i < TOTAL; i ++) {
  80061a:	00001417          	auipc	s0,0x1
  80061e:	9fe40413          	addi	s0,s0,-1538 # 801018 <status>
  800622:	00001917          	auipc	s2,0x1
  800626:	a0a90913          	addi	s2,s2,-1526 # 80102c <status+0x14>
         status[i]=0;
         waitpid(pids[i],&status[i]);
  80062a:	4088                	lw	a0,0(s1)
         status[i]=0;
  80062c:	00042023          	sw	zero,0(s0)
         waitpid(pids[i],&status[i]);
  800630:	85a2                	mv	a1,s0
  800632:	0411                	addi	s0,s0,4
  800634:	aadff0ef          	jal	ra,8000e0 <waitpid>
     for (i = 0; i < TOTAL; i ++) {
  800638:	0491                	addi	s1,s1,4
  80063a:	ff2418e3          	bne	s0,s2,80062a <main+0x84>
     }
     cprintf("main: wait pids over\n");
  80063e:	00000517          	auipc	a0,0x0
  800642:	46a50513          	addi	a0,a0,1130 # 800aa8 <error_string+0x110>
  800646:	b03ff0ef          	jal	ra,800148 <cprintf>
               kill(pids[i]);
          }
     }
     panic("FAIL: T.T\n");
    
}
  80064a:	60e6                	ld	ra,88(sp)
  80064c:	6446                	ld	s0,80(sp)
  80064e:	64a6                	ld	s1,72(sp)
  800650:	6906                	ld	s2,64(sp)
  800652:	79e2                	ld	s3,56(sp)
  800654:	7a42                	ld	s4,48(sp)
  800656:	7aa2                	ld	s5,40(sp)
  800658:	4501                	li	a0,0
  80065a:	6125                	addi	sp,sp,96
  80065c:	8082                	ret
               set_priority(prior[i]);
  80065e:	040a                	slli	s0,s0,0x2
  800660:	101c                	addi	a5,sp,32
  800662:	97a2                	add	a5,a5,s0
  800664:	fe87a503          	lw	a0,-24(a5)
  800668:	a81ff0ef          	jal	ra,8000e8 <set_priority>
  80066c:	003d16b7          	lui	a3,0x3d1
  800670:	90168693          	addi	a3,a3,-1791 # 3d0901 <__panic-0x42f71f>
  800674:	0c800713          	li	a4,200
          j = !j;
  800678:	4792                	lw	a5,4(sp)
  80067a:	377d                	addiw	a4,a4,-1
  80067c:	2781                	sext.w	a5,a5
  80067e:	0017b793          	seqz	a5,a5
  800682:	c23e                	sw	a5,4(sp)
     for (i = 0; i != 200; ++ i)
  800684:	fb75                	bnez	a4,800678 <main+0xd2>
                    if(acc[i]>4000000) {
  800686:	36fd                	addiw	a3,a3,-1
  800688:	f6f5                	bnez	a3,800674 <main+0xce>
  80068a:	003d17b7          	lui	a5,0x3d1
  80068e:	9017879b          	addiw	a5,a5,-1791
  800692:	9452                	add	s0,s0,s4
  800694:	c01c                	sw	a5,0(s0)
                         time=gettime_msec();
  800696:	a51ff0ef          	jal	ra,8000e6 <gettime_msec>
  80069a:	0005049b          	sext.w	s1,a0
                         cprintf("child pid %d, acc %d, time %d\n",getpid(),acc[i],time);
  80069e:	a47ff0ef          	jal	ra,8000e4 <getpid>
  8006a2:	4010                	lw	a2,0(s0)
  8006a4:	85aa                	mv	a1,a0
  8006a6:	86a6                	mv	a3,s1
  8006a8:	00000517          	auipc	a0,0x0
  8006ac:	3b850513          	addi	a0,a0,952 # 800a60 <error_string+0xc8>
  8006b0:	a99ff0ef          	jal	ra,800148 <cprintf>
                         exit(acc[i]);
  8006b4:	4008                	lw	a0,0(s0)
  8006b6:	a13ff0ef          	jal	ra,8000c8 <exit>
  8006ba:	00001417          	auipc	s0,0x1
  8006be:	98a40413          	addi	s0,s0,-1654 # 801044 <pids+0x14>
          if (pids[i] > 0) {
  8006c2:	4088                	lw	a0,0(s1)
  8006c4:	00a05463          	blez	a0,8006cc <main+0x126>
               kill(pids[i]);
  8006c8:	a1bff0ef          	jal	ra,8000e2 <kill>
     for (i = 0; i < TOTAL; i ++) {
  8006cc:	0491                	addi	s1,s1,4
  8006ce:	fe941ae3          	bne	s0,s1,8006c2 <main+0x11c>
     panic("FAIL: T.T\n");
  8006d2:	00000617          	auipc	a2,0x0
  8006d6:	3ee60613          	addi	a2,a2,1006 # 800ac0 <error_string+0x128>
  8006da:	04800593          	li	a1,72
  8006de:	00000517          	auipc	a0,0x0
  8006e2:	3f250513          	addi	a0,a0,1010 # 800ad0 <error_string+0x138>
  8006e6:	93bff0ef          	jal	ra,800020 <__panic>

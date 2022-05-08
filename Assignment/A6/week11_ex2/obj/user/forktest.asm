
obj/__user_forktest.out:     file format elf64-littleriscv


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
  800034:	5e050513          	addi	a0,a0,1504 # 800610 <main+0xb4>
__panic(const char *file, int line, const char *fmt, ...) {
  800038:	ec06                	sd	ra,24(sp)
  80003a:	f436                	sd	a3,40(sp)
  80003c:	f83a                	sd	a4,48(sp)
  80003e:	e0c2                	sd	a6,64(sp)
  800040:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  800042:	e43e                	sd	a5,8(sp)
    cprintf("user panic at %s:%d:\n    ", file, line);
  800044:	0cc000ef          	jal	ra,800110 <cprintf>
    vcprintf(fmt, ap);
  800048:	65a2                	ld	a1,8(sp)
  80004a:	8522                	mv	a0,s0
  80004c:	0a4000ef          	jal	ra,8000f0 <vcprintf>
    cprintf("\n");
  800050:	00000517          	auipc	a0,0x0
  800054:	5e050513          	addi	a0,a0,1504 # 800630 <main+0xd4>
  800058:	0b8000ef          	jal	ra,800110 <cprintf>
    va_end(ap);
    exit(-E_PANIC);
  80005c:	5559                	li	a0,-10
  80005e:	054000ef          	jal	ra,8000b2 <exit>

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

00000000008000ac <sys_putc>:
sys_getpid(void) {
    return syscall(SYS_getpid);
}

int
sys_putc(int64_t c) {
  8000ac:	85aa                	mv	a1,a0
    return syscall(SYS_putc, c);
  8000ae:	4579                	li	a0,30
  8000b0:	bf4d                	j	800062 <syscall>

00000000008000b2 <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  8000b2:	1141                	addi	sp,sp,-16
  8000b4:	e406                	sd	ra,8(sp)
    //cprintf("eee\n");
    sys_exit(error_code);
  8000b6:	fe5ff0ef          	jal	ra,80009a <sys_exit>
    cprintf("BUG: exit failed.\n");
  8000ba:	00000517          	auipc	a0,0x0
  8000be:	57e50513          	addi	a0,a0,1406 # 800638 <main+0xdc>
  8000c2:	04e000ef          	jal	ra,800110 <cprintf>
    while (1);
  8000c6:	a001                	j	8000c6 <exit+0x14>

00000000008000c8 <fork>:
}

int
fork(void) {
    return sys_fork();
  8000c8:	bfe1                	j	8000a0 <sys_fork>

00000000008000ca <wait>:
}

int
wait(void) {
    return sys_wait(0, NULL);
  8000ca:	4581                	li	a1,0
  8000cc:	4501                	li	a0,0
  8000ce:	bfd9                	j	8000a4 <sys_wait>

00000000008000d0 <_start>:
    # move down the esp register
    # since it may cause page fault in backtrace
    // subl $0x20, %esp

    # call user-program function
    call umain
  8000d0:	076000ef          	jal	ra,800146 <umain>
1:  j 1b
  8000d4:	a001                	j	8000d4 <_start+0x4>

00000000008000d6 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  8000d6:	1141                	addi	sp,sp,-16
  8000d8:	e022                	sd	s0,0(sp)
  8000da:	e406                	sd	ra,8(sp)
  8000dc:	842e                	mv	s0,a1
    sys_putc(c);
  8000de:	fcfff0ef          	jal	ra,8000ac <sys_putc>
    (*cnt) ++;
  8000e2:	401c                	lw	a5,0(s0)
}
  8000e4:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
  8000e6:	2785                	addiw	a5,a5,1
  8000e8:	c01c                	sw	a5,0(s0)
}
  8000ea:	6402                	ld	s0,0(sp)
  8000ec:	0141                	addi	sp,sp,16
  8000ee:	8082                	ret

00000000008000f0 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  8000f0:	1101                	addi	sp,sp,-32
  8000f2:	862a                	mv	a2,a0
  8000f4:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  8000f6:	00000517          	auipc	a0,0x0
  8000fa:	fe050513          	addi	a0,a0,-32 # 8000d6 <cputch>
  8000fe:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
  800100:	ec06                	sd	ra,24(sp)
    int cnt = 0;
  800102:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800104:	0d6000ef          	jal	ra,8001da <vprintfmt>
    return cnt;
}
  800108:	60e2                	ld	ra,24(sp)
  80010a:	4532                	lw	a0,12(sp)
  80010c:	6105                	addi	sp,sp,32
  80010e:	8082                	ret

0000000000800110 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  800110:	711d                	addi	sp,sp,-96
    va_list ap;

    va_start(ap, fmt);
  800112:	02810313          	addi	t1,sp,40
cprintf(const char *fmt, ...) {
  800116:	8e2a                	mv	t3,a0
  800118:	f42e                	sd	a1,40(sp)
  80011a:	f832                	sd	a2,48(sp)
  80011c:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80011e:	00000517          	auipc	a0,0x0
  800122:	fb850513          	addi	a0,a0,-72 # 8000d6 <cputch>
  800126:	004c                	addi	a1,sp,4
  800128:	869a                	mv	a3,t1
  80012a:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
  80012c:	ec06                	sd	ra,24(sp)
  80012e:	e0ba                	sd	a4,64(sp)
  800130:	e4be                	sd	a5,72(sp)
  800132:	e8c2                	sd	a6,80(sp)
  800134:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  800136:	e41a                	sd	t1,8(sp)
    int cnt = 0;
  800138:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80013a:	0a0000ef          	jal	ra,8001da <vprintfmt>
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}
  80013e:	60e2                	ld	ra,24(sp)
  800140:	4512                	lw	a0,4(sp)
  800142:	6125                	addi	sp,sp,96
  800144:	8082                	ret

0000000000800146 <umain>:
#include <ulib.h>

int main(void);

void
umain(void) {
  800146:	1141                	addi	sp,sp,-16
  800148:	e406                	sd	ra,8(sp)
    int ret = main();
  80014a:	412000ef          	jal	ra,80055c <main>
    exit(ret);
  80014e:	f65ff0ef          	jal	ra,8000b2 <exit>

0000000000800152 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  800152:	872a                	mv	a4,a0
    size_t cnt = 0;
  800154:	4501                	li	a0,0
    while (cnt < len && *s ++ != '\0') {
  800156:	e589                	bnez	a1,800160 <strnlen+0xe>
  800158:	a811                	j	80016c <strnlen+0x1a>
        cnt ++;
  80015a:	0505                	addi	a0,a0,1
    while (cnt < len && *s ++ != '\0') {
  80015c:	00a58763          	beq	a1,a0,80016a <strnlen+0x18>
  800160:	00a707b3          	add	a5,a4,a0
  800164:	0007c783          	lbu	a5,0(a5)
  800168:	fbed                	bnez	a5,80015a <strnlen+0x8>
    }
    return cnt;
}
  80016a:	8082                	ret
  80016c:	8082                	ret

000000000080016e <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  80016e:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  800172:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  800174:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  800178:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  80017a:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  80017e:	f022                	sd	s0,32(sp)
  800180:	ec26                	sd	s1,24(sp)
  800182:	e84a                	sd	s2,16(sp)
  800184:	f406                	sd	ra,40(sp)
  800186:	e44e                	sd	s3,8(sp)
  800188:	84aa                	mv	s1,a0
  80018a:	892e                	mv	s2,a1
  80018c:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  800190:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  800192:	03067e63          	bgeu	a2,a6,8001ce <printnum+0x60>
  800196:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  800198:	00805763          	blez	s0,8001a6 <printnum+0x38>
  80019c:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  80019e:	85ca                	mv	a1,s2
  8001a0:	854e                	mv	a0,s3
  8001a2:	9482                	jalr	s1
        while (-- width > 0)
  8001a4:	fc65                	bnez	s0,80019c <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  8001a6:	1a02                	slli	s4,s4,0x20
  8001a8:	020a5a13          	srli	s4,s4,0x20
  8001ac:	00000797          	auipc	a5,0x0
  8001b0:	4a478793          	addi	a5,a5,1188 # 800650 <main+0xf4>
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  8001b4:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  8001b6:	9a3e                	add	s4,s4,a5
  8001b8:	000a4503          	lbu	a0,0(s4)
}
  8001bc:	70a2                	ld	ra,40(sp)
  8001be:	69a2                	ld	s3,8(sp)
  8001c0:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  8001c2:	85ca                	mv	a1,s2
  8001c4:	8326                	mv	t1,s1
}
  8001c6:	6942                	ld	s2,16(sp)
  8001c8:	64e2                	ld	s1,24(sp)
  8001ca:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  8001cc:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
  8001ce:	03065633          	divu	a2,a2,a6
  8001d2:	8722                	mv	a4,s0
  8001d4:	f9bff0ef          	jal	ra,80016e <printnum>
  8001d8:	b7f9                	j	8001a6 <printnum+0x38>

00000000008001da <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  8001da:	7119                	addi	sp,sp,-128
  8001dc:	f4a6                	sd	s1,104(sp)
  8001de:	f0ca                	sd	s2,96(sp)
  8001e0:	ecce                	sd	s3,88(sp)
  8001e2:	e8d2                	sd	s4,80(sp)
  8001e4:	e4d6                	sd	s5,72(sp)
  8001e6:	e0da                	sd	s6,64(sp)
  8001e8:	fc5e                	sd	s7,56(sp)
  8001ea:	f06a                	sd	s10,32(sp)
  8001ec:	fc86                	sd	ra,120(sp)
  8001ee:	f8a2                	sd	s0,112(sp)
  8001f0:	f862                	sd	s8,48(sp)
  8001f2:	f466                	sd	s9,40(sp)
  8001f4:	ec6e                	sd	s11,24(sp)
  8001f6:	892a                	mv	s2,a0
  8001f8:	84ae                	mv	s1,a1
  8001fa:	8d32                	mv	s10,a2
  8001fc:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001fe:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  800202:	5b7d                	li	s6,-1
  800204:	00000a97          	auipc	s5,0x0
  800208:	480a8a93          	addi	s5,s5,1152 # 800684 <main+0x128>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  80020c:	00000b97          	auipc	s7,0x0
  800210:	694b8b93          	addi	s7,s7,1684 # 8008a0 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800214:	000d4503          	lbu	a0,0(s10)
  800218:	001d0413          	addi	s0,s10,1
  80021c:	01350a63          	beq	a0,s3,800230 <vprintfmt+0x56>
            if (ch == '\0') {
  800220:	c121                	beqz	a0,800260 <vprintfmt+0x86>
            putch(ch, putdat);
  800222:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800224:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  800226:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800228:	fff44503          	lbu	a0,-1(s0)
  80022c:	ff351ae3          	bne	a0,s3,800220 <vprintfmt+0x46>
  800230:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  800234:	02000793          	li	a5,32
        lflag = altflag = 0;
  800238:	4c81                	li	s9,0
  80023a:	4881                	li	a7,0
        width = precision = -1;
  80023c:	5c7d                	li	s8,-1
  80023e:	5dfd                	li	s11,-1
  800240:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  800244:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  800246:	fdd6059b          	addiw	a1,a2,-35
  80024a:	0ff5f593          	andi	a1,a1,255
  80024e:	00140d13          	addi	s10,s0,1
  800252:	04b56263          	bltu	a0,a1,800296 <vprintfmt+0xbc>
  800256:	058a                	slli	a1,a1,0x2
  800258:	95d6                	add	a1,a1,s5
  80025a:	4194                	lw	a3,0(a1)
  80025c:	96d6                	add	a3,a3,s5
  80025e:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  800260:	70e6                	ld	ra,120(sp)
  800262:	7446                	ld	s0,112(sp)
  800264:	74a6                	ld	s1,104(sp)
  800266:	7906                	ld	s2,96(sp)
  800268:	69e6                	ld	s3,88(sp)
  80026a:	6a46                	ld	s4,80(sp)
  80026c:	6aa6                	ld	s5,72(sp)
  80026e:	6b06                	ld	s6,64(sp)
  800270:	7be2                	ld	s7,56(sp)
  800272:	7c42                	ld	s8,48(sp)
  800274:	7ca2                	ld	s9,40(sp)
  800276:	7d02                	ld	s10,32(sp)
  800278:	6de2                	ld	s11,24(sp)
  80027a:	6109                	addi	sp,sp,128
  80027c:	8082                	ret
            padc = '0';
  80027e:	87b2                	mv	a5,a2
            goto reswitch;
  800280:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  800284:	846a                	mv	s0,s10
  800286:	00140d13          	addi	s10,s0,1
  80028a:	fdd6059b          	addiw	a1,a2,-35
  80028e:	0ff5f593          	andi	a1,a1,255
  800292:	fcb572e3          	bgeu	a0,a1,800256 <vprintfmt+0x7c>
            putch('%', putdat);
  800296:	85a6                	mv	a1,s1
  800298:	02500513          	li	a0,37
  80029c:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  80029e:	fff44783          	lbu	a5,-1(s0)
  8002a2:	8d22                	mv	s10,s0
  8002a4:	f73788e3          	beq	a5,s3,800214 <vprintfmt+0x3a>
  8002a8:	ffed4783          	lbu	a5,-2(s10)
  8002ac:	1d7d                	addi	s10,s10,-1
  8002ae:	ff379de3          	bne	a5,s3,8002a8 <vprintfmt+0xce>
  8002b2:	b78d                	j	800214 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  8002b4:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  8002b8:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  8002bc:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  8002be:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  8002c2:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  8002c6:	02d86463          	bltu	a6,a3,8002ee <vprintfmt+0x114>
                ch = *fmt;
  8002ca:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  8002ce:	002c169b          	slliw	a3,s8,0x2
  8002d2:	0186873b          	addw	a4,a3,s8
  8002d6:	0017171b          	slliw	a4,a4,0x1
  8002da:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  8002dc:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  8002e0:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  8002e2:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  8002e6:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  8002ea:	fed870e3          	bgeu	a6,a3,8002ca <vprintfmt+0xf0>
            if (width < 0)
  8002ee:	f40ddce3          	bgez	s11,800246 <vprintfmt+0x6c>
                width = precision, precision = -1;
  8002f2:	8de2                	mv	s11,s8
  8002f4:	5c7d                	li	s8,-1
  8002f6:	bf81                	j	800246 <vprintfmt+0x6c>
            if (width < 0)
  8002f8:	fffdc693          	not	a3,s11
  8002fc:	96fd                	srai	a3,a3,0x3f
  8002fe:	00ddfdb3          	and	s11,s11,a3
  800302:	00144603          	lbu	a2,1(s0)
  800306:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
  800308:	846a                	mv	s0,s10
            goto reswitch;
  80030a:	bf35                	j	800246 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  80030c:	000a2c03          	lw	s8,0(s4)
            goto process_precision;
  800310:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  800314:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  800316:	846a                	mv	s0,s10
            goto process_precision;
  800318:	bfd9                	j	8002ee <vprintfmt+0x114>
    if (lflag >= 2) {
  80031a:	4705                	li	a4,1
  80031c:	008a0593          	addi	a1,s4,8
  800320:	01174463          	blt	a4,a7,800328 <vprintfmt+0x14e>
    else if (lflag) {
  800324:	1a088e63          	beqz	a7,8004e0 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  800328:	000a3603          	ld	a2,0(s4)
  80032c:	46c1                	li	a3,16
  80032e:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  800330:	2781                	sext.w	a5,a5
  800332:	876e                	mv	a4,s11
  800334:	85a6                	mv	a1,s1
  800336:	854a                	mv	a0,s2
  800338:	e37ff0ef          	jal	ra,80016e <printnum>
            break;
  80033c:	bde1                	j	800214 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  80033e:	000a2503          	lw	a0,0(s4)
  800342:	85a6                	mv	a1,s1
  800344:	0a21                	addi	s4,s4,8
  800346:	9902                	jalr	s2
            break;
  800348:	b5f1                	j	800214 <vprintfmt+0x3a>
    if (lflag >= 2) {
  80034a:	4705                	li	a4,1
  80034c:	008a0593          	addi	a1,s4,8
  800350:	01174463          	blt	a4,a7,800358 <vprintfmt+0x17e>
    else if (lflag) {
  800354:	18088163          	beqz	a7,8004d6 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  800358:	000a3603          	ld	a2,0(s4)
  80035c:	46a9                	li	a3,10
  80035e:	8a2e                	mv	s4,a1
  800360:	bfc1                	j	800330 <vprintfmt+0x156>
            goto reswitch;
  800362:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  800366:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  800368:	846a                	mv	s0,s10
            goto reswitch;
  80036a:	bdf1                	j	800246 <vprintfmt+0x6c>
            putch(ch, putdat);
  80036c:	85a6                	mv	a1,s1
  80036e:	02500513          	li	a0,37
  800372:	9902                	jalr	s2
            break;
  800374:	b545                	j	800214 <vprintfmt+0x3a>
            lflag ++;
  800376:	00144603          	lbu	a2,1(s0)
  80037a:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  80037c:	846a                	mv	s0,s10
            goto reswitch;
  80037e:	b5e1                	j	800246 <vprintfmt+0x6c>
    if (lflag >= 2) {
  800380:	4705                	li	a4,1
  800382:	008a0593          	addi	a1,s4,8
  800386:	01174463          	blt	a4,a7,80038e <vprintfmt+0x1b4>
    else if (lflag) {
  80038a:	14088163          	beqz	a7,8004cc <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  80038e:	000a3603          	ld	a2,0(s4)
  800392:	46a1                	li	a3,8
  800394:	8a2e                	mv	s4,a1
  800396:	bf69                	j	800330 <vprintfmt+0x156>
            putch('0', putdat);
  800398:	03000513          	li	a0,48
  80039c:	85a6                	mv	a1,s1
  80039e:	e03e                	sd	a5,0(sp)
  8003a0:	9902                	jalr	s2
            putch('x', putdat);
  8003a2:	85a6                	mv	a1,s1
  8003a4:	07800513          	li	a0,120
  8003a8:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003aa:	0a21                	addi	s4,s4,8
            goto number;
  8003ac:	6782                	ld	a5,0(sp)
  8003ae:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003b0:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  8003b4:	bfb5                	j	800330 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003b6:	000a3403          	ld	s0,0(s4)
  8003ba:	008a0713          	addi	a4,s4,8
  8003be:	e03a                	sd	a4,0(sp)
  8003c0:	14040263          	beqz	s0,800504 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  8003c4:	0fb05763          	blez	s11,8004b2 <vprintfmt+0x2d8>
  8003c8:	02d00693          	li	a3,45
  8003cc:	0cd79163          	bne	a5,a3,80048e <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003d0:	00044783          	lbu	a5,0(s0)
  8003d4:	0007851b          	sext.w	a0,a5
  8003d8:	cf85                	beqz	a5,800410 <vprintfmt+0x236>
  8003da:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  8003de:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003e2:	000c4563          	bltz	s8,8003ec <vprintfmt+0x212>
  8003e6:	3c7d                	addiw	s8,s8,-1
  8003e8:	036c0263          	beq	s8,s6,80040c <vprintfmt+0x232>
                    putch('?', putdat);
  8003ec:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  8003ee:	0e0c8e63          	beqz	s9,8004ea <vprintfmt+0x310>
  8003f2:	3781                	addiw	a5,a5,-32
  8003f4:	0ef47b63          	bgeu	s0,a5,8004ea <vprintfmt+0x310>
                    putch('?', putdat);
  8003f8:	03f00513          	li	a0,63
  8003fc:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003fe:	000a4783          	lbu	a5,0(s4)
  800402:	3dfd                	addiw	s11,s11,-1
  800404:	0a05                	addi	s4,s4,1
  800406:	0007851b          	sext.w	a0,a5
  80040a:	ffe1                	bnez	a5,8003e2 <vprintfmt+0x208>
            for (; width > 0; width --) {
  80040c:	01b05963          	blez	s11,80041e <vprintfmt+0x244>
  800410:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  800412:	85a6                	mv	a1,s1
  800414:	02000513          	li	a0,32
  800418:	9902                	jalr	s2
            for (; width > 0; width --) {
  80041a:	fe0d9be3          	bnez	s11,800410 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  80041e:	6a02                	ld	s4,0(sp)
  800420:	bbd5                	j	800214 <vprintfmt+0x3a>
    if (lflag >= 2) {
  800422:	4705                	li	a4,1
  800424:	008a0c93          	addi	s9,s4,8
  800428:	01174463          	blt	a4,a7,800430 <vprintfmt+0x256>
    else if (lflag) {
  80042c:	08088d63          	beqz	a7,8004c6 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  800430:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  800434:	0a044d63          	bltz	s0,8004ee <vprintfmt+0x314>
            num = getint(&ap, lflag);
  800438:	8622                	mv	a2,s0
  80043a:	8a66                	mv	s4,s9
  80043c:	46a9                	li	a3,10
  80043e:	bdcd                	j	800330 <vprintfmt+0x156>
            err = va_arg(ap, int);
  800440:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800444:	4761                	li	a4,24
            err = va_arg(ap, int);
  800446:	0a21                	addi	s4,s4,8
            if (err < 0) {
  800448:	41f7d69b          	sraiw	a3,a5,0x1f
  80044c:	8fb5                	xor	a5,a5,a3
  80044e:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800452:	02d74163          	blt	a4,a3,800474 <vprintfmt+0x29a>
  800456:	00369793          	slli	a5,a3,0x3
  80045a:	97de                	add	a5,a5,s7
  80045c:	639c                	ld	a5,0(a5)
  80045e:	cb99                	beqz	a5,800474 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  800460:	86be                	mv	a3,a5
  800462:	00000617          	auipc	a2,0x0
  800466:	21e60613          	addi	a2,a2,542 # 800680 <main+0x124>
  80046a:	85a6                	mv	a1,s1
  80046c:	854a                	mv	a0,s2
  80046e:	0ce000ef          	jal	ra,80053c <printfmt>
  800472:	b34d                	j	800214 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  800474:	00000617          	auipc	a2,0x0
  800478:	1fc60613          	addi	a2,a2,508 # 800670 <main+0x114>
  80047c:	85a6                	mv	a1,s1
  80047e:	854a                	mv	a0,s2
  800480:	0bc000ef          	jal	ra,80053c <printfmt>
  800484:	bb41                	j	800214 <vprintfmt+0x3a>
                p = "(null)";
  800486:	00000417          	auipc	s0,0x0
  80048a:	1e240413          	addi	s0,s0,482 # 800668 <main+0x10c>
                for (width -= strnlen(p, precision); width > 0; width --) {
  80048e:	85e2                	mv	a1,s8
  800490:	8522                	mv	a0,s0
  800492:	e43e                	sd	a5,8(sp)
  800494:	cbfff0ef          	jal	ra,800152 <strnlen>
  800498:	40ad8dbb          	subw	s11,s11,a0
  80049c:	01b05b63          	blez	s11,8004b2 <vprintfmt+0x2d8>
  8004a0:	67a2                	ld	a5,8(sp)
  8004a2:	00078a1b          	sext.w	s4,a5
  8004a6:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  8004a8:	85a6                	mv	a1,s1
  8004aa:	8552                	mv	a0,s4
  8004ac:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004ae:	fe0d9ce3          	bnez	s11,8004a6 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004b2:	00044783          	lbu	a5,0(s0)
  8004b6:	00140a13          	addi	s4,s0,1
  8004ba:	0007851b          	sext.w	a0,a5
  8004be:	d3a5                	beqz	a5,80041e <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  8004c0:	05e00413          	li	s0,94
  8004c4:	bf39                	j	8003e2 <vprintfmt+0x208>
        return va_arg(*ap, int);
  8004c6:	000a2403          	lw	s0,0(s4)
  8004ca:	b7ad                	j	800434 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  8004cc:	000a6603          	lwu	a2,0(s4)
  8004d0:	46a1                	li	a3,8
  8004d2:	8a2e                	mv	s4,a1
  8004d4:	bdb1                	j	800330 <vprintfmt+0x156>
  8004d6:	000a6603          	lwu	a2,0(s4)
  8004da:	46a9                	li	a3,10
  8004dc:	8a2e                	mv	s4,a1
  8004de:	bd89                	j	800330 <vprintfmt+0x156>
  8004e0:	000a6603          	lwu	a2,0(s4)
  8004e4:	46c1                	li	a3,16
  8004e6:	8a2e                	mv	s4,a1
  8004e8:	b5a1                	j	800330 <vprintfmt+0x156>
                    putch(ch, putdat);
  8004ea:	9902                	jalr	s2
  8004ec:	bf09                	j	8003fe <vprintfmt+0x224>
                putch('-', putdat);
  8004ee:	85a6                	mv	a1,s1
  8004f0:	02d00513          	li	a0,45
  8004f4:	e03e                	sd	a5,0(sp)
  8004f6:	9902                	jalr	s2
                num = -(long long)num;
  8004f8:	6782                	ld	a5,0(sp)
  8004fa:	8a66                	mv	s4,s9
  8004fc:	40800633          	neg	a2,s0
  800500:	46a9                	li	a3,10
  800502:	b53d                	j	800330 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  800504:	03b05163          	blez	s11,800526 <vprintfmt+0x34c>
  800508:	02d00693          	li	a3,45
  80050c:	f6d79de3          	bne	a5,a3,800486 <vprintfmt+0x2ac>
                p = "(null)";
  800510:	00000417          	auipc	s0,0x0
  800514:	15840413          	addi	s0,s0,344 # 800668 <main+0x10c>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800518:	02800793          	li	a5,40
  80051c:	02800513          	li	a0,40
  800520:	00140a13          	addi	s4,s0,1
  800524:	bd6d                	j	8003de <vprintfmt+0x204>
  800526:	00000a17          	auipc	s4,0x0
  80052a:	143a0a13          	addi	s4,s4,323 # 800669 <main+0x10d>
  80052e:	02800513          	li	a0,40
  800532:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  800536:	05e00413          	li	s0,94
  80053a:	b565                	j	8003e2 <vprintfmt+0x208>

000000000080053c <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  80053c:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  80053e:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800542:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  800544:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800546:	ec06                	sd	ra,24(sp)
  800548:	f83a                	sd	a4,48(sp)
  80054a:	fc3e                	sd	a5,56(sp)
  80054c:	e0c2                	sd	a6,64(sp)
  80054e:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  800550:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  800552:	c89ff0ef          	jal	ra,8001da <vprintfmt>
}
  800556:	60e2                	ld	ra,24(sp)
  800558:	6161                	addi	sp,sp,80
  80055a:	8082                	ret

000000000080055c <main>:
#include <stdio.h>

const int max_child = 32;

int
main(void) {
  80055c:	1101                	addi	sp,sp,-32
  80055e:	e822                	sd	s0,16(sp)
  800560:	e426                	sd	s1,8(sp)
  800562:	ec06                	sd	ra,24(sp)
    int n, pid;
    for (n = 0; n < max_child; n ++) {
  800564:	4401                	li	s0,0
  800566:	02000493          	li	s1,32
        if ((pid = fork()) == 0) {
  80056a:	b5fff0ef          	jal	ra,8000c8 <fork>
  80056e:	c131                	beqz	a0,8005b2 <main+0x56>
            cprintf("I am child %d\n", n);
            exit(0);
        }
        assert(pid > 0);
  800570:	06a05663          	blez	a0,8005dc <main+0x80>
    for (n = 0; n < max_child; n ++) {
  800574:	2405                	addiw	s0,s0,1
  800576:	fe941ae3          	bne	s0,s1,80056a <main+0xe>
    }

    if (n > max_child) {
        panic("fork claimed to work %d times!\n", n);
    }
    cprintf("fork finished\n");
  80057a:	00000517          	auipc	a0,0x0
  80057e:	42e50513          	addi	a0,a0,1070 # 8009a8 <error_string+0x108>
  800582:	b8fff0ef          	jal	ra,800110 <cprintf>
  800586:	02000413          	li	s0,32
    for (; n > 0; n --) {
        if (wait() != 0) {
  80058a:	b41ff0ef          	jal	ra,8000ca <wait>
  80058e:	ed05                	bnez	a0,8005c6 <main+0x6a>
    for (; n > 0; n --) {
  800590:	347d                	addiw	s0,s0,-1
  800592:	fc65                	bnez	s0,80058a <main+0x2e>
            panic("wait stopped early\n");
        }
    }

    if (wait() == 0) {
  800594:	b37ff0ef          	jal	ra,8000ca <wait>
  800598:	c12d                	beqz	a0,8005fa <main+0x9e>
        panic("wait got too many\n");
    }

    cprintf("forktest pass.\n");
  80059a:	00000517          	auipc	a0,0x0
  80059e:	44e50513          	addi	a0,a0,1102 # 8009e8 <error_string+0x148>
  8005a2:	b6fff0ef          	jal	ra,800110 <cprintf>
    return 0;
}
  8005a6:	60e2                	ld	ra,24(sp)
  8005a8:	6442                	ld	s0,16(sp)
  8005aa:	64a2                	ld	s1,8(sp)
  8005ac:	4501                	li	a0,0
  8005ae:	6105                	addi	sp,sp,32
  8005b0:	8082                	ret
            cprintf("I am child %d\n", n);
  8005b2:	85a2                	mv	a1,s0
  8005b4:	00000517          	auipc	a0,0x0
  8005b8:	3b450513          	addi	a0,a0,948 # 800968 <error_string+0xc8>
  8005bc:	b55ff0ef          	jal	ra,800110 <cprintf>
            exit(0);
  8005c0:	4501                	li	a0,0
  8005c2:	af1ff0ef          	jal	ra,8000b2 <exit>
            panic("wait stopped early\n");
  8005c6:	00000617          	auipc	a2,0x0
  8005ca:	3f260613          	addi	a2,a2,1010 # 8009b8 <error_string+0x118>
  8005ce:	45dd                	li	a1,23
  8005d0:	00000517          	auipc	a0,0x0
  8005d4:	3c850513          	addi	a0,a0,968 # 800998 <error_string+0xf8>
  8005d8:	a49ff0ef          	jal	ra,800020 <__panic>
        assert(pid > 0);
  8005dc:	00000697          	auipc	a3,0x0
  8005e0:	39c68693          	addi	a3,a3,924 # 800978 <error_string+0xd8>
  8005e4:	00000617          	auipc	a2,0x0
  8005e8:	39c60613          	addi	a2,a2,924 # 800980 <error_string+0xe0>
  8005ec:	45b9                	li	a1,14
  8005ee:	00000517          	auipc	a0,0x0
  8005f2:	3aa50513          	addi	a0,a0,938 # 800998 <error_string+0xf8>
  8005f6:	a2bff0ef          	jal	ra,800020 <__panic>
        panic("wait got too many\n");
  8005fa:	00000617          	auipc	a2,0x0
  8005fe:	3d660613          	addi	a2,a2,982 # 8009d0 <error_string+0x130>
  800602:	45f1                	li	a1,28
  800604:	00000517          	auipc	a0,0x0
  800608:	39450513          	addi	a0,a0,916 # 800998 <error_string+0xf8>
  80060c:	a15ff0ef          	jal	ra,800020 <__panic>

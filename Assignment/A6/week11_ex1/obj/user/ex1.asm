
obj/__user_ex1.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <syscall>:
#include <syscall.h>

#define MAX_ARGS            5

static inline int
syscall(int64_t num, ...) {
  800020:	7175                	addi	sp,sp,-144
  800022:	f8ba                	sd	a4,112(sp)
    va_list ap;
    va_start(ap, num);
    uint64_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, uint64_t);
  800024:	e0ba                	sd	a4,64(sp)
  800026:	0118                	addi	a4,sp,128
syscall(int64_t num, ...) {
  800028:	e42a                	sd	a0,8(sp)
  80002a:	ecae                	sd	a1,88(sp)
  80002c:	f0b2                	sd	a2,96(sp)
  80002e:	f4b6                	sd	a3,104(sp)
  800030:	fcbe                	sd	a5,120(sp)
  800032:	e142                	sd	a6,128(sp)
  800034:	e546                	sd	a7,136(sp)
        a[i] = va_arg(ap, uint64_t);
  800036:	f42e                	sd	a1,40(sp)
  800038:	f832                	sd	a2,48(sp)
  80003a:	fc36                	sd	a3,56(sp)
  80003c:	f03a                	sd	a4,32(sp)
  80003e:	e4be                	sd	a5,72(sp)
    }
    va_end(ap);
    asm volatile (
  800040:	4522                	lw	a0,8(sp)
  800042:	55a2                	lw	a1,40(sp)
  800044:	5642                	lw	a2,48(sp)
  800046:	56e2                	lw	a3,56(sp)
  800048:	4706                	lw	a4,64(sp)
  80004a:	47a6                	lw	a5,72(sp)
  80004c:	00000073          	ecall
  800050:	ce2a                	sw	a0,28(sp)
          "m" (a[3]),
          "m" (a[4])
        : "memory"
      );
    return ret;
}
  800052:	4572                	lw	a0,28(sp)
  800054:	6149                	addi	sp,sp,144
  800056:	8082                	ret

0000000000800058 <sys_exit>:

int
sys_exit(int64_t error_code) {
  800058:	85aa                	mv	a1,a0
    return syscall(SYS_exit, error_code);
  80005a:	4505                	li	a0,1
  80005c:	b7d1                	j	800020 <syscall>

000000000080005e <sys_putc>:
sys_getpid(void) {
    return syscall(SYS_getpid);
}

int
sys_putc(int64_t c) {
  80005e:	85aa                	mv	a1,a0
    return syscall(SYS_putc, c);
  800060:	4579                	li	a0,30
  800062:	bf7d                	j	800020 <syscall>

0000000000800064 <sys_labschedule_set_priority>:
sys_gettime(void) {
    return syscall(SYS_gettime);
}

int
sys_labschedule_set_priority(int pr) {
  800064:	85aa                	mv	a1,a0
    return syscall(SYS_labschedule_set_priority, pr);
  800066:	0ff00513          	li	a0,255
  80006a:	bf5d                	j	800020 <syscall>

000000000080006c <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  80006c:	1141                	addi	sp,sp,-16
  80006e:	e406                	sd	ra,8(sp)
    //cprintf("eee\n");
    sys_exit(error_code);
  800070:	fe9ff0ef          	jal	ra,800058 <sys_exit>
    cprintf("BUG: exit failed.\n");
  800074:	00000517          	auipc	a0,0x0
  800078:	4c450513          	addi	a0,a0,1220 # 800538 <main+0x2a>
  80007c:	046000ef          	jal	ra,8000c2 <cprintf>
    while (1);
  800080:	a001                	j	800080 <exit+0x14>

0000000000800082 <set_priority>:
gettime_msec(void) {
    return (unsigned int)sys_gettime();
}

unsigned int
set_priority(int pr){
  800082:	1141                	addi	sp,sp,-16
  800084:	e022                	sd	s0,0(sp)
	cprintf("set priority to %d\n", pr);
  800086:	85aa                	mv	a1,a0
set_priority(int pr){
  800088:	842a                	mv	s0,a0
	cprintf("set priority to %d\n", pr);
  80008a:	00000517          	auipc	a0,0x0
  80008e:	4c650513          	addi	a0,a0,1222 # 800550 <main+0x42>
set_priority(int pr){
  800092:	e406                	sd	ra,8(sp)
	cprintf("set priority to %d\n", pr);
  800094:	02e000ef          	jal	ra,8000c2 <cprintf>
    return (unsigned int) sys_labschedule_set_priority(pr);
  800098:	8522                	mv	a0,s0
}
  80009a:	6402                	ld	s0,0(sp)
  80009c:	60a2                	ld	ra,8(sp)
  80009e:	0141                	addi	sp,sp,16
    return (unsigned int) sys_labschedule_set_priority(pr);
  8000a0:	b7d1                	j	800064 <sys_labschedule_set_priority>

00000000008000a2 <_start>:
    # move down the esp register
    # since it may cause page fault in backtrace
    // subl $0x20, %esp

    # call user-program function
    call umain
  8000a2:	056000ef          	jal	ra,8000f8 <umain>
1:  j 1b
  8000a6:	a001                	j	8000a6 <_start+0x4>

00000000008000a8 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  8000a8:	1141                	addi	sp,sp,-16
  8000aa:	e022                	sd	s0,0(sp)
  8000ac:	e406                	sd	ra,8(sp)
  8000ae:	842e                	mv	s0,a1
    sys_putc(c);
  8000b0:	fafff0ef          	jal	ra,80005e <sys_putc>
    (*cnt) ++;
  8000b4:	401c                	lw	a5,0(s0)
}
  8000b6:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
  8000b8:	2785                	addiw	a5,a5,1
  8000ba:	c01c                	sw	a5,0(s0)
}
  8000bc:	6402                	ld	s0,0(sp)
  8000be:	0141                	addi	sp,sp,16
  8000c0:	8082                	ret

00000000008000c2 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  8000c2:	711d                	addi	sp,sp,-96
    va_list ap;

    va_start(ap, fmt);
  8000c4:	02810313          	addi	t1,sp,40
cprintf(const char *fmt, ...) {
  8000c8:	8e2a                	mv	t3,a0
  8000ca:	f42e                	sd	a1,40(sp)
  8000cc:	f832                	sd	a2,48(sp)
  8000ce:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  8000d0:	00000517          	auipc	a0,0x0
  8000d4:	fd850513          	addi	a0,a0,-40 # 8000a8 <cputch>
  8000d8:	004c                	addi	a1,sp,4
  8000da:	869a                	mv	a3,t1
  8000dc:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
  8000de:	ec06                	sd	ra,24(sp)
  8000e0:	e0ba                	sd	a4,64(sp)
  8000e2:	e4be                	sd	a5,72(sp)
  8000e4:	e8c2                	sd	a6,80(sp)
  8000e6:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  8000e8:	e41a                	sd	t1,8(sp)
    int cnt = 0;
  8000ea:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  8000ec:	0a0000ef          	jal	ra,80018c <vprintfmt>
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}
  8000f0:	60e2                	ld	ra,24(sp)
  8000f2:	4512                	lw	a0,4(sp)
  8000f4:	6125                	addi	sp,sp,96
  8000f6:	8082                	ret

00000000008000f8 <umain>:
#include <ulib.h>

int main(void);

void
umain(void) {
  8000f8:	1141                	addi	sp,sp,-16
  8000fa:	e406                	sd	ra,8(sp)
    int ret = main();
  8000fc:	412000ef          	jal	ra,80050e <main>
    exit(ret);
  800100:	f6dff0ef          	jal	ra,80006c <exit>

0000000000800104 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  800104:	872a                	mv	a4,a0
    size_t cnt = 0;
  800106:	4501                	li	a0,0
    while (cnt < len && *s ++ != '\0') {
  800108:	e589                	bnez	a1,800112 <strnlen+0xe>
  80010a:	a811                	j	80011e <strnlen+0x1a>
        cnt ++;
  80010c:	0505                	addi	a0,a0,1
    while (cnt < len && *s ++ != '\0') {
  80010e:	00a58763          	beq	a1,a0,80011c <strnlen+0x18>
  800112:	00a707b3          	add	a5,a4,a0
  800116:	0007c783          	lbu	a5,0(a5)
  80011a:	fbed                	bnez	a5,80010c <strnlen+0x8>
    }
    return cnt;
}
  80011c:	8082                	ret
  80011e:	8082                	ret

0000000000800120 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  800120:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  800124:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  800126:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  80012a:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  80012c:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  800130:	f022                	sd	s0,32(sp)
  800132:	ec26                	sd	s1,24(sp)
  800134:	e84a                	sd	s2,16(sp)
  800136:	f406                	sd	ra,40(sp)
  800138:	e44e                	sd	s3,8(sp)
  80013a:	84aa                	mv	s1,a0
  80013c:	892e                	mv	s2,a1
  80013e:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  800142:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  800144:	03067e63          	bgeu	a2,a6,800180 <printnum+0x60>
  800148:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  80014a:	00805763          	blez	s0,800158 <printnum+0x38>
  80014e:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  800150:	85ca                	mv	a1,s2
  800152:	854e                	mv	a0,s3
  800154:	9482                	jalr	s1
        while (-- width > 0)
  800156:	fc65                	bnez	s0,80014e <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  800158:	1a02                	slli	s4,s4,0x20
  80015a:	020a5a13          	srli	s4,s4,0x20
  80015e:	00000797          	auipc	a5,0x0
  800162:	40a78793          	addi	a5,a5,1034 # 800568 <main+0x5a>
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  800166:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  800168:	9a3e                	add	s4,s4,a5
  80016a:	000a4503          	lbu	a0,0(s4)
}
  80016e:	70a2                	ld	ra,40(sp)
  800170:	69a2                	ld	s3,8(sp)
  800172:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  800174:	85ca                	mv	a1,s2
  800176:	8326                	mv	t1,s1
}
  800178:	6942                	ld	s2,16(sp)
  80017a:	64e2                	ld	s1,24(sp)
  80017c:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  80017e:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
  800180:	03065633          	divu	a2,a2,a6
  800184:	8722                	mv	a4,s0
  800186:	f9bff0ef          	jal	ra,800120 <printnum>
  80018a:	b7f9                	j	800158 <printnum+0x38>

000000000080018c <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  80018c:	7119                	addi	sp,sp,-128
  80018e:	f4a6                	sd	s1,104(sp)
  800190:	f0ca                	sd	s2,96(sp)
  800192:	ecce                	sd	s3,88(sp)
  800194:	e8d2                	sd	s4,80(sp)
  800196:	e4d6                	sd	s5,72(sp)
  800198:	e0da                	sd	s6,64(sp)
  80019a:	fc5e                	sd	s7,56(sp)
  80019c:	f06a                	sd	s10,32(sp)
  80019e:	fc86                	sd	ra,120(sp)
  8001a0:	f8a2                	sd	s0,112(sp)
  8001a2:	f862                	sd	s8,48(sp)
  8001a4:	f466                	sd	s9,40(sp)
  8001a6:	ec6e                	sd	s11,24(sp)
  8001a8:	892a                	mv	s2,a0
  8001aa:	84ae                	mv	s1,a1
  8001ac:	8d32                	mv	s10,a2
  8001ae:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001b0:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  8001b4:	5b7d                	li	s6,-1
  8001b6:	00000a97          	auipc	s5,0x0
  8001ba:	3e6a8a93          	addi	s5,s5,998 # 80059c <main+0x8e>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8001be:	00000b97          	auipc	s7,0x0
  8001c2:	5fab8b93          	addi	s7,s7,1530 # 8007b8 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001c6:	000d4503          	lbu	a0,0(s10)
  8001ca:	001d0413          	addi	s0,s10,1
  8001ce:	01350a63          	beq	a0,s3,8001e2 <vprintfmt+0x56>
            if (ch == '\0') {
  8001d2:	c121                	beqz	a0,800212 <vprintfmt+0x86>
            putch(ch, putdat);
  8001d4:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001d6:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  8001d8:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001da:	fff44503          	lbu	a0,-1(s0)
  8001de:	ff351ae3          	bne	a0,s3,8001d2 <vprintfmt+0x46>
  8001e2:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  8001e6:	02000793          	li	a5,32
        lflag = altflag = 0;
  8001ea:	4c81                	li	s9,0
  8001ec:	4881                	li	a7,0
        width = precision = -1;
  8001ee:	5c7d                	li	s8,-1
  8001f0:	5dfd                	li	s11,-1
  8001f2:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  8001f6:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  8001f8:	fdd6059b          	addiw	a1,a2,-35
  8001fc:	0ff5f593          	andi	a1,a1,255
  800200:	00140d13          	addi	s10,s0,1
  800204:	04b56263          	bltu	a0,a1,800248 <vprintfmt+0xbc>
  800208:	058a                	slli	a1,a1,0x2
  80020a:	95d6                	add	a1,a1,s5
  80020c:	4194                	lw	a3,0(a1)
  80020e:	96d6                	add	a3,a3,s5
  800210:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  800212:	70e6                	ld	ra,120(sp)
  800214:	7446                	ld	s0,112(sp)
  800216:	74a6                	ld	s1,104(sp)
  800218:	7906                	ld	s2,96(sp)
  80021a:	69e6                	ld	s3,88(sp)
  80021c:	6a46                	ld	s4,80(sp)
  80021e:	6aa6                	ld	s5,72(sp)
  800220:	6b06                	ld	s6,64(sp)
  800222:	7be2                	ld	s7,56(sp)
  800224:	7c42                	ld	s8,48(sp)
  800226:	7ca2                	ld	s9,40(sp)
  800228:	7d02                	ld	s10,32(sp)
  80022a:	6de2                	ld	s11,24(sp)
  80022c:	6109                	addi	sp,sp,128
  80022e:	8082                	ret
            padc = '0';
  800230:	87b2                	mv	a5,a2
            goto reswitch;
  800232:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  800236:	846a                	mv	s0,s10
  800238:	00140d13          	addi	s10,s0,1
  80023c:	fdd6059b          	addiw	a1,a2,-35
  800240:	0ff5f593          	andi	a1,a1,255
  800244:	fcb572e3          	bgeu	a0,a1,800208 <vprintfmt+0x7c>
            putch('%', putdat);
  800248:	85a6                	mv	a1,s1
  80024a:	02500513          	li	a0,37
  80024e:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  800250:	fff44783          	lbu	a5,-1(s0)
  800254:	8d22                	mv	s10,s0
  800256:	f73788e3          	beq	a5,s3,8001c6 <vprintfmt+0x3a>
  80025a:	ffed4783          	lbu	a5,-2(s10)
  80025e:	1d7d                	addi	s10,s10,-1
  800260:	ff379de3          	bne	a5,s3,80025a <vprintfmt+0xce>
  800264:	b78d                	j	8001c6 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  800266:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  80026a:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  80026e:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  800270:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  800274:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  800278:	02d86463          	bltu	a6,a3,8002a0 <vprintfmt+0x114>
                ch = *fmt;
  80027c:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  800280:	002c169b          	slliw	a3,s8,0x2
  800284:	0186873b          	addw	a4,a3,s8
  800288:	0017171b          	slliw	a4,a4,0x1
  80028c:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  80028e:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  800292:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  800294:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  800298:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  80029c:	fed870e3          	bgeu	a6,a3,80027c <vprintfmt+0xf0>
            if (width < 0)
  8002a0:	f40ddce3          	bgez	s11,8001f8 <vprintfmt+0x6c>
                width = precision, precision = -1;
  8002a4:	8de2                	mv	s11,s8
  8002a6:	5c7d                	li	s8,-1
  8002a8:	bf81                	j	8001f8 <vprintfmt+0x6c>
            if (width < 0)
  8002aa:	fffdc693          	not	a3,s11
  8002ae:	96fd                	srai	a3,a3,0x3f
  8002b0:	00ddfdb3          	and	s11,s11,a3
  8002b4:	00144603          	lbu	a2,1(s0)
  8002b8:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
  8002ba:	846a                	mv	s0,s10
            goto reswitch;
  8002bc:	bf35                	j	8001f8 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  8002be:	000a2c03          	lw	s8,0(s4)
            goto process_precision;
  8002c2:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  8002c6:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  8002c8:	846a                	mv	s0,s10
            goto process_precision;
  8002ca:	bfd9                	j	8002a0 <vprintfmt+0x114>
    if (lflag >= 2) {
  8002cc:	4705                	li	a4,1
  8002ce:	008a0593          	addi	a1,s4,8
  8002d2:	01174463          	blt	a4,a7,8002da <vprintfmt+0x14e>
    else if (lflag) {
  8002d6:	1a088e63          	beqz	a7,800492 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  8002da:	000a3603          	ld	a2,0(s4)
  8002de:	46c1                	li	a3,16
  8002e0:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  8002e2:	2781                	sext.w	a5,a5
  8002e4:	876e                	mv	a4,s11
  8002e6:	85a6                	mv	a1,s1
  8002e8:	854a                	mv	a0,s2
  8002ea:	e37ff0ef          	jal	ra,800120 <printnum>
            break;
  8002ee:	bde1                	j	8001c6 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  8002f0:	000a2503          	lw	a0,0(s4)
  8002f4:	85a6                	mv	a1,s1
  8002f6:	0a21                	addi	s4,s4,8
  8002f8:	9902                	jalr	s2
            break;
  8002fa:	b5f1                	j	8001c6 <vprintfmt+0x3a>
    if (lflag >= 2) {
  8002fc:	4705                	li	a4,1
  8002fe:	008a0593          	addi	a1,s4,8
  800302:	01174463          	blt	a4,a7,80030a <vprintfmt+0x17e>
    else if (lflag) {
  800306:	18088163          	beqz	a7,800488 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  80030a:	000a3603          	ld	a2,0(s4)
  80030e:	46a9                	li	a3,10
  800310:	8a2e                	mv	s4,a1
  800312:	bfc1                	j	8002e2 <vprintfmt+0x156>
            goto reswitch;
  800314:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  800318:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  80031a:	846a                	mv	s0,s10
            goto reswitch;
  80031c:	bdf1                	j	8001f8 <vprintfmt+0x6c>
            putch(ch, putdat);
  80031e:	85a6                	mv	a1,s1
  800320:	02500513          	li	a0,37
  800324:	9902                	jalr	s2
            break;
  800326:	b545                	j	8001c6 <vprintfmt+0x3a>
            lflag ++;
  800328:	00144603          	lbu	a2,1(s0)
  80032c:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  80032e:	846a                	mv	s0,s10
            goto reswitch;
  800330:	b5e1                	j	8001f8 <vprintfmt+0x6c>
    if (lflag >= 2) {
  800332:	4705                	li	a4,1
  800334:	008a0593          	addi	a1,s4,8
  800338:	01174463          	blt	a4,a7,800340 <vprintfmt+0x1b4>
    else if (lflag) {
  80033c:	14088163          	beqz	a7,80047e <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  800340:	000a3603          	ld	a2,0(s4)
  800344:	46a1                	li	a3,8
  800346:	8a2e                	mv	s4,a1
  800348:	bf69                	j	8002e2 <vprintfmt+0x156>
            putch('0', putdat);
  80034a:	03000513          	li	a0,48
  80034e:	85a6                	mv	a1,s1
  800350:	e03e                	sd	a5,0(sp)
  800352:	9902                	jalr	s2
            putch('x', putdat);
  800354:	85a6                	mv	a1,s1
  800356:	07800513          	li	a0,120
  80035a:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  80035c:	0a21                	addi	s4,s4,8
            goto number;
  80035e:	6782                	ld	a5,0(sp)
  800360:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  800362:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  800366:	bfb5                	j	8002e2 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  800368:	000a3403          	ld	s0,0(s4)
  80036c:	008a0713          	addi	a4,s4,8
  800370:	e03a                	sd	a4,0(sp)
  800372:	14040263          	beqz	s0,8004b6 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  800376:	0fb05763          	blez	s11,800464 <vprintfmt+0x2d8>
  80037a:	02d00693          	li	a3,45
  80037e:	0cd79163          	bne	a5,a3,800440 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800382:	00044783          	lbu	a5,0(s0)
  800386:	0007851b          	sext.w	a0,a5
  80038a:	cf85                	beqz	a5,8003c2 <vprintfmt+0x236>
  80038c:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  800390:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800394:	000c4563          	bltz	s8,80039e <vprintfmt+0x212>
  800398:	3c7d                	addiw	s8,s8,-1
  80039a:	036c0263          	beq	s8,s6,8003be <vprintfmt+0x232>
                    putch('?', putdat);
  80039e:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  8003a0:	0e0c8e63          	beqz	s9,80049c <vprintfmt+0x310>
  8003a4:	3781                	addiw	a5,a5,-32
  8003a6:	0ef47b63          	bgeu	s0,a5,80049c <vprintfmt+0x310>
                    putch('?', putdat);
  8003aa:	03f00513          	li	a0,63
  8003ae:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003b0:	000a4783          	lbu	a5,0(s4)
  8003b4:	3dfd                	addiw	s11,s11,-1
  8003b6:	0a05                	addi	s4,s4,1
  8003b8:	0007851b          	sext.w	a0,a5
  8003bc:	ffe1                	bnez	a5,800394 <vprintfmt+0x208>
            for (; width > 0; width --) {
  8003be:	01b05963          	blez	s11,8003d0 <vprintfmt+0x244>
  8003c2:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  8003c4:	85a6                	mv	a1,s1
  8003c6:	02000513          	li	a0,32
  8003ca:	9902                	jalr	s2
            for (; width > 0; width --) {
  8003cc:	fe0d9be3          	bnez	s11,8003c2 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003d0:	6a02                	ld	s4,0(sp)
  8003d2:	bbd5                	j	8001c6 <vprintfmt+0x3a>
    if (lflag >= 2) {
  8003d4:	4705                	li	a4,1
  8003d6:	008a0c93          	addi	s9,s4,8
  8003da:	01174463          	blt	a4,a7,8003e2 <vprintfmt+0x256>
    else if (lflag) {
  8003de:	08088d63          	beqz	a7,800478 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  8003e2:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  8003e6:	0a044d63          	bltz	s0,8004a0 <vprintfmt+0x314>
            num = getint(&ap, lflag);
  8003ea:	8622                	mv	a2,s0
  8003ec:	8a66                	mv	s4,s9
  8003ee:	46a9                	li	a3,10
  8003f0:	bdcd                	j	8002e2 <vprintfmt+0x156>
            err = va_arg(ap, int);
  8003f2:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8003f6:	4761                	li	a4,24
            err = va_arg(ap, int);
  8003f8:	0a21                	addi	s4,s4,8
            if (err < 0) {
  8003fa:	41f7d69b          	sraiw	a3,a5,0x1f
  8003fe:	8fb5                	xor	a5,a5,a3
  800400:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800404:	02d74163          	blt	a4,a3,800426 <vprintfmt+0x29a>
  800408:	00369793          	slli	a5,a3,0x3
  80040c:	97de                	add	a5,a5,s7
  80040e:	639c                	ld	a5,0(a5)
  800410:	cb99                	beqz	a5,800426 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  800412:	86be                	mv	a3,a5
  800414:	00000617          	auipc	a2,0x0
  800418:	18460613          	addi	a2,a2,388 # 800598 <main+0x8a>
  80041c:	85a6                	mv	a1,s1
  80041e:	854a                	mv	a0,s2
  800420:	0ce000ef          	jal	ra,8004ee <printfmt>
  800424:	b34d                	j	8001c6 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  800426:	00000617          	auipc	a2,0x0
  80042a:	16260613          	addi	a2,a2,354 # 800588 <main+0x7a>
  80042e:	85a6                	mv	a1,s1
  800430:	854a                	mv	a0,s2
  800432:	0bc000ef          	jal	ra,8004ee <printfmt>
  800436:	bb41                	j	8001c6 <vprintfmt+0x3a>
                p = "(null)";
  800438:	00000417          	auipc	s0,0x0
  80043c:	14840413          	addi	s0,s0,328 # 800580 <main+0x72>
                for (width -= strnlen(p, precision); width > 0; width --) {
  800440:	85e2                	mv	a1,s8
  800442:	8522                	mv	a0,s0
  800444:	e43e                	sd	a5,8(sp)
  800446:	cbfff0ef          	jal	ra,800104 <strnlen>
  80044a:	40ad8dbb          	subw	s11,s11,a0
  80044e:	01b05b63          	blez	s11,800464 <vprintfmt+0x2d8>
  800452:	67a2                	ld	a5,8(sp)
  800454:	00078a1b          	sext.w	s4,a5
  800458:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  80045a:	85a6                	mv	a1,s1
  80045c:	8552                	mv	a0,s4
  80045e:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  800460:	fe0d9ce3          	bnez	s11,800458 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800464:	00044783          	lbu	a5,0(s0)
  800468:	00140a13          	addi	s4,s0,1
  80046c:	0007851b          	sext.w	a0,a5
  800470:	d3a5                	beqz	a5,8003d0 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  800472:	05e00413          	li	s0,94
  800476:	bf39                	j	800394 <vprintfmt+0x208>
        return va_arg(*ap, int);
  800478:	000a2403          	lw	s0,0(s4)
  80047c:	b7ad                	j	8003e6 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  80047e:	000a6603          	lwu	a2,0(s4)
  800482:	46a1                	li	a3,8
  800484:	8a2e                	mv	s4,a1
  800486:	bdb1                	j	8002e2 <vprintfmt+0x156>
  800488:	000a6603          	lwu	a2,0(s4)
  80048c:	46a9                	li	a3,10
  80048e:	8a2e                	mv	s4,a1
  800490:	bd89                	j	8002e2 <vprintfmt+0x156>
  800492:	000a6603          	lwu	a2,0(s4)
  800496:	46c1                	li	a3,16
  800498:	8a2e                	mv	s4,a1
  80049a:	b5a1                	j	8002e2 <vprintfmt+0x156>
                    putch(ch, putdat);
  80049c:	9902                	jalr	s2
  80049e:	bf09                	j	8003b0 <vprintfmt+0x224>
                putch('-', putdat);
  8004a0:	85a6                	mv	a1,s1
  8004a2:	02d00513          	li	a0,45
  8004a6:	e03e                	sd	a5,0(sp)
  8004a8:	9902                	jalr	s2
                num = -(long long)num;
  8004aa:	6782                	ld	a5,0(sp)
  8004ac:	8a66                	mv	s4,s9
  8004ae:	40800633          	neg	a2,s0
  8004b2:	46a9                	li	a3,10
  8004b4:	b53d                	j	8002e2 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  8004b6:	03b05163          	blez	s11,8004d8 <vprintfmt+0x34c>
  8004ba:	02d00693          	li	a3,45
  8004be:	f6d79de3          	bne	a5,a3,800438 <vprintfmt+0x2ac>
                p = "(null)";
  8004c2:	00000417          	auipc	s0,0x0
  8004c6:	0be40413          	addi	s0,s0,190 # 800580 <main+0x72>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004ca:	02800793          	li	a5,40
  8004ce:	02800513          	li	a0,40
  8004d2:	00140a13          	addi	s4,s0,1
  8004d6:	bd6d                	j	800390 <vprintfmt+0x204>
  8004d8:	00000a17          	auipc	s4,0x0
  8004dc:	0a9a0a13          	addi	s4,s4,169 # 800581 <main+0x73>
  8004e0:	02800513          	li	a0,40
  8004e4:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  8004e8:	05e00413          	li	s0,94
  8004ec:	b565                	j	800394 <vprintfmt+0x208>

00000000008004ee <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004ee:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  8004f0:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004f4:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  8004f6:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004f8:	ec06                	sd	ra,24(sp)
  8004fa:	f83a                	sd	a4,48(sp)
  8004fc:	fc3e                	sd	a5,56(sp)
  8004fe:	e0c2                	sd	a6,64(sp)
  800500:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  800502:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  800504:	c89ff0ef          	jal	ra,80018c <vprintfmt>
}
  800508:	60e2                	ld	ra,24(sp)
  80050a:	6161                	addi	sp,sp,80
  80050c:	8082                	ret

000000000080050e <main>:
#include <string.h>
#include <stdlib.h>


int
main(void) {
  80050e:	1141                	addi	sp,sp,-16
    //open this!
    cprintf("\n-------ex1---start------\n");
  800510:	00000517          	auipc	a0,0x0
  800514:	37050513          	addi	a0,a0,880 # 800880 <error_string+0xc8>
main(void) {
  800518:	e406                	sd	ra,8(sp)
    cprintf("\n-------ex1---start------\n");
  80051a:	ba9ff0ef          	jal	ra,8000c2 <cprintf>
    set_priority(5);
  80051e:	4515                	li	a0,5
  800520:	b63ff0ef          	jal	ra,800082 <set_priority>
    cprintf("-------ex1----end-------\n\n");
  800524:	00000517          	auipc	a0,0x0
  800528:	37c50513          	addi	a0,a0,892 # 8008a0 <error_string+0xe8>
  80052c:	b97ff0ef          	jal	ra,8000c2 <cprintf>
}
  800530:	60a2                	ld	ra,8(sp)
  800532:	4501                	li	a0,0
  800534:	0141                	addi	sp,sp,16
  800536:	8082                	ret

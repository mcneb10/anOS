#include "SYS1.h"
uint16* screen;
uint16 curX;
uint16 curY;
uint16 width; //80 column default
uint16 height;//25 row default
uint8 fgcolor;//text white by default
uint8 bgcolor; //background black by default
uint8 fbcombine(uint8 fg, uint8 bg) {
    return fg | bg << 4;
}
uint16 cc2ve(unsigned char c, uint8 color) {
    return (uint16)c | (uint16)color << 8;
}
uint16 curPosToIndex(uint16 x, uint16 y) {
	return (y*width)+x;
}
void clrscreen(void) {
    for(uint16 y = 0; y < height; y++) {
        for(uint16 x = 0; x < width; x++) {
            screen[curPosToIndex(x,y)]=cc2ve(' ',fbcombine(fgcolor,bgcolor));
        }
    }
    curX = 0;
    curY = 0;
}
void screeninit(void) {
    bgcolor = 0;
    fgcolor = 7;
    height = 25;
    width = 80;
    curY = 0;
    curX = 0;
    screen = (uint16*)0xb8000;
    clrscreen();
}

char* itoa(int i, char b[]){
    char const digit[] = "0123456789";
    char* p = b;
    if(i<0){
        *p++ = '-';
        i *= -1;
    }
    int shifter = i;
    do{ //Move to where representation ends
        ++p;
        shifter = shifter/10;
    }while(shifter);
    *p = '\0';
    do{ //Move back, inserting digits as u go
        *--p = digit[i%10];
        i = i/10;
    }while(i);
    return b;
}
void functest(void) {
    putc('X');
}

void putc(char c) {
    if(c=='\n') {
        curX = 0;
        if(curY==height) {
            //at end of screen
            curY=0;
        } else {
            //advance to next line
            curY++;
        }
        return;
    }
    if(c=='\r') {
        curX=0;
        return;
    }
	screen[curPosToIndex(curX,curY)] = cc2ve(c,fbcombine(fgcolor,bgcolor));
    if(curX==width) {
        //at end of line
        curX=0;
        if(curY==height) {
            //at end of screen
            curY=0;
        } else {
            //advance to next line
            curY++;
        }
    }  else {
        //advance to next column
        curX++;
    }
}
uint16 strlen(const char* in) {
    uint16 i = 0;
    while(in[i]) 
	    i++;
    return i;
}
void println(const char* in) {
    print(in);
    print("\n");
}
void print(const char* in) {
    for(uint16 i = 0; i < strlen(in);i++) {
        putc(in[i]);
    }
}

uint8 in(uint16 port)
{
    unsigned char ret;
    asm volatile (
        "inb %1, %0"
        : "=a" (ret)
        : "dN" (port)
    );
    return ret;
}
void out(uint16 port, uint8 data)
{
    asm volatile (
        "outb %1, %0"
        : : "dN" (port), "a" (data)
    );
}
void SYS1ENTRY(void)
{
    screeninit();
    //asm ("mov ah, 0x0e");
    const char* cmsg = "Hello from C!";
    /*
    uint8 c = strlen(cmsg)+32;//0x62;
    asm (
        "mov al, %0"
        :
        : "r"(c)
        : "%al"
    );
    while(1) {
        asm("int 0x10");
    }*/
    //println(cmsg);  
    //__asm__ __volatile__ ("jmp $");
    fgcolor=15;
    bgcolor=1;
    putc('a');
    putc('d');
    putc(cmsg[1]);
    print("Hello from C!");
    while(1);
}

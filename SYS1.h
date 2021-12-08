#ifndef SYS1_H
#define SYS1_H
#include "inc/stuff.h"
uint16* screen;
void SYS1ENTRY();
uint8 fbcombine(uint8 fg, uint8 bg);
uint16 cc2ve(unsigned char c, uint8 color);
uint16 curPosToIndex(uint16 x, uint16 y);
void clrscreen();
void screeninit();
uint16 strlen(const char* in);
void putc(char c);
void functest();
int vidIndex;
void print(const char* in);
void println(const char* in);
#endif
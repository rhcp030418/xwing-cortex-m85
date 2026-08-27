#include <stdint.h>
#include <string.h>
#include "uart.h"
void fe25519_mul_mve(uint32_t r[10], const uint32_t a[10], const uint32_t b[10]);
static const uint8_t LOFF[10]={0,26,51,77,102,128,153,179,204,230};
static void enable_mve(void){ volatile uint32_t*c=(volatile uint32_t*)0xE000ED88u; *c|=(0xFu<<20);
    __asm__ volatile("dsb":::"memory"); __asm__ volatile("isb":::"memory"); }

int main(void)
{
    uart_init(); enable_mve();
    uart_puts("== single-limb probe: a[i]=1, b[j]=1 ==\n");
    uint32_t bad = 0;
    for (int i=0;i<10;i++) for (int j=0;j<10;j++) {
        uint32_t a[10]={0},b[10]={0},r[10];
        a[i]=1; b[j]=1;
        fe25519_mul_mve(r,a,b);
        /* 기대: 열 k=i+j, 자리 off_i+off_j.  k<10 이면 limb k 에 2^(off_i+off_j-off_k),
         * k>=10 이면 wrap 하여 limb k-10 에 19*2^(off_i+off_j-255-off_{k-10}) */
        int k=i+j; uint32_t elimb, eval;
        if (k<10){ elimb=k; eval=1u<<((LOFF[i]+LOFF[j])-LOFF[k]); }
        else { elimb=k-10; eval=19u<<((LOFF[i]+LOFF[j])-255-LOFF[k-10]); }
        uint32_t ok=1;
        for (int m=0;m<10;m++){ uint32_t want=(m==(int)elimb)?eval:0u; if(r[m]!=want) ok=0; }
        if(!ok){ bad++;
            if (bad<=12){ uart_puts("  BAD i="); uart_put_u32(i); uart_puts(" j="); uart_put_u32(j);
              uart_puts(" k="); uart_put_u32(k);
              uart_puts(" want limb"); uart_put_u32(elimb); uart_puts("="); uart_put_u32(eval);
              uart_puts("  got:"); for(int m=0;m<10;m++){uart_puts(" ");uart_put_u32(r[m]);} uart_puts("\n"); } }
    }
    uart_puts("single-limb bad="); uart_put_u32(bad); uart_puts(" / 100\n");
    qemu_exit(0); return 0;
}

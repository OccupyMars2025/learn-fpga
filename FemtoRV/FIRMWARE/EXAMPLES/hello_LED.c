#include <femtorv32.h>

int main() {
   MAX7219_tty_init(); // redirect printf() to led matrix scroller   
   for(;;) {
//      printf("Hello, RISC-V world !!! ");
        printf("Hello ENSG !!! ........... GOCAD RULZ !!! ");
   }

   return 0;
}


#include "defs.h"

extern char bss[];
extern char ebss[];

void main(uint64 mhartid, uint64 dtb_address){
  if(!mhartid){
    //the 1st core
  }
  else{
    //other cores
  }
}

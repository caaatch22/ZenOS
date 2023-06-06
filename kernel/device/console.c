#include "device/console.h"
#include "sbi/sbi.h"
#include "fs/vfs.h"
#include "common/common.h"
#include "utils/string.h"

#define CONSOLE_BUF_SIZE 128

void consputc(int c)
{
  console_putchar(c);
}

void console_init()
{
  // DO NOTHING
}

int consoleread_file(struct inode *ip, uint32_t usr, uint64_t dst, uint32_t off, uint32_t n)
{
  return 0;
}

int consolewrite_file(struct inode *ip, uint32_t usr, uint64_t src, uint32_t off, uint32_t n)
{
  char output[CONSOLE_BUF_SIZE];
  if(usr) {
    copyin2(output, src, n);
  }
  else {
    memcpy(output, src, n);
  }
  print(output);

  return n;
}

struct file_op devfs_file_op_console = {
  .read = consoleread_file,
  .write = consolewrite_file,
  .readdir = NULL,
};

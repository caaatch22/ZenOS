// #include "proc/proc.h"
// /**
//  * wait for child process with pid to exit
//  */
// int wait(int pid, int *wstatus_va, int options, void* rusage)
// {
//   struct proc *p = curr_proc();
//   struct proc *maybe_child;

//   acquire_spinlock(&wait_lock);

//   for (;;) {

//     bool havekids = FALSE;
//     for (maybe_child = pool; maybe_child < &pool[NPROC]; maybe_child++) {
//       if (maybe_child->parent == p) {
//         acquire_spinlock(&maybe_child->lock);

//         if (pid < 0 || maybe_child->pid == pid) {// this is one of the target
//           havekids = TRUE;
//           if (maybe_child->state == ZOMBIE) {
//             // Found one.
//             int child_pid = maybe_child->pid;
//             int wstatus = maybe_child->exit_code;
//             // construct the wait status
//             // see WEXITSTATUS
//             wstatus = (wstatus & 0xff) << 8;
//             if (wstatus_va && copyout(p->pagetable, (uint64_t)wstatus_va, (char *)&wstatus, sizeof(wstatus)) < 0) {
//               release_spinlock(&maybe_child->lock);
//               release_spinlock(&wait_lock);
//               return -1;
//             }
//             freeproc(maybe_child);
//             release_spinlock(&maybe_child->lock);
//             release_spinlock(&wait_lock);
//             return child_pid;
//           }
//         }
//         release_spinlock(&maybe_child->lock);
//       }
//     }

//     if (!havekids || p->killed) {
//       release_spinlock(&wait_lock);
//       return -1;
//     }

//     // No child has exited.
//     // if WNOHANG is set, return 0 immediately.
//     if (options & WNOHANG) {
//       release_spinlock(&wait_lock);
//       return 0;
//     } 
//     // Wait for a child to exit.
//     sleep(p, &wait_lock); 
//   }
// }

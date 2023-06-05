#ifndef ASSERT_H
#define ASSERT_H

// two macros ensures any macro passed will
// be expanded before being stringified
#define STRINGIZE_DETAIL(x) #x
#define STRINGIZE(x) STRINGIZE_DETAIL(x)

/**
 * @brief usage: ASSERT(var == 1, "var should be 1");
 */
#define ASSERT(exp, msg) \
  do {                   \
    if (!(exp))        \
      PANIC(" Assert failed in ["__FILE__ ":" STRINGIZE(__LINE__) "]: \"" #exp "\" " msg);         \
  } while (0)

#endif // ASSERT_H

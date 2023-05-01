#ifndef LOG_H
#define LOG_H

extern void print(char *fmt, ...);
extern int threadid();
extern void shutdown();

enum LOG_COLOR {
  RED = 31,
  GREEN = 32,
  BLUE = 34,
  GRAY = 90,
  YELLOW = 93,
};

#if defined(LOG_LEVEL_ERROR)

#define USE_LOG_ERROR

#endif // LOG_LEVEL_ERROR

#if defined(LOG_LEVEL_WARN)

#define USE_LOG_ERROR
#define USE_LOG_WARN

#endif // LOG_LEVEL_ERROR

#if defined(LOG_LEVEL_INFO)

#define USE_LOG_ERROR
#define USE_LOG_WARN
#define USE_LOG_INFO

#endif // LOG_LEVEL_INFO

#if defined(LOG_LEVEL_DEBUG)

#define USE_LOG_ERROR
#define USE_LOG_WARN
#define USE_LOG_INFO
#define USE_LOG_DEBUG

#endif // LOG_LEVEL_DEBUG

#if defined(LOG_LEVEL_TRACE)

#define USE_LOG_ERROR
#define USE_LOG_WARN
#define USE_LOG_INFO
#define USE_LOG_DEBUG
#define USE_LOG_TRACE

#endif // LOG_LEVEL_TRACE

void dummy(int _, ...) {}

#if defined(USE_LOG_ERROR)
#define LOG_ERROR(fmt, ...)                                                       \
  do {                                                                   \
    int tid = threadid();                                          \
    print("\x1b[%dm[%s %d]" fmt "\x1b[0m\n", RED, "ERROR", tid,   \
           ##__VA_ARGS__);                                         \
  } while (0)
#else
#define LOG_ERROR(fmt, ...) dummy(0, ##__VA_ARGS__)
#endif // USE_LOG_ERROR

#if defined(USE_LOG_WARN)
#define LOG_WARN(fmt, ...)                                                        \
  do {                                                                   \
    int tid = threadid();                                          \
    print("\x1b[%dm[%s %d]" fmt "\x1b[0m\n", YELLOW, "WARN", tid, \
          ##__VA_ARGS__);                                         \
  } while (0)
#else
#define LOG_WARN(fmt, ...) dummy(0, ##__VA_ARGS__)
#endif // USE_LOG_WARN

#if defined(USE_LOG_INFO)
#define LOG_INFO(fmt, ...)                                                        \
  do {                                                                   \
    int tid = threadid();                                          \
    print("\x1b[%dm[%s %d]" fmt "\x1b[0m\n", BLUE, "INFO", tid,   \
          ##__VA_ARGS__);                                         \
  } while (0)
#else
#define LOG_INFO(fmt, ...) dummy(0, ##__VA_ARGS__)
#endif // USE_LOG_INFO

#if defined(USE_LOG_DEBUG)
#define LOG_DEBUG(fmt, ...)                                                       \
  do {                                                                   \
    int tid = threadid();                                          \
    print("\x1b[%dm[%s %d]" fmt "\x1b[0m\n", GREEN, "DEBUG", tid, \
          ##__VA_ARGS__);                                         \
  } while (0)
#else
#define LOG_DEBUG(fmt, ...) dummy(0, ##__VA_ARGS__)
#endif // USE_LOG_DEBUG

#if defined(USE_LOG_TRACE)
#define LOG_TRACE(fmt, ...)                                                       \
  do {                                                                   \
    int tid = threadid();                                          \
    print("\x1b[%dm[%s %d]" fmt "\x1b[0m\n", GRAY, "TRACE", tid,  \
          ##__VA_ARGS__);                                         \
  } while (0)
#else
#define LOG_TRACE(fmt, ...) dummy(0, ##__VA_ARGS__)
#endif // USE_LOG_TRACE

#define PANIC(fmt, ...)                                                        \
  do {                                                                   \
    int tid = threadid();                                          \
    print("\x1b[%dm[%s %d] %s:%d: " fmt "\x1b[0m\n", RED,         \
          "PANIC", tid, __FILE__, __LINE__, ##__VA_ARGS__);       \
    shutdown();                                                    \
  } while (0)




#endif  // LOG_H
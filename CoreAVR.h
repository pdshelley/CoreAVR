// import header files or add definitions here that you want to be visible
// within Swift via the clang importer

// note that many gcc constructs will not work, if you are having trouble
// getting something to compile, add a normal .c file (and optionally header)
// with wrapper functions, then declare the wrapper function here instead

#define cpuFrequency F_CPU


#include <stdint.h>

/**
 * @brief Read a 32-bit value from a volatile pointer.
 * @param ptr The pointer to read from.
 * @return The value read.
 */
static inline uint8_t _volatileRegisterReadUInt8(uintptr_t address) {
  volatile uint8_t *ptr = (volatile uint8_t *)address;
  return *ptr;
}

/**
 * @brief Write a 32-bit value to a volatile pointer.
 * @param ptr The pointer to write to.
 * @param value The value to write.
 */
static inline void _volatileRegisterWriteUInt8(uintptr_t address, uint8_t value) {
  volatile uint8_t *ptr = (volatile uint8_t *)address;
  *ptr = value;
}

/**
 * @brief Read a 32-bit value from a volatile pointer.
 * @param ptr The pointer to read from.
 * @return The value read.
 */
static inline uint16_t _volatileRegisterReadUInt16(uintptr_t address) {
  volatile uint16_t *ptr = (volatile uint16_t *)address;
  return *ptr;
}

/**
 * @brief Write a 32-bit value to a volatile pointer.
 * @param ptr The pointer to write to.
 * @param value The value to write.
 */
static inline void _volatileRegisterWriteUInt16(uintptr_t address, uint16_t value) {
  volatile uint16_t *ptr = (volatile uint16_t *)address;
  *ptr = value;
}


static inline void _noOpperation() {
    asm volatile("nop");
}

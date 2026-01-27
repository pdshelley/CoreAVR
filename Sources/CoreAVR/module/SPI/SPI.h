//
//  SPI.h
//  CoreAVR
//
//  Created by Paul Shelley on 1/23/26.
//



// Version that works for recieving as well as sending, slightly slower than just sending. This only works for SPI_CLOCK_DIV2:
static inline void _fastSpiTransmitReceiveDIV2(const void *txbuf, void *rxbuf, unsigned int len) {
  if (len == 0) return;

  // Clear receive buffer first
  uint8_t *p = (uint8_t *)rxbuf;
  for (unsigned int i = 0; i < len; i++) {
    p[i] = 0;
  }

  asm volatile (
    "ld __tmp_reg__,%a[txbuf]+ \n\t"      // 2 - load first tx byte
    "out %[spdr],__tmp_reg__ \n\t"        // 1 - transmit first byte
    "sbiw %[len],1 \n\t"                  // 2 - decrement len
    "breq LAST_%= \n\t"                   // 2/1 - if zero, go to last read

    "LOOP_%=: \n\t"
      "rjmp .+0 \n\t"                     // 2
      "rjmp .+0 \n\t"                     // 2
      "rjmp .+0 \n\t"                     // 2
      "rjmp .+0 \n\t"                     // 2
      "rjmp .+0 \n\t"                     // 2
      "rjmp .+0 \n\t"                     // 2
      "nop \n\t"                          // 1  (total wait: 13 cycles)

      "in __tmp_reg__,%[spdr] \n\t"       // 1 - read rx byte
      "st %a[rxbuf]+,__tmp_reg__ \n\t"    // 2 - store rx byte
      "ld __tmp_reg__,%a[txbuf]+ \n\t"    // 2 - load next tx byte
      "out %[spdr],__tmp_reg__ \n\t"      // 1 - transmit next byte

      "sbiw %[len],1 \n\t"                // 2
      "brne LOOP_%= \n\t"                 // 2/1

    "LAST_%=: \n\t"
      "rjmp .+0 \n\t"                     // 2
      "rjmp .+0 \n\t"                     // 2
      "rjmp .+0 \n\t"                     // 2
      "rjmp .+0 \n\t"                     // 2
      "rjmp .+0 \n\t"                     // 2
      "rjmp .+0 \n\t"                     // 2
      "nop \n\t"                          // 1  (total wait: 13 cycles)

      "in __tmp_reg__,%[spdr] \n\t"       // 1 - read last rx byte
      "st %a[rxbuf]+,__tmp_reg__ \n\t"    // 2 - store last rx byte

      "nop \n\t"                          // 1 - balance final cycle

    : [txbuf] "+e" (txbuf),
      [rxbuf] "+e" (rxbuf),
      [len] "+w" (len)
    :
      [spdr] "I" (0x2E) // I/O Address space of the SPDR register. TODO: This needs to be generated from ATDF.
    : "cc"
  );
}


// Original Code, this only works for SPI_CLOCK_DIV2:
static inline void _fastSPITransmitDIV2(const void *buf , unsigned int len) {

  if (len == 0) return;
    
  asm volatile (
        "LOOP_LEN_%=:           \n\t"
                                                //  Cycles
          "ld __tmp_reg__,%a[buf]+   \n\t"      //     2 - load tx byte
          "out %[spdr],__tmp_reg__   \n\t"      //     1 - transmit byte
          "rjmp   .+0               \n\t"       //     2
          "rjmp   .+0               \n\t"       //     2
          "rjmp   .+0               \n\t"       //     2
          "rjmp   .+0               \n\t"       //     2
          "rjmp   .+0               \n\t"       //     2
          "rjmp   .+0               \n\t"       //     2
          "nop                      \n\t"       //     1 - total wait: 13 cycles
          "sbiw %[len], 1           \n\t"       //     2
          "brne LOOP_LEN_%=         \n\t"       //     2
          "nop                      \n\t"       //     1 - use up the cycle we saved from the above branch not taken, this makes sure that if we have two transmits in a row, the second one will not step on the first.
        : [buf]   "+e" (buf),
          [len]   "+w" (len)
        : [spdr]  "I" (0x2E) // I/O Address space of the SPDR register. TODO: This needs to be generated from ATDF.
        : "cc", "r0"
  );
}

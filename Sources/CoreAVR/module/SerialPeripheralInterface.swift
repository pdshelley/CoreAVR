//
//  SerialPeripheralInterface.swift
//  SwiftForArduino
//
//  Created by xander rasschaert & Paul Shelley on 25/04/2023.
//

/// SPI🤞🏼– Serial Peripheral Interface
///
/// 19.1 Features
/// • Full-duplex, Three-wire Synchronous Data Transfer • Master or Slave Operation
/// • LSB First or MSB First Data Transfer
/// • Seven Programmable Bit Rates
/// • End of Transmission Interrupt Flag
/// • Write Collision Flag Protection
/// • Wake-up from Idle Mode
/// • Double Speed (CK/2) Master SPI Mode
///
/// 19.2 Overview
/// The Serial Peripheral Interface (SPI) allows high-speed synchronous data transfer between the ATmega48A/PA/88A/PA/168A/PA/328/P and peripheral devices or between several AVR devices.
/// The USART can also be used in Master SPI mode, see “USART in SPI Mode” on page 205. The PRSPI bit in ”Minimizing Power Consumption” on page 51 must be written to zero to enable SPI module.
///
/// ```
///                                       SPI Block Diagram
///
///                                                                                 ┌───────┐
///                                 ┌──────────────────────────────────────────●───▶│S      │     ┌────┐
///                                 │   ┌────────────────────────────────────┐ │ ┌──│M      ├─────┤MISO│
///               XTAL              │   │     MSB                    LSB     │ └─┼─▶│M      │     └────┘
///                 │               │   │    ┌──────────────────────────┐    │   │  │       │     ┌────┐
///                 │               └───┤    │   8 BIT SHIFT REGISTER   │◀ ─ ┼ ─ ●──┤S      ├─────┤MOSI│
///                 ▼                   │    ├──────────────────────────┤    │      │       │     └────┘
///     ┌──────────────────────┐        │    │     READ DATA BUFFER     │    │      │       │
///     │       DIVIDER        │        │    └──────────────────────────┘    │      │  PIN  │
///     │ /2/4/8/16/32/64/128  │        │                                    │      │CONTROL│
///     └─────┬───┬──┬───┬─────┘        └────────────────────────────────────┘      │ LOGIC │
///           │   │  │   │                       ▲                  ▲               │       │
///           ▼   ▼  ▼   ▼                       ▼                  │ CLOCK         │       │
///        ┌────────────────┐ SPI CLOCK (MASTER) │            ┌─────┴─────┐         │       │
///        │                ├────────────────────┼───────────▶│           │         │       │     ┌────┐
///        │     SELECT     │                    │            │   CLOCK   │◀────────┤S      ├─────┤SCK │
///        │                │    ┌───────────────┼────────────┤   LOGIC   │         │       │     └────┘
///        └────────────────┘    │  ┌────────────┼───────────▶│           ├────────▶│M      │     ┌────┐
///          S▲  S▲  S ▲         │  │            │            └───────────┘         │       ├─────┤ SS │
///          P│  P│  P │         │  │            │              ▲  ▲  ▲             │       │     └────┘
///          I│  R│  R │         │  │  ┌─────────┼──────────────┼──┼──┼─────────────┤       │
///          2│  1│  2 │         │  │  │         │              │  │  │             └───────┘
///          X│   │    └─────────┼──┼──┼─────────┼──────────────┼──┼──┼─────┐       M▲ S▲ D▲
///     ┌─────┘   └──────────────┼──┼──┼─────────┼──────────────┼──┼──┼──┐  │       S│ P│ O│
///     │                        │  │  │         │              │  │  │  │  │       T│ E│ R│
///     │                        ▼  │  ▼  MSTR   │              │  │  │  │  │       R│  │ D│
///     │  ┌────────────────────────┴───┐◀───────┼──────────────●──┼──┼──┼──┼────────┘  │  │
///     │  │                            │ SPE    │              │  │  │  │  │           │  │
///     │  │        SPI CONTROL         │◀───────┼────────●─────┼──┼──┼──┼──┼───────────┘  │
///     │  │                            │        │        │     │  │  │  │  │              │
///     │  └─┬──┬────────────────────┬──┘◀───────┼─────┐  │  ┌──┼──┼──┼──┼──┼──────────────┘
///     │    │  │                ▲   │           │     │  │  │  │  │  │  │  │
///     └────┼──┼────────────────●   │           │     │  │  │  │  │  │  │  │
///          │  │               S│   │           │     │  │  │  │  │  │  │  │
///         S│ W│               P│   │           │    S│  │ D│ M│ C│ C│ S│ S│
///         P│ C│               I│   │           │    P│ S│ O│ S│ P│ P│ P│ P│
///         I│ O│               2│   │          8/    I│ P│ R│ T│ O│ H│ R│ R│
///         F▼ L▼   │  │  │  │  X│   │           │    E│ E│ D│ R│ L│ A│ 1│ 0│
///        ┌────────┴──┴──┴──┴───┴─┐ │           │   ┌─┴──┴──┴──┴──┴──┴──┴──┴┐
///        │  SPI STATUS REGISTER  │ │           │   │ SPI CONTROL REGISTER  │
///        └───────────┬───────────┘ │           │   └───────────────────────┘
///                    │             │     8     │  8            ▲
///                    └───────▶─────┼──────/────┼───/────◀─▶────┘
///                                  │           │
///                                  │           ▲
///                                  │           │
///                                  ▼           ▼
///                            SPI INTERRUPT  INTERNAL
///                               REQUEST     DATA BUS
/// ```
public enum SPI {
    public enum ClockPolarity: UInt8 {
        case rising = 0  // Leading rising, trailing falling.
        case falling = 1 // Leading falling, trailing rising.
    }
    
    public enum ClockPhase: UInt8 {
        case sample = 0  // Leading sample, trailing setup.
        case setup = 1   // Leading setup, trailing sample.
    }
    
    // Below data from testing on an Arduino Uno R3
    // nothing = 4 MHz (240 ns)
    // .f4 = 0     4 MHz (240 ns)
    // .f16 = 1    1 MHz (1 us)
    // .f64 = 2  250 kHz (4 us)
    // .f128 = 3 125 kHz (8 us)
    // .f2 = 4     8 MHz (120 ns)
    // .f8 = 5     2 MHz (480 ns)
    // .f32 = 6  500 kHz (2 us)
    // .64_2 = 7 250 kHz (4 us)
    public enum ClockRateSelect: UInt8 {
        case f4 = 0
        case f16 = 1
        case f64 = 2
        case f128 = 3
        case f2 = 4
        case f8 = 5
        case f32 = 6
        case f64_2 = 7
    }
    
    /// ```
    /// |--------|-------|-------|----------------------------------------------------------------------|
    /// |  Mode  | CPOL  | CPHA  | Description                                                          |
    /// |--------|-------|-------|----------------------------------------------------------------------|
    /// |    0   |   0   |   0   | Data sampled on rising edge and shifted out on the falling edge.     |
    /// |--------|-------|-------|----------------------------------------------------------------------|
    /// |    1   |   0   |   0   | Data sampled on the falling edge and shifted out on the rising edge. |
    /// |--------|-------|-------|----------------------------------------------------------------------|
    /// |    2   |   0   |   1   | Data sampled on the falling edge and shifted out on the rising edge. |
    /// |--------|-------|-------|----------------------------------------------------------------------|
    /// |    3   |   0   |   1   | Data sampled on the rising edge and shifted out on the falling edge  |
    /// |--------|-------|-------|----------------------------------------------------------------------|
    /// ```
    public enum Mode: UInt8 {
        case zero = 0
        case one = 1
        case two = 2
        case three = 3
    }
}

public protocol SPIPort {
    // this will probably(?) always be UInt8, but is useful for preventing the protocol
    // from ever accidentally being used as an existential type
    associatedtype PortDataType: BinaryInteger
    
    static var controlRegister: UInt8 { get set }
    static var statusRegister: UInt8 { get set }
    static var dataRegister: PortDataType { get set } // TODO: Are there 16 bit SPI ports?
}

public typealias spi0 = SPI0

public struct SPI0: SPIPort {
    /// 19.5.1 SPCR – SPI Control Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | 0x2C (0x4C)  |  SPIE |  SPE  |  DORD |  MSTR | CPOL  |  CPHA |  SPR1 |  SPR0 |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var controlRegister: UInt8 {
        get {
            return _volatileRegisterReadUInt8(0x4C)
        }
        set {
            _rawPointerWrite(address:0x4C, value: newValue)
        }
    }
    
    /// SPI Interrupt Enable
    /// See ATMega328p Datasheet Section 19.5.1.
    /// SPIE is bit 7 on SPCR.
    ///
    /// This bit causes the SPI interrupt to be executed if SPIF bit in the SPSR Register is set and the if
    /// the Global Interrupt Enable bit in SREG is set.
    @inlinable
    @inline(__always)
    public static var interruptEnable: Bool { //SPIE
        get {
            return !((controlRegister & 0b10000000) == 0)
        }
        set {
            controlRegister = (controlRegister & ~0b10000000) | ((newValue ? 1 : 0) << 7 & 0b10000000)
        }
    }
    
    /// SPI  Enable
    /// See ATMega328p Datasheet Section 19.5.1.
    /// SPE is bit 6 on SPCR.
    ///
    /// When the SPE bit is written to one, the SPI is enabled. This bit must be set to enable any SPI operations.
    @inlinable
    @inline(__always)
    public static var enable: Bool { //SPE
        get {
            return !((controlRegister & 0b01000000) == 0)
        }
        set {
            controlRegister = (controlRegister & ~0b01000000) | ((newValue ? 1 : 0) << 6 & 0b01000000)
        }
    }
    
    /// SPI  DataOrder
    /// See ATMega328p Datasheet Section 19.5.1.
    /// DORD is bit 5 on SPCR.
    ///
    /// When the DORD bit is written to one, the LSB of the data word is transmitted first.
    /// When the DORD bit is written to zero, the MSB of the data word is transmitted first.
    @inlinable
    @inline(__always)
    public static var dataOrder: Bool { // DORD
        get {
            return !((controlRegister & 0b00100000) == 0)
        }
        set {
            controlRegister = (controlRegister & ~0b00100000) | ((newValue ? 1 : 0) << 5 & 0b00100000)
        }
    }
    
    /// SPI  DataOrder
    /// See ATMega328p Datasheet Section 19.5.1.
    /// MSTR is bit 4 on SPCR.
    ///
    /// This bit selects Master SPI mode when written to one, and Slave SPI mode when written logic zero.
    /// If SS is configured as an input and is driven low while MSTR is set, MSTR will be cleared, and SPIF in SPSR
    /// will become set. The user will then have to set MSTR to re-enable SPI Master mode.
    @inlinable
    @inline(__always)
    public static var masterSlaveSelect: Bool { // MSTR
        get {
            return !((controlRegister & 0b00010000) == 0)
        }
        set {
            controlRegister = (controlRegister & ~0b00010000) | ((newValue ? 1 : 0) << 4 & 0b00010000)
        }
    }
    
    /// Clock Polarity
    /// See ATMega328p Datasheet Section 19.5.1.
    /// CPOL is bit 3 on SPCR
    ///
    /// When this bit is written to one, SCK is high when idle. When CPOL is written to zero, SCK is low when idle.
    /// Refer to Figure 19-3 and Figure 19-4 for an example. The CPOL functionality is summarized below:
    ///
    /// ```
    ///| CPOL  | Leading Edge | Trailing Edge |
    ///|-------|--------------|---------------|
    ///| 0     | Rising       | Falling       |
    ///| 1     | Falling      | Rising        |
    /// ```
    @inlinable
    @inline(__always)
    public static var clockPolarity: SPI.ClockPolarity { // CPOL
        get {
            let mode = (controlRegister & 0b00001000) >> 3
            return SPI.ClockPolarity.init(rawValue: mode) ?? .rising
        }
        set {
            controlRegister = (controlRegister & ~0b00001000) | ((newValue.rawValue << 3) & 0b00001000)
        }
    }

    /// Clock Phase
    /// See ATMega328p Datasheet Section 19.5.1.
    /// CPHA is bit 2 on SPCR
    ///
    /// The settings of the Clock Phase bit (CPHA) determine if data is sampled on the leading (first) or trailing (last)
    /// edge of SCK. Refer to Figure 19-3 and Figure 19-4 for an example. The CPOL functionality is summarized below:
    ///
    /// ```
    ///| CPHA  | Leading Edge | Trailing Edge |
    ///|-------|--------------|---------------|
    ///| 0     | Sample       | Setup         |
    ///| 1     | Setup        | Sample        |
    /// ```
    @inlinable
    @inline(__always)
    public static var clockPhase: SPI.ClockPhase { // CPHA
        get {
            let mode = (controlRegister & 0b00000100) >> 2
            return SPI.ClockPhase.init(rawValue: mode) ?? .sample
        }
        set {
            controlRegister = (controlRegister & ~0b00000100) | ((newValue.rawValue << 2) & 0b00000100)
        }
    }
    
    /// SPI Mode
    /// Not in the Datasheet but a standard convention in SPI to define both the Clock Phase and Polarity in a single value. This is a
    /// convienience method to set both the clockPolarity and clockPhase at the same time. 
    ///
    /// In SPI, the Master can select the clock polarity and clock phase. The CPOL bit sets the polarity of the clock signal during the
    /// idle state. The idle state is defined as the period when CS is high and transitioning to low at the start of the transmission
    /// and when CS is low and transitioning to high at the end of the transmission. The CPHA bit selects the clock phase.
    /// Depending on the CPHA bit, the rising or falling clock edge is used to sample and/or shift the data. The main must select
    /// the clock polarity and clock phase, as per the requirement of the subnode. Depending on the CPOL and CPHA bit selection,
    /// four SPI modes are available.
    ///
    /// ```
    /// |--------|-------|-------|----------------------------------------------------------------------|
    /// |  Mode  | CPOL  | CPHA  | Description                                                          |
    /// |--------|-------|-------|----------------------------------------------------------------------|
    /// |    0   |   0   |   0   | Data sampled on rising edge and shifted out on the falling edge.     |
    /// |--------|-------|-------|----------------------------------------------------------------------|
    /// |    1   |   0   |   0   | Data sampled on the falling edge and shifted out on the rising edge. |
    /// |--------|-------|-------|----------------------------------------------------------------------|
    /// |    2   |   0   |   1   | Data sampled on the falling edge and shifted out on the rising edge. |
    /// |--------|-------|-------|----------------------------------------------------------------------|
    /// |    3   |   0   |   1   | Data sampled on the rising edge and shifted out on the falling edge  |
    /// |--------|-------|-------|----------------------------------------------------------------------|
    /// ```
    @inlinable
    @inline(__always)
    public static var mode: SPI.Mode { // CPHA
        get {
            let mode = (controlRegister & 0b00001100) >> 2
            return SPI.Mode.init(rawValue: mode) ?? .sample
        }
        set {
            controlRegister = (controlRegister & ~0b00001100) | ((newValue.rawValue << 2) & 0b00001100)
        }
    }
    
    /// SPI Clock Rate Select 1 and 0
    /// See ATMega328p Datasheet Section 24.9.2.
    /// SPR1, SPR0 are bits 1 and 0 on SPCR and SPI2X is bit 0 on SPSR
    ///
    /// These two bits control the SCK rate of the device configured as a Master. SPR1 and SPR0 have no effect on the Slave. The relationship between
    /// SCK and the Oscillator Clock frequency f_osc is shown in the following table:
    ///
    /// ```
    ///| SPI2X | SPR1  | SPR0  | SCK Frequency       |
    ///|-------|-------|-------|---------------------|
    ///| 0     | 0     | 0     | f_osc/4             |
    ///| 0     | 0     | 1     | f_osc/16            |
    ///| 0     | 1     | 0     | f_osc/64            |
    ///| 0     | 1     | 1     | f_osc/128           |
    ///| 1     | 0     | 0     | f_osc/2             |
    ///| 1     | 0     | 1     | f_osc/8             |
    ///| 1     | 1     | 0     | f_osc/32            |
    ///| 1     | 1     | 1     | f_osc/64            |
    /// ```
    @inlinable
    @inline(__always)
    public static var clockRateSelect: SPI.ClockRateSelect { // SPI2X, SPR[1:0]
        get {
            let mode = (controlRegister & 0b00000011) | ((statusRegister & 0b00000001) << 2)
            return SPI.ClockRateSelect.init(rawValue: mode) ?? .f4
        }
        set {
            controlRegister = (controlRegister & ~0b00000011) | ((newValue.rawValue) & 0b00000011)
            statusRegister = (statusRegister & ~0b00000001) | ((newValue.rawValue & 0b00000100) >> 2)
        }
    }
    
    /// 19.5.2 SPSR – SPI Status Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | 0x2D (0x4D)  |  SPIF |  WCOL |   -   |   -   |   -   |   -   |   -   | SPI2X |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |   R   |   R   |   R   |   R   |   R   |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var statusRegister: UInt8 {
        get {
            return _volatileRegisterReadUInt8(0x4D)
        }
        set {
            _rawPointerWrite(address:0x4D, value: newValue)
        }
    }
    
    
    
    /// Interrupt Flag
    /// See ATMega328p Datasheet Section 19.5.2.
    /// SPIF is bit 7 on SPSR.
    ///
    /// When a serial transfer is complete, the SPIF Flag is set. An interrupt is generated if SPIE in SPCR is set and global interrupts are enabled.
    /// If SS is an input and is driven low when the SPI is in Master mode, this will also set the SPIF Flag. SPIF is cleared by hardware when executing
    /// the corresponding interrupt handling vector. Alternatively, the SPIF bit is cleared by first reading the SPI Status Register with SPIF set,
    /// then accessing the SPI Data Register (SPDR).
    @inlinable
    @inline(__always)
    public static var interruptFlag: Bool { // SPIF
        get {
            return !((statusRegister & 0b10000000) == 0)
        }
        set {
            statusRegister = (statusRegister & ~0b10000000) | ((newValue ? 1 : 0) << 7 & 0b10000000)
        }
    }
    
    
    /// Write COLlision Flag
    /// See ATMega328p Datasheet Section 19.5.2.
    /// WCOL is bit 6 on SPSR.
    ///
    /// The WCOL bit is set if the SPI Data Register (SPDR) is written during a data transfer. The WCOL bit (and the SPIF bit) are cleared
    /// by first reading the SPI Status Register with WCOL set, and then accessing the SPI Data Register.
    @inlinable
    @inline(__always)
    public static var writeCollisionFlag: Bool { // WCOL
        get {
            return !((statusRegister & 0b01000000) == 0)
        }
        set {
            statusRegister = (statusRegister & ~0b01000000) | ((newValue ? 1 : 0) << 6 & 0b01000000)
        }
    }
    
    
    /// Double SPI Speed Bit
    /// See ATMega328p Datasheet Section 19.5.2.
    /// SPI2X is bit 0 on SPSR.
    ///
    /// When this bit is written logic one the SPI speed (SCK Frequency) will be doubled when the SPI is in Master mode (see Table 19-5).
    /// This means that the minimum SCK period will be two CPU clock periods. When the SPI is configured as Slave,
    /// the SPI is only ensured to work at fosc/4 or lower.
    /// The SPI interface on the ATmega48A/PA/88A/PA/168A/PA/328/P is also used for program memory and EEPROM downloading or uploading.
    /// See page 303 for serial programming and verification.
    
    @inlinable
    @inline(__always)
    public static var doubleSPISpeedBit: Bool { //SPI2X
        get {
            return !((statusRegister & 0b00000001) == 0)
        }
        set {
            statusRegister = (statusRegister & ~0b00000001) | ((newValue ? 1 : 0) & 0b00000001)
        }
    }
    
    /// 19.5.3 SPDR – SPI Data Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | 0x2E (0x4E)  |  MSB  |   -   |   -   |   -   |   -   |   -   |   -   |  LSB  |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |   R   |   R   |   R   |   R   |   R   |   R   |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   X   |   X   |   X   |   X   |   X   |   X   |   X   |   X   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var dataRegister: UInt8 {
        get {
            return _volatileRegisterReadUInt8(0x4E)
        }
        set {
            _rawPointerWrite(address:0x4E, value: newValue)
        }
    }
    
    @inlinable @inline(__always)
    @discardableResult public static func transmit(_ buffer: UnsafeMutableBufferPointer<UInt8>) -> UnsafeMutableBufferPointer<UInt8> {
        let recievedBuffer = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: buffer.count)
        
        for index in 0..<buffer.count {
            dataRegister = buffer[index]
            noOpperation() // If two bytes in a row are identical then the second one does not get sent without this No Opp here. // This is also not inlining as I would expect in the asm.
            while !interruptFlag { } // Needed even with out using interrupts to send more than one byte.
            noOpperation()
            recievedBuffer![index] = dataRegister
        }
        return recievedBuffer!
    }
    
    /// The lowest level of writing out data to hardware SPI.
    /// - Parameter byte: A single bite of data to be sent.
    @inlinable @inline(__always)
    @discardableResult public static func write(_ byte: PortDataType) -> PortDataType {
        dataRegister = byte // Save data to SPDR
        noOpperation() // If two bytes in a row are identical then the second one does not get sent without this No Opp here. // This is also not inlining as I would expect in the asm.
        while !interruptFlag { } // Needed even with out using interrupts to send more than one byte.
        return dataRegister
    }
    
//    // Write to the SPI bus (MOSI pin) and also receive (MISO pin)
//    inline static uint8_t transfer(uint8_t data) {
//      SPDR = data;
//      /*
//       * The following NOP introduces a small delay that can prevent the wait
//       * loop form iterating when running at the maximum speed. This gives
//       * about 10% more speed, even if it seems counter-intuitive. At lower
//       * speeds it is unnoticed.
//       */
//      asm volatile("nop");
//      while (!(SPSR & _BV(SPIF))) ; // wait // SPSR = SPI Status Register // SPIF is the Interupt flag
//      return SPDR;
//    }
    
    // TODO: This won't respect sending byte order for the least significant bit first. Fix.
    @inlinable @inline(__always) public static func write16(_ byte: UInt16) -> UInt16 {
        let highByte = write(UInt8((byte & 0b11111111_00000000) >> 8)) // Write High Byte
        let lowByte = write(UInt8(byte & 0b11111111)) // Write Low Byte
        return (UInt16(highByte) << 8) | UInt16(lowByte) // Data returned from the slave
    }
    
    // TODO: This won't respect sending byte order for the least significant bit first. Fix.
    @inlinable @inline(__always) public static func write32(_ byte: UInt32) -> UInt32 {
        let byte1 = write(UInt8((byte & 0b11111111_00000000_00000000_00000000) >> 24))
        let byte2 = write(UInt8((byte & 0b00000000_11111111_00000000_00000000) >> 16))
        let byte3 = write(UInt8((byte & 0b00000000_00000000_11111111_00000000) >> 8)) // Write High Byte
        let byte4 = write(UInt8(byte & 0b00000000_00000000_00000000_11111111)) // Write Low Byte
        return (UInt32(byte1) << 24) | (UInt32(byte2) << 16) | (UInt32(byte3) << 8) | UInt32(byte4) // Data returned from the slave
    }
    
//    @inlinable
//    @inline(__always)
//    public static func write(_ data: StaticString) { // TODO: Figure out why this is not working in the `extension SPIPort where PortDataType == UInt8` // Not sure we can actually write char, only UInt
//        for character in data {
//            write(character)
//        }
//    }
//    
//    @inlinable
//    @inline(__always)
//    public static func write(_ data: Data) { // TODO: Figure out why this is not working in the `extension SPIPort where PortDataType == UInt8` // Not sure we can actually write char, only UInt
//        for byte in data {
//            write(byte)
//        }
//    }
    
    
    // TODO: This sets up SPI as a Master. It can also be configured as a Slave. We need to be able to choose.
    // TODO: SPI supports different "modes" (1-4) this is in effect the settings for CPOL (ClockPolarity) and CPHA (ClockPhase). We need to support this. See https://www.ti.com/content/dam/videos/external-videos/en-us/6/3816841626001/6163521589001.mp4/subassets/basics-of-spi-serial-communications-presentation.pdf
    //
    @inlinable
    @inline(__always)
    public static func setup() { // setup(as _role: .master, and _mode: .zero)
        // Save SREG state // AVR Status Register // Is this really needed? // Is this saving the interrupt state?
        let savedStatus = cpuCore.statusRegister
        
        // Turn off interrupts // Is this really needed for my example as I am not using interrupts
        // TODO: I'm not sure why I was turning off interupts. I imagine that the state should be saved, turned off, settings changed, then turned back to the saved state.
        cpuCore.globalInterruptEnable = false

        // Set MSTR on SPCR // Master/Slave Select on the SPI Control Register, this puts SPI in Master mode as it can be either a Master or Slave.
        masterSlaveSelect = true // TODO: Change API Style for better clarity?
        // Set SPE on SPCR
        enable = true

        // Set as master and enable at the same time.
        //SPI0.controlRegister = 80 // 0b01010000 // Note: These CAN be set individually.

            // Set direction register for SCK and MOSI pin.
            // MISO pin automatically overrides to INPUT.
            // By doing this AFTER enabling SPI, we avoid accidentally
            // clocking in a single bit since the lines go directly
            // from "input" to SPI control.
            // http://code.google.com/p/arduino/issues/detail?id=888
        // Set SCK to Output
        GPIO.pb5.setDataDirection(.output) // SCK
        // Set MISO to Input
        GPIO.pb4.setDataDirection(.output) // MISO // TODO: I think this should be an input when acting as a Master?
        // Set MOSI to Output
        GPIO.pb3.setDataDirection(.output) // MOSI

        // Set SCK and MOSI to Output at the same time. // Note: These CAN be set individually.
        //GPIO.PORTB.dataDirection = 44 // 0b00101100


        // Restore state of SREG // Going to try skipping for now, see above. // Is this setting the interupts back to their saved state?
        cpuCore.statusRegister = savedStatus
        // Finished the "Begin" Function
    }
}

// TODO: The start of an idea to have a Slave object that contains all of the information needed to setup SPI for that particular device.
// These objects will be saved and managed by the end application but will wrap up all the basic functions needed in a simple object with default settings.
// Any setting should be able to be over written.
// There should be a way to include custom encoding and decoding of data to and from the slave device.
//public protocol SPISlave {
//    var port: SPIPort { get set }
//    func send() { }
//}



extension SPIPort where PortDataType == UInt8 {

    
//    void SPI_MasterInit(void) { // Master Receive?
//    }
//    /* Set MOSI and SCK output, all others input */
//    DDR_SPI = (1<<DD_MOSI)|(1<<DD_SCK);
//    /* Enable SPI, Master, set clock rate fck/16 */
//    SPCR = (1<<SPE)|(1<<MSTR)|(1<<SPR0);
//

    

//    @inlinable
//    @inline(__always)
//    public static func write(_ int: Int) {
//        var i = int
//        if i < 0 {
//            write("-")
//            i.negate()
//        }
//
//        let next = i / 10
//
//        if next > 0 {
//            write(next)
//        } else {
//            write(UInt8(i % 10) + 48)
//        }
//    }
}

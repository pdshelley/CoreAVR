//
//  EEPROM.swift
//  CoreAVR
//
//  Created by Paul Shelley on 2/19/26.
//


public typealias eeprom = EEPROM

public struct EEPROM {
    /// 10.6.2 EEARL and EEARH
    /// Offset: 0x41 [ID-000004d0]
    /// Reset: 0xXX
    /// Property: When addressing as I/O Register: address offset is 0x21
    ///
    /// The EEARL and EEARH register pair represents the 16-bit value, EEAR. The low byte [7:0] (suffix L) is
    /// accessible at the original offset. The high byte [15:8] (suffix H) can be accessed at offset + 0x01. For
    /// more details on reading and writing 16-bit registers, refer to accessing 16-bit registers in the section
    /// above.
    ///
    /// When addressing I/O registers as data space using LD and ST instructions, the provided offset must be
    /// used. When using the I/O specific commands IN and OUT, the offset is reduced by 0x20, resulting in an
    /// I/O address offset within 0x00 - 0x3F.
    ///
    /// The device is a complex microcontroller with more peripheral units than can be supported within the 64
    /// locations reserved in Opcode for the IN and OUT instructions. For the extended I/O space from 0x60 in
    /// SRAM, only the ST/STS/STD and LD/LDS/LDD instructions can be used.
    ///
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | EEARH        |   -   |   -   |   -   |   -   |   -   |   -   |   EEAR [9:8]  |
    /// --------------------------------------------------------------------------------
    /// | EEARL        |                          EEAR [7:0]                           |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   x   |   x   |   x   |   x   |   x   |   x   |   x   |   x   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var addressRegister: UInt16 {
        get {
            return UInt16(_volatileRegisterReadUInt8(0x42)) << 8 | UInt16(_volatileRegisterReadUInt8(0x41))
        }
        set {
            _volatileRegisterWriteUInt8(0x42, UInt8(newValue & 0x03FF >> 8))
            _volatileRegisterWriteUInt8(0x41, UInt8(newValue & 0xFF))
        }
    }
    
    /// Bits 9:0 – EEAR[9:0] EEPROM Address
    ///
    /// The EEPROM Address Registers, EEARH and EEARL, specify the EEPROM address in the 1 KB
    /// EEPROM space. The EEPROM data bytes are addressed linearly between 0 and 1023. The initial value
    /// of EEAR is undefined. A proper value must be written before the EEPROM may be accessed.
    
    
    
    /// Name: EEDR
    /// Offset: 0x40 [ID-000004d0]
    /// Reset: 0x00
    /// Property: When addressing as I/O Register: address offset is 0x20
    ///
    /// When addressing I/O registers as data space using LD and ST instructions, the provided offset must be
    /// used. When using the I/O specific commands IN and OUT, the offset is reduced by 0x20, resulting in an
    /// I/O address offset within 0x00 - 0x3F.
    ///
    /// The device is a complex microcontroller with more peripheral units than can be supported within the 64
    /// locations reserved in Opcode for the IN and OUT instructions. For the extend
    ///
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | EEDR         |                          EEDR [7:0]                           |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    ///
    /// For the EEPROM write operation, the EEDR register contains the data to be written to the EEPROM in
    /// the address given by the EEAR register. For the EEPROM read operation, the EEDR contains the data
    /// read out from the EEPROM at the address given by EEAR.
    @inlinable
    @inline(__always)
    public static var dataRegister: UInt8 {
        get {
            return _volatileRegisterReadUInt8(0x40) // TODO: Verify that this is 0x20 and not 0x40
        }
        set {
            _volatileRegisterWriteUInt8(0x40, newValue)
        }
    }
    
    
    /// EEPROM Control Register
    ///
    /// Name: EECR
    /// Offset: 0x3F [ID-000004d0]
    /// Reset: 0x00
    /// Property: When addressing as I/O register: address offset is 0x1F
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | EECR         |   -   |   -   |   EEPM [1:0]  | EERIE | EEMPE |  EEPE |  EERE |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   -   |   -   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   -   |   -   |   x   |   x   |   0   |   0   |   x   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var controlRegister: UInt8 {
        get {
            return _volatileRegisterReadUInt8(0x3F) // TODO: Verify that this is 0x1F and not 0x3F
        }
        set {
            _volatileRegisterWriteUInt8(0x3F, newValue)
        }
    }
    
    /// ```
    /// -------------------------------------------------------------------------------------------------
    /// |  Mode  | CPOL  | CPHA  | Description                                                          |
    /// -------------------------------------------------------------------------------------------------
    /// |    0   |   0   |   0   | Data sampled on rising edge and shifted out on the falling edge.     |
    /// -------------------------------------------------------------------------------------------------
    /// |    1   |   0   |   0   | Data sampled on the falling edge and shifted out on the rising edge. |
    /// -------------------------------------------------------------------------------------------------
    /// |    2   |   0   |   1   | Data sampled on the falling edge and shifted out on the rising edge. |
    /// -------------------------------------------------------------------------------------------------
    /// |    3   |   0   |   1   | Data sampled on the rising edge and shifted out on the falling edge  |
    /// -------------------------------------------------------------------------------------------------
    /// ```
    public enum Mode: UInt8 {
        case eraseAndWrite = 0
        case eraseOnly = 1
        case writeOnly = 2
    }
    
    /// EEPROM Programming Mode Bits
    /// Bits 5:4 – EEPM[1:0]
    ///
    /// The EEPROM Programming mode bit setting defines which programming action will be triggered when
    /// writing EEPE. It is possible to program data in one atomic operation (erase the old value and program the
    /// new value) or to split the erase and write operations into two different operations. The programming times
    /// for the different modes are shown in the table below. While EEPE is set, any write to EEPMn will be
    /// ignored. During reset, the EEPMn bits will be reset to 0b00 unless the EEPROM is busy programming.
    ///
    /// Table 10-1. EEPROM Mode Bits
    /// ```
    /// -------------------------------------------------------------------------------------
    /// | EEPM [1:0]   | Typical Programming Time | Operation                               |
    /// -------------------------------------------------------------------------------------
    /// |      00      |          3.4 ms          | Erase and Write in one Atomic operation |
    /// -------------------------------------------------------------------------------------
    /// |      01      |          1.8 ms          | Erase Only                              |
    /// -------------------------------------------------------------------------------------
    /// |      10      |          1.8 ms          | Write Only                              |
    /// -------------------------------------------------------------------------------------
    /// |      11      |                          | Reserved for future use                 |
    /// -------------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var mode: Mode {
        get {
            let mode = (controlRegister & 0b00110000) >> 4
            return Mode.init(rawValue: mode) ?? .eraseAndWrite
        }
        set {
            controlRegister = (controlRegister & ~0b00110000) | ((newValue.rawValue << 4) & 0b00110000)
        }
    }

    /// EEPROM Ready Interrupt Enable
    /// Bit 3 – EERIE
    ///
    /// Writing EERIE to '1' enables the EEPROM ready interrupt if the I bit in SREG is set. Writing EERIE to
    /// zero disables the interrupt. The EEPROM ready interrupt generates a constant interrupt when EEPE is
    /// cleared. The interrupt will not be generated during EEPROM write or SPM.
    @inline(__always)
    public static var readyInterruptEnable: Bool {
        get {
            return !((controlRegister & 0b00001000) == 0)
        }
        set {
            controlRegister = (controlRegister & ~0b00001000) | ((newValue ? 1 : 0) << 3 & 0b00001000)
        }
    }

    /// EEPROM Master Write Enable
    /// Bit 2 – EEMPE
    ///
    /// The EEMPE bit determines whether writing EEPE to '1' causes the EEPROM to be written.
    /// When EEMPE is '1', setting EEPE within four clock cycles will write data to the EEPROM at the selected
    /// address.
    ///
    /// If EEMPE is zero, setting EEPE will have no effect. When EEMPE has been written to '1' by software,
    /// hardware clears the bit to zero after four clock cycles. See the description of the EEPE bit for an
    /// EEPROM write procedure.
    @inline(__always)
    public static var masterWriteEnable: Bool {
        get {
            return !((controlRegister & 0b00000100) == 0)
        }
        set {
            controlRegister = (controlRegister & ~0b00000100) | ((newValue ? 1 : 0) << 2 & 0b00000100)
        }
    }
    
    /// EEPROM Write Enable
    /// Bit 1 – EEPE
    ///
    /// The EEPROM write enable signal EEPE is the write strobe to the EEPROM. When address and data are
    /// correctly set up, the EEPE bit must be written to '1' to write the value into the EEPROM. The EEMPE bit
    /// must be written to '1' before EEPE is written to '1', otherwise, no EEPROM write takes place. The
    /// following procedure should be followed when writing the EEPROM (the order of steps 3 and 4 is not
    /// essential):
    ///
    ///     1. Wait until EEPE becomes zero.
    ///     2. Wait until SPMEN in SPMCSR becomes zero.
    ///     3. Write new EEPROM address to EEAR (optional).
    ///     4. Write new EEPROM data to EEDR (optional).
    ///     5. Write a '1' to the EEMPE bit while writing a zero to EEPE in EECR.
    ///     6. Within four clock cycles after setting EEMPE, write a '1' to EEPE.
    ///
    /// The EEPROM cannot be programmed during a CPU write to the Flash memory. The software must check
    /// that the Flash programming is completed before initiating a new EEPROM write. Step 2 is only relevant if
    /// the software contains a Boot Loader allowing the CPU to program the Flash. If the Flash is never being
    /// updated by the CPU, step 2 can be omitted.
    ///
    /// CAUTION:
    /// An interrupt between step 5 and step 6 will make the write cycle fail, since the EEPROM Master
    /// Write Enable will time-out. If an interrupt routine accessing the EEPROM is interrupting another
    /// EEPROM access, the EEAR or EEDR register will be modified, causing the interrupted
    /// EEPROM access to fail. It is recommended to have the global interrupt flag cleared during all
    /// the steps to avoid these problems.
    ///
    /// When the write access time has elapsed, the EEPE bit is cleared by hardware. The user
    /// software can poll this bit and wait for a zero before writing the next byte. When EEPE has been
    /// set, the CPU is halted for two cycles before the next instruction is executed.
    /// @inlinable
    @inline(__always)
    public static var writeEnable: Bool {
        get {
            return !((controlRegister & 0b00000010) == 0)
        }
        set {
            controlRegister = (controlRegister & ~0b00000010) | ((newValue ? 1 : 0) << 1 & 0b00000010)
        }
    }

    /// EEPROM Read Enable
    /// Bit 0 – EERE
    ///
    /// The EEPROM read enable signal EERE is the read strobe to the EEPROM. When the correct address is
    /// set up in the EEAR register, the EERE bit must be written to a '1' to trigger the EEPROM read. The
    /// EEPROM read access takes one instruction, and the requested data is available immediately. When the
    /// EEPROM is read, the CPU is halted for four cycles before the next instruction is executed.
    ///
    /// The user should poll the EEPE bit before starting the read operation. If a write operation is in progress, it
    /// is neither possible to read the EEPROM, nor to change the EEAR register.
    ///
    /// The calibrated oscillator is used to time the EEPROM accesses. See the following table for typical
    /// programming times for EEPROM access from the CPU.
    ///
    /// Table 10-2. EEPROM Programming Time
    /// ```
    /// --------------------------------------------------------------------------------------------------
    /// | Symbol                  | Number of Calibrated RC Oscillator Cycles | Typical Programming Time |
    /// --------------------------------------------------------------------------------------------------
    /// | EEPROM write (from CPU) |                   26,368                  |          3.3 ms          |
    /// --------------------------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var readEnable: Bool {
        get {
            return !((controlRegister & 0b00000001) == 0)
        }
        set {
            controlRegister = (controlRegister & ~0b00000001) | ((newValue ? 1 : 0) << 0 & 0b00000001)
        }
    }
    
    /// An interal read function that does not turn off interrupts. This can be used to loop though multiple memory locations to write larger chunks of data.
    /// - Parameter address: EEPROM Memory Address to be read.
    /// - Returns: Uint8 representation of data.
    private static func rawRead(address: UInt16) -> UInt8 {
        while writeEnable { }                    // Wait for completion of previous write
        addressRegister = address                // Set up address register
        readEnable = true                        // Start eeprom read by writing EERE
        let data = dataRegister                  // Get Data
        return data
    }
    
    /// EEPROM Read function that reads a single bytes of data. This temporarily turns off interrupts so the read is not corrupted.
    /// - Parameter address: EEPROM Memory Address to be read.
    /// - Returns: Uint8 representation of data.
    public static func read(address: UInt16) -> UInt8 {
        let savedStatus = cpuCore.statusRegister // Save AVR Status Register (SREG) state so it can be restored later.
        cpuCore.globalInterruptEnable = false    // Turn off interrupts.
        let data = rawRead(address: address)     // Get Data
        cpuCore.statusRegister = savedStatus     // Restore Interrupts
        return data
    }
    
    /// EEPROM Read function that reads two bytes of data and returns them as a single UInt16. This temporarily turns off interrupts so the read is not corrupted.
    /// - Parameter address: The start EEPROM Memory Address to be read, then incremented to read a second address.
    /// - Returns: Uint16 representation of data from two 8 bit memory addresses.
    public static func read16(address: UInt16) -> UInt16 {
        let savedStatus = cpuCore.statusRegister // Save AVR Status Register (SREG) state so it can be restored later.
        cpuCore.globalInterruptEnable = false    // Turn off interrupts.
        let byte0 = rawRead(address: address)
        let byte1 = rawRead(address: address + 1)
        cpuCore.statusRegister = savedStatus     // Restore Interrupts
        return (UInt16(byte1) << 8) | UInt16(byte0)
    }
    
    /// EEPROM Read function that reads four bytes of data and returns them as a single UInt32. This temporarily turns off interrupts so the read is not corrupted.
    /// - Parameter address: The start EEPROM Memory Address to be read, then incremented to read a second, third, and fourth addresses.
    /// - Returns: Uint32 representation of data from four 8 bit memory addresses.
    public static func read32(address: UInt16) -> UInt32 {
        let savedStatus = cpuCore.statusRegister // Save AVR Status Register (SREG) state so it can be restored later.
        cpuCore.globalInterruptEnable = false    // Turn off interrupts.
        let byte0 = rawRead(address: address)
        let byte1 = rawRead(address: address + 1)
        let byte2 = rawRead(address: address + 2)
        let byte3 = rawRead(address: address + 3)
        cpuCore.statusRegister = savedStatus     // Restore Interrupts
        return (UInt32(byte3) << 24) | (UInt32(byte2) << 16) | (UInt32(byte1) << 8) | UInt32(byte0)
    }
    
    /// An interal write function that does not turn off interrupts. This can be used to loop though multiple memory locations to write larger chunks of data.
    /// - Parameters:
    ///   - address: EEPROM Memory Address to be written.
    ///   - data: Byte of data to be written.
    private static func rawWrite(address: UInt16, data: UInt8) {
        while writeEnable { }                    // Wait for completion of previous write
        addressRegister = address                // Set up address and Data Registers
        dataRegister = data                      // Write Data
        masterWriteEnable = true                 // Write logical one to EEMPE
        writeEnable = true                       // Start eeprom write by setting EEPE
    }
    
    /// EEPROM Read function that writes a single bytes of data. This temporarily turns off interrupts so the read is not corrupted.
    /// - Parameters:
    ///   - address: EEPROM Memory Address to be written.
    ///   - data: Byte of data to be written.
    public static func write(address: UInt16, data: UInt8) {
        let savedStatus = cpuCore.statusRegister // Save AVR Status Register (SREG) state so it can be restored later.
        cpuCore.globalInterruptEnable = false    // Turn off interrupts.
        rawWrite(address: address, data: data)   // Write Data
        cpuCore.statusRegister = savedStatus     // Restore Interrupts
    }
    
    /// EEPROM Write function that writes two bytes of data and returns them as a single UInt16. This temporarily turns off interrupts so the read is not corrupted.
    /// - Parameters:
    ///   - address: The start EEPROM Memory Address to be written, then incremented to read a second address.
    ///   - data:Two bytes of data writted over two memory addresses.
    public static func write(address: UInt16, data: UInt16) {
        let savedStatus = cpuCore.statusRegister                  // Save AVR Status Register (SREG) state so it can be restored later.
        cpuCore.globalInterruptEnable = false                     // Turn off interrupts.
        rawWrite(address: address, data: UInt8(data))
        rawWrite(address: (address + 1), data: UInt8(data >> 8))
        cpuCore.statusRegister = savedStatus                      // Restore Interrupts
    }
    
    /// EEPROM Write function that writes four bytes of data and returns them as a single UInt32. This temporarily turns off interrupts so the read is not corrupted.
    /// - Parameters:
    ///   - address: The start EEPROM Memory Address to be written, then incremented to read a second, third, and fourth addresses.
    ///   - data:Four bytes of data writted over four memory addresses.
    public static func write(address: UInt16, data: UInt32) {
        let savedStatus = cpuCore.statusRegister                  // Save AVR Status Register (SREG) state so it can be restored later.
        cpuCore.globalInterruptEnable = false                     // Turn off interrupts.
        rawWrite(address: address, data: UInt8(data))
        rawWrite(address: (address + 1), data: UInt8(data >> 8))
        rawWrite(address: (address + 2), data: UInt8(data >> 16))
        rawWrite(address: (address + 3), data: UInt8(data >> 24))
        cpuCore.statusRegister = savedStatus                      // Restore Interrupts
    }
}

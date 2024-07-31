//===----------------------------------------------------------------------===//
//
// UART.swift
// Swift For Arduino
//
// Created by Paul Shelley on 12/30/2022.
// Copyright © 2022 Paul Shelley. All rights reserved.
//
//===----------------------------------------------------------------------===//
//===----------------------------------------------------------------------===//
// UART Serial Communications
//===----------------------------------------------------------------------===//


// Note: The ATmega48A, ATmegaPA, ATmega88A, ATmegaPA, ATmega168A, ATmegaPA, ATmega328, and ATmega328P, are all pin compatible and have
// the same hardware features and the only differences are in memory space.
// The 328PB that has an additional UART, SPI, and I2C making a total of 2 each and comes in different package sizes.



public enum UART {

    /// See ATMega328p Datasheet Section 20.4.1 and Table 20-9.
    public enum ParityMode: UInt8 {
        case disabled = 0
        case even = 2
        case odd = 3
    }

    /// See ATMega328p Datasheet Table 20-10.
    public enum NumberOfStopBits: UInt8 {
        case one = 0
        case two = 1
    }

    /// See ATMega328p Datasheet Section 20.4 and Table 20-11.
    public enum NumberOfDataBits: UInt8 {
        case five = 0
        case six = 1
        case seven = 2
        case eight = 3
        case nine = 7
    }

    /// See ATMega328p Datasheet Table 20-12.
    // This is relitive to the Transmitted Data Changed (Output of TxDn Pin)
    // Received Data Sampled will be opposite of Transmitted Data Changed, Ex: Rising for TX is Falling for RX.
    public enum ClockPolarity: UInt8 {
        case rising = 0
        case falling = 1
    }

    /// See ATMega328p Datasheet Section 20.11.2
    public enum AsynchronousDoubleSpeedMode: UInt8 {
        case off = 0
        case on = 1
    }

    /// See ATMega328p Datasheet Section 20.11.3
    public enum ReceiverEnable: UInt8 {
        case off = 0
        case on = 1
    }

    /// See ATMega328p Datasheet Section 20.11.3
    public enum TransmitterEnable: UInt8 {
        case off = 0
        case on = 1
    }

    /// See ATMega328p Datasheet Section 20.11.3
    public enum RXCompleteInterruptEnable: UInt8 {
        case off = 0
        case on = 1
    }

    /// See ATMega328p Datasheet Section 20.11.3
    public enum TXCompleteInterruptEnable: UInt8 {
        case off = 0
        case on = 1
    }

    /// See ATMega328p Datasheet Section 20.11.3
    public enum DRECompleteInterruptEnable: UInt8 {
        case off = 0
        case on = 1
    }

}


public protocol UARTPort {
    // this will probably(?) always be UInt8, but is useful for preventing the protocol
    // from ever accidentally being used as an existential type
    associatedtype PortDataType: BinaryInteger

    static var USARTIODataRegister: PortDataType { get set }
    static var USARTBaudRateRegisterH: UInt8 { get set }
    static var USARTBaudRateRegisterL: UInt8 { get set }
    static var USARTControlAndStatusRegisterC: UInt8 { get set }
    static var USARTControlAndStatusRegisterB: UInt8 { get set }
    static var USARTControlAndStatusRegisterA: UInt8 { get set }
}

public typealias uart0 = UART0

/// UART implementation for ATmega48A/PA/88A/PA/168A/PA/328/P
public struct UART0: UARTPort {
    /// See ATMega328p Datasheet Section 36 Register Summary
    
    /// 20.11.1 UDRn – USART I/O Data Register n
    /// ```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    ///              |                          RXB                                  |
    ///-------------------------------------------------------------------------------
    ///              |                          TXB                                  |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    /// ```
    /// The USART Transmit Data Buffer Register and USART Receive Data Buffer Registers share the same I/O address referred to as
    /// USART Data Register or UDRn. The Transmit Data Buffer Register (TXB) will be the destination for data written to the UDRn
    /// Register location. Reading the UDRn Register location will return the contents of the Receive Data Buffer Register (RXB).
    ///
    /// For 5-, 6-, or 7-bit characters the upper unused bits will be ignored by the Transmitter and set to zero by the Receiver.
    ///
    /// The transmit buffer can only be written when the UDREn Flag in the UCSRnA Register is set. Data written to UDRn when the
    /// UDREn Flag is not set, will be ignored by the USART Transmitter. When data is written to the transmit buffer, and the
    /// Transmitter is enabled, the Transmitter will load the data into the Transmit Shift Register when the Shift Register is empty.
    /// Then the data will be serially transmitted on the TxDn pin.
    ///
    /// The receive buffer consists of a two level FIFO. The FIFO will change its state whenever the receive buffer is accessed. Due
    /// to this behavior of the receive buffer, do not use Read-Modify-Write instructions (SBI and CBI) on this location. Be careful
    /// when using bit test instructions (SBIC and SBIS), since these also will change the state of the FIFO.
    ///
    public static var USARTIODataRegister:   UInt8 {
        get {
            _volatileRegisterReadUInt8(0xC6)
        }
        set {
            _volatileRegisterWriteUInt8(0xC6, newValue)
        }
    }


    /// 20.11.2 UCSRnA – USART Control and Status Register n A
    /// 
    /// ```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    ///              | RXCn  | TXCn  | UDREn |  FEn  | DORn  | UPEn  | U2Xn  | MPCMn |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |   R   |  R/W  |   R   |   R   |   R   |   R   |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   1   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    /// ```
    public static var USARTControlAndStatusRegisterA: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xC0)
        }
        set {
            _volatileRegisterWriteUInt8(0xC0, newValue)
        }
    }


    /// 20.11.3 UCSRnB – USART Control and Status Register n B
    /// ```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    ///              |RXCIEn |TXCIEn |UDRIEn | RXENn | TXENn |UCSZn2 | RXB8n | TXB8n |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |   R   |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    /// ```
    public static var USARTControlAndStatusRegisterB: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xC1)
        }
        set {
            _volatileRegisterWriteUInt8(0xC1, newValue)
        }
    }


    /// 20.11.4 UCSRnC – USART Control and Status Register n C
    /// ```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    ///              |UMSELn1|UMSELn0| UPMn1 | UPMn0 | USBSn |UCSZn1 |UCSZn0 |UCPOLn |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   1   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// ```
    public static var USARTControlAndStatusRegisterC: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xC2)
        }
        set {
            _volatileRegisterWriteUInt8(0xC2, newValue)
        }
    }
    

    /// 20.11.5 UBRRnH – USART Baud Rate Register
    /// ```
    ///-------------------------------------------------------------------------------
    /// Bit          |  15   |  14   |  13   |  12   |  11   |  10   |   9   |   8   |
    ///-------------------------------------------------------------------------------
    ///              |   -   |   -   |   -   |   -   |            UBRRn              |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    /// Bits 15 through 12 are reserved for future use. For compatibility with future devices, these bit must be written to zero
    /// when UBRRnH is written.
    ///
    /// This is a 12-bit register which contains the USART baud rate. The UBRRnH contains the four most significant bits, and the
    /// UBRRnL contains the eight least significant bits of the USART baud rate. Ongoing transmissions by the Transmitter and Receiver
    /// will be corrupted if the baud rate is changed. Writing UBRRnL will trigger an immediate update of the baud rate prescaler.
    ///
    public static var USARTBaudRateRegisterH: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xC5)
        }
        set {
            _volatileRegisterWriteUInt8(0xC5, newValue)
        }
    }


    /// 20.11.5 UBRRnL – USART Baud Rate Register
    /// ```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    ///              |                         UBRRn                                 |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    /// ```
    /// This is a 12-bit register which contains the USART baud rate. The UBRRnH contains the four most significant bits, and the
    /// UBRRnL contains the eight least significant bits of the USART baud rate. Ongoing transmissions by the Transmitter and Receiver
    /// will be corrupted if the baud rate is changed. Writing UBRRnL will trigger an immediate update of the baud rate prescaler.
    ///
    public static var USARTBaudRateRegisterL: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xC4)
        }
        set {
            _volatileRegisterWriteUInt8(0xC4, newValue)
        }
    }
}


/// UART implementation for ATmega48A/PA/88A/PA/168A/PA/328/P
// Note: Some of this will probably need to be moved into the protocol and struct as this might be specific to just this family of chips. 
public extension UARTPort {
    // TODO: is there a better order for these properties?

    /// Parity Mode
    /// See ATMega328p Datasheet Section 20.11.4.
    /// UPMn0 and UPMn1 are bits 4 & 5 on UCSRnC.
    ///
    ///These bits enable and set type of parity generation and check. If enabled, the Transmitter will automatically generate and send the
    /// parity of the transmitted data bits within each frame. The Receiver will generate a parity value for the incoming data and compare
    /// it to the UPMn setting. If a mismatch is detected, the UPEn Flag in UCSRnA will be set.
    ///
    /// ```
    ///| UPMn1 | UPMn0 | Parity Mode          |
    ///|-------|-------|----------------------|
    ///| 0     | 0     | Disabled             |
    ///| 0     | 1     | Reserved             |
    ///| 1     | 0     | Enabled, Even Parity |
    ///| 1     | 1     | Enabled, Odd Parity  |
    /// ```
    @inlinable
    @inline(__always)
    static var parityMode: UART.ParityMode {
        get {
            let mode = (USARTControlAndStatusRegisterC & 0b00110000) >> 4
            return UART.ParityMode.init(rawValue: mode) ?? .disabled
        }
        set {
            USARTControlAndStatusRegisterC = (USARTControlAndStatusRegisterC & ~0b00110000) | ((newValue.rawValue << 4) & 0b00110000)
        }
    }

    /// See ATMega328p Datasheet Section 20.11.4.
    /// USBSn is bit 3 on UCSRnC.
    @inlinable
    @inline(__always)
    static var numberOfStopBits: UART.NumberOfStopBits {
        get {
            let mode = (USARTControlAndStatusRegisterC & 0b00001000) >> 3
            return UART.NumberOfStopBits.init(rawValue: mode) ?? .one
        }
        set {
            USARTControlAndStatusRegisterC = (USARTControlAndStatusRegisterC & ~0b00001000) | ((newValue.rawValue << 3) & 0b00001000)
        }
    }

    /// See ATMega328p Datasheet Section 20.11.3 and Section 20.11.4.
    /// UCSZn0 and UCSZn1 are bits 1 and 2 on UCSRnC while UCSZn2 is bit 2 on UCSRnB
    @inlinable
    @inline(__always)
    static var numberOfDataBits: UART.NumberOfDataBits {
        get {
            let mode = ((USARTControlAndStatusRegisterB & 0b00000100) >> 2) | ((USARTControlAndStatusRegisterC & 0b00000110) >> 1)
            return UART.NumberOfDataBits.init(rawValue: mode) ?? .eight
        }
        set {
            USARTControlAndStatusRegisterC = (USARTControlAndStatusRegisterC & ~0b00000110) | ((newValue.rawValue & 0b00000011) << UInt8(1))
            USARTControlAndStatusRegisterB = (USARTControlAndStatusRegisterB & ~0b00000100) | ((newValue.rawValue << 2) & 0b00000100)
        }
    }

    /// See ATMega328p Datasheet Section 20.11.4.
    /// UCPOLn is bit 0 on UCSRnC.
    @inlinable
    @inline(__always)
    static var clockPolarity: UART.ClockPolarity {
        get {
            let mode = USARTControlAndStatusRegisterC & 0b00000001
            return UART.ClockPolarity.init(rawValue: mode) ?? .rising
        }
        set {
            USARTControlAndStatusRegisterC = (USARTControlAndStatusRegisterC & ~0b00000001) | (newValue.rawValue & 0b00000001)
        }
    }

    /// See ATMega328p Datasheet Section 20.
    /// U2Xn is bit 1 on UCSRnA.
    @inlinable
    @inline(__always)
    static var asynchronousDoubleSpeedMode: UART.AsynchronousDoubleSpeedMode {
        get {
            let mode = (USARTControlAndStatusRegisterA & 0b00000010) >> 1
            return UART.AsynchronousDoubleSpeedMode.init(rawValue: mode) ?? .off
        }
        set {
            USARTControlAndStatusRegisterA = (USARTControlAndStatusRegisterA & 0b00000010) | ((newValue.rawValue << 1) & 0b00000010)
        }
    }

    /// Baud Rate Register
    @inlinable
    @inline(__always)
    static var baudRateRegister: UInt16 {
        get {
            return (UInt16(USARTBaudRateRegisterH) << 8) | UInt16(USARTBaudRateRegisterL)
        }
        set {
            USARTBaudRateRegisterH = UInt8((newValue & 0b1111111100000000) >> 8)
            USARTBaudRateRegisterL = UInt8(newValue & 0b11111111)
        }
    }

    /// Note: Needs to be updated to account for U2Xn or the Opperating Mode of the UART. See ATMega328p Datasheet Table 20-1.
    /// This is a convienience wraper on the "baudRateRegister" or "UBRRn" to allow setting a "normal" baud rate
    /// and then do the calculation to convert this to the setting needed for UBRRn.
    @inlinable
    @inline(__always)
    static var baudRate: UInt32 {
        get {
            return UInt32(cpuFrequency)/(UInt32(16*(baudRateRegister+1)))
        }
        set {
            baudRateRegister = UInt16((UInt32(cpuFrequency)/(16*newValue)) - 1)
        }
    }

    /// Receiver Enable
    @inlinable
    @inline(__always)
    static var receiverEnable: UART.ReceiverEnable {
        get {
            let mode = (USARTControlAndStatusRegisterB & 0b00010000) >> 4
            return UART.ReceiverEnable.init(rawValue: mode) ?? .off
        }
        set {
            USARTControlAndStatusRegisterB = (USARTControlAndStatusRegisterB & ~0b00010000) | ((newValue.rawValue << 4) & 0b00010000)
        }
    }

    /// Transmitter Enable
    @inlinable
    @inline(__always)
    static var transmitterEnable: UART.TransmitterEnable {
        get {
            let mode = (USARTControlAndStatusRegisterB & 0b00001000) >> 3
            return UART.TransmitterEnable.init(rawValue: mode) ?? .off
        }
        set {
            USARTControlAndStatusRegisterB = (USARTControlAndStatusRegisterB & ~0b00001000) | ((newValue.rawValue << 3) & 0b000001000)
        }
    }

    /// Data Register Empty Interrupt Enable - Set UCSRB
    @inlinable
    @inline(__always)
    static var dataRegisterEmptyInterruptEnable: UART.DRECompleteInterruptEnable {
        get {
            let mode = (USARTControlAndStatusRegisterB & 0b00100000) >> 5
            return UART.DRECompleteInterruptEnable.init(rawValue: mode) ?? .off
        }
        set {
            USARTControlAndStatusRegisterB = (USARTControlAndStatusRegisterB & ~0b00100000) | ((newValue.rawValue << 5) & 0b00100000)
        }
    }

    /// TX Complete Interrupt Enable - Set UCSRB
    @inlinable
    @inline(__always)
    static var txCompleteInterruptEnable: UART.TXCompleteInterruptEnable {
        get {
            let mode = (USARTControlAndStatusRegisterB & 0b01000000) >> 6
            return UART.TXCompleteInterruptEnable.init(rawValue: mode) ?? .off
        }
        set {
            USARTControlAndStatusRegisterB = (USARTControlAndStatusRegisterB & ~0b01000000) | ((newValue.rawValue << 6) & 0b01000000)
        }
    }

    /// Set UCSRB
    @inlinable
    @inline(__always)
    static var rxCompleteInterruptEnable: UART.RXCompleteInterruptEnable {
        get {
            let mode = (USARTControlAndStatusRegisterB & 0b10000000) >> 7
            return UART.RXCompleteInterruptEnable.init(rawValue: mode) ?? .off
        }
        set {
            USARTControlAndStatusRegisterB = (USARTControlAndStatusRegisterB & ~0b10000000) | ((newValue.rawValue << 7) & 0b10000000)
        }
    }

    /// UPEn is Bit 2 on UCSRnA. See Section 20.11.2.
    @inlinable
    @inline(never)
    static var parityError: Bool {
        get {
            return !((USARTControlAndStatusRegisterA & 0b00000100) == 0)
        }
    }

    /// UDROn is Bit 3 on UCSRnA. See Section 20.11.2.
    @inlinable
    @inline(never)
    static var dataOverrun: Bool {
        get {
            return !((USARTControlAndStatusRegisterA & 0b00001000) == 0)
        }
    }

    /// UFEn is Bit 4 on UCSRnA. See Section 20.11.2.
    @inlinable
    @inline(never)
    static var frameError: Bool {
        get {
            return !((USARTControlAndStatusRegisterA & 0b00010000) == 0)
        }
    }

    /// UDREn is Bit 5 on UCSRnA. See Section 20.11.2.
    @inlinable
    @inline(never) // TODO: There is a swift bug where inlined flags like these are optimised to always 'false', using 'never' fixes the problem (for now).
    // (note that if/when we move to pure swift register access HAL, this optimiser bug will probably go away)
    static var dataRegisterEmpty: Bool {
        get {
            return !((USARTControlAndStatusRegisterA & 0b00100000) == 0)
        }
    }

    /// UTXCn is Bit 6 on UCSRnA. See Section 20.11.2.
    @inlinable
    @inline(never) // TODO: as above
    static var txComplete: Bool {
        get {
            return !((USARTControlAndStatusRegisterA & 0b01000000) == 0)
        }
        set {
            USARTControlAndStatusRegisterA |= UInt8(newValue.hashValue) & 0b01000000
        }
    }

    /// URXCn is Bit 7 on UCSRnA. See Section 20.11.2.
    @inlinable
    @inline(never) // TODO: as above
    static var rxDataAvailable: Bool {
        get {
            return !((USARTControlAndStatusRegisterA & 0b10000000) == 0)
        }
    }
    
    @inlinable
    @inline(__always)
    /// The lowest level of writing out data to hardware UART. This function makes sure that the Data Register is empty before sending out more data, this is important for proper opperation
    /// See Section 20.6.1
    /// - Parameter byte: A single bite of data to be sent.
    static func writeByte(_ byte: PortDataType) {
        while !dataRegisterEmpty { }
        USARTIODataRegister = byte
    }

    // See Section 20.6.1
    @inlinable
    @inline(__always)
    static func read() -> PortDataType { // TODO: Needs Testing
        while !rxDataAvailable { }
        return USARTIODataRegister
    }

    @inlinable
    @inline(__always)
    static func available() -> Bool {
        rxDataAvailable
    }
}

extension UARTPort where PortDataType == UInt8 {
    // See Section 20.6.1
    @inlinable
    @inline(__always)
    public static func write(_ data: StaticString) {
        for character in data {
            writeByte(character)
        }
    }
    
    @inlinable
    @inline(__always)
    public static func write(_ int: Int8) {
        var integer = int

        if integer < 0 {
            write("-")
            integer.negate()
            write(UInt8(integer))
        } else {
            write(UInt8(integer))
        }
    }

    @inlinable
    @inline(__always)
    public static func write(_ int: Int16) {
        var integer = int

        if integer < 0 {
            write("-")
            integer.negate()
            write(UInt16(integer))
        } else {
            write(UInt16(integer))
        }
    }

    @inlinable
    @inline(__always)
    public static func write(_ int: UInt8, withLeadingZeros: Bool = false) {
        var remainingInteger = int
        var currentDivisor: UInt8 = 100
        var shouldPrintZero = withLeadingZeros
        
        while currentDivisor > 0 {
            let currentInt = remainingInteger / currentDivisor
            
            if currentInt > 0 || shouldPrintZero || currentDivisor == 1 {
                writeByte(currentInt + 48)
                shouldPrintZero = true
            }
            
            remainingInteger -= (currentInt * currentDivisor) // Save the remaining numbers to print
            currentDivisor /= 10 // Update the divisor
        }
    }
    
    @inlinable
    @inline(__always)
    public static func write(_ int: UInt16, withLeadingZeros: Bool = false) {
        var remainingInteger = int
        var currentDivisor: UInt16 = 10000
        var shouldPrintZero = withLeadingZeros
        
        while currentDivisor > 0 {
            let currentInt = remainingInteger / currentDivisor
            
            if currentInt > 0 || shouldPrintZero || currentDivisor == 1  {
                writeByte(UInt8(currentInt + 48))
                shouldPrintZero = true
            }
            
            remainingInteger -= (currentInt * currentDivisor) // Save the remaining numbers to print
            currentDivisor /= 10 // Update the divisor
        }
    }
    
    @inlinable
    @inline(__always)
    public static func write(_ int: UInt32, withLeadingZeros: Bool = false) {
        var remainingInteger = int
        var currentDivisor: UInt32 = 1000000000
        var shouldPrintZero = withLeadingZeros
        
        while currentDivisor > 0 {
            let currentInt = remainingInteger / currentDivisor
            
            if currentInt > 0 || shouldPrintZero || currentDivisor == 1  {
                writeByte(UInt8(currentInt + 48))
                shouldPrintZero = true
            }
            
            remainingInteger -= (currentInt * currentDivisor) // Save the remaining numbers to print
            currentDivisor /= 10 // Update the divisor
        }
    }
}

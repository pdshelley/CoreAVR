//
//  UART0.swift
//  CoreAVR
//
//  Created by Brent Van den Abbeel on 2026-02-13.
//
        
public typealias uart0 = UART0

/// UART implementation for ATmega48A/PA/88A/PA/168A/PA/328/P
public struct UART0: UARTPort {
    /// See ATMega328p Datasheet Section 36 Register Summary
    
    /// 20.11.1 UDRn – USART I/O Data Register n
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// |              |                          RXB                                  |
    /// --------------------------------------------------------------------------------
    /// |              |                          TXB                                  |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
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
    @inlinable
    @inline(__always)
    public static var dataRegister: UInt8 {
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
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// |              | RXCn  | TXCn  | UDREn |  FEn  | DORn  | UPEn  | U2Xn  | MPCMn |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |  R/W  |   R   |   R   |   R   |   R   |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   1   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var controlRegisterA: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xC0)
        }
        set {
            _volatileRegisterWriteUInt8(0xC0, newValue)
        }
    }


    /// 20.11.3 UCSRnB – USART Control and Status Register n B
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// |              |RXCIEn |TXCIEn |UDRIEn | RXENn | TXENn |UCSZn2 | RXB8n | TXB8n |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |   R   |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var controlRegisterB: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xC1)
        }
        set {
            _volatileRegisterWriteUInt8(0xC1, newValue)
        }
    }


    /// 20.11.4 UCSRnC – USART Control and Status Register n C
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// |              |UMSELn1|UMSELn0| UPMn1 | UPMn0 | USBSn |UCSZn1 |UCSZn0 |UCPOLn |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   1   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var controlRegisterC: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xC2)
        }
        set {
            _volatileRegisterWriteUInt8(0xC2, newValue)
        }
    }


    /// 20.11.5 UBRRnL – USART Baud Rate Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// |              |                         UBRRn                                 |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    /// This is a 12-bit register which contains the USART baud rate. The UBRRnH contains the four most significant bits, and the
    /// UBRRnL contains the eight least significant bits of the USART baud rate. Ongoing transmissions by the Transmitter and Receiver
    /// will be corrupted if the baud rate is changed. Writing UBRRnL will trigger an immediate update of the baud rate prescaler.
    ///
    @inlinable
    @inline(__always)
    public static var baudRateRegisterL: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xC4)
        }
        set {
            _volatileRegisterWriteUInt8(0xC4, newValue)
        }
    }

 /// 20.11.5 UBRRnH – USART Baud Rate Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |  15   |  14   |  13   |  12   |  11   |  10   |   9   |   8   |
    /// --------------------------------------------------------------------------------
    /// |              |   -   |   -   |   -   |   -   |            UBRRn              |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    ///```
    /// Bits 15 through 12 are reserved for future use. For compatibility with future devices, these bit must be written to zero
    /// when UBRRnH is written.
    ///
    /// This is a 12-bit register which contains the USART baud rate. The UBRRnH contains the four most significant bits, and the
    /// UBRRnL contains the eight least significant bits of the USART baud rate. Ongoing transmissions by the Transmitter and Receiver
    /// will be corrupted if the baud rate is changed. Writing UBRRnL will trigger an immediate update of the baud rate prescaler.
    ///
    @inlinable
    @inline(__always)
    public static var baudRateRegisterH: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xC5)
        }
        set {
            _volatileRegisterWriteUInt8(0xC5, newValue)
        }
    }
    
    /// UBBRn – USART Baud Rate Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// |              |   -   |   -   |   -   |   -   |         UBRRn[12:8]           |
    /// |              |                       UBRRn[7:0]                              |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    /// Bits 15 through 12 are reserved for future use. For compatibility with future devices, these bit must be written to zero
    /// when UBRRnH is written.
    ///
    /// This is a 12-bit register which contains the USART baud rate. The UBRRnH contains the four most significant bits, and the
    /// UBRRnL contains the eight least significant bits of the USART baud rate. Ongoing transmissions by the Transmitter and Receive
    /// will be corrupted if the baud rate is changed. Writing UBRRnL will trigger an immediate update of the baud rate prescaler.
    @inlinable
    @inline(__always)
    public static var baudRateRegister: UInt16 {
        get {
            return (UInt16(baudRateRegisterH) << 8) | UInt16(baudRateRegisterL)
        }
        set {
            baudRateRegisterH = UInt8((newValue & 0b11111111_00000000) >> 8)
            baudRateRegisterL = UInt8(newValue & 0b11111111)
        }
    }
    
    /// URXCn is Bit 7 on UCSRnA. See Section 20.11.2.
    @inlinable
    @inline(never) // TODO: as above
    public static var rxDataAvailable: Bool {
        get {
            return !((controlRegisterA & 0b10000000) == 0)
        }
    }
    
    /// UTXCn is Bit 6 on UCSRnA. See Section 20.11.2.
    @inlinable
    @inline(never) // TODO: as above
    public static var txComplete: Bool {
        get {
            return !((controlRegisterA & 0b01000000) == 0)
        }
        set {
            controlRegisterA |= UInt8(newValue.hashValue) & 0b01000000
        }
    }
    
    /// UDREn is Bit 5 on UCSRnA. See Section 20.11.2.
    @inlinable
    @inline(never) // TODO: There is a swift bug where inlined flags like these are optimised to always 'false', using 'never' fixes the problem (for now).
    // (note that if/when we move to pure swift register access HAL, this optimiser bug will probably go away)
    public static var dataRegisterEmpty: Bool {
        get {
            return !((controlRegisterA & 0b00100000) == 0)
        }
    }
    
    /// UFEn is Bit 4 on UCSRnA. See Section 20.11.2.
    @inlinable
    @inline(never)
    public static var frameError: Bool {
        get {
            return !((controlRegisterA & 0b00010000) == 0)
        }
    }
    
    /// UDROn is Bit 3 on UCSRnA. See Section 20.11.2.
    @inlinable
    @inline(never)
    public static var dataOverrun: Bool {
        get {
            return !((controlRegisterA & 0b00001000) == 0)
        }
    }
    
    /// UPEn is Bit 2 on UCSRnA. See Section 20.11.2.
    @inlinable
    @inline(never)
    public static var parityError: Bool {
        get {
            return !((controlRegisterA & 0b00000100) == 0)
        }
    }
    
    /// See ATMega328p Datasheet Section 20.
    /// U2Xn is bit 1 on UCSRnA.
    @inlinable
    @inline(__always)
    public static var asynchronousDoubleSpeedMode: UART.AsynchronousDoubleSpeedMode {
        get {
            let mode = (controlRegisterA & 0b00000010) >> 1
            return UART.AsynchronousDoubleSpeedMode.init(rawValue: mode) ?? .off
        }
        set {
            controlRegisterA = (controlRegisterA & 0b00000010) | ((newValue.rawValue << 1) & 0b00000010)
        }
    }
    
    /// See ATMega328p Datasheet Section 20.
    /// MPCMn is bit 0 on UCSRnA.
    @inlinable
    @inline(__always)
    public static var multiProcessorCommunication: Bool {
        get {
            return (controlRegisterA & 0b00000001) == 1
        }
        set {
            controlRegisterA = (controlRegisterA & ~0b00000001) | (newValue ? 1 : 0)
        }
    }
    
    /// Set UCSRB
    @inlinable
    @inline(__always)
    public static var rxCompleteInterruptEnable: UART.RXCompleteInterruptEnable {
        get {
            let mode = (controlRegisterB & 0b10000000) >> 7
            return UART.RXCompleteInterruptEnable.init(rawValue: mode) ?? .off
        }
        set {
            controlRegisterB = (controlRegisterB & ~0b10000000) | ((newValue.rawValue << 7) & 0b10000000)
        }
    }
    
    /// TX Complete Interrupt Enable - Set UCSRB
    @inlinable
    @inline(__always)
    public static var txCompleteInterruptEnable: UART.TXCompleteInterruptEnable {
        get {
            let mode = (controlRegisterB & 0b01000000) >> 6
            return UART.TXCompleteInterruptEnable.init(rawValue: mode) ?? .off
        }
        set {
            controlRegisterB = (controlRegisterB & ~0b01000000) | ((newValue.rawValue << 6) & 0b01000000)
        }
    }
    
    /// Data Register Empty Interrupt Enable - Set UCSRB
    @inlinable
    @inline(__always)
    public static var dataRegisterEmptyInterruptEnable: UART.DRECompleteInterruptEnable {
        get {
            let mode = (controlRegisterB & 0b00100000) >> 5
            return UART.DRECompleteInterruptEnable.init(rawValue: mode) ?? .off
        }
        set {
            controlRegisterB = (controlRegisterB & ~0b00100000) | ((newValue.rawValue << 5) & 0b00100000)
        }
    }
    
    /// Receiver Enable
    @inlinable
    @inline(__always)
    public static var receiverEnable: UART.ReceiverEnable {
        get {
            let mode = (controlRegisterB & 0b00010000) >> 4
            return UART.ReceiverEnable.init(rawValue: mode) ?? .off
        }
        set {
            controlRegisterB = (controlRegisterB & ~0b00010000) | ((newValue.rawValue << 4) & 0b00010000)
        }
    }

    /// Transmitter Enable
    @inlinable
    @inline(__always)
    public static var transmitterEnable: UART.TransmitterEnable {
        get {
            let mode = (controlRegisterB & 0b00001000) >> 3
            return UART.TransmitterEnable.init(rawValue: mode) ?? .off
        }
        set {
            controlRegisterB = (controlRegisterB & ~0b00001000) | ((newValue.rawValue << 3) & 0b000001000)
        }
    }
    
    /// See ATMega328p Datasheet Section 20.11.3 and Section 20.11.4.
    /// UCSZn0 and UCSZn1 are bits 1 and 2 on UCSRnC while UCSZn2 is bit 2 on UCSRnB
    @inlinable
    @inline(__always)
    public static var numberOfDataBits: UART.NumberOfDataBits {
        get {
            let mode = ((controlRegisterB & 0b00000100) >> 2) | ((controlRegisterC & 0b00000110) >> 1)
            return UART.NumberOfDataBits.init(rawValue: mode) ?? .eight
        }
        set {
            controlRegisterC = (controlRegisterC & ~0b00000110) | ((newValue.rawValue & 0b00000011) << UInt8(1))
            controlRegisterB = (controlRegisterB & ~0b00000100) | ((newValue.rawValue << 2) & 0b00000100)
        }
    }
    
    /// See ATMega328p Datasheet Section 20.11.3
    /// RXB8n is bit 1 on UCSRnB
    @inlinable
    @inline(__always)
    public static var receiveData8thBit: Bool {
        get {
            return ((controlRegisterB & 0b00000010) >> 1) == 1
        }
    }
    
    /// See ATMega328p Datasheet Section 20.11.3
    /// TXB8n is bit 0 on UCSRnB
    @inlinable
    @inline(__always)
    public static var transmitData8thBit: Bool {
        get {
            return ((controlRegisterB & 0b00000001)) == 1
        }
        set {
            controlRegisterB = (controlRegisterB & ~0b00000001) | (newValue ? 1 : 0)
        }
    }
    
    /// See ATMega328p Datasheet Section 20.11.4
    /// UMSELn are bit 7 and 6 on UCSRnC
    @inlinable
    @inline(__always)
    public static var modeSelect: UART.ModeSelect {
        get {
            let mode = (controlRegisterC & 0b11000000) >> 6
            return UART.ModeSelect.init(rawValue: mode) ?? .asynchronous
        }
        set {
            controlRegisterC = (controlRegisterC & ~0b11000000) | ((newValue.rawValue << 6) & 0b11000000)
        }
    }

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
    public static var parityMode: UART.ParityMode {
        get {
            let mode = (controlRegisterC & 0b00110000) >> 4
            return UART.ParityMode.init(rawValue: mode) ?? .disabled
        }
        set {
            controlRegisterC = (controlRegisterC & ~0b00110000) | ((newValue.rawValue << 4) & 0b00110000)
        }
    }

    /// See ATMega328p Datasheet Section 20.11.4.
    /// USBSn is bit 3 on UCSRnC.
    @inlinable
    @inline(__always)
    public static var numberOfStopBits: UART.NumberOfStopBits {
        get {
            let mode = (controlRegisterC & 0b00001000) >> 3
            return UART.NumberOfStopBits.init(rawValue: mode) ?? .one
        }
        set {
            controlRegisterC = (controlRegisterC & ~0b00001000) | ((newValue.rawValue << 3) & 0b00001000)
        }
    }

    /// See ATMega328p Datasheet Section 20.11.4.
    /// UCPOLn is bit 0 on UCSRnC.
    @inlinable
    @inline(__always)
    public static var clockPolarity: UART.ClockPolarity {
        get {
            let mode = controlRegisterC & 0b00000001
            return UART.ClockPolarity.init(rawValue: mode) ?? .rising
        }
        set {
            controlRegisterC = (controlRegisterC & ~0b00000001) | (newValue.rawValue & 0b00000001)
        }
    }
}

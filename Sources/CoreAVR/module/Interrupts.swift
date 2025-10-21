//
//  Interrupts.swift
//  CoreAVR
//
//  Created by Brent Van den Abbeel on 2025-10-17.
//

public enum InterruptVector: UInt8 {
    /// RESET -  External Pin, Power-on Reset, Brown-out Reset and Watchdog System Reset
    case powerOnReset = 0
    /// INT0 - External Interrupt Request 0
    case externalInterruptRequest0 = 1
    /// INT1 - External Interrupt Request 1
    case externalInterruptRequest1 = 2
    /// PCINT0 - Pin Change Interrupt Request 0
    case pinChangeInterruptRequest0 = 3
    /// PCINT1 - Pin Change Interrupt Request 1
    case pinChangeInterruptRequest1 = 4
    /// PCINT2 - Pin Change Interrupt Request 2
    case pinChangeInterruptRequest2 = 5
    /// WDT - Watchdog Time-out Interrupt
    case watchdogTimeout = 6
    /// TIMER2\_COMPA - Timer/Counter2 Compare Match A
    case timer2CompareMatchA = 7
    /// TIMER2\_COMPB - Timer/Counter2 Compare Match B
    case timer2CompareMatchB = 8
    /// TIMER2\_OVF - Timer/Counter2 Overflow
    case timer2Overflow = 9
    /// TIMER1\_CAPT - Timer/Counter1 Capture Event
    case timer1Capture = 10
    /// TIMER1\_COMPA - Timer/Counter1 Compare Match A
    case timer1CompareMatchA = 11
    /// TIMER1\_COMPB - Timer/Counter1 Compare Match B
    case timer1CompareMatchB = 12
    /// TIMER1\_OVF - Timer/Counter1 Overflow
    case timer1Overflow = 13
    /// TIMER0\_COMPA - Timer/Counter0 Compare Match A
    case timer0CompareMatchA = 14
    /// TIMER0\_COMPB - Timer/Counter0 Compare Match B
    case timer0CompareMatchB = 15
    /// TIMER0\_OVF - Timer/Counter0 Overflow
    case timer0Overflow = 16
    /// SPI\_STC - SPI Serial Transfer Complete
    case spiSerialTransferComplete = 17
    /// USART\_RX - USART Rx Complete
    case usartRxComplete = 18
    /// USART\_UDRE - USART Data Register Empty
    case usartDataRegisterEmpty = 19
    /// USART\_TX - USART Tx Complete
    case usartTxComplete = 20
    /// ADC - ADC Conversion Complete
    case adcConversionComplete = 21
    /// EE\_READY - EEPROM Ready
    case eepromReady = 22
    /// ANALOG\_COMP - Analog Comparator
    case analogComparator = 23
    /// TWI - 2-wire Serial Interface
    case twoWireSerialInterface = 24
    /// SPM\_READY - Store Program Memory Ready
    case storeProgramMemoryReady = 25
}

public enum InterruptSenseControl: UInt8 {
    /// The low level of INTx generates an interrupt request.
    case low = 0
    /// Any logical change on INTx generates an interrupt request.
    case logical = 1
    /// The falling edge of INTx generates an interrupt request.
    case falling = 2
    /// The rising edge of INTx generates an interrupt request.
    case rising = 3
}

public struct Interrupts {
    /// Datasheet Section 7.7 - Reset and Interrupt Handling
    /// Inserts a "Global Interrupt Enable" (`sei`) instruction at the current location.
    @inlinable
    @inline(__always)
    public static func enableInterrupts() {
        _sei()
    }

    /// Datasheet Section 7.7 - Reset and Interrupt Handling
    /// Inserts a "Global Interrupt Disable" (`cli`) instruction at the current location.
    @inlinable
    @inline(__always)
    public static func disableInterrupts() {
        _cli()
    }
    
    /// 12.5.1 MCUCR – MCU Control Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | 0x24 (0x44)  |   -   | BODS  | BODSE |  PUD  |   -   |   -   | IVSEL | IVCE  |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |  R/W  |  R/W  |  R/W  |   R   |   R   |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var mcuControlRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x55)
        }
        set {
            _volatileRegisterWriteUInt8(0x55, newValue)
        }
    }
    
    /// 13.2.1 EICRA – External Interrupt Control Register A
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x69)       |   -   |   -   |   -   |   -   | ISC11 | ISC10 | ISC01 | ISC00 |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var externalInterruptControlRegisterA: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x69)
        }
        set {
            _volatileRegisterWriteUInt8(0x69, newValue)
        }
    }
    
    /// 13.2.2 EIMSK – External Interrupt Mask Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x3D)       |   -   |   -   |   -   |   -   |   -   |   -   |  INT1 |  INT0 |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var externalInterruptMaskRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x3D)
        }
        set {
            _volatileRegisterWriteUInt8(0x3D, newValue)
        }
    }
    
    /// 13.2.3 EIFR – External Interrupt Flag Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x3C)       |   -   |   -   |   -   |   -   |   -   |   -   | INTF1 | INTF0 |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var externalInterruptFlagRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x3C)
        }
        set {
            _volatileRegisterWriteUInt8(0x3C, newValue)
        }
    }
    
    /// 13.2.4 PCICR – Pin Change Interrupt Control Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x68)       |   -   |   -   |   -   |   -   |   -   | PCIE2 | PCIE1 | PCIE0 |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var pinChangeInterruptControlRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x68)
        }
        set {
            _volatileRegisterWriteUInt8(0x68, newValue)
        }
    }
    
    /// 13.2.5 PCIFR – Pin Change Interrupt Flag Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | 0x1B (0x3B)  |   -   |   -   |   -   |   -   |   -   | PCIF2 | PCIF1 | PCIF0 |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var pinChangeInterruptFlagRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x3B)
        }
        set {
            _volatileRegisterWriteUInt8(0x3B, newValue)
        }
    }
    
    /// 13.2.6 PCMSK2 – Pin Change Mask Register 2
    /// ```
    /// ------------------------------------------------------------------------------------------------
    /// | Bit          |    7    |    6    |    5    |    4    |    3    |    2    |    1    |    0    |
    /// ------------------------------------------------------------------------------------------------
    /// | (0x6D)       | PCINT23 | PCINT22 | PCINT21 | PCINT20 | PCINT19 | PCINT18 | PCINT17 | PCINT16 |
    /// ------------------------------------------------------------------------------------------------
    /// | Read/Write   |   R/W   |   R/W   |   R/W   |   R/W   |   R/W   |   R/W   |   R/W   |   R/W   |
    /// ------------------------------------------------------------------------------------------------
    /// | InitialValue |    0    |    0    |    0    |    0    |    0    |    0    |    0    |    0    |
    /// ------------------------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var pinChangeMaskRegister2: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x6D)
        }
        set {
            _volatileRegisterWriteUInt8(0x6D, newValue)
        }
    }
    
    /// 13.2.7 PCMSK1 – Pin Change Mask Register 1
    /// ```
    /// ------------------------------------------------------------------------------------------------
    /// | Bit          |    7    |    6    |    5    |    4    |    3    |    2    |    1    |    0    |
    /// ------------------------------------------------------------------------------------------------
    /// | (0x6C)       |    -    | PCINT14 | PCINT13 | PCINT12 | PCINT11 | PCINT10 | PCINT9  | PCINT8  |
    /// ------------------------------------------------------------------------------------------------
    /// | Read/Write   |    R    |   R/W   |   R/W   |   R/W   |   R/W   |   R/W   |   R/W   |   R/W   |
    /// ------------------------------------------------------------------------------------------------
    /// | InitialValue |    0    |    0    |    0    |    0    |    0    |    0    |    0    |    0    |
    /// ------------------------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var pinChangeMaskRegister1: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x6C)
        }
        set {
            _volatileRegisterWriteUInt8(0x6C, newValue)
        }
    }
    
    /// 13.2.8 PCMSK0 – Pin Change Mask Register 0
    /// ```
    /// ------------------------------------------------------------------------------------------------
    /// | Bit          |    7    |    6    |    5    |    4    |    3    |    2    |    1    |    0    |
    /// ------------------------------------------------------------------------------------------------
    /// | (0x6B)       | PCINT7  | PCINT6  | PCINT5  | PCINT4  | PCINT3  | PCINT2  | PCINT1  | PCINT0  |
    /// ------------------------------------------------------------------------------------------------
    /// | Read/Write   |   R/W   |   R/W   |   R/W   |   R/W   |   R/W   |   R/W   |   R/W   |   R/W   |
    /// ------------------------------------------------------------------------------------------------
    /// | InitialValue |    0    |    0    |    0    |    0    |    0    |    0    |    0    |    0    |
    /// ------------------------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var pinChangeMaskRegister0: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x6B)
        }
        set {
            _volatileRegisterWriteUInt8(0x6B, newValue)
        }
    }
    
    /// Datasheet Section 12.5.1 - Moving Interrupts Between Application and Boot Space, ATmega88A/88PA, ATmega168A/168PA and ATmega328/328P
    /// Bit 1 - IVSEL: Interrupt Vector Select
    ///
    /// When the IVSEL bit is cleared (zero), the Interrupt Vectors are placed at the start of the Flash memory. When
    /// this bit is set (one), the Interrupt Vectors are moved to the beginning of the Boot Loader section of the Flash.
    /// The actual address of the start of the Boot Flash Section is determined by the BOOTSZ Fuses. Refer to the
    /// section ”Boot Loader Support – Read-While-Write Self-Programming” on page 272 for details. To avoid
    /// unintentional changes of Interrupt Vector tables, a special write procedure must be followed to change the
    /// IVSEL bit:
    ///     1. Write the Interrupt Vector Change Enable (IVCE) bit to one.
    ///     2. Within four cycles, write the desired value to IVSEL while writing a zero to IVCE.
    /// Interrupts will automatically be disabled while this sequence is executed. Interrupts are disabled in the cycle
    /// IVCE is set, and they remain disabled until after the instruction following the write to IVSEL. If IVSEL is not
    /// written, interrupts remain disabled for four cycles. The I-bit in the Status Register is unaffected by the automatic
    /// disabling.
    /// Note: If Interrupt Vectors are placed in the Boot Loader section and Boot Lock bit BLB02 is programmed, interrupts are
    /// disabled while executing from the Application section. If Interrupt Vectors are placed in the Application section and
    /// Boot Lock bit BLB12 is programed, interrupts are disabled while executing from the Boot Loader section. Refer to
    /// the section ”Boot Loader Support – Read-While-Write Self-Programming” on page 272 for details on Boot Lock bits.
    @inlinable
    @inline(__always)
    public static var interruptVectorSelect: Bool {
        get {
            let flag = (mcuControlRegister & 0b00000001)
            return flag == 1
        }
        set {
            mcuControlRegister |= ((newValue ? 1 : 0) & 0b00000001)
        }
    }
    
    /// Datasheet Section 12.5.1 - Moving Interrupts Between Application and Boot Space, ATmega88A/88PA, ATmega168A/168PA and ATmega328/328P
    /// Bit 2 - IVCE: Interrupt Vector Change Enable
    ///
    /// The IVCE bit must be written to logic one to enable change of the IVSEL bit. IVCE is cleared by hardware four
    /// cycles after it is written or when IVSEL is written. Setting the IVCE bit will disable interrupts, as explained in the
    /// IVSEL description above.
    @inlinable
    @inline(__always)
    public static var interruptVectorChangeEnable: Bool {
        get {
            let flag = (mcuControlRegister & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            mcuControlRegister |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(1)
        }
    }
    
    /// Datasheet Section 13.2.1 - External Interrupt Control Register A
    /// Bits 3, 2 - ISC11, ISC10: Interrupt Sense Control 1 Bit 1 and Bit 0
    ///
    /// The External Interrupt 1 is activated by the external pin INT1 if the SREG I-flag and the corresponding interrupt
    /// mask are set. The level and edges on the external INT1 pin that activate the interrupt are defined in `InterruptSenseControl`.
    /// The value on the INT1 pin is sampled before detecting edges. If edge or toggle interrupt is selected, pulses that
    /// last longer than one clock period will generate an interrupt. Shorter pulses are not ensured to generate an
    /// interrupt. If low level interrupt is selected, the low level must be held until the completion of the currently
    /// executing instruction to generate an interrupt.
    @inlinable
    @inline(__always)
    public static var interruptSenseControl1: InterruptSenseControl {
        get {
            let sense = (externalInterruptControlRegisterA & 0b00000011)
            return .init(rawValue: sense) ?? .low
        }
        set {
            externalInterruptControlRegisterA |= (newValue.rawValue & 0b00000011)
        }
    }
    
    /// Datasheet Section 13.2.1 - External Interrupt Control Register A
    /// Bits 1, 0 - ISC01, ISC00: Interrupt Sense Control 0 Bit 1 and Bit 0
    ///
    /// The External Interrupt 0 is activated by the external pin INT0 if the SREG I-flag and the corresponding interrupt
    /// mask are set. The level and edges on the external INT0 pin that activate the interrupt are defined in `InterruptSenseControl`.
    /// The value on the INT0 pin is sampled before detecting edges. If edge or toggle interrupt is selected, pulses that
    /// last longer than one clock period will generate an interrupt. Shorter pulses are not ensured to generate an
    /// interrupt. If low level interrupt is selected, the low level must be held until the completion of the currently
    /// executing instruction to generate an interrupt.
    @inlinable
    @inline(__always)
    public static var interruptSenseControl0: InterruptSenseControl {
        get {
            let sense = (externalInterruptControlRegisterA & 0b00001100) >> UInt8(2)
            return .init(rawValue: sense) ?? .low
        }
        set {
            externalInterruptControlRegisterA |= (newValue.rawValue & 0b00000011) << UInt8(2)
        }
    }
    
    /// Datasheet Section 13.2.2 - External Interrupt Mask Register
    /// Bit 1 - INT1: External Interrupt Request 1 Enable
    ///
    /// When the INT1 bit is set (one) and the I-bit in the Status Register (SREG) is set (one), the external pin interrupt
    /// is enabled. The Interrupt Sense Control1 bits 1/0 (ISC11 and ISC10) in the External Interrupt Control Register A
    /// (EICRA) define whether the external interrupt is activated on rising and/or falling edge of the INT1 pin or level
    /// sensed. Activity on the pin will cause an interrupt request even if INT1 is configured as an output. The
    /// corresponding interrupt of External Interrupt Request 1 is executed from the INT1 Interrupt Vector.
    @inlinable
    @inline(__always)
    public static var externalInterruptRequest1Enable: Bool {
        get {
            let flag = (externalInterruptMaskRegister & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            externalInterruptMaskRegister |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(1)
        }
    }
    
    /// Datasheet Section 13.2.2 - External Interrupt Mask Register
    /// Bit 0 - INT0: External Interrupt Request 0 Enable
    ///
    /// When the INT0 bit is set (one) and the I-bit in the Status Register (SREG) is set (one), the external pin interrupt
    /// is enabled. The Interrupt Sense Control0 bits 1/0 (ISC01 and ISC00) in the External Interrupt Control Register A
    /// (EICRA) define whether the external interrupt is activated on rising and/or falling edge of the INT0 pin or level
    /// sensed. Activity on the pin will cause an interrupt request even if INT0 is configured as an output. The
    /// corresponding interrupt of External Interrupt Request 0 is executed from the INT0 Interrupt Vector.
    @inlinable
    @inline(__always)
    public static var externalInterruptRequest0Enable: Bool {
        get {
            let flag = (externalInterruptMaskRegister & 0b00000001)
            return flag == 1
        }
        set {
            externalInterruptMaskRegister |= ((newValue ? 1 : 0) & 0b00000001)
        }
    }
    
    /// Datasheet Section 13.2.3 - External Interrupt Flag Register
    /// Bit 1 - INTF1: External Interrupt Flag 1
    ///
    /// When an edge or logic change on the INT1 pin triggers an interrupt request, INTF1 becomes set (one). If the I-
    /// bit in SREG and the INT1 bit in EIMSK are set (one), the MCU will jump to the corresponding Interrupt Vector.
    /// The flag is cleared when the interrupt routine is executed. Alternatively, the flag can be cleared by writing a
    /// logical one to it. This flag is always cleared when INT1 is configured as a level interrupt.
    @inlinable
    @inline(__always)
    public static var externalInterruptFlag1: Bool {
        get {
            let flag = (externalInterruptFlagRegister & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            externalInterruptFlagRegister |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(1)
        }
    }
    
    /// Datasheet Section 13.2.3 - External Interrupt Flag Register
    /// Bit 0 - INTF0: External Interrupt Flag 0
    ///
    /// When an edge or logic change on the INT0 pin triggers an interrupt request, INTF0 becomes set (one). If the I-
    /// bit in SREG and the INT0 bit in EIMSK are set (one), the MCU will jump to the corresponding Interrupt Vector.
    /// The flag is cleared when the interrupt routine is executed. Alternatively, the flag can be cleared by writing a
    /// logical one to it. This flag is always cleared when INT0 is configured as a level interrupt.
    @inlinable
    @inline(__always)
    public static var externalInterruptFlag0: Bool {
        get {
            let flag = (externalInterruptFlagRegister & 0b00000001)
            return flag == 1
        }
        set {
            externalInterruptFlagRegister |= ((newValue ? 1 : 0) & 0b00000001)
        }
    }
    
    /// Datasheet Section 13.2.4 - Pin Change Interrupt Control Register
    /// Bit 2 - PCIE2: Pin Change Interrupt Enable 2
    ///
    /// When the PCIE2 bit is set (one) and the I-bit in the Status Register (SREG) is set (one), pin change interrupt 2 is
    /// enabled. Any change on any enabled PCINT[23:16] pin will cause an interrupt. The corresponding interrupt of
    /// Pin Change Interrupt Request is executed from the PCI2 Interrupt Vector. PCINT[23:16] pins are enabled
    /// individually by the PCMSK2 Register.
    @inlinable
    @inline(__always)
    public static var pinChangeInterruptEnable2: Bool {
        get {
            let flag = (pinChangeInterruptControlRegister & 0b00000100) >> UInt8(2)
            return flag == 1
        }
        set {
            pinChangeInterruptControlRegister |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(2)
        }
    }
    
    /// Datasheet Section 13.2.4 - Pin Change Interrupt Control Register
    /// Bit 1 - PCIE1: Pin Change Interrupt Enable 1
    ///
    /// When the PCIE1 bit is set (one) and the I-bit in the Status Register (SREG) is set (one), pin change interrupt 1 is
    /// enabled. Any change on any enabled PCINT[14:8] pin will cause an interrupt. The corresponding interrupt of Pin
    /// Change Interrupt Request is executed from the PCI1 Interrupt Vector. PCINT[14:8] pins are enabled individually
    /// by the PCMSK1 Register.
    @inlinable
    @inline(__always)
    public static var pinChangeInterruptEnable1: Bool {
        get {
            let flag = (pinChangeInterruptControlRegister & 0b0000010) >> UInt8(1)
            return flag == 1
        }
        set {
            pinChangeInterruptControlRegister |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(1)
        }
    }
    
    /// Datasheet Section 13.2.4 - Pin Change Interrupt Control Register
    /// Bit 0 - PCIE0: Pin Change Interrupt Enable 0
    ///
    /// When the PCIE0 bit is set (one) and the I-bit in the Status Register (SREG) is set (one), pin change interrupt 0 is
    /// enabled. Any change on any enabled PCINT[7:0] pin will cause an interrupt. The corresponding interrupt of Pin
    /// Change Interrupt Request is executed from the PCI0 Interrupt Vector. PCINT[7:0] pins are enabled individually
    /// by the PCMSK0 Register.
    @inlinable
    @inline(__always)
    public static var pinChangeInterruptEnable0: Bool {
        get {
            let flag = (pinChangeInterruptControlRegister & 0b0000001)
            return flag == 1
        }
        set {
            pinChangeInterruptControlRegister |= ((newValue ? 1 : 0) & 0b00000000)
        }
    }
    
    /// Datasheet Section 13.2.5 - Pin Change Interrupt Flag Register
    /// Bit 2 - PCIF2: Pin Chnage Interrupt Flag 2
    ///
    /// When a logic change on any PCINT[23:16] pin triggers an interrupt request, PCIF2 becomes set (one). If the I-
    /// bit in SREG and the PCIE2 bit in PCICR are set (one), the MCU will jump to the corresponding Interrupt Vector.
    /// The flag is cleared when the interrupt routine is executed. Alternatively, the flag can be cleared by writing a
    /// logical one to it.
    @inlinable
    @inline(__always)
    public static var pinChangeInterruptFlag2: Bool {
        get {
            let flag = (pinChangeInterruptFlagRegister & 0b00000100) >> UInt8(2)
            return flag == 1
        }
        set {
            pinChangeInterruptFlagRegister |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(2)
        }
    }
    
    /// Datasheet Section 13.2.5 - Pin Change Interrupt Flag Register
    /// Bit 1 - PCIF1: Pin Chnage Interrupt Flag 1
    ///
    /// When a logic change on any PCINT[14:8] pin triggers an interrupt request, PCIF1 becomes set (one). If the I-bit
    /// in SREG and the PCIE1 bit in PCICR are set (one), the MCU will jump to the corresponding Interrupt Vector.
    /// The flag is cleared when the interrupt routine is executed. Alternatively, the flag can be cleared by writing a
    /// logical one to it.
    @inlinable
    @inline(__always)
    public static var pinChangeInterruptFlag1: Bool {
        get {
            let flag = (pinChangeInterruptFlagRegister & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            pinChangeInterruptFlagRegister |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(1)
        }
    }
    
    /// Datasheet Section 13.2.5 - Pin Change Interrupt Flag Register
    /// Bit 0 - PCIF0: Pin Chnage Interrupt Flag 0
    ///
    /// When a logic change on any PCINT[7:0] pin triggers an interrupt request, PCIF0 becomes set (one). If the I-bit
    /// in SREG and the PCIE0 bit in PCICR are set (one), the MCU will jump to the corresponding Interrupt Vector.
    /// The flag is cleared when the interrupt routine is executed. Alternatively, the flag can be cleared by writing a
    /// logical one to it.
    @inlinable
    @inline(__always)
    public static var pinChangeInterruptFlag0: Bool {
        get {
            let flag = (pinChangeInterruptFlagRegister & 0b00000001)
            return flag == 1
        }
        set {
            pinChangeInterruptFlagRegister |= ((newValue ? 1 : 0) & 0b00000001)
        }
    }
    
    /// Datasheet Section 13.2.6 - Pin Change Mask Register 2
    /// Bit 7 - PCINT23: Pin Change Enable Mask 23
    ///
    /// Each PCINT[23:16]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[23:16] is set and the PCIE2 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[23:16] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask23: Bool {
        get {
            let flag = (pinChangeMaskRegister2 & 0b10000000) >> UInt8(7)
            return flag == 1
        }
        set {
            pinChangeMaskRegister2 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(7)
        }
    }
    
    /// Datasheet Section 13.2.6 - Pin Change Mask Register 2
    /// Bit 6 - PCINT22: Pin Change Enable Mask 22
    ///
    /// Each PCINT[23:16]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[23:16] is set and the PCIE2 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[23:16] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask22: Bool {
        get {
            let flag = (pinChangeMaskRegister2 & 0b01000000) >> UInt8(6)
            return flag == 1
        }
        set {
            pinChangeMaskRegister2 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(6)
        }
    }
    
    /// Datasheet Section 13.2.6 - Pin Change Mask Register 2
    /// Bit 5 - PCINT21: Pin Change Enable Mask 21
    ///
    /// Each PCINT[23:16]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[23:16] is set and the PCIE2 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[23:16] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask21: Bool {
        get {
            let flag = (pinChangeMaskRegister2 & 0b00100000) >> UInt8(5)
            return flag == 1
        }
        set {
            pinChangeMaskRegister2 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(5)
        }
    }
    
    /// Datasheet Section 13.2.6 - Pin Change Mask Register 2
    /// Bit 4 - PCINT20: Pin Change Enable Mask 20
    ///
    /// Each PCINT[23:16]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[23:16] is set and the PCIE2 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[23:16] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask20: Bool {
        get {
            let flag = (pinChangeMaskRegister2 & 0b00010000) >> UInt8(4)
            return flag == 1
        }
        set {
            pinChangeMaskRegister2 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(4)
        }
    }
    
    /// Datasheet Section 13.2.6 - Pin Change Mask Register 2
    /// Bit 3 - PCINT19: Pin Change Enable Mask 19
    ///
    /// Each PCINT[23:16]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[23:16] is set and the PCIE2 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[23:16] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask19: Bool {
        get {
            let flag = (pinChangeMaskRegister2 & 0b00001000) >> UInt8(3)
            return flag == 1
        }
        set {
            pinChangeMaskRegister2 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(3)
        }
    }
    
    /// Datasheet Section 13.2.6 - Pin Change Mask Register 2
    /// Bit 2 - PCINT18: Pin Change Enable Mask 18
    ///
    /// Each PCINT[23:16]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[23:16] is set and the PCIE2 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[23:16] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask18: Bool {
        get {
            let flag = (pinChangeMaskRegister2 & 0b00000100) >> UInt8(2)
            return flag == 1
        }
        set {
            pinChangeMaskRegister2 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(2)
        }
    }
    
    /// Datasheet Section 13.2.6 - Pin Change Mask Register 2
    /// Bit 1 - PCINT17: Pin Change Enable Mask 17
    ///
    /// Each PCINT[23:16]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[23:16] is set and the PCIE2 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[23:16] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask17: Bool {
        get {
            let flag = (pinChangeMaskRegister2 & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            pinChangeMaskRegister2 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(1)
        }
    }
    
    /// Datasheet Section 13.2.6 - Pin Change Mask Register 2
    /// Bit 0 - PCINT16: Pin Change Enable Mask 16
    ///
    /// Each PCINT[23:16]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[23:16] is set and the PCIE2 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[23:16] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask16: Bool {
        get {
            let flag = (pinChangeMaskRegister2 & 0b00000001)
            return flag == 1
        }
        set {
            pinChangeMaskRegister2 |= ((newValue ? 1 : 0) & 0b00000001)
        }
    }
    
    // NOTE: Contrary to popular belief, there is no PCINT15. We go from 16 to 14, because that's how numbers work.
    
    /// Datasheet Section 13.2.7 - Pin Change Mask Register 1
    /// Bit 6 - PCINT14: Pin Change Enable Mask 14
    ///
    /// Each PCINT[14:8]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[14:8] is set and the PCIE1 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[14:8] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask14: Bool {
        get {
            let flag = (pinChangeMaskRegister1 & 0b01000000) >> UInt8(6)
            return flag == 1
        }
        set {
            pinChangeMaskRegister1 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(6)
        }
    }
    
    /// Datasheet Section 13.2.7 - Pin Change Mask Register 1
    /// Bit 5 - PCINT13: Pin Change Enable Mask 13
    ///
    /// Each PCINT[14:8]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[14:8] is set and the PCIE1 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[14:8] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask13: Bool {
        get {
            let flag = (pinChangeMaskRegister1 & 0b00100000) >> UInt8(5)
            return flag == 1
        }
        set {
            pinChangeMaskRegister1 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(5)
        }
    }
    
    /// Datasheet Section 13.2.7 - Pin Change Mask Register 1
    /// Bit 4 - PCINT12: Pin Change Enable Mask 12
    ///
    /// Each PCINT[14:8]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[14:8] is set and the PCIE1 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[14:8] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask12: Bool {
        get {
            let flag = (pinChangeMaskRegister1 & 0b00010000) >> UInt8(4)
            return flag == 1
        }
        set {
            pinChangeMaskRegister1 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(4)
        }
    }
    
    /// Datasheet Section 13.2.7 - Pin Change Mask Register 1
    /// Bit 3 - PCINT11: Pin Change Enable Mask 11
    ///
    /// Each PCINT[14:8]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[14:8] is set and the PCIE1 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[14:8] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask11: Bool {
        get {
            let flag = (pinChangeMaskRegister1 & 0b00001000) >> UInt8(3)
            return flag == 1
        }
        set {
            pinChangeMaskRegister1 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(3)
        }
    }
    
    /// Datasheet Section 13.2.7 - Pin Change Mask Register 1
    /// Bit 2 - PCINT10: Pin Change Enable Mask 10
    ///
    /// Each PCINT[14:8]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[14:8] is set and the PCIE1 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[14:8] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask10: Bool {
        get {
            let flag = (pinChangeMaskRegister1 & 0b00000100) >> UInt8(2)
            return flag == 1
        }
        set {
            pinChangeMaskRegister1 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(2)
        }
    }
    
    /// Datasheet Section 13.2.7 - Pin Change Mask Register 1
    /// Bit 1 - PCINT9: Pin Change Enable Mask 9
    ///
    /// Each PCINT[14:8]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[14:8] is set and the PCIE1 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[14:8] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask9: Bool {
        get {
            let flag = (pinChangeMaskRegister1 & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            pinChangeMaskRegister1 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(1)
        }
    }
    
    /// Datasheet Section 13.2.7 - Pin Change Mask Register 1
    /// Bit 0 - PCINT8: Pin Change Enable Mask 8
    ///
    /// Each PCINT[14:8]-bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[14:8] is set and the PCIE1 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O
    /// pin. If PCINT[14:8] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask8: Bool {
        get {
            let flag = (pinChangeMaskRegister1 & 0b00000001)
            return flag == 1
        }
        set {
            pinChangeMaskRegister1 |= ((newValue ? 1 : 0) & 0b00000001)
        }
    }
    
    /// Datasheet Section 13.2.8 - Pin Change Mask Register 0
    /// Bit 7 - PCINT7: Pin Change Enable Mask 7
    ///
    /// Each PCINT[7:0] bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If PCINT[7:0]
    /// is set and the PCIE0 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[7:0] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask7: Bool {
        get {
            let flag = (pinChangeMaskRegister0 & 0b10000000) >> UInt8(7)
            return flag == 1
        }
        set {
            pinChangeMaskRegister0 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(7)
        }
    }
    
    /// Datasheet Section 13.2.8 - Pin Change Mask Register 0
    /// Bit 6 - PCINT6: Pin Change Enable Mask 6
    ///
    /// Each PCINT[7:0] bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If PCINT[7:0]
    /// is set and the PCIE0 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[7:0] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask6: Bool {
        get {
            let flag = (pinChangeMaskRegister0 & 0b01000000) >> UInt8(6)
            return flag == 1
        }
        set {
            pinChangeMaskRegister0 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(6)
        }
    }
    
    /// Datasheet Section 13.2.8 - Pin Change Mask Register 0
    /// Bit 5 - PCINT5: Pin Change Enable Mask 5
    ///
    /// Each PCINT[7:0] bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If PCINT[7:0]
    /// is set and the PCIE0 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[7:0] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask5: Bool {
        get {
            let flag = (pinChangeMaskRegister0 & 0b00100000) >> UInt8(5)
            return flag == 1
        }
        set {
            pinChangeMaskRegister0 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(5)
        }
    }
    
    /// Datasheet Section 13.2.8 - Pin Change Mask Register 0
    /// Bit 4 - PCINT4: Pin Change Enable Mask 4
    ///
    /// Each PCINT[7:0] bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If PCINT[7:0]
    /// is set and the PCIE0 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[7:0] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask4: Bool {
        get {
            let flag = (pinChangeMaskRegister0 & 0b00010000) >> UInt8(4)
            return flag == 1
        }
        set {
            pinChangeMaskRegister0 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(4)
        }
    }
    
    /// Datasheet Section 13.2.8 - Pin Change Mask Register 0
    /// Bit 3 - PCINT3: Pin Change Enable Mask 3
    ///
    /// Each PCINT[7:0] bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If PCINT[7:0]
    /// is set and the PCIE0 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[7:0] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask3: Bool {
        get {
            let flag = (pinChangeMaskRegister0 & 0b00001000) >> UInt8(3)
            return flag == 1
        }
        set {
            pinChangeMaskRegister0 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(3)
        }
    }
    
    /// Datasheet Section 13.2.8 - Pin Change Mask Register 0
    /// Bit 2 - PCINT2: Pin Change Enable Mask 2
    ///
    /// Each PCINT[7:0] bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If PCINT[7:0]
    /// is set and the PCIE0 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[7:0] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask2: Bool {
        get {
            let flag = (pinChangeMaskRegister0 & 0b00000100) >> UInt8(2)
            return flag == 1
        }
        set {
            pinChangeMaskRegister0 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(2)
        }
    }
    
    /// Datasheet Section 13.2.8 - Pin Change Mask Register 0
    /// Bit 1 - PCINT1: Pin Change Enable Mask 1
    ///
    /// Each PCINT[7:0] bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If PCINT[7:0]
    /// is set and the PCIE0 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[7:0] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask1: Bool {
        get {
            let flag = (pinChangeMaskRegister0 & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            pinChangeMaskRegister0 |= ((newValue ? 1 : 0) & 0b00000001) << UInt8(1)
        }
    }
    
    /// Datasheet Section 13.2.8 - Pin Change Mask Register 0
    /// Bit 0 - PCINT0: Pin Change Enable Mask 0
    ///
    /// Each PCINT[7:0] bit selects whether pin change interrupt is enabled on the corresponding I/O pin. If PCINT[7:0]
    /// is set and the PCIE0 bit in PCICR is set, pin change interrupt is enabled on the corresponding I/O pin. If
    /// PCINT[7:0] is cleared, pin change interrupt on the corresponding I/O pin is disabled.
    @inlinable
    @inline(__always)
    public static var pinChangeEnableMask0: Bool {
        get {
            let flag = (pinChangeMaskRegister0 & 0b00000001)
            return flag == 1
        }
        set {
            pinChangeMaskRegister0 |= ((newValue ? 1 : 0) & 0b00000001)
        }
    }
}

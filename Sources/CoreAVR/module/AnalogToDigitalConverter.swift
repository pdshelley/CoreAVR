//
//  AnalogToDigitalConverter.swift
//  CoreAVR
//
//  Created by Brent Van den Abbeel on 2025-12-01.
//

public enum VoltageReference: UInt8 {
    /// AREF, Internal Vref turned off
    case internalTurnedOff = 0
    /// AVcc with external capacitor at AREF pin
    case externalCapacitor = 1
    // 2 is reserved
    /// Internal 1.1V Voltage Reference with external capacitor at AREF pin
    case interval1v1WithExternalReference = 3
}

public enum AnalogChannel: UInt8 {
    case adc0 = 0
    case adc1 = 1
    case adc2 = 2
    case adc3 = 3
    case adc4 = 4
    case adc5 = 5
    case adc6 = 6
    case adc7 = 7
    case adc8 = 8
    // 9 through 13 are reserved
    case vbg = 14
    case gnd = 15
}

public enum AnalogPrescaler: UInt8 {
    case divide2 = 0
    case divide2x = 1
    case divide4 = 2
    case divide8 = 3
    case divide16 = 4
    case divide32 = 5
    case divide64 = 6
    case divide128 = 7
}

public enum AutoTriggerSource: UInt8 {
    /// Free Running mode
    case freeRunning = 0
    /// Analog Comparator
    case analogComparator = 1
    /// External Interrupt Request 0
    case externalInterrupt0 = 2
    /// Timer/Counter0 Compare Match A
    case timer0CompareMatchA = 3
    /// Timer/Counter0 Overflow
    case timer0Overflow = 4
    /// Timer/Counter1 Compare Match B
    case timer1CompareMatchB = 5
    /// Timer/Counter1 Overflow
    case timer1Overflow = 6
    /// Timer/Counter1 Capture
    case timer1Capture = 7
}

public typealias adc = AnalogToDigitalConverter

public struct AnalogToDigitalConverter {
    public typealias VoltageReferenceSelection = VoltageReference
    public typealias AnalogChannelSelection = AnalogChannel
    public typealias AnalogPrescalerSelection = AnalogPrescaler
    
    /// ADMUX - ADC Multiplexer Selection Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x7C)       | REFS1 | REFS0 | ADLAR |   -   |  MUX3 |  MUX2 |  MUX1 |  MUX0 |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |   R   |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var multiplexerSelectionRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x7C)
        }
        set {
            _volatileRegisterWriteUInt8(0x7C, newValue)
        }
    }
    
    /// REFS[1:0] - Reference Selection Bits
    /// 
    /// These bits select the voltage reference for the ADC, as shown in the table below.
    /// If these bits are changed during a conversion, the change will not go in effect until this conversion is completed (ADIF in ADCSRA is set).
    /// The internal voltage reference options may not be used if an external reference voltage is being applied to the AREF pin.
    ///
    /// ```
    /// | REFS1 | REFS0 | Voltage Reference Selection                                         |
    /// |-------|-------|---------------------------------------------------------------------|
    /// |   0   |   0   | AREF, Internal Vref turned off                                      |
    /// |   0   |   1   | AVcc with external capacitor at AREF pin                            |
    /// |   1   |   0   | Reserved                                                            |
    /// |   1   |   1   | Internal 1.1V Voltage Reference with external capacitor at AREF pin |
    /// ```
    @inlinable
    @inline(__always)
    public static var reference: VoltageReferenceSelection {
        get {
            let mode = (multiplexerSelectionRegister & 0b11000000) >> UInt8(6)
            return .init(rawValue: mode) ?? .internalTurnedOff
        }
        set {
            multiplexerSelectionRegister |= (newValue.rawValue & 0b00000011) << UInt8(6)
        }
    }
    
    /// ADLAR - ADC Left Adjust Result
    ///
    /// The ADLAR bit affects the presentation of the ADC conversion result in the ADC Data Register.
    /// Write one to ADLAR to left adjust the result.
    /// Otherwise, the result is right adjusted.
    /// Changing the ADLAR bit will affect the ADC Data Register immediately, regardless of any ongoing conversions.
    @inlinable
    @inline(__always)
    public static var leftAdjust: Bool {
        get {
            let flag = (multiplexerSelectionRegister & 0b00100000) >> UInt8(5)
            return flag == 1
        }
        set {
            multiplexerSelectionRegister |= (newValue ? 1 : 0) << UInt8(5)
        }
    }
    
    /// MUX[3:0] - Analog Channel Selection Bits
    ///
    /// The value of these bits select which analog inputs are connected to the ADC. See the table below for details. If these bits are changed during a conversion, the change will not go in effect until this conversion is complete (ADIF in ADCSRA is set).
    ///
    /// ```
    /// | MUX3  | MUX2  | MUX1  | MUX0  | Single Ended Input |
    /// |-------|-------|-------|-------|--------------------|
    /// |   0   |   0   |   0   |   0   | ADC0               |
    /// |   0   |   0   |   0   |   1   | ADC1               |
    /// |   0   |   0   |   1   |   0   | ADC2               |
    /// |   0   |   0   |   1   |   1   | ADC3               |
    /// |   0   |   1   |   0   |   0   | ADC4               |
    /// |   0   |   1   |   0   |   1   | ADC5               |
    /// |   0   |   1   |   1   |   0   | ADC6               |
    /// |   0   |   1   |   1   |   1   | ADC7               |
    /// |   1   |   0   |   0   |   0   | ADC8               |
    /// |   1   |   0   |   0   |   1   | Reserved           |
    /// |   1   |   0   |   1   |   0   | Reserved           |
    /// |   1   |   0   |   1   |   1   | Reserved           |
    /// |   1   |   1   |   0   |   0   | Reserved           |
    /// |   1   |   1   |   0   |   1   | Reserved           |
    /// |   1   |   1   |   1   |   0   | 1.1V (Vbg)         |
    /// |   1   |   1   |   1   |   1   | 0V (GND)           |
    /// 
    /// ```
    @inlinable
    @inline(__always)
    public static var channel: AnalogChannelSelection {
        get {
            let mode = (multiplexerSelectionRegister & 0b00001111)
            return .init(rawValue: mode) ?? .adc0
        }
        set {
            multiplexerSelectionRegister |= (newValue.rawValue & 0b00001111)
        }
    }
    
    /// ADCSRA - ADC Control and Status Register A
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x7A)       | ADEN  |  ADSC | ADATE | ADIF  | ADIE  | ADPS2 | ADPS1 | ADPS0 |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var controlRegisterA: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x7A)
        }
        set {
            _volatileRegisterWriteUInt8(0x7A, newValue)
        }
    }
    
    /// ADEN - ADC Enable
    ///
    /// Writing this bit to one enables the ADC.
    /// By writing it to zero, the ADC is turned off.
    /// Turning off the ADC off while a conversion is in progress, will terminate this conversion.
    @inlinable
    @inline(__always)
    public static var enabled: Bool {
        get {
            let flag = (controlRegisterA & 0b10000000) >> UInt8(7)
            return flag == 1
        }
        set {
            controlRegisterA |= (newValue ? 1 : 0) << UInt8(7)
        }
    }
    
    /// ADSC - ADC Start Conversion
    ///
    /// In Single Conversion mode, write this bit to one to start each conversion.
    /// In Free Running mode, write this bit to one to start the first conversion.
    /// The first conversion after ADSC has been written after the ADC has been enabled, or if ADSC is written at the same time as the ADC is enabled, will take 25 ADC clock cycles instead of the normal 13.
    /// This first conversion performs initialization of the ADC.
    ///
    /// ADSC will read as one as long as a conversion is in progress. When the conversion is complete, it returns to zero.
    /// Writing zero to this bit has no effect.
    @inlinable
    @inline(__always)
    public static var converting: Bool {
        get {
            let flag = (controlRegisterA & 0b01000000) >> UInt8(6)
            return flag == 1
        }
        set {
            controlRegisterA |= (newValue ? 1 : 0) << UInt8(6)
        }
    }
    
    /// ADATE - ADC Auto Trigger Enable
    ///
    /// When this bit is written to one, Auto Triggering of the ADC is enabled.
    /// The ADC will start a conversion on a positive edge of the selected trigger signal. The trigger source is selected by setting the ADC Trigger Select bits, ADTS in ADCSRB.
    @inlinable
    @inline(__always)
    public static var autoTriggerEnabled: Bool {
        get {
            let flag = (controlRegisterA & 0b00100000) >> UInt8(5)
            return flag == 1
        }
        set {
            controlRegisterA |= (newValue ? 1 : 0) << UInt8(5)
        }
    }
    
    /// ADIF - ADC Interrupt Flag
    ///
    /// This bit is set when an ADC conversion completes and the Data Registers are updated.
    /// The ADC Conversion Complete Interrupt is executed if the ADIE bit and the I-bit in SREG are set.
    /// ADIF is cleared by hardware when executing the corresponding interrupt handling vector.
    /// Alternatively, ADIF is cleared by writing a logical one to the flag.
    /// Beware that if doing a Read-Modify-Write on ADCSRA, a pending interrupt can be disabled.
    /// This also applies if the SBI and CBI instructions are used.
    @inlinable
    @inline(__always)
    public static var interruptFlag: Bool {
        get {
            let flag = (controlRegisterA & 0b00010000) >> UInt8(4)
            return flag == 1
        }
        set {
            controlRegisterA |= (newValue ? 1 : 0) << UInt8(4)
        }
    }
    
    /// ADIE - ADC Interrupt Enable
    ///
    /// When this bit is written to one and the I-bit in SREG is set, the ADC Conversion Complete Interrupt is activated.
    @inlinable
    @inline(__always)
    public static var interruptEnabled: Bool {
        get {
            let flag = (controlRegisterA & 0b00001000) >> UInt8(3)
            return flag == 1
        }
        set {
            controlRegisterA |= (newValue ? 1 : 0) << UInt8(3)
        }
    }
    
    /// ADPS[2:0] - ADC Prescaler Select Bits
    ///
    /// These bits determine the division factor between the system clock frequency and the input clock to the ADC.
    ///
    /// ```
    /// | ADPS2 | ADPS1 | ADPS0 | Division Factor |
    /// |-------|-------|-------|-----------------|
    /// |   0   |   0   |   0   | 2               |
    /// |   0   |   0   |   1   | 2               |
    /// |   0   |   1   |   0   | 4               |
    /// |   0   |   1   |   1   | 8               |
    /// |   1   |   0   |   0   | 16              |
    /// |   1   |   0   |   1   | 32              |
    /// |   1   |   1   |   0   | 64              |
    /// |   1   |   1   |   1   | 128             |
    /// ```
    @inlinable
    @inline(__always)
    public static var prescaler: AnalogPrescalerSelection {
        get {
            let mode = (controlRegisterA & 0b00000111)
            return .init(rawValue: mode) ?? .divide2
        }
        set {
            controlRegisterA |= (newValue.rawValue & 0b00000111)
        }
    }
    
    /// ADC - ADC Data Register
    ///
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// NORMAL
    /// | (0x79)       |   -   |   -   |   -   |   -   |   -   |   -   | ADC9  | ADC8  |
    /// | (0x78)       | ADC7  | ADC6  | ADC5  | ADC4  | ADC3  | ADC2  | ADC1  | ADC0  |
    /// LEFT-ALIGNED
    /// | (0x79)       | ADC9  | ADC8  | ADC7  | ADC6  | ADC5  | ADC4  | ADC3  | ADC2  |
    /// | (0x78)       | ADC1  | ADC0  |   -   |   -   |   -   |   -   |   -   |   -   |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |   R   |   R   |   R   |   R   |   R   |   R   |   R   |
    /// | Read/Write   |   R   |   R   |   R   |   R   |   R   |   R   |   R   |   R   |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var dataRegister: UInt16 {
        get {
            _volatileRegisterReadUInt16(0x78)
        }
        // Register is read-only
        set {}
    }
    
    /// ADCH - ADC Data Register (high bits)
    ///
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// NORMAL
    /// | (0x79)       |   -   |   -   |   -   |   -   |   -   |   -   | ADC9  | ADC8  |
    /// LEFT-ALIGNED
    /// | (0x79)       | ADC9  | ADC8  | ADC7  | ADC6  | ADC5  | ADC4  | ADC3  | ADC2  |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |   R   |   R   |   R   |   R   |   R   |   R   |   R   |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var dataRegisterH: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x79)
        }
        // Register is read-only
        set {}
    }
    
    /// ADCL - ADC Data Register (low bits)
    ///
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// NORMAL
    /// | (0x78)       | ADC7  | ADC6  | ADC5  | ADC4  | ADC3  | ADC2  | ADC1  | ADC0  |
    /// LEFT-ALIGNED
    /// | (0x78)       | ADC1  | ADC0  |   -   |   -   |   -   |   -   |   -   |   -   |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |   R   |   R   |   R   |   R   |   R   |   R   |   R   |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var dataRegisterL: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x78)
        }
        // Register is read-only
        set {}
    }
    
    /// ADCSRB - ADC Control and Status Register B
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x7B)       |   -   |  ACME |   -   |   -   |   -   | ADTS2 | ADTS1 | ADTS0 |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |  R/W  |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var controlRegisterB: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x7B)
        }
        set {
            _volatileRegisterWriteUInt8(0x7B, newValue)
        }
    }
    
    /// ACME - Analog Comparator Multiplexer Enable
    ///
    /// When this bit is written logic one and the ADC is switched off (ADEN in ADCSRA is zero), the ADC multiplexer selects the negative input to the Analog Comparator.
    /// When this bit is written logic zero, AIN1 is applied to the negative input of the Analog Comparator.
    @inlinable
    @inline(__always)
    public static var multiplexerEnabled: Bool {
        get {
            let flag = (controlRegisterB & 0b01000000) >> UInt8(6)
            return flag == 1
        }
        set {
            controlRegisterB |= (newValue ? 1 : 0) << UInt8(6)
        }
    }
    
    /// ADTS[2:0] - ADC Auto Trigger Source
    ///
    /// If ADATE in ADCSRA is written to one, the value of these bits selects which source will trigger an ADC conversion.
    /// If ADATE is cleared, the ADTS[2:0] settings will have no effect.
    /// A conversion will be triggered by the rising edge of the selected Interrupt Flag.
    /// Note that switching from a trigger source that is cleared to a trigger source that is set, will generate a positive edge on the trigger signal.
    /// If ADEN in ADCSRA is set, this will start a conversion.
    /// Switching to Free Running mode (ADTS[2:0] = 0) will not cause a trigger event, even if the ADC Interrupt Flag is set.
    ///
    /// ```
    /// | ADTS2 | ADTS1 | ADTS0 | Trigger Source                 |
    /// |-------|-------|-------|--------------------------------|
    /// |   0   |   0   |   0   | Free Running mode              |
    /// |   0   |   0   |   1   | Analog Comparator              |
    /// |   0   |   1   |   0   | External Interrupt Request 0   |
    /// |   0   |   1   |   1   | Timer/Counter0 Compare Match A |
    /// |   1   |   0   |   0   | Timer/Counter0 Overflow        |
    /// |   1   |   0   |   1   | Timer/Counter1 Compare Match B |
    /// |   1   |   1   |   0   | Timer/Counter1 Overflow        |
    /// |   1   |   1   |   1   | Timer/Counter1 Capture Event   |
    /// ```
    @inlinable
    @inline(__always)
    public static var autoTriggerSource: AutoTriggerSource {
        get {
            let mode = (controlRegisterB & 0b00000111)
            return .init(rawValue: mode) ?? .freeRunning
        }
        set {
            controlRegisterB |= (newValue.rawValue & 0b00000111)
        }
    }
    
    /// DIDR0 - Digital Input Disable Register 0
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x7E)       |   -   |   -   | ADC5D | ADC4D | ADC3D | ADC2D | ADC1D | ADC0D |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |   R   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var digitalInputDisableRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x7E)
        }
        set {
            _volatileRegisterWriteUInt8(0x7E, newValue)
        }
    }
    
    /// ADC5D - Digital Input Disable 5
    ///
    /// When this bit is written to a logic one, the digital input buffer on the corresponding ADC pin is disabled.
    /// The corresponding PIN Register bit will always read as zero when this bit is set.
    /// When an analog signal is applied to the ADC5 pin and the digital input from this pin is not needed, this bit should be written to logic one to reduce power consumption in the digital input buffer.
    ///
    @inlinable
    @inline(__always)
    public static var digitalInput5Disabled: Bool {
        get {
            let flag = (digitalInputDisableRegister & 0b00100000) >> UInt8(5)
            return flag == 1
        }
        set {
            digitalInputDisableRegister |= (newValue ? 1 : 0) << UInt8(5)
        }
    }
    
    /// ADC4D - Digital Input Disable 4
    ///
    /// When this bit is written to a logic one, the digital input buffer on the corresponding ADC pin is disabled.
    /// The corresponding PIN Register bit will always read as zero when this bit is set.
    /// When an analog signal is applied to the ADC4 pin and the digital input from this pin is not needed, this bit should be written to logic one to reduce power consumption in the digital input buffer.
    ///
    @inlinable
    @inline(__always)
    public static var digitalInput4Disabled: Bool {
        get {
            let flag = (digitalInputDisableRegister & 0b00010000) >> UInt8(4)
            return flag == 1
        }
        set {
            digitalInputDisableRegister |= (newValue ? 1 : 0) << UInt8(4)
        }
    }
    
    /// ADC3D - Digital Input Disable 3
    ///
    /// When this bit is written to a logic one, the digital input buffer on the corresponding ADC pin is disabled.
    /// The corresponding PIN Register bit will always read as zero when this bit is set.
    /// When an analog signal is applied to the ADC3 pin and the digital input from this pin is not needed, this bit should be written to logic one to reduce power consumption in the digital input buffer.
    ///
    @inlinable
    @inline(__always)
    public static var digitalInput3Disabled: Bool {
        get {
            let flag = (digitalInputDisableRegister & 0b00001000) >> UInt8(3)
            return flag == 1
        }
        set {
            digitalInputDisableRegister |= (newValue ? 1 : 0) << UInt8(3)
        }
    }
    
    /// ADC2D - Digital Input Disable 2
    ///
    /// When this bit is written to a logic one, the digital input buffer on the corresponding ADC pin is disabled.
    /// The corresponding PIN Register bit will always read as zero when this bit is set.
    /// When an analog signal is applied to the ADC2 pin and the digital input from this pin is not needed, this bit should be written to logic one to reduce power consumption in the digital input buffer.
    ///
    @inlinable
    @inline(__always)
    public static var digitalInput2Disabled: Bool {
        get {
            let flag = (digitalInputDisableRegister & 0b00000100) >> UInt8(2)
            return flag == 1
        }
        set {
            digitalInputDisableRegister |= (newValue ? 1 : 0) << UInt8(2)
        }
    }
    
    /// ADC1D - Digital Input Disable 1
    ///
    /// When this bit is written to a logic one, the digital input buffer on the corresponding ADC pin is disabled.
    /// The corresponding PIN Register bit will always read as zero when this bit is set.
    /// When an analog signal is applied to the ADC1 pin and the digital input from this pin is not needed, this bit should be written to logic one to reduce power consumption in the digital input buffer.
    ///
    @inlinable
    @inline(__always)
    public static var digitalInput1Disabled: Bool {
        get {
            let flag = (digitalInputDisableRegister & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            digitalInputDisableRegister |= (newValue ? 1 : 0) << UInt8(1)
        }
    }
    
    /// ADC0D - Digital Input Disable 0
    ///
    /// When this bit is written to a logic one, the digital input buffer on the corresponding ADC pin is disabled.
    /// The corresponding PIN Register bit will always read as zero when this bit is set.
    /// When an analog signal is applied to the ADC0 pin and the digital input from this pin is not needed, this bit should be written to logic one to reduce power consumption in the digital input buffer.
    ///
    @inlinable
    @inline(__always)
    public static var digitalInput0Disabled: Bool {
        get {
            let flag = (digitalInputDisableRegister & 0b00000001)
            return flag == 1
        }
        set {
            digitalInputDisableRegister |= (newValue ? 1 : 0)
        }
    }
}

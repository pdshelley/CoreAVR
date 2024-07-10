//
//  AnalogeDigitalConverter.swift
//  SwiftForArduino
//
//  Created by xander rasschaert on 29/03/2023.
//

public protocol AVRADC{
    static var MultiplexerSelectionRegister: UInt8 { get set }
    static var ControlAndStatusRegisterA: UInt8 { get set }
    static var ControlAndStatusRegisterB: UInt8 { get set }
    static var DigitalInputDisableRegister0: UInt8 { get set }
//    static var StartConversion: UInt8 { get set }
//    static var InterruptEnable: UInt8 { get set }
}

public enum ADC {
    
    /// See ATMega328p Datasheet Section 24.9.1 and Table 24-3.
    public enum VoltageReferenceSelection: UInt8 {
        case AnalogReferenceInternalVoltageReferenceTurnedOff = 0
        case AVccWithExternalCapacitorAtAnalogReferencePin = 1
        case Internal11VoltageReferenceWithExternalCapacitorAtAnalogRefererancePin = 3
    }
    
    public enum AnalogChannelSelectionBits: UInt8 {
        case ADC0 = 0
        case ADC1 = 1
        case ADC2 = 2
        case ADC3 = 3
        case ADC4 = 4
        case ADC5 = 5
        case ADC6 = 6
        case ADC7 = 7
        case ADC8 = 8
        case VBG  = 14
        case GND  = 15
    }
    
    public enum PrescalerSelectBits: UInt8 {
        case Factor2 =   0
        case FactorSecond2 =   1
        case Factor4 =   2
        case Factor8 =   3
        case Factor16 =  4
        case Factor32 =  5
        case Factor64 =  6
        case Factor128 = 7
    }
    
    public enum AutoTriggerSource: UInt8 {
        case FreeRunningMode = 0
        case AnalogComparator = 1
        case ExternalInterruptRequest0 = 2
        case TimerCounter0CompareMatchA = 3
        case TimerCounter0Overflow = 4
        case TimerCounter1CompareMatchB = 5
        case TimerCounter1Overflow = 6
        case TimerCounter1CaptureEvent = 7
    }
}

// NOTE: how to do ADSC, ADIE Page 258
// NOTE: how to do currentADCCallback

public struct AnalogeDigitalConverter: AVRADC {
    @inlinable
    @inline(__always)
    public static var MultiplexerSelectionRegister: UInt8 { //ADMUX
        get {
            return 0
//            return _volatileRegisterReadUInt8(0x7C)
        }
        set {
//            _rawPointerWrite(address:0x7C, value: newValue)
        }
    }
    
    @inlinable
    @inline(__always)
    public static var ControlAndStatusRegisterA: UInt8 { //ADCSRA
        get {
            return 0
//            return _volatileRegisterReadUInt8(0x7A)
        }
        set {
//            _rawPointerWrite(address:0x7A, value: newValue)
        }
    }
    
    @inlinable
    @inline(__always)
    public static var ControlAndStatusRegisterB: UInt8 { //ADCSRB
        get {
            return 0
//            return _volatileRegisterReadUInt8(0x7B)
        }
        set {
//            _rawPointerWrite(address:0x7B, value: newValue)
        }
    }
    
    @inlinable
    @inline(__always)
    public static var ADCH: UInt8 { //ADCSRA
        get {
            return 0
//            return _volatileRegisterReadUInt8(0x79)
        }
        set {
//            _rawPointerWrite(address:0x79, value: newValue)
        }
    }
    
  @inlinable
    @inline(__always)
    public static var ADCL: UInt8 { //ADCSRA
        get {
            return 0
//            return _volatileRegisterReadUInt8(0x78)
        }
        set {
//            _rawPointerWrite(address:0x78, value: newValue)
        }
    }
    
    @inlinable
    @inline(__always)
    public static var DigitalInputDisableRegister0: UInt8 { //DIDR0
        get {
            return 0
//            return _volatileRegisterReadUInt8(0x7E)
        }
        set {
//            _rawPointerWrite(address:0x7E, value: newValue)
        }
    }
}

extension AVRADC {
    /// -------------------------------------
    /// ADC Multiplexer Selection Register
    /// -------------------------------------
    
    /// ADC Multiplexer Selection Register
    /// See ATMega328p Datasheet Section 24.9.1.
    /// REFS1 and REFS0 are bits 7 & 6 on ADMUX.
    ///
    /// These bits select the voltage reference for the ADC, as shown in Table 24-3. If these bits are changed during a conversion,
    /// the change will not go in effect until this conversion is complete (ADIF in ADCSRA is set). The internal voltage reference
    /// options may not be used if an external reference voltage is being applied to the AREF pin.
    ///
    /// ```
    ///| REFS1 | REFS0 | Voltage Reference Selection                                            |
    ///|-------|-------|------------------------------------------------------------------------|
    ///| 0     | 0     | AREF, Internal Vref turned off                                         |
    ///| 0     | 1     | AVcc with external capacitro at AREF pin                               |
    ///| 1     | 0     | Reserved                                                               |
    ///| 1     | 1     | Internal 1.1V Voltage Reference with external capacitor at AREF pin    |
    /// ```
    @inlinable
    @inline(__always)
    public static var voltageReferenceSelection: ADC.VoltageReferenceSelection { // REFS[1:0]
        get {
            let mode = (MultiplexerSelectionRegister & 0b11000000) >> 6
            return ADC.VoltageReferenceSelection.init(rawValue: mode) ?? .AnalogReferenceInternalVoltageReferenceTurnedOff
        }
        set {
            MultiplexerSelectionRegister = (MultiplexerSelectionRegister & ~0b11000000) | ((newValue.rawValue << 6) & 0b11000000)
        }
    }
    
    /// ADC Left Adjust Result
    /// See ATMega328p Datasheet Section 24.9.1.
    /// ADLAR is bit 5 on ADMUX.
    ///
    /// The ADLAR bit affects the presentation of the ADC conversion result in the ADC Data Register.
    /// Write one to ADLAR to left adjust the result. Otherwise, the result is right adjusted.
    /// Changing the ADLAR bit will affect the ADC Data Register immediately, regardless of any ongoing conversions.
    /// For a complete description of this bit, see ”ADCL and ADCH – The ADC Data Register” on page 259.
    @inlinable
    @inline(__always)
    public static var leftAdjustResult: Bool { //ADLAR
        get {
            return !((MultiplexerSelectionRegister & 0b00100000) == 0)
        }
        set {
            MultiplexerSelectionRegister = (MultiplexerSelectionRegister & ~0b00100000) | (((newValue == true) ? 1 : 0) << 5 & 0b00100000)
        }
    }
    
    /// Analog Channel Selection Bits
    /// See ATMega328p Datasheet Section 24.9.1.
    /// MUX3, MUX2, MUX1, MUX0 are bits 3, 2, 1 and 0 on ADMUX.
    ///
    /// The value of these bits selects which analog inputs are connected to the ADC. See Table 24-4 for details.
    /// If these bits are changed during a conversion, the change will not go in effect until this conversion is complete (ADIF in ADCSRA is set).
    ///
    /// ```
    ///| MUX3  | MUX2  | MUX1  | MUX0  | Voltage Reference Selection     |
    ///|-------|-------|-------|-------|---------------------------------|
    ///| 0     | 0     | 0     | 0     | ADC0                            |
    ///| 0     | 0     | 0     | 1     | ADC1                            |
    ///| 0     | 0     | 1     | 0     | ADC2                            |
    ///| 0     | 0     | 1     | 1     | ADC3                            |
    ///| 0     | 1     | 0     | 0     | ADC4                            |
    ///| 0     | 1     | 0     | 1     | ADC5                            |
    ///| 0     | 1     | 1     | 0     | ADC6                            |
    ///| 0     | 1     | 1     | 1     | ADC7                            |
    ///| 1     | 0     | 0     | 0     | ADC8 NOTE: for temp sensor      |
    ///| 1     | 0     | 0     | 1     | Reserved                        |
    ///| 1     | 0     | 1     | 0     | Reserved                        |
    ///| 1     | 0     | 1     | 1     | Reserved                        |
    ///| 1     | 1     | 0     | 0     | Reserved                        |
    ///| 1     | 1     | 0     | 1     | Reserved                        |
    ///| 1     | 1     | 1     | 0     | 1.1V (Vbg)                      |
    ///| 1     | 1     | 1     | 1     | 0V (GND)                        |
    ///```
    @inlinable @inline(__always) public static var analogChannelSelectionBits: ADC.AnalogChannelSelectionBits { // MUX[3:0] // Some devices have more MUX bits.
        get {
            let mode = MultiplexerSelectionRegister & 0b00001111
            return ADC.AnalogChannelSelectionBits.init(rawValue: mode) ?? .GND
        }
        set {
            MultiplexerSelectionRegister = (MultiplexerSelectionRegister & ~0b00001111) | (newValue.rawValue & 0b00001111)
        }
    }

    /// -------------------------------------
    /// ADC Control and Status Register A
    /// -------------------------------------
    
    /// ADC Enable
    /// See ATMega328p Datasheet Section 24.9.2.
    /// ADEN is bit 7 on ADCSRA.
    ///
    /// Writing this bit to one enables the ADC. By writing it to zero, the ADC is turned off.
    /// Turning the ADC off while a conversion is in progress, will terminate this conversion
    @inlinable
    @inline(__always)
    public static var enableADC: Bool { //ADEN
        get {
            return !((ControlAndStatusRegisterA & 0b10000000) == 0)
        }
        set {
            ControlAndStatusRegisterA = (ControlAndStatusRegisterA & ~0b10000000) | (((newValue == true) ? 1 : 0) << 7 & 0b10000000)
        }
    }
    
    
    
    
    /// ADC Start Conversion
    /// See ATMega328p Datasheet Section 24.9.2.
    /// ADSC is bit 6 on ADCSRA.
    ///
    /// This function ses the ADC Start Conversion (ADSC) bit to 1. Becasue writing 0 to this bit has no effect this code pattern will disallow that behaviour.
    ///
    /// In Single Conversion mode, write this bit to one to start each conversion. In Free Running mode,
    /// write this bit to one to start the first conversion. The first conversion after ADSC has been written
    /// after the ADC has been enabled, or if ADSC is written at the same time as the ADC is enabled, will take
    /// 25 ADC clock cycles instead of the normal 13. This first conversion performs initialization of the ADC.
    ///
    /// ADSC will read as one as long as a conversion is in progress. When the conversion is complete,
    /// it returns to zero. Writing zero to this bit has no effect.
    @inlinable
    @inline(__always)
    public static func startConversion() { //ADSC
        ControlAndStatusRegisterA |= 1 << 6 // 6 is the position of the ADC Start Conversion bit. (ADSC) This could change for other chips
    }
    
    /// ADC Start Conversion
    /// See ATMega328p Datasheet Section 24.9.2.
    /// ADSC is bit 6 on ADCSRA.
    ///
    /// Read only property because setting to 0 has no effect. For setting to 1 use startConversion(). This property is used to check for when the conversion is finished.
    ///
    /// In Single Conversion mode, write this bit to one to start each conversion. In Free Running mode,
    /// write this bit to one to start the first conversion. The first conversion after ADSC has been written
    /// after the ADC has been enabled, or if ADSC is written at the same time as the ADC is enabled, will take
    /// 25 ADC clock cycles instead of the normal 13. This first conversion performs initialization of the ADC.
    ///
    /// ADSC will read as one as long as a conversion is in progress. When the conversion is complete,
    /// it returns to zero. Writing zero to this bit has no effect.
    @inlinable
    @inline(__always)
    public static var conversionRunning: Bool { //ADSC
        get {
            return !((ControlAndStatusRegisterA & 0b01000000) == 0)
        }
    }
    
    
    /// ADC Auto Trigger Enable
    /// See ATMega328p Datasheet Section 24.9.2.
    /// ADATE is bit 5 on ADCSRA.
    ///
    /// When this bit is written to one, Auto Triggering of the ADC is enabled. The ADC will start a conversion on a
    /// positive edge of the selected trigger signal. The trigger source is selected by setting the ADC Trigger Select bits,
    /// ADTS in ADCSRB.
    @inlinable
    @inline(__always)
    public static var autoTriggerEnable: Bool { //ADATE
        get {
            return !((ControlAndStatusRegisterA & 0b00100000) == 0)
        }
        set {
            ControlAndStatusRegisterA = (ControlAndStatusRegisterA & ~0b00100000) | (((newValue == true) ? 1 : 0) << 5 & 0b00100000)
        }
    }
    
    
    /// ADC Interrupt Flag
    /// See ATMega328p Datasheet Section 24.9.2.
    /// ADIF is bit 4 on ADCSRA.
    ///
    /// This bit is set when an ADC conversion completes and the Data Registers are updated. The ADC Conversion Complete Interrupt
    /// is executed if the ADIE bit and the I-bit in SREG are set. ADIF is cleared by hardware when executing the corresponding
    /// interrupt handling vector. Alternatively, ADIF is cleared by writing a logical one to the flag. Beware that if doing a
    /// Read-Modify-Write on ADCSRA, a pending interrupt can be disabled. This also applies if the SBI and CBI instructions are used.
    @inlinable
    @inline(__always)
    public static var interruptFlag: Bool { //ADIF
        get {
            return !((ControlAndStatusRegisterA & 0b00010000) == 0)
        }
        set {
            ControlAndStatusRegisterA = (ControlAndStatusRegisterA & ~0b00010000) | (((newValue == true) ? 1 : 0) << 4 & 0b00010000)
        }
    }
    
    
    /// ADC Interrupt Enable
    /// See ATMega328p Datasheet Section 24.9.2.
    /// ADIE is bit 3 on ADCSRA.
    ///
    /// When this bit is written to one and the I-bit in SREG is set, the ADC Conversion Complete Interrupt is activated.
    @inlinable
    @inline(__always)
    public static var interruptEnable: Bool { //ADIE
        get {
            return !((ControlAndStatusRegisterA & 0b00001000) == 0)
        }
        set {
            ControlAndStatusRegisterA = (ControlAndStatusRegisterA & ~0b00001000) | (((newValue == true) ? 1 : 0) << 3 & 0b00001000)
        }
    }
    
    
    /// ADC Prescaler Select Bits
    /// See ATMega328p Datasheet Section 24.9.2.
    /// ADPS2, ADPS1 and ADPS0 are bits 2, 1 and 0 on ADCSRA.
    ///
    /// These bits determine the division factor between the system clock frequency and the input clock to the ADC.
    ///
    /// ```
    ///| ADPS2 | ADPS1 | ADPS0 | Division Factor     |
    ///|-------|-------|-------|---------------------|
    ///| 0     | 0     | 0     | 2                   |
    ///| 0     | 0     | 1     | 2                   |
    ///| 0     | 1     | 0     | 4                   |
    ///| 0     | 1     | 1     | 8                   |
    ///| 1     | 0     | 0     | 16                  |
    ///| 1     | 0     | 1     | 32                  |
    ///| 1     | 1     | 0     | 64                  |
    ///| 1     | 1     | 1     | 128                 |
    ///```
    @inlinable
    @inline(__always)
    public static var prescalerSelectBits: ADC.PrescalerSelectBits { // ADPS[2:0]
        get {
            let mode = (ControlAndStatusRegisterA & 0b00000111)
            return ADC.PrescalerSelectBits.init(rawValue: mode) ?? .Factor2
        }
        set {
            ControlAndStatusRegisterA = (ControlAndStatusRegisterA & ~0b00000111) | ((newValue.rawValue) & 0b00000111)
        }
    }
    
    
    /// -------------------------------------
    /// ADCL and ADCH - The ADC Data Register
    /// -------------------------------------
    
    /// ADC Data Register
    /// See ATMega328p Datasheet Section 24.9.4.
    ///
    /// When an ADC conversion is complete, the result is found in these two registers.
    ///
    /// When ADCL is read, the ADC Data Register is not updated until ADCH is read. Consequently, if the result is left
    /// adjusted and no more than 8-bit precision is required, it is sufficient to read ADCH. Otherwise,
    /// ADCL must be read first, then ADCH.
    ///
    /// The ADLAR bit in ADMUX, and the MUXn bits in ADMUX affect the way the result is read from the registers.
    /// If ADLAR is set, the result is left adjusted. If ADLAR is cleared (default), the result is right adjusted.
    @inlinable
    @inline(__always)
    public static var DataRegister: UInt16 {
        get {
            return ((UInt16(AnalogeDigitalConverter.ADCH) << 8) | UInt16(AnalogeDigitalConverter.ADCL))
        }
        set {
            AnalogeDigitalConverter.ADCH = UInt8((newValue & 0b1111111100000000) >> 8)
            AnalogeDigitalConverter.ADCL = UInt8(newValue & 0b11111111)
        }
    }
    
    
    /// -------------------------------------
    /// ADC Control and Status Register B
    /// -------------------------------------
    
    
    /// ADC Auto Trigger Source
    /// See ATMega328p Datasheet Section 24.9.4.
    /// ADTS2, ADTS1 and ADTS0 are bits 2, 1 and 0 on ADCSRB.
    ///
    /// If ADATE in ADCSRA is written to one, the value of these bits selects which source will trigger an ADC conversion.
    /// If ADATE is cleared, the ADTS[2:0] settings will have no effect. A conversion will be triggered by the rising edge
    /// of the selected Interrupt Flag. Note that switching from a trigger source that is cleared to a trigger source that
    /// is set, will generate a positive edge on the trigger signal. If ADEN in ADCSRA is set, this will start a conversion.
    /// Switching to Free Running mode (ADTS[2:0]=0) will not cause a trigger event, even if the ADC Interrupt Flag is set.
    ///
    /// ```
    ///| ADTS2 | ADTS1 | ADTS0 | Trigger Source                      |
    ///|-------|-------|-------|-------------------------------------|
    ///| 0     | 0     | 0     | Free Running mode                   |
    ///| 0     | 0     | 1     | Analog Comparator                   |
    ///| 0     | 1     | 0     | External Interupt Request 0         |
    ///| 0     | 1     | 1     | Timer/Counter0 Compare Match A      |
    ///| 1     | 0     | 0     | Timer Counter 0 Overflow            |
    ///| 1     | 0     | 1     | Timer/Counter1 Compare Match B      |
    ///| 1     | 1     | 0     | Timer/Counter1 Overflow             |
    ///| 1     | 1     | 1     | Timer/Counter1 Capture Event        |
    @inlinable
    @inline(__always)
    public static var autoTriggerSource: ADC.AutoTriggerSource { // ADTS[2:0]
        get {
            let mode = (ControlAndStatusRegisterB & 0b00000111)
            return ADC.AutoTriggerSource.init(rawValue: mode) ?? .FreeRunningMode
        }
        set {
            ControlAndStatusRegisterB = (ControlAndStatusRegisterB & ~0b00000111) | (newValue.rawValue & 0b00000111)
        }
    }
    
    
    /// -------------------------------------
    /// Digital Input Disable Register 0
    /// -------------------------------------
    
    
    /// ADC5...0 Digital Input Disable
    /// See ATMega328p Datasheet Section 24.9.4.
    /// ADC5D, ADC4D, ADC3D, ADC2D, ADC1D and ADC0D are bits 5, 4, 3, 2, 1 and 0 on DIDR0.
    ///
    /// When this bit is written logic one, the digital input buffer on the corresponding ADC pin is disabled.
    /// The corresponding PIN Register bit will always read as zero when this bit is set. When an analog signal
    /// is applied to the ADC5...0 pin and the digital input from this pin is not needed, this bit should be written
    /// logic one to reduce power consumption in the digital input buffer.
    /// Note that ADC pins ADC7 and ADC6 do not have digital input buffers, and therefore do not require Digital Input Disable bits.
    @inlinable
    @inline(__always)
    public static var digitalInputDisable5: Bool { //ADC5D
        get {
            return !((AnalogeDigitalConverter.DigitalInputDisableRegister0 & 0b00100000) == 0)
        }
        set {
            AnalogeDigitalConverter.DigitalInputDisableRegister0 = (AnalogeDigitalConverter.DigitalInputDisableRegister0 & ~0b00100000) | (((newValue == true) ? 1 : 0) << 5 & 0b00100000)
        }
    }
    
    @inlinable
    @inline(__always)
    public static var digitalInputDisable4: Bool { //ADC4D
        get {
            return !((AnalogeDigitalConverter.DigitalInputDisableRegister0 & 0b00010000) == 0)
        }
        set {
            AnalogeDigitalConverter.DigitalInputDisableRegister0 = (AnalogeDigitalConverter.DigitalInputDisableRegister0 & ~0b00010000) | (((newValue == true) ? 1 : 0) << 4 & 0b00010000)
        }
    }
    
    @inlinable
    @inline(__always)
    public static var digitalInputDisable3: Bool { //ADC3D
        get {
            return !((AnalogeDigitalConverter.DigitalInputDisableRegister0 & 0b00001000) == 0)
        }
        set {
            AnalogeDigitalConverter.DigitalInputDisableRegister0 = (AnalogeDigitalConverter.DigitalInputDisableRegister0 & ~0b00001000) | (((newValue == true) ? 1 : 0) << 3 & 0b00001000)
        }
    }
    
    @inlinable
    @inline(__always)
    public static var digitalInputDisable2: Bool { //ADC2D
        get {
            return !((AnalogeDigitalConverter.DigitalInputDisableRegister0 & 0b00000100) == 0)
        }
        set {
            AnalogeDigitalConverter.DigitalInputDisableRegister0 = (AnalogeDigitalConverter.DigitalInputDisableRegister0 & ~0b00000100) | (((newValue == true) ? 1 : 0) << 2 & 0b00000100)
        }
    }
    
    @inlinable
    @inline(__always)
    public static var digitalInputDisable1: Bool { //ADC1D
        get {
            return !((AnalogeDigitalConverter.DigitalInputDisableRegister0 & 0b00000010) == 0)
        }
        set {
            AnalogeDigitalConverter.DigitalInputDisableRegister0 = (AnalogeDigitalConverter.DigitalInputDisableRegister0 & ~0b00000010) | (((newValue == true) ? 1 : 0) << 1 & 0b00000010)
        }
    }
    
    @inlinable
    @inline(__always)
    public static var digitalInputDisable0: Bool { //ADC0D
        get {
            return !((AnalogeDigitalConverter.DigitalInputDisableRegister0 & 0b00000001) == 0)
        }
        set {
            AnalogeDigitalConverter.DigitalInputDisableRegister0 = (AnalogeDigitalConverter.DigitalInputDisableRegister0 & ~0b00000001) | (((newValue == true) ? 1 : 0) & 0b00000001)
        }
    }
    
}

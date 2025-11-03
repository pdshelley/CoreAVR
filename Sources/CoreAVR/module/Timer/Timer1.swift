//===----------------------------------------------------------------------===//
//
// Timer1.swift
// Swift For Arduino
//
// Created by Paul Shelley on 08/29/2023.
// Copyright © 2022 Paul Shelley. All rights reserved.
//
//===----------------------------------------------------------------------===//


public typealias timer1 = Timer1

/// Timer 1 implementation for ATmega48A/PA/88A/PA/168A/PA/328/P
// NOTE: PRTIM1 needs to be written to zero to enable Timer/Counter1 module. See Datasheet section 16.2
public struct Timer1: Timer16Bit, HasExternalClock {
    /// 16.11.8 TIMSK1 – Timer/Counter1 Interrupt Mask Register
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0x6F)       |   -   |   -   | ICIE1 |   -   |   -   |OCIE1B |OCIE1A | TOIE1 |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |   R   |   R   |  R/W  |   R   |   R   |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    // WARNING: This is not fully tested and understood.
    // TODO: Figure out what the TIMSK1 (Timer Interrupt Mask Register) is used for.
    @inlinable
    @inline(__always)
    public static var timerCounterInterruptMaskRegister: UInt8 { // HALGEN: 16-bit in 8-bit address // HALGEN: Renamed `timerCounterInterruptMaskRegister` (was `timerInterruptMaskRegister`)
        get {
            _volatileRegisterReadUInt8(0x6F)
        }
        set {
            _volatileRegisterWriteUInt8(0x6F, newValue)
        }
    }
    
    // HALGEN: Property name and return type missing.
    // HALGEN: Return type implementation missing (*some* enum -> Bool)
    /// ICIE1 – Timer/Counter1 Input Capture Interrupt Enable
    @inlinable
    @inline(__always)
    public static var timerCounterInputCaptureInterruptEnable: Bool {
        get {
            let flag = (timerCounterInterruptMaskRegister & 0b00100000) >> UInt8(5)
            return flag == 1
        }
        set {
            timerCounterInterruptMaskRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(5)
        }
    }
    
    // HALGEN: Property name and return type missing.
    // HALGEN: Return type implementation missing (*some* enum -> Bool)
    /// OCIE1B – Timer/Counter1 Output CompareB Match Interrupt Enable
    @inlinable
    @inline(__always)
    public static var timerCounterOutputCompareBMatchInterruptEnable: Bool {
        get {
            let flag = (timerCounterInterruptMaskRegister & 0b00000100) >> UInt8(2)
            return flag == 1
        }
        set {
            timerCounterInterruptMaskRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(2)
        }
    }
    
    // HALGEN: Property name and return type missing.
    // HALGEN: Return type implementation missing (*some* enum -> Bool)
    /// OCIE1A – Timer/Counter1 Output CompareA Match Interrupt Enable
    @inlinable
    @inline(__always)
    public static var timerCounterOutputCompareAMatchInterruptEnable: Bool {
        get {
            let flag = (timerCounterInterruptMaskRegister & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            timerCounterInterruptMaskRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(1)
        }
    }
    
    // HALGEN: Property name and return type missing.
    // HALGEN: Return type implementation missing (*some* enum -> Bool)
    /// TOIE1 – Timer/Counter1 Overflow Interrupt Enable
    @inlinable
    @inline(__always)
    public static var timerCounterOverflowInterruptEnable: Bool {
        get {
            let flag = (timerCounterInterruptMaskRegister & 0b00000001) >> UInt8(0)
            return flag == 1
        }
        set {
            timerCounterInterruptMaskRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(0)
        }
    }
    
    /// 16.11.9 TIFR1 – Timer/Counter1 Interrupt Flag Register
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// 0x16 (0x36)  |   -   |   -   |  ICF1 |   -   |   -   | OCF1B | OCF1A | TOV1  |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |   R   |   R   |  R/W  |   R   |   R   |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    // WARNING: This is not fully tested and understood.
    // TODO: Figure out what the TIFR1 (Timer Interrupt Flag Register) is used for.
    @inlinable
    @inline(__always)
    public static var timerCounterInterruptFlagRegister: UInt8 { // HALGEN: 16-bit in 8-bit address // HALGEN: Renamed `timerCounterInterruptFlagRegister` (was `timerInterruptFlagRegister`)
        get {
            _volatileRegisterReadUInt8(0x36)
        }
        set {
            _volatileRegisterWriteUInt8(0x36, newValue)
        }
    }
    
    // HALGEN: Property name and return type missing.
    // HALGEN: Return type implementation missing (*some* enum -> Bool)
    /// ICF1 – Input Capture Flag 1
    @inlinable
    @inline(__always)
    public static var inputCaptureFlag1: Bool {
        get {
            let flag = (timerCounterInterruptFlagRegister & 0b00100000) >> UInt8(5)
            return flag == 1
        }
        set {
            timerCounterInterruptFlagRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(5)
        }
    }
    
    // HALGEN: Property name and return type missing.
    // HALGEN: Return type implementation missing (*some* enum -> Bool)
    /// OCF1B – Output Compare Flag 1B
    @inlinable
    @inline(__always)
    public static var outputCompareFlag1B: Bool {
        get {
            let flag = (timerCounterInterruptFlagRegister & 0b00000100) >> UInt8(2)
            return flag == 1
        }
        set {
            timerCounterInterruptFlagRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(2)
        }
    }
    
    // HALGEN: Property name and return type missing.
    // HALGEN: Return type implementation missing (*some* enum -> Bool)
    /// OCF1A – Output Compare Flag 1A
    @inlinable
    @inline(__always)
    public static var outputCompareFlag1A: Bool {
        get {
            let flag = (timerCounterInterruptFlagRegister & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            timerCounterInterruptFlagRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(1)
        }
    }
    
    // HALGEN: Property name and return type missing.
    // HALGEN: Return type implementation missing (*some* enum -> Bool)
    /// TOV1 – Timer/Counter1 Overflow Flag
    @inlinable
    @inline(__always)
    public static var timerCounterOverflowFlag: Bool {
        get {
            let flag = (timerCounterInterruptFlagRegister & 0b00000001) >> UInt8(0)
            return flag == 1
        }
        set {
            timerCounterInterruptFlagRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(0)
        }
    }
    

    /// 16.11.1 TCCR1A – Timer/Counter1 Control Register A
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0x80)       |COM1A1 |COM1A0 |COM1B1 |COM1B0 |   -   |   -   | WGM11 | WGM10 |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |   R   |   R   |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    public static var timerCounterControlRegisterA: UInt8 { // HALGEN: 16-bit for 8-bit register
        get {
            _volatileRegisterReadUInt8(0x80)
        }
        set {
            _volatileRegisterWriteUInt8(0x80, newValue)
        }
    }
    
    // TODO: Test This!
    // TODO: Add check for toggle?
    @inlinable
    @inline(__always)
    public static var compareOutputModeA: Timer.CompareOutputMode { // HALGEN: Renamed `compareOutputModeA` (was `CompareOutputModeA`)
        get {
            let mode = (timerCounterControlRegisterA & 0b11000000) >> UInt8(6)
            return Timer.CompareOutputMode.init(rawValue: mode) ?? .normal
        }
        set {
            timerCounterControlRegisterA |= (newValue.rawValue & 0b00000011) << UInt8(6)
        }
    }
    
    
    // TODO: Test This!
    // TODO: Add check for toggle?
    @inlinable
    @inline(__always)
    public static var compareOutputModeB: Timer.CompareOutputMode { // HALGEN: Renamed `compareOutputModeB` (was `CompareOutputModeB`)
        get {
            let mode = (timerCounterControlRegisterA & 0b00110000) >> UInt8(4) // HALGEN: wrapped in UInt8
            return Timer.CompareOutputMode.init(rawValue: mode) ?? .normal
        }
        set {
            timerCounterControlRegisterA |= (newValue.rawValue & 0b00000011) << UInt8(4)
        }
    }
    
    
    /// 16.11.2 TCCR1B – Timer/Counter1 Control Register B
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0x81)       | ICNC1 | ICES1 |   -   | WGM13 | WGM12 | CS12  | CS11  | CS10  |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |   R   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    public static var timerCounterControlRegisterB: UInt8 { // HALGEN: 16-bit for 8-bit register
        get {
            _volatileRegisterReadUInt8(0x81)
        }
        set {
            _volatileRegisterWriteUInt8(0x81, newValue)
        }
    }
    
    // HALGEN: Property name and return type missing.
    // HALGEN: Return type implementation missing (*some* enum -> Bool)
    /// ICNC1 – Input Capture 1 Noise Canceler
    @inlinable
    @inline(__always)
    public static var inputCapture1NoiseCanceler: Bool {
        get {
            let flag = (timerCounterControlRegisterB & 0b10000000) >> UInt8(7)
            return flag == 1
        }
        set {
            timerCounterControlRegisterB |= (newValue ? 1 : 0) & 0b00000001 << UInt8(7)
        }
    }
    
    // HALGEN: Property name and return type missing.
    // HALGEN: Return type implementation missing (*some* enum -> Bool)
    /// ICES1 – Input Capture 1 Edge Select
    @inlinable
    @inline(__always)
    public static var inputCapture1EdgeSelect: Bool {
        get {
            let flag = (timerCounterControlRegisterB & 0b01000000) >> UInt8(6)
            return flag == 1
        }
        set {
            timerCounterControlRegisterB |= (newValue ? 1 : 0) & 0b00000001 << UInt8(6)
        }
    }
    
    @inlinable
    @inline(__always)
    public static var prescaler: HasExternalClockPrescaling { // HALGEN: Has InternalClockOnlyPrescaling, whilst Timer1 is HasExternalClockPrescaling
        get {
            let mode = timerCounterControlRegisterA & 0b00000111
            return HasExternalClockPrescaling.init(rawValue: mode) ?? .noClockSource
        }
        set {
            timerCounterControlRegisterB |= newValue.rawValue & 0b00000111
        }
    }
    
    
    /// 16.11.3 TCCR1C – Timer/Counter1 Control Register C
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0x82)       | FOC1A | FOC1B |   -   |   -   |   -   |   -   |   -   |   -   |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |   R   |   R   |   R   |   R   |   R   |   R   |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    public static var timerCounterControlRegisterC: UInt8 { // HALGEN: 16-bit for 8-bit register
        get {
            _volatileRegisterReadUInt8(0x82)
        }
        set {
            _volatileRegisterWriteUInt8(0x82, newValue)
        }
    }
    
    // HALGEN: Return type implementation missing (*some* enum -> Bool)
    // HALGEN: Incomplete comment
    /// FOC1A – 
    @inlinable
    @inline(__always)
    public static var forceOutputCompareA: Bool {
        get {
            let flag = (timerCounterControlRegisterC & 0b10000000) >> UInt8(7)
            return flag == 1
        }
        set {
            timerCounterControlRegisterC |= (newValue ? 1 : 0) & 0b00000001 << UInt8(7)
        }
    }
    
    // HALGEN: Return type implementation missing (*some* enum -> Bool)
    // HALGEN: Incomplete comment
    /// FOC1B – 
    @inlinable
    @inline(__always)
    public static var forceOutputCompareB: Bool {
        get {
            let flag = (timerCounterControlRegisterC & 0b01000000) >> UInt8(6)
            return flag == 1
        }
        set {
            timerCounterControlRegisterC |= (newValue ? 1 : 0) & 0b00000001 << UInt8(6)
        }
    }
    
    
    /// 16.11.4 TCNT1H and TCNT1L – Timer/Counter1
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0x85)       |                      TCNT1[15:8]                              |
    /// (0x84)       |                      TCNT1[ 7:0]                              |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    // WARNING: This is not fully tested and understood.
    // TODO: Figure out what the TCNT1 is used for. I think this is just the actual timer counter that is incrimented each tick of the timer.
    @inlinable
    @inline(__always)
    public static var timerCounter: UInt16 { // HALGEN: Renamed `timerCounter` (was `timerCounterNumber`)
        get {
            _volatileRegisterReadUInt16(0x84) // TODO: Check if we need to read from 0x84 or 0x85 to get the correct value
        }
        set {
            _volatileRegisterWriteUInt16(0x84, newValue) // TODO: Check if we need to write to 0x84 or 0x85 to set the correct value
        }
    }
    
    
    
    /// 16.11.5 OCR1AH and OCR1AL – Output Compare Register A
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0x89)       |                      OCR1A[15:8]                              |
    /// (0x88)       |                      OCR1A[ 7:0]                              |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    // TODO: I believe OCR1A always needs to be larger than OCR1B. Should we have a safety for this?
    @inlinable
    @inline(__always)
    public static var timerCounterOutputCompareRegisterA: UInt16 { // HALGEN: Renamed `timerCounterOutputCompareRegisterA` (was `outputCompareRegisterA`)
        get {
            _volatileRegisterReadUInt16(0x88) // TODO: Check if we need to read from 0x88 or 0x89 to get the correct value
        }
        set {
            _volatileRegisterWriteUInt16(0x88, newValue) // TODO: Check if we need to write to 0x88 or 0x89 to set the correct value
        }
    }
    
    
    
    /// 16.11.6 OCR1BH and OCR1BL – Output Compare Register B
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0x8B)       |                      OCR1A[15:8]                              |
    /// (0x8A)       |                      OCR1A[ 7:0]                              |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    // TODO: I believe OCR1A always needs to be larger than OCR1B. Should we have a safety for this?
    @inlinable
    @inline(__always)
    public static var timerCounterOutputCompareRegisterB: UInt16 { // HALGEN: Renamed `timerCounterOutputCompareRegisterB` (was `outputCompareRegisterB`)
        get {
            _volatileRegisterReadUInt16(0x8A) // TODO: Check if we need to read from 0x8A or 0x8B to get the correct value
        }
        set {
            _volatileRegisterWriteUInt16(0x8A, newValue) // TODO: Check if we need to write to 0x8A or 0x8B to set the correct value
        }
    }
    
    
    /// 16.11.7 ICR1H and ICR1L – Input Capture Register 1
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0x87)       |                       ICR1[15:8]                              |
    /// (0x86)       |                       ICR1[ 7:0]                              |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    @inlinable
    @inline(__always)
    public static var timerCounterInputCaptureRegisterBytes: UInt16 { // HALGEN: Renamed `timerCounterInputCaptureRegisterBytes` (was `inputCaptureRegister`)
        get {
            _volatileRegisterReadUInt16(0x86) // TODO: Check if we need to read from 0x86 or 0x87 to get the correct value
        }
        set {
            _volatileRegisterWriteUInt16(0x86, newValue) // TODO: Check if we need to write to 0x86 or 0x87 to set the correct value
        }
    }
    
    /// GTCCR – General Timer/Counter Control Register
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0x43)       |  TSM  |   -   |   -   |   -   |   -   |   -   |   -   |PSRSYNC|
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |   ?   |   ?   |   ?   |   ?   |   ?   |   ?   |   ?   |   ?   |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    @inlinable
    @inline(__always)
    public static var generalTimerCounterControlRegister: UInt8 { // HALGEN: 16-bit for 8-bit register
        get {
            _volatileRegisterReadUInt8(0x43)
        }
        set {
            _volatileRegisterWriteUInt8(0x43, newValue)
        }
    }
    
    /// TSM – Timer/Counter Synchronization Mode
    @inlinable
    @inline(__always)
    public static var timerSynchronizationMode: Timer.TimerSynchronizationMode {
        get {
            let mode = (generalTimerCounterControlRegister & 0b10000000) >> UInt8(7)
            return Timer.TimerSynchronizationMode.init(rawValue: mode) ?? .disabled
        }
        set {
            generalTimerCounterControlRegister |= (newValue.rawValue) & 0b00000001 << UInt8(7) // HALGEN: Missing `)`
                                                                                               // (newValue.rawValue
                                                                                               //                   ^
                                                                                               //                   here
        }
    }
    
    /// PSRSYNC – Prescaler Reset Timer/Counter1 and Timer/Counter0
    @inlinable
    @inline(__always)
    public static var prescalerResetTimerCounter: Bool {
        get {
            let flag = (generalTimerCounterControlRegister & 0b00000001) >> UInt8(0)
            return flag == 1
        }
        set {
            generalTimerCounterControlRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(0)
        }
    }
    
    
    // TODO: Figure out what FOC2A and FOC2B are for.
    
    // NOTE: There are many uses for PWM, some as simple as holding the same pulse width and only changing periodically for hobby servo control or LED brightness,
    // while more advanced uses can use the timer interupt to dynamically change the pulse width to output complex wave forms.
    
    /// See ATMega328p Datasheet Table 18-8.
    /// Table 18-8. Waveform Generation Mode Bit Description
    ///```
    ///---------------------------------------------------------------------------------------------------
    ///  Mode  | WGM22 | WGM21 | WGM20 | Mode of Operation  |  TOP  | Update of OCRx at | TOV Flag Set on |
    ///---------------------------------------------------------------------------------------------------
    ///    0   |   0   |   0   |   0   | Normal             | 0xFF  | Immediate         | MAX             |
    ///---------------------------------------------------------------------------------------------------
    ///    1   |   0   |   0   |   1   | PWM, Phase Correct | 0xFF  | TOP               | BOTTOM          |
    ///---------------------------------------------------------------------------------------------------
    ///    2   |   0   |   1   |   0   | CTC                | OCRA  | Immediate         | MAX             |
    ///---------------------------------------------------------------------------------------------------
    ///    3   |   0   |   1   |   1   | Fast PWM           | 0xFF  | BOTTOM            | MAX             |
    ///---------------------------------------------------------------------------------------------------
    ///    4   |   1   |   0   |   0   | Reserved           |   -   |         -         |        -        |
    ///---------------------------------------------------------------------------------------------------
    ///    5   |   1   |   0   |   1   | PWM, Phase Correct | OCRA  | TOP               | BOTTOM          |
    ///---------------------------------------------------------------------------------------------------
    ///    6   |   1   |   1   |   0   | Reserved           |   -   |         -         |        -        |
    ///---------------------------------------------------------------------------------------------------
    ///    7   |   1   |   1   |   1   | Fast PWM           | OCRA  | BOTTOM            | TOP             |
    ///---------------------------------------------------------------------------------------------------
    ///```
    ///Notes: 1. MAX= 0xFF
    ///       2. BOTTOM= 0x00
    ///
    @inlinable
    @inline(__always)
    public static var waveformGenerationMode: Timer16Bit.WaveformGenerationMode {
        get {
            let mode = ((timerCounterControlRegisterB & 0b00001000) >> 1) | (timerCounterControlRegisterA & 0b00000011)
            return Timer16Bit.WaveformGenerationMode.init(rawValue: mode) ?? .normal
        }
        set {
            timerCounterControlRegisterA |= (newValue.rawValue & 0b00000011)
            timerCounterControlRegisterB |= ((newValue.rawValue & 0b00000100) << UInt8(1))
        }
    }
}


//===----------------------------------------------------------------------===//
//
// Timer1.swift
// Swift For Arduino
//
// Created by Paul Shelley on 08/29/2023.
// Copyright © 2022 Paul Shelley. All rights reserved.
//
//===----------------------------------------------------------------------===//


typealias timer1 = Timer1

/// Timer 2 implementation for ATmega48A/PA/88A/PA/168A/PA/328/P
// NOTE: PRTIM2 needs to be written to zero to enable Timer/Counter2 module. See Datasheet section 18.2
struct Timer1: Timer16Bit, HasExternalClock {
    

    static var timerCounterControlRegisterA: UInt8 {
        get {
            return 0
//            _volatileRegisterReadUInt8(0x44) // TODO: Change hex
        }
        set {
//            _volatileRegisterWriteUInt8(0x44, newValue) // TODO: Change hex
        }
    }
    
    
    /// 18.11.2 TCCR2B – Timer/Counter Control Register B
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0xBC)       | FOC2A | FOC2B |   -   |   -   | WGM22 | CS22  | CS21  | CS20  |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |   R   |   R   |  R/W  |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    static var timerCounterControlRegisterB: UInt8 {
        get {
            return 0
//            _volatileRegisterReadUInt8(0x45) // TODO: Change hex
        }
        set {
//            _volatileRegisterWriteUInt8(0x45, newValue) // TODO: Change hex
        }
    }
    
    
    
    
    /// 18.11.3 TCNT2 – Timer/Counter Register
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0xBC)       |                         TCNT2                                 |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    /// WARNING: This is not fully tested and understood.
    /// TODO: Figure out what the TCNT2 is used for. I think this is just the actual timer counter that is incrimented each tick of the timer.
    /// TODO: Decide about simplifying this with TCNT2
    @inlinable
    @inline(__always)
    static var timerCounterNumber: UInt16 {
        get {
            return 0 // _volatileRegisterReadUInt16(0x46) // TODO: Change hex and check to see if this works for 16 bit.
        }
        set {
//            _volatileRegisterWriteUInt16(0x46, newValue) // TODO: Change hex and check to see if this works for 16 bit.
        }
    }
    
    
    
    /// 18.11.4 OCR2A – Output Compare Register A
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0xBC)       |                         OCR2A                                 |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    /// TODO: I believe OCR2A always needs to be larger than OCR2B. Should we have a safety for this?
    /// TODO: Decide about simplifying this with OCR2A
    @inlinable
    @inline(__always)
    static var outputCompareRegisterA: UInt16 {
        get {
            return 0 // _volatileRegisterReadUInt16(0x47) // TODO: Change hex and check to see if this works for 16 bit.
        }
        set {
//            _volatileRegisterWriteUInt16(0x47, newValue) // TODO: Change hex and check to see if this works for 16 bit.
        }
    }
    
    
    
    /// 18.11.5 OCR2B – Output Compare Register B
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0xBC)       |                         OCR2B                                 |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    /// TODO: I believe OCR2A always needs to be larger than OCR2B. Should we have a safety for this?
    /// TODO: Decide about simplifying this with OCR2B
    @inlinable
    @inline(__always)
    static var outputCompareRegisterB: UInt16 {
        get {
            return 0 // _volatileRegisterReadUInt16(0x48) // TODO: Change hex and check to see if this works for 16 bit.
        }
        set {
//            _volatileRegisterWriteUInt16(0x48, newValue) // TODO: Change hex and check to see if this works for 16 bit.
        }
    }
    
    
    /// 18.11.6 TIMSK2 – Timer/Counter2 Interrupt Mask Register
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0xBC)       |   -   |   -   |   -   |   -   |   -   |OCIE2B |OCIE2A | TOIE2 |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    /// WARNING: This is not fully tested and understood.
    /// TODO: Figure out what the TIMSK2 (Timer Interrupt Mask Register) is used for.
    /// TODO: Decide about simplifying this with TIMSK2
    @inlinable
    @inline(__always)
    static var timerInterruptMaskRegister: UInt8 {
        get {
            return 0 // _volatileRegisterReadUInt8(0x6E) // TODO: Change hex
        }
        set {
//            _volatileRegisterWriteUInt8(0x6E, newValue) // TODO: Change hex
        }
    }
    
    
    /// 18.11.7 TIFR2 – Timer/Counter2 Interrupt Flag Register
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0xBC)       |   -   |   -   |   -   |   -   |   -   | OCF2B | OCF2A | TOV2  |
    ///-------------------------------------------------------------------------------
    /// Read/Write   |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    /// WARNING: This is not fully tested and understood.
    /// TODO: Figure out what the TIFR2 (Timer Interrupt Flag Register) is used for.
    /// TODO: Decide about simplifying this with TIFR2
    @inlinable
    @inline(__always)
    static var timerInterruptFlagRegister: UInt8 {
        get {
            return 0 // _volatileRegisterReadUInt8(0x35) // TODO: Change hex
        }
        set {
//            _volatileRegisterWriteUInt8(0x35, newValue) // TODO: Change hex
        }
    }
    
    
    /// 18.11.8 ASSR – Asynchronous Status Register
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0xBC)       |   -   | EXCLK |  AS2  |TCN2UB |OCR2AUB|OCR2BUB|TCR2AUB|TCR2BUB|
    ///-------------------------------------------------------------------------------
    /// Read/Write   |   R   |  R/W  |  R/W  |   R   |   R   |   R   |   R   |   R   |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    /// WARNING: This is not fully tested and understood.
    /// TODO: Figure out what the ASSR (Asynchronous Status Register) is used for.
    /// TODO: Decide about simplifying this with ASSR
    @inlinable
    @inline(__always)
    static var asynchronousStatusRegister: UInt8 {
        get {
            return 0 // _volatileRegisterReadUInt8(0xB6) // TODO: is this register address shared by all timers?
        }
        set {
//            _volatileRegisterWriteUInt8(0xB6, newValue) // TODO: is this register address shared by all timers?
        }
    }
    
    
    
    /// 18.11.9 GTCCR – General Timer/Counter Control Register
    ///```
    ///-------------------------------------------------------------------------------
    /// Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///-------------------------------------------------------------------------------
    /// (0xBC)       |  TSM  |   -   |   -   |   -   |   -   |   -   |PSRASY |PSRSYNC|
    ///-------------------------------------------------------------------------------
    /// Read/Write   |  R/W  |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |
    ///-------------------------------------------------------------------------------
    /// InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///-------------------------------------------------------------------------------
    ///```
    /// WARNING: This is not fully tested and understood.
    /// TODO: Figure out what the GTCCR (General Timer/Counter Control Register) is used for.
    /// TODO: Decide about simplifying this with GTCCR
    @inlinable
    @inline(__always)
    static var generalTimerCounterControlRegister: UInt8 {
        get {
            return 0 // _volatileRegisterReadUInt8(0x43) // TODO: Change hex
        }
        set {
//            _volatileRegisterWriteUInt8(0x43, newValue) // TODO: Change hex
        }
    }
    
    
    // TODO: Figure out what FOC2A and FOC2B are for.
    
    // NOTE: There are many uses for PWM, some as simple as holding the same pulse width and only changing periodically for hobby servo control or LED brightness,
    // while more advanced uses can use the timer interupt to dynamically change the pulse width to output complex wave forms.
    
    
    // TODO: Test This!
    // TODO: Add check for toggle?
    @inlinable
    @inline(__always)
    static var CompareOutputModeA: Timer.CompareOutputMode {
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
    static var CompareOutputModeB: Timer.CompareOutputMode {
        get {
            let mode = (timerCounterControlRegisterA & 0b00110000) >> 4
            return Timer.CompareOutputMode.init(rawValue: mode) ?? .normal
        }
        set {
            timerCounterControlRegisterA |= (newValue.rawValue & 0b00000011) << UInt8(4)
        }
    }
    
    @inlinable
    @inline(__always)
    static var prescalor: HasExternalClockPrescaling {
        get {
            let mode = timerCounterControlRegisterA & 0b00000111
            return HasExternalClockPrescaling.init(rawValue: mode) ?? .noClockSource
        }
        set {
            timerCounterControlRegisterB |= newValue.rawValue & 0b00000111
        }
    }
    
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
    static var waveformGenerationMode: Timer16Bit.WaveformGenerationMode {
        get {
            let mode = ((timerCounterControlRegisterB & 0b00001000) >> 1) | (timerCounterControlRegisterA & 0b00000011)
            return Timer16Bit.WaveformGenerationMode.init(rawValue: mode) ?? .normal
        }
        set {
            timerCounterControlRegisterA |= (newValue.rawValue & 0b00000011)
            timerCounterControlRegisterB |= ((newValue.rawValue & 0b00000100) << UInt8(1))
        }
    }
    
    
    static var timerCounterControlRegisterC: UInt8 {
        get {
            return 0
//            _volatileRegisterReadUInt8(0x82)
        }
        set {
//            _volatileRegisterWriteUInt8(0x82, newValue)
        }
    }
    
    
    @inlinable
    @inline(__always)
    static var TCNT1L: UInt8 { //TCNT1L
        get {
            return 0 // _volatileRegisterReadUInt8(0x84)
        }
        set {
//            _volatileRegisterWriteUInt8(0x84, newValue)
        }
    }
    
    @inlinable
    @inline(__always)
    static var TCNT1H: UInt8 { //TCNT1H
        get {
            return 0 // _volatileRegisterReadUInt8(0x85)
        }
        set {
//            _volatileRegisterWriteUInt8(0x85, newValue)
        }
    }
    
    @inlinable
    @inline(__always)
    static var OCR1AL: UInt8 {
        get {
            return 0 // _volatileRegisterReadUInt8(0x88)
        }
        set {
//            _volatileRegisterWriteUInt8(0x88, newValue)
        }
    }
    
    static var OCR1AH: UInt8 {
        get {
            return 0 // _volatileRegisterReadUInt8(0x89)
        }
        set {
//            _volatileRegisterWriteUInt8(0x89, newValue)
        }
    }
    
    @inlinable
    @inline(__always)
    static var OCR1BL: UInt8 {
        get {
            return 0 // _volatileRegisterReadUInt8(0x8A)
        }
        set {
//            _volatileRegisterWriteUInt8(0x8A, newValue)
        }
    }
    
    @inlinable
    @inline(__always)
    static var OCR1BH: UInt8 {
        get {
            return 0 // _volatileRegisterReadUInt8(0x8B)
        }
        set {
//            _volatileRegisterWriteUInt8(0x8B, newValue)
        }
    }
    
    
    // TODO: Figure out what FOC2A and FOC2B are for.
    
    // NOTE: There are many uses for PWM, some as simple as holding the same pulse width and only changing periodically for hobby servo control or LED brightness,
    // while more advanced uses can use the timer interupt to dynamically change the pulse width to output complex wave forms.
}


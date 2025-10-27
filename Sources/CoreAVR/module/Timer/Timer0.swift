//===----------------------------------------------------------------------===//
//
// Timer0.swift
// Swift For Arduino
//
// Created by Paul Shelley on 12/31/2022.
// Copyright © 2022 Paul Shelley. All rights reserved.
//
//===----------------------------------------------------------------------===//

import CCoreAVR

typealias timer0 = Timer0

/// Timer 0 implementation for ATmega48A/PA/88A/PA/168A/PA/328/P
// NOTE: PRTIM0 needs to be written to zero to enable Timer/Counter0 module. See Datasheet section 15.2
struct Timer0: Timer8Bit, HasExternalClock {

    /// 15.9.1 TCCR0A – Timer/Counter Control Register A
    /// ```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| 0x24 (0x44)  |COM0A1 |COM0A0 |COM0B1 |COM0B0 |   -   |   -   | WGM01 | WGM00 |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |   R   |   R   |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    static var timerCounterControlRegisterA: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x44)
        }
        set {
            _volatileRegisterWriteUInt8(0x44, newValue)
        }
    }
    
    
    /// 15.9.2 TCCR0B – Timer/Counter Control Register B
    ///```
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///|--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    ///| 0x25 (0x45)  | FOC2A | FOC2B |   -   |   -   | WGM22 | CS22  | CS21  | CS20  |
    ///| Read/Write   |  R/W  |  R/W  |   R   |   R   |  R/W  |  R/W  |  R/W  |  R/W  |
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///```
    @inlinable
    @inline(__always)
    static var timerCounterControlRegisterB: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x45)
        }
        set {
            _volatileRegisterWriteUInt8(0x45, newValue)
        }
    }
    
    
    /// 15.9.3 TCNT0 – Timer/Counter Register
    ///```
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///|--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    ///| 0x26 (0x46)  |                         TCNT0                                 |
    ///| Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///```
    // WARNING: This is not fully tested and understood.
    // TODO: Figure out what the TCNT0 is used for. I think this is just the actual timer counter that is incrimented each tick of the timer.
    @inlinable
    @inline(__always)
    static var timerCounterNumber: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x46)
        }
        set {
            _volatileRegisterWriteUInt8(0x46, newValue)
        }
    }
    
    
    /// 15.9.4 OCR0A – Output Compare Register A
    ///```
    ///|Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///|-------------|-------|-------|-------|-------|-------|-------|-------|-------|
    ///|0x27 (0x47)  |                         OCR0A                                 |
    ///|Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///|InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///```
    // TODO: I believe OCR0A always needs to be larger than OCR0B. Should we have a safety for this?
    @inlinable
    @inline(__always)
    static var outputCompareRegisterA: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x47)
        }
        set {
            _volatileRegisterWriteUInt8(0x47, newValue)
        }
    }
    
    
    
    /// 15.9.5 OCR0B – Output Compare Register B
    ///```
    ///|Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///|-------------|-------|-------|-------|-------|-------|-------|-------|-------|
    ///|0x28 (0x48)  |                         OCR0B                                 |
    ///|Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///|InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///```
    // TODO: I believe OCR0A always needs to be larger than OCR0B. Should we have a safety for this?
    @inlinable
    @inline(__always)
    static var outputCompareRegisterB: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x48)
        }
        set {
            _volatileRegisterWriteUInt8(0x48, newValue)
        }
    }
    
    
    /// 15.9.6 TIMSK0 – Timer/Counter Interrupt Mask Register
    ///```
    ///|Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///|-------------|-------|-------|-------|-------|-------|-------|-------|-------|
    ///|(0x6E)       |   -   |   -   |   -   |   -   |   -   |OCIE0B |OCIE0A | TOIE0 |
    ///|Read/Write   |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |
    ///|InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///```
    // WARNING: This is not fully tested and understood.
    // TODO: Figure out what the TIMSK0 (Timer Interrupt Mask Register) is used for.
    @inlinable
    @inline(__always)
    static var timerInterruptMaskRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x6E)
        }
        set {
            _volatileRegisterWriteUInt8(0x6E, newValue)
        }
    }
    
    
    /// 15.9.7 TIFR0 – Timer/Counter Interrupt Flag Register
    ///```
    ///|Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///|-------------|-------|-------|-------|-------|-------|-------|-------|-------|
    ///|0x15 (0x35)  |   -   |   -   |   -   |   -   |   -   | OCF0B | OCF0A | TOV0  |
    ///|Read/Write   |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |
    ///|InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///```
    // WARNING: This is not fully tested and understood.
    // TODO: Figure out what the TIFR (Timer Interrupt Flag Register) is used for.
    @inlinable
    @inline(__always)
    static var timerInterruptFlagRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x35)
        }
        set {
            _volatileRegisterWriteUInt8(0x35, newValue)
        }
    }
    
    
    // TODO: Test This!
    // TODO: Add check for toggle?
    @inlinable
    @inline(__always)
    static var CompareOutputModeA: Timer.CompareOutputMode {
        get {
            let mode = (timerCounterControlRegisterA & 0b11000000) >> UInt8(6) // TODO: Check Bit Mask
            return Timer.CompareOutputMode.init(rawValue: mode) ?? .normal
        }
        set {
            timerCounterControlRegisterA |= (newValue.rawValue & 0b00000011) << UInt8(6) // TODO: Check Bit Mask
        }
    }
    
    
    // TODO: Test This!
    // TODO: Add check for toggle?
    @inlinable
    @inline(__always)
    static var CompareOutputModeB: Timer.CompareOutputMode {
        get {
            let mode = (timerCounterControlRegisterA & 0b00110000) >> 4 // TODO: Check Bit Mask
            return Timer.CompareOutputMode.init(rawValue: mode) ?? .normal
        }
        set {
            timerCounterControlRegisterA |= (newValue.rawValue & 0b00000011) << UInt8(4) // TODO: Check Bit Mask
        }
    }
    
    @inlinable
    @inline(__always)
    static var prescaler: HasExternalClockPrescaling {
        get {
            let mode = timerCounterControlRegisterB & 0b00000111 // TODO: Check Bit Mask
            return HasExternalClockPrescaling.init(rawValue: mode) ?? .noClockSource
        }
        set {
            timerCounterControlRegisterB |= newValue.rawValue & 0b00000111 // TODO: Check Bit Mask
        }
    }
    
    /// See ATMega328p Datasheet Table 18-8.
    /// Table 18-8. Waveform Generation Mode Bit Description
    ///```
    ///| Mode  | WGM22 | WGM21 | WGM20 | Mode of Operation  |  TOP  | Update of OCRx at | TOV Flag Set on |
    ///|-------|-------|-------|-------|--------------------|-------|-------------------|-----------------|
    ///|   0   |   0   |   0   |   0   | Normal             | 0xFF  | Immediate         | MAX             |
    ///|   1   |   0   |   0   |   1   | PWM, Phase Correct | 0xFF  | TOP               | BOTTOM          |
    ///|   2   |   0   |   1   |   0   | CTC                | OCRA  | Immediate         | MAX             |
    ///|   3   |   0   |   1   |   1   | Fast PWM           | 0xFF  | BOTTOM            | MAX             |
    ///|   4   |   1   |   0   |   0   | Reserved           |   -   |         -         |        -        |
    ///|   5   |   1   |   0   |   1   | PWM, Phase Correct | OCRA  | TOP               | BOTTOM          |
    ///|   6   |   1   |   1   |   0   | Reserved           |   -   |         -         |        -        |
    ///|   7   |   1   |   1   |   1   | Fast PWM           | OCRA  | BOTTOM            | TOP             |
    ///```
    ///Notes: 1. MAX= 0xFF
    ///       2. BOTTOM= 0x00
    ///
    ///
    @inlinable
    @inline(__always)
    static var waveformGenerationMode: Timer8Bit.WaveformGenerationMode {
        get {
            let mode = ((timerCounterControlRegisterB & 0b00001000) >> 1) | (timerCounterControlRegisterA & 0b00000011) // TODO: Check Bit Mask
            return Timer8Bit.WaveformGenerationMode.init(rawValue: mode) ?? .normal
        }
        set {
            timerCounterControlRegisterA |= (newValue.rawValue & 0b00000011) // TODO: Check Bit Mask
            timerCounterControlRegisterB |= ((newValue.rawValue & 0b00000100) << UInt8(1)) // TODO: Check Bit Mask
        }
    }
}

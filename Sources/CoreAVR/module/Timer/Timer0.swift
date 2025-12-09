//===----------------------------------------------------------------------===//
//
// Timer0.swift
// CoreAVR
//
// Created by Swift AVR Generator on 12/04/2025.
// Copyright © 2025 Paul Shelley. All rights reserved.
//
//===----------------------------------------------------------------------===//


public typealias timer0 = Timer0

public struct Timer0: Timer8Bit {
    /// OCR0B – Timer/Counter0 Output Compare Register
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0x48)       |                             OCR0B                             |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |                              R/W                              |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    @inlinable
    @inline(__always)
    public static var outputCompareRegisterB: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x48)
        }
        set {
            _volatileRegisterWriteUInt8(0x48, newValue)
        }
    }
    /// OCR0A – Timer/Counter0 Output Compare Register
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0x47)       |                             OCR0A                             |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |                              R/W                              |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    @inlinable
    @inline(__always)
    public static var outputCompareRegisterA: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x47)
        }
        set {
            _volatileRegisterWriteUInt8(0x47, newValue)
        }
    }
    /// TCNT0 – Timer/Counter0
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0x46)       |                             TCNT0                             |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |                              R/W                              |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    @inlinable
    @inline(__always)
    public static var count: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x46)
        }
        set {
            _volatileRegisterWriteUInt8(0x46, newValue)
        }
    }
    /// TCCR0B – Timer/Counter Control Register B
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0x45)       | FOC0A | FOC0B |   -   |   -   | WGM02 | CS02  | CS01  | CS00  |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |   W   |   W   |   R   |   R   |  R/W  |  R/W  |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    @inlinable
    @inline(__always)
    public static var controlRegisterB: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x45)
        }
        set {
            _volatileRegisterWriteUInt8(0x45, newValue)
        }
    }
    /// FOC0A – Force Output Compare A 
    ///
    /// The FOCnA bit is only active when the WGM bits specify a non-PWM mode.
    /// However, for ensuring compatibility with future devices, this bit must be set to zero when TCCRnB is written
    /// when operating in PWM mode. When writing a logical one to the FOCnA bit, an immediate Compare Match is
    /// forced on the Waveform Generation unit. The OCnA output is changed according to its COMnA bits setting.
    /// Note that the FOCnA bit is implemented as a strobe. Therefore it is the value present in the COMnA bits that
    /// determines the effect of the forced compare.
    /// A FOCnA strobe will not generate any interrupt, nor will it clear the timer in CTC mode using OCRnA as TOP.
    /// The FOCnA bit is always read as zero.
    @inlinable
    @inline(__always)
    public static var forceOutputCompareA: Bool {
        get {
            let flag = (controlRegisterB & 0b10000000) >> UInt8(7)
            return flag == 1
        }
        set {
            controlRegisterB |= (newValue ? 1 : 0) & 0b00000001 << UInt8(7)
        }
    }
    /// FOC0B – Force Output Compare B 
    ///
    /// The FOCnB bit is only active when the WGM bits specify a non-PWM mode.
    /// However, for ensuring compatibility with future devices, this bit must be set to zero when TCCRnB is written
    /// when operating in PWM mode. When writing a logical one to the FOCnB bit, an immediate Compare Match is
    /// forced on the Waveform Generation unit. The OCnB output is changed according to its COMnB bits setting.
    /// Note that the FOCnB bit is implemented as a strobe. Therefore it is the value present in the COMnB bits that
    /// determines the effect of the forced compare.
    /// A FOCnB strobe will not generate any interrupt, nor will it clear the timer in CTC mode using OCRnB as TOP.
    /// The FOCnB bit is always read as zero.
    @inlinable
    @inline(__always)
    public static var forceOutputCompareB: Bool {
        get {
            let flag = (controlRegisterB & 0b01000000) >> UInt8(6)
            return flag == 1
        }
        set {
            controlRegisterB |= (newValue ? 1 : 0) & 0b00000001 << UInt8(6)
        }
    }
    /// ```
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |  Mode  | CS02  | CS01  | CS00  | Description                                                     |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    0   |   0   |   0   |   0   | No Clock Source (Stopped)                                       |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    1   |   0   |   0   |   1   | Running, No Prescaling                                          |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    2   |   0   |   1   |   0   | Running, CLK/8                                                  |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    3   |   0   |   1   |   1   | Running, CLK/64                                                 |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    4   |   1   |   0   |   0   | Running, CLK/256                                                |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    5   |   1   |   0   |   1   | Running, CLK/1024                                               |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    6   |   1   |   1   |   0   | External clock source. Clock on falling edge.                   |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    7   |   1   |   1   |   1   | External clock source. Clock on rising edge.                    |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// ```
    public enum Prescaling: UInt8 {
        case stopped = 0
        case runningWithoutPrescaling = 1
        case running8 = 2
        case running64 = 3
        case running256 = 4
        case running1024 = 5
        case runningExternalFallingEdge = 6
        case runningExternalRisingEdge = 7
    }
    /// CS0 – Clock Select 
    /// The three Clock Select bits select the clock source to be used by the Timer/Counter.
    @inlinable
    @inline(__always)
    public static var prescaler: Prescaling {
        get {
            let mode = (controlRegisterB & 0b00000111) >> UInt8(0)
            return Prescaling.init(rawValue: mode) ?? .stopped
        }
        set {
            controlRegisterB |= (newValue.rawValue & 0b00000111) << UInt8(0)
        }
    }
    /// TCCR0A – Timer/Counter  Control Register A
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0x44)       |COM0A1 |COM0A0 |COM0B1 |COM0B0 |   -   |   -   | WGM01 | WGM00 |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |   R   |   R   |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    @inlinable
    @inline(__always)
    public static var controlRegisterA: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x44)
        }
        set {
            _volatileRegisterWriteUInt8(0x44, newValue)
        }
    }
    /// COM0A – Compare Output Mode, Phase Correct PWM Mode 
    ///
    /// These bits control the Output Compare pin (OC2A) behavior. If one or both of the COM2A1:0 bits are set, the
    /// OC2A output overrides the normal port functionality of the I/O pin it is connected to. However, note that the Data
    /// Direction Register (DDR) bit corresponding to the OC2A pin must be set in order to enable the output driver.
    /// When OC2A is connected to the pin, the function of the COM2A1:0 bits depends on the WGM22:0 bit setting.
    /// Table 1 shows the COM2A1:0 bit functionality when the WGM22:0 bits are set to a normal or CTC mode
    /// (non-PWM).
    ///
    /// Table 1. Compare Output Mode, non-PWM Mode
    ///```
    ///---------------------------------------------------------------------------------------------
    ///|  Mode  | COM2A1| COM2A0| Description                                                      |
    ///---------------------------------------------------------------------------------------------
    ///| normal |   0   |   0   | Normal port operation, OC0A disconnected.                        |
    ///---------------------------------------------------------------------------------------------
    ///| toggle |   0   |   1   | Toggle OC2A on Compare Match                                     |
    ///---------------------------------------------------------------------------------------------
    ///| clear  |   1   |   0   | Clear OC2A on Compare Match                                      |
    ///---------------------------------------------------------------------------------------------
    ///| set    |   1   |   1   | Set OC2A on Compare Match                                        |
    ///---------------------------------------------------------------------------------------------
    ///```
    ///
    /// Table 2 shows the COM2A1:0 bit functionality when the WGM21:0 bits are set to fast PWM mode.
    ///
    /// Table 2. Compare Output Mode, Fast PWM Mode
    ///```
    ///---------------------------------------------------------------------------------------------
    ///|  Mode  | COM2A1| COM2A0| Description                                                      |
    ///---------------------------------------------------------------------------------------------
    ///| normal |   0   |   0   | Normal port operation, OC2A disconnected.                        |
    ///---------------------------------------------------------------------------------------------
    ///| toggle |   0   |   1   | WGM22 = 0: Normal Port Operation, OC0A Disconnected.             |
    ///|        |       |       | WGM22 = 1: Toggle OC2A on Compare Match.                         |
    ///---------------------------------------------------------------------------------------------
    ///| clear  |   1   |   0   | Clear OC2A on Compare Match, set OC2A at BOTTOM,                 |
    ///|        |       |       | (non-inverting mode).                                            |
    ///---------------------------------------------------------------------------------------------
    ///| set    |   1   |   1   | Set OC2A on Compare Match, clear OC2A at BOTTOM,                 |
    ///|        |       |       | (inverting mode).                                                |
    ///---------------------------------------------------------------------------------------------
    ///```
    /// Note: 1. A special case occurs when OCR2A equals TOP and COM2A1 is set. In this case, the Compare Match is
    ///       ignored, but the set or clear is done at BOTTOM. See ”Fast PWM Mode” in datasheet  for more details.
    ///
    /// Table 3 shows the COM2A1:0 bit functionality when the WGM22:0 bits are set to phase correct PWM mode.
    ///
    /// Table 3. Compare Output Mode, Phase Correct PWM Mode
    ///```
    ///---------------------------------------------------------------------------------------------
    ///|  Mode  | COM2A1| COM2A0| Description                                                      |
    ///---------------------------------------------------------------------------------------------
    ///| normal |   0   |   0   | Normal port operation, OC2A disconnected.                        |
    ///---------------------------------------------------------------------------------------------
    ///| toggle |   0   |   1   | WGM22 = 0: Normal Port Operation, OC0A Disconnected.             |
    ///|        |       |       | WGM22 = 1: Toggle OC2A on Compare Match.                         |
    ///---------------------------------------------------------------------------------------------
    ///| clear  |   1   |   0   | Clear OC2A on Compare Match when up-counting.                    |
    ///|        |       |       | Set OC2A on Compare Match when down-counting.                    |
    ///---------------------------------------------------------------------------------------------
    ///| set    |   1   |   1   | Set OC2A on Compare Match when up-counting.                      |
    ///|        |       |       | Clear OC2A on Compare Match when down-counting.                  |
    ///---------------------------------------------------------------------------------------------
    ///```
    /// Note: 1. A special case occurs when OCR2A equals TOP and COM2A1 is set. In this case, the Compare Match is
    ///       ignored, but the set or clear is done at TOP. See ”Phase Correct PWM Mode” in datasheet for more details.
    ///
    @inlinable
    @inline(__always)
    public static var compareOutputModeA: Timer.CompareOutputMode {
        get {
            let mode = (controlRegisterA & 0b11000000) >> UInt8(6)
            return Timer.CompareOutputMode.init(rawValue: mode) ?? .normal
        }
        set {
            controlRegisterA |= (newValue.rawValue & 0b00000011) << UInt8(6)
        }
    }
    /// COM0B – Compare Output Mode, Fast PWm 
    /// See ATMega328p Datasheet Table 18-5, Table 18-6, and Table 18-7.
    ///
    /// These bits control the Output Compare pin (OC2B) behavior. If one or both of the COM2B1:0 bits are set, the
    /// OC2B output overrides the normal port functionality of the I/O pin it is connected to. However, note that the Data
    /// Direction Register (DDR) bit corresponding to the OC2B pin must be set in order to enable the output driver.
    /// When OC2B is connected to the pin, the function of the COM2B1:0 bits depends on the WGM22:0 bit setting.
    /// Table 18-5 shows the COM2B1:0 bit functionality when the WGM22:0 bits are set to a normal or CTC mode
    /// (non-PWM).
    ///
    /// Table 18-5. Compare Output Mode, non-PWM Mode
    ///```
    ///---------------------------------------------------------------------------------------------
    ///|  Mode  | COM2B1| COM2B0| Description                                                      |
    ///---------------------------------------------------------------------------------------------
    ///| normal |   0   |   0   | Normal port operation, OC0B disconnected.                        |
    ///---------------------------------------------------------------------------------------------
    ///| toggle |   0   |   1   | Toggle OC2B on Compare Match                                     |
    ///---------------------------------------------------------------------------------------------
    ///| clear  |   1   |   0   | Clear OC2B on Compare Match                                      |
    ///---------------------------------------------------------------------------------------------
    ///| set    |   1   |   1   | Set OC2B on Compare Match                                        |
    ///---------------------------------------------------------------------------------------------
    ///```
    ///
    /// Table 18-6 shows the COM2B1:0 bit functionality when the WGM22:0 bits are set to fast PWM mode.
    ///
    /// Table 18-6. Compare Output Mode, Fast PWM Mode
    ///```
    ///---------------------------------------------------------------------------------------------
    ///|  Mode  | COM2B1| COM2B0| Description                                                      |
    ///---------------------------------------------------------------------------------------------
    ///| normal |   0   |   0   | Normal port operation, OC2B disconnected.                        |
    ///---------------------------------------------------------------------------------------------
    ///| toggle |   0   |   1   | Reserved                                                         |
    ///---------------------------------------------------------------------------------------------
    ///| clear  |   1   |   0   | Clear OC2B on Compare Match, set OC2B at BOTTOM,                 |
    ///|        |       |       | (non-inverting mode).                                            |
    ///---------------------------------------------------------------------------------------------
    ///| set    |   1   |   1   | Set OC2B on Compare Match, clear OC2B at BOTTOM,                 |
    ///|        |       |       | (inverting mode).                                                |
    ///---------------------------------------------------------------------------------------------
    ///```
    /// Note: 1. A special case occurs when OCR2B equals TOP and COM2B1 is set. In this case, the Compare Match is
    ///       ignored, but the set or clear is done at BOTTOM. See ”Phase Correct PWM Mode” on page 157 for more
    ///       details.
    ///
    /// Table 18-7 shows the COM2B1:0 bit functionality when the WGM22:0 bits are set to phase correct PWM mode.
    ///
    /// Table 18-7. Compare Output Mode, Phase Correct PWM Mode
    ///```
    ///---------------------------------------------------------------------------------------------
    ///|  Mode  | COM2B1| COM2B0| Description                                                      |
    ///---------------------------------------------------------------------------------------------
    ///| normal |   0   |   0   | Normal port operation, OC2B disconnected.                        |
    ///---------------------------------------------------------------------------------------------
    ///| toggle |   0   |   1   | Reserved                                                         |
    ///---------------------------------------------------------------------------------------------
    ///| clear  |   1   |   0   | Clear OC2B on Compare Match when up-counting.                    |
    ///|        |       |       | Set OC2B on Compare Match when down-counting.                    |
    ///---------------------------------------------------------------------------------------------
    ///| set    |   1   |   1   | Set OC2B on Compare Match when up-counting.                      |
    ///|        |       |       | Clear OC2B on Compare Match when down-counting.                  |
    ///---------------------------------------------------------------------------------------------
    ///```
    /// Note: 1. A special case occurs when OCR2B equals TOP and COM2B1 is set. In this case, the Compare Match is
    ///       ignored, but the set or clear is done at TOP. See ”Phase Correct PWM Mode” on page 157 for more details.
    ///
    @inlinable
    @inline(__always)
    public static var compareOutputModeB: Timer.CompareOutputMode {
        get {
            let mode = (controlRegisterA & 0b00110000) >> UInt8(4)
            return Timer.CompareOutputMode.init(rawValue: mode) ?? .normal
        }
        set {
            controlRegisterA |= (newValue.rawValue & 0b00000011) << UInt8(4)
        }
    }
    /// WGM02 –  
    ///
    /// Combined with the WGM22 bit found in the TCCR2B Register, these bits control the counting sequence of the
    /// counter, the source for maximum (TOP) counter value, and what type of waveform generation to be used, see
    /// Table 18-8. Modes of operation supported by the Timer/Counter unit are: Normal mode (counter), Clear Timer
    /// on Compare Match (CTC) mode, and two types of Pulse Width Modulation (PWM) modes (see ”Modes of
    /// Operation” on page 155).
    ///
    /// Table 18-8. Waveform Generation Mode Bit Description
    ///```
    ///-----------------------------------------------------------------------------------------------------
    ///|  Mode  | WGM22 | WGM21 | WGM20 | Mode of Operation  |  TOP  | Update of OCRx at | TOV Flag Set on |
    ///-----------------------------------------------------------------------------------------------------
    ///|    0   |   0   |   0   |   0   | Normal             | 0xFF  | Immediate         | MAX             |
    ///-----------------------------------------------------------------------------------------------------
    ///|    1   |   0   |   0   |   1   | PWM, Phase Correct | 0xFF  | TOP               | BOTTOM          |
    ///-----------------------------------------------------------------------------------------------------
    ///|    2   |   0   |   1   |   0   | CTC                | OCRA  | Immediate         | MAX             |
    ///-----------------------------------------------------------------------------------------------------
    ///|    3   |   0   |   1   |   1   | Fast PWM           | 0xFF  | BOTTOM            | MAX             |
    ///-----------------------------------------------------------------------------------------------------
    ///|    4   |   1   |   0   |   0   | Reserved           |   -   |         -         |        -        |
    ///-----------------------------------------------------------------------------------------------------
    ///|    5   |   1   |   0   |   1   | PWM, Phase Correct | OCRA  | TOP               | BOTTOM          |
    ///-----------------------------------------------------------------------------------------------------
    ///|    6   |   1   |   1   |   0   | Reserved           |   -   |         -         |        -        |
    ///-----------------------------------------------------------------------------------------------------
    ///|    7   |   1   |   1   |   1   | Fast PWM           | OCRA  | BOTTOM            | TOP             |
    ///-----------------------------------------------------------------------------------------------------
    ///```
    /// Notes: 1. MAX= 0xFF
    ///      2. BOTTOM= 0x00
    ///
    @inlinable
    @inline(__always)
    public static var waveformGenerationMode: Timer8Bit.WaveformGenerationMode {
        get {
            let mode = ((controlRegisterB & 0b00001000) >> 1) | (controlRegisterA & 0b00000011)
            return Timer8Bit.WaveformGenerationMode(rawValue: mode) ?? .normal
        }
        set {
            controlRegisterA |= ((newValue.rawValue & 0b00000011) << UInt8(0))
            controlRegisterB |= ((newValue.rawValue & 0b00000100) << UInt8(1))
        }
    }
    /// TIMSK0 – Timer/Counter0 Interrupt Mask Register
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0x6E)       |   -   |   -   |   -   |   -   |   -   |OCIE0B |OCIE0A | TOIE0 |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    @inlinable
    @inline(__always)
    public static var interruptMaskRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x6E)
        }
        set {
            _volatileRegisterWriteUInt8(0x6E, newValue)
        }
    }
    /// OCIE0B – Timer/Counter0 Output Compare Match B Interrupt Enable 
    @inlinable
    @inline(__always)
    public static var outputCompareMatchBInterruptEnable: Bool {
        get {
            let flag = (interruptMaskRegister & 0b00000100) >> UInt8(2)
            return flag == 1
        }
        set {
            interruptMaskRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(2)
        }
    }
    /// OCIE0A – Timer/Counter0 Output Compare Match A Interrupt Enable 
    @inlinable
    @inline(__always)
    public static var outputCompareMatchAInterruptEnable: Bool {
        get {
            let flag = (interruptMaskRegister & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            interruptMaskRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(1)
        }
    }
    /// TOIE0 – Timer/Counter0 Overflow Interrupt Enable 
    @inlinable
    @inline(__always)
    public static var overflowInterruptEnable: Bool {
        get {
            let flag = (interruptMaskRegister & 0b00000001) >> UInt8(0)
            return flag == 1
        }
        set {
            interruptMaskRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(0)
        }
    }
    /// TIFR0 – Timer/Counter0 Interrupt Flag register
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0x35)       |   -   |   -   |   -   |   -   |   -   | OCF0B | OCF0A | TOV0  |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    @inlinable
    @inline(__always)
    public static var interruptFlagRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x35)
        }
        set {
            _volatileRegisterWriteUInt8(0x35, newValue)
        }
    }
    /// OCF0B – Timer/Counter0 Output Compare Flag 0B 
    @inlinable
    @inline(__always)
    public static var outputCompareFlagB: Bool {
        get {
            let flag = (interruptFlagRegister & 0b00000100) >> UInt8(2)
            return flag == 1
        }
        set {
            interruptFlagRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(2)
        }
    }
    /// OCF0A – Timer/Counter0 Output Compare Flag 0A 
    @inlinable
    @inline(__always)
    public static var outputCompareFlagA: Bool {
        get {
            let flag = (interruptFlagRegister & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            interruptFlagRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(1)
        }
    }
    /// TOV0 – Timer/Counter0 Overflow Flag 
    @inlinable
    @inline(__always)
    public static var overflowFlag: Bool {
        get {
            let flag = (interruptFlagRegister & 0b00000001) >> UInt8(0)
            return flag == 1
        }
        set {
            interruptFlagRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(0)
        }
    }
    /// GTCCR – General Timer/Counter Control Register
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0x43)       |  TSM  |   -   |   -   |   -   |   -   |   -   |   -   |PSRSYNC|
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |  R/W  |   R   |   R   |   R   |   R   |   R   |   R   |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    @inlinable
    @inline(__always)
    public static var generalControlRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x43)
        }
        set {
            _volatileRegisterWriteUInt8(0x43, newValue)
        }
    }
    /// TSM – Timer/Counter Synchronization Mode 
    ///
    /// Writing the TSM bit to one activates the Timer/Counter Synchronization mode. In this mode, the value that is
    /// written to the PSRASY and PSRSYNC bits is kept, hence keeping the corresponding prescaler reset signals
    /// asserted. This ensures that the corresponding Timer/Counters are halted and can be configured to the same
    /// value without the risk of one of them advancing during configuration. When the TSM bit is written to zero, the
    /// PSRASY and PSRSYNC bits are cleared by hardware, and the Timer/Counters start counting simultaneously.
    ///
    @inlinable
    @inline(__always)
    public static var timerSynchronizationMode: Timer.TimerSynchronizationMode {
        get {
            let mode = (generalControlRegister & 0b10000000) >> UInt8(7)
            return Timer.TimerSynchronizationMode.init(rawValue: mode) ?? .disabled
        }
        set {
            generalControlRegister |= (newValue.rawValue & 0b00000001) << UInt8(7)
        }
    }
    /// PSRSYNC – Prescaler Reset Timer/Counter1 and Timer/Counter0
    ///
    /// When this bit is one, Timer/Counter1 and Timer/Counter0 prescaler will be Reset. This bit is normally cleared
    /// immediately by hardware, except if the TSM bit is set. Note that Timer/Counter1 and Timer/Counter0 share the
    /// same prescaler and a reset of this prescaler will affect both timers.
    @inlinable
    @inline(__always)
    public static var prescalerResetSync: Bool {
        get {
            let flag = (generalControlRegister & 0b00000001) >> UInt8(0)
            return flag == 1
        }
        set {
            generalControlRegister |= (newValue ? 1 : 0) & 0b00000001 << UInt8(0)
        }
    }
}

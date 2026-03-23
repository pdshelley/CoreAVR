//===----------------------------------------------------------------------===//
//
// Timer1.swift
// CoreAVR
//
// Created by Swift AVR Generator on 03/23/2026.
// Copyright © 2026 Paul Shelley. All rights reserved.
//
//===----------------------------------------------------------------------===//


public typealias timer1 = Timer1

public struct Timer1: Timer16Bit {
    /// TIMSK1 – Timer/Counter Interrupt Mask Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x6F)       |   -   |   -   | ICIE1 |   -   |   -   |OCIE1B |OCIE1A | TOIE1 |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |   R   |  R/W  |   R   |   R   |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var interruptMaskRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x6F)
        }
        set {
            _volatileRegisterWriteUInt8(0x6F, newValue)
        }
    }

    /// ICIE1 - Timer/Counter1 Input Capture Interrupt Enable
    /// When this bit is written to one, and the I-flag in the Status Register is set (interrupts globally enabled), the
    /// Timer/Counter1 Input Capture interrupt is enabled. The corresponding Interrupt Vector is executed
    /// when the ICF1 Flag, located in TIFR1, is set.
    @inlinable
    @inline(__always)
    public static var inputCaptureInterruptEnable: Bool {
        get {
            let flag = (interruptMaskRegister & 0b00100000) >> UInt8(5)
            return flag == 1
        }
        set {
            interruptMaskRegister = (interruptMaskRegister & ~0b00100000) | (((newValue ? 1 : 0) & 0b00000001) << UInt8(5))
        }
    }

    /// OCIE1B - Timer/Counter1 Output CompareB Match Interrupt Enable
    @inlinable
    @inline(__always)
    public static var outputCompareMatchBInterruptEnable: Bool {
        get {
            let flag = (interruptMaskRegister & 0b00000100) >> UInt8(2)
            return flag == 1
        }
        set {
            interruptMaskRegister = (interruptMaskRegister & ~0b00000100) | (((newValue ? 1 : 0) & 0b00000001) << UInt8(2))
        }
    }

    /// OCIE1A - Timer/Counter1 Output CompareA Match Interrupt Enable
    @inlinable
    @inline(__always)
    public static var outputCompareMatchAInterruptEnable: Bool {
        get {
            let flag = (interruptMaskRegister & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            interruptMaskRegister = (interruptMaskRegister & ~0b00000010) | (((newValue ? 1 : 0) & 0b00000001) << UInt8(1))
        }
    }

    /// TOIE1 - Timer/Counter1 Overflow Interrupt Enable
    @inlinable
    @inline(__always)
    public static var overflowInterruptEnable: Bool {
        get {
            let flag = (interruptMaskRegister & 0b00000001) >> UInt8(0)
            return flag == 1
        }
        set {
            interruptMaskRegister = (interruptMaskRegister & ~0b00000001) | ((newValue ? 1 : 0) & 0b00000001)
        }
    }

    /// TIFR1 – Timer/Counter Interrupt Flag register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x36)       |   -   |   -   | ICF1  |   -   |   -   | OCF1B | OCF1A | TOV1  |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |   R   |   R   |  R/W  |   R   |   R   |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var interruptFlagRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x36)
        }
        set {
            _volatileRegisterWriteUInt8(0x36, newValue)
        }
    }

    /// ICF1 - Input Capture Flag 1
    /// This flag is set when a capture event occurs on the ICP1 pin. When the Input Capture Register (ICR1) is set by
    /// the WGM to be used as the TOP value, the ICF1 Flag is set when the counter reaches the TOP value.
    /// ICF1 is automatically cleared when the Input Capture Interrupt Vector is executed. Alternatively, ICF1 can be
    /// cleared by writing a logic one to its bit location.
    @inlinable
    @inline(__always)
    public static var inputCaptureFlag: Bool {
        get {
            let flag = (interruptFlagRegister & 0b00100000) >> UInt8(5)
            return flag == 1
        }
        set {
            interruptFlagRegister = (interruptFlagRegister & ~0b00100000) | (((newValue ? 1 : 0) & 0b00000001) << UInt8(5))
        }
    }

    /// OCF1B - Output Compare Flag 1B
    @inlinable
    @inline(__always)
    public static var outputCompareFlagB: Bool {
        get {
            let flag = (interruptFlagRegister & 0b00000100) >> UInt8(2)
            return flag == 1
        }
        set {
            interruptFlagRegister = (interruptFlagRegister & ~0b00000100) | (((newValue ? 1 : 0) & 0b00000001) << UInt8(2))
        }
    }

    /// OCF1A - Output Compare Flag 1A
    @inlinable
    @inline(__always)
    public static var outputCompareFlagA: Bool {
        get {
            let flag = (interruptFlagRegister & 0b00000010) >> UInt8(1)
            return flag == 1
        }
        set {
            interruptFlagRegister = (interruptFlagRegister & ~0b00000010) | (((newValue ? 1 : 0) & 0b00000001) << UInt8(1))
        }
    }

    /// TOV1 - Timer/Counter1 Overflow Flag
    @inlinable
    @inline(__always)
    public static var overflowFlag: Bool {
        get {
            let flag = (interruptFlagRegister & 0b00000001) >> UInt8(0)
            return flag == 1
        }
        set {
            interruptFlagRegister = (interruptFlagRegister & ~0b00000001) | ((newValue ? 1 : 0) & 0b00000001)
        }
    }

    /// TCCR1A – Timer/Counter1 Control Register A
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x80)       |COM1A1 |COM1A0 |COM1B1 |COM1B0 |   -   |   -   | WGM11 | WGM10 |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |   R   |   R   |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var controlRegisterA: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x80)
        }
        set {
            _volatileRegisterWriteUInt8(0x80, newValue)
        }
    }

    /// COM1A - Compare Output Mode 1A, bits
    /// These bits control the Output Compare pin (OC1A) behavior. If one or both of the COM1A1:0 bits are set, the
    /// OC1A output overrides the normal port functionality of the I/O pin it is connected to. However, note that the Data
    /// Direction Register (DDR) bit corresponding to the OC1A pin must be set in order to enable the output driver.
    /// When OC1A is connected to the pin, the function of the COM1A1:0 bits depends on the WGM13:0 bit setting.
    /// Table 1 shows the COM1A1:0 bit functionality when the WGM13:0 bits are set to a normal or CTC mode (non-PWM).
    ///
    /// Table 1. Compare Output Mode, non-PWM Mode
    /// ```
    /// ---------------------------------------------------------------------------------------------
    /// |  Mode  | COM1A1| COM1A0| Description                                                      |
    /// ---------------------------------------------------------------------------------------------
    /// | normal |   0   |   0   | Normal port operation, OC1A disconnected.                        |
    /// ---------------------------------------------------------------------------------------------
    /// | toggle |   0   |   1   | Toggle OC1A on Compare Match                                     |
    /// ---------------------------------------------------------------------------------------------
    /// | clear  |   1   |   0   | Clear OC1A on Compare Match                                      |
    /// ---------------------------------------------------------------------------------------------
    /// | set    |   1   |   1   | Set OC1A on Compare Match                                        |
    /// ---------------------------------------------------------------------------------------------
    /// ```
    ///
    /// Table 2 shows the COM1A1:0 bit functionality when the WGM13:0 bits are set to fast PWM mode.
    ///
    /// Table 2. Compare Output Mode, Fast PWM Mode
    /// ```
    /// ---------------------------------------------------------------------------------------------
    /// |  Mode  | COM1A1| COM1A0| Description                                                      |
    /// ---------------------------------------------------------------------------------------------
    /// | normal |   0   |   0   | Normal port operation, OC1A disconnected.                        |
    /// ---------------------------------------------------------------------------------------------
    /// | toggle |   0   |   1   | WGM13:0 = 15: Toggle OC1A on Compare Match.                      |
    /// |        |       |       | For all other WGM1 settings, normal port operation,               |
    /// |        |       |       | OC1A disconnected.                                               |
    /// ---------------------------------------------------------------------------------------------
    /// | clear  |   1   |   0   | Clear OC1A on Compare Match, set OC1A at BOTTOM,                 |
    /// |        |       |       | (non-inverting mode).                                            |
    /// ---------------------------------------------------------------------------------------------
    /// | set    |   1   |   1   | Set OC1A on Compare Match, clear OC1A at BOTTOM,                 |
    /// |        |       |       | (inverting mode).                                                |
    /// ---------------------------------------------------------------------------------------------
    /// ```
    /// Note: 1. A special case occurs when OCR1A equals TOP and COM1A1 is set. In this case, the Compare Match is
    ///       ignored, but the set or clear is done at BOTTOM. See "Fast PWM Mode" in datasheet for more details.
    ///
    /// Table 3 shows the COM1A1:0 bit functionality when the WGM13:0 bits are set to phase correct or phase and frequency correct PWM mode.
    ///
    /// Table 3. Compare Output Mode, Phase Correct and Phase and Frequency Correct PWM Mode
    /// ```
    /// ---------------------------------------------------------------------------------------------
    /// |  Mode  | COM1A1| COM1A0| Description                                                      |
    /// ---------------------------------------------------------------------------------------------
    /// | normal |   0   |   0   | Normal port operation, OC1A disconnected.                        |
    /// ---------------------------------------------------------------------------------------------
    /// | toggle |   0   |   1   | WGM13:0 = 9 or 11: Toggle OC1A on Compare Match.                 |
    /// |        |       |       | For all other WGM1 settings, normal port operation,               |
    /// |        |       |       | OC1A disconnected.                                               |
    /// ---------------------------------------------------------------------------------------------
    /// | clear  |   1   |   0   | Clear OC1A on Compare Match when up-counting.                    |
    /// |        |       |       | Set OC1A on Compare Match when down-counting.                    |
    /// ---------------------------------------------------------------------------------------------
    /// | set    |   1   |   1   | Set OC1A on Compare Match when up-counting.                      |
    /// |        |       |       | Clear OC1A on Compare Match when down-counting.                  |
    /// ---------------------------------------------------------------------------------------------
    /// ```
    /// Note: 1. A special case occurs when OCR1A equals TOP and COM1A1 is set. In this case, the Compare Match is
    ///       ignored, but the set or clear is done at TOP. See "Phase Correct PWM Mode" in datasheet for more details.
    @inlinable
    @inline(__always)
    public static var compareOutputModeA: Timer.CompareOutputMode {
        get {
            let mode = (controlRegisterA & 0b11000000) >> UInt8(6)
            return Timer.CompareOutputMode.init(rawValue: mode) ?? .normal
        }
        set {
            controlRegisterA = (controlRegisterA & ~0b11000000) | ((newValue.rawValue & 0b00000011) << UInt8(6))
        }
    }

    /// COM1B - Compare Output Mode 1B, bits
    /// See ATMega328p Datasheet Table 18-5, Table 18-6, and Table 18-7.
    /// These bits control the Output Compare pin (OC1B) behavior. If one or both of the COM1B1:0 bits are set, the
    /// OC1B output overrides the normal port functionality of the I/O pin it is connected to. However, note that the Data
    /// Direction Register (DDR) bit corresponding to the OC1B pin must be set in order to enable the output driver.
    /// When OC1B is connected to the pin, the function of the COM1B1:0 bits depends on the WGM13:0 bit setting.
    /// Table 18-5 shows the COM2B1:0 bit functionality when the WGM22:0 bits are set to a normal or CTC mode(non-PWM).
    ///
    /// Table 1. Compare Output Mode, non-PWM Mode
    /// ```
    /// ---------------------------------------------------------------------------------------------
    /// |  Mode  | COM1B1| COM1B0| Description                                                      |
    /// ---------------------------------------------------------------------------------------------
    /// | normal |   0   |   0   | Normal port operation, OC1B disconnected.                        |
    /// ---------------------------------------------------------------------------------------------
    /// | toggle |   0   |   1   | Toggle OC1B on Compare Match                                     |
    /// ---------------------------------------------------------------------------------------------
    /// | clear  |   1   |   0   | Clear OC1B on Compare Match                                      |
    /// ---------------------------------------------------------------------------------------------
    /// | set    |   1   |   1   | Set OC1B on Compare Match                                        |
    /// ---------------------------------------------------------------------------------------------
    /// ```
    ///
    /// Table 18-6 shows the COM2B1:0 bit functionality when the WGM22:0 bits are set to fast PWM mode.
    /// Table 18-6. Compare Output Mode, Fast PWM Mode
    /// ```
    /// ---------------------------------------------------------------------------------------------
    /// |  Mode  | COM1B1| COM1B0| Description                                                      |
    /// ---------------------------------------------------------------------------------------------
    /// | normal |   0   |   0   | Normal port operation, OC1B disconnected.                        |
    /// ---------------------------------------------------------------------------------------------
    /// | toggle |   0   |   1   | Reserved                                                         |
    /// ---------------------------------------------------------------------------------------------
    /// | clear  |   1   |   0   | Clear OC1B on Compare Match, set OC1B at BOTTOM,                 |
    /// |        |       |       | (non-inverting mode).                                            |
    /// ---------------------------------------------------------------------------------------------
    /// | set    |   1   |   1   | Set OC1B on Compare Match, clear OC1B at BOTTOM,                 |
    /// |        |       |       | (inverting mode).                                                |
    /// ---------------------------------------------------------------------------------------------
    /// ```
    /// Note: 1. A special case occurs when OCR1B equals TOP and COM1B1 is set. In this case, the Compare Match is
    ///       ignored, but the set or clear is done at BOTTOM. See "Phase Correct PWM Mode" in datasheet for more details.
    ///
    /// Table 18-7 shows the COM2B1:0 bit functionality when the WGM22:0 bits are set to phase correct PWM mode.
    /// Table 18-7. Compare Output Mode, Phase Correct PWM Mode
    /// ```
    /// ---------------------------------------------------------------------------------------------
    /// |  Mode  | COM1B1| COM1B0| Description                                                      |
    /// ---------------------------------------------------------------------------------------------
    /// | normal |   0   |   0   | Normal port operation, OC1B disconnected.                        |
    /// ---------------------------------------------------------------------------------------------
    /// | toggle |   0   |   1   | Reserved                                                         |
    /// ---------------------------------------------------------------------------------------------
    /// | clear  |   1   |   0   | Clear OC1B on Compare Match when up-counting.                    |
    /// |        |       |       | Set OC1B on Compare Match when down-counting.                    |
    /// ---------------------------------------------------------------------------------------------
    /// | set    |   1   |   1   | Set OC1B on Compare Match when up-counting.                      |
    /// |        |       |       | Clear OC1B on Compare Match when down-counting.                  |
    /// ---------------------------------------------------------------------------------------------
    /// ```
    /// Note: 1. A special case occurs when OCR1B equals TOP and COM1B1 is set. In this case, the Compare Match is
    ///       ignored, but the set or clear is done at TOP. See "Phase Correct PWM Mode" on page 157 for more details.
    @inlinable
    @inline(__always)
    public static var compareOutputModeB: Timer.CompareOutputMode {
        get {
            let mode = (controlRegisterA & 0b00110000) >> UInt8(4)
            return Timer.CompareOutputMode.init(rawValue: mode) ?? .normal
        }
        set {
            controlRegisterA = (controlRegisterA & ~0b00110000) | ((newValue.rawValue & 0b00000011) << UInt8(4))
        }
    }

    /// TCCR1B – Timer/Counter1 Control Register B
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x81)       | ICNC1 | ICES1 |   -   | WGM11 | WGM10 | CS12  | CS11  | CS10  |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |   R   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var controlRegisterB: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x81)
        }
        set {
            _volatileRegisterWriteUInt8(0x81, newValue)
        }
    }

    /// ICNC1 - Input Capture 1 Noise Canceler
    /// Setting this bit (to true) activates the Input Capture Noise Canceler. When the noise canceler is activated, the
    /// input from the Input Capture pin (ICP1) is filtered. The filter function requires four successive equal valued
    /// samples of the ICP1 pin for changing its output. The Input Capture is therefore delayed by four Oscillator cycles
    /// when the noise canceler is enabled.
    @inlinable
    @inline(__always)
    public static var inputCaptureNoiseCanceler: Bool {
        get {
            let flag = (controlRegisterB & 0b10000000) >> UInt8(7)
            return flag == 1
        }
        set {
            controlRegisterB = (controlRegisterB & ~0b10000000) | (((newValue ? 1 : 0) & 0b00000001) << UInt8(7))
        }
    }

    /// ICES1 - Input Capture 1 Edge Select
    /// This bit selects which edge on the Input Capture pin (ICP1) that is used to trigger a capture event. When the
    /// ICES1 bit is written to zero, a falling (negative) edge is used as trigger, and when the ICES1 bit is written to one,
    /// a rising (positive) edge will trigger the capture.
    /// When a capture is triggered according to the ICES1 setting, the counter value is copied into the Input Capture
    /// Register (ICR1). The event will also set the Input Capture Flag (ICF1), and this can be used to cause an Input
    /// Capture Interrupt, if this interrupt is enabled.
    /// When the ICR1 is used as TOP value (see description of the WGM bits located in the TCCR1A and the
    /// TCCR1B Register), the ICP1 is disconnected and consequently the Input Capture function is disabled.
    @inlinable
    @inline(__always)
    public static var inputCaptureEdgeSelect: Bool {
        get {
            let flag = (controlRegisterB & 0b01000000) >> UInt8(6)
            return flag == 1
        }
        set {
            controlRegisterB = (controlRegisterB & ~0b01000000) | (((newValue ? 1 : 0) & 0b00000001) << UInt8(6))
        }
    }

    /// WGM1 - Waveform Generation Mode
    /// Combined with the WGM13:2 bits found in the TCCR1B Register, these bits control the counting sequence of the
    /// counter, the source for maximum (TOP) counter value, and what type of waveform generation to be used.
    /// Table 18-8. Modes of operation supported by the Timer/Counter unit are: Normal mode (counter), Clear Timer
    /// on Compare Match (CTC) mode, and two types of Pulse Width Modulation (PWM) modes (see ”Modes of
    /// Operation” on page 155).
    ///
    /// Table 18-8. Waveform Generation Mode Bit Description
    /// ```
    /// --------------------------------------------------------------------------------------------------------------
    /// |  Mode  | WGM13 | WGM12 | WGM11 | WGM10 | Mode of Operation          |  TOP   | Update of OCR1x | TOV1 Flag |
    /// |        |       | (CTC1)|       |       |                            |        |      at         |  Set on   |
    /// --------------------------------------------------------------------------------------------------------------
    /// |    0   |   0   |   0   |   0   |   0   | Normal                     | 0xFFFF | Immediate       | MAX       |
    /// --------------------------------------------------------------------------------------------------------------
    /// |    1   |   0   |   0   |   0   |   1   | PWM, Phase Correct, 8-bit  | 0x00FF | TOP             | BOTTOM    |
    /// --------------------------------------------------------------------------------------------------------------
    /// |    2   |   0   |   0   |   1   |   0   | PWM, Phase Correct, 9-bit  | 0x01FF | TOP             | BOTTOM    |
    /// --------------------------------------------------------------------------------------------------------------
    /// |    3   |   0   |   0   |   1   |   1   | PWM, Phase Correct, 10-bit | 0x03FF | TOP             | BOTTOM    |
    /// --------------------------------------------------------------------------------------------------------------
    /// |    4   |   0   |   1   |   0   |   0   | CTC                        | OCR1A  | Immediate       | MAX       |
    /// --------------------------------------------------------------------------------------------------------------
    /// |    5   |   0   |   1   |   0   |   1   | Fast PWM, 8-bit            | 0x00FF | BOTTOM          | TOP       |
    /// --------------------------------------------------------------------------------------------------------------
    /// |    6   |   0   |   1   |   1   |   0   | Fast PWM, 9-bit            | 0x01FF | BOTTOM          | TOP       |
    /// --------------------------------------------------------------------------------------------------------------
    /// |    7   |   0   |   1   |   1   |   1   | Fast PWM, 10-bit           | 0x03FF | BOTTOM          | TOP       |
    /// --------------------------------------------------------------------------------------------------------------
    /// |    8   |   1   |   0   |   0   |   0   | PWM, Phase+Freq Correct    | ICR1   | BOTTOM          | BOTTOM    |
    /// --------------------------------------------------------------------------------------------------------------
    /// |    9   |   1   |   0   |   0   |   1   | PWM, Phase+Freq Correct    | OCR1A  | BOTTOM          | BOTTOM    |
    /// --------------------------------------------------------------------------------------------------------------
    /// |   10   |   1   |   0   |   1   |   0   | PWM, Phase Correct         | ICR1   | TOP             | BOTTOM    |
    /// --------------------------------------------------------------------------------------------------------------
    /// |   11   |   1   |   0   |   1   |   1   | PWM, Phase Correct         | OCR1A  | TOP             | BOTTOM    |
    /// --------------------------------------------------------------------------------------------------------------
    /// |   12   |   1   |   1   |   0   |   0   | CTC                        | ICR1   | Immediate       | MAX       |
    /// --------------------------------------------------------------------------------------------------------------
    /// |   13   |   1   |   1   |   0   |   1   | Reserved                   |   -    |        -        |     -     |
    /// --------------------------------------------------------------------------------------------------------------
    /// |   14   |   1   |   1   |   1   |   0   | Fast PWM                   | ICR1   | BOTTOM          | TOP       |
    /// --------------------------------------------------------------------------------------------------------------
    /// |   15   |   1   |   1   |   1   |   1   | Fast PWM                   | OCR1A  | BOTTOM          | TOP       |
    /// --------------------------------------------------------------------------------------------------------------
    /// ```
    /// Notes: 1. MAX = 0xFFFF
    ///        2. BOTTOM = 0x0000
    @inlinable
    @inline(__always)
    public static var waveformGenerationMode: Timer16Bit.WaveformGenerationMode {
        get {
            let mode = ((controlRegisterB & 0b00011000) >> UInt8(1)) | (controlRegisterA & 0b00000011)
            return Timer16Bit.WaveformGenerationMode(rawValue: mode) ?? .normal
        }
        set {
            controlRegisterA = (controlRegisterA & ~0b00000011) | (newValue.rawValue & 0b00000011)
            controlRegisterB = (controlRegisterB & ~0b00011000) | ((newValue.rawValue & 0b00001100) << UInt8(1))
        }
    }
    /// ```
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |  Mode  | CS12  | CS11  | CS10  | Description                                                     |
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

    /// CS1 - Prescaler source of Timer/Counter 1
    @inlinable
    @inline(__always)
    public static var prescaler: Prescaling {
        get {
            let mode = (controlRegisterB & 0b00000111) >> UInt8(0)
            return Prescaling.init(rawValue: mode) ?? .stopped
        }
        set {
            controlRegisterB = (controlRegisterB & ~0b00000111) | (newValue.rawValue & 0b00000111)
        }
    }

    /// TCCR1C – Timer/Counter1 Control Register C
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x82)       | FOC1A | FOC1B |   -   |   -   |   -   |   -   |   -   |   -   |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |  R/W  |   R   |   R   |   R   |   R   |   R   |   R   |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var controlRegisterC: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x82)
        }
        set {
            _volatileRegisterWriteUInt8(0x82, newValue)
        }
    }

    /// FOC1A -
    /// The FOC1A bit is only active when the WGM bits specify a non-PWM mode.
    /// However, for ensuring compatibility with future devices, this bit must be set to zero when TCCR1B is written
    /// when operating in PWM mode. When writing a logical one to the FOC1A bit, an immediate Compare Match is
    /// forced on the Waveform Generation unit. The OC1A output is changed according to its COM1A bits setting.
    /// Note that the FOC1A bit is implemented as a strobe. Therefore it is the value present in the COM1A bits that
    /// determines the effect of the forced compare.
    /// A FOC1A strobe will not generate any interrupt, nor will it clear the timer in CTC mode using OCR1A as TOP.
    /// The FOC1A bit is always read as zero.
    @inlinable
    @inline(__always)
    public static var forceOutputCompareA: Bool {
        get {
            let flag = (controlRegisterC & 0b10000000) >> UInt8(7)
            return flag == 1
        }
        set {
            controlRegisterC = (controlRegisterC & ~0b10000000) | (((newValue ? 1 : 0) & 0b00000001) << UInt8(7))
        }
    }

    /// FOC1B -
    /// The FOC1B bit is only active when the WGM bits specify a non-PWM mode.
    /// However, for ensuring compatibility with future devices, this bit must be set to zero when TCCR1B is written
    /// when operating in PWM mode. When writing a logical one to the FOC1B bit, an immediate Compare Match is
    /// forced on the Waveform Generation unit. The OC1B output is changed according to its COM1B bits setting.
    /// Note that the FOC1B bit is implemented as a strobe. Therefore it is the value present in the COM1B bits that
    /// determines the effect of the forced compare.
    /// A FOC1B strobe will not generate any interrupt, nor will it clear the timer in CTC mode using OCR1B as TOP.
    /// The FOC1B bit is always read as zero.
    @inlinable
    @inline(__always)
    public static var forceOutputCompareB: Bool {
        get {
            let flag = (controlRegisterC & 0b01000000) >> UInt8(6)
            return flag == 1
        }
        set {
            controlRegisterC = (controlRegisterC & ~0b01000000) | (((newValue ? 1 : 0) & 0b00000001) << UInt8(6))
        }
    }

    /// TCNT1 – Timer/Counter1  Bytes
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x84)       |                             TCNT1                             |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |                              R/W                              |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var countL: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x84)
        }
        set {
            _volatileRegisterWriteUInt8(0x84, newValue)
        }
    }

    /// TCNT1 – Timer/Counter1  Bytes
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x85)       |                             TCNT1                             |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |                              R/W                              |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var countH: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x85)
        }
        set {
            _volatileRegisterWriteUInt8(0x85, newValue)
        }
    }

    /// TCNT1 – Timer/Counter1  Bytes
    @inlinable
    @inline(__always)
    public static var count: UInt16 {
        get {
            atomic {
                _volatileRegisterReadUInt16(0x84)
            }
        }
        set {
            atomic {
                _volatileRegisterWriteUInt16(0x84, newValue)
            }
        }
    }

    /// OCR1A – Timer/Counter1 Output Compare Register  Bytes
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x88)       |                             OCR1A                             |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |                              R/W                              |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var outputCompareRegisterAL: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x88)
        }
        set {
            _volatileRegisterWriteUInt8(0x88, newValue)
        }
    }

    /// OCR1A – Timer/Counter1 Output Compare Register  Bytes
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x89)       |                             OCR1A                             |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |                              R/W                              |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var outputCompareRegisterAH: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x89)
        }
        set {
            _volatileRegisterWriteUInt8(0x89, newValue)
        }
    }

    /// OCR1A – Timer/Counter1 Output Compare Register  Bytes
    @inlinable
    @inline(__always)
    public static var outputCompareRegisterA: UInt16 {
        get {
            atomic {
                _volatileRegisterReadUInt16(0x88)
            }
        }
        set {
            atomic {
                _volatileRegisterWriteUInt16(0x88, newValue)
            }
        }
    }

    /// OCR1B – Timer/Counter1 Output Compare Register  Bytes
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x8A)       |                             OCR1B                             |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |                              R/W                              |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var outputCompareRegisterBL: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x8A)
        }
        set {
            _volatileRegisterWriteUInt8(0x8A, newValue)
        }
    }

    /// OCR1B – Timer/Counter1 Output Compare Register  Bytes
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x8B)       |                             OCR1B                             |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |                              R/W                              |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var outputCompareRegisterBH: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x8B)
        }
        set {
            _volatileRegisterWriteUInt8(0x8B, newValue)
        }
    }

    /// OCR1B – Timer/Counter1 Output Compare Register  Bytes
    @inlinable
    @inline(__always)
    public static var outputCompareRegisterB: UInt16 {
        get {
            atomic {
                _volatileRegisterReadUInt16(0x8A)
            }
        }
        set {
            atomic {
                _volatileRegisterWriteUInt16(0x8A, newValue)
            }
        }
    }

    /// ICR1 – Timer/Counter1 Input Capture Register  Bytes
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x86)       |                             ICR1                              |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |                              R/W                              |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var inputCaptureRegisterL: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x86)
        }
        set {
            _volatileRegisterWriteUInt8(0x86, newValue)
        }
    }

    /// ICR1 – Timer/Counter1 Input Capture Register  Bytes
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x87)       |                             ICR1                              |
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |                              R/W                              |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
    @inlinable
    @inline(__always)
    public static var inputCaptureRegisterH: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x87)
        }
        set {
            _volatileRegisterWriteUInt8(0x87, newValue)
        }
    }

    /// ICR1 – Timer/Counter1 Input Capture Register  Bytes
    @inlinable
    @inline(__always)
    public static var inputCaptureRegister: UInt16 {
        get {
            atomic {
                _volatileRegisterReadUInt16(0x86)
            }
        }
        set {
            atomic {
                _volatileRegisterWriteUInt16(0x86, newValue)
            }
        }
    }

    /// GTCCR – General Timer/Counter Control Register
    /// ```
    /// --------------------------------------------------------------------------------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// --------------------------------------------------------------------------------
    /// | (0x43)       |  TSM  |   -   |   -   |   -   |   -   |   -   |   -   |PSRSYNC|
    /// --------------------------------------------------------------------------------
    /// | Read/Write   |  R/W  |   R   |   R   |   R   |   R   |   R   |   R   |  R/W  |
    /// --------------------------------------------------------------------------------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// --------------------------------------------------------------------------------
    /// ```
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

    /// TSM - Timer/Counter Synchronization Mode
    /// Writing the TSM bit to one activates the Timer/Counter Synchronization mode. In this mode, the value that is
    /// written to the PSRASY and PSRSYNC bits is kept, hence keeping the corresponding prescaler reset signals
    /// asserted. This ensures that the corresponding Timer/Counters are halted and can be configured to the same
    /// value without the risk of one of them advancing during configuration. When the TSM bit is written to zero, the
    /// PSRASY and PSRSYNC bits are cleared by hardware, and the Timer/Counters start counting simultaneously.
    @inlinable
    @inline(__always)
    public static var timerSynchronizationMode: Timer.TimerSynchronizationMode {
        get {
            let mode = (generalControlRegister & 0b10000000) >> UInt8(7)
            return Timer.TimerSynchronizationMode.init(rawValue: mode) ?? .disabled
        }
        set {
            generalControlRegister = (generalControlRegister & ~0b10000000) | ((newValue.rawValue & 0b00000001) << UInt8(7))
        }
    }

    /// PSRSYNC - Prescaler Reset Timer/Counter1 and Timer/Counter0
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
            generalControlRegister = (generalControlRegister & ~0b00000001) | ((newValue ? 1 : 0) & 0b00000001)
        }
    }
}
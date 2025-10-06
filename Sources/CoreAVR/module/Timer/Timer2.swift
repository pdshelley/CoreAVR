//===----------------------------------------------------------------------===//
//
// Timer1.swift
// Swift For Arduino
//
// Created by Paul Shelley on 08/29/2023.
// Copyright © 2022 Paul Shelley. All rights reserved.
//
//===----------------------------------------------------------------------===//


typealias timer2 = Timer2

/// Timer 2 implementation for ATmega48A/PA/88A/PA/168A/PA/328/P
// NOTE: PRTIM2 needs to be written to zero to enable Timer/Counter2 module. See Datasheet section 18.2
struct Timer2: Timer8Bit, InternalClockOnly, AsyncTimer {
    
    /// 18.11.1 TCCR2A – Timer/Counter Control Register A
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0xB0)       |COM2A1 |COM2A0 |COM2B1 |COM2B0 |   -   |   -   | WGM21 | WGM20 |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |   R   |   R   |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    @inlinable
    @inline(__always)
    static var timerCounterControlRegisterA: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xB0)
        }
        set {
            _volatileRegisterWriteUInt8(0xB0, newValue)
        }
    }
    
    
    /// 18.11.2 TCCR2B – Timer/Counter Control Register B
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0xB1)       | FOC2A | FOC2B |   -   |   -   | WGM22 | CS22  | CS21  | CS20  |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |  R/W  |  R/W  |   R   |   R   |  R/W  |  R/W  |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    @inlinable
    @inline(__always)
    static var timerCounterControlRegisterB: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xB1)
        }
        set {
            _volatileRegisterWriteUInt8(0xB1, newValue)
        }
    }
    
    
    /// 18.11.3 TCNT2 – Timer/Counter Register
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0xB2)       |                         TCNT2                                 |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    // WARNING: This is not fully tested and understood.
    // TODO: Figure out what the TCNT2 is used for. I think this is just the actual timer counter that is incrimented each tick of the timer.
    @inlinable
    @inline(__always)
    static var timerCounterNumber: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xB2)
        }
        set {
            _volatileRegisterWriteUInt8(0xB2, newValue)
        }
    }
    
    
    /// 18.11.4 OCR2A – Output Compare Register A
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0xB3)       |                         OCR2A                                 |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    // TODO: I believe OCR2A always needs to be larger than OCR2B. Should we have a safety for this?
    @inlinable
    @inline(__always)
    static var outputCompareRegisterA: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xB3)
        }
        set {
            _volatileRegisterWriteUInt8(0xB3, newValue)
        }
    }
    
    
    /// 18.11.5 OCR2B – Output Compare Register B
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0xB4)       |                         OCR2B                                 |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    // TODO: I believe OCR2A always needs to be larger than OCR2B. Should we have a safety for this?
    @inlinable
    @inline(__always)
    static var outputCompareRegisterB: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xB4)
        }
        set {
            _volatileRegisterWriteUInt8(0xB4, newValue)
        }
    }
    
    
    /// 18.11.6 TIMSK2 – Timer/Counter2 Interrupt Mask Register
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0x70)       |   -   |   -   |   -   |   -   |   -   |OCIE2B |OCIE2A | TOIE2 |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    // WARNING: This is not fully tested and understood.
    // TODO: Figure out what the TIMSK2 (Timer Interrupt Mask Register) is used for.
    @inlinable
    @inline(__always)
    static var timerInterruptMaskRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x70)
        }
        set {
            _volatileRegisterWriteUInt8(0x70, newValue)
        }
    }
    
    
    /// 18.11.7 TIFR2 – Timer/Counter2 Interrupt Flag Register
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0x37)       |   -   |   -   |   -   |   -   |   -   | OCF2B | OCF2A | TOV2  |
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    // WARNING: This is not fully tested and understood.
    // TODO: Figure out what the TIFR2 (Timer Interrupt Flag Register) is used for.
    @inlinable
    @inline(__always)
    static var timerInterruptFlagRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x37)
        }
        set {
            _volatileRegisterWriteUInt8(0x37, newValue)
        }
    }
    
    
    /// 18.11.8 ASSR – Asynchronous Status Register
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0xB6)       |   -   | EXCLK |  AS2  |TCN2UB |OCR2AUB|OCR2BUB|TCR2AUB|TCR2BUB|
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |   R   |  R/W  |  R/W  |   R   |   R   |   R   |   R   |   R   |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    // WARNING: This is not fully tested and understood.
    // TODO: Figure out what the ASSR (Asynchronous Status Register) is used for.
    @inlinable
    @inline(__always)
    static var asynchronousStatusRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0xB6)
        }
        set {
            _volatileRegisterWriteUInt8(0xB6, newValue)
        }
    }
    
    
    /// 18.11.9 GTCCR – General Timer/Counter Control Register
    ///```
    ///--------------------------------------------------------------------------------
    ///| Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    ///--------------------------------------------------------------------------------
    ///| (0x43)       |  TSM  |   -   |   -   |   -   |   -   |   -   |PSRASY |PSRSYNC|
    ///--------------------------------------------------------------------------------
    ///| Read/Write   |  R/W  |   R   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |
    ///--------------------------------------------------------------------------------
    ///| InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    ///--------------------------------------------------------------------------------
    ///```
    // WARNING: This is not fully tested and understood.
    // TODO: Figure out what the GTCCR (General Timer/Counter Control Register) is used for.
    @inlinable
    @inline(__always)
    static var generalTimerCounterControlRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x43)
        }
        set {
            _volatileRegisterWriteUInt8(0x43, newValue)
        }
    }
    
    // TODO: Figure out what FOC2A and FOC2B are for.
    
    /// Bit 7 of TCCR2B – FOC2A: Force Output Compare A
    /// The FOC2A bit is only active when the WGM bits specify a non-PWM mode.
    /// However, for ensuring compatibility with future devices, this bit must be set to zero when TCCR2B is written
    /// when operating in PWM mode. When writing a logical one to the FOC2A bit, an immediate Compare Match is
    /// forced on the Waveform Generation unit. The OC2A output is changed according to its COM2A1:0 bits setting.
    /// Note that the FOC2A bit is implemented as a strobe. Therefore it is the value present in the COM2A1:0 bits that
    /// determines the effect of the forced compare.
    /// A FOC2A strobe will not generate any interrupt, nor will it clear the timer in CTC mode using OCR2A as TOP.
    /// The FOC2A bit is always read as zero.
    
    /// Bit 6 – FOC2B: Force Output Compare B
    /// The FOC2B bit is only active when the WGM bits specify a non-PWM mode.
    /// However, for ensuring compatibility with future devices, this bit must be set to zero when TCCR2B is written
    /// when operating in PWM mode. When writing a logical one to the FOC2B bit, an immediate Compare Match is
    /// forced on the Waveform Generation unit. The OC2B output is changed according to its COM2B1:0 bits setting.
    /// Note that the FOC2B bit is implemented as a strobe. Therefore it is the value present in the COM2B1:0 bits that
    /// determines the effect of the forced compare.
    /// A FOC2B strobe will not generate any interrupt, nor will it clear the timer in CTC mode using OCR2B as TOP.
    /// The FOC2B bit is always read as zero.
    
    
    // NOTE: There are many uses for PWM, some as simple as holding the same pulse width and only changing periodically for hobby servo control or LED brightness,
    // while more advanced uses can use the timer interupt to dynamically change the pulse width to output complex wave forms.
    
    
    /// Bits 7:6 – COM2A1:0: Compare Match Output A Mode
    /// See ATMega328p Datasheet Table 18-2, Table 18-3, and Table 18-4.
    ///
    /// These bits control the Output Compare pin (OC2A) behavior. If one or both of the COM2A1:0 bits are set, the
    /// OC2A output overrides the normal port functionality of the I/O pin it is connected to. However, note that the Data
    /// Direction Register (DDR) bit corresponding to the OC2A pin must be set in order to enable the output driver.
    /// When OC2A is connected to the pin, the function of the COM2A1:0 bits depends on the WGM22:0 bit setting.
    /// Table 18-2 shows the COM2A1:0 bit functionality when the WGM22:0 bits are set to a normal or CTC mode
    /// (non-PWM).
    ///
    /// Table 18-2. Compare Output Mode, non-PWM Mode
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
    /// Table 18-3 shows the COM2A1:0 bit functionality when the WGM21:0 bits are set to fast PWM mode.
    ///
    /// Table 18-3. Compare Output Mode, Fast PWM Mode
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
    ///       ignored, but the set or clear is done at BOTTOM. See ”Fast PWM Mode” on page 156 for more details.
    ///
    /// Table 18-4 shows the COM2A1:0 bit functionality when the WGM22:0 bits are set to phase correct PWM mode.
    ///
    /// Table 18-4. Compare Output Mode, Phase Correct PWM Mode
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
    ///       ignored, but the set or clear is done at TOP. See ”Phase Correct PWM Mode” on page 157 for more details.
    ///
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
    
    
    /// Bits 5:4 – COM2B1:0: Compare Match Output B Mode
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
    // TODO: Test This!
    // TODO: Add check for toggle?
    @inlinable
    @inline(__always)
    static var CompareOutputModeB: Timer.CompareOutputMode {
        get {
            let mode = (timerCounterControlRegisterB & 0b00110000) >> 4
            return Timer.CompareOutputMode.init(rawValue: mode) ?? .normal
        }
        set {
            timerCounterControlRegisterB |= (newValue.rawValue & 0b00000011) << UInt8(4)
        }
    }
    
    
    /// Bits 2 through 0 on TCCR2B – CS22:0: Clock Select
    /// The three Clock Select bits select the clock source to be used by the Timer/Counter, see Table 18-9 on page 165.
    ///
    /// Table 18-9. Clock Select Bit Description
    ///```
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |  Mode  | CS22  | CS21  | CS20  | Description                                                     |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    0   |   0   |   0   |   0   | No clock source (Timer/Counter stopped)                         |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    1   |   0   |   0   |   1   | clk T2S/(No prescaling)                                         |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    2   |   0   |   1   |   0   | clk T2S/8 (From prescaler)                                      |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    3   |   0   |   1   |   1   | clk T2S/32 (From prescaler)                                     |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    4   |   1   |   0   |   0   | clkI T2S/64 (From prescaler)                                    |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    5   |   1   |   0   |   1   | clkI T2S/128 (From prescaler)                                   |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    6   |   1   |   1   |   0   | clkI T2S/256 (From prescaler)                                   |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// |    7   |   1   |   1   |   1   | clkI T2S/1024 (From prescaler)                                  |
    /// |--------|-------|-------|-------|-----------------------------------------------------------------|
    /// ```
    /// If external pin modes are used for the Timer/Counter0, transitions on the T0 pin will clock the counter even if the
    /// pin is configured as an output. This feature allows software control of the counting.
    @inlinable
    @inline(__always)
    static var prescaler: InternalClockOnlyPrescaling { // Note: In the datasheet this is called the Clock Select. Prescaler is probably more descriptive.
        get {
            let mode = timerCounterControlRegisterB & 0b00000111
            return InternalClockOnlyPrescaling.init(rawValue: mode) ?? .noClockSource
        }
        set {
            timerCounterControlRegisterB |= newValue.rawValue & 0b00000111
        }
    }
    
    
    /// Bit 7 on GTCCR – TSM: Timer/Counter Synchronization Mode
    ///
    /// Writing the TSM bit to one activates the Timer/Counter Synchronization mode. In this mode, the value that is
    /// written to the PSRASY and PSRSYNC bits is kept, hence keeping the corresponding prescaler reset signals
    /// asserted. This ensures that the corresponding Timer/Counters are halted and can be configured to the same
    /// value without the risk of one of them advancing during configuration. When the TSM bit is written to zero, the
    /// PSRASY and PSRSYNC bits are cleared by hardware, and the Timer/Counters start counting simultaneously.
    ///
    // TODO: Test This!
    @inlinable
    @inline(__always)
    static var timerSynchronizationMode: Timer.TimerSynchronizationMode {
        get {
            let mode = (generalTimerCounterControlRegister & 0b10000000) >> 7
            return Timer.TimerSynchronizationMode.init(rawValue: mode) ?? .disabled
        }
        set {
            generalTimerCounterControlRegister |= (newValue.rawValue & 0b10000000) << UInt8(7)
        }
    }
    
    // TODO: Breakout the PSRASY and PSRSYNC bits on GTCCR (0x43).
    
    
    /// See ATMega328p Datasheet Table 18-8.
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
    static var waveformGenerationMode: Timer8Bit.WaveformGenerationMode {
        get {
            let mode = ((timerCounterControlRegisterB & 0b00001000) >> 1) | (timerCounterControlRegisterA & 0b00000011)
            return Timer8Bit.WaveformGenerationMode(rawValue: mode) ?? .normal
        }
        set {
            timerCounterControlRegisterA |= (newValue.rawValue & 0b00000011)
            timerCounterControlRegisterB |= ((newValue.rawValue & 0b00000100) << UInt8(1))
        }
    }
}

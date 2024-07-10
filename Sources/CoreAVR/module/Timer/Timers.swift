//===----------------------------------------------------------------------===//
//
// Timers.swift
// Swift For Arduino
//
// Created by Paul Shelley on 08/29/2023.
// Copyright © 2022 Paul Shelley. All rights reserved.
//
//===----------------------------------------------------------------------===//

// This auto compleets very nicely as you get `timer.0` for timer0.
//let timer: (Timer0, Timer1, Timer2) = (timer0, timer1, timer2)

// This is a nice way to get a list of all timers that have a given set of features but the .0 .1 ... will not corrispond to timer0 or timer1.
// There could be a collision if you wanted to get a timers that was 16 bit, then wanted a second timer that has an external clock, you would need to be more aware that the ATmega328p can do this with timer 1 and timer 0 respectivly.
// It would be nice to be able to have a list that was sorted from what timers were left avalible without doing runtime checks and allowing compiler errors, warnings, and help, all at compile time or pre-compile.
//let timers8Bit: (Timer8Bit, Timer8Bit) = (timer0, timer2)
//let timers16Bit: (Timer16Bit) = (timer1)
//let timersWithExternalClock: (HasExternalClock, HasExternalClock) = (timer0, timer1)
//let timersAsync: (AsyncTimer) = (timer2)


// Timer0 would conform to Timer8Bit, HasExternalClock
// Timer1 would conform to Timer16Bit, HasExternalClock
// Timer2 would conform to Timer8Bit, InternalClockOnly, and AsyncTimer
// TODO: I think Timer 0 and 1 use the prescaler with the external clock while timer 2 only uses the internal clock
// TODO: What happens with chips that have multiple Async Timers? Is this possible?
// TODO: Explore using Generics vs Protocols

protocol Timer {
    
    /// Timer/Counter Control Register A
    /// AKA TCCR0A See ATtiny13A Datasheet Section 11.9.1.
    /// ```
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|--------|
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0    |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|--------|
    /// | (0x2F)       | COM0A1| COM0A0| COM0B1| COM0B0|   -   |   -   | WGM01 | WGM00  |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|--------|
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |   R   |   R   |  R/W  |  R/W   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|--------|
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0    |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|--------|
    /// ```
    static var timerCounterControlRegisterA: UInt8 { get set }
    
    /// Timer/Counter Controll Register B
    /// AKA TCCR0B See ATtiny13A Datasheet Section 11.9.2.
    ///```
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | (0x33)       | FOC0A | FOC0B |   -   |   -   | WGM02 | CS02  | CS01  | CS00  |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | Read/Write   |  R/W  |  R/W  |   R   |   R   |  R/W  |  R/W  |  R/W  |  R/W  |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    ///```
    static var timerCounterControlRegisterB: UInt8 { get set }
    
    /// 11.9.6 TIMSK0 – Timer/Counter2 Interrupt Mask Register
    /// Note: the positions of OCIE0B, OCIE0A, and TOIE0 are different than the 328P.
    /// ```
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | (0x39)       |   -   |   -   |   -   |   -   | OCIE0B| OCIE0A| TOIE0 |   -   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | Read/Write   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |   R   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// ```
    static var timerInterruptMaskRegister: UInt8 { get set }
    
    /// 11.9.7 TIFR0 – Timer/Counter2 Interrupt Flag Register
    /// Note: the positions of OCF0B, OCF0A, and TOV0 are different than the 328P.
    /// ```
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | (0x38)       |   -   |   -   |   -   |   -   | OCF0B | OCF0A | TOV0  |   -   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | Read/Write   |   R   |   R   |   R   |   R   |  R/W  |  R/W  |  R/W  |   R   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// ```
    static var timerInterruptFlagRegister: UInt8 { get set }
    
    typealias CompareOutputMode = CompareOutputModeOption
}

// TODO: I've added notes from the datasheet that show the differences between all the modes for timers 0 and 2 which are 8 bit. This needs to be abstracted in some way and made safe.
enum CompareOutputModeOption: UInt8 {
    
    /// For A&B non-PWM Mode:           Normal port operation, Output Compare Pin disconnected. See Tables 15-2, 15-5, 18-2, or Table 18-5.
    /// For A&B Fast PWM Mode:          Normal port operation, Output Compare Pin disconnected. See Tables 18-3 or Table 18-6.
    /// For A&B Phase Correct PWM Mode: Normal port operation, Output Compare Pin disconnected. See Tables 18-4 or Table 18-7.
    /// Note: Output Compare Pin is OC + TimerNumber + PinLetter. Ex: Timer 0 pin A would be OC0A while Timer 2 pin B would be OC2B.
    case normal = 0
    
    /// For A non-PWM Mode:           Toggle Output Compare Pin on Compare Match. See Tables 15-2, 15-5, 18-2, or Table 18-5.
    /// For A Fast PWM Mode:          WGM02 = 0: Normal Port Operation, OC0A Disconnected. WGM02 = 1: Toggle OC0A on Compare Match. See Table 15-3.
    /// For A Phase Correct PWM Mode: WGM02 = 0: Normal Port Operation, OC0A Disconnected. WGM02 = 1: Toggle OC0A on Compare Match. See Table 15-4.
    /// For B non-PWM Mode:           Toggle Output Compare Pin on Compare Match. See Table 15-5.
    /// For B Fast PWM Mode:          Reserved. See Table 15-6
    /// For B Phase Correct PWM Mode: Reserved. See Table 15-7
    /// NOTE: A special case occurs when OCR0A equals TOP and COM0A1 is set. In this case, the Compare Match is ignored, but the set or clear is done at BOTTOM. See ”Fast PWM Mode” on page 108 for more details.
    /// NOTE: A special case occurs when OCR0A equals TOP and COM0A1 is set. In this case, the Compare Match is ignored, but the set or clear is done at TOP. See ”Phase Correct PWM Mode” on page 134 for more details.
    /// NOTE: B special case occurs when OCR0B equals TOP and COM0B1 is set. In this case, the Compare Match is ignored, but the set or clear is done at TOP. See ”Fast PWM Mode” on page 108 for more details.
    /// NOTE: B special case occurs when OCR0B equals TOP and COM0B1 is set. In this case, the Compare Match is ignored, but the set or clear is done at TOP*. See ”Phase Correct PWM Mode” on page 109 for more details. // * I believe there is an error here in the datasheet as it should say BOTTOM
    case toggle = 1 // TODO: Sometimes this is Reserved and does not work with some Waveform Generation Modes
    
    /// For A non-PWM Mode:           Clear Output Compare Pin on Compare Match. See Table 15-2
    /// For A Fast PWM Mode:          Clear OC0A on Compare Match, set OC0A at BOTTOM, (non-inverting mode).
    /// For A Phase Correct PWM Mode: Clear OC0A on Compare Match when up-counting. Set OC0A on Compare Match when down-counting.
    /// For B non-PWM Mode:           Clear OC0B on Compare Match
    /// For B Fast PWM Mode:          Clear OC0B on Compare Match, set OC0B at BOTTOM, (non-inverting mode)
    /// For B Phase Correct PWM Mode: Clear OC0B on Compare Match when up-counting. Set OC0B on Compare Match when down-counting.
    /// NOTE:
    case clear = 2
    
    /// For A&B non-PWM Mode:           Set Output Compare Pin on Compare Match
    /// For A&B Fast PWM Mode:          Set Output Compare Pin on Compare Match, clear Output Compare Pin at BOTTOM, (inverting mode).
    /// For A&B Phase Correct PWM Mode: Set Output Compare Pin on Compare Match when up-counting. Clear Output Compare Pin on Compare Match when down-counting.
    /// NOTE: Output Compare Pin is OC + TimerNumber + PinLetter. Ex: Timer 0 pin A would be OC0A while Timer 2 pin B would be OC2B.
    case set = 3
}

protocol Timer8Bit: Timer {
    
    /// 11.9.3 TCNT0 – Timer/Counter Register
    /// ```
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|--------
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|--------
    /// | (0x32)       |                         TCNT0                                 |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|--------
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|--------
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|--------
    /// ```
    static var timerCounterNumber: UInt8 { get set }
    
    /// 11.9.4 OCR0A – Output Compare Register A
    /// ```
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | (0x36)       |                         OCR0A                                 |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// ```
    // TODO: I believe OCR2A always needs to be larger than OCR2B. Should we have a safety for this?
    // TODO: Decide about simplifying this with OCR2A
    static var outputCompareRegisterA: UInt8 { get set }
    
    /// 11.9.5 OCR2B – Output Compare Register B
    /// ```
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | Bit          |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | (0x29)       |                         OCR0B                                 |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | Read/Write   |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |  R/W  |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// | InitialValue |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |
    /// |--------------|-------|-------|-------|-------|-------|-------|-------|-------|
    /// ```
    // TODO: I believe OCR2A always needs to be larger than OCR2B. Should we have a safety for this?
    // TODO: Decide about simplifying this with OCR2B
    static var outputCompareRegisterB: UInt8 { get set }
    
    typealias WaveformGenerationMode = WaveformGenerationMode8Bit
}

protocol Timer16Bit: Timer {
    
    // TODO: 16 Bit timers have an extra control register C. Wave Form Generation has more modes, other settings might also be more granular.
    static var timerCounterControlRegisterC: UInt8 { get set }
    
    // Note: These 3 properties change type from UInt8 to UInt16 depending on if the timer is an 8 Bit timer or 16 Bit Timer.
    static var timerCounterNumber: UInt16 { get set }
    static var outputCompareRegisterA: UInt16 { get set }
    static var outputCompareRegisterB: UInt16 { get set }
    
    typealias WaveformGenerationMode = WaveformGenerationMode16Bit
}

/// See ATtiny13A Datasheet Table 11-8.
/// Note: Modes #4 and #5 are Reserved and are unavalible for use and thus not included.
/// Note: This works for the 8 bit timers but the 16 bit timer has different Waveform Generation Modes.
///
/// Table 11-8. Waveform Generation Mode Bit Description
/// ```
/// |--------|-------|-------|-------|--------------------|-------|-------------------|-----------------
/// |  Mode  | WGM02 | WGM01 | WGM00 | Mode of Operation  |  TOP  | Update of OCRx at | TOV Flag Set on |
/// |--------|-------|-------|-------|--------------------|-------|-------------------|-----------------
/// |    0   |   0   |   0   |   0   | Normal             | 0xFF  | Immediate         | MAX             |
/// |--------|-------|-------|-------|--------------------|-------|-------------------|-----------------
/// |    1   |   0   |   0   |   1   | PWM, Phase Correct | 0xFF  | TOP               | BOTTOM          |
/// |--------|-------|-------|-------|--------------------|-------|-------------------|-----------------
/// |    2   |   0   |   1   |   0   | CTC                | OCRA  | Immediate         | MAX             |
/// |--------|-------|-------|-------|--------------------|-------|-------------------|-----------------
/// |    3   |   0   |   1   |   1   | Fast PWM           | 0xFF  | BOTTOM            | MAX             | // Datasheet says top for Update of OCRx. Seems like a mistake.
/// |--------|-------|-------|-------|--------------------|-------|-------------------|-----------------
/// |    4   |   1   |   0   |   0   | Reserved           |   -   |         -         |        -        |
/// |--------|-------|-------|-------|--------------------|-------|-------------------|-----------------
/// |    5   |   1   |   0   |   1   | PWM, Phase Correct | OCRA  | TOP               | BOTTOM          |
/// |--------|-------|-------|-------|--------------------|-------|-------------------|-----------------
/// |    6   |   1   |   1   |   0   | Reserved           |   -   |         -         |        -        |
/// |--------|-------|-------|-------|--------------------|-------|-------------------|-----------------
/// |    7   |   1   |   1   |   1   | Fast PWM           | OCRA  | BOTTOM            | TOP             | // Datasheet says top for Update of OCRx. Seems like a mistake.
/// |--------|-------|-------|-------|--------------------|-------|-------------------|-----------------
/// ```
///  Notes: 1. MAX= 0xFF
///       2. BOTTOM= 0x00
///
enum WaveformGenerationMode8Bit: UInt8 {
    case normal = 0
    case phaseCorrectPWM = 1
    case clearTimerOnCompareMatch = 2
    case fastPWM = 3
    
    // Note: The difference in Modes 5 and 7 are that the Output Compare Register (OCRA or OCRB) is the "Top" where in modes 1 and 3, 255 (0xFF) is the "Top".
    case advancedPhaseCorrectPWM = 5 // TODO: What should this be called?
    case advancedFastPWM = 7  // TODO: What should this be called?
}

enum WaveformGenerationMode16Bit: UInt8 {
    case normal = 0
    case phaseCorrectPWM8Bit = 1
    case phaseCorrectPWM9Bit = 2
    case phaseCorrectPWM10Bit = 3
    case clearTimerCountOnOutputCompairRegister = 4 // TODO: I think naming needs to be updated to be similar to this on the 8 bit version.
    case fastPWM8Bit = 5
    case fastPWM9Bit = 6
    case fastPWM10Bit = 7
    case phaseAndFrequencyCorrectPWMOnInputCaptureRegister = 8 // TODO: Update the names of the 8 bit version to be similar to this
    case phaseAndFrequencyCorrectPWMOnOutputCompairRegister = 9
    case phaseCorrectPWMOnInputCaptureRegister = 10
    case phaseCorrectPWMOnOutputCompairRegister = 11
    case clearTimerCountOnInputCaptureRegister = 12
    case fastPWMOnInputCaptureRegister = 14
    case fastPWMOnOutputCompairRegister = 15
}

protocol HasExternalClock {
    static var prescalor: HasExternalClockPrescaling { get set }
}

/// See ATtiny13A Datasheet Table 11-9.
///
/// Table 11-9. Clock Select Bit Description
/// ```
/// |--------|-------|-------|-------|-----------------------------------------------------------------|
/// |  Mode  | CS02  | CS01  | CS00  | Description                                                     |
/// |--------|-------|-------|-------|-----------------------------------------------------------------|
/// |    0   |   0   |   0   |   0   | No clock source (Timer/Counter stopped)                         |
/// |--------|-------|-------|-------|-----------------------------------------------------------------|
/// |    1   |   0   |   0   |   1   | clk (No prescaling)                                             |
/// |--------|-------|-------|-------|-----------------------------------------------------------------|
/// |    2   |   0   |   1   |   0   | clk /8 (From prescaler)                                         |
/// |--------|-------|-------|-------|-----------------------------------------------------------------|
/// |    3   |   0   |   1   |   1   | clk /64 (From prescaler)                                        |
/// |--------|-------|-------|-------|-----------------------------------------------------------------|
/// |    4   |   1   |   0   |   0   | clkI/O/256 (From prescaler)                                     |
/// |--------|-------|-------|-------|-----------------------------------------------------------------|
/// |    5   |   1   |   0   |   1   | clkI/O/1024 (From prescaler)                                    |
/// |--------|-------|-------|-------|-----------------------------------------------------------------|
/// |    6   |   1   |   1   |   0   | External clock source on T0 pin. Clock on falling edge.         |
/// |--------|-------|-------|-------|-----------------------------------------------------------------|
/// |    7   |   1   |   1   |   1   | External clock source on T0 pin. Clock on rising edge.          |
/// |--------|-------|-------|-------|-----------------------------------------------------------------|
/// ```
/// If external pin modes are used for the Timer/Counter0, transitions on the T0 pin will clock the counter even if the pin is configured as an output. This feature allows software control of the counting.
///
enum HasExternalClockPrescaling: UInt8 {
    case noClockSource = 0 // No Clock Source - counter is off
    case none = 1 // clkT2S - No Prescaler
    case eight = 2 // clkT2S/8
    case thirtyTwo = 3 // clkT2S/32
    case sixtyFour = 4 // clkT2S/64
    case oneTwentyEight = 5 // clkT2S/128
    case twoFiftySix = 6 // clkT2S/256
    case tenTwentyFour = 7 // clkT2S/1024
}

protocol InternalClockOnly {
    static var prescalor: InternalClockOnlyPrescaling { get set }
}

enum InternalClockOnlyPrescaling: UInt8 {
    case noClockSource = 0
    case none = 1
    case eight = 2
    case sixtyFour = 3
    case twoFiftySix = 4
    case tenTwentyFour = 5
    case externalClockOnFallingEdge = 6
    case externalClockOnRisingEdge = 7
}

// TODO: Verify that this assumption is correct.
protocol AsyncTimer {
    // These are only used on the Async timer2?
    static var ASSR:   UInt8 { get set } // TODO: Update this name.
    static var GTCCR:  UInt8 { get set } // TODO: Update this name.
}


//
//  PowerManagementAndSleepModes.swift
//  SwiftForArduino
//
//  Created by xander rasschaert on 29/03/2023.
//

public enum PMSM {
    public enum SleepModeSelect: UInt8 {
        case idle = 0
        case ADCNoiseReduction = 1
        case PowerDown = 2
        case PowerSave = 3
        case Standby = 6
        case ExternalStandby = 7
    }
}

public protocol AVRPMSM {
    static var SleepModeControlRegister: UInt8 { get set }
    static var MCUControlRegister: UInt8 { get set }
    static var PowerReductionRegister: UInt8 { get set }
}

public struct PowerManagementAndSleepModes: AVRPMSM {
    
    @inlinable
    @inline(__always)
    public static var SleepModeControlRegister: UInt8 { //SMCR
        get {
            return _volatileRegisterReadUInt8(0x33)
        }
        set {
            _rawPointerWrite(address:0x33, value: newValue)
        }
    }
    
    @inlinable
    @inline(__always)
    public static var MCUControlRegister: UInt8 { //PRR
        get {
            return _volatileRegisterReadUInt8(0x35)
        }
        set {
            _rawPointerWrite(address:0x35, value: newValue)
        }
    }
    
    
    
    @inlinable
    @inline(__always)
    public static var PowerReductionRegister: UInt8 { //PRR
        get {
            return _volatileRegisterReadUInt8(0x64)
        }
        set {
            _rawPointerWrite(address:0x64, value: newValue)
        }
    }
}

public extension AVRPMSM {
    /// -------------------------------------
    /// Sleep Mode Control Register
    /// -------------------------------------
    
    /// Sleep Mode Select
    /// See ATMega328p Datasheet Section 10.11.1.
    /// SM2, SM1 and SM0 are bits 3, 2 and 1 on SMCR.
    ///
    /// These bits select between the five available sleep modes
    ///
    /// ```
    ///| SM2   | SM1   | SM0   | Sleep Mode              |
    ///|-------|-------|-------|-------------------------|
    ///| 0     | 0     | 0     | Idle                    |
    ///| 0     | 0     | 1     | ADC Noise Reduction     |
    ///| 0     | 1     | 0     | Power-down              |
    ///| 0     | 1     | 1     | Power-save              |
    ///| 1     | 0     | 0     | Reserved                |
    ///| 1     | 0     | 1     | Reserved                |
    ///| 1     | 1     | 0     | Standby                 |
    ///| 1     | 1     | 1     | External Standby        |
    /// ```
    @inlinable
    @inline(__always)
    static var SleepModeSelect: PMSM.SleepModeSelect { // SM[2:0]
        get {
            let mode = (SleepModeControlRegister & ~0b00001110) >> 1
            return PMSM.SleepModeSelect.init(rawValue: mode) ?? .idle
        }
        set {
            SleepModeControlRegister = SleepModeControlRegister | ((newValue.rawValue << 1) & 0b00001110)
        }
    }
    
    /// Power Reduction TWI
    /// See ATMega328p Datasheet Section 10.11.1.
    /// SE is bit 0 on SMCR.
    ///
    /// The SE bit must be written to logic one to make the MCU enter the sleep mode when the SLEEP instruction is executed.
    /// To avoid the MCU entering the sleep mode unless it is the programmer’s purpose, it is recommended to write the Sleep
    /// Enable (SE) bit to one just before the execution of the SLEEP instruction and to clear it immediately after waking up.
    @inlinable
    @inline(__always)
    static var SleepEnable: Bool { //SE
        get {
            return !((SleepModeControlRegister & 0b00000001) == 0)
        }
        set {
            SleepModeControlRegister = (SleepModeControlRegister & ~0b00000001) | (((newValue == true) ? 1 : 0) & 0b00000001)
        }
    }
    
    /// -------------------------------------
    /// MCU Control Register
    /// -------------------------------------
    
    /// BOD Sleep
    /// See ATMega328p Datasheet Section 10.11.2.
    /// BODS is bit 6 on MCUCR.
    ///
    /// The BODS bit must be written to logic one in order to turn off BOD during sleep, see Table 10-1 on page 48. Writing to the
    /// BODS bit is controlled by a timed sequence and an enable bit, BODSE in MCUCR. To disable BOD in relevant sleep modes, both
    /// BODS and BODSE must first be set to one. Then, to set the BODS bit, BODS must be set to one and BODSE must be set to zero
    /// within four clock cycles.
    ///
    /// The BODS bit is active three clock cycles after it is set. A sleep instruction must be executed while BODS is active in order
    /// to turn off the BOD for the actual sleep mode. The BODS bit is automatically cleared after three clock cycles.
    @inlinable
    @inline(__always)
    static var BODSleep: Bool { //BODS
        get {
            return !((MCUControlRegister & 0b01000000) == 0)
        }
        set {
            MCUControlRegister = (MCUControlRegister & ~0b01000000) | (((newValue == true) ? 1 : 0) << 6 & 0b01000000)
        }
    }
    
    /// BOD Sleep Enable
    /// See ATMega328p Datasheet Section 10.11.2.
    /// BODSE is bit 5 on MCUCR.
    ///
    /// BODSE enables setting of BODS control bit, as explained in BODS bit description. BOD disable is controlled by
    /// a timed sequence.
    ///
    /// NOTE: BODS and BODSE only available for picoPower devices ATmega48PA/88PA/168PA/328P
    @inlinable
    @inline(__always)
    static var BODSleepEnable: Bool { //BODSE
        get {
            return !((MCUControlRegister & 0b00100000) == 0)
        }
        set {
            MCUControlRegister = (MCUControlRegister & ~0b00100000) | (((newValue == true) ? 1 : 0) << 5 & 0b00100000)
        }
    }
    
    /// -------------------------------------
    /// Power Reduction Register
    /// -------------------------------------
    
    /// Power Reduction TWI
    /// See ATMega328p Datasheet Section 10.11.3.
    /// PRTWI is bit 7 on PRR.
    ///
    /// Writing a logic one to this bit shuts down the TWI by stopping the clock to the module.
    /// When waking up the TWI again, the TWI should be re initialized to ensure proper operation.
    @inlinable
    @inline(__always)
    static var PowerReductionTWI: Bool { //PRTWI
        get {
            return !((PowerReductionRegister & 0b10000000) == 0)
        }
        set {
            PowerReductionRegister = (PowerReductionRegister & ~0b10000000) | (((newValue == true) ? 1 : 0) << 7 & 0b10000000)
        }
    }
    
    /// Power Reduction Timer/Counter2
    /// See ATMega328p Datasheet Section 10.11.3.
    /// PRTIM2 is bit 6 on PRR.
    ///
    /// Writing a logic one to this bit shuts down the Timer/Counter2 module in synchronous mode (AS2 is 0).
    /// When the Timer/Counter2 is enabled, operation will continue like before the shutdown.
    @inlinable
    @inline(__always)
    static var PowerReductionTimerCounter2: Bool { //PRTIM2
        get {
            return !((PowerReductionRegister & 0b01000000) == 0)
        }
        set {
            PowerReductionRegister = (PowerReductionRegister & ~0b01000000) | (((newValue == true) ? 1 : 0) << 6 & 0b01000000)
        }
    }
    
    /// Power Reduction Timer/Counter0
    /// See ATMega328p Datasheet Section 10.11.3.
    /// PRTIM0 is bit 5 on PRR.
    ///
    /// Writing a logic one to this bit shuts down the Timer/Counter0 module. When the Timer/Counter0 is enabled,
    /// operation will continue like before the shutdown.
    @inlinable
    @inline(__always)
    static var PowerReductionTimerCounter0: Bool { //PRTIM0
        get {
            return !((PowerReductionRegister & 0b00100000) == 0)
        }
        set {
            PowerReductionRegister = (PowerReductionRegister & ~0b00100000) | (((newValue == true) ? 1 : 0) << 5 & 0b00100000)
        }
    }
    
    /// Power Reduction Timer/Counter1
    /// See ATMega328p Datasheet Section 10.11.3.
    /// PRTIM1 is bit 3 on PRR.
    ///
    /// Writing a logic one to this bit shuts down the Timer/Counter2 module in synchronous mode (AS2 is 0).
    /// When the Timer/Counter2 is enabled, operation will continue like before the shutdown.
    @inlinable
    @inline(__always)
    static var PowerReductionTimerCounter1: Bool { //PRTIM1
        get {
            return !((PowerReductionRegister & 0b00001000) == 0)
        }
        set {
            PowerReductionRegister = (PowerReductionRegister & ~0b00001000) | (((newValue == true) ? 1 : 0) << 3 & 0b00001000)
        }
    }
    
    /// Power Reduction Serial Peripheral Interface
    /// See ATMega328p Datasheet Section 10.11.3.
    /// PRSPI is bit 3 on PRR.
    ///
    /// If using debugWIRE On-chip Debug System, this bit should not be written to one. Writing a logic one to
    /// this bit shuts down the Serial Peripheral Interface by stopping the clock to the module. When waking up
    /// the SPI again, the SPI should be re initialized to ensure proper operation.
    @inlinable
    @inline(__always)
    static var PowerReductionSerialPeripheralInterface: Bool { //PRSPI
        get {
            return !((PowerReductionRegister & 0b00000100) == 0)
        }
        set {
            PowerReductionRegister = (PowerReductionRegister & ~0b00000100) | (((newValue == true) ? 1 : 0) << 2 & 0b00000100)
        }
    }
    
    /// Power Reduction USART0
    /// See ATMega328p Datasheet Section 10.11.3.
    /// PRUSART0 is bit 3 on PRR.
    ///
    /// Writing a logic one to this bit shuts down the USART by stopping the clock to the module.
    /// When waking up the USART again, the USART should be re initialized to ensure proper operation.
    @inlinable
    @inline(__always)
    static var PowerReductionUSART0: Bool { //PRUSART0
        get {
            return !((PowerReductionRegister & 0b00000010) == 0)
        }
        set {
            PowerReductionRegister = (PowerReductionRegister & ~0b00000010) | (((newValue == true) ? 1 : 0) << 1 & 0b00000010)
        }
    }
    
    /// Power Reduction ADC
    /// See ATMega328p Datasheet Section 10.11.3.
    /// PRADC is bit 3 on PRR.
    ///
    /// Writing a logic one to this bit shuts down the ADC. The ADC must be disabled before shut down.
    /// The analog comparator cannot use the ADC input MUX when the ADC is shut down.
    @inlinable
    @inline(__always)
    static var PowerReductionADC: Bool { //PRADC
        get {
            return !((PowerReductionRegister & 0b00000001) == 0)
        }
        set {
            PowerReductionRegister = (PowerReductionRegister & ~0b00000001) | (((newValue == true) ? 1 : 0) & 0b00000001)
        }
    }
}

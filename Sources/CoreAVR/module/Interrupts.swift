//
//  Interrupts.swift
//  CoreAVR
//
//  Created by Brent Van den Abbeel on 2025-10-17.
//

public enum InterruptVector: UInt8 {
    case powerOnReset = 0
    case externalInterruptRequest0 = 1
    case externalInterruptRequest1 = 2
    case pinChangeInterruptRequest0 = 3
    case pinChangeInterruptRequest1 = 4
    case pinChangeInterruptRequest2 = 5
    case watchdogTimeout = 6
    case timer2CompareMatchA = 7
    case timer2CompareMatchB = 8
    case timer2Overflow = 9
    case timer1Capture = 10
    case timer1CompareMatchA = 11
    case timer1CompareMatchB = 12
    case timer1Overflow = 13
    case timer0CompareMatchA = 14
    case timer0CompareMatchB = 15
    case timer0Overflow = 16
    case spiSerialTransferComplete = 17
    case usartRxComplete = 18
    case usartDataRegisterEmpty = 19
    case usartTxComplete = 20
    case adcConversionComplete = 21
    case eepromReady = 22
    case analogComparator = 23
    case twoWireSerialInterface = 24
    case storeProgramMemoryReady = 25
}

public struct Interrupts {
    /// Datasheet Section 7.7 - Reset and Interrupt Handling
    /// Inserts a "Global Interrupt Enable" (`sei`) instruction at the current location.
    @inlinable
    @inline(__always)
    public static func enableInterrupts() {
        _sei()
    }

    /// Datasheet Section 7.7 - Reset and Interrupt Handling
    /// Inserts a "Global Interrupt Disable" (`cli`) instruction at the current location.
    @inlinable
    @inline(__always)
    public static func disableInterrupts() {
        _cli()
    }
}

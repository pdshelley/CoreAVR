//===----------------------------------------------------------------------===//
//
// UART.swift
// CoreAVR
//
// Created by Swift AVR Generator on 03/23/2026.
// Copyright © 2026 Paul Shelley. All rights reserved.
//
//===----------------------------------------------------------------------===//




public enum UART {
    /// See ATMega328p Datasheet Section 20.4.1 and Table 20-9.
    public enum ParityMode: UInt8 {
        case disabled = 0
        case even = 2
        case odd = 3
    }

    /// See ATMega328p Datasheet Table 20-10.
    public enum NumberOfStopBits: UInt8 {
        case one = 0
        case two = 1
    }

    /// See ATMega328p Datasheet Section 20.4 and Table 20-11.
    public enum NumberOfDataBits: UInt8 {
        case five = 0
        case six = 1
        case seven = 2
        case eight = 3
        case nine = 7
    }

    /// See ATMega328p Datasheet Table 20-12.
    // This is relative to the Transmitted Data Changed (Output of TxDn Pin)
    // Received Data Sampled will be opposite of Transmitted Data Changed, Ex: Rising for TX is Falling for RX.
    public enum ClockPolarity: UInt8 {
        case rising = 0
        case falling = 1
    }

    /// See ATMega328p Datasheet Section 20.11.2
    public enum AsynchronousDoubleSpeedMode: UInt8 {
        case off = 0
        case on = 1
    }

    /// See ATMega328p Datasheet Section 20.11.3
    public enum ReceiverEnable: UInt8 {
        case off = 0
        case on = 1
    }

    /// See ATMega328p Datasheet Section 20.11.3
    public enum TransmitterEnable: UInt8 {
        case off = 0
        case on = 1
    }

    /// See ATMega328p Datasheet Section 20.11.3
    public enum RXCompleteInterruptEnable: UInt8 {
        case off = 0
        case on = 1
    }

    /// See ATMega328p Datasheet Section 20.11.3
    public enum TXCompleteInterruptEnable: UInt8 {
        case off = 0
        case on = 1
    }

    /// See ATMega328p Datasheet Section 20.11.3
    public enum DRECompleteInterruptEnable: UInt8 {
        case off = 0
        case on = 1
    }

    /// See ATMega328p Datasheet Section 20.11.4 Table 20-8.
    public enum ModeSelect: UInt8 {
        case asynchronous = 0
        case synchronous = 1
        // 2 is reserved
        case masterSPI
    }
}

public protocol UARTPort {
    // this will probably(?) always be UInt8, but is useful for preventing the protocol
    // from ever accidentally being used as an existential type
    associatedtype PortDataType: BinaryInteger

    // Registers
    static var dataRegister: PortDataType { get set }
    static var controlRegisterA: UInt8 { get set }
    static var controlRegisterB: UInt8 { get set }
    static var controlRegisterC: UInt8 { get set }
    static var baudRateRegisterL: UInt8 { get set }
    static var baudRateRegisterH: UInt8 { get set }
    static var baudRateRegister: UInt16 { get set }

    // Properties
    static var rxDataAvailable: Bool { get }
    static var txComplete: Bool { get set }

    static var dataRegisterEmpty: Bool { get }
    static var frameError: Bool { get }
    static var dataOverrun: Bool { get }
    static var parityError: Bool { get }

    static var asynchronousDoubleSpeedMode: UART.AsynchronousDoubleSpeedMode { get set }
    static var multiProcessorCommunication: Bool { get set }

    static var rxCompleteInterruptEnable: UART.RXCompleteInterruptEnable { get set }
    static var txCompleteInterruptEnable: UART.TXCompleteInterruptEnable { get set }
    static var dataRegisterEmptyInterruptEnable: UART.DRECompleteInterruptEnable { get set }

    static var receiverEnable: UART.ReceiverEnable { get set }
    static var transmitterEnable: UART.TransmitterEnable { get set }

    static var numberOfDataBits: UART.NumberOfDataBits { get set }
    static var receiveData8thBit: Bool { get }
    static var transmitData8thBit: Bool { get set }
    static var modeSelect: UART.ModeSelect { get set }
    static var parityMode: UART.ParityMode { get set }
    static var numberOfStopBits: UART.NumberOfStopBits { get set }
    static var clockPolarity: UART.ClockPolarity { get set }
}

public extension UARTPort {
    /// Note: Needs to be updated to account for U2Xn or the Opperating Mode of the UART. See ATMega328p Datasheet Table 20-1.
    /// This is a convenience wrapper on the "baudRateRegister" or "UBRRn" to allow setting a "normal" baud rate
    /// and then do the calculation to convert this to the setting needed for UBRRn.
    @inlinable
    @inline(__always)
    static var baudRate: UInt32 {
        get {
            return UInt32(cpuFrequency) / (UInt32(16 * (baudRateRegister + 1)))
        }
        set {
            baudRateRegister = UInt16((UInt32(cpuFrequency) / (16 * newValue)) - 1)
        }
    }
}

public extension UARTPort {
    @inlinable
    @inline(__always)
    /// The lowest level of writing out data to hardware UART. This function makes sure that the Data Register is empty before sending out more data, this is important for proper opperation
    /// See Section 20.6.1
    /// - Parameter byte: A single byte of data to be sent.
    static func writeByte(_ byte: PortDataType) {
        while !dataRegisterEmpty {
        }
        dataRegister = byte
    }

    // See Section 20.6.1
    @inlinable
    @inline(__always)
    static func read() -> PortDataType { // TODO: Needs Testing
        while !rxDataAvailable {
        }
        return dataRegister
    }

    @inlinable
    @inline(__always)
    static func available() -> Bool {
        rxDataAvailable
    }
}

public extension UARTPort where PortDataType == UInt8 {
    // See Section 20.6.1
    @inlinable
    @inline(__always)
    static func write(_ data: StaticString) {
        for character in data {
            writeByte(character)
        }
    }

    @inlinable
    @inline(__always)
    static func write(_ int: Int8) {
        var integer = int

        if integer < 0 {
            write("-")
            integer.negate()
            write(UInt8(integer))
        } else {
            write(UInt8(integer))
        }
    }

    @inlinable
    @inline(__always)
    static func write(_ int: Int16) {
        var integer = int

        if integer < 0 {
            write("-")
            integer.negate()
            write(UInt16(integer))
        } else {
            write(UInt16(integer))
        }
    }

    @inlinable
    @inline(__always)
    static func write(_ int: UInt8, withLeadingZeros: Bool = false) {
        var remainingInteger = int
        var currentDivisor: UInt8 = 100
        var shouldPrintZero = withLeadingZeros

        while currentDivisor > 0 {
            let currentInt = remainingInteger / currentDivisor

            if currentInt > 0 || shouldPrintZero || currentDivisor == 1 {
                writeByte(currentInt + 48)
                shouldPrintZero = true
            }

            remainingInteger -= (currentInt * currentDivisor) // Save the remaining numbers to print
            currentDivisor /= 10 // Update the divisor
        }
    }

    @inlinable
    @inline(__always)
    static func write(_ int: UInt16, withLeadingZeros: Bool = false) {
        var remainingInteger = int
        var currentDivisor: UInt16 = 10000
        var shouldPrintZero = withLeadingZeros

        while currentDivisor > 0 {
            let currentInt = remainingInteger / currentDivisor

            if currentInt > 0 || shouldPrintZero || currentDivisor == 1  {
                writeByte(UInt8(currentInt + 48))
                shouldPrintZero = true
            }

            remainingInteger -= (currentInt * currentDivisor) // Save the remaining numbers to print
            currentDivisor /= 10 // Update the divisor
        }
    }

    @inlinable
    @inline(__always)
    static func write(_ int: UInt32, withLeadingZeros: Bool = false) {
        var remainingInteger = int
        var currentDivisor: UInt32 = 1000000000
        var shouldPrintZero = withLeadingZeros

        while currentDivisor > 0 {
            let currentInt = remainingInteger / currentDivisor

            if currentInt > 0 || shouldPrintZero || currentDivisor == 1  {
                writeByte(UInt8(currentInt + 48))
                shouldPrintZero = true
            }

            remainingInteger -= (currentInt * currentDivisor) // Save the remaining numbers to print
            currentDivisor /= 10 // Update the divisor
        }
    }
}
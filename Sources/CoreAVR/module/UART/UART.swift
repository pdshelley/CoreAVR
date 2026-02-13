//===----------------------------------------------------------------------===//
//
// UART.swift
// Swift For Arduino
//
// Created by Paul Shelley on 12/30/2022.
// Copyright © 2022 Paul Shelley. All rights reserved.
//
//===----------------------------------------------------------------------===//
//===----------------------------------------------------------------------===//
// UART Serial Communications
//===----------------------------------------------------------------------===//


// Note: The ATmega48A, ATmegaPA, ATmega88A, ATmegaPA, ATmega168A, ATmegaPA, ATmega328, and ATmega328P, are all pin compatible and have
// the same hardware features and the only differences are in memory space.
// The 328PB that has an additional UART, SPI, and I2C making a total of 2 each and comes in different package sizes.


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
    // This is relitive to the Transmitted Data Changed (Output of TxDn Pin)
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
}

public protocol UARTPort {
    // this will probably(?) always be UInt8, but is useful for preventing the protocol
    // from ever accidentally being used as an existential type
    associatedtype PortDataType: BinaryInteger
    
    static var dataRegister: PortDataType { get set }
    static var baudRateRegisterH: UInt8 { get set }
    static var baudRateRegisterL: UInt8 { get set }
    static var baudRateRegister: UInt16 { get set }
    static var controlRegisterA: UInt8 { get set }
    static var controlRegisterB: UInt8 { get set }
    static var controlRegisterC: UInt8 { get set }
}

//===----------------------------------------------------------------------===//
//
// HAL.swift
// Swift For Arduino
//
// Created by Carl Peto & Paul Shelley on 11/27/20.
// Copyright © 2020 Swift4Arduino. All rights reserved.
//
//===----------------------------------------------------------------------===//


// NOTE: This Port abstraction could also have the same issue. I think it's very safe to assume that all of the AVR chips will work this way but I am unfamiliar with how strong this convention is. I'll try to research this.
// See ATmega48A/PA/88A/PA/168A/PA/328/P Datasheet section 14
public protocol PartialPort {
    associatedtype PortType: BinaryInteger
    static var dataRegister: PortType { get set }
    static var inputAddress: PortType { get } // TODO: Can you write to this? See 14.4.4
}

// we separate out the PartialPort protocol because some AVR chips (the HVA series) have
// a port that only contains read/write registers and no data direction register
public protocol Port: PartialPort {
    static var dataDirection: PortType { get set }
}

public protocol Bit {
    associatedtype BitType: BinaryInteger
    associatedtype PinMaskType: BinaryInteger
    static var bit: BitType { get }
}

public extension Bit {
    @inlinable
    @inline(__always)
    static var pinSetMask: PinMaskType {
        1 << bit
    }

    @inlinable
    @inline(__always)
    static var pinClearMask: PinMaskType {
        ~(1 << bit)
    }

    @inlinable
    @inline(__always)
    static var pinDirectionSetMask: PinMaskType {
        1 << bit
    }

    @inlinable
    @inline(__always)
    static var pinDirectionClearMask: PinMaskType {
        ~(1 << bit)
    }

    @inlinable
    @inline(__always)
    static var pinGetMask: PinMaskType {
        1 << bit
    }
}

public protocol PartialPortPin {
    associatedtype PinPartialPort: PartialPort
    associatedtype PinBit: Bit

    static func setValue(_ value: DigitalValue)
    static func value() -> DigitalValue
}

@frozen
public enum DataDirectionFlag: UInt8 {
    case input, output
}

public protocol PortPin: PartialPortPin where PinPartialPort == PinPort {
    associatedtype PinPort: Port
    static func setDataDirection(_ direction: DataDirectionFlag)
}

// TODO: I would love to extend pins with additionl functionality that have it. Obvious cases are Digial pins, pins with Analouge to Digital capabilities, and Pulse Width Moduation capabilities.
// Carl: But, the danger is (as with Arduino Wiring library) you hide the fact you're actually using a timer. Maybe it's better to keep the config on the timer. And doing something like timer2... mode fast pwm... output on pin pd3... Mark 50%

//protocol Digital: Pin {
//
//}
//
//protocol ADC: Pin { // Note: Should we use the word `Analogue` here or should we call this something else more inline with the datasheet like ADC? I'm leaning to ADC
//
//}
//
//protocol PWM: Pin {
//
//}

public extension PartialPortPin where PinPartialPort.PortType == PinBit.PinMaskType {
    @inlinable
    @inline(__always)
    static func setValue(_ value: DigitalValue) {
    if value == .high {
      PinPartialPort.dataRegister |= PinBit.pinSetMask
    } else {
      PinPartialPort.dataRegister &= PinBit.pinClearMask
    }
  }

    @inlinable
    @inline(__always)
    static func value() -> DigitalValue {
      return DigitalValue(PinPartialPort.inputAddress & PinBit.pinGetMask != 0)
  }
}

public extension PortPin where PinPort.PortType == PinBit.PinMaskType {
    @inlinable
    @inline(__always)
    static func setDataDirection(_ direction: DataDirectionFlag) {
        switch direction {
            case .input:
                PinPort.dataDirection &= PinBit.pinDirectionClearMask
            case .output:
                PinPort.dataDirection |= PinBit.pinDirectionSetMask
        }
    }
}

public enum DigitalPin<_Port: Port, _Bit: Bit>: PortPin where _Port.PortType == _Bit.PinMaskType {
    public typealias PinPort = _Port
    public typealias PinPartialPort = _Port
    public typealias PinBit = _Bit
}

public enum InputOnlyDigitalPin<_Port: PartialPort, _Bit: Bit>: PartialPortPin where _Port.PortType == _Bit.PinMaskType {
    public typealias PinPartialPort = _Port
    public typealias PinBit = _Bit
}

// bit definitions for AVR
public enum Bit0: Bit {
    public typealias PinMaskType = UInt8

    @inlinable
    @inline(__always)
    public static var bit: UInt8 { 0 }
}

public enum Bit1: Bit {
    public typealias PinMaskType = UInt8

    @inlinable
    @inline(__always)
    public static var bit: UInt8 { 1 }
}

public enum Bit2: Bit {
    public typealias PinMaskType = UInt8

    @inlinable
    @inline(__always)
    public static var bit: UInt8 { 2 }
}

public enum Bit3: Bit {
    public typealias PinMaskType = UInt8

    @inlinable
    @inline(__always)
    public static var bit: UInt8 { 3 }
}

public enum Bit4: Bit {
    public typealias PinMaskType = UInt8

    @inlinable
    @inline(__always)
    public static var bit: UInt8 { 4 }
}

public enum Bit5: Bit {
    public typealias PinMaskType = UInt8

    @inlinable
    @inline(__always)
    public static var bit: UInt8 { 5 }
}

public enum Bit6: Bit {
    public typealias PinMaskType = UInt8

    @inlinable
    @inline(__always)
    public static var bit: UInt8 { 6 }
}

public enum Bit7: Bit {
    public typealias PinMaskType = UInt8

    @inlinable
    @inline(__always)
    public static var bit: UInt8 { 7 }
}

//------------------------------------------------------------------------------
// Get a single bit from an 8 bit register (value)

@inlinable
@inline(__always)

public func getRegisterBit(_ register: UInt8, bit: UInt8) -> Bool {

//    let registerValue: UInt8 = _volatileRegisterReadUInt8(UInt16(register))
//    let bitFilter = 1 << bit
//    let filtered = registerValue & bitFilter
//    return filtered != 0
    return false
}

//------------------------------------------------------------------------------
// Set a single bit in an 8 bit register, leaving all other bits intact

@inlinable
@inline(__always)

public func setRegisterBit(_ register: UInt8, bit: UInt8, value: Bool) {

//    let bitFilter = 1 << bit

    // Clear bit of interest, leave rest alone
//    var result = register & ~bitFilter

    // Set bit of interest (if needed)
    if value {
//        result = result | bitFilter
    }

//    _volatileRegisterWriteUInt8(UInt16(register), result)
}

//------------------------------------------------------------------------------

//
//  CPUCore.swift
//  SwiftForArduino
//
//  Created by xander rasschaert on 26/04/2023.
//

public protocol AVRCPUCore{
    static var statusRegister: UInt8 { get set }
    static var stackPointerHigh: UInt8 { get set }
}

public typealias cpuCore = CPUCore

public struct CPUCore: AVRCPUCore {
    @inlinable
    @inline(__always)
    public static var statusRegister: UInt8 { //SREG
        get {
            return 0
//            return _volatileRegisterReadUInt8(0x5F)
        }
        set {
//            _rawPointerWrite(address:0x5F, value: newValue)
        }
    }
    
    @inlinable
    @inline(__always)
    public static var stackPointerHigh: UInt8 { //SPH
        get {
            return 0
//            return _volatileRegisterReadUInt8(0x5E)
        }
        set {
//            _rawPointerWrite(address:0x5E, value: newValue)
        }
    }
    
    @inlinable
    @inline(__always)
    public static var stackPointerLow: UInt8 { //SPL
        get {
            return 0
//            return _volatileRegisterReadUInt8(0x5D)
        }
        set {
//            _rawPointerWrite(address:0x5D, value: newValue)
        }
    }
}

public extension AVRCPUCore {
    /// -------------------------------------
    /// AVR Status Register
    /// -------------------------------------
    
    /// SPI Interrupt Enable
    /// See ATMega328p Datasheet Section 7.3.1.
    /// I is bit 7 on SREG.
    ///
    /// The Global Interrupt Enable bit must be set for the interrupts to be enabled. The individual interrupt enable control is
    /// then performed in separate control registers. If the Global Interrupt Enable Register is cleared, none of the interrupts
    /// are enabled independent of the individual interrupt enable settings. The I-bit is cleared by hardware after an interrupt
    /// has occurred, and is set by the RETI instruction to enable subsequent interrupts. The I-bit can also be set and cleared by
    /// the application with the SEI and CLI instructions, as described in the instruction set reference.
    @inlinable
    @inline(__always)
    static var globalInterruptEnable: Bool { //I
        get {
            return !((statusRegister & 0b10000000) == 0)
        }
        set {
            statusRegister = (statusRegister & ~0b10000000) | (((newValue == true) ? 1 : 0) << 7 & 0b10000000)
        }
    }
    
    /// Bit Copy Storage
    /// See ATMega328p Datasheet Section 7.3.1.
    /// T is bit 6 on SREG.
    ///
    /// The Bit Copy instructions BLD (Bit LoaD) and BST (Bit STore) use the T-bit as source or destination for the operated bit.
    /// A bit from a register in the Register File can be copied into T by the BST instruction, and a bit in T can be copied into
    /// a bit in a register in the Register File by the BLD instruction.
    @inlinable
    @inline(__always)
    static var bitCopyStorage: Bool { //I
        get {
            return !((statusRegister & 0b01000000) == 0)
        }
        set {
            statusRegister = (statusRegister & ~0b01000000) | (((newValue == true) ? 1 : 0) << 6 & 0b01000000)
        }
    }
    
    /// Half Carry Flag
    /// See ATMega328p Datasheet Section 7.3.1.
    /// H is bit 5 on SREG.
    ///
    /// The Half Carry Flag H indicates a Half Carry in some arithmetic operations. Half Carry Is useful in BCD arithmetic.
    /// See the “Instruction Set Description” for detailed information.
    @inlinable
    @inline(__always)
    static var halfCarryFlag: Bool { //H
        get {
            return !((statusRegister & 0b00100000) == 0)
        }
        set {
            statusRegister = (statusRegister & ~0b00100000) | (((newValue == true) ? 1 : 0) << 5 & 0b00100000)
        }
    }
    
    /// Sign Bit, S = N + V
    /// See ATMega328p Datasheet Section 7.3.1.
    /// S is bit 4 on SREG.
    ///
    /// The S-bit is always an exclusive or between the Negative Flag N and the Two’s Complement Overflow Flag V.
    /// See the “Instruction Set Description” for detailed information.
    @inlinable
    @inline(__always)
    static var signBit: Bool { //S
        get {
            return !((statusRegister & 0b00010000) == 0)
        }
        set {
            statusRegister = (statusRegister & ~0b00010000) | (((newValue == true) ? 1 : 0) << 4 & 0b00010000)
        }
    }
    
    /// Two's Complement Overflow Flag
    /// See ATMega328p Datasheet Section 7.3.1.
    /// V is bit 3 on SREG.
    ///
    /// The Two’s Complement Overflow Flag V supports two’s complement arithmetic. See the “Instruction Set Description” for detailed information.
    @inlinable
    @inline(__always)
    static var twosComplementOverflowFlag: Bool { //V
        get {
            return !((statusRegister & 0b0001000) == 0)
        }
        set {
            statusRegister = (statusRegister & ~0b00010000) | (((newValue == true) ? 1 : 0) << 3 & 0b00010000)
        }
    }
    
    /// Negative Flag
    /// See ATMega328p Datasheet Section 7.3.1.
    /// N is bit 2 on SREG.
    ///
    /// The Negative Flag N indicates a negative result in an arithmetic or logic operation. See the “Instruction Set Description” for detailed information.
    @inlinable
    @inline(__always)
    static var negativeFlag: Bool { //N
        get {
            return !((statusRegister & 0b00000100) == 0)
        }
        set {
            statusRegister = (statusRegister & ~0b00000100) | (((newValue == true) ? 1 : 0) << 2 & 0b00000100)
        }
    }
    
    /// Zero Flag
    /// See ATMega328p Datasheet Section 7.3.1.
    /// Z is bit 1 on SREG.
    ///
    /// The Zero Flag Z indicates a zero result in an arithmetic or logic operation. See the “Instruction Set Description” for detailed information.
    @inlinable
    @inline(__always)
    static var zeroFlag: Bool { //Z
        get {
            return !((statusRegister & 0b00000010) == 0)
        }
        set {
            statusRegister = (statusRegister & ~0b00000010) | (((newValue == true) ? 1 : 0) << 1 & 0b00000010)
        }
    }
    
    /// Carry Flag
    /// See ATMega328p Datasheet Section 7.3.1.
    /// C is bit 0 on SREG.
    ///
    /// The Carry Flag C indicates a carry in an arithmetic or logic operation. See the “Instruction Set Description” for detailed information.
    @inlinable
    @inline(__always)
    static var carryFlag: Bool { //C
        get {
            return !((statusRegister & 0b00000001) == 0)
        }
        set {
            statusRegister = (statusRegister & ~0b00000001) | ((newValue == true) ? 1 : 0 & 0b00000001)
        }
    }
}

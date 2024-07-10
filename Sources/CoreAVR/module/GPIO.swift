//===----------------------------------------------------------------------===//
//
// GPIO.swift
// Swift For Arduino
//
// Created by Carl Peto & Paul Shelley on 11/27/20.
// Copyright © 2020 Swift4Arduino. All rights reserved.
//
//===----------------------------------------------------------------------===//


// Note: The ATmega48A, ATmegaPA, ATmega88A, ATmegaPA, ATmega168A, ATmegaPA, ATmega328, and ATmega328P, are all pin compatible and have the same hardware features and the only differences are in memory space.
// The 328PB that has an additional UART, SPI, and I2C making a total of 2 each and comes in different package sizes.


// Thought:
// Should GPIO have a portB, then a five or something like that? Maybe just a function to set multiple bits in the same port at the same time for the data direction?
// This could be done currently Ex: GPIO.PORTB.dataDirection = 7, however what would be a good API design for simplifying and maing safe the setting of various bits at the same time? Maybe we need a .high, .low, and .unchainged?


// Note: The ATMegaN8 comes in 4 different packages, a 28 pin DIP, a 28 pin QFN, a 32 pin QFP, and a 23 pin QFN. The two 32 pin chips have extra pins and thus have two extra ADC pins (ADC6 and ADC7).
// See ATMega328p Datasheet Figure 1-1.
public struct GPIO { // TODO: I think I want to rename this struct to AVR5 or something similar. This will probably be the HAL layer for the avr5 core and I'll make a wrapper with a common HAL API that wraps this.

    public enum PORTB: Port {

        /// AKA: PORTB. See ATMega328p Datasheet section 14.4.2. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        // Note: Should we make an alias for this named PORTB for people that want to have "Direct Access" to ports? This is more important for registers that are used for
        // multiple things but could maintain naming consistancy.
        @inlinable
        @inline(__always)
        public static var dataRegister: UInt8 {
            get {
                return 0
//                _volatileRegisterReadUInt8(0x25)
            }
            set {
//                _volatileRegisterWriteUInt8(0x25, newValue)
            }
        }

        /// AKA: DDRB. See ATMega328p Datasheet section 14.4.3. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        @inlinable
        @inline(__always)
        public static var dataDirection: UInt8 {
            get {
                return 0
//                _volatileRegisterReadUInt8(0x24)
            }
            set {
//                _volatileRegisterWriteUInt8(0x24, newValue)
            }
        }

        /// AKA: PINB. See ATMega328p Datasheet section 14.4.4. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        @inlinable
        @inline(__always)
        public static var inputAddress: UInt8 {
            get {
                return 0
//                _volatileRegisterReadUInt8(0x23)
            }
            set {
//                _volatileRegisterWriteUInt8(0x23, newValue)
            }
        }
    }


    public enum PORTC: Port {

        /// AKA: PORTC. See ATMega328p Datasheet section 14.4.2. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        // Note: Should we make an alias for this named PORTC for people that want to have "Direct Access" to ports? This is more important for registers that are used for
        // multiple things but could maintain naming consistancy.
        @inlinable
        @inline(__always)
        public static var dataRegister: UInt8 {
            get {
                return 0
//                _volatileRegisterReadUInt8(0x28)
            }
            set {
//                _volatileRegisterWriteUInt8(0x28, newValue)
            }
        }

        /// AKA: DDRC. See ATMega328p Datasheet section 14.4.3. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        @inlinable
        @inline(__always)
        public static var dataDirection: UInt8 {
            get {
                return 0
//                _volatileRegisterReadUInt8(0x27)
            }
            set {
//                _volatileRegisterWriteUInt8(0x27, newValue)
            }
        }

        /// AKA: PINC. See ATMega328p Datasheet section 14.4.4. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        @inlinable
        @inline(__always)
        public static var inputAddress: UInt8 {
            get {
                return 0
//                _volatileRegisterReadUInt8(0x26)
            }
            set {
//                _volatileRegisterWriteUInt8(0x26, newValue)
            }
        }
    }


    public enum PORTD: Port {

        /// AKA: PORTD. See ATMega328p Datasheet section 14.4.2. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        // Note: Should we make an alias for this named PORTD for people that want to have "Direct Access" to ports? This is more important for registers that are used for
        // multiple things but could maintain naming consistancy.
        @inlinable
        @inline(__always)
        public static var dataRegister: UInt8 {
            get {
                return 0
//                _volatileRegisterReadUInt8(0x2B)
            }
            set {
//                _volatileRegisterWriteUInt8(0x2B, newValue)
            }
        }

        /// AKA: DDRD. See ATMega328p Datasheet section 14.4.3. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        @inlinable
        @inline(__always)
        public static var dataDirection: UInt8 {
            get {
                return 0
//                _volatileRegisterReadUInt8(0x2A)
            }
            set {
//                _volatileRegisterWriteUInt8(0x2A, newValue)
            }
        }

        /// AKA: PIND. See ATMega328p Datasheet section 14.4.4. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        @inlinable
        @inline(__always)
        public static var inputAddress: UInt8 {
            get {
                return 0
//                _volatileRegisterReadUInt8(0x29)
            }
            set {
//                _volatileRegisterWriteUInt8(0x29, newValue)
            }
        }
    }


//    // TODO: Physical Pins have more than one mode. We need a way to detect collisions as well as orginize the code with protocols or structs.
//    public enum pdip28 {
//        public typealias pin1 = pc6
//        public typealias pin2 = pd0
//        public typealias pin3 = pd1
//        public typealias pin4 = pd2
//        public typealias pin5 = pd3
//        public typealias pin6 = pd4
//        // pin7 = VCC
//        // pin8 = GND
//        public typealias pin9 = pb6
//        public typealias pin10 = pb7
//        public typealias pin11 = pd5
//        public typealias pin12 = pd6
//        public typealias pin13 = pd7
//        public typealias pin14 = pb0
//
//        public typealias pin15 = pb1
//        public typealias pin16 = pb2
//        public typealias pin17 = pb3
//        public typealias pin18 = pb4
//        public typealias pin19 = pb5
//        // pin20 AVCC
//        // pin21 AREF
//        // pin22 GND
//        public typealias pin23 = pc0
//        public typealias pin24 = pc1
//        public typealias pin25 = pc2
//        public typealias pin26 = pc3
//        public typealias pin27 = pc4
//        public typealias pin28 = pc5
//    }
//
//    public enum mlf28 {
//        public typealias pin1 = pd3
//        public typealias pin2 = pd4
//        // pin3 = VCC
//        // pin4 = GND
//        public typealias pin5 = pb6
//        public typealias pin6 = pb7
//        public typealias pin7 = pd5
//
//        public typealias pin8 = pd6
//        public typealias pin9 = pd7
//        public typealias pin10 = pb0
//        public typealias pin11 = pb1
//        public typealias pin12 = pb2
//        public typealias pin13 = pb3
//        public typealias pin14 = pb4
//
//        public typealias pin15 = pb5
//        // pin16 = AVCC
//        // pin17 = AREF
//        // pin18 = GND
//        public typealias pin19 = pc0
//        public typealias pin20 = pc1
//        public typealias pin21 = pc2
//
//        public typealias pin22 = pc3
//        public typealias pin23 = pc4
//        public typealias pin24 = pc5
//        public typealias pin25 = pc6
//        public typealias pin26 = pd0
//        public typealias pin27 = pd1
//        public typealias pin28 = pd2
//    }
//
//    public enum tqfp32 {
//        public typealias pin1 = pd3
//        public typealias pin2 = pd4
//        // pin3 = VCC
//        // pin4 = GND
//        // pin5 = VCC
//        // pin6 = GND
//        public typealias pin7 = pb6
//        public typealias pin8 = pb7
//
//        public typealias pin9 = pd5
//        public typealias pin10 = pd6
//        public typealias pin11 = pd7
//        public typealias pin12 = pb0
//        public typealias pin13 = pb1
//        public typealias pin14 = pb2
//        public typealias pin15 = pb3
//        public typealias pin16 = pb4
//
//        public typealias pin17 = pb5
//        // pin18 = AVCC
//        // pin19 = ADC6
//        // pin20 = AREF
//        // pin21 = GND
//        // pin22 = ADC7
//        public typealias pin23 = pc0
//        public typealias pin24 = pc1
//
//        public typealias pin25 = pc2
//        public typealias pin26 = pc3
//        public typealias pin27 = pc4
//        public typealias pin28 = pc5
//        public typealias pin29 = pc6
//        public typealias pin30 = pd0
//        public typealias pin31 = pd1
//        public typealias pin32 = pd2
//    }
//
//    public enum mlf32 {
//        public typealias pin1 = pd3
//        public typealias pin2 = pd4
//        // pin3 = VCC
//        // pin4 = GND
//        // pin5 = VCC
//        // pin6 = GND
//        public typealias pin7 = pb6
//        public typealias pin8 = pb7
//
//        public typealias pin9 = pd5
//        public typealias pin10 = pd6
//        public typealias pin11 = pd7
//        public typealias pin12 = pb0
//        public typealias pin13 = pb1
//        public typealias pin14 = pb2
//        public typealias pin15 = pb3
//        public typealias pin16 = pb4
//
//        public typealias pin17 = pb5
//        // pin18 = AVCC
//        // pin19 = ADC6
//        // pin20 = AREF
//        // pin21 = GND
//        // pin22 = ADC7
//        public typealias pin23 = pc0
//        public typealias pin24 = pc1
//
//        public typealias pin25 = pc2
//        public typealias pin26 = pc3
//        public typealias pin27 = pc4
//        public typealias pin28 = pc5
//        public typealias pin29 = pc6
//        public typealias pin30 = pd0
//        public typealias pin31 = pd1
//        public typealias pin32 = pd2
//    }


// NOTE: I was thinking of using a protocol if possible for this. So a pin could conform to both the 'Analog' and 'Digital' protocols.
// noodling on combined pins...
//    struct DigitAndAnalogPin {
//        var digital: DigitalPin<Port> { }
//        var pwm: PWMPin<Timer>  {}
//        ... other functions? ...
//    }
    
    
    // Generated version:
    /// PortB
    public typealias pb0 = DigitalPin<PORTB,Bit0>
    public typealias pb1 = DigitalPin<PORTB,Bit1>
    public typealias pb2 = DigitalPin<PORTB,Bit2>
    public typealias pb3 = DigitalPin<PORTB,Bit3>
    public typealias pb4 = DigitalPin<PORTB,Bit4>
    public typealias pb5 = DigitalPin<PORTB,Bit5>
    public typealias pb6 = DigitalPin<PORTB,Bit6>
    public typealias pb7 = DigitalPin<PORTB,Bit7>

    /// PortC
    public typealias pc0 = DigitalPin<PORTC,Bit0>
    public typealias pc1 = DigitalPin<PORTC,Bit1>
    public typealias pc2 = DigitalPin<PORTC,Bit2>
    public typealias pc3 = DigitalPin<PORTC,Bit3>
    public typealias pc4 = DigitalPin<PORTC,Bit4>
    public typealias pc5 = DigitalPin<PORTC,Bit5>
    public typealias pc6 = DigitalPin<PORTC,Bit6>

    /// PortD
    public typealias pd0 = DigitalPin<PORTD,Bit0>
    public typealias pd1 = DigitalPin<PORTD,Bit1>
    public typealias pd2 = DigitalPin<PORTD,Bit2>
    public typealias pd3 = DigitalPin<PORTD,Bit3>
    public typealias pd4 = DigitalPin<PORTD,Bit4>
    public typealias pd5 = DigitalPin<PORTD,Bit5>
    public typealias pd6 = DigitalPin<PORTD,Bit6>
    public typealias pd7 = DigitalPin<PORTD,Bit7>
    // End Generated version
    
    

//    /// See ATMega328p Datasheet section 14.4.2.
//    public typealias pb0 = DigitalPin<PortB,Bit0> // PCINT0/CLKO/ICP1
//    public typealias pb1 = DigitalPin<PortB,Bit1> // OC1A/PCINT1
//    
//    
//    public typealias pb2 = DigitalPin<PortB,Bit2> // SS/OC1B/PCINT2
//    public typealias oc1b = DigitalPin<PortB,Bit2> // Is this a good idea?
//    public typealias pcint2 = DigitalPin<PortB,Bit2> // Is this a good idea? 
//    
//    public typealias pb3 = DigitalPin<PortB,Bit3> // MOSI/OC2A/PCINT3
//    
//    // It would be nice to be able to refrence or set registers by their function (EX: MISO) and not need to look up which port to use
//    // for a given piece of hardware. This should also make code more interoperable making universal code possible. Adding a typealias
//    // here is one posibility but it might make sense to do this withing the SPI struct (for each SPI as there can be more than one).
//    // Putting these refrences in the SPI struct would probably be better for namespace and general legibility. Maybe there are other
//    // options that make more sense? Maybe this is not really needed at all?
//    public typealias spi0slaveSelect = DigitalPin<PortB,Bit2> // Is this a good idea?
//    public typealias spi0masterOutSlaveIn = DigitalPin<PortB,Bit3> // Is this a good idea?
//    public typealias spi0masterInSlaveOut = DigitalPin<PortB,Bit4> // Is this a good idea?
//    public typealias spi0Clock = DigitalPin<PortB,Bit5> // Is this a good idea?
//    
//    public typealias pb4 = DigitalPin<PortB,Bit4> // MISO/PCINT4
//    
//    
//    public typealias pb5 = DigitalPin<PortB,Bit5> // SCK/PCINT5
//    public typealias pb6 = DigitalPin<PortB,Bit6> // PCINT6/XTAL1/TOSC1
//    public typealias pb7 = DigitalPin<PortB,Bit7> // PCINT7/XTAL2/TOSC2
//
//    /// See ATMega328p Datasheet section 14.4.5.
//    public typealias pc0 = DigitalPin<PortC,Bit0> // ADC0/PCINT8
//    public typealias pc1 = DigitalPin<PortC,Bit1> // ADC1/PCINT9
//    public typealias pc2 = DigitalPin<PortC,Bit2> // ADC2/PCINT10
//    public typealias pc3 = DigitalPin<PortC,Bit3> // ADC3/PCINT11
//    public typealias pc4 = DigitalPin<PortC,Bit4> // ADC4/SDA/PCINT12
//    public typealias pc5 = DigitalPin<PortC,Bit5> // ADC5/SCL/PCINT13
//    public typealias pc6 = DigitalPin<PortC,Bit6> // PCINT14/RESET
//    // Note: Port C does not use the 7th bit. See the Datasheet 14.4.5.
//
//    /// See ATMega328p Datasheet section 14.4.8.
//    public typealias pd0 = DigitalPin<PortD,Bit0> // PCINT16/RXD
//    public typealias pd1 = DigitalPin<PortD,Bit1> // PCINT17/TXD
//    public typealias pd2 = DigitalPin<PortD,Bit2> // PCINT18/INT0
//    public typealias pd3 = DigitalPin<PortD,Bit3> // PCINT19/OC2B/INT1
//    public typealias pd4 = DigitalPin<PortD,Bit4> // PCINT20/XCK/T0
//    public typealias pd5 = DigitalPin<PortD,Bit5> // PCINT21/OC0B/T1
//    public typealias pd6 = DigitalPin<PortD,Bit6> // PCINT22/OC0A/AIN0
//    public typealias pd7 = DigitalPin<PortD,Bit7> // PCINT23/AIN1


    
}



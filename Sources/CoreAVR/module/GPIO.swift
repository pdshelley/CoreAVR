// Note: The ATMegaN8 comes in 4 different packages, a 28 pin DIP, a 28 pin QFN, a 32 pin QFP, and a 23 pin QFN. The two 32 pin chips have extra pins and thus have two extra ADC pins (ADC6 and ADC7).
// See ATMega328p Datasheet Figure 1-1.
public struct GPIO { // TODO: I think I want to rename this struct to AVR5 or something similar. This will probably be the HAL layer for the avr5 core and I'll make a wrapper with a common HAL API that wraps this.

    /// AKA: MCUCR. See ATMega328p Datasheet section 14.4.1. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
    @inlinable
    @inline(__always)
    public static var mcuControlRegister: UInt8 {
        get {
            _volatileRegisterReadUInt8(0x55)
        }
        set {
            _volatileRegisterWriteUInt8(0x55, newValue)
        }
    }

    public enum PORTB: Port {

        /// AKA: PORTB. See ATMega328p Datasheet section 14.4.2. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        // Note: Should we make an alias for this named PORTB for people that want to have "Direct Access" to ports? This is more important for registers that are used for
        // multiple things but could maintain naming consistancy.
        @inlinable
        @inline(__always)
        public static var dataRegister: UInt8 {
            get {
                _volatileRegisterReadUInt8(0x25)
            }
            set {
                _volatileRegisterWriteUInt8(0x25, newValue)
            }
        }

        /// AKA: DDRB. See ATMega328p Datasheet section 14.4.3. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        @inlinable
        @inline(__always)
        public static var dataDirection: UInt8 {
            get {
                _volatileRegisterReadUInt8(0x24)
            }
            set {
                _volatileRegisterWriteUInt8(0x24, newValue)
            }
        }

        /// AKA: PINB. See ATMega328p Datasheet section 14.4.4. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        @inlinable
        @inline(__always)
        public static var inputAddress: UInt8 {
            get {
                _volatileRegisterReadUInt8(0x23)
            }
            set {
                _volatileRegisterWriteUInt8(0x23, newValue)
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
                _volatileRegisterReadUInt8(0x28)
            }
            set {
                _volatileRegisterWriteUInt8(0x28, newValue)
            }
        }

        /// AKA: DDRC. See ATMega328p Datasheet section 14.4.3. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        @inlinable
        @inline(__always)
        public static var dataDirection: UInt8 {
            get {
                _volatileRegisterReadUInt8(0x27)
            }
            set {
                _volatileRegisterWriteUInt8(0x27, newValue)
            }
        }

        /// AKA: PINC. See ATMega328p Datasheet section 14.4.4. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        @inlinable
        @inline(__always)
        public static var inputAddress: UInt8 {
            get {
                _volatileRegisterReadUInt8(0x26)
            }
            set {
                _volatileRegisterWriteUInt8(0x26, newValue)
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
                _volatileRegisterReadUInt8(0x2B)
            }
            set {
                _volatileRegisterWriteUInt8(0x2B, newValue)
            }
        }

        /// AKA: DDRD. See ATMega328p Datasheet section 14.4.3. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        @inlinable
        @inline(__always)
        public static var dataDirection: UInt8 {
            get {
                _volatileRegisterReadUInt8(0x2A)
            }
            set {
                _volatileRegisterWriteUInt8(0x2A, newValue)
            }
        }

        /// AKA: PIND. See ATMega328p Datasheet section 14.4.4. // TODO: How should we make the Datasheet refrence more generic? Include more of this documentation directly in the code?
        @inlinable
        @inline(__always)
        public static var inputAddress: UInt8 {
            get {
                _volatileRegisterReadUInt8(0x29)
            }
            set {
                _volatileRegisterWriteUInt8(0x29, newValue)
            }
        }
    }

    /// PORTB
    public typealias pb0 = DigitalPin<PORTB, Bit0>
    public typealias pb1 = DigitalPin<PORTB, Bit1>
    public typealias pb2 = DigitalPin<PORTB, Bit2>
    public typealias pb3 = DigitalPin<PORTB, Bit3>
    public typealias pb4 = DigitalPin<PORTB, Bit4>
    public typealias pb5 = DigitalPin<PORTB, Bit5>
    public typealias pb6 = DigitalPin<PORTB, Bit6>
    public typealias pb7 = DigitalPin<PORTB, Bit7>

    /// PORTC
    public typealias pc0 = DigitalPin<PORTC, Bit0>
    public typealias pc1 = DigitalPin<PORTC, Bit1>
    public typealias pc2 = DigitalPin<PORTC, Bit2>
    public typealias pc3 = DigitalPin<PORTC, Bit3>
    public typealias pc4 = DigitalPin<PORTC, Bit4>
    public typealias pc5 = DigitalPin<PORTC, Bit5>
    public typealias pc6 = DigitalPin<PORTC, Bit6>

    /// PORTD
    public typealias pd0 = DigitalPin<PORTD, Bit0>
    public typealias pd1 = DigitalPin<PORTD, Bit1>
    public typealias pd2 = DigitalPin<PORTD, Bit2>
    public typealias pd3 = DigitalPin<PORTD, Bit3>
    public typealias pd4 = DigitalPin<PORTD, Bit4>
    public typealias pd5 = DigitalPin<PORTD, Bit5>
    public typealias pd6 = DigitalPin<PORTD, Bit6>
    public typealias pd7 = DigitalPin<PORTD, Bit7>


}
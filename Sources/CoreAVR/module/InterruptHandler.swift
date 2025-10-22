//
//  InterruptHandler.swift
//  CoreAVR
//
//  Created by TheAlgorithm476 on 2025-10-22.
//

public struct InterruptHandler {
    // MARK: UART
    // Thoughts: Based on the datasheet, it is possible to disable UART-related Interrupts, by setting the RXCIEn, TXCIEn, and UDRIEn bits in UCSRnB to 0.
    // For now, I have added a `disableUARTInterrupts` function that sets these bits.
    // I've also added `enableUARTInterrupts` that does the opposite.
    
    @inlinable
    @inline(__always)
    public static func disableUARTInterrupts() {
        UART0.dataRegisterEmptyInterruptEnable = .off
        UART0.txCompleteInterruptEnable = .off
        UART0.rxCompleteInterruptEnable = .off
    }
    
    @inlinable
    @inline(__always)
    public static func enableUARTInterrupts() {
        UART0.dataRegisterEmptyInterruptEnable = .on
        UART0.txCompleteInterruptEnable = .on
        UART0.rxCompleteInterruptEnable = .on
    }
    
    /// Datasheet Section 20.7.3 - Receive Complete Flag and Interrupt
    /// Handler for USART\_RX - USART Rx Complete Interrupt.
    ///
    /// When the Receive Complete Interrupt Enable (RXCIEn) in UCSRnB is set, the USART Receive Complete
    /// interrupt will be executed as long as the RXCn Flag is set (provided that global interrupts are enabled). When
    /// interrupt-driven data reception is used, the receive complete routine must read the received data from UDRn in
    /// order to clear the RXCn Flag, otherwise a new interrupt will occur once the interrupt routine terminates.
    @inlinable
    @inline(__always)
    public static func handleUSARTRxComplete() {} // TODO: Provide an implementation for this stub.

    /// Datasheet Section 20.6.3 - Transmitter Flags and Interrupts
    /// Handler for USART\_UDRE - USART Data Register Empty Interrupt.
    ///
    /// When the Data Register Empty Interrupt Enable (UDRIEn) bit in UCSRnB is written to one, the USART Data
    /// Register Empty Interrupt will be executed as long as UDREn is set (provided that global interrupts are enabled).
    /// UDREn is cleared by writing UDRn. When interrupt-driven data transmission is used, the Data Register Empty
    /// interrupt routine must either write new data to UDRn in order to clear UDREn or disable the Data Register
    /// Empty interrupt, otherwise a new interrupt will occur once the interrupt routine terminates.
    @inlinable
    @inline(__always)
    public static func handleUSARTDataRegisterEmpty() {} // TODO: Provide an implementation for this stub.

    /// Datasheet Section 20.6.3 - Transmitter Flags and Interrupts
    /// Handler for USART\_TX - USART Tx Complete Interrupt.
    ///
    /// When the Transmit Compete Interrupt Enable (TXCIEn) bit in UCSRnB is set, the USART Transmit Complete
    /// Interrupt will be executed when the TXCn Flag becomes set (provided that global interrupts are enabled). When
    /// the transmit complete interrupt is used, the interrupt handling routine does not have to clear the TXCn Flag, this
    /// is done automatically when the interrupt is executed.
    @inlinable
    @inline(__always)
    public static func handleUSARTTxComplete() {} // TODO: Provide an implementation for this stub.
}

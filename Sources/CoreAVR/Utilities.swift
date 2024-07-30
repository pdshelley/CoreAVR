//===----------------------------------------------------------------------===//
//
// HAL_utils.swift
// Swift For Arduino
//
// Created by Carl Peto & Paul Shelley on 11/27/20.
// Copyright © 2020 Swift4Arduino. All rights reserved.
//
//===----------------------------------------------------------------------===//

//import libc
//
//// I think we probably want to expose the delay loops to Swift.
//public func delayLoop2(_ n: UInt16) {
//    _delay_loop_2(n)
//}
//
//public func delayLoop1(_ n: UInt8) {
//    _delay_loop_1(n)
//}
//
//// Note: Should this be removed? Useful for testing a simple blink. 
//public func waitOneSecond() {
//    for _ in 0..<64 {
//        delayLoop2(0)
//    }
//}

@inlinable
@inline(__always)
public func noOpperation() { // TODO: Figure out why this is not inlining in the assembly.
    _noOpperation()
}

//public func noInterrupts() {
//    cli()
//    }

//
//// Note: This will be removed but is here for testing
//func block(for seconds: UInt8) {
//    let adjusted = seconds * 32
//    for _ in 0..<adjusted {
//        _delay_loop_2(0)
//    }
//}
//
//// Note: Made for testing purpose
//func delayMilliSeconds(ms: UInt64) {
//    let adjusted = ms/1000 * 32
//    for _ in 0..<adjusted {
//        _delay_loop_2(0)
//    }
//}
//
//// Note: Made for testing purpose
//func delayMicroSeconds(us: UInt64) {
//    let adjusted = us/1000000 * 32
//    for _ in 0..<adjusted {
//        _delay_loop_2(0)
//    }
//}

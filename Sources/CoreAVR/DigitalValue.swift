//===----------------------------------------------------------------------===//
//
// DigitalValue.swift
// Swift For Arduino
//
// Created by Paul Shelley on 11/30/20.
// Copyright © 2020 Paul Shelley. All rights reserved.
//
//===----------------------------------------------------------------------===//
//===----------------------------------------------------------------------===//
// DigitalValue Datatype and Supporting Operators
//===----------------------------------------------------------------------===//


// TODO: When changing from INPUT without pull-ups to OUPUT HIGH, there must be an intermediate state: Either pull-ups enabled or OUTPUT LOW. See Datasheet 14.2.3.
@frozen
public struct DigitalValue {
    public var _value: Bool

    @_transparent
    public init(_ _value: Bool) {
        self._value = _value
    }

    @inlinable
    @inline(__always)
    public static var high: DigitalValue { DigitalValue(true) }

    @inlinable
    @inline(__always)
    public static var low: DigitalValue { DigitalValue(false) }
}

// TODO: Do This
//extension DigitalValue: CustomStringConvertible {
//  /// A textual representation of the DigitalValue.
//  @inlinable
//  public var description: String {
//    return self ? "high" : "low"
//  }
//}

extension DigitalValue: Equatable {
    @inlinable
    @inline(__always)
    public static func == (lhs: DigitalValue, rhs: DigitalValue) -> Bool {
        return lhs._value == rhs._value
    }
}

extension DigitalValue: Hashable {
    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    @inlinable
    @inline(__always)
    public func hash(into hasher: inout Hasher) {
        hasher.combine((self._value ? 1 : 0) as UInt8)
    }
}

////===----------------------------------------------------------------------===//
//// Operators
////===----------------------------------------------------------------------===//
extension DigitalValue {
  /// Performs a logical NOT operation on a DigitalValue.
  ///
  /// The logical NOT operator (`!`) inverts a DigitalValue. If the value is
  /// `high`, the result of the operation is `low`; if the value is `low`,
  /// the result is `high`.
  ///
  /// - Parameter a: The DigitalValue to negate.
  @inlinable
  @inline(__always)
  public static prefix func ! (lhs: DigitalValue) -> DigitalValue { DigitalValue(!lhs._value) }
}

extension DigitalValue {
  /// Performs a logical AND operation on two DigitalValues.
  ///
  /// The logical AND operator (`&&`) combines two DigitalValues and returns
  /// `high` if both of the values are `high`. If either of the values is
  /// `low`, the operator returns `low`.
  ///
  /// - Parameters:
  ///   - lhs: The left-hand side of the operation.
  ///   - rhs: The right-hand side of the operation.
  @inlinable
  @inline(__always)
  public static func && (lhs: DigitalValue, rhs: DigitalValue) -> DigitalValue {
        return DigitalValue(lhs._value && rhs._value)
  }

  /// Performs a logical OR operation on two DigitalValues.
  ///
  /// The logical OR operator (`||`) combines two DigitalValues and returns
  /// `high` if at least one of the values is `high`. If both values are
  /// `low`, the operator returns `low`.
  ///
  /// - Parameters:
  ///   - lhs: The left-hand side of the operation.
  ///   - rhs: The right-hand side of the operation.
  @inlinable
  @inline(__always)
  public static func || (lhs: DigitalValue, rhs: DigitalValue) -> DigitalValue {
      return DigitalValue(lhs._value || rhs._value)
  }
}

extension DigitalValue {
  /// Toggles the DigitalValue.
  ///
  /// Use this method to toggle a DigitalValue from `high` to `low` or from
  /// `low` to `high`.
  @inlinable
  @inline(__always)
  public mutating func toggle() { self._value = !self._value }
}


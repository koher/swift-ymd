public struct Year: RawRepresentable {
    public var rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public init(_ years: Int) {
        self.init(rawValue: years)
    }
}

extension Year {
    public var isLeapYear: Bool {
        guard rawValue.isMultiple(of: 4) else { return false }
        guard rawValue.isMultiple(of: 100) else { return true}
        guard rawValue.isMultiple(of: 400) else { return false}
        return true
    }
    
    public var numberOfDays: Int {
        isLeapYear ? 366 : 365
    }
}

extension Year: Equatable, Comparable, Hashable {
    public static func < (lhs: Year, rhs: Year) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

extension Year: Strideable {
    public func distance(to other: Year) -> Int {
        other.rawValue - self.rawValue
    }
    
    public func advanced(by n: Int) -> Year {
        self + Year(n)
    }
}

extension Year: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Int.self)
        self.init(value)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

extension Year: CustomStringConvertible {
    public var description: String {
        rawValue.description
    }
}

extension Year: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(rawValue: value)
    }
}

extension Year: Sendable {}

extension Year {
    public static func + (lhs: Year, rhs: Year) -> Year {
        .init(rawValue: lhs.rawValue + rhs.rawValue)
    }
    
    public static func += (lhs: inout Year, rhs: Year) {
        lhs = lhs + rhs
    }
    
    public static func - (lhs: Year, rhs: Year) -> Year {
        lhs + -rhs
    }
    
    public static func -= (lhs: inout Year, rhs: Year) {
        lhs = lhs - rhs
    }
    
    public static prefix func - (value: Year) -> Year {
        .init(rawValue: -value.rawValue)
    }
}

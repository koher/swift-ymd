import Foundation

public struct YM {
    public var year: Year
    public var month: Month
    
    public init(_ year: Year, _ month: Month) {
        self.year = year
        self.month = month
    }
}

extension YM {
    public var days: ClosedRange<Int> { 1 ... numberOfDays }
    
    public var ymds: ClosedRange<YMD> { YMD(year, month, 1)! ... YMD(year, month, numberOfDays)! }
    
    public var numberOfDays: Int {
        switch month {
        case .january:
            return 31
        case .february:
            return year.isLeapYear ? 29 : 28
        case .march:
            return 31
        case .april:
            return 30
        case .may:
            return 31
        case .june:
            return 30
        case .july:
            return 31
        case .august:
            return 31
        case .september:
            return 30
        case .october:
            return 31
        case .november:
            return 30
        case .december:
            return 31
        }
    }
}

extension YM: Equatable, Comparable, Hashable {
    public static func < (lhs: YM, rhs: YM) -> Bool {
        if lhs.year < rhs.year { return true }
        else if lhs.year > rhs.year { return false }
        else { return lhs.month < rhs.month }
    }
}

extension YM: Strideable {
    public typealias Stride = Int
    
    public func distance(to other: YM) -> Int {
        (other.year.rawValue - self.year.rawValue) * 12 + (other.month.rawValue - self.month.rawValue)
    }
    
    public func advanced(by n: Int) -> YM {
        self + .months(n)
    }
}

extension YM: CustomStringConvertible {
    public var description: String {
        if month < .october {
            return "\(year)-0\(month.rawValue)"
        } else {
            return "\(year)-\(month.rawValue)"
        }
    }
}

extension YM {
    public static func + (lhs: YM, rhs: YMInterval) -> YM {
        switch rhs {
        case .years(let years):
            return YM(lhs.year + Year(years), lhs.month)
        case .months(let months):
            var month = lhs.month.rawValue + months
            month -= 1
            var year = lhs.year.rawValue + month / 12
            month %= 12
            if month < 0 {
                month += 12
                year -= 1
            }
            month += 1
            return YM(Year(year), Month(rawValue: month)!)
        }
    }
    
    public static func += (lhs: inout YM, rhs: YMInterval) {
        lhs = lhs + rhs
    }

    public static func - (lhs: YM, rhs: YMInterval) -> YM {
        lhs + -rhs
    }
    
    public static func -= (lhs: inout YM, rhs: YMInterval) {
        lhs = lhs - rhs
    }
}

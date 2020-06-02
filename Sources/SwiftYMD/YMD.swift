public struct YMD {
    public private(set) var year: Year
    public private(set) var month: Month
    public private(set) var day: Int
    
    public init?(_ year: Year, _ month: Month, _ day: Int) {
        guard YM(year, month).days.contains(day) else { return nil }
        self.year = year
        self.month = month
        self.day = day
    }
}

extension YMD {
    public var ym: YM { YM(year, month) }
    
    public var dayOfYear: Int {
        var days = 0
        for ym in YM(year, .january) ..< self.ym {
            days += ym.numberOfDays
        }
        days += day
        return days
    }
    
    public var dayOfWeak: DayOfWeek {
        let days = YMD(2019, 12, 8)!.distance(to: self)
        var dayIndex = days % 7
        if dayIndex < 0 { dayIndex += 7}
        return DayOfWeek(rawValue: dayIndex)!
    }
}

extension YMD: Equatable, Comparable, Hashable {
    public static func < (lhs: YMD, rhs: YMD) -> Bool {
        if lhs.ym < rhs.ym { return true }
        else if lhs.ym > rhs.ym { return false }
        else { return lhs.day < rhs.day }
    }
}

extension YMD: Strideable {
    public func distance(to other: YMD) -> Int {
        if self > other { return -other.distance(to: self) }
        
        var days = 0
        for year in self.year ..< other.year {
            days += year.numberOfDays
        }
        days += other.dayOfYear
        days -= self.dayOfYear
        
        return days
    }
    
    public func advanced(by n: Int) -> YMD {
        self + .days(n)
    }
}

extension YMD: CustomStringConvertible {
    public var description: String {
        if day < 10 {
            return "\(ym)-0\(day)"
        } else {
            return "\(ym)-\(day)"
        }
    }
}

extension YMD {
    public static func + (lhs: YMD, rhs: YMDInterval) -> YMD {
        switch rhs {
        case .years(let years):
            let ym = lhs.ym + .years(years)
            return YMD(ym.year, ym.month, lhs.day) ?? ym.ymds.last! // `??` for 29th Feb.
        case .months(let months):
            let ym = lhs.ym + .months(months)
            return YMD(ym.year, ym.month, lhs.day) ?? ym.ymds.last!
        case .days(var days):
            let ymd = lhs
            if days < 0 {
                var days = -days
                if days < ymd.day {
                    return YMD(ymd.year, ymd.month, ymd.day - days)!
                }
                days -= ymd.day
                
                var ym = ymd.ym - .months(1)
                while ym.month != .december {
                    if days < ym.numberOfDays {
                        return YMD(ym.year, ym.month, ym.numberOfDays - days)!
                    }
                    days -= ym.numberOfDays
                    ym -= .months(1)
                }
                
                var y = ym.year
                while days >= y.numberOfDays {
                    days -= y.numberOfDays
                    y -= 1
                }
                
                ym = YM(y, .december)
                while days >= ym.numberOfDays {
                    days -= ym.numberOfDays
                    ym -= .months(1)
                }
                
                return YMD(ym.year, ym.month, ym.numberOfDays - days)!
            } else {
                let daysLeftInMonth = ymd.ym.numberOfDays - ymd.day + 1
                if days < daysLeftInMonth {
                    return YMD(ymd.year, ymd.month, ymd.day + days)!
                }
                days -= daysLeftInMonth
                
                var ym = ymd.ym + .months(1)
                while ym.month != .january {
                    if days < ym.numberOfDays {
                        return YMD(ym.year, ym.month, days + 1)!
                    }
                    days -= ym.numberOfDays
                    ym += .months(1)
                }
                
                var y = ym.year
                while days >= y.numberOfDays {
                    days -= y.numberOfDays
                    y += 1
                }

                ym = YM(y, .january)
                while days >= ym.numberOfDays {
                    days -= ym.numberOfDays
                    ym += .months(1)
                }
                
                return YMD(ym.year, ym.month, days + 1)!
            }
        case .weeks(let weeks):
            return lhs + .days(weeks * 7)
        }
    }
    
    public static func += (lhs: inout YMD, rhs: YMDInterval) {
        lhs = lhs + rhs
    }

    public static func - (lhs: YMD, rhs: YMDInterval) -> YMD {
        lhs + -rhs
    }
    
    public static func -= (lhs: inout YMD, rhs: YMDInterval) {
        lhs = lhs - rhs
    }
    
    public static func - (lhs: YMD, rhs: YMD) -> Int {
        rhs.distance(to: lhs)
    }
}

// FIXME: Replace this with tuples when SE-0283 is available.
private struct MD: Comparable {
    var month: Month
    var day: Int
    
    init(_ month: Month, _ day: Int) {
        self.month = month
        self.day = day
    }
    
    static func < (lhs: MD, rhs: MD) -> Bool {
        if lhs.month < rhs.month { return true }
        else if lhs.month > rhs.month { return false }
        else { return lhs.day < rhs.day }
    }
}

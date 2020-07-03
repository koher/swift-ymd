import Foundation

extension YM {
    public init(_ date: Date, timeZone: TimeZone = .current) {
        let calendar: Calendar = .current
        let components = calendar.dateComponents(in: timeZone, from: date)
        guard
            let y = components.year,
            let m = components.month,
            let month = Month(rawValue: m)
        else {
            fatalError("Never reaches here.")
        }
        self.init(Year(y), month)
    }
    
    public static func current() -> YM {
        YM(Date())
    }
}

extension YMD {
    public init(_ date: Date, timeZone: TimeZone = .current) {
        let calendar: Calendar = .current
        let components = calendar.dateComponents(in: timeZone, from: date)
        guard
            let y = components.year,
            let m = components.month,
            let month = Month(rawValue: m),
            let day = components.day,
            let ymd = YMD(Year(y), month, day)
        else {
            fatalError("Never reaches here.")
        }
        self = ymd
    }
    
    public static func current() -> YMD {
        YMD(Date())
    }
}

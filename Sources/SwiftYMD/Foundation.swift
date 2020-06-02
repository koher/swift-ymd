import Foundation

extension YM {
    public static func current() -> YM {
        let date: Date = .init()
        let calendar: Calendar = .current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        return YM(Year(year), Month(rawValue: month)!)
    }
}

extension YMD {
    public static func current() -> YMD {
        let date: Date = .init()
        let calendar: Calendar = .current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        return YMD(Year(year), Month(rawValue: month)!, day)!
    }
}

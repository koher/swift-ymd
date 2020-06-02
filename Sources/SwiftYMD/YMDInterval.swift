public enum YMDInterval {
    case years(Int)
    case months(Int)
    case days(Int)
    case weeks(Int)
}

extension YMDInterval {
    public static prefix func + (value: YMDInterval) -> YMDInterval {
        value
    }

    public static prefix func - (value: YMDInterval) -> YMDInterval {
        switch value {
        case .years(let years):
            return .years(-years)
        case .months(let months):
            return .months(-months)
        case .days(let days):
            return .days(-days)
        case .weeks(let weeks):
            return .weeks(-weeks)
        }
    }
}

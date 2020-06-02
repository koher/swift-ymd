public enum YMInterval {
    case years(Int)
    case months(Int)
}

extension YMInterval {
    public static prefix func + (value: YMInterval) -> YMInterval {
        value
    }
    
    public static prefix func - (value: YMInterval) -> YMInterval {
        switch value {
        case .years(let years):
            return .years(-years)
        case .months(let months):
            return .months(-months)
        }
    }
}

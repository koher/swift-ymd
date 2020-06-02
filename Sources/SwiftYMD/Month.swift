public enum Month: Int, CaseIterable {
    case january   = 1
    case february  = 2
    case march     = 3
    case april     = 4
    case may       = 5
    case june      = 6
    case july      = 7
    case august    = 8
    case september = 9
    case october   = 10
    case november  = 11
    case december  = 12
}

extension Month: Equatable, Comparable, Hashable {
    public static func < (lhs: Month, rhs: Month) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

extension Month: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(rawValue: value)!
    }
}

extension Month: CustomStringConvertible {
    public var description: String {
        switch self {
        case .january:   return "January"
        case .february:  return "February"
        case .march:     return "March"
        case .april:     return "April"
        case .may:       return "May"
        case .june:      return "June"
        case .july:      return "July"
        case .august:    return "August"
        case .september: return "September"
        case .october:   return "October"
        case .november:  return "November"
        case .december:  return "December"
        }
    }
}

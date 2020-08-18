import XCTest
import SwiftYMD
import Foundation

class FoundationTests: XCTestCase {
    // It rarely fails when the date changes during its execution
    func testCurrent() {
        let date: Date = .init()
        let calendar: Calendar = .init(identifier: .gregorian)
        
        let ym: YM = .current()
        XCTAssertEqual(ym.year.rawValue, calendar.component(.year, from: date))
        XCTAssertEqual(ym.month.rawValue, calendar.component(.month, from: date))
        
        let ymd: YMD = .current()
        XCTAssertEqual(ymd.year.rawValue, calendar.component(.year, from: date))
        XCTAssertEqual(ymd.month.rawValue, calendar.component(.month, from: date))
        XCTAssertEqual(ymd.day, calendar.component(.day, from: date))
    }
}

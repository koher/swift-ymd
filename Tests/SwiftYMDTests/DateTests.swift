import XCTest
import SwiftYMD
import Foundation

final class DateTests: XCTestCase {
    func testYMInit() {
        let date: Date = Date(timeIntervalSinceReferenceDate: 0)
        XCTAssertEqual(YM(date, timeZone: TimeZone(abbreviation: "GMT")!), YM(2001, 1))
        XCTAssertEqual(YM(date, timeZone: TimeZone(abbreviation: "JST")!), YM(2001, 1))
        XCTAssertEqual(YM(date, timeZone: TimeZone(abbreviation: "PST")!), YM(2000, 12))
    }
    
    func testYMDInit() {
        let date: Date = Date(timeIntervalSinceReferenceDate: 0)
        XCTAssertEqual(YMD(date, timeZone: TimeZone(abbreviation: "GMT")!), YMD(2001, 1, 1)!)
        XCTAssertEqual(YMD(date, timeZone: TimeZone(abbreviation: "JST")!), YMD(2001, 1, 1)!)
        XCTAssertEqual(YMD(date, timeZone: TimeZone(abbreviation: "PST")!), YMD(2000, 12, 31)!)
    }
    
    func testDateInit() {
        XCTAssertEqual(Date(YM(2001, 1), timeZone: TimeZone(abbreviation: "GMT")!), Date(timeIntervalSinceReferenceDate: 0))
        XCTAssertEqual(Date(YMD(2001, 1, 1)!, timeZone: TimeZone(abbreviation: "GMT")!), Date(timeIntervalSinceReferenceDate: 0))
    }
}

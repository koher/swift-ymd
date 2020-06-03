import XCTest
import SwiftYMD

class YearTests: XCTestCase {
    func testIsLeapYear() {
        XCTAssertFalse((1995 as Year).isLeapYear)
        XCTAssertTrue((1996 as Year).isLeapYear)
        XCTAssertFalse((1997 as Year).isLeapYear)
        XCTAssertFalse((1998 as Year).isLeapYear)
        XCTAssertFalse((1999 as Year).isLeapYear)
        XCTAssertTrue((2000 as Year).isLeapYear)
        XCTAssertFalse((2001 as Year).isLeapYear)
        XCTAssertFalse((2002 as Year).isLeapYear)
        XCTAssertFalse((2003 as Year).isLeapYear)
        XCTAssertTrue((2004 as Year).isLeapYear)
        XCTAssertFalse((2005 as Year).isLeapYear)

        XCTAssertFalse((2095 as Year).isLeapYear)
        XCTAssertTrue((2096 as Year).isLeapYear)
        XCTAssertFalse((2097 as Year).isLeapYear)
        XCTAssertFalse((2098 as Year).isLeapYear)
        XCTAssertFalse((2099 as Year).isLeapYear)
        XCTAssertFalse((2100 as Year).isLeapYear)
        XCTAssertFalse((2101 as Year).isLeapYear)
        XCTAssertFalse((2102 as Year).isLeapYear)
        XCTAssertFalse((2103 as Year).isLeapYear)
        XCTAssertTrue((2104 as Year).isLeapYear)
        XCTAssertFalse((2105 as Year).isLeapYear)
    }
    
    func testNumberOfDays() {
        XCTAssertEqual((1995 as Year).numberOfDays, 365)
        XCTAssertEqual((1996 as Year).numberOfDays, 366)
        XCTAssertEqual((1997 as Year).numberOfDays, 365)
        XCTAssertEqual((1998 as Year).numberOfDays, 365)
        XCTAssertEqual((1999 as Year).numberOfDays, 365)
        XCTAssertEqual((2000 as Year).numberOfDays, 366)
        XCTAssertEqual((2001 as Year).numberOfDays, 365)
        XCTAssertEqual((2002 as Year).numberOfDays, 365)
        XCTAssertEqual((2003 as Year).numberOfDays, 365)
        XCTAssertEqual((2004 as Year).numberOfDays, 366)
        XCTAssertEqual((2005 as Year).numberOfDays, 365)
        
        XCTAssertEqual((2095 as Year).numberOfDays, 365)
        XCTAssertEqual((2096 as Year).numberOfDays, 366)
        XCTAssertEqual((2097 as Year).numberOfDays, 365)
        XCTAssertEqual((2098 as Year).numberOfDays, 365)
        XCTAssertEqual((2099 as Year).numberOfDays, 365)
        XCTAssertEqual((2100 as Year).numberOfDays, 365)
        XCTAssertEqual((2101 as Year).numberOfDays, 365)
        XCTAssertEqual((2102 as Year).numberOfDays, 365)
        XCTAssertEqual((2103 as Year).numberOfDays, 365)
        XCTAssertEqual((2104 as Year).numberOfDays, 366)
        XCTAssertEqual((2105 as Year).numberOfDays, 365)
    }
    
    func testCodable() {
        do { // encoding
            let year: Year = 1988
            let data: Data = try JSONEncoder().encode(year)
            XCTAssertEqual(String(data: data, encoding: .utf8)!, "1988")
        } catch {
            XCTFail("\(error)")
        }
        
        do { // decoding
            let data: Data = "1988".data(using: .utf8)!
            let year: Year = try JSONDecoder().decode(Year.self, from: data)
            XCTAssertEqual(year, 1988)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testOperators() {
        XCTAssertEqual((1988 as Year) + (31 as Year), (2019 as Year))
        do {
            var year: Year = 1988
            year += 31
            XCTAssertEqual(year, 2019)
        }
        
        XCTAssertEqual((2019 as Year) - (31 as Year), (1988 as Year))
        do {
            var year: Year = 2019
            year -= 31
            XCTAssertEqual(year, 1988)
        }
    }
}

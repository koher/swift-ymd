import XCTest
import SwiftYMD

class YMDTests: XCTestCase {
    func testInit() {
        XCTAssertEqual(YMD(1988 as Int, 12 as Int, 3 as Int)!, YMD(Year(1988), .december, 3)!)
        XCTAssertEqual(YMD("1988-12-03")!, YMD(1988, 12, 3)!)
        XCTAssertNil(YMD("2019-13-01"))
        
        XCTAssertNil(YMD(2019, 2, 29))
        XCTAssertEqual(YMD(2020, 2, 29)?.description, "2020-02-29")
    }
    
    func testDayOfWeek() {
        XCTAssertEqual(YMD(1988, 12, 3)!.dayOfWeek, .saturday)
        XCTAssertEqual(YMD(2019, 12, 12)!.dayOfWeek, .thursday)
    }
    
    func testComparable() {
        var values: [YMD] = [
            YMD(1999, 12, 31)!,
            YMD(2000, 3, 1)!,
            YMD(1900, 12, 31)!,
            YMD(2000, 1, 1)!,
            YMD(1999, 12, 30)!,
            YMD(2000, 2, 1)!,
            YMD(2100, 1, 1)!,
            YMD(2000, 1, 2)!,
            YMD(1999, 12, 31)!,
            YMD(2000, 1, 3)!,
            YMD(2000, 2, 28)!,
            YMD(2000, 2, 29)!,
        ]
        values.sort()
        XCTAssertEqual(values, [
            YMD(1900, 12, 31)!,
            YMD(1999, 12, 30)!,
            YMD(1999, 12, 31)!,
            YMD(1999, 12, 31)!,
            YMD(2000, 1, 1)!,
            YMD(2000, 1, 2)!,
            YMD(2000, 1, 3)!,
            YMD(2000, 2, 1)!,
            YMD(2000, 2, 28)!,
            YMD(2000, 2, 29)!,
            YMD(2000, 3, 1)!,
            YMD(2100, 1, 1)!,
        ])
    }
    
    func testDescription() {
        XCTAssertEqual(YMD(1999, 12, 31)!.description, "1999-12-31")
        XCTAssertEqual(YMD(2000, 1, 1)!.description,   "2000-01-01")
        XCTAssertEqual(YMD(2000, 1, 9)!.description,   "2000-01-09")
        XCTAssertEqual(YMD(2000, 1, 10)!.description,  "2000-01-10")
        XCTAssertEqual(YMD(2000, 9, 30)!.description,  "2000-09-30")
        XCTAssertEqual(YMD(2000, 10, 1)!.description,  "2000-10-01")
    }
    
    func testOperators() {
        // days
        XCTAssertEqual(YMD(1988, 12, 3)! + .days(11331), YMD(2019, 12, 12)!)
        do {
            var ymd = YMD(1988, 12, 3)!
            ymd += .days(11331)
            XCTAssertEqual(ymd, YMD(2019, 12, 12)!)
        }
        
        XCTAssertEqual(YMD(2019, 12, 12)! - .days(11331), YMD(1988, 12, 3)!)
        do {
            var ymd = YMD(2019, 12, 12)!
            ymd -= .days(11331)
            XCTAssertEqual(ymd, YMD(1988, 12, 3)!)
        }
        
        XCTAssertEqual(YMD(1988, 12, 3)! + 11331, YMD(2019, 12, 12)!)
        XCTAssertEqual(YMD(2019, 12, 12)! + -11331, YMD(1988, 12, 3)!)
        XCTAssertEqual(YMD(2019, 12, 12)! - YMD(1988, 12, 3)!, 11331)
        XCTAssertEqual(YMD(1988, 12, 3)! - YMD(2019, 12, 12)!, -11331)
        do {
            var ymd = YMD(1988, 12, 3)!
            ymd += 11331
            XCTAssertEqual(ymd, YMD(2019, 12, 12)!)
        }

        // years
        XCTAssertEqual(YMD(1988, 12, 3)! + .years(31), YMD(2019, 12, 3)!)
        XCTAssertEqual(YMD(2019, 12, 3)! - .years(31), YMD(1988, 12, 3)!)
        
        XCTAssertEqual(YMD(2020, 2, 29)! + .years(1), YMD(2021, 2, 28)!)
        XCTAssertEqual(YMD(2020, 2, 29)! + .years(4), YMD(2024, 2, 29)!)

        // months
        XCTAssertEqual(YMD(1988, 12, 3)! + .months(372), YMD(2019, 12, 3)!)
        XCTAssertEqual(YMD(2019, 12, 3)! - .months(372), YMD(1988, 12, 3)!)

        XCTAssertEqual(YMD(2019, 12, 31)! + .months(2), YMD(2020, 2, 29)!)
        XCTAssertEqual(YMD(2019, 12, 31)! + .months(3), YMD(2020, 3, 31)!)

        // weeks
        XCTAssertEqual(YMD(2019, 12, 12)! + .weeks(7), YMD(2020, 1, 30)!)
        XCTAssertEqual(YMD(2020, 1, 30)! - .weeks(7), YMD(2019, 12, 12)!)
    }
    
    func testRanges() {
        var values: [YMD] = []
        for value in YMD(2019, 12, 12)! ... YMD(2020, 3, 20)! {
            values.append(value)
        }
        XCTAssertEqual(values, [
            YMD(2019, 12, 12)!,
            YMD(2019, 12, 13)!,
            YMD(2019, 12, 14)!,
            YMD(2019, 12, 15)!,
            YMD(2019, 12, 16)!,
            YMD(2019, 12, 17)!,
            YMD(2019, 12, 18)!,
            YMD(2019, 12, 19)!,
            YMD(2019, 12, 20)!,
            YMD(2019, 12, 21)!,
            YMD(2019, 12, 22)!,
            YMD(2019, 12, 23)!,
            YMD(2019, 12, 24)!,
            YMD(2019, 12, 25)!,
            YMD(2019, 12, 26)!,
            YMD(2019, 12, 27)!,
            YMD(2019, 12, 28)!,
            YMD(2019, 12, 29)!,
            YMD(2019, 12, 30)!,
            YMD(2019, 12, 31)!,
            YMD(2020, 1, 1)!,
            YMD(2020, 1, 2)!,
            YMD(2020, 1, 3)!,
            YMD(2020, 1, 4)!,
            YMD(2020, 1, 5)!,
            YMD(2020, 1, 6)!,
            YMD(2020, 1, 7)!,
            YMD(2020, 1, 8)!,
            YMD(2020, 1, 9)!,
            YMD(2020, 1, 10)!,
            YMD(2020, 1, 11)!,
            YMD(2020, 1, 12)!,
            YMD(2020, 1, 13)!,
            YMD(2020, 1, 14)!,
            YMD(2020, 1, 15)!,
            YMD(2020, 1, 16)!,
            YMD(2020, 1, 17)!,
            YMD(2020, 1, 18)!,
            YMD(2020, 1, 19)!,
            YMD(2020, 1, 20)!,
            YMD(2020, 1, 21)!,
            YMD(2020, 1, 22)!,
            YMD(2020, 1, 23)!,
            YMD(2020, 1, 24)!,
            YMD(2020, 1, 25)!,
            YMD(2020, 1, 26)!,
            YMD(2020, 1, 27)!,
            YMD(2020, 1, 28)!,
            YMD(2020, 1, 29)!,
            YMD(2020, 1, 30)!,
            YMD(2020, 1, 31)!,
            YMD(2020, 2, 1)!,
            YMD(2020, 2, 2)!,
            YMD(2020, 2, 3)!,
            YMD(2020, 2, 4)!,
            YMD(2020, 2, 5)!,
            YMD(2020, 2, 6)!,
            YMD(2020, 2, 7)!,
            YMD(2020, 2, 8)!,
            YMD(2020, 2, 9)!,
            YMD(2020, 2, 10)!,
            YMD(2020, 2, 11)!,
            YMD(2020, 2, 12)!,
            YMD(2020, 2, 13)!,
            YMD(2020, 2, 14)!,
            YMD(2020, 2, 15)!,
            YMD(2020, 2, 16)!,
            YMD(2020, 2, 17)!,
            YMD(2020, 2, 18)!,
            YMD(2020, 2, 19)!,
            YMD(2020, 2, 20)!,
            YMD(2020, 2, 21)!,
            YMD(2020, 2, 22)!,
            YMD(2020, 2, 23)!,
            YMD(2020, 2, 24)!,
            YMD(2020, 2, 25)!,
            YMD(2020, 2, 26)!,
            YMD(2020, 2, 27)!,
            YMD(2020, 2, 28)!,
            YMD(2020, 2, 29)!,
            YMD(2020, 3, 1)!,
            YMD(2020, 3, 2)!,
            YMD(2020, 3, 3)!,
            YMD(2020, 3, 4)!,
            YMD(2020, 3, 5)!,
            YMD(2020, 3, 6)!,
            YMD(2020, 3, 7)!,
            YMD(2020, 3, 8)!,
            YMD(2020, 3, 9)!,
            YMD(2020, 3, 10)!,
            YMD(2020, 3, 11)!,
            YMD(2020, 3, 12)!,
            YMD(2020, 3, 13)!,
            YMD(2020, 3, 14)!,
            YMD(2020, 3, 15)!,
            YMD(2020, 3, 16)!,
            YMD(2020, 3, 17)!,
            YMD(2020, 3, 18)!,
            YMD(2020, 3, 19)!,
            YMD(2020, 3, 20)!,
        ])
    }
}

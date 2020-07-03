import XCTest
import SwiftYMD

class YMTests: XCTestCase {
    func testInit() {
        XCTAssertEqual(YM(1988 as Int, 12 as Int), YM(Year(1988), .december))
        XCTAssertEqual(YM("1988-12"), YM(1988, 12))
    }
    
    func testNumberOfDays() {
        XCTAssertEqual(YM(1988, 1).numberOfDays, 31)
        XCTAssertEqual(YM(1988, 2).numberOfDays, 29)
        XCTAssertEqual(YM(1988, 3).numberOfDays, 31)
        XCTAssertEqual(YM(1988, 4).numberOfDays, 30)
        XCTAssertEqual(YM(1988, 5).numberOfDays, 31)
        XCTAssertEqual(YM(1988, 6).numberOfDays, 30)
        XCTAssertEqual(YM(1988, 7).numberOfDays, 31)
        XCTAssertEqual(YM(1988, 8).numberOfDays, 31)
        XCTAssertEqual(YM(1988, 9).numberOfDays, 30)
        XCTAssertEqual(YM(1988, 10).numberOfDays, 31)
        XCTAssertEqual(YM(1988, 11).numberOfDays, 30)
        XCTAssertEqual(YM(1988, 12).numberOfDays, 31)
        
        XCTAssertEqual(YM(1995, 2).numberOfDays, 28)
        XCTAssertEqual(YM(1996, 2).numberOfDays, 29)
        XCTAssertEqual(YM(1997, 2).numberOfDays, 28)
        XCTAssertEqual(YM(1998, 2).numberOfDays, 28)
        XCTAssertEqual(YM(1999, 2).numberOfDays, 28)
        XCTAssertEqual(YM(2000, 2).numberOfDays, 29)
        XCTAssertEqual(YM(2001, 2).numberOfDays, 28)
        XCTAssertEqual(YM(2002, 2).numberOfDays, 28)
        XCTAssertEqual(YM(2003, 2).numberOfDays, 28)
        XCTAssertEqual(YM(2004, 2).numberOfDays, 29)
        XCTAssertEqual(YM(2005, 2).numberOfDays, 28)
        
        XCTAssertEqual(YM(2095, 2).numberOfDays, 28)
        XCTAssertEqual(YM(2096, 2).numberOfDays, 29)
        XCTAssertEqual(YM(2097, 2).numberOfDays, 28)
        XCTAssertEqual(YM(2098, 2).numberOfDays, 28)
        XCTAssertEqual(YM(2099, 2).numberOfDays, 28)
        XCTAssertEqual(YM(2100, 2).numberOfDays, 28)
        XCTAssertEqual(YM(2101, 2).numberOfDays, 28)
        XCTAssertEqual(YM(2102, 2).numberOfDays, 28)
        XCTAssertEqual(YM(2103, 2).numberOfDays, 28)
        XCTAssertEqual(YM(2104, 2).numberOfDays, 29)
        XCTAssertEqual(YM(2105, 2).numberOfDays, 28)

        XCTAssertEqual(
            Month.allCases
                .map { YM(1988, $0).numberOfDays }
                .reduce(0, +),
            366
        )

        XCTAssertEqual(
            Month.allCases
                .map { YM(2019, $0).numberOfDays }
                .reduce(0, +),
            365
        )
    }
    
    func testComparable() {
        var values = [
            YM(2001, 1),
            YM(2000, 2),
            YM(1999, 1),
            YM(1999, 12),
            YM(2000, 1),
            YM(1999, 2),
            YM(2001, 2),
            YM(1999, 12),
        ]
        values.sort()
        XCTAssertEqual(values, [
            YM(1999, 1),
            YM(1999, 2),
            YM(1999, 12),
            YM(1999, 12),
            YM(2000, 1),
            YM(2000, 2),
            YM(2001, 1),
            YM(2001, 2),
        ])
    }
    
    func testDescription() {
        XCTAssertEqual(YM(1999, 12).description, "1999-12")
        XCTAssertEqual(YM(2000, 1).description,  "2000-01")
        XCTAssertEqual(YM(2000, 9).description,  "2000-09")
        XCTAssertEqual(YM(2000, 10).description, "2000-10")
    }
    
    func testOperators() {
        XCTAssertEqual(YM(1988, 12) + .years(31), YM(2019, 12))
        do {
            var ym = YM(1988, 12)
            ym += .years(31)
            XCTAssertEqual(ym, YM(2019, 12))
        }
        
        XCTAssertEqual(YM(1988, 12) + .months(372), YM(2019, 12))
        do {
            var ym = YM(1988, 12)
            ym += .months(372)
            XCTAssertEqual(ym, YM(2019, 12))
        }

        XCTAssertEqual(YM(2019, 12) - .years(31), YM(1988, 12))
        do {
            var ym = YM(2019, 12)
            ym -= .years(31)
            XCTAssertEqual(ym, YM(1988, 12))
        }
        
        XCTAssertEqual(YM(2019, 12) - .months(372), YM(1988, 12))
        do {
            var ym = YM(2019, 12)
            ym -= .months(372)
            XCTAssertEqual(ym, YM(1988, 12))
        }
        
        XCTAssertEqual(YM(1988, 12) + 372, YM(2019, 12))
        XCTAssertEqual(YM(2019, 12) + -372, YM(1988, 12))
        XCTAssertEqual(YM(2019, 12) - YM(1988, 12), 372)
        XCTAssertEqual(YM(1988, 12) - YM(2019, 12), -372)
        do {
            var ym = YM(1988, 12)
            ym += 372
            XCTAssertEqual(ym, YM(2019, 12))
        }
    }
    
    func testRanges() {
        var values: [YM] = []
        for value in YM(2018, 12) ... YM(2019, 12) {
            values.append(value)
        }
        XCTAssertEqual(values, [
            YM(2018, 12),
            YM(2019, 1),
            YM(2019, 2),
            YM(2019, 3),
            YM(2019, 4),
            YM(2019, 5),
            YM(2019, 6),
            YM(2019, 7),
            YM(2019, 8),
            YM(2019, 9),
            YM(2019, 10),
            YM(2019, 11),
            YM(2019, 12),
        ])
    }
}

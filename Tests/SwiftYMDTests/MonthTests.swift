import XCTest
import SwiftYMD

class MonthTests: XCTestCase {
    func testInit() {
        XCTAssertEqual(Month(12 as Int), Month.december)
    }
    
    func testCodable() {
        do { // encoding
            let month: Month = .december
            let data: Data = try JSONEncoder().encode(month)
            XCTAssertEqual(String(data: data, encoding: .utf8)!, "\"December\"")
        } catch {
            XCTFail("\(error)")
        }
        
        do { // decoding
            let data: Data = "\"December\"".data(using: .utf8)!
            let month: Month = try JSONDecoder().decode(Month.self, from: data)
            XCTAssertEqual(month, .december)
        } catch {
            XCTFail("\(error)")
        }
    }
}

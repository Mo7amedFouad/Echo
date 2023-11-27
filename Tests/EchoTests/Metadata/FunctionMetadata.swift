import Echo
import XCTest

func add(_ x: Int, _ y: Int...) -> Int {
    fatalError()
}

extension EchoTests {
    func testFunctionMetadata() throws {
        let maybeMetadata = reflect(add(_:_:)) as? FunctionMetadata
        XCTAssertNotNil(maybeMetadata)

        let metadata = maybeMetadata!

        XCTAssertEqual(metadata.flags.bits, 100_663_298)
        XCTAssert(typeArraysEquals(metadata.paramTypes, [Int.self, Int.self]))
        XCTAssert(metadata.resultType == Int.self)
        XCTAssertEqual(metadata.kind, .function)

        for (i, paramFlag) in metadata.paramFlags.enumerated() {
            switch i {
            case 0:
                XCTAssertEqual(paramFlag.bits, 0)
            case 1:
                XCTAssertEqual(paramFlag.bits, 128)
            default:
                fatalError()
            }
        }

        // VWT

        var extraInhabitantCount = 2_147_483_647
        #if os(Linux)
            extraInhabitantCount = 4096
        #endif

        XCTAssertEqual(metadata.vwt.extraInhabitantCount, extraInhabitantCount)
        XCTAssertEqual(metadata.vwt.size, 16)
        XCTAssertEqual(metadata.vwt.stride, 16)
        XCTAssertEqual(metadata.vwt.flags.bits, 65543)
    }
}

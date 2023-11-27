import Echo
import XCTest

extension EchoTests {
    func testExistentialMetatypeMetadata() throws {
        let maybeMetadata = reflect(Testable.Type.self) as? ExistentialMetatypeMetadata
        XCTAssertNotNil(maybeMetadata)

        let metadata = maybeMetadata!

        XCTAssert(metadata.instanceType == Testable.self)
        XCTAssertEqual(metadata.flags.bits, 2_147_483_649)

        // VWT

        var extraInhabitantCount = 2_147_483_647
        #if os(Linux)
            extraInhabitantCount = 4096
        #endif

        XCTAssertEqual(metadata.vwt.extraInhabitantCount, extraInhabitantCount)
        XCTAssertEqual(metadata.vwt.size, 16)
        XCTAssertEqual(metadata.vwt.stride, 16)
        XCTAssertEqual(metadata.vwt.flags.bits, 7)
    }
}

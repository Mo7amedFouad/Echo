import Echo
import XCTest

extension EchoTests {
    func testObjCClassWrapperMetadata() throws {
        #if canImport(ObjectiveC)
            let maybeMetadata = reflect(NSObject.self) as? ObjCClassWrapperMetadata
            XCTAssertNotNil(maybeMetadata)

            let metadata = maybeMetadata!

            // We compare strings here because comparing `NSObject.self` would compare
            // the objc class wrapper against class metadata.
            XCTAssert("\(metadata.classType)" == "NSObject")
            XCTAssertEqual(metadata.kind, .objcClassWrapper)

            // VWT

            XCTAssertEqual(metadata.vwt.extraInhabitantCount, 2_147_483_647)
            XCTAssertEqual(metadata.vwt.size, 8)
            XCTAssertEqual(metadata.vwt.stride, 8)
            XCTAssertEqual(metadata.vwt.flags.bits, 65543)
        #endif
    }
}

import XCTest
@testable import StorageServicePackage

final class StorageServiceTests: XCTestCase {
    func testSavingAndLoading() throws {
        let storageService = StorageService()
        let testObject = ["key": "value"]

        try storageService.save(testObject, forKey: "testKey")
        let loadedObject: [String: String]? = try storageService.load(forKey: "testKey", as: [String: String].self)

        XCTAssertEqual(loadedObject?["key"], "value")
    }
}

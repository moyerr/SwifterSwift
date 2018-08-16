//
//  DataExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 09/02/2017.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class DataExtensionsTests: XCTestCase {

    private struct TestDecodableObject: Equatable, Decodable {
        let firstProperty: Int
        let secondProperty: String
        let thirdProperty: Bool
    }
    
	func testString() {
		let dataFromString = "hello".data(using: .utf8)
		XCTAssertNotNil(dataFromString)
		XCTAssertNotNil(dataFromString?.string(encoding: .utf8))
		XCTAssertEqual(dataFromString?.string(encoding: .utf8), "hello")
	}

    func testBytes() {
        let dataFromString = "hello".data(using: .utf8)
        let bytes = dataFromString?.bytes
        XCTAssertNotNil(bytes)
        XCTAssertEqual(bytes?.count, 5)
    }
    
    func testDecoded() {
        let jsonData =
        """
        {
            "firstProperty": 100,
            "secondProperty": "Hello World!",
            "thirdProperty": true
        }
        """.data(using: .utf8)
        
        let plistData =
        """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>firstProperty</key>
            <integer>100</integer>
            <key>secondProperty</key>
            <string>Hello World!</string>
            <key>thirdProperty</key>
            <true/>
        </dict>
        </plist>
        """.data(using: .utf8)
        
        let invalidJSON = "{ badJSON }".data(using: .utf8)
        let invalidPLIST = "<key>badPLIST</key>".data(using: .utf8)
        
        // Verify data was created
        
        XCTAssertNotNil(jsonData)
        XCTAssertNotNil(plistData)
        XCTAssertNotNil(invalidJSON)
        XCTAssertNotNil(invalidPLIST)
        
        // Test decoding from JSON
        
        let explicitFromJSON = try? jsonData!.decoded() as TestDecodableObject
        let implicitFromJSON: TestDecodableObject? = try? jsonData!.decoded()
        
        XCTAssertNotNil(explicitFromJSON)
        XCTAssertNotNil(implicitFromJSON)
        
        XCTAssertEqual(explicitFromJSON, implicitFromJSON)
        
        XCTAssertThrowsError(try invalidJSON!.decoded() as TestDecodableObject)
        
        // Test decoding from PLIST
        
        let plistDecoder = PropertyListDecoder()
        
        let explicitFromPLIST = try? plistData!.decoded(using: plistDecoder) as TestDecodableObject
        let implicitFromPLIST: TestDecodableObject? = try? plistData!.decoded(using: plistDecoder)
        
        XCTAssertNotNil(explicitFromPLIST)
        XCTAssertNotNil(implicitFromPLIST)
        
        XCTAssertEqual(explicitFromPLIST, implicitFromPLIST)
        
        XCTAssertThrowsError(try invalidPLIST!.decoded(using: plistDecoder) as TestDecodableObject)
    }

}

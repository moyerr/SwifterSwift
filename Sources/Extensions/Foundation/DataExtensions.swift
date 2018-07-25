//
//  DataExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 SwifterSwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Properties
public extension Data {

	/// SwifterSwift: Return data as an array of bytes.
	public var bytes: [UInt8] {
		// http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
		return [UInt8](self)
	}

}

// MARK: - Methods
public extension Data {

	/// SwifterSwift: String by encoding Data using the given encoding (if applicable).
	///
	/// - Parameter encoding: encoding.
	/// - Returns: String by encoding Data using the given encoding (if applicable).
	public func string(encoding: String.Encoding) -> String? {
		return String(data: self, encoding: encoding)
	}
    
    public func jsonDecoded<T: Decodable>(usingKeyDecodingStrategy keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        return try decoder.decode(T.self, from: self)
    }
    
    public func plistDecoded<T: Decodable>(usingFormat format: inout PropertyListSerialization.PropertyListFormat) throws -> T {
        let decoder = PropertyListDecoder()
        return try decoder.decode(T.self, from: self, format: &format)
    }
    
    public func plistDecoded<T: Decodable>() throws -> T {
        return try PropertyListDecoder().decode(T.self, from: self)
    }

}
#endif

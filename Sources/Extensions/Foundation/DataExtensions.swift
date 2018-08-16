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

    /// SwifterSwift: Decodes the data and returns a value of the specified type or
    /// the inferred type if possible. Throws [dataCorrupted](apple-reference-documentation://hs96_0iudB)
    /// if value fails to decode.
    ///
    ///     // Explicit type
    ///     let user = userData.decoded() as User
    ///
    ///     // Inferred type
    ///     userDidLoad(userData.decoded())
    ///
    /// - Parameter decoder: The object used to decode the data. Default is `JSONDecoder`.
    /// - Returns: A value of the specified type (or inferred type, if possible).
    /// - Throws: [dataCorrupted](apple-reference-documentation://hs96_0iudB) if value fails to decode
    public func decoded<D: Decodable>(using decoder: AnyDecoder = JSONDecoder()) throws -> D {
        // Source: https://www.swiftbysundell.com/posts/type-inference-powered-serialization-in-swift
        return try decoder.decode(D.self, from: self)
    }
}

// MARK: - Protocols
public protocol AnyDecoder {
    func decode<D: Decodable>(_ type: D.Type, from data: Data) throws -> D
}

// MARK: - Protocol Conformance
extension JSONDecoder: AnyDecoder {}
extension PropertyListDecoder: AnyDecoder {}

#endif

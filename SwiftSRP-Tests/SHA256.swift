/*******************************************************************************
 * The MIT License (MIT)
 *
 * Copyright (c) 2023, Jean-David Gadina - www.xs-labs.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the Software), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 ******************************************************************************/

import Foundation
import SwiftSRP
import XCTest

final class SHA256: XCTestCase
{
    func testBytesFromData()
    {
        SHA256.results.forEach
        {
            let h = SRPSHA256.bytes( from: Data( $0.bytes ) )

            XCTAssertTrue( h == Data( $0.hashBytes ) )
        }
    }

    func testBytesFromString()
    {
        SHA256.results.forEach
        {
            let h = SRPSHA256.bytes( from: $0.string )

            XCTAssertTrue( h == Data( $0.hashBytes ) )
        }
    }

    func testStringFromData()
    {
        SHA256.results.forEach
        {
            let h1 = SRPSHA256.string( from: Data( $0.bytes ), format: .uppercase )
            let h2 = SRPSHA256.string( from: Data( $0.bytes ), format: .lowercase )

            XCTAssertTrue( h1 == $0.hashStringUppercase )
            XCTAssertTrue( h2 == $0.hashStringLowercase )
        }
    }

    func testStringFromString()
    {
        SHA256.results.forEach
        {
            let h1 = SRPSHA256.string( from: $0.string, format: .uppercase )
            let h2 = SRPSHA256.string( from: $0.string, format: .lowercase )

            XCTAssertTrue( h1 == $0.hashStringUppercase )
            XCTAssertTrue( h2 == $0.hashStringLowercase )
        }
    }

    struct SHA256Results
    {
        var bytes:               [ UInt8 ]
        var string:              String
        var hashBytes:           [ UInt8 ]
        var hashStringUppercase: String
        var hashStringLowercase: String
    }

    private static let results: [ SHA256Results ] =
        [
            SHA256Results(
                bytes:               "hello, world".utf8.map { UInt8( $0 ) },
                string:              "hello, world",
                hashBytes:           [ 0x09, 0xCA, 0x7E, 0x4E, 0xAA, 0x6E, 0x8A, 0xE9, 0xC7, 0xD2, 0x61, 0x16, 0x71, 0x29, 0x18, 0x48, 0x83, 0x64, 0x4D, 0x07, 0xDF, 0xBA, 0x7C, 0xBF, 0xBC, 0x4C, 0x8A, 0x2E, 0x08, 0x36, 0x0D, 0x5B ],
                hashStringUppercase: "09CA7E4EAA6E8AE9C7D261167129184883644D07DFBA7CBFBC4C8A2E08360D5B",
                hashStringLowercase: "09ca7e4eaa6e8ae9c7d261167129184883644d07dfba7cbfbc4c8a2e08360d5b"
            ),
            SHA256Results(
                bytes:               "hello, universe".utf8.map { UInt8( $0 ) },
                string:              "hello, universe",
                hashBytes:           [ 0x21, 0xF0, 0x24, 0x3B, 0x16, 0x8D, 0xE0, 0xFC, 0x4B, 0x3E, 0x29, 0x80, 0xBA, 0xC1, 0xD8, 0xE7, 0xE7, 0xE6, 0x0D, 0xC0, 0xB7, 0x7A, 0x7C, 0x1C, 0x19, 0x9D, 0x94, 0x28, 0x6D, 0xCE, 0x1D, 0x42 ],
                hashStringUppercase: "21F0243B168DE0FC4B3E2980BAC1D8E7E7E60DC0B77A7C1C199D94286DCE1D42",
                hashStringLowercase: "21f0243b168de0fc4b3e2980bac1d8e7e7e60dc0b77a7c1c199d94286dce1d42"
            ),
        ]
}

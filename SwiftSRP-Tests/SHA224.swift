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

final class SHA224: XCTestCase
{
    func testBytesFromData()
    {
        SHA224.results.forEach
        {
            let h = SRPSHA224.bytes( from: Data( $0.bytes ) )

            XCTAssertTrue( h == Data( $0.hashBytes ) )
        }
    }

    func testBytesFromString()
    {
        SHA224.results.forEach
        {
            let h = SRPSHA224.bytes( from: $0.string )

            XCTAssertTrue( h == Data( $0.hashBytes ) )
        }
    }

    func testStringFromData()
    {
        SHA224.results.forEach
        {
            let h1 = SRPSHA224.string( from: Data( $0.bytes ), format: .uppercase )
            let h2 = SRPSHA224.string( from: Data( $0.bytes ), format: .lowercase )

            XCTAssertTrue( h1 == $0.hashStringUppercase )
            XCTAssertTrue( h2 == $0.hashStringLowercase )
        }
    }

    func testStringFromString()
    {
        SHA224.results.forEach
        {
            let h1 = SRPSHA224.string( from: $0.string, format: .uppercase )
            let h2 = SRPSHA224.string( from: $0.string, format: .lowercase )

            XCTAssertTrue( h1 == $0.hashStringUppercase )
            XCTAssertTrue( h2 == $0.hashStringLowercase )
        }
    }

    struct SHA224Results
    {
        var bytes:               [ UInt8 ]
        var string:              String
        var hashBytes:           [ UInt8 ]
        var hashStringUppercase: String
        var hashStringLowercase: String
    }

    private static let results: [ SHA224Results ] =
        [
            SHA224Results(
                bytes:               "hello, world".utf8.map { UInt8( $0 ) },
                string:              "hello, world",
                hashBytes:           [ 0x6E, 0x1A, 0x93, 0xE3, 0x2F, 0xB4, 0x40, 0x81, 0xA4, 0x01, 0xF3, 0xDB, 0x3E, 0xF2, 0xE6, 0xE1, 0x08, 0xB7, 0xBB, 0xEE, 0xB5, 0x70, 0x5A, 0xFD, 0xAF, 0x01, 0xFB, 0x27 ],
                hashStringUppercase: "6E1A93E32FB44081A401F3DB3EF2E6E108B7BBEEB5705AFDAF01FB27",
                hashStringLowercase: "6e1a93e32fb44081a401f3db3ef2e6e108b7bbeeb5705afdaf01fb27"
            ),
            SHA224Results(
                bytes:               "hello, universe".utf8.map { UInt8( $0 ) },
                string:              "hello, universe",
                hashBytes:           [ 0x2A, 0xB1, 0x03, 0xBA, 0x1F, 0xF5, 0x96, 0xC3, 0xE0, 0x52, 0xC7, 0xF6, 0xD1, 0x33, 0x07, 0x61, 0xF7, 0xA6, 0x27, 0x99, 0x58, 0x7F, 0x67, 0xF6, 0x88, 0x52, 0xEB, 0xF7 ],
                hashStringUppercase: "2AB103BA1FF596C3E052C7F6D1330761F7A62799587F67F68852EBF7",
                hashStringLowercase: "2ab103ba1ff596c3e052c7f6d1330761f7a62799587f67f68852ebf7"
            ),
        ]
}

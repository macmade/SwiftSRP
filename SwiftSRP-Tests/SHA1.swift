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

final class SHA1: XCTestCase
{
    func testBytesFromData()
    {
        SHA1.results.forEach
        {
            let h = SRPSHA1.bytes( from: Data( $0.bytes ) )

            XCTAssertTrue( h == Data( $0.hashBytes ) )
        }
    }

    func testBytesFromString()
    {
        SHA1.results.forEach
        {
            let h = SRPSHA1.bytes( from: $0.string )

            XCTAssertTrue( h == Data( $0.hashBytes ) )
        }
    }

    func testStringFromData()
    {
        SHA1.results.forEach
        {
            let h1 = SRPSHA1.string( from: Data( $0.bytes ), format: .uppercase )
            let h2 = SRPSHA1.string( from: Data( $0.bytes ), format: .lowercase )

            XCTAssertTrue( h1 == $0.hashStringUppercase )
            XCTAssertTrue( h2 == $0.hashStringLowercase )
        }
    }

    func testStringFromString()
    {
        SHA1.results.forEach
        {
            let h1 = SRPSHA1.string( from: $0.string, format: .uppercase )
            let h2 = SRPSHA1.string( from: $0.string, format: .lowercase )

            XCTAssertTrue( h1 == $0.hashStringUppercase )
            XCTAssertTrue( h2 == $0.hashStringLowercase )
        }
    }

    struct SHA1Results
    {
        var bytes:               [ UInt8 ]
        var string:              String
        var hashBytes:           [ UInt8 ]
        var hashStringUppercase: String
        var hashStringLowercase: String
    }

    private static let results: [ SHA1Results ] =
        [
            SHA1Results(
                bytes:               "hello, world".utf8.map { UInt8( $0 ) },
                string:              "hello, world",
                hashBytes:           [ 0xB7, 0xE2, 0x3E, 0xC2, 0x9A, 0xF2, 0x2B, 0x0B, 0x4E, 0x41, 0xDA, 0x31, 0xE8, 0x68, 0xD5, 0x72, 0x26, 0x12, 0x1C, 0x84 ],
                hashStringUppercase: "B7E23EC29AF22B0B4E41DA31E868D57226121C84",
                hashStringLowercase: "b7e23ec29af22b0b4e41da31e868d57226121c84"
            ),
            SHA1Results(
                bytes:               "hello, universe".utf8.map { UInt8( $0 ) },
                string:              "hello, universe",
                hashBytes:           [ 0xC7, 0x58, 0xD6, 0xDD, 0xA4, 0x50, 0x3F, 0xEE, 0x91, 0xA1, 0x99, 0x61, 0x91, 0x5E, 0x2B, 0xA7, 0x50, 0x00, 0xC4, 0x55 ],
                hashStringUppercase: "C758D6DDA4503FEE91A19961915E2BA75000C455",
                hashStringLowercase: "c758d6dda4503fee91a19961915e2ba75000c455"
            ),
        ]
}

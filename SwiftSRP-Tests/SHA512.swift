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

final class SHA512: XCTestCase
{
    func testBytesFromData()
    {
        SHA512.results.forEach
        {
            let h = SRPSHA512.bytes( from: Data( $0.bytes ) )

            XCTAssertTrue( h == Data( $0.hashBytes ) )
        }
    }

    func testBytesFromString()
    {
        SHA512.results.forEach
        {
            let h = SRPSHA512.bytes( from: $0.string )

            XCTAssertTrue( h == Data( $0.hashBytes ) )
        }
    }

    func testStringFromData()
    {
        SHA512.results.forEach
        {
            let h1 = SRPSHA512.string( from: Data( $0.bytes ), format: .uppercase )
            let h2 = SRPSHA512.string( from: Data( $0.bytes ), format: .lowercase )

            XCTAssertTrue( h1 == $0.hashStringUppercase )
            XCTAssertTrue( h2 == $0.hashStringLowercase )
        }
    }

    func testStringFromString()
    {
        SHA512.results.forEach
        {
            let h1 = SRPSHA512.string( from: $0.string, format: .uppercase )
            let h2 = SRPSHA512.string( from: $0.string, format: .lowercase )

            XCTAssertTrue( h1 == $0.hashStringUppercase )
            XCTAssertTrue( h2 == $0.hashStringLowercase )
        }
    }

    struct SHA512Results
    {
        var bytes:               [ UInt8 ]
        var string:              String
        var hashBytes:           [ UInt8 ]
        var hashStringUppercase: String
        var hashStringLowercase: String
    }

    private static let results: [ SHA512Results ] =
        [
            SHA512Results(
                bytes:               "hello, world".utf8.map { UInt8( $0 ) },
                string:              "hello, world",
                hashBytes:           [ 0x87, 0x10, 0x33, 0x9D, 0xCB, 0x68, 0x14, 0xD0, 0xD9, 0xD2, 0x29, 0x0E, 0xF4, 0x22, 0x28, 0x5C, 0x93, 0x22, 0xB7, 0x16, 0x39, 0x51, 0xF9, 0xA0, 0xCA, 0x8F, 0x88, 0x3D, 0x33, 0x05, 0x28, 0x6F, 0x44, 0x13, 0x9A, 0xA3, 0x74, 0x84, 0x8E, 0x41, 0x74, 0xF5, 0xAA, 0xDA, 0x66, 0x30, 0x27, 0xE4, 0x54, 0x86, 0x37, 0xB6, 0xD1, 0x98, 0x94, 0xAE, 0xC4, 0xFB, 0x6C, 0x46, 0xA1, 0x39, 0xFB, 0xF9 ],
                hashStringUppercase: "8710339DCB6814D0D9D2290EF422285C9322B7163951F9A0CA8F883D3305286F44139AA374848E4174F5AADA663027E4548637B6D19894AEC4FB6C46A139FBF9",
                hashStringLowercase: "8710339dcb6814d0d9d2290ef422285c9322b7163951f9a0ca8f883d3305286f44139aa374848e4174f5aada663027e4548637b6d19894aec4fb6c46a139fbf9"
            ),
            SHA512Results(
                bytes:               "hello, universe".utf8.map { UInt8( $0 ) },
                string:              "hello, universe",
                hashBytes:           [ 0xB9, 0xE4, 0x5B, 0xB8, 0xD2, 0x6C, 0x21, 0x6F, 0xD6, 0x3E, 0x18, 0x37, 0x8D, 0xE2, 0x35, 0x8C, 0x12, 0xE1, 0xB4, 0xFB, 0x31, 0x98, 0x6B, 0x65, 0x94, 0xC2, 0x2A, 0x9D, 0xCE, 0x8D, 0xDE, 0x8A, 0xB3, 0x0C, 0x70, 0x21, 0xE0, 0xE3, 0xB6, 0xDF, 0x9F, 0x53, 0x21, 0x77, 0x32, 0xB0, 0x21, 0xAF, 0x8F, 0x1C, 0xAF, 0x80, 0xA1, 0xD0, 0x1D, 0xB2, 0xB7, 0xBB, 0xE2, 0x40, 0x7F, 0x67, 0xDE, 0xD5 ],
                hashStringUppercase: "B9E45BB8D26C216FD63E18378DE2358C12E1B4FB31986B6594C22A9DCE8DDE8AB30C7021E0E3B6DF9F53217732B021AF8F1CAF80A1D01DB2B7BBE2407F67DED5",
                hashStringLowercase: "b9e45bb8d26c216fd63e18378de2358c12e1b4fb31986b6594c22a9dce8dde8ab30c7021e0e3b6df9f53217732b021af8f1caf80a1d01db2b7bbe2407f67ded5"
            ),
        ]
}

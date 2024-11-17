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

final class PBKDF2: XCTestCase
{
    func testHMAC()
    {
        self.results.forEach
        {
            let k1 = SRPPBKDF2.hmac( hashAlgorithm: $0.algorithm, password: $0.password,                                salt: Data( $0.salt ), iterations: $0.iterations, keyLength: $0.keyLength )
            let k2 = SRPPBKDF2.hmac( hashAlgorithm: $0.algorithm, password: $0.password.data( using: .utf8 ) ?? Data(), salt: Data( $0.salt ), iterations: $0.iterations, keyLength: $0.keyLength )

            XCTAssertTrue( k1.count == $0.key.count )
            XCTAssertTrue( k2.count == $0.key.count )

            XCTAssertTrue( k1 == Data( $0.key ) )
            XCTAssertTrue( k2 == Data( $0.key ) )
        }
    }

    private var results: [ Result ] = []

    struct Result
    {
        var algorithm:  SRPHashAlgorithm
        var password:   String
        var salt:       [ UInt8 ]
        var iterations: UInt32
        var keyLength:  size_t
        var key:        [ UInt8 ]
    }

    override func setUp()
    {
        self.results = [
            Result(
                algorithm:  .SHA1,
                password:   "hello, world",
                salt:       [ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09 ],
                iterations: 1024,
                keyLength:  10,
                key:        [ 0x11, 0x5E, 0x34, 0x6A, 0xCC, 0xB4, 0xEE, 0x62, 0x11, 0x5D ]
            ),
            Result(
                algorithm:  .SHA1,
                password:   "hello, universe",
                salt:       [ 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00 ],
                iterations: 4096,
                keyLength:  16,
                key:        [ 0xDF, 0x98, 0xED, 0x0D, 0x0E, 0xD1, 0x3A, 0x23, 0x43, 0xEA, 0xEB, 0xD2, 0xCD, 0xEE, 0x2B, 0xD6 ]
            ),
            Result(
                algorithm:   .SHA224,
                password:    "hello, world",
                salt:        [ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09 ],
                iterations:  1024,
                keyLength:   10,
                key:         [ 0x92, 0x06, 0x28, 0xFF, 0xC4, 0x86, 0x96, 0x41, 0xB1, 0xBA ]
            ),
            Result(
                algorithm:   .SHA224,
                password:    "hello, universe",
                salt:        [ 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00 ],
                iterations:  4096,
                keyLength:   16,
                key:         [ 0x22, 0xD4, 0x44, 0x5C, 0xF2, 0xCB, 0xF5, 0x2A, 0x50, 0xEE, 0x52, 0x86, 0xDF, 0x11, 0x28, 0x76 ]
            ),
            Result(
                algorithm:   .SHA256,
                password:    "hello, world",
                salt:        [ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09 ],
                iterations:  1024,
                keyLength:   10,
                key:         [ 0x9E, 0x0D, 0x40, 0x07, 0x7D, 0x4A, 0xE7, 0xE6, 0xAF, 0xE0 ]
            ),
            Result(
                algorithm:   .SHA256,
                password:    "hello, universe",
                salt:        [ 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00 ],
                iterations:  4096,
                keyLength:   16,
                key:         [ 0x31, 0x9D, 0x2F, 0x05, 0xDC, 0x29, 0xA0, 0xE0, 0x14, 0xDE, 0x1B, 0x71, 0x30, 0xF1, 0x79, 0xB0 ]
            ),
            Result(
                algorithm:   .SHA384,
                password:    "hello, world",
                salt:        [ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09 ],
                iterations:  1024,
                keyLength:   10,
                key:         [ 0x17, 0xB1, 0xA9, 0x5E, 0xFC, 0x9C, 0x38, 0x0B, 0xB6, 0x14 ]
            ),
            Result(
                algorithm:   .SHA384,
                password:    "hello, universe",
                salt:        [ 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00 ],
                iterations:  4096,
                keyLength:   16,
                key:         [ 0x57, 0x5F, 0x47, 0x9D, 0x43, 0xBC, 0x49, 0x48, 0x62, 0xA5, 0xBC, 0xCD, 0x7B, 0x9B, 0xBB, 0x54 ]
            ),
            Result(
                algorithm:   .SHA512,
                password:    "hello, world",
                salt:        [ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09 ],
                iterations:  1024,
                keyLength:   10,
                key:         [ 0x63, 0x3E, 0xAA, 0x51, 0x93, 0x82, 0x95, 0x77, 0x30, 0xDD ]
            ),
            Result(
                algorithm:   .SHA512,
                password:    "hello, universe",
                salt:        [ 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00 ],
                iterations:  4096,
                keyLength:   16,
                key:         [ 0x92, 0x81, 0x63, 0xE8, 0x30, 0xA5, 0xD0, 0x30, 0xE1, 0x17, 0x05, 0x86, 0x61, 0x13, 0x80, 0x56 ]
            ),
        ]
    }
}

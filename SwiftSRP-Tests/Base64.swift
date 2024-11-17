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

final class Base64: XCTestCase
{
    func testEncode()
    {
        Base64.testData.forEach
        {
            XCTAssertTrue( SRPBase64.encode( data: $0.decoded.data( using: .utf8 ) ?? Data() ) == $0.encoded )
        }
    }

    func testDecode()
    {
        Base64.testData.forEach
        {
            XCTAssertTrue( SRPBase64.decode( string: $0.encoded ) == $0.decoded.data( using: .utf8 ) ?? Data() )
        }
    }

    private static let testData: [ ( encoded: String, decoded: String ) ] =
        [
            (
                "",
                ""
            ),
            (
                "QQ==",
                "A"
            ),
            (
                "aGVsbG8sIHdvcmxk",
                "hello, world"
            ),
            (
                "aGVsbG8sIHdvcmxkIQ==",
                "hello, world!"
            ),
            (
                "aGVsbG8sIHVuaXZlcnNl",
                "hello, universe"
            ),
            (
                "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4=",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ),
        ]
}

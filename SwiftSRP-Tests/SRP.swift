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

final class SRP: XCTestCase
{
    func testEndToEnd()
    {
        let accounts: [ ( identity: String, password: String ) ] =
            [
                ( "milford@cubicle.org",        "nettles" ),
                ( "hubert@cumberdale.org",      "1234" ),
                ( "marjorie@stewartbaxter.org", "sunshinedust" ),
                ( "jeremy@fisher.org",          "kenneth" ),
            ]

        let algorithms: [ SRPHashAlgorithm ] = [ .SHA1, .SHA224, .SHA256, .SHA384, .SHA512 ]
        let groups:     [ SRPGroupType ]     = [ .NG1024, .NG1536, .NG2048, .NG3072, .NG4096, .NG6144, .NG8192 ]

        algorithms.forEach
        {
            algorithm in

            groups.forEach
            {
                group in

                accounts.forEach
                {
                    account in

                    // Server storage
                    var salt:     Data!
                    var verifier: Data!

                    /* Registration */
                    let register =
                    {
                        let client = SRPClient( identity: account.identity, hashAlgorithm: algorithm, groupType: group )

                        // User registers with a password
                        client.setPassword( string: account.password )

                        // Client generates a salt
                        client.salt = SRPRandom.bytes( count: 16 )

                        // Client -> Server:
                        // Server receives salt and verifier from Client
                        salt     = client.salt
                        verifier = client.v.bytes( endianness: .bigEndian )
                    }

                    register()
                    XCTAssertNotNil( salt )
                    XCTAssertNotNil( verifier )

                    /* Authentication */
                    let client = SRPClient( identity: account.identity, hashAlgorithm: algorithm, groupType: group )
                    let server = SRPServer( identity: account.identity, hashAlgorithm: algorithm, groupType: group )

                    // Server has stored salt and verifier during authentication (see above)
                    server.v    = SRPBigNum( data: verifier, endianness: .bigEndian )
                    server.salt = salt

                    // Client -> Server:
                    // Server receives A from Client
                    server.A = client.A

                    // Server -> Client:
                    // Client receives B and salt from Server
                    client.B    = server.B
                    client.salt = server.salt

                    // User inputs a wrong password
                    client.setPassword( string: "salad" )

                    // Client and Server will not have matching M1 and M2, meaning the authentication failed
                    XCTAssertFalse( client.M1 == server.M1 )
                    XCTAssertFalse( client.M2 == server.M2 )

                    // User inputs the correct password
                    client.setPassword( string: account.password )

                    // With the correct password, Client and Server will have matching M1 and M2, meaning the authentication was successful
                    XCTAssertTrue( client.M1 == server.M1 )
                    XCTAssertTrue( client.M2 == server.M2 )
                }
            }
        }
    }
}

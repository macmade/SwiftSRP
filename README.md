SwiftSRP
========

[![Build Status](https://img.shields.io/github/actions/workflow/status/macmade/SwiftSRP/ci-mac.yaml?label=macOS&logo=apple)](https://github.com/macmade/SwiftSRP/actions/workflows/ci-mac.yaml)
[![Issues](http://img.shields.io/github/issues/macmade/SwiftSRP.svg?logo=github)](https://github.com/macmade/SwiftSRP/issues)
![Status](https://img.shields.io/badge/status-active-brightgreen.svg?logo=git)
![License](https://img.shields.io/badge/license-mit-brightgreen.svg?logo=open-source-initiative)  
[![Contact](https://img.shields.io/badge/follow-@macmade-blue.svg?logo=twitter&style=social)](https://twitter.com/macmade)
[![Sponsor](https://img.shields.io/badge/sponsor-macmade-pink.svg?logo=github-sponsors&style=social)](https://github.com/sponsors/macmade)

### About

Implementation of the Secure Remote Password protocol (SRP) - RFC 5054 for Swift.

**Supported Hash Algorithms:**

 - SHA-1
 - SHA-224
 - SHA-256
 - SHA-384
 - SHA-512

**Supported Group Parameters:**

 - 1024 bits
 - 1536 bits
 - 2048 bits
 - 3072 bits
 - 4096 bits
 - 6144 bits
 - 8192 bits

### Example Usage

```swift

import Foundation
import SwiftSRP

// Server storage
var salt:     Data!
var verifier: Data!

/* Registration */
// Create a SRP client for an identity, with a given hash algorithm and group type
let client = SRPClient( identity: account.identity, hashAlgorithm: .SHA256, groupType: .NG2048 )

// User registers with a password
client.setPassword( string: account.password )

// Client generates a salt
client.salt = SRPRandom.bytes( count: 16 )

// Client -> Server:
// Server receives salt and verifier from Client
// Client can then discard them
salt     = client.salt
verifier = client.v.bytes( endianness: .bigEndian )

/* Authentication */
let client = SRPClient( identity: account.identity, hashAlgorithm: .SHA256, groupType: .NG2048 )
let server = SRPServer( identity: account.identity, hashAlgorithm: .SHA256, groupType: .NG2048 )

// Server has stored salt and verifier during registration (see above)
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
AssertFalse( client.M1 == server.M1 )
AssertFalse( client.M2 == server.M2 )

// User inputs the correct password
client.setPassword( string: account.password )

// With the correct password, Client and Server will have matching M1 and M2, meaning the authentication was successful
AssertTrue( client.M1 == server.M1 )
AssertTrue( client.M2 == server.M2 )

```

Requirements
------------

This project requires OpenSSL.  
A pre-built version of BoringSSL is provided for macOS in the `Submodules/SRPXX/Submodules/BoringSSL/lib` directory.

License
-------

Project is released under the terms of the MIT License.

Repository Infos
----------------

    Owner:          Jean-David Gadina - XS-Labs
    Web:            www.xs-labs.com
    Blog:           www.noxeos.com
    Twitter:        @macmade
    GitHub:         github.com/macmade
    LinkedIn:       ch.linkedin.com/in/macmade/
    StackOverflow:  stackoverflow.com/users/182676/macmade

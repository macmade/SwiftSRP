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

#import <Foundation/Foundation.h>
#import <SwiftSRP/SRPHashAlgorithm.h>
#import <SwiftSRP/SRPGroupType.h>
#import <SwiftSRP/SRPBigNum.h>

typedef NS_OPTIONS( uint64_t, SRPClientOptions )
{
    SRPClientOptionsNoUsernameInX = 1 << 0
};

NS_ASSUME_NONNULL_BEGIN

@interface SRPClient: NSObject

@property( atomic, readonly          ) NSString  * identity;
@property( atomic, readwrite, strong ) NSData    * salt;
@property( atomic, readonly          ) SRPBigNum * N  NS_SWIFT_NAME( N );
@property( atomic, readonly          ) SRPBigNum * g  NS_SWIFT_NAME( g );
@property( atomic, readonly          ) SRPBigNum * k  NS_SWIFT_NAME( k );
@property( atomic, readonly          ) SRPBigNum * u  NS_SWIFT_NAME( u );
@property( atomic, readonly          ) SRPBigNum * a  NS_SWIFT_NAME( a );
@property( atomic, readonly          ) SRPBigNum * A  NS_SWIFT_NAME( A );
@property( atomic, readwrite, strong ) SRPBigNum * B  NS_SWIFT_NAME( B );
@property( atomic, readonly          ) SRPBigNum * x  NS_SWIFT_NAME( x );
@property( atomic, readonly          ) SRPBigNum * v  NS_SWIFT_NAME( v );
@property( atomic, readonly          ) SRPBigNum * S  NS_SWIFT_NAME( S );
@property( atomic, readonly          ) NSData    * K  NS_SWIFT_NAME( K );
@property( atomic, readonly          ) NSData    * M1 NS_SWIFT_NAME( M1 );
@property( atomic, readonly          ) NSData    * M2 NS_SWIFT_NAME( M2 );

- ( instancetype )initWithIdentity: ( NSString * )identity hashAlgorithm: ( SRPHashAlgorithm )hashAlgorithm groupType: ( SRPGroupType )groupType;
- ( instancetype )initWithIdentity: ( NSString * )identity hashAlgorithm: ( SRPHashAlgorithm )hashAlgorithm groupType: ( SRPGroupType )groupType a: ( nullable SRPBigNum * )a NS_DESIGNATED_INITIALIZER;

- ( void )setPasswordString: ( NSString * )value NS_SWIFT_NAME( setPassword(string:) );
- ( void )setPasswordData:   ( NSData * )value   NS_SWIFT_NAME( setPassword(data:) );

- ( void )setOptions:   ( uint64_t )value;
- ( void )addOption:    ( SRPClientOptions )option;
- ( void )removeOption: ( SRPClientOptions )option;
- ( BOOL )hasOption:    ( SRPClientOptions )option;

@end

NS_ASSUME_NONNULL_END

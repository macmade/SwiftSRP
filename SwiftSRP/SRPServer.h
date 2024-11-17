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

NS_ASSUME_NONNULL_BEGIN

@interface SRPServer: NSObject

@property( atomic, readonly          ) NSString  * identity;
@property( atomic, readwrite, strong ) NSData    * salt;
@property( atomic, readonly          ) SRPBigNum * N  NS_SWIFT_NAME( N );
@property( atomic, readonly          ) SRPBigNum * g  NS_SWIFT_NAME( g );
@property( atomic, readonly          ) SRPBigNum * k  NS_SWIFT_NAME( k );
@property( atomic, readonly          ) SRPBigNum * u  NS_SWIFT_NAME( u );
@property( atomic, readwrite, strong ) SRPBigNum * A  NS_SWIFT_NAME( A );
@property( atomic, readonly          ) SRPBigNum * b  NS_SWIFT_NAME( b );
@property( atomic, readonly          ) SRPBigNum * B  NS_SWIFT_NAME( B );
@property( atomic, readwrite, strong ) SRPBigNum * v  NS_SWIFT_NAME( v );
@property( atomic, readonly          ) SRPBigNum * S  NS_SWIFT_NAME( S );
@property( atomic, readonly          ) NSData    * K  NS_SWIFT_NAME( K );
@property( atomic, readonly          ) NSData    * M1 NS_SWIFT_NAME( M1 );
@property( atomic, readonly          ) NSData    * M2 NS_SWIFT_NAME( M2 );

- ( instancetype )initWithIdentity: ( NSString * )identity hashAlgorithm: ( SRPHashAlgorithm )hashAlgorithm groupType: ( SRPGroupType )groupType;
- ( instancetype )initWithIdentity: ( NSString * )identity hashAlgorithm: ( SRPHashAlgorithm )hashAlgorithm groupType: ( SRPGroupType )groupType b: ( nullable SRPBigNum * )b NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END

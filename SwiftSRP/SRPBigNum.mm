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

#import "SRPBigNum.h"
#import "SRPInternal.hpp"
#import <SRPXX.hpp>

NS_ASSUME_NONNULL_BEGIN

@interface SRPBigNum()

@property( atomic, readwrite, assign ) SRP::BigNum * cppObject;

@end

NS_ASSUME_NONNULL_END

@implementation SRPBigNum

+ ( nullable instancetype )fromString: ( NSString * )value format: ( SRPBigNumStringFormat )format
{
    auto n = SRP::BigNum::fromString( value.UTF8String, static_cast< SRP::BigNum::StringFormat >( format ) );
    
    if( n == nullptr )
    {
        return nil;
    }
    
    return [ [ self alloc ] initWithCPPObject: *( n ) ];
}

+ ( instancetype )random: ( unsigned int )bits
{
    return [ [ self alloc ] initWithCPPObject: SRP::BigNum::random( bits ) ];
}

- ( instancetype )initWithCPPObject: ( const SRP::BigNum & )cppObject
{
    if( ( self = [ super init ] ) )
    {
        self.cppObject = new SRP::BigNum( cppObject );
    }
    
    return self;
}

- ( instancetype )init
{
    return [ self initWithCPPObject: {} ];
}

- ( instancetype )initWithData: ( NSData * )data endianness: ( SRPBigNumEndianness )endianness
{
    return [ self initWithCPPObject: { SRPCPPDataWithData( data ), static_cast< SRP::BigNum::Endianness >( endianness ) } ];
}

- ( instancetype )initWithInt64: ( int64_t )value
{
    return [ self initWithCPPObject: { value } ];
}

- ( nullable instancetype )copyWithZone: ( nullable NSZone * )zone
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: *( self.cppObject ) ];
}

- ( oneway void )dealloc
{
    delete self.cppObject;
}

- ( NSString * )string: ( SRPBigNumStringFormat )format
{
    return SRPStringWithCPPString( self.cppObject->string( static_cast< SRP::BigNum::StringFormat >( format ) ) );
}

- ( NSData * )bytes: ( SRPBigNumEndianness )endianness
{
    return SRPDataWithCPPData( self.cppObject->bytes( static_cast< SRP::BigNum::Endianness >( endianness ) ) );
}

- ( NSString * )description
{
    return [ self string: SRPBigNumStringFormatDecimal ];
}

- ( NSUInteger )hash
{
    return [ self string: SRPBigNumStringFormatDecimal ].hash;
}

- ( NSComparisonResult )compare: ( nullable id )object
{
    if( [ object isKindOfClass: [ SRPBigNum class ] ] == NO )
    {
        return NSOrderedDescending;
    }
    
    SRPBigNum * n = object;
    
    if( *( self.cppObject ) < *( n.cppObject ) )
    {
        return NSOrderedAscending;
    }
    else if( *( self.cppObject ) > *( n.cppObject ) )
    {
        return NSOrderedDescending;
    }
    
    return NSOrderedSame;
}

- ( BOOL )isEqual: ( nullable id )object
{
    return [ self compare: object ] == NSOrderedSame;
}

- ( BOOL )isEqualTo: ( nullable id )object
{
    return [ self compare: object ] == NSOrderedSame;
}

- ( BOOL )isNotEqualTo: ( nullable id )object
{
    return [ self compare: object ] != NSOrderedSame;
}

- ( BOOL )isLessThanOrEqualTo: ( nullable id )object
{
    return [ self compare: object ] != NSOrderedDescending;
}

- ( BOOL )isLessThan: ( nullable id )object
{
    return [ self compare: object ] == NSOrderedAscending;
}

- ( BOOL )isGreaterThanOrEqualTo: ( nullable id )object
{
    return [ self compare: object ] != NSOrderedAscending;
}

- ( BOOL )isGreaterThan: ( nullable id )object
{
    return [ self compare: object ] == NSOrderedDescending;
}

@end

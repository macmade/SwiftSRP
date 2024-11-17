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

#ifdef __cplusplus
namespace SRP
{
    class BigNum;
}
#endif

typedef NS_ENUM( NSInteger, SRPBigNumEndianness )
{
    SRPBigNumEndiannessBigEndian,
    SRPBigNumEndiannessLittleEndian
};

typedef NS_ENUM( NSInteger, SRPBigNumStringFormat )
{
    SRPBigNumStringFormatAuto,
    SRPBigNumStringFormatDecimal,
    SRPBigNumStringFormatHexadecimal
};

NS_ASSUME_NONNULL_BEGIN

@interface SRPBigNum: NSObject

#ifdef __cplusplus

@property( atomic, readonly ) SRP::BigNum * cppObject;

- ( instancetype )initWithCPPObject: ( const SRP::BigNum & )cppObject NS_DESIGNATED_INITIALIZER;

#endif

+ ( nullable instancetype )fromString: ( NSString * )value format: ( SRPBigNumStringFormat )format;
+ (          instancetype )random: ( unsigned int )bits;

- ( instancetype )init;
- ( instancetype )initWithData: ( NSData * )data endianness: ( SRPBigNumEndianness )endianness;
- ( instancetype )initWithInt64: ( int64_t )value;

- ( NSString * )string: ( SRPBigNumStringFormat )format NS_SWIFT_NAME( string(format:) );
- ( NSData * )bytes: ( SRPBigNumEndianness )endianness  NS_SWIFT_NAME( bytes(endianness:) );

- ( NSComparisonResult )compare: ( nullable id )object;

- ( BOOL )isEqual: ( nullable id )object;
- ( BOOL )isEqualTo: ( nullable id )object;
- ( BOOL )isNotEqualTo: ( nullable id )object;
- ( BOOL )isLessThanOrEqualTo: ( nullable id )object;
- ( BOOL )isLessThan: ( nullable id )object;
- ( BOOL )isGreaterThanOrEqualTo: ( nullable id )object;
- ( BOOL )isGreaterThan: ( nullable id )object;

@end

NS_ASSUME_NONNULL_END

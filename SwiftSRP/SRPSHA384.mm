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

#import "SRPSHA384.h"
#import "SRPInternal.hpp"
#import <SRPXX.hpp>

@implementation SRPSHA384

+ ( NSData * )bytesFromData: ( NSData * )data
{
    return SRPDataWithCPPData( SRP::SHA384::bytes( SRPCPPDataWithData( data ) ) );
}

+ ( NSData * )bytesFromString: ( NSString * )data
{
    return SRPDataWithCPPData( SRP::SHA384::bytes( data.UTF8String ) );
}

+ ( NSString * )stringFromData: ( NSData * )data   format: ( SRPStringHexFormat )format
{
    return SRPStringWithCPPString( SRP::SHA384::string( SRPCPPDataWithData( data ), static_cast< SRP::String::HexFormat >( format ) ) );
}

+ ( NSString * )stringFromString: ( NSString * )data format: ( SRPStringHexFormat )format
{
    return SRPStringWithCPPString( SRP::SHA384::string( data.UTF8String, static_cast< SRP::String::HexFormat >( format ) ) );
}

@end

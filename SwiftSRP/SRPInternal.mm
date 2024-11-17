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

#import "SRPInternal.hpp"

NSString * SRPStringWithCPPString( const std::string & s )
{
    NSMutableString * string = [ NSMutableString new ];
    
    [ string appendFormat: @"%s", s.c_str() ];
    
    return [ [ NSString alloc ] initWithString: string ];
}

NSData * SRPDataWithCPPData( const std::vector< uint8_t > & d )
{
    return [ NSData dataWithBytes: d.data() length: d.size() ];
}

std::vector< uint8_t > SRPCPPDataWithData( NSData * data )
{
    if( data == nil || data.length == 0 )
    {
        return {};
    }
    
    const uint8_t * bytes = static_cast< const uint8_t * >( data.bytes );
    
    return { bytes, bytes + data.length };
}

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

#import "SRPServer.h"
#import "SRPInternal.hpp"
#import <SRPXX.hpp>

NS_ASSUME_NONNULL_BEGIN

@interface SRPServer()

@property( atomic, readwrite, assign ) SRP::Server * cppObject;

@end

NS_ASSUME_NONNULL_END

@implementation SRPServer

- ( instancetype )init
{
    return [ self initWithIdentity: @"" hashAlgorithm: SRPHashAlgorithmSHA256 groupType: SRPGroupTypeNG2048 b: nil ];
}

- ( instancetype )initWithIdentity: ( NSString * )identity hashAlgorithm: ( SRPHashAlgorithm )hashAlgorithm groupType: ( SRPGroupType )groupType
{
    return [ self initWithIdentity: identity hashAlgorithm: hashAlgorithm groupType: groupType b: nil ];
}

- ( instancetype )initWithIdentity: ( NSString * )identity hashAlgorithm: ( SRPHashAlgorithm )hashAlgorithm groupType: ( SRPGroupType )groupType b: ( nullable SRPBigNum * )b
{
    if( ( self = [ super init ] ) )
    {
        if( b != nil )
        {
            self.cppObject = new SRP::Server( identity.UTF8String, static_cast< SRP::HashAlgorithm >( hashAlgorithm ), static_cast< SRP::Base::GroupType >( groupType ), *( b.cppObject ) );
        }
        else
        {
            self.cppObject = new SRP::Server( identity.UTF8String, static_cast< SRP::HashAlgorithm >( hashAlgorithm ), static_cast< SRP::Base::GroupType >( groupType ) );
        }
    }
    
    return self;
}

- ( oneway void )dealloc
{
    delete self.cppObject;
}

- ( NSString * )identity
{
    return SRPStringWithCPPString( self.cppObject->identity() );
}

- ( NSData * )salt
{
    return SRPDataWithCPPData( self.cppObject->salt() );
}

- ( void )setSalt: ( NSData * )value
{
    self.cppObject->setSalt( SRPCPPDataWithData( value ) );
}

- ( SRPBigNum * )N
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->N() ];
}

- ( SRPBigNum * )g
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->g() ];
}

- ( SRPBigNum * )k
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->k() ];
}

- ( SRPBigNum * )u
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->u() ];
}

- ( SRPBigNum * )A
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->A() ];
}

- ( void )setA: ( SRPBigNum * )value
{
    self.cppObject->setA( *( value.cppObject ) );
}

- ( SRPBigNum * )b
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->b() ];
}

- ( SRPBigNum * )B
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->B() ];
}

- ( SRPBigNum * )v
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->v() ];
}

- ( void )setV: ( SRPBigNum * )value
{
    self.cppObject->setV( *( value.cppObject ) );
}

- ( SRPBigNum * )S
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->S() ];
}

- ( NSData * )K
{
    return SRPDataWithCPPData( self.cppObject->K() );
}

- ( NSData * )M1
{
    return SRPDataWithCPPData( self.cppObject->M1() );
}

- ( NSData * )M2
{
    return SRPDataWithCPPData( self.cppObject->M2() );
}

@end

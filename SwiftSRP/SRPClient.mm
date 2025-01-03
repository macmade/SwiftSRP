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

#import "SRPClient.h"
#import "SRPInternal.hpp"
#import <SRPXX.hpp>

NS_ASSUME_NONNULL_BEGIN

@interface SRPClient()

@property( atomic, readwrite, assign ) SRP::Client * cppObject;

@end

NS_ASSUME_NONNULL_END

@implementation SRPClient

- ( instancetype )init
{
    return [ self initWithIdentity: @"" hashAlgorithm: SRPHashAlgorithmSHA256 groupType: SRPGroupTypeNG2048 a: nil ];
}

- ( instancetype )initWithIdentity: ( NSString * )identity hashAlgorithm: ( SRPHashAlgorithm )hashAlgorithm groupType: ( SRPGroupType )groupType
{
    return [ self initWithIdentity: identity hashAlgorithm: hashAlgorithm groupType: groupType a: nil ];
}

- ( instancetype )initWithIdentity: ( NSString * )identity hashAlgorithm: ( SRPHashAlgorithm )hashAlgorithm groupType: ( SRPGroupType )groupType a: ( nullable SRPBigNum * )a
{
    if( ( self = [ super init ] ) )
    {
        if( a != nil )
        {
            self.cppObject = new SRP::Client( identity.UTF8String, static_cast< SRP::HashAlgorithm >( hashAlgorithm ), static_cast< SRP::Base::GroupType >( groupType ), *( a.cppObject ) );
        }
        else
        {
            self.cppObject = new SRP::Client( identity.UTF8String, static_cast< SRP::HashAlgorithm >( hashAlgorithm ), static_cast< SRP::Base::GroupType >( groupType ) );
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

- ( SRPBigNum * )a
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->a() ];
}

- ( SRPBigNum * )A
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->A() ];
}

- ( SRPBigNum * )B
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->B() ];
}

- ( void )setB: ( SRPBigNum * )value
{
    self.cppObject->setB( *( value.cppObject ) );
}

- ( SRPBigNum * )x
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->x() ];
}

- ( SRPBigNum * )v
{
    return [ [ SRPBigNum alloc ] initWithCPPObject: self.cppObject->v() ];
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

- ( void )setPasswordString: ( NSString * )value
{
    self.cppObject->setPassword( value.UTF8String );
}

- ( void )setPasswordData: ( NSData * )value
{
    self.cppObject->setPassword( SRPCPPDataWithData( value ) );
}

- ( void )setOptions: ( uint64_t )value
{
    self.cppObject->setOptions( value );
}

- ( void )addOption: ( SRPClientOptions )option
{
    self.cppObject->addOption( static_cast< SRP::Client::Options >( option ) );
}

- ( void )removeOption: ( SRPClientOptions )option
{
    self.cppObject->removeOption( static_cast< SRP::Client::Options >( option ) );
}

- ( BOOL )hasOption: ( SRPClientOptions )option
{
    return self.cppObject->hasOption( static_cast< SRP::Client::Options >( option ) );
}

@end

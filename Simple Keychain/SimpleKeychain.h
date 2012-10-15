//
//  SimpleKeychain.h
//  SDHLibrary
//
//  Created by Kristian Kraljic on 10/10/12.
//  Copyright (c) 2012 Kristian Kraljic (dikrypt.com, ksquared.de). All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface SimpleKeychain : NSObject

+(SimpleKeychain*)defaultKeychain;

-(NSUInteger)count;
-(NSUInteger)countOfService:(NSString*)service;

-(NSArray*)keys;
-(NSArray*)keysOfService:(NSString*)service;

-(NSArray*)values;
-(NSArray*)valuesOfService:(NSString*)service;

-(id)objectForKey:(NSString*)key;
-(id)objectForKey:(NSString*)key ofService:(NSString*)service;

-(OSStatus)setObject:(id)object forKey:(NSString*)key;
-(OSStatus)setObject:(id)object forKey:(NSString*)key ofService:(NSString*)service;

-(OSStatus)removeObjectForKey:(NSString*)key;
-(OSStatus)removeObjectForKey:(NSString*)key ofService:(NSString*)service;

@end

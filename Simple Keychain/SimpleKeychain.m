//
//  SimpleKeychain.m
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

#import "SimpleKeychain.h"

@interface SimpleKeychain()

-(NSDictionary*)dictionaryForService:(NSString*)service;
-(OSStatus)dictionary:(NSDictionary*)dictionary forService:(NSString*)service;
+(NSString*)defaultService;

@end

@implementation SimpleKeychain

+(SimpleKeychain*)defaultKeychain {
    static SimpleKeychain* instance = nil; static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{ instance = [[self alloc] init]; });
    return instance;
}

-(NSUInteger)count { return [self countOfService:nil]; }
-(NSUInteger)countOfService:(NSString*)service {
    return [[self dictionaryForService:service] count];
}

-(NSArray*)keys { return [self keysOfService:nil]; }
-(NSArray*)keysOfService:(NSString*)service {
    return [[self dictionaryForService:service] allKeys];
}

-(NSArray*)values { return [self valuesOfService:nil]; }
-(NSArray*)valuesOfService:(NSString*)service {
    return [[self dictionaryForService:service] allValues];
}

-(id)objectForKey:(NSString*)key { return [self objectForKey:key ofService:nil]; }
-(id)objectForKey:(NSString*)key ofService:(NSString*)service {
    return [[self dictionaryForService:service] objectForKey:key];
}

-(OSStatus)setObject:(id)object forKey:(NSString*)key { return [self setObject:object forKey:key ofService:nil]; }
-(OSStatus)setObject:(id)object forKey:(NSString*)key ofService:(NSString*)service {
    NSMutableDictionary* dictionary = [[self dictionaryForService:service] mutableCopy];
    [dictionary setObject:object forKey:key];
    return [self dictionary:dictionary forService:service];
}

-(OSStatus)removeObjectForKey:(NSString*)key { return [self removeObjectForKey:key ofService:nil]; }
-(OSStatus)removeObjectForKey:(NSString*)key ofService:(NSString*)service {
    NSMutableDictionary* dictionary = [[self dictionaryForService:service] mutableCopy];
    [dictionary removeObjectForKey:key];
    return [self dictionary:dictionary forService:service];
}

-(NSDictionary*)dictionaryForService:(NSString*)service {
    CFDictionaryRef result = NULL;
    if(!service) service = [SimpleKeychain defaultService];
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)[NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,[service dataUsingEncoding:NSUTF8StringEncoding],(__bridge id)kSecAttrService,(__bridge id)kCFBooleanTrue,(__bridge id)kSecReturnAttributes,(__bridge id)kCFBooleanTrue, (__bridge id)kSecReturnData,nil],(CFTypeRef *)&result);
    if(status==errSecSuccess&&result) {
        NSData* data = [(__bridge_transfer NSDictionary *)result valueForKey:(__bridge id)kSecAttrGeneric];
        if(data&&[data length]) {
            @try {
                NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
                NSDictionary* dictionary = [unarchiver decodeObjectForKey:@"dictionary"]; [unarchiver finishDecoding];
                return dictionary;
            } @catch (NSException *exception) { return [NSDictionary dictionary]; }
        } else return [NSDictionary dictionary];
    } else return [NSDictionary dictionary];
}
-(OSStatus)dictionary:(NSDictionary*)dictionary forService:(NSString*)service {
    if(!service) service = [SimpleKeychain defaultService];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)[NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,[service dataUsingEncoding:NSUTF8StringEncoding],(__bridge id)kSecAttrService,nil]);
         if(status!=errSecSuccess&&status!=errSecItemNotFound) return status;
    else if(!dictionary) return YES;
    NSMutableData* data = [NSMutableData data];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dictionary forKey:@"dictionary"]; [archiver finishEncoding];
    return SecItemAdd((__bridge CFDictionaryRef)[NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,[service dataUsingEncoding:NSUTF8StringEncoding],(__bridge id)kSecAttrService,data,(__bridge id)kSecAttrGeneric,nil],NULL);
}

+(NSString*)defaultService {
    NSString* identifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    return identifier?identifier:@"SimpleKeychain";
}

@end

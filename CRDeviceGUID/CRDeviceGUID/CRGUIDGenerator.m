//
//  CRGUIDGenerator.m
//  CRDeviceGUID
//
//  Created by Corotata on 2017/4/13.
//  Copyright © 2017年 Corotata. All rights reserved.
//

#import "CRGUIDGenerator.h"
#import <SSKeychain/SSKeychain.h>

static  NSString *kDeviceIDKey = @"CRGUIDGenerator";
@interface CRGUIDGenerator ()

@property (nonatomic, strong) NSString *deviceGUID;

@end

@implementation CRGUIDGenerator

+ (id)sharedInstance
{
    static dispatch_once_t pred;
    static CRGUIDGenerator *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[CRGUIDGenerator alloc] init];
    });
    return sharedInstance;
}


- (NSString *)deviceGUID {
    if (_deviceGUID == nil)
    {
        NSString *uuidStr = [SSKeychain passwordForService:kDeviceIDKey account:kDeviceIDKey error:nil];
        if(uuidStr && uuidStr.length > 0){
            _deviceGUID = [uuidStr copy];
        }else {
            _deviceGUID =  [self createGUID];
            [SSKeychain setPassword:_deviceGUID forService:kDeviceIDKey account:kDeviceIDKey];
        }
    }
    return _deviceGUID;
}



- (NSString *)createGUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    CFStringRef uuidCFStr = CFUUIDCreateString(NULL, uuid);
    return [NSString stringWithFormat:@"%@", uuidCFStr];
}


@end

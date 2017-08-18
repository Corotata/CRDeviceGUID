//
//  CRGUIDGenerator.m
//  CRDeviceGUID
//
//  Created by Corotata on 2017/4/13.
//  Copyright © 2017年 Corotata. All rights reserved.
//

#import "CRGUIDGenerator.h"
#import <SSKeychain/SSKeychain.h>

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
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *mDeviceUUID = [userDefaults valueForKey:kDeviceIDKey];
        if (!mDeviceUUID) {
            mDeviceUUID = [self p_deviceUUIDFromKeyChain];
            [userDefaults setObject:mDeviceUUID forKey:kDeviceIDKey];
            [userDefaults synchronize];
        }
        _deviceGUID = mDeviceUUID;
    }
    return _deviceGUID;
}


- (NSString *)p_deviceUUIDFromKeyChain {
    NSError *error = nil;
    NSString *uuidStr = [SSKeychain passwordForService:kDeviceIDKey account:kDeviceIDKey error:&error];
    if (error) {
        NSLog(@"========= 设备GUID 无法取得,原因为：%@ ==========",error);
    }
    if(!uuidStr){
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        assert(uuid != NULL);
        CFStringRef uuidCFStr = CFUUIDCreateString(NULL, uuid);
        uuidStr = [NSString stringWithFormat:@"%@", uuidCFStr];
        [SSKeychain setPassword:uuidStr forService:kDeviceIDKey account:kDeviceIDKey];
        NSLog(@"========= 创建新的uuid,%@ ==========",uuidStr);
    }
    return uuidStr;
}



- (NSString *)createGUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    CFStringRef uuidCFStr = CFUUIDCreateString(NULL, uuid);
    return [NSString stringWithFormat:@"%@", uuidCFStr];
}


@end

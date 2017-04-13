//
//  UIDevice+GUID.m
//  CRDeviceGUID
//
//  Created by Corotata on 2017/4/13.
//  Copyright © 2017年 Corotata. All rights reserved.
//

#import "UIDevice+GUID.h"
#import "CRGUIDGenerator.h"
@implementation UIDevice (GUID)

- (NSString *)cr_deviceGUID {
    return [[CRGUIDGenerator sharedInstance]deviceGUID];
}

@end

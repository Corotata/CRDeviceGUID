//
//  CRGUIDGenerator.h
//  CRDeviceGUID
//
//  Created by Corotata on 2017/4/13.
//  Copyright © 2017年 Corotata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRGUIDGenerator : NSObject

+ (id)sharedInstance;

- (NSString *)deviceGUID;

- (NSString *)createGUID;

@end

//
//  DeviceInfo.h
//  HandRuler
//
//  Created by 盛鹏超 on 15/3/21.
//  Copyright (c) 2015年 盛鹏超. All rights reserved.
//

#ifndef HandRuler_DeviceInfo_h
#define HandRuler_DeviceInfo_h


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UtilityMacro.h"

@interface DeviceInfo : NSObject

DECLARE_SINGLETON_FOR_CLASS(DeviceInfo)
- (CGSize) getRealSize;//获得设备的毫米数

@end



#endif

//
//  DeviceInfo.m
//  HandRuler
//
//  Created by 盛鹏超 on 15/3/21.
//  Copyright (c) 2015年 盛鹏超. All rights reserved.
//
#import "Deviceinfo.h"
#import "sys/utsname.h"


@implementation DeviceInfo

SYNTHESIZE_SINGLETON_FOR_CLASS(DeviceInfo)


- (CGSize) getRealSize{
    CGSize size;
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSLog(@"%@",deviceString);
    
    CGSize sizeResolution;
    CGFloat fScreenSzie = 0;
    NSRange range;
    do {
        range = [deviceString rangeOfString:@"iphone3"];//iphone4
        if (range.location != NSNotFound) {
            sizeResolution = CGSizeMake(320  , 480);
            fScreenSzie = 3.5;
            break;
        }
        range = [deviceString rangeOfString:@"iphone4"];//iphone4s
        if (range.location != NSNotFound) {
            sizeResolution = CGSizeMake(640, 960);
            fScreenSzie = 3.5;
            break;
        }
        range = [deviceString rangeOfString:@"iphone5"];//iphone5  5c
        if (range.location != NSNotFound) {
            sizeResolution = CGSizeMake(640, 1136);
            fScreenSzie = 4;
            break;
        }
        range = [deviceString rangeOfString:@"iphone6"];//iphone5s
        if (range.location != NSNotFound) {
            sizeResolution = CGSizeMake(640, 1136);
            fScreenSzie = 4;
            break;
        }
        range = [deviceString rangeOfString:@"iphone7"];//iphone6
        if (range.location != NSNotFound) {
            sizeResolution = CGSizeMake(750, 1334);
            fScreenSzie = 4.7;
            break;
        }
        range = [deviceString rangeOfString:@"ipad1"];//ipad
        if (range.location != NSNotFound) {
            sizeResolution = CGSizeMake(768, 1024);
            fScreenSzie = 9.7;
            break;
        }
        range = [deviceString rangeOfString:@"ipad2,5"];//ipad mini
        if (range.location != NSNotFound) {
            sizeResolution = CGSizeMake(768, 1024);
            fScreenSzie = 9.7;
            break;
        }
        range = [deviceString rangeOfString:@"ipad2"];//ipad2
        if (range.location != NSNotFound) {
            sizeResolution = CGSizeMake(768, 1024);
            fScreenSzie = 9.7;
            break;
        }
        range = [deviceString rangeOfString:@"ipad3"];//ipad3
        if (range.location != NSNotFound) {
            sizeResolution = CGSizeMake(1536, 2048);
            fScreenSzie = 9.7;
            break;
        }
        range = [deviceString rangeOfString:@"x86_64"];//模拟器
        if (range.location != NSNotFound) {
            sizeResolution = CGSizeMake(750, 1334);
            fScreenSzie = 4.7;
//            sizeResolution = CGSizeMake(640, 960);
//            fScreenSzie = 3.5;
            sizeResolution = CGSizeMake(768, 1024);
            fScreenSzie = 9.7;
            break;
        }
        NSLog(@"NOTE: Unknown device type: %@", deviceString);
        return size;
    } while (false);
    
    //1英寸等于25.4毫米
    size.height = fScreenSzie*sizeResolution.height*25.4
    /(sqrt(sizeResolution.height*sizeResolution.height+sizeResolution.width*sizeResolution.width));
    
    
    return size;
}

@end
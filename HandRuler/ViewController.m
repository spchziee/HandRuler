//
//  ViewController.m
//  HandRuler
//
//  Created by 盛鹏超 on 15/3/21.
//  Copyright (c) 2015年 盛鹏超. All rights reserved.
//

#import "ViewController.h"
#import "DeviceInfo.h"

static CGFloat kMinScreenHeight = 30.0;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bSwap = false;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat fScreenHeight = [userDefaults floatForKey:@"inputScreenHeight"];
    if (fScreenHeight>kMinScreenHeight) {
        _realSize.height =fScreenHeight;
    } else {
        _realSize = [[DeviceInfo sharedDeviceInfo] getRealSize];
    }
    
    _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
    [self.view addSubview:_imageView];
    _imageView.userInteractionEnabled = true;    //UIImageView默认不会响应事件,需要设置
    _imageView.backgroundColor = [UIColor blackColor];
    
    _buttonForSwap = [[UIButton alloc] init];
    [_buttonForSwap setTitle:@"点击切换方向" forState:UIControlStateNormal];
    [_buttonForSwap setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [_buttonForSwap addTarget:self action:@selector(buttonForSwapClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:_buttonForSwap];
    
    _buttonForCalc = [[UIButton alloc] init];
    [_buttonForCalc setTitle:@"双击设置校准" forState:UIControlStateNormal];
    [_buttonForCalc setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [_buttonForCalc addTarget:self action:@selector(buttonForCalcDoubleClicked:withEvent:) forControlEvents:UIControlEventTouchDownRepeat];
    [_imageView addSubview:_buttonForCalc];
    
    [self adjustControlPos];
    [self drawRuler];
   
#warning 添加单位切换功能
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) drawRuler{
    CGRect rcScreen = _imageView.frame;
    CGFloat fPointPerMm = [[UIScreen mainScreen] bounds].size.height/_realSize.height;
    NSLog(@"fPointPerMm = %f",fPointPerMm);
    
    CGFloat fStart = rcScreen.size.height - 10.0;
    CGFloat fEnd = 10;
    UIFont *font = [UIFont boldSystemFontOfSize:(16)];
    UIGraphicsBeginImageContext(_imageView.frame.size);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);  //线宽
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 NSForegroundColorAttributeName:[[UIColor alloc] initWithRed:0.2 green:0.7 blue:0.3 alpha:1]
                                 };
    int nCount = 0;
    if (_bSwap) {
        fStart = 10;
        fEnd = rcScreen.size.height-10;
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), rcScreen.size.width-5, fStart);  //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), rcScreen.size.width-5, fEnd);   //终点坐标
        while (fStart<fEnd) {
            CGFloat fLength = 10.0;
            if (nCount%10==0) {
                fLength = 20.0;
                NSString *strIndex = [NSString stringWithFormat:@"%d",nCount/10];
                [strIndex drawInRect:CGRectMake(rcScreen.size.width-25-fLength, fStart-8, 80, 20) withAttributes:attributes];
            } else if (nCount%5==0){
                fLength = 15.0;
            }
            nCount++;
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), rcScreen.size.width-5, fStart);  //起点坐标
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), rcScreen.size.width-5-fLength, fStart);   //终点坐标
            fStart +=fPointPerMm;
        }
    }else {
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 5, fStart);  //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 5, fEnd);   //终点坐标
        while (fStart>fEnd) {
            CGFloat fLength = 10.0;
            if (nCount%10==0) {
                fLength = 20.0;
                NSString *strIndex = [NSString stringWithFormat:@"%d",nCount/10];
                [strIndex drawInRect:CGRectMake(10+fLength, fStart-8, 80, 20) withAttributes:attributes];
            } else if (nCount%5==0){
                fLength = 15.0;
            }
            nCount++;
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 5, fStart);  //起点坐标
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 5+fLength, fStart);   //终点坐标
            fStart -=fPointPerMm;
        }
    }
    
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    _imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void) adjustControlPos{
    CGRect rcScreen = [[UIScreen mainScreen] bounds];
    if (_bSwap) {
        _buttonForSwap.frame =CGRectMake(80, rcScreen.size.height/3, 120, 24);
        _buttonForCalc.frame =CGRectMake(80, rcScreen.size.height*2/3, 120, 24);
    }
    else {
        _buttonForSwap.frame =CGRectMake(rcScreen.size.width-200, rcScreen.size.height/3, 120, 24);
        _buttonForCalc.frame =CGRectMake(rcScreen.size.width-200, rcScreen.size.height*2/3, 120, 24);
    }
}

-(void) buttonForSwapClicked:(UIButton *)sender {
    _bSwap = !_bSwap;
    [self adjustControlPos];
    [self drawRuler];
}

-(void) buttonForCalcDoubleClicked:(UIButton*)sender withEvent:(UIEvent*)event{
    UITouch *touch  = [[event allTouches] anyObject];
    if (touch.tapCount==2) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"输入屏幕真实尺寸" message:@"(毫米)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        NSString * strInput = [alertView textFieldAtIndex:0].text;
        CGFloat fInput = [strInput floatValue];
        if (fInput>30&&fInput<300) {
            _realSize.height = fInput;
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setFloat:fInput forKey:@"inputScreenHeight"];
            [self drawRuler];
        }
        else {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setFloat:0 forKey:@"inputScreenHeight"];
        }
    }
}

@end

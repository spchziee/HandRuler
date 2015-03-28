//
//  ViewController.h
//  HandRuler
//
//  Created by 盛鹏超 on 15/3/21.
//  Copyright (c) 2015年 盛鹏超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIAlertViewDelegate>
{
    UIImageView *_imageView;
    UIButton *_buttonForSwap;
    UIButton *_buttonForCalc;
    BOOL _bSwap;
    CGSize _realSize;
}


@end


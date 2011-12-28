//
//  RoundDiskViewController.h
//  TryRoundDisk
//
//  Created by msh on 11-12-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundDiskViewController : UIViewController
{
    UIImageView* disk;
    float angle;
    
    NSTimer* timer;
    BOOL updateEnable;
}
- (float) toAngle:(CGPoint) v;
- (void)setRotate:(float)degress;
- (CGPoint) cgpSub:(CGPoint)v1: (CGPoint)v2;
- (void)update;
@end

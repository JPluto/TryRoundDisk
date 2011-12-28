//
//  RoundDiskViewController.m
//  TryRoundDisk
//
//  Created by msh on 11-12-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "RoundDiskViewController.h"
#import "QuartzCore/CADisplayLink.h"
#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 57.29577951f)
#define CC_DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) * 0.01745329252f)
@implementation RoundDiskViewController


#pragma mark - View lifecycle
- (void)setRotate:(float)degress
{
    
//    NSLog(@"%f",degress);
    float rotate = CC_DEGREES_TO_RADIANS(degress);
    
    CGAffineTransform transform = disk.transform; 	 
	transform = CGAffineTransformRotate(transform, rotate);
	disk.transform = transform; 
    
}

- (CGPoint) cgpSub:(CGPoint)v1: (CGPoint)v2
{
    CGPoint point;
    point.x = v1.x - v2.x;
    point.y = v1.y - v2.y;
    
    return point; 
}
- (float) toAngle:(CGPoint) v
{
    return atan2f(v.x, v.y);
}
- (void)update
{
    if(updateEnable)
    {
        if(fabs(angle)>1)
        {
            [self setRotate:angle];
            angle = 0.99*angle;
        }
        else 
        {
            angle = 0;
        }  
    }

}
- (void)viewDidLoad
{
    updateEnable = NO;
    angle = 0;
   
    [super viewDidLoad];
    disk = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disk.png"]];
    disk.center = self.view.center;
    [self.view addSubview:disk];
    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    timer =[ NSTimer timerWithTimeInterval:1.0f/60 target:self selector:@selector(update) userInfo:nil repeats:YES];
    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];


}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    updateEnable = NO;
    angle = 0;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
        UITouch *touch = [touches anyObject];

        CGPoint previousLocation = [touch previousLocationInView:touch.view];
        CGPoint previouscgp = [self cgpSub:previousLocation :disk.center];
        float previousVector = [self toAngle:previouscgp];
        
        float previousDrgress = CC_RADIANS_TO_DEGREES(previousVector);
        
        CGPoint nowLocation = [touch locationInView:touch.view];
        CGPoint nowcgp = [self cgpSub:nowLocation :disk.center];
        float nowVector = [self toAngle:nowcgp];
        float nowDrgress = CC_RADIANS_TO_DEGREES(nowVector);

        angle = -(nowDrgress - previousDrgress);
        NSLog(@"%f",angle);
        [self setRotate:angle];

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    updateEnable = YES;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    [timer invalidate];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

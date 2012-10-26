//
//  ViewController.m
//  FollowMe
//
//  Created by HEYMES Lucas on 26/10/12.
//  Copyright (c) 2012 Heymès Lucas. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    oldLocation = imageView.center;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint newLocation = [[touches anyObject] locationInView:self.view];
    CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef movePath = CGPathCreateMutable();
    CGPathMoveToPoint(movePath, nil, oldLocation.x, oldLocation.y);
    CGPathAddLineToPoint(movePath, nil, newLocation.x, newLocation.y);
    [imageView setCenter:newLocation];
    [move setPath:movePath];
    CGPathRelease(movePath);
    
    CAKeyframeAnimation *rotate = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSMutableArray *valuesArray = [NSMutableArray array];
    CATransform3D rStep;
    for (int i=0; i<360; i++) {
        rStep = CATransform3DMakeRotation(0.017544*i, 0, 1, 1);
        [valuesArray addObject:[NSValue valueWithCATransform3D:rStep]];
    }
    [rotate setValues:valuesArray];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    [animationGroup setDuration:1.0];
    [animationGroup setAnimations:[NSArray arrayWithObjects:move, rotate, nil]];
    CALayer *viewLayer = imageView.layer;
    [viewLayer addAnimation:animationGroup forKey:@"animations"];
    oldLocation = newLocation;
}
@end

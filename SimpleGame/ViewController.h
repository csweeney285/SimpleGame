//
//  ViewController.h
//  SimpleGame
//
//  Created by Conor Sweeney on 12/14/15.
//  Copyright © 2015 Conor Sweeney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic,strong) UIPushBehavior *ballPush;

@property (strong, nonatomic) UIView *myBar;
@property (strong, nonatomic) UIView *myBall;

@property (strong, nonatomic) UIView *border1;
@property (strong, nonatomic) UIView *border2;
@property (strong, nonatomic) UIView *border3;
@property (strong, nonatomic) UIView *border4;

@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property long counter;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property long highScore;
@property double barX;

@property float firstX;
@property float firstY;

- (IBAction)resetButton:(id)sender;
- (IBAction)startButton:(id)sender;

@end


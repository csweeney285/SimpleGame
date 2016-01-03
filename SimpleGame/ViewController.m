//
//  ViewController.m
//  SimpleGame
//
//  Created by Conor Sweeney on 12/14/15.
//  Copyright © 2015 Conor Sweeney. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    UIDynamicItemBehavior *ballBehavior;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.counterLabel.center = self.view.center;
    self.view.backgroundColor = [UIColor greenColor];
    
    
    self.myBar  = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x-30, (self.view.frame.size.height - 16), 60, 15)];
    self.myBar.backgroundColor = [UIColor blackColor];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    [self.view addSubview:self.myBar];
    
    self.myBall  = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x-10, 1, 20, 20)];
    self.myBall.backgroundColor = [UIColor redColor];
    self.myBall.layer.cornerRadius = 10;

    [self.view addSubview:self.myBall];
    self.highScore = 0;
    self.highScoreLabel.text = [NSString stringWithFormat:@"%ld",self.highScore];

    self.counter = 0;
    [self setCounterText];
    [self createBorder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createBar{
    if (self.barX + 60 > (self.view.frame.size.width - 60)) {
        self.barX = (self.view.frame.size.width - 60);
    }
    else if (self.barX < 0)
    {
        self.barX = 0;
    }
    self.myBar.frame = CGRectMake(self.barX, (self.view.frame.size.height - 16), 60, 15);
    [self.animator updateItemUsingCurrentState:self.myBar];
}

-(void) createBall{
    self.myBall.center = CGPointMake(self.view.center.x -10, 10);
    [self.animator updateItemUsingCurrentState:self.myBall];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    self.barX = touchLocation.x;
    [self createBar];
}

- (IBAction)resetButton:(id)sender {
    self.counter = 0;
    [self setCounterText];
    [self.animator removeAllBehaviors];
    [self createBall];
}

- (IBAction)startButton:(id)sender {
    self.counter = 0;
    [self setCounterText];
    
    if (self.ballPush == nil) {
        [self addAnimations];
        [self initAnimation];
    }
    else{
        [self.animator removeAllBehaviors];
        [self createBall];
        [self addAnimations];
        [self initAnimation];
    }
}

-(void) initAnimation
{
    self.ballPush = [[UIPushBehavior alloc]initWithItems:@[self.myBall] mode:UIPushBehaviorModeInstantaneous];
    int x = arc4random_uniform(6) - 3;
    int w = arc4random_uniform(10);
    int z = arc4random_uniform(10);
    int y = arc4random_uniform(6) - 3;
    
    float i = x - (w * 0.1);
    float j = y - (z * 0.1);
    
    self.ballPush.pushDirection = CGVectorMake(i,j);
    self.ballPush.magnitude = .2;
    [self.animator addBehavior:self.ballPush];
    
}

-(void) addAnimations{
    ballBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.myBall]];
    ballBehavior.friction = 0.0000;
    ballBehavior.elasticity = 1.08;
    ballBehavior.resistance = 0.0;
    
    UIDynamicItemBehavior *barBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.myBar]];
    barBehavior.friction = 0.0000;
    barBehavior.density = 100000000000;
    barBehavior.elasticity = 1.15;
    barBehavior.resistance = 0;
    barBehavior.anchored = YES;
    
    UIDynamicItemBehavior *border1Behavior = [[UIDynamicItemBehavior alloc]initWithItems:@[self.border1]];
    border1Behavior.friction = 0.0000;
    border1Behavior.density = 100000000000;
    border1Behavior.elasticity = 1.02;
    border1Behavior.resistance = 0;
    border1Behavior.anchored = YES;
    
    UIDynamicItemBehavior *border2Behavior = [[UIDynamicItemBehavior alloc]initWithItems:@[self.border2]];
    border2Behavior.friction = 0.0000;
    border2Behavior.density = 100000000000;
    border2Behavior.elasticity = 1.02;
    border2Behavior.resistance = 0;
    border2Behavior.anchored = YES;
    
    UIDynamicItemBehavior *border3Behavior = [[UIDynamicItemBehavior alloc]initWithItems:@[self.border3]];
    border3Behavior.friction = 0.0000;
    border3Behavior.density = 100000000000;
    border3Behavior.elasticity = 1.02;
    border3Behavior.resistance = 0;
    border3Behavior.anchored = YES;
    
    UIDynamicItemBehavior *border4Behavior = [[UIDynamicItemBehavior alloc]initWithItems:@[self.border4]];
    border4Behavior.anchored = YES;
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.myBall, self.myBar,self.border4]];
    // Creates collision boundaries from the bounds of the dynamic animator's
    // reference view (self.view).
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    collisionBehavior.collisionDelegate = self;
    
    
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:ballBehavior];
    [self.animator addBehavior:barBehavior];
    [self.animator addBehavior:border1Behavior];
    [self.animator addBehavior:border2Behavior];
    [self.animator addBehavior:border3Behavior];
    [self.animator addBehavior:border4Behavior];


}

-(void)createBorder{
    self.border1  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.view.frame.size.height)];
    self.border1.backgroundColor = [UIColor greenColor];
    
    self.border2 =[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width -1, 0, 1, self.view.frame.size.height)];
    self.border2.backgroundColor = [UIColor greenColor];
    
    self.border3 = [[UIView alloc]initWithFrame:CGRectMake(1,0,self.view.frame.size.width-1,1)];
    self.border3.backgroundColor = [UIColor greenColor];
    
    self.border4 = [[UIView alloc]initWithFrame:CGRectMake(1, self.view.frame.size.height-1, self.view.frame.size.width -1, 1)];
    self.border4.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:self.border1];
    [self.view addSubview:self.border2];
    [self.view addSubview:self.border3];
    [self.view addSubview:self.border4];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p{
    
    //end game with bottom border and ball collision
    if ((item1 == self.myBall && item2 == self.border4)||(item1 == self.border4 && item2 == self.myBall)) {
        NSLog(@"You lose");
        self.counter=0;
        [self.animator removeAllBehaviors];
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"You Lose"
                                      message:@"Press OK"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [self setCounterText];
                                 
                             }];
        [alert addAction:ok]; // add action to uialertcontroller
    }

    //Bar and Ball Collision
    if ((item1 == self.myBall && item2 == self.myBar)||(item1 == self.myBar && item2 == self.myBall)) {
        NSLog(@"Paddle Hit");
        self.counter++;
        NSLog(@"Count - %ld",self.counter);
        [self setCounterText];
        
    }

}

-(void)setCounterText{
    self.counterLabel.text = [NSString stringWithFormat:@"%ld",self.counter];
    if (self.counter > self.highScore) {
        self.highScore = self.counter;
        self.highScoreLabel.text = [NSString stringWithFormat:@"%ld",self.highScore];
    }
}


@end

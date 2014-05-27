//
//  GameControllerViewController.m
//  GameController
//
//  Created by Peterlee on 5/13/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "GameControllerViewController.h"

@interface GameControllerViewController ()

@end

@implementation GameControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerDidConnect) name:GCControllerDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerDisConnect) name:GCControllerDidDisconnectNotification object:nil];
    

    // Do any additional setup after loading the view from its nib.
}
-(void) controllerDidConnect
{
    NSLog(@"%s",__PRETTY_FUNCTION__);


}
-(void) controllerDisConnect
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
-(void)viewWillAppear:(BOOL)animated
{

    [GCController startWirelessControllerDiscoveryWithCompletionHandler:^{
        
        [[GCController controllers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            GCController *controller=(GCController *)obj;
            self.gameController =controller;
            NSLog(@"discover vendorName:%@ attrached:%d  gamepad:%@ playerIndex:%ld",controller.vendorName,controller.attachedToDevice,controller.gamepad,(long)controller.playerIndex);
            
            GCGamepad *pad = self.gameController.gamepad;
            pad.buttonA.valueChangedHandler =  ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                [self.buttonA setHighlighted:pressed];
            };
            
            pad.buttonB.valueChangedHandler =  ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                [self.buttonB setHighlighted:pressed];
            };
            
            pad.buttonX.valueChangedHandler =  ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                [self.buttonX setHighlighted:pressed];
            };
            
            pad.buttonY.valueChangedHandler =  ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                [self.buttonY setHighlighted:pressed];
            };
            
            pad.dpad.up.valueChangedHandler =  ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                [self.upButton setHighlighted:pressed];
            };
            pad.dpad.down.valueChangedHandler =  ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                [self.downBtton setHighlighted:pressed];
            };
            pad.dpad.left.valueChangedHandler =  ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                [self.leftButton setHighlighted:pressed];
            };
            pad.dpad.right.valueChangedHandler =  ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                [self.rightButton setHighlighted:pressed];
            };
            
     
            
            GCExtendedGamepad *profile = self.gameController.extendedGamepad;
            
            
            profile.leftThumbstick.valueChangedHandler = ^(GCControllerDirectionPad *dpad, float xValue, float yValue)
            {
                NSLog(@"leftThumbStick:%@,xValue:%f,yValue:%f",dpad,xValue,yValue);
            };
            profile.rightThumbstick.valueChangedHandler = ^(GCControllerDirectionPad *dpad, float xValue, float yValue)
            {
                NSLog(@"rightThumbStick:%@,xValue:%f,yValue:%f",dpad,xValue,yValue);
            };
            
            
            profile.leftShoulder.valueChangedHandler= ^ (GCControllerButtonInput *button, float value, BOOL pressed)
            {
                [self.l1Button setHighlighted:pressed];
            };
            profile.rightShoulder.valueChangedHandler= ^ (GCControllerButtonInput *button, float value, BOOL pressed)
            {
                  [self.r1Button setHighlighted:pressed];
            };
            
            profile.rightTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                [self.r2Button setHighlighted:pressed];
            };
            profile.leftTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                  [self.l2Button setHighlighted:pressed];
            };


            
        }];
        
    }];
    
    
  }


@end

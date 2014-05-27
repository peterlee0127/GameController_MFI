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
            NSLog(@"discover vendorName:%@ gamepad:%@ playerIndex:%ld",controller.vendorName,controller.gamepad,controller.playerIndex);
        }];
        
    }];

    
    GCGamepad *pad = self.gameController.gamepad;
    pad.buttonA.valueChangedHandler =  ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        NSLog(@"buttonA:%d",pressed);
    };

    pad.buttonB.valueChangedHandler =  ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        NSLog(@"buttonB:%d",pressed);
    };
    
    pad.buttonX.valueChangedHandler =  ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        NSLog(@"buttonX:%d",pressed);
    };
    
    pad.buttonY.valueChangedHandler =  ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        NSLog(@"buttonY:%d",pressed);
    };
    
    
    
    

    GCExtendedGamepad *profile = self.gameController.extendedGamepad;
    profile.rightTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        NSLog(@"rightTrigger:%@,Value:%f,Pressed:%d",button,value,pressed);
    };
    profile.leftTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        NSLog(@"leftTrigger:%@,Value:%f,Pressed:%d",button,value,pressed);
    };
    
    
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
        NSLog(@"leftShoulder:%@,Value:%f,Pressed:%d",button,value,pressed);
    };
    profile.rightShoulder.valueChangedHandler= ^ (GCControllerButtonInput *button, float value, BOOL pressed)
    {
        NSLog(@"rightShoulder:%@,Value:%f,Pressed:%d",button,value,pressed);
    };
}


@end

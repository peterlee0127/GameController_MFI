//
//  GameControllerViewController.m
//  GameController
//
//  Created by Peterlee on 5/13/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "GameControllerViewController.h"
#import "InfoViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>


@interface GameControllerViewController () <CBCentralManagerDelegate>

@property (nonatomic,strong) CBCentralManager *centralManager;
@property (nonatomic,strong) UIView *activityAlertView;

@end

@implementation GameControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName = @"";
    if([UIScreen mainScreen].bounds.size.height==480)
    {
        nibName = @"GameControllerViewController_35";
    }
    else
    {
        nibName = @"GameControllerViewController";
    }
    self=[super initWithNibName:nibName bundle:nil];
    if (self) {
   
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.activityAlertView=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2- 210, 60, 420, 160)];
    self.activityAlertView.alpha=0.9;
    
    UITextView *waitLabel =[[UITextView alloc] initWithFrame:CGRectMake(self.activityAlertView.frame.origin.y-30, 0, 380, 160)];
    waitLabel.textAlignment=NSTextAlignmentLeft;
    waitLabel.userInteractionEnabled=NO;
    waitLabel.backgroundColor=[UIColor clearColor];
    waitLabel.text=@"Loading your controller Information,it will take few seconds.\n(please ensure already connected to MFi Controller)";
    waitLabel.font=[UIFont fontWithName:@"Helvetica" size:24];
    [self.activityAlertView addSubview:waitLabel];
    
    self.activityAlertView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.activityAlertView];
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() ];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerDidConnect) name:GCControllerDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerDisConnect) name:GCControllerDidDisconnectNotification object:nil];
    
    [self.infoButton addTarget:self action:@selector(showInfoVC) forControlEvents:UIControlEventTouchDown];

    // Do any additional setup after loading the view from its nib.
}

#pragma mark - CentrolManager Delegate
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // Determine the state of the peripheral
    if ([central state] == CBCentralManagerStatePoweredOff) {
        NSLog(@"CoreBluetooth BLE hardware is powered off");
        UIAlertView *notPoweredOn = [[UIAlertView alloc] initWithTitle:@"Please Ensure your Bluetooth is On" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [notPoweredOn show];
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
        NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
//        [central scanForPeripheralsWithServices:nil options:nil];
        UIAlertView *notPoweredOn = [[UIAlertView alloc] initWithTitle:@"BLE hardware is powered on and ready, now scanning" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [notPoweredOn show];
    }
    else if ([central state] == CBCentralManagerStateUnauthorized) {
        NSLog(@"CoreBluetooth BLE state is unauthorized");
    }
    else if ([central state] == CBCentralManagerStateUnknown) {
        NSLog(@"CoreBluetooth BLE state is unknown");
    }
    else if ([central state] == CBCentralManagerStateUnsupported) {
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
        UIAlertView *notPoweredOn = [[UIAlertView alloc] initWithTitle:@"BLE hardware is unsupported on this platform" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [notPoweredOn show];
    }
}
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
     NSLog(@"Discovered %@", peripheral.name);
}

#pragma mark - Notification Center
-(void) controllerDidConnect
{
    [[GCController controllers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        GCController *controller=(GCController *)obj;
        self.gameController =controller;
        NSLog(@"discover vendorName:%@ attrached:%d  gamepad:%@ playerIndex:%ld"
              ,controller.vendorName,controller.attachedToDevice,controller.gamepad,(long)controller.playerIndex);
        [self.activityAlertView removeFromSuperview];
        
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
        
        
        GCExtendedGamepad *extendPad = self.gameController.extendedGamepad;
        extendPad.leftThumbstick.valueChangedHandler = ^(GCControllerDirectionPad *dpad, float xValue, float yValue)
        {
            NSLog(@"leftThumbStick:%@,xValue:%f,yValue:%f",dpad,xValue,yValue);
        };
        extendPad.rightThumbstick.valueChangedHandler = ^(GCControllerDirectionPad *dpad, float xValue, float yValue)
        {
            NSLog(@"rightThumbStick:%@,xValue:%f,yValue:%f",dpad,xValue,yValue);
        };
        extendPad.leftShoulder.valueChangedHandler= ^ (GCControllerButtonInput *button, float value, BOOL pressed)
        {
            [self.l1Button setHighlighted:pressed];
        };
        extendPad.rightShoulder.valueChangedHandler= ^ (GCControllerButtonInput *button, float value, BOOL pressed)
        {
            [self.r1Button setHighlighted:pressed];
        };
        extendPad.rightTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
        {
            [self.r2Button setHighlighted:pressed];
        };
        extendPad.leftTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
        {
            [self.l2Button setHighlighted:pressed];
        };
    }];


}
-(void) controllerDisConnect
{
    [GCController startWirelessControllerDiscoveryWithCompletionHandler:^{
        NSLog(@"startWirelessControllerDiscoveryWithCompletionHandler");
    }];
}
-(void) showInfoVC
{
    InfoViewController *infoVC=[[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    [self presentViewController:infoVC animated:YES completion:nil];
}


@end

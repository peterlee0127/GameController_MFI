//
//  GameControllerViewController.h
//  GameController
//
//  Created by Peterlee on 5/13/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameController/GameController.h>

@interface GameControllerViewController : UIViewController

@property (nonatomic,strong) GCController *gameController;


@property (nonatomic,strong) IBOutlet UIButton *leftButton;
@property (nonatomic,strong) IBOutlet UIButton *rightButton;
@property (nonatomic,strong) IBOutlet UIButton *upButton;
@property (nonatomic,strong) IBOutlet UIButton *downBtton;


@property (nonatomic,strong) IBOutlet UIButton *buttonX;
@property (nonatomic,strong) IBOutlet UIButton *buttonA;
@property (nonatomic,strong) IBOutlet UIButton *buttonB;
@property (nonatomic,strong) IBOutlet UIButton *buttonY;


@property (nonatomic,strong) IBOutlet UIButton *leftThumbStickButton;
@property (nonatomic,strong) IBOutlet UIButton *rightThumbStickButton;

@property (nonatomic,strong) IBOutlet UIButton *l1Button;
@property (nonatomic,strong) IBOutlet UIButton *l2Button;
@property (nonatomic,strong) IBOutlet UIButton *r1Button;
@property (nonatomic,strong) IBOutlet UIButton *r2Button;


@property (nonatomic,strong) IBOutlet UIButton *infoButton;

@end

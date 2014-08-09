//
//  AOGameScene.m
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 15/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import "AOTitleScene.h"
#import "AOBackgroundNode.h"
#import "AOMainTitleNode.h"
#import "AOStartGameNode.h"
#import "AOSpaceShipNode.h"
#import "AOProjectileNode.h"
#import "AOGamePlayScene.h"
#import <AVFoundation/AVFoundation.h>
#import "AOUtil.h"

@interface AOTitleScene ()

@property (nonatomic) SKAction *pressStartSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@property (nonatomic) AOGamePlayScene *gamePlayScene;
@property (nonatomic) SKTransition *transition;

@end


@implementation AOTitleScene

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        AOBackgroundNode *background = [AOBackgroundNode createBackground];
        
        
        
        
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        
        //AOMainTitleNode *title = [AOMainTitleNode mainTitleAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+150)];
        //[self addChild:title];
        
        SKSpriteNode *logo = [SKSpriteNode spriteNodeWithImageNamed:@"logo"];
        logo.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+150);
        [self addChild:logo];
        
        
        
        AOStartGameNode *start = [AOStartGameNode pressStartAtPosition:CGPointMake(CGRectGetMidX(self.frame), logo.position.y-350)];
        [self addChild:start];
        
        
        
        
        
        
        
        
        AOSpaceShipNode *spaceShip = [AOSpaceShipNode createSpaceShipAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)) ofType:AOSpaceShipTypeBig];
        
        
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"StartScreen" withExtension:@"mp3"];
        
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.backgroundMusic.numberOfLoops = -1;
        [self.backgroundMusic prepareToPlay];
        
        

        
        
       
        [self addChild:spaceShip];
        
        
        [spaceShip performStartAnimation];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            _gamePlayScene = [AOGamePlayScene sceneWithSize:self.frame.size];
            _transition = [SKTransition fadeWithDuration:1];
        
        });
        
        
        
        
        
        
    }
    return self;

}

-(void) didMoveToView:(SKView *)view{
    
    if (AOMusicEnabled) {
        [self.backgroundMusic play];
    }
    
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    

        
        
    
    [self.view presentScene:_gamePlayScene transition:_transition];
   [self runAction:[SKAction playSoundFileNamed:@"start3.caf" waitForCompletion:NO]];
       
        

    
    

}

-(void)shootProjectile{
    
  
    
    AOSpaceShipNode *spaceShip = (AOSpaceShipNode *)[self childNodeWithName:@"SpaceShip2"];
    
    
    
    AOProjectileNode *projectile = [AOProjectileNode createProjectileAtPosition:CGPointMake(spaceShip.position.x, spaceShip.position.y+200)];
    
    
    [self addChild:projectile];
    
}





@end











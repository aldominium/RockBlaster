//
//  AOHudNode.m
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 21/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import "AOHudNode.h"
#import "AOUtil.h"
#import "AOGameData.h"

@implementation AOHudNode

+ (instancetype) hudAtPosition:(CGPoint) position inFrame:(CGRect)frame{
    
    AOHudNode *hud = [self node];
    hud.position = position;
    hud.zPosition = 20;
    hud.name = @"HUD";
    
    
    hud.lives = AOMaxLives;
    
    SKSpriteNode *lastLifeBar;
    
    
    for (int i = 0; i < hud.lives; i++) {
        SKSpriteNode *lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"life"];
        lifeBar.name = [NSString stringWithFormat:@"Life%d",i+1];
        lifeBar.xScale = 1.5;
        lifeBar.yScale = 1.5;
        
        [hud addChild:lifeBar];
        
        if (lastLifeBar == nil) {
            lifeBar.position = CGPointMake(10, 5);
        }else{
            
            lifeBar.position = CGPointMake(lastLifeBar.position.x + 25, lastLifeBar.position.y);
            
        }
        
        lastLifeBar = lifeBar;
        
    }
    
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    scoreLabel.name = @"Score";
    scoreLabel.text = @"0";
    scoreLabel.fontSize  = 20;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    scoreLabel.position = CGPointMake(frame.size.width-20, 10);
    [hud addChild:scoreLabel];
    
    
    SKLabelNode *highScoreLabel = [[SKLabelNode alloc] initWithFontNamed:@"Futura-CondensedExtraBold"];
    highScoreLabel.name = @"Score";
    highScoreLabel.text = [NSString stringWithFormat:@"High: %li pt", [AOGameData sharedGameData].highScore];;
    highScoreLabel.fontSize  = 20;
    highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    highScoreLabel.position = CGPointMake(frame.size.width-20, -20);
    [hud addChild:highScoreLabel];
    
    
    return hud;
    
    
}


-(void) addPoints:(NSInteger)points{
    
    [AOGameData sharedGameData].score += points;
    SKLabelNode *scoreLabel = (SKLabelNode *)[self childNodeWithName:@"Score"];
    scoreLabel.text = [NSString stringWithFormat:@"%li pt", [AOGameData sharedGameData].score];
    
    
   
    
    
    
}


//Si las vidas son igual a 0, regresa true
-(BOOL)loseLife{
    if (self.lives > 0) {
        NSString *lifeNodeName = [NSString stringWithFormat:@"Life%ld",(long)self.lives];
        SKNode *liveToRemove = [self childNodeWithName:lifeNodeName];
        [liveToRemove removeFromParent];
        self.lives --;
    }
    
    return self.lives == 0;
    
}


@end

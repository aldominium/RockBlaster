//
//  AOHudNode.m
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 21/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import "AOHudNode.h"
#import "AOUtil.h"

@implementation AOHudNode

+ (instancetype) hudAtPosition:(CGPoint) position inFrame:(CGRect)frame{
    
    AOHudNode *hud = [self node];
    hud.position = position;
    hud.zPosition = 20;
    hud.name = @"HUD";
    
    
    hud.lives = AOMaxLives;
    NSLog(@"HUDlives %f", position.y);
    
    SKSpriteNode *lastLifeBar;
    
    
    for (int i = 0; i < hud.lives; i++) {
        SKSpriteNode *lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"life"];
        lifeBar.name = [NSString stringWithFormat:@"Life%d",i+1];
        
        [hud addChild:lifeBar];
        
        if (lastLifeBar == nil) {
            lifeBar.position = CGPointMake(10, 10);
        }else{
            
            lifeBar.position = CGPointMake(lastLifeBar.position.x + 20, lastLifeBar.position.y);
            
        }
        
        lastLifeBar = lifeBar;
        
    }
    
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    scoreLabel.name = @"Score";
    scoreLabel.text = @"0";
    scoreLabel.fontSize  = 24;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    scoreLabel.position = CGPointMake(frame.size.width-20, 0);
    [hud addChild:scoreLabel];
    
    
    return hud;
    
    
}


-(void) addPoints:(NSInteger)points{
    
    self.score += points;
    SKLabelNode *scoreLabel = (SKLabelNode *)[self childNodeWithName:@"Score"];
    scoreLabel.text = [NSString stringWithFormat:@"%d",self.score];
    
    
}


//Si las vidas son igual a 0, regresa true
-(BOOL)loseLife{
    if (self.lives > 0) {
        NSString *lifeNodeName = [NSString stringWithFormat:@"Life%d",self.lives];
        SKNode *liveToRemove = [self childNodeWithName:lifeNodeName];
        [liveToRemove removeFromParent];
        self.lives --;
    }
    
    return self.lives == 0;
    
}


@end

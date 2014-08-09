//
//  AOGameOverNode.m
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 15/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import "AOGameOverNode.h"

@implementation AOGameOverNode


+(instancetype)gameOverAtPosition:(CGPoint)position{
    
    AOGameOverNode *gameOver = [self node];
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Bold"];
    gameOverLabel.name = @"GameOver";
    gameOverLabel.text = @"Game Over";
    gameOverLabel.fontSize = 48;
    gameOverLabel.position = position;
    [gameOver addChild:gameOverLabel];
    
    return gameOver;
    
}

-(void) performAnimation{
    SKLabelNode *label = (SKLabelNode*)[self childNodeWithName:@"GameOver"];
    label.xScale = 0;
    label.yScale = 0;
    SKAction *scaleUp = [SKAction scaleTo:1.2f duration:0.75f];
    SKAction *scaleDown = [SKAction scaleTo:0.9f duration:0.25f];
    SKAction *run = [SKAction runBlock:^{
        
        SKLabelNode *touchToRestart = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Bold"];
        touchToRestart.text = @"Restart";
        touchToRestart.name = @"Restart";
        touchToRestart.fontSize = 24;
        touchToRestart.position = CGPointMake(label.position.x, label.position.y-50);
        [self addChild:touchToRestart];
        
        SKLabelNode *share = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Bold"];
        share.text = @"Share Score";
        share.name = @"Share";
        share.fontSize = 24;
        share.position = CGPointMake(label.position.x, label.position.y-100);
        [self addChild:share];
        
    }];
    
    SKAction *scaleSequence = [SKAction sequence:@[scaleUp,scaleDown,run]];
    
    [label runAction:scaleSequence];
}


@end

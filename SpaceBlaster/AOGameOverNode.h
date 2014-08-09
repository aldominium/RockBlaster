//
//  AOGameOverNode.h
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 15/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AOGameOverNode : SKNode

+(instancetype)gameOverAtPosition:(CGPoint)position;

-(void)performAnimation;

@end

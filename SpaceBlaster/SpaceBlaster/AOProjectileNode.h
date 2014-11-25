//
//  AOProjectileNode.h
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 17/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AOProjectileNode : SKSpriteNode

+(instancetype)createProjectileAtPosition:(CGPoint)position;

-(void)shoot;

-(void)setUpPhysicsBody;


@end

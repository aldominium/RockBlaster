//
//  AOGamePlayScene.h
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 18/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@interface AOGamePlayScene : SKScene <SKPhysicsContactDelegate>

-(id)initWithSize:(CGSize)size;

-(void)shootProjectile;

-(void)createDebrisAtPosition:(CGPoint) position;

-(void)setUpSounds;

@end

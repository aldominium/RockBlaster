//
//  AOSpaceShipNode.h
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 15/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AOSpaceShipNode : SKSpriteNode

typedef NS_ENUM(NSUInteger, AOSpaceShipType) {
    AOSpaceShipTypeSmall,
    AOSpaceShipTypeBig
};


+(instancetype)createSpaceShipAtPosition:(CGPoint)position ofType:(AOSpaceShipType)type;

-(void) performStartAnimation;

-(void) performReduceAnimation;

-(void) performTiltAnimation;

-(void)moveToStartingPoint;

-(void)setUpPhysicsBody;



@end

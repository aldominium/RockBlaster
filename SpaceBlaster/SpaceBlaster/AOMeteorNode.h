//
//  AOMeteorNode.h
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 18/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AOMeteorNode : SKSpriteNode
+(instancetype)createMeteor;

-(void)setUpPhysicsBody;

@end

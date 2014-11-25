//
//  AOAmmoNode.h
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 08/08/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AOAmmoNode : SKSpriteNode

+(instancetype)createAmmoAtPosition:(CGPoint)position;

-(void)changeState:(NSInteger)state;

@end

//
//  AOHudNode.h
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 21/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AOHudNode : SKNode

@property (nonatomic) NSInteger lives;
@property (nonatomic) NSInteger score;

+ (instancetype) hudAtPosition:(CGPoint) position inFrame:(CGRect)frame;

-(void) addPoints:(NSInteger)points;
-(BOOL) loseLife;

@end

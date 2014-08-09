//
//  AOStartGameNode.m
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 15/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import "AOStartGameNode.h"

@implementation AOStartGameNode
+(instancetype)pressStartAtPosition:(CGPoint)position{
    
   
    
    AOStartGameNode *start = [self labelNodeWithFontNamed:@"Orbitron-Bold"];
    
    start.name = @"PressStart";
    start.text = @"Press Start";
    start.fontSize = 28;
    start.position = position;
    
    return start;

}
@end

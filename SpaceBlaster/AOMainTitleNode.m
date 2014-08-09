//
//  AOMainTitleNode.m
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 15/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import "AOMainTitleNode.h"

@implementation AOMainTitleNode

+(instancetype)mainTitleAtPosition:(CGPoint)position{
    
   
    
    AOMainTitleNode *title = (AOMainTitleNode*)[self labelNodeWithFontNamed:@"Orbitron-Bold"];
    
    title.name = @"MainTitle";
    title.text = @"Space Blaster";
    title.fontSize = 36;
    title.position = position;
    
    return title;

}

@end










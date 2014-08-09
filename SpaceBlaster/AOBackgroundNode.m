//
//  AOBackgroundNode.m
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 15/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import "AOBackgroundNode.h"

@implementation AOBackgroundNode

+ (instancetype) createBackground{
    
    AOBackgroundNode *background;
    NSArray *textures;
    
    background = [self spriteNodeWithImageNamed:@"bg-stars_00"];
    textures = @[[SKTexture textureWithImageNamed:@"bg-stars_00"],
                 [SKTexture textureWithImageNamed:@"bg-stars_01"],
                 [SKTexture textureWithImageNamed:@"bg-stars_02"],
                 [SKTexture textureWithImageNamed:@"bg-stars_03"],
                 [SKTexture textureWithImageNamed:@"bg-stars_04"],
                 [SKTexture textureWithImageNamed:@"bg-stars_05"],
                 [SKTexture textureWithImageNamed:@"bg-stars_06"],
                 [SKTexture textureWithImageNamed:@"bg-stars_07"],
                 [SKTexture textureWithImageNamed:@"bg-stars_08"],
                 [SKTexture textureWithImageNamed:@"bg-stars_09"],
                 [SKTexture textureWithImageNamed:@"bg-stars_10"],
                 [SKTexture textureWithImageNamed:@"bg-stars_11"],
                 [SKTexture textureWithImageNamed:@"bg-stars_12"],
                 [SKTexture textureWithImageNamed:@"bg-stars_13"],
                 [SKTexture textureWithImageNamed:@"bg-stars_14"],
                 [SKTexture textureWithImageNamed:@"bg-stars_15"],
                 [SKTexture textureWithImageNamed:@"bg-stars_16"],
                 [SKTexture textureWithImageNamed:@"bg-stars_17"],
                 [SKTexture textureWithImageNamed:@"bg-stars_18"],];
   
    
    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.05];
    [background runAction:[SKAction repeatActionForever:animation]];
    
    background.name = @"bg";
    
    
    return background;
    
}


@end

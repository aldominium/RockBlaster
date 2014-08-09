//
//  AOSpaceShipNode.m
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 15/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import "AOSpaceShipNode.h"
#import "AOUtil.h"

@interface AOSpaceShipNode ()
@property SKAction *animationAction;
@end

@implementation AOSpaceShipNode


+(instancetype)createSpaceShipAtPosition:(CGPoint)position ofType:(AOSpaceShipType)type{
    AOSpaceShipNode *spaceShip;
    
    
    if (type == AOSpaceShipTypeSmall) {
        spaceShip  = [self spriteNodeWithImageNamed:@"ship-small_01"];
        
        NSArray *textures = @[[SKTexture textureWithImageNamed:@"ship-small_01"],
                              [SKTexture textureWithImageNamed:@"ship-small_02"],
                              [SKTexture textureWithImageNamed:@"ship-small_03"],
                              [SKTexture textureWithImageNamed:@"ship-small_04"],];
        
        
        SKAction *animation = [SKAction repeatActionForever:[SKAction animateWithTextures:textures timePerFrame:0.1 resize:YES restore:NO]];
        
        
        
        [spaceShip runAction:animation];
    }else{
        
        spaceShip = [self spriteNodeWithImageNamed:@"ship-big"];
    
    }
    
    spaceShip.position = position;
    spaceShip.name = @"SpaceShip";
    spaceShip.zPosition = 900;
    
    [spaceShip setUpPhysicsBody];
    
    
    
    return spaceShip;
}

-(void)moveToStartingPoint{
    

    SKAction *move = [SKAction moveToY:100 duration:1];
    
    
    
    SKAction *reduce = [SKAction scaleBy:1/3.5 duration:1];
    
    SKAction *fadeOut = [SKAction fadeOutWithDuration:1];
    
    
    SKAction *group = [SKAction group:@[move,reduce,fadeOut]];
    
    
    [self runAction:group];
    //[ship runAction:animation];
    
}

-(void) performStartAnimation{
    
    
    
    
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"ship-morph0001"],
                          [SKTexture textureWithImageNamed:@"ship-morph0002"],
                          [SKTexture textureWithImageNamed:@"ship-morph0003"],
                          [SKTexture textureWithImageNamed:@"ship-morph0004"],
                          [SKTexture textureWithImageNamed:@"ship-morph0005"],
                          [SKTexture textureWithImageNamed:@"ship-morph0006"],
                          [SKTexture textureWithImageNamed:@"ship-morph0007"],
                          [SKTexture textureWithImageNamed:@"ship-morph0008"],
                          [SKTexture textureWithImageNamed:@"ship-morph0009"],
                          [SKTexture textureWithImageNamed:@"ship-morph0010"],
                          [SKTexture textureWithImageNamed:@"ship-morph0011"],
                          [SKTexture textureWithImageNamed:@"ship-morph0012"],
                          [SKTexture textureWithImageNamed:@"ship-morph0013"],
                          [SKTexture textureWithImageNamed:@"ship-morph0014"],
                          [SKTexture textureWithImageNamed:@"ship-morph0015"],
                          [SKTexture textureWithImageNamed:@"ship-morph0016"],
                          [SKTexture textureWithImageNamed:@"ship-morph0017"],
                          [SKTexture textureWithImageNamed:@"ship-morph0018"],
                          [SKTexture textureWithImageNamed:@"ship-morph0019"],
                          [SKTexture textureWithImageNamed:@"ship-morph0020"],
                          [SKTexture textureWithImageNamed:@"ship-morph0021"],
                          [SKTexture textureWithImageNamed:@"ship-morph0022"],
                          [SKTexture textureWithImageNamed:@"ship-morph0023"],
                          [SKTexture textureWithImageNamed:@"ship-morph0024"],
                          [SKTexture textureWithImageNamed:@"ship-morph0025"],
                          [SKTexture textureWithImageNamed:@"ship-morph0026"],
                          [SKTexture textureWithImageNamed:@"ship-morph0027"],
                          [SKTexture textureWithImageNamed:@"ship-morph0028"],
                          [SKTexture textureWithImageNamed:@"ship-morph0029"],
                          [SKTexture textureWithImageNamed:@"ship-morph0030"],
                          [SKTexture textureWithImageNamed:@"ship-morph0031"],
                          [SKTexture textureWithImageNamed:@"ship-morph0032"],
                          [SKTexture textureWithImageNamed:@"ship-morph0033"],
                          [SKTexture textureWithImageNamed:@"ship-morph0034"],
                          [SKTexture textureWithImageNamed:@"ship-morph0035"],
                          [SKTexture textureWithImageNamed:@"ship-morph0036"],
                          [SKTexture textureWithImageNamed:@"ship-morph0037"],
                          [SKTexture textureWithImageNamed:@"ship-morph0038"],
                          [SKTexture textureWithImageNamed:@"ship-morph0039"],
                          [SKTexture textureWithImageNamed:@"ship-morph0040"],];
    
    
    
    
    _animationAction = [SKAction animateWithTextures:textures timePerFrame:0.25];
    
    self.xScale = 3;
    self.yScale = 3;
    
    [self runAction:[SKAction animateWithTextures:textures timePerFrame:0.08]];
    
    
    

}

-(void) performReduceAnimation{
    
    SKAction *reduce = [SKAction scaleBy:1/3 duration:1];
    [self runAction:reduce];

}



-(void) performTiltAnimation{

    SKAction *fadeOut = [SKAction fadeAlphaTo:0.5 duration:0.2];
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.2];
    SKAction *tilt = [SKAction sequence:@[fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn,
                                          fadeOut,fadeIn]];
                      
                      
                      
    [self runAction:tilt];
    

}



-(void)setUpPhysicsBody{
    
    
    
    //Se le da su pologono de colision
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    
    //No le afecta la gravedad porque se movera con el dispositivo
    self.physicsBody.affectedByGravity = NO;
    
    self.physicsBody.dynamic = YES;
    
    self.physicsBody.mass = 0.02;
    
    //Le das la categoria de proyectil
    self.physicsBody.categoryBitMask = AOCollissionCategoryShip;
    
    //No choca con nadie
    self.physicsBody.collisionBitMask = AOCollissionCategoryWall;
    
    //Contra quienes hace contacto
    self.physicsBody.contactTestBitMask = AOCollissionCategoryMeteor;
    
    
    
}

    





@end














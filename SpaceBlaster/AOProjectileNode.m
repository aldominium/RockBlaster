//
//  AOProjectileNode.m
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 17/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import "AOProjectileNode.h"
#import "AOUtil.h"

@implementation AOProjectileNode

+(instancetype)createProjectileAtPosition:(CGPoint)position{
    
    AOProjectileNode *projectile = [self spriteNodeWithImageNamed:@"missile"];
    projectile.position = position;
    projectile.name =  @"Projectile";
    
    [projectile setUpPhysicsBody];
    
    return projectile;

}


-(void)shoot{

    SKAction *moveProjectile = [SKAction moveToY:500 duration:3];
    [self runAction:moveProjectile];
    
}



-(void)setUpPhysicsBody{
    
    
    
    //Se le da su pologono de colision
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    
    //No le afecta la gravedad porque va a tener velocidad
    self.physicsBody.affectedByGravity = NO;
    
    //Le das la categoria de proyectil
    self.physicsBody.categoryBitMask = AOCollissionCategoryProjectile;
    
    //No choca con nadie
    self.physicsBody.collisionBitMask = 0;
    
    //Contra quienes hace contacto
    self.physicsBody.contactTestBitMask = AOCollissionCategoryMeteor;
    
    
    
    
    
    
}


@end










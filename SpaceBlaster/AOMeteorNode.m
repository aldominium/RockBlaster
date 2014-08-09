//
//  AOMeteorNode.m
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 18/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import "AOMeteorNode.h"
#import "AOUtil.h"

@implementation AOMeteorNode
+(instancetype)createMeteor{

    AOMeteorNode *meteor;
    
    meteor = [self spriteNodeWithImageNamed:@"rock"];
    
    float scale = [AOUtil randomWithMin:AOMeteorMinSize max:AOMeteorMaxSize]/ 100.0f;
    
    meteor.xScale = scale;
    meteor.yScale = scale;
    meteor.physicsBody.mass = scale;
    
    [meteor setUpPhysicsBody];
    
    int rotateDuration = [AOUtil randomWithMin:90 max:360];
    
    [meteor runAction:[SKAction rotateByAngle:rotateDuration duration:60]];
    
    return meteor;
    
    

}

//Configura todo lo relacionado con la fisica
-(void)setUpPhysicsBody{
    
    //Pone el contorno con la fisica
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    
    //Le desactivamos la gravedad para en su lugar ponerle velocidad
    self.physicsBody.affectedByGravity = NO;
    
    
    //Le pone la categoria de meteor para las colisiones
    self.physicsBody.categoryBitMask = AOCollissionCategoryMeteor;
    
    //No colisiona con nadie(rebotes,etc)
    self.physicsBody.collisionBitMask = 0;
    
    //Hace contacto con la nave o los proyectiles
    self.physicsBody.contactTestBitMask = AOCollissionCategoryProjectile | AOCollissionCategoryShip;
    
    
}



@end






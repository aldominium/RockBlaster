//
//  AOAmmoNode.m
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 08/08/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import "AOAmmoNode.h"

@interface AOAmmoNode ()
@property NSInteger state;
@end


@implementation AOAmmoNode

+(instancetype)createAmmoAtPosition:(CGPoint)position{
    AOAmmoNode *ammo;
    ammo = [AOAmmoNode spriteNodeWithImageNamed:@"btn-reload-e8"];
    ammo.position = position;
    ammo.name =  @"Ammo";
    ammo.state = 5;
    ammo.xScale = 1.5;
    ammo.yScale = 1.5;
    
    return ammo;


}

-(void)changeState:(NSInteger)state{
    self.state = state;
    
    switch (self.state) {
        case 8:
            self.texture = [SKTexture textureWithImageNamed:@"btn-reload-e8"];
            break;
        case 7:
            self.texture = [SKTexture textureWithImageNamed:@"btn-reload-e7"];
            break;
        case 6:
            self.texture = [SKTexture textureWithImageNamed:@"btn-reload-e6"];
            break;
        case 5:
            self.texture = [SKTexture textureWithImageNamed:@"btn-reload-e5"];
            break;
        case 4:
            self.texture = [SKTexture textureWithImageNamed:@"btn-reload-e4"];
            break;
        case 3:
            self.texture = [SKTexture textureWithImageNamed:@"btn-reload-e3"];
            break;
        case 2:
            self.texture = [SKTexture textureWithImageNamed:@"btn-reload-e2"];
            break;
        case 1:
            self.texture = [SKTexture textureWithImageNamed:@"btn-reload-e1"];
            break;
        case 0:
            self.texture = [SKTexture textureWithImageNamed:@"btn-reload-e0"];
            break;
            
        default:
            break;
    }
    
}

@end

//
//  AOUtil.h
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 16/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int AOProjectileSpeed = 400;
static int AOMeteorMinSpeed = -150;
static int AOMeteorMaxSpeed = -100;
static const int AOMaxLives = 4;
static const int AOPointsPerHit = 100;
static const BOOL AOMusicEnabled = YES;
static const int AOMeteorMinSize = 100;
static const int AOMeteorMaxSize = 200;

//Para definir los tipos de las categorias de colisiones
typedef NS_OPTIONS(uint32_t, AOCollissionCategory) {
    AOCollissionCategoryMeteor       = 1 << 0,
    AOCollissionCategoryProjectile  = 1 << 1,
    AOCollissionCategoryDebris      = 1 << 2,
    AOCollissionCategoryShip      = 1 << 3,
    AOCollissionCategoryWall      = 1 << 4
};


@interface AOUtil : NSObject

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max;

@end

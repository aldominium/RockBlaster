//
//  AOGameData.h
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 10/08/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AOGameData : NSObject <NSCoding>

@property (assign, nonatomic) long highScore;
@property (assign, nonatomic) long score;

+(instancetype)sharedGameData;
-(void)reset;
-(void)save;
@end

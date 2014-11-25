//
//  AOGameData.m
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 10/08/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

#import "AOGameData.h"

@implementation AOGameData

static NSString* const SSGameDataHighScoreKey = @"highScore";

+ (instancetype)sharedGameData {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self loadInstance];
    });
    
    return sharedInstance;
}

-(void)reset
{
    self.score = 0;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeDouble:self.highScore forKey: SSGameDataHighScoreKey];
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [self init];
    if (self) {
        _highScore = [decoder decodeDoubleForKey: SSGameDataHighScoreKey];
    }
    return self;
}

+(NSString*)filePath
{
    static NSString* filePath = nil;
    if (!filePath) {
        filePath =
        [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
         stringByAppendingPathComponent:@"gamedata"];
    }
    return filePath;
}

+(instancetype)loadInstance
{
    NSData* decodedData = [NSData dataWithContentsOfFile: [AOGameData filePath]];
    if (decodedData) {
        AOGameData* gameData = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
        return gameData;
    }
    
    return [[AOGameData alloc] init];
}

-(void)save
{
    NSData* encodedData = [NSKeyedArchiver archivedDataWithRootObject: self];
    [encodedData writeToFile:[AOGameData filePath] atomically:YES];
}

@end

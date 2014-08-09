//
//  AOGamePlayScene.m
//  SpaceBlaster
//
//  Created by Aldo Olivares Dominguez on 18/07/14.
//  Copyright (c) 2014 Aldominium. All rights reserved.
//

/*
 To do:
 -HUD
 -Sonidos y música
 -movimiento de la nave(probarlo)
 -Game over
 -Bonuses
 -social
 -game center
 -boton de desactivar audio
 -boton pausa
 -gameplay music
 -QUITAR BUG DE PROYECTILES done
 -poner musica de fondo de juego
 
 */

#import "AOGamePlayScene.h"
#import "AOAmmoNode.h"
#import "AOBackgroundNode.h"
#import "AOSpaceShipNode.h"
#import "AOTitleScene.h"
#import "AOProjectileNode.h"
#import "AOMeteorNode.h"
#import "AOUtil.h"
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>
#import "AOHudNode.h"
#import "AOGameOverNode.h"
#import <Social/Social.h>

@interface AOGamePlayScene ()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;//Para saber cuanto hace que corrio el ultimo game loop
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded; //Para saber hace cuanto añadimos un enemigo
@property (nonatomic) NSTimeInterval totalGameTime;

@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;


//para los sonidos
@property (nonatomic) SKAction *damageSFX;
@property (nonatomic) SKAction *explodeSFX;
@property (nonatomic) SKAction *fireSFX;
@property (nonatomic) SKAction *gameOverVoiceSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@property (nonatomic) AVAudioPlayer *gameOverMusic;


//Para el flujo del juego
@property (nonatomic) BOOL gameOver;
@property (nonatomic) BOOL restart;
@property (nonatomic) BOOL gameOverDisplayed;
@property (nonatomic) NSInteger score;


//Para los disparos
@property (nonatomic) NSTimeInterval cooldownTimer;
@property (nonatomic) BOOL isBulletShot;
@property (nonatomic) BOOL isBulletReady;
@property (nonatomic) NSInteger bulletsLeft;



//Para el movimiento de la nave
@property (strong) CMMotionManager* motionManager;

@end

@implementation AOGamePlayScene


-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        self.lastUpdateTimeInterval = 0;
        self.timeSinceEnemyAdded = 0;
        self.addEnemyTimeInterval = 1.5;
        self.totalGameTime = 0;
        self.minSpeed = AOMeteorMinSpeed;
        self.restart = NO;
        self.gameOver = NO;
        self.gameOverDisplayed = NO;
        self.isBulletShot = NO;
        self.isBulletReady = YES;
        self.cooldownTimer = 0;
        self.bulletsLeft = 8;
        self.score = 0;
        
        
        /* Setup your scene here */
        AOBackgroundNode *background = [AOBackgroundNode createBackground];
        background.userInteractionEnabled = NO;
        
        
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        
        AOSpaceShipNode *spaceShip = [AOSpaceShipNode createSpaceShipAtPosition:CGPointMake(CGRectGetMidX(self.frame), 100) ofType:AOSpaceShipTypeSmall];
        [self addChild:spaceShip];
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8);
        
        //Indica que la escena es la que va a recibir las notificaciones de todos los contactos
        self.physicsWorld.contactDelegate = self;
        
        
        AOHudNode *hud = [AOHudNode hudAtPosition:CGPointMake(10, self.frame.size.height-40) inFrame:self.frame];
        
        
        
        [self addChild:hud];
        
        [self setUpSounds];
        
        
        
        
        AOAmmoNode *ammo = [AOAmmoNode createAmmoAtPosition:CGPointMake(40, 40)];
        
        [self addChild:ammo];
       
        
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        
        
        
    }
    return self;
    
}


//Da la hora del sistema en segundos
-(void) update:(NSTimeInterval)currentTime{
    
    SKNode *spaceShipNode = [self childNodeWithName:@"SpaceShip"];
    
    
    //To move the ship
    [self processUserMotionForUpdate:currentTime];
    
    //Esto es para la primera vez que se corre el game loop y poner valores
    //Si hay algun valor en lastUpdateTimeInterval, entramos en el if
    if (self.lastUpdateTimeInterval) {
        
        //Esto va aumentando el tiempo desde que se añadio el ultimo perro
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        
        //Esto va aumentando el tiempo que se ha jugado
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
        
        
    }
    
    if (self.isBulletShot) {
        self.cooldownTimer += currentTime -self.lastUpdateTimeInterval;
        NSLog(@"cooldon %f",self.cooldownTimer);
    }
    
    
    if (self.cooldownTimer >= 0.15) {
        self.isBulletShot = NO;
        self.isBulletReady = YES;
        self.cooldownTimer = 0;
    }
    
    
    if (self.timeSinceEnemyAdded > self.addEnemyTimeInterval && !self.gameOver && self.totalGameTime > 5.0) {
        [self addMeteor];
        self.timeSinceEnemyAdded = 0;
        if (self.totalGameTime > 30) {
            [self addMeteor];
        }
    }
    
    
    
    self.lastUpdateTimeInterval = currentTime;
    
    if (self.totalGameTime > 30) {
        self.addEnemyTimeInterval = 0.5;
        AOMeteorMinSpeed = -350;
        AOMeteorMaxSpeed = -300;
      
        
    } else if (self.totalGameTime > 15){
        self.addEnemyTimeInterval = 1.15;
        AOMeteorMinSpeed = -300;
        AOMeteorMaxSpeed = -250;
        
        
    }else if(self.totalGameTime > 10){
        self.addEnemyTimeInterval = 1.25;
        AOMeteorMinSpeed = -250;
        AOMeteorMaxSpeed = -200;
        
        
    }else if(self.totalGameTime >5){
        self.addEnemyTimeInterval = 1.5;
        AOMeteorMinSpeed = -200;
        AOMeteorMaxSpeed = -150;
            
        
    }
    //Si las vidas son 0
    if (self.gameOver && !self.gameOverDisplayed) {
        [self performGameOver];
    }
    
    
    
    
    
}

-(void)didMoveToView:(SKView *)view{

    self.motionManager = [[CMMotionManager alloc] init];
    [self.motionManager startAccelerometerUpdates];

}

-(void)processUserMotionForUpdate:(NSTimeInterval)currentTime {
    
    SKNode *spaceShipNode = [self childNodeWithName:@"SpaceShip"];
    
    //1
    SKSpriteNode* ship = (SKSpriteNode*)[self childNodeWithName:@"SpaceShip"];
    //2
    CMAccelerometerData* data = self.motionManager.accelerometerData;
    //3
    if (fabs(data.acceleration.x) > 0.1) {
        //4 How do you move the ship?
        [ship.physicsBody applyForce:CGVectorMake(30.0 * data.acceleration.x, 0)];
    }
}

-(void)setUpSounds{
    
    
    NSURL *gameOverUrl = [[NSBundle mainBundle] URLForResource:@"GameOverMusic" withExtension:@"mp3"];
    
    self.gameOverMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:gameOverUrl error:nil];
    self.gameOverMusic.numberOfLoops = 1;
    [self.gameOverMusic prepareToPlay];
    
    
    self.damageSFX = [SKAction playSoundFileNamed:@"hit2.caf" waitForCompletion:NO];
    self.explodeSFX = [SKAction playSoundFileNamed:@"Explosion2.caf" waitForCompletion:NO];
    self.fireSFX = [SKAction playSoundFileNamed:@"Fire.caf" waitForCompletion:NO];
    self.gameOverVoiceSFX = [SKAction playSoundFileNamed:@"GameOverVoice.caf" waitForCompletion:NO];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    if (!self.gameOver) {
        
        
        
        UITouch *touch = [touches anyObject];
        CGPoint touchLocation = [touch locationInNode:self];
        SKNode *touchedNode = [self nodeAtPoint:touchLocation];
        AOAmmoNode *ammo = (AOAmmoNode *)[self childNodeWithName:@"Ammo"];
        
        
        NSLog(@"touchLocation x: %f and y: %f", touchLocation.x, touchLocation.y);
        
        if (self.isBulletReady && self.bulletsLeft > 0 &&touchedNode != self && ![touchedNode.name  isEqual: @"Ammo"]) {
            [self shootProjectile];
            self.isBulletReady = NO;
            self.bulletsLeft--;
            [ammo changeState:self.bulletsLeft];
        }
        
        
        if (touchedNode != self && [touchedNode.name  isEqual: @"Ammo"]) {
            self.bulletsLeft = 8;
            [ammo changeState:self.bulletsLeft];
        }
        
            
 
        
    }else{ //if(self.restart)
        
        UITouch *touch = [touches anyObject];
        CGPoint touchLocation = [touch locationInNode:self];
        SKNode *touchedNode = [self nodeAtPoint:touchLocation];
        AOAmmoNode *ammo = (AOAmmoNode *)[self childNodeWithName:@"Ammo"];
        
        /*
        for (SKNode *node in [self children]) {
            [node removeFromParent];
        }
        
        AOGamePlayScene *scene = [AOGamePlayScene sceneWithSize:self.view.bounds.size];
        [self.view presentScene:scene];
         */
        
        if (touchedNode != self && [touchedNode.name  isEqual: @"Restart"]) {
            
            for (SKNode *node in [self children]) {
                [node removeFromParent];
            }
            
            AOGamePlayScene *scene = [AOGamePlayScene sceneWithSize:self.view.bounds.size];
            [self.view presentScene:scene];
            
        }
        
        if (touchedNode != self && [touchedNode.name  isEqual: @"Share"]) {
            
            SLComposeViewController *composer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [composer setInitialText:[NSString stringWithFormat:@"Just Scored %d points on Rock Blasters!!! \n #RockBlasters",self.score]];
            [self.view.window.rootViewController presentViewController:composer animated:YES completion:nil];
            
        }
        
        
    }
    
    
    
}




-(void) addMeteor{
    
    
    
    AOMeteorNode *meteor = [AOMeteorNode createMeteor];
    
    float dy = [AOUtil randomWithMin:AOMeteorMinSpeed max:AOMeteorMaxSpeed];
    
    meteor.physicsBody.velocity = CGVectorMake(0, dy);
    
    float y = self.frame.size.height + (meteor.size.height)/2;
    float x = [AOUtil randomWithMin:10+meteor.size.width
                                max:self.frame.size.width-meteor.size.width-10];
    
    
    meteor.position = CGPointMake(x, y);
    [self addChild:meteor];
    
}




-(void)shootProjectile{
    
    
    
    AOSpaceShipNode *spaceShip = (AOSpaceShipNode *)[self childNodeWithName:@"SpaceShip"];
    
    
    
    AOProjectileNode *projectile = [AOProjectileNode createProjectileAtPosition:CGPointMake(spaceShip.position.x, spaceShip.position.y+10)];
    
    
    [self addChild:projectile];
    
    SKAction *move = [SKAction moveToY:self.frame.size.height+100 duration:1];
    
    
    
    [projectile runAction:move];
    
    self.isBulletShot = YES;
    
    [self runAction:self.fireSFX];

    
}


//Parametro con objeto de tipo SKPhysicsContact que tiene 4 propiedades
//bodyA = el primero objeto en la colision
//bodyB = e segundo en la colision
//point = el punto donde colisionaron
//impulse = el impulso que obtienen del impacto
-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    
    SKPhysicsBody *firstBody,*secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }else{
        
        firstBody  = contact.bodyB;
        secondBody = contact.bodyA;
        
    }
    
    
    //Si el objeto A es un meteoro y el B es un proyectil, destruyelos
    if (firstBody.categoryBitMask == AOCollissionCategoryMeteor &&
        secondBody.categoryBitMask == AOCollissionCategoryProjectile) {
        
        
        AOMeteorNode *meteor = (AOMeteorNode *)firstBody.node;
        AOProjectileNode *projectile = (AOProjectileNode *)secondBody.node;
        
        
        
        [self createDebrisAtPosition:contact.contactPoint];
        
        [self addPoints:100];
        
        [self runAction:self.explodeSFX];
        
        [meteor removeFromParent];
        [projectile removeFromParent];
        
        
      
        
    //Hubo colision entre un meteoro y la nave
    }else if (firstBody.categoryBitMask == AOCollissionCategoryMeteor &&
              secondBody.categoryBitMask == AOCollissionCategoryShip){
        NSLog(@"Vida menos");
        
        AOMeteorNode *meteor = (AOMeteorNode *)firstBody.node;
        [meteor removeFromParent];
        [self createDebrisAtPosition:contact.contactPoint];
        
        [self loseLife];
        [self runAction:self.damageSFX];
    
    
    }
    
}

-(void) addPoints:(NSInteger)points{
    
    AOHudNode *hud = (AOHudNode *)[self childNodeWithName:@"HUD"];
    [hud addPoints:points];
    self.score += 100;
    
}

-(void) loseLife{
    
    AOHudNode *hud = (AOHudNode *)[self childNodeWithName:@"HUD"];
    
    //Si tiene 0 vidas, game over es igual a true
    self.gameOver = [hud loseLife];
    
    NSLog(@"%d",self.gameOver);
    
    
    
}

-(void) performGameOver{
    AOGameOverNode *gameOver = [AOGameOverNode gameOverAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 50)];
    [self addChild:gameOver];
    
    //self.restart = YES;
    self.gameOverDisplayed = YES;
    [gameOver performAnimation];
    
    //[self.backgroundMusic stop];
    [self.gameOverMusic play];
    //[self runAction:self.gameOverVoiceSFX];
    
    [self setUserInteractionEnabled: NO];
    
    SKAction *waiting = [SKAction waitForDuration:3.0];
    
    [self runAction:waiting completion:^{
        [self setUserInteractionEnabled: YES];
    }];
    
    
}


-(void)createDebrisAtPosition:(CGPoint) position{
    
    NSInteger numberOfPieces = [AOUtil randomWithMin:5 max:10];
    
    //NSString *imageName;
    
    for (int i = 0; i < numberOfPieces; i++) {
        NSInteger randomPiece = [AOUtil randomWithMin:1 max:9];
        NSString *imageName = [NSString stringWithFormat:@"debris_0%ld",(long)randomPiece];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debris.position = position;
        [self addChild:debris];
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = AOCollissionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = AOCollissionCategoryDebris;
        debris.name = @"debris";
        debris.physicsBody.velocity = CGVectorMake([AOUtil randomWithMin:-100 max:100], [AOUtil randomWithMin:150 max:350]);
        [debris runAction:[SKAction waitForDuration:0.7] completion:^{[debris removeFromParent];}];
    }
    
    NSString *explosionPath = [[NSBundle mainBundle]pathForResource:@"Explosion" ofType:@"sks"];
    
    SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionPath];
    
    explosion.position = position;
    
    [self addChild:explosion];
    
    [explosion runAction:[SKAction waitForDuration:2.0] completion:^{
        [explosion removeFromParent];
        
    }];
    
}






@end








//
//  L3SDKTextureAtlasAnimation.m
//  iOS-SpriteKite-TextureAtlasAnimation
//
//  Created by Domenico Vacchiano on 13/10/15.
//  Copyright © 2015 DomenicoVacchiano. All rights reserved.
//

#import "L3SDKTextureAtlasAnimation.h"

@interface L3SDKTextureAtlasAnimation ()
//array to store sprite frames
@property (nonatomic,strong)NSMutableArray*spriteFrames;
//property to store the atlas bundle name
@property (nonatomic,strong)NSString*atlasBundle;
//property to store the texture base name
@property (nonatomic,strong)NSString*textureBaseName;
//property to store the texture number format
@property (nonatomic,strong)NSString*textureNumberFormat;

//load all sprite frames
-(void)setupAtlasTexture;
//start sprite frames animation with an SKAction
-(void)startSpriteAnimation:(BOOL)isMotion;
-(void)animateWithMotion:(BOOL)isMotion;
//stop current animation
-(void)stopSpriteAnimation;
//utility methods
-(CGPoint)getEndLocation:(CGPoint)location;
-(int)getMultiplierForDirection:(CGPoint)pointToMove;
@end

@implementation L3SDKTextureAtlasAnimation
@synthesize timePerFrame;
@synthesize allowSpriteToMoveOn;
@synthesize spriteOrientation;

#pragma init factory methods
-(instancetype)initWithAtlasBundle:(NSString*)bundle
                andTextureBaseName:(NSString*)baseName{
    
    return [self initWithAtlasBundle:bundle andTextureBaseName:baseName andTextureNumberFormat:@"0"];
}
-(instancetype)initWithAtlasBundle:(NSString*)bundle
                andTextureBaseName:(NSString*)baseName
            andTextureNumberFormat:(NSString*)numberFormat{
    
    self=[super init];
    if (self) {
        //init local propertis
        self.spriteFrames=[[NSMutableArray alloc]initWithCapacity:5];
        self.atlasBundle=bundle;
        self.textureBaseName=baseName;
        self.timePerFrame=0.05f;
        self.textureNumberFormat=numberFormat;
        self.allowSpriteToMoveOn=SpriteMovmentDirectionAll;
        self.spriteOrientation=SpriteOrientationRight;
        //load sprite frames
        [self setupAtlasTexture];
    }
    return self;
}

#pragma mark public methods
-(void)animate{
    [self animateWithMotion:NO];
}
-(void)animateToDirection:(CGPoint)location{
    [self animateToDirection:location withMotion:NO];
}
-(void)animateToDirection:(CGPoint)location withMotion:(BOOL)isMotion{
    
    //sprite speed calculation
    CGSize screenSize = self.scene.size;
    float spriteVelocity =screenSize.width / 3.0;
    
    //destination point
    CGPoint moveDifference =CGPointMake(location.x - self.spriteNode.position.x, location.y - self.spriteNode.position.y);
    float distanceToMove = sqrtf(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y);
    
    //duration of animation
    float moveDuration = distanceToMove / spriteVelocity;
    
    switch (self.spriteOrientation) {
        case SpriteOrientationUp:
        case SpriteOrientationDown:
            self.spriteNode.yScale = fabs(self.spriteNode.yScale) * [self getMultiplierForDirection:moveDifference];
            break;
        case SpriteOrientationLeft:
        case SpriteOrientationRight:
            self.spriteNode.xScale = fabs(self.spriteNode.xScale) * [self getMultiplierForDirection:moveDifference];
            break;
        default:
            break;
    }

    //start animation
    [self animateWithMotion:isMotion];
    
    if (isMotion) {
        //sequence of actions to start and stop the animation
        SKAction *moveAction = [SKAction moveTo:[self getEndLocation:location] duration:moveDuration];
        SKAction *doneAction = [SKAction runBlock:(dispatch_block_t)^() {
            //animation completed
            [self stopSpriteAnimation];
        }];
        SKAction *moveActionWithDone=[SKAction sequence:@[moveAction,doneAction ]];
        [self.spriteNode runAction:moveActionWithDone withKey:@"spriteAnimating"];
    }

}

#pragma mark private methods
-(void)setupAtlasTexture{
    
    
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setPositiveFormat:self.textureNumberFormat];
    
    
    //load the TextureAtlas with the bundle name
    SKTextureAtlas *spriteAnimatedAtlas = [SKTextureAtlas atlasNamed:self.atlasBundle];
    
    //oad the animation sprite frames from the TextureAtlas
    NSUInteger numImages = spriteAnimatedAtlas.textureNames.count;
    
    for (int i=1; i <= numImages; i++) {
        //format the sprite frame name by using the number format
        NSString *textureName = [NSString stringWithFormat:@"%@%@",
                                 self.textureBaseName,
                                 [formatter stringFromNumber:[NSNumber numberWithInt:i]]
                                 ];
        [self.spriteFrames addObject:[spriteAnimatedAtlas textureNamed:textureName]];
    }
    
    
    //Create a sprite
    _spriteNode = [SKSpriteNode spriteNodeWithTexture:self.spriteFrames[0]];
    
    //add sprite
    [self addChild:self.spriteNode];
}

-(void)startSpriteAnimation:(BOOL)isMotion{
    
    //start the animation with an SKAction
    SKAction*animateTexture=[SKAction animateWithTextures:self.spriteFrames
                                             timePerFrame:self.timePerFrame
                                                   resize:NO
                                                  restore:YES];
    
    if (isMotion) {
        [self.spriteNode runAction:[SKAction repeatActionForever:animateTexture] withKey:@"spriteAnimation"];
    }else{
        [self.spriteNode runAction:animateTexture withKey:@"spriteAnimation"];
    }
    
}
-(void)stopSpriteAnimation{
    //remove actions
    [self.spriteNode removeAllActions];
}
-(CGPoint)getEndLocation:(CGPoint)location{
    
    //depending on the motion behavior, returns a proper end point location
    switch (self.allowSpriteToMoveOn) {
        case SpriteMovmentDirectionAll:
            return location;
        case SpriteMovmentDirectionX:
            return CGPointMake(location.x, self.spriteNode.position.y);
        case SpriteMovmentDirectionY:
            return CGPointMake(self.spriteNode.position.x,location.y);
        default:
            break;
    }
}
-(int)getMultiplierForDirection:(CGPoint)pointToMove{
    
    //depending of the sprite orientation, returns a proper multiplier for the current position
    switch (self.spriteOrientation) {
        case SpriteOrientationRight:
            return  (pointToMove.x < 0 ? -1 : 1);
        case SpriteOrientationLeft:
            return  (pointToMove.x < 0 ? 1 : -1);
        case SpriteOrientationUp:
            return  (pointToMove.y < 0 ? -1 : 1);
        case SpriteOrientationDown:
            return  (pointToMove.y < 0 ? 1 : -1);
        default:
            break;
    }
    return 0;
    
}

-(void)animateWithMotion:(BOOL)isMotion{
    
    if ([self.spriteNode actionForKey:@"spriteAnimating"]) {
        //stop just the moving to a new location, but leave the walking legs movement running
        [self.spriteNode removeActionForKey:@"spriteMoving"];
    }
    
    if (![self.spriteNode actionForKey:@"spriteAnimating"]) {
        //if legs are not moving go ahead and start them
        [self startSpriteAnimation:isMotion];  //start the bear walking
    }
}


@end

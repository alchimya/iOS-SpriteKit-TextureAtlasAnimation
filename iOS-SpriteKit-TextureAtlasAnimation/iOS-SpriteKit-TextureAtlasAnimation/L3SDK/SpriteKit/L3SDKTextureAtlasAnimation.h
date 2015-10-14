//
//  L3SDKTextureAtlasAnimation.h
//  iOS-SpriteKite-TextureAtlasAnimation
//
//  Created by Domenico Vacchiano on 13/10/15.
//  Copyright © 2015 DomenicoVacchiano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

//defines the motion direction behavior
typedef enum : NSUInteger {
    SpriteMovmentDirectionAll,
    SpriteMovmentDirectionX,
    SpriteMovmentDirectionY
} SpriteMovmentDirection;
//defines the orientation of the sprite frames
typedef enum : NSUInteger {
    SpriteOrientationRight,
    SpriteOrientationLeft,
    SpriteOrientationUp,
    SpriteOrientationDown
} SpriteOrientation;

@interface L3SDKTextureAtlasAnimation :SKNode
//gets current SKSpriteNode reference
@property (nonatomic,strong,readonly)SKSpriteNode*spriteNode;
//gets/sets the amount of time that each texture is displayed. Default=0.05f
@property (nonatomic,assign)NSTimeInterval timePerFrame;
//gets/sets the motion behavior
@property (nonatomic,assign)SpriteMovmentDirection allowSpriteToMoveOn;
//gets/sets the original orientation of the sprite frames
@property (nonatomic,assign)SpriteOrientation spriteOrientation;

//factory methods to init class with:
//atlas bundle name: the atlas folder included into the main bundle of your project
//sprite frame (texture) base name
//sprite frame (texture) number progession format
-(instancetype)initWithAtlasBundle:(NSString*)bundle
                andTextureBaseName:(NSString*)baseName;

-(instancetype)initWithAtlasBundle:(NSString*)bundle
                andTextureBaseName:(NSString*)baseName
            andTextureNumberFormat:(NSString*)numberFormat;

//allows to start the animation following a direction
-(void)animateToDirection:(CGPoint)location;
//allows to start the animation with a motion following a direction
-(void)animateToDirection:(CGPoint)location withMotion:(BOOL)isMotion;
//allows to start an animation
-(void)animate;
@end

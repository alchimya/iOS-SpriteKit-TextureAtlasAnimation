//
//  GameScene.m
//  iOS-SpriteKite-TextureAtlasAnimation
//
//  Created by Domenico Vacchiano on 13/10/15.
//  Copyright (c) 2015 DomenicoVacchiano. All rights reserved.
//

#import "GameScene.h"
#import "L3SDKTextureAtlasAnimation.h"


typedef enum : NSUInteger {
    CurrentAnimationNone,
    CurrentAnimationVikingRun,
    CurrentAnimationVikingJump,
    CurrentAnimationVikingJumpSwing,
    CurrentAnimationVikingSwing,
    CurrentAnimationCaveMan,
    CurrentAnimationSpaceShip,
    CurrentAnimationRedBaron,
    CurrentAnimationBear,
} CurrentAnimation;
@interface GameScene ()
@property (nonatomic,assign)CurrentAnimation currentAnimation;
@property (nonatomic,strong)L3SDKTextureAtlasAnimation*spriteAnimation;
@end
@implementation GameScene

-(instancetype)initWithSize:(CGSize)size{
    
    self=[super initWithSize:size];
    if (self) {
        //change this value to test an animation
        self.currentAnimation=CurrentAnimationCaveMan;
        
        switch (self.currentAnimation) {
            case CurrentAnimationCaveMan:
                [self setupCaveMan];
                break;
            case CurrentAnimationVikingJump:
                [self setupVikingJump];
                break;
            case CurrentAnimationVikingRun:
                [self setupVikingRun];
                break;
            case CurrentAnimationVikingJumpSwing:
                [self setupVikingJumpSwing];
                break;
            case CurrentAnimationVikingSwing:
                [self setupVikingSwing];
                break;
            case CurrentAnimationSpaceShip:
                [self setupSpaceShip];
                break;
            case CurrentAnimationRedBaron:
                [self setupRedBaron];
                break;
            case CurrentAnimationBear:
                [self setupBear];
                break;
            default:
                break;
        }
        
        
        
    }
    return self;

}
-(void)setupVikingRun{

    self.spriteAnimation=[[L3SDKTextureAtlasAnimation alloc]
                          initWithAtlasBundle:@"viking_run"
                          andTextureBaseName:@"vikingrun"];
    
    self.spriteAnimation.spriteNode.position=CGPointMake(self.size.width/2,self.size.height/2);
    self.spriteAnimation.spriteNode.size=CGSizeMake(180, 180);
    self.spriteAnimation.timePerFrame=0.05f;
    self.spriteAnimation.allowSpriteToMoveOn=SpriteMovmentDirectionAll;
    self.spriteAnimation.spriteOrientation=SpriteOrientationRight;
    [self addChild:self.spriteAnimation];
}
-(void)setupVikingJump{
    
    self.spriteAnimation=[[L3SDKTextureAtlasAnimation alloc]
                    initWithAtlasBundle:@"viking_jump"
                    andTextureBaseName:@"vikingjump"];
    
    self.spriteAnimation.spriteNode.position=CGPointMake(self.size.width/2,self.size.height/2);;
    
    self.spriteAnimation.spriteNode.size=CGSizeMake(380, 380);
    self.spriteAnimation.timePerFrame=0.05f;
    [self addChild:self.spriteAnimation];
    
}
-(void)setupVikingJumpSwing{
    
    self.spriteAnimation=[[L3SDKTextureAtlasAnimation alloc]
                     initWithAtlasBundle:@"viking_jumpswing"
                     andTextureBaseName:@"vikingjumpswing"];
    
    self.spriteAnimation.spriteNode.position=CGPointMake(self.size.width/2,self.size.height/2);;
    self.spriteAnimation.spriteNode.size=CGSizeMake(250, 250);
    self.spriteAnimation.timePerFrame=0.05f;
    [self addChild:self.spriteAnimation];
    
}
-(void)setupVikingSwing{
    
    self.spriteAnimation=[[L3SDKTextureAtlasAnimation alloc]
                          initWithAtlasBundle:@"viking_swing"
                          andTextureBaseName:@"vikingswing"];
    
    self.spriteAnimation.spriteNode.position=CGPointMake(self.size.width/2,self.size.height/2);;
    
    self.spriteAnimation.spriteNode.size=CGSizeMake(300, 300);
    self.spriteAnimation.timePerFrame=0.05f;
    [self addChild:self.spriteAnimation];
    
}
-(void)setupCaveMan{
    
    self.spriteAnimation=[[L3SDKTextureAtlasAnimation alloc]
                          initWithAtlasBundle:@"caveman"
                          andTextureBaseName:@"caveman"];
    
    self.spriteAnimation.spriteNode.position=CGPointMake(self.size.width/2,self.size.height/2);;
    self.spriteAnimation.spriteNode.size=CGSizeMake(230, 230);
    self.spriteAnimation.timePerFrame=0.05f;
    self.spriteAnimation.allowSpriteToMoveOn=SpriteMovmentDirectionX;
    self.spriteAnimation.spriteOrientation=SpriteOrientationRight;
    
    [self addChild:self.spriteAnimation];
    
}
-(void)setupSpaceShip{
    
    self.spriteAnimation=[[L3SDKTextureAtlasAnimation alloc]
                  initWithAtlasBundle:@"spaceship"
                  andTextureBaseName:@"spaceship"];
    
    self.spriteAnimation.spriteNode.position=CGPointMake(self.size.width/2,self.size.height/2);;
    self.spriteAnimation.spriteNode.size=CGSizeMake(80, 80);
    self.spriteAnimation.allowSpriteToMoveOn=SpriteMovmentDirectionY;
    self.spriteAnimation.spriteOrientation=SpriteOrientationUp;
    
    [self addChild:self.spriteAnimation];
    
}
-(void)setupRedBaron{
    //NOTE: this example shows how to setup a custom umber format
    self.spriteAnimation=[[L3SDKTextureAtlasAnimation alloc]
                  initWithAtlasBundle:@"baroncombo"
                  andTextureBaseName:@"baron_combo"
                  andTextureNumberFormat:@"0000"];
    
    self.spriteAnimation.spriteNode.position=CGPointMake(self.size.width/2,self.size.height/2);;
    self.spriteAnimation.spriteNode.size=CGSizeMake(400, 400);
    self.spriteAnimation.timePerFrame=0.05f;
    self.spriteAnimation.spriteOrientation=SpriteOrientationLeft;
    
    [self addChild:self.spriteAnimation];
    
}
-(void)setupBear{
    
    self.spriteAnimation=[[L3SDKTextureAtlasAnimation alloc]
                          initWithAtlasBundle:@"bear"
                          andTextureBaseName:@"bear"];
    
    self.spriteAnimation.spriteNode.position=CGPointMake(self.size.width/2,self.size.height/2);
    self.spriteAnimation.spriteNode.size=CGSizeMake(150, 150);
    self.spriteAnimation.allowSpriteToMoveOn=SpriteMovmentDirectionAll;
    self.spriteAnimation.spriteOrientation=SpriteOrientationLeft;
    [self addChild:self.spriteAnimation];
    
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    CGPoint location = [[touches anyObject] locationInNode:self];

    
    switch (self.currentAnimation) {
        case CurrentAnimationCaveMan:
        case CurrentAnimationBear:
        case CurrentAnimationVikingRun:
        case CurrentAnimationSpaceShip:
            [self.spriteAnimation animateToDirection:location withMotion:YES];
            break;
        case CurrentAnimationVikingJump:
        case CurrentAnimationVikingJumpSwing:
        case CurrentAnimationVikingSwing:
            [self.spriteAnimation animate];
            break;
        case CurrentAnimationRedBaron:
            [self.spriteAnimation animateToDirection:location];
        default:
            break;
    }
    

    

}


@end

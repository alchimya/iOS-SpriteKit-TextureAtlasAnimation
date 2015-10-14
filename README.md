# iOS-SpriteKit-TextureAtlasAnimation
An useful SKNode subclass that allow to animate a set of sprite frames of an atlas bundle.

![ScreenShot](https://raw.github.com/alchimya/iOS-SpriteKit-TextureAtlasAnimation/master/screenshots/RedBaron.gif)

# Introduction
Inspired from an interesting tutorial, read on RayWenderLich and written by Tony Dahbura (http://www.raywenderlich.com/45152/sprite-kit-tutorial-animations-and-texture-atlases)
about Animations and Texture Atlases, I decide to develop an utility class (SKNode sublass) to achive this behavior
in an EZ Way!

# How to use
To implement an animation you have:
1) to add in the main bundle of the project, an atlas bundle with a set of sprite frames (within my example project there are some bundle).
2) create an instance of the class <b>L3SDKTextureAtlasAnimation</b> an initialite it with one of the init factory methods (see below).

<h5>properties</h5>

  name                        |     type                        |   description    
------------------------------| --------------------------------|--------------------------------------------------------
spriteNode                    | SKSpriteNode                    | gets the SKSpriteNode reference
timePerFrame                  | NSTimeInterval                  | gets/sets the amount of time that each texture is displayed. Default=0.05f
allowSpriteToMoveOn           | SpriteMovmentDirection          | gets/sets the motion behavior
spriteOrientation             | SpriteOrientation               | gets/sets the original orientation of the sprite frames

<h5>methods</h5>
  name                    |     type        |   description    
--------------------------| ----------------|-------------------------------------------------------------------
initWithAtlasBundle       | instancetype    | allows to init the class
animateToDirection        | void            | allows to start the animation and optionally to move toward a direction
animate                   | void            | allows to start an animation

<h5>enums</h5>

```objectivec
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
```
<h5>example</h5>
```objectivec

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

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint location = [[touches anyObject] locationInNode:self];
  [self.spriteAnimation animateToDirection:location];
}

```
<br/> 
![ScreenShot](https://raw.github.com/alchimya/iOS-SpriteKit-TextureAtlasAnimation/master/screenshots/CaveMan.gif)
<br/> 
![ScreenShot](https://raw.github.com/alchimya/iOS-SpriteKit-TextureAtlasAnimation/master/screenshots/VikingJump.gif)
<br/> 
![ScreenShot](https://raw.github.com/alchimya/iOS-SpriteKit-TextureAtlasAnimation/master/screenshots/VikingRun.gif)

//
//  EndLevel.m
//  IM
//
//  Created by Damian Rizzotto on 22/10/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "EndLevel.h"

@implementation EndLevel{
    CCNode* _StarOn1;
    CCNode* _StarOn2;
    CCNode* _StarOn3;
    
    CCNode* _levels;
    CCNode* _retry;
    CCNode* _next;
}

-(void)levels{
    float duration = 0.075f;
    id scaleUp = [CCActionScaleTo actionWithDuration:duration scaleX:1.25f scaleY:1.25f];
    id scaleDown = [CCActionScaleTo actionWithDuration:duration scaleX:1.0f scaleY:1.0f];
    id call = [CCActionCallFunc actionWithTarget:self selector:@selector(goLevels)];
    id buttonAction = [CCActionSequence actions: scaleUp,scaleDown, call, nil];
    [_levels runAction:buttonAction];
}
-(void)goLevels{
    [[CCDirector sharedDirector] popScene];
}

-(void) cleanStars{
    _StarOn1.opacity =0;
    _StarOn2.opacity =0;
    _StarOn3.opacity =0;

}
-(void) showStars: (int) stars{
    CCLOG(@"%i",stars);

    float duration = 0.075f;
    id delay = [CCActionDelay actionWithDuration:0.5f];
    id show = [CCActionFadeTo actionWithDuration:0 opacity:1 ];
    id scaleUp = [CCActionScaleTo actionWithDuration:duration scaleX:0.8f scaleY:0.8f];
    id scaleDown = [CCActionScaleTo actionWithDuration:duration scaleX:0.7f scaleY:0.7f];
    
    if(stars >=1){
        id buttonAction = [CCActionSequence actions: show,scaleUp,scaleDown, nil];
        [_StarOn1 runAction:buttonAction];
    }
    if(stars >=2){
        id buttonAction = [CCActionSequence actions: delay,show,scaleUp,scaleDown, nil];
        [_StarOn2 runAction:buttonAction];
    }
    if(stars ==3){
        id buttonAction = [CCActionSequence actions: delay,delay,show,scaleUp,scaleDown, nil];
        [_StarOn3 runAction:buttonAction];
    }
}

- (void) next{
    float duration = 0.075f;
    id scaleUp = [CCActionScaleTo actionWithDuration:duration scaleX:1.25f scaleY:1.25f];
    id scaleDown = [CCActionScaleTo actionWithDuration:duration scaleX:1.0f scaleY:1.0f];
    id call = [CCActionCallFunc actionWithTarget:self selector:@selector(goNext)];
    id buttonAction = [CCActionSequence actions: scaleUp,scaleDown, call, nil];
    [_next runAction:buttonAction];
}

-(void) goNext{
    LevelWrapper* lr = ((LevelWrapper*)_parent.parent);
    int levelNum = lr.levelNum;
    int levelSet = lr.levelSet;
    levelNum++;
    lr.menu.position = ccp(54,0);
    if(levelNum == 8){
        levelNum = 1;
        levelSet++;
    }
    
    if(levelSet > 1){
        [[CCDirector sharedDirector]  popScene];
    }else{
        [lr changeLevel:levelNum levelSet:levelSet];
    }
}

- (void) retry{
    float duration = 0.075f;
    id scaleUp = [CCActionScaleTo actionWithDuration:duration scaleX:1.25f scaleY:1.25f];
    id scaleDown = [CCActionScaleTo actionWithDuration:duration scaleX:1.0f scaleY:1.0f];
    id call = [CCActionCallFunc actionWithTarget:self selector:@selector(goRetry)];
    id buttonAction = [CCActionSequence actions: scaleUp,scaleDown, call, nil];
    [_retry runAction:buttonAction];
}
- (void) goRetry{
    [((LevelWrapper*)_parent.parent) retry];
}

@end

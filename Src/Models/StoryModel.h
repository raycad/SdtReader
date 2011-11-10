//
//  CourseModel.h
//  SdtReader
//
//  Created by raycad on 10/27/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Story.h"

@interface StoryModel : NSObject {
    NSMutableArray  *m_storyList;    
}

- (BOOL)addStory:(Story *)story;

- (Story *)storyAtIndex:(int)index;

- (BOOL)copyDataFrom:(StoryModel *)other;

- (void)clear;

- (int)count;
@end
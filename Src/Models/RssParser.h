//
//  RssParser.h
//  SdtReader
//
//  Created by raycad on 8/15/09.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssStoryModel.h"

@protocol RssParserDelegate;

@interface RssParser : NSObject {	
    id<RssParserDelegate>   m_delegate;
    
	NSMutableString         *m_currentItemValue;	
	NSOperationQueue        *m_retrieverQueue;    
    NSString                *m_rssFeedLink;
    
    RssStoryModel           *m_rssStoryModel;
    RssStory                *m_currentRssStory;
}

@property (nonatomic, copy) NSString *rssFeedLink;
@property (nonatomic, retain) RssStory *currentRssStory;
@property (nonatomic, retain) NSMutableString *currentItemValue;
@property (readonly) RssStoryModel *rssStoryModel;

@property (nonatomic, assign) id<RssParserDelegate> delegate;
@property (nonatomic, retain) NSOperationQueue *retrieverQueue;

- (void)startProcess;

@end

@protocol RssParserDelegate <NSObject>
- (void)processCompleted;
- (void)processHasErrors;
@end

//
//  RssStory.h
//  SdtReader
//
//  Created by raycad on 11/10/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssStory : NSObject {
    NSString    *m_title;
    NSString    *m_description;
    NSString    *m_linkUrl;
    NSString    *m_creator;
    NSString    *m_guidUrl;
    NSDate      *m_pubDate;
    NSString    *m_mediaUrl;
}

@property (nonatomic, copy)     NSString    *title;
@property (nonatomic, copy)     NSString    *description;
@property (nonatomic, copy)     NSString    *linkUrl;
@property (nonatomic, copy)     NSString    *creator;
@property (nonatomic, copy)     NSString    *guidUrl;
@property (nonatomic, retain)   NSDate      *pubDate;
@property (nonatomic, copy)     NSString    *mediaUrl;
@end

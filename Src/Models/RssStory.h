//
//  RssStory.h
//  SdtReader
//
//  Created by raycad on 11/10/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssStory : NSObject {
    NSString *m_title;
    NSString *m_description;
    NSString *m_link;
    NSString *m_creator;
    NSString *m_guid;
    NSString *m_date;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *creator;
@property (nonatomic, retain) NSString *guid;
@property (nonatomic, retain) NSString *date;
@end

//
//  Feed.h
//  SdtReader
//
//  Created by raycad on 11/10/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedPK : NSObject {
    NSString *m_title;    
}

@property NSString *title;

-(id)initWithTitle:(NSString *)title;
@end

@interface Feed : NSObject {
    NSString    *m_title;
    NSString    *m_link;
    NSString    *m_website;
    NSString    *m_description;
    
    FeedPK      *m_feedPK;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSString *description;

- (id)initWithFeedPK:(FeedPK *)feedPK;
- (FeedPK *)feedPK;

- (BOOL)isEqual:(id)object;
@end

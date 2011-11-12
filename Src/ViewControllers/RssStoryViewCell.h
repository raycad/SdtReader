//
//  RssStoryViewCell.h
//  SdtReader
//
//  Created by raycad on 11/6/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssStory.h"

@interface RssStoryViewCell : UITableViewCell {
    UILabel     *m_titleLabel;
    UITextView  *m_descriptionLabel;
    UILabel     *m_indexLabel;
    UIImageView *m_thumbnailImageView;
    RssStory    *m_rssStory;
}

@property (nonatomic, retain) UILabel     *titleLabel;
@property (nonatomic, retain) UITextView  *descriptionLabel;
@property (nonatomic, retain) UILabel     *indexLabel;
@property (nonatomic, retain) UIImageView *thumbnailImageView;
@property (nonatomic, retain) RssStory     *rssStory;
@end

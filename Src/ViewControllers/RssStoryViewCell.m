//
//  RssStoryViewCell.m
//  SdtReader
//
//  Created by raycad on 11/6/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssStoryViewCell.h"

@implementation RssStoryViewCell

@synthesize titleLabel          = m_titleLabel;
@synthesize descriptionLabel    = m_descriptionLabel;
@synthesize indexLabel          = m_indexLabel;
@synthesize thumbnailImageView  = m_thumbnailImageView;
@synthesize rssStory             = m_rssStory;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])) {
        // Initialization code
        m_titleLabel = [[UILabel alloc]init];
        m_titleLabel.textAlignment = UITextAlignmentLeft;
        m_indexLabel.font = [UIFont fontWithMarkupDescription:@"font-family: Arial; font-size: 22px; font-weight: bold;"];
        
        m_descriptionLabel = [[UITextView alloc]init];
        m_descriptionLabel.textAlignment = UITextAlignmentLeft;
        m_descriptionLabel.font = [UIFont fontWithMarkupDescription:@"font-family: Arial; font-size: 13px; font-style : italic;"];
        m_descriptionLabel.textColor = [UIColor blueColor];
        [m_descriptionLabel setEditable:NO];
        [m_descriptionLabel setUserInteractionEnabled:NO];
        
        m_indexLabel = [[UILabel alloc]init];
        m_indexLabel.textAlignment = UITextAlignmentLeft;
        //m_indexLabel.font = [UIFont systemFontOfSize:10];
        m_indexLabel.font = [UIFont fontWithMarkupDescription:@"font-family: Arial; font-size: 15px; font-weight: bold; font-style : italic;"];
        m_indexLabel.textColor = [UIColor grayColor];
        
        m_thumbnailImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:m_titleLabel];
        [self.contentView addSubview:m_descriptionLabel];
        //[self.contentView addSubview:m_indexLabel];
        [self.contentView addSubview:m_thumbnailImageView];        
    }
    
    return self;
}

- (void)layoutSubviews 
{
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat leftBoundsX = contentRect.origin.x;
    CGFloat rightBoundsX = contentRect.size.width;
    CGRect frame;
    frame = CGRectMake(leftBoundsX+5, 2, 32, 32);
    m_thumbnailImageView.frame = frame;
    
    frame = CGRectMake(leftBoundsX+42, 2, contentRect.size.width - 50, 28);
    m_titleLabel.frame = frame;
    
    frame = CGRectMake(leftBoundsX, 28, contentRect.size.width - 6, 70);
    m_descriptionLabel.frame = frame;
    
    /*frame = CGRectMake(rightBoundsX-50, 18, 40, 20);
    m_indexLabel.frame = frame;*/
}

- (void)dealloc
{
    [m_rssStory release];
    [m_titleLabel release];
    [m_descriptionLabel release];
    [m_indexLabel release];
    [m_thumbnailImageView release];
}
@end
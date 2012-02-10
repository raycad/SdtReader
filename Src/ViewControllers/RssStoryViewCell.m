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
        m_titleLabel = [[UILabel alloc] init];
        m_titleLabel.textAlignment = UITextAlignmentLeft;
        m_titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
        
        m_descriptionLabel = [[UITextView alloc] init];
        m_descriptionLabel.textAlignment = UITextAlignmentLeft;
        //m_descriptionLabel.font = [UIFont fontNamesForFamilyName:@"font-family: Arial; font-size: 13px; font-style : italic;"];
        m_descriptionLabel.font = [UIFont fontWithName:@"Arial" size:13];
        m_descriptionLabel.textColor = [UIColor blueColor];
        [m_descriptionLabel setEditable:NO];
        [m_descriptionLabel setUserInteractionEnabled:NO];
        
        m_indexLabel = [[UILabel alloc] init];
        m_indexLabel.textAlignment = UITextAlignmentLeft;
        //m_indexLabel.font = [UIFont systemFontOfSize:10];
        //m_indexLabel.font = [UIFont fontNamesForFamilyName:@"font-family: Arial; font-size: 15px; font-weight: bold; font-style : italic;"];
        m_indexLabel.textColor = [UIColor grayColor];
        
        m_thumbnailImageView = [[UIImageView alloc] init];
        
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
    int iconSize = 64;
    CGFloat leftTitleX = leftBoundsX+iconSize+5;
    
    frame = CGRectMake(leftBoundsX+2, 10, iconSize, iconSize);
    m_thumbnailImageView.frame = frame;    
    
    frame = CGRectMake(leftTitleX, 3, rightBoundsX-iconSize-5, 25);
    m_titleLabel.frame = frame;
    
    frame = CGRectMake(leftTitleX-6, 26, rightBoundsX-iconSize-5, 55);
    m_descriptionLabel.frame = frame;
    
    /*frame = CGRectMake(rightBoundsX-50, 18, 40, 20);
    m_indexLabel.frame = frame;*/
}

- (void)loadImageInBackground
{
    NSString *imageLink = m_rssStory.mediaUrl;
    if (imageLink == nil || [imageLink isEqualToString:@""]) 
        return;
    
    NSURL *url = [NSURL URLWithString:imageLink];
    
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    
    // Update thumbnail image
    m_rssStory.image = image;
    m_thumbnailImageView.image = image;
}

- (void)updateData
{
    if (!m_rssStory)
        return;
    
    // Update data
    self.titleLabel.text = m_rssStory.title;
    self.descriptionLabel.text = m_rssStory.description;
    
    UIImage *image = m_rssStory.image;
    if (image == nil) {
        image = [UIImage imageNamed:@"rss_icon64.png"];
        m_rssStory.image = image;
        
        NSString *imageLink = m_rssStory.mediaUrl;
        if (imageLink != nil && ![imageLink isEqualToString:@""]) {
            [NSThread detachNewThreadSelector:@selector(loadImageInBackground)
                                     toTarget:self withObject:nil];
        }
    } 
    
    m_thumbnailImageView.image = image;
}
@end
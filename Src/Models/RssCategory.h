//
//  RssCategory.h
//  SdtReader
//
//  Created by raycad on 11/10/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssCategoryPK : NSObject {
    NSString *m_title;    
}

@property NSString *title;

-(id)initWithTitle:(NSString *)title;
@end

@interface RssCategory : NSObject {
    NSString    *m_title;
    NSString    *m_description;

    RssCategoryPK   *m_rssCategoryPK;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *description;
@property int rate;

- (id)initWithRssCategoryPK:(RssCategoryPK *)rssCategoryPK;
- (RssCategoryPK *)rssCategoryPK;

- (BOOL)isEqual:(id)object;
@end

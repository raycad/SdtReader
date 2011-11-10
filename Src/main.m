//
//  main.m
//  SdtReader
//
//  Created by raycad on 11/9/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReaderModel.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    // Initialize the app model
    ReaderModel *readerModel = [ReaderModel instance];
    
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    
    [readerModel release];
    [pool release];
    return retVal;
}

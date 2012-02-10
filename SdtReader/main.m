//
//  main.m
//  SdtReader
//
//  Created by raycad sun on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "ReaderModel.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        // Initialize the app model
        ReaderModel *readerModel = [ReaderModel instance];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

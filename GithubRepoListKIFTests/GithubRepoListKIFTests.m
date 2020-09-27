//
//  GithubRepoListKIFTests.m
//  GithubRepoListKIFTests
//
//  Created by Marcelo Hammes on 27/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

//#import <XCTest/XCTest.h>
#import <KIF/KIF.h>

@interface GithubRepoListKIFTests : KIFTestCase

@end

@implementation GithubRepoListKIFTests

- (void)beforeEach
{
    [tester waitForTimeInterval:10];
}

- (void)afterEach
{
    
}

- (void)testPullToRefresh
{
    [tester pullToRefreshViewWithAccessibilityLabel:@"" value:0];
    // Verify that the login succeeded
//    [tester waitForTappableViewWithAccessibilityLabel:@"Welcome"];
}

@end

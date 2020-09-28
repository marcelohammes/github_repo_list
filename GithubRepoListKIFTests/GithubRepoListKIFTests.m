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

- (void)beforeEach {
    [viewTester waitForTimeInterval:5];
}

- (void)testInFirstPullToRefresh {
    [tester pullToRefreshViewWithAccessibilityLabel:@"Github Repositories List" value:0];
    
    [tester waitForViewWithAccessibilityLabel:@"Refresh Indicator"];
}

- (void)testInSecondInfiniteScroll {
    // Make many scrolls to bottom
    [tester scrollViewWithAccessibilityIdentifier:@"Github Repositories List" byFractionOfSizeHorizontal:0.0 vertical:-0.9];
    [tester scrollViewWithAccessibilityIdentifier:@"Github Repositories List" byFractionOfSizeHorizontal:0.0 vertical:-0.9];
    [tester scrollViewWithAccessibilityIdentifier:@"Github Repositories List" byFractionOfSizeHorizontal:0.0 vertical:-0.9];
    [tester scrollViewWithAccessibilityIdentifier:@"Github Repositories List" byFractionOfSizeHorizontal:0.0 vertical:-0.9];
    [tester scrollViewWithAccessibilityIdentifier:@"Github Repositories List" byFractionOfSizeHorizontal:0.0 vertical:-0.9];
    [tester scrollViewWithAccessibilityIdentifier:@"Github Repositories List" byFractionOfSizeHorizontal:0.0 vertical:-0.9];
    [tester scrollViewWithAccessibilityIdentifier:@"Github Repositories List" byFractionOfSizeHorizontal:0.0 vertical:-0.9];
    [tester scrollViewWithAccessibilityIdentifier:@"Github Repositories List" byFractionOfSizeHorizontal:0.0 vertical:-0.9];
    
    [tester waitForViewWithAccessibilityLabel:@"Loading Item"];
}

@end

//
//  ViewController.m
//  EGDateViewDemo
//
//  Created by Miguel Ángel Grau Martínez on 27/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "EGDateView.h"

@interface ViewController ()
@property (nonatomic,strong) EGDateView *dateView;
@property (nonatomic,strong) NSTimer *timer;

-(void)updateDateView;
@end

@implementation ViewController
@synthesize dateView = _dateView;
@synthesize timer = _timer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dateView = [[EGDateView alloc] initWithFrame:CGRectMake(0.0, 100.0, 320.0, 50.0)];
    _dateView.date = [NSDate date];
    
    [self.view addSubview:_dateView];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                            target:self
                                          selector:@selector(updateDateView)
                                          userInfo:nil
                                           repeats:YES];
}

- (void)viewDidUnload
{
    [_timer invalidate];
    [self setTimer:nil];
    [self setDateView:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)updateDateView
{
    _dateView.date = [NSDate date];
}


@end

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
@property (nonatomic,strong) EGDateView *dateDiffView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSDate *initDate;
@property (nonatomic,strong) NSDate *endDate;
-(void)updateDateView;
@end

@implementation ViewController
@synthesize dateView = _dateView;
@synthesize dateDiffView = _dateDiffView;
@synthesize timer = _timer;
@synthesize initDate = _initDate;
@synthesize endDate = _endDate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dateView = [[EGDateView alloc] initWithFrame:CGRectMake(0.0, 100.0, 320.0, 50.0)];
    _dateDiffView = [[EGDateView alloc] initWithFrame:CGRectMake(0.0, 150.0, 320.0, 50.0)];
        
    _dateView.date = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = -1;
    dateComponents.month = 0;    
    dateComponents.day = 0;
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    
    _initDate = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];    
    _endDate = [NSDate date];
    [_dateDiffView displayDifferenceBetweenDate:_initDate andDate:_endDate];
    
    [self.view addSubview:_dateView];
    [self.view addSubview:_dateDiffView];
    
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
    [self setDateDiffView:nil];
    
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
        
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.second = 1;
    
    _initDate = [calendar dateByAddingComponents:dateComponents toDate:_initDate options:0];    
    [_dateDiffView displayDifferenceBetweenDate:_initDate andDate:_endDate];
}


@end

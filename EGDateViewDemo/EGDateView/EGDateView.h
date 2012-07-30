//
//  EGDateView.h
//  EGDateViewDemo
//
//  Created by Miguel Ángel Grau Martínez on 27/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum EGDateViewDisplayMode {
    EGDateDisplayModeDateTime,
    EGDateDisplayModeDate,
    EGDateDisplayModeTime
} EGDateViewDisplayMode;

@class EGDateView;

@interface EGDateView : UIView

@property (strong, nonatomic) NSDate *date;
@property (weak, nonatomic) UIFont *fontDate;
@property (weak, nonatomic) UIFont *fontDateComponent;
@property (weak, nonatomic) UIFont *fontTime;
@property (weak, nonatomic) UIFont *fontTimeComponent;
@property (strong, nonatomic) UIColor *colorDate;
@property (strong, nonatomic) UIColor *colorTime;
@property (strong, nonatomic) UIColor *colorDateForComponentType;
@property (strong, nonatomic) UIColor *colorTimeForComponentType;
@property (nonatomic) EGDateViewDisplayMode displayMode;

-(void)displayDifferenceBetweenDate:(NSDate *)fromDate andDate:(NSDate *)toDate;

@end




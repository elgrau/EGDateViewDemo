//
//  EGDateView.m
//  EGDateViewDemo
//
//  Created by Miguel Ángel Grau Martínez on 27/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EGDateView.h"

#define SEPARATOR 3.0
#define COMPONENT_SEPARATOR 2.0

@interface EGDateView()
-(CGFloat) widthForDate;
-(void)setupView;

@property (nonatomic,strong) NSDateComponents *dateComponents;
@property (nonatomic) BOOL drawNegativeSign;

@end


@implementation EGDateView
@synthesize date = _date;
@synthesize dateComponents = _dateComponents;
@synthesize displayMode = _displayMode;
@synthesize colorDate = _colorDate;
@synthesize colorTime = _colorTime;
@synthesize colorDateForComponentType = _colorDateForComponentType;
@synthesize colorTimeForComponentType = _colorTimeForComponentType;
@synthesize fontDate = _fontDate;
@synthesize fontDateComponent = _fontDateComponent;
@synthesize fontTime = _fontTime;
@synthesize fontTimeComponent = _fontTimeComponent;
@synthesize drawNegativeSign = _drawNegativeSign;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder] ;
	if (self)
	{
        [self setupView];
	}
	return self ;
}


-(void)setupView
{
    self.backgroundColor = [UIColor clearColor];
    _drawNegativeSign = NO;
    
    _displayMode = EGDateDisplayModeDateTime;
    _fontDate = [UIFont systemFontOfSize:15.0f];
    _fontDateComponent = [UIFont systemFontOfSize:10.0f];
    _fontTime = [UIFont systemFontOfSize:15.0f];
    _fontTimeComponent = [UIFont systemFontOfSize:10.0f];
    
    _colorDate = [UIColor colorWithRed:112.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1.0];
    _colorTime = [UIColor colorWithRed:122.0/255.0 green:200.0/255.0 blue:255.0/255.0 alpha:1.0];
    _colorDateForComponentType = [UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1.0];
    _colorTimeForComponentType = [UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1.0];
    
}

-(void)setDate:(NSDate *)date
{
    if (date != _date) {
        _date = date;
        
        _dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:_date];
        
        [self setNeedsDisplay];
    }
}

-(void)displayDifferenceBetweenDate:(NSDate *)fromDate andDate:(NSDate *)toDate
{
    _dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:fromDate toDate:toDate options:0];
    
    [self setNeedsDisplay];
}

-(void)displayDateComponents:(NSDateComponents *)dateComponents
{
    _dateComponents = dateComponents;
    
    [self setNeedsDisplay];
}

-(void)displayNegativeDateComponents:(NSDateComponents *)dateComponents
{
    _drawNegativeSign = YES;
    
    [self displayDateComponents:dateComponents];
}


-(void)setDisplayMode:(EGDateViewDisplayMode)displayMode
{
    if (displayMode != _displayMode) {
        _displayMode = displayMode;
        [self setNeedsDisplay];
    }
}

-(void) setColorDate:(UIColor *)colorDate
{
    if (colorDate != _colorDate) {
        _colorDate = colorDate;
        [self setNeedsDisplay];
    }
}

-(void) setColorTime:(UIColor *)colorTime
{
    if (colorTime != _colorTime) {
        _colorTime = colorTime;
        [self setNeedsDisplay];
    }
}

-(void) setColorDateForComponentType:(UIColor *)colorDateForComponentType
{
    if (colorDateForComponentType != _colorDateForComponentType) {
        _colorDateForComponentType = colorDateForComponentType;
        [self setNeedsDisplay];
    }
}

-(void) setColorTimeForComponentType:(UIColor *)colorTimeForComponentType
{
    if (colorTimeForComponentType != _colorTimeForComponentType) {
        _colorTimeForComponentType = colorTimeForComponentType;
        [self setNeedsDisplay];
    }
}







-(NSString *)year
{
    return [NSString stringWithFormat:@"%02d",_dateComponents.year];
}

-(NSString *)month
{
    return [NSString stringWithFormat:@"%02d",_dateComponents.month];
}

-(NSString *)day
{
    return [NSString stringWithFormat:@"%02d",_dateComponents.day];
}

-(NSString *)hour
{
    return [NSString stringWithFormat:@"%02d",_dateComponents.hour];
}

-(NSString *)minute
{
    return [NSString stringWithFormat:@"%02d",_dateComponents.minute];
}

-(UIFont *)fontForNegativeSign
{
    UIFont *font = _fontDate;
    
    if (_displayMode == EGDateDisplayModeTime) {
        font = _fontTime;            
    }
    return font;
}

-(UIColor *)colorForNegativeSign
{
    UIColor *color = _colorDate;
    
    if (_displayMode == EGDateDisplayModeTime) {
        color = _colorTime;            
    }
    return color;
}


-(CGFloat)widthForDate
{
    CGFloat width = 0.0;    
    
    if (_drawNegativeSign) {                
        CGSize negativeSignSize = [@"-" sizeWithFont:[self fontForNegativeSign]];
        width += negativeSignSize.width + COMPONENT_SEPARATOR;
    }
    
    if (_displayMode != EGDateDisplayModeTime) {
        CGSize yearSize = [[self year] sizeWithFont:_fontDate];
        CGSize monthSize = [[self month] sizeWithFont:_fontDate];
        CGSize daySize = [[self day] sizeWithFont:_fontDate];
        
        CGSize yearComponentSize = [@"A" sizeWithFont:_fontDateComponent];
        CGSize monthComponentSize = [@"M" sizeWithFont:_fontDateComponent];
        CGSize dayComponentSize = [@"D" sizeWithFont:_fontDateComponent];
        
        width += yearSize.width + COMPONENT_SEPARATOR + yearComponentSize.width + SEPARATOR 
        + monthSize.width + COMPONENT_SEPARATOR + monthComponentSize.width + SEPARATOR
        + daySize.width + COMPONENT_SEPARATOR + dayComponentSize.width;
    }
    
    if (_displayMode == EGDateDisplayModeDateTime) {
        width += SEPARATOR;
    }
    
    if (_displayMode != EGDateDisplayModeDate) {       
        CGSize hourSize = [[self hour] sizeWithFont:_fontTime];
        CGSize minuteSize = [[self minute] sizeWithFont:_fontTime];
        
        CGSize hourComponentSize = [@"H" sizeWithFont:_fontTimeComponent];
        CGSize minuteComponentSize = [@"M" sizeWithFont:_fontTimeComponent];
        
        
        width += hourSize.width + COMPONENT_SEPARATOR + hourComponentSize.width + SEPARATOR
        + minuteSize.width + COMPONENT_SEPARATOR + minuteComponentSize.width;
    }
    
    return width;
}

-(void)drawRect:(CGRect)rect
{
    if (_dateComponents != nil) {    
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        
        CGFloat linePosition = (self.frame.size.width - [self widthForDate]) / 2;
        CGFloat topPosition = 0.0;
        CGFloat heightDateText = 0.0;
        
        if (_drawNegativeSign) {                            
            [[self colorForNegativeSign] setFill];
            UIFont *font = [self fontForNegativeSign];
            
            CGContextTranslateCTM(ctx, linePosition, topPosition);
            CGSize size = [@"-" sizeWithFont:[self fontForNegativeSign]];
            CGRect textRect = CGRectMake(0.0, 0.0, size.width, size.height);
            [@"-" drawInRect:textRect withFont:font];
            linePosition = size.width + COMPONENT_SEPARATOR;
        }
        
        if (_displayMode != EGDateDisplayModeTime) {        
            NSArray *dateValues = [NSArray arrayWithObjects:[self year],[self month], [self day], nil];
            NSArray *dateComponentsValues = [NSArray arrayWithObjects:@"A",@"M", @"D", nil];
            
            for(NSInteger i=0; i<[dateValues count]; i++)
            {
                [_colorDate setFill];
                CGContextTranslateCTM(ctx, linePosition, topPosition);
                NSString *text = [dateValues objectAtIndex:i];
                CGSize size = [text sizeWithFont:_fontDate];
                CGRect textRect = CGRectMake(0.0, 0.0, size.width, size.height);
                [text drawInRect:textRect withFont:_fontDate];
                linePosition = size.width + COMPONENT_SEPARATOR;
                heightDateText = size.height;
                
                [_colorDateForComponentType setFill];
                text = [dateComponentsValues objectAtIndex:i];
                CGSize sizeComponent = [text sizeWithFont:_fontDateComponent];
                textRect = CGRectMake(0.0, 0.0, sizeComponent.width, sizeComponent.height);
                
                topPosition = size.height - sizeComponent.height;
                CGContextTranslateCTM(ctx, linePosition, topPosition);
                [text drawInRect:textRect withFont:_fontDateComponent];        
                linePosition = sizeComponent.width + SEPARATOR;
                topPosition = -1 * topPosition;
            }
        }
        
        if (_displayMode != EGDateDisplayModeDate) {
            
            if (_displayMode == EGDateDisplayModeDateTime) {            
                CGContextTranslateCTM(ctx, linePosition, topPosition);
                
                // Calculamos la posición Y donde se va a empezar a ubicar el tiempo
                CGSize sizeDate = [@"0" sizeWithFont:_fontDate];
                CGSize sizeTime = [@"0" sizeWithFont:_fontTime];        
                topPosition = sizeDate.height - sizeTime.height;
            }
            
            NSArray *timeValues = [NSArray arrayWithObjects:[self hour],[self minute], nil];
            NSArray *timeComponentsValues = [NSArray arrayWithObjects:@"H",@"M", nil];
            
            for(NSInteger i=0; i<[timeValues count]; i++)
            {
                [_colorTime setFill];
                CGContextTranslateCTM(ctx, linePosition, topPosition);
                NSString *text = [timeValues objectAtIndex:i];
                CGSize size = [text sizeWithFont:_fontTime];
                CGRect textRect = CGRectMake(0.0, 0.0, size.width, size.height);
                [text drawInRect:textRect withFont:_fontTime];
                linePosition = size.width + COMPONENT_SEPARATOR;
                
                [_colorTimeForComponentType setFill];
                text = [timeComponentsValues objectAtIndex:i];
                CGSize sizeComponent = [text sizeWithFont:_fontTimeComponent];
                textRect = CGRectMake(0.0, 0.0, sizeComponent.width, sizeComponent.height);
                topPosition = size.height - sizeComponent.height;
                CGContextTranslateCTM(ctx, linePosition, topPosition);
                [text drawInRect:textRect withFont:_fontTimeComponent];
                linePosition = sizeComponent.width + SEPARATOR;     
                topPosition = -1 * topPosition;
            } 
        }
        
        CGContextRestoreGState(ctx);
    }
    _drawNegativeSign = NO;
}

@end

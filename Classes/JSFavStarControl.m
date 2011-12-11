//
//  JSFaveStarControl.m
//  FavStarControl
//
//  Created by James "Jasarien" Addyman on 17/02/2010.
//  Copyright 2010 JamSoft. All rights reserved.
//  http://jamsoftonline.com
//

#import "JSFavStarControl.h"


@implementation JSFavStarControl

@synthesize dotImage = _dotImage;
@synthesize starImage = _starImage;
@synthesize maxStars = _maxStars;
@synthesize rating = _rating;

- (id)initWithFrame:(CGRect)frame dotImage:(UIImage *)dotImage starImage:(UIImage *)starImage
{
	if (self = [self initWithFrame:frame])
	{
		_rating = 0;
        _maxStars = 5;
        
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		self.contentMode = UIViewContentModeRedraw;
		
		_dotImage = [dotImage retain];
		_starImage = [starImage retain];
	}
	
	return self;
}

- (void)drawRect:(CGRect)rect
{
    CGPoint currPoint = CGPointZero;
    
    CGFloat imageWidth = 20;
    if (_starImage) {
        imageWidth = _starImage.size.width;
    }
    else if (_dotImage) {
        imageWidth = _dotImage.size.width;
    }
    
    CGFloat stepX = imageWidth + (rect.size.width - self.maxStars*imageWidth)/(self.maxStars-1);
	
	for (int i = 0; i < _rating; i++)
	{
		if (_starImage) {
			[_starImage drawAtPoint:currPoint];
        }
		else {
			[@"★" drawAtPoint:currPoint withFont:[UIFont boldSystemFontOfSize:22]];
        }
        currPoint.x += stepX;
	}
	
	NSInteger remaining = self.maxStars - _rating;
	
	for (int i = 0; i < remaining; i++)
	{
		if (_dotImage) {
			[_dotImage drawAtPoint:currPoint];
        }
		else {
			[@" •" drawAtPoint:currPoint withFont:[UIFont boldSystemFontOfSize:22]];
        }
        currPoint.x += stepX;
	}
}


- (void)dealloc
{
	[_dotImage release];
	[_starImage release];
	
	_dotImage = nil,
	_starImage = nil;
	
    [super dealloc];
}

#pragma mark Accessors

- (void)setRating:(NSInteger)rating
{
    if (rating != _rating) {
        _rating = rating;
        [self setNeedsDisplay];
    }
}

#pragma mark UIControl

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGFloat width = self.frame.size.width;
	CGRect section = CGRectMake(0, 0, width / self.maxStars, self.frame.size.height);
	
	CGPoint touchLocation = [touch locationInView:self];
	
	for (int i = 0; i < self.maxStars; i++)
	{		
		if (touchLocation.x > section.origin.x && touchLocation.x < section.origin.x + section.size.width)
		{ // touch is inside section
			if (_rating != (i+1))
			{
				_rating = i+1;
				[self sendActionsForControlEvents:UIControlEventValueChanged];
			}
			
			break;
		}
		
		section.origin.x += section.size.width;
	}
	
	[self setNeedsDisplay];
	return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGFloat width = self.frame.size.width;
	CGRect section = CGRectMake(0, 0, width / self.maxStars, self.frame.size.height);
	
	CGPoint touchLocation = [touch locationInView:self];
	
	if (touchLocation.x < 0)
	{
		if (_rating != 0)
		{	
			_rating = 0;
			[self sendActionsForControlEvents:UIControlEventValueChanged];
		}
	}
	else if (touchLocation.x > width)
	{
		if (_rating != self.maxStars)
		{
			_rating = self.maxStars;
			[self sendActionsForControlEvents:UIControlEventValueChanged];
		}
	}
	else
	{
		for (int i = 0; i < self.maxStars; i++)
		{
			if (touchLocation.x > section.origin.x && touchLocation.x < section.origin.x + section.size.width)
			{ // touch is inside section
				if (_rating != (i+1))
				{
					_rating = i+1;
					[self sendActionsForControlEvents:UIControlEventValueChanged];
				}
				break;
			}
			
			section.origin.x += section.size.width;
		}
	}
	
	[self setNeedsDisplay];
	return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGFloat width = self.frame.size.width;
	CGRect section = CGRectMake(0, 0, width / self.maxStars, self.frame.size.height);
	
	CGPoint touchLocation = [touch locationInView:self];
	
	if (touchLocation.x < 0)
	{
		if (_rating != 0)
		{	
			_rating = 0;
			[self sendActionsForControlEvents:UIControlEventValueChanged];
		}
	}
	else if (touchLocation.x > width)
	{
		if (_rating != self.maxStars)
		{
			_rating = self.maxStars;
			[self sendActionsForControlEvents:UIControlEventValueChanged];
		}
		
	}
	else
	{
		for (int i = 0; i < self.maxStars; i++)
		{
			if (touchLocation.x > section.origin.x && touchLocation.x < section.origin.x + section.size.width)
			{
				if (_rating != (i+1))
				{
					_rating = i+1;
					[self sendActionsForControlEvents:UIControlEventValueChanged];
				}
				
				break;
			}
			
			section.origin.x += section.size.width;
		}
	}
	
	[self setNeedsDisplay];
}

@end

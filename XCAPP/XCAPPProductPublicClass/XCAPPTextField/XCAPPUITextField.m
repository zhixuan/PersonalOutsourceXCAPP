//
//  XCAPPUITextField.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/8.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCAPPUITextField.h"

@implementation XCAPPUITextField

- (void)drawRect:(CGRect)rect

{
    
    if( [[self placeholder] length] > 0 )
        
    {
        
        if ( self.xcPlaceHolderLabel == nil )
            
        {
            
            self.xcPlaceHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            
//            self.xcPlaceHolderLabel.lineBreakMode = UILineBreakModeWordWrap;
            
            self.xcPlaceHolderLabel.numberOfLines = 0;
            
            self.xcPlaceHolderLabel.font = self.font;
            
            self.xcPlaceHolderLabel.backgroundColor = [UIColor clearColor];
            
            self.xcPlaceHolderLabel.textColor = self.xcPlaceholderColor;
            
            self.xcPlaceHolderLabel.alpha = 0;
            
            self.xcPlaceHolderLabel.tag = 999;
            
            [self addSubview:self.xcPlaceHolderLabel];
            
        }
        
        
        
        self.xcPlaceHolderLabel.text = self.placeholder;
        
        [self.xcPlaceHolderLabel sizeToFit];
        
        [self sendSubviewToBack:self.xcPlaceHolderLabel];
        
    }
    
    
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
        
    {
        
        [[self viewWithTag:999] setAlpha:1];
        
    }
    
    
    
    [super drawRect:rect];
    
}

- (id)initWithFrame:(CGRect)frame

{
    
    if( (self = [super initWithFrame:frame]) )
        
    {
        
        [self setPlaceholder:@""];
        
//        [self setXcPlaceholder:@""];
        
        [self setXcPlaceholderColor:[UIColor lightGrayColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    
    return self;
    
}

- (void)textChanged:(NSNotification *)notification

{
    
    if([[self placeholder] length] == 0)
        
    {
        
        return;
        
    }
    
    
    
    if([[self text] length] == 0)
        
    {
        
        [[self viewWithTag:999] setAlpha:1];
        
    }
    
    else
        
    {
        
        [[self viewWithTag:999] setAlpha:0];
        
    }
    
}



- (void)setText:(NSString *)text {
    
    [super setText:text];
    
    [self textChanged:nil];
    
}



- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setPlaceholder:@""];
    
//    [self setXcPlaceholder:@""];
    
    [self setXcPlaceholderColor:[UIColor lightGrayColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc

{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.xcPlaceHolderLabel = nil;
    
    self.xcPlaceholderColor = nil;
    
//    self.xcPlaceholder = nil;
#if ! __has_feature(objc_arc)
    [self.xcPlaceHolderLabel release];
    [self.xcPlaceholderColor release];
//    [self.xcPlaceholder release];
    [super dealloc];
#endif
    
}
@end

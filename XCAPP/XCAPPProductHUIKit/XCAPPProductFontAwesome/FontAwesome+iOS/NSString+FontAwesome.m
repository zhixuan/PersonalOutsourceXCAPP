//
//  NSString+FontAwesome.m
//
//  Copyright (c) 2012 Alex Usbergo. All rights reserved.
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//

#import "NSString+FontAwesome.h"

@implementation NSString (FontAwesome)

#pragma mark - Public API
+ (FMIconFont)fontAwesomeEnumForIconIdentifier:(NSString*)string {
    NSDictionary *enums = [self enumDictionary];
    return [enums[string] integerValue];
}

+ (NSString*)fontAwesomeIconStringForEnum:(FMIconFont)value {
    
    
    
//    [NSString fontAwesomeUnicodeStrings][value]
    return [NSString fontAwesomeUnicodeStrings][value];
}

+ (NSString*)fontAwesomeIconStringForIconIdentifier:(NSString*)identifier {
    return [self fontAwesomeIconStringForEnum:[self fontAwesomeEnumForIconIdentifier:identifier]];
}


#pragma mark - Data Initialization
+ (NSArray *)fontAwesomeUnicodeStrings {
    
    static NSArray *fontAwesomeUnicodeStrings;
    
    static dispatch_once_t unicodeStringsOnceToken;
    dispatch_once(&unicodeStringsOnceToken, ^{
        
        
        fontAwesomeUnicodeStrings = @[@"\ue900", @"\ue901", @"\ue902",@"\ue903",
                                      @"\ue904", @"\ue905", @"\ue906",@"\ue907",
                                      @"\ue908", @"\ue909", @"\ue90A",@"\ue90B",
                                      @"\ue90C", @"\ue90D", @"\ue90E",@"\ue90F",
                                      @"\ue910", @"\ue911", @"\ue912",@"\ue913",
                                      @"\ue914", @"\ue915", @"\ue916",@"\ue917",
                                      @"\ue918", @"\ue919", @"\ue91A",@"\ue91B",
                                      @"\ue91C", @"\ue91D", @"\ue91E",@"\ue91F",
                                      @"\ue920", @"\ue921", @"\ue922",@"\ue923",
                                      @"\ue924", @"\ue925", @"\ue926",@"\ue927",
                                      @"\ue928", @"\ue929", @"\ue92A",@"\ue92B",
                                      @"\ue92C", @"\ue92D", @"\ue92E",@"\ue92F",
                                      @"\ue930", @"\ue931", @"\ue932",@"\ue933",
                                      @"\ue934", @"\ue935", @"\ue936",@"\ue937",
                                      @"\ue938", @"\ue939", @"\ue93A",@"\ue93B",
                                      @"\ue93C", @"\ue93D", @"\ue93E",@"\ue93F",
                                      @"\ue940", @"\ue941", @"\ue642",@"\ue943",
                                      @"\ue944", @"\ue645", @"\ue646",@"\ue647",
                                      @"\ue948", @"\ue649", @"\ue64A",@"\ue64B",
                                      @"\ue94C", @"\ue64D", @"\ue64E",@"\ue64F",];
    });
    
    return fontAwesomeUnicodeStrings;
}

+ (NSDictionary *)enumDictionary {
    
	static NSDictionary *enumDictionary;
    
    static dispatch_once_t enumDictionaryOnceToken;
    dispatch_once(&enumDictionaryOnceToken, ^{
        
		NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
		enumDictionary = tmp;
	});
    
    return enumDictionary;
}

@end

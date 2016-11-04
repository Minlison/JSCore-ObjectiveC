//
//  CustomWebView.m
//  demo
//
//  Created by youdaoli666 on 16/4/6.
//  Copyright © 2016年 zqc. All rights reserved.
//

#import "CustomWebView.h"

@interface CustomWebView()

@end

@implementation CustomWebView
{
    UIMenuController *menuController;
    UIMenuItem *menuItemFavorite;
	id <UIWebViewDelegate> _in_delegate;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
		[self _InitMenu];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
	    [self _InitMenu];
    }
    return self;
}

- (void)_InitMenu
{
	[self becomeFirstResponder];
	// Initialization code
	
//	menuController = [UIMenuController sharedMenuController];
//	menuItemFavorite = [[UIMenuItem alloc] initWithTitle:@"划线" action:@selector(Favorite:)];
//	UIMenuItem *menuItemNote = [[UIMenuItem alloc] initWithTitle:@"笔记" action:@selector(Note:)];
//	UIMenuItem *menuItemShare = [[UIMenuItem alloc] initWithTitle:@"文摘" action:@selector(Share:)];
//	//        UIMenuItem *menuItemCopy = [[UIMenuItem alloc] initWithTitle:@"文摘" action:@selector(jumpToWenZhaiVC:)];
//	UIMenuItem *menuItemCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(Copy:)];
//	
//	NSArray *mArray = [NSArray arrayWithObjects:menuItemCopy,menuItemFavorite,menuItemNote,menuItemShare, nil];
//	
//	[menuController setMenuItems:mArray];
//	[menuController update];
	
	
	//设置显示位置
	//[menuController setTargetRect:CGRectMake(15, 15, 100, 50) inView:self];
	//显示
	//        [menuController setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder
{
    return  YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    NSString* isAppliedToSelection = [self stringByEvaluatingJavaScriptFromString:@"isAppliedToSelection()"];
    if([isAppliedToSelection isEqualToString:@"true"])
        menuItemFavorite.title = @"取消划线";
    else
        menuItemFavorite.title = @"划线";
    //NSLog(@"isAppliedToSelection=%@",isAppliedToSelection);
    if(action == @selector(Favorite:) || action == @selector(Note:) ||action == @selector(Share:) || action == @selector(Copy:)){
        return YES;
    }
    
    return NO;
}


-(void)Favorite:(id)sender{
    NSString* selection = [self stringByEvaluatingJavaScriptFromString:@"selFavorite()"];
    
    if(_favoriteD!=nil && [_favoriteD respondsToSelector: @selector(Favorite:)] == true){
        [_favoriteD Favorite:selection]; //调用协议委托
    }
    
    
    //NSLog(@"selFavorite=%@",selection);
}

-(void)Note:(id)sender{
    NSString* selection = [self stringByEvaluatingJavaScriptFromString:@"selNote()"];
    
    if(_noteD!=nil && [_noteD respondsToSelector: @selector(Note:)] == true){
        [_noteD Note:selection]; //调用协议委托
    }
    
    //NSLog(@"selNote=%@",selection);
}

-(void)Share:(id)sender{
    NSString* selection = [self stringByEvaluatingJavaScriptFromString:@"selShare()"];
    
    if(_shareD!=nil && [_shareD respondsToSelector: @selector(Share:)] == true){
        [_shareD Share:selection]; //调用协议委托
    }
    
    //NSLog(@"selShare=%@",selection);
}

-(void)Copy:(id)sender{
    NSString* selection = [self stringByEvaluatingJavaScriptFromString:@"selCopy()"];
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = selection;
}

-(void)unNote{
    [self stringByEvaluatingJavaScriptFromString:@"unNote()"];
    
    //NSLog(@"selNote=%@",selection);
}



@end

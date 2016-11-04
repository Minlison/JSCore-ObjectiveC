//
//  CustomWebView.h
//  EBook
//
//  Created by GJHMac on 16/4/11.
//  Copyright © 2016年 leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomWebView : UIWebView

@property ( nonatomic,strong) id favoriteD;
@property ( nonatomic,strong) id noteD;
@property ( nonatomic,strong) id shareD;

-(void)unNote;

@end

@protocol FavoriteDelegate
-(void)Favorite:(NSString *)content;
-(void)Note:(NSString *)content;
-(void)Share:(NSString *)content;

@end

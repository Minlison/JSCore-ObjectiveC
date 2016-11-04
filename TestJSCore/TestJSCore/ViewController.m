//
//  ViewController.m
//  testDownloadTask
//
//  Created by MinLison on 2016/11/4.
//  Copyright © 2016年 com.ichengzivrpro.orgz. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (assign, nonatomic) BOOL isExpend;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@end

@implementation ViewController
- (IBAction)expend:(UIBarButtonItem *)sender
{
	if (_isExpend)
	{
		[self.webView stringByEvaluatingJavaScriptFromString:@"hidden()"];
	}
	else
	{
		[self.webView stringByEvaluatingJavaScriptFromString:@"show()"];
	}
	_isExpend = !_isExpend;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor blueColor];
	
	//
	
	// 固定
	NSString *path = [[NSBundle mainBundle] pathForResource:@"notes" ofType:@"html"];
	NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
	NSString *basePath = [[NSBundle mainBundle] bundlePath];
	NSURL *baseUrl = [NSURL fileURLWithPath:basePath];
	[self.webView loadHTMLString:htmlString baseURL:baseUrl];
	
	
	
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	
	JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
	context[@"resizeWindow"] = ^(){
		NSArray <JSValue *>*args = [JSContext currentArguments];
		for (JSValue *jsVal in args) {
			NSLog(@"%@", jsVal.toString);
		}
		
		NSInteger w = args.firstObject.toInt32;
		NSInteger h = args.lastObject.toInt32;
		self.heightConst.constant = h + 24;
	};
	
	NSString *str = @"杨某发现丈夫孙某某因赌博欠下高额债务后，将自家房产卖掉偿还赌债。两人离婚后，杨某依然帮助前夫还债，并不惜挪用某公司资金，并将另一家公司的9套房产变更到自己和前夫名下，以此获得抵押贷款。后挪用资金的事情东窗事发，杨某获刑3年，缓刑3年。近日，通州区法院对杨某变更公司9套房屋产权的案件进行了审理，法院认为，将公有房屋产权变更并用以抵押贷款供个人使用，构成挪用公款罪。其前夫孙某某也因为配合杨某变更产权构成挪用公款罪。通州法院最终判处杨某有期徒刑6年，与前罪挪用资金罪并罚，决定执行有期徒刑8年6个月，孙某某则被判处有期徒刑1年，缓刑1年。</p><p><strong>变更9套公有房屋产权获得抵押贷款";
	
	
	str = [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
	str = [str stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
	NSString * jsStr = [NSString stringWithFormat:@"loadData(\"%@\")",str];
	
	NSString *res = [self.webView stringByEvaluatingJavaScriptFromString:jsStr];
	
	NSLog(@"%@",NSStringFromCGSize(self.webView.scrollView.contentSize));
	
	
//	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//		[self.webView stringByEvaluatingJavaScriptFromString:@"loadData(\"lallalallaldfasdf阿里的时刻给家里速度快放假了思考及地方了\")"];
//	});
}



- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end

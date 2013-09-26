//
//  CLMGridMenuController.m
//  GridMenuController
//
//  Created by Andrew Hulsizer on 9/2/13.
//  Copyright (c) 2013 Andrew Hulsizer. All rights reserved.
//

#import "CLMGridMenuController.h"
#import "CLMGridMenuItem.h"
#import "CLMGridMenuView.h"
#import "CLMGridMenuLayout.h"
#import "CLMGridMenuPresentation.h"

@interface CLMGridMenuController () <CLMGridMenuViewDataSource, CLMGridMenuViewDelegate>

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) id<CLMGridMenuLayout> layout;
@property (nonatomic, strong) id<CLMGridMenuPresentation> presentation;
@end

@implementation CLMGridMenuController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers layout:(id<CLMGridMenuLayout>)layout presentation:(id<CLMGridMenuPresentation>)presentation
{
    self = [super init];
    if (self)
    {
        _viewControllers = viewControllers;
        _layout = layout;
        _presentation = presentation;
    }
    
    return self;
}

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
	[self configureContentView];
    [self configureGridMenuView];
	[self addViewControllersAsChildren];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setFirstView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Builders
- (void)configureContentView
{
	self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:self.contentView];
}

- (void)configureGridMenuView
{
    self.gridMenuView = [[CLMGridMenuView alloc] initWithFrame:self.view.bounds];
    self.gridMenuView.delegate = self;
    self.gridMenuView.dataSource = self;
    
    [self.view addSubview:self.gridMenuView];
}

- (void)addViewControllersAsChildren
{
	[self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *controller, NSUInteger idx, BOOL *stop) {
		[self addChildViewController:controller];
		[controller didMoveToParentViewController:self];
	}];
}

- (void)setFirstView
{
	UIViewController<CLMGridMenuItemViewController> *controller = [self.viewControllers firstObject];
    
	[self.contentView addSubview:controller.view];
    self.contentViewController = controller;
    
    [self.gridMenuView selectGridMenuItemAtIndex:0];
    
}

#pragma mark - CLMGridMenuViewDelegate

- (void)gridMenuView:(CLMGridMenuView *)gridMenuView didSelectItemAtIndex:(NSUInteger)index
{
    UIViewController<CLMGridMenuItemViewController> *fromViewController = self.contentViewController;
    UIViewController<CLMGridMenuItemViewController> *toViewController = [self.viewControllers objectAtIndex:index];
    
	//Add toViewController
	[self.contentView addSubview:toViewController.view];
	
    [self.presentation transitionFromViewController:fromViewController toViewController:toViewController];

    self.contentViewController = toViewController;
	
	[self.gridMenuView selectGridMenuItemAtIndex:index];
}

#pragma mark - CLMGridMenuViewDatasource

- (NSUInteger)numberOfMenuItems
{
    return [_viewControllers count];
}

- (id<CLMGridMenuLayout>)layoutForMenu
{
    return _layout;
}

//NOTE: Maybe make this return a UIButton
- (CLMGridMenuItem *)gridMenuItemForIndex:(NSUInteger)index
{
    UIViewController<CLMGridMenuItemViewController> *gridMenuItemViewController = [self.viewControllers objectAtIndex:index];
    return gridMenuItemViewController.gridMenuItem;
}

@end

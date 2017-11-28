//
//  ViewController.m
//  ExpenceHelper
//
//  Created by Gaurav Bhadane on 19/11/17.
//  Copyright © 2017 GB. All rights reserved.
//

#import "SideMenuViewController.h"
#import "HomeViewController.h"

@interface SideMenuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *userInfoView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userEnailID;

@end

@implementation SideMenuViewController{
    NSArray * sideMenuArray;
    long selectedIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpUI];
    [self.tableView reloadData];
    selectedIndex = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpUI
{
    sideMenuArray = [self getMenuOptions];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.userName.text = @"Gaurav Bhadane";
    self.userEnailID.text = @"gauravbhadane2996@gmail.com";
//    self.userImage.image = ;
    
//    [self.tableView registerClass:(SideMenuTableViewCell.self) forCellReuseIdentifier:@"SideMenuTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SideMenuTVCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SideMenuTVCell"];
    

}
- (NSArray *) getMenuOptions
{
   /* <dict>
    <key>MENU_NAME</key>
    <string>Home</string>
    <key>MENU_IMAGE</key>
    <string>menu_home.png</string>
    <key>SHOW_FLAG</key>
    <string>Y</string>
    <key>TAG</key>
    <string>1</string>
    </dict>
    */
    
    NSMutableArray *items = [[NSMutableArray alloc] init] ;
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"AppConfig" ofType:@"plist"];
    NSDictionary * actionMenuList = [[NSDictionary alloc]initWithContentsOfFile:plistPath ];
    
    NSMutableArray *defaultNavMenuList = (NSMutableArray *)[[NSArray alloc]initWithArray:[actionMenuList objectForKey:@"SIDE_MENU"]];
    
    for(NSDictionary * navMenuDict in defaultNavMenuList)
    {
        NSString *menuDefaultTitle = [navMenuDict objectForKey:@"MENU_NAME"];
        NSString *menuIcon = [navMenuDict objectForKey:@"MENU_IMAGE"];
        NSString *menuTag = [navMenuDict objectForKey:@"TAG"];
        BOOL showMenu = [[navMenuDict objectForKey:@"SHOW_FLAG"] isEqualToString:@"Y"];
        
        if(showMenu)
            [items addObject:[[NSDictionary alloc] initWithObjectsAndKeys:menuDefaultTitle,@"MENU_NAME", menuIcon,@"MENU_IMAGE",menuTag,@"TAG", nil]];
    }
    
    return items;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return sideMenuArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * sideMenuDict = [sideMenuArray objectAtIndex:indexPath.row];
    
    SideMenuTVCell *cell = [tableView
                              dequeueReusableCellWithIdentifier:@"SideMenuTVCell"];
    if (cell == nil) {
        cell = [[SideMenuTVCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"SideMenuTVCell"];
    }
    
    cell.lblMenuName.text = [sideMenuDict valueForKey:@"MENU_NAME"];
    cell.tag = [[sideMenuDict valueForKey:@"TAG"]integerValue];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)selectActionMenu:(NSInteger)index
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController * vc ;
    
    
    switch (index) {
            case 0:
             NSLog(@"%ld",index);
                vc = (HomeViewController *) [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
                break;
        default:
            NSLog(@"%ld",index);
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self selectActionMenu:indexPath.row];
}

@end



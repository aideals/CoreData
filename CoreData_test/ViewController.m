//
//  ViewController.m
//  CoreData_test
//
//  Created by 鹏 刘 on 2017/4/10.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "ViewController.h"
#import "Teacher.h"
#import "Student.h"
#import "FechedResultViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSManagedObjectContext *schoolMOC;
@property (nonatomic,strong) UIButton *add;
@property (nonatomic,strong) UIButton *delete;
@property (nonatomic,strong) UIButton *change;
@property (nonatomic,strong) UIButton *push;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initButton];
}

- (NSManagedObjectContext *)contextWithModelName:(NSString *)modelName
{
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite",modelName];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    
    moc.persistentStoreCoordinator = coordinator;
    
    return moc;
}

- (NSManagedObjectContext *)schoolMOC
{
    if (!_schoolMOC) {
       _schoolMOC = [self contextWithModelName:@"School"];
    }
    return _schoolMOC;
}

- (void)initButton
{
    self.add = [[UIButton alloc] initWithFrame:CGRectMake(130, 110, 125, 60)];
    self.add.backgroundColor = [UIColor yellowColor];
    [self.add setTitle:@"Add" forState:UIControlStateNormal];
    [self.add setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.add addTarget:self action:@selector(addEntity:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.add];
    
    self.delete = [[UIButton alloc] initWithFrame:CGRectMake(130, 200, 125, 60)];
    self.delete.backgroundColor = [UIColor yellowColor];
    [self.delete setTitle:@"Delete" forState:UIControlStateNormal];
    [self.delete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.delete addTarget:self action:@selector(deleteEntity:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.delete];

    self.change = [[UIButton alloc] initWithFrame:CGRectMake(130, 300, 125, 60)];
    self.change.backgroundColor = [UIColor yellowColor];
    [self.change setTitle:@"Change" forState:UIControlStateNormal];
    [self.change setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.change addTarget:self action:@selector(changeEntity:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.change];

    self.push = [[UIButton alloc] initWithFrame:CGRectMake(130, 420, 125, 60)];
    self.push.backgroundColor = [UIColor yellowColor];
    [self.push setTitle:@"Push" forState:UIControlStateNormal];
    [self.push setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.push addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.push];

}

- (IBAction)addEntity:(UIButton *)sender
{
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.schoolMOC];
    student.name = @"Liu Song Song";
    student.age = @(23);
    
    NSError *error = nil;
    if (self.schoolMOC.hasChanges) {
        [self.schoolMOC save:&error];
    }

    if (error) {
        NSLog(@"Core Data insert data is failed:%@",error);
    }

}

- (IBAction)deleteEntity:(UIButton *)sender
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",@"Liu Song Song"];
    request.predicate = predicate;
    
    NSError *error = nil;
    NSArray<Student *> *students = [self.schoolMOC executeFetchRequest:request error:&error];
    [students enumerateObjectsUsingBlock:^(Student * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.schoolMOC deleteObject:obj];
    }];

    if (self.schoolMOC.hasChanges) {
        [self.schoolMOC save:&error];
    }

}

- (IBAction)changeEntity:(UIButton *)sender
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",@"Liu Song Song"];
    request.predicate = predicate;
    
    
    NSError *error = nil;
    NSArray<Student *> *students = [self.schoolMOC executeFetchRequest:request error:&error];
    [students enumerateObjectsUsingBlock:^(Student * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.age = @(22);
    }];
    
    
    if (self.schoolMOC.hasChanges) {
        [self.schoolMOC save:&error];
    }
 
    if (error) {
        NSLog(@"Core Data change data is failed:%@",error);
    }


}

- (IBAction)pushView:(UIButton *)sender
{
    FechedResultViewController *frvc = [[FechedResultViewController alloc] initWithNibName:nil bundle:nil];
    frvc.title = @"Feched Result";
    [self.navigationController pushViewController:frvc animated:nil];
}




@end

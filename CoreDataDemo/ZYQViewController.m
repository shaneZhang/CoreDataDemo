//
//  ZYQViewController.m
//  CoreDataDemo
//
//  Created by 张毓庆 on 13-12-7.
//  Copyright (c) 2013年 张毓庆. All rights reserved.
//

#import "ZYQViewController.h"
#import <CoreData/CoreData.h>
#import "Person.h"
#import "Book.h"

@interface ZYQViewController ()
{
    // CoreData数据库操作的上下
    NSManagedObjectContext *_context;
}
@end

@implementation ZYQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self openDB];
    
    
//    [self addPerson];
    
    [self allPersons];
//    [self updatePerson];
    
//    [self removePerson];
}

#pragma mark - 删除数据
- (void)removePerson
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"name = '张毓庆'"];
    
    NSArray *result = [_context executeFetchRequest:request error:nil];
    
    for (Person *person in result)
    {
        NSLog(@" %@ %@ %@",person.name,person.age,person.phoneNumber);
        
        
        [_context deleteObject:person];
        
        break;
    }
    
    
    if ([_context save:nil])
    {
        NSLog(@"删除数据库成功");
    }
    else
    {
        NSLog(@"删除数据失败");
    }
}

#pragma mark - 更新数据
- (void)updatePerson
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Book"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"name CONTAINS '野性的呼唤'"];
    
    NSArray *result = [_context executeFetchRequest:request error:nil];
    
    for (Book *book in result)
    {
        NSLog(@" %@ , %@",book.name,book.price);
        
        book.name = @"西游记";
    }
    
    if ([_context save:nil])
    {
        NSLog(@"更新数据成功");
    }
    else
    {
        NSLog(@"更新数据失败");
    }
}

#pragma mark - 查询所有数据
- (void)allPersons
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"name like '*张*'"];
    
    NSArray *array = [_context executeFetchRequest:request error:nil];
    
    for (Person *person in array)
    {
        NSLog(@" %@ %@ %@",person.name,person.age,person.phoneNumber);
        
        for (Book *book in person.books)
        {
            NSLog(@"Book %@ %@",book.name,book.price);
        }
    }
}
#pragma mark - 创建数据库
- (void)openDB
{
    // 创建实例化数据库的实体
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // 实例化一个持久化的数据连接调度
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    
    // 数据库的保存路径
    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbPath = [docs[0] stringByAppendingPathComponent:@"myDB.db"];
    NSURL *dbURL = [NSURL fileURLWithPath:dbPath];
    
    // 打开或者是新建数据库的文件
    NSError *error = nil;
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:dbURL options:nil error:&error];
    
    if (error)
    {
        NSLog(@"打开数据库失败");
    }
    else
    {
        NSLog(@"打开数据库成功");
        
        
        // 实例化一个数据库的上下文
        _context = [[NSManagedObjectContext alloc]init];
        _context.persistentStoreCoordinator = store;
    }
    
}

#pragma mark - 添加个人记录
- (void)addPerson
{
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_context];
    
    // 设置个人信息
    person.name = @"张毓庆";
    person.age = @23;
    person.phoneNumber = @"15810499872";
    
    // 新增一本图书
    Book *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:_context];
    book.name = @"野性的呼唤";
    book.price = @50.002;
    
    Book *book2 = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:_context];
    book2.name = @"英语2";
    book2.price = @34.0;
    
    NSSet *bookSet = [NSSet setWithObjects:book,book2, nil];
    person.books = bookSet;
    
    
    if ([_context save:nil])
    {
        NSLog(@"新增数据成功");
    }
    else
    {
        NSLog(@"新增数据失败");
    }
    
}
@end

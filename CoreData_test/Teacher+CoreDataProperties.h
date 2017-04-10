//
//  Teacher+CoreDataProperties.h
//  CoreData_test
//
//  Created by 鹏 刘 on 2017/4/10.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Teacher.h"

NS_ASSUME_NONNULL_BEGIN

@interface Teacher (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *student;

@end

@interface Teacher (CoreDataGeneratedAccessors)

- (void)addStudentObject:(NSManagedObject *)value;
- (void)removeStudentObject:(NSManagedObject *)value;
- (void)addStudent:(NSSet<NSManagedObject *> *)values;
- (void)removeStudent:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END

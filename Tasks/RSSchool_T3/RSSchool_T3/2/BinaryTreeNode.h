//
//  BinaryTreeNode.h
//  RSSchool_T3
//
//  Created by Admin on 4/15/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinaryTreeNode : NSObject

@property(retain, nonatomic)BinaryTreeNode* leftChild;
@property(retain, nonatomic)BinaryTreeNode* rightChild;
@property(assign)BOOL isFull;

@end


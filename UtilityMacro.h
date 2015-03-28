//
//  UtilityMacro.h
//  HandRuler
//
//  Created by 盛鹏超 on 15/3/21.
//  Copyright (c) 2015年 盛鹏超. All rights reserved.
//

#ifndef HandRuler_UtilityMacro_h
#define HandRuler_UtilityMacro_h

#define DECLARE_SINGLETON_FOR_CLASS(classname) +(classname *) shared##classname;
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) static classname *shared##classname = nil;+ (classname *)shared##classname{    @synchronized(self)   {       if (shared##classname == nil)        {            shared##classname = [[self alloc] init];        }    }   return shared##classname;} + (id)allocWithZone:(NSZone *)zone{    @synchronized(self)    {        if (shared##classname == nil)     {            shared##classname = [super allocWithZone:zone];          return shared##classname;        }    }    return nil;} - (id)copyWithZone:(NSZone *)zone{    return self;} 


#endif

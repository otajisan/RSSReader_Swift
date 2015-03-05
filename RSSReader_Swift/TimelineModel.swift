//
//  TimelineModel.swift
//  RSSReader_Swift
//
//  Created by MTL on 2015/03/05.
//  Copyright (c) 2015年 MTL. All rights reserved.
//

import Foundation

class TimelineModel : NSObject {
    var title:NSString
    var imageUrl:NSURL?
    
    init(title: String, imageUrl: NSURL?){
        self.title = title
        self.imageUrl = imageUrl
    }
}
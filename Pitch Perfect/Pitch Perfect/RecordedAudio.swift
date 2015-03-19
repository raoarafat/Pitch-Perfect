//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Arafat on 3/17/15.
//  Copyright (c) 2015 Arafat. All rights reserved.
//

import UIKit

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    //Initializer OR Constructor
   init(title : String, filePathUrl : NSURL) {
        self.title = title
        self.filePathUrl = filePathUrl
    }
    
}

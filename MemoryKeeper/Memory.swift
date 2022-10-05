//
//  Memory.swift
//  MemoryKeeper
//
//  Created by Grant Watson on 10/5/22.
//

import Foundation

class Memory: NSObject {
    var image: String
    var caption: String
    
    init(image: String, caption: String) {
        self.image = image
        self.caption = caption
    }
}

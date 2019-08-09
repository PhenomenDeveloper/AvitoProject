//
//  Object.swift
//  AvitoProject
//
//  Created by Lev Kolesnikov on 24/07/2019.
//  Copyright © 2019 phenomendevelopers. All rights reserved.
//

import Foundation

struct Object {
    
    let id: Int
    let value: Any
    
    init? (jsonData: [String: Any]) {
        guard let id = jsonData["id"] as? Int,
            jsonData.keys.contains(where: { $0 == "value" }) else {
                return nil
        }
        
        let value = jsonData["value"]
        
        self.id = id
        self.value = value!
    }
    
}

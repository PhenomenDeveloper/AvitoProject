//
//  Parametr.swift
//  AvitoProject
//
//  Created by Lev Kolesnikov on 24/07/2019.
//  Copyright © 2019 phenomendevelopers. All rights reserved.
//

import Foundation

struct Parameter: Codable {
    
    let id: Int
    let title: String
    var value: String?
    var values: [Value]?
    
    init? (jsonData: [String : Any]) {
        guard let id = jsonData["id"] as? Int,
            let title = jsonData["title"] as? String,
            let value = jsonData["value"] as? String,
            let values = jsonData["values"] as? [Any]?
            else {
                return nil
        }
        
        var loadedValues : [Value]? = nil
        
            if values is [[String: Any]] {
                if !values!.isEmpty {
                    loadedValues = []
                    for value in values! {
                        if let object = value as? [String:Any] {
                            loadedValues?.append(Value(jsonData: object)!)
                        }
                    }
                }
        }
        
        self.id = id
        self.title = title
        self.value = value
        self.values = loadedValues
    }
    
}

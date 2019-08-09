//
//  Value.swift
//  AvitoProject
//
//  Created by Lev Kolesnikov on 24/07/2019.
//  Copyright © 2019 phenomendevelopers. All rights reserved.
//

import Foundation

struct Value: Codable {
    
    let id: Int
    let title: String
    var parameters: [Parameter]?
    
    init? (jsonData: [String : Any]) {
        
        guard let id = jsonData["id"] as? Int,
            let title = jsonData["title"] as? String,
            let params = jsonData["params"] as? [Any]?
            else {
                
                return nil
        }
        
        var parameters : [Parameter]? = nil
        
        if params is [[String : Any]] {
            if !params!.isEmpty {
                parameters = []
                for object in params! {
                    if let obj = object as? [String: Any] {
                        parameters!.append(Parameter(jsonData: obj)!)
                    }
                }
            }
        }
        
        self.id = id
        self.title = title
        self.parameters = parameters
    }
    
}

//
//  Error.swift
//  AvitoProject
//
//  Created by Lev Kolesnikov on 30/07/2019.
//  Copyright © 2019 phenomendevelopers. All rights reserved.
//

import Foundation
// Возможные ошибки при работе с JSON
enum JSONError: Error {
    case invalidInputData
    case invalidURL
    
}

struct TypeError: Codable {
    let error : MessageError
}

struct MessageError: Codable {
    let message: String
}

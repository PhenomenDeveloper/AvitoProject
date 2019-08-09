//
//  ViewModels.swift
//  AvitoProject
//
//  Created by Lev Kolesnikov on 30/07/2019.
//  Copyright © 2019 phenomendevelopers. All rights reserved.
//

import Foundation

class AvitoHomeViewModel {
    //     получение JSON из файла
    public func getJSON(filename: String, withExtension: String) throws -> [String: Any]? {
        
        let file: URL? = Bundle.main.url(forResource: filename, withExtension: withExtension)
        
        guard let filePath = file?.path else {
            throw JSONError.invalidURL
        }
        
        let data: Data = try Data(contentsOf: URL(fileURLWithPath: filePath))
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            return jsonData
        } catch {
            throw JSONError.invalidInputData
        }
        
    }
    //    Преобразование JSON в необходимый объект
    public func getStructure (_ json: [String: Any]) -> [Parameter] {
        var parameters: [Parameter] = []
        let jsonParameters = json["params"] as? [[String: Any]]
        
        for object in jsonParameters! {
            if let newParameter = Parameter(jsonData: object) {
                parameters.append(newParameter)
            }
        }
        return parameters
        
    }
    //    Преобразование JSON в необходимый объект
    public func getDraftValues (_ json: [String: Any]) -> [Int: Object] {
        var objects: [Int: Object] = [:]
        let jsonObjects = json["values"] as? [[String: Any]]
        for object in jsonObjects! {
            if let newObject = Object(jsonData: object) {
                objects[newObject.id] = newObject
            }
        }
        return objects
        
    }
// Объединение и запись итогового файла Structure_with_values.json
    public func combineJSON (avitoArray: inout [Parameter], answers: [Int: Object]) -> String? {
        
        var resultDict: [Int: String] = [:]
        
        for elementObject in answers {
            if elementObject.value.value is Int  {
                var tempTuple: (Object, String) = (elementObject.value, "")
                createResultDict(tempTuple: &tempTuple, avitoArray: avitoArray)
                resultDict[elementObject.key] = tempTuple.1
            } else {
                resultDict[elementObject.key] = elementObject.value.value as? String
            }
        }
        
        combineStructureWithValues(resultDict: resultDict, avitoArray: &avitoArray)
        let data = try! JSONEncoder().encode(avitoArray)
        let pathJSON = createJSON(data, "Structure_with_values")
        
        guard let path = pathJSON else {
             return nil
        }
        
        return path
      
    }
    // Создание словаря со связью [id: Value](Value, которое необходимо подставить в Structure)
    public func createResultDict (tempTuple: inout (Object, String), avitoArray: [Parameter]) {
        for itemParams in avitoArray {
            if tempTuple.0.value as! Int == itemParams.id {
                tempTuple.1 = itemParams.title
            }
            if itemParams.values != nil {
                for itemValues in itemParams.values! {
                    if tempTuple.0.value as! Int == itemValues.id {
                        tempTuple.1 = itemValues.title
                    } else
                        if itemValues.parameters != nil {
                            createResultDict(tempTuple: &tempTuple, avitoArray: itemValues.parameters!)
                    }
                }
            }
        }
        
    }
    
//    Заполнение Structure с использованием созданного ранее словаря
    public func combineStructureWithValues (resultDict: [Int: String], avitoArray: inout [Parameter]) {
        for indexParam in 0...avitoArray.count - 1 {
            
            if resultDict[avitoArray[indexParam].id] != nil {
                avitoArray[indexParam].value = resultDict[avitoArray[indexParam].id]
            }
            
            if avitoArray[indexParam].values != nil {
                for indexValue in 0...avitoArray[indexParam].values!.count - 1 {
                    if avitoArray[indexParam].values![indexValue].parameters != nil {
                        combineStructureWithValues(resultDict: resultDict, avitoArray: &avitoArray[indexParam].values![indexValue].parameters!)
                    }
                }
            }
        }
        
    }
//    Создание JSON ошибки
    public func getError (typeError: TypeError) -> String? {
        let data = try! JSONEncoder().encode(typeError)
        let pathError = createJSON(data, "error")
        
        guard let path = pathError else {
            return nil
        }
        
        return path
    }
//    Содание JSON + Запись + Путь
    public func createJSON (_ data: Data, _ name: String) -> String? {
         let path: URL? = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
         guard let truePath = path else {
            print("Невозможно создать директорию!")
            return nil
         }
        
        let filePath = truePath.path + "/" + "\(name).json"
        print(filePath)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        try! data.write(to: URL(fileURLWithPath: filePath))
        
        return filePath
    }
    
}


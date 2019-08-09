//
//  ViewController.swift
//  AvitoProject
//
//  Created by Lev Kolesnikov on 24/07/2019.
//  Copyright © 2019 phenomendevelopers. All rights reserved.
//

import UIKit

class AvitoHomeViewController: UIViewController {

    let viewModel: AvitoHomeViewModel = AvitoHomeViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellIdentifier = "cellIdentifier"
    var combineJSONPath: String?
    var errorPath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Avito Project"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.allowsMultipleSelection = false
        
        do {
//            Загрузка JSON данных с файлов
            let structureJSON = (try viewModel.getJSON(filename: "Structure", withExtension: "json"))!
            let draftValuesJSON = (try viewModel.getJSON(filename: "Draft_values", withExtension: "json"))!
//            Создание обрабатываемых объектов
            var strucrueObjects = viewModel.getStructure(structureJSON)
            let draftValuesObjects = viewModel.getDraftValues(draftValuesJSON)
//            Получение итогового JSON файла + его запись + путь
            combineJSONPath = viewModel.combineJSON(avitoArray: &strucrueObjects, answers: draftValuesObjects) ?? ""
            
//            Обработка ошибок при работе с JSON
        } catch JSONError.invalidURL {
            errorPath = AvitoHomeViewModel().getError(typeError: TypeError(error: MessageError(message: "Ошибка URL")))!
            print(errorPath)
        } catch JSONError.invalidInputData {
            errorPath = AvitoHomeViewModel().getError(typeError: TypeError(error: MessageError(message: "Входной файл является неконсистетным")))!
            print(errorPath)
        } catch let error {
            print(error.localizedDescription)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let path = combineJSONPath else {
            return
        }
        
        if let vc = segue.destination as? AppDetailsViewController, segue.identifier == "showAppDetails" {
            vc.path = path
        }
        
    }
    
    @IBAction func appDetailsTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAppDetails", sender: nil)
    }
    

}

extension AvitoHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        для примера
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.imageView.image = UIImage(named: "a-class")
        cell.imageView.contentMode = .scaleAspectFill
        
        cell.descriptionLabel.text = "Mercedes-Benz A-Class"
        
        cell.imageView.applyshadowWithCorner(containerView: cell.shadowView, cornerRadious: 5.0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCarDetails", sender: nil)
    }
}


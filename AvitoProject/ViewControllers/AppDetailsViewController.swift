//
//  AppDetailViewController.swift
//  AvitoProject
//
//  Created by Lev Kolesnikov on 02/08/2019.
//  Copyright © 2019 phenomendevelopers. All rights reserved.
//

import UIKit

class AppDetailsViewController: UIViewController {
    
    var path: String = ""

    @IBOutlet weak var pathTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pathTextView.text = path
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

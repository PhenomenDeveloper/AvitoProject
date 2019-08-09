//
//  CarDetailViewController.swift
//  AvitoProject
//
//  Created by Lev Kolesnikov on 02/08/2019.
//  Copyright © 2019 phenomendevelopers. All rights reserved.
//

import UIKit

class CarDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var engineTypeLabel: UILabel!
    @IBOutlet weak var engineVolume: UILabel!
    @IBOutlet weak var enginePowerLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var vinNumberLabel: UILabel!
    @IBOutlet weak var bodyTypeLabel: UILabel!
    @IBOutlet weak var numberOfDoorsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI () {
        imageView.applyshadowWithCorner(containerView: shadowView, cornerRadious: 5.0)
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

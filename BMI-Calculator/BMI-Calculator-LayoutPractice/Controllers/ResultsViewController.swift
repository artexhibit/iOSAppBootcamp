//
//  ResultsViewController.swift
//  BMI-Calculator-LayoutPractice
//
//  Created by Игорь Волков on 13.08.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var bmiValue: String?
    var advice: String?
    var colour: UIColor?
        
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiLabel.text = bmiValue
        adviceLabel.text = advice
        view.backgroundColor = colour
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //IBOutlets allows to reference to UI element
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!

    @IBAction func rollButtomPressed(_ sender: UIButton) {
    
        //constant for an Array which no need to change in future
        let diceArray = [#imageLiteral(resourceName: "DiceOne"),#imageLiteral(resourceName: "DiceTwo"),#imageLiteral(resourceName: "DiceThree"),#imageLiteral(resourceName: "DiceFour"),#imageLiteral(resourceName: "DiceFive"),#imageLiteral(resourceName: "DiceSix")]
        
        //2 ways of using randomisation in code
        diceImageView1.image = diceArray.randomElement()
        diceImageView2.image = diceArray[Int.random(in: 0...5)]
      
    }
    
}


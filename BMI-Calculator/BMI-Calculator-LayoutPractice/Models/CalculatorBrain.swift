//
//  CalculatorBrain.swift
//  BMI-Calculator-LayoutPractice
//
//  Created by Игорь Волков on 14.08.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

struct CalculatorBrain {

    var bmi: BMI?
    
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight/(height * height)
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more Pies!", color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        } else {
            bmi = BMI(value: bmiValue, advice: "Eat less Pies!", color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        }
    }
    
    func getBMIValue() -> String {
        let bmiValue = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiValue
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

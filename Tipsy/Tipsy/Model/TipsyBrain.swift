
import Foundation

struct TipsyBrain {
    
    var splitNumber:String?
    var billNumber:String?
    var tipNumber:Float?
    
    mutating func tipToFloat(_ tipAmount: String) {
        let tipWithoutPct = String(tipAmount.dropLast())
        tipNumber = Float(tipWithoutPct)! / 100
    }
    
    func stepperToString(_ stepperValue: Double) -> String {
       return String(format: "%.0f", stepperValue)
    }
    
    func calculateResult() -> String {
        let totalSplit = Float(splitNumber!)!
        let totalBill = Float(billNumber!) ?? 0.0
        let totalTip = Float(tipNumber!)
        let result = (totalBill + (totalBill * totalTip)) / totalSplit
        let finalResult = String(format: "%.2f ₽", result)
        return finalResult
    }
}

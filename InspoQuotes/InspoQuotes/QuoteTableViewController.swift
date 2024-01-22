
import UIKit
import StoreKit

class QuoteTableViewController: UITableViewController, SKPaymentTransactionObserver {
    let productID = "ru.volkovigor.InspoQuotes.PremiumQuotes"
    
    var quotesToShow = [
        "Our greatest glory is not in never falling, but in rising every time we fall. — Confucius",
        "All our dreams can come true, if we have the courage to pursue them. – Walt Disney",
        "It does not matter how slowly you go as long as you do not stop. – Confucius",
        "Everything you’ve ever wanted is on the other side of fear. — George Addair",
        "Success is not final, failure is not fatal: it is the courage to continue that counts. – Winston Churchill",
        "Hardships often prepare ordinary people for an extraordinary destiny. – C.S. Lewis"
    ]
    
    let premiumQuotes = [
        "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine. ― Roy T. Bennett",
        "I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear. – Nelson Mandela",
        "There is only one thing that makes a dream impossible to achieve: the fear of failure. ― Paulo Coelho",
        "It’s not whether you get knocked down. It’s whether you get up. – Vince Lombardi",
        "Your true success in life begins only when you make the commitment to become excellent at what you do. — Brian Tracy",
        "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going. – Chantal Sutherland"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        if isPurchased() {
            showPremiumQuotes()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "BrandColor")
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if isPurchased() {
                return quotesToShow.count
            } else {
                return quotesToShow.count + 1
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeparatorCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)
            
            if indexPath.row < quotesToShow.count {
                cell.textLabel?.text = quotesToShow[indexPath.row]
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.textColor = .black
                cell.accessoryType = .none
            } else {
                cell.textLabel?.text = "Get More Quotes"
                cell.textLabel?.textColor = UIColor(named: "BrandColor")
                cell.accessoryType = .disclosureIndicator
            }
            return cell
        }
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == quotesToShow.count {
           buyPremiumQuotes()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 1.0
        } else {
            return UITableView.automaticDimension
        }
    }
    
 //MARK: - In-App Purchase Methods
    
    func buyPremiumQuotes() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            print("You can't make payments")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                //Payment was successful
                //Place for unlocking purchased content
                showPremiumQuotes()
                SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .failed {
                //Payment was Failed
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("Payment was Failed with error: \(errorDescription)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .restored {
                func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
                    showPremiumQuotes()
                    print("Transaction Restored")
                }
            }
        }
    }
    
    func showPremiumQuotes() {
        UserDefaults.standard.set(true, forKey: productID)
        navigationItem.setRightBarButton(nil, animated: true)
        quotesToShow.append(contentsOf: premiumQuotes)
        tableView.reloadData()
    }
    
    func isPurchased() -> Bool {
        let purchaseStatus = UserDefaults.standard.bool(forKey: productID)
        if purchaseStatus {
            print("Previously Purchased")
            return true
        } else {
            return false
        }
    }
    
    @IBAction func restorePressed(_ sender: UIBarButtonItem) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

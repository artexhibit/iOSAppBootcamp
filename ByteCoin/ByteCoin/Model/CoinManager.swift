
import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager, currency: CurrencyModel)
    func didFailWithError(_ coinManager: CoinManager, error: Error)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "AF9FAD1C-9598-4854-BF03-4339EF30464F"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(self, error: error!)
                    return
                }
                if let safeData = data {
                    let coinData = self.parseJSON(safeData)
                    self.delegate?.didUpdateCurrency(self, currency: coinData!)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CurrencyModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let coinRate = decodedData.rate
            let currencyName = decodedData.asset_id_quote
            let coin = CurrencyModel(coinRate: coinRate, currencyName: currencyName)
            return coin
        } catch {
            delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
}

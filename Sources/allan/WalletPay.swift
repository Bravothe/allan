import SwiftUI

public class WalletPay: ObservableObject {
    private let userId = "USER_123" // Hardcoded User ID
    private var walletBalance: Double = 100.0 // Hardcoded Balance
    
    @Published var showPurchaseAlert = false
    @Published var showTransactionAlert = false
    @Published var showResultAlert = false
    @Published var transactionMessage = ""
    @Published var purchaseDetails: (buyer: String, items: [String], amount: Double)? = nil
    @Published var enteredPasscode = ""
    @Published var transactionResult = ""

    public init() {}

    // Function to start the purchase process
    public func startPurchase(buyer: String, items: [String], amount: Double) {
        self.purchaseDetails = (buyer, items, amount)
        self.showPurchaseAlert = true
    }
    
    // Function to process the payment
    public func processTransaction() {
        guard let details = purchaseDetails else { return }
        
        if walletBalance >= details.amount {
            walletBalance -= details.amount
            transactionResult = "Payment Processed Successfully"
        } else {
            transactionResult = "Insufficient Balance"
        }
        
        showTransactionAlert = false
        showResultAlert = true
    }
}


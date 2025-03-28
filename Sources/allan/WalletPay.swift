import SwiftUI

public class WalletPay: ObservableObject {
    private let userId = "USER_123" // Hardcoded User ID (for validation)
    private var walletBalance: Double = 100.0 // Hardcoded Balance
    
    @Published var showPopup = false
    @Published var showTransactionPopup = false
    @Published var showResultPopup = false
    @Published var transactionMessage = ""
    @Published var purchaseDetails: (buyer: String, items: [String], amount: Double)? = nil
    @Published var enteredPasscode = ""
    @Published var transactionResult = ""

    public init() {}

    // Function to initiate the payment process
    public func startPurchase(buyer: String, items: [String], amount: Double) {
        self.purchaseDetails = (buyer, items, amount)
        self.showPopup = true
    }
    
    // Function to validate the passcode and process the payment
    public func processTransaction() {
        guard let details = purchaseDetails else { return }
        
        if walletBalance >= details.amount {
            walletBalance -= details.amount
            transactionResult = "Payment Processed Successfully"
        } else {
            transactionResult = "Insufficient Balance"
        }
        
        showTransactionPopup = false
        showResultPopup = true
    }
}


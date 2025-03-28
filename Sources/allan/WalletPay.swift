import SwiftUI

public class WalletPay: ObservableObject {
    private let userId = "USER_123" // Hardcoded User ID in library
    private var walletBalance: Double = 100.0 // Hardcoded Balance
    
    @Published var showPurchaseAlert = false
    @Published var showTransactionAlert = false
    @Published var showResultAlert = false
    @Published var showSignInAlert = false
    @Published var transactionMessage = ""
    @Published var purchaseDetails: (buyer: String, items: [String], amount: Double)? = nil
    @Published var enteredPasscode = ""
    @Published var transactionResult = ""

    public init() {
        print("WalletPay initialized") // Debug
    }

    public func startPurchase(userId: String, buyer: String, items: [String], amount: Double) {
        print("startPurchase called with userId: \(userId), buyer: \(buyer), items: \(items), amount: \(amount)") // Debug
        
        self.showPurchaseAlert = false // Reset states
        self.showSignInAlert = false
        
        if userId == self.userId {
            self.purchaseDetails = (buyer, items, amount)
            self.showPurchaseAlert = true
            print("User ID matches, showPurchaseAlert set to: \(showPurchaseAlert), showSignInAlert: \(showSignInAlert)") // Debug
        } else {
            self.showSignInAlert = true
            print("User ID mismatch, showSignInAlert set to: \(showSignInAlert), showPurchaseAlert: \(showPurchaseAlert)") // Debug
        }
    }
    
    func processTransaction() {
        guard let details = purchaseDetails else { return }
        print("Processing transaction for amount: \(details.amount)") // Debug
        
        if walletBalance >= details.amount {
            walletBalance -= details.amount
            transactionResult = "Payment Processed Successfully"
        } else {
            transactionResult = "Insufficient Balance"
        }
        
        showTransactionAlert = false
        showResultAlert = true
        print("Transaction result: \(transactionResult)") // Debug
    }
}

import SwiftUI

public struct WalletPayAlert: View {
    @ObservedObject var walletPay: WalletPay

    public init(walletPay: WalletPay) {
        self.walletPay = walletPay
        print("WalletPayAlert initialized") // Debug
    }
    
    public var body: some View {
        VStack {
            Text("Debug: \(walletPay.showPurchaseAlert ? "Purchase Alert" : walletPay.showSignInAlert ? "Sign In Alert" : "No Alert")") // Debug
        }
        .alert(isPresented: $walletPay.showSignInAlert) { // New sign-in alert
            Alert(
                title: Text("Sign In Required"),
                message: Text("Sign In to continue"),
                dismissButton: .default(Text("OK")) {
                    walletPay.showSignInAlert = false
                }
            )
        }
        .alert(isPresented: $walletPay.showPurchaseAlert) {
            if let details = walletPay.purchaseDetails {
                print("Showing purchase alert") // Debug
                return Alert(
                    title: Text("Purchase Details"),
                    message: Text("""
                        Buyer: \(details.buyer)
                        Items: \(details.items.joined(separator: ", "))
                        Total: $\(details.amount, specifier: "%.2f")
                    """),
                    primaryButton: .default(Text("Next")) {
                        walletPay.showPurchaseAlert = false
                        walletPay.showTransactionAlert = true
                    },
                    secondaryButton: .cancel()
                )
            } else {
                return Alert(title: Text("Error"), message: Text("Invalid purchase details"))
            }
        }
        .alert(isPresented: $walletPay.showTransactionAlert) {
            Alert(
                title: Text("Transaction Summary"),
                message: Text("Enter your wallet passcode to complete the transaction."),
                primaryButton: .default(Text("Continue")) {
                    walletPay.processTransaction()
                },
                secondaryButton: .cancel()
            )
        }
        .alert(isPresented: $walletPay.showResultAlert) {
            Alert(
                title: Text("Transaction Status"),
                message: Text(walletPay.transactionResult),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

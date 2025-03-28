import SwiftUI

public struct WalletPayAlert: View {
    @ObservedObject var walletPay: WalletPay

    public init(walletPay: WalletPay) {
        self.walletPay = walletPay
        print("WalletPayAlert initialized") // Debug
    }
    
    public var body: some View {
        VStack {
            Text("Debug: \(walletPay.showSignInAlert ? "Sign In" : walletPay.showPurchaseAlert ? "Purchase" : walletPay.showTransactionAlert ? "Transaction" : walletPay.showResultAlert ? "Result" : "No Alert")") // Debug
            // Sign-in alert on a separate view
            Color.clear
                .frame(width: 0, height: 0)
                .alert(isPresented: $walletPay.showSignInAlert) {
                    print("Showing sign-in alert") // Debug
                    return Alert(
                        title: Text("Sign In Required"),
                        message: Text("Sign In to continue"),
                        dismissButton: .default(Text("OK")) {
                            walletPay.showSignInAlert = false
                        }
                    )
                }
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
            print("Showing transaction alert") // Debug
            return Alert(
                title: Text("Transaction Summary"),
                message: Text("Enter your wallet passcode to complete the transaction."),
                primaryButton: .default(Text("Continue")) {
                    walletPay.processTransaction()
                },
                secondaryButton: .cancel()
            )
        }
        .alert(isPresented: $walletPay.showResultAlert) {
            print("Showing result alert") // Debug
            return Alert(
                title: Text("Transaction Status"),
                message: Text(walletPay.transactionResult),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

import SwiftUI
public struct WalletPayAlert: View {
    @ObservedObject var walletPay: WalletPay

    public init(walletPay: WalletPay) {
        self.walletPay = walletPay
    }
    
    public var body: some View {
        VStack {}
        .alert(isPresented: $walletPay.showPurchaseAlert) {
            if let details = walletPay.purchaseDetails {
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

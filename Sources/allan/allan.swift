import SwiftUI
public struct WalletPayPopup: View {
    @ObservedObject var walletPay: WalletPay

    public init(walletPay: WalletPay) {
        self.walletPay = walletPay
    }
    
    public var body: some View {
        VStack {
            if walletPay.showPopup, let details = walletPay.purchaseDetails {
                VStack {
                    Text("Purchase Details")
                        .font(.headline)
                    Text("Buyer: \(details.buyer)")
                    Text("Items: \(details.items.joined(separator: ", "))")
                    Text("Total: $\(details.amount, specifier: "%.2f")")
                    Button("Next") {
                        walletPay.showPopup = false
                        walletPay.showTransactionPopup = true
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            
            if walletPay.showTransactionPopup {
                VStack {
                    Text("Transaction Summary")
                    Text("Enter your wallet passcode:")
                    SecureField("Passcode", text: $walletPay.enteredPasscode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button("Continue") {
                        walletPay.processTransaction()
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            
            if walletPay.showResultPopup {
                VStack {
                    Text(walletPay.transactionResult)
                    Button("OK") {
                        walletPay.showResultPopup = false
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        }
    }
}


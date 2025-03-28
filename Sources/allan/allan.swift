import SwiftUI

public struct Allan {
    public private(set) var text = "Hello, World!"
    
    public init() {}
    
    // A SwiftUI View that will display the message in a popup
    public func messageView() -> some View {
        Text(text)
            .padding()
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(8)
            .shadow(radius: 10)
    }
}

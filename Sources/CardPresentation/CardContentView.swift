import SwiftUI

struct CardContentView<Content: View>: View {
    let content: Content
    
    var body: some View {
        content
            .padding()
            .background(.background.secondary)
            .cornerRadius(24)
            .padding(.horizontal, 10)
            .frame(maxWidth: 440)
    }
}

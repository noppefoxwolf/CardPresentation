import SwiftUI

struct CardContentView<Content: View>: View {
    let content: Content
    
    var body: some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(36)
            .padding(.horizontal, 10)
    }
}

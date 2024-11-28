import SwiftUI

struct CardContentView: View {
    @Environment(\.dismiss)
    var dismiss
    
    var body: some View {
        VStack {
            Image(.airpods)
                .resizable()
                .scaledToFit()
                .frame(width: 256, height: 256)
            
            Button {
                
            } label: {
                Text("Connect")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .overlay(alignment: .topTrailing) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.circle)
            .controlSize(.small)
        }
    }
}


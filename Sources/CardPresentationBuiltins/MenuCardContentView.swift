import SwiftUI

public struct MenuCardContentView<Content: View>: View {
    @Environment(\.dismiss)
    var dismiss
    
    @ViewBuilder
    let title: () -> Text
    
    @ViewBuilder
    let content: () -> Content
    
    public init(
        @ViewBuilder title: @escaping () -> Text,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.content = content
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            HStack {
                title()
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: {
                    dismiss()
                }, label: {
                    CancelView()
                })
            }.font(.title2)
            
            if #available(iOS 18.0, *) {
                Group(
                    subviews: content(),
                    transform: transform
                )
            } else {
                VariadicView.Tree(
                    subviews: content(),
                    transform: transform
                )
            }
        }
        .foregroundStyle(.primary)
    }
    
    @ViewBuilder
    func transform<T: RandomAccessCollection>(_ subviews: T) -> some View where T.Element: View & Identifiable {
        HStack {
            ForEach(subviews.prefix(3)) { subview in
                subview
                    .labelStyle(.leaf)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        
        if subviews.count > 3 {
            ForEach(subviews.suffix(subviews.count - 3)) { subview in
                subview
                    .labelStyle(.row)
            }
        }
    }
}

struct CancelView: View {
    var body: some View {
        Image(systemName: "xmark.circle.fill")
            .bold()
            .font(.title2)
            .foregroundStyle(.secondary)
    }
}

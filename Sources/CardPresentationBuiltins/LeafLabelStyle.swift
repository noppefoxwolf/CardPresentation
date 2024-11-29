import SwiftUI

struct LeafLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 4) {
            configuration.icon
                .bold()
            configuration.title
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.background.secondary)
        .cornerRadius(10)
    }
}

extension LabelStyle where Self == LeafLabelStyle {
    static var leaf: LeafLabelStyle {
        LeafLabelStyle()
    }
}

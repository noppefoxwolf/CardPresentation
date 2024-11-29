import SwiftUI

struct RowLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
                .frame(maxWidth: .infinity, alignment: .leading)
            configuration.icon
        }
        .padding()
        .background(.background.secondary)
        .cornerRadius(10)
    }
}

extension LabelStyle where Self == RowLabelStyle {
    static var row: RowLabelStyle {
        RowLabelStyle()
    }
}

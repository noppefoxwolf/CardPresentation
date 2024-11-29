import SwiftUI

enum VariadicView {
    struct Tree<SubViews: View, Content: View>: View {
        let subviews: SubViews
        
        @ViewBuilder
        let transform: (_VariadicView_Children) -> Content
        
        var body: some View {
            _VariadicView.Tree(
                ViewRoot { subviews in
                    transform(subviews)
                },
                content: { subviews }
            )
        }
    }

    struct ViewRoot<Result: View>: _VariadicView_ViewRoot {
        
        @ViewBuilder
        let transform: (_VariadicView_Children) -> Result
        
        func body(children: _VariadicView.Children) -> Result {
            transform(children)
        }
    }
}

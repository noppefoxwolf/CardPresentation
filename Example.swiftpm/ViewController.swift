import UIKit
import SwiftUI
import CardPresentation
import CardPresentationBuiltins

final class ViewController: UIViewController {
    let label: UILabel = UILabel()
    let button: UIButton = UIButton(configuration: .filled())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        label.text = "Hello, World!"
        button.configuration?.title = "Button"
        
        let stackView = UIStackView(
            arrangedSubviews: [
                label,
                button
            ]
        )
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            view.trailingAnchor.constraint(
                equalTo: stackView.safeAreaLayoutGuide.trailingAnchor
            ),
        ])
        
        button.addAction(UIAction { [unowned self] _ in
            presentCard()
        }, for: .primaryActionTriggered)
    }
    
    func presentCard() {
        let vc = CardHostingController(rootView: CardContentView())
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
    }
}

struct CardContentView: View {
    @Environment(\.dismiss)
    var dismiss
    
    var body: some View {
        MenuCardContentView(
            title: {
                Text("Choose a Person")
            },
            content: {
                Button(action: {
                    dismiss()
                }) {
                    Label("apple1", systemImage: "apple.logo")
                }
                Button(action: {
                    dismiss()
                }) {
                    Label("apple2", systemImage: "apple.logo")
                }
                Button(action: {
                    dismiss()
                }) {
                    Label("apple3", systemImage: "apple.logo")
                }
                Button(action: {
                    dismiss()
                }) {
                    Label("apple4", systemImage: "apple.logo")
                }
            }
        )
    }
}

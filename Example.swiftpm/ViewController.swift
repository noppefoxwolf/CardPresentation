import UIKit
import SwiftUI
import CardPresentation

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
            stackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
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
        present(vc, animated: true)
    }
}

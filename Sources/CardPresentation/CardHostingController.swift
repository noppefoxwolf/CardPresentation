import UIKit
import SwiftUI

public final class CardHostingController<Content: View>: UIViewController {
    let contentViewController: UIHostingController<CardContentView<Content>>
    
    public init(rootView: Content) {
        let rootView = CardContentView(content: rootView)
        let viewController = UIHostingController(rootView: rootView)
        viewController.sizingOptions = [.preferredContentSize, .intrinsicContentSize]
        viewController.view.backgroundColor = .clear
        self.contentViewController = viewController
        super.init(nibName: nil, bundle: nil)
        let detent = UISheetPresentationController.Detent.custom(resolver: { [unowned self] context in
            contentViewController.preferredContentSize.height
        })
        sheetPresentationController?.detents = [detent]
        sheetPresentationController?.preferredCornerRadius = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        view.backgroundColor = .clear
        
        contentViewController.willMove(toParent: self)
        
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentViewController.view)
        
        NSLayoutConstraint.activate([
            contentViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentViewController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            contentViewController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        
        addChild(contentViewController)
        contentViewController.didMove(toParent: self)
        
    }
    
    public override func preferredContentSizeDidChange(forChildContentContainer container: any UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        sheetPresentationController?.invalidateDetents()
    }
}


import UIKit
import SwiftUI

public final class CardHostingController<Content: View>: UIViewController {
    let contentViewController: UIHostingController<CardContentView<Content>>
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    
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
        
        topConstraint = contentViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        bottomConstraint = contentViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([
            contentViewController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            contentViewController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        
        addChild(contentViewController)
        contentViewController.didMove(toParent: self)
    }
    
    public override func updateViewConstraints() {
        super.updateViewConstraints()
        switch traitCollection.verticalSizeClass {
        case .compact:
            topConstraint?.isActive = false
            bottomConstraint?.isActive = true
        case .regular:
            fallthrough
        default:
            topConstraint?.isActive = true
            bottomConstraint?.isActive = false
        }
    }
    
    // iOS 17
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.verticalSizeClass != traitCollection.verticalSizeClass {
            updateViewConstraints()
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        // Dismiss when tap outside
        for touch in touches {
            let hitView = view.hitTest(touch.location(in: view), with: event)
            if hitView == view {
                dismiss(animated: true)
            }
        }
    }
    
    public override func preferredContentSizeDidChange(forChildContentContainer container: any UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        sheetPresentationController?.invalidateDetents()
    }
}


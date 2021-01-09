import UIKit

extension UIView {
    func pinTopToSafeArea(to: UIView) {
        topAnchor.constraint(equalTo: to.safeAreaLayoutGuide.topAnchor).isActive = true
    }

    func pinBottomToSafeArea(to: UIView) {
        bottomAnchor.constraint(equalTo: to.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func pinLeadingToSafeArea(to: UIView) {
        leadingAnchor.constraint(equalTo: to.safeAreaLayoutGuide.leadingAnchor).isActive = true
    }

    func pinTrailingToSafeArea(to: UIView) {
        trailingAnchor.constraint(equalTo: to.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    func pinToSafeArea(to: UIView) {
        pinTopToSafeArea(to: to)
        pinBottomToSafeArea(to: to)
        pinLeadingToSafeArea(to: to)
        pinTrailingToSafeArea(to: to)
    }
}

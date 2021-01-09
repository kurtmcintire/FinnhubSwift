import Combine
import UIKit

class SymbolDetailsViewController: UIViewController {
    var viewModel: SymbolDetailViewModel!
    var loadingSubscriber: AnyCancellable?
    var dataSubscriber: AnyCancellable?
    var priceSubscriber: AnyCancellable?

    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout).bold()
        return label
    }()

    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2).bold()
        return label
    }()

    var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        return label
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            nameLabel,
            priceLabel,
        ])
        let padding: CGFloat = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.axis = .vertical
        stackView.spacing = padding / 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var indicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        return activity
    }()

    init(symbol: String) {
        viewModel = SymbolDetailViewModel(symbol: symbol)
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        configureStatic()
        fetchData()
        bindData()
    }

    func configureBackground() {
        view.backgroundColor = .systemBackground
    }

    func configureStatic() {
        view.addSubview(indicator)
        indicator.pinToSafeArea(to: view)

        view.addSubview(stackView)
        stackView.pinTopToSafeArea(to: view)
        stackView.pinLeadingToSafeArea(to: view)
        stackView.pinTrailingToSafeArea(to: view)
    }

    func configureDynamic() {
        titleLabel.text = viewModel.title
        nameLabel.text = viewModel.name
    }

    func updatePrice() {
        priceLabel.text = viewModel.priceString
    }

    func fetchData() {
        viewModel?.fetchSymbol()
        viewModel?.streamPrice()
    }

    func bindData() {
        priceSubscriber = viewModel.$price.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.updatePrice()
            }
        }

        dataSubscriber = viewModel.$stats.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.configureDynamic()
            }
        }

        loadingSubscriber = viewModel.$loading.sink(receiveValue: { [weak self] loading in
            DispatchQueue.main.async {
                loading ? self?.indicator.startAnimating() : self?.indicator.stopAnimating()
            }
        })
    }
}

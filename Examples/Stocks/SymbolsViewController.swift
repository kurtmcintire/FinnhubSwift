import Combine
import FinnhubSwift
import UIKit

class SymbolsViewController: UIViewController {
    let symbolsViewModel = SymbolsViewModel()
    var loadingSubscriber: AnyCancellable?
    var symbolsSubscriber: AnyCancellable?

    lazy var searchBar: UISearchBar = {
        let search = UISearchBar(frame: .zero)
        search.translatesAutoresizingMaskIntoConstraints = false
        search.delegate = self
        return search
    }()

    let refreshControl = UIRefreshControl(frame: .zero)

    lazy var mainCollectionView: SymbolsCollectionView = {
        let collectionView = SymbolsCollectionView(frame: view.bounds)
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        return collectionView
    }()

    var dataSource: SymbolsDataSource!
    var nameFilter: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavItem()
        configureBackground()
        configureHierarchy()
        configureDataSource()
        bindData()
    }

    func configureNavItem() {
        navigationItem.title = "Stocks"
    }

    func configureBackground() {
        view.backgroundColor = .systemBackground
    }

    func configureDataSource() {
        dataSource = SymbolsDataSource(ownedCollectionView: mainCollectionView)
    }

    func configureHierarchy() {
        view.addSubview(mainCollectionView)
        view.addSubview(searchBar)

        searchBar.pinTopToSafeArea(to: view)
        searchBar.pinLeadingToSafeArea(to: view)
        searchBar.pinTrailingToSafeArea(to: view)

        mainCollectionView.pinBottomToSafeArea(to: view)
        mainCollectionView.pinLeadingToSafeArea(to: view)
        mainCollectionView.pinTrailingToSafeArea(to: view)

        NSLayoutConstraint(item: searchBar, attribute: .bottom, relatedBy: .equal, toItem: mainCollectionView, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
    }

    func bindData() {
        symbolsSubscriber = symbolsViewModel.$symbols.sink { [weak self] newSymbols in
            DispatchQueue.main.async {
                self?.dataSource.update(newSymbols)
            }
        }

        loadingSubscriber = symbolsViewModel.$loading.sink(receiveValue: { [weak self] loading in
            DispatchQueue.main.async {
                loading ? self?.refreshControl.beginRefreshing() : self?.refreshControl.endRefreshing()
            }
        })
    }

    @objc private func refreshData(_: Any) {
        if let text = searchBar.text {
            symbolsViewModel.fetchSymbols(searchQuery: text)
        }
    }
}

extension SymbolsViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        symbolsViewModel.fetchSymbols(searchQuery: searchText)
    }
}

import Combine
import UIKit

class SymbolsViewController: UIViewController {
    let symbolsViewModel = SymbolsViewModel()
    var loadingSubscriber: AnyCancellable?
    var symbolsSubscriber: AnyCancellable?

    let searchBar = UISearchBar(frame: .zero)
    let refreshControl = UIRefreshControl(frame: .zero)

    var mainCollectionView: SymbolsCollectionView!
    var dataSource: SymbolsDataSource!
    var nameFilter: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavItem()
        configureBackground()
        configureHierarchy()
        configureDataSource()
        loadData()
        bindData()
    }

    func configureNavItem() {
        navigationItem.title = "Stocks"
        navigationItem.largeTitleDisplayMode = .always
    }

    func configureBackground() {
        view.backgroundColor = .white
    }

    func configureDataSource() {
        dataSource = SymbolsDataSource(ownedCollectionView: mainCollectionView)
    }

    func configureHierarchy() {
        view.backgroundColor = .systemBackground
        mainCollectionView = SymbolsCollectionView(frame: view.bounds)

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self

        mainCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)

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

    func loadData() {
        symbolsViewModel.fetchSymbols()
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
        loadData()
    }
}

extension SymbolsViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        let filteredSymbols = symbolsViewModel.filteredSymbols(with: searchText)
        dataSource.update(filteredSymbols)
    }
}

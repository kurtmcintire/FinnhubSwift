import Combine
import FinnhubSwift
import UIKit

class SymbolsViewController: UIViewController {
    let viewModel = SymbolsViewModel()
    var loadingSubscriber: AnyCancellable?
    var symbolsSubscriber: AnyCancellable?
    var dataSource: SymbolsDataSource!

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
        collectionView.delegate = self
        return collectionView
    }()

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

        NSLayoutConstraint.activate([
            searchBar.bottomAnchor.constraint(equalTo: mainCollectionView.topAnchor, constant: 0),
        ])

        mainCollectionView.pinBottomToSafeArea(to: view)
        mainCollectionView.pinLeadingToSafeArea(to: view)
        mainCollectionView.pinTrailingToSafeArea(to: view)
    }

    func bindData() {
        symbolsSubscriber = viewModel.$symbols.sink { [weak self] newSymbols in
            DispatchQueue.main.async {
                self?.dataSource.update(newSymbols)
            }
        }

        loadingSubscriber = viewModel.$loading.sink(receiveValue: { [weak self] loading in
            DispatchQueue.main.async {
                loading ? self?.refreshControl.beginRefreshing() : self?.refreshControl.endRefreshing()
            }
        })
    }

    @objc private func refreshData(_: Any) {
        if let text = searchBar.text {
            viewModel.fetchSymbols(searchQuery: text)
        }
    }
}

extension SymbolsViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchSymbols(searchQuery: searchText)
    }
}

extension SymbolsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let symbol = viewModel.symbol(at: indexPath.row)
        let detailViewController = SymbolDetailsViewController(symbol: symbol)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

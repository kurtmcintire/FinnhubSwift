import Combine
import FinnhubSwift
import UIKit

class SymbolsViewController: UIViewController {
    enum Section: CaseIterable {
        case main
    }

    let symbolsController = CompanySymbolsController()
    var loadingSubscriber: AnyCancellable?
    var symbolsSubscriber: AnyCancellable?

    let searchBar = UISearchBar(frame: .zero)
    let refreshControl = UIRefreshControl(frame: .zero)

    var mainCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, CompanySymbol>!
    var nameFilter: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavItem()
        configureBackground()
        configureHierarchy()
        configureDataSource()
        loadData()
    }

    func configureNavItem() {
        navigationItem.title = "Stocks, NASDAQ & NYSE"
        navigationItem.largeTitleDisplayMode = .always
    }

    func configureBackground() {
        view.backgroundColor = .white
    }

    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration
        <UICollectionViewListCell, CompanySymbol> { cell, _, symbol in
            var contentConfiguration = UIListContentConfiguration.cell()
            contentConfiguration.text = symbol.description
            contentConfiguration.secondaryText = symbol.symbol
            cell.contentConfiguration = contentConfiguration

            cell.accessories = [.disclosureIndicator()]
        }

        dataSource = UICollectionViewDiffableDataSource<Section, CompanySymbol>(collectionView: mainCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: CompanySymbol) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }

    func performQuery(with filter: String?) {
        let filteredSymbols = symbolsController.filteredSymbols(with: filter).sorted { $0.displaySymbol < $1.displaySymbol }

        var snapshot = NSDiffableDataSourceSnapshot<Section, CompanySymbol>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredSymbols)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }

    func configureHierarchy() {
        view.backgroundColor = .systemBackground
        
        let layout = createLayout()
        mainCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        mainCollectionView.backgroundColor = .systemGroupedBackground
        mainCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)

        searchBar.delegate = self

        view.addSubview(mainCollectionView)
        view.addSubview(searchBar)
    
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        searchBar.pinTopToSafeArea(to: view)
        searchBar.pinLeadingToSafeArea(to: view)
        searchBar.pinTrailingToSafeArea(to: view)

        mainCollectionView.pinBottomToSafeArea(to: view)
        mainCollectionView.pinLeadingToSafeArea(to: view)
        mainCollectionView.pinTrailingToSafeArea(to: view)

        NSLayoutConstraint(item: searchBar, attribute: .bottom, relatedBy: .equal, toItem: mainCollectionView, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
    }

    func loadData() {
        symbolsController.fetchSymbols()
        symbolsSubscriber = symbolsController.$symbols.sink { [weak self] newSymbols in
            DispatchQueue.main.async {
                self?.updateDataSource(newSymbols)
            }
        }

        loadingSubscriber = symbolsController.$loading.sink(receiveValue: { [weak self] loading in
            if loading == false {
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
            }
        })
    }

    func updateDataSource(_ newSymbols: [CompanySymbol]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CompanySymbol>()
        snapshot.appendSections([.main])
        snapshot.appendItems(newSymbols)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    @objc private func refreshData(_: Any) {
        loadData()
    }
}

extension SymbolsViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
}

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
        configureHierarchy()
        configureDataSource()
        loadData()
    }

    func configureNavItem() {
        navigationItem.title = "Stocks, NASDAQ & NYSE"
        navigationItem.largeTitleDisplayMode = .always
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
        updateDataSource(filteredSymbols)
    }

    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }

    func configureHierarchy() {
        view.backgroundColor = .systemBackground
        let layout = createLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.addSubview(collectionView)
        view.addSubview(searchBar)

        let views = ["cv": collectionView, "searchBar": searchBar]
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[cv]|", options: [], metrics: nil, views: views
        ))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[searchBar]|", options: [], metrics: nil, views: views
        ))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "V:[searchBar]-20-[cv]|", options: [], metrics: nil, views: views
        ))
        constraints.append(searchBar.topAnchor.constraint(
            equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0
        ))
        NSLayoutConstraint.activate(constraints)
        mainCollectionView = collectionView

        searchBar.delegate = self
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

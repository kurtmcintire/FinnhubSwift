import FinnhubSwift
import Foundation

struct SymbolViewModel: Hashable, Equatable {
    private let symbol: CompanySymbol

    var text: String { return symbol.description }
    var secondaryText: String { return symbol.symbol }

    init(symbol: CompanySymbol) {
        self.symbol = symbol
    }
}

class SymbolsViewModel: ObservableObject {
    private var companySymbols: [CompanySymbol] = []
    private var pendingRequestWorkItem: DispatchWorkItem?
    @Published var symbols: [SymbolViewModel] = []
    @Published var loading: Bool = false

    func fetchSymbols(searchQuery: String) {
        pendingRequestWorkItem?.cancel()
        if searchQuery.isEmpty {
            loading = false
            symbols = []
            return
        }

        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem { [weak self] in
            self?.loading = true

            FinnhubClient.symbol(query: searchQuery) { [weak self] result in
                self?.loading = false
                switch result {
                case let .success(data):
                    self?.companySymbols = data.result
                    self?.symbols = data.result.map { companySymbol -> SymbolViewModel in
                        SymbolViewModel(symbol: companySymbol)
                    }
                case .failure(.invalidData):
                    self?.companySymbols = []
                    self?.symbols = []
                case .failure(.networkFailure(_)):
                    self?.companySymbols = []
                    self?.symbols = []
                }
            }
        }

        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(200), execute: requestWorkItem)
    }

    func symbol(at index: Int) -> String {
        companySymbols[index].displaySymbol
    }
}

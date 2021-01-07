import FinnhubSwift
import Foundation

struct SymbolViewModel: Hashable, Equatable {
    private let symbol: CompanySymbol

    var text: String { return symbol.description }
    var secondaryText: String { return symbol.symbol }

    init(symbol: CompanySymbol) {
        self.symbol = symbol
    }

    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else { return true }
        if filterText.isEmpty { return true }
        let lowercasedFilter = filterText.lowercased()
        return text.lowercased().contains(lowercasedFilter) || secondaryText.lowercased().contains(lowercasedFilter)
    }
}

class SymbolsViewModel: ObservableObject {
    @Published var symbols: [SymbolViewModel] = []
    @Published var loading: Bool = false

    func filteredSymbols(with filter: String? = nil, limit: Int? = nil) -> [SymbolViewModel] {
        let filtered = symbols.filter { $0.contains(filter) }
        if let limit = limit {
            return Array(filtered.prefix(through: limit))
        } else {
            return filtered
        }
    }

    func fetchSymbols(searchQuery: String) {
        loading = true

        FinnhubClient.symbol(query: searchQuery) { [weak self] result in
            self?.loading = false
            switch result {
            case let .success(data):
                self?.symbols = data.result.map { (companySymbol) -> SymbolViewModel in
                    SymbolViewModel(symbol: companySymbol)
                }
            case .failure(.invalidData):
                self?.symbols = []
            case .failure(.networkFailure(_)):
                self?.symbols = []
            }
        }
    }
}

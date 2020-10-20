import Foundation

enum HttpMethod<Body> {
    case get
    case post(Body)
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

public enum Result<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
}

struct Resource<A> {
    var urlRequest: URLRequest
    let parse: (Data) -> A?
}

extension Resource {
    func map<B>(_ transform: @escaping (A) -> B) -> Resource<B> {
        return Resource<B>(urlRequest: urlRequest) { self.parse($0).map(transform) }
    }
}

extension Resource where A: Decodable {
    init(get url: URL, headers: (String, String)) {
        urlRequest = URLRequest(url: url)
        urlRequest.setValue(headers.0, forHTTPHeaderField: headers.1)
        parse = { data in
            try? JSONDecoder().decode(A.self, from: data)
        }
    }

    init<Body: Encodable>(url: URL, method: HttpMethod<Body>) {
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.method
        switch method {
        case .get: ()
        case let .post(body):
            urlRequest.httpBody = try! JSONEncoder().encode(body)
        }
        parse = { data in
            try? JSONDecoder().decode(A.self, from: data)
        }
    }
}

extension URLSession {
    func load<A>(_ resource: Resource<A>, completion: @escaping (Result<A?, Error>) -> Void) {
        dataTask(with: resource.urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(data.flatMap(resource.parse)))
            }
        }.resume()
    }
}

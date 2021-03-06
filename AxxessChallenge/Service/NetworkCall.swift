//
//  NetworkResource.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/27/21.
//

import Alamofire

class NetworkCall {
    /**
     Deserializes the API endpoint response to the model object, T
     
     - returns:
        Result state (success, error)
     - parameters:
        - response: AFDataResponse returned from Alamofire responseData API
     */
    private func decodeResponse<T>(_ response: AFDataResponse<Data>) -> Result<T?, Error> where T: Decodable {
        switch response.result {
        case .success(let data):
            guard let statusCode = response.response?.statusCode else {
                return .failure(NSError(domain: "empty server response", code: 0)) }
            switch statusCode {
            case 200...299, 304:
                do {
                    return .success(try JSONDecoder().decode(T.self, from: data))
                } catch (let error) {
                    return .failure(error)
                }
            default:
                return .failure(NSError(domain: response.description, code: statusCode))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    /**
     Executes request query from service layer and returns a response.
     
     - parameters:
        - method: HTTPMethod (GET, PUT, POST, DEL)
        - url: the request url string
        - parameters: The body parameters for a HTTP request
        - completion: calls the handler with argument, Result
     
     */
    func execute<T>(method: HTTPMethod, url: String, parameters: [String: Any]? = nil,
                completion: @escaping (Result<T?, Error>?) -> Void) where T: Decodable {
        if !NetworkUtil.isConnectedToInternet {
            completion(.failure(NetworkError.notReachable))
            return
        }
        AF.request(url, method: method, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    return completion(.failure(NSError(domain: "empty server response", code: 0))) }
                switch statusCode {
                case 200...299, 304:
                    do {
                        return completion(.success(try JSONDecoder().decode(T.self, from: data)))
                    } catch (let error) {
                        return completion(.failure(error))
                    }
                default:
                    return completion(.failure(NSError(domain: response.description, code: statusCode)))
                }
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}

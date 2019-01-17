//
//  APIClient.swift
//  RegresRx
//
//  Created by Gustavo Henrique on 04/01/19.
//  Copyright © 2019 Gustavo Henrique. All rights reserved.
//

import UIKit

enum APIError : Error {
    
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case unauthorized
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .unauthorized: return "Unauthorized"
        }
    }
}

protocol APIClient {
    
    var session : URLSession { get }
    func fetch<T:Decodable>(with request: URLRequest, decode: @escaping(Decodable) -> T? , completionHandler: @escaping(Result<T, APIError>) -> Void)
}

extension APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    typealias JSONEmptyCompletionHandler = (APIError?) -> Void
    
    /* Task utilizada para converter o JSON utilizando o protocolo Decodable Nativo do Swift */
    
    public func decodingTask<T:Decodable>(with request: URLRequest, decodingType : T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler ) -> URLSessionDataTask {
        
        print("URL HEADERS -> \(String(describing: request.allHTTPHeaderFields))")
        print("URL REQUEST -> \(String(describing: request.url))")
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
        
            if httpResponse.statusCode == 200 {
                if let data = data {
                    
                    do{
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(genericModel,nil)
                    
                    } catch {
                        completion(nil, .jsonParsingFailure)
                    }
                    
                } else {
                    completion(nil, .invalidData)
                }
                
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    public func taskWithoutDecode(with request: URLRequest, completionHandler completion: @escaping JSONEmptyCompletionHandler ) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(nil)
            } else if httpResponse.statusCode == 401 {
                completion(.unauthorized)
            } else {
                completion(.responseUnsuccessful)
            }
        }
        
        return task
    }
    
    
    public func fetch<T:Decodable>(with request: URLRequest, decode: @escaping(Decodable) -> T?, completionHandler: @escaping(Result<T, APIError>) -> Void) {
        
        let task = decodingTask(with: request, decodingType: T.self) { json, error in
            
            DispatchQueue.main.async {
                
                guard let json = json else {
                    if let error = error {
                        completionHandler(Result.failed(error))
                    } else {
                        completionHandler(Result.failed(.invalidData))
                    }
                    return
                }
                
                if let data = decode(json) {
                    completionHandler(Result.sucess(data))
                } else {
                    completionHandler(Result.failed(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
    
    
    
    
}

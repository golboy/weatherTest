//
//  FileUrl.swift
//  AppTest
//
//  Created by Golboy on 11/1/2566 BE.
//

import Foundation

extension URLSession {
    func fetchData<T: Decodable>(for url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
    
    func fetchData<T: Decodable>(for url: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
    
    func synchronousDataTask(urlrequest: URLRequest) -> (Data?, URLResponse?, Error?) {
      var data: Data?
      var response: URLResponse?
      var error: Error?
      
      let semaphore = DispatchSemaphore(value: 0)
      
      let dataTask = self.dataTask(with: urlrequest) {
        data = $0
        response = $1
        error = $2
        
        semaphore.signal()
      }
      dataTask.resume()
      
      _ = semaphore.wait(timeout: .distantFuture)
      
      return (data, response, error)
    }
}



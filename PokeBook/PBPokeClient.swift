//
//  PokeClient.swift
//  PokeBook
//
//  Created by user on 7/19/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation
import SystemConfiguration

enum RequestMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

final class PBPokeClient {
  private var baseUrl: String
  
  init(baseUrl: String) {
    self.baseUrl = baseUrl
  }
  
  func load(path: String, method: RequestMethod, params: JSON, completion: @escaping (Any?, Error?) -> Void ) -> URLSessionDataTask? {
    if !Reachability.isConnectedToNetwork() {
      completion(nil, PBServiceError.noInternetConnection)
      return nil
    }
  
    let parameters = params
    /* Add token if it exists
    if let token = Preferences.getToken() {
      parameters["token"] = token
    }
    */
    let request = URLRequest(baseUrl: baseUrl, path: path, params: parameters, method: method)
    return perform(request: request, completion: completion)
  }
}

private extension PBPokeClient {
  
  func perform(request: URLRequest, completion: @escaping (Any?, Error?) -> Void ) -> URLSessionDataTask {
    let _completion: (Any?, Error?) -> Void = { result, error in
      DispatchQueue.main.async { completion(result, error) }
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      var object: Any? = nil
      if let data = data {
        object = try? JSONSerialization.jsonObject(with: data, options: [])
      }
      
      if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
        _completion(object, nil)
      } else if let error = error {
        _completion(nil, error)
      } else {
        let error = PBServiceError(object as? JSON)
        _completion(nil, error)
      }
    }
    task.resume()
    return task
  }
}

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
  
  func load(path: String, method: RequestMethod, params: JSON, completion: @escaping (Any?, PBServiceError?) -> Void ) -> URLSessionDataTask? {
    if !Reachability.isConnectedToNetwork() {
      completion(nil, .noInternetConnection)
      return nil
    }
  
    let parameters = params
    /* Add token if it exists
    if let token = Preferences.getToken() {
      parameters["token"] = token
    }
    */
    
    let request = URLRequest(baseUrl: baseUrl, path: path, params: parameters, method: method)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      var object: Any? = nil
      if let data = data {
        object = try? JSONSerialization.jsonObject(with: data, options: [])
      }
      
      if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
        completion(object, nil)
      } else {
        let error = PBServiceError(object as? JSON)
        completion(nil, error)
      }
    }
    task.resume()
    return task
  }
}

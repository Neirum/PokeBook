//
//  URL+Extension.swift
//  PokeBook
//
//  Created by user on 7/19/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation

extension URL {
  
  init(baseUrl: String, path: String, params:JSON, method: RequestMethod) {
    var componentsUrl = URLComponents.init(string: baseUrl)!
    componentsUrl.path += path
    
    switch method {
      case .get, .delete:
        componentsUrl.queryItems = params.map {
          URLQueryItem(name: $0.key, value: String(describing: $0.value))
        }
      default:
        break
    }
    self = componentsUrl.url!
  }
  
}

extension URLRequest {
  
  init(baseUrl: String, path: String, params: JSON, method: RequestMethod) {
    let url = URL(baseUrl: baseUrl, path: path, params: params, method: method)
    self.init(url: url)
    
    httpMethod = method.rawValue
    setValue("application/json", forHTTPHeaderField: "Accept")
    setValue("application/json", forHTTPHeaderField: "Content-Type")
    if let token = params["token"] as? String {
      setValue(token, forHTTPHeaderField: "X-Access-Token")
    }
    
    switch method {
      case .post, .put:
        httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
      default:
        break
    }
  }
  
  
}

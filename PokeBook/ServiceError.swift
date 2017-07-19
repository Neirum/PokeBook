//
//  ServiceError.swift
//  PokeBook
//
//  Created by user on 7/19/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation


typealias JSON = [String: Any]

enum PBServiceError: Error {
  
  case noInternetConnection
  case custom(String)
  case other
  
}

extension PBServiceError: LocalizedError {
  
  var errorDescription: String? {
    switch self {
      case .noInternetConnection:
        return "No internet connection"
      case .other:
        return "Something went wrong"
      case .custom(let message):
        return message
    }
  }
  
}

extension PBServiceError {
  
  init(_ json: JSON?) {
    if let msg = json?["message"] as? String {
      self = .custom(msg)
    } else {
      self = .other
    }
  }
  
}

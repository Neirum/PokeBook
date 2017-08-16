//
//  PBCacheError.swift
//  PokeBook
//
//  Created by user on 8/16/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation

enum PBCacheError: Error {
  
  case noData
  case notEnoughData([Pokemon])
  case custom(String)
  case other
  
}

extension PBCacheError: LocalizedError {
  
  var errorDescription: String? {
    switch self {
      case .noData:
        return "No stored data"
      case .notEnoughData:
        return "Not enough data to fetch"
      case .custom(let message):
        return message
      case .other:
        return "Unresolved error"
    }
  }
  
}

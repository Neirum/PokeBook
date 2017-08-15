//
//  CoreDataController.swift
//  PokeBook
//
//  Created by user on 8/3/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation
import CoreData

class CoreDataController: NSObject {
  
  static public let shared = CoreDataController()
  private override init() {
    super.init()
  }
  
  struct DataModels {
    static let pokebookModel: String = "PokeBook"
  }
  
  let persistantContainer: NSPersistentContainer = {
    let persistantContainer = NSPersistentContainer(name: DataModels.pokebookModel)
    persistantContainer.loadPersistentStores() { (description, error) in
      if let error = error {
        fatalError("Failed to load Core Data stack: \(error)")
      }
    }
    return persistantContainer
  }()
  
  var context: NSManagedObjectContext {
    return persistantContainer.viewContext
  }
  
  func commit() throws {
    if persistantContainer.viewContext.hasChanges {
      try context.save()
    }
  }
  
  func delete(_ object: NSManagedObject) {
    context.delete(object)
  }
  
  func insert(_ object: NSManagedObject) {
    context.insert(object)
  }
  
}

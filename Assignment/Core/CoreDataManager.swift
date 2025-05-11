//
//  CoreDataManager.swift
//  Assignment
//
//  Created by Abhay Chaurasia on 11/05/25.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchProducts() -> [Products] {
        
      //  let request: NSFetchRequest<Products> = Products.fetchRequest()

        let request: NSFetchRequest<Products> = Products.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }

    func deleteAllProducts() {
        let products = fetchProducts()
        products.forEach { context.delete($0) }
        save()
    }

    func save() {
        do {
            try context.save()
        } catch {
            print("❌ Core Data Save Error:", error)
        }
    }
    
    func delete(_ product: Products) {
        context.delete(product)
        save()
    }
}

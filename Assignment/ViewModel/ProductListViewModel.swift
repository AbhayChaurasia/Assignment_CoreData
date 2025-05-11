//
//  Untitled.swift
//  Assignment
//
//  Created by Abhay Chaurasia on 12/05/25.
//

import Foundation

class ProductListViewModel {

    var products: [Products] = []
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func loadData() {
        let saved = CoreDataManager.shared.fetchProducts()
        if saved.isEmpty {
            fetchFromAPI()
        } else {
            self.products = saved
            onDataUpdated?()
        }
    }

    func fetchFromAPI(attempts: Int = 0) {
        let maxRetries = 3
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        guard let url = URL(string: Endpoint.baseURL) else { return }

        session.dataTask(with: url) { data, _, error in
            if let urlError = error as? URLError {
                if urlError.code == .networkConnectionLost && attempts < maxRetries {
                    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                        self.fetchFromAPI(attempts: attempts + 1)
                    }
                    return
                } else {
                    self.onError?("❌ Network error: \(urlError.localizedDescription)")
                    return
                }
            }
            if let error = error {
                self.onError?("❌ API error: \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode([ProductResponse].self, from: data)
                CoreDataManager.shared.deleteAllProducts()
                decoded.forEach { self.saveToCoreData($0) }
                self.products = CoreDataManager.shared.fetchProducts()
                self.onDataUpdated?()
            } catch {
                self.onError?("❌ Decode error: \(error.localizedDescription)")
            }
        }.resume()
    }

    private func saveToCoreData(_ response: ProductResponse) {
        let product = Products(context: CoreDataManager.shared.context)
        product.id = response.id
        product.name = response.name

        if let d = response.data {
            product.color = d.color
            product.capacity = d.capacity ?? (d.capacityGB != nil ? "\(d.capacityGB!) GB" : nil)
            product.price = d.price ?? 0
            product.generation = d.generation
            product.year = Int16(d.year ?? 0)
            product.cpuModel = d.cpuModel
            product.hardDiskSize = d.hardDiskSize
            product.strapColour = d.strapColour
            product.caseSize = d.caseSize
            product.screenSize = d.screenSize ?? 0
            product.descriptionText = d.description
        }
        CoreDataManager.shared.save()
    }

    func deleteProduct(at index: Int) {
        let product = products[index]
        CoreDataManager.shared.delete(product)
        products.remove(at: index)
        onDataUpdated?()
    }
}

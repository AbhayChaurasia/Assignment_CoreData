//
//  CoreDataModel.swift
//  Assignment
//
//  Created by Prince on 02/05/25.
//

import Foundation

// MARK: - CoreDataModelElement
struct CoreDataModelElement: Codable {
    let id, name: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let dataColor, dataCapacity: String?
    let capacityGB: Int?
    let dataPrice: Double?
    let dataGeneration: String?
    let year: Int?
    let cpuModel, hardDiskSize, strapColour, caseSize: String?
    let color, description, capacity: String?
    let screenSize: Double?
    let generation, price: String?

    enum CodingKeys: String, CodingKey {
        case dataColor = "color"
        case dataCapacity = "capacity"
        case capacityGB = "capacity GB"
        case dataPrice = "price"
        case dataGeneration = "generation"
        case year
        case cpuModel = "CPU model"
        case hardDiskSize = "Hard disk size"
        case strapColour = "Strap Colour"
        case caseSize = "Case Size"
        case color = "Color"
        case description = "Description"
        case capacity = "Capacity"
        case screenSize = "Screen size"
        case generation = "Generation"
        case price = "Price"
    }
}

typealias CoreDataModel = [CoreDataModelElement]


struct ProductJSON: Codable {
    let id: String?
    let name: String?
    let data: ProductDetails?
}


struct ProductModel: Codable {
    let id: String?
    let name: String?
    let data: ProductData?
}

struct ProductData: Codable {
    let color: String?
    let capacity: String?
    let price: Double?
    let generation: String?
    let year: Int?
    let cpuModel: String?
    let hardDiskSize: String?
    let strapColour: String?
    let caseSize: String?
    let description: String?
    let screenSize: Double?
}

//
//  products.swift
//  Assignment
//
//  Created by Abhay Chaurasia on 11/05/25.
//

struct ProductResponse: Codable {
    let id: String?
    let name: String?
    let data: ProductDetails?
}

struct ProductDetails: Codable {
    let color: String?
    let capacity: String?
    let capacityGB: Int?
    let price: Double?
    let generation: String?
    let year: Int?
    let cpuModel: String?
    let hardDiskSize: String?
    let strapColour: String?
    let caseSize: String?
    let screenSize: Double?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case color, capacity
        case capacityGB = "capacity GB"
        case price, generation, year
        case cpuModel = "CPU model"
        case hardDiskSize = "Hard disk size"
        case strapColour = "Strap Colour"
        case caseSize = "Case Size"
        case screenSize = "Screen size"
        case description = "Description"
    }
}





//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Giorgi on 8/22/24.
//
import Foundation

struct MenuResponse: Codable {
    let menu: [MenuItem]
}

struct MenuItem: Identifiable, Codable {
    var id: Int
    var title: String
    var description: String
    var price: String
    var image: String
    var category: String
}

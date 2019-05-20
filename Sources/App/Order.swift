//
//  Order.swift
//  App
//
//  Created by Vlad Eliseev on 21/05/2019.
//

import Foundation
import Vapor
import FluentSQLite

struct Order: Content, SQLiteModel, Migration {
    var id: Int?
    var products: [[String : Int]]
    var buyerName: String
    var total: Int
    var date: Date?
}

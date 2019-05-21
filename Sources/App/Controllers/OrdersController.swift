//
//  OrdersController.swift
//  App
//
//  Created by Vlad Eliseev on 21/05/2019.
//

import Vapor

class OrdersController: RouteCollection {
    
    func boot(router: Router) throws {
        let ordersRoutes = router.grouped("api", "orders")
        ordersRoutes.get(use: getAllHandler)
        ordersRoutes.post(Order.self, use: createHandler)
        ordersRoutes.post(Order.parameter, "delete", use: deleteOrderHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Order]> {
        return Order.query(on: req).all()
    }
    
    func createHandler(
        _ req: Request,
        order: Order
        ) throws -> Future<Order> {
        var orderCopy = order
        orderCopy.date = Date()
        return orderCopy.save(on: req)
    }
    
    func deleteOrderHandler(_ req: Request) throws
        -> Future<Response> {
            return try req.parameters.next(Order.self).delete(on: req)
                .transform(to: req.redirect(to: "/"))
    }
    
    struct IndexContext: Encodable {
        let title: String
        let orders: [Order]?
    }
    
    func indexHandler(_ req: Request) throws -> Future<View> {
        return Order.query(on: req)
            .all()
            .flatMap(to: View.self) { orders in
                let ordersData = orders.isEmpty ? nil : orders
                let context = IndexContext(
                    title: "Orders",
                    orders: ordersData)
                return try req.view().render("orders", context)
        }
    }
    
}

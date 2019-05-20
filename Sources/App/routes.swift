import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    router.get { req -> Future<View> in
        return try req.view().render("test")
    }
    
    router.get("test") { req -> Future<View> in
        return Order.query(on: req).all().flatMap(to: View.self) { orders in
            return try req.view().render("home", ["orders" : orders])
        }
    }
    
    router.get("getOrders") { req -> Future<[Order]> in
        return Order.query(on: req).all()
    }
    
    router.post(Order.self, at: "order") { (request, order) -> Future<Order> in
        print(order)
        var orderCopy = order
        orderCopy.date = Date()
        return orderCopy.save(on: request)
    }
}

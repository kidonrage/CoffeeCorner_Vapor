import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    router.get { req -> Future<View> in
        return try req.view().render("test")
    }
    
    let ordersController = OrdersController()
    try router.register(collection: ordersController)
}

import Foundation

// MARK: - An example of the recursive associated type in a protocol
protocol Screen {
    associatedtype ItemType: Item
    associatedtype ChildScreen: Screen where ChildScreen.ItemType == ItemType
    var items: [ItemType] { get set }
    var childScreens: [ChildScreen] { get set }
}

class MainScreen: Screen {
    typealias ItemType = Movie
    typealias ChildScreen = MainScreen
    
    var items = [Movie]()
    var childScreens = [MainScreen]()
}

class CategoryScreen: Screen {
    typealias ItemType = Movie
    typealias Childscreen = DetailScreen
    
    var items = [Movie]()
    var childScreens = [DetailScreen]()
}

class DetailScreen: Screen {
    typealias ItemType = Movie
    typealias Childscreen = DetailScreen
    
    var items = [Movie]()
    var childScreens = [DetailScreen]()
}

protocol Item {
    init(fileName: String)
}

struct Movie: Item {
    var fileName: String
}

struct Song: Item {
    var fileName: String
}



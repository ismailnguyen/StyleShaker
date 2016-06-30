import UIKit

class User: NSObject {
    
    // Singleton used on whole application
    static let sharedInstance = User()
    
    var products: [Product]?
    var criteria: Criteria?
    
    override init(){
        super.init()
        
        self.criteria = Criteria()
    }
    
    convenience init(criteria: Criteria?){
        self.init()
        
        self.criteria = criteria
    }
    
    func getCriteria() -> Criteria {
        return self.criteria!
    }
}

import UIKit

class Gender: NSObject {
    
    var female: Bool = false
    var male: Bool = true
    
    override init(){
        super.init()
    }
    
    convenience init(female: Bool?, male: Bool?){
        self.init()
        
        self.female = female!
        self.male = male!
    }
    
    func isFemale() -> Bool {
        return self.female
    }
    
    func isMale() -> Bool {
        return self.male
    }
}

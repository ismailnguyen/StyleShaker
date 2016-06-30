import UIKit

class Skin: NSObject {
    
    var dark: Bool = true
    var bright: Bool = false
    
    override init(){
        super.init()
    }
    
    convenience init(dark: Bool?, bright: Bool?){
        self.init()
        
        self.dark = dark!
        self.bright = bright!
    }
    
    func isDark() -> Bool {
        return self.dark
    }
    
    func isBright() -> Bool {
        return self.bright
    }
}

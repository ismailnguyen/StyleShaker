import UIKit

class Mood : NSObject {
    var party: Bool = true
    var weekend: Bool = true
    var chill: Bool = true
    var work: Bool = true
    
    override init(){
        super.init()
    }
    
    convenience init(party: Bool?, weekend: Bool?, chill: Bool?, work: Bool?){
        self.init()
        
        self.party = party!
        self.weekend = weekend!
        self.chill = chill!
        self.work = work!
    }
    
    func isParty() -> Bool {
        return self.party
    }
    
    func isWeekend() -> Bool {
        return self.weekend
    }
    
    func isChill() -> Bool {
        return self.chill
    }
    
    func isWork() -> Bool {
        return self.work
    }
}

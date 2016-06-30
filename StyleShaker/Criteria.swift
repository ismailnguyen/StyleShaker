import UIKit

class Criteria: NSObject {

    var mood: Mood?
    var gender: Gender?
    var hair: Hair?
    var skin: Skin?
    
    override init(){
        super.init()
        
        self.mood = Mood()
        self.gender = Gender()
        self.hair = Hair()
        self.skin = Skin()
    }
    
    convenience init(mood: Mood?, gender: Gender?, hair: Hair?, skin: Skin?) {
        self.init()
        
        self.mood = mood!
        self.gender = gender!
        self.hair = hair!
        self.skin = skin!
    }
    
    func updateMood(mood: Mood?) -> Void {
        self.mood = mood!
    }
    
    func updateHair(hair: Hair?) -> Void {
        self.hair = hair!
    }
    
    func updateSkin(skin: Skin?) -> Void {
        self.skin = skin!
    }
    
    func updateGender(gender: Gender?) -> Void {
        self.gender = gender!
    }
}

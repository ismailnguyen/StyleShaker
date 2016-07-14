import UIKit

class User: NSObject {
    
    // Singleton used on whole application
    static let sharedInstance = User()
    
    var products: [Product]?
    var criteria: Criteria?
    
    override init(){
        super.init()
        
        self.criteria = Criteria()
        self.products = [Product]()
        
        //save()
        recover()
    }
    
    convenience init(criteria: Criteria?){
        self.init()
        
        self.criteria = criteria
    }
    
    func getCriteria() -> Criteria {
        return self.criteria!
    }
    
    func save() -> Void {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setBool((self.criteria?.mood?.chill)!, forKey: "criteria_mood_chill")
        userDefaults.setBool((self.criteria?.mood?.party)!, forKey: "criteria_mood_party")
        userDefaults.setBool((self.criteria?.mood?.weekend)!, forKey: "criteria_mood_weekend")
        userDefaults.setBool((self.criteria?.mood?.work)!, forKey: "criteria_mood_work")
        
        userDefaults.setBool((self.criteria?.gender?.female)!, forKey: "criteria_gender_female")
        userDefaults.setBool((self.criteria?.gender?.male)!, forKey: "criteria_gender_male")
        
        userDefaults.setBool((self.criteria?.hair?.bright)!, forKey: "criteria_hair_bright")
        userDefaults.setBool((self.criteria?.hair?.dark)!, forKey: "criteria_hair_dark")
        
        userDefaults.setBool((self.criteria?.skin?.bright)!, forKey: "criteria_skin_bright")
        userDefaults.setBool((self.criteria?.skin?.dark)!, forKey: "criteria_skin_dark")
        userDefaults.synchronize()
    }
    
    func recover() -> Void {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        self.criteria!.mood?.chill = userDefaults.boolForKey("criteria_mood_chill")
        self.criteria!.mood?.party = userDefaults.boolForKey("criteria_mood_party")
        self.criteria!.mood?.weekend = userDefaults.boolForKey("criteria_mood_weekend")
        self.criteria!.mood?.work = userDefaults.boolForKey("criteria_mood_work")
        
        self.criteria!.gender?.female = userDefaults.boolForKey("criteria_gender_female")
        self.criteria!.gender?.male = userDefaults.boolForKey("criteria_gender_male")
        
        self.criteria!.hair?.bright = userDefaults.boolForKey("criteria_hair_bright")
        self.criteria!.hair?.dark = userDefaults.boolForKey("criteria_hair_dark")
        
        self.criteria!.skin?.bright = userDefaults.boolForKey("criteria_skin_bright")
        self.criteria!.skin?.dark = userDefaults.boolForKey("criteria_skin_dark")
    }
}

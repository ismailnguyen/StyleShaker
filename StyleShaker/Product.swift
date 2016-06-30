import UIKit

class Product: NSObject {
    
    var id: String?
    var title: String?
    var about: String?
    var picture: String?
    var pictureImage: UIImage?
    var tags: [String]?
    var criteria: Criteria?
    
    override init(){
        super.init()
    }
    
    convenience init(id: String?, title: String?, about: String?, picture: String?, tags: [String]?, criteria: Criteria?){
        self.init()
        
        self.id = id!
        self.title = title!
        self.about = about!
        self.picture = picture
        self.tags = tags
        self.criteria = criteria
    }
    
    func setImage(pictureImage: UIImage?) -> Void {
        self.pictureImage = pictureImage
    }
}

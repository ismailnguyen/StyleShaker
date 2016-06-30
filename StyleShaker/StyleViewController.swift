import UIKit

let STYLE_CELL_IDENTIFIER = "StyleCell"
let PRODUCT_DETAIL_SEGUE = "ProductDetailSegue"
let PRODUCTS_URL: String = "http://163.172.27.134/api/products"

class StyleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var products: [Product] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self

        loadProducts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        print("Shaky shaky")
        loadProducts()
    }
    
    private func filterProducts() -> Void {
        print("Shuuufle")
        self.products = self.products.shuffle()
        
        print("Remove last bad guys from index 10")
        if (self.products.count > 10) {
            self.products.removeRange(9..<self.products.count-1)
        }
    }
    
    // If user has hair preferences, check if product hair details matches with user's
    private func matchHair(hair: Hair) -> Bool {
        if (User.sharedInstance.criteria != nil) {
            if (User.sharedInstance.criteria?.hair?.bright == false
                && User.sharedInstance.criteria?.hair?.dark == false) {
                    return true
            }
            else if (User.sharedInstance.criteria?.hair?.bright == hair.bright
                && User.sharedInstance.criteria?.hair?.dark == hair.dark) {
                    return true
            }
            
            return false
        }
        
        return true
    }
    
    // If user has skin preferences, check if product skin details matches with user's
    private func matchSkin(skin: Skin) -> Bool {
        if (User.sharedInstance.criteria != nil) {
            if (User.sharedInstance.criteria?.skin?.bright == false
                && User.sharedInstance.criteria?.skin?.dark == false) {
                    return true
            }
            else if (User.sharedInstance.criteria?.skin?.bright == skin.bright
                && User.sharedInstance.criteria?.skin?.dark == skin.dark) {
                    return true
            }
            
            return false
        }
        
        return true
    }
    
    // If user has gender preferences, check if product gender details matches with user's
    private func matchGender(gender: Gender) -> Bool {
        if (User.sharedInstance.criteria != nil) {
            if (User.sharedInstance.criteria?.gender?.female == false
                && User.sharedInstance.criteria?.gender?.male == false) {
                    return true
            }
            else if (User.sharedInstance.criteria?.gender?.female == gender.female
                && User.sharedInstance.criteria?.gender?.male == gender.male) {
                    return true
            }
            
            return false
        }
        
        return true
    }
    
    private func matchMood(mood: Mood) -> Bool {
        if (User.sharedInstance.criteria != nil) {
            if (User.sharedInstance.criteria?.mood?.party == false
                && User.sharedInstance.criteria?.mood?.weekend == false
                && User.sharedInstance.criteria?.mood?.work == false
                && User.sharedInstance.criteria?.mood?.chill == false) {
                    return false
            }
            else {
                if (mood.party == true && User.sharedInstance.criteria?.mood?.party == true) {
                    return true
                }
                
                if (mood.weekend == true && User.sharedInstance.criteria?.mood?.weekend == true) {
                    return true
                }
                
                if (mood.work == true && User.sharedInstance.criteria?.mood?.work == true) {
                    return true
                }
                
                if (mood.chill == true && User.sharedInstance.criteria?.mood?.chill == true) {
                    return true
                }
                
                return false
            }
        }
        
        return true
    }
    
    private func loadProducts() -> Void {
        let requestUrl: NSURL = NSURL(string: PRODUCTS_URL)!
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: requestUrl)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Site available, downloading datas baby")
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    for item in json as! [[String: AnyObject]] {
                        
                        var criteria : Criteria = Criteria()
                        
                        // criterias
                        if let criteriaNode  = item["criteria"] as? [String: AnyObject] {
                            var mood : Mood = Mood()
                            var gender : Gender = Gender()
                            var skin : Skin = Skin()
                            var hair : Hair = Hair()
                            
                            // mood
                            if let moodNode = criteriaNode["mood"] as? [String : AnyObject] {
                                let moodParty = moodNode["party"] as! Bool
                                let moodWeekend = moodNode["weekend"] as! Bool
                                let moodChill = moodNode["chill"] as! Bool
                                let moodWork = moodNode["work"] as! Bool
                                
                                mood = Mood(party: moodParty, weekend: moodWeekend, chill: moodChill, work: moodWork)
                            }
                            
                            // gender
                            if let genderNode = criteriaNode["gender"] as? [String : AnyObject] {
                                let genderMale = genderNode["male"] as! Bool
                                let genderFemale = genderNode["female"] as! Bool
                                
                                gender = Gender(female: genderMale, male: genderFemale)
                            }
                            
                            // skin
                            if let skinNode = criteriaNode["skin"] as? [String : AnyObject] {
                                let skinBright = skinNode["bright"] as! Bool
                                let skinDark = skinNode["dark"] as! Bool
                                
                                hair = Hair(dark: skinBright, bright: skinDark)
                            }
                            
                            // hair
                            if let hairNode = criteriaNode["hair"] as? [String : AnyObject] {
                                let hairBight = hairNode["bright"] as! Bool
                                let hairDark = hairNode["dark"] as! Bool
                                
                                skin = Skin(dark: hairBight, bright: hairDark)
                            }
                            
                            criteria = Criteria(mood: mood, gender: gender, hair: hair, skin: skin)
                        }

                        let product: Product = Product(
                            id: item["id"] as? String,
                            title: item["title"] as? String,
                            about: item["about"] as? String,
                            picture: item["picture"] as? String,
                            tags: item["tags"] as? [String],
                            criteria: criteria
                        )
                        
                        // If user has preferences and product matches to that, get it
                        if (self.matchGender((product.criteria?.gender)!) == true
                            && self.matchHair((product.criteria?.hair)!) == true
                            && self.matchSkin((product.criteria?.skin)!) == true
                            && self.matchMood((product.criteria?.mood)!) == true) {
                                
                            product.pictureImage = self.downloadImage(product.picture!)
                            
                            self.products.append(product)
                            print("product was added")
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.filterProducts()
                        
                        self.collectionView.reloadData()
                    })
                }
                catch {
                    print("Hmm sorry buddy, an error occured during json retrieving")
                }
            }
        }
        
        task.resume()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: StyleCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(STYLE_CELL_IDENTIFIER, forIndexPath: indexPath) as! StyleCollectionViewCell
     
        cell.title.text = products[indexPath.row].title
        
        cell.picture.image = products[indexPath.row].pictureImage
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(PRODUCT_DETAIL_SEGUE, sender: products[indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == PRODUCT_DETAIL_SEGUE)
        {
            let controller: ProductDetailViewController = segue.destinationViewController as! ProductDetailViewController
            
            let product = sender as? Product
            
            controller.product = product
        }
    }
    
    func downloadImage(link: String) -> UIImage {
        return UIImage(data: NSData(contentsOfURL: NSURL(string: link)!)!)!
    }
}

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
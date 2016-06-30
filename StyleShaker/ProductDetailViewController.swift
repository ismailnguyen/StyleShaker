import UIKit

let TAG_CELL_IDENTIFIER = "TagCell"
let PRODUCT_LIST_SEGUE = "ProductListSegue"

class ProductDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionview: UICollectionView!
    
    var product: Product? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionview.dataSource = self
        collectionview.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        if (product != nil) {
            lbl_title.text = product?.title
            lbl_description.text = product?.about
            imageView.image = product?.pictureImage
            
            lbl_title.hidden = false
            lbl_description.hidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (product?.tags!.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: TagViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(TAG_CELL_IDENTIFIER, forIndexPath: indexPath) as! TagViewCell
        
        cell.lbl_title.text = product?.tags![indexPath.row]
        
        return cell
    }
    
    @IBAction func btn_bestOffers(sender: AnyObject) {
        performSegueWithIdentifier(PRODUCT_LIST_SEGUE, sender: product)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == PRODUCT_LIST_SEGUE)
        {
            let controller: WebViewController = segue.destinationViewController as! WebViewController
            
            let product = sender as? Product
            
            controller.product = product
        }
    }
}

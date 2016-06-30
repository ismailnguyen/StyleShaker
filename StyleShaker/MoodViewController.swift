import UIKit

let MOOD_CELL_IDENTIFIER = "MoodCell"
let STYLE_SEGUE = "StyleSegue"

class MoodViewController: UIViewController, UITableViewDataSource {

    let moodsCriteria: [String] = ["TRAVAIL", "SOIREE", "WEEKEND", "CHILL"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodsCriteria.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MoodTableViewCell = tableView.dequeueReusableCellWithIdentifier(MOOD_CELL_IDENTIFIER) as! MoodTableViewCell
        
        let mood : String = moodsCriteria[indexPath.row]
        
        cell.choiceLabel.text = mood
        
        if (mood == "TRAVAIL") {
            cell.choice.setOn((User.sharedInstance.getCriteria().mood?.work)!, animated: false)
        }
            
        else if (mood == "SOIREE") {
            cell.choice.setOn((User.sharedInstance.getCriteria().mood?.party)!, animated: false)
        }
            
        else if (mood == "WEEKEND") {
            cell.choice.setOn((User.sharedInstance.getCriteria().mood?.weekend)!, animated: false)
        }
            
        else if (mood == "CHILL") {
            cell.choice.setOn((User.sharedInstance.getCriteria().mood?.chill)!, animated: false)
        }
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    } 
    
    @IBAction func btn_valid(sender: AnyObject) {
        performSegueWithIdentifier(STYLE_SEGUE, sender: self)
    }
}
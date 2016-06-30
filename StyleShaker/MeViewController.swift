import UIKit

let ME_CELL_IDENTIFIER = "BodyCell"
let MOOD_SEGUE = "MoodSegue"

class MeViewController: UIViewController, UITableViewDataSource {

    let meCriterias: [String] = ["Cheveux", "Peau", "Sexe"]
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meCriterias.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: BodyTableViewCell = tableView.dequeueReusableCellWithIdentifier(ME_CELL_IDENTIFIER) as! BodyTableViewCell
        
        let criteria : String = meCriterias[indexPath.row]
        
        cell.choiceTitle.text = criteria
        
        if (criteria == "Cheveux") {
            if (User.sharedInstance.getCriteria().hair?.dark == true
                || User.sharedInstance.getCriteria().hair?.bright == true) {
                cell.choice.setOn(true, animated: false)
                    
                if (User.sharedInstance.getCriteria().hair?.dark == true) {
                    cell.choiceRight.layer.borderWidth = 1
                }
                else {
                    cell.choiceLeft.layer.borderWidth = 1
                }
            }
            
            cell.choiceLeft.setTitle("Clair", forState: UIControlState.Normal)
            cell.choiceRight.setTitle("Foncé", forState: UIControlState.Normal)
        }
        
        if (criteria == "Peau") {
            if (User.sharedInstance.getCriteria().skin?.dark == true
                || User.sharedInstance.getCriteria().skin?.bright == true) {
                    cell.choice.setOn(true, animated: false)
                    
                if (User.sharedInstance.getCriteria().skin?.dark == true) {
                    cell.choiceRight.layer.borderWidth = 1
                }
                else {
                    cell.choiceLeft.layer.borderWidth = 1
                }
            }
            
            cell.choiceLeft.setTitle("Clair", forState: UIControlState.Normal)
            cell.choiceRight.setTitle("Foncé", forState: UIControlState.Normal)
        }
        
        if (criteria == "Sexe") {
            if (User.sharedInstance.getCriteria().gender?.female == true
                || User.sharedInstance.getCriteria().gender?.male == true) {
                    cell.choice.setOn(true, animated: false)
                    
                if (User.sharedInstance.getCriteria().gender?.female == true) {
                    cell.choiceRight.layer.borderWidth = 1
                }
                else if (User.sharedInstance.getCriteria().gender?.male == true) {
                    cell.choiceLeft.layer.borderWidth = 1
                }
            }
            
            cell.choiceLeft.setTitle("Masculin", forState: UIControlState.Normal)
            cell.choiceRight.setTitle("Féminin", forState: UIControlState.Normal)
        }
        
        return cell
    }
    
    @IBAction func btn_valid(sender: AnyObject) {
        performSegueWithIdentifier(MOOD_SEGUE, sender: self)
    }
}

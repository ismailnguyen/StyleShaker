import UIKit

class MoodTableViewCell: UITableViewCell {

    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var choice: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onChoiceChanged(sender: AnyObject) {
        if (choiceLabel.text == "TRAVAIL") {
            User.sharedInstance.getCriteria().mood?.work = choice.on
        }
        
        else if (choiceLabel.text == "SOIREE") {
            User.sharedInstance.getCriteria().mood?.party = choice.on
        }
        
        else if (choiceLabel.text == "WEEKEND") {
            User.sharedInstance.getCriteria().mood?.weekend = choice.on
        }
        
        else if (choiceLabel.text == "CHILL") {
            User.sharedInstance.getCriteria().mood?.chill = choice.on
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

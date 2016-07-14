import UIKit

class BodyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var choiceTitle: UILabel!
    @IBOutlet weak var choice: UISwitch!
    @IBOutlet weak var choiceLeft: UIButton!
    @IBOutlet weak var choiceRight: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Left side choices
    @IBAction func onLeftChoiceSelected(sender: AnyObject) {
        if (choiceTitle.text == "Cheveux" && choice.on) {
            User.sharedInstance.getCriteria().updateSkin(
                Skin(dark: false, bright: true)
            )
        }
        
        else if (choiceTitle.text == "Peau" && choice.on) {
            User.sharedInstance.getCriteria().updateSkin(
                Skin(dark: false, bright: true)
            )
        }
        
        else if (choiceTitle.text == "Sexe" && choice.on) {
            User.sharedInstance.getCriteria().updateGender(
                Gender(female: false, male: true)
            )
        }
        
        // Update border of current button and disable other side one
        choiceLeft.layer.borderWidth = 1
        choiceRight.layer.borderWidth = 0
        
        User.sharedInstance.save()
    }

    // Right side choices
    @IBAction func onRightChoiceSelected(sender: AnyObject) {
        if (choiceTitle.text == "Cheveux" && choice.on) {
            User.sharedInstance.getCriteria().updateSkin(
                Skin(dark: true, bright: false)
            )
        }
        
        else if (choiceTitle.text == "Peau" && choice.on) {
            User.sharedInstance.getCriteria().updateSkin(
                Skin(dark: true, bright: false)
            )
        }
        
        else if (choiceTitle.text == "Sexe" && choice.on) {
            User.sharedInstance.getCriteria().updateGender(
                Gender(female: true, male: false)
            )
        }
        
        // Update border of current button and disable other side one
        choiceRight.layer.borderWidth = 1
        choiceLeft.layer.borderWidth = 0
        
        User.sharedInstance.save()
    }
    
    // Enable/Disable choices
    @IBAction func onChoiceChanged(sender: AnyObject) {
        if (choiceTitle.text == "Cheveux") {
            if (choice.on) {
                if (User.sharedInstance.getCriteria().hair?.isDark() == true) {
                    User.sharedInstance.getCriteria().updateHair(Hair(dark: true, bright: false))
                    choiceRight.layer.borderWidth = 1
                }
                else {
                    User.sharedInstance.getCriteria().updateHair(Hair(dark: false, bright: true))
                    choiceLeft.layer.borderWidth = 1
                }
            }
            else {
                User.sharedInstance.getCriteria().updateHair(Hair(dark: false, bright: false))
            }
        }
        
        else if (choiceTitle.text == "Peau") {
            if (choice.on) {
                if (User.sharedInstance.getCriteria().skin?.isDark() == true) {
                    User.sharedInstance.getCriteria().updateSkin(Skin(dark: true, bright: false))
                    choiceRight.layer.borderWidth = 1
                }
                else {
                    User.sharedInstance.getCriteria().updateSkin(Skin(dark: false, bright: true))
                    choiceLeft.layer.borderWidth = 1
                }
            }
            else {
                User.sharedInstance.getCriteria().updateSkin(Skin(dark: false, bright: false))
            }
        }
        
        else if (choiceTitle.text == "Sexe") {
            if (choice.on) {
                if (User.sharedInstance.getCriteria().gender?.isFemale() == true) {
                    User.sharedInstance.getCriteria().updateGender(Gender(female: true, male: false))
                    choiceRight.layer.borderWidth = 1
                }
                else {
                    User.sharedInstance.getCriteria().updateGender(Gender(female: false, male: true))
                    choiceLeft.layer.borderWidth = 1
                }
            }
            else {
                User.sharedInstance.getCriteria().updateGender(Gender(female: false, male: false))
            }
        }
        
        // Enable/Disable left and right choice buttons
        choiceRight.enabled = choice.on
        choiceLeft.enabled = choice.on
        
        if (!choice.on) {
            choiceRight.layer.borderWidth = 0
            choiceLeft.layer.borderWidth = 0
        }
        
        User.sharedInstance.save()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

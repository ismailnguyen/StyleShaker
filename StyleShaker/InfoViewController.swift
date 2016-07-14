//
//  InfoViewController.swift
//  StyleShaker
//
//  Created by Etudiant on 28/06/2016.
//  Copyright © 2016 ESGI. All rights reserved.
//

import UIKit

class InfoViewController : UIViewController {
    
    @IBOutlet weak var easter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        easter.userInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        easter.addGestureRecognizer(gestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        let noContentAlert = UIAlertController(title: "Oust", message: "Petit conquinou !", preferredStyle: UIAlertControllerStyle.Alert)
        
        noContentAlert.addAction(UIAlertAction(title: "Oui Maitre", style: .Default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popViewControllerAnimated(true)
        }))
        
        presentViewController(noContentAlert, animated: true, completion: nil)
    }
}


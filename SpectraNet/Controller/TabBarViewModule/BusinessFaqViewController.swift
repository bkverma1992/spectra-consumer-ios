//
//  BusinessViewController.swift
//  SpectraNet
//
//  Created by Yugasalabs-28 on 30/08/2019.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit

class BusinessFaqViewController: UIViewController {
    @IBOutlet var ques1: UILabel!
    @IBOutlet var ques2: UILabel!
    @IBOutlet var ques3: UILabel!
    @IBOutlet var ques4: UILabel!
    @IBOutlet var ques5: UILabel!
    @IBOutlet var ques6: UILabel!
    @IBOutlet var ques7: UILabel!
    @IBOutlet var ques8: UILabel!
    @IBOutlet var ques9: UILabel!
    @IBOutlet var ques10: UILabel!
    @IBOutlet var ques11: UILabel!
    @IBOutlet var ques12: UILabel!
    @IBOutlet var ques13: UILabel!
    @IBOutlet var ques14: UILabel!
    @IBOutlet var ques15: UILabel!
    @IBOutlet var ques16: UILabel!
    @IBOutlet var ques17: UILabel!
    @IBOutlet var ques18: UILabel!
    @IBOutlet var ques19: UILabel!
    @IBOutlet var ques20: UILabel!
    
    @IBOutlet var ans1: UILabel!
    @IBOutlet var ans2: UILabel!
    @IBOutlet var ans3: UILabel!
    @IBOutlet var ans4: UILabel!
    @IBOutlet var ans5: UILabel!
    @IBOutlet var ans6: UILabel!
    @IBOutlet var ans7: UILabel!
    @IBOutlet var ans8: UILabel!
    @IBOutlet var ans9: UILabel!
    @IBOutlet var ans10: UILabel!
    @IBOutlet var ans11: UILabel!
    @IBOutlet var ans12: UILabel!
    @IBOutlet var ans13: UILabel!
    @IBOutlet var ans14: UILabel!
    @IBOutlet var ans15: UILabel!
    @IBOutlet var ans16: UILabel!
    @IBOutlet var ans17: UILabel!
    @IBOutlet var ans18: UILabel!
    @IBOutlet var ans19: UILabel!
    @IBOutlet var ans20: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ques1.text = faqBusinessQuestion.ques1
        ques2.text = faqBusinessQuestion.ques2
        ques3.text = faqBusinessQuestion.ques3
        ques4.text = faqBusinessQuestion.ques4
        ques5.text = faqBusinessQuestion.ques5
        ques6.text = faqBusinessQuestion.ques6
        ques7.text = faqBusinessQuestion.ques7
        ques8.text = faqBusinessQuestion.ques8
        ques9.text = faqBusinessQuestion.ques9
        ques10.text = faqBusinessQuestion.ques10
        ques11.text = faqBusinessQuestion.ques11
        ques12.text = faqBusinessQuestion.ques12
        ques13.text = faqBusinessQuestion.ques13
        ques14.text = faqBusinessQuestion.ques14
        ques15.text = faqBusinessQuestion.ques15
        ques16.text = faqBusinessQuestion.ques16
        ques17.text = faqBusinessQuestion.ques17
        ques18.text = faqBusinessQuestion.ques18
        ques19.text = faqBusinessQuestion.ques19
        ques20.text = faqBusinessQuestion.ques20

    }
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func qsnBTN1(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans1.text = faqBusinessAnswer.ans1
        }
        else
        {
            ans1.text = ""
            
        }
    }
    @IBAction func qsnBTN2(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans2.text = faqBusinessAnswer.ans2
        }
        else
        {
            ans2.text = ""
        }
    }
    @IBAction func qsnBTN3(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans3.text = faqBusinessAnswer.ans3
            
        }
        else
        {
            ans3.text = ""
            
        }
    }
    @IBAction func qsnBTN4(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans4.text = faqBusinessAnswer.ans4
            
        }
        else
        {
            ans4.text = ""
            
        }
    }
    @IBAction func qsnBTN5(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans5.text = faqBusinessAnswer.ans5
            
        }
        else
        {
            ans5.text = ""
            
        }
    }
    @IBAction func qsnBTN6(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans6.text = faqBusinessAnswer.ans6
            
        }
        else
        {
            ans6.text = ""
            
        }
    }
    @IBAction func qsnBTN7(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans7.text = faqBusinessAnswer.ans7
            
        }
        else
        {
            ans7.text = ""
            
        }
    }
    @IBAction func qsnBTN8(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans8.text = faqBusinessAnswer.ans8
            
        }
        else
        {
            ans8.text = ""
            
        }
    }
    @IBAction func qsnBTN9(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans9.text = faqBusinessAnswer.ans9
            
        }
        else
        {
            ans9.text = ""
            
        }
    }
    @IBAction func qsnBTN10(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans10.text = faqBusinessAnswer.ans10
            
        }
        else
        {
            ans10.text = ""
            
        }
    }
    @IBAction func qsnBTN11(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans11.text = faqBusinessAnswer.ans11
            
        }
        else
        {
            ans11.text = ""
            
        }
    }
    @IBAction func qsnBTN12(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans12.text = faqBusinessAnswer.ans12
            
        }
        else
        {
            ans12.text = ""
            
        }
    }
    @IBAction func qsnBTN13(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans13.text = faqBusinessAnswer.ans13
            
        }
        else
        {
            ans13.text = ""
            
        }
    }
    @IBAction func qsnBTN14(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans14.text = faqBusinessAnswer.ans14
            
        }
        else
        {
            ans14.text = ""
            
        }
    }
    @IBAction func qsnBTN15(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans15.text = faqBusinessAnswer.ans15
            
        }
        else
        {
            ans15.text = ""
            
        }
    }
    @IBAction func qsnBTN16(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans16.text = faqBusinessAnswer.ans16
            
        }
        else
        {
            ans16.text = ""
            
        }
    }
    @IBAction func qsnBTN17(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans17.text = faqBusinessAnswer.ans17
            
        }
        else
        {
            ans17.text = ""
            
        }
    }
    @IBAction func qsnBTN18(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans18.text = faqBusinessAnswer.ans18
            
        }
        else
        {
            ans18.text = ""
            
        }
    }
    @IBAction func qsnBTN19(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans19.text = faqBusinessAnswer.ans19
            
        }
        else
        {
            ans19.text = ""
            
        }
    }
    @IBAction func qsnBTN20(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans20.text = faqBusinessAnswer.ans20
            
        }
        else
        {
            ans20.text = ""
            
        }
    }
 

}

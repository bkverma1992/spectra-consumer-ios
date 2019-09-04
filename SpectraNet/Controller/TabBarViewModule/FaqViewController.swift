//
//  FaqViewController.swift
//  SpectraNet
//
//  Created by Bhoopendra on 8/14/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit

class FaqViewController: UIViewController,UIScrollViewDelegate
{

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
    @IBOutlet var ques21: UILabel!
    @IBOutlet var ques22: UILabel!
    @IBOutlet var ques23: UILabel!
    @IBOutlet var ques24: UILabel!
    @IBOutlet var ques25: UILabel!
    @IBOutlet var ques26: UILabel!
    @IBOutlet var ques27: UILabel!
    @IBOutlet var ques28: UILabel!
    @IBOutlet var ques29: UILabel!
    @IBOutlet var ques30: UILabel!
    @IBOutlet var ques31: UILabel!
    @IBOutlet var ques32: UILabel!
    @IBOutlet var ques33: UILabel!
    @IBOutlet var ques34: UILabel!
    @IBOutlet var ques35: UILabel!
    @IBOutlet var ques36: UILabel!
    @IBOutlet var ques37: UILabel!
    @IBOutlet var ques38: UILabel!
    @IBOutlet var ques39: UILabel!
    @IBOutlet var ques40: UILabel!
    @IBOutlet var ques41: UILabel!
    @IBOutlet var ques42: UILabel!
    @IBOutlet var ques43: UILabel!
    @IBOutlet var ques44: UILabel!
    @IBOutlet var ques45: UILabel!
    @IBOutlet var ques46: UILabel!
    @IBOutlet var ques47: UILabel!

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
    @IBOutlet var ans21: UILabel!
    @IBOutlet var ans22: UILabel!
    @IBOutlet var ans23: UILabel!
    @IBOutlet var ans24: UILabel!
    @IBOutlet var ans25: UILabel!
    @IBOutlet var ans26: UILabel!
    @IBOutlet var ans27: UILabel!
    @IBOutlet var ans28: UILabel!
    @IBOutlet var ans29: UILabel!
    @IBOutlet var ans30: UILabel!
    @IBOutlet var ans31: UILabel!
    @IBOutlet var ans32: UILabel!
    @IBOutlet var ans33: UILabel!
    @IBOutlet var ans34: UILabel!
    @IBOutlet var ans35: UILabel!
    @IBOutlet var ans36: UILabel!
    @IBOutlet var ans37: UILabel!
    @IBOutlet var ans38: UILabel!
    @IBOutlet var ans39: UILabel!
    @IBOutlet var ans40: UILabel!
    @IBOutlet var ans41: UILabel!
    @IBOutlet var ans42: UILabel!
    @IBOutlet var ans43: UILabel!
    @IBOutlet var ans44: UILabel!
    @IBOutlet var ans45: UILabel!
    @IBOutlet var ans46: UILabel!
    @IBOutlet var ans47: UILabel!


    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        ques1.text = faqHomeQuestion.ques1
        ques2.text = faqHomeQuestion.ques2
        ques3.text = faqHomeQuestion.ques3
        ques4.text = faqHomeQuestion.ques4
        ques5.text = faqHomeQuestion.ques5
        ques6.text = faqHomeQuestion.ques6
        ques7.text = faqHomeQuestion.ques7
        ques8.text = faqHomeQuestion.ques8
        ques9.text = faqHomeQuestion.ques9
        ques10.text = faqHomeQuestion.ques10
        ques11.text = faqHomeQuestion.ques11
        ques12.text = faqHomeQuestion.ques12
        ques13.text = faqHomeQuestion.ques13
        ques14.text = faqHomeQuestion.ques14
        ques15.text = faqHomeQuestion.ques15
        ques16.text = faqHomeQuestion.ques16
        ques17.text = faqHomeQuestion.ques17
        ques18.text = faqHomeQuestion.ques18
        ques19.text = faqHomeQuestion.ques19
        ques20.text = faqHomeQuestion.ques20
        ques21.text = faqHomeQuestion.ques21
        ques22.text = faqHomeQuestion.ques22
        ques23.text = faqHomeQuestion.ques23
        ques24.text = faqHomeQuestion.ques24
        ques25.text = faqHomeQuestion.ques25
        ques26.text = faqHomeQuestion.ques26
        ques27.text = faqHomeQuestion.ques27
        ques28.text = faqHomeQuestion.ques28
        ques29.text = faqHomeQuestion.ques29
        ques30.text = faqHomeQuestion.ques30
        ques31.text = faqHomeQuestion.ques31
        ques32.text = faqHomeQuestion.ques32
        ques33.text = faqHomeQuestion.ques33
        ques34.text = faqHomeQuestion.ques34
        ques35.text = faqHomeQuestion.ques35
        ques36.text = faqHomeQuestion.ques36
        ques37.text = faqHomeQuestion.ques37
        ques38.text = faqHomeQuestion.ques38
        ques39.text = faqHomeQuestion.ques39
        ques40.text = faqHomeQuestion.ques40
        ques41.text = faqHomeQuestion.ques41
        ques42.text = faqHomeQuestion.ques42
        ques43.text = faqHomeQuestion.ques43
        ques44.text = faqHomeQuestion.ques44
        ques45.text = faqHomeQuestion.ques45
        ques46.text = faqHomeQuestion.ques46
        ques47.text = faqHomeQuestion.ques47

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
            ans1.text = faqHomeAnswer.ans1
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
            ans2.text = faqHomeAnswer.ans2
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
            ans3.text = faqHomeAnswer.ans3

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
            ans4.text = faqHomeAnswer.ans4

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
            ans5.text = faqHomeAnswer.ans5

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
            ans6.text = faqHomeAnswer.ans6

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
            ans7.text = faqHomeAnswer.ans7

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
            ans8.text = faqHomeAnswer.ans8

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
            ans9.text = faqHomeAnswer.ans9

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
            ans10.text = faqHomeAnswer.ans10

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
            ans11.text = faqHomeAnswer.ans11

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
            ans12.text = faqHomeAnswer.ans12

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
            ans13.text = faqHomeAnswer.ans13

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
            ans14.text = faqHomeAnswer.ans14

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
            ans15.text = faqHomeAnswer.ans15

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
            ans16.text = faqHomeAnswer.ans16

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
            ans17.text = faqHomeAnswer.ans17

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
            ans18.text = faqHomeAnswer.ans18

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
            ans19.text = faqHomeAnswer.ans19

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
            ans20.text = faqHomeAnswer.ans20

        }
        else
        {
            ans20.text = ""

        }
    }
    @IBAction func qsnBTN21(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans21.text = faqHomeAnswer.ans21

        }
        else
        {
            ans21.text = ""

        }
    }
    @IBAction func qsnBTN22(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans22.text = faqHomeAnswer.ans22

        }
        else
        {
            ans22.text = ""

        }
    }
    @IBAction func qsnBTN23(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans23.text = faqHomeAnswer.ans23

        }
        else
        {
            ans23.text = ""

        }
    }
    @IBAction func qsnBTN24(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans24.text = faqHomeAnswer.ans24

        }
        else
        {
            ans24.text = ""

        }
    }
    @IBAction func qsnBTN25(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans25.text = faqHomeAnswer.ans25

        }
        else
        {
            ans25.text = ""

        }
    }
    @IBAction func qsnBTN26(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans26.text = faqHomeAnswer.ans26

        }
        else
        {
            ans26.text = ""

        }
    }
    @IBAction func qsnBTN27(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans27.text = faqHomeAnswer.ans27

        }
        else
        {
            ans27.text = ""

        }
    }
    @IBAction func qsnBTN28(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans28.text = faqHomeAnswer.ans28

        }
        else
        {
            ans28.text = ""

        }
    }
    @IBAction func qsnBTN29(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans29.text = faqHomeAnswer.ans29

        }
        else
        {
            ans29.text = ""

        }
    }
    @IBAction func qsnBTN30(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans30.text = faqHomeAnswer.ans30

        }
        else
        {
            ans30.text = ""

        }
    }
    @IBAction func qsnBTN31(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans31.text = faqHomeAnswer.ans31

        }
        else
        {
            ans31.text = ""

        }
    }
    @IBAction func qsnBTN32(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans32.text = faqHomeAnswer.ans32

        }
        else
        {
            ans32.text = ""

        }
    }
    @IBAction func qsnBTN33(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans33.text = faqHomeAnswer.ans33

        }
        else
        {
            ans33.text = ""

        }
    }
    @IBAction func qsnBTN34(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans34.text = faqHomeAnswer.ans34

        }
        else
        {
            ans34.text = ""

        }
    }
    @IBAction func qsnBTN35(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans35.text = faqHomeAnswer.ans35

        }
        else
        {
            ans35.text = ""

        }
    }
    @IBAction func qsnBTN36(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans36.text = faqHomeAnswer.ans36

        }
        else
        {
            ans36.text = ""

        }
    }
    @IBAction func qsnBTN37(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans37.text = faqHomeAnswer.ans37

        }
        else
        {
            ans37.text = ""

        }
    }
    @IBAction func qsnBTN38(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans38.text = faqHomeAnswer.ans38

        }
        else
        {
            ans38.text = ""

        }
    }
    @IBAction func qsnBTN39(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans39.text = faqHomeAnswer.ans39

        }
        else
        {
            ans39.text = ""

        }
    }
    @IBAction func qsnBTN40(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans40.text = faqHomeAnswer.ans40

        }
        else
        {
            ans40.text = ""

        }
    }
    @IBAction func qsnBTN41(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans41.text = faqHomeAnswer.ans41

        }
        else
        {
            ans41.text = ""

        }
    }
    @IBAction func qsnBTN42(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans42.text = faqHomeAnswer.ans42

        }
        else
        {
            ans42.text = ""

        }
    }
    @IBAction func qsnBTN43(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans43.text = faqHomeAnswer.ans43

        }
        else
        {
            ans43.text = ""

        }
    }
    @IBAction func qsnBTN44(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans44.text = faqHomeAnswer.ans44

        }
        else
        {
            ans44.text = ""

        }
    }
    @IBAction func qsnBTN45(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans45.text = faqHomeAnswer.ans45

        }
        else
        {
            ans45.text = ""

        }
    }
    @IBAction func qsnBTN46(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans46.text = faqHomeAnswer.ans46
        }
        else
        {
            ans46.text = ""
        }
    }
    @IBAction func qsnBTN47(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            ans47.text = faqHomeAnswer.ans47
        }
        else
        {
            ans47.text = ""
        }
    }
   
}

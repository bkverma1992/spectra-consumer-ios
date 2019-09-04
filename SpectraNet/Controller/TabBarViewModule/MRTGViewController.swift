//
//  MRTGViewController.swift
//  SpectraNet
//
//  Created by Yugasalabs-28 on 29/08/2019.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit

class MRTGViewController: UIViewController,UIScrollViewDelegate {
    var networkClass = CANetworkManager()
    @IBOutlet var img: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if ConnectionCheck.isConnectedToNetwork() == true
        {
            self .serviceGetMRTGGbcanId()
        }
        else
        {
            showAlertC(message: AlertViewMessage.internetConnection)
        }
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return img
    }
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func serviceGetMRTGGbcanId()
    {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.getMRTGGbcanID, forKey: "Action")
        dict .setValue("9019422", forKey: "canID")
        dict .setValue("1", forKey: "dateType")
        dict .setValue(UserAuthKEY.authKEY, forKey: "Authkey")
        print(dict)
        
        networkClass.requestApi(serviceName: ServiceMethods.serviceBaseURL, method: kHTTPMethod.POST, postData: dict as! Dictionary<String, AnyObject>) { (response, error) in
            
            print(response as Any)
            if response != nil
            {
                var dataResponse = NSDictionary()
                var checkStatus = String()
                
                dataResponse = response as! NSDictionary
                checkStatus = dataResponse.value(forKey: "status") as! String
                
                if checkStatus == "success"
                {
                    let strr = dataResponse.value(forKey: "response")
                    self.img.image = self.base64Convert(base64String: strr as? String)
                }
                else
                {
                    self.showAlertC(message:dataResponse.value(forKey: "message") as! String)
                }
            }
        }
    }
    
    func base64Convert(base64String: String?) -> UIImage{
        if (base64String?.isEmpty)! {
            return #imageLiteral(resourceName: "no_image_found")
        }else {
            let dataDecoded : Data = Data(base64Encoded: base64String!, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            return decodedimage!
        }
    }
}

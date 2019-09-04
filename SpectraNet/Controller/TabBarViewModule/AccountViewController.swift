//
//  AccountViewController.swift
//  SpectraNet
//
//  Created by Yugasalabs-28 on 23/07/2019.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class AccountViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let realm = try? Realm()
    var userResult:Results<UserCurrentData>? = nil
    
    let networkClass = CANetworkManager()
    var dataResponse = NSDictionary()
    var checkStatus = String()
    var profileListData = NSDictionary()
    var appd = AppDelegate()
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var chooseBuuton: UIButton!
    var imagePicker = UIImagePickerController()
    var canID = String()
    
    @IBOutlet var profileImgBTN: UIButton!
    
    @IBOutlet var userNameTF: UITextField!
    @IBOutlet var mobileNumberTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var userAddress: UILabel!
    @IBOutlet var selectedCanID: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var profileParentView: UIView!
    
    @IBOutlet var canIDView: UIView!
    @IBOutlet var LblPhotoStatus: UILabel!
    @IBOutlet var lbluserNameD: UILabel!
    @IBOutlet var lbluserIDNameD: UILabel!
    @IBOutlet var lblBillingContactD: UILabel!
    @IBOutlet var lblBillingAdd: UILabel!
    @IBOutlet var lblTechContactD: UILabel!
    @IBOutlet var lblBillingAddD: UILabel!
    @IBOutlet var billingContactTF: UITextField!
    @IBOutlet var techContactTF: UITextField!
    @IBOutlet var instaLine: UILabel!
    @IBOutlet var billingLine: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appd = UIApplication.shared.delegate as! AppDelegate
        
        
        userResult = self.realm!.objects(UserCurrentData.self)
        if let userData = userResult?[0]
        {
            userNameTF.text = userData.AccountName
            canID = userData.CANId
            selectedCanID.text = String(format: "CAN ID - %@", canID)
            appd.segmentType = userData.Segment
        }
        if appd.segmentType == segment.userB2C
        {
            lbluserNameD.text = profileUserB2C.userNameD
            lbluserIDNameD.text = profileUserB2C.userIdD
            lblBillingAddD.text = profileUserB2C.billingAddD
            lblBillingAdd.text = ""
            lblTechContactD.text = ""
            lblBillingContactD.text = ""
            billingContactTF.text = ""
            techContactTF.text = ""
            instaLine.isHidden = true
            billingLine.isHidden = true

        }
        else
        {
            lbluserNameD.text = profileUserB2B.userNameD
            lbluserIDNameD.text = profileUserB2B.userIdD
            lblBillingAddD.text = profileUserB2B.billingAddD
            instaLine.isHidden = false
            billingLine.isHidden = false
        }
   
        if ConnectionCheck.isConnectedToNetwork() == true
        {
             serviceTypeGetProfile()
        }
        else
        {
            showAlertC(message: AlertViewMessage.internetConnection)
        }
       
        if UIScreen.main.sizeType == .iPhone5
        {
            scrollView.isScrollEnabled = true
        }
        else
        {
            scrollView.isScrollEnabled = false
        }
        
        if isKeyPresentInUserDefaults(key: "Userimage")
        {
        let dataa = UserDefaults.standard.object(forKey: "Userimage") as! Data
        print(dataa)
        let image = UIImage(data: dataa)
        profileImgBTN.setImage(image, for: UIControl.State.normal)
        setCornerRadiusButton(radius: Float(profileImgBTN.frame.height/2), color: UIColor.clear, button: profileImgBTN)
            LblPhotoStatus.text = profilePictureUpload.UploadedImageText
        }
        else
        {
            LblPhotoStatus.text = profilePictureUpload.ifImageNotUploadText
        }

        profileParentView.isHidden = true
        canIDView.isHidden = true
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    func serviceTypeGetProfile()
    {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.getProfile, forKey: "Action")
        dict .setValue(canID, forKey: "canID")
        dict .setValue(UserAuthKEY.authKEY, forKey: "Authkey")
        print(dict)
        networkClass.requestApi(serviceName: ServiceMethods.serviceBaseURL, method: kHTTPMethod.POST, postData: dict as! Dictionary<String, AnyObject>) { (response, error) in
            
            print(response as Any)
            if response != nil
            {
                self.dataResponse = response as! NSDictionary
                self.checkStatus = self.dataResponse.value(forKey: "status") as! String
            
                if self.checkStatus == "success"
                  {
                    self.profileListData = self.dataResponse.value(forKey: "response") as! NSDictionary
                    self.setData(dict: self.profileListData.value(forKey: "billTo") as! NSDictionary)
                    self.profileParentView.isHidden = false
                    self.canIDView.isHidden = false
                  }
                else
                  {
                    self.showAlertC(message:self.dataResponse.value(forKey: "response") as! String)
                 }
          }
        }
    }
    
    func setData(dict: NSDictionary)
    {
        if appd.segmentType==segment.userB2C
        {
            mobileNumberTF.text = dict.value(forKey: "mobile") as? String
        }
        else
        {
            mobileNumberTF.text = canID
            lblBillingAdd.text = dict.value(forKey: "address") as? String
            billingContactTF.text = dict.value(forKey: "mobile") as? String
            userNameTF.text = dict.value(forKey: "username") as? String
            techContactTF.text = ""
        }
        emailTF.text = dict.value(forKey: "email") as? String
        userAddress.text = dict.value(forKey: "address") as? String
  
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func uploadImgBTN(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func showCanIDClick(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.CanIDSelectedIdentifier) as? CanIDViewController
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    
        var yourDataImagePNG = NSData()
        let  croppedImage = cropImage(imageToCrop: chosenImage, toRect: CGRectMake(
            chosenImage.size.width/2,
                0,
            chosenImage.size.width/2,
            chosenImage.size.height)
        )
        yourDataImagePNG = (croppedImage ).pngData()! as NSData
       
        UserDefaults().set(yourDataImagePNG, forKey: "Userimage")
        UserDefaults.standard.object(forKey: "Userimage")
        print(UserDefaults.standard.object(forKey: "Userimage") as! Data)
        
        let dataa = UserDefaults.standard.object(forKey: "Userimage") as! Data
        print(dataa)
        let image = UIImage(data: dataa)
        profileImgBTN.setImage(image, for: UIControl.State.normal)
        setCornerRadiusButton(radius: Float(profileImgBTN.frame.height/2), color: UIColor.clear, button: profileImgBTN)
        LblPhotoStatus.text = profilePictureUpload.UploadedImageText

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func cropImage(imageToCrop:UIImage, toRect rect:CGRect) -> UIImage{
        
        let imageRef:CGImage = imageToCrop.cgImage!.cropping(to: rect)!
        let cropped:UIImage = UIImage(cgImage:imageRef)
        return cropped
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}

extension UIImage {
    
    func save(at directory: FileManager.SearchPathDirectory,
              pathAndImageName: String,
              createSubdirectoriesIfNeed: Bool = true,
              compressionQuality: CGFloat = 1.0)  -> URL? {
        do {
            let documentsDirectory = try FileManager.default.url(for: directory, in: .userDomainMask,
                                                                 appropriateFor: nil,
                                                                 create: false)
            return save(at: documentsDirectory.appendingPathComponent(pathAndImageName),
                        createSubdirectoriesIfNeed: createSubdirectoriesIfNeed,
                        compressionQuality: compressionQuality)
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
    
    func save(at url: URL,
              createSubdirectoriesIfNeed: Bool = true,
              compressionQuality: CGFloat = 1.0)  -> URL? {
        do {
            if createSubdirectoriesIfNeed {
                try FileManager.default.createDirectory(at: url.deletingLastPathComponent(),
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            }
            guard let data = jpegData(compressionQuality: compressionQuality) else { return nil }
            try data.write(to: url)
            return url
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
}

// load from path

extension UIImage {
    convenience init?(fileURLWithPath url: URL, scale: CGFloat = 1.0) {
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data, scale: scale)
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
}

//extension UIImage {
//    func crop(to:CGSize) -> UIImage {
//        guard let cgimage = self.cgImage else { return self }
//
//        let contextImage: UIImage = UIImage(cgImage: cgimage)
//
//        let contextSize: CGSize = contextImage.size
//
//        //Set to square
//        var posX: CGFloat = 0.0
//        var posY: CGFloat = 0.0
//        let cropAspect: CGFloat = to.width / to.height
//
//        var cropWidth: CGFloat = to.width
//        var cropHeight: CGFloat = to.height
//
//        if to.width > to.height { //Landscape
//            cropWidth = contextSize.width
//            cropHeight = contextSize.width / cropAspect
//            posY = (contextSize.height - cropHeight) / 2
//        } else if to.width < to.height { //Portrait
//            cropHeight = contextSize.height
//            cropWidth = contextSize.height * cropAspect
//            posX = (contextSize.width - cropWidth) / 2
//        } else { //Square
//            if contextSize.width >= contextSize.height { //Square on landscape (or square)
//                cropHeight = contextSize.height
//                cropWidth = contextSize.height * cropAspect
//                posX = (contextSize.width - cropWidth) / 2
//            }else{ //Square on portrait
//                cropWidth = contextSize.width
//                cropHeight = contextSize.width / cropAspect
//                posY = (contextSize.height - cropHeight) / 2
//            }
//}
//}
//}

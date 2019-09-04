//
//  InvoiceContentViewController.swift
//  SpectraNet
//
//  Created by Bhoopendra on 8/19/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import WebKit
import PDFKit

class InvoiceContentViewController: UIViewController,UIWebViewDelegate {
   
    @IBOutlet var pdfView: PDFView!
    @IBOutlet var webView2: UIWebView!
    var networkClass = CANetworkManager()
    let realm = try? Realm()
    var userResult:Results<UserCurrentData>? = nil
    var invoiceNumber = String()
    var sendInvoiceNumber = String()
    var htmlStr = String()
    var fileUrl = NSURL()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ConnectionCheck.isConnectedToNetwork() == true
        {
            print(fileUrl)
            if fileUrl.absoluteString == ""
            {
                 serviceTypeInvoiceContentData()
            }
            else
            {
            if !FileManager.default.fileExists(atPath:fileUrl.path!)
            {
                serviceTypeInvoiceContentData()
            }
            else
            {
                if let document = PDFDocument(url: fileUrl as URL) {
                    pdfView.document = document
                }
            }
          }
        }
        else
        {
            showAlertC(message: AlertViewMessage.internetConnection)
        }
        webView2.isHidden = true
    }

    func serviceTypeInvoiceContentData()
    {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.invoiceContent, forKey: "Action")
        dict .setValue(invoiceNumber, forKey: "invoiceNo")
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
                    self.htmlStr = dataResponse.value(forKey: "response") as! String
                    self.webView2.loadHTMLString(self.htmlStr, baseURL: nil)
                    self.webView2.delegate = self
//                    self.openPDFView() remove webview from this screen
                    self.webView2.isHidden = true
                }
                else
                {
                    self.showAlertC(message:dataResponse.value(forKey: "message") as! String)
                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func shareInvoice(_ sender: Any)
    {
        let vc = UIActivityViewController(activityItems: [fileUrl], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        openPDFView()
    }
    
    func openPDFView()
    {
        let render = UIPrintPageRenderer()
        render.addPrintFormatter((self.webView2?.viewPrintFormatter())!, startingAtPageAt: 0)
        let page = CGRect(x: 0, y: 0, width: webView2.frame.width, height: webView2.frame.height)
        render.setValue(NSValue(cgRect:page),forKey:"paperRect")
        render.setValue(NSValue(cgRect:page), forKey: "printableRect")
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData,page, nil)
        
        for i in 1...render.numberOfPages-1
        {
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bounds)
        }
        
        UIGraphicsEndPDFContext();
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(documentsDirectory)
        var nameOfFile = String()
        nameOfFile = String(format: "%@.pdf", invoiceNumber)
        
        fileUrl = documentsDirectory.appendingPathComponent(nameOfFile) as NSURL;
        
        if !FileManager.default.fileExists(atPath:fileUrl.path!) {
        do {
            try pdfData.write(to: fileUrl as URL)
            print("file saved")
            if let document = PDFDocument(url: fileUrl as URL) {
                pdfView.document = document
            }
        }
        catch
        {
            print("error saving file:", error);
        }
        }
        else
        {
            if let document = PDFDocument(url: fileUrl as URL) {
                pdfView.document = document
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

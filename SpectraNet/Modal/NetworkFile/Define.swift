//
//  Define.swift
//  MenuCardCreator
//
//  Created by Chakshu on 8/7/18.
//  Copyright © 2018 Affle Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit


// MARK : GLOBAL Functions
func print_debug <T> (object: T) {
//print(object)
}
struct ServiceMethods{
    //static let serviceBaseURL = "https://epayuat.spectra.co/index.php"       // Testing
    static let serviceBaseURL = "https://epayuat.spectra.co/index.php"       // LiVe
   // "http://52.44.93.62:8012/v1/"       // Live
    static let ServiceSpectr = "https://epay.spectra.co/kaizala_attn/index.php"
}


struct ColorCodes {
    
//    static let cartGrayColor = UIColor(hex: "f5f5f5")
//    static let loaderColor  = UIColor(hex: "D7213C")
//    static let totalUserGraphColor  = UIColor(hex: "D7213C")
//    static let totalParticipantGraphColor  = UIColor(hex: "972F6F")
}

/// This structer is used for all the Web Links
struct WebLinks {
   
  
    static let termAndCondition    =   "https://jasonsdeli.com.sg/terms-of-use"
    static let privacyPolicy    =   "https://jasonsdeli.com.sg/privacy-policy"
    
    
}

struct ActionKeys {
    
    static let userAccountData = "getAccountData"
    static let getInvoiceList = "getInvoiceList"
    static let getAccountByPassword = "getAccountByPassword"
    static let getAccountByMobile = "getAccountByMobile"
    static let sandOTP = "sendotp"
    static let resendOTP = "resendotp"
    static let forgotPassword = "forgotpassword"
    static let paymentTransactionDetails = "paymentTransactionDetail"
    static let getSRStatus = "getSRstatus"
    static let getProfile = "getprofile"
    static let getAttnSpectra = "getAttn"
    static let getRatePlan = "getrateplan"
    static let getCases = "getcasetype"
    static let createSR = "createSR"
    static let invoiceContent = "getInvoiceContent"
    static let getMRTGGbcanID = "getMRTGbycanid"
    static let getSessionHistory = "getSessionhistory"

}

struct UserAuthKEY {
    static let authKEY      = "AdgT68HnjkehEqlkd4"
    static let authKEYSpectra      = "AdgT6SnjAkeLqlkE4"
}

struct ErrorValidationMessages {
    static let wrongEmailAddress    =    "Please enter valid email."
    static let wrongEmailUserName    =    "Please enter username"
    static let wrongMobileNumber    =    "Please enter valid mobile number."
    static let wrongEnterPassword    =     "Please enter your password"
    static let wrongPassword    =     "Password should be atleast 10 characters long."
    static let validOption    =     "Please enter valid options."
}

struct DefaultString {
    static let setSeletctdate = "Select Date"
}

///This structer is used for all the keys used in service class.All the keys used in service class should be here.
struct ServiceKeys {
    
    static let status = "status"
}

/// This structer is used for all the Segue's in the app
struct Segue {
    
    
    
}

struct ViewIdentifier {
    static let homeIdentifier = "HomeView"
    static let invoiceIdentifier = "InvoiceDetail"
    static let loginIdentifier = "LoginView"
    static let otpIdentifier = "OTPViewC"
    static let forgotPswdIdentifier = "ForgotPasswordView"
    static let customTabIdentifier = "CustomTab"
    static let menuIdentifier = "MoreView"
    static let SRIdentifier = "SRView"
    static let AccountIdentifier = "AccountView"
    static let NotificationIdentifier = "NotificationVC"
    static let planIdentifier = "PlanView"
    static let CanIDSelectedIdentifier = "CanIDVC"
    static let PayNowIdentifier = "PayNowVC"
    static let CreateSRIdentifier = "CreateSRVC"
    static let dataUsageIdentifier = "DataUsageVC"
    static let faqIdentifier = "FaqVC"
    static let invoiceDetailsIdentifier = "InvoiceContentVC"
    static let caseTypeIdentifier = "CaseTypeCell"
    static let mrtgIdentifier = "MRTGVC"
    static let businessIdentifier = "BusinessFaqVC"
}

struct TableViewCellName {
      static let homeTableViewCell = "HomeCell"
      static let invoiceTableViewCell = "InvoiceCell"
      static let TrasactionTableViewCell = "TrasactionCell"
     static let moreTableViewCell = "MoreCell"
     static let helpTableViewCell = "HelpCell"
     static let srTableViewCell = "SRCell"
     static let notificationTableViewCell = "NotificationCell"
     static let canIDTableViewCell = "CANIDCell"
    static let caseTypeTableViewCell = "CaseTypeCell"

   
    
}



/// This structer is used for all the Alerts Title's
struct AlertViewTitle {
    static let title_Error      =   "Error!"
    static let title_Success    =   "Success!"
    static let Logout  =   "Logout"
     static let Delete  =   "Delete"
     static let Alert  =   "Alert!"
    static let resultGenerated = "Result generated"
}

/// This structer is used for all the Alert's Button Title
struct AlertViewButtonTitle {
   
     static let title_OK = "OK"
     static let Logout  =   "Logout"
     static let Delete  =   "Delete"
     static let Cancel  =   "Cancel"
}

/// This structer is used for all the Alert messages
struct AlertViewMessage {
    
     static let internetConnection = "Please check your internet connection."
     static let pleaseTryAgain = "Please Try Again."
     static let enterCanIDForgot = "Enter your CAN ID to reset your password"
     static let enterUsernameForgot = "Enter your username to reset your password"
     static let invaliOTP = "Invalid OTP"

}

/// This structer is used for all the error messages in the app
struct ErrorMessages {
    static let wrongEmailAddress    =    "Please enter valid email."
    static let wrongPassword    =     "Password should be atleast 4 characters long."
    static let validOption    =     "Please enter valid options."
    static let yearValidation    =     "Please enter valid Year."
    static let endYearValidation    =     "End year should be greater than the start year."
    static let selectOneYear    =     "You can select maximum period of 1 year."

}
/// This structer is used for all the Mail Composer Text messages
struct MailComposerText {

}

/// This structer is used for all the Date Formats Values used in the app
struct DateFormats {
    static let isoFormat        =   "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    static let isoFormatWithOutTimeZone        =   "yyyy-MM-dd'T'HH:mm:ss"
    static let isoOutPutFormat        =    "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    static let dateOfBirth      =   "MMM dd, yyyy"
    static let dropGiftDateFormat         =   "MMM d, yyyy      hh:mm a"
    static let timeFormatOnly         =   "hh:mm a"
    static let dateFormatOnly         =   "MMMM d,yyyy"
    static let monthdateFormatOnly         =   "MM,dd"
    static let minutesFormatOnly         =   "mm"
    static let orderDateFormat         =   "dd/MM/yyyy"
    static let orderMDYDateFormat         =   "MM/dd/yyyy"
    static let orderDateFormatOutPut         =   "dd/MMM/yyyy"
    static let orderCurrentDateFormatOutPut         =   "yyyy-MM-dd"
    static let orderDateFormatResult        =   "dd-MM-yyyy"
    static let orderYearMonth = "MMMM yyyy"
}

struct faqHomeQuestion
{
    static let ques1 = "I have seen a new plan which meets my requirement, but my bill cycle is not over, can I change the plan in between?"
    static let ques2 = "How do I check my Bill?"
    static let ques3 = "How can I make the bill Payment?"
    static let ques4 = "How can I change my tariff Plan?"
    static let ques5 = "What is my due date for bill payment?"
    static let ques6 = "I need help with my router as my internet connection is not working?"
    static let ques7 = "My internet is not working, what should I do?"
    static let ques8 = "How can I Check the data consumed?"
    static let ques9 = "Is 100 GB data good to use. How can I use it?"
    static let ques10 = "What is data volume?"
    static let ques11 = "How can I check my usage?"
    static let ques12 = "how do I install Spectra FTTH (Fiber to the Home) Connection?"
    static let ques13 = "What will happen if my installation does not happen on account of wiring issues?"
    static let ques14 = "How do I check Internet speed of my Spectra Connection?"
    static let ques15 = "What documents do I need to give while applying for Spectra FTTH connection?"
    static let ques16 = "What documents can I give as Identity Proof and address Proof?"
    static let ques17 = "can I have multiple connection in my house?"
    static let ques18 = "My friend in adjacent society has Spectra connection but I do not have it in my society?"
    static let ques19 = "What is asymmetric and symmetric bandwidth?"
    static let ques20 = "What is an IP address?"
    static let ques21 = "What is static and dynamic IP address?"
    static let ques22 = "What is FTTH?"
    static let ques23 = "What is FUP?"
    static let ques24 = "I am not getting the promised speed, what do I do?"
    static let ques25 = "What are the available payment options?"
    static let ques26 = "How can I change my registered mobile number?"
    static let ques27 = "How can I change my registered e-mail id?"
    static let ques28 = "Can I transfer the ownership of my internet connection?"
    static let ques29 = "What is the procedure to shift within the society?"
    static let ques30 = "What is the procedure to shift my internet connection to a different room?"
    static let ques31 = "How do I update my alternate number?"
    static let ques32 = "I am travelling for 3 months, how can I put my connection on safe custody?"
    static let ques33 = "How long does it take to process a refund?"
    static let ques34 = "In case we’re on Wi-Fi, what are the quick checks to ensure that we get the best from your spectra internet connection?"
    static let ques35 = "What is 1 Gbps?"
    static let ques36 = "Why 1 Gbps/ or Why do I need such high speed?"
    static let ques37 = "What can I do with 1 Gbps?"
    static let ques38 = "My consumption is low. Why should I take 1 Gbps connection?"
    static let ques39 = "What all equipment ill you give? Will you give a Wi-Fi router / modem?"
    static let ques40 = "Will I get 1 Gbps?"
    static let ques41 = "Is there capping on data or is unlimited? There must be some capping!!"
    static let ques42 = "What factors could affect my speed? Or why am I not getting 1 Gbps speed? Or why am I getting only 100 MBP when my neighbor is getting 900 BPS, while we both are subscribed to 1 Gbps package?"
    static let ques43 = "How can I test the Internet speed that I’ getting at my home?"
    static let ques44 = "How do I get the most out of 1 Gbps?"
    static let ques45 = "By When will 1 Gbps come to my residence area?"
    static let ques46 = "I am a B2B customer for broadband for 100 MBPS. I see that you are now offering 1 Gbps for home. By hen can I expect this to be made available for businesses like mine?"
    static let ques47 = "Why should I choose Spectra over other providers?"
}
struct faqHomeAnswer
{
 
    static let ans1 = "Yes, you may change the plan anytime by raising a SR under ‘My SR’ menu."
    static let ans2 = "Billing of the customer is started from the first day of installation and the billing cycle is 30 days. Your bill is sent to your registered e-mail id on your bill generation date. You can also check your bill in our app under ‘Invoices’ menu."
    static let ans3 = "You can make online bill payment via credit card/debit card/Net banking by logging into your account at Spectra app under ‘Invoices’ menu."
    static let ans4 = "You can change your tariff plan by raising a SR through app under ‘My SR’ menu or contacting us on our toll-free no: 1800-121-5678 or by writing us at care@spectra.co."
    static let ans5 = "To view your due date for bill click on the 'Invoices' menu"
    static let ans6 = "Router issues may result in internet connection disruption. Rebooting the router or switching it off and on can solve the problem. Unplug your router, wait for some time and re-plug. Attempt to reconnect to internet. If the issue is still not resolved or you do not have connection issues with the router, then you may please contact our customer care at care@spectra.co for support or raise a SR under ‘My SR’ menu."
    static let ans7 = "First check the LEDs on the router – If No LED is glowing, then ensure power cable is connected to CPE and power supply is available. If power is not coming, please change the socket on different power source to verify the availability of power. If adapter is faulty, please replace with the working adapter. If only WAN LED is not glowing, ensure WAN Cable is properly connected on the WAN port of CPE. If cable is loose, plug out and plug in the WAN cable again. If still LED is not coming up, please power off device and power on after 5 sec. If the problem is still not resolved, then please write to us at care@spectra.co If WAN and LAN/Wi-Fi LEDs are glowing solid green, then If you are connected by LAN cable\n  Ensure that DHCP option is enable in your Ethernet card.\n Check TCP/IP Setting in your Device by typing in Start -> Run > ncpa.cpl and press enter.\n Radio button should be checked (Obtain an IP Address automatically & Obtain DNS server address automatically)\n  Check cable from Router LAN port to your PC / Laptop Ethernet port.\n Verify your IP with following steps: \n Click on start button in window.\n Click on run, type cmd, a window dialog box will open, type ipconfig on command prompt.\n  If you are not getting the IP address, then please write to us at care@spectra.co If you are getting the IP Address, please try to ping Default Gateway. If you are getting reply after ping command, it means your connectivity from PC to CPE is fine, If still your internet is not working please call customer care. If you are not able to ping Default Gateway, it could be due to LAN connectivity issue, please write to us at care@spectra.co"

    static let ans8 = "You can also check your account data usage in app under ‘Data usage’ menu."
    static let ans9 = "100 GB data gives you practically unlimited access for Watching 50 HD movies, or Streaming a whole month of music streaming (that’s 650 hours!), or Half a month of continuous HD video calling on Skype (that’s 320 hours!), or Thousands of hours of web browsing and thousands of e-mails."
    static let ans10 = "Data volume refers to the data allocated in a specific plan which can be used for uploads and download. We have both limited and unlimited Internet plans. Please visit www.spectra.co for plan details."
    static let ans11 = "To check your usage in app, click on 'Data Usage' menu."
    static let ans12 = "Post successful account verification, our Installation team will visit your premises within 72 hours and install the FTTH connection and give you demonstration. We support only equipment given by us."
    static let ans13 = "Our teams are well trained but sometimes we come across scenarios where wiring teams get stuck on account of choke conduit. In such cases, team will re-attempt and at the time will request for the support of your building electrician. If all these efforts fail, then the amount will be refunded to you within 4 weeks in your bank account as per details shared."
    static let ans14 = "To check the accurate speed please connect your device on the direct LAN cable. To perform a speed test, visit http://fiber.spectra.co/"
    static let ans15 = "You will need to submit the following documents along with duly filled Customer Application Form (CAF) and applicable charges (if any)\n Self-attested Photograph\n Self-attested Proof of Identity\n Self-attested Proof of Address"
   
    static let ans16 = "You can attach self-attested copy of any one of them for Proof of Address & Proof of Identity.\n Aadhaar (UID) Card\n Passport\n Voter ID Card\n  Current passbook of Post Office/PSU Bank as Proof of Address, having photo as Proof of Identity & Address.\n Photo Identity Card having address of Central Govt./PSU or State Govt./PSU only.\n Certificate of address having photo, issued by MP/MLA/Group A Gazetted Officer in letter head.\n Certificate of address with photo from Govt.\n Recognized educational institutions (for students only) Pensioner's Card having Photo with address.\n CGHS/ECHS Card Address card with photo issued by Dept. of Post, Govt. of India.\n Caste & Domicile Certificate with Photo & Address issued by State Govt.\n Freedom Fighter Card having Photo & Address.\n Certificate of address having photo issued by Village Panchayat head or equivalent authority.\n (For rural areas) Kisan Passbook having Photo with Address."

    static let ans17 = "Yes, you can have multiple connections. You may apply while taking initial connection or any time later. Multiple connections will be installed post verifying there are no dues on the existing connection."
    static let ans18 = "There can be 2 reasons for this. We may either be not present in your area or your society has not given permission to allow our connectivity. Check Internet availability in your area"
    static let ans19 = "Asymmetric bandwidth gives you different speeds for upload and download (Download like browsing, watching movies, downloading songs, etc. is usually higher than uploads like file upload, etc.). Symmetric bandwidth allows you same speeds for both upload and downloads."
    static let ans20 = "On connecting to the internet your device is automatically given IP (Internet Protocol) address to identify it to the outside world. There are 2 types of IP address – static and dynamic."
    static let ans21 = "Static IP address always remains the same. Dynamic IP address changes from session to session and is given to Business users."
    static let ans22 = "FTTH stands for Fiber-to-the-Home. This means a fiber optic line is hooked directly to your home or business. Fiber optic line uses a thin strand of glass to transmit beams of light that carry an amazing amount of data. This delivers high-speed Internet services."
    static let ans23 = "Fair Usage Policy (also known as Fair Access Policy or Bandwidth Cap) is implemented by Internet Service Providers (ISPs) where once you reach data transfer limit as per the plan opted, speed reduces to as stated in your plan and is reset as per plan at the start of your next monthly billing cycle."
    static let ans24 = "To check the accurate speed please connect your device on the direct LAN cable. To perform a speed test, Visit http://fiber.spectra.co"
    static let ans25 = "We have different modes of payment available. You can make the payment through Credit card /debit card - offline & online. Apart from this you can also make payment via Mobiwik, Paytm, Ola money, PayU Money, Airtel Money, Freecharge, Payzapp, UPI."
    static let ans26 = "You can change your registered mobile number by contacting us on our toll free no: 1800-121-5678 or by writing us at care@spectra.co. You can even do live chat on our website i.e. www.spectra.co"
    static let ans27 = "You can change your registered e-mail ID by contacting us on our toll-free no: 1800-121-5678 or by writing us at care@spectra.co . Live chat is available on our website i.e. www.spectra.co"
    static let ans28 = "Yes, you can transfer the ownership of your internet connection."
    static let ans29 = "You have to raise Service request under ‘My SR’ menu. You need to pay a charge of ₹ 500."
    static let ans30 = "You can submit a request for internal shifting in app under ‘My SR’ menu. You need to pay a charge of ₹ 250"
    static let ans31 = "You can update your alternate number by contacting us on our toll-free no: 1800-121-5678 or by writing us at care@spectra.co. Live chat is available on our website i.e. www.spectra.co"
    static let ans32 = "You can submit a request for safe custody by contacting at us on our toll-free no: 1800-121-5678 or by writing us at care@spectra.co. Live chat is available on our website i.e. www.spectra.co. You need to pay a charge of ₹ 550 for safe custody."
    static let ans33 = "It takes 30 days to process your refund into your bank account"
    static let ans34 = "100 GB data gives you practically unlimited access for Watching 50 HD movies, or Streaming a whole month of music streaming (that’s 650 hours!), or Half a month of continuous HD video calling on Skype (that’s 320 hours!), or Thousands of hours of web browsing and thousands of e-mails."
    static let ans35 = "One gigabit per second (Gbps) is equivalent to 1000 megabits per second (Mbps) internet connection. One Gbps is also called 1000 Mbps or 1 GIG. This is the fastest broadband Internet connection available in India, enabling you to browse the web and upload or download files faster than ever before."
    static let ans36 = "On an average today, a household has 4-5 devices connected to the broadband such as TVs, laptops, smartphones, tablets, printers, home security systems or gaming consoles. All these devices consume bandwidth from the same connection, which means the resulting speed and experience on each device takes a hit. If you have a high-speed connection such as 1 Gbps, multiple devices can deliver great experience simultaneously./n Another great benefit is the symmetric upload speed which other providers can’t offer. This means that not only will you be able download files and content at lightning fast speed, but all uploads will also take only second. \n With Spectra 1 Gbps, you can:\n Use multiple devices simultaneously without sacrificing speed or compromising on experience on any\n Stream movies, download videos and upload photos with virtually no buffering or waiting\n Play games online knowing you have the fastest Internet speed available\n Work from home with the greatest efficiency and reliability you can get from a home Internet connection\n Upload heavy files such as photographs, videos and work documents to the cloud in seconds.\n All these things can be done simultaneously using just one connection. So why not?"

    static let ans37 = "There is nothing that you can’t do with 1 Gbps. You can binge watch in 4K videos on multiple Smart TVs, play multiplayer online games and do HD video conferencing and all of it simultaneously.\n Download 3 MB MP3 file in less than half a second \n Download 350 MB TV episode in 3 seconds\n Download 950 MB 1080p HD TV episode in 8 seconds\n Download 15 GB 4k movie in less than 2 minutes\n Upload to cloud faster than transfer to external drive\n Online multi-player gaming without buffer"
    
    static let ans38 = "We are offering you the fastest speed with unlimited data volume at the prices that you currently pay for your existing services. At the same price, you can get much more. Also, 1 Gbps is about the speed experience more than consumption limits. Your consumption could remain the same, but speed of 1 Gbps will enhance the experience."
    static let ans39 = "We will provide you with an ONT device that terminates the fiber cable at your location. Along with this, you will receive D-Link DIR 825 AC1200 Dual Band Gigabit router that is designed to give the best experience of 1 Gbps connection. With this, you can:\n Simultaneously stream HD and 4K content on multiple devices\n Seamlessly play multiplayer online gaming\n Video call without buffer\n Backup to cloud or download software and program updates in seconds\n Set parental control on usage\n Connect to storage, printer etc. via 4 Gigabit ports and USB port\n The router comes at no additional cost with Spectra 1 Gbps package with a refundable security deposit of Rs. 2000. If you are an existing Spectra user, you can call us on 1800 121 5678 today for more details and for scheduling installation."
    
    static let ans40 = "With our 1 Gbps package, we set you up for the fastest broadband experience. The actual speed that you get depends on number of devices being used and their configuration. For best performance from your broadband package, we recommend a direct ethernet (LAN) cable connection. Minimum requirement for a laptop to deliver 1 Gbps speed:\n LAN Port 1 G\n Mother Board intel i5 (i7 recommended)\n  RAM: 8 Gb\n Processor 2.4 Ghz"

    static let ans41 = "No, the plans are truly unlimited. There is no data capping on the volume you consume. However, if you choose our limited time promotion offer of package costing Rs. 799 for six months, your data will be capped at 150 GB."
    static let ans42 = "For best performance from your 1 Gbps connection, we recommend a direct ethernet (LAN) cable connection. Internet speeds over a wired connection (Cat 5 or Cat 6 ethernet cable) are faster compared to wireless speeds.\n There are many factors that adversely impact your home Wi-Fi performance, these are:\n Types of wireless devices its processor and operating system: older phones and laptops that have older Wi-Fi protocols 802.11g, n will give you lower speed and worst still slow down the output from the router.\n Invest in a dual band 802.11AC router. With dual band technology, you can set-up 2 SSID's, one on the 2.4 GHz band for slower connection but longer range. And the less occupied 5GHz frequency band for higher speeds at a shorter distance. Your Spectra connection comes with D-Link DIR 825 1200AC at no additional cost for a refundable security deposit.\n Number of devices in use: the more the devices, the more the load on the router and the lesser the speed.\n Distance from the router: the 2.4 GHz channel gives you range but lower speeds, while the 5 GHz channel is less crowded, gives you higher speed but for shorter distances.\n Network interference in your home. In high-rise buildings, with multiple flats on the same floor, signal interference from your neighbor’s router impacts the reach and speed of your router.\n Your internet browser: Plug-ins and add-ins affect browser performance and therefore results of your speed test.\n Building materials, in-home obstructions affect signal strength.\n  Location of your Wi-Fi router and its height. do place your router in a central, elevated spot. In perhaps your living room at an ideal height of 6 Ft (like the top of a shelf of your book rack) so that furniture and other obstacles do not block its signal. Your router should also be away from sources of electrical interference such as microwaves, cordless phones and TVs."
    
    static let ans43 = "We recommend that you use: http://fiber.spectra.co"
    
    static let ans44 = "There are many factors that can adversely impact your 1 Gbps experience. In most cases, this happens when the device being used doesn’t support such high speed. Laptops fitted with a gig port support up to 1 Gbps speeds.\n The next thing to check is if your device is plugged directly into the router via an Ethernet cable versus using Wi-Fi service. A cable is the best way to experience your device's full speed. If you connect via Wi-Fi, your speed will decrease since wireless connections are slower. Wireless connections can also be adversely affected by extreme distance versus close proximity to the router as well as the number of walls or other obstacles between your device and the router.\n The last thing to check is if your router supports 1 Gbps speed. We recommend using the D-Link DIR 825 AC1200 Dual Band Gigabit router that is designed to give the best experience of 1 Gbps connection. With this, you can:\n Simultaneously stream HD and 4K content on multiple devices\n Seamlessly play multiplayer online gaming\n Video call without buffer\n Backup to cloud or download software and program updates in seconds\n Set parental control on usage\n Connect to storage, printer etc. via 4 Gigabit ports and USB port\n The router comes at no additional cost with Spectra 1 Gbps package with a refundable security deposit of Rs. 2000. If you are an existing Spectra user, you can call us on 1800 121 5678 today for more details and for scheduling installation."
   
    static let ans45 = "Thank you for your interest in our services. We are actively expanding our fiber network across major cities in the country. Our website is the best place to check availability of our services in real time."
    static let ans46 = "Thank you for your interest in our services. We are actively expanding our fiber network across major cities in the country. Our website is the best place to check availability of our services in real time."
    static let ans47 = "Thank you for your interest in our services. We are actively expanding our fiber network across major cities in the country. Our website is the best place to check availability of our services in real time.Spectra is a fiber broadband service. While other service providers oﬀer a core copper network or a LAN or coaxial cable, both of which cannot serve a reliable upload and download speed. Spectra’s 100% ﬁber network gives you an experience like never before.\n Fiber is fast. Much, much faster than copper. It is reliable, made of glass and works on light pulses. Your data transfers at the speed of light.\n Spectra is the fastest. Spectra is consistently #1 on the Netﬂix ISP leader board in India for fastest internet service.\n You get a dual band, gigabit router, D-Link DIR 825 AC 1200 which gives seamless experience for your 100 MBPS Spectra connection.\n Symmetric speed up to 100 MBPS. Same speed for upload and download. Buﬀer free gaming, video calls, social sharing and cloud backup.\n We are there for you 24X7. Call for support at 1800 121 5678 or email us at care@spectra.co"
}

struct faqBusinessQuestion
{
    static let ques1 = "I have seen a new plan which meets my requirement, but my bill cycle is not over, can I change the plan in between?"
    static let ques2 = "How can I view my bill/bill amount in App?"
    static let ques3 = "What is my due date for bill payment?"
    static let ques4 = "How can I change my tariff plan?"
    static let ques5 = "I am not getting the promised speed, what do I do?"
    static let ques6 = "What is FUP?"
    static let ques7 = "is 100 GB data good to use. How can I use it?"
    static let ques8 = "What is asymmetric and symmetric bandwidth?"
    static let ques9 = "What is an IP address?"
    static let ques10 = "I am not getting the promised speed, what do I do?"
    static let ques11 = "What is static and dynamic IP address?"
    static let ques12 = "How can I change my registered mobile number?"
    static let ques13 = "How can I change my registered email id?"
    static let ques14 = "Can I transfer the ownership of my internet connection?"
    static let ques15 = "What is the procedure to shift within the building?"
    static let ques16 = "What is the procedure to shift my internet connection to a different room?"
    static let ques17 = "I am travelling for 3 months, how can I put my connection on safe custody?"
    static let ques18 = "What are the available payment options?"
    static let ques19 = "How can I check my usage?"
    static let ques20 = "How long does it take to process a refund?"
}
struct faqBusinessAnswer
{

    static let ans1 = "Yes, you can change the plan in between the bill cycle. You can contact your relationship manager."
    static let ans2 = "To view your bill, click on ‘Invoices' menu."
    static let ans3 = "To view due date of your bill click on 'Invoices' option."
    static let ans4 = "You can change plan by writing us at support@spectra.co or contact your relationship manager."
    static let ans5 = "You need to check the speed on direct LAN cable connectivity. To perform a speed test refer to fiber.spectra.co or you may contact your relationship manager."
    static let ans6 = "Fair Usage Policy (also known as Fair Access Policy or Bandwidth Cap) is implemented by Internet Service Providers (ISPs) where once you reach data transfer limit as per the plan opted, speed reduces to as stated in your plan and is reset as per plan at the start of your next monthly billing cycle."
    static let ans7 = "100 GB data gives you practically unlimited access for Watching 50 HD movies, or Streaming a whole month of music streaming (that’s 650 hours!), or Half a month of continuous HD video calling on Skype (that’s 320 hours!), or Thousands of hours of web browsing and thousands of emails."
    static let ans8 = "Asymmetric bandwidth gives you different speeds for upload and download (Download like browsing, watching movies, downloading songs, etc. is usually higher than uploads like file upload, etc.). Symmetric bandwidth allows you the same speed for both upload and download."
    static let ans9 = "On connecting to the internet your device is automatically given IP (Internet Protocol) address to identify it to the outside world. There are two types of IP address – Static and dynamic."
    static let ans10 = "You need to check the speed on direct LAN cable connectivity. To perform a speed test refer to fiber.spectra.co or you may contact your relationship manager."
    static let ans11 = "Static IP address remains the same while Dynamic IP address changes from session to session and is given to Business users."
    static let ans12 = "You can change your registered mobile number by writing us at support@spectra.co from your registered email id."
    static let ans13 = "ou can change your registered email id by writing us at support@spectra.co from your registered email id."
    static let ans14 = "Yes, you can transfer the ownership of your internet connection."
    static let ans15 = "You can contact your relationship manager for submit the required documents. Charges will be informed by relationship manager."
    static let ans16 = "You can submit a request for internal shifting by writing us at support@spectra.co. Your relationship manager will inform about the charges applicable."
    static let ans17 = "You can submit a request for safe custody by writing us at support@spectra.co . Your outstanding needs to be cleared."
    static let ans18 = "Customer can make payment through app by using Debit card, Credit card, UPI or Netbanking."
    static let ans19 = "To check your account data usage in app under ‘Data usage’ menu."
    static let ans20 = "It takes 21 days post device recovery to process your refund into your bank account."
}
struct profileUserB2B {
        static let userNameD = "Company Name"
        static let userIdD = "Can ID"
        static let billingAddD = "Billing Address"
        static let BillingContD = "Billing Contact"
        static let techContD = "Technical Contact"
        static let userPhotoStatusD = "Change Profile Picture  "
        static let userPhotoStatusDEmpty = "Upload Profile Picture "

}
struct profileUserB2C {
    static let userNameD = "User Name"
    static let userIdD = "Mobile No"
    static let billingAddD = ""
    static let BillingContD = ""
    static let techContD = ""
    static let userPhotoStatusDEmpty = "Upload Profile Picture "
    static let userPhotoStatusD = "Change Profile Picture "

}
struct segment {
    static let userB2C = "Home1"
}
struct profilePictureUpload {
    static let ifImageNotUploadText = "Upload Profile Picture"
    static let UploadedImageText = "Change Profile Picture"
}

struct dummyUsingHome
{
    
   static let dummyLable = "Label hdfk hjdkfhdfs hdfkldfs hdfjklhdl dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx nb,cxbcvx hbn,cmbncv nc,cx nb,cmnbcv ,nb,cv dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx yryrtybh hghgg hfhff hfhfhf fhfhgf hff ffh hfff  "
      static let menuDummyLable = "Label hdfk hjdkfhdfs hdfkldfs hdfjklhdl dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx nb,cxbcvx hbn,cmbncv nc,cx nb,cmnbcv ,nb,cv dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx yryrtybh hghgg hfhff hfhfhf fhfhgf hff ffh hfff Label hdfk hjdkfhdfs hdfkldfs hdfjklhdl dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx nb,cxbcvx hbn,cmbncv nc,cx nb,cmnbcv ,nb,cv dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx yryrtybh hghgg hfhff hfhfhf fhfhgf hff ffh hfff Label hdfk hjdkfhdfs hdfkldfs hdfjklhdl dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx nb,cxbcvx  bnjkn,cvx nb,cxbcvx "
    static let iphone8PlusmenuDummy = "Label hdfk hjdkfhdfs hdfkldfs hdfjklhdl dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx nb,cxbcvx hbn,cmbncv nc,cx nb,cmnbcv ,nb,cv dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx yryrtybh hghgg hfhff hfhfhf fhfhgf hff ffh hfff Label hdfk hjdkfhdfs hdfkldfs hdfjklhdl dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx nb,cxbcvx hbn,cmbncv nc,cx nb,cmnbcv ,nb,cv dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx yryrtybh hghgg hfhff hfhfhf fhfhgf hff ffh hfff Label hdfk hjdkfhdfs hdfkldfs hdfjklhdl dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx nb,cxbcvx  bnjkn,cvx nb,cxbcvx  hjdkfhdfs hdfkldfs hdfjklhdl dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx nb,cxbcvx  bnjkn,cvx nb,cxbcvx"
    static let iphone5PlusmenuDummy = "Label hdfk hjdkfhdfs hdfkldfs hdfjklhdl dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx nb,cxbcvx hbn,cmbncv nc,cx nb,cmnbcv ,nb,cv dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx yryrtybh hghgg hfhff hfhfhf fhfhgf hff ffh hfff Label hdfk hjdkfhdfs hdfkldfs hdfjklhdl dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx nb,cxbcvx hbn,cmbncv nc,cx nb,cmnbcv ,nb,cv dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx hbjkvbhvcx bnjkn,cvx yryrtybh hghgg hfhff hfhfhf fhfhgf hff ffh hfff Label hdfk hjdkfhdfs"


     static let menuDummyLable1 = "Label hdfk hjdkfhdfs hdfkldfs hdfjklhdl dfkljghfdlk hjkdfhvbdf hjklbhfxc hbjklbhcx hbjkvbhvcx"
}

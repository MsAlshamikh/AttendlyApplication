//
//  ProfileVC.swift
//  AttendlyApp
//
//  Created by Yumna Almalki on 15/02/1444 AH.
//

import UIKit
import AudioToolbox
import CodableFirebase
import Firebase
import MessageUI

class LecturerProfileVC: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var coleLabel: UILabel!
    @IBOutlet weak var depLabel: UILabel!
    let firestore = Firestore.firestore()
   // @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var MyProfile: UILabel!
    
    
    @IBOutlet weak var logoutnow: UIButton!
    
    @IBOutlet weak var titleLable: UILabel!
    var lecturerID : String?
    
    var user : User! {
        didSet {
            updateUI(for: user)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        course()
    }
    @IBAction func viewProfile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "timetable2") as! ViewController3
          navigationController?.pushViewController( vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //cehck if lecturer id is present
        if let lecturerID = lecturerID {
            loadProfile(letctrerID: lecturerID)
            setUIForOtherlecturerProfile()
        } else {
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            loadProfile(letctrerID: uid)
//            let logoutBarButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(meout(_:)))
//            self.navigationItem.rightBarButtonItem = logoutBarButton
print("hh")
        }
        
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    func course(){
        let db = Firestore.firestore()
        Task{
            let snapshot =  try await db.collection("Lectures").whereField("EmailLectures", isEqualTo: "1232@lecture.ksu.edu.sa").getDocuments()
            
//            let sectsChk = snapshot.documents.first!.get("Sections") as! [String]
//            let actualChk = snapshot.documents.first!.get("courses") as! [String]
            
          //  guard let sectsChk = snapshot.documents.first?.get("Sections") as? [String] else { return }
            let sectsChk = snapshot.documents.first!.get("AllsectionID") as! [String]
            let actualChk = snapshot.documents.first!.get("courses") as! [String]
            print("sectsChk",sectsChk)
            print("actualChk",actualChk)
            
              if((actualChk.count == 1 && actualChk[0] == "" ) || (sectsChk.count == 1 && sectsChk[0] == "" ) )
                {
                //    self.noC.text = "No courses \n registered!"
                }
                else{
                    for i in 0..<sectsChk.count {
                      
                        print("sectsChk is i ",sectsChk[i])
                      //..
                        let sectss = try await db.collection("Sections").whereField("section", isEqualTo: sectsChk[i]).getDocuments()
                       
                      //  let  section =  sectss.documents.first!.get("section") as! String
                       // print("section",section)
                        var cdate =  sectss.documents.first!.get("courseDate") as! [String: String]
                        print("cdate",cdate)
                        for (key,value) in cdate {

                            if key == "1"
                            {
                                //no 0
                                if value == "8:00"
                                {Global.shared.Sunday[1] = actualChk[i]}
                                else if value == "9:15"
                                {Global.shared.Sunday[2] = actualChk[i]}
                                else if value == "10:30"
                                {Global.shared.Sunday[3] = actualChk[i]}
                                else if value == "11:45"
                                {Global.shared.Sunday[4] = actualChk[i]}
                                else if value == "12:50"
                                {Global.shared.Sunday[5] = actualChk[i]}
                                else if value == "1:30"
                                {Global.shared.Sunday[6] = actualChk[i]}
                                else if value == "2:45"
                                {Global.shared.Sunday[7] = actualChk[i]}
                                else if value == "3:50"
                                {Global.shared.Sunday[8] = actualChk[i]}
                                else if value == "4:45"
                                {Global.shared.Sunday[9] = actualChk[i]}
                                else{}

                            }
                            else if  key == "2"
                            {
                                //no 0
                                if value == "8:00"
                                {Global.shared.Monday[1] = actualChk[i]}
                                else if value == "9:15"
                                {Global.shared.Monday[2] = actualChk[i]}
                                else if value == "10:30"
                                {Global.shared.Monday[3] = actualChk[i]}
                                else if value == "11:45"
                                {Global.shared.Monday[4] = actualChk[i]}
                                else if value == "12:50"
                                {Global.shared.Monday[5] = actualChk[i]}
                                else if value == "1:30"
                                {Global.shared.Monday[6] = actualChk[i]}
                                else if value == "2:45"
                                {Global.shared.Monday[7] = actualChk[i]}
                                else if value == "3:50"
                                {Global.shared.Monday[8] = actualChk[i]}
                                else if value == "4:45"
                                {Global.shared.Monday[9] = actualChk[i]}
                                else{}
                            }
                            else if  key == "3"
                            {
                                //no 0
                                if value == "8:00"
                                {Global.shared.Tuesday[1] = actualChk[i]}
                                else if value == "9:15"
                                {Global.shared.Tuesday[2] = actualChk[i]}
                                else if value == "10:30"
                                {Global.shared.Tuesday[3] = actualChk[i]}
                                else if value == "11:45"
                                {Global.shared.Tuesday[4] = actualChk[i]}
                                else if value == "12:50"
                                {Global.shared.Tuesday[5] = actualChk[i]}
                                else if value == "1:30"
                                {Global.shared.Tuesday[6] = actualChk[i]}
                                else if value == "2:45"
                                {Global.shared.Tuesday[7] = actualChk[i]}
                                else if value == "3:50"
                                {Global.shared.Tuesday[8] = actualChk[i]}
                                else if value == "4:45"
                                {Global.shared.Tuesday[9] = actualChk[i]}
                                else{}
                            }
                            else if  key == "4"
                            {
                                //no 0
                                if value == "8:00"
                                {Global.shared.Wednesday[1] = actualChk[i]}
                                else if value == "9:15"
                                {Global.shared.Wednesday[2] = actualChk[i]}
                                else if value == "10:30"
                                {Global.shared.Wednesday[3] = actualChk[i]}
                                else if value == "11:45"
                                {Global.shared.Wednesday[4] = actualChk[i]}
                                else if value == "12:50"
                                {Global.shared.Wednesday[5] = actualChk[i]}
                                else if value == "1:30"
                                {Global.shared.Wednesday[6] = actualChk[i]}
                                else if value == "2:45"
                                {Global.shared.Wednesday[7] = actualChk[i]}
                                else if value == "3:50"
                                {Global.shared.Wednesday[8] = actualChk[i]}
                                else if value == "4:45"
                                {Global.shared.Wednesday[9] = actualChk[i]}
                                else{}
                            }
                            else if  key == "5"
                            {
                                //no 0
                                if value == "8:00"
                                {Global.shared.Thursday[1] = actualChk[i]}
                                else if value == "9:15"
                                {Global.shared.Thursday[2] = actualChk[i]}
                                else if value == "10:30"
                                {Global.shared.Thursday[3] = actualChk[i]}
                                else if value == "11:45"
                                {Global.shared.Thursday[4] = actualChk[i]}
                                else if value == "12:50"
                                {Global.shared.Thursday[5] = actualChk[i]}
                                else if value == "1:30"
                                {Global.shared.Thursday[6] = actualChk[i]}
                                else if value == "2:45"
                                {Global.shared.Thursday[7] = actualChk[i]}
                                else if value == "3:50"
                                {Global.shared.Thursday[8] = actualChk[i]}
                                else if value == "4:45"
                                {Global.shared.Thursday[9] = actualChk[i]}
                                else{}
                            }
                        }
                    }
                }}
    }
    
    @IBAction func logggoutt(_ sender: Any) {
        print("pressed")
              let alert = UIAlertController(title: "Alert", message: "Are you Sure You want to Logout", preferredStyle: .alert)

               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

              do{



                     try Auth.auth().signOut()

                  

                  print("logout!")

                 self.performSegue(withIdentifier: "logo2", sender: self)

                  } //do

               

               catch let signOutError as NSError{

                   print("error",signOutError)

                }

                      

               }))

                  alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:nil))

                       self.present(alert, animated: true, completion: nil)

            //   self.performSegue(withIdentifier: "logo2", sender: self)
    }
    
    func setUIForOtherlecturerProfile () {
      //logoutButton.isHidden = true
        logoutnow.isHidden = true
        MyProfile.isHidden = true 
      //  sendEmail.isHidden = true
        titleLable.text = "Lecturer Profile"
        
//   let emailBarButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(emailButtonTouched(_:)))
        let emailBarButton = UIBarButtonItem(
            image : UIImage (systemName: "envelope" ),style: .plain, target: self, action: #selector(emailButtonTouched(_:)))
        
//        let emailBarButton = UIBarButtonItem(image: UIImage(named: "message.and.waveform.fill"), style: .plain, target: self, action:#selector(emailButtonTouched(_:)))

        
        self.navigationItem.rightBarButtonItem = emailBarButton
    }
    
    func updateUI(for user:User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        coleLabel.text = user.college
        depLabel.text = user.department
    }
    
    func loadProfile(letctrerID lid:String) {
        firestore.collection("Users").document(lid).getDocument { document, error in
            guard let doc = document, let userData  = doc.data() else {
                //Inform user that there no document asscisated with the uid he have priovided
                print("Error loadin user profile", error?.localizedDescription ?? "Unknown Error")
                return
            }
            self.user = try! FirebaseDecoder().decode(User.self, from: userData)
        }
    }
    
//    @IBAction func meout(_ sender: UIButton) {
//        do{
//            try Auth.auth().signOut()
//            print("logout!")
//        }catch let signOutError as NSError{
//            print("error",signOutError)
//        }
//        self.performSegue(withIdentifier: "logo2", sender: self)
//    }
    
    
    @objc func emailButtonTouched(_ sender:UIBarButtonItem) {
        guard let lecturer = user else {return}
        
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients([lecturer.email])
            self.present(mailVC, animated:true)
        }
    }
}

extension LecturerProfileVC : MFMailComposeViewControllerDelegate  {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            print("Mail sending error", error.localizedDescription)
            controller.dismiss(animated: true)
        } else {
            controller.dismiss(animated: true)
            //SHOW and alert that mail was sent
        }
    }
}

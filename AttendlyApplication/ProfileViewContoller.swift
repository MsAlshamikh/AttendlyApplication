//
//  profileController.swift
//  AttendlyApp
//
//  Created by Amani Aldahmash on 11/09/2022.
//

import UIKit
import AudioToolbox
import CodableFirebase
import Firebase
import MessageUI

class ProfileViewContoller: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sid: UILabel!
    @IBOutlet weak var majorlabel: UILabel!
    @IBOutlet weak var avlabel: UILabel!
    @IBOutlet weak var looggg: UIButton!
    
    let firestore = Firestore.firestore()
    
    var student : User! {
        didSet {
            updateUI(forStudent: student)
        }
    }
    
    var adviser : User! {
        didSet {
            updateUI(forAdviser: adviser)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for  schedule:
        course()
        //
        //loadProfile()
        let tg = UITapGestureRecognizer(target: self, action: #selector(adviserNameTapped(_:)))
        avlabel.isUserInteractionEnabled = true
        avlabel.addGestureRecognizer(tg)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadProfile()
    }
    
    func course(){
        let db = Firestore.firestore()
        Task{
            let snapshot =  try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: "400@student.ksu.edu.sa").getDocuments()
            
//            let sectsChk = snapshot.documents.first!.get("Sections") as! [String]
//            let actualChk = snapshot.documents.first!.get("courses") as! [String]
            
          //  guard let sectsChk = snapshot.documents.first?.get("Sections") as? [String] else { return }
            let sectsChk = snapshot.documents.first!.get("Sections") as! [String]
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
    

    
    func updateUI(forStudent user:User) {
        //TODO: Update this data to your IBOutlets
        print("User", user.name, user.email)
        
        nameLabel.text = user.name
        emailLabel.text = user.email
        sid.text = user.sid
        majorlabel.text = user.major
        //avlabel.text = user.advn
    }
    
    func loadProfile() {
        guard let uid = Auth.auth().currentUser?.uid else {
            //TODO: inform user that he is not logged in any more and then take him to login page
            return
        }
        firestore.collection("Users").document(uid).getDocument { document, error in
            guard let doc = document, let userData  = doc.data() else {
                //Inform user that there no document asscisated with the uid he have priovided
                print("Error loadin user profile", error?.localizedDescription ?? "Unknown Error")
                return
            }
            do {
                self.student = try FirebaseDecoder().decode(User.self, from: userData)
                if let aid = self.student.adviserID {
                    self.loadAdviserFor(adviserId: aid)
                }
                
            } catch {
                print("ERROR: User Decode", error.localizedDescription)
            }
        }
    }
    
    func loadAdviserFor(adviserId:String) {
        firestore.collection("Users").document(adviserId).getDocument(completion: { document, error in
            guard let doc = document, let userData  = doc.data() else {
                //Inform user that there no document asscisated with the uid he have priovided
                print("Error loadin adviser profile", error?.localizedDescription ?? "Unknown Error")
                return
            }
            do {
                self.adviser = try FirebaseDecoder().decode(User.self, from: userData)
            } catch {
                print("ERROR: Adviser Decode", error.localizedDescription)
            }
        })
    }
    
    func updateUI(forAdviser adviser:User) {
        let underlineAttribute = NSAttributedString(string: adviser.name, attributes: [NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue])
        avlabel.attributedText = underlineAttribute
    }
    
//    @IBAction func loUGout(_ sender: UIButton) {
//        do{
//            try Auth.auth().signOut()
//            print("logout!")
//        }catch let signOutError as NSError{
//            print("error",signOutError)
//        }
//        self.performSegue(withIdentifier: "logo2", sender: self)
//    }
    @IBAction func logggouuuu(_ sender: Any) {
        print("pressed")
            
              let alert = UIAlertController(title: "Alert", message: "Are you Sure You want to Logout", preferredStyle: .alert)

               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

              do{

                  

                     try Auth.auth().signOut()

                  

                  print("logout!")

                 self.performSegue(withIdentifier: "logo", sender: self)

                  } //do

               

               catch let signOutError as NSError{

                   print("error",signOutError)

                }

                      

               }))

                  alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:nil))

                       self.present(alert, animated: true, completion: nil)

            //   self.performSegue(withIdentifier: "logo2", sender: self)
    }
    
    @objc func adviserNameTapped(_ sender:UITapGestureRecognizer) {
        guard let adviser = adviser else {return}
        
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients([adviser.email])
            self.present(mailVC, animated:true)
        }
    }
}

extension ProfileViewContoller : MFMailComposeViewControllerDelegate  {
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

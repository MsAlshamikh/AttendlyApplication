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
    
    @IBAction func loUGout(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            print("logout!")
        }catch let signOutError as NSError{
            print("error",signOutError)
        }
        self.performSegue(withIdentifier: "logo2", sender: self)
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

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


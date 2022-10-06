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
    @IBOutlet weak var logoutButton: UIButton!
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
            let logoutBarButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(meout(_:)))
            self.navigationItem.rightBarButtonItem = logoutBarButton

        }
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setUIForOtherlecturerProfile () {
        logoutButton.isHidden = true
        titleLable.text = "Lecturer Profile"
        
        let emailBarButton = UIBarButtonItem( image : UIImage (systemName: "message" ),style: .plain, target: self, action: #selector(emailButtonTouched(_:)))
        
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
    
    @IBAction func meout(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            print("logout!")
        }catch let signOutError as NSError{
            print("error",signOutError)
        }
        self.performSegue(withIdentifier: "logo2", sender: self)
    }
    
    
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


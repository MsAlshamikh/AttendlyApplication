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


class ProfileVC: UIViewController {
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var coleLabel: UILabel!
    @IBOutlet weak var depLabel: UILabel!
    let firestore = Firestore.firestore()
    
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
        
        loadProfile()
    }
    
    func updateUI(for user:User) {
        //TODO: Update this data to your IBOutlets
        print("User", user.name, user.email)
        
        nameLabel.text = user.name
        emailLabel.text = user.email
        coleLabel.text = user.college
        depLabel.text = user.department
    }
    
    
    func loadProfile() {
        guard let uid = Auth.auth().currentUser?.uid else {
            //TODO: inform user that he is not logged in any more and then take him to login page
            return
        }
        firestore.collection("Users").document(uid).getDocument { document, error in
            guard let doc = document, let userData  = document?.data() else {
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
        
        
    }


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


class ProfileViewContoller: UIViewController {
    @IBOutlet weak var emailLabel: UILabel!
    let firestore = Firestore.firestore()
    
    var user : User! {
        didSet {
            updateUI(for: user)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        //loadProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadProfile()
    }
    
    func updateUI(for user:User) {
        //TODO: Update this data to your IBOutlets
        print("User", user.name, user.email)
        
        //nameLabel.text = user.name
        emailLabel.text = user.email
        
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
    
    @IBAction func loUGout(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            print("logout!")
        }catch let signOutError as NSError{
            print("error",signOutError)
        }
        self.performSegue(withIdentifier: "logo2", sender: self)
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



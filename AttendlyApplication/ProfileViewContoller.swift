//
//  profileController.swift
//  AttendlyApp
//
//  Created by Amani Aldahmash on 11/09/2022.
//

import UIKit
import AudioToolbox
import Firebase


class ProfileViewContoller: UIViewController {
    let firestore = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        //loadProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadProfile()
    }
    
    func loadProfile() {
        guard let uid = Auth.auth().currentUser?.uid else {
            //TODO: inform user that he is not logged in any more and then take him to login page
            return
        }
        
        print("UID = ", uid)
        
        //PLEASE KEEP THIS CODE WE WILL FIGURE THIS LATER
//        firestore.collection("users").document(uid).getDocument { document, error in
//            guard let document = document else {
//                //Inform user that there no document asscisated with the uid he have priovided
//                print("Error loadin user profile", error?.localizedDescription ?? "Unknown Error")
//                return
//            }
//
//            print (document.exists, document.data())
//
//        }
        
        
        firestore.collection("users").whereField("userID", isEqualTo: uid).getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error loadin user profile", error?.localizedDescription ?? "Unknown Error")
                return
            }
            
            print(documents.last?.exists, documents.last?.data())
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



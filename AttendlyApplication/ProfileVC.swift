//
//  ProfileVC.swift
//  AttendlyApp
//
//  Created by Yumna Almalki on 15/02/1444 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileVC: UIViewController {
    var messages : String = "" 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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


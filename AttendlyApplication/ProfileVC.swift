//
//  ProfileVC.swift
//  AttendlyApp
//
//  Created by Yumna Almalki on 15/02/1444 AH.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore



class ProfileVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func meout(_ sender: Any) {
   
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
        
        
    }

    



    
    
   
    


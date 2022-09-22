//
//  profileController.swift
//  AttendlyApp
//
//  Created by Amani Aldahmash on 11/09/2022.
//

import UIKit

import FirebaseAuth

class profileContoller: UIViewController {


//
    //@IBAction func loUGout(_ sender: Any) {

   // @IBAction func loUGout(_ sender: UIButton) {
    
    override func viewDidLoad() {
        super.viewDidLoad()
   //  navigationController.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sname(_ sender: Any) {
    }
    
    @IBAction func semail(_ sender: Any) {
    }
    
    @IBAction func sid(_ sender: Any) {
    }
    
    
    @IBAction func sadv(_ sender: Any) {
    }
    
    
    @IBAction func loUGout(_ sender: UIButton) {
    
    // @IBAction func loUGout(_ sender: UIBarButtonItem) {
    
    do{
            try Auth.auth().signOut()
        print("logout!")
        }catch let signOutError as NSError{
        print("error",signOutError)
        }
   

    self.performSegue(withIdentifier: "logo", sender: self)

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



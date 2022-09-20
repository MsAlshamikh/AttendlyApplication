//
//  listOfstudent.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 24/02/1444 AH.
//



//listOfstudent:

import UIKit
import FirebaseFirestore

class listOfstudent: UIViewController {

    
    @IBOutlet weak var list: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        list.delegate =  self
        list.delegate = self
        
        
    }
        
}
    
    extension listOfstudent: UITableViewDelegate{
       // func tableview()
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("yes")
        }
    }
    
    extension listOfstudent : UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath)
            return cell
        }
    }
    
  //  func tableview( _tableVie: UITableView, cellForRowAt indexpath: IndexPath) -> UI{
        
    
    
        

        
        

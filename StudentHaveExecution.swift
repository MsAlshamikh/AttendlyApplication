//
//  StudentHaveExecution.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 19/03/1444 AH.
//

import UIKit

import FirebaseFirestore

class StudentHaveExecution: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    
   
    @IBOutlet weak var nameSection: UILabel!
    @IBOutlet weak var noStudent: UILabel!
    
    var sectionNmae: String = ""
    
    var all = ["hi" , "hello" ]
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        print("new pahe statrt")
        super.viewDidLoad()
        noStudent.isHidden = true
        nameSection.text = sectionNmae

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let my = tableView.dequeueReusableCell(withIdentifier: "cell") as! studentHave
      
        my.nameSt.text = all[indexPath.row]
        return my 
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  all.count
    }
   

}

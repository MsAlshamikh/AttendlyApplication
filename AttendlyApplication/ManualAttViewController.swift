//
//  ManualAttViewController.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 01/03/1444 AH.
//

import Firebase
import UIKit

class ManualAttViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableview: UITableView!
    
    
    var nameStudent = [String]()
  //  var emailStudent = [String]()
    var stateSt = [String]()
    var emailSt = [String]()
    var v: String = ""
    var networking: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //  nostudent.isHidden = true

        print("what pressed is ")
        print(v)
        print("name of student")
        print(nameStudent)
        if ( nameStudent.count == 0 )
        {
      //      nostudent.isHidden = false
            
            print("no student")
        }
        tableview.delegate = self
        tableview.dataSource = self
        //tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 50
        tableview.rowHeight = 50
       // navigationController?.navigationItem.title = "ss"
        
        
     let text1 = NSMutableAttributedString()
       text1.append(NSAttributedString(string: ""
                                  ));
        text1.append(NSAttributedString(string: v));
      //  nameSection.attributedText = text1
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        let state = stateSt[indexPath.row]
        
    
        
        if state == "absent" {
            
            if networking {
                return
            }
            let email = emailSt[indexPath.row]
            
            
            
            let date = Date()
            let calunder = Calendar.current
            let day = calunder.component(.day , from: date)
            let month = calunder.component(.month , from: date)
            let year = calunder.component(.year , from: date)
            let thed = "\(day)-\(month)-\(year)"
            Task {
               
                let db = Firestore.firestore()
                
                networking = true
                guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }
                
                guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments().documents.first?.documentID else { return }
                
                try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": "attend"], merge: true)
                
                print("done")
                stateSt[indexPath.row] = "attend"
                tableView.reloadData()
                networking = false
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("enter")
        return nameStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("s")
        let my = tableView.dequeueReusableCell(withIdentifier: "cll") as! customAttendTable
      //  my?.textLabel?.text = nameStudent[indexPath.row]
    //my?.imageView?.image = UIImage(named: "girl")
        
        
//        my.nostudent.text = nameStudent[indexPath.row]
//        my.idStu.text = idStudent[indexPath.row]
//        my.person.image = UIImage(named: "girl" )
        my.state.text =  nameStudent[indexPath.row]
        my.name.text = stateSt[indexPath.row]
      
        
        
    
        
      

        
    

        return my
    }
    
    
}

//
//  StudentHaveExecution.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 19/03/1444 AH.
//

import UIKit

import FirebaseFirestore

class StudentHaveExecution: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    var statexceution = [String]()
    var  nameAll = [String]()
    var idAll = [String]()
  
    var  FormStateAll = [String]()
   
    @IBOutlet weak var nameSection: UILabel!
    @IBOutlet weak var noStudent: UILabel!
    
    var sectionNmae: String = ""
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        print("new pahe statrt")
        super.viewDidLoad()
        navigationItem.title = "Student in list"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = 80
        
        noStudent.isHidden = true
        nameSection.text = sectionNmae
        
        
      //  var  fullNameCourse = String.self
        
        let db = Firestore.firestore()
       Task {
         
           let t_snapshot = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: sectionNmae).whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments()
           
         //   let st = t_snapshot.documents.first?.data()["st"] as! String
            
       //     print("st is :" , st)
            for doc in t_snapshot.documents {
                let documentID = doc.documentID
                
                let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").getDocuments()
            
                
                for studentDoc in snp.documents {
                   
                    guard let FormState = studentDoc.get("FormState") as? String else { continue }

                    print("formState of student/",FormState)
                    
                   
                    guard let name  = studentDoc.get("name") as? String else { continue }

                    print("name of student have exec/",name)
                   
                    guard let id  = studentDoc.get("id") as? String else { continue }

                    print("id of student have exec/",id)
                    
                  
                    guard let st  = doc.get("st") as? String else { continue }

                    print("st is222222 :" , st)
                    
//                    stateAll.append(state)
//                    dateAll.append(st)
//                    timeAll.append(time)
                    
                    nameAll.append(name)
                   FormStateAll.append(FormState)
                    idAll.append(st)
                    self.tableView.reloadData()
                }
                
                
            }
            
            
            
        }

    }
    
    @objc func didTapCellButton(sender: UIButton) {
        
        let tag = sender.tag
        let dateispreesed = idAll[tag]
        let namepressed = nameAll[tag]
        print("wiich is now press?? number of row",tag)
        print("wiich is now press?? dateispreesed",dateispreesed)
        print("wiich is now press?? name",dateispreesed)
        
        let stude = storyboard?.instantiateViewController(withIdentifier: "LectureViewEXViewController") as! LectureViewEXViewController
//        stude.Takesection = WhatPressed
//        stude.datePreesed = dateispreesed
//        print("whatpressed ???" , WhatPressed)
        stude.datePreesed = dateispreesed
        stude.namepressed = namepressed
        stude.sectionNmae = sectionNmae
        navigationController?.pushViewController(stude, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let my = tableView.dequeueReusableCell(withIdentifier: "cell") as! studentHave
      
      //  my.nameSt.text = all[indexPath.row]
        my.nameSt.text = nameAll[indexPath.row]
        my.idSt.text = idAll[indexPath.row]
        my.StateExec.text = FormStateAll[indexPath.row]
        my.imageExec.image = UIImage(named: "repor")
        my.viewExec.tag = indexPath.row
        
        my.viewExec.addTarget(self, action: #selector(didTapCellButton(sender:)),for: .touchUpInside)
        return my 
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameAll.count
    }
   

}

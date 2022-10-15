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
    
    var all = ["hi" , "hello" ]
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        print("new pahe statrt")
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
      //  tableView.estimatedRowHeight = 50
      //  tableView.rowHeight = 50
        
        noStudent.isHidden = true
        nameSection.text = sectionNmae
        let db = Firestore.firestore()
       Task {
         
           let t_snapshot = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: sectionNmae).whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments()
           
         //   let st = t_snapshot.documents.first?.data()["st"] as! String
            
       //     print("st is :" , st)
            for doc in t_snapshot.documents {
                let documentID = doc.documentID
                
                let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").getDocuments()
                print(snp.documents.count)
            //      let st = t_snapshot.documents.first?.data()["st"] as! String
                
                guard let st  = doc.get("st") as? String else { continue }

                print("st is :" , st)
                for studentDoc in snp.documents {
                    
                    
                    guard let name  = studentDoc.get("name") as? String else { continue }

                    print("name of student have exec/",name)
                   
                    guard let id  = studentDoc.get("id") as? String else { continue }

                    print("id of student have exec/",id)
                    
                    guard let FormState = studentDoc.get("FormState") as? String else { continue }

                    print("time of student/",FormState)
                    
                    
//                    stateAll.append(state)
//                    dateAll.append(st)
//                    timeAll.append(time)
                    
                    nameAll.append(name)
                   FormStateAll.append(FormState)
                    idAll.append(id)
                    self.tableView.reloadData()
                }
                
                
            }
            
            
            
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let my = tableView.dequeueReusableCell(withIdentifier: "cell") as! studentHave
      
      //  my.nameSt.text = all[indexPath.row]
        my.nameSt.text = nameAll[indexPath.row]
        my.idSt.text = idAll[indexPath.row]
        my.StateExec.text = FormStateAll[indexPath.row]
        my.imageExec.image = UIImage(named: "repor")
        return my 
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameAll.count
    }
   

}

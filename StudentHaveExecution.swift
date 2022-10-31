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
    var serialAll = [String]()
    var popTwice: Bool?
   
    @IBOutlet weak var nameSection: UILabel!
    @IBOutlet weak var noStudent: UILabel!
    @IBOutlet weak var noStudentsFoundLabel: UILabel!
    
   // var sectionNmae: String = ""
    
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Data structure to hold student information for the Table View
    var tableData = [(String, String, String, String)]()
    var filteredTableData = [(String, String, String, String)]()
    
    let refreshControl = UIRefreshControl()


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            print("back")
            
            if let popTwice = popTwice, popTwice == true {
                print("pop twice")
                self.navigationController?.popViewController(animated: true)
            }
        }
       ///here is tryum
        ///
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var  nameAll = [String]()
//        var idAll = [String]()
//
//        var  FormStateAll = [String]()
//        var serialAll = [String]()
        
//        nameAll.enumerated().forEach { index, name in
//            tableData.append((name, idAll[index], serialAll[index], FormStateAll[index]))
//        }
//        self.filteredTableData = tableData
        
        searchBar.delegate = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           tableView.addSubview(refreshControl)
        
        navigationItem.title = "Student excuses"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = 80
        
        noStudent.isHidden = true
        nameSection.text =  Global.shared.sectionName
        noStudentsFoundLabel.isHidden = true
        let db = Firestore.firestore()
       Task {
         
           let t_snapshot = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo:  Global.shared.sectionName).whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments()
           
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
                    
                    guard let SerialNum = studentDoc.get("SerialNum") as? String else { continue }

                    print("st is222222 :" , st, name)
                    
//                    stateAll.append(state)
//                    dateAll.append(st)
//                    timeAll.append(time)
                    
                    nameAll.append(name)
                   FormStateAll.append(FormState)
                    idAll.append(st)
                    serialAll.append(SerialNum)
                    
                    tableData = []
                   nameAll.enumerated().forEach { index, name in
                       tableData.append((name, idAll[index], serialAll[index], FormStateAll[index]))
                   }
                    self.filteredTableData = tableData
                    
                    self.tableView.reloadData()
                }
                
                
            }
            
            
            
        }

    }
    
    @objc func refresh(_ sender: AnyObject) {
        noStudentsFoundLabel.isHidden = !(filteredTableData.count == 0)
        let db = Firestore.firestore()
        Task {
          
            let t_snapshot = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: Global.shared.sectionName).whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments()
            
            nameAll.removeAll()
            FormStateAll.removeAll()
            idAll.removeAll()
            serialAll.removeAll()
            
            
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
                     
                     guard let SerialNum = studentDoc.get("SerialNum") as? String else { continue }
                    

                     print("st new... :" , st, name)
                    
                     nameAll.append(name)
                    FormStateAll.append(FormState)
                     idAll.append(st)
                     serialAll.append(SerialNum)
                     
                    // self.tableView.reloadData()
                 }
                 
                 
             }
            tableData = []
            nameAll.enumerated().forEach { index, name in
                print("st new... 22:" , index, name)
                tableData.append((name, idAll[index], serialAll[index], FormStateAll[index]))
            }
            self.filteredTableData = tableData
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
         }
    }
    
    @objc func didTapCellButton(sender: UIButton) {
        
        let tag = sender.tag
        let dateispreesed = idAll[tag]
        let namepressed = nameAll[tag]
        print("wiich is now press?? number of row",tag)
        print("wiich is now press?? dateispreesed",dateispreesed)
        print("wiich is now press?? name",dateispreesed)
        
        let stude = storyboard?.instantiateViewController(withIdentifier: "LectureViewEXViewController") as!   LectureViewEXViewController
//        stude.Takesection = WhatPressed
//        stude.datePreesed = dateispreesed
//        print("whatpressed ???" , WhatPressed)
        stude.datePreesed = dateispreesed
        stude.namepressed = namepressed
        stude.sectionNmae = Global.shared.sectionName
        navigationController?.pushViewController(stude, animated: true)
        
        
    }
    @objc func viewFterRejectAccept(sender: UIButton) {
        let tag = sender.tag
        let dateispreesed = idAll[tag]
        let namepressed = nameAll[tag]
        print("wiich is now press?? number of row",tag)
        print("wiich is now press?? dateispreesed",dateispreesed)
        print("wiich is now press?? name",dateispreesed)
        
        let stude = storyboard?.instantiateViewController(withIdentifier: "LectureViewAccepRej") as! LectureViewAccepRej
//        stude.Takesection = WhatPressed
//        stude.datePreesed = dateispreesed
//        print("whatpressed ???" , WhatPressed)
        stude.datePreesed = dateispreesed
        stude.namepressed = namepressed
        stude.sectionNmae = Global.shared.sectionName
        navigationController?.pushViewController(stude, animated: true)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let my = tableView.dequeueReusableCell(withIdentifier: "cell") as! studentHave
        my.selectionStyle = .none
        my.viewExec.isHidden = true
        my.ViewExecAfterAccRej.isHidden = true
        
        let (name, id, serial, form) = filteredTableData[indexPath.row]
        
        my.viewExec.tag = indexPath.row
       
        my.viewExec.addTarget(self, action: #selector(didTapCellButton(sender:)),for: .touchUpInside)
        my.ViewExecAfterAccRej.tag = indexPath.row
        my.ViewExecAfterAccRej.addTarget(self, action: #selector(viewFterRejectAccept(sender:)),for: .touchUpInside)
        
        my.nameSt.text = name // nameAll[indexPath.row]
        my.idSt.text = id // idAll[indexPath.row]
        my.serial.text = serial // serialAll[indexPath.row]
      //  my.StateExec.text = FormStateAll[indexPath.row]
        if form == "Pending"   {
           
         //   my.StateExec.text = FormStateAll[indexPath.row]
          my.viewExec.isHidden = false
            
        }
     else   if form == "Accepted"   {
           
           // my.StateExec.text = FormStateAll[indexPath.row]
          my.viewExec.isHidden = true
         my.ViewExecAfterAccRej.tintColor =  #colorLiteral(red: 0.2394818664, green: 0.486830771, blue: 0.1318500638, alpha: 1)
         my.ViewExecAfterAccRej .isHidden = false
            
        }
        else   if form == "Rejected"   {
               
             //  my.StateExec.text = FormStateAll[indexPath.row]
             my.viewExec.isHidden = true
            my.ViewExecAfterAccRej.tintColor = #colorLiteral(red: 0.909211576, green: 0.4139966071, blue: 0.356043905, alpha: 1)
            my.ViewExecAfterAccRej.isHidden = false
               
           }
        
        my.imageExec.image = UIImage(named: "girl")
        
     
        
       
        return my 
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTableData.count
    }
   

}


// Setup searchbar delegate
extension StudentHaveExecution: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty {
            self.filteredTableData = tableData
            tableView.reloadData()
            noStudentsFoundLabel.isHidden = !(filteredTableData.count == 0)
        } else {
            let filteredStudents = self.tableData.filter { (studentName, studentId, serial, form) in
                return studentName.lowercased().contains(query.lowercased().trimmingCharacters(in: .whitespaces)) || studentId.lowercased().contains(query.lowercased().trimmingCharacters(in: .whitespaces))
                || serial.lowercased().contains(query.lowercased().trimmingCharacters(in: .whitespaces))
            }
            
            self.filteredTableData = filteredStudents
            self.tableView.reloadData()
            noStudentsFoundLabel.isHidden = !(filteredTableData.count == 0)
        }
    }
}

//
//  AdvisorVC.swift
//  AttendlyApp
//
//  Created by Yumna Almalki on 15/02/1444 AH.
//

import UIKit
import FirebaseFirestore

class AdvisorVC: UIViewController {
    var Sectionss: String = ""
    var coursess: String = ""
    var students: [[String: Any]] = []
   // var studentID: String = ""
    var allStudents: [[String: Any]] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    var serialStudent = [String]()
    
    func get() {
            let db = Firestore.firestore()
            db.collection("Lectures").whereField("EmailLectures", isEqualTo: Global.shared.useremailshare ).getDocuments {
                (snapshot, error) in
                if let error = error {
                    print("FAIL ")
                }
                else{
                    guard let lecturer = snapshot?.documents.first else {
                        return }
                    
                    guard let lecturerId = lecturer.get("lecturesID") as? String else { return }
                    //let sects = snapshot!.documents.first!.get("Sectionss") as! [String]
                    db.collection("Unistudent").whereField("advisorID", isEqualTo: lecturerId).getDocuments {[weak self] snapshot, error in
                        guard let snapshot = snapshot else {
                            return
                        }
                        
                        var students: [[String: Any]] = []
                        let docs = snapshot.documents
                        print("Docs... ", docs)
                        for i in 0..<docs.count {
                            let document = docs[i].data()
                            students.append(document)
//
                        }
                        self?.students = students
                        self?.allStudents = students
                        
                        self?.tableview.reloadData()
                        self?.toggleNoStudentsFound(show: students.count == 0)
                        
                    }
                }
            }

        }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // self.passwordTextfiled.delegate = self
        
        tableview.delegate = self
        tableview.dataSource = self
        //tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 50
        tableview.rowHeight = 50
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        get()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
    //touch out
    override func touchesBegan(_ tmnaouches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func displayStudents(students: [String]) {
        removeStudents()
        if students.count > 0 {
            for i in 0..<students.count {
                let name = students[i]
                let label = UIButton(frame: .init(x: self.view.frame.midX-175 , y: 340 + ( Double(i) * 90 ), width: 350, height: 60))
                label.setTitle(name, for: .normal)
                label.titleLabel?.font = label.titleLabel?.font.withSize(23)
                label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
                label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                label.layer.cornerRadius = 0.07 * label.bounds.size.width
                label.tag = 999
                self.view.addSubview(label)
            }
        } else {
            let label = UIButton(frame: .init(x: self.view.frame.midX-175 , y: 340 + ( Double(0) * 90 ), width: 350, height: 60))
            label.setTitle(" No Student Found", for: .normal)
            label.titleLabel?.font = label.titleLabel?.font.withSize(30)
            label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
            label.tag = 999
            self.view.addSubview(label)
        }
    }
    
    func toggleNoStudentsFound(show: Bool) {
        if(show) {
            let label = UIButton(frame: .init(x: self.view.frame.midX-175 , y: 500 + ( Double(0) * 90 ), width: 350, height: 60))
            label.setTitle(" No Student Found", for: .normal)
            label.titleLabel?.font = label.titleLabel?.font.withSize(30)
            label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
            label.tag = 999
            self.view.addSubview(label)
        } else {
            removeStudents()
        }
    }
    
    func removeStudents() {
        self.view.subviews.filter { view in
            view.tag == 999
        }.forEach { view in
            view.removeFromSuperview()
        }
    }
}
extension AdvisorVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print("Update REsults")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty {
            self.students = self.allStudents
            tableview.reloadData()
            //displayStudents(students: self.students)
        } else {
            let filteredStudents = self.students.filter { student in
                let Name = student["name"] as? String ?? ""
                let studentID = student["studentID"] as? String ?? ""
                let serialN = student["Snum"] as? String ?? ""
                
                return Name.lowercased().contains(query.lowercased().trimmingCharacters(in: .whitespaces)) ||
                    serialN.lowercased().contains(query.lowercased().trimmingCharacters(in: .whitespaces)) ||
                studentID.lowercased().contains(query.lowercased().trimmingCharacters(in: .whitespaces))
               // let name = student["name"] as? String ?? ""
            //    let studentID = student["studentID"] as? String ?? ""
        
             //   return name.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))
               // guard let email = emailTextfiled.text?.trimmingCharacters(in: .whitespaces)
            }
            self.students = filteredStudents
            self.tableview.reloadData()
            //displayStudents(students: filteredStudents)
        }
        toggleNoStudentsFound(show: students.count == 0)
    }
   
}

 
extension AdvisorVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("enter ADVISOR")
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("s ADVISOR")
        let my = tableView.dequeueReusableCell(withIdentifier: "cell") as! customTableviewControolerTableViewCell
        let student = students[indexPath.row]
        let Name = student["name"] as? String ?? ""
        let studentID = student["studentID"] as? String ?? ""
        let serialN = student["Snum"] as? String ?? ""
        my.nostudent.text = Name
        my.idStu.text = studentID
        my.serialN.text = serialN
        my.person.image = UIImage(named: "girl" )
        return my
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = students[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "StudentInfoViewController") as! StudentInfoViewController
        vc.student = student
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



 

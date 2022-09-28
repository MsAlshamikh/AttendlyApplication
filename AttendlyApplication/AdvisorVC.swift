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
    var students: [String] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
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
                        var students: [String] = []
                        let docs = snapshot.documents
                        print("Docs... ", docs)
                        for i in 0..<docs.count {
                            let document = docs[i].data()
                            let name = document["name"] as? String ?? ""
                            students.append(name)
//
                        }
                        self?.students = students
                        self?.displayStudents(students: students)
                        
                        
                        
                        
                    }
                }
            }

        }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        get()
    }
    
    func displayStudents(students: [String]) {
        removeStudents()
        for i in 0..<students.count {
            let name = students[i]
            let label = UIButton(frame: .init(x: self.view.frame.midX-148 , y: 280 + ( Double(i) * 90 ), width: 300, height: 60))
            label.setTitle(name, for: .normal)
            label.titleLabel?.font = label.titleLabel?.font.withSize(30)
            label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
            label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
            label.layer.cornerRadius = 0.07 * label.bounds.size.width
            label.tag = 999
            self.view.addSubview(label)
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
        if searchText.isEmpty {
            displayStudents(students: self.students)
        } else {
            let filteredStudents = self.students.filter { student in
                student.contains(searchText)
            }
            displayStudents(students: filteredStudents)
        }
    }
}

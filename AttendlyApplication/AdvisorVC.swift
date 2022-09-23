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
    func get() {
            let db = Firestore.firestore()
            db.collection("classes").whereField("LecturerEmail", isEqualTo: Global.shared.useremailshare ).getDocuments {
                (snapshot, error) in
                if let error = error {
                    print("FAIL ")
                }
                else{
                    print("SUCCESS")
                    let actual = snapshot!.documents.first!.get("coursess") as! [String]
                    //let sects = snapshot!.documents.first!.get("Sectionss") as! [String]
                    print(actual)
                    if actual.count == 1 {
                        let  course = actual.first!
                        db.collection("studentsByCourse").document(course).collection("students").getDocuments { snapshot, error in
                            guard let snapshot = snapshot else {
                                return
                            }
                            var students: [String] = []
                            let docs = snapshot.documents
                            for i in 0..<docs.count {
                                let document = docs[i].data()
                                let name = document["name"] as? String ?? ""
                                students.append(name)
                                let label = UIButton(frame: .init(x: self.view.frame.midX-148 , y: 280 + ( Double(i) * 90 ), width: 300, height: 60))
                                label.setTitle(name, for: .normal)
                                label.titleLabel?.font = label.titleLabel?.font.withSize(30)
                                label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
                                label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                                //label.params["course"] = actual[i]
                                //!!!!!!
                                //label.tag = Int(sects[i]) ?? 0

                                //label.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
                                label.layer.cornerRadius = 0.07 * label.bounds.size.width
                                self.view.addSubview(label)
                            }
                            self.students = students
                        }
                    
                    }
//                    for i in 0..<actual.count {
//
//                        let label = UIButton(frame: .init(x: self.view.frame.midX-148 , y: 280 + ( Double(i) * 90 ), width: 300, height: 60))
//                        label.setTitle(actual[i], for: .normal)
//                        label.titleLabel?.font = label.titleLabel?.font.withSize(30)
//                        label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
//                        label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
//                        //label.params["course"] = actual[i]
//                        //!!!!!!
//                        //label.tag = Int(sects[i]) ?? 0
//
//                        //label.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
//                        label.layer.cornerRadius = 0.07 * label.bounds.size.width
//                        self.view.addSubview(label)
//                    }
                    //Vstack
                    // coursesT.text = actual
                    //     print((actual).count)
                }
            }

        }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        let resultsController = UITableViewController(style: .grouped)
        let searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        get()
    }


}
extension AdvisorVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("Update REsults")
    }
}

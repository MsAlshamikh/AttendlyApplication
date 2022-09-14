//
//  CurrentVC.swift
//  AttendlyApp
//
//  Created by Yumna Almalki on 15/02/1444 AH.
//

import UIKit
import FirebaseFirestore

class CurrentVC: UIViewController {

    @IBOutlet weak var selectCourseBtn: UIButton!
    
    @IBOutlet var butsection1Collection: [UIButton]!
    
    var courses: [String] = []
    
    
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectCourseBtn.layer.cornerRadius = selectCourseBtn.frame.height / 2
        butsection1Collection.forEach{  (btn) in btn.layer.cornerRadius = btn.frame.height / 2
            btn.layer.cornerRadius = btn.frame.height / 2
            btn.isHidden = true
            btn.alpha = 0
        
    }
        getCourses()
    }
    
    func getCourses() {
        let db = Firestore.firestore()
        db.collection("classes").getDocuments {[weak self] snapshot, error in
            guard let snapshot = snapshot else {
                return
            }
            for document in snapshot.documents {
                let data = document.data()
                let courses = data["coursess"] as? [String] ?? []
                self?.courses = courses
                self?.addButtons(for: courses)
            }
        }
    }
    
    func addButtons(for courses: [String]) {
        buttonsStackView.isUserInteractionEnabled = true
        
        buttonsStackView.arrangedSubviews.forEach { button in
            button.removeFromSuperview()
        }
        
       
        for (index, course) in courses.enumerated() {
            let button = UIButton()
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 1), for: .normal)
            button.backgroundColor = UIColor(red: 171/255, green: 193/255, blue: 198/255, alpha:1)
            button.setTitle(course, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(fetchStudentsFor(sender:)), for: .touchUpInside)
            button.layer.cornerRadius = 25
            button.isEnabled = true
            buttonsStackView.addArrangedSubview(button)
        }
        
    }
    
    @objc func fetchStudentsFor(sender: UIButton) {
        let tag = sender.tag
        let course = courses[tag]
        self.openCheckin(with: [], courseName: course)
//        let db = Firestore.firestore()
//        db.collection("studentsByCourse/\(course)/students").getDocuments {[weak self] snapshot, error in
//            let docs = snapshot?.documents
//            guard let snapshot = snapshot else { return }
//
//            var students: [[String: Any]] = []
//            for document in snapshot.documents {
//                var student = document.data()
//                student["documentID"] = document.documentID
//
//                print("STTTT ", students)
//                students.append(student)
//            }
//        }
    }
    
    func openCheckin(with students: [[String: Any]], courseName: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let checkinVC = storyboard.instantiateViewController(identifier: "CheckInVC") as! CheckInVC
        checkinVC.students = students
        checkinVC.courseName = courseName
        self.show(checkinVC, sender: self)
    }
    

    @IBAction func selectCourse(_ sender: UIButton) {
        butsection1Collection.forEach{ (btn) in UIView.animate(withDuration: 0.7){
            btn.isHidden = !btn.isHidden
            btn.alpha = btn.alpha == 0 ? 1 : 0
            btn.layoutIfNeeded()
            
        }
    }
    }
    @IBAction func butSection1(_ sender: UIButton) {
        if let btnLb1 = sender.titleLabel?.text{
            print(btnLb1)
            
        }
        
    }
    
   
}


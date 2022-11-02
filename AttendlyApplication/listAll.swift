//
//  listAll.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 25/02/1444 AH.
//

import UIKit
import FirebaseFirestore
class listAll: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var seeExecution: UIButton!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    @IBOutlet weak var nameSection: UILabel!
    
    @IBOutlet weak var zeroStudent: UILabel!
    
    @IBOutlet weak var dataOf: UILabel!
    @IBOutlet weak var noStudentsFoundLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var nameStudent = [String]()
    var emailStudent = [String]()
    var idStudent = [String]()
    var serialStudent = [String]()

    
    // Data structure to hold student information for the Table View
    var tableData = [(String, String, String)]()
    var filteredTableData = [(String, String, String)]()
    
    
    var v: String = ""
    var sectionName = ""
    var SingleEmail: String = ""
    var SingleName: String = ""
    //var sectionNmae: String = ""
    let db = Firestore.firestore()
    
    var percentagestu = [String]()
    
    var doubles = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameStudent.enumerated().forEach { index, name in
            tableData.append((name, idStudent[index], serialStudent[index]))
        }
        self.filteredTableData = tableData
       
        //navigationItem.title = "Student list"
//        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
//
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
//
//        let titleAttributes = [
//            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36)
//         ]
//         self.navigationController?.navigationBar.titleTextAttributes = titleAttributes

        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.semibold), NSAttributedString.Key.foregroundColor: UIColor.white]

        
        zeroStudent.isHidden = true
        
      //  sectionName = nameSection.text!
        searchBar.delegate = self
        
        print("what pressed is ")
        print(v)
        print("name of student")
        print(nameStudent)
        if ( nameStudent.count == 0 )
        {
        zeroStudent.isHidden = false
            print("no student")
            
         //   self.noC.text = "No courses \n registered!"
          self.zeroStudent.text = "No Student Registered Yet "
        }
        tableview.delegate = self
        tableview.dataSource = self
        //tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 50
        tableview.rowHeight = 50
       // navigationController?.navigationItem.title = "ss"
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy‏"
    dataOf.text = dateFormatter.string(from: date)
        
     let text1 = NSMutableAttributedString()

       text1.append(NSAttributedString(string: ""
                                  ));
        text1.append(NSAttributedString(string: v));
        nameSection.attributedText = text1
        sectionName = nameSection.text!
        // let d = Int(date.split(separator: "-")[0])!
        
      //  var spliting = percentagestu.split(separator: "%")
        
        doubles = percentagestu.compactMap(Double.init)
        print("doubles ",doubles )
        
      print("[percentage]",percentagestu)
        
        
       // var converDou = Double(percentagestu)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("enter")
        noStudentsFoundLabel.isHidden = !(filteredTableData.count == 0)
        return filteredTableData.count
    }
    
//    @objc func refresh(_ sender: AnyObject) {
//   Task {
//
//        let t_snapshot = try await db.collection("Unistudent").whereField("co", arrayContains: v).getDocuments()
//         var studentArry = [String]()
//         var emailArry = [String]()
//         var studentID = [String]()
//         var perecmtageArrya = [String]()
//
//
//
//
//
//           for document in t_snapshot.documents {
//            // print(course)
//             print("here")
//          let name = document.get("name") as! String
//               let ID = document.get("studentID") as! String
//               let EMAIL = document.get("StudentEmail") as! String
//
//               studentArry.append(name)
//               studentID.append(ID)
//               emailArry.append(EMAIL)
//
//               var numsec = v.split(separator: "-")[1]
//
//               let shot = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: EMAIL).getDocuments()
//           guard let documentID = shot.documents.first?.documentID else { return }
//
//               var abbsencest = shot.documents.first!.get("abbsencest") as! [String: Int]
//               var sectionH = shot.documents.first!.get("sectionH") as! [String: Int]
//               var percentage = shot.documents.first!.get("percentage") as! [String: Int]
//
//               print("abbsencest",abbsencest)
//               var sherdabbsencest = 0
//               var sheredsectionH = 0
//               var sheredpercentage = 0
//             //  for valueAbb in abbsencest {
//               for (key,value) in abbsencest {
//                   print("\(key): \(value)")
//                   var sectionNumber = key
//                   var abbsentNumber = value
//                   print("sectionNumber",sectionNumber)
//                   print("abbsentNumber",abbsentNumber)
//
//                   if( sectionNumber == numsec ){
//                      print(" just for section that was perssed abbsence", abbsentNumber)
//                       sherdabbsencest = abbsentNumber
//                   }
//
//               }
//               for (key,value) in sectionH {
//                   print("\(key): \(value)")
//                   var sectionNumber2 = key
//                   var abbsentNumber2 = value
//                   print("sectionNumber2",sectionNumber2)
//                   print("abbsentNumber2",abbsentNumber2)
//
//                   if( sectionNumber2 == numsec ){
//                      print(" just for section that was perssed abbsence", abbsentNumber2)
//                       sheredsectionH = abbsentNumber2
//                    // perecmtageArrya.append( abbsentNumber
//                   }
//
//               }
//               for (key,value) in percentage {
//                   print("\(key): \(value)")
//                   var sectionNumber3 = key
//                   var abbsentNumber3 = value
//                   print("sectionNumber2",sectionNumber3)
//                   print("abbsentNumber2",abbsentNumber3)
//
//                 if( sectionNumber3 == numsec ){
//                      print(" just for section that was perssed abbsence", abbsentNumber3)
//                    // perecmtageArrya.append( abbsentNumber )
//                     sheredpercentage = abbsentNumber3
//
//                   }
//               }
//               print(" sherdabbsencest", sherdabbsencest)
//               print("sheredpercentage", sheredpercentage)
//               print(" sheredsectionH", sheredsectionH)
//
//               //perecmtageArrya.append( abbsentNumber )
//
//               var step1 = Double(sheredsectionH ) * 0.25
//                  var step2 = ( Double(sherdabbsencest) /  step1 ) * 100
//                       var final = step2 * 0.25
//                  final = Double(round(10 * final) / 10 )
//
//                  print(final)
//
//
//
//
//             let st = String(final)
//             perecmtageArrya.append(st)
//       //    let name = t_snapshot.course["name"] as? String??
//
//           //  let name: String = snapshot.documents.first?.data()["name"] as! String
//               print("ID of student/",ID)
//               print("name of student/",name)
//             guard let documentID = t_snapshot.documents.first?.documentID else { continue }
//             print("docID", documentID)
//             print(coursess.count)
//
//               // perecmtageArrya.append( abbsentNumber
//
//         }
//
//   }
//
//     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let my = tableView.dequeueReusableCell(withIdentifier: "cell") as! customTableviewControolerTableViewCell
      
        // Use table data structure
        my.nostudent.text = filteredTableData[indexPath.row].0
        my.idStu.text = filteredTableData[indexPath.row].1
        
        my.serialN.text = filteredTableData[indexPath.row].2
        my.person.image = UIImage(named: "girl" )
        
        if doubles[indexPath.row]  >= 20 {    // less than or eqaul to 0
            my.currrentsectionpressed.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            my.currrentsectionpressed.text = ""+String ( percentagestu[indexPath.row] + "%" ) }
       else if doubles[indexPath.row]  >= 10 {    // less than or eqaul to 0
            my.currrentsectionpressed.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            my.currrentsectionpressed.text = ""+String ( percentagestu[indexPath.row] + "%" ) }
       else if doubles[indexPath.row] >= 0 {   //less than  or equal 7
            my.currrentsectionpressed.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
           
            my.currrentsectionpressed.text = ""+String ( percentagestu[indexPath.row] + "%" ) }
        
        
       let emails = emailStudent[indexPath.row]
        
    
        print("befor task")
        print(emails)

        return my
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
                let currentCell = tableView.cellForRow(at: indexPath)! as! customTableviewControolerTableViewCell   // THE SOLUTION
                let v = currentCell.idStu!.text!
                print("is preeesed", v)
        
       // Task{
        
        
        
        let db = Firestore.firestore()
        
        
        db.collection("Unistudent").whereField("studentID", isEqualTo: v).getDocuments{
            (snapshot, error) in
            if let error = error {
            }
            else{
                let EmailStu = snapshot!.documents.first!.get("StudentEmail") as! String
                
                let NameStu = snapshot!.documents.first!.get("Fullname") as! String
//               let snapshot = try await db.collection("Unistudent").whereField("studentID", isEqualTo: v).getDocuments()
//               guard let EmailStu = snapshot.documents.first?.get("StudentEmail") as? String else { return }
//               guard let NameStu = snapshot.documents.first?.get("Fullname") as? String else { return }
               
            
                let stude = self.storyboard?.instantiateViewController(withIdentifier: "StudentVC") as! StudentVC
        
               print("Email  ssssss" , EmailStu )
//            
            
              var arrAll = NameStu.split(separator: "-")
               print("TRRRRYYY SPLLLIITTT", arrAll)
               stude.v = v // id student
                stude.sectionName = self.sectionName
//               stude.SingleName = NameStu
//               stude.SingleEmail = EmailStu
            stude.FullEmail = EmailStu
            stude.SingleName = String(arrAll[0])
            stude.SingleEmail = String(arrAll[1])
            
                print("here course is ", self.sectionName)
       
        
                self.navigationController?.pushViewController(stude, animated: true)
       // }
            }
    
    }
    }
    

    @IBAction func pressExecution(_ sender: UIButton) {
        print("goo")
        let stude = storyboard?.instantiateViewController(withIdentifier: "StudentHaveExecution") as! StudentHaveExecution
  //  stude.sectionNmae = sectionName
        Global.shared.sectionName = sectionName
        print("sectionName ???" , sectionName)
        navigationController?.pushViewController(stude, animated: true)
    }
    
}
// Setup searchbar delegate
extension listAll: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty {
            self.filteredTableData = tableData
            tableview.reloadData()
        } else {
            let filteredStudents = self.tableData.filter { (studentName, studentId, serial) in
                return studentName.lowercased().contains(query.lowercased().trimmingCharacters(in: .whitespaces)) || studentId.lowercased().contains(query.lowercased().trimmingCharacters(in: .whitespaces))
                ||  serial.lowercased().contains(query.lowercased().trimmingCharacters(in: .whitespaces))
            }
            
            self.filteredTableData = filteredStudents
            self.tableview.reloadData()
        }
    }
}

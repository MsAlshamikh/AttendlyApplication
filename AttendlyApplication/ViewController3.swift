//
//  ViewController2.swift
//  AttendlyApplication
//
//  Created by SHAMMA  on 01/04/1444 AH.
//

//this part is basically the fixed part of the table -AD

import UIKit
import FirebaseFirestore

class ViewController3: UIViewController {
    var numbersArray = [String]()

    let colorArray = [ #colorLiteral(red: 0.9827464223, green: 0.8374974728, blue: 0.9789015651, alpha: 1),  #colorLiteral(red: 0.7701125145, green: 0.9381597638, blue: 1, alpha: 1),  #colorLiteral(red: 0.9619761109, green: 0.9262647629, blue: 0.6508037448, alpha: 1) ,  #colorLiteral(red: 0.7984707952, green: 0.9665120244, blue: 0.6857665181, alpha: 1) ,  #colorLiteral(red: 0.8193834424, green: 0.8202515244, blue: 1, alpha: 1),  #colorLiteral(red: 1, green: 0.8212433457, blue: 0.7032110095, alpha: 1)]
 
   
    
    @IBOutlet weak var gridCollectionView: UICollectionView!
    
    @IBOutlet weak var gridLayout: StickyGridCollectionViewLayout!
    {
        didSet {
            gridLayout.stickyRowsCount = 1
         gridLayout.stickyColumnsCount = 1
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
        
    }
    
}


// MARK: - Collection view data source and delegate methods

extension ViewController3: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
      
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
            
        }
//print(indexPath)
   
        //HERE GET
    //    course()
        
       
        
    
        if (indexPath.elementsEqual([1, 0])){
            cell.titleLabel2.text = "8:00"
        }
        else if (indexPath.elementsEqual([2, 0])){
            cell.titleLabel2.text = "9:15"
        }
        else if (indexPath.elementsEqual([0, 0])){
            cell.titleLabel2.text = ""
        }

        else if (indexPath.elementsEqual([3, 0])){
            cell.titleLabel2.text = "10:30"
        }
        else if (indexPath.elementsEqual([4, 0])){
            cell.titleLabel2.text = "11:45"
        }
        else if (indexPath.elementsEqual([5, 0])){
            cell.titleLabel2.text = "12:50"
        }//days
        else if (indexPath.elementsEqual([6, 0])){
            cell.titleLabel2.text = "1:30"
        }
        else if (indexPath.elementsEqual([7, 0])){
            cell.titleLabel2.text = "2:45"
        }
        else if (indexPath.elementsEqual([8, 0])){
            cell.titleLabel2.text = "3:50"
        }
        else if (indexPath.elementsEqual([9, 0])){
            cell.titleLabel2.text = "4:45"
        }
        else if (indexPath.elementsEqual([0, 1])){
            cell.titleLabel2.text = "Sun" // 9.15-10.20
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 2])){
            cell.titleLabel2.text = "Mon"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 3])){
            cell.titleLabel2.text = "Tue"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 4])){
            cell.titleLabel2.text = "Wed"           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 5])){
            cell.titleLabel2.text = "Thur"
           // cell.titleLabel.textAlignment = .left
            
        }
       /* else if (indexPath.elementsEqual([0, 6])){
            cell.titleLabel.text = "13:30-14:35"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 7])){
            cell.titleLabel.text = "14:45-15:50"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 8])){
            cell.titleLabel.text = "16:00-17:05"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 9])){
            cell.titleLabel.text = "17:15-18:20"
           // cell.titleLabel.textAlignment = .left
            
        }*/
        else{
            cell.titleLabel2.text = "\(indexPath)"}
        
     cell.backgroundColor = gridLayout.isItemSticky(at: indexPath)  ? .groupTableViewBackground : .white
        if(cell.backgroundColor == .white){
            cell.backgroundColor =  #colorLiteral(red: 0.8953151844, green: 0.9132214881, blue: 0.9132214881, alpha: 1)
          cell.layer.borderWidth = 0.3
           cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.titleLabel2.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.titleLabel2.font = cell.titleLabel2.font.withSize(14)
           
        }
        else{
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.layer.borderWidth = 0.4
            cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.titleLabel2.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.titleLabel2.font = cell.titleLabel2.font.withSize(17)
            
        }
        
        //SHAMMA COLORS
        
        for i in 1..<Global.shared.Sunday.count{
            if (indexPath.elementsEqual([i, 1]))
            { cell.titleLabel2.text = Global.shared.Sunday[i]
                if(Global.shared.Sunday[i] == "SWE482"){
                   cell.backgroundColor =  #colorLiteral(red: 0.9827464223, green: 0.8374974728, blue: 0.9789015651, alpha: 1)
               }
                else if(Global.shared.Sunday[i] == "SWE321"){
                   cell.backgroundColor =  #colorLiteral(red: 0.7984707952, green: 0.9665120244, blue: 0.6857665181, alpha: 1)
               }
                else if(Global.shared.Sunday[i] == "SWE444"){
                   cell.backgroundColor =  #colorLiteral(red: 0.7042651985, green: 0.6803297185, blue: 0.9686274529, alpha: 1)
               }
                else if(Global.shared.Sunday[i] == "SWE381"){
                   cell.backgroundColor =  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
               }
                else if(Global.shared.Sunday[i] == "Cloud482"){
                   cell.backgroundColor =  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
               }
                else
                {
                    cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}

            }
        }
        for i in 1..<Global.shared.Monday.count{
            if (indexPath.elementsEqual([i, 2]))
            { cell.titleLabel2.text = Global.shared.Monday[i]
                if(Global.shared.Monday[i] == "SWE482"){
                   cell.backgroundColor =  #colorLiteral(red: 0.9827464223, green: 0.8374974728, blue: 0.9789015651, alpha: 1)
               }
                else if(Global.shared.Monday[i] == "SWE321"){
                   cell.backgroundColor =  #colorLiteral(red: 0.7984707952, green: 0.9665120244, blue: 0.6857665181, alpha: 1)
               }
                else if(Global.shared.Monday[i] == "SWE444"){
                   cell.backgroundColor =  #colorLiteral(red: 0.7042651985, green: 0.6803297185, blue: 0.9686274529, alpha: 1)
               }
                else if(Global.shared.Monday[i] == "SWE381"){
                   cell.backgroundColor =  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
               }
                else if(Global.shared.Monday[i] == "Cloud482"){
                   cell.backgroundColor =  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
               }
                else
                {
                    cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}

           }
        }
        for i in 1..<Global.shared.Tuesday.count{
            if (indexPath.elementsEqual([i, 3]))
            { cell.titleLabel2.text = Global.shared.Tuesday[i]
                if(Global.shared.Tuesday[i] == "SWE482"){
                   cell.backgroundColor =  #colorLiteral(red: 0.9827464223, green: 0.8374974728, blue: 0.9789015651, alpha: 1)
               }
                else if(Global.shared.Tuesday[i] == "SWE321"){
                   cell.backgroundColor =  #colorLiteral(red: 0.7984707952, green: 0.9665120244, blue: 0.6857665181, alpha: 1)
               }
                else if(Global.shared.Tuesday[i] == "SWE444"){
                   cell.backgroundColor =  #colorLiteral(red: 0.7042651985, green: 0.6803297185, blue: 0.9686274529, alpha: 1)
               }
                else if(Global.shared.Tuesday[i] == "SWE381"){
                   cell.backgroundColor =  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
               }
                else if(Global.shared.Tuesday[i] == "Cloud482"){
                   cell.backgroundColor =  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
               }
                else
                {
                    cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}

            }
        }
        for i in 1..<Global.shared.Wednesday.count{
            if (indexPath.elementsEqual([i, 4]))
            { cell.titleLabel2.text = Global.shared.Wednesday[i]
                if(Global.shared.Wednesday[i] == "SWE482"){
                   cell.backgroundColor =  #colorLiteral(red: 0.9827464223, green: 0.8374974728, blue: 0.9789015651, alpha: 1)
               }
                else if(Global.shared.Wednesday[i] == "SWE321"){
                   cell.backgroundColor =  #colorLiteral(red: 0.7984707952, green: 0.9665120244, blue: 0.6857665181, alpha: 1)
               }
                else if(Global.shared.Wednesday[i] == "SWE444"){
                   cell.backgroundColor =  #colorLiteral(red: 0.7042651985, green: 0.6803297185, blue: 0.9686274529, alpha: 1)
               }
                else if(Global.shared.Wednesday[i] == "SWE381"){
                   cell.backgroundColor =  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
               }
                else if(Global.shared.Wednesday[i] == "Cloud482"){
                   cell.backgroundColor =  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
               }
                else
                {
                    cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}
            }
        }
        for i in 1..<Global.shared.Thursday.count{
            if (indexPath.elementsEqual([i, 5]))
            { cell.titleLabel2.text = Global.shared.Thursday[i]
                if(Global.shared.Thursday[i] == "SWE482"){
                   cell.backgroundColor =  #colorLiteral(red: 0.9827464223, green: 0.8374974728, blue: 0.9789015651, alpha: 1)
               }
                else if(Global.shared.Thursday[i] == "SWE321"){
                   cell.backgroundColor =  #colorLiteral(red: 0.7984707952, green: 0.9665120244, blue: 0.6857665181, alpha: 1)
               }
                else if(Global.shared.Thursday[i] == "SWE444"){
                   cell.backgroundColor =  #colorLiteral(red: 0.7042651985, green: 0.6803297185, blue: 0.9686274529, alpha: 1)
               }
                else if(Global.shared.Thursday[i] == "SWE381"){
                   cell.backgroundColor =  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
               }
                else if(Global.shared.Thursday[i] == "Cloud482"){
                   cell.backgroundColor =  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
               }
                else
                {
                    cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}
            }}

            
        
        return cell
    }}
   



extension ViewController3: UICollectionViewDelegateFlowLayout , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 66, height: 50)
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath) as? CollectionViewCell else {
    //           return
    //
    //        }
          let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            Global.shared.WhatPressed = cell.titleLabel2.text!
                            var studentArry = [String]()
                            var emailArry = [String]()
                            var studentID = [String]()
                            var perecmtageArrya = [String]()
                            var serialStudent = [String]()

            var  v =  ""
            var  i  =  0
         if(cell.titleLabel2.text! != ""){
             v = cell.titleLabel2.text!
             
            var v1 = ""
              let db = Firestore.firestore()
             
             db.collection("Sections").whereField("courseName", isEqualTo: v).getDocuments{
                 (shot, error) in
                 if let error = error {
                 }
                 else{
    let couseN = shot!.documents.first!.get("fullCourse") as! String
                     v1 = couseN
print("v1 ",v1)
                 }
             }
             
             
             
     db.collection("Unistudent").whereField("courses", arrayContains: v).getDocuments{
         (snapshot, error) in
         if let error = error {
         }
         else{
             print("AMANI  BEFORE THE   FOR  LOOOOOP ")
             for documents in snapshot!.documents
             {
                 print("AMANI  IS INSIDE ")
                 let name = documents.get("name") as! String
                 print("AMANI  GOT NAME", name)
                 studentArry.append(name)
                 print("AMANI  APPEND NAME")
                 let ID = documents.get("studentID") as! String
                 print("AMANI  GOT ID", ID)
                 studentID.append(ID)
                 let EMAIL = documents.get("StudentEmail") as! String
                 print("AMANI  GOT EMAIL", EMAIL)
                 emailArry.append(EMAIL)
                 let ser = documents.get("SerialNum") as! String
                 print("ser",ser)
                 serialStudent.append(ser)
                 
                 var SA = documents.get("Sections") as! [String]
                 var numsec = ""
                 var SA1 = documents.get("courses") as! [String]
                 for i in 0 ..< SA1.count {
                     if( SA1[i] == v ){
                    numsec = SA[i]
                         print("numsec",numsec)
                         
                     }
                     
                     print("After numsec",numsec)
                     
                 }
               //  var numsec = SA[i+1].split(separator: "-")[1]
                 var abbsencest = documents.get("abbsencest") as! [String: Int]
                 var sectionH = documents.get("sectionH") as! [String: Int]
                 var percentage = documents.get("percentage") as! [String: Int]

                 print("abbsencest",abbsencest)
                 var sherdabbsencest = 0
                 var sheredsectionH = 0
                 var sheredpercentage = 0
               //  for valueAbb in abbsencest {
                 for (key,value) in abbsencest {
                     print("\(key): \(value)")
                     var sectionNumber = key
                     var abbsentNumber = value
                     print("sectionNumber",sectionNumber)
                     print("abbsentNumber",abbsentNumber)

                     if( sectionNumber == numsec ){
                        print(" just for section that was perssed abbsence", abbsentNumber)
                         sherdabbsencest = abbsentNumber
                     }

                 }
                 for (key,value) in sectionH {
                     print("\(key): \(value)")
                     var sectionNumber2 = key
                     var abbsentNumber2 = value
                     print("sectionNumber2",sectionNumber2)
                     print("abbsentNumber2",abbsentNumber2)

                     if( sectionNumber2 == numsec ){
                        print(" just for section that was perssed abbsence", abbsentNumber2)
                         sheredsectionH = abbsentNumber2
                      // perecmtageArrya.append( abbsentNumber
                     }

                 }
                 for (key,value) in percentage {
                     print("\(key): \(value)")
                     var sectionNumber3 = key
                     var abbsentNumber3 = value
                     print("sectionNumber2",sectionNumber3)
                     print("abbsentNumber2",abbsentNumber3)

                   if( sectionNumber3 == numsec ){
                        print(" just for section that was perssed abbsence", abbsentNumber3)
                      // perecmtageArrya.append( abbsentNumber )
                       sheredpercentage = abbsentNumber3

                     }
                 }
                 var step1 = Double(sheredsectionH ) * 0.25
                    var step2 = ( Double(sherdabbsencest) /  step1 ) * 100
                   var final = step2 * 0.25
                    final = Double(round(10 * final) / 10 )
                 let st = String(final)
               perecmtageArrya.append(st)
             }
            
         

    //                  for document in t_snapshot.documents {
    //                   // print(course)
    //                    print("here")
    //                      let name = document.get("name") as! String
    //                      let ID = document.get("studentID") as! String
    //                      let EMAIL = document.get("StudentEmail") as! String
    //                      studentArry.append(name)
    //                      studentID.append(ID)
    //                      emailArry.append(EMAIL)
                          
                               let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "listAll") as! listAll
             
            print("AMANI  LETS  SEE", studentArry)
             print("AMANI  LETS  SEE ID", studentID)
             print("AMANI  LETS  SEE v", v)
             
                                vc1.nameStudent = studentArry
                                 vc1.idStudent = studentID
                                   vc1.v = v1
                                   vc1.emailStudent = emailArry
                                   vc1.percentagestu = perecmtageArrya
             vc1.serialStudent = serialStudent
                                    self.navigationController?.pushViewController( vc1, animated: true)}
     }}}}






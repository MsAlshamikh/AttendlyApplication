//
//  NFChelper.swift
//  AttendlyApplication
//
//  Created by SHAMMA  on 17/02/1444 AH.
//

import Foundation
import CoreNFC
import FirebaseFirestore
class NFChelper: NSObject, NFCNDEFReaderSessionDelegate {
  var onNFCResult: ((Bool, String) -> ())?
  func restartSession() {
    let session = NFCNDEFReaderSession(delegate: self,
                                       queue: nil,
                                       invalidateAfterFirstRead: true)
    session.begin()
  }
  
  // MARK: NFCNDEFReaderSessionDelegate
  func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
    guard let onNFCResult = onNFCResult else { return }
      
    //  print("Cancel") # if we press cancel butten
    onNFCResult(false, error.localizedDescription)
      
  }
  
  func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
    guard let onNFCResult = onNFCResult else { return }
      guard let firstMsg = messages.first else { return  }
      guard let firstRecord = firstMsg.records.first else { return}
      if let resultString = String(data: firstRecord.payload, encoding: .utf8){
          if !resultString.hasPrefix("First"){
              
              
             // var flag = get()
              
              
              onNFCResult(true, resultString)
          }
        
          
      }
      
      
      

     
  }
    
    
    /*
    func get() ->Bool {
        var flag = false
            let db = Firestore.firestore()
        db.collection("KsuDataBase").whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments{ [self]
                (snapshot, error) in
                if let error = error {
                    print("FAIL ")
                    
                }
                else{
                    print("SUCCESS")
                    
                    db.collectionGroup("Section").getDocuments { (snapshot, error) in
                        let actual = snapshot!.documents.first!.get("sectionID") as! [String]
                        print(actual)
                        flag=true
                    }
                }
    
                }
   return flag }*/
    
    
    
    
    
    
    
    
    
    
   /* func get() ->Bool {
        var x=false
            let db = Firestore.firestore()
        db.collection("KsuDataBase").whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments{ [self]
                (snapshot, error) in
                if let error = error {
                    print("FAIL ")
                }
                else{
                    print("SUCCESS")
                    
                    
                    
                    db.collection("KsuDataBase").document("Student").collection("Section").getDocuments(){ [self]
                        (snapshot, error) in
                        if let error = error {
                            print("FAIL ")
                        }
                        else{
                            var s=""
                            print("SUCCESS")
                            let actual = snapshot!.documents.first!.get("s") as! [String]
                            
                            print(actual)
                            x = true
                        }
                
                    
                    
                    
                    
                  /*  let actual = snapshot!.documents.first!.get("Sectionss") as! [String]
                    
                   for sec in actual{
                        if self.result.contains(sec){
                            let alertController = UIAlertController(title: "Success", message: "You are attended succssfully",preferredStyle: .alert)
                            // ## should change the color ( attended = true )
                        }
                        else {
                            let alertController = UIAlertController(title: "Fail", message: "Your attended is Fail ",preferredStyle: .alert)
                        }
                    }
            for i in 0..<actual.count {
           for j in 0..<result.count {

               /*let myString1 = "556"
               let myInt1 = Int(myString1)*/
               
               let result2 = String(result)
               //if result2[j] == actual[i]{
              
    
               break
              }
    
              }
    */
    
           }//end else
    
        }
                   
      }
    return x
    }*/

}


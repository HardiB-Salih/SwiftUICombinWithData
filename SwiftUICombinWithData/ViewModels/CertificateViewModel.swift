//
//  CertificateViewModel.swift
//  SwiftUICombinWithData
//
//  Created by HardiB.Salih on 6/30/23.
//

import Foundation
import Firebase

final class CertificateViewModel: ObservableObject {
    @Published var certificates: [Certificate] = []

    init(){
        fetchCertificates()
    }
    func fetchCertificates() {
        let db = Firestore.firestore()

        db.collection("certificates").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let querySnapshot = querySnapshot {
                    for document in querySnapshot.documents {
                        let data = document.data()

                        let id = data["id"] as? String ?? ""
                        let course = data["course"] as? String ?? ""
                        let dateValue = (data["date"] as AnyObject).dateValue()
                        let date = dateValue.formatDate()
                        let logo = data["logo"] as? String ?? ""
                        let instructor = data["instructor"] as? String ?? ""

                        let certificate = Certificate(id: id, course: course, date: date, logo: logo, instructor: instructor)

                        self.certificates.append(certificate)
                    }
                }
            }
        }
    }
}

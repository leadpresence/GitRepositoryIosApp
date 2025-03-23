//
//  EmTable.swift
//  GitReposApp
//
//  Created by chibueze felix on 22/03/2025.
//


import SwiftUI


struct EmployeeTable: View {
 let data = [
 Employee(name: "John Doe", occupation: "Software Developer"),
 Employee(name: "Jane Smith", occupation: "Project Manager"),
 Employee(name: "Sam Johnson", occupation: "Designer")
 ]
    
var body: some View {
 Table(data) {
 TableColumn("Name", value: \.name)
 TableColumn("Occupation", value: \.occupation)
 }
 }
}

//
//  ContentView.swift
//  WeSplit
//
//  Created by Anu Mittal on 01/02/21.
//

import SwiftUI

struct ContentView: View {
  static let baseNumberOfPeople = 0
  @State private var checkAmount = ""
  @State private var numberOfPeople = "2"
  @State private var tipPercent = 2
  
  @State private var isTipSelected = false
  
  let tipPercentages = [10, 15, 20, 25, 0]
  
  private var totalAmountPerPerson: Double {
    let orderAmount = Double(checkAmount) ?? 0
    let tipSelection = Double(tipPercentages[tipPercent])
    let numberOfPeopleCount = Int(numberOfPeople) ?? 0
    let peopleCount = Double(numberOfPeopleCount + ContentView.baseNumberOfPeople)
    let tipValue = orderAmount / 100 * tipSelection
    let grandTotal = orderAmount + tipValue
    let amountPerPerson = grandTotal / peopleCount
    return amountPerPerson.onReceive(
  }

  private var totalAmount: Double {
    let orderAmount = Double(checkAmount) ?? 0
    let tipSelection = Double(tipPercentages[tipPercent])
    let tipValue = orderAmount / 100 * tipSelection
    let grandTotal = orderAmount + tipValue
    return grandTotal
  }
  func doSomething() {
    print("called")
  }
  var body: some View {
    NavigationView {
    Form {
      Section {
        TextField("Enter the Amount", text: $checkAmount)
          .keyboardType(.decimalPad)
        TextField("Number of people", text: $numberOfPeople)
          .keyboardType(.decimalPad)
//
//        Picker("Number of people", selection: $numberOfPeople) {
//                ForEach(2 ..< 100) {
//                    Text("\($0) people")
//                }
//            }
      }
      
      Section(header: Text("How much tip do you want to leave?")) {
        Picker("Tip percentage", selection: $tipPercent) {
          ForEach(0 ..< tipPercentages.count) {
            Text("\(self.tipPercentages[$0])%")
          }
        }
        .pickerStyle(SegmentedPickerStyle())
      }.onReceive([self.$tipPercent].publisher.first(), perform: { _ in
        isTipSelected = tipPercentages[tipPercent] != 0
      })
      
      Section(header: Text("Total Amount(including tip)")) {
        Text("$\(totalAmount, specifier: "%.2f")")
      }
      
      Section(header: Text("Amount per person")) {
        Text("$\(totalAmountPerPerson, specifier: "%.2f")")
          .foregroundColor(isTipSelected ? .black : .red)
      }
    }.navigationBarTitle("WeSplit")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

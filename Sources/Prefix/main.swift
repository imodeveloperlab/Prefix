//import SwiftCLI
//
//class GreetCommand: Command {
//    let name = "greet"
//    let person = Parameter()
//    func execute() throws {
//        stdout <<< "Hello \(person.value)!"
//    }
//}
//
//let greeter = CLI(name: "greeter")
//greeter.commands = [GreetCommand()]
//_ = greeter.go()

import PrefixCore
import Files
import Foundation

func getFrameworks() -> [PrefixFramework] {
    
    let alamofire = PrefixFramework(originalName: "Alamofire",
                                    finalName: "Alamofire",
                                    fromPath: "Source")
    
    let imoTableView = PrefixFramework(originalName: "ImoTableView",
                                       finalName: "ImoTableView",
                                       fromPath: "ImoTableView/ImoTableView/")
    
    let activeLabel = PrefixFramework(originalName: "ActiveLabel.swift",
                                      finalName: "ActiveLabel",
                                      fromPath: "ActiveLabel")
    
    let phoneNumberKit = PrefixFramework(originalName: "PhoneNumberKit",
                                         finalName: "PhoneNumberKit",
                                         fromPath: "PhoneNumberKit")

    return [imoTableView, activeLabel, phoneNumberKit, alamofire]
}

func test2() {
    
    let refactor = PrefixRefactor()
    
    for framework in getFrameworks() {
        
        do {
            
            let mainFolder = try Folder.home.subfolder(named: "PrefixTest")
            try framework.clearDestinationFolder(root: mainFolder)
            let from = try framework.fromFolder(with: mainFolder)
            let to = try framework.toFolder(with: mainFolder)
            try refactor.prefix(prefix: framework.finalName.toPrefix(), from: from, to: to)
            
        } catch {
            print("error: \(error)")
        }
    }
}

test2()




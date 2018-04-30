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

func test() {

    let prefix = PrefixFiles()
    
    do {
        
        let mainFolder = try Folder.home.subfolder(named: "PrefixTest")
        
        //CREATE CONVERTED FOLDER IF NOT EXIST
        if !mainFolder.containsSubfolder(named: "Converted") {
            try mainFolder.createSubfolder(named: "Converted")
        }
        
        let convertedFolder = try mainFolder.subfolder(named: "Converted")
        
        //DELETE ALL FILES FROM CONVERTED FOLDER
        guard let filesToDelete = prefix.getAllSwiftFiles(folder: convertedFolder) else {
            return
        }
        
        for file in filesToDelete {
            try file.delete()
        }

        //GET ALL FILES FROM MAIN FOLDER
        guard let files = prefix.getAllSwiftFiles(folder: mainFolder) else {
            return
        }
        
        for file in files {
            if let content = file.prefix(with: "MM") {
                try convertedFolder.createFile(named: "MM\(file.name)", contents: content)
            }
        }
        
    } catch {
        print(error)
    }
}

test()

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
        
        var allPossibleTypes = [String]()
        
        for file in files {
            
            guard let content = file.content() else {
                   continue
            }
            
            allPossibleTypes.append(contentsOf: content.getAllSwitfTypeDeclarations(skipPrivate: true))
        }
        
        print(allPossibleTypes)
        
        let newPrefix = "MM"
        
        for file in files {
            
            guard var content = file.content() else {
                continue
            }
            
            for type in allPossibleTypes {
                
                let components = type.components(separatedBy: " ")
                
                if components.count == 2 {
                    
                    let replace = components[1]
                    let with = "MM\(components[1])"
                    
                    print("\(replace) with \(with)")
                    
                    if let checkRange = content.range(of: replace) {
                        let nsRange = content.nsRange(from: checkRange)
                        let substring = content.subsstring(with: NSMakeRange(nsRange.location - newPrefix.count, newPrefix.count))
                        
                        if substring == newPrefix {
                            continue
                        }
                    }
                    
                    content = content.replacingOccurrences(of: replace, with: with)
                    try convertedFolder.createFile(named: "MM\(file.name)", contents: content)
                }
            }
        }

    } catch {
        print(error)
    }
}

//test()

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




import SwiftCLI
import PrefixCore
import Files
import Foundation

class AddCommand: Command {
    
    let name = "add"
    let prefix = Parameter()
    
    func execute() throws {
        
        do {
            let mainFolder = Folder.current
            let refactor = PrefixRefactor()
            
            if !mainFolder.containsSubfolder(named: "\(prefix.value)Prefix") {
                try mainFolder.createSubfolder(named: "\(prefix.value)Prefix")
            }
            
            let toFolder = try mainFolder.subfolder(atPath: "\(prefix.value)Prefix")
            
            if mainFolder.containsSubfolder(named: "\(prefix.value)Prefix") {
                let destinationFolder = try mainFolder.subfolder(atPath: "\(prefix.value)Prefix")
                let filesManager = PrefixFiles()
                if let filesToDelete = filesManager.getFilesFrom(folder: destinationFolder) {
                    for file in filesToDelete {
                        try file.delete()
                    }
                }
            }
            
            try refactor.prefix(prefix: prefix.value, from: mainFolder, to: toFolder)
            
        } catch {
            print("error: \(error)")
        }
        
        stdout <<< "Done add prefix \(prefix.value)"
    }
}

let greeter = CLI(name: "greeter")
greeter.commands = [AddCommand()]
_ = greeter.go()


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




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
            
            let destinationFolderName = "\(prefix.value)Prefix"
            
            if !mainFolder.containsSubfolder(named: destinationFolderName) {
                try mainFolder.createSubfolder(named: destinationFolderName)
            }
            
            let toFolder = try mainFolder.subfolder(atPath: destinationFolderName)
            
            if mainFolder.containsSubfolder(named: destinationFolderName) {
                let destinationFolder = try mainFolder.subfolder(atPath: destinationFolderName)
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

let prefix = CLI(name: "prefix")
prefix.commands = [AddCommand()]
_ = prefix.go()

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




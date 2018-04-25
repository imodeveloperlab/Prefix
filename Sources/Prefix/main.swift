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

func test() {

    let prefix = PrefixFiles()
    
    do {
        guard let files = prefix.getAllSwiftFiles(folder: try Folder.home.subfolder(named: "PrefixTest")) else {
            return
        }
        
        for file in files {
            if let content = file.content() {
                
                print(content)
                
                let matches = content.getAllMatches(for: PrefixParser.containSwiftTypeDeclarations("class"))
                print(matches)
            }
        }
        
    } catch {
        print(error)
    }
}

test()

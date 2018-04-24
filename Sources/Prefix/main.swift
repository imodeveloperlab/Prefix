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

let prefix = PrefixFiles()
let files = prefix.getAllSwiftFiles(folder: try Folder.home.subfolder(named: "PrefixTest"))

print(files ?? "no files found")

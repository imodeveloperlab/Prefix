# Prefix
Prefix is an command line tool app which helps with adding prefix to an swift file which contains defined classes enums tructs and so on and adding to them wanted prefix.

#### Build and Install

```
$ swift build -c release -Xswiftc -static-stdlib
$ cd .build/x86_64-apple-macosx10.10/release
$ cp -f Prefix /usr/local/bin/prefix
```

#### Ussage

From terminal go to your folder with swift files you want to add prefix and run:

```
$ prefix add PREFIX_NAME
```

and **Prefix** will create and subfolder with name PREFIX_NAME**Prefix** and put all changed files in.

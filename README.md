# Prefix
Prefix is an command line tool app which helps with adding prefix to an swift file which contains defined swift types class, protocol, extension, enum, struct and adding to them wanted **Prefix**.

#### Clone, Build and Install

```
$ git clone git@github.com:imodeveloperlab/Prefix.git
$ cd Prefix
$ swift build -c release -Xswiftc -static-stdlib
$ cd .build/x86_64-apple-macosx10.10/release
$ cp -f Prefix /usr/local/bin/prefix
```

#### Usage

From terminal go to your folder with swift files you want to add prefix and run:

```
$ prefix add PREFIX_NAME
```

and **Prefix** will create and subfolder with name PREFIX_NAME**Prefix** and put all changed files in.

# Template
> General description:
Dillinger is a cloud-enabled, mobile-ready, offline-storage, AngularJS powered HTML5 Markdown editor.

### Table of contents
* [General Informations](#general-info)
* [Prerequisites](#prerequisites)
* [Setup](#setup)
* [How to use](#how-to-use)
* [Todos](#todos)
* [Sources](#sources)
* [Status](#status)
* [How to Commit](#how-to-commit)

### General Informations
This project is a template supposed to blablabla.

### Prerequisites
| Technologies | Versions |
| ------ | ------ |
| Golang | 1.14 |
| Terraform | 1.XX |
| Kubernetes | 1.20 |


### Setup
```sh
$ docker build..
```

### How to use
**Helper**
```
===================================================
Welcome to go-DES
===================================================
Example:

$ go-DES -e "I am a message to encrypt": Will encrypt the message in binary
$ go-DES -e -b "I am a message to encrypt": Will encrypt the message in binary
$ go-DES -e -h "I am a message to encrypt": Will encrypt the message in hexadecimal
$ go-DES -e -b64 "I am a message to encrypt": Will encrypt the message in base64
$ go-DES -d -h "762336c2b5360cc38751": Will decrypt the hexadecimal message
===================================================
Arguments:

--help: Print this helper
-e: Encrypt a message
-d: Decrypt a message
-h: Use hexadecimal
-b64: Use base64
-b: Use binary
===================================================
```

### Todos
* Implement autocompletion
* Fix truc

### Sources
[pdf](google.com/pdf)

### Status
Project is: in progress, finished, no longer continue and why?

### How to commit
Here is a guide to make clean commit in this project.
```sh
$ git commit -m "[STATUS] Here is the message"
```
**Status**
* ADD : When you add a new file or a new function(ality)
* UPDATE : When you modify a function(ality)
* DONE : When you finish a task/function
* WIP : When your work still in progress
* BUG : In case you create a Bug ^^
* FIXED : When you fixed a bug

**Examples**
```
$ git commit -m "[ADD] newFunction()"
$ git commit -m "[DONE] Lambda x"
$ git commit -m "[WIP] missing return statement newFunction()"
$ git commit -m "[BUG] callLambda() don't work"
$ git commit -m "[FIXED] callLambda() don't work: API gateway did not allowed usage of GET method"
```
You can combine status
```
git commit -m "[WIP/BUG] still working on callLambda() bug"
```

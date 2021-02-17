## Description
`ls.c` implements the basic functionality of the typical command line function
 ls, including:
* listing files and directories (entries) in the directory specified by the
 first positional argument
* listing entries' size in bytes, time last modified (see TODO), and name

## Usage
1. From the same directory where `ls.c` is located:
```
# call for current (default) directory
> ./ls

# call for parent directory
> ./ls ../
```

## TODO
* Format epoch into human readable timestamps
* Format size into K(kilo), M(mega), etc.
* Include optional flags (the current implementation behaves as if these are set):
  * `l`: display full info; withouth this flag, only diplay entry names
  * `a`: display all entries;without this flag, ignore entries beginning with `.`
* Create help documentation

## Resources
* [ls manual](https://linuxcommand.org/lc3_man_pages/ls1.html)
* [***actual*** ls implementation](https://git.savannah.gnu.org/cgit/coreutils.git/tree/src/ls.c)

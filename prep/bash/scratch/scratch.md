## Parameter expansion
* Without quotes @$ and @* both expand into a list of positional parameters beginning with $1
* Within double quotes:
  *

## Math
* Use let or surround expressions in double brackets
```
let z=5 #equivalent to ((z = 5))
echo $z
5
let z=$z+1 #equivalent to ((z = z + 1))
echo $z
6
```

# Sources
[Positional arguments - The Geek Stuff](https://www.thegeekstuff.com/2010/05/bash-shell-special-parameters/)
[Bash guide](http://mywiki.wooledge.org/BashGuide)
* compile down to assembly 
```
> GOOS=linux GOARCH=amd64 go tool compile -S direct_topfunc_call.go
```
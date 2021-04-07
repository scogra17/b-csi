## Optimizing system
In order of priority: 
1) RPC calls (milliseconds, e.g. light takes approx 1/8th of a second to go around the equator)
2) Database queries (reason: reading from disk)
3) [rewatch letcture!]
x) Memory reads
x+1) CPU intensive tasks (single instruction takes nanoseconds to run)

## CPU -- simple vs. modern 

single cycle CPU 
("fetch, decode, execute"),      modern CPU
____________________________|________________
1 instruction/cycle         | superscalar (multiple instructions at the same stage at one time)
not pipelined               | pipelined (each part of the CPU is in use)
                            | branch prediction
                            | speculative execution
                            | out of order (ooo) execution
                            |
                            |

* Due to pipelining, incorrect branch prediction is very costly. For this reason, minimize branching. 
* If you repeat certain branching patterns, the branch prediction will be better than if not

## Misc notes 
* mov r10, r11 // this won't take even a single CPU cycle since the registers can be re-named to reflect the change
* In multi core systems (semantic multi-plexing), different "threads" share access to the same memory, but are processed on separate cores 
	* Additionally, due to Umdaws law (sp?), the non parallelizable portions will come to dominate the programs execution time 	

## References 
[common latencies](colin-scott.github.io/personal_website/research/interactive_latency.html)
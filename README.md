# R-Benchmark
This repository contains an R benchmark for single and multithreaded workloads.

# Results

| CPU               | Cores/Threads | Memory | OS      | single-threaded (in secs) | multi-threaed on 2 threads (in secs) | multi-threaed on 4 threads (in secs) | multi-threaded on all threads (in secs) |
| ----------------- | ------------- | ------ | ------- | ------------------------- | ------------------------------------ | ------------------------------------ | --------------------------------------- |
| AMD Ryzen 7 3700X | 8/16          | 16 GB  | Windows | 37.079                    | 29.086                               | 17.495                               | 12.961                                  |
| AMD Ryzen 9 5900X | 12/24         | 64 GB  | Linux   | 24.667                    | 19.958                               | 12.837                               | 11.972                                  |
| Apple M1 (ARM)    | 8 (4e/4p)/ NA | 16 GB  | MacOS   | 19.089                    | 18.73                                | 12.333                               | 11.335                                  |
| Apple M1 Pro (ARM)    | 8 (6e/2p)/ NA | 16 GB  | MacOS   | 19.267                    | 19.556                                | 12.434                               | 9.926                                  |
| Intel Core i5 6600k    | 4/4         | 16 GB  | Windows  | 44.462                    | 33.341                                | 24.534                               | 24.534                                  |

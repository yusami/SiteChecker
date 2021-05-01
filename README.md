# SiteChecker

## Overview

* Check multiple sites by ruby.

## Description

1. Read configs from the file. (`config.json`)
2. Connect each site.
3. Show the summary.

## Requirement

* Ruby 2.7

## Usage

~~~
$ ruby runner.rb
~~~

## Example

~~~
$ ruby runner.rb
Reading config...
["https://www.google.com/", "https://www.example-abcdef.com/"]
Checking site...
-https://www.google.com/: 200
-https://www.example-abcdef.com/: Failed to open TCP connection to www.example-abcdef.com:443 (getaddrinfo: nodename nor servname provided, or not known)
-Total: 2, Success: 1, Failure: 1
~~~

## Licence

* Copyright &copy; 2020-2021 yusami
* Licensed under the [Apache License, Version 2.0][Apache]

[Apache]: http://www.apache.org/licenses/LICENSE-2.0


## Author

* [yusami](https://github.com/yusami)

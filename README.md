## Overview

noderunner is the service used by codewars.com to evaluate javascript and coffeescript code. 
Currently Codewars supports these two languages as well as Ruby, which is ran using a separate project since it runs on jruby.

## Design

noderunner is based off of the https://github.com/gf3/sandbox node package. It executes JavaScript within a sandbox environment. 
In the future, as noderunner is expanded to support other languages, it will probably be made to execute code within sandboxed
processes utilizing Linux containers. 


## More Info

Consult the wiki for more information on how noderunner works in tandem with codewars.com. 

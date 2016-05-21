# Caesar

A small web application to allow people to give a 👍 or 👎 on planning
applications near them.

This prototype was made at the OpenAustralia Hackfest in April 2016, and is very
rough around the edges. Please don't try to use it for anything serious.

## Prerequisites

- Ruby 2.3.0
- PostgreSQL

## Quick start

```
bundle install
bin/rake db:setup
bin/puma -p 5000
open http://localhost:5000/applications/1/yes
```

## Licence

This project is released in the public domain.

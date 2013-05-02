# Overview #

Send is a quick way to send messages, via multiple transports from the
command line.

Uses the very nice [nodemailer](https://github.com/andris9/Nodemailer),
and wraps it with a command line interface that takes yaml formatted
messages, leverages environment variables.

# Messages #

Here is a nice sample, in yaml:

```yaml
from: someone@somewhere.com
to: you@elsewhere.com
cc: super@friends.com
subject: Greetings
text: Raw text
html: <b>Less Raw text<b>

```

You can check the docs for `nodemailer`, this is just a passthrough.


The most important thing is to check with `send -help`, which will have
the latest docs.



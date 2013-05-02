Main command line entry point.

    docopt = require 'docopt'
    path = require 'nodemailer'
    yaml = require 'js-yaml'
    fs = require 'fs'
    nodemailer = require 'nodemailer'

Actual command line processing via docopt.

    require.extensions['.docopt'] = (module, filename) ->
        doc = fs.readFileSync filename, 'utf8'
        module.exports =
            options: docopt.docopt doc, version: require('../package.json').version
            help: doc
    cli = require './cli.docopt'

Full on help.

    if cli.options['--help']
        console.log cli.help


Read standard in, sending this along to a passed sender function.

    send = (sender) ->
        buffers = []
        process.stdin.on 'data', (chunk) ->
            buffers.push chunk
        process.stdin.on 'end', ->
            context = yaml.safeLoad(Buffer.concat(buffers).toString())
            console.log yaml.safeDump(context)
            sender context

Here are the sub command handlers.

    ses = (options) ->
        transport = nodemailer.createTransport "SES",
            AWSAccessKeyID: options['--access-key'] or process.env['AWS_ACCESS_KEY_ID']
            AWSSecretKey: options['--secret-key'] or process.env['AWS_SECRET_ACCESS_KEY']
        (context) ->
            transport.sendMail context, (err, out) ->
                if err
                    console.error err
                    process.exit 1
                else
                    process.exit 0


Start it up!

    console.log cli.options
    cli.options.ses and send(ses cli.options)
    process.stdin.resume()

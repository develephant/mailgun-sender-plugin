
```lua
-- Require the Mailgun Sender plugin
local mailgun = require "plugin.mailgun-sender"

-- Set your Mailgun credentials
local mg_key = "<mailgun-api-key>"
local mg_domain = "<mailgun-sending-domain>"

-- Create a new Mailgun Sender message object
local msg = mailgun.new(mg_key, mg_domain)

-- Populate the message to be sent
msg:to("Chris <from-email-address>")
msg:from("<to-email-address>")
msg:subject("This is a Mailgun message.")
msg:text("This is the text version of the email.")
msg:html("<b>This is the html version of the email.</b>")

-- Create a "send" response listener
local function onSendResult( evt )
  if evt.isError then
    print(evt.error)
  else
    print(evt.response)
  end
end

-- Send the message
msg:send( onSendResult )
```
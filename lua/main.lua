--#############################################################################
--# MailGun sender plugin
--#(c)2017 C. Byerley (develephant.com)
--#############################################################################

local mailgun = require "plugin.mailgun-sender"

local mg_key = "<mailgun-api-key"
local mg_domain = "<mailgun-sending-domain>"

local msg = mailgun.new( mg_key, mg_domain )

msg:to( "Chris <from-email-address>" )
msg:from( "<to-email-address>" )
msg:subject( "This is a MailGun message." )
msg:text( "This is the text version of the email." )
msg:html( "<b>This is the html version of the email.</b>" )

local function onSendResult( evt )
  if evt.isError then
    print(evt.error)
  else
    print(evt.response)
  end
end

msg:send( onSendResult )
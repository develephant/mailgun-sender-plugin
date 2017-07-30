-- 
-- Abstract: mailgun-sender Library Plugin Test Project
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2015 Corona Labs Inc. All Rights Reserved.
--
------------------------------------------------------------

-- Load plugin library
local mailgun = require "plugin.mailgun-sender"

local mg_key = "key-4fbda5dca9b40f5a824a2802f6984920"
local mg_domain = "sandbox837048be26554cd6b6802684fa1f6ef4.mailgun.org"

local msg = mailgun.new( mg_key, mg_domain )

msg:to( "Chris <cbyerley@develephant.com>" )
msg:from( "cbyerley@gmail.com" )
msg:subject( "Hello from my testing account." )
msg:text( "This is a text message version of the email." )
msg:html( "<b>Hello this is a html testing content.</b>" )
msg:tag("appmail")
msg:testMode( true )
msg:requireTls( true )

local function onSendResult( evt )
  if evt.isError then
    print(evt.error)
  else
    print(evt.response)
  end
end

msg:send( onSendResult )
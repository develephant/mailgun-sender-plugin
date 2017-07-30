--#############################################################################
--# MailGun sender plugin
--#(c)2017 C. Byerley (develephant.com)
--#############################################################################
local Library = require "CoronaLibrary"

local lib = Library:new{ name='mailgun-sender', publisherId='com.develephant' }

local mime = require("mime")
local b64 = mime.encode("base64")

local api = {
  key = nil,
  domain = nil,
  debug = nil
}

api.data = {
  from = nil,
  to = nil,
  cc = nil,
  bcc = nil,
  subject = nil,
  text = nil,
  html = nil,
  ["o:tag"] = nil, 
  ["o:campaign"] = nil,
  ["o:testmode"] = nil,
  ["o:require-tls"] = nil,
  ["o:skip-verification"] = nil,
  ["h:Reply-To"] = nil
}

function api:to( ... )
  local addresses = { ... }
  self.data.to = table.concat(addresses, ",")
end

function api:from( from_address )
  self.data.from = from_address
end

function api:cc( ... )
  local addresses = { ... }
  self.data.cc = table.concat(addresses, ",")
end

function api:bcc( ... )
  local addresses = { ... }
  self.data.bcc = table.concat(addresses, ",")
end

function api:subject( subject_txt )
  self.data.subject = subject_txt
end

function api:text( msg_text )
  self.data.text = msg_text
end

function api:html( msg_html )
  self.data.html = msg_html
end

function api:tag( tag_str )
  self.data["o:tag"] = tag_str
end

function api:campaign( campaign_str )
  self.data["o:campaign"] = campaign_str
end

function api:testMode( mode_bool )
  if mode_bool == true then
    mode_bool = "yes"
  else
    mode_bool = "no"
  end

  self.data["o:testmode"] = mode_bool
end

function api:requireTls( tls_bool )
  if tls_bool == true then
    tls_bool = "True"
  else
    tls_bool = "False"
  end

  self.data["o:require-tls"] = tls_bool
end

function api:skipVerification( verify_bool )
  if verify_bool == true then
    verify_bool = "True"
  else
    verify_bool = "False"
  end

  self.data["o:skip-verification"] = verify_bool
end

function api:replyTo( reply_to_str )
  self.data["h:Reply-To"] = reply_to_str
end

function api:send( listener )

  local url = "https://api.mailgun.net/v3/"..self.domain.."/messages"

  local headers = {
    ["Content-Type"] = "application/x-www-form-urlencoded",
    ["Authentication"] = b64("api:"..self.key)
  }

  local form = {}
  for k, v in pairs(self.data) do 
    table.insert(form, (k.."="..v))
  end

  form = table.concat(form, "&")
  
  assert(form, "Please provide values to the message object.")

  if self.debug then
    print( form )
  end

  local params = {}
  params.body = form
  params.headers = headers

  return network.request(url, "POST", listener, params)
end

function lib.new( key, domain )

  assert(key, "An API key value is required to send a message.")
  assert(domain, "A domain value is required to send a message.")

  local msgObj = setmetatable({key=key, domain=domain}, {__index=api})

  return msgObj
end

return lib

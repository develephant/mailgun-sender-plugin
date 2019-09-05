
# Mailgun Sender

---

## new

Create a new Mailgun message object.

__Syntax__

```lua
mailgun.new( key, domain[, region] )
```

__Returns__

A new message object.

__Parameters__

|Name|Description|Type|Required|
|----|-----------|----|--------|
|key|Your Mailgun API key.|String|Y|
|domain|Your verified Mailgun domain.|String|Y|
|region|API region endpoint. Possible options are `US` and `EU`. The region is set to `US` by default.|String|N|

__Example__

___US endpoint___:

```lua
local msg = mailgun.new( "key-abcdef12345", "verified.mailgun.domain" )
```

___EU endpoint___:

```lua
local msg = mailgun.new( "key-abcdef12345", "verified.mailgun.domain", "EU" )
```

__Note__

You can create multple instances of the message object:

```lua
local msg1 = mailgun.new(key, domain)
local msg2 = mailgun.new(key, domain)
```

---

# Message Object

---

## :to

The address(es) to send the message to. Multiple values must be seperated by a comma. ___This is a required value___.

__Syntax__

```lua
msg:to( address[, addressN] )
```

__Parameters__

|Name|Description|Type|
|----|-----------|----|
|address|The recipient address(es).|String|

__Examples__

_Single address:_

```lua
--Address only
msg:to("user@email.com")

--With name
msg:to("Chris <user@email.com>")
```

_Multiple addresses:_

```lua
msg:to("user1@email.com", "Jim <user2@email.com>")
```

---

## :from

The message sender address. ___This is a required value___.

__Syntax__

```lua
msg:from( address )
```

__Parameters__

|Name|Description|Type|
|----|-----------|----|
|address|The sender address.|String|

__Example__

```lua
msg:from("sender@email.com")
```

---

## :cc

The address(es) to "cc" the message to. Multiple values must be seperated by a comma.

__Syntax__

```lua
msg:cc( address[, addressN] )
```

__Parameters__

|Name|Description|Type|
|----|-----------|----|
|address|The "cc" address(es).|String|

__Examples__

_Single address:_

```lua
--Address only
msg:cc("user@email.com")

--With name
msg:cc("Chris <user@email.com>")
```

_Multiple addresses:_

```lua
msg:cc("user1@email.com", "Jim <user2@email.com>")
```

---

## :bcc

The address(es) to "bcc" the message to. Multiple values must be seperated by a comma.

__Syntax__

```lua
msg:bcc( address[, addressN] )
```

__Parameters__

|Name|Description|Type|
|----|-----------|----|
|address|The "bcc" address(es).|String|

__Examples__

_Single address:_

```lua
--Address only
msg:bcc("user@email.com")

--With name
msg:bcc("Chris <user@email.com>")
```

_Multiple addresses:_

```lua
msg:bcc("user1@email.com", "Jim <user2@email.com>")
```

---

## :replyTo

Sets a specific reply-to address. If not set, the sender address is the default.

__Syntax__

```lua
msg:replyTo( address )
```

__Parameters__

|Name|Description|Type|
|----|-----------|----|
|address|A specific reply-to address.|String|

__Example__

```lua
msg:replyTo("Support <support@email.com>")
```

---

## :subject

The subject line for the email. The default is "(no subject)" if not provided.

__Syntax__

```lua
msg:subject( subject_str )
```

__Parameters__

|Name|Description|Type|
|----|-----------|----|
|subject_str|The subject title.|String|

__Example__

```lua
msg:subject("A Super Email")
```

---

## :text

The plain text version of the message body.

__Syntax__

```lua
msg:text( message_str )
```

__Parameters__

|Name|Description|Type|
|----|-----------|----|
|message_str|A plain string message.|String|

__Example__

```lua
msg:text("Here is your plain information.")
```

---

## :html

The html version of the message body.

__Syntax__

```lua
msg:html( message_html )
```

__Parameters__

|Name|Description|Type|
|----|-----------|----|
|message_html|An html string message.|String|

__Example__

```lua
msg:html("Here is your <b>bold</b> information.")
```

---

## :tag

Sets a specific tag for the email. Can be used for tracking in Mailgun.

__Syntax__

```lua
msg:tag( tag_str )
```

__Parameters__

|Name|Description|Type|
|----|-----------|----|
|tag_str|A string tag for tracking.|String|

__Example__

```lua
msg:tag("appuser")
```

---

## :requireTls

Force Mailgun to use TLS when sending the message. Defaults to _false_.

__Syntax__

```lua
msg:requireTls( bool )
```

__Parameters__

|Name|Description|Type|
|----|-----------|----|
|bool|Whether to enable TLS for this message.|Boolean|

__Example__

```lua
msg:requireTls(true)
```

---

## :skipVerification

Skip certificate verification when using TLS. Defaults to _false_.

__Syntax__

```lua
msg:skipVerification( bool )
```

__Parameters__

|Name|Description|Type|
|----|-----------|----|
|bool|Whether to skip verification in TLS.|Boolean|

__Example__

```lua
msg:skipVerification(true)
```

---

## :testMode

Used for debugging in Mailgun. Defaults to _false_.

__Syntax__

```lua
msg:testMode( bool )
```

__Parameters__

|Name|Description|Type|
|----|-----------|----|
|bool|Whether to enable test mode.|Boolean|

__Example__

```lua
msg:testMode(true)
```

---

## :send

Send the final message via Mailgun.

__Syntax__

```lua
msg:send( [listener] )
```

__Parameters__

|Name|Description|Type|Required|
|----|-----------|----|--------|
|listener|A network listener function.|Function|N|

__Example__

```lua
local function onSendResponse( evt )
  if evt.isError then
    print(evt.error)
  else
    print(evt.response)
  end
end

msg:send(onSendResponse)
```

---
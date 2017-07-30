![logo](imgs/logo256.png)

# Mailgun Sender

___A simple [Mailgun](https://www.mailgun.com/) plugin for sending email with [Corona](https://coronalabs.com).___

!!! note
    This plugin provides limited support for the Mailgun API. In particular, there is no support for attachments.
    
## Get the Plugin

You will need the __Mailgun Sender__ plugin available in the __[Corona Marketplace](https://marketplace.coronalabs.com/plugin/mailgun-sender)__.

## Add the Plugin

Add the plugin by adding an entry to the plugins table of your __build.settings__ file:

```sh
settings =
{
    plugins =
    {
        ["plugin.mailgun-sender"] =
        {
            publisherId = "com.develephant"
        },
    },
}
```

## Load the Plugin

In your project "require" the plugin:

```lua
local mailgun = require("plugin.mailgun-sender")
```

You're now ready to use the __Mailgun Sender__ plugin in your project.

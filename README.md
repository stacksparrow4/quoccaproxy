# Quoccaproxy

This app creates a local webserver which adds MTLS to your quoccabank requests, meaning you don't need to configure your tools to use a proxy.

## Usage:

1. Download this repo
1. Download your p12 file using [mtls.quoccabank.com](https://mtls.quoccabank.com)
1. Place the file inside this repo, and rename it to `quocca.p12`
1. Create a new file called `pass.key` and paste the password for your p12 certificate inside it
1. Download docker for your platform
1. Run `docker compose up --build` inside this directory. This will start the server
1. Edit your hosts file (`c:\Windows\System32\Drivers\etc\hosts` on windows, `/etc/hosts` on other systems). Add a line to forward a quoccabank site to 127.0.0.1.

    Add the following line:

    ```
    127.0.0.1 www.quoccabank.com haas.quoccabank.com
    ```

    (You can add more subdomains here. You will need to update this file each time you want another site to be forwarded through the proxy)
1. Once this is done, test it out by visiting [`http://www.quoccabank.com/`](http://www.quoccabank.com/) in a browser. Or even better, try using a command line tool. Without the proxy you should need to specify extra command line options to use mtls, but you should now be able to do `curl http://www.quoccabank.com` without any errors.

## FAQ

**Should I use this all the time?**

I would recommend only enabling it if you want to do scripting or use command line tools and don't want to troubleshoot getting these tools to use your mtls certificate. Because of the way the setup works, only the sites listed in your hosts file will go through the proxy, everything else will be unaffected.

**Help, quoccabank is no longer responding!**

Your `docker compose up --build` command may have stopped. Simply run it again to start the webserver.

If all else fails, you can remove the line you added from your hosts file to stop using the proxy altogether.

**Can't connect?**

Make sure you are using HTTP and not HTTPS. The proxy only listens on HTTP.

**SSL error in the browser?**

The site may have a HSTS record. Google for "how to remove HSTS cache in <insert browser here>".

**Does this work with burp?**

It should.

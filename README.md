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
    127.0.0.1 www.quoccabank.com haas.quoccabank.com whoami.quoccabank.com
    ```

    (You can add more subdomains here. You will need to update this file each time you want another site to be forwarded through the proxy)
1. Once this is done, test it out using `curl http://whoami.quoccabank.com`. **You should not need to specify any certificates**, and you should recieve the whoami flag. (This should also work in the browser, but it is easier to tell if you are sending certificates in the command line)
1. You should also be able to see the requests inside the terminal in which you ran `docker compose up --build`.

> Note: the proxy only listens on http. If you end up with https in the url (some browsers like to add it if you failed to connect to a site), it will not work. If you are having issues remember to check you are using http and not https.

## FAQ

**Should I use this all the time?**

I would recommend **only enabling it if you want to do scripting or use command line tools** and don't want to troubleshoot getting these tools to use your mtls certificate. Because of the way the setup works, only the sites listed in your hosts file will go through the proxy, everything else will be unaffected.

The reason why you should NOT use this:

1. You have to modify your hosts file for each site
1. It may make tiny changes (eg. changing the order of HTTP headers) which may be important in later challenges

**I can't connect to my proxied quoccabank site!**

1. Your `docker compose up --build` command may have stopped. Simply run it again to start the webserver.
1. Make sure you are using HTTP and not HTTPS. The proxy only listens on HTTP.
1. If all else fails, you can remove the line you added from your hosts file to stop using the proxy altogether.

**My browser is not connecting to quoccaproxy even though I added the /etc/hosts record**

Your browser may be using DNS over HTTPS, in which case you will need to google on how to disable this.

**SSL error in the browser?**

The site may have a HSTS record. Google for `how to remove HSTS cache in <insert browser here>`.

**Does this work with burp?**

Yes.

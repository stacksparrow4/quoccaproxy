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
1. Once this is done, test it out by visiting [`http://www.quoccabank.com/`](http://www.quoccabank.com/) in a browser.

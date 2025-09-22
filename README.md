# tailscale-onion-proxy

This creates a tailscale-exit-node through which you can access the tor network.

``` bash
nano .env # add an auth-key from tailscale and the tailscale ip of your new exit-node
docker compose up -d
```

After the first start you will see your tor-exit-node in tailnet under https://login.tailscale.com/admin/machines.
Allow it to be an exit node https://tailscale.com/kb/1103/exit-nodes#allow-the-exit-node-from-the-admin-console.

Copy the tailscale-internal-IP of your tor-exit-node and add it as TAILSCALE_IP to the .env file and do a docker compose up -d again so the dns service will resolve domains to the new IP.

``` bash
docker compose up -d
```

Now you can use your new tor-exit-node!

Browser actively block you from accessing .onion sites, to get around this we use .carrot.
This should be totally transparent to the .onion site.

You can test it by accessing my blog http://simonja4fdp3lxdjeis5qjuugqe3wtbstlr2w7gmzsrnhhkpctmbgead.carrot/blog

## Explanation

There are 4 services:
1. tor - provides the access to the tor network
2. tailscale - provides the access to your tailnet
3. dns - resolves all .carrot domains to the IP of your tailscale exit node hosting a nginx reverse proxy
4. nginx - the reverse proxy that replaces .carrot with .onion in the header and sends the request to tor, in the response from tor occurrences of .onion get replaced with .carrot

credits to https://www.reddit.com/user/StatisticianMinute18/ for posting https://www.reddit.com/r/Tailscale/comments/1mm2mwd/access_to_tor_via_tailscale_exit_node_working_100/

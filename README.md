# tailscale-onion-proxy

This creates a tailscale-exit-node through which you can access the tor network.

``` bash
nano .env # add an auth-key from tailscale
docker compose up -d
docker compose exec tailscale sh /post-rules.sh
```

Browser actively block you from accessing .onion sites, to get around this we use .carrot.
But the server running the hidden service must also respond to other domains then just .onion for this to work.

You can test it by accessing my blog http://simonja4fdp3lxdjeis5qjuugqe3wtbstlr2w7gmzsrnhhkpctmbgead.carrot/blog

credits to https://www.reddit.com/user/StatisticianMinute18/ for posting https://www.reddit.com/r/Tailscale/comments/1mm2mwd/access_to_tor_via_tailscale_exit_node_working_100/

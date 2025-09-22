#apk add redsocks # needed to forward tcp/udp traffic with iptables

# Start redsocks in background
redsocks -c /etc/redsocks.conf &

# Allow local traffic
iptables -t nat -A OUTPUT -d 127.0.0.1 -j RETURN        # local
#iptables -t nat -A OUTPUT -d 172.96.0.21 -j RETURN      # tor container
iptables -t nat -A OUTPUT -d 172.96.0.30 -j RETURN      # nginx container
iptables -t nat -A OUTPUT -d 172.96.0.25 -j RETURN      # coredns container
#iptables -t nat -A OUTPUT -d <your-headscale-server> -j RETURN   # if you have a custom headscale server

# Redirect all TCP traffic to redsocks TCP port
iptables -t nat -A OUTPUT -p tcp -j REDIRECT --to-ports 12345

# Redirect all UDP traffic except DNS to redsocks UDP port
iptables -t nat -A OUTPUT -p udp --dport 53 -j RETURN
iptables -t nat -A OUTPUT -p udp -j REDIRECT --to-ports 10053

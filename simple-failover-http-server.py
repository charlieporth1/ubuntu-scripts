#!/usr/bin/env python3
import http.server, ssl

cert_dir = '/etc/letsencrypt/live/gcp.pihole.ctptech.dev/fullchain.pem'
server_address = ('0.0.0.0', 443)

httpd = http.server.HTTPServer(server_address, http.server.SimpleHTTPRequestHandler)
httpd.socket = ssl.wrap_socket(httpd.socket,
                               server_side=True,
                               certfile=cert_dir,
                               ssl_version=ssl.PROTOCOL_TLS)
httpd.serve_forever()

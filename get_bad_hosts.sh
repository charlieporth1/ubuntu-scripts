#!/bin/bash
IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"
curl --header "X-HoneyDb-ApiId: d0a5058d7c0477caf0e29f7396d229c5bfd27dc154d66ea3cd36278378f9d7c9" \
        --header "X-HoneyDb-ApiKey: 7fbaa583dbe35f8368251a7e83e49ba8f92aff105bbc2efb839a2ef5501db6fc" \
        https://honeydb.io/api/bad-hosts | grep -oE "${IP_REGEX}"

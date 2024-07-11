function seecert --description 'nslookup and openssl s_client -showcerts in one command'
    nslookup $argv
    echo "Q" | openssl s_client -showcerts -servername $argv -connect $argv:443 | openssl x509 -text | grep -iA2 "Validity"
end

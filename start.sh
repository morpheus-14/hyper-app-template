
case "$(uname -s)" in
  Darwin )
    ip=`ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2`
    ;;
  Linux )
    ip=`ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d: -f2 | awk '{ print $1 }'`
    ;;
esac

echo $ip
npx webpack-dev-server --content-base dist/ --host $ip --port 8080

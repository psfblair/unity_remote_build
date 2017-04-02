#/bin/sh

# NOTE: Before running this script for the first time, initialize /etc/hosts with 
# your remote host using the following line as a template (without the #):
# 0.0.0.0 <REMOTE_HOST>

if [ -z "$REMOTE_USER" ] || [ -z "$REMOTE_HOST" ] || [[ -z $LOCAL_MOUNT_POINT ]]
then
  echo
  echo "ERROR: $0 requires the REMOTE_USER, REMOTE_HOST, and LOCAL_MOUNT_POINT" 
  echo "variables to be set in the environment."
  echo "REMOTE_USER: $REMOTE_USER"
  echo "REMOTE_HOST: $REMOTE_HOST"
  echo "LOCAL_MOUNT_POINT: $LOCAL_MOUNT_POINT"
  echo 
  exit 1
fi


# May need to modify this for whatever directory the rdp files get downloaded to
RDP_FILE=`ls -tr ~/Downloads/*.rdp | tail -1`

# sed -E is for OS X, use sed -r on linux
IP_ADDRESS=`cat "$RDP_FILE" | grep 'address' | sed -E 's/.*s:(.*):[[:digit:]]+/\1/' | tr -d '\015' | tr -d '\012'`

echo "Modifying /etc/hosts..."
echo "sudo password for your local workstation:"
sudo sed -e 's/.*'"$REMOTE_HOST/$IP_ADDRESS $REMOTE_HOST/" -i old /etc/hosts

open "$RDP_FILE"

echo "Mounting remote Users directory..."
mount -t smbfs "//$REMOTE_USER@$IP_ADDRESS/Users" "$LOCAL_MOUNT_POINT"

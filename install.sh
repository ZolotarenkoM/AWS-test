#!/bin/bash
function yum_install() {
  local PACKAGE="$1";
  while ! yum install -y "${PACKAGE}"; do
  echo "Failed to install ${PACKAGE}"
  sleep 15
  echo "Trying again."
  done
}
yum -y update && yum_install aws-cfn-bootstrap
instance=`curl http://169.254.169.254/latest/meta-data/instance-id`
region=`curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | awk -F\" '/region/ {print $4}'`
hostnamectl set-hostname qa-web-$instance.$region.amazonaws.com

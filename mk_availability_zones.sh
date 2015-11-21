#!/bin/bash
set -euo pipefail

function list_availabilty_zones() {
  for zone in $(aws ec2 describe-regions | jq -r '.Regions[].RegionName'); do
	echo -n "$zone = "
	echo $(aws ec2 describe-availability-zones --region="$zone" | aws ec2 describe-availability-zones| jq -c '[.AvailabilityZones[].ZoneName]|join(",")')
  done
}

function main() {
local azs=$(list_availabilty_zones)
  cat << EOF
variable "aws_availability_zones" {
    default = {
$azs
    }
}
EOF
} 

main

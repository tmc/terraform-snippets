all: aws_availability_zones.tf

aws_availability_zones.tf: ./mk_availability_zones.sh
	bash ./mk_availability_zones.sh > $@

#!/bin/bash -e

if [ $(id -u) -eq 0 ]; then
    mkdir -p $SNAP_COMMON/keystone.conf.d
    sed -e "s|__SNAP_DATA__|$SNAP_COMMON|g" \
        -e "s|__SNAP__|$SNAP|g" \
        $SNAP/templates/keystone-snap.conf > $SNAP_COMMON/keystone.conf.d/keystone-snap.conf
fi

/usr/bin/env uwsgi --master --emperor /etc/uwsgi &

source /etc/apache2/envvars
export APACHE_DIR="apache2"
/usr/sbin/apache2 -DFOREGROUND
#/usr/bin/env python "$SNAP/usr/bin/$1" --config-file=$SNAP/etc/keystone/keystone.conf "${@:2}"

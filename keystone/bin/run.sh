#!/bin/bash -e

if [ $(id -u) -eq 0 ]; then
    mkdir -p $SNAP_COMMON/keystone.conf.d
    sed -e "s|__SNAP_DATA__|$SNAP_COMMON|g" \
        -e "s|__SNAP__|$SNAP|g" \
        $SNAP/templates/keystone-snap.conf > $SNAP_COMMON/keystone.conf.d/keystone-snap.conf
fi

exec "$SNAP/usr/bin/python2" "$SNAP/usr/bin/$1" --config-file=$SNAP/etc/keystone/keystone.conf --config-dir=$SNAP_COMMON/keystone.conf.d "${@:2}"

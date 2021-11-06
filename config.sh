#!/bin/env bash

set -eo pipefail
# Variables
GRP="TI6"
PREFIX="192.214"
DNS="192.168.122.1"
ENIESLOBBY_IP="$PREFIX.2.2"
WATER7_IP="$PREFIX.2.3"
LOGUETOWN_IP="$PREFIX.1.2"
ALABASTA_IP="$PREFIX.1.3"
JIPANGU_IP="$PREFIX.1.4"

FOOSHA_e1_IP="$PREFIX.1.1"
FOOSHA_e2_IP="$PREFIX.2.1"
ENIESLOBBY_IP_REV="$(echo $ENIESLOBBY_IP | sed -r 's/([^\.]*)\.([^\.]*)\.([^\.]*)\.([^\.]*)/\3\.\2\.\1/')"
PTR_RECORD="$ENIESLOBBY_IP_REV.in-addr.arpa"

# Router
function Foosha {
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.214.0.0/16
    apt update
}

# Server
function EniesLobby {
    echo nameserver 192.168.122.1 > /etc/resolv.conf
	apt update
}

function Water7 {
    echo nameserver 192.168.122.1 > /etc/resolv.conf
    apt update
}

# Client
function Loguetown {
    echo nameserver 192.168.122.1 > /etc/resolv.conf
	apt update
}

function Alabasta {
    echo nameserver 192.168.122.1 > /etc/resolv.conf
	apt update
}

function Jipangu {
    echo nameserver 192.168.122.1 > /etc/resolv.conf
	apt update
}
function host-is { [[ $HOSTNAME = "$1" ]] && return 0 || return 1; }

function update {
	local last_update = $(stat -c '%y' /var/cache/apt)
}

if host-is Foosha; then
	Foosha
elif host-is EniesLobby; then
	EniesLobby
elif host-is Water7; then
	Water7
elif host-is Jipangu; then
	Jipangu
elif host-is Loguetown; then
	Loguetown
elif host-is Alabasta; then
	Alabasta
fi
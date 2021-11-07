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

TOTTOLAND_IP="$PREFIX.3.2"
SKYPIE_IP="$PREFIX.3.3"

FOOSHA_e1_IP="$PREFIX.1.1"
FOOSHA_e2_IP="$PREFIX.2.1"
ENIESLOBBY_IP_REV="$(echo $ENIESLOBBY_IP | sed -r 's/([^\.]*)\.([^\.]*)\.([^\.]*)\.([^\.]*)/\3\.\2\.\1/')"
PTR_RECORD="$ENIESLOBBY_IP_REV.in-addr.arpa"

# Router
function Foosha {
    apt update
    apt-get install isc-dhcp-relay -y
}

# Server
function EniesLobby {
	apt update
}

function Water7 {
    apt update
}

function Jipangu {
	apt update
    apt-get install isc-dhcp-server -y
    sed -i -e 's/INTERFACES=""/g' -e 's/INTERFACES="eth0"/g' /etc/default/isc-dhcp-server
}

# Client Switch 1
function Loguetown {
	apt update
}

function Alabasta {
	apt update
}

# Client Switch 2
function TottoLand {
	apt update
}

function Skypie {
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
elif host-is TottoLand; then
	TottoLand
elif host-is Skypie; then
	Skypie
fi
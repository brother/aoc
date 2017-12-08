#!/bin/bash

inarray() { local q=$1 e; shift; (( $# )) && for e; do [[ $q = "$e" ]] && return; done; }

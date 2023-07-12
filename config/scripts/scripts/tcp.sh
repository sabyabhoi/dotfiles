#!/usr/bin/sh

socat TCP4-LISTEN:8080,fork,reuseaddr EXEC:/tmp/app/app

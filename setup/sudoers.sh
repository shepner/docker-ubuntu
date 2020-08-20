#!/bin/sh

# Remove what little bits of pesky security we have
echo "`id -un` ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo

#!/bin/bash
clear
_secure_token_user="${1:-$USER}"
echo Updating secure token for $_secure_token_user...
sysadminctl interactive -secureTokenOn "$_secure_token_user" -password -
sysadminctl -secureTokenStatus "$_secure_token_user"

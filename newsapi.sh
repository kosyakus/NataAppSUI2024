#!/bin/sh

#  newsapi.sh
#  NataAppSUI2024
#
#  Created by Natalia Sinitsyna on 09.09.2024.
#  

MODULE="Modules/NewsAPI/Sources/NewsAPI"

openapi-generator generate -i "newsapi.yaml" -g swift5 -o "newsapi"
rm -r $MODULE""*
cp -R "newsapi/OpenAPIClient/Classes/OpenAPIs/". $MODULE
rm -r "newsapi"

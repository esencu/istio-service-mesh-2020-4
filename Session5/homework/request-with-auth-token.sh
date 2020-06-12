#!/bin/bash

if [[ -z ${ISTIO_LESSONS_AUTH_TOKEN+x} ]]; then
   echo Get AUTH TOKEN
   ISTIO_LESSONS_AUTH_TOKEN=$(curl --request POST --url https://dev-odessa.eu.auth0.com/oauth/token --header 'content-type: application/json' --data '{"client_id":"kXl87M0AifuLlAl319ALRRLtCnCTXuF9","client_secret":"FQsVvRJ0GpUqNwC9-sC_jcarNxMPaQEVTdEQUhVufsoxus1TlYSH9OkRVHyQqSqy","audience":"https://istio-lessons.io","grant_type":"client_credentials"}' -s | jq '.access_token')
   echo ISTIO_LESSONS_AUTH_TOKEN $ISTIO_LESSONS_AUTH_TOKEN
fi
curl --request GET --url http://localhost/frontend-catalog/api/v1/dashboard --header "Authorization: Bearer $ISTIO_LESSONS_AUTH_TOKEN" -s | jq .


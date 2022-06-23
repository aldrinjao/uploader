#!/bin/bash

# read from args
username="rump-conflictalert"
tilesetName="kapai_hazard"
# get from notebook
accessToken=""
fileName="hazard.mbtiles"

curl -X POST "https://api.mapbox.com/uploads/v1/rump-conflictalert/credentials?access_token=$accessToken" -o creds.json




varbucket=($(jq -r '.bucket' creds.json))
varkey=($(jq -r '.key' creds.json))
varaccessKeyId=($(jq -r  '.accessKeyId' creds.json))
varsecretAccessKey=($(jq -r  '.secretAccessKey' creds.json))
varsessionToken=($(jq  -r '.sessionToken' creds.json))
varurl=($(jq -r  '.url' creds.json))


export AWS_ACCESS_KEY_ID=${varaccessKeyId}
export AWS_SECRET_ACCESS_KEY=${varsecretAccessKey}
export AWS_SESSION_TOKEN=${varsessionToken}


printf "\nupload to AWS S3:\n\n"

aws s3 cp ${fileName} s3://${varbucket}/${varkey} --region us-east-1


printf "\n\n copy and paste this to the command line to upload S3 to mapbox\n\n"

echo "curl -X POST -H \"Content-Type: application/json\" -H \"Cache-Control: no-cache\" -d '{\"url\": \"http://${varbucket}.s3.amazonaws.com/${varkey}\",\"tileset\": \"rump-conflictalert.${tilesetName}\"}' 'https://api.mapbox.com/uploads/v1/rump-conflictalert?access_token=${accessToken}'"


# kailangan zip the file through the command line

# curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '{"url": "http://${varbucket}.s3.amazonaws.com/${varkey}","tileset": "rump-conflictalert.${tilesetName}"}' 'https://api.mapbox.com/uploads/v1/rump-conflictalert?access_token=${accessToken}'


# curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '{"url": "http://tilestream-tilesets-production.s3.amazonaws.com/24/_pending/fmibh1r84n02cji2gx2e5btkc/rump-conflictalert","tileset": "rump-conflictalert.kapai_landcover"}' 'https://api.mapbox.com/uploads/v1/rump-conflictalert?access_token=sk.eyJ1IjoicnVtcC1jb25mbGljdGFsZXJ0IiwiYSI6ImNrczRiOHZ0OTFwNjkyd3BqejhweTJmNWQifQ.RGC2GfNE-2oyfVbtT7O6uw'




# curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '{  "url": "http://tilestream-tilesets-production.s3.amazonaws.com/07/_pending/ztpyjza9tj024020sx2m5btkc/rump-conflictalert","tileset": "rump-conflictalert.kapailandcover"}' 'https://api.mapbox.com/uploads/v1/rump-conflictalert?access_token=sk.eyJ1IjoicnVtcC1jb25mbGljdGFsZXJ0IiwiYSI6ImNrczRiOHZ0OTFwNjkyd3BqejhweTJmNWQifQ.RGC2GfNE-2oyfVbtT7O6uw'


# curl "https://api.mapbox.com/uploads/v1/rump-conflictalert/cktb8i0791t9920nylxml2upi?access_token=sk.eyJ1IjoicnVtcC1jb25mbGljdGFsZXJ0IiwiYSI6ImNrczRiOHZ0OTFwNjkyd3BqejhweTJmNWQifQ.RGC2GfNE-2oyfVbtT7O6uw"
# hugo-build
A docker container to build websites with hugo and wercker.

[![wercker status](https://app.wercker.com/status/c2c36586afcb68edcf48c6851295807f/m/master "wercker status")](https://app.wercker.com/project/bykey/c2c36586afcb68edcf48c6851295807f)

## Purpose
This container is designed to be used with [wercker](http://wercker.com) to build a static web site using [hugo](http://gohugo.io).

## Alpine Linux
This container is derived from [Alpine Linux](http://www.alpinelinux.org/) and therefore does not have /bin/bash.  Since wercker uses /bin/bash for their setup steps, you must override the box cmd as shown in the sample *wercker.yml* below.

## Sample *wercker.yml*
	box: 
		id: raizyr/hugo-build
		cmd: /bin/sh
	build:
		steps:
			- script:
					name: initialize git submodules
					code: |
						git submodule update --init --recursive
			- script:
					name: build with hugo
					code: |
						hugo
	deploy:
		steps:
			- s3sync:
					source_dir: public/
					delete-removed: true
					bucket-url: $AWS_BUCKET_URL
					key-id: $AWS_ACCESS_KEY_ID
					key-secret: $AWS_SECRET_ACCESS_KEY

# hugo-deploy
A docker container to build websites with hugo and then deploy them to S3.

## Purpose
This container is designed to be used with [wercker](http://wercker.com) to build a static web site using [hugo](http://gohugo.io) and deploy it to [Amazon S3](https://aws.amazon.com/s3/) using [s3cmd](https://github.com/s3tools/s3cmd).

## Sample *wercker.yml*
	box: raizyr/hugo-deploy
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
			- script:
					name: S3 sync with s3cmd
					# This expects that you have defined $AWS_ACCESS_KEY 
					# and $AWS_SECRET_ACCESS_KEY in your wercker application.
					code: |
						s3cmd sync public/ s3://$S3_DEPLOY_BUCKET/

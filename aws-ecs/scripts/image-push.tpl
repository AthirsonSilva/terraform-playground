#!/bin/bash
$(aws ecr get-login --no-include-email --region ${region})
docker build -t ${repo_url}:latest .
docker push ${repo_url}:latest
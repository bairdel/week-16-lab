#! /usr/bin/env bash

set -eo pipefail

## Deploys the networking stack
if [[ -z "${STUDENT_NAME}" ]]; then
  echo "STUDENT_NAME is not set"
  exit 1
fi

readonly STACK_NAME="${STUDENT_NAME}-networking"
readonly TEMPLATE_FILE="$(dirname "${BASH_SOURCE[0]}")/templates/networking.yml"
readonly AWS_DEFAULT_REGION="eu-west-2"

aws cloudformation deploy \
  --stack-name "${STACK_NAME}" \
  --template-file "${TEMPLATE_FILE}" \
  --capabilities CAPABILITY_IAM \
  --no-fail-on-empty-changeset \
  --tags "Project=Poems" "Environment=Dev" "StudentName=${STUDENT_NAME}" \
  --region "${AWS_DEFAULT_REGION}" \
  --parameter-overrides "file://networking_params.json" 
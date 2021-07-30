#!/usr/bin/env sh
set -e
set -o pipefail

echo "::group::{title}"

echo "Running ESigner.com CodeSign Action ====>"
echo ""

COMMAND="cd /codesign; java -cp '.:/codesign/jar/*' com.ssl.code.signing.tool.CodeSignTool"

[ ! -z $INPUT_COMMAND ] && COMMAND="$COMMAND $INPUT_COMMAND"
[ ! -z $INPUT_USERNAME ] && COMMAND="$COMMAND -username $INPUT_USERNAME"
[ ! -z $INPUT_PASSWORD ] && COMMAND="$COMMAND -password $INPUT_PASSWORD"
[ ! -z $INPUT_CREDENTIAL_ID ] && COMMAND="${COMMAND} -credential_id ${INPUT_CREDENTIAL_ID}"
[ ! -z $INPUT_TOTP_SECRET ] && COMMAND="${COMMAND} -totp_secret ${INPUT_TOTP_SECRET}"
[ ! -z $INPUT_PROGRAM_NAME ] && COMMAND="${COMMAND} -program_name ${INPUT_PROGRAM_NAME}"
[ ! -z $INPUT_FILE_PATH ] && COMMAND="${COMMAND} -input_file_path ${INPUT_FILE_PATH}"
[ ! -z $INPUT_OUTPUT_PATH ] && COMMAND="${COMMAND} -output_dir_path ${INPUT_OUTPUT_PATH}"

RESULT=$(sh -c "set -e;  set -o pipefail; $COMMAND")

if [[ "$RESULT" =~ .*"Error".* ]]; then
  echo "::error::Something Went Wrong. Please try again."
  echo "::error::$RESULT"
  exit 1
else
  echo "::set-output name=SELECTED_COLOR::green"
  echo "$RESULT"
fi

echo "::endgroup::"
exit 0

#!/usr/bin/env sh
set -e
set -o pipefail

echo "::group::Run CodeSigner"

echo "Running ESigner.com CodeSign Action ====>"
echo ""

COMMAND="cd /codesign; java -cp"
COMMAND="${COMMAND} /codesign/jar/picocli-4.6.1.jar:/codesign/jar/bcprov-jdk15on-1.65.01.jar:/codesign/jar/httpclient-4.5.13.jar:/codesign/jar/json-simple-1.1.1.jar:/codesign/jar/jsign-core-3.1.jar:"
COMMAND="${COMMAND}/codesign/jar/commons-io-2.8.0.jar:/codesign/jar/bcpkix-jdk15on-1.65.jar:/codesign/jar/code_sign_tool-1.2.0.jar:/codesign/jar/httpcore-4.4.13.jar:/codesign/jar/commons-logging-1.2.jar:"
COMMAND="${COMMAND}/codesign/jar/log4j-api-2.13.3.jar:/codesign/jar/log4j-core-2.13.3.jar:/codesign/jar/poi-4.1.2.jar:/codesign/jar/commons-lang3-3.9.jar:/codesign/jar/commons-math3-3.6.1.jar:"
COMMAND="${COMMAND}/codesign/jar/totp-1.0.jar:/codesign/jar/commons-codec-1.15.jar"
COMMAND="${COMMAND} com.ssl.code.signing.tool.CodeSignTool"

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

#!/usr/bin/env bash
set -e

echo "::group::Run CodeSigner"

echo "Running ESigner.com CodeSign Action ====>"
echo ""

if [[ "$INPUT_ENVIRONMENT_NAME" != "PROD" ]]; then
    cp /codesign/conf/code_sign_tool.properties /codesign/conf/code_sign_tool.properties.production
    cp /codesign/conf/code_sign_tool_demo.properties /codesign/conf/code_sign_tool.properties 
fi

COMMAND="/usr/bin/codesign"

[ ! -z $INPUT_COMMAND ] && COMMAND="$COMMAND $INPUT_COMMAND"
[ ! -z $INPUT_USERNAME ] && COMMAND="$COMMAND -username $INPUT_USERNAME"
[ ! -z $INPUT_PASSWORD ] && COMMAND="$COMMAND -password $INPUT_PASSWORD"
[ ! -z $INPUT_CREDENTIAL_ID ] && COMMAND="${COMMAND} -credential_id ${INPUT_CREDENTIAL_ID}"
[ ! -z $INPUT_TOTP_SECRET ] && COMMAND="${COMMAND} -totp_secret ${INPUT_TOTP_SECRET}"
[ ! -z $INPUT_PROGRAM_NAME ] && COMMAND="${COMMAND} -program_name ${INPUT_PROGRAM_NAME}"
[ ! -z $INPUT_FILE_PATH ] && COMMAND="${COMMAND} -input_file_path ${INPUT_FILE_PATH}"
[ ! -z $INPUT_DIR_PATH ] && COMMAND="${COMMAND} -input_dir_path ${INPUT_DIR_PATH}"
[ ! -z $INPUT_OUTPUT_PATH ] && COMMAND="${COMMAND} -output_dir_path ${INPUT_OUTPUT_PATH}"
[ ! -z $INPUT_MALWARE_BLOCK ] && COMMAND="${COMMAND} -malware_block=${INPUT_MALWARE_BLOCK}"
[ ! -z $INPUT_OVERRIDE ] && COMMAND="${COMMAND} -override=${INPUT_OVERRIDE}"

RESULT=$(bash -c "set -e; $COMMAND 2>&1")

if [[ "$RESULT" =~ .*"Error".* || "$RESULT" =~ .*"Exception".* || "$RESULT" =~ .*"Missing required option".* ||
      "$RESULT" =~ .*"Unmatched arguments from".* ]]; then
  echo "::error::Something Went Wrong. Please try again."
  echo "::error::$RESULT"
  exit 1
else
  echo "SELECTED_COLOR=green" >> $GITHUB_OUTPUT
  echo "$RESULT"
fi

if [[ "$INPUT_CLEAN_LOGS" == "true" || "$INPUT_CLEAN_LOGS" == true ]]; then
    rm -rf /codesign/logs/*.log
    echo "CodeSigner logs folder is deleted: /codesign/logs"
fi

echo "::endgroup::"
exit 0

#!/usr/bin/env sh
set -e
set -o pipefail

echo "Running ESigner.com CodeSign Action ====>"
echo ""

COMMAND="java -cp '.:/codesign/jar/*' com.ssl.code.signing.tool.CodeSignTool"

[ ! -z $INPUT_COMMAND ] && COMMAND="$COMMAND $INPUT_COMMAND"
[ ! -z $INPUT_USERNAME ] && COMMAND="$COMMAND -username $INPUT_USERNAME"
[ ! -z $INPUT_PASSWORD ] && COMMAND="$COMMAND -password $INPUT_PASSWORD"
[ ! -z "$INPUT_CREDENTIAL_ID" ] && COMMAND="${COMMAND} -credential_id ${INPUT_CREDENTIAL_ID}"
[ ! -z "$INPUT_TOTP_SECRET" ] && COMMAND="${COMMAND} -totp_secret ${INPUT_TOTP_SECRET}"
[ ! -z "$INPUT_PROGRAM_NAME" ] && COMMAND="${COMMAND} -program_name ${INPUT_PROGRAM_NAME}"
[ ! -z "$INPUT_INPUT_FILE" ] && COMMAND="${COMMAND} -input_dir_path ${INPUT_INPUT_FILE}"
[ ! -z "$INPUT_OUTPUT_DIR" ] && COMMAND="${COMMAND} -output_dir_path ${INPUT_OUTPUT_DIR}"

sh -c "set -e;  set -o pipefail; $COMMAND"

echo ""

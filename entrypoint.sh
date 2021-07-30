#!/usr/bin/env sh
set -e
set -o pipefail

echo "RUNNING ACTION ====>"

echo $INPUT_COMMAND

COMMAND="java -cp '.:/codesign/jar/*' com.ssl.code.signing.tool.CodeSignTool ${INPUT_COMMAND}"
echo $COMMAND

sh -c "set -e;  set -o pipefail; $COMMAND"

#!/usr/bin/env sh
set -e
set -o pipefail

echo "Running ESigner.com CodeSign Action ====>"
echo ""

COMMAND="java -cp '.:/codesign/jar/*' com.ssl.code.signing.tool.CodeSignTool ${INPUT_COMMAND}"

sh -c "set -e;  set -o pipefail; $COMMAND"

echo ""

#!/usr/bin/env bash
set -e
set -o pipefail

echo "RUNNING ACTION ====>"

COMMAND="java -cp '.:/codesign/jar/*' com.ssl.code.signing.tool.CodeSignTool $@"
echo $COMMAND

bash -c "set -e;  set -o pipefail; $COMMAND"

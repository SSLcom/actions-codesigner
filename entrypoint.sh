#!/usr/bin/env sh
set -e
set -o pipefail

echo "RUNNING ACTION ====>"

COMMAND="java -cp '.:/codesign/jar/*' com.ssl.code.signing.tool.CodeSignTool $@"
echo $COMMAND

sh -c "set -e;  set -o pipefail; $COMMAND"

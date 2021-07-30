# actions-codesigner
GitHub Action for CodeSigner by SSL.com


docker run -it --rm -v "$(pwd)"/files:/files codesign sign -credential_id 8b072e22-7685-4771-b5c6-48e46614915f -username "esigner_demo" -password "esignerDemo#1" -input_file_path /files/minimal.msi  -output_dir_path /files/output -totp_secret RDXYgV9qju+6/7GnMf1vCbKexXVJmUVr+86Wq/8aIGg=


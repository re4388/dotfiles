#!/bin/bash
# -e  Exit immediately if a command exits with a non-zero status.
set -e

QURL=$1
QTITLE=$2


shopt -s lastpipe
grep "notion_token_wait_for_sort_db" ~/.secret | cut -d ' ' -f2 | read notion_token

generate_post_data()
{
  cat <<EOF
{
  "parent": { "type": "database_id", "database_id": "310cf079c91340ffaedf149a8ab84ff4" },
  "properties": {
    "Name": {
      "type": "title",
      "title": [{ "type": "text", "text": { "content": "$QTITLE" } }]
    },
    "URL": {
      "type": "url", 
      "url": "$QURL"
    }
   }
}
EOF
}

curl --location --request POST 'https://api.notion.com/v1/pages' \
--header 'Notion-Version: 2021-05-13' \
--header "Authorization: Bearer ${notion_token}" \
--header 'Content-Type: application/json' \
--data "$(generate_post_data)"


# --data-raw '{
#       "parent": { "type": "database_id", "database_id": "310cf079c91340ffaedf149a8ab84ff4" },
#       "properties": {
#         "Name": {
#           "type": "title",
#           "title": [{ "type": "text", "text": { "content": "'$QTITLE'" } }]
#         },
#         "URL": {
#           "type": "url", 
#           "url": "'$QURL'"
#         }
#        }
#   }'

# curl --location --request POST 'https://api.notion.com/v1/pages' \
# --header 'Notion-Version: 2021-05-13' \
# --header 'Authorization: Bearer secret_hMeSRFpPeXjIPOsSispHjNjBQuqcxtG31TFgGCqBxaE' \
# --header 'Content-Type: application/json' \
# --data-raw '{
#       "parent": { "type": "database_id", "database_id": "310cf079c91340ffaedf149a8ab84ff4" },
#       "properties": {
#       "Name": {
#         "type": "title",
#         "title": [{ "type": "text", "text": { "content": "'$QTITLE'" } }]
#       },
#       "URL": {
#             "type": "url", 
#             "url": "'$QURL'"}
#     }
#   }'

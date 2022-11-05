#!/bin/bash

echo "########### Creating table res-order-history ###########"
aws   $AWS_ENDPOINT \
      dynamodb create-table \
         --cli-input-json '
         {
           "TableName": "res-order-history",
           "KeySchema": [
             {
               "KeyType": "HASH",
               "AttributeName": "orderId"
             }
           ],
           "AttributeDefinitions": [
             {
               "AttributeName": "consumerId",
               "AttributeType": "S"
             },
             {
               "AttributeName": "creationDate",
               "AttributeType": "N"
             },
             {
               "AttributeName": "orderId",
               "AttributeType": "S"
             }
           ],
           "GlobalSecondaryIndexes": [
             {
               "IndexName": "res-order-history-by-consumer-id-and-creation-time",
               "Projection": {
                 "ProjectionType": "ALL"
               },
               "ProvisionedThroughput": {
                 "WriteCapacityUnits": 3,
                 "ReadCapacityUnits": 3
               },
               "KeySchema": [
                 {
                   "KeyType": "HASH",
                   "AttributeName": "consumerId"
                 },
                 {
                   "KeyType": "RANGE",
                   "AttributeName": "creationDate"
                 }
               ]
             }
           ],
           "ProvisionedThroughput": {
             "WriteCapacityUnits": 3,
             "ReadCapacityUnits": 3
           }
         }
         '
      # --cli-input-json=file://res-order-history.json

echo "########### Describing a table ###########"
aws   $AWS_ENDPOINT \
      dynamodb describe-table --table-name res-order-history --output table
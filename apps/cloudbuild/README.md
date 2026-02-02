# Cloudbuild

## How to run cloud build manually

First of all enable the cloud build API using the following command:

```
gcloud services enable cloudbuild.googleapis.com
```


```
gcloud builds submit --tag gcr.io/$PROJECT_ID/quickstart-image .
```
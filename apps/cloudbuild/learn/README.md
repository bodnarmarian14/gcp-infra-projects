# Cloudbuild


## 01 folder

## Set the project where the cloud build will run

```
gcloud config set project <project>
```

## Enable the API

```
gcloud services enable cloudbuild.googleapis.com
```

## How to run cloud build manually

Before to run the following command assure you are in the folder where the cloud build config is:

```
gcloud builds submit --config cloudbuild.yaml
```

Issues:
- ERROR: (gcloud.builds.submit) NOT_FOUND: Requested entity was not found.

Solve this issue by granting `Sorage Object Viewer` to the google cloud build service account.


## 02 folder



## 03 folder


## 04 folder

## 05 folder


## 06 folder
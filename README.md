
# Automl Vision Data Ingestion

Make data ingestion easy for GCP AutoML Vision


## Prerequisites

- [Docker](https://www.docker.com/community-edition) installed
- [Service account key](https://cloud.google.com/iam/docs/understanding-service-accounts)  with `AutoML Editor` and `Storage Object Admin` [roles](https://cloud.google.com/iam/docs/understanding-roles)
- Training images should be organized as below tree structure
	- `ABC` (it could be named as the topic of the trained model) is the root directory, it contains all labels named directories (`A`, `B` and `C`)
	- Under the label named directories are all training images with the corresponding label

```
ABC
├── A
│   ├── x.jpg
│   ├── y.jpg
│   └── z.jpg
├── B
│   ├── b1.jpg
│   ├── b2.jpg
│   └── b3.jpg
└── C
    ├── ca.jpg
    ├── cb.jpg
    └── cc.jpg
```


## Usage

1. Pull [`browny/automl-vision-data-ingestion`](https://hub.docker.com/r/browny/automl-vision-data-ingestion/) docker image

```
$> docker pull browny/automl-vision-data-ingestion
```

2. Under the root directory (i.e. `ABC/`), run below docker command

```
$> docker run -v `pwd`:`pwd` \
     -v <your_service_account_key_absolute_path>:/opt/key.json \
     -w `pwd` -it browny/automl-vision-data-ingestion <your_destination_directory>
```

3. Import images by assign CSV file URL as `<your_destination_directory>/index.csv`, that's it ~


If `<your_destination_directory>` is `gs://project-123-vcm/ABC` then the content of `gs://project-123-vcm/ABC/index.csv` should be like as below

```
gs://project-123-vcm/ABC/A/0.jpg,A
gs://project-123-vcm/ABC/A/1.jpg,A
gs://project-123-vcm/ABC/A/2.jpg,A
gs://project-123-vcm/ABC/B/0.jpg,B
gs://project-123-vcm/ABC/B/1.jpg,B
gs://project-123-vcm/ABC/B/2.jpg,B
gs://project-123-vcm/ABC/C/0.jpg,C
gs://project-123-vcm/ABC/C/1.jpg,C
gs://project-123-vcm/ABC/C/2.jpg,C
```


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


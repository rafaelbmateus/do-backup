# DO Backup

Create a backup of existing directory using an image docker.

To verify the connection with Digital Ocean Spaces execute:

```console
make check
```

To create a simple backup execute:

```console
make backup dir=/home/rafael/dev/me/backup/scripts
```

To run daily in a for execute:

```console
make run-daily dir=/home/rafael/dev/me/backup/scripts
```

# Quick starter

Create a Space in Digital Ocean.

Create a access key.

Create a `.env` file:

```
DO_FOLDER=my-backups
DO_SPACE=s3://rafaelbmateus
SLACK_WEBHOOK_URL=<YOUR_SLACK_WEBHOOK_URL>
ACCESS_KEY=<YOUR_ACCESS_KEY>
SECRET_KEY=<YOUR_SECRET_KEY>
```

Remeber to change `<YOUR_ACCESS_KEY>` and `<YOUR_SECRET_KEY>`

The variable `DO_FOLDER` is a any folder name to keep your backups.
Will be created if not exists.


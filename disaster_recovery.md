Initaly I thought of creating a function that would make an 
export, and then make a manual recovery if anything goes wrong, 
but I didn't manage to configure the IAM setting correctly.
So I've chosen a simpler path - point in time recovery. It makes
a snapshot every minute, so I could retrieve my lost info any time.

The first step will make an export to the bucket and second one
will restore the db from that export.
```bash
gcloud firestore export gs://my-small-bucket --snapshot-time=YOUR_DESIRED_TIMESTAMP --collection-ids="my-collection"

gcloud firestore import gs://my-small-bucket/YOUR_DESIRED_TIMESTAMP/ --database="(default)"
```
Example of YOUR_DESIRED_TIMESTAMP - 2024-06-15T18:52:00+02:00
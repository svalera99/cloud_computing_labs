to use the infrastructure change the path to gcp credentials.
then in terraform dir simply terraform apply.
Sometimes the issues with creating the firebase db might pop up, then just run terraform apply once again.

POSSIBLE ISSUES:
If you destroy the firebase db, GCP seems to have some internal delay
and thus for a while you won't be able to create one again.
If you meet error Error: Error creating Database: googleapi: Error 400: Database ID '(default)' is not available in project ''. Please retry in 145 seconds. Then redo command terraform apply after 145 seconds.
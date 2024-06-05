import base64
import functions_framework

import json
from google.cloud import storage


# Triggered from a message on a Cloud Pub/Sub topic.
@functions_framework.cloud_event
def writer_pubsub(cloud_event):
    # Print out the data from Pub/Sub, to prove that it worked
    data = json.loads(base64.b64decode(
        cloud_event.data["message"]["data"]
    ))

    msg_id = data.get("id", None)
    if msg_id is None:
      return "Msg coudn't be stored due to lacking id"
    msg_body = data.get("other_data", "")
    

    storage_client = storage.Client()
    bucket = storage_client.get_bucket("very_small_bucket")

    inx = 0
    filename = ""
    while True:
      filename = f"/msgs/{msg_id}_{inx}.txt"
      blob = bucket.blob(filename)
      if blob.exists():
        inx += 1
      else:
        break

    blob = bucket.blob(filename)
    with blob.open("w") as f:
      f.write("Body: " + msg_body + "\nid: " + str(msg_id))

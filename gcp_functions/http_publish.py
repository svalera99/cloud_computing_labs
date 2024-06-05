import json

import functions_framework
from google.cloud import pubsub

publisher = pubsub.PublisherClient()
topic_path = publisher.topic_path(
  'botattempt-1567093478511',
  'my-topic'
)

@functions_framework.http
def write_data_http(request):
    """HTTP Cloud Function.
    Args:
        request (flask.Request): The request object.
        <https://flask.palletsprojects.com/en/1.1.x/api/#incoming-request-data>
    Returns:
        The response text, or any set of values that can be turned into a
        Response object using `make_response`
        <https://flask.palletsprojects.com/en/1.1.x/api/#flask.make_response>.
    """
    try:
        event_data = request.get_json(silent=True)
        event_data_str = json.dumps(event_data)
        event_data_bytes = event_data_str.encode('utf-8')

        publisher.publish(topic_path, data=event_data_bytes)
        return "Event sucessfuly published"
    except Exception as e:
        return f"Coudn't publish the event due to {e}"

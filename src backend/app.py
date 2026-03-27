from flask import Flask, request, jsonify
from flask_cors import CORS
import requests

app = Flask(__name__)
CORS(app)

@app.route('/api/search', methods=['POST'])
def search():
    data = request.json
    orcid = data.get('orcid')
    author = data.get('author')

    publications = []

    # ORCID API
    if orcid:
        url = f"https://pub.orcid.org/v3.0/{orcid}/works"
        headers = {"Accept": "application/json"}
        res = requests.get(url, headers=headers)

        if res.status_code == 200:
            works = res.json().get("group", [])
            for work in works:
                try:
                    title = work["work-summary"][0]["title"]["title"]["value"]
                    publications.append(title)
                except:
                    pass

    # OpenAlex API
    if author:
        url = f"https://api.openalex.org/works?search={author}"
        res = requests.get(url)

        if res.status_code == 200:
            results = res.json().get("results", [])
            for item in results[:5]:
                title = item.get("title")
                if title:
                    publications.append(title)

    # Remove duplicates
    publications = list(set(publications))

    return jsonify({"publications": publications})


if __name__ == '__main__':
    app.run(debug=True)
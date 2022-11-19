from issue.models import OSMIssue
import csv
csvFile = csv.DictReader(open(r"C:/Projects/TUM/HackaTUM/issues.csv"))

for row in csvFile:
    issue = OSMIssue(lan=row["longitude"], lat=row["latitude"], osm_way_id=row["osm_way_id"], highway=row["highway"])
    issue.save()

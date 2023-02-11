import urllib.request
import re

search_keyword="hybrid+farming+techniques"
html = urllib.request.urlopen(f"https://www.youtube.com/results?search_query={search_keyword}&sp=CAM%253D") # Filter for Most popular, Relevant and latest
video_ids = re.findall(r"watch\?v=(\S{11})", html.read().decode())

videos = []

for i in range(0,5):
    temp = {
        'url' : f"https://www.youtube.com/watch?v={video_ids[i]}",
        'img1' : f'https://img.youtube.com/vi/{video_ids[i]}/0.jpg',
        'img2' : f'https://img.youtube.com/vi/{video_ids[i]}/1.jpg',
        'img3' : f'https://img.youtube.com/vi/{video_ids[i]}/2.jpg'
    }
    videos.append(temp)

print(videos)
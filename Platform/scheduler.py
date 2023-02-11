from apscheduler.schedulers.background import BackgroundScheduler
from datetime import datetime

def job():
    print("Hello")

def start():
    scheduler = BackgroundScheduler()
    scheduler.add_job(job, 'interval', seconds=3)
    scheduler.start()
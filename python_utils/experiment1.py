import sys
import matplotlib.pyplot as plt
import math
import os
from pydrive.auth import GoogleAuth
from pydrive.drive import GoogleDrive

import csv
import pandas as pd
import requests as rs
import csv
import collections
import numpy as np
import collections
from wait_timer import WaitTimer
from read_stdin import readline, print_until_first_csi_line
import datetime
import os
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

current_time = datetime.datetime.now()
hour = current_time.hour
minute = current_time.minute

print("Current time: {}:{}.".format(hour, minute))

# Set subcarrier to plot
subcarrier = 44

# Wait Timers. Change these values to increase or decrease the rate of `print_stats` and `render_plot`.
print_stats_wait_timer = WaitTimer(1.0)
render_plot_wait_timer = WaitTimer(0.2)

# Deque definition
perm_amp = collections.deque(maxlen=100)
perm_phase = collections.deque(maxlen=100)

# Variables to store CSI statistics
packet_count = 0
total_packet_counts = 0

# Create figure for plotting
plt.ion()
fig = plt.figure()
ax = fig.add_subplot(111)
fig.canvas.draw()
plt.show(block=False)


def carrier_plot(amp):
    plt.clf()
    df = np.asarray(amp, dtype=np.int32)
    # Can be changed to df[x] to plot sub-carrier x only (set color='r' also)
    plt.plot(range(100 - len(amp), 100), df[:, subcarrier], color='r')
    plt.xlabel("Time")
    plt.ylabel("Amplitude")
    plt.xlim(0, 100)
    plt.title(f"Amplitude plot of Subcarrier {subcarrier}")
    # TODO use blit instead of flush_events for more fastness
    # to flush the GUI events
    fig.canvas.flush_events()
    plt.show()


def process(res):
    # Parser
    all_data = res.split(',')
    csi_data = all_data[25].split(" ")
    csi_data[0] = csi_data[0].replace("[", "")
    csi_data[-1] = csi_data[-1].replace("]", "")
    gauth = GoogleAuth()
    gauth.LocalWebserverAuth()
    drive = GoogleDrive(gauth)
    file_id = '1p2hg42U5fQ5-T2SPjy42884_jmnO87yU'
    tadata = []
    csv_file = drive.CreateFile({'id': file_id})
    csv_file.GetContentFile('temp.csv')  # Download the file as 'temp.csv'
    with open('temp.csv', 'r') as file:
        reader = csv.reader(file)
        tadata = list(reader)
    new_data = [res]
    tadata.extend(new_data)
    with open('temp.csv', 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerows(tadata)

    csv_file.SetContentFile('temp.csv')
    csv_file.Upload()
    os.remove('temp.csv')
    csi_data.pop()
    csi_data = [int(c) for c in csi_data if c]
    with open("collected_data.csv", "a", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(all_data)
    imaginary = []
    real = []
    for i, val in enumerate(csi_data):
        if i % 2 == 0:
            imaginary.append(val)
        else:
            real.append(val)

    csi_size = len(csi_data)
    amplitudes = []
    phases = []
    if len(imaginary) > 0 and len(real) > 0:
        for j in range(int(csi_size / 2)):
            amplitude_calc = math.sqrt(imaginary[j] ** 2 + real[j] ** 2)
            phase_calc = math.atan2(imaginary[j], real[j])
            amplitudes.append(amplitude_calc)
            phases.append(phase_calc)

        perm_phase.append(phases)
        perm_amp.append(amplitudes)

print_until_first_csi_line()

while True:
    line = readline()
    if "CSI_DATA" in line:
        process(line)
        packet_count += 1
        total_packet_counts += 1

        if print_stats_wait_timer.check():
            print_stats_wait_timer.update()
            print("Packet Count:", packet_count, "per second.", "Total Count:", total_packet_counts)
            packet_count = 0

        if render_plot_wait_timer.check() and len(perm_amp) > 2:
            render_plot_wait_timer.update()
            carrier_plot(perm_amp)
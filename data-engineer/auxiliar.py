#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Help Functions
"""

from datetime import datetime
from pytz import timezone
import pytz


def dateObject(year, month_number, day_of_month, hour, minute):
    MST = timezone('US/Mountain')
    date_object = datetime(int(year),
                           int(month_number),
                           int(day_of_month),
                           int(hour),
                           int(minute),
                           0,
                           tzinfo=MST)
    return date_object


def createTimeMST(year, month_number, day_of_month, hour, minute):
    fmt = '%Y-%m-%d %H:%M'
    date_object = dateObject(year, month_number, day_of_month, hour, minute)
    str_time_mst = date_object.strftime(fmt)
    return str_time_mst


def createTimeUTC(year, month_number, day_of_month, hour, minute):
    fmt = '%Y-%m-%d %H:%M'
    utc = pytz.utc
    utc.zone
    date_object = dateObject(year, month_number, day_of_month, hour, minute)
    str_time_utc = date_object.astimezone(utc).strftime(fmt)
    return str_time_utc


def createTimestamps(data):
    months_dict = monthDictionary()
    data['month_number'] = data['month']
    data.replace({'month_number': months_dict}, inplace=True)
    data['time'] = data['quarter_hour']
    data.replace({'time': {'': '00:00'}}, inplace=True)

    # Create hour and second columns
    data['hour'] = data.apply(lambda row: row.time.split(':')[0], axis=1)
    data['minutes'] = data.apply(lambda row: row.time.split(':')[1], axis=1)

    # Create Timestamp
    data['MST'] = data.apply(lambda row: createTimeMST(row.year,
                                                       row.month_number,
                                                       row.day_of_month,
                                                       row.hour,
                                                       row.minutes), axis=1)
    data['UTC'] = data.apply(lambda row: createTimeUTC(row.year,
                                                       row.month_number,
                                                       row.day_of_month,
                                                       row.hour,
                                                       row.minutes), axis=1)

    return data


def monthDictionary():
    months = {'January': '1',
              'February': '2',
              'March': '3',
              'April': '4',
              'May': '5',
              'June': '6',
              'July': '7',
              'August': '8',
              'September': '9',
              'October': '10',
              'November': '11',
              'December': '12'
              }
    return months

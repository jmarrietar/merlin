#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Data Engineer Test
"""

from df2gspread import gspread2df as g2d
from auxiliar import createTimestamps


def sheet2BigQuery(gpath, sheet, table, project_id, col):
    """
    Parameters:
      gpath - Spread Sheet ID
      sheet - Worksheet name
      table - BQ destination Table in format dataset.table
      project_id - GCP Project
      col - List of columns 
    """

    # Read Spreadsheet to Dataframe
    data = g2d.download(gfile=gpath,
                        wks_name=sheet,
                        col_names=True)

    # Create Columns MST and UCT
    data = createTimestamps(data)

    # Select Columns
    data_result = data[col]

    # Save Dataframe to Bigquery
    data_result.to_gbq(destination_table=table,
                       project_id=project_id,
                       if_exists='replace')

    return True


def main():
    # Parameters
    GPATH = "1IXupgmWYgkCbWm9NHLRNr3XSOmha0Equd4DWiGI1Uio"
    COL = ['year', 'month', 'day_of_month', 'quarter_hour', 'campaign',
           'category', 'disposition', 'MST', 'UTC']
    TABLE = "merlin_dataset.test_data"
    PROJECT_ID = "merlin"
    SHEET_NAME = "Hoja 1"

    # Run Function
    sheet2BigQuery(GPATH, SHEET_NAME, TABLE, PROJECT_ID, COL)

if __name__ == "__main__":
    main()

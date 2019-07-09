# Created by CHEN at 25/03/2019
# Email: q.chen@student.utwente.nl

import pandas as pd

# eventFiles = ['event1024_1702.csv','event1024_1719.csv','event8080.csv']
# eventSaveFiles = ['event1024_1702_changed.csv','event1024_1719_changed.csv','event_8080_changed.csv']
# eventFiles = ['record-[2019.04.04-16.30.12]-1024.csv','record-[2019.04.04-16.47.36]-1024.csv']
# eventSaveFiles = ['record-[2019.04.04-16.30.12]-1024_changed.csv','record-[2019.04.04-16.47.36]-1024_changed.csv']
# eventFiles = ['record-[2019.04.05-16.59.51]-1024.csv','record-[2019.04.05-16.59.57]-8000.csv']
# eventSaveFiles = ['record-[2019.04.05-16.59.51]-1024_changed.csv','record-[2019.04.05-16.59.57]-8000_changed.csv']
# eventFiles = ['data/trial5/record-[2019.04.09-16.52.51]-8000.csv','data/trial5/record-[2019.04.09-16.52.54]-1024.csv','data/trial5/record-[2019.04.09-16.57.21]-8000.csv',
#               'data/trial5/record-[2019.04.09-16.57.24]-1024.csv','data/trial5/record-[2019.04.09-17.04.31]-8000.csv','data/trial5/record-[2019.04.09-17.04.33]-1024.csv',
#               'data/trial5/record-[2019.04.09-17.11.00]-8000.csv','data/trial5/record-[2019.04.09-17.11.03]-1024.csv','data/trial5/record-[2019.04.09-17.15.33]-8000.csv',
#               'data/trial5/record-[2019.04.09-17.15.36]-1024.csv','data/trial5/record-[2019.04.09-17.21.55]-8000.csv','data/trial5/record-[2019.04.09-17.21.58]-1024.csv']
# eventSaveFiles = ['data/trial5/record-[2019.04.09-16.52.51]-8000_changed.csv','data/trial5/record-[2019.04.09-16.52.54]-1024_changed.csv','data/trial5/record-[2019.04.09-16.57.21]-8000_changed.csv',
#               'data/trial5/record-[2019.04.09-16.57.24]-1024_changed.csv','data/trial5/record-[2019.04.09-17.04.31]-8000_changed.csv','data/trial5/record-[2019.04.09-17.04.33]-1024_changed.csv',
#               'data/trial5/record-[2019.04.09-17.11.00]-8000_changed.csv','data/trial5/record-[2019.04.09-17.11.03]-1024_changed.csv','data/trial5/record-[2019.04.09-17.15.33]-8000_changed.csv',
#               'data/trial5/record-[2019.04.09-17.15.36]-1024_changed.csv','data/trial5/record-[2019.04.09-17.21.55]-8000_changed.csv','data/trial5/record-[2019.04.09-17.21.58]-1024_changed.csv']
# trial 6 files
# eventFiles = ['data/trial6/record-[2019.04.10-16.30.55]-1024.csv','data/trial6/record-[2019.04.10-16.30.59]-8000.csv',
#               'data/trial6/record-[2019.04.10-16.27.03]-1024.csv','data/trial6/record-[2019.04.10-16.27.06]-8000.csv','data/trial6/record-[2019.04.10-16.23.09]-8000.csv',
#               'data/trial6/record-[2019.04.10-16.23.07]-1024.csv','data/trial6/record-[2019.04.10-16.14.21]-8000.csv','data/trial6/record-[2019.04.10-16.14.17]-1024.csv',
#               'data/trial6/record-[2019.04.10-16.06.25]-8000.csv', 'data/trial6/record-[2019.04.10-16.06.22]-1024.csv','data/trial6/record-[2019.04.10-16.05.00]-8000.csv',
#               'data/trial6/record-[2019.04.10-16.04.58]-1024.csv','data/trial6/record-[2019.04.10-16.01.52]-8000.csv','data/trial6/record-[2019.04.10-16.01.49]-1024.csv',
#               'data/trial6/record-[2019.04.10-15.56.21]-8000.csv','data/trial6/record-[2019.04.10-15.56.14]-1024.csv']
# eventSaveFiles = ['data/trial6/record-[2019.04.10-16.30.55]-1024_changed.csv','data/trial6/record-[2019.04.10-16.30.59]-8000_changed.csv',
#                   'data/trial6/record-[2019.04.10-16.27.03]-1024_changed.csv','data/trial6/record-[2019.04.10-16.27.06]-8000_changed.csv','data/trial6/record-[2019.04.10-16.23.09]-8000_changed.csv',
#               'data/trial6/record-[2019.04.10-16.23.07]-1024_changed.csv','data/trial6/record-[2019.04.10-16.14.21]-8000_changed.csv','data/trial6/record-[2019.04.10-16.14.17]-1024_changed.csv',
#               'data/trial6/record-[2019.04.10-16.06.25]-8000_changed.csv', 'data/trial6/record-[2019.04.10-16.06.22]-1024_changed.csv','data/trial6/record-[2019.04.10-16.05.00]-8000_changed.csv',
#               'data/trial6/record-[2019.04.10-16.04.58]-1024_changed.csv','data/trial6/record-[2019.04.10-16.01.52]-8000_changed.csv','data/trial6/record-[2019.04.10-16.01.49]-1024_changed.csv',
#               'data/trial6/record-[2019.04.10-15.56.21]-8000_changed.csv','data/trial6/record-[2019.04.10-15.56.14]-1024_changed.csv']
# eventFiles = ['data/trial7/record-[2019.04.12-17.37.16]-1024.csv','data/trial7/record-[2019.04.12-17.38.45]-1024.csv',
#               'data/trial7/record-[2019.04.12-17.39.36]-1024.csv','data/trial7/record-[2019.04.12-17.47.34]-1024.csv',
#               'data/trial7/record-[2019.04.12-17.58.19]-1024.csv','data/trial7/record-[2019.04.12-17.59.13]-1024.csv',
#               'data/trial7/record-[2019.04.12-18.00.07]-1024.csv','data/trial7/record-[2019.04.12-18.06.27]-1024.csv']
# eventSaveFiles = ['data/trial7/record-[2019.04.12-17.37.16]-1024_changed.csv','data/trial7/record-[2019.04.12-17.38.45]-1024_changed.csv',
#               'data/trial7/record-[2019.04.12-17.39.36]-1024_changed.csv','data/trial7/record-[2019.04.12-17.47.34]-1024_changed.csv',
#               'data/trial7/record-[2019.04.12-17.58.19]-1024_changed.csv','data/trial7/record-[2019.04.12-17.59.13]-1024_changed.csv',
#               'data/trial7/record-[2019.04.12-18.00.07]-1024_changed.csv','data/trial7/record-[2019.04.12-18.06.27]-1024_changed.csv']
# eventFiles = ['data/trial8/record-[2019.04.15-17.17.20]-1024.csv','data/trial8/record-[2019.04.15-17.21.30]-1024.csv',
#               'data/trial8/record-[2019.04.15-17.26.06]-1024.csv', 'data/trial8/record-[2019.04.15-17.31.54]-1024.csv',
#               'data/trial8/record-[2019.04.15-17.35.19]-1024.csv','data/trial8/record-[2019.04.15-17.38.56]-1024.csv']
# eventSaveFiles = ['data/trial8/record-[2019.04.15-17.17.20]-1024_changed.csv','data/trial8/record-[2019.04.15-17.21.30]-1024_changed.csv',
#               'data/trial8/record-[2019.04.15-17.26.06]-1024_changed.csv', 'data/trial8/record-[2019.04.15-17.31.54]-1024_changed.csv',
#               'data/trial8/record-[2019.04.15-17.35.19]-1024_changed.csv','data/trial8/record-[2019.04.15-17.38.56]-1024_changed.csv']
# eventFiles = ['data/trial9/record-[2019.04.17-14.26.48]-1024.csv','data/trial9/record-[2019.04.17-14.31.53]-1024.csv',
#                   'data/trial9/record-[2019.04.17-14.41.01]-1024.csv','data/trial9/record-[2019.04.17-14.48.49]-1024.csv',
#                   'data/trial9/record-[2019.04.17-14.53.27]-1024.csv']
# eventSaveFiles =['data/trial9/record-[2019.04.17-14.26.48]-1024_changed.csv','data/trial9/record-[2019.04.17-14.31.53]-1024_changed.csv',
#                   'data/trial9/record-[2019.04.17-14.41.01]-1024_changed.csv','data/trial9/record-[2019.04.17-14.48.49]-1024_changed.csv',
#                   'data/trial9/record-[2019.04.17-14.53.27]-1024_changed.csv']
eventFiles = ['data/trial11/record-[2019.04.25-13.19.38]-1024.csv','data/trial11/record-[2019.04.25-13.23.46]-1024.csv',
              'data/trial11/record-[2019.04.25-13.30.45]-1024.csv','data/trial11/record-[2019.04.25-13.34.25]-1024.csv']
eventSaveFiles = ['data/trial11/record-[2019.04.25-13.19.38]-1024_changed.csv','data/trial11/record-[2019.04.25-13.23.46]-1024_changed.csv',
                  'data/trial11/record-[2019.04.25-13.30.45]-1024_changed.csv','data/trial11/record-[2019.04.25-13.34.25]-1024_changed.csv'];
for idx, ori_file in enumerate(eventFiles):
    data = pd.read_csv(ori_file,sep='	',usecols=[1,2])
    data = data.drop_duplicates()
    print(data.head(10))
    data.to_csv(eventSaveFiles[idx],index = False, header = None)


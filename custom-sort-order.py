#!/usr/bin/env python3
import sys
import csv
args = sys.argv

order_filename = args[1]
to_sort_filename = args[2]
# Write to a file
order_lists = list()
with open(order_filename, 'r') as f:
    sorts = csv.reader(f, delimiter=',', quotechar='|')
    for line in sorts:
  #      print(line)
        order_lists.append(line)

_lists = list()
with open(to_sort_filename, 'r') as f:
    sored_file = csv.reader(f, delimiter='\n', quotechar='|')
    for line in sored_file:
 #       print(line)
        _lists.append(line)

#print(_lists)
sorted_order_lists = list()
order_lists_str_items = list()

for item in order_lists:
    order_lists_str_items.append(item[0])

for line in _lists:
    line_str = line[0]
    substring_list = order_lists_str_items[:]
    for item in order_lists:
        str_item = item[0]
        if item is not None or item is not []:
#            substring_list_exist = any(substring in line_str for substring in substring_list)
            if substring_list is not [] and str_item in substring_list:
               substring_list.remove(str_item)
 #              print(substring_list)
            substring_list_exist = any(map(line_str.__contains__, substring_list))
#            print(substring_list_exist)
            if str_item in line_str and line_str not in order_lists_str_items and not substring_list_exist:
                sorted_order_lists.append([line_str, item[1]])

# Sort data
#results = sorted(lists, key=lambda x:(int(x[2]), int(x[1])))
#results = sorted(_lists, key=))
#print(results)
#print(sorted_order_lists)
sorted_order_lists.sort(key=lambda x:int(x[1]))
for line in sorted_order_lists:
    line_str = line[0]
    print(line_str)
